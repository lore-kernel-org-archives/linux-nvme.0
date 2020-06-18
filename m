Return-Path: <SRS0=0To6=77=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ADA6C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jun 2020 21:08:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A101208B8
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jun 2020 21:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="STpZul8U";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="D0YSXf5c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A101208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7YNjjRlZxVV2DBuDjfSsrvN/QcCO+eYp8NRAgAEBjt0=; b=STpZul8Ui7v/Lm8bGnwU8ixDP
	AsXv6GtsDxf3J6V9KxZeTVjlDIdsJvwWBkRvBE0ku3rENDSghYFNqoEvReWi4tBMIMjOBOnCfyTEz
	S5Aia7oWdQLX0FWCZ0esusNYyC+TEAj8cPy4Dei7B6pjLIz0DB20NdD/qrpdAQp3nU7ARS+LYN2/i
	H9DOQwaHyfeXdbgf21mNh3rbM/vlNflx1SkwFk6aDFuC7UjKEIpbecEMTbFZCUQiN7/TSaDg0Y0Io
	RnS0he9HnRh4v7/cwVGu8ah0ivsupAQ508nwTdTtt0WKsf3hL5FfaNQh0m9KeDMGxDo9Kh8g/G40F
	dJYwzbKQg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jm1li-0001BW-HR; Thu, 18 Jun 2020 21:08:18 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jm1le-0001Av-EM
 for linux-nvme@lists.infradead.org; Thu, 18 Jun 2020 21:08:16 +0000
Received: by mail-wm1-x344.google.com with SMTP id y20so7144411wmi.2
 for <linux-nvme@lists.infradead.org>; Thu, 18 Jun 2020 14:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=ggw+RLzwmpyyEiT1KQdp4dtSLiIkA+8DINb4OML+CJY=;
 b=D0YSXf5cAh2kEScb1AXB59bjqJ7uI7mgrZLNUbTGd2Rx2rbDiRDXwvZOA3BL8dK5oj
 M6i65DHAxqRArcWVE6SVJA/KtmMRvpOhgLebT4B9CdNf3lnvVbiBRfgccuggpX9VOHYK
 CNdl3X73sTzmyY5vr/pED563VRIsrLJikX4+Jx6Ug53kubPHPTxltHJtqQWC9v41J+Cr
 UJf7bQcvZM/RiPzytMnrZfFBWTxBioR+dgCUnQZwMWe5+9wb6O3aewQZ8EB5q95PvhVC
 +voVStamFMmwTYEseCMAdfYTqeJDltHiW0QVPNpttU8XfMphjLxtRwcXqj44Ob9ZVKw2
 5Ltw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=ggw+RLzwmpyyEiT1KQdp4dtSLiIkA+8DINb4OML+CJY=;
 b=k4CtIUhTTCQWCqWanzCOPXEtueW4fEuB12+CqCcRpzZXe9OQawSpWOKhLPesAXx+9I
 KHe/P4PmmMMWtxYcEbeJy99kqEUzOkuE1wCGY+K3pPgz7BQxEeMazk6kFQrmuXzJ9TBC
 MvMxvr+u34FQ1Sz6Eynhj8aFsVKiG++MnmVBknmXk9ZYqMAgCqC6r4lDwmt7M+slKVWv
 RXKshMPvVPQRGiekROx2nr7/VX4c597370toQXQpk6DvfodtBIWprqsuDRBFeMCX2k+h
 trIxRRG2em92c+zNtjOnnVp0eEw/MMow5my3/CSwfAKGmNFLnk73zObXURxuG6Cyla91
 5iBA==
X-Gm-Message-State: AOAM533nQD8Z/VDCox6zNmS2QaRPmOP0wIxNv77qFMdWJQKvxrHAtNH0
 6fv13K1Vf8+bOvtBtvLASGrmPQ==
X-Google-Smtp-Source: ABdhPJzhrk+K//npHPnI+8t1LgOJEZXWWDmcfXap4FUGU2ywhpC77XkVPnYEyTrfWdvyM7sDzOUARQ==
X-Received: by 2002:a1c:e20a:: with SMTP id z10mr200343wmg.63.1592514491962;
 Thu, 18 Jun 2020 14:08:11 -0700 (PDT)
Received: from [10.0.0.6] (xb932c246.cust.hiper.dk. [185.50.194.70])
 by smtp.gmail.com with ESMTPSA id z8sm1702491wrv.80.2020.06.18.14.08.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2020 14:08:11 -0700 (PDT)
Subject: Re: [PATCHv2 2/5] null_blk: introduce zone capacity for zoned device
To: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, hch@lst.de, sagi@grimberg.me
References: <20200618145354.1139350-1-kbusch@kernel.org>
 <20200618145354.1139350-3-kbusch@kernel.org>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <c99bf481-af99-e6a7-731d-d7cc7dd17455@lightnvm.io>
Date: Thu, 18 Jun 2020 23:08:11 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200618145354.1139350-3-kbusch@kernel.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200618_140814_554450_F7FC37EC 
X-CRM114-Status: GOOD (  20.69  )
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
Cc: axboe@kernel.dk, Aravind Ramesh <aravind.ramesh@wdc.com>,
 Daniel Wagner <dwagner@suse.de>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTgvMDYvMjAyMCAxNi41MywgS2VpdGggQnVzY2ggd3JvdGU6Cj4gRnJvbTogQXJhdmluZCBS
YW1lc2ggPGFyYXZpbmQucmFtZXNoQHdkYy5jb20+Cj4KPiBBbGxvdyBlbXVsYXRpb24gb2YgYSB6
b25lZCBkZXZpY2Ugd2l0aCBhIHBlciB6b25lIGNhcGFjaXR5IHNtYWxsZXIgdGhhbgo+IHRoZSB6
b25lIHNpemUgYXMgYXMgZGVmaW5lZCBpbiB0aGUgWm9uZWQgTmFtZXNwYWNlIChaTlMpIENvbW1h
bmQgU2V0Cj4gc3BlY2lmaWNhdGlvbi4gVGhlIHpvbmUgY2FwYWNpdHkgZGVmYXVsdHMgdG8gdGhl
IHpvbmUgc2l6ZSBpZiBub3QKPiBzcGVjaWZpZWQgYW5kIG11c3QgYmUgc21hbGxlciB0aGFuIHRo
ZSB6b25lIHNpemUgb3RoZXJ3aXNlLgo+Cj4gUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJu
aSA8Y2hhaXRhbnlhLmt1bGthcm5pQHdkYy5jb20+Cj4gUmV2aWV3ZWQtYnk6IERhbmllbCBXYWdu
ZXIgPGR3YWduZXJAc3VzZS5kZT4KPiBSZXZpZXdlZC1ieTogTWFydGluIEsuIFBldGVyc2VuIDxt
YXJ0aW4ucGV0ZXJzZW5Ab3JhY2xlLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBBcmF2aW5kIFJhbWVz
aCA8YXJhdmluZC5yYW1lc2hAd2RjLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvYmxvY2svbnVsbF9i
bGsuaCAgICAgICB8ICAxICsKPiAgIGRyaXZlcnMvYmxvY2svbnVsbF9ibGtfbWFpbi5jICB8IDEw
ICsrKysrKysrKy0KPiAgIGRyaXZlcnMvYmxvY2svbnVsbF9ibGtfem9uZWQuYyB8IDE2ICsrKysr
KysrKysrKysrLS0KPiAgIDMgZmlsZXMgY2hhbmdlZCwgMjQgaW5zZXJ0aW9ucygrKSwgMyBkZWxl
dGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Jsb2NrL251bGxfYmxrLmggYi9kcml2
ZXJzL2Jsb2NrL251bGxfYmxrLmgKPiBpbmRleCA4MWIzMTFjOWQ3ODEuLmRhZWQ0YTljMzQzNiAx
MDA2NDQKPiAtLS0gYS9kcml2ZXJzL2Jsb2NrL251bGxfYmxrLmgKPiArKysgYi9kcml2ZXJzL2Js
b2NrL251bGxfYmxrLmgKPiBAQCAtNDksNiArNDksNyBAQCBzdHJ1Y3QgbnVsbGJfZGV2aWNlIHsK
PiAgIAl1bnNpZ25lZCBsb25nIGNvbXBsZXRpb25fbnNlYzsgLyogdGltZSBpbiBucyB0byBjb21w
bGV0ZSBhIHJlcXVlc3QgKi8KPiAgIAl1bnNpZ25lZCBsb25nIGNhY2hlX3NpemU7IC8qIGRpc2sg
Y2FjaGUgc2l6ZSBpbiBNQiAqLwo+ICAgCXVuc2lnbmVkIGxvbmcgem9uZV9zaXplOyAvKiB6b25l
IHNpemUgaW4gTUIgaWYgZGV2aWNlIGlzIHpvbmVkICovCj4gKwl1bnNpZ25lZCBsb25nIHpvbmVf
Y2FwYWNpdHk7IC8qIHpvbmUgY2FwYWNpdHkgaW4gTUIgaWYgZGV2aWNlIGlzIHpvbmVkICovCj4g
ICAJdW5zaWduZWQgaW50IHpvbmVfbnJfY29udjsgLyogbnVtYmVyIG9mIGNvbnZlbnRpb25hbCB6
b25lcyAqLwo+ICAgCXVuc2lnbmVkIGludCBzdWJtaXRfcXVldWVzOyAvKiBudW1iZXIgb2Ygc3Vi
bWlzc2lvbiBxdWV1ZXMgKi8KPiAgIAl1bnNpZ25lZCBpbnQgaG9tZV9ub2RlOyAvKiBob21lIG5v
ZGUgZm9yIHRoZSBkZXZpY2UgKi8KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ibG9jay9udWxsX2Js
a19tYWluLmMgYi9kcml2ZXJzL2Jsb2NrL251bGxfYmxrX21haW4uYwo+IGluZGV4IDg3YjMxZjlj
YTM2Mi4uYTJhMGUxOTkyMTViIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvYmxvY2svbnVsbF9ibGtf
bWFpbi5jCj4gKysrIGIvZHJpdmVycy9ibG9jay9udWxsX2Jsa19tYWluLmMKPiBAQCAtMjAwLDYg
KzIwMCwxMCBAQCBzdGF0aWMgdW5zaWduZWQgbG9uZyBnX3pvbmVfc2l6ZSA9IDI1NjsKPiAgIG1v
ZHVsZV9wYXJhbV9uYW1lZCh6b25lX3NpemUsIGdfem9uZV9zaXplLCB1bG9uZywgU19JUlVHTyk7
Cj4gICBNT0RVTEVfUEFSTV9ERVNDKHpvbmVfc2l6ZSwgIlpvbmUgc2l6ZSBpbiBNQiB3aGVuIGJs
b2NrIGRldmljZSBpcyB6b25lZC4gTXVzdCBiZSBwb3dlci1vZi10d286IERlZmF1bHQ6IDI1NiIp
Owo+ICAgCj4gK3N0YXRpYyB1bnNpZ25lZCBsb25nIGdfem9uZV9jYXBhY2l0eTsKPiArbW9kdWxl
X3BhcmFtX25hbWVkKHpvbmVfY2FwYWNpdHksIGdfem9uZV9jYXBhY2l0eSwgdWxvbmcsIDA0NDQp
Owo+ICtNT0RVTEVfUEFSTV9ERVNDKHpvbmVfY2FwYWNpdHksICJab25lIGNhcGFjaXR5IGluIE1C
IHdoZW4gYmxvY2sgZGV2aWNlIGlzIHpvbmVkLiBDYW4gYmUgbGVzcyB0aGFuIG9yIGVxdWFsIHRv
IHpvbmUgc2l6ZS4gRGVmYXVsdDogWm9uZSBzaXplIik7Cj4gKwo+ICAgc3RhdGljIHVuc2lnbmVk
IGludCBnX3pvbmVfbnJfY29udjsKPiAgIG1vZHVsZV9wYXJhbV9uYW1lZCh6b25lX25yX2NvbnYs
IGdfem9uZV9ucl9jb252LCB1aW50LCAwNDQ0KTsKPiAgIE1PRFVMRV9QQVJNX0RFU0Moem9uZV9u
cl9jb252LCAiTnVtYmVyIG9mIGNvbnZlbnRpb25hbCB6b25lcyB3aGVuIGJsb2NrIGRldmljZSBp
cyB6b25lZC4gRGVmYXVsdDogMCIpOwo+IEBAIC0zNDEsNiArMzQ1LDcgQEAgTlVMTEJfREVWSUNF
X0FUVFIobWJwcywgdWludCwgTlVMTCk7Cj4gICBOVUxMQl9ERVZJQ0VfQVRUUihjYWNoZV9zaXpl
LCB1bG9uZywgTlVMTCk7Cj4gICBOVUxMQl9ERVZJQ0VfQVRUUih6b25lZCwgYm9vbCwgTlVMTCk7
Cj4gICBOVUxMQl9ERVZJQ0VfQVRUUih6b25lX3NpemUsIHVsb25nLCBOVUxMKTsKPiArTlVMTEJf
REVWSUNFX0FUVFIoem9uZV9jYXBhY2l0eSwgdWxvbmcsIE5VTEwpOwo+ICAgTlVMTEJfREVWSUNF
X0FUVFIoem9uZV9ucl9jb252LCB1aW50LCBOVUxMKTsKPiAgIAo+ICAgc3RhdGljIHNzaXplX3Qg
bnVsbGJfZGV2aWNlX3Bvd2VyX3Nob3coc3RydWN0IGNvbmZpZ19pdGVtICppdGVtLCBjaGFyICpw
YWdlKQo+IEBAIC00NTcsNiArNDYyLDcgQEAgc3RhdGljIHN0cnVjdCBjb25maWdmc19hdHRyaWJ1
dGUgKm51bGxiX2RldmljZV9hdHRyc1tdID0gewo+ICAgCSZudWxsYl9kZXZpY2VfYXR0cl9iYWRi
bG9ja3MsCj4gICAJJm51bGxiX2RldmljZV9hdHRyX3pvbmVkLAo+ICAgCSZudWxsYl9kZXZpY2Vf
YXR0cl96b25lX3NpemUsCj4gKwkmbnVsbGJfZGV2aWNlX2F0dHJfem9uZV9jYXBhY2l0eSwKPiAg
IAkmbnVsbGJfZGV2aWNlX2F0dHJfem9uZV9ucl9jb252LAo+ICAgCU5VTEwsCj4gICB9Owo+IEBA
IC01MTAsNyArNTE2LDggQEAgbnVsbGJfZ3JvdXBfZHJvcF9pdGVtKHN0cnVjdCBjb25maWdfZ3Jv
dXAgKmdyb3VwLCBzdHJ1Y3QgY29uZmlnX2l0ZW0gKml0ZW0pCj4gICAKPiAgIHN0YXRpYyBzc2l6
ZV90IG1lbWJfZ3JvdXBfZmVhdHVyZXNfc2hvdyhzdHJ1Y3QgY29uZmlnX2l0ZW0gKml0ZW0sIGNo
YXIgKnBhZ2UpCj4gICB7Cj4gLQlyZXR1cm4gc25wcmludGYocGFnZSwgUEFHRV9TSVpFLCAibWVt
b3J5X2JhY2tlZCxkaXNjYXJkLGJhbmR3aWR0aCxjYWNoZSxiYWRibG9ja3Msem9uZWQsem9uZV9z
aXplLHpvbmVfbnJfY29udlxuIik7Cj4gKwlyZXR1cm4gc25wcmludGYocGFnZSwgUEFHRV9TSVpF
LAo+ICsJCQkibWVtb3J5X2JhY2tlZCxkaXNjYXJkLGJhbmR3aWR0aCxjYWNoZSxiYWRibG9ja3Ms
em9uZWQsem9uZV9zaXplLHpvbmVfY2FwYWNpdHksem9uZV9ucl9jb252XG4iKTsKPiAgIH0KPiAg
IAo+ICAgQ09ORklHRlNfQVRUUl9STyhtZW1iX2dyb3VwXywgZmVhdHVyZXMpOwo+IEBAIC01NzEs
NiArNTc4LDcgQEAgc3RhdGljIHN0cnVjdCBudWxsYl9kZXZpY2UgKm51bGxfYWxsb2NfZGV2KHZv
aWQpCj4gICAJZGV2LT51c2VfcGVyX25vZGVfaGN0eCA9IGdfdXNlX3Blcl9ub2RlX2hjdHg7Cj4g
ICAJZGV2LT56b25lZCA9IGdfem9uZWQ7Cj4gICAJZGV2LT56b25lX3NpemUgPSBnX3pvbmVfc2l6
ZTsKPiArCWRldi0+em9uZV9jYXBhY2l0eSA9IGdfem9uZV9jYXBhY2l0eTsKPiAgIAlkZXYtPnpv
bmVfbnJfY29udiA9IGdfem9uZV9ucl9jb252Owo+ICAgCXJldHVybiBkZXY7Cj4gICB9Cj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvYmxvY2svbnVsbF9ibGtfem9uZWQuYyBiL2RyaXZlcnMvYmxvY2sv
bnVsbF9ibGtfem9uZWQuYwo+IGluZGV4IDYyNGFhYzA5YjAwNS4uM2QyNWM5YWQyMzgzIDEwMDY0
NAo+IC0tLSBhL2RyaXZlcnMvYmxvY2svbnVsbF9ibGtfem9uZWQuYwo+ICsrKyBiL2RyaXZlcnMv
YmxvY2svbnVsbF9ibGtfem9uZWQuYwo+IEBAIC0yOCw2ICsyOCwxNSBAQCBpbnQgbnVsbF9pbml0
X3pvbmVkX2RldihzdHJ1Y3QgbnVsbGJfZGV2aWNlICpkZXYsIHN0cnVjdCByZXF1ZXN0X3F1ZXVl
ICpxKQo+ICAgCQlyZXR1cm4gLUVJTlZBTDsKPiAgIAl9Cj4gICAKPiArCWlmICghZGV2LT56b25l
X2NhcGFjaXR5KQo+ICsJCWRldi0+em9uZV9jYXBhY2l0eSA9IGRldi0+em9uZV9zaXplOwo+ICsK
PiArCWlmIChkZXYtPnpvbmVfY2FwYWNpdHkgPiBkZXYtPnpvbmVfc2l6ZSkgewo+ICsJCXByX2Vy
cigibnVsbF9ibGs6IHpvbmUgY2FwYWNpdHkgKCVsdSBNQikgbGFyZ2VyIHRoYW4gem9uZSBzaXpl
ICglbHUgTUIpXG4iLAo+ICsJCQkJCWRldi0+em9uZV9jYXBhY2l0eSwgZGV2LT56b25lX3NpemUp
Owo+ICsJCXJldHVybiAtRUlOVkFMOwo+ICsJfQo+ICsKPiAgIAlkZXYtPnpvbmVfc2l6ZV9zZWN0
cyA9IGRldi0+em9uZV9zaXplIDw8IFpPTkVfU0laRV9TSElGVDsKPiAgIAlkZXYtPm5yX3pvbmVz
ID0gZGV2X3NpemUgPj4KPiAgIAkJCQkoU0VDVE9SX1NISUZUICsgaWxvZzIoZGV2LT56b25lX3Np
emVfc2VjdHMpKTsKPiBAQCAtNjAsNyArNjksNyBAQCBpbnQgbnVsbF9pbml0X3pvbmVkX2Rldihz
dHJ1Y3QgbnVsbGJfZGV2aWNlICpkZXYsIHN0cnVjdCByZXF1ZXN0X3F1ZXVlICpxKQo+ICAgCj4g
ICAJCXpvbmUtPnN0YXJ0ID0gem9uZS0+d3AgPSBzZWN0b3I7Cj4gICAJCXpvbmUtPmxlbiA9IGRl
di0+em9uZV9zaXplX3NlY3RzOwo+IC0JCXpvbmUtPmNhcGFjaXR5ID0gem9uZS0+bGVuOwo+ICsJ
CXpvbmUtPmNhcGFjaXR5ID0gZGV2LT56b25lX2NhcGFjaXR5IDw8IFpPTkVfU0laRV9TSElGVDsK
PiAgIAkJem9uZS0+dHlwZSA9IEJMS19aT05FX1RZUEVfU0VRV1JJVEVfUkVROwo+ICAgCQl6b25l
LT5jb25kID0gQkxLX1pPTkVfQ09ORF9FTVBUWTsKPiAgIAo+IEBAIC0xODcsNiArMTk2LDkgQEAg
c3RhdGljIGJsa19zdGF0dXNfdCBudWxsX3pvbmVfd3JpdGUoc3RydWN0IG51bGxiX2NtZCAqY21k
LCBzZWN0b3JfdCBzZWN0b3IsCj4gICAJCQlyZXR1cm4gQkxLX1NUU19JT0VSUjsKPiAgIAkJfQo+
ICAgCj4gKwkJaWYgKHpvbmUtPndwICsgbnJfc2VjdG9ycyA+IHpvbmUtPnN0YXJ0ICsgem9uZS0+
Y2FwYWNpdHkpCj4gKwkJCXJldHVybiBCTEtfU1RTX0lPRVJSOwo+ICsKPiAgIAkJaWYgKHpvbmUt
PmNvbmQgIT0gQkxLX1pPTkVfQ09ORF9FWFBfT1BFTikKPiAgIAkJCXpvbmUtPmNvbmQgPSBCTEtf
Wk9ORV9DT05EX0lNUF9PUEVOOwo+ICAgCj4gQEAgLTE5NSw3ICsyMDcsNyBAQCBzdGF0aWMgYmxr
X3N0YXR1c190IG51bGxfem9uZV93cml0ZShzdHJ1Y3QgbnVsbGJfY21kICpjbWQsIHNlY3Rvcl90
IHNlY3RvciwKPiAgIAkJCXJldHVybiByZXQ7Cj4gICAKPiAgIAkJem9uZS0+d3AgKz0gbnJfc2Vj
dG9yczsKPiAtCQlpZiAoem9uZS0+d3AgPT0gem9uZS0+c3RhcnQgKyB6b25lLT5sZW4pCj4gKwkJ
aWYgKHpvbmUtPndwID09IHpvbmUtPnN0YXJ0ICsgem9uZS0+Y2FwYWNpdHkpCj4gICAJCQl6b25l
LT5jb25kID0gQkxLX1pPTkVfQ09ORF9GVUxMOwo+ICAgCQlyZXR1cm4gQkxLX1NUU19PSzsKPiAg
IAlkZWZhdWx0OgoKUmV2aWV3ZWQtYnk6IE1hdGlhcyBCasO4cmxpbmcgPG1hdGlhcy5iam9ybGlu
Z0B3ZGMuY29tPgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmxpbnV4LW52bWUgbWFpbGluZyBsaXN0CmxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9y
ZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
