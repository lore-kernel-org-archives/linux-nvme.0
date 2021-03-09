Return-Path: <SRS0=pxZf=IH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6372CC433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Mar 2021 20:54:53 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06D9F65243
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Mar 2021 20:54:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06D9F65243
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=XJ2cpt3U7HuMW3AIIXJW4+mWE5NhIP83qiRHyzklzNc=; b=SMPNT0n4Az+9zQyDLsWC0vZV7
	rAHpHutQ9xY5faslkom1LhK4M2djFxr/dRBk7apZHfWUHkznThuJt0A2ON2RLNKdUk6Q/eQcoapl5
	qvAliJGcXwbEuYD+ziZ79VchkFD4ecVTq2vQbLTszT1QUC9A0NtOBZr5qJx2edFv0//2XdHykMnte
	JriXVpbnBucubRvKTxPgs5Lr6Wy2PQTymEhuVTolV151vDRPUW+ex9yXzORElA+MxHMEYQRxBvtaO
	IzKBCi/HdOGDQyAgEnqAbsJw7OiADduw/VTFkrCyQYt3O0bvK80y9suQFBvknnlGtpnyxDCds7yig
	q7edONdZw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lJjNL-005OPW-Ou; Tue, 09 Mar 2021 20:54:43 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lJjNG-005OOz-Id
 for linux-nvme@lists.infradead.org; Tue, 09 Mar 2021 20:54:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1615323283; x=1646859283;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=LXJG7W5aclPNqj4OcBnVYEa4r560lavQmPY3HkV1Frg=;
 b=KNJeazVE2yUufL0HsK2aOole+q70RB8g4qp0gXuSuO4xSTVL4T+SF4RC
 XHcmNuk73wlhFmnyGmmyYK9TaGhqaH/0zo2wRxUq2fhagTXXsHA4cpPTw
 YbiTYAu4B/wvQDWD1m3yqXLkpaO5w5s0D0UM2/7Q7YNFajLX795tIMnA/
 gZhxuVlSz5Vm+AOHV5ULDsS3ip3j6ixxRqaaGHitFt3MlpwL1DyoLstpJ
 xc9dMIRiJndDK9jQkX7EOBPNjEOXbusfggX/nRp5gocun5AnsvjLZQ2Fw
 xcDuxKvj4Sr9Ikf6v760C3VEp1o+e156XMBBTOsdAUbn0s58jsaxKY4YW A==;
IronPort-SDR: yFLBKDmEej6+QTme1vuFq0Ii/meFhjNr47fN2uGWbp9ncC+32dSK1oAoVRd+dkht1oTBDomz1G
 3wapSh2rz9PpMYsep5OCsA847kLqaknUDKPcqgNaG7KBUapLESieUNOjXTnwJGpRK8TOb9seCZ
 yGN58s3xc3obIPrOn5p1TcsEIQGNHY22JwY6U0StmJCTlYW0y9H1DibVTlYxA1RTV2CTtjZvIr
 TTUtOOLusltXzXZHzGjEDIW8Pw7lXWuIW/lW8JUkbwtP8rXf+j6f7WPReG8MSZxwRvHr+l4GX5
 HxI=
X-IronPort-AV: E=Sophos;i="5.81,236,1610380800"; d="scan'208";a="266089880"
Received: from mail-bl2nam02lp2057.outbound.protection.outlook.com (HELO
 NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.57])
 by ob1.hgst.iphmx.com with ESMTP; 10 Mar 2021 04:54:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nmjxNKebnVdICB9ZX0nyL3DzfG6/yA7syjZfO2l3dE8Wx2FGTNyUtp4vBR3wcpwW8rAnmer9tETMWs6nubReVVjhtv2CmfcsG2hQ0WqLwD0JTFanU8pzgwTINjRgys9g8RgLz3AIFyj88K/WbpHvdK0pU3MoyxAI2ZVTte1Pbl+qV3uMPwLMMhgNGtjxAXYdidASSNRmsdHGs6YcJ0eFSvIKzeGwoMCPmPjSaWTsLEKukGTiT/wZcgohpnl2ST77U8Uhb9cf7PRaVwL1EC4/isBn2OCswBFMtZB81ycb6w0FcGBh8ezgqL1Z5l6A5Z+QovR0fErMCzwtTP8DbIuybQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Irsg38Qui3KAcZ9dDBE/10sgj4L+pIWEps2lhkGFci4=;
 b=aaj9K0Sk+PRq7ryfD/cFcNoVI3HOCiNixze7jIfZ/ZC3lIa2g9iJR9ixEBDNjpz+7eKHMhX9RG2O87c29jWOOHUEZipVgxKxG5P5r65G8fls5DB23iM76NeeWLChP53v1ILQ3y7iQ5HW4CYeUM/zOfJ+/s1ArGlKBdXcCanelXnexDjtxJL5u+PwCmVkbtWNUntpH2e+YlQq97tYDsfnPmf0cQoTR8hDBtCmkqM3cQ9QcscBfpUOs3Za9mP+va+UrOXGu96y4cTMXmF61jD0z1s7IisSEogtVUdi7j4ugST1ZRRXCpTm6jHGqVch75E0OtyToDOgJ1sDi6Mc8Az8lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Irsg38Qui3KAcZ9dDBE/10sgj4L+pIWEps2lhkGFci4=;
 b=XJ5QTw4+pHCuJqVH+bYec/mMupV2pNaPiyEY56th+BItOH+7Cz/yQmCV37Ff0KSFQux9P8+kRXYxsKn5ym/L90gR1umOIhb/oo6o/o74z2uYLBQzPb6CM1aP/pviJbKykX9Se0/YSmXtyGrrAgVQLmd8OCNCzRQF1/1ZgIh7cCY=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7262.namprd04.prod.outlook.com (2603:10b6:a03:292::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.28; Tue, 9 Mar
 2021 20:54:21 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3890.038; Tue, 9 Mar 2021
 20:54:21 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "sagi@grimberg.me"
 <sagi@grimberg.me>, Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH V10 1/8] nvmet: trim args for nvmet_copy_ns_identifier()
Thread-Topic: [PATCH V10 1/8] nvmet: trim args for nvmet_copy_ns_identifier()
Thread-Index: AQHXFKDd0Blfx0b+CUmfKhVWopYbEg==
Date: Tue, 9 Mar 2021 20:54:21 +0000
Message-ID: <BYAPR04MB49657D2071E6115C08F1DBE286929@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210309045823.18545-1-chaitanya.kulkarni@wdc.com>
 <20210309045823.18545-2-chaitanya.kulkarni@wdc.com>
 <20210309113434.GA9520@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 912a0203-6eb0-4e1c-e656-08d8e33d83aa
x-ms-traffictypediagnostic: SJ0PR04MB7262:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR04MB72629A644202604981B2032786929@SJ0PR04MB7262.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9otlBEHAB/Po7CF3xrGipZNk0WrJeJZZkHKPESS+hR0fi1Hx8aJdFd8BzcuHoyiI8vqxNTILt9saJYMo6j3Su/W2mylADOixxnWef8bbAqcQ6XM+jBVppd1/VEO6pGVtrU4vVG5Uu90VVyWSbru5rkrbEREHX24n2Z+XeWe7IjwKfjPv5aTUg5d9ZcWuFlh3XnCRev8YLwI5VzTDpkZSmc2mboX+j0o6WrjyrfI0Hnzj9NL6gEQJ+5d8lxcunMXZxmNhv+2pNCn9HgGi2xwUa9fwJB1JKi4B/Ypxxzu0zw+8KuXrWT6d91iqC9azCN7lkU4zGRxFlnhqYNbK1+a+OO8zt3H78P5GFsjVOCi/J89fsWKJY7Wapd+/GRTMaaAaQX+27RyJEzSusK4N+Nhe4A6A20nuOpoA4vthH0+rBxJrmKKQwlbp6mZbYiH/eRsl6DGTfr9H/28NJzk0imXNTJEl8/9DdQU/baOeFl7C4sNE6JWWPKm2jUxatK64J0rer18IOyrMZcbzii/6YGgX+g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(39850400004)(366004)(136003)(346002)(66556008)(66476007)(4326008)(66446008)(64756008)(6916009)(66946007)(52536014)(478600001)(91956017)(55016002)(9686003)(2906002)(54906003)(5660300002)(76116006)(8676002)(316002)(186003)(53546011)(6506007)(7696005)(86362001)(33656002)(8936002)(71200400001)(26005)(558084003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?W6cgGfXjEXn6YzbowILcBJS8THX8a1Ydpf7zlsU4HNR8t3jLa9SesZJXipRY?=
 =?us-ascii?Q?A8C4TE4xZq5ByTOTlSTUbi7K0F7IrNP+VMYJc7oOSAv6+a3i4wnCRDpAqchp?=
 =?us-ascii?Q?3SZQ42XH1IQa9ArfGjitXeOl4v9Qzvx6pofgHmpOLNK3TgIcAP1jNwC+hgvN?=
 =?us-ascii?Q?4LZ7pRnkdowAsZxcbk/Xs7G4GkfxXu3HCF7uiYsvE8BzpLEixuSus5qIQk28?=
 =?us-ascii?Q?WKjrIQN5JbA+HSDHUrsKxRHvbRAeUtv7GJCzzQW0L4BkMRdNOpOhPKR9vpYc?=
 =?us-ascii?Q?1KRucyBMZow+t2HzmO9FzT3cJc/3/KwYpHKm12CzwaVv9Ou1FF/2GBd78OIH?=
 =?us-ascii?Q?kiNSMqAUbYaVofUSndykypEwz79YUeBi1ldAQ3IEW3fkFuKGuPlQhMP+q9XK?=
 =?us-ascii?Q?sulkxa2Zj+hFegHnfdXZXi+f081MlfXQB1pJSlEBCWntH3ffBY6rue7ESWgx?=
 =?us-ascii?Q?RrWEgapwwveGtPMH3KVMK5UgZRcOLO2h1eTAHRqK3JJ+tD8WnZrv5d5Y/0Qy?=
 =?us-ascii?Q?lhRjLl1sdC6kLz+E1Vm6pAvi3hRO7i7jiYwYyrkFm02lbZoKikJ2OektpQ5A?=
 =?us-ascii?Q?s7DsjTxxhxqEILB5X6Un/JOv3Frgp/wf3uTK955+ZQwU+EtUW8lxJldFk7Ty?=
 =?us-ascii?Q?o/qRT8w1Z/NVOkfuXBM8coUDpF5PHhfjijKQOMohlQxLBiu77CE5/zu4F2xi?=
 =?us-ascii?Q?7GiIfkD8/DnLPlKkbP4Ow9U8Cw0wLY5h5gbVyAXAm34iLKH0oIIQbQr40W70?=
 =?us-ascii?Q?0M3QfEv1aBYskQG3qxDeLIn2TkTuOcir+4R69k20NVhqfl64acNL/VJrDa5U?=
 =?us-ascii?Q?W+kbFW4dH2Dw/CMOCe+5uVwfe3ec/buoQIyTvOV33BwO468d9f/+qf8yZbKX?=
 =?us-ascii?Q?LF6rxA0DUzthrvk6Zlx8J8kRcb7eE/rLvhhZROqcpwt7fFB6dAEcc3O3fEEG?=
 =?us-ascii?Q?e616g0x/VTowduX1sGOsWm651A7FjJE0eLQKrLsTptKlGpLQtXJk7b7ZZ8XV?=
 =?us-ascii?Q?6P4/1gD3aaH4Mnn2SRUOJBDsTuy+PEvtJhdNX2N3+jKU32jHeXhBwcbrcEqm?=
 =?us-ascii?Q?x9BbKcy0v61rcQEGgKI9fRV16mtZCf4S5bZj48m0gMvhviJ1bE2aOEhBQrf5?=
 =?us-ascii?Q?WN9KyhIzRv9BzHEyYrVrjMqATJsG6SvAkg/9nc73H3CNplbaxaJJPZwOXtsJ?=
 =?us-ascii?Q?+LFWnQESu/eE8136wCYcxpKfqLC+sA8vKGBnaVHVXr4DORwlbcd5EuMTsUxU?=
 =?us-ascii?Q?n4kcUJ5gVCBsulkhsD+I+cLKFnRVXgqUsmhOQ/Lb/we6m+vklehbflaeJ368?=
 =?us-ascii?Q?fXyjGPCVvrLM2l3yk50etMFz?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 912a0203-6eb0-4e1c-e656-08d8e33d83aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2021 20:54:21.3331 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QVJbtWmkfXjiOFCh9TFRlEI8KwJqFys8KKpu92t0nIdGKjU098f5R47b3XOfwvEzvzDVQoDvPCq2lm7V3pc47bXBRL1HJxAWCr0iKzd8C+w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7262
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210309_205439_078581_CDDCA9A0 
X-CRM114-Status: GOOD (  10.11  )
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

On 3/9/21 03:34, Christoph Hellwig wrote:
> This looks really strange to me.  The copy function should just do
> the grunt work, while the policy should stay in the callers.
>
I'll drop this patch.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
