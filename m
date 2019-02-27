From: kbusch@kernel.org (Keith Busch)
Date: Wed, 27 Feb 2019 10:51:20 -0700
Subject: [PATCH] nvme-pci: Prevent mmio reads if pci channel offline
In-Reply-To: <940d608e1a044a54abcb9d65923951f3@ausx13mps317.AMER.DELL.COM>
References: <20190222010502.2434-1-jonathan.derrick@intel.com>
 <CAHk-=wjmjHyovjtzaq=HSegEpiO2SXWaYfJ6qsJrZhXg_YSx5g@mail.gmail.com>
 <2b7d8f45d11c47e69f56ad1bc3324dd1@ausx13mps321.AMER.DELL.COM>
 <CAHk-=wg_e5M0b5aJJf8V_UYaqX12YYA9MEg=gHNp6ALE5fK23w@mail.gmail.com>
 <cbe2ed1562a64609be6538f5816ec1b6@ausx13mps321.AMER.DELL.COM>
 <20190225155501.GI10237@localhost.localdomain>
 <b35ebf928ed743cca6649a191c76957b@ausx13mps321.AMER.DELL.COM>
 <CAHk-=wgRdATtsBzo-LDkWn_sW-PJvq95SahZcsTxxDMPzLWxKA@mail.gmail.com>
 <940d608e1a044a54abcb9d65923951f3@ausx13mps317.AMER.DELL.COM>
Message-ID: <20190227175119.GB19455@localhost.localdomain>

On Wed, Feb 27, 2019@04:42:05PM +0000, Alex_Gagniuc@Dellteam.com wrote:
> On 2/26/19 7:02 PM, Linus Torvalds wrote:
> > On Tue, Feb 26, 2019@2:37 PM <Alex_Gagniuc@dellteam.com> wrote:
> >>
> >> Then nobody gets the (error) message. You can go a bit further and try
> >> 'pcie_ports=native". Again, nobody gets the memo. ):
> > 
> > So? The error was bogus to begin with. Why would we care?
> 
> Of course nobody cares about that. We care about actual errors that we 
> now know we won't be notified of. Imagine if we didn't get the memo that 
> a piece of data is corrupt, and imagine the reaction of RAS folk.
> 
> And I know the counter to that is a panic() is much more likely to cause 
> data corruption, and we're trading one piece of crap for an even 
> stinkier one. Whatever we end up doing, we have to do better than 
> silence errors and pretend nothing happened.
> 
> 
> > Yes, yes, PCI bridges have the ability to return errors in accesses to
> > non-existent devices. But that was always bogus, and is never useful.
> > The whole "you get an interrupt or NMI on a bad access" is simply a
> > horribly broken model. It's not useful.
> > 
> > We already have long depended on hotplug drivers noticing the "oh, I'm
> > getting all-ff returns, the device may be gone". It's usually trivial,
> > and works a whole lot better.
> 
> And that's been working great, hasn't it? I think you're thinking 
> strictly about hotplug. There are other situations where things are all 
> F'd, but the hardware isn't sending all F's. (example: ECRC errors)
> 
> 
> > It's not an error. Trying to force it to be an NMI or SCI or machine
> > check is bogus. It causes horrendous pain, because asynchronous
> > reporting doesn't work reliably anyway, and *synchronous* reporting is
> > impossible to sanely handle without crazy problems.
> > 
> > So the only sane model for hotplug devices is "IO still works, and
> > returns all ones". Maybe with an async one-time and *recoverable*
> > machine check or other reporting the access after the fact.
> 
> Exactly!!! A notification (not calling it an 'error') that something 
> unusual has happened is good. Treating these things like errors is so 
> obvious, even a caveman wouldn't do it.
> In a world with FFS, we don't always get to have that model. Oh, FFS!
> 
> 
> > Anything else is simply broken. It would be broken even if firmware
> > wasn't involved, but obviously firmware people tend to often make a
> > bad situation even worse.
> 
> Linus, be nice to firmware people. I've met a few, and I can vouch that 
> they're very kind and nice. They're also very scared, especially when OS 
> people want to ask them a few questions.
> 
> I think FFS should get out of the way when OS advertises it's capable of 
> handling XYZ. There are some good arguments why this hasn't happened, 
> but I won't get into details. I do think it's unlikely that machines 
> will be moving back to an OS-controlled model.
> 
> And Linus, keep in mind, when these machines were developed, OSes 
> couldn't handle recovery properly. None of this was ever an issue. It's 
> our fault that we've changed the OS after the machines are on the market.
> 
> Alex

I can't tell where you're going with this. It doesn't sound like you're
talking about hotplug anymore, at least.
