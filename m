Return-Path: <SRS0=wOI1=J5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6FAC433B4
	for <linux-nvme@archiver.kernel.org>; Sun,  2 May 2021 12:00:09 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61762611AC
	for <linux-nvme@archiver.kernel.org>; Sun,  2 May 2021 12:00:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61762611AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=JlWAP3X55Pn4UzSLtr20B5rijkYcqgHIjmd5V90xMDw=; b=c8wB8WU8rPEa0eU4nt+R4/XU9
	x2YShj6GtmM4ofQ3rjhYnL0JNjKtf3Hw7Ob2rNCnjBkISWsRm5JA/wusoO4+sfO1KBVtpItbFP5tG
	bFdje/V8yVCOo8iMngXnmjAKpFAUoK8qMyRP6gSnJ+XgbQ3xDI5hh5cPmATU5Yqngsvq4VQDUcvfs
	LRE8fCdKSd6Z8h/0uQGS6HubfPF5faXZWTYzLodTyrdo5ioIEJgGywN2N4uOMLQp0Ib+a10a/yUao
	kuYr3PKU4kHxdWJyNU/LDFiNnfrm+mZghrDeFOEe3eRSJSx0Y7AalHeZL0QGsvZhx5RqLJL1Penmg
	xx427QLKg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ldAlX-00Bihs-Jt; Sun, 02 May 2021 12:00:03 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldAlT-00Bih8-Fs
 for linux-nvme@desiato.infradead.org; Sun, 02 May 2021 11:59:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=buho2BC0Wmj3t29hnUA7PpDEpJBqeLFU0wzWFnXNSLg=; b=yU2BGAEuIMk7ZYBmX1GMGG6m/m
 F50gQWdcr697FTmt7xMsYVyk0a57oyKoNFrF8r0uaIVxTtBJPDMFuWjNh8Johslwvo/CClFGjbP/U
 +J5PR2OA+2lhusvBkWLlmvPt0rzbgwYkVeXezt/Jm+0aCjH2gDW8zXoO1ck5Si796w68ganBhMxtz
 4bstb9GCOJlBUSbVX8umGxlhBQJHWj/3Kk4IaJQeZKL3hV8D4q41YBgylJZooj8mn7Jb4KMiNUAUe
 B9EQFlszb+PGFFA6XSuRUMocPvplcqJn2As1kzgXQomHaw8y756Qy2H0margiThwwFCi7V9BF3C0a
 qzAr90ag==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldAlQ-002W7u-VR
 for linux-nvme@lists.infradead.org; Sun, 02 May 2021 11:59:58 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id A6E5AB1A5;
 Sun,  2 May 2021 11:59:55 +0000 (UTC)
Subject: Re: [RFC PATCH v4 27/27] qedn: Add support of ASYNC
To: Shai Malin <smalin@marvell.com>, netdev@vger.kernel.org,
 linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de, axboe@fb.com,
 kbusch@kernel.org
Cc: "David S . Miller davem @ davemloft . net --cc=Jakub Kicinski"
 <kuba@kernel.org>, aelior@marvell.com, mkalderon@marvell.com,
 okulkarni@marvell.com, pkushwaha@marvell.com, malin1024@gmail.com
References: <20210429190926.5086-1-smalin@marvell.com>
 <20210429190926.5086-28-smalin@marvell.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <156b840a-2ea2-0b3b-1bf6-7869838fccbe@suse.de>
Date: Sun, 2 May 2021 13:59:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210429190926.5086-28-smalin@marvell.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210502_045957_198534_F80A847B 
X-CRM114-Status: GOOD (  13.24  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gNC8yOS8yMSA5OjA5IFBNLCBTaGFpIE1hbGluIHdyb3RlOgo+IEZyb206IFByYWJoYWthciBL
dXNod2FoYSA8cGt1c2h3YWhhQG1hcnZlbGwuY29tPgo+IAo+IFRoaXMgcGF0Y2ggaW1wbGVtZW50
IEFTWU5DIHJlcXVlc3QgYW5kIHJlc3BvbnNlIGV2ZW50IG5vdGlmaWNhdGlvbgo+IGhhbmRsaW5n
IGF0IHFlZG4gZHJpdmVyIGxldmVsLgo+IAo+IE5WTUUgT2ZsZCBsYXllcidzIEFTWU5DIHJlcXVl
c3QgaXMgdHJlYXRlZCBzaW1pbGFyIHRvIHJlYWQgd2l0aAo+IGZha2UgQ0NDSUQuIFRoaXMgQ0ND
SUQgdXNlZCB0byByb3V0ZSBBU1lOQyBub3RpZmljYXRpb24gYmFjayB0bwo+IHRoZSBOVk1FIG9m
bGQgbGF5ZXIuCj4gCj4gQWNrZWQtYnk6IElnb3IgUnVzc2tpa2ggPGlydXNza2lraEBtYXJ2ZWxs
LmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBQcmFiaGFrYXIgS3VzaHdhaGEgPHBrdXNod2FoYUBtYXJ2
ZWxsLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBPbWthciBLdWxrYXJuaSA8b2t1bGthcm5pQG1hcnZl
bGwuY29tPgo+IFNpZ25lZC1vZmYtYnk6IE1pY2hhbCBLYWxkZXJvbiA8bWthbGRlcm9uQG1hcnZl
bGwuY29tPgo+IFNpZ25lZC1vZmYtYnk6IEFyaWVsIEVsaW9yIDxhZWxpb3JAbWFydmVsbC5jb20+
Cj4gU2lnbmVkLW9mZi1ieTogU2hhaSBNYWxpbiA8c21hbGluQG1hcnZlbGwuY29tPgo+IC0tLQo+
ICAgZHJpdmVycy9udm1lL2h3L3FlZG4vcWVkbi5oICAgICAgfCAgIDggKysKPiAgIGRyaXZlcnMv
bnZtZS9ody9xZWRuL3FlZG5fbWFpbi5jIHwgICAxICsKPiAgIGRyaXZlcnMvbnZtZS9ody9xZWRu
L3FlZG5fdGFzay5jIHwgMTU2ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0KPiAgIDMg
ZmlsZXMgY2hhbmdlZCwgMTU2IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pCj4gClJldmll
d2VkLWJ5OiBIYW5uZXMgUmVpbmVja2UgPGhhcmVAc3VzZS5kZT4KCkNoZWVycywKCkhhbm5lcwot
LSAKRHIuIEhhbm5lcyBSZWluZWNrZSAgICAgICAgICAgICAgICBLZXJuZWwgU3RvcmFnZSBBcmNo
aXRlY3QKaGFyZUBzdXNlLmRlICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKzQ5IDkxMSA3
NDA1MyA2ODgKU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR21iSCwgTWF4ZmVsZHN0ci4gNSwgOTA0
MDkgTsO8cm5iZXJnCkhSQiAzNjgwOSAoQUcgTsO8cm5iZXJnKSwgR2VzY2jDpGZ0c2bDvGhyZXI6
IEZlbGl4IEltZW5kw7ZyZmZlcgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtbnZtZQo=
