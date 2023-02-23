//
//  TableViewCell.swift
//  ToDo
//
//  Created by Nikhil Patel on 2023-02-18.
//

import UIKit

class TableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

}
