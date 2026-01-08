Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D78C6D1488E
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Jan 2026 02:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0sLNOECmZRhdx0FgrVc7IyQtjQaMYlBBJHfdvcztFsg=; b=LTpAYbEn3GpLeiXFYZ7Dcy0Zz7
	EGH3Ep0UD1pqJ4Gwl1G3yWpqlcT+j7UDTPNf0feUJ2a7dFy1lpv1xZ2GRMlsflUEP+KwcKfq2jf2O
	D8Im+sgxMTHMHIY9XcvR0KayBLDy7w92nZVXbYzWArkdygnKA9wXp2l7pfnSbBcFP2h0dga9ROjgT
	SYUuveDEriyO/bJmSHC/348Fs/K1lcHP84tI4RCOls3xZDVrKjnxZZQqfF2B3Tp7qSt3d2phiyR+L
	6jR96RJwvqT5LIl5jjsmo753po2fWcofx9UqY7H2boi58suC+BkVM703ny97D79GKFew++LpSvdiC
	XsvX1oZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdfTi-0000000FoeM-3gyz;
	Thu, 08 Jan 2026 02:10:22 +0000
Received: from mail-eastusazon11011049.outbound.protection.outlook.com ([52.101.52.49] helo=BL2PR02CU003.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdfTf-0000000Fodl-1ySU
	for linux-nvme@lists.infradead.org;
	Thu, 08 Jan 2026 02:10:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AyiBSJHmjZuDW+GYwZnwqCyhAUCXkhUnXHydvrn5cLca1SBMvraXGgt3+qgsi1s0kMUgCsxifWB4jskZ4/MrWpThASG2gwYy4KXeYJOePn41gPL46y1lFnPqfiCNht1MwHGcolnQMNomZmbcpp+gRp/MFEoquL2HOmkD4STC+nXQ8kyfSrbsTGheoj10juWsJn6pGEvtQx3tavTLW6gZ9bqpcHR41l11QsqVJSKHW3MdmoHqeadu2x9i7uedpf7WKMtQBHXoEwJoQSEz1s+hZZA0id9WwpqplzyTzGsedBW1DqCVZfunzg9OicfpZWz53tjg9+qHPOKy6trOENLdmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0sLNOECmZRhdx0FgrVc7IyQtjQaMYlBBJHfdvcztFsg=;
 b=rSdDMI5pR88qHJ3zsrpg0qTVPMivGLG4qh5EGI7c+GPe2813Sjnq7uwPE8LlDo+9GkWpiqirbpqASt1Ejh+kJjXkLJtNTDFvxQ+ocN5cIAAGia6UEhMbKNgzFNTMMFkb1rqskfHc/Ppj5vjOUDB2xvSl3+u54h7XnO9bXp55+IZ7r/BlwfTqRpM3ZZvkCcSpK4pT/0gzEhkMYhVPlsUxTSMAXOYVbanX7z03VbxkTsbPZK/qRyJNKCOE8Schc9JiTfnBirQPp9IB0LPApY5DP6xhvyriLjwRBpYXWbLbMuMRqJHn3CP85pu/emleYqXcDnhTzcHZjBczid4VRoho3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0sLNOECmZRhdx0FgrVc7IyQtjQaMYlBBJHfdvcztFsg=;
 b=Qu6uSr0huM97oUlDoK4Bj1Umscb/nyLV6oYbhok13e602p6Ju2OIYGsD5FXzCVRxNaC/XyAKXDc4VRXypV5k7bZh25SNpTJespn9RKZt4s0SV4wTmivl6oIw79+wpQwWpDJdMWhTYIgYB71krjth2ELNdDTO7ljXGseBFFWgLuWmFHvwG0qJN8BOMZOalMlJFwF5PvTiLCD7y1McG/PegYuwtsWlQj4aIl0/C55xkUta3sVGIpRKFQ8jFz26bRLDzXRiGI1Jz6MA9GN92H0X1KkBaRdoS0ME9wc/jBfNn5r6JVYuNK9aJQUiVb02ctgv66ddTbWEzplLv7q4w6GfmQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DM4PR12MB5889.namprd12.prod.outlook.com (2603:10b6:8:65::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 02:10:13 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 02:10:13 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Justin Tee <justintee8345@gmail.com>, "yi.zhang@redhat.com"
	<yi.zhang@redhat.com>
CC: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>, "kbusch@kernel.org"
	<kbusch@kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de"
	<hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"justin.tee@broadcom.com" <justin.tee@broadcom.com>,
	"nareshgottumukkala83@gmail.com" <nareshgottumukkala83@gmail.com>,
	"paul.ely@broadcom.com" <paul.ely@broadcom.com>
Subject: Re: [BUG FIX PATCH COMPILE TESTED ONLY] nvme-fc: release admin tagset
 if init fails
Thread-Topic: [BUG FIX PATCH COMPILE TESTED ONLY] nvme-fc: release admin
 tagset if init fails
Thread-Index: AQHccUZLpkx5lBpkQkGyCBztz3Rx8bVFkeMAgAB384CAAZt0AA==
Date: Thu, 8 Jan 2026 02:10:13 +0000
Message-ID: <a2feda48-515d-4e48-876a-01ea6d8d8398@nvidia.com>
References: <20251220001842.6027-1-ckulkarnilinux@gmail.com>
 <ccf8741c-35f0-49bc-90dd-314085f1dbb0@nvidia.com>
 <cddd1db8-3da7-44a5-bcf9-210267c30625@gmail.com>
In-Reply-To: <cddd1db8-3da7-44a5-bcf9-210267c30625@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DM4PR12MB5889:EE_
x-ms-office365-filtering-correlation-id: 074b6697-d015-4fcf-ba80-08de4e5b0ee8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|7416014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?Z0cyeVJmVFM3RzFyZHdOUi82OGlZcUpnRGVFV2I3eWV6alhzeVBBaEhDNElK?=
 =?utf-8?B?T0k2NmpoTGFwVnl2SHRENmVrb3ZtQ1M5dVFHOHBZTHpCK0RmbUZlbjUxWFpB?=
 =?utf-8?B?MGY0ck5Ebi9ta2ZzbHFZbEpQRE5GN083Z1JJcEF3SDl5RmhwOW9QYXJNTkZw?=
 =?utf-8?B?aWREU0FkeDNoaXZMZEkzRElqNGRRbUpjSEltMkIzZDNzVklBdHNxSlRiOERI?=
 =?utf-8?B?SGkvWHRSTFRVZTAraGQ5V1c4NFJYc1hla0RKSlgvNk5WV3ROLy9laXlDQnA4?=
 =?utf-8?B?Vm9HOXhHMDYzZlZCOTYveDZsMUo5M1hldVNQRkNnbk1SQ1Fadyt2Uk1CVUZM?=
 =?utf-8?B?THQzL05vZkpKRGhZTkJjWnJ3bkRRUDNkM3ZGQUQzZ1lvVGR4aWZXcG1abjlU?=
 =?utf-8?B?NFhEZnhCZVZzNndiVFRqeWZCT2lqRzdIT0hVMGdKV2xnTUxmSUVML2FLM29Q?=
 =?utf-8?B?a3NyYWMrU1Fmd21BYkI2eFZCWURsZmVwM3hkZHVKTVZpNGdvZ0xsdUo3SDgw?=
 =?utf-8?B?cDBycktsK1NrbnUvZzQrcHcxTjFrMGVzUGRnUEVLOUhIYkRETkxWb3NOUWlp?=
 =?utf-8?B?T1J1UURraDIwUGppaGE5VHFlVmh6NGlYLzQ2cUo3L3N1bThFdWREWm1XeVR3?=
 =?utf-8?B?SjcreWttMEdDdmVUN0NnU3hwMmc5UXV6U1U2Q0RNb21EbHlubHVzVDQxdmt4?=
 =?utf-8?B?WllwdlRzTzcwWkh6R2xDMEVhS2hLbTlLL3RZVHEwdml2QWRubGkwQmtaMk1W?=
 =?utf-8?B?UDJQYkpuR3Qzd0lZTEthb3VvVlBnTFdYT242U2pQczhLdGR1ZzVLSjZUd2Vx?=
 =?utf-8?B?cm9pdTdrbjQwNHJGbk1NbWcxY0lpZGxYQlNVRE1YTkxuSk5wODBMT2dCODlq?=
 =?utf-8?B?bTM0aFpQQzN0YzkyWHJxSVhuSmpIMlUybTRmZXVSNWRYRFRlbnVnYWhLcWli?=
 =?utf-8?B?U2Y0Uy9kQU1uUUhjNWUvY215ZTB0djU2bjRDSnNteURneEppdlFraWxCODlQ?=
 =?utf-8?B?d1NGSXk3eTJwRE9QZG1mUE5lL29rMW8wZHkvTWlVMW9TQ01CRHB0d2Rrcmxz?=
 =?utf-8?B?WTVmSlJ5Nkh5ZElnRjBQNFYxakVjYXloekMxUHo0MmhSWnFBQ1g5THhrQ2lh?=
 =?utf-8?B?ZUJxVWYwSEV5SnB5MkxzdUd0V0k1eFNISHNDMEtLdnlxeGE4UCttakFURDRK?=
 =?utf-8?B?cTJTM01jdjBOMHlld0hjMkc5UGZianhqRzhsNWtLTXVSd1EvTURZSldkVnc3?=
 =?utf-8?B?THVLSWJrRXJGbEUxMExEd1pnWWpQaWFCdTZHMXY3bHo0WE1MSVQ0dlZmSlZW?=
 =?utf-8?B?dG85ckppQXVGZXpSNjdYL3VLQ0tZVG52aUVlWXNHOHNlaHpGNDlqTmtZQ2tP?=
 =?utf-8?B?TmlveWJVaHFXUXZxRktwbmJrbDJwVnpyVzQralRPeG55VzBDWmJ5dEh3Z1ZT?=
 =?utf-8?B?c1Q1elp2Y1gvSkdtcmwwUlo2Q1l3Wm53RWpVbHVRd0xZNENJZmt4OHkyRjhF?=
 =?utf-8?B?bXpMQzdHTDRlaDJhYlNFNXAvWHNKamV1ZVZYYUU2MnFaZTg0SUlSUWp6T0tF?=
 =?utf-8?B?VDdYQ2dNeGhKUEo1MFVGaWJJN0RTSUdvcWk1RUxOV29NVXk2VjE0WWNSdkVT?=
 =?utf-8?B?TzdjdG15QWhibjhIVXgyeGZNR3dZRTlGTDVKNEhmZ2tUaFRnTzN6OUs4b3Bw?=
 =?utf-8?B?WjZBTFF5VERzVVM1b3g2UFVDRk4xT1pMQ1VmdDZ2TnhqdkhRQVRiaE1zUjZo?=
 =?utf-8?B?Ujc3U0w0ajVLWHphZ0lXazVQRzdFenAvVkdWMWk1QVlvRFVjQkIzSEVVcXhi?=
 =?utf-8?B?RnBvSUN5Ymt2alhDZjgrMnk5MFdDQmdwTHhkUU43dllSemViMEZyRHBaN1Rr?=
 =?utf-8?B?akp4dVVjTXF5dVVZZWdoZ2VvY3RyRmw4aEh5eGk5QU4zQmkzYitFWXVvL1c4?=
 =?utf-8?B?SndkcFBxK2ZXY3U5cGl2WnV4cUUzSXZxeW5RZGg2cWpid2hJK0RLb09nK0E4?=
 =?utf-8?B?TW93cC90SjlWWHFXVGkwdGh6QzRJWWV5SkJENEY3WnYxaklDbW1pN2dKSEh5?=
 =?utf-8?Q?QpwdYU?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QU5HdTFYVytzQ1h4Yy9VdHVvQkN3aFRhRG13aHFHQ3VGLzdDY0dycjhsa0V3?=
 =?utf-8?B?SXZwWXJROW01eGwyYThVN2ZXRWpLNUV6cWFtZXpQeTVmWDMwV0VLZWdFKzBT?=
 =?utf-8?B?SjZ4MUpJd1lEMEFXdU5tUGJkVW5YeDN0NXlTTXk0U3hRTGNwZXpvQkJqVTNa?=
 =?utf-8?B?ZUIvWFY5L0J5R3FvZmprRmNrY0g1L1pDaUN4QW9vSTBjTnUwTU81aEdJanhI?=
 =?utf-8?B?dHk1ai8vYXdXdVk0cG54N0VjSmhLdEtVS3MrY3JxcjVzQ2lFS2I5MGFQNXRL?=
 =?utf-8?B?dlgzcVhOWlpTNzh4N2l5aEhuYUYzOUsyL1lkem1aVDhJTVY2dmltVGFDU2lF?=
 =?utf-8?B?UGg3WWl5UjV2QzdLYmVtS21Ib2ZWRGlpb3ZFNElFdzJEelQ3NDJFUENOMnpH?=
 =?utf-8?B?SkV3L0lVd0hxUUxQbFZxRVc5bnYwWGdvVW9hRkZIVDFHVEl6Z1ZVTkNhTnJ5?=
 =?utf-8?B?SnY2KzBaQVU1QVYwdVRGRXZuQWprejVjSHZMNlZRcDBZakpXYithRGtjYjdM?=
 =?utf-8?B?WS80U2RZRUdJc0FwL25UYk5BNDdqcGo5UWpBbHFCcUkrUlFYaWkyemVSdDls?=
 =?utf-8?B?UkFrVXNkS1NmVjd6T0E3ekFYb3RsQmxhUGdGcXRZNFQ3Rzl2Y0hFc25pY3FI?=
 =?utf-8?B?aGdkMW9HaUVaN1UvT1lYYWNrYk02aW1QaWM4TUp6QmVmZGFpMmV5ajk1YWZl?=
 =?utf-8?B?Z0JCNWRnd2xiTEwzZThhOGlVeEVMZExVRCt6cktWTGVyN1Nqdit3Zm9JOUQw?=
 =?utf-8?B?M2hoL0hSVVhJSWxsbjVnbGYvKzJBWEFTQVdINWpYNEFKUERkQjVWT05uUEN0?=
 =?utf-8?B?aC9wb1hQcDZhbnArWHhSZE1leEZ2N29BaHJiT1N4anNNa2NWVlZBODA1OHNL?=
 =?utf-8?B?V1ozcklNQWdhLzNTV21nTlBRQ0Ztamw0cnRlY3dtU3RMYys2cWdocDBqaFRZ?=
 =?utf-8?B?MjhKeDVvM25JQWZRWWQydG1NZDlWYUxWS2x6WW5IUG9ELzBrVkc3RGVoanAz?=
 =?utf-8?B?VHUwUkVQVmtCcnlFVXV1blpLOVlUS0JuRHdXbFlwTitCbkJiNlV0ak1PT3NM?=
 =?utf-8?B?Zms2T0tBNS9lK3RCeFNjZndPK21qcmlrYk1WdUE3MG9VQjNZOHBFKy9BRnFK?=
 =?utf-8?B?dXNpdnRKWCtZbXFMMS9JUTZKd0g1WmVXRzYzZFhhVXErdFJhaHU1bjh2bzVF?=
 =?utf-8?B?MFBLVW1FbTQ3Q2JBOTFoUUVPYVpUd3oxcFErYi9BVnJxQjI5UGJ2VktyR3BW?=
 =?utf-8?B?VmNJZUw0TW5NMW9LaU9aZWhwcEZDbmt2bkVYblpvNGN2MTRONlF0ekJHd2pi?=
 =?utf-8?B?ZytoU3pPSUh6cVhkNVlSdi9ELy9YOHUwdE15RWJ4N0xlYmx1eElqM05YL0Fj?=
 =?utf-8?B?VlloTFNVeENrN0ZJSk8waVZ3S3B3TVM1Sk90dTFkZldleU8reUFPcGdDWGRK?=
 =?utf-8?B?MGU0S1M1dlBndkVmS0k1YWdMV1VzcHptZUl3OEJSV2lXcXhLYmJGNHQ1dzBI?=
 =?utf-8?B?UGU4U0NYbTU2ajhKaVhOZ2lZc29hVFBlMXpvdUNkVTZtdmNzZzR4MGhPN0dr?=
 =?utf-8?B?d09QZjJpVmgzVjhrWGVmR2hNWHhEVjFBL3B0VXBrRm1uaDNtcjliczhnVTBt?=
 =?utf-8?B?amRVb2pOUlpFMlN1ZE16NXp0bVFKZTUrNFFyWG01STMzV0k1Umw3d3hRazRX?=
 =?utf-8?B?ZjQ0VGd0a0RzUlZXVnQyZUlmN2xJM2lEYktZWFExcDN4bk9wQ2R0bDVrVDBi?=
 =?utf-8?B?Y3h3eGpPbHhNZ2xiYndhb05pL1lZSVNKU2ZSNzVvK0xTZW5ycWVCN0w1R3gr?=
 =?utf-8?B?Smd0d29PbFRYZUVtcklvdkFZZlAwWUhlOXBTNityajIyK3dzZUhVL0VGT01p?=
 =?utf-8?B?N0JYVjRtN3pPV3lmWklTem1SbkpROXNNVWFFbFJDUnJlSTZoenRoMmk0TmZs?=
 =?utf-8?B?Nlk1Y3M1NU5rMEMrVk92M3ZNOEplUVhScWQ3K0h4WWU0Z2tFK1BIWGdybTRj?=
 =?utf-8?B?RGtqWWtQeGJoYzM3WDJWZk4wTi8xNFhJVmpVL1hHL3l1aDlRN1lRbllMNVBG?=
 =?utf-8?B?UGo1Q2x2WGk4bTlHNWNLdVdUWVp3MEtFaG9nQUNmaVUrUEFWclJhTXFsZVBX?=
 =?utf-8?B?NTVmT3FySTJqUUp1UXhmak9iZ2EyM2F1ZysrT2pUdG03NmkweHVzOHR0dTVC?=
 =?utf-8?B?ODlGUVljRHZxSVZ3cUpqQnF5bXZxQndUVGdRbmQxNmlVWW5ZTnQ3TGhyanJO?=
 =?utf-8?B?aE1jL0pmTnRabDJvZ1BVYUJvaDVpZmVxR2dpb2tUZHZTcHUzWjhNekJ2WWFY?=
 =?utf-8?B?Z1RtM0thQUpRZituOStSZUNVb3BIZElpRjk5bkk3djlWdEZjZkZFb3MrRFl4?=
 =?utf-8?Q?+/iibGRIhxOdDnaa0fKe6HViDyAQHTNqYhnLnYMcspX+b?=
x-ms-exchange-antispam-messagedata-1: SUWXx2PPRnwO3g==
Content-Type: text/plain; charset="utf-8"
Content-ID: <5157A9DF30E97C4FAD79E2F7CA152EDD@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 074b6697-d015-4fcf-ba80-08de4e5b0ee8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2026 02:10:13.2056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hm13L/9iU2OOa2LgLZWjGVNT5T+nyXySDQ/2nBEA4b548QDyk3lXfoyb2AsUW+qMlLq2VJlyir59QxkrQAzlUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5889
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260107_181019_514602_71114980 
X-CRM114-Status: UNSURE (   8.93  )
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

T24gMS82LzI2IDE3OjM3LCBKdXN0aW4gVGVlIHdyb3RlOg0KPiBIaSBZaSwNCj4NCj4gV2FzIHRo
ZXJlIGEgc3BlY2lmaWMgbnZtZS9mYyBibGt0ZXN0IGNhc2UgdGhhdCB0cmlnZ2VyZWQgdGhpcyBj
YWxsIA0KPiB0cmFjZT/CoCBPciwgd2FzIHRoaXMgb2JzZXJ2ZWQgYWZ0ZXIgc3RyZXNzIHJ1bm5p
bmcgYWxsIG52bWUvZmMgDQo+IGJsa3Rlc3RzIGluIGEgbG9vcD8NCj4NCj4gUmVnYXJkcywNCj4g
SnVzdGluIFRlZQ0KPg0KdGhhbmtzIGZvciBsb29raW5nIGludG8gdGhpcywgaXQgd2FzIG9ic2Vy
dmVkIHdoZW4gWWkgcmVwb3J0ZWQgdGhlIGlzc3VlLg0KDQpJcnJlc3BlY3RpdmUgb2Ygd2hldGhl
ciBpdCBpcyByZXBybyBpc3N1ZSwgaXQncyBzdGlsbCBhIGJ1ZyA/DQoNCkNhbiB5b3UgcGxlYXNl
IHByb3ZpZGUgcmV2aWV3IGNvbW1lbnRzID8NCg0KLWNrDQoNCiAgDQoNCg==

