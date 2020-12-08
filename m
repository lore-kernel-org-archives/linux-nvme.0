Return-Path: <SRS0=lokR=FM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3ECEC433FE
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Dec 2020 13:56:24 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26CDA23A53
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Dec 2020 13:56:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26CDA23A53
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=lTXgRi7SHEw06lkNHBlHqp3VD2fwMBhmy3jWuYn7TPY=; b=sY5vo8gjYTCwv5RMPIUxKyx8x
	JjEUoOS7u4RpQULafdrRoXzWDTZXtWivg1HCKZPTq5i0mrdYbaR65PSsmMyKJxWoVJ7wpXqVIIogE
	3p5yu0TFTPE8hsw6EwJuNlQLBeYFbTB/D11ZY7NIrqv3k+nNmsUmx1BBd7h7/0tJAW3NlIReiCJgD
	UOxT5WayFfViA3CbafQ1bp0aJlgmNVKHmBClGGdDIa3iIELlkj5Qcu7io6g51f9MjJHTZDd+3axro
	K9TfTSE0X4aSKM/k9OocLRkDxsAqpgq+qxhk33GpJFn813uKmXatBnjWdDtDf8ORo2WE4W3Nq/0Pl
	D8uirZeQQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmdTZ-0000Zv-Nt; Tue, 08 Dec 2020 13:56:21 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmdTY-0000Zb-2l
 for linux-nvme@merlin.infradead.org; Tue, 08 Dec 2020 13:56:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=XYDpXg9CTQvvO2zGH4cqKQUFyn+zcgg/9AwNB2fd4cw=; b=Z0HXQUhYW7HNbygyi/Sn2yiCAC
 0qdlBZ5wdxINMkkf2VfB4W4Ux6eUuNStoHRBPdgVBEcMVPvSVczD/1y4Yr6ag8/iqSYsVwn6iIZBp
 7aKs0HoQAfn0hGngwjCVXM7HVFWGUEVJ1308vJgLYUZSOggeSYjPw/3WgQWHV4ag668ERokl6HLac
 0woP6V+VgOVyaZiBJjxRb/CgL77NCgOMBK2uknGap9NITXktBRAFAQhy4mfLgwx0OoeqlvHMnik3C
 XkOE20fiurDxLSH9KpeiPUrkAS9HEMfYdxLpWZ7sAMqT9IROQCTe5No38uBji3N4chgVVKySytEm+
 YPPPGFow==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1kmdTW-000051-Se; Tue, 08 Dec 2020 13:56:18 +0000
Date: Tue, 8 Dec 2020 13:56:18 +0000
From: Christoph Hellwig <hch@infradead.org>
To: James Smart <james.smart@broadcom.com>
Subject: Re: [PATCH] nvme-fcloop: Fix sscanf type and
 list_first_entry_or_null warnings
Message-ID: <20201208135618.GA32719@infradead.org>
References: <20201207202940.2904-1-james.smart@broadcom.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201207202940.2904-1-james.smart@broadcom.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks,

applied to nvme-5.11.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
