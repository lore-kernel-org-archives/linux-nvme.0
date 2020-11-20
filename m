Return-Path: <SRS0=Qryz=E2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60EFFC5519F
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2020 07:22:33 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C082C2158C
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2020 07:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="U9dZr0CB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C082C2158C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=mvYlNhinXMf4cz5jxdBzrxQpIE+vBkezQzxjUhwt8G4=; b=U9dZr0CBLQG53FobpJpLsmrM1
	iv3LB0jr71IQgPtDCyEQ2nigSgHcijgpBSiXae3erMA1Am+GFCfKZkYtAwcmi5ZEjrtK+bOZs3naz
	d2mBPdUqfST1U9ntWF3WqnzSiiGUw4wUuEwIxjcADwFwHwpPceo6Z3iN7PJ8timw/mjFn87WPqXbT
	aPlfi2vuyU7rQ7CMo2wMd614Kb9BdLWEYqrbX88XyqMCrN44uTUfxUsJFst2sb/j4ZtJaij2rGfNR
	mWPzzXfA3EyJ+j/hqf96yn6wNBN29bdalJP6sv5tNixh54U6+mYSszFJiVHtpbyXIj2MRXkDUPmvR
	AR424hhAw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kg0kW-0002Xf-H5; Fri, 20 Nov 2020 07:22:28 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kg0kT-0002Fe-Pk
 for linux-nvme@lists.infradead.org; Fri, 20 Nov 2020 07:22:26 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 7376AAC23;
 Fri, 20 Nov 2020 07:20:23 +0000 (UTC)
Subject: Re: [PATCH 31/78] loop: use set_disk_ro
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
References: <20201116145809.410558-1-hch@lst.de>
 <20201116145809.410558-32-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <62c828df-02be-1848-0a95-9b937f9998da@suse.de>
Date: Fri, 20 Nov 2020 08:20:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201116145809.410558-32-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201120_022225_957566_04D5A6C5 
X-CRM114-Status: GOOD (  22.10  )
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

T24gMTEvMTYvMjAgMzo1NyBQTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4gVXNlIHNldF9k
aXNrX3JvIGluc3RlYWQgb2Ygc2V0X2RldmljZV9ybyB0byBtYXRjaCBhbGwgb3RoZXIgYmxvY2sK
PiBkcml2ZXJzIGFuZCB0byBlbnN1cmUgYWxsIHBhcnRpdGlvbnMgbWlycm9yIHRoZSByZWFkLW9u
bHkgZmxhZy4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5k
ZT4KPiAtLS0KPiAgIGRyaXZlcnMvYmxvY2svbG9vcC5jIHwgMiArLQo+ICAgMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvYmxvY2svbG9vcC5jIGIvZHJpdmVycy9ibG9jay9sb29wLmMKPiBpbmRleCA4NGEzNmMyNDJl
NTU1MC4uNDFjYWY3OTlkZjcyMWYgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ibG9jay9sb29wLmMK
PiArKysgYi9kcml2ZXJzL2Jsb2NrL2xvb3AuYwo+IEBAIC0xMTM0LDcgKzExMzQsNyBAQCBzdGF0
aWMgaW50IGxvb3BfY29uZmlndXJlKHN0cnVjdCBsb29wX2RldmljZSAqbG8sIGZtb2RlX3QgbW9k
ZSwKPiAgIAlpZiAoZXJyb3IpCj4gICAJCWdvdG8gb3V0X3VubG9jazsKPiAgIAo+IC0Jc2V0X2Rl
dmljZV9ybyhiZGV2LCAobG8tPmxvX2ZsYWdzICYgTE9fRkxBR1NfUkVBRF9PTkxZKSAhPSAwKTsK
PiArCXNldF9kaXNrX3JvKGxvLT5sb19kaXNrLCAobG8tPmxvX2ZsYWdzICYgTE9fRkxBR1NfUkVB
RF9PTkxZKSAhPSAwKTsKPiAgIAo+ICAgCWxvLT51c2VfZGlvID0gbG8tPmxvX2ZsYWdzICYgTE9f
RkxBR1NfRElSRUNUX0lPOwo+ICAgCWxvLT5sb19kZXZpY2UgPSBiZGV2Owo+IApSZXZpZXdlZC1i
eTogSGFubmVzIFJlaW5lY2tlIDxoYXJlQHN1c2UuZGU+CgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRy
LiBIYW5uZXMgUmVpbmVja2UgICAgICAgICAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0
CmhhcmVAc3VzZS5kZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMg
Njg4ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7D
vHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdlc2Now6RmdHNmw7xocmVyOiBGZWxp
eCBJbWVuZMO2cmZmZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52
bWUK
