Return-Path: <SRS0=CsQm=XR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1E3C3A5A2
	for <linux-nvme@archiver.kernel.org>; Sun, 22 Sep 2019 05:34:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCB8C2067B
	for <linux-nvme@archiver.kernel.org>; Sun, 22 Sep 2019 05:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dDjQidb6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ng6T1DxC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="trdnrTrx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCB8C2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=3db/uzBdLafPDheMXC6Z6PIb/YQilRoRJtNWjuZMyIU=; b=dDjQidb68tbJ9S
	4GcALvfeAG7KyO8S/vwSCuAt64qR1H3UIMP9y3T7+0hL3ux7sly3TkdSGpikSu9v3DZdINcVd1+q4
	m3mIzni5qzaicuuqBRi9ERhlobtwzOdVpbE173KOQX8uomGilJDgaOZ6PZN+Szuxz1fRDo8BoruNO
	IXkobXfe9MYIowsN5IVUxVzoYE7Pv7T1eHIbFlWYpP6eM2YSEz9TO/2SbaeWf09B0/I84M1OBAZyf
	3RocIhaouTUqjvICRDuDjqk5SO9WXJ/ZjGnOh4tSXzMxrQkrMSHaLaSJ9kpxyWQiaPucQ1dnvfY/d
	brMEG2HNdx9Gm5rcefSg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iBuVE-00033u-2i; Sun, 22 Sep 2019 05:33:44 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iBuV2-00033B-3i
 for linux-nvme@lists.infradead.org; Sun, 22 Sep 2019 05:33:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1569130412; x=1600666412;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=AlBqYHGorPTp4R9kR/ix6AQsdZSaELSeuuaa7p50qwE=;
 b=ng6T1DxCaB4x+II6nldVvYA2jRnVqYja/T77e2ZzGwdw3F6Y07jknLj4
 gdv1YnaOITCCzNirl0dW4TAUz4zjSqc4zJ1LmPDcvkQbdZFr4NVkVlFoi
 8nPIKjh1V3FzIY/3j9rguT8T6wxtXZ0vcYnWmxNu0WYpXvSgXTI5Dq3Rs
 4TNzbCILcIkjZZX/mbCooLEiA828Nx95Jt2howCa81p4pXDmrdU8uE30U
 o5oFaEso/nBSDUgk6WxKL/QgQebeR9y6F6OTSzfkwOnX2XolE3Q0NvQjX
 2foji0woe65YolCV5MLgExk9ShVpygVTH1PLzNSUEWRPcnBNhgCsg4yZe g==;
IronPort-SDR: 3AELqwkY+CT3Kugz23FtL2KMSTfX9D5uM1+1hTnDPUFJ3EIV8IbthAgbGQP0NxvvGEUpuFQ81C
 TFWxqIW5z1uFYIgzLrbbT0nXPkPKlujP8GFwjXI9aRZS9cSo2BI0vnF7iQDveV8Z7ssminqhVq
 h+BH0+VyWgloGxeUEr+goAo9i2xF8hQWwl7YqZO4IVss1uhdeMZoNcA5h5pRexOJWGPkz5XmTq
 q6LspIMgthyTdZLpU1AxFtbK6l2/VH3ZogMlJltOAZQVn8XZaB/g2fx4RzvtWLwabTgcbdPPLM
 DOo=
X-IronPort-AV: E=Sophos;i="5.64,535,1559491200"; d="scan'208";a="120396775"
Received: from mail-co1nam04lp2053.outbound.protection.outlook.com (HELO
 NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.53])
 by ob1.hgst.iphmx.com with ESMTP; 22 Sep 2019 13:33:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TkE5Ym3TnNfxkDN9W3nypsbuNQhf0YEfA52EhQh7PC0cnjuKum0j1iDe/MwL7UxFibq8dDpSY5P8f1Y5OGz1qxORqKXgRcxAeCDHgSQ8q62aUgNMU8+qV6F7yXdfd0211rJaRlLiH8Rk2LmrdmdX2Ba/09lks1vZfxIdx2oGqg1tCtesVf+H6jwtVh4ncOJF6WQGX6lcXeSNDykQdNVCqJ/fMQuZSjAcZuvHNqDfS+pbLLoaYQyXbab0M2a3v3vliRwZhzTV831YjbL+LnNl0TP2vUqk6vx9WxXoy1d7gr7OlauLPcTDWAFtbAVZO5Oa/EPhFv3Y41VNsYK5yTyO2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vID74Dd2DKJ75FzdrfZLXYlOHvhvHBji+pMS1folX+s=;
 b=dRa/hoXi3OURiSx/8QrWRRH5bSxu2hJFA4FPud42RUTCkTr/MjBdlZFye50SaNt9Yha3XLLAoa2o//mPbZtnXuq6trO8QqDe7SrJlPV7c1z7h48ah6QkjhcBoF/dU6hVQoOst2HDIYrWXYTTDElzx1jTycygoyIgnz5qzW71RR5HKTBYeyH3GMPxt++SRFcCf4fcPgwdzz3XWAGzJ04DlChqFD9A4YfggNIZ0noB53VmMApPhWb9Dg5g5WZsFoRqB/F+8jTeZwm9FRK6RmqaVsQDdvBD2Zt0blrOTdbio/+bydPwLpeA3xM11k19U85NBx1GWFMRsdcPFroL330pYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vID74Dd2DKJ75FzdrfZLXYlOHvhvHBji+pMS1folX+s=;
 b=trdnrTrxmzjrKQJfWT94Rt7uc6Do0JbBKPZCGsjwEJD7HGKntW8s7Mkg9kURx0cD0vL+OHoG0F42bxwO41oKyEpk+I0JeGGhxbjhkVsYq312Gba6BWoyzf37W1m7+OR8Jcp4BZoq4jbHyHdissXwJnJQ3WBRjkf3syVQiHkyC6w=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB6102.namprd04.prod.outlook.com (20.178.234.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.25; Sun, 22 Sep 2019 05:33:24 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6169:680:44fc:965d]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6169:680:44fc:965d%6]) with mapi id 15.20.2284.023; Sun, 22 Sep 2019
 05:33:23 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 1/2] scatterlist: make sgl_free null pointer safe
Thread-Topic: [PATCH 1/2] scatterlist: make sgl_free null pointer safe
Thread-Index: AQHVb9/Nml9ko61kuUmCZf1rz5rqAA==
Date: Sun, 22 Sep 2019 05:33:23 +0000
Message-ID: <BYAPR04MB5749A22666141F6BD6E07573868A0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190920181818.14424-1-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.170]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a4db592e-92ff-48fc-016f-08d73f1e6300
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:BYAPR04MB6102; 
x-ms-traffictypediagnostic: BYAPR04MB6102:
x-microsoft-antispam-prvs: <BYAPR04MB6102213D426525E748850715868A0@BYAPR04MB6102.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:200;
x-forefront-prvs: 016885DD9B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(366004)(136003)(396003)(376002)(39860400002)(189003)(199004)(6506007)(53546011)(76176011)(81166006)(110136005)(99286004)(5660300002)(316002)(54906003)(478600001)(71200400001)(229853002)(71190400001)(33656002)(6436002)(66066001)(6246003)(76116006)(14454004)(305945005)(66446008)(7736002)(66476007)(55016002)(66556008)(64756008)(25786009)(9686003)(66946007)(74316002)(52536014)(3846002)(14444005)(2906002)(256004)(4326008)(8936002)(26005)(486006)(6116002)(476003)(446003)(102836004)(7696005)(81156014)(2501003)(86362001)(186003)(8676002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB6102;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nIIeBKO1Q4LQ7TJsCBLURf7fs4TbGhAgaiXWQw6P4VLcLHP3wFsWWI3bsKNUFJ9PLQvxmFmEJSLqWlOGMGX1LxF5J/hoEuUTdvagfQIpbIZQ3OZlrVmKOauKpS7/tf2yB4Kzvo0ga2QfJ82Oxa4BXpzaAwiiPaWYOk594fikUBLJ1U97h2Tuu9LDrDkDmPbQNrAHnltuUX50QdGB3jvBIgkYDu2JPV6tjD1XJ6Ydsg92L0kX4TGLAbsZtsIaQN9CSe4EDNTyuVXQIkyZyMouLL1SS+Mvl+pwHihk5pnzUuEgN+crS6yoAXz1h6EE1zzoDnzqfVlhYmafKtf4W9drx7zyNB8+pSpifmMc8fJnQW9Q5vFcX3pw0n6fNqwI1dW/FWColOiUh0LtaoDtBxTbPbA61HJBQ0ORDIeDVomhUiE=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4db592e-92ff-48fc-016f-08d73f1e6300
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2019 05:33:23.1911 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DXVTuReGusWUxOa801WuQHOn+XcNoE9j5r28W1beScIWzvfvImg/tc98Oz5M+DaYmoZgjX1LmvsR4Bdp+sy6MThx2bcKIASS2f9cJAioJ3c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6102
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190921_223332_596023_E3671880 
X-CRM114-Status: GOOD (  17.16  )
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
Cc: Keith Busch <keith.busch@intel.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Unless I totally missed what you are trying to fix here,
I think this case is already handled implicitly to avoid
the code repetition inside for_each_sg() which makes :-

sgl_free()
	sgl_free_order()
		sgl_free_n_order()
code path NULL safe.

I did a quick test without applying your patch with some prints
and it worked file following module:-

#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
#include <linux/init.h>
#include <linux/blkdev.h>
#include <linux/slab.h>
#include <linux/module.h>
#include <linux/kernel.h>

int init_module(void)
{
	sgl_free(NULL);
	return 0;
}

void cleanup_module(void)
{

}

MODULE_LICENSE("GPL");
MODULE_VERSION("1.0");

Prints :-
diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index c2cf2c3..56fa586 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -563,13 +563,20 @@ void sgl_free_n_order(struct scatterlist *sgl, int 
nents, int order)
         struct page *page;
         int i;

+       pr_info("%s %d\n", __func__, __LINE__);
         for_each_sg(sgl, sg, nents, i) {
+               pr_info("%s %d\n", __func__, __LINE__);
                 if (!sg)
                         break;
+
+               pr_info("%s %d\n", __func__, __LINE__);
                 page = sg_page(sg);
                 if (page)
                         __free_pages(page, order);
+               pr_info("%s %d\n", __func__, __LINE__);
         }
+
+       pr_info("%s %d\n", __func__, __LINE__);
         kfree(sgl);
  }
  EXPORT_SYMBOL(sgl_free_n_order);
@@ -581,6 +588,7 @@ void sgl_free_n_order(struct scatterlist *sgl, int 
nents, int order)
   */
  void sgl_free_order(struct scatterlist *sgl, int order)
  {
+       pr_info("%s %d\n", __func__, __LINE__);
         sgl_free_n_order(sgl, INT_MAX, order);
  }
  EXPORT_SYMBOL(sgl_free_order);
@@ -591,6 +599,7 @@ void sgl_free_order(struct scatterlist *sgl, int order)
   */
  void sgl_free(struct scatterlist *sgl)
  {
+       pr_info("%s %d\n", __func__, __LINE__);
         sgl_free_order(sgl, 0);
  }
  EXPORT_SYMBOL(sgl_free);

Got the following output without any crash or warning :-

[  156.950073] sgl_free 602
[  156.950076] sgl_free_order 591
[  156.950078] sgl_free_n_order 566
[  156.950079] sgl_free_n_order 568
[  156.950081] sgl_free_n_order 579

Did I miss anything ?

On 09/20/2019 11:18 AM, Sagi Grimberg wrote:
> Match other alloc/free routines by checking the sgl pointer first.
>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   lib/scatterlist.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/lib/scatterlist.c b/lib/scatterlist.c
> index c2cf2c311b7d..fea25b035e67 100644
> --- a/lib/scatterlist.c
> +++ b/lib/scatterlist.c
> @@ -563,6 +563,9 @@ void sgl_free_n_order(struct scatterlist *sgl, int nents, int order)
>   	struct page *page;
>   	int i;
>
> +	if (!sgl)
> +		return;
> +
>   	for_each_sg(sgl, sg, nents, i) {
>   		if (!sg)
>   			break;
>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
