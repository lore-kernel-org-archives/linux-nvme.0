Return-Path: <SRS0=D26X=KB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A645CC433B4
	for <linux-nvme@archiver.kernel.org>; Thu,  6 May 2021 07:44:07 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 006D2613B4
	for <linux-nvme@archiver.kernel.org>; Thu,  6 May 2021 07:44:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 006D2613B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7n3FOik8rBN6hXWM0IxzdbFBjm9nWqaG9dOxtZB+hko=; b=mEE5CTEAFEobNb3PkRy4w02Hh
	8MOz6ZIaPYIljyAgCU6vEEZ3xBKv7Hqq+8dSErImmcOoBlsTinUxBf+QtysY85A8+nK5XJrNv0bC2
	8JAU7CDCZGjaObdJc+P6yLRuUR7ERp+Gzjnfk8qCh8Hpp5GjsOjH7FysFa0DKQj8WS5CHYV0Y5opK
	P4HDN4QW4TRO0G3NJPQ/XILcHUNgXm2HSI3s+GzMfU1IaVfrtvHzJO8zaU2xL3B51ytGXyrVZphrX
	l66SN6WloMl5csPNtaN6MFeKl2vfa+N0tStwD/zyyrtG4TBrv9RFmQYKD3asslEtltss5XqesZkXt
	PCxMSqxuQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1leYfm-003WN7-Ok; Thu, 06 May 2021 07:43:50 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1leYfk-003WMv-SY
 for linux-nvme@desiato.infradead.org; Thu, 06 May 2021 07:43:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=wdRt/HwUfqqDjnOqoCcWN6DivALjZZACXAAs6ScAxlQ=; b=SlFZ0mHDPUtqyC68/IFoJb2gDY
 F9vuvYRckYIhyVBN+LtTKZBx9bdssaXOqfsj0+XhnnaOX/5M/nPkIrF1gDBmNrCr1bdmWVI1cm6cn
 BdawTYwFSuZ0h/jsm1UQCFfhzOhSHrXVMhcOQ2UM6XyPVnJKDYkXZwH7l9PbZtK4X4CYgkXIklyPB
 HJP6NkbOaYGKY5pYr8XnOra7q54KNX7ipkj9g7Ha3md7/jTCCKOxZl8QiZnsC6QU5duqJ02QoU5k1
 HEvykaU3LRgICXDk/KbyJdQAfe928wWYIIGDtJ4otaqG0Sh4StwIf3YCsblKLIamm0whCtbwNlxzh
 qVW8abMA==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1leYfi-005fxb-7L
 for linux-nvme@lists.infradead.org; Thu, 06 May 2021 07:43:47 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 672126736F; Thu,  6 May 2021 09:43:42 +0200 (CEST)
Date: Thu, 6 May 2021 09:43:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>, Daniel Wagner <daniel.wagner@suse.de>
Subject: Re: [PATCHv3] nvme-mpath: delete disk after last connection
Message-ID: <20210506074341.GC14615@lst.de>
References: <20210501120447.45478-1-hare@suse.de>
 <20210504085457.GA21826@lst.de>
 <5e4df9ec-c66c-17cf-542f-bac71b490e62@suse.de>
 <d1ca6eab-1ec9-d6c7-ed8a-00d9110bf023@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d1ca6eab-1ec9-d6c7-ed8a-00d9110bf023@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210506_004346_431215_12D49888 
X-CRM114-Status: GOOD (  22.19  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, May 04, 2021 at 12:54:14PM -0700, Sagi Grimberg wrote:
> Yes, I'm not sure I understand your comment Christoph. This addresses an
> issue with mdraid where hot unplug+replug does not restore the device to
> the raid group (pci and fabrics alike), where before multipath this used
> to work.
>
> queue_if_no_path is a dm-multipath feature so I'm not entirely clear
> what is the concern? mdraid on nvme (pci/fabrics) used to work a certain
> way, with the introduction of nvme-mpath the behavior was broken (as far
> as I understand from Hannes).

AFAIK that specific mdraid behavior is also fixed by the uevent patch
he sent.

> My thinking is that if we want queue_if_no_path functionality in nvme
> mpath we should have it explicitly stated properly such that people
> that actually need it will use it and have mdraid function correctly
> again. Also, queue_if_no_path applies really if all the paths are
> gone in the sense they are completely removed, and doesn't apply
> to controller reset/reconnect.
>
> I agree we should probably have queue_if_no_path attribute on the
> mpath device, but it doesn't sound right to default it to true given
> that it breaks mdraid stacking on top of it..

I really do not think we should change the mpath behaviors years after
first adding it.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
