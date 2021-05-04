Return-Path: <SRS0=iWk4=J7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2AFC433ED
	for <linux-nvme@archiver.kernel.org>; Tue,  4 May 2021 07:42:42 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30EEA613AA
	for <linux-nvme@archiver.kernel.org>; Tue,  4 May 2021 07:42:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30EEA613AA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7xin8YcM8UXA1N0nCbD4BbyDBrLeWo+T/XKKPOETZ9c=; b=bXDj0CcIadHtPKBdkoZhmEyFQ
	WXQpC5R0ZkMTP0BOc7WNvqpEGsLcSrC66Am0ucjkxBIQq8KSRgRw20byoah9pXvsn7Gwj2FTsDDBb
	ZpR+29GvC0EFRv+AmGaTz/3rEiePBykOk/xttSv+FvOl8wzkAdYrDaZw5nz4XBqd5GoBMtVTMVcWW
	UexUODwITb+Xkx1Ci1HRLJaBA+x4TY3uW28E1PogOLeRzuljdFGZqzcWY7ohsostgGXsxRtmggmpO
	bsN4+sTDWnXkizr3pRHihh4F/1rLvtW0kZiau4ECoocUznK1xi31JDB34C8NlF3JFptoi66HNSaaU
	MmOYe/ryg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ldphD-00FdHK-Jp; Tue, 04 May 2021 07:42:19 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldph8-00FdG3-Nz
 for linux-nvme@desiato.infradead.org; Tue, 04 May 2021 07:42:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=JfcaAWiL9MX/KzgqZFMd5GxaGaNC7KsyrSBFfXwwLXo=; b=XzZxy+mkrX9od/w+4SQnDcBHVz
 czt4fsU60pW8YscGPV9m6hw32CaiXazKjBf8hac5xNcPFWSWq1ZYOpTrxBdJ+VQWvACv7ywORUNDN
 ExSSnWr0GoIJ03tbwg+f/aIOcz0hohQEHT9mmSS36qSaSSE+4s//dp8TyHhTPfRyvFS8gT0rWDXKK
 oAtjJjsDTnvBQi5xZ9QC2RjxMFitzzj5Qyr7Gli2X5ppvXRlSvxZhfYmbiQRZxPPb/VRcdQkGwx46
 EsAY0FOGKqQiO4yhR7RXJh12XKQh80LsuMGqV05l409UHphCxvpumgeLyNREAvYCZhCxTKRZeJlsa
 nxg/HJMQ==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldph6-003m3s-Ai
 for linux-nvme@lists.infradead.org; Tue, 04 May 2021 07:42:13 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 5CD9568AFE; Tue,  4 May 2021 09:42:10 +0200 (CEST)
Date: Tue, 4 May 2021 09:42:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] nvme-multipath: Reset bdev to ns head when failover
Message-ID: <20210504074210.GB16523@lst.de>
References: <20210503170303.10443-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210503170303.10443-1-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210504_004212_530250_EBCBB0DE 
X-CRM114-Status: UNSURE (   9.40  )
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
