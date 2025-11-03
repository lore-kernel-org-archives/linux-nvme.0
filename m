Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9FC2CCF9E3
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Nov 2025 02:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UsCE3nzMiSkOlaNHlbtJU7CIUbHVtIEQTpW6vzpHqaY=; b=uwJye0lkJ8+HEEaaB/prcWn2j0
	w5QF3mvP88rB4iO604f7MSyxn5wrBYCEXdpv6wzfXE2V3KgAARH4pgYmtVP2IWmZwZniFow2KEVYr
	vSfHblJls6n6LnzxqsA7t0fqQwSaUtKNzrxjnmMYwBnIfZlYeo8mTlQTo7gNpHioODJ0nmg6ogVo3
	L/qE+AybiXcp4PeK69f9j3dc16TihnldPBO81OxmI3rVSR5DBZUFRQXLKiEEMlL1DZZWOAFTT0YQ/
	PA96qOf74XE6K1LBrv/p/yfKN4WN7hXakQytoCV6yU2Y9RvtGb/9ctO7nPSJPyhKqYDn91JlQ984e
	DnGYu/eA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFkMf-0000000949L-0D8Y;
	Mon, 03 Nov 2025 02:32:13 +0000
Received: from mail-southcentralusazon11013047.outbound.protection.outlook.com ([40.93.196.47] helo=SA9PR02CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFkMc-0000000948Y-3bin
	for linux-nvme@lists.infradead.org;
	Mon, 03 Nov 2025 02:32:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rVKBvtNhKsu/XArtfPJh9CRClALZJGY3dbs5t+AlSBofJ5fsepmH6w5pNi3iCAdPVkPSp6qy2Y3uDmMAlgzaMKt6O2InHm7b3tJe7JAfWrKAvHlG1XSbS/CFAdsceW18siagMfFwoV2fWjSwlyltpWo6SnxmCf1znTa81tjzESV4uHpSPG9wLtOWyUAKx+l2Hsn9vBOe7bOuTT17FbAtQJe8XnEIcMXf77szqe8F2CUXLoV6Rwih2GChD9+7PTQlAIAWmqnPpfLunEptCYCd+qbTassIoZiKXkCz9HZ04pcNsCl5cj/2rZwdR4+3Ti3AAS7mq2z4swGJRL55piUM7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UsCE3nzMiSkOlaNHlbtJU7CIUbHVtIEQTpW6vzpHqaY=;
 b=G/hCD+z1SD7dgcmpqPQHb3clo1SsLC5V6MKpOkDqf27dOl2G/2OBXyFhzASBX/ZpaInkJ7I/h6p9ZVcCp2i+OtBg7FdhQ5zsk5FFplALEr2Lg6ziIy2jgl58Wm3LOPZi75aQtPuPMi3luM2wfqhsGRxMxBS16RmUMP+plVXXKISm22UxopKaDp6Fo8Q7UeBrA1PLHJRJ1FQc3ekyueKDKnIs+xuUirVyTKBEwEUPaOKp9Nlehx4ftc3z0+vstPRbTxLzCXDsho6QD5VL7zuvE7RUr1AvAWmy7nmaMwRvxkRueO7M1QJ9K/3iC2tCVsyp3L9kTAvtygERBSU+S6I1ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UsCE3nzMiSkOlaNHlbtJU7CIUbHVtIEQTpW6vzpHqaY=;
 b=ZzUBLOI5pti/uiM71RtIkgFViFudYlHeW1Cfm1e7hp+q/cEwMZN0hltUROEb0E9g02XSwZhyagX6t/d9hM7ykACDf3m2RkVPjPArTIzuQ8pPM64uAMZJHAqMZfW4f+LKTPftgIc2D58/1HaZbdZJtU83W1mucmnd9UxEXTVJ3KLNVRsuHH/TVOMRzDlMkXJEGm0Ewu29in9MEjqTf3ZhgLlmdaVXQDd01Vg7jo1nV0MpKsflGFGi/eOBep6k4lulz1VcLZ+k/JnSMW/OXFB4fqgl3cedkBsztIPPIBqeFI/g2hPgXEVQ9PlvATMFTcvt4BqHAGsInpBcgirlj0YILg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SA1PR12MB999085.namprd12.prod.outlook.com (2603:10b6:806:4a2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 02:32:05 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 02:32:05 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Alistair Francis <alistair23@gmail.com>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "sagi@grimberg.me" <sagi@grimberg.me>, "hare@suse.de"
	<hare@suse.de>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Alistair Francis <alistair.francis@wdc.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 3/3] nvme: Allow reauth from sysfs
Thread-Topic: [PATCH 3/3] nvme: Allow reauth from sysfs
Thread-Index: AQHcSVCCMmRH7tj5UEabgx2Ww4HvrbTcTECAgAPot4CAAAUugIAABUIAgAACDoA=
Date: Mon, 3 Nov 2025 02:32:05 +0000
Message-ID: <f40b441b-2a82-4739-a4c2-a47b2376a80f@nvidia.com>
References: <20251030035114.16840-1-alistair.francis@wdc.com>
 <20251030035114.16840-4-alistair.francis@wdc.com>
 <20251031140541.GB17006@lst.de>
 <CAKmqyKNr8N4r=9RvgErr-zj929gd8oRfdKGgrhVajK_UxR828g@mail.gmail.com>
 <b684812e-8ade-4adc-aa08-2e4fcc9811d7@nvidia.com>
 <CAKmqyKP4sWF_HbP4FNK9w1AP_MxnTNBjzO+uYaumT9p4UigepQ@mail.gmail.com>
In-Reply-To: <CAKmqyKP4sWF_HbP4FNK9w1AP_MxnTNBjzO+uYaumT9p4UigepQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SA1PR12MB999085:EE_
x-ms-office365-filtering-correlation-id: 516052d7-442b-46cb-e380-08de1a812dbd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|38070700021|7053199007;
x-microsoft-antispam-message-info: =?utf-8?B?dlplQ0Qvb0pkdzNjZlNyUWN2TDZuMFZrRUFZMm1UZGdFdmNBNmo4QkpTN3Zo?=
 =?utf-8?B?WjZnMCttM0kyQjZPK2pVbU02WkhQTTlIL2cwUkxxM1lSa3Z5ZVdmSFlLb0J6?=
 =?utf-8?B?bUh6SjZaU0RYZmNJa1VzaUJzUEp5ckxoeWxhRE04Mi8wYTV2U0JCcnE0ZStI?=
 =?utf-8?B?dG1JTVBVc1B6ZXFNSzViMEpoL1NVTHEvM1pJUVMrQWlZYUUvRU11aHRRM1R4?=
 =?utf-8?B?Q2grN2NtdVFuNHpKZFJXblJPVFJCVmtWSlhGTFMxRTdFaXJRTWc3aWs5WE5M?=
 =?utf-8?B?K0xnYkNqWlNQT01WU0d2VXRHMHNpZi9YNURjNnZ6VTFSUGtVd3VkTzI0M1BE?=
 =?utf-8?B?eHRaM2x5cVZXajY4bXBvZjZwMkF0UGF3emlBNlRHbndMTUxIa25CWHp3TlRn?=
 =?utf-8?B?dHBkSGhub1M3aDdWTkpMczY0L29KODBwclRmbGt3bFM5MGllTGxzYi91cTdq?=
 =?utf-8?B?US9McnB5ZjVCaFJDNFBxUDFZWEl2OXgxTkV0SlFkT3RWZGorYjZlc3FtY21K?=
 =?utf-8?B?SGFabGlyak4zbmtUYnJCbTlGcXNSWk1TM3Zqd3YxQVpWZE1YOWZ1Zmk2WTFh?=
 =?utf-8?B?b3F3ZkV0RS8vRjdPL2didFp3TFQySTVqc2k4cGQ5dHY3cEFvZzF3YmNxUCtK?=
 =?utf-8?B?N2ZWQW43OWNLcmZrUHAzZ0Z2VEQyTWsrVjVlUDB2L0dVcUY0d0l6S3FZNUJ6?=
 =?utf-8?B?WkMrVEs5N2VLY0VQaWpCS256QUE2K1NGdTJLbkJGODZ0T08vNzdwMlpjbk1r?=
 =?utf-8?B?WHNuN0FxdTJXN3oyQVNzNzd5bCtzZnMyYzgrL1IyV3JNM1E3MHlBUld6ODFJ?=
 =?utf-8?B?TFVMUW5IdE0rK21oTGloTkFHQ2xDY3dQYkw2KzlUbVdRaEZCRFpkeERMRWZx?=
 =?utf-8?B?ZUFBcThJSG9RbVBlcEUwNjFUaGtyaEVidjIvMEFTdDNsMWV3QVJCOGhXclg2?=
 =?utf-8?B?V1Vvd1Bvb2JBamJaWnVJeGZjNTdrQjFrRXhkRzRiSXpKd09xaGpGZTErTG42?=
 =?utf-8?B?T1JOdE01cHQ3YWxLUG9HaDFiYzBEOU1JanNFakl1MTJ0QlpXYlJ0VWNDZUFw?=
 =?utf-8?B?TUR5S1R3eUh3amVWc0lIaW56YUlKQzVsc0hYdkVMV0lJblQ4U1FDZU9lS1U0?=
 =?utf-8?B?NjVLVFB0d3JEQTErSjdHT2VQbjNtbUpKbHhMdnFWR3FjQmlvUE1EYSs4VCtj?=
 =?utf-8?B?TWgvUGdnK0tuaDZYMVdBeDlPQ0pIR3U4SXM2eWZSdW1uaFlWQ3F0WElQUGsz?=
 =?utf-8?B?ZmFJT2RGejliRy9vS1Z0OTlCUGxRWk9YeHJkT2NVWkxjVmJrUTBQRG9Eem1t?=
 =?utf-8?B?M1RzdDJ3UlhlenA3dksrY1Y0ZjVUMnRWTzdibFFyRGxFTFk0T1V5SGhVdW9s?=
 =?utf-8?B?ajZtRW1tUTZ2aURscTVMMmRBQmxUZ01tRlRGK2FpRDhBQytXZnlFdGNVK0tC?=
 =?utf-8?B?NVoyOVd2amwvd0tuM2I1N0ZkUGhVZmtIZTJFYk1BVE1oSGNSVTZwcHl6QVlD?=
 =?utf-8?B?cXVDSk5NcFMzTWhRZzZTRmR4Ym9vK00yRExmTVorSEpyRGp3TUxROGVmWmxI?=
 =?utf-8?B?SFRTVFhDeFVPRjcyNnBtM2NoY3lreFR6NTZQUHlpTzdaSnFKN055TkoxbXFC?=
 =?utf-8?B?d21pT2t6a3VobWdUOEFRSGZWQUtLSG1aaTBUdWsyMmFZWDh0OUE5cUcxa0Zz?=
 =?utf-8?B?WVZaVitUZnhCdlBxaks0cklQZ24wTTFrOEhSVXlXRFBOUHFUSlcxY1V2RHJH?=
 =?utf-8?B?RCtRVTlkdGR1clltU3hqYmUxUkhURmlJM3I2a3BpamlsM2dKaUhNTU00SWZ3?=
 =?utf-8?B?SVdVOXlyYlN5SGVaYXBvdmVjRzhvWWZQQ1k0NUQ3OS8vRkFCNGVSVis0YTRG?=
 =?utf-8?B?dy9WUkU0Q2ZZbjREd1FyazI2TDZFc3EzSk9iMjYvcW9jUkUzSnFjMWJyS092?=
 =?utf-8?B?aGtZOEZINXJuZEwzZ0c0ZDJnWUF4bm1UZHk3NmVjRS9CTjk0UnZEdktxU3VC?=
 =?utf-8?B?WTl4Y2txWEpCcGJmQStuWWZ2K2JWWTJMaTVpM2UwTHVWa2tScGxURnUxYkxl?=
 =?utf-8?Q?JvBfY4?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SGhnd2ZwcGczOTZoT1RHQmxKamVTK1Z3UzNQYUpWWG9TQW1UdUx2WTJuM3k0?=
 =?utf-8?B?cUp6R3I4d3NibUVDMXp0ZUowZkMzYVI5aDRGczBJazNnMVh3YU9qemIvdTVw?=
 =?utf-8?B?YkI2SG1WcVZlQ1FmZzVmM3R3d1ZMOFpKYXp6czJHbzdYbFFIb1c5UTY2TGNp?=
 =?utf-8?B?N3B6bWR6UXkwVi9tbWsyYVQ5NTE3ZGhLaGNPYkdHNkdMaUUrcjUxOEpYSWhI?=
 =?utf-8?B?OHJzMUhRNTVRN1VzemswbXR4elFxb1l5M2lrbnVKR3M0a0MxcVhiaEFOb1py?=
 =?utf-8?B?MEU2cGplRE1HVmZIaXZBWmFrZGRmR0FoZ1IvakdXbjVZbXlWQzcrZmVwZ1p2?=
 =?utf-8?B?T2JuT2VQVEhKTDQ3b0hWODcwUnY1R3RKYW94TzN6WVhIS2NKVXdoV3Jad2hh?=
 =?utf-8?B?VEdvbVhiU01ZY1AwcUMrWHhuS2NOVlY3Wm0wZUxrOGJrL09SWmx6UGJudCt2?=
 =?utf-8?B?OWRSdFpaWUxMeFRaMXE3RjBKKzEyaklKb0FqOEdqaDhERld0U2ZFWnlPOE4x?=
 =?utf-8?B?bkV4azZIb0ZhV0xRcGJwSHV6UWZtb3RSeFhlRDNjOVYwZ3k5dkMyVFcxcWg4?=
 =?utf-8?B?dlkveU5MZFZYbTIyQjhBN3VIQ3JWT2txNG5TQlFnWldwakQ0RVJ0QzN6YlJ5?=
 =?utf-8?B?b3crVEhTUXV0dUNLQWtqbWlTcnhVcDJjNjVTbHczOXFiTzNqRnpCeGF0MmdG?=
 =?utf-8?B?SmN4akRvS3M3a1VvcWhXVUcxeUdyM2tHeEU4VklwemRoQVJxbFdSWm5nVURV?=
 =?utf-8?B?eGE0WWRhWGN4Q3kxTzVvdDlMeStwaElvSUlSTjFoOEdUemljekFaSzZyUnNn?=
 =?utf-8?B?NnF3MXVYZFIyYXBSMzRHV3hTVVBINmZGYXkwbjN1cTBGYSttMzVwSzRVTXlt?=
 =?utf-8?B?YXZleWg3ZWlHN2NQRDJIZmlGNmhFamh3a1lEb0xKL3RzU3pwbFJ5bmphS0d6?=
 =?utf-8?B?TE1UT3dtcUZ6RlRaemtLa3d4UFc4UU1ROWtGNVArbkxhVXhvY0hlQSs1cWhV?=
 =?utf-8?B?a3Z6Q1dlNXB3bm44Uit0UmFTTWY3TW5CdllWMGMvYTdQc3FYQjhSM0NhQ2tC?=
 =?utf-8?B?K29RMjZmQjBmbUFBRGVVV3gzeWhKbVdZZjZhd0tDcHNJVktvbFhkNGtmdTZp?=
 =?utf-8?B?MWFpYVJ6VCtoSGFYOVNQZTRmMGxWMDNFWi9tZUtXVm0rcHlacW9LeTF3UTd1?=
 =?utf-8?B?eURFUUt5YVFjdldQcTJNUGdORTRXcGowVVkwS2VVNk1qa1Z2K1F4cFRkSWky?=
 =?utf-8?B?U0lva3VXQnE5TDM2ZXAvblMxU0FBVzVGSUs4Y04vM0tTZG9aS0FwZDgxZlNV?=
 =?utf-8?B?dytQQ09hdGh2QTNTSVdVTnFVcHd0U1JUaWNLR3BPRXB5a1daRTBrT3c1bm1k?=
 =?utf-8?B?bmhkY1dudmdobml3SEFtbWdLL1pRN3oyemVYdWZwZkt5RWk0T042Y1FxNXhO?=
 =?utf-8?B?TGJ3ZXRscFp2akxacFZKWVNWWUFSNVE4UHF6NEc4K2o4ck9CMVBBdGhaWHU5?=
 =?utf-8?B?NWIyOHNUa2hoakJsUlpJMzRZSTJwOVVLY0tBbFpIbFBXdEJEc0Q1R01na2dN?=
 =?utf-8?B?OG1HNmZlSEJFQ2d1cjZUaGp4Slo5S3NGd2F1Vi9UV2Z4SjUyc3Zrd0JubFZE?=
 =?utf-8?B?V3RCUy9tdE5mYi9QR2syN1N2OC9pZitLa1B3YXBMMk0ra0UvSTZUdkMvTGJp?=
 =?utf-8?B?MVp5eFVzcEpkZ25maEJBVk9pKzg4R1d1R2N1TjZDcTJOQ09WZFZvS0t4SU8v?=
 =?utf-8?B?cUU1SFAySDNEVlVWci8wMzRjMlcrUVppb0VlQjRuZkJBOC9uM3VYQjNicW5O?=
 =?utf-8?B?M0Z0dnVrbEVCTEZ3YTFDS0Y4Nk9PTUk0Q1REcXRuVytwTlZ3NHNlVHdBY0xO?=
 =?utf-8?B?YUhlN3Nta014K01VSTNxR1F4Mjd3NFV5N2YrNjVpOXUvaEJwVnFLNFFiTThu?=
 =?utf-8?B?LzMzUy9sSmJYNHd0TkRNbGIzMnhsUlU5M3hjdG1XUzB3VEkvUFlvM0tBeXpx?=
 =?utf-8?B?alBZdU1LZTBHczJQaHZZYVd2blF4K0V4c0FMNnp4bElTVmM5R2E0R3dWaVhl?=
 =?utf-8?B?cHdYQzdScjVpdmtqRFUxVTNrZURBcU9JeDFRdXE4YWVsRmh1Qm81VnU5VCto?=
 =?utf-8?B?a1lFWFlnbHMrZGY5bERPSDNTM1VjSTBiZTBkY0dDNDg5M1JkU0JlMXR1TW9j?=
 =?utf-8?Q?6z4UvB1dX/KgcE2HGvaPHa68Y0G3Pc+0rGBWMqJ2rLXO?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F36B577F4153854EB0EC86C01A393A24@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 516052d7-442b-46cb-e380-08de1a812dbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2025 02:32:05.3261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FhLBDXAoDUqTHH4txXQ9TX2WydRx8lA7c3VenT5o8gyauAQi8fwaZUbe+sxtF7Teweea88s428Oy3bcmL7WxVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999085
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251102_183210_899944_36EEDE31 
X-CRM114-Status: GOOD (  18.59  )
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

T24gMTEvMi8yNSA2OjI0IFBNLCBBbGlzdGFpciBGcmFuY2lzIHdyb3RlOg0KPiBPbiBNb24sIE5v
diAzLCAyMDI1IGF0IDEyOjA14oCvUE0gQ2hhaXRhbnlhIEt1bGthcm5pDQo+IDxjaGFpdGFueWFr
QG52aWRpYS5jb20+IHdyb3RlOg0KPj4gT24gMTEvMi8yNSA1OjQ3IFBNLCBBbGlzdGFpciBGcmFu
Y2lzIHdyb3RlOg0KPj4+IE9uIFNhdCwgTm92IDEsIDIwMjUgYXQgMTI6MDXigK9BTSBDaHJpc3Rv
cGggSGVsbHdpZzxoY2hAbHN0LmRlPiB3cm90ZToNCj4+Pj4gT24gVGh1LCBPY3QgMzAsIDIwMjUg
YXQgMDE6NTE6MTRQTSArMTAwMCxhbGlzdGFpcjIzQGdtYWlsLmNvbSB3cm90ZToNCj4+Pj4+IEZy
b206IEFsaXN0YWlyIEZyYW5jaXM8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPg0KPj4+Pj4NCj4+
Pj4+IEFsbG93IHVzZXJzcGFjZSB0byB0cmlnZ2VyIGEgcmVhdXRoIChSRVBMQUNFVExTUFNLKSBm
cm9tIHN5c2ZzLg0KPj4+Pj4gVGhpcyBjYW4gYmUgZG9uZSBieSB3cml0aW5nIHRoZSBxdWV1ZSBJ
RCB0byB0ZSBzeXNmcyBmaWxlLg0KPj4+Pj4NCj4+Pj4+IGVjaG8gMCA+IC9zeXMvZGV2aWNlcy92
aXJ0dWFsL252bWUtZmFicmljcy9jdGwvbnZtZTAvcmVwbGFjZV9wc2sNCj4+Pj4+DQo+Pj4+PiBO
b3RlIHRoYXQgb25seSBRSUQgMCAoYWRtaW4gcXVldWUpIGlzIHN1cHBvcnRlZC4NCj4+Pj4gV2h5
IHBhc3MgdGhlIHF1ZXVlIElEIHRoZW4gaW5zdGVhZCBvZiBhIGJvb2xlYW4gdmFsdWU/DQo+Pj4g
SSBsaWtlZCB0aGUgZXhwbGljaXRuZXNzIG9mIHBhc3NpbmcgYSBxdWV1ZSBJRCBpbnN0ZWFkIG9m
IGEgYm9vbCBhbmQNCj4+PiBpdCBhbGxvd3Mgc3VwcG9ydGluZyBtb3JlIHF1ZXVlcyBpbiB0aGUg
ZnV0dXJlIGlmIHRoYXQgY2hhbmdlcyBpbiB0aGUNCj4+PiBzcGVjLg0KPj4+DQo+Pj4gSSBjYW4g
Y2hhbmdlIGl0IHRvIGEgYm9vbCBpbnN0ZWFkIGlmIHRoYXQncyBwcmVmZXJyZWQ/DQo+Pj4NCj4+
PiBBbGlzdGFpcg0KPj4gZG8geW91IGhhdmUgYW55IHBsYW5zIHRvIGFkZCBzdXBwb3J0IGZvciB0
aGUgSS9PIHF1ZXVlcyBpbiBmdXR1cmUgPw0KPiBObywgaXQgd291bGQgcmVxdWlyZSBhIHNwZWMg
Y2hhbmdlDQoNCg0Kb2theSBzbyBpdCdzIGdvaW5nIHRvIGJlIHNpZ25pZmljYW50IGNoYW5nZSBv
ZiBmdW5jdGlvbmFsaXR5IHZpYSBzcGVjLg0KDQoNCj4+IE9SDQo+PiBoYXZlIGEgc3Ryb25nIHVz
ZWNhc2UgZm9yIEkvTyBxdWV1ZXMgdG8gc3VwcG9ydCB0aGlzIGZlYXR1cmUgPw0KPiBJIGRvIG5v
dCwgYnV0IGl0IGRvZXMgc2VlbSBsaWtlIHNvbWV0aGluZyB0aGF0IG1heWJlIHNob3VsZCBiZSBz
dXBwb3J0ZWQNCg0KDQppdCBkb2VzIHNvdW5kIHVzZWZ1bCBhbmQgaXQncyBhIHNwYWMgY2hhbmdl
IHNvIGhvdyBhYm91dCB3ZSBhZGQgc2VwYXJhdGUgDQpJL08gcXVldWVzIGludGVyZmFjZSB3aXRo
IHNwZWMgY2hhbmdlIGFuZCBrZWVwIHRoaXMgcHVyZWx5IGFkbWluIHF1ZXVlID8NCg0KPiBBbGlz
dGFpcg0KPg0KPj4gLWNrDQo+Pg0KDQo=

