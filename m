Return-Path: <SRS0=15Zf=IO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7993AC433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 09:36:47 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCB626500E
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 09:36:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCB626500E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=U9VXYasf4mwTnqwwur5ETtkXLpFzZH1QUwTYYtUB2gc=; b=XEFDN9/nC1B9iAy9NSctPos6D
	b7rj/y7ZaDBt/8bmGh4I34iagybQvrvqbCYmQlpgconxGzU2qQMNOPYWGT1/Yfi5493Ns64s9/hxI
	MpYywDUEVnYbCes8ygnVNSa0BPSjbAXwJaiUrRxJH1MYdcBxxYNBpLuAkS2U+ar+e5ii0Yx6LX+iP
	IngzWsOdhqB/BEx05YOkl8SmoN+Fftl6QEs5h2802COF/t1fJl7joew0uLVVG2vntJBICCJF4BdnU
	ZU+Q8KZk1RpFNCxxL3BSi06CuOV0XuCSxfY9JwGham3dZrylEnQFS+Cn6Fvnq5kzj//42YBlwHw1K
	VSIDOYBrg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lM67z-000Ik1-Ep; Tue, 16 Mar 2021 09:36:39 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lM67w-000Ijb-12
 for linux-nvme@lists.infradead.org; Tue, 16 Mar 2021 09:36:37 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id CC2FCAC1F;
 Tue, 16 Mar 2021 09:36:34 +0000 (UTC)
Subject: Re: [PATCH 01/10] nvme-discover: lookup existing persistent
 controllers
To: Sagi Grimberg <sagi@grimberg.me>, mwilck@suse.com,
 Keith Busch <kbusch@kernel.org>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, Enzo Matsumiya <ematsumiya@suse.de>
References: <20210306003624.21102-1-mwilck@suse.com>
 <20210306003624.21102-2-mwilck@suse.com>
 <b7f98f09-c21d-579d-c925-5b511796c7f5@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <4e0f2eb7-d546-7862-8845-637e4c4662da@suse.de>
Date: Tue, 16 Mar 2021 10:36:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <b7f98f09-c21d-579d-c925-5b511796c7f5@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210316_093636_168337_F11C5894 
X-CRM114-Status: GOOD (  15.25  )
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

T24gMy8xNS8yMSA2OjM4IFBNLCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+IAo+PiBGcm9tOiBIYW5u
ZXMgUmVpbmVja2UgPGhhcmVAc3VzZS5kZT4KPj4KPj4gSWYgcGVyc2lzdGVudCBjb250cm9sbGVy
IGNvbm5lY3Rpb25zIGFyZSBwcmVzZW50IHRoZXkgc2hvdWxkIGJlCj4+IHByZWZlcnJlZCBldmVu
IGlmIG5vIC0tZGV2aWNlIG9wdGlvbiBpcyBnaXZlbiBvbiB0aGUgY29tbWFuZGxpbmUuCj4+IFRv
IGF2b2lkIHNlbGVjdGluZyBhIHRlbXBvcmFyeSBub24tcGVyc2lzdGVudCBjb250cm9sbGVyIHRo
ZQo+PiAna2F0bycgYXR0cmlidXRlIGlzIGNoZWNrZWQ7IGFueSBjb250cm9sbGVyIHdoaWNoIGRv
ZXMgbm90IGhhdmUKPj4gdGhpcyBhdHRyaWJ1dGUgb3IgZm9yIHdoaWNoIHRoZSBhdHRyaWJ1dGUg
aXMgJzAnIHdpbGwgYmUgc2tpcHBlZC4KPiAKPiBXaHk/Cj4gCj4gWW91IGFsc28gbmVlZCBhIGZh
bGxiYWNrIGluIGNhc2Uga2F0byBpcyBub3QgZXhwb3NlZCBpbiBwcmlvcgo+IGtlcm5lbHMuCgpU
aGUgaWRlYSB3YXMgdG8gbWFrZSB0aGUgJy0tZGV2aWNlJyBhdHRyaWJ1dGUgb3B0aW9uYWwgX2lm
Zl8gdGhlIGtlcm5lbCAKZXhwb3NlcyB0aGUgJ2thdG8nIGF0dHJpYnV0ZSBfYW5kXyB0aGF0IGF0
dHJpYnV0ZSBpcyBub24temVyby4KCk5vdGhpbmcgbW9yZSwgbm90aGluZyBsZXNzLgoKQXBwYXJl
bnRseSB0aGUgY29tbWVudCB3YXMgc2xpZ2h0bHkgbWlzbGVhZGluZy4KSSBuZXZlciBpbnRlbmRl
ZCB0byBjaGFuZ2UgdGhlIGN1cnJlbnQgYmVoYXZpb3VyIGlmIHRoZSAna2F0bycgYXR0cmlidXRl
IAppcyBub3QgZXhwb3NlZC4KCkNoZWVycwoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tl
ICAgICAgICAgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJl
IFNvbHV0aW9ucyBHbWJILCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5
IChBRyBOw7xybmJlcmcpLCBHZXNjaMOkZnRzZsO8aHJlcjogRmVsaXggSW1lbmTDtnJmZmVyCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1l
IG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
