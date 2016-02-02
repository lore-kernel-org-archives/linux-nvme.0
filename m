From: mark_jacobson@stackvelocity.com (Mark Jacobson)
Date: Wed, 3 Feb 2016 00:31:22 +0100
Subject: NVMe and IRQ Affinity
Message-ID: <CACo6K_bSDJwt61mnKDpYvcXjCVA9UKGO17pythzcJ8Rnjh19sA@mail.gmail.com>

Hello there,

I had a question regarding the NVMe driver and IRQ affinity. For
context, I'm running Centos 7.1 with the 4.2.3-1.el7.elrepo.x86_64
kernel on a system with two E5-2650 v3 CPUs.

I've been battling soft core lockups in a system with 24 NVMe drives
and noticed that the drives I'm working with (Samsung PM953) will by
default only route interrupts to CPU0 despite having affinity for all
cores and I figured I'd ask here since that seemed like a driver
issue.

I've tried adjusting the smp_affinity for the various IRQ handlers,
but 1) That seems to essentially force (most of the) interrupts up to
the higher MSI-X vectors that do still have CPU 0 available, and 2)
there seems to be a huge performance hit swapping to another CPU (say
CPU2).  Is this something that makes any kind of sense from a driver
perspective? (I know high-speed NICs commonly distribute interrupts
across many cores, so it doesn't seem normal to me.) Is there a newer
kernel version that would help with this problem? Or barring any of
that, does this seem like a hardware issue?

(And yes, I realize eventually my IRQ masks should only point to cores
associated with the NUMA node they're connected to. I've been ignoring
that for debugging.)

Trimmed interrupt table (forgive the many, many wraps) below. The
spikes on cores on interrupt 159 are for when I forced interrupts away
from CPU0 by masking off some of the lower order irq affinity bits.

 159:  145078914          0          0          0   11994376
0          0          0    5139627          0          0          0
      0          0          0          0          0          0
 0          0    2766162
         0          0          0          0          0          0
    0          0          0          0          0          0
0          0          0          0          0          0          0
IR-PCI-MSI 12058624-edge
   nvme7q0, nvme7q1
 160:   12514715          0          0          0          0
0          0          0          0          0          0          0
      0          0          0          0          0          0
 0          0          0
         0          0          0          0          0          0
    0          0          0          0          0          0
0          0          0          0          0          0          0
IR-PCI-MSI 12058625-edge
   nvme7q2
 161:     985758          0          0          0          0
0          0          0          0          0          0          0
      0          0          0          0          0          0
 0          0          0
         0          0          0          0          0          0
    0          0          0          0          0          0
0          0          0          0          0          0          0
IR-PCI-MSI 12058626-edge
   nvme7q3
 162:    6155130          0          0          0          0
0          0          0          0          0          0          0
      0          0          0          0          0          0
 0          0          0
         0          0          0          0          0          0
    0          0          0          0          0          0
0          0          0          0          0          0          0
IR-PCI-MSI 12058627-edge
   nvme7q4
 163:      61111          0          0          0          0
0          0          0          0          0          0          0
      0          0          0          0          0          0
 0          0          0
         0          0          0          0          0          0
    0          0          0          0          0          0
0          0          0          0          0          0          0
IR-PCI-MSI 12058628-edge
   nvme7q5
 164:      53257          0          0          0          0
0          0          0          0          0          0          0
      0          0          0          0          0          0
 0          0          0
         0          0          0          0          0          0
    0          0          0          0          0          0
0          0          0          0          0          0          0
IR-PCI-MSI 12058629-edge
   nvme7q6
 165:      52186          0          0          0          0
0          0          0          0          0          0          0
      0          0          0          0          0          0
 0          0          0
         0          0          0          0          0          0
    0          0          0          0          0          0
0          0          0          0          0          0          0
IR-PCI-MSI 12058630-edge
   nvme7q7
 166:      28943          0          0          0          0
0          0          0          0          0          0          0
      0          0          0          0          0          0
 0          0          0
         0          0          0          0          0          0
    0          0          0          0          0          0
0          0          0          0          0          0          0
IR-PCI-MSI 12058631-edge
   nvme7q8

Any help would be appreciated!

Thank you,

Mark Jacobson
Software Test Engineer
Stack Velocity
