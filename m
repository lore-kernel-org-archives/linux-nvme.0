Return-Path: <SRS0=y/hj=KX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F154C4708D
	for <linux-nvme@archiver.kernel.org>; Fri, 28 May 2021 12:13:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AC68611BD
	for <linux-nvme@archiver.kernel.org>; Fri, 28 May 2021 12:13:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AC68611BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=YASNpF0f4L6d4OJDD9UMm1uDglU5XXN+m8aproSdnWY=; b=eHhW4uPT0a1gnHQFsWGSW/GAlm
	fgz8SUrA7bjL6MYhsAM4KXrwdxZhND8W3z9aL3HDLWfWfn+6wMXEioGea1/lu5vl5n+XMToOdVtfz
	42JpGPFZswop/qTANs2LKPbb0OnGrjHBV3pNn7VsURjvqJfnfLrvPx19im9NvoL71/a4UuZIbAm3D
	F1X0wHf17vClBBt7cgli8rc+j55sTsyiIUwgQtFp1KTmeQKk8Kg2jf9FoOQJG6PJ8TBsgK5LRIJEA
	D/C7lbzB3qrhqyONJWDCdrGKYFCXvZi1TVb6dSQTyikeHwXHsNxd3aAvx3oDrswjVjeB6X4VPeZN5
	7mrwAZ4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lmbMW-00FGEk-TN; Fri, 28 May 2021 12:13:13 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lmbBD-00FAQr-67
 for linux-nvme@lists.infradead.org; Fri, 28 May 2021 12:01:36 +0000
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
 (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8DCA61FD2E;
 Fri, 28 May 2021 12:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1622203288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=28Ql1fFOwHfGvjGlsFOqzm5hrcryr9KIZc8+TcoIlRA=;
 b=rfafd+TeaZQrNT39BKAX1RgJ+bcYD/Rs3rHs8N/q64d5raxAWfffo2hBplr9OS0X2cljrS
 ftNyY2bvIxXMaQWL81+Ruuff+jiBlgu8TySAp8aPxUJmelVxlPcRr/KXGWVtZ/mCm6uaBd
 JKc1Y1ziwpGBA6Zh2OT1P/4oG3CdI1A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1622203288;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=28Ql1fFOwHfGvjGlsFOqzm5hrcryr9KIZc8+TcoIlRA=;
 b=U6d5DrMBqQcLRms71v6dqZknwv6Qigi+BZowmQsVUAnr6JvfWr2VvtAi15m3P74nKSwz9m
 LnJUGMj5odjdosAw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
 by imap.suse.de (Postfix) with ESMTP id 56F0A11A98;
 Fri, 28 May 2021 12:01:28 +0000 (UTC)
Received: from director2.suse.de ([192.168.254.72]) by imap3-int with ESMTPSA
 id 6Hx9FJjbsGCqGQAALh3uQQ
 (envelope-from <hare@suse.de>); Fri, 28 May 2021 12:01:28 +0000
Subject: Re: [RFC PATCH v6 10/27] qed: Add NVMeTCP Offload PF Level FW and HW
 HSI
To: Shai Malin <smalin@marvell.com>, netdev@vger.kernel.org,
 linux-nvme@lists.infradead.org, davem@davemloft.net, kuba@kernel.org,
 sagi@grimberg.me, hch@lst.de, axboe@fb.com, kbusch@kernel.org
Cc: aelior@marvell.com, mkalderon@marvell.com, okulkarni@marvell.com,
 pkushwaha@marvell.com, malin1024@gmail.com,
 Dean Balandin <dbalandin@marvell.com>
References: <20210527235902.2185-1-smalin@marvell.com>
 <20210527235902.2185-11-smalin@marvell.com>
From: Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <e83f1143-042e-0e0a-01e1-8e8720f8ffa8@suse.de>
Date: Fri, 28 May 2021 14:01:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210527235902.2185-11-smalin@marvell.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210528_050131_502940_E19996C1 
X-CRM114-Status: GOOD (  15.20  )
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

T24gNS8yOC8yMSAxOjU4IEFNLCBTaGFpIE1hbGluIHdyb3RlOgo+IFRoaXMgcGF0Y2ggaW50cm9k
dWNlcyB0aGUgTlZNZVRDUCBkZXZpY2UgYW5kIFBGIGxldmVsIEhTSSBhbmQgSFNJCj4gZnVuY3Rp
b25hbGl0eSBpbiBvcmRlciB0byBpbml0aWFsaXplIGFuZCBpbnRlcmFjdCB3aXRoIHRoZSBIVyBk
ZXZpY2UuCj4gVGhlIHBhdGNoIGFsc28gYWRkcyBxZWQgTlZNZVRDUCBwZXJzb25hbGl0eS4KPiAK
PiBUaGlzIHBhdGNoIGlzIGJhc2VkIG9uIHRoZSBxZWRlLCBxZWRyLCBxZWRpLCBxZWRmIGRyaXZl
cnMgSFNJLgo+IAo+IEFja2VkLWJ5OiBJZ29yIFJ1c3NraWtoIDxpcnVzc2tpa2hAbWFydmVsbC5j
b20+Cj4gU2lnbmVkLW9mZi1ieTogRGVhbiBCYWxhbmRpbiA8ZGJhbGFuZGluQG1hcnZlbGwuY29t
Pgo+IFNpZ25lZC1vZmYtYnk6IFByYWJoYWthciBLdXNod2FoYSA8cGt1c2h3YWhhQG1hcnZlbGwu
Y29tPgo+IFNpZ25lZC1vZmYtYnk6IE9ta2FyIEt1bGthcm5pIDxva3Vsa2FybmlAbWFydmVsbC5j
b20+Cj4gU2lnbmVkLW9mZi1ieTogU2hhaSBNYWxpbiA8c21hbGluQG1hcnZlbGwuY29tPgo+IFNp
Z25lZC1vZmYtYnk6IE1pY2hhbCBLYWxkZXJvbiA8bWthbGRlcm9uQG1hcnZlbGwuY29tPgo+IFNp
Z25lZC1vZmYtYnk6IEFyaWVsIEVsaW9yIDxhZWxpb3JAbWFydmVsbC5jb20+Cj4gLS0tCj4gIGRy
aXZlcnMvbmV0L2V0aGVybmV0L3Fsb2dpYy9LY29uZmlnICAgICAgICAgICB8ICAgMyArCj4gIGRy
aXZlcnMvbmV0L2V0aGVybmV0L3Fsb2dpYy9xZWQvTWFrZWZpbGUgICAgICB8ICAgMiArCj4gIGRy
aXZlcnMvbmV0L2V0aGVybmV0L3Fsb2dpYy9xZWQvcWVkLmggICAgICAgICB8ICAgNSArCj4gIGRy
aXZlcnMvbmV0L2V0aGVybmV0L3Fsb2dpYy9xZWQvcWVkX2N4dC5jICAgICB8ICAyNiArKwo+ICBk
cml2ZXJzL25ldC9ldGhlcm5ldC9xbG9naWMvcWVkL3FlZF9kZXYuYyAgICAgfCAgNDggKystCj4g
IGRyaXZlcnMvbmV0L2V0aGVybmV0L3Fsb2dpYy9xZWQvcWVkX2hzaS5oICAgICB8ICAgNCArLQo+
ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9xbG9naWMvcWVkL3FlZF9sbDIuYyAgICAgfCAgMzIgKy0K
PiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvcWxvZ2ljL3FlZC9xZWRfbWNwLmMgICAgIHwgICAzICsK
PiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvcWxvZ2ljL3FlZC9xZWRfbW5nX3Rsdi5jIHwgICAzICst
Cj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L3Fsb2dpYy9xZWQvcWVkX252bWV0Y3AuYyB8IDI4MiAr
KysrKysrKysrKysrKysrKysKPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvcWxvZ2ljL3FlZC9xZWRf
bnZtZXRjcC5oIHwgIDUxICsrKysKPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvcWxvZ2ljL3FlZC9x
ZWRfb29vLmMgICAgIHwgICAzICstCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L3Fsb2dpYy9xZWQv
cWVkX3NwLmggICAgICB8ICAgMiArCj4gIC4uLi9uZXQvZXRoZXJuZXQvcWxvZ2ljL3FlZC9xZWRf
c3BfY29tbWFuZHMuYyB8ICAgMSArCj4gIGluY2x1ZGUvbGludXgvcWVkL252bWV0Y3BfY29tbW9u
LmggICAgICAgICAgICB8ICA1NCArKysrCj4gIGluY2x1ZGUvbGludXgvcWVkL3FlZF9pZi5oICAg
ICAgICAgICAgICAgICAgICB8ICAyMiArKwo+ICBpbmNsdWRlL2xpbnV4L3FlZC9xZWRfbnZtZXRj
cF9pZi5oICAgICAgICAgICAgfCAgNzIgKysrKysKPiAgMTcgZmlsZXMgY2hhbmdlZCwgNTkzIGlu
c2VydGlvbnMoKyksIDIwIGRlbGV0aW9ucygtKQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVy
cy9uZXQvZXRoZXJuZXQvcWxvZ2ljL3FlZC9xZWRfbnZtZXRjcC5jCj4gIGNyZWF0ZSBtb2RlIDEw
MDY0NCBkcml2ZXJzL25ldC9ldGhlcm5ldC9xbG9naWMvcWVkL3FlZF9udm1ldGNwLmgKPiAgY3Jl
YXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvbGludXgvcWVkL252bWV0Y3BfY29tbW9uLmgKPiAgY3Jl
YXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvbGludXgvcWVkL3FlZF9udm1ldGNwX2lmLmgKPiAKUmV2
aWV3ZWQtYnk6IEhhbm5lcyBSZWluZWNrZSA8aGFyZUBzdXNlLmRlPgoKQ2hlZXJzLAoKSGFubmVz
Ci0tIApEci4gSGFubmVzIFJlaW5lY2tlCQkgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVj
dApoYXJlQHN1c2UuZGUJCQkgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNv
ZnR3YXJlIFNvbHV0aW9ucyBHZXJtYW55IEdtYkgsIDkwNDA5IE7DvHJuYmVyZwpHRjogRi4gSW1l
bmTDtnJmZmVyLCBIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZykKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4
LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
