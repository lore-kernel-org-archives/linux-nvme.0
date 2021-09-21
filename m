Return-Path: <SRS0=kLfw=OL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D3AC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Sep 2021 07:16:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 342B8611C5
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Sep 2021 07:16:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 342B8611C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=a5BGJtlnl0WstKCG5yUc6mS/V6hA5IMTdHUQCFHrVKg=; b=UGCsWufIJHgf77
	+lvsL3IQw7I6JsYdIU6cFj3Nje1HLI/Mb9CPSuMc3Td89uLefaU9pbY9uISbGQm8wozigoi9oikZB
	oRUq7FOmBLLo4cnYkuMtq1QCO/rqTDLkJ/Addo7GcpENubY+t3SXgy+VRWBPVzx/hrfyNRQbAU4r3
	QClv48tcXhSSl9Q8a8ES0Mrmh9Xw0bLH77ZLnbyRyd5maR6UJd3mmugrGBx+C5paOC/ak+d8VHvBV
	/yvhcljMfpkkZ3ZPMylXIqw15KkcZp6pRqrcwaOIZLQtQS3lNfuHbzl3U909rgj85OavopQBiucVW
	k8T4DHVf1/46TerJnV9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mSa0B-003lYD-JW; Tue, 21 Sep 2021 07:15:39 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mSa08-003lXX-GT
 for linux-nvme@lists.infradead.org; Tue, 21 Sep 2021 07:15:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 4ABED67373; Tue, 21 Sep 2021 09:15:28 +0200 (CEST)
Date: Tue, 21 Sep 2021 09:15:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Anton Eidelman <anton.eidelman@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com
Subject: Re: [PATCH] nvme/mpath: fix hang when disk goes live over reconnect
Message-ID: <20210921071527.GA24837@lst.de>
References: <20210918215729.388968-1-anton@lightbitslabs.com>
 <20210920063534.GA26999@lst.de> <20210920145336.GA489494@anton-latitude>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210920145336.GA489494@anton-latitude>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210921_001536_734511_167613F6 
X-CRM114-Status: GOOD (  12.83  )
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

On Mon, Sep 20, 2021 at 08:53:36AM -0600, Anton Eidelman wrote:
> The wrapper is to:
> - follow the naming convention for mpath functions called from core
> - allow the implementation to have more logic in future
> 
> As for error propagation, nvme_start_ctrl is void.

Which of course can be changed, like all software.

> Any error in nvme_read_ana_log() will have the same effect as
> when it is invoked from nvme_ana_work(), i.e. will be ignored.

We need to return negative errors during initialization otherwise
we're going to run into teardown problems.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
