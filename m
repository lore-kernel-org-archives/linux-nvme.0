Return-Path: <SRS0=cPwJ=HN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADAAC433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Feb 2021 18:33:34 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 628A464DCF
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Feb 2021 18:33:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 628A464DCF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=2Zl0+cin2Islv12WCQiU+iMDAQ6WwRULYNo8i4wpfR8=; b=bwEqzbe04EaSRiPFOQDmcBj7W
	PqxkQWMcKqlbuge3WJEfFR01+RBgsAmG3KVYfYcjm1mdi/uo9QzcKWqAUjXkZ/4iV6R9XLqmXU+/B
	gh5ntUSSvq5Pyn256/f1mzAin76oUlc9i0+O1m/9fXA+pyzr78dx7gjyJV73lHSx+FtM4QStMxnqR
	M58EfT7BMdhN5LZj4Zce58YV5bbNbb9n2aZwMxwLwQX1QHDPb43FLikVq0DVhooo7TQl6dt9qnZA/
	rqlsP6b4N6ZRZ4lyNdyYsl5tLE3URFPGJbh+tXPt2y0BWBzxEqxjfa3NJSstvcOyrKG/pWvMaiAJO
	l3mlZwW6g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lAGmP-0003MD-R2; Thu, 11 Feb 2021 18:33:29 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lAGmM-0003Kv-Do
 for linux-nvme@lists.infradead.org; Thu, 11 Feb 2021 18:33:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1613068406; x=1644604406;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=GYed2MA0GNM5Y0ctS8m2LyFIrLL23S76hPPLF+Ae4tc=;
 b=mLscAVTjwbX6C4mwYSrQdc2O0PL/myfqX+ucawXP0VpN8PGFGbnH6Z/X
 61BWDSW5//p1/DchUCg+eGpmbN/BA9FCduRzVNwQOAljk0JW2o9xTK/ji
 g6O503PClO6m9sRaj+kKXK1d7oIPddZf/cLRd4+6sxNwahrEbgXhF5CK5
 nQEb7YcLVjap39sHceUgwY9kghfVgs4kqB2s5adb5cW9MrfIR4OvnGbLY
 YMApA3GwQ6dAHdLxYF8U78uPze1JXQsu/PyK6k+rCuC6waPzGbezRv+Vm
 W4RmuNbY5ui6taUTXlYZLOcesujyMJbLn++QnDyPArFR+mqVnItMqCHt0 g==;
IronPort-SDR: 6de2RIlj++2jpA9cSy8QkgA4pNU8GOKmc0ums3dlTMDIOS4UpR5bUSATAIfD/YW57VOe2A54J8
 OatsgUH6WiAhdbayMcy+29Fxr5dOOWhihdJTTDhtIPCAaueTO2uhUZxRzQdMiJvisBuTxXhAiR
 z+Hu5XDEDn4FTpiNiCk+MzY3MeWBWhVCiefq0psTkTA8sBz2pN0AuFTODjgRwwxe1Q/uySg3Go
 MUm/YAA9AZc8lz1Egy8zajSsiBYaXfXc0WVZdLO5gq+M6/m0Ug54g5+4AZkEXgxJ1UYvtw5Zrp
 9cA=
X-IronPort-AV: E=Sophos;i="5.81,171,1610380800"; d="scan'208";a="159768548"
Received: from mail-dm6nam10lp2108.outbound.protection.outlook.com (HELO
 NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.108])
 by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2021 02:33:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z3OtvDsubTgUYI5jQWysaoqBQmN91ESYdPCw61mdVjJLq0MnLbxKRje+J7xXUSUZaXZR/CVVeUqdFz7352msJcbZOhqbQOwmHHrtjdG8uGdkUZp6UQFTRePRX6KvQJeR/2/jrV+Isreqhp23NyB9KIxboe05/xBaZicpWOIALvSyrd94bFzrVnwkyAdoBcs0DHeFQA2DM3DmqmJ7N5aPioLCLsqFJAaLT+jtDY6elg1pteXpCBmhqrIWIW8biNhBVQ5aAPpXdkSUgbZQvEsDT395yxLvFN3mvvgsi8HjIXpop50ekyir5WEm6vysbII6MDb75JTRw5mpj9okBPO+Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RufnIJ62Mzc9c3XmfhPqzGSQnUHnVB+aaBerAmu6H8I=;
 b=OiVtK0jVRl4ASeyMpH5Ma0RRdxyJ72lJWvceOKE9+oX993PcCczXY0gJOtkjNM+kI2iWC5zqLPaX42jd1mbSX/QO1bz0LoCXU4ZYqu8FMgbDa4Yl+6im+0feMVIqK6OTD1PgPrlq1+5eqXFazDhLmbpxPTm1T8n5pT2UZGzAJpEhn8EIX2feHwxwRBQJ4CPcfAGS/V+6ca8sQHr7MWo2mCZ3T6EtYsslFEasCMbErdhji4eN2w3838eyfdg6DPMFgDDLvs7dPDg3VLOcF2bNEL+4Lw9KQL+qPgkPNxjsj9QTuvHyME/HjSe3l83xr0Wy37KeN0IpO8wLIqO8FMlXQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RufnIJ62Mzc9c3XmfhPqzGSQnUHnVB+aaBerAmu6H8I=;
 b=uFOMZfso84tdvAlJgvp/t+RInxjy96tHF3qKiXbr8kCSuL74Uh7oGYBOIYzd/A8MFYYFno2hVNwlggQhWQ9GV68lbK2PXjyYz47ifBbO8dE6Lc6lXqtrmIOk/x48yRYla1nLNh4tKBv5JABQVI1myd78IgoUNQFbAz9Lid8wd9Q=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB7123.namprd04.prod.outlook.com (2603:10b6:a03:227::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Thu, 11 Feb
 2021 18:33:23 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3825.027; Thu, 11 Feb 2021
 18:33:23 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: nvme-5.12 is crashing with fabrics discover
Thread-Topic: nvme-5.12 is crashing with fabrics discover
Thread-Index: AQHXAGHGX9ypV4/+aUmbh2zu7YHutA==
Date: Thu, 11 Feb 2021 18:33:23 +0000
Message-ID: <BYAPR04MB496523687FF7402E1692AA61868C9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <f4f56a23-c458-5a4c-457d-d9478aea854a@grimberg.me>
 <BYAPR04MB4965CD9C122653C1009F0500868C9@BYAPR04MB4965.namprd04.prod.outlook.com>
 <20210211182357.GA25973@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2600:8802:2703:6e00:a1e7:39ad:c095:f42c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 37fbe84c-8e51-4f32-372a-08d8cebb839d
x-ms-traffictypediagnostic: BY5PR04MB7123:
x-microsoft-antispam-prvs: <BY5PR04MB7123EF430899344877837E5F868C9@BY5PR04MB7123.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:751;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F+XJKF2GUcVxzrgifczpjxs8enjEzV4dCTRuf8qoOvG72Af0HLWPUqj8SUvtSQhQ7o+2TIn8QFlwU1qsmUa2Z2OfckAYHzuryURRChp4sS5scKkf7j4qtxAGYYmCzW1ZlFsNQ6dZ3USejLNxgtgpTA8oQw+yPX1NgGqD48TAN5DZneDwpjfSeEV9GHtnXOx5Nrg0a42W+wxpzVUKhQc6a7Y/FmTA23Y/u3fc62p6+ymtbeEiQYVBwVec6iPmZRK9LJat40P77TfTTgy2cZXbzaLUNfY1cFIKsG+sFNJRVAuTXw2n/fs7B1/zhb/hNlfeZiKBQEyxsBovqDFmQSo9hJkws6LXVzkvAHBofb6se3knq3ErbAktnA9lOHHFZxHUn60vUEVQPHghgp6OlpSjYfT0Yxj2xD3aah4ucbq0XyLUb/tFdTJPe7vr9eDJWKXlkEBjpO/Bu3LQ100nw+za/vxAHkziwUYpm1uvDgejbkrajBaVRJ7ExeuQO4yUPMTymmRZ6BxfcEBKy1IbtZj+fg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(39860400002)(376002)(396003)(136003)(33656002)(86362001)(66946007)(76116006)(316002)(64756008)(478600001)(7696005)(66556008)(66446008)(8936002)(83380400001)(66476007)(4744005)(4326008)(55016002)(186003)(2906002)(6916009)(52536014)(54906003)(5660300002)(8676002)(53546011)(6506007)(9686003)(71200400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?eWt2EdbHQ6x154mNQQNtEJBXwJ4nFAMa6dYgjNI2elw+Fjs82RWaFOkWFxz2?=
 =?us-ascii?Q?lDEoWy2ComOwMe/YKZWB/WvwuSJZH+p0kLlwq092wQdzeI1irq+MScK0ax0g?=
 =?us-ascii?Q?VkXkP7Ty95QDFGEruGkk5WApQqrWJ1CQx7tmXervCGLNdHXUDX1DZOkZ7h2Y?=
 =?us-ascii?Q?xaeOlj4pEjArZEo2++El+IKutgENbKA4Aa56+Bys7jHbUIXntUpKzz1l+W3R?=
 =?us-ascii?Q?op/8TCv67+OJzURA64rqy5TzhJPL0lzzyjVErdD+uJrRfa1MQlpcFBgIz2LB?=
 =?us-ascii?Q?mTwxYLe6f7j4qjEaYRGABWwU5vP1Lj4QAmqEeAXNKOiQsovOzmMITAJX0ug6?=
 =?us-ascii?Q?iVrGr6DTwpNmzstJ7c+twp3tv6LW/gjUh+H+prktqyORhaTMbCANfa2rQQUc?=
 =?us-ascii?Q?NeiwAtMWr3fbJPHwJcYAp3EvkbzZ90V20lqFFPP2Naoo+eakSSDuAefO+VRr?=
 =?us-ascii?Q?hI1TEYhe8RqSCgTqVx1P+hYDdLr8D9F6vDBZLJxQzjGZmM0ZUa66BywHxieb?=
 =?us-ascii?Q?AAbbhinV6t+NZTu4y4j9t1gN8r3y1jOT/ZhORC8OVVwIwOBtaddY8AwSh5rj?=
 =?us-ascii?Q?zn1kpN+Tcr0Pz+crfxM8EA7N/MA2lkyV91ibIwa7nl7zRbgPGCBk4I3h5je7?=
 =?us-ascii?Q?TBV4kmuQcnVRUkutaP8UeS0mFP8oz5SILhCI9C8+YlGE+poC53fKwj6U0KVI?=
 =?us-ascii?Q?Tw4ta8IrAWYH9veqjiDkbAn578bnriSrbV4L+la8KXFU7h64m8Rmi0o7kdhs?=
 =?us-ascii?Q?VZMGkdxkF0jZS+dsHdbHPqGuQMtfKb5NMbJCfHqz5HwL+fgcZ1y1SLOyRDIE?=
 =?us-ascii?Q?IQKppZ7OYzskPZ5Qagk+NcAKu+fZugQK5jsnULn9ZYNN24rb9stpKV2u+PsA?=
 =?us-ascii?Q?o3DQVrH9eiZN8VLX9vt5ZABRjJ9K3WX0AbBIZkefyxL9u65ifEdH18oRkEzB?=
 =?us-ascii?Q?eGI3AQDcJQ2XfNiBe0It4RuTaMd+BMNo4vBnvHXx/8W0sOVDTKq/evV4HCFC?=
 =?us-ascii?Q?vUB9g9fFzKk8FU7DnL6qiPAuBj/+1Ofp2OZ2/eWtSdi19cApzpxhREAesVi5?=
 =?us-ascii?Q?+yXJZbsZGhM559qP9EmvJfzDgh05f+3td7BMZdJx5M/BybIFMzyOccYYLIEQ?=
 =?us-ascii?Q?VBKqebF0dmUOa7hFRzvAdaZx+IjeuguFsZ6rBOi/Zj9gdo5ZNQEy//lY+oH6?=
 =?us-ascii?Q?NWTJlI+cq9C86E3fG4a0bh6+AmFfdOcnKW5o8is5SdNHac5mu/sHFgu6aM2U?=
 =?us-ascii?Q?5SXiKeStxZsMqM0YdtCMq/gyV85zD+t9Irh8YSG7nGhM+/j5/mX4XKrj33Xy?=
 =?us-ascii?Q?4oKwHX0X4Qz6r9IcPoSExOGQOCmC9u0rOWlI8yyZZmNErlVRpCAPecW8VT30?=
 =?us-ascii?Q?Xzj52Y1ttSxSjp0kLmzOwmXyy4H1uO51aLxGvO8rwP3RodqqLw=3D=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37fbe84c-8e51-4f32-372a-08d8cebb839d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2021 18:33:23.3680 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IWfdG6m3+TOV2q3QlxyQUfOFouNKApm5T+1pxlEMEm8zfYWqUh5Q5dqthYrNAIByXsW56HXk3I2vLfwioY3N7A6xep+IRkFGae6utAXyuh8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7123
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210211_133326_683687_8763F692 
X-CRM114-Status: GOOD (  14.35  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2/11/21 10:24 AM, Christoph Hellwig wrote:
> On Thu, Feb 11, 2021 at 06:17:56PM +0000, Chaitanya Kulkarni wrote:
>> I think fix for this is present in the linux-block/for-next tree, can
>> you see if that fixes
>> your problem ?
> Sorry that I attributed it to Keith in my last mail, this was you.  Looks
> like it only made it into Jens' for-5.12/block tree, but not
> for-5.12/drivers on which nvme-5.12 is based.
>

Saw that, I replied to Sagi's email with that commit, not sure if that got
delivered or not.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
