Return-Path: <SRS0=dHSS=OF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C9DC433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Sep 2021 09:02:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3853E61185
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Sep 2021 09:02:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3853E61185
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=8+9B349ZzrqxG/hnR8DeBVq+w7ZV2XIKIQ3m9np5egY=; b=W0mRJY+TqjVs10
	uRBKQCszcW/g2zM4znBeVVW7tWSzRebGaKy79iYICgNcqhds62c/mXJzFGX0xtU6O0B42tE0aVmQJ
	v2B5Ipt7hynlshtU+kBQLSP/v0n1sY727lkXpV3VgisLUXDYGZjmL25e3X9GM2XGGUJ+5zwX3q0bS
	z2/sY3yPN9VgCsS65maeBRroDGis/emSQcOE/hKEXg2WUNqHwfvqQgjLzXXR/yAKD44uGizSZWw9a
	mRsopvEoD12qtjoCFwKiF3uyioxj/H5WHbgp+c4goHkza2lXqTsX/MyluSt1mZn9ovk4bHbU5eyNI
	Vn7yWCsVaxZEzjUhyTnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mQQnt-008ZhC-UM; Wed, 15 Sep 2021 09:02:05 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQQnq-008Zff-U3
 for linux-nvme@lists.infradead.org; Wed, 15 Sep 2021 09:02:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1631696523; x=1663232523;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=tOhK5rt4/906/8uiPaI9N6o63huiOdxsgDLoTn1Wuho=;
 b=KKFBRiNnKC/XQJZ5QRA6prfkirHxszOIztqwEx7aesNy4kFkGTlOb8BH
 p0K4B3sO/GUldZSRqt8GbtBN6Y022wkgKVhYfQffSFsT6K1UtDxGvU18/
 HeUG4GDiAZ6vPRBxEovL4OHa4RbIJOcXoLdXHx2H/DrWJJ4ktE1xsS0X8
 LUMQQzqQhTlZTekNp7Nbkdfqvg22mBstSY/tNvAE67qdCxHtRRitk1U8+
 TPkJS9CaCowxjOTWTO3pbCQDNJGhuytynWhwNRYQ7TNfb2QAhq9ITgYmy
 ZRVhW4Cjui0gfcoIbOCcbsBptrkc7kX+jZmuOblJzVkk49KTy5CMkbJdy w==;
X-IronPort-AV: E=Sophos;i="5.85,294,1624291200"; d="scan'208";a="180573770"
Received: from mail-dm6nam10lp2106.outbound.protection.outlook.com (HELO
 NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.106])
 by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2021 17:02:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TAguvIAbzq7yE/hVQn5PBUemPhB6SuYUeBzpnd9xhOXHztJ22IF06c9g65WPB6le+FBwwOetPcnzgtZA0SVJqAoYnNqgW8CMVyS6kMU3vgLT+FMjMoNkMA+QdDj1iqIp3/Dn+2QpdClaC6XXlDpLT6BLH8lgozJ1oKsNKNdHNdiaX0ZCoY8DKKkxHccGv/4OTExbECzmMuW86zI+JujsZNWqBrfIQtyr0HnaSeuw9O1ogIKTm2xR8J4pfSG34NKNrQUiKuyUJeRUMOUGDTr83Seq7SaQaphuG9CllTK9Ib/pgVWwCCZSlaql8G5GeliUVOHpn+ZFLI1G2JJE1p7J8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=E3P+hEovJsrp6152o/CDPO260BO9k5AydhENQFg0or8=;
 b=ZZMcQ6xyMBibfiiJO+fbILtImtqO/AA/aHPlRqY789K0VY1EqYI64DMOKkji+mRBLCjoDtzhl+EfCHV/egY/f8bNoU6b9AEnabtR+76TqoJ+fwfHdi3pzH6/Vfpqw0uycEhT02Lrfr+NmZjg3ObOWCHzf40AEs+up67whbRei3jIB8PcG2OydS1t73bw/+ZlzWVsEiLJbdnmUo+YUb2n3xvijgDvXLICPbBnh2WXdB7btLg1qRdz/C0mMX/NpsPcHKC5xbaIunjE3iNlHScPZkOKBQUornL95UXW8BO4E1WlM7+mXCzry2NXyb2G3YKi8udKjh6guOO5j3zVovA83w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E3P+hEovJsrp6152o/CDPO260BO9k5AydhENQFg0or8=;
 b=g/OnR1kQ2WQDKnbO29bKXbit9vg95DBackvyAzURqClL2fe+Qkwvo+3Pr6UEPlGrSROiv00h5sYwlTcM1vZc4V7v++dSkDfVzUvB4MsXOAhtuXybWF2hd2N1ODHlyY+c325Ky6PCCWsoNb+WfFrJp9h9D4n9kjs14dN2tVqzjXg=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM5PR04MB0667.namprd04.prod.outlook.com (2603:10b6:3:100::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Wed, 15 Sep
 2021 09:01:59 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::7c0e:3e95:80d3:7a70]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::7c0e:3e95:80d3:7a70%7]) with mapi id 15.20.4523.014; Wed, 15 Sep 2021
 09:01:59 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Christoph Hellwig <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
CC: "anton.eidelman@gmail.com" <anton.eidelman@gmail.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme: keep ctrl->namespaces ordered
Thread-Topic: [PATCH] nvme: keep ctrl->namespaces ordered
Thread-Index: AQHXqgMqZnbOVkPf70+Bgl2sgXE5RA==
Date: Wed, 15 Sep 2021 09:01:59 +0000
Message-ID: <DM6PR04MB708191B702A0CE3C696D3B37E7DB9@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210915072006.956307-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d5026740-348b-4e1d-3c2d-08d978277a3d
x-ms-traffictypediagnostic: DM5PR04MB0667:
x-microsoft-antispam-prvs: <DM5PR04MB0667D927877901A7FF49F652E7DB9@DM5PR04MB0667.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UogvzqfdkDPJCs3Tq5L6MtdH8waNq8J0Z0lN3hiLF2up3sgjZnhyDsf+rIIdqxFLpfzBz7U+16PVKgshE+GOd4jgkdz9VaUVeGjqOy4QKt9TcIdPBGefKcKhc4GRXCyv5n8pkqSc2izfP1qdFWQYemvGVVnsCJAGTYVRlnKUo0eSFF7rQRc0cHUrEtr8jtTv44LE3OJy5uoQwKsrIKEFmcVUpDxjnskyRNKUAbzkFGiAjVqcjEAd0YBboj3zR1p6At79sC8Uu/iZxk5taLSrW4KUXQVpHScIiq2gZKAaaMt+vCNr7imgJ5lWt6uvwrLxeTsRzrfm80knCrfrzfxwWpV/z/rYyek2RSgGLi/i32/EVYcwQ6SLL/w969da2n6SbWdJMmNKWQvXMrzttoasQwqjGng4QXPPfFUlS0LWbgjjAthqZFYn46GMdaWbcNbxmrQdBHM5nmqiylIbXWYgjHbvO/+Xc0N4sg3pkvwYzYqjPcBye7L9+VnnI5tSM6JenCCVlvcSIU3jPdDCZHFy4HMOYhzAG/7Wy97wbXX1/yu4GbWjUGiOEd0xPTaU9b681dRXsJVI9KJ9PjgTF15G48Z7He1F6wgY3RmC9A4djFXWrgvsvAz+PGLaKCnTYpGk1DM8OgAj4PiSzrRDNTTbtWexxfts6cRROsZgrSr9mlxlEE//ULUKY1HX8enL9br5k8FLPoD1pMomrFkmUs7FkA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB7081.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(396003)(39860400002)(346002)(376002)(8936002)(478600001)(55016002)(53546011)(8676002)(2906002)(9686003)(54906003)(186003)(64756008)(71200400001)(66446008)(5660300002)(4326008)(7696005)(6506007)(66476007)(66556008)(110136005)(38070700005)(38100700002)(52536014)(86362001)(76116006)(83380400001)(122000001)(316002)(33656002)(91956017)(66946007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uPq9j6QA+EP5kA3lKnGSeXbyLHf71gfCN+rAqJGWwkdF59kugWzpedPu+RvD?=
 =?us-ascii?Q?j9xykBWYxm2yq0AW+urBj4EgQydeC0EVDlxx2Xx1+VaSXCZxSiZmrHzY4iYZ?=
 =?us-ascii?Q?b66HOyhfsZ/djYcu9CCK2UmzqSL4Pv4oR8LnOhWyfaiNWM/MTeYOGbZtzg9/?=
 =?us-ascii?Q?maIdT0W1C/2Bl7nz6u1O3QKQpFwy65GeXBfP5fPnPv/X89rB1fdHRfM+UOzE?=
 =?us-ascii?Q?aLp1iymIWDQXPfFgaAiL1FHeje7b/dXV4BBumGuq8kc7FdhoFFX0+6qKS3yG?=
 =?us-ascii?Q?aPzW1acVWT7k3ApWcFU69hA3sMXsT+uyHzw9mLP6CJypq34amFz8R5bF8MM6?=
 =?us-ascii?Q?15eLgclfjvlARO+8NB5N2yxSH37HPe9ntemZO2m4wIwvgzV3KjlSXqtwJflO?=
 =?us-ascii?Q?9eJIh5mJFJN85NXOKskS7gqGzA3rvQp0jRQM9aldZKzrrTpJgEm7fFxdu3dk?=
 =?us-ascii?Q?fl7yFtH98UZxZYQxM97IFwfMXUgCQUaoaj+jrVCaqtzKqEfqFeVIOaP6YlE+?=
 =?us-ascii?Q?Qf6YTd8h3jO27/5vVChbPTbiirTaYhkFCKfVgrlRJcLMGr+GXuDmqx2e/igP?=
 =?us-ascii?Q?ygBSxRKcwE2kpV8fmP19tCT3bfZlKVlTu7N3o63xN5FPkYMYj8DpbZjJEhTK?=
 =?us-ascii?Q?JzRuhJ+dpyB/8IwSdKEsp4lzTx2m2Hbdi5rG14heNmBW5VquhFgD3PQuffmA?=
 =?us-ascii?Q?ZO255DHkRtdRLmXjCWzF+RozSjxjyiCTCvKwmtkzaUKcfKawhKgc9t/FNj+q?=
 =?us-ascii?Q?5b0/1ueU481tBINv5lC7gzJWQROMzy6DrNbEeLI2nlsnMgwb1lSYtGt3HpfA?=
 =?us-ascii?Q?wxdf26ta1FJHlOVjmFr9bMdhPul3W7oAHwaPka3wFlwWqeQKrDRbt1KMrqek?=
 =?us-ascii?Q?gPJmOTeFN18CJk54x3qf09Dt7W3v5Km+swJZHIGHS8A3Ss1hpAUGA+IGGAzp?=
 =?us-ascii?Q?w/LOWITxvSztfzomyyOp05/rcmku78Ajzx41jmkEBL7tClyWMf5FWXNWDlkU?=
 =?us-ascii?Q?IFX/rA60YwcC2eh7dPAPDG4UsgR38/2kjS9vBqZ3oSkBTyN6A5XF0i0hrRNw?=
 =?us-ascii?Q?0wJvVwTsVYMQrnFkh12ts2eSyARNc/WsRdTvkQwulmeeOMRucTLoe/6fuhbA?=
 =?us-ascii?Q?CD8WNeec29v85jM5Tpfq7WoajMtcScmaSNMMjHlC8XEe6AKW/NCzUbY0D2zm?=
 =?us-ascii?Q?cp6jFcV5Mm2HtAcwfnRkqZkhUm/Ysw6VqftU0ICJ37qm8bRnBRWbWxUmNfQJ?=
 =?us-ascii?Q?CKJD5RtEaTtD2uv2NQfUmd688l8PmEc41QJrznbGu4Rx/H6iKypG/7aZLX6h?=
 =?us-ascii?Q?zo0TucdCau+zfyI9LwxqHL+xDQ2pqdPvMnIuXWsPjAPsuEPDeGZvs3EQ0Q45?=
 =?us-ascii?Q?Slh7X1ESVWWpGZF+lksTwrZXvQBVe9ek7j2pqgWOCvQCQAw8OA=3D=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5026740-348b-4e1d-3c2d-08d978277a3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2021 09:01:59.7774 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /hvWsqWNQ+Te91R/51pDiZFfOT/jo+9u/xYFD0jLOCWH3/pZHDVSdZJM7JHdvB6JHp/A0qVcWLjp4W3KEWJrBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0667
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210915_020203_108674_AA3ACF20 
X-CRM114-Status: GOOD (  22.74  )
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

On 2021/09/15 16:27, Christoph Hellwig wrote:
> Various places in the nvme code that rely on ctrl->namespace to be
> ordered.  Ensure that the namespae is inserted into the list at the
> right position from the start instead of sorting it after the fact.
> 
> Fixes: 540c801c65eb ("NVMe: Implement namespace list scanning")
> Reported-by: Anton Eidelman <anton.eidelman@gmail.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/core.c | 38 ++++++++++++++++++++------------------
>  1 file changed, 20 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 97f8211cf92c1..3e3c835777458 100644
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
> @@ -3716,15 +3715,6 @@ static int nvme_init_ns_head(struct nvme_ns *ns, unsigned nsid,
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
> @@ -3745,6 +3735,23 @@ struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>  }
>  EXPORT_SYMBOL_NS_GPL(nvme_find_get_ns, NVME_TARGET_PASSTHRU);
>  
> +/*
> + * Add the namespace to the controller list while keeping the list ordered.
> + */
> +static void nvme_ns_add_to_ctrl_list(struct nvme_ns *ns)
> +{
> +	struct nvme_ns *tmp;
> +
> +	list_for_each_entry_reverse(tmp, &ns->ctrl->namespaces, list) {
> +		if (tmp->head->ns_id < ns->head->ns_id) {
> +			list_add(&tmp->list, &ns->ctrl->namespaces);
> +			return;
> +		}
> +	}
> +
> +	list_add_tail(&ns->list, &ns->ctrl->namespaces);
> +}
> +
>  static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
>  		struct nvme_ns_ids *ids)
>  {
> @@ -3794,10 +3801,9 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
>  	if (nvme_update_ns_info(ns, id))
>  		goto out_unlink_ns;
>  
> -	down_write(&ctrl->namespaces_rwsem);
> -	list_add_tail(&ns->list, &ctrl->namespaces);
> -	up_write(&ctrl->namespaces_rwsem);
> -
> +	down_write(&ns->ctrl->namespaces_rwsem);
> +	nvme_ns_add_to_ctrl_list(ns);
> +	up_write(&ns->ctrl->namespaces_rwsem);
>  	nvme_get_ctrl(ctrl);
>  
>  	if (device_add_disk(ctrl->device, ns->disk, nvme_ns_id_attr_groups))
> @@ -4082,10 +4088,6 @@ static void nvme_scan_work(struct work_struct *work)
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

Looks OK to me.

Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>


-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
