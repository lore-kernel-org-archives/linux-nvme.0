From: hch@lst.de (Christoph Hellwig)
Date: Wed, 7 Nov 2018 09:19:15 +0100
Subject: [PATCH 1/2] pci: prevent sk hynix nvme from entering D3
In-Reply-To: <CAFv23QmK-BPNLcy9UTuYjF=Jv_xOUFj5dTTem9r-dfijb4WQ8Q@mail.gmail.com>
References: <20181106020402.21120-1-acelan.kao@canonical.com>
 <20181106071011.GA23935@infradead.org>
 <CAFv23QmK-BPNLcy9UTuYjF=Jv_xOUFj5dTTem9r-dfijb4WQ8Q@mail.gmail.com>
Message-ID: <20181107081915.GA24841@lst.de>

On Tue, Nov 06, 2018@06:11:31PM +0800, AceLan Kao wrote:
> Agree, this is not a good fix for Sk hynix nvme, so Dell is still pushing
> Sk hynix to fix it from firmware.
> But before the firmware is ready, this is still a issue that need to be fixed in
> kernel side, and the new firmware may not be applied on the old nvme
> modules.
> This list won't keep growing, and we'll keep an eye on the new firmware and
> co-work with engineers from Sky hynix to make sure this issue won't happen
> again.

We generally quirk for grave issues that make devices unusable.

To me working around a D3 mode that consumers more power than D0
does not quite fit that bill.
