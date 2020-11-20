Return-Path: <SRS0=Qryz=E2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50726C5519F
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2020 07:50:39 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBE2F222BA
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2020 07:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FHuwgYrD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBE2F222BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=TqbZ3jDhFv9P2t5J25wJFnE//VX6gHGRAstm5d4D0aQ=; b=FHuwgYrD5HQv37I9ZrzalTboU
	5x6KMLv+VVfVb0WYLcnmCjJz9vXZKao7EGQdYDefBOyLfnQm23hv6jzBSGgvNaBzg85rlpLSiiuR3
	IqoNxsXt5Y9m5ytR4u4iGUh8hwIWvckENH7v587Ph/BEvqZmSD/9F7D7q47E8x63Wc2j07Mrb9vFj
	2D5Bo0ZrBL1YeGqpYsLwTh2x87WjKRyvjejT4T+Zfv3jcjCs0cb6r7Y5q++z1Ku37BiJOZkQW60pt
	bW70Gcaqo4g+s5hJ7Y4aH3XCPJaqZxsZWY7CcSeTYZmmaFRUMDpY1fcJ8j40IEwZIGsZ4tm6xJEF1
	64tmVwmWA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kg1Bj-0000vk-8K; Fri, 20 Nov 2020 07:50:35 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kg1Bg-0000vF-CS
 for linux-nvme@lists.infradead.org; Fri, 20 Nov 2020 07:50:33 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 55C9CAC23;
 Fri, 20 Nov 2020 07:50:31 +0000 (UTC)
Subject: Re: [PATCH 66/78] block: keep a block_device reference for each
 hd_struct
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
References: <20201116145809.410558-1-hch@lst.de>
 <20201116145809.410558-67-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <23914ef5-5245-b468-4168-bc1584e979d2@suse.de>
Date: Fri, 20 Nov 2020 08:50:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201116145809.410558-67-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201120_025032_551264_5C309147 
X-CRM114-Status: GOOD (  25.61  )
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

T24gMTEvMTYvMjAgMzo1NyBQTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4gVG8gc2ltcGxp
ZnkgYmxvY2sgZGV2aWNlIGxvb2t1cCBhbmQgYSBmZXcgb3RoZXIgdXBjb21kaW4gYXJlYXMsIG1h
a2Ugc3VyZQo+IHRoYXQgd2UgYWx3YXlzIGhhdmUgYSBzdHJ1Y3QgYmxvY2tfZGV2aWNlIGF2YWls
YWJsZSBmb3IgZWFjaCBkaXNrIGFuZAo+IGVhY2ggcGFydGl0aW9uLiAgVGhlIG9ubHkgZG93bnNp
ZGUgb2YgdGhpcyBpcyB0aGF0IGVhY2ggZGV2aWNlIGFuZAo+IHBhcnRpdGlvbiB1c2VzIGEgbGl0
dGxlIG1vcmUgbWVtb3JpZXMuICBUaGUgdXBzaWRlIHdpbGwgYmUgdGhhdCBhIGxvdCBvZgo+IGNv
ZGUgY2FuIGJlIHNpbXBsaWZpZWQuCj4gCj4gV2l0aCB0aGF0IGFsbCB3ZSBuZWVkIHRvIGxvb2sg
dXAgdGhlIGJsb2NrIGRldmljZSBpcyB0byBsb29rdXAgdGhlIGlub2RlCj4gYW5kIGRvIGEgZmV3
IHNhbml0eSBjaGVja3Mgb24gdGhlIGdlbmRpc2ssIGluc3RlYWQgb2YgdGhlIHNlcGFyYXRlIGxv
b2t1cAo+IGZvciB0aGUgZ2VuZGlzay4KPiAKPiBBcyBwYXJ0IG9mIHRoZSBjaGFuZ2Ugc3dpdGNo
IGJkZ2V0KCkgdG8gb25seSBmaW5kIGV4aXN0aW5nIGJsb2NrIGRldmljZXMsCj4gZ2l2ZW4gdGhh
dCB3ZSBrbm93IHRoYXQgdGhlIGJsb2NrX2RldmljZSBzdHJ1Y3R1cmUgbXVzdCBiZSBhbGxvY2F0
ZWQgYXQKPiBwcm9iZSAvIHBhcnRpdGlvbiBzY2FuIHRpbWUuCj4gCj4gYmxrLWNncm91cCBuZWVk
ZWQgYSBiaXQgb2YgYSBzcGVjaWFsIHRyZWF0bWVudCBhcyB0aGUgb25seSBwbGFjZSB0aGF0Cj4g
d2FudGVkIHRvIGxvb2t1cCBhIGdlbmRpc2sgb3V0c2lkZSBvZiB0aGUgbm9ybWFsIGJsa2Rldl9n
ZXQgcGF0aC4gIEl0IGlzCj4gc3dpdGNoZWQgdG8gbG9va3VwIHVzaW5nIHRoZSBibG9jayBkZXZp
Y2UgaGFzaCBub3cgdGhhdCB0aGlzIGlzIHRoZQo+IHByaW1hcnkgbG9va3VwIHBhdGguCj4gCj4g
U2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+Cj4gLS0tCj4gICBi
bG9jay9ibGstY2dyb3VwLmMgICAgICAgICB8ICA0MiArKysrLS0tLS0KPiAgIGJsb2NrL2Jsay1p
b2Nvc3QuYyAgICAgICAgIHwgIDM2ICsrKy0tLS0KPiAgIGJsb2NrL2Jsay5oICAgICAgICAgICAg
ICAgIHwgICAxIC0KPiAgIGJsb2NrL2dlbmhkLmMgICAgICAgICAgICAgIHwgMTg4ICsrKy0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiAgIGJsb2NrL3BhcnRpdGlvbnMvY29yZS5j
ICAgIHwgIDI4ICsrKy0tLQo+ICAgZnMvYmxvY2tfZGV2LmMgICAgICAgICAgICAgfCAxMzMgKysr
KysrKysrKysrKysrLS0tLS0tLS0tLS0KPiAgIGluY2x1ZGUvbGludXgvYmxrLWNncm91cC5oIHwg
ICA0ICstCj4gICBpbmNsdWRlL2xpbnV4L2Jsa2Rldi5oICAgICB8ICAgMyArCj4gICBpbmNsdWRl
L2xpbnV4L2dlbmhkLmggICAgICB8ICAgNCArLQo+ICAgOSBmaWxlcyBjaGFuZ2VkLCAxNTMgaW5z
ZXJ0aW9ucygrKSwgMjg2IGRlbGV0aW9ucygtKQo+IApSZXZpZXdlZC1ieTogSGFubmVzIFJlaW5l
Y2tlIDxoYXJlQHN1c2UuZGU+CgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVj
a2UgICAgICAgICAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5kZSAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdh
cmUgU29sdXRpb25zIEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4
MDkgKEFHIE7DvHJuYmVyZyksIEdlc2Now6RmdHNmw7xocmVyOiBGZWxpeCBJbWVuZMO2cmZmZXIK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52
bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
