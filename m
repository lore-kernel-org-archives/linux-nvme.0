Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B0DCD4F3C
	for <linux-nvme@archiver.kernel.org>; Mon, 18 May 2026 12:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LP/t9B09zoVMiHpQnSHUHFVZc7IbgwlnP18Rg5g5whY=; b=NN6SBw4VE04d2Snc81QMPnq0ny
	BS9hfAWZu8N9X/o5VmrkPzfdpBETX20l5LFQkU56y4emUtZGNjd6N05yNjWKqHlCJmPUhGoitW3m1
	A2+hmhIaGJp04w4fF7wOsXvwWbhMew593W0akb2YJLFr5XbKJxCu18cVcYutnXk0r5G8dL+O+rRAY
	uZqtQBy/mECrYygaxq9Kv9hx2i0S0NFmcAgIrHM4PYuLMjLS/aTla/MsXwMs+yJfKtJruINh6386H
	3lmtteRCLO4E6wQGQh1nxHRNmNfoPylvFwby5M3DBiq95NQJxuqX2XrKYIWLASUmVq+G0tHsnkCd1
	8ZHGscZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOx0B-0000000FcM8-3W3Z;
	Mon, 18 May 2026 12:23:19 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOx0A-0000000FcLB-1FKP
	for linux-nvme@bombadil.infradead.org;
	Mon, 18 May 2026 12:23:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Transfer-Encoding
	:Content-Type:In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=LP/t9B09zoVMiHpQnSHUHFVZc7IbgwlnP18Rg5g5whY=; b=jE0ArfAEiNKjse2oe8qri+JblP
	eRLdyJvlnBrh4G91v+vU7996vpEhYKyYFCFsfilYHYA8qilU51ZG1K2W93d9EoU7LvMXTKeMAPUm7
	Rz5TFsfMLggUZhvJaG0eQV35uG99to9pZ146uzH4f5OSuaqlveck5KLiiUjDo7eZGj474gmMfV+IM
	0/iqJTlQZQyhm03uCXEVNn5xvgvO5DQJDOQaACrpr6mDn/clF6l3KhP5Jqs3X4iykeyehRr+7HyCk
	o9UFrPPZNRbO9psfMCXMoRJcWy8FnC9i/V9zNh6im+Y+5CuqQXuPmVPTLpvF9ttnyTwU//zj37M/y
	qhZUhL8g==;
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
	by desiato.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOx05-0000000B7Hs-3K9a
	for linux-nvme@lists.infradead.org;
	Mon, 18 May 2026 12:23:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SPEHvn87lT7w6/eE6EMyu9WUN2tG71aIEsKJs7IC5DOBjiAnSSACPwEk0n2wU6J8qnvNYPo3a3qDqyAbuLBMWwWz3rAa0ZFQloFSv6quJa8QSpjpafKA9kd0qxjJzI7AUY9JlSTLlOkCvIrPAhe6TQNzbZbfGZRBfnAn1YS3u749m8K4Qf8saAztu7V+Bswj11tbtj3vtOFWE5/L0EpHWfwBAOFJEh1JMmOJd4/mS5bO24YBq++fIAdawPGOaBZjkBTQFBIObuJCH8MbS0mB6TDIp2GkQperYmFVUyJgrc2anjVVjtGQQ5Hm8wBuwbtaKo01LHCQlWlz7a+vlpb5mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LP/t9B09zoVMiHpQnSHUHFVZc7IbgwlnP18Rg5g5whY=;
 b=Y5jSzcNn7TbL5oBJ3BptBU/45eLLcAHF8VTsETr6DJbSVrYCn9dtHAp8OmGE9DIiL38CkGa7sTJRxG291UebnQtOovhXJ4vJJfZNVUk8tKMlnmR8YhEznkQ5TQqlybodQN5CmjFtERNyUwk5puXK6GfTUZY7cqKpdmP17LBQqBRBg4Grn+qBcG+DL/vqxNyQD5g5B4HbJmLxvRiHV2JzPvRtIcfahVZF5lnca2GWPhDKQHGwRT2UNOFX+YNmcTvEzyFuF9FGD4T/Pkw37gkY4f9v8toE10adAINayDhWBiozns6MWCrxlgrjyrsaHYRxAb//ZQYw4I8BCP7bN5D4Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LP/t9B09zoVMiHpQnSHUHFVZc7IbgwlnP18Rg5g5whY=;
 b=4YYm0Vt13P8XrqmE0tv1R1S24EB5qluBn5KfzTtIHqnVHXibBJhLv0+bVdH7jDCmCp3nFe1REyKEfjTD8Wp7aHtCla3fSgRFAMuQvIGkLUYg/b+WE/1ap7PVMo8ubj/4l9lMoPpaNNFmVYL/wxMBfSZxGVGO0flcfW6OIPRiCfo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA5PPFEC2853BA9.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.16; Mon, 18 May
 2026 12:23:06 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 12:23:05 +0000
Message-ID: <df697a76-c700-4908-ac08-a47ad07e0796@amd.com>
Date: Mon, 18 May 2026 14:22:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/10] block: introduce dma map backed bio type
To: Pavel Begunkov <asml.silence@gmail.com>, Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, Nitesh Shetty <nj.shetty@samsung.com>,
 Kanchan Joshi <joshi.k@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>,
 Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <cover.1777475843.git.asml.silence@gmail.com>
 <646ecd6fde8d9e146cb051efb514deb27ce3883e.1777475843.git.asml.silence@gmail.com>
 <20260513081929.GD5477@lst.de>
 <24833f76-2289-4859-86d1-9215b11a1258@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <24833f76-2289-4859-86d1-9215b11a1258@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0162.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA5PPFEC2853BA9:EE_
X-MS-Office365-Filtering-Correlation-Id: 45f1adb1-4b12-40b2-2af5-08deb4d83699
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|22082099003|18002099003|56012099003|11063799003|4143699003;
X-Microsoft-Antispam-Message-Info: c5aJkkXEkZVsBeRewdvK/rsYZ2SSoyyiUq0q5OnByEaKqL+/6STlRDM4HGjW/KkvQuHXpyd1EUOryAeZN+R7zwKErRAir/7zz60rjAQrEMcjsQa3otykv/yQk1epfrlr4RGbGVdtBMoudv0DVKs61q6ZKYomWc42AKZG+dgGTXOuQ6S3He0U2HUArAIcMwGDgedUvK/tx4qaOVRy1t3lZ2gItHUZq04FvUeFscC3d0td6OECU4elEpJmKa8YBN5k8lTIdtYe8oHW31ap0FEOmdGSj0yrTxhpfQakj8i/FtTDT/VPDo+WJetkYswaJzrPd8l5CGkf2NgKS98dt2/wZlNoL3kmDMVJU9AkmVFYwYeE8l+dMPgfGx7ct4JVo+xGVppAJKM3SfMvxljUuYHmpGh8vM3mKbTrwVgCVJrhH0087zxCz303m2TRP5XRnm5iXXaNhxlLo3SX7ZHCqIpPvBBQUxn0HYTPNELyxqw6dYV99M5NQTafjXs64gS7rmx40cLVMmIbpn3Poo+q05jQGCYcFVn9zrL2T7+WiacdcNKMfBRL8TMu7LdEA0W2LKpdKr/xxvmMoaQew0alvOt/YbD2RxKNhlglcOporo6R5OlskZyBpN/FzZQ8++D+vEWpBEy3bzSJDCfQy3UBaOywHU5ly/21jM8l4Jor9DrQ3SO2c9rw9tDocgZ05DCPlNxg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003)(11063799003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTlMMFpXUTNyUVBoblRpSlpnL3U4NXNyOU4xRlpnVDRVeEIyZkJGWC9pdEhB?=
 =?utf-8?B?VDZEWUsyd1BiNlE3NE0wK1N5NmJENFk5QktrUDJuVUlBR2dJd1J3eEtaa2lm?=
 =?utf-8?B?aGxLNFUzTGRyR2tqRXhETWUvUzBsMjNLYWFhaFRJK1dkZkNGdENjSEQxMG94?=
 =?utf-8?B?UldVNWM4SnZta3Zjb0hqNXlMclJWKzUxbHk5bnlOdDBiSzEzQW9uS2VPKzhw?=
 =?utf-8?B?MkQzMTFFY0MrdUc3VDBXU1NYUkN3MUZpVVZSQ0gwVFh2UmUyV3BRdGNTUDFH?=
 =?utf-8?B?dDEwd095c1VHMVN4c0k1bm1BczBURkE3VFhSajdYMWh5dXBFVG1JKzhLZWpr?=
 =?utf-8?B?VHE5STZMVjA4Z21yaGJDMUJtbVhjL25DcHphWmIzRlpJVUYxQVNGQ3MvZGlP?=
 =?utf-8?B?bkVRNWdKdXRkUEdRN09ZZlRNemxGUm00eldiLzJoVCtraksvR1p2bjhMMWZE?=
 =?utf-8?B?SW9nUzJzdzQvb3FvTlpqZ3VDbE9EeitpalJlNmJtMXhkY0UwOWpCVWNOOS81?=
 =?utf-8?B?Y1IvbDRzQnVkZk5XQ1dJNUNWYnJ4Um5FSm1oOS9RSmV6WExNM3l6eHdVUVFG?=
 =?utf-8?B?ZGVucjB4TUJzcm5TdFVURE5KaXdMeFI0eVAyLzhHbkZpZHZHdk90N2EyS0p1?=
 =?utf-8?B?UmEzeGlHUzNzZ3dsOXRFRjNDa25tUUtMeFFjR1laSWxpdFVWbjNoaTNXcWpI?=
 =?utf-8?B?SjM4NjdHZVpoL0k5b2plbnd2dllQOEJIRWhoRE94TlpGcW02MXdSQlE2QVQ0?=
 =?utf-8?B?SnQ4NVJGc0lvcDNIR2FmQ0h5aGpWRFpnZHpwSklscGZoUVZBUGUrQ3VFQnRh?=
 =?utf-8?B?NjhsQnZ3TkhVOGIwVHdKUXFxRU0xT2RZdG9ncUszM0JyMEUwemJDYTl6aHRB?=
 =?utf-8?B?RE85MTRFV1EvQmt5U1NuM0o2RGQvS0c2WXVsNVN2VlBFcWJYQjl5aUdYbk0v?=
 =?utf-8?B?SE5HUlhSN2xMd2M0ZDhzaFc0bFhleDNxNmVHdlBISXM5OGE2RENrbzNNRStN?=
 =?utf-8?B?VWJDNVd2MVZGVEhwTS9VRmcxWklBV0NEYXFjSlVqbHd0eW9sUTZxNUlKczYv?=
 =?utf-8?B?TnAyNnF0VlErYTd2eWJhMWtJOW9hLzFMdjlFSXY3ZUlnNnpTSlc2bEtNUkJG?=
 =?utf-8?B?V2xtMkh0MXhoY05naXlTVFU0aEI5dUhSaEFLbDZSOU55SUNVZXFlZE5OdUZP?=
 =?utf-8?B?c1dxOUt6S0FXelkrbURRTDZ5dDRjdlQ1b1RSSE8yUmtEaUpuTTNJcmw1Mmx0?=
 =?utf-8?B?TXRDYUpJbVEvZnpqMWxlWEtjdVRoVWplTmdKclFTR1haUDJCUld3S1hJTkQ2?=
 =?utf-8?B?M1lsK01VOWQrbitIS0lOVEVPNDQyMlI0VEs4eWJEVyszMlEvYnpqNk4vVXVx?=
 =?utf-8?B?ZkRpV3E3SUVrczJZM2h0WTRxSlVQcmswdk1VL2FSRUx0eVFuOE96VkdDMGRs?=
 =?utf-8?B?c0ZubkxWTmYvK0VpZ3dhZEwvWlQxVUxYdEZvUGtWaEI3MW01ZmNWcy8yUzB2?=
 =?utf-8?B?VW5wc3QzbUpqNzN0N3J6WVRoYS91MGVzTDRaNW9yWDdWUm0xeDljYVFvdkJq?=
 =?utf-8?B?N01tNEdCeVZ4MnJDUkNFcXJKKzJPZDJqekhjVml0MWVEZSs0enl3dW9iVXQz?=
 =?utf-8?B?aUkraGhYVUpJNk1BNVQwUHdrRWNFYUsxVFpJVll4QWxjYytMLzBtK2lIMjVs?=
 =?utf-8?B?NFlhTU53YnlVcjRZYzVEbnlxajFnSTkxTjIvZlp4WEtLeFVieElVRHlpWGp3?=
 =?utf-8?B?OUsrZ0VaaGNQamdGalRsN3VhbXUyMmliSnRlRFFxV1JMN3IvOXBIOXZLeVR0?=
 =?utf-8?B?V3hyMnJUS3JKNEtLV3ZXbnZHR2U2aSt5RUlGL1JvNTdkeHBuWUdabmQxc3R0?=
 =?utf-8?B?YmdUSkxXVlJLMXBxS0NjS0QzYTJxNjdmMXNqMEVRUUdZRzE4QWg3YndZSXFo?=
 =?utf-8?B?RGpJOEJlWVptN1AvWGJ2SG5mS2Jrdk9pMlY2Y3lBZ1VORzdpWS9Xa3hXSjdj?=
 =?utf-8?B?Qjc4R1AvTVE3SHlLL3dDUmRFTm50UDhrVlhuS1IvZkJsOGVVU3VKMWp3V0dh?=
 =?utf-8?B?WStOc0JRanVoQ09NVFJaVFhUZ25wOHJsRTg3eTJ0dVgwOXRaZFh1cHQ1RWpP?=
 =?utf-8?B?SmRWZDdrb1RtK1NNQjYvUW5Ma291SWtQb0pBZjZRWno5eHdwMFMxRTZUNjBj?=
 =?utf-8?B?TVhFV0lzV092NHlsaEZCbDd5Vk5vSmE1Q2Y2TDkwbVAyMWROVlYyc3gwMlFh?=
 =?utf-8?B?alVxMldlZVJMQTRURmpxcW5La0tYd3RCd3R2b1BSU3I1MCtPdVpmR2txalJF?=
 =?utf-8?Q?5rqQZeVVhidv5FY1mz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45f1adb1-4b12-40b2-2af5-08deb4d83699
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 12:23:05.7014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1WsjQ8f2zBS5HENcJg3BQedENvqiLG177GgFQXBVXSaaV5GGqPIZx8quYSXn+mwO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFEC2853BA9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260518_132314_214266_55A033A4 
X-CRM114-Status: GOOD (  37.44  )
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

On 5/18/26 12:29, Pavel Begunkov wrote:
> On 5/13/26 09:19, Christoph Hellwig wrote:
>>> +    if (!bio_flagged(bio_src, BIO_DMABUF_MAP)) {
>>> +        bio->bi_io_vec = bio_src->bi_io_vec;
>>> +    } else {
>>> +        bio->dmabuf_map = bio_src->dmabuf_map;
>>> +        bio_set_flag(bio, BIO_DMABUF_MAP);
>>> +    }
>>
>> This is backwards, please avoid pointless negations:
> 
> I can flip it, but compilers tend to prefer the true branch. E.g. this
> 
> if (cond) A; else B;
> C;
> 
> can get compiled into:
> 
> jmpcc cond B
> A: ...
> C:
> return;
> B: ...
> jmp C;

When that is really a performance critical path then you can use the likely() and unlikely() macros to give the compiler the hint which one to prefer.

What could be useful is to have the true path for the more common and the false path for the less common case for documentation purposes, but in that case I would expected some code comments as well.

Regards,
Christian.

>  
> 
>>
>>     if (bio_flagged(bio_src, BIO_DMABUF_MAP)) {
>>         bio->dmabuf_map = bio_src->dmabuf_map;
>>         bio_set_flag(bio, BIO_DMABUF_MAP);
>>     } else {
>>         bio->bi_io_vec = bio_src->bi_io_vec;
>>     }
>>
>>> +    if (bio_flagged(bio, BIO_DMABUF_MAP)) {
>>> +        nsegs = 1;
>>> +
>>> +        if ((bio->bi_iter.bi_bvec_done & lim->dma_alignment) ||
>>> +            (bio->bi_iter.bi_size & len_align_mask))
>>> +            return -EINVAL;
>>> +        if (bio->bi_iter.bi_size > max_bytes) {
>>> +            bytes = max_bytes;
>>> +            goto split;
>>> +        }
>>
>> Please add a comment explaining why nsegs is always 1 here.
> 
> 
> 
>>
>>> @@ -424,7 +424,8 @@ static inline struct bio *__bio_split_to_limits(struct bio *bio,
>>>       switch (bio_op(bio)) {
>>>       case REQ_OP_READ:
>>>       case REQ_OP_WRITE:
>>> -        if (bio_may_need_split(bio, lim))
>>> +        if (bio_may_need_split(bio, lim) ||
>>> +            bio_flagged(bio, BIO_DMABUF_MAP))
>>>               return bio_split_rw(bio, lim, nr_segs);
>>
>> The BIO_DMABUF_MAP check should go into bio_may_need_split.
> 
> Ok
>>> +static inline void bio_advance_iter_dmabuf_map(struct bvec_iter *iter,
>>> +                           unsigned int bytes)
>>> +{
>>> +    iter->bi_bvec_done += bytes;
>>> +    iter->bi_size -= bytes;
>>> +}
>>> +
>>>   static inline void bio_advance_iter(const struct bio *bio,
>>>                       struct bvec_iter *iter, unsigned int bytes)
>>>   {
>>>       iter->bi_sector += bytes >> 9;
>>>   -    if (bio_no_advance_iter(bio))
>>> +    if (bio_no_advance_iter(bio)) {
>>>           iter->bi_size -= bytes;
>>> -    else
>>> +    } else if (bio_flagged(bio, BIO_DMABUF_MAP)) {
>>> +        bio_advance_iter_dmabuf_map(iter, bytes);
>>
>> This is a bit of a mess.  You're using bi_bvec_done for something that
>> is not bvec_done, which makes the naming very confusing.  That is even
>> more confusing than the existing usage, which isn't great.  Also we
>> add yet another conditional to heavily inlined code.  I'd suggest
>> the following:
>>
>>   - add a prep patch to rename bi_bvec_done to bi_offset, as even for
>>     the existing usage it is the offset into the current bio_vec as
>>     much as it is the count of byes done, as those must be the same
>>     and it is used both ways
>>   - add a prep patch to also increase bi_offset for bio_no_advance_iter.
>>     It is not actually use there, but incrementing it is harmless and
>>     this will avoid a new special case
>>   - please also documet this new usage in the commet in struct bvec_iter.
>>   - then just add the dma buf mapping to the bio_no_advance_iter condition
> 
> I'll take a look
> 
>>   - figure out what to do about dm_bio_rewind_iter, which pokes into these
>>     things that really should be block layer internal
> 
> Need to check what that is, but doesn't implement the interface and
> is not supposed to ever see the dmabuf iterator.
> 
>>>   }
>>> @@ -391,7 +403,7 @@ static inline void bio_wouldblock_error(struct bio *bio)
>>>    */
>>>   static inline int bio_iov_vecs_to_alloc(struct iov_iter *iter, int max_segs)
>>>   {
>>> -    if (iov_iter_is_bvec(iter))
>>> +    if (iov_iter_is_bvec(iter) || iov_iter_is_dmabuf_map(iter))
>>>           return 0;
>>>       return iov_iter_npages(iter, max_segs);
>>>   }
>>
>> Please update the comment for this helper.
>>
>>> @@ -322,6 +327,7 @@ enum {
>>>       BIO_REMAPPED,
>>>       BIO_ZONE_WRITE_PLUGGING, /* bio handled through zone write plugging */
>>>       BIO_EMULATES_ZONE_APPEND, /* bio emulates a zone append operation */
>>> +    BIO_DMABUF_MAP, /* Using premmaped dma buffers */
>>
>> Shouldn't this be a REQ_ flag as we should never mix and match bios with
>> and without this flag in a single request?
> 
> Do you mean adding both and propagating it from bio to req? submit_bio()
> takes a bio, so we still need to set it there before it reaches blk-mq.
> And there might be bio-based drivers using it in the future.
> 


