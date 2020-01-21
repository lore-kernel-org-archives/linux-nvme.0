Return-Path: <SRS0=JmHd=3K=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92F4C2D0CE
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jan 2020 17:40:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7056722522
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jan 2020 17:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Nghou2kp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gKTHAsDq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7056722522
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=s65PTXEm8oi9OTQBPT1GI7yPYFZ1AQT6p0vhARk7/6A=; b=Nghou2kpTHHb3kPmZq4Pwn5YY
	Gxq0Ei+bwEblnsvY8vHbw6a9PIjYtMffCu21q13Ud1eo/H8m6bCPVKaGbDKBAVzWwf/Uy3HMudJ8g
	OqNTTz+Qjb8xVlDZ/sYl1DEIrUSmlt82b41H2p5RAkXHjSq15GQgd8Dtk31PtjWT+pLPGyJ+bUyFR
	pY0hEXIX85f90s2oKZag6A4aKczGxy1Z9Zt/E78ZOUGddzwsfDKGJTEbvvhfZotzF47axxPd396sb
	SqQIC8HidCCSKFU8XINvwTnr8+ox4AASMcPIDeS71c4lZn4/1NZJU6U4rxRWdyHHhn4JiLV5QqnVe
	jh3kGsZKQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1itxW6-0003eG-B8; Tue, 21 Jan 2020 17:40:42 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1itxW0-0003d3-BZ
 for linux-nvme@lists.infradead.org; Tue, 21 Jan 2020 17:40:41 +0000
Received: by mail-wr1-x441.google.com with SMTP id y11so4236215wrt.6
 for <linux-nvme@lists.infradead.org>; Tue, 21 Jan 2020 09:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=p5ou2HSZ04Dgd0tIFYjhH+o9daOfZDF9tReOwzx5fCg=;
 b=gKTHAsDq/u2nCtjbe8tn80YotGNyStvIQ2gPGmBQ7StLC8Vm2tXRe1jGX2k8czvGRJ
 MIbOpxD2HkMEyECynsKQhZiUiLkj5KA1yUfygK4VpWv4yvel//jdAYw6M9wZS9Iph6Wl
 H31om/ZhbzGMisJS4rz786JToqcldcqbW3c2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=p5ou2HSZ04Dgd0tIFYjhH+o9daOfZDF9tReOwzx5fCg=;
 b=qmd0UTz4RMTwqN1t0RavzuXpa34m4tQpMJDTDDO3JSm5H1tuKnS2eT1frHLHOa+Uj1
 AmKpr3mKDgEPO9tY3IcIPfnfp1/skW0hmcjPT9tpWC/FUOfhNKpY2Tt1pd2iDKwv6U9a
 uv7WoiU6r39RKYsimCsGH5bHB9elHjK8dv7XyVbf5wXImquuBsEKzS8MhmfKQnG/6QC5
 SIPTNhVubfUpSZITgxaZR1MsEcvfxcgAzl5PcG2X1F2ukcTfjMkmR8N7LYSTanNWg+E8
 i4wRGg0rUk7usEYaH8SL6JHeDHxTSfOY5bgMTbObl7WDpVQsj7azktPIUpoSJIsvbXd2
 XEzg==
X-Gm-Message-State: APjAAAUxYgk1mL8mDLnWqRPBnrqjKuIL7P1Z/MGoon7wF0Suf8+lrnGQ
 GzVuFKjvNrWCX39qOwhIyxh+BA==
X-Google-Smtp-Source: APXvYqwSjpjOQvGnvgzbynos3xb0KeVo1QDpCqaSBR62z4+avvBE2kZijxd/97AeLqWTUOelZOngMQ==
X-Received: by 2002:adf:c74f:: with SMTP id b15mr6283735wrh.272.1579628434291; 
 Tue, 21 Jan 2020 09:40:34 -0800 (PST)
Received: from [10.69.45.46] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id f16sm53545938wrm.65.2020.01.21.09.40.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2020 09:40:33 -0800 (PST)
Subject: Re: [PATCH 02/15] nvme: Enforce extended LBA format for fabrics
 metadata
To: Max Gurtovoy <maxg@mellanox.com>, linux-nvme@lists.infradead.org,
 kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, martin.petersen@oracle.com
References: <20200106133736.123038-1-maxg@mellanox.com>
 <20200106133736.123038-4-maxg@mellanox.com>
 <57aa8b5c-b8c9-7617-bc11-b6797587fdc8@broadcom.com>
 <d7b94f4e-4a75-941f-3cf6-22001c1850a3@mellanox.com>
From: James Smart <james.smart@broadcom.com>
Message-ID: <82e2093a-5fcd-0731-7ee3-22405cfb31f6@broadcom.com>
Date: Tue, 21 Jan 2020 09:40:29 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <d7b94f4e-4a75-941f-3cf6-22001c1850a3@mellanox.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200121_094036_403307_0BBC281D 
X-CRM114-Status: GOOD (  22.66  )
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
Cc: axboe@kernel.dk, vladimirk@mellanox.com, idanb@mellanox.com,
 israelr@mellanox.com, shlomin@mellanox.com, oren@mellanox.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiAxLzE5LzIwMjAgMzoyMCBBTSwgTWF4IEd1cnRvdm95IHdyb3RlOgo+Cj4gT24gMS8xNy8y
MDIwIDE6NTMgQU0sIEphbWVzIFNtYXJ0IHdyb3RlOgo+Pgo+Pgo+PiBPbiAxLzYvMjAyMCA1OjM3
IEFNLCBNYXggR3VydG92b3kgd3JvdGU6Cj4+PiBBbiBleHRlbmRlZCBMQkEgaXMgYSBsYXJnZXIg
TEJBIHRoYXQgaXMgY3JlYXRlZCB3aGVuIG1ldGFkYXRhIAo+Pj4gYXNzb2NpYXRlZAo+Pj4gd2l0
aCB0aGUgTEJBIGlzIHRyYW5zZmVycmVkIGNvbnRpZ3VvdXNseSB3aXRoIHRoZSBMQkEgZGF0YSAo
QUtBCj4+PiBpbnRlcmxlYXZlZCkuIFRoZSBtZXRhZGF0YSBtYXkgYmUgZWl0aGVyIHRyYW5zZmVy
cmVkIGFzIHBhcnQgb2YgdGhlIExCQQo+Pj4gKGNyZWF0aW5nIGFuIGV4dGVuZGVkIExCQSkgb3Ig
aXQgbWF5IGJlIHRyYW5zZmVycmVkIGFzIGEgc2VwYXJhdGUKPj4+IGNvbnRpZ3VvdXMgYnVmZmVy
IG9mIGRhdGEuIEFjY29yZGluZyB0byB0aGUgTlZNZW9GIHNwZWMsIGEgZmFicmljcyBjdHJsCj4+
PiBzdXBwb3J0cyBvbmx5IGFuIEV4dGVuZGVkIExCQSBmb3JtYXQuIEZhaWwgcmV2YWxpZGF0aW9u
IGluIGNhc2Ugd2UgCj4+PiBoYXZlIGEKPj4+IHNwZWMgdmlvbGF0aW9uLiBBbHNvIGluaXRpYWxp
emUgdGhlIGludGVncml0eSBwcm9maWxlIGZvciB0aGUgYmxvY2sgCj4+PiBkZXZpY2UKPj4+IGZv
ciBmYWJyaWNzIGN0cmwuCj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogTWF4IEd1cnRvdm95IDxtYXhn
QG1lbGxhbm94LmNvbT4KPj4+IFNpZ25lZC1vZmYtYnk6IElzcmFlbCBSdWtzaGluIDxpc3JhZWxy
QG1lbGxhbm94LmNvbT4KPj4+IC0tLQo+Pj4gwqAgZHJpdmVycy9udm1lL2hvc3QvY29yZS5jIHwg
MjUgKysrKysrKysrKysrKysrKysrKysrLS0tLQo+Pj4gwqAgMSBmaWxlIGNoYW5nZWQsIDIxIGlu
c2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bnZtZS9ob3N0L2NvcmUuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYwo+Pj4gaW5kZXggZDk4
ZWI0OC4uMDg5Y2RjM2MgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMK
Pj4+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYwo+Pj4gQEAgLTE4MTgsNyArMTgxOCw3
IEBAIHN0YXRpYyB2b2lkIG52bWVfdXBkYXRlX2Rpc2tfaW5mbyhzdHJ1Y3QgCj4+PiBnZW5kaXNr
ICpkaXNrLAo+Pj4gwqDCoMKgwqDCoCBibGtfbXFfdW5mcmVlemVfcXVldWUoZGlzay0+cXVldWUp
Owo+Pj4gwqAgfQo+Pj4gwqAgLXN0YXRpYyB2b2lkIF9fbnZtZV9yZXZhbGlkYXRlX2Rpc2soc3Ry
dWN0IGdlbmRpc2sgKmRpc2ssIHN0cnVjdCAKPj4+IG52bWVfaWRfbnMgKmlkKQo+Pj4gK3N0YXRp
YyBpbnQgX19udm1lX3JldmFsaWRhdGVfZGlzayhzdHJ1Y3QgZ2VuZGlzayAqZGlzaywgc3RydWN0
IAo+Pj4gbnZtZV9pZF9ucyAqaWQpCj4+PiDCoCB7Cj4+PiDCoMKgwqDCoMKgIHN0cnVjdCBudm1l
X25zICpucyA9IGRpc2stPnByaXZhdGVfZGF0YTsKPj4+IMKgIEBAIC0xODQ2LDExICsxODQ2LDIx
IEBAIHN0YXRpYyB2b2lkIF9fbnZtZV9yZXZhbGlkYXRlX2Rpc2soc3RydWN0IAo+Pj4gZ2VuZGlz
ayAqZGlzaywgc3RydWN0IG52bWVfaWRfbnMgKmlkKQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgbnMtPmZlYXR1cmVzIHw9IE5WTUVfTlNfRVhUX0xCQVM7Cj4+PiDCoCDCoMKgwqDCoMKg
wqDCoMKgwqAgLyoKPj4+ICvCoMKgwqDCoMKgwqDCoMKgICogRm9yIEZhYnJpY3MsIG9ubHkgbWV0
YWRhdGEgYXMgcGFydCBvZiBleHRlbmRlZCBkYXRhIExCQSBpcwo+Pj4gK8KgwqDCoMKgwqDCoMKg
wqAgKiBzdXBwb3J0ZWQuIEZhaWwgaW4gY2FzZSBvZiBhIHNwZWMgdmlvbGF0aW9uLgo+Pj4gK8Kg
wqDCoMKgwqDCoMKgwqAgKi8KPj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAobnMtPmN0cmwtPm9wcy0+
ZmxhZ3MgJiBOVk1FX0ZfRkFCUklDUykgewo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYg
KFdBUk5fT05fT05DRSghKG5zLT5mZWF0dXJlcyAmIE5WTUVfTlNfRVhUX0xCQVMpKSkKPj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FSU5WQUw7Cj4+PiArwqDCoMKg
wqDCoMKgwqAgfQo+Pj4gKwo+Pj4gK8KgwqDCoMKgwqDCoMKgIC8qCj4+PiDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAqIEZvciBQQ0ksIEV4dGVuZGVkIGxvZ2ljYWwgYmxvY2sgd2lsbCBiZSBnZW5lcmF0
ZWQgYnkgdGhlCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIGNvbnRyb2xsZXIuCj4+PiDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAqLwo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChucy0+Y3RybC0+
b3BzLT5mbGFncyAmIE5WTUVfRl9NRVRBREFUQV9TVVBQT1JURUQpIHsKPj4+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGlmICghKG5zLT5mZWF0dXJlcyAmIE5WTUVfTlNfRVhUX0xCQVMpKQo+Pj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKG5zLT5jdHJsLT5vcHMtPmZsYWdzICYgTlZNRV9G
X0ZBQlJJQ1MgfHwKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIShucy0+ZmVh
dHVyZXMgJiBOVk1FX05TX0VYVF9MQkFTKSkKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgbnMtPmZlYXR1cmVzIHw9IE5WTUVfTlNfRElYX1NVUFBPUlRFRDsKPj4KPj4gVGhp
cyBsYXN0IGNoYW5nZSBzZWVtcyBvZGQgLSB3aHkgaXMgRElYIHNldCBpZiBOVk1FX0ZfRkFCUklD
UyA/Cj4+Cj4+IFBlciBwYXRjaCBkZXNjcmlwdGlvbiBhYm92ZSwgRmFicmljcyBzcGVjIHJlcXVp
cmVzIG1ldGFkYXRhIGFzIGFuIAo+PiBleHRlbmRlZCBMQkEsIHRodXMgaXQgZG9lc24ndCBzdXBw
b3J0IERJWC4KPgo+IHdlIHJlZmVyIERJWCBhcyBtZW1vcnkgZG9tYWluIG1ldGFkYXRhLgoKSXQn
cyBmaW5lLsKgIEJ1dCBzb21ld2hlcmUgd2UgbmVlZCB0byBiZSBjbGVhciB0aGF0ICJESVgiIGFz
IGl0J3MgCnJlZmVyZW5jZWQgaGVyZSBpcyByZWxhdGl2ZSB0byB0aGUgT1MgdG8gaG9zdCBwb3J0
IGludGVyZmFjZSBhbmQgaXMgbm90IAoiRElYIiBhcyBwZXIgTlZNRSBzdGRzIGRlZmluaXRpb24u
IFRoZSBmbGFnIHlvdSBhcmUgc2V0dGluZyBvbiB0aGUgbnMgCmZlYXR1cmVzIGlzICpub3QqIGEg
bnMgYXR0cmlidXRlIGFzIHJlYWQgZnJvbSB0aGUgY29udHJvbGxlci7CoCBBIGNvbW1lbnQgCnNo
b3VsZCBiZSBoYWQgc29tZXdoZXJlLgoKCj4KPj4KPj4gV2hpY2ggaXMgdG91Y2hlcyBvbiBhIGxv
dCBvZiBvZGQgdGhpbmdzIHdpdGggdGhlIG52bWUgc3BlYyBhcyBpdCdzIAo+PiBjZXJ0YWlubHkg
cG9zc2libGUgZm9yLCB3aXRoaW4gdGhlIG9zIGhvc3QgaW1wbGVtZW50YXRpb24sIHRvIGhhdmUg
Cj4+IHRoZSBob3N0IHRyYW5zbWl0dGluZyBlbmdpbmUgdG8gY29udmVydCBhbiBPUyBzZXBhcmF0
ZSBESUYgYnVmIHRvIGFuIAo+PiBleHRlbmRlZCBsYmEgdHJhbnNtaXNzaW9uIG9uIHRoZSB3aXJl
IGFuZCBhcyBwcmVzZW50ZWQgdG8gdGhlIAo+PiBjb250cm9sbGVyLsKgIFRyYW5zcG9ydHMgY2Fu
IGNlcnRhaW5seSBoZWxwIG1ha2UgdGhpcyBoYXBwZW4gLSBhbmQgYWRkIAo+PiBlZ3Jlc3MgY2hl
Y2tpbmcgYXMgdGhlIGRhdGEgbGVhdmVzIHRoZSBob3N0LsKgwqDCoCBXaGljaCBtZWFucyAtIEkn
bSBub3QgCj4+IHN1cmUgdGhpcyBoYXJkIERJWCBkZWZpbml0aW9uIGJlaW5nIGltcGxlbWVudGVk
IHRoaXMgd2F5IGlzIHRoZSB3YXkgCj4+IHRvIGdvLgo+Cj4gUkRNQSB0cmFuc3BvcnQgaXMgY29u
dmVydGluZyBzZXBhcmF0ZWQgU0dMcyAobm9uLWV4dGVuZGVkIG1vZGUpIHRoYXQgCj4gc2VudCBi
eSB0aGUgYmxvY2sgbGF5ZXIgdG8gZXh0ZW5kZWQgbW9kZS4KPgo+IFRoZSBpZGVhIGhlcmUgaXMg
dG8gZGVmaW5lIG9uIHdoaWNoIGNvbmRpdGlvbnMgd2UnbGwgYXNrIHRoZSBibG9jayAKPiBsYXll
ciB0byBzZXQgaXQncyBtZXRhZGF0YSBpbmZyYXN0cnVjdHVyZS4KPgo+IGZvciBQQ0kgLSBvbmx5
IGluIGNhc2Ugb2Ygbm9uLWV4dGVuZGVkIG1vZGUgKGluIGV4dGVuZGVkIG1vZGUgdGhlIAo+IGJs
b2NrIGxheWVyIHdpbGwgbm90IHNldCBpbnRlZ3JpdHksIGFuZCB0aGUgbnZtZSBkcml2ZXIgd2ls
bCBzZXQgdGhlIAo+IFBSQUNUL1BSQ0hLIGlmIG5lZWRlZCkgc2luY2UgdGhlcmUgaXMgbm8gY29u
dmVyc2lvbiB0byBleHRlbmRlZCBtb2RlIAo+IGluIHRoZSBudm1lIGRyaXZlci4KPgo+IGZvciBm
YWJyaWNzIC0gYWx3YXlzIGFzayBmb3IgYmxrIGludGVncml0eSBzZXR0aW5nIHNpbmNlIHRoZSB0
cmFuc3BvcnQgCj4gKFJETUEgb25seSBmb3Igbm93KSBpcyByZXNwb25zaWJsZSBmb3IgdHJhbnNm
ZXJyaW5nIGl0IHRvIGV4dGVuZGVkIAo+IG1vZGUgb24gdGhlIHdpcmUuCgpZZXAgYWdyZWUuIEJ1
dCB0aGVyZSBzaG91bGQgYmUgYSBjb21tZW50IG9uIHdoYXQgaXMgaGFwcGVuaW5nIHdpdGhpbiB0
aGUgCk9TIHRvIGhvc3QgcG9ydCBpbnRlcmZhY2UgdnMgd2hhdCBpcyBoYXBwZW5pbmcgcGVyIHRo
ZSBudm1lIHN0ZC4gSXQgCnNlZW1zIHRvIGdldCBtdWRkbGVkLgoKLS0gamFtZXMKCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1udm1lIG1haWxp
bmcgbGlzdApsaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
