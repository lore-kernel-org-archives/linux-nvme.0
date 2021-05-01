Return-Path: <SRS0=FZGd=J4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF5FC433B4
	for <linux-nvme@archiver.kernel.org>; Sat,  1 May 2021 12:19:15 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49D7861409
	for <linux-nvme@archiver.kernel.org>; Sat,  1 May 2021 12:19:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49D7861409
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7ngWb3Lu0qjmgQu6U7MHjJAV84z44zwjM/HPIo1X8Ww=; b=oZIYKuF2GWWgTGO89dMePOZYm
	E4QJ5cfgEBN+xwZ9fuXCNLt96m4Ux21cwye5sS0imARtknI+t0UB23TCCsqxNcis6v84v0km/rOVW
	8D9DT0oM6afEBwQEDWvUsl75O3417YrJ4o3aYfWtmAw/TXoJvBLhbfKW0gBqbbgpy1NBtBTD4vqQS
	oUaXOGkSGcy4SKqrLIfVewggVLSjLDVLOL/opZ5vCT5e6s3xU+SPI5Q/ufbROdGJGGsxC+RrSADDt
	pacQ07i4UvJAsINNctwQBDgnIRvgiTJoXEo7ygJ7j08Ct0uxnsAF8Ijvo7qMkeY9TOUE7aoS3qWYb
	ZPnp6BsEw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lcoaI-00A1fM-JB; Sat, 01 May 2021 12:18:59 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lcoaC-00A1e3-Ee
 for linux-nvme@desiato.infradead.org; Sat, 01 May 2021 12:18:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=j96E2BBY3NwCBoIWCcw0T9QbMnI62ZtWS/vlWUBPxs8=; b=MiUruEUNwkrUcAjNXb0heR2um8
 L1Pq7/EHn0D5z7yTIK79uWQzbMtE//i4WLOYYXU+8Ua2lbXNvJgpKxU4XvEbqW8eQkdBV25KlJ/bO
 OKMaDaTkOfG0SAd+kBaoXTbOBeavZgYn5iVu8b0yHPPkq7iB3vNlUKbvhJ+ALB6dFCFjTiKRjELcX
 7iLQ20n8XQ0dFRroQTdin6yZpZEdyzOgRm4uX7HFhuITuqHMpc8fYM4csEXdCz0WBEx0QuxxXlEFt
 jDVZcpUyEp1KX6pFtC1yraWQoj47Sx48V/PfJSM9REuyP52mU+Fn8Z0EuHtFNes9BmTG2h8d/uKMu
 D2MWrFeA==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lcoa9-001yz3-L0
 for linux-nvme@lists.infradead.org; Sat, 01 May 2021 12:18:51 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 487E9B29C;
 Sat,  1 May 2021 12:18:47 +0000 (UTC)
Subject: Re: [RFC PATCH v4 08/27] nvme-tcp-offload: Add nvme-tcp-offload -
 NVMeTCP HW offload ULP
To: Shai Malin <smalin@marvell.com>, netdev@vger.kernel.org,
 linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de, axboe@fb.com,
 kbusch@kernel.org
Cc: "David S . Miller davem @ davemloft . net --cc=Jakub Kicinski"
 <kuba@kernel.org>, aelior@marvell.com, mkalderon@marvell.com,
 okulkarni@marvell.com, pkushwaha@marvell.com, malin1024@gmail.com,
 Dean Balandin <dbalandin@marvell.com>
References: <20210429190926.5086-1-smalin@marvell.com>
 <20210429190926.5086-9-smalin@marvell.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <7831d4ff-9e47-3c43-8725-95eb0bdd7107@suse.de>
Date: Sat, 1 May 2021 14:18:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210429190926.5086-9-smalin@marvell.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210501_051849_859123_3D74C2CA 
X-CRM114-Status: GOOD (  20.15  )
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

T24gNC8yOS8yMSA5OjA5IFBNLCBTaGFpIE1hbGluIHdyb3RlOgo+IFRoaXMgcGF0Y2ggd2lsbCBw
cmVzZW50IHRoZSBzdHJ1Y3R1cmUgZm9yIHRoZSBOVk1lVENQIG9mZmxvYWQgY29tbW9uCj4gbGF5
ZXIgZHJpdmVyLiBUaGlzIG1vZHVsZSBpcyBhZGRlZCB1bmRlciAiZHJpdmVycy9udm1lL2hvc3Qv
IiBhbmQgZnV0dXJlCj4gb2ZmbG9hZCBkcml2ZXJzIHdoaWNoIHdpbGwgcmVnaXN0ZXIgdG8gaXQg
d2lsbCBiZSBwbGFjZWQgdW5kZXIKPiAiZHJpdmVycy9udm1lL2h3Ii4KPiBUaGlzIG5ldyBkcml2
ZXIgd2lsbCBiZSBlbmFibGVkIGJ5IHRoZSBLY29uZmlnICJOVk0gRXhwcmVzcyBvdmVyIEZhYnJp
Y3MKPiBUQ1Agb2ZmbG9hZCBjb21tbW9uIGxheWVyIi4KPiBJbiBvcmRlciB0byBzdXBwb3J0IHRo
ZSBuZXcgdHJhbnNwb3J0IHR5cGUsIGZvciBob3N0IG1vZGUsIG5vIGNoYW5nZSBpcwo+IG5lZWRl
ZC4KPiAKPiBFYWNoIG5ldyB2ZW5kb3Itc3BlY2lmaWMgb2ZmbG9hZCBkcml2ZXIgd2lsbCByZWdp
c3RlciB0byB0aGlzIFVMUCBkdXJpbmcKPiBpdHMgcHJvYmUgZnVuY3Rpb24sIGJ5IGZpbGxpbmcg
b3V0IHRoZSBudm1lX3RjcF9vZmxkX2Rldi0+b3BzIGFuZAo+IG52bWVfdGNwX29mbGRfZGV2LT5w
cml2YXRlX2RhdGEgYW5kIGNhbGxpbmcgbnZtZV90Y3Bfb2ZsZF9yZWdpc3Rlcl9kZXYKPiB3aXRo
IHRoZSBpbml0aWFsaXplZCBzdHJ1Y3QuCj4gCj4gVGhlIGludGVybmFsIGltcGxlbWVudGF0aW9u
Ogo+IC0gdGNwLW9mZmxvYWQuaDoKPiAgICBJbmNsdWRlcyBhbGwgY29tbW9uIHN0cnVjdHMgYW5k
IG9wcyB0byBiZSB1c2VkIGFuZCBzaGFyZWQgYnkgb2ZmbG9hZAo+ICAgIGRyaXZlcnMuCj4gCj4g
LSB0Y3Atb2ZmbG9hZC5jOgo+ICAgIEluY2x1ZGVzIHRoZSBpbml0IGZ1bmN0aW9uIHdoaWNoIHJl
Z2lzdGVycyBhcyBhIE5WTWYgdHJhbnNwb3J0IGp1c3QKPiAgICBsaWtlIGFueSBvdGhlciB0cmFu
c3BvcnQuCj4gCj4gQWNrZWQtYnk6IElnb3IgUnVzc2tpa2ggPGlydXNza2lraEBtYXJ2ZWxsLmNv
bT4KPiBTaWduZWQtb2ZmLWJ5OiBEZWFuIEJhbGFuZGluIDxkYmFsYW5kaW5AbWFydmVsbC5jb20+
Cj4gU2lnbmVkLW9mZi1ieTogUHJhYmhha2FyIEt1c2h3YWhhIDxwa3VzaHdhaGFAbWFydmVsbC5j
b20+Cj4gU2lnbmVkLW9mZi1ieTogT21rYXIgS3Vsa2FybmkgPG9rdWxrYXJuaUBtYXJ2ZWxsLmNv
bT4KPiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWwgS2FsZGVyb24gPG1rYWxkZXJvbkBtYXJ2ZWxsLmNv
bT4KPiBTaWduZWQtb2ZmLWJ5OiBBcmllbCBFbGlvciA8YWVsaW9yQG1hcnZlbGwuY29tPgo+IFNp
Z25lZC1vZmYtYnk6IFNoYWkgTWFsaW4gPHNtYWxpbkBtYXJ2ZWxsLmNvbT4KPiAtLS0KPiAgIGRy
aXZlcnMvbnZtZS9ob3N0L0tjb25maWcgICAgICAgfCAgMTYgKysrCj4gICBkcml2ZXJzL252bWUv
aG9zdC9NYWtlZmlsZSAgICAgIHwgICAzICsKPiAgIGRyaXZlcnMvbnZtZS9ob3N0L3RjcC1vZmZs
b2FkLmMgfCAxMjYgKysrKysrKysrKysrKysrKysrKwo+ICAgZHJpdmVycy9udm1lL2hvc3QvdGNw
LW9mZmxvYWQuaCB8IDIwNiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+ICAgNCBm
aWxlcyBjaGFuZ2VkLCAzNTEgaW5zZXJ0aW9ucygrKQo+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRy
aXZlcnMvbnZtZS9ob3N0L3RjcC1vZmZsb2FkLmMKPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2
ZXJzL252bWUvaG9zdC90Y3Atb2ZmbG9hZC5oCj4gCkl0IHdpbGwgYmUgdHJpY2t5IHRvIHNlbGVj
dCB0aGUgY29ycmVjdCB0cmFuc3BvcnQgZWcgd2hlbiB0cmF2ZXJzaW5nIHRoZSAKZGlzY292ZXJ5
IGxvZyBwYWdlOyB0aGUgZGlzY292ZXJ5IGxvZyBwYWdlIG9ubHkga25vd3MgYWJvdXQgJ3RjcCcg
KG5vdCAKJ3RjcF9vZmZsb2FkJyksIHNvIHRoZSBvZmZsb2FkIHdvbid0IGJlIHBpY2tlZCB1cC4K
QnV0IHRoYXQgY2FuIHdlIHdvcmtlZCBvbiAvIGZpeGVkIGxhdGVyIG9uLCBhcyBpdCdzIGFyZ3Vh
Ymx5IGEgcG9saWN5IApkZWNpc2lvbi4KClJldmlld2VkLWJ5OiBIYW5uZXMgUmVpbmVja2UgPGhh
cmVAc3VzZS5kZT4KCkNoZWVycywKCkhhbm5lcwotLSAKRHIuIEhhbm5lcyBSZWluZWNrZSAgICAg
ICAgICAgICAgICBLZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QKaGFyZUBzdXNlLmRlICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VTRSBTb2Z0d2FyZSBTb2x1
dGlvbnMgR21iSCwgTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnCkhSQiAzNjgwOSAoQUcg
TsO8cm5iZXJnKSwgR2VzY2jDpGZ0c2bDvGhyZXI6IEZlbGl4IEltZW5kw7ZyZmZlcgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWls
aW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
