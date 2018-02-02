From: keith.busch@intel.com (Keith Busch)
Date: Fri, 2 Feb 2018 14:38:29 -0700
Subject: [PATCH] NVMe-CLI Fix command failures in regress script
In-Reply-To: <MWHPR04MB102561D215C063C6967513F4EAF90@MWHPR04MB1025.namprd04.prod.outlook.com>
References: <20180202195021.8560-1-jeff.lien@wdc.com>
 <20180202202930.GK24417@localhost.localdomain>
 <MWHPR04MB102561D215C063C6967513F4EAF90@MWHPR04MB1025.namprd04.prod.outlook.com>
Message-ID: <20180202213829.GL24417@localhost.localdomain>

On Fri, Feb 02, 2018@09:33:12PM +0000, Jeffrey Lien wrote:
> Keith, 
> Then should we remove the commands that require a namespace id (ie id-ns, flush, write, and read)?  

If you provide a block device, nvme-cli will automatically figure out
the nsid if you didn't provide one.
