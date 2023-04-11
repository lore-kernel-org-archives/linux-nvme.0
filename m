Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 936CFC77B61
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Apr 2023 00:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V21DLOW/dL2S/mHjhxma/HoOwAbpk/v8MHYiFGLePUc=; b=JteC+OAxw1YenknlJk2yYD2/Im
	4VVUxwN6T/3zkbTjTWWUxBPF434ZUXJ5gHT0uW1qiJ/YHjO0Jm6hWmPLJtC1WKLjF26qYMOJBkiRy
	IiymxlTU9Q1Lp9jvBXeU6zhc/bL4GfM4jUTBiVhstsWOFqGlBorO/T9buJZygMtrI5fds6H+D4F3S
	7+bZUFSO2rgjwwwVTnm+hk5MvUw9UVWEkm6pIjjoX6F6isB1Kob87LWkeqmaM5u8BFHJgZRqwHUI2
	/Ue0cC5R/VIHQtsWGBnYD8rKloiyi3eKVzpmnDZvCrstUNQrs3wPBu80MU05wraKa5lGR1qSdnAEa
	jVPOAedg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pm1W1-00G7vh-0E;
	Tue, 11 Apr 2023 00:05:41 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pm1Vt-00G7v1-0Z
	for linux-nvme@lists.infradead.org;
	Tue, 11 Apr 2023 00:05:36 +0000
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33AJZs85026479;
	Tue, 11 Apr 2023 00:05:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=V21DLOW/dL2S/mHjhxma/HoOwAbpk/v8MHYiFGLePUc=;
 b=P4Hy6dg1o51M6lIEVxLP/Fn/77FXTUzdjdT71ZIFzcwsyrVL+A4YD2XmR96gDfV/YroE
 32XsA+XXBBNsk88IjpTNLwBgTgWxRCww1XpxMzi5SZSM9FaOxXzPHdpYYLdJ0RMHRPpJ
 raYIBRw7kaB73GfDxmHAc2Zum8uEl9oDkoHZwtM3SHooSspct8ES82ufS8MF3WXYxJFK
 bPHtjVI6rVZ5Aj+ZLM44PqcV+j+QgUWcnj6SqQbFRde7U5vS7e6MWEqzlAOn6MFDXkXC
 ecEZU7XfNlHXPx3BqaajJ5hCPN0GyZRW+MaeKcjxUYmXXdAXt/Ju9jK5aIc+oIIyv4Ov 5A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pu0bvv2pc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Apr 2023 00:05:31 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33ALuHx4034283;
	Tue, 11 Apr 2023 00:05:30 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3puwc328kk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Apr 2023 00:05:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+YvtyqE2ajwbqa6aGqDTC3E+XfdHJd1LLdtBh759k+7iWIwa9yEw4bdK3KhHjHRUgF9JXn+hr0lsYUDV+wjsvLQwQsOtt2rg+yd7UJIzmr1QurIkIvRKixmp9i2iTAVC7idklTBWMdgTyOMrlObQaGoRkjAHxvXIEUlDtOxGDXxYJnwZMjGKtf3Q+SMsUoSXx7PB5OXTDduv4zVrZYtGNrBofq9Mn7qXPiFIoHAcfkPf+kEZ+FdlGHJx3UCYvIPXyMP44UjV6MJxsjwScOnU3uDYbt3jhhujiUvnF7ndYd4Jomqsj1XtXJdT9SvI9HP+AN+ym69k1Ujp3r1IBmuzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V21DLOW/dL2S/mHjhxma/HoOwAbpk/v8MHYiFGLePUc=;
 b=lm8pVuaUQHTtGewpXVghNPWF2VXr1unflgr6PkkhguGXIrl5OGueSBzBBl03tiRwI/s7BSHFrbH7Enj20Q2u+HXRd9GNOn5aG1Yx9HRtlJIkpSiHtDEVk/CMs27rPc/IwehisVtbQXuo+oTrciTnwTWMXjXABXqOd1fsWslDrO84Y6cg9/YdWPEhnJ6ZskvWADFkcqZmPuygaZXD/oT1ErDhSD5XvpIuDyHSWV2E1tHiA8k6YZcghT5SMCWN/eHfBkoe2kpFkJ+OL2v0K4aP2H8CGEc+5bBP1tFsxxtQlOH8KnkBdfxEcvlPDv503P7bXWipoDW12KUkwseugN03Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V21DLOW/dL2S/mHjhxma/HoOwAbpk/v8MHYiFGLePUc=;
 b=Y/4KJ9nO2yXl/KHfNJR8bgrIqTRsy2p3JE118zSPZvdjJ3hrbLanDBuZXNDebML7zLm7d9x36Z7EMoCrWPDxcjZJr+1/8V/vW0zQ7+QLzSn3qpbaq5ftu055K4vInOrqs1/PEugBmOByAUxFEYuRjBwqFOaMYoNWPue4dKz1iDo=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by BY5PR10MB4244.namprd10.prod.outlook.com (2603:10b6:a03:207::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Tue, 11 Apr
 2023 00:05:25 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::e206:6854:c7ed:225c]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::e206:6854:c7ed:225c%6]) with mapi id 15.20.6277.038; Tue, 11 Apr 2023
 00:05:25 +0000
Message-ID: <0c50fbf6-4bc3-7289-2a39-072191c81dbe@oracle.com>
Date: Mon, 10 Apr 2023 17:05:22 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH V5 0/1] nvme: allow passthru cmd error logging
Content-Language: en-US
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org
References: <20230409212538.18647-1-kch@nvidia.com>
From: alan.adamson@oracle.com
In-Reply-To: <20230409212538.18647-1-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0133.namprd11.prod.outlook.com
 (2603:10b6:806:131::18) To SJ0PR10MB5550.namprd10.prod.outlook.com
 (2603:10b6:a03:3d3::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5550:EE_|BY5PR10MB4244:EE_
X-MS-Office365-Filtering-Correlation-Id: 0850e103-bfe3-4d88-856b-08db3a20736d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	sJ/lx2i2/bON4vum+gkmjE/xUh4KIhUfOMje0yk3Kl3GMEziYDI1Rq2dvOhV2kDSxeoYXLh6p3dXGh1mHLwpez7/To/j79qgsTOmXU+BKaqwQNi4mFlg5HS1QKGGaKoKoSZ+ZveywmGZ78qVGtrX2SEd6VAk5bIyEebmne3F1SBN8QxR5k7cuNJAHWK6Rnp+IpvwujQYFp8GcG8WBZgXaLiY5AMD/ZVf3hNdl3Eo4cZB7BlolGEyFW+gwbgOR0axYkqoPuWKpq5DjnTEc2WCyARTEW3PpSYyhkv2WTv3mYSA1inPRZo59kaVkaQQEqwxiFxFDqf4VUjOtSgWk2HQmdSwunJTWiJAO98tHBEN3OrMckeLPsXr8FOEbeg6j0viL57cHOZbTKv+MCx51QmRyfMv4coqQa67FdPGTC0ZjS/vSu4RClJf0fBK1Ze9rAUThYh6JpTMo1ZqdbQ09dkLQtvAlNa7UI4DS/R3ujeuLK3dyBuhWArAONakY5bzt6aXaZABPIWUpg9i4bMmxbrEFuiQXP1O7bIaPTG7jQTpAziR2uMgBT+fZI2ALaixyFhj09Hc76ATHyBxvGPzVGG2jqnbePzq3SVEmeLFtQA3oYDi3oCqQP+9VEWF5HeMKt/z
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5550.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(346002)(136003)(366004)(396003)(451199021)(36756003)(86362001)(31696002)(41300700001)(316002)(478600001)(8676002)(66946007)(66476007)(6486002)(6916009)(66556008)(4326008)(5660300002)(2906002)(8936002)(4744005)(186003)(38100700002)(53546011)(6666004)(6512007)(6506007)(9686003)(26005)(2616005)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?dDY0azA0S0ZBWnhzc3N1VTBDUUZnaVlMUFJodEg3WGdlaGNsRDhmSllhTU5l?=
 =?utf-8?B?TGEwWlNITUQxcjVqZmFDRURDVitRTzdBV0V2eUJadXhuZkpDKzRydDJMMEUy?=
 =?utf-8?B?NHJWUW9vQlgrRjJQN3Z6OVF0YitPZjlENUwwdzRrOXdBQ09RM2dpZ2l3R1p4?=
 =?utf-8?B?ZUpsK3grUXExWDJicGpSRjhESHhJenZjWDVPY0prY0M1eXh2WXhDS3FPZnFq?=
 =?utf-8?B?MEtURG9BWFBXZDlHdlhCSlo4QVFuZklYTHZ1VHBuTUt6NWk3TjhIUVZiK1l2?=
 =?utf-8?B?Y0pJNy85VE5UWE1KdGRCbC92dXorNHVVMFFkUnZYaENZYzhGK2xWMmZ2T0Yz?=
 =?utf-8?B?cXRaWkx3SWxDeUt0K0U0WjJDRllPTzlCQk14VkM4dXRuUVYrc3hORUVtMXhK?=
 =?utf-8?B?ckxpWDdjcHA2YTNsWmJjVllGZ3JaaTBzWEdBd2l2U0s0SVEwUTExem1laGhP?=
 =?utf-8?B?bDJoenFPTG03WDcxVjZSNDdRWWJTRnd3cmx6YVhsN2VsL1ZGelBxdkVicHRt?=
 =?utf-8?B?SVViOFdMaHRGdnNFRXBnM0dkWnhkMjR4aisyQzFQVDQwWlIrWU5ObnFjTi9I?=
 =?utf-8?B?RnVmYzN4cmNVOXNXanlWN0syV3F1R2tJeE9DSGR3bC9lOFZIYzB2bFVZOGFN?=
 =?utf-8?B?ZUJGQnBiNTc2L1VPcDhnYjN4cDQ1TXpJV0tqdnZzVFYrKzlhVU1TMUZnTVho?=
 =?utf-8?B?c2NxWjYycUk1WDNta25oOWdOTzV4SW80ekpOMThlU0ZoYVVHRHRzaEFXUnJQ?=
 =?utf-8?B?dmhZL2h1cVFiS1V1UU9uUGpGU0hxelgrTHV2VDU2NmlzcG1JeWQ1eWxjWEJN?=
 =?utf-8?B?eVNRVjlna0FwaUk1YWtHWWw4bUJqMzN1R3VIc2pSVy8rakFUWWtFalprZ1JX?=
 =?utf-8?B?THdYVWRmb1hGZTlyNDVqVFZYQmVHMWlUSWxYeU1zTDhCRkt6aUZpMUFETzNO?=
 =?utf-8?B?NkFZc2pWcWg5S2dxS0Z5QnZsbDFrWVpvUXlpa2thNy92VFdBdFd1ZjJuY09R?=
 =?utf-8?B?V2xkbXh0ZUMxVE9NWTNSWW5yYjZVZ1Q0MFl1WWs5WHVNenM1S09ubkZCYTdB?=
 =?utf-8?B?Nk1vQTBoSDFOUjRLZTVqb3ZZSzhESEZvNXREOXRjaGZ5WW1tdlBzVURoaHhJ?=
 =?utf-8?B?Wm83azBCdmZHZndlV2lDdEEvK0Zva3cvZTR6TTQ4ZEs1ZndqK21vNGdRN2Qx?=
 =?utf-8?B?QTVDTVgwYzRNN1dPZVRuUHZhOVVNN3VxVHMwQzRhd25CdW5FTG9xdVJxV0lY?=
 =?utf-8?B?eFZydTN4aTdad05COFlDWnFCNkc0UE1QZERHTStvZnZiMlBXYVlaZUNPaks5?=
 =?utf-8?B?dUpJWkpZV21OTExIUE9weXZaRVJZNGpnekIrcHZFcXJPbGVVYjZ5VFUrbjAz?=
 =?utf-8?B?L1hKR1A3cDRzYkhzQ0Z4ajRlZXFXY2tqV0hlbUp4K29BVVlkdFhvdVhoeXRC?=
 =?utf-8?B?N2tzeGlOU3ZvUi80cWo0d2prYWZkMTNQcm9BM3M0NXpkRDVlUytKeHQvL0Vy?=
 =?utf-8?B?SU9lVGF6RmxIb3JuaEVJQjZDQTZSY0IrcWlwcktONVd0TjRGN3QzTTdwZU1z?=
 =?utf-8?B?ZDZ0YzZVdC9KY0sweVIxUG5DOXlJMnlML0VJa3llSkpyYXNNU05QWDdaWjlT?=
 =?utf-8?B?c0xtRzNQNG5QMTJLZzdjbzdsWC9sQ1FvTW9wT0xFWEsrY2JaYnBudVp6MFhP?=
 =?utf-8?B?YkpuZFBQZUIzc0hNUkxuVy9rSXdZZGpKOENFak84WXlNcU1Ud2hRNjM1OHVH?=
 =?utf-8?B?RUhzRjg1L25rckdUNjlkbHNPb3FMWnZkaEN0VDFNVHRJUFE5ZzI4cWlHVFVa?=
 =?utf-8?B?L2Vpd210YkRqTmJMby9yb2x1Mmt2TXd5N1dRMk5maTlYY0pZT2RIbFUxZ1Ji?=
 =?utf-8?B?TXF0aXNlMzZ2b2krblRwT2FacjRtWStrRXhtb1ZNRVkrRFdJWGtHU1ViZ2dL?=
 =?utf-8?B?M3hUOTMvdDJHcW5TN1ljbytucWh2dEpobDBtampJOW1NR2F6emxWREI0Wm5j?=
 =?utf-8?B?R25aTFNNMHpxaHovdXk3ZjNIQ3ZLUHJBaXgxZ0NEMFhubWgrZlBLRVRnZnJt?=
 =?utf-8?B?NmJiUkhyMGlzQUFXRTRMcW9hNVcxaXI4T0JDMzRoTHRNcllETmxwVWtoZUYw?=
 =?utf-8?Q?0wmzjksbUcmipYD3Tm9lZFfy0?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	GDbD9sAPzMGeg2Tm79FB2hZeBCjEznJpRfjxfDE6gv8j/ehLctNSy0WCFEbstBtnSSA5mY+6MAmHQPicK1P3uunorsF9HSNDaIGv7Gje2Cwgoh/1AvEMtmf45zYGJL5Wy2oWI4fcd4ZFyGva8Ac162fK4yU1akBIpDQ7/WtXh/9kDD+zw/eDCjyGnzHHltZNeIMoytKx4it1Fb75JKNU6ajhhme8DHtj8ak9Mjo2E5xOHM23uHKxVEZxg7mYYz1R6mxL8ybEfuYa5r0mxBdSFl+GW+L1bvTQigRfirZcpF/mxOSxEs48OzDG6gfNDvKsQd1Tsmb4RIYE+OW+nAp254paxWQlRswsgxKSByobHV7PMWYYlIUXAlJ07BjYrdTUOcEqDcbTMMlUwHYs/UkrG9rhtA7rj0mDl4Lx1GZ2e9gChnn4NQ4Y53X/DpBbAyPOlm49nSC+scvKppCCpiYB0sgmhWzKL+QiaE7YNjfr6FrazGpBNnAWIFH5rPjXwh0Wxze7LzBQHPCjx96/VR8kAEtGV3xSLcFGoUyXzkCOyFCKqdKOyEizP2l22BCOMAcbby9zLbz1HjJ7C1sDoR1TBtqCRuZAppQmkzHHX+ELIHTKlKqYoFmisa+Q9nz69R/UnqmtrlvOalPnXXwY+8HKBdysuDAkoRyK6LEJ/rY9Eh6pirjRY9RCzvRNhq2TOw29W7Z/3RR8CpNmwoNEL8M4iVcK/5EL2tiXZjy5cu7RwzibPeVZwGa0O6W+0IPGoo68NTGkykkll5inhwSyM9GGvRiKb7x1Mk8VPVimKhKA5K+bMmDyRqa1pGH42oibM62R
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0850e103-bfe3-4d88-856b-08db3a20736d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 00:05:25.5894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yMpEV3tQI79dhVV8gOv7js87ZLbcHYoBBmYDClolbEDOR07pLdPGLcNJlenV7zsTWY/Bakf4QY2gSo0Cm6fW3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4244
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-10_17,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304100211
X-Proofpoint-GUID: 12q13oYnw8PpU3pCu1GuPBvfUKapjINh
X-Proofpoint-ORIG-GUID: 12q13oYnw8PpU3pCu1GuPBvfUKapjINh
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230410_170534_164411_6DE79641 
X-CRM114-Status: GOOD (  17.25  )
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


On 4/9/23 2:25 PM, Chaitanya Kulkarni wrote:
> Hi Alan,
>
> I spnet some time on the V4 to fix several nits and testing with keeping
> your authorship, please have a look, feel free to send a next version
> if you find something not right.
>
> In nvme_end_req()_ we only log errors which are for non-passthru
> commands. Add a helper function nvme_log_err_passthru() which allows us
> to log error for passthru commands by decoding cdw10-cdw15 values of
> nvme command.

CK,

Thanks for doing this. Looks good.  I've tested it in my environment.

Alan



