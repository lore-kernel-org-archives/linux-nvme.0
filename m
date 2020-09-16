Return-Path: <SRS0=FbzM=CZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF332C433E2
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Sep 2020 16:00:51 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EDFD20809
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Sep 2020 16:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="x+10wmzp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="BtfyhAdE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EDFD20809
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=rmN5L41NHK25uY08DeyZj7z881YIUDhh+WITvo5+e1E=; b=x+10wmzpDPmQ47hhrQ4WJB7/Y
	Q1HvL37EUEKJxnBDaBaSsst5mcuuMmkUlA0nWeMZM8SnKOwU/iq0l8nxfAs8txqhs4pvnC1S4SJ5E
	GSxqvSBoaWkgvbWvTmrSaP0AP7hbkoLYWO9tCcP/iXs77eU+U+Qmn8fsGpkNFH+QKTuHA9eBmooSk
	fCzdL0n/h6yLDg2hoe3xiVyVkq5cCWEVLrtKwq4VVKITL119SXCW188/XqhLHAGgmBdM2ZbNfKT5P
	lE0CWld4xzyDSkNL/eqStKjNk5UaDi11SU5DhH/0ygMcdD2rmwIJOSf7DcgC/S7zHz3hAckb5G4Wl
	7IwZIViwg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kIZrO-0004y4-U2; Wed, 16 Sep 2020 16:00:42 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIZpZ-00046c-Gn
 for linux-nvme@lists.infradead.org; Wed, 16 Sep 2020 15:58:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Kl4gKnBVaWxKTQ+1ePRrnceRarn0FVo8I7rg4pNyrvY=; b=BtfyhAdEP2su1nbmDDwMI11f/1
 iUlbymwQmZ4usIILEY7/XrDIMbz5goUfYKHxrhFziuRCD2A7NErJT3ncdzLFeCX2GoBtyDn6aUYCe
 iN08MfYOXyP09DOOEO9Lfm5VpHFPEN0JDP8qI3mANbxwolDH9AX+1W2xpDLrurVBc0ryirh8qxUYH
 J+Z3P2uL2K1JOW3UWrWG76Wetli92t8SGhBHKpdAWelMj94UOIMFjXd90LwzXSPx9z345mf69C0GW
 HLxY6tYAH8zgMjX/nqgLrmGD8Wu5IEBGR1LXyJE3Ay7pwXd0H0XR2gvfHshjEAFFhZyvu3YrSodBc
 WX/BiTTg==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4]
 helo=[192.168.0.10])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1kIZpQ-0003Qw-Gq; Wed, 16 Sep 2020 09:58:42 -0600
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20200916035326.9229-1-chaitanya.kulkarni@wdc.com>
 <20200916035326.9229-2-chaitanya.kulkarni@wdc.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <73c9b0fe-ed1d-5cd5-137c-9c6ab9baa1f2@deltatee.com>
Date: Wed, 16 Sep 2020 09:58:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200916035326.9229-2-chaitanya.kulkarni@wdc.com>
Content-Language: en-US
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: sagi@grimberg.me, hch@lst.de, kbusch@kernel.org,
 linux-nvme@lists.infradead.org, chaitanya.kulkarni@wdc.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH V2 1/2] nvme-core: fix nvme module ref count Oops
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200916_115849_742636_BA963EF7 
X-CRM114-Status: GOOD (  19.29  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2020-09-15 9:53 p.m., Chaitanya Kulkarni wrote:
> Introduce car dev relase function, get/put the module refernece which
> allows us to fix the potential Oops which can be easily reproduced with
> NVMeOF passthru ctrl :-
> 
> Entering kdb (current=0xffff8887f8290000, pid 3128) on processor 30 Oops: (null)
> due to oops @ 0xffffffffa01019ad
> CPU: 30 PID: 3128 Comm: bash Tainted: G        W  OE     5.8.0-rc4nvme-5.9+ #35
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.4
> RIP: 0010:nvme_free_ctrl+0x234/0x285 [nvme_core]
> Code: 57 10 a0 e8 73 bf 02 e1 ba 3d 11 00 00 48 c7 c6 98 33 10 a0 48 c7 c7 1d 57 10 a0 e8 5b bf 02 e1 8
> RSP: 0018:ffffc90001d63de0 EFLAGS: 00010246
> RAX: ffffffffa05c0440 RBX: ffff8888119e45a0 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffff8888177e9550 RDI: ffff8888119e43b0
> RBP: ffff8887d4768000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: ffffc90001d63c90 R12: ffff8888119e43b0
> R13: ffff8888119e5108 R14: dead000000000100 R15: ffff8888119e5108
> FS:  00007f1ef27b0740(0000) GS:ffff888817600000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffffffa05c0470 CR3: 00000007f6bee000 CR4: 00000000003406e0
> Call Trace:
>  device_release+0x27/0x80
>  kobject_put+0x98/0x170
>  nvmet_passthru_ctrl_disable+0x4a/0x70 [nvmet]
>  nvmet_passthru_enable_store+0x4c/0x90 [nvmet]
>  configfs_write_file+0xe6/0x150
>  vfs_write+0xba/0x1e0
>  ksys_write+0x5f/0xe0
>  do_syscall_64+0x52/0xb0
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x7f1ef1eb2840
> Code: Bad RIP value.
> RSP: 002b:00007fffdbff0eb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f1ef1eb2840
> RDX: 0000000000000002 RSI: 00007f1ef27d2000 RDI: 0000000000000001
> RBP: 00007f1ef27d2000 R08: 000000000000000a R09: 00007f1ef27b0740
> R10: 0000000000000001 R11: 0000000000000246 R12: 00007f1ef2186400
> R13: 0000000000000002 R14: 0000000000000001 R15: 0000000000000000
> 
> With this patch fix we take the module ref count in nvme_dev_open() and
> release that ref count in newly introduced nvme_dev_release().
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  drivers/nvme/host/core.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 8b75f6ca0b61..c5f9d64b2bec 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3261,10 +3261,22 @@ static int nvme_dev_open(struct inode *inode, struct file *file)
>  		return -EWOULDBLOCK;
>  	}
>  
> +	if (!try_module_get(ctrl->ops->module))
> +		return -EINVAL;

Aren't we also still missing the nvme_get_ctrl() here? We have a
reference to the controller that's not counted; which was the original
bug, and we need a reference to the module to be able to put that
reference...

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
