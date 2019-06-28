From: hch@lst.de (Christoph Hellwig)
Date: Fri, 28 Jun 2019 09:23:10 +0200
Subject: [PATCH v2 2/5] nvme: rename "pci" operations to "mmio"
In-Reply-To: <CAD8Lp464B0dOd+ayF_AK4DRzHEpiaSbUOXjVJ5bq5zMXq=BBKQ@mail.gmail.com>
References: <20190620051333.2235-1-drake@endlessm.com>
 <20190620051333.2235-3-drake@endlessm.com> <20190620061038.GA20564@lst.de>
 <CAD8Lp45ua=L+ixO+du=Njhy+dxjWobWA+V1i+Y2p6faeyt1FBQ@mail.gmail.com>
 <20190624061617.GA2848@lst.de>
 <CAD8Lp464B0dOd+ayF_AK4DRzHEpiaSbUOXjVJ5bq5zMXq=BBKQ@mail.gmail.com>
Message-ID: <20190628072310.GA28896@lst.de>

On Tue, Jun 25, 2019@11:51:28AM +0800, Daniel Drake wrote:
> Bearing in mind that we've already been told that the NVMe device
> config space is inaccessible, and the new docs show exactly how the
> BIOS enforces such inaccessibility during early boot, the remaining
> points you mentioned recently were:

If we can't access the config space we unfortunately can't support
this scheme at all, as it invalidates all our quirks handling.
