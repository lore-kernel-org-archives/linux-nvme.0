Return-Path: <SRS0=0To6=77=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E40C433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jun 2020 20:22:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCA18207DD
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jun 2020 20:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="knStlSJQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PwrrvNiL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="FR3+kKLh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCA18207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bZtBwGSMz7SvkEeVZFIxnrKpGfXvuMA12ZmUOalVsOI=; b=knStlSJQ1z939j
	x3p+fCHqFObDIflD/lNa653ENoTHNdYBUgE83PqQVIFQIvJ5BfiJRWbwmWnKl2o0TOgJ390lhQDnb
	pVVZjZ9eolGEkdzmpQW11ygxB015KOujL141E6ZrIsj6CEbhzT8JX+rt66f105fHOrfdN8XDSm+je
	WJJUaSGkcvbU/lbeNSiCXr7K917/Fd3+oxGoDpFNOL3+LxGfChD9gHRq4msTOai4hu0TAVRp677w7
	KrzhyNoiASEShSKOziCLsPN8oK560vKunDuhpW2Loy6EnsDPrlCGxN2CAqSbJJUnF48U1LVDPlNJq
	ECb+01zb7J0RV/UNE7DQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jm13E-0005h6-U5; Thu, 18 Jun 2020 20:22:20 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jm13C-0005gf-1e
 for linux-nvme@lists.infradead.org; Thu, 18 Jun 2020 20:22:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592511737; x=1624047737;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=FhaY5ERAO0hboIg5hoL0wnfFKNclRMP8Euk9Dltnmuk=;
 b=PwrrvNiLe9Oi0rDzBCd2enoDGsC7oAyg/rI+R1gckBkNmK6THQ0wgAhX
 shGSp1XV/5j0YkgUCa9egdfatX1y7WFTKvN0RN7F/O/+tuc2rLLtKTZpI
 8ERNbRxDHG7duvhqFOLlOsBj2Tkq55rvIxGzM/Vx3JiznYrs3NpvJgVbD
 VQ96wXJZ/5OG5GBPwvzD5d75095atPfe8mZSUlFEI1ZE5YaueARnRGJWl
 Y9ab/ZRu79QzMADMCSbd1SPL2agG5ueU4cQ3qrCgum1kPWqqvrlLem/Lh
 ZtE77/kTUYgMlsQEo6yP70W4vIdbBC4H7QbobyV0i3XG2UJOEsL6napy+ w==;
IronPort-SDR: 2FW2dneHJ9r7yhCm8onP6k5gkfyHSOYSqJkdm1zgotC6cnfYHEPu8yz1W+PhFTNPioPY6PvdG0
 bgmroU5BGwA0HFlHiYnQ3tX+QnzTMtGxFPnVJzqAh/NwNz7RDuLGif4VsRM2DU3wfbcc+9J5+J
 QtQ3HhzJd7l9imyaLXTyTKTdGSTfAF3e6h+K66EnbGfnaSXreYMa8LdS92peR2gOqWb9KO8q30
 sf6o8KRv0CzSXihIqQ/xm7EALgTmhGAJAqcjbiNmKO/AaGDakfM2w6RPoKeuvW/X5AmuyA0dea
 voA=
X-IronPort-AV: E=Sophos;i="5.75,252,1589212800"; d="scan'208";a="140353968"
Received: from mail-sn1nam04lp2055.outbound.protection.outlook.com (HELO
 NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.55])
 by ob1.hgst.iphmx.com with ESMTP; 19 Jun 2020 04:22:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mUXHevfCiB2CxcOo+g5K4XVhWfWkW13U2GW8TAmoDZbEq3UokNOB16j9lZDMdOzd5kcc6pRqa0mCZmWbYjEK84RvxsqTKBbbshoYytPocKqPyNfeIypiql3B9fKA1oNHzfCFd7cuDv++1Pvh/csGbE11KLstJqKKjYP03UpxEDMZ8cyqQXAhxQu+Wi+FsorWfP+pqGDmG5oVSuilAWvCjIHufouUV6oodlNU/lmUz3r7chNwVKHS92q02//Swh0XYmimBEzxK95bd6u0kB4O7MZ5gYGUsf1aUZdrC+Wxbw5gWo0DmGaj2TdF7VW2Vy2sra0RIBvsy6n8htW1JN2S3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FhaY5ERAO0hboIg5hoL0wnfFKNclRMP8Euk9Dltnmuk=;
 b=XM9rR0HgVlyxfSYD3hglOLBaM/P540JNktoWyYFEPwcBOduA4bm+8hSUfw08IsEuC/0Docx5X4+rLjas44/gw+e9UbmTujOoWzLK+tsOLx4ptbG77jWM5YtLu1imigNdI8b/q0xMyp0vV+3/XHeoZanyMryUI7yS2OhR4bD4njmkNgcNd6C2wvD89/ThmvwBTV0BXlKZHX/5KXEiblKhPa7ZR/mV0RssKB9LzlGKam7UjbQhT1FlRV0kM800aOdby735L2MBlKOlgoW11w1z/2LHjv695EltFoZbo32oexpi/zMpzDaG3Sz2UoWn7IeqietBvu85Mc3RQMg6H59wdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FhaY5ERAO0hboIg5hoL0wnfFKNclRMP8Euk9Dltnmuk=;
 b=FR3+kKLheyLdpn3AMRa0hWMMoI1t9CZYpE6ufC2tgcrR7i1No7odpo0SlmblCMZWM+iAXmDUMSpVj7Occ95MBzrAX0pROHIm34/pehzDbAWVH7hguPLKZYBIc4rVMTPRvAzsHhtTFgVvPvo5bGH1rFrGYY2WTMZQIRMuphMWHVI=
Received: from MN2PR04MB6223.namprd04.prod.outlook.com (2603:10b6:208:db::14)
 by MN2PR04MB5630.namprd04.prod.outlook.com (2603:10b6:208:ff::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 18 Jun
 2020 20:22:10 +0000
Received: from MN2PR04MB6223.namprd04.prod.outlook.com
 ([fe80::899f:1d14:ad80:400e]) by MN2PR04MB6223.namprd04.prod.outlook.com
 ([fe80::899f:1d14:ad80:400e%4]) with mapi id 15.20.3109.021; Thu, 18 Jun 2020
 20:22:10 +0000
From: Matias Bjorling <Matias.Bjorling@wdc.com>
To: Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>
Subject: RE: [PATCHv2 5/5] nvme: support for zoned namespaces
Thread-Topic: [PATCHv2 5/5] nvme: support for zoned namespaces
Thread-Index: AQHWRYBVI7ILHVLNRE6vcred1EbgZ6jexF4AgAAC7NA=
Date: Thu, 18 Jun 2020 20:22:09 +0000
Message-ID: <MN2PR04MB6223341068C204A8A48C3ECFF19B0@MN2PR04MB6223.namprd04.prod.outlook.com>
References: <20200618145354.1139350-1-kbusch@kernel.org>
 <20200618145354.1139350-6-kbusch@kernel.org>
 <20200618193556.3s2gbkjsfotomot7@apples.localdomain>
In-Reply-To: <20200618193556.3s2gbkjsfotomot7@apples.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: irrelevant.dk; dkim=none (message not signed)
 header.d=none;irrelevant.dk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [185.50.194.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 89f731d9-bf34-47a9-60c3-08d813c54766
x-ms-traffictypediagnostic: MN2PR04MB5630:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB563098DFD3EDEE4E73278A99F19B0@MN2PR04MB5630.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0438F90F17
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DfnA/G+YX0NRntLJ5OnsLpInGysD2rVFkLoaXBumga4Aibvq4Mj5/5BRjUo8vuyAMZLkGfAiPesAqljibnIUFwy00uOWftVrjtlc62PWMXJhGvXHav2Cy3MhTQuBtR55IslfyV6UBuWxVtmw6smyV/yXn3Ozjv5xxEZrGosR4pjo0vmRbhnseyFnK+DlOnAjfwGybsxjpY6OVxXGTv2/hpr+ocroAwyfAw/NlIDUBiKtBT4e+4AI/hICz5LUopvH0mHaJd0w//xStZSzzMBv7dGQVZOBXK1a5bMW51ErMNGe3e+sqIMAB0Dxo2lqj42x
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6223.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(346002)(366004)(376002)(136003)(186003)(83380400001)(86362001)(66556008)(66446008)(2906002)(26005)(478600001)(8676002)(64756008)(66476007)(66946007)(8936002)(5660300002)(33656002)(7696005)(52536014)(54906003)(110136005)(71200400001)(9686003)(4326008)(55016002)(76116006)(316002)(6506007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: Dzi+A6ykmMDDAgX/Gxt6RLbGbe3Xlvf3mra8vcmx4Si3S27TYH4tBPQ26PM179E0FY2PYsgpdH9p7ND6tfOf3n8YTZsPlLXCLArNUS5/+ZGnmFFOc3Pzb4+oNuRd/m0ZwBBhzmRgunhLCfoWky6XELaDVIylrFSZ1Pyw6uCs72gg1NSwjNYOjThgaAFo1vehSjGskknVPCwQIzjh60bPRB0H5njeNQBkFe94jki1OLoUwzBsTM/pjoDeVRTDhWlLkiieL9802MlhxDZb0/HirfDGK08kBQ46pJUrj0+FtWZ4jREHD7toOW1kXKBPxVz/9GBWLBEtfkGrql/koKqkFY4d9w/7IlG/HeN82lenDFbtMvIuAB6/dF8Er31AgefPaB6TSXRgSG8Dcy1Xw/MJeKoQnKmfA5b5lhimUxWztBI4RoDELr2fsc4cTwRYDx/0JulZ9b7OE8e4/j/7AZi11Ie5Z4PebbN5WlLZbd24d+OGYCfJ9jqwjYsvxUYqdGyc
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89f731d9-bf34-47a9-60c3-08d813c54766
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2020 20:22:09.9372 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oZN8MDiLDpuuHcjR0KWvoedc3My3TFDJ490oBh4ZqRF9VNRxnYVu9RC2+S9EnjdtVc1Tk3D2Z7uD/ZtZ5m3WJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5630
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200618_132218_177223_F00E48CF 
X-CRM114-Status: GOOD (  18.05  )
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>, Niklas Cassel <Niklas.Cassel@wdc.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Ajay Joshi <Ajay.Joshi@wdc.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>, Keith Busch <Keith.Busch@wdc.com>,
 Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
 Aravind Ramesh <Aravind.Ramesh@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Hans Holmberg <Hans.Holmberg@wdc.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>, "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



> -----Original Message-----
> From: Klaus Jensen <its@irrelevant.dk>
> Sent: Thursday, 18 June 2020 21.36
> To: Keith Busch <kbusch@kernel.org>
> Cc: linux-nvme@lists.infradead.org; linux-block@vger.kernel.org; hch@lst.de;
> sagi@grimberg.me; axboe@kernel.dk; Niklas Cassel <Niklas.Cassel@wdc.com>;
> Damien Le Moal <Damien.LeMoal@wdc.com>; Ajay Joshi
> <Ajay.Joshi@wdc.com>; Keith Busch <Keith.Busch@wdc.com>; Martin K .
> Petersen <martin.petersen@oracle.com>; Dmitry Fomichev
> <Dmitry.Fomichev@wdc.com>; Aravind Ramesh <Aravind.Ramesh@wdc.com>;
> Hans Holmberg <Hans.Holmberg@wdc.com>; Matias Bjorling
> <Matias.Bjorling@wdc.com>
> Subject: Re: [PATCHv2 5/5] nvme: support for zoned namespaces
> 
> On Jun 18 07:53, Keith Busch wrote:
> > diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c new
> > file mode 100644 index 000000000000..d57fbbfe15e8
> > --- /dev/null
> > +++ b/drivers/nvme/host/zns.c
> > @@ -0,0 +1,238 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2020 Western Digital Corporation or its affiliates.
> > + */
> > +
> > +#include <linux/blkdev.h>
> > +#include <linux/vmalloc.h>
> > +#include "nvme.h"
> > +
> > +static int nvme_set_max_append(struct nvme_ctrl *ctrl) {
> > +	struct nvme_command c = { };
> > +	struct nvme_id_ctrl_zns *id;
> > +	int status;
> > +
> > +	id = kzalloc(sizeof(*id), GFP_KERNEL);
> > +	if (!id)
> > +		return -ENOMEM;
> > +
> > +	c.identify.opcode = nvme_admin_identify;
> > +	c.identify.cns = NVME_ID_CNS_CS_CTRL;
> > +	c.identify.csi = NVME_CSI_ZNS;
> > +
> > +	status = nvme_submit_sync_cmd(ctrl->admin_q, &c, id, sizeof(*id));
> > +	if (status) {
> > +		kfree(id);
> > +		return status;
> > +	}
> > +
> > +	ctrl->max_zone_append = 1 << (id->zamds + 3);
> > +	kfree(id);
> > +	return 0;
> > +}
> > +
> > +int nvme_update_zone_info(struct gendisk *disk, struct nvme_ns *ns,
> > +			  unsigned lbaf)
> > +{
> > +	struct nvme_effects_log *log = ns->head->effects;
> > +	struct request_queue *q = disk->queue;
> > +	struct nvme_command c = { };
> > +	struct nvme_id_ns_zns *id;
> > +	int status;
> > +
> > +	/* Driver requires zone append support */
> > +	if (!(log->iocs[nvme_cmd_zone_append] &
> NVME_CMD_EFFECTS_CSUPP))
> > +		return -ENODEV;
> > +
> > +	/* Lazily query controller append limit for the first zoned namespace */
> > +	if (!ns->ctrl->max_zone_append) {
> > +		status = nvme_set_max_append(ns->ctrl);
> > +		if (status)
> > +			return status;
> > +	}
> > +
> > +	id = kzalloc(sizeof(*id), GFP_KERNEL);
> > +	if (!id)
> > +		return -ENOMEM;
> > +
> > +	c.identify.opcode = nvme_admin_identify;
> > +	c.identify.nsid = cpu_to_le32(ns->head->ns_id);
> > +	c.identify.cns = NVME_ID_CNS_CS_NS;
> > +	c.identify.csi = NVME_CSI_ZNS;
> > +
> > +	status = nvme_submit_sync_cmd(ns->ctrl->admin_q, &c, id,
> sizeof(*id));
> > +	if (status)
> > +		goto free_data;
> > +
> > +	/*
> > +	 * We currently do not handle devices requiring any of the zoned
> > +	 * operation characteristics.
> > +	 */
> > +	if (id->zoc) {
> > +		status = -EINVAL;
> > +		goto free_data;
> > +	}
> 
> A dev_err() here would be nice. I had to dig a bit to track down why my
> emulated device didn't show up ;)

I've stumpled upon this a couple of times where namespaces did not show up for some reason. Instead of adding it here, would it make sense to write an error higher up the chain? For example around the nvme_revalidate_disk function.
_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
