Return-Path: <SRS0=pISK=JY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C658EC433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 02:34:38 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A044613B0
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 02:34:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A044613B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=S+NzNUPgPimvjYQtY1RFhka+jC7ZGOsnv2KEJrmjnFI=; b=ouFA9TgbeRKjkyQFPJSr5Smla
	lZxNLEzpyT0OvEBcYzUv8U3N43Su9hkPX8RAgc8PnG1/QpOsrhCeC2FUuX4DRslbiTdBoMT0y/lo3
	TNoJ7pMj4xloD2p2fqsTjC130cnxlCeQ1CrLVbvtt9ntxGweijovfaIxJ3Wk+i25Lx3I/F1vJf1Jr
	JBarmImS+p7hYoogcLNARLGRqkJJV0K7x7tfmDWReAWtq7He9Bf40j0uJuZdHiqipuzmX4kO/D4K9
	ehgg4t2TKX8WtS1rjWKoAgnft2DE5/U7eke88URBYXGwm3OhFWhv/1Ur5Yo5U2vdqM8H3DKYUzSor
	yDRTJV06w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbDYP-000TrE-Ld; Tue, 27 Apr 2021 02:34:25 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbDYL-000TqZ-3p
 for linux-nvme@desiato.infradead.org; Tue, 27 Apr 2021 02:34:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:References:Message-ID:Date:Subject:CC:
 To:From:Sender:Reply-To:Content-ID:Content-Description:In-Reply-To;
 bh=lIJ1IYgFjhQu2Z0C9ltXtqRxNrOh1lTTjY6jH/lzagM=; b=wb5/9gr/V/M27SX+20gz0+Y0Za
 1b6JfxrV/vqUm4tiYa27FzQmW9tz++7s2iLVptvfmB6qq5ya6wREXgkeHq/KT7tLSsdOQNXRV7fzH
 XXKWewW/hljxRnTrxUDwg7RDvNDNSbaB1wOWYPQnm41C3DquFfsfTr3xlSxzGk8/9RoFoPnRhBpiu
 dIt1owwGmY48ubO7B2xQ74Iq99T7rUgQSt31pXUD7qK1TkW2vflx0jMyrBxeeAImhMIz5stYMVwaX
 1XgCJquxIxEKzImA2n2BplxClNTdJBtX58bTtFRXASEnkmMTolmmLRXLR2oy4l84M1uxm+Lpm3+sU
 dTtdiCGA==;
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbDYI-00GO9I-Hd
 for linux-nvme@lists.infradead.org; Tue, 27 Apr 2021 02:34:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1619490858; x=1651026858;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=lIJ1IYgFjhQu2Z0C9ltXtqRxNrOh1lTTjY6jH/lzagM=;
 b=qOhVt3RpNAP6b9cYexF4j5Ke8MA9XUvxAKVeS4lHUzgbRc6gujgtrTUR
 r9dSxPVW46w18dbm6oWhX9la10FoF4mKlbUoso6CPql+pz4PFU7VQREU3
 vXYNLtE1A2WUSYniA69ycOxd8W9kQBu4Ck+PPfvzJVEWrRydGXR8NapSX
 huy7TICYh6+h++KB1ploLbmN8k2AwecSDqtU6g8RyqC4OVhDim6SdRd+y
 cj0JIhXkhSo2nKIgPmB0C/9wLYNoKErKSjq7nDWtm/zPHgsidNHceOo2L
 UjlcF6u7BSf76s8ssCf18Q3zo+IPUxZIhczQZM0j/l/xOdHlSZ3EsvI0q Q==;
IronPort-SDR: Ax5R5VdnnNl7NRnLDw8H/9RIcmize2p74U1b4JzJ5KgylwEydkbTWB4ClUpGlt6GEybdm/j0l8
 rDLYu1WzLFmF9c01jJXXZmRnLI551ukwWtGOFmU7tvufBkF98BjOHNDTcea5Xlr7Qsghi8WAdz
 aVZLRATsVj05a0/itl2RrCZZni5K2GOR9V1KMdSSD7j4Bq8jxD5hENpdVjDMuCMgXbYd1U+yRJ
 IgyQhmlzyJ8xN9nUJMowYBlIpW0Kc81CUGAhodR4YwYgNswu9+bRRk+gPl+Wrok+D67LGN7+v/
 ajI=
X-IronPort-AV: E=Sophos;i="5.82,252,1613404800"; d="scan'208";a="277344707"
Received: from mail-bn8nam12lp2175.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.175])
 by ob1.hgst.iphmx.com with ESMTP; 27 Apr 2021 10:34:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OfkjbBr00s7IGHpireNtDMWpOp5UMgJhCKuimXqEIEL8NQdOA2/ECEns5n5yFkeye+qyEl0+1Et1/0fj5JwID50lDCIFO47pDM2C6agvjx5M/T05qTMHSl2V+y6pgMkEDmjhZj0pWcuikHHwJHszBrp37N+iyrblGONGGUy0vQlqO8PFAfN0qA8TcMeFSiR2le7Vl7kzls3KXtqY1TF6YjYNx5hEEBPQkDkIxrvI7ZYQ0i4kcJHEZlVNWlWU9Qflpj8hjA/LMDGpSvuGaw/hGqmp4AnMBWSNeQ4wX4Rz9M0sN8ZnOZdx0dCbdWOXR6H7qzF8w0y1fQX9ks2dQxvhBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lIJ1IYgFjhQu2Z0C9ltXtqRxNrOh1lTTjY6jH/lzagM=;
 b=mEmW5HN+fLhHf9X4SjnBV21DPHdAYAYRzw8sM+bKw2S3VIHcr2EgI8+IwMggPAx5C+yfvLMJO28/m8fVchZ5wX5P8+h8NI9pRXT3YmSYEZh8ip73+6nOdgY6OKEd01PSQhmYp8nZVZMHtzKtV6MkwHbgpIvieeryIo27IjXMEXYhz5olZExwDDjrjOYk68QF7ZB0QnAIVOHJRIxh9I+0BG1hAhN2SJwEtet0cHqP4JS/0AkG8sznMhtfdbThfdBOM/lbxS+XUVcjhfjVXM/uvA7hViR9Hi1LPR3Ns8h2HJj8JwJVcOj0kkfZ/HFrP0NGyLmYtaOtfo0Qhxn1BruXTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lIJ1IYgFjhQu2Z0C9ltXtqRxNrOh1lTTjY6jH/lzagM=;
 b=wv8aU8C+XU1+pbGWiGCNXBPzKz9F0gfmoSONyvjLvW4RiQAArhR8zj4B8x5iGP2shfh1RT03H3n//taETd5vOYC/IxJVgVW3ily42Fncp7LbB4sHqNYyEXcx6KZXyW+s6H30kAqdo4oYcetyZRY14CPsLoijTBeCburmESta7qY=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6884.namprd04.prod.outlook.com (2603:10b6:a03:222::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Tue, 27 Apr
 2021 02:34:12 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.4042.024; Tue, 27 Apr 2021
 02:34:12 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "wenxiong@linux.vnet.ibm.com" <wenxiong@linux.vnet.ibm.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: "keith.busch@intel.com" <keith.busch@intel.com>, "wenxiong@us.ibm.com"
 <wenxiong@us.ibm.com>
Subject: Re: [PATCH 0/3] Update Persistent Event Log
Thread-Topic: [PATCH 0/3] Update Persistent Event Log
Thread-Index: AQHXOtHks04Aj4XLukyVVIuTPOtJlQ==
Date: Tue, 27 Apr 2021 02:34:12 +0000
Message-ID: <BYAPR04MB496595EC0CEE41611B6E8F0886419@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <1619459538-3998-1-git-send-email-wenxiong@linux.vnet.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.vnet.ibm.com; dkim=none (message not signed)
 header.d=none; linux.vnet.ibm.com; dmarc=none action=none header.from=wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f9b78d90-606e-4721-d188-08d90924f18c
x-ms-traffictypediagnostic: BY5PR04MB6884:
x-microsoft-antispam-prvs: <BY5PR04MB6884AD0EEC82105E9DC4E84E86419@BY5PR04MB6884.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZaZLbP+1tWuxlV5gZ6MO15WfxGMPeS3aRtIXcIydAmuI+g62NdUx3JpachQyEODEGE+HJ2KbfLfiziktwC6gtsODrgXvYrI4GKPBiSCWZIynmkZi+2ln9ZM8ca81bkL4CQhKpqwDHYemvRr8QaOF9cZOP82LP4yMjFYoEERxoHRchn6sbCntVevXdmN/Ug/S9L9Dc7WCWnemRkg6HvW5Apl8mGEeuz/W1iitdA44Qh2WNsU6pUziUn57nG9S2Cp9GxDQFKKfKaAhMQChnODrJjD4MuUw+5JB7xKo5A++G4y7Opk5Acmt49RaSyORV6tqACAf5wpWXZlAEuXqiqLMfD1cb3KHjIX7mxC4G/6WokRy5mOxXj8rcpSSHUOpEMnou8lvTBby2af9h9rqzAYK/uFJsRe9oFC6qufNoYLxeiVjqPFamE0ElEKXSbFaITJ91pAgtLik7uz4JA/53/+VXMNQBTtqVjfLaXEY5orBxqFZTbJkYawgDBYPhAdFgWz9E2dImmgb3srImUKHOyDrZzdnD67mfPRaOl/drhnRTWfs19JWMrBhPhlN2dQg8TiOorrHnlWWZ5JxQp3lxIgvEGkOWpfrphDvfqqpufx5rnY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(366004)(376002)(396003)(55016002)(66446008)(52536014)(9686003)(26005)(186003)(478600001)(86362001)(2906002)(76116006)(4326008)(110136005)(53546011)(8936002)(4744005)(6506007)(316002)(122000001)(5660300002)(38100700002)(66476007)(8676002)(71200400001)(64756008)(66556008)(33656002)(54906003)(7696005)(66946007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?MxI5hfuk8WT/9ZYoy4md8ZrQ/dirUZXga1N3kLxOKgH08yOeNETcfSqg2VbW?=
 =?us-ascii?Q?X/jsLLxDo1HiGeS2utsn09pVkO0aoLaOB56kCn5Zz3mFHMlkRu7dDn0n5MET?=
 =?us-ascii?Q?csv8jxmLxUX71W2Vt9Z8CkkDeIutgcmF0Z9/WpQkDTQtUQGC2qP/FnbhRCTT?=
 =?us-ascii?Q?RIGcKZSumG0mtvSm3IWeiB8lRUk8CStpf7ZjRr3TgBEuNIFASoiQHo5nNdhM?=
 =?us-ascii?Q?Cvu5gVQL7A/e4ftTZf3zXU95tABq1kB3ZcMBOtT+gG9e1uz+Ndu8N12ec41r?=
 =?us-ascii?Q?DMpAibRqiqdCEiTl+XjqCQwjPh41DZ0vp9ur39Um5Wi7hSfuN++Dae1wmZOg?=
 =?us-ascii?Q?Gl3mMI55A6S1xcC8UKB1MpkhUE54i2IX1OicWMT1r+y1EvLpSgrAezo3uVt5?=
 =?us-ascii?Q?x42oUwg6QZEXHl4sazL9qFZ0TfclKGBD5Q2OCT4+Bq6Z0Z7mL1aXiflhm2nW?=
 =?us-ascii?Q?1+9+kwiP63essM0gI6u45LfavRRUsq333XQ6MJgLanlS47FCraUG7k5Rz6U5?=
 =?us-ascii?Q?37Yp7qi+PxbCmOP37f6fFFP0y2XN6DoP/krUw8phylgvgGzRiU+ACFsWxTaU?=
 =?us-ascii?Q?NC8o1nALWO/9x/NMsMHvkAJLGjRFUC8SlKjNwN2OvvvFkgTQzoV5xPMMmkdE?=
 =?us-ascii?Q?D1QzfC2pHO92m3cn7MQhwCSi2aIEjR0DmrcuUC35wYAjfSc4q+mh05JW0edb?=
 =?us-ascii?Q?V9mudz5CvNxLOeKmRne67YUY5OHSK249gnfZqG8vUMBgFzn7fVqU7i4cQtdM?=
 =?us-ascii?Q?2jUTm8GnlsynmReoI/2hVy+ONzRJOiB1YxtWTV3JBsh01jcalGZqPtI5o/Er?=
 =?us-ascii?Q?BVY7J1nH5rR+TMiSuDUn2XZ8ZYkT/XY2m+U08GuHFI1dvnFwAeemUze9wPhF?=
 =?us-ascii?Q?J05F8PFQpH7LEgog2iVgOJEpRb0XLhLMNtThMCVDucARoqDtztdzJZLw2MCc?=
 =?us-ascii?Q?bxqxTqCmxhICksUYtlJQqa/6NGMkCbec5twthcOd7RpBXjtWpMoa7Smjbr3n?=
 =?us-ascii?Q?4LdLaDYdoYKjt7oot9xx5Yhs2moSu3EbGuA0jyf2G0P8A4CIgQeJI74oIIpd?=
 =?us-ascii?Q?pSVHcKlaT8PtVGFFlt2aognGHyqS1gK2KnU2Lxg7a+l+Roq93eXImyKYZWAg?=
 =?us-ascii?Q?bxoJGWX9nLKPHKKG+YWJ3Kba6FKFeQW+5YsSBYd7ubN8EqLSZlNkOdHKnq4/?=
 =?us-ascii?Q?ggtUNlFR0mxBpGyYlXaVI9sWSvmJNHJrVPxrVWfzy6csAw3BUyS/8O5TRezv?=
 =?us-ascii?Q?3oD1eZBpwFJA1Aj8LOYUZ30FAWESkGP6VxMGleGNzUOMNLo85PRmAzjiPX2e?=
 =?us-ascii?Q?9AUhQBT6KuebstthFiOZhy+o?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9b78d90-606e-4721-d188-08d90924f18c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2021 02:34:12.3747 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n/uaXCRg4Jtl7Zt79XmAF5r7WzeEPudxlnsIHC1H8Y8qH0TeYmRMDabFVw8rVjrvurPGZXkIoM1jyOORmYowz+th8icex26MUYnf6HLZPAg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6884
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210426_193418_707553_7FED9AF6 
X-CRM114-Status: GOOD (  10.49  )
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

On 4/26/21 12:25, wenxiong@linux.vnet.ibm.com wrote:
> From: Wen Xiong <wenxiong@linux.vnet.ibm.com>
>
> Hi All,
>
> We have tested persistent event log with two kinds of difference NVME
> devices. Per cusomter's suggestions, we would like to add or modify
> the fowllowing patches in current pel code.
>
> Thanks for your help!
> Wendy

Please add prefix nvme-cli to the subject line from next time.



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
