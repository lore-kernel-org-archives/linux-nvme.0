From: mark.d.rustad@intel.com (Rustad, Mark D)
Date: Tue, 3 Apr 2018 19:18:23 +0000
Subject: [virtio-dev] [pci PATCH v7 2/5] virtio_pci: Add support for
 unmanaged SR-IOV on virtio_pci devices
In-Reply-To: <20180403212503-mutt-send-email-mst@kernel.org>
References: <20180315183449.3102.64791.stgit@localhost.localdomain>
 <20180315184132.3102.90947.stgit@localhost.localdomain>
 <20180316183042-mutt-send-email-mst@kernel.org>
 <CAKgT0UfgZ2gAdiAbCe4MTOr3o9cqq1q-mykCQsw68p2F-QEC8g@mail.gmail.com>
 <20180403161151-mutt-send-email-mst@kernel.org>
 <CAKgT0UfeSmG=xsd6sTkg4cOMnZ0QiqtCRDt4PynpF3d6nvvFCA@mail.gmail.com>
 <20180403212503-mutt-send-email-mst@kernel.org>
Message-ID: <0927465E-0B56-4903-9F5E-288A7D9C46E6@intel.com>

On Apr 3, 2018,@11:27 AM, Michael S. Tsirkin <mst@redhat.com> wrote:

>> I'm not sure why you would need a feature bit. The capability is
>> controlled via PCI configuration space. If it is present the device
>> has the capability. If it is not then it does not.
>>
>> Basically if the PCI configuration space is not present then the sysfs
>> entries will not be spawned and nothing will attempt to use this
>> function.
>>
>> - ALex
>
> It's about compability with older guests which ignore the
> capability.
>
> The feature is thus helpful so host knows whether guest supports VFs.

This is not about a guest creating its own VFs. This is about a host PF  
that happens to have a virtio interface to be able to create virtio VFs  
that can be assigned to guests. Nothing changes at all from a guest  
perspective. Or maybe I am not understanding what you mean by "whether  
guest supports VFs".

--
Mark Rustad, Networking Division, Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 873 bytes
Desc: Message signed with OpenPGP
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20180403/fe140733/attachment.sig>
