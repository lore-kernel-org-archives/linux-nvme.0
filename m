Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C7FAD6A223
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Nov 2024 01:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CFguy11ofgtz76+hnSLpkdihHTIQ1t1jz5EBy2vamCg=; b=l7983T/anNdijtjzfmQh7oUIoe
	PYqOei7ADEPMRUFUtLdaCUV9m8K4z/myc1CkGBQMp7kW227DspCVZx3/CCuTTHK19thl0GsXVaolO
	x3oGe2o/erv5Dm9aCQiCvO7EdBNhzM1EViXEMiQPOtOs7y6iRagNddTBJdI3mSrMMMAMDfhLRy2hk
	h8sNYXIBlmiFYwmEdGkvATm3o+dTY2B+pca0MSs8ZLmFkmRU2hqAZ8O91pnqia+SH8E4ZS1Umr04d
	45L+ZXccChdbTQEDwFTn6e4Rwv4Dneo/0WuXohpqBEosH2yQH4DOi4rplroHAl68E4zgEsN3RXOC3
	8xCOeeOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBlKW-00000001KFx-1Dbr;
	Fri, 15 Nov 2024 01:41:00 +0000
Received: from out30-124.freemail.mail.aliyun.com ([115.124.30.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBlKT-00000001KFT-1VGS
	for linux-nvme@lists.infradead.org;
	Fri, 15 Nov 2024 01:40:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731634853; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=CFguy11ofgtz76+hnSLpkdihHTIQ1t1jz5EBy2vamCg=;
	b=hI4ArgypskfSGyEzZe5B9BdHQmIgR1kFam29fwUPBn44waZN0UKrbD20UtiR4+rGu0grsnSjgL3iRwjob9KTgjEc4ceM6HWUyczeBj6bNlBZZu57auhLmfQ4WdzvzkrzB00KSVHZTo0TwXCEjTlznLeenAAWQjFCw9JzIXJC6Ww=
Received: from 30.178.81.254(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WJQesu2_1731634849 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 15 Nov 2024 09:40:50 +0800
Message-ID: <72a94818-cbca-4c0d-a37d-59fba15e4dbc@linux.alibaba.com>
Date: Fri, 15 Nov 2024 09:40:47 +0800
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: CONFIG_NVME_MULTIPATH - Do we need this?
To: John Meneghini <jmeneghi@redhat.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: Ewan Milne <emilne@redhat.com>, Bryan Gurney <bgurney@redhat.com>,
 Chris Leech <cleech@redhat.com>, Maurizio Lombardi <mlombard@redhat.com>
References: <889e1d2a-1cda-4979-8279-f2f665350376@redhat.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <889e1d2a-1cda-4979-8279-f2f665350376@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241114_174057_878510_C2FE6CED 
X-CRM114-Status: GOOD (  11.00  )
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


在 2024/11/13 08:23, John Meneghini 写道:
> Now that RHEL-10 beta has shipped we no longer support anything but 
> native nvme multi-pathing and I'd like to do something about the 
> multipath module parameter:
>
> bool multipath = true;
> module_param(multipath, bool, 0444);
> MODULE_PARM_DESC(multipath,
>         "turn on native support for multiple controllers per subsystem");
>
> I'd like to remove this parameter from nvme_core/multipath.c. The fact 
> is, setting nvme_core.multipath=N never worked in anything but RHEL 
> and keeping it around only causes confusion.
>
> For that matter, I'd like to remove the CONFIG_NVME_MULTIPATH kconfig 
> option altogether.
>
> Does anybody actually use this?
>
> # CONFIG_NVME_MULTIPATH is not set
>
> Do we actually support running nvme without multipath.c ?
>
If the user want use dm-multipath instead of nvme-multipath, but the 
kernel's CONFIG_NVME_MULTIPATH is y, they can set this parameter to 
disable nvme-multipath.

Best Regards,

Guixin Liu


