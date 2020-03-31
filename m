Return-Path: <SRS0=yNQM=5Q=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD52AC2D0EE
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 15:45:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F67F20781
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 15:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AQoZtAAY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F67F20781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=m1eQPC7VXs5HZ9kGipFsEBkCHXCfzLYhrAl4dPj1AQY=; b=AQoZtAAYGkP/ON
	ImTkoCg7GhhW79HHpl3noMDWXQemTxoHRNWCSbKyH5WKgL8ust/C6nyax1d1QFxGwBOrEGjNl7rIq
	2sub5vRNbYPWsXUMhNT8uC3lOR0dihdzSU3tUQY7ZQvOBX/os5FHjbqaMx9a6VoCK1TDpbtQT1eiH
	Bf4qDFsyCfYu597pya08ArthcsztA+UHBZk34CbpbolxUTYEbNDeLMujsp1QMJ8EbOEZRyFMNOUvC
	hCNPjh1Skko2jBjooaxuQeIU+FZGWsWEhotH86ZsdVY07tQ71+43KZ8wKkI4/PjnfVC1hUet7dpIy
	FgSu0nLnkkiQLaxtEq1w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jJJ5D-0004UB-6c; Tue, 31 Mar 2020 15:45:43 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1jJGsP-0008Dz-G2; Tue, 31 Mar 2020 13:24:21 +0000
Date: Tue, 31 Mar 2020 06:24:21 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Alex Talker <alextalker@yandex.ru>
Subject: Re: nvme: Duplicate cntlid error
Message-ID: <20200331132421.GA27280@infradead.org>
References: <3cfc539a-07ba-3757-073e-dc81f9c0c824@yandex.ru>
 <2d02e844-5700-64e9-26dc-50b3958d2ab5@grimberg.me>
 <00875be1-c0bd-9b25-efa3-4236421678b7@yandex.ru>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <00875be1-c0bd-9b25-efa3-4236421678b7@yandex.ru>
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
Cc: maxg@mellanox.com, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Mar 31, 2020 at 01:37:18PM +0300, Alex Talker wrote:
> but not in any MLNX OFED driver back-port. Does Mellanox has plans to
> include this feature in next release?

That is completely offtopic for this list.  Also please don't use vendor
forks full of broken code, your life will be painful and of no
interest for others.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
