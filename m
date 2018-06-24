From: Golden_Miller83@protonmail.ch (Jordan Glover)
Date: Sun, 24 Jun 2018 18:06:41 -0400
Subject: [4.18-rc2 regression] WARNING: CPU: 0 PID: 1 at
 drivers/nvme/host/pci.c:2570 nvme_probe+0x212/0x440
In-Reply-To: <20180624211520.GA16559@sbauer-Z170X-UD5>
References: <Y7NwNf_cB9KfO8DYYkrQt_o4SQ6oFpyHC4ALTdU8K-1rKTpeY7zlAkEhN8mWm30q7cJTVBGDVqfJ65JvkV14hbUFcXQkwQ7CsrloyrFvglw=@protonmail.ch>
 <20180624211520.GA16559@sbauer-Z170X-UD5>
Message-ID: <tRUGFtw_8KFYLF98YCf0vYYQagRWk-ZNXonQVla7xXvTgMCb7Z2kDM0ocI1O8Nhhbqn-oBlVNM8ue3TABpo3PqIA-_B_lhhceT4dPFGrSd0=@protonmail.ch>

On June 24, 2018 11:15 PM, Scott Bauer <scott.bauer@intel.com> wrote:

> On Sun, Jun 24, 2018@04:37:35PM -0400, Jordan Glover wrote:
> 
> > Hello,
> > 
> > After update to Linux 4.18-rc2 I see the following warning at every boot.
> > 
> > It doesn't occur on Linux 4.18-rc1.
> > 
> > WARNING: CPU: 0 PID: 1 at drivers/nvme/host/pci.c:2570 nvme_probe+0x212/0x440
> > 
> > Modules linked in:
> 
> I suspect that you have CONFIG_DEBUG_SG and CONFIG_NEED_SG_DMA_LENGTH set, can you
> 
> confirm for us please?

Yes, I have both of them enabled.

Jordan
