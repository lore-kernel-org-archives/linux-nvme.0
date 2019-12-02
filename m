Return-Path: <SRS0=f1uU=ZY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B184C432C0
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Dec 2019 18:04:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C02220674
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Dec 2019 18:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mhgYvcUR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="Y6eJD1O8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C02220674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:MIME-Version:Subject:To
	:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=UVIw7AUvEQpFYVAuIZJPQK3tcDBCAJuVxk0E46IHfzI=; b=mhgYvcUR2hcE1F
	xKd28UOUE1CMbnsexK1MzljD0+1WYd/O9xkNqAbWXfaZXNts60evXXujIVfbbYP9Y7mp8qYD6lnTF
	J50d6/jeFXMz7ZIeabLxjbJWrkROHAXlKAYkYo+u7+luBNLdpSOl5YyVFOQvXO6OlYFta4tzXxpu4
	wm5KxS+goQY125P1kDrb64a/Zof68CTPdZ+XQqeBEh0SeaxylLLZaRsuMqoUqvX8p6lnkk/Yfg7J9
	HwkFxqbPOA/hQFpSkElBmRVpRfJ0fc12kZLUysmSa2CsoEXjk4izUM+2/5kTgwMQDkQ1J1R7PKK7k
	9hcn2gCO0as+BwBKjJ7w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ibq3n-0006M9-KJ; Mon, 02 Dec 2019 18:04:35 +0000
Received: from forward102j.mail.yandex.net ([2a02:6b8:0:801:2::102])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ibq3k-0006Lo-El
 for linux-nvme@lists.infradead.org; Mon, 02 Dec 2019 18:04:34 +0000
Received: from mxback14o.mail.yandex.net (mxback14o.mail.yandex.net
 [IPv6:2a02:6b8:0:1a2d::65])
 by forward102j.mail.yandex.net (Yandex) with ESMTP id 2B8ABF213AA
 for <linux-nvme@lists.infradead.org>; Mon,  2 Dec 2019 21:04:25 +0300 (MSK)
Received: from localhost (localhost [::1])
 by mxback14o.mail.yandex.net (mxback/Yandex) with ESMTP id mAnC026diV-4O38x84v;
 Mon, 02 Dec 2019 21:04:24 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1575309864; bh=fJgaXR6fheYYTN9Ji2szFQtJYYUwSktXOsCYPynD+Q0=;
 h=Message-Id:Date:Subject:To:From;
 b=Y6eJD1O8knFUbXTdJjkoFWj+At72HVdRTBnqAYyWndMAZ4uCtXatQuJYOt41IQ4NC
 UOGv/bv3ZBwYunxTf/FGCaYfCbsF1bc7qX4H9Wukxt16r3D1576F5rqbs1gjmWx9uN
 cLqZCg16tzDTm//g0R9n1940zt3DRS+c4gPC0khI=
Authentication-Results: mxback14o.mail.yandex.net;
 dkim=pass header.i=@yandex.ru
Received: by iva7-56e9317134d0.qloud-c.yandex.net with HTTP;
 Mon, 02 Dec 2019 21:04:24 +0300
From: Talker Alex <alextalker@yandex.ru>
Envelope-From: alextalker@yandex.ru
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: nvme: Resevations support on target side
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Mon, 02 Dec 2019 21:04:24 +0300
Message-Id: <8659391575309864@iva7-56e9317134d0.qloud-c.yandex.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191202_100432_810934_DCD06847 
X-CRM114-Status: UNSURE (   5.10  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi!

Is there plans to implement Reservations support in target driver(from NVMe v1.4 part 8.8)?
I see that host support is already implemented in nvme utility & driver level.
However, I haven't found hardware on which it works - target driver doesn't support this command and PCIe drives available to me also.

So, I'm wondering if anyone begin to implement this feature at least on single target level.

------------------
Best regards,
Alex

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
