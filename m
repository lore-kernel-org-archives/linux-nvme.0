From: aeasi@marvell.com (Arun Easi)
Date: Wed, 26 Jun 2019 17:28:49 -0700
Subject: [EXT] Re: [PATCH] nvme-fc: fix module unloads while lports still
 pending
In-Reply-To: <alpine.LRH.2.21.9999.1906261638450.7630@mvluser05.qlc.com>
References: <20190625160604.3905-1-jsmart2021@gmail.com>
 <alpine.LRH.2.21.9999.1906261516150.7630@mvluser05.qlc.com>
 <ddcc1865-4494-9cfe-d371-9995c19ae1c4@gmail.com>
 <alpine.LRH.2.21.9999.1906261638450.7630@mvluser05.qlc.com>
Message-ID: <alpine.LRH.2.21.9999.1906261725120.7630@mvluser05.qlc.com>

Attaching the patch I was referring earlier. Maybe the infinite loop in 
exit could be changed to a time bound one.

-Arun

On Wed, 26 Jun 2019, 5:02pm, Arun Easi wrote:

> On Wed, 26 Jun 2019, 4:00pm, James Smart wrote:
> 
> > External Email
> > 
> > ----------------------------------------------------------------------
> > On 6/26/2019 3:20 PM, Arun Easi wrote:
> > > Changes look ok.
> > > 
> > > Did you hit this during testing? Wondering because LLD would have unloaded
> > > prior to nvme_fc, so no lport/rport should remain if LLD behaves well.
> > > 
> > > -Arun
> > > 
> > 
> > It's been a longstanding annoyance - usually tied with test cases that used
> > modprobe -r.   Issue is the drivers would call the targetport unregister
> > calls, which would release the targetport once all the outstanding ios were
> > cancelled to the lldd and the link-side association terminated, but the
> > controllers are in a reconnecting and not yet torn down.
> 
> Did you mean a "nvme_reset_ctrl/nvme_delete_ctrl" is in progress?
> 
> > From the drivers point of view, they are unlinked. Thus it was 
> > intended the driver could unregister/unload/reload/reregister and if 
> > possible reconnect - allowing the nvme device to never be deleted. Given 
> > the lack of module reference, when the driver module left, so did the 
> > transport module, even with the live data structures.
> > 
> 
> Thanks for the explanation. This reminds me of a similar issue we hit. The 
> fix under consideration was to wait in nvme_fc module exit to quiesce 
> rport/lport before proceeding.
> 
> Anyway, with the fix above, I am wondering, if nvme_fc is active for a 
> brief time just after the unload of LLD, the unload of nvme_fc would fail 
> (saying in use), wouldn't it? If so, in addition to the above fix, a 
> quiesce (flush) of such threads during module exit would give "modprobe 
> -r" a better chance to unload both modules.
> 
> Thoughts?
> 
> -Arun
> 
> 
> 
-------------- next part --------------
