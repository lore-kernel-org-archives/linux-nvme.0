Return-Path: <SRS0=+1uq=AT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6881BC433E0
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jul 2020 17:12:17 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3490D2065F
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jul 2020 17:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mQkxKPm8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LTnc9kMH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3490D2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/rEnMQfIKK1ucyoz/oQUbE9408y100C7M0q7zjwT7ZY=; b=mQkxKPm8PikVtWXXMI9c6CsGP
	cusnnzwSszF24m0HDpPVasnivs2xvZLU23kZrsdsGVPca/G5MEuEqDwWT5OxzIk3wlKXYX4EwAvsE
	3btxgH9LQrPOGMk81oezN8dNs/JgkOThwzb7uDNQ4WT+6wcONr6Ow446uIQldOk6J1HrSmIh0B9MF
	g3+rxwIl1AZnEG1VTQoN4SPZiIA2f82f0tCvvIxJvXhXLOCgOxWqDRQNmMotFihaIvhEksZh/74P1
	bGuGYZoPzFz+w3BeQyn/X6r7CPVBJbryUvh75TmtiEJm5lnZyJeJCM6fTBd5kiS99HhLJ0/jmruoY
	IxAfg+LEQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jtDcB-0001Lh-Pp; Wed, 08 Jul 2020 17:12:11 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jtDcA-0001LH-0x
 for linux-nvme@lists.infradead.org; Wed, 08 Jul 2020 17:12:10 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1F1832065F;
 Wed,  8 Jul 2020 17:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594228329;
 bh=yQ4BoDZtGwAxlRTU5ngc1iiGz+Aw4LNsUvxAPuEBIiU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LTnc9kMHqvbSt02AUHxwt830Z4aDISVVqzejxgHwwYe/jenFfr5DtpqfglW3ucZ5m
 6e0z2F+QXGF71JOwDgfK2dXtS1h/acPwP5zlV5JynkzeCSOKfCvIWX+NDSRwnx8pAe
 HQgDh3QK3sNCVbCUXtrY3Nu3Xza7U9MTAR52Nl+g=
Date: Wed, 8 Jul 2020 10:12:07 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme: remove ns->disk checks
Message-ID: <20200708171207.GB2288218@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200708144015.315108-1-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200708144015.315108-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200708_131210_207453_04055C3C 
X-CRM114-Status: UNSURE (   9.96  )
X-CRM114-Notice: Please train this message.
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
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Jul 08, 2020 at 04:40:15PM +0200, Christoph Hellwig wrote:
> By the time a namespace is added to ctrl->namespaces list and thus
> can be looked up ns->disk has been assigned, and it it never cleared.
> 
> Remove all the checks for ns->disk being NULL.

Looks like all these pointless checks were from an older interaction
with lightnvm that is no longer applicable, so looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
