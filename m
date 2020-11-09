Return-Path: <SRS0=mxs5=EP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22E8C2D0A3
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2020 09:25:35 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8271A206ED
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2020 09:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="E6rVDOSn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8271A206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=LSn90cwiuQwh9MaRMAN7MNbChYVmciYnsmIRimNg3a8=; b=E6rVDOSnSywfFcWO/PofUmfey
	25yaI60yzvmBoQjxBgCFaMp4+NCf/EiUrJfBmyK6sc/1pU+xUAxFRpCr3xY9DEDe85TyFPLuoH7xb
	Yk3b9WSeKYrAgwd1NXSrjdPVVe628thJ1EtH2nylZu4f3uNyKaJCwammccCsQIaqdkE+GWnLRSa7e
	OYUkPEk5m/MlNCu9dJrr24uCjsnF+FFzDWx4dc5m8Ig8i1gYVRTfCFep7GzkUkErRPdt2kIgCksAy
	I9lc6tdkBaJtDnRt9hjjMCnzsA8cu/rxYe1UhuuOKttffLZ6R5lCjNGFhOe155VsnTL7Yif99o98H
	Y+VzVAtwg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kc3QX-0005WJ-Sq; Mon, 09 Nov 2020 09:25:29 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kc3QV-0005VQ-PZ
 for linux-nvme@lists.infradead.org; Mon, 09 Nov 2020 09:25:28 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id CA23CABCC;
 Mon,  9 Nov 2020 09:25:23 +0000 (UTC)
Subject: Re: [PATCH 03/24] nvme: let set_capacity_revalidate_and_notify update
 the bdev size
To: Christoph Hellwig <hch@lst.de>
References: <20201106190337.1973127-1-hch@lst.de>
 <20201106190337.1973127-4-hch@lst.de>
 <1d06cdfa-a904-30be-f3ec-08ae2fa85cbd@suse.de>
 <20201109085340.GB27483@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <e79f9a96-ef53-d6ea-f6e7-e141bdd2e2d2@suse.de>
Date: Mon, 9 Nov 2020 10:25:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201109085340.GB27483@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201109_042527_959066_7527D767 
X-CRM114-Status: GOOD (  23.30  )
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
 ceph-devel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, "Martin K. Petersen" <martin.petersen@oracle.com>,
 Minchan Kim <minchan@kernel.org>, linux-fsdevel@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTEvOS8yMCA5OjUzIEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPiBPbiBNb24sIE5v
diAwOSwgMjAyMCBhdCAwODo1Mzo1OEFNICswMTAwLCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6Cj4+
PiBpbmRleCAzNzYwOTZiZmM1NGE4My4uNGU4NmM5YWFmZDg4YTcgMTAwNjQ0Cj4+PiAtLS0gYS9k
cml2ZXJzL252bWUvaG9zdC9jb3JlLmMKPj4+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUu
Ywo+Pj4gQEAgLTIwNTMsNyArMjA1Myw3IEBAIHN0YXRpYyB2b2lkIG52bWVfdXBkYXRlX2Rpc2tf
aW5mbyhzdHJ1Y3QgZ2VuZGlzayAqZGlzaywKPj4+ICAgIAkJCWNhcGFjaXR5ID0gMDsKWyAuLiBd
Cj4+IE9yaWdpbmFsbHkgbnZtZSBtdWx0aXBhdGggd291bGQgdXBkYXRlL2NoYW5nZSB0aGUgc2l6
ZSBvZiB0aGUgbXVsdGlwYXRoCj4+IGRldmljZSBhY2NvcmRpbmcgdG8gdGhlIHVuZGVybHlpbmcg
cGF0aCBkZXZpY2VzLgo+PiBXaXRoIHRoaXMgcGF0Y2ggdGhlIHNpemUgb2YgdGhlIG11bHRpcGF0
aCBkZXZpY2Ugd2lsbCBfbm90XyBjaGFuZ2UgaWYgdGhlcmUKPj4gaXMgYSBjaGFuZ2Ugb24gdGhl
IHVuZGVybHlpbmcgZGV2aWNlcy4KPiAKPiBZZXMsIGl0IHdpbGwuICBUYWtlIGEgY2xvc2UgbG9v
ayBhdCBudm1lX3VwZGF0ZV9kaXNrX2luZm8gYW5kIGhvdyBpdCBpcwo+IGNhbGxlZC4KPiAKT2th
eSwgdGhlbjogV2hhdCB3b3VsZCBiZSB0aGUgY29ycmVjdCB3YXkgb2YgaGFuZGxpbmcgYSBzaXpl
IHVwZGF0ZSBmb3IgCk5WTWUgbXVsdGlwYXRoPwpBc3N1bWluZyB3ZSdyZSBnZXR0aW5nIGFuIEFF
TiBmb3IgZWFjaCBwYXRoIHNpZ25hbGxpbmcgdGhlIHNpemUgY2hhbmdlCihvciBhIGNvbnRyb2xs
ZXIgcmVzZXQgbGVhZGluZyB0byBhIHNpemUgY2hhbmdlKS4KU28gaWYgd2UncmUgdXBkYXRpbmcg
dGhlIHNpemUgb2YgdGhlIG11bHRpcGF0aCBkZXZpY2UgdG9nZXRoZXIgd2l0aCB0aGUgCnBhdGgg
ZGV2aWNlIGF0IHRoZSBmaXJzdCBBRU4vcmVzZXQgd2UnbGwgZW5kIHVwIHdpdGggdGhlIG90aGVy
IHBhdGhzIApoYXZpbmcgYSBkaWZmZXJlbnQgc2l6ZSB0aGFuIHRoZSBtdWx0aXBhdGggZGV2aWNl
IChhbmQgdGhlIHBhdGggd2UndmUgCmp1c3QgYmVlbiB1cGRhdGluZykuCi0gRG8gd2UgY2FyZSwg
b3IgY3Jvc3MgZmluZ2VycyBhbmQgaG9wZSBmb3IgdGhlIGJlc3Q/Ci0gU2hvdWxkbid0IHdlIGRl
dGVjdCB0aGUgY2FzZSB3aGVyZSB3ZSB3b24ndCBnZXQgYSBzaXplIHVwZGF0ZSBmb3IgdGhlIApv
dGhlciBwYXRocywgb3IsIGluZGVlZCwgd2UgaGF2ZSBhIGdlbnVpbmUgZGV2aWNlIHNpemUgbWlz
bWF0Y2ggZHVlIHRvIGEgCm1pc2NvbmZpZ3VyYXRpb24gb24gdGhlIHRhcmdldD8KCklFIHNob3Vs
ZG4ndCB3ZSBoYXZlIGEgZmxhZyAnc2l6ZSB1cGRhdGUgcGVuZGluZycgZm9yIHRoZSBvdGhlciBw
YXRocywsIAp0byB0YWtlIHRoZW0gb3V0IG91ZiB1c2UgdGVtcG9yYXJpbHkgdW50aWwgdGhlIG90
aGVyIEFFTnMvcmVzZXRzIGhhdmUgCmJlZW4gcHJvY2Vzc2VkPwoKQ2hlZXJzLAoKSGFubmVzCi0t
IApEci4gSGFubmVzIFJlaW5lY2tlICAgICAgICAgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hp
dGVjdApoYXJlQHN1c2UuZGUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICArNDkgOTExIDc0
MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHbWJILCBNYXhmZWxkc3RyLiA1LCA5MDQw
OSBOw7xybmJlcmcKSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBHZXNjaMOkZnRzZsO8aHJlcjog
RmVsaXggSW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJh
ZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51
eC1udm1lCg==
