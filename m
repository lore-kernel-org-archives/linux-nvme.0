Return-Path: <SRS0=B5n5=C6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB779C43463
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2020 06:34:27 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0826F20739
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2020 06:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KiE13YDr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0826F20739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=qAWjAbrlKHHxPamHhV4DfaPFeqAyR6G7CJdPDYPfLEo=; b=KiE13YDr/KfQJHYroxI6KFRLy
	7I/nKHJT7nCx/zH4mBtjLKTE5pavdih92EJqh4lIDBime3m2szOGH8czLA90/08fL88QDjsSC/sxP
	3KvhGpzVi1JCiIZWZm1Mr56E21C/jop1IkrTQIYzv7CF399uApy/i9SW1eny5M65KKGDlZvi/SwFi
	4QeNhJMSQSb/EpCSUeaiubZTnGUE7VBcfpg5WXBo2bQGLSxHQ2+AJyVKNKyXSyFobWgYn7WLMX5yf
	ldADgOTrmg3aevHkZ9JgokgZz9VHhMgYNDlZKpTIynxpWI0MF1wPypgntEpYWexYJUvAOHo7/jGmN
	6j5p05OTA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kKFP2-0000tf-BP; Mon, 21 Sep 2020 06:34:20 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kKFOz-0000sl-EQ
 for linux-nvme@lists.infradead.org; Mon, 21 Sep 2020 06:34:18 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 4734568AFE; Mon, 21 Sep 2020 08:34:14 +0200 (CEST)
Date: Mon, 21 Sep 2020 08:34:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: Xianting Tian <tian.xianting@h3c.com>
Subject: Re: [PATCH] nvme: replace meaningless judgement by checking
 whether req is null
Message-ID: <20200921063413.GA18298@lst.de>
References: <20200921021052.10462-1-tian.xianting@h3c.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200921021052.10462-1-tian.xianting@h3c.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200921_023417_597664_0D74927F 
X-CRM114-Status: UNSURE (   7.60  )
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
Cc: sagi@grimberg.me, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, axboe@fb.com, kbusch@kernel.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks, this looks much more sensible than the previous versions.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
