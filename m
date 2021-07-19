Return-Path: <SRS0=+L5I=ML=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CAAC07E9B
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Jul 2021 11:12:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4620E6108B
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Jul 2021 11:12:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4620E6108B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=ZDorinl4byRKlb9SqFFto8Zn1V+MTa2jDc1r1yFJJ24=; b=uU8tg2J+6H5TCKvDbLWgIogAr1
	bKnrzFmELmg5y79SXtfWM4NWEvm7DaSGoX71C3w0PETLKKPWlI7De5wIvsL5KsEdRN2BIrUFiu5qS
	xP3O0K5zvG/TdyK7vWzwNHGit1LaM9P2C2SFjb05oyWa02hrUS5LP2budR6dpEqhTtJbFpBxJqhsP
	nhP5rz9STJ2L57xJakD7qkv9uV04+KlrfKpq8atnHWRsx2RVUw/84iEgyG72rVMiydTfr/rHaZyxP
	AnRYd4ZbLkhNGuP1YpGmuM87HHhNX0IRJ4+3BRy30PLifBx/kJGthi84C8/P3OzkMK94K8e3q14V7
	+IQbQBqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m5RBI-009STq-OJ; Mon, 19 Jul 2021 11:11:28 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m5RBF-009SSg-IV
 for linux-nvme@lists.infradead.org; Mon, 19 Jul 2021 11:11:27 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 42D0620211;
 Mon, 19 Jul 2021 11:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1626693084; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ifLJS6gG3h3JfPSPBAaSbsZ8FktMPmEJAcxEtc8PggA=;
 b=FxodbbgtmOviT0rbr5nThGXSmfpNsFhhzGnh+34rmwUWvRWYZIwhC7Tf1cLeZAhcWITV/R
 S7rWEOU6YYWiFd8rdqhVcI/2jdVBcuRfWtFQvkwCg1Z14B+BEcMBP/rOZJ5hlV5wSB8NmC
 TbG/h7jaWHG7e6xUNIGznOwncgNkfDI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1626693084;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ifLJS6gG3h3JfPSPBAaSbsZ8FktMPmEJAcxEtc8PggA=;
 b=Ry4KuHfjsKJoas5R0+5IIHHudRg08K4HqARIG23oWozAgirg+qjJNbMANujAW4CK1EXbBW
 y0Z6jGGQdiKahrDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3338013CDE;
 Mon, 19 Jul 2021 11:11:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Af0tDNxd9WATSgAAMHmgww
 (envelope-from <hare@suse.de>); Mon, 19 Jul 2021 11:11:24 +0000
Subject: Re: [RFC PATCH 00/11] nvme: In-band authentication support
To: Simo Sorce <simo@redhat.com>, Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org
References: <20210716110428.9727-1-hare@suse.de>
 <fce7efe2a5f1047e9f4ab93eedf5ace1946d308c.camel@redhat.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <310097fc-03a9-dc13-6615-2715d59260a2@suse.de>
Date: Mon, 19 Jul 2021 13:11:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <fce7efe2a5f1047e9f4ab93eedf5ace1946d308c.camel@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210719_041125_804356_229E32F8 
X-CRM114-Status: GOOD (  20.26  )
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

T24gNy8xOS8yMSAxMjowMiBQTSwgU2ltbyBTb3JjZSB3cm90ZToKPiBPbiBGcmksIDIwMjEtMDct
MTYgYXQgMTM6MDQgKzAyMDAsIEhhbm5lcyBSZWluZWNrZSB3cm90ZToKPj4gSGkgYWxsLAo+Pgo+
PiByZWNlbnQgdXBkYXRlcyB0byB0aGUgTlZNZSBzcGVjIGhhdmUgYWRkZWQgZGVmaW5pdGlvbnMg
Zm9yIGluLWJhbmQKPj4gYXV0aGVudGljYXRpb24sIGFuZCBzZWVpbmcgdGhhdCBpdCBwcm92aWRl
cyBzb21lIHJlYWwgYmVuZWZpdCBlc3BlY2lhbGx5Cj4+IGZvciBOVk1lLVRDUCBoZXJlJ3MgYW4g
YXR0ZW1wdCB0byBpbXBsZW1lbnQgaXQuCj4+Cj4+IFRyaWNreSBiaXQgaGVyZSBpcyB0aGF0IHRo
ZSBzcGVjaWZpY2F0aW9uIG9yaWVudHMgaXRzZWxmIG9uIFRMUyAxLjMsCj4+IGJ1dCBzdXBwb3J0
cyBvbmx5IHRoZSBGRkRIRSBncm91cHMuIFdoaWNoIG9mIGNvdXJzZSB0aGUga2VybmVsIGRvZXNu
J3QKPj4gc3VwcG9ydC4gSSd2ZSBiZWVuIGFibGUgdG8gY29tZSB1cCB3aXRoIGEgcGF0Y2ggZm9y
IHRoaXMsIGJ1dCBhcyB0aGlzCj4+IGlzIG15IGZpcnN0IGF0dGVtcHQgdG8gZml4IGFueXRoaW5n
IGluIHRoZSBjcnlwdG8gYXJlYSBJIHdvdWxkIGludml0ZQo+PiBwZW9wbGUgbW9yZSBmYW1pbGlh
ciB3aXRoIHRoZXNlIG1hdHRlcnMgdG8gaGF2ZSBhIGxvb2suCj4+Cj4+IEFsc28gbm90ZSB0aGF0
IHRoaXMgaXMganVzdCBmb3IgaW4tYmFuZCBhdXRoZW50aWNhdGlvbi4gU2VjdXJlIGNvbmNhdGVu
YXRpb24KPj4gKGllIHN0YXJ0aW5nIFRMUyB3aXRoIHRoZSBuZWdvdGlhdGVkIHBhcmFtZXRlcnMp
IGlzIG5vdCBpbXBsZW1lbnRlZDsgb25lIHdvdWxkCj4+IG5lZWQgdG8gdXBkYXRlIHRoZSBrZXJu
ZWwgVExTIGltcGxlbWVudGF0aW9uIGZvciB0aGlzLCB3aGljaCBhdCB0aGlzIHRpbWUgaXMKPj4g
YmV5b25kIHNjb3BlLgo+Pgo+PiBBcyB1c3VhbCwgY29tbWVudHMgYW5kIHJldmlld3MgYXJlIHdl
bGNvbWUuCj4gCj4gSGkgSGFubmVzLAo+IGNvdWxkIHlvdSBwbGVhc2UgcmVmZXJlbmNlIHRoZSBz
cGVjaWZpYyBzdGFuZGFyZHMgdGhhdCBkZXNjcmliZSB0aGUKPiBOVk1lIGF1dGhlbnRpY2F0aW9u
IHByb3RvY29scz8KPiAKCmh0dHBzOi8vbnZtZXhwcmVzcy5vcmcvd3AtY29udGVudC91cGxvYWRz
L05WTS1FeHByZXNzLUJhc2UtU3BlY2lmaWNhdGlvbi0yXzAtMjAyMS4wNi4wMi1SYXRpZmllZC01
LnBkZgoKU2VjdGlvbiAnOC4xMyBOVk1lLW92ZXItRmFicmljcyBJbi1iYW5kIGF1dGhlbnRpY2F0
aW9uJwoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlCQkgICAgICAgICAg
IEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUJCQkgICAgICAgICAgICAgICAg
ICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHZXJtYW55IEdtYkgs
IE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyks
IEdGOiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2xpbnV4LW52bWUK
