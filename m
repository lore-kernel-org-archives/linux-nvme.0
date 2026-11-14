Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AE7606A883
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 19:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ZgEHywst;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hCl1aTcE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Date:Cc:To:From:Subject:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=FNHcsFInRg6O/+cM6rrKb1TT4rbjRwnXWB+glwR9lSk=; b=ZgEHywstIp1VTH
	TuAE/1qoJFFESGXrDCPOemDMQV+CTVUuA6U7BcXSLHm+6u9NdquSm2UpmyDd2C1gj55GdNdNXI09N
	9TszkKsjX/xTx8l8C5AMZ9xo6p36bgRXaMx61UC0F/o/Y4SOTtNiOB8NwERhf1O41mErMfz7XO+M0
	ZQRf4wjDipXyflCI/jzWZXbJ9Dp416cWuszvLUIZ6Ci8mzv7j06uaf0wSEkzIx7V9+nYDlvo46Y0+
	65ilbhyzgFbBe+q+3QRDY25jFHxbfUe5s8RXiAi+dBJ3IN/jE3lSMvJfcy6pppRWwXGhYwoDigwdk
	zL66gz9/df/nk+R2jMDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSJuN-0000000GhZy-1pCu;
	Sat, 14 Nov 2026 19:59:31 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSJuJ-0000000GhZN-1hHV
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 19:59:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794686366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FNHcsFInRg6O/+cM6rrKb1TT4rbjRwnXWB+glwR9lSk=;
	b=hCl1aTcEa2wN9A30/SYv5Yr/SmFZoZJO+2VLtO3QvoHFSAl6qowczOiE+mV4vikUCO5o2I
	1QqauKS36ZB0TG9hv/S1Bfq5mF0pCJlii16XC9uoynCedUYUd6YFfBvp6JFrgJUAJxA8mg
	qM4LSP9qcNy9zwzmJyAXu0Bq5alvRhs=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-ODEAQySeP3CrER_pPIN-PQ-1; Sat, 14 Nov 2026 14:59:22 -0500
X-MC-Unique: ODEAQySeP3CrER_pPIN-PQ-1
X-Mimecast-MFC-AGG-ID: ODEAQySeP3CrER_pPIN-PQ_1794686362
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-55c16eb248eso22004731cf.2
        for <linux-nvme@lists.infradead.org>; Sat, 14 Nov 2026 11:59:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794686362; x=1795291162;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uFXNoy6gP0yH6T4s0vbljgaUMgktLJ38QS3jqGJ3hsM=;
        b=EA7BjYbWEULiVVP1fgmXGY0Yw5fh/H7UQZYOw1myadmFa7wxnShPKCujIR2VpiyuTI
         aAkYP4JVUM2NNM2cxRric0OPswyV1AjCa3LdHVAdTw5gSY5vS3n4yCLUpcuen7d4fuGR
         dLjr4MgK43vIXWFNFaDUycsXxrtedwQg72HETZrd2tmwPHyP64T+GiFcIguaVO4UgzTe
         zyOT8L//lG1ynuilzlqoUmxskSu3+X4JyME8yDySERQbDGtj2Hn1xMqaLTr7kLjQhYOp
         7E4cNyr3GkCSvQCp1k0cdUISfX/esMt5d3bV1qk3epRAlEmXGjvtltMb4t01HKhwaQQb
         ShJg==
X-Forwarded-Encrypted: i=1; AL+hErFk+YTdYTT7vOGhBHvAfyFojABU7/oYkhjAhvy9wYP1OWMsyZnS5b+OG1/XmxJIw7VXEG1HfQi5xruy@lists.infradead.org
X-Gm-Message-State: APuU4Z/Q9IbBD/LCE14NpFMEZWK4tYmmcc2ZJYbPyUxHjq0A7pu7Spza
	tqy5rs7yXQUdh/Ie4LZQKoGvss1b4U5KkjsAf9HNyYamY9LHnvGZDHi8v3DiQOBpg38E2etzX+9
	lxBPEgJZtYF45ZnZ4HrfiiGDbmitAEOhepi0D9IU4z6gETi8ohE5X64KvjzIe8WDS8wH0
X-Gm-Gg: AYBFou26h845g0HEgcrqgX/qxAtfgVnUjE9apijS+vL+IybVMxQknRrJaLFI/taORWW
	sT8LK+7n8k5KzNBXiLH9BMdEzkajKN7ivECBdQ+dMIW5aODwaT9xQym8oFZFHmxz1w35YxJwtdr
	eaekQUF+qJGMLnYBUDxFNpyDENQ1SL5u0ixhCLJxByRGJDn4NERDdjknKWA78gzBQqsylOg+/PG
	98TNx48fGl/RiOI64vrDR7QH1qYUWdrjdeuCl1sC9H2T0e5ozIVoKxxm2cG4aOVMFmwtL1TtJav
	o6RB7fnHG7UCF9WoT8mnG94YxRBRZU3VbCUodjYE7+dJ6nK+pA6EDntdmGiY8Pm0OHfxKw1cEui
	o+gherktLUB/tnzdgFozZ4f39B1h9OHbVRLit2MKOm6Ot5IXhV8S7jPhea6a2Q9fMCRHYZ5Tlwn
	dcu2pWEqN3GvTrFPkoSnvK8hKxYuCwduxc8puFp2GkZ2upuPrfPrhxXGP2oC0p/ClIghAlHg==
X-Received: by 2002:a05:622a:598e:b0:55c:f671:99be with SMTP id d75a77b69052e-55cf6719b5bmr26848951cf.47.1794686361854;
        Sat, 14 Nov 2026 11:59:21 -0800 (PST)
X-Received: by 2002:a05:622a:598e:b0:55c:f671:99be with SMTP id d75a77b69052e-55cf6719b5bmr26848801cf.47.1794686361370;
        Sat, 14 Nov 2026 11:59:21 -0800 (PST)
Received: from loberman-thinkpadp1gen5.rmtusma.csb ([2600:6c65:2440:d8c:929c:b769:6def:faa3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55ad043f2f7sm46189161cf.5.2026.11.14.11.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 11:59:20 -0800 (PST)
Message-ID: <74d88ab7faf32dbcfd22e508defa695c217c0a67.camel@redhat.com>
Subject: Re: [PATCH v9 00/29] Native SCSI Multipath support
From: Laurence Oberman <loberman@redhat.com>
To: Xose Vazquez Perez <xose.vazquez@gmail.com>, John Garry
	 <john.garry@linux.dev>
Cc: hare@suse.com, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, 	snitzer@kernel.org, jmeneghi@redhat.com,
 dm-devel@lists.linux.dev, hch@lst.de, 	michael.christie@oracle.com, "James
 E.J. Bottomley"	 <James.Bottomley@HansenPartnership.com>, mkp@kernel.org,
 Benjamin Marzinski	 <bmarzins@redhat.com>, Martin Wilck <mwilck@suse.com>
Date: Sat, 14 Nov 2026 14:59:19 -0500
In-Reply-To: <72c69ee88f292a008173bb84a7335330d3415b71.camel@redhat.com>
References: <20261108204733.557995-1-john.garry@linux.dev>
		 <9b90edc29d5b3be49f5bd0e0ecec5f1701e089bf.camel@redhat.com>
		 <3332329d-b922-45a4-8333-e8353e983885@linux.dev>
		 <00e03246-95dc-46dd-a2f9-89ad88f177d1@gmail.com>
	 <72c69ee88f292a008173bb84a7335330d3415b71.camel@redhat.com>
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Asp4-dq2EOg92omCrzdhvuyrm1eAL6NiNhyIgZkM5HY_1794686362
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261114_115927_524402_5A05814A 
X-CRM114-Status: GOOD (  30.11  )
X-Spam-Score: -2.8 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gU2F0LCAyMDI2LTExLTE0IGF0IDExOjI5IC0wNTAwLCBMYXVyZW5jZSBPYmVybWFuIHdyb3Rl
Ogo+IE9uIFNhdCwgMjAyNi0xMS0xNCBhdCAxNDowMyArMDEwMCwgWG9zZSBWYXpxdWV6IFBlcmV6
IHdyb3RlOgo+ID4gT24gMTEvMTAvMjYgMTA6MDUgQU0sIEpvaG4gR2Fycnkgd3JvdGU6Cj4gPiAK
PiA+ID4gT24gMTEvOS8yNiAyMDoxOSwgTGF1cmVuY2UgT2Jlcm1hbiB3cm90ZToKPiA+ID4gPiAz
LiBTbWFsbGVyIHBvaW50cwo+ID4gPiA+IAo+ID4gPiA+IC0gbnVtYSB3aXRoIGVxdWFsIE5VTUEg
ZGlzdGFuY2UgdXNlcyBvbmUgcGF0aCBwZXIgTFVOLCBzbyB3aXRoCj4gPiA+ID4gdHdvIEFPCj4g
PiA+ID4gwqDCoCBwYXRocyB0aHJvdWdoIHR3byBIQkFzLCBoYWxmIHRoZSBvcHRpbWl6ZWQgYmFu
ZHdpZHRoIGlzIGlkbGUKPiA+ID4gPiAoc2RsOjIKPiA+ID4gPiDCoMKgIGFib3ZlIHVuZGVyIG51
bWEpLiBUaGF0IG1hdGNoZXMgTlZNZSwgYnV0IHVzZXJzIGNvbWluZyBmcm9tCj4gPiA+ID4gwqDC
oCBkbS1tdWx0aXBhdGggc2VydmljZS10aW1lIHdpbGwgbm90aWNlLiBXb3VsZCByb3VuZC1yb2Jp
biBvcgo+ID4gPiA+IMKgwqAgcXVldWUtZGVwdGggYmUgYSBiZXR0ZXIgZGVmYXVsdCBmb3IgU0NT
ST8KPiA+ID4gCj4gPiA+IE1heWJlLCBidXQgcm91bmQtcm9iaW4gbWF5IG5vdCBiZSBhbHdheXMg
aWRlYWwgY29uc2lkZXJpbmcgb25seSBhCj4gPiA+IGJpbyBtb2RlIG9mIG9wZXJhdGlvbiBpcyBz
dXBwb3J0ZWQgYW5kIG5vIG1lcmdpbmcgbGlrZSBkbS1tcGF0aAo+ID4gPiBSUQo+ID4gPiBtb2Rl
Lgo+ID4gCj4gPiBpb3BvbGljeSBjYW4gZWFzaWx5IGJlIGN1c3RvbWl6ZWQgcGVyIGFycmF5L2Rl
dmljZSB2aWEgdWRldiBydWxlcy4KPiA+IEp1c3QgbGlrZSBpdCdzIGRvbmUgZm9yIE5WTWU6Cj4g
PiBodHRwczovL2dpdGh1Yi5jb20vbGludXgtbnZtZS9udm1lLWNsaS9ibG9iL21hc3Rlci9udm1m
LWF1dG9jb25uZWN0L3VkZXYtcnVsZXMvNzEtbnZtZi1ocGUucnVsZXMuaW4KPiA+IAo+ID4gQWRk
aXRpb25hbGx5LCAic2VydmljZS10aW1lIiBhbmQgImxhdGVuY3kiIEkvTyBwb2xpY2llcyBhcmUK
PiA+IGN1cnJlbnRseQo+ID4gdW5kZXIKPiA+IGRldmVsb3BtZW50Ogo+ID4gaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvbGludXgtbnZtZS8yMDI2MTAyNjExMTAxOS4zNzI0NDY1LTEta2FuaWVAbGlu
dXguYWxpYmFiYS5jb20vVC8KPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LW52bWUv
MjAyNjA4MTUxNzM1MDIuMTE4NTkyOS0xLW5pbGF5QGxpbnV4LmlibS5jb20vVC8KPiA+IAo+ID4g
PiA+IC0gVGhlcmUgaXMgbm8gdXNlcnNwYWNlIHRvb2wgeWV0IHRvIHNob3cgaGVhZHMsIHBhdGhz
IGFuZCBBTFVBCj4gPiA+ID4gc3RhdGUKPiA+ID4gPiDCoMKgICh0aGUgZXF1aXZhbGVudCBvZiBt
dWx0aXBhdGggLWxsIG9yIG52bWUgbGlzdC1zdWJzeXMpLiBJCj4gPiA+ID4gdXNlZAo+ID4gPiA+
IGEKPiA+ID4gPiDCoMKgIHNtYWxsIHN5c2ZzIHNjcmlwdCBmb3IgdGhpcyB0ZXN0aW5nLiBCZW4s
IGlzIG5hdGl2ZSBTQ1NJCj4gPiA+ID4gbXVsdGlwYXRoCj4gPiA+ID4gwqDCoCBzdXBwb3J0IGlu
IG11bHRpcGF0aC10b29scyBwbGFubmVkPwo+ID4gPiAKPiA+ID4gV2VsbCwgdGhlIHdob2xlIHBv
aW50IGlzIHRoYXQgd2UgZG9uJ3QgbmVlZCB1c2Vyc3BhY2UgdG9vbHMuCj4gPiA+IEhvd2V2ZXIs
IEkgYXBwcmVjaWF0ZSB0aGF0IHRoZXJlIGlzIG5vIGdlbmVyYWwgU0NTSSB0b29saW5nIHdoaWNo
Cj4gPiA+IGNvdWxkIGhlbHAgaGVyZS4gSSBrbm93IHRoYXQgSGltYW5zaHUgTSBkaWQgd29yayBv
biBhIFNDU0kKPiA+ID4gdmVyc2lvbgo+ID4gPiBvZiAKPiA+ID4gbnZtZS1jbGkgdG9vbCBwcmV2
aW91c2x5LiBNYXJ0aW4gbWF5IGtub3cgdGhlIHN0YXR1cyBvZiB0aGF0Lgo+ID4gCj4gPiBBZ3Jl
ZWQgdGhhdCB1c2Vyc3BhY2UgdG9vbHMgYXJlIG5vdCBzdHJpY3RseSBuZWVkZWQgZm9yCj4gPiBj
b25maWd1cmF0aW9uLCBidXQKPiA+IG9ic2VydmFiaWxpdHkgaXMga2V5Lgo+ID4gQSBzdGFuZGFy
ZCB1dGlsaXR5IHRvIHZpc3VhbGl6ZSB0aGUgZGV2aWNlIHRvcG9sb2d5LCBwYXRoIGhlYWx0aAo+
ID4gYW5kCj4gPiBBTFVBCj4gPiBzdGF0ZXMgYXQgYSBnbGFuY2UsIHNpbWlsYXIgdG8gd2hhdCBt
dWx0aXBhdGgtdG9vbHMgcHJvdmlkZXMsIHdvdWxkCj4gPiBzYXZlIGEKPiA+IGxvdCBvZiBmcmlj
dGlvbiBmb3Igc3lzYWRtaW5zIG1pZ3JhdGluZyBhd2F5IGZyb20gZG0tbXVsdGlwYXRoLgo+ID4g
UmVseWluZyBzb2xlbHkgb24gYWQtaG9jIHNjcmlwdHMgb3IgbWFudWFsIHN5c2ZzIHBhcnNpbmcg
Y2FuIGJlY29tZQo+ID4gcXVpdGUKPiA+IHRlZGlvdXMgaW4gcHJvZHVjdGlvbiBlbnZpcm9ubWVu
dHMuCj4gSGVsbG8gWG9zZQo+IAo+IEkgaGF2ZSBhIHdvcmtpbmcgcnVzdCBiYXNlZCB1c2Vyc3Bh
Y2UgdG9vbCBmb3IgdGhpcy4gSXQgc3RhcnRlZCBhcyBhCj4gcGF0aCBhbmQgSU9QUyBtb25pdG9y
IGFuZCB3b3JrcyB3ZWxsLiBJIGFtIGNsZWFuaW5nIGl0IHVwIHRoaXMKPiB3ZWVrZW5kCj4gYW5k
IHdpbGwgc2hhcmUgYSByZXBvIG5leHQgd2Vlay4KPiAKPiBUaGUgZW1haWwgY2xpZW50IHdyYXBz
IHRoZSBsaW5lcywgbG9va3MgYmV0dGVyIG9uIHRoZSB3aWRlciBzY3JlZW4KPiAKPiAKPiA9PT0g
TlZNZSBQZXItUGF0aCBNb25pdG9yID09PQo+IAo+IG52bWUtc3Vic3lzMMKgwqDCoMKgIE5RTjog
bG9iZQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlvcG9saWN5OiBudW1hCj4g
Cj4gU2FtcGxlIGludGVydmFsOiAxcyB8IGxhdGVuY3k6IGF2ZXJhZ2UgcGVyIGNvbXBsZXRlZCBJ
L08gaW4gdGhpcwo+IGludGVydmFsCj4gCj4gUEFUSMKgwqDCoMKgwqDCoMKgwqDCoMKgIENUUkzC
oMKgwqDCoMKgwqAgQU5BIFNUQVRFwqDCoMKgwqDCoCBUUkFOU1BPUlTCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIFIKPiBJT1BTwqDCoCBXIElPUFPCoCBSIEFWRyBMQVTCoCBXIEFW
RyBMQVTCoMKgwqDCoMKgIFJFQUQgQlfCoMKgwqDCoCBXUklURSBCVwo+IOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgAo+IOKUgOKUgAo+IAo+IOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgAo+IG52bWUwYzFu
McKgwqDCoMKgwqAgbnZtZTHCoMKgwqDCoMKgIG9wdGltaXplZMKgwqDCoMKgwqAgcmRtYToxOTIu
MTY4LjIuMjU0OjQ0MjDCoMKgwqAgCj4gNTkuNUvCoMKgwqAgNTkuNkvCoMKgwqAgMTcuODJtc8Kg
wqDCoCAxNS43Nm1zwqDCoCAyMzIuMyBNQi9zwqDCoCAyMzIuOCBNQi9zCj4gbnZtZTBjMm4xwqDC
oMKgwqDCoCBudm1lMsKgwqDCoMKgwqAgb3B0aW1pemVkwqDCoMKgwqDCoCByZG1hOjE5Mi4xNjgu
MS4yNTQ6NDQyMMKgwqDCoMKgwqAKPiAwwqDCoMKgwqDCoMKgwqAgMMKgwqDCoMKgwqDCoMKgwqDC
oCAtwqDCoMKgwqDCoMKgwqDCoMKgIC3CoMKgwqDCoMKgwqDCoCAwIEIvc8KgwqDCoMKgwqDCoMKg
IDAgQi9zCj4gCj4gQ2hhbmdlIHRvIHJvdW5kLXJvYmluCj4gCj4gPT09IE5WTWUgUGVyLVBhdGgg
TW9uaXRvciA9PT0KPiAKPiBudm1lLXN1YnN5czDCoMKgwqDCoCBOUU46IGxvYmUKPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpb3BvbGljeTogcm91bmQtcm9iaW4KPiAKPiBTYW1w
bGUgaW50ZXJ2YWw6IDFzIHwgbGF0ZW5jeTogYXZlcmFnZSBwZXIgY29tcGxldGVkIEkvTyBpbiB0
aGlzCj4gaW50ZXJ2YWwKPiAKPiBQQVRIwqDCoMKgwqDCoMKgwqDCoMKgwqAgQ1RSTMKgwqDCoMKg
wqDCoCBBTkEgU1RBVEXCoMKgwqDCoMKgIFRSQU5TUE9SVMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgUgo+IElPUFPCoMKgIFcgSU9QU8KgIFIgQVZHIExBVMKgIFcgQVZHIExBVMKg
wqDCoMKgwqAgUkVBRCBCV8KgwqDCoMKgIFdSSVRFIEJXCj4g4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSACj4g4pSA4pSACj4gCj4g4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSACj4gbnZtZTBjMW4xwqDCoMKg
wqDCoCBudm1lMcKgwqDCoMKgwqAgb3B0aW1pemVkwqDCoMKgwqDCoCByZG1hOjE5Mi4xNjguMi4y
NTQ6NDQyMMKgwqDCoCAKPiAxNS4yS8KgwqDCoCAxNS4yS8KgwqDCoCAxMy41Mm1zwqDCoMKgIDEx
LjA0bXPCoMKgIDExOC44IE1CL3PCoMKgIDExOC42IE1CL3MKPiBudm1lMGMybjHCoMKgwqDCoMKg
IG52bWUywqDCoMKgwqDCoCBvcHRpbWl6ZWTCoMKgwqDCoMKgIHJkbWE6MTkyLjE2OC4xLjI1NDo0
NDIwwqDCoMKgIAo+IDE0LjlLwqDCoMKgIDE1LjVLwqDCoMKgIDU0LjIybXPCoMKgwqAgNjMuMjNt
c8KgwqAgMTE2LjYgTUIvc8KgwqAgMTIxLjEgTUIvcwo+IAo+IFRoYW5rcwo+IExhdXJlbmNlCgpT
ZWUgdGhlIFJFQURNRS5tZCwgbmVlZHMgY2FyZ28vcnVzdCB0byBidWlsZCBpdC4KCmdpdCBjbG9u
ZSBodHRwczovL2dpdGh1Yi5jb20vbG9iZXJtYW4vbnZtZS1zY3NpLXBhdGgtaW9wcy5naXQKY2Qg
bnZtZS1zY3NpLXBhdGgtaW9wcwpjYXJnbyBidWlsZCAtLXJlbGVhc2UKQmluYXJ5IHdpbGwgYmUg
aW4gdGFyZ2V0L3JlbGVhc2UvbnZtZS1wYXRoLWlvcHMKClRoaXMgaXMgd29ya2luZyB3ZWxsIGZv
ciBtZSB3aXRoIG5hdGl2ZSBudm1lIG11bHRpcGF0aCBhbmQgbmF0aXZlIHNjc2kKbXVsdGlwYXRo
LgoKTGV0IG1lIGtub3cgaWYgeW91IGxpa2UgaXQuCgpodHRwczovL2dpdGh1Yi5jb20vbG9iZXJt
YW4vbnZtZS1zY3NpLXBhdGgtaW9wcy5naXQKDQo=


