From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 23 Jan 2017 23:47:56 -0800
Subject: crash in sg_alloc_table_chained
In-Reply-To: <8C8F83F9-BDBB-4B59-BA4E-BAA34CB2E20D@cavium.com>
References: <8C8F83F9-BDBB-4B59-BA4E-BAA34CB2E20D@cavium.com>
Message-ID: <20170124074756.GB27932@infradead.org>

Hi Darren,

you probably want this patch that I sent last week:

   "Subject: [PATCH] nvme-fc: use blk_rq_nr_phys_segments"
