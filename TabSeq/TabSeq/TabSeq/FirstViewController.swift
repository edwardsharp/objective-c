//
//  FirstViewController.swift
//  TabSeq
//
//  Created by edward on 8/30/14.
//  Copyright (c) 2014 edwardsharp. All rights reserved.
//

import UIKit

var items = [String]()

class FirstViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        items = ["", "", "", "","", "", "", "","", "", "", "","", "", "", "","", "", "", "","", "", "", "","", "", "", "","", "", "", "","", "", "", "","", "", "", "","", "", "", "","", "", "", "","", "", "", "","", "", "", "","", "", "", "","", "", "", "","", "", "", "","", "", "", "","", "", "", "","", "", "", "","", "", "", "","", "", "", "","", "", "", "","", "", "", "","", "", "", "","", "", "", "","", "", "", "","", "", "", "","", "", "", "","", "", "", "","", "", "", ""]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // #PRAGMA MARK - collectionview delegate stuffz
    
    func collectionView(collectionView: UICollectionView!, numberOfItemsInSection section: Int) -> Int
    {
        return items.count
    }
    
    
    func collectionView(collectionView: UICollectionView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell!
    {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as ButtonCollectionViewCell
        //cell.imageView.image = UIImage(named:images[indexPath.row])
        return cell
    }
}

