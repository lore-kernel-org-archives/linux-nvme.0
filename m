From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 27 Nov 2018 08:33:49 +0100
Subject: [PATCH] drivers/nvme/host/rdma.c: Fix double freeing of async
 event data
In-Reply-To: <1543252659-22757-1-git-send-email-psajeepa@purestorage.com>
References: <1543252659-22757-1-git-send-email-psajeepa@purestorage.com>
Message-ID: <20181127073349.GA25211@infradead.org>

On Mon, Nov 26, 2018@10:17:39AM -0700, Prabhath Sajeepa wrote:
> Some error paths in configuration of admin queue free data buffer
> associated with async request SQE without resetting the data buffer
> pointer to NULL, This buffer is also freed up again if the controller
> is shutdown or reset.

Can you please provide a signoff?
