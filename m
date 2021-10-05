Return-Path: <SRS0=bdbJ=OZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771C7C433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Oct 2021 03:39:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 077016138B
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Oct 2021 03:39:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 077016138B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4EhALzf90/jLgLRQOM5ISb831d7h71G9hZ6E4t4LDLE=; b=zAN5M7IGZ1PoZA
	ojhXfjSoZ9kTWC1Tl6oOFTlkQy6cTdiXb/6U2j93pvFga6jswHNq4K5biUhLPQMTtBgENCRD+quHu
	85ZlUY8BZYxGYhQZjcZE+ecdZNgvUt1dzC8IozCOlnQrySQZr2beImn/z52O8ykVx7TMYEx1a6zhv
	wN6fKY4m+MA5/JIBGglR5oRFMvFkneUMmKBoB8YbqJMt4bTSEQ1Vnpl52mgIiDGbCdakDh+rQZORK
	CjR2NTrSuy0CzVU6cvYQ9NIoI3Re6S0dgILssaidR8WXMne0+YD8qUop/fuc9Z7gPtLTgZjgu2dHX
	UwGkn44KXwrP+IR2dp6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mXbHe-008nw7-HE; Tue, 05 Oct 2021 03:38:26 +0000
Received: from mail-bn8nam12on2041.outbound.protection.outlook.com
 ([40.107.237.41] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mXbHb-008nvB-Tp
 for linux-nvme@lists.infradead.org; Tue, 05 Oct 2021 03:38:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NvmTs14nl7d1IKJMfk8TmYxJHd/L7rWQVnPBdNMYqVZ95fgPH+4/6mR7lRHR2FSRHqmMdyWHuPPyh84UnOl5yIi0w7SQDiZp6EEGCsbJArzticfbbDdMWoz2kRtXsF/EYw5zch7yGGlDH92ffJVZS2AvaIbXHGZbMpilHRfJL7Gs9yNg6Io4QswuQU4xHv89ly+DlMvjym7KLvyry1r8iPRPcpaY1eHevpfnyiiooZ0Nt34sAfuCV0VN4y80cgJAsh9JBgqL/QkKgeir/WtIIWs6wnUn5s9xOgmfy0V7EepnuWvXvZIGc+4BEL0scEDFj2VgGOnlHWqWAXx58JH2qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/LWTdjbtuGHcGEwjeKSMtfXP+fJdyL1QAwPLQoN/08=;
 b=kmizn1ymXQV+IMnIA7Bo5qQH5/YQ+eOcQ+3Dt1med5UnmQhBEqSUJ368YjQ52FEqLcaI7ergNayJqhL12RcfZkDhne5eUDxyQWbyVDdUL+SISf5dYSFlfjoF6I9BqPaLq+4EoYi/qf33vJ2no9ILaAkB+OlMNrVPVQD8co/9iAYLQzNYo13pN3BrThp21wwahbtmf6QjwlOJwybNQl8pj7evLnAxmwwdxTOlUPkOAdA9PaZXRtyzsRd68x9Fe4zvKvH+gqWikF2A01Su8wMuzYh7W5BER7kIl5cYTAC0nD1VugB88HoDNxkBk51nogFx4x0OrskWYbzzFx2diWFeMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/LWTdjbtuGHcGEwjeKSMtfXP+fJdyL1QAwPLQoN/08=;
 b=Frd0s2EpYtY4WoXc/KYcbDBRy0TjWreyA1KlowMZGmnIwo68SVg6aIaE7bWFkzFL6pbqAjW8ns5b9MW15KdigOdOZOkrV6rEmkk0a1pEfZkKbEgODWxC0vn/BLAdxRKXo1W1VcFCuyoe9E+HRgrIGf6kQMK8mJiaL5XKeeuTeIh4164mOXF4qtbEDIeszCLVhEfVPvwoAshoOqZYzngl48qdsYzIm4ATQ1YmSwUksH9rQ7UyelxyrNut/XeAYZ3xJ8uMN72Ji8GJ/YZxKOLq8xbLhPYyAitT9TjGVh/QkWrSyz0KMqEw4lbQAy26FaBJOdgw4n30OwN+N8RzLI9IxQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1726.namprd12.prod.outlook.com (2603:10b6:300:110::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.13; Tue, 5 Oct
 2021 03:38:18 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524%7]) with mapi id 15.20.4566.022; Tue, 5 Oct 2021
 03:38:18 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Ming Lei <ming.lei@redhat.com>
CC: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Sagi
 Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH V2 1/5] nvme: add APIs for stopping/starting admin queue
Thread-Topic: [PATCH V2 1/5] nvme: add APIs for stopping/starting admin queue
Thread-Index: AQHXtfqjo6XrkhaLxkCH4OgsGNpS36u9phOAgAYN3QCAABT4gA==
Date: Tue, 5 Oct 2021 03:38:18 +0000
Message-ID: <79efb733-4904-d27f-b336-d5d97d3ca261@nvidia.com>
References: <20210930125621.1161726-1-ming.lei@redhat.com>
 <20210930125621.1161726-2-ming.lei@redhat.com>
 <95d25bd6-f632-67cc-657e-5158c6412256@nvidia.com> <YVu3EjPqT8VME/oY@T590>
In-Reply-To: <YVu3EjPqT8VME/oY@T590>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6f092334-a013-4fbf-209a-08d987b1922a
x-ms-traffictypediagnostic: MWHPR12MB1726:
x-microsoft-antispam-prvs: <MWHPR12MB1726063C9F666DDBFE07C41BA3AF9@MWHPR12MB1726.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ECprFV25M5l5ZznUtyAFiZWmdnKL3oZkCjvNVsAK/uyYpsXzDSBum92MRBEk7qZHzTSS+Kj2dd9hYEDmkwglA7C4gPL/gRpVG58BZIzAOv5A76tBVloFlquIeXv3rNlBtHCBs0qIdKRuyqAjxYpMro+uTwJcIPyZchcA6HEn3mr3kVhOqFLPkceviWv4I1Z3fJTu2h1wk8x0pk5anpTMxx+vJIJWU/OeCdtu44uHsFvNrN6M7ogfglCy56AdX7f5qcbCPRp6HpvPb7FTQslJJYHiWxLMRD86s4Smgv1WSn05ZY3tJj46eE8R+ywy8H86fb/jGWJcJtW3WE3sKC+6JUlEzp3OhWQM9SwqmpdBlyDu3dKoZD0X17MqgS/eRj/UVoatzEqRPkqrKJrdNkrYGjeDgyPwpExYxG+N8zu4hDEiWAvX1hralAd1hsUiaJPfaGrlWRv2ZEugFRRW8TXJS8Yvfnh7aozlxkZiPxD1qbw51t4sPLYWKRb14sZr/mVqBXTbcL+iKXd8edMUCQEZPs07jNKpLR8ISmu7dhYj86a3pPa3gSOw4iSSXmKc9r17CUs/AtYPk3ULfhadtLA0JZ2iwG2iJ20wHn7dGdYel3Ox4XDVi7GcoDuAkGkOOzyrCiPHFq0Gp7OhBP3a880hrqcvRxVKU84KEcn8sZ4l9ig/oZ3XhntaNJfPZ8Uw+eQRs+pDwVG1ssHraG7rr0gWEfTfJDOkP4bYPUdeZ/+rxiVV1lBcggwlH9cA/90qcKT5p8P9KtDWJqMQwi1TK2/wWw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(83380400001)(6916009)(66946007)(91956017)(66446008)(186003)(8936002)(76116006)(4326008)(508600001)(66476007)(66556008)(2906002)(36756003)(6512007)(2616005)(64756008)(31696002)(8676002)(38100700002)(31686004)(71200400001)(86362001)(54906003)(5660300002)(53546011)(316002)(38070700005)(122000001)(6486002)(6506007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eHlPdW9oV3ZIeGdYNVZ1N1p2bjRTVitSWTh2MFN2aW1lbG8xQUFiK1B5Mm5j?=
 =?utf-8?B?azNEVzJuSEx4L1M0Z1IveVFBZlJxTjArcWpneG01TGh2MU5jeERUZWVrcVNq?=
 =?utf-8?B?UndsTzFRMTVrdjQyV0tjMUM2ZEwrK0VHTE9UcWVJOWpaNUNSYUUrMzk2ZkxI?=
 =?utf-8?B?TEdjU3FIUnFJekppTEM0Y2NiVE9GVGFxM1V6bWFENm5NMWkyUUpaN0xicjIz?=
 =?utf-8?B?VVNJQkwwa21IcjUrVGJaWkxnSndqSUpWSTMrSUhENE9qSHZNYjQ0bE5rK0M2?=
 =?utf-8?B?SVpsWW9zbksvVjJRaVhHQmY5QnZhdnNPb3hldmRDR1U1ZVdZckRKM01ONHVh?=
 =?utf-8?B?aTdZWkRFUVV0dFZTWlVvUmNlaHRzcFBJNWlxYzdveDNtWldnOU9Hd3BLQkhO?=
 =?utf-8?B?b0RVd1FUMXozVHZaZzR3Qk15b0R3MU9NTjBWUkkvSlMrUS93eVNvL0h4c3RM?=
 =?utf-8?B?VFN4ZVM4MmpTUFhodXp1S09BZlc0LzZEYnUvU3FVR3A4aHhndndTYWtjUnU0?=
 =?utf-8?B?RzUxRCtsL2JtNENjRFpuWExwWWg0T1VUYjVxRUUxemJMZWJKazg0dWY1Yll4?=
 =?utf-8?B?aDcvU3lXTWVKREh0bXFSL3c5aDZ6SlBGa3M0SmR2YmUwSkdsSkExSE9FYTBo?=
 =?utf-8?B?ZkhvZit5em9wRzJhWEZDTUZFTTh4Nk55UFUxa1JQVlE0OEcyR1hOcysxS0VT?=
 =?utf-8?B?Tm5tTkNzckgvMmhqVXgvZFpNSitzc2pNOVErVWRsNnlDb1pLZUdmc3ZYRUQ1?=
 =?utf-8?B?UVA0alhDeDZRM3RtOU16MFQzcXFBWWNWdi9wc2RjRFVSMmhiSWpQN2ZMcTRj?=
 =?utf-8?B?djNKalQzeGs0cXpiTS9oWU5sK2FvN0dZdGx2K3ZqLzZwZGxTa2UwdXo1ZWVy?=
 =?utf-8?B?QUxDOTFLQnptY1hFMVp5ZmkrNlBldGVBWTFDaUNZMzBoNElRUHZtTnd6RjMx?=
 =?utf-8?B?V3VmTnRYMnVnMzRSOXZxSHVKWVBPMUJUWm5HOVNPWk4vWWx3VXZvL0V1NHZq?=
 =?utf-8?B?akJZL3grSCtVZGNUdTZsU1JNV0lOY1N3ZlBPRUVKN0FjcFhtbVN6MkllN2Jm?=
 =?utf-8?B?TGxmS296M2c5SFhaNWdWaitxWDV3TW1OaW9jcGNuLzBDNDhvbGJ6dEdZNHkz?=
 =?utf-8?B?T1pRczF1ckljdFZ3VDZXQmlEUlNsQkJxWkpnZmtLM2VVWW1xd1l3UjNzcFNE?=
 =?utf-8?B?NlliZEIzeERaTnpXM1Rwakh5VTNnT1lNYmVlSmtUbDlSMU4vK3o0SHl2L1Fj?=
 =?utf-8?B?dkt6dXJheWt4RitKVHRuei9EcUlOR1k3a3BYK2R6UnE3LzcwUzNQcHJvWGNU?=
 =?utf-8?B?eXpUSGRNSEFzdDNWN0hVQjROT0EyQWhINThOSllqYlNaSlVrUjg3QUl0NjBS?=
 =?utf-8?B?MEo5SVhmV2VoclBpUlhQSlBuUVRuRlBsc2tGVmliZ2s1VXpOclI0aXcvQWNl?=
 =?utf-8?B?eEVqNDUvTzVMRmxpU2syK2IrbTNmc2wzV1BYZ2ZLckRmOEFvYlVXbG9kRGtp?=
 =?utf-8?B?SVFyNjlUNG9mUytERzlnVE5WR3FBR25xSVdWRVdXSU1vR2NZajBPc1UrdUF5?=
 =?utf-8?B?Y2s1V1NqT0RtazhZTFhMWXlpVzFzYXZEdkxWcnpMZzA2Z216RmRkWThkb3hK?=
 =?utf-8?B?OS85M3NKU0h2blJzRFQ4Wi9ER1JDV055S3hYaTQzeUVKVHlCZkdCb2FhUnZy?=
 =?utf-8?B?NmZ0enZQMkFNUnlFbDgyTW5HQVlNay9RQjkwZ25LWWljZ3lVR21NRWFWdHVi?=
 =?utf-8?B?ZTBqQy9FRFJSNTkxc25KdXRZaTZpc1dWY1p6cGdxeHV6UWtocitnenZxUWNl?=
 =?utf-8?B?UzV6SkVZT0dLc3JhTmxWUT09?=
x-ms-exchange-transport-forked: True
Content-ID: <407AA98FAEE64548A03BB218B09C599D@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f092334-a013-4fbf-209a-08d987b1922a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 03:38:18.0411 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MGdMpGkK71vdvo/A7KLSlV5hw9MpAdW3b2hJUE0499GIYRNqpYTX2QCzTfGR5+8Bp8MR1S5I9X6hT+afQwbEIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1726
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211004_203824_010784_E4C54E8F 
X-CRM114-Status: GOOD (  23.76  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 10/4/21 19:23, Ming Lei wrote:
> External email: Use caution opening links or attachments
> 
> 
> Hello Chaitanya,
> 
> On Fri, Oct 01, 2021 at 05:56:04AM +0000, Chaitanya Kulkarni wrote:
>> On 9/30/2021 5:56 AM, Ming Lei wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> Add two APIs for stopping and starting admin queue.
>>>
>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>
>>
>> this patch looks good to me, but from the feedback I've received in past
>> we need to add the new functions in the patch where they are actually
>> used than adding it in a separate patch.
> 
> The added two APIs are exported via EXPORT_SYMBOL_GPL(), so it won't
> cause any build warning. I see lots of such practise too.
> 

the comment was not related to any build or warning.

> It is easier for reviewing in this way since the 1st patch focuses on
> API implementation, and the 2nd patch focuses on using the API,
> especially there are lots of users in patch 2.
> 

I am aware of that, just sharing what I got the comments in the past.

> But if you really don't like this way, I am fine to merge the two since
> merging is always easier than splitting, :-)
> 

it will be good if we can keep the consistency ... nothing else ..

> 
> Thanks,
> Ming
> 
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
