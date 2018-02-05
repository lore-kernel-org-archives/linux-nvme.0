From: sbauer@eng.utah.edu (Scotty Bauer)
Date: Mon, 05 Feb 2018 11:44:46 -0700
Subject: Unsafe shutdowns on TOSHIBA THNSF5256GPUK NVME
In-Reply-To: <7QlrLlBcNh77StPeNNrcSdPK0A-MIo4tyaJTCCnbjj35h29Z99Gk4vuEX2tdZKnSZQjnoUy4Gl7AHtwsXfGiUNp9fVQgdHHX60bd8VSlmOk=@protonmail.ch>
References: <7QlrLlBcNh77StPeNNrcSdPK0A-MIo4tyaJTCCnbjj35h29Z99Gk4vuEX2tdZKnSZQjnoUy4Gl7AHtwsXfGiUNp9fVQgdHHX60bd8VSlmOk=@protonmail.ch>
Message-ID: <fd59dd68a60beb42d2aee9f40b6ab48c@eng.utah.edu>

add nvme_core.shutdown_timeout=20 to your kernel boot parameters.



On 2018-02-05 10:01, Jordan Glover wrote:
> Hello,
> 
> I have problem with "unsafe shutdowns" on Lenovo laptop with TOSHIBA
> THNSF5256GPUK NVME disk. It happens every time I power-off my machine 
> and I can
> hear characteristic "click" sound like with rotational disks. (maybe 
> that's
> something else but I'm basing on info from S.M.A.R.T data not this).
> 
> I looked around and saw that people report similar problems in 
> different NVME
> disks[1][2], even across different OSes[3][4]. I also found some old 
> patches
> witch tried to deal with this[5].
> 
> I know that my disk was already put on $hitlist due to power saving 
> issues[6].
> 
> I tested this with linux kernels 4.14.x - 4.15. My BIOS and disk 
> firmware are
> updated.
> 
> Is there anything I could do to resolve this issue? Thx for any help.
> 
> Jordan
> 
> [1] https://bbs.archlinux.org/viewtopic.php?id=230723
> [2] https://bugs.alpinelinux.org/issues/5082
> [3]https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=211852
> [4]
> https://www.win-raid.com/t2041f38-SAMSUNG-PRO-NVMe-SSD-unsafe-shutdowns-NVMe-driver-W-x-unexpected-shutdown.html
> [5] 
> http://lists.infradead.org/pipermail/linux-nvme/2014-March/000744.html
> [6]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/nvme/host/core.c#n1950
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
