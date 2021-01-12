Return-Path: <SRS0=XnCc=GP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46049C433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 07:36:17 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E52FC22AAF
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 07:36:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E52FC22AAF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=XwOFfNLoKBXOiR7dcB75k3BEZJmOtXFueZbg6lqQEmM=; b=C+vSeiXUU5KNu5GtyutHe5Bn3
	sthORh1sR4GQT4YWjw1Ywu16PTPvU7JCiVuLtiywP7pdxO4FIPa2QUMWGARfPejx/vesjkEyNj/9z
	lB28qTefTUR2GyPxGeysNIAdbDOpv745NrRU7kkhNatU3eb+tfvQIOZCjJB30HLpUFsoXqk2wmoZY
	wU2HpxN3hi8p3K8HOPOzpAIDjIacV/DsCz4VkfLm34tjxPed+Fd2b9u8GsKlCV2ul9LaHooGbdFlW
	eeyxpNRVPk7Myi7XRdLCNdc79IMYriiMNIPrvUbj0n+6HBLXoTesNYCWcYyA6i/d1GX04cdHFDbYo
	FOr1tb+lg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzEDq-0002p1-7F; Tue, 12 Jan 2021 07:36:10 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzEDo-0002np-3c
 for linux-nvme@lists.infradead.org; Tue, 12 Jan 2021 07:36:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 97A2667373; Tue, 12 Jan 2021 08:36:06 +0100 (CET)
Date: Tue, 12 Jan 2021 08:36:06 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH V9 9/9] nvmet: call nvmet_bio_done() for zone append
Message-ID: <20210112073606.GD24288@lst.de>
References: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com>
 <20210112042623.6316-10-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210112042623.6316-10-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210112_023608_328533_8E3EB837 
X-CRM114-Status: UNSURE (   6.05  )
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
Cc: linux-block@vger.kernel.org, damien.lemoal@wdc.com, hch@lst.de,
 linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

I don't see much of a need to share such trivial functionality over
different codebases.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
