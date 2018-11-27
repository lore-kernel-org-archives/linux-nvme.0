From: hch@lst.de (Christoph Hellwig)
Date: Tue, 27 Nov 2018 08:42:35 +0100
Subject: [PATCH] drivers/nvme/host/rdma.c: Fix double freeing of async
 event data
In-Reply-To: <670099a6-8541-9cbf-6e4f-93690c42c6d3@grimberg.me>
References: <1543252659-22757-1-git-send-email-psajeepa@purestorage.com>
 <670099a6-8541-9cbf-6e4f-93690c42c6d3@grimberg.me>
Message-ID: <20181127074235.GA30186@lst.de>

On Mon, Nov 26, 2018@11:41:09PM -0800, Sagi Grimberg wrote:
> Can you fix the change log title to "nvme-rdma: ..." please?

And that as well, yes.  Although I usually fix those bits up when
applying instead of maxing a fuzz :)
