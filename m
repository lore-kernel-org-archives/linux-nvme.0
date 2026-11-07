Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4262606A32C
	for <linux-nvme@archiver.kernel.org>; Sat,  7 Nov 2026 03:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Q2TX4e/R;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IOgAJhyk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=vBq+Vi8nhrcgb+rwT0xqsW9JqWl7+dVS67eiXkR00vw=; b=Q2TX4e/RmlVQwQhJ6oqVQJBs3R
	dvKgXZFmfcqeJf3mfjscCbkTp1CqXslOoHQ0QqJbbFpLbhBCUhkHFL8Py7GUz9n4Onfh6pGVVB3G3
	CNRxjUhN25e+KqnhT3TYXxqMjB8u685qXY0zJZHpvE70uILpJEQW5tj5NJlFZbhstRbDSuFquuKxv
	TGlq8hE8jK73frim7N+uQcNPCt/A13i0r+KmEpsXIXwjGguIt+nfvLYfLLdU7+c8f+z5a1/KmB/L5
	7JFSRefWB9MWDVDudKBvSdK4Ar226nb3xy7lQO9vBId5IfYq3RMxyDhF9k3Xpfe/NV/Yi5Al4UKc0
	dUGMekVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPWxg-0000000E7lv-31cw;
	Sat, 07 Nov 2026 03:19:24 +0000
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPWxd-0000000E7lS-34sI
	for linux-nvme@lists.infradead.org;
	Sat, 07 Nov 2026 03:19:23 +0000
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-8b306bbff8eso9953797b3.3
        for <linux-nvme@lists.infradead.org>; Fri, 06 Nov 2026 19:19:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794021560; cv=none;
        d=google.com; s=arc-20260327;
        b=NrLgM4Q8NUhPJR2Ng8ovmGU9zjxk8isumsjFFMCjOp2i3Zs01cs6n+HXBGMiiyrFXV
         hRH3xHPh7ybul1PpF2kM203Ppji0W79deGr1TWcn8BNH0VeJ2c2I1ZVYMyBO/H71oxFa
         Ro34tfnjwe85kfvSJqs0tUgdnh1xB/TyQ9+hL/UFn8xXynz16wEqojCAilj+nGOcod1H
         QQjiQDLIxGlNH4fAjbOejhDlNdtpIfK2BI/l7bkquPb+lLTOoo3MKwoUZkxTG42E7gNa
         GSvy7uSSxtP5NiXBGjKF3N4yZU2IWhk0Jyc8FOlzUItwgpFK2Lv+q/Zlr9hRukf3DmCJ
         wl9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=vBq+Vi8nhrcgb+rwT0xqsW9JqWl7+dVS67eiXkR00vw=;
        fh=ZFmJ8/OD33jRm9JmlqxvESefUbJ3pFMIVSb96Byb3xY=;
        b=dOSapiVbYDH01ItyqlY54+bLiKXHNh2QY5vvsMtwSSeOlDRAurnyaIhM6SJICPZbkD
         FftNdWfdaZsf0Os1YYAiGth/4UqnRt2Bf1PbE6mDP4H4dxGTHEfMl+KM22JH9dRcLNwD
         W5klVh5hbqRp08Bqv0yZ81jfovzyyDYpFbpxa/FZtloDTEDHmq4pUMT4v5jCL755YPwy
         LEdpmBOB+QPB5gFgJ1xdFaMOYJUlrV3y2BhDoPzLrTThUKKdit1Zm4IAzohKR8RFDFSf
         /kIGF7jiJlk6fRLUVYo+b+DwcZBcRm7Cy9/ePdq9sxzIRN62v6anKGDJIrA0kdQYw3yp
         h0Bg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794021560; x=1794626360; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vBq+Vi8nhrcgb+rwT0xqsW9JqWl7+dVS67eiXkR00vw=;
        b=IOgAJhyk/dTbNlquQ/hokQKtKqKzhVeM5At89sdTY6VvKhEQWcm/flMetZUYHaYj2u
         e3vhRc+ytBqjajL+nIbvGMf42fnyLIemlKZNK73R/vFqOFGoVGCoWV9NmxlSC8xbJmHI
         7Z0GT5O6OrT0Y0tNBDJd7+QK+f5+KOsPzDqFXUWCKzKaoZVtCQ2uZtxcmGylZ0g4v5hX
         Ps6X2VesalfKLEEFWZ7SUYB/GUp/kHIADiVbP/S54lVG5ako05NMfupe+aHtXQCaEVYt
         zXNM0jrN/GOWH4Slfkr38a/rAU+JgdnGKUsxAUzS/YKOohwwuYsARVuq8exaSAU0spNQ
         U0+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794021560; x=1794626360;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vBq+Vi8nhrcgb+rwT0xqsW9JqWl7+dVS67eiXkR00vw=;
        b=n6CypyWmkLx3lrLkUrN3DX1CUY5e2GigVR0+LcZeAxkMdX4tYIukoeomY2sGv2y6Mp
         3JTmwYIyqXE8/b4hTlADpYhPXwvNSiN13iv9T7oaL2FzRn6Xa6V66GfVuaIB568WUdDh
         SQBHOMGoZ0hLcNju98d36rfASiW6GlHrJM3L5JW5e2j1QUIvYon9epgNOLRDDe3nyqGq
         wN5ttVLVBPwie03Z7OD7aJOFxjCpI+B/Gii/ZA49mKmCEOJDazITJtUHALWki19N2Vya
         EmvuaE+Kt4jL5eSVOs6NTYpu6a3kDfpLhyghjUPTmQ+ZLo3EPNOEFQabHFAIvjCnqYVq
         001w==
X-Gm-Message-State: APuU4Z/PIjPoOE0oMFiiP2+sCPCM7ODcORRF4rp+2lR+i9CcPfwrPi31
	l4h9WGymHZesvDxrbcCuPyo5irBWioB7uNQFeAuoDbmnIuDUst+7K7L1ZhgL0fTDASuxr1Ds3+9
	Euh0Rv5E1cJkNBnKtn1I63wm68/sVUGy1b8D/
X-Gm-Gg: AYBFou0zNbP1IF7KVl64gtx+NxaeYGsWs2Mjx4tWipFreEMfv8JcPhFDvs7jIjppHyW
	RBZeQABStVfSNG54lDartJGSW1AULzEPgDQuvGLym+oKeLud4mBE1Q9G2hQmeac2yThymct+EEV
	A1H+wiyXvhSPK80RZRXqnns9IUBS1DyAyFSbBDu5U8YMc8hvfadvzdizFPAs7MWmaYbNldpPjfM
	8Nh0fnnmvoLrWxElRhQvcD0BEOVCYLTDJc05WsZCz7uLSfvWEreiHKAJbaLgkC+HxwbUdGil6k6
	3kY8FxhCOBAdWv7t6SVkbDpXs8PMrcEVtnZQPRfvy3Ds4yrkITaSprpLKuuj/MuxWb9cDF5k9sS
	lN/MCNF1kEZRpDD63KKGHYZDGmCapvX20jtFBDgEfPrb2WN/VGWnndO8aZHuNHRAhYvf8e8d21c
	nOjcUqShFqlbquqC7g+A==
X-Received: by 2002:a05:690c:9509:b0:8b3:3096:26da with SMTP id
 00721157ae682-8b34192ed4cmr17503037b3.33.1794021559737; Fri, 06 Nov 2026
 19:19:19 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CALJMncxA-=OFc05Ht74hWnia8-sCd5yLn5hK+KfnoHMO_sbzSQ@mail.gmail.com>
 <IA6PR08MB10897D405AB097DF85E193EF8DB682@IA6PR08MB10897.namprd08.prod.outlook.com>
In-Reply-To: <IA6PR08MB10897D405AB097DF85E193EF8DB682@IA6PR08MB10897.namprd08.prod.outlook.com>
From: Omar Alzand <omaribrahimfadel@gmail.com>
Date: Sat, 7 Nov 2026 06:19:08 +0300
X-Gm-Features: AclHuK9UoQy8dj8EL_wQkwCksXt2uctDYqjGMi2Kx9VuGUW1xrMLT380xKjdvxk
Message-ID: <CALJMnczUpA9tMLSvGuXJKDUn=XN3ucPeS6aU0nv4jmSm1jS_FA@mail.gmail.com>
Subject: Re: nvme-pci: Micron 2200 (1344:5410) needs NVME_QUIRK_DMAPOOL_ALIGN_512
To: Bean Huo <beanhuo@micron.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Keith Busch <kbusch@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: multipart/mixed; boundary="000000000000c9d76d065fa731ba"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261106_191921_864917_59FE7780 
X-CRM114-Status: GOOD (  24.29  )
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000c9d76d065fa731ba
Content-Type: text/plain; charset="UTF-8"

Hi Bean,

Thanks for checking internally.

I only have a single 2200V so I can't test a second 2200 or a
different firmware; the single-device caveat from my first mail still
stands. If anyone on the list has another 1344:5410 unit, a second
data point would be welcome.

Since the quirk only changes the PRP-list pool alignment with no
functional downside, and you have no objection to the 1344:5410 entry,
I've attached the patch adding the nvme_id_table entry after the
1344:5407


Thanks,
Omar

On Thu, 5 Nov 2026 at 00:40, Bean Huo <beanhuo@micron.com> wrote:
>
> Omar,
>
> I checked, Micron 2200 is an EOL product, and I am not able to confirm from our side
> that this is the same root cause as the 4100AT, or whether it applies to all drives/firmware
> sharing PCI ID 1344:5410.
>
> your results are based on a single 2200V. Do you have the same issue on the second device?
>
> NVME_QUIRK_DMAPOOL_ALIGN_512 only changes the PRP list pool alignment and has
> no functional downside, so I have no objection to adding the 1344:5410 entry as Christoph
> suggested.
>
> Kind regards,
> Bean
>
>
>

--000000000000c9d76d065fa731ba
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-nvme-pci-add-NVME_QUIRK_DMAPOOL_ALIGN_512-for-Micron-2200.patch"
Content-Disposition: attachment; 
	filename="0001-nvme-pci-add-NVME_QUIRK_DMAPOOL_ALIGN_512-for-Micron-2200.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mw5u2jzl0>
X-Attachment-Id: f_mw5u2jzl0

RnJvbSAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBPbWFyIEFsemFuZCA8b21hcmlicmFoaW1mYWRlbEBnbWFpbC5j
b20+CkRhdGU6IEZyaSwgNyBOb3YgMjAyNiAwNjoxMDowMCArMDMwMApTdWJqZWN0OiBbUEFUQ0hd
IG52bWUtcGNpOiBhZGQgTlZNRV9RVUlSS19ETUFQT09MX0FMSUdOXzUxMiBmb3IgTWljcm9uIDIy
MDAKClRoZSBNaWNyb24gMjIwMCAoMTM0NDo1NDEwKSBjb3JydXB0cyB0aGUgbGFzdCBwYWdlIG9m
IHJlYWRzIG9mIGV4YWN0bHkKMzMgcGFnZXMgKDEzMiBLaUIpLiAgU3VjaCBhIHJlYWQgdXNlcyBh
IDMyLWVudHJ5IFBSUCBsaXN0LCB3aGljaCBleGFjdGx5CmZpbGxzIGEgMjU2LWJ5dGUgc21hbGwt
cG9vbCBkZXNjcmlwdG9yLCBhbmQgdGhlIGZpbmFsIHBhZ2UgaXMgZHJvcHBlZAp3aGlsZSB0aGUg
cmVhZCBzdGlsbCByZXR1cm5zIHN1Y2Nlc3MuICBPbiBidHJmcyB0aGlzIGFwcGVhcnMgYXMKaW50
ZXJtaXR0ZW50ICJjc3VtIGZhaWxlZCIgcmVhZCBlcnJvcnMgdGhhdCBzdWNjZWVkIG9uIHJldHJ5
LgoKQSByYXctZGV2aWNlIHRlc3QgKGVpZ2h0IE9fRElSRUNUIHJlYWRlcnMgb2YgTiBwYWdlcyBp
bnRvIGEgMHhBQS1maWxsZWQKYnVmZmVyLCBwbHVzIG1peGVkLXNpemUgYmFja2dyb3VuZCBsb2Fk
KSBpc29sYXRlcyBpdCB0byAzMy1wYWdlIHJlYWRzOgoKICBwYWdlcyAgIHJlYWRzICAgIGJhZCBw
YWdlcwogICAgIDMyICAgMjM1MTUgICAgMAogICAgIDMzICAgMTc3MTUgICAgMTAwMSAgIChhbGwg
YXQgcGFnZSAzMywgfjUuNjUlKQogICAgIDM0ICAgMTM3MzUgICAgMAoKQm9vdGluZyB3aXRoIG52
bWUucXVpcmtzPTEzNDQ6NTQxMDpkbWFwb29sX2FsaWduXzUxMiBlbGltaW5hdGVzIGl0CigxMzMy
ODAgcmVhZHMgYXQgMzMgcGFnZXMsIDAgYmFkKSBhbmQgY2xlYXJzIHRoZSBidHJmcyBjaGVja3N1
bSBlcnJvcnMuClNwbGl0dGluZyB0aGUgcmVhZCB2aWEgbWF4X3NlY3RvcnNfa2I9MTI4IGFsc28g
YXZvaWRzIGl0OyB3cml0ZXMgYXJlCnVuYWZmZWN0ZWQuICBUaGlzIGlzIHRoZSBzYW1lIHF1aXJr
IHRoZSBNaWNyb24gNDEwMEFUIG5lZWRlZC4KClZlcmlmaWVkIHRocm91Z2ggdGhlIG52bWUucXVp
cmtzIG1vZHVsZSBwYXJhbWV0ZXIgb24gYSBzaW5nbGUgMjIwMFYKKE1pY3Jvbl8yMjAwVl9NVEZE
SEJBNTEyVENLLCBmaXJtd2FyZSBQMU1BMFY0KTsgdGhpcyBhZGRzIHRoZSBlcXVpdmFsZW50Cmlk
X3RhYmxlIGVudHJ5LgoKU3VnZ2VzdGVkLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5k
ZT4KU2lnbmVkLW9mZi1ieTogT21hciBBbHphbmQgPG9tYXJpYnJhaGltZmFkZWxAZ21haWwuY29t
PgotLS0KIGRyaXZlcnMvbnZtZS9ob3N0L3BjaS5jIHwgMiArKwogMSBmaWxlIGNoYW5nZWQsIDIg
aW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L3BjaS5jIGIvZHJp
dmVycy9udm1lL2hvc3QvcGNpLmMKLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvcGNpLmMKKysrIGIv
ZHJpdmVycy9udm1lL2hvc3QvcGNpLmMKQEAgLTQ0MjYsNiArNDQyNiw4IEBAIHN0YXRpYyBjb25z
dCBzdHJ1Y3QgcGNpX2RldmljZV9pZCBudm1lX2lkX3RhYmxlW10gPSB7CiAJCQkJTlZNRV9RVUlS
S19JR05PUkVfREVWX1NVQk5RTiwgfSwKIAkgeyBQQ0lfREVWSUNFKDB4MTM0NCwgMHg1NDA3KSwg
LyogTWljcm9uIFRlY2hub2xvZ3kgSW5jIE5WTWUgU1NEICovCiAJCS5kcml2ZXJfZGF0YSA9IE5W
TUVfUVVJUktfSUdOT1JFX0RFVl9TVUJOUU4gfSwKKwl7IFBDSV9ERVZJQ0UoMHgxMzQ0LCAweDU0
MTApLAkvKiBNaWNyb24gMjIwMCAqLworCQkuZHJpdmVyX2RhdGEgPSBOVk1FX1FVSVJLX0RNQVBP
T0xfQUxJR05fNTEyLCB9LAogCSB7IFBDSV9ERVZJQ0UoMHgxMzQ0LCAweDYwMDEpLCAgIC8qIE1p
Y3JvbiBOaXRybyBOVk1lICovCiAJCSAuZHJpdmVyX2RhdGEgPSBOVk1FX1FVSVJLX0JPR1VTX05J
RCwgfSwKIAl7IFBDSV9ERVZJQ0UoMHgxMzQ0LCAweDYwMDQpLAkvKiBNaWNyb24gNDEwMEFUICov
Ci0tIAoyLjQzLjAK
--000000000000c9d76d065fa731ba--

