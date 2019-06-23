From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sun, 23 Jun 2019 20:54:25 +0900
Subject: [RFC] mismatch between chardev and blkdev node names
In-Reply-To: <C98BA6B1D6A342DAA10DA3CA561EA768@alyakaslap>
References: <49a9c722-72f4-bce9-b368-ece078e1e03a@grimberg.me>
 <20190610124925.GA20319@minwooim-desktop>
 <CAOSXXT6BJD8tnus6=vWh6dr9owkVSJdQ_f1icG9Kdq7SpF9Pzg@mail.gmail.com>
 <20190610140650.GA25273@minwooim-desktop>
 <CGME20190610235716epcas4p2715a468530e87b74c60543e8077a0481@epcms2p4>
 <20190611051448epcms2p4637f4b9209d0b9292e0db2b3be1dcced@epcms2p4>
 <C98BA6B1D6A342DAA10DA3CA561EA768@alyakaslap>
Message-ID: <20190623115425.GB26212@minwooim-desktop>

On 19-06-23 11:13:54, Alex Lyakas wrote:
> Hello,
> 
> if we look at the UDEV DEVPATH propertys of a particular nvme block device,
> for example:
> 
> DEVPATH=/devices/virtual/nvme-fabrics/ctl/nvmeX/nvmeYnZ
> 
> Would it be correct to say that "nvmeX" is the controller instance for this
> particular block device (or one of the instances)?

Yes, for the above path, The corresponding blkdev of the nvmeX subsystem
is nvmeYnZ.  We just need to be aware if the MULTIPATH is enabled or
not.  If so, the X will be a subsystem instance which can be checked by
nvme list-subsys.  If not, the X is the controller instance name.

Thanks,
