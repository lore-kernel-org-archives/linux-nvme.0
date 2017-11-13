From: rajur@chelsio.com (Raju  Rangoju)
Date: Mon, 13 Nov 2017 17:17:42 +0000
Subject: kernel paging request error observed on initiator after 'nvmetcli
 clear' on target
In-Reply-To: <CY1PR12MB077466A1AA7B248815F95618BC560@CY1PR12MB0774.namprd12.prod.outlook.com>
References: <CY1PR12MB07745F65B8684865F1AB8EEABC470@CY1PR12MB0774.namprd12.prod.outlook.com>
 <CY1PR12MB0774E29B5A7C62813DD2F371BC500@CY1PR12MB0774.namprd12.prod.outlook.com>
 <188896fb-2be9-81fe-64d6-6e2c77be7a06@grimberg.me>
 <CY1PR12MB077466A1AA7B248815F95618BC560@CY1PR12MB0774.namprd12.prod.outlook.com>
Message-ID: <CY1PR12MB07742829BFFB4C80E113D58FBC2B0@CY1PR12MB0774.namprd12.prod.outlook.com>

Hi Sagi,

I have tried suggested API pci_alloc_irq_vectors (which is supposed to handle live cpu online/offline), but I could still see the issue.
Let me know if I'm missing something.

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
index 38a5c6764bb5..0f66f8ae49da 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
@@ -4200,7 +4200,8 @@ static int enable_msix(struct adapter *adap)
 #else
        need = adap->params.nports + EXTRA_VECS + ofld_need + uld_need;
 #endif
-       allocated = pci_enable_msix_range(adap->pdev, entries, need, want);
+       allocated = pci_alloc_irq_vectors(adap->pdev, need, want, PCI_IRQ_MSIX);
        if (allocated < 0) {
                dev_info(adap->pdev_dev, "not enough MSI-X vectors left,"
                         " not using MSI-X\n");
@@ -4226,10 +4227,10 @@ static int enable_msix(struct adapter *adap)
        }

        for (i = 0; i < (s->max_ethqsets + EXTRA_VECS); ++i)
-               adap->msix_info[i].vec = entries[i].vector;
+               adap->msix_info[i].vec = pci_irq_vector(adap->pdev, i);
        if (is_uld(adap)) {
                for (j = 0 ; i < allocated; ++i, j++) {
-                       adap->msix_info_ulds[j].vec = entries[i].vector;
+                       adap->msix_info_ulds[j].vec = pci_irq_vector(adap->pdev, i);
                        adap->msix_info_ulds[j].idx = i;
                }
                adap->msix_bmap_ulds.mapsize = j;
Thanks,
Raju

-----Original Message-----
From: Raju Rangoju 
Sent: 08 November 2017 15:28
To: 'Sagi Grimberg' <sagi at grimberg.me>
Cc: SWise OGC <swise at opengridcomputing.com>; Potnuri Bharat Teja <bharat at chelsio.com>
Subject: RE: kernel paging request error observed on initiator after 'nvmetcli clear' on target

Hi Sagi,

Yes, this issue is seen only when I clear the target while cpu offline is happening. It does not happen if I do not offline the cpu core.

This crash is seen while reaping the completions.
static int __ib_process_cq(struct ib_cq *cq, int budget) { ...
    if (wc->wr_cqe)
          wc->wr_cqe->done(cq, wc);
                                     ^^^^^^

Thanks,
Raju

-----Original Message-----
From: Sagi Grimberg [mailto:sagi@grimberg.me]
Sent: 06 November 2017 17:17
To: Raju Rangoju <rajur at chelsio.com>
Subject: Re: kernel paging request error observed on initiator after 'nvmetcli clear' on target

> Hello Sagi,

Hi Raju,

> Did you get a chance to look at this?

This does not happen if you don't offline cpus correct?

Can you tell to what does the crash correlates to?
This is only if you clear the target while cpu offline is happening? if you don't do them together? does it still happen?

I suspect that we are racing with the affinity break process that triggers when offlining a cpu core.

IIRC, iw_cxgb4 does not use pci_alloc_irq_vectors() api that correctly handles live cpu offline/online.
