From: mark.d.rustad@intel.com (Rustad, Mark D)
Date: Wed, 28 Mar 2018 21:31:40 +0000
Subject: [pci PATCH v7 2/5] virtio_pci: Add support for unmanaged SR-IOV
 on virtio_pci devices
In-Reply-To: <20180315184132.3102.90947.stgit@localhost.localdomain>
References: <20180315183449.3102.64791.stgit@localhost.localdomain>
 <20180315184132.3102.90947.stgit@localhost.localdomain>
Message-ID: <52734805-4A20-41C0-A46A-A8AFF8D79A72@intel.com>

On Mar 15, 2018,@11:42 AM, Alexander Duyck <alexander.duyck@gmail.com> wrote:

> From: Alexander Duyck <alexander.h.duyck at intel.com>
> 
> Hardware-realized virtio_pci devices can implement SR-IOV, so this
> patch enables its use. The device in question is an upcoming Intel
> NIC that implements both a virtio_net PF and virtio_net VFs. These
> are hardware realizations of what has been up to now been a software
> interface.
> 
> The device in question has the following 4-part PCI IDs:
> 
> PF: vendor: 1af4 device: 1041 subvendor: 8086 subdevice: 15fe
> VF: vendor: 1af4 device: 1041 subvendor: 8086 subdevice: 05fe
> 
> The patch currently needs no check for device ID, because the callback
> will never be made for devices that do not assert the capability or
> when run on a platform incapable of SR-IOV.
> 
> One reason for this patch is because the hardware requires the
> vendor ID of a VF to be the same as the vendor ID of the PF that
> created it. So it seemed logical to simply have a fully-functioning
> virtio_net PF create the VFs. This patch makes that possible.
> 
> Reviewed-by: Christoph Hellwig <hch at lst.de>
> Signed-off-by: Mark Rustad <mark.d.rustad at intel.com>
> Signed-off-by: Alexander Duyck <alexander.h.duyck at intel.com>
> ---
> 
> v4: Dropped call to pci_disable_sriov in virtio_pci_remove function
> v5: Replaced call to pci_sriov_configure_unmanaged with
>         pci_sriov_configure_simple
> v6: Dropped "#ifdef" checks for IOV wrapping sriov_configure definition
> v7: No code change, added Reviewed-by
> 
>  drivers/virtio/virtio_pci_common.c |    1 +
>  1 file changed, 1 insertion(+)

Tested with the identified device.

Tested-by: Mark Rustad <mark.d.rustad at intel.com>

--
Mark Rustad, Networking Division, Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 873 bytes
Desc: Message signed with OpenPGP
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20180328/3b039aae/attachment.sig>
