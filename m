From: dan.j.williams@intel.com (Dan Williams)
Date: Sat, 22 Oct 2016 12:26:54 -0700
Subject: [PATCH 0/5] ahci: nvme remap support
In-Reply-To: <20161022065038.GA8547@lst.de>
References: <147709592108.3733.7194541797066785254.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20161022065038.GA8547@lst.de>
Message-ID: <CAPcyv4grb=53fvF9akx6r7M_EgHu90w2o3xZySqTev+gOnm14Q@mail.gmail.com>

On Fri, Oct 21, 2016@11:50 PM, Christoph Hellwig <hch@lst.de> wrote:
> On Fri, Oct 21, 2016@05:25:21PM -0700, Dan Williams wrote:
>> Some Intel ahci implementations have the capability to expose another
>> pci-express device's memory resources through an ahci memory bar.  Add
>> the enabling to detect these configurations and register the resources
>> for the nvme driver to consume. Otherwise, the nvme device is
>> effectively hidden from the kernel for this configuration.
>
> Honestly I think this is just too ugly to live. I think people getting
> tricked by Intel into buying this piece of junk will just have to live
> with AHCI mode.

Objection noted and, frankly, expected. But no, this is Linux, we as a
community do our best to not strand users with hardware they have in
hand. So, please help me review these patches with an eye towards
minimizing the ongoing maintenance burden to ahci and nvme.
