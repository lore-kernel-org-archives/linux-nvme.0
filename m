From: alexander.duyck@gmail.com (Alexander Duyck)
Date: Fri, 20 Apr 2018 13:01:07 -0700
Subject: [pci PATCH v8 0/4] Add support for unmanaged SR-IOV
In-Reply-To: <5fc62d10-790f-2356-c2f6-fd49f542dd3c@infradead.org>
References: <20180420162633.46077.49012.stgit@ahduyck-green-test.jf.intel.com>
 <5fc62d10-790f-2356-c2f6-fd49f542dd3c@infradead.org>
Message-ID: <CAKgT0UewuO7LWc8wkHPTv2cksF39-8+5nFfEP_DmXVRQtgOWdg@mail.gmail.com>

On Fri, Apr 20, 2018@10:23 AM, Randy Dunlap <rdunlap@infradead.org> wrote:
> On 04/20/18 09:28, Alexander Duyck wrote:
>> This series is meant to add support for SR-IOV on devices when the VFs are
>> not managed by the kernel. Examples of recent patches attempting to do this
>> include:
>> virto - https://patchwork.kernel.org/patch/10241225/
>> pci-stub - https://patchwork.kernel.org/patch/10109935/
>> vfio - https://patchwork.kernel.org/patch/10103353/
>> uio - https://patchwork.kernel.org/patch/9974031/
>
> Hi,
>
> Somewhere in this patch series it would be nice to tell us what the heck
> a "PF" is.  :)
>
> Thanks.

Sorry, I was kind of operating on the assumption of everyone
understanding SR-IOV nomenclature.

A "PF" is a PCIe Physical Function. When you bring up a PCIe device
that supports SR-IOV it is the device that is there to begin with.

A "VF" is a PCIe Virtual Function. You could think of as a logical
device that is spawned from the physical function using a combination
of hardware configuration via the SR-IOV block in the PCIe extended
configuration space and kernel/driver features.

There are also a number of online resources you could use to research
SR-IOV further. Hope that helps to clarify some of this.

Thanks.

Alex
