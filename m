Return-Path: <SRS0=kOig=GY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1102C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jan 2021 08:09:59 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 446352395B
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jan 2021 08:09:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 446352395B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=sCdJjj0Mk11ayeQV/uEfnYvntfAMp52N6jkG8USYMw4=; b=v1NE8qE0XQIm0en8DExHRoWTP
	WxRYM6XLaePa97oSt5jkOaIFCg1jr4fIouw6tzUw846JrkFKZZ4+bq7qUnssRnpPRvg8KyfKVjnOX
	FaLWKQOXjZMg4u4Y1BrmplrOUv2umI5XHzwvmYoZj2RWWGcSDhpqhL3JSqbtihgwt0QN7AFL7q7qK
	uQdDDYDHuBVpzeOTNE6zLoxCLqUo5Q5RmuVDfQOAiN0o12j3+wOVibOjOWyNJdMXeKqfM87EYFylV
	z4YRqrb4sAZl1JJpG8NgMJ2AO+rovYwhADKyysXJmNE82My0FDGQI/0voK6246ER0dxkSOaUBmWBF
	CeQ944riQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l2V1l-0001AP-5l; Thu, 21 Jan 2021 08:09:13 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2V1h-00019Q-I1
 for linux-nvme@lists.infradead.org; Thu, 21 Jan 2021 08:09:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1611216549; x=1642752549;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=Sj1WPoL+RYLDdNB33FzFSSmCPX1Y3ghO5WNg0+qrXcc=;
 b=U3ZsUDIxDl8tnJ4NpvYtiKH9W6hq/SrXXSPdSOcKSOwj7H+vMlDOADt/
 11hwRNSmcxRJB3QR02fsofEIKP2GA/HNYSxOG7qbA+7ONgMRrv+lQCWMQ
 Vo5P46nwO0u5HPzmTOZrfQe7ROXtSY/glWAwnHflqCnOiTO3TNFR/m6Y+
 5a7qya63v/cVwYWMEwJhRVQSsVCYyvDGjclRQNl3Tg4Orvy5YaHsFVUtP
 PnBHXg7gu8C71gUwqLczTJ687YAahVACO9oR7Oh+duKdMNiqdM4E21Nda
 7DdP9HxZ1e0vWh8hX2S/3XzP+nnasWU5SuE1+eAFXc2m2aCl5OXBALvUS A==;
IronPort-SDR: CZgwItdyl4FzlKxaO03ZyilImNOiu02jYyvxk7uEzkVmYvOB1Ynzt/O+6rGNSkejRLO/slbdjK
 jO82x2tliSp9em/m79Z5wLxZKptDnrXAkrZxBwmpRObWz6pUggAqLwUxOOPr/KY451WBPo4YM4
 +hztli+2I9JG4v9FVdiylApjBPw1GrCAdihgsqidp2zNYssylPkqtbAWOL9Qv8L3E0agW3bsRM
 43TiF1AirUtrEB3dAa9AxKcuL4chyRnI2WOF0Ab6tbM+SHsHl17OTr0/dqXeejk1N/Mo/nB0ld
 RBo=
X-IronPort-AV: E=Sophos;i="5.79,363,1602518400"; d="scan'208";a="268300759"
Received: from mail-co1nam11lp2171.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.171])
 by ob1.hgst.iphmx.com with ESMTP; 21 Jan 2021 16:09:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X0DQ6y456b9yShHKcOnsiEWatkBUeO/qD4uBbU3OOFcTX84ulEBKYxRURuthkGxhWZKEBsM11y/6syTFX1RBHuG8ovLO0i0A5XOmaGma+gMRIUY0qM/esax8fjnSzdPhqrYdGoeX7/ur37/8Lmi5n57skgT0JoM7D2iDPF+uLQfveIkPpYdWXPYWkG4z0S2PlsrtSCL55/Oo3+peikWFov5w33HLDwnvB5NrMQnQ4aLytpMu1kAOyF5bICEJydktYU1EWvvmaeEpNM3v0Jmq0pqkF0ICWG1hn2mLSPh1kW+Dc5LhzYsjt1VCJTkUhOO75vvM6Byf0vtsBSQXsSY6Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/21psWnU5K2ppnXgGifvZwesw6TBdFvAiXwVupVfKM=;
 b=bunBr50rqqgZOW9m0A76wZG9KkkGGcERx/tp0MBK5ByGUFwfBlWwOREfF2ZpZuiI9rx542OEgGzj8h9KIBheFoMVq0rZQNfZOPiWdP3CovuJBtbwtCctDFwiuCjoLFnNJrBNko1FyMyc+yntQ3j/WuRujf36fQ615fZ4YNL7/QAa46qkmEhSjEUi10msmKnixUyHxuXduK2zDOYcFFQ6Difvms+3FTVD1gy2m02zgf48MxlCOHDihrujE8LzdQL5qOvuS1hkyApcchGc3x+Un+FRuADK3aTlJk2Avanfkk/NFL9tmTNYiW3fz3vhOS+yjFPZRyFQ2lSfUP9cgqs01A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/21psWnU5K2ppnXgGifvZwesw6TBdFvAiXwVupVfKM=;
 b=IARhpFyGSu3sliLErR5c20f65QkirDcr0SAmkoLJ1husBjufd+WBkDwLWG1/Izkgdp3d0dq58ht9HhrYt/eXgtKjkxvw27gUSEn+ObRXp26Covt3IJKD7WZMfnGvyIzUz7EXFaLMn02fEmFsC//A756CokQdbKfX4qz8RRLkhHM=
Received: from DM6PR04MB4972.namprd04.prod.outlook.com (2603:10b6:5:fc::10) by
 DM6PR04MB5531.namprd04.prod.outlook.com (2603:10b6:5:123::26) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.11; Thu, 21 Jan 2021 08:08:58 +0000
Received: from DM6PR04MB4972.namprd04.prod.outlook.com
 ([fe80::9a1:f2ba:2679:8188]) by DM6PR04MB4972.namprd04.prod.outlook.com
 ([fe80::9a1:f2ba:2679:8188%7]) with mapi id 15.20.3763.010; Thu, 21 Jan 2021
 08:08:58 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>, "sagi@grimberg.me"
 <sagi@grimberg.me>, "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de"
 <hch@lst.de>
Subject: Re: [PATCH 1/1] nvme: update enumerations for status codes
Thread-Topic: [PATCH 1/1] nvme: update enumerations for status codes
Thread-Index: AQHW4pl/PNJXQVRLPUucy0ABCmCD4w==
Date: Thu, 21 Jan 2021 08:08:58 +0000
Message-ID: <DM6PR04MB4972577AACC08ECFB620E54C86A10@DM6PR04MB4972.namprd04.prod.outlook.com>
References: <20210104125947.160984-1-mgurtovoy@nvidia.com>
 <BYAPR04MB4965E1DC0180C2E5789E505186A20@BYAPR04MB4965.namprd04.prod.outlook.com>
 <55ebc8c7-5631-1f99-1384-80ca85c26b0d@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2600:1700:31ee:290:6c3f:2942:f9ba:e594]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4320b2fc-28fe-46e1-0a06-08d8bde3ce45
x-ms-traffictypediagnostic: DM6PR04MB5531:
x-microsoft-antispam-prvs: <DM6PR04MB5531CCE74A303764E779639486A19@DM6PR04MB5531.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n2D0ukS3+3vI0uE+Ox8/ysnIMPBMGa/E+wLG/P4uCbW11uNdbXH6bCroGKU/NV5Cf1kqhVFn4khe9bX0aOPIdNAscPmu17V6rXTmm53Ow2uZn2R2FvQv7obkGxWHXBZMMk493bMwSrxGcBRN/H+gpvf6BNC5fq2wxxKTw1zm+Bff70yvAc+lgat+cMIhgkyTifhHGu7UYLOxfpBXNQS4ujFXh4rVFUUw6UpS5BfOCFbKuMbwLBS2pThjZkiz/rEdBWc4uW94zQRSnpfFLlmP0VkCG7KO8jqd6nqcD4xqcuRyqfv8nUCgdlz1XQklzUjMmGyns2FuCSeZtE0FzMvIgXoOmE9hPQyXic0pm1umYOE8oAO/GHHz2lyTGmD+jBM+vKqdTQlGuZDoJ8hAdjG2hg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB4972.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(53546011)(15650500001)(2906002)(83380400001)(54906003)(8676002)(6506007)(7696005)(110136005)(66446008)(52536014)(66556008)(76116006)(64756008)(33656002)(478600001)(66946007)(91956017)(66476007)(5660300002)(86362001)(4326008)(8936002)(186003)(316002)(55016002)(71200400001)(9686003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ABsX+AsMmr8JKLfUfUAg9d5+ET3sJDjWWRkMg53OCxb1JcLc9/8URA0s+Uoe?=
 =?us-ascii?Q?1CBWDHLmwP6eAhfGq5AzN31qJXiiAW8Y5cx+49BqgPZIm+gmTbpwo+MkWvcB?=
 =?us-ascii?Q?LZ4J6+XHiZaPzFH/YW/Jz6K9PhF74iJpwdvMd0Lk9qMInVGjgBNwFy85pBr6?=
 =?us-ascii?Q?JCzetecEgP1kueztwoAyp0ys1T74EIHaArUGJ96j8XYMOqROOrNf5yF970i+?=
 =?us-ascii?Q?0nV/p+Y54VP+BUlGCsz/37ziBSs1L0atkT4p26qy8f2c/RwNI+hXF69e2r9V?=
 =?us-ascii?Q?aE7ZuWtC/5lDOBgYW3FoIcq6cNsyTqHRI38KiuN55jNkwiO/nWHnL7vdjXf2?=
 =?us-ascii?Q?cOkhhyIoT85Aqr3V8FmSKG8ntUgfetskk9rzopzEiFwTva6fuOraV6ioYft0?=
 =?us-ascii?Q?TOhjnFGfTEv95UKkQKbCMebvnEcvv8P/WG5SyhGLokgxrnTKA3sqBLcOoPE5?=
 =?us-ascii?Q?0lCsjFw9o36D7pmeS6EhOnI6/g4SV3vQwRTcqPMaLfcUIxjyFteyS0lhTw5R?=
 =?us-ascii?Q?qjMP9UOHcUZkwYU6AxjTqxMy6tM45YAJjz9dlIG+1FKRF4KCdioPuXU8Y/zs?=
 =?us-ascii?Q?Zb2t43fx2KM/RhE4Eex0Ks5J64X+0hYvTdGzABgx0WasbPVKx1yW6KNfw+lP?=
 =?us-ascii?Q?W3IezS8vztNQ3Jo4XCqynng64VA+mHIlGEzI4HgVi1kkhdZ/3i2c3+ZMCA+G?=
 =?us-ascii?Q?IHgvE48Fw5JbaANORadMlYKi9wRG032Hojs66sUdxRzvbu2PDlyR62PdMxKi?=
 =?us-ascii?Q?R4l3C9IpPgfYLYD1gO9iLiaBy0wbWOTdAQhNgsdZYpMwjWBMHJ0+lHqbMvlc?=
 =?us-ascii?Q?Wt8bEnNyBdIZ9Tg8mdqlNgoOHo3qekUbn4sDZcurhivbq3BlZdkKrGt44J+N?=
 =?us-ascii?Q?wgUNc7zyfnAsMg0YxpefTNnEsF8kaMlRZ0qeDYKgPeO8XWrWWDz8qUiiH/4y?=
 =?us-ascii?Q?4J+hBFca3dQfgV/D3szs6UieVB2MoecaEvENHtA6k/BUfBSni9XQy2nf/Xh4?=
 =?us-ascii?Q?mjke9X/Slbop/J+twaRQIeEdTtdExD4fvSO/3oliG5jwKkLhTT6PA+IuHPva?=
 =?us-ascii?Q?JSAw1M0Cx1uIecWt36vLl7GkbCSEFRBGbIQlTLcU3VADgK8y6DeXySuY/M+2?=
 =?us-ascii?Q?J6T0VKxiUCKTZ/ukkFm/vrZmEpWHNamxlQ=3D=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB4972.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4320b2fc-28fe-46e1-0a06-08d8bde3ce45
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2021 08:08:58.7702 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0jbv/J4mkFlnpUhVsmH3mdClx3xIqGbpQ9TJp/pTeDZ0IblLy7rp+Y+CfAYfzHwiPRyNwK7vFd3csdtj/dM5vDxVo/wVM8RARyV8OdFG82w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5531
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210121_030909_911555_03013169 
X-CRM114-Status: GOOD (  18.56  )
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
Cc: "israelr@nvidia.com" <israelr@nvidia.com>,
 "nitzanc@nvidia.com" <nitzanc@nvidia.com>, "oren@nvidia.com" <oren@nvidia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 1/20/21 2:03 AM, Max Gurtovoy wrote:
> On 1/20/2021 7:09 AM, Chaitanya Kulkarni wrote:
>> Max,
>> On 1/4/21 04:59, Max Gurtovoy wrote:
>>> All the updates are mentioned in the ratified NVMe 1.4 spec.
>>>
>>> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>>> ---
>> I'm not against keeping the header file up to date with the spec,
>> but should we add the error status into the kernel code even if
>> we are not using it in the host/target driver ?
> I we go with this approach we should remove half of the code inside nvme.h
Yes you are right and I really don't understand the need to add symbols
when they are not used I think I'm also guilty of some :P.

It will be great if someone can clarify the need to add symbols when they
arenot used in the kernel or a use case which needs this sort of update.
>
>> Here we add 24 lines which we have not used at all.
>>>   include/linux/nvme.h | 24 ++++++++++++++++++++----
>>>   1 file changed, 20 insertions(+), 4 deletions(-)
>>>
>> Regarding the nvme-cli this is much needed a sync since it does
>> decode all the errors if I'm not wrong.
> I can sync it in V2.
>
>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
