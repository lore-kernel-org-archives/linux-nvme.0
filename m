Return-Path: <SRS0=Qryz=E2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D08C5519F
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2020 07:55:38 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DDC1222BA
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2020 07:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pUetmaZa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DDC1222BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=KYyO6ssYNZyHwM3QWaHWEbAYgmMeKVE4evsDstRrpbI=; b=pUetmaZamB6rSkp2YRsZu+D2F
	5UW/LzfmaS1kdu5VVfTNFrp6kPC1IMf3qqy8bsh0dbAqNP4qXrgpya1pJ3IQFpUPDMEcSeq0HHxRR
	lBBgbH9Vx08maTxy8vJlkkdC8ViRMw9hiFFvEARdmE6p45rpH0veOfqPy1D1ZYyTp0dVwOYuoOmP/
	jqZkMCk/W2q5IgyIqRWpzf430bSwMkCf+S6NcICWlpG45XXwJA+A2cDwhrdvzl93cxMtRkOjfKzes
	KeBzR/cl2oLntZRfJ6479Kev5N5mJPW0XqF8DmXBsDTIDirTaz8qAXQ3Q2mc/opFFPiWkAQZlGrsQ
	+ShZWP8KQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kg1GX-0001nW-GT; Fri, 20 Nov 2020 07:55:33 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kg1GU-0001lp-Sn
 for linux-nvme@lists.infradead.org; Fri, 20 Nov 2020 07:55:32 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 9D32FAC23;
 Fri, 20 Nov 2020 07:55:29 +0000 (UTC)
Subject: Re: [PATCH 69/78] block: remove the nr_sects field in struct hd_struct
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
References: <20201116145809.410558-1-hch@lst.de>
 <20201116145809.410558-70-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <f776dc43-0917-5d09-52a6-0d5e57914dd5@suse.de>
Date: Fri, 20 Nov 2020 08:55:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201116145809.410558-70-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201120_025531_099569_27D62A8B 
X-CRM114-Status: GOOD (  19.84  )
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

T24gMTEvMTYvMjAgMzo1OCBQTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4gTm93IHRoYXQg
dGhlIGhkX3N0cnVjdCBhbHdheXMgaGFzIGEgYmxvY2sgZGV2aWNlIGF0dGFjaGVkIHRvIGl0LCB0
aGVyZSBpcwo+IG5vIG5lZWQgZm9yIGhhdmluZyB0d28gc2l6ZSBmaWVsZCB0aGF0IGp1c3QgZ2V0
IG91dCBvZiBzeW5jLgo+IAo+IEFkZGl0aW9uYWwgdGhlIGZpZWxkIGluIGhkX3N0cnVjdCBkaWQg
bm90IHVzZSBwcm9wZXIgc2VyaWFsaXppYXRpb24sCj4gcG9zc2libHkgYWxsb3dpbmcgZm9yIHRv
cm4gd3JpdGVzLiAgQnkgb25seSB1c2luZyB0aGUgYmxvY2tfZGV2aWNlIGZpZWxkCj4gdGhpcyBw
cm9ibGVtIGFsc28gZ2V0cyBmaXhlZC4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVs
bHdpZyA8aGNoQGxzdC5kZT4KPiAtLS0KPiAgIGJsb2NrL2Jpby5jICAgICAgICAgICAgICAgICAg
ICAgICAgfCAgMiArLQo+ICAgYmxvY2svYmxrLWNvcmUuYyAgICAgICAgICAgICAgICAgICB8ICAy
ICstCj4gICBibG9jay9ibGsuaCAgICAgICAgICAgICAgICAgICAgICAgIHwgNTMgLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQo+ICAgYmxvY2svZ2VuaGQuYyAgICAgICAgICAgICAgICAgICAgICB8IDM0
ICsrKysrKystLS0tLS0tCj4gICBibG9jay9wYXJ0aXRpb25zL2NvcmUuYyAgICAgICAgICAgIHwg
MTcgKysrKy0tLQo+ICAgZHJpdmVycy9ibG9jay9sb29wLmMgICAgICAgICAgICAgICB8ICAxIC0K
PiAgIGRyaXZlcnMvYmxvY2svbmJkLmMgICAgICAgICAgICAgICAgfCAgMiArLQo+ICAgZHJpdmVy
cy9ibG9jay94ZW4tYmxrYmFjay9jb21tb24uaCB8ICA0ICstCj4gICBkcml2ZXJzL21kL2JjYWNo
ZS9zdXBlci5jICAgICAgICAgIHwgIDIgKy0KPiAgIGRyaXZlcnMvczM5MC9ibG9jay9kYXNkX2lv
Y3RsLmMgICAgfCAgNCArLQo+ICAgZHJpdmVycy90YXJnZXQvdGFyZ2V0X2NvcmVfcHNjc2kuYyB8
ICA3ICstLQo+ICAgZnMvYmxvY2tfZGV2LmMgICAgICAgICAgICAgICAgICAgICB8IDczICstLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+ICAgZnMvZjJmcy9zdXBlci5jICAgICAgICAgICAg
ICAgICAgICB8ICAyICstCj4gICBmcy9wc3RvcmUvYmxrLmMgICAgICAgICAgICAgICAgICAgIHwg
IDIgKy0KPiAgIGluY2x1ZGUvbGludXgvZ2VuaGQuaCAgICAgICAgICAgICAgfCAyOSArKystLS0t
LS0tLS0KPiAgIGtlcm5lbC90cmFjZS9ibGt0cmFjZS5jICAgICAgICAgICAgfCAgMiArLQo+ICAg
MTYgZmlsZXMgY2hhbmdlZCwgNDcgaW5zZXJ0aW9ucygrKSwgMTg5IGRlbGV0aW9ucygtKQo+IApS
ZXZpZXdlZC1ieTogSGFubmVzIFJlaW5lY2tlIDxoYXJlQHN1c2UuZGU+CgpDaGVlcnMsCgpIYW5u
ZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2UgICAgICAgICAgICAgICAgS2VybmVsIFN0b3JhZ2Ug
QXJjaGl0ZWN0CmhhcmVAc3VzZS5kZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICs0OSA5
MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdtYkgsIE1heGZlbGRzdHIuIDUs
IDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdlc2Now6RmdHNmw7xo
cmVyOiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2xpbnV4LW52bWUK
