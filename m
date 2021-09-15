Return-Path: <SRS0=dHSS=OF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD23EC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Sep 2021 22:01:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6805261131
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Sep 2021 22:01:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6805261131
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=LEWPOFKUvyg4jAxZ6TCnxM2IkEonO8CwHfSU/q9l7Wk=; b=PnKSOGPkXY7ViA
	v3zAC0GVxxNFaVgmVtHdqjTqaAwuxbqF3ICecEkwB8SaapPhu6DeP8Ra0PTPstEBtdxN3Epqi4H4J
	qnWageN+a8y0QvoRBA3YFWeYe/LyiD7XDhab71d5jxwDoIXyvd6xNB7xFEPP8h8f/jAPjzfjjY/v3
	FM27XTBDk36hNl7pXuZZZKcAzkYWLs62svbwHb90Nlso6TvLI0+6PQoqw7XILBTVBsvdSlRZYUpw/
	I21dYI3YSsZ8eAXClY27imj3wEjIEHFjJ0P4A4Eft1raRWcfORstL/KEeXb6re/MwbcsxgczmAbK3
	NDJvOlmStqPdbWOV6L/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mQcxL-009z4W-QZ; Wed, 15 Sep 2021 22:00:39 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQcxH-009z3J-OW
 for linux-nvme@lists.infradead.org; Wed, 15 Sep 2021 22:00:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1631743235; x=1663279235;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=rBf6q7ZVWIV8hebqsU5z0L1sp3dt7Vz61NYdPPZOYSM=;
 b=BsR39K8SMJX/crUPgCcKwueJUvluxH8XtoVGEafLns906fLAjUh+GsWf
 GZkbBSH3F4LeHJjfWVg0vx1od9pmIiz12wo2FPCr8sM7lckms5GiV827m
 PzYSOpzdGSfmUU+6SYM6U+y07wth6qdsZR9tAd/5W8+UpaL7+1ou15C5K
 Ru139mBL/oqrEw01PjAD+oSlJ3CM1Q9Fjqid4VUFEXTuiMPtLtxfjuay1
 J7tk1ww0/krq/7InyBnTQO0AwvnPsQA/uKYzTQms4tNuzgwdjuPJAtdMS
 SLDAUoqnUVk9fxUc+iUj4B34os/zan3+a9RvMM3mvjY3FXamlqKATJVpb g==;
X-IronPort-AV: E=Sophos;i="5.85,296,1624291200"; d="scan'208";a="291730617"
Received: from mail-mw2nam12lp2041.outbound.protection.outlook.com (HELO
 NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.41])
 by ob1.hgst.iphmx.com with ESMTP; 16 Sep 2021 06:00:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mNpdDK8LhVCeed7uX/cOKnq8sRq6vewf7Uowd1xfO8K6IbOZFizzCtE7jmMdmFVZZVATlqOF9KTo44zyhsZ3IeYtCZZI8HkHYiQQlhBfjQbTDX+RZO7tBr7dzPV9d2m0w2wjSqwMK84nSZnm9+D65DYUYCWAvM7QdHdtUlIgMncATXqzt1m/Cod3/GNsmInRnM0gFZCdrvhnfktmBEDb+xv81pOXrb5MTzhhMvqrnw/g9XXk3Akcu277QH0SgSv0cNejIIRqBSV9SSq9j2q5dULtOHRHq8CHivtLB9sqQrSOt0m7FIJ0CkDR5nsgm9Tvvn+83s1r3rj9EDrbb4QzWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=Wq7+YQqNAGEyrZxhHTcAYRu7mbqK30m2pnWzXrrrSGI=;
 b=Qh7bSDAQGNQlbBLiwuYbK9pGcpeV6kqzf5Lbc0YfHnm/NbCrdOcuiimfWc9Mw7OMEY+4Df6pJZj+i0aBWDTMRW/YPemjcZDjocyKKRptVbZbGNbhDEcJkKGzWP9jswLj7fI7Ofu9BWdVVLoFJzpwbR/whNIEgKmYle3KAdQSdBsX8vWDQhoPl5462Hg+BZJ1vby5Mcwo6LonTtT1+8lBiFT5rBRwayMydJ/Yjg5SOdHwsEpe3y53D0TE7nlqitqnpiEnUO2rkWh5rnIOaLw8YI/CMaZafxZg49RirEAPlceUAQXuaBjsfd3lXg6t9YMx+heYWrYOjAHrl7J1CwO02w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wq7+YQqNAGEyrZxhHTcAYRu7mbqK30m2pnWzXrrrSGI=;
 b=f2MAc9ootYXKTULhlmTKLJskNIFWyx2xwPg8v6MIeGlsmoskjMtnMFGiJvoodQMTA7LzjoGLEfsFLapOkOINzo4WOK6QguDexvNshrgJzNh4BvJxASt0HqG1FstTQYQ1Du0OW3/LQtB/hYfdeGdM6WkyeS4M42jZq2QcAKq32EU=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB4409.namprd04.prod.outlook.com (2603:10b6:5:a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Wed, 15 Sep
 2021 22:00:31 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::7c0e:3e95:80d3:7a70]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::7c0e:3e95:80d3:7a70%7]) with mapi id 15.20.4523.014; Wed, 15 Sep 2021
 22:00:31 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Christoph Hellwig <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
CC: "anton.eidelman@gmail.com" <anton.eidelman@gmail.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme: keep ctrl->namespaces ordered
Thread-Topic: [PATCH] nvme: keep ctrl->namespaces ordered
Thread-Index: AQHXqkhtf+cD197zqUG6hc6l7CXwCQ==
Date: Wed, 15 Sep 2021 22:00:31 +0000
Message-ID: <DM6PR04MB708196D604DB3250A74FD093E7DB9@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210915153751.1457173-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c9c57b50-a330-454e-62cb-08d978943c7d
x-ms-traffictypediagnostic: DM6PR04MB4409:
x-microsoft-antispam-prvs: <DM6PR04MB4409469B6CC5406EE8514D46E7DB9@DM6PR04MB4409.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BU4HUmYJH345Zp1DicjhlwkUYdlsJbqQQln17lkKUbYg9n19XNwcq3xDXpVLL97G26EchahYwpkKBe1+cX8Yiqa/6DpsA9jBP/XL0SCQ2GE34xu/rhWyMTgpfb6YmJ262NEzMvSGbDz488s32m1e9ANq4F65LWpOJNPDJf+SvoKESA3ABz8srTraa+QnijAdN7tFT26f3CkJcJL8c8JvtvWL+FAdlMm8TUeGhIxyyj49ddgiLl8AAsdSXumw09QtQEr32PFE3LNKKtLjz16EHw4TVppsWCLFV/Q6wMaWG9SaPB5DwyZOMERBvyaGIz064MtRuWa3Vy/TmyGxf97inCMJXshWnPO1hY1ztUg3j1xd6C/i/zwOlXBrkq6c+q3jwadjooAqFDGjT1MaWbhBAsUIdOh9ybZlY0X71TjuM4Eza1XLTHHQaQE9elsVGEkbmJb1XRvGCEZ4xA4I0KadMuzW+WqTWxGnrl10STTOd6gXmAPm5VtHjBqW+8cLqd4VTh93bDZEDkVCN7pSMl0I8+8Ct144swXK2bC/kUHY9PxOZKzUU1P6M2GISDRobnw4s7pPmDpaHpi8jO/yJ39VbcngcvBVbDNdfCAYHqclejss//v+Vf3n+1OUCED3+yMgKZAoiey4YKbpylRd6HZ/u1ia73ww7BVyP8foHiYgfVzpgLq04wGyQ6+p023EDLBCJCLTYC5TFZdmtU45g4pErg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB7081.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(346002)(136003)(376002)(396003)(8676002)(7696005)(4326008)(8936002)(38100700002)(2906002)(6506007)(53546011)(71200400001)(52536014)(316002)(478600001)(54906003)(55016002)(110136005)(186003)(5660300002)(66476007)(66446008)(66556008)(66946007)(91956017)(64756008)(76116006)(33656002)(122000001)(83380400001)(86362001)(38070700005)(9686003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vuiKu7+IiPT2UztpxUdPzuhiNRwu6zgdgIzdFM6bwVE+1rxRZ6oU3cONlucw?=
 =?us-ascii?Q?g+lP8xav57dl+ljloOYs+Qe8DuxwzHKKSoGQC0ptdrWMDbnTjeiza4i7xWv5?=
 =?us-ascii?Q?SJ4h6B9dLtWnG6g6kAPXnDmFW1PcyHx0zZ8l80lZvv//KuxZnnZqY3zEGpAK?=
 =?us-ascii?Q?RoYC0z4oYyjR/jv4PaKQL3c8tMLDkQ3zGtOyrdDzpy1kxh2ikAjkFTEdDUj3?=
 =?us-ascii?Q?8KR5gHDTqDQtYs7eMjviNoSNvZP3wLv1uR7GdAs5X5rEt9zoiZkzWQmiLa/I?=
 =?us-ascii?Q?RlX3RPbkOTrV6UmOq7VyAcqwoBOKkGgB9Tf4R2Ir7zd7vMYMeHZO2btQIB27?=
 =?us-ascii?Q?E6Y6jcpM9e8oC07fA5+8/YeLtzUUQ8W3AniGNxq97uYtgkAHwXR4CHs+rZBg?=
 =?us-ascii?Q?1xOzE/Np+mG3miheaMS8im2FLFH1rqi7BcbFos24YrsOoYxvZ5KVX6r8SBS3?=
 =?us-ascii?Q?0YoYmhSeLyHJb6kRfmaSAW0Pai4xaX+llwV9e7Jy4cWyR1ZT92XKO6CyXG0F?=
 =?us-ascii?Q?CSWGkpdvfejxutWHpHucXjS+u+iUJKZXFdK/8G/ksSEFrgl/NQuE4C2lAtEn?=
 =?us-ascii?Q?h9DatxjgtLmaQr2mXcdeAmMD799pdPJznuxrhZH8JXbB6mkQukRZh5uH+aeC?=
 =?us-ascii?Q?uU7jr1D1D7S7iNBCdYfgQz3esLc9XXrl7b+PCopoC8/ZGcGgqViR4LBgJPmx?=
 =?us-ascii?Q?HuT51asBXoTv73J62ns6ZfSyQMZTWMGiaFOxixuZ8WSNzGZuGZ6JB+F4YJGH?=
 =?us-ascii?Q?EZgqZ1DuH6ydgeD5EOQhXNoIfZyVqDy7TKxvYNkaSwWekM5KXv/jpTGT5YQG?=
 =?us-ascii?Q?g6JR47I9HsbcUdL2E5vCw3ksfkZcNdGsP0WUAmM8NYMz8TzIVIBRsoNdwUog?=
 =?us-ascii?Q?JWPZXC5un8Vup43e3UIl5c1NOPokzu46mW+/kLAPpZ3W46dTCabGGk/TQvpe?=
 =?us-ascii?Q?dgGl0bnHacOaTccXHevEm8UlpUryW9AaSS7PYKkQApjzhBcGmpHD479HIX42?=
 =?us-ascii?Q?MNiF7RVQ4x9VomSlfNDI3mCzoDN65VHXbmQZdIYcBtGUxG9tuVWkdV+FhH9A?=
 =?us-ascii?Q?T3MdnYl3zN2Dww7iaFJC78DhTV6QEsy/w6Mw/f7raAp/JegdzcYG+GsI+c1S?=
 =?us-ascii?Q?RTDZQWjwiAKWLKPRj2LCl4MSB4hSv1jVMW97DmS9cNzvhCSJ2eN8hFDd+IcU?=
 =?us-ascii?Q?rYsoSQIQalLFZUlH25YtkceNiiLt8A7CDWrvW2vTKFCkM72ofmRhST3lZuw2?=
 =?us-ascii?Q?U4QUWtBZvY8zfXl0ke7ZdmAudFCxtW/II4dpq0ZE23pexSHCAWa8rrM5yRre?=
 =?us-ascii?Q?3Nn5Z3U6xeZrLxQMBq2+lcYdxS++0uoI9CPj6Dd2svwo/zIaBAR7prcNrSGc?=
 =?us-ascii?Q?CLZ9whciXAJskLGLAR+Oa7i+MSJOcX1Aub6sDbFm2g+YrWAAIQ=3D=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9c57b50-a330-454e-62cb-08d978943c7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2021 22:00:31.3684 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O34qKnAbtw2ByhVF9aFKeDDwCX5GdLs1XJoWfUWMJN6f1/5xSVg/b2MfhhjmmO59VwXTYMJwD7sFlsMfS/qQ6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4409
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210915_150035_977622_5E9F9821 
X-CRM114-Status: GOOD (  22.69  )
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

On 2021/09/16 0:43, Christoph Hellwig wrote:
> Various places in the nvme code that rely on ctrl->namespace to be
> ordered.  Ensure that the namespae is inserted into the list at the
> right position from the start instead of sorting it after the fact.
> 
> Fixes: 540c801c65eb ("NVMe: Implement namespace list scanning")
> Reported-by: Anton Eidelman <anton.eidelman@gmail.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/core.c | 33 +++++++++++++++++----------------
>  1 file changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 7efb31b87f37a..3894a8508065d 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -13,7 +13,6 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/backing-dev.h>
> -#include <linux/list_sort.h>
>  #include <linux/slab.h>
>  #include <linux/types.h>
>  #include <linux/pr.h>
> @@ -3714,15 +3713,6 @@ static int nvme_init_ns_head(struct nvme_ns *ns, unsigned nsid,
>  	return ret;
>  }
>  
> -static int ns_cmp(void *priv, const struct list_head *a,
> -		const struct list_head *b)
> -{
> -	struct nvme_ns *nsa = container_of(a, struct nvme_ns, list);
> -	struct nvme_ns *nsb = container_of(b, struct nvme_ns, list);
> -
> -	return nsa->head->ns_id - nsb->head->ns_id;
> -}
> -
>  struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>  {
>  	struct nvme_ns *ns, *ret = NULL;
> @@ -3743,6 +3733,22 @@ struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>  }
>  EXPORT_SYMBOL_NS_GPL(nvme_find_get_ns, NVME_TARGET_PASSTHRU);
>  
> +/*
> + * Add the namespace to the controller list while keeping the list ordered.
> + */

May be add a note here about the impossibility to ever get a duplicate NS IDs ?

> +static void nvme_ns_add_to_ctrl_list(struct nvme_ns *ns)
> +{
> +	struct nvme_ns *tmp;
> +
> +	list_for_each_entry_reverse(tmp, &ns->ctrl->namespaces, list) {
> +		if (tmp->head->ns_id < ns->head->ns_id) {
> +			list_add(&ns->list, &tmp->list);
> +			return;
> +		}
> +	}
> +	list_add(&ns->list, &ns->ctrl->namespaces);
> +}
> +
>  static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
>  		struct nvme_ns_ids *ids)
>  {
> @@ -3793,9 +3799,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
>  		goto out_unlink_ns;
>  
>  	down_write(&ctrl->namespaces_rwsem);
> -	list_add_tail(&ns->list, &ctrl->namespaces);
> +	nvme_ns_add_to_ctrl_list(ns);
>  	up_write(&ctrl->namespaces_rwsem);
> -
>  	nvme_get_ctrl(ctrl);
>  
>  	if (device_add_disk(ctrl->device, ns->disk, nvme_ns_id_attr_groups))
> @@ -4083,10 +4088,6 @@ static void nvme_scan_work(struct work_struct *work)
>  	if (nvme_scan_ns_list(ctrl) != 0)
>  		nvme_scan_ns_sequential(ctrl);
>  	mutex_unlock(&ctrl->scan_lock);
> -
> -	down_write(&ctrl->namespaces_rwsem);
> -	list_sort(NULL, &ctrl->namespaces, ns_cmp);
> -	up_write(&ctrl->namespaces_rwsem);
>  }
>  
>  /*
> 

Apart from the nit above, looks OK to me.

Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>


-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
