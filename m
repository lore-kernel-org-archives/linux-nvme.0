Return-Path: <SRS0=Qryz=E2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D86C64E75
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2020 07:59:45 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0421222BA
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2020 07:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gz1ojsab"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0421222BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=tfkV1+qFEijPmKJfbOD9o+15Jfcc3c9a5BRsXAERYKU=; b=gz1ojsabzjhYgxjUi2g8XzPpG
	bj315ix4tolkRulIgOeWXob1nDKz6eKd8WuwRCW2w/Wo+xKag8c7+DgctBhbHMECJVW54OgRTwVWD
	/qFyPA9DFijGXxka+2naNIcVJNn/2xhCyqQfZWOsxjfleCMdLlyzOUfRTnCIPcANAErgTHfqmVWs3
	Z9lFJCxwFG4x3NSRasZMmwXX4uPgJCS5jQR5Ku2pI6MnhYqlT7TLSWLJKikBVPfOMmU4E/sq+oALG
	+6dJL3r+Gji6TuOwGq86YXxepq4OR8rFZBk96HhYS192pj6CenJ8vcGIX4mdXISbCT97YqHERRlXn
	P2cbc7FtA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kg1KY-0002qV-3Q; Fri, 20 Nov 2020 07:59:42 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kg1KV-0002pd-Od
 for linux-nvme@lists.infradead.org; Fri, 20 Nov 2020 07:59:40 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id AEC1DAB3D;
 Fri, 20 Nov 2020 07:59:38 +0000 (UTC)
Subject: Re: [PATCH 72/78] block: use disk_part_iter_exit in
 disk_part_iter_next
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
References: <20201116145809.410558-1-hch@lst.de>
 <20201116145809.410558-73-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <aa77ac66-cfdf-a53a-c30d-e44a6fc93b38@suse.de>
Date: Fri, 20 Nov 2020 08:59:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201116145809.410558-73-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201120_025939_908267_11471583 
X-CRM114-Status: GOOD (  22.61  )
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

T24gMTEvMTYvMjAgMzo1OCBQTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4gQ2FsbCBkaXNr
X3BhcnRfaXRlcl9leGl0IGluIGRpc2tfcGFydF9pdGVyX25leHQgaW5zdGVhZCBvZiBkdXBsaWNh
dGluZwo+IHRoZSBmdW5jdGlvbmFsaXR5Lgo+IAo+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waCBI
ZWxsd2lnIDxoY2hAbHN0LmRlPgo+IC0tLQo+ICAgYmxvY2svZ2VuaGQuYyB8IDMgKy0tCj4gICAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDIgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAt
LWdpdCBhL2Jsb2NrL2dlbmhkLmMgYi9ibG9jay9nZW5oZC5jCj4gaW5kZXggOTk5ZjcxNDJiMDRl
N2QuLjU2YmMzN2U5OGVkODUyIDEwMDY0NAo+IC0tLSBhL2Jsb2NrL2dlbmhkLmMKPiArKysgYi9i
bG9jay9nZW5oZC5jCj4gQEAgLTIzMCw4ICsyMzAsNyBAQCBzdHJ1Y3QgaGRfc3RydWN0ICpkaXNr
X3BhcnRfaXRlcl9uZXh0KHN0cnVjdCBkaXNrX3BhcnRfaXRlciAqcGl0ZXIpCj4gICAJaW50IGlu
YywgZW5kOwo+ICAgCj4gICAJLyogcHV0IHRoZSBsYXN0IHBhcnRpdGlvbiAqLwo+IC0JZGlza19w
dXRfcGFydChwaXRlci0+cGFydCk7Cj4gLQlwaXRlci0+cGFydCA9IE5VTEw7Cj4gKwlkaXNrX3Bh
cnRfaXRlcl9leGl0KHBpdGVyKTsKPiAgIAo+ICAgCS8qIGdldCBwYXJ0X3RibCAqLwo+ICAgCXJj
dV9yZWFkX2xvY2soKTsKPiAKUmV2aWV3ZWQtYnk6IEhhbm5lcyBSZWluZWNrZSA8aGFyZUBzdXNl
LmRlPgoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlICAgICAgICAgICAg
ICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBH
bWJILCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChBRyBOw7xybmJl
cmcpLCBHZXNjaMOkZnRzZsO8aHJlcjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlz
dApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
