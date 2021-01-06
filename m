Return-Path: <SRS0=xG/4=GJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF38C433DB
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Jan 2021 07:59:32 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68D8A22CB9
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Jan 2021 07:59:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68D8A22CB9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EWc14xLiGK2Xo3gN2KgRMK8B+EiyV2kuKhgMZWCk7fk=; b=xTnHtZ427R35yjfBst6lTBXuR
	qcor5WNTNatUpyX1LSbA2sen16RLYkQ78+aJoDwOE4Py0lQkFICqf8YfQaSa/Jy+PiXaio75heyvp
	FagJzvUcnE6o7uDiuFz9/8vfVBJNmnxBzyTUO8FCAtOKvPMzHNYUZ6Z5jaecvxZ/8sDz/vWTlxVht
	NVfz4vV+EYvh71ALzUu0V8/NsSJDu7NhhR885ZEy4jxRZLzHsq/lhy1Q8Q2BBiJMF6C6EK0XAJPqO
	0+7vjvjtojhSNQhHqypfRYEOa7wsKzwdnsEqHJteuip8oGN5mzLvb655VCk5Y+t3+1UKUCfvuLp8h
	akLZ0gC4Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kx3iy-00005G-H4; Wed, 06 Jan 2021 07:59:20 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kx3iw-0008W0-8T
 for linux-nvme@lists.infradead.org; Wed, 06 Jan 2021 07:59:19 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 0870967373; Wed,  6 Jan 2021 08:59:13 +0100 (CET)
Date: Wed, 6 Jan 2021 08:59:12 +0100
From: Christoph Hellwig <hch@lst.de>
To: klayph@gmail.com
Subject: Re: [PATCH 1/2] nvme: support fused nvme requests
Message-ID: <20210106075912.GA31712@lst.de>
References: <20210105224939.1336-1-clay.mayers@kioxia.com>
 <20210105224939.1336-2-clay.mayers@kioxia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210105224939.1336-2-clay.mayers@kioxia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210106_025918_434204_C49B8E40 
X-CRM114-Status: UNSURE (   7.36  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

I really don't like this.  There is no good use case and it really
affects the I/O submission fast path.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
