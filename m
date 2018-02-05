From: Jeff.Lien@wdc.com (Jeffrey Lien)
Date: Mon, 5 Feb 2018 19:00:58 +0000
Subject: [PATCH] NVMe-CLI Fix command failures in regress script
In-Reply-To: <20180205165704.GA31110@localhost.localdomain>
References: <20180202195021.8560-1-jeff.lien@wdc.com>
 <20180202202930.GK24417@localhost.localdomain>
 <MWHPR04MB102561D215C063C6967513F4EAF90@MWHPR04MB1025.namprd04.prod.outlook.com>
 <20180202213829.GL24417@localhost.localdomain>
 <MWHPR04MB1025A39C17C55A89D61A6E58EAFE0@MWHPR04MB1025.namprd04.prod.outlook.com>
 <20180205165704.GA31110@localhost.localdomain>
Message-ID: <MWHPR04MB1025C0DF9D330E1B0DC5CFBEEAFE0@MWHPR04MB1025.namprd04.prod.outlook.com>

Ok, that makes sense.  I should have thought to try that; sorry for the trouble.   

I did find 2 other problems/failures when using the block device though:
1)  The flush command has a default namespace id of All ID's (0xffffffff) which causes it to fail.  So to fix that either:
    * The default ns id has to change for the flush command or 
    * The "-n 1" parm needs to be added to the flush command in the regress script 
2) The --block-count=0 setting in the read/write commands fails when the nvme drive is formatted with a lba data size of 512 bytes.  Setting it to 8 seems to work for both  512 and 4k bytes lba data size.  
    
I can recreate the patch with these fixes, just not sure which option to take with the flush command. 

Jeff Lien

-----Original Message-----
From: Keith Busch [mailto:keith.busch@intel.com] 
Sent: Monday, February 5, 2018 10:57 AM
To: Jeffrey Lien
Cc: linux-nvme at lists.infradead.org; David Darrington
Subject: Re: [PATCH] NVMe-CLI Fix command failures in regress script

On Mon, Feb 05, 2018@04:49:11PM +0000, Jeffrey Lien wrote:
> Keith,
> That doesn't seem to happen with our nvme device.  Below is what I get when I run the regress script as is.  Am I missing something on the invocation?
> 
> ./regress -d /dev/nvme0 -l -w
                    ^^^^^

That's a character device. You need to use a block device, like /dev/nvme0n1.
