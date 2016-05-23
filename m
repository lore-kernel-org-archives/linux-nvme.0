From: keith.busch@intel.com (Keith Busch)
Date: Mon, 23 May 2016 13:21:44 -0400
Subject: [PATCH 2/2] nvme/pci: Enable SR-IOV capabilities
In-Reply-To: <20160523170652.GA12826@localhost>
References: <1463521199-16604-1-git-send-email-keith.busch@intel.com>
 <1463521199-16604-2-git-send-email-keith.busch@intel.com>
 <20160523170652.GA12826@localhost>
Message-ID: <20160523172144.GD17208@localhost.localdomain>

On Mon, May 23, 2016@12:06:52PM -0500, Bjorn Helgaas wrote:
> I do not subscribe to the belief that every function should have a
> single exit.  In this case, I think it makes the function much harder
> to understand than this:

No problem with multiple exists. 
 
>   if (numvfs == 0)
>     pci_disable_sriov(pdev);
>     return 0;
>   }
> 
>   return pci_enable_sriov(pdev, numvfs);

Slight change to the above: pci_enable_sriov returns 0 on success,
but a driver's .sriov_configure is supposed to return the number of
VF's successfully configured, so need to return 'numvfs' on success.
