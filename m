From: acelan.kao@canonical.com (AceLan Kao)
Date: Tue, 6 Nov 2018 18:11:31 +0800
Subject: [PATCH 1/2] pci: prevent sk hynix nvme from entering D3
In-Reply-To: <20181106071011.GA23935@infradead.org>
References: <20181106020402.21120-1-acelan.kao@canonical.com>
 <20181106071011.GA23935@infradead.org>
Message-ID: <CAFv23QmK-BPNLcy9UTuYjF=Jv_xOUFj5dTTem9r-dfijb4WQ8Q@mail.gmail.com>

Christoph Hellwig <hch at infradead.org> ? 2018?11?6? ?? ??3:10???
>
> On Tue, Nov 06, 2018@10:04:01AM +0800, AceLan Kao wrote:
> > It leads to the power consumption raises to 2.2W during s2idle, while
> > it consumes less than 1W during long idle if put SK hynix nvme to D3
> > and then enter s2idle.
> > >From SK hynix FE, MS Windows doesn't put nvme to D3, and uses its own
> > APST feature to do the power management.
> > To leverage its APST feature during s2idle, we can't disable nvme
> > device while suspending, too.
> >
> > BTW, prevent it from entering D3 will increase the power consumtion around
> > 0.13W ~ 0.15W during short/long idle, and the power consumption during
> > s2idle becomes 0.77W.
>
> Please get this fixed in firmware.  And yes, depending on which Windows
> driver you use Windows might be doing very agressive runtime D3, which
> is parted of Windows modern standby, so it'll trip up there eventually
> as well.
Agree, this is not a good fix for Sk hynix nvme, so Dell is still pushing
Sk hynix to fix it from firmware.
But before the firmware is ready, this is still a issue that need to be fixed in
kernel side, and the new firmware may not be applied on the old nvme
modules.
This list won't keep growing, and we'll keep an eye on the new firmware and
co-work with engineers from Sky hynix to make sure this issue won't happen
again.
