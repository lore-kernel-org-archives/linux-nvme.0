From: israelr@mellanox.com (Israel Rukshin)
Date: Tue, 7 Nov 2017 17:43:25 +0200
Subject: [PATCH] nvme-rdma: Use mr pool
In-Reply-To: <20171106164839.GA27494@lst.de>
References: <1509982181-6340-1-git-send-email-israelr@mellanox.com>
 <20171106164839.GA27494@lst.de>
Message-ID: <726ae6aa-57ec-4442-9dee-fd3bce818e62@mellanox.com>

On 11/6/2017 6:48 PM, Christoph Hellwig wrote:
> Do you have any performance numbers for this change?
>
> Also we shouldn't need the hack for the flush special case in
> nvme_rdma_post_send once we stop embedding the MR in struct request.

Hi Christoph,

Yes, I have some performance numbers.

Here is my results for READ/WRITE IOPs:

BS = 512B:
     32 Jobs (1 device):
         1) w/ mr pool 6.4 M / 6.2 M
         2) w/o mr pool 6.4 M / 6.2 M

     512 Jobs (8 devices at the same subsystem):
         1) w/ mr pool  8.2 M / 7.8 M
         2) w/o mr pool  8.2 M / 7.9 M

BS = 4k:
      32 Jobs (1 device):
         1) w/ mr pool  2.4 M/ 2 M
         2) w/o mr pool  2.4 M/ 2 M

     512 Jobs (8 devices at the same subsystem):
         1) w/ mr pool 2.1 M / 2.2 M
         2) w/o mr pool  2.1M / 2.1 M


You can see from the results that there is no performance degradation 
with my patch.

Regards,
Israel
