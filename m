From: hch@lst.de (Christoph Hellwig)
Date: Tue, 7 Jun 2016 19:31:05 +0200
Subject: NVMe over Fabrics target implementation
In-Reply-To: <6abd6fd0-3a75-8569-95a4-174d856d0043@sandisk.com>
References: <1465248177-17970-1-git-send-email-hch@lst.de>
 <6abd6fd0-3a75-8569-95a4-174d856d0043@sandisk.com>
Message-ID: <20160607173105.GA13935@lst.de>

Hi Bart,

> As you know with configfs it is not allowed to create directories in the 
> configfs hierarchy from inside the kernel.

Of course you can, and every user of configfs relies on being able
to create directories from the kernel using either the default_groups
list, or through the use of configfs_register_group().
