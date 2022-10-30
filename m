Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A867C38A02
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Oct 2022 02:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:MIME-Version:
	Content-Type:Content-Transfer-Encoding:References:In-Reply-To:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o4jNIfBz65TgbCcHSOUBwU9wnWnimND6eRqLFO7E29E=; b=kLQOLOhgUOxinJYvNI22FneEhc
	tPPxyPodRcX9coP3tzfVO71F82zyH4tUMg1C2C1rMIztPb+agUO+HBi5X2qQQuLHmUvfccH4tueb6
	vebHm8iHjeS3LG6lCrRoDzO87K2iPHFdy23+7lOtiPbVHbdM1zNKvmeHnao1YXJz8dybGjMKa38o4
	/cMP7XctHkgBqEbUm27n3AjyWs2nuix3iaGD6jmfsE/tUcthFlrBt5UhAAzayKCRLXnSedB/XDEwT
	WywU2dSEDxo/3ol/QpNX0qpYtJm02vJ19DnluJ/AmLCG0ZUM8yDChh9qMQOnqQaCWszeb3f5M4lMo
	8papVFtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ooy30-00BTUu-V1; Sun, 30 Oct 2022 02:27:38 +0000
Received: from spam.zju.edu.cn ([61.164.42.155] helo=zju.edu.cn)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ooy2w-00BTTL-SF
	for linux-nvme@lists.infradead.org; Sun, 30 Oct 2022 02:27:38 +0000
Received: by ajax-webmail-mail-app4 (Coremail) ; Sun, 30 Oct 2022 10:27:22
 +0800 (GMT+08:00)
X-Originating-IP: [10.192.32.139]
Date: Sun, 30 Oct 2022 10:27:22 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Jinlong Chen" <nickyc975@zju.edu.cn>
To: "Bart Van Assche" <bvanassche@acm.org>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org
Subject: Re: Re: [PATCH 1/3] blk-mq: remove redundant call to
 blk_freeze_queue_start in blk_mq_destroy_queue
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2022 www.mailtech.cn zju.edu.cn
In-Reply-To: <adaea16a-c7cd-5d68-50c8-d56de851061a@acm.org>
References: <cover.1667035519.git.nickyc975@zju.edu.cn>
 <ebd3a47a1ebf4ab518c985cdbaa1ac3afd6dfb9f.1667035519.git.nickyc975@zju.edu.cn>
 <adaea16a-c7cd-5d68-50c8-d56de851061a@acm.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <42681e4e.15223d.18426b71124.Coremail.nickyc975@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cS_KCgBXXP0K4V1j+p2eBw--.49366W
X-CM-SenderInfo: qssqjiaqqzq6lmxovvfxof0/1tbiAggTB1ZdtcKM4AAAsO
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221029_192735_251337_EC7BD0A0 
X-CRM114-Status: GOOD (  10.92  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

SGksIEJhcnQuCgo+ID4gQ2FsbGluZyBibGtfZnJlZXplX3F1ZXVlIHJlc3VsdHMgaW4gYSByZWR1
bmRhbnQgY2FsbCB0bwo+ID4gYmxrX2ZyZWV6ZV9xdWV1ZV9zdGFydCBhcyBpdCBoYXMgYmVlbiBj
YWxsZWQgaW4gYmxrX3F1ZXVlX3N0YXJ0X2RyYWluLgo+ID4gCj4gPiBSZXBsYWNlIGJsa19mcmVl
emVfcXVldWUgd2l0aCBibGtfbXFfZnJlZXplX3F1ZXVlX3dhaXQgdG8gYXZvaWQgdGhlCj4gPiBy
ZWR1bmRhbnQgY2FsbC4KPiAKPiBibGtfbXFfZGVzdHJveV9xdWV1ZSgpIGhhcyBtb3JlIGNhbGxl
cnMgdGhhbiBibGtfcXVldWVfc3RhcnRfZHJhaW4oKSBzbyAKPiB0aGUgYWJvdmUgZGVzY3JpcHRp
b24gaXMgYXQgbGVhc3QgbWlzbGVhZGluZy4KPiAKPiBBZGRpdGlvbmFsbHksIHRoZSB3b3JkICJj
bGVhbnVwIiBmcm9tIHRoZSBwYXRjaCBzZXJpZXMgdGl0bGUgaW5kaWNhdGVzIAo+IHRoYXQgbm8g
cGF0Y2ggaW4gdGhpcyBzZXJpZXMgY2hhbmdlcyB0aGUgYmVoYXZpb3Igb2YgdGhlIGNvZGUuIFRo
aXMgCj4gcGF0Y2ggaW52b2x2ZXMgYSBiZWhhdmlvciBjaGFuZ2UuCgpTb3JyeSBmb3IgbXkgcG9v
ciBkZXNjcmlwdGlvbi4gSSdsbCBzZW5kIGEgbmV3IHNlcmllcyB3aXRoIHRoZXNlCmRlc2NyaXB0
aW9uIHByb2JsZW1zIHJlc29sdmVkLgoKPiBJIHRoaW5rIHRoaXMgcGF0Y2ggaW50cm9kdWNlcyBh
IGhhbmcgZm9yIGV2ZXJ5IGNhbGxlciBvZiAKPiBibGtfbXFfZGVzdHJveV9xdWV1ZSgpIG90aGVy
IHRoYW4gYmxrX3F1ZXVlX3N0YXJ0X2RyYWluKCkuCj4gCj4gQmFydC4KCkkgZG9uJ3Qgc2VlIHdo
eSB0aGUgcGF0Y2ggaW50cm9kdWNlcyBhIGhhbmcuIFRoZSBjYWxsaW5nIHJlbGF0aW9uc2hpcCBp
bgpibGtfbXFfZGVzdHJveV9xdWV1ZSBpcyBhcyBmb2xsb3dzOgoKYmxrX21xX2Rlc3Ryb3lfcXVl
dWUoKQogICAgLi4uCiAgICAtPiBibGtfcXVldWVfc3RhcnRfZHJhaW4oKQogICAgICAgIC0+IGJs
a19mcmVlemVfcXVldWVfc3RhcnQoKSAgPC0gY2FsbGVkCiAgICAgICAgLi4uCiAgICAtPiBibGtf
ZnJlZXplX3F1ZXVlKCkKICAgICAgICAtPiBibGtfZnJlZXplX3F1ZXVlX3N0YXJ0KCkgIDwtIGNh
bGxlZCBhZ2FpbgogICAgICAgIC0+IGJsa19tcV9mcmVlemVfcXVldWVfd2FpdCgpCiAgICAuLi4K
ClNvIEkgdGhpbmsgdGhlcmUgaXMgYSByZWR1bmRhbnQgY2FsbCB0byBibGtfZnJlZXplX3F1ZXVl
X3N0YXJ0KCksIHdlCmp1c3QgbmVlZCB0byBjYWxsIGJsa19tcV9mcmVlemVfcXVldWVfd2FpdCgp
IGFmdGVyIGNhbGxpbmcKYmxrX3F1ZXVlX3N0YXJ0X2RyYWluKCkuCgpUaGFua3MhCkppbmxvbmcg
Q2hlbgoK

