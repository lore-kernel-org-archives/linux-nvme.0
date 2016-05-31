From: keith.busch@intel.com (Keith Busch)
Date: Tue, 31 May 2016 10:35:08 -0400
Subject: [PATCHv2] NVMe: Fix removal in case of active namespace list
 scanning method
In-Reply-To: <574C19D5.1060106@samsung.com>
References: <20160527132834.GA19990@localhost.localdomain>
 <574C19D5.1060106@samsung.com>
Message-ID: <20160531143507.GA24107@localhost.localdomain>

On Mon, May 30, 2016@04:15:41PM +0530, Sunad Bhandary wrote:
> In the patch, the namespaces are not removed on failure of identify
> list. If nvme_identify_ns_list fails, the value is returned and
> sequential scanning is done. The call to nvme_remove_invalid_namespaces is
> done when the value of nsid in the list is 0.

Sorry, my mistake. You're right, it is good as-is.
