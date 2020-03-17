Return-Path: <SRS0=JSXe=5C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E173C10F29
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Mar 2020 12:58:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 588BF20658
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Mar 2020 12:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Mj7MK3WF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 588BF20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GjxdsoT3m9zMgcvpHfg8Ae32HjesnI9rwvCnV5iMmMQ=; b=Mj7MK3WFC+nnfw
	W5MTc7VA85Phr0jaHlG/mJHPhkxwMSM5yzGlPfV+aShcwHSdH7OytfdnorT9fw9FUPzSGl6ewZ29d
	nE87i9tJgsKJwaG0xWsklWXI3Znksjub2Cj/JRIMypTN2ezmCTdi6U3AUAazO/uF+YUZD3EYfkxR3
	QMtR4eq5X9reygwq7y/TRPzQMBahZT8asD/z8w3kOr2EOJRvp7GxcOhPOLgRzOu/ygdO+MfeQ1OSb
	z65Cp8dZZdWXD5hfEdB5AhsvmuNw9LZdDmJ/5Nu3Y6nt3SZ3ujCyaxiVwf6pD74cRHb62WgzUu6Zl
	OXk/trYiVyGKo7JtLpDA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jEBnr-00069T-Ab; Tue, 17 Mar 2020 12:58:39 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jEBmw-0004r0-3N
 for linux-nvme@lists.infradead.org; Tue, 17 Mar 2020 12:57:45 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 68FB068CEC; Tue, 17 Mar 2020 13:57:38 +0100 (CET)
Date: Tue, 17 Mar 2020 13:57:37 +0100
From: Christoph Hellwig <hch@lst.de>
To: masahiro31.yamada@kioxia.com
Subject: Re: [PATCH V2] nvme: Add compat_ioctl handler for NVME_IOCTL_SUBMIT_IO
Message-ID: <20200317125737.GH12316@lst.de>
References: <92c670379c264775b8bb28a2bd3b380b@TGXML281.toshiba.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <92c670379c264775b8bb28a2bd3b380b@TGXML281.toshiba.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200317_055742_921530_05AFEB61 
X-CRM114-Status: UNSURE (   5.37  )
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
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
