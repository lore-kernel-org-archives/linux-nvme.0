From: hch@lst.de (Christoph Hellwig)
Date: Wed, 8 May 2019 21:51:59 +0200
Subject: [PATCH] nvme-pci: Use non-operational power state instead of
 D3 on Suspend-to-Idle
In-Reply-To: <f8a043b00909418bad6adcdb62d16e6e@AUSX13MPC105.AMER.DELL.COM>
References: <20190508185955.11406-1-kai.heng.feng@canonical.com>
 <20190508191624.GA8365@localhost.localdomain>
 <3CDA9F13-B17C-456F-8CE1-3A63C6E0DC8F@canonical.com>
 <f8a043b00909418bad6adcdb62d16e6e@AUSX13MPC105.AMER.DELL.COM>
Message-ID: <20190508195159.GA1530@lst.de>

On Wed, May 08, 2019@07:38:50PM +0000, Mario.Limonciello@dell.com wrote:
> The existing routines have an implied assumption that firmware will come swinging
> with a hammer to control the rails the SSD sits on.
> With S2I everything needs to come from the driver side and it really is a
> different paradigm.

And that is why is this patch is fundamentally broken.

When using the simple pm ops suspend the pm core expects the device
to be powered off.  If fancy suspend doesn't want that we need to
communicate what to do to the device in another way, as the whole
thing is a platform decision.  There probabl is one (or five) methods
in dev_pm_ops that do the right thing, but please coordinate this
with the PM maintainers to make sure it does the right thing and
doesn't for example break either hibernate where we really don't
expect just a lower power state, or enterprise class NVMe devices
that don't do APST and don't really do different power states at
all in many cases.
