//
//  ViewController.swift
//  Setting-Abramov-Pavel-iOs-5-HW13
//
//  Created by Pavel Абрамов on 16.05.2022.
//

import UIKit

struct Section {
    let title: String
    let options: [SettingOptionType]
}

enum SettingOptionType {
    case staticCell(model: SettingOption)
    case switchCell(model: SettingsSwitchOption)
}

struct SettingsSwitchOption {
    let title: String
    let icon: UIImage?
    let iconBackgroundColor: UIColor
    let handler: (() -> Void)
    var isOn: Bool
}

struct SettingOption {
    let title: String
    let icon: UIImage?
    let iconBackgroundColor: UIColor
    let handler: (() -> Void)
    
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(SettingTableViewCell.self,
                       forCellReuseIdentifier: SettingTableViewCell.identifier)
        table.register(SwitchTableViewCell.self,
                       forCellReuseIdentifier: SwitchTableViewCell.identifier)
        return table
    }()
    
    var models = [Section]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        title = "Setting"
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
    }
    
    func configure() {
        models.append(Section(title: "", options: [
            .switchCell(model: SettingsSwitchOption(title: "Airplane Mode", icon: UIImage(systemName: "airplane.circle"), iconBackgroundColor: .red , handler: {
                        print("Airplane Mode")
                    }, isOn: true )),
            
        ]))
        
        models.append(Section(title: "General", options: [
            .staticCell(model: SettingOption(title: "Wi-Fi", icon: UIImage(systemName: "speaker.fill"), iconBackgroundColor:
                    .systemPink) {
                        print("Wi-Fi")
                    }),
            .staticCell(model: SettingOption(title: "Bluetooth", icon: UIImage(systemName: "shuffle"), iconBackgroundColor:
                    .systemBlue) {
                        print("Bluetooth")
                    }),
            .staticCell(model:SettingOption(title: "Cellular communication", icon: UIImage(systemName: "phone.connection"), iconBackgroundColor:
                    .systemPurple) {
                        print("Cellular communication")
                    })
            
        ]))
        
        models.append(Section(title: "", options: [
            .switchCell(model:SettingsSwitchOption(title: "Modem mode", icon: UIImage(systemName: "personalhotspot"), iconBackgroundColor:
                    .systemGreen, handler: {
                        print("Airplane Mode")
                    }, isOn: true )),
            
        ]))
        
        models.append(Section(title: "Information", options: [
            .staticCell(model: SettingOption(title: "Notifications", icon: UIImage(systemName: "speaker.fill"), iconBackgroundColor: .systemPink) {
                print("Notifications")
            }),
            .staticCell(model: SettingOption(title: "Sounds screen time", icon: UIImage(systemName: "bell"), iconBackgroundColor: .systemRed) {
                print("Sounds screen time")
            }),
            .staticCell(model:SettingOption(title: "Focusing", icon: UIImage(systemName: "bolt"), iconBackgroundColor: .systemPurple) {
                
            }),
            .staticCell(model:SettingOption(title: "Screen time", icon: UIImage(systemName: "timer"), iconBackgroundColor: .systemPurple) {
                
            })
        ]))
        
        models.append(Section(title: "Basic", options: [
            .staticCell(model: SettingOption(title: "Basic", icon: UIImage(systemName: "brain"), iconBackgroundColor: .systemGray) {
                print("Basic")
            }),
            .staticCell(model: SettingOption(title: "Control point", icon: UIImage(systemName: "control"), iconBackgroundColor: .systemGray) {
                print("Control point")
            }),
            .staticCell(model:SettingOption(title: "Screen and brightness", icon: UIImage(systemName: "bell"), iconBackgroundColor: .systemBlue) {
                
            }),
            .staticCell(model:SettingOption(title: "Wallpaper", icon: UIImage(systemName: "square.and.arrow.down"), iconBackgroundColor: .systemPurple) {
                
            })
        ]))
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int ) -> String?  {
        let section = models[section]
        return section.title
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section].options[indexPath.row]
        
        switch model.self {
        case .staticCell(let model):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SettingTableViewCell.identifier,
                for: indexPath
            ) as? SettingTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: model)
            return cell
        case .switchCell(let model):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SwitchTableViewCell.identifier,
                for: indexPath
            ) as? SwitchTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: model)
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let type = models[indexPath.section].options[indexPath.row]
        switch type.self {
        case .staticCell(let model):
            model.handler()
        case .switchCell(let model):
            model.handler()
            
        }
    }
}


