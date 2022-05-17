Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B420EC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 17 May 2022 22:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U0BbNmPKGfzU6uTIHnEusDgTgUOXEsXenD7RMrN8pjU=; b=Xuvzr6UAP4/5MX5Sc4K9CsV+np
	8L4n7WbVAPh5GiJb7ovvAZHW6QqLZS9mpuZ48qabFqmIDSQWcTsfTL8VXzNvwhsJhgaL3tj2OhyHf
	+0CF9iHMgQRFlRMTC2+giUryJuDzMetHaUaHFfhR5yYdbgw0g8Z9L8hsrmP3Zq/rrL+b/trp92sXQ
	lsGsi+xc27gfcDvcyjhnoduIyZldYGPZpde0BNKGMQrNXjdihRMb3ZP7WlW4IuJyuWxzVANYFThw8
	qri4pCi/7GcTCAumKwINHdz5/KrU253vK/W3dbL4oCyTCp9nMm5vUnq3EjhDiuyQWpXZA44x3+6yX
	uuRzquBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nr61m-00GA7S-RI; Tue, 17 May 2022 22:50:54 +0000
Received: from mail-bn7nam10on20603.outbound.protection.outlook.com
 ([2a01:111:f400:7e8a::603]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nr61j-00GA5g-BF
 for linux-nvme@lists.infradead.org; Tue, 17 May 2022 22:50:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XuzzlVIGsuXJdcCfET8s05DOK8Fu/dlhxMTICaWgKnolAqQcy+UzhnQQlojh7Hl2hmXfp9vMHa6b+diWq2kS/Gv5F2nOd4T1e0ctUeAKCuTWgrtk3vwSY49QafkS6HrJ5Tq13Pz8KeZxYisiBBESO+jR42CU1HcmxX0Or3eXl1Tm0zwOH+mOJUnGtE3l/uXJO86bvELXshdigI2uwHzAroXa7XNmX02ABWcyW8SaK87hw+kWQVltOnHpq0pXO20Q6ptb+0W8SxGPUlWvOY1NgmkEUfKBZuYJyoA0an4/ahlXisiph3r2n7H/6O5k+t65sGuvL8XlUXbav3OQ7P+ejg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U0BbNmPKGfzU6uTIHnEusDgTgUOXEsXenD7RMrN8pjU=;
 b=MtnMdsCSz8XbstfElzPOk0EuaFmKC9iG2HUXAvkGK8LT/1Nt6/+wJeCBvHsPaO24IM6TLK/RWwCAXOtcuxkYdHqROIJ6///e4PBLEF17ppaKngGcXYaYbc98O7a3NsssGBu2RuYX8w5npJfQulFBsU3FVOBYi0zRDcrB87D1q7tecUjXUl6cCCDcjGOv0DjlxJjSIfHiNyP03GRly6sPHurUiBOtY8kqCPHDB13NaNVdB2QtN/vwTsee+iM9ZoUaAd5LYZhYPlktPWekeFIo+3C7Zstslk8GcVKKONqab1lSwmmtXTo2s5skr9vzMPArZXzPM3qN9SInMPczWsBkxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U0BbNmPKGfzU6uTIHnEusDgTgUOXEsXenD7RMrN8pjU=;
 b=eSRX0AZoL8WO/zkke6eqymMYXuSA2vbkHvAi7KP4DzZiZkNNEV/MV8jZwsTXgf4/bSSita/Igdh6P0YdHS2lDTbM/MCQuJvGzs6UhWic+NYhbyJ7OpczI+daftLk+0qDcA3Op3HpK95VTK8ABp79Pt+wRd2vWNwDLtDaGvVaiPKwC2Hr+44W7EbkPwkRq8WVcQVkrt7GQ9HUjdlRqxOtaMlZhVR66taYontvj4IlhD117H1O068lmmjPZz83nJZGG4RHOcsoTMU2rfEFCZWB1s5IF6lTzJ+Xi04i9EQ1pRJVHvfM7u1lU4wAgtdPv206wrXw+wU3qm27P3HsjgPT5g==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR1201MB0240.namprd12.prod.outlook.com (2603:10b6:301:58::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Tue, 17 May
 2022 22:50:49 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4925:327b:5c15:b393]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4925:327b:5c15:b393%3]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 22:50:49 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "Engel, Amit" <Amit.Engel@Dell.com>
CC: "Grupi, Elad" <Elad.Grupi@dell.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: kernel panic due to a nvmet race
Thread-Topic: kernel panic due to a nvmet race
Thread-Index: Adhp21iJ9u9jG5zsSGGi8oBfAS1jxQAEZqcAAASRRyAAEFUiAA==
Date: Tue, 17 May 2022 22:50:48 +0000
Message-ID: <5131d4f6-2a05-78ee-7a05-7af411d13cb2@nvidia.com>
References: <CO1PR19MB4885A916016D38EF6CFD07B6EECE9@CO1PR19MB4885.namprd19.prod.outlook.com>
 <b5f0557f-bccc-e19f-bf66-7de1f891b6e2@grimberg.me>
 <CO1PR19MB48850C38576C102DF8B5D0F6EECE9@CO1PR19MB4885.namprd19.prod.outlook.com>
In-Reply-To: <CO1PR19MB48850C38576C102DF8B5D0F6EECE9@CO1PR19MB4885.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dc204077-466b-4697-48d9-08da3857afe2
x-ms-traffictypediagnostic: MWHPR1201MB0240:EE_
x-microsoft-antispam-prvs: <MWHPR1201MB0240E229BCEED8C1A091C204A3CE9@MWHPR1201MB0240.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eftYioIPHTADtHx+zGQ5wD+obwpNPN2XoBv1qWqmBhGoRJCXyT+8woQom1NOR/s+7IHOfXdvd+DKGguSRZbs+HteLSxvIIIS17ySm+N7a2oey33DF7abPffXpbjCFOSN1MW2n00fWhIL1RvApQ9dI1YklSc3LR4ztTcy8kmHnZ/fIxObi0J25nQ2n/fgxPxMxR5qLZBAdBOhicawhQ7UEGYlnqUHN66+CJ5bIvc7KEW5zwuNZ2O0ex3qpcjNiwSJJx5NQuRc7xDWzyWiv+Kgxiq7CuLfQ960iy/8nq3vQaJ/AVgpVeh5JlDhoFs1cpCpWBSQoQXJoJOFdJQfCe6QejjJIkTfP4eEeRwikqSNkN+Ce6zRFFqguHqXepcN10xU37eidPbbpOfmwomOYfxXeNxSxMsDrVd22ZQIYmOMlp2sDZTTsyps4R863yEYv4d7f3mnCUBBdHf4yuxj+zN6rFnztvf4O5pnyR9dZM1i0PC4u1io/iAIHseyRDheLW4dvBxMmrvap4MI8OhSV8C1KnZF1UY3T4lImXHBcSHnzZmSmglJY1JqG0wlG3Dju37w483vtIVM2d4cIhJtBvBAbInCZKwJye5JtDCjNravLSLEw9hnZpeLY9aQGJqczFnu651Rl5N57LshzNaHvP1w43qWKqi3sOUZQS4XXnAHSNC77EblZt+zn7CHQD6iP+1IrVTWG1bgrGSRYOrcDIR76rJSP2oBfDjSmv27mIcKgpTvIE/ZiO/dd/ug4Wbg/L7uhOhmMfDqRBuxnW9rnrKD/g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(4326008)(83380400001)(122000001)(8936002)(31686004)(186003)(8676002)(6506007)(53546011)(316002)(5660300002)(31696002)(36756003)(71200400001)(86362001)(2616005)(54906003)(6916009)(2906002)(66946007)(508600001)(6486002)(6512007)(76116006)(64756008)(91956017)(66446008)(66556008)(66476007)(558084003)(38100700002)(38070700005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UURnMTQ5dEwyVENWaXV4dnVTMmJBWit0ak5VRCszV0FiMGtxdml4SjR5YTJt?=
 =?utf-8?B?aGx2eUo5bnRZNFZsVG9QcllmMmFoZ3RjRHZOS0RZMUZOK0RoV2krbG1sdEJF?=
 =?utf-8?B?ZVdVTnpPUDlLNnI4OFRGVnJuc21vWHJhcXJESUNvNEtxOWQ1SWpWUHpQQVIv?=
 =?utf-8?B?UWRoU3NaZzRWR1ZuUEh2ZVo0ZC9pMmRhY1EyRE9WVjhsQUJmQnpOekdxWER4?=
 =?utf-8?B?bDhrOFM3YXpsQVdGanV2R2gzRDdvTXZHcHlxVHRZWktqaElHSmkxbDRDRDdV?=
 =?utf-8?B?VWc3RG5TNHN2OUd5RXp2NDR1d0pMVSsvVTk1MkhkcmNITCtRQ0xWeDFYV3RW?=
 =?utf-8?B?RTZLSU9FWFhqV25jVyt4anJQLy9LOGxpZGU0dlQrM1NtVkVKaDJYbmlZVDUv?=
 =?utf-8?B?NC91bWl6SmR5Q2NqZzloWTlUY3JSKzlWaVRlaUVGRG1hTExWSktLUnNhVnZp?=
 =?utf-8?B?WHpXWllaT1BpSHN5N05TSnFIeWRxb1dQR2hGLzJ5b25wdWh4OThQZkU1ajc4?=
 =?utf-8?B?eStaMEx6WWM4M0YxMEo3ZklpZEU3VzFmeHl2aDJQTTEreFFZWldRTTBybGtV?=
 =?utf-8?B?ZS9zUGxMN1RVSzJWSnZBS2QxdFdGRUhVNTBzK3VBRDAvekxPQUdHalVaN1V3?=
 =?utf-8?B?M2VkRi8yQ0xlZ1YxemVscTFzMU9QRUVjS2srbnZ6TEwrc2tTM1h5UTBpb3BO?=
 =?utf-8?B?WjFCN3VBcGFtaExmMEExa0svdWxUT2UwUEF2NWdjbVkzcWE2aXIxakVhcW83?=
 =?utf-8?B?dzhldHJNMFY0ejZ0NUNGOGwyOEI0TGdCNk1CT1dtcEhLL05yVm04YmtqOE44?=
 =?utf-8?B?TW5YNXpwWjJ4Qi9JZUM2eHNXSklFNnNCTnpqdklVZ1pnWHlyMzEyR0FRNkJY?=
 =?utf-8?B?QlMwMHhJd3RQZm1Lc1ZxVFlrMFMxZ3FOZ3UxZ05mNXptVmlydW9ieEs0QVBW?=
 =?utf-8?B?ZkZISXlGaE5UNHBTNzJmMG5hTWxrRHgxY25QVStVUkUxbmtaRDljSTF0NGdn?=
 =?utf-8?B?QjlLK2V3Y1dBeklpclAwelJOODg3RjNjZDY5TkxDeXBjbm91YVJ5MEpuY3c1?=
 =?utf-8?B?Ym1BUmhKdzBKNmR1UjJ4aEpxaUV5NDZVVDdaOTBwODByWm1uNGg2ZHZoNWJh?=
 =?utf-8?B?REZreXR6THNjditlbDd4NGZKczVtZE5TNzZwMEJvM016V1VOT3VtQlg0R1Zx?=
 =?utf-8?B?akRQdWpLcnF4WlFXZURTeVIrbElkeHU3RlZtTlZOc0dZdDZYbGx2czRST2dP?=
 =?utf-8?B?UFVnL29kbk1FbU9LM3JmV0x3K21NN3I4N2hYbGNITzlPMG9ncjA2Lzc1R0pZ?=
 =?utf-8?B?RVhtNmtuWnk0WmxUb2VmR2JBMnlJQWV5eFpwa2xuTjRkS08vdW1wNUltb0p3?=
 =?utf-8?B?S1IzbndmekFjaWZrZjI0Zy91K25oNlRiSGY1bW9JKzFZWDlSQk4xaGpublpK?=
 =?utf-8?B?MHVNNE13Q2hTNnZISjNlbEduM2pIQjBzTytDTDM1WkhIcW1FOFVJNkMwbVB1?=
 =?utf-8?B?K0lVMUtxM2hIaVJLMkpJdXlzYUk0MlU3QjZkTzhPYVJkM1NnZ2EvM1ZlK0Z6?=
 =?utf-8?B?V3dkK0J2NnAxZDE0SHNleGd0YmMvYkp4V0dmQThHTGREL21FTTJZZjZtaTZH?=
 =?utf-8?B?SnBGTC9zblZZNjN5ZjROTTB3MFhTNm56QkN5OTZ6a1ZsVXNkcWJsK1QzU3Ny?=
 =?utf-8?B?VHpWOUhBdjMwaUQwRW5VMFdWbnFKRGx3TU16SnY4eVh4cG5XNGJOWDJ1b0gv?=
 =?utf-8?B?MXA0TTVPaXk2MmNITHhIcnJNZUE3SWVMUmFzUmx1ZXUyREZvcy9BMlA3YVVk?=
 =?utf-8?B?bWNtbWVUSzVhc3dJWTVQNTJyZ0dlRUhvWnN3V1BiWW5mOENkNzM5T2dvL1Ns?=
 =?utf-8?B?RE5kQVliZkE0Mms0cXNiYkFnYVhsb2NpL291UklkNlY3U24zU3B5WkNlUncz?=
 =?utf-8?B?eEVtdXVGMlI3ZnV1d0NOWm1WbFlPSVdxTlIrVW1PaWJ6U3B1UmUvekNiUEJ5?=
 =?utf-8?B?VFFlOFdIZjBSeFRBbFN3aTRzK0VrMjBqY1l1S1ZlcDZCTWsrWWl4TE1pN0lo?=
 =?utf-8?B?V1hDUUVmQ3k3bXMzOVE5MG5RQ0g0SThzVEVPclRmSldDQVN2N0ZRSmF4bkx4?=
 =?utf-8?B?Ykc1Ry94RG1YMlQ1UHg4S0ZSRkVORTNBaCtmTmlpc0pRbkVXY2d0UzN6bVhw?=
 =?utf-8?B?eVVKRXo2cjR0S05YeHJqWGVUbXpuVUI1WXJsYXJtWWpyaENjV2pIVHVoNmIz?=
 =?utf-8?B?bHBDYk4rWnNzcDNCVWdWaUZOUTVNankvck0raTVjVzc5Tkh5RUNCTjhmcDQ5?=
 =?utf-8?B?dzVockNSa0lkeWVoZ0RDNXdrM0J5eit5RklRVFNhRXFpVm01WkpxWVJjV0pO?=
 =?utf-8?Q?cnsikS9ZGoNTsM6RoR8S9O3z1yV9usGRhady/4NBUji4g?=
x-ms-exchange-antispam-messagedata-1: 8OLt1R9tvyVBHQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <4F8485FBC22A8E41BD83C95D5317F74F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc204077-466b-4697-48d9-08da3857afe2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2022 22:50:48.9874 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0r6NBI8M86R80jdZdXfYdR8HMJ/v3/m2X95niU11af484dGj30izbFxSUwNtZY2xanqbsa1UBAXqF3LlG7LK2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0240
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220517_155051_670639_52B2DEA6 
X-CRM114-Status: UNSURE (   9.18  )
X-CRM114-Notice: Please train this message.
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

T24gNS8xNy8yMiAwODowNSwgRW5nZWwsIEFtaXQgd3JvdGU6DQo+IFJpZ2h0LiBXZSBhcmUgd29y
a2luZyBvbiBhIGZpeCBmb3IgdGNwL3JkbWENCj4gDQo+IFRoYW5rcw0KPiBBbWl0DQo+IA0KPiAN
Cj4gSW50ZXJuYWwgVXNlIC0gQ29uZmlkZW50aWFsDQo+IA0KDQpQbGVhc2UgcmVtb3ZlIGFib3Zl
IHByb3ByaWV0YXJ5IG1lc3NhZ2UgYW5kIHRvcCBwb3N0aW5nLg0KDQotY2sNCg0KDQo=

