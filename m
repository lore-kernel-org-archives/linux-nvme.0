Return-Path: <SRS0=0+fG=2Y=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2895BC2D0CE
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Jan 2020 06:16:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCE59217F4
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Jan 2020 06:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WDTxYqru";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KIsNqote";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Dgm0KCAQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCE59217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=xnLgzR/s8R2WkLRbVbHaeZc+r9X6L0fV4uDdnxCWYkU=; b=WDTxYqruYK3N9o
	aG7P4xVZTMPLqil87fQOamQv6JmipWVYNmOtLJABM6nQvwtq0Shbkw6V0FHYZGi0eyhL+PqIDjyzd
	1AzRUGLewsvFLma+sqhYtezgKNtpX/aSwZ/oolUEKOVu8/jOCVCsb38Mi7BkdbvWFldw3sLeFoUth
	sqM8pHOlx3CNtofqeRTFuFmoFzSMM4tEA6bl2UdfbbzWTCU0JG/zhF3si86SeSjiBYp0F9/lOEk4g
	ocgxRDeJCXWkYOZSkY7QxXl13V7+sg5PhcHj8syoMnn0Gw7OmF8I6s61rqVRJ9s24UBwvmyuEn+Tv
	TFahsv0ZTsJS54h6NPrA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1inGGR-0005dL-CR; Fri, 03 Jan 2020 06:16:51 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1inGGO-0005c1-8M
 for linux-nvme@lists.infradead.org; Fri, 03 Jan 2020 06:16:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1578032209; x=1609568209;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=3BykkbwY0/+hWZ1HCPfrTm7/hx4CMew5HKiNlOeHEQ4=;
 b=KIsNqote0znz3SGr1pWEDNJvY8AgAshSBeaTnhf7nUiik2CdsNK9lZgj
 ncbmR9MCdgj4Dl56l2pUbrhPQQg+nLNjW+roCLu1CXNP6xvtDsEBDoFl7
 r/MUu72DyAxP+pj0ImVyC95I1zGS+BRpkViv5943sNx58qHzEn6WVpTvL
 a1WWzs1otw8rsEnz9O89sfzwno+aldkKv3MaPUQkLamJ0Vu3nlRf6d4UJ
 tfBGA4AUQmhHJ+lRr837bAxKNkSGW3hcG8WnwGWYz6fels7L4nK2boZcd
 231x9OTvH4AiA3+vT16bKrFw/MkdlIfwExhUILgOCKZ26GpsoL+cmhbrU w==;
IronPort-SDR: BAQUOTBsbivz+hOSvQIkiE0F2giY4ePtjLtw5YXtoBL3uh7gaLv/4mzrQviGt6H5Qc09VMm7cP
 xQ9RtbYa29K0U2CMdgCoNSjX+NRefWtwfNWVYMC6OeOH4CzcwfU9FUSi+HiLieMW7au4boFSyT
 2spNgk6m07S+kQbkaeNP0bZp/PnO+NzHXNS/a8hakvVkCO4A/lDkKKeRgv9c5Vu6wZi3e5v3Xg
 rRIWZHNsv1KaXGsa4rNhCT6ICOi1nfDcsEgsFHXDocxesJevQ/GT2GclYts3XDzsK4FDzKRHxz
 MyM=
X-IronPort-AV: E=Sophos;i="5.69,389,1571673600"; d="scan'208";a="128216119"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO
 NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
 by ob1.hgst.iphmx.com with ESMTP; 03 Jan 2020 14:16:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ctmKqQLU3VtWwWyfL+5J/UDY9BFVxWWJBYBZrSwiuiXK+L5mwiU29vqi7xpABp2vQPiaU4pE9VqvI8jKhgvpIpnq7vv2JDLfGbFJCItsa/4UN8ZWpYAkvkFwiYYfc+Ka0ONU78pe9W3xkqWUAcRx2cjRzACHqdQSj/89hd/IUEPg+2E+BHeNXfQgUvgLTmp0yOdOvvjD2G0rqQH4zh2ww4Md1BAnqUBv1tYh0R0XXaM/L04jE7wP/EqwVGY/nkb738qPgsFMApveeZruq3aun2r4Sx6U2BsmQxhhLAWq1Bod2GWsTi9rr1mD13hWDfrxphdpppSk0u7iCH/Cw124sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFTSLtxL+pKEKPF8QYG5iILAJFh5HqZfhjwpw7QV/IE=;
 b=EuUNViihD96HPgeX5y+k1Q1V38Ztor9oNDfbekIGVpuWy+wur2jHESThfQr0BN2WB7R9eWWNVeLth8n+wiLoGje+KebAC9wZJUu60yeV0Pce8+7+NnfWz3f1UhtqvGZgKBDgte8bGWKq4FEG+Lxgm1y5WBKLxjvedGSxI7U3Sqav2/kB92gk8psNHK3l0gu3mS2am15jvu2gCI6sQ4jVWEBllGq5Ken2KAvVsmv8+lLQUs8E84DuSUkrdWtQku0CmgRN9DzsKEE4Lb+Ks2Jo8/hMA/gPcNVxCsHijHOVcCdwv2lykLCwhI2OWcEglp8CGe2zS3PQvi5KweM0jInjNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFTSLtxL+pKEKPF8QYG5iILAJFh5HqZfhjwpw7QV/IE=;
 b=Dgm0KCAQwlKgFTZk+Z+F59q1B4IByuL8OOreCX1YuID9IEMGowUBXHHXVeAFC0uczTVAwyKXXwTPWkA0tZ921QFk+/De9cLo1r08OhauUwakqxAYaEC31b2nph9kexZHwX7RwjUzEGMjXU3LRpoVk02os1Z6SfiIY/PTJ4bN1wE=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB6088.namprd04.prod.outlook.com (20.178.234.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12; Fri, 3 Jan 2020 06:16:39 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f%5]) with mapi id 15.20.2602.010; Fri, 3 Jan 2020
 06:16:39 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Balbir Singh <sblbir@amazon.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [resend v1 1/5] block/genhd: Notify udev about capacity change
Thread-Topic: [resend v1 1/5] block/genhd: Notify udev about capacity change
Thread-Index: AQHVwUG9qzxAaxFzwka5YkVHh6Dxxg==
Date: Fri, 3 Jan 2020 06:16:39 +0000
Message-ID: <BYAPR04MB5749EE1549B30FCECEC1154B86230@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20200102075315.22652-1-sblbir@amazon.com>
 <20200102075315.22652-2-sblbir@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 266f1800-e0c7-4fa3-7e22-08d790147ed5
x-ms-traffictypediagnostic: BYAPR04MB6088:
x-microsoft-antispam-prvs: <BYAPR04MB60882842113B8F114D2B325086230@BYAPR04MB6088.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0271483E06
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(39860400002)(366004)(396003)(136003)(376002)(189003)(199004)(55016002)(81156014)(81166006)(33656002)(4326008)(478600001)(9686003)(8936002)(8676002)(26005)(71200400001)(5660300002)(66946007)(186003)(66476007)(66556008)(64756008)(52536014)(66446008)(2906002)(7696005)(53546011)(6506007)(54906003)(76116006)(316002)(110136005)(86362001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB6088;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S02XEImNXratMrw4kJxuKj8f5tIwFjC/bDYtasryNxVaOFF4TS1l9EPs4OrqYOTQbQRdtDfgVDQ/FI46Lwtc4M9ls4kQXirSPmsFTpmef9OItTI3mBSwHy0M4ryZu9+P1aqHXvZWvnKmMWPufk99ZB7KCBtDP8tptwNSZkd6tzbDIbYm2rlORoXnSWV5kVkMWIlmBb7A4MKbj+JFFJg3Y7R2YYBW1YJJkZNFQ+aFvFLFGIqV1scLywqZyInJVtEaD9kswvGit49rFeLPyBADIREE/nxhvZyuaiMISHjM164ghdR9tQ4XjGQLDDEe+mbdpFA57pWmMC27WWQt6N6SrEfMZHCac9HoxU8DPhd4WdFzO651lmla2Gn4CqQIw+/hRajystC6DzkbGe3SRK0NoxJCpwGuKblgJzHaUedWByphZs8HFFvYw5E9htUFHWgr
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 266f1800-e0c7-4fa3-7e22-08d790147ed5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2020 06:16:39.6961 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BJSzvi4TeV5gwBjkoTJ5icjd8Ssy+mEpIkXgYVmGpqol6hT0iVBy2MzOCtpXEf12EVRWfbQ8j0Xp6T1K3vIdFaLDfLsmrrmCjc+jXmknalw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6088
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200102_221648_353706_D6037928 
X-CRM114-Status: GOOD (  13.38  )
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
 "ssomesh@amazon.com" <ssomesh@amazon.com>,
 "jejb@linux.ibm.com" <jejb@linux.ibm.com>, "hch@lst.de" <hch@lst.de>,
 "mst@redhat.com" <mst@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 01/01/2020 11:53 PM, Balbir Singh wrote:
> Allow block/genhd to notify user space (via udev) about disk size changes
> using a new helper disk_set_capacity(), which is a wrapper on top
> of set_capacity(). disk_set_capacity() will only notify via udev if
> the current capacity or the target capacity is not zero.
>
> Suggested-by: Christoph Hellwig<hch@lst.de>
> Signed-off-by: Someswarudu Sangaraju<ssomesh@amazon.com>
> Signed-off-by: Balbir Singh<sblbir@amazon.com>
> ---

Since disk_set_capacity(() is on the same line as set_capacity()
we should follow the same convention, which is :-

1. Avoid exporting symbol.
2. Mark new function in-line.

Unless there is a very specific reason for breaking the pattern.

Why not this (totally untested but easy convey above comment)
on the top of this patch ?

# git diff
diff --git a/block/genhd.c b/block/genhd.c
index 94faec98607b..ff6268970ddc 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -46,25 +46,6 @@ static void disk_add_events(struct gendisk *disk);
  static void disk_del_events(struct gendisk *disk);
  static void disk_release_events(struct gendisk *disk);

-/*
- * Set disk capacity and notify if the size is not currently
- * zero and will not be set to zero
- */
-void disk_set_capacity(struct gendisk *disk, sector_t size)
-{
-       sector_t capacity = get_capacity(disk);
-
-       set_capacity(disk, size);
-       if (capacity != 0 && size != 0) {
-               char *envp[] = { "RESIZE=1", NULL };
-
-               kobject_uevent_env(&disk_to_dev(disk)->kobj, 
KOBJ_CHANGE, envp);
-       }
-}
-
-EXPORT_SYMBOL_GPL(disk_set_capacity);
-
-
  void part_inc_in_flight(struct request_queue *q, struct hd_struct 
*part, int rw)
  {
         if (queue_is_mq(q))
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index d5e87d7cc357..5e595a28f893 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -469,6 +469,22 @@ static inline void set_capacity(struct gendisk 
*disk, sector_t size)
         disk->part0.nr_sects = size;
  }

+/*
+ * Set disk capacity and notify if the size is not currently
+ * zero and will not be set to zero
+ */
+static inline void disk_set_capacity(struct gendisk *disk, sector_t size)
+{
+       sector_t capacity = get_capacity(disk);
+
+       set_capacity(disk, size);
+       if (capacity != 0 && size != 0) {
+               char *envp[] = { "RESIZE=1", NULL };
+
+               kobject_uevent_env(&disk_to_dev(disk)->kobj, 
KOBJ_CHANGE, envp);
+       }
+}
+
  #ifdef CONFIG_SOLARIS_X86_PARTITION



_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
