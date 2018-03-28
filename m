From: mark.d.rustad@intel.com (Rustad, Mark D)
Date: Wed, 28 Mar 2018 21:30:29 +0000
Subject: [virtio-dev] [pci PATCH v7 1/5] pci: Add
 pci_sriov_configure_simple for PFs that don't manage VF resources
In-Reply-To: <20180315184055.3102.2435.stgit@localhost.localdomain>
References: <20180315183449.3102.64791.stgit@localhost.localdomain>
 <20180315184055.3102.2435.stgit@localhost.localdomain>
Message-ID: <C573B44F-097F-45D2-AB4C-B8BCCBCC2C4F@intel.com>

On Mar 15, 2018,@11:41 AM, Alexander Duyck <alexander.duyck@gmail.com> wrote:

> From: Alexander Duyck <alexander.h.duyck at intel.com>
> 
> This patch adds a common configuration function called
> pci_sriov_configure_simple that will allow for managing VFs on devices
> where the PF is not capable of managing VF resources.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck at intel.com>
> ---
> 
> v5: New patch replacing pci_sriov_configure_unmanaged with
>       pci_sriov_configure_simple
>     Dropped bits related to autoprobe changes
> v6: Defined pci_sriov_configure_simple as NULL if IOV is disabled
> v7: Updated pci_sriov_configure_simple to drop need for err value
>     Fixed comment explaining why pci_sriov_configure_simple is NULL
> 
>  drivers/pci/iov.c   |   31 +++++++++++++++++++++++++++++++
>  include/linux/pci.h |    3 +++
>  2 files changed, 34 insertions(+)

Tested with the device identified in patch #2.

Tested-by: Mark Rustad <mark.d.rustad at intel.com>

--
Mark Rustad, Networking Division, Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 873 bytes
Desc: Message signed with OpenPGP
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20180328/2014b39a/attachment.sig>
