Return-Path: <SRS0=T5dq=OD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4D7C4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 09:50:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC2176103B
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 09:50:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DC2176103B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=eX/EfPmJ4ubOZxve349r+wCKgBuDUUIC7YWrzG4oZmg=; b=UBSUmL+B1HFM6kj3OpaI3OCAly
	PqV2xj6+RGe0glm4Hc4BOnsXQnwZLLU5JuzAiHL/b09onSBAF/pVpJsUABgK7NvqkxAGv3/QHw3be
	68KpWLzDs27xhVMOI1n10ipYAeYpxe5dgVPgNZn5lMJGjCkbYqtvwHxS0OzzV+4UxQzANHGDDd7hR
	0KPQuFNHZvrkkV/xsTk6iXe+EPvumgCNl7dB0O5+aIdPVHxRWP5axRza9GwbKdkDLPxWYofM9Te7L
	xViEbwV+bHboQnyL4vHMlzF+GkA+eBFAtYFKvy4VkAri6xkO1pwEm/Y5XVwnm8NmeLb7oH39QhSfB
	gefVvYSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mPibW-0018Ym-IX; Mon, 13 Sep 2021 09:50:22 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mPiUt-0016z8-Q7
 for linux-nvme@lists.infradead.org; Mon, 13 Sep 2021 09:43:33 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 73C151FFC2;
 Mon, 13 Sep 2021 09:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1631526210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/VvwVSp+siaxFTQ0nA6pMCVjKYop5kzwx3kuWkB4cEI=;
 b=XYteGMtx3EeOM+WhtNnveTpaloytVuzV6CeoDtq8zWupweE596UyK/INUuaTrkF5XoUmrz
 ZjajeV045o3BPEy5amh+hjLJa/rxwhmbXi1tT74bDh8HOe6UNiOMqydBeYkayoARVTBzLr
 SbG4ECWagU89EK6mzWZ10gz25P98QwU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1631526210;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/VvwVSp+siaxFTQ0nA6pMCVjKYop5kzwx3kuWkB4cEI=;
 b=3AMNTROkHLgXA3U5yhHkU7/4Og8g1bCHeMyZxQSK2OH8bYQadAUd7diKMUJJginSRUee4x
 voTLgF7jf4tW7ADw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6371B13A09;
 Mon, 13 Sep 2021 09:43:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id vGobGEIdP2E8YgAAMHmgww
 (envelope-from <hare@suse.de>); Mon, 13 Sep 2021 09:43:30 +0000
Subject: Re: [PATCHv3 00/12] nvme: In-band authentication support
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, linux-nvme@lists.infradead.org,
 linux-crypto@vger.kernel.org
References: <20210910064322.67705-1-hare@suse.de>
 <47a839c3-1c8d-9ccf-3b3d-387862227c4f@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <0ab8d79a-6403-9177-319d-ad41dfa4c41b@suse.de>
Date: Mon, 13 Sep 2021 11:43:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <47a839c3-1c8d-9ccf-3b3d-387862227c4f@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210913_024332_083401_ABD18506 
X-CRM114-Status: GOOD (  17.99  )
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

T24gOS8xMy8yMSAxMToxNiBBTSwgU2FnaSBHcmltYmVyZyB3cm90ZToKPiAKPj4gSGkgYWxsLAo+
Pgo+PiByZWNlbnQgdXBkYXRlcyB0byB0aGUgTlZNZSBzcGVjIGhhdmUgYWRkZWQgZGVmaW5pdGlv
bnMgZm9yIGluLWJhbmQKPj4gYXV0aGVudGljYXRpb24sIGFuZCBzZWVpbmcgdGhhdCBpdCBwcm92
aWRlcyBzb21lIHJlYWwgYmVuZWZpdAo+PiBlc3BlY2lhbGx5IGZvciBOVk1lLVRDUCBoZXJlJ3Mg
YW4gYXR0ZW1wdCB0byBpbXBsZW1lbnQgaXQuCj4+Cj4+IFRyaWNreSBiaXQgaGVyZSBpcyB0aGF0
IHRoZSBzcGVjaWZpY2F0aW9uIG9yaWVudHMgaXRzZWxmIG9uIFRMUyAxLjMsCj4+IGJ1dCBzdXBw
b3J0cyBvbmx5IHRoZSBGRkRIRSBncm91cHMuIFdoaWNoIG9mIGNvdXJzZSB0aGUga2VybmVsIGRv
ZXNuJ3QKPj4gc3VwcG9ydC4gSSd2ZSBiZWVuIGFibGUgdG8gY29tZSB1cCB3aXRoIGEgcGF0Y2gg
Zm9yIHRoaXMsIGJ1dCBhcyB0aGlzCj4+IGlzIG15IGZpcnN0IGF0dGVtcHQgdG8gZml4IGFueXRo
aW5nIGluIHRoZSBjcnlwdG8gYXJlYSBJIHdvdWxkIGludml0ZQo+PiBwZW9wbGUgbW9yZSBmYW1p
bGlhciB3aXRoIHRoZXNlIG1hdHRlcnMgdG8gaGF2ZSBhIGxvb2suCj4+Cj4+IEFsc28gbm90ZSB0
aGF0IHRoaXMgaXMganVzdCBmb3IgaW4tYmFuZCBhdXRoZW50aWNhdGlvbi4gU2VjdXJlCj4+IGNv
bmNhdGVuYXRpb24gKGllIHN0YXJ0aW5nIFRMUyB3aXRoIHRoZSBuZWdvdGlhdGVkIHBhcmFtZXRl
cnMpIGlzIG5vdAo+PiBpbXBsZW1lbnRlZDsgb25lIHdvdWxkIG5lZWQgdG8gdXBkYXRlIHRoZSBr
ZXJuZWwgVExTIGltcGxlbWVudGF0aW9uCj4+IGZvciB0aGlzLCB3aGljaCBhdCB0aGlzIHRpbWUg
aXMgYmV5b25kIHNjb3BlLgo+Pgo+PiBBcyB1c3VhbCwgY29tbWVudHMgYW5kIHJldmlld3MgYXJl
IHdlbGNvbWUuCj4gCj4gU3RpbGwgbm8gbnZtZS1jbGkgbm9yIG52bWV0Y2xpIDooCgpKdXN0IHNl
bmQgaXQgKGZvciBsaWJudm1lIGFuZCBudm1lLWNsaSkuIFBhdGNoIGZvciBudm1ldGNsaSB0byBm
b2xsb3cuCgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2UJCSAgICAgICAg
ICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5kZQkJCSAgICAgICAgICAgICAg
ICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdlcm1hbnkgR21i
SCwgTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnCkhSQiAzNjgwOSAoQUcgTsO8cm5iZXJn
KSwgR0Y6IEZlbGl4IEltZW5kw7ZyZmZlcgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8vbGludXgtbnZtZQo=
