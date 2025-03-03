Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD5EAC282C6
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Mar 2025 18:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jeQx5mxBYz0gyqyUNd3YNAwsmy0uTXOOiyWUN20Mn74=; b=30cd1IaMtIGvYSnamLEUUFwuDH
	lqce+zOJ5m+2DWlwvvrqNYnxHyG/O/dgL1JGCiPHR8TCbE/cRguXqLoUXmj5tFY3hTQkPPSPohyJQ
	8DuRtCnmHpmBDbxl7TGZ9QpWrBKG7JO64QBMTDzq17MMI1fu00hzsiEXnNsP1bewAq/T8LtoDPymW
	FP07Ui3na72TfRxraV8EaxuT4SW7OoLWoTE/kiNsBvB5NE+kvVxvUdERxZqkOiG2FbARRl3j4ekOy
	Vc3mZcp4tGLY8jXRUvy550blZV0wuVHyOmO6NfkBxmDwbvGi5PiSy9w3niSHfiZH+dCWd/Hii4/Wd
	AbwYqLQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tpAl8-00000001y1t-2LaJ;
	Mon, 03 Mar 2025 18:43:22 +0000
Received: from mail-bn7nam10on20628.outbound.protection.outlook.com ([2a01:111:f403:2009::628] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tpAl6-00000001y0q-2mUj
	for linux-nvme@lists.infradead.org;
	Mon, 03 Mar 2025 18:43:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h7KkRtk8AOpdHXq2slYdvc76gKV5Gw8JNySqcPyFP6uu0dF+z4kNJvjawG375XBfnE70IWPiBYt9cagfAXSGjthOIhMHJNgm2MInv28dDngekgV45tAuyQkczt5URd2b5LnV4cppugA1G/QMWo5SUn3VGiPDl3fKpx8R+yEkcTzOmozkjIUtGGhuTKh2nCYn2qG7AVm78fDUnNQAslnVnXKSeiQCS94dfWTESngFunCTkgBdTXXuxXNQkukr9ovj4aMeZhZwWJYoVb/53huAATv1qjS92PsL8uUXM0B/gvaSXooGJf5NMzDNf+dQ4rN7gUCsDZ75H1oo5AQPwnQHZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jeQx5mxBYz0gyqyUNd3YNAwsmy0uTXOOiyWUN20Mn74=;
 b=pFYINqmDynj+PRH7JQ2Ge8ILIHS7SLplv5EAWY7ZqQI+PoLlb683ltIf/2JEGJ+APR+QILUulIBW38Zy2KiuuzZPRU2XSdmww+fb3GsDWFb2zrkHNg3L90NRhAyA2CUSjJyrIXFvh6ZrLm2e5Luj4l8BMpqgJ7ASIMFAubyvn7MtD1uGYuHhj5x4Pr2F8eUM2WWA3fIyunes5sEuFC6AE4cKR9k1MdW0pmsWAj/PBXH+VrttQUS3lYgyhxtiNo6fdvo/dJYdVixOoCdIMGbZZNIwnOiB5gsYZti+76zDQHl5pHv8f/POPUxiSI1fq7DvOgZgXWv4rM/FBrXzYe4UVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jeQx5mxBYz0gyqyUNd3YNAwsmy0uTXOOiyWUN20Mn74=;
 b=Coga2igifkQKircDGdCz0hFggviY/UkpZttJV8/pXXGNxHZGbgGnQYYAQ4cAzKYo/d/wI8OxBEjciI+QKbz8M3dAgqZP7NEJDI05cu3PIZAsHlj6+l5WGVhjTLIO0qzqw1klF3V/DbpBB2YX2/4AWTKCVNbSNp9oQXgkB4aoAHKlqK5Bk2x6F1zZDzMEWp05DzmLPKkbUjsebzjTyArbF79ijjfn9a2kCbhEXmHvWKfX4pQp9t7fh7fhvCcZsKYNTAeeHo7qC07EqbZ9/vF7d5XQA9Sk+kjHt2xxr2R8zojyxHhYdkAfcdGCE49PbEjDvrib3i56NImBco2SnTE8VQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DM4PR12MB5817.namprd12.prod.outlook.com (2603:10b6:8:60::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Mon, 3 Mar
 2025 18:43:08 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8489.028; Mon, 3 Mar 2025
 18:43:07 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Dan Carpenter <dan.carpenter@linaro.org>, Caleb Sander Mateos
	<csander@purestorage.com>
CC: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke
	<hare@suse.de>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] nvme-tcp: fix signedness bug in
 nvme_tcp_init_connection()
Thread-Topic: [PATCH] nvme-tcp: fix signedness bug in
 nvme_tcp_init_connection()
Thread-Index: AQHbicTGklO/ict370K7EGYcX8UnzLNhxKuA
Date: Mon, 3 Mar 2025 18:43:07 +0000
Message-ID: <b9dcfd43-6608-4b9c-a5bd-556a8eb08faf@nvidia.com>
References: <0f3be9ff-81a1-4c33-8960-75de2c239ae0@stanley.mountain>
In-Reply-To: <0f3be9ff-81a1-4c33-8960-75de2c239ae0@stanley.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DM4PR12MB5817:EE_
x-ms-office365-filtering-correlation-id: 55b38f71-cf94-4f67-508a-08dd5a833d80
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|10070799003|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?a1A3YzI4WkN6eEtIbklyNWNkY3U2SjErbVBaaEhoRC8yK09NY0pONkpFZVdX?=
 =?utf-8?B?R1hsVmQ1RkJmQmdLeU9FcUZySTZOamdVKy82cnJCazlsaE85RVlpSTFtSjJl?=
 =?utf-8?B?ZTI4eVIzcHMvTmtxYnNTU2ZyeVNWRlg4SWdyYWk3MXd4V2E3V29DSWM2aVI0?=
 =?utf-8?B?ZElsdmUzdll4azhFZFlvZXlGUWJOYTFoQkNOTlJFOFUrd2s3Z3BjUXVta2wy?=
 =?utf-8?B?eFpyb09Qa3RTczZzcUM4UGdNY3VyMStIL0ZZbC9SQUNwZDZPREZWSTBuR1VL?=
 =?utf-8?B?Ui9xUXAxdzFFZkY0TGdpZVFYbnhFRjFWRVZNZ3hVNnRYUzdlNTMraFJKVDJN?=
 =?utf-8?B?VWd5WnY4QTd0c1h6d2VvSlRDNG9JbW1XL09hYUU1M2ZSeDlta0R2UkJVQjdT?=
 =?utf-8?B?N0tLbGoxRldiRktCQjQ5d3lPVXVORlQwRG8wUjNKYTNCckNqNGQ2NHFTWU03?=
 =?utf-8?B?Z0dOQ2dpcFgweitVSjNKa3ExZDcweE5iVzNEMjZFWG4rdVIremtWNU9OcS93?=
 =?utf-8?B?RXYvU0M1MnpCUmhteHhsMVpCOXlMcDV1K0haY0Z6ckJwVllQRmkvSXpXQVZk?=
 =?utf-8?B?NzVibFdrODk5TzNZTzd3UElvUUw2bS9ONU12Q3V1UkxIYlk1YTRhRVBJbWJj?=
 =?utf-8?B?Qk9FbVpGY3hEakdjVUVTUThHWEVtU1VvbDBacjZ6NzBtNGR5OGFlYkZJbDVj?=
 =?utf-8?B?WTlKNzE3MEpYbkNPRXprZFVJR1dMekt3MkJJdWMrU0M5bkk2Uy9aNFRkNEVO?=
 =?utf-8?B?SVNPbVZuQ3cyY3ZheVd4WC9jM2krRUNaRS9qZ01BRnQzMi9yRWQ5ejlnL3BY?=
 =?utf-8?B?K3VNV2VHczRSUTNOT0VIdVpieTc4VFlLV0I0OUJEb2xkWW1pQ3NmSEpiNzdq?=
 =?utf-8?B?Zm1veHJmTlFZaGNqMXZrcnFPd3R3UUFHcEJSdE5HdjYrNkFDaXFKaWk4K3hV?=
 =?utf-8?B?UzBTWDcxTXdaaG96NVdjK3UvcDEybi9kU1NVUkFzdEQ1SWJ2dVpUQjdLY3By?=
 =?utf-8?B?Ym1sekp0MlFqUkt4aytzdTFPaEMvYldpYjJ6V0lFejNlL2plVnEvM2J6RGNp?=
 =?utf-8?B?RG9XUTFFRlFIbE9rWGs2SjJTSTIyMi9MTkJHZC9CeEl6S3NGUU9UUU5TRUM4?=
 =?utf-8?B?c0dqcXhTVUplZmhFc1o4cHhaaUtrR3lwWmo1M0NBUS9LZ3FtSjd1UkdSUmlQ?=
 =?utf-8?B?VnVJU0F2N1FLbWt1cW4vOXZJSmpwWEd3enJsNXJVQlVmWU5DVVQrSlF6VjJr?=
 =?utf-8?B?eE9wZjNSSGhId3NleUZqai96cDVOd283aUo1UnhreVNyekw0MTRwdWU0OTJz?=
 =?utf-8?B?MDRWZ0ZLd1lEY1MvSDFUMjlXZ2k4WEtJdEs4Z210TS9sV0ROSEVsL2F3dFdZ?=
 =?utf-8?B?a3grdHZLRUpoQkhqUWJGRnVQQmRrV2pXWEdNa04xRm9PR0ZlUjRCNGFCcnBE?=
 =?utf-8?B?ZzlrTUtxcnB5c3djQ3VndlEvdFhlMVRUQVZlMHJ3aER1YXI5TGdNb2NWMTJ0?=
 =?utf-8?B?ODZRdE9Ucld3NDJaTHZ3dloyREs1c2NsazlqRFQvSnVJQnNTWklUZEtRZ2R2?=
 =?utf-8?B?TFJTL05hRG9sVGVtZmlkSWd2TTNlaTRmUkJZamdmNURQRzdJanNlbnN2UHdZ?=
 =?utf-8?B?ekx3TkU1VEtXS2svU2Zib3Jndkh1aTBiSkxpcHJvVGlYcXEzK1dHUExySG1X?=
 =?utf-8?B?UGNhQ2RmMmFnTnBUbHJKZ05vb1R2Ykp5eUp1cTE2eS9wN1krL0ZvcEs0dWJh?=
 =?utf-8?B?MGtTNTg0NG1FdFpNVStnTzJKLy93cEpzRXI2VXpsNDVTeFF3V25MRUJRQnh0?=
 =?utf-8?B?NFE5WUxoSThUVTIxUEdGWWRNNHZRcmNxRXU0bHpVcXVFZzVFTUxHRmgyUXdC?=
 =?utf-8?B?ZlkyRXZ4UkNJaWtXN2ZCOHZYUzM5WXowL0c5bTVkYk9rZHREUHZTckgrZG12?=
 =?utf-8?Q?kyzcWA3ZU6M=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ODZ0NmhWVzhtdXJ6RExNL0hzQTBobzhVZTMvRldEQlROUFRLdEFBWStmMnJD?=
 =?utf-8?B?VXFIRXl4aEtRUTRneHBnVlZzT3YrZnNydUQ5RFdCYmVNK3RhU2NjVktQdGZX?=
 =?utf-8?B?cmJRcEdmMUtTTmNTbjVmS01yd2drZ1dYMlBZK3VWcXVydnhTME5rSXNDKzJJ?=
 =?utf-8?B?RWtXNmJkeXBLZ0tIMGFEbmhZdUc1MlE3RlhWVVRvVHJOeXhXSnF3cWYrOUd5?=
 =?utf-8?B?U3pYUE9QUjg4UXU5QzZab21NZmRhTjB3Z1poZ1JRWHRibXQxajRHTHRGenBX?=
 =?utf-8?B?NWlFRVpnWlZaazdnN09RRjl0cG1tRTVCVkR6VVpaRTFRenhuVVNhQ21QT1ZN?=
 =?utf-8?B?YnZWQnhqRUp6N210RFB2ZmxrNWNqTlBOajhaNVJJRThyODJ4RTRmWVE4MEZW?=
 =?utf-8?B?WmY5L3IxWnZsQ1J4MnoyODE3US96WEpIVEhzRVQ2ejBXUFZOZlRNQVBIOVdN?=
 =?utf-8?B?RGd0UjVabmJDWFUwcFVabDBpb0owT2l4NURDTjRYMGRzSk9tZ25PKzN1dmh2?=
 =?utf-8?B?UVdGaHFYaWtpWXZrL2hReDM4c1ZCbXJCSis4YnZDVTNpQS9zVXAvUGNDaFNj?=
 =?utf-8?B?MXgvTkdDdlhCdGIrWW4zWGxkVEEzTnU4SUc1WlNXWU92VGJnMVFkalYzamFC?=
 =?utf-8?B?ZXRqZUFsWmxjTnU2bGJCMDFLNkpRZlBiUUQ2SUFRSEdrTzlkTjRkblVZUkZn?=
 =?utf-8?B?QmZqWkhBTmNiU0hjNDFGS29zdFhqQ042RkRiZFJ6RTJLVjYxTVRZSndlQkNw?=
 =?utf-8?B?WWxybVRidGU0RzB0bE05NjJZYjRrU044VUxFZzhLMzJicmpUcWttaXFkL2dC?=
 =?utf-8?B?QlRpWjJmU3MyVHFsOWd2dDYyRDcyY2ZqbENsVUl0NEgrejRKY212UGdkODFl?=
 =?utf-8?B?UklFSEZ1ejdkaWs5UHVxMWJuaVdSc2ZlT1pUMm1uNmVRRWl4RW1lSzlVejg3?=
 =?utf-8?B?dXBURWZXZVNEVXlOa2piekQwMm9CVk9VQTdGMkk2VDJ1ckl3bjl2bElFRS9q?=
 =?utf-8?B?cGNuTTloYUtEQ2pUVU5vSXBIcit2c3FPNGw5dlNHc1RLck9nZGZxVDlyNVVZ?=
 =?utf-8?B?VG9DemNtWUI1OUZ4MDc3c1A0Mml4T3dOUzJwRWsyTmZQV0ZpQklvemQ0Y0R4?=
 =?utf-8?B?aFJYczZVcitpOWZPbVJLbFMzb2p6S2NDLyt3L2xnN0tETkptNE82SEFLTjNN?=
 =?utf-8?B?QTZKWDdpUVlOQUtJSjI3ZHB2cnF2MjBrZ2lqVFB3VmdLQXBYT2dUNmlHeWdY?=
 =?utf-8?B?VGZqZ0RNR2x5TWpRZjYxZDFneFN2MDlsOFVoRjU4NFA4VTdHbTlydG5LS0NS?=
 =?utf-8?B?bVhrNlptMW5iV2NFL0RPYXVSZWI5TnNqczl6S0dvNUx4czNNRXRrUXJSRU5Y?=
 =?utf-8?B?SVZ3U3JsQzVpYXFackZaTVYrNUFLQzNONTlCTURKVUlaU1hhRnN4Nit1QlZO?=
 =?utf-8?B?VWE4TXRRK1RialhlS3JXUjl0NnEvUWtVMWE3MHVZbHZRVFlkUk5uS3Q3VkVG?=
 =?utf-8?B?OTUwWFRGRjFKbmsxa2NWanhWVkg1ejVXQ2dnKzhYQzR2d1ROOVBVTEhWcldk?=
 =?utf-8?B?dWtIN1JwdjhVemhSbmRpb1RuUzJaL1RHZ3N1cWwvVkwyRDMza3BzWEVleTB1?=
 =?utf-8?B?UWV0TWhEY1ExcldBUHRnNk03Q2ZsR0NYTWZ1S2VLRDQzRkwwZlptUWlpdEF2?=
 =?utf-8?B?MjF2UmRWZDloTFV5Z2gvZFpDb3grNzRQdmNkbWs1WDd3eUNaanJDN3hwd1Vr?=
 =?utf-8?B?eEhHazV5M015MEdvZWlWUkd1L2ZSaGNVdWRDNnNLcGFDVkpKTWQ3OVhtTGNE?=
 =?utf-8?B?bXM2c3FCZzE1T0krcWxycjZrQkE5WTB2TUtCZTVPUzhBeFVncFBWcCtaWktv?=
 =?utf-8?B?YVpqb3FmbDV3a2JkWXVsT1k0WXB6cHdyNWRoWUJsaXdWUHZtTUpPRWZaaXlx?=
 =?utf-8?B?T2JUUTM2cUFnOGVRVlAwZFdQMTBhaFRHc1ZIT1h3SEF2WE5oRDNYNG5mSnBn?=
 =?utf-8?B?dDJFdit1WmY2c0dyTFJpWXZJUUpPckVvM1Y4THdiYnZPcm5mUUFOK3FZYkJt?=
 =?utf-8?B?UEwwZVJKS2dRWUtkK2VmN21mdU1aN0dwNDlaRHFoR2JRTFZRNXRGV1V1ekk3?=
 =?utf-8?B?ckpya0lraFl4YUNTaWMrVFdQUWVna0p6TDkrdmEzTmEwYnpwa3NhZWJTc21D?=
 =?utf-8?B?Snc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C4B063EF61776942B71CBFD3C725B279@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55b38f71-cf94-4f67-508a-08dd5a833d80
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2025 18:43:07.5016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kO+HsKuoHzBwmqtrKwMfudzThBj0oSPdUJrKoqvcNeCMKGepz/IFdB/Bsspbm6I5eLbVsXU3SoPIoBaD4tcXaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5817
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250303_104320_701597_08713AE5 
X-CRM114-Status: GOOD (  13.08  )
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

T24gMi8yOC8yNSAwMTozOSwgRGFuIENhcnBlbnRlciB3cm90ZToNCj4gVGhlIGtlcm5lbF9yZWN2
bXNnKCkgZnVuY3Rpb24gcmV0dXJucyBhbiBpbnQgd2hpY2ggY291bGQgYmUgZWl0aGVyDQo+IG5l
Z2F0aXZlIGVycm9yIGNvZGVzIG9yIHRoZSBudW1iZXIgb2YgYnl0ZXMgcmVjZWl2ZWQuICBUaGUg
cHJvYmxlbSBpcw0KPiB0aGF0IHRoZSBjb25kaXRpb246DQo+DQo+IAlpZiAocmV0IDwgc2l6ZW9m
KCppY3Jlc3ApKSB7DQo+DQo+IGlzIHR5cGUgcHJvbW90ZWQgdG8gdHlwZSB1bnNpZ25lZCBsb25n
IGFuZCBuZWdhdGl2ZSB2YWx1ZXMgYXJlIHRyZWF0ZWQNCj4gYXMgaGlnaCBwb3NpdGl2ZSB2YWx1
ZXMgd2hpY2ggaXMgc3VjY2Vzcywgd2hlbiB0aGV5IHNob3VsZCBiZSB0cmVhdGVkIGFzDQo+IGZh
aWx1cmUuICBBZGQgYSBjYXN0IHNvIHRvIGF2b2lkIHRoZSB0eXBlIHByb21vdGlvbi4NCj4NCj4g
Rml4ZXM6IDU3ODUzOWUwOTY5MCAoIm52bWUtdGNwOiBmaXggY29ubmVjdCBmYWlsdXJlIG9uIHJl
Y2VpdmluZyBwYXJ0aWFsIElDUmVzcCBQRFUiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBEYW4gQ2FycGVu
dGVyPGRhbi5jYXJwZW50ZXJAbGluYXJvLm9yZz4NCg0KVGhhbmtzIGZvciB0aGUgZml4LCBsb29r
cyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNv
bT4NCg0KLWNrDQoNCg0K

