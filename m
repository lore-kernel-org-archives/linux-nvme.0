Return-Path: <SRS0=i+iK=YW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2755CA9EC2
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Oct 2019 07:27:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE1E420650
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Oct 2019 07:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IYBnYOyR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PYeys+4H";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="azgqvA9O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE1E420650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=/eHzYGbCO60Z39JNEL3m0fppTuyubq4sY4MGmiLIAm4=; b=IYBnYOyRSYCW98
	XdDhKJq5/5DThWwEFjF6jZCAKzeWRe4p882Hg4AB2CMhhsSPWyCDSFLxynVGX/62uq/Tfv48bXtGN
	8876NZjU/Dop2Xl2BXpKZ5S65Jpc3WiQ9+CG0K5RU5g50qJUM8DfWZzSa1OTFT4QysGsfyMl4KJ1r
	jL62XOCawcJ+DOmaC5Hr5oFy9I1H2nxS5CGr6vZCK4e9o3gOCgLu5wr6bLiogGpnPMYuyS+S+aPxH
	5LK8iOaDRECbpp9SnDZSoGrJ24R4drQXna08ydlwSbnrtEfGP4PnhImsVnSykRfP2R5fbuHDREi+L
	4cYGFSyLUJl4m+HqpleA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iPLuG-0005qr-4K; Tue, 29 Oct 2019 07:27:08 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iPLuB-0005mA-Qy
 for linux-nvme@lists.infradead.org; Tue, 29 Oct 2019 07:27:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1572334024; x=1603870024;
 h=from:to:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=HiMys9wzOC4W2+G86qP3JwXREKgvi3yWFD2g4OuhVkE=;
 b=PYeys+4HPXnAbi+7zJl29GLwejzlFrxBQoDkCETa++Hr4h9ncjlgM8rn
 rmh+g83IvnL8U5y8PAFLPwB5l+nRBAxNh+U+xKvaDg1Gg4J/WB07DFAfV
 VE+CzBGhBpYXhbW1JGbOw76PUM1jqFdGJGotNE8b+PWm6mSmoIvof4Idl
 9AowhiYI2CXApbu8FX5f0NUwFOBI1iFgLEri0xudhhufP7EqGaMt4RhS1
 WoELYB8VJgLUiwTYS90Rhdj+363oHM/H2VKh2KINQQxnMh0iOuibddW2I
 GkKzkzz2RVPlx9mJ+jX9yoVPj1vSu82sKxne+akqcqsaJyt3upw0x05G2 w==;
IronPort-SDR: JI+6al8E4VFfU0Kapve7XjkFgtAGvvraWcsa9HpZRu7tKaoF265N5pHKJzwjCISV65us6EO3vl
 6jWPL/O/B5Cq9WQua2yEMsfjRVMB+4ySIc5dRenw6YmQ+6AYxSFB2YDxdOCXDXintb/OVW3V0H
 H0MsesvxFm78xyQShKMs7A9UTadn8aV0U9OOG3w0A0JHYjNhUXQlQx4nXWCg0dt3SLXsDDU+Dc
 dmxPG3Bbtg9NrisK4/IUpsWrIV6BxCSPrglelSxXv4yXVKpuaOKj36TQ9VNp8VHb2XL1iH3sZJ
 NUs=
X-IronPort-AV: E=Sophos;i="5.68,243,1569254400"; d="scan'208";a="122318824"
Received: from mail-cys01nam02lp2054.outbound.protection.outlook.com (HELO
 NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.54])
 by ob1.hgst.iphmx.com with ESMTP; 29 Oct 2019 15:27:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YLufbRymNP4sRiZax6utMQ/kEqnzo8/z7Cmz/rl/w/TyWvNNi2RvD+XuGNa/ROmtxBCvrTa8smQw3c+xKcUyQnXxc0fRjgfj07CO5J+5h8ufvlOMeEWwmtehSNS5MykyhCXEvLffYN/lXtP6pnuGPRAMxWWwiiQl9ndCoE/LAeeqlWuRO2BL6yiR+2ibD8r+Quws9YLklKcXWLSgIkYJl7mBsLosuj1dJ2azr1rlOqgJ0bQyaR3z+x0KLIF5Ztt11H/cHz2KCxbA9qSl/f0Xz8a2lpqC+wMPjnZv7scxZiwmnLHbKn3paoPoAJ8GFUwW8SlcVTZ/5XYJU7nM5VnHHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zOTYYQyjiSFNI+ZVjitVBG1tFo/Mp0+nKLQGszphnRA=;
 b=nZRNc/XI44idlq8suO9l9+YAGGnLjBI981v+4UmyVgflhHrC2BEXhPdlLFrXYwZZhNj+1KhuKmxtNiwll3cxXxGjgdGPIgxjhFalqNZFK468/qMW2vExHdt8yDpI4Y6N9E81k9IfKWloctEmnTkb/S5gnj0K5HvB2FXIE1o29xVm7OJk6D+1qkeiF+NKCtYEr7u60EXlIz3fGWVLqNbICiZl/0sAmElyYyRzUuuGyOcVoIQUxnuCTaotQ6IoJLZ2rKk2DbzeRkTQQo7PJchBQCLo6nVd/HloYhEqY0NQQvzhk0n4IQaKRjifgrGickVlNwburM0d3LzvOvCjUvFQTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zOTYYQyjiSFNI+ZVjitVBG1tFo/Mp0+nKLQGszphnRA=;
 b=azgqvA9OAEWkxY9G/mPy+TZ1j/17owZew1fL/4rR2+0NKud7q1iRpVkKnPOWDjK6NTL7R1e/FUKbf3vzJZAuQ7DsSX7WYugwgxhg3lCpLWF3oHBMd+h+OyPIMBnKyHSMgMOqXf9d1H7rcdLNNX+IH4VbE4LbncwMaKGBdBsRniI=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB5783.namprd04.prod.outlook.com (20.179.60.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Tue, 29 Oct 2019 07:27:00 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::34a1:afd2:e5c1:77c7]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::34a1:afd2:e5c1:77c7%6]) with mapi id 15.20.2387.027; Tue, 29 Oct 2019
 07:27:00 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvmet: stop using bio_set_op_attrs
Thread-Topic: [PATCH] nvmet: stop using bio_set_op_attrs
Thread-Index: AQHVjihE3Ljs+lA30EGc4OmH4iNl3g==
Date: Tue, 29 Oct 2019 07:27:00 +0000
Message-ID: <BYAPR04MB5749D0C5DF99B50DA97E66C286610@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20191029071223.24206-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 57fa76ac-98af-4e4c-2d7e-08d75c416325
x-ms-traffictypediagnostic: BYAPR04MB5783:
x-microsoft-antispam-prvs: <BYAPR04MB57838F73F34628C3D74DDD1D86610@BYAPR04MB5783.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:651;
x-forefront-prvs: 0205EDCD76
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(396003)(376002)(366004)(346002)(39860400002)(136003)(199004)(189003)(5660300002)(74316002)(76176011)(305945005)(81166006)(66066001)(478600001)(476003)(186003)(7736002)(7696005)(66556008)(76116006)(66476007)(26005)(25786009)(66946007)(66446008)(64756008)(81156014)(486006)(446003)(53546011)(6506007)(2501003)(102836004)(8936002)(229853002)(99286004)(6436002)(52536014)(110136005)(33656002)(2906002)(86362001)(14454004)(6116002)(316002)(71200400001)(71190400001)(3846002)(256004)(8676002)(55016002)(9686003)(6246003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB5783;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RJY9dQP40XVv3dVp8+zsi1ML/OI8bth43Ej9K0X5FJuHRAEGCxteAjp1LomPfZaB7v7YRQ5zArn9QsFyydod6hSUWXce9JyN/oS5rlvdRV0rqarJfyA6bg85UFg9gB7pjnz08iZCIMfrBKmg/l4NzxeQrjNSdESiReG3naw5BP943YrTjMu0auTlKK8Ehrp2BwHcQWfNVQenWEA3MVpkBdELRnv+OaV9fFFAbxJSVhqmDTF2p05wv+IaG4+gHqu7k6sly6Lz5/zPP1ZmVjNmL3cSXSuyDPz1rEHQEcBdj9N6cJCQJ4kp86QFMnMvszeJ+VwyV/kGiz5oGycFXhGKfYLGRW0Dj7/yfcQYCId7w6X6CrwSCKd81bVHxyjJATBJcm5ndXi59QP1JArBjo1mHvqzDA87y5nNqytMWu6xaTKE8nAfV9hVWUtFt/GislUT
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57fa76ac-98af-4e4c-2d7e-08d75c416325
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 07:27:00.1485 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qIyeVThZQwE9MYadHE/ZnDNyt8mOaA5yIy5FWmwDA/RwGhWyNnTt9beU5bbQc5FI/itk0+gMDd7IR4wHPOb17rnomotVF0lBIiXBlokk9Qw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5783
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191029_002704_006752_4E507530 
X-CRM114-Status: GOOD (  15.10  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

On 10/29/2019 12:12 AM, Christoph Hellwig wrote:
> bio_set_op_attrs has been long deprecated, replace it with a direct
> assignment of the flags to bio->bi_opf.
>
> Signed-off-by: Christoph Hellwig<hch@lst.de>
> ---
>   drivers/nvme/target/io-cmd-bdev.c | 13 ++++++-------
>   1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
> index 07e4f8c579d3..b6fca0e421ef 100644
> --- a/drivers/nvme/target/io-cmd-bdev.c
> +++ b/drivers/nvme/target/io-cmd-bdev.c
> @@ -149,7 +149,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
>   	struct scatterlist *sg;
>   	struct blk_plug plug;
>   	sector_t sector;
> -	int op, op_flags = 0, i;
> +	int op, i;
>
>   	if (!nvmet_check_data_len(req, nvmet_rw_len(req)))
>   		return;
> @@ -160,16 +160,15 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
>   	}
>
>   	if (req->cmd->rw.opcode == nvme_cmd_write) {
> -		op = REQ_OP_WRITE;
> -		op_flags = REQ_SYNC | REQ_IDLE;
> +		op = REQ_OP_WRITE | REQ_SYNC | REQ_IDLE;
>   		if (req->cmd->rw.control & cpu_to_le16(NVME_RW_FUA))
> -			op_flags |= REQ_FUA;
> +			op |= REQ_FUA;
>   	} else {

Is it possible to initialize op = REQ_OP_READ and get rid of this else
block unless that makes code hard to read ? This can be done with the
time of applying patch.

>   		op = REQ_OP_READ;
>   	}
>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
