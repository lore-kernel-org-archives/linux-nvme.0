Return-Path: <SRS0=5VvL=N5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C89C433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Sep 2021 07:49:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAD7561103
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Sep 2021 07:49:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BAD7561103
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wd5+M57yBo6KybPlKE2hR8saLUrfKOPAKm5J8T7nsZU=; b=JF5P0OJlZSGXj3
	KPY+XghYMcKwVjS1C34JKpE89PwWt8TrYWk/ihzKQh0tQv1NPboJudQMCNE1wwN1S5Swl987hh9Un
	kI7D+kbA4J4WuuKd184xg/MT2tT8WTcvjmSks9Vb8cSrZQwJSrz712LkqNP+vZJaqkd6JXDQ/tOuf
	bxtsj7i/fFBaSDqMJnMiICQ93hAUI8mKLLJB3D4t9UOH+up80etgRNHGFhYIGL37BQf80q/oAMIjl
	jqXIR1d36OKVpLqwj6fmJkQnhYZa9dDIYPmkWpakjF9F0vQh0hqQYNofhM3Ylyl1SWiR6tECgjwdw
	mLTDz+QD8/y1q7gDUZPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mNVqa-002min-Pj; Tue, 07 Sep 2021 07:48:48 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mNVqY-002mhj-AE
 for linux-nvme@lists.infradead.org; Tue, 07 Sep 2021 07:48:47 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 66F0568AFE; Tue,  7 Sep 2021 09:48:44 +0200 (CEST)
Date: Tue, 7 Sep 2021 09:48:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
 io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 anuj20.g@samsung.com, javier.gonz@samsung.com, hare@suse.de
Subject: Re: [RFC PATCH 5/6] io_uring: add support for uring_cmd with
 fixed-buffer
Message-ID: <20210907074844.GD29874@lst.de>
References: <20210805125539.66958-1-joshi.k@samsung.com>
 <CGME20210805125934epcas5p4ff88e95d558ad9f65d77a888a4211b18@epcas5p4.samsung.com>
 <20210805125539.66958-6-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210805125539.66958-6-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210907_004846_545362_D0318B19 
X-CRM114-Status: GOOD (  10.84  )
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

On Thu, Aug 05, 2021 at 06:25:38PM +0530, Kanchan Joshi wrote:
> From: Anuj Gupta <anuj20.g@samsung.com>
> 
> Add IORING_OP_URING_CMD_FIXED opcode that enables performing the
> operation with previously registered buffers.

We should also pass this information on into ->uring_cmd instead of
needing two ioctl_cmd opcodes.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
