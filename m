From: keith.busch@intel.com (Keith Busch)
Date: Mon, 1 Jun 2015 23:02:25 +0000 (UTC)
Subject: NVMe scalability issue
In-Reply-To: <1433199171.7699.22.camel@ssi>
References: <1433199171.7699.22.camel@ssi>
Message-ID: <alpine.LNX.2.00.1506012254500.15930@localhost.lm.intel.com>

On Mon, 1 Jun 2015, Ming Lin wrote:
> Hi list,
>
> I'm playing with 8 high performance NVMe devices on a 4 sockets server.
> Each device can get 730K 4k read IOPS.
>
> Kernel: 4.1-rc3
> fio test shows it doesn't scale well with 4 or more devices.
> I wonder any possible direction to improve it.

There was a demo at SC'14 with a heck of a lot more NVMe drives than that,
and performance scaled quite linearly. Are your devices sharing PCI-e lanes?

You could try setting "cpus_allowed" on each job to the CPU's on the
socket local to the nvme device. That should get a measurable improvement,
and if your irq's are appropriately affinitized.
