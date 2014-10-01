From: Indranil.Bhattacharya@netapp.com (Bhattacharya, Indranil)
Date: Wed, 1 Oct 2014 06:41:29 +0000
Subject: 4K writes on nvme device vs that on ext4 running on nvme block device
Message-ID: <eedf708ac5b545a2b26ee81b60dd49d3@hioexcmbx06-prd.hq.netapp.com>

Hi,

I was recently doing some experiments using the nvme emulator (nvmeqemu) and I observed a curious thing. There was a marked degradation in write-throughput when I run FIO (multithreaded, O_DIRECT writes) on an ext4 filesystem that has been created on top of a nvme block device; as compared to the same tests which run directly on the nvme block device (i.e. without the filesystem in between).

I plan to repeat this test on a real nvme device as soon as I get one, but some insight from others on the following questions will be helpful:

	1) Have others seen the same on a real nvme device?
	2) If yes, any possible explanation for the same?

Thanks,
Indranil ???
