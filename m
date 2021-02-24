Return-Path: <SRS0=qQKB=H2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE59C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Feb 2021 21:53:14 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0685A64EFA
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Feb 2021 21:53:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0685A64EFA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=gdOudREe0cuTV3iWpw6yNd5yTEj2L2eoKYRnFTplqow=; b=IIuGepTgCJxR8vpW23CDJ35Ig
	8GMTwvFlh53hpCK4YIeGmungB5OnFhiYkmHIkdh1hT30FfGGBWoDgZYvAbIEKHy3Tqugr5oNjTZYn
	IGAR2nzBX+vT4JPL1k9K3wTW8Nzqhp0taBgtmv79fvKt6+mluT1S2Ww1wFmPCoSJqwczUMz2KAZlw
	iRgS2Hyd/M1I48MWw7+DUwKTm1KSkcmuqA+pfJnV3E/w/ZN3QL8ZiuFiSnlhSSJU6Aa3X4jGjfAkh
	8dKf5ES/+vIW924dcElLDx3cXQ6GcnszLjIyHwAg3XmQjq55c8jFxiUyCpkK65BSFo008/UgqO2iq
	+osx8In9g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lF25c-0002Bw-2t; Wed, 24 Feb 2021 21:53:00 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lF25Z-0002BU-Mz
 for linux-nvme@lists.infradead.org; Wed, 24 Feb 2021 21:52:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1614203577; x=1645739577;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=ypb89vYpzt0h8LOMvpq5U16WBtRVDAJaYBlkfUj4gzI=;
 b=JAvIxzlvpSNtgQumCPxAbxLs8HB1CzCMUiReymBrcJK8f9Ic7O2yYxPn
 zzCqyqqOP9/jGow2apWdAJXs8A9Xji22laEofOVWEaPyNj7HKqcjOiq2W
 W3cSRVmRwX9ebZTu+eYZqRTe0kubP2yiuy638QwuqLulJcjyWBhmrvT8I
 WvQABYrJSe1+ue7dGoJudDLTpR1zBS7w30li4LLLrG1FrQPAZ71sQW665
 eAY1iIv2/F7qEu+LkakVrvD8fneAYgl4CSn8+7CHnssiUqO0XYaFJtZtJ
 5Sr42+2egL5N0co4mZ3b+6K9ZKoh/JYIyBf2yoxear2QxEkK/noolkHFS g==;
IronPort-SDR: ixLh9wEs11yLXmyKsCJw2xnefDNqgOQuxsnmVmJXOrl0rTCDUxPS2MULwNndy8OEIotH0xU4KL
 uuMcMhHyhWWXR/kzj+zdMPP6PZ1SREDuygm7jdv+SVVsVpuw52ohYeGWDv+KD+Gyg/bs9ZPm9j
 BRiv1DMZvaIE6tIjbVSDBs0YObjY/mH/SqG28HbDIr1P0oQtJ3SpVetiWZQwlRqYvpV2YiWj2o
 UuVzxvDdHW9xj6v9BF72i7OT9QyWqjJvSHfMdU/pUof7QP+ZeYQJQeHu4uhmghZ2r89+Xle/0r
 ZDU=
X-IronPort-AV: E=Sophos;i="5.81,203,1610380800"; d="scan'208";a="165212506"
Received: from mail-co1nam11lp2172.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.172])
 by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2021 05:52:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lFH3vL2tyY6RFl/u7ipv2E8q9H4AcXRhm6lHovVnu9jFnvSkx6jfk0Y+/SZGRU7i5n0QcFvqStymUmVtMGDPszbICKi0KfG3Y+sKdLp9aINLgPXCheYljrZgQ15qw9foVEuOPT5Rhx/EtyMgK33qYv6145Jkb2c8rKgQB4GBZEDYpqZHTiDzp1RTXKqidz++vhnVPmAJRLPQThueMlPS0PzI19f5Nu3JqB/0OxaK117J94heudBYzxJuqeMWU+jioqsoMQkjCgBraUZQxz40Y+/ZwS58M924ZqQeSnsdg3rX6GwCRjzO1et1kCP7IK2rF3L0IHAHr4mLSf4l6AHC8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ZKvUPHiCfGtzHbtlY+0oK+8TYq6/6LvQMDnen5tVWU=;
 b=ctNhs4jyYn+VqHe7WPmxcGkpidQuiWiYiAu7fMv/8gUbIg34Oo8amVa3FY44xtwNuuU0drxTpIrpdofs3ghDmJRTYB4FgEpFNszoKRyTBBI+ukmjKlTq7nLpdH2cGPmdmfRg70Sa53LfsFPQFOTpzC6S6Z+Dz1IxzMzrqzsU2bxgGlstBEw5sv2cENlSt9frGhSQv3LhUmhup9OPGgsbeHG2Lpc+bd7Eu927S4F72T9GVYgyuEUCLrGrgdNmqhSbzcSqEdQBmZ3gx385HKFLiOFH1EsBcVN2o3bs+s8GYtiS5qk1pR7wmGpRdufcBZ1x5NV/oko89MMpGN1iI2VVkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ZKvUPHiCfGtzHbtlY+0oK+8TYq6/6LvQMDnen5tVWU=;
 b=dpZ7dx1ctCFbtNFJgOZN72HmiTCmHnw5HCwvN7FN4sfEbl5jywOAYDkRa912GMr16miyjo1PRfh3bsbbCuEB/sQOiniU3YP0seeag9p/wi+PI2u1ZtoeyJOTSuP2CWQKbDSyYFJ1dVgjJFrcyT6658s0fphOjBSTDL+sHFje1aE=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4757.namprd04.prod.outlook.com (2603:10b6:a03:55::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 24 Feb
 2021 21:52:52 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 21:52:52 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 00/14] nvme: few cleanups and small improvements
Thread-Topic: [PATCH 00/14] nvme: few cleanups and small improvements
Thread-Index: AQHXBMFRdhpEFB8Bg06h4gqvmdJB1Q==
Date: Wed, 24 Feb 2021 21:52:52 +0000
Message-ID: <BYAPR04MB4965F8A3DC3ABB6A4FDA28AF869F9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210217001032.25741-1-chaitanya.kulkarni@wdc.com>
 <20210224154229.GA26830@redsun51.ssa.fujisawa.hgst.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fa9a591a-9226-47bf-acff-08d8d90e8921
x-ms-traffictypediagnostic: BYAPR04MB4757:
x-microsoft-antispam-prvs: <BYAPR04MB47572281F18F566856F962F2869F9@BYAPR04MB4757.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hKx0RSJU17sxST8ngknEXASZ5pcA9Bl8h3GNsb8olbJ10SQO2hB1NHSuszdn0diMIw4SYiGTzlheKiqpC9r9aE9lT4CR921hhEOvJV52zq6kFf3YOilqZsAQ1vveWLnsFF5ICyGFFpNYpFUmwBcSZxykF8E7G+1sMe9Gtp62fD+n52yb8S4Qyzbi3vzpnBCySETx9ywO8rP5KIGrRVp/2fxQONNOWiIu8WrdVeWWr9n81Bv2BrlOfc27J7o4Zy+hDwVdgy6WCERxBK2RbvLMkLVSAXifxHUJgTTH+1v93NItQyiAm6mijs2QTNogYq0nRKYqCS9/DCPi1PZ0dYltT0usnC25ZkHJE53Nm4g4YNSnYitfHhwz7yTHyOSQUjvsD5/DeETWJZ94tDHpIzY0BlSbuvnA8HTZWFQeEjTZLgTo3775LmMRNWbEaAVvRULDRTQEEbEb0pwkzgOF/zxewpgGMbKK4kDRP2QYCbFwIvDqB+ZfIKH1wUiBMd6cJhzRe48AGvhbhMS1Gy1iUI+1wg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(136003)(366004)(39840400004)(376002)(26005)(186003)(8936002)(66476007)(8676002)(66446008)(66946007)(4326008)(76116006)(64756008)(9686003)(66556008)(55016002)(6916009)(52536014)(4744005)(91956017)(86362001)(7696005)(5660300002)(53546011)(6506007)(478600001)(54906003)(71200400001)(2906002)(316002)(33656002)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?0XKQ13KHOf1ZkSO9xDPgQhAoQVTAe5w3bh5jpxnSuKoOy2e2W7ON/wW89hAi?=
 =?us-ascii?Q?Ghkqd51yIma6WXSYs8PVdL78olFmk8gmgS9UwBobw82Q5c6FfWtWRs/skv6a?=
 =?us-ascii?Q?AksUdX51PUb79m8stBVmgWc7PBlKluCcCo7cFpYkRBL3yPdth9BhT2ajbyww?=
 =?us-ascii?Q?wxNLDkhvG8VD+DY+JIinUR9/6lBaW/ie4XZROKwtHMNI0PSyWdZaf1VMwSMl?=
 =?us-ascii?Q?VjNlsZ57SvGUKlFfT/Zq8VdkcQVixJsjiGfhOSyuss38U/w8HyeXvhDy31Sv?=
 =?us-ascii?Q?thYScH/hBS9S+chusr+GbziPxqv1MvmpJGpKvXbfbWy361KTrcSNIdhr311p?=
 =?us-ascii?Q?G86nllCfK+35x4SQUOBAID4UytJOXtyrVXq5dPLw2PuBAlMhrlhNoon+1A61?=
 =?us-ascii?Q?xalY3sSSd/Z8CsubcnsgYS+70k51IKZr5UTd100tI00PUWrw5HcfsNp2bkhI?=
 =?us-ascii?Q?vjadu/WdJkR96mSnAQlfsI3UW6XxWN05eBXmP+XC66bgYgrCx/eVWQPb3Coj?=
 =?us-ascii?Q?VVFmIkctI9B5pJuoZ4brce9SxYjU0iOIy5b0hVJBtDHYhT+4P3Tr/FQXYzK4?=
 =?us-ascii?Q?g11qR8cZjhcIBVPnhXcquP9PlVx+4BeVsLLitlWzi8fVTQQTgw0kKJ59PHVv?=
 =?us-ascii?Q?qrvp4HDIhtOHkyZjzmV3piFrTuiE34zswa8ZiW1GG2UXUhUFCO28o9SRoJKj?=
 =?us-ascii?Q?mpYF/neYSSK2DCSqpxmsQC0kPVbWPiKmp7nzwpBTTBUjbxRM1FUCvehrYGjc?=
 =?us-ascii?Q?nbPkfvQkdr7BCx1m7kxQrBp72RnYSUcDxOKz9RGzWC77Uy8jywb82I7LOZ5g?=
 =?us-ascii?Q?CkXRf1ipOIUgwVlCAs+Nv03dVr7wr08wM8zHg40XTyOjTj0o05Jjo/aiZ3kH?=
 =?us-ascii?Q?bBcH4SvI6qpcbdfAciLZVDrp4xJNosGdPorrlbsWDCuhZZ2/mOZ87LjtWHQL?=
 =?us-ascii?Q?4utV8TbbvusoLbJJdzxVTK3/kE+RohzOZQILrSGatJHCOYAaBtpUJSsFUgxU?=
 =?us-ascii?Q?DcyWkuXey4cwXZLqmIO5Km3I9H8GkC5Pls7llRCn/7CfdgyKisZqjDiLkjf4?=
 =?us-ascii?Q?+/XWQjZjaFsKOXKZsmidVg3YIIg0HmXz+lEJLR1WcYmVM7LODMyRaZBdHnCI?=
 =?us-ascii?Q?YoPqn9oGBXR1rT5/dlPwLKF6gFr1of8Et1SHrAQGkk8pOncCQoC5tt/evotT?=
 =?us-ascii?Q?bmS/pPgcF3+hzPNXa91CmZbgeLQL4dBFPkCgiaFbxRVuYVCzceSLnqJGjC1D?=
 =?us-ascii?Q?yHIojClBbvYvDofgEMR2hDreMqkyzLMgXggUdRNZKND88wqeaAWli/AqlRxG?=
 =?us-ascii?Q?HaTUkSKGQJ/LFKVLhiSrdUG1N5PDFoKNvnlRFoT5b2nL8w=3D=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa9a591a-9226-47bf-acff-08d8d90e8921
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2021 21:52:52.4961 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6FXs+ptCdIlEtUNvBuGbpL4IFDSHE8oZ+FTZYBceTryTQoG/UNxkFQU39/fQw0VwZXwNtRCJNopib/bdmvYywi8vPF6cq4EnycfTicA+1WY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4757
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210224_165257_919946_366DD153 
X-CRM114-Status: GOOD (  12.45  )
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
Cc: "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2/24/21 07:42, Keith Busch wrote:
> On Tue, Feb 16, 2021 at 04:10:18PM -0800, Chaitanya Kulkarni wrote:
>> Hi,
>>
>> This has few cleanups such as variable data type, removing oneliner
>> wrappers for single callers, removing duplicate kfree() and small
>> improvements for NVMeOF Passthru fast path such as likely annotation,
>> removing the extra checks, making function inline for host/core.c.
>> Last couple of patches fixes warning for FC function header
>> documentation.
> The two documentation fixes at the end look fine, but much of the rest
> looks unnecessary. 
>  
Thanks for the feedback Keith.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
