Return-Path: <SRS0=zrHs=64=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E59FC433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 14 May 2020 06:18:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE4C920575
	for <linux-nvme@archiver.kernel.org>; Thu, 14 May 2020 06:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OyqesbmF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE4C920575
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=v2sBhZw3rBkdZXV446nr1qx8LZrRkgqA9gP6HDYK5pk=; b=OyqesbmFN33v80UrX6MxN/H0p
	jkb9OzotlWkHvN8vs9tRm/PCZN5P27R2y4PqFVI6XggFESLOZNpHdwadDozjA4fZ/m8KV+ptp48Ps
	nIfX2qb6KDiOQBJ5k4o43ONsAOINjk60KBR5hAt9d3Ncgceg3la2M6VeBs1Aov6ZFT70FFMu8C9qI
	pyDB3UyBuEDAJI1lHCn8bHdfMJ9VneGX9ctdkczLynYwfTVHsQKUiflzc4oQfNS5L9H/CIAtGKTQU
	o1QXV7SF9JwG1a6Zrpxo1qQpmI+n1d78Zm+ZVpYvSVZR6l9onJMlNr7iyJenWZOej/CoZNOo1yRpT
	iwuOsgIVQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jZ7CY-0002sw-1W; Thu, 14 May 2020 06:18:38 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jZ7CV-0002sD-IC
 for linux-nvme@lists.infradead.org; Thu, 14 May 2020 06:18:37 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id B6D5DABD0;
 Thu, 14 May 2020 06:18:36 +0000 (UTC)
Subject: Re: [PATCH v2] nvme: Fix io_opt limit setting
To: Damien Le Moal <damien.lemoal@wdc.com>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>
References: <20200514055626.1111729-1-damien.lemoal@wdc.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <b7d1fc3e-342f-310f-ad20-fa4076581236@suse.de>
Date: Thu, 14 May 2020 08:18:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200514055626.1111729-1-damien.lemoal@wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200513_231835_750919_2AD3BF3A 
X-CRM114-Status: GOOD (  25.80  )
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
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gNS8xNC8yMCA3OjU2IEFNLCBEYW1pZW4gTGUgTW9hbCB3cm90ZToKPiBDdXJyZW50bHksIGEg
bmFtZXNwYWNlIGlvX29wdCBxdWV1ZSBsaW1pdCBpcyBzZXQgYnkgZGVmYXVsdCB0byB0aGUKPiBw
aHlzaWNhbCBzZWN0b3Igc2l6ZSBvZiB0aGUgbmFtZXNwYWNlIGFuZCB0byB0aGUgdGhlIHdyaXRl
IG9wdGltYWwKPiBzaXplIChOT1dTKSB3aGVuIHRoZSBuYW1lc3BhY2UgcmVwb3J0cyBvcHRpbWFs
IElPIHNpemVzLiBUaGlzIGNhdXNlcwo+IHByb2JsZW1zIHdpdGggYmxvY2sgbGltaXRzIHN0YWNr
aW5nIGluIGJsa19zdGFja19saW1pdHMoKSB3aGVuIGEKPiBuYW1lc3BhY2UgYmxvY2sgZGV2aWNl
IGlzIGNvbWJpbmVkIHdpdGggYW4gSEREIHdoaWNoIGdlbmVyYWxseSBkbyBub3QKPiByZXBvcnQg
YW55IG9wdGltYWwgdHJhbnNmZXIgc2l6ZSAoaW9fb3B0IGxpbWl0IGlzIDApLiBUaGUgY29kZToK
PiAKPiAvKiBPcHRpbWFsIEkvTyBhIG11bHRpcGxlIG9mIHRoZSBwaHlzaWNhbCBibG9jayBzaXpl
PyAqLwo+IGlmICh0LT5pb19vcHQgJiAodC0+cGh5c2ljYWxfYmxvY2tfc2l6ZSAtIDEpKSB7Cj4g
CXQtPmlvX29wdCA9IDA7Cj4gCXQtPm1pc2FsaWduZWQgPSAxOwo+IAlyZXQgPSAtMTsKPiB9Cj4g
Cj4gaW4gYmxrX3N0YWNrX2xpbWl0cygpIHJlc3VsdHMgaW4gYW4gZXJyb3IgcmV0dXJuIGZvciB0
aGlzIGZ1bmN0aW9uIHdoZW4KPiB0aGUgY29tYmluZWQgZGV2aWNlcyBoYXZlIGRpZmZlcmVudCBi
dXQgY29tcGF0aWJsZSBwaHlzaWNhbCBzZWN0b3IKPiBzaXplcyAoZS5nLiA1MTJCIHNlY3RvciBT
U0Qgd2l0aCA0S0Igc2VjdG9yIGRpc2tzKS4KPiAKPiBGaXggdGhpcyBieSBub3Qgc2V0dGluZyB0
aGUgb3B0aW1hbCBJTyBzaXplIHF1ZXVlIGxpbWl0IGlmIHRoZSBuYW1lc3BhY2UKPiBkb2VzIG5v
dCByZXBvcnQgYW4gb3B0aW1hbCB3cml0ZSBzaXplIHZhbHVlLgo+IAo+IFNpZ25lZC1vZmYtYnk6
IERhbWllbiBMZSBNb2FsIDxkYW1pZW4ubGVtb2FsQHdkYy5jb20+Cj4gLS0tCj4gCj4gKiBDaGFu
Z2VzIGZyb20gdjE6Cj4gICAgLSBSZWJhc2VkIG9uIG52bWUvbnZtZS01LjggdHJlZQo+IAo+ICAg
ZHJpdmVycy9udm1lL2hvc3QvY29yZS5jIHwgNCArKy0tCj4gICAxIGZpbGUgY2hhbmdlZCwgMiBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252
bWUvaG9zdC9jb3JlLmMgYi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMKPiBpbmRleCA4MDVkMjg5
ZTZjZDkuLjk1MWQ1NThkYzY2MiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC9jb3Jl
LmMKPiArKysgYi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMKPiBAQCAtMTg0Miw3ICsxODQyLDcg
QEAgc3RhdGljIHZvaWQgbnZtZV91cGRhdGVfZGlza19pbmZvKHN0cnVjdCBnZW5kaXNrICpkaXNr
LAo+ICAgewo+ICAgCXNlY3Rvcl90IGNhcGFjaXR5ID0gbnZtZV9sYmFfdG9fc2VjdChucywgbGU2
NF90b19jcHUoaWQtPm5zemUpKTsKPiAgIAl1bnNpZ25lZCBzaG9ydCBicyA9IDEgPDwgbnMtPmxi
YV9zaGlmdDsKPiAtCXUzMiBhdG9taWNfYnMsIHBoeXNfYnMsIGlvX29wdDsKPiArCXUzMiBhdG9t
aWNfYnMsIHBoeXNfYnMsIGlvX29wdCA9IDA7Cj4gICAKPiAgIAlpZiAobnMtPmxiYV9zaGlmdCA+
IFBBR0VfU0hJRlQpIHsKPiAgIAkJLyogdW5zdXBwb3J0ZWQgYmxvY2sgc2l6ZSwgc2V0IGNhcGFj
aXR5IHRvIDAgbGF0ZXIgKi8KPiBAQCAtMTg1MSw3ICsxODUxLDcgQEAgc3RhdGljIHZvaWQgbnZt
ZV91cGRhdGVfZGlza19pbmZvKHN0cnVjdCBnZW5kaXNrICpkaXNrLAo+ICAgCWJsa19tcV9mcmVl
emVfcXVldWUoZGlzay0+cXVldWUpOwo+ICAgCWJsa19pbnRlZ3JpdHlfdW5yZWdpc3RlcihkaXNr
KTsKPiAgIAo+IC0JYXRvbWljX2JzID0gcGh5c19icyA9IGlvX29wdCA9IGJzOwo+ICsJYXRvbWlj
X2JzID0gcGh5c19icyA9IGJzOwo+ICAgCW52bWVfc2V0dXBfc3RyZWFtc19ucyhucy0+Y3RybCwg
bnMsICZwaHlzX2JzLCAmaW9fb3B0KTsKPiAgIAlpZiAoaWQtPm5hYm8gPT0gMCkgewo+ICAgCQkv
Kgo+IApSZXZpZXdlZC1ieTogSGFubmVzIFJlaW5lY2tlIDxoYXJlQHN1c2UuZGU+CgpDaGVlcnMs
CgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2UgICAgICAgICAgICBUZWFtbGVhZCBTdG9y
YWdlICYgTmV0d29ya2luZwpoYXJlQHN1c2UuZGUgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR21iSCwgTWF4ZmVs
ZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnCkhSQiAzNjgwOSAoQUcgTsO8cm5iZXJnKSwgR2VzY2jD
pGZ0c2bDvGhyZXI6IEZlbGl4IEltZW5kw7ZyZmZlcgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KbGludXgtbnZtZSBtYWlsaW5nIGxpc3QKbGludXgtbnZt
ZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8vbGludXgtbnZtZQo=
