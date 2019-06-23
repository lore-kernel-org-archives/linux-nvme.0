From: alex@zadara.com (Alex Lyakas)
Date: Sun, 23 Jun 2019 11:13:54 +0300
Subject: [RFC] mismatch between chardev and blkdev node names
In-Reply-To: <20190611051448epcms2p4637f4b9209d0b9292e0db2b3be1dcced@epcms2p4>
References: <49a9c722-72f4-bce9-b368-ece078e1e03a@grimberg.me>
 <20190610124925.GA20319@minwooim-desktop>
 <CAOSXXT6BJD8tnus6=vWh6dr9owkVSJdQ_f1icG9Kdq7SpF9Pzg@mail.gmail.com>
 <20190610140650.GA25273@minwooim-desktop>
 <CGME20190610235716epcas4p2715a468530e87b74c60543e8077a0481@epcms2p4>
 <20190611051448epcms2p4637f4b9209d0b9292e0db2b3be1dcced@epcms2p4>
Message-ID: <C98BA6B1D6A342DAA10DA3CA561EA768@alyakaslap>

Hello,

if we look at the UDEV DEVPATH propertys of a particular nvme block device, 
for example:

DEVPATH=/devices/virtual/nvme-fabrics/ctl/nvmeX/nvmeYnZ

Would it be correct to say that "nvmeX" is the controller instance for this 
particular block device (or one of the instances)?

Thanks,
Alex.






-----Original Message----- 
From: Minwoo Im
Sent: Tuesday, June 11, 2019 8:14 AM
To: Sagi Grimberg ; Minwoo Im ; Keith Busch ; Minwoo Im
Cc: linux-nvme
Subject: Re: [RFC] mismatch between chardev and blkdev node names

> >> You just need to know this if you're accessing direct namespace
> >> handles, and the controller-namespace relationship is accurately
> >> represented in sysfs for those wanting to view it.
> >
> > Then the user should exactly know the relationship bettwen the
> > controller and namespaces via the sysfs structures.
>
> Or run:
>
> nvme list-subsys (with or without passing in a namespace device node).
>
> For example: nvme list-subsys /dev/nvme0n1 will show you exactly which
> controllers it spans and which subsystem it belongs to.

Yeah, Sagi.

I just have posted the comment to the issue in Github just like what you've
mentioned.  we can figure out the relationship for the subsystems via
"nvme list-subsys".

Thanks,

_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme 
