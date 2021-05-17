Return-Path: <SRS0=YADc=KM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAABBC433B4
	for <linux-nvme@archiver.kernel.org>; Mon, 17 May 2021 15:36:59 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0CCE61108
	for <linux-nvme@archiver.kernel.org>; Mon, 17 May 2021 15:36:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0CCE61108
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=rp8BoLEEc2G7V98hjnxIun5dweIeY5/MRfdgAyRFwPA=; b=qNB4I2yxzAEqY6x9mjPJe64Dv
	O31VkGGpJ8B2V6SqJXSkrmfnvaSgcFU/1SSop/7Asqa424OKVIyi208lJ3CJSzNdrdzYmmxVotaYx
	rS0xchpyMoOJkPZWmvkh5rwlHTnLtvvaqwlpeThdGskyzC7gacSwPtWCDVbIIw/1UGfxYFcl9yELg
	Bl8UEniX1rvenNE03iDSqhCNlCpgO+xeFZh+4hynmk3rMDzSStO24q+QEWgoV6q15YcNGuzErMyo+
	3RudnYkTkGs964iSNmNH7nr16DahAAOuUaRCiISPAcga0jzDlv6OXJOzst2DZzK8C269PjD/47Abh
	GYXgLwnhw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lifIY-00FQgX-Av; Mon, 17 May 2021 15:36:50 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lifIU-00FQfT-Nn
 for linux-nvme@desiato.infradead.org; Mon, 17 May 2021 15:36:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=UTCwMcxcCsaD7mSJ2SQZ0OxRn1orwIqZ1qydVLlChr4=; b=qnDomn75B62Bt2WuTQ3Ev3zbBt
 Q+skAKvo8UBKWiWSyJpAUyaWUa+ZguJxq4Kj/QL2y2hwR9NG1BgWljBKzZNoucWLOtHBsSQPrxbs5
 LBfc5PJ3vbFrPq7OZEs6IrKNBhToi0pZGwspvTjpGmvgyUYQPG+J9KwMBxBIvdqwv7puleE6t/1Na
 w2T6sGolCIqljx4wa+jiPADNw37Afcg1UleY5pmoTS0RTaN+qlYvp48fOTXnoTodDG6MJ6r8Kgr4o
 Cu9e/3kkfW62h2a2LCA+0C1bYkjNoXH6AhzWsUFSYtA2bQRm5x89C/YmAEDrn9qzqgFT5sMaaxGQd
 jqDIXLcA==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lifIQ-00Dvn4-Ji
 for linux-nvme@lists.infradead.org; Mon, 17 May 2021 15:36:45 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id B6C06AC47;
 Mon, 17 May 2021 15:36:40 +0000 (UTC)
Subject: Re: [PATCHv4] nvme: allow to re-attach namespaces after all paths are
 down
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
References: <20210517081809.104813-1-hare@suse.de>
 <20210517152601.GA2709350@dhcp-10-100-145-180.wdc.com>
From: Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <688618fa-a079-6d84-adf2-01ee36f95d76@suse.de>
Date: Mon, 17 May 2021 17:36:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210517152601.GA2709350@dhcp-10-100-145-180.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210517_083642_812566_5D60AF78 
X-CRM114-Status: GOOD (  17.80  )
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

T24gNS8xNy8yMSA1OjI2IFBNLCBLZWl0aCBCdXNjaCB3cm90ZToKPiBPbiBNb24sIE1heSAxNywg
MjAyMSBhdCAxMDoxODowOUFNICswMjAwLCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6Cj4+IFdlIHNo
b3VsZCBvbmx5IHJlbW92ZSB0aGUgbnMgaGVhZCBmcm9tIHRoZSBsaXN0IG9mIGhlYWRzIHBlcgo+
PiBzdWJzeXN0ZW0gaWYgdGhlIHJlZmVyZW5jZSBjb3VudCBkcm9wcyB0byB6ZXJvLiBSZW1vdmlu
ZyBpdAo+PiBhdCB0aGUgc3RhcnQgb2YgbnZtZV9uc19yZW1vdmUoKSB3aWxsIHByZXZlbnQgdXMg
ZnJvbSByZWF0dGFjaGluZwo+PiB0aGUgbmFtZXNwYWNlIHRvIHRoZSBjb3JyZWN0IG5zIGhlYWQg
b25jZSBhIHBhdGggYmVjb21lcyBhdmFpbGFibGUKPj4gYWdhaW4uCj4gCj4gVGhpcyBsb29rcyBm
aW5lIHRvIG1lCj4gCj4gUmV2aWV3ZWQtYnk6IEtlaXRoIEJ1c2NoIDxrYnVzY2hAa2VybmVsLm9y
Zz4KPiAKPiBUaGVyZSBhcmUgcG90ZW50aWFsIGNvcm5lciBjYXNlcyBhc3NvY2lhdGVkIHdpdGgg
bmFtZXNwYWNlIG1hbmFnZW1lbnQKPiB0aGF0IGNhbiBjYXVzZSBwcm9ibGVtcyBoZXJlLCBidXQg
aXQgd291bGQgY2VydGFpbmx5IGJlIGEgdXNlciBlcnJvcgo+IHRoYXQgbmVlZHMgbWFudWFsIGlu
dGVydmVudGlvbiBhbnl3YXkuIEkgc3VzcGVjdCB0aG9zZSBzY2VuYXJpb3MgYXJlCj4gdmVyeSB1
bmNvbW1vbiB0b28sIHNvIEkgdGhpbmsgd2UgY2FuIGRlYWwgd2l0aCB0aGF0IGxhdGVyIGlmIGl0
IGJlY29tZXMKPiBhIHByb2JsZW0uCj4gCkhvdyBzbz8KV2UncmUga2VlcGluZyBhIGNvcHkgb2Yg
dGhlIE5TIElEcyBhcm91bmQsIHNvIGFmdGVyIHJlY29ubmVjdCB0aGUKbmFtZXNwYWNlIHdvdWxk
IGhhdmUgdG8gcHJvdmlkZSBzYW1lIHNldCBvZiBOUyBJRHMuCgpJZiB0aGUgbmFtZXNwYWNlIGlz
IGRpZmZlcmVudCB5ZXQgcHJvdmlkaW5nIHRoZSBzYW1lIE5TIElEcyB3ZSdsbCBoYXZlIGEKcHJv
YmxlbSBldmVuIHdpdGggdGhlIGN1cnJlbnQgY29kZSwgYXMgd2UncmUgdXNpbmcgdGhlIE5EIElE
IHRvIGlkZW50aWZ5Cm11bHRpcGF0aGVkIG5hbWVzcGFjZXMuCgpPciBkbyB5b3UgaGF2ZSBhIGRp
ZmZlcmVudCBzY2VuYXJpbyBpbiBtaW5kPwoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVz
IFJlaW5lY2tlCQkgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUJ
CQkgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9u
cyBHZXJtYW55IEdtYkgsIDkwNDA5IE7DvHJuYmVyZwpHRjogRi4gSW1lbmTDtnJmZmVyLCBIUkIg
MzY4MDkgKEFHIE7DvHJuYmVyZykKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LW52bWUK
