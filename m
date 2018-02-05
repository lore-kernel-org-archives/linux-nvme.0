From: keith.busch@intel.com (Keith Busch)
Date: Mon, 5 Feb 2018 09:57:04 -0700
Subject: [PATCH] NVMe-CLI Fix command failures in regress script
In-Reply-To: <MWHPR04MB1025A39C17C55A89D61A6E58EAFE0@MWHPR04MB1025.namprd04.prod.outlook.com>
References: <20180202195021.8560-1-jeff.lien@wdc.com>
 <20180202202930.GK24417@localhost.localdomain>
 <MWHPR04MB102561D215C063C6967513F4EAF90@MWHPR04MB1025.namprd04.prod.outlook.com>
 <20180202213829.GL24417@localhost.localdomain>
 <MWHPR04MB1025A39C17C55A89D61A6E58EAFE0@MWHPR04MB1025.namprd04.prod.outlook.com>
Message-ID: <20180205165704.GA31110@localhost.localdomain>

On Mon, Feb 05, 2018@04:49:11PM +0000, Jeffrey Lien wrote:
> Keith,
> That doesn't seem to happen with our nvme device.  Below is what I get when I run the regress script as is.  Am I missing something on the invocation?
> 
> ./regress -d /dev/nvme0 -l -w
                    ^^^^^

That's a character device. You need to use a block device, like
/dev/nvme0n1.
