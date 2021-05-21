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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4BECC4707A
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 17:29:29 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 387E761168
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 17:29:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 387E761168
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2Wps6m3khOuuASz8DwaHsyOPN3mDoCGGihpeZeuTpYM=; b=l0HCAU/JJNdHCYjysTSCZYukAZ
	NB+yfV4Oo5VvqoGAWi2hbbCt1krpuqgsKQHH2kIpgRwGEo4NiKz1/ulOE2BhJRZpIhPnke+OLY5A4
	cf0Gg3KpgeAMZI4n7Pty3msfOLVmz2CfZSaDMNdJt2XLIdW38Wh8AKdM90K1Sn77u4cFTNe2bmfHl
	tRu9oERJlPmYJKoOj/KwU3lBCPCpfUnP2fcl3XAUxLnGtsMJeKQc8INrpw9SSpCdKkugaFlU6W9In
	IbRSZjkolQHUTqIUgmBz6z/2DFVohD0op77Q2AmttuYhqGYE0jrOHqOgHkVkiYtwkDa5nSavJGYQn
	XXDtjD0A==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lk8xY-000VVP-Qs; Fri, 21 May 2021 17:29:16 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lk8wz-000VKv-Cb
 for linux-nvme@desiato.infradead.org; Fri, 21 May 2021 17:28:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:In-Reply-To:Date:Message-ID:From:
 References:Cc:To:Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=AVmeNug8M7N3VRwIeXG1TKinFe95HfsrB1Qj/zSgglM=; b=w3ZM+HFXaF9jSVicKcLwY+sB5K
 CDi2+gjyeIgryPNSzfGeumUdpnqgFIYEj7EjGc8Q+9E3xmjJab0zrZzi4RAux4xp49a9QOSCwZVi2
 RuAWhhjJ7uNMgHo8gQwzZDw59RoaMctpEHXMlD5G/7hbtq2Xge0+yRxN6WBFAsbh+X66i2iWIp43+
 Rp7d3ymttqNbVapo8zlCG3rN69goV26G9JH4+wMLERzWPy+boTIKNNKQNgbWhPtDiyLD9BlHt0xYD
 HTbSW920kSUhZgsQLdiJvuh+3VpbUiZhQF1Fx77o0eet0Sj+thLASNELo0zNa/rGedX7RmPYrgjEX
 ZYzkszlg==;
Received: from aserp2130.oracle.com ([141.146.126.79])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lk8ww-00HJTC-II
 for linux-nvme@lists.infradead.org; Fri, 21 May 2021 17:28:40 +0000
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14LHAcel046403;
 Fri, 21 May 2021 17:28:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=AVmeNug8M7N3VRwIeXG1TKinFe95HfsrB1Qj/zSgglM=;
 b=dmwgLpq7/xLaPNP2mfmGCwMvltrjcaHuCxOUyxKxCE63tF44XdIUI877Z18XsVkrLJ6k
 /wx3bt24/yWDE/MH1ipOjHr8RXZWXQVCeBydwROt12d03ulUuPjTA9h/VdkMEHZddybK
 SNhFpsGFUXT2iaosEHduSg9EzEZPfrwIlAKcO27KbBfbFvvM1QFlRwVKRyqea3FN3LGf
 OYByAAdTegiwL68W3uPFBjggVd9KxKfpl6raVkwee6l8taiYLzMQGWFZUD8/eLqu+Pr1
 ozcWiLyliutmnjt9QZvzgpiikPF3bl+aurJBa0IhFO+iTNlVh5nLPVQ/p8Le1qiaRErv sw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2130.oracle.com with ESMTP id 38j3tbrdr9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 May 2021 17:28:35 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14LHQYV5049521;
 Fri, 21 May 2021 17:28:34 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
 by userp3030.oracle.com with ESMTP id 38megns8pj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 May 2021 17:28:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fd3/qMMvv7+CkrHLEfbHZveMD6RivMa5aOEZ3k928kin099DA2jSy0X16iBqtp+SvXTihBPp/aWDgOi2skVkP3LvlyUz0lJyD2yoljR2chWs3ZRg0tIKVndhH1ntKtB3P/HZ0RJiiAnf4N0SQhac5uxAVkDJQ4wbqHqT18G3D+PZ11kc4esWpIUxpC1WHC/gf1IRqn/QjqVvFP45xkggnY7IDsx9NWtCQiEeCkAlhztOT4tUrJ4wLsMb8elE9PwSYZa/f3eoL89FpQINoRtN0ciDpKK1BTvN7uv0VfVRs4Z+wCwwD0mSWFaKFwFdGEFVqzoGGyPKIbbgSycSCBPEFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AVmeNug8M7N3VRwIeXG1TKinFe95HfsrB1Qj/zSgglM=;
 b=V4KliBr/PaDGBbdf0urk87+eDJ6128ohGGLoSMNyIWWGB9IE26lmnzJFPPCDM/mpRqu3JZ+F2ClhqPQEFy/cXolL4xm+LU+GR68GKBZL/QI6IEpWEC7uSKbL2kuPTudXCcqD5z0YiAGMsJFJak0n0J5ZYoLLe6saXsQsnpUqCrKOfnct6uKQT+xBsXvZDLW5ygYEMX6VxD8xtpOZMHFb7VKhDsAFY+zb7XO1itZtMvDNnb3k/P4U0plveiE7tOymCsCUi9kIfHAV4QNK0TQ/TW46GyudBGUSzOU6FGfwrvCLYrdKBLAZQTiFJ41y79dB0ld3pDTGStwLG2C3qM6Sdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AVmeNug8M7N3VRwIeXG1TKinFe95HfsrB1Qj/zSgglM=;
 b=SCImGJUICr7E2TPKNzMLeDdJt3EGbbRVgonhHNHEPlgWml4wxrkLJ8buMc6C3kwTy8mCUAllxWgUAEi1r721oI+AxuBYw6ciZSsxpB5oAMdlgGmM7FXgtF1RyG3pWJ49oYdXjTHcqJcCVmChDc6ozhnIzW36JQbNpr0+dpccAl0=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=oracle.com;
Received: from SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19)
 by SA2PR10MB4665.namprd10.prod.outlook.com (2603:10b6:806:fb::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Fri, 21 May
 2021 17:28:32 +0000
Received: from SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::168:1a9:228:46f3]) by SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::168:1a9:228:46f3%6]) with mapi id 15.20.4129.034; Fri, 21 May 2021
 17:28:32 +0000
Subject: Re: [PATCH] nvme/fc: Short-circuit reconnect retries
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 James Smart <james.smart@broadcom.com>, linux-nvme@lists.infradead.org
References: <20210521082300.146648-1-hare@suse.de>
From: Himanshu Madhani <himanshu.madhani@oracle.com>
Organization: Oracle
Message-ID: <18ffaa95-62c3-323b-5f7e-79ee469b5f87@oracle.com>
Date: Fri, 21 May 2021 12:28:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <20210521082300.146648-1-hare@suse.de>
Content-Language: en-US
X-Originating-IP: [70.114.128.235]
X-ClientProxiedBy: SN4PR0501CA0137.namprd05.prod.outlook.com
 (2603:10b6:803:2c::15) To SN6PR10MB2943.namprd10.prod.outlook.com
 (2603:10b6:805:d4::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.28] (70.114.128.235) by
 SN4PR0501CA0137.namprd05.prod.outlook.com (2603:10b6:803:2c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.12 via Frontend
 Transport; Fri, 21 May 2021 17:28:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d19c11e5-83ae-4a75-66f7-08d91c7ddb02
X-MS-TrafficTypeDiagnostic: SA2PR10MB4665:
X-Microsoft-Antispam-PRVS: <SA2PR10MB4665AC3F3A3D5F333EAF50AFE6299@SA2PR10MB4665.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xYibHq9/4xAvoPIP7VrN3x4XgJgqCiVRZefp08qzUo4RPCeJwnKeeLdpLjNIDDEKvRvZjCULjFBWoaPTwc35W+YypAn9qTiBQls6sYqDlyMFKMlIdLZp09J0zXZOBu1Nd42oQYK9Hd5qg6bGSPutMFwAA5IDDnPe3BRVvJuPBQxJkfkH+DS6my3BvOo+t74sanRChjhN+YE/iev2fnO6lKhbUyvZAgDuJk+Jnn1o9E3+mK7VUo3KhKTwhxdRcR3P9LH4wJ6eADsD4ycT9Sx6XZ2leAsZTuTfUxyo0GjnG62RGFfcRxR26w9SNUjj5qFWQQunCBg5ntsg3udEh5JrsksSpAi4BkweCZrFD2g3bdi0iunRzWDs+eld890NJIOLk/gFzBGNvG4UvrJrFGvtV8j/bUDkY1moFi7c317GjKD2DuJNcniQLGMTSpHCXtrYLjSBG0amxQ4l/m+crzu6GV3VV4rA5vWDVHjVvJn8QGyn74rwENOPzQLJaA5iUyeH4abjOqYrBHDMlIziOwLSKBI5QBrrSIeL6tvoyLcfhlPpdgPTFLBa5Yh/ZiCzxUV7feP/16grLXQ9Jn0PByLlVwzJ09xeJCOLXhnMRf5/HhUtAWPjhTz7kWOKK17gOxliCf8nFsIqAfBCWQPvLeXfchYwYn2gArfzhexPOL4IuP+g/xZDjlOktNhYY5S9Drkd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR10MB2943.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(396003)(376002)(366004)(39860400002)(346002)(136003)(4326008)(54906003)(26005)(316002)(110136005)(16576012)(86362001)(16526019)(31686004)(38100700002)(31696002)(186003)(36756003)(53546011)(956004)(6486002)(36916002)(44832011)(5660300002)(8936002)(8676002)(2616005)(83380400001)(2906002)(66946007)(66476007)(66556008)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UzdPVVRDU3k3b2VwUlNMU0pBejFDNUUrSmtUdXB3dkd1SGdyNk93TUIzeVRj?=
 =?utf-8?B?eG9yc3Z0aXpyRXRkdjFoTG5HT0pEWlVsdVRMRUViRTQ1dUI4bnJWdXpGeU9r?=
 =?utf-8?B?cnMwM3hoNHZaQXdPL1ZEMXVlSVRXd3pVRjV0dk5sL21TSkhQdUx5dWZOSTc4?=
 =?utf-8?B?SlE5OUhGSlBWQitXZGR3bEZFc2RZVisvYnZYeHIybXFNVUU4bmdvSGJ2RkZm?=
 =?utf-8?B?WEhSRkxrUHpmZlJnd0Y4ejRzM2JaMjl0U2JhODg5SENsMlpJSGpvRVlkZXZr?=
 =?utf-8?B?eGpkS3NpQjg2Z2I0RzhPMm5NbTNKR2JrRGJaVm53dkJnRGczc0VQRTZabU4x?=
 =?utf-8?B?eVNGWU4zWUpBa3k4YTZ3TlNJRDVBSTlEbXdzd2pYTGlrRE1IcGtOdkR2RDZP?=
 =?utf-8?B?TW9FUU5sOUUxYUdicTh0RXdnRmNwL1gxSU0xV0R5REZneDROSTgwbGVNMFZr?=
 =?utf-8?B?ZWJ4dUFMbTVtY1JHTnNnL0pDdFN1UlE5VVo0VlB6RHN0ZDZDWnU5MUVkUjVY?=
 =?utf-8?B?N01WNDFHWHRFejY1NFk3RnRBRlcrNFR6d21wSTQ1L0VucTZxMGNQTFpoTEYw?=
 =?utf-8?B?QjdxQlA2dkdTT0paaWdFOVNFREtoamxIVXRSOUo4Z25IQnVpQ1VZY20vOW5F?=
 =?utf-8?B?LzV3RGhWTWR1cHpvWmVVVTVpUU15R2Q1R1cxZkVOYUFsTWJrbmxINGtPTnhk?=
 =?utf-8?B?cStUUkNWZmNhYk84V2QzUHV6Y3NjUjRNdFU1SXBFRllTL3E4SlJEaW4zczAy?=
 =?utf-8?B?N2xWN041SUY4WGR4YVBiMVo5RS9YMmdWclVyUW9VaUdGdDhERGhqV3hrRnJs?=
 =?utf-8?B?SDNKL2FQR2tLbGFwakVxU3lVUEVnQkdkQVh6WHRTOS9LNTlBb2NIUmxFcHFI?=
 =?utf-8?B?SndzOEkyTm95alhJSTdNTHRkVkNhUVgzaUowdUZhUzJNNVNzWHNLNW1LQU53?=
 =?utf-8?B?MWxpZ1lDaHV2bS9PZ1Z5Z1dCcjJGZVNFNHd6WTlnSnpzdjRXeUlwT3hqdlJ2?=
 =?utf-8?B?R012dzcwRlZ3WktUZkEvNFkzMnNEOW5ucFFrSm5rWDJuMVYwWGp2S2psWld4?=
 =?utf-8?B?QzVNOWhyaGRjZXdhY0VDMlR1b2pCenNSbDRTR2ZaWFgvWDRpKzFhWGJ2WkhH?=
 =?utf-8?B?SVdCV0hKcllURnpIMkxKS0ZTRVVEYy9mUzlEcC81MzE0WnBTaDR2dWdVNW8z?=
 =?utf-8?B?Z3U3NlRibk9ROG5WVGFOYVdzODZraytiMExicFpRc2VOVUYxd3E1ZUxBdjh6?=
 =?utf-8?B?KzZGVEhIRE9Xd21ZbGZScENlUUZRZG4xMmsycWNSUThYYTNZRHVqR3U3eVZo?=
 =?utf-8?B?U1hBL3VlSVpjTjZwa01zUjRkeDlpbm5pVlBqd1JEcTNSajBkN3ZJd2s5Z0Ir?=
 =?utf-8?B?Ym16QWphbm15TWtEdjFtREJZTW1XMHZ5Z3dXcWlMK3FtanBjVS9ITE1wWTJM?=
 =?utf-8?B?d3hzRjRSWE5WS0dmNzVOQ2d0M003WlNlb3A3R0gwRnFqNGpnSVFWQ3RJclg5?=
 =?utf-8?B?Rnp6Y2g2eWxUU2tZQ2VHcTkxbEJ4MXh3MkQwRzhJQmp3bXdNcWtkUHduczJO?=
 =?utf-8?B?aUtOZ2ZzNnd6bUg4Y1JTT1o5RWVYL2xnNHM5cWlWdGpweFVySk9DcDR2VitM?=
 =?utf-8?B?OHVpU2ppZXQycGwwL085VDZBYmh1OVVKajVUSk1kaW9qS1BBZzJiN1d3MjVN?=
 =?utf-8?B?cWsxdCtSeXZwNm9HdmhyblFLUDRPSWlWc28vL3hvU2wzVGRlUjREUjdkQWNr?=
 =?utf-8?Q?vICF4IxG8/xmXlINjictrv1TaSzLold+vn9+cEK?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d19c11e5-83ae-4a75-66f7-08d91c7ddb02
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2021 17:28:32.2562 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QBMhdGVIoTV+bDlvKa0fpANRA1rRz8Vh5lRuAg22T3oGBTmBqeELTLCbkcYZoc5kyIEcUopF1YhALoxZIcwifYoCpq2Ea/T1q+YZ7sAAXtg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4665
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9991
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105210092
X-Proofpoint-ORIG-GUID: ZV8hhXbpQyoC90phoO2ZILni-RH0ssHq
X-Proofpoint-GUID: ZV8hhXbpQyoC90phoO2ZILni-RH0ssHq
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9991
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999 mlxscore=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105210091
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210521_102838_731927_DBB90346 
X-CRM114-Status: GOOD (  29.12  )
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
> Returning an nvme status from nvme_fc_create_association() indicates
> that the association is established, and we should honour the DNR bit.
> If it's set a reconnect attempt will just return the same error, so
> we can short-circuit the reconnect attempts and fail the connection
> directly.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/host/fc.c | 25 +++++++++++++++++--------
>   1 file changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index d9ab9e7871d0..b16acab5d8d8 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -3095,6 +3095,7 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
>   	if (ctrl->ctrl.icdoff) {
>   		dev_err(ctrl->ctrl.device, "icdoff %d is not supported!\n",
>   				ctrl->ctrl.icdoff);
> +		ret = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
>   		goto out_disconnect_admin_queue;
>   	}
>   
> @@ -3102,6 +3103,7 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
>   	if (!(ctrl->ctrl.sgls & ((1 << 0) | (1 << 1)))) {
>   		dev_err(ctrl->ctrl.device,
>   			"Mandatory sgls are not supported!\n");
> +		ret = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
>   		goto out_disconnect_admin_queue;
>   	}
>   
> @@ -3268,11 +3270,13 @@ nvme_fc_reconnect_or_delete(struct nvme_fc_ctrl *ctrl, int status)
>   	if (ctrl->ctrl.state != NVME_CTRL_CONNECTING)
>   		return;
>   
> -	if (portptr->port_state == FC_OBJSTATE_ONLINE)
> +	if (portptr->port_state == FC_OBJSTATE_ONLINE) {
>   		dev_info(ctrl->ctrl.device,
>   			"NVME-FC{%d}: reset: Reconnect attempt failed (%d)\n",
>   			ctrl->cnum, status);
> -	else if (time_after_eq(jiffies, rport->dev_loss_end))
> +		if (status > 0 && (status & NVME_SC_DNR))
> +			recon = false;
> +	} else if (time_after_eq(jiffies, rport->dev_loss_end))
>   		recon = false;
>   
>   	if (recon && nvmf_should_reconnect(&ctrl->ctrl)) {
> @@ -3286,12 +3290,17 @@ nvme_fc_reconnect_or_delete(struct nvme_fc_ctrl *ctrl, int status)
>   
>   		queue_delayed_work(nvme_wq, &ctrl->connect_work, recon_delay);
>   	} else {
> -		if (portptr->port_state == FC_OBJSTATE_ONLINE)
> -			dev_warn(ctrl->ctrl.device,
> -				"NVME-FC{%d}: Max reconnect attempts (%d) "
> -				"reached.\n",
> -				ctrl->cnum, ctrl->ctrl.nr_reconnects);
> -		else
> +		if (portptr->port_state == FC_OBJSTATE_ONLINE) {
> +			if (status > 0 && (status & NVME_SC_DNR))
> +				dev_warn(ctrl->ctrl.device,
> +					 "NVME-FC{%d}: reconnect failure\n",
> +					 ctrl->cnum);
> +			else
> +				dev_warn(ctrl->ctrl.device,
> +					 "NVME-FC{%d}: Max reconnect attempts "
> +					 "(%d) reached.\n",
> +					 ctrl->cnum, ctrl->ctrl.nr_reconnects);
> +		} else
>   			dev_warn(ctrl->ctrl.device,
>   				"NVME-FC{%d}: dev_loss_tmo (%d) expired "
>   				"while waiting for remoteport connectivity.\n",
> 

Looks Good to me.

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

-- 
Himanshu Madhani                                Oracle Linux Engineering

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
