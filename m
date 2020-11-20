Return-Path: <SRS0=Qryz=E2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C45C56201
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2020 07:25:35 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A5E52158C
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2020 07:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="d1xjkLj+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A5E52158C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5cSiW8avs6+9Fn0KeRnDWTjJUn3pSsuQJ4WJ6HOrwnM=; b=d1xjkLj+/djIArxg5pKWRcJvT
	28OzmX1f+OFlpL7zEpbgPLOgGauI/sxAB6jlJS5xpNa32Ls9djz5MKypC6WsFT0txCVa9h4wj4QP2
	llK4A0ZzGtRrYEHhflRpwJdxK5vsQDkGIORzfN1mh/mu7LRhcZraW579gAjik11zz8hcoeEETClvr
	WN5Fr4JEFOdV63d78vD5xTc/G67IAIkW3YNJcs9yiKgJTW9VaWVk8E2ZPfC2N+GlYBOJDlFmUop3X
	udvSr6YYtaQm56meHE97KX2QysOZZQKGeCzucjT1es6jlM+pM1nE/xYElX2bEdz3DAw5qE4poYSrj
	L0pSIZ1hA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kg0nU-0003Iq-8A; Fri, 20 Nov 2020 07:25:32 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kg0nS-0003I8-Q1
 for linux-nvme@lists.infradead.org; Fri, 20 Nov 2020 07:25:31 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id ACBFAAB3D;
 Fri, 20 Nov 2020 07:25:29 +0000 (UTC)
Subject: Re: [PATCH 54/78] block: remove a duplicate __disk_get_part prototype
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
References: <20201116145809.410558-1-hch@lst.de>
 <20201116145809.410558-55-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <92e3c0c1-aa72-aff9-8916-aa443f85a9e4@suse.de>
Date: Fri, 20 Nov 2020 08:25:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201116145809.410558-55-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201120_022530_996841_9B01C6B1 
X-CRM114-Status: GOOD (  21.42  )
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

T24gMTEvMTYvMjAgMzo1NyBQTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4gU2lnbmVkLW9m
Zi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+Cj4gLS0tCj4gICBpbmNsdWRlL2xp
bnV4L2dlbmhkLmggfCAxIC0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0pCj4gCj4g
ZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvZ2VuaGQuaCBiL2luY2x1ZGUvbGludXgvZ2VuaGQu
aAo+IGluZGV4IDQ2NTUzZDZkNjAyNTYzLi4yMmY1YjlmZDk2ZjhiZiAxMDA2NDQKPiAtLS0gYS9p
bmNsdWRlL2xpbnV4L2dlbmhkLmgKPiArKysgYi9pbmNsdWRlL2xpbnV4L2dlbmhkLmgKPiBAQCAt
MjUwLDcgKzI1MCw2IEBAIHN0YXRpYyBpbmxpbmUgZGV2X3QgcGFydF9kZXZ0KHN0cnVjdCBoZF9z
dHJ1Y3QgKnBhcnQpCj4gICAJcmV0dXJuIHBhcnRfdG9fZGV2KHBhcnQpLT5kZXZ0Owo+ICAgfQo+
ICAgCj4gLWV4dGVybiBzdHJ1Y3QgaGRfc3RydWN0ICpfX2Rpc2tfZ2V0X3BhcnQoc3RydWN0IGdl
bmRpc2sgKmRpc2ssIGludCBwYXJ0bm8pOwo+ICAgZXh0ZXJuIHN0cnVjdCBoZF9zdHJ1Y3QgKmRp
c2tfZ2V0X3BhcnQoc3RydWN0IGdlbmRpc2sgKmRpc2ssIGludCBwYXJ0bm8pOwo+ICAgCj4gICBz
dGF0aWMgaW5saW5lIHZvaWQgZGlza19wdXRfcGFydChzdHJ1Y3QgaGRfc3RydWN0ICpwYXJ0KQo+
IApSZXZpZXdlZC1ieTogSGFubmVzIFJlaW5lY2tlIDxoYXJlQHN1c2UuZGU+CgpDaGVlcnMsCgpI
YW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2UgICAgICAgICAgICAgICAgS2VybmVsIFN0b3Jh
Z2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5kZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICs0
OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdtYkgsIE1heGZlbGRzdHIu
IDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdlc2Now6RmdHNm
w7xocmVyOiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2xpbnV4LW52bWUK
