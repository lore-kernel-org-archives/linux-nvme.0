Return-Path: <SRS0=G/Rm=MN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BC9C636C9
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Jul 2021 06:02:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4457F6101E
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Jul 2021 06:02:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4457F6101E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=C9mgml6OKjYBg8CpwwzsTXLRpst35zOgKHUglQ8uhNY=; b=RBSmypwtKbCDsr
	yWSC+aH2wBFfu6puJYNVx2kEpKKJbQm5Y4v6RT2342hhaGqblHkSuPE+orVdggrf665eIoyqpk3M3
	xv7ANm2RsUFu9e6k5SpwIE08hL3J+amD+He0NqF1f0WhGVxFxwcmAX/Ah2wug5ik/BklW4mvM2fpZ
	tI+MrERcviCineWqd7k5Oh7aambOcUUThs4dgYakN1Ooob/9/B235HOEcyRf8Sv1OSqyyIF4o99jI
	cJzM58ggZxMP6xoGLHGP/vW9aV7omAzzrE6QjReWXQXMm0hMSqgG/w+nXdtItL6uiDq+/bDYqrIhX
	00OxIoX+gZdvdhBKbsyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m65JY-00EY2l-Fn; Wed, 21 Jul 2021 06:02:40 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m65JW-00EY2a-GQ
 for linux-nvme@bombadil.infradead.org; Wed, 21 Jul 2021 06:02:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=xTrSR5FxLTHlT683MT6fZhnMXRsjOihJmr0e6uIW3yM=; b=Rc+7IacUzDUQtYIFZW2gRbVdd3
 9xI/Rw0oLJ0nr1e+yVupW2shFd4rmvF26jfL2tGhcT5PKB1DxNga2HuUhiEzRySsw7y/ZBZc42NeC
 ICUzRai9woLhWaQVtf9oFbMZcuTKyaOnx1Whd4WcyHEvJqyYxRWzmytOlZn0jSPv+G9RI70zFKjqZ
 Ai0XpXgZUCMUkG4exBmhHWtdvJYafuPkVIrQBhADoDVKHvdvCRcEUq5DclawRBTRAp8F9+ARXxHn9
 MyhL4MBLwus2zuHUpXV9Sem46+FyKGEKhlS8X1yl069GJ6uOV0WeFNQJQ7kLTuZgmsIMSSGb4ICjq
 5VBzK4Ug==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat
 Linux)) id 1m65JR-008r4v-Lz; Wed, 21 Jul 2021 06:02:35 +0000
Date: Wed, 21 Jul 2021 07:02:33 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andy Smith <andy@strugglers.net>
Cc: Keith Busch <kbusch@kernel.org>, Linux-nvme@lists.infradead.org
Subject: Re: 5.10.40-1 - Invalid SGL for payload:131072 nents:13
Message-ID: <YPe4efNRl1x+zNWw@infradead.org>
References: <20210720220733.h324jghdtqorh2hs@bitfolk.com>
 <20210721003434.GC2005888@dhcp-10-100-145-180.wdc.com>
 <20210721024725.igwl5zyh2gcuav4c@bitfolk.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210721024725.igwl5zyh2gcuav4c@bitfolk.com>
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

On Wed, Jul 21, 2021 at 02:47:25AM +0000, Andy Smith wrote:
> to reduce it to an amount that would never be used?

Just the mem parameter.  With Xen dom0 you do not have an easy way out.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
