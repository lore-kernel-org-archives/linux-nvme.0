From: keith.busch@intel.com (Keith Busch)
Date: Tue, 6 Feb 2018 10:15:50 -0700
Subject: [PATCH]nvme-pci: Fixes EEH failure on ppc
In-Reply-To: <0cc8ee246d548b5bf2b397591419e7b6@linux.vnet.ibm.com>
References: <1517867380-18790-1-git-send-email-wenxiong@vmlinux.vnet.ibm.com>
 <20180206163347.GG31110@localhost.localdomain>
 <d2ea54c017d9954e4f3d4cf80040867d@linux.vnet.ibm.com>
 <20180206170200.GA658@localhost.localdomain>
 <0cc8ee246d548b5bf2b397591419e7b6@linux.vnet.ibm.com>
Message-ID: <20180206171550.GA764@localhost.localdomain>

On Tue, Feb 06, 2018@11:08:14AM -0600, wenxiong wrote:
> 
> Powerpc kernel code/nvme driver eeh callback functions are  going to recover
> it at this point.

Are these using the registered pci_err_handler callbacks? If so, it
may be okay to return NOT_HANDLED from the timeout handler.
