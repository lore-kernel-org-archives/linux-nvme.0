Return-Path: <SRS0=j3u6=B3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A86EC433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2020 15:57:12 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53448208E4
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2020 15:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SUJ/L2KQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="C4tMPTON"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53448208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=MTBlDMb/Yyjg7JdDNqOCRk5El1lHT1tySxN4XWjZfOE=; b=SUJ/L2KQ8HNXvZk5yl8bLFsD1
	m9UPXA2PteoPXYtGZBo3HAvcbNAr9xTOdFc0XW4WVGI+LSYWi3K00Iea+VWdimxZxQzqXo0+F70wt
	m3kpPwloSEq3WNbvk2SXhHBGFu4HyjA8ui3lMPwZT3imtMoNFNT2hgdVF6DY7LTqod/6wcZbH5lCd
	0Yi2ILqIVQpTlp5mtoENtUL+CTbskNWDFIr7H7x4QzFqRo+7BLuSrRpZLHnlU+LqZBLSh6oSJ8thS
	h1fbkD4cRC0poqrPoQ9FxE6nLHHi3NPJ5grAAWuS3FJmKI6WL0kWM3t6N0MmH3RVhvndvT1mAAg39
	FqM84zLOA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k7hVR-0003ZC-CZ; Mon, 17 Aug 2020 15:57:05 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k7hVO-0003Xq-5j
 for linux-nvme@lists.infradead.org; Mon, 17 Aug 2020 15:57:03 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1C3C320825;
 Mon, 17 Aug 2020 15:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597679820;
 bh=AyJyeBUIrLG0r7Q9Vo+RWqzElD6xhH3UK5WZ5y9uLyY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=C4tMPTONxbWjnDm8fnGLSy4ebkMPC5O4CJq4RTVft4DO2Kq1WKNzKCLZstZ7SjSBr
 6njgN4kXVE++dvsTW6NwqrNf7YSg4H36M6M0I8Fg3IBfFt3xqcXrxGZq3VeC7+gF2U
 tzb6b8QyDc3CMzj2cmF96YWyMm0xK+pjwvz5Gtxs=
Date: Mon, 17 Aug 2020 08:56:58 -0700
From: Keith Busch <kbusch@kernel.org>
To: "Ahmed S. Darwish" <a.darwish@linutronix.de>
Subject: Re: v5.9-rc1 commit reliably breaks pci nvme detection
Message-ID: <20200817155658.GB1221871@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200817135011.GA2072@lx-t490>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200817135011.GA2072@lx-t490>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200817_115702_330958_C8C88A6E 
X-CRM114-Status: GOOD (  12.57  )
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
Cc: Jens Axboe <axboe@fb.com>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Aug 17, 2020 at 03:50:11PM +0200, Ahmed S. Darwish wrote:
> Hello,
> 
> Below v5.9-rc1 commit reliably breaks my boot on a Thinkpad e480
> laptop. PCI nvme detection fails, and the kernel becomes not able
> anymore to find the rootfs / parse "root=".
> 
> Bisecting v5.8=>v5.9-rc1 blames that commit. Reverting it *reliably*
> fixes the problem and makes me able to boot v5.9-rc1.

The fix is staged in the nvme tree here:

  http://git.infradead.org/nvme.git/commit/286155561ecd13b6c85a78eaf2880d3baea03b9e

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
