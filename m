From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Wed, 28 Feb 2018 17:05:44 +0800
Subject: Query about RQF_DONTPREP usage in nvme driver
Message-ID: <814d7bf1-b458-4885-ab03-346dff912c82@oracle.com>

Hi Keith

Sorry for bothering you. ;)

In scsi, when requeue the request with RQF_DONTPREP, scsi core will not
do the sglist mapping or some other driver specific data's allocation and initialization.

However, in nvme_pci_complete_rq, it will invoke the nvme_unmap_data unconditionally,
and when the request enters into nvme_queue_rq again, it just reserve some members of
nvme_request and redo the whole command preparation again when RQF_DONTPREP is set.
Even all the other transport have the same actions.

Do we have any specific consideration on this ?

Thanks in advance
Jiancaho 
