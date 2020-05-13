Return-Path: <SRS0=q3TM=63=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE370C433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 May 2020 19:04:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AB0320671
	for <linux-nvme@archiver.kernel.org>; Wed, 13 May 2020 19:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="la5MtkiP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LhJ0DwTl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AB0320671
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Pju2wVVIc5+92vQfhWGA4hQXcZ0AdSKgiAapONp1fQE=; b=la5MtkiPE2i39ErWXjXUzuCoE
	Etf/zLuZzEuPz/dNkYviRa/WfBov/jGNsqCneYpamZmdiSuj0URVoSsGHOPM+3RGDx2IFa6xITc57
	eztjHNQC6jmwknuqFMGBF6lYFHzx6f/D2OMlL7za8MSmiF4P8z22BPCbn/MFUiS3xXfGmMOoXv1wI
	tswtiW2xIekVtGOgawFXt9qqfFK/XI9yMAh/+gtPf9q/Ne9uLfB/uIWGSXRvjmKSpRpqWpsxRSGXg
	Hl5Fb/Or0tgJK7PERyRA/Ja41bJDcZ2vtKSu51Pt5N9fbujXhVY7dVr0Yy5Hv46Oh8AEFsNpUeaW6
	JwzFL0+9A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jYwfj-0003hA-3K; Wed, 13 May 2020 19:04:03 +0000
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jYwfg-0003go-8J
 for linux-nvme@lists.infradead.org; Wed, 13 May 2020 19:04:01 +0000
Received: by mail-pj1-x1042.google.com with SMTP id hi11so11500681pjb.3
 for <linux-nvme@lists.infradead.org>; Wed, 13 May 2020 12:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=r0K+FMLxcQ6CvXt24T/yFjHiLvqhHAzW8C7rtIl08RI=;
 b=LhJ0DwTl/TuUNc1XVJQnOIvSl5FGXkLbumTioCAWlx6V+Aaylr8FSp66dYU6pDVJWC
 yp7KqCvt9TbOyHz2QHvmNrs3l18ODKLqIynqbOXo5T3484iaymFXj4tZA1LV7KHizEz/
 izBSi2FYqug7y63E8PP7EITtJwAMU6jz2sdeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=r0K+FMLxcQ6CvXt24T/yFjHiLvqhHAzW8C7rtIl08RI=;
 b=HzEY8NfsFOAEWfidcICNRrjjzNkgL8p++eBbj3QegMZNgLAh7ppaWJoe1MEc8Uqsvd
 idrjrZd3a8GYH/y8W8j+INQvqwlmBGHYR8DbtULAr06/pYymsKfTFhwLv3Ojl9TtSVah
 2+bPjmHJUEu/Ms4TOTtvnfgrYR7ILF5qx0xUQ58cWvLioi5ffwznbp+BRtma2zvnYTT+
 EYbU6fM1dVU30Dsub2EcjBrLgWp/t5CWJz1jsA6m1rI/OaGBAo3EdXH8M0T1iW4qCGJ2
 D7CsiitXFKQUWn2dB0l69k/JbCRMsLGiZUsB6210yQYTvvDTAyKzaW/M1YOq2KkL0OHH
 B+kA==
X-Gm-Message-State: AOAM531Wl4reLHUlmvcwGWCW757wD1t3Ijosw1LRwyxUO9fLKS4uPP1I
 cRNrcAlGhcWO7GAZd4h1e3OUVg==
X-Google-Smtp-Source: ABdhPJynGw9JeGTnwF+sBtUZXtheD6eMay8tnYA17PLfqs9yDNXGD0uydeZKKHinfVoFrRhI16IAxw==
X-Received: by 2002:a17:902:50d:: with SMTP id 13mr590907plf.170.1589396638819; 
 Wed, 13 May 2020 12:03:58 -0700 (PDT)
Received: from [10.230.185.151] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id e4sm379472pge.45.2020.05.13.12.03.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2020 12:03:57 -0700 (PDT)
Subject: Re: [PATCH 06/16] nvme: enforce extended LBA format for fabrics
 metadata
To: Max Gurtovoy <maxg@mellanox.com>, linux-nvme@lists.infradead.org,
 kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, martin.petersen@oracle.com,
 jsmart2021@gmail.com, axboe@kernel.dk
References: <20200504155755.221125-1-maxg@mellanox.com>
 <20200504155755.221125-7-maxg@mellanox.com>
From: James Smart <james.smart@broadcom.com>
Message-ID: <33e04c87-f41a-e5a4-05f0-807d52bb78ff@broadcom.com>
Date: Wed, 13 May 2020 12:03:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200504155755.221125-7-maxg@mellanox.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200513_120400_298419_C2202364 
X-CRM114-Status: GOOD (  19.89  )
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
Cc: vladimirk@mellanox.com, idanb@mellanox.com, israelr@mellanox.com,
 shlomin@mellanox.com, oren@mellanox.com, nitzanc@mellanox.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiA1LzQvMjAyMCA4OjU3IEFNLCBNYXggR3VydG92b3kgd3JvdGU6Cj4gQW4gZXh0ZW5kZWQg
TEJBIGlzIGEgbGFyZ2VyIExCQSB0aGF0IGlzIGNyZWF0ZWQgd2hlbiBtZXRhZGF0YSBhc3NvY2lh
dGVkCj4gd2l0aCB0aGUgTEJBIGlzIHRyYW5zZmVycmVkIGNvbnRpZ3VvdXNseSB3aXRoIHRoZSBM
QkEgZGF0YSAoQUtBCj4gaW50ZXJsZWF2ZWQpLiBUaGUgbWV0YWRhdGEgbWF5IGJlIGVpdGhlciB0
cmFuc2ZlcnJlZCBhcyBwYXJ0IG9mIHRoZSBMQkEKPiAoY3JlYXRpbmcgYW4gZXh0ZW5kZWQgTEJB
KSBvciBpdCBtYXkgYmUgdHJhbnNmZXJyZWQgYXMgYSBzZXBhcmF0ZQo+IGNvbnRpZ3VvdXMgYnVm
ZmVyIG9mIGRhdGEuIEFjY29yZGluZyB0byB0aGUgTlZNZW9GIHNwZWMsIGEgZmFicmljcyBjdHJs
Cj4gc3VwcG9ydHMgb25seSBhbiBFeHRlbmRlZCBMQkEgZm9ybWF0LiBGYWlsIHJldmFsaWRhdGlv
biBpbiBjYXNlIHdlIGhhdmUgYQo+IHNwZWMgdmlvbGF0aW9uLiBBbHNvIGFkZCBhIGZsYWcgdGhh
dCB3aWxsIGltcGx5IG9uIGNhcGFibGUgdHJhbnNwb3J0cyBhbmQKPiBjb250cm9sbGVycyBhcyBw
YXJ0IG9mIGEgcHJlcGFyYXRpb24gZm9yIGFsbG93aW5nIGVuZC10by1lbmQgcHJvdGVjdGlvbgo+
IGluZm9ybWF0aW9uIGZvciBmYWJyaWMgY29udHJvbGxlcnMuCj4KPiBTdWdnZXN0ZWQtYnk6IENo
cmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPgo+IFNpZ25lZC1vZmYtYnk6IE1heCBHdXJ0b3Zv
eSA8bWF4Z0BtZWxsYW5veC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogSXNyYWVsIFJ1a3NoaW4gPGlz
cmFlbHJAbWVsbGFub3guY29tPgo+IFJldmlld2VkLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNo
QGxzdC5kZT4KPiAtLS0KPiAgIGRyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYyB8IDQxICsrKysrKysr
KysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgMjcg
aW5zZXJ0aW9ucygrKSwgMTQgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9u
dm1lL2hvc3QvY29yZS5jIGIvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jCj4gaW5kZXggODliMWJm
Y2IuLmY1NjUyODEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jCj4gKysr
IGIvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jCj4gQEAgLTE5NDEsMTYgKzE5NDIsMjQgQEAgc3Rh
dGljIHZvaWQgX19udm1lX3JldmFsaWRhdGVfZGlzayhzdHJ1Y3QgZ2VuZGlzayAqZGlzaywgc3Ry
dWN0IG52bWVfaWRfbnMgKmlkKQo+ICAgCQlucy0+cGlfdHlwZSA9IDA7Cj4gICAKPiAgIAlpZiAo
bnMtPm1zKSB7Cj4gLQkJaWYgKGlkLT5mbGJhcyAmIE5WTUVfTlNfRkxCQVNfTUVUQV9FWFQpCj4g
LQkJCW5zLT5mZWF0dXJlcyB8PSBOVk1FX05TX0VYVF9MQkFTOwo+IC0KPiAgIAkJLyoKPiAtCQkg
KiBGb3IgUENJLCBFeHRlbmRlZCBsb2dpY2FsIGJsb2NrIHdpbGwgYmUgZ2VuZXJhdGVkIGJ5IHRo
ZQo+IC0JCSAqIGNvbnRyb2xsZXIuIE5vbi1leHRlbmRlZCBmb3JtYXQgY2FuIGJlIGdlbmVyYXRl
ZCBieSB0aGUKPiAtCQkgKiBibG9jayBsYXllci4KPiArCQkgKiBGb3IgUENJZSBvbmx5IHRoZSBz
ZXBhcmF0ZSBtZXRhZGF0YSBwb2ludGVyIGlzIHN1cHBvcnRlZCwKPiArCQkgKiBhcyB0aGUgYmxv
Y2sgbGF5ZXIgc3VwcGxpZXMgbWV0YWRhdGEgaW4gYSBzZXBhcmF0ZSBiaW9fdmVjCj4gKwkJICog
Y2hhaW4uIEZvciBGYWJyaWNzLCBvbmx5IG1ldGFkYXRhIGFzIHBhcnQgb2YgZXh0ZW5kZWQgZGF0
YQo+ICsJCSAqIExCQSBpcyBzdXBwb3J0ZWQgb24gdGhlIHdpcmUgcGVyIHRoZSBGYWJyaWNzIHNw
ZWNpZmljYXRpb24sCj4gKwkJICogYnV0IHRoZSBIQkEvSENBIHdpbGwgZG8gdGhlIHJlbWFwcGlu
ZyBmcm9tIHRoZSBzZXBhcmF0ZQo+ICsJCSAqIG1ldGFkYXRhIGJ1ZmZlcnMgZm9yIHVzLgo+ICAg
CQkgKi8KPiAtCQlpZiAobnMtPmN0cmwtPm9wcy0+ZmxhZ3MgJiBOVk1FX0ZfTUVUQURBVEFfU1VQ
UE9SVEVEKSB7Cj4gLQkJCWlmICghKG5zLT5mZWF0dXJlcyAmIE5WTUVfTlNfRVhUX0xCQVMpKQo+
ICsJCWlmIChpZC0+ZmxiYXMgJiBOVk1FX05TX0ZMQkFTX01FVEFfRVhUKSB7Cj4gKwkJCW5zLT5m
ZWF0dXJlcyB8PSBOVk1FX05TX0VYVF9MQkFTOwo+ICsJCQlpZiAoKGN0cmwtPm9wcy0+ZmxhZ3Mg
JiBOVk1FX0ZfRkFCUklDUykgJiYKPiArCQkJICAgIChjdHJsLT5vcHMtPmZsYWdzICYgTlZNRV9G
X01FVEFEQVRBX1NVUFBPUlRFRCkgJiYKPiArCQkJICAgIGN0cmwtPm1heF9pbnRlZ3JpdHlfc2Vn
bWVudHMpCj4gKwkJCQlucy0+ZmVhdHVyZXMgfD0gTlZNRV9OU19NRVRBREFUQV9TVVBQT1JURUQ7
CgpUaGlzIGlzIG9rLsKgIExhdGVyIHBhdGNoZXMgd2lsbCBzaG91bGQgZGVhbCB3aXRoIG5vIGJs
b2NrLWxheWVyIAppbnRlZ3JpdHkgYnVmZmVyLCBidXQgaGF2aW5nIHRoZSB0cmFuc3BvcnQgcG9y
dCBhdXRvLWdlbmVyYXRlL3N0cmlwIAppbnRlcmxlYXZlZCBwaSBkYXRhLCBhcyB3ZSB3aWxsIHdh
bnQgdG8gcHJvdGVjdCBkdXJpbmcgdHJhbnNtaXNzaW9uIG9uIAp0aGUgd2lyZSwgbm90IGp1c3Qg
UFJBQ1Q9MSBpdC4KCj4gKwkJfSBlbHNlIHsKPiArCQkJaWYgKFdBUk5fT05fT05DRShjdHJsLT5v
cHMtPmZsYWdzICYgTlZNRV9GX0ZBQlJJQ1MpKQo+ICsJCQkJcmV0dXJuIC1FSU5WQUw7Cj4gKwkJ
CWlmIChjdHJsLT5vcHMtPmZsYWdzICYgTlZNRV9GX01FVEFEQVRBX1NVUFBPUlRFRCkKPiAgIAkJ
CQlucy0+ZmVhdHVyZXMgfD0gTlZNRV9OU19NRVRBREFUQV9TVVBQT1JURUQ7Cj4gICAJCX0KClRo
ZSBOVk1FX0ZfTUVUQURBVEFfU1VQUE9SVEVEIGZsYWcgc2hvdWxkIGJlIG9uIGEgcGVyLWN0cmwg
YmFzaXMuIFRoZXJlIAp3aWxsIGJlIGRpZmZlcmVudCB0cmFuc3BvcnQgcG9ydHMgdW5kZXIgdGhl
IHNhbWUgdHJhbnNwb3J0IHdpdGggCmRpZmZlcmVudCBhYmlsaXRpZXMuCgpJJ20gb2sgaWYgdGhl
c2UgcGF0Y2hlcyBnbyBpbiwgdGhlbiBhIGxhdGVyIHBhdGNoIG1vdmVzIHRoZSBmbGFncyAobWln
aHQgCmFzIHdlbGwgbW92ZSBOVk1FX0ZfRkFCUklDUyB0b28pLgoKClJldmlld2VkLWJ5OsKgIEph
bWVzIFNtYXJ0IDxqYW1lcy5zbWFydEBicm9hZGNvbS5jb20+CgotLSBqYW1lcwoKCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1udm1lIG1haWxp
bmcgbGlzdApsaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
