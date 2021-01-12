Return-Path: <SRS0=XnCc=GP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F4BC433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 05:40:34 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23D5522CB2
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 05:40:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23D5522CB2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=gK2QXjIIegRLyUAFwIXukDdql+M0i8tNEwM++r2gt5A=; b=M5zfumKSJwCvlToy35ffisopk
	oCyNS5muw+zR7UCkpgReU6oQj1sAuYR9tJbRggmr3Q2AcKjaySfBKVBggy4yWWyz6ux9Ll2vBTUwj
	GcyieJUqgh1AXD20XeFFWqPhOSbSJNyUVkbFAZGG0YiBPVw/O5H5Vm0Y7lhtRiGmtI7mqWYMqwB9g
	vp+MNVLj3r0YYwlFtVIOoMB/GrkAoM/Uz/ebZ+yN3WrpxI415fcTjktlR/c8PcuXOKKN8goRAlEPV
	KvWdkYL6Hmud+dSWeve4gUcBBQVl+nwoAP+sawBWgYKyZq2FnBNb17hUtFW8iaNlSnQED0f88XNOu
	xLk31f5Xw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzCPr-0003EW-Mj; Tue, 12 Jan 2021 05:40:27 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzCPo-0003DC-OM
 for linux-nvme@lists.infradead.org; Tue, 12 Jan 2021 05:40:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1610430025; x=1641966025;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=/bSctMMrw1cebHRg5RYOgLQFcbD2UIcLE6a590nMGQE=;
 b=IiuR30tfTsCgZZFzktUVWsz7gjyuxNp+WQMAY0uDRWy15BE3azWvbvSS
 ZQFW+8hHr9FTb+Un6Vq3hjBj5gInkQxrCvTt1J3QuAB2+bYefW1ZM+xlQ
 h6w5M/DzUZQANUpnFLrimMYgi+HQc7RdPQbgP3C6+6Kjc/eQybBb2gScb
 7YMCTQpW/knm1AlNPhz1Vn8NVjL0SGS+N6FHhV3xTj/RsUC7x/5xkcOFN
 uBIL3za6dlCTKm0ZDCO7to7R7Gt9Kv7eMFytmxU9VSNAdDHQhgtJrc4S1
 bNIdJ7SxyF1te4L4k2sNN8DMR50qgfH7owLZMR487ot8HMU09IlQxnF/8 A==;
IronPort-SDR: XCsYByATMlBg1cxho4q7jl2Ooq33b3dNCtMoxoa9Ns0L4l0A+WCZ0YzdFQYbG7+q92DxWid9oc
 zQn6PPS6HK/b/Wvkn9ZP0Nw6ZJ7xxeLUJlkeJPrFZdlkIKj/xytlcktYiR9lIaG3QGIGu4f0l9
 MWdB17ABRy5PudlUORFM3ylt+M3pcrOggTDAfn12dSw55KHxeo1T9IokMOC7gXm224Nk+yE9OK
 xGnx5trZTSQdg0CsiTPvX9IL+l2nOF+Wk9j16hFJ2HldASlfKXsmnifOHbQWEljznVFmJ6yHdW
 r1I=
X-IronPort-AV: E=Sophos;i="5.79,340,1602518400"; d="scan'208";a="158384824"
Received: from mail-dm6nam10lp2105.outbound.protection.outlook.com (HELO
 NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.105])
 by ob1.hgst.iphmx.com with ESMTP; 12 Jan 2021 13:40:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=auehVxJtH2JLbe+ir5OBTozxsj4ye9DT35/4zlhMNh/JVaOQIOScwOOOuACpReqQlAUnY8HxDyV8bqKdev2ZghPxdtZ2EC9UIYduYcF8q+tauKntQVpEZtagO4gpo07UCPANfm2Ky5SlkcA+uHPogn0dfRbiKpFYIbvBAJgr+bPm4AdDQHK2vaUnhx6vPPEyJCpNOkBOMwVn+6epcOXSSbY/FggkfZ8tYVZ7GtSUlWVqBnpkgDmEgltVSncmO+9ihQ7Y6dzY2/sykVFpxpsy+m0YMHz34IaXSbiRD1/dHXxqFjAXMOlc2arzU/QXKQ/tHpMkInC5LGp95A92sAC0rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3WIh/yndaZLyUbXqTenEuzKMMQ5IOVKZPY664TkAAs=;
 b=fdcKWBAYvcXa1fiQQQdzcBP4UIAU1u9lLVvEHuiSJOK7mb0bHO0AamPJqMWJZuivra7y0UiO1+1+XsrRnCG+nsvP6v+WvXg3rz0vouSqrPx/66QsoDyboNfFNZJ7RlC0igrRsiwiEabwGMq9yJ8Lm7XpA5ylSpBH7/5n3a5QWYRFwd2EKYkpyjN9FPPNSRy4DQlRzExg4biqok+q70MR0iP7gxhD5Zx/kT+oVj84vwaE4H4QDE26f9Hi7C68NU6oS/m1QZxJiXpMIOcg8Msk25xU0JVUwmJ3O8pP3uafw8FPeVr3NIXW3Ejs5PDzq513TyFtS7jOkfCV3Q4hdD8ODA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3WIh/yndaZLyUbXqTenEuzKMMQ5IOVKZPY664TkAAs=;
 b=qT+3/8UJG6SoNJRJjiRdVcKx/D2LGokWfPxzGUtvrQaBXwH1/Spl2zB6N/tME+Od1gA06Wow9KcZ0AiofbRMhggHXw9l7kEe5SJQm6TB8odkCyrw4XiOaH45K1wjkuKXbV7j18nvUaTSTVoaFQt5m05Qujk1OKNHawPfNXUNLbE=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB6446.namprd04.prod.outlook.com (2603:10b6:208:1aa::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Tue, 12 Jan
 2021 05:40:21 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::2dbb:7e01:f076:eca0]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::2dbb:7e01:f076:eca0%9]) with mapi id 15.20.3742.012; Tue, 12 Jan 2021
 05:40:21 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH V9 1/9] block: export bio_add_hw_pages()
Thread-Topic: [PATCH V9 1/9] block: export bio_add_hw_pages()
Thread-Index: AQHW6Jsh1gHE/mYsHEGEzXQRV1WfYA==
Date: Tue, 12 Jan 2021 05:40:21 +0000
Message-ID: <BL0PR04MB6514D012AC158AB3F873C387E7AA0@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com>
 <20210112042623.6316-2-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:5cb8:2b48:5f8c:2c03]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 535dab38-c260-489f-e27e-08d8b6bc8d3a
x-ms-traffictypediagnostic: MN2PR04MB6446:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB6446F401E065C03818B0F8EBE7AA0@MN2PR04MB6446.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KCY7FNjqKE4wB/ahQ37XmCeelWyiHT/BOW/ZFDAzI+ZzmMTihQBym4qZYEHxT9iubWuNkVxenLDQbsrUV8OR5dPCW3/CG0cY0cVwoOimiqqLYd0AyW3ottsfgOvTX2h3fG+uyOtGTyfBNvOCNjKfG9mOnYRYTSOoiD0E9XKFYkg0cb6obeHctUmuEhXygz9AplWgW76mmv3TN8b4AB2/5hOs5ApLJSDpg4j3u1Z881zCmQMjyhcbP9otY7C4EDoqjwaBT8bfbG/jH4rb+Dv5RR1NrB9mbiw9Fh9xxbgU0Ex9gJezSTnJRR14VGSo9BWvQt8X5wl5tvREPdBTCH/vXV34EDCZtdubLnzIqx5f74oynbBg/K9ykCt6IhIfviQot/GvHIJbGgq9BgEREdtzhQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR04MB6514.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(136003)(376002)(396003)(39860400002)(71200400001)(6506007)(4326008)(9686003)(7696005)(316002)(53546011)(5660300002)(2906002)(186003)(33656002)(66446008)(478600001)(54906003)(83380400001)(110136005)(8676002)(91956017)(66476007)(76116006)(8936002)(66556008)(64756008)(52536014)(86362001)(66946007)(55016002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?oP/S9Kcz0v3gkCuuifngnwdnS6nljfFB0IiDgibNJbF32Wnzy0jxgsYZIyZF?=
 =?us-ascii?Q?lTGyLMLN9fw4gdln8ZboOiHvlgKKLEwucBqV70rGUYQ4Bm1F9eAlehYCe1Yz?=
 =?us-ascii?Q?5Z3YnaXaBJ3RwYf4w/g7wn14ct7TFKY81No/TgBfnNY+slnRDIDl2ow/nXx/?=
 =?us-ascii?Q?hUWvrl8Ze2z0lnK4Y9IbBfRrA/HFyjDB61OF+Hq9cNZ9EVfBSHK/MR3xglsw?=
 =?us-ascii?Q?ro/G/9Amwpqh75YJDay5rizlLJ3qrVRkplr8RG/CulPrBTs3KL1OIl9pL5JF?=
 =?us-ascii?Q?b0YiXpTL3jAn+KBZ35p3MtOWQnRCdKSdASeshitZHn3DktTCscvPdd1KXSmW?=
 =?us-ascii?Q?vBQP/1mxIwmA+BosudrUrNc4w4NS0JbfHEB+HAE6MbO96umDtz87/ZUmGLpn?=
 =?us-ascii?Q?JubF1+0sNP1/8tKiAdyB4mn1NiC85Qc0Fs+lyOZ++EYrrmVL+RVCVW3HLzSZ?=
 =?us-ascii?Q?5xWVbN3FASjGgd9urwFp9kPUiEUgBd2gWBKz6CLZuNRkp11tJdwrzIsVDT1I?=
 =?us-ascii?Q?Z4suZIi5MZbJNE7vWfgPzAq2Q6rZoVWk2nlG9/CUBCu0RYPd0cXnOkBYt4xd?=
 =?us-ascii?Q?41CnxsTd4BkIo5TI8OFwpQkvlGHUmPmqZJNn/c6d8Zh4zHQFp0xjZHa9Vs2l?=
 =?us-ascii?Q?0OrpjzWLu7d/NzV+jqivNfHA+XXSsvhFfURz1NeMFB3t4XJLjcWpYtFk+N1Y?=
 =?us-ascii?Q?15CGwB+TYxBFhHYPfgVWAKeF4CpzdUcSMDw4KDO/vpr0oRvBdi/q80QyfDik?=
 =?us-ascii?Q?4Anz5lFHLF+sVcLz+hL8A6IrVo9wE40e0vfGK+4JlNIVlg1wDj5oz6O86qGa?=
 =?us-ascii?Q?EL+48KRuB6F6OomOmHyomtvmCWFaUdhlgn91NOhdh0etZnnQP7ltfWP2njaZ?=
 =?us-ascii?Q?OcEs3AlinkW/ZXwoXAqCoixHJS8mOk3G3Zj1Jy7+3KXYsScB2ryuXwQrj36b?=
 =?us-ascii?Q?bPp1ACfX8MurGOZIbXVNI6vvavIh0nVbyFycLU+SCForfe4nfTHqEdM/wF3b?=
 =?us-ascii?Q?wS2PuTEAn34lZyW51Lg3ZAKDkOLVO4Miw1dYBO1zLvvrGA6is6uhfGIfxbkM?=
 =?us-ascii?Q?rd32+hW6?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 535dab38-c260-489f-e27e-08d8b6bc8d3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2021 05:40:21.1801 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q5s9wXD3g/vlrgpts3hLOu7A03AQzQE30k7um+Djg/b14zNSfJF7vOgDOdr1jjPB0yx5hxi6FGpCrL/on49UWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6446
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210112_004024_960262_03150A4A 
X-CRM114-Status: GOOD (  19.12  )
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
Cc: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2021/01/12 13:26, Chaitanya Kulkarni wrote:
> To implement the NVMe Zone Append command on the NVMeOF target side for
> generic Zoned Block Devices with NVMe Zoned Namespaces interface, we
> need to build the bios with hardware limitations, i.e. we use
> bio_add_hw_page() with queue_max_zone_append_sectors() instead of
> bio_add_page().
> 
> Without this API being exported NVMeOF target will require to use
> bio_add_hw_page() caller bio_iov_iter_get_pages(). That results in
> extra work which is inefficient.
> 
> Export the API so that NVMeOF ZBD over ZNS backend can use it to build
> Zone Append bios.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  block/bio.c            | 1 +
>  block/blk.h            | 4 ----
>  include/linux/blkdev.h | 4 ++++
>  3 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 1f2cc1fbe283..5cbd56b54f98 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -826,6 +826,7 @@ int bio_add_hw_page(struct request_queue *q, struct bio *bio,
>  	bio->bi_iter.bi_size += len;
>  	return len;
>  }
> +EXPORT_SYMBOL(bio_add_hw_page);
>  
>  /**
>   * bio_add_pc_page	- attempt to add page to passthrough bio
> diff --git a/block/blk.h b/block/blk.h
> index 7550364c326c..200030b2d74f 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -351,8 +351,4 @@ int bdev_resize_partition(struct block_device *bdev, int partno,
>  		sector_t start, sector_t length);
>  int disk_expand_part_tbl(struct gendisk *disk, int target);
>  
> -int bio_add_hw_page(struct request_queue *q, struct bio *bio,
> -		struct page *page, unsigned int len, unsigned int offset,
> -		unsigned int max_sectors, bool *same_page);
> -
>  #endif /* BLK_INTERNAL_H */
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 070de09425ad..028ccc9bdf8d 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -2005,6 +2005,10 @@ struct block_device *I_BDEV(struct inode *inode);
>  struct block_device *bdgrab(struct block_device *bdev);
>  void bdput(struct block_device *);
>  
> +int bio_add_hw_page(struct request_queue *q, struct bio *bio,
> +		struct page *page, unsigned int len, unsigned int offset,
> +		unsigned int max_sectors, bool *same_page);
> +
>  #ifdef CONFIG_BLOCK
>  void invalidate_bdev(struct block_device *bdev);
>  int truncate_bdev_range(struct block_device *bdev, fmode_t mode, loff_t lstart,
> 

Looks good.

Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>

-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
