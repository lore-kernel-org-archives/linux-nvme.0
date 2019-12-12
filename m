Return-Path: <SRS0=hCdm=2C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A55DC43603
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2019 10:40:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF38D206DA
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2019 10:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GC9p7u4G";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="eeUr+dLt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF38D206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:MIME-Version:Subject:
	References:In-Reply-To:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jZ53JNSLtoPzt0PviOVdy8yd3hZ9pZqCu/83ihHvano=; b=GC9p7u4G7Ffutt
	epVoh8pOQBebcetUz99qNzETrf+htYWe+Vsaam1OkM1CWVpEk81M+1UswN83XbhBLOLZhFzELoB/c
	c3wayQaG9ke+09EmlGliTmSoqgiJbWfPDZjq2PwIIJsDjogdkveLooG/9UdNapoTzuxf2zbvB1Q/r
	au+6TGjRqgMEiXhGQq23F3HzcJy9eCVuPYMZGEGBtd+90lzY+0FEiznj8GAk1EGo0J2jJH3dE5u/3
	0MOn1Tk4a1MUvr5ZR2dzqgB/mC+jtH5SQelbq1MOnTuC/5q1Nin7CxurlK8wfpJHePIbXCYemejJF
	gLaHsiIsb7OXMpDPPkZQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ifLth-0004R7-Ru; Thu, 12 Dec 2019 10:40:41 +0000
Received: from forward500j.mail.yandex.net ([5.45.198.250])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ifLte-0004QH-NA
 for linux-nvme@lists.infradead.org; Thu, 12 Dec 2019 10:40:40 +0000
Received: from mxback4q.mail.yandex.net (mxback4q.mail.yandex.net
 [IPv6:2a02:6b8:c0e:6d:0:640:ed15:d2bd])
 by forward500j.mail.yandex.net (Yandex) with ESMTP id 7BE5311C139C;
 Thu, 12 Dec 2019 13:40:34 +0300 (MSK)
Received: from localhost (localhost [::1])
 by mxback4q.mail.yandex.net (mxback/Yandex) with ESMTP id RVKBZUJfek-eXEat4GA; 
 Thu, 12 Dec 2019 13:40:33 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1576147233; bh=sUzG0p4jka1ZZAzp8zAKj3z/GwPm3KRxG8TXIfO5Zhg=;
 h=Message-Id:Cc:Subject:In-Reply-To:Date:References:To:From;
 b=eeUr+dLtS+7C1sXnAHSjEpSUHJGbGyQlgY7G8FK2ULOcOsN2JXxclx48dMOZPaMNS
 vNhSgMv+/w/ZO3fEJMi8KyalVp40SE4TZ/A/QxM3vYTs/Lu/SmR7qedjKWKFzapUqQ
 VbNY+1Ck1BVG3Eso+QWX1yEl1YuUbmgJEx/K8xMY=
Authentication-Results: mxback4q.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by vla5-4a37cde0b550.qloud-c.yandex.net with HTTP;
 Thu, 12 Dec 2019 13:40:33 +0300
From: Talker Alex <alextalker@yandex.ru>
Envelope-From: alextalker@yandex.ru
To: linux-nvme <linux-nvme@lists.infradead.org>
In-Reply-To: <3861821576146988@sas8-ed615920eca2.qloud-c.yandex.net>
References: <34086421575664793@iva7-8a22bc446c12.qloud-c.yandex.net>
 <20191212093341.GA20683@infradead.org>
 <3861821576146988@sas8-ed615920eca2.qloud-c.yandex.net>
Subject: Re: [PATCH] nvmet: fix null-pointer when removing a referral
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Thu, 12 Dec 2019 13:40:33 +0300
Message-Id: <4206371576147233@vla5-4a37cde0b550.qloud-c.yandex.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191212_024038_933777_0BADF524 
X-CRM114-Status: UNSURE (   4.66  )
X-CRM114-Notice: Please train this message.
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
Cc: Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> nvmet_referral_item_ops can be entirely removed now.

I was wondering if removing the nvmet_referral_item_ops can cause NULL reference again
but things went ain't so bad.

> Otherwise the patch looks good, thanks a lot!

Thanks a lot for responding on this. This patch really matters to me,
as everything else in configuration seems to be working out quite fine.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
