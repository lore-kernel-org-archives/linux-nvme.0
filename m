Return-Path: <SRS0=aHbv=JT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E719C433ED
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Apr 2021 19:02:01 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A41FB613B8
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Apr 2021 19:02:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A41FB613B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=CF6pX9XMHGYtwTx/Ibf6Fp1Awd1AGTnBgkB/gDLnD8g=; b=NlPMJvlHtabfa+c4TLa6npirt
	ecsqGF4kFQ/08feKx9X+5oOGSf4Zu8x4hDz/AIjCphMCI5re+P0SmnOM4aSLXhW8Ou9d5usMMfxjE
	jD4F/GEcv1YlqhmSvhzib3TieX95rgEgQlEx/NisL4H6VdhL4F2tGX5XrXjpWM0m587hV5ZsAb8Ud
	0cegOEPdU0XpouMyyn0wKqbz3NVoJK9sVWf3J5P08qqrLnzB9WtWlRthXczM5gcEVIZB1JPXsuiEo
	m/K5Ai3/ZWvwI/NtavjHrHLjyU5zLi/y5kaA+4kKgKt0mE6ZlqPGzr8oHxZ/dql1FfH1q2Vv9N7ro
	eaNWgqpTQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lZea8-00HHw2-6h; Thu, 22 Apr 2021 19:01:44 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZea5-00HHvq-7O
 for linux-nvme@desiato.infradead.org; Thu, 22 Apr 2021 19:01:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:References:Message-ID:Date:Subject:CC:
 To:From:Sender:Reply-To:Content-ID:Content-Description:In-Reply-To;
 bh=Pc43HfwuMQ/8vb587TemCzughOcv4ja5qaUrTY2iQWQ=; b=uecxjKQH2ZinwJIKBHNN2wFpvN
 QgF11uANMi1942f4wut/wQLVJ93OsnzsiKcsx7lcAMn9Ptg8vFHQk4WTbUspIvPdDF1u0yOnO6t4h
 hjpQEcJlMie92Ux5p3RiOuOPx76kpLXuVB0tbOhUOz/B6jcPjUB2VQbDh/HMpYKgPHy1uiziE8QNR
 j9quFlYNywd/Jqte4kiC5ifWCBcbLa7aHpFnslrloMv1tGn862fgbSgvhmmY2mI8xkBQ3ZYItsI1p
 SJA5tyWavNF7TB3pbGUjTk1n+JeMoeROg242oTx04drodhK+RPqkE0Kf8jpQ49CWC1vYxhGh6IQjD
 nZv1n3tA==;
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZea2-00Dw2E-E7
 for linux-nvme@lists.infradead.org; Thu, 22 Apr 2021 19:01:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1619118098; x=1650654098;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=Ec/GWwaJrFkREBKYKFkamu42mLoan6FwRkwQNoUOMFo=;
 b=faN5i7jdtwLMTyO6rcbH9/5Iy552O3xGaUNtrQ1AB/s9Pe4lLBxgZDNR
 uguEdLwbIWZe3EPYMQphP7VKgtLg+N8UgxxxcsauSCU8H41Qt8VvyBMq9
 QAu3xOp/WkWVKAXmofp+/5nsuph3kyS21upavs+RhghFx4KgJHvaxUgxy
 mkm/M4SkMtf+DpogMAyljEXnfqunNac6KoBP5eA0yBCvt+k2ZsOrHjxVQ
 zwBlxA16uS21TkVjkmBUt3xK7fUOtjg1QKBbWKzyoQRI28jus9dsWsT2G
 Xuz0CKSEgtV6rUImAzRZ0L4xc68EnmM8EC5N0ijSM47+c6grFTbT6/2ih w==;
IronPort-SDR: Ka/zKjP+oFaSMRF2xOxFJWI1bJSZOX0324ktzMq1WomBLYn1ByKccD7a2NgQExga18gO7Iuc4x
 bTt/iTuxvto/h1xHY5hoOSAdZQxhBU+uYFAJQnY8k/Q0aI7aIpGiuHdmIgpaB4tW6Al6QzCDoK
 qPxdW5ux8d1OfrV6ao3J7CC8a+ndGFJ6sLUKO94qfySt2asNZGTt7GKEd+tSQPmlEX+7tIiVhB
 kuzQj1gheJ4O+Qq912/xH+I2+YYjLMY8ehLD+uIksswGsl3seOV6cDMUx0vaUXhzpggkxA7Hwm
 RBw=
X-IronPort-AV: E=Sophos;i="5.82,243,1613404800"; d="scan'208";a="166443300"
Received: from mail-mw2nam08lp2173.outbound.protection.outlook.com (HELO
 NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.173])
 by ob1.hgst.iphmx.com with ESMTP; 23 Apr 2021 03:01:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ozjxt35SKoH3WDLZFX50K7Cf3FsReNhAV1/D3pHjiLkA+aSaTSK7z2ixkcIfCqfQ3YgqSRCGeHdC74Nr3Rj9QlVLHf2kBmQeR64CtN+zJFL+KBKZKMKFLlruPxv/xsMZXewVyhyudS/7XIoc1x9nZX7U98Tt97n43eaAtw8eH97MHKeLYe6CeD4UDdSoulfd31QDzGZ/ZoZOVXiwqi0WiMnghz0iMfkWJMFsL5hm8kL8FYi5StX9z9YfnqdsSatOqqRuC6F2MCag0QCxOzoD0N/PFjN5EvG7yd7vJvNi4yf/MQ277uk8kxbc10EKA0QephZuROF35PgzHtoWlgGwdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pc43HfwuMQ/8vb587TemCzughOcv4ja5qaUrTY2iQWQ=;
 b=id0YPXTu8Gfv5AEx0V5HVOq8/lSl1zbUKT2JXlNaFASC8Cg8SHkgRXbDvSYOg/gfgbWBCv2BVRWjDhxPeEr2wD06QL1AlCA49xT3FYzRztZsSChsaZ7Kkq/9uX3ESrYYCP3L2Lu0aRGv4xouzLTGnePz/pg0maDCJWfDKwtnZ78Pcjd8dH1CyQaX6WVWQv/JBKJ2W0C/rl2vULK01Sqb96rwd7kn6n70+1DpPsH6jYShp5J47VSK0OxKXd73LLObsCXTYO8k8jm1vgPi+2rbtFLjsNU5FtD4hBVHf4AGNzEhcFe24eyy2dBrzMD4+84Wei3c0m6EeSwUInQKzRo7tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pc43HfwuMQ/8vb587TemCzughOcv4ja5qaUrTY2iQWQ=;
 b=pijtBzX8tVJM7hbzCPzt1C+jIx/PZ9zgy6Y6YYdmCYtG2nzyNxKGx0IiiTA8JtCIqiepagkuyY9NVmugAsv57GB15rUJpoSt8M2saVJOs+/EMV+hAqt8ZPb4qJIriRSdIO9/T6fmk34A50xowzzZoCCLZS3/n8FJogiliXiJkog=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4231.namprd04.prod.outlook.com (2603:10b6:a02:f9::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Thu, 22 Apr
 2021 19:01:33 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.4042.024; Thu, 22 Apr 2021
 19:01:33 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "kbusch@kernel.org"
 <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>, "oren@nvidia.com"
 <oren@nvidia.com>, "ngottlieb@nvidia.com" <ngottlieb@nvidia.com>
Subject: Re: [PATCH 4/4] nvmet: make ver stable once connection established
Thread-Topic: [PATCH 4/4] nvmet: make ver stable once connection established
Thread-Index: AQHXNcTY3fiTtEHfWEG+MXP8IUoT4A==
Date: Thu, 22 Apr 2021 19:01:33 +0000
Message-ID: <BYAPR04MB496510EB11F9BEEB80020ABF86469@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210420090903.595664-1-mgurtovoy@nvidia.com>
 <20210420090903.595664-4-mgurtovoy@nvidia.com>
 <BYAPR04MB496522B82F4480CADD4FF34286489@BYAPR04MB4965.namprd04.prod.outlook.com>
 <be2f8d6b-eb56-5efc-1853-5279329f733f@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c0487c0-a673-4153-8f4f-08d905c10be8
x-ms-traffictypediagnostic: BYAPR04MB4231:
x-microsoft-antispam-prvs: <BYAPR04MB4231538C0929352BA9E29E3386469@BYAPR04MB4231.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yXnjhhf0Rg3o+VJ2Lp4oS0nSPW0rhntXq9dkE15qKy7LEfa7ANKcdjjId9j+w6GQRUOiKFs8SMWxtlFtPL9VA2LdVxY4uztweIxeBRHlUQI+P6OwPLAtfHt3wVtuX8Q3XUmy3CPtB/Tg7F4nRaLvEEUNjeRxvrHr4H8vmSX0MrDuTo8ArKMmOMrGBEbEWN+mxu7Y2MhEm+eCiK08tI9g6aQDuNVCYwJqBiLiSS7C4UcPdR15v/RQzJwR7NPUuGawrB8P/uj+QTScj+mM9SKqaz2AqIvab/3Q13PeKL8mJqcugyqkje79iGKHAZdHxyNMOOw9bv0xrxqEZpXTUYc6XC/Jf1Efsj2rADg5KzzWAzaqIpyOA6CRy19OB3ooyY5YzrM98Uw81q4o0wKGYXxm29CAoB8OuhMAz8U6lCmfvDgfJAcggPproV+eUoiKSbmr2fnpj4CDyVuhrigoNgeLJp8L1n7XiLaoZEUjJRGsm6LF5dXKofxivWMqKR26cxdLHB1cVoCAhuuFTqlQ9HCfIb4WHeGR5Rfb4sZIHbT3ds+yCsFHGyHUkTUTgNZwZld3WVgb4ULkRMDEoMidmPv+o95lX122Zpp0+95ycD/AZ6E=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39850400004)(346002)(366004)(396003)(136003)(376002)(66946007)(66446008)(66556008)(76116006)(8676002)(478600001)(52536014)(38100700002)(64756008)(8936002)(54906003)(66476007)(71200400001)(55016002)(7696005)(26005)(53546011)(33656002)(9686003)(6506007)(83380400001)(6916009)(186003)(4326008)(2906002)(316002)(5660300002)(86362001)(122000001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?kduM44mE2goyR0/RDPoKFStlVRi2NBnH95Ct1OUUOlYg/hInwrLHEKy+bNZH?=
 =?us-ascii?Q?Pzz1E/eNvPh17Mc5CUiEXmAp3u4frbZK0qt/HbHwehRFSn0gocfgE1TM3BwB?=
 =?us-ascii?Q?EVArY5KJQTWWiwjseHGgLP5Ej7KGX5xMqtswBm705CfeC5lzl42tHX4ibg/S?=
 =?us-ascii?Q?xnoQrOXTsFfcme2pblpxANLVLuMgDAQiOv1Vbi3/IthWs6xaExoHqtOQI+W8?=
 =?us-ascii?Q?5Wc90lR5E46FYtoMxnTTfII2DJuw2kL5RuXQa+4YLqydlBi3BTsMbarxOCr+?=
 =?us-ascii?Q?MFCLA7o9THfbF13SbCN2vtTr78Z100xdiDuQ8QCpnhQ1ahtiLGXvviVUklrJ?=
 =?us-ascii?Q?T2wgTe9QQqaxqQcSwtIPw/VmxJjezsNSESn7u7+k3LLRl1JncuADmxnFMVeY?=
 =?us-ascii?Q?4L/IufTaHV+8pruQ2bAs8Q9n4mbdb9PiPAMbKEFX8QYgKKAbQ8vM3UrkH4Gb?=
 =?us-ascii?Q?ueFdrbQQRokxueWskdvfpA2GvkxAOnMylXymQAD/4KGr7z1URDX58kDUyCDQ?=
 =?us-ascii?Q?en4QkBfaEKEjL1Z0E2u+Da1oAWPn52s7pEYCDWDZDoJVw+jdicMQL9CmDJb1?=
 =?us-ascii?Q?YXda3JPadIDUv/3qmx0r2z82hH2jgCZHfiLEdgX/qOWCa5Ewj0QC2cyfYIBD?=
 =?us-ascii?Q?gwi+iRm4M2AFSwui2zy/TSVUGDcGiHR+tS+k8OprnixEwR9omdRPp/pncCIQ?=
 =?us-ascii?Q?j+MSCzzziqBTuLpN2C+L2VEm6MbF6R3GCbtlLa1Hmjf7gHUGdcwSTmJYyiee?=
 =?us-ascii?Q?TCNR2U4qf9ghsAuHWdQ6nAbyo+Nt80yrdijNhy1N90Pe+kxEHWHXjq6OEtYf?=
 =?us-ascii?Q?gXTvKmbQg5UgKvCzrYS8WlgqOjosep43azWOk37mbb+Ye+JJhjXt8myWAAkW?=
 =?us-ascii?Q?n152J41N3XFwk+Iz5uBdcyHunMDjLn+yQwKLuKbbIyOG+RvliQDsJs7UVBLF?=
 =?us-ascii?Q?RvLh/UaHGyDS6W0/uQpnfVJ4i8a/AVpMGWax+pw78W0Uxgb3BRle2xIAAWce?=
 =?us-ascii?Q?EIFtauKd9oJQp0Wj0Cns2P13aTxKvgY+ZcfthtczKbK64vEkjK5rtY20ejVN?=
 =?us-ascii?Q?/PUccmtRMSUaeNZnTFb4ig0sfYSeflRlTqCJgb6NMr8FpUCtH2SOZcjs4CFM?=
 =?us-ascii?Q?ujmTSGgxw0YC9T/6ESRY30EEX2wOuNfA5ajEnh9wC4UwyJD8IXS4DhhI4J0e?=
 =?us-ascii?Q?cB/um2vjx2cHwBVmvVSa/dlv+gzvUNVKBdU+zguEN3m4bWEsiDK06HsiHrE4?=
 =?us-ascii?Q?o+bpkPIqa3i5u4apiPacxU3mH+8QzlGSCBs7nJtU8h/64eyaFOgBfPT6GN51?=
 =?us-ascii?Q?kgX0T1BxUwFcwCUCjcyblAjp?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c0487c0-a673-4153-8f4f-08d905c10be8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2021 19:01:33.5463 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aZ/QbvH5/udKWTJgZlKFYizBJwXeJOD13H01fCJsz0URYNaXTaYXSuAun7e/PrUesqEJ3nlSKWOO+6xkzOjvH390X9DBHYcIqXI33fptioA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4231
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210422_120138_562896_AAC23D13 
X-CRM114-Status: GOOD (  12.39  )
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

On 4/22/21 01:43, Max Gurtovoy wrote:
> On 4/20/2021 8:47 PM, Chaitanya Kulkarni wrote:
>> On 4/20/21 02:09, Max Gurtovoy wrote:
>>> -static ssize_t nvmet_subsys_attr_version_store(struct config_item *item,
>>> -					       const char *page, size_t count)
>>> +static ssize_t
>>> +nvmet_subsys_attr_version_store_locked(struct nvmet_subsys *subsys,
>>> +		const char *page, size_t count)
>>>   {
>> Seems like we lost the indentation in above line which was there previously.
> We added a new line since the line was > 80 chars.
>
> And we follow the conventions.

Original line has 5 tabs + spaces :-

-static ssize_t nvmet_subsys_attr_version_store(struct config_item *item,$
-^I^I^I^I^I       const char *page, size_t count)$

This change has 2 tabs no spaces, breaks the alignment of args:-

+nvmet_subsys_attr_version_store_locked(struct nvmet_subsys *subsys,$
+^I^Iconst char *page, size_t count)$

Following fits in 70 char(note the tabs before spaces):-

static ssize_t$
nvmet_subsys_attr_version_store_locked(struct nvmet_subsys *subsys,$
^I^I^I^I       const char *page, size_t count)$
It doesn't break convention, also keeps the alignment of args.

>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
