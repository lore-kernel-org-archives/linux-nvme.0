Return-Path: <SRS0=w6YM=OR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 531EBC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 04:35:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A7F860FC2
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 04:35:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0A7F860FC2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=live.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yKkniMlHwpjhIEkf0kgQs9dIrN/kl1FWEnfKH39+PpA=; b=eNpqNZ2fgBk24N
	6LzVfugBHYtmGtgBkAJNjdsvmri5qOlA4mCzWyNuZFTxcM3n+ochReheJi07Wfgkk96I9ocXtkygL
	WNU8Y1pQIQRd0dZrCxVnwPc36zWXe5wLVazEpg9PO5RiU4PMkt3pVprW4QP+vxMs51SxT4O1fFmKR
	00vBmCdCrM7SulfYCabAfxW5l2WaQ8735XdMR7jxnhvussFK1LeHL5GVAb8VBE8/aYsYC3it8vGnp
	JPxUUHjzaMDwXg2lOiBo7RcJOeyKpVAM8zUaNgEGCKJD0zKPT7ed1pz5lcQ3VMx7Or+fOUvbDumiF
	Zcqeuy8dL2HDXdSQJ/fQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mUiM8-001YC1-LX; Mon, 27 Sep 2021 04:35:08 +0000
Received: from mail-bo1ind01olkn0140.outbound.protection.outlook.com
 ([104.47.101.140] helo=IND01-BO1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mUiM6-001YBh-9D
 for linux-nvme@lists.infradead.org; Mon, 27 Sep 2021 04:35:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y8Di9W0xBxvI9McZalCER9k1Sg13jg9DKjTeVQzytC3uYgnRKrfn/VC4yENbGGx2g2hqscnDXYj/VYs5PFcfu3J6zMaij4aK5vHTOxtp+SGke/om3/EGRPNnxeUCNquyVw4FPAmIr7gTRGeJ+p6sLj/RXRHzgKwAOw4zbu7U0eFyrHoJMupxCf3UMTDOQXcQ0BUtItJfPS4Qp9jJAJjILngpZFqGUwmke4zHfry/D0pqQ1vwflEJ16I6jXTaK9iMiOCbRQIKLPjRYMnMUYalQBer6tvhvLTMRBCOKM0uEyB1SVf0QvUhYYZuIeyVafD1QTFipyPax6uoic+FvS+rhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=bAKJC6a92cWdq8FYAVwVo65rlc+wOVEDxnuq0cbMUzg=;
 b=KTr60UXnIOrtAFyFTDto9uHQKSTomBtPCFWf2FqbdvtSuil/33CVizIB+Qe+iC4GkU6t8cOo5oWYNzrre4/W+9rGs66V175UuHSdtLAncbqAj+2o3TUOKc7TtLtVUzHVtzscfNxWV4FZc2fEvw2qG5JPaqpyvT71D+A79di9V/BzrMmB2n4EGe+DUfDNgfMeM8r1OcGlt06L2ljQ4OmmKT+inN/9Kov1eoGJK0I8jT066Id3CoBUcn781TNu3DpAwm/YlSIpVFrkaXqon2CqQgN+IcQmd3F7c2sqSDmvuHPXw8iwmbsDo4THRQtuGcq2Jb/J/8jaO90Tsc0VWC1mOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bAKJC6a92cWdq8FYAVwVo65rlc+wOVEDxnuq0cbMUzg=;
 b=QQH3k30zkJ91fiBr+nKleBJIZ65Du0ElS/9P4pPlR876BWZEZjPnIJOBoH87vArmbO3R3FgLOW2KvFI+qOAFCg5dtgTAzrE8BgkfIjzUq7/SCPkge3rtpfiOxYL9PaGZxCN8xB7ssdKiboY52YRYeczK/5rW6dxOniL4fbPIKQ9Tng/DmLimDeXtn5NHbnLT+kuXdKI4IEQUE4hGijWWAdBVy7Qk5GpxtmiYnxMhhQyFym7sQMJALl4Nx2+feGJqPedKONdnBw3ZGnFAZciawXEfZVk4WOYd/vYk1Lc0XNNbAYQg6Wsxu8lt6zbz4nAM5t9f71+m1fO2eZ4n7K4p5A==
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1b::13)
 by PNZPR01MB5197.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:3a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Mon, 27 Sep
 2021 04:35:00 +0000
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::fc30:dd98:6807:9ea]) by PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::fc30:dd98:6807:9ea%3]) with mapi id 15.20.4544.021; Mon, 27 Sep 2021
 04:35:00 +0000
From: Aditya Garg <gargaditya08@live.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Urgent bug fix causing Apple SSDs to not work.
Thread-Topic: [PATCH] Urgent bug fix causing Apple SSDs to not work.
Thread-Index: AQHXscFVd2R2aGQVnEGbLlhqpJsHVKu1F/kAgAASzICAAAs0gIAAkgX1gAAtJVaAAAzqAIABTFoD
Date: Mon, 27 Sep 2021 04:35:00 +0000
Message-ID: <PNZPR01MB4415FE077EAA0C094A8EE6DAB8A79@PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM>
References: <PNZPR01MB4415600ACD3C8D9944F15058B8A59@PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM>
 <CAHk-=wgML11x9afCvmg9yhVm9wi5mvnjBvmX+i7OfMA0Vd4FWA@mail.gmail.com>
 <20210925195425.GB116968@dhcp-10-100-145-180.wdc.com>
 <7e75e292-3073-f1f9-287a-badf92c8e4e8@grimberg.me>
 <PNZPR01MB4415F5304CAA1A83442549DBB8A69@PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM>
 <PNZPR01MB4415986CC44AACC100AD1189B8A69@PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM>
 <4dae80c3-034c-617b-c766-1858d6ee1220@protonmail.com>
In-Reply-To: <4dae80c3-034c-617b-c766-1858d6ee1220@protonmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: a8fcd596-a001-7bba-5080-2901fe6cd60a
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [qRa2i8BM1YvaLAWtVn5nrYrRLdGgG9v3k84wa1OwM4Snu4ZzVR/J+oOonpPKPyOn]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d02ea87e-d08f-492c-62f1-08d981702aa3
x-ms-traffictypediagnostic: PNZPR01MB5197:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m0/uq2NS81jT1pvJdKpq1VSZ48RLTpJIwx8Bf8gIrr4wSyiPhRkigFe6EC0G3GTjvGMUZAoh1z8xbSKh9NTIkFaVz/Xjy/Qjk+ki2Hzgm2zl1BPe1/ySacRDaTIPrSBqY0RpdSIkOrqpQgPSf7hvD7dUR3at6JtdNoUvR81rsIYt2kYiliAPMAbODJ5APpnpyhzo4YoepyqxMj2ILQzS1f+6m3svRTGpyFo3y5SmCxfuZD5Tqgg6Kd0QrR3KeISjq3UBJ8iQvmq5OGyRIEIEE23f76jBzHSEehL0tGa/LI3LJqOsnrCKeOphIEfCCyVMFdlpfzd7LL/b3c2wn4HWKlDvYpuY1WMIoHYhbDEMdYLvzZj5l6uL447bsajkompqnTl68aO9C2onZLkvgRfL6lNGyDARdG6T+U+UYhmd7ccnoSc8/0XCn015p25ao1N4ivIGFaxnPPXlNU+qzSzKPu4Vg+ZBREfA9NPQ7kXfdNs=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: wC/iNhaAXYtt7F4HiBo28zWAG1arno4MiZf7GZqj59EOWetqiLh7fwH/YJgU71j4to7AXetkwlksiQ9UVK1TDtQSdHWPLgbEox/+q1RPpAmzYvsISEuevjwHJ64avt61/zGGbykpvgrh7BHusgDOirpUJzrQD7TDhO/4bXbUmSuuqo5f+/7YSj47YyUW8Kk7Q3XOG7p/e+vVJGO1ZsIaXg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-3174-20-msonline-outlook-a1a1a.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: d02ea87e-d08f-492c-62f1-08d981702aa3
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2021 04:35:00.0878 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNZPR01MB5197
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210926_213506_368614_3889A2DC 
X-CRM114-Status: GOOD (  13.65  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

I tried Orlando Chamberlain's patch on 5.14.7 but still the SSD is not being recognised.

________________________________________
From: Orlando Chamberlain <redecorating@protonmail.com>
Sent: Sunday, September 26, 2021 8:44 AM
To: Aditya Garg; sagi@grimberg.me; kbusch@kernel.org
Cc: torvalds@linux-foundation.org; axboe@fb.com; hch@lst.de; linux-nvme@lists.infradead.org; james.smart@broadcom.com; chaitanya.kulkarni@wdc.com; akpm@linux-foundation.org; linux-kernel@vger.kernel.org; trivial@kernel.org
Subject: Re: [PATCH] Urgent bug fix causing Apple SSDs to not work.

On 26/9/21 18:07, Aditya Garg wrote:
> I checked out the proposal sent by Orlando Chamberlain to replace
> NVME_QUIRK_SHARED_TAGS , by NVME_QUIRK_SHARED_TAGS | given in the patch on
> http://lists.infradead.org/pipermail/linux-nvme/2021-September/027665.html
> <http://lists.infradead.org/pipermail/linux-nvme/2021-September/027665.html>.
> The , still causes panics to the T2 as described before. In the case of |, the
> kernel boots correctly without panicking the T2, but in case we are having Linux
> on an External Drive, which is my case, then the internal SSD doesn't seem to be
> recognised at all. I've tested the patch on 5.14.7. A screenshot of the GNOME
> Disks utility has been attached along with this mail.

I had some issues with the patch not applying automatically as I mixed up tabs and spaces,
(due to me copying stuff directly out of vim), so I had issues with getting patches to apply
automatically. I've checked that this file https://github.com/Redecorating/mbp-16.1-linux-wifi/blob/anbox-bt/1001-apple-t2-disable-nvme-gen-counter-quirk.patch
applies correctly for me (and github ci), so can you see if it still doesn't work with that?


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
