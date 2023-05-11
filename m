Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B8F2C7EE22
	for <linux-nvme@archiver.kernel.org>; Thu, 11 May 2023 14:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HqhcrVGe0g+TaBeK3Qul/rtRdv5E3EIBKugnWN36Q18=; b=fYuB746BXr12EoTWJ9K+G2gxv4
	KnHS99v0utImVymaDJhbUtvMLwrOX677XBPsiuPCY3d1P1tDpRY5dcQV0S+exZaBNbEf4/Vpn9CFI
	+2D1LaYY28q+1cKDgT/wRzk7rU7H4QUYLfNIkxVGUvd7u33sSxMjgRwvaiBFCQWAyoPEJ3NpZh+C8
	6z4g/5NpSHnU1lNN8VdPNnRfLClsI4BYG53eokWf3q0FHe5nibvDQb4Y97G4d/fIUxwayWL2/JqLZ
	R3GZpE7ebmt5BWQzwnhh3V25urW8V8WZwwpJtswhWKR6QTGtuxHA58BNwnwIqlCMNLOai/y6xByAP
	wZ3MKvcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1px6q8-008x6z-1c;
	Thu, 11 May 2023 14:00:16 +0000
Received: from mail-mw2nam10on2061e.outbound.protection.outlook.com ([2a01:111:f400:7e89::61e] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1px6q6-008x6H-19
	for linux-nvme@lists.infradead.org;
	Thu, 11 May 2023 14:00:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NxWGHLXU0sTEzpJi7BoebyKoD5psJlj3Ws+wQMFkX7/75dV9dkbhpVol/Ftjpw0blr7tjjLWZEbzXaPL7RwWapHfdWRdoSaTPiNtaRwBk/RDRAL03bCaVy4lJ1bjPK/1GZNoO27ge48s2A+3LwCQhZALe4hzqfjegmwEKiWEivQ8TGmezZKyKLqyCccw2PZKr6ACFnwHu8zlZfe5tYN7FAA9O6cZAgalZQlj3fZuWoFnmoy+w9wecl0DqmtnqaCSY5Ivc0nCiVQSDwqUhyFmOExMxU5hR+zUUFmx2KUZkPgy1MUdTTQS7t/OlRnKrycrMb+xLIXoYfsg7qDn0lgT6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HqhcrVGe0g+TaBeK3Qul/rtRdv5E3EIBKugnWN36Q18=;
 b=i1MMSIijS+KAxc19p1eritTg8I/DJksAZ6Vnsg9yXokXAu/HR9o1w8zhRDGTvol0rX1OUKMdBc2mdes+6FFS2hrIbCiH+RqVYvlLUR8vrogtsrVW+xP+bdkj4meEQDS9V2Q+hF1UZHcTUvlQBISwnmFspYlksmoGk5RyaP3/Kqh+UrWJ1KdpEXSzs6gu6P+12dIr2llnrtxUnbFwoGp+Rro0V4p3wnxLPjeZASFtmP6tpbpQ2xSoYL/YXJBl68bdIx5jig+52mO4paijArNl03Q/WU6B5XpvUQUp5owTfkGIrtDxiYa6WpvauYiUyDPoZWSC8oRi3xApiSCVuzY1VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HqhcrVGe0g+TaBeK3Qul/rtRdv5E3EIBKugnWN36Q18=;
 b=A1gXy8EjoHnkORGqUTUPPP7/GfquqY3TMeeJQDXmL3hsXpDpqziUqyRyIX4eHw8d7++8hkcHl53UWITDu34O5r7O/wq0Fr/nM/C6B9pUky1HFQG/YZ7GMdsLScKwTwMLH4j7euXIMS5oyWdgB1kTf2YIYUFq5etWgDErXpRAGrxcZ2VlSHVRuUtwB41x8S/+JUjmLmo0el9oBzXBHEWHi7c+ZCss7tFEHpg3flp2jTx3o5vIE1dCNkvseU1OReDD8Ee5UMMQt8J0sX/YPDqXECFG1z4UxSg89oou+AvGe/JDgKilXZDLM3jiuCm/UoSpQVDSO3S3J4wAnp7cf03Cdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by PH0PR12MB7813.namprd12.prod.outlook.com (2603:10b6:510:286::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Thu, 11 May
 2023 13:59:44 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::61c3:1cd:90b6:c307]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::61c3:1cd:90b6:c307%4]) with mapi id 15.20.6387.021; Thu, 11 May 2023
 13:59:44 +0000
Message-ID: <33db06d5-36fc-77bb-1f0c-adb61fc77767@nvidia.com>
Date: Thu, 11 May 2023 16:59:36 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 3/3] nvme-fabrics: prevent overriding of existing host
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: sagi@grimberg.me, kbusch@kernel.org, linux-nvme@lists.infradead.org,
 hare@suse.de, axboe@kernel.dk, oren@nvidia.com, ngottlieb@nvidia.com,
 israelr@nvidia.com
References: <20230510180231.18865-1-mgurtovoy@nvidia.com>
 <20230510180231.18865-4-mgurtovoy@nvidia.com> <20230511131625.GC29790@lst.de>
 <97e4f76b-0c11-1f68-c4e1-0984ed04ac8f@nvidia.com>
 <20230511134959.GA786@lst.de>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20230511134959.GA786@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0546.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::17) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|PH0PR12MB7813:EE_
X-MS-Office365-Filtering-Correlation-Id: a39df2a8-c176-4794-86f4-08db5227f8f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	wrF2il8vrPFwe1VAPOvuCL4UtRAeSZkB85VYgrYbCIQmdizLifuEuJvo3LKlcyIzrqOpcHFC5ex3+nYfCFckrRGAAGWomVRAsN9eBmUFKU2ZxARkWZs3JAyHU/HSXh7Q91FjVyecg4L3gf9SVEGi6sB3dN8930L1OyAKPRE47bouv60Gon0T9iU8QVRHehl4BOWcIR61SyzBVA1PiseWRot8IiTNFERx6KJI2oN1qcrKIA4mR+eLCKlu7X8sHdZF1ILz6/lgl+VlyloYGGMsKJrTf+US8n4YHD9utoVgJKagt++RZVbV1b2RSE+FCS8M44lkIkL8a+whHRnKKGfSaPiUHngEwO7vMLhYnV6yteMMiavgER4K8uV+dRxh8xalkd6Dxg8a8rnc5ynrU1Mb0s0IWBuZmWOrI5TEMKMu5jxR47i/6zrfclenb1a0d2+JTsjAAeKjo3dpwrzK9QAxDs06ycJASFb3OwJzxVZglx0y6/tecMX8fXSpwKM2Hh73lGgYyROXlI7ZJY/rAMFbnf0QfSlE/NTh5SrLUtnmJ7GrIq9lI2J2HUOjSGqNnTiNk1vBKGGZNepV761hWgYyDS/idyt0a2drXp/7w1XtTsiiAXHp0ByYNXUe1ot3xTfgSaCjAhpRdccrDw3TSZX8UQ==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(136003)(366004)(346002)(396003)(451199021)(316002)(6916009)(478600001)(31686004)(86362001)(6486002)(6666004)(31696002)(4326008)(66946007)(66476007)(66556008)(2616005)(36756003)(8676002)(41300700001)(8936002)(38100700002)(4744005)(26005)(186003)(2906002)(6512007)(6506007)(5660300002)(107886003)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?UHgwYUt3bURiTERnSGsrRWZuKyt5NzhCOUVtRmdMSXh5QVZpNDFSZy9qT2tX?=
 =?utf-8?B?UlkwanNGY3FEZm40REh2aWpoUmJ6RkdVNjRPWmwxbXR4Yzlyd2FCN0tKcVli?=
 =?utf-8?B?MS92TkJsTmNlNkVuTmRVNWpYbVdRdWRWbXloZUoyUCt5YkI3V3ZHWlgvNVZZ?=
 =?utf-8?B?YkNQMExCcU8zSHlMUDE2bVFzN3B5eE1hUUdhaDhza1FzZExZSk44LzVrWHdN?=
 =?utf-8?B?MmJlWjBlaW5SOHE4OUN2d0I4MEd2SEpZRWEwOVZFUUkrMURLcEUxRDV0Y1hB?=
 =?utf-8?B?RmZUWFV2SUdQQTl3Y1lsOWNGRFdFcDV6bzlwNHZpU0RBRVpxNXdaZVVpZ1Ev?=
 =?utf-8?B?MlZPN01aTnNFVnlJQ3lBQzNzZlJVcUVHRW53Lytzby9SZnNMT3NTUEpwNzdO?=
 =?utf-8?B?eXhndHFZc0F1RTRsb1I4KzZxNWhmaGV5NnZCUDExNWlJd04rc2lhcEFLY3NC?=
 =?utf-8?B?L0ptdUh3cHl4MkJlZGtENjhkb003UEFwVGdaeGpLL1lDemdWaFhLMmpHeStG?=
 =?utf-8?B?WTlTazg4WTV1UmFPV1ZLY0E0MDF0MUNaNkxEQUdIa2tQcmF5aFE1SjB2a3Nz?=
 =?utf-8?B?TlA1cG5Hb3pLUkE4d0pyTXhFMmxIaDNIU3NaN3gweFc2elBvL0pUOFlWRTBG?=
 =?utf-8?B?L2VxTU8yL0lVaDVEUC8xUjgwZ1NxcStUVDJZVFh2eHdtQkxqWFVxMXJTSGx4?=
 =?utf-8?B?ZU1WMlJGNWJ4WlVvNEpsZGkxcTRYSEJSTHl4akFuU1IwNTYwbVh1bEFDU0Z2?=
 =?utf-8?B?dXdTVXlPVmZDTzdMK0lQdVFkamtwSldxTXZYci9La3dUZTZsNDNvbllFNHFF?=
 =?utf-8?B?WUlnWG0yMFRHVmdRWXVTQzFhdkovam53bmpBTXoxVkR0UnpiYkZpby8zMVEz?=
 =?utf-8?B?alZYa0JNc1RiRTRBTGs2Umk0SFJ0UVIzaHlLUHBNV1pDbU9UdzBNcHgxQ2Rs?=
 =?utf-8?B?NlAxNml4SmpsVDFCbTVXR2JNaHZjNjBJbXN3eG9KTmllRkRCL0U4T1pVVnJj?=
 =?utf-8?B?dDBtSG5rSVhIdk9uSlJEdEFyTkhvYWRuSlRJNVduQUJjZ2pwa25qa21LSkNL?=
 =?utf-8?B?VlphR0pnV0dhQ2QrMFV4Tm1OajFSYTRjYmxjcmh3aHNmcXRnVFZSRGZrbnJj?=
 =?utf-8?B?NDlicDdIZkR2OTBCMlpjemhJdm1XcmpSaXM0M3FiMzc4T24yaHE3dmkxZ1Fh?=
 =?utf-8?B?UnVpbEUrUUthbFVnQW9iMHJGdFZqTDRmdmZrZDBsMlJvWmRlSytqMXVrTDFx?=
 =?utf-8?B?ZExMOTB2Uk1LOHlZL0x3Zk1FVU1sUkNFZ29OOUl5RzhvN29BRVBLeG40Y0Y5?=
 =?utf-8?B?ZTVQNUtSK1M5Rkl1dm1qanRwMnBtV2NoUTZoRUYvdmZQYjFVYnI3OXg5QTlI?=
 =?utf-8?B?aEgwenB0SUFDL1JVeEtGaHZDZjU0M2NiZjFOcXZSdDZTRFVnU0xzemNJbTl0?=
 =?utf-8?B?b2VFbmxvcjRsUTVDbUp1eUZvNkZSTU9sLzBla0t1dWZtdXV4QURPZUZiYldC?=
 =?utf-8?B?WEkwUzhXaUNEaU9JR3RUTmFRYURSNkhZbWp2aEN0U0YwL3ppSmdIN1RRZXk4?=
 =?utf-8?B?SGp3VTVIMndYM1dORVJManMzYmJXcmxMbTBacW1NZ1AycHpJL0wxTzRQY0lx?=
 =?utf-8?B?WWpKZUxWSmFpS2JvZmRTa3o2aHVaaFFTbXd4TFNKUURHNFArTXJqUlp1WXF4?=
 =?utf-8?B?SmxveVBHZEJQaFJlT0I3bGs0VkZuWjBheVFLWWFmV1RIT2RDdlRqQTFaQUpX?=
 =?utf-8?B?VlpZVDh0TGxaK3lONXdEMGJ5c0lTMHYrbjQ1ZmFQVnhnSVRsQ3gzNVNtSk9C?=
 =?utf-8?B?MnEyUmxPNUNnNXk0M3VkU3poS0g5Sll1M2dmZkhkaDcvcllWRFAxbzAzQmZH?=
 =?utf-8?B?TnBZVDdKOEk5V0syblFmWGttUVgwTWRKc1hkZ0ZwUlpFK21vTFZEL29rKzB0?=
 =?utf-8?B?QTExVGg2Vlp2R1FkZ1hiTDg3U2QzOFJLdjFRZ2pZMWc2OWZ5RXlaVUJYb3NI?=
 =?utf-8?B?RFRpblhDbnJQbHhzcG4yU28yR211d21iSkRnNlcwZUR5dWY4UjlsQ2tLN2ds?=
 =?utf-8?B?NHVUVnRBdWsweWZPTVpsdC9WVUxWSW4xdHlFZDRWZGx6V3hMNGpwUDVmZTdY?=
 =?utf-8?Q?YC/xgA3q0UyhrvK3bRCQqIpfy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a39df2a8-c176-4794-86f4-08db5227f8f7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 13:59:43.9756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q/DKIvm16Xy4G9dYcRBkCn+xOlQRYF0tQoAQL/WF69CgEg5Eu2l1UdVF88sT5p5p4W05clqgHrOdst50+IF/aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7813
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230511_070014_400159_789218A2 
X-CRM114-Status: UNSURE (   8.73  )
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



On 11/05/2023 16:49, Christoph Hellwig wrote:
> On Thu, May 11, 2023 at 04:26:55PM +0300, Max Gurtovoy wrote:
>> I first though this way too but the specification allows an NQN to have
>> logical partitions marked as hostIds:
>>
>> NVMe over fabrics spec 1.1a section 3.3 (p 27):
> 
> This is simply broken and we must no support it.

I see.
So I'll re-spin it with 1:1 mapping between hostnqn and hostid. This 
means we won't allow any nqn to have multiple ids and vice versa.

