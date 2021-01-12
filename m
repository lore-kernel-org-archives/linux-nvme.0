Return-Path: <SRS0=XnCc=GP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615EFC433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 05:55:44 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 066CF222F9
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 05:55:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 066CF222F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=TjmZOst/vK1OPVEyLNE1o0NaN/XtiLQWCE7JXLfzCtg=; b=1rTMpQDY+Vqe1/dHEVv3V/eMP
	0RRa3c0OYosJDnHSItk54Zf0aL+NATrS0+dDIAg+oCBzpIVi3RMp4SKaANcPTdexJVytGq125RehP
	fIwRjr4Ym9eJj7K1G1BQ24bd9hSeMeiS2uvli+suYgXiznpQi1x/V83ZQgCjJAKmjDZIYkTmzjFKv
	ciJCuX0Xqgq1TYgmBMDKwTnXMXRKnyEtTJFWMLfQBmmjIjT/IzMg+TmtH4EhznDwa1+YbiG2ShKxL
	Qe+nM1g4eqKqSDVd7mJHA29uYRdREJHufC3NGdNEnwClEDT1OUnpYlDBbbH2NoY18GDeQJQHmnorZ
	nYQ83aPlw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzCeW-00071u-75; Tue, 12 Jan 2021 05:55:36 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzCeU-00070x-IG
 for linux-nvme@lists.infradead.org; Tue, 12 Jan 2021 05:55:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1610430935; x=1641966935;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=fEAaIpcgu+8j+G12fyP1vXwIu+OfwFIykKRBYqPJXWQ=;
 b=TZlSRLQnTUcl9uDVTO/PY/JiRAM5MpT0dLdOCny1Oo3aOxNPKllv+BD5
 jb6dslxR7IlaMaDDHjCdJkFfoF+WShCZvG2OufPYjOLSq3VXEBftfH1LR
 6FClXvvCkA5T1+Rm34kt+ckE7P1//5ukPCg2ZALWN79zhx5b1Wx8+dznt
 yYa+j9r9GR+rhikSD5PMUmsNPoGC/hbxBB+CW+d5U6BNL2jjrbfVN36hp
 NbJShaoubKjbA5PV0usXJw4szLZXsYeBT1sBGJgyUz0t2ZDL+Fvy9yyKg
 NkxTI/eF6KLWKyVBjSx9ng87dukfkUbobPADUcnTO1M0PWH29biJSFh1u w==;
IronPort-SDR: wo0x3/CzYMf66vPPRMLJuzOVqGzJc1ag+bHIFPrmOLJ/jzxnAREZNNSYyCND8Aqmg/CSdzbNCD
 BZNxogxCf3FOt6YooBGvyJ57fhs/ciGhkk8yxNxnM4GQxAC0BvrVfP9QpA4t8b4IPPyngRNXaw
 q1J0f0uWEIkv3w4SLLEgi/m9wSNakJyTEZSm3A477Ttq+lw0SilsWKWXS3UegQDMIBS+BI5G43
 MAOeLOlxfu2RQvySSfbf7T9Ok5RvFNqUp3scvJJOWRXmhY3reNqH+QaQzYSPkUhMT3APFyYkaf
 zfg=
X-IronPort-AV: E=Sophos;i="5.79,340,1602518400"; d="scan'208";a="158385494"
Received: from mail-bn8nam08lp2041.outbound.protection.outlook.com (HELO
 NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.41])
 by ob1.hgst.iphmx.com with ESMTP; 12 Jan 2021 13:55:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HskRea+EV0gRhPX0egNLRW0w3nIgL3ceYajosBl6bl2DRlNG43eauHGqhBSjGJT0UAgkPrQsoq3rUX8gttcrnzbigGSNtJRod2Qj9Pd/tYVREheMkdJP6ukBfE8vQlR3i5v384YW6putvYQMpUEBXbVBZ6hA3qiL8R1eGSp+K79CTNmfuwNeFkQ9LJFvIVc8Xd8n3xS29Pxcif6ltBRyY8dcqge98rSVMmhPK72agmiJUayJljD70KP+ORlV7Yn2UBGOE4M2UnEBELWdW8Tuv/dS2U4ec+4YCgONLYrEKGtFxcHbc1aOESp+amGDJmcSjyCEoLnS7tkfnjxD67mVKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MDhVzD0Fg9WhnPfFJS4vgFlOE58JRQwGllgVIQnL4Ao=;
 b=FY6j1i9x0qKxXxetqv1ulGfo9pv2936rQt8GR8Jkb69i3WrzmVxkIkrutXeMO2fpH3FA6T8yIwsnnrVV6/wb2KBg4I/VS+u5X5zah3fLHZI/5zL6PHVL26/CKknU7Kuy80ZG3Y2UBIdton2GgC7BewrlPmVyuh/3zdXkxy0TMIVICK8Jon6+H26ZJrYCt5Q9T9YNkzZYvmMcZU+A7LMF0HdHa550Tn7wtflPUiCJQsPR45hwP9AXQ1dOLpWFSDZs0f++4ru4tU4/mQnC7rUvCaBHnMkLFrds6KfR0sin2BH+8BP8b3TK2K2Maj6BDZs3tMQvZgUrbTJD1NFhcg1UZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MDhVzD0Fg9WhnPfFJS4vgFlOE58JRQwGllgVIQnL4Ao=;
 b=KpVYRpyYWRwTiKhnsz9CFu1B58b/tOGllG0QRpyNMyvO4msK7ELBYvbKvjjQNUlr72C6AuJdPEwdDyxEayX7c+5OVNjm4VWyh9GW5S+2gTOxiazm1mM8MB5yZa+t7gIDxgMpyZMNQE6PvyqwXkZB/1XP3UidStV/ypcI7ER075Q=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5254.namprd04.prod.outlook.com (2603:10b6:a03:c2::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Tue, 12 Jan
 2021 05:55:29 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a%6]) with mapi id 15.20.3742.012; Tue, 12 Jan 2021
 05:55:29 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Damien Le Moal <Damien.LeMoal@wdc.com>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH V9 5/9] nvmet: add bio get helper for different backends
Thread-Topic: [PATCH V9 5/9] nvmet: add bio get helper for different backends
Thread-Index: AQHW6Js5srDvdWB7Nk6D2IdsRVTi3A==
Date: Tue, 12 Jan 2021 05:55:29 +0000
Message-ID: <BYAPR04MB49656232D23482CAE1948FAE86AA0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com>
 <20210112042623.6316-6-chaitanya.kulkarni@wdc.com>
 <BL0PR04MB651444A9A810E0DA8D958431E7AA0@BL0PR04MB6514.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c191e37e-9b6f-4db2-93ec-08d8b6beaac2
x-ms-traffictypediagnostic: BYAPR04MB5254:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB52547F0FDA7CA75DEFD8068086AA0@BYAPR04MB5254.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oCBpQ7E/eFRJ9Xcny4QO+4/ohoo3uAKLB44BFrb1qbm8CERMp4i+e8UaG5mo5fGrp/XQXEKhV+S1z9l20sFHh0dIQSspVxSkY+BMLuMg8j+2xDTYZ5CTaSgU0aKF6E1pIA382H5oOHlMq3Ls6a2/Ep3gGj+i38h66aiIDuc9oynjc25qNohdyMKpAxCgQAQ07W6PtHs16wToGrBENEPDcQYwc2LihOJlMhfFPP9JxeD/oHbv74tv2Pwu352ymoMXGphpzImtTADVUTr+OhJvF1p/gbwdI2MuWBjBeBwuOwSzAP6Mw+CbclapMhzHXTeJ+JbAE0zFblGY8MSEDLCFXixKtGY1uPMopxU6sG1bZsjPtrjlAxkc1nhWsU0fuoJOMw6vjskl6koLKSE0eS97SQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(396003)(136003)(346002)(39860400002)(55016002)(478600001)(64756008)(8676002)(2906002)(316002)(7696005)(71200400001)(26005)(110136005)(8936002)(4326008)(54906003)(52536014)(6506007)(9686003)(76116006)(86362001)(33656002)(5660300002)(186003)(53546011)(66556008)(66476007)(66446008)(83380400001)(66946007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?mT8wyxV48CtYArycH0Bmf5R6KzCzSvbsX3N9scW4Mvtp8sMlRZNP/gdK42nj?=
 =?us-ascii?Q?f3ChMmiTgkmxTDICCk/PakBp2XVLmgoQtsUFfCt6VDzU+w9T5YkIfEyn1d/j?=
 =?us-ascii?Q?qc+bSdopmYytbhHSJybyd8QhS4OeUpB7hGpfcuNZhZSZokVisoQAXmCT/USr?=
 =?us-ascii?Q?34OAne4DUfod/v5sFgxsAgEJ4owmuJZ5QBKcLgmUglywNPApRgHiox5HdQXF?=
 =?us-ascii?Q?ykDpXD+9yzAvrD3TTN1atteUPN8AfnrIguPfQxmGXJRDJcrJLr28DUZeI+rj?=
 =?us-ascii?Q?jYnqiT7Gg6fvdv0Vfj7sLb3qRm4UQZLbhlIwOWgRujkI/EJXVoV8ZEqKbyYp?=
 =?us-ascii?Q?q4fbURpoxJQJP3LBoTCbUxVC+zp4E7z9TZ5qcgQvnvhGnndnxFPYqtY+khKd?=
 =?us-ascii?Q?QjtfoVTLHKJIQtTwak1tRyXo2Fc1/jp1SI4rLaPmR2LEMn4lqPY2+GW7g0JE?=
 =?us-ascii?Q?sBO3r+XzkyaHCUUzEXnQrOWHWS44ZIlZqpoqs0icF3xjLmpCmuSn9o1vEDZn?=
 =?us-ascii?Q?XR6HorVJq19UCMsBYHTzLcGT1JPo5cf9EbZzV80KAehJHyhHkBM6kxfvAnnZ?=
 =?us-ascii?Q?bzaQB0WYe1p1nFoUVZqjxR7+lSfDX1eUJ+dwhYWUJ1yK/qj+BtQa8CvIFSlP?=
 =?us-ascii?Q?zvwCuZR34Gx0MIzdYpOmBFWHViUK24QfXHMWIlHQT29hbQBc5HUmYc09Mdgr?=
 =?us-ascii?Q?jWbI62uKVAY/HjYOqak0qtTZSyA3iC9y5lmEMNj9QlFWKaV2WVBKq10DQV2V?=
 =?us-ascii?Q?LFgLizrGgVauMOmIoSiXuaA+BUcVKF3LLGEDJuj83ElGnEotclwjJ2tHF9do?=
 =?us-ascii?Q?ABpaNAh9ewHASukA4kXBuq0UjpFYfY3T/KFFyC4dUjDM1j8OnkDoszhg2sCk?=
 =?us-ascii?Q?7BK+PZSazXwTFOaZTx2+LP3WYrudRIaYqki9zDBQ2vpaBinuvLrE4X17i/EP?=
 =?us-ascii?Q?xUWW6uiHK/0K4s/cUicWGOWeZQOCCBp8Z03MTbR1U0MTjid/JB5mc3Igxqd8?=
 =?us-ascii?Q?YcQG?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c191e37e-9b6f-4db2-93ec-08d8b6beaac2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2021 05:55:29.6652 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +R050MdhQWOO9XI+07EfU331+XAUnn2eq5NVXQcV8+Wc8UOQjFDL9BzAR2ndW53BpwXygUFBSQ3rfkdmPZd+VXzM/KsqGPUh/et8oW/PT5M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5254
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210112_005534_833870_783CAA90 
X-CRM114-Status: GOOD (  15.38  )
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

On 1/11/21 21:37, Damien Le Moal wrote:
>> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
>> index 7361665585a2..3fc84f79cce1 100644
>> --- a/drivers/nvme/target/nvmet.h
>> +++ b/drivers/nvme/target/nvmet.h
>> @@ -652,4 +652,20 @@ nvmet_bdev_execute_zone_append(struct nvmet_req *req)
>>  }
>>  #endif /* CONFIG_BLK_DEV_ZONED */
>>  
>> +static inline struct bio *nvmet_req_bio_get(struct nvmet_req *req,
>> +					    bio_end_io_t *bi_end_io)
>> +{
>> +	struct bio *bio;
>> +
>> +	if (req->transfer_len <= NVMET_MAX_INLINE_DATA_LEN) {
>> +		bio = &req->b.inline_bio;
>> +		bio_init(bio, req->inline_bvec, ARRAY_SIZE(req->inline_bvec));
>> +		return bio;
>> +	}
>> +
>> +	bio = bio_alloc(GFP_KERNEL, req->sg_cnt);
> I have a doubt about the use of GFP_KERNEL here... Shouldn't these be GFP_NOIO ?
> The code was like this so it is may be OK, but without GFP_NOIO, is forward
> progress guaranteed ? No recursion possible ?
>
I've kept the original behavior, let check if this needs to be
GFP_KERNEL or not,
if so I'll send a separate patch with a proper message.

Thanks for pointing this out.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
