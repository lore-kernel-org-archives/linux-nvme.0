Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 495C8C369D9
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Apr 2025 19:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Date:To:From:Subject:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K6htldoXr9aJeErwsSbFswms5RF4CWlj3qq3DFQ2SEU=; b=KSETvezpIHBG/dgnOo67Q++wtA
	wIlZ1kJMXQQ8YY8ReEaP7AYitqZia4xcC9mX4rUR3FE2Y/FIzP8Jvyr9n+P+mpoMuV6jxUzGObQyJ
	o9yhk2s6NzRAV1EE3OkXQ9DA5knwHBO/XVBeDOhR5b1Ga3ImblLvAzfy6xm6HXcyp6QfYdxnGs4Oa
	LPUA/hOK5Vq54B7n8y9GjAYZnM5RL88YMYM7y8DF1h2iASjft9caFc5LETeCkc7ThoqQvIgYaeM5n
	HM+DVBCNd6chvHKXuNF/7LeCIspgTogY3vd9PirUkwjQ5V35fFdQY+wMylQqGagQ5PqMPZcBgqnWU
	HiTimVrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uADQE-0000000DpoO-3Xe7;
	Wed, 30 Apr 2025 19:48:46 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uADQC-0000000Dpme-0J45
	for linux-nvme@lists.infradead.org;
	Wed, 30 Apr 2025 19:48:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746042522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K6htldoXr9aJeErwsSbFswms5RF4CWlj3qq3DFQ2SEU=;
	b=BqLoEKwXUjQQvNpoopbbljNhL0j43oqHwvoff7KaNU75YByNc8Usbzjk80wfa568v4B5UR
	i1sLYIauYdeLJy1HK3rALohC8G/Ag+6S/MG4RaY4soXcllDQVcEsroeRavJcGpLMCHqEZk
	bjXej9jV2PyCE18kl8wXrDVr6ZONgu8=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-nMhy-rA_OUCUh26kig2Pzg-1; Wed, 30 Apr 2025 15:48:41 -0400
X-MC-Unique: nMhy-rA_OUCUh26kig2Pzg-1
X-Mimecast-MFC-AGG-ID: nMhy-rA_OUCUh26kig2Pzg_1746042521
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-7080c0fe7b5so4077807b3.2
        for <linux-nvme@lists.infradead.org>; Wed, 30 Apr 2025 12:48:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746042520; x=1746647320;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K6htldoXr9aJeErwsSbFswms5RF4CWlj3qq3DFQ2SEU=;
        b=Dy4z+oAHNenD8LSgLYg5IweYQ+HpB5pZtPg1lpj5r96Mr0qG/ksCOVRGwA2kyyXam3
         bUGjR+77DXBcSkn1ootljo6wxjSvtBFqDIOD9qnkq1K0fsT/Oti4TNkxKQfLuO/ZCgZi
         rDZERDsSryfjVx1Bh2+BdS90q+bdeyFmKR8msIMJGh+6FcHmrVO606BnDpbJv1S1cq0t
         SHRsHd7q0JmpwweNs5ff1g3GoNA7bVfvLcQeJIqY8lniqPsjsek3PnbpjptJ8sX1eY43
         dTXdIP2xSgaoAwwtHJ80ys5uS+rTsNSBpkJjFJAut1iLNAPf6tgWQuRgW4A+XbU0iFMh
         K8BA==
X-Gm-Message-State: AOJu0Yx0sHnRsLF0ZQ7kYvT7i5XKeLwV29Uue8JGRqanmbKHx34H/X5q
	f7kyGnRBCVv0ax5rAk1PtmDgGy2OPErYZH0Zh8jcSNxMjoTxqcORtlWQO6Q5QYeaJK4P4cN2KFE
	RQOt0g9EdFxbCe/H1oJE+5ORcvKJxA3XswVoi77pnaNa+nQncdKK/HMW293kKuJ9i7nnnGcqkBp
	Qh06XUv1DxuralX+pBTsHl90/MhUAjfLeQH7AFl2lECjfeoLPK
X-Gm-Gg: ASbGncu6kKpoEETm2hN8cDNQhrd6byij0zOCIJxAH2KShANvNTczF0x+dATtmGKRot3
	NWUxTnAf8REKelmdKYLEUndQu/0wKCBcHMohY04UIgvF4Tm1CrETPpiXTlbpLPZsnYKRrfUcY9x
	8jMxe/WKr2NZC4c8t1RQzauLesF3dudHjADtDHdn8IvYOrmQSD7GYsWR10RXAOk5Qqb13PHwCe/
	1apNH/y5uFJTsBSpvKF37wTVl+gXz3ufhoDusnR4R3n5TBMgH7Ww+smyIAlQP1KGwrJlkMdHNGH
	1KAZs0XJRKDibeWup7WSoM0a6tdsEMbhfPRaVtOgTiEKmhTOzkdtOjhUAlYAPA==
X-Received: by 2002:a05:690c:4984:b0:6fd:2fcf:12f5 with SMTP id 00721157ae682-708abe0b1c2mr72352227b3.27.1746042520318;
        Wed, 30 Apr 2025 12:48:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYGdp4vL/FGB9s/v75BFCFKdZtIAyLGX63a3R1/ODVXNrx0XkTmXRK9w0RRgR4GS9FE5qrmQ==
X-Received: by 2002:a05:690c:4984:b0:6fd:2fcf:12f5 with SMTP id 00721157ae682-708abe0b1c2mr72351857b3.27.1746042519947;
        Wed, 30 Apr 2025 12:48:39 -0700 (PDT)
Received: from ?IPv6:2600:6c64:4e7f:603b:fc4d:8b7c:e90c:601a? ([2600:6c64:4e7f:603b:fc4d:8b7c:e90c:601a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-708ae068ee9sm5603757b3.53.2025.04.30.12.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 12:48:39 -0700 (PDT)
Message-ID: <90dc48eb2acc075015c91eb1ff6a79e1eb999b46.camel@redhat.com>
Subject: Re: Samsung  PM1733 MZXL53T2HBLS-00AH3 and duplicate id's may need
 a quirk
From: Laurence Oberman <loberman@redhat.com>
To: linux-nvme@lists.infradead.org, kbusch@kernel.org, "Lombardi, Maurizio"
	 <mlombard@redhat.com>, bgurney@redhat.com
Date: Wed, 30 Apr 2025 15:48:38 -0400
In-Reply-To: <b368dde2186500caf71464bc966cf22953c5124a.camel@redhat.com>
References: <b368dde2186500caf71464bc966cf22953c5124a.camel@redhat.com>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zzXdwupubV6TvQy22xxrHdl4h5fSkK8W5PrWkuGzJFw_1746042521
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250430_124844_188800_C4C5C72B 
X-CRM114-Status: GOOD (  19.95  )
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

T24gV2VkLCAyMDI1LTA0LTMwIGF0IDEyOjE0IC0wNDAwLCBMYXVyZW5jZSBPYmVybWFuIHdyb3Rl
Ogo+IEhlbGxvCj4gCj4gQSBjdXN0b21lciB3YXMgYXR0ZW1wdGluZyB0byBjcmVhdGUgYWRkaXRp
b25hbCBuYW1lc3BhY2VzIG9uIHRoaXMKPiBkZXZpY2UgYW5kIGl0IGZhaWxlZCB3aXRoIAo+IAo+
IFsgMTEyMC41MTY5NTJdIG52bWUgbnZtZTA6IHJlc2Nhbm5pbmcgbmFtZXNwYWNlcy4KPiBbIDEx
MjAuNTMxODczXSBudm1lIG52bWUwOiBkdXBsaWNhdGUgSURzIGluIHN1YnN5c3RlbSBmb3IgbnNp
ZCAyCj4gWyAxMTIwLjU3Mzg5MV0gbnZtZSBudm1lMDogZHVwbGljYXRlIElEcyBpbiBzdWJzeXN0
ZW0gZm9yIG5zaWQgNAo+IFsgMTEyMC41ODc4MjJdIG52bWUgbnZtZTA6IGR1cGxpY2F0ZSBJRHMg
aW4gc3Vic3lzdGVtIGZvciBuc2lkIDUKPiBbIDExMjAuNjAxODg2XSBudm1lIG52bWUwOiBkdXBs
aWNhdGUgSURzIGluIHN1YnN5c3RlbSBmb3IgbnNpZCA2Cj4gCj4gSSBhZGRlZCBzb21lIGRlYnVn
IGFuZCB0aGlzIHdhcyBmbGFnZ2VkIGhlcmUKPiAKPiB3ZSB0cmlnZ2VyIG9uIHRoaXMgYW5kIHdl
IHJldHVybiAtRU5WQUwKPiAKPiAKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlm
IChoYXNfZXVpNjQgJiYKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBt
ZW1jbXAoJmlkcy0+ZXVpNjQsICZoLT5pZHMuZXVpNjQsIHNpemVvZihpZHMtCj4gPiBldWk2NCkp
ID09IDApIHsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBwcmludGsoIlJIREVCVUc6IGlkcy0+ZXVpNjQ6ICVwVUIgaC0KPiA+IGlkcy5ldWk2NDogJXBV
QlxuIiwmaWRzLT51dWlkLCZoLT5pZHMudXVpZCk7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIC1FSU5WQUw7Cj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqB9Cj4gCj4gVGhpcyBsZWFkcyB0byB0aGUgY29kZSBoZXJlIGJhaWxp
bmcgd2l0aCB0aGUgZHVwbGljYXRlIGlkIG1lc3NhZ2UKPiAKPiBzdGF0aWMgaW50IG52bWVfaW5p
dF9uc19oZWFkKHN0cnVjdCBudm1lX25zICpucywgc3RydWN0IG52bWVfbnNfaW5mbwo+ICppbmZv
KQo+IHsKPiDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsID0gbnMtPmN0cmw7
Cj4gwqDCoMKgwqDCoMKgwqAgc3RydWN0IG52bWVfbnNfaGVhZCAqaGVhZCA9IE5VTEw7Cj4gwqDC
oMKgwqDCoMKgwqAgaW50IHJldDsKPiAKPiAuLgo+IC4uCj4gwqDCoMKgwqDCoMKgwqAgbXV0ZXhf
bG9jaygmY3RybC0+c3Vic3lzLT5sb2NrKTsKPiDCoMKgwqDCoMKgwqDCoCBoZWFkID0gbnZtZV9m
aW5kX25zX2hlYWQoY3RybCwgaW5mby0+bnNpZCk7Cj4gwqDCoMKgwqDCoMKgwqAgaWYgKCFoZWFk
KSB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldCA9IG52bWVfc3Vic3lzX2No
ZWNrX2R1cGxpY2F0ZV9pZHMoY3RybC0+c3Vic3lzLAo+ICZpbmZvLT5pZHMpOwo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAocmV0KSB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkZXZfZXJyKGN0cmwtPmRldmljZSwKPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAi
ZHVwbGljYXRlIElEcyBpbiBzdWJzeXN0ZW0gZm9yIG5zaWQKPiAlZFxuIiwKPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbmZv
LT5uc2lkKTsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGdvdG8gb3V0X3VubG9jazsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+IC4u
Cj4gLi4KPiBvdXRfdW5sb2NrOgo+IMKgwqDCoMKgwqDCoMKgIG11dGV4X3VubG9jaygmY3RybC0+
c3Vic3lzLT5sb2NrKTsKPiDCoMKgwqDCoMKgwqDCoCByZXR1cm4gcmV0Owo+IH0KPiAKPiBNeSBx
dWVzdGlvbiBkbyB3ZSBuZWVkIHRvIGFkZCB5ZXQgYW5vdGhlciBOVk1FX1FVSVJLX0JPR1VTX05J
RCwgZm9yCj4gdGhpcyBkZXZpY2UgbW9kZWwuCj4gCj4gSGFzIGFueWJvZHkgZWxzZSBzZWVuIHRo
aXMKPiAKPiBSZWdhcmRzCj4gTGF1cmVuY2UKCgpRdWljayBmb2xsb3cgdXAsIFRoaXMgaXMgbm90
IGEgcGF0Y2ggeWV0LCBqdXN0IGFuIHVwZGF0ZSB0byBnZXQKZmVlZGJhY2sgZmlyc3QuCgpUaGUg
cXVpcmsgd29ya3MKV291bGQgaXQgYmUgYWNjZXB0YWJsZSB0byBhZGQgdGhpcyBhbmQgaWYgc28g
SSB3aWxsIHNlbmQgYW4gb2ZmaWNpYWwKcGF0Y2gKCgpkaWZmIC1OdXJwIGxpbnV4LTUuMTQuMC01
MDMuMzguMS5lbDlfNS5vcmlnL2RyaXZlcnMvbnZtZS9ob3N0L3BjaS5jCmxpbnV4LTUuMTQuMC01
MDMuMzguMS5lbDlfNS9kcml2ZXJzL252bWUvaG9zdC9wY2kuYwotLS0gbGludXgtNS4xNC4wLTUw
My4zOC4xLmVsOV81Lm9yaWcvZHJpdmVycy9udm1lL2hvc3QvcGNpLmMJMjAyNS0KMDQtMTMgMjA6
MjI6MjAuMDAwMDAwMDAwIC0wNDAwCisrKyBsaW51eC01LjE0LjAtNTAzLjM4LjEuZWw5XzUvZHJp
dmVycy9udm1lL2hvc3QvcGNpLmMJMjAyNS0wNC0zMAoxMjo0NDoxMS4wNjg5NjMxMDYgLTA0MDAK
QEAgLTM0MzIsNiArMzQzMiw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcGNpX2RldmljZV9pZCBu
dm1lX2kKIAkJLmRyaXZlcl9kYXRhID0gTlZNRV9RVUlSS19ESVNBQkxFX1dSSVRFX1pFUk9FUywg
fSwKIAl7IFBDSV9ERVZJQ0UoMHgxNDRkLCAweGE4MDIpLCAgIC8qIFNhbXN1bmcgU005NTMgKi8K
IAkJLmRyaXZlcl9kYXRhID0gTlZNRV9RVUlSS19CT0dVU19OSUQsIH0sCisJeyBQQ0lfREVWSUNF
KDB4MTQ0ZCwgMHhhODI0KSwgICAvKiBTYW1zdW5nICBQTTE3MzMKTVpYTDUzVDJIQkxTLTAwQUgz
ICovCisJCS5kcml2ZXJfZGF0YSA9IE5WTUVfUVVJUktfQk9HVVNfTklELCB9LAogCXsgUENJX0RF
VklDRSgweDFjYzQsIDB4NjMwMyksICAgLyogVU1JUyBSUEpUSjUxMk1HRTFRRFkgNTEyRwoqLwog
CQkuZHJpdmVyX2RhdGEgPSBOVk1FX1FVSVJLX0RJU0FCTEVfV1JJVEVfWkVST0VTLCB9LAogCXsg
UENJX0RFVklDRSgweDFjYzQsIDB4NjMwMiksICAgLyogVU1JUyBSUEpUSjI1Nk1HRTFRRFkgMjU2
RwoqLwo=


