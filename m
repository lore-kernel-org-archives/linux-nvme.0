Return-Path: <SRS0=morU=AH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3160C433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 10:35:50 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F6E120775
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 10:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eF1CWoyd";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CSiPpKIh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F6E120775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=DQ8rX/BoGzSaOrw/Pz8r+iPSbZH7XfRcjd1AlHME/0o=; b=eF1CWoyd7ABlx93x3uqWoJfB2
	2tmSbYmsz6b/gUBxkySLM8p3fBAyzDO0aZ+V0lSSRuEEVI0cOE+tFgpLSbQm3h4MdjGDQJTZVvVhg
	aLbDwnbuBLtvBh2eU9UD6plMhpPnali/2r/Ftxq2jifyYtkqSLr8QRQkDzIShnzOnOB95CFEzFU4Q
	c0NoeFamNmAi1byre7ydRw5i9+QTcC3Dc6+rx9L4j0HYtN0egOLd2sbEdeOvhf9tBHaaZLHPfuRXO
	UxBERGcVSe5uqom5TWO7MH536JDyhiP5Y9mOp/qfOSiEssh0A4BeUVkCkbVckWWaDj7yehLCe1CZE
	3HqZPR4+w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jolhx-0007Jf-1s; Fri, 26 Jun 2020 10:35:45 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jolh4-0006b2-U7
 for linux-nvme@merlin.infradead.org; Fri, 26 Jun 2020 10:34:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=ttM3K97Opw3P5YgnRz7EfFbdq/l/YhzWIc24UC0lj3I=; b=CSiPpKIh96WKN5UhnH8d6OgAt1
 iyTi+Q7BBsVaC92QnDi9Hkpqp+ylF8qI3KeB4EqMVxSJNWt9XrOrIWPgaNZBVXbVQ8ggpJeDz47do
 PEH4zSdm0UIK/zu756MoQZTqeTABUOuS8FD+jRNh/cj4XiGoW6np9FHbT6B3EMGHvLocxvZ2Bg7yD
 i6eLzC9V4vYdAJPAyod7alewiQBJF5Rr4Fn+ssFNqMuN/Wg8FAIRLxrzJc70G0MDI/QHJOAmJFGpE
 ILhsDieeO3PyykKvqbWdxYj+TNfL9pu3UfqhWfhJ3c6cDPBt4rnc6FhuprwyPJOMOV1WgrYK9JImX
 BvwUN9Lw==;
Received: from verein.lst.de ([213.95.11.211])
 by casper.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jolZ0-0001Ae-Tt
 for linux-nvme@lists.infradead.org; Fri, 26 Jun 2020 10:26:33 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id E4C3F68B05; Fri, 26 Jun 2020 10:28:44 +0200 (CEST)
Date: Fri, 26 Jun 2020 10:28:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: Re: [PATCH v2 2/2] nvme: Use USEC_PER_SEC instead of magic numbers
Message-ID: <20200626082844.GA24570@lst.de>
References: <cover.1592980985.git.baolin.wang@linux.alibaba.com>
 <440d84877c3bc0917790466ee85753919fb29cb5.1592980985.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <440d84877c3bc0917790466ee85753919fb29cb5.1592980985.git.baolin.wang@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200626_112631_497833_DBA4D2FD 
X-CRM114-Status: UNSURE (   7.81  )
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
Cc: sagi@grimberg.me, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, axboe@fb.com, baolin.wang7@gmail.com,
 kbusch@kernel.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks,

applied to nvme-5.9.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
