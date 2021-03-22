Return-Path: <SRS0=yO6k=IU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51817C433C1
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Mar 2021 19:15:53 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC95A6199E
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Mar 2021 19:15:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC95A6199E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=MJgwbbjI+KBz9jeQr7S9llP4IbDCN4t1bxoBJ1tctD0=; b=FNsq+x10OjU40nrnUdY6fv9F8
	Z9wQmd/OLCUbg8+/KsfxBFe+pBx16NDWygMvg7iQ4SBJkKlWBxBcXwHP9MoZ7u+zBDGBSP09J8Bgg
	+Y7IO6rgpL244RrhbxtK//eqNOay8DRWPvR7t+bEGFctM0UU9Cub8LK2hbc8joiR1UP3S0eYo2Cdp
	fWk9E8SGWD7rpkksWUggVsCza+b2GZuj7nWeOV4T+yqdwTdPgmMnIQ+ErHt6ndQ1Yl9meJ99q6FFM
	47HnoJCHED0AqHDCpVHaVc0JVHMqMdrGSV2kzAWmp8D4zokA6sdGCriv5UbGzB7cnITBwv0UKad2D
	4Aac3SvZg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lOQ1Y-00CPnH-L7; Mon, 22 Mar 2021 19:15:36 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lOQ1T-00CPmK-Op
 for linux-nvme@lists.infradead.org; Mon, 22 Mar 2021 19:15:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1616440531; x=1647976531;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=UsPqcOS1IAkaDETqregWmAAq2vPWHXg81CR5eybr6So=;
 b=O9l2leVVsUdAeVUmpuoWmRPOp9Ul2aoE0ncjeEmXRyVkGkN5M59AzAtS
 C5SLuh+c3CCc7DmmG1zruslEJ85Pkhpo88rx2TtUaWJfS5dydfyUKR/11
 xEKbcoYwj6pVeaF5z/BprItV0A31Z2EM4L5Spp/WM8ep1t/F/tFsSuIGj
 HzzcjOdRwrKpA0GvkAWJ+yRNBVw77ZlMhY1FtK4uLSSIflWfVCkNOyUKr
 UjSl+YWKg2JnrZZUtQS4eEANUmz7srO0VKK48ou4DrViYrNiaYZbXkvuG
 x1zfhN4lx0x8SZo4cGeryMbVdTDQbac8/2wkOuxw0l2nhaig4eLT18It7 Q==;
IronPort-SDR: tta0pD+fe4WBytd0Vq6o4F4tPErWPnLBE7BkUH5QEgs5YtfeDn+ofOK6ZD37M5V3OORvjtIs2W
 mPyDXeh/5bRvVLS2DLQ8G3AJMQGqHD0KP69Z+/EIYXyrPNJSrxHbKZFkT0TwtSCV072F+hvLvp
 FpaKmc2g0JxwTr4CbB3qMO25E+yBLPYZOwP83PS0phVpATc4Ncja39cvHy6RXlgoUjo24EVcqR
 VqcxqlB472/AoxRvfSAfCenms2UMHe07XSl9OBv2XNkKemNXL1I9nI/KROqp6V2YiAQjjbQ3Xa
 7gY=
X-IronPort-AV: E=Sophos;i="5.81,269,1610380800"; d="scan'208";a="167208209"
Received: from mail-mw2nam12lp2045.outbound.protection.outlook.com (HELO
 NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.45])
 by ob1.hgst.iphmx.com with ESMTP; 23 Mar 2021 03:15:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rm3IaxnX2LZGEuIn0T6X4Xyfct+ArD+fMkNJ3jzfkjIUQnRrIUPgblMayl8enouGyqIKpBGIzIltp9ObZ3qZW3T9kZ66xfK4Q9Si67BATPv5/oj/ErqvueFliPMCsat84KVGyvWxBVIwyP2jAOudkOmLcCzq225d71V7EiiNS3HMrQbuX+KywAOiBFpyUUTI9ZGmvszt4pzqYx8nPtNV58GWEwMJ/9HsH4ZHTigv4yychRZF9bATRANtcUXKPWfUFzLp1czblaidmo2RfYUu1Ja3VLOHFvVw+N1sjRYFWLAx+o9+3mzP+OUbbT9gtm5Q9uzhJf5x5j8FCl+fRdmcFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ld+p9JeFesz4+/BuaJ5sfTDCTuaJwWiBhOmJ4Vy64Xk=;
 b=gm80ZMse3WLQahQqAx4/Dv2K8I7i3XlaMt+Ox9AjQWSNGu39Z9mY9K3ugLGOwqTPAcyOYHgzrvLkWs3CFb+nIjuBjz78/3te7GTl+k3IJF/mtFyOaDBgrQy9clgyN1iwUnbh4Wgo5baQan2jmwNrqX/EPOg2A6m9xqUnzMl7hWtXpcQQ1yG6NckJZnH8N3jjES5Vjm7Yii4I1YzZD51Lu9PrFCGehPAyxDI81G1skpOfqWiYfU2pWbAJ0LS3JWWrCxXrl3ioIRjN3uG/mgTOvcw6srF0L9OvcVDgIImqsLAiBlmHG0ZVnD3h+9QUfvn1RQIbrm+ekDV1i48pP+vJyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ld+p9JeFesz4+/BuaJ5sfTDCTuaJwWiBhOmJ4Vy64Xk=;
 b=0LILYZH9frd5+/afZFXL6yoEcUZ4bCp9piG19SnpA1zxkF8WD6UrjYM6Ly8AgatwzC8ps4hnYu+eUNtMPU3V4qSZnTUbwdYxSsECxrf+EMhPzi4Sm9wLulj+GjzSHH9nkDdKbTo9KaAoU8NhsakubHivtcDZo8oT1vaNw9qv9DE=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB7027.namprd04.prod.outlook.com (2603:10b6:a03:225::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 19:15:22 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3955.027; Mon, 22 Mar 2021
 19:15:22 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "amit.engel@dell.com" <amit.engel@dell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "james.smart@broadcom.com" <james.smart@broadcom.com>
CC: James Smart <jsmart2021@gmail.com>
Subject: Re: [PATCH] nvmet-fc: simplify nvmet_fc_alloc_hostport
Thread-Topic: [PATCH] nvmet-fc: simplify nvmet_fc_alloc_hostport
Thread-Index: AQHXH06tqYHC8w0QLUOi6S5SvvpPqg==
Date: Mon, 22 Mar 2021 19:15:22 +0000
Message-ID: <BYAPR04MB496537278CC338FBE8066FFA86659@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210322185945.10364-1-amit.engel@dell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dell.com; dkim=none (message not signed)
 header.d=none;dell.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b63f6ce3-8698-4d3e-605e-08d8ed66d724
x-ms-traffictypediagnostic: BY5PR04MB7027:
x-microsoft-antispam-prvs: <BY5PR04MB70278922CC356ACAAD9E21C286659@BY5PR04MB7027.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lrpjU7xHZmR9f/Qjkl7R2cl8Pc46ffoGhvJ6t9gvPL8EDCcGxU6Nx3t7AfBZimjFGaUWFmAGD5MvG29Bxcba/UJ3VlIjcUWX+MMx99WXLV5EtdBCp3T+tASF5dp4cMIJN806Vstgdd8ijirOe8WXHbGQQN5FDUlj/GvAhNxdVCXgkorkBGhWPLEAT0YAgTC20buW7PTOfVpGjrFp9Ut9sDLLSRbLYT5BNbhTFr37tFz/YPfk19FIhFSAG2Z3f6NrhV5pqEC/2Z+JvF0pelh6ITcHzgWVve0uitcMjYkMzn6U4ohfAKOJzuR5PzHZJTGEsPSgSZ5AToLcNrO5wZh8K3gx6U/4LpMCKlvvthgH2Su5XU1r2gVuKJXmo7AHp5Ehss26p9LmafBbYMkYrD5BET/U+eXaA8f6JpLXVWSVWBZrWM/wu48Bvy4E/Qiv8OiPijCQ8TgXIckIWx1oREMdkHY3k/ggqSDbbsb0aHnHhpNMvKgaUtbusOGN6jnxqi2uMDb693n3lyEOPn6OaGhtCG7sYLhnd1eYDHhMbQmEBmbwHzSR1cwDbGul23HyEPIZXLv6ww3g5K7XSfhS9ceJwMxflKWdbZtIqvuTTQLrlrUtN1dSpboyXyYKtjytwt+SN9If+FfaFlkEqmm/VCKyvO0ZielnC55o8kZsPDras2I=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(136003)(39860400002)(396003)(376002)(6506007)(86362001)(26005)(52536014)(66446008)(8936002)(7696005)(55016002)(316002)(66556008)(33656002)(478600001)(9686003)(66946007)(71200400001)(8676002)(4326008)(76116006)(66476007)(64756008)(186003)(53546011)(38100700001)(558084003)(110136005)(5660300002)(2906002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Fyt3hlpbCTezU4VmMcdQiCs5l7SPAsfe82Zp8AB4+vzIkA2/JxwyVS833+Pb?=
 =?us-ascii?Q?T7O29r49oDWAdMdCBVsKsPgXZbnvtgdacV5Mk9+SqjUn3SisjDin1N74D1C3?=
 =?us-ascii?Q?Atu68wV7MHg9vQ72/27jPtvk5PJg4qQmNusP9AQnf0UWOPKuNghtUMOhsRLj?=
 =?us-ascii?Q?XD0HbvpbdsSN2z8tdBhEhA3YPpsA+gwjmBMhTGoxic5G25RYhx6AgJi1rGUW?=
 =?us-ascii?Q?cb0MeT5LjV+BM3SARF+AS8sX6ynd54vE7mNQy/Hoo/DgwFCN9Lu45NpYGWHE?=
 =?us-ascii?Q?MDUChDMqvq6Fo9E94+Mu1/Dj5zSpDlPvSvKQH1eXH5YrlgkMd7QEwQWUmWob?=
 =?us-ascii?Q?WMXuK4xMg0zypQMMqU2ylJTdGrhsMlncoc28mjxbfXXLjkskw8Y4TUSmVDNk?=
 =?us-ascii?Q?cE/8/DKzrLd+ONGpuoMp6aJOhahVu9s6+jFrHq7gs5lA4kIj2IJXs9CFbjAz?=
 =?us-ascii?Q?fdUIMe7dqgRPnHItosQkG4TtATza7QplUI1mfQGEVIMX4KqEni2Evb8axDZj?=
 =?us-ascii?Q?BMGuwQhT4cEnXZrdKXftbyI4sdCbzXU2zA6rTzwUiFGWT1/wwf+E+zVR3lUH?=
 =?us-ascii?Q?8+zplnBUBTfzYZvInPu+Qhs09uQ2APYfesLdMG4RpqWpHIEuCtUQnWGFD6d8?=
 =?us-ascii?Q?vTWPNb/vIkik0rMmlz59B1+r+TQ7w3qvWgcOLhklKLzGHKn+QEamZu1J2VQQ?=
 =?us-ascii?Q?pt4Ie2Xp9qOwXJIPE4XhzEiYdvuD4e+BhiVlh3a8mepKkzBuu1uRkFghk8QN?=
 =?us-ascii?Q?wPpBqzlZM5QIP+A6nM2GR28wrutdJ9hjrE6mfH0yz+3Ao94yQDnDM+0tkSsn?=
 =?us-ascii?Q?wlLiexAOHpGTU4w0sNQ5CmGaER2186Fg1UjmCcD8qmUjzKzEuN4j3mYtPM85?=
 =?us-ascii?Q?80Wz6O4ktoxkEuDO+QDkh4Y4vtR1rbBzAcnu3sfm5NjawSBZJNL0USJRhgMu?=
 =?us-ascii?Q?xNNLG1DPsi4+gMIDpbb+G/4bH66wR14LJJBCSfCEkIAL9g4kkMuri35/0EvA?=
 =?us-ascii?Q?66PWlhyU8BNp7wdH1wwzd5VWN+rr99/JAQdQ2RjbbV2HaV6z3IogCmygGJyM?=
 =?us-ascii?Q?hy55/80Loji49AQB6HAT8b7b63sND74Ewx3JNz363qqVOemsqMTl6bN7/tZc?=
 =?us-ascii?Q?D2wxXpTAtMIjeOqflWYe7ChzQsDfECZEIcPgzlTXEz0VVWUlEApus6uNv0Aa?=
 =?us-ascii?Q?Q3LBfAyoV7TrbmFPTGOJfYZWRozXmn4Cobq04qHcE+ewK4C7IzIg8y9DbEYO?=
 =?us-ascii?Q?qyPLUvCIS6pK+11tnE16PF+/uDSWcG5uTp5GmOFtfdzwozP7vjF17mgRyQzv?=
 =?us-ascii?Q?tVRVDw8EMhZ/Tiu80VTPkmbt?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b63f6ce3-8698-4d3e-605e-08d8ed66d724
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2021 19:15:22.4208 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H3iIzZiW+7QhKEEqMCniY1c1bRVlt8cVkm3VQhcTLxwu/HGN25gXqOt3odFh8cDwRzRPKQB+Y1aFniD1J/i/4BurN8ydlA5ui08FRqr50mw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7027
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210322_191532_201584_27188F48 
X-CRM114-Status: UNSURE (   8.94  )
X-CRM114-Notice: Please train this message.
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

On 3/22/21 12:08, amit.engel@dell.com wrote:
> -		return (match) ? match : ERR_PTR(-ENOMEM);
> +		return ERR_PTR(-ENOMEM);
>  	}

Same comment about return () here.



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
