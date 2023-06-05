Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA6F2C7EE2A
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jun 2023 10:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TggMb4+Ta43SwSbo9aIHcr3o3GY9aA5+Q2o21hyGEUc=; b=Lck2gG9kKr00yHHwlk/LVfAkaf
	AWNFw2mQeoksWts7+gLcyj8gINiYxVv8twrVbBfR8agHtLAkjotPuhT35MP+YkV8znevgFcsZWLJv
	E8idLkCvy36PJUbh5xi/WsM8GiDIy9RlnBOIgExNtbf0GZMIo+YBm7iV7HgadNmmhW4y2OS57y8P2
	MvbXPOZqFGxrSc9XdZH4htbM8othpwNiKvlevytgdyF6eHjgXPYfIpF5GQky03mnjH7deYizluvpW
	azRpZZhRHzu6If5m4WI7Ec9/csnig494HJOW2GStPo/W9zuV8txzjaPG9jYRCbO1K7doPRuoc5HpH
	wAcq4Iow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q67oj-00F5Jv-2J;
	Mon, 05 Jun 2023 10:52:05 +0000
Received: from mail-bn8nam12on20618.outbound.protection.outlook.com ([2a01:111:f400:fe5b::618] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q67oh-00F59k-2W
	for linux-nvme@lists.infradead.org;
	Mon, 05 Jun 2023 10:52:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tg4oU39rpV0unqKddofblPHsVqdt9YBWG7kGPXYeES7jDjr5S4+ZDrmH9hx8CUHZ+V3x7HWRnjkZjMXVXQ9lo/iOOSI/lfERP3nnLmCuQ0k5rJrj1TSuRwweH/XH8D74JkgvunoRmJRMzEUPvdbcwK56uVxI67dfGue2IMY+N+tep5Z8q/lmv7eMVOmDEaTFrwPoaWiaCjAqgw35IAFueGaMMtanh3SujPpeU6hhgVe9mKO8LnkIWEdydNIMFIbmODPEVkuX5V86kuFILopdpTn1Q9rmIWbARUzuRI74JmZoxjaai/aplb7hx3nNVwIq1MdfkF0wNU4knnsgg18wJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TggMb4+Ta43SwSbo9aIHcr3o3GY9aA5+Q2o21hyGEUc=;
 b=gxyiLx72Xar8Wh06jheP6JITdD8LdwaALDxq0a99Yd740KQkXCn8XuI4g2wMC0r0z51qlMyUe3/ffTlq9HWC+t45QaMa21dEyt6a3e8bb0tf0l8vM1EpDRRgaU00eYYA9t47H+sO3h28Zt42kkBqdwvqlEp+Q8IRzKe+fHD0tO+lh/VROW9G4ZilSR0KVgS452T1QqPEtwDbaQcZ69JIwY2BHbALlmzLZA3REW1D6OMxvYuDKbEhEvacH5I4Ph4bjTGhESK/32RIZrElb/Y3pXgRxijasQxtFLmbsH0vnrVPkhWX//bkRSdrVph646LcWpzSp2doFZJeDI0IKgSyyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TggMb4+Ta43SwSbo9aIHcr3o3GY9aA5+Q2o21hyGEUc=;
 b=DmPvToa9bSfMC4vzHuZgoKkr2yXyadNfMoHJmz6Rd3715/6UD9x7YefVWCVUBItyiY2O8v+3G6sHesTd6kIoBANjNzp+TpXqSme5Fvqlovxfzz/wqV8X12qX6njk3JfkLta3duZRxSmV9bEf6sRc6D4S6qlnrO8n6YoLbw7laVZPIDawPCQlJeU/T514UZ2GWb8raUT9KN7sUREWDn9OBrHBnihb2rZoJaTZmehGdNW5bj1cshD4PufR/HDLuWlOll15ZCuOoZMxJKHOalQttAuleOJvVlefHtcHion/DLSK8X5gZIST1lz1PwpMkVbNMm7d2trJztw0MizO8Y8tPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by SA1PR12MB7296.namprd12.prod.outlook.com (2603:10b6:806:2ba::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 10:51:43 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::cb7e:86d1:886b:3d0c]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::cb7e:86d1:886b:3d0c%6]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 10:51:43 +0000
Message-ID: <da92cc34-e327-d324-0ff8-5db2d5c2b707@nvidia.com>
Date: Mon, 5 Jun 2023 13:51:36 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] nvme-fabrics: open code __nvmf_host_find()
Content-Language: en-US
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>
References: <20230602064742.56298-1-kch@nvidia.com>
 <f03639ad-18b7-a051-c83c-7bca5ef1ec0b@nvidia.com>
 <4b0ddae0-bc01-34ad-9ab4-4d63e262ae3f@nvidia.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <4b0ddae0-bc01-34ad-9ab4-4d63e262ae3f@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0107.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::10) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|SA1PR12MB7296:EE_
X-MS-Office365-Filtering-Correlation-Id: cce69aba-7106-4a1d-2384-08db65b2d97a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z6SNyKx276jao/Jk7FIXshjlfBk87ArTDyxEfg/U/cZvfa+SVPg1wxdIETrMq65kwLei18MSI8WacP8r6iKqziiV3RWheX62kISVW6+50P2e95+YqamVBYZX4pM1p39Y/Qr7Q2B9pmMvTA4S1Lg47z8jcfis1A+Cd79U70mKKKIC1NbunHVvLJQvkHTum+A6usbnNWGfq0T/i+UYMDXU6WYcBwnAXLtKjnNreSSIhpA7aCxXE0MkfnN4614c08hlTeTXyWRAWejST8keFMCXLLSeDvvXkL9ih76ncHBWq5KdWheMjUB5TU7MWbYjObF3he4+bIYRyWHuNQ07uHTOo88Uyw5Xvbjrogp61ZZStcXBilAXR9PR0dH6SWRinuk6lia876SFAU4dK2FAuiik26apr++fDnElYZ8cY3xzi0B6Of39XNX6NICZUPgwWg4qjirwIZECr3KxXudS/Ea4mn8join1NV2flj+WbYOloCo4V1gPUwW4fizeXzGVd1SSafdwQUoHFE1CwMAPBylkFfkU+mtTmcmhVZ06dDZWNDOkxI+4XItrFgdI7wBvcfsCnjdKWpyJxDU34DfJYYPtB0FOto5Nh0RFgshl87+xTvaXVfhLAOTi1qrqqLpYV3Ys+hlHJpKlLmQfX1fKHX6C0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(366004)(39860400002)(346002)(451199021)(36756003)(2906002)(86362001)(31696002)(5660300002)(31686004)(83380400001)(6666004)(6486002)(186003)(26005)(6506007)(6512007)(53546011)(478600001)(110136005)(54906003)(66556008)(316002)(38100700002)(66476007)(66946007)(4326008)(2616005)(41300700001)(8936002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VE0xYVRFZ1RGTE1DbXdCSkhRenFaTEx1R0ZGeUNHWXZUR2RuVzVjVXAvcFBk?=
 =?utf-8?B?VnlnRXgzK25YR2N6NDE5RFBjRkx1Ukd0YmNDbDlibSs5djZ4MXo1U1RyNHFj?=
 =?utf-8?B?UkI3SGgzUXByNlNoYWJzUGZLa0xwRU9zSEExQlR4czZNTTBzMmVjTE14bjk3?=
 =?utf-8?B?TFpjNVRyeGs1RDdTTnZyVW1sSjQyU1QycTUrcHAzMVVmaGZSMUtzR3JtR2du?=
 =?utf-8?B?SHJPSlZNcnpGUjkxeUtNOXhBNVlSNU0zeG0zUTgwUjlvVnJlY3lRcW5hZVpw?=
 =?utf-8?B?cXREbzRETnI1RWsvZWIvWDV4U05MOVo5TjByTSsrVXdZcmlQZmRnMWY1MkRX?=
 =?utf-8?B?d3cvMEJUTXNFQUhLRzhGSndnVlVheW1tTzUvcnpYWUpjVmttVFpGS2Fyc3FN?=
 =?utf-8?B?bEc5VlFmdzQ1Tnh3SS85QVpEWUNPOHc1cDFmKzFLeTVHc3dOYVN1WWQvQUlT?=
 =?utf-8?B?RFdsODVBei8zSzZzcEZzQWkwNWgzQTVoZjJMWENaZjRsYlp4S05hNlpKd3lN?=
 =?utf-8?B?c0orSU1kQjk0SG5VMkRoZWZibW5KRE05YllUMXNNc1J1NzFmdDhRb2tMQ2ky?=
 =?utf-8?B?c3BGK25CaURxRGI1N0xkR0JMVnoremVUOU5HSW4zU1E4TFdIU1FydElIZGM2?=
 =?utf-8?B?cm5KZTlDNXdKSFpqSllxZXVaWmpjNDY5TVRlM011bWJmcjVQTzk1bDJWZGVj?=
 =?utf-8?B?d25ib3V3TUFrY0NDVU15TSsydkU2S2xndGdYOTdDaWVaaGdNM2M1U29BL0tQ?=
 =?utf-8?B?Q1A2Wlg5M3lNdGg4cWdMQzhrUjVVVmc4dHg5MSs3RjdrRmx6dHptOFRhS2Vv?=
 =?utf-8?B?YjZDblBvM0UrRUlvVW9GUFh3eHdvdVpIMjNZTVNRYkl6VmJSbWVRTTFjZHJT?=
 =?utf-8?B?SFF4TlBmYVVoQmZrMmJFZjB6VWFLc2cvRkxXQkN2cllnWWpIWmJyYUhiS0lz?=
 =?utf-8?B?Y01sVVRMU0gxbWpWRGdHbVdmUnR6WTFlOG1hRUFoVjVpY01KLzFJRTFqTWtl?=
 =?utf-8?B?bnI1bS9aZEFDNU1ncDdZcHBZdWNkd2lNQnA4Ym5WSnZrRWFkTFNyeUZLUU52?=
 =?utf-8?B?WU9OWXRsOTUxTW9IZHdVTmtYbFdqVzhnR0JTSGxpa2RNMHlUSHU2TWtnenlZ?=
 =?utf-8?B?QUVxQnFESHRpZWJYVmZ4U1p2MFZWOXp6TFJlSjcrZ0lGVXFFellhVVIrdFhV?=
 =?utf-8?B?YXVzd1lvOFF0NXgrdy9hOVR0b3ZlSVlOZWJRYWhmUVh0UEJqa05yMURmcGI4?=
 =?utf-8?B?M1ExV1NVdytxQUY2aVhraFJobmtjQ3g0eWRrNW5sREt0M2RuS3dzcDJmZFoz?=
 =?utf-8?B?ZmJDT1VQOWxiWUN4Z0h1dUtPS0RZbnpXNHJzRUhFY1dsbzNZVHpWYnBqQkUx?=
 =?utf-8?B?Slp0L2s4V0x0N1d1SGRBN0UvazhMemt1RE81RUJjMUtVekxPWTFrVXNacEdy?=
 =?utf-8?B?MmQxbFJRQUNUZDh5TjZHMHVwL0FwSzY3RmFMWkdXbUN0YWo3NFllRFJzbWdk?=
 =?utf-8?B?b2g0OXJzUG5zVGl5ek13M2ptM0RYM0NmV01qaUxwT2Fia1pranVJbWhKaHRT?=
 =?utf-8?B?YVZ3cStwTFZzOWNZTjlSbnNHS0pQYjF5b1Zha1BnMnUvTDJGTEJSV2p0NGUx?=
 =?utf-8?B?VUFjU0xJbzN3Qnh6N3lxMkpkakVraUxqWWF3Zm5ZU0JYTWFJYkRGb3JKczlY?=
 =?utf-8?B?TTJqS1JFdDRsOXpia3hiK2NndWFvdXRZbVQvZDk2SUZEQXJJdmtSdE9KS2xq?=
 =?utf-8?B?R0N6LzRYYXUxRUhkM2czeXI0Yk4rY1BIUnZRNWhwZEpPQnlXUzJaeXFCUGEy?=
 =?utf-8?B?VUwycGFSWFF2cWtRNjlrUjdQS3pvV1pzbkFnRXZUMk9GYzR3cXlLQ1gyYWVC?=
 =?utf-8?B?REVWc2ZWcUhTb3g1UHo3WkpXZ2JUMzdHMFdrR2c1WDFnRWo0UlRLeC82ZkRI?=
 =?utf-8?B?THI2WGx1WlBOTTc0RWdxS2ZZVUJXZ3dSR0l5SDZDRytoVFpFbDhtSnJHdkwz?=
 =?utf-8?B?YjI0bXJYUTcyNUs0eXVmTS9uTW5DeWVvYTZxMUZsYkczWTY0Y3JiTlhmUEp1?=
 =?utf-8?B?R2piS1Z5SSttSk5nb1ZOUWZKWi80YWZFeTU2UjJBcVY5dktHS1FoVnJvMVRT?=
 =?utf-8?B?VDhpLzZPQmhhNUxNeDVOOUpIREJIeTM0SU1XVXFsQXJqSzIyNEJtM20xSXQx?=
 =?utf-8?B?WFE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cce69aba-7106-4a1d-2384-08db65b2d97a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 10:51:43.2481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qAQUY5dtlPqidHt7F0ZLAyk5OHXCCHLcI5PV4X9zSZ2+Yraz7KBfjS9r+mI//MF2RYOBVRfZACpCfIWH7+130w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7296
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230605_035203_843495_3ED9AEF9 
X-CRM114-Status: GOOD (  17.55  )
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



On 05/06/2023 12:13, Chaitanya Kulkarni wrote:
> On 6/3/23 17:35, Max Gurtovoy wrote:
>> Hi,
>>
>> On 02/06/2023 9:47, Chaitanya Kulkarni wrote:
>>> There is no point in maintaining a separate funciton __nvmf_host_find()
>>
>> typo *function
>>
>>> that has only one caller nvmf_host_add() especially when caller and
>>> callee both are small enough to merge.
>>>
>>> Due to this we are actually repeating the error handling code in both
>>> callee and caller for no reason that can be avoided, but instead we have
>>> to read both function to establish the correctness along with additional
>>> lockdep warning check due to involved locking.
>>>
>>> Just open code __nvmf_host_find() in nvme_host_alloc() with appropriate
>>> comment that removes repeated error checks in the callee/caller and
>>> lockdep check that is needed for the nvmf_hosts_mutex involvement,
>>> diffstats :-
>>
>> The above 2 sentences are redundant IMO.
>> There is no error handling in the callee so it can't be repeated. We
>> just return error in the callee.
> 
> and that is error handling, without error conditions we would
> only returning either valid host (that is non NULL) or NULL in
> absence of host in the list. That -EINVAL return is the reason
> we need separate check with IS_ERR in the caller ...
> 
> -    if (IS_ERR(host)) {
> -        goto out_unlock;
> -    } else if (host) {
> -        kref_get(&host->ref);
> -        goto out_unlock;

this check happens in the caller. No duplication.

> 
>> The first sentence is good enough to justify this patch.
>>
>> Lets have instead:
>>
>> "Merge its code with the only caller nvmf_host_add() since both are
>> small enough.
>> The lockdep check in __nvmf_host_find() after the merge becomes
>> redundant so we can remove it too."
>>
>>
> 
> I don't understand what you are saying, provide a complete commit
> log that can be applied verbatim to this patch.

just say something like:

"
Open code __nvmf_host_find() since there is only one caller for it and 
both are small enough to merge.
As a result, the lockdep check in __nvmf_host_find() after the merge 
becomes redundant so we can remove it too.
"


> 
> -ck
> 
> 

