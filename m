Return-Path: <SRS0=YEyo=W5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0156C3A59B
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Sep 2019 08:29:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C68EB21874
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Sep 2019 08:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="huTb+2Z/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C68EB21874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Y3xCU1a2Aq1PByJjPtZyL72/vGKKMlhJQ7UYSRYTNto=; b=huTb+2Z/RDk5n3
	m5hpQz3pDeyolSh25MK7GDebYlkfGRBt8gY48iHxfpHrzEaEcY4HFQq8mfu8lQnMtjUkXnk9e9sxA
	tCUqX7yfetIhPCROfXlJJRphcMgiQp/DQAneuQP+kXFJah65LX7bqMta7yAqpbqM/9b0Pq2zJ5QYl
	wAPlb7UMw5l8XC/f/M7DD6gXRAOHmy8HaB/i50lkCDSoOrIplADYjWk4so1oDSKP9A9pJnqoxCkuY
	V/AYnnWIBpronokiHkNUVvKrfp+oRs6HIpuJXEe8LuAxS3mHkZx4s+DyLIz8gorBF7fLHfUjCbYoU
	aMUjgUYfbNdMK53s9k+g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i4hiW-000069-DM; Mon, 02 Sep 2019 08:29:40 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i4hiT-00005I-8r
 for linux-nvme@lists.infradead.org; Mon, 02 Sep 2019 08:29:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 7D5E0227A8A; Mon,  2 Sep 2019 10:29:33 +0200 (CEST)
Date: Mon, 2 Sep 2019 10:29:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Marta Rybczynska <mrybczyn@kalray.eu>
Subject: Re: [PATCH v2] nvme: allow 64-bit results in passthru commands
Message-ID: <20190902082933.GA29909@lst.de>
References: <89520652.56920183.1565948841909.JavaMail.zimbra@kalray.eu>
 <20190822000652.GF9511@lst.de>
 <1678802062.58145473.1566818428010.JavaMail.zimbra@kalray.eu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1678802062.58145473.1566818428010.JavaMail.zimbra@kalray.eu>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190902_012937_465736_6A3C3072 
X-CRM114-Status: UNSURE (   6.11  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Samuel Jones <sjones@kalray.eu>,
 Guillaume Missonnier <gmissonnier@kalray.eu>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-nvme <linux-nvme@lists.infradead.org>, axboe <axboe@fb.com>,
 kbusch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Aug 26, 2019 at 01:20:28PM +0200, Marta Rybczynska wrote:
> Do you mean something like this?

Yes.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
