From: kenneth.heitke@intel.com (Heitke, Kenneth)
Date: Tue, 23 Apr 2019 11:55:03 -0600
Subject: Controller memory buffer - P2PDMA question
Message-ID: <5979444b-1fbf-3471-ceb0-d90c705c40d7@intel.com>

For the controller memory buffer, the read-data (RDS) and write-data 
(WDS) support isn't required to symmetrical since there are individual 
bits for each. The code below requires that both be supported before the 
P2P memory will be published

nvme_map_cmb:nvme/host/pci.c

         if ((dev->cmbsz & (NVME_CMBSZ_WDS | NVME_CMBSZ_RDS)) ==
                         (NVME_CMBSZ_WDS | NVME_CMBSZ_RDS))
                 pci_p2pmem_publish(pdev, true);

Would it make sense for P2PDMA to support the idea of directionality? 
Should a device be able to publish its controller memory buffer just for 
TO_DEVICE and/or FROM_DEVICE?
