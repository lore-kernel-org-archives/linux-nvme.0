From: mr.nuke.me@gmail.com (Alex G)
Date: Wed, 20 Mar 2019 20:27:11 -0500
Subject: [PATCH v3] PCI/MSI: Don't touch MSI bits when the PCI device is
 disconnected
In-Reply-To: <CAHk-=wjDY1C+E0gUHmb6O3THwoTNpm=-qthDRcW+sG2RB430Mw@mail.gmail.com>
References: <20190222194808.15962-1-mr.nuke.me@gmail.com>
 <20190320205233.GE251185@google.com>
 <CAHk-=wjDY1C+E0gUHmb6O3THwoTNpm=-qthDRcW+sG2RB430Mw@mail.gmail.com>
Message-ID: <156dec38-438d-1ce9-64fa-af95d37c14bd@gmail.com>

On 3/20/19 4:44 PM, Linus Torvalds wrote:
> On Wed, Mar 20, 2019@1:52 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>>
>> AFAICT, the consensus there was that it would be better to find some
>> sort of platform solution instead of dealing with it in individual
>> drivers.  The PCI core isn't really a driver, but I think the same
>> argument applies to it: if we had a better way to recover from readl()
>> errors, that way would work equally well in nvme-pci and the PCI core.
> 
> I think that patches with the pattern "if (disconnected) don't do IO"
> are fundamentally broken and we should look for alternatives in all
> cases.
> 
> They are fundamentally broken because they are racy: if it's an actual
> sudden disconnect in the middle of IO, there's no guarantee that we'll
> even be notified in time.
> 
> They are fundamentally broken because they add new magic special cases
> that very few people will ever test, and the people who do test them
> tend to do so with old irrelevant kernels.
> 
> Finally, they are fundamentally broken because they always end up
> being just special cases. One or two special case accesses in a
> driver, or perhaps all accesses of a particular type in just _one_
> special driver.
> 
> Yes, yes, I realize that people want error reporting, and that
> hot-removal can cause various error conditions (perhaps just parity
> errors for the IO, but also perhaps other random errors caused by
> firmware perhaps doing special HW setup).
> 
> But the "you get a fatal interrupt, so avoid the IO" kind of model is
> completely broken, and needs to just be fixed differently. See above
> why it's so completely broken.
> 
> So if the hw is set up to send some kinf of synchronous interrupt or
> machine check that cannot sanely be handled (perhaps because it will
> just repeat forever), we should try to just disable said thing.
> 
> PCIe allows for just polling for errors on the bridges, afaik. It's
> been years since I looked at it, and maybe I'm wrong. And I bet there
> are various "platform-specific value add" registers etc that may need
> tweaking outside of any standard spec for PCIe error reporting. But
> let's do that in a platform driver, to set up the platform to not do
> the silly "I'm just going to die if I see an error" thing.
> 
> It's way better to have a model where you poll each bridge once a
> minute (or one an hour) and let people know "guys, your hardware
> reports errors", than make random crappy changes to random drivers
> because the hardware was set up to die on said errors.
> 
> And if some MIS person wants the "hardware will die" setting, then
> they can damn well have that, and then it's not out problem, but it
> also means that we don't start changing random drivers for that insane
> setting. It's dead, Jim, and it was the users choice.
> 
> Notice how in neither case does it make sense to try to do some "if
> (disconnected) dont_do_io()" model for the drivers.

I disagree with the idea of doing something you know can cause an error 
to propagate. That being said, in this particular case we have come to 
rely a little too much on the if (disconnected) model.

You mentioned in the other thread that fixing the GHES driver will pay 
much higher dividends. I'm working on reviving a couple of changes to do 
just that. Some industry folk were very concerned about the "don't 
panic()" approach, and I want to make sure I fairly present their 
arguments in the cover letter.

I'm hoping one day we'll have the ability to use page tables to prevent 
the situations that we're trying to fix today in less than ideal ways. 
Although there are other places in msi.c that use if (disconnected), I'm 
okay with dropping this change -- provided we come up with an equivalent 
fix.

But even if FFS doesn't crash, do we really want to lose hundreds of 
milliseconds to SMM --on all cores-- when all it takes is a couple of 
cycles to check a flag?

Alex
