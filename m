From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 1 Nov 2017 08:43:37 -0700
Subject: [PATCH] nvme: freeze IO accesses around format
In-Reply-To: <6951d74c-e765-1b5d-6e39-d88d261bf9b9@kernel.dk>
References: <6951d74c-e765-1b5d-6e39-d88d261bf9b9@kernel.dk>
Message-ID: <20171101154337.GB25317@infradead.org>

On Fri, Oct 27, 2017@10:35:58AM -0600, Jens Axboe wrote:
> Prevents this by freezing IO access to the device around a format.
> Without this, the following set of commands can easily make your device
> disappear:
> 
> parted -s /dev/nvme3n1 mklabel gpt
> parted -s /dev/nvme3n1 mkpart primary 0G 100G
> parted -s /dev/nvme3n1 rm 1
> nvme format /dev/nvme3

Can you wire this test case up for blktests?
