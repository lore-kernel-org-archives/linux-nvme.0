Return-Path: <SRS0=JPfP=EQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DFFAC388F7
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2020 07:00:48 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E2D420674
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2020 07:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="I+pSygnZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E2D420674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=uVDLZ0Bj8yh4F52/HUZT/jCBLDLILdOmQjUobFMJyVs=; b=I+pSygnZQiyQASU4n4mpHujgx
	oycspBP+K+yWzLEFuGLgeVy+acUShPffPNg/tcAbAVrkhztFVn7HtI0reWSTTsgExI63hBJ+eQ5uJ
	wXRNft6tx1nbi3CazmDAXD/RUxUMYL7P2idHQqBefBW1oD+b32Y/dL6BvItYcWh6IRhPscvjpo2u9
	Q79MoxuLIC3LnPGV14l+ppyqh5iiGhoEXJrVQsCdVPTSgtNMXW6FBkQH0IcASWALD9PhFKzrsODYd
	UBQRZuicmUimvGpvWd9jiWnd8LXns6Pk06zlKuTgUxLQNb1PkcFZiqs+3mEvgM63U4TP1zDqltfqi
	00EAgGFTA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kcNdu-0004f4-75; Tue, 10 Nov 2020 07:00:38 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kcNdo-0004ed-Up
 for linux-nvme@lists.infradead.org; Tue, 10 Nov 2020 07:00:33 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 4ADE6ABCC;
 Tue, 10 Nov 2020 07:00:29 +0000 (UTC)
Subject: Re: [PATCH 03/24] nvme: let set_capacity_revalidate_and_notify update
 the bdev size
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
References: <20201106190337.1973127-1-hch@lst.de>
 <20201106190337.1973127-4-hch@lst.de>
 <1d06cdfa-a904-30be-f3ec-08ae2fa85cbd@suse.de>
 <20201109085340.GB27483@lst.de>
 <e79f9a96-ef53-d6ea-f6e7-e141bdd2e2d2@suse.de>
 <d28042e3-3123-5dfc-d0a2-aab0012150c8@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <c883475d-c154-a123-521e-4723b87534cd@suse.de>
Date: Tue, 10 Nov 2020 08:00:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <d28042e3-3123-5dfc-d0a2-aab0012150c8@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201110_020033_118623_63E7B77F 
X-CRM114-Status: GOOD (  21.87  )
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

T24gMTEvMTAvMjAgMTI6MjggQU0sIFNhZ2kgR3JpbWJlcmcgd3JvdGU6Cj4gCj4+IFsgLi4gXQo+
Pj4+IE9yaWdpbmFsbHkgbnZtZSBtdWx0aXBhdGggd291bGQgdXBkYXRlL2NoYW5nZSB0aGUgc2l6
ZSBvZiB0aGUgbXVsdGlwYXRoCj4+Pj4gZGV2aWNlIGFjY29yZGluZyB0byB0aGUgdW5kZXJseWlu
ZyBwYXRoIGRldmljZXMuCj4+Pj4gV2l0aCB0aGlzIHBhdGNoIHRoZSBzaXplIG9mIHRoZSBtdWx0
aXBhdGggZGV2aWNlIHdpbGwgX25vdF8gY2hhbmdlIAo+Pj4+IGlmIHRoZXJlCj4+Pj4gaXMgYSBj
aGFuZ2Ugb24gdGhlIHVuZGVybHlpbmcgZGV2aWNlcy4KPj4+Cj4+PiBZZXMsIGl0IHdpbGwuwqAg
VGFrZSBhIGNsb3NlIGxvb2sgYXQgbnZtZV91cGRhdGVfZGlza19pbmZvIGFuZCBob3cgaXQgaXMK
Pj4+IGNhbGxlZC4KPj4+Cj4+IE9rYXksIHRoZW46IFdoYXQgd291bGQgYmUgdGhlIGNvcnJlY3Qg
d2F5IG9mIGhhbmRsaW5nIGEgc2l6ZSB1cGRhdGUgCj4+IGZvciBOVk1lIG11bHRpcGF0aD8KPj4g
QXNzdW1pbmcgd2UncmUgZ2V0dGluZyBhbiBBRU4gZm9yIGVhY2ggcGF0aCBzaWduYWxsaW5nIHRo
ZSBzaXplIGNoYW5nZQo+PiAob3IgYSBjb250cm9sbGVyIHJlc2V0IGxlYWRpbmcgdG8gYSBzaXpl
IGNoYW5nZSkuCj4+IFNvIGlmIHdlJ3JlIHVwZGF0aW5nIHRoZSBzaXplIG9mIHRoZSBtdWx0aXBh
dGggZGV2aWNlIHRvZ2V0aGVyIHdpdGggCj4+IHRoZSBwYXRoIGRldmljZSBhdCB0aGUgZmlyc3Qg
QUVOL3Jlc2V0IHdlJ2xsIGVuZCB1cCB3aXRoIHRoZSBvdGhlciAKPj4gcGF0aHMgaGF2aW5nIGEg
ZGlmZmVyZW50IHNpemUgdGhhbiB0aGUgbXVsdGlwYXRoIGRldmljZSAoYW5kIHRoZSBwYXRoIAo+
PiB3ZSd2ZSBqdXN0IGJlZW4gdXBkYXRpbmcpLgo+PiAtIERvIHdlIGNhcmUsIG9yIGNyb3NzIGZp
bmdlcnMgYW5kIGhvcGUgZm9yIHRoZSBiZXN0Pwo+PiAtIFNob3VsZG4ndCB3ZSBkZXRlY3QgdGhl
IGNhc2Ugd2hlcmUgd2Ugd29uJ3QgZ2V0IGEgc2l6ZSB1cGRhdGUgZm9yIAo+PiB0aGUgb3RoZXIg
cGF0aHMsIG9yLCBpbmRlZWQsIHdlIGhhdmUgYSBnZW51aW5lIGRldmljZSBzaXplIG1pc21hdGNo
IAo+PiBkdWUgdG8gYSBtaXNjb25maWd1cmF0aW9uIG9uIHRoZSB0YXJnZXQ/Cj4+Cj4+IElFIHNo
b3VsZG4ndCB3ZSBoYXZlIGEgZmxhZyAnc2l6ZSB1cGRhdGUgcGVuZGluZycgZm9yIHRoZSBvdGhl
ciAKPj4gcGF0aHMsLCB0byB0YWtlIHRoZW0gb3V0IG91ZiB1c2UgdGVtcG9yYXJpbHkgdW50aWwg
dGhlIG90aGVyIAo+PiBBRU5zL3Jlc2V0cyBoYXZlIGJlZW4gcHJvY2Vzc2VkPwo+IAo+IHRoZSBt
cGF0aCBkZXZpY2Ugd2lsbCB0YWtlIHRoZSBtaW5pbXVtIHNpemUgZnJvbSBhbGwgdGhlIHBhdGhz
LCB0aGF0IGlzCj4gd2hhdCBibGtfc3RhY2tfbGltaXRzIGRvZXMuIFdoZW4gdGhlIEFFTiBmb3Ig
YWxsIHRoZSBwYXRocyB3aWxsIGFycml2ZQo+IHRoZSBtcGF0aCBzaXplIHdpbGwgdXBkYXRlLgo+
IApCdXQgdGhhdCdzIHByZWNpc2VseSBteSBwb2ludDsgdGhlcmUgd29uJ3QgYmUgYW4gQUVOIGZv
ciBfYWxsXyBwYXRocywgCmJ1dCByYXRoZXIgb25lIEFFTiBwZXIgcGF0aC4gV2hpY2ggd2lsbCBi
ZSBwcm9jZXNzZWQgc2VwYXJhdGVseSwgbGVhZGluZyAKdG8gdGhlIGlzc3VlIGRlc2NyaWJlZCBh
Ym92ZS4KCj4gTm90IHN1cmUgaG93IHRoaXMgaXMgZGlmZmVyZW50IHRoYW4gd2hhdCB3ZSBoYXZl
IHRvZGF5Li4uCgpPaCwgdGhhdCBpcyBhIHByb2JsZW0gZXZlbiB0b2RheS4KU28gd2Ugc2hvdWxk
IHByb2JhYmx5IG1vdmUgaXQgdG8gYSBkaWZmZXJlbnQgdGhyZWFkLi4uCgpDaGVlcnMsCgpIYW5u
ZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2UgICAgICAgICAgICAgICAgS2VybmVsIFN0b3JhZ2Ug
QXJjaGl0ZWN0CmhhcmVAc3VzZS5kZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICs0OSA5
MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdtYkgsIE1heGZlbGRzdHIuIDUs
IDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdlc2Now6RmdHNmw7xo
cmVyOiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2xpbnV4LW52bWUK
