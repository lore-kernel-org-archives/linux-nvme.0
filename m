From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 5 Oct 2017 01:03:20 -0700
Subject: [PATCH v2 6/7] nvme_fc: move remote port get/put/free location
In-Reply-To: <20170927045046.22238-7-jsmart2021@gmail.com>
References: <20170927045046.22238-1-jsmart2021@gmail.com>
 <20170927045046.22238-7-jsmart2021@gmail.com>
Message-ID: <20171005080320.GD5063@infradead.org>

On Tue, Sep 26, 2017@09:50:45PM -0700, James Smart wrote:
> move nvme_fc_rport_get/put and rport free to higher in the file to
> avoid adding prototypes to resolve references in upcoming code additions
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>

Looks fine.

I've picked this up in nvme-4.15 as large code movements are bound
to create conflicts, so I'd rather have it earlier than later.
