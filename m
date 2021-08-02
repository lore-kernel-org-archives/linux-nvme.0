Return-Path: <SRS0=aESL=MZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17537C4338F
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Aug 2021 19:36:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C250160E09
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Aug 2021 19:36:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C250160E09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6LPDBb4xIQdtBQsHYOnDcM6xp5Aafuldk/dTDpfke/0=; b=wriwtSNRQwlDZt4J3k5ncpkron
	7IcZqgFPqSoNrwfe2qB6OQlkGtiK64XyX9/fdIZl53x1I5/giLmxBCuODbVMmxqmnhAshlCCWNjJf
	ZcxyR3T4oscZMLQmevyj/sf5gAtjzMqQAp46+8u66jKVA4to7MVWHI1cnVJLq8V2ImXoLOX0YPpWP
	LJwjXZBJde3lVoc7B3GKuABt5J4yDQIWVLjJgb89j/JklfQBy/sTelXEsJWpGXIbPorN481YhiD0k
	wBEm/I9Ml5tiuzVSB2vVUVz/ppO8P4oa5/YvOBUYqVt4P45w07e8sDfbQJ/jIMS113ZSr3+ANmjZp
	79QpYSpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mAdje-0003m6-NX; Mon, 02 Aug 2021 19:36:26 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mAdjc-0003lZ-Dr
 for linux-nvme@lists.infradead.org; Mon, 02 Aug 2021 19:36:25 +0000
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 172JW33I005798; Mon, 2 Aug 2021 19:36:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=3cuWblrLtA5iK0CjgKttc7PmcZ5MIGeQG0lUX4gXGXA=;
 b=MgxdJ2+y9BY+tUtL+vifdgqFDzUCNxwgSQ0Knrv//5NGM8V/AAKm4cOQEzFfjUa1MA/n
 LANO0xlzlQjhC851sMLDmj5UDkJHh4S/NLYF5vK2IIHsadzLb4AYzhIP8z3Y0SmSjLLL
 1ejKg4e0+2aSiIX/QxUUuxrQBGaTmTa5J3goeY7YSAaShn1MLNAFhWzp63RVbv5Bexyg
 oe5/1yMhgj8Z+wgpyocssp1dA8y+CnGgIR3GmfRemGfJNhpEEU3NKKI65SZXUzTnAk78
 6PGjbZJtCDciqKTriSHvoctSyLZR3Q+VHOjPCyKP2F5lSy++25/RAOWKKPsz6GY62aJ7 jA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=3cuWblrLtA5iK0CjgKttc7PmcZ5MIGeQG0lUX4gXGXA=;
 b=d8yeRyPt5hMIeRNG04Ukx5CW3dD3C6nMGywcuOyl9PXN2KHmx1zQx/Ls4c1kHd7ry5oZ
 XZJSR57cPSBTRpBgVsn7u1JqeO4o48U2cwAugKGK4pXD7ddea5k7x/ACZekYupUoI4AD
 i1Q2Sz1bYs23QaevAQXdSdDZymc2LUo5Zh9ZunctFbK/w13QcjwCTeC8kzufRpw40kWc
 EizWKsyVJBIDzkiyhb1PXYqzkVsdtWWRhgjzG2iqPjepf/N8f23RTbqCCpN+QwmcqC8T
 F2jLZw3Ir+mthuxBHXtlmIuohzU0yhOBT/pIX0zcZ9oWc6I2UbFcoWmwfnM8//dtvfQZ 9w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 3a5wy1je5e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 02 Aug 2021 19:36:15 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 172JVKK6137653;
 Mon, 2 Aug 2021 19:36:14 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
 by userp3030.oracle.com with ESMTP id 3a4umx8h7h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 02 Aug 2021 19:36:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CPAG1cUthxhr2YLBLYWCpsTl65C+hE5NS2FOLIl/mFHpavtiiTJz3+PDugteS9Lg00BAeZi9ppk/Qv3Uuyla97L5YUQHSsfG3ZrY4ERXVIk96nhEhC4TClqH3Pwe8Kylq/cPABwaiPGSRbXrW8nWgsCA8UuOL5d0sE6IOEUO1eEi/kDsfmTXj6EcAsMb1DyGFqNcO1jLik7vBv+KR6uJin5Kzp192YaEszZ8+sKGrWzUHBgrYkl8Dw4AM30kGI4l5rkWepQiH4eDbX6wasT0+3scqZxGDHBvat6a5tazry8RviG2zKtXvKQTbK4ItRiSUhAlpkSgt2Was2aMnmJaig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3cuWblrLtA5iK0CjgKttc7PmcZ5MIGeQG0lUX4gXGXA=;
 b=GgtW7vmsPD/dNhSoVqOrBNfLQb5b+QozEXOr1Hmw7bsPsLDJ1ksIvt4JNF9ldoOR5AlV3T+JcwY98cUYJb4r9pfGJy2K63q+Imw0dQzWRxbOpT/oZERSNMO2Dz2XZTGG/9hUf+iEULAAkACalnwwpjJBtBK23NUM0kt5ncYRifYciHOmTY/p+Z8uVYJHxVHNNCPYltNvBfd+rS83XQDnbxhxOoC0oI+PdmNDePA9+HhW/ivJbJZxQ7/f1p/KqAA7GGpdgaVPT2IQwDZnlj5kkH2OX5CUDjBMRNAv8e3MMu9kutKEVmWqAWBQ7qugV6PsK9p1H2JulKC7cv896yz91A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3cuWblrLtA5iK0CjgKttc7PmcZ5MIGeQG0lUX4gXGXA=;
 b=G+2qVVZHXO3SrzeNZlI9KT3TekBlKzaqVtGYUa1ln7gGAHik6zRheE3mqzk2vPOOIOwxMdjHFpv3/WdYiwF3vsj/eVFfGJeTQBcTVyk8fx+hZ6/4eTNE0l17Nx50hdq9UfYTWayIEOeKAayWEemCeWOGXVKh/6658bw2ADVImPM=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19)
 by SN6PR10MB2990.namprd10.prod.outlook.com (2603:10b6:805:db::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.25; Mon, 2 Aug
 2021 19:36:11 +0000
Received: from SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::7c0c:7f1d:bbb2:b43]) by SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::7c0c:7f1d:bbb2:b43%5]) with mapi id 15.20.4373.026; Mon, 2 Aug 2021
 19:36:11 +0000
Subject: Re: [PATCH v4 4/8] nvme-fc: Wait with a timeout for queue to freeze
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>,
 Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
 Wen Xiong <wenxiong@us.ibm.com>, James Smart <jsmart2021@gmail.com>
References: <20210802112658.75875-1-dwagner@suse.de>
 <20210802112658.75875-5-dwagner@suse.de>
From: Himanshu Madhani <himanshu.madhani@oracle.com>
Organization: Oracle
Message-ID: <13814cd7-eb04-8c14-0732-e0f70005835f@oracle.com>
Date: Mon, 2 Aug 2021 14:36:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210802112658.75875-5-dwagner@suse.de>
Content-Language: en-US
X-ClientProxiedBy: SN4PR0701CA0030.namprd07.prod.outlook.com
 (2603:10b6:803:2d::23) To SN6PR10MB2943.namprd10.prod.outlook.com
 (2603:10b6:805:d4::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2606:b400:2001:93:8000::b52] (2606:b400:8004:44::1e) by
 SN4PR0701CA0030.namprd07.prod.outlook.com (2603:10b6:803:2d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend
 Transport; Mon, 2 Aug 2021 19:36:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f085732c-20b3-4104-efbe-08d955ecc8a6
X-MS-TrafficTypeDiagnostic: SN6PR10MB2990:
X-Microsoft-Antispam-PRVS: <SN6PR10MB2990840A82B0D642DD1D89FCE6EF9@SN6PR10MB2990.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:81;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KreTuZPr6AoZF26J4ZbI7CIO4EquUpqBckZHkpLC/HVzIesLyYQ7o/CJ40/a8jS6q9m/tw3flvYIoVIh2HA1dl9EMqB3zqATL5YBy5OiFe1TV6JWK5IYuL+IJ5nxurFoBiyvB+q4U+NPXoYDevOfbJ8L0o02AOczPfsV+ZvQE6rZroWkHsCqS6Qul/K+cFyDWk/S3pG73l1M+x04SxNXDA2d8vgZF6WSghsMw2sg/GpzOxrGMDqcfQYY+7ipIBu9VJ97pC1154+ptntsFTdPLxxL73CiSRRkSDW8Lvy1Oy60H9Easfbvu0AQtSaRkv4r0f16Z8sSsuyYLDHe6GKVOQ24aU9+0yNYilP3Y2+YBswrdO3Ak631h1psH0GpSaYuT1arro/GJ4/6UKomGxH5ix5jdWfCXL6x2y+a07tXbvrHuA1aNyL4WsRptT1Anfv53KUu79QVlzmAI0E6FN85fbkS+vX/gIJ0sEWxBgWoM/eNxEgKkl3ERtbfRplDXKMwnlRPwCjiuR0BdECSGQ3CinL8Ji2LcFya8nCEJuZhTM+STwu6oIvqL47JEJeqYOcA5eXkbil3HlwN4vl59QXipFBaCEd7Q6pkvWPTYldy+Ux/++rETj7qvhB7/x17xlc69ttJE9q1/Ubhe+bcjp9x2sOsX9K4H6cMAwRLU+G1oYSvyIJuJnJtSX8PDwz6eRVTEqw0we6/f0CdhBS7rN/eSjxvV5PzYeM+gHoHzu3RBpw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR10MB2943.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(376002)(39860400002)(396003)(366004)(346002)(136003)(36916002)(7416002)(44832011)(66946007)(38100700002)(83380400001)(31696002)(66476007)(66556008)(186003)(316002)(5660300002)(36756003)(2616005)(478600001)(86362001)(2906002)(4326008)(6486002)(8676002)(31686004)(8936002)(53546011)(54906003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3RnSVRtMTBTejFmN1pkekN6ZEhZZEg5U3FDNGxDQVhvSkx3bGE1NXJQdElD?=
 =?utf-8?B?MnZySGdNR1VGbGUwcUNXOU9YaGVVS1NHWXQrUVcwZTdPNUQ1N2w3a0pHMjhU?=
 =?utf-8?B?MUpzTVJqTHdna2I5RmNWNEFMZTFnNXZ2NFVKU0NXV2liK1B1LzlrMkdtY1VL?=
 =?utf-8?B?eGpON1VCME1MZ3REQ3R0K2Q3RFl1MFhXNktIYmMrNmZrZm0rbjBHNVkxSlBT?=
 =?utf-8?B?NFpDdmx4VkNVV3U5ZnVRb2hUY2JHanRqTG5ZSTB2bUUxdGhDaHU4WkQrWUs3?=
 =?utf-8?B?a0xobEY1QlZ2MGdUamg2bTlwYnpudmdMOEM2Q0ZDS0NHQnh4SlRlUzhuejdG?=
 =?utf-8?B?USs3Q1Bqc2x6MmxPbTlQam1HU04zUVUrd3dTV3hoRDQzRWRqQTZ5Rm1SMjl5?=
 =?utf-8?B?RjNLUVViZFJYSy9ZYTJONStQRUQ5R3B3aWkwR3FnOHBJemNheHhPMHZ5aWt5?=
 =?utf-8?B?dDE5Y0pFZ1ZKZW1zQndIemMxSHBOOXB1Z25kVFRZVExwMXpMVTFtVEYxNkcr?=
 =?utf-8?B?MWNKSEZEQXZVYUtQQVZOKzV6V2txQ1VhRGZnZ0lUOFdJUy9lZy9ybERCRk1O?=
 =?utf-8?B?cXF6YWw5NHQ0UHJQTnpIWk82NG50N01RSDBjVHRuMUtaMERoT1NmYmRySmlz?=
 =?utf-8?B?RjBXSXh5QU1VRWFENVNtemlxTUN6ejJDbXV2ODdHZ0lZaHl6S3dSU1FwNGh5?=
 =?utf-8?B?N0pJdlhiVFF4cllqUjQwanpQQkVyUDJKMGpibjQxV1RwYThtTUxpVVZqTnVs?=
 =?utf-8?B?Y3J4RDRlWmZFTmhZSTlpQUtjSHpVQS9JRXJmQyt2UXkyaW10UjNEUHBjK3J5?=
 =?utf-8?B?dGRvRHlnQmNwdXhNZWFSY1J1VXVSZU13QWVac2Vubk1WMFAvWkhCRmZaZ1Rp?=
 =?utf-8?B?OFNsUStIZlFOUHlhNi80RnFlNFJXUHZEQkZKbkpWZDFjVWFzQVZmSHRwQ3V2?=
 =?utf-8?B?UjZtU1JBczFTbVVVRU0yU2RLN0tZUGU5Y1NQZkR6MUI0NnhrTld3YXpINUR2?=
 =?utf-8?B?QVRFZlFCK1VNbk80VUozR2xoUVlEdThBUUxTTzUzN2QrWkRyWlUyM0pXYWwr?=
 =?utf-8?B?TXZ4OXAyZDBtbC9lQmtXb0Z3OXpueHVSYlJBaGV0eVY4SkxoamVrRGhMWFBR?=
 =?utf-8?B?bnRXMkFPNjYvQ0ZTZ2NUSzliK3YzM2k4VFQraHlzcUt4SzJxTUxQV3BCRUQy?=
 =?utf-8?B?UGNCYlB6b0I1SEZtSGdFWFJNYi9Sbk1mSTE4dXhMbzhyWkEvcVZDM3c0OGRJ?=
 =?utf-8?B?TDFUT2R6SXQ1UXIyRFp5QXU1WFE1QnRnYXpYb0JINjNNUkt6NzhTVmxGd0dN?=
 =?utf-8?B?bUVOdHd4ZmhOOUYvbnFRc1U2aDJkMHJ3dmF5Y2ZFQkk0amN4NGJtQ0hRdE1U?=
 =?utf-8?B?dFFWN2RnZFd4S2p4UkZ3U2l6RVNTT1B1VXBraWtqbmRGbGlXWmNEOThqY3lx?=
 =?utf-8?B?MUVhRitCd2JHZmExOUtMUm9nWXE4NDU3bkpOcTRYZ3JJaVE2TmZJS3lpSDBB?=
 =?utf-8?B?SWlXSndIeTBrOGJSbzd5Y3V0VEo1MmloQ3k2Sjd3YnpKWG5UbnRFNDBwUjZi?=
 =?utf-8?B?aGRBOWluMnFWQWNSY3JBY2VBSjN6ZFY0Wnk1SDV2TW81V3Uzay9mQ3lacWhl?=
 =?utf-8?B?cXRZaTdrejF5Z2NDeVpXUUdqQmtkKzM5Szg0MFhEdjRWM1EvU0FmS1A4L1lW?=
 =?utf-8?B?WlNXMVdIMlZIM2ZHOExRbzZrcTE5eVdWOW1FRENiSG83aGdEMlhpREJyUlJW?=
 =?utf-8?B?aTNuMG9qTjFhUzF3Qnk0Y0oxaUZDK3JlWVlTRG5nZjdGdTBBZzE0TU9MQS91?=
 =?utf-8?B?SU1DdjlOWVRWeU5BcTZwdz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f085732c-20b3-4104-efbe-08d955ecc8a6
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2021 19:36:11.7351 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tOoGvCx8binNxdDFvCrkTS83f4wmul7twyZuQZtF3WbpnpKbnVpGaY9VM0OpYejxsByLpk8Zu4Xescr0JdP7OdJUcpZWQ00oANUI91ikDKE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2990
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10064
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108020125
X-Proofpoint-GUID: 771LSlRrYohmDeBxIsCu7gOux0cr-XW4
X-Proofpoint-ORIG-GUID: 771LSlRrYohmDeBxIsCu7gOux0cr-XW4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210802_123624_645699_453B563D 
X-CRM114-Status: GOOD (  24.29  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 8/2/21 6:26 AM, Daniel Wagner wrote:
> Do not wait indifinitly for all queues to freeze. Instead use a
> timeout and abort the operation if we get stuck.
> 
> Reviewed-by: James Smart <jsmart2021@gmail.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/host/fc.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 8a903769364f..dbb8ad816df8 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -2955,7 +2955,14 @@ nvme_fc_recreate_io_queues(struct nvme_fc_ctrl *ctrl)
>   		dev_info(ctrl->ctrl.device,
>   			"reconnect: revising io queue count from %d to %d\n",
>   			prior_ioq_cnt, nr_io_queues);
> -		nvme_wait_freeze(&ctrl->ctrl);
> +		if (!nvme_wait_freeze_timeout(&ctrl->ctrl, NVME_IO_TIMEOUT)) {
> +			/*
> +			 * If we timed out waiting for freeze we are likely to
> +			 * be stuck.  Fail the controller initialization just
> +			 * to be safe.
> +			 */
> +			return -ENODEV;
> +		}
>   		blk_mq_update_nr_hw_queues(&ctrl->tag_set, nr_io_queues);
>   		nvme_unfreeze(&ctrl->ctrl);
>   	}
> 

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

-- 
Himanshu Madhani                                Oracle Linux Engineering

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
