From: bart.vanassche@sandisk.com (Bart Van Assche)
Date: Tue, 18 Oct 2016 13:09:39 -0700
Subject: [PATCH 0/6] Six NVMeOF-related patches
Message-ID: <e96f7b21-9686-c24f-9c64-e6fb4b44fea0@sandisk.com>

Hello Keith,

This patch series is what I came up with while I was using the NVMeOF 
host and target drivers to test my pending block layer and dm-mq 
patches. It would be appreciated if you would consider these patches for 
inclusion in the upstream kernel. The individual patches in this series are:

0001-nvme-scsi-Remove-set-but-not-used-variables.patch
0002-nvme-fabrics-Adjust-source-code-indentation.patch
0003-nvme-fabrics-Fix-memory-leaks-in-nvmf_parse_options.patch
0004-nvme-fabrics-Fix-a-memory-leak-in-an-nvmf_create_ctr.patch
0005-nvme-fabrics-Print-network-address-if-address-resolu.patch
0006-nvme-rdma-Make-nvme_rdma_conn_rejected-more-informat.patch

Thanks,

Bart.
