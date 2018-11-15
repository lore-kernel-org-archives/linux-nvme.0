From: helgaas@kernel.org (Bjorn Helgaas)
Date: Thu, 15 Nov 2018 08:58:09 -0600
Subject: [PATCH v2 1/2] pci: prevent sk hynix nvme from entering D3
In-Reply-To: <B21C5A96-AB21-4405-BBF1-9AD343425CA9@canonical.com>
References: <20181106071214.12745-1-acelan.kao@canonical.com>
 <20181109002157.GK41183@google.com>
 <B21C5A96-AB21-4405-BBF1-9AD343425CA9@canonical.com>
Message-ID: <20181115145809.GA207836@google.com>

On Thu, Nov 15, 2018@03:16:29PM +0800, Kai Heng Feng wrote:
> > On Nov 9, 2018,@08:21, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Tue, Nov 06, 2018@03:12:13PM +0800, AceLan Kao wrote:
> >> It leads to the power consumption raises to 2.2W during s2idle, while
> >> it consumes less than 1W during long idle if put SK hynix nvme to D3
> >> and then enter s2idle.
> >> From SK hynix FE, MS Windows doesn't put nvme to D3, and uses its own
> >> APST feature to do the power management.
> >> To leverage its APST feature during s2idle, we can't disable nvme
> >> device while suspending, too.
> 
> We have a new Intel NVMe [8086:f1a6] that has this ?new? behavior.
> 
> > I don't know how APST works, but it sounds like you want to disable D3
> > if you're using APST.  But that's not what this patch does; this
> > disables it always.
> 
> Ok, will work on a new patch that only disables D3 when APST is enabled.

My comment was that the changelog didn't match the code.  I don't know
which one is wrong, so I wasn't trying to suggest that you change the
code.  If the code is right and the changelog is wrong, just change
the changelog.

> > I'm not sure we want a quirk for this at all, since as Christoph
> > points out, it doesn't fix a functional issue as the other uses of
> > quirk_no_ata_d3() do.
> > 
> > From your emails with Christoph, it sounds like this quirk is a
> > workaround for a firmware defect.  If we *do* end up wanting a quirk,
> > the changelog should at least mention the firmware defect and maybe
> > check whether it has been fixed.
> 
> According to SK Hynix folks and new evidence on the new Intel NVMe
> we have, this is something we are going to see more often.

Hmmm, are you suggesting that if we went this quirk route, we'd be
updating the quirk frequently to add new devices?

I'm opposed to that as a strategy because it makes needless work.  You
have to update the quirk, backport it to older kernels, re-release
distro kernels, etc.

If this situation is going to happen frequently, it would be better to
(a) fix the firmware defect (if that's what this is) or (b) pursue
some APST or other spec change so there's a generic documented way to
handle this without requiring device-specific quirks.

Bjorn
