From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Thu, 25 Jul 2019 11:51:41 +0200
Subject: [Regression] Commit "nvme/pci: Use host managed power state for
 suspend" has problems
Message-ID: <2332799.izEFUvJP67@kreacher>

Hi Keith,

Unfortunately,

commit d916b1be94b6dc8d293abed2451f3062f6af7551
Author: Keith Busch <keith.busch at intel.com>
Date:   Thu May 23 09:27:35 2019 -0600

    nvme-pci: use host managed power state for suspend

doesn't universally improve things.  In fact, in some cases it makes things worse.

For example, on the Dell XPS13 9380 I have here it prevents the processor package
from reaching idle states deeper than PC2 in suspend-to-idle (which, of course, also
prevents the SoC from reaching any kind of S0ix).

That can be readily explained too.  Namely, with the commit above the NVMe device
stays in D0 over suspend/resume, so the root port it is connected to also has to stay in
D0 and that "blocks" package C-states deeper than PC2.

In order for the root port to be able to go to D3, the device connected to it also needs
to go into D3, so it looks like (at least on this particular machine, but maybe in
general), both D3 and the NVMe-specific PM are needed.

I'm not sure what to do here, because evidently there are systems where that commit
helps.  I was thinking about adding a module option allowing the user to override the
default behavior which in turn should be compatible with 5.2 and earlier kernels.

Cheers,
Rafael
