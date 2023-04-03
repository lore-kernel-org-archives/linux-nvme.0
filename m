Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FE3DC76196
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Apr 2023 22:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=huuvLRDc8xv2Dw8MWvFe/twGTcpWheAHcfhd9ucNae0=; b=0PKWz5lsR+PyN7dBbEvL7nddVq
	awDNqQRKyi4e3NQRXU/evDF7kJfJvRcqLc9y1XqzTGB6PyHuvpNZ3CNpkG2ezx3Gpvg3NfUtr1Kyt
	Hn9Lxve3PqJORpkwdDN7il1bQn0MF7C2BVsIlm5QMq+KC7vdwpwe23WM90vZ0U66Msp8xM6MobFBc
	YtR0B97u7c+AQFgYmyzy3t0c//hwq+htFBL4svGcT7WzUeuT1YSLat0u/sE1nEIoLwAErO+rzNfOL
	eApoO1CI+0tsNInoXNvGCKYnWzrEtXGa5R3l0QHxgtUVkZtU5pO6iXUpTbasEHTbWygRYs/j/iCoM
	h+S+JZKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pjSXW-00H3GG-0T;
	Mon, 03 Apr 2023 22:20:38 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pjSXS-00H3De-2c
	for linux-nvme@lists.infradead.org;
	Mon, 03 Apr 2023 22:20:36 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 333Jbh7i021158;
	Mon, 3 Apr 2023 22:20:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=huuvLRDc8xv2Dw8MWvFe/twGTcpWheAHcfhd9ucNae0=;
 b=SWGJHXo/jNlxsmEgOgWtqiFPdprvmghIyj9zwLnBAB0hAeAtH+o8zEUGkBaIZfYxGR7Y
 UE5CiyuPILLlj3ug9SOJddX/ZpBgpNFjHblrek+hgbCwof+u2SG8V/SlleiPmw8zmv+z
 HS2bISEIoGVKqm+uxuyvFG/vWgLkFTZcUIzt6PcoBccY0EreuKEfXzlq1ok2H2RuZuLD
 OU8/qs0LRrwI67c2xt2KyAPsFvhplVKbA3yT82i74tMM2MvtAwn1fHz9g1qVXBVlkqy/
 Wn5j5pqIYUaq95+P52Mc5E3gDeMi6U7TRX452lDxv9dQYLXXEaFSfIbvOeatC7tfhRLr aw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppbd3ve1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Apr 2023 22:20:19 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 333LBDZt027760;
	Mon, 3 Apr 2023 22:20:19 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pptunx2vp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Apr 2023 22:20:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nH4Ly6tN1Tvk3enjwNZBVakoQ8Irwj2PQlkB2zz2mH6c5+xE+OJchv2NJNG8vhy2x0zJ3rhUD1xC/VBm1Yg39zXFh4a08+MfiAgARqvsNB8dYOUa/1q8x/lpuXvbdG0jAheEjLMUkNEUkckN1GsGTZqgOOWOxHj1c8pxT6TGYD3iESU7wPfZ/p2ocdyBOX244I+7D52iTMZQgE468al2pRUyjQgLjYRv1CsZEhFHriUuJ1x0N9tO0haIZsb5XfXjxj4pYkL9BblCeXFUvaJ7VuWQlynb6C3VFHGB4yTxJvL7yrrvT3MwPru1LPHhwLwHgCIiibweB4xTzUfJjwG3Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=huuvLRDc8xv2Dw8MWvFe/twGTcpWheAHcfhd9ucNae0=;
 b=IbSIaquCScqyIcer2f8+78zVPuY5YLNLbjRwGEa+EC9y3E5EEzBWPNGw/myq0TZXtjdwtwBD1Y67CpZ5h/M4zDkSJNIZexBCJl7JiOfjbyxxyWvEGMaD9ktppYkmaZsYliq9pPwNkqm6CWkRUqxcXP3fGYtogTBWEvKJhlcd7RtCwUj33NQUZR6vMs4bTzcS9Ce1pqZOV/cVm0zw4Smf6XC23/h8LzfLxjJQbOY+cYeHmS+woQBRhB1QsaSFW/GyUuoikzBKhnCxxV6xAlKYDOW+xK254bWOwKwSKThuU9WCtS0fbgVYBNvFR4irTYPPNpN96fuao8G7rnoMzt5qXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=huuvLRDc8xv2Dw8MWvFe/twGTcpWheAHcfhd9ucNae0=;
 b=rvvvauePUljlDg4cXQ8QgBtGfgRrj/qqr/YbwBPTP201P3/4/XbWqWHkmx27ng/NVGb47Ihob1ZHbVhD9MTGpyLeZkDEAUUyVEnBG/ub5uCm/FIfGJyN9dqRzcBpASf2e+94eQ/RPed0njgFT8H5PL3xYtFf7yb+mLBCPnUK2P0=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by PH7PR10MB6202.namprd10.prod.outlook.com (2603:10b6:510:1f2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.26; Mon, 3 Apr
 2023 22:20:17 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::1d60:b6d8:763b:d31f]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::1d60:b6d8:763b:d31f%3]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 22:20:17 +0000
Message-ID: <ca72677d-932d-29f6-5260-0b0d05fd6584@oracle.com>
Date: Mon, 3 Apr 2023 15:20:14 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [RFC v3 1/1] nvme: add passthrough error logging opt-in
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de
References: <20230331221823.2806192-1-alan.adamson@oracle.com>
 <20230331221823.2806192-2-alan.adamson@oracle.com>
 <40dba1f3-8307-ca1a-ad6f-c80df87e0344@grimberg.me>
From: alan.adamson@oracle.com
In-Reply-To: <40dba1f3-8307-ca1a-ad6f-c80df87e0344@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0239.namprd04.prod.outlook.com
 (2603:10b6:806:127::34) To SJ0PR10MB5550.namprd10.prod.outlook.com
 (2603:10b6:a03:3d3::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5550:EE_|PH7PR10MB6202:EE_
X-MS-Office365-Filtering-Correlation-Id: ca5d4d5d-fd27-4f74-1fb7-08db34919a96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	diHkJjoiz3DcpOwB6TYOg2pIoEOuMrfoUCVrY0B05yYchHAXcpBezLqhvw5wpsr+75/d5oLn1AqrA4wI3ojuLgcxF3n0pN6861iWe/N03aUKY21ZgT0qwZQdBoZn7vm0sUbzAyNhhZOvFcGASbHFUJMQiPe3HqgQTl2uEvmavUdSwt0NpqyLA56GlYBlZTRQ4Z3ZCOB3/YublVbMaRhgzr30lfSLnzyykJVoqiu9bKx8tFkC9I96/ZWCLOtn1Njbrjb8bI6AnL28BYBl/xnNihrb5Bs3oqJdEZopgl9PCbbsqaVUIxbvZpGxaRQ9tz5QUI/IXrs9D6cLYJHVQpnkBBTNmX0TndO72JOfQUGXSxayXysogbNqe46tyQssQJRO3Xk3iVZ/+rdHF/JnsQvB6fb73XhscOMlWoXGJwqVM/BJrqrhEWNxs9qAsLvIlCFyp2HqePk6a4NQtLGWXNMfY8q6uZam+MpP+zMubFGxmCQIjEHWNkmF5xcI6jLMSKNW/eJUxZg5ciulIG35GP48DyBLALu4zzI7WC2U33f9f/6eLwdEnMZEUzicA/VvhaEk2UROqDEjOgo8KF8Wp/HuLKgFeNs8Z0ZiQGdWNeCEjlY=
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5550.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(376002)(366004)(346002)(136003)(451199021)(38100700002)(8936002)(6666004)(478600001)(2616005)(31696002)(83380400001)(41300700001)(5660300002)(2906002)(31686004)(66946007)(8676002)(66476007)(66556008)(4326008)(186003)(6512007)(53546011)(26005)(6506007)(86362001)(9686003)(316002)(36756003)(6486002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?aEhZMGx2cGxMMnFQL3R6S3I3SU9NR2ZGaHpNeGJzdE11NXpwVDJ3bFNHNmZz?=
 =?utf-8?B?cEpzK21udlY4cjNmZXJIQWFkUDhVTlpRZnlMRk5GMFhtL0RvSTIxUWJ6bHQ4?=
 =?utf-8?B?cFpmN09BZVZUR3U1K29sT2pSeUxQeFpKVXM5WjNwWVZSZjlHUVdzbURCcnlU?=
 =?utf-8?B?dE9TM0dJRWgwL0RpeXVnMDRZK1hjWVNxdlB0emhzaytxR0x6bXBIUTNTdGFE?=
 =?utf-8?B?b2U2TlJYdlZnMDNTTjMvTHh4T3QzY1RoR1llaGFMN1hNTUhNc0c2dG1zS1B5?=
 =?utf-8?B?N2JEblQ3WldEWmdZbk8yckxzTElJYmllZC95Q0FKRXJOaVZaeGNqTnNtaXNR?=
 =?utf-8?B?djZuRE94NmZqTUZDY1BCRzdXQ0pyWXFOcGM5MGZzSytQM2x0bllWaWxPd2RF?=
 =?utf-8?B?NXpoK0hiRStlSENsT0U3Y0tNWjQ1N20rd21aUGVtejYvZ09HSFR6WS84YndY?=
 =?utf-8?B?SE95akZoWWJ0SFBDU0Y5ek1iMlhBUDBmSy96REU5VGtYS2lCZ0pjOHVJdmls?=
 =?utf-8?B?SVQrWm93SDRWM3dJWlVRS3h0Q1FZT3h6elM1cFJUU0crZHMzaG9HSC8rcXNP?=
 =?utf-8?B?REw2MldRczFzRWNna21RaTJ6OWJZKzhZOGtXM0luWGxYci9ldEtvV3hVcG10?=
 =?utf-8?B?M3dSMzFZempEVmo4N2lyZzBUVTdqczZpR2RaNkxGRk5XVG1mb3IvbUZYbHh4?=
 =?utf-8?B?Um5MbTFkaFU3SkllYmxmaUo4dXE0MytaVXBVWTJBTnF2OXhoMmNkNklTWmRj?=
 =?utf-8?B?ZE0vdFJyRm9RcGhkTWgrWmd2TnpJdFR3MWJLZW9RWERkUSs1QnZUaGFEOUlm?=
 =?utf-8?B?SzdaR3BPNG5oRWljV2JQYnNnTkViUHhOVWpCYkVvM2tmcmxxYkVqZ0QwbTNK?=
 =?utf-8?B?enNqMHFhaW1LazFuMDlheVdEWUYwaXBJYmVRUm5vancxSS9yOTlOSk1ab2VH?=
 =?utf-8?B?L2xLb2x2SGRGaTdPbWNvVk1tam5JS2tqdXg0SmtoT01ER3VOSndFWWltZFhv?=
 =?utf-8?B?Q0swaHVGMktQOER5cGFFZnFEUlo4Ukw3S09aTnRmQzJHUEFQZnMwalYwOGpp?=
 =?utf-8?B?aHRpRFpJOEFQQ2RtczdXRForbUVZekdEVzNjNUVveUVWODRXa0FYNlRwZmRk?=
 =?utf-8?B?cjgvSUZFNVc5L21FbDNjWFg5U0FZTnRiS3JDQ1NWOWh6RURkdUFmSjM4cito?=
 =?utf-8?B?V0lJY0tvTkM3M3FaVGNwaGhtaXIza2xzVEVqQm5UWk0ydjVyZ0owbUlKSUZn?=
 =?utf-8?B?MWk1aDRraUFtS1JvTGVDYi9ZWUJhMVE0U2xMWW51SlE2RGxBdDdHYWh4ZEhR?=
 =?utf-8?B?a3RUWU9HL09mZ0Q3NEtMc0ZLMmhIM29oTHJOdHh4SEVjYTZDeDlOeDhiOWE5?=
 =?utf-8?B?OXBrRWdDWCs3T3cwbkJKQWFOcExScUoyQ1k4YTQyZFluMm1RdXVOaUZaYTZs?=
 =?utf-8?B?NkhjTXBGUkVrcUZJVWQrb3JZZW0wdGVIUG9TZU1GVTV6OFpBNFc1ZjBDMmwx?=
 =?utf-8?B?TEhGSnVuTlBBWmliSy9yWXZqMlZ1K0l6TWs0eHV0cWxLb2x1VWl2cXFrNFF0?=
 =?utf-8?B?bDIwUlZYd29vMkFvcExUUEFYWkhtNW5ZQytzdXdiNlV1aVdtd0hlMFNYTE83?=
 =?utf-8?B?MXpmdEQvKzZLLy9sT2daQWFvRS9UQUcxeHhWTDhTSUY3Y2pUWEVoUnNNcnA0?=
 =?utf-8?B?QjZYK2F3YUlwcE12NHlLU3R2aEZqNTlBOFFycFhiRm85YnRHY2VsSVFYUlU0?=
 =?utf-8?B?ZlY3UmVURUZYc0N6eEVQZnNQdU9kN0JyN1VOMkpWQWs1cDJTcXc2TDdoZXhM?=
 =?utf-8?B?RDVZRFMrTCtMWXU4MmZOazhiZ1pVNzQyOCtQVUZOaG5iejd0T043ZjJMcU9B?=
 =?utf-8?B?eTJSMW15MlUwRHVrek1yNG01TTZrWkRMN0NNWnZYV2FsL2IrVkphM29PZTJZ?=
 =?utf-8?B?SVFQK2NRazczV3E2MG5PSXNmVnJqOTNhNm5pUkNqMCs3VmF5azFEb3JMTjlx?=
 =?utf-8?B?VHZEb3JaRUwzTXlqUlZGZFo2N1BHQjgxZy80ekFPcHcxWlptaUJ6RTkydkVs?=
 =?utf-8?B?V1NkOGl5SGpMaFZXdm1FMkVxYTBHbXVUWlVoS05YV1IyVUUvTE9oNW5sS0g5?=
 =?utf-8?Q?fY08tnJhYRonsSoykPdbXRCIP?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	Jx9fUNS0BLRH30SKipeJibqu62NJ3jiXX3x2O8ls8UpxfDtZ/PZwE3qgkpZRtGtWYj8qkIFcJjaSkdWxaJmapm0O4UU/GkmI8U1Y5XI2U4kiJab3Sc649RQ/RfRxyVdt9JsNRF7cryuuMrmTUcyWbwowlsPmlA8lBSGnxEke07vS63nQ4/VpG3mvxPju5TpaEOEDZp0PeYFum6O1qhDLaPPashWX9/dltdBUbnxVp/t3ic3He9IwsApKqiKKC+tjDNQI96LTauSIkRgykMX+EB8byxVnrHo7tyPrz0og+3mx1T6nwe6rAan1JsPD8Lom/jkmbGxSEhp8nFOGl0A0WNtE8zswwAtGE6q5HS/N4hpr2AIHH8NzhOzwVKLXYbefVtfCLd+VqSql8fzce4RPQlOYriSIUrU2x6B66fKdROOhlRsEBMEOqusPWUK8PE0y3R+vz7PIc0xfv5zr+e1TVziud4+8M0xkhSZiA2OahN20MiGnRf4YeqH6/q0d2fcC1iD1/VJtD2FI/NOiVZq9B9CfccLocDGBe+7oLoC9GSX6nJTdttJmDmnMOr0srwATJrQJ+qyLkoWzOPjVqY1SR2/HNB9OQVvVhYhXxZxWnuowhJGRIW8/qifYx66wBVenObf/ssvi0b0ZvBpl4y3NoIsU2KX01fst5EjK5qrLDNmK1P5mjhHMVaQe9gkhF5QyaV9ZCxmFQ425g+nHnPGoqkSVsSfD/VssZFYBTnqWFnom7nMeNy+W2qE+MvDZC3a61A9wOoG2wbE4LvoCqCzxBTyRTqmcVwl6xWg/espTM+4XlwnQeMy/Pv+F9mgZq/wfVQj87mf95SCE0wpPaNCfeaioZ5ChTnQ6iio1q7va+2Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca5d4d5d-fd27-4f74-1fb7-08db34919a96
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 22:20:17.3093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vxf5OrCBCFioYtpjKaROUXRiUbYbHnR9nWuekHr+hPTlTmZidjElCQOMFbnzehEYdCUkdOvrNHgksB8VsVAYmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6202
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_17,2023-04-03_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304030177
X-Proofpoint-ORIG-GUID: kc3FKonzqpLew0iGufM30ghU5uYUJ-vN
X-Proofpoint-GUID: kc3FKonzqpLew0iGufM30ghU5uYUJ-vN
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230403_152035_388278_43CE0C97 
X-CRM114-Status: GOOD (  20.77  )
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


On 4/3/23 3:17 AM, Sagi Grimberg wrote:
>
>
> On 4/1/23 01:18, Alan Adamson wrote:
>> Commit d7ac8dca938c ("nvme: quiet user passthrough command errors") 
>> disabled error
>> logging for user passthrough commands.  This commit adds the ability 
>> to opt-in
>> to passthrough error logging.
>>
>> To enable passthrough error logging:
>>          echo 1 > /sys/class/nvme/nvme0/passthrough_logging
>>
>> To disable passthrough error logging:
>>          echo 0 > /sys/class/nvme/nvme0/passthrough_logging
>>
>> By default, passthrough error logging will remain disabled.
>>
>> Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
>> ---
>>   drivers/nvme/host/core.c | 93 ++++++++++++++++++++++++++++++++++++++--
>>   drivers/nvme/host/nvme.h |  1 +
>>   2 files changed, 90 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 53ef028596c6..82d4f8235a8f 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -337,6 +337,49 @@ static void nvme_log_error(struct request *req)
>>                  nr->status & NVME_SC_DNR  ? "DNR "  : "");
>>   }
>>   +static void nvme_log_error_passthrough(struct request *req)
>> +{
>> +    struct nvme_ns *ns = req->q->queuedata;
>> +    struct nvme_request *nr = nvme_req(req);
>> +
>> +    if (ns) {
>> +        pr_err_ratelimited("%s: %s(0x%x), %s (sct 0x%x / sc 0x%x) %s%s"
>> +            "cdw10=0x%x cdw11=0x%x cdw12=0x%x cdw13=0x%x cdw14=0x%x 
>> cdw15=0x%x\n",
>> +            ns->disk ? ns->disk->disk_name : "?",
>> +            nvme_get_opcode_str(nr->cmd->common.opcode),
>> +            nr->cmd->common.opcode,
>> +            nvme_get_error_status_str(nr->status),
>> +            nr->status >> 8 & 7,    /* Status Code Type */
>> +            nr->status & 0xff,    /* Status Code */
>> +            nr->status & NVME_SC_MORE ? "MORE " : "",
>> +            nr->status & NVME_SC_DNR  ? "DNR "  : "",
>> +            nr->cmd->common.cdw10,
>> +            nr->cmd->common.cdw11,
>> +            nr->cmd->common.cdw12,
>> +            nr->cmd->common.cdw13,
>> +            nr->cmd->common.cdw14,
>> +            nr->cmd->common.cdw14);
>> +        return;
>> +    }
>> +
>> +    pr_err_ratelimited("%s: %s(0x%x), %s (sct 0x%x / sc 0x%x) %s%s"
>> +            "cdw10=0x%x cdw11=0x%x cdw12=0x%x cdw13=0x%x cdw14=0x%x 
>> cdw15=0x%x\n",
>> +            dev_name(nr->ctrl->device),
>> + nvme_get_admin_opcode_str(nr->cmd->common.opcode),
>> +            nr->cmd->common.opcode,
>> +            nvme_get_error_status_str(nr->status),
>> +            nr->status >> 8 & 7,    /* Status Code Type */
>> +            nr->status & 0xff,    /* Status Code */
>> +            nr->status & NVME_SC_MORE ? "MORE " : "",
>> +            nr->status & NVME_SC_DNR  ? "DNR "  : "",
>> +            nr->cmd->common.cdw10,
>> +            nr->cmd->common.cdw11,
>> +            nr->cmd->common.cdw12,
>> +            nr->cmd->common.cdw13,
>> +            nr->cmd->common.cdw14,
>> +            nr->cmd->common.cdw14);
>> +}
>> +
>>   enum nvme_disposition {
>>       COMPLETE,
>>       RETRY,
>> @@ -381,8 +424,12 @@ static inline void nvme_end_req(struct request 
>> *req)
>>   {
>>       blk_status_t status = nvme_error_status(nvme_req(req)->status);
>>   -    if (unlikely(nvme_req(req)->status && !(req->rq_flags & 
>> RQF_QUIET)))
>> -        nvme_log_error(req);
>> +    if (unlikely(nvme_req(req)->status && !(req->rq_flags & 
>> RQF_QUIET))) {
>> +        if (blk_rq_is_passthrough(req))
>> +            nvme_log_error_passthrough(req);
>> +        else
>> +            nvme_log_error(req);
>> +    }
>>       nvme_end_req_zoned(req);
>>       nvme_trace_bio_complete(req);
>>       if (req->cmd_flags & REQ_NVME_MPATH)
>> @@ -666,6 +713,8 @@ static inline void nvme_clear_nvme_request(struct 
>> request *req)
>>   /* initialize a passthrough request */
>>   void nvme_init_request(struct request *req, struct nvme_command *cmd)
>>   {
>> +    struct nvme_request *nr = nvme_req(req);
>> +
>>       if (req->q->queuedata)
>>           req->timeout = NVME_IO_TIMEOUT;
>>       else /* no queuedata implies admin queue */
>> @@ -678,8 +727,10 @@ void nvme_init_request(struct request *req, 
>> struct nvme_command *cmd)
>>       if (req->mq_hctx->type == HCTX_TYPE_POLL)
>>           req->cmd_flags |= REQ_POLLED;
>>       nvme_clear_nvme_request(req);
>> -    req->rq_flags |= RQF_QUIET;
>> -    memcpy(nvme_req(req)->cmd, cmd, sizeof(*cmd));
>> +    if (!nr->ctrl->error_logging)
>> +        req->rq_flags |= RQF_QUIET;
>> +
>> +    memcpy(nr->cmd, cmd, sizeof(*cmd));
>
> Question, if we already introduce granularity to this setting, why
> not per-ns? why only per controller? I'd think it makes more
> sense to do this per ns. Will also remove access to ctrl in the hot
> path...


Meaning we should have both:

/sys/class/nvme/nvme0/passthrough_logging

/sys/class/nvme/nvme0/nvme0n1/passthrough_logging


Alan




