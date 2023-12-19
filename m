Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2FD8C41535
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Dec 2023 23:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zzQcS1QPNiS1nszL9Wa3t6//6ODbKK5ZAYSSFXaXNhc=; b=gQZMTbOo6CLr0Rp1MoiKYgF2i7
	EjzSQRXgjoh0XJdBaozfoi9ZMR45EEHkSHfr1h1e7+hzH9ADciPP+lUJuW9duy5XTwDg90JKLKq0l
	KdR39u+aLnM2fhrE9KZA6qRhtFXAReICATj3YWlcGoKncP/RctBR+sImtA7YPD0DwS6AT5rTjwN53
	Tv6SwJi6TFU1nZFSblBlYp8D1E7I10pOesmCM3vIpk5Ee6+YmmMcTNk/o9sGFQHZ1oSWDky8upQrg
	oFeDGdSx0Ghe/blknsAy4ACbKJNe6IsQdEqEeDUd532+hTrEj2041S2yJ+sHyjGneuLBY7eSz+R4B
	YTHYJVhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFjwk-00Fie4-13;
	Tue, 19 Dec 2023 23:56:22 +0000
Received: from mail-dm6nam11on20608.outbound.protection.outlook.com ([2a01:111:f400:7eaa::608] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFjwf-00Fice-1B
	for linux-nvme@lists.infradead.org;
	Tue, 19 Dec 2023 23:56:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XkQi64eErb6vFJ39lVeXM0xdhSb5I90q9x/qS4T4XaT9jfG5K0KiLPv61fu2T9eIXSJ2yqtXXhOO98m8yzNbaJLHaMoxm/tiWvoAdEvI9NZYceidPLaIlLgqvexNYd9mRxYVKWi76IGEf/yKwBh1vBySv9NrXyE3qlh/ct/tUpfKwo0jg9GJxRoAJ8OXhGXZSKIQcIzAIYtLK9DVV+m9ZtVqLaAJwwxcTZn8NFbN4j8U6d1oCgRGrr5peupEV7A7X8aAaSQRZb69FvVkgX8J6lXNb8Y2Swi0ZsvswpWDOmfeaI3+O3AQ7HNbWTRyd4wjuH8hyJI3HvEtrMGA0AXONQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zzQcS1QPNiS1nszL9Wa3t6//6ODbKK5ZAYSSFXaXNhc=;
 b=Mr6RF+6EbJ6o4zbUHCqJA1X4mt6FyCsibdehENmZuBojutdDTEPVeAEIZynC6szJ7f5AGuXACiN8Ah7+pt6SSxdGq6cQoopIGSiJXAngULNj72t95PeZTShqr4V789zwUV7fopgqydf8YLBzW6j8Yi8WmsZ/2HHHq63/CoH0H76QEib67bLbeFZlMdDAhrepujYpjWT5QLs190lHsLjt34y8XT5TWTJYMmTfzrk6pQaglL5x/xeS0/xvEunUt86cYCWEpDxTj5aTmH3RPXpdnKMffhWqjm0ZwLXFulFTZxfsvoxKuTENIYlTRyAqTkH6foauIgBjGm1bRZjWtuIN5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zzQcS1QPNiS1nszL9Wa3t6//6ODbKK5ZAYSSFXaXNhc=;
 b=ROFykmYoORL37qraaS/Ta/UeUfLIlf/11i7BhySMyGysCEVOO9T8+nzTEYZyvvCXK4Kv0+1YK0D1LVQqm43OQO/dDkFeD9iMLzYIIwid5ZkLsbofcCnLzGCpKw5eKq55MtJwQxELXAlxg5O/0NteOZUIYf3cAEcBqXfIkcmDVj9QssV3IAgeyNFrPU2fEztOqJYPFTCbcCmAGtEV0WM+hLs/+FK05RI9yZleDwKFYRaObYTs5BKP2lf6cVnWDh9nlxDrwwWEFoVN8YNM2wQGCrFnzmw8iqKRE32yjdH2Awt5g1YT3taA+9sGyJQqqk0uCxglHwAF4hfzdZ7ikfPVCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by PH0PR12MB7815.namprd12.prod.outlook.com (2603:10b6:510:28a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 23:55:56 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504%4]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 23:55:56 +0000
Message-ID: <af03a48b-1084-4049-8cf7-a48088b3e5e2@nvidia.com>
Date: Wed, 20 Dec 2023 01:55:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: ioccsz and iorcsz check failing
Content-Language: en-US
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
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <c566399b-04cb-4aea-beb8-230dbdc9ebf9@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0143.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::35) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|PH0PR12MB7815:EE_
X-MS-Office365-Filtering-Correlation-Id: bf0551ae-396c-4cc8-f89d-08dc00ee0a9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xEYCLILfJ3JejJQtmEGFbMYhoQQRHY9Kkw2NhPH8BNPbQhSgndSY37dvnQHqChHnrnQcVDV01uhPnnp7WzrHaZp67oPEZgh8bTVJK1QF7DuHQECNz0kkcywiE+BF05lbFZ5NefV9ouJsaXndeWN35mLzekfbUawUltFh36Cmsh56ZvVQM/J08HbF1kiaYhB3p3EiFXlcpYzj3fEoHtXGBIrbbx+6V5U8UytcHp0CqmQk8DfO572L7n7MOJd6gng4nCcmCKgCv+dhvxCCSuhi5O1up5khH6bo7KFWzUyoD14I+NlrRah54Nj07il9l3ewY46d1QCmt/SK2aZ6WI8tC6c+Fm/21LIbyBDGWVhsaLjL/csaxL/YtYh+VtnmNRju2VeWgUWV2X3gltd4yunQPCCSB89mmpIZUSoJXAaeUnbFDC7/jf57R5pShsqe2+mYgKtVzaqQ3KS8NhzIjIuufz1l61PtONmBYGbRl0IcHCJ18AqYpgue+9llfgdDfj7QdYONaP197N3SYJaCGc+bE+wKWaOZqe/vzsrqwbVoKN/kVNMYkgu//9r+9jD3CFtp25XpfWTDS5cwHGw+ULErgfbcgjWkbsKaXcNkB4eL/vhYX4AXWXbkwzwiXo2KaHc0a5asCCv/6A7YKkxBhVxo3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(39860400002)(366004)(346002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(83380400001)(6506007)(6512007)(2616005)(53546011)(478600001)(5660300002)(26005)(2906002)(41300700001)(8676002)(110136005)(6666004)(4326008)(8936002)(316002)(6486002)(54906003)(66556008)(66476007)(66946007)(36756003)(86362001)(31696002)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzdlVXhKNjR6Zk95eUhPS2xNNHNQMTI4VnJHK1gxSEg2Nng0M0NDM0NMZWdG?=
 =?utf-8?B?TzQza2tHS21wOENMZ1psa0NpdXdjdEV4emNBWjRBUDVCMDZCdllFVHFrMHpk?=
 =?utf-8?B?U2h2aXZydVdBMFEwKzN4Z0xiczNNSEdkVERoeDd1YVJyekVtUTVXcUhPdWJk?=
 =?utf-8?B?VWJ2d2p6dVZWT2hidzczVEtqYUpKaEpNQTU3czI3amFnODFpTGlpcTF0Y0Jo?=
 =?utf-8?B?cHdQbS9kdWZHQ2hMNkhUSGxhOXYvamN1Q0djMEVHVHlmZHNXZjhrc2lMOGFw?=
 =?utf-8?B?UXdDUDdqVkVUUmNvamlnZVZqRlVBcnJ0bTRGWDJqWmI0QnJSV0xPc20zWHpo?=
 =?utf-8?B?cTlwVmlUQ3pDb0lxVlJDeGlXU3REdk5hVG5aNWlYbW9SbUdOeGZ3YnJKcS9V?=
 =?utf-8?B?Snd3OUowd2hDOFJvdkdwVkhNbUpDbGhNSHhGUVRFOHNhNEUvTVB5cHo3MW9I?=
 =?utf-8?B?VXVRNXVUQ0J4L0NoQms5WVFzeW9jL2N4UEJKZGtRak41L2pHaitvd28vdmVW?=
 =?utf-8?B?cng3eUVSejA1MFVYanB6L3VTZDl6ajNmVFplOU1FUnlIZXpodkpPcjJUUnpq?=
 =?utf-8?B?YUVDNVV1M1Rka2R3a2t3dk51MGlURFZ6ZWVpQmZTMS90SzhEclk0b2FkbkdH?=
 =?utf-8?B?eEx2MzZZOUdQVmUwaWNabmJBa09mVHE0d1pYMjJqMSsrM05PQUl6VnJSNkNJ?=
 =?utf-8?B?b080M01yRStDNWtTQVltM0VtNzNCL1dBclltR2tKZmV6bHVqSTZYTStEWGZB?=
 =?utf-8?B?NUxXdWg0QmVEU2lVekt0cXFLMWE1RmIwNUFtYXNNeFpObnZXNXAwNnEreEdk?=
 =?utf-8?B?MVo3QzNzQlRTKy9QYWpId0RIV1o0bFgxTHF3QU1SVjUrYU9WZm44VGlFb1g1?=
 =?utf-8?B?THJwRkE5Wi9oaTBqS0hpL1hXd3BuSC9LeTFMUW56RHQ4azlsWlQ5YTZXL3hF?=
 =?utf-8?B?Tm95a3VLZTR6M3hrTFlRNlNJelpiNldiMjVzQzRjNXVyTDc2TUl1Ly9hVjgw?=
 =?utf-8?B?WERHVnlWUTk2Z2xBR1kvSGMvNDdPSExNU0djWDBibzhzUGR2dzVlaERaa0xH?=
 =?utf-8?B?bkdSTGlHVVlodHNVUjhrcEgwSDBVbkdndm53SS9IUFFrdXVYYkdKdzRUZm5Y?=
 =?utf-8?B?djJWTFQ5RVNBZEtySnZEanZFblJpMWVVajczQ082Y0gvME1ESHltVXlvNlVo?=
 =?utf-8?B?N3c4ZmRVcGFxdEdsZEpOQk9NbUk2MFRXZVF2Y0JBZ2srTy96UjBPTVBOc2Ey?=
 =?utf-8?B?UW1yUTdLcjE4RTBzYVZGV3hXQVdTdUFLMXF0bEE5TnJtdHVNZ3J1TlY3YVI2?=
 =?utf-8?B?bzFyU2VDSXVGaXZFaGtXMHc2QllRNzFZN1RWbDR3Znd1RU9tRmZwa1Y1Q2lZ?=
 =?utf-8?B?OVhJQ2ZrTE5xb2ZRVWVldGZBK1J2cVNjblQySFhxOFRHbFZYMzZqN1IvZEQ4?=
 =?utf-8?B?Vk9nNWdwS0liZWZaa2xzbGo3YVM1b241cm5hUzR3MHMzVzIzODk0akhUc0NM?=
 =?utf-8?B?Nzk1UkJIUXJqTS9Kc2Uvb2RhQU5xN1BpR2VRMWE1bmVPT2dwSm9jaG5rVUZF?=
 =?utf-8?B?dXFaNVBGbU4xekpqVysycmlYUDlYenYxdFVIYndNT1J4ZDhCaCtFbUJaVEdh?=
 =?utf-8?B?YkRkOStsZ2RQTnl5cDd4cmprYUhKYUpiRXI5elhwbTdhTWh5ejM0TG5nRzBu?=
 =?utf-8?B?K25NeGd1bjZkWjUrUjhrSlhldk92aVRDdXQybk5saTk0cWhnMThDL3FYcndO?=
 =?utf-8?B?T3Iza0RjaVRVVlIwOXZIRGUwQjkwcWd3ZUE1RklONkZpWWhjNkIwYkpvd01k?=
 =?utf-8?B?SExMVmlQTEEwS1NrekxQNHBXV1pmLzl0NnpReERUeE40QThGbmhpNVE2SU01?=
 =?utf-8?B?bXMxNFZicDJlVlk3cmx3a0RkbjVkZHRJdVdiVzlOMXVPWmZCRFBMSWk0SDk4?=
 =?utf-8?B?cS9TMngxcnRBcFVZblRwY0lSdGRuSjl3QmIxZGxXVWpHYnZEZkFJWC9UY1Vy?=
 =?utf-8?B?MkttYkx2WmZvRkdLOHpjL2ZiWEJ3andoaS9iQVRDTmdZa2MxNnRnaGdobVU1?=
 =?utf-8?B?bDFGUUFQRlVCRzNWMUJqNDl5TE9OeFpqRWU5VDNtQ2ZkRHpQLzg4SUZWVlUy?=
 =?utf-8?Q?AcAzxV0r+Fvot9FDFTLQx3kCS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf0551ae-396c-4cc8-f89d-08dc00ee0a9d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 23:55:56.6352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x8+iqoyGFoxSRUjDCHLNJ0KiY1f0WxYhCNKO2z9MpD1ESzf639q/+iKhewwxAsd3sFz9RXDO1L7W6vx0SLQazQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7815
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231219_155617_573053_78B2B53E 
X-CRM114-Status: GOOD (  21.96  )
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



On 19/12/2023 21:59, Sagi Grimberg wrote:
> 
> 
> On 12/19/23 19:24, Max Gurtovoy wrote:
>>
>>
>> On 18/12/2023 18:04, Sagi Grimberg wrote:
>>>
>>>>> Is anything else in the identify wrong, or is it just these
>>>>> fabrics fields?
>>>>
>>>> So what I am seeing on the wire are a few fabrics commands (connect,
>>>> get
>>>> property) followed by the nvme id ctrl command (opcode 0x6).
>>>>
>>>>    nvmet: nvmet_req_init:962
>>>>    nvmet: nvmet_parse_admin_cmd:1011
>>>>    nvmet: nvmet_parse_discovery_cmd:359 opcode 6
>>>>
>>>> This calls then nvmet_execute_disc_identify, so adding
>>>>
>>>> --- a/drivers/nvme/target/discovery.c
>>>> +++ b/drivers/nvme/target/discovery.c
>>>> @@ -249,6 +249,7 @@ static void nvmet_execute_disc_identify(struct
>>>> nvmet_req *req)
>>>>    {
>>>>           struct nvmet_ctrl *ctrl = req->sq->ctrl;
>>>>           struct nvme_id_ctrl *id;
>>>> +       u32 cmd_capsule_size;
>>>>           u16 status = 0;
>>>>
>>>>           if (!nvmet_check_transfer_len(req, NVME_IDENTIFY_DATA_SIZE))
>>>> @@ -289,6 +290,17 @@ static void nvmet_execute_disc_identify(struct
>>>> nvmet_req *req)
>>>>                   id->sgls |= cpu_to_le32(1 << 2);
>>>>           if (req->port->inline_data_size)
>>>>                   id->sgls |= cpu_to_le32(1 << 20);
>>>> +       /*
>>>> +        * Max command capsule size is sqe + in-capsule data size.
>>>> +        * Disable in-capsule data for Metadata capable controllers.
>>>> +        */
>>>> +       cmd_capsule_size = sizeof(struct nvme_command);
>>>> +       if (!ctrl->pi_support)
>>>> +               cmd_capsule_size += req->port->inline_data_size;
>>>> +       id->ioccsz = cpu_to_le32(cmd_capsule_size / 16);
>>>
>>> Yes, this is the culprit. Nice that it exposed a bug.
>>>
>>> There is no in-capsule data for discovery controllers afaict.
>>
>> Also, the discovery controllers can't support PI AFAIK.
> 
> Indeed, we should simply set it to sizeof(struct nvme_command) / 16.
> 
> It is true that for tcp transport we should add additional 8192 which
> is mandatory for nvme-tcp. But that can be done in an incremental patch.

I'm not aware of additional 8k of mandatory size for nvme-tcp discovery 
controllers.
what is this needed for ?

I was re-thinking about this issue again and I think that the original 
patch that caused the problem that Daniel found is wrong from spec 
perspective and also breaks compatibility with linux target for no 
reason. And maybe with other targets as well.

A discovery controller according to the spec does not implement IO 
queues or expose namespaces. So why do we even check for IOCCSZ and 
IORCSZ for these controllers ?
It is also mentioned explicitly that these 2 fields are reserved for 
discovery controllers.

SPEC:
"
I/O Queue Command Capsule Supported Size (IOCCSZ): This field defines 
the maximum I/O command capsule size in 16 byte units. The minimum value 
that shall be indicated is 4 corresponding to 64 bytes.

I/O Queue Response Capsule Supported Size (IORCSZ): This field defines 
the maximum I/O response capsule size in 16 byte units. The minimum 
value that shall be indicated is 1 corresponding to 16 bytes.
"

I suggest the following untested code to fix *only* the host driver side:

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ee2e4c49892d..89e01e6b5fe4 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3068,14 +3068,14 @@ static int nvme_check_ctrl_fabric_info(struct 
nvme_ctrl *ctrl, struct nvme_id_ct
                 return -EINVAL;
         }

-       if (ctrl->ioccsz < 4) {
+       if (nvme_discovery_ctrl(ctrl) && ctrl->ioccsz < 4) {
                 dev_err(ctrl->device,
                         "I/O queue command capsule supported size %d < 
4\n",
                         ctrl->ioccsz);
                 return -EINVAL;
         }

-       if (ctrl->iorcsz < 1) {
+       if (nvme_discovery_ctrl(ctrl) && ctrl->iorcsz < 1) {
                 dev_err(ctrl->device,
                         "I/O queue response capsule supported size %d < 
1\n",
                         ctrl->iorcsz);


Daniel,
can you please test the above and if it works I'll send a fix with your 
Tested-By signature. We must have it merged to next 6.7 rc.

-Max.

