From: hch@lst.de (Christoph Hellwig)
Date: Tue, 12 Feb 2019 09:00:03 +0100
Subject: [PATCH] nvme-pci: Add missing unlock for reset error
In-Reply-To: <20190211162350.4662-1-keith.busch@intel.com>
References: <20190211162350.4662-1-keith.busch@intel.com>
Message-ID: <20190212080003.GH16301@lst.de>

On Mon, Feb 11, 2019@09:23:50AM -0700, Keith Busch wrote:
> The reset work holds a mutex to prevent races with removal modifying the
> same resources, but was unlocking only on success. Unlock on failure
> too.
> 
> Fixes: 5c959d73dba64 ("nvme-pci: fix rapid add remove sequence")
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
> My mistake. :(

Looks sensible to me.  Unless I hear complaints I'll merge it later
today.
