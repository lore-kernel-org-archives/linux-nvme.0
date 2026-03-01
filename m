Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03581FD0066
	for <linux-nvme@archiver.kernel.org>; Sun,  1 Mar 2026 13:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wzBKO8Ieo7nPFwdBGUnOkv7cSuhvOm9gE/AchyqePVg=; b=u54IJYzetsXXMFQevou70mAnkO
	T5gbMr1ckdXp4WV0cFcYR36+CZ3PvTFx13lP6xkFsLFdyqD2V0S5OyDJ/VnwWjsCsb0R7xvCSyBlV
	kIbl7belnVKS9XqK6DyPYMxuKlhufAG9B87uR38gIDzB4zUckvG0drGYEDbzaYwj3k1B9FzVjGIK3
	SFnT7FYRCuGeclQ7FuwyAR8CyqOl12zMMLZxzd1oVsAwNAwdi2ICYPlT9rVhrztyHPOBgKG2jVHsz
	mNclOkg98u5mKzg9zgMKGgYO4FYA3yQUc4meSZRlnkcx+oX3aiZImbLk88QkSF9SNPr4m/21n8ga8
	xysjZ89A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwgzL-0000000BX9X-01IZ;
	Sun, 01 Mar 2026 13:37:39 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwgyI-0000000BWQL-292q
	for linux-nvme@lists.infradead.org;
	Sun, 01 Mar 2026 13:36:36 +0000
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id 3f25c63a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sun, 1 Mar 2026 14:36:29 +0100 (CET)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 01 Mar 2026 14:36:29 +0100
Message-Id: <DGRHI7H6BTSG.12V7ZG8WJGOVB@bsdbackstore.eu>
Subject: Re: [BUG] NVMe: Discard timeout/hang on a801 during mkfs
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
To: "Sune Brian" <briansune@gmail.com>, <linux-nvme@lists.infradead.org>
X-Mailer: aerc 0.20.0
References: <CAN7C2SCFgVzj+Jr8kc1ySLH9KAPjGFN8XTEKQjvefEVyRT9K5w@mail.gmail.com>
In-Reply-To: <CAN7C2SCFgVzj+Jr8kc1ySLH9KAPjGFN8XTEKQjvefEVyRT9K5w@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260301_053634_922155_587390BE 
X-CRM114-Status: GOOD (  10.96  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sat Feb 28, 2026 at 1:22 PM CET, Sune Brian wrote:
> Issue: A fresh NVMe is format below instructions
> always result in series of "opcode # (Write) QID 1 timeout"
> While normal mount and read write shows no stall
> or hang.
>
> dmesg log is placed at the end.
>
> During testing it shows that DRAM-less NVMe will result in
> timeout but DRAM NVMe does not.
>
> Please maintainers help to see if there are any possible
> causes that could remove these possible PCIe reset.
>
> Test Kernel: 6.12.33-g3234b1ed8956-dirty
> CPU: ARM7l

I am not sure from where this kernel comes from but a search on google
hints to the Altera FPGA github tree
Is this the Altera's kernel?

I looked at their 6.12 LTS branch
https://github.com/altera-fpga/linux-socfpga/blob/socfpga-6.12.43-lts/drive=
rs/nvme/host/pci.c

And they miss a patch that fixes some problems with I/O timeouts in
the nvme-pci driver.

https://lore.kernel.org/linux-nvme/CABXGCsMd_xv8jPDF_sFYhwd8GtANZ23nbaSJuCx=
QRO7cjPtgWg@mail.gmail.com/

https://lore.kernel.org/linux-nvme/20250331162859.1407725-1-mlombard@redhat=
.com/

Maurizio

>
> 1) sudo wipefs -a /dev/nvme0n1
>
> /dev/nvme0n1: 8 bytes were erased at offset 0x00000200 (gpt): 45 46 49
> 20 50 41 52 54
> /dev/nvme0n1: 8 bytes were erased at offset 0x1dcf855e00 (gpt): 45 46
> 49 20 50 41 52 54
> /dev/nvme0n1: 2 bytes were erased at offset 0x000001fe (PMBR): 55 a
>
> 2) sudo fdisk /dev/nvme0n1
> g
> n
>
> w
>
> 3) sudo mkfs.ext4 /dev/nvme0n1p1
>
> mke2fs 1.47.2 (1-Jan-2025)
> Discarding device blocks: done
> Creating filesystem with 31258368 4k blocks and 7815168 inodes
> Filesystem UUID: 8f469cc5-d6e1-4606-bfda-869806245d9f
> Superblock backups stored on blocks:
>         32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 26=
54208,
>         4096000, 7962624, 11239424, 20480000, 23887872
>
> Allocating group tables: done
> Writing inode tables: done
> Creating journal (131072 blocks):
> done
> Writing superblocks and filesystem accounting information: done
>
> Thanks,
> Brian
>
>
>
> [  367.247264] nvme nvme0: I/O tag 516 (b204) opcode 0x1 (Write) QID 1
> timeout, aborting req_op:WRITE(1) size:524288
> [  367.247340] nvme nvme0: I/O tag 517 (e205) opcode 0x1 (Write) QID 1
> timeout, aborting req_op:WRITE(1) size:524288
> [  367.247416] nvme nvme0: I/O tag 518 (a206) opcode 0x1 (Write) QID 1
> timeout, aborting req_op:WRITE(1) size:524288
> [  367.247490] nvme nvme0: I/O tag 519 (8207) opcode 0x1 (Write) QID 1
> timeout, aborting req_op:WRITE(1) size:524288
> [  367.259566] nvme nvme0: Abort status: 0x0
> [  367.259969] nvme nvme0: Abort status: 0x0
> [  367.260387] nvme nvme0: Abort status: 0x0
> [  367.260796] nvme nvme0: Abort status: 0x0
> [  367.261216] nvme nvme0: Abort status: 0x0
> [  367.261632] nvme nvme0: Abort status: 0x0
> [  367.262054] nvme nvme0: Abort status: 0x0
> [  367.262466] nvme nvme0: Abort status: 0x0
> [  397.326988] nvme nvme0: I/O tag 512 (1200) opcode 0x1 (Write) QID 1
> timeout, reset controller
> [  397.572037] nvme nvme0: D3 entry latency set to 8 seconds
> [  397.879485] nvme nvme0: 2/0/0 default/read/poll queues
> [  428.695589] nvme nvme0: I/O tag 800 (a320) opcode 0x1 (Write) QID 2
> timeout, aborting req_op:WRITE(1) size:524288
> [  428.695656] nvme nvme0: I/O tag 801 (b321) opcode 0x1 (Write) QID 2
> timeout, aborting req_op:WRITE(1) size:524288
> [  428.695736] nvme nvme0: I/O tag 802 (b322) opcode 0x1 (Write) QID 2
> timeout, aborting req_op:WRITE(1) size:524288
> [  428.695811] nvme nvme0: I/O tag 803 (a323) opcode 0x1 (Write) QID 2
> timeout, aborting req_op:WRITE(1) size:524288
> [  428.695888] nvme nvme0: I/O tag 804 (a324) opcode 0x1 (Write) QID 2
> timeout, aborting req_op:WRITE(1) size:524288
> [  428.695964] nvme nvme0: I/O tag 805 (a325) opcode 0x1 (Write) QID 2
> timeout, aborting req_op:WRITE(1) size:524288
> [  428.696040] nvme nvme0: I/O tag 806 (a326) opcode 0x1 (Write) QID 2
> timeout, aborting req_op:WRITE(1) size:524288
> [  428.696115] nvme nvme0: I/O tag 807 (a327) opcode 0x1 (Write) QID 2
> timeout, aborting req_op:WRITE(1) size:524288
> [  428.707945] nvme nvme0: Abort status: 0x0
> [  428.708342] nvme nvme0: Abort status: 0x0
> [  428.708761] nvme nvme0: Abort status: 0x0
> [  428.709173] nvme nvme0: Abort status: 0x0
> [  428.709588] nvme nvme0: Abort status: 0x0
> [  428.710009] nvme nvme0: Abort status: 0x0
> [  428.710420] nvme nvme0: Abort status: 0x0
> [  428.710836] nvme nvme0: Abort status: 0x0
> [  458.775585] nvme nvme0: I/O tag 800 (a320) opcode 0x1 (Write) QID 2
> timeout, reset controller
> [  458.881506] nvme nvme0: D3 entry latency set to 8 seconds
> [  459.188996] nvme nvme0: 2/0/0 default/read/poll queues
> [  490.135562] nvme nvme0: I/O tag 864 (3360) opcode 0x1 (Write) QID 2
> timeout, aborting req_op:WRITE(1) size:524288
> [  490.135621] nvme nvme0: I/O tag 865 (3361) opcode 0x1 (Write) QID 2
> timeout, aborting req_op:WRITE(1) size:524288
> [  490.135700] nvme nvme0: I/O tag 866 (3362) opcode 0x1 (Write) QID 2
> timeout, aborting req_op:WRITE(1) size:524288
> [  490.135776] nvme nvme0: I/O tag 867 (3363) opcode 0x1 (Write) QID 2
> timeout, aborting req_op:WRITE(1) size:524288
> [  490.135851] nvme nvme0: I/O tag 868 (3364) opcode 0x1 (Write) QID 2
> timeout, aborting req_op:WRITE(1) size:524288
> [  490.135926] nvme nvme0: I/O tag 869 (3365) opcode 0x1 (Write) QID 2
> timeout, aborting req_op:WRITE(1) size:524288
> [  490.136002] nvme nvme0: I/O tag 870 (3366) opcode 0x1 (Write) QID 2
> timeout, aborting req_op:WRITE(1) size:524288
> [  490.136078] nvme nvme0: I/O tag 871 (3367) opcode 0x1 (Write) QID 2
> timeout, aborting req_op:WRITE(1) size:524288
> [  490.148114] nvme nvme0: Abort status: 0x0
> [  490.148514] nvme nvme0: Abort status: 0x0
> [  490.148928] nvme nvme0: Abort status: 0x0
> [  490.149343] nvme nvme0: Abort status: 0x0
> [  490.149759] nvme nvme0: Abort status: 0x0
> [  490.150174] nvme nvme0: Abort status: 0x0
> [  490.150589] nvme nvme0: Abort status: 0x0
> [  490.151007] nvme nvme0: Abort status: 0x0
> [  520.216470] nvme nvme0: I/O tag 864 (3360) opcode 0x1 (Write) QID 2
> timeout, reset controller
> [  520.321547] nvme nvme0: D3 entry latency set to 8 seconds
> [  520.628957] nvme nvme0: 2/0/0 default/read/poll queues
> [  551.565560] nvme nvme0: I/O tag 0 (3000) opcode 0x1 (Write) QID 2
> timeout, aborting req_op:WRITE(1) size:524288
> [  551.565619] nvme nvme0: I/O tag 1 (3001) opcode 0x1 (Write) QID 2
> timeout, aborting req_op:WRITE(1) size:524288
> [  551.565698] nvme nvme0: I/O tag 2 (3002) opcode 0x1 (Write) QID 2
> timeout, aborting req_op:WRITE(1) size:524288
> [  551.565775] nvme nvme0: I/O tag 3 (3003) opcode 0x1 (Write) QID 2
> timeout, aborting req_op:WRITE(1) size:524288
> [  551.565852] nvme nvme0: I/O tag 4 (3004) opcode 0x1 (Write) QID 2
> timeout, aborting req_op:WRITE(1) size:524288
> [  551.565927] nvme nvme0: I/O tag 5 (3005) opcode 0x1 (Write) QID 2
> timeout, aborting req_op:WRITE(1) size:524288
> [  551.566003] nvme nvme0: I/O tag 6 (3006) opcode 0x1 (Write) QID 2
> timeout, aborting req_op:WRITE(1) size:524288
> [  551.566077] nvme nvme0: I/O tag 7 (3007) opcode 0x1 (Write) QID 2
> timeout, aborting req_op:WRITE(1) size:524288
> [  551.577697] nvme nvme0: Abort status: 0x0
> [  551.578098] nvme nvme0: Abort status: 0x0
> [  551.578512] nvme nvme0: Abort status: 0x0
> [  551.578928] nvme nvme0: Abort status: 0x0
> [  551.579344] nvme nvme0: Abort status: 0x0
> [  551.579763] nvme nvme0: Abort status: 0x0
> [  551.580178] nvme nvme0: Abort status: 0x0
> [  551.580592] nvme nvme0: Abort status: 0x0
> [  581.645586] nvme nvme0: I/O tag 0 (3000) opcode 0x1 (Write) QID 2
> timeout, reset controller
> [  581.751551] nvme nvme0: D3 entry latency set to 8 seconds
> [  582.059055] nvme nvme0: 2/0/0 default/read/poll queues
> [  659.631514] EXT4-fs (nvme0n1p1): mounted filesystem
> ab5af757-02ef-464d-9a18-550553079e1a r/w with ordered data mode. Quota
> mode: disabled.
> [  669.859862] EXT4-fs (nvme0n1p1): unmounting filesystem
> ab5af757-02ef-464d-9a18-550553079e1a.
> [  714.126451] nvme nvme0: I/O tag 672 (12a0) opcode 0x1 (Write) QID 1
> timeout, aborting req_op:WRITE(1) size:524288
> [  714.126511] nvme nvme0: I/O tag 673 (52a1) opcode 0x1 (Write) QID 1
> timeout, aborting req_op:WRITE(1) size:524288
> [  714.126590] nvme nvme0: I/O tag 674 (52a2) opcode 0x1 (Write) QID 1
> timeout, aborting req_op:WRITE(1) size:524288
> [  714.126666] nvme nvme0: I/O tag 675 (32a3) opcode 0x1 (Write) QID 1
> timeout, aborting req_op:WRITE(1) size:524288
> [  714.126742] nvme nvme0: I/O tag 676 (52a4) opcode 0x1 (Write) QID 1
> timeout, aborting req_op:WRITE(1) size:524288
> [  714.126818] nvme nvme0: I/O tag 677 (42a5) opcode 0x1 (Write) QID 1
> timeout, aborting req_op:WRITE(1) size:524288
> [  714.126892] nvme nvme0: I/O tag 678 (a2a6) opcode 0x1 (Write) QID 1
> timeout, aborting req_op:WRITE(1) size:524288
> [  714.126968] nvme nvme0: I/O tag 679 (52a7) opcode 0x1 (Write) QID 1
> timeout, aborting req_op:WRITE(1) size:524288
> [  714.138481] nvme nvme0: Abort status: 0x0
> [  714.138891] nvme nvme0: Abort status: 0x0
> [  714.139306] nvme nvme0: Abort status: 0x0
> [  714.139718] nvme nvme0: Abort status: 0x0
> [  714.140133] nvme nvme0: Abort status: 0x0
> [  714.140554] nvme nvme0: Abort status: 0x0
> [  714.140970] nvme nvme0: Abort status: 0x0
> [  714.141381] nvme nvme0: Abort status: 0x0
> [  718.766519] nvme nvme0: I/O tag 832 (0340) opcode 0x1 (Write) QID 1
> timeout, aborting req_op:WRITE(1) size:4096
> [  718.766585] nvme nvme0: I/O tag 833 (0341) opcode 0x1 (Write) QID 1
> timeout, aborting req_op:WRITE(1) size:4096
> [  718.766665] nvme nvme0: I/O tag 834 (0342) opcode 0x1 (Write) QID 1
> timeout, aborting req_op:WRITE(1) size:4096
> [  718.766741] nvme nvme0: I/O tag 835 (0343) opcode 0x1 (Write) QID 1
> timeout, aborting req_op:WRITE(1) size:4096
> [  718.766816] nvme nvme0: I/O tag 836 (0344) opcode 0x1 (Write) QID 1
> timeout, aborting req_op:WRITE(1) size:4096
> [  718.766891] nvme nvme0: I/O tag 837 (0345) opcode 0x1 (Write) QID 1
> timeout, aborting req_op:WRITE(1) size:4096
> [  718.766966] nvme nvme0: I/O tag 838 (0346) opcode 0x1 (Write) QID 1
> timeout, aborting req_op:WRITE(1) size:4096
> [  718.767041] nvme nvme0: I/O tag 839 (0347) opcode 0x1 (Write) QID 1
> timeout, aborting req_op:WRITE(1) size:4096
> [  718.779019] nvme nvme0: Abort status: 0x0
> [  718.779423] nvme nvme0: Abort status: 0x0
> [  718.779842] nvme nvme0: Abort status: 0x0
> [  718.780260] nvme nvme0: Abort status: 0x0
> [  718.780676] nvme nvme0: Abort status: 0x0
> [  718.781090] nvme nvme0: Abort status: 0x0
> [  718.781505] nvme nvme0: Abort status: 0x0
> [  718.781923] nvme nvme0: Abort status: 0x0
> [  744.206471] nvme nvme0: I/O tag 672 (12a0) opcode 0x1 (Write) QID 1
> timeout, reset controller
> [  744.301696] nvme nvme0: D3 entry latency set to 8 seconds
> [  744.609090] nvme nvme0: 2/0/0 default/read/poll queues
> [  775.575584] nvme nvme0: I/O tag 800 (5320) opcode 0x1 (Write) QID 1
> timeout, aborting req_op:WRITE(1) size:524288
> [  775.575656] nvme nvme0: I/O tag 801 (5321) opcode 0x1 (Write) QID 1
> timeout, aborting req_op:WRITE(1) size:524288
> [  775.575735] nvme nvme0: I/O tag 805 (4325) opcode 0x1 (Write) QID 1
> timeout, aborting req_op:WRITE(1) size:524288
> [  775.575813] nvme nvme0: I/O tag 811 (332b) opcode 0x1 (Write) QID 1
> timeout, aborting req_op:WRITE(1) size:524288
> [  775.575889] nvme nvme0: I/O tag 812 (332c) opcode 0x1 (Write) QID 1
> timeout, aborting req_op:WRITE(1) size:524288
> [  775.575965] nvme nvme0: I/O tag 813 (332d) opcode 0x1 (Write) QID 1
> timeout, aborting req_op:WRITE(1) size:524288
> [  775.576039] nvme nvme0: I/O tag 814 (332e) opcode 0x1 (Write) QID 1
> timeout, aborting req_op:WRITE(1) size:524288
> [  775.576114] nvme nvme0: I/O tag 826 (233a) opcode 0x1 (Write) QID 1
> timeout, aborting req_op:WRITE(1) size:524288
> [  775.587809] nvme nvme0: Abort status: 0x0
> [  775.588213] nvme nvme0: Abort status: 0x0
> [  775.588628] nvme nvme0: Abort status: 0x0
> [  775.589046] nvme nvme0: Abort status: 0x0
> [  775.589462] nvme nvme0: Abort status: 0x0
> [  775.589879] nvme nvme0: Abort status: 0x0
> [  775.590298] nvme nvme0: Abort status: 0x0
> [  775.590714] nvme nvme0: Abort status: 0x0
> [  805.655581] nvme nvme0: I/O tag 800 (5320) opcode 0x1 (Write) QID 1
> timeout, reset controller
> [  805.760937] nvme nvme0: D3 entry latency set to 8 seconds
> [  806.068328] nvme nvme0: 2/0/0 default/read/poll queues
> [  836.375584] nvme nvme0: I/O tag 864 (6360) opcode 0x1 (Write) QID 1
> timeout, aborting req_op:WRITE(1) size:524288
> [  836.375655] nvme nvme0: I/O tag 865 (5361) opcode 0x1 (Write) QID 1
> timeout, aborting req_op:WRITE(1) size:524288
> [  836.375735] nvme nvme0: I/O tag 869 (4365) opcode 0x1 (Write) QID 1
> timeout, aborting req_op:WRITE(1) size:524288
> [  836.375811] nvme nvme0: I/O tag 875 (336b) opcode 0x1 (Write) QID 1
> timeout, aborting req_op:WRITE(1) size:524288
> [  836.375887] nvme nvme0: I/O tag 876 (336c) opcode 0x1 (Write) QID 1
> timeout, aborting req_op:WRITE(1) size:524288
> [  836.375962] nvme nvme0: I/O tag 877 (336d) opcode 0x1 (Write) QID 1
> timeout, aborting req_op:WRITE(1) size:524288
> [  836.376038] nvme nvme0: I/O tag 878 (236e) opcode 0x1 (Write) QID 1
> timeout, aborting req_op:WRITE(1) size:524288
> [  836.376115] nvme nvme0: I/O tag 890 (137a) opcode 0x1 (Write) QID 1
> timeout, aborting req_op:WRITE(1) size:524288
> [  836.388465] nvme nvme0: Abort status: 0x0
> [  836.388866] nvme nvme0: Abort status: 0x0
> [  836.389283] nvme nvme0: Abort status: 0x0
> [  836.389700] nvme nvme0: Abort status: 0x0
> [  836.390117] nvme nvme0: Abort status: 0x0
> [  836.390533] nvme nvme0: Abort status: 0x0
> [  836.390948] nvme nvme0: Abort status: 0x0
> [  836.391363] nvme nvme0: Abort status: 0x0
> [  866.455585] nvme nvme0: I/O tag 864 (6360) opcode 0x1 (Write) QID 1
> timeout, reset controller
> [  866.560911] nvme nvme0: D3 entry latency set to 8 seconds
> [  866.868300] nvme nvme0: 2/0/0 default/read/poll queues
> [  897.176461] nvme nvme0: I/O tag 930 (63a2) opcode 0x1 (Write) QID 1
> timeout, aborting req_op:WRITE(1) size:524288
> [  897.176524] nvme nvme0: I/O tag 936 (33a8) opcode 0x1 (Write) QID 1
> timeout, aborting req_op:WRITE(1) size:524288
> [  897.176602] nvme nvme0: I/O tag 937 (33a9) opcode 0x1 (Write) QID 1
> timeout, aborting req_op:WRITE(1) size:524288
> [  897.176680] nvme nvme0: I/O tag 938 (33aa) opcode 0x1 (Write) QID 1
> timeout, aborting req_op:WRITE(1) size:524288
> [  897.176756] nvme nvme0: I/O tag 950 (13b6) opcode 0x1 (Write) QID 1
> timeout, aborting req_op:WRITE(1) size:524288
> [  897.176832] nvme nvme0: I/O tag 951 (13b7) opcode 0x1 (Write) QID 1
> timeout, aborting req_op:WRITE(1) size:524288
> [  897.176907] nvme nvme0: I/O tag 952 (13b8) opcode 0x1 (Write) QID 1
> timeout, aborting req_op:WRITE(1) size:524288
> [  897.176981] nvme nvme0: I/O tag 953 (13b9) opcode 0x1 (Write) QID 1
> timeout, aborting req_op:WRITE(1) size:524288
> [  897.188976] nvme nvme0: Abort status: 0x0
> [  897.189374] nvme nvme0: Abort status: 0x0
> [  897.189787] nvme nvme0: Abort status: 0x0
> [  897.190204] nvme nvme0: Abort status: 0x0
> [  897.190621] nvme nvme0: Abort status: 0x0
> [  897.191037] nvme nvme0: Abort status: 0x0
> [  897.191455] nvme nvme0: Abort status: 0x0
> [  897.191870] nvme nvme0: Abort status: 0x0
> [  897.225585] nvme nvme0: I/O tag 928 (a3a0) opcode 0x1 (Write) QID 1
> timeout, aborting req_op:WRITE(1) size:524288
> [  897.225642] nvme nvme0: I/O tag 931 (63a3) opcode 0x1 (Write) QID 1
> timeout, aborting req_op:WRITE(1) size:524288
> [  897.225677] nvme nvme0: I/O tag 932 (63a4) opcode 0x1 (Write) QID 1
> timeout, aborting req_op:WRITE(1) size:524288
> [  897.225712] nvme nvme0: I/O tag 939 (33ab) opcode 0x1 (Write) QID 1
> timeout, aborting req_op:WRITE(1) size:524288
> [  897.225742] nvme nvme0: I/O tag 940 (23ac) opcode 0x1 (Write) QID 1
> timeout, aborting req_op:WRITE(1) size:524288
> [  897.225773] nvme nvme0: I/O tag 941 (23ad) opcode 0x1 (Write) QID 1
> timeout, aborting req_op:WRITE(1) size:524288
> [  897.225805] nvme nvme0: I/O tag 942 (23ae) opcode 0x1 (Write) QID 1
> timeout, aborting req_op:WRITE(1) size:524288
> [  897.225835] nvme nvme0: I/O tag 943 (23af) opcode 0x1 (Write) QID 1
> timeout, aborting req_op:WRITE(1) size:524288
> [  897.230852] nvme nvme0: Abort status: 0x0
> [  897.231671] nvme nvme0: Abort status: 0x0
> [  897.232087] nvme nvme0: Abort status: 0x0
> [  897.232505] nvme nvme0: Abort status: 0x0
> [  897.232921] nvme nvme0: Abort status: 0x0
> [  897.233338] nvme nvme0: Abort status: 0x0
> [  897.233754] nvme nvme0: Abort status: 0x0
> [  897.234169] nvme nvme0: Abort status: 0x0
> [  897.276483] nvme nvme0: I/O tag 929 (73a1) opcode 0x1 (Write) QID 1
> timeout, aborting req_op:WRITE(1) size:524288
> [  897.276539] nvme nvme0: I/O tag 933 (43a5) opcode 0x1 (Write) QID 1
> timeout, aborting req_op:WRITE(1) size:524288
> [  897.276574] nvme nvme0: I/O tag 934 (43a6) opcode 0x1 (Write) QID 1
> timeout, aborting req_op:WRITE(1) size:524288
> [  897.276611] nvme nvme0: I/O tag 944 (23b0) opcode 0x1 (Write) QID 1
> timeout, aborting req_op:WRITE(1) size:524288
> [  897.276642] nvme nvme0: I/O tag 945 (23b1) opcode 0x1 (Write) QID 1
> timeout, aborting req_op:WRITE(1) size:524288
> [  897.276673] nvme nvme0: I/O tag 946 (23b2) opcode 0x1 (Write) QID 1
> timeout, aborting req_op:WRITE(1) size:524288
> [  897.276704] nvme nvme0: I/O tag 947 (23b3) opcode 0x1 (Write) QID 1
> timeout, aborting req_op:WRITE(1) size:524288
> [  897.276749] nvme nvme0: I/O tag 973 (13cd) opcode 0x1 (Write) QID 1
> timeout, aborting req_op:WRITE(1) size:524288
> [  897.281687] nvme nvme0: Abort status: 0x0
> [  897.282507] nvme nvme0: Abort status: 0x0
> [  897.282922] nvme nvme0: Abort status: 0x0
> [  897.283338] nvme nvme0: Abort status: 0x0
> [  897.283754] nvme nvme0: Abort status: 0x0
> [  897.284169] nvme nvme0: Abort status: 0x0
> [  897.284587] nvme nvme0: Abort status: 0x0
> [  897.285003] nvme nvme0: Abort status: 0x0
> [  897.325590] nvme nvme0: I/O tag 935 (43a7) opcode 0x1 (Write) QID 1
> timeout, aborting req_op:WRITE(1) size:524288
> [  897.325653] nvme nvme0: I/O tag 948 (23b4) opcode 0x1 (Write) QID 1
> timeout, aborting req_op:WRITE(1) size:524288
> [  897.325688] nvme nvme0: I/O tag 949 (23b5) opcode 0x1 (Write) QID 1
> timeout, aborting req_op:WRITE(1) size:524288
> [  897.325738] nvme nvme0: I/O tag 986 (13da) opcode 0x1 (Write) QID 1
> timeout, aborting req_op:WRITE(1) size:524288
> [  897.325770] nvme nvme0: I/O tag 987 (13db) opcode 0x1 (Write) QID 1
> timeout, aborting req_op:WRITE(1) size:524288
> [  897.325802] nvme nvme0: I/O tag 988 (13dc) opcode 0x1 (Write) QID 1
> timeout, aborting req_op:WRITE(1) size:524288
> [  897.325833] nvme nvme0: I/O tag 989 (13dd) opcode 0x1 (Write) QID 1
> timeout, aborting req_op:WRITE(1) size:524288
> [  897.330302] nvme nvme0: Abort status: 0x0
> [  897.331121] nvme nvme0: Abort status: 0x0
> [  897.331537] nvme nvme0: Abort status: 0x0
> [  897.331953] nvme nvme0: Abort status: 0x0
> [  897.332367] nvme nvme0: Abort status: 0x0
> [  897.332782] nvme nvme0: Abort status: 0x0
> [  897.333197] nvme nvme0: Abort status: 0x0
> [  927.256483] nvme nvme0: I/O tag 930 (63a2) opcode 0x1 (Write) QID 1
> timeout, reset controller
> [  927.351551] nvme nvme0: D3 entry latency set to 8 seconds
> [  927.659098] nvme nvme0: 2/0/0 default/read/poll queues
> [  958.606442] nvme nvme0: I/O tag 64 (5040) opcode 0x1 (Write) QID 1
> timeout, aborting req_op:WRITE(1) size:524288
> [  958.606502] nvme nvme0: I/O tag 65 (5041) opcode 0x1 (Write) QID 1
> timeout, aborting req_op:WRITE(1) size:524288
> [  958.606582] nvme nvme0: I/O tag 66 (4042) opcode 0x1 (Write) QID 1
> timeout, aborting req_op:WRITE(1) size:524288
> [  958.606658] nvme nvme0: I/O tag 67 (4043) opcode 0x1 (Write) QID 1
> timeout, aborting req_op:WRITE(1) size:524288
> [  958.606735] nvme nvme0: I/O tag 68 (3044) opcode 0x1 (Write) QID 1
> timeout, aborting req_op:WRITE(1) size:524288
> [  958.606810] nvme nvme0: I/O tag 69 (3045) opcode 0x1 (Write) QID 1
> timeout, aborting req_op:WRITE(1) size:524288
> [  958.606886] nvme nvme0: I/O tag 70 (3046) opcode 0x1 (Write) QID 1
> timeout, aborting req_op:WRITE(1) size:524288
> [  958.606963] nvme nvme0: I/O tag 72 (2048) opcode 0x1 (Write) QID 1
> timeout, aborting req_op:WRITE(1) size:524288
> [  958.619373] nvme nvme0: Abort status: 0x0
> [  958.619787] nvme nvme0: Abort status: 0x0
> [  958.620199] nvme nvme0: Abort status: 0x0
> [  958.620616] nvme nvme0: Abort status: 0x0
> [  958.621036] nvme nvme0: Abort status: 0x0
> [  958.621447] nvme nvme0: Abort status: 0x0
> [  958.621865] nvme nvme0: Abort status: 0x0
> [  958.622280] nvme nvme0: Abort status: 0x0
> [  988.686467] nvme nvme0: I/O tag 64 (5040) opcode 0x1 (Write) QID 1
> timeout, reset controller
> [  988.781537] nvme nvme0: D3 entry latency set to 8 seconds
> [  989.089011] nvme nvme0: 2/0/0 default/read/poll queues


