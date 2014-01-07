From: hdgokhale@gmail.com (Hrishikesh Gokhale)
Date: Tue, 7 Jan 2014 20:34:35 +0530
Subject: BUG_ON at nvme_setup_prp getting hit.
Message-ID: <CAEAgd7GtR6V_x-JJHSOA6DyVP2z7HUW3vNbbUa3LapLmGZsMLw@mail.gmail.com>

 Hi All,

Requesting for help in resolving the following:

Setup:
Running FIO tester tool on NVMe device driver (/block/nvme.c) with I/O
engine ?libaio?. Using Odd block size like 17K, 129K, 257K,  etc.
Distribution ?Fedora 18? (Kernel v3.6.10).

Observation:
 I?ve observed intermittent hit on BUG_ON which is pointing to
nvme_setup_prps() function in nvme.c driver.

>>> CODE
 static int nvme_setup_prps(...)

{
       int dma_len = sg_dma_len(sg);

       u64 dma_addr = sg_dma_address(sg);

       int offset = offset_in_page(dma_addr);
       ...
       dma_len -= PAGE_SIZE;
       ...
       if (dma_len > 0)
           continue;
       BUG_ON(dma_len < 0);
 }
 <<< CODE

After adding prints , I found that this problem is reproduced on use
of PRP list.

Offset value in DMA page is changed (in nvme_setup_prps() function)
from the original offset value which was present while sg_set_page()
function was executed. The offset value of virtual address is found
different than the offset value of physical/DMA address.
Query:
Is it possible to avoid the ?offset value change? in DMA-able memory
(in nvme_setup_prps() function) to avoid BUG_ON()check? ?

Thanks & Regards,
Hrishikesh
