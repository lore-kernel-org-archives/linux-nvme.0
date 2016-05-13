From: keith.busch@intel.com (Keith Busch)
Date: Fri, 13 May 2016 17:03:03 -0400
Subject: Hang Condition in nvme_ns_remove
In-Reply-To: <BL2PR04MB163363775AA16EECA5666CE92740@BL2PR04MB163.namprd04.prod.outlook.com>
References: <BL2PR04MB163363775AA16EECA5666CE92740@BL2PR04MB163.namprd04.prod.outlook.com>
Message-ID: <20160513210302.GA14531@localhost.localdomain>

On Fri, May 13, 2016@08:52:15PM +0000, Jeff Lien wrote:
> I encountered another hang condition in the nvme_ns_remove function.  It's caused when nvme_ns_remove is called by nvme_scan_namespaces/__nvme_scan_namespaces.  In nvme_scan_namespaces, the namespaces_mutex is locked; nvme_ns_remove will also try to get that mutex right before the call to list_del_init.  When that handles it hangs there.   
> 
> It could be fixed by removing the mutex_lock call in nvme_ns_remove and then changing the code so that all other callers of ns_remove get the lock instead.  Since I'm not real familiar with this part of the code, I don't know if this is the best fix or not.   Asking for your input on that.   

Should be fixed if you pick up this commit (and any dependencies):

  https://git.kernel.org/cgit/linux/kernel/git/axboe/linux-block.git/commit?id=b7b9c2278752e37dc7ae918cda823aa2a078e03b
