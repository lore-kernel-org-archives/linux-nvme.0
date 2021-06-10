Return-Path: <SRS0=9ZED=LE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D4E7C48BD1
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Jun 2021 21:01:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0211F6100A
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Jun 2021 21:01:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0211F6100A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=uojQSa/V5p+GrYg57rL23bk67wMuP8Qc5oicwQXr+jQ=; b=JIxlO7CpS1J8gt
	66n81n8Tam8VrHzRgbIwkhH/gKOf1pkDuR7g9vNPTwfLigN/Ox5KgecKvM0iCMoSpsQBTma8twWwR
	Z2vt2Lvv4buq0C+ghbnujeWkGHWpXrNQ1mo5oXBuBdUnQpaj5HM5OeYuQFF4ikmgnKHpG0E4cnadU
	z6pZA4XuATCJ29m/YMS3bANt2cF5DMDUXo66yrMz+ENWIePw7X3qD4mTgB2gbtXiYxMgP+g8dqmbI
	QDYmafJ78vI+NyfqtPaoHAOWxNbpPswy7wRBtBESW3yMb6YsMy4JW+VbGJEMUnBxhViZ6PwsM1EoQ
	wWUD/+50AVRul1CyiptQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lrRnl-002UFe-Pk; Thu, 10 Jun 2021 21:01:21 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lrRnh-002UEn-PF
 for linux-nvme@lists.infradead.org; Thu, 10 Jun 2021 21:01:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623358877; x=1654894877;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=NflzKF2c5WXrsnW9pjsIkZjHJWEpA+Y0cgUDhcMip8c=;
 b=c8vsDSFoc0di3RCDyuk6GsL40IBXgToEuRGJpCC0HL0VOn6XG8KEXRT6
 AmZPoolsxBTHNpllQd2AlN1yeBvW4XE5FM4i+U6rGR1TycepH2jW2N770
 Kv+WXOlo7LxMEZ/oocbA5xtYIBx3QouzeAhtFITCxzwlJFmPEcV5t1aWQ
 0yP7GYx0XE1vRcRmMK6VXQXjdVEs5hoMQDwXPt4XNrD6DTyo6hLw4Ozf0
 ZyKEn/GA+tJ7O1ua6XHlmLhNTEDj0QzjYg6qVFWZRsvXYx0Ltx7fBnzzH
 OCTKpVqGVqkcV883FaIlTi6Vr3ZG2Sa6JH5QsKBSnIrdRxQJYl4F7k6rj Q==;
IronPort-SDR: dqZ8cj/fdGnVHnCfAbBh05VfLHfDe9Nnbnu0zDXaJf6wEGEppmNy0KbqCJS1ogRuhQNa6qPpmv
 HKw5+hIIQFPTgLbgXgxBuntUaXdy0uhMUQKjzjfcM37JxwVmiVl1HTRdwkhg2g3fo0fE2skS4Y
 93zCZAcWPy6enEX8JPsXS7eDzjCFUeTbF20k5Vauxw4cQUr07SpWfZ+bKao+h4l7FrLp1HAlr3
 dC391X4h0Pm+4UU7Ld4BwlHXTcs9bKpsEHMGBdFcB9ZSy9lGB6f4ldP2rJI2VYJ+gYaj8W7Hoj
 3+4=
X-IronPort-AV: E=Sophos;i="5.83,264,1616428800"; d="scan'208";a="176266331"
Received: from mail-co1nam11lp2174.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.174])
 by ob1.hgst.iphmx.com with ESMTP; 11 Jun 2021 05:01:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TUQqP1wpJTT24O2QrMLb/qhGxB0mPmuUN+z7d/A9nIH/AItfA/r5rpoFLjyFSZv8vbQgIqcMjz+J+vRHO7cFq/HIslYGu+0iDGJ2Ft3L60QkZ3cUWn9xIuIg1plxsuYeBLbIUFpkXYs3edg4TjNhscjc5/JCgq+gOHeB4+aJpiN+ODXWMUH3+yvu9GClbyrqRpBrzy671Gdj2kBhlwVwP4YAva6k5xtCQjgfrKWGPa+FxFAuJN68WVUYcNHP5/A5SMF8kNuzjD3juOXR1ZwfvVLzi3calHla1ldhwSx9zo5lsnLZfvLMRLrTjvqYa4mplkFO5VZTXm3SRHfuOp/Jnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LiisJl5LL1m13qV42VSgs057u6yhpxI71hztXtonoNA=;
 b=BpMTSrP2pSuyy5hTxTdQgqmgpteeEEth+nJC0LIFKNVom4hKxJhxm8t9RM7QMxc/pAUVf3LV7CFepcmJWXhOVj8z1Yncs3uBAHvRRNvhAOPvjHIzJCx68IR/2+W5RK2UGOJxtzd7eXkOVhemCqnekazM5zKqQsEmnisRkDAeM9Dmt87pS5zg5UF26S53JLWcZ5YJ8rjeLg9StBo76zaqb4lsPFnE1wBFpVc4EOuZ6MVJak3h5eCGM4dx8qT4R+pZbgiXkoyU3Y1yR5N68x5xJGKBB5ygSm/v3GB9DPxenSDZCtsRvfEKM6n4bNEeG8cSjAxOjQb9blCvb109Lx0fHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LiisJl5LL1m13qV42VSgs057u6yhpxI71hztXtonoNA=;
 b=XfacFJd2XpFa5dTHePO3RyfUOVzv/RaePXday79k+731QjY30HgDaiSqAGbg3j43qt45+I/d45eApJSrmflJ+8btT975HdALS0T0pEkK3RUah/eF7/68F+14EGcz1UC3NWT1mVSW8r4RqtMkI9s1dw0/JyTMeqlvFIHrnTnABxs=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7261.namprd04.prod.outlook.com (2603:10b6:a03:294::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.23; Thu, 10 Jun
 2021 21:01:15 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4219.021; Thu, 10 Jun 2021
 21:01:14 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] Revert "nvme: verify MNAN value if ANA is enabled"
Thread-Topic: [PATCH] Revert "nvme: verify MNAN value if ANA is enabled"
Thread-Index: AQHXXaK3o1g8yliZMUm7tWfZRJ//BA==
Date: Thu, 10 Jun 2021 21:01:14 +0000
Message-ID: <BYAPR04MB4965AE59EF50A714B12DF42886359@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210610024539.28875-1-chaitanya.kulkarni@wdc.com>
 <BYAPR04MB49655A9B821FEE29D7A89E3986359@BYAPR04MB4965.namprd04.prod.outlook.com>
 <20210610074546.jyqjalpldii6reg6@beryllium.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 341c460e-7fce-40e1-01df-08d92c52e28d
x-ms-traffictypediagnostic: SJ0PR04MB7261:
x-microsoft-antispam-prvs: <SJ0PR04MB7261B9E6FA2E946B60B06D0886359@SJ0PR04MB7261.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h6zDRClWwhZEaaXq+0jEc8HJDlSJZLbqIqUdJGdZDd60zGq466os8SoYTALQX0t9VSe5vptfBNjE7HS2C1t8RgpchAsGAscBkEA48Ubs8ID/RYUjIg73urWkMujpr4VriQBlYFcV5ShcOo+OCthkEawX/N8DyCqfsxwqq32rAaq+Kd8jQMmWk8V16pMnJydGhC9lTuDL6MJREHbzB61tvrMOr9SuOACKYQLgc/f8VwLHFpMOxZXGY20Wvxk/y4RredZrkExeGCqXHjurWwBAcc/7EhWr6NAHpTO/Rv+6mokUp/MRgACS7ACHFbYd5lQyPqOaABE95YwQmDlDnomQ9QRUhKP0t06FLNyg2v3U2euOnxBw2wfc+BcZcUi8mQIhQDJPuYYKFxeRPgWHH9PYRRbI9PngJkkSOPAG1O2dKx6zpYpP6Owl6ivZ07egcoMpAaryNLg0dhuybiKXE7wCfTLdo/+RJ68W51PYkEFKYv5KM/Y9YTYaE0DHjMscpVvHJnHkwXqnY7aJRUrQN/3NNqbaBI8ZKJiNT65qdowaXPZsiGy/HWWxdwwXCDUj9AQ7QxKqbyDSbJUOEf23itYRftQ+JpQOEeCxXAoUpcG74OY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(346002)(376002)(39860400002)(8936002)(33656002)(8676002)(9686003)(66946007)(6506007)(26005)(66556008)(66446008)(64756008)(66476007)(6916009)(186003)(478600001)(316002)(38100700002)(55016002)(71200400001)(76116006)(83380400001)(122000001)(4326008)(52536014)(7696005)(15650500001)(5660300002)(86362001)(53546011)(2906002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Hw3LtMSWizBiVS26WAD3bm0IH3zm3kdbtQk21MQtm9cxMOTRlNuyB2scRBnB?=
 =?us-ascii?Q?bm48ULx9CPZW6RYuyNu0W+c1lINtLaQ2Nt0fxt2VZNwob28bU/1jvaF/JXQQ?=
 =?us-ascii?Q?QYmgfY2x4aYPRPkXw0gSb8ZNLNGzhii0/csnuDwu+jUfrLIEqY4q0q4pLe9V?=
 =?us-ascii?Q?dzvA3xkxVD24s8aM/jiG/907ajbQT4hFotaVj/a5cR1lDj8HW612nzsInxdI?=
 =?us-ascii?Q?bF76s1R9MFdTyMmhuwM2GsywW8DbY6Z25eVeR2CblHTmf4w6czTOkCvvJqyl?=
 =?us-ascii?Q?7KpNflFc1tVVSc9ksKLiEX9odaUFDWOIym8+UnD5V23GGFIIzc474ueIpXtw?=
 =?us-ascii?Q?MxheWgjcn3hCZckduidDNOBY/Xs+pppLVT3e8apy3vYRCSYMVOcGtRu7q9EK?=
 =?us-ascii?Q?fJ59Y2UTKBIxq52dgqZLxKvye6tLNZRq7mNlX1wywetjGpA1aqokdEn3W4va?=
 =?us-ascii?Q?x8uvzwjPALLSar1jZsDnxrd6tjeHCYtEfMXiMzT6T0y6PrG0DzBs0fR0JSLs?=
 =?us-ascii?Q?YYS7B4Gta5/bEDVRd7yDKyscHrHSYpiqmpMPvguWmLrzaKyne3HFe/8gcpoR?=
 =?us-ascii?Q?YOQ5XmeHppChrgB2Gt8NBhV8VvHreNBPobI8DcW8RIS4r3G37Ep0GxP5K7Me?=
 =?us-ascii?Q?gAlduU3FoYrVg6K5BuCP7kELfJlfnQwADmnXuwjKNuGskuP/iIydGkxysekN?=
 =?us-ascii?Q?Hodmcx9qsixCw5MJcD95mXQqmYecOuRiK6feVRpioaOaZBEIKWC+R60/0kOD?=
 =?us-ascii?Q?KHf7C4+MRzbpAq3nSQgcowvoYkBAJ+hCStvO+JMFniJK30HHb0jOLMqA5s8t?=
 =?us-ascii?Q?SjUhp67/H1B6gt87uk08SxHU1TMqzwn6sDkTh/hUXW/f0s4EHmoGLI08/UDH?=
 =?us-ascii?Q?hNwoXesvH5S2RzTnjC7z1KroNhWLOroJKadguw3orko5xZYz2bBe1Sm05FWO?=
 =?us-ascii?Q?qQYeYuCSVYPWEz88jaOk9tWQR4KNmT0yU+Vo+6scrIBS62Yif3XPjcYm389v?=
 =?us-ascii?Q?of0LdUHzwIbncZ+N+V2/dz+c6NuufccAE7MBBmriq6bSRCeeKgjF/xNiBYDM?=
 =?us-ascii?Q?GMh2T6O0ArsMoqz9YN3+W6xOMaXsf4FS5jDp4JvvXQm0QeEPkun4ebHZ9VrL?=
 =?us-ascii?Q?PhRphuhPvLpZeQrkb8OB/4Dp6JH162S5EaWw3V4it2/5uhIESummE9hbdkin?=
 =?us-ascii?Q?wQHKSGxYceTvS1QkJyrWN1zft5RKpkN7Pwj/2XeN+Tyv+NPnklZnEcNlKaPl?=
 =?us-ascii?Q?kGV2RZy+su9DaVZ5aTaaHcX4LlGujZgrh953no+MGx2zcsiIYtbwn6/OW5UY?=
 =?us-ascii?Q?YG7W/tglgmLY10PZVR+B5L4y?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 341c460e-7fce-40e1-01df-08d92c52e28d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2021 21:01:14.7939 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ebr0LP4Lq/AzJ2wHNHwxMbxsT+WIWDvg4nKFb+FqO2mBj0sQeZKdra6KZZ8BUOkA/ZQQaeAQ+LEALxRad5chQYxTlGrLCBwz1K6GWkkXN6k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7261
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210610_140117_894131_6B4D717F 
X-CRM114-Status: GOOD (  24.00  )
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

On 6/10/21 00:45, Daniel Wagner wrote:
>> diff --git a/drivers/nvme/target/admin-cmd.c
>> b/drivers/nvme/target/admin-cmd.c
>> index cd60a8184d04..a8ec377bb68d 100644
>> --- a/drivers/nvme/target/admin-cmd.c
>> +++ b/drivers/nvme/target/admin-cmd.c
>> @@ -394,7 +394,7 @@ static void nvmet_execute_identify_ctrl(struct
>> nvmet_req *req)
>>         id->maxcmd = cpu_to_le16(NVMET_MAX_CMD);
>>  
>>         id->nn = cpu_to_le32(ctrl->subsys->max_nsid);
>> -       id->mnan = cpu_to_le32(NVMET_MAX_NAMESPACES);
>> +       id->mnan = cpu_to_le32(ctrl->subsys->max_nsid);
>>         id->oncs = cpu_to_le16(NVME_CTRL_ONCS_DSM |
>>                         NVME_CTRL_ONCS_WRITE_ZEROES);
> This looks like the right fix for the upper limit problem.
> I can see the tests are still failing with
>
>   nvme nvme0: Invalid MNAN value 0
>
> which indicates there is another problem in the nvmet core.
>
> I try to find it.x
>
> Thanks,
> Daniel
>


With following two patches blktests test-cases are passing for me.

root@vm nvme (nvme-5.14) # git log -2
commit cd5d6d55a405f97ad5c31a738976eea0e16ebe20 (HEAD -> nvme-5.14)
Author: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date:   Wed Jun 9 20:07:56 2021 -0700

    nvmet: set the mnan value to nn
   
    From spec :-
    "MNAN : If the controller supports Asymmetric Namespace Access
Reporting,
    then this field shall be set to a non-zero value that is less than or
    equal tothe NN value".
   
    In nvmet_execute_identify_ctrl() when building the identify controller
    data structure set the mnan value to nn to follow the spec.
   
    Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

commit 1368a1a5e7566d726bf74234d05895c3f0d54690
Author: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date:   Wed Jun 9 20:07:00 2021 -0700

    nvme: fix the comparison in the mnan check
   
    The existing check for the valid mnan value will result in the error
    when ctrl->max_namespaces are set to the 1024 from NVMeOF target since
    !1024 == 0 so it will lead to next comparison 1024 > is->nn which will
    be always true untill target has 1024 namespaces.
   
    This patch fixes the comparison.
   
    Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
root@vm nvme (nvme-5.14) # cat
0001-nvme-fix-the-comparison-in-the-mnan-check.patch
From f1f0947ca495b7d9b8721411e407ebf9efad0df9 Mon Sep 17 00:00:00 2001
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Wed, 9 Jun 2021 20:07:00 -0700
Subject: [PATCH 1/2] nvme: fix the comparison in the mnan check

The existing check for the valid mnan value will result in the error
when ctrl->max_namespaces are set to the 1024 from NVMeOF target since
!1024 == 0 so it will lead to next comparison 1024 > is->nn which will
be always true untill target has 1024 namespaces.

This patch fixes the comparison.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/multipath.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 23573fe3fc7d..4277f1554bd5 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -813,7 +813,7 @@ int nvme_mpath_init_identify(struct nvme_ctrl *ctrl,
struct nvme_id_ctrl *id)
         !(ctrl->subsys->cmic & NVME_CTRL_CMIC_ANA))
         return 0;
 
-    if (!ctrl->max_namespaces ||
+    if (ctrl->max_namespaces &&
         ctrl->max_namespaces > le32_to_cpu(id->nn)) {
         dev_err(ctrl->device,
             "Invalid MNAN value %u\n", ctrl->max_namespaces);
-- 
2.22.1

root@vm nvme (nvme-5.14) # cat 0002-nvmet-set-the-mnan-value-to-nn.patch
From d18c2c851686c4e5fa8ddb457e6726cafb86b85f Mon Sep 17 00:00:00 2001
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Wed, 9 Jun 2021 20:07:56 -0700
Subject: [PATCH 2/2] nvmet: set the mnan value to nn

From spec :-
"MNAN : If the controller supports Asymmetric Namespace Access Reporting,
then this field shall be set to a non-zero value that is less than or
equal tothe NN value".

In nvmet_execute_identify_ctrl() when building the identify controller
data structure set the mnan value to nn to follow the spec.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/admin-cmd.c
b/drivers/nvme/target/admin-cmd.c
index cd60a8184d04..88e85d9a5be8 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -394,7 +394,11 @@ static void nvmet_execute_identify_ctrl(struct
nvmet_req *req)
     id->maxcmd = cpu_to_le16(NVMET_MAX_CMD);
 
     id->nn = cpu_to_le32(ctrl->subsys->max_nsid);
-    id->mnan = cpu_to_le32(NVMET_MAX_NAMESPACES);
+    if (IS_ENABLED(CONFIG_NVME_MULTIPATH))
+        id->mnan = cpu_to_le32(ctrl->subsys->max_nsid);
+    else
+        id->mnan = cpu_to_le32(NVMET_MAX_NAMESPACES);
+
     id->oncs = cpu_to_le16(NVME_CTRL_ONCS_DSM |
             NVME_CTRL_ONCS_WRITE_ZEROES);
 
-- 
2.22.1

root@vm nvme (nvme-5.14) # ./compile_nvme.sh
+ umount /mnt/nvme0n1
+ clear_dmesg
umount: /mnt/nvme0n1: not mounted
+ modprobe -r nvme-fabrics
+ modprobe -r nvme_loop
+ modprobe -r nvmet
+ modprobe -r nvme
+ sleep 1
+ modprobe -r nvme-core
+ lsmod
+ grep nvme
+ git apply ./all-fixes.diff
+ sleep 1
++ nproc
+ make -j 64 M=drivers/nvme/ modules
  CC [M]  drivers/nvme//target/loop.o
  LD [M]  drivers/nvme//target/nvme-loop.o
  MODPOST drivers/nvme//Module.symvers
  LD [M]  drivers/nvme//target/nvme-loop.ko
+ HOST=drivers/nvme/host
+ TARGET=drivers/nvme/target
++ uname -r
+ HOST_DEST=/lib/modules/5.13.0-rc3nvme+/kernel/drivers/nvme/host/
++ uname -r
+ TARGET_DEST=/lib/modules/5.13.0-rc3nvme+/kernel/drivers/nvme/target/
+ cp drivers/nvme/host/nvme-core.ko drivers/nvme/host/nvme-fabrics.ko
drivers/nvme/host/nvme-fc.ko drivers/nvme/host/nvme.ko
drivers/nvme/host/nvme-rdma.ko drivers/nvme/host/nvme-tcp.ko
/lib/modules/5.13.0-rc3nvme+/kernel/drivers/nvme/host//
+ cp drivers/nvme/target/nvme-fcloop.ko drivers/nvme/target/nvme-loop.ko
drivers/nvme/target/nvmet-fc.ko drivers/nvme/target/nvmet.ko
drivers/nvme/target/nvmet-rdma.ko drivers/nvme/target/nvmet-tcp.ko
/lib/modules/5.13.0-rc3nvme+/kernel/drivers/nvme/target//
+ ls -lrth /lib/modules/5.13.0-rc3nvme+/kernel/drivers/nvme/host/
/lib/modules/5.13.0-rc3nvme+/kernel/drivers/nvme/target//
/lib/modules/5.13.0-rc3nvme+/kernel/drivers/nvme/host/:
total 9.1M
-rw-r--r--. 1 root root 4.0M Jun 10 13:50 nvme-core.ko
-rw-r--r--. 1 root root 639K Jun 10 13:50 nvme-fabrics.ko
-rw-r--r--. 1 root root 1.2M Jun 10 13:50 nvme-fc.ko
-rw-r--r--. 1 root root 1.1M Jun 10 13:50 nvme.ko
-rw-r--r--. 1 root root 1.2M Jun 10 13:50 nvme-rdma.ko
-rw-r--r--. 1 root root 1.1M Jun 10 13:50 nvme-tcp.ko

/lib/modules/5.13.0-rc3nvme+/kernel/drivers/nvme/target//:
total 8.3M
-rw-r--r--. 1 root root 718K Jun 10 13:50 nvme-fcloop.ko
-rw-r--r--. 1 root root 623K Jun 10 13:50 nvme-loop.ko
-rw-r--r--. 1 root root 1.1M Jun 10 13:50 nvmet-fc.ko
-rw-r--r--. 1 root root 4.0M Jun 10 13:50 nvmet.ko
-rw-r--r--. 1 root root 1.1M Jun 10 13:50 nvmet-rdma.ko
-rw-r--r--. 1 root root 868K Jun 10 13:50 nvmet-tcp.ko
+ modprobe nvme
+ git co drivers/nvme/target/loop.c
Updated 1 path from the index
root@vm nvme (nvme-5.14) # cdblktests
root@vm blktests (master) # ./check nvme
nvme/002 (create many subsystems and test discovery)         [passed]
    runtime  40.408s  ...  40.579s
nvme/003 (test if we're sending keep-alives to a discovery controller)
[passed]
    runtime  10.179s  ...  10.180s
nvme/004 (test nvme and nvmet UUID NS descriptors)           [passed]
    runtime  1.786s  ...  1.794s
nvme/005 (reset local loopback target)                       [passed]
    runtime  2.241s  ...  2.233s
nvme/006 (create an NVMeOF target with a block device-backed ns) [passed]
    runtime  0.147s  ...  0.152s
nvme/007 (create an NVMeOF target with a file-backed ns)     [passed]
    runtime  0.097s  ...  0.102s
nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
    runtime  1.793s  ...  1.792s
nvme/009 (create an NVMeOF host with a file-backed ns)       [passed]
    runtime  1.749s  ...  1.751s
nvme/010 (run data verification fio job on NVMeOF block device-backed
ns) [passed]
    runtime  38.113s  ...  31.199s
nvme/011 (run data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  296.910s  ...  302.248s
nvme/012 (run mkfs and data verification fio job on NVMeOF block
device-backed ns) [passed]
    runtime  8.823s  ...  9.221s
nvme/013 (run mkfs and data verification fio job on NVMeOF file-backed
ns) [passed]
    runtime  23.517s  ...  24.288s
nvme/014 (flush a NVMeOF block device-backed ns)             [passed]
    runtime  22.787s  ...  20.386s
nvme/015 (unit test for NVMe flush for file backed ns)       [passed]
    runtime  20.599s  ...  23.212s
nvme/016 (create/delete many NVMeOF block device-backed ns and test
discovery) [passed]
    runtime  21.616s  ...  21.016s
nvme/017 (create/delete many file-ns and test discovery)     [passed]
    runtime    ...  20.721s
nvme/018 (unit test NVMe-oF out of range access on a file backend) [passed]
    runtime  1.777s  ...  1.752s
nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [passed]
    runtime  1.795s  ...  1.805s
nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [passed]
    runtime  1.756s  ...  1.746s
nvme/021 (test NVMe list command on NVMeOF file-backed ns)   [passed]
    runtime  1.734s  ...  1.745s
nvme/022 (test NVMe reset command on NVMeOF file-backed ns)  [passed]
    runtime  2.168s  ...  2.181s
nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [passed]
    runtime  1.782s  ...  1.776s
nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [passed]
    runtime  1.730s  ...  1.743s
nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [passed]
    runtime  1.719s  ...  1.767s
nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [passed]
    runtime  1.718s  ...  1.732s
nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [passed]
    runtime  1.754s  ...  1.748s
nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [passed]
    runtime  1.753s  ...  1.776s
nvme/029 (test userspace IO via nvme-cli read/write interface) [passed]
    runtime  2.280s  ...  2.244s
nvme/030 (ensure the discovery generation counter is updated
appropriately) [passed]
    runtime  0.425s  ...  0.401s
nvme/031 (test deletion of NVMeOF controllers immediately after setup)
[passed]
    runtime  6.134s  ...  5.996s
nvme/038 (test deletion of NVMeOF subsystem without enabling) [passed]
    runtime  0.075s  ...  0.059s
root@vm blktests (master) #



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
