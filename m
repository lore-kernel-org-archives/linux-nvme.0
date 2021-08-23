Return-Path: <SRS0=nO+g=NO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F20C4338F
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Aug 2021 08:03:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 319756135A
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Aug 2021 08:03:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 319756135A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iuktLIzarvHjEJlKtxuBEUVUXP0f2R+/dgHk/7kC0YA=; b=JBPennbLJtMN3D
	0SO6UQyeyt7HbxoDGGK8L8OBwYGyZu5oMbFDnwLTzntUJwVicozpYXwQiD3t/dDyWFLjtIZUE0A1p
	7f9V7sfiFh5mFqir3a0E8KwJVWPdQvrpZlt2dA81ZRyNX49UnRHwGOwu7fyzH5z5k51Z6yp1RzwJE
	UcMxlPpSvrgh6qIL3mjGKrjSSsRRUlKEBBI7LyPbzk4f+6w5aAhb3rRHFqn772AQpT8RpPCWg5ipQ
	7Gza58nq5NJA3B2mMeDnQlIGJA7U1MhY/avAaSoS8OJFGVxp9Q/abPfS3K/mEI3FSK+j8l6vJP0f9
	Az6NioRI1Jz4vuqS8TOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mI4ut-00FqMb-DW; Mon, 23 Aug 2021 08:02:47 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mI4ui-00FqKD-Gv
 for linux-nvme@bombadil.infradead.org; Mon, 23 Aug 2021 08:02:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=0YHLZvLC/xYlfH0XYhEFmgV1nKxhlxOO7Z/IK6ZmpAI=; b=REOu/Y7RZTNXQ77H+7M7+0SGgN
 tucyMjIduGWdDmhUG2tZsD2ruCmikVvOzz8XJPUjNKM1K/fLVOYJDTA4qLC7kKjvlgHwg57YMH3Db
 pqvDyS+xn5dxRDGrgiD9PEBmym9/oygH8Hyq0TzlhLplHmW8DpWeOmflKzTAmXp7R1/bIc47dgiMP
 pMKLEJj4HwjEH3nbmFQu1X/EjPAAPf4QIrkSXRjLqR4Hyvt0KgPKWPQ7NIVc1xtRZyEZVigCzCshn
 5/691P88KjKBkD1DDEolM9Y6w0x+hW3JspqGvMJ8ZokL0sEuwymZvQuFHTUDnHcpX0wTuD8nOss6u
 XvgnNlcw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat
 Linux)) id 1mI4tu-009SLT-3t; Mon, 23 Aug 2021 08:02:00 +0000
Date: Mon, 23 Aug 2021 09:01:46 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>,
 Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
 Wen Xiong <wenxiong@us.ibm.com>,
 Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH v5 0/3] Handle update hardware queues and queue freeze
 more carefully
Message-ID: <YSNV6vpaEnzc0Yv4@infradead.org>
References: <20210818120530.130501-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210818120530.130501-1-dwagner@suse.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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

applied to nvme-5.15.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
