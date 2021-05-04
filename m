Return-Path: <SRS0=iWk4=J7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CED5C433B4
	for <linux-nvme@archiver.kernel.org>; Tue,  4 May 2021 13:40:52 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC7E161104
	for <linux-nvme@archiver.kernel.org>; Tue,  4 May 2021 13:40:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC7E161104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=scMkyLI1KNF9Lu7WaI9PMy0P6W+uazEnpmo0U/HnmIE=; b=PzRUuDV3kv6Y9hkIORkyGQmd5
	x1G13AX2+LSmldzu/nxlyugE8i8LkwFmAoM1gYheMkiTQNOqSvfLUAS0eTKrcLgOrcGZfDwNaJnZU
	tQjs8nx9GT5Nv2j99SFCgAd4o8i+oDBRgX8iJW9KZhN+BaU7Uy89B+wZ3c0Ff3YEDUtzAV3cqzSAf
	pZLwSnsLEeoc5eiOFoIXBLpQa01crYJGuwxpnFIcHhN9ZRbMuM8YE9O+PFNjuv+pL71ZUVE7XcVos
	qSeOMrEHnNpUPObHleamDd+nNCYsZoAw4lVaJpZuUwLmDWZ+tldyeg/1Soa+ID1yMODaM02SL1iP7
	42Utp+LFQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ldvHu-00GI1X-2H; Tue, 04 May 2021 13:40:34 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldvHs-00GI1P-AZ
 for linux-nvme@desiato.infradead.org; Tue, 04 May 2021 13:40:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=PWw4+n2+EYntQZORdvEBrVMggr7ZmVvaVi3/lpYRdro=; b=JQVymB0tUKX09gk85pL0aKmPYi
 v68+pvzY4z6NwLlfj2pOj6j1RVdFG5fNtHUp4Oqmaorw8hTN5Cv/ablQji8NnG7SbINex8YLc5EOq
 YqoUs1fhA6FDIviMUVQN/MUPOnPZ0oPaDn7mlCjdDj7RvPW7L5bNtbLlnrUmJs8y0eloZ01aiEZyc
 uhtqHyczHSQI9pLVFpYjmliGYpmQLyy19C6eKMbW29+t9nOFLyJtsF4j09DcfWAUi6rCEfQTRxkYT
 hr/cLimNGDwApes5kKtOlBVctj0PBVCu2/ThWlLiG04v40Fx6MkBInNXiHX4tvyF9TUr1zJ0Upz5Z
 CDwbjjUg==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldvHp-0040bD-Do
 for linux-nvme@lists.infradead.org; Tue, 04 May 2021 13:40:31 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 551A5AF2F;
 Tue,  4 May 2021 13:40:26 +0000 (UTC)
Subject: Re: [PATCHv3] nvme-mpath: delete disk after last connection
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Daniel Wagner <daniel.wagner@suse.de>
References: <20210501120447.45478-1-hare@suse.de>
 <20210504085457.GA21826@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <5e4df9ec-c66c-17cf-542f-bac71b490e62@suse.de>
Date: Tue, 4 May 2021 15:40:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210504085457.GA21826@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210504_064029_635141_6259A8A6 
X-CRM114-Status: GOOD (  18.86  )
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

T24gNS80LzIxIDEwOjU0IEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPiBBcyBzdGF0ZWQg
aW4gdGhlIHYzIHJldmlldyB0aGlzIGlzIGFuIGluY29tcGF0aWJsZSBjaGFuZ2UuICBXZSdsbCBu
ZWVkCj4gdGhlIHF1ZXVlX2lmX25vX3BhdGggYXR0cmlidXRlIGZpcnN0LCBhbmQgZGVmYXVsdCBp
dCB0byBvbiB0byBrZWVwCj4gY29tcGF0YWJpbGl0eS4KPiAKClRoYXQgaXMgd2hhdCBJIHRyaWVk
IHRoZSBsYXN0IHRpbWUsIGJ1dCB0aGUgZGlyZWN0aW9uIEkgZ290IHdhcyB0byB0cmVhdCAKYm90
aCwgTlZNZS1QQ0kgYW5kIE5WTWUtb0YgaWRlbnRpY2FsbHk6CihodHRwczovL2xvcmUua2VybmVs
Lm9yZy9saW51eC1udm1lLzM0ZTVjMTc4LThiYzQtNjhkMy04Mzc0LWZiYzFiNDUxYjZlOEBncmlt
YmVyZy5tZS8pCgogPj4+PiBBbmQgeWVzLCB0aGlzIGlzIGV4YWN0bHkgdGhlIHNhbWUgc2V0dXAs
IHRoZSBvbmx5IGRpZmZlcmVuY2UKID4+Pj4gYmVpbmcgdGhlIENNSUMgc2V0dGluZyBmb3IgdGhl
IE5WTWUgZGV2aWNlLgogPj4+CiA+Pj4gSSBhZ3JlZSB3aXRoIENocmlzdG9waCB0aGF0IHdlIHNo
b3VsZCBkbyBleGFjdGx5IHRoZSBzYW1lIGZvciBhbGwuCiA+Pj4KID4+PiBIYW5uZXMsIE15IHVu
ZGVyc3RhbmRpbmcgaGVyZSBpcyB0aGF0IHlvdSB3YW50IHRoZSBkZXZpY2UgdG8gZ28gYXdheQog
Pj4+IGFmdGVyIHRoZSBsYXN0IHBhdGggZGlzYXBwZWFyZWQgYmVjYXVzZSBpdCBicmVha3MgbWQs
IHdoeSBkb24ndCB5b3UKID4+PiB3YW50IHRvIGhhdmUgdGhpcyBhbHNvIGZvciBmYWJyaWNzPwog
Pj4+CiA+PiBPaCwgSSB3b3VsZCBfbG92ZV8gdG8gaGF2ZSBpdCBmb3IgZmFicmljcyBwZXIgZGVm
YXVsdC4KID4+IElmIHlvdSBhZ3JlZSB3aXRoIGl0IEkgY2FuIHJlc2VuZCBLZWl0aHMgb3JpZ2lu
YWwgcGF0Y2gsIHdoaWNoIHNvbHZlcwogPj4gdGhlIGlzc3VlIHdpdGhvdXQgdGhlIG5lZWQgZm9y
IGFueSBhZGRpdGlvbmFsIHNldHRpbmdzLgogPgogPiBJIHRoaW5rIHRoYXQgdGhpcyBpcyB3aGF0
IHdlIHNob3VsZCBkby4gQ2FyZSB0byByZXNlbmQgdGhpcyBmb3IKID4gYm90aCBmYWJyaWNzIGFu
ZCBwY2k/CgpTbyB3aGF0IGlzIGl0IG5vdz8KU2hvdWxkIEkgZ28gYmFjayB0byB0aGUgcHJldmlv
dXMgcGF0Y2ggc2VyaWVzPwoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tl
ICAgICAgICAgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJl
IFNvbHV0aW9ucyBHbWJILCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5
IChBRyBOw7xybmJlcmcpLCBHZXNjaMOkZnRzZsO8aHJlcjogRmVsaXggSW1lbmTDtnJmZmVyCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1l
IG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
