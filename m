Return-Path: <SRS0=mUlG=GL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 938FCC433DB
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Jan 2021 11:23:30 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D0AC235FC
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Jan 2021 11:23:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D0AC235FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Qzt6KTd2pvKUg1ZptORbmDfoxMg5LCBX35mzt0USCDs=; b=Y/z6jyuqHB5ynoJIaqsziHXtp
	tS8x34xhKB3lXYuf/VAIRaFo6+FgDTCIxR170oPU0tprKWy+Wk5ORGLPnqXua2iOee1dW9xmISw5K
	XCjOPF20RsiL4NG7R0YVMLy5W4+W7U8lg7NKXPLU4mgoSwIem8kv1/VC/IkgAa8paVT7kw94lvpnx
	1vxQdqCuKusyDf8IRGqyiDQEg2RN3c4TF2x6eJJk3uWBW9IwLDftIqL5/ZCufPxiv6iIXCB3bt/y5
	5bnv/UpCyaBH9Lz5froXC3Bmga6XwDopcqW5IoX9wvt0BsRYiCuBiz/o4yrHscIau9mAqcmlE2abw
	OWymnRA/A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kxprY-0004hJ-6h; Fri, 08 Jan 2021 11:23:24 +0000
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kxprT-0004fM-SR
 for linux-nvme@lists.infradead.org; Fri, 08 Jan 2021 11:23:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1610104996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F5evQhgp/eDWRIxXqAVG/hoxLKS4i8PTMG7Ceb3X7kM=;
 b=FkbIcbwl5Tqjepe3G9O4z0GGZTt6XS8hIWQFpTRESm4s8s3DDQJSnCN3LXYN+RzvPI+n3I
 di7k5AaMEORk2SVA9/r+ZzZ8C+cZaZ+XRTEw7b0urmVMYXklzqaRPmsz6tsmFj2ACx0CIU
 wHFwvXfq6Mn6nu7jMYzmBsxok8KGaIM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-QIL7nXPaNqSYSfN8KzInAQ-1; Fri, 08 Jan 2021 06:23:12 -0500
X-MC-Unique: QIL7nXPaNqSYSfN8KzInAQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62D9B800D53;
 Fri,  8 Jan 2021 11:23:11 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-74.pek2.redhat.com [10.72.12.74])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DCDE76062F;
 Fri,  8 Jan 2021 11:23:07 +0000 (UTC)
Subject: Re: [PATCH] nvme-tcp: Fix possible race of io_work and direct send
To: Or Gerlitz <gerlitz.or@gmail.com>, Sagi Grimberg <sagi@grimberg.me>
References: <20201221080339.945164-1-sagi@grimberg.me>
 <CAJ3xEMj8Y_=Y=orV59GR9=L4M3r4+mZzMW6w2cv2K9d5eKXZDA@mail.gmail.com>
From: Yi Zhang <yi.zhang@redhat.com>
Message-ID: <041e694c-b3bf-a79a-3397-93ab96275f3a@redhat.com>
Date: Fri, 8 Jan 2021 19:23:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAJ3xEMj8Y_=Y=orV59GR9=L4M3r4+mZzMW6w2cv2K9d5eKXZDA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yi.zhang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210108_062320_000018_1F8C52CF 
X-CRM114-Status: GOOD (  24.95  )
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
Cc: Keith Busch <kbusch@kernel.org>, Boris Pismenny <borispismenny@gmail.com>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Ben Ben-ishay <benishay@mellanox.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiAxLzgvMjEgMzowNSBBTSwgT3IgR2VybGl0eiB3cm90ZToKPiBPbiBNb24sIERlYyAyMSwg
MjAyMCBhdCAxMDowNiBBTSBTYWdpIEdyaW1iZXJnIDxzYWdpQGdyaW1iZXJnLm1lPiB3cm90ZToK
Pj4gV2UgbWF5IHNlbmQgYSByZXF1ZXN0ICh3aXRoIG9yIHdpdGhvdXQgaXRzIGRhdGEpIGZyb20g
dHdvIHBhdGhzOgo+PiAxLiBGcm9tIG91ciBJL08gY29udGV4dCBudm1lX3RjcF9pb193b3JrIHdo
aWNoIGlzIHRyaWdnZXJlZCBmcm9tOgo+PiAtIHF1ZXVlX3JxCj4+IC0gcjJ0IHJlY2VwdGlvbgo+
PiAtIHNvY2tldCBkYXRhX3JlYWR5IGFuZCB3cml0ZV9zcGFjZSBjYWxsYmFja3MKPj4gMi4gRGly
ZWN0bHkgZnJvbSBxdWV1ZV9ycSBpZiB0aGUgc2VuZF9saXN0IGlzIGVtcHR5IChiZWNhdXNlCj4+
IHdlIHdhbnQgdG8gc2F2ZSB0aGUgY29udGV4dCBzd2l0Y2ggYXNzb2NpYXRlZCB3aXRoIHNjaGVk
dWxpbmcKPj4gb3VyIGlvX3dvcmspLgo+PiBGaXhlczogZGI1YWQ2YjdmOGNkICgibnZtZS10Y3A6
IHRyeSB0byBzZW5kIHJlcXVlc3QgaW4gcXVldWVfcnEgY29udGV4dCIpCj4+IFJlcG9ydGVkLWJ5
OiBQb3RudXJpIEJoYXJhdCBUZWphIDxiaGFyYXRAY2hlbHNpby5jb20+Cj4+IFJlcG9ydGVkLWJ5
OiBTYW11ZWwgSm9uZXMgPHNqb25lc0BrYWxyYXlpbmMuY29tPgo+PiAtLS0gYS9kcml2ZXJzL252
bWUvaG9zdC90Y3AuYwo+PiArKysgYi9kcml2ZXJzL252bWUvaG9zdC90Y3AuYwo+PiBAQCAtMjc5
LDcgKzI4OSw3IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBudm1lX3RjcF9xdWV1ZV9yZXF1ZXN0KHN0
cnVjdCBudm1lX3RjcF9yZXF1ZXN0ICpyZXEsCj4+ICAgICAgICAgIGlmIChxdWV1ZS0+aW9fY3B1
ID09IHNtcF9wcm9jZXNzb3JfaWQoKSAmJgo+PiAgICAgICAgICAgICAgc3luYyAmJiBlbXB0eSAm
JiBtdXRleF90cnlsb2NrKCZxdWV1ZS0+c2VuZF9tdXRleCkpIHsKPiBidXQgd2UgY2FuJ3QgcmVs
eSBvbiB0aGUgcHJvY2Vzc29yIGlkIGlmIHdlIGFyZSBvbiBwcmVlbXB0aWJsZSBzdGF0ZS4uCj4K
PiAgICAzNzMuOTQwMzM2XSBCVUc6IHVzaW5nIHNtcF9wcm9jZXNzb3JfaWQoKSBpbiBwcmVlbXB0
aWJsZSBbMDAwMDAwMDBdCj4gY29kZToga3dvcmtlci91ODo0LzQ1Nwo+IFsgIDM3My45NDIwMzdd
IGNhbGxlciBpcyBudm1lX3RjcF9zdWJtaXRfYXN5bmNfZXZlbnQrMHg0ZGEvMHg2OTAgW252bWVf
dGNwXQo+IFsgIDM3My45NDIxNDRdIENQVTogMCBQSUQ6IDQ1NyBDb21tOiBrd29ya2VyL3U4OjQg
Tm90IHRhaW50ZWQgNS4xMS4wLXJjMSsgIzExNgo+IFsgIDM3My45NDIxNzFdIEhhcmR3YXJlIG5h
bWU6IFFFTVUgU3RhbmRhcmQgUEMgKGk0NDBGWCArIFBJSVgsIDE5OTYpLAo+IEJJT1MgcmVsLTEu
MTIuMS0wLWdhNWNhYjU4ZTlhM2YtcHJlYnVpbHQucWVtdS5vcmcgMDQvMDEvMjAxNAo+IFsgIDM3
My45NDIxOTZdIFdvcmtxdWV1ZTogbnZtZS13cSBudm1lX2FzeW5jX2V2ZW50X3dvcmsgW252bWVf
Y29yZV0KPiBbICAzNzMuOTQyMjU5XSBDYWxsIFRyYWNlOgo+IFsgIDM3My45NDIyODZdICBkdW1w
X3N0YWNrKzB4ZDAvMHgxMTkKPiBbICAzNzMuOTQyMzQ2XSAgY2hlY2tfcHJlZW1wdGlvbl9kaXNh
YmxlZCsweGVjLzB4ZjAKPiBbICAzNzMuOTQyMzk3XSAgbnZtZV90Y3Bfc3VibWl0X2FzeW5jX2V2
ZW50KzB4NGRhLzB4NjkwIFtudm1lX3RjcF0KPiBbICAzNzMuOTQyNDQ5XSAgbnZtZV9hc3luY19l
dmVudF93b3JrKzB4MTFkLzB4MWYwIFtudm1lX2NvcmVdCj4gWyAgMzczLjk0MjQ5Nl0gID8gbnZt
ZV9jdHJsX2xvc3NfdG1vX3Nob3crMHgxNDAvMHgxNDAgW252bWVfY29yZV0KPiBbICAzNzMuOTQy
NTc2XSAgcHJvY2Vzc19vbmVfd29yaysweDlmMy8weDE2MzAKPiBbICAzNzMuOTQyNjQ5XSAgPyBw
d3FfZGVjX25yX2luX2ZsaWdodCsweDMzMC8weDMzMAo+IFsgIDM3My45NDI3NjVdICB3b3JrZXJf
dGhyZWFkKzB4OWUvMHhmNjAKPiBbICAzNzMuOTQyODQ5XSAgPyBwcm9jZXNzX29uZV93b3JrKzB4
MTYzMC8weDE2MzAKPiBbICAzNzMuOTQyODg5XSAga3RocmVhZCsweDM2Mi8weDQ4MAo+IFsgIDM3
My45NDI5MThdICA/IGt0aHJlYWRfY3JlYXRlX29uX25vZGUrMHgxMDAvMHgxMDAKPgo+ICAgICAg
ICAgLyoKPiArICAgICAgICAqIGlmIHdlJ3JlIHRoZSBmaXJzdCBvbiB0aGUgc2VuZF9saXN0IGFu
ZCB3ZSBjYW4gdHJ5IHRvIHNlbmQKPiArICAgICAgICAqIGRpcmVjdGx5LCBvdGhlcndpc2UgcXVl
dWUgaW9fd29yay4gQWxzbywgb25seSBkbyB0aGF0IGlmIHdlCj4gKyAgICAgICAgKiBhcmUgb24g
dGhlIHNhbWUgY3B1LCBzbyB3ZSBkb24ndCBpbnRyb2R1Y2UgY29udGVudGlvbi4KPiArICAgICAg
ICAqLwo+ICsgICAgICAgaWYgKHF1ZXVlLT5pb19jcHUgPT0gc21wX3Byb2Nlc3Nvcl9pZCgpICYm
Cj4gKyAgICAgICAgICAgc3luYyAmJiBlbXB0eSAmJiBtdXRleF90cnlsb2NrKCZxdWV1ZS0+c2Vu
ZF9tdXRleCkpIHsKPiArICAgICAgICAgICAgICAgbnZtZV90Y3BfdHJ5X3NlbmQocXVldWUpOwo+
ICsgICAgICAgICAgICAgICBtdXRleF91bmxvY2soJnF1ZXVlLT5zZW5kX211dGV4KTsKPiArICAg
ICAgIH0gZWxzZSB7Cj4gKyAgICAgICAgICAgICAgIHF1ZXVlX3dvcmtfb24ocXVldWUtPmlvX2Nw
dSwgbnZtZV90Y3Bfd3EsICZxdWV1ZS0+aW9fd29yayk7Cj4gKyAgICAgICB9Cj4KPiBzbyBiZWZv
cmUgdGhpcyBwYXRjaCB0aGF0IGNoZWNrIHdhcyBub3QgbmVlZGVkPyBJIHdhcyBub3Qgc3VyZSBy
ZSBhbGwKPiB0aGUgaW52b2x2ZWQgY29udGV4dHMgYW5kIGhvdyB0byBmaXggdGhhdC4uIHNvIGp1
c3Qgc2VuZGluZyB0aGUgcmVwb3J0ClllYWgsIEkgbWV0IHNpbWlsYXIgaXNzdWUgYWZ0ZXIgZW5h
YmxlIFBSRUVNUFQuCgpbwqAgMTM1LjI4NTM2Nl0gcnVuIGJsa3Rlc3RzIG52bWUvMDAzIGF0IDIw
MjEtMDEtMDggMDY6MTM6MDQKW8KgIDEzNS4zNTg0NTddIGxvb3A6IG1vZHVsZSBsb2FkZWQKW8Kg
IDEzNS4zNjg2MDddIG52bWV0OiBhZGRpbmcgbnNpZCAxIHRvIHN1YnN5c3RlbSBibGt0ZXN0cy1z
dWJzeXN0ZW0tMQpbwqAgMTM1LjM2OTU2OF0gbnZtZXRfdGNwOiBlbmFibGluZyBwb3J0IDAgKDEy
Ny4wLjAuMTo0NDIwKQpbwqAgMTM1LjM3NDI2MV0gbnZtZXQ6IGNyZWF0aW5nIGNvbnRyb2xsZXIg
MSBmb3Igc3Vic3lzdGVtIApucW4uMjAxNC0wOC5vcmcubnZtZXhwcmVzcy5kaXNjb3ZlcnkgZm9y
IE5RTiAKbnFuLjIwMTQtMDgub3JnLm52bWV4cHJlc3M6dXVpZDowZDJlODc5Yy05ZWZiLTQwMjYt
YTgyZS00NTBlNDI4MzE3NWUuClvCoCAxMzUuMzc0MzgxXSBudm1lIG52bWUwOiBuZXcgY3RybDog
TlFOIAoibnFuLjIwMTQtMDgub3JnLm52bWV4cHJlc3MuZGlzY292ZXJ5IiwgYWRkciAxMjcuMC4w
LjE6NDQyMApbwqAgMTM1LjM3NDM4Ml0gQlVHOiB1c2luZyBzbXBfcHJvY2Vzc29yX2lkKCkgaW4g
cHJlZW1wdGlibGUgWzAwMDAwMDAwXSAKY29kZToga3dvcmtlci91NjQ6MTgvMTg3ClvCoCAxMzUu
Mzc0Mzg3XSBjYWxsZXIgaXMgbnZtZV90Y3Bfc3VibWl0X2FzeW5jX2V2ZW50KzB4MTExLzB4MTQw
IFtudm1lX3RjcF0KW8KgIDEzNS4zODk1MThdIENQVTogMzEgUElEOiAxODcgQ29tbToga3dvcmtl
ci91NjQ6MTggVGFpbnRlZDogRyBTwqDCoMKgwqDCoMKgwqAgCknCoMKgwqDCoMKgwqAgNS4xMS4w
LXJjMi52MSAjMgpbwqAgMTM1LjM5ODEyMV0gSGFyZHdhcmUgbmFtZTogRGVsbCBJbmMuIFBvd2Vy
RWRnZSBSNjQwLzA2TlI4MiwgQklPUyAKMi4xMC4wIDExLzEyLzIwMjAKW8KgIDEzNS40MDU2ODhd
IFdvcmtxdWV1ZTogbnZtZS13cSBudm1lX2FzeW5jX2V2ZW50X3dvcmsgW252bWVfY29yZV0KW8Kg
IDEzNS40MTE3MDRdIENhbGwgVHJhY2U6ClvCoCAxMzUuNDE0MTU3XcKgIGR1bXBfc3RhY2srMHg1
Ny8weDZhClvCoCAxMzUuNDE3NDc1XcKgIGNoZWNrX3ByZWVtcHRpb25fZGlzYWJsZWQrMHhiNi8w
eGQwClvCoCAxMzUuNDIyMDk0XcKgIG52bWVfdGNwX3N1Ym1pdF9hc3luY19ldmVudCsweDExMS8w
eDE0MCBbbnZtZV90Y3BdClvCoCAxMzUuNDI4MDE0XcKgIG52bWVfYXN5bmNfZXZlbnRfd29yaysw
eDVkLzB4YzAgW252bWVfY29yZV0KW8KgIDEzNS40MzMzMjRdwqAgcHJvY2Vzc19vbmVfd29yaysw
eDFiNi8weDNiMApbwqAgMTM1LjQzNzMzN13CoCB3b3JrZXJfdGhyZWFkKzB4MzAvMHgzNzAKW8Kg
IDEzNS40NDEwMDJdwqAgPyBwcm9jZXNzX29uZV93b3JrKzB4M2IwLzB4M2IwClvCoCAxMzUuNDQ1
MTkwXcKgIGt0aHJlYWQrMHgxM2QvMHgxNjAKW8KgIDEzNS40NDg0MjNdwqAgPyBrdGhyZWFkX3Bh
cmsrMHg4MC8weDgwClvCoCAxMzUuNDUyMDg5XcKgIHJldF9mcm9tX2ZvcmsrMHgxZi8weDMwClvC
oCAxNDUuMzk0OTI3XSBudm1lIG52bWUwOiBSZW1vdmluZyBjdHJsOiBOUU4gCiJucW4uMjAxNC0w
OC5vcmcubnZtZXhwcmVzcy5kaXNjb3ZlcnkiCgoKPiBfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwo+IExpbnV4LW52bWUgbWFpbGluZyBsaXN0Cj4gTGludXgt
bnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCj4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9saW51eC1udm1lCj4KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9saW51eC1udm1lCg==
