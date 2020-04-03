Return-Path: <SRS0=Pknt=5T=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2450C43331
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Apr 2020 06:49:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7245220757
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Apr 2020 06:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ACPzBm9F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7245220757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2nfKGBNoUq2jfF4Ik1+mITAVwHQamAbxWl+lFEOQBqw=; b=ACPzBm9F+TGnCZ
	OGBpzRp8MZ8rjRuqM35NBqVp95Q5IZFSrY4/4z7k336hQXxuBoP/7jO+NlOYvpk0Qd0dkTGyQXhaR
	3KNby0y+7fIafJvtyjOqtGTAB6JQJNKGeOqJGzm9ooq7RqfBndfR9OUKSQrkbKdVtpkPmYE9dpNBB
	UZcbOQc8rPUlBUG0fD5DrvKBemMqAwnVbDc6ybD0aXpuR092SZy+7YGXjGsTBm0cC9LgFNl1D+PPH
	jfBa3njCUHFH/24c4M7nXe/6876N3PKrMNhTA9w2kdgeHDZ9L4N5QPskMfDfmZPVH76fdsgHLrgNS
	M10TrDRsBK6EyOi6Ihqw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jKG9C-0005k1-I0; Fri, 03 Apr 2020 06:49:46 +0000
Received: from [2001:4bb8:180:7914:31ae:9e5d:34b6:7946] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jKG9A-0005jT-9e; Fri, 03 Apr 2020 06:49:45 +0000
Date: Fri, 3 Apr 2020 08:49:41 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Tony Asleson <tasleson@redhat.com>
Subject: Re: [PATCH] nvmetcli: Allow different devices for make test
Message-ID: <20200403064941.GA309222@infradead.org>
References: <20200402155443.91120-1-tasleson@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200402155443.91120-1-tasleson@redhat.com>
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
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks,

applied.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
