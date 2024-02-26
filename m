Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4570C48BF6
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Feb 2024 06:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lKtYnx2D4uVj+j2VMqvFn0Cd8uZjeUxklB6TEzLdOdQ=; b=q0nE5wmpxM3i0/RoPMz2juAd/+
	0IYl/KHdruqMeoNu6z5dDgDWoc7FxFtQFLQRTsfAQJKUMY7mQI/lQ+iu+ycZzyTKhzHrTNiJy5hes
	sqc833nEcXWiFT06OQKaoUnh0x5s4BhWrB+Otj8xqcjM0CElQPloRaLHb1qUC3NmX5pgBTvgWzg9j
	PwHYgFs3+r5jBYZpOFxoAXiKaRjM83zHVegwh9an3+vANIUFUYBhG1PvmgX/TI20s3BCsPTvDSUyY
	iIXvJqAviM8IIwnJaYGFLGzGP515sz7CUcBGbNcFjBJjIFk1oyFMC5bKV6DCgTUn+VKA7rKcxCbgH
	eZf2KP6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reUhr-0000000GgWN-3UAp;
	Mon, 26 Feb 2024 06:43:19 +0000
Received: from mail-bn7nam10on20600.outbound.protection.outlook.com ([2a01:111:f403:2009::600] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reUho-0000000GgVX-2hcv
	for linux-nvme@lists.infradead.org;
	Mon, 26 Feb 2024 06:43:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/LDl2Nr3m9eUJQZDqZjGJkIJveujtTil9lws3/iJiGG1sjuTKxvIXR0Xqae0OWCirRfA2aabnLwbOLpdfV2bOa5rejGW1PuMRZroL9N9yX1qcQexpJuEM41wqgLiKLQYhIjdqa+G+yBBLWf3+E7pyktmm1BzEVM/yjLv3hVkeYU2C8liLLxrpmUKv/w+PcNY+Em12q5RqucbAgnZvh3Kxmf9h5ng5yzCUaHVdMsyuklkWFUVqL0REhr4De//+jO12ElUrr1PNM2MZ5P+YWylUgiY1sXXtfHpfirPmIoDgQUwudrhplF5QZXAfulbtHkcHXogV5M+bk+9/TJsGM3dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lKtYnx2D4uVj+j2VMqvFn0Cd8uZjeUxklB6TEzLdOdQ=;
 b=Sqlf4A64tCI/r4SZX2MAZtPNt8iusBxHimMIgglZ/3IyKIhClU+oD/38/bI9Dh3x9vIlN8wFdY7XL2q3k/tntu2Eeg/l3nmBu6VxW8bUyftAWF0PqdEHD+nTjuCwjTtYPBwN0aoTp32U+20jQhd+3CtxMasIFwKXFk5FmMJ+iPMeCwjvG4GLsqy9eVtDJvjeh+NvUVGIpynFUw5ho5yVDHEhzAbkVqi5z2IUyr3ZVWGHVsiH8CrWbdA5VJgJ/07cFvCFj/v/0VoRRo+WsrbtKrbelz2thg0vPLCvGhXUPtD3UmV8bCZJkeTrgqyF72ZIKWlYwWI6gYtvYQ09Wds+Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lKtYnx2D4uVj+j2VMqvFn0Cd8uZjeUxklB6TEzLdOdQ=;
 b=Goz1u/xxzWw9dxHGOUg6yZvu+j8+D8ZX01g2jbpyX/GkTEWwqGEqzBgrqwpMEHyL0kgKMDuAGvvl5Dc7c99N9EEBF/mKtkjJpSQE+mvk/ZAThD96SF2wuOS7Wh9osUe3LLR7mrDuHssUYn8CWjWieMOSntl4p+Lj1p79wy1vJiGQdvufCtpNWPutg9pnTeQxmPxElRit+wZqq5OrDp89CuE5WnwKWtpJ3nl24dKEAAEHPGCTOxec+x1mgXLyZTSDTT4CDR6OPS9XsFKZMiUGpt+wZ6fW7iiSbxerTbIXK6YK/Y0iiWR4e2kgdPAaMczSUGxyE3ECxudNwFFg1AyVQg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by IA0PR12MB7507.namprd12.prod.outlook.com (2603:10b6:208:441::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.33; Mon, 26 Feb
 2024 06:43:08 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7316.034; Mon, 26 Feb 2024
 06:43:08 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Guixin Liu <kanie@linux.alibaba.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>, "sagi@grimberg.me"
	<sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH v7 0/1] Implement the NVMe reservation feature
Thread-Topic: [PATCH v7 0/1] Implement the NVMe reservation feature
Thread-Index: AQHaVLbf3S2JbeZAh0WgbRnHFKhmzbEPdmOAgAzbsICAAAKbgA==
Date: Mon, 26 Feb 2024 06:43:08 +0000
Message-ID: <8cc26612-bd2d-4e2f-a3de-06ca6d7e477a@nvidia.com>
References: <20240201023207.112007-1-kanie@linux.alibaba.com>
 <af0c5068-fec7-453a-a1e2-b5c0d7e8e308@linux.alibaba.com>
 <b7f4e68f-bf9b-4d77-acd9-c9bb7570a614@linux.alibaba.com>
In-Reply-To: <b7f4e68f-bf9b-4d77-acd9-c9bb7570a614@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|IA0PR12MB7507:EE_
x-ms-office365-filtering-correlation-id: ec6f27b2-e92c-4f52-4d5d-08dc36963155
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ffK12AbZcKRjYy/f7Mhi1dDxaBRXQc6HaNCmJATlynrYt6lqHmdKhREMNX2GWRLW6624HbBOZgQm15ZF677s1dcM+2IJ3ljH1R3Azz+akC9mQcsgOOZtOzLguXYmiGWpVcikUzf/1rDl2dXP97nk3ZPM1waqQp2QLzYpz+Kf6CwNGjHlx4N/VW6kg0gy6CVzV6q+RYPVThfUeT593Zv0PJyPmj7lIz0iXla1OJn+d0IuxApbLXcJCNnvDG1mkHMMpqBNoRjwdSzz6wADYB7zvENZT8Efvxdyv1DaGP80Dfg/HYz/m4II6JY5LmAjNOxosCwwn9TC2Nb1+wXXzd9LanHTITyaeSW1Nw2XmFBwZh3Kzizk/TzIVXBci/j5AsSbP/2mABfLosKXBpqrGA/H2z9vY5o9u+gwLUh8ZTfMUy8XCZRqI3tk1oLWayhrjCmy9qulOXzIi9hBNPPjWQuCu8cqvIGdbkkrczdC4ZAeaYUYg8yvaKvaZg/JyEdHUr0J49XB/5INMuiFEkM+XOBMHWp/a87b7JyYxtzJBeHIyp/Th1HX3IMrjKmvRoAM8ts71xuGbMBaerWsvn9q9D6wmZsLI+W394YFUGoQfIFLOPFQfCuyZernP2fVrEs5tVNdZ7HfovX8EXQYbeGhhedaI4CumtpevOQStXmWnojTCVpVnWBKPr47r2sX34BP4acigCrl6Wi41wWehXAN+wcVn33vnklOfIfRJcivX9NmQG4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGp2blBMUjNlRlV4akhDczhSdFBGWVVyMnc3eGxtOFRULzNIb2xqSTM2YmRZ?=
 =?utf-8?B?ZkNsRDJNNndTb2JhTGtYTldhbUVmT1c3aGtSK2lreldibHNPSjlMNmtqcVlh?=
 =?utf-8?B?Z0NnUUl5emZGZkI5YlZ5M2RPbzgwVkpWa0pYRlpxVHBYaHdKZnRvbnpmZE9B?=
 =?utf-8?B?Yy9mMFAzS2dNb0VGcFdNUjZvblNhdFo4U253WUlrdTBxMzl4bXZzeS96MmNv?=
 =?utf-8?B?L29QMXBtSXFCSllvdFJxc2M3ZGZmVTJ2UWdZTk1hZ015TGxoWFA4VXZVSUp2?=
 =?utf-8?B?dENOMElQTlRsZjJpNTQxV1VKak51Q3B0amZDVU5mdVdKS1U3TlhYRFRJZjB4?=
 =?utf-8?B?NzVzcjREQ20yNnBTY09FU1FXbi9FQm5KY1ZpQjFmVWg1RXNab2k2ak55MUR0?=
 =?utf-8?B?MmJ2R1N6U1pmTnFUdSt1akRqcUVUTEhxeDBoR1hkQys3bUY0YzhjL1FUbGhV?=
 =?utf-8?B?dE5oUC9Yd0JaNHQzbWs3RHFMRlhTb3JsMG5BVi9yd0hoNFcxQ2tJdTlrTVZt?=
 =?utf-8?B?Z0QzcWlwbUVWVTZ3SDJFWmtMblRmVWNYYjVMTUxGbStBWVdHNEZFaUZ2dWdn?=
 =?utf-8?B?N2lYU0ZUNXE5aHovbUFUQkhuaFFLVlQ1VnNJSXNHb3hsQUhKenhpNFRtajE1?=
 =?utf-8?B?RXFoK0dxcjRqOWJvYzZIU3pkYnlnYjAzNThIeXBOOUIyR0ZNdFFxOGlpdkNk?=
 =?utf-8?B?aGE4TDVLWjV3WDlwaWI2dWZHV2F6N005TEV5ZzdnMSt2UmdEeG0yNm8yaERH?=
 =?utf-8?B?dWhmTjRnSi9IeUpJRHR6RHJaWjdFTmhvcCt2TlM2RzUrRUVqUmJiblIxcXFG?=
 =?utf-8?B?Y1dzbDJFR3hpSmpha1ltWDI1VTNTNS9INUFUbDNmU1dzMGtCVkppWWhjK1Vy?=
 =?utf-8?B?aFcxQnhuQVBBNFlJa3A3Z1huZUhlNVNJaHcrSnZyb2l5RkVYWVZZY0lBQSth?=
 =?utf-8?B?NjlUVHljMkREcXAzV0FBcHdyTEZ6WC9OaWNkTG83UGtoK2lxcnU0M1c5eDlH?=
 =?utf-8?B?aGYwdXNJTUs3YVpwTGxrb2o2eWdpMDJDdEd3RjRsUGdET0Q2ekMyYXFpOTBF?=
 =?utf-8?B?bjRtaWd1MU9RbGlJZzBnZzIzTmV3dFVTZEpDbU9UREp1OUZOSHA2TlJTY3Bp?=
 =?utf-8?B?NE5TMU51TDBUSVpwN1RiZTZJdjgvaHJtMU5yT2h0UE0xdHF3dDZ2czhZVWVx?=
 =?utf-8?B?MHBiS3dsaVVoVlBpR0xTVFBwTUd4Q3hNVjQzcHFnSjFFS2tRWWZ1UVJTOVdB?=
 =?utf-8?B?ZzZLMndkWFkxNkZiL05wbHJXSmMzMUFDK3pSOVoxNWxxZDNPMWQwK1U4TG5n?=
 =?utf-8?B?K0ZFV2FxLzR5R0I4N1plcm5OUnU2SmpXaTlkdU5CVUo1a0tpU21HcXI1N2ZS?=
 =?utf-8?B?d3cxUDgxQXpuZ09ScnhhM0ZGeDVxbFpvOU1pUE80ODVINUlDWi9RQy9ocXlO?=
 =?utf-8?B?NjVYOWtOMDJqcFh5Yy9qSjk0cjhSdzhrTFg0WXFwR0NycTh2V1lPb1F6ckpi?=
 =?utf-8?B?NkR4bDR0dlh1U0xOZGtnNEkvcThyeHIxeGVaRmN4dXhKUHFxM3h1c3MzTVNB?=
 =?utf-8?B?alVRMnA5SytUMDF5dkRBYU5Udk1aNm91bEYxa0p5clV2WjBZTkNWUEczK1VC?=
 =?utf-8?B?SjQySFBOM0FZSjBDRGJiZ0d6QUNuSStqN3hJVXZ2dVRXaU9JODhVV3hUTE9F?=
 =?utf-8?B?WU5NdkRoUTArVVRsODZURVRVOW1NUnBTZXFrQm5kSWNuZDdycXYxeFNNNGlH?=
 =?utf-8?B?RjRFYnI2WHhzcm01U2VreHNHY1pnVXgrbGRBaXJvNU9IRWFENHhTczE5d052?=
 =?utf-8?B?NjFpZC9wdlNUN1NhS21XQWxEZzZrRkk0aDY4Ym9aZzk3aXE1djRkYUF1bVlm?=
 =?utf-8?B?aDZKc0FBMjJFeFhGd3dDU09WbU5FM0Y2QThuTHZ5a1NtRmVTNWJPQW5oV1hp?=
 =?utf-8?B?eGVacUFkZkg4dVUxNUtMdTlLUVBhQTg3Zm9wQmtmTnJZcnZCRUZlQWNCVm1X?=
 =?utf-8?B?OTVabm5tb2djb1dSMm5BaWVxZHlDdE1hTGo4RkM1TzZGVDhHSU1PQjZIR3lq?=
 =?utf-8?B?emE4ekh1Sml4eFlpVVZEa3Q5RElkZWk2Y2RkdGxhMmtsUlFpQjVBSHBWR1Zr?=
 =?utf-8?Q?P+3hz+JgudlnyPKGiFuvZo96E?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F7AC4612B2F67E41A6E80C0E2B7B8172@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec6f27b2-e92c-4f52-4d5d-08dc36963155
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2024 06:43:08.0201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y5AnDspoWgHvdRt4prd9WH2SP8gC1bRUsoC1BSgkBsUnRT5/f9uwzylLZnSN7Q02HZihiR9EboFsn5niRHYiyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7507
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240225_224316_752614_635A316F 
X-CRM114-Status: GOOD (  10.30  )
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

T24gMi8yNS8yNCAyMjozMywgR3VpeGluIExpdSB3cm90ZToNCj4gSGkgQ2hyaXN0b3BoIGFuZCBD
aGFpdGFueWEsDQo+DQo+IMKgwqDCoCBJIG5vdGljZWQgdGhhdCBTYWdpIGhhc24ndCByZXBsaWVk
IHRvIGFueSBlbWFpbHMgZm9yIGEgbW9udGgsIGNvdWxkDQo+DQo+IHlvdSBwbGVhc2UgcmV2aWV3
IHRoaXMgcGF0Y2g/DQo+DQo+IEJlc3QgUmVnYXJkcywNCj4NCj4gR3VpeGluIExpdQ0KPg0KDQpI
aSwNCg0KWW91IHdpbGwgaGF2ZSBteSByZXZpZXcgYnkgZW5kIG9mIHRoaXMgd2VlayB3b3JzdCBj
YXNlIG9uIHdlZWtlbmQuDQoNCi1jaw0KDQoNCg==

