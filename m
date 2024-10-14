Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17557CF259D
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Oct 2024 06:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QcV5kFCNO0IA2Oap0xWpmHrKQkbF5AW7LNtF0sFoSkM=; b=XO+BJor4OfLUUjab8/6/J2dR2F
	D7h9nDyxMcYvgIQVTBGwFVEzH8yzFS5tOdlqnrhL3T3LjEea+JePDJIZZGwHahKTZFhUrGNCSxZhy
	sL6yp015mX7KB6Jn0T5p2YvuDXiDM2+pg1Xbk5xWuludfJqymkFROr8XH6fMeihj/faFyikjciTgP
	R9OEPc+Wvf1aCK64opBfxvL1mY1RCKOe7R3TJipgUy6DDi5hFwYvwCshcvUBdW/htlV7eSbjvTAkq
	amkj1K+HArT6ALsuJ+t6qz3h3rwbEhmlkem9WN/L5HQQxJxSA4sGKwHe57ec/TKUR3TUWhbRkrro/
	HtY3tmWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0EVU-00000003sfF-03tG;
	Mon, 14 Oct 2024 06:24:40 +0000
Received: from mail-dm6nam10on2060b.outbound.protection.outlook.com ([2a01:111:f403:2413::60b] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0EPa-00000003rpF-4829
	for linux-nvme@lists.infradead.org;
	Mon, 14 Oct 2024 06:18:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hycb5g+vRkd5PR5q7lzZOpSwwREDwBcHe5vl/TbF0HFh2d5JG4RKdQ+9CGopCA48vQpV77XIZZk1MVwujWawtetwgFWERl8rBNVwxpm0ZLcnM0EhyrCSdZWI8SVeGFheSEvB27+cBcdlf68IGZLGavWqiCM8IWkqWV7kvsyb9v/cozTFgfVesXDoKiucicCcgzpL86xllKqce8pZF0XF3MK/qekT4Ciuuy0naSETHAUr9sxSiYzu+KzpSZzxKT+Tyes2wqxTYoT7nhkr+fAAL588Nv0txBNiFcbLg/eeFh/hsV+aEfq1281/5GppcJZPBEy9c9J+t2cdT+kKXHos2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QcV5kFCNO0IA2Oap0xWpmHrKQkbF5AW7LNtF0sFoSkM=;
 b=DY0VLB8e1z54HwUy/UIy5abONGhp0m2ShbzKiGzTLeFw6ho+1Z2NfWc9ZnYOGO7DcWHM4FpG4q1sejclo+0/rnL4Ss9SEVbe6zX/fDDjYBgqE87wKj95XuJH8h548q3TDE7yo+TwHy8lrSs+D1vtCKCpRXWQ+UWRg8pCVhy7LMMT+FJvHfqqf+MjZHBxVcesSGUQrcTzRCnpDibF5AZHca0LVvDf2F4Pg9pTmU3qkISg5xg9fbcK35iZlLLg9BiGjvQmagoJyNS8JhFtTp5scgDc9CjJ3v3/S9BzbUPlunpFMNQ2K7Einh5/sMBRLKKENmZL5g6NXpcqh34tsPP6yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QcV5kFCNO0IA2Oap0xWpmHrKQkbF5AW7LNtF0sFoSkM=;
 b=EMz5PHjiBEE49b4bGr5hxX5FPfj2IiLRrwQi5Sz8/Vzu7ATvVME4wCnONkjkSfiDq69u/q+oMAIjzDSMEEEBIkjVkCQ10+ClvWQH+LcUBFg6jK126KXXPnwLgRUp5vxzEFVQJHFcmqN7bFNC61ZOPmOeeASi8Gbie3i8xyhXMTHGxejdezY3rrVL5817ukp9uArp7Ntjj/1mbX68mcmWrLALwxs+wJfT9nkdCcmXuZ1i2532Sxk05UDf9KeU/6AVKxVjC7heTa3mxHWBHj9ZyQuuxKv3MZtL1Kn7u6ACXqi5jIFQ1se4auxk2A5Cu47vq7GVZ8D5CJvgDCGiQwSwCQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by LV3PR12MB9214.namprd12.prod.outlook.com (2603:10b6:408:1a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Mon, 14 Oct
 2024 06:18:29 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 06:18:29 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Guixin Liu <kanie@linux.alibaba.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH v14 2/2] nvmet: support reservation feature
Thread-Topic: [PATCH v14 2/2] nvmet: support reservation feature
Thread-Index: AQHbG4T/H8s1C6KgMkaucjSB6AieILKFpW6AgAAZAoCAAAxKAA==
Date: Mon, 14 Oct 2024 06:18:29 +0000
Message-ID: <2328cc06-0353-4a31-9ff3-6595f9a88831@nvidia.com>
References: <20241011022612.50303-1-kanie@linux.alibaba.com>
 <20241011022612.50303-3-kanie@linux.alibaba.com>
 <11a10ade-fa1b-4dad-9a80-1d1681e8bd0f@nvidia.com>
 <cceb6b00-0c52-4788-96c7-9cc69928fa26@linux.alibaba.com>
In-Reply-To: <cceb6b00-0c52-4788-96c7-9cc69928fa26@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|LV3PR12MB9214:EE_
x-ms-office365-filtering-correlation-id: f325ef8b-0f94-4bad-15b3-08dcec180556
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZXlNQSt2UEdKRnBYeXNoWlk0QUZWQkY3b3ppK1c1dXNoaXowZ3Y1N0NwMEUz?=
 =?utf-8?B?YnJCbTYrTDNLNUpQekdQSFZ4b29sVHJ3c2xQQnNQbmdkZkNwWlVGWG5McnUy?=
 =?utf-8?B?c1A5YXFGMWxuSHdWWXltK1lscmIvTTQ5Uy9XT2c3b3BXTXZKVXdNL0VrQTdP?=
 =?utf-8?B?ODBPbk9HYW9idzFZVllpZUl4RVFPNTdTVEM5dkRyTlpneGtOMkUzNFFTZStQ?=
 =?utf-8?B?TG54VldiYXdPNVkxOFZUeVNmUWxaMWxXRXl0R0N0VWUvWHl4TkZVc0drTmtG?=
 =?utf-8?B?NllHZFZYeStXTzdiWWZMdnpCTVE3VG1QY05iSHFxS0JYZEVpcndBZGl0OStu?=
 =?utf-8?B?elZNdGJFQmVvMlJHTTBSRzZxbmFKTjBJajlWb3JHTjA3VGxnTC9sUHk4SWpn?=
 =?utf-8?B?bll3d1c2aWQ0R21RampGMUZqVWNVSHZvdkFzek5zV2p1RmUrVGZoM3l1eHVF?=
 =?utf-8?B?S1RXRVFvcnZhRHVESjRCZkFyNjN5OFpTVTV5R1QxV0VtMGhNVVpQcUUzQ2t5?=
 =?utf-8?B?cWF5RUpwOWlQVTdZMklhNlhoV1VNQnhCNVcxODROclpWZDRnU3FrU09TM1VV?=
 =?utf-8?B?cXNMVjRja0NldVFwUlZsUVZzM1lHcE4rUDBvQTR6RjBCYlowbThxd1FCdVRv?=
 =?utf-8?B?NTZTWUxpWE9ScGRpUmk0b0xiaHRPSjVGczJEQXhaTjZ3SFluRExSU1lyd1Fo?=
 =?utf-8?B?eGNiQ2hwWUxoa3BwN3hqUXJwQUZJTDRMUG85L2pKWkZqVm90YjhrT3M5WW83?=
 =?utf-8?B?azY0Z2NXcG9XRUwwTW0vbXN0WUV1emZ6VzZ2ZDYydi9Gb2E4cjNuZDhKenkw?=
 =?utf-8?B?SDByTlVWa2xVQk54Ujh4MHJOVXZ3S3dWUk5VbkNlMHVYRkp4b0xuZWYzZVA5?=
 =?utf-8?B?L0pmSnpwNVNZdEM0SWJMKzFWeE94elhCTEsrUmowbklFekpuN0NDMHZpOU0x?=
 =?utf-8?B?ckdqZEZFdDhuKytqcUdydkdHanhsS2pLVUJ2ck1VYVJ3QmFPNERXQXdod2Qw?=
 =?utf-8?B?MUtaSVdtYm5BUkZhdFJNQkhyaWQ5eVlETmZoN2xpUllCbnZmYjBFVkh6bjgy?=
 =?utf-8?B?ZzlaOXVoZ3RFWElrZUpNa09TcXRLb1hhZHFhWncvSG5La2MreHU3TjJtOWs3?=
 =?utf-8?B?MGIyNUh4LzFjb1RUaUNNZmJZTmRyN0Z6L2t4Q1RUTzJPVU1oTEsxU2ExM3cr?=
 =?utf-8?B?TWszSDlHNFJ0YzZFVDF2UUdNVlNBd1lOZ1o2QTZHQituQVIzRkQweGwyQUtY?=
 =?utf-8?B?R2JPbHFiSWdsa3pOSDRaMUhBT2VxZnRMRVZzMXN6SDVxdXh0TXNtbElyTWRj?=
 =?utf-8?B?V000ajdZOFdYYlR0MWwvWUc2WEJxNld4dURxYlJvV0ZSTnFraC93WFo2ME9w?=
 =?utf-8?B?TlN5VjlhYlVtU0R2T28waEdLV1JlZzhaMnNEdkdxeGwvVWdIYXZEVkhybE5y?=
 =?utf-8?B?czJBL1hwL2JVWStiNzBTeDZDWVgrTUQ2K2QwWTFCSU5zUWhJbE1hQjlVdk45?=
 =?utf-8?B?eWxXWG9GWkRmcXo4WmpyQkFUaDd6S1ZlRWczYVNOWWh5SHI5U0pYbXZRaHlx?=
 =?utf-8?B?MnQvLzlxcC9rYTVlZ3R2b1l5ODFGWUFBTGV3LytxN3U3QWU3VjBzYm1sZ2RN?=
 =?utf-8?B?RDJNYlRqUk5tN3hoc3B3eGlYL0xTQ1RKa3Q4cVVIdEhoZU4xOEY1aDJnVTd5?=
 =?utf-8?B?OWU5OHZPQUF3d3dBTmI1MnFNSEpLREN1UUdRa2NqQkRKTldSclJEdkZqOW1n?=
 =?utf-8?B?RUN6NmR2VGEzV05mMHNPamwvNGxKaGQ0R0g3T044bHJRKzhhN0lQdGY1QkJh?=
 =?utf-8?B?MksrVlVEc0FuTzdUYVJSZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RFpmNVg2amdNeGxCN2tGUXMxQ1VNM1I3VStjNDlISis0MFNaZzJmNEFvS1hy?=
 =?utf-8?B?Nk40djNPejRkOHpKUFdScWIwZk0rWHkwdHM0TExkMy8vL21XSkRUV0VhVHY2?=
 =?utf-8?B?TmtQYWJWMXVCZHFUalc1Ky9OamFJTExzcG53RHRlN0NrU3dXK0UzendpRmFW?=
 =?utf-8?B?S3E5bHZYMkRlYkNHVXgvNUV3VWJMYmh4SmtDaGFLRVI4L1VjUDM3ZUljbGda?=
 =?utf-8?B?akV6dzNkUm5OVXcvaUErbThCWHhYNHhXTU40ZXpFZEFFZjNndUwzQTdTL3JB?=
 =?utf-8?B?NjNkcllEeHhyV2V4VStHUjFWY21ucE1Uc2hNTGtNajZEcktONU9HNGF4OHcx?=
 =?utf-8?B?SlBWaWV5TlR4VVpRRElpOFpXVGdQSWg1bGZTdnBjb3g2SnEvWVFXbW1ndEpC?=
 =?utf-8?B?T05VMUdBeTBoSmplazlxZ3FqUmNCVm1VRk5wNlN3NEFGa0h2MXJnRGVNdXdz?=
 =?utf-8?B?SDhaay9PNVM1RHhtcFp6UldJWkh1enA3Rkp5aHRkdGE5WmxiSGtoWjgxQU9i?=
 =?utf-8?B?dUJOUTJFQmZySnJzRnNnRHhXUldzV0RyZnJtRmkvNk4wRUxBZ1dIbW1PUm1h?=
 =?utf-8?B?bUdIU3c3bUxBY2RPVjgwMllnWmMvMmxCQ0EvTWMvV0IvQ3NJUjlXQ3JzbHd6?=
 =?utf-8?B?RDJ5UlVKUGpLVEY1R3B3cU84bXU2dnM2U0MyNGt2OFhLY3V5ZmhxVjdFTERH?=
 =?utf-8?B?eVZHQUppZGxsT0dQQ2xSSHZxbjhQaWxlWE5QdDl0enJXZ0E5dGJGWnNPQzhK?=
 =?utf-8?B?YUNVTlF6cFBGWDY2Y3I4SXBpVEIvZ0x6c3YrTG81QllLdFB6cDhWZURtRHM3?=
 =?utf-8?B?dVZyeGFwRzg2M0hJUU9BMU1mUDhleGZGUkpudWlEUUFaRkUycE02OUgrMTZj?=
 =?utf-8?B?WHIyZHd3UUt4NEg2M0R5MlArNGliZkdVbDYvMXNFT0hsSUQ4QmVEZUx3RWd0?=
 =?utf-8?B?Q3IwbDRnWTIwN0RTWnVVZkJVcEVjcTVObnNjV2s1Rm1QclBEQi9RYm1TNVV5?=
 =?utf-8?B?cE9VYWJkTWNkWjZvRmF0M2FXTHE3bE9ZZm9BMmhpSENWcGZSSjlSK1oxd2JT?=
 =?utf-8?B?cU9NTzVBelY4WUsxZktJZUs4TjNzbVJ1dGt3MHVmUzdVR1YwTE1OaHY5a1Jl?=
 =?utf-8?B?MVZMNS9qY0dKQUNlcWlST0tCSlJ5Z3ZDRU9zYmFNSnFicEc5YmQrbnV3ejJC?=
 =?utf-8?B?WHRGT1p0Z1FIVm4yY1RHMWlyZHlxYUx1Y21ta3F6c2Z4NWczcDloK1kzVzdQ?=
 =?utf-8?B?Tmw3bndwY3NkRVVsNjNvY2RzSkI2OUlVTkN5NTFhU05YRjNucHZHdjBDUXc4?=
 =?utf-8?B?TXVoeEZ3RmRoZXFhU3dxWjZLLzVSUmEvVEhpdklGV3owQ2Y0NzhUOVVPMVJ0?=
 =?utf-8?B?U0NzRU5OTVNIcjRYN2MvekwvVkUyUlhGVlFxZXhaUlptbjljazJqZFAxaHRy?=
 =?utf-8?B?ZnJGeFlTWHZ5bEpsek1lSWlpa1F5cU1DSHlCTlRDWHBYK2R6U293d1p4aXk4?=
 =?utf-8?B?RUhxa2MrQWJHWU1Ia1VKZGc0aUd1NFlFRC9Rc3B3TmxVajR1TVo2Z016cjdW?=
 =?utf-8?B?SlFERHJqMmhOL3N1MGhXM0lxbS83ZzNUb3VKOTV6MHFMWTNLMytONTMrbTBG?=
 =?utf-8?B?ejc0TmNFc0xQYXpyaENTRmdTaHM3a2dYa1g4WmFuWEdwN0JRbkhqais5SEtI?=
 =?utf-8?B?TVFUcjY3V01QYlYzTUhJbFBNUUZlQkU3YWFBLytFYUIrUmg4NjNQK3hYMDBr?=
 =?utf-8?B?ZkM3eUE3dk5kOXBhZzZmTDRzZmFKWkJaUkJ0b1l2NVpHY2M5UURWbEhjTkhl?=
 =?utf-8?B?WlhCUXcyaHZld3dzd1ZDeVc0YXF5TlJYODN5NS8yaGV4bHZZcmRjWUZURnpH?=
 =?utf-8?B?RkV2anpSbm1iYjYwMGZJY043bHRtVVBhWlBYaHpOYnNYV0s5c2pzZnovMnAv?=
 =?utf-8?B?bXRBOWp0ZHFPUFYzT1ZYRUFhZ0JwczlFY2xSbkcrVFMvN0FQUUc3eFFYRGpK?=
 =?utf-8?B?SXU3NFI2cUhpeVd3WHZYZTBuMWpCUUFVTHB1RS9SckE1dHVxZnl5MGFaMy9u?=
 =?utf-8?B?c2dVTG14L2JwbTUzMUw5UzhJVWJWOC9IcjRxbnZYV1dkYWJWbTQ4UzR2YkpH?=
 =?utf-8?B?Mkx1RXcveVVRb2RsYzFyOGh5TWhramdNY0xOcGk4dHpIZlRTeDJ6TWdHMUlV?=
 =?utf-8?Q?fsRKEw5onWYzz8YoUSgyAuXPMzxuFWBkhaLiLdouvTu4?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <19450DBBBC370348B5C204CA7DB5505B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f325ef8b-0f94-4bad-15b3-08dcec180556
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2024 06:18:29.2334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EX/57l0I5Vhe2F3cHi1vm7z71fD6JoeU1lg60+ELy1IBwhcupdgKOQcf/F7YRFjUuQ/j18BY01ZUZTjC3hPJ5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9214
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241013_231835_050400_867F795E 
X-CRM114-Status: GOOD (  15.30  )
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

T24gMTAvMTMvMjQgMjI6MzQsIEd1aXhpbiBMaXUgd3JvdGU6DQo+IE5ldyA2LjEyLXJjMiBhZGQg
YSBjb21taXQgDQo+IDVmNjBkNWY2YmJjMTJlNzgyZmFjNzgxMTBiMGVlNjI2OThmM2I1NzYoIm1v
dmUgYXNtL3VuYWxpZ25lZC5oIHRvIA0KPiBsaW51eC91bmFsaWduZWQuaCIpLCBJIGNoYW5nZSBt
eSBjb2RlIHRvIGZpdCB0aGlzLg0KPg0KPiBCZXN0IFJlZ2FyZHMsDQo+DQo+IEd1aXhpbiBMaXUN
Cj4NCg0KTGV0J3MgYXZvaWQgdG9wIHBvc3RpbmcgaWYgd2UgY2FuIGZvciBldmVyeW9uZSBlbHNl
IG9uIHRoZSBsaXN0Lg0KDQpTbyBpZiB3ZSBtZXJnZSB0aGlzIHBhdGNoIHRoZW4gd2UgaGF2ZSB0
byBtYWtlIHN1cmUgYmVmb3JlIHdlIHNlbnQNCnRoZSBwdWxsIHJlcXVlc3QgYWJvdmUgY29tbWl0
IChmM2I1NzYpIGlzIGluIHRoZSB0cmVlLCBvdGhlcndpc2Uga2VybmVsDQp0ZXN0IHJvYm90IG1l
bnRpb25lZCBpbiBbMV0gd2lsbCBzdGFydCBjb21wbGFpbmluZyA/DQoNCj4g5ZyoIDIwMjQvMTAv
MTQgMTI6MDQsIENoYWl0YW55YSBLdWxrYXJuaSDlhpnpgZM6DQo+PiBPbiAxMC8xMC8yNCAxOToy
NiwgR3VpeGluIExpdSB3cm90ZToNCj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL3Rhcmdl
dC9wci5jIGIvZHJpdmVycy9udm1lL3RhcmdldC9wci5jDQo+Pj4gbmV3IGZpbGUgbW9kZSAxMDA2
NDQNCj4+PiBpbmRleCAwMDAwMDAwMDAwMDAuLjVmM2I5ODYxNTMzZQ0KPj4+IC0tLSAvZGV2L251
bGwNCj4+PiArKysgYi9kcml2ZXJzL252bWUvdGFyZ2V0L3ByLmMNCj4+PiBAQCAtMCwwICsxLDEx
NjIgQEANCj4+PiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCj4+PiArLyoN
Cj4+PiArICogTlZNZSBvdmVyIEZhYnJpY3MgUGVyc2lzdCBSZXNlcnZhdGlvbi4NCj4+PiArICog
Q29weXJpZ2h0IChjKSAyMDI0IEd1aXhpbiBMaXUsIEFsaWJhYmEgR3JvdXAuDQo+Pj4gKyAqIEFs
bCByaWdodHMgcmVzZXJ2ZWQuDQo+Pj4gKyAqLw0KPj4+ICsjZGVmaW5lIHByX2ZtdChmbXQpIEtC
VUlMRF9NT0ROQU1FICI6ICIgZm10DQo+Pj4gKyNpbmNsdWRlIDxsaW51eC91bmFsaWduZWQuaD4N
Cj4+PiArI2luY2x1ZGUgPGxpbnV4L2xvY2tkZXAuaD4NCj4+PiArI2luY2x1ZGUgIm52bWV0Lmgi
DQo+PiBJJ20gcnVubmluZyBpbnRvIGVycm9yIHdoZW4gdHJ5aW5nIHRvIHRlc3QgdGhpcyBjb2Rl
IFsxXSwNCj4+IHdpdGggZm9sbG93aW5nIHNlZW1zIHRvIGZpeCBpdCBvbiBteSBwbGF0Zm9ybWNh
biB5b3UNCj4+IGNoZWNrID86LQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvdGFy
Z2V0L3ByLmMgYi9kcml2ZXJzL252bWUvdGFyZ2V0L3ByLmMNCj4+IGluZGV4IDVmM2I5ODYxNTMz
ZS4uMDAwYzgzZmJkYTUyIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9udm1lL3RhcmdldC9wci5j
DQo+PiArKysgYi9kcml2ZXJzL252bWUvdGFyZ2V0L3ByLmMNCj4+IEBAIC01LDcgKzUsNyBAQA0K
Pj4gwqAgwqAgKiBBbGwgcmlnaHRzIHJlc2VydmVkLg0KPj4gwqAgwqAgKi8NCj4+IMKgIMKgI2Rl
ZmluZSBwcl9mbXQoZm10KSBLQlVJTERfTU9ETkFNRSAiOiAiIGZtdA0KPj4gLSNpbmNsdWRlIDxs
aW51eC91bmFsaWduZWQuaD4NCj4+ICsjaW5jbHVkZSA8YXNtLWdlbmVyaWMvdW5hbGlnbmVkLmg+
DQo+PiDCoCDCoCNpbmNsdWRlIDxsaW51eC9sb2NrZGVwLmg+DQo+PiDCoCDCoCNpbmNsdWRlICJu
dm1ldC5oIg0KPj4NCj4+IC1jaw0KPj4NCj4+DQo+PiBbMV0NCj4+DQo+PiBudm1lIChudm1lLTYu
MTIpICMgbWFrZSBNPWRyaXZlcnMvbnZtZS90YXJnZXQvDQo+PiDCoCDCoCBDQyBbTV3CoCBkcml2
ZXJzL252bWUvdGFyZ2V0L3ByLm8NCj4+IGRyaXZlcnMvbnZtZS90YXJnZXQvcHIuYzo4OjEwOiBm
YXRhbCBlcnJvcjogbGludXgvdW5hbGlnbmVkLmg6IE5vIHN1Y2gNCj4+IGZpbGUgb3IgZGlyZWN0
b3J5DQo+PiDCoCDCoMKgwqAgOCB8ICNpbmNsdWRlIDxsaW51eC91bmFsaWduZWQuaD4NCj4+IMKg
IMKgwqDCoMKgwqAgfMKgwqDCoMKgwqDCoMKgwqDCoCBefn5+fn5+fn5+fn5+fn5+fn5+DQo+PiBj
b21waWxhdGlvbiB0ZXJtaW5hdGVkLg0KPj4gbWFrZVsyXTogKioqIFtzY3JpcHRzL01ha2VmaWxl
LmJ1aWxkOjIyOTogZHJpdmVycy9udm1lL3RhcmdldC9wci5vXSANCj4+IEVycm9yIDENCj4+IG1h
a2VbMV06ICoqKiBbL21udC9kYXRhL252bWUvTWFrZWZpbGU6MTkzNjogZHJpdmVycy9udm1lL3Rh
cmdldF0gRXJyb3IgMg0KPj4gbWFrZTogKioqIFtNYWtlZmlsZToyMjQ6IF9fc3ViLW1ha2VdIEVy
cm9yIDINCj4+DQo+PiBudm1lIChudm1lLTYuMTIpICMgZ2l0IGRpZmYNCj4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL252bWUvdGFyZ2V0L3ByLmMgYi9kcml2ZXJzL252bWUvdGFyZ2V0L3ByLmMNCj4+
IGluZGV4IDVmM2I5ODYxNTMzZS4uMDAwYzgzZmJkYTUyIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVy
cy9udm1lL3RhcmdldC9wci5jDQo+PiArKysgYi9kcml2ZXJzL252bWUvdGFyZ2V0L3ByLmMNCj4+
IEBAIC01LDcgKzUsNyBAQA0KPj4gwqAgwqAgKiBBbGwgcmlnaHRzIHJlc2VydmVkLg0KPj4gwqAg
wqAgKi8NCj4+IMKgIMKgI2RlZmluZSBwcl9mbXQoZm10KSBLQlVJTERfTU9ETkFNRSAiOiAiIGZt
dA0KPj4gLSNpbmNsdWRlIDxsaW51eC91bmFsaWduZWQuaD4NCj4+ICsjaW5jbHVkZSA8YXNtLWdl
bmVyaWMvdW5hbGlnbmVkLmg+DQo+PiDCoCDCoCNpbmNsdWRlIDxsaW51eC9sb2NrZGVwLmg+DQo+
PiDCoCDCoCNpbmNsdWRlICJudm1ldC5oIg0KPj4NCj4+IG52bWUgKG52bWUtNi4xMikgIyBnaXQg
YXBwbHkgcHItZml4LmRpZmYNCj4+DQo+PiBudm1lIChudm1lLTYuMTIpICMgbWFrZSBNPWRyaXZl
cnMvbnZtZS90YXJnZXQvDQo+PiDCoCDCoCBDQyBbTV3CoCBkcml2ZXJzL252bWUvdGFyZ2V0L3By
Lm8NCj4+IMKgIMKgIExEIFtNXcKgIGRyaXZlcnMvbnZtZS90YXJnZXQvbnZtZXQubw0KPj4gwqAg
wqAgTU9EUE9TVCBkcml2ZXJzL252bWUvdGFyZ2V0L01vZHVsZS5zeW12ZXJzDQo+PiDCoCDCoCBD
QyBbTV3CoCBkcml2ZXJzL252bWUvdGFyZ2V0Ly5tb2R1bGUtY29tbW9uLm8NCj4+IMKgIMKgIExE
IFtNXcKgIGRyaXZlcnMvbnZtZS90YXJnZXQvbnZtZXQua28NCj4+IMKgIMKgIExEIFtNXcKgIGRy
aXZlcnMvbnZtZS90YXJnZXQvbnZtZS1sb29wLmtvDQo+PiDCoCDCoCBMRCBbTV3CoCBkcml2ZXJz
L252bWUvdGFyZ2V0L252bWV0LXJkbWEua28NCj4+IMKgIMKgIExEIFtNXcKgIGRyaXZlcnMvbnZt
ZS90YXJnZXQvbnZtZXQtZmMua28NCj4+IMKgIMKgIExEIFtNXcKgIGRyaXZlcnMvbnZtZS90YXJn
ZXQvbnZtZS1mY2xvb3Aua28NCj4+IMKgIMKgIExEIFtNXcKgIGRyaXZlcnMvbnZtZS90YXJnZXQv
bnZtZXQtdGNwLmtvDQo+PiBudm1lIChudm1lLTYuMTIpICMNCj4+DQo+Pg0KDQotY2sNCg0KWzFd
DQoNCkUuZy4gDQpodHRwczovL2xpc3RzLmluZnJhZGVhZC5vcmcvcGlwZXJtYWlsL2xpbnV4LW52
bWUvMjAyNC1TZXB0ZW1iZXIvMDQ5ODMxLmh0bWwNCg0KDQo=

