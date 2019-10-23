Return-Path: <SRS0=6M3L=YQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35EECA9EB9
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Oct 2019 20:32:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A93F520659
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Oct 2019 20:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XHNc9RAW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TexLH+oS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="l4rQHm5A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A93F520659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=6VATY3Z1Jg0IAvWvkDhyr6xQA290NLhRtHCDot3YAKo=; b=XHNc9RAW7nxpEF
	0nZCS0tqRtI/1dUf0uUo6uF6DMyqKcemHESItOz5D8/eNu8FefYZ6gIWgbcKuKxW1vjQEdsE3zvyt
	B27DOt4eggUa0PK0QgvqG/iZRrVeCrT2NA2UgW5EcuJzHh4YNikPoIQEe5+rH0ux4QRu2mVYS1t9s
	lXik0quezkwPhi0URkNvyTHATPnlIXq6sKgNyPJQhgk52j5GNAdhOyNoVr/tmPsawNnGBxyETQUVn
	nWicEOrFggC6PfxFXdw7fc6LQK81K6Ir14/bJfjozOphWsGqW9gcfwwTr5H2/YSzFdl6+3eVX/jOw
	sSW7zQmPuBYNZexxBO8w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iNNIb-0006b0-N8; Wed, 23 Oct 2019 20:32:05 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iNNIZ-0006aM-Ew
 for linux-nvme@lists.infradead.org; Wed, 23 Oct 2019 20:32:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1571862723; x=1603398723;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=KLgLUlVsnnPLZeUMYrdO/imm8HBbdPPvzdRbOkiJnjQ=;
 b=TexLH+oSNRM9/4978RhC4EMDqaI9y2xhz8CtSZRTFQ9PquKsuQH46P/w
 /H0tSEpoCELCZsLwoXdvONQePT4WOR6zagd673+fAV1zk7OL9yGwOy8B+
 uJvIZ74p4qYVtwhOmthttRFXn/YukAQOXBgwaCaTGuR6BtonCN4xne7bj
 rytRY2dsobT+1qxcy3JJYQCy8wPMPAyXc0gSSEp8K+PB0+P0kVowhSzMe
 SWTqP/gMI0PcmKBzyuco4JK2Gz8oq/UZD0jWU+AdA9HISgFGr5u06Fy69
 ipOzPN/5pApVtOk9Kn5Y9d5L4nL1vohEcndWfY95qAs7AVRt4sPVmriLo w==;
IronPort-SDR: 5umrMZGbR1676MZWVWSSs9yqqeNsYyeNAIN/7LlGfxNnfoVrnWUPYiRnAlX2bF/ccJ4J2vseGv
 lTKaHxKDKRzW28SO3IjzmVNWRvBkBR8f3HFc4UQJJPDJNQFmSHJAvpNauF7z22m0zIO9nV9OS2
 gHqB18eOAiGl/X957x4GNckzxLC3ITCgiyJ6Kp8xBJ/cKnad7G/YAnIaaviNLMYlnSYr1XRoAU
 nJTihLn0mVX1kxUv65pSoQTAppbiowKwqpQMz8PHt/hykIWa4ESQvAXBfsoK+meQlivOAGmG/o
 bcg=
X-IronPort-AV: E=Sophos;i="5.68,222,1569254400"; d="scan'208";a="125613127"
Received: from mail-bl2nam02lp2052.outbound.protection.outlook.com (HELO
 NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.52])
 by ob1.hgst.iphmx.com with ESMTP; 24 Oct 2019 04:32:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mQeVkgmibBk9AMtc9SGCH7nM/sSJHWecQfuoP5IUK49zkmEAWZ3CgMhUG5mNa2QWq8aM9YR/1jiTBOFwMiWlyDb2yoxWPoNH/sby4BRSjOge+6Yi3V1nFIIarAQmSCbew3oV+KoN/tUQlKjhpxl4nbYKrfmqxEDvfH/0oKn+lt/zakwcZHvlX3ZZRsH8z7FVp14n0U5S097ypyN1duw/MdoxH61T5nCMS+21FN3ss/mdWfW1jsVj/aM742kE5SaJZnJk7z76bc0WD9cwarW7ztrUrhSMSJJYWMVW8fy1j1iecQ/NezU49VH8VETDpIQtJ+DOCqWkjTytGaYgesLDrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5fcLxJ1B9t31WnbPJ+ZXZilHMPckk1o/Y8b4BuuDGw=;
 b=fMwQMEm00jIvtN3jzXYQsN5KQPdF9Sk1tdwQ7aPu+44KpZfiPAHaqxxqenRlhCDuBs5TWqDmX4yaO8xvhuGBWj76/fn/eVzyNRhu0ZJmB5SuZnKYnTgcjyfVsTufBMl4GyfBMd3dWGf4mvewo9lhhU8/WXsVsPDGxrKhgHmiH8qt8QnwX8xpUIgam7wHYegS/BiHATSx9GLP6mfrNbfvB6g+gIAy9p3YZjvohIV53aMKemgNXstMsrTeri0NSn1HSMZOr65ACKZA8aNwVYC4qfSvMmBtN19ZqP/hSGLqkgmlDS2/xGcA8sfSZB00gzNXEUt8ZNQUz8eBgJDDNQdYLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5fcLxJ1B9t31WnbPJ+ZXZilHMPckk1o/Y8b4BuuDGw=;
 b=l4rQHm5AbUDlx5muRdQ6C29r0AxBqm0Dwe8mKVpdYw4P9GFKs6pYfnoUjFtDeEtFFVXg4m2xj/uvwi95scU/fmqysPQiPHS+UvbWNN7CuErH0HGRMRE+ApRFXBs3bVHeIngqnxungFD9HXUPJnvl5dyZHz+uYKBUCHyt0TPWMpw=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB4742.namprd04.prod.outlook.com (52.135.239.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Wed, 23 Oct 2019 20:31:58 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::34a1:afd2:e5c1:77c7]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::34a1:afd2:e5c1:77c7%6]) with mapi id 15.20.2387.021; Wed, 23 Oct 2019
 20:31:58 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Logan Gunthorpe <logang@deltatee.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 5/7] nvmet: Introduce nvmet_dsm_len() helper
Thread-Topic: [PATCH 5/7] nvmet: Introduce nvmet_dsm_len() helper
Thread-Index: AQHVib/6vP1Zu73G8kKgTvQAkF+kfw==
Date: Wed, 23 Oct 2019 20:31:58 +0000
Message-ID: <BYAPR04MB574984DB7059767E40564B4C866B0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20191023163545.4193-1-logang@deltatee.com>
 <20191023163545.4193-6-logang@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6b7288b3-be2c-4f2b-e51d-08d757f80d84
x-ms-traffictypediagnostic: BYAPR04MB4742:
x-microsoft-antispam-prvs: <BYAPR04MB4742B21D42D20B42E20DD1B8866B0@BYAPR04MB4742.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:466;
x-forefront-prvs: 019919A9E4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(136003)(39860400002)(396003)(376002)(346002)(366004)(189003)(199004)(76116006)(64756008)(66946007)(66556008)(66446008)(6506007)(66476007)(7696005)(8936002)(26005)(53546011)(66066001)(76176011)(102836004)(55016002)(99286004)(256004)(229853002)(186003)(478600001)(14454004)(2201001)(86362001)(6246003)(110136005)(6436002)(81166006)(81156014)(52536014)(9686003)(305945005)(2906002)(2501003)(4326008)(5660300002)(3846002)(6116002)(8676002)(486006)(71200400001)(71190400001)(54906003)(74316002)(446003)(33656002)(25786009)(7736002)(316002)(476003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB4742;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: knHcFNFdz8e8iilLjtzqjucvuEF9qennVdjpB2/VQIWxUbN6Npf4wbKokBMi5XalDZvSEa0fELhcgG7r+u/DAbu/LqPxwBe3wcfXHsQdg6tJhVqwVjsLR1QX58gbB+Yc1wUdAUIjwB2oOJ/GKPx/8m9ifaBUD3CwuQBcuxq1AqAZ/dGGIfGoi4lCrZ4YGfj6cNhEqLMTXTqDqUz2Gn1gwIjl3BYf9ScRcjlVyS0Bg9j6HD4kZEdXRIOQ75ve1XC3ey2varbThi2OJcsSskNwhJ7Run4SYY+LpKcDaPp/rAwbBf/x+C1RkLLe6KXH3oT8Tq4reJa8bXpy8CafMZijPDSxgjleT9foNIFXqi6QfMOKCIQydxjv0IypTCP8WOJQdKKCRBaVoUxPiFW1UN/dlMvMGmt9IXPYYRstcCs0naE=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b7288b3-be2c-4f2b-e51d-08d757f80d84
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2019 20:31:58.4964 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aWE5wsouLi3es1nV3ScPObZGj7YWfDuUgOsmIR5IUuOBc1GayhBt/6dORrzJhZf9ILZFeD+VAmpReRZSErqch8RAXLtHJ7y+96Ia4Zhoz4g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4742
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191023_133203_508005_9ADB6430 
X-CRM114-Status: GOOD (  13.13  )
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
Cc: Max Gurtovoy <maxg@mellanox.com>, Stephen Bates <sbates@raithlin.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

On 10/23/2019 09:36 AM, Logan Gunthorpe wrote:
> Similar to the nvmet_rw_len helper.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> [logang@deltatee.com: separated out of a larger draft patch from hch]
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>   drivers/nvme/target/io-cmd-file.c | 3 +--
>   drivers/nvme/target/nvmet.h       | 6 ++++++
>   2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
> index 05453f5d1448..7481556da6e6 100644
> --- a/drivers/nvme/target/io-cmd-file.c
> +++ b/drivers/nvme/target/io-cmd-file.c
> @@ -379,8 +379,7 @@ u16 nvmet_file_parse_io_cmd(struct nvmet_req *req)
>   		return 0;
>   	case nvme_cmd_dsm:
>   		req->execute = nvmet_file_execute_dsm;
> -		req->data_len = (le32_to_cpu(cmd->dsm.nr) + 1) *
> -			sizeof(struct nvme_dsm_range);
> +		req->data_len = nvmet_dsm_len(req);
>   		return 0;
>   	case nvme_cmd_write_zeroes:
>   		req->execute = nvmet_file_execute_write_zeroes;
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index c51f8dd01dc4..6ccf2d098d9f 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -495,6 +495,12 @@ static inline u32 nvmet_rw_len(struct nvmet_req *req)
>   			req->ns->blksize_shift;
>   }
>
> +static inline u32 nvmet_dsm_len(struct nvmet_req *req)
> +{
> +	return (le32_to_cpu(req->cmd->dsm.nr) + 1) *
> +		sizeof(struct nvme_dsm_range);
> +}
> +
>   u16 errno_to_nvme_status(struct nvmet_req *req, int errno);
>
>   /* Convert a 32-bit number to a 16-bit 0's based number */
>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
