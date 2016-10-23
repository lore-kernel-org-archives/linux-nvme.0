From: dan.j.williams@intel.com (Dan Williams)
Date: Sun, 23 Oct 2016 06:57:41 -0700
Subject: [PATCH 0/5] ahci: nvme remap support
In-Reply-To: <20161023083424.GA31994@lst.de>
References: <147709592108.3733.7194541797066785254.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20161022065038.GA8547@lst.de>
 <CAPcyv4grb=53fvF9akx6r7M_EgHu90w2o3xZySqTev+gOnm14Q@mail.gmail.com>
 <20161023083424.GA31994@lst.de>
Message-ID: <CAPcyv4iNNu5bxzEOx0XMy2Edd4d5xvrEK+6A4mYsNH5iXtbUTA@mail.gmail.com>

On Sun, Oct 23, 2016@1:34 AM, Christoph Hellwig <hch@lst.de> wrote:
> It's just a major burden on NVMe.  What is the reset behavior of
> your franken devices for example?  Pleas take it to the NVMe technical
> working group first so that we can come up with a coherent theory
> of operations.

I should clarify that these are not new devices for the NVMe technical
working group to consider. They are discrete / typical / off-the-shelf
NVMe devices from any vendor.  It's just the memory bar and interrupt
vector that are arranged to be shared with an ahci pci device.
