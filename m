Return-Path: <SRS0=itK/=OY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD273C433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Oct 2021 16:58:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49FE761357
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Oct 2021 16:58:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 49FE761357
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=x/nh7rU90E2MgzIBBSB6/x4TCaA9ZX27FtI7wB3idv4=; b=2rMDo3V0phlX8+
	KL/VqtAcMMI4e9RagPSgkLY06t/TMeQCzcJEBeDD/Esmndbzdf9R6HLtWNqAuJeqDaAof8YhCPeAh
	qYsI9fdhl0idksE5iAHMs1hsYjZbY2PxzMS8r8a1XgBY57OXhaEW4QaEtfWXhBaOj1bJtuOkxmNPR
	9zdQA+L6pNA3g3F2vPUAWOg+xd8nB8M93gAzu8l/KOCgrM9voNSV5vsgEgJBpJURS9cSOWCTmQrdk
	8gd8TdHB4fpTKoYTksZ+8MtfZaMtJbF1dFbg+1ftn8BPhA6OWzasYBBVL2LmzMgxrxbqpQEFuMhec
	/51qemS4QSYtpgk7BIuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mXRHt-007Dxq-Bb; Mon, 04 Oct 2021 16:58:01 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mXRHR-007DkZ-Ah
 for linux-nvme@lists.infradead.org; Mon, 04 Oct 2021 16:57:35 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 732A768B05; Mon,  4 Oct 2021 18:57:25 +0200 (CEST)
Date: Mon, 4 Oct 2021 18:57:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Anton Eidelman <anton.eidelman@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com
Subject: Re: [PATCH] nvme/mpath: fix hang when disk goes live over reconnect
Message-ID: <20211004165725.GB21511@lst.de>
References: <20210918215729.388968-1-anton@lightbitslabs.com>
 <20210920063534.GA26999@lst.de> <20210920145336.GA489494@anton-latitude>
 <20210921071527.GA24837@lst.de> <20211004164612.GA1475751@anton-latitude>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211004164612.GA1475751@anton-latitude>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211004_095733_546411_43B7D8B3 
X-CRM114-Status: GOOD (  14.01  )
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

On Mon, Oct 04, 2021 at 10:46:12AM -0600, Anton Eidelman wrote:
> How do we proceed with this fix?

Please resend with the suggested updates.

> I believe error propagation here is not wanted because:
> 1) A failure to fetch or parse the ANA log should not be considered
>    an error in ctrl initialization.

We must handle error that are due to a controller failing to initialize.

> 2) Such error will not cause problems in teardown.
> 3) The same failure is possible in ANA work and we do not take
>    any action in such case.

Failing in a workqueue is different from failing in the initialization
path.

> 4) Adding support for failure to nvme_start_ctrl() adds complexity
>    and does not look useful due to the above 1-3.
---end quoted text---

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
