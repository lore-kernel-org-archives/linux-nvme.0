Return-Path: <SRS0=tapN=C7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB571C4363D
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2020 14:57:21 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DA6D2395C
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2020 14:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WMaYr3LC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XqU2M5rl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DA6D2395C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=dWwYzAC3cblhsQ0iD9KbldunZRCaNJu0mrba5HwmgIE=; b=WMaYr3LCOinm01Xj14NCP9j6N
	YoCXjtmvAuCNVcAMdV1zUgvc6dQjMsDd+HvXuiehGRhksIgrFKioKJYs4Why4ruQb1mX5oUFQU4iH
	zpCSAe2XZWAyW9AHykvF/FzngKrYWl/i02jIRt5UzszFZV5UAJ4BUpoOfCRgURYr45oNyP+//CBq9
	OFuKXhXFaedp82+mkHc3eET/xXH41G+Vgko3UZCCxm8f3J/N/5aln8wNqZStohmFoel/RrPgNZwlQ
	PpUa52lcb7H1xnXCd9+P5S6O2jwvuSjl55jHFbsl95jdtimEyrKrmQWM523V3yXHJZSHsISne6QsH
	7rnUH+xVw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kKjjE-0000oT-6G; Tue, 22 Sep 2020 14:57:12 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kKjjA-0000nO-Ji
 for linux-nvme@lists.infradead.org; Tue, 22 Sep 2020 14:57:09 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5833B2395C;
 Tue, 22 Sep 2020 14:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600786627;
 bh=qgNyAecq4oxMx1KaA3J1BnvoQo/FK2H/JbyEW4SN8pk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XqU2M5rll9Q9dBJ5G1ByTbvHr6CQvompbhY9rSaF7xg+CDIRBpVaNfGXBfNQIwAC4
 K7X1hf0hdWhByhKaaM+jUqgcfIL4j60YaAm8nojwvUMRjFX9MG6NGRk2c0l2bnzfe8
 cRG5IQHFP1mRdbib5Q1mMRUfgtPs95wH/LP7ClG8=
Date: Tue, 22 Sep 2020 07:57:05 -0700
From: Keith Busch <kbusch@kernel.org>
To: Xianting Tian <tian.xianting@h3c.com>
Subject: Re: [PATCH] [v2] nvme: replace meaningless judgement by checking
 whether req is null
Message-ID: <20200922145705.GA4035426@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200922062517.30031-1-tian.xianting@h3c.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200922062517.30031-1-tian.xianting@h3c.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200922_105708_749874_E782A304 
X-CRM114-Status: UNSURE (   8.65  )
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
Cc: axboe@fb.com, linux-kernel@vger.kernel.org, hch@lst.de,
 linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The commit subject is a too long. We should really try to keep these to
50 characters or less.

  nvme-pci: fix NULL req in completion handler

Otherwise, looks fine.

Reviewed-by: Keith Busch <kbusch@kernel.org>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
