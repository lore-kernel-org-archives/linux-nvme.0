From: alex.williamson@redhat.com (Alex Williamson)
Date: Sun, 11 Mar 2018 21:59:09 -0600
Subject: [pci PATCH v4 1/4] pci-iov: Add support for unmanaged SR-IOV
In-Reply-To: <20180308190047.5433.77952.stgit@localhost.localdomain>
References: <20180308185507.5433.98830.stgit@localhost.localdomain>
 <20180308190047.5433.77952.stgit@localhost.localdomain>
Message-ID: <20180311215909.16ed4bf1@t450s.home>

On Thu, 08 Mar 2018 11:02:29 -0800
Alexander Duyck <alexander.duyck@gmail.com> wrote:

> From: Alexander Duyck <alexander.h.duyck at intel.com>
> 
> This patch is meant to add some basic functionality to support for SR-IOV
> on devices when the VFs are not managed by some other entity in the device
> other than the kernel.
> 
> A new sysfs value called sriov_unmanaged_autoprobe has been added. This
> value is used as the drivers_autoprobe setting of the VFs when they are
> being managed by an external entity such as device firmware instead of
> being managed by the kernel.
> 
> One side effect of this change is that the sriov_drivers_autoprobe and
> sriov_unmanaged_autoprobe will only apply their updates when SR-IOV VFs
> are allocated. Attempts to update them when SR-IOV is in use will only
> update the local value and will not update sriov->autoprobe.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck at intel.com>
> ---


I still struggle to understand why we need this "unmanaged"
complication and how a user of the sysfs API is expected to have any
idea whether a PF is managed or unmanaged and why they should care.
Can't we just have a pci_simple_sriov_configure() helper and ignore
this unmanaged business?  Thanks,

Alex
