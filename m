From: kbusch@kernel.org (Keith Busch)
Date: Thu, 25 Jul 2019 08:52:10 -0600
Subject: [Regression] Commit "nvme/pci: Use host managed power state for
 suspend" has problems
In-Reply-To: <2332799.izEFUvJP67@kreacher>
References: <2332799.izEFUvJP67@kreacher>
Message-ID: <20190725145209.GA6949@localhost.localdomain>

On Thu, Jul 25, 2019@02:51:41AM -0700, Rafael J. Wysocki wrote:
> Hi Keith,
> 
> Unfortunately,
> 
> commit d916b1be94b6dc8d293abed2451f3062f6af7551
> Author: Keith Busch <keith.busch at intel.com>
> Date:   Thu May 23 09:27:35 2019 -0600
> 
>     nvme-pci: use host managed power state for suspend
> 
> doesn't universally improve things.  In fact, in some cases it makes things worse.
> 
> For example, on the Dell XPS13 9380 I have here it prevents the processor package
> from reaching idle states deeper than PC2 in suspend-to-idle (which, of course, also
> prevents the SoC from reaching any kind of S0ix).
> 
> That can be readily explained too.  Namely, with the commit above the NVMe device
> stays in D0 over suspend/resume, so the root port it is connected to also has to stay in
> D0 and that "blocks" package C-states deeper than PC2.
> 
> In order for the root port to be able to go to D3, the device connected to it also needs
> to go into D3, so it looks like (at least on this particular machine, but maybe in
> general), both D3 and the NVMe-specific PM are needed.
> 
> I'm not sure what to do here, because evidently there are systems where that commit
> helps.  I was thinking about adding a module option allowing the user to override the
> default behavior which in turn should be compatible with 5.2 and earlier kernels.

Darn, that's too bad. I don't think we can improve one thing at the
expense of another, so unless we find an acceptable criteria to select
what low power mode to use, I would be inclined to support a revert or
a kernel option to default to the previous behavior.

One thing we might check before using NVMe power states is if the lowest
PS is non-operational with MP below some threshold. What does your device
report for:

  nvme id-ctrl /dev/nvme0

?
