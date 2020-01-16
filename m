Return-Path: <SRS0=1/6V=3F=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5768C33CB1
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Jan 2020 14:16:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 981BB207E0
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Jan 2020 14:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZfF/fbaL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="o/ooMMWF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 981BB207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:MIME-Version:Subject:
	References:In-Reply-To:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ajpfyFkQVJodpytT92qM9p3+WQILZrmiPu44lwkEM90=; b=ZfF/fbaLib6rMy
	t0jUTJFHdtPo1oaDkCDWvXJBKGIX3MzaoG9R3QF0Y+pleiS0dXsjAbnbwCL9FRuUqep1SqutaVRbK
	aoY7v1X60gsoUuAW8eCvbYK0AHZKY/7VkKIL/WNo7PaLjfTpFq+/QZP4UbeltjDGCRnELyEpaqnz6
	yWINSzX9lv8YBiJAqTcv9GHGYbIGyum6/LObRdhL2DwEZomjHokfO86QFBKGf8TnncLpBIc6SYTQp
	wmBN3zR/SwrwPUs46VLRqDE5IcHprgOfkSZ1Y9dpu9EYlPCEvVulIL/VOxwM9vvlFEqUe6VrY0whB
	FC/pEFggu/w7XVcL18yg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1is5wE-0005bA-Vc; Thu, 16 Jan 2020 14:15:58 +0000
Received: from forward501p.mail.yandex.net ([2a02:6b8:0:1472:2741:0:8b7:120])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1is5w8-0005Zp-Em
 for linux-nvme@lists.infradead.org; Thu, 16 Jan 2020 14:15:57 +0000
Received: from mxback1q.mail.yandex.net (mxback1q.mail.yandex.net
 [IPv6:2a02:6b8:c0e:39:0:640:25b3:aea5])
 by forward501p.mail.yandex.net (Yandex) with ESMTP id D97BF35008CC;
 Thu, 16 Jan 2020 17:15:41 +0300 (MSK)
Received: from localhost (localhost [::1])
 by mxback1q.mail.yandex.net (mxback/Yandex) with ESMTP id OORCNMaddV-FfGeRYbc; 
 Thu, 16 Jan 2020 17:15:41 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1579184141; bh=4yds1dAAPaFstw1xk+DTNGLaxN4HfBeKCzWAsZYlcTo=;
 h=Message-Id:Cc:Subject:In-Reply-To:Date:References:To:From;
 b=o/ooMMWFreoaTVGM0KnZpoBakSXFEUJ2ZH0IScoMPCg79TzBY4vMu81bYGxZQqEZT
 CwkPdMUAtyEgoSzWnDIiiFcyuVirocwlJbIDCfpFiBTdqkXxKubxaNrdj0ZGA2lww4
 TJuEgSJUhUzBQVAFZfXP326lIaRAydp6XFuSO7/k=
Authentication-Results: mxback1q.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by vla4-9d01d86ae0b7.qloud-c.yandex.net with HTTP;
 Thu, 16 Jan 2020 17:15:40 +0300
From: Talker Alex <alextalker@yandex.ru>
Envelope-From: alextalker@yandex.ru
To: linux-nvme <linux-nvme@lists.infradead.org>
In-Reply-To: <20191212104322.GA19996@infradead.org>
References: <34086421575664793@iva7-8a22bc446c12.qloud-c.yandex.net>
 <20191212093341.GA20683@infradead.org>
 <3861821576146988@sas8-ed615920eca2.qloud-c.yandex.net>
 <20191212104322.GA19996@infradead.org>
Subject: Re: [PATCH] nvmet: fix null-pointer when removing a referral
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Thu, 16 Jan 2020 17:15:40 +0300
Message-Id: <416341579184141@vla4-9d01d86ae0b7.qloud-c.yandex.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200116_061552_812241_F642E8FF 
X-CRM114-Status: UNSURE (   4.15  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

UGluZy4KCldvdWxkIGFueW9uZSBraW5kbHkgZmluYWxseSBtZXJnZSB0aGlzIGZpeD8KCkknZCBy
ZWFsbHkgYXBwcmVjaWF0ZSBpdC4KCjEyLjEyLjIwMTksIDEzOjQzLCAiQ2hyaXN0b3BoIEhlbGx3
aWciIDxoY2hAaW5mcmFkZWFkLm9yZz46Cj4gT24gVGh1LCBEZWMgMTIsIDIwMTkgYXQgMDE6MzY6
MjhQTSArMDMwMCwgVGFsa2VyIEFsZXggd3JvdGU6Cj4+IMKgbnZtZXRfcmVmZXJyYWxfcmVsZWFz
ZSgpIHdhcyBjYWxsZWQgd2hlbiBpdGVtLT5jaV9wYXJlbnQKPj4gwqBvciBpdGVtLT5jaV9ncm91
cCB3ZXJlIGFscmVhZHkgc2V0IHRvIE5VTEwgYnkgY29uZmlnZnMgaW50ZXJuYWxzLgo+Pgo+PiDC
oFNpZ25lZC1vZmYtYnk6IEFsZWtzYW5kciBEaWFkaXVzaGtpbiA8YWxleHRhbGtlckB5YS5ydT4K
Pgo+IExvb2tzIGdvb2QsCj4KPiBSZXZpZXdlZC1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBs
c3QuZGU+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwps
aW51eC1udm1lIG1haWxpbmcgbGlzdApsaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
