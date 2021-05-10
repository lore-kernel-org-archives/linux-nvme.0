Return-Path: <SRS0=GcL3=KF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCFEC433B4
	for <linux-nvme@archiver.kernel.org>; Mon, 10 May 2021 07:00:39 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CA2A6105A
	for <linux-nvme@archiver.kernel.org>; Mon, 10 May 2021 07:00:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CA2A6105A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7xin8YcM8UXA1N0nCbD4BbyDBrLeWo+T/XKKPOETZ9c=; b=qMQARUiMLK5qBQQZfxTF0S60B
	RhwZNUxg6NUlBoWInJbCXmh70Eq1EdvBM7E6KyQ+0c3Xtp4gVuUwm/QQHlDYRvnAKZ/hU5waZX7eE
	C7yrutZON1ZEkrxZJNDqDh8NEHkRKe1iOExmKpQUMqqT6kflPK9T4Nztzzm/7/eX1+4GGWObnz3ct
	6ez0Q0Rk/WkDj7/OcCEiA2O7v5OOKKcjaoXvHOf6Wuzlll3e9m+f8sy25BAX/1Vltn9LExmnxR9Fz
	G09ZRdWeyXCqv3Kq1vZDyhOn/fjT7ihB3FqjYEM62mLjerWG+bVcfu+CY21nXdfeGB78ossIxUJvi
	zTXDfxyrw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lfzu5-00DRAc-U8; Mon, 10 May 2021 07:00:34 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lfztl-00DR4l-Vr
 for linux-nvme@desiato.infradead.org; Mon, 10 May 2021 07:00:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=JfcaAWiL9MX/KzgqZFMd5GxaGaNC7KsyrSBFfXwwLXo=; b=KDecMKznOZqtBbU/ZWgtdxqqdP
 5Ed1rTZt5c4DUbBaVM7C6Dqg3smVVIzC6H+XzC/VuYHd3e622axZuAwKg2rJBv/tL6u4a/R2n3tjX
 hGPP0i8HCqctUjmAm5rke6qZbZf1Y9lUhrPJX8YC9DRqRQh/jRhqJ6gkotymEY+elk4SUmUckvw1R
 An2buqH1oys7UhjvbU5/gOF+nxHvPmJ5+ZDLNvaAM6fd/3JaYDh4kuzjhnq8YQJZQsQAtelbW+R9Q
 8TzH5PF8qtN7BM0Yz7xHmTxI/9hITwYL2tyImZpqzbhXBt3RKpKSJzPji44x5wI6o0+VwYh4uRtpl
 54av25gg==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lfztj-008M9k-Hs
 for linux-nvme@lists.infradead.org; Mon, 10 May 2021 07:00:12 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id AE55C67373; Mon, 10 May 2021 09:00:08 +0200 (CEST)
Date: Mon, 10 May 2021 09:00:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: Michal Kalderon <michal.kalderon@marvell.com>
Cc: mkalderon@marvell.com, aelior@marvell.com, hch@lst.de, sagi@grimberg.me,
 yaminf@mellanox.com, linux-nvme@lists.infradead.org,
 linux-rdma@vger.kernel.org, Shai Malin <smalin@marvell.com>
Subject: Re: [PATCH] nvmet-rdma: Fix NULL deref when SEND is completed with
 error
Message-ID: <20210510070007.GB30907@lst.de>
References: <20210506070819.12502-1-michal.kalderon@marvell.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210506070819.12502-1-michal.kalderon@marvell.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210510_000011_758367_068D94D2 
X-CRM114-Status: UNSURE (   8.34  )
X-CRM114-Notice: Please train this message.
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

Thanks,

applied to nvme-5.13.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
