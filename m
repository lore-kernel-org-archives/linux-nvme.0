Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F833C531DC
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Aug 2024 06:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1eiQs7+d5gxXqMuLe6F7WG91aRsrKkpVO8HugqymCwE=; b=ad5IZTL0L1osqd0r7d3oIYYX+9
	QOjaWm6uVnLPSW/vGgT1hHyFkI8R42bScHc1/h02Xtu7mlp6uQg1PxB93wTbNQ5VVLdkkIBQjQ+i4
	R1Tg+tq0CEZbKjG5ZrCZ+lI+YJDl0uiWzcE8ypCn787RFLeV3hr+YEOAZ1qxupmfMpmMcDbU4Z6O9
	EjbKGwjiJXboU8ig/OoenJrhEKI0pCLKfvT9YAVWgc+zkARqrFkOFbc3Eoe0R31nAYsEt+LqxFP9j
	GrCD7xa3+fZtcFcOc1tb77VB/b2kZ0Qhjr5/Y9pN4vUCcLTDGg8ryOdw8wU2jX2+URG0RUKV+PdxT
	qIPTJ0Bg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shNwx-0000000FU3E-0B44;
	Fri, 23 Aug 2024 06:39:07 +0000
Received: from mail-bn7nam10on20616.outbound.protection.outlook.com ([2a01:111:f403:2009::616] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shNwu-0000000FU2N-1zjg
	for linux-nvme@lists.infradead.org;
	Fri, 23 Aug 2024 06:39:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ekwTfu7ViaQSP/ItWoluVznpDEJ69IEL6Ebjn/Cul7q6nhGp+Fbkgp3mCm5Ib9qQmEb+Ya6+b2FgRh15xWvYBDO6M+ApEggnJQbCaol5iShbIVYWW34yJhq/smi1GLGtpS3qP3gd/bgBaIQ/VOXBFFX+v8tS8zNoOyLM32mCXMskPFcBWmN4xbqcnYJ24gKroEaF90vdI508qRZ44rSXpB5J0295Bi7apT+LmzykI+ibidmozKgSKT+PZ834l2LOCoQYY93ZGbOhRaqv7br+Dnbp3MrUTSl2dCKlVa0fjF75/rEu8Vi3SqT7UoT43Q0ChRFQc9rE2tF53OIB/CSjNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1eiQs7+d5gxXqMuLe6F7WG91aRsrKkpVO8HugqymCwE=;
 b=Zo9i1M6TL+5pnfhR7Gu7rjdOFwQWBEhAImy4ZVY18XaQVDwV/jy5ovNjoxAZqowpX734cHDTjXqms8uVErehztHCmoHR8M7kpoXvwsn5kGPNAHxKtMV6IQgKrmQ08BPm6MtV/s/InuwcLMrISwC1IoFKs6gwwuToC7yDxCtVk7jUnp7ciC4Bp1GV0l1S2ofQLW0JJatIaotlmy59EpRiCIVKL/+o0WTawiDFGT00WfE6Cg+TMc35lSnqoY0aRV+0oKB1uUv2c0FqyFBnV7bQ5T3JMvXNldKVUtizsWRTn5BN0painQhEFtsSQOunhAgETjByOUVwzK0SfTFl190V4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1eiQs7+d5gxXqMuLe6F7WG91aRsrKkpVO8HugqymCwE=;
 b=OFEYLBdu0ePt1xx+GULpfhyS4WupAmEtFjZYU8daLY0mb4JtiLvI7GAFOy8xhOVf7nAKSsioCUmjWEXjMVlt3p014YTg3Bi/CqX0bcOK8RxBYic8QlLo+O84YC3PfF461C+cwu3jH9LnztPmaJ638yJTsRNrRji9ip5IhnSXurKNQviPBRDrkrww2rXZUoYFYgHj63wNglFWpnfjowst1wycfrL42y+Z47ZvXY8SpvYUHpCq1EM9M99cfzqjOdeS/VxEjSr5qzBveLn89w6xFOUWgr9iZNBrsdUBiUq4jPJGP/s4QcP6p6Q6SCBMj8v4H9nBomPHDBkxu/LcXloRSg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CH0PR12MB8580.namprd12.prod.outlook.com (2603:10b6:610:192::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Fri, 23 Aug
 2024 06:38:59 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%3]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 06:38:59 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@meta.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: use better description for async reset reason
Thread-Topic: [PATCH] nvme: use better description for async reset reason
Thread-Index: AQHa9KucbzUdagTiRES9NbyWVecPe7I0ZO2A
Date: Fri, 23 Aug 2024 06:38:59 +0000
Message-ID: <c284ac0a-c87e-439c-89da-835a58c8f513@nvidia.com>
References: <20240822152259.3896264-1-kbusch@meta.com>
In-Reply-To: <20240822152259.3896264-1-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CH0PR12MB8580:EE_
x-ms-office365-filtering-correlation-id: 0d42d7cf-030e-41bd-dd91-08dcc33e451f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Q094NmkzcGxWcGQ3bmNYZ3pUc0xuaDhwUmFjcVhPNEFXZTFhWjZZdFkrS1Rw?=
 =?utf-8?B?K254ZUVEQjljYWJ3NWNwT3pWV3JLcXBiK1p3TC9MZDRoL3NTS3diKzI1K1Qr?=
 =?utf-8?B?Z3ZuaHpsaHp2dEhhT0tBeTlKVU9pQ3dzRDg4dW1DN1pVVlRxQ3VqSWpzaVIv?=
 =?utf-8?B?ODZKY0E0eEorU3RUY2oySk9LMmc2SDNqZU9FY1o5S3VNaWMwQ0xURURpZDhE?=
 =?utf-8?B?c09EcnJWUzBvbHFScHpKbzhwU1VVVSs0aVhvdkp2Y1J6Q3Y4ZGthOFM0UnFl?=
 =?utf-8?B?REZKOVlVVkdkQ0FpaHlFM3NLQUE0dzQ0SjhXMmF3bXJnNVl6TW9BdExQdEFO?=
 =?utf-8?B?OEhRRWExeURrQUlnUG5GSnhXM1NUeUJoZmg2TkVvSnhrNkMwckhhZkdWL05G?=
 =?utf-8?B?K3luR0txRXI1NUFkREtiS3MzOEh6b2hxNXJITUNXakxDMXY3UkF6UG0xZlJ4?=
 =?utf-8?B?MHAwQkZFbWFHTkxRNHJDOHg3cXlaWEdUeVFBMzlnQ0ZEMkNEZkZwVFl3U3hs?=
 =?utf-8?B?WHlFaEFJY0I5TmR1TWtPOHY4Wkx3eVBOb2JNWlRmTHFLeTI2UmxMdTBQbDhN?=
 =?utf-8?B?NHhYOTI4WWI1WVlHUjVISFZURFdjMDcwUEpORzlVRjIyQXhzdGF3bVZPOFh0?=
 =?utf-8?B?aTQ5cGlwcCtHdkRrV2lTdFBHcnoxbzBreE5IZWEzb1ZjbDBSS1dyWU43eCt5?=
 =?utf-8?B?YjZoSFVUSGNEcmdGa24yQlZiekVsZjlJZDg1UnU1UGc4RlJMYzg5M2U1a1Qy?=
 =?utf-8?B?eE43Lzhwb210bGhzRUZ5a3VFYWVyZ0Q0bGhpYjBOaXkyYkE0dzhhVVhyVG43?=
 =?utf-8?B?cGhSN2hoMlBoUmpqRXZYSGtVZlNsR2x5VjNRdGI4ejQyRHUxVmJERlE5U0xX?=
 =?utf-8?B?UWh6V3JSOTJtakM2VmJMV2g4SWRCcGhhUjMycUlzdFV5RTdVUWp1V1ZPaER2?=
 =?utf-8?B?Zzl6MTRwR1JRRjF5MU4xVjJtbVhhYkRrZDJUdTVweUlDTTdJeVNJR295c240?=
 =?utf-8?B?ZXZFQmR5dlMzeEk0MkYvcUpUcWhCVFBGblJvVFc0bk9qRnFFN2NJRWNISTRV?=
 =?utf-8?B?STJpL013SHVTSnlpU1cwazd0QmRzZ0tXY09JalA2ekpWOUtaNUc1TTRNdld6?=
 =?utf-8?B?eVlKakV5WU43QjRZdjBETTdTc3VJWE90UGNkelFLVFFIbGFwUWRMZEhTUG9M?=
 =?utf-8?B?Vk1uY29HalZXYzI0Y0NLbzFabVc0b0xNVUptSHpZY3dBaitQREtiaFZhZC9O?=
 =?utf-8?B?Zm9MOW0zT3I0TDFIMHVrbVUyeGc5NGlYd2xidWZBMzV6M01DdGg5UjFQdm9C?=
 =?utf-8?B?Nnc1ZjkwdmlNbk5YejhZQ1Z5TWhDbytSc3A3ZjBMbXB3S0VLTFVSbThyTUFG?=
 =?utf-8?B?c3NBT2kxSXRJT1B3d1VKSUhkblVVVFFsY3grQ1BuMFFLbFlCQmNrdzNpdjBx?=
 =?utf-8?B?UGhERmtNTHl3UEJQVTZiNktVZ1JOc1Z4NnMwL1NZOUdOekRkeCtYMVRYTUtK?=
 =?utf-8?B?ZzNER1VvQWRZN2EwWi8vUmM0aG5sd1U4WXRTdUFiTW5IM2tVdFR5am5FY1FC?=
 =?utf-8?B?aENUNDFUZ0lOMkc5aEhCcjY4bTZqTnBvc1NlTFhHUU1raGVhWVNneWR3eUhX?=
 =?utf-8?B?SGhyRWVwOTV4SEp0ZFZpbXUycEMrR2VWTkVVVmJXdHk5aG04MkFZTjl5Y3Bt?=
 =?utf-8?B?YUtBdStHRmQvMmk5SU5wa1JqeEtZVTJIN2lnZjBuTS9ycTFhZFJ1KzRWczM4?=
 =?utf-8?B?aGVMZVcvZWlWOE95MkJIdi9zVVV1STAvQk14alR4Z3pDdUxidGNwK0N4ajBh?=
 =?utf-8?B?R0JLWSs3SE1iWUJoTXdpK2dUYlNDWUhQbVJkTkxuRmhhNFNSUVJDRFB4Q1o4?=
 =?utf-8?B?UHI3UkRERHZDTEtJTndweDJ3b2RhaEZmbmhKWm9wd2M0MUE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Wk0veWY0elFiS2ZyNWJsY1JLVStFS3Z4K0NTRW15SFJOWEtwbVljcytuS0dU?=
 =?utf-8?B?djNnYkxsbGR5dUV0dWpHUTd2elZXT0FjNVN5WDE3dGh1T2tVb2xEUnErMUU3?=
 =?utf-8?B?MHo0YzRZbEpVRkxDc0RJVDRoZFBwdjR1dGc1cGNOWXM5TXIvVU9zcjBCeEs4?=
 =?utf-8?B?N2FJSEZHUzRhWlF5T2k2WVpCMW00Z3NZUUFGT05XM1ZVMHhISUdLdi91L0tt?=
 =?utf-8?B?REsyY3FIeStBZU55b3hQZEZSb1pKK2RyRzVaRVoxRXI5MHRXTFlhVWVXZ0pM?=
 =?utf-8?B?K2M2RER3RU9xTzhzcERIR25XZVZZYytMakpHS3RFN2k3YkVoTHdPSjJuSlNz?=
 =?utf-8?B?MFJkZHVvdnFzbkNKMFVtTGU5elBSUFN4K3Q5bktBUHpkOFNiaFhMRitrT3M5?=
 =?utf-8?B?djRBVWYzZ2Q3TS9meS9MV2JWc3B1Mjk1ZjFjdUxIV1BIWEtick1QQWJIbUVW?=
 =?utf-8?B?MTRmeHlGeGRleUdqOVpacm9BTE1ZTkhFYStFcXhUSWFmRjNDbE41T25IYWNt?=
 =?utf-8?B?ajk5TUZ1TWNvSVdVYzlpUVdTeW4xQ3FCTnkrQk02MHBUVnkwaVV4SWRRRHpT?=
 =?utf-8?B?a2VVNTF0UTFicWFnQVl5bnFCOUlqNmx2b25idHQxOEg5QzN1eTBqdWlJTHRB?=
 =?utf-8?B?YWF2Z2Q3L0FHcCt0ZjdUampxVWJmS1l2Ny9ybytYaHJlcE9WTFkxME80WkJC?=
 =?utf-8?B?RFNYaDZrdlFvT2dXTWlIc3pxZzhjTzRVRXdBYkFuaWlpcGY3d1ZIRDhKODRU?=
 =?utf-8?B?UUFVYkFKQlRHOGU5ckJHSVlTOG9yS3VzNVpYb25tZlpoU0ZKK1RJeHJrejZk?=
 =?utf-8?B?VFlZU3g3ZHpFV2lMdGJvTjd5QnNDbDNaRllpY05iM092dEtoaVpxM0hzeXh3?=
 =?utf-8?B?VTc4Q1hBODFDT3VoSnNYajZjWXdmc1FYRTRveXVCVEdwdkJlTEhvNU9HVjR5?=
 =?utf-8?B?VWJEMjI3b2hnTzRoU3l0cXB2N3hIZUxhQ1EyQXNLQkRQYmxVRWJHL3VUZ25P?=
 =?utf-8?B?Wlo0RGVCYzhNWkhES0Z6K3ROVDk3OTY3RWc2NWVmYVhtT0JLbkhLZ2F3Ungv?=
 =?utf-8?B?UHQ1ZmtZSjUzQW9iS3NHK0FrZFNLK2Eya0dSeVVSSFBpdEFhZlNaNC9ObnN5?=
 =?utf-8?B?bWFJbkVHWEp4MlVnRXNGeEliaXMzR2JOU3NIM3BjeVczUWNiaFVnRzUxVDNy?=
 =?utf-8?B?aFM0cWhPMERBeHZUOURvZUlYVVBjcTQ3YmtQMXJiTUowNC95VHM1YTdQY3RT?=
 =?utf-8?B?N1g5VDlVdUVoU1pYK0VQRmprcUNKRVlhU2ZWcVJINkMwV0dFeDNwY2l0TFRC?=
 =?utf-8?B?aGcvN1lYaUtvZDN4Y1JrL0ppd1BvNW5KWVI1aXR4SkNQSll1ZDBSNUgrV1Jz?=
 =?utf-8?B?dUp1dzlaUlNOT1o0QnIxeGxlNVVEdVVoYWplZjUvdnZKNXdCblAwaE44QWdZ?=
 =?utf-8?B?SjRKQjRZZ2xDRkhNd3lmSDVDMTN4VTZTUkdnK1F1ZjdQNjlnc3Q3T3gxY0N2?=
 =?utf-8?B?cE9WMkZKWTl2MldQUmhCVTlvZkE2T3lFYVZLVUxyOXlqYmhCL1ViNk5yOStQ?=
 =?utf-8?B?ZEJCc1lPTjZSV2hvdW5raXpUTjRCV0U1QWRERDlNekxJcVhiSUhjbFd6OFpX?=
 =?utf-8?B?dmlUMTZYcndvT1pXVytzNlY1TzJGbkE2R2o3ZUNlYnFRYmFBdVZDYmY4WnFh?=
 =?utf-8?B?WkZ6T0dEZ2NKMTNRWis4SUpTNThsQWlPcFlVL3RUenFKNEZ0VG1hN3ptWlZ4?=
 =?utf-8?B?OEV1TWx3QjFrMkN3Sm5ncXdDRFZLRExtcXlNMzJOOCtKNmUwbXBsejRMd2to?=
 =?utf-8?B?SXdFMXJReStTQ0FRRXhaRHRIMTc5ZDFhUXBvTTlGYnhsVzdqTzFoM21kQ0Fu?=
 =?utf-8?B?Y2xuZXMzbUZpNmFHelFTVExhMUV3d3ROQ0VlcytWemFmMmF1UnBySkFiRCsv?=
 =?utf-8?B?VUtPVUpHbGJqcmgvWm1DR0pJUHp5V2o3QXVQL2ZSWjJmV0lpQW1xdSsyUlVw?=
 =?utf-8?B?WEN4cEEzQVFveVNlQlViSXNkV0VrK0tqTVQweHdaTVNjTktsSHNGYWVNdVZR?=
 =?utf-8?B?clJoQ1ZPMGlGMGFsVnVkdFgzTEV0R0RQN2N2Zm9EVzYvNXYyZVI0aU0rMGpH?=
 =?utf-8?B?UXhyQTFLemErVk5MeU1MOHpNemhJUjdJcSt1dis2Qld2ckNJM3E4d1hRaUox?=
 =?utf-8?Q?JHykQVOXn0OhNI4gv3KlceG9R4pX38jpCkqFb72hf4A9?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F9ABC91F9230A4CA0439C7CA5AC56B6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d42d7cf-030e-41bd-dd91-08dcc33e451f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2024 06:38:59.4436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aoDnn1hLsUkYtMygltTSMCdSDWWyAnfZvEahpzulb2e/fPJQccR7R8jnqTxFNRF6rymIWNd6Bs4fhwBifiXHRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8580
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240822_233904_552801_66A1F69C 
X-CRM114-Status: UNSURE (   8.99  )
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

T24gOC8yMi8yNCAwODoyMiwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IEZyb206IEtlaXRoIEJ1c2No
PGtidXNjaEBrZXJuZWwub3JnPg0KPg0KPiBUaGUgTlZNZSBBRVIgbm90aWZpY2F0aW9uIG9mIGEg
cGVyc2lzdGVudCBpbnRlcm5hbCBlcnJvciB0cmlnZ2VycyBhDQo+IHJlc2V0LiBUaGUgZXhpc3Rp
bmcgd2FybmluZyBtZXNzYWdlIGp1c3Qgc2F5cyAiZHVlIHRvIEFFUiIsIHdoaWNoIGNhbiBiZQ0K
PiBjb25mdXNlZCB3aXRoIHRoZSB1bmxyZWF0ZWQgUENJZSBBRVIgY29uZGl0aW9uLiBKdXN0IHNh
eSB3aGF0IHRoZSBldmVudA0KPiB3YXMgaW5zdGVhZCBvZiB0aGUgZ2VuZXJpYyBvdmVybG9hZGVk
IGFjcm9ueW0uDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEtlaXRoIEJ1c2NoPGtidXNjaEBrZXJuZWwu
b3JnPg0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxr
Y2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0KDQo=

