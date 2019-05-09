From: Mario.Limonciello@dell.com (Mario.Limonciello@dell.com)
Date: Thu, 9 May 2019 18:57:34 +0000
Subject: [PATCH] nvme-pci: Use non-operational power state instead of D3
 on Suspend-to-Idle
In-Reply-To: <AB325926-0D77-4851-8E8A-A10599756BF9@canonical.com>
References: <3CDA9F13-B17C-456F-8CE1-3A63C6E0DC8F@canonical.com>
 <f8a043b00909418bad6adcdb62d16e6e@AUSX13MPC105.AMER.DELL.COM>
 <20190508195159.GA1530@lst.de>
 <b43f2c0078f245398101fa9a40cfc2dc@AUSX13MPC105.AMER.DELL.COM>
 <20190509061237.GA15229@lst.de>
 <064701C3-2BD4-4D93-891D-B7FBB5040FC4@canonical.com>
 <CAJZ5v0ggMwpJt=XWXu4gU51o8y4BpJ4KZ5RKzfk3+v8GGb-QbQ@mail.gmail.com>
 <A4DD2E9F-054E-4D4B-9F77-D69040EBE120@canonical.com>
 <20190509095601.GA19041@lst.de>
 <225CF4F7-C8E1-4C66-B362-97E84596A54E@canonical.com>
 <20190509103142.GA19550@lst.de>
 <AB325926-0D77-4851-8E8A-A10599756BF9@canonical.com>
Message-ID: <31b7d7959bf94c15a04bab0ced518444@AUSX13MPC101.AMER.DELL.COM>

> >
> >>> Otherwise I think we should use a "no-op" suspend, just leaving the
> >>> power management to the device, or a simple setting the device to the
> >>> deepest power state for everything else, where everything else is
> >>> suspend, or suspend to idle.
> >>
> >> I am not sure I get your idea. Does this ?no-op? suspend happen in NVMe
> >> driver or PM core?
> >
> > no-op means we don't want to do anything in nvme.  If that happens
> > by not calling nvme or stubbing out the method for that particular
> > case does not matter.
> 
> Ok, but we still need to figure out how to prevent the device device from
> tradition to D3.

This so-called no-op was something that we had experimented with while developing
this patch, but found that it would not help power consumption on all drives.

That's why we have explicit call to go into deepest power state in current patch.

> 
> >
> >>> And of course than we have windows modern standby actually mandating
> >>> runtime D3 in some case, and vague handwaving mentions of this being
> >>> forced on the platforms, which I'm not entirely sure how they fit
> >>> into the above picture.
> >>
> >> I was told that Windows doesn?t use runtime D3, APST is used exclusively.
> >
> > As far as I know the default power management modes in the Microsoft
> > NVMe driver is explicit power management transitions, and in the Intel
> > RST driver that is commonly used it is APST.  But both could still
> > be comined with runtime D3 in theory, I'm just not sure if they are.
> >
> > Microsoft has been pushing for aggressive runtime D3 for a while, but
> > I don't know if that includes NVMe devices.
> 
> Ok, I?ll check with vendors about this.
> 

No, current Windows versions don't transition to D3 with inbox NVME driver.
You're correct, it's explicit state transitions even if APST was enabled
(as this patch is currently doing as well).
