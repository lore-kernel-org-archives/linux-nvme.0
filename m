Return-Path: <SRS0=LUST=DN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4A1C41604
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Oct 2020 17:41:17 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 196BB20782
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Oct 2020 17:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="e2j/rtMW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ak106rIN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 196BB20782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1v0Dz/NJ7sJE4u7f/yHISDusQos2wF7twPwEieMIQJc=; b=e2j/rtMWMljVwCu/ybeLogAzN
	S37LVDqakqgqHfqtVoW+lgeJUmN969/Es4Y0tqJ+LujOkLzVwDNJoh0MSBrQgF3x1UuRYeOKMV4Eg
	86uC2/H590wEfbVfZ996t1/i9j3LfPx3K+pfwZoGx+nkD/u2v8TD7hyjtbpM/VEyjI7jkvEp4JX3K
	hKQp1HaAfOlBeioEGtJA2Q85quvy5SUIO7Xj0VppfEk2vHiFZRtPaQQhWxgIWG7L9V+kjBot48tOs
	8MdOVG3F4nLpGXmhwnCh5uJaL0gyROStYLfA2Zx5itxjGaPSrkaEebf1ZHfu+C+P//UTMrD3nw2i0
	MZnvk/FgQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kPqxb-0006LP-9l; Tue, 06 Oct 2020 17:41:11 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kPqxU-0006HZ-FQ
 for linux-nvme@lists.infradead.org; Tue, 06 Oct 2020 17:41:07 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 23B6F20782;
 Tue,  6 Oct 2020 17:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1602006062;
 bh=wrqvkguElMwgcjScF0aVIixRUmyTDeGAak0jn+vyp8g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Ak106rIN/cbmyZY08O/DcUTjgkPFERtvCttTc1rjXzDmV4Ww8Ubygxj5QTSIWqlGi
 YSnxShR5kPSWWk0e82j778klEP8fmkvVLhLJi4InBc01GQ39b0ozs65Vbyu5plESsF
 c1V2+A2Yiatcj+tzHUUiy+02ZEEAAxZFGgWlSvGs=
Date: Tue, 6 Oct 2020 10:41:00 -0700
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 2/2] nvme: add 'queue_if_no_path' semantics
Message-ID: <20201006174100.GA959043@dhcp-10-100-145-180.wdl.wdc.com>
References: <20201005124500.6015-1-hare@suse.de>
 <20201005124500.6015-3-hare@suse.de> <20201005125201.GB1125@lst.de>
 <8d7d4803-5808-0839-ee4f-e36a12756497@suse.de>
 <20201006075153.GA10041@lst.de>
 <b720433b-5849-2e7f-d359-53247976bad5@suse.de>
 <20201006082727.GC10243@lst.de>
 <a848297e-3243-6366-86ee-0800d51198e1@suse.de>
 <20201006083926.GA13568@lst.de>
 <00e75643-d422-ca12-1648-02ca89044182@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <00e75643-d422-ca12-1648-02ca89044182@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201006_134104_612315_4E8A857F 
X-CRM114-Status: GOOD (  17.14  )
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
Cc: Keith Busch <keith.busch@wdc.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Oct 06, 2020 at 03:30:14PM +0200, Hannes Reinecke wrote:
> but the re-added device isn't added to the MD RAID.
> In fact, it has been assigned a _different_ namespace ID:

That's actually just a driver assigned instance rather than a Namespace
ID. 
 
> [  904.299065] pcieport 0000:00:08.0: pciehp: Slot(0-1): Card present
> [  904.299067] pcieport 0000:00:08.0: pciehp: Slot(0-1): Link Up
> [  904.435314] pci 0000:02:00.0: [8086:5845] type 00 class 0x010802
> [  904.435523] pci 0000:02:00.0: reg 0x10: [mem 0x00000000-0x00001fff 64bit]
> [  904.435676] pci 0000:02:00.0: reg 0x20: [mem 0x00000000-0x00000fff]
> [  904.436982] pci 0000:02:00.0: BAR 0: assigned [mem 0xc1200000-0xc1201fff 64bit]
> [  904.437086] pci 0000:02:00.0: BAR 4: assigned [mem 0xc1202000-0xc1202fff]
> [  904.437118] pcieport 0000:00:08.0: PCI bridge to [bus 02]
> [  904.437137] pcieport 0000:00:08.0:   bridge window [io  0x7000-0x7fff]
> [  904.439024] pcieport 0000:00:08.0:   bridge window [mem 0xc1200000-0xc13fffff]
> [  904.440229] pcieport 0000:00:08.0:   bridge window [mem 0x802000000-0x803ffffff 64bit pref]
> [  904.447150] nvme nvme3: pci function 0000:02:00.0
> [  904.447487] nvme 0000:02:00.0: enabling device (0000 -> 0002)
> [  904.458880] nvme nvme3: 1/0/0 default/read/poll queues
> [  904.461296] nvme1n2: detected capacity change from 0 to 4294967296
> 
> and the 'old', pre-hotplug device still lingers on in the 'nvme list'
> output.

I think what you're showing is a problem for everyone, including
fabrics. The namespace was attached to the previously existing
subsystem, nvme1, but we didn't find the previously existing "head" to
reattach the namespace.

I just threw the below together very hastily, so I'm sure there's
something wrong with it, but just to capture what's wrong with the
current code:

---
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3833584b5cee..0b3bbbe6d1e8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3897,8 +3897,6 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 
 	mutex_lock(&ns->ctrl->subsys->lock);
 	list_del_rcu(&ns->siblings);
-	if (list_empty(&ns->head->list))
-		list_del_init(&ns->head->entry);
 	mutex_unlock(&ns->ctrl->subsys->lock);
 
 	synchronize_rcu(); /* guarantee not available in head->list */
--

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
