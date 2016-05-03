From: hch@lst.de (hch@lst.de)
Date: Tue, 3 May 2016 18:05:56 +0200
Subject: [PATCH] NVMe: eliminate potential deadlock by
 nvme_get_ns_from_disk invoking nvme_free_ns
In-Reply-To: <B58D82457FDA0744A320A2FC5AC253B93D578BBE@fmsmsx104.amr.corp.intel.com>
References: <1462263954-2475-1-git-send-email-shhuiw@foxmail.com>
 <B58D82457FDA0744A320A2FC5AC253B93D578BBE@fmsmsx104.amr.corp.intel.com>
Message-ID: <20160503160556.GA32446@lst.de>

On Tue, May 03, 2016@02:04:16PM +0000, Busch, Keith wrote:
> Swapping the ns and module reference gets order would have been simpler.

That's fine with me, too.
