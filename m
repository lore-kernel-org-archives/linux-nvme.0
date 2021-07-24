Return-Path: <SRS0=i1kA=MQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C4EFC4338F
	for <linux-nvme@archiver.kernel.org>; Sat, 24 Jul 2021 11:18:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A128360E95
	for <linux-nvme@archiver.kernel.org>; Sat, 24 Jul 2021 11:18:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A128360E95
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a09ueoDwwQ/6kkXEujg8058IqxYUxZga+t9Mc4xZFSk=; b=IWi1o76cp8sHaDTa8owYt/2GUZ
	X6V00hJCkG+3XXe/KFjePfo3ONfuDrgGRRNB7QI8difyETjPOnAdWx5Amd+GDzR05qyUnFNYhBYST
	0C6sYArgrKd761spVKs0F4efCopLEd1yjQq9PdVr7TCRYN/4BZDJwM4eUAwmYWzVBueRX+zW/e0JL
	CtyMTBcOa7QTSIUlpwDhx7VilYK7xjkyacjbtETxArin1VDlFmfBXUxdI+Nqf3OD8jJCon/HOMj6R
	XSgbGh72w5FbriTMDXPCyoiWJESbnG3d/+V1AEmfLoqw9Vd48xlDeIP6qfcXzy3kUiSW/8VfP1mEb
	iwVgDkeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m7Ff4-0076Qv-NH; Sat, 24 Jul 2021 11:17:42 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m7Ff1-0076QU-HU
 for linux-nvme@lists.infradead.org; Sat, 24 Jul 2021 11:17:40 +0000
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0768D2004F;
 Sat, 24 Jul 2021 11:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1627125455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NkVWf78L+AoJgvAxJsjn66EGaBxm+SYMwkmixM6XH9I=;
 b=D8UWHPr3nT8G3QJl8mOWyoyMkloqPk3c7kb+geAfYRVSHj2uqsK/DKUI3YuO2ndyTHp555
 fv1hh0zaWK+0TLORtjKYvRkY2y1RBJIUfYdAm1k1m07anhFUQVlMs7un5A1uWl9pZisRGh
 EMrkXbqJRvkckeTr14T8LK6Pi+i/x/s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1627125455;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NkVWf78L+AoJgvAxJsjn66EGaBxm+SYMwkmixM6XH9I=;
 b=5ucQesTJjyzpPjf6QKPaWWrFKbny+4STqzMvso07sLVjN8IqMLu94xhLINjuZ72kjZubTI
 Dro8otJtwriqO+Cw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id D104F13982;
 Sat, 24 Jul 2021 11:17:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id FmmlMc72+2DpYgAAGKfGzw
 (envelope-from <hare@suse.de>); Sat, 24 Jul 2021 11:17:34 +0000
Subject: Re: [RFC PATCH 00/11] nvme: In-band authentication support
To: Vladislav Bolkhovitin <vst@vlnb.net>, Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org
References: <20210716110428.9727-1-hare@suse.de>
 <66b3b869-02bd-9dee-fadc-8538c6aad57a@vlnb.net>
 <e339e6e7-fc32-2480-ca99-516547105776@suse.de>
 <833cfd62-1e1f-1dca-2e38-ff07b3a5e8fb@vlnb.net>
 <2f241490-3bfd-2151-9d76-970e0d6bfd68@vlnb.net>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <d1ca46ef-4615-9385-f30b-281b6c39ac8a@suse.de>
Date: Sat, 24 Jul 2021 13:17:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <2f241490-3bfd-2151-9d76-970e0d6bfd68@vlnb.net>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210724_041739_782107_6D82251C 
X-CRM114-Status: GOOD (  18.49  )
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

T24gNy8yMy8yMSAxMDowMiBQTSwgVmxhZGlzbGF2IEJvbGtob3ZpdGluIHdyb3RlOgo+IEFub3Ro
ZXIgY29tbWVudCBpcyB0aGF0IGJldHRlciB0byBwZXJmb3JtIENSQyBjaGVjayBvZiBkaGNoYXBf
c2VjcmV0IGFuZAo+IGdlbmVyYXRpb24gb2YgZGhjaGFwX2tleSByaWdodCB3aGVyZSB0aGUgc2Vj
cmV0IHdhcyBzcGVjaWZpZWQgKGUuZy4sCj4gbnZtZXRfYXV0aF9zZXRfaG9zdF9rZXkoKSBvbiB0
aGUgdGFyZ2V0IHNpZGUpLgo+IAo+IE5vIG5lZWQgdG8gZG8gaXQgZXZlcnkgdGltZSBmb3IgZXZl
cnkgY29ubmVjdGlvbiBhbmQgYnkgdGhhdCBpbmNyZWFzZQo+IGF1dGhlbnRpY2F0aW9uIGxhdGVu
Y3kuIEFzIEkgd3JvdGUgaW4gdGhlIG90aGVyIGNvbW1lbnQsIGl0IG1pZ2h0IGJlIDEyOAo+IG9y
IG1vcmUgY29ubmVjdGlvbnMgZXN0YWJsaXNoZWQgZHVyaW5nIGNvbm5lY3RpbmcgdG8gYSBzaW5n
bGUgTlZNZS1vRgo+IGRldmljZS4KPiAKQW5kIHRoaXMgaXMgc29tZXRoaW5nIEkgZGlkIGRlbGli
ZXJhdGVseS4KVGhlIHByaW1hcnkgaXNzdWUgaGVyZSBpcyB0aGF0IHRoZSB1c2VyIG1pZ2h0IHdh
bnQvbmVlZCB0byBjaGFuZ2UgdGhlIApQU0sgZm9yIHJlLWF1dGhlbnRpY2F0aW9uLiBCdXQgZm9y
IHRoYXQgaGUgbWlnaHQgbmVlZCB0byBjaGVjayB3aGF0IHRoZSAKb3JpZ2luYWwvY3VycmVudCBQ
U0sgaXMsIHNvIEkgdGhpbmsgd2UgbmVlZCB0byBrZWVwIHRoZSBvcmlnaW5hbCBQU0sgYXMgCnBh
c3NlZCBpbiBmcm9tIHRoZSB1c2VyLgpBbmQgSSBmb3VuZCBpdCBhIHdhc3RlIG9mIHNwYWNlIHRv
IHN0b3JlIHRoZSBkZWNvZGVkIHNlY3JldCBpbiBhZGRpdGlvbiAKdG8gdGhlIG9yaWdpbmFsIG9u
ZSwgc2VlaW5nIHRoYXQgaXQgY2FuIGJlIGRlcml2ZWQgZnJvbSB0aGUgb3JpZ2luYWwgb25lLgpC
dXQgeW91ciBhcmd1bWVudCBhYm91dCB0aGUgbWFueSBjb25uZWN0aW9ucyByZXF1aXJlZCBmb3Ig
YSBzaW5nbGUgTlZNZSAKYXNzb2NpYXRpb24gaXMgY2VydGFpbmx5IHRydWUsIHRvIGl0IHdvdWxk
IG1ha2Ugc2Vuc2UgdG8ga2VlcCB0aGUgZGVjb2RlIApvbmUgYXJvdW5kLCB0b28sIGp1c3QgdG8g
c3BlZWQgdXAgY29tcHV0YXRpb24uCldpbGwgYmUgdXBkYXRpbmcgdGhlIHBhdGNoc2V0LgoKQ2hl
ZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlICAgICAgICAgICAgICAgIEtlcm5l
bCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHbWJILCBNYXhm
ZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBHZXNj
aMOkZnRzZsO8aHJlcjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1u
dm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9saW51eC1udm1lCg==
