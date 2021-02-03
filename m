Return-Path: <SRS0=tyWw=HF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFAEC433E0
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Feb 2021 04:31:23 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8BBB64E29
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Feb 2021 04:31:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8BBB64E29
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=ZDon7mb4U/JB6n3Rlz+PO7Z6nYrRk9Zci2HD84B7ZHA=; b=xJyaRpv3q6FBb0ZcmEJQOeOsV
	9NSNr1P9KpdEMc+RMtCVET6INJ0cddJ0HLYyIt7rkBZgkOYVknJwVMW4R0h9ak/O7SDEPw9VLpWpg
	i4rHps67UyMQhGnIfbBzTLKZwoHCKACJJgcvoFsqVpCPYcmiYsEP1+5R1jSaD9zXoIYt21qj07J70
	nbqQl7FnodPrpe/O4E6ntX49K+ypW12tMnax/W8OcIlV/K/lWeD13TZObgGH9wKLJ5pH7u7Z8DzPH
	iza/TntxxhJvGQzZJSPY0KkSKw+2H7XkixbGNBxMCKgpNYVPJCEfbuXGhVIKY1DZ0mNwnSTe8/a3p
	s4YYbG3Zw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l79ox-0004js-Kf; Wed, 03 Feb 2021 04:31:15 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l79ot-0004j7-A6
 for linux-nvme@lists.infradead.org; Wed, 03 Feb 2021 04:31:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1612326671; x=1643862671;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=gtZuzk5ybxLQteWYR8tZmDGlDsJcM5EjxAXFbtgxjAg=;
 b=Lwq20OS1TdAmuEYDZZ3krT//XzkpSys4OYkz2vqzEzo3tYwV/zT9QX4q
 HR1mmxr0wJ1JBwv7yPlyFJPJUjLOaFWu3wyoKLu7oi9i1odkBpikT/dtG
 aPzy9ErsfY2Nck6qvFI+KZSnE0AFEYrigiozKytT1bmhboJ5Ugb2PNtVm
 2k2Fi4q2xFpjCV3c8BLeR6NboJsNymEq6L2LEDSCORiB2EgqsYmwryFIL
 wkSakA9tLKUkQDwcAV03s5ow+4WC4shRAD/+G96gj3LCUJc/QWFEl+wUG
 ncPc4phhWnFiBsCtDZi9j+SsezAzzcqU5DqsMlQHB0/lMiJ57vARDbQCZ Q==;
IronPort-SDR: NVT3ScYlWTsEUHw1J0g2hFt3RRHyQgTPbpo1lV0ts+AV3ot/DNvMJLCcU3WHOSxucQfnEG6C3r
 giCcaN/6ocWpnJJr1OrP9NdD954ZD1YgJiRDTVV/na/HDmjt+n8G6eASXQrIKInOVyJVEM4JKM
 lutkSPiri/zqVRt8aCZ6KtEpVbD6cddKpD6Ul1i2sf5rmEvABKaTaI1Lpbzu0UDsnJETT2y+7v
 LiA22oMwFt8FueSHFk/mEilcwzUJTqWlTyFPHUUmqCQMAZBGpGThhc9LYvvk8/XJZ4IZv6cqK9
 PGs=
X-IronPort-AV: E=Sophos;i="5.79,397,1602518400"; d="scan'208";a="158989024"
Received: from mail-dm6nam10lp2101.outbound.protection.outlook.com (HELO
 NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.101])
 by ob1.hgst.iphmx.com with ESMTP; 03 Feb 2021 12:31:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e+H2zwGMWJNWFh4hVM6j2iAQXY0IM/nch1KM17pQIUhMrmL2qmqoABiFht3N8P2ejiqkcObq6HTwEhGa6IpdN+tfgjb/tVd/irlizyGlPSX1aIii4uqN2XgCP+wcAIvHiRL8vWhKAikUApiJMgHiQdw3BR5VAWYXfjmMyZLCnYK/Ia5rQ9tQwb68fiatPZakagLFw1h2GTV7laPhwFqt6aXPoh9k/RCTHC1mUNW/yWAyvYsaJD7rZtScMWyDS1DvGBWK2BL1nWSxYnVDFfTcSMdy4dObCPWoZBfrkWHU+1tBH4PXWMQw7FT5N2MoB8DBt8RDi/ZzLgR5omEmxWnL3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PSIy98HhaW7JYC3AMiaB3EwElYQOwTFBPltkvpj+PAg=;
 b=mw2HaUY/pxHyYgol82ccyC2fUlOGzWHL3jWfcZBlGepD+7UJtE0Ntdu6CWqyW+g7ADhXUsljGYtS9uG1wgm0RBLObZl4G96Z4+Dx8si1FjVuRTZQZ/hRdwb4vIaGSXjBfC6Cb0mCPSMojGlZMx6MUtpJeRfPHFpRZFFneK3BaNUjNRtWubo4EhEYhGucCSzpFSupKRAhFULE9G8IWyuMCn+SofRH4K/wD8hw2mufmdJcRVwdS+v40wAyRWLh/eWr+PnivDRdogrsQP9ONger4drz5WSVGdHAG3TDEUQHyTyAtt7KXd0z9e+Qt9h8g0tAxRKJB5zP8p9YjJS2TWadUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PSIy98HhaW7JYC3AMiaB3EwElYQOwTFBPltkvpj+PAg=;
 b=TWL0x4c3Q9+3FlWiyqf4AgTrBkbpx9OqtLTme3fXPHlKSmYrC+oNu0LwlUpkyjUsCgnL1gpBy7hSJJTvcvx0GO2IL6+mxDBblsIQcuXdAl6YtfnYqRgxDebNSjotZJGN3vqIwxkw7AroFvAFh8PQy7+gzjwObqZ3pkmt8Aosg3o=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5526.namprd04.prod.outlook.com (2603:10b6:a03:e9::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.24; Wed, 3 Feb
 2021 04:31:06 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3805.024; Wed, 3 Feb 2021
 04:31:06 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 01/10] nvmet: zeroout id-ns buffer for invalid nsid
Thread-Topic: [PATCH 01/10] nvmet: zeroout id-ns buffer for invalid nsid
Thread-Index: AQHW+Fz0+PPbisI7LkypCGaccpFcgw==
Date: Wed, 3 Feb 2021 04:31:06 +0000
Message-ID: <BYAPR04MB496538B136C5484C817FF50C86B49@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210201054138.34324-1-chaitanya.kulkarni@wdc.com>
 <20210201054138.34324-2-chaitanya.kulkarni@wdc.com>
 <20210201172438.GB12054@lst.de>
 <BYAPR04MB49653AC1A94F78112729EC6686B59@BYAPR04MB4965.namprd04.prod.outlook.com>
 <20210202093831.GG17771@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 08c38efa-35b3-4dba-9516-08d8c7fc85e6
x-ms-traffictypediagnostic: BYAPR04MB5526:
x-microsoft-antispam-prvs: <BYAPR04MB552636875C7EF4C7F38821DF86B49@BYAPR04MB5526.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DkNw8g/VK7daSlBP4Kwv2zk3catGlihBAgOB2TRH5maQVa1b2HaWmge2rA3n2XpG9DxICT+ajS6gzRQ5jJPAaAQeeBmqLXddcH9LxupG6sKaA6TNXt3n/16jF1FtOYiaka0UWbId0IgZ7m1V3/We87b4mQrWLOiDsbSDuc/BHj8Icx2HsWoOMK045XfWCUJ0kl99GRUReE2weIXph8UpOjCO2ZyOeks4kVSqQpEG7m8Fnn5AHTAa3KbvtS7HYgTLp3xeYOzITVbL4d88NuhCFValjp86XhK2Ob2tN/zY6GlX1V9/Iu/3FvOg1eBrK6h1BOQnA69uJ89Uc0pjSxeAthRsqvSlDBbc+TFpj/NyPz8CnCi4x4Hl7kOsjd1j8L69JmuywQ4jrY99ZbpekI0idTjTtYRAluvlCnFCTLKIU3ONgzjcksdpBkdYTR5W86zjJ8oQJqr1z3JtS3NeiufemMNBCw3XiudZtWAPSQVW7RVFmlGeOULI1mqVQqAWpq6oFyFDOAYn3EAZ+jsg3QIr0S6G2a+Em2Yc2So/CDZ5YKydy1F42e5qfWbKSJ1c6v5GVjc/v2kIzNijjZKV+derOjlOyJFNBuJgRe+6lyZh42uMjSEHgBvOxaFCFnWzFp3bvf1k2sG90Mimp3En6LrEsQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(366004)(136003)(346002)(396003)(66476007)(6506007)(186003)(7696005)(2906002)(54906003)(966005)(5660300002)(76116006)(66946007)(4326008)(66446008)(9686003)(33656002)(26005)(64756008)(8676002)(55016002)(8936002)(6916009)(316002)(478600001)(52536014)(53546011)(86362001)(71200400001)(66556008)(533714002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ApNDJkb7+A8XFjIlAAi7rzUm2vmtm5iunqlCkTSA8CdLKLE8ZQRbFVaIWQvV?=
 =?us-ascii?Q?+6PjUeDZceHiMrCcFj8howiuFRSrYQ8qyDiqllBWoJoRBxCI8kfksQoq7g5c?=
 =?us-ascii?Q?jRsonJaHjsZwPDSOko0nqce4sIXevxhRpkL0fSOdBWaJA4D36+JHKTyomXLd?=
 =?us-ascii?Q?u6Pro36EzhAJJ2lPPffLI26IRuXkuHHckGHHYOE6QOWp0Naevy2nVrEGSzU+?=
 =?us-ascii?Q?/WUU6cDcA0cvtAOOWH7gwTQGI34Myu8V6dDof9nsWl/Zo2q5U3YBhX8XuQig?=
 =?us-ascii?Q?UEnd1yskJXEaynrV7t+1dpAJmP78H4nbCJBZfor/afZvFmHdoFNwyLyyKBeW?=
 =?us-ascii?Q?/N6IexV+mCtIinNauQUEWQ0SZAjoeOfub5y6QYubwraPUoz5c3Tbx7MbrE89?=
 =?us-ascii?Q?lf8DoQNm6YBHxIr9eMSL1KSJAA6RFIk9IKBGNdliJv/8rot9ba8CTGreswPQ?=
 =?us-ascii?Q?pcBxNzmWy68WrNoXANW/fnMfUza6MI2mkx/CrwJAte+T706qFkTR0nTle2Ft?=
 =?us-ascii?Q?uTL09/KjQvTC1hg1ZLnL5xuAdKNmbTldUb1TpUoBWr87Cy5TgshUFpZcvMVd?=
 =?us-ascii?Q?nqW0i/x3XVF0FfsmmYAHT0ItiULWEW79Fa0LFzQmPA6OTb3UsOPlI/irLS/f?=
 =?us-ascii?Q?XaGOgyvskOVn95uc4kWwUkpREiOeYZYF8bOkMUiWKg1oIJJ6tig0qt3Y8vO0?=
 =?us-ascii?Q?3EGXSJdbGfgA4aUlZPKv3LWqm8VBI4rHleWx0ldxHL7k1297BUh+IgsqSj99?=
 =?us-ascii?Q?2IgcJRWMsEgFiRrtCEmY9RqeJuGh5ZYrOUc91lX36S2CpGXZS7+RXNX3SvH2?=
 =?us-ascii?Q?1ULwZYbcABCNF6PcGpdgWdYDX96DWXG1xZO6xzHmfsX4TsgF03nov5beVVZx?=
 =?us-ascii?Q?QplQKLPU/AGkYDEK5Gd5CN+TJkDVM4ArWIFDdPPD6AORpSrylozz4HvaYQzN?=
 =?us-ascii?Q?0+p/S3qLRj7G2jCCDfnVXF0gy2dzYFWOkT0h3qTx0knWGHWSLBE5aojiGFMW?=
 =?us-ascii?Q?cKFjwgwGG6LhwEJ7fJ5PmWde5F2uSNq3IlHR90aa2SUKVEa4h3AvLVPO4om6?=
 =?us-ascii?Q?8bAK8cZ733F2g74hPtB6+nQ2JGb5yg=3D=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08c38efa-35b3-4dba-9516-08d8c7fc85e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2021 04:31:06.3363 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GhZ8D6RM0/SHxjMCTkHgxnjXo98X8kWy/bUq/xvVZByITmSA+lahvNk/dVrikmvufINa9e7mH8yEIph0VjIstUwv1aq3zsvwKhtLexI/lVU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5526
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210202_233111_664719_A9B38E45 
X-CRM114-Status: GOOD (  21.89  )
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

On 2/2/21 01:38, Christoph Hellwig wrote:
> On Tue, Feb 02, 2021 at 12:12:33AM +0000, Chaitanya Kulkarni wrote:
>>>> +	req->ns = nvmet_find_namespace(ctrl, req->cmd->identify.nsid);
>>>> +	if (!req->ns) {
>>>> +		status = NVME_SC_INVALID_NS;
>>>> +		/*
>>>> +		 * According to spec : If the specified namespace is
>>>> +		 * an unallocated NSID then the controller returns a zero filled
>>>> +		 * data structure. Also don't override the error status as invalid
>>>> +		 * namespace takes priority over the failed zeroout buffer case.
>>>> +		 */
>>>> +		nvmet_zero_sgl(req, 0, sizeof(*id));
>>>> +		goto out;
>>>> +	}
>>>> +
>>>>  	id = kzalloc(sizeof(*id), GFP_KERNEL);
>>>>  	if (!id) {
>>>>  		status = NVME_SC_INTERNAL;
>>>>  		goto out;
>>>>  	}
>>>>  
>>>> -	/* return an all zeroed buffer if we can't find an active namespace */
>>>> -	req->ns = nvmet_find_namespace(ctrl, req->cmd->identify.nsid);
>>>> -	if (!req->ns) {
>>>> -		status = NVME_SC_INVALID_NS;
>>>> -		goto done;
>>> I think all we need to do is to remove the status assignment here.
>>> While you're patch avoids the memory allocation for this case, it isn't
>>> really the fast path so I'd rather avoid the extra code.
>>>
>> Sorry, I didn't understand this comment. If we remove the status assignment
>> then host will not get the right error. That is the bug we fixed it
>> initially
>> with bffcd507780e.
> Actually, looking at it, bffcd507780e is wrong.  Identify Namespace
> to a namespace that is not active should return a status of 0 and
> a zeroed structure.

I didn't find anything in the spec that says we need to return the
the status of 0 for unallocated [1] NSID.

I've checked with two different PCIe controllers for id-ns with invalid
nsid they both returned NVME_SC_INVALID_NS and so does QEMU :-

PCIe:-

# nvme list | tr -s ' ' ' '
Node SN Model Namespace Usage Format FW Rev
/dev/nvme0n1 191515805865 XXXXXXXXXXX-00SJG0 1 250.06 GB / 250.06 GB 512
B + 0 B 102000XX
/dev/nvme1n1 191912800089 XXXXXXXXXXX-00SJG0 1 2.00 TB / 2.00 TB 512 B +
0 B 102430XX

# nvme id-ns /dev/nvme0n1 -n 100
NVMe Status:INVALID_NS(400b) NSID:100

# nvme id-ns /dev/nvme1n1 -n 100
NVMe Status:INVALID_NS(400b) NSID:100

QEMU:-

# nvme list | tr -s ' ' ' '
Node SN Model Namespace Usage Format FW Rev
/dev/nvme0n1 foo QEMU NVMe Ctrl 1 1.07 GB / 1.07 GB 512 B + 0 B 1.0
# nvme id-ns /dev/nvme0 -n 100
NVMe status: INVALID_NS: The namespace or the format of that namespace
is invalid(0x400b)

Without bffcd507780e targetwas returning success and zeroed buffer [2].
Now with bffcd507780etarget is returning NVME_SC_INVALID but the buffer
is not
zeroed (which was there in original patch [3] then we changed to not copy
buffer [4]). Above call to nvmet_zero_sgl() in this patch fixes that.

Please correct me if I missed something.
>> Regarding fast path, if system is under pressure even single memory
>> allocation
>> can be costly, especially when host tries to do read id-ns, is there any
>> reason why we should not consider this scenario ?
> No sensible host gets there.  I'd rather keep the code simple.
>

[1] Unallocated NSIDs do not refer to any namespaces that exist in the
NVM subsystem.
[2] http://lists.infradead.org/pipermail/linux-nvme/2021-January/021954.html
[3] http://lists.infradead.org/pipermail/linux-nvme/2021-January/021954.html
[4] http://lists.infradead.org/pipermail/linux-nvme/2021-January/021979.html

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
