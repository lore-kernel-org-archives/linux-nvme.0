Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09FDCC27C5E
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Jun 2024 04:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uk+P4tI2wOAnF9eqA7uzu9rOALffv2/qzN0+MINc0gc=; b=bTTMMCYpGQ6jC/FfIK/gJVSvH2
	0SHnY25ce3CRBIyEl1UO2zFjS/m/2oIGv55l+e6XeJBayWsbRVsBzcVxk2Kc7iaCJqMhVzzbk1WJT
	WRD11DYy1UNGojM2iR27yAh9aS38OicNdAhCzgIyAbkmegxOYg7AdXD5ZkCD5DbcmTbG1CDZS6gx5
	F5BJJ/hw8Jz3aPJ0flhzstotZi/V0iVMmfgNWvpsXOn7tYZHzXV+6DGcS1KP+OdOuGyWgPtlSRY3h
	UxSXbNJLvObWS4z7sEqE3s4ZYjp4N+AQFwdkHWfqw3pH+BGOmVck0xjpKFdrVHGHEOOMKfBVDC+pb
	9GL4HSjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGWjp-00000003l9u-2V2w;
	Mon, 10 Jun 2024 04:34:33 +0000
Received: from mail-co1nam11on20600.outbound.protection.outlook.com ([2a01:111:f403:2416::600] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGWjd-00000003l6S-4A6Z
	for linux-nvme@lists.infradead.org;
	Mon, 10 Jun 2024 04:34:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M4LHnIBumTEgXXkY+wUgaHXnR1wp5S0R4FXDT/Q9l5Cuft58I2NFgoChcnk3ERADVKTifnBy90wGgdqUrjN4kcReTY8CIoqkiXJZLKnpHFqqRTE087ftYWrzctGVsCkbiXHE4Bbop3sdGDcAWxwy8nZCEdV+j9PBXnZZQ0nEAlkuACn9h91nVSeoGmICBBkSdwHX/je4GV3mFDcdyfuu2e/EKqmK98Yb7XjMdf35Yl3j0sSGod+8WtSzKLNsMsm+7J6gQHAwOHsTp1re/mn8fywcs3Z+MXwXj8Uyc50e4jpbGPAGsDHGjRZLHaHONVB9fsHcK9WW6QztUbnRmzDBNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uk+P4tI2wOAnF9eqA7uzu9rOALffv2/qzN0+MINc0gc=;
 b=Yd8/+724/9dLuL4cufQ0+vn6L6NXB3Ith/iOCfLyoFi1DNbTSAslT74Q6pIo0jKguPTF0AzWwJ3HEliwMP2nmpwffa6RXGF3qn/otjraPPpEUwemc9t1JnVe0T90pPl3vTccOfaQKvmIZc34JjdUlnhDzCJomeN+FYEjvRzsEJj3ng1thzfBaO9Rd3KWJxdXrndXWeMU9tw0Ox0uTTKKejugRPd6IeG8frq6NJcqTeJtoCmm/UB5juotkAaR795JNuUQ5OA9Y5tm0BDwnWPbq8GKbGMAohpWAGxEPUu87Oq8VBs9/oiajX6fYHoLux4Z/hyr+ZgwUDBpCOss90Diyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uk+P4tI2wOAnF9eqA7uzu9rOALffv2/qzN0+MINc0gc=;
 b=XDM12pspYUCKqRC6c5UOxWSBAqLtTDWjlrxVJkQRYuegKTm1FKjxW765RoJDt/VGmNWaVvZw+UV8AwnP1z4+Zfd2hpV445VLeA9jfRMCzncAyBCs8HA9XuRjKyzTFkI63ZYtU/v5O2AlxB/DYnPcuyS6dEFyxD4SMaLLFFLGTKr94zBT+ur3b9LAtEaKLmu6s2DqJte4FucBrPIIDuY5OSwvipflUyYnOOnvXA5YrEhsjuU5FZ+3b7VvFBnHGtk0mxNcN+PtBPIzK0k4TLa6pjtSj8VGwN4Vje+G//1Gb+cKAk3bbOvenTWh4+h2aarw4TSa3HwaLScGgXY80SlLzw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SJ2PR12MB8182.namprd12.prod.outlook.com (2603:10b6:a03:4fd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 04:34:01 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 04:34:00 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Alexander Sapozhnikov <alsp705@gmail.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>, Sagi Grimberg <sagi@grimberg.me>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Christoph
 Hellwig <hch@lst.de>, "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>
Subject: Re: [PATCH] drivers: nvme: target: core: deref after null
Thread-Topic: [PATCH] drivers: nvme: target: core: deref after null
Thread-Index: AQHauOC75f47YOHHZUOX1gJ4jpV7fbHAbRIA
Date: Mon, 10 Jun 2024 04:34:00 +0000
Message-ID: <99b7bf0e-8a91-492a-bb96-9f5ae7eef416@nvidia.com>
References: <20240607134340.11-1-alsp705@gmail.com>
In-Reply-To: <20240607134340.11-1-alsp705@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SJ2PR12MB8182:EE_
x-ms-office365-filtering-correlation-id: 38a160d7-a3b3-4082-51d4-08dc89068cf0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?bmRlaE9acWEwSXJrblhmQ1EwT2FkWkNrNWwvV1hJUHpzOC9VZ1hOWmtzZlNO?=
 =?utf-8?B?SEx6UzBtNVd2OEV6b28zcDB3c2VSNlB0bi9iSXNnaS8rRmE5cHRqZjhRYmpt?=
 =?utf-8?B?aklMZ040OEcrdmdZaWQrQU1LQ3NxMmxISmI4M0FtUGF2SFRKTEdyMlVvMGti?=
 =?utf-8?B?aHBQV0drblhQZHRiTVBxZG05MUhadkw5R3I2SURkL0l6SHFXNy9RZlpTTU5E?=
 =?utf-8?B?NEdyVlRJTjRzb1ZJdG1oQmh2YTVwWWViUjl5RGZHSGlBSGV2Q1cwK2RxLzRR?=
 =?utf-8?B?aTBRYnBnYjRLSmJ2VDZPeDRtbkpGVDkxVXJlM1JPYmI1emc2ZFRNWmRuVC9Q?=
 =?utf-8?B?ODJiT3ZHQUI5a1hFamprUWx2U3ZsNjQ2aGxtcm81cnhXakxuTG5nczd3SGNh?=
 =?utf-8?B?aFhSdmFOT2FvWVRjZnJQcWx5NlJMaFkxYm1tL0RwRlVWV0NxUy9RdmRNQ1RC?=
 =?utf-8?B?dDQxdEVzcjhpQVJHRjN4Q0Z3azdqMVhjaVNkNnViSldTSG9JUmo3dVp0blhx?=
 =?utf-8?B?L1crNEFHeVhzYUxnSDVkS0c0Nm56eG9rMmRsSE9FUDF3clpSZThrUFpzbkQ5?=
 =?utf-8?B?TnlhZDRyeGM0dGdkdFF6NGhjcGtiM0loa0RyNFFSRUMyYmcyTVQxelp0dmIr?=
 =?utf-8?B?dUlMZmh5Zk4yN0RrZjNScm1BbkFzL2liS29ReVJyNjcyaVFzVDhrRzZieGdK?=
 =?utf-8?B?Q2crak5ERFNRamtrcjhPa3FlQldUd0xKSzZYcWFNMnEweDIxYkMrb05seFl3?=
 =?utf-8?B?QkZibldOQmNVditQVGhiRXFOTVZGMEtDQVI5NVFzV3BoMHg5dDZwZW5XVitk?=
 =?utf-8?B?Ym9KMkpCK2p2aW9FSzhuVU1kZWlSTkxlSDBCL2VGanc1RjZQTU5DZ3hkRHF6?=
 =?utf-8?B?Y0VpWGVyRFgvTStmTGY3amNIZEVpYzAwNzlDQlo5ZmRQTmkraGYwWnpjTXE1?=
 =?utf-8?B?Q2FkSVFwNFVnMGxJNng4Zk0zMk5hMlNHMzFrK0FaRVF1UW5wYkRKQmdEMXNH?=
 =?utf-8?B?V1Y0NXJ5bUtNekpLdFBpSjdmUFRmci9iY3laK2tWK216V0NnTzhRbG9qNEVJ?=
 =?utf-8?B?bnJWZnlCR0RtNGgwcFRZaFlsWHQ0YUNJdjVHdk9YcStDYUFzMkRKZ0F1WE5u?=
 =?utf-8?B?ZGdkK2Z2dXh4NHdjMi8zQXVpZmVFeW1HY1FQUlBibk84NVBFYVg2cnYrS1Fo?=
 =?utf-8?B?Z0NFVnpySG9zdzBESXk5STBjN05LTmM0eUhxbEYvRU5TdnozTk9vcnNHdGhD?=
 =?utf-8?B?WVhvTjVMTi91UzZaaWRxYWEzS2lxRzNrQWlmZmxlbmtKZGdwOXIrR0dUeTR1?=
 =?utf-8?B?bWZQZ29jTlhzd21vaE4rdVBKMUVFRmVlMDJtVkRTSTR0ZGNndFFKN2NIRjlM?=
 =?utf-8?B?eUo4ODRrWEVoeFowdG9iT1J6d1hxUDk2WFJZS0I2bkhyb1pJSTdmVTcrclpo?=
 =?utf-8?B?RVpFSXhDdDdiVFhZdDZ2YnIwblBjL0swcE1ycGxwVlVpMEI3Y0E3bUZUZHBF?=
 =?utf-8?B?UlQvRzBNUEcwWGlmbXkvL0xmMkd4VERZckVRNktwZXV2a0w1Y01jdU5wT1g0?=
 =?utf-8?B?VjdzUXJ6bWJQN2t2ZFlqU0p6MmZHTXVyY0FaSzJiMzU2YXNSUW9XT1pzTzVk?=
 =?utf-8?B?ZnJHNXc5THpCUDluaVFOcVRGTTI3RU0vVzNCb2VaOHB3anRJclNoMGIvN1l2?=
 =?utf-8?B?bEY3SW9vUUFpZXdlbUhNZzRUejQ5NEhDL2RiU1JWc3VpSlFPa2tId3dvSTFt?=
 =?utf-8?B?WXRzN0g5am9EeUw4QWhmUjJ5bDM2d3BpaFRoaEw4ZzdkTis2NWFQTThsZnZG?=
 =?utf-8?Q?Qcq9oPvT/ObCAU/vqfYK03ne2AUw/TsPpuIkM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YTdBZFN0cnVBR0xQTzV5RGF2aGZXVXRHOGlncXlYb2JYdi85SkYwOE9RMy9h?=
 =?utf-8?B?cldOL3VPdUVucEVMZ2JJZWJjTEJLZlBTZENKZ000T2JYQUY5V1ZONmo0SXZ5?=
 =?utf-8?B?MmJsSXZwRnRZQy9YdkdyYkorSWRMSHFNak1rbGZqTCt0TGNRNzYzaUxKQzBN?=
 =?utf-8?B?WVAySUFlU25oSjUzMXd5Ui8rWG0zYjNNclBGRXJQUXpsRWtQQ1F1aVRLNTRk?=
 =?utf-8?B?U2JiaEFBTWg5TGJtUXhuR3I5cFZVNUd0TlozV29XN24rVXZ6RG5rSUVvb1F1?=
 =?utf-8?B?N2tpUnpkR1M1VWVlcERMTUd1cW8rc2F3aHVpVkl1NEVrK0VCVzF6UlFOa01q?=
 =?utf-8?B?bjZzZThYQ2x3WllDejlpSXAzS2ZCTy9BTDZzSU5rOHFDZHVIbWRQQ2diNUNz?=
 =?utf-8?B?ZHRBS0ZGaWk1alpGcDVaZ0RvNEJ5WnFJWEFIRlV3ZjVQOXR3RkViS0lVTUZp?=
 =?utf-8?B?V2l5ZXN0ZitNdWFybVZ1M29XZWZzek83bDJiRVN3N2xqNzJWVDIrb3k4RjdM?=
 =?utf-8?B?RVlJdmdpZFhWSTVKQms2WFZDZjQvQlhTeVJRZ0phTnU4Y3ppcjNua2xRbkhZ?=
 =?utf-8?B?YVY0SVpKbGFHTmgwWnNlcGlBazlxTkRVZG1YTDI0RGM2L2ZJWDhGVGFBclND?=
 =?utf-8?B?bTEyMi84aFZ5Nm01NVpiT05LVlVmZFY5QnZpc2UxT1cwajN4VDYzTnNZK2Uv?=
 =?utf-8?B?bmtiT0NHZ2tjSnZXVnNNVlFrN1JSekMzMTVBcmpvVVVOL3hKL0c0REwrK2c4?=
 =?utf-8?B?K2F6MUhXZENZNjZsTSt1N014aTFTOWtvUVZESkp2L2syNXQwZ1RweWFhbGEr?=
 =?utf-8?B?ZWlFQTcvWWxJc3NPMkV4THVOMS91bnB6MjBLZjB0QWVIdWFkYUpRNmllbnNZ?=
 =?utf-8?B?YmdzRkhLNnZKVHdhK25ybVMvdStmUUs4NTRJMkJTRTBBTW1qNzgvdUhONE41?=
 =?utf-8?B?b25ObFpiYitIbzBSdElNdmQ0am5MdnBHWjJDOVBMWTdvcEU4WFJ0N0ltTjls?=
 =?utf-8?B?NFdoZGVZc1M1OWl0em4reUVyZjR0VmdqWFdXOWhETitGdFhWckVneHU1cmV4?=
 =?utf-8?B?eStMWEh3ZnRxbXJHaWJnMTI1cVByZENYVEpRbVJ0eGVNT1ZnZVJyK2RnbHJk?=
 =?utf-8?B?ZEY0UnJqREdaOE1UdWhFU2laVGJNRzNhUStJcHljd2l1U05qZU5VVEN1YitR?=
 =?utf-8?B?YThTNWNVNTZWL3NXS2lrMGVqbmxQUWZaL1dKSW5icTM0UWRySWFoYVV0UXV1?=
 =?utf-8?B?WVIzUUpIVy9nZjN0QkJ3RHJDQVNvK1NWUVpCT0kwRUM5TFo3aXpnWmMyUEFS?=
 =?utf-8?B?a04rdEpxRnJiSTY4VWtjc2RQU29Nd0FTTktKOWNWNWNOb0NjWkhkU2ZsVW9B?=
 =?utf-8?B?UmdmMjY1ZENVUEJBN2lnTUJaSXZVWTdMWFZ2REcwcFhBdGJXeTFEcVhKVEJK?=
 =?utf-8?B?bk94UGErSGhqdWhxVFBaZk5yUXN5YlJoTnp4aHpkdzNuUld5bXViejczeVR3?=
 =?utf-8?B?QjVxcTV1VEJtckR0L1lzUTh0ZVdBeVcvZ3Z2S2x3bjlta3RDbHNYb1JaVlFC?=
 =?utf-8?B?SjF6eW5LVlo4TmxRMHNzZWJEclY4TFNTQzYvcEpZa3dRZzAxamp4VWlvRnpr?=
 =?utf-8?B?azZENlpxUHBTL0UxTkVBZURUZ3A2K1I5UGx6TEdqMmwzOTFDUE84Tjg1eWpB?=
 =?utf-8?B?bUg2eEE0Vjc5b1VDbCs4M3RVamwwVWZMbExwYXJjMUpWN3QyY0hEYXNRaHZo?=
 =?utf-8?B?a2gxRTRTM09yRFUwekxZMGR1V3lydHNzVi9oR1k4RXBLeThuZXF4YzR5Ylc4?=
 =?utf-8?B?aUJ3YWN1Uk12cUdzeDhqNDJiWTU0UTd3ZksyaWh5T1c4Qkp6V2FJd0ZadUx4?=
 =?utf-8?B?cG4vSTdSK1dKMHpXS2JqR1lsdUtBRXFzSFQ5NElvTk10aFh6cUp0c09zeG1l?=
 =?utf-8?B?TVo1Wi91NG8vcENqYmxOUUVmc0c2RExPTzkvK1cyeVU4ZUFUOExNZENTajJm?=
 =?utf-8?B?aXdwUDJpQk9UajA1V0FyaUQ4c2NDdVRJMzBrNmZxaExpK21tS2t3Wkh3eHlh?=
 =?utf-8?B?Z2YySWEzY1RLQzJtZGFsTm5DZ2xaUzZ0NTQxWG1EejYzd3dyYkV2T1o1R0V2?=
 =?utf-8?B?cVVnWHJoNHFHWVlXTWpLL09LVnZvZ1dtRys0TFJiNlBHZDBiUUpEbjBrdURm?=
 =?utf-8?Q?DKJotTO/bCATvSVYd3EUuBYynkLlA7zmkuD5Rvm3qapd?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <02E704C698FFA245992FEEEA71284D24@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38a160d7-a3b3-4082-51d4-08dc89068cf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2024 04:34:00.6857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Xhvno/ygEUWDk48z6krtRAybfdVpPKtKfMgvNZE+ReWnifas+aXF5ZHRRGTGTlfFnV/srBoY/4KffP05jhHtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8182
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240609_213422_068867_11F292FB 
X-CRM114-Status: GOOD (  20.22  )
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

T24gNi83LzI0IDA2OjQzLCBBbGV4YW5kZXIgU2Fwb3pobmlrb3Ygd3JvdGU6DQo+IEZyb206IEFs
ZXhhbmRyIFNhcG96aG5pa292IDxhbHNwNzA1QGdtYWlsLmNvbT4NCj4NCj4gQWZ0ZXIgaGF2aW5n
IGJlZW4gY29tcGFyZWQgdG8gYSBOVUxMIHZhbHVlIGF0IGNvcmUuYzo4MTMsDQo+IHBvaW50ZXIg
JygqKnNxLT5jdHJsKS5zcXMnIGlzIGRlcmVmZXJlbmNlZCBhdCBjb3JlLmM6ODM4Lg0KDQpyZWFs
bHkgZGlkbid0IHVuZGVyc3RhbmQgdGhlIE5VTEwgY2hlY2sgbWVudGlvbmVkIGFib3ZlIDotDQoN
CiDCoDgxMsKgwqDCoMKgwqDCoMKgwqDCoCAqLw0KIMKgODEzwqDCoMKgwqDCoMKgwqDCoCBpZiAo
Y3RybCAmJiBjdHJsLT5zcXMgJiYgY3RybC0+c3FzWzBdID09IHNxKQ0KIMKgODE0wqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbnZtZXRfYXN5bmNfZXZlbnRzX2ZhaWxhbGwoY3RybCk7
DQoNCmZyb20gd2hhdCBJIGtub3cgaXQgY2hlY2tzIHRoZSBub24gTlVMTCBjdHJsLT5zcXMgYW5k
IHRoZW4NCnZhbGlkYXRlcyB0aGUgc3EgaXMgYWRtaW4gcXVldWUgYmVmb3JlIGNhbGxpbmcgZmFp
bGluZyB0aGUgYXN5bmMNCmV2ZW50cyAuLi4NCg0KPiBGb3VuZCBieSBMaW51eCBWZXJpZmljYXRp
b24gQ2VudGVyIChsaW51eHRlc3Rpbmcub3JnKSB3aXRoIFNWQUNFLg0KPg0KPiBTaWduZWQtb2Zm
LWJ5OiBBbGV4YW5kciBTYXBvemhuaWtvdiA8YWxzcDcwNUBnbWFpbC5jb20+DQo+IC0tLQ0KPiAg
IGRyaXZlcnMvbnZtZS90YXJnZXQvY29yZS5jIHwgMiArLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9u
dm1lL3RhcmdldC9jb3JlLmMgYi9kcml2ZXJzL252bWUvdGFyZ2V0L2NvcmUuYw0KPiBpbmRleCAw
NmYwYzU4N2YzNDMuLjVhNjdkMmJjMGM1NSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9udm1lL3Rh
cmdldC9jb3JlLmMNCj4gKysrIGIvZHJpdmVycy9udm1lL3RhcmdldC9jb3JlLmMNCj4gQEAgLTgy
Nyw3ICs4MjcsNyBAQCB2b2lkIG52bWV0X3NxX2Rlc3Ryb3koc3RydWN0IG52bWV0X3NxICpzcSkN
Cj4gICAJICovDQo+ICAgCWN0cmwgPSBzcS0+Y3RybDsNCj4gICANCj4gLQlpZiAoY3RybCkgew0K
PiArCWlmIChjdHJsICYmIGN0cmwtPnNxcykgew0KPiAgIAkJLyoNCj4gICAJCSAqIFRoZSB0ZWFy
ZG93biBmbG93IG1heSB0YWtlIHNvbWUgdGltZSwgYW5kIHRoZSBob3N0IG1heSBub3QNCj4gICAJ
CSAqIHNlbmQgdXMga2VlcC1hbGl2ZSBkdXJpbmcgdGhpcyBwZXJpb2QsIGhlbmNlIHJlc2V0IHRo
ZQ0KDQpkbyB3ZSBuZWVkIG1vcmUgZmluZSBncmFpbmVkIGNoZWNrIHdoZXJlIGN0cmwtPnNxcyBp
cyBhY3R1YWxseQ0KYWNjZXNzZWQgOi0NCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS90YXJn
ZXQvY29yZS5jIGIvZHJpdmVycy9udm1lL3RhcmdldC9jb3JlLmMNCmluZGV4IDA2ZjBjNTg3ZjM0
My4uYTcwY2FkNWE2MjYyIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9udm1lL3RhcmdldC9jb3JlLmMN
CisrKyBiL2RyaXZlcnMvbnZtZS90YXJnZXQvY29yZS5jDQpAQCAtODM1LDcgKzgzNSw4IEBAIHZv
aWQgbnZtZXRfc3FfZGVzdHJveShzdHJ1Y3QgbnZtZXRfc3EgKnNxKQ0KIMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgICogY29udHJvbGxlciB0ZWFyZG93biBhcyBhIHJlc3VsdCBvZiBh
IGtlZXAtYWxpdmUgDQpleHBpcmF0aW9uLg0KIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgICovDQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGN0cmwtPnJlc2V0X3Ria2Fz
ID0gdHJ1ZTsNCi3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNxLT5jdHJsLT5zcXNbc3Et
PnFpZF0gPSBOVUxMOw0KK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHNxLT5jdHJs
LT5zcXMpDQorwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3Et
PmN0cmwtPnNxc1tzcS0+cWlkXSA9IE5VTEw7DQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIG52bWV0X2N0cmxfcHV0KGN0cmwpOw0KIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBzcS0+Y3RybCA9IE5VTEw7IC8qIGFsbG93cyByZXVzaW5nIHRoZSBxdWV1ZSBsYXRlciAqLw0K
IMKgwqDCoMKgwqDCoMKgIH0NCg0KLWNrDQoNCg0K

