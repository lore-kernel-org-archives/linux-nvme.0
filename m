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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA684C4338F
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Aug 2021 19:38:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BDFB61103
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Aug 2021 19:38:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8BDFB61103
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WFVWxJIh4W8rAqPoG9OIXRMf3sBTie2nRw8SY1A7zok=; b=tsRK1sJMxJ+E+rlkKMbgkuBRKO
	EK+OdUrcDZ5rWWqqmiFKWw+sJLWFsR31iveeluCZfCND0aVExBZf1m6nMrDxkdNqeudqW0e9oLUds
	pv+oeSm7gSTmO2xb6t84/5sKMtn8CfpwfjjUNQyxsZ1rH6kEC9TcOfRtQ6d+xQXSMCt0Ofszqrgq2
	FLqOW9TNwVN8SmJzen38PcapLPkMhLGrurZE1kIjDHat9j+6rakzkbLUieOqrcmKGlklePI4ibqKR
	Oh0ZjCCCyTcK/i8UE1uXHj1aWML716x1rS15BdAnkWEOQZ65mLFNZZf35rCYRGWudQHrUXQ85lggS
	VxqTQmoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mAdlc-00043A-IY; Mon, 02 Aug 2021 19:38:28 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mAdlX-00041z-38
 for linux-nvme@lists.infradead.org; Mon, 02 Aug 2021 19:38:26 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 172JWuxp001973; Mon, 2 Aug 2021 19:38:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=+qRGhwPJL6Atr2VCR/G6BP8oCApGUXI6VAS8hllaHWo=;
 b=iyDhxzwZ9uJRgSNIHVhWMHyIw0OibHs/eVjCKhz3G+VI2Cez1KiyLbGc7mowqd1R9p+n
 0FaKEcPWjJahdK+8btMMSxHrHC1cX0FN9kw6lES70edpTZoodsoHAVzT7TIePm6m+dGp
 88swg76OKQ1Knivy/6ZaqfJk0IPNlRN+84pJ0aQpUScGmTuGIHQMnYuk3YdxjuFh4ER4
 gB/7CsaooriXAnDCquXKKsQuYfm1OXz03tjwAbUQuOa6ELS01N2WY44qUZLDhTzQ4eLE
 c6B4hiFuUIcVfSVe969VPGfvyCMy/z1wJKQrjghpxnJFjIw1u/FIPrbEO0JQ4xbxjfxh UA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=+qRGhwPJL6Atr2VCR/G6BP8oCApGUXI6VAS8hllaHWo=;
 b=NBOVF0lFm5XJCe/BqbnhePsSIIMBQL1iyLCsHXb8udJye0f7/JjbS7bkS7DV6Qv4gqKt
 7IDHOeLQxqvjb2iFvABNmBLdlaJbUZGrJnGPoOwKO1WCog2InHiufQJ6dU760T6k8u+t
 yHy7FEbIy3d5Dtx1p8n1zipADSwD5RHi9ly7pENai9t0FgCM21/VCpCAL93vkp8e32f8
 kbF+O0GcYP2yuKDJuNLshJboX0iSeMCkNOt7Kg1KlyWbDCIKz75fJeg49igE96/IQOjQ
 +dv0C6QY39C1E9YDCho5sdlRBCdEeItR5xFGgndM3IastLnctm3nXV/n/aRvVvkeeGAf RA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 3a6cnthmw2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 02 Aug 2021 19:38:10 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 172JU39A157162;
 Mon, 2 Aug 2021 19:38:09 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam08lp2040.outbound.protection.outlook.com [104.47.73.40])
 by aserp3030.oracle.com with ESMTP id 3a4vjcjfxx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 02 Aug 2021 19:38:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VrMdNxqvAVqtMMF1vZ6n7YZCUlsq2q2loJtrB0GIJnIZKbGFoP8GG8P8sQZ0210YFsBFseo7SdegtVRFvbtXLoFARdol2LjvX05Tm/4a8Yy2d81OG5t1p2IhnMohDyUGjXT3WeD0YYQ7cCcSdj0MqfK5bULYrvPO/CffUOYlaz1kjLxdV+fg78bXE+Y8yVdgyTdjZWCAs8DwgAq14av15+2Zf35bUhrSOUjMORfgpvGsOEXQusg9nR8Es+A/Gw/U30witfEnRvZNWcyMxH7hNwjdomy+2Fa1EHsl2KWNbBm1eO16b9OoGjygxNXUKpB5FdtjvnCjnwlDdW/9fRqqhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qRGhwPJL6Atr2VCR/G6BP8oCApGUXI6VAS8hllaHWo=;
 b=hCN6e8HhqbLQOg4ZxBRGpY/haIhoACwqOnsW5bh37MH6PhP/xNAgzLAoiIwREfFCldvPZcQBx3jYvTFymI5/XOAHerwI8BV6Lm1yDO7CbMvn74GBvTAtu0q5kmNTNdAPPa8hkoGRrSNKRuPilzr8q/YPYYcxK/QUdXxYbDLQgJWUTI4teApG5DIlDjNb5rbaLL1iLqEUqKAR4ik69c8/tBH+t56PFUtHfvhL8KcT2JMd02D8eqs+sl8d2p3u68UyWQL4YoQntE44yoqNaRCl1TTH3nBic4YmSrfdCfsHKQkVwlm/NAaDXcv7ByDjLSr78SNMXbNObixyHQzXJahoyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qRGhwPJL6Atr2VCR/G6BP8oCApGUXI6VAS8hllaHWo=;
 b=lxYFcykoyWNw35LZV+qP9Hf9XIOUHg3qDFqHp8y0WNzb2t1Aj65b/HG4agFZhY+/e7wFpwmSfOVoCI+ipiER+HMFHbwvKWetHjrkdWQ3FwXT9ASchI7czp7IQG3jl9OX0WsThBPX1oUYWoB2f2PkeBolrCrWwNR9JX1MrfrgjiM=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=oracle.com;
Received: from SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19)
 by SA2PR10MB4604.namprd10.prod.outlook.com (2603:10b6:806:11c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.19; Mon, 2 Aug
 2021 19:38:08 +0000
Received: from SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::7c0c:7f1d:bbb2:b43]) by SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::7c0c:7f1d:bbb2:b43%5]) with mapi id 15.20.4373.026; Mon, 2 Aug 2021
 19:38:07 +0000
Subject: Re: [PATCH v4 5/8] nvme-fc: avoid race between time out and tear down
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>,
 Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
 Wen Xiong <wenxiong@us.ibm.com>, James Smart <jsmart2021@gmail.com>,
 Chao Leng <lengchao@huawei.com>
References: <20210802112658.75875-1-dwagner@suse.de>
 <20210802112658.75875-6-dwagner@suse.de>
From: Himanshu Madhani <himanshu.madhani@oracle.com>
Organization: Oracle
Message-ID: <40d87a70-c6f8-0d84-2dd2-86383794ee45@oracle.com>
Date: Mon, 2 Aug 2021 14:38:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210802112658.75875-6-dwagner@suse.de>
Content-Language: en-US
X-ClientProxiedBy: SA9PR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:806:20::31) To SN6PR10MB2943.namprd10.prod.outlook.com
 (2603:10b6:805:d4::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2606:b400:2001:93:8000::b52] (2606:b400:8004:44::1e) by
 SA9PR03CA0026.namprd03.prod.outlook.com (2603:10b6:806:20::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.19 via Frontend Transport; Mon, 2 Aug 2021 19:38:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ac9fdb2-ee9e-4416-9181-08d955ed0dd7
X-MS-TrafficTypeDiagnostic: SA2PR10MB4604:
X-Microsoft-Antispam-PRVS: <SA2PR10MB4604771F7DD2057417AED29DE6EF9@SA2PR10MB4604.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:185;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vCwSjx8fAfVQR3wAeY4COU1aQtNnJNg/RbLm8wxetdqPraJiIKPMBLNnrkm5hzGSJEC8dBzgtRfmqSYIM0xXtEdohERsiUIxVCJLacfeH21ai648RIvxcjRloU9i5cKvckYJLtYiRO5bT7XKP7JLnrkREBmfDfMBkp9hyp2A3rBIoz59fmv/BoqjM53q8asogw6BRW0dtL/+bBC6gXJhKvmG3WkSWwE5lSAAQ+F8O29pilxvGXw54SLwRq2NRykjASZEg5Ti6+JyF8TiKm1PL2ys9u9aE+P/THl/uvhdfbYWyPPdPEzemFyIxkwmTl7nb47H86EHBAlw3e6STGfOQn9OlNIuUV552YEi6AhTNW9e18fPa7yACxa9w97G+yXiu/CBhxbO8DrGLngoR2ZrOnY/Vtn4edcsej5i8XekY188zZXdNGyegYyGLBHS1pKFx9jl5li+0tT1RngHzg7LErlLFHrT8FgTlFA3NbX5kIqCkh2qblllnNhPMhGBuApNZBVG0DZJ95Yk/hBLPve55KAVvKls93IceaZPJqmwWVezrG196mChysb7XnywOfsvH1aIZ7WLye2AbM/oJLvgxvRWpUF+i5ZfWgBEbK65eyBwohSnYz2CE/KcPh+FtwEbo1AGvJmFR0QifY8ZibjUw+e41JwUs/X4H5FxicvT737Efisp5U4OQR8U740HLP6H044m/j2Vs/bHtEeZcQFEnLCpm91jfQH/+R7kVzX66i8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR10MB2943.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(346002)(136003)(376002)(39860400002)(396003)(38100700002)(2616005)(66946007)(316002)(86362001)(83380400001)(186003)(53546011)(5660300002)(44832011)(54906003)(2906002)(8676002)(36756003)(36916002)(7416002)(66476007)(66556008)(31686004)(478600001)(4326008)(8936002)(6486002)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1djanlXdXNSUTNNMlRKY0JqY1NCYnFEaEJacDNpUE5YTENKMmtyMzZ0OE10?=
 =?utf-8?B?RG9VUnp4K2JWa3pxSHUydVpsNkd0eVBSUGxwOVJBdFhQbVhKNlhpZ1B4Z0du?=
 =?utf-8?B?aHA4dklpZkFIdXM1QUFTMDVDRXhPdm5MU0g2VlluY0JMcTkxN29uaWtUcS8w?=
 =?utf-8?B?cGNLdm9OVGxpWEZMbGxhcHNDNUYvY0ZmSVNCS0hYVWxSUy9DRHgySUJKWmp6?=
 =?utf-8?B?bnJIZXVpUExDSmVNUDJGNnAzcTlQblk3RStSMlNxZEhta0hEZ2ZyeFlIRGlW?=
 =?utf-8?B?R2xQMVB5R1ZhYkFmTlJ1R1M1SUg1a3EzeUZybjJWclFKM1hGYXBZK1c4UXRj?=
 =?utf-8?B?dCthenJFRHY4MTI1THNkNVh0ZjhIdVFEbEdnR1RBdFlQbFpVcUZRMm84bUxJ?=
 =?utf-8?B?MUlaN3hQaEFXaFRUVXpBSGRMRU9YNWpyaTM3cHBKWTRIRU5jWWwxZWdHcHNS?=
 =?utf-8?B?bXJseHpjYkdwZ3RVQnZQd2lXd2t0aU5YOWZMWHFSRWFUTS9NMUxLMElVblRY?=
 =?utf-8?B?OEJ3SW1VbnFvNklxOHN2dEdLM2VBL1NLUVNoelJmeGpxR3BGQXFkemlqN2V4?=
 =?utf-8?B?S1E4M2pQZUxxaDB0bFl1OVQxYXNFcC8wZkVoWGNYaGlRN1BzLzZqMCtoT0Jl?=
 =?utf-8?B?ZktmdS80dEZNVGJZa2R4ZzF4allCejR2ZWI4MDl1b1FCWEJCSjA0RHQyQ3Mz?=
 =?utf-8?B?b3RHL1hSUG9wZkYrczlRYTNlbUdoK3lNeDRPa1ltMUJOQ3hzZ0h5SUtjdHg2?=
 =?utf-8?B?MURUYml2MDlINjFuaFZqaU1aOGtyMkZxMTlRTE1VNUF5MFNNeFp6dnRqTFpB?=
 =?utf-8?B?aU9yNlE3RENDRnRPdzM5V0RjQ0U1eEsvbHRCbjcyY3E5S3E1Zzk2KytYWjBx?=
 =?utf-8?B?RnRWcGZwQ1IrNnhXOHZrQmoydUw4ejYxVmNKSElsalk5Nml3Q3hFemsvYjlR?=
 =?utf-8?B?dGJ1MGdtOVd2R2hUMTRXUFNNaERwWjZYUm9aTXRJcFQrMEprMnVMelJBYzlX?=
 =?utf-8?B?TWFZTitGMUpnM21qS1V3VXZWT3V2NldLN1dLRjBWZE9sS3U0aXRCKytXQ1R2?=
 =?utf-8?B?QTZmS0l0bklVaGwwb1YrRUh2VnpNYmhVMDVpUzYzZVZ1bFNuc3piMXg0YXp4?=
 =?utf-8?B?bDNXakpBVFlBYzVwNERtRHpOd0pwbmxwMitFenZtK01pdHJEaFBVZm1nOXNC?=
 =?utf-8?B?NjJrajZEMUs3U0c3Q1Jid05DYmNiNE9DMitCZFZlZGdXMSs5TmI3YVo3NmlR?=
 =?utf-8?B?UkhjME40T241dmJheUhjNWdZMXhrNjNXeE16SHZyazFmYlFqZ09TR0pRWHQy?=
 =?utf-8?B?eVdkMEE2TksrOXlpNEo3ZlBWaWREYjNOeE55ODkySW1GQytEejZUMHJsdkRG?=
 =?utf-8?B?TjhXQXBaTmtqeEJ6QnE4cXdYZEVyWEdmOVpNRjROTy9na1F5TFNSQzJoRUVV?=
 =?utf-8?B?SVR6TGNnM3JCYTZMWW5RYmJmR1lObHBNTU9FKzF6T2J0VHI3eklOUHVVTktp?=
 =?utf-8?B?NkE1bEVMNmhmcjUzWDdodDk2eHd2Z1ZGVWxZOTJCQ1lMOXdYZ25xRS9ialJ1?=
 =?utf-8?B?Z2IzVjhoL3VyM24zcVo4N2kwK1RCQ2hJMGRid0NtTSt6bmpRZTYvVG9VNkhC?=
 =?utf-8?B?Y1VpZXZNTXBSTkxrVGYvMkF1TDVjMVVra0FLcEk2aGV0UENObHZpZXhzVGg0?=
 =?utf-8?B?dmJzOEkyLzBacEtGdzlRaDc0RWwwUVkzTzF5djNVRkVhaXIyRXBTV3NiQ2VX?=
 =?utf-8?B?Zk9DUSt3b3hidEpweU1VZ0hHRHg4QVdGWUQ2M0JoeHo1SHhOdEVEczJ2WmZr?=
 =?utf-8?B?UlJDYnM1RU9JMzdnZ2lEZz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ac9fdb2-ee9e-4416-9181-08d955ed0dd7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2021 19:38:07.8206 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z0wjeG6YkFiiWV/lJMMCTR70Sq3qUTrjO2l/rR4FVC9tHdMXyMUYpsbLagQjVtVon+jOBwBKmqZ8sv1b7DUYCulgTt8isuh/o1aaScmKJH4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4604
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10064
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 suspectscore=0 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108020125
X-Proofpoint-ORIG-GUID: H2MHNUU3dlHrhbPUExBkIlHcqqfubDVE
X-Proofpoint-GUID: H2MHNUU3dlHrhbPUExBkIlHcqqfubDVE
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210802_123823_339043_18602467 
X-CRM114-Status: GOOD (  26.05  )
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
> From: James Smart <jsmart2021@gmail.com>
> 
> To avoid race between time out and tear down, in tear down process,
> first we quiesce the queue, and then delete the timer and cancel
> the time out work for the queue.
> 
> This patch merges the admin and io sync ops into the queue teardown logic
> as shown in the RDMA patch 3017013dcc "nvme-rdma: avoid race between time
> out and tear down". There is no teardown_lock in nvme-fc.
> 
> Signed-off-by: James Smart <jsmart2021@gmail.com>
> CC: Chao Leng <lengchao@huawei.com>
> Tested-by: Daniel Wagner <dwagner@suse.de>
> [dwagner: updated commit id referenced in commit message]
> Reviewed-by: Daniel Wagner <dwagner@suse.de>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/host/fc.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index dbb8ad816df8..133b87db4f1d 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -2487,6 +2487,7 @@ __nvme_fc_abort_outstanding_ios(struct nvme_fc_ctrl *ctrl, bool start_queues)
>   	 */
>   	if (ctrl->ctrl.queue_count > 1) {
>   		nvme_stop_queues(&ctrl->ctrl);
> +		nvme_sync_io_queues(&ctrl->ctrl);
>   		blk_mq_tagset_busy_iter(&ctrl->tag_set,
>   				nvme_fc_terminate_exchange, &ctrl->ctrl);
>   		blk_mq_tagset_wait_completed_request(&ctrl->tag_set);
> @@ -2510,6 +2511,7 @@ __nvme_fc_abort_outstanding_ios(struct nvme_fc_ctrl *ctrl, bool start_queues)
>   	 * clean up the admin queue. Same thing as above.
>   	 */
>   	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
> +	blk_sync_queue(ctrl->ctrl.admin_q);
>   	blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
>   				nvme_fc_terminate_exchange, &ctrl->ctrl);
>   	blk_mq_tagset_wait_completed_request(&ctrl->admin_tag_set);
> 

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

-- 
Himanshu Madhani                                Oracle Linux Engineering

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
