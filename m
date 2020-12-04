Return-Path: <SRS0=dg6g=FI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B66FC433FE
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Dec 2020 03:13:57 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E4E022513
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Dec 2020 03:13:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E4E022513
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=h8Rd7yi0lyaY2K9OD+uRZStrWGAUnf+CzCvL74XvDb8=; b=kOO4H2GZx5/AmLVYzNx9AZGd5
	64ZsDbg3oUHTv+2Xm3bz3NmffIHQCueiX8WC+pcuOT9KKQ+151l77m8AL9HURPZm0GnoIgZcfVRhk
	WJ4Ywz2aAp6espeZlhY2O36dSlYTczvJhF2VRUUWDhZSjHiQQ0tmLuQNVE3p31n7WMWKDOiWtI/T/
	5+mz+MJuBiUTXZB8A7WHRmtxnV31zHNNePVhXDYDoAxry32Dl1+vCi/kIbQpS049/5HAAziQpU3J4
	2vtvqp0Wx9piM2Y+yJjH+/uy9lJ280t2dJr9AvxbAFy+stTbb97eXY/tvOCiTZJAbVJ9LuFlalAbs
	fYxt9QREA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kl1XZ-0002bp-Tw; Fri, 04 Dec 2020 03:13:49 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kl1XV-0002bP-OS
 for linux-nvme@lists.infradead.org; Fri, 04 Dec 2020 03:13:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1607051625; x=1638587625;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=Up7giy1xN8Tl8+tGQcOgTckJj26FnF6TsVOCW4sULvM=;
 b=GXRiCNPClZ+Ur1zjxYKzigr087ef2OKNEyzJLIZzZPMd6xYYI6QpDyjP
 zfktotZOefL4bVlQ0QmRYH2VDBEg1nci0LjkydYbERXppWbTLYT+lgt2k
 YKMTibaO5O13eDJdwPivpPkiUBaiNfgjUrym+CcqPYM5znVKAJ+jcYxtf
 PlVYrP42yusN9HkkwegOr5l9iSvUHU2vSQH/OswCSEHUWqrqFa7qZCzSB
 OehiJGMPS5s+0VEaPb6xRRSolTyXPLYU8YRujB/t9v2ifXZxVVKHxz55U
 h++5/1XfvRsUtjYBPyH1ADkQFKA3qBE87GrfzLyL2aTaYufZYsqG/n/Ik A==;
IronPort-SDR: HjATsmS9D0IolR+kpzmpbGBaRvc8EL5/lRbFFXOkE/CW177hScl2mmo3uYaCb1k8+eohl3SYOh
 GoxFMXMbCC/obhN8ZO4KnsE9gxqUvGLQ+SQ5sJ1Ww0ZhCCNNU9g+h+NfZqsoav/AwzTmMDU8a6
 e3XieOtSj8lqtiR2S8QF1P9/7mWYRKB3f36o5LLnvp+Cl5RvV5O0Xl3MpHUrF00F+FxXkUPvdx
 dxW/wAlzD/RnxGxM4dWu/tp0EE39WXarbj4REkwdO0PuWfWJVftpV48Eyvq5c3bAasN9GuYUpZ
 HjM=
X-IronPort-AV: E=Sophos;i="5.78,391,1599494400"; d="scan'208";a="154466235"
Received: from mail-bn8nam08lp2042.outbound.protection.outlook.com (HELO
 NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.42])
 by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2020 11:13:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oB1XrXob9hCkicbak3Jb8sGQzVvJRwBuDL0KO8+qvvI5zxyZadrX4YYLL2SjJ0Hc/PRJ+p6OYWItgTYerlB3RoC/Sv8T+lnB1FHSgo/vl6X7R/Ywg5GC7piVAnTJFcc2EjoyyuxIpUigekjctnaAaWSy4h4sIPZlLoFRjw35u2bMm5JkAVeRue75JozsCp2vF+LRM50+SlKYFBT5LC7UCbwSFdWNZLGQWXw8Hn517ipO0AfT12bFb9sAZTmrP61iUO4FWuVXHaVOc6qANWTIQa11YvtyweZ+sdyNEBqOeMsLp9CMJXj/yA+sheVi4if/t+K/NIqqpdK1vs0fG7T/XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EnKwytHu2GFyJjYrq3/2clCyikneJ/jCMObW5Ey3zA4=;
 b=KT7m1edlyp+zn+Pp1L1E3GK2m3PabCGrNA/iL6nG93JQqzfiO450lMbWN0wkCZpbyQMEq5uCp5Qp1cjecGVdIvbM0HhfDagcUQdE910VDZ5mTWODriJlNVpqF6JRBlVR05e2CyYwJjcjGCSb3XFcIdeo7wplCDmPi7Fad+wuxBIZ34wjvt4Y3SmolF9PwhKsZCa3H1xjCL5a/g3nVpkNz+GQrILWYDXu6X+5F6z531sz3Cvhv2x0PvsCeg/xWDUCohoteJ1PQJ7MP7gxaESCbiTuauGdZCUkevM7kUQqwKxL8ShyD7fp0GX+Wic7a1waI2VUraBsFa4aCzJMx1AmXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EnKwytHu2GFyJjYrq3/2clCyikneJ/jCMObW5Ey3zA4=;
 b=IkT0d0c+Rc3QLvykhQhHpW+NR14WJjzjDo/BmYl/h9k+biKYV00JZ0p++he1jK1HYLYoKa0KBfoIKaBA3Y6JF4e8svC3w8xG7iTSz5jJAl/pEZVzPGTrxNpUDOr2l9SXAbjUu1zAXSq6ApvkEVNUUxZK4sEEb4hW/uC+dxjHgRo=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7501.namprd04.prod.outlook.com (2603:10b6:a03:321::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.18; Fri, 4 Dec
 2020 03:13:40 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4%7]) with mapi id 15.20.3611.031; Fri, 4 Dec 2020
 03:13:40 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V4 2/9] nvmet: add ZNS support for bdev-ns
Thread-Topic: [PATCH V4 2/9] nvmet: add ZNS support for bdev-ns
Thread-Index: AQHWyHOfj2jsXGog0ESuEo0VpGL9vg==
Date: Fri, 4 Dec 2020 03:13:40 +0000
Message-ID: <BYAPR04MB4965E50D3DCEFE4A0970631286F10@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20201202062227.9826-1-chaitanya.kulkarni@wdc.com>
 <20201202062227.9826-3-chaitanya.kulkarni@wdc.com>
 <20201202090715.GA2952@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 84d62dbc-36ab-48bb-7055-08d89802998f
x-ms-traffictypediagnostic: SJ0PR04MB7501:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR04MB7501CC823AB0D02718FCF35286F10@SJ0PR04MB7501.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7/rzL8ypkHTT3FHFEmoiY3/dXnplffReKdRNONbUBLgBQAZNu6O2KZ9ZsoDdqX1tpkNlQCM7kWLOVwf9lz9SgT5bxIyVBa/MoNRwAvFm4OhgqA+PKcfgL40Dgjx47gvWI1hQMQ7WRNLIIB8Cm6mb2Qi5ImsF0vAg7j7id1tzrzFjzgqSL1dpqMLk5sdIFUDjBy2cG6SgMeh7jg73XnmaOjsvplTlBH7YozsDVAV4kGyNm8YwLrZhkSUyJNqCk+CDgpD9dZunOxenLV5aNb7x+zFs0WUCabDqEB3CiiH7x80GpgPGPhnr54LpE0jOXUcTe3kFdPWCM9XDmqic/psgbw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(366004)(136003)(396003)(39860400002)(316002)(4326008)(76116006)(66476007)(7696005)(66556008)(64756008)(66946007)(66446008)(9686003)(71200400001)(6506007)(54906003)(53546011)(83380400001)(8936002)(52536014)(2906002)(186003)(86362001)(55016002)(478600001)(5660300002)(26005)(33656002)(6916009)(8676002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?DrHO1W4RsZFNE/Iw79BARjBr8tBU1yXQUXVDDzG+tOvp6CY44hksA7h+ya7W?=
 =?us-ascii?Q?9+rgL658UqyHpJOYhJbFuthX8c6rqXBitNceMZLrh4rfLA9Gtbgq/xH6wFSm?=
 =?us-ascii?Q?crvT4IDuyCr7syyZOlN3KiHWlIMj1FeHtCPikprFAQzE7trkXc1QzLYXHeOg?=
 =?us-ascii?Q?Pj55n+87u3ffq2kP8xdDSpTzOX3KJnyktHsI/9SONdmQrNNXWtrAf4sTrZFt?=
 =?us-ascii?Q?zEUvQY9HDUTTzD7ZY01ev9mgr8desBayRux7rXFgyGRtS90SOvyO8gxSeZ7t?=
 =?us-ascii?Q?2pGK3Y4QBi+39AfG+NCVmR9JezuKoQbM0wg+GoTxcXEHmpp2oulWmIhNIY6I?=
 =?us-ascii?Q?bvOXKWGt92/Y/oYd/oSihyFzOhqkcKK3RZ6PsIwlPhYrGTfxQFusNImndhOn?=
 =?us-ascii?Q?vna5CFhNpJ5iN+AlJGSM5oAy0M5O7QBViAx2mHeh4hqbylxXtTtWGbL8gZ9n?=
 =?us-ascii?Q?iTLgjY33mRDLWzTnJ7vh58a3KkY+W90all/nxLue2mJWzr8nEHqEkNxrbrYY?=
 =?us-ascii?Q?7vrYRu9dc0R99KOl3iQ3kZZ0vcQj68xeiAlOlzY4OZRvqCZECsyHnDFhufVP?=
 =?us-ascii?Q?yBLsAPAqTNjBlAirf+23Pn+pe1sFB/uwsCPia4T5q9N2bqKTzp0s+NQtntt4?=
 =?us-ascii?Q?x38gbX2x7yUZyj+1VX83cItKumofw6Etk/HuMR/lRZQXaf3IQhkqdmO35vFV?=
 =?us-ascii?Q?IO6nGgsHK/o8YnXI9riILglZbAcgeLM+XxUe5aoPaH6mzkioBP0mJEigvwqs?=
 =?us-ascii?Q?I7I2t5G+58qs2+zsbrv4uTpoztR28PR33Yv8gho4X2O/8ACyMt2F+Vbq28Cq?=
 =?us-ascii?Q?WkBDhIKkbjCUQKAd4Tsgxbbt/V5Qfi1FQZpCyXlDbqZM2d2AJ4vyjCnkxR9h?=
 =?us-ascii?Q?Arh7E+hYIflVyxHgWkdo7w2lX/tZSVb/hw75rSjFZT2vmxH+/G97ZBNoen2v?=
 =?us-ascii?Q?rppSGutGb+K6yMqGoiqCF2Mi5GmOfitQ+wQ/aRkt075mMHYxBPJk3mOj/yND?=
 =?us-ascii?Q?q/Tk?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84d62dbc-36ab-48bb-7055-08d89802998f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2020 03:13:40.5666 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CMHEpIxZQXbfhsn/g+1dHNJmxdpa/uPcbaekVR4IKQd2ulGgIVHjyuYYVsM8DwdZH5dqKWJ6t3d0rtCgRKgB+A+Xuuqab/MLz4QaOhUp3WM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7501
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201203_221346_224441_1188E3BA 
X-CRM114-Status: GOOD (  31.50  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 12/2/20 01:07, Christoph Hellwig wrote:
> On Tue, Dec 01, 2020 at 10:22:20PM -0800, Chaitanya Kulkarni wrote:
>> Add zns-bdev-config, id-ctrl, id-ns, zns-cmd-effects, zone-mgmt-send,
>> zone-mgmt-recv and zone-append handlers
> If you think you need to speel out command please do so as in the spec
> instead of uisng strange abbreviations.
>
> That being said the commit log should document the why and the overall
> architecture considerations, not low-level details like this.

The commit log is really bad, let me rewrite in a more meaningful way.

>
>> +#ifdef CONFIG_BLK_DEV_ZONED
>> +	struct nvme_id_ns_zns	id_zns;
>> +	unsigned int		zasl;
>> +#endif
> This wastes a lot of space for all normal non-zns uses.  Please have some
> sort of private data field that zns can use.  Why do we even need to store
> the whole data structure instead of the few native format fields we need?
No need, this should use the fields than data structure.
>>  static inline struct nvmet_ns *to_nvmet_ns(struct config_item *item)
>> @@ -251,6 +255,10 @@ struct nvmet_subsys {
>>  	unsigned int		admin_timeout;
>>  	unsigned int		io_timeout;
>>  #endif /* CONFIG_NVME_TARGET_PASSTHRU */
>> +
>> +#ifdef CONFIG_BLK_DEV_ZONED
>> +	struct nvme_id_ctrl_zns	id_ctrl_zns;
>> +#endif
> Same here.
Yep.
>
>> +#define NVMET_MPSMIN_SHIFT	12
> Needs some documentation on the why.
Okay.
>> +static inline struct block_device *nvmet_bdev(struct nvmet_req *req)
>> +{
>> +	return req->ns->bdev;
>> +}
> I don't really see the point of this helper.
Okay, I'll remove it.
>> +/*
>> + *  ZNS related command implementation and helpers.
>> + */
>> +
>> +u16 nvmet_process_zns_cis(struct nvmet_req *req, off_t *off)
>> +{
>> +	u16 nvme_cis_zns = NVME_CSI_ZNS;
>> +
>> +	if (!bdev_is_zoned(nvmet_bdev(req)))
>> +		return NVME_SC_SUCCESS;
>> +
>> +	return nvmet_copy_ns_identifier(req, NVME_NIDT_CSI, NVME_NIDT_CSI_LEN,
>> +					&nvme_cis_zns, off);
>> +}
> This looks weird.  We can want to support the command set identifier in
> general, so this should go into common code, and just look up the command
> set identifier in the nvmet_ns structure.

ZNS is the only user for this, so I've added to the zns code. I'll move to

admin-cmd.

>> +void nvmet_zns_add_cmd_effects(struct nvme_effects_log *log)
>> +{
>> +	log->iocs[nvme_cmd_zone_append]		= cpu_to_le32(1 << 0);
>> +	log->iocs[nvme_cmd_zone_mgmt_send]	= cpu_to_le32(1 << 0);
>> +	log->iocs[nvme_cmd_zone_mgmt_recv]	= cpu_to_le32(1 << 0);
>> +}
> Just add this to the caller under an if.  For the if a helper that checks
> IS_ENABLED() and the csi would be useful.
Okay.
>> +
>> +static inline bool nvmet_bdev_validate_zns_zones(struct nvmet_ns *ns)
>> +{
>> +	if (ns->bdev->bd_disk->queue->conv_zones_bitmap) {
>> +		pr_err("block devices with conventional zones are not supported.");
>> +		return false;
>> +	}
>> +
>> +	return !(get_capacity(ns->bdev->bd_disk) &
>> +			(bdev_zone_sectors(ns->bdev) - 1));
>> +}
> I think this should be open coded in the caller.
>
Okay.
>> +static inline u8 nvmet_zasl(unsigned int zone_append_sects)
>> +{
>> +	/*
>> +	 * Zone Append Size Limit is the value experessed in the units
>> +	 * of minimum memory page size (i.e. 12) and is reported power of 2.
>> +	 */
>> +	return ilog2((zone_append_sects << 9) >> NVMET_MPSMIN_SHIFT);
>> +}
>> +
>> +static inline void nvmet_zns_update_zasl(struct nvmet_ns *ns)
>> +{
>> +	struct request_queue *q = ns->bdev->bd_disk->queue;
>> +	struct nvmet_ns *ins;
>> +	unsigned long idx;
>> +	u8 min_zasl;
>> +
>> +	/*
>> +	 * Calculate new ctrl->zasl value when enabling the new ns. This value
>> +	 * has to be the minimum of the max_zone_append values from available
>> +	 * namespaces.
>> +	 */
>> +	min_zasl = ns->zasl = nvmet_zasl(queue_max_zone_append_sectors(q));
>> +
>> +	xa_for_each(&(ns->subsys->namespaces), idx, ins) {
>> +		struct request_queue *iq = ins->bdev->bd_disk->queue;
>> +		unsigned int imax_za_sects = queue_max_zone_append_sectors(iq);
>> +		u8 izasl = nvmet_zasl(imax_za_sects);
>> +
>> +		if (!bdev_is_zoned(ins->bdev))
>> +			continue;
>> +
>> +		min_zasl = min_zasl > izasl ? izasl : min_zasl;
>> +	}
>> +
>> +	ns->subsys->id_ctrl_zns.zasl = min_zasl;
>> +}
> This will change the limit when a new namespaces is added.  I think we need
> to just pick the value of the first namespaces and refuse adding a new
> one if the limit is lower to not completely break hosts.

But that will force users to add ns with highest zasl first no matter what.

Isn't there should be a way to update the host with async event

so that host can refresh the ctrl->zasl when ns addition async notification

is generated ?

>> +void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
> This whole function looks weird.  I'd expect that we mostly (if not
> entirely) reuse nvmet_bdev_execute_rw, just using bio_add_hw_page
> instead of bio_add_page and setting up the proper op field.

that was the initial choice, please see the reply to the your comment

on the first patch.

>> +#else  /* CONFIG_BLK_DEV_ZONED */
> We really do try to avoid these kinds of ifdefs in .c files.  Either
> put the stubs inline into the header, of use IS_ENABLED() magic in
> the callers.  In this case I think the new helper I mentioned above
> which checks IS_ENABLED + the csi seems like the right way.
>
With addition of the these empty stubs these functions are getting added

to all the transport code which has nothing to with the backend that felt

wrong to me. But if you are okay with that I'll make this change.




_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
