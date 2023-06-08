Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 524C0C7EE25
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Jun 2023 12:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k0s/fY1hAigXCT2vxqVVf6ZKzF8O//eMAhZaZU9RM/4=; b=urG5DV3X/VQllQdE5EkQpFVAFu
	YO178EUGsowPufGrNVhJUms5Yryl0a4aZ98e5U81m9qoTv42Tp+UKg0Bd9AxbU2jTKsXkCOfLi+Am
	8YEtzJ1Y5L7Ni4+JxOcihMGsqkP/g6oU/qcXgPuTypF4nW5DlHmFy8u9VAE8zO8VDj2EpCG3R+fTg
	wjQS+CBrowwKdRxv7lSY7byIDXt8twEEiVCsCXK1Rnx29OnvH6NJ9s55tQkg8OvCgI1t2CaWhApcb
	IRKu4yAtbYeeeF1aIkTDLGEG1RM9YlUR6EDwmaAbV1pFckfqYU9XKA0ZFgiPcWhwITNTgibJdP7VX
	74Ea5/mw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q7ExG-009Mhn-2c;
	Thu, 08 Jun 2023 12:41:30 +0000
Received: from mail-dm6nam04on20613.outbound.protection.outlook.com ([2a01:111:f400:7e8b::613] helo=NAM04-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q7ExE-009MhA-1a
	for linux-nvme@lists.infradead.org;
	Thu, 08 Jun 2023 12:41:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=et45MVTlVJK5PpjHoH0V/CcHIkd79O/ROL+j0c/nfEM4ISc2QKB0ezzVqu8hrrE4giBdvQRj6LnkUW60p9O2Y2iktib3PBX/ZjT2eNNvW61HNfbAiePgSi12qhCmNS8xfwEXJfbvelcOvengiUWPHP+UhfbHGwQSvYH1Tg+WfDdTIRg/JrUI+ur6K733G/AsIWNnH0oz7OkdtbYo5v58iD8GOtHwnKIvvlJvbE/bUItW09YtMQEEYGCeN+1u49M30pP1Bsgw6T01+JuGiXbxm/BxrOSuaTQC9ilHcWX+YUcaRLoRfwR84UlJGvRLn7jZaSZ+xMRsTQ+GOJzdnSDMeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k0s/fY1hAigXCT2vxqVVf6ZKzF8O//eMAhZaZU9RM/4=;
 b=eXwZWVvtCvBJgAHMu9W6camGyfdd7CnE8flIVib/fwJuaj5S831+GxAZaHnchxJd7CG9LnUQ6C2M9+FG3zin5+rrYBfAM3gRjJxBDA/mp3SSl4RojSXPoDlFXldeU/M3MPMZitHjiwj+UCdysBujBsOmpMnp+jlwfgS6TH38JUI1uEVl67zl6gzJs6mCC9FQIIZFuYu015qwB9FRk3jvhtRJoIQWI5fYonn2CJX78OFeq5Ryj6an6FW3yngsiMK/0negEZYBJ1klIT6m95s3VF0N/lU8Lvu/ZJKH4nu/RtinzQS5S5M8AY3gopK3vRXMe0J1SSrS3O60ZcX7OK92HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0s/fY1hAigXCT2vxqVVf6ZKzF8O//eMAhZaZU9RM/4=;
 b=AopZrrE7tSXyCJAYqGTxLKCOOXP6lxHrcjMqOKv9jfdfn7eovuumILsvSQZxZTRxKD7wGa16DdYoWETeJ2c8jk0rmT0ChsNkJ7qmEnGWoDPd1IKyu4/5eoJS1h69g9gj2dm8WMDrni1KMykz0ikMg9IUzV+4dJETCsPSLQxHJXU2BQJEllz8ak8uEkEKJ2ltPyieV4fwNkpm4wLO7bCo4Zn+AGbYxAuJoZHIYa9sbLhxguRM73VhfS4ADkTk6Z9JMN1GfwT8cv9sZYBpgl1kbO3SW1ZtWVlypoAt1eLnWEg0x4HTUW4lPbE0G01pKr7ehPgiGy/bSYzdOX6W9tG1qQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by BN9PR12MB5259.namprd12.prod.outlook.com (2603:10b6:408:100::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Thu, 8 Jun
 2023 12:41:20 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::5fe3:edc2:ade4:32ea]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::5fe3:edc2:ade4:32ea%6]) with mapi id 15.20.6477.016; Thu, 8 Jun 2023
 12:41:20 +0000
Message-ID: <b13dd6f2-92e8-66a5-e1c4-696d43677886@nvidia.com>
Date: Thu, 8 Jun 2023 15:41:13 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH V3 2/3] nvmet_auth: use common helper for buffer alloc
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 hare@suse.de
Cc: hch@lst.de, linux-nvme@lists.infradead.org, kbusch@kernel.org
References: <20230605091920.34253-1-kch@nvidia.com>
 <20230605091920.34253-3-kch@nvidia.com>
 <a8431996-516d-2da1-2f9e-1931d69e4d4d@grimberg.me>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <a8431996-516d-2da1-2f9e-1931d69e4d4d@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0142.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::16) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|BN9PR12MB5259:EE_
X-MS-Office365-Filtering-Correlation-Id: d30c66c7-97cd-44fa-69ff-08db681da8f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OUAFf4Ec1qwP0qAnU4Y9SJgl0YOKDZCErd5wJy/4+3ddCGFRdRGhqhJwNNjpv+lsOgsFEw8pACh9iRrHJkWOM4t/XgnNJM5VUjuJIoV3OhkuBIFWokewahDzj5ThrjtU98Ju2Bu4LK6rKdAMzBrhGZToD//cVIFFv+Ki7XZrBT7/JGV9LixZDOiJPRstcVYtQgvVhf8RkZcmknHXgm/5q080wTKSwZoQ3TtoTsKnqrRgXX5xADExbGUnWMikG106crHnnlwUgWcjbXF0Icw91DsQ7mqMgUfHfeESS7IjY7Cqp/lNXRZ5Si5w4dVuEEr9hE5o55OINx+YEO3GUKzPZfTfocxf+qzRBPAIHfJUVtOddarNoosnQBup6CTwFi3CpPfSG3hhdZ0V+4lb0apIy0ZiLTZg0ZZha1mQvLM5hdzpgVN4P3xX72r/nPHXsqOC8pacrmmblYwYznXtG9b0m0yn0UC4IHI+jIQiFYdL+NTay3jDXkG4xQj/boKw6wNRgoUKSdKmjqOdDP+3QacVNZOYd9qa913+JtaYAEljVqAvr28tkeyiymjfYqEOj+lN7kiG9Hg8vcp1L27vCZbEo27biWkozQPeOZ2mv3UEu3FCUZ6xC5kHx4bAIR7cB/N6jARJFxbkelGhY/m4g+LZgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(396003)(39860400002)(366004)(451199021)(478600001)(2906002)(2616005)(83380400001)(6506007)(26005)(31696002)(53546011)(186003)(6512007)(86362001)(38100700002)(6486002)(36756003)(6666004)(5660300002)(8936002)(8676002)(31686004)(41300700001)(66476007)(4326008)(66946007)(66556008)(316002)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzdjU29KeTlvQWlmZmdyU05RU1ozNGtEOXQ1cWMwZ0ZxSVFwWjJ5VGFzKzlh?=
 =?utf-8?B?OSt5MW9XVVNSdmxuVDdyRzNCdEFzcEhkWGhzYVlJZEFWWjdXd0NGT2FzTnBR?=
 =?utf-8?B?bzBoTEVCSG0xaVl4UVIvV0tYc3JRUUhXMWkrTHgwVmFianN2WlJxcG9zWDZ3?=
 =?utf-8?B?Q1pKNmIvbTZKcVQxZGpNRzlyeE9wd2R4SUJKbnhxTjFQZHBmTDBFWURVSlZw?=
 =?utf-8?B?eGVkTld5b2lMZ3hxa3oyc0w0bkh1RmV0YndPdnZKU3gvRFRwaUxvQ0ZsUDhZ?=
 =?utf-8?B?U3hzb25vdCtqaUdiSXovWVc1UE1XZCtkZlg1YmZBcE9Ub3RLTjRUUVFrV1Yw?=
 =?utf-8?B?bXlPZEc1SnZJY0lSZ3FySnJJT1ZMOUdUSFF6V2c2OWRqcExpdzZXdmF4UWsx?=
 =?utf-8?B?bnlXQUhHdjlKWjBvejkzb1cxY0E5YyswNTRENHA0VlJiOHpmbjgrUnFXUFhG?=
 =?utf-8?B?dm9jaEdqZWdEalduUmR0T1hXSTlJYSt6UVI3ekdkbzVmQW9DeXhjZS9zZ3lj?=
 =?utf-8?B?cDBYZXFSSmhJMEtiR2pkd0pxaGZhVmt6UXFOOGlzUjZSdGptVTEyM01TRnRT?=
 =?utf-8?B?U1dWbENXRDBUVGVGREZaN1MrM1VQWUZJYkI3VXIzdUNtSW9VZTNvT0orZkE3?=
 =?utf-8?B?UVowcWhLbEJVUGdTMno5V0FMRk5GZElMeGV5Y2VOWmtNbDlsaWx1YXRYeHhH?=
 =?utf-8?B?dHUzRGVvRkZNSzc5Q0hsNkZiSVIxaGlSUEcvL2s4MHhORmVnYnVYcVhOZzhs?=
 =?utf-8?B?VGFNbHBQcldsQjJpa1k5eXdsNk9DN1RTTkJJVUhvWGlDWGNlalZoUm1yZWVE?=
 =?utf-8?B?ZEdyUVBIZjl1NllEWUNqK0x4b1FadFhJdlJvNU9LNVltQ29CODRuZjdvYWtI?=
 =?utf-8?B?OXEzL1oxYnFMcStLUTZiUnM3M3JSNXVrc042RENkZnE0YTlJSVhRQmZ5c3Jp?=
 =?utf-8?B?cDAvRTIvM052cWcvVVJrd29iSUh3di85NFp3d3ZuSzdRRkNGZ3Y4aDVqU1Ja?=
 =?utf-8?B?dGhEVkVMZ2U3dTlMWndyOWdzVXQ4WEZ0WlBwdm81UDhtTU1DZ0l0K0hWWHg1?=
 =?utf-8?B?YVZNK3hsTGVwbzFNaWxCS3ZTdzNXWEgwRjFrZGl5cGFnemQvaS9zbi8vazZX?=
 =?utf-8?B?QnBPeDBWQjBJNUpSVmNCWUtlVjU1RHZWR05PWmxVN1pLTFVoZzFHdE1Ud1gr?=
 =?utf-8?B?OXh5SHZXWGZCMEVKa0ZRMHBGOFNUT3dUYTlWNU90aTVuWFJDbXFpVVFrZWR2?=
 =?utf-8?B?Nk5yazRYL0RBMFdyK0RLMWlNYXliaVdYOGw3SGhoZGZZRjZaSUg5dkYyZE1D?=
 =?utf-8?B?VnlhMFptczNIKzVFWjdRMWNLemFydkhKVDl6OERBRVF4alI3QUlXKy8yTkJq?=
 =?utf-8?B?NjUvV25SUWdRQVFCdkhnWHNkR0FTbFJDSkl0M0MvMVJGU0I3UUpBQ0FaQTlI?=
 =?utf-8?B?ZXplYlA2WGFZYXFWdlJHTU5jeDA3bUovR2d4WWErV1BUNy9XeklpajJNYWFP?=
 =?utf-8?B?ZmVWRitVYUFYM3J3YkFKZGJqV3NUZjExcGtUdW1JdnVxTFFvUzdwVmVxUEtr?=
 =?utf-8?B?bll1TjY0azRRcEtGdjRzMWs1UGd2alZhV21STWprNGhiVXNId2NYNmZPK05G?=
 =?utf-8?B?RWh1Q01MdG5sb3NQU2RQUXdtaXNRdkhHb0toNkVkcE1xdWI3cW5MOHhRenNt?=
 =?utf-8?B?UDlqZlhGeTBRVjJrT2ptN2hVcGpQYlBGdVJ4UFRhU0FuOFBRMXFWT0pOb2p4?=
 =?utf-8?B?WnQycTRBbHo2b0JIUHY5MHd4MFNFWG9qRFM4RXYvdngzNEVGTW1xTmE0ZUhn?=
 =?utf-8?B?c0pEbEpMMmhNVHZBUG9ONU45YkQxclJ5dUh0ck1Lb3F5NThzcE1scXlyUERu?=
 =?utf-8?B?WSs3OTBFWjdIaDdLdVdYVlA3UXNxMDZEREpwK1YyWDVDcnBuNjBmSnJvQlpx?=
 =?utf-8?B?amZpZXRlSk1zR1dyZjBrZFhwdnpGemlUV1NvYWFYcENQYlZVdk02b1lGOFJH?=
 =?utf-8?B?RW9tSlVTZXdMSEhhZWIwUnI1YVVFRHc0R1BBK29FRDNHWk9kWlY5Ky9vMFdm?=
 =?utf-8?B?NEFDbGg4N3N4SnduNnhid01jVzlmamdxaUVBcnd2TUsyanovaFNWc0tSUzFl?=
 =?utf-8?Q?iGnN6EvbvkkPR4ifE2EMZ7+nn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d30c66c7-97cd-44fa-69ff-08db681da8f6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 12:41:20.3857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ObI2zk9W4+23QYfdE2X2GHy9lNxHr3rqvirTpH6e1J+2ml94fPyJsYCMomPYr6FCt08OzlcIwDFBcXxfF6pGog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5259
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230608_054128_578889_ACED7868 
X-CRM114-Status: GOOD (  12.60  )
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



On 06/06/2023 1:02, Sagi Grimberg wrote:
> 
> 
> On 6/5/23 12:19, Chaitanya Kulkarni wrote:
>> Add a common helper to factor out buffer allocation in
>> nvmet_execute_auth_send() and nvmet_execute_auth_receive() and call it
>> from nvmet_auth_common_prep() once we done with the secp/spsp0/spsp1
>> check.
>>
>> Only functional change in this patch is transfer buffer allocation is
>> moved before nvmet_check_transfer_len() and it is freed if when
>> nvmet_check_transfer_len() fails. But similar allocation and free is
>> used in error unwind path in nvme code and it is not in fast path, so
>> it shuold be fine.
> 
> This is asking for a future memory leak. It kinda makes sense to
> allocate after we run sanity checks on the request...
> 

Also I don't understand why do we need helper function for malloc ?
Allocating using nvmet_auth_alloc_transfer_buffer() and freeing using 
free() is just make the driver maintenance harder.

Another problem in this patch is that the len in the recv buffer is 
le32_to_cpu(req->cmd->auth_receive.al) and in the send is 
le32_to_cpu(req->cmd->auth_send.tl) so it's logically wrong to unify 
them. Same for error_loc.

maybe just don't include this patch 2/3 in V4 ?

