From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 18 Mar 2019 14:43:49 -0700
Subject: =?UTF-8?Q?Re=3a_=e3=80=90Question_for_nvme-rdma_calltrace=e3=80=91?=
In-Reply-To: <20190318142418.GB23430@localhost.localdomain>
References: <0546F6C37BCE5843B1A9A6517ACC82B625C01FB5@dggema523-mbx.china.huawei.com>
 <20190318142418.GB23430@localhost.localdomain>
Message-ID: <a76f7d78-ff89-df23-629e-7a8478afe502@grimberg.me>

Hi Guys,

> Replying in plain text so the mailing list can accept it, and CC'ing Sagi.
> 
> Before looking deep into this, do you experience the same NULL dereference
> on an unmodified kernel? The below indicates you've changed something.

There was a regression in the area that was fixed lately with:
--
commit b1064d3e337b4d0b67d641b5f771187d8f1f027d
Author: Sagi Grimberg <sagi at grimberg.me>
Date:   Fri Jan 18 16:43:24 2019 -0800

     nvme-rdma: rework queue maps handling

     If the device supports less queues than provided (if the device has 
less
     completion vectors), we might hit a bug due to the fact that we ignore
     that in nvme_rdma_map_queues (we override the maps nr_queues with user
     opts).

     Instead, keep track of how many default/read/poll queues we actually
     allocated (rather than asked by the user) and use that to assign our
     queue mappings.

     Fixes: b65bb777ef22 (" nvme-rdma: support separate queue maps for 
read and write")
     Reported-by: Saleem, Shiraz <shiraz.saleem at intel.com>
     Reviewed-by: Christoph Hellwig <hch at lst.de>
     Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
     Signed-off-by: Jens Axboe <axboe at kernel.dk>
--

Is this applied in your nvme-rdma driver?

Note that its the first time I'm hearing of someone testing the huawei
device, so its not impossible that we can have an issue.

Also, how many completion vectors are available in the device under
test vs. the number of cores in the system?
