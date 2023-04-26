Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED78EC77B60
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Apr 2023 05:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S2Jfnb6ro7EVun0ayPaQLe3PkcVol3fn2zd9IaPlrlE=; b=GfZ2lFUGa8h6TwF2CPb6BjWjAD
	M6/rHhmOYSsBhQ05Li+S7zFd+u65SJB836oxFIrVFqt/vjGdU0a3lsmH62Nn94VPb8tH7EH6vUUQj
	MCmKyGSCYvKfHy6ZFeu+ci4EGz8gAFzN18Quz+3rrabffmk9qsvlEV91YwYD41e1CSHdrs+5UW0YX
	gtwLfg42FxfZrRXUAd5iVRaeAFlSifCidRkmtq8dSjIlh7dOMvOLhoCcaUwiiSvGd/niP4/nWlSUi
	9fjpO8gvDIp7WwJeF33gGWIWPjSWPU8KM4Pc54mYCDuwvoYMhpnucJ02YS1vjmyyc2//6GEetC/YL
	CHfHJHpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1prYAO-002soA-1U;
	Wed, 26 Apr 2023 05:58:12 +0000
Received: from a1-bg02.venev.name ([213.240.239.49])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1prYAL-002snJ-0h
	for linux-nvme@lists.infradead.org;
	Wed, 26 Apr 2023 05:58:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=venev.name;
	s=default; h=Content-Transfer-Encoding:Content-Type:Date:To:From:Subject:
	Message-ID:Reply-To:Sender; bh=S2Jfnb6ro7EVun0ayPaQLe3PkcVol3fn2zd9IaPlrlE=; 
	b=dLhcRtwG0JkoRMdDnpQjsMhZTMZH5ygYmZHNkexenHLz7qg5rBKqrR+Vh0MukCQZa96u1/SvqrL
	icqqLHKunHwncgOCbs2KiObcA2e3vli3Jm47GmCsOFXHRfMeweLoONgGUmL7fK/mqFxhyT/vxfxfW
	iYaoB2ajg4RUlaG1ZTaqCqSukBR7Myyyd9LdB0vRn4XmcrrDUYeRn3I/xNWoI8LNqTD11d4/iK0CR
	XPA+7jzwr+hYonsgDLf+51nlT1BtJqc5dx31Lul2XAwl8NAJPWyFPLz763R+i+9aHBjwSjjqAULrb
	7PQcAPP5j5YXtrPFFdvI8Yr0N1d/M2FSAdKdPGFxjfp1RqBDfW5MjyBBX7a8E1cUv6hJwNMbCdNED
	d4H1br5tXc2qPXDQwW+MzIFmx8WK4wvCTh+iH4VQcVcfZdW73ULYlDLOzHl2mB8w8cq5swtr8PxEb
	dbDG2n8sMhwKYnVW7s4m+RSzyxQFHYCUjVr/BBMmhVq0pikV7c7c5tAlh8oHReKQ1Ngti0N2F5dha
	RK78SjEe12JSNJCq07NI+1j/ePniZotK5tOPFE072Gkt9mS9yjMdlQr1Xg2Vo0/o4AH18AnLfT6lo
	O/GNXNrZPLDt9JISRLPaATUHpkEv4ysPznn+fsSfpGU+vb6EzDH1wpsjGcT6EZhdjPN4Q=;
Received: from a1-bg02.venev.name ([213.240.239.49] helo=pmx1.venev.name)
	by a1-bg02.venev.name with esmtps
	id 1prY9x-001TEU-0N
	(TLS1.3:TLS_AES_256_GCM_SHA384:256)
	(envelope-from <hristo@venev.name>);
	Wed, 26 Apr 2023 05:57:45 +0000
Received: from a1-bg02.venev.name ([213.240.239.49])
	by pmx1.venev.name with ESMTPSA
	id M8KDOFi9SGTrWQUAdB6GMg
	(envelope-from <hristo@venev.name>); Wed, 26 Apr 2023 05:57:45 +0000
Message-ID: <386668a7596beb52443c14fb33bfb5f329895509.camel@venev.name>
Subject: Re: [PATCH] nvme-pci: add quirk for missing secondary temperature
 thresholds
From: Hristo Venev <hristo@venev.name>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
Date: Wed, 26 Apr 2023 08:57:44 +0300
In-Reply-To: <5e8a5d87-3cc8-4141-bcea-34aff5a82149@roeck-us.net>
References: <20230425195853.322100-1-hristo@venev.name>
	 <5e8a5d87-3cc8-4141-bcea-34aff5a82149@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230425_225809_374409_85377F23 
X-CRM114-Status: GOOD (  27.82  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gVHVlLCAyMDIzLTA0LTI1IGF0IDE2OjM5IC0wNzAwLCBHdWVudGVyIFJvZWNrIHdyb3RlOgo+
IE9uIFR1ZSwgQXByIDI1LCAyMDIzIGF0IDEwOjU4OjU0UE0gKzAzMDAsIEhyaXN0byBWZW5ldiB3
cm90ZToKPiA+IE9uIEtpbmdzdG9uIEtDMzAwMCBhbmQgS2luZ3N0b24gRlVSWSBSZW5lZ2FkZSAo
Ym90aCBoYXZlIHRoZSBzYW1lCj4gPiBQQ0kKPiA+IElEcykgYWNjZXNzaW5nIHRlbXAzX3ttaW4s
bWF4fSBmYWlscyB3aXRoIGFuIGludmFsaWQgZmllbGQgZXJyb3IKPiA+IChub3RlCj4gPiB0aGF0
IHRoZXJlIGlzIG5vIHByb2JsZW0gc2V0dGluZyB0aGUgdGhyZXNob2xkcyBmb3IgdGVtcDEpLgo+
ID4gCj4gPiBUaGlzIGNvbnRyYWRpY3RzIHRoZSBOVk0gRXhwcmVzcyBCYXNlIFNwZWNpZmljYXRp
b24gMi4wYiwgcGFnZSAyOTI6Cj4gPiAKPiA+IMKgIFRoZSBvdmVyIHRlbXBlcmF0dXJlIHRocmVz
aG9sZCBhbmQgdW5kZXIgdGVtcGVyYXR1cmUgdGhyZXNob2xkCj4gPiDCoCBmZWF0dXJlcyBzaGFs
bCBiZSBpbXBsZW1lbnRlZCBmb3IgYWxsIGltcGxlbWVudGVkIHRlbXBlcmF0dXJlCj4gPiBzZW5z
b3JzCj4gPiDCoCAoaS5lLiwgYWxsIFRlbXBlcmF0dXJlIFNlbnNvciBmaWVsZHMgdGhhdCByZXBv
cnQgYSBub24temVybwo+ID4gdmFsdWUpLgo+ID4gCj4gPiBEZWZpbmUgTlZNRV9RVUlSS19OT19T
RUNPTkRBUllfVEVNUF9USFJFU0ggdGhhdCBkaXNhYmxlcyB0aGUKPiA+IHRocmVzaG9sZHMKPiA+
IGZvciBhbGwgYnV0IHRoZSBjb21wb3NpdGUgdGVtcGVyYXR1cmUgYW5kIHNldCBpdCBmb3IgdGhp
cyBkZXZpY2UuCj4gPiAKPiAKPiBUaGUgZGVzY3JpcHRpb24gYWJvdmUgc2F5cyB0aGF0IHRlbXAz
X3ttaW4sbWF4fSByZXR1cm4gZXJyb3JzLgo+IEhvdyBhYm91dCB0ZW1wMiA/IFRoaXMgcGF0Y2gg
ZGlzYWJsZXMgdGhhdCBhcyB3ZWxsLCBidXQgaXQgaXMgbm90Cj4gY2xlYXIKPiBpZiB0ZW1wMl97
bWluLG1heH0gcmV0dXJuIGVycm9ycyBhcyB3ZWxsLiBJZiB0ZW1wMiBsaW1pdHMgd29yaywKPiBk
aXNhYmxpbmcKPiB0aGVtIHdvdWxkIGJlIG92ZXJraWxsLgoKdGVtcDIgZG9lc24ndCBleGlzdC4g
VGhlIG9ubHkgdGVtcGVyYXR1cmUgc2Vuc29ycyBvbiB0aGF0IFNTRCBhcmUgdGVtcDEKYW5kIHRl
bXAzLgoKPiAKPiBUaGFua3MsCj4gR3VlbnRlcgo+IAo+ID4gU2lnbmVkLW9mZi1ieTogSHJpc3Rv
IFZlbmV2IDxocmlzdG9AdmVuZXYubmFtZT4KPiA+IC0tLQo+ID4gwqBkcml2ZXJzL252bWUvaG9z
dC9od21vbi5jIHwgMyArKy0KPiA+IMKgZHJpdmVycy9udm1lL2hvc3QvbnZtZS5owqAgfCA1ICsr
KysrCj4gPiDCoGRyaXZlcnMvbnZtZS9ob3N0L3BjaS5jwqDCoCB8IDIgKysKPiA+IMKgMyBmaWxl
cyBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPiA+IAo+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L2h3bW9uLmMgYi9kcml2ZXJzL252bWUvaG9zdC9od21v
bi5jCj4gPiBpbmRleCA5ZTZlNTZjMjBlYzkuLjdhMmM0YjVlMDE4YyAxMDA2NDQKPiA+IC0tLSBh
L2RyaXZlcnMvbnZtZS9ob3N0L2h3bW9uLmMKPiA+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L2h3
bW9uLmMKPiA+IEBAIC0xNjMsNyArMTYzLDggQEAgc3RhdGljIHVtb2RlX3QgbnZtZV9od21vbl9p
c192aXNpYmxlKGNvbnN0IHZvaWQKPiA+ICpfZGF0YSwKPiA+IMKgwqDCoMKgwqDCoMKgwqBjYXNl
IGh3bW9uX3RlbXBfbWF4Ogo+ID4gwqDCoMKgwqDCoMKgwqDCoGNhc2UgaHdtb25fdGVtcF9taW46
Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmICgoIWNoYW5uZWwgJiYgZGF0
YS0+Y3RybC0+d2N0ZW1wKSB8fAo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAoY2hhbm5lbCAmJiBkYXRhLT5sb2ctPnRlbXBfc2Vuc29yW2NoYW5uZWwgLQo+ID4gMV0p
KSB7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIChjaGFubmVsICYm
IGRhdGEtPmxvZy0+dGVtcF9zZW5zb3JbY2hhbm5lbCAtIDFdCj4gPiAmJgo+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICEoZGF0YS0+Y3RybC0+cXVpcmtzICYKPiA+
IE5WTUVfUVVJUktfTk9fU0VDT05EQVJZX1RFTVBfVEhSRVNIKSkpIHsKPiA+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChkYXRhLT5jdHJsLT5xdWly
a3MgJgo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIE5WTUVfUVVJUktfTk9fVEVNUF9USFJFU0hfQ0hBTkdFKQo+ID4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVy
biAwNDQ0Owo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L252bWUuaCBiL2RyaXZl
cnMvbnZtZS9ob3N0L252bWUuaAo+ID4gaW5kZXggYmY0NmYxMjJlOWUxLi5hMmQ0ZjU5ZTA1MzUg
MTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC9udm1lLmgKPiA+ICsrKyBiL2RyaXZl
cnMvbnZtZS9ob3N0L252bWUuaAo+ID4gQEAgLTE0OSw2ICsxNDksMTEgQEAgZW51bSBudm1lX3F1
aXJrcyB7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgICogUmVwb3J0cyBnYXJiYWdlIGluIHRoZSBuYW1l
c3BhY2UgaWRlbnRpZmllcnMgKGV1aTY0LAo+ID4gbmd1aWQsIHV1aWQpLgo+ID4gwqDCoMKgwqDC
oMKgwqDCoCAqLwo+ID4gwqDCoMKgwqDCoMKgwqDCoE5WTUVfUVVJUktfQk9HVVNfTklEwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoD0gKDEgPDwgMTgpLAo+ID4gKwo+ID4g
K8KgwqDCoMKgwqDCoMKgLyoKPiA+ICvCoMKgwqDCoMKgwqDCoCAqIE5vIHRlbXBlcmF0dXJlIHRo
cmVzaG9sZHMgZm9yIGNoYW5uZWxzIG90aGVyIHRoYW4gMAo+ID4gKENvbXBvc2l0ZSkuCj4gPiAr
wqDCoMKgwqDCoMKgwqAgKi8KPiA+ICvCoMKgwqDCoMKgwqDCoE5WTUVfUVVJUktfTk9fU0VDT05E
QVJZX1RFTVBfVEhSRVNIwqDCoMKgwqDCoD0gKDEgPDwgMTkpLAo+ID4gwqB9Owo+ID4gwqAKPiA+
IMKgLyoKPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9wY2kuYyBiL2RyaXZlcnMv
bnZtZS9ob3N0L3BjaS5jCj4gPiBpbmRleCBjZDc4NzNkZTMxMjEuLmU0NTdhZDE2OWRjYiAxMDA2
NDQKPiA+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L3BjaS5jCj4gPiArKysgYi9kcml2ZXJzL252
bWUvaG9zdC9wY2kuYwo+ID4gQEAgLTM0MTYsNiArMzQxNiw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1
Y3QgcGNpX2RldmljZV9pZAo+ID4gbnZtZV9pZF90YWJsZVtdID0gewo+ID4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAuZHJpdmVyX2RhdGEgPSBOVk1FX1FVSVJLX0RJU0FCTEVfV1JJ
VEVfWkVST0VTLCB9LAo+ID4gwqDCoMKgwqDCoMKgwqDCoHsgUENJX0RFVklDRSgweDI2NDYsIDB4
NTAxRSkswqDCoCAvKiBLSU5HU1RPTiBPTTNQR1A0eHh4eFEKPiA+IE9TMjEwMTEgTlZNZSBTU0Qg
Ki8KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLmRyaXZlcl9kYXRhID0gTlZN
RV9RVUlSS19ESVNBQkxFX1dSSVRFX1pFUk9FUywgfSwKPiA+ICvCoMKgwqDCoMKgwqDCoHsgUENJ
X0RFVklDRSgweDI2NDYsIDB4NTAxMykswqDCoCAvKiBLaW5nc3RvbiBLQzMwMDAsCj4gPiBLaW5n
c3RvbiBGVVJZIFJlbmVnYWRlICovCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
LmRyaXZlcl9kYXRhID0gTlZNRV9RVUlSS19OT19TRUNPTkRBUllfVEVNUF9USFJFU0gsCj4gPiB9
LAo+ID4gwqDCoMKgwqDCoMKgwqDCoHsgUENJX0RFVklDRSgweDFmNDAsIDB4MTIwMikswqDCoCAv
KiBOZXRhYyBUZWNobm9sb2dpZXMgQ28uCj4gPiBOVjMwMDAgTlZNZSBTU0QgKi8KPiA+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLmRyaXZlcl9kYXRhID0gTlZNRV9RVUlSS19CT0dV
U19OSUQsIH0sCj4gPiDCoMKgwqDCoMKgwqDCoMKgeyBQQ0lfREVWSUNFKDB4MWY0MCwgMHg1MjM2
KSzCoMKgIC8qIE5ldGFjIFRlY2hub2xvZ2llcyBDby4KPiA+IE5WNzAwMCBOVk1lIFNTRCAqLwo+
ID4gLS0gCj4gPiAyLjQwLjAKPiA+IAoK


