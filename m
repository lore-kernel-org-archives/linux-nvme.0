Return-Path: <SRS0=KS3B=PB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C63C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 04:25:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4663C60F11
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 04:25:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4663C60F11
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Kr5WvV+2wIw2/iZ+n90wyiwjUUMK+SoWxwT9ey+wHrs=; b=Bz89htzVzAnett
	w1n87pgjMfxn/Xm4d20KsklELgSaDlY+mmbYy/BkGy1oz6uIL2JIfU1O3Jhw4bTyASjMoeSdTkrFk
	c3NI6vhUqm1AstIPl2bvTzvI1PZ6iLMFg8E1YESvqcIHZwhDcwhi4Gu3shxH1cuqsUAz73Gu25sRn
	AkctKuY4A0Vz0vEGRAM7osF2+dLwq+aIypOVBcy0z4mET1LHBIxTV3rRtsg0LXFR/NizdLEeuRvG4
	tJCg9F9gTquti/j3K7/gt4dBr6tbj9n61F7b+YzBcd/f0YWupXU083H1ObUvwb5EY9SuE3KAIwymV
	iYHCrj4fBsNkW97dD7QA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1maVpM-00EoxU-LA; Wed, 13 Oct 2021 04:25:16 +0000
Received: from mail-bn8nam12on2059.outbound.protection.outlook.com
 ([40.107.237.59] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maVpJ-00Eowz-Q1
 for linux-nvme@lists.infradead.org; Wed, 13 Oct 2021 04:25:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TwEOfBRXz5DDRJdGv6kXhJzjyEsVdg3rCM06EZ5N+N2CZQWLW9DIW9NbIFG5SMzJtJVBy0QLz82QlDUS79tD1Bl8FF8n4ZqmJn0efYK6STPvClVrghtn1BS0FISVDOAhN1+2scPtSylkhpw10dfwMmMpH9T4b3XYo9mjRC067prLg3jX4Lf0Pi6BxMPGf2U2wy689bFaexHFb2acczutzf91/ZOj9Epafa9nyIwnu7ywkMNFNoOwWGW8k98fEpijotqHCXCa9vmSa3hAKb8ThqPROPoi8tVPU2Oc0zHu2ndVClMknfGGq8tSpLSmAL4dzIGsGLifPb4vT+/aIfSugA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QSlpr0HCxJYIETj46zk+GU5/TtVFuzUGdK2hNUvDMlM=;
 b=PxyF0b8Ed3UN/myJDkmrAZ9wcFh7vj2c7W7ikKaELer/eyJXkOFPu4ebRjD1QUvkE0aR3Q/cwVxNV6xpEfOv5ERKakc2vZwUKyuJKl6VbTbiC8Uzfw5iVVAsyqc+2zWDorAsrgRZiFsFPL45yKF4aJDd6HZcJKbksMnbg6qGOWW0+gtWeEioYAzFXUmt39PLFClc9zNJJFmvJl1y6RvBaKGDbie2A2YZK3o51uIRw7zxqXSHA+bnv++mqkmZvOcYLYGGpIjIdWBYqR7p4NlP/0qs50gOYUffzFGU9k9konHPVI/JUfavccGacat/Hux2T3WQpYbjCjLPOnejpgDs3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QSlpr0HCxJYIETj46zk+GU5/TtVFuzUGdK2hNUvDMlM=;
 b=VX+GNF/UKngcmlkjywY8cEUBVQuJGXqdBnX9Pix0ImTk8RIvxyH7e7eMcVy+BICVeYO4hVYs9vnGOpxVMZpjJExQ8zygKh/+lU0Z3S1maH5cQ26pi5ta8+C7HjS9l214FC31jVBnMqGy4WkVuBjD6bny8m+wHjrePvUlyzjUbU/uLIzG90JDQAQyrS483WrdrYc1ApzS9I+3iKwNBhfHT0GPwVSibGAMAXJIE2snlGqyNk2QHwPXkQLBJtO4LYocWOCkbyg5DyoMPOaXTuGBvOBhSBbcRnqwSQPd+mrmlj7Rav0VCwuuI2u+dScS64VsT7HNFeEs0JWJLpAYod0z7Q==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1583.namprd12.prod.outlook.com (2603:10b6:301:11::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25; Wed, 13 Oct
 2021 04:25:01 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524%7]) with mapi id 15.20.4587.026; Wed, 13 Oct 2021
 04:25:01 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
CC: Jens Axboe <axboe@kernel.dk>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, Sagi Grimberg <sagi@grimberg.me>, Keith
 Busch <kbusch@kernel.org>
Subject: Re: [PATCH V2 1/5] nvme: add APIs for stopping/starting admin queue
Thread-Topic: [PATCH V2 1/5] nvme: add APIs for stopping/starting admin queue
Thread-Index: AQHXtfqjo6XrkhaLxkCH4OgsGNpS36u9phOAgAYN3QCACglSgIACq16A
Date: Wed, 13 Oct 2021 04:25:01 +0000
Message-ID: <e631275f-2254-65cf-2ea6-cf7f8cd0b587@nvidia.com>
References: <20210930125621.1161726-1-ming.lei@redhat.com>
 <20210930125621.1161726-2-ming.lei@redhat.com>
 <95d25bd6-f632-67cc-657e-5158c6412256@nvidia.com> <YVu3EjPqT8VME/oY@T590>
 <20211011113911.GA16138@lst.de>
In-Reply-To: <20211011113911.GA16138@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 53248de3-54a0-49a0-09db-08d98e016ca5
x-ms-traffictypediagnostic: MWHPR12MB1583:
x-microsoft-antispam-prvs: <MWHPR12MB1583BC1246F7AA6FA7151365A3B79@MWHPR12MB1583.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0UIpScbeTR0L4025OxVPEjAsZcGAXNcKVL4lGq9r7teuiygyhOx8tNkD/aJ7VLwS257v8xM1M7fk00vBocnP52768VFG18QcL06uhKrbVBye3e/9zBcroVdI+KsROzfLse3fNjbI/Rhoq9Ge0crW/7Lq9RPsRPcvyE/rModD8Fxspuo0QFWeu5XWcWiWuHsrDywxNL1sHqVvhpip4Q3dJqkec+BwgdJ5kib6aAW4w+nEC0lMvHfcvnUlp5nNztCkt7O47z3XSJCgpMLbJcfTAVwXU+geugKM2p4sCkqa1LBLpjlfP7QG/Sz9aisSGAkRAiGb0DATxFxFTY+BIzEFzWcXfN1knYUhpRgMFRVGC/xDLLCKO85jUjktJyq6el6Wbgfj+wIQbA3UUPjyGzPDmEYDwUkTPpCOYywR43UsQbp2atlK+Qz6/Yjb9sQIyKkfMgS4XyTZiItAnPln8g6Hr3DVfEu8DuzQNVd6I4CM8T2/EpvzaLJcX4I7Om1L+j4ygesMAJVPiuRheiMBko4HQl1DFip3mQcmhamIyOdIYhm4Aylr1/x/gT4rjdgCAuz7lYOIHhz1nLxkJFzVXNA0KlH2unuMyqz5gs1NRxJmYxRG7G5Fa1CRacPV7dvUESRtihR37ICzXv6KcuWTq3sJbMWfrP4/hjYFRhbMdcNIxO+o4QuAUihBQtDkO5sKZMC46cMvu0B7ZNGcIQkanRYrzA+VlqT+MfX35srUcmjYueHU3M5uEY7GV5wGlXNj5pWeJseOjBM2IYs43BRR//l/EA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(76116006)(6512007)(66946007)(38070700005)(6486002)(508600001)(71200400001)(54906003)(122000001)(31696002)(8936002)(8676002)(91956017)(66476007)(66556008)(64756008)(66446008)(86362001)(558084003)(110136005)(186003)(5660300002)(36756003)(2906002)(2616005)(4326008)(316002)(6506007)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VnVFS05JQ2w0TGdoYWM5UG1RS1FZNm5GV1luVmlmc251Y2xKVFlJYXJsckp6?=
 =?utf-8?B?V210SnBEdm5abXZwMmxZdUoxa2tSRm5ybUdQWmZhZURyMWNlMVRqcFdrNU5q?=
 =?utf-8?B?U0pIMkRUTmYwOG1uNUJpY212ajFuLy8zSnQvN2NEUmpWWThXMktnczB5bnJJ?=
 =?utf-8?B?SXpucWdtbXB0VnZLUUFDS0FpWUpza2RSL3ZINE9hQytGOEp6VjJMcmNGTkR0?=
 =?utf-8?B?N1NId0x2L043MXlxU0M0OHlWbnRrdjdlRG5NdWxTWlpJakpnU0ZBUkJhQys3?=
 =?utf-8?B?WjQ2K2UxNEE5YmhBZEdWV1lkOFRyZVpZeUhRTkxxaWh1UWQ1WS9KSlVoMWUy?=
 =?utf-8?B?M0ZwYVYyV0ZUdVVYbnNWSHdrQldPM0VuZ2EydlFvVjBFaEE5SzA2azljSDk0?=
 =?utf-8?B?WGpZTUFXRFoxeldaaUdHd3p4QmcyTnhKQm05UUMxN0Q2NjA4SDlxelpJUE95?=
 =?utf-8?B?L0Z0cHFyQ1oyTjdTMkZ4bG1Ndkg2WmdQKytuUzNUR3IxcXFrakFXd0R1MC9q?=
 =?utf-8?B?ZWJycS9LNEUxYzcxeEFYR1RpZTdhL3FtZWgwWElxMlRmaFF4djl0QmFBNVZI?=
 =?utf-8?B?ejc5V1pLbDBVTGZ1ZUxYY1RGOS9WVXpMVGN3Q1VFbVNTSmZqczF0dXVpSHRv?=
 =?utf-8?B?SjlXc0UvUGR2N0xnV1ptOUlNdnJtdHF1Skl2K0tkYzVXbkt0eVk5Rk4xZ3Bm?=
 =?utf-8?B?enlCVHJDSXo5N25qM1RheW14MWc4dG1lUmtzNzMzYVFEdnN6RXdYRHY5ekUx?=
 =?utf-8?B?ak1Dd21mSHdGMkFqenpXb3c1UTNjK0pVVFV3SHo2YzlMcHlXQndlTmJicnBP?=
 =?utf-8?B?OWFVZ08yeWxQdXpSbU1xZkxMNnNRdEwrdWl2dExpeS9CdzJqbXlORnZmdXNZ?=
 =?utf-8?B?Rm15cStxT2ViRlJONTltUUh2bHVGdHB3b1RucVF4ekYwc0MwK2Y1ZEd3NHhs?=
 =?utf-8?B?MU9tZ1ZQdWJ5Tlh4cDhnbEtuYlprVkRJV1FUTkdNbEo0NHdaa0lETXJEL0ZJ?=
 =?utf-8?B?dHNJQ3lTL0tBcTZxL3N6TWpFNHlJdHp2Q3ZPak4rSXVGc1VvcS9vVHBvY2dx?=
 =?utf-8?B?QmdYSlRGRUxPZDZmZnNvNkFuRWsxS2dMVWl5THFpYTV6SUlzcGp6TkFLV3JN?=
 =?utf-8?B?eUNzaitOZVhieW91Q3MvWXZGaGFaTERpTHZzNGZKM2JLbDYySW1QLytGV3Vk?=
 =?utf-8?B?ZEgzTnNUVS9Mdll4TEVneGtxZmcxN21teFFVZDh2NndrR0EzSFhnMWdjdlRp?=
 =?utf-8?B?bGtWaExMNldzbmJrTjVCV2dwd0ZWVTFhRjlwd29BL3dHNS93aTF4enlCUndu?=
 =?utf-8?B?eCtJY09BK1Q1NWEvTU0rd3VUbHNCQXJIbnhZL2RXeno5MVJQRmRWazZnUFUx?=
 =?utf-8?B?Mi9DdnJUVTZyTHVEUE1SeldWWGZHQ3FYdlBleWJWdnJmQWZWalBZN1NwN0xF?=
 =?utf-8?B?NGtQWWdGVVdGNGc3S1NiV2tTZ201U1F5a1B6cWhzNjR2bkxWcDJDZW8xYk4x?=
 =?utf-8?B?MzZpd0NRS2lYc0Z6emxJN25CeVpnV3lPYWl4UXorbFI0TzVRcEo1OWhzY0My?=
 =?utf-8?B?N3Rrb0tzQjVsa0paQVVWOUVPY3NlN1dnQ01XQUVqK1p1ZFJIUVhMNzdjM2hp?=
 =?utf-8?B?dnU2cGJPMXZKemN4RnB3UU9hT0ZGdUd2WUxTbTJ0WmZHb3BJOCtkSVFUcXE3?=
 =?utf-8?B?U0Vwc25oRHN6N05kdi9wOGFkWkliR1JyQ2F1VStuVDhZWVIyOTZJWjl4azl2?=
 =?utf-8?B?L0NTOFRDUlRXa3RZam5Ha053R2N3ZXd1STNuWEVnNDlRMzBDL04xT3B0WG1Z?=
 =?utf-8?B?ZUZhQjRVTEY3bVpjUVk4Q1Exd0xScjR2Qm1oTExOZEh1TUZqa1BUekd5cFRj?=
 =?utf-8?Q?OQOw9cyTkZX5t?=
x-ms-exchange-transport-forked: True
Content-ID: <0796265606862449B991F37305FAAA2F@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53248de3-54a0-49a0-09db-08d98e016ca5
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2021 04:25:01.7133 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BFkYO+xhqPL/SdwtJiNYTIM2WdKrCYWe9H0tgEF5cfUIa0jOSLTJu7R8V6uqCZkK2xNKHn9f6da2A+rVGCgqmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1583
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211012_212513_892636_6EEB41CB 
X-CRM114-Status: UNSURE (   8.00  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> The above is for use inside the same driver/subsystem.  Cross-subsystem
> we usually do what Ming did here.
> 

I'll keep in mind for future reviews and patches.
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
