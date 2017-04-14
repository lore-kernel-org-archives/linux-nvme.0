From: alex.nlnnfn@gmail.com (alexnln)
Date: Fri, 14 Apr 2017 13:54:51 +0300
Subject: offest calculation from the dma_address
Message-ID: <20170414135451.515c3a53134384c388071989@gmail.com>

Hello,

In pci.c, in nvme_setup_prps() offset is calculated from the dma address:
int offset = dma_addr & (page_size - 1);

Why not to use sg->offset?

I mean, what if hypothetical dma allocator returns non-page aligned addresses?
In such case offset would be wrong.

Thanks,
Alex
