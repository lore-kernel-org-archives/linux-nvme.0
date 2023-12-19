Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A5BAC46CA2
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Dec 2023 16:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QY0/i6uVuSdT9koK5GH794BSeXPc19ENCVa86aE/h1o=; b=zZjuXbyo/sBLAfYONJUUVQqvT6
	WE9m15IDoWSSb/wI3jB57b71wRZYWit/QIw7Y0GUWMtS/MbUpFvW8HMmq99VVs+WVPP0frCoDTVzB
	zw0Lg0IUKqAvmk6sG3wLklU2XjJt6cr/6ujZP+g6jqJPTvpF/XuZVtkuRaNdVS6j5FHKwGsuQRqpL
	eWZsx/DnnSIQDcWlNN/uKUv29NH0EspXiVjkvteiy+z2O/DNHS1NQbtijKIEtdloHGGaSAtUa6WMB
	t/QsS0qi99wAAfFUU/KCdR95Z8Aa8TCeI09XKLtONl1nQLUCk7CJcZcPmjxkCGkcGiwPRvFuAl/d9
	gl3MNADA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFcf2-00EdlO-0R;
	Tue, 19 Dec 2023 16:09:36 +0000
Received: from mail-dm6nam11on20619.outbound.protection.outlook.com ([2a01:111:f400:7eaa::619] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFcf0-00EdkC-0B
	for linux-nvme@lists.infradead.org;
	Tue, 19 Dec 2023 16:09:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OPKEOBpySmymHZ0DjQ7/1K8GVIHbpUwqQwzu5AK6MznFAH8h7Ud7hchJB/0xcK5L2YMzdVY4i6VWJiE0vVJbb1HhKil3zyZz/C1gsK/BmplDb//44IV5qG6sw8pBxYz0WwBfsmFxwstaZhE60VrrO5E9rrfbw8M023+feCLSzVkjPoPsgs22UfFh7fGg3DablIkzez3G/KnVk2xqPPXk855Czcu4ClYEdL5MC4nuOJTR4L0EWP7tAEzoOYojcxI1q3wWjhhikBvoGRmSPHwogwnBqBgzuHSNcNKoKgXM63SVsq6KiWZmTMLBJ1/RW/3E7hsh+1FZkHxuSJ7SkeTrGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QY0/i6uVuSdT9koK5GH794BSeXPc19ENCVa86aE/h1o=;
 b=ADFJeg5EQu0OFQtn3UsYxvd8A7T9vw1AbCVUeQA6L5ZDw/dQPphQu3E/S4N0/NmhHwWuQWuHtPdfaLD/FzmlvMa9T6yq7VayqBY5MRJC78fydXKOkyXVmI0IcpRk0JhA7o2yHexT4d70NLT5yei8dwJ/KFVGPtbqrcdA/JOlqkHk8Hrcbv3TIy0IvCeUnOmdCwigFnc2gaO+vL1wu8gnNCZZqvs0sx3XlBNXRFMtftbEH5/cT0DL3zO/mcB6FcoPrhRSKN3h8jpM1s69fIWJ1dTZzVd5rqnhGsNsRbos2A39/Qb9WMR27bYTKyfpQ2UFdefXCrvhN6Ceb/ISodOLVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QY0/i6uVuSdT9koK5GH794BSeXPc19ENCVa86aE/h1o=;
 b=C7ZCYIgxDkLUWKNAI1WOPX8xRmudCd6nEX64IMVk+Z7774YUpNySH8bY/0+hkGKLy1eTz0ilHa0OfikIahSy5wy8m/D5Fcatf+f/9o+GtNU8Tdy1H33g/bigFAjMZzDyaXAr+UnO9YJz6sG9Kieh+rZvHQgQFMLbMODEOCeesewPaIw8S/MV4qU6iYhpiqCFe24PpJzwuAigfg2HCjcGgn/60w/ahHHENsig4heCT2bVC4i79ryGAwn+0gs0eVa5IMa1QPMa01+bctl/groeIdcfGmUq7+nYfaHcqjPc4H4AOd6VDJjQJW2KyTMe4HulMNcll6AM2Y/RjKdzs3GScw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DS7PR12MB8249.namprd12.prod.outlook.com (2603:10b6:8:ea::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Tue, 19 Dec
 2023 16:09:28 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504%4]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 16:09:28 +0000
Message-ID: <2863ba06-747c-401a-85db-2ecbdfc78e04@nvidia.com>
Date: Tue, 19 Dec 2023 18:09:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] nvme-pci: enhance timeout kernel log
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, axboe@kernel.dk, chaitanyak@nvidia.com,
 Keith Busch <kbusch@kernel.org>
References: <20231218224633.2963811-1-kbusch@meta.com>
 <20231219050108.GA31771@lst.de>
 <b0bb838e-761c-4857-9647-515f50d7ebf0@grimberg.me>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <b0bb838e-761c-4857-9647-515f50d7ebf0@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0140.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::6) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|DS7PR12MB8249:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b8b5bed-9a7c-4fe7-041f-08dc00ace0d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BJVP5rMg7s8OWNNi9CYRmcRVVWgMJLuh3Z3ugXSyKkEGHhGQPQyN0kq6B7m270431lHCbTeSinettOOhYIU299HdW15t1OObZY5yLUUQPP53evF1ALcP3uFgRK7kXAVIFCWswRY1yvP941nxszDO41+KfCiISAWtu7jjdPyL199d1GhKIr9v708Cpmcb2q2fwdk8+gmUtkVg/4/Gr5TfulqDDaDD0VAXmJa1dun8RSMv/q1F65Lu914z8qyIsVOAsGQkfW0uvCEpPSNseWs+MnQhgqxsF5ZuWxPUfkQ5+9ttYJvTpA5ZICIdYs+gChIhqlCn+rIT+ibGYOGDwXXXfxn7mbfAkEuOs/wDvkJMrM3z7mlrunoWI+bR2t23BM1X6NleRHgOBKc3MMOQjh5B9NvpslRn2rTkBWkiWgNG7wATuL88RU8Q3uFhfZDUBryd17W1Rjrq8s7yKXu4sgJRGJqHzyhCDk1leqLOZJTiasijh5qC5ngRGA+Y7AuvVFO56Miy4d7Tt8i70t4Bjx93c5KSaxjsOgLoSr66OA4heJh6xD+vsEAYiU6xO2CUNtmsIXDEpyqaQL54tvZ2rqYdDnb8TQv0QtegvAcd7KgJA/T2cU6OcoZHOHmPr5lRcQgFFXtHaH1sh/AoQSGkDSNzNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(366004)(346002)(39860400002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(110136005)(31686004)(4744005)(2906002)(5660300002)(8936002)(4326008)(8676002)(316002)(66476007)(66946007)(66556008)(6506007)(6512007)(6666004)(478600001)(31696002)(86362001)(6486002)(2616005)(53546011)(41300700001)(26005)(38100700002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzNwZFJDeGdFeU1pM0dkRTBLemJoUDZJbVdpK2tRWitOTmtLbktnRlJ1dlFK?=
 =?utf-8?B?dDBTVU56WlBJNzV3NUswWFZNbVp6bXdZMGdWKzU0ZVN5d2ZDS3E5V0JBS2VS?=
 =?utf-8?B?aTVvZzdZMU41cGpGbEpsQmo5ckdXZ0loejJCTUNNREEzb0RSOWNndTRlWnd3?=
 =?utf-8?B?a1N5QU1kTHhEQyt3MnhEdEhJRWtTSlRiVlhDYXRhNnoxQzU2RitwQU9KUUN5?=
 =?utf-8?B?V3dDRExTaEFQcFNDU0lhb2Q1OFZDWmw2YTAwME5NUFErU3pYdkNucU5KNCtZ?=
 =?utf-8?B?OVN4RUU1UERqN0E4bWJmZ2R3TlVyUm5CKzNNQnNtOWp6N2FYMk5rSHBvTDdq?=
 =?utf-8?B?Sjd4TDd1QzFLT2U4bTdIUk1rZllCcHorWFBiWFNjMjd0YmtldVYxc3JDWmNC?=
 =?utf-8?B?WFdSeGovVkhaUDFLS2VqcmxoTUJyc1R1ZnNCTEY5WUhEcSt1VnlQSnlRSVkz?=
 =?utf-8?B?d3NsNkNpMjNhS3VPU0F1ckgvaENXSEFkUTFlUXo1bUJWWk5yTlA0SEpEQ1lF?=
 =?utf-8?B?NjBDN0MxTXZBTmdYVGNON3kxejJOdnlHU1Z2b29GV0lwelFBaS9PeDVVSmV2?=
 =?utf-8?B?L0ZzZ1o4QkdoakFoeGEvOWJ0YzNPQzl6VzBrMTdiOU1id1ZvNXdoclNaWE9F?=
 =?utf-8?B?N24zWnV3b3Eyc3lPRCtoK1NsSkVVMW5ZUG14RlNnYmNIOFZzbGloVit2TDVV?=
 =?utf-8?B?TWlHd1g0K09ybU9INlJJZXlZZWJILy9xMDJyWjFUQkUxeEtaTGplM0l3NWQ1?=
 =?utf-8?B?MmEySDN6RTlsMHpFTi90emptWE5TQWRNQVcvek1na284UTBvVHpoaHNWRkxo?=
 =?utf-8?B?enNWcHNtT3pjWjNMR3ZUNmZRTWZsd01KaFMzV0NTbUp0aEZaWWdKVlhnaTdo?=
 =?utf-8?B?WXJMaldDaWFHVW9GeE5ZdDBGVytkdWFIYytSOGpiZEFDa0Z3d3FCK1VVRVVh?=
 =?utf-8?B?bVMwOVVtdFFuSjNTcHF6SGtFR0dxNWU2c1kva3crWHhBWHAzdDlVeXZyd0VW?=
 =?utf-8?B?VSt3aGdBWjVhSld0TG5VcHVhUHNLY0lOWTBlWmY1UkhwVWloNTdvMGh2dkFR?=
 =?utf-8?B?ZW5oZlVWaSs3bUxFUDJMRXA5U0hZeTFDM2dkQllLTXNTeTEwc0d3a2daZDU4?=
 =?utf-8?B?MERWUjk4dWhxSkR2ZmNDOWd5d1JKZSt0aFFGVGlKUGhxK1NEYkVFWFJtVVVR?=
 =?utf-8?B?d2dpNFVQQjJ2NWoxSnEwMlcxd2JFcnVVbk93d1grN2ZuN3ZTUktYMFIvWFR4?=
 =?utf-8?B?K1FDaEVRTnN6Tk9PZWhYVVN6QU93emV2TkJPTDFjamVvQStYa3BHaXdRWnpU?=
 =?utf-8?B?ZHVaeHRpK3VGOGFMRTJWUUU3ck96Q1ArWVpQbUZvdTEzYTkyK1crV2htZ2VW?=
 =?utf-8?B?cDRrdWxHM2R3Rjhzc3pjVzBxdE5JZzVHbXJzSWV5M0tUdytzS25qTXNvN1VG?=
 =?utf-8?B?bHRWdzMveWhnU0luV0dqVVh6UjZMQ2JoZXNEL1RFckVhV0pTWE5kUkhhbnd5?=
 =?utf-8?B?UURDSU5kZVpKSUhLUGhZODQrSFFXbG5Cek9WN1Z0LytPWFZ1QlZUQmE5NGl2?=
 =?utf-8?B?RUdKZThDbWcvOXdPWmVPRzRGWkNVYmx0Sm55NElWbkZRdXdrblVGdVRuZmlO?=
 =?utf-8?B?Wmc4Ukx3aVl1bDIycmppenlFcEhKVkw5U1NBSXluL25NQnZtUFVUYnJNTFRs?=
 =?utf-8?B?aVhqYW0xYUZwQ2dLOVNoVEtsOUo5RklTaCtaWEFZM21xSmZsNExHUEVHSkNX?=
 =?utf-8?B?aTZ3d21Ic3FLdTVEaER0U0dieU5EckQ3VjkzMHJxRzlkbmJNZ3J5cnM5WW9I?=
 =?utf-8?B?dCtUa0JqcEZteWRDd0ZCQk5NVUFKbnlnQnRvbXdNNHU0dDZPQlV3Z0NZVCtJ?=
 =?utf-8?B?bWVKMWt2UnZJVHhTdUY0SjVzWnRaNWtMdWE3MVF4VzA4aXBGellvVjJHU2Nx?=
 =?utf-8?B?UlZNWmVWTXJlZVNWV1BISW5oNi9RQng1TjIySHFrbkZlSXZPQ2tWT1VHQjRi?=
 =?utf-8?B?ZlhrWFdBczZRZnVLem9ZYVpZMUQ4TlpIUWplOEtuWURYNk51QUMwbTZwMXdq?=
 =?utf-8?B?dzlDYzVQU3ZwRzVuVXdwdTVqcW5RVUFSN2p3UDVyRHp2QkxnSmJJNGM0clJr?=
 =?utf-8?Q?4VSWfmytYPllfeps4SwTK8Wt1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b8b5bed-9a7c-4fe7-041f-08dc00ace0d3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 16:09:28.8407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tLS1/ym0BXikFeQaTUbB39cmZod9zCQADj1/qRLd2MIiX74SJD6jvrd53/kCkjLCkCauWLEjkqGBaIRPskUs3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8249
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231219_080934_194345_66473084 
X-CRM114-Status: UNSURE (   8.91  )
X-CRM114-Notice: Please train this message.
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



On 19/12/2023 16:15, Sagi Grimberg wrote:
> 
>>> -             "I/O %d QID %d timeout, completion polled\n",
>>> +             "I/O tag %d QID %d timeout, completion polled\n",
>>
>> Q: should we use the Linux term tag or the NVMe term command ID
>> (or command_id) ?  I don't really care, just thinking out loud.
> 
> I was fine with neither tbh, but tag is better than command_id I
> think.
> 

In the current Keith code it is actually the tag.
If you would like to print the cid please use: nvme_cid(req).

I guess the cid will be the useful value that we can compare to the 
wireshark or the target prints.

