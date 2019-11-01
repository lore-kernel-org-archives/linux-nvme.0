Return-Path: <SRS0=Vg0R=YZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4D2CA9EC9
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Nov 2019 06:35:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB0A8208E3
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Nov 2019 06:35:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tc5ksABP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZvqQEmED";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="KHxn9hU1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB0A8208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=w6bbSFtG2hoYLLi1Mitm9qH7g/989iD1vmui+VU2rYI=; b=tc5ksABPE8sj5a
	MkWFRWe1DeQ35yMSWcXiRtRdRABQr0AS1bh4Mgqs0cDu1iLSwIY5dm3Cj+htpe7h50Ji0x7DLNxdG
	rJgp3iGDjkoW6bcaLG8UF5xTyH3ajHNzZHPmA2TBIzWqX2+PelmojDbwTCtqM71w8jBwrefobsHxq
	5j7DyjJtfHRuPHBC2mKVlftWu1iyTA8gAWU9+z5DXP5lZUCj58rK1Uir0kh7dn+ILwRMFN1mCqMKl
	Ar3VeRudXhEbvKM3NK1GCJTPVKESs5WIBf7zZ2X7pyFT7tic1MDDw8ZtncjF2H1U++YwtMXVilB4n
	y/++Uy82mjLAmlMbIJLw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iQQX4-0000PI-5l; Fri, 01 Nov 2019 06:35:38 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iQQX0-0000Oj-3Y
 for linux-nvme@lists.infradead.org; Fri, 01 Nov 2019 06:35:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1572590134; x=1604126134;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=Fqb3MBeEkyir7HY4IPmAkoSnd+EltXEiq9+EzS20Wfw=;
 b=ZvqQEmEDISV7PzpC4LmV2Nlvhzz6MIj/qkkvn2VUWCoxoCWNDGOgeL/M
 Uez+hKvEutURVE1BZX1jP609ViYLqZRlNXt+jJC9O+Y6OfZB/fmS8EmlG
 mFgH8SL5Wi7eDM4Apm21httNqXUJQWecAvvXnuRBxWrsXo/Du1Zrj9221
 vjRKkgpvO/FD0tPRehAQdXPSPMcfAznkCdKdJH8TH9QR/Q2wuI5Q8yPMB
 vurK9czvcClsjlJGCwYc8KpDsCofZSs6Cb+cY/8qMcTpaQvfwaUM7q6O+
 UVeBFWkHyJ0tppsSUlAXFvxPrNEVVKGZ4p7apdI5kBjofk3QaxSerrXp7 w==;
IronPort-SDR: SAAqVyjBbl42+kMFqaUynysIkX5pOL9YF76v90MOZ4RUBYG2knqMhxJ/jtCfX7KiXMnph7E6B4
 trIHCnfPO0ShOwtC476MNnIv3UicLccl1cia6+z1ipRi4rNkT5/qLaN20aSAeSiYIBGMRPltHe
 ofFzmMehuW3BZlnVrLRsL2obhjbZ4zEqezAEDASk5zk/jBoKupiZpl1yY7LUeQYQc0cbLqEj72
 IDYqvcKR58jmNgTy0NPczp2DKmRCl43MLCd+iaGndHQacicbZMAvVAGKevwHtVn4+fuoBQP8cK
 9l0=
X-IronPort-AV: E=Sophos;i="5.68,254,1569254400"; d="scan'208";a="229053611"
Received: from mail-sn1nam02lp2059.outbound.protection.outlook.com (HELO
 NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.59])
 by ob1.hgst.iphmx.com with ESMTP; 01 Nov 2019 14:35:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I4b/sVEz5JWLIiqdkT4/DJPlNxltzY1fp0h5v/aJPspQ4wFw14nOQBCeMb687nkkGuXMVzbMuNgpTMUjQQrl2wfQ7r+OPEV8ktJqLRplQMYIR5JN7VIlE4C+ICH15tKQhi5zz3rTiawF7fcl89YpSCFbZwY9NAn2DzGOy84gRh7J4DdjqIplHcPWEdE4dPm4PQ1F4Vr2FFLXNnzncriLg53OTR6OnKVLP5/VTJUNK+rXvhH0+/CMfcgJCqsbRBfW/MZ9LxYxMoZp1IQaA1iETxBmvttewTFqs+g10uRYbL/LDFrQ6ejX9ZXUsgxVuv2UwV9ZMZdthYDKZ1PFS1EMug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ah/lorb4kJLAf9AU0oebPRKFm86YRAG4uknc4GQG5bY=;
 b=jbXcreoPz1sPWJgnveo5KZ0jeJtb20SuT63jyF7Mm6tjcE0Albxm4/ZDn5Sgj+ek+s+XJr8Nv1+iPufQePfmLlPDhUjRHt0viFpOZjRDFsD5QF86D7q86gZzRRuu2j9PJFFnPfoB+KxZndN1liV+ZM5IATjtD3AY/Dd3X/B0rAq2PxQQntW0mKCeW2GGmTEkNRECJ/re+60nFjtDIakcHxPXUdKlMG4PTDT3OccaH7u/YPiwJAYzRGXPn3asP15BCxrQUSkhxbfwuGZ/bogRI+OGY23AHez91EKTzWB6KCNzohrueZMSiBpzSNDHxQqb/KG0mSqDLajcz2Un9aNzyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ah/lorb4kJLAf9AU0oebPRKFm86YRAG4uknc4GQG5bY=;
 b=KHxn9hU1QYE5YutVJ+gPEiO1dLS/EfGHFy648Vr7JY+x3Q7+KIPvyXQJiHiTLkJ+6mhY+XYcrLinikGBUMXGtv8gQ0lQM7+muwN9Am750NbDBhTsWH0c23XFPovnGj/Nf3Gln7GKpU1cTwYj+n5RV58GB/2W9h1YCY8dO766b3Y=
Received: from DM6PR04MB5754.namprd04.prod.outlook.com (20.179.52.22) by
 DM6PR04MB4075.namprd04.prod.outlook.com (20.176.87.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Fri, 1 Nov 2019 06:35:29 +0000
Received: from DM6PR04MB5754.namprd04.prod.outlook.com
 ([fe80::65c4:52fd:1454:4b04]) by DM6PR04MB5754.namprd04.prod.outlook.com
 ([fe80::65c4:52fd:1454:4b04%7]) with mapi id 15.20.2408.016; Fri, 1 Nov 2019
 06:35:29 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvmet: allow block device to use buffered I/O
Thread-Topic: [PATCH] nvmet: allow block device to use buffered I/O
Thread-Index: AQHVjuMTkpKH7LTBv02BcTLV8YUdtA==
Date: Fri, 1 Nov 2019 06:35:29 +0000
Message-ID: <DM6PR04MB57546F751A33B58A4D2161A686620@DM6PR04MB5754.namprd04.prod.outlook.com>
References: <1572409583-3109-1-git-send-email-chaitanya.kulkarni@wdc.com>
 <20191031144531.GB6024@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: abb7a509-e87c-43e2-8c2d-08d75e95b040
x-ms-traffictypediagnostic: DM6PR04MB4075:
x-microsoft-antispam-prvs: <DM6PR04MB4075A71078135F8328C60B3D86620@DM6PR04MB4075.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 020877E0CB
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(136003)(346002)(39860400002)(376002)(366004)(396003)(199004)(189003)(99286004)(316002)(54906003)(446003)(6116002)(52536014)(6436002)(55016002)(53546011)(6506007)(76176011)(25786009)(478600001)(66556008)(3846002)(66066001)(66476007)(476003)(229853002)(6246003)(102836004)(86362001)(26005)(2906002)(4326008)(5660300002)(486006)(14454004)(9686003)(66946007)(8676002)(8936002)(76116006)(81156014)(14444005)(256004)(91956017)(186003)(81166006)(64756008)(66446008)(7736002)(6916009)(305945005)(74316002)(71190400001)(33656002)(71200400001)(7696005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM6PR04MB4075;
 H:DM6PR04MB5754.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IUolcPP0CWU+pfZk7RDvAFHr9xkgCs2dPrYUOcH/nQc5AEYiAi/5TBSAih9x7EyUxIM59FtNQ5VdOlypob4F29jJ1vear/QaOu+4+ByCHjzjXo9qJnFSX3mwP1Js5oclX6BW8O3xuprzTMLTQ4k4q5PtOQOm4BZ0H1vCb5kUQctjgbBvyiYrRaJA0dWh20YAfNdyvHSXq8+7Hn3pxZ31ddh3KAPuJp+1y9l8pNN1xrU/if4za3AkpXJQmSNJLkfNrROnIefF3SSSexHQO7y5d384UBPpDdlCNJEU8QObBW5VKL8WtULalZFRJYHOfRBxxevvoJRr8acMfRZVWr+MG0jD1VnGLtmEbr9zmeXMRw41IGN9Uz3DG6a/qwZwP4oeabhtPCOhQgajM8SCpl9YN72DBMbHVNyBizfOmVHwOpuMQG8lzUv2ZUN66IaZwCsX
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abb7a509-e87c-43e2-8c2d-08d75e95b040
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2019 06:35:29.2285 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7CtIhAPUKHjNh4Cb6WDbznXibnYkN3vH5ysse9GVZi63kVDX6sU2CI2GkzJUg6XzOAVZKuWfni1YhnC8cp2jLLxkhcHtXewvQMjkSoDmckM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4075
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191031_233534_227044_2EA308D1 
X-CRM114-Status: GOOD (  19.21  )
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
Cc: "kbusch@kernel.org" <kbusch@kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 10/31/2019 07:45 AM, Christoph Hellwig wrote:
> IFF we want to allow selecting the backend it should be a configfs
> file with the backend name, use_vfs is not very descriptive.  But I'm
> still not sure it is an all that useful feature.
>

Right now we don't have any caching support on the target side for
the block device backend. With this patch we can at least have
minimum caching support. Although, with this we are depending on the
page cache for performance, but it is still better than having
nothing.

For applications with datasets which can fit in the Target DRAM
and where write once and read many pattern is common this feature
is very useful.

With the above suggestion how about something like this:-

 From 2e640a1a34875fa8920794afc55181b636ce0d00 Mon Sep 17 00:00:00 2001
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Tue, 29 Oct 2019 21:05:03 -0700
Subject: [PATCH] nvmet: allow block device to use buffered I/O
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

NVMeOF target already has a support to execute requests in the buffered
I/O mode with file backend. This patch allows block devices to be used
with file backend code so that buffered I/O parameter can be set for a
block device backed namespace when newly introduced per namespace
optional configfs parameter "backend" is set to string value "file".

Please note that this parameter is only in effect when device_path is
configured as a block device.

Following is the performance improvement :-

Device_path = /dev/nullb0, I/O type = randread.

With this patch and buffered I/O = 0, backend=block:
   read: IOPS=198k, BW=772MiB/s (809MB/s)(45.2GiB/60002msec)
   read: IOPS=198k, BW=774MiB/s (811MB/s)(45.3GiB/60002msec)
   read: IOPS=197k, BW=771MiB/s (808MB/s)(45.2GiB/60002msec)

With this patch and buffered I/O = 1, backend=file:
   read: IOPS=979k, BW=3825MiB/s (4010MB/s)(224GiB/60002msec)
   read: IOPS=983k, BW=3841MiB/s (4028MB/s)(225GiB/60003msec)
   read: IOPS=980k, BW=3828MiB/s (4014MB/s)(224GiB/60002msec)

<snip>
     HITS   MISSES  DIRTIES    RATIO   BUFFERS_MB   CACHE_MB
   795057    78070        0    91.1%         1026       7961
  1028017        4        0   100.0%         1026       7962
  1025259        0        0   100.0%         1026       7962
  1003651        0        0   100.0%         1026       7962
  1024775        0        0   100.0%         1026       7962
  1003080        0        0   100.0%         1026       7962
  1004128        0        0   100.0%         1026       7962
  1003831        0        0   100.0%         1026       7962
  1026133        0        0   100.0%         1026       7962
<snip>

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
  drivers/nvme/target/configfs.c    | 34 ++++++++++++++++++++++++++++++++++
  drivers/nvme/target/core.c        |  1 +
  drivers/nvme/target/io-cmd-bdev.c |  2 +-
  drivers/nvme/target/io-cmd-file.c | 38 
+++++++++++++++++++++++++-------------
  drivers/nvme/target/nvmet.h       |  1 +
  5 files changed, 62 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 98613a4..538a591 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -545,6 +545,39 @@ static ssize_t nvmet_ns_buffered_io_store(struct 
config_item *item,

  CONFIGFS_ATTR(nvmet_ns_, buffered_io);

+static ssize_t nvmet_ns_backend_show(struct config_item *item, char *page)
+{
+	struct nvmet_ns *ns = to_nvmet_ns(item);
+	int ret;
+
+	/* ns->backend value is valid only when we have valid ns->bdev set */
+	if (ns->bdev)
+		ret = sprintf(page, "%s\n", ns->backend ? "file" : "block");
+	else
+		ret = sprintf(page, "ns is either not enabled or not bdev.\n");
+
+	return ret;
+}
+
+static ssize_t nvmet_ns_backend_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct nvmet_ns *ns = to_nvmet_ns(item);
+
+	mutex_lock(&ns->subsys->lock);
+	if (ns->enabled) {
+		pr_err("disable ns before setting backend value.\n");
+		mutex_unlock(&ns->subsys->lock);
+		return -EINVAL;
+	}
+
+	ns->backend = strncasecmp(page, "file", 4) == 0 ? true : false;
+	mutex_unlock(&ns->subsys->lock);
+	return count;
+}
+
+CONFIGFS_ATTR(nvmet_ns_, backend);
+
  static struct configfs_attribute *nvmet_ns_attrs[] = {
  	&nvmet_ns_attr_device_path,
  	&nvmet_ns_attr_device_nguid,
@@ -552,6 +585,7 @@ static ssize_t nvmet_ns_buffered_io_store(struct 
config_item *item,
  	&nvmet_ns_attr_ana_grpid,
  	&nvmet_ns_attr_enable,
  	&nvmet_ns_attr_buffered_io,
+	&nvmet_ns_attr_backend,
  #ifdef CONFIG_PCI_P2PDMA
  	&nvmet_ns_attr_p2pmem,
  #endif
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 28438b8..fb9676d 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -653,6 +653,7 @@ struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys 
*subsys, u32 nsid)

  	uuid_gen(&ns->uuid);
  	ns->buffered_io = false;
+	ns->backend = false;

  	return ns;
  }
diff --git a/drivers/nvme/target/io-cmd-bdev.c 
b/drivers/nvme/target/io-cmd-bdev.c
index b6fca0e..0179675 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -64,7 +64,7 @@ int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
  	}
  	ns->size = i_size_read(ns->bdev->bd_inode);
  	ns->blksize_shift = blksize_bits(bdev_logical_block_size(ns->bdev));
-	return 0;
+	return ns->backend ? -ENOTBLK : 0;
  }

  void nvmet_bdev_ns_disable(struct nvmet_ns *ns)
diff --git a/drivers/nvme/target/io-cmd-file.c 
b/drivers/nvme/target/io-cmd-file.c
index caebfce..ec258a4 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -25,6 +25,10 @@ void nvmet_file_ns_disable(struct nvmet_ns *ns)
  		fput(ns->file);
  		ns->file = NULL;
  	}
+
+	/* when using vfs layer we have opend bdev see target.core.c */
+	if (ns->backend)
+		nvmet_bdev_ns_disable(ns);
  }

  int nvmet_file_ns_enable(struct nvmet_ns *ns)
@@ -33,6 +37,11 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
  	struct kstat stat;
  	int ret;

+	if (!ns->bdev && ns->backend) {
+		pr_info("backend value only applies to block device\n");
+		return -EINVAL;
+	}
+
  	if (!ns->buffered_io)
  		flags |= O_DIRECT;

@@ -43,19 +52,22 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
  		return PTR_ERR(ns->file);
  	}

-	ret = vfs_getattr(&ns->file->f_path,
-			&stat, STATX_SIZE, AT_STATX_FORCE_SYNC);
-	if (ret)
-		goto err;
-
-	ns->size = stat.size;
-	/*
-	 * i_blkbits can be greater than the universally accepted upper bound,
-	 * so make sure we export a sane namespace lba_shift.
-	 */
-	ns->blksize_shift = min_t(u8,
-			file_inode(ns->file)->i_blkbits, 12);
-
+	if (!ns->backend) {
+		ret = vfs_getattr(&ns->file->f_path,
+				  &stat, STATX_SIZE, AT_STATX_FORCE_SYNC);
+		if (ret) {
+			pr_err("failed to stat device file %s\n",
+					ns->device_path);
+			goto err;
+		}
+		/*
+		 * i_blkbits can be greater than the universally accepted upper
+		 * bound, so make sure we export a sane namespace lba_shift.
+		 */
+		ns->size = stat.size;
+		ns->blksize_shift = min_t(u8,
+				file_inode(ns->file)->i_blkbits, 12);
+	}
  	ns->bvec_cache = kmem_cache_create("nvmet-bvec",
  			NVMET_MAX_MPOOL_BVEC * sizeof(struct bio_vec),
  			0, SLAB_HWCACHE_ALIGN, NULL);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 46df45e..b7f7b97 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -63,6 +63,7 @@ struct nvmet_ns {
  	u32			anagrpid;

  	bool			buffered_io;
+	bool			backend;
  	bool			enabled;
  	struct nvmet_subsys	*subsys;
  	const char		*device_path;
-- 
1.8.3.1






_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
