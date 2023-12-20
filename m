Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 874E1C41535
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Dec 2023 00:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Cc:To:From:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Jym0fHmQjfpTa/qlqgBTSiF6pReYtygil3bsAMqaQ2c=; b=OcwwSYru1wCmdFHDxyfQR7SqoN
	ipsDgXlrdbRSs/kfQozHQ9Oh2ysFh+RKAvH892Hn74g/9Huenzb/4wqDc4NimHydZzwrqYxUJAWoe
	4GbAux93hvS5b2Pu5qZRioQ2mDK0/ET4cikNeHVNSOWo+jCLHcNdT1op1yxzUd+jRV4JPu6hHnFdG
	jIsp1tPW2XBd14kmj5+QUatcDFbp1vj5NJ0z53y3GCx7Z9sGfG4CCu/3Ze0d4j43K0CpPQMgPTrdo
	ckfxgHNnrWVVqAhHfxztrFLO4/4Lct8E6gs8eN1Ob5c5I+aDoj6wXOsLyyZ6QPGeLXd53m9V8TIew
	1UINlXUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFkAv-00FkFP-0w;
	Wed, 20 Dec 2023 00:11:01 +0000
Received: from mail-mw2nam10on20601.outbound.protection.outlook.com ([2a01:111:f403:2412::601] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFkAr-00FkEH-2q
	for linux-nvme@lists.infradead.org;
	Wed, 20 Dec 2023 00:10:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BUYrn6rsKzcP/m2NldBZxp5zLzTrJxWMDeKtdp9BbvBn6hxTH3IO5NmBUWVsQgTv9hARu97My1JAsWuc8H7OfYtgN5GyObQBCpofVezOc+V9+2XWPgQwvE0XaZ+3lgLvrcITSt2tJ49Tc8Fb63i74R9Zre/sBlK9M2lEWQYNbCWzYKFCKkNEU0tRVyRPuBI4Tv3TGFwp+gXuznT8ocL1xk3PJRY2NiZSGFRQ5iucVzz22wIQbQydskOtCnPZL+ibeRoFoWbkO9aF60XOfstt3yi1wpEhboi9s9Kp/Yn3hm2pFrdGDB7Nowb8Afhk9Tzx0L8Ik4098iTbuo26bu9g3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jym0fHmQjfpTa/qlqgBTSiF6pReYtygil3bsAMqaQ2c=;
 b=liDejTSM1zRTLyK2dGlrcIhAO/AYrouUGurFu7CGASxuKbJ9ZlMPCu+yq2/8yRRklXz4iXiqqazGKCDaVwi9XVmx1S0D+Qr3Cuckvl4O/BCS9CYEqTqimCPNoSjc+BxEn1Pbk8Xtyx1QTTF7hhHAji/6M29Syo8YIazI0o/L3yReCpMR7fY9mqypRQw0EXR9i/cYPEp3uz3ZO992HoiU3hKPqHofUscdi1Zq6YYFsxuhhy8zUkJ8L7tisyZfh3nvubsQqMhq75cFcV6+CE3S2scCF3GCociCPu9IS+7PKZYvgK7f12CKcvY5Sr5N1zEvYlu2NoYXnABLb4db6F8wpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jym0fHmQjfpTa/qlqgBTSiF6pReYtygil3bsAMqaQ2c=;
 b=CAkRSRZfxWC5QDAgoTjMHjdJUASWTD9sdWzmK7CEERW8h8v69MmTu7dynnRwhKIO2MrLkRbSxI8mpp0IDC0QsPrgWc0sn2iwwDdRlDme7sZ7SYsbsDe1i7Xym1bxkpAA7WQ0IYoN0P5hHFcSssxYJN9cp6GTNIf9Q8htMFeqUWlsGKcsijx+WgA13lNYTLSUQyOYIPM+JOPsYgr+qIzUuZ2jS3XzHDu+URoYQNsWK0gvvOJy5LwjDRfQTllJnlCdnR4nuVR8n+QQihx+J20JhqXqY0TrU4vgeypkYp9CF52r+NcCUW9iQIDZJ75vtcAb5WtNDzS/Cyk4W1qJMKlOQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by IA0PR12MB8326.namprd12.prod.outlook.com (2603:10b6:208:40d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Wed, 20 Dec
 2023 00:10:48 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504%4]) with mapi id 15.20.7091.034; Wed, 20 Dec 2023
 00:10:48 +0000
Message-ID: <a4ec22ae-c7b7-4583-a41d-52755eb5f301@nvidia.com>
Date: Wed, 20 Dec 2023 02:10:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: ioccsz and iorcsz check failing
Content-Language: en-US
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>
Cc: Keith Busch <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>
References: <6ib6nyftuap3ubf7uryt6sndmomfif47nkforsitadbda2pdkb@ie35lozrsiqf>
 <ZXyWKKhaDUpyOXsK@kbusch-mbp.dhcp.thefacebook.com>
 <74327ed0-63f6-4e9e-9d7c-2bf0eaf264d3@grimberg.me>
 <p5sosvqw3z4bajhhobw2eng73dfk6drbjgste4hrik3te4wie4@wxytk76vjlim>
 <0efbe093-6f9e-4026-92aa-3442bde68e7b@grimberg.me>
 <d2754a5a-8162-4e66-89ba-466127eb7d3a@nvidia.com>
 <c566399b-04cb-4aea-beb8-230dbdc9ebf9@grimberg.me>
 <af03a48b-1084-4049-8cf7-a48088b3e5e2@nvidia.com>
In-Reply-To: <af03a48b-1084-4049-8cf7-a48088b3e5e2@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO6P265CA0008.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::18) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|IA0PR12MB8326:EE_
X-MS-Office365-Filtering-Correlation-Id: a1503444-9a5d-475a-b3fb-08dc00f01e54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U7tRRvtx/eBRnpDJ16FDn3X7oMxVSNyILapm7dhv3Qb4/KuxfuYEJx6PaDELxYvTGNzs6ZscKGqIeD4PZPDoj5y9zevmX/bciowb67ka4vBvupJ2vOw0DBb8JnxYVW2EARgoYqxvGqe92TzRzBqy+sGvA49ART4pbDNZkG6nUcha8Ld1UiisjoBnS3tdn/dWjX+eXPjykaieYQKIib1Tk7r0w+2Y9f3ZRdPKtvlQVAuzYC6+0nQUS3saS5zvPLECoDRlQYsmiDk+2QpwXZEq3KyKwFo6evkkfoMgHogeoVaYrchaeicTBnj1dvgHWNRnHkKEaQbqBDiAmBaBmDOT0vxyb4ohdrtBZbmqgvQLszM+rdsu5+TqwQoPcQVI4hdDNi4JnmfNF9oqL2NqVfJ9XUDFyM0p+6WsixA/2t69mmNAwJ9C4NV98RH/vUXa6mrkRZyiBRFsn0Ij2IlU6jq3BIPkjjtQf6sSZ7I5JjrgLZP3PmYxh7fI4vzDaXqpt5/khhiEfB0dwKYNuXdioFPSDZdoGAaE1J9/oZWhzXYLnHbU3KrzNoxV+oVr/u8vQeOzdGpJJa8n/okC84u9lunX2LEkOYQlclE5yiMsnryMWby3/14XqVNb13pxsfvcgiPpH2+m4F+m1SqxSbSmnboKRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(396003)(346002)(136003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(26005)(2616005)(6506007)(6512007)(6666004)(53546011)(5660300002)(2906002)(83380400001)(478600001)(8676002)(8936002)(4326008)(110136005)(6486002)(66476007)(54906003)(66946007)(66556008)(316002)(38100700002)(41300700001)(86362001)(31696002)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1VBMWRPc3JtRGRSMmdJTVNxWFBtN09Ta25QTUY0bjh6alNPUUhQY1FIVzRP?=
 =?utf-8?B?VFN1YWhBOStSUEN1bEdnc2dSa3pwaFJsaW5tR2h3UGZVWFJicERVSVE4S21K?=
 =?utf-8?B?YW1BVWUzVFp3ZERQenlVRmg3blBEQ3A1MStKaWdNc1d0NitvN1AyM280L3NE?=
 =?utf-8?B?cUhZbkVCa1VJU0ZwLzBCYVhXVXN4MlN5WDhpNWJIYWtNTDgzeTg4bHByM0pz?=
 =?utf-8?B?cndMYVJvNzgyU3NnSVVTUVVLdFY0QUJxVmhnQlNGYzEwRFNtSlJKdHhZMUE4?=
 =?utf-8?B?cC9pdWYzMmlyeVNBcWpGWG44UUNRb0p0TkZpd2E5TFJOSk9LZzNOSFY2TkJt?=
 =?utf-8?B?NzJ2cWZqVFpnZTVBSHk0UEszVzErK09pbk1LdGRMNEFnVVhXNjltSTRiREpI?=
 =?utf-8?B?T0lKQitrMmNBU1A1UHBwZ1UwYm41OUtxcStTU1VpTmt2WlhNTElGd2FyTmNO?=
 =?utf-8?B?bThVbUdJemZheHFxWEloQjAwVkpYQUkxVWVVWnUyWk96SFNLaVRWYlNUbHc5?=
 =?utf-8?B?K1lhdkdxU2N4ZGRaZEZEV3N1UUNXVkM2elROdnB5S1E5OG0rL29wRTQ0V0Nv?=
 =?utf-8?B?YkVKazB2b0NYMVpXS25TYmZhdlVjTHA0SmtMTUdVYXJ0SmtqQ2JsazNxUjRt?=
 =?utf-8?B?WjlmNjVEc2VpOU1tRmpyV1pQYXNoRGcwVjl5cWcxRnFHMG41TFJKZjZHTWM1?=
 =?utf-8?B?TVg4b3dqbFJrVnBZVTNDdmlaN3pzZ0hESFRpdjRuSy9vTVNZb3lhK3I5ZFpC?=
 =?utf-8?B?NjcyaHA5c2h1S0haclhDL2J5TmlMTFVZb2g0U0pZZW5GMTZoUU4xbU5sOUZQ?=
 =?utf-8?B?bU5ENzAvVXpkWTR5KzdnWmRzcFNQQjkrVjlNdEp0R2Y2TEdNY203MkE0Wjlt?=
 =?utf-8?B?NElhMFUySkRwS2x2Tms1V0k0MitTckdlTE1HajFPSUdvckEyVWNOb21tUmFK?=
 =?utf-8?B?R2lWc21JRkJTdXJpckg0c2oySWdLZUVkSzBRZ3N1d0t1K0lzSUVwOFBBV1hz?=
 =?utf-8?B?a0oxME9sVnJZMzdWS2ZmcG1PSlMrZDdQd3BPMWVyVnNLM0tTSnBRRDFNMXVQ?=
 =?utf-8?B?c1RaM24zNEFFV29Xa0h6a2FpOXk0elc3VGFaQzV4WHEycGRVYmowT1psV1lE?=
 =?utf-8?B?cThHTiszQWVmRlpza0FzcUFMQUVva1FUWllFSCtmUk5zYlB0TlRFaVZKMDFh?=
 =?utf-8?B?QjR3T0lRVG5ScVhXMmhNaGpBanRMVm1uUmhpZ3RGVkFLRFErKzA0aURHWVhu?=
 =?utf-8?B?WjdZeFlwU2dxL0VCWDE3NDVaZm1BNk1WR1Z2ZEo1UHdJYkNrdWJycGg2Ni8v?=
 =?utf-8?B?ekd3eDhQV1dKUVdEQ1V0YlB0SmpjZm5JRWxxNjFJYUgxb252WWhndG5SNy9B?=
 =?utf-8?B?Ylc2UzhNSWxWbW4yTHRNV3N3OVh4alViZ3RtMlpYZjhIa2lZdTNzSTl1cFdx?=
 =?utf-8?B?aUh5Ynp5em9YMVQwaDcyakR6TmRHYXZVQm1XSVN1WnNYbllaV0U3QWJXbXRR?=
 =?utf-8?B?YWx6UWptMEJQd0oyb1QyVG9DcnZhcWd6WUlBSjl5ZzFRejkraGpVd2xQNkQv?=
 =?utf-8?B?dGRpZWd4Z09JWlkrc3R2cDdXVWw0VEYybjFHdGtHUVFHNk9xcFBST0tUT2l1?=
 =?utf-8?B?OHFVWDJuVXBHVnN5REhOcjZFOFBEeW1DVjdCaGpuTStuVDVxamZXT3pQaHZq?=
 =?utf-8?B?UzJPWFUrVHpYam8wUkpaU1YwREkyS2JRMHNyWEFuWHdhdTVYWXZjOCtEamRw?=
 =?utf-8?B?eFJTR3ptRjFnc1Z3eVBpRFd4ZXM1ZldxS1hYeGtzcGorUEpsLzE2b05XbnRq?=
 =?utf-8?B?ZjBOQ3V3TVpiMFcrNGRNa2gvQkNnTXJjTzI2eHhGWE1sVmJ2WDlnUnJ1ODBj?=
 =?utf-8?B?bURtMXJ3d3Rjd2N3OUFsTVQxUHJqdjRDTmVCcTVCc1ArT1NEM3NTcFFlZFJk?=
 =?utf-8?B?WnBtTWI5bzkyTTAxZHV2aUhuR3l3RDVQR2YzRlA5YmFIOWphbUVPYlcvYUhT?=
 =?utf-8?B?V2RRVzg1a2ZWaTJNeEovWjVKV1dwc0dPVVlHVVFqbnc2NUJvU1RxZUhKOWdj?=
 =?utf-8?B?K05rOWxnQXRQZ2xpWEFCNjUweTRucU9vK2hoZkZHdjhhbVNOY0kyL1FBR1Jt?=
 =?utf-8?B?YTlreW00Z0lyUWF6bml1bzRhUUdhTi9Hdkozbng0RGEyU2pzY2pxZUVlM3Nn?=
 =?utf-8?B?bEE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1503444-9a5d-475a-b3fb-08dc00f01e54
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 00:10:48.2838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2J14dEqFs3zUecnba+H640j4XN6H38i+FVInxBLCmLccCdBkaixpeNreLfoFRcycudV4b1LmH7M/1Di0e2tLAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8326
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231219_161057_978720_85FDE890 
X-CRM114-Status: GOOD (  32.24  )
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



On 20/12/2023 1:55, Max Gurtovoy wrote:
> 
> 
> On 19/12/2023 21:59, Sagi Grimberg wrote:
>>
>>
>> On 12/19/23 19:24, Max Gurtovoy wrote:
>>>
>>>
>>> On 18/12/2023 18:04, Sagi Grimberg wrote:
>>>>
>>>>>> Is anything else in the identify wrong, or is it just these
>>>>>> fabrics fields?
>>>>>
>>>>> So what I am seeing on the wire are a few fabrics commands (connect,
>>>>> get
>>>>> property) followed by the nvme id ctrl command (opcode 0x6).
>>>>>
>>>>>    nvmet: nvmet_req_init:962
>>>>>    nvmet: nvmet_parse_admin_cmd:1011
>>>>>    nvmet: nvmet_parse_discovery_cmd:359 opcode 6
>>>>>
>>>>> This calls then nvmet_execute_disc_identify, so adding
>>>>>
>>>>> --- a/drivers/nvme/target/discovery.c
>>>>> +++ b/drivers/nvme/target/discovery.c
>>>>> @@ -249,6 +249,7 @@ static void nvmet_execute_disc_identify(struct
>>>>> nvmet_req *req)
>>>>>    {
>>>>>           struct nvmet_ctrl *ctrl = req->sq->ctrl;
>>>>>           struct nvme_id_ctrl *id;
>>>>> +       u32 cmd_capsule_size;
>>>>>           u16 status = 0;
>>>>>
>>>>>           if (!nvmet_check_transfer_len(req, NVME_IDENTIFY_DATA_SIZE))
>>>>> @@ -289,6 +290,17 @@ static void nvmet_execute_disc_identify(struct
>>>>> nvmet_req *req)
>>>>>                   id->sgls |= cpu_to_le32(1 << 2);
>>>>>           if (req->port->inline_data_size)
>>>>>                   id->sgls |= cpu_to_le32(1 << 20);
>>>>> +       /*
>>>>> +        * Max command capsule size is sqe + in-capsule data size.
>>>>> +        * Disable in-capsule data for Metadata capable controllers.
>>>>> +        */
>>>>> +       cmd_capsule_size = sizeof(struct nvme_command);
>>>>> +       if (!ctrl->pi_support)
>>>>> +               cmd_capsule_size += req->port->inline_data_size;
>>>>> +       id->ioccsz = cpu_to_le32(cmd_capsule_size / 16);
>>>>
>>>> Yes, this is the culprit. Nice that it exposed a bug.
>>>>
>>>> There is no in-capsule data for discovery controllers afaict.
>>>
>>> Also, the discovery controllers can't support PI AFAIK.
>>
>> Indeed, we should simply set it to sizeof(struct nvme_command) / 16.
>>
>> It is true that for tcp transport we should add additional 8192 which
>> is mandatory for nvme-tcp. But that can be done in an incremental patch.
> 
> I'm not aware of additional 8k of mandatory size for nvme-tcp discovery 
> controllers.
> what is this needed for ?
> 
> I was re-thinking about this issue again and I think that the original 
> patch that caused the problem that Daniel found is wrong from spec 
> perspective and also breaks compatibility with linux target for no 
> reason. And maybe with other targets as well.
> 
> A discovery controller according to the spec does not implement IO 
> queues or expose namespaces. So why do we even check for IOCCSZ and 
> IORCSZ for these controllers ?
> It is also mentioned explicitly that these 2 fields are reserved for 
> discovery controllers.
> 
> SPEC:
> "
> I/O Queue Command Capsule Supported Size (IOCCSZ): This field defines 
> the maximum I/O command capsule size in 16 byte units. The minimum value 
> that shall be indicated is 4 corresponding to 64 bytes.
> 
> I/O Queue Response Capsule Supported Size (IORCSZ): This field defines 
> the maximum I/O response capsule size in 16 byte units. The minimum 
> value that shall be indicated is 1 corresponding to 16 bytes.
> "
> 
> I suggest the following untested code to fix *only* the host driver side:
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index ee2e4c49892d..89e01e6b5fe4 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3068,14 +3068,14 @@ static int nvme_check_ctrl_fabric_info(struct 
> nvme_ctrl *ctrl, struct nvme_id_ct
>                  return -EINVAL;
>          }
> 
> -       if (ctrl->ioccsz < 4) {
> +       if (nvme_discovery_ctrl(ctrl) && ctrl->ioccsz < 4) {
>                  dev_err(ctrl->device,
>                          "I/O queue command capsule supported size %d < 
> 4\n",
>                          ctrl->ioccsz);
>                  return -EINVAL;
>          }
> 
> -       if (ctrl->iorcsz < 1) {
> +       if (nvme_discovery_ctrl(ctrl) && ctrl->iorcsz < 1) {
>                  dev_err(ctrl->device,
>                          "I/O queue response capsule supported size %d < 
> 1\n",
>                          ctrl->iorcsz);
> 
> 
> Daniel,
> can you please test the above and if it works I'll send a fix with your 
> Tested-By signature. We must have it merged to next 6.7 rc.
> 
> -Max.
> 

Daniel,
I just saw that Caleb also noticed that it shouldn't be relevant for 
discovery controllers. The mail got lost in the mailbox.

Anyway, I believe the initiator/host code should be updated for 6.7 and 
must ignore these fields as the spec explicitly said it is reserved.
For the target side, I prefer to keep it 0 for reserved fields since 
this is the convention in all the specifications that I'm aware of.

Sagi/Christoph,
WDYT ?

I have a small bug for above code so please use:

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ee2e4c49892d..b218ac88fcf8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3068,14 +3068,14 @@ static int nvme_check_ctrl_fabric_info(struct 
nvme_ctrl *ctrl, struct nvme_id_ct
                 return -EINVAL;
         }

-       if (ctrl->ioccsz < 4) {
+       if (!nvme_discovery_ctrl(ctrl) && ctrl->ioccsz < 4) {
                 dev_err(ctrl->device,
                         "I/O queue command capsule supported size %d < 
4\n",
                         ctrl->ioccsz);
                 return -EINVAL;
         }

-       if (ctrl->iorcsz < 1) {
+       if (!nvme_discovery_ctrl(ctrl) && ctrl->iorcsz < 1) {
                 dev_err(ctrl->device,
                         "I/O queue response capsule supported size %d < 
1\n",
                         ctrl->iorcsz);



