Return-Path: <SRS0=HgeD=FF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2D5C64E7B
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Dec 2020 22:22:14 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2AED2086A
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Dec 2020 22:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="0pyDchck";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="dJ6zk+aT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2AED2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pWVI94UX9HF0aC0zWXHyl8VPIkxCAwdZSL9hlSfFpPM=; b=0pyDchck1YrR6ec2HikFFcGXZM
	tfeAbjFD0qHRJ7SqtGzNgcUvDUYJlLp4fYE+ULrWTUEidMmQ77LPKdm9W+KvHiVu0eSC1tPrqbPAm
	nu8fQAHLEXDeyLNA3Ylj9Xl7BqErh51yh6o67GiGLiNoeraB3YuLblvkkOGw6AQQ15zh4zGQpSHAr
	ZYL4ogtaIevL59u+t0MkjdvrKmzAZm3Sl8M55mwTs4yp1fufWJJZcmldOMDE2eWvEa/nQRCbVyHzw
	deVl4VxidGvYyLiaKIHhXdOc3ZZ0g81PRad5SQcVZvlpTm+D5cnOBXB3UeLNf2LCKha0pSyoDvqoW
	4/A7qHKw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kkE2A-0004f3-0n; Tue, 01 Dec 2020 22:22:06 +0000
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]
 helo=mx0b-0016f401.pphosted.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kkE27-0004dV-NP
 for linux-nvme@lists.infradead.org; Tue, 01 Dec 2020 22:22:04 +0000
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 0B1MLCEI011687
 for <linux-nvme@lists.infradead.org>; Tue, 1 Dec 2020 14:22:00 -0800
Received: from dc5-exch01.marvell.com ([199.233.59.181])
 by mx0a-0016f401.pphosted.com with ESMTP id 355w5d09yu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Tue, 01 Dec 2020 14:22:00 -0800
Received: from SC-EXCH04.marvell.com (10.93.176.84) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Tue, 1 Dec 2020 14:21:59 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 1 Dec
 2020 14:21:58 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 1 Dec 2020 14:21:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LzcQPq1CJKpR7ud7TRe85Y5u/iT7C6aoaNfiItYqSuy5CzWDYC02q7nttiwG1lvj0BfMbTs2h4xsWK0F4/yDQ/AUMox1uWivh/eBHR/NRlOPtjJqZKoTeTQAvfl1wipalT8gnsN5ruZzPzRe5uOCIABAf/D5eCapcMPKUsh2MW358ClHSf685GKs1tMaNidQmGY5ybthDwuEieHSjlMcNBQbWseEVPer54Xg9wxKGxQdJbqNWpfdjnwyN6bAQLnJupuw476kNHd80rOAtua3jKwMqXq3EwzbJm+SxI5XQmzkEuCWtLGr07J6SfNvBWr2gu1ZTAXUYMagpA/R4ErNxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rhhX4uGSAHhjWwN4sTGzwKaGDANQxvKQNpOz+mTAK2I=;
 b=bQdPcUqiYCt+jmZCncbf6ePHmftXPJSyj7aJZYMg/IXahsT2OvjC5Zzak/UDOwcax6ZNdY9I5DlO0g7zxQWritCRnSVYT7BrOxFPRBeimpmUG7Dw6m4NdI1pxglEo5Ir8BTk5S14/vVqx+te6x+ebaTS3arw4ZhhzUVwf4A31DzspQ0Az5SWFUkr2IKOV4wulPXGVaakZpccG55VVz1OowR8Ft2MEnP+nI5zLQ7yZzxoNBZ7HZlSz7rBn5cFxnJT7J42ZHzMQkLp8SEtc9i8SjkLWJqpUstgn5mOIy/EFBZY2oEQQueYsssYE4LeEYWVqEXP5UrMaMh5WnuJc9Vgbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rhhX4uGSAHhjWwN4sTGzwKaGDANQxvKQNpOz+mTAK2I=;
 b=dJ6zk+aTxFIB1wjxDTj/wPkbrMoGQW6Q6B068E3P+jAQ8dZrPqNkLMYsUU/c2F0igTGVviwuw3AFL08t2X6SJA2X4fPp3/iIa2QrV3GAUE0NQmRcsMyIEcuKp2GtiVWx0NiXpOgCcNDCVddHcHwvr4DmOh5i1p20/L4UPCs0kSM=
Received: from PH0PR18MB3845.namprd18.prod.outlook.com (2603:10b6:510:27::11)
 by PH0PR18MB4088.namprd18.prod.outlook.com (2603:10b6:510:3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Tue, 1 Dec
 2020 22:21:58 +0000
Received: from PH0PR18MB3845.namprd18.prod.outlook.com
 ([fe80::89df:9094:449f:db13]) by PH0PR18MB3845.namprd18.prod.outlook.com
 ([fe80::89df:9094:449f:db13%4]) with mapi id 15.20.3611.020; Tue, 1 Dec 2020
 22:21:58 +0000
From: Shai Malin <smalin@marvell.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH 0/7] RFC patch series - NVMeTCP Offload ULP
Thread-Topic: [EXT] Re: [PATCH 0/7] RFC patch series - NVMeTCP Offload ULP
Thread-Index: AQHWvn9JtHuPg8cN/0q5zvPM4JNVpanZqWiAgAk6CyA=
Date: Tue, 1 Dec 2020 22:21:58 +0000
Message-ID: <PH0PR18MB3845FF0CF70DF92D4785895ACCF40@PH0PR18MB3845.namprd18.prod.outlook.com>
References: <20201119142107.17429-1-smalin@marvell.com>
 <eb819457-aee9-e203-13d6-72b3afa4cfff@grimberg.me>
In-Reply-To: <eb819457-aee9-e203-13d6-72b3afa4cfff@grimberg.me>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=marvell.com;
x-originating-ip: [79.182.80.24]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: afa6fb4c-373b-44d6-6b96-08d896478486
x-ms-traffictypediagnostic: PH0PR18MB4088:
x-microsoft-antispam-prvs: <PH0PR18MB40884DC51B8C55D81681A9DFCCF40@PH0PR18MB4088.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:421;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Io9W3LdCKMTUPyM/4x/x4SKG8T3cTzl+hl/7UUDzgks3oQSO5YEcZrUsSB/mFmX6oyH3+3GIq/7s85Ir+Qr1E743C4UQBDxRbwouX2QGxbMRySerH6zdPrH7cHZFq3+x/ASI+528tZ6TWPfv1WcbY/XQft18rqgt28foCOaVBqndP7dZAx6AHIp08uHEnSRURmodf1iW7YOdZWoPQflsyao+2ukQca2O1s+fK8z+h/bICta2OMX5BH5uRL2AIxPpoWDH9cuA7yhu59DsyY+/t+E5tSUn+jFssUdx7COX4iraEKv/sRihQcB5b0lsEJGn4zHIkeOYmars4KbUCjh3xg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR18MB3845.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(346002)(376002)(396003)(39850400004)(7696005)(6916009)(186003)(52536014)(66446008)(66556008)(64756008)(66476007)(6506007)(53546011)(66946007)(478600001)(2906002)(76116006)(9686003)(55016002)(86362001)(558084003)(5660300002)(8676002)(26005)(8936002)(71200400001)(316002)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?NlhwRFJBdkVDdEtEQ3J2UUFLN3VubW1JOUU5cXlmVy9wZFZ4NDhCbWRUbWdU?=
 =?utf-8?B?b2RTNmlpQ0RwQldvWUdZbHpGSmlBQWZxZ1B3UFliL0w2NnRXUmtzQXZKTmxv?=
 =?utf-8?B?T2FJcGoyWk5HQUtseGJ2STVDVjJvLzZOcGdydEIxUFFwUFFuYWZOalozT1d5?=
 =?utf-8?B?S04xV3cxMFhTM25uWUZpTWtJay81cko0YnhmU3U1Ti9Mc2Q0SUFCMStoSkZq?=
 =?utf-8?B?ck5FUzJTZkV5eDFTMnRmV1Vqd0ZvMmJvOEJhTXpwQW8zRlFSb0dvMFdSa3ov?=
 =?utf-8?B?VWhaZXdQVTF6OUp0UDlMSmFXbURiZ3A5V2J3ZmRHaHBoQ21xeWt1Y3Z3SFdI?=
 =?utf-8?B?VzQ3YVdHSlhFd0FYTUp0N0lwb3dZRE5HblcvVTRpSmVDRS95bEpoRkMyeHdU?=
 =?utf-8?B?WXJuSWZ3RGhhanJOU05SZVZnanJvSVdMZFhhbndBVlV3YUtxcUlwKzBpOUdo?=
 =?utf-8?B?N2VxSU9GZHZaTTYraWc5b3IvaEVZTGZybXN0MUhxalZ0cm94cEZRZWNYQ053?=
 =?utf-8?B?SXNiajFWc3VrVjlKYkkwNlJZZXk1Znc0UVJ6Vkh4WFREYmFXZit2RE5ETUFF?=
 =?utf-8?B?QUdkbm5kZ3h6NURzb1FQbUF2dXpqQzkrVnhRTE1qOVM2cFgrZnh1M1JVUGlQ?=
 =?utf-8?B?MTRmckh1VzU4NFloT1ZGVll2L2ZuRWpIa0FpQTl5Z2srWEpuNU1ocXp2aVJY?=
 =?utf-8?B?dVowUE91YnVJdi9FN2h0NU9LY0Q4TDZKNWx5SzVTVk5rekxDNjk5SkVvQlVk?=
 =?utf-8?B?RGgxUkx3bUxtUzY5SVVVNWVRSk1qS1haK1R0WnBCS1Q3UlIzTXh3VHZRbkgr?=
 =?utf-8?B?Z3MveVhZS2dTcXJuUG4wdG5FNnNwZHlYSnFCRXJzN1hHUFcwSy9iU1VMak9Z?=
 =?utf-8?B?QXpmWnI2R1pXTDNyRktoU2tyUmJyNUtvdXlqRktWcytUYUk1d1FLS1pQVWQ1?=
 =?utf-8?B?Z1ROR0N4MzlxN2ZiQUZiUE5OcUtmWEdEcWJJaDdGWk9sczdsaWR5NG9heTNw?=
 =?utf-8?B?Qm5pVkE5ZytUNHFBejBkdndveUFtcHozYVpoR2syV0dmNE9lNFFidGZJQVNs?=
 =?utf-8?B?Nk9QdWUvbmNCZ2J5NExHMnMrY0t3SyttSWU4T2s4NG1wQmVCdGhERm9sN09p?=
 =?utf-8?B?em9qSFJLZTNlT0ltREJWdG04dlhsMnFZK0JmMS9DdVRQZGRNM1RiY05VOTlx?=
 =?utf-8?B?ZzZkMnpqZm9yR2oxWERmTGJpYVlSV2ZmK3N1RVpWdDArdmF3blVEbjhkejAw?=
 =?utf-8?B?WmlkekZDajJlNE5oLzhyZ1Nub2xEd0ppd1BxV2g2WnprQTkrMGhFdDMxUE9Y?=
 =?utf-8?Q?rfvwNtrzfbcuc=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB3845.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afa6fb4c-373b-44d6-6b96-08d896478486
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2020 22:21:58.2006 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6EFOCTN8/xDr4j4q4vsC3vXtqsRIJaxoMIBgjX+cNEJTp5CMiPz3oNDYQa4YSvHzYDIjYRbgzGJ6yyJVCP6DCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB4088
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-12-01_11:2020-11-30,
 2020-12-01 signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201201_172203_912798_8B177430 
X-CRM114-Status: UNSURE (   8.66  )
X-CRM114-Notice: Please train this message.
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 11/26/2020 3:27 AM, Sagi Grimberg wrote:
> You should tag this set with RFC, this is not in consideration for inclusion...

Understood.
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
