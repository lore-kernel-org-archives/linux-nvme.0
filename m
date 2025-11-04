Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F770CCFA00
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Nov 2025 04:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M+EV4bMWI1Z7U/YrI9dYWdNycnntvAftRpvx8eNUW5g=; b=1im3MHkYjkhO+XZqMY/impCrmt
	UoWI9tsfsgekI8ynyzSdDb+bLi1JWshLiYah0HCnndCAbVHr4+gpxkNGcXbMzw6PBRh/nvRCydKGe
	LKCSZV4cqd1RH5/hULyeEzaDVocxm2Of7YwVMuNle0cIAE4wDuyXfIvVauqhWJgUThyj0JrMyKjux
	Fg2R8toNY4j+cpAJM+QxidhiexndKqYTkjpZLxodATJx46ZsVrLxG7n3eXIIyYvB8OlXaFpIbCYza
	zfO6YIuSir8z5SiXD7KUlY5BhlaBbs9dmipGeDUrCTUGQtD0ko+uAhEhg58fwMIOQ58bpRyRcZs8o
	qbO3LuDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vG8Od-0000000B7d3-1cd5;
	Tue, 04 Nov 2025 04:11:51 +0000
Received: from mail-eastusazon11012009.outbound.protection.outlook.com ([52.101.53.9] helo=BL0PR03CU003.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vG8Ob-0000000B7c7-0ZFE
	for linux-nvme@lists.infradead.org;
	Tue, 04 Nov 2025 04:11:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a8+nA4QcPmRjP9d7Hf0N+p3CyVwhMwOahZ/zttJByIoeueYmk2C0ekU17C2P3AjqxbLEes5lNi+JM2EYLaUWLKFKvAC/ScVOjH+iptuX+8uvCdbhgK64svBQlI0IuOodpBBWA1maRQnchTxEQZwgfm+Cny5pGV+s10v4k7KpcCHF9+KGidP5KrmgbQPSuaawALqe2p94YkQzdSqGYoOUbyqVt8/F6VE/k50TCptjAonOKgMApkjrnEXwD9zDcBv/G5xxEvB/N4rdaIdoWPMoB+C6JA0O0p6UfW5QUecni7ipy50Rxx8XgLanp2lsQc7bAjPEaT5+6TqkIc+PkvqQOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M+EV4bMWI1Z7U/YrI9dYWdNycnntvAftRpvx8eNUW5g=;
 b=KYUR5SDBrdcEKxdt5Ausi5p4epSt/E8aQMiK9MfOBhuu79S6ieYn0Ws7R3WDNXqVvUrbQeulg8I8jZUjjReGkpak7zPAOd7x+J8nqMcVaYoM3QwjfiU6YaiSp+JAag6g/sB/If5YE5PcZYYhWyDicYXK/mkVHmHKy1+5PL/U7qBPho3TE6nHwxipXmlJkxNUFlysU8J6nzCVL+ihP4QrPNzZ4/5jCEGuUOwFRkIrzKZqLMLmI+d72ZoKGwuacMIIGCNR7ziEjbNKjkfwGb577xFBUjt2LPgf6axO+o6XrRoXChazzsdIOwv8pI3aD8bM7xpmHHM9J1VCp7qD5XUQVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+EV4bMWI1Z7U/YrI9dYWdNycnntvAftRpvx8eNUW5g=;
 b=SptLsg0pNBBMewhjGt3JiS/3CVkDTqwPD7Kw6mnJI0qt+MgP7F/ISui/wJgaEsPWH+U9Nm2+FD3ucyWojCagwSUOZm+OIxrDOPzW6KYXaAaI6bAgDRRdBte/JmcrwCAtyBYckgpLmZpxsynQ97S2VsfIgsvAYliYY4A1FARM1YW6AC2rlp4lRUy2yKKuSy9wcd2KYAvbmFjNZidhX6IyjFIlKVAA6pbReoIqAJkh0Uozqze3O81PqOhcaqFh3RnnoC7pc2JaIKqK9m8dhDIJtVW0lB4LRUxI8kamGSSCfc40+SkXgPoXdFUQkmlwilIk8Se3VH+eyw2Mbj8FlTKuUA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DS0PR12MB7632.namprd12.prod.outlook.com (2603:10b6:8:11f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 04:11:44 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 04:11:44 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Keith
 Busch <keith.busch@wdc.com>, Christoph Hellwig <hch@lst.de>,
	"dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>, Mike Snitzer
	<snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>, "Martin K .
 Petersen" <martin.petersen@oracle.com>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>, "linux-xfs@vger.kernel.org"
	<linux-xfs@vger.kernel.org>, Carlos Maiolino <cem@kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, David Sterba
	<dsterba@suse.com>
Subject: Re: [PATCH v3 10/15] block: introduce blkdev_report_zones_cached()
Thread-Topic: [PATCH v3 10/15] block: introduce blkdev_report_zones_cached()
Thread-Index: AQHcTStuY66jOf+KC0CnP3ksKoo6H7Th5+sA
Date: Tue, 4 Nov 2025 04:11:44 +0000
Message-ID: <97b30ee1-2d32-49e7-a275-bd006d3a031d@nvidia.com>
References: <20251104013147.913802-1-dlemoal@kernel.org>
 <20251104013147.913802-11-dlemoal@kernel.org>
In-Reply-To: <20251104013147.913802-11-dlemoal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DS0PR12MB7632:EE_
x-ms-office365-filtering-correlation-id: f03480fb-1a3b-4bea-6508-08de1b584422
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|10070799003|1800799024|38070700021|921020;
x-microsoft-antispam-message-info: =?utf-8?B?NjdkOE1xNkJTWnlJZTdqVW12WEh2VEpsbXFCVkg4TTFMdWNpMlpDVys3bVJk?=
 =?utf-8?B?YkRQMjg2L3FyOUs0MWxyajhPY3JFeFF1T2crWno1VEVGUFFsQzloM216dWo3?=
 =?utf-8?B?NkdjQmVsZFdldE92OFY3Yk9LdjFreFhxSUt0UEMzQklqZ3RpWFhvZW1BVGNU?=
 =?utf-8?B?TjNXTndjTkRmbEpwQlNmcmJNTjhsVVZ1SmlOWEtmZ0cwRlMxQ0VZTk02Y2x3?=
 =?utf-8?B?bk5MbWZSSU1ZV0J0b2x5UTA0blpxYzBBaEgycEpFZWdEaXMvRm9LY1pqcS9Z?=
 =?utf-8?B?aEN5SU80R0lMQng0TTNRMERGcmJLbVB2ZUxaTmFYQXhoR0RGYi9pTyt5elJ5?=
 =?utf-8?B?QnZpRUR2dzhTa2ZMcTNoaWJOV05OVjVoTk9SdW5iNlUyRVk4dEdqSzVScTR6?=
 =?utf-8?B?OVdlTUNjSkNyVVJ5Wit6TzE3TmtlYmhyblhsMVRLMDBEWE1pTi9xbWxlcjhl?=
 =?utf-8?B?WWxPU09zMlFIeGpPT0phM3VNSTljU0Q3N1RvWXFMRW9Ycy9WV2h2ZDk5eW1s?=
 =?utf-8?B?RnBmR3llRHU0cExBNFArR0xhOTl5dE4vUU4yS2dETG9EM3ZqRmJkMlFDUDJC?=
 =?utf-8?B?bDlDanI0Yk40enZVUGdvK0dQWUlFQTRkSjJod1UzQUNBK2UxM0c0ZDJxWmpL?=
 =?utf-8?B?QlZrN0JyeWZMenFNWUxGMm9sR25idUVrMDhtNWszUWJBS05qazJ1Z3p5R2lt?=
 =?utf-8?B?c2hRS3hTSlZHalpCS3JJU2QvYTAxZTdkNjZVc2Y5V0hsQUxHN212YlZOZzgx?=
 =?utf-8?B?UmFXdEFWeUJSa3hQVllKaTZ2alhLaXpNTDFyYmlCSXpGMVNxcEpYTHZqVm84?=
 =?utf-8?B?Wjl3azZTd1pYN3BqL2hpeVRLaTZhejNnYkx2aTBGUlpubVYza3REVitISSs2?=
 =?utf-8?B?dWNpTDhhak5QUWRuK3RXd1lUQ0F4MTFCT3A4dFVSWGw3dmVRM3JBSDZtOG9V?=
 =?utf-8?B?TUpqYm13MCt6M1pGQjZtTDExcDBqdHZ0VHZVNG1lSHY1YnBZdEpUVDBxeXZ1?=
 =?utf-8?B?cEx2UHhRSmtDVkhjaEF3STFmUktkM3BxSEZjcm1sMHA3dUVFY3BpVERJaEp4?=
 =?utf-8?B?WU1tekc0ZHdzTmFJcjBBK3E0THUycUNjbklHeEdhTHdUTEtRdUJURjljSjlM?=
 =?utf-8?B?M3puUHNzWkd2SFhkV0RlY0Y3bXRVVkZvY1JtU1phVWxlZTJxaVVyUHJCSW5N?=
 =?utf-8?B?ZWg5S1orZm0wQ0xROTNDaU10a3JaZ1lMMkJzcmlpaTFpdGdLRzgwV3NnVDE4?=
 =?utf-8?B?Y3BuTWFNNVNKQ21pZFgxaUtGbHBOcnRWQkNaZTVERXJXTzlNazcwSkNBS0Qw?=
 =?utf-8?B?QjAxc3IxRk1PbEJ3YzVMYzRPck00YWtxbkE2WlJlVEY2bWs2NlNtRWdmcFAr?=
 =?utf-8?B?UGtHMkR0WjBqNksybm9xTXdYZ251NmVXWS9oWXhscGI5ZkpVME93NjJ0MDdy?=
 =?utf-8?B?Kzl3bDRDT3pOcWs2amhSaW8weEtnOGN4RUdiRmd3eGFIVVAyQmkrdlVVZDZk?=
 =?utf-8?B?TnpCUGFzajlpckU5anlJL1lkOGVJZVBGdDc0d2xUbnJpRWYwa0JNUm00VGJH?=
 =?utf-8?B?NXh0Z3lBMXNCeHVFVWgxRm1mWDZJRDh3cnFVN240aVBaNEEzUUZBVjF6WnFn?=
 =?utf-8?B?OTROMFBUNUJycFR3bnVIYzBaQ2txdlBCL3AwY1E5L3BPUWM0aGlreHJsSGZB?=
 =?utf-8?B?WkRkNGFhMEI3QklPZUp4bXpsVy9yVVlobE4ySi9kb0FRTjZQQ0wvV253SEZY?=
 =?utf-8?B?ZjhyVEZhVFFwbTZIc1JUS29jSUl5Ti8xc2ZXa2dZK1A1MjJOeWVYVGFPOWRi?=
 =?utf-8?B?eVVYUUJTY3NtZi9xOFdSUDFYQU90UlowcHM0MzU0QXFweUVEN1BVT1h6QjI1?=
 =?utf-8?B?Q2VkSXMraVQ2cTArbWVTVmllLzExaW5ORnZkNm9NL2w4Zk9WVkgrd3R1dFdU?=
 =?utf-8?B?aXhwbG9nSUNFNWRLY1Q4YXNBMFJ5VTM5andKVkVTemUyd09mRDk5cmtRT3Ba?=
 =?utf-8?B?Y0RHa1RyVUN0dDJnSDVCUnFmRTVyaEdWOERVc2trclRKb1NCSHlOUnBpSW0v?=
 =?utf-8?B?aHU4RFpZdFF0VWc3R1ZQYnlya0ZDUGNRc3BPdz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(10070799003)(1800799024)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFplRnZyWTVpeTlFektxZ3Q4cXU3aEZmbUV0cldEVUdGeFlGSm8vaE1mUU94?=
 =?utf-8?B?Z0hwK2FFR0NwZ3MrZWRRS1daVHVnZGVrS2dGbGhOOVRkc1JWUThqcm9vakRT?=
 =?utf-8?B?V2srSEdNNzlhaXpQcGdjZFUwNHY4MisvdDJ3NklPQUdRTWZkRGtLMGZZUE9D?=
 =?utf-8?B?c0pybllpRlRKYS92WW05RXlUWHlUWFdHUERlSldnNm1NMTFGRkVQeUlyUjFV?=
 =?utf-8?B?cDVVV2NkM3ErdDIzbTEvNjgxNjhnRVFsVE9hWDJaWGRWZnJpVHArSCtlWWVH?=
 =?utf-8?B?ek5UUW1XbUw2cnkrUlAzZFMwOFk1bFlCVFpJR3NYMVAzUS9IZXpMZVlEZGdW?=
 =?utf-8?B?bW5mUTN2T3MrbzQycWduTWtKdGZKK2ZTeEJ1SHB6bFZSNU01aXlVcURLOGJq?=
 =?utf-8?B?cks5anU4amxodUo3N2paUlhmbnEvUkpLdk54TUV2ZzJtWG1lRXUwejB6amUr?=
 =?utf-8?B?aW5DV1kycEVFalh2R2xEaGZWdzFMSVJ4TnQzekIvbzlMZHdnbTErZFZLTFlQ?=
 =?utf-8?B?UTNsQ3NneUVmQ04xQncyWHQzdlB4bWZGZ3ZnV3N3WXkwTERRZDVCWGpkZEZO?=
 =?utf-8?B?Z3ltUnNqT0U4c0hZMm03QjRpYVJ3T0FVc2w4OXRlNHQza3ZJNndhTGxvd1FG?=
 =?utf-8?B?S240VEN6WEFhb3pSV1NmZHF6cG5ObHhzT3lYRVBHR1RoU1VONi9LNEtUSndE?=
 =?utf-8?B?QUVIRmxmYVFXcCtiYWJTdDJubWVXM1JnYTdlNTE4UTlPaTdmc01SQnVEV1dh?=
 =?utf-8?B?YUpZNEx1MXhjUDJodXNNQmtORjd4OWJvMjFSanB5K3pMUDFQYjhoYWFyMjBN?=
 =?utf-8?B?cXdxcUozL0JrcFR4Wm9pVkhTZFZScENXRG8ydWg3SG5KeGdGQ041WGxjQ2J1?=
 =?utf-8?B?aDVnQ0FGSk96VWRtaFBQNVNUVlNrQ2hMdjdCL2dQcDFaZVFnNjhDYzkxSU9F?=
 =?utf-8?B?S293V2dGa3BlUmtpVzNpRkdkSnczZi96U3BDRXp1d3hvSGRpdlFjVmNnM0hR?=
 =?utf-8?B?aS9EMHVpYm04emRpdGZ6NGdvTENGV2FMUUx5R3ZjWTdGRTlGTTh0VkYvOHNZ?=
 =?utf-8?B?VVhlWmZnak9KQXhhVE9sajF3UjRmWVBKQklqbC9walpDUTN2aHl2dEVoL1RR?=
 =?utf-8?B?dHVMQUlLSkRwbzBNNGNzbnp6bFR4UEpmelJkNEFaOHhHaUJ2TFV0YXFXMGwr?=
 =?utf-8?B?allJNm5KRE5IaHBXQ05GbFhUY0xNS3BaeVhlamFmRmZ1ODV6SHVkUmcvemRH?=
 =?utf-8?B?emRPZG1STlVpU21pQlpSUVhJSDdCblQwN0RIbzJtTmNWUGFCWWFBd2xsSld2?=
 =?utf-8?B?SGNROXBOeG05UEt1RkN6K2ZjQkFpenFyMDVYNDNTZzlHdS81Qk9rWVhwRkVR?=
 =?utf-8?B?bDJ6emo1TURtU2ZoV3Yrc21FWVU3UjNnMzdtQXNjYm90NW1DdkJDci9YV3FR?=
 =?utf-8?B?UDJWZkJROVBpWkVRVitMMlhQdUMrZXhwQWxkMnRCL2ZoQld5cm1YV1BTVHVo?=
 =?utf-8?B?a0xSY1pRV3h6ODB6dW45RlVaTzA5NXF2d1AxR2xtQXRqajNkNmlpUEVEZXVu?=
 =?utf-8?B?SCtFSWJKeGxmSVFldW55NG12Q0hLUEs2TVZaYjZuN0FSaE1UNWFPUVo4SXE2?=
 =?utf-8?B?MkNSN2JNTHhZVzkzM1YzTE1ETTAvSlR3N1JGV3kreUNPMW1zd1FzTWpUdTlR?=
 =?utf-8?B?RTdTcnFScThiSUlhOTJ3azdwYWczVEFlT0lnenN4ZTFrMTlPckFnV1VZZG1M?=
 =?utf-8?B?ZXN5aE1zSm1BS3JYa0hLVCtMVW5tbkxBTHpxbWI4MjNoTjM0bmpEK3NIbDA3?=
 =?utf-8?B?UUw3bHduWG9tOFVwa1lPeVlqam9rQ3BXRjBIbTZBczBkdkpQb0dxQUczVnN3?=
 =?utf-8?B?blhza2ZBdUtkSFV2T050SVljN0l4eGZocFBNdHlZekExQ0trSUU0ZU9VRVU5?=
 =?utf-8?B?dmYrc1R2SGxmRmFtUkV5bDdVdXZkQ2tOUnVmSmpTV1JSREJFOFFPc0c2dllj?=
 =?utf-8?B?MjV0VnBWSzJXWTVwZ2ZpcVZOdk9LOFJqcmRxOVB4cE9qd05sbk9VNGZvWE8y?=
 =?utf-8?B?ak0zd3VEZlhtTUkxUHdOeHZXM21CTWFHNU1wOG5jMVV6Y21OWkgvYVB4N2ty?=
 =?utf-8?B?ODVucWRNdGxNOXl3ZnJaOG9PbjF5dDJaL1VXek1JOVhmT0piM2g2YjVOandk?=
 =?utf-8?Q?aF30EkmeLc0zHr/lkNxvy3Peoe60Ek4E7hc5BsE1RNRK?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CAFE611DAFFB6A41B0ABB3F0125C9358@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f03480fb-1a3b-4bea-6508-08de1b584422
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 04:11:44.7285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ak19b3IdUqprzLs17H94mz2k19PL96G4ULCcqH3hRwRuRaiRK64R6IlQv3bQBzCVZEwcyfhGGvIEApU28jMZdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7632
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251103_201149_175126_F599622E 
X-CRM114-Status: GOOD (  14.72  )
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

T24gMTEvMy8yNSAxNzozMSwgRGFtaWVuIExlIE1vYWwgd3JvdGU6DQo+IEludHJvZHVjZSB0aGUg
ZnVuY3Rpb24gYmxrZGV2X3JlcG9ydF96b25lc19jYWNoZWQoKSB0byBwcm92aWRlIGEgZmFzdA0K
PiByZXBvcnQgem9uZSBidWlsdCB1c2luZyB0aGUgYmxrZGV2X2dldF96b25lX2luZm8oKSBmdW5j
dGlvbiwgd2hpY2ggZ2V0cw0KPiB6b25lIGluZm9ybWF0aW9uIGZyb20gYSBkaXNrIHpvbmVzX2Nv
bmQgYXJyYXkgb3Igem9uZSB3cml0ZSBwbHVncy4NCj4gRm9yIGEgbGFyZ2UgY2FwYWNpdHkgU01S
IGRyaXZlLCBzdWNoIGZhc3QgcmVwb3J0IHpvbmUgY2FuIGJlIGNvbXBsZXRlZA0KPiBpbiBhIGZl
dyBtaWxsaXNlY29uZHMgY29tcGFyZWQgdG8gc2V2ZXJhbCBzZWNvbmRzIGNvbXBsZXRpb24gdGlt
ZXMNCj4gd2hlbiB0aGUgcmVwb3J0IHpvbmUgaXMgb2J0YWluZWQgZnJvbSB0aGUgZGV2aWNlLg0K
Pg0KPiBUaGUgem9uZSByZXBvcnQgaXMgYnVpbHQgaW4gdGhlIHNhbWUgbWFubmVyIGFzIHdpdGgg
dGhlIHJlZ3VsYXINCj4gYmxrZGV2X3JlcG9ydF96b25lcygpIGZ1bmN0aW9uLCB0aGF0IGlzLCB0
aGUgZmlyc3Qgem9uZSByZXBvcnRlZCBpcyB0aGUNCj4gb25lIGNvbnRhaW5pbmcgdGhlIHNwZWNp
ZmllZCBzdGFydCBzZWN0b3IgYW5kIHRoZSByZXBvcnQgaXMgbGltaXRlZCB0bw0KPiB0aGUgc3Bl
Y2lmaWVkIG51bWJlciBvZiB6b25lcyAobnJfem9uZXMgYXJndW1lbnQpLiBUaGUgaW5mb3JtYXRp
b24gZm9yDQo+IGVhY2ggem9uZSBpbiB0aGUgcmVwb3J0IGlzIG9idGFpbmVkIHVzaW5nIGJsa2Rl
dl9nZXRfem9uZV9pbmZvKCkuDQo+DQo+IEZvciB6b25lZCBkZXZpY2VzIHRoYXQgZG8gbm90IHVz
ZSB6b25lIHdyaXRlIHBsdWcgcmVzb3VyY2VzLA0KPiB1c2luZyBibGtkZXZfZ2V0X3pvbmVfaW5m
bygpIGlzIGluZWZmaWNpZW50IGFzIHRoZSB6b25lIHJlcG9ydCB3b3VsZA0KPiBiZSB2ZXJ5IHNs
b3csIGdlbmVyYXRlZCBvbmUgem9uZSBhdCBhIHRpbWUuIFRvIGF2b2lkIHRoaXMsDQo+IGJsa2Rl
dl9yZXBvcnRfem9uZXNfY2FjaGVkKCkgZmFsbHMgYmFjayB0byBjYWxsaW5nDQo+IGJsa2Rldl9k
b19yZXBvcnRfem9uZXMoKSB0byBleGVjdXRlIGEgcmVndWxhciB6b25lIHJlcG9ydC4gSW4gdGhp
cyBjYXNlLA0KPiB0aGUgLnJlcG9ydF9hY3RpdmUgZmllbGQgb2Ygc3RydWN0IGJsa19yZXBvcnRf
em9uZXNfYXJncyBpcyBzZXQgdG8gdHJ1ZQ0KPiB0byByZXBvcnQgem9uZSBjb25kaXRpb25zIHVz
aW5nIHRoZSBCTEtfWk9ORV9DT05EX0FDVElWRSBjb25kaXRpb24gaW4NCj4gcGxhY2Ugb2YgdGhl
IGltcGxpY2l0IG9wZW4sIGV4cGxpY2l0IG9wZW4gYW5kIGNsb3NlZCBjb25kaXRpb25zLg0KPg0K
PiBTaWduZWQtb2ZmLWJ5OiBEYW1pZW4gTGUgTW9hbDxkbGVtb2FsQGtlcm5lbC5vcmc+DQo+IFJl
dmlld2VkLWJ5OiBDaHJpc3RvcGggSGVsbHdpZzxoY2hAbHN0LmRlPg0KDQoNCg0KTG9va3MgZ29v
ZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoN
Ci1jaw0KDQoNCg==

