Return-Path: <SRS0=0To6=77=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951BEC433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jun 2020 15:54:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D9212070A
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jun 2020 15:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GeonNW13"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D9212070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4KpV3dwKGHwLzZQNMV4C9Dsug7nCMYHA21gZ1m+Q7eI=; b=GeonNW13HlRzrm
	hVAFrMtIgOHwfuxCEUfIhy8EbYfGC3h4EuewObm/8x/L9ptbsInad9I8ZVjY6CNYfodmpQ7crPTd/
	PkiawuObkDQW5QPlDZbAozvt+37HPaeuuv5lJ31uLNIBIEwRkrFPJBZjl6Jv0ZoLl3eBvaKi+gb8o
	FsrgF0zMWKkw1QWeLmXApjEpKI2/nPjT/RTrhomgZGU9xJcpMsJP/0zNv4sQ5muZ6Np74NgURkIEF
	pAtcqDPdrRXruzIe1ASSrHgnav2friMmnyjkwvZoVgq63CGKlGOILwcPzFfqs3LFnkn2bWwv+GOcr
	oQFDCOmt1zZVMybwmPLg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jlwsA-0003Y6-Bf; Thu, 18 Jun 2020 15:54:38 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jlwpp-0001iF-Ab
 for linux-nvme@lists.infradead.org; Thu, 18 Jun 2020 15:52:14 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id BE1FCADC8;
 Thu, 18 Jun 2020 15:52:10 +0000 (UTC)
Date: Thu, 18 Jun 2020 17:52:10 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 05/12] blk-mq: short cut the IPI path in
 blk_mq_force_complete_rq for !SMP
Message-ID: <20200618155210.qozt54zi7265vozj@beryllium.lan>
References: <20200611064452.12353-1-hch@lst.de>
 <20200611064452.12353-6-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200611064452.12353-6-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200618_085213_560747_5417025D 
X-CRM114-Status: UNSURE (   9.63  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Peter Zijlstra <peterz@infradead.org>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jun 11, 2020 at 08:44:45AM +0200, Christoph Hellwig wrote:
> Let the compile optimize out the entire IPI path, given that we are
> obviously not going to use it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Daniel Wagner <dwagner@suse.de>



_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
