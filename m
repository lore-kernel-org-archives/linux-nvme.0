Return-Path: <SRS0=WFi/=JF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 251C8C433ED
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 22:07:06 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B91D610A3
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 22:07:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B91D610A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=7G9EvN6Kc898TJPsY6JlBYIjLOWpU0hbf3zHSOE7Xe4=; b=YAsMzRMEkkzY/BhJW1S8J2Pbc
	XFCgm51DVSTIpblU7Ad50ye+CyY0+z9JbzOdL3j/IcAAylPCMKYNeZiAykD1zgZdysh9UBTiCuXY0
	4/fCGnYoolYZ8rsc5aGZNVITTUKJ2YYD2/zZDUMA5zjqGhB8pYnJWE3gcpl15Ul/1Ps6Y1dDyTvA7
	ntQ3apE2EfMUDh03ZghjmW2r3Whpu+gc7FbH8GBwWkKA4O9dWPCynD01Wn4jCAsYFixOBYmtE+fPI
	LuD8zY/uJZ1jUhM+592gFmpHZfMyQ+7xt+q9JG0vilz/rxL4E84dkaTyhh5uyIGWSyyLxF7Tenwh4
	wrm+ZGXfg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUcnP-009LgZ-9X; Thu, 08 Apr 2021 22:06:39 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUcnJ-009LfP-6f
 for linux-nvme@lists.infradead.org; Thu, 08 Apr 2021 22:06:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1617919593; x=1649455593;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=NFO/NSh8dIWpJQfgee9rOvDn3bORrVIjuN48YRzj4MA=;
 b=FsoVQlBQzFcru/qwvjdpcYqwXLr/qi6kFoIztIh+WicVbYZGl7EWCqpK
 XDbV6jW6aEu2CX4Wcone18iDIEuhCq1w/uibRE+Xb07EYUSVCHKn8Awgz
 fdegLciY+16Uy1ZktUUD5HHv+eEJXaBQsO/tcxNBrTEZJqX6HHwlELPmX
 5ddWE79npPn0oAYfAcXLmwAesm/xS6u1MgfQ9FmpzOYM/8gmr7sB4uEoT
 3Ypr7RKYGSktKrtPrs1vn8cRauv+iCBbVpAdlGs6rrZelffXMSgLaP8Zz
 O0L3jNtWgUtnHOBMEu4ob+/qJy96Qm0EVxQD+adc/kkhFztOkNBtVW2VB g==;
IronPort-SDR: dvkXtSQZyJ4rfXWjrI4/DpliE3hVDiSA62au0YmsXLReb0czWz/Mj1G56rtGfmISuZiG9OlmRp
 1Z3a96DKx3qibbh37boLuMLARQ3gxpDe/NCo2K8WJaLPFqBGZ+H5uPxzgNHfkWft7hy7O/25o5
 Xmf1TbDGbhqIT68Tf9BW++hzXikdPhhlhDnYBfzJgmruepLScyZEbCQrDPctN5SvqQ8ZkB71AY
 OXn0aP6stLSmT/vzRdoW9XQyjiRPJ+eQjpsGP+LvcV263OHPEg06IYhKdAe3Nx3qybm8R65HUg
 c9g=
X-IronPort-AV: E=Sophos;i="5.82,207,1613404800"; d="scan'208";a="164238178"
Received: from mail-bn8nam12lp2173.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.173])
 by ob1.hgst.iphmx.com with ESMTP; 09 Apr 2021 06:06:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cAGC4xxvhiwV17+5yLVD2DOalQBIYTC4AATUHIo5HKR5HMqVVKXntyUT9ZpjfCMKL08xx6nVmDpAi3BO4oB2PTIZCezYJHZ8zAW1ZpXLuBpOkFI7LJ2+LLCYYzJ/t8lrfAftzOkCoGp5f/b91JOw+B1ObE2LyBt9Z8wdwLOM9J+mt90Cv6Ky1/DlEmQ78H4orj/UprdR0whi5nTUifJYLI2pbTXx+jc2PtL25OW8pPe8TwMOCtqbTPR/5MZF+CaIQcWV2QE4S6HKS6WCevrNTWehQUOijECs/z/CB5RQi+r/DHoGCCrnCr7RmhVA57Co3qCcmtMfgC4nx2cdm4r++w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+FfCuMbIP2EoCULMe0wSBqTIX/YhPFAH41PfwYrpy4=;
 b=iF3DHGk4IFqB8lgQfse6k2jKOOHtQLRa8FGvGatZBlno4sKO9lshRG4N12MUYBwbPz4qrPqc5XA/y7tn3XKGUeqXq1wRIf3u67HtTjSD11HQE5p8WX6yDAomP+F8aRleNIWQLPobkJPm6TnvTa9R35zFynuhioskJerNIb8Yjwjl20idqK9XMMI1iouk/THIKRdyQG03h3yD35ISWC0dS58blinkbSePiuxDXo/LZVSpe4J0Ds7e6yrvpPzk35s1VKGx4ZI7GN2Y7U1TYf5MsQZDn4qtx1tPS7NaAQ/ePqXdbjn0uc/5ExPuHjha/rXr+R3swzTm1BtuV9VLUElOYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+FfCuMbIP2EoCULMe0wSBqTIX/YhPFAH41PfwYrpy4=;
 b=yN3Ug2du2GZhj3BIEBlUCBKLbz9897kHj8355Cf8Uw3iy8E0HKe7B1oi2NY9yNtDgQOab23Pcvi8PLPjoKwTTSKKZqOOU9EVAQ/2a3vAsqo5n8VrqzYwFqmzGXrFt89Og/T2BfGDy9OTUBhkq8xuvWkIrPTIqE2u/9sNxEcWDCo=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6803.namprd04.prod.outlook.com (2603:10b6:a03:21a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16; Thu, 8 Apr
 2021 22:06:16 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.4020.018; Thu, 8 Apr 2021
 22:06:16 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Damien Le Moal <Damien.LeMoal@wdc.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH V13 2/4] nvmet: add ZBD over ZNS backend support
Thread-Topic: [PATCH V13 2/4] nvmet: add ZBD over ZNS backend support
Thread-Index: AQHXLAw04l3W0N5us06JCpRfHcvipQ==
Date: Thu, 8 Apr 2021 22:06:15 +0000
Message-ID: <BYAPR04MB4965EF4797C51B1896D2640486749@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210408001427.20501-1-chaitanya.kulkarni@wdc.com>
 <20210408001427.20501-3-chaitanya.kulkarni@wdc.com>
 <BL0PR04MB6514CAFA7FDA65E10B1DCE11E7749@BL0PR04MB6514.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 55f463c9-3ed1-46c3-f893-08d8fada87c5
x-ms-traffictypediagnostic: BY5PR04MB6803:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR04MB6803B28EFC2958AF495B2F5786749@BY5PR04MB6803.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gd+lJ5XtyPBcm6dvPcJmdHVR5OPvcvqWdHaA5g67KpdfWPCf9gUj/x3nmjWWioowQXpQ64ina8w1bsBzE4zyppNtNFuG6q7xfssKOUkXum8YEqaJsZ7/gRV9na+CNDwnalBWjv/4ShbkNYAt5puwpSWCfZKyyAk5W34f0Oc/CqDp6XeXDDI9NZrB6dI5aOxvPMNkMhMhku5/9+cWRvCizmTt/4KDUu78+qbERf1aW1r8C0BaXP6gUIjAejKU87dORSXgRbvT9WPyIjUZYfj4bp//jBz+vSocEopBa44fL9gPjQj2Lqk1gkEboTKxWUPR4kSDG2omvxUqjgvNWue9K2zWSxQT0NIk39mBfdKvDPIWENsFEzIhw1gz5ug2rxy1a3JL/68+b9s5k/Z50nglj0vd8N7P7gDuqoT4F5pAlC71vlJCiXzjS50LbysIW6Amhl2blwdWZTu7rapGXyJzwbxfffa3apIMIQX+bI535USna3C0gg2cjuMxaWWASy9QvlCMV0Gy+MvmhYukRqKm+M92kn/6FDPm3EZ9e1VtaKdEpmotAdrSVLX8E1np5/cjh08UVfj5p67Sw6uoT09GBfiq+lId6zV5qNwN4WjbwWo6KffW/vN0W+H9xkJl5OjRscMcWr3+LYs/iq/gjedYoA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(366004)(136003)(346002)(376002)(66476007)(66556008)(91956017)(4326008)(8936002)(26005)(6506007)(53546011)(64756008)(55016002)(66946007)(6636002)(54906003)(5660300002)(66446008)(76116006)(2906002)(7696005)(83380400001)(9686003)(33656002)(86362001)(71200400001)(6862004)(478600001)(186003)(30864003)(8676002)(52536014)(316002)(38100700001)(579004);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?0aaDdBO40Mtb3cw5wOtTP0NTXqCnb/EFfPsFCWfX8cYsxO3XiinmBAbzVsGz?=
 =?us-ascii?Q?HbgS6HVPCWc5X1rhAnzGCrEGWE4HDxSrpAmzzXhXO7Ps6KN9yl7SC94Dr2ro?=
 =?us-ascii?Q?tezEHGedhitmWCQG/bPvd+3WNWQdxZMeOW9KHyg6QNgTpv9J3yRElF223jLJ?=
 =?us-ascii?Q?VzQvqdUV7qBvJux+iARNpve0qLhdrspWKCFxf0NP8/u/dCOJEA1yAdhacewX?=
 =?us-ascii?Q?wLnBMwtWJ5wB7L0MHSNg96lBhekaHMfTr/A0KaXKh2bdNDxiKy384b/gl5++?=
 =?us-ascii?Q?XFRpRPkLuB8SAyYdmlR++t4XNpeHSF1WplzQ+9d53DROW5z0wdJIbDmw7uFs?=
 =?us-ascii?Q?SkVjfwER3vEfsPjy7vWBUnRvfE6I1gjuNGhvr7E6/0zNkPaKu6DUPumZxSHV?=
 =?us-ascii?Q?KEs7Aay00f8QGJ1JyD17b/DqCqZ6cUb2W29lk4VQ6Xsouk9/lJ8nk+BMPsAI?=
 =?us-ascii?Q?t9KztNZyNsc3uFvrg+NjTMeuCBhJC35xuE+/UJrxsignJDaJzvtHNtj6gMym?=
 =?us-ascii?Q?z/0A0F+22QJ6QWBndFE5p51cCCDAoFlwE4XcaA40R2Ienp959Rx2SJwoJyt0?=
 =?us-ascii?Q?9AIE3EYYTeKhdRLcg2e5vRwnIxQU2Wbh8JtzCaUtQ3CUUg5BxBzqP5zNCzzk?=
 =?us-ascii?Q?q0uQvvYRwEUPLNGgrxU8mwvrzJcNf1+Kt7u50stYscLoMahIwSnz1IT5UD9q?=
 =?us-ascii?Q?EObfdt4ivZ6cqRjieEI5qHRanSmC75/+0OexmZ0Zdmzuls4XPpMGfPZcHef5?=
 =?us-ascii?Q?F+htpbN63euzAEJi/zSU/y+TYvny2Zg/Cdcs71svpQfS/UUP98WV6HNR0Ve4?=
 =?us-ascii?Q?lPxkRA9IojlJupZLgnp192nYnbhRfQg+QKnzk133e6zW8XGuVFqduNLH1spH?=
 =?us-ascii?Q?2hV8Jfqb4MVcLXpzqUPUN4bmbFxHQyPZsqAihxnyqvRE8ZsqVftctyI56wAW?=
 =?us-ascii?Q?FwpclYvQ9JpwK+NeT8i1injtYlAYzYu3NLutToPNPnLdpYrVeaNFYtOypGMC?=
 =?us-ascii?Q?9m30ihaQzvF7EWbNbdqx9HeBdEj8VQiz508B3obBwN1XKpmjyzCxX9UHb2/6?=
 =?us-ascii?Q?k1DyiTNsxAg+wc5ei/SFWJ4lB+WYfnW77Z08F53NXZ6K7r7oGMw8ALNTLc8w?=
 =?us-ascii?Q?VEY8SbUfZxJqDFjnf/wnwvl+o1q8KUVKxYtcwOd/P5fzpbsKBqW8C0pmXeKF?=
 =?us-ascii?Q?FiiEIe7jhCiS8CueynuOul+vkeAZ6zLG052rCSXj9hk/MqY2+bnCCsYp2Ir8?=
 =?us-ascii?Q?t/0DIllkUpV6XOQVRdzHfC1p7R5QQQbVwTwuV2UmJCeyWLgZYWGbZP3Zom1R?=
 =?us-ascii?Q?4EYUk9f5nvv1c+WsRPAg3zjP?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55f463c9-3ed1-46c3-f893-08d8fada87c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2021 22:06:15.8319 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lmgfiVxIGTwJsaz+1EkZufZh2bwnSUJq4GdN7VbjTZzRxhI3xi7N0VTaXHFCMLMo721dKL+NAt72Q8de6IJQd/GjxgxGQXvo1whHgWF/9D4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6803
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210408_230634_058418_CEE642A0 
X-CRM114-Status: GOOD (  22.64  )
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

On 4/8/21 01:01, Damien Le Moal wrote:
>> +struct nvmet_report_zone_data {
>> +	struct nvme_zone_report *rz;
>> +	struct nvmet_ns *ns;
>> +	u64 nr_zones;
>> +	u8 zrasf;
>> +};
>> +
>> +static int nvmet_bdev_report_zone_cb(struct blk_zone *z, unsigned i, void *d)
>> +{
>> +	struct nvmet_report_zone_data *rz = d;
>> +	struct nvme_zone_descriptor *entries = rz->rz->entries;
>> +	struct nvmet_ns *ns = rz->ns;
>> +	static const unsigned int blk_zcond_to_nvme_zstate[] = {
>> +		[BLK_ZONE_COND_EMPTY]	 = NVME_ZRASF_ZONE_STATE_EMPTY,
>> +		[BLK_ZONE_COND_IMP_OPEN] = NVME_ZRASF_ZONE_STATE_IMP_OPEN,
>> +		[BLK_ZONE_COND_EXP_OPEN] = NVME_ZRASF_ZONE_STATE_EXP_OPEN,
>> +		[BLK_ZONE_COND_CLOSED]	 = NVME_ZRASF_ZONE_STATE_CLOSED,
>> +		[BLK_ZONE_COND_READONLY] = NVME_ZRASF_ZONE_STATE_READONLY,
>> +		[BLK_ZONE_COND_FULL]	 = NVME_ZRASF_ZONE_STATE_FULL,
>> +		[BLK_ZONE_COND_OFFLINE]	 = NVME_ZRASF_ZONE_STATE_OFFLINE,
>> +	};
> This creates a sparse array bigger than it needs to be. If you reverse here and
> use the ZRASF values as indexes (blk_zrasf_to_zcond[]), the array will shrink
> and not be sparse, then... See below...
>
>> +
>> +	if (rz->zrasf == NVME_ZRASF_ZONE_REPORT_ALL)
>> +		goto record_zone;
>> +
>> +	/*
>> +	 * Make sure this zone condition's value is mapped to NVMe ZNS zone
>> +	 * condition value.
>> +	 */
>> +	if (z->cond > ARRAY_SIZE(blk_zcond_to_nvme_zstate) ||
>> +	    !blk_zcond_to_nvme_zstate[z->cond])
>> +		return -EINVAL;
>> +
>> +	/* filter zone by condition */
>> +	if (blk_zcond_to_nvme_zstate[z->cond] != rz->zrasf)
>> +		return 0;
> ...since zrasf is already validated, all of the above becomes:
>
> 	/* filter zones by condition */
> 	if (rz->zrasf != NVME_ZRASF_ZONE_REPORT_ALL &&
> 	    z->cond != blk_zrasf_to_zcond[rz->zrasf])
> 		return 0;

Since you are okay with this will make this change, except the array
name should be:- nvme_zrasf_to_blk_zcond.

>> +
>> +record_zone:
> This label can go away too.

Yes.

>
>> +
>> +	entries[rz->nr_zones].zcap = nvmet_sect_to_lba(ns, z->capacity);
>> +	entries[rz->nr_zones].zslba = nvmet_sect_to_lba(ns, z->start);
>> +	entries[rz->nr_zones].wp = nvmet_sect_to_lba(ns, z->wp);
>> +	entries[rz->nr_zones].za = z->reset ? 1 << 2 : 0;
>> +	entries[rz->nr_zones].zs = z->cond << 4;
>> +	entries[rz->nr_zones].zt = z->type;
>> +
>> +	rz->nr_zones++;
>> +
>> +	return 0;
>> +}
>> +
>> +unsigned long nvmet_req_nr_zones_from_slba(struct nvmet_req *req)

[...]

>> +void nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req)
>> +{
>> +	sector_t sect = nvmet_lba_to_sect(req->ns, req->cmd->zms.slba);
>> +	u16 status = NVME_SC_SUCCESS;
>> +	u8 zsa = req->cmd->zms.zsa;
>> +	sector_t nr_sects;
>> +	enum req_opf op;
>> +	int ret;
>> +	const unsigned int zsa_to_op[] = {
>> +		[NVME_ZONE_OPEN]	= REQ_OP_ZONE_OPEN,
>> +		[NVME_ZONE_CLOSE]	= REQ_OP_ZONE_CLOSE,
>> +		[NVME_ZONE_FINISH]	= REQ_OP_ZONE_FINISH,
>> +		[NVME_ZONE_RESET]	= REQ_OP_ZONE_RESET,
>> +	};
>> +
>> +	if (zsa > ARRAY_SIZE(zsa_to_op)) {
>> +		status = NVME_SC_INVALID_FIELD;
>> +		goto out;
>> +	}
>> +
>> +	op = zsa_to_op[zsa];
>> +
>> +	if (req->cmd->zms.select_all) {
>> +		sect = 0;
>> +		nr_sects = get_capacity(req->ns->bdev->bd_disk);
>> +	} else {
>> +		sect = nvmet_lba_to_sect(req->ns, req->cmd->zms.slba);
>> +		nr_sects = bdev_zone_sectors(req->ns->bdev);
>> +	}
>> +
>> +	ret = blkdev_zone_mgmt(req->ns->bdev, op, sect, nr_sects, GFP_KERNEL);
>> +	if (ret)
>> +		status = NVME_SC_INTERNAL;
> This one is a little odd with regard to the ALL bit. In the block layer, only
> zone reset all is supported, which mean that the above will not do
> open/close/finish all. Only reset all will work. Open/close/finish all need to
> be emulated here: do a full report zone and based on the zone condition and op,
> call blkdev_zone_mgmt() for each zone that need a operation. Ideally,
> blkdev_zone_mgmt() should be called in the report cb, but I am not sure if that
> cannot create some context problems...

Please see the explanation at the end [1].

>> +out:
>> +	nvmet_req_complete(req, status);
>> +}
>> +
>> +static void nvmet_bdev_zone_append_bio_done(struct bio *bio)
>> +{
>> +	struct nvmet_req *req = bio->bi_private;
>> +
>> +	req->cqe->result.u64 = nvmet_sect_to_lba(req->ns,
>> +						 bio->bi_iter.bi_sector);
> You should do this only if status is success, no ?

I'll add a BLK_STS_OK check before the assignment.

>> +	nvmet_req_complete(req, blk_to_nvme_status(req, bio->bi_status));
>> +	if (bio != &req->b.inline_bio)
>> +		bio_put(bio);
>> +}
>> +
>> +void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
>> +{
>> +	sector_t sect = nvmet_lba_to_sect(req->ns, req->cmd->rw.slba);
>> +	u16 status = NVME_SC_SUCCESS;
>> +	unsigned int total_len = 0;
>> +	struct scatterlist *sg;
>> +	int ret = 0, sg_cnt;
>> +	struct bio *bio;
>> +
>> +	/* Request is completed on len mismatch in nvmet_check_transter_len() */
>> +	if (!nvmet_check_transfer_len(req, nvmet_rw_data_len(req)))
>> +		return;
>> +
>> +	if (!req->sg_cnt) {
>> +		nvmet_req_complete(req, 0);
> isn't this an error ? (not entirely sure)

if transfer len matches the rw len and it is zero we cannot send any data
so just complete the command.

>
>> +		return;
>> +	}
>> +
>> +	if (req->transfer_len <= NVMET_MAX_INLINE_DATA_LEN) {
>> +		bio = &req->b.inline_bio;
>> +		bio_init(bio, req->inline_bvec, ARRAY_SIZE(req->inline_bvec));
>>

[1] Zone Mgmt send emulation with all bit comment :-

I ran the test where all the zones are set to the EMPTY right after creating
a controller on the host (initiator), see [A]. With the passthru command
with
all bit set, I was able to change the state of all the zones, see [B].

So I did not understand your comment about how all bit is failing to
change the
state of all zones with passthru commnd ?


A. All zones are empty.

# nvme zns report-zones /dev/nvme1n1
nr_zones: 32
SLBA: 0x0     WP: 0x0     Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x4000  WP: 0x4000  Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x8000  WP: 0x8000  Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0xc000  WP: 0xc000  Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x10000 WP: 0x10000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x14000 WP: 0x14000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x18000 WP: 0x18000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x1c000 WP: 0x1c000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x20000 WP: 0x20000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x24000 WP: 0x24000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x28000 WP: 0x28000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x2c000 WP: 0x2c000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x30000 WP: 0x30000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x34000 WP: 0x34000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x38000 WP: 0x38000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x3c000 WP: 0x3c000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x40000 WP: 0x40000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x44000 WP: 0x44000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x48000 WP: 0x48000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x4c000 WP: 0x4c000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x50000 WP: 0x50000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x54000 WP: 0x54000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x58000 WP: 0x58000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x5c000 WP: 0x5c000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x60000 WP: 0x60000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x64000 WP: 0x64000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x68000 WP: 0x68000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x6c000 WP: 0x6c000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x70000 WP: 0x70000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x74000 WP: 0x74000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x78000 WP: 0x78000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x7c000 WP: 0x7c000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0

B. Now we send the passthru command with all bit set  for
    zsa values RESET 0x04, OPEN 0x03, CLOSE 0x01, FINISH 0x02
    in the same oder as above. All the zones state are changed.

# for zsa in 4 3 1 2 ; do
>nvme zns zone-mgmt-send /dev/nvme1n1 -a -zsa=0x${zsa}
>nvme zns report-zones /dev/nvme1n1
>done

+ nvme zns zone-mgmt-send /dev/nvme1n1 -a -zsa=0x4
zone-mgmt-send: Success, action:4 zone:0 all:1 nsid:1
+ nvme zns report-zones /dev/nvme1n1
nr_zones: 32
SLBA: 0x0     WP: 0x0     Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x4000  WP: 0x4000  Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x8000  WP: 0x8000  Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0xc000  WP: 0xc000  Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x10000 WP: 0x10000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x14000 WP: 0x14000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x18000 WP: 0x18000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x1c000 WP: 0x1c000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x20000 WP: 0x20000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x24000 WP: 0x24000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x28000 WP: 0x28000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x2c000 WP: 0x2c000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x30000 WP: 0x30000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x34000 WP: 0x34000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x38000 WP: 0x38000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x3c000 WP: 0x3c000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x40000 WP: 0x40000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x44000 WP: 0x44000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x48000 WP: 0x48000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x4c000 WP: 0x4c000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x50000 WP: 0x50000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x54000 WP: 0x54000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x58000 WP: 0x58000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x5c000 WP: 0x5c000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x60000 WP: 0x60000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x64000 WP: 0x64000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x68000 WP: 0x68000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x6c000 WP: 0x6c000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x70000 WP: 0x70000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x74000 WP: 0x74000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x78000 WP: 0x78000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x7c000 WP: 0x7c000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
+ for i in 4 3 1 2
+ nvme zns zone-mgmt-send /dev/nvme1n1 -a -zsa=0x3
zone-mgmt-send: Success, action:3 zone:0 all:1 nsid:1
+ nvme zns report-zones /dev/nvme1n1
nr_zones: 32
SLBA: 0x0     WP: 0x0     Cap: 0x4000 State: EXP_OPENED Type:
SEQWRITE_REQ Attrs: 0x0
SLBA: 0x4000  WP: 0x4000  Cap: 0x4000 State: EXP_OPENED Type:
SEQWRITE_REQ Attrs: 0x0
SLBA: 0x8000  WP: 0x8000  Cap: 0x4000 State: EXP_OPENED Type:
SEQWRITE_REQ Attrs: 0x0
SLBA: 0xc000  WP: 0xc000  Cap: 0x4000 State: EXP_OPENED Type:
SEQWRITE_REQ Attrs: 0x0
SLBA: 0x10000 WP: 0x10000 Cap: 0x4000 State: EXP_OPENED Type:
SEQWRITE_REQ Attrs: 0x0
SLBA: 0x14000 WP: 0x14000 Cap: 0x4000 State: EXP_OPENED Type:
SEQWRITE_REQ Attrs: 0x0
SLBA: 0x18000 WP: 0x18000 Cap: 0x4000 State: EXP_OPENED Type:
SEQWRITE_REQ Attrs: 0x0
SLBA: 0x1c000 WP: 0x1c000 Cap: 0x4000 State: EXP_OPENED Type:
SEQWRITE_REQ Attrs: 0x0
SLBA: 0x20000 WP: 0x20000 Cap: 0x4000 State: EXP_OPENED Type:
SEQWRITE_REQ Attrs: 0x0
SLBA: 0x24000 WP: 0x24000 Cap: 0x4000 State: EXP_OPENED Type:
SEQWRITE_REQ Attrs: 0x0
SLBA: 0x28000 WP: 0x28000 Cap: 0x4000 State: EXP_OPENED Type:
SEQWRITE_REQ Attrs: 0x0
SLBA: 0x2c000 WP: 0x2c000 Cap: 0x4000 State: EXP_OPENED Type:
SEQWRITE_REQ Attrs: 0x0
SLBA: 0x30000 WP: 0x30000 Cap: 0x4000 State: EXP_OPENED Type:
SEQWRITE_REQ Attrs: 0x0
SLBA: 0x34000 WP: 0x34000 Cap: 0x4000 State: EXP_OPENED Type:
SEQWRITE_REQ Attrs: 0x0
SLBA: 0x38000 WP: 0x38000 Cap: 0x4000 State: EXP_OPENED Type:
SEQWRITE_REQ Attrs: 0x0
SLBA: 0x3c000 WP: 0x3c000 Cap: 0x4000 State: EXP_OPENED Type:
SEQWRITE_REQ Attrs: 0x0
SLBA: 0x40000 WP: 0x40000 Cap: 0x4000 State: EXP_OPENED Type:
SEQWRITE_REQ Attrs: 0x0
SLBA: 0x44000 WP: 0x44000 Cap: 0x4000 State: EXP_OPENED Type:
SEQWRITE_REQ Attrs: 0x0
SLBA: 0x48000 WP: 0x48000 Cap: 0x4000 State: EXP_OPENED Type:
SEQWRITE_REQ Attrs: 0x0
SLBA: 0x4c000 WP: 0x4c000 Cap: 0x4000 State: EXP_OPENED Type:
SEQWRITE_REQ Attrs: 0x0
SLBA: 0x50000 WP: 0x50000 Cap: 0x4000 State: EXP_OPENED Type:
SEQWRITE_REQ Attrs: 0x0
SLBA: 0x54000 WP: 0x54000 Cap: 0x4000 State: EXP_OPENED Type:
SEQWRITE_REQ Attrs: 0x0
SLBA: 0x58000 WP: 0x58000 Cap: 0x4000 State: EXP_OPENED Type:
SEQWRITE_REQ Attrs: 0x0
SLBA: 0x5c000 WP: 0x5c000 Cap: 0x4000 State: EXP_OPENED Type:
SEQWRITE_REQ Attrs: 0x0
SLBA: 0x60000 WP: 0x60000 Cap: 0x4000 State: EXP_OPENED Type:
SEQWRITE_REQ Attrs: 0x0
SLBA: 0x64000 WP: 0x64000 Cap: 0x4000 State: EXP_OPENED Type:
SEQWRITE_REQ Attrs: 0x0
SLBA: 0x68000 WP: 0x68000 Cap: 0x4000 State: EXP_OPENED Type:
SEQWRITE_REQ Attrs: 0x0
SLBA: 0x6c000 WP: 0x6c000 Cap: 0x4000 State: EXP_OPENED Type:
SEQWRITE_REQ Attrs: 0x0
SLBA: 0x70000 WP: 0x70000 Cap: 0x4000 State: EXP_OPENED Type:
SEQWRITE_REQ Attrs: 0x0
SLBA: 0x74000 WP: 0x74000 Cap: 0x4000 State: EXP_OPENED Type:
SEQWRITE_REQ Attrs: 0x0
SLBA: 0x78000 WP: 0x78000 Cap: 0x4000 State: EXP_OPENED Type:
SEQWRITE_REQ Attrs: 0x0
SLBA: 0x7c000 WP: 0x7c000 Cap: 0x4000 State: EXP_OPENED Type:
SEQWRITE_REQ Attrs: 0x0
+ for i in 4 3 1 2
+ nvme zns zone-mgmt-send /dev/nvme1n1 -a -zsa=0x1
zone-mgmt-send: Success, action:1 zone:0 all:1 nsid:1
+ nvme zns report-zones /dev/nvme1n1
nr_zones: 32
SLBA: 0x0     WP: 0x0     Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x4000  WP: 0x4000  Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x8000  WP: 0x8000  Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0xc000  WP: 0xc000  Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x10000 WP: 0x10000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x14000 WP: 0x14000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x18000 WP: 0x18000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x1c000 WP: 0x1c000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x20000 WP: 0x20000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x24000 WP: 0x24000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x28000 WP: 0x28000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x2c000 WP: 0x2c000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x30000 WP: 0x30000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x34000 WP: 0x34000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x38000 WP: 0x38000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x3c000 WP: 0x3c000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x40000 WP: 0x40000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x44000 WP: 0x44000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x48000 WP: 0x48000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x4c000 WP: 0x4c000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x50000 WP: 0x50000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x54000 WP: 0x54000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x58000 WP: 0x58000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x5c000 WP: 0x5c000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x60000 WP: 0x60000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x64000 WP: 0x64000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x68000 WP: 0x68000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x6c000 WP: 0x6c000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x70000 WP: 0x70000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x74000 WP: 0x74000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x78000 WP: 0x78000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x7c000 WP: 0x7c000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
Attrs: 0x0
+ for i in 4 3 1 2
+ nvme zns zone-mgmt-send /dev/nvme1n1 -a -zsa=0x2
zone-mgmt-send: Success, action:2 zone:0 all:1 nsid:1
+ nvme zns report-zones /dev/nvme1n1
nr_zones: 32
SLBA: 0x0     WP: 0x4000  Cap: 0x4000 State: FULL Type: SEQWRITE_REQ
Attrs: 0x0                       
SLBA: 0x4000  WP: 0x8000  Cap: 0x4000 State: FULL Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x8000  WP: 0xc000  Cap: 0x4000 State: FULL Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0xc000  WP: 0x10000 Cap: 0x4000 State: FULL Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x10000 WP: 0x14000 Cap: 0x4000 State: FULL Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x14000 WP: 0x18000 Cap: 0x4000 State: FULL Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x18000 WP: 0x1c000 Cap: 0x4000 State: FULL Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x1c000 WP: 0x20000 Cap: 0x4000 State: FULL Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x20000 WP: 0x24000 Cap: 0x4000 State: FULL Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x24000 WP: 0x28000 Cap: 0x4000 State: FULL Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x28000 WP: 0x2c000 Cap: 0x4000 State: FULL Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x2c000 WP: 0x30000 Cap: 0x4000 State: FULL Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x30000 WP: 0x34000 Cap: 0x4000 State: FULL Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x34000 WP: 0x38000 Cap: 0x4000 State: FULL Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x38000 WP: 0x3c000 Cap: 0x4000 State: FULL Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x3c000 WP: 0x40000 Cap: 0x4000 State: FULL Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x40000 WP: 0x44000 Cap: 0x4000 State: FULL Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x44000 WP: 0x48000 Cap: 0x4000 State: FULL Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x48000 WP: 0x4c000 Cap: 0x4000 State: FULL Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x4c000 WP: 0x50000 Cap: 0x4000 State: FULL Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x50000 WP: 0x54000 Cap: 0x4000 State: FULL Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x54000 WP: 0x58000 Cap: 0x4000 State: FULL Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x58000 WP: 0x5c000 Cap: 0x4000 State: FULL Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x5c000 WP: 0x60000 Cap: 0x4000 State: FULL Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x60000 WP: 0x64000 Cap: 0x4000 State: FULL Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x64000 WP: 0x68000 Cap: 0x4000 State: FULL Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x68000 WP: 0x6c000 Cap: 0x4000 State: FULL Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x6c000 WP: 0x70000 Cap: 0x4000 State: FULL Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x70000 WP: 0x74000 Cap: 0x4000 State: FULL Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x74000 WP: 0x78000 Cap: 0x4000 State: FULL Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x78000 WP: 0x7c000 Cap: 0x4000 State: FULL Type: SEQWRITE_REQ
Attrs: 0x0
SLBA: 0x7c000 WP: 0x80000 Cap: 0x4000 State: FULL Type: SEQWRITE_REQ
Attrs: 0x0
+ set +x



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
