//
//  AboutViewController.swift
//  Canada
//
//  Created by user on 16/02/24.
//

import UIKit
import Combine
import Network

 

//class NetworkMonitor: UIViewController {
//    static let shared = NetworkMonitor()
//
//    let monitor = NWPathMonitor()
//    
//    private var status: NWPath.Status = .requiresConnection
//    var isReachable: Bool { status == .satisfied }
//    var isReachableOnCellular: Bool = true
//
//    func startMonitoring() {
//        monitor.pathUpdateHandler = { [weak self] path in
//            self?.status = path.status
//            self?.isReachableOnCellular = path.isExpensive
//
//            if path.status == .satisfied {
//                print("We're connected!")
//           
//                // post connected notification
//            } else {
//                print("No connection.")
//                // post disconnected notification
//                self?.showAlert(title: kAlertTitle, message: "No network Connection")
//            }
//            print(path.isExpensive)
//        }
//
//        let queue = DispatchQueue(label: "NetworkMonitor")
//        monitor.start(queue: queue)
//    }
//
//    func stopMonitoring() {
//        monitor.cancel()
//    }
//}


 

class AboutViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var tableview: UITableView!
    
    //MARK: - Variables
    private var aboutViewModel: AboutViewModel!
 
    
    //MARK: - Viewdidload
    override func viewDidLoad() {
        super.viewDidLoad()

        setupview()
        getListOfData()
    }
    
    //MARK: - Setupview
    private func setupview() {
        NotificationCenter.default.addObserver(self, selector: #selector(showOfflineDeviceUI(notification:)), name: NSNotification.Name.connectivityStatus, object: nil)
        aboutViewModel = AboutViewModel(serviceProtocol: HttpUtility())
        setuptableView()
    }
    //MARK: - SetuptableView
    private func setuptableView() {
        tableview.rowHeight = UITableView.automaticDimension
        tableview.estimatedRowHeight = 300
    }
    //MARK: - ShowOfflineDeviceUI
    @objc func showOfflineDeviceUI(notification: Notification) {
        if NetworkMonitor.shared.isConnected {
            getListOfData()
        } else {
            self.showAlert(title: kAlertTitle, message: "No internet connectivity")
        }
    }

    
    //MARK: - GetListOfData
    func getListOfData() {
        aboutViewModel.getData { [weak self] success, data, error in
            guard let self = self else { return }
            if success {
                self.tableview.reloadData()
            }
        }
    }
}

extension AboutViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aboutViewModel?.getAboutList().count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdentifier, for: indexPath) as? AboutTableViewCell  else { return UITableViewCell()}
        
        let model = aboutViewModel?.getAboutList()[indexPath.row]
        cell.titleLabel.text = model?.title
        cell.descriptionsLabel.text = model?.description
        guard let imageUrl = model?.imageHref else { return cell }
        cell.imageview.setImageFromUrl(ImageURL: imageUrl)
        
        
        return cell
    }
}
