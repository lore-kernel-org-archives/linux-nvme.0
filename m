Return-Path: <SRS0=3Lap=G6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922EDC433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Jan 2021 10:05:11 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15F7D2072C
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Jan 2021 10:05:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15F7D2072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Yv23dmF3W/Jfp7Ji4Fnzp6sqR+84Ya9UttdO+FCt1bM=; b=uilGNySJnwHLq6srezkoICuug
	RCw4mmRLmOGvHXDqwYNAKzD8Cbp4viwcxh1doo2VitQxw3fot3C8Y/Ch2xRI0LRFa5CXYjYchGuVj
	XTm8QfNGrZMhhFFBlYPu9txwippTugoN56O3jQIQ268Zj5pN/iJnc9/ykdUNgPqf0AGsgWOMQixNt
	gsI3IHcEjsUDriGCrQaJi90fGPXgGv77RYu3tDLduwPKSngIvZ14TeHkPJJJBE+WFzb9zEt7JfKwC
	gpTCdGqYjYpLKnf3KJWL/twl9v8J2ILkRW7vqiC/qP4ZkVJBCfo/kySXyThcPyTvseHNVVk7MJKIv
	nHckJuCFQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4hgl-0005UX-NS; Wed, 27 Jan 2021 10:04:39 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4hgk-0005UC-4f
 for linux-nvme@lists.infradead.org; Wed, 27 Jan 2021 10:04:39 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id C03A4AD57;
 Wed, 27 Jan 2021 10:04:36 +0000 (UTC)
Subject: Re: [PATCH 2/2] nvme: return -ETIMEDOUT in nvme_submit_sync_cmd()
To: Daniel Wagner <dwagner@suse.de>
References: <20210127080605.146627-1-hare@suse.de>
 <20210127080605.146627-3-hare@suse.de>
 <20210127092225.5b5n3bhp4edmhzic@beryllium.lan>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <12b62ac4-f122-bc95-2615-b5f70ce54884@suse.de>
Date: Wed, 27 Jan 2021 11:04:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210127092225.5b5n3bhp4edmhzic@beryllium.lan>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210127_050438_306073_2DFAD620 
X-CRM114-Status: GOOD (  20.88  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <keith.busch@wdc.com>, Sagi Grimberg <sagi@grimberg.me>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMS8yNy8yMSAxMDoyMiBBTSwgRGFuaWVsIFdhZ25lciB3cm90ZToKPiBPbiBXZWQsIEphbiAy
NywgMjAyMSBhdCAwOTowNjowNUFNICswMTAwLCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6Cj4+IFdo
ZW4gYSBjb21tYW5kIHRpbWVzIG91dCB3ZSBzaG91bGQgYmUgcmV0dXJuaW5nIC1FVElNRURPVVQg
aW4KPj4gbnZtZV9zdWJtaXRfc3luY19jbWQoKSwgYW5kIG5vdCByZXF1aXJpbmcgdGhlIGNhbGxl
ciB0byBndWVzcyB3aGV0aGVyCj4+IGEgc3BlY2lmaWMgTlZNZSBzdGF0dXMgc2hvdWxkIGJlIGlu
dGVycHJldGVkIGFzIGEgdGltZW91dC4KPj4KPj4gU2lnbmVkLW9mZi1ieTogSGFubmVzIFJlaW5l
Y2tlIDxoYXJlQHN1c2UuZGU+Cj4+IC0tLQo+PiAgIGRyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYyB8
IDIgKysKPj4gICBkcml2ZXJzL252bWUvaG9zdC9udm1lLmggfCAxICsKPj4gICBkcml2ZXJzL252
bWUvaG9zdC9yZG1hLmMgfCAxICsKPj4gICBkcml2ZXJzL252bWUvaG9zdC90Y3AuYyAgfCAxICsK
PiAKPiBJIHdvbmRlciBpZiB3ZSBoYXZlIHRvIGRvIHNvbWV0aGluZyBzaW1pbGFyIGZvciBGQy4g
QXMgZmFyIEkgdW5kZXJzdGFuZAo+IGFuIGFib3J0IGNvbW1hbmQgaXMgaXNzdWVkIGFuZCB0aGUg
ZHJpdmVycyB3aWxsIHJldHVybiB0aGUgb3JpZ2luYWwKPiByZXF1ZXN0IHdpdGggRkNQT1BfU1RB
VEVfQUJPUlRFRCB3aGljaCB0aGVuIHdpbGwgYmUgbWFwcGVkIHRvCj4gTlZNRV9TQ19IT1NUX1BB
VEhfRVJST1IuCj4gCj4gQ2FuJ3Qgc2F5IGlmIHRoaXMgaXMgZ29vZCBvciBiYWQsIGl0J3MgYSBq
dXN0IGRpZmZlcmVudC4KPiAKR29vZCBwb2ludCwgYW5kIGluZGVlZCB5b3UgYXJlIGNvcnJlY3Qu
CldpbGwgYmUgc2VuZGluZyBhIHYyIHZlcnNpb24uCgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBI
YW5uZXMgUmVpbmVja2UgICAgICAgICAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0Cmhh
cmVAc3VzZS5kZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4
ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJu
YmVyZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdlc2Now6RmdHNmw7xocmVyOiBGZWxpeCBJ
bWVuZMO2cmZmZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9y
ZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
