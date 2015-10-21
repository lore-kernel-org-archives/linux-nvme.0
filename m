From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Wed, 21 Oct 2015 17:40:42 +0300
Subject: [PATCH 06/18] nvme: split a new struct nvme_ctrl out of struct
 nvme_dev
In-Reply-To: <20151020113041.GA31462@lst.de>
References: <1444975128-8768-1-git-send-email-hch@lst.de>
 <1444975128-8768-7-git-send-email-hch@lst.de>
 <56261541.9030702@dev.mellanox.co.il> <20151020102617.GA29824@lst.de>
 <56261AF1.2040408@dev.mellanox.co.il> <20151020113041.GA31462@lst.de>
Message-ID: <5627A3EA.7070305@dev.mellanox.co.il>

On 10/20/2015 2:30 PM, Christoph Hellwig wrote:
> On Tue, Oct 20, 2015@01:44:01PM +0300, Sagi Grimberg wrote:
>> I wasn't suggesting moving it to nvme_ctrl, I was suggesting to keep it
>> in nvme_dev and maybe add a helper have nvme_ctrl_to_dev(ctrl)->dev used
>> in slow paths. It would allow to remove the copy pointer in nvme_ctrl.
>
> But it would require adding a function pointer to get the location from
> the different transport drivers.  A pointer seems much simpler than that.
>

Yea, I'm fine with that...

Reviewed-by: Sagi Grimberg <sagig at mellanox.com>
