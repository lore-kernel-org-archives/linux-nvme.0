Return-Path: <SRS0=oXoK=KQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF1CC4707A
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 17:28:44 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4BF161176
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 17:28:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4BF161176
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b1zgX360FQJxDDMxzcdY8thQrqp/ylK+J8+p+lp5Ke8=; b=e3UjaRWfO8PsnCBEvJQ2Cghf0K
	r/wtL2vtMcFuJ6VR4Zd38ZkCkhkeTtWBd7w8jc1TwOcgDyEYCS55lQdQzscKwn1mL4YLnn97/rgpC
	RhCi7o/3tmeCJ71vt+zb0tjmqlo6X8y8nXFVqPR33MfuxyIyw2qjAj3IVIwcFY65E/uk4DMmneIbH
	6986+2So09OLcfOJrP2/NIeBP8bb1IipgO1Yan+/9jy8pgOqIqRMrmb350f5USPAKVmcDi3Lmrtdh
	xMuWS0AGJ5SIgVZW40oItEIicDVVCZhRfrzUe7Dnh5GXlN4j1JUNO1rbPESG8Aheq0M7FX9/pNW2b
	G3OBzUXw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lk8wo-000VIr-4m; Fri, 21 May 2021 17:28:30 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lk8wJ-000VDE-6S
 for linux-nvme@desiato.infradead.org; Fri, 21 May 2021 17:27:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:In-Reply-To:Date:Message-ID:From:
 References:Cc:To:Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=nzyt6gvBcn/KsNzGASeEGjy2PMUNg7V2A5qyjC1srcI=; b=ezd++gf1vKhJV+pcfYGI7VfowJ
 4AN18V4Nz3bR21GQ4PwqVZDH318XCB764xtw2732OqnKJ1ZK0i8yF2iXHrLPWY5mIpDkeB3pDfJYs
 8Saol2X/fTgyLxjfd/bn1BEhG7iWltfdlTugKI0bdmB7xpZ9rCkHoBne5/Udf6loMlE5C5ts8iuKb
 4TyKuaUiHhvG1zpY6ITBh75eGHpxbOd154U1GkUi30v0wA8m0hFmRi0PDBUajSSgWYBYaAqMIwOk4
 qvaFRlqH7RV/WyroCmBngJHfQkclrFLO+NGiBDtT0ERv+AUVcVulzeYtHkz2Ns9qlkada2YnnWd4y
 jYpkua4w==;
Received: from userp2130.oracle.com ([156.151.31.86])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lk8wG-00HJQy-GV
 for linux-nvme@lists.infradead.org; Fri, 21 May 2021 17:27:57 +0000
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14LH9GZg075231;
 Fri, 21 May 2021 17:27:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=nzyt6gvBcn/KsNzGASeEGjy2PMUNg7V2A5qyjC1srcI=;
 b=c4mBeztg8AYiOIu5WlrnSNeDG1WzaPs8pIAtGlPlt4EIGtLk2qy7YHq01DiKD74n8EJB
 GLZwc/4Bw9qEBKMl4xXR5+CfSeF5VA7/rslaWWWuWVsnkV/gnVS8hzQOzVK9NIAK/QZ8
 t/AvdtoYyeM5/RV7iOJeLZZIVhgFygRL0qmGTbEKZaM06NTyydKv5HCjU194U0YUMhEc
 7KjFmi/BtMzugyhM4i/MtxnwKcq10OzpP0RmZq4OhF2MbH6jmh9PhNxyDP70M36xnebE
 Nj6fVjPQV/Sl+iAC4e/mLnHMJJT0+w16w3xIdWrobzWAutTPGhums4dSEPZMOvifd0lR PA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 38j5qrgb6x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 May 2021 17:27:53 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14LHQQ4j163575;
 Fri, 21 May 2021 17:27:52 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
 by aserp3020.oracle.com with ESMTP id 38nry3ctah-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 May 2021 17:27:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OiWTvBRB/E+BozcYXk0zlHzPJRMQjQr/XSuz6CEuqLFbUYO0SI95usttZoPSlJfX+oW2umt+dzKZMFezjA5qSybLgjSrSpv3U5ln8rDP45iXA7kkNSq95zXfYxbrD2HD2I2MLoq6gy9YIS7VyiLyuawn/Ml55x2MX9n5NXdJnsuTz7RhcEdWlZYbxNU0ML0dexDD6ffmE40w+1fwvrb0bbvw3hAwtUL3eJsr2Wbkqq2usLJq5DMSMNNFI1xZKQQmdq71Tl0NGKrTlRX17biTwnSiHWTC8fDruYId6GWaZmZQDvM+lTRR+4uXCNLdwtReU17Qthdn3hQj+Jlzaajy6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nzyt6gvBcn/KsNzGASeEGjy2PMUNg7V2A5qyjC1srcI=;
 b=RbWQrDXJtofxWOlosh054WMGyjdIYTeNO8HqL1MUqSMOrH7P4S/fcx6UXzHHQUW0xmjQImFYBi5bAQag4aOORSMExFQL+LTs+UAX9nv+WKH/Rd/4ywD1XGfQ1ACNq14Yj3cEIFry7waSwthGJ6tGrAQdmw6jTylz5eOldp6CUVvGp/toqVePrFgkcgz/JwWY10o2bGwhnEgjOCbiGf3DIOzzhc0tBKW8G9r2h8duvZxSukquq1o34j4mDeyiuwdmGFuGtJw2q/zJs4TJ3jhjPBCXQTwhMiOqm7HvmQq7KucD6j5ubSVukwwngEg4xtX5jk6m+vz6GrLx1PLfK3s7ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nzyt6gvBcn/KsNzGASeEGjy2PMUNg7V2A5qyjC1srcI=;
 b=zRCecGJ9HHVm3z/078/okPExC78VrNYv6k12Q8LT0gaMEnPxvfpJa66tqrBFwlom43qRYjTOff1sR3UYqAa8NMM8yp2ZLu/zzQLH+5a0CfXZZ76OwLnqjYk/NO47aBD1Y6/MfrEQLgZP9v1kk3yXfkujHjgRzu3W0i9Cb3Ry25I=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=oracle.com;
Received: from SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19)
 by SA2PR10MB4665.namprd10.prod.outlook.com (2603:10b6:806:fb::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Fri, 21 May
 2021 17:27:50 +0000
Received: from SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::168:1a9:228:46f3]) by SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::168:1a9:228:46f3%6]) with mapi id 15.20.4129.034; Fri, 21 May 2021
 17:27:50 +0000
Subject: Re: [PATCH] nvme-fabrics: decode host pathing error for connect
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20210521082346.146966-1-hare@suse.de>
From: Himanshu Madhani <himanshu.madhani@oracle.com>
Organization: Oracle
Message-ID: <0a159cfd-7097-811c-5a82-a9f6726cfe91@oracle.com>
Date: Fri, 21 May 2021 12:27:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <20210521082346.146966-1-hare@suse.de>
Content-Language: en-US
X-Originating-IP: [70.114.128.235]
X-ClientProxiedBy: SN4PR0501CA0138.namprd05.prod.outlook.com
 (2603:10b6:803:2c::16) To SN6PR10MB2943.namprd10.prod.outlook.com
 (2603:10b6:805:d4::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.28] (70.114.128.235) by
 SN4PR0501CA0138.namprd05.prod.outlook.com (2603:10b6:803:2c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.12 via Frontend
 Transport; Fri, 21 May 2021 17:27:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8e26d9c-5624-4a3f-58f4-08d91c7dc1e6
X-MS-TrafficTypeDiagnostic: SA2PR10MB4665:
X-Microsoft-Antispam-PRVS: <SA2PR10MB4665FCDB43D1182E5BECD746E6299@SA2PR10MB4665.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:386;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8jaL7Kml/gcliyuRjn76LO+i3aUVgh815YxR1MHRkd1TpZIgP1c4G2EFK/1Ui9Hd+mv7hWsHSTfb0Dpj76HNZZiFkwzu2wijsAPncrQs2xpYrQ5I7eLKcIAZmYdcSs7QgTwjg+wqcsVfPZjw4Ci7vFshCnbmxQLcaUwJH6UMFfqTht7DGp/dOwG4pLiy0+TyniS+2bJxwwpKJD9Ve/ZT/ciF/S3L1+XmKP8oISdHfdlACZE5R7hkk15yQ6ubJzYtibiVN5FJs1xjnfgjZVPsVUzw7KrRaMRNd3dv4Bn4CeZxMm1tQ+tUynJWJrho5c3kKpPQkB3Gzip6CRmljb7gxyGIOorMNgkTnVaOqIFM+ys+qOc4miJryPXLXlg+HPP8pbAkygmJdMYCz3TfV6rgdYNNjmZqO3w7f9pPwrCQYHiqLT9O0wz2AP5zT1NLd73v3EBygj09lcICHv+Jg0Vt08Tlf6qlGeqokLBlnl84guGO0Zxgyk+QS/xV9JPj3jTaK07YUGQ8adHig3SjXc0LLKyiwiqPzmfsMj470gVYKqPertOA+MmNMikjtKnfbQk7wHpXhoWn2kc666XFIeCdAQ5xaM4NLaDwrXlMwQOKvsaFZXA8cHrnh8zix6YaUjt7/XalcvKmjK9zzKq8PdN7ZpaKMrniikgMgJuxJVIPQzqTEKtnzu6OPdYFZWXaYRQ1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR10MB2943.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(396003)(376002)(366004)(39860400002)(346002)(136003)(4326008)(54906003)(26005)(316002)(110136005)(16576012)(86362001)(16526019)(31686004)(38100700002)(31696002)(186003)(36756003)(53546011)(956004)(6486002)(36916002)(4744005)(44832011)(5660300002)(8936002)(8676002)(2616005)(2906002)(66946007)(66476007)(66556008)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?V1UwT0FZWEQ1VWhxa0x6cFA0WnNKbmtkRDNkbzNCc0tldFJ0WHZuYmhrMUZv?=
 =?utf-8?B?UGwvakFRbWVEbWtoeEp2NUtub1JudVRiY2VBMlJzU1BEYjZBKzFvcEVxMnBj?=
 =?utf-8?B?bE9GSWxMRWpIbEczbzh5ZkJ1RXZlL2ozYjd1UDVKb3ZjQ1BlbUMxaEJqUHlP?=
 =?utf-8?B?ZUdJM2VwQUpVSWRHWEVWdjloYmRMOWUzMGIyWnhoNUlqemJVSzh5UkR4Q1BT?=
 =?utf-8?B?YU5qcnU3UEdjK0NSaDRxMnoyNjBibzdCZjFVYjBaVkxGbDcvYVNXWk9UQllm?=
 =?utf-8?B?Tng1OWNMdzJXLzhGR01oSURuZmtNMmxoVW0zWXlYN01aRjJ6WnVDckJqSlNy?=
 =?utf-8?B?TDU2Mnl1aGlnMkZkbjFWY05UdEZqd3R3Wkh5SWNiVGp6MkVkRzBkOHJzcVJV?=
 =?utf-8?B?UG9UclhKaEh5enMvL2E1K01tRWlNRnlTZHByZlFnRWZrcTFNNVhMQzNxRXps?=
 =?utf-8?B?Z3EzRllGbkpXbk5mR3A4a1Jab3BrR29XZFpKbXVXelUrY1I4Sml4b2UyY2Zp?=
 =?utf-8?B?Q1l3ckRSZHRTOGpaenRMaHVNaFRJKzlkalZQNDJuQVJ1V1NxVjkzNjhVV0tR?=
 =?utf-8?B?TVdQMzNrSWtEQ3o4ZlBKNmZxQnFJeW5FNTZHRDMwVFZVZnVPQXpwK1pDU0hw?=
 =?utf-8?B?NU9OVEI3QTlFdU1PcGs4WkFsYVpqT1B5RGNqSjgvTUpHYkx4QlNzMmxqYlZW?=
 =?utf-8?B?eTAzcXNrcFpUOWdhSWZOcFJnYXo3ZzVMdG9wL0lveVdRUE92d3N5Z3hFd3pv?=
 =?utf-8?B?V2pHZUNsdkdXSEFGdXUrS3ZiNVV5QTZiT0JvTTRZNWQyeE1SaERxcU5yZTls?=
 =?utf-8?B?eDZmRS9FUlNCK1BIelcvdTZSU1NweWpKVFV3b0JRaUxnTzQrc2NDM3VtVG5C?=
 =?utf-8?B?VFRaSXhNNXhLdlU4U1Y5MkM0b3JrY2I1bW1WaTZuWWlLV3NPci91L3pZWnVj?=
 =?utf-8?B?NDRPdnlBbm0yVldVZkFsZnNSek9OVjNCM0ZJdmtITm8yMzR3ZGxZNzlTckxV?=
 =?utf-8?B?TjZCOXJaWXc1NzZXa0xTcHJRYVQwbW9XZ3JNb2kxOGV5YmhXNzRMVzN5YWhq?=
 =?utf-8?B?bnlCWk1VNFRudWM2ZEYxTmVzWGQ4cHVQU25rWkhYUnlkdG54eHNFWGtHYXBv?=
 =?utf-8?B?REFVRGk3Uy9IdWRVTnl4ZHU0Qlo3SU1lT1k1UUlVTFVIQWx0WmxONDVvNXlj?=
 =?utf-8?B?WE9QOWROdllxL3RpcWtvUmtYS0lkemNjL2ZyY2wyZ21TazNsa0c1SlJvYUFC?=
 =?utf-8?B?MDBoMnFpMmZrT3dESDVsYkphdHg4bm1VMEtrdGZkRkNKR0YrTUFvUU9ROERy?=
 =?utf-8?B?NTkxOG9KclJuNm56azlzbWxLb1llQ2ZqZC9UNUZzMTBja3pmeUhsTGhRamxO?=
 =?utf-8?B?V1liZWl1eFNUK3Z1Q3VxZkNNTmM2d0NDR3pNWG9rK3ZIb1h2a1UvdmQwZU9L?=
 =?utf-8?B?Rk44Q1RGYXJQR3Y3WExaUk5SSU9LZ3pJZHFaR0dMZy95c0lDQjIyYStyZzJL?=
 =?utf-8?B?SWcrM2VtdHExRTJtTmwrS3ptcmxIVStIMStZTE56QUNiYTlpQVpVdTR6S3Zz?=
 =?utf-8?B?L2hNZjE0ejNQbWxZcGl4LzQvdm1lRVVBQlBZNGtNR1RWUEFaeUppR21JTmFN?=
 =?utf-8?B?OFhsdVFYTjBEY2ZiazZjQXlXbDJwMDg4LytqZE5GaGdWcnFZL3NKY2MzQXY0?=
 =?utf-8?B?SzladWJSbFpNcjg2L3d4V1BjaHZ0WVJjb1hhYUplVTV1cllHdFBsZERzc0tr?=
 =?utf-8?Q?CLfjDPE5wzsRX/ZYpI2LwSpc1kJlCl0/C8z+wh+?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8e26d9c-5624-4a3f-58f4-08d91c7dc1e6
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2021 17:27:50.0913 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pBA+4CKzI9OQL2OkYS0GaY6N/rsLAU/Ulog3ClI0DJMcjTM0iHLfGLGOGKY92ON+O7ejMvLpXPJEM94go/ACzzSHRaIGSzjM2SLIQcbDEB4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4665
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9991
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105210092
X-Proofpoint-GUID: n8lPGJDGPX-hO91aQ-g-ERG5E2CxwO1-
X-Proofpoint-ORIG-GUID: n8lPGJDGPX-hO91aQ-g-ERG5E2CxwO1-
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9991
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 impostorscore=0
 mlxscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105210091
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210521_102756_715453_89838052 
X-CRM114-Status: GOOD (  20.61  )
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



On 5/21/21 3:23 AM, Hannes Reinecke wrote:
> Add an additional decoding for 'host pathing error' during connect.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/host/fabrics.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index a2bb7fc63a73..34a84d2086c7 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -336,6 +336,11 @@ static void nvmf_log_connect_error(struct nvme_ctrl *ctrl,
>   			cmd->connect.recfmt);
>   		break;
>   
> +	case NVME_SC_HOST_PATH_ERROR:
> +		dev_err(ctrl->device,
> +			"Connect command failed: host path error\n");
> +		break;
> +
>   	default:
>   		dev_err(ctrl->device,
>   			"Connect command failed, error wo/DNR bit: %d\n",
> 

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

-- 
Himanshu Madhani                                Oracle Linux Engineering

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
