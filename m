Return-Path: <SRS0=ZbIm=I7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9078AC433B4
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Apr 2021 05:02:57 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6A3F610E8
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Apr 2021 05:02:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6A3F610E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=h79QFR+XZso58RJfInZoepPVw8nXpTWaNEXETyut9Xo=; b=aDSnZ/9eF5TEzR54XE97pmDx6
	NWjh1hdl9q2VU7HZOJvZa6XSpZeOdowrKOUqEjs1AxgStq2tX7N7ry6GQ89VrDLuK8koJAfoOWzKL
	xoNJ9GaBAiOnFCUnVTWndTruye68plNlskVZcJcPfHZX95YQ6nxL7orEtzs9wc/OrSlfDb6DyMMua
	Z/4v4p+UTjbcDag8yOE+4EKl8ijKVv7mHU4jl1+zEfAhvzZ9oDajgPfKRnQq3g4MM98udYVRyxu9t
	4XZnNJBo1cZeps6c9uVTINOkpe05DsgaSoxeV0J1zQecrM7jitAWOU0NXgULBpd3FmcNh9fpQWpXY
	yiFISqSEQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lSBwz-00BybQ-Iq; Fri, 02 Apr 2021 05:02:33 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lSBws-00Bya9-Gm
 for linux-nvme@lists.infradead.org; Fri, 02 Apr 2021 05:02:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1617339744; x=1648875744;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=anP7LKGcLjq0S17DR+tXImNvPviKIbf+P9m9s4yEVYM=;
 b=YiNXns9gtg5Di247jnFN7No04nC/wJ7CaAuoJMbbSuWjqLgm9U/bsbRR
 1ZzWp0gzSyelNyjmUrdazfi25wEBGAlXwWU5R4w312YyH+u0IBN8k0OwF
 +WabX3WgIBITqn0kt3sGdjNg0lum3jMuxmFv2nydNk5GKpPWbkGf4klgB
 TwF3xU+nIjXMnaI5/32EOIVuKo4VXpeYk8emmK0iOT4r1vEk1Bj+doeSO
 cT9MEXlJ2PJwAJqueEFIIybcurL1sXHAZ2/K5BIkbNL3lsKLGFt0yaDaK
 v3T4DQr+Y4j/EJwir3MAUMHMH94SJBlwJzb95zuuBnxZzAT33zcrwlyOM w==;
IronPort-SDR: GDiiBGSphF16yBSZXzpRm+slge1EkpOqs8GIVdY+F90FPPq8coOE1i5wxo2QXyO6io9ttYUNG+
 VXgh4HtWBtUADTpiSFiQoB+BdZ5FJ3UOxRn8Ufp5WCqC/vDHAJ1VqK29MHSfNVXcu8TzgOYVz/
 C/9wsVTR/JzB+gVL+FqAdqLHKPEykHMTvd81rNa1Jpevv6Qkws6NdYsRAU1WH0gglXS+9QUrQ1
 Pv+a0QL6nfgxuRJoYe8CLtBlsVMrJ/5AJ8njHbqmqF34q5jHY8+EdK4pisogWzkEWDb1SCck+h
 G90=
X-IronPort-AV: E=Sophos;i="5.81,298,1610380800"; d="scan'208";a="268020523"
Received: from mail-sn1nam02lp2051.outbound.protection.outlook.com (HELO
 NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.51])
 by ob1.hgst.iphmx.com with ESMTP; 02 Apr 2021 13:00:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mNwe2z5gM+AketlHfjrA0N2Q9xql/MokLVz4tenwqXoqBKzD/Yz7rJP2bkcOyEMZHC5HRYWrYok0Y3ibfTjDoJ5QbGkQda5qkxYZR7NdomUkVU87NY9vaegbRtcVhxzZ2+EiWisUR3Cn/eIyuE+k+evz538aJf7bjbxZHOsjxbtLhLGjYPstl4KdlY6swHC5fRReoOBLmVmzG5Jgtl9Rpqv5OX+m4isa7OTF7gGCwzA5yBFY6zwi6F93RTdTMTBNB+8HnwaUdUdoUcPZiCv2vm30hsS1Grke9Ts/AfXil2vG1tyoQZtpVG0T4ZyveWdecn9DAWsBaHNmr5j99rcWqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yf4eEhkPiy2xuAc0Jqz0kK93N025C/QnYw3L+CGRM9o=;
 b=UPnXl2y3qIjqiZV43FH7aUBVCIaTy+ShLXtK5Bl3Osp8thRDxNYduUxqJ5QFMM6oqqzgQT4ctgNdaU2WmVgaoHH2qWL8H0Lqtb2CCzEqXz6DQyui2OOUzHt9NaY0XbX+o7h3imtz9DnDWVclYGatSrA/scj6/RCLRer6DJ1Xwq25iaRBYPvxX3Pqcpn7xEa2fdrX44OVXyfNi8aJnzz97xIkr4PJDJSHKbrJsmHcQrrgXZWQrvzQlS8C807QGeWEMSAbucbmBL5bnua30HLquZBqivydak617RpCl4NInS+Qc7PGMBGOp4+Mmeq2u5O5h38cLNfPwkOVYSYw/fd6iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yf4eEhkPiy2xuAc0Jqz0kK93N025C/QnYw3L+CGRM9o=;
 b=X50jqilqURBgzrkGxUYrt7eO0pnc+oSB9bcyFp4SfbmSTRguNVDb+KTlEuL5pmxPR8t+OCaftsKDK9yY16Usg4GknolhkzTBxSB0s6338ra4J6ynbmipd9HIWqt109T6xj3Fr0ePLoYwM1d6/Xr1VzQUviB4eEanwLMFV7F8QdA=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB6478.namprd04.prod.outlook.com (2603:10b6:208:1af::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Fri, 2 Apr
 2021 05:00:58 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887%3]) with mapi id 15.20.3999.029; Fri, 2 Apr 2021
 05:00:58 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>
CC: Christoph Hellwig <hch@lst.de>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v3] nvme: Fix handling of large MDTS values
Thread-Topic: [PATCH v3] nvme: Fix handling of large MDTS values
Thread-Index: AQHXJ2Ifwv01fPG1oUqmxcqs0WkupQ==
Date: Fri, 2 Apr 2021 05:00:58 +0000
Message-ID: <BL0PR04MB6514CD8EA0289C5C52A1C47AE77A9@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210402013907.10131-1-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:b95b:6452:cf2:6a2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2034c925-f0e6-45b6-b474-08d8f5944dd3
x-ms-traffictypediagnostic: MN2PR04MB6478:
x-microsoft-antispam-prvs: <MN2PR04MB64783724C674D9C91D907CA8E77A9@MN2PR04MB6478.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HExzzpDZ2HANCXkLKi32MAq1KNNQRK5BMmawocYTivNf6HPV1hBTH0CZfsLRN/FemnyXIl4rKM6OgpncGwDJSsMJLCmLeHtElgERUsyJGiGsdQWaUA+hu9aj76BJvG4zjMaSEHBLLY+YBxDasuGoWRJVtGDXMfj3QSHHRE7fB41zMqkCltriZ0Tijkhw7Lgltt5kVdOtFeWmW9pgAHug6lvxcX+P1g7o8Rb153zAj92S7JNkXrmRyQsf+k2mfvyAr/YLvErD4UstD7gPR59kQ3QPRHGq19O3bSgHYEfMvc61uiyw2ElxP6PZEaZl/N4qr2Sc9SSqhjbqm7yEKoJJJ992xchUIBoKKAAG28TH2RjKa3K+3zpua6XoV2E/W4/YPgrEYgsieVu4/CQHmrEea6vtApYmeJoV/nyNhJCWOBs/93CuXcYcPUtiaR9eEspYoUohC+vO470qNrlf73Z3XFlLX/LHayp9l51//sguHMRB+uIkoaWNyjuWJjVWnmm43s8j4W9l8CeLNUrHp2goHtX12FdMawN+czYaWxPdKo40wieJZ2Q+91k7apM++vTP1PuXSySVKxGLxpkLcKDf0LqikIWz9+zhaL2MPZUtjDkCF4UN01nSGDpcLqp/BOBaLSFJ0dnN6EJhDOzrF8ZkdDxx3cCW61lCo80K5SteTgUozQ+CzCNkrKlAGYswM3cZDrcwdbQn/zWxU5ca7MGvSuftcU5PI2Z0ksxQPVjnidw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR04MB6514.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(376002)(346002)(136003)(366004)(33656002)(110136005)(71200400001)(52536014)(54906003)(64756008)(478600001)(66446008)(86362001)(316002)(66556008)(66476007)(186003)(76116006)(55016002)(66946007)(966005)(83380400001)(5660300002)(8676002)(91956017)(9686003)(6506007)(4326008)(7696005)(8936002)(38100700001)(53546011)(2906002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?t7lCKGm+lSyo3pOU2eqsiQ1ugTNUVu/fwdX70tplkeYbE4bm176qcjWBGIfs?=
 =?us-ascii?Q?7L4wArwQwfoSg6VZhKusTaBDZV1LJ3GMD2KNXZRtOd+53vyYLTzBrIrR2hXT?=
 =?us-ascii?Q?Qj8PlagCu9OLgvcx5l4J4HXCOOjjndNNXXSvpVUuC2wtf0onpjGFk9LLoKzy?=
 =?us-ascii?Q?r0AkBV9ZJPCgjrW1Hn+BLN1N9mcPlVDJJM1HRuyF2fFkFXz1DliBhzNh9bTw?=
 =?us-ascii?Q?VYmdUsjR2BPsHzE9PUK0EzcS6IozdGJo0i8K+UnIk4Fz1t2J3G8Pi5YG6Hxt?=
 =?us-ascii?Q?+m7v7fs8qPDB7Pkkxh8TDlyHq2B5BDscb4Mko0WT4r+nesWn84y2SdkqC0Xm?=
 =?us-ascii?Q?fsScIR8cjwv2TS6/q8CEatC1zLZC6irZfJuCrCeRgErtCgvuX10/n7eyHhvK?=
 =?us-ascii?Q?Onk0OgqX3k9Rak1Ri7diQPl+odzgY/0B9SCCSGIs4DAaumGCVRo0eXaM2PHc?=
 =?us-ascii?Q?Fj6T66RwUHrsLnq+XQTvyJ43tybrcmn1l2CeOmzjx8aMYruUlCRRt7Y354jv?=
 =?us-ascii?Q?vJ8nChjckEf5F2/xEzs11n3VSlPlmTWVBY2foiQUuKBpB95hqDsqBdNAHzCZ?=
 =?us-ascii?Q?m2ah4Xu4ZhcNTikvQhnNLhQ5n10D/2swv7RpT42i0eUM99MvQinsOEknvZSM?=
 =?us-ascii?Q?pvXU0nB+X4U9plYikNG+g9P/gCGD5M3Xg14pDWb69yZHUqVs5ceirBNs3w8H?=
 =?us-ascii?Q?yT1+XlkzoYe+e2Bha3JVaDQVv7ECIZVGqPE55WHSyJ8xhjysIXgVvOBC25a7?=
 =?us-ascii?Q?eAfHwBHbDcZd7zELtgXCATtshFuJIlJIfp1ezdRmE3q18R3NZJISPtG6S+22?=
 =?us-ascii?Q?yvojzEXJ8PTw+yiu25wMaOgEWGuPlkeciV5fK6vTKF6TUKXZcdb2RgPNS6ci?=
 =?us-ascii?Q?n8VoHY/H6Shl5nCRAryeL2g4tItofHxCamnzqdKVsag2Npogytr5FLsOPW8t?=
 =?us-ascii?Q?unZJyMOChRnp9/WXaULocREaL8bwui5fluF/tCrkszQgquV/f4ha5OhkrYx0?=
 =?us-ascii?Q?AOjWY8/RXBf9Ib+kTqR4fFXATH+uluSrzN71oW5nKHIYvmFd2SZmcpbacfee?=
 =?us-ascii?Q?Hc4SZ3vB5SDfvF074wOxIkBrTjlt1NfpdWrNBFWT+68Pxrb45tjZoS6Jq1ol?=
 =?us-ascii?Q?+Ql3jg6ReWxnsjDteSTJUcXzuS566yxsJgVRH7Qj2GAgqvJMjjfrjWFGBRz4?=
 =?us-ascii?Q?thDqDrO1c4Y0lHkBfrs23rQEjTo3NeCjTQyFGujgIjZNpGxVdI+CZNBkP8PX?=
 =?us-ascii?Q?cEkTaEJGUoF7crS2i9KNUd4anYucHs+OD0pmu9M/VDIMOBbBE3h5WPOugheu?=
 =?us-ascii?Q?UY9vHAjxwq0c+bJ6VOHh7kKgQNrPnoWRohfaBzztwl4jNm/f2YAaLDyiT1ip?=
 =?us-ascii?Q?j1pMOQhwwIH5gdOUHL1N7w9LwUJaokxnT4Opanzv7gYPg8XvjQ=3D=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2034c925-f0e6-45b6-b474-08d8f5944dd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2021 05:00:58.0877 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OhMfJed61XJWqg5tmUroOMTkWhaSCwU96qnv1n3W8XhQMWT0YHIldAtHdil1OSfdGpO7XE9Nkon/pas8miJRMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6478
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210402_060224_093369_51679370 
X-CRM114-Status: GOOD (  16.78  )
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

On 2021/04/02 10:47, Bart Van Assche wrote:
> Instead of triggering an integer overflow and undefined behavior if MDTS is
> large, set max_hw_sectors to UINT_MAX.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Keith Busch <kbusch@kernel.org>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
> 
> Changes compared to v2: reduced the two max_hw_sectors = UINT_MAX statements into a single assignment.
> Changes compared to v1: removed a dev_err() call.
> 
>  drivers/nvme/host/core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 40215a0246e4..87d43309742b 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3123,10 +3123,10 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
>  
>  	atomic_set(&ctrl->abort_limit, id->acl + 1);
>  	ctrl->vwc = id->vwc;
> -	if (id->mdts)
> -		max_hw_sectors = 1 << (id->mdts + page_shift - 9);
> -	else
> +	if (!id->mdts || check_shl_overflow(1U, id->mdts + page_shift - 9,
> +					    &max_hw_sectors)) {
>  		max_hw_sectors = UINT_MAX;
> +	}

Nit: this could be rewritten as:

	if (!id->mdts ||
	    check_shl_overflow(1U, id->mdts + page_shift - 9, &max_hw_sectors))
		max_hw_sectors = UINT_MAX;

More readable and no unneeded brackets. No ?

>  	ctrl->max_hw_sectors =
>  		min_not_zero(ctrl->max_hw_sectors, max_hw_sectors);
>  
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
> 


-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
