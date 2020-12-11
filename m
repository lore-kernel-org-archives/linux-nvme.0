Return-Path: <SRS0=PNO/=FP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66802C4361B
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Dec 2020 00:50:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE7B023DE3
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Dec 2020 00:50:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE7B023DE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=IrmbqPvHTG6vgH/gOz4oF9ZwoHKT4ZDp5DE6tkGCnnU=; b=P0nxeTa6Vl70IwZInNUtxp1DS
	0rC0ho7uYUpZdaHFuymWnsv/6QqeSIL+VWlMnoHRBzoksOsnnc7YwZ5cd4MR144awFcuWUotjitAZ
	4ajGUfsP1Aj+a3NRV5tURxTyy6mjeoS5Ljj1O/gTzmX73YQpq1YzBgImV7WXXEg5y8CPBoVCFLmWZ
	wfU71YLKINC1tXo8XAagSusdzCkjROe2p92tRk8XyvMIavg6d7/iwFtjn6bMLVFM2+T2qEw1FeLW9
	4fMtOGXK+kbWTAnSwj1OrnO7RZFcR1aLITb5ACkMXaVuo1wbkBFqhfTSxBEGw9hoQoxz5J9NASUXT
	78W5Mx3dg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1knWdM-00037G-P8; Fri, 11 Dec 2020 00:50:08 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1knWdI-00035z-F7
 for linux-nvme@lists.infradead.org; Fri, 11 Dec 2020 00:50:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1607647805; x=1639183805;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=RQHxWWeC9mqHgBxeuLRDGT2FsgMu2X2XAvqQwAFMKEQ=;
 b=BB6K+oHUtn4+eBUvC2jgwvxSznJYFGbz1UALuJFC0fjuKyqiIkz2mnWi
 iblller4Yp4m2zIq0pYbfHOkm98LSFlM1IyHWwKbeJoiBTFqevGy038wg
 hW4ytgruvFM3NBa2q+riM+GnMdVyfaWKukRp7M/ZPuIuNaVvFqJiqvLIq
 vE/5axCHlLQFhWIZ8Fvdd73SkiNoX1VZHvZNU3HYjxGDZLWpFSr4dyYPq
 A8cY5MYH4IfdlAUAVp8gTN1XUTXXzEAjEwD71qvXen2qZSW32XbHfcLlX
 FKsq67aMIeFOjC15vOsQhZJmxOUAoQ9ijKEZP+D8ro/tQt0YGIa+xR108 g==;
IronPort-SDR: w4RVbMJZvF9pLVEOdMv4SJclsnpTJSu7wP9G85LnVFuQHQ59S6rPeZrP1sdFkDAAWoWVRygj4k
 8qNDfl7HF+KrHCuCqxPsnQFIhxpniXw/R7O5rMGVod4n4JENWNVHppN/J2d6xyagKxr8FmzcO0
 lajkSsN4X1C5wpXjnKPiZ8MQ7hEie525PWCb15+Czd9TfLr65uTISAqtzBW30WvE0NnY/apUKm
 K7Qks3+BXcuBgwUgmqP1+FTPxraSLNC6hLqHtT+yiHxT1EzM18864S1Mpp4dcV8H567u9lWD5X
 peQ=
X-IronPort-AV: E=Sophos;i="5.78,409,1599494400"; d="scan'208";a="156114557"
Received: from mail-bn8nam12lp2169.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.169])
 by ob1.hgst.iphmx.com with ESMTP; 11 Dec 2020 08:50:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZL5lt9gpET6DqVoRcbAUHKeNGv29JbfQUzJHqf1Katd5HWIxFAtiYfh9EhcEJo9Y7vC0q5OwRPgRb1s6/BHzj+AxTq/WyK0dtXm+Lc3rvve22tBkZdBJG09Bun1IHDR9W5idUIxe5+u+azqAoIu2ELkvQ8MabATEgaJ+0njhETHbwRwwenVw+KwJoWDBLM39Wx32UDEtGsqfssWN2khJ16emWK0tKeqUpn3OrJbhImf7s5/33B6pUlL5XibTd51ZJD8XhBzbrrgI+lo/D+xcLRFHSFPBWTEBy68x7RS83dCZtNjliwHAjsUVVmaolRGInmy8bik+msyRQGRp6PVIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7fURhQhA7qX+xNFu6+7lLFC8KUFzIA+5hkR35LttfUE=;
 b=H6XUMexW05KnXqubS3zOKJGJyOIp7gN0j3AYmxyOSR7SGVNZ0MB2GKPQ+wadCQ+t7snPCZ9BlcVwI4qFNPxhhzGeq7B1eVvr98yPz2+7hOSrbdjBFBpzMlvNxg3OuVDqCM/fn4u070DvecrQ3yTAxt3LvgmpevwvAwWqyWKzp4sB0HBbD3r88O/QqDhjOipFi95O6Qx28uQSyrytnw3BXkxM8bGHJigpCZGktKbyWJ7Iytt+c850Ppj0p0+HIhO6R44TLw8B1GKStYelYVa11bXIvitqFOzOHC6pUC8JfxGO6UObtLFrLF8eA7u95C5ZUaYdazEXBnY71l270HPSAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7fURhQhA7qX+xNFu6+7lLFC8KUFzIA+5hkR35LttfUE=;
 b=Ee2sQLhojlsSG1CtIPt89xYyDWTWUo9o0PO6/b4yJXrVULR6R5P53gILVPsqmzjnmIhm3qr2FnUeAzhdEv+fRxE1FEaOCPh8Hrd19p8ssB3yTeeStcSEHwp6FY/KCN3NY99HyZ0tSxiSsPCi1ziticiqJALpVEe0M6PBsHkbBOg=
Received: from CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19)
 by CH2PR04MB7111.namprd04.prod.outlook.com (2603:10b6:610:96::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.19; Fri, 11 Dec
 2020 00:50:00 +0000
Received: from CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a]) by CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a%7]) with mapi id 15.20.3632.023; Fri, 11 Dec 2020
 00:50:00 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH V5 2/6] nvmet: add lba to sect coversion helpers
Thread-Topic: [PATCH V5 2/6] nvmet: add lba to sect coversion helpers
Thread-Index: AQHWzr14JdabCdKFpkO7eEfFxoDzyw==
Date: Fri, 11 Dec 2020 00:50:00 +0000
Message-ID: <CH2PR04MB652229BB9545FFAB75F5A754E7CA0@CH2PR04MB6522.namprd04.prod.outlook.com>
References: <20201210062622.62053-1-chaitanya.kulkarni@wdc.com>
 <20201210062622.62053-3-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:5911:8225:c337:ee37]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 19c5d54c-9dc1-4699-db5d-08d89d6eb07f
x-ms-traffictypediagnostic: CH2PR04MB7111:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR04MB711104EFC078C68406875091E7CA0@CH2PR04MB7111.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yfCg8n3fIahJzls77tUZE7IULm7k026XJkrxXwO1rkdeWByAmvX+3+Oa6mvmxjNbWyEGS74ORTpapMwsGmvThcsajhFiC8zQfwDtvb6PhhioyGtEY6DpDbKr77LXW+MXZvJYLe0sTKdJ5AOyJ/Zw2sa1MBM69wSGHCLOcUGIMDcpxxoh1tIoRDx0jd8/e6XAMTLfKgkWTifF1V72FM9LHijosVae/5t3YaEKWs2dc4iFOl2jtKmyabgHemWN8rXUTKg525Wbhelrug6MNj3pI32b36clED6VOW/7B0Kra9aGYSXoK4jLrGbk54N/ssPm0zde9w7FIjxCmBp5RWHrlw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR04MB6522.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(376002)(346002)(508600001)(76116006)(186003)(5660300002)(7696005)(6506007)(91956017)(71200400001)(9686003)(4326008)(53546011)(54906003)(86362001)(55016002)(8936002)(52536014)(64756008)(83380400001)(66946007)(66446008)(8676002)(66556008)(2906002)(33656002)(66476007)(110136005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?mZi6+ijjiiSjWut0C5X/ZMmIfn/65OBAVEbsVA1T0suv0vzme2JjMg7pMyMB?=
 =?us-ascii?Q?TV5x1fGKrcIixkx81y2sz894g0plBqQB35I0oLsnbdbkgTIKKtYWt2EmLWfM?=
 =?us-ascii?Q?E21a5/XP48wFoYIOFZRKd3xFOMacL7KXs+cIZHGFOiEzPWtk6hEjyMpdTLlA?=
 =?us-ascii?Q?XukgDyYT7vAkW/KybhzW8PvY2/tk0NIZznj7Ej89ipUFgoOO6Ql2gQBHlapq?=
 =?us-ascii?Q?JdK034EcxhjuEBA28bz1u/Z9/f0nwwDNDnrGQO1YKSmd/d5IvYpM5pZqlV6z?=
 =?us-ascii?Q?KXf1cjUgzKrV2A939VnxgW7501DY/PKVcv1z2gy6j4pC2eji9iYxMF0JKnAz?=
 =?us-ascii?Q?o33YXzU2/uZjcM9+USFe9tmwwK/s0PlNZVwMmJDr70xG4KvPwigsRCFdUltz?=
 =?us-ascii?Q?+QyIcaekKhu8XuoXGOjuHP/++QuvU4vKfVQILAZ6EYweOCadayWA/uw2SPxR?=
 =?us-ascii?Q?KjQGI+pgjWfpZ3/9n4X5OTt9fv0JpnwhOzr7zTyIKdOcNwDXThh1GlHWOJnB?=
 =?us-ascii?Q?JQ6DGnsVjwRpJremN5sWjcoircto6ZyFMtflO9S4hyG7CIfUhEAGhqP9pp1h?=
 =?us-ascii?Q?bAnDpxQ2xBQRuNQPSod6YOsl56xfdPFop4Ow9XRqy2/CKyfXpdHImaJjV8l+?=
 =?us-ascii?Q?jEL4NQKYu2eF7fGL4pHQuPLHZyWxXSKtZfL5bvOBMaCrC9n9E9LEPDz29vCO?=
 =?us-ascii?Q?8e6nSo2TA8xnyB30guPzO/TqgSkR5YtYf2RX2FTu31NxqsL9wgVkeelQR0M0?=
 =?us-ascii?Q?0RUIfPxfSVaZKavTagaxFNrJxFZA8M6XLlDI0GDhfI0OHwsqu1TuPHbhC+Uz?=
 =?us-ascii?Q?to7fhh4fhOyOVwf3ha40IkkkwMW7XstSPBCWAHPitot6DH9pYOu/I57Nld0r?=
 =?us-ascii?Q?IRFju/vGN4xGvhVfqgt0ClrI+ktcZ+twS67N3vBxM3papTfiN1nwWjRG8lIa?=
 =?us-ascii?Q?BuRBcKaZ9KANP6LmIvlhtyCYg/LrOVHvKMof4MRJCm8uc9Qv279gcOtQ43m5?=
 =?us-ascii?Q?blBN65Bkn+uqjvLtMPk4L6Df8PSQngMdNkzGHHPOl4M101ZT9agkiyJg7krM?=
 =?us-ascii?Q?6abAW//l?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6522.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19c5d54c-9dc1-4699-db5d-08d89d6eb07f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2020 00:50:00.4713 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nU92pptyj5b/zSVEx3BvqsMDb+JJ+Dt3mfqPf0q7ECOy4t7lVBUvh2nMOD5U6tMjNrPB7WGreT78w9UE2IiarA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB7111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201210_195004_885892_5796F51E 
X-CRM114-Status: GOOD (  18.44  )
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
Cc: "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020/12/10 15:27, Chaitanya Kulkarni wrote:
> In this preparation patch we add helpers to convert lbas to sectors and
> sectors to lba. This is needed to eliminate code duplication in the ZBD
> backend.
> 
> Use these helpers in the block device backennd.

s/backennd/backend

And in the title:

s/coversion/conversion

scripts/checkpatch.pl does spell checking...

> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  drivers/nvme/target/io-cmd-bdev.c |  8 +++-----
>  drivers/nvme/target/nvmet.h       | 10 ++++++++++
>  2 files changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
> index 125dde3f410e..23095bdfce06 100644
> --- a/drivers/nvme/target/io-cmd-bdev.c
> +++ b/drivers/nvme/target/io-cmd-bdev.c
> @@ -256,8 +256,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
>  	if (is_pci_p2pdma_page(sg_page(req->sg)))
>  		op |= REQ_NOMERGE;
>  
> -	sector = le64_to_cpu(req->cmd->rw.slba);
> -	sector <<= (req->ns->blksize_shift - 9);
> +	sector = nvmet_lba_to_sect(req->ns, req->cmd->rw.slba);
>  
>  	if (req->transfer_len <= NVMET_MAX_INLINE_DATA_LEN) {
>  		bio = &req->b.inline_bio;
> @@ -345,7 +344,7 @@ static u16 nvmet_bdev_discard_range(struct nvmet_req *req,
>  	int ret;
>  
>  	ret = __blkdev_issue_discard(ns->bdev,
> -			le64_to_cpu(range->slba) << (ns->blksize_shift - 9),
> +			nvmet_lba_to_sect(ns, range->slba),
>  			le32_to_cpu(range->nlb) << (ns->blksize_shift - 9),
>  			GFP_KERNEL, 0, bio);
>  	if (ret && ret != -EOPNOTSUPP) {
> @@ -414,8 +413,7 @@ static void nvmet_bdev_execute_write_zeroes(struct nvmet_req *req)
>  	if (!nvmet_check_transfer_len(req, 0))
>  		return;
>  
> -	sector = le64_to_cpu(write_zeroes->slba) <<
> -		(req->ns->blksize_shift - 9);
> +	sector = nvmet_lba_to_sect(req->ns, write_zeroes->slba);
>  	nr_sector = (((sector_t)le16_to_cpu(write_zeroes->length) + 1) <<
>  		(req->ns->blksize_shift - 9));
>  
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index 592763732065..4cb4cdae858c 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -603,4 +603,14 @@ static inline bool nvmet_ns_has_pi(struct nvmet_ns *ns)
>  	return ns->pi_type && ns->metadata_size == sizeof(struct t10_pi_tuple);
>  }
>  
> +static inline u64 nvmet_sect_to_lba(struct nvmet_ns *ns, sector_t sect)
> +{
> +	return sect >> (ns->blksize_shift - SECTOR_SHIFT);
> +}
> +
> +static inline sector_t nvmet_lba_to_sect(struct nvmet_ns *ns, __le64 lba)
> +{
> +	return le64_to_cpu(lba) << (ns->blksize_shift - SECTOR_SHIFT);
> +}
> +

One thing here that I am not a fan of is the inconsistency between the 2 helpers
regarding the LBA endianess: nvmet_lba_to_sect() takes LE lba value, but
nvmet_sect_to_lba() returns a CPU endian lba value. Can't we unify them to work
on CPU endian values, and then if needed add another helper like:

static inline sector_t nvmet_lelba_to_sect(struct nvmet_ns *ns, __le64 lba)
{
	return nvmet_lba_to_sect(ns, le64_to_cpu(lba));
}


>  #endif /* _NVMET_H */
> 


-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
