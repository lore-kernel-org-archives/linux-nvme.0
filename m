Return-Path: <SRS0=oNUT=JZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_TONAME_EQ_TOLOCAL_SHORT,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 106DFC433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Apr 2021 06:46:19 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8010610FB
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Apr 2021 06:46:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8010610FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BgJAQgj3hITZvxY2vaAd8cui4HNHj7i9MtOAX2lzx0Q=; b=kyErGG3LaM7nS2dlGwW11PdDa
	yNCoeup4J4+fmjcAO2vJUDpQuZVzb5oyxOC5AVbFIlLMXXEmjnz5ZyWJG6KgNYZT7BGrCfbSrSqNx
	QOuTCR/0YBwsZtnRsgFtWoDx/P8KjnpLnSFBXXJPNp8MHY2x0m4g4qzF8BQo1rSVj4FFFgz4L1NK6
	UpuIqBFlSj4kkxEZ+NayAjwUNjfhcHZsiyc92Hc2U4UKMFZb8h5rCBwYRcRetyM+TAz3fOvWg40Yd
	9c4O2pAgJ6PS+2ud3UB+wwMEoU0BF+S3qki9S4PZ/PdI1NQGt3MfK+/f8of8Yo7Z+K9XCv4xVareK
	lDpM50JmQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbdxO-002xVl-HV; Wed, 28 Apr 2021 06:45:58 +0000
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbdwc-002xKK-0v
 for linux-nvme@lists.infradead.org; Wed, 28 Apr 2021 06:45:13 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 18B5368C7B; Wed, 28 Apr 2021 08:44:59 +0200 (CEST)
Date: Wed, 28 Apr 2021 08:44:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: taochiu <taochiu@synology.com>
Cc: hch@lst.de, chaitanya.kulkarni@wdc.com, kbusch@kernel.org, axboe@fb.com,
 sagi@grimberg.me, james.smart@broadcom.com,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Cody Wong <codywong@synology.com>, Leon Chien <leonchien@synology.com>
Subject: Re: [PATCH v2 1/2] nvme-core: Move nvmf queue ready check routines
 to core
Message-ID: <20210428064458.GB5988@lst.de>
References: <20210426025310.3005573-1-taochiu@synology.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210426025310.3005573-1-taochiu@synology.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210428_074511_908877_2EB76D44 
X-CRM114-Status: UNSURE (   8.05  )
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

applied the series to nvme-5.13.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
