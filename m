Return-Path: <SRS0=Qryz=E2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECDECC56201
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2020 07:23:24 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A9B62158C
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2020 07:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SgeZBGGk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A9B62158C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=H2OUxcpd1Dz3WS6rv3Pzqpqx5BPieAtrGXuoHjJbu+c=; b=SgeZBGGkGbS63h4JhDM/tSOfO
	qnmSw3qFCaFnvWs04IDU892xnCNRQuAO4oMh30dL9/VVujCs8VBldK3fAlrmODW+cl+OvSzWIQHaV
	g+eghtFvMSuQDpW2LTrVYBWrrNDaqMgQej+8H9R9D72fnISlbPwYyqUsFNn+MN7wwSl9DTBx7El9d
	Ym+v8adVH9rBA4QUvFxAjeGHILfBnxSdZa0eLK77sSwblcVzxX67I+1Of5uIxsopnD5hF9vik8YUk
	h6JkgqOR8/fw38Y9m7owPFlzE3d5eIaouAvSKxz1wVYP4svTzq2pykA+7VPrOu4jB9gDWavKhAFiK
	hgUZ4XBZw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kg0lL-0002ld-TZ; Fri, 20 Nov 2020 07:23:19 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kg0lK-0002kg-6W
 for linux-nvme@lists.infradead.org; Fri, 20 Nov 2020 07:23:19 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id EDB7EAC0C;
 Fri, 20 Nov 2020 07:23:16 +0000 (UTC)
Subject: Re: [PATCH 34/78] block: propagate BLKROSET to all partitions
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
References: <20201116145809.410558-1-hch@lst.de>
 <20201116145809.410558-35-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <11ea0b89-d8e6-2d5d-59e4-90e928d54042@suse.de>
Date: Fri, 20 Nov 2020 08:23:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201116145809.410558-35-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201120_022318_384297_1AF9AFBF 
X-CRM114-Status: GOOD (  23.54  )
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

T24gMTEvMTYvMjAgMzo1NyBQTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4gV2hlbiBzZXR0
aW5nIHRoZSB3aG9sZSBkZXZpY2UgcmVhZC1vbmx5IChvciBjbGVhcmluZyB0aGUgcmVhZC1vbmx5
Cj4gc3RhdGUpLCBhbHNvIHVwZGF0ZSB0aGUgcG9saWN5IGZvciBhbGwgcGFydGl0aW9ucy4gIFRo
ZSBzMzkwIGRhc2QKPiBkcml2ZXIgaGFzIGF3bHdheXMgYmVlbiBkb2luZyB0aGlzIGFuZCBpdCBt
YWtlcyBhIGxvdCBvZiBzZW5zZS4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdp
ZyA8aGNoQGxzdC5kZT4KPiAtLS0KPiAgIGJsb2NrL2lvY3RsLmMgfCA1ICsrKystCj4gICAxIGZp
bGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4gCj4gZGlmZiAtLWdp
dCBhL2Jsb2NrL2lvY3RsLmMgYi9ibG9jay9pb2N0bC5jCj4gaW5kZXggNmI3ODUxODEzNDRmZTEu
LjIyZjM5NGQxMThjMzAyIDEwMDY0NAo+IC0tLSBhL2Jsb2NrL2lvY3RsLmMKPiArKysgYi9ibG9j
ay9pb2N0bC5jCj4gQEAgLTM1NCw3ICszNTQsMTAgQEAgc3RhdGljIGludCBibGtkZXZfcm9zZXQo
c3RydWN0IGJsb2NrX2RldmljZSAqYmRldiwgZm1vZGVfdCBtb2RlLAo+ICAgCQlpZiAocmV0KQo+
ICAgCQkJcmV0dXJuIHJldDsKPiAgIAl9Cj4gLQliZGV2LT5iZF9wYXJ0LT5wb2xpY3kgPSBuOwo+
ICsJaWYgKGJkZXZfaXNfcGFydGl0aW9uKGJkZXYpKQo+ICsJCWJkZXYtPmJkX3BhcnQtPnBvbGlj
eSA9IG47Cj4gKwllbHNlCj4gKwkJc2V0X2Rpc2tfcm8oYmRldi0+YmRfZGlzaywgbik7Cj4gICAJ
cmV0dXJuIDA7Cj4gICB9Cj4gICAKPiAKUmV2aWV3ZWQtYnk6IEhhbm5lcyBSZWluZWNrZSA8aGFy
ZUBzdXNlLmRlPgoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlICAgICAg
ICAgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0
aW9ucyBHbWJILCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChBRyBO
w7xybmJlcmcpLCBHZXNjaMOkZnRzZsO8aHJlcjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxp
bmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
