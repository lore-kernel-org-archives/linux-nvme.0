Return-Path: <SRS0=f2/u=AV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50AFC433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jul 2020 06:59:01 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BCAD2078B
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jul 2020 06:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tKFWqlC/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BCAD2078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3C44PWfvjN9skIJdkUHzT0W3XhYddnf1vGCAtM0mPJ8=; b=tKFWqlC/ZVpXYWttWIffIVCg5
	/kcYkF7hYQNXtAxz8lkGWma/nH7jejUhku4FnNvDm24vb3l3VGklcRCMv8HoarzpI43KjJ3NhzaOK
	FCLbdaQXsSTpqi/u9EG3QRb1bB/E9kSIiuBA7zmNywVQgOEoFsxbwmgtD/Auf0B2009IJ4erF7hlM
	clp2Heht8rhOhBmS8P69beMMn+3pEDsotyQBVHyn5smU6QlZPwHz5KHdmutoDCXUoM0zV071ZSXEi
	UveFBmPJgDxKWROWOw519FrU9LlO36S/jiYrhNl1xrcX6D/f2QxRZuynMLkje2ok5jN0af2SHzwjH
	POm+FwVHQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jtmzm-00075c-KD; Fri, 10 Jul 2020 06:58:54 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jtmzj-00074q-Bz
 for linux-nvme@lists.infradead.org; Fri, 10 Jul 2020 06:58:52 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 51638AD74;
 Fri, 10 Jul 2020 06:58:48 +0000 (UTC)
Subject: Re: [PATCH v7] nvme-fabrics: reject I/O to offline device
To: Sagi Grimberg <sagi@grimberg.me>, James Smart <james.smart@broadcom.com>, 
 Victor Gladkov <Victor.Gladkov@kioxia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <168ed5d66eae49ac8b445478b1bb362d@kioxia.com>
 <ca82af03-0cf7-bb71-cf55-caf88c278dfa@broadcom.com>
 <fee0ecca-3d31-a04f-af7c-7a3aada9d6fe@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <6232a445-f898-5294-77a1-6a06ee94717d@suse.de>
Date: Fri, 10 Jul 2020 08:58:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <fee0ecca-3d31-a04f-af7c-7a3aada9d6fe@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200710_025851_512632_0B3F9DAB 
X-CRM114-Status: GOOD (  18.77  )
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
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 "Ewan D. Milne" <emilne@redhat.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gNy8xMC8yMCA2OjUwIEFNLCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+IAo+PiBMb29rcyBnb29k
IHRvIG1lLsKgIE9ubHkgbml0IEkgc2VlIGlzIC0gd2h5IGFyZSB3ZSBjaGVja2luZyBjdHJsLT5v
cHRzIAo+PiBpbiB0aGUgeHh4X2ZhaWxmYXN0X3dvcmsoKSByb3V0aW5lcyA/Cj4gCj4gV2hpY2gg
YnJpbmdzIG1lIHRvIHRoZSBxdWVzdGlvbiwgaXMgdGhlcmUgYW55IGRlc2lyZSB0byBoYXZlIHRo
aXMKPiBiZWhhdmlvciBpbiBwY2kgYXMgd2VsbD8KCkkgd2FzIHVuZGVyIHRoZSBpbXByZXNzaW9u
IHRoYXQgYW4gb2ZmbGluZSBOVk1lLVBDSSBkZXZpY2UgaXMgYSBwcmV0dHkgCnRlcm1pbmFsIGNv
bmRpdGlvbi4gVGhpcyBwYXRjaCBvbmx5IHdvdWxkIG1ha2Ugc2Vuc2UgaWYgYSByZWNvbm5lY3Qg
CndvdWxkIGJlIGFibGUgdG8gcmVjb3ZlciB0aGlzIHNpdHVhdGlvbi4KRm9yIE5WTWUtUENJIHdl
IHdvdWxkIG5vdGlmeSB0aGUgYXBwbGljYXRpb24gZWFybGllcjsgZGV2aWNlJ3Mgc3RpbGwgCmRl
YWQsIHRob3VnaCwgc28gSSdtIG5vdCBzdXJlIGlmIHRoYXQgbWFrZXMgYSBodWdlIGRpZmZlcmVu
Y2UuCk5vciBzaG91bGQgaXQgYmUgYSBjb21tb24gb2NjdXJlbmNlLgoKVW5sZXNzIHlvdSB0YWxr
IGFib3V0IEFSTSBzZXJ2ZXJzLCBmb3Igd2hpY2ggZnJ5aW5nIE5WTWUgZGV2aWNlcyBzZWVtcyAK
dG8gYmUgYSBob2JieSA6LSkKCkNoZWVycywKCkhhbm5lcwotLSAKRHIuIEhhbm5lcyBSZWluZWNr
ZSAgICAgICAgICAgIFRlYW1sZWFkIFN0b3JhZ2UgJiBOZXR3b3JraW5nCmhhcmVAc3VzZS5kZSAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3
YXJlIFNvbHV0aW9ucyBHbWJILCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2
ODA5IChBRyBOw7xybmJlcmcpLCBHZXNjaMOkZnRzZsO8aHJlcjogRmVsaXggSW1lbmTDtnJmZmVy
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1u
dm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
