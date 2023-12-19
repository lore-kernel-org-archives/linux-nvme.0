Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97E44C41535
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Dec 2023 17:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hbNFOswcy6tsUjBMVC42wHg9DkGn2JEFhc9Ai7niSh4=; b=mn9HFxItEv+KYB9hEipChEsjRH
	nDflHtGTgH5rBmIvJbJpxK24t/ayhNwKjGym0p/80vI84buzDpUg3bk5RNTM7ld7HUblA/8tCv6LA
	EUhluBcTFtFWUg2m/5HCIedyVRUGFrCpPH/jU1iIttq55nR0TSXn+UFnsnahAVHeDWJVsasKRnDr4
	CHZR1tjy6QEJaCnWnHyJh5MkEocXIyuxh1yfUNkfOPr50tpBV6vmxsQPfnx/SBwFaf+mweq6cg1e9
	K/Gc1ve/NDv8cGrKF0MgUb3xF+so46+bK+589jNhGT92/UDryOHz4Cs1ACGq3J36FJTsB4X3EgS6T
	sBJXmGdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFdpW-00EvN0-1l;
	Tue, 19 Dec 2023 17:24:30 +0000
Received: from mail-mw2nam10on20600.outbound.protection.outlook.com ([2a01:111:f403:2412::600] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFdpT-00EvLK-04
	for linux-nvme@lists.infradead.org;
	Tue, 19 Dec 2023 17:24:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QSnYMg7SAX5RfKBHVSLXP/Rhk23benI9ArDgjc1f4LYTN/ih2mbJqMPrkGcWQyIy6xMDIXx1bhcCspHuO/Oc9itTUN3v7rlWEwNOouDBxwzDFs0RSxG3Dr0o+00/UuOA6XlObB9YTf3hkKWLcadryEnoeC49xaXkZEqUYyf8OPKSARlUCvsuUYDrh0cWu4izXvrMfGPbCzu/DZJrAl9lh9HWGeAO35IXRxFnN+AzmvRFLPpL1uzXRseEUOP9qQ3xXT4cXVI1wUSv9AR9csbt/gJE5yRGAuV2xnq9vAIkXjISDswIiTyF2+tzQaaSupicpe5XMwO1nAWbHi4tLSHTKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hbNFOswcy6tsUjBMVC42wHg9DkGn2JEFhc9Ai7niSh4=;
 b=TdSNGIp+1qByCm25C8JXunfP6Uj0xcT0zAtN4gbqJGmU9JRpFJuUxW0MK9SQrEjpd2HqMYyJCW5L9a6Vjhe0Y0SIfH4hPtE15VEsLr0M6Dk2O+C1hSkJrRWZD7sCWvV6gqaqpCZ1c0EeBSV1Koz/W8e4RdbHiN3SQ26W+uM0jRB4lm4/p84RzhGCp+dJNX3apro13qW55udfTItSPZLZ2eIxRr5Bf8FNoTKoo5q1Ifr6w0EBJ7/fMhXqsiCXq1hsE1FjGfM9cN8army/xQdwNhKW6hn5oxkdE+kwp0JJB0SY4dEYg5+4bDgm5LIVfBlk8d8LBxxEwOsopblYoKJ3Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hbNFOswcy6tsUjBMVC42wHg9DkGn2JEFhc9Ai7niSh4=;
 b=OG0k1mYw5HC4vJ3fIPc0Azz4Zx6kOZFGNXZsCNEX6aNl+ry6G3oUD7uSqizly+6rXdGdov0q0COoNkeTN8rptrEkXWy1AdZ/sz0rTwFpFtGjbSaGQ16nn5roZz2GTd7oWNCODbwyZPNbaxUq/zyKUlU9mMRbk5FHMqwOBX/xDDR1986jQGQnCqFBaenwgVvNW9pdd1MSEGDibu34g3SJYhD9zSzf+j98TAfE/e3LfLdUjNtJwggevurRUr6Fz/jPw6q/P7Kl6h/tQYGbxhqLcBnGdOlzmp2O8UBFNCxeYf76Cy0iTyk0BUuxhH1cTad5GZrz7hwRsInTovF8dp6SPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by CH0PR12MB5386.namprd12.prod.outlook.com (2603:10b6:610:d5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 17:24:21 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504%4]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 17:24:21 +0000
Message-ID: <d2754a5a-8162-4e66-89ba-466127eb7d3a@nvidia.com>
Date: Tue, 19 Dec 2023 19:24:17 +0200
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
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <0efbe093-6f9e-4026-92aa-3442bde68e7b@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0448.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::28) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|CH0PR12MB5386:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f939618-c447-40ae-4931-08dc00b756bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7EglsnUR7+sPIu7MPXLk6c92KTpcPthM6HWYfNyb3sLVKWEz83yvSR7JrTtdL2Onhop8gz94dchgiSMpNgAf1lN2jN4fvwAVIXym3BiuPx9vrTyEn0v7RiTTud388gWhXRZ/Sp53lIs8ZVMnKV3JKXWhRFjfzdkw4Jh6zrRLjk3n5heQMP7mcxbtGzM6AM1TZYgbOxDslNw8GR43wqlLFqYhRwBln98YL1ICVgFgnI5PatJe9zYipgpNP7RWtxPJVnuXZrBhlsj53UuldcjQmXh8oLDmObJtvnXTjaAc7C5xrBvUVrervH+1360ig5W9yYVSvxzyfxAGtzdwEA2jQiOZ8jZtdFqMuAPi5xAnzv1Rrfb2URHp3tt/2jwkcXTn8xueg15b4uDVrGm+0+nVAatpKM7N67M/dJnTfjuOdqCeNJrvcTxcE1bYrhANqOGh19AXkQGKB+ldsx6RxA1vk59sLEZZrhFzNhAmw6mP829ng6B06sxysetnsuUflJth3ETWtNY+N2KsRJxeqRmeYOZCayM5IiMG9MFB8i1dDGkBzmsRJHGLUBLFw7+VRuIT8J/jDnu0p7+p135v3hzzt6aqMkI419Yx411PsmRP6uvn9XdfnM6qeDJmHR7I0HSf838psk2MxXXcHobFHRbLWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(346002)(366004)(396003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(4326008)(38100700002)(5660300002)(8936002)(8676002)(6666004)(53546011)(6512007)(6506007)(83380400001)(66946007)(316002)(110136005)(66556008)(66476007)(2906002)(6486002)(54906003)(41300700001)(26005)(31696002)(86362001)(31686004)(2616005)(478600001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aURoaVRSTHR4WDZTYnhUQjQwWXE1dWhJWGYvb1oxWkJEbVdIWnpYQ01hc2Vq?=
 =?utf-8?B?aGs2NktFZ2dQckE4WmliaW85RjlocGs1eGJMOUJ6cjdEZ3JnWVhkL09ESmU1?=
 =?utf-8?B?eHJaajIzamM1SmlDZ1k2eCtFUTZsTVRIZTVobWVqQWZQRklGYnZsVUxuU3JY?=
 =?utf-8?B?NDdmYVRBMkJENnNCNk9FdTk0NERkYVVkZDFuQzI5VzFCZU1LUEhRT2dSYUFE?=
 =?utf-8?B?NWtFM09sTGxCTXBXTVc1QWs1YnN5M2dQdjBnZldaVWN5Sk1vUDlVRlRtdE5z?=
 =?utf-8?B?cWs4NEVrYkVqZXgzdXlBU3p0aVA1WXN1NmlyL2dpeTJIRENiakpnYVVrclp5?=
 =?utf-8?B?Zk9zKzZmVFFNRUdpNDZMbkhMNHEzcjVYWTB4RzdDMmlVZU9MRkh5T3VoeWtn?=
 =?utf-8?B?YUhhVWpYODBpUitoQnlkVkFXYXpDOTdpREkyYzZLVzJ3czEvSEJUTXd1dnQ4?=
 =?utf-8?B?YWFBT3ZSbEJmaENvRUVuTDRyZkNzRUFWMFVPbVdzY1E0RmhveEsvdGIzaFhJ?=
 =?utf-8?B?U3YrZldTKyt6elgrQTVyZXZxT0pLa21HQk5nZ3c5QU9IbVdoZGp6LzVxbitR?=
 =?utf-8?B?MFlMYmEwU1NhVlhieTYyMndBWmlXN3piZllobWs5UzJkeUxmSytMYU53Z3dt?=
 =?utf-8?B?YWg2T1M5bTBKMDVZdnlnbEZSRSswMmxzK25BTEhNaDMxeGxaRm5wRzR5Qkh0?=
 =?utf-8?B?bzU0eUg2Mk9sZW51ekg3c0pmUzdEZ3pEZzRhNkJwY1pNaE45NVg4Q1Y1S2FW?=
 =?utf-8?B?bHRyWHhEQUNtWWdBSG9KSVJNa3pyUUYrNDlsNVZPbXR5TlUya0ptUFZseS91?=
 =?utf-8?B?YlMzNTBLK29HdjZmS0wxMUNyQVF0RnlnM2pYbGYyWHJkYkZ3b3hKc1FFMFZR?=
 =?utf-8?B?UjlPSzVTQms5SnRhcG9ESGorTy93aHpoZkgzYjBhSHNUMllMNk1yU1pNeEha?=
 =?utf-8?B?NW1CbHBJMUZlQlRjSHJDaDljSmxOZFpKY2puTHJNQzJkeHVibHNiRW4vb2xZ?=
 =?utf-8?B?OW0zWFRUdlJwTndxNEh5VDBxakFicjhGamJYNXhFejRGalpveWNUQTFuTnF6?=
 =?utf-8?B?MWlxMnkwOHc1Nk94ejVGTjZXRWpmN2d1TG8rSjNMUnU3MFAwT3ZRNHVZTDJJ?=
 =?utf-8?B?YzZDL0RScGVEaFdCcjl6RitrdjRtdVV0WFNDMXFHSUdkS3N5T3RRMW9LK1ox?=
 =?utf-8?B?KzZDOU10ZExGUmUyL2lqZ2FZNS9MM3lXR0FWNXNWb3JvUXA4cHpXdlpvQ3BS?=
 =?utf-8?B?aEJmT0E1Vk53RTNpZGFsQW9pRnJzS1lPR0hTamtWU1p0Y1lvakZYVEJERjJT?=
 =?utf-8?B?OFJZTjhSMjdHYURQTTJFTktCRndDQlR3QlptQ3N1RVU5d25pK3FHM25nRUVQ?=
 =?utf-8?B?OWJOKzd0czd4UzZmU2F5VXh0bGJvUjlqOTBmSGtpeEptQW9tSEFmVU4waHlO?=
 =?utf-8?B?cm5CNlB2cVdOcGhidDJPcS9yd2ZOU0xDa2w2MGRWMERnR0pVZ1Btd29sOXNh?=
 =?utf-8?B?SWw5bjR6YmV5OUpiOS9Ua0xrVHNkV0l1cGZ4bzFPZXlDb3AvZkxhVU8wR3Vh?=
 =?utf-8?B?ait1M05oK29PTkNSNGxjSHdBZlptTG1Jb1NpZk15TDkzc1R4bXErYmZEZDV2?=
 =?utf-8?B?aVBQZWQyMjVyWHhCVW5Ebk1MK2tLekxHc0lraVZ1TEh4SnM2NVJMMjlvLzQy?=
 =?utf-8?B?b2dBbDVyOGdjVjJjNXgxQTFDTTNxVExKMkYvcXpOWE1wT0s1R0YxN1FETFE4?=
 =?utf-8?B?YThFekQ3UFpaS1NCeExvMGJ2REZPZEZleXZCQUdCcmN3Vm5oNTBYMm5UYlVl?=
 =?utf-8?B?a1F0ZENXdjNwSU5nMHJYRWowelJUeXlvNEl5d01OUldJbmRKZHRhYVYxbmJ1?=
 =?utf-8?B?UVlWa3BGckVoYmlUb3R6VnIrVWw0aG1WVm1xWU1lTTNyZWRodUw2WVVySFlM?=
 =?utf-8?B?T0VmNndISjh1aE8wZVEwSytYWnFqZzZRaVBGR1ZBaGdocTNGa1BMS0sxdEIz?=
 =?utf-8?B?ditPSDQ3c2Y4dEZzL3IxcGtJOXBWc0pMMVU4aVcrY2RKRmhycDF3YU5nSHVS?=
 =?utf-8?B?V0dzaUhFaXNNbXNOVC8wUG5qRm5SNEluQkV1My9rM09QM1BhMkRabVp5eDQy?=
 =?utf-8?B?K2plZWFZSkVHbFRHOTZzaVQrTlU0MVF6Z1Z0TXFSd0lFUWtHYVErUGRsNUo0?=
 =?utf-8?B?eEE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f939618-c447-40ae-4931-08dc00b756bf
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 17:24:21.6262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /hPBr7aK742NdlvPYt+tLlKSD5y9GO4rhYBbabaWwLYL6Y7EgqGx8GMSGe2nJNVSSq2Q34S6P9bDNs3cGPz3SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5386
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231219_092427_208136_BB642963 
X-CRM114-Status: GOOD (  11.79  )
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



On 18/12/2023 18:04, Sagi Grimberg wrote:
> 
>>> Is anything else in the identify wrong, or is it just these
>>> fabrics fields?
>>
>> So what I am seeing on the wire are a few fabrics commands (connect, get
>> property) followed by the nvme id ctrl command (opcode 0x6).
>>
>>   nvmet: nvmet_req_init:962
>>   nvmet: nvmet_parse_admin_cmd:1011
>>   nvmet: nvmet_parse_discovery_cmd:359 opcode 6
>>
>> This calls then nvmet_execute_disc_identify, so adding
>>
>> --- a/drivers/nvme/target/discovery.c
>> +++ b/drivers/nvme/target/discovery.c
>> @@ -249,6 +249,7 @@ static void nvmet_execute_disc_identify(struct 
>> nvmet_req *req)
>>   {
>>          struct nvmet_ctrl *ctrl = req->sq->ctrl;
>>          struct nvme_id_ctrl *id;
>> +       u32 cmd_capsule_size;
>>          u16 status = 0;
>>
>>          if (!nvmet_check_transfer_len(req, NVME_IDENTIFY_DATA_SIZE))
>> @@ -289,6 +290,17 @@ static void nvmet_execute_disc_identify(struct 
>> nvmet_req *req)
>>                  id->sgls |= cpu_to_le32(1 << 2);
>>          if (req->port->inline_data_size)
>>                  id->sgls |= cpu_to_le32(1 << 20);
>> +       /*
>> +        * Max command capsule size is sqe + in-capsule data size.
>> +        * Disable in-capsule data for Metadata capable controllers.
>> +        */
>> +       cmd_capsule_size = sizeof(struct nvme_command);
>> +       if (!ctrl->pi_support)
>> +               cmd_capsule_size += req->port->inline_data_size;
>> +       id->ioccsz = cpu_to_le32(cmd_capsule_size / 16);
> 
> Yes, this is the culprit. Nice that it exposed a bug.
> 
> There is no in-capsule data for discovery controllers afaict.

Also, the discovery controllers can't support PI AFAIK.

