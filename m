Return-Path: <SRS0=morU=AH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C59C433E2
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 09:54:12 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4852C21531
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 09:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PUvoRD+S";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KQcBwfgb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="Kqx1kT6U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4852C21531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EkuqYKkzStYL/TAzpHbIreCiGK5+DIY8zYKhqYrchO8=; b=PUvoRD+SLX5RmuaV5v1iI+MZt
	3xnlR2BVt2iURJrVDdqWmGPFSichCXjTg68pmMwsvZSECwPNC3ruDLmJssgnVB9uvVPZN9LwDX5Do
	21hInnR1R+h5GlkjK7JJ1u6sZxB+D8+xo7klacyufIV8dqPssVYcjrrl9h5ywtAa00M5BSNVEXApI
	bblgvQwzHQdPhmCkkAPbRABlI3k1OFp85fvE0GeSag4CFCBG2nuXBMJl0XdUaH2wGFgdudR9hMTNN
	zPXsP7Uv96KKQDUbX37RdQyvQpyt/LMGYZJdeb1TNb8YSJERaEAqBHJJtoQ/iisdXKdw+K3atNP+T
	3UkX+QUNg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jol3d-0004Rx-VP; Fri, 26 Jun 2020 09:54:06 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jokka-0003YZ-RP
 for linux-nvme@merlin.infradead.org; Fri, 26 Jun 2020 09:34:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=24b5gDylzuSdyKBvIpDVqbEw1/MYXNgLUKpTA8z0MWE=; b=KQcBwfgbh2iCPiVqX1qcGaRi6p
 /lYXdP/Oha6IMMmm0s7xZq3Qs6f2aHAdlj6uZ3F/9ggDtTnP/WxwYrFxwRyx7BNpvalpKNqrANYAS
 GnQXqoOBc9qkUH5WwXYL1e1JMlfHIPtddBH9YmqcW3YRj7wT71v4Hkg7xP9ihEP3e3TCIDYgGufRP
 zuEMug+8U7SO45N53Y+ujMPyQE6vnvvEjhABwF4/cfQypZ8LMDHXogiQOfP62+pn7NNC7j4KwGs09
 lzSsTTp2HsZELjA7JMQ6P25hbVDz0Dn9k9z9GBVvKce149cIE0QkbyGYBQCs9hZ5mOV8zMz4HGOTB
 EDAiW8ew==;
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641])
 by casper.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jokhX-0002jx-V4
 for linux-nvme@lists.infradead.org; Fri, 26 Jun 2020 09:31:38 +0000
Received: by mail-ej1-x641.google.com with SMTP id o18so4251069eje.7
 for <linux-nvme@lists.infradead.org>; Fri, 26 Jun 2020 02:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=24b5gDylzuSdyKBvIpDVqbEw1/MYXNgLUKpTA8z0MWE=;
 b=Kqx1kT6UZOAW77lejOr7FDay+cq0DzqH5sUtObB13nvbH7Xi26tn55Hmmm6NB0XKi+
 LjEH+TFdXRHHDpWaRL0UBpi2Y4dqiy6W4yDtnOjbsph25kNKbzNZG6ACHQSklaGn2a6w
 Lxsx/oAcTovtQwwhnEB7BwR/vC8rEmc8IqZ7kDWyuPfNEpzc4TRNN1H2pUNJuKUiiei/
 EXj6I60Xl/scyZwBhYEvslCEOAIxVI/Ta76SVXnlbj7yLLEcjx7rVLDRBNK30AAXwe0w
 5GplKkYYolnJKgxiCmCLaK7VaogQkUNSu2hFVm0xnwBSpxs3hcg3oBcBTnOa0NM/qzv4
 TkAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=24b5gDylzuSdyKBvIpDVqbEw1/MYXNgLUKpTA8z0MWE=;
 b=B1AI14H3wJt4EtBuOwiFofpFwYK3XUJFKwyDdOzQLYpDvuF9yisYJx+JmH17M6AN3G
 3qYejeA04HorXckEAsA1+olDpY8tiCy3RtYtfhSXXIUdLtecvVpeL16fpvaQJ18ucvV1
 g5ZMX9EV4qPlQbZ78IiYToomqUb5I375kHaW69VNouX04WXi6jOBw2+QkIXTnV+p12lM
 GAzoyH31tI3xmPF31rZyCPHeZfXosL1bSwchEKVU+XRX6GrFIlZWLuwL6HjqDe90s5Tw
 0sZgdhb0e9INVGdQHa6Bbsd/lR+280h2cQTli+3q3w6xsM5f5/OJNI7yCedhB0MhJX4A
 +D7Q==
X-Gm-Message-State: AOAM532zuf75rq8i7yq5PmqQwonyLa+xlSv5vGzmcz6P0bb1Us8mGk+c
 ZJCHbktF3dhB7HRxVKGKDXleLcMnFLUpjFFw
X-Google-Smtp-Source: ABdhPJys1/vocZCEORKXSfmdqU9cuvhxcgqTD4kZyktEJulCiXtYHgtGolOMluHFxgN0G6q0GuxDfw==
X-Received: by 2002:a17:906:add3:: with SMTP id
 lb19mr1287370ejb.308.1593154547182; 
 Thu, 25 Jun 2020 23:55:47 -0700 (PDT)
Received: from localhost (ip-5-186-127-235.cgn.fibianet.dk. [5.186.127.235])
 by smtp.gmail.com with ESMTPSA id l6sm20158305edn.42.2020.06.25.23.55.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 23:55:46 -0700 (PDT)
Date: Fri, 26 Jun 2020 08:55:46 +0200
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To: Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH 6/6] nvme: Add consistency check for zone count
Message-ID: <20200626065546.v266c3zjv2gjoycs@mpHalley.localdomain>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-7-javier@javigon.com>
 <20200625214921.GA1773527@dhcp-10-100-145-180.wdl.wdc.com>
 <MWHPR04MB3758829D20916B73DDB5581EE7930@MWHPR04MB3758.namprd04.prod.outlook.com>
 <20200626061310.6invpvs2tzxfbida@mpHalley.localdomain>
 <CY4PR04MB375167CFC4E3CF22324C71B5E7930@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CY4PR04MB375167CFC4E3CF22324C71B5E7930@CY4PR04MB3751.namprd04.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200626_103116_533819_603E3821 
X-CRM114-Status: GOOD (  26.39  )
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
 SelvaKumar S <selvakuma.s1@samsung.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 Kanchan Joshi <joshi.k@samsung.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Nitesh Shetty <nj.shetty@samsung.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Keith Busch <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMjYuMDYuMjAyMCAwNjo0OSwgRGFtaWVuIExlIE1vYWwgd3JvdGU6Cj5PbiAyMDIwLzA2LzI2
IDE1OjEzLCBKYXZpZXIgR29uesOhbGV6IHdyb3RlOgo+PiBPbiAyNi4wNi4yMDIwIDAwOjA0LCBE
YW1pZW4gTGUgTW9hbCB3cm90ZToKPj4+IE9uIDIwMjAvMDYvMjYgNjo0OSwgS2VpdGggQnVzY2gg
d3JvdGU6Cj4+Pj4gT24gVGh1LCBKdW4gMjUsIDIwMjAgYXQgMDI6MjE6NTJQTSArMDIwMCwgSmF2
aWVyIEdvbnrDoWxleiB3cm90ZToKPj4+Pj4gIGRyaXZlcnMvbnZtZS9ob3N0L3pucy5jIHwgNyAr
KysrKysrCj4+Pj4+ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspCj4+Pj4+Cj4+Pj4+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC96bnMuYyBiL2RyaXZlcnMvbnZtZS9ob3N0
L3pucy5jCj4+Pj4+IGluZGV4IDdkODM4MWZlNzY2NS4uZGU4MDY3ODhhMTg0IDEwMDY0NAo+Pj4+
PiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC96bnMuYwo+Pj4+PiArKysgYi9kcml2ZXJzL252bWUv
aG9zdC96bnMuYwo+Pj4+PiBAQCAtMjM0LDYgKzIzNCwxMyBAQCBzdGF0aWMgaW50IG52bWVfbnNf
cmVwb3J0X3pvbmVzKHN0cnVjdCBudm1lX25zICpucywgc2VjdG9yX3Qgc2VjdG9yLAo+Pj4+PiAg
CQlzZWN0b3IgKz0gbnMtPnpzemUgKiBuejsKPj4+Pj4gIAl9Cj4+Pj4+Cj4+Pj4+ICsJaWYgKG5y
X3pvbmVzIDwgMCAmJiB6b25lX2lkeCAhPSBucy0+bnJfem9uZXMpIHsKPj4+Pj4gKwkJZGV2X2Vy
cihucy0+Y3RybC0+ZGV2aWNlLCAiaW5jb25zaXN0ZW50IHpvbmUgY291bnQgJXUvJXVcbiIsCj4+
Pj4+ICsJCQkJem9uZV9pZHgsIG5zLT5ucl96b25lcyk7Cj4+Pj4+ICsJCXJldCA9IC1FSU5WQUw7
Cj4+Pj4+ICsJCWdvdG8gb3V0X2ZyZWU7Cj4+Pj4+ICsJfQo+Pj4+PiArCj4+Pj4+ICAJcmV0ID0g
em9uZV9pZHg7Cj4+Pj4KPj4+PiBucl96b25lcyBpcyB1bnNpZ25lZCwgc28gaXQncyBuZXZlciA8
IDAuCj4+Pj4KPj4+PiBUaGUgQVBJIHdlJ3JlIHByb3ZpZGluZyBkb2Vzbid0IHJlcXVpcmUgem9u
ZV9pZHggZXF1YWwgdGhlIG5hbWVzcGFjZSdzCj4+Pj4gbnJfem9uZXMgYXQgdGhlIGVuZCwgdGhv
dWdoLiBBIHN1YnNldCBvZiB0aGUgdG90YWwgbnVtYmVyIG9mIHpvbmVzIGNhbgo+Pj4+IGJlIHJl
cXVlc3RlZCBoZXJlLgo+Pj4+Cj4+Cj4+IEkgZGlkIHNlZSBucl96b25lcyBjb21pbmcgd2l0aCAt
MTsgZ3Vlc3MgaXQgaXMgbXkgY29tcGlsZXIuCj4KPlNlZSBpbmNsdWRlL2xpbnV4L2Jsa2Rldi5o
LiAtMSBpczoKPgo+I2RlZmluZSBCTEtfQUxMX1pPTkVTICAoKHVuc2lnbmVkIGludCktMSkKPgo+
V2hpY2ggaXMgZG9jdW1lbnRlZCBpbiBibG9jay9ibGstem9uZWQuYzoKPgo+LyoqCj4gKiBibGtk
ZXZfcmVwb3J0X3pvbmVzIC0gR2V0IHpvbmVzIGluZm9ybWF0aW9uCj4gKiBAYmRldjogICAgICAg
VGFyZ2V0IGJsb2NrIGRldmljZQo+ICogQHNlY3RvcjogICAgIFNlY3RvciBmcm9tIHdoaWNoIHRv
IHJlcG9ydCB6b25lcwo+ICogQG5yX3pvbmVzOiAgIE1heGltdW0gbnVtYmVyIG9mIHpvbmVzIHRv
IHJlcG9ydAo+ICogQGNiOiAgICAgICAgIENhbGxiYWNrIGZ1bmN0aW9uIGNhbGxlZCBmb3IgZWFj
aCByZXBvcnRlZCB6b25lCj4gKiBAZGF0YTogICAgICAgUHJpdmF0ZSBkYXRhIGZvciB0aGUgY2Fs
bGJhY2sKPiAqCj4gKiBEZXNjcmlwdGlvbjoKPiAqICAgIEdldCB6b25lIGluZm9ybWF0aW9uIHN0
YXJ0aW5nIGZyb20gdGhlIHpvbmUgY29udGFpbmluZyBAc2VjdG9yIGZvciBhdCBtb3N0Cj4gKiAg
ICBAbnJfem9uZXMsIGFuZCBjYWxsIEBjYiBmb3IgZWFjaCB6b25lIHJlcG9ydGVkIGJ5IHRoZSBk
ZXZpY2UuCj4gKiAgICBUbyByZXBvcnQgYWxsIHpvbmVzIGluIGEgZGV2aWNlIHN0YXJ0aW5nIGZy
b20gQHNlY3RvciwgdGhlIEJMS19BTExfWk9ORVMKPiAqICAgIGNvbnN0YW50IGNhbiBiZSBwYXNz
ZWQgdG8gQG5yX3pvbmVzLgo+ICogICAgUmV0dXJucyB0aGUgbnVtYmVyIG9mIHpvbmVzIHJlcG9y
dGVkIGJ5IHRoZSBkZXZpY2UsIG9yIGEgbmVnYXRpdmUgZXJybm8KPiAqICAgIHZhbHVlIGluIGNh
c2Ugb2YgZmFpbHVyZS4KPiAqCj4gKiAgICBOb3RlOiBUaGUgY2FsbGVyIG11c3QgdXNlIG1lbWFs
bG9jX25vWFhfc2F2ZS9yZXN0b3JlKCkgY2FsbHMgdG8gY29udHJvbAo+ICogICAgbWVtb3J5IGFs
bG9jYXRpb25zIGRvbmUgd2l0aGluIHRoaXMgZnVuY3Rpb24uCj4gKi8KPmludCBibGtkZXZfcmVw
b3J0X3pvbmVzKHN0cnVjdCBibG9ja19kZXZpY2UgKmJkZXYsIHNlY3Rvcl90IHNlY3RvciwKPiAg
ICAgICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGludCBucl96b25lcywgcmVwb3J0X3pvbmVz
X2NiIGNiLCB2b2lkICpkYXRhKQo+Cj4+Cj4+Pgo+Pj4gWWVzLCBhYnNvbHV0ZWx5LiB6b25lX2lk
eCBpcyBub3QgYW4gYWJzb2x1dGUgem9uZSBudW1iZXIuIEl0IGlzIHRoZSBpbmRleCBvZiB0aGUK
Pj4+IHJlcG9ydGVkIHpvbmUgZGVzY3JpcHRvciBpbiB0aGUgY3VycmVudCByZXBvcnQgcmFuZ2Ug
cmVxdWVzdGVkIGJ5IHRoZSB1c2VyLAo+Pj4gd2hpY2ggaXMgbm90IG5lY2Vzc2FyaWx5IGZvciB0
aGUgZW50aXJlIGRyaXZlIChpLmUuLCBwcm92aWRlZCBuciB6b25lcyBpcyBsZXNzCj4+PiB0aGFu
IHRoZSB0b3RhbCBudW1iZXIgb2Ygem9uZXMgb2YgdGhlIGRpc2sgYW5kL29yIHN0YXJ0IHNlY3Rv
ciBpcyA+IDApLiBTbwo+Pj4gem9uZV9pZHggaW5kaWNhdGVzIHRoZSBhY3R1YWwgbnVtYmVyIG9m
IHpvbmVzIHJlcG9ydGVkLCBpdCBpcyBub3QgdGhlIHRvdGFsCj4+Cj4+IEkgc2VlLiBBcyBJIGNh
biBzZWUsIHdoZW4gbnJfem9uZXMgY29tZXMgdW5kZWZpbmVkIEkgYmVsaWV2ZWQgd2UgY291bGQK
Pj4gYXNzdW1lIHRoYXQgem9uZV9pZHggaXMgYWJzb2x1dGUsIGJ1dCBJIGNhbiBiZSB3cm9uZy4K
Pgo+Tm8uIHpvbmVfaWR4IGlzICphbHdheXMqIHRoZSBpbmRleCBvZiB0aGUgem9uZSBpbiB0aGUg
Y3VycmVudCByZXBvcnQuIFdoYXRldmVyCj50aGF0IHJlcG9ydCBpcywgcmVnYXJkbGVzcyBvZiB0
aGUgcmVwb3J0IHN0YXJ0aW5nIHBvaW50IGFuZCBudW1iZXIgb2Ygem9uZXMKPnJlcXVlc3RlZC4g
RS5nLiBGb3IgYSBzaW5nbGUgem9uZSByZXBvcnQgKG5yX3pvbmVzID0gMSksIHlvdSB3aWxsIGFs
d2F5cyBzZWUKPnpvbmVfaWR4ID0gMC4gRm9yIGEgZnVsbCByZXBvcnQsIHpvbmVfaWR4IHdpbGwg
Y29ycmVzcG9uZCB0byB0aGUgem9uZSBudW1iZXIuCj5UaGlzIGlzIHVzZWQgZm9yIGV4YW1wbGUg
aW4gYmxrX3JldmFsaWRhdGVfZGlza196b25lcygpIHRvIGluaXRpYWxpemUgdGhlIHpvbmUKPmJp
dG1hcHMuCj4KPj4gRG9lcyBpdCBtYWtlIHNlbnNlIHRvIHN1cHBvcnQgdGhpcyBjaGVjayB3aXRo
IGFuIGFkZGl0aW9uYWwgY291bnRlciBhbmQKPj4gYSBleHBsaWNpdCBucl96b25lcyBpbml0aWFs
aXphdGlvbiB3aGVuIHVuZGVmaW5lZCBvciB5b3UKPj4gcHJlZmVyIHRvIGp1c3QgcmVtb3ZlIGl0
IGFzIE1hdGlhcyBzdWdnZXN0ZWQ/Cj4KPlRoZSBjaGVjayBpcyBub3QgbmVlZGVkIGF0IGFsbC4K
Pgo+SWYgdGhlIGRldmljZSBpcyBidWdneSBhbmQgcmVwb3J0cyBtb3JlIHpvbmVzIHRoYW4gdGhl
IGRldmljZSBjYXBhY2l0eSBvciBhbnkKPm90aGVyIGJ1Z3MsIHRoZSBkcml2ZXIgY2FuIGNhdGNo
IHRoYXQgd2hlbiBpdCBwcm9jZXNzZXMgdGhlIHJlcG9ydC4KPmJsa19yZXZhbGlkYXRlX2Rpc2tf
em9uZXMoKSBhbHNvIGhhcyBtYW55IGNoZWNrcy4KCkkgaGF2ZSBtYW5hZ2VkIHRvIGNyZWF0ZSBh
IFFFTVUgWk5TIGRldmljZSB0aGF0IGdhdmUgbWUgYSBoZWFkYWNoZSB3aXRoCmEgbGl0dGxlIGJp
dCBvZiBleHRyYSBjYXBhY2l0eSB0aGF0IHRyaWdnZXJlZCBhbiBhZGRpdGlvbmFsIHpvbmUgcmVw
b3J0LgpUaGlzIHdhcyB0aGUgbW90aXZhdGlvbiBmb3IgdGhlIHBhdGNoLgoKSSB3aWxsIGxvb2sg
YXQgdGhlIGNoZWNrcyB0byBjb3ZlciB0aGlzIGNhc2UgdG9vIHRoZW4uCgpUaGFua3MsCkphdmll
cgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgt
bnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
