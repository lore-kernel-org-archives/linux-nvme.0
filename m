Return-Path: <SRS0=Qryz=E2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69ADBC5519F
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2020 08:58:54 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3B222224C
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2020 08:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="w0HJ95XG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3B222224C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=yr6dmF+RLO2rHpdytGb/D9Nh8t4xE9jL4ygt4/Uc9pI=; b=w0HJ95XGnJlbOJ2TAmZqNjI3R
	3kPdMpPY9AHoY49xpwIu4u2if0nRRmEfZkxDqhOmLDEB9DqDYzzEh+apKs0InYp4xaFf/R2KAr4Qv
	Eru2Qs7CzA6hQSYKn5i2W5V95llvZpO66AwYKiY4LKfR8A0iHhq8sVOEH1onkxnPQT+SEkMKY06F4
	v/clncLFNwUZLcklSgCRRQ95988NhWw2iXSXz7M9vvTbgD1sEh6XBzgGfFLKCNrKztXxbA06uIiO/
	A4+7J0+f5nP4xoJoq1z7/TOqxnZtLVjPhd8UZsryroDrDuUqKXJo43B8a1Uw10+xUsZnmAwAkDLJC
	nUeVZbygA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kg2Fj-0003Jr-Cs; Fri, 20 Nov 2020 08:58:47 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kg2Ff-0003Iw-Lb
 for linux-nvme@lists.infradead.org; Fri, 20 Nov 2020 08:58:44 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 5CAD1AC23;
 Fri, 20 Nov 2020 08:58:42 +0000 (UTC)
Subject: Re: [PATCH 74/78] block: merge struct block_device and struct
 hd_struct
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
References: <20201116145809.410558-1-hch@lst.de>
 <20201116145809.410558-75-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <f6e6b948-44c8-50f0-beea-921eb3a268dd@suse.de>
Date: Fri, 20 Nov 2020 09:58:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201116145809.410558-75-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201120_035843_982647_75D2F3EE 
X-CRM114-Status: GOOD (  22.49  )
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
Cc: Justin Sanders <justin@coraid.com>, Mike Snitzer <snitzer@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 linux-nvme@lists.infradead.org, Song Liu <song@kernel.org>,
 dm-devel@redhat.com, drbd-dev@lists.linbit.com, linux-scsi@vger.kernel.org,
 xen-devel@lists.xenproject.org, Ilya Dryomov <idryomov@gmail.com>,
 Jack Wang <jinpu.wang@cloud.ionos.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Josef Bacik <josef@toxicpanda.com>, nbd@other.debian.org,
 linux-raid@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 ceph-devel@vger.kernel.org, linux-block@vger.kernel.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Minchan Kim <minchan@kernel.org>, linux-fsdevel@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTEvMTYvMjAgMzo1OCBQTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4gSW5zdGVhZCBv
ZiBoYXZpbmcgdHdvIHN0cnVjdHVyZXMgdGhhdCByZXByZXNlbnQgZWFjaCBibG9jayBkZXZpY2Ug
d2l0aAo+IGRpZmZlcmVudCBsaWZ0IHRpbWUgcnVsZXMgbWVyZ2VkIHRoZW0gaW50byBhIHNpbmds
ZSBvbmUuICBUaGlzIGFsc28KPiBncmVhdGx5IHNpbXBsaWZpZXMgdGhlIHJlZmVyZW5jZSBjb3Vu
dGluZyBydWxlcywgYXMgd2UgY2FuIHVzZSB0aGUgaW5vZGUKPiByZWZlcmVuY2UgY291bnQgYXMg
dGhlIG1haW4gcmVmZXJlbmNlIGNvdW50IGZvciB0aGUgbmV3IHN0cnVjdAo+IGJsb2NrX2Rldmlj
ZSwgd2l0aCB0aGUgZGV2aWNlIG1vZGVsIHJlZmVyZW5jZSBmcm9udCBlbmRpbmcgaXQgZm9yIGRl
dmljZQo+IG1vZGVsIGludGVyYWN0aW9uLiAgVGhlIHBlcmNwdSByZWZjb3VudCBpbiBzdHJ1Y3Qg
aGRfc3RydWN0IGlzIGVudGlyZWx5Cj4gZ29uZSBnaXZlbiB0aGF0IHN0cnVjdCBibG9ja19kZXZp
Y2UgbXVzdCBiZSBvcGVuZWQgYW5kIHRodXMgdmFsaWQgZm9yCj4gdGhlIGR1cmF0aW9uIG9mIHRo
ZSBJL08uCj4gCj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+
Cj4gLS0tCj4gICBibG9jay9iaW8uYyAgICAgICAgICAgICAgICAgICAgICAgIHwgICA2ICstCj4g
ICBibG9jay9ibGstY2dyb3VwLmMgICAgICAgICAgICAgICAgIHwgICA5ICstCj4gICBibG9jay9i
bGstY29yZS5jICAgICAgICAgICAgICAgICAgIHwgIDg1ICsrKysrLS0tLS0KPiAgIGJsb2NrL2Js
ay1mbHVzaC5jICAgICAgICAgICAgICAgICAgfCAgIDIgKy0KPiAgIGJsb2NrL2Jsay1saWIuYyAg
ICAgICAgICAgICAgICAgICAgfCAgIDIgKy0KPiAgIGJsb2NrL2Jsay1tZXJnZS5jICAgICAgICAg
ICAgICAgICAgfCAgIDYgKy0KPiAgIGJsb2NrL2Jsay1tcS5jICAgICAgICAgICAgICAgICAgICAg
fCAgMTEgKy0KPiAgIGJsb2NrL2Jsay1tcS5oICAgICAgICAgICAgICAgICAgICAgfCAgIDUgKy0K
PiAgIGJsb2NrL2Jsay5oICAgICAgICAgICAgICAgICAgICAgICAgfCAgMzggKystLS0KPiAgIGJs
b2NrL2dlbmhkLmMgICAgICAgICAgICAgICAgICAgICAgfCAyNDIgKysrKysrKysrKystLS0tLS0t
LS0tLS0tLS0tLS0KPiAgIGJsb2NrL2lvY3RsLmMgICAgICAgICAgICAgICAgICAgICAgfCAgIDQg
Ky0KPiAgIGJsb2NrL3BhcnRpdGlvbnMvY29yZS5jICAgICAgICAgICAgfCAyMjEgKysrKysrKy0t
LS0tLS0tLS0tLS0tLS0tLS0KPiAgIGRyaXZlcnMvYmxvY2svZHJiZC9kcmJkX3JlY2VpdmVyLmMg
fCAgIDIgKy0KPiAgIGRyaXZlcnMvYmxvY2svZHJiZC9kcmJkX3dvcmtlci5jICAgfCAgIDIgKy0K
PiAgIGRyaXZlcnMvYmxvY2svenJhbS96cmFtX2Rydi5jICAgICAgfCAgIDIgKy0KPiAgIGRyaXZl
cnMvbWQvYmNhY2hlL3JlcXVlc3QuYyAgICAgICAgfCAgIDQgKy0KPiAgIGRyaXZlcnMvbWQvZG0u
YyAgICAgICAgICAgICAgICAgICAgfCAgIDggKy0KPiAgIGRyaXZlcnMvbWQvbWQuYyAgICAgICAg
ICAgICAgICAgICAgfCAgIDQgKy0KPiAgIGRyaXZlcnMvbnZtZS90YXJnZXQvYWRtaW4tY21kLmMg
ICAgfCAgMjAgKy0tCj4gICBkcml2ZXJzL3MzOTAvYmxvY2svZGFzZC5jICAgICAgICAgIHwgICA4
ICstCj4gICBmcy9ibG9ja19kZXYuYyAgICAgICAgICAgICAgICAgICAgIHwgIDY4ICsrKy0tLS0t
Cj4gICBmcy9leHQ0L3N1cGVyLmMgICAgICAgICAgICAgICAgICAgIHwgIDE4ICstLQo+ICAgZnMv
ZXh0NC9zeXNmcy5jICAgICAgICAgICAgICAgICAgICB8ICAxMCArLQo+ICAgZnMvZjJmcy9jaGVj
a3BvaW50LmMgICAgICAgICAgICAgICB8ICAgNSArLQo+ICAgZnMvZjJmcy9mMmZzLmggICAgICAg
ICAgICAgICAgICAgICB8ICAgMiArLQo+ICAgZnMvZjJmcy9zdXBlci5jICAgICAgICAgICAgICAg
ICAgICB8ICAgNiArLQo+ICAgZnMvZjJmcy9zeXNmcy5jICAgICAgICAgICAgICAgICAgICB8ICAg
OSAtLQo+ICAgaW5jbHVkZS9saW51eC9ibGtfdHlwZXMuaCAgICAgICAgICB8ICAyMyArKy0KPiAg
IGluY2x1ZGUvbGludXgvYmxrZGV2LmggICAgICAgICAgICAgfCAgMTMgKy0KPiAgIGluY2x1ZGUv
bGludXgvZ2VuaGQuaCAgICAgICAgICAgICAgfCAgNjcgKystLS0tLS0KPiAgIGluY2x1ZGUvbGlu
dXgvcGFydF9zdGF0LmggICAgICAgICAgfCAgMTcgKy0KPiAgIGluaXQvZG9fbW91bnRzLmMgICAg
ICAgICAgICAgICAgICAgfCAgMjAgKy0tCj4gICBrZXJuZWwvdHJhY2UvYmxrdHJhY2UuYyAgICAg
ICAgICAgIHwgIDU0ICsrLS0tLS0KPiAgIDMzIGZpbGVzIGNoYW5nZWQsIDM1MSBpbnNlcnRpb25z
KCspLCA2NDIgZGVsZXRpb25zKC0pCj4gClJldmlld2VkLWJ5OiBIYW5uZXMgUmVpbmVja2UgPGhh
cmVAc3VzZS5kZT4KCkNoZWVycywKCkhhbm5lcwotLSAKRHIuIEhhbm5lcyBSZWluZWNrZSAgICAg
ICAgICAgICAgICBLZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QKaGFyZUBzdXNlLmRlICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VTRSBTb2Z0d2FyZSBTb2x1
dGlvbnMgR21iSCwgTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnCkhSQiAzNjgwOSAoQUcg
TsO8cm5iZXJnKSwgR2VzY2jDpGZ0c2bDvGhyZXI6IEZlbGl4IEltZW5kw7ZyZmZlcgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWls
aW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
