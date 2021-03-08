Return-Path: <SRS0=2ZV3=IG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED9DC433DB
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Mar 2021 07:17:16 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19E6A65146
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Mar 2021 07:17:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19E6A65146
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=Gm/a/uUbrczJoX/XLl9aeisJCAPlho6XFoBtAZhDFoc=; b=M50D93IE6iWfPHnbHkVJned3b
	44QtbcmG4xzPLf3c5mHd3+cSgyWETsisqHDG/BjJxMAPF6td+2OVNfHcHK+E0266RyGXJfMubcYPm
	avQmslerDuTEMht1kzTMRmhJhel9+Sz51ROR48k4CeasPxDTKScQXE0eQmqZi0LLFouIZIT2Ujbe7
	X14EAcmi4EZMV0qNrJTepsT5Xzb0KZUDlvuyTbdjEmtpahtQJIcD+CZjvezJhfofrk3iUA813z5S9
	ZpMHyEfMnLBydVGhZAJbMTyP2lf7s1kLHogHPJwISyctKET+naIIk4BPFTGsImJY4GpuuGWe3i3Zu
	4AXLUnzUg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lJA8O-00FgTm-RN; Mon, 08 Mar 2021 07:16:58 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lJA4L-00Ff7p-IT
 for linux-nvme@lists.infradead.org; Mon, 08 Mar 2021 07:12:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1615187566; x=1646723566;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=HeyOYyiFSipUCCY50sOzh5EbGuqKt61qj4BCwMWeJUM=;
 b=A6AdTh/rLLI7cnD+h12s4Y0s1qD0ognnGWQNB0B4dczXkVGCpFFeTGUr
 avScKFzzIvBWSQa+fGl3ZYh+wGt1HOehK+EVG2rwlW+IN41mlQSTWhag8
 a+rgpAmU+gYCL0MC4puRAipqP5Anv4qpkFXICfavXObXw5hb8qOqMinTv
 P9YdWO5wXeOWRR5s1G7jl6s1Of5KVp0NWhCJB3r7N3e9warl3Xv9ksjCI
 eSS0mMj9tTCA2yxCbSo+c6JU1kbBTr0Sarlers+k/MEOW11ZQ/JyHwLa3
 JfT6Gy8yuQKQ7wK5G+OBnFKNG9uF6faramH9ee6uaKv2snVuqf+JlHlob w==;
IronPort-SDR: a/kzrSGB3gYZUgv18M4saHluxU6g+MILBTjUAoyR+q7gzLgbraDZENNIGQ4jDVQasFHPr6AZ6c
 lZ7FdTiFJXyAq4MZxfsDJ+B1hLp6UfjP6fpafNqpprcRRnTsBBphqRu2FAQOFwfKhWj7w/vwLn
 9BYFiHlsT7Q+1xExqCIgKSxZG/6SiEbRB5Y8hg+bzLjdcCkf3lcXNl7xs4iowBsVhTcJB0p2J3
 6DCIwYECWNGXLaV5tfSdn4slWgTRmAmfrvFN1gClMY0SD7u0i2hP0eMPKaObLi+s61SE+oj8ZZ
 mVE=
X-IronPort-AV: E=Sophos;i="5.81,231,1610380800"; d="scan'208";a="162755602"
Received: from mail-dm6nam12lp2171.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.171])
 by ob1.hgst.iphmx.com with ESMTP; 08 Mar 2021 15:12:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HpvrrgHU7CoY5MXvIf5hFuzQH8+Db6ri+uFOSRbhOs9Eqw9J1xnsHyjbugzk4g3/39S0IddvfVs1q/jqoMMXgtF8vuid93FvnosuQdR7WhyB5A73Fb+JtlR66boPH21OE55G+iMv2J9UkBmgOJDtbJz4R16v2w2b072JfbyXWnNbQ/Jjoh66CQ4n1rd4frTUoVxGRnLn/cdtm4OMdqVZAzUlIw2OyZ3yzr1Vh5ISoH8RcJHXORC3r9/pSaDw5qGMfF9ZITi5vGetB51iWBPOaOS51ze+Vpzmtxx2qd4hFTQMJyH0uOtVOnFFv9WbVA+s6UA7W+6zbjTwt0Id9AVm7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HeyOYyiFSipUCCY50sOzh5EbGuqKt61qj4BCwMWeJUM=;
 b=LvneB6On78BHUGLGgx/DkDKUFbi6TAMACOliLByJs3B0wA7imexAIy+B6XZLJdihWzrWtJSClNcRO98U1wbNHrQMGoIwFqR0bXx9+XnARbgSUPn2qHJkYImcFMdpX9wdheOXhQD9wlF7GmDZnK0F7oCp/hewarXnMKIEMCrTyTYmumJgQ5XXS0JhCxU9f4ZbRTvwWOJ5rllc59lOjnrMdss16TlI8R/iJMJQRlntR9J9O6RtdtXaObJolPxsCD7dUqLJPSVjTxQPsU52xMOI5c8phUasevYC++Hc9bHzBNh7F7BZeUIrzx4b4tHeOV4zQPR3G3YWzHIG6dZkGPQskQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HeyOYyiFSipUCCY50sOzh5EbGuqKt61qj4BCwMWeJUM=;
 b=sZ1M7XdNJvYImEEAZCvZFmnw8Wv7AeJOspju8aDegG6lr0mdA9Z4jeI2UV2ydUsJtSJNMPPVfqhma0cgPXaY0hseWiUakZahA21Glf2dwH4fcpIk8kfwoUoqX9RBItJaWdFU8W7jrzIV2pOSHz8uAi3yX1e1FS5RGkjAoYgqSvk=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB6023.namprd04.prod.outlook.com (2603:10b6:a03:e9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Mon, 8 Mar
 2021 07:12:38 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3890.038; Mon, 8 Mar 2021
 07:12:37 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "mwilck@suse.com" <mwilck@suse.com>, Sagi Grimberg <sagi@grimberg.me>,
 Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Enzo
 Matsumiya <ematsumiya@suse.de>
Subject: Re: [PATCH 04/10] nvme-connect-all(1): fix documentation for
 --quiet/-S
Thread-Topic: [PATCH 04/10] nvme-connect-all(1): fix documentation for
 --quiet/-S
Thread-Index: AQHXEiDL266SRWiHdkqa4Msj+Ktd7w==
Date: Mon, 8 Mar 2021 07:12:37 +0000
Message-ID: <BYAPR04MB49650C82700B9A91094C6C1786939@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210306003624.21102-1-mwilck@suse.com>
 <20210306003624.21102-5-mwilck@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7c3c0b6e-f054-4699-3535-08d8e2018e14
x-ms-traffictypediagnostic: BYAPR04MB6023:
x-microsoft-antispam-prvs: <BYAPR04MB60237F9A2DA0B44689F7973F86939@BYAPR04MB6023.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:506;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 34eDYOhp6GZ3/bcm8uPFvrcyx9Ilj0aDS8qntW/qPtSNhc7fDFJMNclXTYNop5khCcjOrnnjvd8M78XEeb/a0UnqOzSqRN3GWRdVsXCMZLr0PPBLGVxJ31/A6PaP/Lb47WbXIlqLkTjMOs5dHWTmbRPVoi1mZEzDY7D4ffJoV6rGdwCB6PY6/0lhHWgHKn6Lu7fWZg5IJDe6LETANxUqP3WeyssF/nTT8roibWQO6fpPyLZHpxH9rthwTGzutfLjzN15IUOJYFc0CQcrJwu8WbqCuCrZCdfSboezdUtw7lCCRbXC8yReB58TadFYQ9oJxKj3bbJ5JLhKKZRtlrT3PAoSE70b1P7PTCkTcZhjuX1YqWc6BKZGkT+7eVur98QwFuE4tX709BwtIzny8/HLpMaqviZaHqCohlJ1nI7wdInaLRD2NVH9UtRl3NkH2MFbgvv5Cd8z7iZK6NMWL8zcPfdfLuMfiKEYME85Aak24heCnZAc+WQXmIeXoolPSeiFBWk5IVcgJAB1OHJXHYE5Zg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(110136005)(76116006)(54906003)(86362001)(66556008)(5660300002)(66946007)(52536014)(558084003)(8676002)(66476007)(66446008)(71200400001)(64756008)(8936002)(55016002)(26005)(6506007)(316002)(4326008)(53546011)(478600001)(186003)(9686003)(7696005)(2906002)(33656002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?AbVXXcaH1q25J5yTlpZrJyWM0BY6ud7iuamhN8HnIAjEbmFNgNDiBZS+BMaF?=
 =?us-ascii?Q?Di0oPbRt6y87HljDGzmVdvmVkvlk/DKaKErQUPfCF96MC+vxitrjcQJm2Uyw?=
 =?us-ascii?Q?zFpWYtb7wXsB5cvfoQMWgAFX4hm0DhSuBTSlqdvmnfGBMDrlLIbmoFoSoWu4?=
 =?us-ascii?Q?e2LTOG5l+x/udKZdsr6JniMBKDVdx5+bL+/N7E52afqRQUaolSm9K51eaLwJ?=
 =?us-ascii?Q?XIuxC+E05w4stMKBWiIYoHhFsMwGIokz21GmVBKAAgztpsOMOy1eU6utcH86?=
 =?us-ascii?Q?3fhw6rzYNusESAGUmZ69/GeqAoKFFFH+vSK8i6/6LoznaBKuKCJydngvfAXJ?=
 =?us-ascii?Q?IO/sEYSgExJrPXbHUy4Y/E5i0CEON3MGYehnwlRG/2HBYOgn98XIASjXl944?=
 =?us-ascii?Q?mYktDcUUbv5qMFXVCTbq8no3e+D3EUqYyR7wqeJIF7Jo9Uih2JXQdKdTf6vb?=
 =?us-ascii?Q?EU4fJbYnOdxpp6ps73hsHCtunYi8xHFJyHR4rKsOwIUtKQL+/2NU2Zy4n4Dd?=
 =?us-ascii?Q?Cd3HQKGeu+ZlTQEUJmAj8c4MQMpd7QFCKvKU6LXsFoT4Gd6X74m1CWv/ao/N?=
 =?us-ascii?Q?zGwzD5VlqF439EDYV3ez/mwgMp9wMVRS1+ASF7DjgoxLPbI1TYQxVmKavyxE?=
 =?us-ascii?Q?yosUa644fUbrXoONS0WyEeSv2kinqwBuNJdqM5MhAiaY+wkw/nK/cnOq4l0Q?=
 =?us-ascii?Q?+F0nNC2Oh62NZDOaqcuDc9ZjAGBwg6ijBLd8ff5NdA533dC6F5njeiRu4Ncx?=
 =?us-ascii?Q?Am9pmPS9noBkh21+1SoIYaOXfjPjC7z0EdRI3CTABaZ2w3yHE/AjfaExGr0q?=
 =?us-ascii?Q?CRz5IrmuxM1544WwNh+8KZ+WWTpuzQB/gKULnKXG4i5bsPuhdgwVFfFDTxUu?=
 =?us-ascii?Q?SKQI6Mlz4f+hNJ9jO/eMNs7u66oKYjFJoalQsp0dDm+Z7zJNXIfOdgcZM0M3?=
 =?us-ascii?Q?3AEEDBmhz5hGOWsR2UZBi7R2DBT5Pm/56Op1/xufgzkqPiQ2rnw9yhHkebyK?=
 =?us-ascii?Q?pUNnUdcuRdommfSEDfwDmhleLnnj3/vjFzlaMyVGpC0Z03IhYWSPJGD7GdzS?=
 =?us-ascii?Q?acv/vb8iCnzxCowyHwUG8BZr9ik2wXoWnp9mB4lG2HzlivoIgCtCwVqxhEkz?=
 =?us-ascii?Q?XbeDCC9R+cPhakPbmhGW/1NKu79bedFGKfAB69i1Cxvds/iQaW5DamYAF1iL?=
 =?us-ascii?Q?rSqO+nNGQ2cQ+t03I5COXZW/E5on7gdLOxj3HRkzL3bdIFsyOiu8fmT/pqcs?=
 =?us-ascii?Q?Dz0vqeZdG0eCTJEKCDNPdA1nqDZZm51qwvF4H1IUpY6+0/IRa9Mh8XcPO0Ys?=
 =?us-ascii?Q?idhjxc5Xw+T+TkWh9TuVmVch?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c3c0b6e-f054-4699-3535-08d8e2018e14
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2021 07:12:37.8069 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H5Ls6k75HhEpDnnuxoF0rGuimoxJlNEefd2BTlk6l6jbPSB51xGGIy5tCcZnfZR2evOYx+KZLSndx49AasWW5gL2qNtjozKnFXvJdfO3+J0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6023
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210308_071248_398586_A3BBFE1C 
X-CRM114-Status: UNSURE (   9.76  )
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

On 3/5/21 16:36, mwilck@suse.com wrote:
> From: Martin Wilck <mwilck@suse.com>
>
> Signed-off-by: Martin Wilck <mwilck@suse.com>

Stale date reference 01/20/2021 to current date, otherwise
Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
