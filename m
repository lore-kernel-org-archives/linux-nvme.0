From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 10 Jun 2019 16:56:59 -0700
Subject: [RFC] mismatch between chardev and blkdev node names
In-Reply-To: <20190610140650.GA25273@minwooim-desktop>
References: <20190610124925.GA20319@minwooim-desktop>
 <CAOSXXT6BJD8tnus6=vWh6dr9owkVSJdQ_f1icG9Kdq7SpF9Pzg@mail.gmail.com>
 <20190610140650.GA25273@minwooim-desktop>
Message-ID: <49a9c722-72f4-bce9-b368-ece078e1e03a@grimberg.me>


>> You just need to know this if you're accessing direct namespace
>> handles, and the controller-namespace relationship is accurately
>> represented in sysfs for those wanting to view it.
> 
> Then the user should exactly know the relationship bettwen the
> controller and namespaces via the sysfs structures.

Or run:

nvme list-subsys (with or without passing in a namespace device node).

For example: nvme list-subsys /dev/nvme0n1 will show you exactly which
controllers it spans and which subsystem it belongs to.
