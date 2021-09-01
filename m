Return-Path: <SRS0=EXAn=NX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE73C4320A
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Sep 2021 12:26:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF9F860F92
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Sep 2021 12:26:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CF9F860F92
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zKsdXTx+TP17jbmL+7duH4CcYnHFvzOhNT9yhi94fB4=; b=fK6qX5tKu0ozSk
	ewNO0OLl8b5OJcQJoPDMAuaJnh6yNe+9AWJ6FiCMXtMyaRmDImYvBNATk5fpb7bZVQgDi06O4FWpC
	g7fR8vEMQ/NcmRSfj9cm02BuhWLMwVlZNTAWTdux2X9DsKDusD97XUhJnDlpLF70UofwWqlsTv2YD
	diRJj2G5gDkTDROQdcEaBsWBtayPZQ4rNV5VcX1EKq7+X8M9ZAXa5bVeNxVMQP/zMbH+cKrz61gEX
	RqFe7i2nHEfFZILU+GCQ5sF4PGs6o6v930wH03O0V8mOnCJd9Fy9e3q9hzJgXt0UfSLO34gFvvHWx
	1lCwlaxZskq03yXjR3tQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mLPJX-005w06-N6; Wed, 01 Sep 2021 12:25:59 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mLPJT-005vz3-Mk
 for linux-nvme@bombadil.infradead.org; Wed, 01 Sep 2021 12:25:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=j04+nObtEo9Lx3wgZg+CisiSWMhsMj0sdOktBlelLfc=; b=VKgUay1NPt84DBlLxiUAeiUH92
 568nlOHq9RmYLOJ8lbQTtu8zf0snIrD4tFoILO7R/xDo0FCdMIOlK+Iqiu88YUVCoXnt7IzXvwftn
 NFQOJfbjplYjPA3ypobMKBIiC3RWOlE1mhvbsDd3HuN3S2UxrQjmaqugkvG/lgMBs5poW0tCLPliy
 CwdppGclZWlsAFpSXt7QwHLeg6ezeZLPjN+kx/4Wl53j11icr+Ds/vA6qf1rfbkz2MuHjAefwdtK8
 Vca4qNcm0JVHEx6w+MhKkSLSjhAiwPK9CHQ8hZwDrHFzzH6jZY51DAyU5xqX3jDMQRnlziKUU5Hx4
 KiEwQjSA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat
 Linux)) id 1mLPIp-002IwP-KV; Wed, 01 Sep 2021 12:25:33 +0000
Date: Wed, 1 Sep 2021 13:25:15 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] nvme: only call synhronize_srcu when clearing current
 path
Message-ID: <YS9xKzRWW97L6ZN9@infradead.org>
References: <20210901092524.131610-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210901092524.131610-1-dwagner@suse.de>
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

applied to nvme-5.15 with a cosmetic fixup to keep the lines from
overflowing.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
