From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Tue, 26 Feb 2019 17:01:49 -0800
Subject: [PATCH] nvme-pci: Prevent mmio reads if pci channel offline
In-Reply-To: <b35ebf928ed743cca6649a191c76957b@ausx13mps321.AMER.DELL.COM>
References: <20190222010502.2434-1-jonathan.derrick@intel.com>
 <CAHk-=wjmjHyovjtzaq=HSegEpiO2SXWaYfJ6qsJrZhXg_YSx5g@mail.gmail.com>
 <2b7d8f45d11c47e69f56ad1bc3324dd1@ausx13mps321.AMER.DELL.COM>
 <CAHk-=wg_e5M0b5aJJf8V_UYaqX12YYA9MEg=gHNp6ALE5fK23w@mail.gmail.com>
 <cbe2ed1562a64609be6538f5816ec1b6@ausx13mps321.AMER.DELL.COM>
 <20190225155501.GI10237@localhost.localdomain>
 <b35ebf928ed743cca6649a191c76957b@ausx13mps321.AMER.DELL.COM>
Message-ID: <CAHk-=wgRdATtsBzo-LDkWn_sW-PJvq95SahZcsTxxDMPzLWxKA@mail.gmail.com>

On Tue, Feb 26, 2019@2:37 PM <Alex_Gagniuc@dellteam.com> wrote:
>
> Then nobody gets the (error) message. You can go a bit further and try
> 'pcie_ports=native". Again, nobody gets the memo. ):

So? The error was bogus to begin with. Why would we care?

Yes, yes, PCI bridges have the ability to return errors in accesses to
non-existent devices. But that was always bogus, and is never useful.
The whole "you get an interrupt or NMI on a bad access" is simply a
horribly broken model. It's not useful.

We already have long depended on hotplug drivers noticing the "oh, I'm
getting all-ff returns, the device may be gone". It's usually trivial,
and works a whole lot better.

It's not an error. Trying to force it to be an NMI or SCI or machine
check is bogus. It causes horrendous pain, because asynchronous
reporting doesn't work reliably anyway, and *synchronous* reporting is
impossible to sanely handle without crazy problems.

So the only sane model for hotplug devices is "IO still works, and
returns all ones". Maybe with an async one-time and *recoverable*
machine check or other reporting the access after the fact.

Anything else is simply broken. It would be broken even if firmware
wasn't involved, but obviously firmware people tend to often make a
bad situation even worse.

              Linus
