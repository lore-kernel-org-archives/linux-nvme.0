Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F34606A329
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 16:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=yz881LX0;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=K2sqOlIc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Date:Cc:To:From:Subject:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=NmV0onUi4RY5n3YpNLKOgp62iNPsVgUbXzR7nNG0hK4=; b=yz881LX0gojna9
	QAPaAehtTXK5X3Or/az1BQO8DMd6DFC5vSZnzSduXROoRSV06XZS1HvP/pC2guYxTVIMKyqYXmh9U
	jhaWgdlhzOx/pbQdmXgQ/trpbWI6lQk/IBc0fxkA1euEuIB3U4x/QgDX2uBhwyXwty/O/iCX4MON+
	XTVvDI1JCdQvs6GIpPpUDqz/bswZkIIzTDyV0RoJl+OS1Ed9QtCt75H9rFVzaaOCNmvSaUtRr67s+
	m/IvMpH8UYDtY9US2oxJ51njpbwdpkBiJq6wyLcD3hLXHc8T3rRdP0oHeAn83atP2ibKRjDCT3BJb
	sjLNOspazi0IqlVEt0Vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSGdZ-0000000GSzh-3HlV;
	Sat, 14 Nov 2026 16:29:57 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSGdT-0000000GSxw-1ibD
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 16:29:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794673789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NmV0onUi4RY5n3YpNLKOgp62iNPsVgUbXzR7nNG0hK4=;
	b=K2sqOlIc6ZVd+wZKSbUVyfm2b4addpXYNahNZfv5wFp+pYJeeo9XuPM1Sm8vNh6TRigtF5
	3bO/J0IZeXjjVR2NcuzNOL9xiwM+6MuJk6nKF6lBrd0dIivHw8S4lALr+R7XN/YgOL7K0m
	x1kBUMEuALdXXFuSzra7NaYPhCI9uTs=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-AZFaXXFpOeuZsThHX1vVBA-1; Sat, 14 Nov 2026 11:29:46 -0500
X-MC-Unique: AZFaXXFpOeuZsThHX1vVBA-1
X-Mimecast-MFC-AGG-ID: AZFaXXFpOeuZsThHX1vVBA_1794673785
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-55bb7f70b06so22930441cf.0
        for <linux-nvme@lists.infradead.org>; Sat, 14 Nov 2026 08:29:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794673785; x=1795278585;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n2A4Bzesj8lSex24jcQa4eIw8NYUbc0vDdMOEEExUHk=;
        b=btjjvdSU1uFw42kkGrAVYk5/PI/al0Rjft6ffGGhAfMnZXKQE5x5Jw+GiIK4XqUJRa
         YJ6E0NlQKjN7URfs3uMoiVdDdC2ZAGeMLvPXTxBNq7/oVVanEf0SEC8rqfC749fMSquV
         scY4MdNUOdYC253TFT1U4pMal6f4I+cvJLITdZKK1yZqjo3ObXy61IK9n+EHmikAKyiD
         0xpzLDWnWiFfdPrmYlQG1W7GXv9Hzbsx5Fy8b9g3KEbqGQTAQN+s0zWz+fLhyrqmch7Q
         uC1VItKSinIuOsSAVND8MbrX4MTij7oIhWUdLMl8vmqyE2ftwXB/yKgBNEv1O4iCRFXw
         d/ow==
X-Forwarded-Encrypted: i=1; AL+hErGbpXoWvBBWsB7gthnJ1R0Vfq9oPZRaeDpmW2YzZ28S2fudLUFL+lFnbiUew5y3EqnYDobcVpxqlodd@lists.infradead.org
X-Gm-Message-State: APuU4Z+huwfrooZcjEDjg18Fh6+WdhgpmnE27mcILDhYS1DWuDgU8+3/
	e9+Di1muEqYlspXa+IcAqi38sQdC8nyLnOUYKj+Q3coyGL/tXnNVovax5/foS5ewl3RGXrYXZGL
	c27Dy/4BL9GH7sIdxNosR2w0AhLNgTfxdd7GumLnG9yW+Cv1XhFZD08Xg1bowpcbHx1iY
X-Gm-Gg: AYBFou1EZwL6wrnBJJATQ9pSenp5Btu1ecsILiEIxBrUDZxsGxtBVATkBkG7cludM3+
	KJ7eLhO406T576j+cnxNVj6AzpGnrfbjloy1OTWgiEMlgpmvqLJfBH6f7eSf/dOSdIudnCuay/a
	+SeMQJfMRf5HUmj18eDSmaO8uW9kL5ZgTMJXCtt/Rr+kixi3qCdUh+qYy8fOwiZKAzuCVInrU49
	fwJQhG2JCm8/5Xyg15UzwAlVTxK9e+AIMEG6X/R/u5ItfJfu9dS1N9QesQeHBwGuVZSW7QW/q7G
	Q4EFCC+5mOPG3voNe8PGVVBg068MNDGb35+tnihoyQ/SsvcJ8Zt3KuL4CXkeMp3F3VkrR19W4Zq
	EiYVY8JeWGuO8kzK1jK+YZdcY4tvfNtjH5Iu2fBtZCr0LrZ8BMQ/No/map6duBmn0cphJPpzbIc
	0nwHzK4NLpo3GjbNqx8X9BLuEtl1ZXbpAa2Z1ZYsQ8YUWgevENNefJ7dKtg1g9J0NpSFYuFw==
X-Received: by 2002:ac8:5d4b:0:b0:533:95c1:fb11 with SMTP id d75a77b69052e-55956e5d97cmr146589501cf.28.1794673785392;
        Sat, 14 Nov 2026 08:29:45 -0800 (PST)
X-Received: by 2002:ac8:5d4b:0:b0:533:95c1:fb11 with SMTP id d75a77b69052e-55956e5d97cmr146589201cf.28.1794673784936;
        Sat, 14 Nov 2026 08:29:44 -0800 (PST)
Received: from loberman-thinkpadp1gen5.rmtusma.csb ([2600:6c65:2440:d8c:929c:b769:6def:faa3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d453casm46039086d6.10.2026.11.14.08.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 08:29:44 -0800 (PST)
Message-ID: <72c69ee88f292a008173bb84a7335330d3415b71.camel@redhat.com>
Subject: Re: [PATCH v9 00/29] Native SCSI Multipath support
From: Laurence Oberman <loberman@redhat.com>
To: Xose Vazquez Perez <xose.vazquez@gmail.com>, John Garry
	 <john.garry@linux.dev>
Cc: hare@suse.com, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, 	snitzer@kernel.org, jmeneghi@redhat.com,
 dm-devel@lists.linux.dev, hch@lst.de, 	michael.christie@oracle.com, "James
 E.J. Bottomley"	 <James.Bottomley@HansenPartnership.com>, mkp@kernel.org,
 Benjamin Marzinski	 <bmarzins@redhat.com>, Martin Wilck <mwilck@suse.com>
Date: Sat, 14 Nov 2026 11:29:43 -0500
In-Reply-To: <00e03246-95dc-46dd-a2f9-89ad88f177d1@gmail.com>
References: <20261108204733.557995-1-john.garry@linux.dev>
	 <9b90edc29d5b3be49f5bd0e0ecec5f1701e089bf.camel@redhat.com>
	 <3332329d-b922-45a4-8333-e8353e983885@linux.dev>
	 <00e03246-95dc-46dd-a2f9-89ad88f177d1@gmail.com>
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OHkSYT_mcYxQQ6oyTAb0LnDUrmWFhk_u1ZWmd9Hfu8k_1794673785
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261114_082951_535331_0FD2DED2 
X-CRM114-Status: GOOD (  23.54  )
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

T24gU2F0LCAyMDI2LTExLTE0IGF0IDE0OjAzICswMTAwLCBYb3NlIFZhenF1ZXogUGVyZXogd3Jv
dGU6Cj4gT24gMTEvMTAvMjYgMTA6MDUgQU0sIEpvaG4gR2Fycnkgd3JvdGU6Cj4gCj4gPiBPbiAx
MS85LzI2IDIwOjE5LCBMYXVyZW5jZSBPYmVybWFuIHdyb3RlOgo+ID4gPiAzLiBTbWFsbGVyIHBv
aW50cwo+ID4gPiAKPiA+ID4gLSBudW1hIHdpdGggZXF1YWwgTlVNQSBkaXN0YW5jZSB1c2VzIG9u
ZSBwYXRoIHBlciBMVU4sIHNvIHdpdGgKPiA+ID4gdHdvIEFPCj4gPiA+IMKgwqAgcGF0aHMgdGhy
b3VnaCB0d28gSEJBcywgaGFsZiB0aGUgb3B0aW1pemVkIGJhbmR3aWR0aCBpcyBpZGxlCj4gPiA+
IChzZGw6Mgo+ID4gPiDCoMKgIGFib3ZlIHVuZGVyIG51bWEpLiBUaGF0IG1hdGNoZXMgTlZNZSwg
YnV0IHVzZXJzIGNvbWluZyBmcm9tCj4gPiA+IMKgwqAgZG0tbXVsdGlwYXRoIHNlcnZpY2UtdGlt
ZSB3aWxsIG5vdGljZS4gV291bGQgcm91bmQtcm9iaW4gb3IKPiA+ID4gwqDCoCBxdWV1ZS1kZXB0
aCBiZSBhIGJldHRlciBkZWZhdWx0IGZvciBTQ1NJPwo+ID4gCj4gPiBNYXliZSwgYnV0IHJvdW5k
LXJvYmluIG1heSBub3QgYmUgYWx3YXlzIGlkZWFsIGNvbnNpZGVyaW5nIG9ubHkgYQo+ID4gYmlv
IG1vZGUgb2Ygb3BlcmF0aW9uIGlzIHN1cHBvcnRlZCBhbmQgbm8gbWVyZ2luZyBsaWtlIGRtLW1w
YXRoIFJRCj4gPiBtb2RlLgo+IAo+IGlvcG9saWN5IGNhbiBlYXNpbHkgYmUgY3VzdG9taXplZCBw
ZXIgYXJyYXkvZGV2aWNlIHZpYSB1ZGV2IHJ1bGVzLgo+IEp1c3QgbGlrZSBpdCdzIGRvbmUgZm9y
IE5WTWU6Cj4gaHR0cHM6Ly9naXRodWIuY29tL2xpbnV4LW52bWUvbnZtZS1jbGkvYmxvYi9tYXN0
ZXIvbnZtZi1hdXRvY29ubmVjdC91ZGV2LXJ1bGVzLzcxLW52bWYtaHBlLnJ1bGVzLmluCj4gCj4g
QWRkaXRpb25hbGx5LCAic2VydmljZS10aW1lIiBhbmQgImxhdGVuY3kiIEkvTyBwb2xpY2llcyBh
cmUgY3VycmVudGx5Cj4gdW5kZXIKPiBkZXZlbG9wbWVudDoKPiBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9saW51eC1udm1lLzIwMjYxMDI2MTExMDE5LjM3MjQ0NjUtMS1rYW5pZUBsaW51eC5hbGli
YWJhLmNvbS9ULwo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LW52bWUvMjAyNjA4MTUx
NzM1MDIuMTE4NTkyOS0xLW5pbGF5QGxpbnV4LmlibS5jb20vVC8KPiAKPiA+ID4gLSBUaGVyZSBp
cyBubyB1c2Vyc3BhY2UgdG9vbCB5ZXQgdG8gc2hvdyBoZWFkcywgcGF0aHMgYW5kIEFMVUEKPiA+
ID4gc3RhdGUKPiA+ID4gwqDCoCAodGhlIGVxdWl2YWxlbnQgb2YgbXVsdGlwYXRoIC1sbCBvciBu
dm1lIGxpc3Qtc3Vic3lzKS4gSSB1c2VkCj4gPiA+IGEKPiA+ID4gwqDCoCBzbWFsbCBzeXNmcyBz
Y3JpcHQgZm9yIHRoaXMgdGVzdGluZy4gQmVuLCBpcyBuYXRpdmUgU0NTSQo+ID4gPiBtdWx0aXBh
dGgKPiA+ID4gwqDCoCBzdXBwb3J0IGluIG11bHRpcGF0aC10b29scyBwbGFubmVkPwo+ID4gCj4g
PiBXZWxsLCB0aGUgd2hvbGUgcG9pbnQgaXMgdGhhdCB3ZSBkb24ndCBuZWVkIHVzZXJzcGFjZSB0
b29scy4KPiA+IEhvd2V2ZXIsIEkgYXBwcmVjaWF0ZSB0aGF0IHRoZXJlIGlzIG5vIGdlbmVyYWwg
U0NTSSB0b29saW5nIHdoaWNoCj4gPiBjb3VsZCBoZWxwIGhlcmUuIEkga25vdyB0aGF0IEhpbWFu
c2h1IE0gZGlkIHdvcmsgb24gYSBTQ1NJIHZlcnNpb24KPiA+IG9mIAo+ID4gbnZtZS1jbGkgdG9v
bCBwcmV2aW91c2x5LiBNYXJ0aW4gbWF5IGtub3cgdGhlIHN0YXR1cyBvZiB0aGF0Lgo+IAo+IEFn
cmVlZCB0aGF0IHVzZXJzcGFjZSB0b29scyBhcmUgbm90IHN0cmljdGx5IG5lZWRlZCBmb3IKPiBj
b25maWd1cmF0aW9uLCBidXQKPiBvYnNlcnZhYmlsaXR5IGlzIGtleS4KPiBBIHN0YW5kYXJkIHV0
aWxpdHkgdG8gdmlzdWFsaXplIHRoZSBkZXZpY2UgdG9wb2xvZ3ksIHBhdGggaGVhbHRoIGFuZAo+
IEFMVUEKPiBzdGF0ZXMgYXQgYSBnbGFuY2UsIHNpbWlsYXIgdG8gd2hhdCBtdWx0aXBhdGgtdG9v
bHMgcHJvdmlkZXMsIHdvdWxkCj4gc2F2ZSBhCj4gbG90IG9mIGZyaWN0aW9uIGZvciBzeXNhZG1p
bnMgbWlncmF0aW5nIGF3YXkgZnJvbSBkbS1tdWx0aXBhdGguCj4gUmVseWluZyBzb2xlbHkgb24g
YWQtaG9jIHNjcmlwdHMgb3IgbWFudWFsIHN5c2ZzIHBhcnNpbmcgY2FuIGJlY29tZQo+IHF1aXRl
Cj4gdGVkaW91cyBpbiBwcm9kdWN0aW9uIGVudmlyb25tZW50cy4KSGVsbG8gWG9zZQoKSSBoYXZl
IGEgd29ya2luZyBydXN0IGJhc2VkIHVzZXJzcGFjZSB0b29sIGZvciB0aGlzLiBJdCBzdGFydGVk
IGFzIGEKcGF0aCBhbmQgSU9QUyBtb25pdG9yIGFuZCB3b3JrcyB3ZWxsLiBJIGFtIGNsZWFuaW5n
IGl0IHVwIHRoaXMgd2Vla2VuZAphbmQgd2lsbCBzaGFyZSBhIHJlcG8gbmV4dCB3ZWVrLgoKVGhl
IGVtYWlsIGNsaWVudCB3cmFwcyB0aGUgbGluZXMsIGxvb2tzIGJldHRlciBvbiB0aGUgd2lkZXIg
c2NyZWVuCgoKPT09IE5WTWUgUGVyLVBhdGggTW9uaXRvciA9PT0KCm52bWUtc3Vic3lzMCAgICAg
TlFOOiBsb2JlCiAgICAgICAgICAgICAgICAgaW9wb2xpY3k6IG51bWEKClNhbXBsZSBpbnRlcnZh
bDogMXMgfCBsYXRlbmN5OiBhdmVyYWdlIHBlciBjb21wbGV0ZWQgSS9PIGluIHRoaXMKaW50ZXJ2
YWwKClBBVEggICAgICAgICAgIENUUkwgICAgICAgQU5BIFNUQVRFICAgICAgVFJBTlNQT1JUICAg
ICAgICAgICAgICAgICAgUgpJT1BTICAgVyBJT1BTICBSIEFWRyBMQVQgIFcgQVZHIExBVCAgICAg
IFJFQUQgQlcgICAgIFdSSVRFIEJXCuKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgAoK4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSACm52bWUwYzFuMSAgICAgIG52bWUxICAgICAgb3B0aW1pemVkICAg
ICAgcmRtYToxOTIuMTY4LjIuMjU0OjQ0MjAgICAgCjU5LjVLICAgIDU5LjZLICAgIDE3LjgybXMg
ICAgMTUuNzZtcyAgIDIzMi4zIE1CL3MgICAyMzIuOCBNQi9zCm52bWUwYzJuMSAgICAgIG52bWUy
ICAgICAgb3B0aW1pemVkICAgICAgcmRtYToxOTIuMTY4LjEuMjU0OjQ0MjAgICAgICAKMCAgICAg
ICAgMCAgICAgICAgICAtICAgICAgICAgIC0gICAgICAgIDAgQi9zICAgICAgICAwIEIvcwoKQ2hh
bmdlIHRvIHJvdW5kLXJvYmluCgo9PT0gTlZNZSBQZXItUGF0aCBNb25pdG9yID09PQoKbnZtZS1z
dWJzeXMwICAgICBOUU46IGxvYmUKICAgICAgICAgICAgICAgICBpb3BvbGljeTogcm91bmQtcm9i
aW4KClNhbXBsZSBpbnRlcnZhbDogMXMgfCBsYXRlbmN5OiBhdmVyYWdlIHBlciBjb21wbGV0ZWQg
SS9PIGluIHRoaXMKaW50ZXJ2YWwKClBBVEggICAgICAgICAgIENUUkwgICAgICAgQU5BIFNUQVRF
ICAgICAgVFJBTlNQT1JUICAgICAgICAgICAgICAgICAgUgpJT1BTICAgVyBJT1BTICBSIEFWRyBM
QVQgIFcgQVZHIExBVCAgICAgIFJFQUQgQlcgICAgIFdSSVRFIEJXCuKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgAoK4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSACm52bWUwYzFuMSAgICAgIG52bWUx
ICAgICAgb3B0aW1pemVkICAgICAgcmRtYToxOTIuMTY4LjIuMjU0OjQ0MjAgICAgCjE1LjJLICAg
IDE1LjJLICAgIDEzLjUybXMgICAgMTEuMDRtcyAgIDExOC44IE1CL3MgICAxMTguNiBNQi9zCm52
bWUwYzJuMSAgICAgIG52bWUyICAgICAgb3B0aW1pemVkICAgICAgcmRtYToxOTIuMTY4LjEuMjU0
OjQ0MjAgICAgCjE0LjlLICAgIDE1LjVLICAgIDU0LjIybXMgICAgNjMuMjNtcyAgIDExNi42IE1C
L3MgICAxMjEuMSBNQi9zCgpUaGFua3MKTGF1cmVuY2UKDQo=


