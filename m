Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D80F2C19F2A
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Aug 2022 12:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:Date:Message-ID:Cc:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+fH6wXpnnvDfAF8iMT1u3oqLVAgU7rPAK6kcOOMdnAY=; b=Ko+l8nki0uYl0cf3ucIXRe+A95
	Nn8LiHbwkMuITcbm0SfFfdhM+vbBEdjoxauymB/7AdDUpOjKEVohHtpOFtvtProjJlUmM9e+5Pl7j
	kKCrCYXHV9ryaEVcsqbeyBOK+Cga3YmU1VDsYIM+5oo35lKobkSQWFOZJZJY059HV6hO0HN9DeAM9
	UKFlU6rZQIWWIyicdJv9LGpcBCNmKEcIXQ9QAuJBi1u3Z5J8wEql5z239lacohRT2ylPY9i02o2CW
	MiM7afaoGXsT1QrEiM1KncWEK4BlVTczKHCVxlDDTbBGcuGP+AFgTc+oHWI7byO1tLMqlCqs2DE+/
	2ZQg+rXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIUrG-006NA4-SG; Mon, 01 Aug 2022 12:49:18 +0000
Received: from mail-eopbgr150124.outbound.protection.outlook.com ([40.107.15.124] helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIUk4-006I4o-3n
	for linux-nvme@lists.infradead.org; Mon, 01 Aug 2022 12:41:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fahOtJ2nuiJLeufCQ9ARunX11VbxvUV1b6Mjg9vjP8H+ykBGdA/DgemkqC5rWoox5HXdUj6PG5Swv6GTCEslyGBWGRKGbS4t8f1dAYuwi2FV0Pyv+WdUFUFr6MzwBQCMVmLzXQGZqwiQzSFbEjEhyMHegN/3Bdu0O3sTistZrsaf8ZIivumOoKBNafCnt8Ce3zSZS70IWAGByGlquEd1nBA1mJyA/RzT0sMsjXbHSNT5yg0Ef3joU+S8NMoZVhmcupnPnjN3OW46iyQnsNDmThRwGu5ZwVfV8texf+aXHLtJYCPE/28weq9R3wdugFJRnn24N4VXrKoU/Rk96wv0jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+fH6wXpnnvDfAF8iMT1u3oqLVAgU7rPAK6kcOOMdnAY=;
 b=ZXLS8w4RpzDBKtSjKFLANhsQom/6uipdlT/oOYux7d6/k6RNGIvK66nuocayeGKoT+VIjiFXfzzADsRUUtg4ZKxodTZoM9kNs/5rzsiaiI2gdienY1SQ0HCW1ald268rJasESjlwin7hu/oiwmaSE1t7Wsmwfeo77aae+63O5H9LXaoddMJeLsyZRXBOdKw8w22qyeMssD59mYMps4KO6HDbP8p2V0Dah9+8krsboLmXEIZHwp5azppNTu1VHcEeF6Lr89Sec/tbCradzNsmWNIM4HHGqYC9w5KglrURtbZ8wMaYA1A/MIHNlsA0bnMeylyURNF04BSHlYiC+YodXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.com; dmarc=pass action=none header.from=kontron.com;
 dkim=pass header.d=kontron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+fH6wXpnnvDfAF8iMT1u3oqLVAgU7rPAK6kcOOMdnAY=;
 b=QDINSO9hv+kYasXYh8dDDoYLObRQLD4BjteAFdy+ed2kLy/ijdnBXIlkpQpl7pmcsYLuNZmAiJ9TdFFxdHsEPsbHms9Onn/s9bjHFs8eC7PwQ9fToZANeemqxOdcdc6SLBMq68zKdgv9jZuMlEaUeIcDpvAjJ8OBRgqCATs0/To=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.com;
Received: from DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3ef::11)
 by AM0PR10MB2290.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:d7::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.15; Mon, 1 Aug
 2022 12:41:47 +0000
Received: from DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::88c1:4797:9d1a:97a5]) by DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::88c1:4797:9d1a:97a5%9]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 12:41:47 +0000
Subject: Re: NVMe write protection support
To: Chao Leng <lengchao@huawei.com>
References: <DU0PR10MB62528F66099C2311E2AF1EEE809A9@DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM>
 <90b10a73-4c32-4a84-97b4-88f5a926c771@huawei.com>
From: Gilles BULOZ <gilles.buloz@kontron.com>
Organization: Kontron Modular Computers SA
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Message-ID: <1070fdd5-c1bb-92bd-c5f0-9efd9d88d518@kontron.com>
Date: Mon, 1 Aug 2022 14:41:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <90b10a73-4c32-4a84-97b4-88f5a926c771@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PR1P264CA0001.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:19e::6) To DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:3ef::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0fcae1dc-f760-4473-bd94-08da73bb3268
X-MS-TrafficTypeDiagnostic: AM0PR10MB2290:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	XoWZtufgiuWAz26HhN1Ixtjj9tWvnLa8LBkugsSPrdSJdKuNGiQ3iL867mQBfwOUIE5W8VU7A+LFj4KAGfywmXsIMaF7+t1USAFo+1e8X+tL8LjT9N5wcS1W+2IOxkEIyziGCU+pDBAdQDWN+QtcOMUKN1cGVCS6moBdn+AZW4sVyL2dGHLGGaGaNUAcYoeAB9a+NeaAQgkBF6pppcEY1LOeG5uG/jRg5UGZ3SpDK9LmCINZpkHLCHNlhtu3IfRvhYwkUN/h0Zm2+/l3bZQqcq7L5qZ/mIR4d7kn/Fvfihsk8W0/y6n5XeX1RNLXlNUO2JnVIVh/a9cYwXdjnZbtp//ndVw8Cz4yqaE5CGF0GUo9ngddWRSZZZoJFKbIZh+CemR2Mvco0K3lrJ2EKA53sIA9/mJI6ngfDrpRFgeqTpr+UWu/AHoZlYJxzyedEDZu3EHXyfeggNXxIrJZ11m/8PUErncdrjAVJZfrXHa5GW6sYgPMBqrLenL7uNQfxrdf4mW3++sjlAMrs/igLKok/GmTu0RHq0h44/SMTXGFYnlZTvOB9OvurDvGNCO1XYegZjpSomtg9xt3dHCi7h1OEDIUgN00k77r9BgfgNQHf6++Z5+5AJLY8FvFImP5W1czFoN7G8X8sTmNsUvFze+i6zdLKVMOGleTMCbFjd12dn7gp63clvItaIxuoPnpjizHzxuFtC6JeVIsc/FcJ2QKem2LG1E7OXVVoln8UsZkj8vQMgAGFJpnQBHvzpLQskvnrQXP7XAr+AXFg4+PrOOIznuXUS5H7K1LQtuJ2+3qi01FMTxRlpXSRu02AqUsU5iUDuPnnV1K/UJTKmkBObbB4Q==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(39860400002)(366004)(346002)(376002)(66574015)(83380400001)(316002)(186003)(38100700002)(66476007)(4326008)(66946007)(66556008)(31686004)(8676002)(6916009)(36756003)(8936002)(5660300002)(2906002)(26005)(478600001)(6486002)(6506007)(53546011)(36916002)(86362001)(31696002)(6512007)(3480700007)(41300700001)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?WTlyY0owNEcwdStqNmpRM2ZBa01vSFg4bEhiQnRJaVJ6QWpGV3VDcUhQRlF6?=
 =?utf-8?B?NGMvZ2FJVnBxU3M0QTNuUnVPZnVsOWNvOFk3aGpxdnh4Ry9KZE1BZjlDRFpB?=
 =?utf-8?B?QW5ORUlMdVRsc0l2THBwMXBhMDIxMjQ4QjVtRyswd2dLdWVjNllkVjVCZUlu?=
 =?utf-8?B?bmdHN3ZjeC9MRkczS25nN2s0a1JUNU1POGtScm9VUytCMzArSVQyemNDUHpQ?=
 =?utf-8?B?WDI3eTJLVWlnZEh3V1Rzd2c0VjhoV0FWV1VTajVGZUErNVBUUHhrOGlVcCt4?=
 =?utf-8?B?RDBNRnc0M3dUbTQ3dW1FT1hkQzZ6RUc4cDBOQ3NLSmVqd2RlZEszSmh5Yjlz?=
 =?utf-8?B?aEF1UksrQXJrWEZHc2hTc0RnM1BuYTRnTHNvVWtldnZ2SmwvVFlJVWJTMGxW?=
 =?utf-8?B?OVk4QUVMOGtLdjI2UENzY1JpcmduVWVRMUJHdjZMSFlOTkl1RkV2czNYRjFV?=
 =?utf-8?B?RDJ0QWRhelY0SVByVTMxTVpURXIwQjVWNHQrNVkrOWppMzlmRmF4UFcyMHAx?=
 =?utf-8?B?NC9mTkIrdlZqQVJlQmpDS29VSlVleE0yUkRVRDZ0WmVJZ2NlQkllWnNNckFq?=
 =?utf-8?B?aTlxVjFkMHNDdjEzRTZ2cUxkOXlWenFNQXJhTkF4R0RjMEE5aGdvaGZldzRH?=
 =?utf-8?B?U0FSMno2VzBDd1hYWTBGM1lIY201WC9IQW50NzZzbjk5RFlFaWw4aU81N0dq?=
 =?utf-8?B?NnlXWFdPOE5WSStGbUYxb3RHTUhUdE9mYmJGck1qaktSK0NBRzIrdUM1WWFp?=
 =?utf-8?B?L2xoTGRwczduazBiUUMvdGFxTlpDTjJuZkY5cjlOL08rOVBPamdQWUNmaDRw?=
 =?utf-8?B?RUMwTjlGbk1wK0xwRG16bHFLQkIrNGp6V3RRVzhJVW1INFZtNXh0RUhmMXl1?=
 =?utf-8?B?T01YRStuZnNLN1lQZ3FMa1VyVEJ5MGJldVJNbnBRSzRYRE1iakQ1b2EzcHlH?=
 =?utf-8?B?QjJFQXBYb0NJSXZVcU5NZVhGeFg1UXlLblJnalhqRWcvYktzN05EU25YbkRS?=
 =?utf-8?B?alB2Q1ZLTGwyR29Cb25MYWo1VEl6WFJxUVUwSVhEam9zZVBUUGxOcWVETmJm?=
 =?utf-8?B?MGtncU5kTllzU1MxYXl1ZnZJbzNDeGVXcGFRdUo2VUprZ2YwNUZtazlCb0hw?=
 =?utf-8?B?L1FvSHVNN1drV1hCTjBxWDRaOHJTanZXdkxWVzdla3ZFc011c1JycmYrWXBG?=
 =?utf-8?B?MndmWUJ5SHlKMzI5M3hNa3ZJYXFIalZjUEREZnk1cktLRTBnSWY1RTdLYjkv?=
 =?utf-8?B?ZGlVakVkdGl2NS9nQ2E2aWpuU1NIUDJNSVdKdlg5eDBabTRqeTk5SC9PZmpr?=
 =?utf-8?B?T0RFckc4NmMvRm1hRUZGSGYwd21WZWhuV3FJT2tkeU11eUlPQWdwQ1lWVjh5?=
 =?utf-8?B?TlJiMWRPM2F4dEhleHMzTDJRQWxucklBaWJRMTFYU2x4WkNwQngxakhoL0VV?=
 =?utf-8?B?QnRPd1J2c2F3Z1NkZzZLMi9SYUdDTys0SXZacE9EWndOS3Q0QzZ5TVdKK0FQ?=
 =?utf-8?B?L3d1Z0V6NVBOSUtlckZEL3dFTEhha3VWWmppTVFhbWJ5STRzMFhTWVdxSWx4?=
 =?utf-8?B?eEVGOWRLWlBFZ1hSeHFQdjVXMW1KRlhNZ3pkY1Q0bnNYY3dEMktwYVp1NTF0?=
 =?utf-8?B?OFlIVHZrSHZCcU5za0dGZXpFUVlYdHFBODlOYVlydHBxM0xwa0p4MUN4RjYz?=
 =?utf-8?B?Qk44bGJ1UEU0U1RzN0dGNjFaRTVES3R6OWQ0UVNzaWsxcGpqYllENTlucm51?=
 =?utf-8?B?bmVoOTFMMllabXRKUUhTam9leDV3bVNRTEpwbzhaKzJNeGt0SnBzQUdTQW9x?=
 =?utf-8?B?eU1XMzhLTEZNWHFCRU5wSmIrTHRmdzVUQTBMVGRNK0FpbjArOHJ2OXNwL2ZE?=
 =?utf-8?B?bWdEaDljdlVoMlNhSW5sQWp1VXFQWWd0S2ZhSnlWRjhVOVZCOHJqOG9aWjFm?=
 =?utf-8?B?cUFjVjZEdlVpNytiZkMwekJSb0VuY2lOT2RSdmtDYzZmWlVnQUUxK0xlRWZY?=
 =?utf-8?B?ek85dHNnYjR2SmMzRUxka29ydFNuZ29XUmVSa1JvSnpVUzE5UEJlYzhtN08y?=
 =?utf-8?B?dWlWRGFuaFc4NENidFlzREFZSTkwSjVzVDhuTXNNT1BrRGFKcWFEWmN2N0Jv?=
 =?utf-8?B?aWxiSURKZ3VwQ3VvbnAyenN0U1dHZ3ZkQ2FiT1R6NXZuTzRUMUV5Q0NWUWZW?=
 =?utf-8?B?R3c9PQ==?=
X-OriginatorOrg: kontron.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fcae1dc-f760-4473-bd94-08da73bb3268
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 12:41:47.1757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KohZwyrsNe7Gv2I2cFstXbBQafjzwFY96NZr24pyO+hgShU/49gZkUdq1F/dE/7PkvzpDivabaqeksZobhSXPBnE7rO/sJXrth5fIlq465o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2290
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220801_054153_754490_1D17AB6F 
X-CRM114-Status: GOOD (  16.71  )
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

Thanks Chao for your suggestion : "Suggest: set the NSATTR of namespace to 1 when identify namespace."
Also thanks to Andrey Kuzmin for his private reply : "It sounds like the kernel nvme subsystem is either ignoring or misinterpreting 
the status code returned by the controller in the write completion. Per spec, an attempt to write to a write-protected namespace 
must be declined with 'Namespace is Write Protected' status code (see Nvme Command Set Spec. Fig. 67 for details) which, apparently, 
isn't critical wrt the device itself."
I'll check all this with our NVMe manufacturer

Le 01/08/2022 à 12:01, Chao Leng a écrit :
>
> On 2022/8/1 16:36, Gilles Buloz wrote:
>> Dear developers,
>> In case an NVMe module has a write protection feature, what is the best  method for the NVMe to tell the kernel it is write 
>> protected (if any),  and how the kernel should handle a write to such a module ?
> Suggest: set the NSATTR of namespace to 1 when identify namespace.
>> As computer manufacturers, we had a request from some customers to have the NVMe module fully write protected (fpr safety). So we 
>> asked our NVMe manufacturer partner to add thiss feature to their NVMe. But the problem is that if a write is done to this module 
>> while it is write protected, the kernel treats it as "critical medium error" (giving something like this in the dmesg : 
>> blk_update_request: critical medium error, dev nvme0n1, sector 977537456 op 0x1:(WRITE) flags 0x800 phys_seg
>>   2 prio class 0).
>> OK, no write should be attempted if the write protection is enabled, but this critical medium error is maybe too much because the 
>> disk is actually not damaged and read is still possible.
>> For SATA devices I see that we have a message like that in dmesg : "sd 6:0:0:0: [sdb] Write Protect is off", but nothing like 
>> this for NVMe. So maybe the write protection is not supported/expected for NVMe devices ?
>> Thanks
>> .
>>
> .


