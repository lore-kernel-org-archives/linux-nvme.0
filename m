Return-Path: <SRS0=pxZf=IH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA0FC433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Mar 2021 10:30:27 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9253C6525D
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Mar 2021 10:30:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9253C6525D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7xin8YcM8UXA1N0nCbD4BbyDBrLeWo+T/XKKPOETZ9c=; b=fblcaYMftS0NqKNN4mvy3DZMI
	b+mIWr6++a1qHOIFug+jxUVAJF5J5qbh7JeCAGKa5AeWHEEmZGMLqEIq089RWfGF8PY2rJkBGqWTS
	bpNiHLDYunrLCABMZXwR0NyfAxJd6D2fLRY3svJ4s2NwnmHGLpfsAqJcDBG7VGopEzmh2n8sOfoAy
	TKVo8BQUD5sQNvnpM/CPnLGzoPy0KLHHcZb9BMNRDem9FHFHK7Vx/2SaSmL5HJ4eBzrPy9o8KoQx1
	MzFY9gHputHHMMD0Bx9oYRyvN7YwPVy5qd4Z0xku/w2JsdVmyIVyue8YDEOtaYUWYqeEg5ma2VoXp
	yySaR08dA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lJZd3-004DTy-Jr; Tue, 09 Mar 2021 10:30:17 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lJZcp-004DRt-1U
 for linux-nvme@desiato.infradead.org; Tue, 09 Mar 2021 10:30:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=JfcaAWiL9MX/KzgqZFMd5GxaGaNC7KsyrSBFfXwwLXo=; b=UG1qJCiY6w395LakKj4YnYSy1q
 zoQkR9c5JupceQJ+XEG8ZIo6qOYKppgcWpcWigmDxepVv5xF8rOnA7jwF3iscVBbuzY/aNcC/+NQe
 e8aTGe0u1nUtYBb472jPpqmUOD5F321I5XWXqjeu40KeVCdz9lbuv5D7dNgzrq1sj+rOPIuZY1+z3
 2cTmlw7cbkNnBt+iZDxkiPaHj3ANP6Hu3bjSq2oQ6KWY1uxohW3sWPahit6lZvDmibY+y1l1DYHDN
 4DtsokEazvEV+BxdSKnrbUE2LCPgQfMPi2F9GwDTg0T4mmAupNXyKmmP33qL0+xhKW9uTm6om8g3T
 ePWXjJog==;
Received: from verein.lst.de ([213.95.11.211])
 by casper.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lJZGo-000QY9-SO
 for linux-nvme@lists.infradead.org; Tue, 09 Mar 2021 10:07:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 57E2E68C4E; Tue,  9 Mar 2021 11:07:17 +0100 (CET)
Date: Tue, 9 Mar 2021 11:07:16 +0100
From: Christoph Hellwig <hch@lst.de>
To: Minwoo Im <minwoo.im.dev@gmail.com>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvme-multipath: use nvme_ctrl_use_ana helper to check ANA
Message-ID: <20210309100716.GB7310@lst.de>
References: <20210225105744.69579-1-minwoo.im.dev@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210225105744.69579-1-minwoo.im.dev@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210309_100719_678717_19B80034 
X-CRM114-Status: UNSURE (   5.48  )
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
