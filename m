From: keith.busch@intel.com (Keith Busch)
Date: Thu, 2 May 2019 06:57:23 -0600
Subject: [PATCH 0/4] nvme-pci: support device coredump
In-Reply-To: <1556787561-5113-1-git-send-email-akinobu.mita@gmail.com>
References: <1556787561-5113-1-git-send-email-akinobu.mita@gmail.com>
Message-ID: <20190502125722.GA28470@localhost.localdomain>

On Thu, May 02, 2019@05:59:17PM +0900, Akinobu Mita wrote:
> This enables to capture snapshot of controller information via device
> coredump machanism, and it helps diagnose and debug issues.
> 
> The nvme device coredump is triggered before resetting the controller
> caused by I/O timeout, and creates the following coredump files.
> 
> - regs: NVMe controller registers, including each I/O queue doorbell
>         registers, in nvme-show-regs style text format.

You're supposed to treat queue doorbells as write-only. Spec says:

  The host should not read the doorbell registers. If a doorbell register
  is read, the value returned is vendor specific.
