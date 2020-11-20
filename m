Return-Path: <SRS0=Qryz=E2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C22C5519F
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2020 07:41:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10C9622256
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2020 07:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bA2OrT0J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10C9622256
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=CA+vdaBM2IGh7OkubvlGcDeUAHVWhCV3OWtfG3XcPHI=; b=bA2OrT0JoW4gI3+LZZmaX2ccM
	CYtzoCl04tzkrJWydRji6uZWTqJwPldxe7v0P9xLnYgUCJwCC9iCZFrcBClL2xzRNzvfLnTbwEO5n
	pqzMIxeri9TANsf1A9Tww9n1fF+M5/dos6IUldE62PX6bU2x8teqS8hVoyZWRYjlOs/szP3VTAGOp
	VK2DFb4Cgt2cb6UqPdiyYjRvMyqo4l8S12iPyXbZQaOHv4kScAjWoKdsSmAikWfKzRCTKPR4CqAqF
	eeUQJMUUQ9P8oBEY5bBsQQdkTRz89TaC7k7OrVYqpS1CS5iV6hCsl4nvjZwzqdo8WQEchUuHtjqi0
	A5l384q8g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kg12o-0007VZ-AY; Fri, 20 Nov 2020 07:41:22 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kg12m-0007Us-8P
 for linux-nvme@lists.infradead.org; Fri, 20 Nov 2020 07:41:21 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 0C348AC23;
 Fri, 20 Nov 2020 07:41:19 +0000 (UTC)
Subject: Re: [PATCH 64/78] dm: simplify flush_bio initialization in
 __send_empty_flush
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
References: <20201116145809.410558-1-hch@lst.de>
 <20201116145809.410558-65-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <38ac9782-a563-b7ea-595a-124159fb755d@suse.de>
Date: Fri, 20 Nov 2020 08:41:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201116145809.410558-65-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201120_024120_450773_2413AB3A 
X-CRM114-Status: GOOD (  24.92  )
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

T24gMTEvMTYvMjAgMzo1NyBQTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4gV2UgZG9uJ3Qg
cmVhbGx5IG5lZWQgdGhlIHN0cnVjdCBibG9ja19kZXZpY2UgdG8gaW5pdGlhbGl6ZSBhIGJpby4g
IFNvCj4gc3dpdGNoIGZyb20gdXNpbmcgYmlvX3NldF9kZXYgdG8gbWFudWFsbHkgc2V0dGluZyB1
cCBiaV9kaXNrIChiaV9wYXJ0bm8KPiB3aWxsIGFsd2F5cyBiZSB6ZXJvIGFuZCBoYXMgYmVlbiBj
bGVhcmVkIGJ5IGJpb19pbml0IGFscmVhZHkpLgo+IAo+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9w
aCBIZWxsd2lnIDxoY2hAbHN0LmRlPgo+IC0tLQo+ICAgZHJpdmVycy9tZC9kbS5jIHwgMTIgKysr
LS0tLS0tLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9u
cygtKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21kL2RtLmMgYi9kcml2ZXJzL21kL2RtLmMK
PiBpbmRleCA1NDczOWYxYjU3OWJjOC4uNmQ3ZWI3MmQ0MWY5ZWEgMTAwNjQ0Cj4gLS0tIGEvZHJp
dmVycy9tZC9kbS5jCj4gKysrIGIvZHJpdmVycy9tZC9kbS5jCj4gQEAgLTE0MjIsMTggKzE0MjIs
MTIgQEAgc3RhdGljIGludCBfX3NlbmRfZW1wdHlfZmx1c2goc3RydWN0IGNsb25lX2luZm8gKmNp
KQo+ICAgCSAqLwo+ICAgCWJpb19pbml0KCZmbHVzaF9iaW8sIE5VTEwsIDApOwo+ICAgCWZsdXNo
X2Jpby5iaV9vcGYgPSBSRVFfT1BfV1JJVEUgfCBSRVFfUFJFRkxVU0ggfCBSRVFfU1lOQzsKPiAr
CWZsdXNoX2Jpby5iaV9kaXNrID0gY2ktPmlvLT5tZC0+ZGlzazsKPiArCWJpb19hc3NvY2lhdGVf
YmxrZygmZmx1c2hfYmlvKTsKPiArCj4gICAJY2ktPmJpbyA9ICZmbHVzaF9iaW87Cj4gICAJY2kt
PnNlY3Rvcl9jb3VudCA9IDA7Cj4gICAKPiAtCS8qCj4gLQkgKiBFbXB0eSBmbHVzaCB1c2VzIGEg
c3RhdGljYWxseSBpbml0aWFsaXplZCBiaW8sIGFzIHRoZSBiYXNlIGZvcgo+IC0JICogY2xvbmlu
Zy4gIEhvd2V2ZXIsIGJsa2cgYXNzb2NpYXRpb24gcmVxdWlyZXMgdGhhdCBhIGJkZXYgaXMKPiAt
CSAqIGFzc29jaWF0ZWQgd2l0aCBhIGdlbmRpc2ssIHdoaWNoIGRvZXNuJ3QgaGFwcGVuIHVudGls
IHRoZSBiZGV2IGlzCj4gLQkgKiBvcGVuZWQuICBTbywgYmxrZyBhc3NvY2lhdGlvbiBpcyBkb25l
IGF0IGlzc3VlIHRpbWUgb2YgdGhlIGZsdXNoCj4gLQkgKiByYXRoZXIgdGhhbiB3aGVuIHRoZSBk
ZXZpY2UgaXMgY3JlYXRlZCBpbiBhbGxvY19kZXYoKS4KPiAtCSAqLwo+IC0JYmlvX3NldF9kZXYo
Y2ktPmJpbywgY2ktPmlvLT5tZC0+YmRldik7Cj4gLQo+ICAgCUJVR19PTihiaW9faGFzX2RhdGEo
Y2ktPmJpbykpOwo+ICAgCXdoaWxlICgodGkgPSBkbV90YWJsZV9nZXRfdGFyZ2V0KGNpLT5tYXAs
IHRhcmdldF9ucisrKSkpCj4gICAJCV9fc2VuZF9kdXBsaWNhdGVfYmlvcyhjaSwgdGksIHRpLT5u
dW1fZmx1c2hfYmlvcywgTlVMTCk7Cj4gCkFoLCB0aG91Z2h0IGFzIG11Y2guIEkndmUgc3R1bWJs
ZWQgYWNyb3NzIHRoaXMgd2hpbGUgZGVidWdnaW5nIApibGstaW50ZXJwb3Nlci4KClJldmlld2Vk
LWJ5OiBIYW5uZXMgUmVpbmVja2UgPGhhcmVAc3VzZS5kZT4KCkNoZWVycywKCkhhbm5lcwotLSAK
RHIuIEhhbm5lcyBSZWluZWNrZSAgICAgICAgICAgICAgICBLZXJuZWwgU3RvcmFnZSBBcmNoaXRl
Y3QKaGFyZUBzdXNlLmRlICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKzQ5IDkxMSA3NDA1
MyA2ODgKU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR21iSCwgTWF4ZmVsZHN0ci4gNSwgOTA0MDkg
TsO8cm5iZXJnCkhSQiAzNjgwOSAoQUcgTsO8cm5iZXJnKSwgR2VzY2jDpGZ0c2bDvGhyZXI6IEZl
bGl4IEltZW5kw7ZyZmZlcgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRl
YWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgt
bnZtZQo=
