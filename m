From: keith.busch@intel.com (Keith Busch)
Date: Mon, 5 Feb 2018 12:34:16 -0700
Subject: [PATCH] NVMe-CLI Fix command failures in regress script
In-Reply-To: <MWHPR04MB1025C0DF9D330E1B0DC5CFBEEAFE0@MWHPR04MB1025.namprd04.prod.outlook.com>
References: <20180202195021.8560-1-jeff.lien@wdc.com>
 <20180202202930.GK24417@localhost.localdomain>
 <MWHPR04MB102561D215C063C6967513F4EAF90@MWHPR04MB1025.namprd04.prod.outlook.com>
 <20180202213829.GL24417@localhost.localdomain>
 <MWHPR04MB1025A39C17C55A89D61A6E58EAFE0@MWHPR04MB1025.namprd04.prod.outlook.com>
 <20180205165704.GA31110@localhost.localdomain>
 <MWHPR04MB1025C0DF9D330E1B0DC5CFBEEAFE0@MWHPR04MB1025.namprd04.prod.outlook.com>
Message-ID: <20180205193416.GC31110@localhost.localdomain>

On Mon, Feb 05, 2018@07:00:58PM +0000, Jeffrey Lien wrote:
> Ok, that makes sense.  I should have thought to try that; sorry for the trouble.   
> 
> I did find 2 other problems/failures when using the block device though:
> 1)  The flush command has a default namespace id of All ID's (0xffffffff) which causes it to fail.  So to fix that either:
>     * The default ns id has to change for the flush command or 
>     * The "-n 1" parm needs to be added to the flush command in the regress script 

I will change nvme-cli to use the block handle NSID no problem, but
isn't Flush the only IO command that is required to support the
broadcast NSID? I know the wording was a bit vague on using this value
and there was discussion on the technical reflector about it, but I
haven't had time to read into where they're going with it.

> 2) The --block-count=0 setting in the read/write commands fails when the nvme drive is formatted with a lba data size of 512 bytes.  Setting it to 8 seems to work for both  512 and 4k bytes lba data size.  

Oops, the regress script has hard-coded an expected 4k LBA format. We need
it to discover and be re-active to the format instead.
