Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ABC6C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 18 May 2022 12:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:Subject
	:Date:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZtDBhl5mFMsBtYxv+U2Qlr6rhaWW0H9CQJAT76Gbi/A=; b=3N9RFq01jzcQZhLX3moMUsYqwz
	HQFZpqiiWwiBmDM/e8lV+dsBQMizaic5yVDoehoe+wYyLc5U8g1NLVfIvlnCfaZOe2l7l0S+YXxSM
	w+m+FrNj/FtTPfBdKdY5vuVOyhttIXwyIl8PYiue1JmhNCioSSpy8kZsLj9tCo3295N21Hid3OaY+
	CAXtMOmXGgTfrXv1ExJ/X2lqHULlQxWlNDFUCecRsGNAEbCOx0v/fz33h3xkr793nhjVfnsYgIN2x
	QBPmx5IE24Ku5i3LTOLBrHu/V+BeZc2qWH39aRpzpGLZf72CrQQEUK5zI2CLCbf96BQq5FZipsIxH
	LtlZn2iQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrIZo-001vYA-KJ; Wed, 18 May 2022 12:14:52 +0000
Received: from mail-dm6nam10on2061f.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::61f]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrIZm-001vS8-07
 for linux-nvme@lists.infradead.org; Wed, 18 May 2022 12:14:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MBRdaW7LnWXdHzbfhTN4ZlM9ZOfVtZFzR8Ckncd5a6Xqwd3sAGTkA/ZwvhoV5M3u9uLIBGPQh+4JzCo4gWf6O46spvlJgJzkepzgU5qlsZxQezDLD9+RGKwduGdohhxKbels6JXRXgYg5BQ7Mu2i9UglQY2YMiZzGggLYpQ+drgcU0MI7HRViCe+ctpdTUucFm9rlKi7EoSwNg2S3H6BWRSe8ElVhOdqbzp4u8bCPVIsrRDaUloWnz687OpBFvFwjelvruOkif0QHytltM3+7gVWAfhHauz2XLOe9dnmXMGKKLecvrFKqONhtkL4fgb2AnL3P96Sw9MgmRochz2R8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZtDBhl5mFMsBtYxv+U2Qlr6rhaWW0H9CQJAT76Gbi/A=;
 b=b4MDvE00ucUqcH8dCPi7YQJ3Qt9N+R8SBxOs98fohN82TarnAd3wrXDYg9AouqH+0OI337b774v/eER2P5Y6c0NWhXk+FeBaQX1yltZ5/uuXFwkXqH5tjALkPDnf2jG2J9F2l6vzvwLn6x/PBmPga7awAJx0M/jdqkrrs3ir22/PRtd8Cb1gpGZWsKOBOxvNPrJ3IA/tkSlzFB2aaMNNNsxJEJuoKG77SsghNPofXqqlqNKO3FedlN69+TbCyVAu6plU4MxO/DbrezfD6XRKxtVRas+2g84DllPYBOrEjwmbb0622vbBsFTRw2xoQ+6Gmmu7lZmXlRhEEqfSCpdsiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZtDBhl5mFMsBtYxv+U2Qlr6rhaWW0H9CQJAT76Gbi/A=;
 b=IA+tacHIkX5Gtw9eU+AqVVxohOn75Z/DdybqTewqkIKu13XFdJTL8g4V1AcC6RhplB2P2orD6tnTWiECKpAC/Kxs97xZge1WlUU+7AOOrvLCTvjLxVR39/ouRVNteRaOdbwVw361XmsqSOVh7EGOGVNSQOw/yvM4r2QTm+060sahF/fd+BIngEKuiG1Gs/yRZeQzryBmiOXbRWC1wkuesyKSpMQ7JfbrAPKU2x00HtxHqa5MLribkQVGKeyB6Knn23Z0O5H6CL1zC/Akki7e6xDwWaKhPcGMT/5tRsFKJcADqVXBjZyKe+TnlLzFteGLqxzmtos6g/EV8n9TTlYJhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW3PR12MB4409.namprd12.prod.outlook.com (2603:10b6:303:2d::23)
 by BN9PR12MB5163.namprd12.prod.outlook.com (2603:10b6:408:11c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Wed, 18 May
 2022 12:14:45 +0000
Received: from MW3PR12MB4409.namprd12.prod.outlook.com
 ([fe80::69fb:e088:273c:3e27]) by MW3PR12MB4409.namprd12.prod.outlook.com
 ([fe80::69fb:e088:273c:3e27%7]) with mapi id 15.20.5250.018; Wed, 18 May 2022
 12:14:44 +0000
Message-ID: <b12b9724-343e-7a86-41f1-67aa51ed887c@nvidia.com>
Date: Wed, 18 May 2022 15:14:38 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] nvme-rdma: Remove timeout for getting RDMA-CM established
 event
Content-Language: en-US
To: Linux-nvme <linux-nvme@lists.infradead.org>
References: <1652627080-42045-1-git-send-email-israelr@nvidia.com>
 <65ee2faf-b916-8905-cde5-c31b84b9350c@grimberg.me>
From: Israel Rukshin <israelr@nvidia.com>
In-Reply-To: <65ee2faf-b916-8905-cde5-c31b84b9350c@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0013.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::9) To MW3PR12MB4409.namprd12.prod.outlook.com
 (2603:10b6:303:2d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0deb1728-016e-46ee-68c8-08da38c7fe40
X-MS-TrafficTypeDiagnostic: BN9PR12MB5163:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB516388A2829DE3AD797735AFDAD19@BN9PR12MB5163.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jzc2PkKtGsd627IsT230RHVmMIHxk1b9XlH/L9BWk2ug/tLFGV/2fbL5PF4mAZwyyHuB0rdaRJCTH2B9hdvRz8oZxuBT32A0drlmMz1MpUFqzIPLc3w6qyEih4sdnasVonbgrp1fNifghWN3kAElHvBlBbI3tLqy+quOgyUZWp64GKy2fKHda36NpHu6VyGiNS1d7uBjRWY4vJBEt+vCCZzNAC1nBbquiwGTwWm9wdi7kJ77yOw5chsSm8v7LiAKZ3r3zs43JzSR4Of+bELiA9uSZwKVzO8bBpdq2ZfskHefPcEAAczs6KKNSubmZRP6BB6ICY7kWA8CYge+rwGINmPsLlAHulw5qUVYanwCwsQZA70nwrouig9flBBja1Lyd+HPCu8cVC9njAQdzQu7BH5iz+W+P/dOlEBxpvvhDGs33zsiGWhUhk76oIrPIDjO/RF+WOFfBPzwnuFPQ+22CKnsqz605gIhkFHtTEhw6jE+c1Oa5V6ShbkzHKJz1+3M2piyQo9T5E4XAHoSbJoMfEJ786c2A+iLJvOQGypXxtd2mHQ2PRH/PsZkMyDkEWptAT2fCSETaZTATOvAof9McnheDMbiccgY/2zePuPAjRDG2cwlDkHUi/9UNUNauturH+YzA3+T/OUPHgaR7Iu7rVZjsAW6hSda21FZuNRpPHFrUgtrLL22a9UbFBfQjty/snKMlSZQghzdE81kO2qy2MXOel8ZgQ+TgxxSRoGDy58=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4409.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2906002)(83380400001)(66946007)(86362001)(36756003)(66556008)(2616005)(38100700002)(53546011)(5660300002)(6506007)(31686004)(6916009)(6666004)(8936002)(26005)(6512007)(186003)(508600001)(6486002)(8676002)(316002)(31696002)(66476007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dE9WUTFxb1IzcjNxM25qcDVIWVUzczQ3OVl6TkxkRFgwYVBnTnp4dXVsMHVV?=
 =?utf-8?B?RFhlQzhHOVJ0SnpyUGQzaW9DRHlNb3hrY2FCeFkwbkJYY212d2YxTHdZN1lM?=
 =?utf-8?B?TEdCYnRUZjU1RDBhck44M1N1WlRBbjl1aXBXalZWcGlSbVZUNWhxNWdMYU9v?=
 =?utf-8?B?bDd5NDQxMU9LMDgrditUQXRSUVdxdVpNaklYU09zZTBGRW5GMVRaOFBpWGNa?=
 =?utf-8?B?aEZIU2FSQnVYcEpaajNaSVJLRHJrdGRaanRraUs2MjRHL3RQM3NjMVlDMmFs?=
 =?utf-8?B?ZVFtRkVsemVHUzQ1K3EyNW50TW54QkJjbWlGdmhMNzVmUTdjNXZrMU5HRGJy?=
 =?utf-8?B?MXZKMTAwbVVITUdiUzgvbU5YRVFJMkE2MEhHRFNtQW9RVXd4bkFMeXJ5ajZD?=
 =?utf-8?B?d21FR1hIeHVGQWl0QWJDd0xOUzZva0RndlhBOXFUcDJPYzJqMkprQW9yZE5K?=
 =?utf-8?B?RW41OVc2NGlNUlVnNUVubFRWdXVpTXA2V093Qk12NlFLQUZvQmdsS2haOElp?=
 =?utf-8?B?S3FIcVR2RFlxb3B6TGloc2ZLUUZwVzdpRytScit0QlhSSzdNZ3lyYitnNWR0?=
 =?utf-8?B?RVRtVHhQdTk5ZDZBOWJkVHkxQkM0R1IrRnk2TTRkR1FBMkUzeEwrRzNVaS9t?=
 =?utf-8?B?QTkvL20zelN5NlVRUEJaUGg2NVczMG1vK1ZPcVc1R09ZMWE0UEV3UGxHVUVF?=
 =?utf-8?B?NDcxZzdIY3YvemM1SldsUlRDQXBoNVlBR1duTW1QajVkRTl0N040L0lkRzFY?=
 =?utf-8?B?Z1FPSnU2d1d2eEEwN1VZOUw5dXVSejVPbkRxOEdxcStKYmQvMXlacXlvdjQv?=
 =?utf-8?B?WDY4QWY0ZzZ6Y2dYTkJkNFowL0JEUFUxcWMxbzVEUDhYc3FRU1JVYUtFQWZD?=
 =?utf-8?B?Nm5sUHBuWlNubzRKcEpqTlJPNzZkM2pHbWY5ZTRTbnIzdWZEYmdFY3M3M1Mw?=
 =?utf-8?B?MStFcTZObDN5ZmU0ZnFBbnZiSUZWY1Y4M3RnYUd6MExiODBYZ0Y4TnR6SDZh?=
 =?utf-8?B?NWJnTW5nK0R0WjVzbUUyVEY4U0lRTGtGMHZkMXFETVo3YVZOZlNYL3RmcTVU?=
 =?utf-8?B?MUdDQnZFZFlsWUxTMHVVWTdoL3hyR3lUTkk3Y0d6V2dVR1lUZXZ3RE5aZnd6?=
 =?utf-8?B?ays0Mmtxcm01WmdOY3JGMzlwV0Jrdk9QelVEcnZ3aDBwTHdlaHlzdkI0NFhH?=
 =?utf-8?B?UzhoemY2R01Xa3hOQW5kRnR0NEw0SitPYmlENlZWZC94Y1BVcmtWVWZaVXhs?=
 =?utf-8?B?SXE5Wm5aMlNrRE5tcHNxaklQS1NQL2M3SkwyYmZvTmtMWDlHM1d1M1hvSjNm?=
 =?utf-8?B?Nk5lTi9iVlRjdHhTSHRyMjdMeWtzRXhibEorVXFSTWo4dG1WcXJ0d09wWTRj?=
 =?utf-8?B?aUR1Zkd6VXV4aURobkt5Nk5IcGhCWGNDQ3FQaGJSVFh6YzNpamViR2FpQVhy?=
 =?utf-8?B?MXgxNzhnMlNjalQ2c21VejVObXd1VkVhYkMzZUFSczE0YVNQSXZxeTYyWnNo?=
 =?utf-8?B?ekg5andBaU1RK2I5QnVrWGNSTVlnUzFKaDlWZlRRd1prMmFUWDRXMnB1Qm9m?=
 =?utf-8?B?Sjg1ZU5xNFNqMG9yd01WWWxSUjJiOG5TU3BtWHlPcml4cU1taWN5LzV3dmh2?=
 =?utf-8?B?VGFrcmdESVZPZ3JHUmk2QnQxL1B1a2J0dHNKNTAvT2h0T0FuWUtoamNoRU8z?=
 =?utf-8?B?QURhSzliYXNwbmJpU3h5SEoyVEVjZGU0NVJ5YUFoVktXUGRoTUYrQmdKWXlh?=
 =?utf-8?B?dW1oeVJXL3JmMzIwcmdYZFNFRGtUYTQvMTJETHFTNUxDaTd5dDN6bkJ0anVF?=
 =?utf-8?B?SWZrWFNpMlBXc2UwS2gwK1V5RWE4Z1phR2hlV0V5MjZCY0RPOEE4MXJnOXd0?=
 =?utf-8?B?cE1lbEpIcFhHajdBa3Z3SkpzUVJTZU51amtXUW1mbzdscjRKdFdlQzR4a3FT?=
 =?utf-8?B?aEQ0WGNpV3YxN3FCdHdUZW5CcVZxQTcvd0RCMzYwRVlOOEdoZXdZdGE0U2FM?=
 =?utf-8?B?NmVCTTBSVlZtS29ydS9uTXBkci90d3FsTjBkWVRXTk43a1B6QWdqZFVyNW42?=
 =?utf-8?B?eTlNaW9sSk5UVHZJRSsvclBsVDdTSm5iZzFLTlV0RG90RG1BTndxUGJXQzZa?=
 =?utf-8?B?ODlRR2hQUFFPMmJjZDRwVU1ka0pGSHJML3dsbW4wd1J3L0YzRzE1UHgyNmhO?=
 =?utf-8?B?S0lSc3JrTWtUejJvemczeUVmQUs5K2ovN29mQ0V2cUxsb2t6b05HWFJIRVY1?=
 =?utf-8?B?eGVpRXFCZDVYd2RZWitvTkNZVDIxUU8yQlA3aGtVamlYUFZYbjh1QXJlVUdH?=
 =?utf-8?B?enp1RXJEWEFkT1lVeVE4R1p6TVFOYlRuMG9PUTRHYk9JTmtuWVlwQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0deb1728-016e-46ee-68c8-08da38c7fe40
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4409.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 12:14:44.6158 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yXG3LcZzB79aA/m3KOJXBpO9ltQkHgYi24upOGZvUrRIy9nrrB5dmYp5xF7wHsATE3Nhv3IC8oCRd0Qx66DH6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5163
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220518_051450_088084_D67BE106 
X-CRM114-Status: GOOD (  13.80  )
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

Hi Sagi,

On 5/17/2022 1:11 PM, Sagi Grimberg wrote:
>
>> In case many controllers start error recovery at the same time (i.e.,
>> when port is down and up), they may never succeed to reconnect again.
>> This is because the target can't handle all the connect requests at
>> three seconds (the arbitrary value set today). Even if some of the
>> connections are established, when a single queue fails to connect,
>> all the controller's queues are destroyed as well. So, on the
>> following reconnection attempts the number of connect requests may
>> remain the same. To fix this, remove the timeout and wait for RDMA-CM
>> event to abort/complete the connect request. RDMA-CM sends unreachable
>> event when a timeout of ~90 seconds is expired. This approach is used
>> at other RDMA-CM users like SRP and iSER at blocking mode.
>
> So with this connecting to an unreachable controller will take 90
> seconds?

The answer is yes.
An unreachable controller is only when adders/route resolve passed 
successfully, so bad IP will fail immediately.
When running nvme connect, the user can press (Ctrl + C) to fail the 
connection immediately. On error recovery
it is not possible to fail it by pressing (Ctrl + C), but it doesn't 
block others.
I ran "nvme connect" with and without this patch and you can see the 
results at the table below:

Test                                                       |    With 
Patch                                                      | Without patch
Target is busy with other connections/disconnections               |  
succeed                   |Fail after 3 seconds
Kill target after successful resolve address and boot after 30 seconds   
|  Get reject when target machine is up         |Fail after 3 seconds
Kill target after successful resolve address and boot after 120 seconds 
|  Get unreachable event after ~90 seconds  |Fail after 3 seconds
Port down after successful resolve address and up after 30 seconds     
|  succeed       |Fail after 3 seconds
Port down after successful resolve address and up after 120 seconds   |  
Get unreachable event after ~90 seconds  |Fail after 3 seconds
At error recovery, one reconnect attempt time is                      |  
Up to 90 seconds per controller.        |Up to 3 seconds per controller
Error recovery with many connections                         |   succeed 
                              |Never

Israel


