Return-Path: <SRS0=XnCc=GP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F80C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 05:57:56 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0B1E222F9
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 05:57:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0B1E222F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=yM7gEVyiS7FS002sNicsE8t6KUXDD0VJyIpmi2K0uA8=; b=jWVorX6U7G9aDqh4SHQ+CYdhb
	tp+e9Yn9rqIPAaaRmDFkUMPoVSASpD46r5dFRpEsjDS7WDZiql1lsug+FrLvZ1PR/jkJn2ec3YNVd
	TaiYKfmtzc6LGJVnSPva829JJ6hO0bQBEc6QM3OoJRu6xsSSoa5lCPYhwixrByLj7x7hIM6wEbwl4
	0EAtsv2ApGPHZe88uz65VEvHnrn94h/Vqs7gIL/GQTb9cTnOHJ/On7ThC4g4CvjYvOHa9um/gOebI
	WM7OTFxCsUX7ZEUHLgGC/qO6+He58vo6fcmxbDZ3caD/sGY3wLvMZ2ErcA7Pk0+oSX4j0x2KR355s
	eT391YSCg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzCgb-0007XT-8H; Tue, 12 Jan 2021 05:57:45 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzCgY-0007WP-6a
 for linux-nvme@lists.infradead.org; Tue, 12 Jan 2021 05:57:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1610431061; x=1641967061;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=hbM3AjN7Es26AGdELvxyTSp87BMWF623toeJonijovA=;
 b=haJ9hdVFho2CiJ3dsNe8+o8Mpk+trDFR1kGRmuFgdoJPIJ7Pc6RpOmnz
 flrDJnnqtOwKrvK73AGhPQ/pNnVXimFJXk+W6FRE33LrztlnNjpU8RcNH
 yjj9FftEFyNgwtmii4l8ZeLxjZWt1mNmWn9goAmtE6ETphSlaHcVKOxEp
 ORMC5oi+0igDjRHyzoU8kB9yqBmhjsiBcBYAfL3XZPgJQ4zPtnX/plqXi
 YRKpk5AmxwkDPesXKM2lATWCAFBjIS/K1Pncny19QjNq+cxwKIPFWFjpk
 C5x9+jTVj1IiXVOU1sSeLRkXnPxGyvpIBb8yLfVwQzlRyp3hNiPQaa6kL g==;
IronPort-SDR: vX3C/+5sZ0DrB8V8fJDwffZj6xXyHx4CutElPurB2OX6NOxzODz6PuExAtN6cFWAlsi5OzpzDf
 4t1iAUUBesvmevPltMjMncts370PLIexW4jU8L0QADuwoasvgpP44gQLpuZEb4hu4P0KKs2PXi
 zBhvVILtb5nS1zqKBtLthhhdJWahcl7AiPE+X04Ap0ZGxeMyVRW+WMMXzNBwFuZ4a3xvebD9pP
 Ne9i1P8u3qf7FDgCXH6yaDnH+xd96Tqg3Sgedxy70RTE+ks50MvWNgfwkLbRv+Pj8469mvqPx/
 CrY=
X-IronPort-AV: E=Sophos;i="5.79,340,1602518400"; d="scan'208";a="267510132"
Received: from mail-bn7nam10lp2109.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.109])
 by ob1.hgst.iphmx.com with ESMTP; 12 Jan 2021 13:57:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gYWL/4OYgBGiclSghZPMzCUvmStVJWQJ55h3fBJ1VpXhhS+X32FLI+6Kv0M9zp9btOe+T2fRKFbEIRHS9FvrQLwyIxdtHMY4TnICJfuPaSpxo5Ew4sH4juL2prkiCsZtYB1cXS0LPaSJIqnoEur9Nvu/w27v8Y23ogc1QFZkONArs1+W3UvGzQ8/kHH7DtKltttA7lF8aD1imn/KZwgdaWgG46TkOtLoRW5CFO6lK/HyLhXpZatVdjCACpnXEi38jzVOoYvJl3HqTW7hNZQROTRrlj8zf9ZKVCP7jnrFn90qtWIYDhNHEepbxqEdMNLdAjUmOa8NHszdZYKJirUaXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eNoudw9NCr5HK6jmTKNKBroJMpKA+M95mUDptQrhoMI=;
 b=lB2ySwZvpAtDMheo/Y4Cl/Dk0EN9/ZY++kw1k011168/65XjQ5dsQg/YF5wqqn0qcly+8xp6a6tYHE7iyWzEzmND6U/K2cFdKsqHc8OB9A4eVfJLlL02J3/e+xHgNMq/kMtTWu0zmwuuetueJrZCh/TVSm/m26QYB9urIoHS7gn1Cfc9lElluZRsJDCkwdd4DqXfn2aFlonNtkPjPEFq3iS1zAgRv/Tg8LlYBC3QjpomMiQ8XcpieLqgK1qHr5MgLi5fu90WhipLUWlnufSUUyfJMCut00/Vmzs3Um4gT4FNQ8NvTP2Hyfd22tyoZ0xJxQ89ZiNzrBsrwaf1jDAezA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eNoudw9NCr5HK6jmTKNKBroJMpKA+M95mUDptQrhoMI=;
 b=g3uYpgjSNI3JJlfwkGRM13XPJt5UiVjyG7kPi7BjOHOgDeC++qMoQZiPHK7Xk70wqoW1Mpe/n15sCYRjJoIusI9RIS48Wikw60L+ZeeMQqQuLEK7xUsjo/hOxeQy9CdY4xKm6gzAjZ7X+tfMfgGLoIy0Lnnzc+SiSS3hQoerClU=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5254.namprd04.prod.outlook.com (2603:10b6:a03:c2::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Tue, 12 Jan
 2021 05:57:39 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a%6]) with mapi id 15.20.3742.012; Tue, 12 Jan 2021
 05:57:39 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Damien Le Moal <Damien.LeMoal@wdc.com>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH V9 6/9] nvmet: add bio init helper for different backends
Thread-Topic: [PATCH V9 6/9] nvmet: add bio init helper for different backends
Thread-Index: AQHW6Js+dLnOabsb902jm/8Qx/tj3g==
Date: Tue, 12 Jan 2021 05:57:38 +0000
Message-ID: <BYAPR04MB496575ACE95FA2E6EA31AC8286AA0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com>
 <20210112042623.6316-7-chaitanya.kulkarni@wdc.com>
 <BL0PR04MB6514DF0B740BE6F4AB3141AEE7AA0@BL0PR04MB6514.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b8c747ce-a44b-400f-44da-08d8b6bef7d1
x-ms-traffictypediagnostic: BYAPR04MB5254:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB525495BC6E75C7E707B4E13E86AA0@BYAPR04MB5254.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ru8hxywBiFYgcJZbk276ymWxFhv0lfj1iu929/HG3EmLL2RK2eCFo/AEQvT534Vah/jQDCeEZZu71TZm83Y3PB6tGN+J6NQY0oRmL2DrzYKHZeu2EtDxyMWvvDdJdYqVCKOZZ5cjmj1rPw8/zHhEbXG65OhWEizcowzfyJwFKKEskQIi9CHV6wAzYOrzJaOusBGhW5/u0DkSMRdh1Z2XkLQEPO2iBLLj4FbxqMluOI7IUWaRNHqsMZjyNUTgZxCWLuEAqT3aXUsdjTZavwfGE7lURqvBrI+ibL138jufXPJx/i/LJL0Nmk1lR9KpiRsHDofXLjjY8LYRFaJn8Na7WUjYQD62fht2OabxLgPHe5I78uerXZL2nbh8fVflmbcBHVScWRZ2x54uV/N20MxHsA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(396003)(136003)(346002)(39860400002)(55016002)(478600001)(64756008)(8676002)(2906002)(316002)(7696005)(71200400001)(26005)(110136005)(8936002)(4326008)(54906003)(52536014)(6506007)(9686003)(4744005)(76116006)(86362001)(33656002)(5660300002)(186003)(53546011)(66556008)(66476007)(66446008)(66946007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?DgtXvXvYgLDStskf/FO219DsU7PeOaUf/7NqEhMmEZY7Vjpf2atfzaf8mhgK?=
 =?us-ascii?Q?FHhC6W+TXs0CPQg0foJ8qqg5B4oFa3nnTwNEV29ocDNaRVnBqxw8+tyW4GEe?=
 =?us-ascii?Q?jK6FBuVGxa/OJuZ7eW8eIkNJ517xzmZBu6lcAUai3B9tx+iUz326j7IybI/i?=
 =?us-ascii?Q?TVi6tcW8GnHGMuCUf8qVXcXw2sDVoa/lnI1ioiaWeGI/PHx67dFPOaskNxa2?=
 =?us-ascii?Q?XxYfraa6IBAdzmMPHsbAQaeUkbOBZwCXinCyk5n6gF2VZDNvW2GUCj2mRspb?=
 =?us-ascii?Q?upU6KVwhHl2ScPKfGi1U/DvhUuR8aXZk4YI7zIQs4WH1U2Ra4xLUaK3YtqVR?=
 =?us-ascii?Q?FRFZnW6uvMrBol7THWed+T08/YSOBs6HpTAd8hnvZVqoImkTPMk1gOfMnNOL?=
 =?us-ascii?Q?sa/GmqAZ4riDlprdlxIuqqsuWT1qSMJg4/LleEfGDhn5epTGRP3yrxDPLUUq?=
 =?us-ascii?Q?z42Xi2KP3Mxr1tSa1/deQkrkV5kO+k7cTJPYRL2G/ZDvvhtV0/22aKpaE77k?=
 =?us-ascii?Q?1cM4DR3iG7dRF3g1aLn9JytSpYMW2HTDv5BHyDwszv9Ce+vZ47uMCArsTwaj?=
 =?us-ascii?Q?MPDF87XlWPkQnEuBSctClTDgk5FOoyywgIgvS3nKfoD7Smpdj3rLtYrlGlCv?=
 =?us-ascii?Q?6gJbElYTHIPS2cfkCRmtF64sJR91PbCMeV0miJwALwJIrhpfFGqNdk4ROfOl?=
 =?us-ascii?Q?XdHTkSV98YM73IeKyGtPQ0SrHk9oSogLsSLS7xLKgIPjniTpXKTGQs4vOUJF?=
 =?us-ascii?Q?FevTOMv97w5o16KiZFo/YP7qF45/5ukM0+gy5oua12ghPKoCuSu0F9Rwc+F0?=
 =?us-ascii?Q?uyOSgdSFx6R7ONNQURdseADVOsRT+5PfSQoUS9mXnktdrHnpfb8L39vCxbLi?=
 =?us-ascii?Q?dW7243Fh4vVmF11+Jo6VTJ/dg6fD4Qwa32y2ZwvixDSj4Hc9YVeI9K23S58d?=
 =?us-ascii?Q?B5YIwNaDFc/h7T9tOrWmatf0/dEO9iUevaZTFq26vGHpLLGOchmbNHzWfnrT?=
 =?us-ascii?Q?Xi1I?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8c747ce-a44b-400f-44da-08d8b6bef7d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2021 05:57:38.7130 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oq3jZrbXJUlhDqY6vlUx/AVQTG3E/SBJlSlKkmDSm6UfPXktrW8uxfj4GMk3J6JXc5pPdTfByIlntuNGDlxydB7sezjQodvHmLEFz+2gWA8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5254
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210112_005742_564238_BDFEE3DC 
X-CRM114-Status: UNSURE (   9.95  )
X-CRM114-Notice: Please train this message.
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
Cc: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 1/11/21 21:40, Damien Le Moal wrote:
>>  	bio = nvmet_req_bio_get(req, NULL);
>> -	bio_set_dev(bio, req->ns->bdev);
>> -	bio->bi_iter.bi_sector = sect;
>> -	bio->bi_opf = REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE;
>> +	nvmet_bio_init(bio, req->ns->bdev, op, sect, NULL, NULL);
> op is used only here I think. So is that variable really necessary ?
>
This is just my personal preference as without using op we will have to
add a new line to a function call, I like to keep the function call in
one line as much as I can.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
