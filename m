Return-Path: <SRS0=w6YM=OR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882B0C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 19:35:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B79660F94
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 19:35:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4B79660F94
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xo2+vx7SRSd5bjPRXGa/i4P1ghAQheo3Q31PG1Wmv+A=; b=C/xsm30kh7Zm8P
	RqOjKRE9rSMTjrY2KjEaub4Kcqa9R+SWMFdSMCyz5yyhg+kOdXpGEOEvnLFPaXHTv7CMloTkZWyvP
	JrhTvbaFtoJl9yj2rTRtG9h8aCgzyPjsJ5nJacXVzyGzm3HXgYXE8HHz/KlKIQF8xUT43H919GmNo
	OlqBeNLYC9ZTVrMb+ldyO1TuI6ZDLqt1Y7NVybn7L2DZCkBNppuAzapb+vJhuEzAZyIubtjJumxJC
	tDltt/ubs0dhpvsemE3EIJNCEMYYf9H6pqT5Uo1uAuW9qeLCXA3n/6yFSeWDm4MkiqjYT5DMwDWHF
	ferNr/HbmipmaVT9oG+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mUwOj-0040Ny-Vw; Mon, 27 Sep 2021 19:34:46 +0000
Received: from mail-bn8nam12on2082.outbound.protection.outlook.com
 ([40.107.237.82] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mUwOg-0040MN-J4
 for linux-nvme@lists.infradead.org; Mon, 27 Sep 2021 19:34:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XX69c1epnfvz99cWC8sqMk/LGBIJhwvJ55OeqgRhAnjexogiizrpTbh/qeti7s+YkwTQ3cNHlXIY4GzEHt37Si117kZ1TZa5TxGjb0lMQ89hSGRRP5Sj77roKG0b7wBPxDGYfwYVZmesG8lPv/b5SRlAWNoSYc6a0Ui3U807VodwaPjjJf2CgtuxSOkKwfUuu28R6ZIgzebIeuFweK86YZRSc0sxctZG8a8Ic/Py3U95EPG2/hQ78wmCsuvH3siusxD8QYmeJHrb1oEcxNWFRo5N7lIrjddCwqDXHCNZ/TejJ2z4F8VFFS2dMzvYhZ9dQMLefveabmWeL6IdM56r3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=e6HAyvEBM28B2OW68F8XWZ28NXmTEKKo4g/NZHmX4FE=;
 b=UKg2wjblw+60lOaxTCvQtpenttn6VYHJuX8LOOpq4V7CPBuYWUA6xyKRVq5XnCUXz/jnilOQGQ5+43AwWTd0+Mx2W0zS5E6wN/ww8cfC37D/m06ZJgEdPFNX64aXAmN70LMtQwcJdBUWMeYoPFJaBJZFVfbloTTayaKmm2iZRsspgyxgzbiTk02TmS9KsR3n5y6jllvwf8kOLAVtw2ITWRGbCTHYSkDsqKegCctkliG847IvvF64kmxlM8oDCZ74HWy30HlMcskb0bWlRauIRNW6I4BDWjQ2MUPudusEkxldcQ23j3liLnJnbltyIklBSCm2hD2ioPWhxJZIyWZUTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e6HAyvEBM28B2OW68F8XWZ28NXmTEKKo4g/NZHmX4FE=;
 b=RB+8PLvf2jpEmetaPUjdW9Y9UMQLo+DUykFz5KkBV/3RSHzQniG8TxOHUDg9S02cUyt5yv0bTbilYdtcYH0OENCNNxbDgGynDYhQWfq3oOwHAvVkof8vvA3fP2QZRSOJhFFn+7fz+GFWlFolN4ZX03a0TDZnk40kzBqLKLJNcg7iI/OjRVk3d2Jsq8ppncmx0WOkJf+eZTNCqGOGOBYqXEV/9mBcRUs32RqTBSrg+Ua3yVQVFfyYyDpahgWe3T4SCpwG9VieXvKxam1FpmDgLhG0amAr4BYJHGoqLmyR1NBWRlc771tsD0VZWNuth7jwUv7O8vmJYkTsgkpp66QYBw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW2PR12MB4665.namprd12.prod.outlook.com (2603:10b6:302:2::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.19; Mon, 27 Sep
 2021 19:34:35 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f%5]) with mapi id 15.20.4544.021; Mon, 27 Sep 2021
 19:34:35 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: chengjike <chengjike.cheng@huawei.com>, "kbusch@kernel.org"
 <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "sagi@grimberg.me" <sagi@grimberg.me>
CC: "sunao.sun@huawei.com" <sunao.sun@huawei.com>, "jiangtao62@huawei.com"
 <jiangtao62@huawei.com>
Subject: Re: [PATCH V2 nvme-cli 1/2] initialize disk "access" variable
Thread-Topic: [PATCH V2 nvme-cli 1/2] initialize disk "access" variable
Thread-Index: AQHXs0DTYHbujTRYikql8HQsZd2g5Ku4RuWA
Date: Mon, 27 Sep 2021 19:34:35 +0000
Message-ID: <980ca996-f072-e8b7-b9d9-6e1b71b3c2cc@nvidia.com>
References: <20210927014137.3756-1-chengjike.cheng@huawei.com>
 <20210927014137.3756-2-chengjike.cheng@huawei.com>
In-Reply-To: <20210927014137.3756-2-chengjike.cheng@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b622aeb3-2f97-4a41-7656-08d981edd678
x-ms-traffictypediagnostic: MW2PR12MB4665:
x-microsoft-antispam-prvs: <MW2PR12MB4665F7BBC9928A9E9760DB1CA3A79@MW2PR12MB4665.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1443;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RRRk/55G+dsBmArnwvMjmDj/7LOuvVCumh+CGbD8sg9sAYe52eRD4TP0wKFb7y7EAUg9odhlID2NmfUMSg0ULGx3VH87Smn173DYpyEXqy9IL+Mgi7uBLcioA1kFI63Qx0kQn3PCu/Sdv/E34otUab3qwTQub8c2iOJzqpojPUP/7dC9DreFbmYcukQdrgFGE4gAv5t6LQHcBXUD/iM/UGYAykMP9RHtGluCEf0Qh1wsqBzNOhGLH1JrVZXbyU6mWUgsZypg95vj60Cx3B6jF6HJXZP7VNa0s8n+fMeNALXGnAlU73XqcQKM78kVEVc7WbgWqBVdFmRF0ybl/aewi9SkFYA88ZxwXogD7A4Or9Xxae0j9kbGPyz/yWupk1arRqQPR/Zx5+S4WYesm4issXJB/8rd9p2VAd9uLlpcvEPJIOP3n5843+NrcVdFHuLdHDk6Gm1kfMIfbyzsGcxQaYeExa+9EDWDIO2e7T8RiNX28YY0wUUwWptjuSviLwlJiqAdT8d9g+A2pxWMRisUaqDUM+9LjScmVdLse+C/3Ecvirn6Oa4vX5IJNmQAdR0gQ9OlkhBOgRsrn1x0HoiCgM2cJxwqk3gja4L+9W8cUoST0KJMKzKS1RdaPHC+cHx4t3NLIjs6O2g7F4L+M+9aCpdEiANzKcDD8rqbkvYi/eXrlFRb0K4Xcqn65QjHf5HBDjyOgCLw6n9g2739dLN0Tcz9YvMzP1Sbe4brKd7nZrrLJCS+9qhXWjR10W4MRHYl/pdZrXM2MGDfdJKgW6I31A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66946007)(38070700005)(66556008)(66446008)(186003)(6486002)(31686004)(2616005)(8676002)(316002)(36756003)(64756008)(26005)(38100700002)(5660300002)(86362001)(110136005)(2906002)(71200400001)(66476007)(83380400001)(6506007)(6512007)(122000001)(54906003)(4326008)(8936002)(53546011)(508600001)(31696002)(76116006)(91956017)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OU10a3VQT3RVRjJYcGNLK0NpQmQvM1dQUmRuczQ4K1QyaiszUkJYc2JMdHdP?=
 =?utf-8?B?em5tYlB0d0dxa25zMkV6ckpTeHl3b3NsSDBCNEsvOHdER0VhUzhCVGpuZjMw?=
 =?utf-8?B?bVk3OUhMYk9Ud3d3T2x1NnZpZXNXK1EweStENy9CRy9PemJXK1d2RnBqK2pT?=
 =?utf-8?B?OGkzaGdac0ovOVV2R1ZoYjh3eXpoNkUvTnJZbUkzVzhRcWR5bmI0emhSTzFl?=
 =?utf-8?B?bm80VkNXWnBEWmJub0JTQkEvRlBVSURLMkJIaGV6NG43SnRMSE0xNEZFQXZ3?=
 =?utf-8?B?MEo0cDhDZks1UDFLaytGb2NFYklGSmhtZEs4YXBtYjhnalo1QUxyMEdnakZ3?=
 =?utf-8?B?d3FFQnM4RnYzdlJWL3ZEa0k0dTREYmU0UHkxNVZVZXYxYUc3Tm1mWHMwS1ZP?=
 =?utf-8?B?ZVBCWm1INWErSjdLelBOU3FPMHRyRUpUbm1HY3RpRkw2eEYvZi84ZFhQRGtJ?=
 =?utf-8?B?L1VvdThIdWlBZ0J5bTZNMHpFcmVrRHRBdUxCemhqNzYrV3UvQlFFemhoVVJp?=
 =?utf-8?B?WjlGa3hiTjlpVU8xYjN2V0lTd0wrV2dVWDVkT21iUmRBNWFuRUsrbHhaa3FG?=
 =?utf-8?B?UDhCSnpEbmlWM3FVLzFnUnJhTVNRc3pKTHRKUm5ZQ0VRSTdyU1czeXY2REpX?=
 =?utf-8?B?Z0VSbCtoZERGc1ptK0FrVlRCWTZReG5xWFAwN2xZaGJMc05EeVJWaWRQYzZJ?=
 =?utf-8?B?QzJLUlZsSS9IRVVRUjMyMHJFMVMzMVAvdE41cDR3SEZYNVEzQXNNcHhXM0xn?=
 =?utf-8?B?dStOSEFkVTVwdDBzVGdFbkVnYjBSd1RHSFEzRU9nT29jdTJTaWJTZ2FYTFVz?=
 =?utf-8?B?Wi9YMERIVHR6UzlhNEVIVytlNWZNcGU5UTJQdnpQem9LRWd5ckZBMW1EWWpR?=
 =?utf-8?B?enQrQUFqSk9TM3FZTWVFSTRSV1NPQ2F3UjRuaXhJeFp2N1A4QW5EdjZuSDda?=
 =?utf-8?B?YW5jKzlJS014VUFBS2E0NFBZL0k1d3NsWDB2VTJnZDJnR2pZSzZEcmE4UXFz?=
 =?utf-8?B?czBtT1BTNlhRSzVLLzZoQ2VaeHcwTHVxOFB2VUlQT1NUcmtuYnZQRXZmbVFT?=
 =?utf-8?B?cDNIZFl3NWh2ellZU1VhUFVWaGh6ejI0dllBZmxXVVNhSGo2RVFOVDNBdkVC?=
 =?utf-8?B?amxnNFV5QTc1YTMyallEUWI0Wk1mR3VQNmF1UXl3MXFPcDI5cGViQm0xdjlO?=
 =?utf-8?B?RVVRendQY2wwdy9DYkFmZEZQRnVQK0krdk5KM0RiMTFXSU5VK2hNeGw5biti?=
 =?utf-8?B?dW81N3Fzei9LTGk0eDd1SThmWmx1ZTNyTC9WZ3BpVjRhaWMzVXowbVc3MWwz?=
 =?utf-8?B?WFVvdTRUS0pGOG1wYjhFd0N4SkZEb055a2xOcnUwNTVnejZVOVR4MHo5VDZw?=
 =?utf-8?B?d2NKSTRRRjRVYUlscklDQkQwOEhPOVNRdUNuMXV1dUlqWUR2bjJqT3JOdDho?=
 =?utf-8?B?c3BFTjNSSFB5S29zcWpLa2dUSWRWVUxqUnd4T0VpTXRUaFVzTDZGMzZpc2dp?=
 =?utf-8?B?cGZ4N3ZUellqMW44bW1lWW91RVhER0VLYmlDWXV0NEY1aktLMVdad2JpODB5?=
 =?utf-8?B?SXMrUDg2ZGozdzJJbWdZd1cxNkFTVWQ2QVgzT2lZcU9sUWRXYUJ5K0ZQQlAy?=
 =?utf-8?B?ZEhQNDNlMGE1OEkyUXNqMzFEeE9FK0ZmaFpaWDZyWFdPV1VZYm44R01IeVpj?=
 =?utf-8?B?REd2c2ZIR0F4UkVlc0ZrbkJ2UHdRWm5CRytRTHpOU0psMTZlbngybHVoQ2NY?=
 =?utf-8?Q?+uE300+Ud6MiHT6MSwMHenoaKMP5FTb+Voo2a2O?=
x-ms-exchange-transport-forked: True
Content-ID: <D7630CF735B7BC4F9B777DDB1DE23D9A@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b622aeb3-2f97-4a41-7656-08d981edd678
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2021 19:34:35.4237 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FvCkJeQITiDw8JKMrWwJL29z2syhho3mKysf1DeEttWApKwrYpD+PORfJSSr8uCnCQOcUzZuuY+1J/obbIVdnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB4665
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210927_123442_901438_6F4747E9 
X-CRM114-Status: GOOD (  29.55  )
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

On 9/26/21 6:41 PM, chengjike wrote:
> External email: Use caution opening links or attachments
> 
> 
> When it is failed to get nvme_id_ns data from NVMe Subsystem, the failure may be caused
> by a link disconnection or an error code returned by the subsystem(such as NVME_SC_*).
> Then the "access" of disk is set to "faulty"(otherwise, set the value to "live").
> Some displaying content of fault device can be obtained from the disk attribute files.
> 

commit log is overly long and somewhat needs an improvement about what 
code changes we are doing... see below comments...

> Signed-off-by: chengjike <chengjike.cheng@huawei.com>
> ---
>   src/nvme/private.h |  1 +
>   src/nvme/tree.c    | 57 ++++++++++++++++++++++++++++++++++++++++++----
>   src/nvme/tree.h    |  8 +++++++
>   3 files changed, 61 insertions(+), 5 deletions(-)
> 
> diff --git a/src/nvme/private.h b/src/nvme/private.h
> index 2a151bf..255c1b1 100644
> --- a/src/nvme/private.h
> +++ b/src/nvme/private.h
> @@ -37,6 +37,7 @@ struct nvme_ns {
>          __u32 nsid;
>          char *name;
>          char *sysfs_dir;
> +       char *access;
> 
>          int lba_shift;
>          int lba_size;
> diff --git a/src/nvme/tree.c b/src/nvme/tree.c
> index 293b0c0..dea0f45 100644
> --- a/src/nvme/tree.c
> +++ b/src/nvme/tree.c
> @@ -229,9 +229,11 @@ nvme_ns_t nvme_subsystem_next_ns(nvme_subsystem_t s, nvme_ns_t n)
>   static void __nvme_free_ns(struct nvme_ns *n)
>   {
>          list_del_init(&n->entry);
> -       close(n->fd);
> +       if (n->fd > 0)
> +               close(n->fd);
>          free(n->name);
>          free(n->sysfs_dir);
> +       free(n->access);
>          free(n);
>   }
> 
> @@ -1023,9 +1025,6 @@ static int nvme_configure_ctrl(nvme_ctrl_t c, const char *path,
>          closedir(d);
> 
>          c->fd = nvme_open(name);
> -       if (c->fd < 0)
> -               return c->fd;
> -
>          c->name = strdup(name);
>          c->sysfs_dir = (char *)path;
>          c->firmware = nvme_get_ctrl_attr(c, "firmware_rev");
> @@ -1277,6 +1276,11 @@ const char *nvme_ns_get_name(nvme_ns_t n)
>          return n->name;
>   }
> 
> +const char *nvme_ns_get_access(nvme_ns_t n)
> +{
> +       return n->access;
> +}
> +

why introduce a function that is not used in this patch ? Is this a prep 
patch if so please update the commit log accordingly.

>   const char *nvme_ns_get_model(nvme_ns_t n)
>   {
>          return n->c ? n->c->model : n->s->model;
> @@ -1515,6 +1519,37 @@ free_ns:
>          return NULL;
>   }
> 
> +static nvme_ns_t nvme_ns_get_local_data(const char *name, const char *path)
> +{
> +       struct nvme_ns *n;
> +       char *ns_id;
> +
> +       n = calloc(1, sizeof(*n));
> +       if (!n) {
> +               errno = ENOMEM;
> +               return NULL;
> +       }
> +       memset(n, 0, sizeof(struct nvme_ns));
> +

setting the memory to zero when allocating from calloc()  ?

> +       n->name = strdup(name);
> +       n->fd = -1;
> +       ns_id = nvme_get_attr(path, "nsid");
> +       if (!ns_id)
> +               goto free_ns;

this label is used only once just return here and remove the goto label.

> +       n->nsid = atoi(ns_id);
> +       free(ns_id);
> +
> +       list_head_init(&n->paths);
> +       list_node_init(&n->entry);
> +
> +       return n;
> +
> +free_ns:
> +       free(n->name);
> +       free(n);
> +       return NULL;

above error handling code should be moved to if (!ns_id) ...

> +}
> +
>   static struct nvme_ns *__nvme_scan_namespace(const char *sysfs_dir, const char *name)
>   {
>          struct nvme_ns *n;
> @@ -1528,9 +1563,21 @@ static struct nvme_ns *__nvme_scan_namespace(const char *sysfs_dir, const char *
>          }
> 
>          n = nvme_ns_open(name);
> -       if (!n)
> +       if (!n) {
> +               n = nvme_ns_get_local_data(name, path);
> +               if (!n)
> +                       goto free_path;
> +               ret = asprintf(&n->access, "%s", "faulty");
> +               if (ret < 0)
> +                       goto free_path;
> +               goto get_attr;
> +       }
> +
> +       ret = asprintf(&n->access, "%s", "live");
> +       if (ret < 0)
>                  goto free_path;
> 
> +get_attr:
>          n->sysfs_dir = path;
>          return n;
> 
> diff --git a/src/nvme/tree.h b/src/nvme/tree.h
> index 68f5cbf..7d3d049 100644
> --- a/src/nvme/tree.h
> +++ b/src/nvme/tree.h
> @@ -452,6 +452,14 @@ const char *nvme_ns_get_sysfs_dir(nvme_ns_t n);
>    */
>   const char *nvme_ns_get_name(nvme_ns_t n);
> 
> +/**
> + * nvme_ns_get_access() -
> + * @n:
> + *
> + * Return:
> + */

Wrong function documentation comment, you need to be more descriptive
wht the function is doing...

> +const char *nvme_ns_get_access(nvme_ns_t n);
> +
>   /**
>    * nvme_ns_get_firmware() -
>    * @n:
> --
> 2.21.0.windows.1
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
