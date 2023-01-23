Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E3B3C05027
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Jan 2023 13:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XFjJEWefeNs4Vt03eFqmqbb9bCEunRPI7r3InLtkue0=; b=t42YksEs0uueV6E0akfe5zNKfi
	21pL09vKNZr/fHoPjMeNjjMJ/mA/hEXkah6FVdekkzRuWrDeyI3LVl5KftlB1CwqhQjf0qsltSimA
	cVk+8CMc1/LOh7IVYh0oJd4eXldwUPvlyFuuQusMr/ycM3NiwUi/ZkZHQRzgf0NtnLv5/Y+hHch65
	7h5rCWxMeSdvt+GEYbIaDFfiYbSMvAv7BJbdd3934b4hGUIg12ucLZoTR9bBezsA5Vj9ThbYvbUdd
	zeFQoOeubzFAN4FYtkTPkqrqX/zYvdrT7zi7fUQTfb5eQggl8x1F2awhFRpCea+XSZIu2WQNQAns1
	vgMunL9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pJwyH-00HNai-AN; Mon, 23 Jan 2023 13:34:49 +0000
Received: from mail-mw2nam12on2077.outbound.protection.outlook.com ([40.107.244.77] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pJwyE-00HNZd-KS
	for linux-nvme@lists.infradead.org; Mon, 23 Jan 2023 13:34:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LNPYvVb/y4/t6UsS4tQU7QZ9C/IGfPGRfg8W+xHZtUwr2S0bGTg2n2mq28kK7uGJyR9D+vrhmiKCWvlb6ip8OJUucy7TdLY7qcNAKcH6XJob9UxqivK7matN1v/Ut+WXb8UB3B4sHxPV++7Q7xv9jVNeDUog7uatX/hxDxWx3EkH097SB2KrvUn5+LOmV68gmQDGiAQ1pbXp2DoOaH/ZUSkIMhXS/h9sjwz9gGwxtxbIFJUnCHOdXdKzE/dfY27opNIxNA5T+stSXfWGb0cKpKxDdIJXGY2Va38xfDfMQtOO5oy8i++FhNejidrTZk5cNB3DsNNyWUel95rm6Tqu4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XFjJEWefeNs4Vt03eFqmqbb9bCEunRPI7r3InLtkue0=;
 b=VvYkZhFG5dYDG8lSO17q+ANCKBuyKqfrW0YhXPyoPfwZKAyPJbB0mhJa4STYojBvVZfBSrS/tY1jGy5DurWGJNCeTjnRaxwzP+Sd1NGGDzlGvB1X0IxgzOF0x3UY928/5Di3tOxLn+qQHCOuR9nrOeFaUkWZNUcTKJREql1Rv09pHgi0ZQav0UJXuAttBAkhorvBIrdCPdDBBeGNCxd9z8T+PnSclV7HWlWLMuPTWcOWrUdeDvDJJ2Ith4lhQWaACYP47esdOEliB9R8+SipWXT5isECw9wKQ2mu5bFeyPqJdPC/OL+5CH/K8jam5VTjn9BC1DAW9312b6XT7isb6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XFjJEWefeNs4Vt03eFqmqbb9bCEunRPI7r3InLtkue0=;
 b=uep+zNBoeTcY372E2rOmnnNsvw7ro1sr4h9r7CdK2t9Sy5pz5VL2CBAJvvA1bFpRzejS2N8FeKT+w9lcJgwWLBofVOlFzj3HDW9qRI7R2C3vz+KUfM7so2Q9Uuj52cFCYAdRQMAPlOyBHJHYrtw7TMyOeOynhLQOg67wb2Y9Etp9rIlTMoi3WhvNHhM/yiaVwQ6dPbrIx2j11sEC2qdQ2I1dipK43/qTErtZNrbm75xz8/PKvY0YJoje7H16jqzY6WUzxypRSTwwOxRsjmaJ49SCaoRDstJdClUESOI5NflPcR1jyvOZ0+xockI0GUmVkAAt3KLhq3q4kVufsqIGBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by MN0PR12MB5810.namprd12.prod.outlook.com (2603:10b6:208:376::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Mon, 23 Jan
 2023 13:34:42 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::9444:21e0:2a65:da95]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::9444:21e0:2a65:da95%7]) with mapi id 15.20.6002.033; Mon, 23 Jan 2023
 13:34:41 +0000
Message-ID: <b26b8444-6195-da79-d7bb-addae0059446@nvidia.com>
Date: Mon, 23 Jan 2023 15:34:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/3] nvme-fabrics: introduce existing_ctrl operation
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 hch@infradead.org, kbusch@kernel.org
Cc: israelr@nvidia.com, chaitanyak@nvidia.com
References: <20230115100341.40347-1-mgurtovoy@nvidia.com>
 <e89cc27a-4b8f-6503-fec9-670de2bb885e@grimberg.me>
Content-Language: en-US
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <e89cc27a-4b8f-6503-fec9-670de2bb885e@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR08CA0091.eurprd08.prod.outlook.com
 (2603:10a6:800:d3::17) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|MN0PR12MB5810:EE_
X-MS-Office365-Filtering-Correlation-Id: 113b296a-e650-47b5-adc3-08dafd469505
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	L2R9rXbF40XQnOkguxFTbAjF28Ygfy8BkevMwhvzJQO7ClEcPiOLSarpq+gw7VTFiUwbWRMC06TLUeEPSob+jJEzHaef6Hw6W/Eq++Nk6MBc7qqbX9ZP9XZQKGytZpEGSNW4ZT3TeFI1BbmNUujHTV9YC8wnjuE6Z7XvChPCOnmpN9RL0LdenX14dzCQs/Fw753tDg7Yob7g4b/b02Dyl5Zj0scxfKdWs6q/zu/qmQyKkt4Z2NvUjSzJNlxdCwtIsK08Xoi29S/eT4ZYIdRPr5+YRYHOvkS4FyZllUAHKdOFcHFRhaCT0K/I5/skUOAwALQsc+eC7a51SOI1IiTC4edPHHFA5wPRFsF69yrV07Txvjbzrp5NzJDCDonvhMIHLV6b52qXPjm55QMO35ERBMOYcpBi1rFTXrKAFcJ5RNJU+2hLVuDb4GS0gC3ailB0SjmhCHKkI6I3rtUegHqTVwmo20kMF3YTzno68HR6tZ1Bd1OZn6+CuRHme9sMGUFMYNdHwUOrc1b6O+wo9ONMIy+WLI9cWOLJmtIFyY4Qc8mnNiZffLJ2Lrn3L7A3pSoNHQJaq/X/KGAxgIw1UIm74E2tyKQRegs1/vB6xGVbxNuu+rUuGz6qc7yeoKU5yjqKkI2QaImR7EQoQ60pN+hd5knTU0tIN3jFGc6+3MhTIlV7gSzkqSMhDnG4CehykPgVU3ftVjuKC3lp4WMVUdSYvi7iFkMJhai09DUhXw4BlVM=
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(366004)(376002)(136003)(396003)(451199015)(36756003)(86362001)(2906002)(38100700002)(8936002)(4326008)(41300700001)(5660300002)(83380400001)(31696002)(478600001)(6486002)(31686004)(186003)(8676002)(6506007)(53546011)(6512007)(66946007)(66556008)(66476007)(2616005)(316002)(6666004)(107886003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?b1RkQ2VqM2k5bXhKUzl6TnBvREVsdGExSk1VRHJNUEQvU3BiNElyanZFZlJm?=
 =?utf-8?B?WXV4K2o4QUpQS0F1Nm8wR2prSFVxQTk4N05lZ2RnQUh5aWMrYldCWDdwSFhi?=
 =?utf-8?B?VXgzOUhsVnYrcEpzWjd2WWRVdEhqTHlLK0xNRVp3OEpCYjRFbHJKeUhXcGNZ?=
 =?utf-8?B?N0lDblJHQkVUSnBBZERNSnBpUzFObTAzWCs1NVZZejBad2xQTWVFU09PVXBZ?=
 =?utf-8?B?TXpXY3I0YTFWNXdvR3BsVmpSYnNQN2ViSDVHQWQ2TjFSdXlEK0NZZEp2SGxT?=
 =?utf-8?B?ZzJVVEZzcHc4dkRSWWRYdzNGbGxmZDZaOTdEVmVnWE15QTVaeE1Fa3JHNEpU?=
 =?utf-8?B?QkRRdjQyWHYxbUloMXdoZktQL21tZHNpSU50MnBuVEJ3OVlrQVFKdWloZ0Jl?=
 =?utf-8?B?b0NsU0xxc3pWY2tsRUZQWm10ZDEzbnBYdnVsSHlNQStSUElzNE5hUXRDbnpW?=
 =?utf-8?B?blJnTWo1TGhpREUvYUZ5dERWSzJFcFM5TithQ0d2cVRBY3JBRTdjdkhoSHpP?=
 =?utf-8?B?a2Jhejc3dFE5TVpZRkF6Smt2SURyUnpjUGJsWXpyY0ZVeThwZ2xReS8xdmpo?=
 =?utf-8?B?WFVIMjRXbTlXb1dPb0pCeUY1S0s3dDZidXYveXZoM3h1RGZPMDA3dEFKbzRQ?=
 =?utf-8?B?RE1VaHhnN1M4VTBiRXhlYktyWHhreDNaYU5Cd3REalY5V2czdXBCR1hkWTMx?=
 =?utf-8?B?NnJtZ0h3YnZZUHdEQnp1aVJ3Y3ZJOHRJd2FOVW9uNEFlRFA3MnJkZzZUZGhO?=
 =?utf-8?B?TEExTGRuRXlZVFVuSUpPNGFlOSs4Q1pCYndrWnBZbzgyZWhIcDNZS1l3d2dp?=
 =?utf-8?B?dXZtSVFHdGFybVZTTGZjWWVobmFwbGthTGUyZ1lQU3hjMXVESlhySHVlZjhR?=
 =?utf-8?B?cmR2TFBrTzRnUUI1ZWtjOHZhTjc0Ky9HUjNCQjNoa3VuNjlzUmtFTEJGMnpl?=
 =?utf-8?B?b3kxS3ZLOHdzTmVNZkZRa1Mxc0Q3RHU1RjUxZ0hZRDRyOHdMd1dhOU9rT2F4?=
 =?utf-8?B?ZXdWQ1hHK0d1dzlIcWljVk9PSkFTekRLZ2xuZ1hBck15TUdQVzVWOWc5RE1U?=
 =?utf-8?B?UVp1cVFLaVJkYXJ3Zlc2aVM2N1VER2tVc21TMnZHWTZlMjUvRlNIbFRacmRC?=
 =?utf-8?B?YnpnSW81bDIrQlI4T0dBbWtvT1gwVzBLWG41cGRUamh1Mnlza0pTYzZBK09p?=
 =?utf-8?B?UTVva1pjVGkyNzZCanc5ZFpiTWtSbEpqWTdOU3VhSEZKQVc2K0FGZEhEUEQ5?=
 =?utf-8?B?TE9ZT2RaTEpuT3B5MGIwb3p1TnNsU2RyV3BVOFBuNGF1S2pRTFR4bVlvOFZM?=
 =?utf-8?B?dnh2OTBEb1dxTDV6RE5Jb2hXRFpVbUcxTUdVckttN3VWZ1VRQ3VGazB6NTFU?=
 =?utf-8?B?c0t2TDJGRVFyZ2ZoWEpoMmNieFNaNjVaN2VuSlVLSHlqQk9YdlZVekxGRnYw?=
 =?utf-8?B?d2pQc0NIVGpjejZHNWJJVnh3VFZST0dxWm5lSTIvdnhVUWVTOGhuS2hnRmlV?=
 =?utf-8?B?Z3ZEQ096NkcyOEcxT2o4YkRDMG5adlNjMjFuS1JKa04xUkdnTlY5K1RTRG1k?=
 =?utf-8?B?aDFMY3JIRmhUSFNvNTd1SFMvNC9CbHNQbkhNWmVFVjhMWTVtbXRsc1dibnFF?=
 =?utf-8?B?S1o0TU1udkJ6dU5hUHRxTWdUeXNoR0xHNUdPZ1pFMlhmQlYwYklhMkI4OXhY?=
 =?utf-8?B?QWNZWXlCK3h0SUF0OUlVSzAydE9sVHN1dDZ6cnNCMUk5SzBHdGxzbEdrY2JP?=
 =?utf-8?B?dHByR0YxTHhjbDBxeXppNFpqOWZma3R5MmtrZURFcmFRdmMxUWg1NCswcUZo?=
 =?utf-8?B?clFjUHk5c0VZOVloUk52U3JQeks0N3pwYlBvUndDU0FOWEFyRWxWbm9MQVFE?=
 =?utf-8?B?M2RWUDc3OTlJOVhva1BvNDNIU0NqQ1RXNW1rZkQwSzBPUEFkcGFyQmVlQXB5?=
 =?utf-8?B?ZXhzc0NKZVkxUGVHM2VlZUM1cVhhUE91aFExUE9ONUxqVlRpQ25zdTBaMGRJ?=
 =?utf-8?B?em5BaE5wMW54ZGk2R3VSOE9pMDlPSnI5bHBuYVgxZkoxRFZlUVM3UGhPVFgy?=
 =?utf-8?B?U29zVWJXbHJ6NkIxbWthMnhVTVY4V25WZGhUSlJJRDROM1VJUHZHQ0hpOW1Y?=
 =?utf-8?B?N2czUUtCVGNEKzhlQk1CVDF5eXN4bFdjQ0lCMEVKUGxVZ2ZGVzBDQ0RMOEhi?=
 =?utf-8?B?eEZ3YlFDKytSS3dXRXBxQWhyQ0QwVHVjUkJEVDNTWklOZjZISFpNWTFEVUIw?=
 =?utf-8?B?OWl4SFdEYk9tSlVaYVE2UC8wSkpnPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 113b296a-e650-47b5-adc3-08dafd469505
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2023 13:34:41.9030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E6km4TQhycgh+w8uZ2LuApWUTz3OHlckjqFwgtve2JH47qJPhZpCRKduQlnvyJaptBcAEHXihbVIoubTmcT4VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5810
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230123_053446_718772_BB169893 
X-CRM114-Status: GOOD (  19.36  )
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

On 23/01/2023 14:33, Sagi Grimberg wrote:
>
>> The check if the connection request matches an existing controller is
>> duplicated in several transports (such as RDMA and TCP). Move it to
>> common code as optional operation.
>>
>> Also, this check can be done before creating the controller to simplify
>> the flow.
>>
>> Reviewed-by: Israel Rukshin <israelr@nvidia.com>
>> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>> ---
>>   drivers/nvme/host/fabrics.c | 7 +++++++
>>   drivers/nvme/host/fabrics.h | 3 +++
>>   2 files changed, 10 insertions(+)
>>
>> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
>> index ce27276f552d..3d5035331b9f 100644
>> --- a/drivers/nvme/host/fabrics.c
>> +++ b/drivers/nvme/host/fabrics.c
>> @@ -1100,6 +1100,13 @@ nvmf_create_ctrl(struct device *dev, const 
>> char *buf)
>>       if (ret)
>>           goto out_module_put;
>>   +    if (ops->existing_ctrl) {
>> +        if (!opts->duplicate_connect && ops->existing_ctrl(opts)) {
>> +            ret = -EALREADY;
>> +            goto out_module_put;
>> +        }
>> +    }
>> +
>>       ctrl = ops->create_ctrl(dev, opts);
>>       if (IS_ERR(ctrl)) {
>>           ret = PTR_ERR(ctrl);
>> diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
>> index a6e22116e139..587b92575a9b 100644
>> --- a/drivers/nvme/host/fabrics.h
>> +++ b/drivers/nvme/host/fabrics.h
>> @@ -153,6 +153,8 @@ struct nvmf_ctrl_options {
>>    *            that would go into starting up that fabric
>>    *            for the purpose of conneciton to an NVMe controller
>>    *            using that fabric technology.
>> + * @existing_ctrl():    optional function pointer that checks if a 
>> connection
>> + *             request matches an existing controller.
>>    *
>>    * Notes:
>>    *    1. At minimum, 'required_opts' and 'allowed_opts' should
>> @@ -170,6 +172,7 @@ struct nvmf_transport_ops {
>>       int            allowed_opts;
>>       struct nvme_ctrl    *(*create_ctrl)(struct device *dev,
>>                       struct nvmf_ctrl_options *opts);
>> +    bool            (*existing_ctrl)(struct nvmf_ctrl_options *opts);
>>   };
>>     static inline bool
>
> Maybe do nvmf_existing_ctrl() that iterates with device_for_each_child 
> and filters by transport?
>
do you propose some incremental logic to this series or to change some 
logic in the existing patches ?


> This will eliminate the identical code from rdma/tcp and potentially
> from fc?

We agreed that FC will use this common code after some cleanup/changes.

We can't hold improvements to the subsystem if some specific transport 
has to do some preparations/re-designs to fit common code.



