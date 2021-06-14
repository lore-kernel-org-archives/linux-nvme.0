Return-Path: <SRS0=JVDK=LI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127C2C2B9F4
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Jun 2021 21:19:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C68DA6128B
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Jun 2021 21:19:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C68DA6128B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=NrQv8ZVKSYKoJr4osiV1RtevHTeOck83kPMwspaDIGA=; b=IYc9ef6QjGihpK
	shfOWb7tDm2IHTW/zMywckrXk796gJcfpRAFYhs4f9CwYqh7GVNDmFYXACpMjaUyH2sHrdG1lEBfD
	cbRgrjvnsLxwjZBQYxi/xG3bTdvySRemJS/XenQ+mOHyXpqvz+PM/2crrw7i895UzK6WDntNtzEEj
	vamKboz4tpGpDeBITLbnN4XViyuIU0kT2N4V3KENeO9HusEk6Ue2DkAN5/9YI6wEbdOAn1c9Lq9wQ
	4mhRN+Q4u8tdgGDOmPPDbwOGh3rljz2jlmJdPtVc5VyOY+ZSmdjKtku0i3Qtuj/JsqgT58Jhg2oBL
	22J9jWDrSAKYncm0ie5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lstzR-00GCtM-NH; Mon, 14 Jun 2021 21:19:25 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lstzO-00GCse-8G
 for linux-nvme@lists.infradead.org; Mon, 14 Jun 2021 21:19:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623705561; x=1655241561;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=8PlpkwrzH9q9E64pVyWakDDfspN7sg8d8/BXeAnAFN8=;
 b=U/69fE4rVVXSYLPLemriKMCbsgrQiSRNoPIHp9StoDiBs1q7tZl8Oz41
 5wbx5zfM80SQ1uoD5Rk+7mjSlOUWDBz2iqRKIsM6DOBYotonKdpotIXtI
 97dk5SF9xvlXBguWpgc4WTh3KG3WVRpEQhQn3OGPtcsyMcRm4Iy2DiYk8
 CEV+8+ufeGjexD8eZqyeSI+ygMehSVBomyfsdKOWznBkvFPLvIexvWrqd
 zG1/+kFWZ6qX8sUeMVtKvNyhbX2nqomwlSWq/ZsSCgunHgOb+ByOtZfLZ
 DgYj3u6EeFiNod8W8Zd9KdOeiMNRUnPI2EtUPVs2QLFs2s0YY6VZjj6KB A==;
IronPort-SDR: o0ZYMCXXYfQtIh/Rm/ylJ8uqfUKES5BRe3g8OcmeQEr8LNvICPtFU2wb2K/KLCfAA7RdFUD2MD
 BiyocQAmAcEVmIwwWxTHJ6lDEsxn0DA+FvHP496z/jnW3LApKhox0Fx/KYYPXJ2X/Vyye0vHp9
 hJtIYnFTCXIIlwL3QgLuAfiHOItSFvCW2rdnR1olje6Eo2azvujvOSSUZgvd7d0yh0V8PF/1/G
 4D5l4ETZhy9/FsvdoHEcL19w+Ijc4DN8IJt30cPxJP4KzQE/alTnQNukW1HUqKtbFI37aDpoWP
 gns=
X-IronPort-AV: E=Sophos;i="5.83,273,1616428800"; d="scan'208";a="171145380"
Received: from mail-dm6nam11lp2174.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.174])
 by ob1.hgst.iphmx.com with ESMTP; 15 Jun 2021 05:19:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H8fEmCN+66uvtTHkkhKR3aKlVhNETcnLLK+/se63WGg9uiUGSG1nVNK7fUTdeqKkvtHDM3w1OlxyUal+sxVHN/iYkvNGUldmKIv7GOwT1FAT/QTKx8k7j3TEOL0VizwFNxb/Qjj3uDV6BGAGZdVW8whqJ4IebCOMlfPQml7XLbaKQ0JEbRnQdAqDHLZPy0kk4JU+fQfiiUvPMo8ZVDo8Lw19rp4o+Vgnu+Jh9jY3jJYjF/QoZhCflZc75Apdp+S60+ntrtNzlU/8TV+vYSh21qlGY+r6NqZoI6wtnq4CjZcrQnyNIaKM9p+MsutWRE+n7mLkz1nEJpxmqRVrffLagA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djOOTtcyprAO237HwcONKA6jq/lamlBnvKkGcqFQhcM=;
 b=LkhPhlWJDjFGrvFRcUvpckSYWYw7AfEkIPcshYH1gjjJ6x/vreunAmHCvRV1hutzA/9Pa2f0gxi9u+fpICBtW2XZrWBc1+b1PBw/GNcPkLp3vcM1A66Vcn+v4HerhkOpvX4HzSQP+TbEyMEQ+sJ6jP0Q64O6DIkOuqKvpuAd/mYfk1a2G3PdGTswok8bcnbncQeCd5MG/hGuSRwoPUMokvkyLHNWwuN7FLYFIREt3+asOEYC2Q0Alcy5Vh2hjN5A4rA44KZ+AnRshAVCDUrhfUMuBEUZvEB4gkLIZSRhKpgF5bkynv9TYCbqXsPaDrWxDhsLfQb1gvaXB1+vRD6Yew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djOOTtcyprAO237HwcONKA6jq/lamlBnvKkGcqFQhcM=;
 b=EUU5tSleizHJCf6Sb94CShoFQJCw6X5I2AHLad4ZnCwKLq9f9BRiCuRItkvaULiIxAkoHtSqWWjeBtKiP20Um3Yetl+Np/on2o06QlZvQhir5BBQXFS35SDkzln7dvxRU5kmBsKKaG/8RZU4a7zGwufxOn6DwLqenaDHAsxXjkk=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7437.namprd04.prod.outlook.com (2603:10b6:a03:299::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Mon, 14 Jun
 2021 21:19:19 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 21:19:19 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "dwagner@suse.de" <dwagner@suse.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 1/3] nvmet: use subsys->max_nsid to report MNAN
Thread-Topic: [PATCH 1/3] nvmet: use subsys->max_nsid to report MNAN
Thread-Index: AQHXYI8cWRnTl+iEBUuDeUyedOHTgQ==
Date: Mon, 14 Jun 2021 21:19:18 +0000
Message-ID: <BYAPR04MB49651D977E8A8593309CE56E86319@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210613200252.9167-1-chaitanya.kulkarni@wdc.com>
 <20210613200252.9167-2-chaitanya.kulkarni@wdc.com>
 <20210614063629.GA29129@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b283edff-3eb0-43d1-b9f6-08d92f7a1288
x-ms-traffictypediagnostic: SJ0PR04MB7437:
x-microsoft-antispam-prvs: <SJ0PR04MB7437657990D9428C37EE6C9686319@SJ0PR04MB7437.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UcDLBQZIyToEF1V/a5N9B11iHQzsoiZ0VQGsn29miRHScJw2Z05Y0+umjbwwF+ycYpNEX3J7x+hZ+E66Bnvte9FpU28tgBHuJdVsKfXCQisx59++FI5MuZmM6jQD+0nmb3n79j4Eli0jOBXdyoMkfhxvt9m5Mb5211CZ35QZy8ei4tsNTPavuCwItYzkmNAaYftt+RvEMYFoprSlinDtOZEHpnvdwwGr6bq3wSv4dSb37qoGRyJzyMVGN+U1Em6dfb+yIBvLyNfn8EpPcqoZwkJs/MUeA2JSa+yo+7JngEpX+YjrKsw6HG4i8tSgUwlz1blUax+cXJWfeW9hePpOiBoU3YB61KgbMAat5MhBSWFOWnpu9HcRmVqjKFDmm+kY4+mhIWZKF4/j9fzxrr5aXdcfiOTiMqCW60hNqb6bv5bQ+LROTvwW6oHkll7aYon9HBjj3PPE+lXNpCk/D6L6VjaysNEdEG/ZS+HrTxMAbaixAHc991RlqX361CXWDR3h6BJ7HGOVSeTmNdVeLH55EWaNg8p6BBvR3t3HC+J1nzXnY7ZqbkEuwaT0+PjBXLhfMj9gTEgMIlAAqmdEhZwPXQK4UT4cbHl8k2TTHuvydwQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(366004)(136003)(39860400002)(26005)(9686003)(38100700002)(53546011)(6506007)(8676002)(33656002)(122000001)(186003)(316002)(71200400001)(2906002)(54906003)(64756008)(4326008)(8936002)(76116006)(6916009)(86362001)(66946007)(83380400001)(478600001)(52536014)(4744005)(55016002)(66446008)(66556008)(5660300002)(7696005)(66476007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uFEjpPORHvSMq5yH6tdB3ET7Ue5+iAWJX5aSlQJeV7QwRjys/ilH7u77TfP+?=
 =?us-ascii?Q?4cAsb/gtauD29EDYb3pGRcZzBrS1/MmMRz37ENdJV7kMl6aUt2hpaWafy9Hg?=
 =?us-ascii?Q?MlPg6h0/w1fOp4AZlAJ2v2mnvmXwjDZgS0H4gZpbNFyQqrZVLNTG7diwRlmw?=
 =?us-ascii?Q?deEQlBu7yZBZYiv/NDmUqaWGB/YX+EaXFuEoMzKN6kyS8jlvd6JKByGRr8/T?=
 =?us-ascii?Q?JGTiQcJKuW+W2q2pALiP+XorJZLET9zhENRdES02wIDqEjdPVe1yPTazyXoH?=
 =?us-ascii?Q?5KLikhZmzSSQpQ95Xj9VvGYSLVf/Qks28vQhnfvkbfFArjKs9hLUu5jdxLAS?=
 =?us-ascii?Q?zTlcQLpyYnYuswy8BVeB/MA9y7v9V39KpAD2TIIfKdQ3bZnLCVDTxyNKhAWa?=
 =?us-ascii?Q?MFzwZl/u0GNHMXh3bTKYGcmaw8TdhxYXVphQDsmClSaL0Th7PNEbKpTzVFvW?=
 =?us-ascii?Q?oLyqXRE8xiRmQ5fJCtCnNv2F8l1xTjVzuy+SLzxDXSJmI1yRATVoEXMNPvPe?=
 =?us-ascii?Q?kicPeVrYkWIxiMwzr8yzfnHS/lmat3UWoQ+Bi92n28aeQ2oKhIrclNwa1rsC?=
 =?us-ascii?Q?v13CQ4Cibyhsh7Rl95ZFguCGD+RxxoBpVXK1sFYPEEPe9xCQoZ60LyebpIVD?=
 =?us-ascii?Q?9+oQHtFGi73Kcqjl2dwjHhjVJqdaC1Y7NfgaubYII+DPPS2v0wgr4KGefB1P?=
 =?us-ascii?Q?KLtNkvi/7C/crqwWmmyDNhPUvcUxBfiOPT9TLaEe2OZJ1JHBuRCWMjjB0k2x?=
 =?us-ascii?Q?2Xv48vYPrlLnUXgGZR9VLC8ByzuYUjqtEf8/vrH6rWK0VT5FKqfVORmW8q6d?=
 =?us-ascii?Q?fRZe0+r8vLcOrsdfQFzgCX8tNSOV8YsH3aY6Ahnwx4L1MoeV5evqkypg7oIB?=
 =?us-ascii?Q?oWGwQboid/1j8VAziF7PcFyeZ95ArvkWaQzv+Hpy9IyxQFoEHeV6WrM/zN1D?=
 =?us-ascii?Q?bjxT2pP3C88oR7PVnNsRBQPEXfb1BNii/jLj8kjCKYlzvmrmqa4ivMT1Imqp?=
 =?us-ascii?Q?T5e9rwaeTnzamy05cvsKm2RpRqTnVFV7eMynKFU9WZ6mTJJ5IepQHAW0qSxs?=
 =?us-ascii?Q?tTw4YAILTe84yRuozkOu/3PAjahciqVwNBNCacJH/6uT925m9J1wxSI6sWnK?=
 =?us-ascii?Q?nbmCIwa6yYuyqzVV866BFcqv/qoYCgmoRx/NUDjF20vHYJ3gBbUZwpPNwn4p?=
 =?us-ascii?Q?P0c5ROT51ieDfo5C69pC3HnmHa+UjdkvhhJ0rzwHo7PkNENMB2rm88wPYfqg?=
 =?us-ascii?Q?gJ+lHMeHvTuVr5V02b0IdgAATj3i1zvlvHRr3XXBPSML5Aadvq+FTw7RbZbX?=
 =?us-ascii?Q?tFzPlJcUnqB2rAeoQJ000gme?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b283edff-3eb0-43d1-b9f6-08d92f7a1288
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2021 21:19:18.8854 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XCclGRF7b8bFPPYGHhg+OuDlGFAOWUo91UgpjnyTTOzAHyF9nqitqYotiqtwHerMcAZ6nTb0yJXkFB22Hs0541mnL2Cs2nfwmonRIiMjTYU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7437
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210614_141923_237511_877A7138 
X-CRM114-Status: GOOD (  15.06  )
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

On 6/13/21 23:36, Christoph Hellwig wrote:
> On Sun, Jun 13, 2021 at 01:02:50PM -0700, Chaitanya Kulkarni wrote:
>> For Spec regarding MNAN value:-
>>
>> If the controller supports Asymmetric Namespace Access Reporting, then
>> this field shall be set to a non-zero value that is less than or equal
>> to the NN value.
>>
>> Instead of using NVMET_MAX_NAMESPACES use subsys->max_nsid to set the
>> MNAN value.
> I think this is a rather bad idea as it is supposed to be a relatively
> static number.  I think the right fix is to stop playing games with a
> dyanmic NN and always report UINT_MAX in nn.
>

Sent out the patch with NN set to U32_MAX.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
