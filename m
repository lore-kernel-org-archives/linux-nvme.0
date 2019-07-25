From: kai.heng.feng@canonical.com (Kai-Heng Feng)
Date: Thu, 25 Jul 2019 22:02:37 +0800
Subject: [Regression] Commit "nvme/pci: Use host managed power state for
 suspend" has problems
In-Reply-To: <2332799.izEFUvJP67@kreacher>
References: <2332799.izEFUvJP67@kreacher>
Message-ID: <E62786E4-5DA9-4542-899A-658D0E021190@canonical.com>

Hi Rafael,

at 17:51, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:

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
> doesn't universally improve things.  In fact, in some cases it makes  
> things worse.
>
> For example, on the Dell XPS13 9380 I have here it prevents the processor  
> package
> from reaching idle states deeper than PC2 in suspend-to-idle (which, of  
> course, also
> prevents the SoC from reaching any kind of S0ix).
>
> That can be readily explained too.  Namely, with the commit above the  
> NVMe device
> stays in D0 over suspend/resume, so the root port it is connected to also  
> has to stay in
> D0 and that "blocks" package C-states deeper than PC2.
>
> In order for the root port to be able to go to D3, the device connected  
> to it also needs
> to go into D3, so it looks like (at least on this particular machine, but  
> maybe in
> general), both D3 and the NVMe-specific PM are needed.
>
> I'm not sure what to do here, because evidently there are systems where  
> that commit
> helps.  I was thinking about adding a module option allowing the user to  
> override the
> default behavior which in turn should be compatible with 5.2 and earlier  
> kernels.

I just briefly tested s2i on XPS 9370, and the power meter shows a 0.8~0.9W  
power consumption so at least I don?t see the issue on XPS 9370.

Can you please provide the output of `nvme id-ctrl /dev/nvme*` and I?ll  
test the NVMe controller on XPS 9380.

Kai-Heng

>
> Cheers,
> Rafael
