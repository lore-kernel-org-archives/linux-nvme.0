Return-Path: <SRS0=mxs5=EP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE8CC2D0A3
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2020 07:54:11 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E7662084C
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2020 07:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bASZKM19"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E7662084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=izPbBYtISk/vqqWBkf0XhASDpwkpJPDlPeSiEpyChsI=; b=bASZKM19WYD/AR+D0Fqk0eT1q
	8PcQZzl3qzCrDbudk1ptHusS4lJwzVTwLHhPzn+7Ymu9MmVUb1UoWGOXMMLOnzplCPSre6fiWHR7P
	6vxsAA2ERprg+WVwdqHFZ8t1nRNDGaBmsumSOfCT8Hyf2Fe/txUdXshNe5QQQ9Wq8Qgg63OQ/JZ+A
	+gWFbzoCkMmsDf2yt9W+QTugC4hLxg6aKofLAP4vWF63/1LtJpz638G60nAoBUEEwbuiXoeSdd0zV
	FZJ2qoOKdNcUtboQ+FO8JlQpv6JxKyX+FAkuW+1Rwk8aexKLMSnoH+t2LJcIIB9M95VYbr9HLjWLE
	BJH27c7tA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kc204-0003Dn-V9; Mon, 09 Nov 2020 07:54:05 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kc202-0003D8-Bx
 for linux-nvme@lists.infradead.org; Mon, 09 Nov 2020 07:54:03 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id E44CAABAE;
 Mon,  9 Nov 2020 07:53:59 +0000 (UTC)
Subject: Re: [PATCH 03/24] nvme: let set_capacity_revalidate_and_notify update
 the bdev size
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
References: <20201106190337.1973127-1-hch@lst.de>
 <20201106190337.1973127-4-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <1d06cdfa-a904-30be-f3ec-08ae2fa85cbd@suse.de>
Date: Mon, 9 Nov 2020 08:53:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201106190337.1973127-4-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201109_025402_543987_C50C7D64 
X-CRM114-Status: GOOD (  24.41  )
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

T24gMTEvNi8yMCA4OjAzIFBNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPiBUaGVyZSBpcyBu
byBnb29kIHJlYXNvbiB0byBjYWxsIHJldmFsaWRhdGVfZGlza19zaXplIHNlcGFyYXRlbHkuCj4g
Cj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+Cj4gLS0tCj4g
ICBkcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgfCA1ICstLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKyksIDQgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bnZtZS9ob3N0L2NvcmUuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYwo+IGluZGV4IDM3NjA5
NmJmYzU0YTgzLi40ZTg2YzlhYWZkODhhNyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL252bWUvaG9z
dC9jb3JlLmMKPiArKysgYi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMKPiBAQCAtMjA1Myw3ICsy
MDUzLDcgQEAgc3RhdGljIHZvaWQgbnZtZV91cGRhdGVfZGlza19pbmZvKHN0cnVjdCBnZW5kaXNr
ICpkaXNrLAo+ICAgCQkJY2FwYWNpdHkgPSAwOwo+ICAgCX0KPiAgIAo+IC0Jc2V0X2NhcGFjaXR5
X3JldmFsaWRhdGVfYW5kX25vdGlmeShkaXNrLCBjYXBhY2l0eSwgZmFsc2UpOwo+ICsJc2V0X2Nh
cGFjaXR5X3JldmFsaWRhdGVfYW5kX25vdGlmeShkaXNrLCBjYXBhY2l0eSwgdHJ1ZSk7Cj4gICAK
PiAgIAludm1lX2NvbmZpZ19kaXNjYXJkKGRpc2ssIG5zKTsKPiAgIAludm1lX2NvbmZpZ193cml0
ZV96ZXJvZXMoZGlzaywgbnMpOwo+IEBAIC0yMTM2LDcgKzIxMzYsNiBAQCBzdGF0aWMgaW50IG52
bWVfdXBkYXRlX25zX2luZm8oc3RydWN0IG52bWVfbnMgKm5zLCBzdHJ1Y3QgbnZtZV9pZF9ucyAq
aWQpCj4gICAJCWJsa19zdGFja19saW1pdHMoJm5zLT5oZWFkLT5kaXNrLT5xdWV1ZS0+bGltaXRz
LAo+ICAgCQkJCSAmbnMtPnF1ZXVlLT5saW1pdHMsIDApOwo+ICAgCQlibGtfcXVldWVfdXBkYXRl
X3JlYWRhaGVhZChucy0+aGVhZC0+ZGlzay0+cXVldWUpOwo+IC0JCW52bWVfdXBkYXRlX2JkZXZf
c2l6ZShucy0+aGVhZC0+ZGlzayk7Cj4gICAJCWJsa19tcV91bmZyZWV6ZV9xdWV1ZShucy0+aGVh
ZC0+ZGlzay0+cXVldWUpOwo+ICAgCX0KPiAgICNlbmRpZgoKSG9sZCBvbi4KVGhpcywgYXQgdGhl
IHZlcnkgbGVhc3QsIHNob3VsZCBiZSBhIHNlcGFyYXRlIHBhdGNoLgpXaXRoIHRoaXMgeW91IGFy
ZSBjaGFuZ2luZyB0aGUgYmVoYXZpb3VyIG9mIG52bWUgbXVsdGlwYXRoLgoKT3JpZ2luYWxseSBu
dm1lIG11bHRpcGF0aCB3b3VsZCB1cGRhdGUvY2hhbmdlIHRoZSBzaXplIG9mIHRoZSBtdWx0aXBh
dGggCmRldmljZSBhY2NvcmRpbmcgdG8gdGhlIHVuZGVybHlpbmcgcGF0aCBkZXZpY2VzLgpXaXRo
IHRoaXMgcGF0Y2ggdGhlIHNpemUgb2YgdGhlIG11bHRpcGF0aCBkZXZpY2Ugd2lsbCBfbm90XyBj
aGFuZ2UgaWYgCnRoZXJlIGlzIGEgY2hhbmdlIG9uIHRoZSB1bmRlcmx5aW5nIGRldmljZXMuCgpX
aGlsZSBwZXJzb25hbGx5IEkgd291bGQgX2xvdmVfIHRvIGhhdmUgdGhpcyBwYXRjaCwgd2Ugc2hv
dWxkIGF0IGxlYXN0IApkb2N1bWVudCB0aGlzIGJ5IG1ha2luZyBpdCBhIHNlcGFyYXRlIHBhdGNo
LgpBbmQgd2UgcG9zc2libHkgc2hvdWxkIGNoZWNrIGlmIGJvdGggc2l6ZXMgYXJlIHRoZSBzYW1l
LCBhbmQgdGhpbmsgb2YgCndoYXQgd2Ugc2hvdWxkIGJlIGRvaW5nIGlmIHRoZXkgYXJlIG5vdC4K
CkNoZWVycywKCkhhbm5lcwotLSAKRHIuIEhhbm5lcyBSZWluZWNrZSAgICAgICAgICAgICAgICBL
ZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QKaGFyZUBzdXNlLmRlICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR21iSCwg
TWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnCkhSQiAzNjgwOSAoQUcgTsO8cm5iZXJnKSwg
R2VzY2jDpGZ0c2bDvGhyZXI6IEZlbGl4IEltZW5kw7ZyZmZlcgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGlu
dXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
