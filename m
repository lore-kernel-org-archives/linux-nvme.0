From: dan.j.williams@intel.com (Dan Williams)
Date: Mon, 24 Oct 2016 10:57:16 -0700
Subject: [PATCH 0/5] ahci: nvme remap support
In-Reply-To: <CAPcyv4jSx5c3DzEsbfUph5Akk-XyxQ2sXAgmLZfhvGEOUtBqdQ@mail.gmail.com>
References: <147709592108.3733.7194541797066785254.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20161022065038.GA8547@lst.de>
 <CAPcyv4grb=53fvF9akx6r7M_EgHu90w2o3xZySqTev+gOnm14Q@mail.gmail.com>
 <20161023083424.GA31994@lst.de>
 <CAPcyv4iNNu5bxzEOx0XMy2Edd4d5xvrEK+6A4mYsNH5iXtbUTA@mail.gmail.com>
 <20161024124938.GB2389@lst.de> <20161024144628.GC8633@localhost.localdomain>
 <20161024151657.GA7080@lst.de>
 <CAPcyv4jSx5c3DzEsbfUph5Akk-XyxQ2sXAgmLZfhvGEOUtBqdQ@mail.gmail.com>
Message-ID: <CAPcyv4hxxa2FD+kzaDes7FxunwFp=++HiRh=uNMk3W5QWTbHMg@mail.gmail.com>

On Mon, Oct 24, 2016@10:46 AM, Dan Williams <dan.j.williams@intel.com> wrote:
> On Mon, Oct 24, 2016@8:16 AM, Christoph Hellwig <hch@lst.de> wrote:
[..]
>> If it's the latter let's keep AHCI entirely out
>> of the game - add the affected PCI IDs to the NVMe driver itself, add
>> a quirk for them and implement the enable sequence inside the NVMe
>> driver.
>
> The PCI ID of the AHCI device is not uniquely identifiable when in this mode.
>
> We could flip the arrangement and have the ahci device as the platform
> device, but I'm not sure this makes the nvme reset problem much
> better.  If we allow subsystem resets at all they would still need to
> be coordinated across 2 devices/drivers to reinitialize pci registers.

...but it still might be the better way to go. I.e. push the hacks to
the legacy driver and not burden nvme with this new "nvme_dev_ops"
concept.
