From: keith.busch@intel.com (Keith Busch)
Date: Tue, 2 Feb 2016 23:45:40 +0000
Subject: NVMe and IRQ Affinity
In-Reply-To: <CACo6K_bSDJwt61mnKDpYvcXjCVA9UKGO17pythzcJ8Rnjh19sA@mail.gmail.com>
References: <CACo6K_bSDJwt61mnKDpYvcXjCVA9UKGO17pythzcJ8Rnjh19sA@mail.gmail.com>
Message-ID: <20160202234540.GA21046@localhost.localdomain>

On Wed, Feb 03, 2016@12:31:22AM +0100, Mark Jacobson wrote:
> and noticed that the drives I'm working with (Samsung PM953) will by
> default only route interrupts to CPU0 despite having affinity for all
> cores and I figured I'd ask here since that seemed like a driver
> issue.

Sounds like the affinity hints are either messed up in this distro, or
just not being used by irqbalance. Could you run the following script
and send the output?

---
cat /sys/block/nvme0n1/mq/*/cpu_list

for i in $(grep nvme0q /proc/interrupts  | cut -d":" -f1 | sed "s/ //g"); do
  echo "IRQ:  $i";
  echo -n "HINT: " && cat /proc/irq/$i/affinity_hint
  echo -n "SMP:  " && cat /proc/irq/$i/smp_affinity
done
