Return-Path: <SRS0=1D85=OM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132FCC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 07:09:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C194961266
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 07:09:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C194961266
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kLv/HxXuSwX3uwr9GTBH9bk+hNPyEPCpCSyYyYSx7ds=; b=hM4pgS8zXofHJc
	x1yU07HWlsmylXWdsEK9x+VWzfaG1piYITmKkQoikFApbzejSBNMqKktEURO/ZueTrcKBTPkXUnuh
	2u/nUUVULNCusqyVRE2Y7LLIA4L6PiFJD/YM6IdgqOpjyqVmI01p+pCzSAHAvHBgVkgteAZJpRVf1
	a6onZHD2Muj/zGnc7aDsAvnbKnCt3hw9d9A4pRqF8CkhXp7bA8kob/Mv+o/hPVxlalIr7caBY/HTh
	1GKkARcXMzN2UC0hXbippo+92qyXV9zIPSethNfIUvFOwaSRIG/j4paUisyZxchAUWv7hQnj56MYK
	Ehvw8519HYbzgqgvHxiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mSwNB-007FS9-8P; Wed, 22 Sep 2021 07:08:53 +0000
Received: from mail-mw2nam08on2058.outbound.protection.outlook.com
 ([40.107.101.58] helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mSwN6-007FOk-VA
 for linux-nvme@lists.infradead.org; Wed, 22 Sep 2021 07:08:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YLC/OcB5YJDlQ/PQqfuods29FUbhICevTpL1DPRGTcgRWglN3d+xdqAeB77mSeb2AHTzdNce1Q+dPLmg3P6b/YCrt/I4l0Knxth5Q8E1Q0G/h5ZOzj7JUG1u5bfbxcuJ1tQHoZN+qqpnP4qCUzz9Zxg09xUEjLuyjVaHc0jf1nLfJMgcOYJkMPQYOPXKbbccE4A97IBe3iHBSKQNNjgcvBXw+8ADLCu/cQBo8xUvJU049Z4NqEaeg9mJQxHXuJfkQCnrcF2hkeBMCLzpI4kRttWh8YTi89JllQblG/HoDM8gEWRvhOUUjg0aHquCvTCfwdONNt8cSFtdbFQYLRsxWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=sKawj+8KD4yEcAV3ewhdrglBImTrVEQWi4eKsc1uE9g=;
 b=XH8yobsIMu09v89487/QXeEYhln1fybUEPuGA1m3kO0fLFGxszt9sTbgObQjTVzl3pJ8WZj68CpFPk9BAEYhyQlXlU7h5mwMTt/pZciT85BTrqXpttYKhLkC57g8Ag8Vn+DAEPLduQJKXl2TCRbkxj/YzKcW2JP+Mbx/xtfeObtmmplAyfd7SQHpLOJHo1Bcb1OeVDfoX2U3aY3OXPBK954dmQ1TkwK4jRh9bwJQ20GmnHPaxYS7Aa7FAU87M05+nKeoZj0TukNKdhlzq4Ug1yEf/sOSL9w537b8dyZ/N7o6C4QJHoDfWms7SkqXvvHGxR+sRiij/ppMpzbMVUoTRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sKawj+8KD4yEcAV3ewhdrglBImTrVEQWi4eKsc1uE9g=;
 b=hBfeK9tiIKQA5bkBA083ZqAROEKZD7zOCmqE83nVxJ9Jf+Z3ULJMbRE29/geiC/v19heBaaw7m+aKu1JbNcy4facbIub97YuTyfgKV8BQo0NcAkPB0nxkZr8tDQklgvsgImCrclS7aATpG3NkoHnDBoRKupGp02wG9X8IctjS5NctrYf8tIkTlUL+49xGTGLm87NNtE+TvG1NELPjuLe4QYR63Nrcbi1fJqwIvjkw9MX0UCF54TQeif7I/hr9ARGEimrh39NsE+VeaeDQyU1ZSRO8eyfdlWnLXmfjglyAKgTcrtsXYhlQzv30sGVUjGzMpGGT91oB2q05wCrLpbBOw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW3PR12MB4459.namprd12.prod.outlook.com (2603:10b6:303:56::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Wed, 22 Sep
 2021 07:08:39 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f%5]) with mapi id 15.20.4523.018; Wed, 22 Sep 2021
 07:08:39 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
CC: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 4/7] nvmet: set 'CNTRLTYPE' in the identify controller data
Thread-Topic: [PATCH 4/7] nvmet: set 'CNTRLTYPE' in the identify controller
 data
Thread-Index: AQHXr3wJY/BqLnDwpked73Sq2Pr466uvolwA
Date: Wed, 22 Sep 2021 07:08:39 +0000
Message-ID: <81372298-81b9-ec3c-af23-aa11b65432f1@nvidia.com>
References: <20210922063525.143045-1-hare@suse.de>
 <20210922063525.143045-5-hare@suse.de>
In-Reply-To: <20210922063525.143045-5-hare@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 99278798-7441-4d9a-d0cb-08d97d97cdac
x-ms-traffictypediagnostic: MW3PR12MB4459:
x-microsoft-antispam-prvs: <MW3PR12MB4459EAFF26F1343467A0E668A3A29@MW3PR12MB4459.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HhQB3KyFSHI1i6HJl1hE4U9zJOX5B0c6JlR6rPh3MupY1QWleKuHnBcOi36OygopFTSFxr8HIi2MBb5aVgjepg9wCx7ACSb1TU9GnThOE7UPhsRrabaBs5ZcpK6p661cpMrMmWY+8r2M/GpCvGFa79jb2WusE6uA2afSGNrRbOXyH0ATlOJdua6yyUXA840Y3U7BDcQZgsLF3lrKfPPXaO60fvCw0GB3q5wjpaE9RpFnrd6DndBX4dGaDzlPvqaozdbh/6CL6WF4bzRdVH/SsjCkmW9pj49p2Veg0303lJtykyIhDwgd2PkNiTh6sjYRt4Upb7GHWMX4DZPPeZ6JJnatyoEyCByfahJPR621iAzgGX+VINb7IHxlCEvSPRgMIwhfmPPraEjPv84s2msEHyeIFa+DaQ/N0qp8Cz9TzPpKYo9ku7YbVgosu6jn8IBQ2mcvyABib4E1lCKnm/jSOrvIFSf7BDO+ICv6WAjh4ZTx+ad20YLTGuC/akIWHc1UbtKHlvtHlcKTZSvxIWcric7SSyG7Who5JrJR13SQSbcfWNoZYaPp2HVJzbBpUn/dVt37c3ST/miFsVPWYZ+Mrf1L4bqaZuRLgbH4EZFa9exfa66f3qCOvBnNTxdgGiSqy8npFdDmhTYBKhJYsm0gdoR1T1FR1vbjre5L0PnWA/c2XdPdqVs6lg2yQS3TgkmvF+4xrkG/nu5/M/EbmhrQ4R2G4JE487ha9cwths6wG7wP0yrO4+8ulQbtotZivclpfXoCuIaSJD3Sf5Ff2XOFrw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(31696002)(316002)(86362001)(71200400001)(6506007)(122000001)(31686004)(38100700002)(38070700005)(558084003)(76116006)(66946007)(508600001)(66476007)(66556008)(6512007)(4326008)(2616005)(64756008)(66446008)(53546011)(54906003)(5660300002)(6486002)(110136005)(8936002)(2906002)(36756003)(91956017)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0VPSHloTWxLVnRHUGVlazlaazQrV29KZjBKZDYrMHZIOVpvd3JwVUFTN1g3?=
 =?utf-8?B?ZXJQa0VWYnJ4K0o5ZjlQejVsN0VnaDR2K3JuR0Z6NFRyWGFsYmM4ckMxMzlG?=
 =?utf-8?B?Q29zM2RyZk1tbWY5NHNlandSYjRqK21FRHVucVYxWndBbUZTR3VlWVlybUFL?=
 =?utf-8?B?dGZNWkFJa3ROOUJoWXkxTEdpS0VJZEM0VkhnaFJyb01iZDZlUStUYm5YN24x?=
 =?utf-8?B?Sjc3b01ITW1EU2lnaVZaZ3BqQkQ0SzVacGVmTDZnamN5M2YvU0JqZWRwMjhy?=
 =?utf-8?B?TU9LcTBpNkNiM2N2eXNXUmpNY2NIQmdIN2VCNEwxQi9qRTVIUXJ1TE9lZVJV?=
 =?utf-8?B?RVNFTkdTZkFnaGRqTXp1ODBOcjNHaTFSTFB3U1VHRmFWTE11SE0yeFBSVUlL?=
 =?utf-8?B?cjBrdjBvMjRPUXRQcWFhN0NITFpCR2Y4d2luOHJlVHFJYmdXKzJyeW0rVW9p?=
 =?utf-8?B?R2NZSktKSUJ6TjBnTkk5WW9JcTBpSExza1JTaW5pbWc2Q0pWd0J6M0JVRHV5?=
 =?utf-8?B?d21Fc0pDd2NWbU4wYm5uWXk2eENNR1dZRUdaYzNvUWtCaU1mWnNsNlNyUHJX?=
 =?utf-8?B?aEV1VnNpT0JObTRKemQrVGh1ZEp6MU9MZWNLVTBEbDhLTm9YTzFpT1p4ZUts?=
 =?utf-8?B?VDlxNmI1UFVrc1l5YmVZL2JGWTBnUVhKVE9tellPUGtrdkNTd1FUTXVQcitW?=
 =?utf-8?B?alJPcWxSUUgybEtKOXk0RDFtTkJVTXg3bEtFQktoU0VDRE9EcTJJVXo4UTJJ?=
 =?utf-8?B?eWlMZFRMRXVlNzNZNFBlanViQjc2RHI5M0dtcEYxSnpwNE9xaTYzZ3U1QytV?=
 =?utf-8?B?WnZnTFNLOWtoS3M5bU1ObWJwN1VhbTNDWlMzTk4ram5PSHZEU1ZBMDVibUhz?=
 =?utf-8?B?L2gyWlBWTXYwaVVVY2lzVkZJc0pHRjlKVUxTcWpEU3AyQlRiRVRjMTdlWm1L?=
 =?utf-8?B?Z2Z4V0FmZ29NWkw5QnJVMU50M1BVMURoS1BCR2V0THlQanEyR0tEUHBIeTV0?=
 =?utf-8?B?YkhQeHhQbnpOUUZqYTFHWkpyaWlhNkRhQXplNHNwT1VGaTdxNWxaYjVvM2Rq?=
 =?utf-8?B?cEhCMS9JTVd5azNqNHBNYWtHYkNTSnA4VUhjNEpTdmlwQzJLRVNaTGx2UzZD?=
 =?utf-8?B?S0JDVHB2ZlRtWTZtNnVYamNMeGsyUXh1NUJEd3orQXRid1ZTeUpjUHhuMlNN?=
 =?utf-8?B?a0Z5WjhZeDJyd3p5V2QvRHRoa0x2Qm82MTA2OEl3U3NhU2tZYUt3K1JKZ3M2?=
 =?utf-8?B?aUc2Q1kvV29IRExJWTMrOThwQlNxeU1ST3lOUjRUbHpqV3ZVWVloZzZheExJ?=
 =?utf-8?B?N3ZneHArUzlQTTFFdFppN2NlcTFReVF5Z2wwRG5ONnRLWWFWNDdHd0E5ekJw?=
 =?utf-8?B?RmZMbjhTcEQ1cm8yNUQ5azdjdFNiekRYZGJ5YmI3Z3FmVnFiOFNSYmpGUm5P?=
 =?utf-8?B?Z0txak1icStFRG14ejVFT1g0R3FkdnI0bWI4N2JRM2pIN1NpMTZHNEpuWXR1?=
 =?utf-8?B?M1oydVVkMSs3WXRyQnlrOVVlcHZ3YWU0ajJEcUs1R2FHVFgrek9uQ2pkaVM4?=
 =?utf-8?B?OFVFSDE0eHR1RHJ3ejk2YU9maVZxdzAwVVZJMlJHZTRrNFFhWkdRWFhpZ2Rs?=
 =?utf-8?B?eHdobUJVdEticFZOK2FVM3Fyay9VTjkzbzhXNWozVXRPQ05FN09WcFY2Rys3?=
 =?utf-8?B?Vzg3N1hFd0JlMHdiRVRxamtEemJxbVpKTy94K3gxak82UWsraWIvMFB2d0dF?=
 =?utf-8?B?U05GcWpVU0hZYlM2RWpIQTVtWjA0L1BNcll5SUwrU1VOdVp0amV2Z1ZaWEZO?=
 =?utf-8?B?U0NCTXc4ZGdEa00reWJLQT09?=
x-ms-exchange-transport-forked: True
Content-ID: <1E30181017E34A4BA2E3A3CE199526BF@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99278798-7441-4d9a-d0cb-08d97d97cdac
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2021 07:08:39.2055 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5MrvHfspnZI5IrFT5EvR38I+Mr6InUT8Pg7p78X/Vqr92dqGjq8ULhsKGHOv9r4CTmktS87M5YiFgq/MSNTDnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4459
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210922_000849_047408_71601A5F 
X-CRM114-Status: GOOD (  10.89  )
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

On 9/21/21 23:35, Hannes Reinecke wrote:
> External email: Use caution opening links or attachments
> 
> 
> Set the correct 'CNTRLTYPE' field in the identify controller data.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---

Looks good.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
