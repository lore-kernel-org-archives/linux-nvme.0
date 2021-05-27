Return-Path: <SRS0=/NUg=KW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C5BC4708D
	for <linux-nvme@archiver.kernel.org>; Thu, 27 May 2021 15:13:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F356260724
	for <linux-nvme@archiver.kernel.org>; Thu, 27 May 2021 15:13:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F356260724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lshKEQfMHx26DWKv1FdPwTeE55L5QeLUvfy/uQejlA8=; b=rqvWNi/brxMk7d69IniAgwPpVi
	6olCT2WhF7s6WqAnfvF5pkXygKyXL/JaBBpSYQyjqig8t5q4/0VU8SNFGMBBL0HSrUAQH3d0iHJCP
	CxYUjqbIUZl1jiL66Qgf2/2doCXcAoGlkY6Eu7JLQWW+8dipj1gcWoEnOokHkUoXDWme3zH4ES0c8
	RKPWzJvw8unx/ag1g4+gCMDV1BIdw9QlR6EjUgbPWf8eCeWvgpQxM+vb9baK+wp1MmClCkqJY7u2L
	H0LCgzKASBJUEKxCN0C0O+hOklByOCnw2MDISEFY2OC8LFbl2lfn8mAe8tQSebL14lM73pfan9BTS
	YQoSdr3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lmHgm-0075wJ-6o; Thu, 27 May 2021 15:12:50 +0000
Received: from mail-dm3nam07on2087.outbound.protection.outlook.com
 ([40.107.95.87] helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lmHFh-006t7n-DB
 for linux-nvme@lists.infradead.org; Thu, 27 May 2021 14:44:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=caljr3qAicXsZB/QJR02cz4aTt5qBQ3eKEkZQ1UXA9LlVsID/OlUmwIbcZGcwXaVkFYTWg3sCD19L36wHnkJYiJrA38VG9BeEqaBiL/Gwc/LwFUk5gWz6ssOt/QSQdPCWDIVaDL6tCxQHOn8ofgnNZgYZaRMYtu0HPQI5etZIdft/uaY9nULQIjMnoskl7UPEUMaqb7oVGq7pgEMp7lVnf+7Ddt3fc6OH3qf53//f6iJF/F3BDYUDf64U1k1jxM4KV5OeXHpINkoUb8RnpMe0MXXw+3qyI4GUz/7JfKoWcoiszncCHvHATqbIxo7h+rKseULHJAM5yBnzlorcbF6KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2ZPlxpN3saaAzQxOz+0/2VBBTyQ+XOWkRoBkqvoTqk=;
 b=T951g9SkUNkFl68j/KlkD4P1IPSX/mEyFXlcmWGHkIdLC+Qq/N5IN7QxkkCh6iPRff2rlkjIzDxzd2Z+jHW8WEYE1s3yzo+CbQnvTnu2sz/XDWKPBCinu7sbEn50kUYEf0Y0ONEn40rKkw42yeP1YM/ePu6BWwkshu7Sko7Onc2417+60hi1rnoBic+EmTrRFrwGNU1A2igQi4WH+xRH57ChYJeT8GhMEoDB2QRbZ2cDomvItTsUT7tfVRkakdILtnDuZZXrsx5X6g35rAsrB3MfRqAygN8u9hkNqWi0NnenTsFdPMHlSEdOf7fu/31wKWDZpHa2tDccVMMygHqeIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2ZPlxpN3saaAzQxOz+0/2VBBTyQ+XOWkRoBkqvoTqk=;
 b=VTRBmTwcPRpuZWudA3+BONm+ID2nb9NsFQ/+3WYqTUcIbWyjfl3iGE5MzVQDo2vSGGcPRHuIUoAe+j7qJH/0KxB5a3UymRkpEnCjfkEYWJsSXAJROKc19X92UTyYyqYleVNvMvFBfPwWzcKjydHOWGpJT0LRTv9qsvVIhxKCW8Y=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2693.namprd12.prod.outlook.com (2603:10b6:a03:6a::33)
 by BY5PR12MB4114.namprd12.prod.outlook.com (2603:10b6:a03:20c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Thu, 27 May
 2021 14:44:45 +0000
Received: from BYAPR12MB2693.namprd12.prod.outlook.com
 ([fe80::c0c3:7247:a767:f5b6]) by BYAPR12MB2693.namprd12.prod.outlook.com
 ([fe80::c0c3:7247:a767:f5b6%3]) with mapi id 15.20.4150.026; Thu, 27 May 2021
 14:44:45 +0000
Subject: Re: [PATCH v2] nvme: Look for StorageD3Enable on companion ACPI
 device instead
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Sagi Grimberg <sagi@grimberg.me>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 Prike Liang <Prike.Liang@amd.com>, rrangel@chromium.org,
 david.e.box@linux.intel.com, Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>,
 Alexander Deucher <Alexander.Deucher@amd.com>, bhelgaas@google.com
References: <20210527135941.7634-1-mario.limonciello@amd.com>
 <20210527143548.GA32170@lst.de>
From: "Limonciello, Mario" <mario.limonciello@amd.com>
Message-ID: <c911ed05-071f-ddcd-7f76-9cb7535dd01b@amd.com>
Date: Thu, 27 May 2021 09:44:41 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
In-Reply-To: <20210527143548.GA32170@lst.de>
Content-Language: en-US
X-Originating-IP: [165.204.77.11]
X-ClientProxiedBy: SN1PR12CA0087.namprd12.prod.outlook.com
 (2603:10b6:802:21::22) To BYAPR12MB2693.namprd12.prod.outlook.com
 (2603:10b6:a03:6a::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.254.51.208] (165.204.77.11) by
 SN1PR12CA0087.namprd12.prod.outlook.com (2603:10b6:802:21::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.20 via Frontend Transport; Thu, 27 May 2021 14:44:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10eb8628-4079-4c21-52b1-08d9211df811
X-MS-TrafficTypeDiagnostic: BY5PR12MB4114:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB4114C646E6A9EDCF2E9D79CAE2239@BY5PR12MB4114.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7L7CB78edCvy7HdcEBZ6HS1WFLXNwbngVWhRlr5bxl6tQUdGu6Dwl+eC9bw6EnTORD4/q2CXdbilhf8cRkFTh+sQ9PkOtyN9y4hvlwbFgyoGAMljPfKzLIsQTxDEF9Cd31eRUeY75s9cymk3JUYuwg9qxuSPclfnZA+WjamHRhasy/BoZ2UT2tcEfBOuL9dLEMOJynvTRtdNo7iAslKxAJ79BpRTNc6WqsAj1oJCIhn/kAL0Ar+mS//TZQvH0ZAACwQbM9QhC+4Lh1xssHLPFWMaNtY4nQqBcgaIqvcfnOBXudNg+pJwqBB4mXZ/awuxP5Lc0liGv3C13M88YWKqDruThJQqh8HVd88Ez3jZxloUnSKsbnx8TEIKoYOTWIWWFM50m2wfwfkwpC5srxIGUvJDBFT86G+VwApEqyP2jIQ4mbvK++UrmnWLza1vnenllz7YDamnqf2hhBiNi9cl8GX2waxUiJ5T5hcJKT7Qlh5em1i42CoBDrK6b74um6UAPHmESxXxgSk3VYErkw0CxOeO2h+3grJ/vwK9dOKwKJYgQqMQsmRZ3/HqVS7Kf9ke1yc1EKOPvjpZEigbFMd+BsWDzyzgdrTm0qGZTCDZrX4ZDo83K7dVhRae1ANGlqeOTZF/Ch4dgA/dv6Sine74fnhlo0zcImH2zK7RaRjWCid+3wE2CJD5mlBWirpXmksIVFliCnog2gV4r6Dgi6fmxGJ19rG85jjMagt9Mt9gqwcADlL/8sNz9Zji6mvgpiEklLUWJ5DHsCm/DE+0adb1IfJB5DcbPAt5ZxEReKXRdN+1wPYY3o8VE6hDGhcoOCzo+V25XiBeO8MWMF5qwgSGW8cf9x2F1n/IkJOK1IWnvII=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2693.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(366004)(39860400002)(136003)(346002)(45080400002)(16576012)(956004)(66946007)(66476007)(2616005)(54906003)(316002)(966005)(66556008)(186003)(478600001)(2906002)(4326008)(8936002)(6486002)(26005)(53546011)(36756003)(16526019)(5660300002)(31686004)(86362001)(52116002)(38350700002)(31696002)(4744005)(38100700002)(8676002)(6916009)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UHIxeFcvL1Z4MVV0ME1aV3ZMd3pvN3RaUTgybjhERndsYUtBeGZiUjk4UDYx?=
 =?utf-8?B?aC9hRGxFQ3JDK2RRTGlHcFAzRTdlWXFydzEzZ3NyN291aGpHN2JxUWc5TmUw?=
 =?utf-8?B?VG5ORlpCZ29PcUtxZ2hPVnRlaGF4N05BZnJVckdzeVVrRTV1RW9wKy9SNnFZ?=
 =?utf-8?B?SktxRTNVSS9lWERMbzE3VlpqRFVlNHkvSnNOLzVHY2U1WG9tRnh6blBhaC9S?=
 =?utf-8?B?WUZGNytMWlZZMUdPcVp2RDJCdHhPcDY4NUNzOXJYQTBaTE9pMjdNMlE3Vy9R?=
 =?utf-8?B?T1ZuZEdjNTZOVzRWeW9mTmlxZU1BRjMvMkZoM3pZcFZhNHU1RW9GckZnb043?=
 =?utf-8?B?RWFBT0JzNk8xYkVEVVRzS0lwUXpwMzdaQ0l5YUU1RWhDU2RXbGN1UHd5akhX?=
 =?utf-8?B?T2RFa01SU2xJUlhvU1duRmZyTnJCN3BCMlJJR01IL2V3SHVucWZMbHVPNDJ5?=
 =?utf-8?B?Z2d2MUQxclh3R1g0K3VHSEptNVl0TGw0clNwd2s0c1UreFpkblpadE1WNnhw?=
 =?utf-8?B?aGtsNGlNMlRlSGlwejFhWDgxaml5QVRlQjA2Rmw3SXMxSFVHZ3lrOVM0dTlU?=
 =?utf-8?B?Unk4VVVDMi83WlZtaEZxdXJ4L1JtcGh5ek5LMFliaEdwNXlUY3dqQ1BUbldp?=
 =?utf-8?B?NkMyVEs4NjQ3bkhmZjNiSXIvVXZ6alpLZkVRODlDajk4M2JtOXJtWE5lTWsy?=
 =?utf-8?B?MXpDQnBSVisrRkZ1TDlHRlVMR2Q2NVc0TzAwWkZHbTJlVE4xZW5LN0FBelhW?=
 =?utf-8?B?UGx0OGdzMDVkZyt5M251VHFGNmNQMkp0T1JVNGxDanFLRTRNSlBBQ3FkUS9K?=
 =?utf-8?B?eGs2bWhGcDZ2OExZZHBuYjdJaU8zbjd6bEtBR3RmL0Y3b3V6ZWkveUp5Y09N?=
 =?utf-8?B?NGV6SVU2Y3U0dExKL2MwZURPMzQ2RWJLOEp1VnJtVmdDbWFhWXFnbUszanZp?=
 =?utf-8?B?VmVJZHlOVUlveXBrMkM2QW9LL3lmSER1UmRIT0Q0dVptVTkyS0tMa0hXK0pQ?=
 =?utf-8?B?Z2FzYWtzbTlIVndEcE9tTDNHWWdaL2I3T1FlSHVTaWliZEh4NnBuWWVWMG9a?=
 =?utf-8?B?SmgySk5GVXFpWDY5T0p2dHk1Wi9valR2eXRGK0w3a2JqV0IxM1VvdFRSMzZz?=
 =?utf-8?B?VTBieUlyMHYxSEpKNE5LMW1ab2tYaWFyL1FqZSs3SzJKcHczeTdQYitsWU9Z?=
 =?utf-8?B?RWs0KythK2JOUVUzWkpMWnJBTWFycjRTbVJmWXRlVWIreGhDRit3V0hROVRr?=
 =?utf-8?B?clRIOXovbG93d2ZldXpLY1RCblloWmMwekJJbkJiWFZ6ajZiVWVKUVpXS2pk?=
 =?utf-8?B?OUpYZXB0Y2p6bHdOdmFIc0MxNlB2djNyNkpxYXBmSW03OEtIYmk4MDVYMUVP?=
 =?utf-8?B?L1VpaExEU3FaaHdsNndzSngvK0V5RjFrSHcrb1dIU0RnVFhVWjNGV0UrV1Jn?=
 =?utf-8?B?UFJoYzNrRkF0UW1hdlVvcFRzUm5VcW56ZWtBUVNHN1YvaHFGcGcycDZCSVRl?=
 =?utf-8?B?L1NWaGdpOXdxSUwrRi9MTTZsU2RMb0c4bk5kTGttWDNTOHJQSXVKVlNwaTAz?=
 =?utf-8?B?Y3lnaWhZZzh0dU41TTZPWmpCemNubGdYNXFlMUtvWW5tMzMwMTNVTzJ1STA2?=
 =?utf-8?B?bW1NQXc4UzdXVXFMajFoaE5uM2ZORWFJYStrM0RPbDhQaEkwWEdJek9rbHlN?=
 =?utf-8?B?dktkekRzdVNRVy9ESjdKc2JQbWVzVzBnR1lxUUJRd1c5VVU2MWs4YldPM21Z?=
 =?utf-8?Q?kMsTxgBUch3/veUdyP72vCU1T+DKa2v89qWQtge?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10eb8628-4079-4c21-52b1-08d9211df811
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2693.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2021 14:44:45.0927 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Hq7BY7+YLwFAlLDVk2ZYFyYAsk7ix3ISXp3XeCXvkXTVu6JHZkP7tcl/psAJzXvaFYGjeHLHrmiSdx2+KKmhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4114
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210527_074449_507017_1DF8CA34 
X-CRM114-Status: GOOD (  14.30  )
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

On 5/27/2021 09:35, Christoph Hellwig wrote:
> Adding Raul who has been asking for something like this as well.
> 

I thought I already included him on CC.  Sorry if I munged the email or 
something.

> I'd also really like to move nvme_acpi_storage_d3 out of the NVMe
> driver.  The Microsoft document that the original document references
> makes it very clear that this is not NVMe specific, but also covers
> at least AHCI.  On top of that the platform simply can't know what kind
> of PCIe device is in any given slot.  Last but not least this will also
> allow us to add quirks for devices that fail to properly mark this
> misfeature in the ACPI tables.
> 

+Bjorn

Back when this feature was first submitted, that was actually the 
initial way that it was done, but Bjorn had preferred to see it move
into the NVME driver directly:

https://lore.kernel.org/linux-nvme/20200625173053.GA2694537@bjorn-Precision-5520/

Bjorn, are you OK with this coming "back" to PCI based on Christoph's
comments?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
