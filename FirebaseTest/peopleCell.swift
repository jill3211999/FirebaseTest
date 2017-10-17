//
//  peopleCell.swift
//  FirebaseTest
//
//  Created by Jill on 2017/10/16.
//  Copyright © 2017年 Jill. All rights reserved.
//

import UIKit

class peopleCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    var clickClosure: (()->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func deletePeople(_ sender: Any) {
        if (clickClosure != nil) {
            clickClosure!()
        }
    }
    
    func touchUpInside(_ triggerBlock: @escaping () -> ()){
        clickClosure = triggerBlock
    }
    
}
