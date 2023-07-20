Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C34EB64DA
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Jul 2023 21:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Subject:From:To:Date:Message-ID:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=lJRScmS/f7RMRWyTzvtSYaBHkSXr5h2CFaycPAXBW6c=; b=an3d7R+tcl6TsR
	dnWtRny6t0Ae8jsQq0BiOydYzv0OupIWY8nRNwRvteeOQvlt6WtcmznUBHiRBKnxF1KFB+7rjZuOQ
	uiCJQflH9u7+n2WWNDMSr/t7EHYSyXL5fhP/5/p7fTps4eFPxj4SMU7wXOJWZbxizwNguwkZByfmd
	Gu9U4mgxpJ/+ccqQqVW13QAIfzGgzZBxPt4eBTL+C5nBQzIzq+Ly3Luzrh/vXesscGx9JAdGu++S+
	bC/1YLYHQ3ah4LTW9ojmmCoyN51eOE+YsqHS//5/MGv8CAtRdhCqda1frTKNAfs4dZCsmxSXCkPSS
	eanqt1DV/GNJg78dpVhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qMb8V-00CFBZ-1A;
	Thu, 20 Jul 2023 21:24:35 +0000
Received: from mail-vi1eur05olkn2082a.outbound.protection.outlook.com ([2a01:111:f400:7d00::82a] helo=EUR05-VI1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qMb8S-00CFAP-1r
	for linux-nvme@lists.infradead.org;
	Thu, 20 Jul 2023 21:24:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QFrp+mgoef1x5GmryIWkw/tlAckh4DvRxAgUPh9P8RpjCM2+V26eW9ozeYp+cfOaiIlpCddLneUhJXfKdH7VyXOsvKqZauuwm3rkN/ccAhxYZvR+A34+UlL8/TeADs/693NjV5X0PdMlSX/dmHo5v1ieaAklYg9Cdxt+UswNp2NnJjuKNgU+0VvEwPdmrSWvPE5YCCBnn8xw8An9EzyAPGbg2Cw4/BTaqMUL/cQVg3n3VQnXn7YLZ8grGazSRie93OqGkST8k+hf1CCRtBtcEs2f7yX/pvTezdlJMVH8E0Br9RmeRVkedaJ9Gg++tJti8N2mxqs+hv++/ryf1KgiEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJRScmS/f7RMRWyTzvtSYaBHkSXr5h2CFaycPAXBW6c=;
 b=UYeeEvvyKrCUJnS78S3EmbIJoTzvf5Mmv4tcnbw7+eYLyuTkKzEiao0ZV7lYLHv1tOL48VjOXF6EZT6sSYS81B2Cbh0zmt42VkKjPouUiJrQxVaQ2pMWd49C8AlUG/n/KmiDwQnRvtMSZC1Atwlj2YKwgKZtsNL5htZ//gmHEbYEaAOoSdme+Y9KxzmCa471dtjOhytL0yq1HjazveB+J0aE1kDq8XDpVHRBUo+18HzY3rx8hu1Aa8fXms2wQhDId4In5g6k31g5n4uJepZvQJiESl8go41EMGjYOJcqCd+Nxf6ZtRL5IWgPfAz3GzAtuElEhpcyks7DhnMd1ZIiDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJRScmS/f7RMRWyTzvtSYaBHkSXr5h2CFaycPAXBW6c=;
 b=J+WlaN3PqAFW8xLkKvVJZ0Ign/Xv8F1nSIMQMSQGyaiTj/zP4lv9UubFKGmcU7p+4VCowu/ehN/XimK/d5JFxGvnXvpTTMnM0aV3KE4wDrb2+NghwZ5kmLGy2lqZmHNmrFe8JwQFJ1XJIgDW0wxlS5D4MWd53VGh9JV/Mohgko1C9LGF+VJLCyjtyLTmf/c3X1OE+Xfj3mGBVrPAo+oAJoAngbYkGUbHt88vMnn4ubBK2j6Em7n9DkJB5Mv1y4AepKA+ydvKYPRNoJQDgDRV3BQvYkYAiU6u5H6S60gVAOOIbwM305OXplS1DlwMZpqNntCt56XbtzrdobSkDjxhtw==
Received: from DB9P195MB1489.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:33d::20)
 by DBAP195MB0891.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:1ca::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Thu, 20 Jul
 2023 21:08:43 +0000
Received: from DB9P195MB1489.EURP195.PROD.OUTLOOK.COM
 ([fe80::5cc1:4946:aa2:3271]) by DB9P195MB1489.EURP195.PROD.OUTLOOK.COM
 ([fe80::5cc1:4946:aa2:3271%7]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 21:08:43 +0000
Message-ID: <DB9P195MB14891E0E72F12377031315CAD23EA@DB9P195MB1489.EURP195.PROD.OUTLOOK.COM>
Date: Thu, 20 Jul 2023 23:08:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: linux-nvme@lists.infradead.org, ming.lei@redhat.com
From: Martin Bayern <martinbayern@outlook.com>
Subject: Failed to enable trace event: nvme:*
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [ygbJk2fcj48IBHiGa+lWefnbaA9itHfEV8ixOqO2r4AiPYEXtsQBFvljArk3MT03]
X-ClientProxiedBy: FR3P281CA0039.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::11) To DB9P195MB1489.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:33d::20)
X-Microsoft-Original-Message-ID: <261238d9-30e8-81b3-54ab-9c1eb855f2c5@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P195MB1489:EE_|DBAP195MB0891:EE_
X-MS-Office365-Filtering-Correlation-Id: fadc4b01-b05e-4b8b-6704-08db89657fcd
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aYp9D+mZN35hWNW9ix88+ni4xcOwY/4bCwSAHDuDORACMDTv/D3DmE2fdaJN5Gi58+YC+zJemPLGINztM7dWatQ3GKxKxenB7SNdz//UoNtHFn0JnXlUtWqZy6WiyNajxGtZDo8Yn6UJy4jQVNvbEufkIEeVRoW3CxrfPyNHGJw0nabdHNT3N/hw/mibLfLQlDR39typAqmf5HuocqDOYZkJOOaeqcpf7rDHhWdWWIvdmtgcLrFGX7pdmnHpOLJA/9v9FeQ6PSFApXine2b4qvf8kEWRvL6375wVJ1mEcC8Axx82+5UEXHS9XMTltXSPkYUru5NEqaI2mdqwfIOYAK3bumgc3aovX2TvhhV8BGsOVMcAdrflhJfXMVN1wqw9VrIIJ7yE6qhAmEggTaWBiO8eZSb4SW/hDCSJv3RISp/1a/6m2c5VBif5U6pI0AeL2Ykn2swdnuW3r04/ci6DBP9dPvtcg0pLVybC6fvxKBrnmthX5k/QhDKWHSREJv37rIRb4mIXf/GytYoK21IR5852JSEUJNAXxKRHTexkB08wMJ4KOasLE9dLGqPF7fOa
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0FHSGJuaE5lR0FLNUxMVVFXcU1Ha083WEFiL21jNkUwdlJYUnRIK0dEVVBD?=
 =?utf-8?B?V2ZBQm1rZnk2elljVkZ0Tk1JbmNWQXZuT2hGa1FCSU44MFA3a1A3MEVFemFu?=
 =?utf-8?B?N3BoSllPZG0wM2E1d2tVY0JjOHZhS3IreXpwcFU5OWowK041eGVTdkd0V3Q3?=
 =?utf-8?B?UGtjSHVLSFNKU3pKMGh1N3lNT1hxRzFkSjBrTWRyVWlVVlRxbmtpa2tjSDFh?=
 =?utf-8?B?ajhEYVF3T0dRZWxneEcvRVdLT3NLbHZlVS80MUVMQUQxUGlQY0NqdThBdTc4?=
 =?utf-8?B?WXBOY0NzQ1YyaWl4WUpUem53VjQ0RzBSYXB3NXZwZndEQVl2RXU2UjhRQTBP?=
 =?utf-8?B?MmJIQmhOaWpMREdOalNlalNkWE1IVkp3U0Z5aExlZDlnenByVmpaU1g4eUtZ?=
 =?utf-8?B?SU5mOG5JUnFoZUVCK2w4dFRIRUJ6amU5VVYzczFycDNYVGJDY0hHS3JsWHJl?=
 =?utf-8?B?anlVODk1STNUdWxzYnJYNm1xdGVSM0toaXlCL09ZSmRBQ0dsOGdWQ1hkUUpt?=
 =?utf-8?B?MlF0akhSSVJqaklySFpUVGZqZGhKVFlwMVhuR3RxTmlZUDBKaHNYL29wR3NJ?=
 =?utf-8?B?ekdLWDZZNTNzNVRnQ1J1bU9EMlB3c2ZraFNDUHVrV3l0dW1aWHdmaXlwYm8y?=
 =?utf-8?B?aUVwUTU2dVJjRDN1MmoyTlZoRW1QWFVtb1ErR2NxY0ZBdjBQWjNDN0JVdkpo?=
 =?utf-8?B?VUhJbnpoUnVQRHlZN0FHejU4SlFrOUV2TDExUENpbGQ0MGY5Z01QLzNDbGlh?=
 =?utf-8?B?THBWQ08wdEZjQjdoZ01WdG5senYwOUpwYVpkTFh2TmZ2QWI0TE9TS0wxNGRZ?=
 =?utf-8?B?cC8rby9maUFTOG9CZEZnMTNXejJ1bE5wbER4czNrVWZSQU1yci9zT3FNS2VC?=
 =?utf-8?B?OWtIdHBiVkRCY1NSR0JkaS9mNTlNeE1LL1RUMFNma1lOY2kvTjVDNjdDbjZx?=
 =?utf-8?B?UDdUTjZhWlhkZjdqNUpMaVVzeERHNDU4UTFUL0JSWmdLYkhYbWFscWlKNTA5?=
 =?utf-8?B?Tk43Sk5zcitTNExCWHZraTdGYU9NWHAreU92QjlmbVJrL2tHd0NvZ1lxY0Nm?=
 =?utf-8?B?K3J5RE5Fb2Z4b1BSL01JQzNPSTFGd0ZqWTR3S29HcFY1eGdPQWg2b0Q5WTZF?=
 =?utf-8?B?bTRrR1BmTUpJSGtoMFBXdUl6ODZEb0FNM08rTjZpVk9vY1N2WGRHQldBcE9m?=
 =?utf-8?B?STh6L3Z2Q3dXditqMUxTZU5HeE1HQnQyZVZtMDQ3RHJhdGM0d2FvR1loME9E?=
 =?utf-8?B?REdiTUFZK1lmRkVTV3c2TFg3enIrYVo0eGZxUld4QzZJWktNaE84U1BRN25D?=
 =?utf-8?B?a3d4QXpYL05BRStpZnQ0ZGg5amhkUEN1b2cwd24xS1hUWnJOSEYxM1pTdm0z?=
 =?utf-8?B?T1hQQUhuQnZKR2M2Qys2NXFkYS85M3BMK1dvVTVySjJRV0wxNUdmL0x6NUFV?=
 =?utf-8?B?QllmSVRScmdiQjNtakw2NlFNa2J5UmFYbzBXRjJqNTJiYXFQMFJPWnBOWkIx?=
 =?utf-8?B?UW1HTExtRVd4N2QyOG9xM01nVks0a1dUODJwejRkTjAwcnphVkR0dzFTdTIr?=
 =?utf-8?B?bXRKc29YdFl3eHJkV2NUOXVWaGxqbXV2Q2tlS2Q5cHYzMHJYdHgvdHhXeUpk?=
 =?utf-8?B?TXFESDlIRkkxUDJpQXozSFVidVpEL1dYZ2dzM2xmWGVlcHZYOHdZTUl4dThy?=
 =?utf-8?B?ZkIwSWhyZ08yWDdVcDBxbytXeGNNNG56czRnT2xaSjMwUnBFWEl5K29DR3JC?=
 =?utf-8?Q?EnhQcK3br1qqF1E/OY=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fadc4b01-b05e-4b8b-6704-08db89657fcd
X-MS-Exchange-CrossTenant-AuthSource: DB9P195MB1489.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 21:08:43.4886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP195MB0891
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230720_142432_625758_D574A436 
X-CRM114-Status: UNSURE (   8.33  )
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

Not sure why NVMe tracepoints cannot be enabled during the boot phase in Ubuntu, I added "trace_event=nvme:*" in the kernel boot command line, but after booting, I get the following error message:

"Failed to enable trace event: nvme:*"

I found Ming Lei posted the same problem on the 2019 Linux-nvme mailing list, but don't know how to fix it.

Does anyone know why?


Regards,
Martin


