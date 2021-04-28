Return-Path: <SRS0=oNUT=JZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F13DC433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Apr 2021 18:52:23 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3CAC613DA
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Apr 2021 18:52:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3CAC613DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=H7vAhKOx233UYDpDY8IZ3wnghuLCuDDw0RPTNyVRNhg=; b=X+Nsmh/hGSWYZaZKt5CdwsYel
	PVPAl+3YpPRPco0UvuZWUs7L4x0Xo+eQhqTRYGKKQrFfgRV4rLHPkeu4TUKjBcI6+WMug72gLoLpD
	1To2sM6ET1I5glaXC+cpxhJHqXMBYhZ5ohxHrfum9wOv06y3XNOpR7e693Wi+nkIBehDoqxLsBF68
	dbnu5KX4v2ezItf/AmM4NFkaH50qzc4xldM24oI/pSNY3Quea3Iz+DTlNrCLRmEY0gq1y490sVBTA
	WDg9SgcKWdC4uwHU0DP0tzu4/5Tlb6zOBmBaeoIc2sVvhY56f9ztPjaSUNyq2/qVNSUlXTebjqK8j
	KCiIDIYIg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbpI0-0046rI-4I; Wed, 28 Apr 2021 18:52:00 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbpHu-0046qu-HH
 for linux-nvme@desiato.infradead.org; Wed, 28 Apr 2021 18:51:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:References:Message-ID:Date:Subject:CC:
 To:From:Sender:Reply-To:Content-ID:Content-Description:In-Reply-To;
 bh=BtFE2UQ6Jvy1/hPE/a7btdeSJsOZkqU2+wbxfbdmYJI=; b=BLkIdGGRxVIfyxrg1cIHLYZhsw
 fcKKp7GH4rFAYKQNXa0U0SK4O3bxB+D39/zTnpjEq/02AueP1idm20GPcNQOzOiyjvmcYfRhza6Vq
 mjNOhRqolP8JoJtcUZTUE0spy8s+qw3wJhunkNJS8WtxWjKsgjBOCsPKWuH6/WiCnFJ3fESijxqFd
 hOfLeTO9zeEq6R/7EP3rjmvi/EImwb5yz94LcRyhA05+wu9IbILjKEeVg5AI5GvSC0LbSqWZS8JQe
 /Nvd5oaF9A35KZeslyNJ4bEledFBgmDF/hkaO1wYIw7AImFwYM4klaWtaos3fxKsANYJPFflMallC
 4TatXd4Q==;
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbpHr-0007fM-VZ
 for linux-nvme@lists.infradead.org; Wed, 28 Apr 2021 18:51:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1619635911; x=1651171911;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=BtFE2UQ6Jvy1/hPE/a7btdeSJsOZkqU2+wbxfbdmYJI=;
 b=rEoNSzpSN6j1LNTkZIlW7bJ+XQRGIOT1JyLLoJIkN4f3KjGZOPuZsAvE
 l41g7xBeg5uK2U8vgFp3amgoH+NO/Kz40aNcqq4DNjLiXqqiQ4ZLyBVv9
 s7UrDz/l6qbtYJivkALHRBbIYGqA6U2ToQAhtRFMOc2weqjb7uwsAdwSm
 6sFXf0+D3MYIvw6nLHAyi6WmLoa/+UQM1pR69DG9oFUkX+7Lfne+T8+5Y
 L/oLOdOPDZ66S4GHP02aTDK2AGBScgWyNrE8ISFxuH1kVtp+ftnIpkwnX
 B4Pl6Jt1RM1DWbB93tw0xoQ69trgHr+vXTQ3TlxZjguJqJ8IRlPn+/EbY g==;
IronPort-SDR: d0WSrqLfOFkF74XkyaRVQHzNDB6Qu9tyZdM5gmRkLuZtiZ4Fo3math07GkdQ7O/PFgtPxkTmQ0
 ePiCJm3nL5s3xMLbfBYFmQpjJjmjZnZVnFEpKdTwcfTwu2WAGFIOoDCbiDRFno3WByCV5VnNmJ
 cV8t0ezDGjIOwXTe4ZdIKMRTBjiQBdB3vG9suT+RNrVs6gNBOu9VAu+MkLriVNHLex2gE9/GNt
 rsK27lK9/x6JeClWTWhFgcVgWJ27jQOwM/cYp55tdGudsQKL4vuA5r10m76WkwsadXLfqpwn5X
 AiE=
X-IronPort-AV: E=Sophos;i="5.82,258,1613404800"; d="scan'208";a="166575308"
Received: from mail-bn3nam04lp2054.outbound.protection.outlook.com (HELO
 NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.54])
 by ob1.hgst.iphmx.com with ESMTP; 29 Apr 2021 02:51:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bWNe//D7NS444XfnM/OBaphGGNT8QTIBih2XsDeTkuzyTPVNbjH+i5RYWwovkpU+vYCJmoRaOyzJW6+GpmXrM+2SOwZQy/iTrF6oA1uI/jZQO/U3syO62qCB1IkB8CexVXdfo6mMJutGOHnvEwa2DNwH0HI8VFZM7bKjUG33C200o58EY49T6XYphIomQWfVN6AKem0ZrSz177mMSLw0M7vV3Sf7CqTZLHfbi0GhobtwJlMCEXGUQghBhHK3U5MACwpouDh33Q/vZvyZOxnMqVp2oU3xeVx5YhhN6AsqqbFlztuRjb+ZYCwXxeMqxJYbvwsY8ipYKIDr0Pw+a7ITEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BtFE2UQ6Jvy1/hPE/a7btdeSJsOZkqU2+wbxfbdmYJI=;
 b=jA6tiDt3/d+1FeM7H+GM/i5F38AGGuizRcYJ+E89+obbsfe7J1e5Q2oM5YWY/FtSQ1R1YpAFgf/gXR+9cB+pmH5XiDSDH0WDwNGCvwKQlEbk/jOhf6DYWId50Ipf6wYmFZZckYDdfdR0NS3qh0rqf97a+aUSknwqGYM3+G6AVHMUM1/Jtqb/lM8on89niEyf7a1y0yvPRRB95psZ9D5LPGW0K+Xe3hMMFjHjOgdX/37hH3Wiu0rGxY5hMZ2TWDWsR4tU9TzJE1t4L1gbdctaCwcVEbSYi3BfDkuqqatefRihmK/CRwyzvHiIsfoz3hhxa9C3VlLhSnFitd7BbalhIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BtFE2UQ6Jvy1/hPE/a7btdeSJsOZkqU2+wbxfbdmYJI=;
 b=Trq3o8EFSo2e2Jz4qsF+xQ9wpYlxQOhNBDwlpDWfyJNnRQgRVPzvZM8F5pHm0PyVwP/AoBI8QLgvv5SBvZiA7fYWUy9b2pJIIkg0KX4YNt6jd0WITFcBXZllw1F54DETaHeeDbyGefYiDWiKqYTBFEEPbDKOpq4QgV+1aDTA1uo=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7262.namprd04.prod.outlook.com (2603:10b6:a03:292::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Wed, 28 Apr
 2021 18:51:48 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.4042.024; Wed, 28 Apr 2021
 18:51:48 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "Belanger, Martin" <Martin.Belanger@dell.com>, Martin Belanger
 <nitram_67@hotmail.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 1/1] Generate uevent on namespace AENs
Thread-Topic: [PATCH 1/1] Generate uevent on namespace AENs
Thread-Index: AQHXOtyJpVaoq+y8XkGj0nRxvGy4XQ==
Date: Wed, 28 Apr 2021 18:51:48 +0000
Message-ID: <BYAPR04MB49655438E37C566A45D4E9CF86409@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210426202842.42096-1-nitram_67@hotmail.com>
 <BL0PR13MB42914E1160F96F3EEFE518009C429@BL0PR13MB4291.namprd13.prod.outlook.com>
 <BYAPR04MB49656A4930E8A4367DFD9AC886419@BYAPR04MB4965.namprd04.prod.outlook.com>
 <SJ0PR19MB45443BABE01370BAC883B32DF2419@SJ0PR19MB4544.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dell.com; dkim=none (message not signed)
 header.d=none;dell.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ee40e66-ed3e-4931-a2fa-08d90a76ada5
x-ms-traffictypediagnostic: SJ0PR04MB7262:
x-microsoft-antispam-prvs: <SJ0PR04MB72622BB8E8E9E36E5D625CC886409@SJ0PR04MB7262.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:862;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7MAWuPkxlvTgUXyulkrqjyM3zbNsNXriUt1fOmnIBcY/rVTdTqO7EHthc7zf9zAfJ6d01HtWRCNEN+q9qVrvDFxM/z9bubjmBGQKGZGSKpimfxbj//RUXdPhLHCr1QM8bG0mzQMlP9YFie2dvpI2ZLbpcp5lQ6kS4xup2wu0t7WgaIgSnDQqqE28rl/swqgbP0Yfi8TNnv+hKMspxBVvJd9nJdcbCC/T5hTJVKKTnqWQ6ygZNr1RI+QvcGiVExQh6GDk4E0si0TRw4p0TckqZSttljL0m2+n72RuSIWPok2ZmQrcAIF1+/vZtK4lPRUcro+RHCw/KRJ1+97YkBrxCKu52+tuey2KS99r4mW00hkFc9ZMQtOhNPptC36CGJ2uI4cRvuQ55T+LfmUt29tprK4KqA6rNv9uFrS2Bcuujz3EWnQlYhLLSMAYKtabNEsTirJwXIizXlFqelgIP1fkyUFKiMuWmt9RBHOer0UQKxeMRV1tCZZ0ZYTNp5qICHYg2/7NrrYy4QLrVImLHn5ic4jGhEazn+i4g5wfB88sZxMWrlf14lMam6JT2EVCwEejaJh0Nnd/3SBHnHQadX+WVe2/eTBPyzDT1Z7gcnzyb3Y=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(366004)(346002)(39860400002)(136003)(122000001)(5660300002)(110136005)(33656002)(76116006)(8676002)(66476007)(66946007)(64756008)(83380400001)(66556008)(9686003)(52536014)(38100700002)(66446008)(26005)(4744005)(478600001)(71200400001)(2906002)(7696005)(316002)(186003)(86362001)(8936002)(53546011)(4326008)(54906003)(55016002)(6506007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?PxVT/eHF7MSztJACmYup+gK/Fc9yeE3m/xXIEamGajleBxVsyTx3x/YmSchA?=
 =?us-ascii?Q?w3wSU9zWY7DUtl10/2tLM2BdGAEKvHRYOcevpB/koB9JbRmFeQllotjivrSh?=
 =?us-ascii?Q?KDyATeJC6AqQSlZoNtikKULlhVl6eSpVb0ontP9EpaxkT97Kspi5xF3mItXi?=
 =?us-ascii?Q?fP+5i7tByfiui3YvplFeq+cfVSB3tPswVeHHnkTYcQVyck2gjxStGbJvdYDn?=
 =?us-ascii?Q?peXVsCgaFbmVGE1LtbQBcFs+SsxGl6sL9NE2BNCKwQq2xyGAwXtxLTtk8dHN?=
 =?us-ascii?Q?XIZY5TaLVjiiS53yuh+4aDgSsV5+z/qC9h47W5boT5obY8EoDSLqDEygrKkm?=
 =?us-ascii?Q?/w2fcX2nWql+kBAhtiGzYGP5fbeCg3JXL0R1/nWIioNdbLH74l4KVp0s8nTK?=
 =?us-ascii?Q?3ybPdBUHoqqM0864zEm+bMvFj30u08m0yxzIu3qZAwoxNTmcov6ATjIM9d99?=
 =?us-ascii?Q?uO+rB54v7PTu2FAfleIrmNBJbvV2mkBwVkTtwUgbf95TjukNEJd322IWwota?=
 =?us-ascii?Q?rSvp/PJh+BvzrcNsxW2Xy7fiRAmdFiwOMLxqMC2KrkTpE1yVA1UhMGlMey8A?=
 =?us-ascii?Q?KAUIaP3uueHKdcFx1RZ49xCRUdO98UQMQq+5iXzVXTJ4D2IQLHsUHVzf1wJV?=
 =?us-ascii?Q?WTT5ppfNoLbMeEuPMVWlhlAEE2fah8mp2ulxtYoN7HUgq5E2JAp4H5T/wh9Q?=
 =?us-ascii?Q?3glhnXWhIHsjPhTHkXq58HnJ+I8YhaufUKRCkOa8EEaOewKhN1nByXZO4J5h?=
 =?us-ascii?Q?ln81FqrrJGvJCfzXZa96wD2Ic0dSF5/a+5+cz1EM9ID2QVa9Pr1KAH3a6klw?=
 =?us-ascii?Q?kAMZcSG2Q/jgNJpkSHEDE0IblZgxldTv50/iNrzeyhxTSKhvlLTeZ2rlMh1U?=
 =?us-ascii?Q?h43U2gknn99CTwQC2LdDOEoZbA7fGMQMp75V2NmvGAEWIeAnHfKqV7bX3s07?=
 =?us-ascii?Q?44JurxC7rUfonHVRicvBZkfoioxvOQj4Epgy2B92I1F5DLYrbw1EjlVg+rST?=
 =?us-ascii?Q?jBhprjnEttCJHcMjQEK4xs4A091eWPJh2talDb2drUNLn3R8rms/e+hqgpSp?=
 =?us-ascii?Q?gK0Xi+NkIasXvCWJULUKfmmOUnX6bezTic3JuMb3Mz/fWjLQ+/D+TjzzSqQN?=
 =?us-ascii?Q?x7TJWJEIgc7xWcDJQdAZOcrDScaEl9A1AxHt/UWlJBERgalGvG8whq+fGZbl?=
 =?us-ascii?Q?nf73VHgziy5KGfMfbmdR1SOELo8MKn2bsrYC+hANG7HPyGe98xQj5BlXMMQk?=
 =?us-ascii?Q?Gbfry4INdagPnKk9pdL2SpIbRvNxBvitfONPAOZQGXU+YMC0HdFlynC3Idhc?=
 =?us-ascii?Q?o/ZMTW842r/IfbTKhWKQ5yiWELyO1LsK6oprBsfa0aQ7CA=3D=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ee40e66-ed3e-4931-a2fa-08d90a76ada5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 18:51:48.3808 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g3vp7VjBWfj09up8BTkXPGNICd3KeouPdCjHTH6scBeu6iArafmbmgkah6SsotR2XigvlwEPkO5B3TJPOpBNjjuaRcHQ/a/RDaTz5k0RuRk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7262
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210428_115152_040023_EF16CC31 
X-CRM114-Status: GOOD (  12.09  )
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

On 4/27/21 05:03, Belanger, Martin wrote:
> Hi Chaitanya,
>
> I'm sorry, but I'm not sure what you mean by "proper commit description". What is "improper" about the description I submitted.
>
> Thanks,
> Martin

Commit log is as important as functionality :-

1. There is no commit log in the patch but in the cover letter.
2. Subject line doesn't involve subsystem prefix.

That is "improper" from maintainer's point of view.

For more examples see the git log and kernel documentation.



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
