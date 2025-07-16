Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 114FFC83F1B
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Jul 2025 22:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4ILHXA+wfsLiexo6UtTYJ9I0CywrkAB171RoO1Q/Kf4=; b=wbYnN4OHEEs6Zuxf04MYJ7Hdr7
	26I2uOubdQP8ZaGNm5LanlQy73EDBOjER1Pdlf9M2BOpsg/c/MYXhqtJIpTdbW0alG8pNXabPqZZv
	HiAXQ6gIDNFF+O0t+iZmhqtFLg7KUiLfwmJMgIW+5Qt6A/mx7H7i/qgzWCjNywg2mOgH8XocjlbeY
	aNqMcvLFSBCW6AeR9pty9BJ7xiyrngUuBAEZNb9EBqBRW165jEEy0H9dKDcU0X9YWx12lzXkonsbP
	AEItRHquEaAmyLPfjAhhY8hmkYD8kEdFNXTkL6Y5uUf1+aUasGw1nwR8Y88Dk3hfnuiY8/cln4mAb
	yMvOvXjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucAUL-00000008mnD-44KK;
	Wed, 16 Jul 2025 22:20:33 +0000
Received: from mail-dm6nam10on20611.outbound.protection.outlook.com ([2a01:111:f403:2413::611] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucA7f-00000008kLo-0YSE
	for linux-nvme@lists.infradead.org;
	Wed, 16 Jul 2025 21:57:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jpaxNjTUh6ysfvYRM3LqKc+A/GqnF+n5qxHSOwYaqlj5AlKIGtI24YoIOZZU9AOFvNEN9zTccSIj/RDNfdYhFnf2StB/kFJ2OZx9UZQkuJv8mQTpnQrdqACD1jk+d55Y1LgWifqbI779mWWi023NnjoUcPXgKW7LVFoUdUtDEpaTSRab4YUPs1TOTkfjbhmpj2MmnmJcZEJQMdeNbtxLjEq9KvNlS3OVjT4OQG8k/NoZBpNgETU+IaUTOPNQj0QPoQcBiIR4gyUCFRayu9wGbBtbyDBRvBCp4AuH7j8z8wjIymvPNjG1OP8TTRGzSNu4lmrcmCQ3kcDiLMvoWPeZ5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ILHXA+wfsLiexo6UtTYJ9I0CywrkAB171RoO1Q/Kf4=;
 b=hlk5FkV7JfTIcKMaN4wADq85duQVcVoUkSdisWiuxyAdUGxMdJa4CDGRB9bhUQHF064IWj6nHhxaTWqN6UgiEZUpA3/ZrypDzZJB1YyA/IkuSZzcXxUNZwXef814kAmRegbfIGJDiZpoqnM8R2nhHxYkC+Jklw+U9RDGYVwAqXvgbtC1+aUsmTEJHQfH5WgdijzQQYmn0vT1dbCMWdg+fF00Hb8CZchbjCcjr58K/gLakPzqwbi7THR8LvU2+22Mjs/apdtx0X7IPl4j1TboJMfot37o2OXzfy3xRiJac9tm1bleSRBBcvf9fEjnjhX0kdkxcowfU84oYBfTUJdP8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ILHXA+wfsLiexo6UtTYJ9I0CywrkAB171RoO1Q/Kf4=;
 b=EfeNHYD+gw+hNDyY0nCYex92I6/AizJOFV/Yaiwz07AmLSYZmvGjPStqf9rE6aAYdToqDkG2KqKGZIYfk0Dx6aRixeIaODCB70LNlMM4Iv5cyAvpI0jhtfKma2jRudizICa0MquTKfWE49yLhXF993xG9hGa2ZkKPgJxpLeTC66c1/XzYuGzLlgOhmZJ4NxptXiR3ALhwsRBuCqSjR3hCFol31UMvGE0NT3YKsdMvz7K+RgdeaSDki4AXqueNWQymfI5hLh9PUR8E5KkW+krFIfpZIzQ9U3SgPC9SMWdObyCrcQZZ+moqpY5WHGLI4aklC12AoFIKu3rvLZZkin0+g==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DS7PR12MB6143.namprd12.prod.outlook.com (2603:10b6:8:99::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Wed, 16 Jul
 2025 21:56:47 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%3]) with mapi id 15.20.8922.035; Wed, 16 Jul 2025
 21:56:47 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Rick Wertenbroek <rick.wertenbroek@gmail.com>
CC: "rick.wertenbroek@heig-vd.ch" <rick.wertenbroek@heig-vd.ch>,
	"dlemoal@kernel.org" <dlemoal@kernel.org>, "alberto.dassatti@heig-vd.ch"
	<alberto.dassatti@heig-vd.ch>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
	<sagi@grimberg.me>, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	=?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>, Manivannan
 Sadhasivam <mani@kernel.org>, Keith Busch <kbusch@kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] nvmet: pci-epf: Do not complete commands twice if
 nvmet_req_init() fails
Thread-Topic: [PATCH v2 1/1] nvmet: pci-epf: Do not complete commands twice if
 nvmet_req_init() fails
Thread-Index: AQHb9kLp/mgD1AWk3kya1UGpL+lX07Q1TIYA
Date: Wed, 16 Jul 2025 21:56:47 +0000
Message-ID: <ba009e79-e82a-478d-bf2b-52b964141c11@nvidia.com>
References: <20250716111503.26054-1-rick.wertenbroek@gmail.com>
 <20250716111503.26054-2-rick.wertenbroek@gmail.com>
In-Reply-To: <20250716111503.26054-2-rick.wertenbroek@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DS7PR12MB6143:EE_
x-ms-office365-filtering-correlation-id: 5ad4579e-2703-4405-d9a0-08ddc4b3a91f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|10070799003|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UndlWEROVFFrRklOQTlPM09FN0RHWm1CUnVGc3NBL1BXdXNhb1JYVE9yK2Fz?=
 =?utf-8?B?cXhzMmgzNzMvQWY3cG5PQTdhTmJYdHU5OHBBZ0p1MUo4K0R6V1lrTS80SUgz?=
 =?utf-8?B?N2hEYXlxeEd0a2krZis0TFJETmdiclMvaDMxQVBoMno0bUlJSk9qQWlOcjJo?=
 =?utf-8?B?VDR4ZHYrZlR4eXZRT00wcWoxa0Z3MWZqTWs0VnVtRTRORTRLZjlZdEtoazB0?=
 =?utf-8?B?UENORW9qSDZEaDg0QnhVeE5lVHVRMVUwaEVmNk1ueTZvYldSMnF4SnM4QWpq?=
 =?utf-8?B?Rm8yOWpIOTFtNUExZ21Eb3k3a0VOMXZBSE9YZFUzNXpTSmRjMjgvRi9NZitW?=
 =?utf-8?B?eTBBL0xTdzdhNllFS1J2cERRZkhWcmZmYUR0UGNVdnB6TTQvZVRabThEQUF4?=
 =?utf-8?B?WS95UWZESWRWWk9xNEIvNUI3QjZEeTZIUml2ZGRKSTRjcnRhYW03dzdia0Vr?=
 =?utf-8?B?YXd5b1h6MGROUFJ5OWJKS0VGWVBIUlc2ejFvVW5oZVppL2ZzZFhjZGRUWXBR?=
 =?utf-8?B?eEdzSnhTb1V3bE9MMThZWFd6aFMwNm5SellRa0pvRkRzYXJsaG5haVE5ZEhR?=
 =?utf-8?B?dTllU3hMcGFXK2ZIdVdiODE5Z3hOUXg1S3prR241cW1ERzVFeDVrbnlaQ1ll?=
 =?utf-8?B?Ty9UMXBucll5L1lsVTNkQ1lLalg1R2xBZ0luMXNhTnVGSklyUGtETHpsOW5r?=
 =?utf-8?B?OTNQMjd6UjZUVnAzSC9CUXFOWVlEMm5LOGt6Wis0d3docGZRb0FkRzhOelUw?=
 =?utf-8?B?V0RZNmNXWTBmNU85dmN2VjNzeEt0R0dxK3dCbUdvUVpwOTdLQmc2UTdnTTgr?=
 =?utf-8?B?V3BXWjFyMXZ4WEpLS0lTRngxWFd6cnozRVpBemZnNzBodFY2Rk42L0xKYlRH?=
 =?utf-8?B?ejRPdXBBcy9NMnpWNkowQ2NhcXZ1RkxyVGlYSWN2MGdSbnBBaW04dEVEN0d0?=
 =?utf-8?B?Vjh3SU5tanFhYnRjb0ZwcTV2OWR1Y3FndlVpMTg1M0J4RnYrVWZISzZOM0U3?=
 =?utf-8?B?MXVCU2JhOEZ3MzlhMGNRelY5R2dUSTBFUmNpUXdRb1drZ2cwdDZYVUM3NHN4?=
 =?utf-8?B?MStXcTBuVk5ldG0xRk5YSldwSldGTDZKTVZIRmpHVWUxbkJPYk92WnlJbmdT?=
 =?utf-8?B?b3hnRnBSRnNMUVIwKzkvTXhXWGhIendmcUttemNuNlBNcm1OWlJWY0ppQlFP?=
 =?utf-8?B?V2MzdXNTQ2RWRXAxQ1RxTjdidWNRNTZKTy9NR25tTmJoUkRKODhoMXF4MUk5?=
 =?utf-8?B?c2VLYXA0L0FvaTgxbXRJckd0SXNIL2syUjIxck44TnlOdEdCeEJpQVVQaTd6?=
 =?utf-8?B?Qzd5SUpkVFN0L3pmQURyR3RyQkU3TDZPVTNoR1ZFK0J3ckNyRFU1cElrUjRk?=
 =?utf-8?B?Sm5LNG0zeFl1U2UyVWlXdnNBTndYblV5RG8yWXdnVXUremFRdzUyUzd4RU5L?=
 =?utf-8?B?aElTRUVSZnc5dkFWckZnQ200Qm1uRTA0bUZIYVpMR0VVWXJvemRRRUxDNm1N?=
 =?utf-8?B?VndrM2c5RXVHTE1JckYvODNyODE5Q0c3YUUrYVJuK1hWNTM1aDBFQ2o0Q0hP?=
 =?utf-8?B?cWZtU3dGK2RYcWVscC93SHJSRXlOZTZmT04yaWllQy9iY1NObTk4c0tmeEdq?=
 =?utf-8?B?NmNKTlBEZ0xyOFo5YnZabzhvTlgrVU94TGdZMnNUYUw3alhyRDh6YjFvYm80?=
 =?utf-8?B?VU1iNmtoM3NPd3NIQUowakxEeVRxQ0k3aGJOai9RRmkxYkxxQVF2cWN2UmNt?=
 =?utf-8?B?TlFTeUMwWnl4b2lmZFNyZXhWdGZWY1JSR3pESno0ZkJ1REszbEpxQkRaZUZB?=
 =?utf-8?B?OWk3T2p5TUM1RTlhcTh5ZlZYN3hqQVE3VjR0L3hmOU4wMXc1N2VhRFZVZ3J4?=
 =?utf-8?B?VnErSkVaRC9SMzNzK05HaVJJNlM2VjArTldTYkh0V3VmdHd5cDk0UkJGOE5K?=
 =?utf-8?B?YTRXcVp4dHlRL21kMWg5YlE1cytRdzM1V0FDbWgrWjBCNUxPTTBrZmJWaWhN?=
 =?utf-8?B?YTdsRWU3TkR3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RmRtNUVtY2M0WlNLM3BwbkpLcHNodGVzYzQ3cXdDVURueGNvREhDc0t1SDZN?=
 =?utf-8?B?bkJGYUtveGFZcE1mYXJoU1JCb3cvUWluYi9hU2xxTm1xaUhVY2xnNlIvR1Jz?=
 =?utf-8?B?VjQ4blRGc1JNdVhOQzcvMUcwNXRIUC85VHB5UUxtVXQwRnAwV3UxdjJ4QlE2?=
 =?utf-8?B?ZGxKeTVLM3dJRlZ4QzVGTTM2UEN3R1VxMnk0UXVQejFvVTM1VnBiWE54WDE5?=
 =?utf-8?B?OGVKcEVvL2tEa01CZlBKOWRDY0tVdVVDTHRaZ2ZpKzAzS1FQRkhDS1B5U0lB?=
 =?utf-8?B?TWdaT0FsU1pTRHpydkNvbFZmNjc4KzN1aE1YWThRbFJJU1ZxRzFSZDZ4SC9z?=
 =?utf-8?B?dTF6dzl1ZUkvN1B4R0ZnZ2JaWGF3WVA3d1Nxd3RBR0REZW1NQzR4Q2tpWjlt?=
 =?utf-8?B?Nmwwb1NwQXFpMkRpaDdxQTNvNkk0TEs5K3FEMHVrSnJnRENEVExlc0R6RXJQ?=
 =?utf-8?B?NlNkcmZhNUVoMnBQSFp5c0dBSEM3UHc3ZnY0L1JvRzVrSkZLcUsySW1nN1Vp?=
 =?utf-8?B?MXRYclFRMlFVY1piTEdEbVU3QVFnZW44eHVtREIra0RFK0Q4SmQ1aTVSVVMr?=
 =?utf-8?B?M09UeVJNWm92TEpDMUIwdnYzZDhlVGhHOEFMRUh0V0JRTU94ZEQvbko4ZlNP?=
 =?utf-8?B?ZHlmWVp0R0RFY3RwY0MzM0xqdUVLUDFjdnBYOVdvdUpYWFpkenFqcm1BdS9v?=
 =?utf-8?B?aW5TMS9nNnU1L3NhUDBKRnVVWlg1K05MUkM0bTZqejU3dnh3cUlSb0JsOWEr?=
 =?utf-8?B?ZDJkNzV2VGhaT0hxM1NRYnFRajd4MlRkM0pDMFVaWnpuMS9lQ0ZZUmtqUUVE?=
 =?utf-8?B?Vks0SmppM2VWR3pSTUMvTytJUCtGd0tsbnR0NmdNSTEwVWNEcWZ0M3JPV2Nz?=
 =?utf-8?B?TzBGeXo0ZDdWakFzaDZvOHBuM1Fla01BMmNhZk5sV3drSnRWRmJUVFFVZU00?=
 =?utf-8?B?NnJDYWI5cWRJSWxyNTAzSmw2SkE1NE1kb0s1L3ZmQVBqb2pCRjNXdDZORmJn?=
 =?utf-8?B?NDBxTDAyemM3V3R3eWNjcWx3UVlZUW44U0RqalovVFNQNTRuTGczNTUrVHN6?=
 =?utf-8?B?ZGFsOTVnODdWalh2UE8zbnp3d3lGYnFWaXh3RmM4eXc5V3lkamZmU0s5YnZw?=
 =?utf-8?B?anVlOUxOb3loR21ZNG4xdWlKc29Pb2pjK3l3Q203eXIwMW93QWNqU0NUMWgy?=
 =?utf-8?B?VEYvRHZFcDVEZ203RmNHWUhuZ1Y1RVF3RWFTdG9TTkVyRUdlWDljb2RlNTAz?=
 =?utf-8?B?alJJVFZIOWJJQURBcnNZWTZ5eHhIWEMzbVprMmcxc0Ztamw3Z1JRUFN0RVBU?=
 =?utf-8?B?NU9VcU1RdXJ3OHRjU3YrSVV0NzBEa1lyNHdCdlpQT1YyaU9BRlVrMnRnOU8v?=
 =?utf-8?B?QUQvZ1hYSExUOEZXU1lqZ2pxZ0FNNEFlMEhoSGlES2Y1RTVlMDlwaGtDOXMr?=
 =?utf-8?B?WnNsdXNvVTNnVTJaTXZFR0dHZEMxNjArNnFDbzFveExwZlpkaWtOcEEwZWs3?=
 =?utf-8?B?WEZSbWJoV01MZ3BjVENDWVVLVWw1cnRDbFhhVnhBQUV6Z21wMm9ldWNDc20r?=
 =?utf-8?B?bmJTVGNLK0Z5T21Db1F1TnYvS250RkJNRHNkREE4VC9FN2toMnVlcEhZL0kr?=
 =?utf-8?B?UkxCTlV1b3RvVG92ZTBXQ1BHRlBqZy83YUN3SjlPVUF4cTBjVzNlSmpiUkhH?=
 =?utf-8?B?b0gvM0l6TDl5eUpEMlJHU2xGSFBKNWRON3krN2ppTXdpTHpMRFdUdDFvcG54?=
 =?utf-8?B?SThwS1hTQjBmckJ1OGdTekwyMUJNTGJRbDNERC9yVE9Mam5ZZHBkS2VVZjZM?=
 =?utf-8?B?YmJYZWZ3UGcrNjRSTjdCVVhlc0QxVWdHaU94aW1KcG5wa0ZrNUxQUXArd3Nq?=
 =?utf-8?B?Y096bGZGeG5wSG9OdFpEVzFIbHNSQlNIb0E3NldJMGttRGZkQ2FOd2dyVnVR?=
 =?utf-8?B?RVF5cXY0QWc1OTkzYXowT2grWkkxbFpXK3FyTWVLVFl5Q0tmcCtJbFpua3gy?=
 =?utf-8?B?L1NLK0MyWVhxSUhOUDVnS3Y5WnpzanU0TVo1QzVPZEYrbjJTQkIxNkdJU3Ix?=
 =?utf-8?B?RVc3VE1RZFhUN0hobEZSNTJtY1JJSzZjRkdXS2RMYlNzSTg3dkpTakhwNjk1?=
 =?utf-8?B?cGRhaXhBVm9NeWdRTUw1WmVJL3pXWTNLVlhMNXFqUzNaZTVmbEtYZWYrd3or?=
 =?utf-8?Q?SVAT5AukVVglJwvm6pR9W2pB3s8Onii6+BVZB5/q7maA?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FB44D9C3F6554049AC7AA8F5717BF9E4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ad4579e-2703-4405-d9a0-08ddc4b3a91f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2025 21:56:47.1665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CdphXM4YReDnHa6ordrCUTIpMrueSY/z75rbMkHNwhktyRoborZhXdkyZZPTQSWKV3IExTD0tJS7twBVLb2aQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6143
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250716_145707_172764_5A25831B 
X-CRM114-Status: GOOD (  17.29  )
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

T24gNy8xNi8yNSAwNDoxNSwgUmljayBXZXJ0ZW5icm9layB3cm90ZToNCj4gSGF2ZSBudm1ldF9y
ZXFfaW5pdCgpIGFuZCByZXEtPmV4ZWN1dGUoKSBjb21wbGV0ZSBmYWlsZWQgY29tbWFuZHMuDQo+
DQo+IERlc2NyaXB0aW9uIG9mIHRoZSBwcm9ibGVtOg0KPiBudm1ldF9yZXFfaW5pdCgpIGNhbGxz
IF9fbnZtZXRfcmVxX2NvbXBsZXRlKCkgaW50ZXJuYWxseSB1cG9uIGZhaWx1cmUsDQo+IGUuZy4s
IHVuc3VwcG9ydGVkIG9wY29kZSwgd2hpY2ggY2FsbHMgdGhlICJxdWV1ZV9yZXNwb25zZSIgY2Fs
bGJhY2ssDQo+IHRoaXMgcmVzdWx0cyBpbiBudm1ldF9wY2lfZXBmX3F1ZXVlX3Jlc3BvbnNlKCkg
YmVpbmcgY2FsbGVkLCB3aGljaCB3aWxsDQo+IGNhbGwgbnZtZXRfcGNpX2VwZl9jb21wbGV0ZV9p
b2QoKSBpZiBkYXRhX2xlbiBpcyAwIG9yIGlmIGRtYV9kaXIgaXMNCj4gZGlmZmVyZW50IGZyb20g
RE1BX1RPX0RFVklDRS4gVGhpcyByZXN1bHRzIGluIGEgZG91YmxlIGNvbXBsZXRpb24gYXMNCj4g
bnZtZXRfcGNpX2VwZl9leGVjX2lvZF93b3JrKCkgYWxzbyBjYWxscyBudm1ldF9wY2lfZXBmX2Nv
bXBsZXRlX2lvZCgpDQo+IHdoZW4gbnZtZXRfcmVxX2luaXQoKSBmYWlscy4NCj4NCj4gU3RlcHMg
dG8gcmVwcm9kdWNlOg0KPiBPbiB0aGUgaG9zdCBzZW5kIGEgY29tbWFuZCB3aXRoIGFuIHVuc3Vw
cG9ydGVkIG9wY29kZSB3aXRoIG52bWUtY2xpLA0KPiBGb3IgZXhhbXBsZSB0aGUgYWRtaW4gY29t
bWFuZCAic2VjdXJpdHkgcmVjZWl2ZSINCj4gJCBzdWRvIG52bWUgc2VjdXJpdHktcmVjdiAvZGV2
L252bWUwbjEgLW4xIC14NDA5Ng0KPg0KPiBUaGlzIHRyaWdnZXJzIGEgZG91YmxlIGNvbXBsZXRp
b24gYXMgbnZtZXRfcmVxX2luaXQoKSBmYWlscyBhbmQNCj4gbnZtZXRfcGNpX2VwZl9xdWV1ZV9y
ZXNwb25zZSgpIGlzIGNhbGxlZCwgaGVyZSBpb2QtPmRtYV9kaXIgaXMgc3RpbGwNCj4gaW4gdGhl
IGRlZmF1bHQgc3RhdGUgb2YgIkRNQV9OT05FIiBhcyBzZXQgYnkgZGVmYXVsdCBpbg0KPiBudm1l
dF9wY2lfZXBmX2FsbG9jX2lvZCgpLCBzbyBudm1ldF9wY2lfZXBmX2NvbXBsZXRlX2lvZCgpIGlz
IGNhbGxlZC4NCj4gQmVjYXVzZSBudm1ldF9yZXFfaW5pdCgpIGZhaWxlZCBudm1ldF9wY2lfZXBm
X2NvbXBsZXRlX2lvZCgpIGlzIGFsc28NCj4gY2FsbGVkIGluIG52bWV0X3BjaV9lcGZfZXhlY19p
b2Rfd29yaygpIGxlYWRpbmcgdG8gYSBkb3VibGUgY29tcGxldGlvbi4NCj4gVGhpcyBub3Qgb25s
eSBzZW5kcyB0d28gY29tcGxldGlvbnMgdG8gdGhlIGhvc3QgYnV0IGFsc28gY29ycnVwdHMgdGhl
DQo+IHN0YXRlIG9mIHRoZSBQQ0kgTlZNZSB0YXJnZXQgbGVhZGluZyB0byBrZXJuZWwgb29wcy4N
Cj4NCj4gVGhpcyBwYXRjaCBsZXRzIG52bWV0X3JlcV9pbml0KCkgYW5kIHJlcS0+ZXhlY3V0ZSgp
IGNvbXBsZXRlIGFsbCBmYWlsZWQNCj4gY29tbWFuZHMsIGFuZCByZW1vdmVzIHRoZSBkb3VibGUg
Y29tcGxldGlvbiBjYXNlIGluDQo+IG52bWV0X3BjaV9lcGZfZXhlY19pb2Rfd29yaygpIHRoZXJl
Zm9yZSBmaXhpbmcgdGhlIGVkZ2UgY2FzZXMgd2hlcmUNCj4gZG91YmxlIGNvbXBsZXRpb25zIG9j
Y3VycmVkLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBSaWNrIFdlcnRlbmJyb2VrPHJpY2sud2VydGVu
YnJvZWtAZ21haWwuY29tPg0KPiBSZXZpZXdlZC1ieTogRGFtaWVuIExlIE1vYWw8ZGxlbW9hbEBr
ZXJuZWwub3JnPg0KPiBGaXhlczogMGZhYTBmZTZmOTBlICgibnZtZXQ6IE5ldyBOVk1lIFBDSSBl
bmRwb2ludCBmdW5jdGlvbiB0YXJnZXQgZHJpdmVyIikNCj4gQ2M6c3RhYmxlQHZnZXIua2VybmVs
Lm9yZw0KDQpHb29kIGNhdGNoLCBsb29rcyBnb29kLCBJIHdpc2ggd2UgaGF2ZSB0ZXN0cyBmb3Ig
dGhpcyBwYXJ0IG9mIHRhcmdldA0KdG8gaXQgd2lsbCBnZXQgdGVzdGVkIG9uIHJlZ3VsYXIgYmFz
aXMsIG5vdCB0aGUgcmVxdWlyZW1lbnQsIGp1c3QNCmEgdGhvdWdodC4NCg0KUmV2aWV3ZWQtYnk6
IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==

