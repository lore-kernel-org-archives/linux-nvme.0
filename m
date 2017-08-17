From: axboe@kernel.dk (Jens Axboe)
Date: Thu, 17 Aug 2017 14:47:30 -0600
Subject: [PATCH] nvme/pci: Set cqe_seen on polled completions
In-Reply-To: <1503002706-32394-1-git-send-email-keith.busch@intel.com>
References: <1503002706-32394-1-git-send-email-keith.busch@intel.com>
Message-ID: <5e13a757-66d0-dadd-f926-c3d2e1d0cc6c@kernel.dk>

On 08/17/2017 02:45 PM, Keith Busch wrote:
> Fixes: 920d13a884 ("nvme-pci: factor out the cqe reading mechanics from __nvme_process_cq")
> 
> Reported-by: Jens Axboe <axboe at kernel.dk>
> Signed-off-by: Keith Busch <keith.busch at intel.com>

Tested-by: Jens Axboe <axboe at kenel.dk>

-- 
Jens Axboe
