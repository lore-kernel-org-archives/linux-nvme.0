Return-Path: <SRS0=yMBa=LB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F4BC4743F
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 15:46:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0238B6102A
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 15:46:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0238B6102A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=4goCVU49gBIPL2rs4N8naYt3h8jX0+SIP8PSLAJAOv4=; b=LGWAxFlFC5SEMFEMOampIIZ/u3
	dY+PVHPSySY2UXIrNGRaCXsvLzQ5T9bdr/zRGotgCtgalngEy7Iy52z18ouFJuq8WrUdDW/2EGoM8
	F1NntcgGf1RRnhoSmk7tLGZWxZx6dkJ6rZq2mq3iW60JuTrdbi74z4JIzH2cu4WlDLKouS4BcBVa0
	XKR+aXCuPaRuBmGF7Y6kyvdET+zBFXsWpYQsK5XBxBmdZNnMzUIjeZWc1FOV+HSsNs4ilzeL/r+ky
	USzxDyFxdG7GuPsEM0fKaCHAsubzSl/gzEUH63qx1DUl2cBf8MSQHqMmUwcq7mIBIaIONi3xW+7H+
	g28lYUaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqHSC-004JuS-0x; Mon, 07 Jun 2021 15:46:16 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqHS7-004JtX-Cn
 for linux-nvme@lists.infradead.org; Mon, 07 Jun 2021 15:46:14 +0000
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
 (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E70C91FDA5;
 Mon,  7 Jun 2021 15:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1623080769; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6X+lxKL1u5/eOeJjN6PYASQ1G5DrjjeKa0CNe67un7I=;
 b=RGuD5SsR1msLK3siKs9xdLspo0PSp93/9J0jcl05iGIIQ8Qp7Yhp2PJbeLrqZs63LtosrU
 zz0cYySqe23hxXTKkzN/EBOF/Z+s/GEDLM0TLMUlVVnnP8+hpQHbJ3PcENTYN8Mtb4xoy3
 XUHHLwkcLtBQUOFIWXXomDcVbzwpFwE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1623080769;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6X+lxKL1u5/eOeJjN6PYASQ1G5DrjjeKa0CNe67un7I=;
 b=GHeecwf530mrbLBiUPAMnLsWuKm7byYAsKm97Y1U94hf687Cya5MpCJtW9n6evNoZ81N1n
 YODo4jDq97aMhcDQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
 by imap.suse.de (Postfix) with ESMTP id 886D2118DD;
 Mon,  7 Jun 2021 15:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1623080769; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6X+lxKL1u5/eOeJjN6PYASQ1G5DrjjeKa0CNe67un7I=;
 b=RGuD5SsR1msLK3siKs9xdLspo0PSp93/9J0jcl05iGIIQ8Qp7Yhp2PJbeLrqZs63LtosrU
 zz0cYySqe23hxXTKkzN/EBOF/Z+s/GEDLM0TLMUlVVnnP8+hpQHbJ3PcENTYN8Mtb4xoy3
 XUHHLwkcLtBQUOFIWXXomDcVbzwpFwE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1623080769;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6X+lxKL1u5/eOeJjN6PYASQ1G5DrjjeKa0CNe67un7I=;
 b=GHeecwf530mrbLBiUPAMnLsWuKm7byYAsKm97Y1U94hf687Cya5MpCJtW9n6evNoZ81N1n
 YODo4jDq97aMhcDQ==
Received: from director2.suse.de ([192.168.254.72]) by imap3-int with ESMTPSA
 id afmOIEE/vmBldwAALh3uQQ
 (envelope-from <hare@suse.de>); Mon, 07 Jun 2021 15:46:09 +0000
Subject: Re: [PATCH 5/8] nvme-tcp-offload: Add controller level implementation
To: Shai Malin <smalin@marvell.com>, linux-nvme@lists.infradead.org,
 sagi@grimberg.me, hch@lst.de, axboe@fb.com, kbusch@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 aelior@marvell.com, mkalderon@marvell.com, okulkarni@marvell.com,
 pkushwaha@marvell.com, prabhakar.pkin@gmail.com, malin1024@gmail.com,
 Arie Gershberg <agershberg@marvell.com>
References: <20210602184246.14184-1-smalin@marvell.com>
 <20210602184246.14184-6-smalin@marvell.com>
From: Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <87a2822c-c5ac-13d1-336a-b96045c3de5b@suse.de>
Date: Mon, 7 Jun 2021 17:46:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210602184246.14184-6-smalin@marvell.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210607_084611_606243_0EEC2B5F 
X-CRM114-Status: GOOD (  17.05  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gNi8yLzIxIDg6NDIgUE0sIFNoYWkgTWFsaW4gd3JvdGU6Cj4gRnJvbTogQXJpZSBHZXJzaGJl
cmcgPGFnZXJzaGJlcmdAbWFydmVsbC5jb20+Cj4gCj4gSW4gdGhpcyBwYXRjaCB3ZSBpbXBsZW1l
bnQgY29udHJvbGxlciBsZXZlbCBmdW5jdGlvbmFsaXR5IGluY2x1ZGluZzoKPiAtIGNyZWF0ZV9j
dHJsLgo+IC0gZGVsZXRlX2N0cmwuCj4gLSBmcmVlX2N0cmwuCj4gCj4gVGhlIGltcGxlbWVudGF0
aW9uIGlzIHNpbWlsYXIgdG8gb3RoZXIgbnZtZSBmYWJyaWNzIG1vZHVsZXMsIHRoZSBtYWluCj4g
ZGlmZmVyZW5jZSBiZWluZyB0aGF0IHRoZSBudm1lLXRjcC1vZmZsb2FkIFVMUCBjYWxscyB0aGUg
dmVuZG9yIHNwZWNpZmljCj4gY2xhaW1fZGV2KCkgb3Agd2l0aCB0aGUgZ2l2ZW4gVENQL0lQIHBh
cmFtZXRlcnMgdG8gZGV0ZXJtaW5lIHdoaWNoIGRldmljZQo+IHdpbGwgYmUgdXNlZCBmb3IgdGhp
cyBjb250cm9sbGVyLgo+IE9uY2UgZm91bmQsIHRoZSB2ZW5kb3Igc3BlY2lmaWMgZGV2aWNlIGFu
ZCBjb250cm9sbGVyIHdpbGwgYmUgcGFpcmVkIGFuZAo+IGtlcHQgaW4gYSBjb250cm9sbGVyIGxp
c3QgbWFuYWdlZCBieSB0aGUgVUxQLgo+IAo+IEFja2VkLWJ5OiBJZ29yIFJ1c3NraWtoIDxpcnVz
c2tpa2hAbWFydmVsbC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogQXJpZSBHZXJzaGJlcmcgPGFnZXJz
aGJlcmdAbWFydmVsbC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogUHJhYmhha2FyIEt1c2h3YWhhIDxw
a3VzaHdhaGFAbWFydmVsbC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogT21rYXIgS3Vsa2FybmkgPG9r
dWxrYXJuaUBtYXJ2ZWxsLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWwgS2FsZGVyb24gPG1r
YWxkZXJvbkBtYXJ2ZWxsLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBBcmllbCBFbGlvciA8YWVsaW9y
QG1hcnZlbGwuY29tPgo+IFNpZ25lZC1vZmYtYnk6IFNoYWkgTWFsaW4gPHNtYWxpbkBtYXJ2ZWxs
LmNvbT4KPiBSZXZpZXdlZC1ieTogSGltYW5zaHUgTWFkaGFuaSA8aGltYW5zaHUubWFkaGFuaUBv
cmFjbGUuY29tPgo+IC0tLQo+ICBkcml2ZXJzL252bWUvaG9zdC90Y3Atb2ZmbG9hZC5jIHwgNDgx
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystCj4gIDEgZmlsZSBjaGFuZ2VkLCA0NzYg
aW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKPiAKUmV2aWV3ZWQtYnk6IEhhbm5lcyBSZWlu
ZWNrZSA8aGFyZUBzdXNlLmRlPgoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5l
Y2tlCQkgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUJCQkgICAg
ICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHZXJt
YW55IEdtYkgsIDkwNDA5IE7DvHJuYmVyZwpHRjogRi4gSW1lbmTDtnJmZmVyLCBIUkIgMzY4MDkg
KEFHIE7DvHJuYmVyZykKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52
bWUK
