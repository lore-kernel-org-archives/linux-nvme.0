Return-Path: <SRS0=KTc9=BF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29486C433E0
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Jul 2020 15:44:14 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E979520714
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Jul 2020 15:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HkhoNXOR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z18Lx/2U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E979520714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2moTha1U4BHa14b9qWVb5gmIF0BAu/7tNBsXG2bhQVI=; b=HkhoNXORm9rAmPgxEW4oxu8tS
	qYjjGq2F0XwoVUdmbhoJ1n1AysoY9KDWYQCgDTcuuUoFnOzwgEdO1PeRf3FjxFvByGrYZn81x3sMI
	9j7t4SfnSTJMcCTVT6gR9k3OHHreJrnpEhe3Pl0xB1jjzcXLBPXlv+8PNTukba/2Ro1/PuW4ZU1Oj
	LFiPdnOjVxBiiyN0WWc6CTRCV/A4V0O6BWmSfTOqKW2WbEU5MX/Uy/8JqaNVbOKvpwITNWZolsVdX
	Pv0mTDsy0V1l7SU2UE7fB7gA7FoDZcT2E+mSdOKmcfRvQvH4rIQTNysoae/abyFent2YkcSS6as+Y
	gwiitYgKg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jziot-00010J-SU; Sun, 26 Jul 2020 15:44:11 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jzios-000109-6u
 for linux-nvme@merlin.infradead.org; Sun, 26 Jul 2020 15:44:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=PwQfeucBAthj62YHwv24a2v4MDpmLeTOUHpUQ/WdSDk=; b=Z18Lx/2UeUI5LCcJh4l+8e4ISP
 vdZdcmwtWcwncFzwTVOXGwayPPZ7ZPfm1P0J3Ur2JJNGW8remoaL8t5w4JjfP0RPJsMOYs2D2dFB2
 Kxy+L+J2kOKU8u/zyYKv0ub45AgH9jngCKhNJTr0UZ81kYSP69qOZfn1LTy1+zEeWO7ERR3jCBNsa
 NCa29EtAhZw9BkSdjZ4jp28XQ1Z3SNdVNy34rz5hu3bbLLVmtu1PckOgLIKtDL5OXl1sW1qPa5JYD
 g27mX3+AryMLEewDRfjGhgc25SpJcP6FTIMO3I4P1YalgzjpRq0j/voS1DjYbgJ6qrOHdN47WHDpk
 0XSFpDag==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1jzior-00085x-7X; Sun, 26 Jul 2020 15:44:09 +0000
Date: Sun, 26 Jul 2020 16:44:09 +0100
From: Christoph Hellwig <hch@infradead.org>
To: James Smart <jsmart2021@gmail.com>
Subject: Re: [PATCH] nvmet-fc: remove redundant del_work_active flag
Message-ID: <20200726154409.GD30848@infradead.org>
References: <20200724164048.49936-1-jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200724164048.49936-1-jsmart2021@gmail.com>
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

On Fri, Jul 24, 2020 at 09:40:48AM -0700, James Smart wrote:
> The transport has a del_work_active flag to avoid duplicate scheduling
> of the del_work item. This is redundant with the checks that
> schedule_work() makes.
> 
> Remove the del_work_active flag.
> 
> Signed-off-by: James Smart <jsmart2021@gmail.com>

Applied to nvme-5.9, thanks.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
