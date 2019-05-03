From: hch@lst.de (Christoph Hellwig)
Date: Fri, 3 May 2019 14:20:35 +0200
Subject: [PATCH 0/4] nvme-pci: support device coredump
In-Reply-To: <20190503121232.GB30013@localhost.localdomain>
References: <1556787561-5113-1-git-send-email-akinobu.mita@gmail.com>
 <20190502125722.GA28470@localhost.localdomain>
 <CAC5umygdADGrYeJy=F53Mm4bNPHmo+WY4SD3HFSRqi_cLrz9jw@mail.gmail.com>
 <20190503121232.GB30013@localhost.localdomain>
Message-ID: <20190503122035.GA21501@lst.de>

On Fri, May 03, 2019@06:12:32AM -0600, Keith Busch wrote:
> Could you actually explain how the rest is useful? I personally have
> never encountered an issue where knowing these values would have helped:
> every device timeout always needed device specific internal firmware
> logs in my experience.

Yes.  Also not that NVMe now has the 'device initiated telemetry'
feauture, which is just a wired name for device coredump.  Wiring that
up so that we can easily provide that data to the device vendor would
actually be pretty useful.
