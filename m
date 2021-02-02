Return-Path: <SRS0=QQ4x=HE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C742DC433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Feb 2021 00:13:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 764CB64DDC
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Feb 2021 00:13:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 764CB64DDC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=mX5ibeIfx8h1UrBKpqpj8R0f+svGqlnJgxacGqJfS8g=; b=WMiiOLEeMCmJTDoHnvcrI941Q
	TBb1KpQzUw8bmaPoR6k24gVBXFd2QMEbEQ8xrYf7h0PnzaPnBNPvQt3ycN8X/bD2OeCkfhlc+y48r
	seWIoLvvYTj8ILkhJrdQ5eOXIP/Nhs9o8l+zaw1xIwuuqpew3Y2FdFvVlfGumXoAhz8aoeAb8jE/a
	JJkvg+da3ZUsTY50znGo80Sul3PJwXxmKvk2MWT+LE/XHRN52rAUmAD+Ci8zeUlVLlgL69zIeUR04
	khSDf3J5gwvVy++JLQbNAGOeYLdY01zd+fEkuphHdAIR0p9SH4E0umh43fQWBQ5OodWqgA1bcextT
	jUNzzMibQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6jKL-0005ee-0a; Tue, 02 Feb 2021 00:13:53 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6jKI-0005eB-I4
 for linux-nvme@lists.infradead.org; Tue, 02 Feb 2021 00:13:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1612224830; x=1643760830;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=PP/Eab1EnzXY7605bs0itODOKJn7cNlIPh/t6O+8PDs=;
 b=NGlQvuVCqxPb4e3Tb2dT2o1KOvnkkk0PfpsOhk/1DTvkd46HtekVzfoX
 2/7hu0pVpg8gLeKjXEqnB2W3NSKaPB/4mJlmzaH50kw88D/pf1P5Wzzjm
 R29BrQKeqnTw81e4qyx9kKLFXG/PCAQ6voxc037dj2nF/bkcrD2lBcXHr
 8TOyZR11OV0qABi+i/dy9wRh1FXARQoxgIoGAXX4KzJ7i0sQ3XjlWhTW4
 RwLeaEXVBe0zL8HKkIw9gQQ+BdJaRXwy1p+RGvxIPiBO77AhjEi5AvEzp
 Z9M5Yj6Vqv/pwjhxauYK2PdrbzFUWm9zSaU8Iy9caQDCOxKTmZKk9AuG0 g==;
IronPort-SDR: z0komFoWXeEqvasnz2ov9+oaS3hZ97O7ZMehguFdV+vJ2YTUOLM+R0Xe1CY4p6Msje5LzR1zcy
 XbE9k2a7q0AUXR4Gcu555nhw+aVKfZ39QXc0LfkEsjC8l1vo7mHY82iITJQ+MP5ognYlI8STfx
 tQSA0/VO7tBgNDsXlBBYcQ0m485MARoagjXmm3EvSMd+y63ySdUTDRP4jwKYtnxFxbfGRkQv5/
 ITNBzs8PfIlZfaapKh7Y3C+m/2r5NRxTsrFkKL8ePx41ep7g3ePlripNOo+faw2q28iIdYNOUp
 MQM=
X-IronPort-AV: E=Sophos;i="5.79,393,1602518400"; d="scan'208";a="269276609"
Received: from mail-dm6nam11lp2170.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.170])
 by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2021 08:13:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mdN8VYjUG+4ZGuVDv7ls+VjYwwQshxKzZk8wiHygSZkdc7dLQArjn1Vb9FvDNnvaCFgtKVzxjYUMv1NE/bx4ebbv8RIw6Y+ABZKHEkQ1tfiI3UJegX01wKGqKezZf0sR2ydJkd6OJ5GTX9wkbWEwFKVzo71l5Xy2k56mbu/2qGNWGOAHpVsEKNumqmTvviIWsrhRmOX23gLGQei4TsZoY8nReYZkq+G3wkEf1QotNul+rSanr+ujsvvn/p7FTRGDd6ikfVhV9NmkqIC80gDG6ml/xMC26n87d3ONo/c1LDJxiXhETVIV2075eOu9okJTHsyAPPRdEoxmesY0qfS4oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ASzkZU2TUywl32lWSNuxjJOF3k6ujvqzkgt+cSnj86A=;
 b=g5Ge6tvteafRYXaFBUoD17Dfd1U4yqOmfCpcMTCDHO+ZCKixrhOUIetqBmU4DYUKbXc0sSjvh1EiU6cbMWbJMku6QNYtvcoQjTy+TxZMFnWvPHFxvZ195nHDe4FyLhw+UF4sczJuK2Z19Ma+9ZtCCNQNgVJ8oPN3K67oLtI6dWdjnEi3tKs1FqPgLRoD2LYPra6YnDdbMfq/2QCZ1Ny1qhXUBmR0RuBkWuLCxp/CnVwxTUsJY3ryNL7csfILSoptFrxBhXTHnA3MGtwuY4aQB4EH+F1osVJrTjsheW4f/yTQn8ju7vK1ieNIi9MjVlzDFe36FIQd0CIKEte2z84+2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ASzkZU2TUywl32lWSNuxjJOF3k6ujvqzkgt+cSnj86A=;
 b=rz/tsPGHgVKRwvJqsIrCy46MIwayLPWQa5gXpc7FMkM073O/QMdndVfnL4dfW8Go4/aNAp5OAoGqmRohxYRNI8PZlWWAEJB/Gr72BbXXWq2acL8ygfaGHSiT+P/WjVMepVcf2EpmC6nin1VJpruiggiwV44j/z1kdjP0LleWQBk=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5431.namprd04.prod.outlook.com (2603:10b6:a03:ce::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.22; Tue, 2 Feb
 2021 00:13:48 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3805.024; Tue, 2 Feb 2021
 00:13:47 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 04/10] nvmet: remove nsid param from nvmet_find_namespace()
Thread-Topic: [PATCH 04/10] nvmet: remove nsid param from
 nvmet_find_namespace()
Thread-Index: AQHW+F0AjjEylwDhwE+1FFYAMTETWA==
Date: Tue, 2 Feb 2021 00:13:47 +0000
Message-ID: <BYAPR04MB4965C6585639860A00269B2286B59@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210201054138.34324-1-chaitanya.kulkarni@wdc.com>
 <20210201054138.34324-5-chaitanya.kulkarni@wdc.com>
 <20210201172810.GD12054@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d1743110-3a24-404a-f048-08d8c70f6960
x-ms-traffictypediagnostic: BYAPR04MB5431:
x-microsoft-antispam-prvs: <BYAPR04MB54315C33368A250446527D2B86B59@BYAPR04MB5431.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l6lQKAJUXitdgKs/uNPxnO4xb3iiomr6VQGxVN+S10IwXpcY1PEm1KnKrjK0yuDgJU/WLX3SoyuKfcLaOlWUDCoctkQWVl2CXx6rMJUgWsG0mEia6JEK3LFYuGD9SsWBkZ5ysBQhTNED/qHVlytep4+N2D6Rr9wLmq2cV0Z5oS8teuzY1WSNUawP1ejTNKfaWT0usuVD108Gr5dwYt22QVUdl2pcmyWwso8cVuBBrUeCber02VpDHYg9bYEyO8pHTXp3gk2suGCzxzpedERZ827aPxMRfw2+xbd1Vj6S4avQmvzrwxolCjDFZINQbqr4yLV40yrfy4zz02L9aRijwjh94aA98Rf97bNNN34ruSes1q1CA/AqMd0lDBgR29OAkgggnr6dBAy+GOO0EQr5Q5/R+UXN7EMNCyGK8oDINDaCpI9gYemoidpGsMOZ/qWzZ1gYufDLDPPwK0/zxLC+wbKtc3hGQvP9bMIWCTHYoBIQc0MqOR2jK2FJ2BOxn/ew62ca/73QUnMsG6h07UGp1g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(396003)(366004)(346002)(39860400002)(64756008)(66446008)(52536014)(66556008)(5660300002)(66476007)(8936002)(6916009)(4744005)(53546011)(86362001)(7696005)(8676002)(478600001)(76116006)(66946007)(55016002)(33656002)(71200400001)(91956017)(9686003)(26005)(54906003)(4326008)(2906002)(316002)(6506007)(186003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?e7n3rM+FY/9asmUYfzwKUXEHeTPrBf1d5fQzdq6DsWgTBIqXqZSl/VSYMZ5X?=
 =?us-ascii?Q?xVKwxr3lrZ30jbGburyq6v8LZCjzDiPs/wetgKtobIshoEFROwad1gLNGV/T?=
 =?us-ascii?Q?lpt1QK+0LFSTY5EmpZB70ilACZKVColoau5ajuj9e6voI/k+n3AoLis134Ek?=
 =?us-ascii?Q?cOl8t1kS/afeU/bcZePKrSYjGwV/h6Ie7VqdE0h+yLb1HC0/iBUKvB9PziCu?=
 =?us-ascii?Q?a3gjLm53qFRQvF9i7rjo82EtrAg3BKqWf4z+7jnt597Bh3ZNyfami8Kn2Lqn?=
 =?us-ascii?Q?/WOA7qFPhArdzZmmbranY9RgZhXbRoeFuF0JmpGIeswRjBW9VFL8IyU8VsYL?=
 =?us-ascii?Q?wUjNiBLBu0dLDdvDpqL6w++EpFkSK3VC7qgeRNaD7QIYCSxvRGN7N4fuMRyJ?=
 =?us-ascii?Q?7k5TwkRLMIG22CqWHMFhNOm6azsx0AbFC/n8nA/0H0zmfeRgA7Iv8Tw4YB+E?=
 =?us-ascii?Q?GoVvFHrjyckx5FSjy1prUSlikf7+KwaesMWIDwskkaMihhaSiBO7H35PndJq?=
 =?us-ascii?Q?AweGXheXGmX4iFLWV4qmdFUzvYKmyVVdtCwdaNuupGnkMIgb/stHerOQ0TVL?=
 =?us-ascii?Q?pJvzkadsSdn6PdoR0cTgb2ijIa6UAChBMBm/D90FikSpVu7gF53LYgzyt0ZF?=
 =?us-ascii?Q?0RJ4ipt8fIlJvg8PKLYhdrKlJaSV/JSeRbM8VMZ95B+706QPwe0iASJBMKes?=
 =?us-ascii?Q?/WX3N2ZBE2xWynKHntwErpMBTGZ+/JLCmxQT1HqpfCwETJSDHOXMuemN7J+J?=
 =?us-ascii?Q?/A2Io8sYZEhFXY2AklFo+47kKQAvlXPp6iu8uthaP2ZFhcBHoNAF2kL6kGlR?=
 =?us-ascii?Q?MRnrYft3oHLe5dL2xzZSXGZ1lQkuCkYqgG9b0IQCsQxgwKqSejAMwQSOVdFv?=
 =?us-ascii?Q?fSHfXdcUcszBsLruufGbWVJ341Aw5IFkSWMBBlnp98aYe7VKdi7dzDU53l9t?=
 =?us-ascii?Q?XpCwa7PnXW4mzCYLxszcTaKBW/LwGY8xjdGCpjUb5sRamekki8javaO0VKX/?=
 =?us-ascii?Q?g2ARUMbncFZFvDkOoHnfxSlnu+DQU1uCx75mbi3xxy0DwIZcEMgxNa/dZqyl?=
 =?us-ascii?Q?Zmxc6S6T?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1743110-3a24-404a-f048-08d8c70f6960
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2021 00:13:47.8683 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wutAD3t4eUcfauHytWsTMCiGq896cP4JqMebDlGz5u1a080nKXMk7DQxlxFyKaKi0nOJEQTFKa/Md/XeoKpNPzklDrZQMmOUPNungsBzN0s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5431
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210201_191350_774979_E872339B 
X-CRM114-Status: GOOD (  11.27  )
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
Cc: "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2/1/21 09:28, Christoph Hellwig wrote:
>> The nvmet_find_namespace() takes nsid parameter which is from NVMe
>> commands structures such as get_log_page, identify, rw and common. All
>> these commands have same offset for the nsid field.
>>
>> Derive nsid from req (req->cmd->common.nsid) and remove the extra
>> parameter from the nvmet_find_namespace().
> I'd merge this into the previous one as that totally changes the
> calling conventions anyway.  Otherwise this looks good to me.
>
Okay.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
