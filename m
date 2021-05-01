Return-Path: <SRS0=FZGd=J4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30DFFC433B4
	for <linux-nvme@archiver.kernel.org>; Sat,  1 May 2021 11:36:29 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC4D3613F2
	for <linux-nvme@archiver.kernel.org>; Sat,  1 May 2021 11:36:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC4D3613F2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=HT0Zi94K4Z9DZ3hFwI6a1Ge46yenCPFP+X5RyuLoJYM=; b=oxF3RXeo2vxL/n/a27dpPOGhV
	3wNDstY56X/gHRDS2TLxEY0TxlNup5oQLaQ3eViLYu/rb1CzlyrezjCwZKNVJDExPQsAItRbhfoX2
	uzRAndMOgqD/CwI6s3dZnM7LWGua0O71tWxOdO6Ric9jwhDgmVlMWEP0QD6rPWuyfSPu/a5UQSm/k
	3nCJsrEIqN771B4tPaTuXjn6mUqor7oIoNzF0SBmwrmgugRoCGK+/0Ss8yVyWIBsLN49QqlheLEa+
	5sbIy15g0khApBcqBNUgMMhbsIpzn9S5CO98dxCpgSiMHRbiC7ZJnZsp8hRp8X8B/fVrjM/+6vsvH
	oHcKMbeQA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lcnv0-009xcc-Rf; Sat, 01 May 2021 11:36:19 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lcnux-009xcS-VA
 for linux-nvme@desiato.infradead.org; Sat, 01 May 2021 11:36:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=8mJxUhIanjhn6Vlf3T4ATiqhxDrEkGCtglE9wu351WE=; b=r28PUEK2y2geEdpBBbdrezvNtF
 1ZoL3gfsFzjK/yFWBrVf2S4oQtBiJvEln5WgUzEqlUwIK+Mr7nMAGbktc6vI1llcv+vcjj53L2zWK
 ATsgw8XezW4UIq4e83yQNnEruT8klSBLZBTurIMbaNyexSBWvPiphiQVd0ilx1hBJMvsWEw+ktNVn
 Y9DjrysMN9gTADMC3nT1A9DQL3xoXyhGgn1uAxjKN2DUp8h9W9/u/DTe6hBc2SPIqdJRUuGjGZI+u
 8GY1CRFVeCUGh7Xa14VyJf9hGJRg2SV8A7o2fZ5ST5oUsJ5ExMRvdMLO9Prn2zBWxN3KXpVso8+CT
 5hQp8wGQ==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lcnuv-001xjL-Dr
 for linux-nvme@lists.infradead.org; Sat, 01 May 2021 11:36:14 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 1F404B139;
 Sat,  1 May 2021 11:36:12 +0000 (UTC)
Subject: Re: [PATCH] nvme: do not try to reconfigure APST when the controller
 is not live
To: Christoph Hellwig <hch@lst.de>, sagi@grimberg.me, kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org, Peng Liu <liupeng17@lenovo.com>
References: <20210409094905.1920747-1-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <79605e56-4e35-4112-11ba-4b6ca9baffef@suse.de>
Date: Sat, 1 May 2021 13:36:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210409094905.1920747-1-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210501_043613_636170_A33810AF 
X-CRM114-Status: GOOD (  20.97  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gNC85LzIxIDExOjQ5IEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPiBEbyBub3QgY2Fs
bCBudm1lX2NvbmZpZ3VyZV9hcHN0IHdoZW4gdGhlIGNvbnRyb2xsZXIgaXMgbm90IGxpdmUsIGdp
dmVuCj4gdGhhdCBudm1lX2NvbmZpZ3VyZV9hcHN0IHdpbGwgZmFpbCBkdWUgdGhlIGxhY2sgb2Yg
YW4gYWRtaW4gcXVldWUgd2hlbgo+IHRoZSBjb250cm9sbGVyIGlzIGJlaW5nIHRvcm4gZG93biBh
bmQgbnZtZV9zZXRfbGF0ZW5jeV90b2xlcmFuY2UgaXMKPiBjYWxsZWQgZnJvbSBkZXZfcG1fcW9z
X2hpZGVfbGF0ZW5jeV90b2xlcmFuY2UuCj4gCj4gRml4ZXM6IDUxMGE0MDVkOTQ1YigibnZtZTog
Zml4IG1lbW9yeSBsZWFrIGZvciBwb3dlciBsYXRlbmN5IHRvbGVyYW5jZSIpCj4gUmVwb3J0ZWQt
Ynk6IFBlbmcgTGl1IDxsaXVwZW5nMTdAbGVub3ZvLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBDaHJp
c3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4KPiAtLS0KPiAgIGRyaXZlcnMvbnZtZS9ob3N0L2Nv
cmUuYyB8IDMgKystCj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYyBiL2RyaXZl
cnMvbnZtZS9ob3N0L2NvcmUuYwo+IGluZGV4IDYzYTFlNmNjMjdhY2FiLi5mM2M3YjFjYjJjN2M4
YyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMKPiArKysgYi9kcml2ZXJz
L252bWUvaG9zdC9jb3JlLmMKPiBAQCAtMjc0MCw3ICsyNzQwLDggQEAgc3RhdGljIHZvaWQgbnZt
ZV9zZXRfbGF0ZW5jeV90b2xlcmFuY2Uoc3RydWN0IGRldmljZSAqZGV2LCBzMzIgdmFsKQo+ICAg
Cj4gICAJaWYgKGN0cmwtPnBzX21heF9sYXRlbmN5X3VzICE9IGxhdGVuY3kpIHsKPiAgIAkJY3Ry
bC0+cHNfbWF4X2xhdGVuY3lfdXMgPSBsYXRlbmN5Owo+IC0JCW52bWVfY29uZmlndXJlX2Fwc3Qo
Y3RybCk7Cj4gKwkJaWYgKGN0cmwtPnN0YXRlID09IE5WTUVfQ1RSTF9MSVZFKQo+ICsJCQludm1l
X2NvbmZpZ3VyZV9hcHN0KGN0cmwpOwo+ICAgCX0KPiAgIH0KPiAgIAo+IApSZXZpZXdlZC1ieTog
SGFubmVzIFJlaW5lY2tlIDxoYXJlQHN1c2UuZGU+CgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBI
YW5uZXMgUmVpbmVja2UgICAgICAgICAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0Cmhh
cmVAc3VzZS5kZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4
ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJu
YmVyZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdlc2Now6RmdHNmw7xocmVyOiBGZWxpeCBJ
bWVuZMO2cmZmZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9y
ZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
