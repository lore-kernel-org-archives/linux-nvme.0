Return-Path: <SRS0=morU=AH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88583C433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 15:53:03 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52CED20702
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 15:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="riX8Kb0C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52CED20702
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9PviOccxg+0ab+a9oi8PnJhcTEB35hgGOpqRRom7bA0=; b=riX8Kb0CAZK3Z5WcgPWY6z/6y
	BtMjgmfUGCrf1SiizoxBhtl3nAMHBVpAXESeSxczeVRroLFe37P/FejCB+RVCCqjHKTKRFT8MTvZP
	kpiJZtjIniQd8xGZSYhpydfYuRD5jdioDvICLR2AVZLPBtaIzxq8ZjINpY5gd//s+PjWyKUE6o6Ny
	qkzoq4s3rJnY/oZ068oXSuzBb5XX4QGIHLaE9MLXV99FankjUasf8pFecDwDQQ5q7bZqWGp4deu8s
	6SOHn/h/EMSOKRVoE8aBgr1JqRfs5tqDNhZ3ejrngIYOCT0usBVDhSfqQZ0+W4GDUMBCLjmRHjhj/
	XEgmQxMZA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1joqey-0005W4-GP; Fri, 26 Jun 2020 15:53:00 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1joqet-0005UV-F0
 for linux-nvme@lists.infradead.org; Fri, 26 Jun 2020 15:52:56 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 52918AEFE;
 Fri, 26 Jun 2020 15:52:54 +0000 (UTC)
Subject: Re: [PATCH v3 for-5.8-rc 2/5] nvme-multipath: fix deadlock between
 ana_work and scan_work
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <20200624085312.35967-1-sagi@grimberg.me>
 <20200624085312.35967-3-sagi@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <def0b644-7b28-906e-aef4-f106ba9c7653@suse.de>
Date: Fri, 26 Jun 2020 17:52:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200624085312.35967-3-sagi@grimberg.me>
Content-Language: en-US
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
Cc: Anton Eidelman <anton@lightbitslabs.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gNi8yNC8yMCAxMDo1MyBBTSwgU2FnaSBHcmltYmVyZyB3cm90ZToKPiBGcm9tOiBBbnRvbiBF
aWRlbG1hbiA8YW50b25AbGlnaHRiaXRzbGFicy5jb20+Cj4gCj4gV2hlbiBzY2FuX3dvcmsgY2Fs
bHMgbnZtZV9tcGF0aF9hZGRfZGlzaygpIHRoaXMgaG9sZHMgYW5hX2xvY2sKPiBhbmQgaW52b2tl
cyBudm1lX3BhcnNlX2FuYV9sb2coKSwgd2hpY2ggbWF5IGlzc3VlIElPCj4gaW4gZGV2aWNlX2Fk
ZF9kaXNrKCkgYW5kIGhhbmcgd2FpdGluZyBmb3IgYW4gYWNjZXNzaWJsZSBwYXRoLgo+IFdoaWxl
IG52bWVfbXBhdGhfc2V0X2xpdmUoKSBvbmx5IGNhbGxlZCB3aGVuIG52bWVfc3RhdGVfaXNfbGl2
ZSgpLAo+IGEgdHJhbnNpdGlvbiBtYXkgY2F1c2UgTlZNRV9TQ19BTkFfVFJBTlNJVElPTiBhbmQg
cmVxdWV1ZSB0aGUgSU8uCj4gCj4gSW4gb3JkZXIgdG8gcmVjb3ZlciBhbmQgY29tcGxldGUgdGhl
IElPIGFuYV93b3JrIG9uIHRoZSBzYW1lIGN0cmwKPiBzaG91bGQgYmUgYWJsZSB0byB1cGRhdGUg
dGhlIHBhdGggc3RhdGUgYW5kIHJlbW92ZSBOVk1FX05TX0FOQV9QRU5ESU5HLgo+IAo+IFRoZSBk
ZWFkbG9jayBvY2N1cnMgYmVjYXVzZSBzY2FuX3dvcmsga2VlcHMgaG9sZGluZyBhbmFfbG9jaywK
PiBzbyBhbmFfd29yayBoYW5ncyBbMV0uCj4gCj4gRml4Ogo+IE5vdyBudm1lX21wYXRoX2FkZF9k
aXNrKCkgdXNlcyBudm1lX3BhcnNlX2FuYV9sb2coKSB0byBvYnRhaW4gYSBjb3B5Cj4gb2YgdGhl
IEFOQSBncm91cCBkZXNjLCBhbmQgdGhlbiBjYWxscyBudm1lX3VwZGF0ZV9uc19hbmFfc3RhdGUo
KSB3aXRob3V0Cj4gaG9sZGluZyBhbmFfbG9jay4KPiAKPiBbMV06Cj4ga2VybmVsOiBXb3JrcXVl
dWU6IG52bWUtd3EgbnZtZV9zY2FuX3dvcmsgW252bWVfY29yZV0KPiBrZXJuZWw6IENhbGwgVHJh
Y2U6Cj4ga2VybmVsOiAgX19zY2hlZHVsZSsweDJiOS8weDZjMAo+IGtlcm5lbDogIHNjaGVkdWxl
KzB4NDIvMHhiMAo+IGtlcm5lbDogIGlvX3NjaGVkdWxlKzB4MTYvMHg0MAo+IGtlcm5lbDogIGRv
X3JlYWRfY2FjaGVfcGFnZSsweDQzOC8weDgzMAo+IGtlcm5lbDogIHJlYWRfY2FjaGVfcGFnZSsw
eDEyLzB4MjAKPiBrZXJuZWw6ICByZWFkX2Rldl9zZWN0b3IrMHgyNy8weGMwCj4ga2VybmVsOiAg
cmVhZF9sYmErMHhjMS8weDIyMAo+IGtlcm5lbDogIGVmaV9wYXJ0aXRpb24rMHgxZTYvMHg3MDgK
PiBrZXJuZWw6ICBjaGVja19wYXJ0aXRpb24rMHgxNTQvMHgyNDQKPiBrZXJuZWw6ICByZXNjYW5f
cGFydGl0aW9ucysweGFlLzB4MjgwCj4ga2VybmVsOiAgX19ibGtkZXZfZ2V0KzB4NDBmLzB4NTYw
Cj4ga2VybmVsOiAgYmxrZGV2X2dldCsweDNkLzB4MTQwCj4ga2VybmVsOiAgX19kZXZpY2VfYWRk
X2Rpc2srMHgzODgvMHg0ODAKPiBrZXJuZWw6ICBkZXZpY2VfYWRkX2Rpc2srMHgxMy8weDIwCj4g
a2VybmVsOiAgbnZtZV9tcGF0aF9zZXRfbGl2ZSsweDExOS8weDE0MCBbbnZtZV9jb3JlXQo+IGtl
cm5lbDogIG52bWVfdXBkYXRlX25zX2FuYV9zdGF0ZSsweDVjLzB4NjAgW252bWVfY29yZV0KPiBr
ZXJuZWw6ICBudm1lX3NldF9uc19hbmFfc3RhdGUrMHgxZS8weDMwIFtudm1lX2NvcmVdCj4ga2Vy
bmVsOiAgbnZtZV9wYXJzZV9hbmFfbG9nKzB4YTEvMHgxODAgW252bWVfY29yZV0KPiBrZXJuZWw6
ICBudm1lX21wYXRoX2FkZF9kaXNrKzB4NDcvMHg5MCBbbnZtZV9jb3JlXQo+IGtlcm5lbDogIG52
bWVfdmFsaWRhdGVfbnMrMHgzOTYvMHg5NDAgW252bWVfY29yZV0KPiBrZXJuZWw6ICBudm1lX3Nj
YW5fd29yaysweDI0Zi8weDM4MCBbbnZtZV9jb3JlXQo+IGtlcm5lbDogIHByb2Nlc3Nfb25lX3dv
cmsrMHgxZGIvMHgzODAKPiBrZXJuZWw6ICB3b3JrZXJfdGhyZWFkKzB4MjQ5LzB4NDAwCj4ga2Vy
bmVsOiAga3RocmVhZCsweDEwNC8weDE0MAo+IAo+IGtlcm5lbDogV29ya3F1ZXVlOiBudm1lLXdx
IG52bWVfYW5hX3dvcmsgW252bWVfY29yZV0KPiBrZXJuZWw6IENhbGwgVHJhY2U6Cj4ga2VybmVs
OiAgX19zY2hlZHVsZSsweDJiOS8weDZjMAo+IGtlcm5lbDogIHNjaGVkdWxlKzB4NDIvMHhiMAo+
IGtlcm5lbDogIHNjaGVkdWxlX3ByZWVtcHRfZGlzYWJsZWQrMHhlLzB4MTAKPiBrZXJuZWw6ICBf
X211dGV4X2xvY2suaXNyYS4wKzB4MTgyLzB4NGYwCj4ga2VybmVsOiAgPyBfX3N3aXRjaF90b19h
c20rMHgzNC8weDcwCj4ga2VybmVsOiAgPyBzZWxlY3RfdGFza19ycV9mYWlyKzB4MWFhLzB4NWMw
Cj4ga2VybmVsOiAgPyBrdm1fc2NoZWRfY2xvY2tfcmVhZCsweDExLzB4MjAKPiBrZXJuZWw6ICA/
IHNjaGVkX2Nsb2NrKzB4OS8weDEwCj4ga2VybmVsOiAgX19tdXRleF9sb2NrX3Nsb3dwYXRoKzB4
MTMvMHgyMAo+IGtlcm5lbDogIG11dGV4X2xvY2srMHgyZS8weDQwCj4ga2VybmVsOiAgbnZtZV9y
ZWFkX2FuYV9sb2crMHgzYS8weDEwMCBbbnZtZV9jb3JlXQo+IGtlcm5lbDogIG52bWVfYW5hX3dv
cmsrMHgxNS8weDIwIFtudm1lX2NvcmVdCj4ga2VybmVsOiAgcHJvY2Vzc19vbmVfd29yaysweDFk
Yi8weDM4MAo+IGtlcm5lbDogIHdvcmtlcl90aHJlYWQrMHg0ZC8weDQwMAo+IGtlcm5lbDogIGt0
aHJlYWQrMHgxMDQvMHgxNDAKPiBrZXJuZWw6ICA/IHByb2Nlc3Nfb25lX3dvcmsrMHgzODAvMHgz
ODAKPiBrZXJuZWw6ICA/IGt0aHJlYWRfcGFyaysweDgwLzB4ODAKPiBrZXJuZWw6ICByZXRfZnJv
bV9mb3JrKzB4MzUvMHg0MAo+IAo+IEZpeGVzOiAwZDBiNjYwZjIxNGQgKCJudm1lOiBhZGQgQU5B
IHN1cHBvcnQiKQo+IFNpZ25lZC1vZmYtYnk6IEFudG9uIEVpZGVsbWFuIDxhbnRvbkBsaWdodGJp
dHNsYWJzLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBTYWdpIEdyaW1iZXJnIDxzYWdpQGdyaW1iZXJn
Lm1lPgo+IC0tLQo+ICAgZHJpdmVycy9udm1lL2hvc3QvbXVsdGlwYXRoLmMgfCAyNCArKysrKysr
KysrKysrKysrLS0tLS0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCA4
IGRlbGV0aW9ucygtKQo+IApSZXZpZXdlZC1ieTogSGFubmVzIFJlaW5lY2tlIDxoYXJlQHN1c2Uu
ZGU+CgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2UgICAgICAgICAgICBU
ZWFtbGVhZCBTdG9yYWdlICYgTmV0d29ya2luZwpoYXJlQHN1c2UuZGUgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMg
R21iSCwgTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnCkhSQiAzNjgwOSAoQUcgTsO8cm5i
ZXJnKSwgR2VzY2jDpGZ0c2bDvGhyZXI6IEZlbGl4IEltZW5kw7ZyZmZlcgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxp
c3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
