Return-Path: <SRS0=LBLG=7C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35DBC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2020 17:12:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99E2D206B6
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2020 17:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="C+1KkEn2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99E2D206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ctSlRXv9GDTJcXVunKlg+DEWv+P4QEJD/mTdGU7XXDw=; b=C+1KkEn2qsmSr6
	765kD1UKY7D/zmR7uno/y5MKZTxApijRMGs3OljlsQunobpWgQgyJo0eFDv+ZTC34tf+GtDUwHwjz
	mUfWvwV0WuGWoWfxTlIEXolZuU7akFVDh9etPE/+++skZN2R0wzFR/zI49MmMR6pLagU0k3Tm7pur
	Ya6UBpVLEoqpGYftNtZDieWwCBBRue/g/SH+yBcTz9SpAsZLG3MGEM2kATFoGUYQhkjjsfBqtUnU4
	rx8jLG1LDnIGvj/EZeMRCKg+164K+X0Nl0JSW/7npnpsl9J4lsn5R0h4w9MSBGr59uKEjQrY1WLHa
	FAiSfTHlJ/kC/r5PjT+g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jbSGY-0007cx-25; Wed, 20 May 2020 17:12:26 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jbSGV-0007bk-A9
 for linux-nvme@lists.infradead.org; Wed, 20 May 2020 17:12:24 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id A1CF868BEB; Wed, 20 May 2020 19:12:20 +0200 (CEST)
Date: Wed, 20 May 2020 19:12:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] nvme: delete an unnecessary declaration
Message-ID: <20200520171220.GA9677@lst.de>
References: <20200515120659.GA575846@mwanda>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200515120659.GA575846@mwanda>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200520_101223_499569_A7CEAD1E 
X-CRM114-Status: UNSURE (   5.50  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, kernel-janitors@vger.kernel.org,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks,

applied to nvme-5.8.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
