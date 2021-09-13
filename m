Return-Path: <SRS0=T5dq=OD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DFDBC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 15:07:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAA2660F36
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 15:07:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BAA2660F36
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iuktLIzarvHjEJlKtxuBEUVUXP0f2R+/dgHk/7kC0YA=; b=lEyX+KuMq7YjOU
	wcuTjlIB2rHyN5UMcNJ3DBvWM/DoGNGez6IA1rgLei6bJSO12pDuJ+JohaIKxNyRgd7KO9BPrVsk+
	vrzRC/yIheKSc5aYtXjUg9USELnh+KQLpA7kBPAHkCduKYmX9O4CA6/JZyHTtKxHMpn+ytWxNVtMC
	uuD3GBdYu+CXbOBE/AmTZgvJSu4JprEQcj9Rs5YnGcKILWcX7T6vdpVZX2JP9av73prbdzYPUSxHT
	I6aHIv7NpQVqeRPuZKW6npE/+aqMWmBx3MnKFJ000sh5ALeGXCfuGF4TKReyN6RenqfYAdZ/qRjdA
	/YYxb9GAfuASBXGgt1ww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mPnXz-00286X-Ej; Mon, 13 Sep 2021 15:07:03 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mPnXx-00286O-IL
 for linux-nvme@bombadil.infradead.org; Mon, 13 Sep 2021 15:07:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=0YHLZvLC/xYlfH0XYhEFmgV1nKxhlxOO7Z/IK6ZmpAI=; b=wQ6omweJvZS4ApGonNoEupv7kV
 +gb1gtbETbRcSbjvaXb88yY959VqDFSIj+L8P5g4dlVKtY3RqghM8wz7qROkSW59AvWViPLSKbNAW
 +E4lOdDO8UYam0yO0pDQcDXur4ovf/coqcLd5wlpUxWA8bFW8zFeFdUXDbzrdrePTnlrakKl+n0oj
 U3lVYtRLLY5a9tO9s03nJFYZ2F92E1VO36fCXG4+cbJ59/w2HoQLZAbA0l01Lq+kQCSZ5F2vc4opM
 b8VKq/pfTq4vIYZ57ItGF5jjyy6CncI9P2GavCy2LPqxiSkpzgvn9TM9WyZzGwIbmCOgm21TBsjnf
 npl3IoVg==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat
 Linux)) id 1mPnWQ-00DeFk-54; Mon, 13 Sep 2021 15:06:05 +0000
Date: Mon, 13 Sep 2021 16:05:26 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ruozhu Li <liruozhu@huawei.com>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me
Subject: Re: [PATCH 1/1] nvme-rdma: destroy cm id before destroy qp to avoid
 use after free
Message-ID: <YT9otjIM4WY+sa+7@infradead.org>
References: <20210906035134.14789-1-liruozhu@huawei.com>
 <20210906035134.14789-2-liruozhu@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210906035134.14789-2-liruozhu@huawei.com>
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
