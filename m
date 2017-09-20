From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 20 Sep 2017 14:32:55 -0700
Subject: [PATCH v2] nvmet_fc: ensure target queue id within range.
In-Reply-To: <20170919233356.15403-1-jsmart2021@gmail.com>
References: <20170919233356.15403-1-jsmart2021@gmail.com>
Message-ID: <20170920213255.GE10442@infradead.org>

On Tue, Sep 19, 2017@04:33:56PM -0700, James Smart wrote:
> When searching for queue id's ensure they are within the expected range
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>

Looks fine,

Reviewed-by: Christoph Hellwig <hch at lst.de>
