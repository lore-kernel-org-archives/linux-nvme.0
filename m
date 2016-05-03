From: hch@lst.de (hch)
Date: Tue, 3 May 2016 09:52:27 +0200
Subject: May nvme_get_ns_from_disk introduce deadlock?
In-Reply-To: <tencent_0E8E6EA15D543CDF17012F42@qq.com>
References: <tencent_0E8E6EA15D543CDF17012F42@qq.com>
Message-ID: <20160503075227.GA18064@lst.de>

On Tue, May 03, 2016@02:33:32PM +0800, Wang Sheng-Hui wrote:
> Hi,
> 
> I'm reading the code, and found that nvme_get_ns_from_disk *may* 
> introduce deadlock by invoking nvme_free_ns in core.c (nested
> spin_lock(&dev_list_lock) ). 
> But I can't figure out which condition can lead to deadlock.
> 
> Will someone help to explain the code that how can it escape from deadlock?

Just move the put outside the spinlock..  Can you send a patch?
