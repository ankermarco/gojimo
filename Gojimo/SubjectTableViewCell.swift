//
//  SubjectTableViewCell.swift
//  Gojimo
//
//  Created by Ke Ma on 02/05/2016.
//  Copyright © 2016 Ke. All rights reserved.
//

import UIKit

class SubjectTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var idField: UITextField!
    @IBOutlet weak var linkField: UITextField!
    var cellCell: String?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
