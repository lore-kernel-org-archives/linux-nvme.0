Return-Path: <SRS0=lokR=FM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A1FC433FE
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Dec 2020 16:49:28 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32DB123A79
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Dec 2020 16:49:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32DB123A79
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=fRgwv5BjsGXD/P4/4PqhbzOWvTAdhtmZC+EM8+TB6Hs=; b=fgxAkAGzUHhT7fe7q8e+uv3a7
	9O0cX+k16lJ/tnJmByhsCo6Ewcs/hLwMQbAziRPXRkiiBk3+Ym3RTMOKgf1lXNik3ZXWvS8OoIZh8
	vzTYpgm1d5nWtTB4dEBic9MNm1VG5b8CbdLWdccgt3gD3VB+vWWCJhWvojCJPIibF6ab5DZyO5Xl9
	bumdr108Q20VWqEGgk55wGxs+0/9AAQpRx1H7NQgzoJ9gYh3Hvr0FryEQCRO2oMqF80dVKSNia87D
	aiDoWJvSpY6lcMQBe6zN8kUiPxA01fhBNIbSw79SzRmsdTiD4m2ct7lu1JYm+uDkq5gVTF7FvFbRT
	1zKUrE3KQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmgB3-00072P-2X; Tue, 08 Dec 2020 16:49:25 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmgB0-00070R-0X
 for linux-nvme@lists.infradead.org; Tue, 08 Dec 2020 16:49:22 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id C82D5AD1E;
 Tue,  8 Dec 2020 16:49:20 +0000 (UTC)
Subject: Re: [PATCH 6/6] nvme: allow revalidate to set a namespace read-only
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
References: <20201208162829.2424563-1-hch@lst.de>
 <20201208162829.2424563-7-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <59794c03-e907-f265-2358-b2271b46ec2b@suse.de>
Date: Tue, 8 Dec 2020 17:49:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201208162829.2424563-7-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201208_114922_178933_64D47D5C 
X-CRM114-Status: GOOD (  21.48  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Mike Snitzer <snitzer@redhat.com>,
 Oleksii Kurochko <olkuroch@cisco.com>,
 Dongsheng Yang <dongsheng.yang@easystack.cn>, linux-block@vger.kernel.org,
 dm-devel@redhat.com, linux-nvme@lists.infradead.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Keith Busch <kbusch@kernel.org>, Ilya Dryomov <idryomov@gmail.com>,
 ceph-devel@vger.kernel.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTIvOC8yMCA1OjI4IFBNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPiBVbmNvbmRpdGlv
bmFsbHkgY2FsbCBzZXRfZGlza19ybyBub3cgdGhhdCBpdCBvbmx5IHVwZGF0ZXMgdGhlIGhhcmR3
YXJlCj4gc3RhdGUuICBUaGlzIGFsbG93cyB0byBwcm9wZXJseSBzZXQgdXAgdGhlIExpbnV4IGRl
dmljZXMgcmVhZC1vbmx5IHdoZW4KPiB0aGUgY29udHJvbGxlciB0dXJucyBhIHByZXZpb3VzbHkg
d3JpdGFibGUgbmFtZXNwYWNlIHJlYWQtb25seS4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3Rv
cGggSGVsbHdpZyA8aGNoQGxzdC5kZT4KPiBSZXZpZXdlZC1ieTogS2VpdGggQnVzY2ggPGtidXNj
aEBrZXJuZWwub3JnPgo+IFJldmlld2VkLWJ5OiBNYXJ0aW4gSy4gUGV0ZXJzZW4gPG1hcnRpbi5w
ZXRlcnNlbkBvcmFjbGUuY29tPgo+IC0tLQo+ICAgZHJpdmVycy9udm1lL2hvc3QvY29yZS5jIHwg
NSArKy0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMo
LSkKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jIGIvZHJpdmVycy9u
dm1lL2hvc3QvY29yZS5jCj4gaW5kZXggY2UxYjYxNTE5NDQxMzEuLjNhMDU1N2NjYzlmYzVkIDEw
MDY0NAo+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYwo+ICsrKyBiL2RyaXZlcnMvbnZt
ZS9ob3N0L2NvcmUuYwo+IEBAIC0yMTE0LDkgKzIxMTQsOCBAQCBzdGF0aWMgdm9pZCBudm1lX3Vw
ZGF0ZV9kaXNrX2luZm8oc3RydWN0IGdlbmRpc2sgKmRpc2ssCj4gICAJbnZtZV9jb25maWdfZGlz
Y2FyZChkaXNrLCBucyk7Cj4gICAJbnZtZV9jb25maWdfd3JpdGVfemVyb2VzKGRpc2ssIG5zKTsK
PiAgIAo+IC0JaWYgKChpZC0+bnNhdHRyICYgTlZNRV9OU19BVFRSX1JPKSB8fAo+IC0JICAgIHRl
c3RfYml0KE5WTUVfTlNfRk9SQ0VfUk8sICZucy0+ZmxhZ3MpKQo+IC0JCXNldF9kaXNrX3JvKGRp
c2ssIHRydWUpOwo+ICsJc2V0X2Rpc2tfcm8oZGlzaywgKGlkLT5uc2F0dHIgJiBOVk1FX05TX0FU
VFJfUk8pIHx8Cj4gKwkJdGVzdF9iaXQoTlZNRV9OU19GT1JDRV9STywgJm5zLT5mbGFncykpOwo+
ICAgfQo+ICAgCj4gICBzdGF0aWMgaW5saW5lIGJvb2wgbnZtZV9maXJzdF9zY2FuKHN0cnVjdCBn
ZW5kaXNrICpkaXNrKQo+IApSZXZpZXdlZC1ieTogSGFubmVzIFJlaW5lY2tlIDxoYXJlQHN1c2Uu
ZGU+CgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2UgICAgICAgICAgICAg
ICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5kZSAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdt
YkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVy
ZyksIEdlc2Now6RmdHNmw7xocmVyOiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0
CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
