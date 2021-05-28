Return-Path: <SRS0=y/hj=KX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A1FC2B9F7
	for <linux-nvme@archiver.kernel.org>; Fri, 28 May 2021 13:05:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C6ED6139A
	for <linux-nvme@archiver.kernel.org>; Fri, 28 May 2021 13:05:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C6ED6139A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=xKqnqpm89gA9yqsIWPw4y1oTtAUBuyBnIukpPEEqy6Y=; b=LAQ42PwL/xE8Jovv82oOZjvWK3
	4tukbCmBBrE05Fd2x3lBubJMsPbJOFRpDyV8TK/yq6iT77fj1GdOgoJjZsmlemdyN8VSsmT5my28q
	Z3X/G1O/42u7GIEiv+ONSj3UKqHtaDQrOyBwPLfQeRD1LiM/74xpLWT+hOO21UB98BxFB42PyOZ26
	vuDXd2Dq09SjHb9+r0v1tBOhAyTrP5uClo2hXebr1/ESTEXR57CEiiqrT7pmRjcVo6mi+rKE8uMxs
	wjMPMRJVM+GutgLmGVOFUWOppRozDso9Fjs9AY619cM+LScDKUe5NeAjv6RWndSGOmn9YAMjFzrO9
	hhM7qIUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lmcAm-00Fcgk-P5; Fri, 28 May 2021 13:05:08 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lmbsz-00FUvh-5C
 for linux-nvme@lists.infradead.org; Fri, 28 May 2021 12:46:46 +0000
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
 (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 92C9F1FD2E;
 Fri, 28 May 2021 12:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1622206003; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P97HW2+GhwiADFe/qrdemvBBlPHYcnDV6EFPfZ/sS5Q=;
 b=s+R3BccLA4IaOt7J4VxZ2to2HYZHRFTJe10VOj2spBzsIpOZiR/E/7AxV/1Q1EuC0ViaG7
 nzttAmtwyEjfjPum7cOzfpbSmLe61j88A1azJgbQcx3cHr0rLguxY1PDhkCrlJ2Zta96DA
 mUvG46zDMnoWHaLLt6prvzABgewRoWU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1622206003;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P97HW2+GhwiADFe/qrdemvBBlPHYcnDV6EFPfZ/sS5Q=;
 b=/z3OAtfGglDBpR3VY7fCFljKp8+cI2Us0OgZfU0OIZ9y39NP4Sn7f12GCWgsFlJHdRuc5X
 2IAPluD/YR19KoDw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
 by imap.suse.de (Postfix) with ESMTP id 60C6A11A98;
 Fri, 28 May 2021 12:46:43 +0000 (UTC)
Received: from director2.suse.de ([192.168.254.72]) by imap3-int with ESMTPSA
 id ZAThFjPmsGBaMgAALh3uQQ
 (envelope-from <hare@suse.de>); Fri, 28 May 2021 12:46:43 +0000
Subject: Re: [RFC PATCH v6 19/27] qedn: Add IRQ and fast-path resources
 initializations
To: Shai Malin <smalin@marvell.com>, netdev@vger.kernel.org,
 linux-nvme@lists.infradead.org, davem@davemloft.net, kuba@kernel.org,
 sagi@grimberg.me, hch@lst.de, axboe@fb.com, kbusch@kernel.org
Cc: aelior@marvell.com, mkalderon@marvell.com, okulkarni@marvell.com,
 pkushwaha@marvell.com, malin1024@gmail.com
References: <20210527235902.2185-1-smalin@marvell.com>
 <20210527235902.2185-20-smalin@marvell.com>
From: Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <8f198995-3994-fbca-e8e1-0f73d28f7a34@suse.de>
Date: Fri, 28 May 2021 14:46:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210527235902.2185-20-smalin@marvell.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210528_054645_383408_4A0AF3AC 
X-CRM114-Status: GOOD (  20.31  )
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

T24gNS8yOC8yMSAxOjU4IEFNLCBTaGFpIE1hbGluIHdyb3RlOgo+IFRoaXMgcGF0Y2ggd2lsbCBw
cmVzZW50IHRoZSBhZGRpbmcgb2YgcWVkbl9mcF9xdWV1ZSAtIHRoaXMgaXMgYSBwZXIgY3B1Cj4g
Y29yZSBlbGVtZW50IHdoaWNoIGhhbmRsZXMgYWxsIG9mIHRoZSBjb25uZWN0aW9ucyBvbiB0aGF0
IGNwdSBjb3JlLgo+IFRoZSBxZWRuX2ZwX3F1ZXVlIHdpbGwgaGFuZGxlIGEgZ3JvdXAgb2YgY29u
bmVjdGlvbnMgKE5WTWVvRiBRUHMpIHdoaWNoCj4gYXJlIGhhbmRsZWQgb24gdGhlIHNhbWUgY3B1
IGNvcmUsIGFuZCB3aWxsIG9ubHkgdXNlIHRoZSBzYW1lIEZXLWRyaXZlcgo+IHJlc291cmNlcyB3
aXRoIG5vIG5lZWQgdG8gYmUgcmVsYXRlZCB0byB0aGUgc2FtZSBOVk1lb0YgY29udHJvbGxlci4K
PiAKPiBUaGUgcGVyIHFlZG5fZnFfcXVldWUgcmVzb3VyY2VzIGFyZSB0aGUgRlcgQ1EgYW5kIEZX
IHN0YXR1cyBibG9jazoKPiAtIFRoZSBGVyBDUSB3aWxsIGJlIHVzZWQgZm9yIHRoZSBGVyB0byBu
b3RpZnkgdGhlIGRyaXZlciB0aGF0IHRoZQo+ICAgdGhlIGV4Y2hhbmdlIGhhcyBlbmRlZCBhbmQg
dGhlIEZXIHdpbGwgcGFzcyB0aGUgaW5jb21pbmcgTlZNZW9GIENRRQo+ICAgKGlmIGV4aXN0KSB0
byB0aGUgZHJpdmVyLgo+IC0gRlcgc3RhdHVzIGJsb2NrIC0gd2hpY2ggaXMgdXNlZCBmb3IgdGhl
IEZXIHRvIG5vdGlmeSB0aGUgZHJpdmVyIHdpdGgKPiAgIHRoZSBwcm9kdWNlciB1cGRhdGUgb2Yg
dGhlIEZXIENRRSBjaGFpbi4KPiAKPiBUaGUgRlcgZmFzdC1wYXRoIHF1ZXVlcyBhcmUgYmFzZWQg
b24gcWVkX2NoYWluLmgKPiAKPiBBY2tlZC1ieTogSWdvciBSdXNza2lraCA8aXJ1c3NraWtoQG1h
cnZlbGwuY29tPgo+IFNpZ25lZC1vZmYtYnk6IFByYWJoYWthciBLdXNod2FoYSA8cGt1c2h3YWhh
QG1hcnZlbGwuY29tPgo+IFNpZ25lZC1vZmYtYnk6IE9ta2FyIEt1bGthcm5pIDxva3Vsa2FybmlA
bWFydmVsbC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogTWljaGFsIEthbGRlcm9uIDxta2FsZGVyb25A
bWFydmVsbC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogQXJpZWwgRWxpb3IgPGFlbGlvckBtYXJ2ZWxs
LmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBTaGFpIE1hbGluIDxzbWFsaW5AbWFydmVsbC5jb20+Cj4g
LS0tCj4gIGRyaXZlcnMvbnZtZS9ody9xZWRuL3FlZG4uaCAgICAgIHwgIDI1ICsrKwo+ICBkcml2
ZXJzL252bWUvaHcvcWVkbi9xZWRuX21haW4uYyB8IDI4OSArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKystCj4gIDIgZmlsZXMgY2hhbmdlZCwgMzExIGluc2VydGlvbnMoKyksIDMgZGVsZXRp
b25zKC0pCj4gClJldmlld2VkLWJ5OiBIYW5uZXMgUmVpbmVja2UgPGhhcmVAc3VzZS5kZT4KCkNo
ZWVycywKCkhhbm5lcwotLSAKRHIuIEhhbm5lcyBSZWluZWNrZQkJICAgICAgICBLZXJuZWwgU3Rv
cmFnZSBBcmNoaXRlY3QKaGFyZUBzdXNlLmRlCQkJICAgICAgICAgICAgICAgKzQ5IDkxMSA3NDA1
MyA2ODgKU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR2VybWFueSBHbWJILCA5MDQwOSBOw7xybmJl
cmcKR0Y6IEYuIEltZW5kw7ZyZmZlciwgSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxp
bmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
