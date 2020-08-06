Return-Path: <SRS0=CEZP=BQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3515C433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 19:55:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A70F221E2
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 19:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pBIv0VG/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="ChDLCkXV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A70F221E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=OvHKLxXwOzLFMxgQBzjGC0Y1iwItdXPCAGe1RCc6N08=; b=pBIv0VG/5i//KDUKwzfIDW3UF
	55qzguE5iflMnkiXbGIA6J0D4I0rFbgbH5g4/HgaSeTtMBnvR782S9QVc96PW8lY07BlAfiPWGt0z
	oZNj/Ohcnm7mJy6Lbg3fLzubM7KlrCtwEGAxQTWPEMMU6kXgjpuH9VqVRtPdyRl73PY2NbEyQtFLm
	azs5VD8+hlFFzz3s94Aqkfdz61YRup8VO2p9HkDigbhpOxWIUUZNNpoTyHgZTDjPwAdQmjJtpUaA5
	8vv4tsfDEkIC5Oa07RdlLz3jq7vdzei1Wa+4QumkPYUbp7DUQl/rdwmDjZU1yqy/SW0+3uhGkn3eq
	VCWy4C2Uw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3lz0-00027n-Ji; Thu, 06 Aug 2020 19:55:22 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3lyy-00026t-JZ
 for linux-nvme@lists.infradead.org; Thu, 06 Aug 2020 19:55:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=15Uy1b4DzriDz1N2cPi8DnbqZff77ICti2OotyLNQWc=; b=ChDLCkXV2yfYgT7vA1Dy6EFdA8
 L3Gq+3XAbpeh/4HQQtf4hF1Y3D8TTIqLG8jbd5NoA3UobZR5H7+LgE2hZsmLYoJFy6PQV+NMr6znm
 hPPFDGBdufX2wDSbUcn5CN5KORYcKbkwVB40sQSe9H/Vg50ynCnCeMTs6EfjbaCkvFZHkA3a5W1lt
 6t5UhZqv7+ftsFi0FKcZweTk/g+xiMEvkDvmo4Qzcf5kggj8ABL93/ZCF4zWEZ41CfldF9L9DA5cd
 dydu8pu0xJZ+yNXYG6nif7oS6naoIhSiAqOaAU6J8lQ7RstVdm1vfpj0d/YJP82Ig4/CcF55UFaXY
 bo3o78Dg==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4]
 helo=[192.168.0.10])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1k3lyw-0001TT-GG; Thu, 06 Aug 2020 13:55:19 -0600
To: Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Keith Busch <kbusch@kernel.org>
References: <20200806073151.56061-1-chaitanya.kulkarni@wdc.com>
 <20200806073151.56061-2-chaitanya.kulkarni@wdc.com>
 <20200806154247.GB3075319@dhcp-10-100-145-180.wdl.wdc.com>
 <1f6a1c73-fd0e-d05d-3254-03d0592ac998@deltatee.com>
 <20200806162602.GD3075319@dhcp-10-100-145-180.wdl.wdc.com>
 <BYAPR04MB49654162034AA3CBA2F4E49B86480@BYAPR04MB4965.namprd04.prod.outlook.com>
 <5dd8cdbf-8864-ecd4-928e-daa74a9cd166@deltatee.com>
 <f6944200-35cb-e38a-b799-92bb4036698e@grimberg.me>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <dfe9e93f-ceff-d666-c857-a0b7979e0673@deltatee.com>
Date: Thu, 6 Aug 2020 13:55:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <f6944200-35cb-e38a-b799-92bb4036698e@grimberg.me>
Content-Language: en-US
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: hch@lst.de, linux-nvme@lists.infradead.org,
 kbusch@kernel.org, Chaitanya.Kulkarni@wdc.com, sagi@grimberg.me
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 1/2] nvmet: fix oops in nvmet_execute_passthru_cmd()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200806_155520_685494_572C26E1 
X-CRM114-Status: GOOD (  15.78  )
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
Cc: "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiAyMDIwLTA4LTA2IDE6NTQgcC5tLiwgU2FnaSBHcmltYmVyZyB3cm90ZToKPiAKPj4+IFRo
aXMgYWRkcyBhbiBleHRyYSBsYWJlbC4gQWxzbyBJIGRvbid0IHVuZGVyc3RhbmQgd2h5IHdlIHNo
b3VsZCBjaGFuZ2UKPj4+IHRoZSBvcmRlciBvZiBudm1ldF9yZXFfY29tcGxldGUoKSBhbmQgYmxr
X3B1dF9yZXF1ZXN0KCkgaW4KPj4+IG52bWV0X3Bhc3N0aHJ1X2V4ZWN1dGVfY21kKCkgYW5kIG1h
a2UgaXMgaW5jb25zaXN0ZW50IHdpdGggaW4KPj4+IG52bWV0X3Bhc3N0aHJ1X3JlcV9kb25lKCkg
Pwo+Pgo+PiBJIGRvbid0IGtub3cgd2h5IGFuIGV4dHJhIGxhYmVsIGlzIGFuIGlzc3VlIGFuZCBJ
IGRvbid0IHRoaW5rIHRoZQo+PiBpbmNvbnNpc3RlbmN5IGlzIGltcG9ydGFudC4gVGhpcyBmb2xs
b3dzIHRoZSBjb21tb24gcGF0dGVybiB3aGVyZSB0aGluZ3MKPj4gYXJlIGNsZWFuZWQgdXAgaW4g
dGhlIHJldmVyc2Ugb3JkZXIgb2YgdGhlaXIgY3JlYXRpb24gYW5kIGxhYmVscyBhcmUKPj4gdXNl
ZCB0byBjb250cm9sIHdoaWNoIGNsZWFudXBzIGhhcHBlbiBiYXNlZCBvbiBob3cgZmFyIGl0IGdv
dDoKPj4KPj4gcmMgPSBzZXR1cDEoKTsKPj4gaWYgKHJjKQo+PiDCoMKgwqDCoMKgIHJldHVybiAt
MTsKPj4KPj4gcmMgPSBzZXR1cDIoKTsKPj4gaWYgKHJjKQo+PiDCoMKgwqAgZ290byBvdXRfdGVh
cmRvd24xOwo+Pgo+Pgo+PiByYyA9IHNldHVwMygpOwo+PiBpZiAocmMpCj4+IMKgwqDCoCBnb3Rv
IHRlYXJkb3duMjsKPj4KPj4gcmV0dXJuOwo+Pgo+PiBvdXRfdGVyYWRvd24yOgo+PiDCoMKgwqDC
oCB0ZWFyZG93bjIoKTsKPj4gb3V0X3RlYXJkb3duMToKPj4gwqDCoMKgwqAgdGVhcmRvd24xKCk7
Cj4+IMKgwqDCoMKgIHJldHVybiAtMTsKPj4KPiAKPiBDYW4gd2UgYWxzbyBhZGQgYSBsYWJlbCB0
byByZW1vdmUgdGhlIGlmIChucykgY29uZGl0aW9uPwoKTm8sIGJlY2F1c2UgdGhlIG5zIGlzIG9u
bHkgY29uZGl0aW9uYWxseSBhbGxvY2F0ZWQgaWYgdGhlIHF1ZXVlLWlkIGlzCm5vbi16ZXJvLgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZt
ZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0
cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
