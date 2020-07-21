Return-Path: <SRS0=MSYC=BA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B114BC433E3
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jul 2020 06:39:34 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7947C2080D
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jul 2020 06:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fkb8CRE7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7947C2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3pNbZXAPdRNS3HhzcfqtkQPqw8KmMcJ9zqFjWVCJydc=; b=fkb8CRE7NK75Tbqic+JpqsEED
	1zWgGV0yP+LEbLLuFC2ceEYr9C82js2Yc3WRCaPb7bASBm+8h+H8EMlPN16WqfIpSDuvmj45V5jBA
	JqpilFQiNeXqgWVVvI9yp01YdWmlkwaWcOTy+rerXcGoTLtpPN9R+8ZW+pztpY7hrFl34P2K2ftKn
	MnilYMJxbqZEENxHgSB5xKfJYi4zvLFCciXvx8ogjx7vh8mPfUPswu0y10IEwjcwg4c87KCKkyMGH
	4kaz4zFPewefh7/KeUnW1bZBEC9DCP7yluvVMDCZuX3hCyvMpCF6Ru2IrB3onprkWmXSNWDWvuDhZ
	5hRg9l4+g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jxlvz-0004Xp-0z; Tue, 21 Jul 2020 06:39:27 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jxlvr-0004XO-Nx
 for linux-nvme@lists.infradead.org; Tue, 21 Jul 2020 06:39:20 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id DF0BEACDB;
 Tue, 21 Jul 2020 06:39:23 +0000 (UTC)
Subject: Re: [PATCH 1/2] nvme: multipath: round-robin: fix logic for
 non-optimized paths
To: Sagi Grimberg <sagi@grimberg.me>, mwilck@suse.com,
 Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@intel.com>
References: <20200716195929.28399-1-mwilck@suse.com>
 <fcda06a3-ac59-60dc-7200-ce22b9c216bf@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <b2e59b6e-e71a-a9d8-c768-a4a052449cf6@suse.de>
Date: Tue, 21 Jul 2020 08:39:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <fcda06a3-ac59-60dc-7200-ce22b9c216bf@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200721_023919_882800_93796DFB 
X-CRM114-Status: GOOD (  17.36  )
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

T24gNy8yMC8yMCA5OjUxIFBNLCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+IAo+PiBGcm9tOiBNYXJ0
aW4gV2lsY2sgPG13aWxja0BzdXNlLmNvbT4KPj4KPj4gSGFuZGxlIHRoZSBzcGVjaWFsIGNhc2Ug
d2hlcmUgd2UgaGF2ZSBleGFjdGx5IG9uZSBvcHRpbWl6ZWQgcGF0aCwKPj4gd2hpY2ggd2Ugc2hv
dWxkIGtlZXAgdXNpbmcgaW4gdGhpcyBjYXNlLiBBbHNvLCB1c2UgdGhlIG5leHQKPj4gbm9uLW9w
dGltaXplZCBwYXRoLCBub3QgdGhlIGxhc3Qgb25lLgo+IAo+IE5vdCBzdXJlIEkgdW5kZXJzdGFu
ZCwgZG9lcyB0aGlzIHBhdGNoIGFsc28gdXNlIG5vbm9wdCBwYXRocyBpZiB3ZQo+IGhhdmUgYSBz
aW5nbGUgb3B0IHBhdGg/CgpJbmRlZWQsIHRoZSBsYXR0ZXIgY2hhbmdlIHNob3VsZCBiZSByZW1v
dmVkIGZyb20gdGhpcyBwYXRjaC4KCkNoZWVycywKCkhhbm5lcwotLSAKRHIuIEhhbm5lcyBSZWlu
ZWNrZSAgICAgICAgICAgIFRlYW1sZWFkIFN0b3JhZ2UgJiBOZXR3b3JraW5nCmhhcmVAc3VzZS5k
ZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNv
ZnR3YXJlIFNvbHV0aW9ucyBHbWJILCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcKSFJC
IDM2ODA5IChBRyBOw7xybmJlcmcpLCBHZXNjaMOkZnRzZsO8aHJlcjogRmVsaXggSW1lbmTDtnJm
ZmVyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51
eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
