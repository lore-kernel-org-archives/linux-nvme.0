Return-Path: <SRS0=oXoK=KQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 904FCC433ED
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 00:39:35 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB1DD60C3E
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 00:39:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB1DD60C3E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ldXfZLZxnmYxJ+6yDpPsKNbuR7PB4DUdOmodt6sWXmU=; b=qMBcyu0j/zkPFwyq+zfrgntv6L
	66M1NYKbcSLo/57eGLG2gsuZgChhhuYxargDs50KEQOxISeRXtOWKCvMm4ul/3woLfBsmrZwaEBFm
	KWIH75awers0Ufm9q0vhXXSQAZsqBUqDoBf/7tuZY/8a423riws7o8LNTYCxkl9gdm5eSeZkpSwg5
	PwjylStoPZbaPLZs9x1857ilATVPf6CPBINks6LnVHMGnHGMX3oD/EwgDhRIBcXgFZO0JjUArdbOW
	veV/ja4q7IXmlzH7XAFGsjlrMnfDhNyDlaBdJzzUC0Eo460O7Fl+17paD2gwZ9T0pYlovOl2EYdpP
	iFyagfRQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ljtBq-0038Dr-VF; Fri, 21 May 2021 00:38:59 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ljtBm-0038B5-Q7
 for linux-nvme@desiato.infradead.org; Fri, 21 May 2021 00:38:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-ID:Content-Description;
 bh=E+6BHO0qd7vtjHzsYJn+/xofpizOdrNRNiAn4fQyoiE=; b=ZYPASh64DeDzwv6kCZnfBczNTm
 MX3Wm3p507DkYuoubASMncBMfeJlMJ4gRr26ZzirGUpgLdK5Ga0gByC66TpShaNDu2EY6wycVauRw
 Qmf9lPjROe5QL04HxdGr9E+sbewllPyXVoZMgDCo9edpk7pxV5VeY12cpNZytxZGvuRLa+wHmOUlc
 g/bKMJQWfMMO8ofua7XEebP0c+VO4XumgXyq/xBsKZzoWLGNqFfh8hebUPjoDqTYvk2h5DlnS24Qg
 N8tkidVRTPkeZLQAIlJiNWqhAIbzxKFsuEHcwuq9v+dX73en0h7UoGEiESeDSJUL4JAkTK2StVcTP
 gPwYrRRA==;
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljtBi-00GjTo-W3
 for linux-nvme@lists.infradead.org; Fri, 21 May 2021 00:38:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1621557527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E+6BHO0qd7vtjHzsYJn+/xofpizOdrNRNiAn4fQyoiE=;
 b=ERuQpbGe119tZYb7ZasyavM/0j3mb+CBzCqk7bo/r762/lrmESnYXPg3SRacWKQGgr3r+J
 CTth4uHKkb00K5LLe9sqbiSnzwPkI7TYEMv9Rpd9KWPAZhTatiRkSrync0C4B/HULhyAsC
 elu6imzwRJrHEdK0iclZuun/MfecjTM=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-579-iMMqp6DkMZuJGUiyTJdKfQ-1; Thu, 20 May 2021 20:38:46 -0400
X-MC-Unique: iMMqp6DkMZuJGUiyTJdKfQ-1
Received: by mail-yb1-f197.google.com with SMTP id
 p138-20020a2542900000b029051304a381d9so12570851yba.20
 for <linux-nvme@lists.infradead.org>; Thu, 20 May 2021 17:38:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=E+6BHO0qd7vtjHzsYJn+/xofpizOdrNRNiAn4fQyoiE=;
 b=ciIRJmrqmaprAfAbau4c01FOwhVNMM8Qzg6kse73RtCbleeZ/pdinpnqhX8IAdG1E0
 HKTdTyD01faKpOcVDHrd5NUAUZsL+AaBDDVL9IBVMIi3lAZCsI3N2MGXGdbYPDjdhsUU
 1bFpTQaV5W0s4+bfrb9SvWhyUd8YSMlvUxx7M801R9PF1qDR6jhAyu7eV01wIZlMgOT6
 /VCw8xPb+kPduEc22+OJD4WH1aSAaffdfdDRCeEUFPvQDumDF/5DiawJJxepP+MsuCTR
 VKk2gFEUP5FQZINRCQHL9os+nDvC9tAwgzOlEg9iQw1TUAn3tuiTow+8glyD8Y8spX9P
 mSsQ==
X-Gm-Message-State: AOAM532LMySSpbOfqFYToKlJ2UPatoF1mNjEUHAf7VwrgtHC5ccipXf8
 OgrRAsdD2gm6cYjap4qnIoaz3XEXe1FdHl7cdVqzrLys04AtM5UI4YKkRv7A3PncUD1dTRXlgSe
 W+zJn/YKnDfebHmFr6vZavg+Na7PrOJR7SumopOdFhqs=
X-Received: by 2002:a25:2009:: with SMTP id g9mr11019834ybg.198.1621557525569; 
 Thu, 20 May 2021 17:38:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwht0EMox1Mrr8wTfduQVprH4yzlZ2HggVff3IsEdYP1lHnoL1+nOGnjDfLlrsWeL8r6QIupbfEUJEdycHEou0=
X-Received: by 2002:a25:2009:: with SMTP id g9mr11019818ybg.198.1621557525373; 
 Thu, 20 May 2021 17:38:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs-hAaHhWU4Kb4NrQ9Fvi7DiH95P=Q=7zK-inxpeZtztkw@mail.gmail.com>
 <3243ab72-ffe3-e655-ef0a-d695885ce2c5@grimberg.me>
 <CAHj4cs9uOHRgRe9PJ3_0A4NMo4T1q4XzCYG6UAV-V=RZ39i1iQ@mail.gmail.com>
 <CAHj4cs-JawWOTNBnQ3OTeNXUb_zeH3-5MrPQWK0=1QPfEJ7ROA@mail.gmail.com>
 <201a97a9-e42f-8d8e-3cc7-e5cf8ba816c2@grimberg.me>
 <423b7c5e-deb7-3547-6ca4-8f4476e9eb03@suse.de>
 <CAHj4cs-3sY=E643N89Gs46M0-KLivJP2WeXsB8bCftNq1kAe9g@mail.gmail.com>
 <CAHj4cs_NVzgA8=gC9MKSakdDgBR4ghLQv6H8tw_BgxUUvA+Uew@mail.gmail.com>
 <d0bd7905-9741-012f-ff7a-f211d8170088@suse.de>
In-Reply-To: <d0bd7905-9741-012f-ff7a-f211d8170088@suse.de>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Fri, 21 May 2021 08:38:33 +0800
Message-ID: <CAHj4cs8XEVdZKK1J0GHZxEzBkApOaO9T-uONGiimM-_qR8Kjaw@mail.gmail.com>
Subject: Re: [bug report] blktests nvme/022 lead kernel WARNING and NULL
 pointer
To: Hannes Reinecke <hare@suse.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, 
 skt-results-master@redhat.com, Bruno Goncalves <bgoncalv@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210520_173851_151097_4BF0AC67 
X-CRM114-Status: GOOD (  17.07  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

PiA+Cj4gPiBXaGF0IGFib3V0IHRoaXM/CgpIaSBIYW5uZXMKV2l0aCB0aGlzIHBhdGNoLCBubyBX
QVJOTklORy9OVUxMIHBvaW50ZXIgdGhpcyB0aW1lLCBidXQgc3RpbGwgaGF2ZQona2VlcC1hbGl2
ZSB0aW1lciBleHBpcmVkJyBhbmQgcmVzZXQgZmFpbHVyZSBpc3N1ZSwgaGVyZSBpcyB0aGUgZnVs
bApsb2c6CgojIC4vY2hlY2sgbnZtZS8wMjIKbnZtZS8wMjIgKHRlc3QgTlZNZSByZXNldCBjb21t
YW5kIG9uIE5WTWVPRiBmaWxlLWJhY2tlZCBucykgIFtmYWlsZWRdCiAgICBydW50aW1lICAxMC42
NDZzICAuLi4gIDExLjA4N3MKICAgIC0tLSB0ZXN0cy9udm1lLzAyMi5vdXQgMjAyMS0wNS0yMCAy
MDoxNjozMS4zODQwNjg4MDcgLTA0MDAKICAgICsrKyAvcm9vdC9ibGt0ZXN0cy9yZXN1bHRzL25v
ZGV2L252bWUvMDIyLm91dC5iYWQgMjAyMS0wNS0yMAoyMDoyNDoyNy44NzQyNTA0NjYgLTA0MDAK
ICAgIEBAIC0xLDQgKzEsNSBAQAogICAgIFJ1bm5pbmcgbnZtZS8wMjIKICAgICA5MWZkYmEwZC1m
ODdiLTRjMjUtYjgwZi1kYjdiZTE0MThiOWUKICAgICB1dWlkLjkxZmRiYTBkLWY4N2ItNGMyNS1i
ODBmLWRiN2JlMTQxOGI5ZQogICAgK0VSUk9SOiByZXNldCBmYWlsZWQKICAgICBUZXN0IGNvbXBs
ZXRlCiMgY2F0IHJlc3VsdHMvbm9kZXYvbnZtZS8wMjIuZnVsbApSZXNldDogTmV0d29yayBkcm9w
cGVkIGNvbm5lY3Rpb24gb24gcmVzZXQKTlFOOmJsa3Rlc3RzLXN1YnN5c3RlbS0xIGRpc2Nvbm5l
Y3RlZCAxIGNvbnRyb2xsZXIocykKClszNzM1My4wNjg0NDhdIHJ1biBibGt0ZXN0cyBudm1lLzAy
MiBhdCAyMDIxLTA1LTIwIDIwOjI0OjE2ClszNzM1My4xNDYzMDFdIG52bWV0OiBhZGRpbmcgbnNp
ZCAxIHRvIHN1YnN5c3RlbSBibGt0ZXN0cy1zdWJzeXN0ZW0tMQpbMzczNTMuMTYxNzY1XSBudm1l
dDogY3JlYXRpbmcgY29udHJvbGxlciAxIGZvciBzdWJzeXN0ZW0KYmxrdGVzdHMtc3Vic3lzdGVt
LTEgZm9yIE5RTgpucW4uMjAxNC0wOC5vcmcubnZtZXhwcmVzczp1dWlkOjZhNzBkMjIwLWJmZGUt
MTAwMC0wM2NlLWVhNDBiODczMDkwNC4KWzM3MzUzLjE3NTc5Nl0gbnZtZSBudm1lMDogY3JlYXRp
bmcgMTI4IEkvTyBxdWV1ZXMuClszNzM1My4xODk3MzRdIG52bWUgbnZtZTA6IG5ldyBjdHJsOiAi
YmxrdGVzdHMtc3Vic3lzdGVtLTEiClszNzM1NC4yMTY2ODZdIG52bWUgbnZtZTA6IHJlc2V0dGlu
ZyBjb250cm9sbGVyClszNzM2My4yNzA2MDddIG52bWV0OiBjdHJsIDEga2VlcC1hbGl2ZSB0aW1l
ciAoNSBzZWNvbmRzKSBleHBpcmVkIQpbMzczNjMuMjc2NTIxXSBudm1ldDogY3RybCAxIGZhdGFs
IGVycm9yIG9jY3VycmVkIQpbMzczNjMuMjgxMDU4XSBudm1lIG52bWUwOiBSZW1vdmluZyBjdHJs
OiBOUU4gImJsa3Rlc3RzLXN1YnN5c3RlbS0xIgoKIyAuL2NoZWNrIG52bWUvMDIxCm52bWUvMDIx
ICh0ZXN0IE5WTWUgbGlzdCBjb21tYW5kIG9uIE5WTWVPRiBmaWxlLWJhY2tlZCBucykgICBbcGFz
c2VkXQogICAgcnVudGltZSAgMTAuOTU4cyAgLi4uICAxMS4zODJzCiMgZG1lc2cKWzM4MTQyLjg2
Mjg4MV0gcnVuIGJsa3Rlc3RzIG52bWUvMDIxIGF0IDIwMjEtMDUtMjAgMjA6Mzc6MjYKWzM4MTQy
Ljk0MTAzOF0gbnZtZXQ6IGFkZGluZyBuc2lkIDEgdG8gc3Vic3lzdGVtIGJsa3Rlc3RzLXN1YnN5
c3RlbS0xClszODE0Mi45NTY2MjFdIG52bWV0OiBjcmVhdGluZyBjb250cm9sbGVyIDEgZm9yIHN1
YnN5c3RlbQpibGt0ZXN0cy1zdWJzeXN0ZW0tMSBmb3IgTlFOCm5xbi4yMDE0LTA4Lm9yZy5udm1l
eHByZXNzOnV1aWQ6NmE3MGQyMjAtYmZkZS0xMDAwLTAzY2UtZWE0MGI4NzMwOTA0LgpbMzgxNDIu
OTcwNTI0XSBudm1lIG52bWUwOiBjcmVhdGluZyAxMjggSS9PIHF1ZXVlcy4KWzM4MTQyLjk4NDM1
Nl0gbnZtZSBudm1lMDogbmV3IGN0cmw6ICJibGt0ZXN0cy1zdWJzeXN0ZW0tMSIKWzM4MTQ0LjAx
NDYwMV0gbnZtZSBudm1lMDogUmVtb3ZpbmcgY3RybDogTlFOICJibGt0ZXN0cy1zdWJzeXN0ZW0t
MSIKWzM4MTUzLjAzMDEwN10gbnZtZXQ6IGN0cmwgMSBrZWVwLWFsaXZlIHRpbWVyICg1IHNlY29u
ZHMpIGV4cGlyZWQhClszODE1My4wMzYwMThdIG52bWV0OiBjdHJsIDEgZmF0YWwgZXJyb3Igb2Nj
dXJyZWQhCgoKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvdGFyZ2V0L2xvb3AuYyBiL2Ry
aXZlcnMvbnZtZS90YXJnZXQvbG9vcC5jCj4gaW5kZXggNzRiM2IxNTBlMWE1Li45ODM4YTdkMjdi
YzEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9udm1lL3RhcmdldC9sb29wLmMKPiArKysgYi9kcml2
ZXJzL252bWUvdGFyZ2V0L2xvb3AuYwo+IEBAIC0yNjMsNyArMjYzLDggQEAgc3RhdGljIGNvbnN0
IHN0cnVjdCBibGtfbXFfb3BzCj4gbnZtZV9sb29wX2FkbWluX21xX29wcyA9IHsKPgo+ICAgc3Rh
dGljIHZvaWQgbnZtZV9sb29wX2Rlc3Ryb3lfYWRtaW5fcXVldWUoc3RydWN0IG52bWVfbG9vcF9j
dHJsICpjdHJsKQo+ICAgewo+IC0gICAgICAgY2xlYXJfYml0KE5WTUVfTE9PUF9RX0xJVkUsICZj
dHJsLT5xdWV1ZXNbMF0uZmxhZ3MpOwo+ICsgICAgICAgaWYgKCF0ZXN0X2FuZF9jbGVhcl9iaXQo
TlZNRV9MT09QX1FfTElWRSwgJmN0cmwtPnF1ZXVlc1swXS5mbGFncykpCj4gKyAgICAgICAgICAg
ICAgIHJldHVybjsKPiAgICAgICAgICBudm1ldF9zcV9kZXN0cm95KCZjdHJsLT5xdWV1ZXNbMF0u
bnZtZV9zcSk7Cj4gICAgICAgICAgYmxrX2NsZWFudXBfcXVldWUoY3RybC0+Y3RybC5hZG1pbl9x
KTsKPiAgICAgICAgICBibGtfY2xlYW51cF9xdWV1ZShjdHJsLT5jdHJsLmZhYnJpY3NfcSk7Cj4g
QEAgLTI5OSw2ICszMDAsNyBAQCBzdGF0aWMgdm9pZCBudm1lX2xvb3BfZGVzdHJveV9pb19xdWV1
ZXMoc3RydWN0Cj4gbnZtZV9sb29wX2N0cmwgKmN0cmwpCj4gICAgICAgICAgICAgICAgICBjbGVh
cl9iaXQoTlZNRV9MT09QX1FfTElWRSwgJmN0cmwtPnF1ZXVlc1tpXS5mbGFncyk7Cj4gICAgICAg
ICAgICAgICAgICBudm1ldF9zcV9kZXN0cm95KCZjdHJsLT5xdWV1ZXNbaV0ubnZtZV9zcSk7Cj4g
ICAgICAgICAgfQo+ICsgICAgICAgY3RybC0+Y3RybC5xdWV1ZV9jb3VudCA9IDE7Cj4gICB9Cj4K
PiAgIHN0YXRpYyBpbnQgbnZtZV9sb29wX2luaXRfaW9fcXVldWVzKHN0cnVjdCBudm1lX2xvb3Bf
Y3RybCAqY3RybCkKPiBAQCAtNDA1LDYgKzQwNyw3IEBAIHN0YXRpYyBpbnQgbnZtZV9sb29wX2Nv
bmZpZ3VyZV9hZG1pbl9xdWV1ZShzdHJ1Y3QKPiBudm1lX2xvb3BfY3RybCAqY3RybCkKPiAgICAg
ICAgICByZXR1cm4gMDsKPgo+ICAgb3V0X2NsZWFudXBfcXVldWU6Cj4gKyAgICAgICBjbGVhcl9i
aXQoTlZNRV9MT09QX1FfTElWRSwgJmN0cmwtPnF1ZXVlc1swXS5mbGFncyk7Cj4gICAgICAgICAg
YmxrX2NsZWFudXBfcXVldWUoY3RybC0+Y3RybC5hZG1pbl9xKTsKPiAgIG91dF9jbGVhbnVwX2Zh
YnJpY3NfcToKPiAgICAgICAgICBibGtfY2xlYW51cF9xdWV1ZShjdHJsLT5jdHJsLmZhYnJpY3Nf
cSk7Cj4gQEAgLTQ2Miw4ICs0NjUsMTAgQEAgc3RhdGljIHZvaWQgbnZtZV9sb29wX3Jlc2V0X2N0
cmxfd29yayhzdHJ1Y3QKPiB3b3JrX3N0cnVjdCAqd29yaykKPiAgICAgICAgICBudm1lX2xvb3Bf
c2h1dGRvd25fY3RybChjdHJsKTsKPgo+ICAgICAgICAgIGlmICghbnZtZV9jaGFuZ2VfY3RybF9z
dGF0ZSgmY3RybC0+Y3RybCwgTlZNRV9DVFJMX0NPTk5FQ1RJTkcpKSB7Cj4gLSAgICAgICAgICAg
ICAgIC8qIHN0YXRlIGNoYW5nZSBmYWlsdXJlIHNob3VsZCBuZXZlciBoYXBwZW4gKi8KPiAtICAg
ICAgICAgICAgICAgV0FSTl9PTl9PTkNFKDEpOwo+ICsgICAgICAgICAgICAgICBpZiAoY3RybC0+
Y3RybC5zdGF0ZSAhPSBOVk1FX0NUUkxfREVMRVRJTkcgJiYKPiArICAgICAgICAgICAgICAgICAg
IGN0cmwtPmN0cmwuc3RhdGUgIT0gTlZNRV9DVFJMX0RFTEVUSU5HX05PSU8pCj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgLyogc3RhdGUgY2hhbmdlIGZhaWx1cmUgZm9yIG5vbi1kZWxldGVkIGN0
cmw/ICovCj4gKyAgICAgICAgICAgICAgICAgICAgICAgV0FSTl9PTl9PTkNFKDEpOwo+ICAgICAg
ICAgICAgICAgICAgcmV0dXJuOwo+ICAgICAgICAgIH0KPgo+Cj4gKEknbGwgYmUgc2VuZGluZyBv
dXQgYSBmb3JtYWwgcGF0Y2hzZXQgb25jZSBpdCdzIGNvbmZpcm1lZCkuCj4KPiBDaGVlcnMsCj4K
PiBIYW5uZXMKPiAtLQo+IERyLiBIYW5uZXMgUmVpbmVja2UgICAgICAgICAgICAgICAgS2VybmVs
IFN0b3JhZ2UgQXJjaGl0ZWN0Cj4gaGFyZUBzdXNlLmRlICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKPiBTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHbWJILCBN
YXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcKPiBIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyks
IEdlc2Now6RmdHNmw7xocmVyOiBGZWxpeCBJbWVuZMO2cmZmZXIKPgoKCi0tIApCZXN0IFJlZ2Fy
ZHMsCiAgWWkgWmhhbmcKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1u
dm1lCg==
