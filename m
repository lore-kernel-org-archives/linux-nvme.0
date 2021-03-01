Return-Path: <SRS0=Uoxm=H7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66EEDC433DB
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Mar 2021 15:39:49 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05DA864E01
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Mar 2021 15:39:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05DA864E01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=netapp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=T5MOZxzyRxsKdhf2Y+5QzBDBLqCQ2r5geEdehVuOrg8=; b=dj9pXEh1UQb4NjXitN5QxiLT1
	vSTmk6DnbnD1oM8Bag9jnc49MoPhNx6pvgulWu0PGWQbvtIV09rhbehABMRjUnGvp8zP9b1c+KKMs
	xBAJfGnFfJikV44O7Rz51FtKUOWVigEfNF0LqWAPrDsmpdmzd2Ie2BbIxX2kByqLBTX/DOaY7Qy1X
	NsucOD9x8vr4fUicvjvdR0Y+NFgFQ89BQWGUf8YhkoP3RiKRyi835gjpuz/hemYOsEk1ZkTQlAUcI
	FkI8S4wC3Fs+fJSwxsuKqc6ONFgAn0a/DQ/zeQTWMuA+um3mHpFaKnGtQgXWbxDGXbSckvpcD0OPy
	7A5Uaqhow==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lGkdz-0004xA-J0; Mon, 01 Mar 2021 15:39:35 +0000
Received: from mail-eopbgr770045.outbound.protection.outlook.com
 ([40.107.77.45] helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lGkdu-0004wE-WA
 for linux-nvme@lists.infradead.org; Mon, 01 Mar 2021 15:39:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CkOAEVI6GfV8binGWhXpKR1no8mxtPP+gxaEUn34GzBqPtT4Eo9eAMeF9oT8hRGc/o3eeCXUBlVdVNn7e+S6kb8t7EmsNBjvuFxjg16980kZYGBA8SD0OUNvV3zzPjvsrrgwGvYd2Ox30WNM323XD/hlBEm0vqR6YDQxWI6+5TZmJ6Uewb1r8k4g3O8PLjlPOVdOYsE0ExcRJUPTjYmC3+RMH9tolSk5s1u2weOo+9JIm2xEPvLsyGOrsyJDOP+jRUTdJB7BtwlHIOcEyvI7DsH29gEZsail4+PL7uky3xnJlm3RpqV0bFs4THTrC8y9yI5JD6WBGhJs/dAxefl1pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQ9FseCAp/DXq1ATRh8hNd8PB/xmr49ET4oghmnUhnc=;
 b=ZzoA+Z9+b5EjmgxlLek5UqWKJpECXp9vsR3560wXK1kg3c1gl2u4SyQ6zvRGAqZBUqbibL4N3pOCWP48EaW3t0zV4A7XoSYmJ+B0aJm4ZlXzRrYbdkbBLXGKMg4UIk98VzE54Jwh7WQaJw6bVPdlCSuSoSuFt03ySDnl2zPiBQs9Q9ZFJamaX65rq+3UrmPuHjExq4va/BXwBj4h2x2STPKOUbdC9spoA1DyqdjL19WMm8bqLjTbuBRheR50QV4sfB9cUI3d8kSZ9DMTvThwIaJHdkxmUuw0ILPAkHpTQ5E2QgNR7kb2VFeplWU9v0K/LfE4C5UMz0SKuFO+YZgEGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netapp.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQ9FseCAp/DXq1ATRh8hNd8PB/xmr49ET4oghmnUhnc=;
 b=Lw9CgCSDVRJeAII7oIqV+pd4BRfqYruziBZg/fHHFCEUXNQ1Rle+XGhureQjhu/gO+6zb0sUNbRfSDdKpE2Joq6oyKD5vEp24FBJjICeHeHC4h1w++WIMBjqRPduN/iVAlAbE9uE3m1VBmI4Z7F+XEwimqBqqGRAaxEDgtLT36Qd2Y4C3KKmyd/M0ionDPjSWVFMOinCL1FLIAIuMB10OOnfg8QcqrUXvsPJOrpJnjnhbQCAgdGSHj1GfxCbhyGA+k7YvESfn0DKckSQeb8pvuGDjSvbR+7EBsTxdub1icK3mV+yCJtTy31iPdcGMrai2CBnEuLLvFua7P1f+Fud3w==
Received: from DM6PR06MB4634.namprd06.prod.outlook.com (2603:10b6:5:ff::25) by
 DM6PR06MB4364.namprd06.prod.outlook.com (2603:10b6:5:22::31) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.26; Mon, 1 Mar 2021 15:39:24 +0000
Received: from DM6PR06MB4634.namprd06.prod.outlook.com
 ([fe80::59f8:5b0e:ed9f:2998]) by DM6PR06MB4634.namprd06.prod.outlook.com
 ([fe80::59f8:5b0e:ed9f:2998%6]) with mapi id 15.20.3868.033; Mon, 1 Mar 2021
 15:39:24 +0000
From: "George, Martin" <Martin.George@netapp.com>
To: "hare@suse.de" <hare@suse.de>, "keith.busch@wdc.com" <keith.busch@wdc.com>
Subject: Re: [PATCH] nvme: add 'kato' sysfs attribute
Thread-Topic: [PATCH] nvme: add 'kato' sysfs attribute
Thread-Index: AQHXDBRomE4y/WIDh0+Z16MithXtm6pvSfEA
Date: Mon, 1 Mar 2021 15:39:23 +0000
Message-ID: <07b463679c97dd9e352530cfb5751c3e9a247f2b.camel@netapp.com>
References: <20210226075251.108025-1-hare@suse.de>
In-Reply-To: <20210226075251.108025-1-hare@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.4-0ubuntu1 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=netapp.com;
x-originating-ip: [202.3.121.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cf2922c6-fc58-4bad-d300-08d8dcc8309e
x-ms-traffictypediagnostic: DM6PR06MB4364:
x-microsoft-antispam-prvs: <DM6PR06MB43647515A69A5CE8C64848B4959A9@DM6PR06MB4364.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ICSo7gNOB7JdqpgBwZ79qsJFxRFaOK/Ktywd3FhxoDf+PbG+aHW66dYjJcMoZuwGA9OZ/DnwsLC79JYtrjYZ7+FJsW7RggoQndrXfL9Ihv39vxlLJpVvVMEknIIGofqxJS7p9lvTApjLVtm+GYwuR/0pfsAzKbbKCbDxFoRK+Vgz0l7Ns5KmhLP0NPZ2ZyyMmZEOEnhPw9F4qK8+FYvEqMsHRMfRg+l8BqnuTDb3VcQOU4AtvmIw6drEtSmrIcZ3DRGHEtBG6h6YUuyxreCLy3ef2GfFr/Hr2oDpTHbGKM1Y6PPfGEQmo/l/Hxi/LERzhU8edkZTlVt4fne2kFhW7xj+jwSaqodGoqToQISQMsI5kEKje9ruZdVJEOWqUphgtB6r41u084Nxuzxw3Jg94gffNhPW7iIfECU/mysfYZznzvF5KSU4bfyiSx3pQ2+fkbpUr18BgzfoHHu8XyC9218Tm32UoiCEnQMlMhcezuxM7y5WDIpmtJcUaywVUSoV549YoDuUWk0KY/Sy9tbEUQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR06MB4634.namprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(396003)(346002)(39860400002)(376002)(66446008)(83380400001)(316002)(64756008)(76116006)(6512007)(91956017)(66946007)(66476007)(2616005)(4326008)(66556008)(478600001)(5660300002)(110136005)(54906003)(6506007)(26005)(6486002)(8676002)(2906002)(36756003)(71200400001)(186003)(86362001)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?dzdueVZ3TjNmekVndTZSK2dNQ3RtM0dabjErSzY5cEFYWmJjNzhHdXlWS0pa?=
 =?utf-8?B?b2lKaGtzKzU1YXlvZTY3OHdXcWtqUVNHRkI2Ny85YmpxMnhXd3dNSEFCL0RX?=
 =?utf-8?B?dFN3ckxwZWJxSDdGNEFHTGovOTlZRmc2c25NekdiaS8rdVZNWWV1WFVXSmY1?=
 =?utf-8?B?dloxQm5GWmNkdUluSFVDUTF5V0VZVnRyZTd4cisybTM0RXFyUDlsMnBOdEQr?=
 =?utf-8?B?b2owZEpwYUU2RXo1dGNISE9UbytzeXZzamo3cVNiVnBnYzB6UDc3d24rNG9y?=
 =?utf-8?B?K25EdjAvdG5ORmkvR1c4Tm4rVUhrTFNXak5ic0F1dVd4Y0J5dllrcnNVSktw?=
 =?utf-8?B?R3hCbjdiYzVlZXEzZU8yN05xNGQxQzMzN1JPMi9iZUxIdG9vK1lJcHRON0Zw?=
 =?utf-8?B?S05hakRZQ1dMYmd1dzFtaUt4TzE1dWpYZXZiejV3Mm5kTVVOM2xOeTlLQlFH?=
 =?utf-8?B?cG93VU9tZ0FBOWg0Q3ZZVlhRYzdzendQUjJ5QlhHczlUUW1YM281aUUxdjVm?=
 =?utf-8?B?RkRFWm0zb05ETXh5cW1nY1BqcDF3ZmYzYllhSWE4K2kxcGpheWRHR3pDbVY0?=
 =?utf-8?B?V2R5SjQ0S1FNcmhuaXRiUFB4Sy8zVFFqUm5JekRPRnFtS3hFZW9WM2hkVkQz?=
 =?utf-8?B?azcvQ2l6ejVtOUlxRkNXVklBZ0QxU1Nxd0lSZDNid0R4OVp2UXNCSC8wcHRT?=
 =?utf-8?B?RjFCaG9TcXFTdzYzalpiQUdFOEZKOUtvUDE4Lzd6aFU5NWpFSGVmTUV6VXh3?=
 =?utf-8?B?aDk2TzlPaTJCTHc3cWUwYXlsbGNtd1BidmRHZWhhcE1zUXZETTFETWtGV2dp?=
 =?utf-8?B?MzhSVkF1dSttbzhoSkRiU2tPcW9kc2l5dlpIdW54aTVWazduM2pjSmVpc2pl?=
 =?utf-8?B?ZmpBcjJVSzU4WENUVVJkZENVbXI0aGZDOVRjM09KcEo2aVh0bVZOc2tHZFJL?=
 =?utf-8?B?dlNEb0FhQ2lEbk5jc1dKcWpvbzMrWmdhNHdzNmVGbERRMjZEbjBwcitCVEJO?=
 =?utf-8?B?azBvZzk3UUtCeUJYcjhhWUVtazNlei9SaUZHYyswZzNKd2NEeTBNN0FiSWxu?=
 =?utf-8?B?TW1vbElCbG5IWUV4R1NzRXhkdGg5WjRZRDFpY3loanhzZDV1NGJBNXN6TmNQ?=
 =?utf-8?B?anFsU281cmV3LzRMZTdYejJLMVhMN3BNR1RmajYzUUdyVHRPOW9wak5BN2RK?=
 =?utf-8?B?RVNIWWlycitHSDRacURMSHlDQlpnVDRFZnRuWkdxcjBPUTRPUGdER0VvLy9K?=
 =?utf-8?B?VXlVQzJhVStValhSMTFpKzBnWlQzVUZYejhROFgyL05qU3lheGQyWTRNT1NG?=
 =?utf-8?B?S2RtUVNPRE5WVUg0TWE0bmpkd3Q5bWlQRE9YUWg3M29jVlJnRU4rVjhnSDZr?=
 =?utf-8?B?Z2NxQ2x3QURKbE4wQTZhVmRmVitaUGMwTEZ0M0JMWnB5VFQ0d2VWc1hFaWFB?=
 =?utf-8?B?NWpTNis0cEIySjJCN2ZRKzFTZkRaSWRMZEdBR1JRMzZ1akdYUkVZb1pIdmNu?=
 =?utf-8?B?ekh3bmdPOTBQT0dreU10K2JweDV2aEYrQlZXSHJKQi9XdlBFSVpUbmt1SGhx?=
 =?utf-8?B?eGRvdnVuQkZNOXBEM253WkorSkpiNmE2dkMwbU1qZC8xbWtaWVVhSDdUbFVm?=
 =?utf-8?B?ejlJZkkxYStFejY1R2tmWnhPc3lVdy9qRHNJS2xwMXZVMVFValBmeGYzMGhx?=
 =?utf-8?B?N1RMazN5cGtrblpQMjkzL3k5WFlqd01uNmlHZ2xrMWZxN0NmZUJjUTdHd2JT?=
 =?utf-8?Q?+fo7wm8bXpN/J3IiijMQX0FhtuDnclSBcps+cTI?=
x-ms-exchange-transport-forked: True
Content-ID: <DAC8283AD1903A40B540E87FACF5138C@namprd06.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR06MB4634.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf2922c6-fc58-4bad-d300-08d8dcc8309e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2021 15:39:23.9230 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NMyIR16Q4WSXiRBRpvYKl7m3yjBDBRmi55aV9cQSPkAo7Mz+Nigv/4zlG3B8CNsoKY8V3BlhMInkldBEZqmDdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB4364
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210301_103932_011449_DC61748F 
X-CRM114-Status: GOOD (  16.34  )
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
Cc: "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, 2021-02-26 at 08:52 +0100, Hannes Reinecke wrote:
> Add a 'kato' controller sysfs attribute to display the current
> keep-alive timeout value (if any). This allows userspace to identify
> persistent discovery controllers, as these will have a non-zero
> KATO value.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/nvme/host/core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 1d5fc8a6fd37..9ad23472ac15 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3547,6 +3547,7 @@ nvme_show_int_function(cntlid);
>  nvme_show_int_function(numa_node);
>  nvme_show_int_function(queue_count);
>  nvme_show_int_function(sqsize);
> +nvme_show_int_function(kato);
> 
>  static ssize_t nvme_sysfs_delete(struct device *dev,
>                                 struct device_attribute *attr, const
> char *buf,
> @@ -3749,6 +3750,7 @@ static struct attribute *nvme_dev_attrs[] = {
>         &dev_attr_ctrl_loss_tmo.attr,
>         &dev_attr_fast_io_fail_tmo.attr,
>         &dev_attr_reconnect_delay.attr,
> +       &dev_attr_kato.attr,
>         NULL
>  };
> 

This is helpful indeed. But looks like the actual kato value sent down
the wire is ctrl->kato + NVME_KATO_GRACE. Wondering if that may end up
confusing the end user.

-Martin
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
