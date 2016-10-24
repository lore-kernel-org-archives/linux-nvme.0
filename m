From: hch@lst.de (Christoph Hellwig)
Date: Mon, 24 Oct 2016 20:21:36 +0200
Subject: [PATCH 0/5] ahci: nvme remap support
In-Reply-To: <CAPcyv4hxxa2FD+kzaDes7FxunwFp=++HiRh=uNMk3W5QWTbHMg@mail.gmail.com>
References: <147709592108.3733.7194541797066785254.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20161022065038.GA8547@lst.de>
 <CAPcyv4grb=53fvF9akx6r7M_EgHu90w2o3xZySqTev+gOnm14Q@mail.gmail.com>
 <20161023083424.GA31994@lst.de>
 <CAPcyv4iNNu5bxzEOx0XMy2Edd4d5xvrEK+6A4mYsNH5iXtbUTA@mail.gmail.com>
 <20161024124938.GB2389@lst.de> <20161024144628.GC8633@localhost.localdomain>
 <20161024151657.GA7080@lst.de>
 <CAPcyv4jSx5c3DzEsbfUph5Akk-XyxQ2sXAgmLZfhvGEOUtBqdQ@mail.gmail.com>
 <CAPcyv4hxxa2FD+kzaDes7FxunwFp=++HiRh=uNMk3W5QWTbHMg@mail.gmail.com>
Message-ID: <20161024182136.GA11822@lst.de>

On Mon, Oct 24, 2016@10:57:16AM -0700, Dan Williams wrote:
> ...but it still might be the better way to go. I.e. push the hacks to
> the legacy driver and not burden nvme with this new "nvme_dev_ops"
> concept.

Let's get some coherent text on how this device even operates out
first and then we can decide if and how we can support it.
