Return-Path: <SRS0=Wy35=LD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5818FC47095
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Jun 2021 09:40:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B97B6124C
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Jun 2021 09:40:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B97B6124C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=v7n90xZUt0AE6eijBF4Cc5FTRD/wRbDB8stA455PbFc=; b=NXbsGFODh+NaDT
	xrZtn8cdiA62fLRobK2CVATBckrLfiC8vIBYWnhZhGnbuIxYBBgIANxkatxEXoTedA1iU6HB4xlnu
	PWh9ecTdJjNqS2AaZ+qrVdVRQae6BCV7q9X/TbqNQbJLVmDioGNme1BMkijPeZRTWoiARDLHgZ1b0
	2vHj10EH4Lf+eTYzarWLdc5kCg/HGxv1XI7v/3ylCszFAYQHbQE5zJhD3KKx94Pb9FvoQr87a8+kG
	ujVvMQ/h3AdMbtHo+AH7Ib+cOxpaiafeoboBCuWxKKn77CKa0FmMPCllHumnoQ40V4nxZaGCGaAiH
	jRNp5r32U5StvEla4rGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lquhC-00Ckdh-Ik; Wed, 09 Jun 2021 09:40:22 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lquZL-00ChLz-AJ
 for linux-nvme@lists.infradead.org; Wed, 09 Jun 2021 09:32:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623231134; x=1654767134;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=WevMh8kF+0ES/Iw97QyLi8o/1yibYFhMJjA152ym36I=;
 b=Osgdwf/3vcvWf2dc3W8bMlclYRKRzhBgaNV3LJL2E8CO//8OzlOdhsbq
 ZhX+t5+2ogVfqohe/91y8n5KjIMEHYV204QdsPIp+IvusEW7ku3uahdFc
 ThtfFxAJ6zikdxeZbRpPJQW9YEgYDZnmvhzSfi93HddEOu60M0wZXkd4w
 8LpYSS0eJxJ86h/RB1f5H9wJ/B9GYWecZVY+VeLPVUjcE/NYg1m+G9wsI
 GuVb6RQSsiqQ9p8GQnRQ0RKSQ4ipAQxRZx5KsChkOAwNhP+MHF+mezqVP
 y81kRuMEjZcECovtIXYJJyIAQZ2qtlot9lTS5OuhqaxFBvUjI/qxvYeMo w==;
IronPort-SDR: R+JQzgrw3A2HJY6NxO0YjLEPaLcslRj7fhZcGk0BOGmbNclS7LYSAGdPg2bYRHmS8KRH+yTt9N
 r5p7cb+zHzRUXJXD0gU1huqKT51RnJ8z1k3FDTXmu3euQYsM02idtIltZ73KTjt+E022y50j6F
 Zy9XcLo/YwmolzDWyM+Xqb6XqTa2JsmJijM5YQ6iSmEtAMMqD84cIaoLembg5gjekJ2d0Way60
 83Ejx8ge62TGxv0ajvnGDzXVBSt+MjyzPAj6ytSt3BJjwUdBqJ6kFVXxrIbC29m54L5D4htJ93
 3+I=
X-IronPort-AV: E=Sophos;i="5.83,260,1616428800"; d="scan'208";a="171282190"
Received: from mail-co1nam11lp2173.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.173])
 by ob1.hgst.iphmx.com with ESMTP; 09 Jun 2021 17:32:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d0VCAcShPBtccL72c9AxP+GWPcsJJIchlz35/MXvjIXQBBSOzd7+GDvHZXVEYrTB6fK6DoxFc6K/eX4xo+kUXxsj0diOYD7bzX6uLS1t0m3CtL0rXeIcUqcVQ1BHW8B+WYbn6WAtxAFARetYrumKvq8VvG7Y1ZLdGL+63VSOsaLBhjElx4B2q7DgbUV3CrHXReFTNI3pmXVdp+xVeargyCmGftvnhRaqutwCzWSlfYxFw4C8TilSBbfEMe01+jkopQVWH/94WRWBPOASdxd9MpczYX38dotDJwYaLWQMCw9/w7JV/O0rV9Vi7LBLE12zoh+squrNzEspIubGHVjBjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37Enqd9DJzSNxLFutiF5fyXZGxPKK9zn+Ex45Lg2WzI=;
 b=NoQ4pvPLYZQRrwIHyf1tGLvWrNE00Zz8torL53p9QMyL+rgEhg45NLkaMAjyXjfqedAy+jVxTQ9VMHxjm5jBposso9H3u3cq9ROPLfRuoESRlweBXtUwy5F0cpS/Q7tq2QP4B0lXxXSfIbC2fLrjA/vkHDcYBNyapH2crnvq1i1pfZdnZD2i7BYsZz4GXVI7jjPpRlDFf7ISX4wZ8ji1AqubZrj5kzh3udpaUOgh4yrb4+cPcL11G37sYGXkBYYBv8qm5g9S/OrD0TRe3vxEJuwMuZeKjLxvUHGp0sswvs51wnDBJxrje3rb2UIAzgOw0uBjC7nVbfzYdwN58sYyGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37Enqd9DJzSNxLFutiF5fyXZGxPKK9zn+Ex45Lg2WzI=;
 b=nsXLpcCFncmtF1nf3Z7sZi8r7ewDfCWnudStydZGgJwwxG2oycGWdGgPkQzOJf93PEg0QqqQNcFLDz89OoVyFO2A9IM8O/BYXfoPj/pIRkpa8UIa2Zik1Txkv2RLiJ6wp7Va6YZK0c62w3nTID/sfdSr+Nhzp2C2sksbbUOLMf0=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB6606.namprd04.prod.outlook.com (2603:10b6:5:1b6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Wed, 9 Jun
 2021 09:32:12 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806%9]) with mapi id 15.20.4195.030; Wed, 9 Jun 2021
 09:32:12 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH 1/5] block: export blk_next_bio()
Thread-Topic: [PATCH 1/5] block: export blk_next_bio()
Thread-Index: AQHXXCmuO2Me8Rube0OJdVyszSpB/A==
Date: Wed, 9 Jun 2021 09:32:11 +0000
Message-ID: <DM6PR04MB70819F84C206B3AE2756C709E7369@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210608054635.5661-1-chaitanya.kulkarni@wdc.com>
 <20210608054635.5661-2-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:513e:a3fe:98aa:a7ae]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a5bc04c8-b423-44b7-4f1d-08d92b2975e0
x-ms-traffictypediagnostic: DM6PR04MB6606:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB6606B8FC82E55DD132231C58E7369@DM6PR04MB6606.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F+Oz6aTRtDgGpsF6ypIfltlQIWXdxSMU0YcwxicwEODUKdYor20mfktUcAlYpFVrLjoCgTmIfpg5vGBf95yfkpeau1ABGtLsu8z1U7WFv9tZupJ5OBNOzXKcq3iZryv2ZnauXgrXFYJtqRsAK1D8yeGTCEY3i1xWJ1i9h3XzoWPxxs6TB9Xc1ybpmMZqEM4WvxlzwAuDlDi2qkGxmLNB+7HhpofncfkOyciAZyqAI3copt5LiWBAsqbqw4OrNTQeE9zRzxpg+U5uW0cRvt67a2e7x9T/aSaFInr9YvX8rsxVMSsj3aFMDYnLMf1ch4QCatEUVCo/N31wNNazgM7KhOebLd4YfXhMKe6Tcki+HLXhhtiM0Wmn5Ppzgb6mqreLGMmkwhtYVkVgR8R0D3RZIp2MdG5HZmhxQgyR9RiJO9DJXTWjXjuzL8A7PC217I7vnCCg3JQDENSCeDfjioahpPk8+MvcZRf8OMZW1UOzH70ULU3mgol4A3uaiHSn1PAc18J27ydzsyk+u7BDG+2L3QfPtwjYKyKGqw+wWyvYIb0VLDg52jCXbcjVmuvDl4ZLIYMGObmeuHwrpoyvH2SE6dV3yt8MNyf2W8tui5ZmfPA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB7081.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(33656002)(8936002)(316002)(66946007)(71200400001)(66446008)(64756008)(55016002)(76116006)(186003)(66556008)(91956017)(478600001)(110136005)(86362001)(7696005)(5660300002)(4326008)(53546011)(2906002)(6506007)(52536014)(122000001)(9686003)(83380400001)(38100700002)(66476007)(8676002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Qm9Grw3nVirlQeJIpF+ZBPVy+bcsySYTGx2SoidcePsNI74tbP9g5zBImN8b?=
 =?us-ascii?Q?KJFnO8EPugOe58Bd8gkkxc3Tp0NJfHzR4OEBrHTt1bb9nghnrZYfKWzOEesY?=
 =?us-ascii?Q?/87/Gm4MaQWAbz0Dqz5NVClWAluAzeSLbginBJNxmnzJtW71mTXMiQl6szzL?=
 =?us-ascii?Q?zPYtiKdhaIwVWyi/JTkI7nRqcNsTHxi1qoi+xYmdBFlRwxAVg3/Iwzq0ymRs?=
 =?us-ascii?Q?KzKL4wokhOSXHYmcLHYC3me4FeI+K0q84IfkC8r/KjODXQvZHQvdcleSyLRv?=
 =?us-ascii?Q?nHTzV5v7HI2meZ1/393j8IWEIVjQ9ADRDq5BbzfR9/9dCnE7XJbwEu9I1Abc?=
 =?us-ascii?Q?QWDdwHLNUCQri9+Ql7ziIPDk9YtPp/9wb13MRy/cvR5o0HYZ9MchD0wG0HHu?=
 =?us-ascii?Q?s0V599lWbuwUDjlL0Xfq9up8MrCamwtlfdECFb564U0zUrifOfH8lwXvSnoT?=
 =?us-ascii?Q?J5WQPvdmhrP9sTiYrlnefPFUXbm9GOngAKZyy34I/VBKbaLyIzbPdqne1iEO?=
 =?us-ascii?Q?3BZO4c3nKuYk91pDjkb3oEF5yeeuPlp8kV3iCaZMLncImgCpuAJZuLAzEnxt?=
 =?us-ascii?Q?ATLyE2GjmC6GUBWOmHlEGUNChb0jVmISRHpM4uSYFn2PUlSSxRrV45IeWsxZ?=
 =?us-ascii?Q?WNWdS+qVZxRtGYrCQ210xQOX5umF57DPm5vt6bi9/1NKI5h8BhlId53XNxf1?=
 =?us-ascii?Q?5QkXvI/dsmHHihhoWjjegkm6hbThD3nxbITko/WLR6zx0YM3utnJi9+P0eCP?=
 =?us-ascii?Q?WEYogJffm9IfsWqDdlGIdd+0pW96pE0ng0mLgzAT8RYUp81vzbXxPcqSW2wo?=
 =?us-ascii?Q?GU62ZB27uprQY41DWk0qGkRRNXlvTtM8gPEwMRSsACtyoPGmU4Vq74ceALKb?=
 =?us-ascii?Q?9KzoTzNDCLR4RpJpY5+hkDKBD/Xj4Yy8AYBo/92zGVXPkCYqEePRJpd4BopH?=
 =?us-ascii?Q?ptglWUW0TCeKvvzehkEwcP3BNGUTGHHKr1v0kzACCzHzWDgjR12QGAGYb6BG?=
 =?us-ascii?Q?ZtSpP09SSreO0m7MRefo2W3/nGgV2HKri9ZcM/6WBszZb2zE87zTr/eMZlQg?=
 =?us-ascii?Q?PtSuHbc6sJ2fvRxRWYvI6vP3TWZO9lEH9S3fPNLIdMgj1gw9fuXahkszbvBg?=
 =?us-ascii?Q?JqHTGSlM+BNegImi9nMwtKqB/D9eqAIHZVQ1zBi0xggp3j/HhQyEYo3yGVXL?=
 =?us-ascii?Q?VEcMicjLYjvLyBjyB4UIYiTbC10MFJijcspfOeEPd7BMixim+02nuzBv1MHi?=
 =?us-ascii?Q?UlgJlW6wkc/MTrpj6dfBw6P6pqelG25cnymEJjc74rf2EyRrInVbGvWTFqk+?=
 =?us-ascii?Q?cVuH6z2GF6u5gzG8AXpqvuUsKi7ckFkNKPKkTjF8Na/YNIoadP+h57dFQjwd?=
 =?us-ascii?Q?HaZkE1aha73Z+kCcG9Pyfv3o6sV4Zm0Lptx3HQTJTxEpIhAIFg=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5bc04c8-b423-44b7-4f1d-08d92b2975e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2021 09:32:11.9908 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dBLX667F5sIWI7bIxBVe8h08ydjMV8SPi6keYcEtKcQ4ZIdHtHlQp68NMQt5kmY20cJhTZuCIyr1vk6li4qaDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6606
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210609_023215_475716_212315D2 
X-CRM114-Status: GOOD (  17.44  )
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

On 2021/06/08 14:46, Chaitanya Kulkarni wrote:
> The block layer provides emulation of zone management operations
> targeting all zones of a zoned block device only for the zone reset
> operation (REQ_OP_ZONE_RESET). In order to correctly implement
> exporting of zoned block devices with NVMeOF, emulating zone management
> operations targeting all zones of a device is also necessary for the
> open, close and finish zone operations (REQ_OP_ZONE_OPEN,
> REQ_OP_ZONE_CLOSE and REQ_OP_ZONE_FINISH).
> 
> Instead of duplicating the code, export the existing helper from block
> layer so we can use a bio chaining pattern that is present in the block
> layer for REQ_OP_ZONE RESET all emulation in the NVMeOF zoned block
> device backend.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  block/blk-lib.c     | 1 +
>  include/linux/bio.h | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/block/blk-lib.c b/block/blk-lib.c
> index 7b256131b20b..9f09beadcbe3 100644
> --- a/block/blk-lib.c
> +++ b/block/blk-lib.c
> @@ -21,6 +21,7 @@ struct bio *blk_next_bio(struct bio *bio, unsigned int nr_pages, gfp_t gfp)
>  
>  	return new;
>  }
> +EXPORT_SYMBOL_GPL(blk_next_bio);
>  
>  int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
>  		sector_t nr_sects, gfp_t gfp_mask, int flags,
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index a0b4cfdf62a4..b2491ead22a0 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -822,4 +822,6 @@ static inline void bio_set_polled(struct bio *bio, struct kiocb *kiocb)
>  		bio->bi_opf |= REQ_NOWAIT;
>  }
>  
> +struct bio *blk_next_bio(struct bio *bio, unsigned int nr_pages, gfp_t gfp);
> +
>  #endif /* __LINUX_BIO_H */
> 

Note: this should be sent to Jens and linux-block too. This needs Jens Ack.

Looks good.

Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>

-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
