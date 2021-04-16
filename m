Return-Path: <SRS0=jca5=JN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0E9C433ED
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 14:26:37 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5235F610C8
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 14:26:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5235F610C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Ko2ORThJRLp7yU0HNvf8z7Z67VNRHjrjs1AZUVpmgJE=; b=EANWxlVK2k2yOjm6iH5v+uo30
	LCIY0uPxTw8KK5Yd75srgQHRhN6MApYoHS2/hHy+H/JIAJHD010GCLK3rGw0ARZcE+ZV2ow0R/UR1
	1/ikkaHsUpsvEh8VjpiRja0TdecL38lKifgy1+e2fMWrni5Uk0oITdNoVihqisoBCHiJAwFcGDWpM
	bzJwoueLzSf39AAs8lwdk/9TpF1IHIKg67PrEMNy5OeFa9TuZ6biunhp8kSylFA80Br5iWIZgsfDs
	0ltEoe3RjXNhjE8EuNZaLt5T4yE4AdpZ5g0eut/6aSFdQb8KLZuvmiI3C5Yn1rC3H9otaM2Z3WQyl
	4wpZcskyA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lXPQO-002Oo2-If; Fri, 16 Apr 2021 14:26:24 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXPQM-002OnU-17
 for linux-nvme@desiato.infradead.org; Fri, 16 Apr 2021 14:26:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=v2VhDlYezg8mzK1DPEvNuQm5aRz+baQOQ4+DktV2/34=; b=bgKihBHLdUXaLlqJR/k/gGKt5y
 vrnARw9UdGEQWxR4EulE4zxifZhuaWqueDl8oBKw1RxItTyuf6MIR7vrjm78nUh0E3qjcQeEhHlAi
 JwHpPI/uh02BCwMaIbJRWtZRQyBKJmleNjqz6Rgr/fF33O0lHslLmtc8aVwHpp5dgb80dRUn6BNpC
 x8SFqb72Q6XYsLvjRqeZDZ3FzIT0WbIg0ntsurrRzzCoYQrgwTyFxuNgv2XRuYwwCo+gq/6Hjv0PH
 AxBDe2cyTevNflRXkULSpXmGywjrza7eaYxWMtlwn2eBwvih1EOMrf/TC88CNUwHeEnajDyWzvLP/
 OjrPh+2Q==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXPQJ-009ROa-Cp
 for linux-nvme@lists.infradead.org; Fri, 16 Apr 2021 14:26:20 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id F246DAF11;
 Fri, 16 Apr 2021 14:26:17 +0000 (UTC)
Subject: Re: [PATCH 0/1] Add Host Transport Interface option (host-triface)
To: "Belanger, Martin" <Martin.Belanger@dell.com>,
 James Smart <jsmart2021@gmail.com>, Martin Belanger <nitram_67@hotmail.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
References: <BL0PR13MB429178ADAA0C3C8AA2AA05379C4D9@BL0PR13MB4291.namprd13.prod.outlook.com>
 <f693d139-2a3d-a780-9e15-9ab130cdab3f@gmail.com>
 <SJ0PR19MB4544D7B102BC3A957B57A780F24C9@SJ0PR19MB4544.namprd19.prod.outlook.com>
From: Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <c6fad890-475d-2f8d-dc0d-40c1c60e9007@suse.de>
Date: Fri, 16 Apr 2021 16:26:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <SJ0PR19MB4544D7B102BC3A957B57A780F24C9@SJ0PR19MB4544.namprd19.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210416_072619_600700_5D20100B 
X-CRM114-Status: GOOD (  18.53  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gNC8xNi8yMSAyOjQxIEFNLCBCZWxhbmdlciwgTWFydGluIHdyb3RlOgo+IFJlLXNlbmRpbmcg
aW4gUGxhaW4gVGV4dCBtb2RlLgo+IAo+IEhpIEphbWVzLAo+IAo+IFdpdGggSE9TVF9UUkFERFIs
IHdlIHVzZSBiaW5kKCkgdG8gYmluZCB0byBhbiBhZGRyZXNzIGp1c3QgYmVmb3JlIGludm9raW5n
IGNvbm5lY3QoKS4gSSBhbHNvIHVzZWQKPiB0byB0aGluayB0aGF0IHRoaXMgd2FzIHRoZSB3YXkg
dG8gZm9yY2UgcGFja2V0cyB0byBiZSByb3V0ZWQgb250byB0aGUgaW50ZXJmYWNlIG1hdGNoaW5n
IHRoZSBhZGRyZXNzCj4gdXNlZCBpbiB0aGUgYmluZCgpLiBCdXQgdGhhdCBpcyBub3QgdGhlIGNh
c2UgKEkgdGVzdGVkIGl0KS4gYmluZCgpIGRvZXMgbm90IGNvbnRyb2wgdGhlIHJvdXRpbmcKPiBv
ZiB0cmFuc21pdHRlZCBwYWNrZXRzLiBUaGUgb25seSB0aGluZyB0aGF0IGJpbmQoKSBkb2VzIGlz
IHRvIHNldCB0aGUgc291cmNlIGFkZHJlc3Mgb24gdGhlIHNvY2tldAo+IHNvIHRoYXQgd2hlbiBh
IHJlbW90ZSBwcm9jZXNzIHF1ZXJpZXMgdGhlIHBlZXIgYWRkcmVzcyAoZ2V0cGVlcm5hbWUpLCBp
dCB3aWxsIHNlZSB0aGF0IGFkZHJlc3MgYXMKPiB0aGUgc291cmNlIGFkZHJlc3MuCj4gCj4gSXQn
cyBvbmx5IGEgc2V0c29ja29wdCgpIHdpdGggU09fQklORFRPREVWSUNFIHRoYXQgY2FuIGZvcmNl
IHBhY2tldHMgdG8gZ28gb3V0IG9uIGEgc3BlY2lmaWMKPiBpbnRlcmZhY2UgKEkgdGVzdGVkIHRo
YXQgYXMgd2VsbCkuCj4KSG1tLiBCdXQgYXJndWFibHkgdGhpcyB3YXMgd2hhdCAnaG9zdF90cmFk
ZHInIHdhcyBzdXBwb3NlZCB0byBhY2hpZXZlLgpJZiB5b3UgY29tcGFyZSBjb21taXQgOGY0ZThk
YWNlM2QxICgibnZtZS1yZG1hOiBhZGQgc3VwcG9ydCBmb3IKaG9zdF90cmFkZHIiKSBpdCBjbGVh
cmx5IHN0YXRlcyB0aGF0IHRoZSByZXF1ZXN0IHNob3VsZCBiZSBfc2VuZF8gdmlhCnRoZSBpbnRl
cmZhY2Ugc3BlY2lmaWVkIHdpdGggaG9zdF90cmFkZHIuClNvIGluIHRoZSBsaWdodCBvZiB0aGlz
IEknZCByYXRoZXIgbW9kaWZ5IHRoZSBjdXJyZW50IGhhbmRsaW5nIG9mCmhvc3RfdHJhZGRyIGZv
ciB0Y3AuCgpVbmxlc3MgdGhpcyB3YXMgaW50ZW50aW9uYWxseSBjb2RlZCB0aGlzIHdheS4gU2Fn
aT8KCkNoZWVycywKCkhhbm5lcwotLSAKRHIuIEhhbm5lcyBSZWluZWNrZQkJICAgICAgICBLZXJu
ZWwgU3RvcmFnZSBBcmNoaXRlY3QKaGFyZUBzdXNlLmRlCQkJICAgICAgICAgICAgICAgKzQ5IDkx
MSA3NDA1MyA2ODgKU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR2VybWFueSBHbWJILCA5MDQwOSBO
w7xybmJlcmcKR0Y6IEYuIEltZW5kw7ZyZmZlciwgSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1l
IG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
