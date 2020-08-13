Return-Path: <SRS0=x9Yf=BX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C02C433E1
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Aug 2020 15:43:37 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F79B20829
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Aug 2020 15:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lqDe2FU3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gJi7Dflg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F79B20829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=PH7BDEBWpS4zRMqXGeEsHdn0xoWbeQ+8eYmTvs5tuiQ=; b=lqDe2FU3pOdKzUxlaMxx0ebdh
	uWz41ReVZAlU64l5eT/eP2FvN9nk/ek7AH9mWmJbxp2YwKQc4x1OSPfpWax+7O3rKqLCSXB2/eh7K
	RWFrpR2I7X36s779nmr+2DWb1bDLQYmd8NED+4DavBR5kk+AOuB9YNoaPg/z9jpkJcKQCM+1r8W9E
	hmAqoBQ8+57rpSK/OO99L5MGAyAMiRmyiuEG9VIA6oUdYMaLwV0LndevZi47eMv3toXGAvaEeM4Ld
	Eiy5CAVnJ0NEGDXtUHVAELEiME+qldfGUzvbqOMQOz/I3adCTN/UxHeRx5YDipxDkC3zikLrxmD1N
	Lq6+84erA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6FOA-0000tm-ET; Thu, 13 Aug 2020 15:43:34 +0000
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]
 helo=us-smtp-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6FO7-0000t1-0b
 for linux-nvme@lists.infradead.org; Thu, 13 Aug 2020 15:43:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597333410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XvQRtIwCdu5WxmMHZUuhQ5M8vGVV7X73Dsg4ufy9ew0=;
 b=gJi7DflgQIsja/25LLSZGUtzpZ4Z/rneqvILpe6AoYQRCMm7ieppDYiyFGpbSaQ4DJ4M8V
 CDDKJUAeoCtXJFEqy10KNjmnWXAeveIt6uak9aNhFUZIrJHIbR01bvX80SwcrqVQYW7RTi
 r+JlQqXLIFfPTdnEdyG6MXkKK+uzyc4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-Rrnq6fBeNQ6jvIr2zPgnjg-1; Thu, 13 Aug 2020 11:43:25 -0400
X-MC-Unique: Rrnq6fBeNQ6jvIr2zPgnjg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 747EF1DDE0;
 Thu, 13 Aug 2020 15:43:24 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 54E446FDAF;
 Thu, 13 Aug 2020 15:43:21 +0000 (UTC)
Date: Thu, 13 Aug 2020 11:43:20 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: "Meneghini, John" <John.Meneghini@netapp.com>
Subject: Re: [RESEND PATCH] nvme: explicitly use normal NVMe error handling
 when appropriate
Message-ID: <20200813154320.GA5707@redhat.com>
References: <20200806191943.GA27868@redhat.com>
 <6B826235-C504-4621-B8F7-34475B200979@netapp.com>
 <20200807000755.GA28957@redhat.com>
 <510f5aff-0437-b1ce-f7ab-c812edbea880@grimberg.me>
 <20200807045015.GA29737@redhat.com>
 <fec745aa-0091-ee1f-cb0f-da9e18cf0aa2@grimberg.me>
 <20200810143620.GA19127@redhat.com>
 <20200810172209.GA19535@redhat.com>
 <20200813144811.GA5452@redhat.com>
 <A90B4EF6-354C-4735-9E5A-45BF27F520E2@netapp.com>
MIME-Version: 1.0
In-Reply-To: <A90B4EF6-354C-4735-9E5A-45BF27F520E2@netapp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=msnitzer@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200813_114331_135941_AC0BE685 
X-CRM114-Status: GOOD (  26.68  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Ewan Milne <emilne@redhat.com>,
 Christoph Hellwig <hch@infradead.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Chao Leng <lengchao@huawei.com>, Keith Busch <kbusch@kernel.org>,
 Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

TWF5YmUgYmVjYXVzZSBJIGRpZG4ndCBjYyBsaW51eC1ibG9jaz8KT25seSB3YXkgdGhhdCBJIGtu
b3cgdG8gInVwbG9hZCB0aGlzIHBhdGNoIHRoZXJlIiBpcyB0byBoYXZlIGNjJ2QKbGludXgtYmxv
Y2suCgpCdXQgdGhlIHBhdGNoIGlzIGluIGRtLWRldmVsJ3MgcGF0Y2h3b3JrIGhlcmU6Cmh0dHBz
Oi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvMTE3MTI1NjMvCgpJcyB0aGF0IHN1ZmZpY2ll
bnQgZm9yIHlvdXIgbmVlZHM/CgpUaGFua3MsCk1pa2UKCk9uIFRodSwgQXVnIDEzIDIwMjAgYXQg
MTE6MjlhbSAtMDQwMCwKTWVuZWdoaW5pLCBKb2huIDxKb2huLk1lbmVnaGluaUBuZXRhcHAuY29t
PiB3cm90ZToKCj4gTWlrZSwgCj4gCj4gSSBkb24ndCBzZWUgeW91ciBwYXRjaCBhdDoKPiAKPiBo
dHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtYmxvY2svbGlzdC8/c3Vi
bWl0dGVyPTE2NDMKPiAKPiBDYW4geW91IHBsZWFzZSB1cGxvYWQgdGhpcyBwYXRjaCB0aGVyZT8K
PiAKPiBUaGFua3MsCj4gCj4gL0pvaG4KPiAKPiDvu79PbiA4LzEzLzIwLCAxMDo0OCBBTSwgIk1p
a2UgU25pdHplciIgPHNuaXR6ZXJAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gCj4gICAgIENvbW1pdCA3
NjRlOTMzMjA5OGMwICgibnZtZS1tdWx0aXBhdGg6IGRvIG5vdCByZXNldCBvbiB1bmtub3duCj4g
ICAgIHN0YXR1cyIpLCBhbW9uZyBvdGhlciB0aGluZ3MsIGZpeGVkIE5WTUVfU0NfQ01EX0lOVEVS
UlVQVEVEIGVycm9yCj4gICAgIGhhbmRsaW5nIGJ5IGNoYW5naW5nIG11bHRpcGF0aGluZydzIG52
bWVfZmFpbG92ZXJfcmVxKCkgdG8gc2hvcnQtY2lyY3VpdAo+ICAgICBwYXRoIGZhaWxvdmVyIGFu
ZCB0aGVuIGZhbGxiYWNrIHRvIE5WTWUncyBub3JtYWwgZXJyb3IgaGFuZGxpbmcgKHdoaWNoCj4g
ICAgIHRha2VzIGNhcmUgb2YgTlZNRV9TQ19DTURfSU5URVJSVVBURUQpLgo+IAo+ICAgICBUaGlz
IGRldG91ciB0aHJvdWdoIG5hdGl2ZSBOVk1lIG11bHRpcGF0aGluZyBjb2RlIGlzIHVud2VsY29t
ZSBiZWNhdXNlCj4gICAgIGl0IHByZXZlbnRzIE5WTWUgY29yZSBmcm9tIGhhbmRsaW5nIE5WTUVf
U0NfQ01EX0lOVEVSUlVQVEVEIGluZGVwZW5kZW50Cj4gICAgIG9mIGFueSBtdWx0aXBhdGhpbmcg
Y29uY2VybnMuCj4gCj4gICAgIEludHJvZHVjZSBudm1lX3N0YXR1c19uZWVkc19sb2NhbF9lcnJv
cl9oYW5kbGluZygpIHRvIHByaW9yaXRpemUKPiAgICAgbm9uLWZhaWxvdmVyIHJldHJ5LCB3aGVu
IGFwcHJvcHJpYXRlLCBpbiB0ZXJtcyBvZiBub3JtYWwgTlZNZSBlcnJvcgo+ICAgICBoYW5kbGlu
Zy4gIG52bWVfc3RhdHVzX25lZWRzX2xvY2FsX2Vycm9yX2hhbmRsaW5nKCkgd2lsbCBuYXR1cmVs
eSBldm9sdmUKPiAgICAgdG8gaW5jbHVkZSBoYW5kbGluZyBvZiBhbnkgb3RoZXIgZXJyb3JzIHRo
YXQgbm9ybWFsIGVycm9yIGhhbmRsaW5nIG11c3QKPiAgICAgYmUgdXNlZCBmb3IuCj4gCj4gICAg
IG52bWVfZmFpbG92ZXJfcmVxKCkncyBhYmlsaXR5IHRvIGZhbGxiYWNrIHRvIG5vcm1hbCBOVk1l
IGVycm9yIGhhbmRsaW5nCj4gICAgIGhhcyBiZWVuIHByZXNlcnZlZCBiZWNhdXNlIGl0IG1heSBi
ZSB1c2VmdWwgZm9yIGZ1dHVyZSBOVk1FX1NDIHRoYXQKPiAgICAgbnZtZV9zdGF0dXNfbmVlZHNf
bG9jYWxfZXJyb3JfaGFuZGxpbmcoKSBoYXNuJ3QgYmVlbiB0cmFpbmVkIGZvciB5ZXQuCj4gCj4g
ICAgIFNpZ25lZC1vZmYtYnk6IE1pa2UgU25pdHplciA8c25pdHplckByZWRoYXQuY29tPgo+ICAg
ICAtLS0KPiAgICAgIGRyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYyB8IDE2ICsrKysrKysrKysrKysr
LS0KPiAgICAgIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygt
KQo+IAo+ICAgICBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jIGIvZHJpdmVy
cy9udm1lL2hvc3QvY29yZS5jCj4gICAgIGluZGV4IDg4Y2ZmMzA5ZDhlNC4uYmU3NDliNjkwYWY3
IDEwMDY0NAo+ICAgICAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMKPiAgICAgKysrIGIv
ZHJpdmVycy9udm1lL2hvc3QvY29yZS5jCj4gICAgIEBAIC0yNTIsNiArMjUyLDE2IEBAIHN0YXRp
YyBpbmxpbmUgYm9vbCBudm1lX3JlcV9uZWVkc19yZXRyeShzdHJ1Y3QgcmVxdWVzdCAqcmVxKQo+
ICAgICAgICAgICAgIHJldHVybiB0cnVlOwo+ICAgICAgfQo+IAo+ICAgICArc3RhdGljIGlubGlu
ZSBib29sIG52bWVfc3RhdHVzX25lZWRzX2xvY2FsX2Vycm9yX2hhbmRsaW5nKHUxNiBzdGF0dXMp
Cj4gICAgICt7Cj4gICAgICsgICAgICAgc3dpdGNoIChzdGF0dXMgJiAweDdmZikgewo+ICAgICAr
ICAgICAgIGNhc2UgTlZNRV9TQ19DTURfSU5URVJSVVBURUQ6Cj4gICAgICsgICAgICAgICAgICAg
ICByZXR1cm4gdHJ1ZTsKPiAgICAgKyAgICAgICBkZWZhdWx0Ogo+ICAgICArICAgICAgICAgICAg
ICAgcmV0dXJuIGZhbHNlOwo+ICAgICArICAgICAgIH0KPiAgICAgK30KPiAgICAgKwo+ICAgICAg
c3RhdGljIHZvaWQgbnZtZV9yZXRyeV9yZXEoc3RydWN0IHJlcXVlc3QgKnJlcSkKPiAgICAgIHsK
PiAgICAgICAgICAgICBzdHJ1Y3QgbnZtZV9ucyAqbnMgPSByZXEtPnEtPnF1ZXVlZGF0YTsKPiAg
ICAgQEAgLTI3MCw3ICsyODAsOCBAQCBzdGF0aWMgdm9pZCBudm1lX3JldHJ5X3JlcShzdHJ1Y3Qg
cmVxdWVzdCAqcmVxKQo+IAo+ICAgICAgdm9pZCBudm1lX2NvbXBsZXRlX3JxKHN0cnVjdCByZXF1
ZXN0ICpyZXEpCj4gICAgICB7Cj4gICAgIC0gICAgICAgYmxrX3N0YXR1c190IHN0YXR1cyA9IG52
bWVfZXJyb3Jfc3RhdHVzKG52bWVfcmVxKHJlcSktPnN0YXR1cyk7Cj4gICAgICsgICAgICAgdTE2
IG52bWVfc3RhdHVzID0gbnZtZV9yZXEocmVxKS0+c3RhdHVzOwo+ICAgICArICAgICAgIGJsa19z
dGF0dXNfdCBzdGF0dXMgPSBudm1lX2Vycm9yX3N0YXR1cyhudm1lX3N0YXR1cyk7Cj4gCj4gICAg
ICAgICAgICAgdHJhY2VfbnZtZV9jb21wbGV0ZV9ycShyZXEpOwo+IAo+ICAgICBAQCAtMjgwLDcg
KzI5MSw4IEBAIHZvaWQgbnZtZV9jb21wbGV0ZV9ycShzdHJ1Y3QgcmVxdWVzdCAqcmVxKQo+ICAg
ICAgICAgICAgICAgICAgICAgbnZtZV9yZXEocmVxKS0+Y3RybC0+Y29tcF9zZWVuID0gdHJ1ZTsK
PiAKPiAgICAgICAgICAgICBpZiAodW5saWtlbHkoc3RhdHVzICE9IEJMS19TVFNfT0sgJiYgbnZt
ZV9yZXFfbmVlZHNfcmV0cnkocmVxKSkpIHsKPiAgICAgLSAgICAgICAgICAgICAgIGlmICgocmVx
LT5jbWRfZmxhZ3MgJiBSRVFfTlZNRV9NUEFUSCkgJiYgbnZtZV9mYWlsb3Zlcl9yZXEocmVxKSkK
PiAgICAgKyAgICAgICAgICAgICAgIGlmICghbnZtZV9zdGF0dXNfbmVlZHNfbG9jYWxfZXJyb3Jf
aGFuZGxpbmcobnZtZV9zdGF0dXMpICYmCj4gICAgICsgICAgICAgICAgICAgICAgICAgKHJlcS0+
Y21kX2ZsYWdzICYgUkVRX05WTUVfTVBBVEgpICYmIG52bWVfZmFpbG92ZXJfcmVxKHJlcSkpCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybjsKPiAKPiAgICAgICAgICAgICAgICAg
ICAgIGlmICghYmxrX3F1ZXVlX2R5aW5nKHJlcS0+cSkpIHsKPiAgICAgLS0KPiAgICAgMi4xOC4w
Cj4gCj4gCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
TGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
