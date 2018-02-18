From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sun, 18 Feb 2018 16:52:34 +0900
Subject: nvme-pci: about page_size of DMA pool
Message-ID: <2dfcc20c-a0c4-d01a-cde8-01662202cff8@gmail.com>

Hi All,

It seems that _PAGE_SIZE_ and _dev->ctrl.page_size_ might be different.
For now, nvme_setup_prp_pools() attempts to create PRP page DMA pool
with PAGE_SIZE instead of dev->ctrl.page_size.

By the way, in nvme_pci_setup_prps(), PRP lists are built by
dev->ctrl.page_size like following code.

for (;;) {
         if (i == page_size >> 3) {
                  ^^^^^^^^^
             __le64 *old_prp_list = prp_list;
             prp_list = dma_pool_alloc(pool, GFP_ATOMIC, &prp_dma);

if dev->ctrl.page_size should be used as is, I guess DMA pool should be
created in dev->ctrl.page_size (But at that time of
nvme_setup_prp_pools(), dev->ctrl.page_size may not be set properly)
somehow instead of PAGE_SIZE.

Additionally, It seems that page_shift in nvme_enable_ctrl() is now
hard-coded to 12 which means dev->ctrl.page_size will always be 4096,
though.


Q1. Should dev->prp_page_pool be created with dev->ctrl.page_size
instead of PAGE_SIZE?

Q2. Is there any special reason why page_shift in nvme_enable_ctrl()
is hard-coded to 12, not PAGE_SHIFT?

Always welcome directives and comments. :)

Sincerely,
Minwoo Im
