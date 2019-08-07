From: jeff.johnson@aeoncomputing.com (Jeff Johnson)
Date: Wed, 7 Aug 2019 14:04:32 -0700
Subject: inverting order of NVMe pci enable/disable device during
 boot/shutdown? Failing release.
Message-ID: <CAFCYAsfsCH+swCmpubto9od6dmJFsw0i+VDri9U+GVyZkOqcWg@mail.gmail.com>

Greetings,

Is there a way to invert the order of PCI device enable/disable during
boot or shutdown?

I have an attached NVMe SSD chassis with 24 SSDs. I have discovered
that on random host shutdowns that the last couple NVMe SSDs get left
in a bad state after they are unregistered by the kernel. Out of 24
SSDs all but the last one or two successfully remain at their
negotiated speed and width after release. The last one, or sometimes
two, SSDs to be released get stuck in a polling state (gen1, 0width)
which will not clear or resolve unless the PCIe switch is reset.

Multiple backplanes and moving SSDs doesn't change the fact that it is
always the last one or two SSDs to release on host orderly shutdown.

If I can swap the order of drive reserve/release on boot and shutdown
then I could determine if the issue follows the physical path or the
last drives in the release process.

Thanks!

--Jeff
