From: keith.busch@intel.com (Keith Busch)
Date: Thu, 11 Jan 2018 08:48:58 -0700
Subject: [PATCH] nvme-pci: calculate iod and avg_seg_size just before use
 them
In-Reply-To: <1515647379-1877-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1515647379-1877-1-git-send-email-jianchao.w.wang@oracle.com>
Message-ID: <20180111154857.GA2602@localhost.localdomain>

On Thu, Jan 11, 2018@01:09:39PM +0800, Jianchao Wang wrote:
> The calculation of iod and avg_seg_size maybe meaningless if
> nvme_pci_use_sgls returns before uses them. So calculate
> just before use them.

The compiler will do the right thing here, but I see what you mean. I
think Christoph has some SGL improvements coming, though, that will
obviate this.
