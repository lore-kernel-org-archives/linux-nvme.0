Return-Path: <SRS0=15CP=IN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE97C433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 05:01:39 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DF5264E33
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 05:01:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DF5264E33
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=KFQpZrvVUkieYsBdbcdQqBI2hwhRm1Qmu74ZZLxWBJw=; b=f7/ITpBjug/c+Hh8kmDE6WN3u
	23DMZrO791Ehuzo44vYjz3sA/bMj5DR7ERKfXZ5uFx5AQdmiXpgNJWcQsD9EoHdPcnfsVrj20SR65
	E+UOHEYBd8v/FN/S+JwUTU0fuImmaCk6B+rM3zOHj5ogxY+KoacGcT7KOATmGtrFwdeJoRsp+skrQ
	TXVM2hUH4RVFhMWqzJqbi07+KPOSbwKJvoAceTM/aUnc3RtKj1RJYnkymmTFwcOpoXA+maa+MDsdJ
	jXWHDEY/5N0fFYpxkyBZK5iPAxByjmsp8KNDeAhxUb0UMeQVishrsloQh1LJQcSG6crow/BkUeXsk
	Yqojmv5Qw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lLfM6-00EuIc-7g; Mon, 15 Mar 2021 05:01:26 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lLfEO-00Et3t-6k
 for linux-nvme@lists.infradead.org; Mon, 15 Mar 2021 04:54:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1615784008; x=1647320008;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=6WbV8rVB5emx1vzPI83hIqAzxpuTalmZLaLJFolJcO8=;
 b=JQ5kDOV+68S0DpStc5licQV+Fb3so9IN68X15K/NcoplV8kPa0i23yk4
 q4cUu23nlMTO2qIZi7B5RNjTuxAo8NI3rD/bOlup1pPZ5GAyBHQGGFAbj
 hK4YFJR2MKdy5nBXN7BAwuVnez4f3Eq3r+Vx4XdXz4EjSluiaYCkTzT+K
 JFOdTYG2okZfa9Tczn9oDKpu8Ewggu1Ls9w1wmIdRmigGrYiAk+r5rad8
 BMLPVMysVo1efaaWfvpJnwcbdaLid2r8TKHlb9hTKxDYoc6AhsGhrGl40
 +KjMJOyc/brWqnM9Jbj4Qw+7Dak7U4yFtqJZKzEjwaEZlPxqNeSVYeanJ A==;
IronPort-SDR: uCOAw08cv2cm9JjLdezpPLe7TGCfx9bwq40g3zFyfd4qjx+2J5q6IWZT1WevgOrTK55mJZJYTR
 yeOqmPiqtvpv5rYKSupPV4ww9xyj4HIW3hGgD/otr86Ic7GPG9AKd8AeMcLR7XsaGJSljBr6bH
 vwZ43aQneEmNls4xrPdTq8FldEL6X5s7ciQ6+ZXyVaOu1maIIQbtTP5mKq/O5gwdmletTHGkLp
 o8OU0zZ64/ff6RtZMieGcvge47A/5dWca6LPjTBCo+kE9Q2jKzEaKfrhZRD9ZgSDpZZirNNbzs
 eLA=
X-IronPort-AV: E=Sophos;i="5.81,249,1610380800"; d="scan'208";a="272847216"
Received: from mail-bn8nam12lp2173.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.173])
 by ob1.hgst.iphmx.com with ESMTP; 15 Mar 2021 12:53:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KXs4tamu30Q86yPyy2WKlXT7uwq3rwRFXjkJJ04mIiumxWiLolOcMgXckyVybHXDlx5eL612jettYp2EJymMzjZoMEgzgStRdwtbcLisFBBMsPK6wSBTA4CXHm4apgkloHSWv3BcPRSpXN/C8k9Blx4CC7ebtKqiYES8PN94gAZG62wyE9NPmPf0CFUdJPvLZcxTCZwCOLvc3A7H8FUmn7jDWPn7w2A6LZgH0n5psv/0dWTcmaIIHCkluE91bnXsuhYlTOibR+6n1sV84nD4a9i1EOQPjTocdmhE9VDMqAr7ovLvaH8IGuyfCZSYz5cT3lWFWLoNLqq8JFjKs9NzXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1FbDN/2b69nQieQonDaG0yLsAV+RxN2b6nQgRVoaWo=;
 b=B0WZfyw3MIu9hxIlOSnw2zwzKLFelEtsEH2cmOz+26ucR93HajLsF+yLBf7nklM/eqobHeTRrGLMmrrw4VaMuM7fPmftwRcFY8e0/akQZfweTg88oECm9cXqNEvsxckVm1+ghwVckI7v6p8zEQcW8NvCurDqRWYVNn/Dc/HlQEDrLblx8mmj/OGDo2Kn0eNNv1bOEk/CoXU6yAupFxsCxKiorwTFFwue3sRW7tisVaIwbat65SJbuNyWXqFvU40tGLzN7hAjRcYC3/jV64xyhGbui/eXIf4s85d4K/HNGA7nQ0NzSuO9m/UEPjeiFC9Ptz8fXuW9O1Ym3g7E5+8YWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1FbDN/2b69nQieQonDaG0yLsAV+RxN2b6nQgRVoaWo=;
 b=ZIeW23yA8Dduvs4d4xoUHYwlhBtzIlhYECexVWks7gEoinC9wQj5jJmCPABVOJjdK+DwYvueoVY8g1pK2qXsuKEA5yZ0lZemxHHuRihbN7pQOXEvAJ0an/Riw0bTHDKOOk+isojLgqE+YDRIT5jRit65Dhzx1kC4ZvbsqzEjUHg=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5832.namprd04.prod.outlook.com (2603:10b6:a03:10f::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Mon, 15 Mar
 2021 04:53:22 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 04:53:22 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Damien Le Moal <Damien.LeMoal@wdc.com>
CC: "hch@lst.de" <hch@lst.de>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH V12 2/3] nvmet: add ZBD over ZNS backend support
Thread-Topic: [PATCH V12 2/3] nvmet: add ZBD over ZNS backend support
Thread-Index: AQHXFkZtzlyRTj6MdkG4iVwqsOEFzw==
Date: Mon, 15 Mar 2021 04:53:22 +0000
Message-ID: <BYAPR04MB4965377CFCEE24912A9BEBA3866C9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210311071530.18680-1-chaitanya.kulkarni@wdc.com>
 <20210311071530.18680-3-chaitanya.kulkarni@wdc.com>
 <BL0PR04MB6514B749F68EB412FEC032DDE76F9@BL0PR04MB6514.namprd04.prod.outlook.com>
 <BYAPR04MB49657E04A5017F5C31D4EFE1866F9@BYAPR04MB4965.namprd04.prod.outlook.com>
 <BL0PR04MB6514F4EC40A62AB4763560E8E76F9@BL0PR04MB6514.namprd04.prod.outlook.com>
 <BYAPR04MB496561F5A30C4200976B718E866C9@BYAPR04MB4965.namprd04.prod.outlook.com>
 <BL0PR04MB65148249836C08C94D2A4A15E76C9@BL0PR04MB6514.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8db91b96-0b2e-45e8-3683-08d8e76e42c6
x-ms-traffictypediagnostic: BYAPR04MB5832:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB583299E6A3A39E37A6896A46866C9@BYAPR04MB5832.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DKSc3E2eF+KPmhuCKBCD3mivbI4oy0S6xqQi/uvxGncNwneK2mdD5ArcwjF54TTKh6NFm+msxOcyowDu8pHfS4s1V47hPVzZ+BVC60HHRKQeLmgJrFGU9wWx7TMXr/jeSivkVdOvS7SmMRzNrLsfxxYEcVrQdu4gcndSSAZ3Rr+CsHkUMhyZsFALZ9HiPdYSnKRVE36IWE/Ce8AeuxaTsNISXo9yqPSX3evEtpzkZ1a/wz6waKJLaqz5OlH34Dez0SxXIrCDUzhD+Jx8klj8UCYYqyQWYCsBWi+lDkeZBCE6EMv7GOpySBrWddlidMKWQg9bAAq3ZolxVUlARlu5WpfagwIpfqRTw8J6FNmEe1F//EBFgF8lz2Q5HWmeEXC/D3iuf5EZLOq83fehunnW8QdCGEjFInf5SzPpw726Hh3LLJK2syKOKzbw52Xc0HSj8BWxnTbXK0L+hQEm6ARKA63OWRANtVLtDDtLcNaQOqLSnzM8nDlL9iUj+kX99f3yczoeTxchu6qIEnrACeUB4ObsjGqgpt0Zo2HyboutR1Dpfbe/ekv5UM/g5/C7NRay
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(39850400004)(346002)(396003)(366004)(4326008)(33656002)(71200400001)(478600001)(6862004)(26005)(9686003)(55016002)(86362001)(6506007)(186003)(2906002)(6636002)(4744005)(8676002)(66946007)(91956017)(8936002)(316002)(66476007)(76116006)(54906003)(64756008)(66556008)(66446008)(52536014)(7696005)(5660300002)(53546011);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?QgMLeqmfoClxA5M2UstQlZiSfQdtxH1D/5UycfK2tBwbj1NfA0p+4a5jLzsK?=
 =?us-ascii?Q?Tv+5/RI+erW4V2eOod4KjvhAwgr0NjBoWNl3lIG5GIxC3vADKYCVyVWapJjL?=
 =?us-ascii?Q?YtnqlAwOVrQaSlmfcilsESdWw8GoZSsZLGWE2rUB/CwHRiZn9E7DzpiDMzGQ?=
 =?us-ascii?Q?swWlUQy7r6F6vhS0hyla9Ren4duy0CgQKd6C4cRUYVKmC98ISskBkLBeLZrH?=
 =?us-ascii?Q?ZgVSeiag+CgV1dzI8WGXtClv2hFKmAApAWuU4S7zV1UfiwlbYz5jj/TnSfxg?=
 =?us-ascii?Q?RT43VxkWQ+u2R70+Psqbv0/8uveaeayZ7G1A/qAoqUfjy3LE0byTtmeaqFBV?=
 =?us-ascii?Q?zOmxuyIyCYP/OSUW/rVWiSrFLwxnkTpDWvMTsqssJoEdDH01XzGFeOwwXKPR?=
 =?us-ascii?Q?3XS/9v3bJ+49390Q7IehK50bsaIh/TEtYMm/upNDfTTjWHpU4u/ZFETqrTJO?=
 =?us-ascii?Q?iOEgQfCQIFD4eaooDHRpS6kwU5TOUtFc1cm7fNR7k+4kksrJSeN434uqgsfa?=
 =?us-ascii?Q?XGF7KHNIeDGOhGVEjpuoKukXEvpcazM6wdSm8B+RXpjE9iOo6gE7sA+Mn2Ph?=
 =?us-ascii?Q?49Sfwi24v6iVl/5/tBR3X5HKpLLSfs1ljYPwbr5lE487HxeEM/wxbywlxGVM?=
 =?us-ascii?Q?NNXVwd7YVIsZcQlwVb1Zm0y//adUnCFlyla2jomrjGvGPJ065qWKTFEW61vo?=
 =?us-ascii?Q?1h/mrpZEdTzx6+X+khzAGi6n266EWwQ3X1fuAqcfBe27mIW3JpZnQ8V9vryl?=
 =?us-ascii?Q?Vy5DhlLSgXuqsBB/XZZX57j0FTVT01amAB4a6OVYXTSEmUTHTgkohwRAq9DX?=
 =?us-ascii?Q?17FoPb9P9JkjbUUHKKawoC2ZhvMfMQyn1NkzpNxzwnfTtPzFPGVcL9Aetfej?=
 =?us-ascii?Q?TLM3VgQNRQi8o5xbqzNEgGJM5G2b638fq4kYXzIeeTny4dU/TxNW9VMsuFko?=
 =?us-ascii?Q?x49drXnjyqArj7bp1OI7N2+7cdBMK1hpMAqN24CqNADmM18poyb5OhFrccu7?=
 =?us-ascii?Q?pVqXEPxk7G9qYt9dB8D5sgIPbexM1wl9ux+VUadSjGIG8ac0cQ5OyRhT0aEB?=
 =?us-ascii?Q?uEYMU9JvjKN1+12XpVPDGaCisJg6JIKn315FxsBPCs0XUgrwIzoiiypLRgMH?=
 =?us-ascii?Q?P7xVa6FUMYfT1JG/+/YGAKovEpqqaC0PRJK5IKTYfO2rvPRUaE6fVZZxmG1s?=
 =?us-ascii?Q?PyJsxe+Koznrky9LNMVzE4j7WHGLdgDb+am2IHgKgJDKQnf3+2lAOUxDLTi9?=
 =?us-ascii?Q?5HhMhV5haF83blGnKcxPWcMZ7Vh2szJkjDrQHnOVmpKPMZft9wj0AMYfuP8C?=
 =?us-ascii?Q?VeD0duthgew8zn/Deyw+DfXX?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8db91b96-0b2e-45e8-3683-08d8e76e42c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2021 04:53:22.4517 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8CG2KduMkhWKuaJnRXDqkNYqBT0r+r0SL+P/GNRBbwSfru2G4/kfK/3UmcRoXKy0Y6s6YvRdjpVv6i9Ab5uJ6OPYYudi+aIQoGXck9AMV5o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5832
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210315_045358_772030_63193C4D 
X-CRM114-Status: GOOD (  13.56  )
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

On 3/14/21 21:09, Damien Le Moal wrote:
>> Regarding the passthru commands support following are the non technical
>> issues
>> I ran into, it will be great to get some feedback before we proceed :-
>>
>> 1. We don't support any passthru commands for the generic NVMeOF target
>> backends
>>    (file/bdev) for that we have a dedicated passthru target. ZBD backend
>> is a
>>    generic one, so do we really want to add support for user's NVMe
>> passthru
>>    commands ?
> If it is not supported then fine, no filtering is needed. But you should add a
> check on the report zones command received by the target to make sure that the
> reporting option field is "report all", and fail the command if any other
> reporting option is set since it cannot be honored.
>

Absolutely will do that, thanks for the quick reply.



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
