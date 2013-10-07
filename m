From: tj@kernel.org (Tejun Heo)
Date: Mon, 7 Oct 2013 14:10:43 -0400
Subject: [PATCH RFC 05/77] PCI/MSI: Convert pci_msix_table_size() to a
 public interface
In-Reply-To: <e8b51bd48c24d0fc4ee8adea5c138c9bf84191e9.1380703262.git.agordeev@redhat.com>
References: <cover.1380703262.git.agordeev@redhat.com>
 <e8b51bd48c24d0fc4ee8adea5c138c9bf84191e9.1380703262.git.agordeev@redhat.com>
Message-ID: <20131007181043.GA27396@htj.dyndns.org>

Hello,

On Wed, Oct 02, 2013@12:48:21PM +0200, Alexander Gordeev wrote:
> Make pci_msix_table_size() to return a error code if the device
> does not support MSI-X. This update is needed to facilitate a
> forthcoming re-design MSI/MSI-X interrupts enabling pattern.
> 
> Device drivers will use this interface to obtain maximum number
> of MSI-X interrupts the device supports and use that value in
> the following call to pci_enable_msix() interface.
> 
> Signed-off-by: Alexander Gordeev <agordeev at redhat.com>

Hmmm... I probably missed something but why is this necessary?  To
discern between -EINVAL and -ENOSPC?  If so, does that really matter?

Thanks.

-- 
tejun
