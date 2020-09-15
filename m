Return-Path: <SRS0=GAdO=CY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580FEC43461
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Sep 2020 05:59:33 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A59492080C
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Sep 2020 05:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZT/quwB4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A59492080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=DQ8rX/BoGzSaOrw/Pz8r+iPSbZH7XfRcjd1AlHME/0o=; b=ZT/quwB4nVwZkNdM+HNgHNi/y
	8UPwWxPAueFVf2XLCaoiwNf7l5GHfwk1v/VO6ByBNjLaHwGS+RAplgk64GSzMsenV/O/3zMgV22wO
	I6SuD4BnnnWrQyuBGMqUEwDyVUd1haEEmwsF/UzJSUnp3o099m3rlS3R8hWb1qX8yQ6C7hEoE7IHP
	iGfMMTlP1hvRa/VFg+UrRlCYZZ/4zVwsi+v0kCErwz91Kzj/YOKQF1mFbxTc9MlWVPx76tw/7f1YN
	1n8Zq26DUCD5ZkOCOHSr5COOe6c68volRWgQu9RDTLFx9H8LvwzdcBG17VBleGZXtdGKGQiezyN5o
	iYX1f+9ow==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kI401-0004co-M5; Tue, 15 Sep 2020 05:59:29 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kI3zy-0004cN-De
 for linux-nvme@lists.infradead.org; Tue, 15 Sep 2020 05:59:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 260E76736F; Tue, 15 Sep 2020 07:59:24 +0200 (CEST)
Date: Tue, 15 Sep 2020 07:59:23 +0200
From: Christoph Hellwig <hch@lst.de>
To: Necip Fazil Yildiran <fazilyildiran@gmail.com>
Subject: Re: [PATCH] nvme: tcp: fix kconfig dependency warning when !CRYPTO
Message-ID: <20200915055923.GB18496@lst.de>
References: <20200914150120.449602-1-fazilyildiran@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200914150120.449602-1-fazilyildiran@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200915_015926_619817_F92CDD13 
X-CRM114-Status: UNSURE (   6.72  )
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
Cc: sagi@grimberg.me, paul@pgazz.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, axboe@fb.com, minwoo.im.dev@gmail.com,
 kbusch@kernel.org, jeho@cs.utexas.edu, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks,

applied to nvme-5.9.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
