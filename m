Return-Path: <SRS0=15Zf=IO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7798C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 18:32:26 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51AFD6507D
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 18:32:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51AFD6507D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=ZuQlOidN7JRspvaKyjoTDTmJiQeOgUzUPuC/8Dv0DiU=; b=ZiH2ihiP9c7GSCF0iZwd0m/s9
	44oEokj//um7dLG60HMCqMueW8FzoQw8V34CZjLFYSiZJiLMCTtaYNJzZ70FCLdPOKKg1h80NcOr+
	ZKe56EbEdUXRGrU00OgBVJJbQYfKAIAIuehFC35+6Rb4vcaUD74gN4tYd0Mpnd6MMw39ZiMOivMHo
	FVLhj7wEnYHSwQEiAnzq9kpWPQeTCd0Onk1NjhdDin+3vYT0GICWyXxcf6v2/CSzpdQqlCV5Wm73b
	aA2UVUoZVYBjnuTA25vpSUlArH+nDJuXsCBbbvOLueEN/wHDhyPST9cuc6KUKx6u407SGdHg5h0KO
	4Nyk3j6tg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMEUJ-001cqn-O1; Tue, 16 Mar 2021 18:32:15 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMEUC-001cp6-1k
 for linux-nvme@lists.infradead.org; Tue, 16 Mar 2021 18:32:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1615919528; x=1647455528;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=Ic8UHompUah5EZdB3JND8MdP8NYaFXBgRSSq38um9Ek=;
 b=ksNTwsuMuhWuVTAqjtW6y8yJzp27B/iPCMUlkhENhbIppNGBPbYs6Jdz
 3jT3EthL99Gr8bKD5FQ0gQnNSLDLnvfdds4C8TReTVwsgKcJaRkV+HIEr
 /Rh4unGCY0GpP8FCQ03HSH3fN1HL0vHCp5kakOpC7FpQ59xJN+2uqTqvm
 adHHCx3AaYyScQUBs23aO9k8WXMvjeaE2dMkLdGuBQuEaI/MBMYVDYUBO
 enEQGTkoZeVIPPh5qqgz4BILQUJo+jZ/bK/hItcsABRaD3UEi2WU9slLZ
 lbAId4lqW6kXVCsY9gt+TQhyEB4+QQW2reu5AljUj0LRgrJ28a//qt4TH Q==;
IronPort-SDR: AvFmWq4TrBrvicjvLi9wXo/v6W2LbPX44MCQMmJvX1qG+ZoJwuIc+cFtc9NmabdPw6zs9LWsKT
 2q3NenCVFK0ivEsCyOsYsaoAGP5/6bIHjWO96bLMpjR6JPhHLpSF1SVN/bl2w92W78MoVoqaP+
 adPLJG1hY6Hl8QXWfwUoTtz6WZdsf0EQwHB3UDBeBalaZ/tlsnRvpDYu3vAxVj9TtpQwEqVHoo
 jto0M9EjhUnFTTDzC4vWVmq/oreA0m+3BAg6BE++P8H0pmmhg2M/qedgMArq+dxiDay+lPDDcy
 2eU=
X-IronPort-AV: E=Sophos;i="5.81,254,1610380800"; d="scan'208";a="273007894"
Received: from mail-mw2nam08lp2171.outbound.protection.outlook.com (HELO
 NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.171])
 by ob1.hgst.iphmx.com with ESMTP; 17 Mar 2021 02:32:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=if+Yc9IuPGNTmrUxWAMDJCVT49XrhH8WG/04fN1sryNP8Qo7WkwizsiVswGhXH766BLH13mSYZRyWQj1O7dbMDYxgVsbRN5+ozx/irMxghq/u0eAgqSfYLbvkp8yHgOs4EZBGbMtZUjPXbDdUFUEys2uf5MMvYTFaSaX2VAFWidoyWsPnX7nzMI1cRnfdrrZWiNnmqep9kzfRlqbcz7/9JvjNbQtu0V857IkjBsTsJrwFprPSncK9q7Bo0dQnxr7bDW96pTlu3Vehlz9pwAp0mz9TM+q41aamNo+aR1hxAim5t6byM4aklrcFCEqb5K+35iv0/Wk4cyugoi8Y60b/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBfM+FNkUW3izhK7Ep/R+Vnlo9K6O/NhanGD5Bz5xWE=;
 b=HSWo1R3FMJUb7BmZu3PAGS0pRD/wQsLHALvRAX4yeloIHfXMQ7klMMA/b99GvYgyhb8/shIqkanCySd15cFrRYa6DFPFmrMAggZzYNuDueToWpp94WZGe75t3FSLvRMU0BG9VEdVKMgWJ2m35STBtKyReBeNwHX1+qZ18EVXEuqcdnkzcBDdKB1emgcJntgs6IIUO+iGxIQ4djKc4hQCTFyjwTHrk2UwB0iDM+0CUspbzGqgl/bbPUZzBi8qaXUn05XLLE+bH03A3Y8YhpQ110pljhClgaBDCGKCvcEsW0NQgXBjSU/ONQAyzj/WpJ/K7sGuEKkhSpOhkHQzgVyzyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBfM+FNkUW3izhK7Ep/R+Vnlo9K6O/NhanGD5Bz5xWE=;
 b=UMR5mgBM4ZZoaoEGHSwmxCcMF30cCinyDCuQAMJ/AqCHcd3NYZsTO/nPoOU4cQgb6AlyHb9R07qfVGAumUlp2OgHGW9cRatotsQwt7MP3W/fMH8czM1Su+5kcbFj+1mA7DVA1t06vKz6ox+xjiLcEb110nC1BYRo/JhFY5C68LU=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5255.namprd04.prod.outlook.com (2603:10b6:a03:cb::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Tue, 16 Mar
 2021 18:32:03 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3933.032; Tue, 16 Mar 2021
 18:32:03 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
CC: Sagi Grimberg <sagi@grimberg.me>, "ngottlieb@nvidia.com"
 <ngottlieb@nvidia.com>, "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org"
 <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 1/1] nvmet: do not allow model_number exceed 40 bytes
Thread-Topic: [PATCH 1/1] nvmet: do not allow model_number exceed 40 bytes
Thread-Index: AQHXGateohYAPQtrLEmKz9nIE6WnAQ==
Date: Tue, 16 Mar 2021 18:32:03 +0000
Message-ID: <BYAPR04MB49653D53C5A0BB3D11D3E281866B9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210315145611.155972-1-ngottlieb@nvidia.com>
 <BYAPR04MB49657B5E84CDE72510A5AB77866C9@BYAPR04MB4965.namprd04.prod.outlook.com>
 <4a4a2b20-af9c-0474-a5b6-734158dafcb7@grimberg.me>
 <BYAPR04MB496523CA274146559560AFF1866B9@BYAPR04MB4965.namprd04.prod.outlook.com>
 <0b645d22-4787-e4c6-6872-c840ac7ed39f@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7de5aefa-a4c8-46e9-3e42-08d8e8a9cbad
x-ms-traffictypediagnostic: BYAPR04MB5255:
x-microsoft-antispam-prvs: <BYAPR04MB5255C03C7E3325C6B190E399866B9@BYAPR04MB5255.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XJbKKq+1fmjG5Rp/xzIFELniVJQkQZeC+vs6/2ERtBiyUwIT2yNO1zX0lUGC5i1bzDteIXZU+yLrlye7DELoOccLeVwAbwi9UO4I6AVFmdPsS+EZlbDDLBFca6PFUJZT4tiV5FfziabCccut64SCyEZL3D7fhREWVLa2ZFob7acuUrFXzAn+g+ZPad6T85AIagYWBwdY8Iom8/tGKU4Wwog8WSztqwISwrJJsLfyv8VX6cKGWdbHpsDzTKk2c2f8yIBAAVDt3eBH8X7bdQqs5moDl381+5p1rSKcSQiLb+sA0g0ZkfZp7h9Fj5DuEKbcTuCtdpWuduX7CSK6nqQzTgHvVgEIGH2YQ3yrMWjgENrFi76qg193SWjrihjDYDcxl6aoA3pyZOflPiRwVWbpaJzaQo4MDUCDXiBzaSE8ru2o+J233Z+PdAJD7G8WiOZOYjLvYq94Og3XLivOxsBGS7wfpnPyU0oAaB/oqa5uMfUhLQ3Y1xSg2qqExIxS6W+a9YIx7lM34FP7cbILjhbwasiCB+vQ3IXjGA7gf2B/Sy/cFtSrRBarVZEAtQ9RQSnB
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(136003)(39850400004)(366004)(66556008)(71200400001)(55016002)(4744005)(2906002)(5660300002)(6506007)(478600001)(316002)(7696005)(64756008)(26005)(86362001)(54906003)(8676002)(8936002)(4326008)(6916009)(66946007)(53546011)(52536014)(83380400001)(33656002)(186003)(76116006)(66476007)(66446008)(91956017)(9686003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?eqy3y0gnmvJ+dhm451mqtRhBKueYE4w1NdwgZDZKNMy7dyjMGG4i7fjtrA54?=
 =?us-ascii?Q?OoYLPDYiG3jHzle9KAfudShCPb5DIrv7xfimnHNzRhKGNgpvvLzLOf62Ce3o?=
 =?us-ascii?Q?6ux9ozuRBVRJOrIp9N74UXVdjBjaBoNZp+5hQbDX6Wh2FlVO9ONEcfBg9+8m?=
 =?us-ascii?Q?Z7+3B27K+YrExiV6q+P8NmUm0M0ISKQkS1MI0gMvlaxbyQ90I7ObhrbqN85R?=
 =?us-ascii?Q?ywLPeBl+tuTCpDNMboF06olB4f3ynTRgDt/w8U6D34wBaclkb6y81cqxT0U9?=
 =?us-ascii?Q?umrQ2fTvX3//mAUqjSvtt9g4N6iVJY1VnQL04Co42FqUSqgPwFocO6/kOxBs?=
 =?us-ascii?Q?oGCPOhPEC1TOeRVd/H2onMICTkt6bsS6JstcdOntRB968oISPE/HQwmQod7Y?=
 =?us-ascii?Q?LLvgETm93V8aLgVdHaSl221mKK1d5eLRJ+3LxoeQod7AqT3sP0IJVJDPTZR+?=
 =?us-ascii?Q?0KcMoT94s4Ycrp+QEe9rEN0HvQsC/1qg10ljHLCZ4JmAXEWIHniVCAhmRkAe?=
 =?us-ascii?Q?CvNvYJEn0Nd+FaGya1/DoX8uy1anksSzmQzAoeCaYdFKkeEtop+J2/KAMOHg?=
 =?us-ascii?Q?90sHpDflLufTd1/A7YVnVB6RpSi7vjTzrepvj/+NbM8PgA03V3ksu0Hig9Uf?=
 =?us-ascii?Q?FkXabAvH+IfuT9Sf/N+7c5N3s+EhDcXdouxMdsV7zl38ksjd+koNxa4BAEeg?=
 =?us-ascii?Q?QTTqPmkdkfYIhlpAxY22A89rH+ZMYWFDT4B7JUoUwxpZxLp05ghg/q3Px1zi?=
 =?us-ascii?Q?1vabx+/I45dZQbW/FCcBsl527uch7KYX9Akp/ix2TmIWFPbwJKCC3NQoIDhF?=
 =?us-ascii?Q?JGmF9BlRhe/NiF/T50cdR+4UUm+FTXxnUB2x14PwqpGlSndKHYqdz9nkBSXS?=
 =?us-ascii?Q?bHNQSnhoNAYldfohzMvwdJXSVjC8+AEmJGJV6Pf4CaAtkNLSCV5QSk0m2m2U?=
 =?us-ascii?Q?2/QUIGZ4rBdk6FyN/vT6KYtnWW1TfZT1CDbMZ6X3XSSTRbjgcDVwM64YLzU+?=
 =?us-ascii?Q?cfqXEMNi+55/X+eatIaPohHk+5KCc1Po6sTEdMeGDSQBsIxUzlR/1LA6CKho?=
 =?us-ascii?Q?xIUdaqEjGSO5wXi/VNXcDgZk57CpsGAyM+shSM9BVWAlMLdfqzz2u/QRiPhQ?=
 =?us-ascii?Q?OPkmA7ieG56QW1pJz+hfs9JoGmGkvqp3jqYJMSP0ptTsad2qb4pXswAcq4/d?=
 =?us-ascii?Q?O83R58tUEr2CzjDXq4J6Uww32t0vV7CuTV1n0uDSKhZhkjIROjIRlWREqMhV?=
 =?us-ascii?Q?idwvLDyictz8ObrdWkPjv5ibwp15eKL0SKRqIgEkHDD3qoMOvysWC0SaYcej?=
 =?us-ascii?Q?DxxB2kZPob1gdXUGieLNualE?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7de5aefa-a4c8-46e9-3e42-08d8e8a9cbad
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2021 18:32:03.5992 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iWnmg5u5rfcLpE5suUo//qmYMKcrOXx9nroLxheUnZZPlTCKbyG2dtqJXyXfmKc+eTMnsyLqa8D/pq56VXXlZNv44EijQ000b4W74GXRxUE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5255
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210316_183208_937859_3A7A5435 
X-CRM114-Status: GOOD (  13.31  )
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

On 3/16/21 01:35, Max Gurtovoy wrote:
>>>> Is this a fix for 5.12-rc  ?
>>> I think this patch can wait for 5.13 for sure, maybe needs a Fixes
>>> tag to help it get back to stable...
>>>
>> That's what I thought, can you please respin unless there is a reason for
>> this to be in 5.12 ?
> The function nvmet_subsys_attr_model_store_locked also exist in 5.12 and 
> this patch applies on it.

I see.

> I'm not sure it can't go to 5.12 but no problem we can re-spin it for 5.13.
>
> I guess for Fixes tag we can use commit "013b7ebe5a0d70e nvmet: make 
> ctrl model configurable" , right ?

Yes, except sha should be 12 digit 013b7ebe5a0d like :-

    Fixes: ed7770f66286 ("nvme/hwmon: rework to avoid devm allocation")


>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
