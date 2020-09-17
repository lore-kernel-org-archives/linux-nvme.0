Return-Path: <SRS0=U7CH=C2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F0CFC43461
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Sep 2020 06:14:34 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99D8220684
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Sep 2020 06:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GN5h6Pqi";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Nvodx2FM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="MqcQXns7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99D8220684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=O08daEAnruaGXTtOQ1XWzFDjiZvY44OJ8frEUEwC3cg=; b=GN5h6Pqi6zVcQUXw94tp0JgZp
	9kHe6W0HzMHW16Iw2MyxAvyCa0lvNIfcsRz1rkjrbiK5175QiPQqpvUHM+giB/JKLs+w9MSnWcoCQ
	xhrzl0M4dX9fAMD85RGTQxHMYKcV2fY6VEK8zUhwLGHtgXfxRQsYDFw+oPSgi8X1X4qi18/wX024u
	YyeEZnBN8uGCbi8Oth5ZvrXPQGRVbhxloVQqPIH9HDVlzCUVBYpvw+Z88a0BhJktwn7haEGXcg2ht
	vyNDkmG94ockzoxJlVIR7HeE3tEtn6kKzKEsHrDuV1lSrtyX5smNqu6GmILZwdJulL1iRJbFvWrdb
	7Nde7exqQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kInBc-00031C-HB; Thu, 17 Sep 2020 06:14:28 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kInBa-00030q-6Y
 for linux-nvme@lists.infradead.org; Thu, 17 Sep 2020 06:14:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1600323266; x=1631859266;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=ZQQSHZs9Uppa2BjCQE3S22NkEufZbqEWGpKGXdh5CLk=;
 b=Nvodx2FMVkN8COJVg+WmlO48rk0r7Y7+8GlNZ2erCfA2cgdw+Q96GLfr
 MjsiqdosrXJBPML77GJ9TPgc8f3bRbvSjddp2S6PHmi/006nMaJQEgj4g
 F/PsZ3OwJW0FzLMiEsDdQeSscEPXnMDX617A9I/J4kenMMHnb/vy9tvR1
 BthRjczVJjlY1gwcJH4Q5B6jnzoW89EdsYzuQ/CfchwBmo1v5AX1F5dl9
 g/WfFSNin/xYickPDGGlEkJl6OYWotNbju5vAk+B0G6e0B1lRGRwarAr+
 aB1rSoIf6MSIMsQdcJ7Dxrm0nr0ZBHr0AdjrHr1DwLCd4rLLAicMVWhRB g==;
IronPort-SDR: XUQS1Z758aIlUTzaTCyeQ2AGRba9NlKPz9jsEaZNPitKgXlpPm8tsrhKZvCvHeHj02OhOWAsXz
 lVmKU3278uiKfbaAhBroxT/2BI08KPE3CKQS9k3xCjlM7wpcRHde8NTrr4qyOs1EqJWF3NRe+2
 YnXkCu6IOGRQTy6Zbp4+cID8jQ9aRve0fjB1PYwzJu6WJeEx83q90W5LdjjPo7mHgPvp0yDT6y
 4CghER7y7HdgEKM4sV2dZQB2VNIO6tj+vHacrsmzm6bxfKAis+zlWRHg6Dr8bqyfs+VGpqS6UQ
 bZQ=
X-IronPort-AV: E=Sophos;i="5.76,435,1592841600"; d="scan'208";a="257256737"
Received: from mail-bn7nam10lp2106.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.106])
 by ob1.hgst.iphmx.com with ESMTP; 17 Sep 2020 14:14:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dFQfCmVgOfPyZKwvI1X15EEqlJPOrjZHCIONTHIkNML1hybC1KhizIxJjIT6xn4lchIByAWcGxkUCQsw8xdzSkpBoKdYE/kdAd7Fq6ycbqrtL2+UNXrYd+JB/h4wHScVnclkeiTI2xclM/Wvan45lRtBCVzf9lhKcX4De5A7V8UxNw6mreAFMRnlmKIt76G4mVJ9NJe598dhHxMYVgdc9ze6WijzsBWfkRhAihfC4KJI1zepqB/wsZpEtqrve1ilv/MZKRPccwWIEJ7rS4BeuSMZytP9YE5ekWq3khzyES53TFqcJhXUWvl2Q4kZLsnfY5XIhjhkBxGl4GF0GDSkLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NqbyWxqOe1UI0QhkIicUC3Z/Plr1mjQRaE/2n6ASchg=;
 b=ieJMPCdjsK3azLOJ72R2JPbAB3oB+GIzKwdqvEG47qmtSRRUwMEuqaYzD7RyIsuuJ8uaqr6nDNv8j2ksw2HELRkVNttD8e33p3J1sESVceup2xB6zy/A3gEnkIUakEbba/++U3kKkoqiVoeI5URQDp/3Uh5iyO2YPVLFSR3UT+oE5Xtex8m/iCTqx265aL3GSSEGBIbgwXRAoWxLO4Gy1/0NwluYUk2RqONv7dpdRhNe/j2s4qHq0X5Pg5ZQSRJCJOk7Cq9F0Jxu9Pht9mVA95g4HGqL1WjxsS6w4W9C3f+jWp27jNQ+9Fw4SK+cS7O+CkzbM+IGrHPq1zMV1WkRyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NqbyWxqOe1UI0QhkIicUC3Z/Plr1mjQRaE/2n6ASchg=;
 b=MqcQXns75ay0sYwpzi7/IgW3y22ye94o8ra/duS6PhRndVRn2lVXX1nyTFNTO5Ce2YMM13oW73ggoQgqSU/w6/IoVz2MlV/JTv4ZEcd0owXlKc8lQrXZX5EkE/WTYINMj1+gM1KnGpZMUyrwqVxjjeb8FgOqhvI/j4p1C56Mq3E=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0345.namprd04.prod.outlook.com (2603:10b6:903:42::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Thu, 17 Sep
 2020 06:14:21 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3391.015; Thu, 17 Sep 2020
 06:14:21 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: "hch@lst.de" <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 2/2] nvme: translate zone resource errors
Thread-Topic: [PATCHv2 2/2] nvme: translate zone resource errors
Thread-Index: AQHWi4yBEpsiQBwb9UupBn3tJNUrww==
Date: Thu, 17 Sep 2020 06:14:21 +0000
Message-ID: <CY4PR04MB3751C0A0B0962D5C3E8486A7E73E0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200915181230.3674743-1-kbusch@kernel.org>
 <20200915181230.3674743-2-kbusch@kernel.org>
 <CY4PR04MB37511B210DF4E12A481E0268E7200@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200916210054.GB3676296@dhcp-10-100-145-180.wdl.wdc.com>
 <20200917054802.GA31594@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.47.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ac3e8235-73bc-4262-30d6-08d85ad0eb23
x-ms-traffictypediagnostic: CY4PR04MB0345:
x-microsoft-antispam-prvs: <CY4PR04MB034591827AC2A94275558B7AE73E0@CY4PR04MB0345.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 56Ui8t3PKZnRkNP0pF1iGTJ5Knafyh3TZTef7JNonSYCYrsodHxzd0XBMs08LFfe8RG9hZiPyGtef1KsMhRQsZPpYxFhOvUBxn9OLv2Czb5V67kDPcrYns4tccV8zkphCOAyATPmRdPl9ITTAoRn/Byp7jhAxVFrymXOg/+TKJhK51bCXCFs6fYDX1xDIUP47gu5WUyfiqrntOQ0KN9GxRfyswz0EjPobD6xo0dsZfCZWTjgC3Rt28cS3ggyE6x9kCe7igkd0uw5omw8M/IIhEiymrdyUvyzruzHFD0bbCi+c6f/jQ4AdpIfgBHzJlgy4jEmopDIcaq8QkAuLfHu6g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(66556008)(26005)(71200400001)(110136005)(64756008)(66446008)(76116006)(66476007)(91956017)(478600001)(53546011)(7696005)(316002)(66946007)(186003)(5660300002)(6506007)(54906003)(52536014)(83380400001)(2906002)(8676002)(8936002)(33656002)(4326008)(86362001)(55016002)(9686003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: wx3wwpCgyrWqeIHEAYpH1VeN1SVJrseLIc2DcJXRudcLq9UNu77ozEDkVAZp6npRl3li572kvToJFiimMonmq5gVbGa01U51efCj+uSTFJSLrwuXxLarISrCAmGU++JIceFBVV8c2BVHm/aVHsV6AESEwxntSDhrySq10rpcqJh1vtDNmMMREQrntWnKKIXWci5ECF8TN7u9wfu74NnJb1EspSwPGL4OVJgI8LvcDjdJd8pkxhUcUuXhV3AJvHQzzaetnQ8Wp49VrYIqRQnFZjE1As9uhyguXnPJGWhxvaoYSFugKc2IUUKO+1mXGEJ8ysCh0yAuG83KXNKEUPa95fzmVf3NsxDPlgHLqgDGaLQfeZ/wIwz/3+3W80qjIkgDJEHanysVWVGWBKsteO8U5ZiWwvRrkud9dIScZwAnoV8777qPuQ1DvsTI/t9sg7SY9dEevklWszPdOep7EbSDdWx3P9Qwe5QMs9ZEBPSvZxj4cSGm0n41EScyNxoz6gpa8d215DpJItaZhK7yvgLzVLM5dO5u5GdD7sYPfB2vxzrpm+B3DXkTE5aDHFHTy7UDOs9Pap5xL0/pYPupvGMJTaeagNECPRicoQS47UbuIo7u99vc8sykl6anBXaiBlLzS3MkB8qHYACccLyN4ZcvKg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac3e8235-73bc-4262-30d6-08d85ad0eb23
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2020 06:14:21.6325 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yoLAu0/jwNPYiJGwiOozBonFeur1rOSFe/X11C4Tiu5GHunOpVmkTx/bwXAUQidpZGL+j8+uUpvtTdEd2K9oaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0345
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200917_021426_537192_187105C5 
X-CRM114-Status: GOOD (  14.26  )
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020/09/17 14:48, hch@lst.de wrote:
> On Wed, Sep 16, 2020 at 02:00:54PM -0700, Keith Busch wrote:
>> I believe it's safe to use for the completion side since the special
>> handling is only for submission errors. But I agree this type of double
>> meaning could invite confusion. I'll send a v3 with your suggestion and
>> we'll see how that goes.
> 
> Two remarks:  Can you include the scsi patch for Damien so that ZNS
> and ZBC/ZAC are handled together?  Should we use a separate status
> for active vs open zones?

I did not think about that... It will not matter for ZBC/ZAC since there is no
limit on active zones, but that indeed could be useful for ZNS. And with
Johannes "explicit_open" series for zonefs, open() of a zonefs file would return
different error codes to the application for max open exceeded vs max active
exceeded. Same for raw block devices ioctls or write operations.

Hmm. So we need 2 BLK_STS and 2 errno. Not a big change but I am out of idea for
the second errno... EOVERFLOW for max active error ?

Max open zones error: BLK_STS_ZONE_MOR -> ETOOMANYREFS
Mac active zones error: BLK_STS_ZONE_MAR -> EOVERFLOW

May be.

-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
