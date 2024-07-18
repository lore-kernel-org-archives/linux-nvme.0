Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96409C3DA60
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jul 2024 12:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ng6OeAlq61WwNcYu8/i5b0hV+7YNBuFZDQH3nNPv5Zo=; b=F/B9W9fwjzb2I5WCziS3ob77FD
	gTm7wFX/hBA9KrwmRhHin22tfD9zN6hovG0GMNArwjtRLnmb1ihSNMoG+60ntKlXlugaZufRLV+Je
	SEUlWakK0SwFcalgo17OPpL15Xy5N+5b1iLZ+ffErQoDScDnE093A9eUYKBkEZGk36iyzUxetTXpo
	AtDwZISBLWgmtRUS57vXCvFUCPqcTqe/1YNTqKB1MB3BDzsWwShMRPrfHyhWCFIBI8p8j70/cwZnF
	/gkOtwivECUX1UvEovd3iDuMVhN1BJ+6uVI/F38zO19g7Jme7F11FAA0HuqS7QqhVRICAoulsh7OX
	da+/osgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUQjQ-0000000H24V-41nz;
	Thu, 18 Jul 2024 12:59:36 +0000
Received: from [2a01:111:f403:c200::1] (helo=DB3PR0202CU003.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUQjN-0000000H22l-3vbu
	for linux-nvme@lists.infradead.org;
	Thu, 18 Jul 2024 12:59:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=muThBjBzxjaVThzP4XS5ZouLR8KFE1xXeyeH2pkxWjWjcoG6d0NdPhtx2G9i/vMEpfWY2fbCy+MqnRb2yeASMRIB2yeKKFS0zgpV10LIUeXY2O4Rx5qXdoYdVC7rSqaqZEqFX6JgFuwC/areEF6d2yfFw3cD5byNiQYwyNXtL4vCpKVDeztzuIisz0XkdrJMe0GpmbMjdj9uR5STYFw1M0r2EOmmSQGSyo+YJqsmB2CMxZPJ+ZrFCv48uAIDXRTgCfqcrI0OcEbGQCMoFEtGkblxAwZ295a7Y6nQuitbL49mK/4ToJqARG0yBaEN+onrAcVoBB1i4cbWN7TZlWkxUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ng6OeAlq61WwNcYu8/i5b0hV+7YNBuFZDQH3nNPv5Zo=;
 b=l+iaU+8JfSdlbRaP37U9Yn9bp3ccPUi5SQQajjTN1ZH5nbyJvQmveewbB7yrfIGhhSp1+vasFRy5QIT4LYDTw05PQI/t1DsHOAHKyePYfCfsTc7UclUYbekWFQVAz5GJEZr1UKYqIuYMg2LMOfYBEfJEyM4x6XiucYJykd9oC0Y4Ekr2BgDzJO7CGfVc/njz/jHh6bx3VentkkEgBnvkiMGrTosFnfQJXEpzyo4YGOWPYkqn8s6Ej3gg8QsC8ziKXeszU2TM+zSqQTCO9dI+R0d2/M+zVC+13juDFBsJfNDts5uqcUDryuUa6+58bwH0W1Kl9PvccPL8XwC/Pc5tCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=volumez.com; dmarc=pass action=none header.from=volumez.com;
 dkim=pass header.d=volumez.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=storingio.onmicrosoft.com; s=selector1-storingio-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ng6OeAlq61WwNcYu8/i5b0hV+7YNBuFZDQH3nNPv5Zo=;
 b=dp2Vsi5Y0CBGras8PyXMfOvZpTqHnCOi9/ynFa6Vj06kyBXUP53oENaqVKuRc/A4drOa+WqWmn+5JDC0CqcSqKd7oHXeMLxyemAN0+0rXVb+a407KUWvTM7D0gem/IOLlatd1/1IdVrKgBGpYQHVOpusafEMB1lQe66w+UgcdeSKBSX117U80/lvHKku8X9NpJP1bevZkbO+NtHKGaiZ5BhjA+vh6J4JFC3PB2reeoqmBjhsOYFf3zn57vxNmigA6RZMechOALD+RASeYJrZ2v+e2Zq9+Pk9ts0bgPeVuDNhXwKxiUY3OwGtGY9Pni+1B3P+Y05eJravrfDj06lqGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=volumez.com;
Received: from AS8PR04MB8344.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::20)
 by VI0PR04MB10926.eurprd04.prod.outlook.com (2603:10a6:800:259::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Thu, 18 Jul
 2024 12:59:22 +0000
Received: from AS8PR04MB8344.eurprd04.prod.outlook.com
 ([fe80::d3e7:36d9:18b3:3bc7]) by AS8PR04MB8344.eurprd04.prod.outlook.com
 ([fe80::d3e7:36d9:18b3:3bc7%5]) with mapi id 15.20.7784.016; Thu, 18 Jul 2024
 12:59:22 +0000
Message-ID: <90d5665a-bfb4-43c1-bcd0-5a1189816b37@volumez.com>
Date: Thu, 18 Jul 2024 15:59:18 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests v3 2/2] md: add regression test for
 "md/md-bitmap: fix writing non bitmap pages"
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "dwagner@suse.de" <dwagner@suse.de>,
 "chaitanyak@nvidia.com" <chaitanyak@nvidia.com>
References: <20240716115026.1783969-1-ofir.gal@volumez.com>
 <20240716115026.1783969-3-ofir.gal@volumez.com>
 <iviiquxyax5ofjcnd7g45wwgbjy7ikikfz5oqdnuz4kf444gno@xpaa42btwok2>
 <f6255383-88df-4aff-97fb-2504108e300a@volumez.com>
 <kumwslbrccrhttvbjqyfznbcem7k5rryasppabgkzx6iw72uyj@rv4uu2o2jtkt>
Content-Language: en-US
From: Ofir Gal <ofir.gal@volumez.com>
In-Reply-To: <kumwslbrccrhttvbjqyfznbcem7k5rryasppabgkzx6iw72uyj@rv4uu2o2jtkt>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0013.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::7)
 To AS8PR04MB8344.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8344:EE_|VI0PR04MB10926:EE_
X-MS-Office365-Filtering-Correlation-Id: 6507e428-03d1-45eb-0adf-08dca72971b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TXdleFlaOUNTU3QyQVQzdUdBZ2p0RWJ1eXJ0UytjSGozQU4zUDBUVXYySkFq?=
 =?utf-8?B?dWtxbU1kek00TCtNVDhoYndjbEk3QVgyaVZXRnNWSTR2RFlLQVZWdHNGaFdM?=
 =?utf-8?B?TXBmZVovdDZGY1A4UFJYV0FBWVRBaU1LRWthb3lkeElSZ1JoQmd0dVB2dWhV?=
 =?utf-8?B?VXNzbC9VZmw0YWJRWTFLcXd2d1Q1a2NmWG8zNjJoSmEyNWhUcG96YnhQUHZZ?=
 =?utf-8?B?WjN1ZjlOcmRCTkh3NzVrV1R2NFBHT1dkZHNWTUMzcEUrc1VnSHFXbHNkclE1?=
 =?utf-8?B?NVFTaGlkVDkvMGFNKy9ueWp6dFVaWUJhbENIc1ZYakZEY0pJQmtFV3JRRlRF?=
 =?utf-8?B?OHR5SlBzQktZaVBFM2oxY1FKdUNsSnlaUkFnUFFNK1lyYnBWOE5vT2JzcmM3?=
 =?utf-8?B?QmtMUDVrWG5sbWdKdGFaSjlDOE05NHc1NzdoTHR2QnBBYU90MHhtSHVlSHVT?=
 =?utf-8?B?eFgzNXVHZ0g4ZzBja2hNcnhoakJRSkVQbThRZ1pWRVg5blZlYkJqOTdoYlJN?=
 =?utf-8?B?NUVub0ErQ3BjbnA1Z0tYdkgvSE1NaE1lQnZRVjB6eW9TR3ZXK3BrWDAwM3p4?=
 =?utf-8?B?Y2xIZWIwQ2pYeGlGM2ZSUmxYWTErdE1nZUtXeHJkM1VNeW8rdXdRNE55ZDhX?=
 =?utf-8?B?SzYxcHpmSlZseTBxVnV2enZTdzhrOTVVTlFYUk4xeGd3QytyRWxsRmsvL2Fn?=
 =?utf-8?B?eldRNWdDQzQxUXhkQXNubWNUeG84UkQxTUVWb0RXMUFkRXBKTDRsdTNXdHk1?=
 =?utf-8?B?ZTJ0QVRVUXExWk5oaHhUOVltd3k2cmtaSm83MTVvRjk4UHpSbE1yN0dqYm9m?=
 =?utf-8?B?SVJEdG9ka3NXRU16RHVrRmtXUGs2YjdmUDkvdmNhRUdWaFloYjNlYkpCY2Ry?=
 =?utf-8?B?bCtKTnhPb0dkRW9QR0pUV2RqL3pDd1NMcFY0WlIvSGJ2RFlvVUs0bCtNaEVt?=
 =?utf-8?B?UUs0SGE1aWtsNkMzUTl2dWtJdW1JVzMvd29ud0s2aG9MU2hKSXNLMTJldytt?=
 =?utf-8?B?SCthcXBTcTVaM01DQm0zS1l5bFQ1SlY4SEJtY3owQ1FQZ21RY1pjek5mK3VD?=
 =?utf-8?B?LzlpcnNvR0VWWVBHNTFIVkdaM0FTREVxR2JGV3M1SkNsOEFiUXhZb1doMUJo?=
 =?utf-8?B?L0NuMDlFNCtKSytXMGMyajE3U01scWQ3cGJIaUtnMGc3cWs1MDV1RXNpcVlB?=
 =?utf-8?B?N3owOXJUMjlraEhFOUsrVkkwZHRYL3hrUUlSbHdLSzVVOEhJWFU2NXgxRG5u?=
 =?utf-8?B?WDBFVFphcUZQM0xQaUQ1VWFIWkZFYTYyMlRHZnVFcHdCanlpK3RMNlZZRngv?=
 =?utf-8?B?RFVzVXhURDEvVXJzMXc3VUFqNW4rVE0ya25jWHlGMFBZTG82UFRmcys4dVgw?=
 =?utf-8?B?UEd6Vm9IY0d3c0x0M3hLanhQVlZBZlRycTdGN29UcTVkYkkwN0ZQWVNDT3N3?=
 =?utf-8?B?MVk5a2g0c3kyNTZFR0xiMmZLSFNhODF5aTBXd3gzcnZmT1RmN1QvdmVqdUZs?=
 =?utf-8?B?ZXJFU0p4VFE3SEpwRDhNdCtDTi9XVDhuRkNDeXB2TUJ1WUtpeXlhaGxKNmUz?=
 =?utf-8?B?aFdDSytsQm5EOTA2SVUxUG9EUFVPTjR0Y1RYWDZZcDI0Y0dGVFY0dk5sRUMz?=
 =?utf-8?B?TXdaNnJ4QjBHWVlMZzJVZjArTmdhNDI1WWZ5OUk5S3VPWjgwSnBxNWtiQm91?=
 =?utf-8?B?ODNrUlArVjZKcE5GdGhNc056QTVwS1d3MHhlM0thYkFMOXIvYjIyT3UyUXY2?=
 =?utf-8?B?QlR4TkY5MklMekJHQTBVeHNvd1JQSGFBRzZGUUk3cXhkcmJteHROQmZraEJz?=
 =?utf-8?B?YW5FMlhUZlZGQnRjTzByZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8344.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGhsemc5cURyQTE1VlhlaHZPZzhaK0NQQ1cvbTFBVE9Lby9QeVExenhKTi9x?=
 =?utf-8?B?K282NzN1RWJjd20vZjloTWFUQXkwbWlRaHJQdWdZczk2Rlo1WW1LajhTTXJm?=
 =?utf-8?B?WEVIRFNjbGhpdGxIcGIvSWNScnRkM1cyeDFJb1czZGNxYjZKT0Z0b1UwTTZn?=
 =?utf-8?B?TU9ERjNybHhrME9WZ0RlTUpmdWdmZzlyb1lUSFR6ZUVsdEp4a0pKVTgwRkpB?=
 =?utf-8?B?NnQ5ZkNseDEvTXRZS1psdEsvRm40Qk14R0J2c0JlYjg2MmZtbERxZ2ZOTllZ?=
 =?utf-8?B?aytKSEp1aFd6UDRmK2tKdnR2OUVPWnFvTDZWellhSlVTU0pXTWl1UXo1Vnhr?=
 =?utf-8?B?RDJRK1FLZERDZyt0QWFEbjJFZ1MrNVpNbTBjMnMwOGdiQmIwUmdQaFJLbGVx?=
 =?utf-8?B?aHRQY1dCQjhVT1FqL1QvRUJNU0RGdFFUaEhsWVlsWFUrNDhDNjVBQWZ4QVVQ?=
 =?utf-8?B?MFBTZ3AxVTFjOWlQQzNoLzJQR0hVMXl5NmRTYUxKQStBSWtMRk9MU2h6WFRv?=
 =?utf-8?B?TDgxNWdLbDExaFJrU3ZmYjNjTDlaNVJUTzk1OUV5L0puTUp4Sm1HVWxtZ25a?=
 =?utf-8?B?d1Rwd3NHeUdkR3dXeUhnMElaWWo0QTd4RC9oc3F1ZSswYnZkRU52Wm9aamlz?=
 =?utf-8?B?d2NpUC9Ybk43V1dTdEtmY3NBNVh5NklhV1NlcUFxQ0U4b2FJNm9TbVJjOEt6?=
 =?utf-8?B?SVNDb09zc3kyRnBudlNCUUhHUkxhL0ZWN0FlZzJlRm9MdC84TzRXWGRrRlhX?=
 =?utf-8?B?a1FtMVU2SHQ0cFhRaWpNU3haYVZRaWNEL2wwRWlhZXlEeVJ2QjRRWEdxR2E3?=
 =?utf-8?B?NW5PK1VqRmhCV0kzNlNUSnJQTWI5MTNZWG45MmgvUCtyLzVDQWxlL0hrWis5?=
 =?utf-8?B?ZFN4SG5jd243N3JTS2VTK3M2WG5LMjdEbjJwRU5RbHlZekJwa2JURGVBbXl5?=
 =?utf-8?B?d3VvakxUc04vK0VGL3lmNHJJN1o5UzNvbmt0bTdXN0FhWDZMTEI4TUU4Rlk2?=
 =?utf-8?B?S0MwMnQzRTRSNGloQjBJU28xM0p0d0tQbm1xbUpORTRlcHNkalRTMjVLcTNh?=
 =?utf-8?B?OVRPd1lRWUluaHRzZ0FoTVFqQ1NITFJLRHFHQVJaRnM4Z0JwWUVFVWk0a3Ey?=
 =?utf-8?B?Q3owRmpVTVdpWGFaNjNLYVVSL3NGQzlQa2lhZEtlQUxEUXpsc2IzWjZ5Vm5C?=
 =?utf-8?B?aEZGZXYrUmhULzI3K2pvcEwvdzRHc05JQkVSZWFCNm1DY2dDY1oxTU8yTDlF?=
 =?utf-8?B?S05uVGJXREFNZkRvdTBOWFRwbXhwcVliLzFOY3M1a2FYMXhZSnRtMkJ4eWZ2?=
 =?utf-8?B?a3Q5UVY5VG9PUG5qbmU4bEc3TUlDTy92OUFQMmxPbnRuVDZiRU1GU3Q0SHRR?=
 =?utf-8?B?ckFLMnRZQ29rK0JpUHFVbXlvckR0YlJ0WVBYaG1jVXFyUDZpSVExb3dudkV1?=
 =?utf-8?B?MENQZjJkS0ZuNlAxVG9oNE91bzRpOGlHNEJYdHY2WWhuck9pZG5zNmt3Tlk5?=
 =?utf-8?B?RWJJdjJqdDlmTzNwdmxreGs2YktOVFJ4ci9MN3dLYmh0WXpOMmFsSEcwNFFY?=
 =?utf-8?B?NWFhaUZ5UFhxWlFUZ0hiS21GUG0wdDRadDhnUmVBa01QcEtUdW5ZenBwWTVB?=
 =?utf-8?B?MXRib3J1WTE1bDZrMHdQMllVbVUvZUhTRHlLS2JHRmdvWVZpRmNUZFlWSXl0?=
 =?utf-8?B?WVBMbzRhQWtOSG5sQU9iVEYvbUhhRG0xM0R0K1RxOGxGeGdJMnNNWGE5bWNO?=
 =?utf-8?B?NzE0ZEFqVzF3azBpOXNxZnlNdk5lK1dLZVZXM3doWllUSVUxWGJjMFFUR2dy?=
 =?utf-8?B?a2xaNzFoSCtyUlcvZmJ6ZTVUSDlIV0ZYNGN3WGVwdmZycEdiUFhXNlVQd0tR?=
 =?utf-8?B?SkRiMTFJQlV2S2VVb2ptRUk5cko0OFNEVnpiN2tkQVFGNzFoMktTV214MUwy?=
 =?utf-8?B?bTM1cTNWN3ZxMVFuNGNWV2M1R0N1eFB1OHFzQy9UNjBuZVVvUkFSOUxPZkVr?=
 =?utf-8?B?TG85M3FSNS83TFoxYVYyZ0diblVQMW1BNVdQalplNDVzRlZiVmEydmFzaTJ5?=
 =?utf-8?B?MHoyM2JYZkMxeklHTmM0T3hUUU9BTUhUZGpWVS9uWUJGVVZPVG1VT0E0UmlS?=
 =?utf-8?Q?4G70/mgkXtuWZZxQRWqXOfPX5?=
X-OriginatorOrg: volumez.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6507e428-03d1-45eb-0adf-08dca72971b6
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8344.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 12:59:22.4552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b1841924-914b-4377-bb23-9f1fac784a1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0d5m861SnADh0f6IJFzWq8N3m1Qri89PcbuuuBB/EY1k2Z061TPLKRlsGVgIdev8/LfRqpQLCILv4TKRpGoLPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10926
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240718_055934_025582_5E3D07E4 
X-CRM114-Status: GOOD (  26.81  )
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


On 7/18/24 15:36, Shinichiro Kawasaki wrote:
> On Jul 18, 2024 / 11:26, Ofir Gal wrote:
>> On 7/17/24 10:41, Shinichiro Kawasaki wrote:
>>> Hi Ofir, thank you for this v3 series. The two patches look good to me, except
>>> one unclear point below.
>>>
>>> On Jul 16, 2024 / 14:50, Ofir Gal wrote:
>>> [...]
>>>> diff --git a/tests/md/001 b/tests/md/001
>>>> new file mode 100755
>>>> index 0000000..e9578e8
>>>> --- /dev/null
>>>> +++ b/tests/md/001
>>>> @@ -0,0 +1,85 @@
>>>> +#!/bin/bash
>>>> +# SPDX-License-Identifier: GPL-3.0+
>>>> +# Copyright (C) 2024 Ofir Gal
>>>> +#
>>>> +# The bug is "visible" only when the underlying device of the raid is a network
>>>> +# block device that utilize MSG_SPLICE_PAGES. nvme-tcp is used as the network device.
>>>> +#
>>>> +# Regression test for patch "md/md-bitmap: fix writing non bitmap pages" and
>>>> +# for patch "nvme-tcp: use sendpages_ok() instead of sendpage_ok()"
>>>
>>> The cover letter of the series says that the new test case is the regression
>>> test for the patch "md/md-bitmap: fix writing non bitmap pages". On the other
>>> hand, the comment above says that this test case is for the two patches. Which
>>> is correct? (Or which is more accurate?)
>>>
>>> When I ran this test case, it failed on the kernel v6.10, which is expected.
>>> Then I applied the 1st patch "md/md-bitmap: fix writing non bitmap pages" only
>>> to the v6.10 kernel, and the test case passed. It passed without the 2nd patch
>>> "nvme-tcp: use sendpages_ok() instead of sendpage_ok()". So, I'm not sure if
>>> this test case is the regression test for the 2nd patch.
>> Sorry for the confusion, either one of the patches solves the issue.
>>
>> The "md/md-bitmap: fix writing non bitmap pages" patch fix the root
>> cause issue. md-bitmap sent contiguous pages that it didn't allocate,
>> that happened to be a page list that consists of non-slub and slub
>> pages.
>>
>> The nvme-tcp assumed there won't be a mixed IO of slub and
>> non-slub in order to turn on MSG_SPLICE_PAGES, "nvme-tcp: use
>> sendpages_ok() instead of sendpage_ok()" patch address this assumption
>> by checking each page instead of the first page.
>>
>> I think it's more accurate to say this regression test for the 1st
>> patch, we can probably make a separate regression test for the 2nd
>> patch.
>>
>> I can change the comment to prevent confusion.
>
> Ofir, thank you for the clarification. I tried to apply only the 2nd patch
> "nvme-tcp: use sendpages_ok() instead of sendpage_ok()" and its depenednet
> patch to the kernel. When I ran the added test case on this kernel, I
> observed the failure symptom changed (it looks improving the kernel
> behavior), but still I observed KASAN slab-use-after-free and the test case
> failed. I think this explains your statement: "it's more accurate to say this
> regression test for the 1st patch".
>
> If you are okay just to drop the 2nd patch part in the comment, I can do that
> edit when I apply this blktests patch. Or if you want to improve the comment
> by yourself, please repost the series. Please let me know your preference.
You can drop the 2nd part, Thanks!

