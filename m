Return-Path: <SRS0=QQ4x=HE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B02C433DB
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Feb 2021 00:12:44 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6061964DDC
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Feb 2021 00:12:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6061964DDC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=85P6B9YBZ9ButHQen2cXeFhd1D+sC9Lu1n4wNdIislY=; b=u62hkI21zFKmOwuJegCjgCZIa
	sdeVUwZTjaMdFhWNsS4xikXHdfXoCFOrsnCqd/lxOT/ZexN1soPniDnN0k/PxNpBCpFFB2B+VacO6
	vJz1O5ah/rm/hCPR1PFbmAx2xJNONrD8EIw+eBU2onGjdV20UxzXdSO3kT/qH5L2GnvvzCGEMRf+t
	GravAY2wKkXuNwwK7Mu/S8aHYrNXXSigD66jtsAbJCBwtSol29GCgTbgT7vDyUaQE9hKyQC3txV1F
	U35ZAwI8hnNQy+wESC7Iwoorl7yTh+GswaJ+XaDZeRBnm5fyHxndy56baiV2vhH9P9lrjRFl67omA
	0oz71NJ2w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6jJB-0005Te-C2; Tue, 02 Feb 2021 00:12:41 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6jJ8-0005T2-64
 for linux-nvme@lists.infradead.org; Tue, 02 Feb 2021 00:12:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1612224758; x=1643760758;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=vbX1dCZIA8Z8PF3X6ubtBy3E9NVc//j2j//CQULG2ww=;
 b=A4DPADb0hJBgjusWZ42qJ3xNV0ShHAIOpbuv8oZTdnn4t3jhDFCfNk9t
 9D5a4Cm4ZAPoA486ckNEBks5k/0/PwIw0GtE+XMog/RmCwLeD2W1AUt11
 X2hlwu+qy2J430916lhIrrRRsMR6wDMYKaBnifOt99E39zcp00TE+Rr6G
 pZg4fdFK9v8cf7ensa1aOVHsTiyGGgv1u5qSKMmBQxQEtxXSZ7kea2svz
 s3/hps9HrKJ4WcypfMXNNjqMtc6pQl1HNmL1HF8/k24I/eUjEbcrzDh0h
 p6zF2HYGMYISvSt+2lmC9Zk7yRgoDoOIa2kWnroBumZpFRAeMd0E4eU47 w==;
IronPort-SDR: vFBGEH/GZKBp+ej9lql9vHeGjpjfyXP8UJOy4+gZ4+IrBxLNIDOjJr52c8v31JFDVWQXCBLHfF
 ED4tm7SHuOpwfqVucRRc4Q8pBCzdGZzY0sa3yyHECSNmlpkJNnAC/gnzjndqcFcPr/GjqyC0RN
 CkdfaeRCg5LJyq1aPtMuQm8t6x78/NdtnYZ6KWoEaeQcrHID1SYTRa42uGDyaWseTOg6FA/XEH
 klhyVXV2RPqBqFBGu3D2D3UBBVbDgkcNGHNKKH4sDbxPQjQQbuyd2aalc7amCHboqlezTLZ9hw
 uqk=
X-IronPort-AV: E=Sophos;i="5.79,393,1602518400"; d="scan'208";a="163311676"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
 by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2021 08:12:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kJDyhjkYpqMHyEtleURjsupTH4YJuUGZyKGb5ZblY+os74TSokFkoqt3yKe3mGkE5e5jKR/Lu8D4W63sFWaD8S7RDAC3w4KodQkHfgmJYioR5oGbKAAtYmcaO4bSddKSYc7wWYi8KQ3oTjpEgQ59l/DzNfm3eGQUuynH56p7IGNi21Xk4bzrvVmUyNCHxIT3kjgrI+RqIz5ySXDWzCe/nsX+QuIKtjxsAnXHUhJffFDeMSV5dfDqT7OK6kwtFGb0joJKKCgTLSJQZNOrIX56QCaxNy4B5wKi4w3DKy5Bq4DIJyKNyZi5NwZ0msxtf5JRBYvqtRzvtIdTlk46c22LHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tTPsDppLrnrWWffryedgSfLyfn7XxrasKt6dFfxSynk=;
 b=gP2H1woJ/i4WQAaxWebqQW9GmI0TUg7/M9VaAA6151xpfPjVXgH5/Shz7Td0v3RtvaVgDswrc60ewsucd6EcJo966Do2lkAkRrt2PMciUdUrz/LC4raPVssy2zgO9Mnmhr66F991bhOs/ym0nNWfN1t5WtzxSfA48kr7Zgt5ahJfyEJDaggdIwd0wew91uxLCKTlMaRjfHHRZb6/L0rkB9hpG08MtGfarTfhFhmamySEHK3aUN0cZ7A6vKNVTf3mdJLTyTVuoUerxlvOKnd390Jy0CDSQG19z7XWSRtvlMRB/1bxV6gUbdusnScQQQFxrHciGZzuGT+S8aRiywKROg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tTPsDppLrnrWWffryedgSfLyfn7XxrasKt6dFfxSynk=;
 b=BW3DEnMuf87vi0gmOhJbdJtLwM5OSaIg4Zni0mqb1T5Gp0dNNpOQ4E/3xVecFpgKL9zqhyjr/PkpXHTWuP9J1PjhljDlIUSvQco7cT95qk1QVJyQPM0fQVyMNXUMAvdPm43mU3O51cgybT9rt/qNd4sSf7TW5I6ZJy1qDnJ+5Tw=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5431.namprd04.prod.outlook.com (2603:10b6:a03:ce::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.22; Tue, 2 Feb
 2021 00:12:34 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3805.024; Tue, 2 Feb 2021
 00:12:34 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 01/10] nvmet: zeroout id-ns buffer for invalid nsid
Thread-Topic: [PATCH 01/10] nvmet: zeroout id-ns buffer for invalid nsid
Thread-Index: AQHW+Fz0+PPbisI7LkypCGaccpFcgw==
Date: Tue, 2 Feb 2021 00:12:33 +0000
Message-ID: <BYAPR04MB49653AC1A94F78112729EC6686B59@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210201054138.34324-1-chaitanya.kulkarni@wdc.com>
 <20210201054138.34324-2-chaitanya.kulkarni@wdc.com>
 <20210201172438.GB12054@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 61191fb8-29b3-417d-3b24-08d8c70f3d5b
x-ms-traffictypediagnostic: BYAPR04MB5431:
x-microsoft-antispam-prvs: <BYAPR04MB5431D85AB1A47CBAFB5E88E986B59@BYAPR04MB5431.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FeKET9gZPzYGPl/LPnCVDyHR2alsljsnqOmZ9J4lbghsWJPBehWvCB89xnGqr517/39yt+jEb22o9ICzpGnE2C2rfWonivSZPS68lC0j/XjpahNA8ELdfLdWlek4VZn9Sb+ri8V/rd3050VC3N1uGsl2/HGjhkgJc5h4jNhgzg59TSBQhgPbuWUCIN3EfpVoJbkpA4kR4skSx2chPX3HIRnAkwRUBdI5xbligobACa7a1362Yn0QPMm8H+B1DmDkv2NbRM11l4HKERdnHsWc3Fm1ML/mj8lG4ygrBg7DKhfOUAhgsc4P8NmcG/rJDI+y/NXC+j5ioDX41TAraAft5hYLq3VLAQK0NmWAA/V/5RwqHhotCFeI5epJ2cMyC67WWn2zd8Tbfri3j7exzHSaHWubSZHg2bUQ12E999pQ6XssL8MxNdh8bmvCsqjKGwkl3IMG/dr9PcOEZ2RXIu/LRRFFZtZkvf2snJhVuL1QEq59jQRVZ26YjbJTZQxCsvCzmCcHbrp9j+BUjFZPReNUag==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(396003)(366004)(346002)(39860400002)(64756008)(66446008)(52536014)(66556008)(5660300002)(66476007)(8936002)(6916009)(53546011)(86362001)(7696005)(8676002)(478600001)(76116006)(66946007)(55016002)(33656002)(71200400001)(91956017)(9686003)(26005)(83380400001)(54906003)(4326008)(2906002)(316002)(6506007)(186003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?mF9IoXmcNcwdKCXT5KS2zTxmp8Sx5sXTTg+4s3blEeUwQEPzP7RZeO152Sdx?=
 =?us-ascii?Q?qVeb5wVOWv+0EERou1/H8GTVeionHn9zqECZ8xikL4mY4ZYU4Y7uKNbRPNyE?=
 =?us-ascii?Q?uNENnK3P/wnMBgU7rlf0ngQv9JOg0goPfLVhcmWNzba+UwGrUh0QkzmaSW5P?=
 =?us-ascii?Q?Ch892mOBjzgbhACZPxTh2HyMKWWvviPun0e9B3pXUf0DQ45jYYwyThcGq+Mm?=
 =?us-ascii?Q?jxVko5bUE2OrIHshZVjFNrlxTguuWhRUBe5kbV1GMYMg2NclJ9N0WYspRZG7?=
 =?us-ascii?Q?AQl3M32qdfQ4q1XtdU3rm86Nsnsc5Zr5EnUmVmk2c9OiGhYi6pa+dU4q5PKi?=
 =?us-ascii?Q?RBiLHeckYPH02Ol8US7g0IMDn5cNhyq5mFvrpZaAAoGUrfYpwi5UcEjyotqj?=
 =?us-ascii?Q?YsjOzk65hKJm/5wEgtsYuTjUVrAHOyVbax37i79kLo+VFeEdgxk74QxmZOu4?=
 =?us-ascii?Q?ozIzvOJPDYXsIDBauIYZTeNNRJ3z36MqRHyf8DPYRZAaXo8Og4aaxSKIyTAH?=
 =?us-ascii?Q?+uF8WcJuAMWCvfHCosixzlnhGnIEPsAwxbHoIb02NKOi22Q2C4YMPQB7SXOo?=
 =?us-ascii?Q?MSQ0+2+Vl/CGNgtyHyKju8mY2MBQzf0x4n4wHZwskeWqZM5XmkOHz5+Y+LX9?=
 =?us-ascii?Q?oPq6B3H1dVx8VG8CFQ1Zy52DhVmCWHNyl48NX0QhHO2ZgdSskqroeAycxZbz?=
 =?us-ascii?Q?gO0EIIiJUdQNyfMjIkovQZVwpHFkNAAZ9yQlUk9LfdAspRKjjOtpS1M95cf7?=
 =?us-ascii?Q?b9SxwxsANpI2mcwgyFzUefC9CH6gnyEeg+T0oJD4Te84EZ/8nnC6m7QIzQfQ?=
 =?us-ascii?Q?TsD6KKDOKG+Z8BXbm18oMY6VCT/bTe93BjbPmiRfzOeNY0N96z63qq+iW2sD?=
 =?us-ascii?Q?TKBWIh0PK5FGfccSd0UadMOa65gqAuzxNYQbY4CR+MFbvrSnokJH9m+RxvL7?=
 =?us-ascii?Q?rfu2INHePTl4WO7U5Sf+9iPcJ6EfgRqBMfxn+OtU21DSWCCyJKV/j//JpaAk?=
 =?us-ascii?Q?yQp26zYgXEizqd/k2I3CscA613sPKu3nb9POTMmDPE0UufB5bqiXHSw6Cze6?=
 =?us-ascii?Q?INsh5LvUzPHYQZBlKNWAj7kgyiljWA=3D=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61191fb8-29b3-417d-3b24-08d8c70f3d5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2021 00:12:33.9771 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i9zE1AM3JLzbXlN+MhKYFLGz7joTSZu9joqC0lbe09hIg+sZGaUm/QeBn9sb/QIh+dF8ltqHC3xnR0jXN0R7A/AR7tsH5BA0eINMLYwUjac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5431
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210201_191238_488264_D79328D7 
X-CRM114-Status: GOOD (  18.47  )
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
Cc: "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2/1/21 09:24, Christoph Hellwig wrote:
>>  drivers/nvme/target/admin-cmd.c | 22 ++++++++++++++--------
>>  1 file changed, 14 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
>> index 613a4d8feac1..8cc7bb25d10d 100644
>> --- a/drivers/nvme/target/admin-cmd.c
>> +++ b/drivers/nvme/target/admin-cmd.c
>> @@ -476,19 +476,25 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
>>  		goto out;
>>  	}
>>  
>> +	req->ns = nvmet_find_namespace(ctrl, req->cmd->identify.nsid);
>> +	if (!req->ns) {
>> +		status = NVME_SC_INVALID_NS;
>> +		/*
>> +		 * According to spec : If the specified namespace is
>> +		 * an unallocated NSID then the controller returns a zero filled
>> +		 * data structure. Also don't override the error status as invalid
>> +		 * namespace takes priority over the failed zeroout buffer case.
>> +		 */
>> +		nvmet_zero_sgl(req, 0, sizeof(*id));
>> +		goto out;
>> +	}
>> +
>>  	id = kzalloc(sizeof(*id), GFP_KERNEL);
>>  	if (!id) {
>>  		status = NVME_SC_INTERNAL;
>>  		goto out;
>>  	}
>>  
>> -	/* return an all zeroed buffer if we can't find an active namespace */
>> -	req->ns = nvmet_find_namespace(ctrl, req->cmd->identify.nsid);
>> -	if (!req->ns) {
>> -		status = NVME_SC_INVALID_NS;
>> -		goto done;
> I think all we need to do is to remove the status assignment here.
> While you're patch avoids the memory allocation for this case, it isn't
> really the fast path so I'd rather avoid the extra code.
>
Sorry, I didn't understand this comment. If we remove the status assignment
then host will not get the right error. That is the bug we fixed it
initially
with bffcd507780e.

Regarding fast path, if system is under pressure even single memory
allocation
can be costly, especially when host tries to do read id-ns, is there any
reason why we should not consider this scenario ?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
