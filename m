From: narayan.ayalasomayajula@kazan-networks.com (Narayan Ayalasomayajula)
Date: Thu, 15 Dec 2016 19:13:27 +0000
Subject: Enabling RoCEv2 and connecting to IPv6 targets
Message-ID: <BY2PR08MB181560EB58B0E8DF5A944E84C09D0@BY2PR08MB1815.namprd08.prod.outlook.com>

All,

I am attempting to enable connecting to IPv6 NVMe-oF targets (not the Linux NVMe-oF target) as well as enable RoCEv2 and have a couple of questions:

1.  With regards to IPv6, I tried the following syntax in the "echo" command (executed on a Ubuntu Host running the 4.8.0-rc22 version of the kernel) and got the following error message:

	echo "traddr=fe80::0c6:11ff:fe41:0516,transport=rdma,trsvcid=4420,nqn=nqn.kazannet.0" > /dev/nvme-fabrics
	bash: echo: write error: Invalid argument

	dmesg log indicates:

	nvme_rdma: malformed IP address passed: fe80::0c6:11ff:fe41:0516

Is the support for connecting to IPv6 NVMe-oF targets not available in  the 4.8 version of the kernel?

2.  With regards to RoCEv2, I need to select/configure the appropriate GID on the Host NVMe-oF network interface but have not found a way to do so. I see the following example for IB at (https://community.mellanox.com/docs/DOC-2415):

	ib_send_bw -x 1

How do I do this for NVMe-oF?

Sorry if I am missing something very obvious - any guidance is appreciated.

Thanks,

Narayan
Kazan Networks
