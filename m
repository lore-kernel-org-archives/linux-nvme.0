Return-Path: <SRS0=DhF7=6T=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2697C47254
	for <linux-nvme@archiver.kernel.org>; Tue,  5 May 2020 23:34:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CC0F206B8
	for <linux-nvme@archiver.kernel.org>; Tue,  5 May 2020 23:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="U0RdaGfH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="O8TkrfhW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CC0F206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=RWzBSz0cGAX4jYlBsyStaqFzCCD5CobWlZs+m0RPN/U=; b=U0RdaGfHYToHk0UvKQYKfwQG1
	V99ugKIWaoJYoytKPgM2UF2+j+wtm5ECDZpWvuJSTMxTHlbmgL6GI2y5it0lWWpEdkX2e1CAwc6b3
	XgDW2nKLH0EB7SyZy7pl36pxxuMYyo9kSOptbI0RohQ1dJdDufUSUF6S0LvXFjwKMEIupqoON4j3q
	a7VAv6D5wz3dZ+Stua/FIwTqN6W0uhvDV0vU+VmCeRmfoZaKEZ+kT6Jl50vAYBgxYxFM8KUQFepPW
	3jBVNy/DVraLI+2Dj+YHm/x4cx22NanOPoxjOdR4TJMoncByxF3W0Cdj8mJJOWVDMT/EpVy7vd0u/
	zeqGVKxZg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jW74X-0003wr-OC; Tue, 05 May 2020 23:33:57 +0000
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jW74V-0003wN-7r
 for linux-nvme@lists.infradead.org; Tue, 05 May 2020 23:33:56 +0000
Received: by mail-qt1-x843.google.com with SMTP id z90so3600739qtd.10
 for <linux-nvme@lists.infradead.org>; Tue, 05 May 2020 16:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=BzRjVu+EMuv9TXzLN/p4U2NjYfwhPrwWInOHmW4/I3w=;
 b=O8TkrfhW44YF099Aa8nhSptSOE7kxVd6AzgSwc2cxHtF+LS8/zS+IwNbSl/xtVkGS8
 Qq2kCbkPRiE9ZRlPHezrNFOOYu/yJD8JyYoh4mOkg5FrfjYka8kWqr32NJsmFBerc76E
 tvhaYxXZYWAeRdFNGPkmycizK2PPQuMOmQc7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=BzRjVu+EMuv9TXzLN/p4U2NjYfwhPrwWInOHmW4/I3w=;
 b=p0QN/A49bAV9YCGVOXnQXfqm/W5HeM2sNjStrNYdW+mwq7smUFYSlxPnwMWecSXoIY
 1aJLfycH8Yv/UNd49tjfYnPli6RO2LiVaslchTRlk5UdZKZ5Vuz9MqFAxPCLyCmIvE5N
 Pl/ci7Jcl1+iuU997rmDVe91J2ZmugpjpTAVc3yNrlpLWwXEUWo2ylt2ACvfSahijt/Q
 fwZ1SWbjHw5IOAWib5VkjCiVVDbuvpYxss0pObJNevKmNk/hhchuzkZkWM8jAI2qTXtW
 5f8F++Jdkqi3tMtSraMEBZPCDrMW1GIQYaYxZIMOQ9dwYMaSimO88aX2xhtu/mYS3UTB
 LPmQ==
X-Gm-Message-State: AGi0PuYHSAPTqrvPESdT1BPLiH/YgkVCoJad5T5WPO0SRtrNbEwWTcdl
 CGfYzQAf0QAB189j35DWCpj1/Q==
X-Google-Smtp-Source: APiQypKJ1MNetUU8utsqj1Ik4usdjvvYwqTYeq4FFAegOarmg0444uFui4rAyJFn3nGoklVWo1gvPg==
X-Received: by 2002:ac8:370c:: with SMTP id o12mr941004qtb.380.1588721632637; 
 Tue, 05 May 2020 16:33:52 -0700 (PDT)
Received: from [10.230.185.151] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id j90sm3139771qte.20.2020.05.05.16.33.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2020 16:33:52 -0700 (PDT)
Subject: Re: [PATCH 03/16] nvme: introduce NVME_NS_METADATA_SUPPORTED flag
To: Max Gurtovoy <maxg@mellanox.com>, linux-nvme@lists.infradead.org,
 kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, martin.petersen@oracle.com,
 jsmart2021@gmail.com, axboe@kernel.dk
References: <20200504155755.221125-1-maxg@mellanox.com>
 <20200504155755.221125-4-maxg@mellanox.com>
From: James Smart <james.smart@broadcom.com>
Message-ID: <e21354ca-a7bb-cf2d-d427-c8410c797a49@broadcom.com>
Date: Tue, 5 May 2020 16:33:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200504155755.221125-4-maxg@mellanox.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200505_163355_290032_9041F67E 
X-CRM114-Status: GOOD (  24.20  )
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

CgpPbiA1LzQvMjAyMCA4OjU3IEFNLCBNYXggR3VydG92b3kgd3JvdGU6Cj4gVGhpcyBpcyBhIHBy
ZXBhcmF0aW9uIGZvciBhZGRpbmcgc3VwcG9ydCBmb3IgbWV0YWRhdGEgaW4gZmFicmljCj4gY29u
dHJvbGxlcnMuIE5ldyBmbGFnIHdpbGwgaW1wbHkgdGhhdCBOVk1lIG5hbWVzcGFjZSBzdXBwb3J0
cyBnZXR0aW5nCj4gbWV0YWRhdGEgdGhhdCB3YXMgb3JpZ2luYWxseSBnZW5lcmF0ZWQgYnkgaG9z
dCdzIGJsb2NrIGxheWVyLgo+Cj4gU2lnbmVkLW9mZi1ieTogTWF4IEd1cnRvdm95IDxtYXhnQG1l
bGxhbm94LmNvbT4KPiBSZXZpZXdlZC1ieTogSXNyYWVsIFJ1a3NoaW4gPGlzcmFlbHJAbWVsbGFu
b3guY29tPgo+IFJldmlld2VkLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4KPiAt
LS0KPiAgIGRyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYyB8IDQxICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKystLS0tLS0tCj4gICBkcml2ZXJzL252bWUvaG9zdC9udm1lLmggfCAgMSAr
Cj4gICAyIGZpbGVzIGNoYW5nZWQsIDM1IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pCj4K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jIGIvZHJpdmVycy9udm1lL2hv
c3QvY29yZS5jCj4gaW5kZXggMWQyMjZjYy4uNGI3ZmFmOSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJz
L252bWUvaG9zdC9jb3JlLmMKPiArKysgYi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMKPiBAQCAt
MTg4MiwxMyArMTg4MiwyNyBAQCBzdGF0aWMgdm9pZCBudm1lX3VwZGF0ZV9kaXNrX2luZm8oc3Ry
dWN0IGdlbmRpc2sgKmRpc2ssCj4gICAJYmxrX3F1ZXVlX2lvX21pbihkaXNrLT5xdWV1ZSwgcGh5
c19icyk7Cj4gICAJYmxrX3F1ZXVlX2lvX29wdChkaXNrLT5xdWV1ZSwgaW9fb3B0KTsKPiAgIAo+
IC0JaWYgKG5zLT5tcyAmJiAhKG5zLT5mZWF0dXJlcyAmIE5WTUVfTlNfRVhUX0xCQVMpICYmCj4g
LQkgICAgKG5zLT5jdHJsLT5vcHMtPmZsYWdzICYgTlZNRV9GX01FVEFEQVRBX1NVUFBPUlRFRCkp
Cj4gLQkJbnZtZV9pbml0X2ludGVncml0eShkaXNrLCBucy0+bXMsIG5zLT5waV90eXBlKTsKPiAt
CWlmICgobnMtPm1zICYmICFudm1lX25zX2hhc19waShucykgJiYgIWJsa19nZXRfaW50ZWdyaXR5
KGRpc2spKSB8fAo+IC0JICAgIG5zLT5sYmFfc2hpZnQgPiBQQUdFX1NISUZUKQo+ICsJLyoKPiAr
CSAqIFRoZSBibG9jayBsYXllciBjYW4ndCBzdXBwb3J0IExCQSBzaXplcyBsYXJnZXIgdGhhbiB0
aGUgcGFnZSBzaXplCj4gKwkgKiB5ZXQsIHNvIGNhdGNoIHRoaXMgZWFybHkgYW5kIGRvbid0IGFs
bG93IGJsb2NrIEkvTy4KPiArCSAqLwo+ICsJaWYgKG5zLT5sYmFfc2hpZnQgPiBQQUdFX1NISUZU
KQo+ICAgCQljYXBhY2l0eSA9IDA7Cj4gICAKPiArCS8qCj4gKwkgKiBSZWdpc3RlciBhIG1ldGFk
YXRhIHByb2ZpbGUgZm9yIFBJLCBvciB0aGUgcGxhaW4gbm9uLWludGVncml0eSBOVk1lCj4gKwkg
KiBtZXRhZGF0YSBtYXNxdWVyYWRpbmcgYXMgVHlwZSAwIGlmIHN1cHBvcnRlZCwgb3RoZXJ3aXNl
IHJlamVjdCBibG9jawo+ICsJICogSS9PIHRvIG5hbWVzcGFjZXMgd2l0aCBtZXRhZGF0YSBleGNl
cHQgd2hlbiB0aGUgbmFtZXNwYWNlIHN1cHBvcnRzCj4gKwkgKiBQSSwgYXMgaXQgY2FuIHN0cmlw
L2luc2VydCBpbiB0aGF0IGNhc2UuCj4gKwkgKi8KPiArCWlmIChucy0+bXMpIHsKPiArCQlpZiAo
SVNfRU5BQkxFRChDT05GSUdfQkxLX0RFVl9JTlRFR1JJVFkpICYmCj4gKwkJICAgIChucy0+ZmVh
dHVyZXMgJiBOVk1FX05TX01FVEFEQVRBX1NVUFBPUlRFRCkpCj4gKwkJCW52bWVfaW5pdF9pbnRl
Z3JpdHkoZGlzaywgbnMtPm1zLCBucy0+cGlfdHlwZSk7Cj4gKwkJZWxzZSBpZiAoIW52bWVfbnNf
aGFzX3BpKG5zKSkKPiArCQkJY2FwYWNpdHkgPSAwOwo+ICsJfQo+ICsKTG9vayBiZWxvdyBmb3Ig
aG93IEkgaW50ZXJwcmV0IHRoZSBtZWFuaW5nIG9mIHRoZSAKTlZNRV9OU19NRVRBREFUQV9TVVBQ
T1JURUQgZmxhZy4gSXQncyBhIHJvbGx1cCBvZiBzZXZlcmFsIGNvbmRpdGlvbnMuIApOb3QgYWxs
IG9mIHRob3NlIGNvbmRpdGlvbnMgYXJlIGNvbnNpZGVyZWQgaW4gdGhlIGVsc2UgY2xhdXNlLgoK
VGhlICJlbHNlIGlmIiBjbGF1c2UgbG9va3MgdG9vIGxpZ2h0IHRvIGFkZHJlc3MgYWxsIHRoZSBj
YXNlcyB3aGVyZSAKY2FwYWNpdHkgc2hvdWxkIGJlIHNldCB0byAwLiBQcm9iYWJseSBzaG91bGRu
J3QgYmUgYW4gZWxzZS4KRXhhbXBsZXM6Ci0gISBJU19FTkFCTEVEKENPTkZJR19CTEtfREVWX0lO
VEVHUklUWSkgJiBtZXRhIGlzIHBpwqDCoCAoYWthIG52bWVfaHNfaGFzX3BpKQotIG1ldGEgaXMg
bm90IHBpICh0aHVzIHBpX3R5cGU9MCBpbiBjYWxsIHRvIG52bWVfaW5pdF9pbnRlZ3JpdHkoKSks
IAp3aGljaCByZXN1bHRzIGluwqAgIWJsa19nZXRfaW50ZWdyaXR5KGRpc2spIHdoaWNoIGlzIG5v
dCBjaGVja2VkLgotIG1ldGEgaXMgcGkgYW5kOgogwqAgLSAhbnMtPmN0cmwtPm9wcy0+ZmxhZ3Mg
JiBOVk1FX0ZfTUVUQURBVEFfU1VQUE9SVEVECiDCoCAtICFucy0+ZmVhdHVyZXMgJiBOVk1FX05T
X0VYVF9MQkFTCgptYXkgYmUgYSBjb3VwbGUgb3RoZXJzLgoKPiAgIAlzZXRfY2FwYWNpdHlfcmV2
YWxpZGF0ZV9hbmRfbm90aWZ5KGRpc2ssIGNhcGFjaXR5LCBmYWxzZSk7Cj4gICAKPiAgIAludm1l
X2NvbmZpZ19kaXNjYXJkKGRpc2ssIG5zKTsKPiBAQCAtMTkyMywxNCArMTkzNywyNyBAQCBzdGF0
aWMgdm9pZCBfX252bWVfcmV2YWxpZGF0ZV9kaXNrKHN0cnVjdCBnZW5kaXNrICpkaXNrLCBzdHJ1
Y3QgbnZtZV9pZF9ucyAqaWQpCj4gICAKPiAgIAlucy0+ZmVhdHVyZXMgPSAwOwo+ICAgCW5zLT5t
cyA9IGxlMTZfdG9fY3B1KGlkLT5sYmFmW2lkLT5mbGJhcyAmIE5WTUVfTlNfRkxCQVNfTEJBX01B
U0tdLm1zKTsKPiAtCWlmIChucy0+bXMgJiYgKGlkLT5mbGJhcyAmIE5WTUVfTlNfRkxCQVNfTUVU
QV9FWFQpKQo+IC0JCW5zLT5mZWF0dXJlcyB8PSBOVk1FX05TX0VYVF9MQkFTOwo+ICAgCS8qIHRo
ZSBQSSBpbXBsZW1lbnRhdGlvbiByZXF1aXJlcyBtZXRhZGF0YSBlcXVhbCB0MTAgcGkgdHVwbGUg
c2l6ZSAqLwo+ICAgCWlmIChucy0+bXMgPT0gc2l6ZW9mKHN0cnVjdCB0MTBfcGlfdHVwbGUpKQo+
ICAgCQlucy0+cGlfdHlwZSA9IGlkLT5kcHMgJiBOVk1FX05TX0RQU19QSV9NQVNLOwo+ICAgCWVs
c2UKPiAgIAkJbnMtPnBpX3R5cGUgPSAwOwo+ICAgCj4gKwlpZiAobnMtPm1zKSB7Cj4gKwkJaWYg
KGlkLT5mbGJhcyAmIE5WTUVfTlNfRkxCQVNfTUVUQV9FWFQpCj4gKwkJCW5zLT5mZWF0dXJlcyB8
PSBOVk1FX05TX0VYVF9MQkFTOwo+ICsKPiArCQkvKgo+ICsJCSAqIEZvciBQQ0ksIEV4dGVuZGVk
IGxvZ2ljYWwgYmxvY2sgd2lsbCBiZSBnZW5lcmF0ZWQgYnkgdGhlCj4gKwkJICogY29udHJvbGxl
ci4gTm9uLWV4dGVuZGVkIGZvcm1hdCBjYW4gYmUgZ2VuZXJhdGVkIGJ5IHRoZQo+ICsJCSAqIGJs
b2NrIGxheWVyLgo+ICsJCSAqLwo+ICsJCWlmIChucy0+Y3RybC0+b3BzLT5mbGFncyAmIE5WTUVf
Rl9NRVRBREFUQV9TVVBQT1JURUQpIHsKPiArCQkJaWYgKCEobnMtPmZlYXR1cmVzICYgTlZNRV9O
U19FWFRfTEJBUykpCj4gKwkJCQlucy0+ZmVhdHVyZXMgfD0gTlZNRV9OU19NRVRBREFUQV9TVVBQ
T1JURUQ7CgpTbyBJIGludGVycHJldCB0aGlzIGZsYWcgdG8gbWVhbjoKMSkgbmFtZXNwYWNlIGhh
cyBtZXRhZGF0YSwKMikgY29udHJvbGxlciB0cmFuc3BvcnQgc3VwcG9ydHMgbWV0YWRhdGEgKGFu
ZCBpbXBsaWNpdGx5OiBzaW5jZSBpdCdzIApwY2kgc28gZmFyIGl0J3MgdmlhIHNlcGFyYXRlIGJ1
ZmZlciBvbmx5KQozKSB0aGUgbnZtZSBjb250cm9sbGVyIHJlcXVpcmVzIGEgc2VwYXJhdGUgbWV0
YWRhdGEgYnVmZmVyICh0aHVzIGl0IAptYXRjaGVzIHRoZSB0cmFuc3BvcnQpLgo0KSBhbmQgaW1w
bGljaXRseSwgaWYgd2UncmUgZ29pbmcgdG8gaGF2ZSBESUYsIHRoZSBibG9jayBsYXllciB3aWxs
IGdpdmUgCnVzIGEgc2VwYXJhdGUgYnVmZmVyLgpub3RlOiBhbGwgYmV0cyBhcmUgb2ZmIGlmIHRo
ZSBtZXRhZGF0YSBpc24ndCBmb3IgRElGLiBidXQgdGhhdCdzIG5vdCAKaGFuZGxlZCBoZXJlLi4u
Li4KCkkgd2lzaCB0aGUgY29tbWVudCBleHBsYWluZWQgdGhhdC4KCkFuZCBvZiBjb3Vyc2UgdGhl
c2Ugd2lsbCBjaGFuZ2Ugd2l0aCBmYWJyaWNzIGFzIGl0IHdpbGwgYmUgZXhwZWN0ZWQgdGhhdCAK
bnMncyBvbiBmYWJyaWNzIHdpbGwgYmUgbnMtPmZlYXR1cmVzICYgTlZNRV9OU19FWFRfTEJBUy4g
QnV0IC0gdGhhdCAKaXNuJ3QgcGFydCBvZiB0aGlzIGNvbW1pdC7CoCBTbyBkb2Vzbid0IGNvdW50
IGFnYWluc3QgdGhpcyBwYXRjaC4KCj4gKwkJfQo+ICsJfQo+ICsKPiAgIAlpZiAoaW9iKQo+ICAg
CQlibGtfcXVldWVfY2h1bmtfc2VjdG9ycyhucy0+cXVldWUsIHJvdW5kZG93bl9wb3dfb2ZfdHdv
KGlvYikpOwo+ICAgCW52bWVfdXBkYXRlX2Rpc2tfaW5mbyhkaXNrLCBucywgaWQpOwo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9udm1lLmggYi9kcml2ZXJzL252bWUvaG9zdC9udm1l
LmgKPiBpbmRleCAxMTA1NzdjNy4uMGRkYTE0NSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL252bWUv
aG9zdC9udm1lLmgKPiArKysgYi9kcml2ZXJzL252bWUvaG9zdC9udm1lLmgKPiBAQCAtMzY2LDYg
KzM2Niw3IEBAIHN0cnVjdCBudm1lX25zX2hlYWQgewo+ICAgCj4gICBlbnVtIG52bWVfbnNfZmVh
dHVyZXMgewo+ICAgCU5WTUVfTlNfRVhUX0xCQVMgPSAxIDw8IDAsIC8qIHN1cHBvcnQgZXh0ZW5k
ZWQgTEJBIGZvcm1hdCAqLwo+ICsJTlZNRV9OU19NRVRBREFUQV9TVVBQT1JURUQgPSAxIDw8IDEs
IC8qIHN1cHBvcnQgZ2V0dGluZyBnZW5lcmF0ZWQgbWQgKi8KPiAgIH07Cj4gICAKPiAgIHN0cnVj
dCBudm1lX25zIHsKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpsaW51eC1udm1lIG1haWxpbmcgbGlzdApsaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1l
Cg==
