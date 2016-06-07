From: swise@opengridcomputing.com (Steve Wise)
Date: Tue, 7 Jun 2016 15:14:22 -0500
Subject: NVMe over Fabrics RDMA transport drivers
In-Reply-To: <9C6B67F36DCAFC479B1CF6A967258A8C7DDCB23D@ORSMSX115.amr.corp.intel.com>
References: <1465248215-18186-1-git-send-email-hch@lst.de>
 <5756B695.5020305@grimberg.me>
 <9C6B67F36DCAFC479B1CF6A967258A8C7DDCB23D@ORSMSX115.amr.corp.intel.com>
Message-ID: <6ed161c3-d7d2-909f-6f17-7d75c36ed5b2@opengridcomputing.com>

On 6/7/2016 9:55 AM, Woodruff, Robert J wrote:
> Sagi Grimberg wrote,
>
>> We forgot to CC Linux-rdma, CC'ing...
> Are you planning on sending the patch set to the linux-rdma list for comments as well ?
> It might be good to do so if you want review from the rdma subsystem experts, as many of them do not subscribe to the other
> lists.

It would be great to make sure and CC linux-rdma on v2 of all 4 series, 
so interested folks can review and/or test out the whole enchilada.

Anyway, today I used the github tree at 
git://git.infradead.org/nvme-fabrics.git, branch nvmf-all for testing 
NVME/Fabrics over RDMA.  I used nvme-cli from 
https://github.com/linux-nvme/nvme-cli.git, and nvmetcli from 
git://git.infradead.org/users/hch/nvmetcli.git for configuring.  I ran 
some xfs, fio and iozone tests over both iw_cxgb4 and mlx4, using ram 
disks and an NVME ssd.  Checks out good so far!

Tested-by: Steve Wise <swise at opengridcomputing.com>
