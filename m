Return-Path: <SRS0=li1X=BB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D64C433E1
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jul 2020 05:35:20 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D2F020684
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jul 2020 05:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="3TxpzNa+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D2F020684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=lvUVLTszskIgwTE5LR/4Y9bhBspgvxzbv5zot2Lh+fg=; b=3TxpzNa+kCIhjo7zFvIKxMi4m
	/ADwgFI35COjN0BUJPeyluSJFE102NIk51k0/j4O9+u53PBIv+Ey5+f+J9dF/g/F/t540lpu4x0ZU
	mnd9dL9OYNlINjc9O13cnZSqx5u3KYVQkLlyZorYTBU1EF74DhXJOYqlKc7zObEithIQVKfxckP+v
	0UEcgD1tyBmgsQkURw/acB6X5nwe4UgxZNCHmq6gqGJYOvl6ZPF8U1ggCQxGmsQ1xDciYrHFc/dnB
	h73MOnBgTpy+/I0fXEUrsvy3QgVEaylKftaa/S98QDWl2aokLIusspeLVwng0UsrgWR68ep2t7hAN
	62AfGpZEQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jy7PL-0005Oa-NX; Wed, 22 Jul 2020 05:35:11 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jy7PJ-0005OA-5O
 for linux-nvme@lists.infradead.org; Wed, 22 Jul 2020 05:35:10 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id BC703AD26;
 Wed, 22 Jul 2020 05:35:13 +0000 (UTC)
Subject: Re: [PATCH 1/2] nvme: multipath: round-robin: fix logic for
 non-optimized paths
To: Sagi Grimberg <sagi@grimberg.me>, mwilck@suse.com,
 Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@intel.com>
References: <20200716195929.28399-1-mwilck@suse.com>
 <fcda06a3-ac59-60dc-7200-ce22b9c216bf@grimberg.me>
 <b2e59b6e-e71a-a9d8-c768-a4a052449cf6@suse.de>
 <c51e7fa1-2e89-e5e1-6962-bc16470afd59@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <c8890576-31e5-a56c-53ab-b953b7e404b7@suse.de>
Date: Wed, 22 Jul 2020 07:35:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <c51e7fa1-2e89-e5e1-6962-bc16470afd59@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200722_013509_355496_4B094300 
X-CRM114-Status: GOOD (  19.13  )
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
Cc: marting@netapp.com, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gNy8yMS8yMCA3OjE5IFBNLCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+IAo+Pj4+IEhhbmRsZSB0
aGUgc3BlY2lhbCBjYXNlIHdoZXJlIHdlIGhhdmUgZXhhY3RseSBvbmUgb3B0aW1pemVkIHBhdGgs
Cj4+Pj4gd2hpY2ggd2Ugc2hvdWxkIGtlZXAgdXNpbmcgaW4gdGhpcyBjYXNlLiBBbHNvLCB1c2Ug
dGhlIG5leHQKPj4+PiBub24tb3B0aW1pemVkIHBhdGgsIG5vdCB0aGUgbGFzdCBvbmUuCj4+Pgo+
Pj4gTm90IHN1cmUgSSB1bmRlcnN0YW5kLCBkb2VzIHRoaXMgcGF0Y2ggYWxzbyB1c2Ugbm9ub3B0
IHBhdGhzIGlmIHdlCj4+PiBoYXZlIGEgc2luZ2xlIG9wdCBwYXRoPwo+Pgo+PiBJbmRlZWQsIHRo
ZSBsYXR0ZXIgY2hhbmdlIHNob3VsZCBiZSByZW1vdmVkIGZyb20gdGhpcyBwYXRjaC4KPiAKPiBX
aHkgc2hvdWxkIHdlIGV2ZW4gZG8gdGhpcz8gd2UgaGF2ZSBhIGNsZWFyIGluZGljYXRpb24gZnJv
bSB0aGUKPiBjb250cm9sbGVyIG9uIG5zIGFjY2Vzcy4gSWYgd2UgaGF2ZSBhIG9wdGltaXplZCBw
YXRoIHdlIHNob3VsZCBuZXZlcgo+IHNlbGVjdCBhbnkgbm9uLW9wdGltaXplZCBwYXRoLgo+IAo+
IFdoYXQgaWYgYSBub24tb3B0aW1pemVkIHBhdGggaGFzIGEgNTB4IGhpZ2hlciBhY2Nlc3MgbGF0
ZW5jeT8gaXQncyBqdXN0Cj4gd3JvbmcgdG8gdXNlIHRoaXMgcGF0aC4uLgoKRXJybS4gSSB0aGlu
ayBNYXJ0aW4gZGlkbid0IHN0YXRlIGNsZWFybHkgd2hhdCB0aGUgcHJvYmxlbSB3YXMuCgpUaGUg
cHJvYmxlbSBpcyB3aGVuIHRoZSBfY3VycmVudF8gcGF0aCBpcyB0aGUgb25seSBvcHRpbWl6ZWQg
cGF0aCwgYW5kIAphbGwgb3RoZXIgcGF0aHMgYXJlIG5vbi1vcHRpbWl6ZWQ6CgoJZm9yIChucyA9
IG52bWVfbmV4dF9ucyhoZWFkLCBvbGQpOwoJICAgICBucyAhPSBvbGQ7CgkgICAgIG5zID0gbnZt
ZV9uZXh0X25zKGhlYWQsIG5zKSkgewoKV2Ugc3RhcnQgd2l0aCB0aGUgX25leHRfIHBhdGgsIGFu
ZCBzdG9wIF9iZWZvcmVfIHdlIGNoZWNrIHRoZSAnb2xkJyAKcGF0aC4gQ29uc2VxdWVudGx5IHRo
ZSAnb2xkJyBwYXRoIGlzIG5ldmVyIGNoZWNrZWQsIGFuZCBuZXZlciBzZWxlY3RlZC4KCkNoZWVy
cywKCkhhbm5lcwotLSAKRHIuIEhhbm5lcyBSZWluZWNrZSAgICAgICAgICAgIFRlYW1sZWFkIFN0
b3JhZ2UgJiBOZXR3b3JraW5nCmhhcmVAc3VzZS5kZSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHbWJILCBNYXhm
ZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBHZXNj
aMOkZnRzZsO8aHJlcjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1u
dm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9saW51eC1udm1lCg==
