From: mark_jacobson@stackvelocity.com (Mark Jacobson)
Date: Wed, 3 Feb 2016 00:50:06 +0100
Subject: NVMe and IRQ Affinity
In-Reply-To: <20160202234540.GA21046@localhost.localdomain>
References: <CACo6K_bSDJwt61mnKDpYvcXjCVA9UKGO17pythzcJ8Rnjh19sA@mail.gmail.com>
 <20160202234540.GA21046@localhost.localdomain>
Message-ID: <CACo6K_YGiH2ER4s21OzmD69LDL+ES0PO54jJ_efcSFw7pHADvQ@mail.gmail.com>

Output is below. I'm aware the distro hints are fairly invalid.
Luckily, I've had to implement PCIe endpoints (in FPGAs) in the past,
so I knew roughly where to look. Note that despite the 00,3ff003ff,
only CPU0 ever gets hit unless I force-disable that bit.

root# cat /sys/block/nvme0n1/mq/*/cpu_list
0, 1, 2, 20, 21, 22
3, 4, 23, 24
5, 6, 7, 25, 26, 27
8, 9, 28, 29
10, 11, 12, 30, 31, 32
13, 14, 33, 34
15, 16, 17, 35, 36, 37
18, 19, 38, 39
root#
root# for i in $(grep nvme0q /proc/interrupts  | cut -d":" -f1 | sed
"s/ //g"); do
>   echo "IRQ:  $i";
>   echo -n "HINT: " && cat /proc/irq/$i/affinity_hint
>   echo -n "SMP:  " && cat /proc/irq/$i/smp_affinity
> done
IRQ:  87
HINT: ff,ffffffff
SMP:  ff,ffffffff
IRQ:  88
HINT: 00,00000000
SMP:  00,3ff003ff
IRQ:  89
HINT: 00,00000000
SMP:  00,3ff003ff
IRQ:  90
HINT: 00,00000000
SMP:  00,3ff003ff
IRQ:  91
HINT: 00,00000000
SMP:  00,3ff003ff
IRQ:  92
HINT: 00,00000000
SMP:  00,3ff003ff
IRQ:  93
HINT: 00,00000000
SMP:  00,3ff003ff
IRQ:  94
HINT: 00,00000000
SMP:  00,3ff003ff
Thank you,

Mark Jacobson
Software Test Engineer
Stack Velocity


On Wed, Feb 3, 2016@12:45 AM, Keith Busch <keith.busch@intel.com> wrote:
> On Wed, Feb 03, 2016@12:31:22AM +0100, Mark Jacobson wrote:
>> and noticed that the drives I'm working with (Samsung PM953) will by
>> default only route interrupts to CPU0 despite having affinity for all
>> cores and I figured I'd ask here since that seemed like a driver
>> issue.
>
> Sounds like the affinity hints are either messed up in this distro, or
> just not being used by irqbalance. Could you run the following script
> and send the output?
>
> ---
> cat /sys/block/nvme0n1/mq/*/cpu_list
>
> for i in $(grep nvme0q /proc/interrupts  | cut -d":" -f1 | sed "s/ //g"); do
>   echo "IRQ:  $i";
>   echo -n "HINT: " && cat /proc/irq/$i/affinity_hint
>   echo -n "SMP:  " && cat /proc/irq/$i/smp_affinity
> done
