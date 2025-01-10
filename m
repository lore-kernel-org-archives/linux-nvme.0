Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE011E7719C
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jan 2025 16:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IxTkpTzgi+owaBpYpL+RIc8wy5x1gLPOUY9XqLSBS50=; b=WAiEZCaQaNNIuQ9mquCUtcRbjb
	UP/UUgXQXUDOqFdsR4KEOWzEaLStgKCE5WPi8sM0Fgod7bNN03QaJEqAy7VOcwdZ7r3Xv/JHEDXtO
	x8hwC/84wdVGJNCjoEN23nnwW7EU0mFoZcWBsNTODMrT0f5fmutrHOMiQy4AMv5fAdSCZa3q6Zhee
	1Rl7zWGvYRRhH0ODUa+ldbkyGWZ8FL/DUVaAPHsrs93Y02TNU4OqsuM/O8dOAmgrrjDYvROeB5xJj
	znWttE+heRwEiTBX/iyLFswrO62QvNyVrYlaFuDm1GujXbAel2aM683jFnbPU86XQl8RTEUrP9Ezj
	W6/mvelA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tWHet-0000000GB9N-2Jt9;
	Fri, 10 Jan 2025 16:14:51 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWHEe-0000000G5E8-1j0I
	for linux-nvme@bombadil.infradead.org;
	Fri, 10 Jan 2025 15:47:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IxTkpTzgi+owaBpYpL+RIc8wy5x1gLPOUY9XqLSBS50=; b=UBIUEPWj10Nn4s2CdnktK7jORV
	qeNH5RPehKIUD7c3j+nZXEctqyel5dBE0UcyvaBylKb6NLNE2p0mom86U1JkjxkFG2qdnOFUPpJkC
	+/lOxoFk1tmkGn6+bVXJzaivVVmvSs1Xn9md7aWvE/wXx/rbn8YUR6yrGT8fbLdhqtxXqFj61tR6I
	H/k1w+cRcHOWJTmFe40DO7J4zy/m8jcAm0Z46Oum3Vs0cbHmEJO4vPx/n9yvN1AVdXF0nzMI2Sys/
	/X0+TwLqEdz2E5rUFdSloeD9z9f2MzDknH2VAyjca6zmCz2NH/MHXFwfMjAd9p4RxC7v2L1QLkGwb
	znuqB29g==;
Received: from dfw.source.kernel.org ([139.178.84.217])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWHEa-00000009pZS-2aju
	for linux-nvme@lists.infradead.org;
	Fri, 10 Jan 2025 15:47:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 0D2AC5C110C;
	Fri, 10 Jan 2025 15:46:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AE28C4CED6;
	Fri, 10 Jan 2025 15:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736524056;
	bh=v3QlWihrvC2wBYTNOXQmOaLJBSc9kmxtCi5HfT3ZccA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dAcNk76w1oNPGr2sFmZrw8xAc4kYdNfx8E6sl2UWx81FpVxYE8bAMt6/elADP72aL
	 MIAuHpS1K0Dm+Q7QdatgsJPu2TzN9pL2Aho8JoNWsFZJHmEoSXDyzvvkOaV4mVLvwi
	 pOSPWrzh+LK2EMJwNLt1lQS0dFodw6sQBusmRfzF6PvtFyaIJuS+LvYnMbFrZjTNH8
	 FSVxw1Yqs830DpRcjGZkz1knTN+8+d2tLBaZGbgAKUG1bp/s6ZyMvxfs4uTVt8d/Yx
	 x1GVWWLNNyJoPmARFtMIeExZsQGGW6lZsoS9y++hBO7Q1WPNZz2cwfk6cOtAmfSL4u
	 aHV5YQSdchyeg==
Date: Fri, 10 Jan 2025 08:47:33 -0700
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: dwagner@suse.de, hare@suse.de, hch@lst.de, sagi@grimberg.me,
	axboe@fb.com, gjoyce@linux.ibm.com, linux-nvme@lists.infradead.org
Subject: Re: [PATCHv6 RFC 0/3] Add visibility for native NVMe multipath using
 sysfs
Message-ID: <Z4FBFSGCfHC4PYYi@kbusch-mbp>
References: <20241213041908.1381196-1-nilay@linux.ibm.com>
 <Z36sNBMPV7--2XHw@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z36sNBMPV7--2XHw@kbusch-mbp>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250110_154741_724203_53BA7C94 
X-CRM114-Status: GOOD (  14.22  )
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

On Wed, Jan 08, 2025 at 09:47:48AM -0700, Keith Busch wrote:
> On Fri, Dec 13, 2024 at 09:48:33AM +0530, Nilay Shroff wrote:
> > This RFC propose adding new sysfs attributes for adding visibility of
> > nvme native multipath I/O.
> > 
> > The changes are divided into three patches.
> > The first patch adds visibility for round-robin io-policy.
> > The second patch adds visibility for numa io-policy.
> > The third patch adds the visibility for queue-depth io-policy.
> 
> Thanks, applied to nvme-6.14.

I think I have to back this out of nvme-6.14 for now. This appears to be
causing a problem with blktests, test case trtype = loop nvme/058, as
reported by Chaitanya.

Here's a snippet of the kernel messages related to this:

[ 9031.706759] sysfs: cannot create duplicate filename '/devices/virtual/nvme-subsystem/nvme-subsys1/nvme1n2/multipath/nvme1c4n2'
[ 9031.706767] CPU: 41 UID: 0 PID: 52494 Comm: kworker/u192:61 Tainted:G        W  O     N 6.13.0-rc4nvme+ #109
[ 9031.706775] Tainted: [W]=WARN, [O]=OOT_MODULE, [N]=TEST
[ 9031.706777] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[ 9031.706781] Workqueue: async async_run_entry_fn
[ 9031.706790] Call Trace:
[ 9031.706795]  <TASK>
[ 9031.706798]  dump_stack_lvl+0x94/0xb0
[ 9031.706806]  sysfs_warn_dup+0x5b/0x70
[ 9031.706812]  sysfs_do_create_link_sd+0xce/0xe0
[ 9031.706817]  sysfs_add_link_to_group+0x35/0x60
[ 9031.706823]  nvme_mpath_add_sysfs_link+0xc3/0x160 [nvme_core]
[ 9031.706848]  nvme_mpath_set_live+0xb9/0x1f0 [nvme_core]
[ 9031.706865]  nvme_mpath_add_disk+0x10b/0x130 [nvme_core]
[ 9031.706883]  nvme_alloc_ns+0x8d5/0xc80 [nvme_core]
[ 9031.706904]  nvme_scan_ns+0x280/0x350 [nvme_core]
[ 9031.706920]  ? do_raw_spin_unlock+0x4e/0xc0
[ 9031.706929]  async_run_entry_fn+0x31/0x130
[ 9031.706934]  process_one_work+0x1f9/0x630
[ 9031.706943]  worker_thread+0x191/0x330
[ 9031.706948]  ? __pfx_worker_thread+0x10/0x10
[ 9031.706952]  kthread+0xe1/0x120
[ 9031.706956]  ? __pfx_kthread+0x10/0x10
[ 9031.706959]  ret_from_fork+0x31/0x50
[ 9031.706965]  ? __pfx_kthread+0x10/0x10
[ 9031.706968]  ret_from_fork_asm+0x1a/0x30
[ 9031.706980]  </TASK>
[ 9031.707062] block nvme1n2: failed to create link to nvme1c4n2


