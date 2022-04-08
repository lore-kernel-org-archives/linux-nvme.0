Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAA99C433F5
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Apr 2022 02:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QaL13KhYdy3sO9xk15lNOaDXN0ONm57+p89+Dlj7Ork=; b=mmhuMR+qtBrmjeRl1EuaheMRE8
	3R/94HHdBGZZss89c6N+ObISQWuBshfdyccjhy11ywX69rsJjVOGt1zBIa8l2eq4F1DWiUAtdNGJu
	oxfQb019blxut7kwY43KOup5uBITydZysS+gzxb4bN6vIgAEv6UlY7laLUb4iX/zw8EnNxGfvnDPU
	AIKkpR84ewUzmf0xFIoO3RVVfj4fPoyajSfnoyf57kPeyDgffMB0fEX8u3QYJLo17gI93/wNt4VjC
	mxNIkbkJPSRzU5QjPbHsa9/Mx1Z3lzgPCShSFpBxksiaW2B5r+QNV5dU+RpJIiuO5I2LHO43oXJz8
	8ezDD8+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nceMm-00EeBT-Sd; Fri, 08 Apr 2022 02:28:52 +0000
Received: from mail-sn1anam02on20624.outbound.protection.outlook.com
 ([2a01:111:f400:7ea9::624]
 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nceMk-00EeB6-EJ
 for linux-nvme@lists.infradead.org; Fri, 08 Apr 2022 02:28:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JMIQBFlFjoNrBlp1C0x2e/9v7B3kRFkjzZVAEcmPH1/nffsIi07vsretrPqJ+OgGIsvQsH1ufRjHmBlVAsxBprljC81c4kCdmc16OwUboJtEeI16/MAymj46bSr6LA0vr8GZt7GkDgSKe+U/Nvwc0ZabRizCxpdJjU1ZqNyi7+3fkC8SfRi+P9w7fTLVfWp0whC1BwJorM1Mw1noKk3/AR+KA4fv890lyF7LKev+SEWcsNGySGNfIJCco2O+gQVhURllPwyiTRtED5kGurbIK9WVEgrKJC1VouIVvJZV2hWLfFrhKH9g7J+FY6NviEQ2k27kjNEiiJ68ZQjOd7X6Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QaL13KhYdy3sO9xk15lNOaDXN0ONm57+p89+Dlj7Ork=;
 b=n75bqxUfwRQv49UJHxBjpqesV4hswg72juiOiv7paIubwiN6CHdzM5C1DOtQSfgncZVfwixSRgYRZ3sXFIZ7KRlRjaZ6U7rDPwUwWDuTGdFy3LLPkdgvZlMYLQOfOKJ/KlZg76+gRASja9A16GoBd7XZKX1t2aB83LF8hAcmkSmUhv1lWDa3gTQ1yB7qVjaIJeAoQwF/O2vi3ypP+/fJomOSrIiiDxgWpNZ8OijO4YY4Z+nQFj1ETY6hPit0sixevEf3h8XaG5Av8umVpdTHj8LFziuZSsvIQvN3CijBbjECorMq6gq41HevgzTtIVBKIknrYx9p/xP4/j4K36cASg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QaL13KhYdy3sO9xk15lNOaDXN0ONm57+p89+Dlj7Ork=;
 b=HjyHdyyhB8/NnZhYw9fkHWnhiaV6qX3FtXzyjBCoVxNaN4C5qQo+iBfICcNdsNuPokdEd4o/NsfPL1/049Wm5EygIzjnRA0t41uo+xOFfVt+vmnVgB6pVdyX9WoTpXbxksAQ7SCzJ4sAfOJmCOSD7NkXdEN+zG9HdpcVFnimBpnmSHD/FyZspj5NWs1pKKIoGNMMVY2asQ+lzZtCgRcCP3g8NLL2GBsM3ebLh53svG24yDQIK3308RnF1FOtnj+cfB2TgeVeQEFCCRYnGQDWgigRIgAgaSJGdtCgjiK36YwZOJ9KA/9MVywH+ou+YoIPd5Rji2DNlPto467XU1mQdw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SA1PR12MB5640.namprd12.prod.outlook.com (2603:10b6:806:238::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Fri, 8 Apr
 2022 02:13:04 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3dbb:6c2c:eecf:a279]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3dbb:6c2c:eecf:a279%6]) with mapi id 15.20.5123.031; Fri, 8 Apr 2022
 02:13:04 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Alan Adamson <alan.adamson@oracle.com>
CC: Sagi Grimberg <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>, Keith Busch
 <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme-core: mark passthru requests RQF_QUIET flag
Thread-Topic: [PATCH] nvme-core: mark passthru requests RQF_QUIET flag
Thread-Index: AQHYSdUmD3brgDUei0iedZF8Ixk0L6zjGb6AgAAClgCAAAWlAIAAT2MAgAC0PoCAADK+AIAAiyCAgAAG0ACAAAbxAIAAA+AAgABTl4A=
Date: Fri, 8 Apr 2022 02:13:04 +0000
Message-ID: <752d1875-1680-8f8d-7330-d5e8771c7e7a@nvidia.com>
References: <20220406164109.30449-1-kch@nvidia.com>
 <Yk3FT78uVW+9rRV5@kbusch-mbp.dhcp.thefacebook.com>
 <21a3a237-5f3b-a608-2d79-e0a5fdcc0d88@nvidia.com>
 <Yk3MNrI3YfjvbRqZ@kbusch-mbp.dhcp.thefacebook.com>
 <92C8BCED-6845-46D4-BCD0-78E790A5F86E@oracle.com>
 <20220407085113.GB19062@lst.de>
 <64ff1e92-6c6c-da38-8753-0e6098394622@grimberg.me>
 <4386789d-6722-add8-5b42-f605e48e894b@nvidia.com>
 <650E6456-BCAC-47DA-B50E-4321E98AC9AC@oracle.com>
 <b793928e-f127-8155-b124-642614afbb85@nvidia.com>
 <C8570F84-276F-42D0-9914-4440FAF64B5C@oracle.com>
In-Reply-To: <C8570F84-276F-42D0-9914-4440FAF64B5C@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bfb7d24b-ff9e-4f52-0ed9-08da19055085
x-ms-traffictypediagnostic: SA1PR12MB5640:EE_
x-microsoft-antispam-prvs: <SA1PR12MB5640BA24160E18BCBDF20FC8A3E99@SA1PR12MB5640.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OLUrb5kTIK1SFVhDLj/YFmNSH38Q1VjYqLsavQoGmxgXs6Pb+OKtNs/Prg+q/xM5UuYQHQnZfIveCsX16BDAI/OUiocWnJwQvP8RM/2+OO7Ec3/6bGnkREj0EjbvsW1DorpvpvFlRDhkYm/xUqWgjQwvV8Efhr691WSMHaUqlHWqphbwqgkTdaO+SgZe+GFC7GqToq83VK213HQud2SiMs1SpF6JR2553LHMV+KXosNIxc18cGEA0eWQk4BI+YvkjmFd2SkUogTS5A6OxVWSrpEy7krmYDTFRFVKZIhGlbo2mm/bWan6iqsdwXdsyVM0W9hYTwQNqeALNssRndc1eSN/VDIzzkqhfiNkDDIyTfuY2BNJGO91vEtUSnw+gowIvqIKWUqN9zoH7eXFugybM+qqqJXVeAKJ8E7wUAQ8NmY7Daw9dn9PEavxTmfTezGtW4ms8XprqgJC1w+apmExFwBeHzzK1zSPFfv3LsPlgt5aU1wc0BgbKrSONhp5F+S6YNPvrqRH7zC1LywRPCCnhd8t47qsV3VhYEh554q3aS43h3NRw6y2F44BG4AzO16hVq6vBAlM+vegcuGP+6vE0gbE4S1h7Roq2RO1HA8icrz0Vo4wT7sXpoXBW/YTBifDSLp7RUNtlWiuZiSpHvJrsS7Zqgt5RXhsF97c29Z33Hq4oOwHvsbXxsK7CdviW1irsu7DepzcjP2HgCRBIVHkbZ+hnpzsdfPxDFS6eStx0aEajYSPByeXm1Srh0K7Aev/yQiuTMiiPFQHmB/5GYDHQQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66556008)(66946007)(186003)(66476007)(83380400001)(8936002)(2616005)(54906003)(66446008)(71200400001)(76116006)(2906002)(316002)(91956017)(5660300002)(38070700005)(31696002)(38100700002)(122000001)(31686004)(36756003)(8676002)(6486002)(6916009)(64756008)(86362001)(508600001)(6506007)(4326008)(6512007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R2kwL2k1Z1VDRnF0ZkpVaEpjVzNSckNnTnliWmdFaDcxM3lVMmMvbkhOSm45?=
 =?utf-8?B?MXpTeDlHL0V0SkR5RExyb0s3YTEwMi9LV25DR2ZtSFl1VVpMdFlySUI2QzNB?=
 =?utf-8?B?S3k0azduYTRKQ0U2VVpJaHBrdXpWK1JCSWtXaXpIR0U4MjNTa21PM29LWFhi?=
 =?utf-8?B?Z0ExbStsVE4xWkROczdUVVA1OXFISnl2WTB2L3hVYlZnVkxyTVE5MTFIUmdq?=
 =?utf-8?B?ODVTS0hXWFdTc0xocUNXN3p6ZjhUSm93SkpZVjByRHg4Q203Sk1GbmxkbjBp?=
 =?utf-8?B?TlFqR0drUGh1dmZqOW9hZ1lpWGRzc3Vha2N4QmRkd1JmcS9RWnAzZHpVRzUv?=
 =?utf-8?B?ZE0wRStzNXYySnh2ZXlKWlhMd0g3eGVqS2JsUnZCYndOUm1hOFo0NGNGaVdx?=
 =?utf-8?B?cG9zTlZZNVZvTXpMQkhVSjgrZFZVbHk2amRBcFdaekgzZHBIRTRQQ0pXUWxu?=
 =?utf-8?B?UDZreUt5WnB2TXRkUVBRc0EySERVYzRBaVBSTk9iaTRWM2l2cjNQa0lSbnpT?=
 =?utf-8?B?bXFCWXF5dEd3RlpVSzdIOTZrZUhOSDNLdFFVWllZS0dUTGpkVnUyeDdtZHBq?=
 =?utf-8?B?SUlZakI0K29Bbk1jUDJOM0tDZ0Z3U3hkdmRhczNzNUlxM0ZPYXhVN0dCc2FX?=
 =?utf-8?B?bC80M2JYYXdla0w0dm5PM2RaRzU4clk2bUx1S0RRV2V2aVIxaThMTkhjU25Y?=
 =?utf-8?B?dmNvbHpLMEEyKytVKy9XMnNxODhOcExIbkxTcDNhV2d6VDIzeUJGaW84WlMx?=
 =?utf-8?B?dXBHajhWbTJuQnZ4QnkwZ3lWb0pSWDBIcHh2dUtoRzY2bnpoZ2lEdVlJYXla?=
 =?utf-8?B?MjRNVSt1WnpZY2t4RGNxODJrUmpxWUwzc1IrZ1I4S25IS21xZkl1ckNqZTN3?=
 =?utf-8?B?Wm14RVJLdm1qckJaREhNZFVIbUhGMHU0ZlBHWStKNFNLY1kveUdvRWpaRmZH?=
 =?utf-8?B?eVJGVUJBVEg3ZUk2dGp4VEh1RHIvbWkrV2lwWFp5M2UrZ01OUFhDcitJM1pV?=
 =?utf-8?B?QUlEc3FJTm01cE5vL1hLb1hYRHFvWkx2K2paSDJ5TEVTSXpRaWtqNlhiSXhE?=
 =?utf-8?B?dzJ6TkxsZFNNMHY1bHZ1bjJ0WmIvTjlIR1hpRGVPTW9ocXdrZkIwYXl4Vi9P?=
 =?utf-8?B?Z2VMdEowK2FpYzlVQURIRnJuR3BWK25qUFE3aTRlSndtL0RNNkh0anp5RnVN?=
 =?utf-8?B?andJQVNQQ2tyMWFyRHp5Z1A5TkpBYUFranc3WjhXcU44aTkzWkx4Q3ZsWmsw?=
 =?utf-8?B?T0lvekQrQ2NqdDhTZ2FhSzluOE1UVEV0WTVsaktpam9iSXlTajMrZzVDT0k3?=
 =?utf-8?B?a3NVVktHZ3BqSHFGWUhEYzVZY1pyM2JqcTNqYzMrZFBKYWZvcDN1RVlwbmNN?=
 =?utf-8?B?YWlDLzY0T2lWSHlIVnVZa09RbERZdXQyWktac1g2Wlp6UFJNb2EvMm40amlK?=
 =?utf-8?B?eHRGQ1FNS2ttNi9hc2FlQlZIajczT2VyNTlUMDd0NlFCTnJhN2ZDQW5uWFR4?=
 =?utf-8?B?NmFHMHhUbXpkbElGSmRBaTNiR2E0d09ZQklYRGM4UTVrTG8xeHVGRmhzQ3lw?=
 =?utf-8?B?aVVZS2wzVGcvNVowbmpFTjVCbUlqSDUwNkV2STJ4bk81WXl2MlVGdlhKd1pB?=
 =?utf-8?B?czNFbDFEZTJxN1JpVUdjTG96V2JKcmtLSE9aVFJWRW5CSytib2FPQmRPR0lU?=
 =?utf-8?B?NytwTlBNdlBCVlBrOHRyY1EwTE8yQzBYNEJXSmxlaVlNSXRSMjVycFB0SmpM?=
 =?utf-8?B?MHJnWU9xYmR6dVY4QzF1WjB1Y1dVRWtpM2N4K1l3bVBWbU9XdDFudTBTY1BO?=
 =?utf-8?B?YU0zTVBobUNyUUxkR21HVVNUd1AvdXhjQmtDcDFkV0ZYNndudWcyeDBPRW9Y?=
 =?utf-8?B?TGQwQURra1FtNGdUNEFqdWFnTVgzY1B5bWhLQjNWVXh6b09panNEaHYzUVB4?=
 =?utf-8?B?Mktla3A3dDBheExGVzF1THpmV09hNmJxWVRTN2RkV3kyUTVNa3d5S0RVT3JJ?=
 =?utf-8?B?Vi9tNzNhT242by9CSG5vTHdTNHZIRGJVN2hNWlRxbXJlOVZab3FvczcyTmZ4?=
 =?utf-8?B?WGRCVG8rUkNBdXVBb2tkdkxWS2UyUUgxZkZrdk9BMTRiRTFtaVlEbmdMbHlY?=
 =?utf-8?B?ZWZ5SGRiWXFseU5qa1NhaUI1RmNFWllTb29HVDFXN083ZDVURERneHVVcU9z?=
 =?utf-8?B?cXBxUXBFeFNBem91bGhVbVdDYW9oc2Zta1RNWjUyWGNZZXF5bFpxUExFOW11?=
 =?utf-8?B?RGlOYmxEOFpsQk15bEpPLzJJQ0NyK2lqVkxma3lxclkvTmVYam9tL09ZbitC?=
 =?utf-8?B?cEROSWZNYURUU0ZMRTFNL0Fjb2ZYVXJmT0FxUmVqSVFaUEZUSG1Xc0tTUXVC?=
 =?utf-8?Q?zCKJcIYX4CegRW1QaihKXje7df28WLGyG5bzsfbowm95m?=
x-ms-exchange-antispam-messagedata-1: LJrXW08bUWYifw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <735253C9F5BFC441B35115E36F69FC8B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfb7d24b-ff9e-4f52-0ed9-08da19055085
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2022 02:13:04.1837 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oBzrYOZSIP0HB3orrt9yyExdM31e/MYbWxr37iNRuI07NGlecUPVQQrEcIdIL/0HRLji80b+rcAY4Gcl6hCmOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5640
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220407_192850_519282_37DF3430 
X-CRM114-Status: GOOD (  12.70  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

DQo+PiBudm1lIChudm1lLTUuMTgpICMgZ2l0IGRpZmYNCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L252bWUvaG9zdC9jb3JlLmMgYi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMNCj4+IGluZGV4IGYy
MDRjNmY3OGI1Yi4uYTFlYTJmNzM2ZDQyIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9udm1lL2hv
c3QvY29yZS5jDQo+PiArKysgYi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMNCj4+IEBAIC0zNzAs
NyArMzcwLDcgQEAgc3RhdGljIGlubGluZSB2b2lkIG52bWVfZW5kX3JlcShzdHJ1Y3QgcmVxdWVz
dCAqcmVxKQ0KPj4gICB7DQo+PiAgICAgICAgICBibGtfc3RhdHVzX3Qgc3RhdHVzID0gbnZtZV9l
cnJvcl9zdGF0dXMobnZtZV9yZXEocmVxKS0+c3RhdHVzKTsNCj4+DQo+PiAtICAgICAgIGlmICh1
bmxpa2VseShudm1lX3JlcShyZXEpLT5zdGF0dXMgIT0gTlZNRV9TQ19TVUNDRVNTKSkNCj4+ICsg
ICAgICAgaWYgKHVubGlrZWx5KG52bWVfcmVxKHJlcSktPnN0YXR1cyAmJiAhKHJlcS0+cnFfZmxh
Z3MgJiBSUUZfUVVJRVQpKSkNCj4+ICAgICAgICAgICAgICAgICAgbnZtZV9sb2dfZXJyb3IocmVx
KTsNCj4+ICAgICAgICAgIG52bWVfZW5kX3JlcV96b25lZChyZXEpOw0KPj4gICAgICAgICAgbnZt
ZV90cmFjZV9iaW9fY29tcGxldGUocmVxKTsNCj4+IEBAIC0xMDg2LDkgKzEwODYsMTEgQEAgaW50
IF9fbnZtZV9zdWJtaXRfc3luY19jbWQoc3RydWN0IHJlcXVlc3RfcXVldWUNCj4+ICpxLCBzdHJ1
Y3QgbnZtZV9jb21tYW5kICpjbWQsDQo+PiAgICAgICAgICBlbHNlDQo+PiAgICAgICAgICAgICAg
ICAgIHJlcSA9IGJsa19tcV9hbGxvY19yZXF1ZXN0X2hjdHgocSwgbnZtZV9yZXFfb3AoY21kKSwg
ZmxhZ3MsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgcWlkID8gcWlkIC0gMSA6IDApOw0KPj4gLQ0KPj4gICAgICAgICAgaWYgKElTX0VSUihyZXEp
KQ0KPj4gICAgICAgICAgICAgICAgICByZXR1cm4gUFRSX0VSUihyZXEpOw0KPj4gKw0KPj4gKyAg
ICAgICByZXEtPnJxX2ZsYWdzIHw9IFJRRl9RVUlFVDsNCj4+ICsNCj4+ICAgICAgICAgIG52bWVf
aW5pdF9yZXF1ZXN0KHJlcSwgY21kKTsNCj4+DQo+PiAgICAgICAgICBpZiAodGltZW91dCkNCj4+
DQo+Pg0KPj4gaWYgbm90IHRoZW4gSSdsbCBrZWVwIGRpZ2dpbmcuLg0KPj4NCj4+IC1jaw0KPiAN
Cj4gSSBqdXN0IHRyaWVkIHRoZSBwYXRjaCBvbiBteSBjb25maWcsIGl0IHByb3Blcmx5IHN1cHBy
ZXNzZXMgdGhlIGJvb3R1cCBtZXNzYWdlLCBidXQgaXQgYWxzbyBzdXByZXNzZXMgbWVzc2FnZXMg
ZnJvbSAibnZtZSBhZG1pbi1wYXNzdGhydeKAnS4NCj4gDQo+IEFsYW4NCj4gDQoNCkNhbiB5b3Ug
cGxlYXNlIHNoYXJlIGEgY29tbWFuZCBsaW5lIGZvciAibnZtZSBhZG1pbi1wYXNzdGhydSINCndo
ZXJlIHRoaXMgcGF0Y2ggc3VwcmVzc2VzIG1lc3NhZ2VzID8NCg0KLWNrDQoNCg0K

