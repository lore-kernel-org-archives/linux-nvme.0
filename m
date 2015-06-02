From: keith.busch@intel.com (Keith Busch)
Date: Tue, 2 Jun 2015 03:30:36 +0000 (UTC)
Subject: NVMe scalability issue
In-Reply-To: <CAF1ivSZCiWjrJQWckr2cTrfHEjS99ULz0HH94XP+wW3L3Jwttg@mail.gmail.com>
References: <1433199171.7699.22.camel@ssi>
 <alpine.LNX.2.00.1506012254500.15930@localhost.lm.intel.com>
 <CAF1ivSZCiWjrJQWckr2cTrfHEjS99ULz0HH94XP+wW3L3Jwttg@mail.gmail.com>
Message-ID: <alpine.LNX.2.00.1506020325260.15930@localhost.lm.intel.com>

On Mon, 1 Jun 2015, Ming Lin wrote:
> On Mon, Jun 1, 2015@4:02 PM, Keith Busch <keith.busch@intel.com> wrote:
>> There was a demo at SC'14 with a heck of a lot more NVMe drives than that,
>> and performance scaled quite linearly. Are your devices sharing PCI-e lanes?
>
> Is there a way to check it via, for example, /sys?

   # lspci -tv

>> You could try setting "cpus_allowed" on each job to the CPU's on the
>> socket local to the nvme device. That should get a measurable improvement,
>> and if your irq's are appropriately affinitized.
>
> How to know which socket is local to which nvme device?

   # cat /sys/class/nvme/nvme<#>/device/numa_node
