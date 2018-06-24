From: scott.bauer@intel.com (Scott Bauer)
Date: Sun, 24 Jun 2018 15:15:20 -0600
Subject: [4.18-rc2 regression] WARNING: CPU: 0 PID: 1 at
 drivers/nvme/host/pci.c:2570 nvme_probe+0x212/0x440
In-Reply-To: <Y7NwNf_cB9KfO8DYYkrQt_o4SQ6oFpyHC4ALTdU8K-1rKTpeY7zlAkEhN8mWm30q7cJTVBGDVqfJ65JvkV14hbUFcXQkwQ7CsrloyrFvglw=@protonmail.ch>
References: <Y7NwNf_cB9KfO8DYYkrQt_o4SQ6oFpyHC4ALTdU8K-1rKTpeY7zlAkEhN8mWm30q7cJTVBGDVqfJ65JvkV14hbUFcXQkwQ7CsrloyrFvglw=@protonmail.ch>
Message-ID: <20180624211520.GA16559@sbauer-Z170X-UD5>

On Sun, Jun 24, 2018@04:37:35PM -0400, Jordan Glover wrote:
> 
> Hello, 
> 
> After update to Linux 4.18-rc2 I see the following warning at every boot.
> It doesn't occur on Linux 4.18-rc1.
> 
> WARNING: CPU: 0 PID: 1 at drivers/nvme/host/pci.c:2570 nvme_probe+0x212/0x440
> Modules linked in:

I suspect that you have CONFIG_DEBUG_SG and CONFIG_NEED_SG_DMA_LENGTH set, can you
confirm for us please?
