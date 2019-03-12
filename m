From: kwolf@redhat.com (Kevin Wolf)
Date: Tue, 12 Mar 2019 16:05:17 +0100
Subject: [PATCH] nvme: fix write zeroes offset and count
In-Reply-To: <20190311151153.10516-1-keith.busch@intel.com>
References: <20190311151153.10516-1-keith.busch@intel.com>
Message-ID: <20190312150517.GH4791@linux.fritz.box>

Am 11.03.2019 um 16:11 hat Keith Busch geschrieben:
> The implementation used blocks units rather than the expected bytes.
> 
> Fixes: c03e7ef12a9 ("nvme: Implement Write Zeroes")
> Reported-by: Ming Lei <ming.lei at redhat.com>
> Signed-off-by: Keith Busch <keith.busch at intel.com>

Thanks, applied to the block branch.

Kevin
