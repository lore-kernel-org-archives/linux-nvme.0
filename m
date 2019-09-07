Return-Path: <SRS0=r3NF=XC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B608CC43331
	for <linux-nvme@archiver.kernel.org>; Sat,  7 Sep 2019 18:43:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8097D20854
	for <linux-nvme@archiver.kernel.org>; Sat,  7 Sep 2019 18:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ck57D07f";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="al30nZav";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="cTKtuvUT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8097D20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=STz2I51bKhWf+4LalgXXI9R9Ts+gMUiCgLxugzNV8uo=; b=Ck57D07fySfarG
	qxO+xGwwCrDP9DStqWtCc0dCbGc4VWqgs6pAqDoV1ZwyOakWvkKGysikKEslFkxlKe52syJKox2aQ
	Uf97uiFU5lrUrLiK32dnWSfF5+Mbw4jnCvmq/Abuc5a/vzRokDVOdF865J5Un/VuZ1EseIZ3qVbMl
	RmIpVbtkUI1Iy+qsUVHrEtUra/HA6q9dVckEao+rdfzDGips/BnKfRbow6SuNmiFf/k21m37wHrYz
	V/Jklkss2DBAqJF9Xo/TiT49jhNvPrBwI2PXkQx1DwnE7KyYAuPEh1qbpIEJlmmFgGdL4Ru/7vdwj
	4v/+smKXZOu37EnW91mQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i6ffn-00028N-EF; Sat, 07 Sep 2019 18:42:59 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i6ffj-00027a-Kw
 for linux-nvme@lists.infradead.org; Sat, 07 Sep 2019 18:42:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1567881775; x=1599417775;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=Ca/3WHO2tArSA0pRrXqVUvm7Wp4fcSJyIr0NAzN8E3Y=;
 b=al30nZav0gL5o4OciPlaMEb/wowXWuU2T7yECFDq9zSF1a4bOK2I3Mf/
 s6IXwS9LWstWrgFVT0Czd/E1AeOFpuFMlC5rAWLXJ/O1ADQ0P861fqfGT
 lNQihqtrAoObJTFTXkWuKcleoNs9nYrTSwNVZTP9YkkULtGQRInR59lbN
 GtqXfa8Aq1STHWmrgCcO5B0VCb8owLEoLop5ArM7ogw+tK0hXz56+WQpU
 IBr4BBwlZot0+kg3elbaLJDJqov0IWg2d/eW/hNyIVn6sgOko+gMd7a+n
 heHuI4uE+BVym03U3Xp+antxG3Y7myCAtn5uncIIPTVYpXwqsglpXif7f A==;
IronPort-SDR: pS0wKdQTYnjXVSJSz5tRuOZYmLi87KjTpGN2jnf0kh83PkAazfKV8ppha/c7CFDrkK3aWy//eN
 YscEPnxV1j94pkF+ilNwqEKFwi8T+I7n4BJ9PdDkWuvMPWPKgnSVCxG6bfDCJr7krkpP2troCU
 l31BI98oTSHUTILA5YuX4xv8dAMTscYtkLwVw0BZS4/SfgUroZvPlrJGmpsmI79BbF/9u3g2Ic
 KSwLKXbLt1sx2c2NOBYHNxbo1CbVL0VKVx2bWAl8nfar5nQdx7/u/q3Ytef7yTWOCE+pezFPs3
 +o8=
X-IronPort-AV: E=Sophos;i="5.64,478,1559491200"; d="scan'208";a="117739897"
Received: from mail-by2nam01lp2051.outbound.protection.outlook.com (HELO
 NAM01-BY2-obe.outbound.protection.outlook.com) ([104.47.34.51])
 by ob1.hgst.iphmx.com with ESMTP; 08 Sep 2019 02:42:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T5yuRsIpC5RKuDnHfXUk75n25+W3X3Ra7Csu96L9jgKeHTKaVlEq7+LSyjrM77vqAccE1vCSsul4dONJjuQwC0CkAKYAzExrzGp5oI1QSolVgQCVim1bvzRrGfS1a9+I6fpd5zKA0AnBPI/9nxexGLBsX0MLC/uwQXIXaU3/nrZM8Dd2Fbu6WH8DQCbFH0gRftVh0SsWQJkRhSEltMyLGyOAR7+91+grjbNh+QveTH9YDkBBsdaFFe4tJKrLVblNUIY4UUjndUHVN+p6XURN7vAXjljZO8J4cEoyFIjKr0ig7rSq6QZaEdRvwQPLCznIVu0shFNec5ZLeK1qVnVaHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RftVf8WrnRNBQnWCSBJaZP6MC1X0ohQ2OzKPZJ2HZFs=;
 b=hObcFp6n+46rNwXmQkeGeyqglfthATOsInWWMLvtWnxTiV4Fbvs0iRYY9iA2TzZuTGeNGc6ABmEhkq/0LY03YmL3RKoy6O/dE2z/ky2Zfgf4qb5uWmBWfSHT3I1wMygbPQAj9irHsbu8XIs435GJKvh71DNOUcnz9exdbPabieOpZQCYcnbBXffwJUlxVLp9fcq2wYGkefaOXgpjuS7onU37OJEQw5p66BXZXq1zbRYKrNyE1sZLPo/e7Oiyb5eNrS4qyAqdkZ3Nnps/nbltHESQyduyZ97UfkKLdyu958xfb1Bd5ASxcWjImJTUdUvSW3DMknC2EaNELBzfbmv6qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RftVf8WrnRNBQnWCSBJaZP6MC1X0ohQ2OzKPZJ2HZFs=;
 b=cTKtuvUTGZcF1pIiFo6OCXzeC0v0DGw//eUEkzPJjhukbYbnMJo7Aacw9TDyddnBGKJHLlTJq9AEwMjrTtdUKqP+J3tCTwn2FtzGLL0dsBpQXo4cbLNEAovx3q0ddUnXw9cfhWbqtVEo78skWZLeOjwX82gOtM5jBcCVo05Ml4w=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB5400.namprd04.prod.outlook.com (20.178.50.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.16; Sat, 7 Sep 2019 18:42:49 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6169:680:44fc:965d]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6169:680:44fc:965d%6]) with mapi id 15.20.2241.018; Sat, 7 Sep 2019
 18:42:49 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Sagi
 Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvme: Restore device naming sanity
Thread-Topic: [PATCH] nvme: Restore device naming sanity
Thread-Index: AQHVY0b0r2H6Juc7x0CaNQILnZjrrw==
Date: Sat, 7 Sep 2019 18:42:49 +0000
Message-ID: <BYAPR04MB5749E4FBF82F23C41A494A6286B50@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190904173159.22921-1-kbusch@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3fe34546-8bb1-4c24-b256-08d733c32eca
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:BYAPR04MB5400; 
x-ms-traffictypediagnostic: BYAPR04MB5400:
x-microsoft-antispam-prvs: <BYAPR04MB5400E402CEF62A5FB65CEC3686B50@BYAPR04MB5400.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1468;
x-forefront-prvs: 0153A8321A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(396003)(346002)(39860400002)(136003)(366004)(376002)(189003)(199004)(305945005)(54906003)(6116002)(3846002)(25786009)(2906002)(71200400001)(71190400001)(446003)(476003)(486006)(33656002)(86362001)(6436002)(2501003)(66066001)(316002)(74316002)(52536014)(229853002)(5660300002)(478600001)(14454004)(14444005)(256004)(9686003)(55016002)(53936002)(76176011)(186003)(64756008)(81156014)(81166006)(66946007)(6506007)(7696005)(8676002)(66476007)(8936002)(26005)(76116006)(53546011)(66556008)(66446008)(4326008)(110136005)(7736002)(102836004)(99286004)(6246003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB5400;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: U4/mZr07d8lHnjn+1LSyyONGYjRx/K7KS3OsW2tOg1yscrGjCasGnlvbVl2odrSaJ7xEil+TVNOc4iCv/oCdhqYH+U0kY4LhkIzpKGV8J1K8jsFzrFLAE/JvkqmSQWRcak7rKKGS/9nv6oqJKykqXLSVN1Dw41Q3ndu7VQyuHK2UHHtLC9hueB/bnJnzJgTF8WeGUiEjLqWmq6Fd0Gmkpxw6S6R+skze42jQWYQnZyBTeCJNHwhUYq6GaD+nAZtGkoTRUymaFgW9t0H1Y7XB34W9PJOTRSrKvdeOSgTMHmICyMTOhdZFuDpko0KbkzYP/hiy6MMySDp5bkZDtojco5DTTT+IYjEPDSlnpQ4x7NRZMaCdtC4XlQhIGKrHKogN6v6O/2s9hAAOhMSq9IERQsofKEi6MKiYnbFhT6m7wKQ=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fe34546-8bb1-4c24-b256-08d733c32eca
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2019 18:42:49.1750 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CBZ9xwPG28MPPkc3EudRG5Jt444ZwPfTYevXGBvKEXGBaRsyG7a22aALKNczLh3ECpeAd87KOACUM/KH67VoGOYVhbD1iVjAMcxLY21Q3G4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5400
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190907_114255_725945_072AC91F 
X-CRM114-Status: GOOD (  16.35  )
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
Cc: Jens Axboe <axboe@fb.com>, Hannes Reinecke <hare@suse.com>,
 Logan Gunthorpe <logang@deltatee.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Apart from the some nits, this looks okay.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

May be subject line should be 's/nvme/nvme-core/' ?

On 09/04/2019 10:34 AM, Keith Busch wrote:
> The namespace names must be unique for the lifetime of the subsystem.
> This was accomplished by using their parent subsystems' instances which
> was independent of the controllers connected to that subsystem.
>
> The consequence of that naming scheme meant that name prefixes given to
> namespaces may match a controller from an unrelated subsystem. This has
> understandbly invited confusion when examining device nodes.
's/understandbly/understandably/'
>
> Ensure the namespace's subsystem instance never clashes with a
> controller instance of another subsystem by transferring the instance
> ownership to parent subsystem from the first controller discovered in
> that subsystem.
>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>   drivers/nvme/host/core.c | 21 ++++++++++-----------
>   1 file changed, 10 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 14c0bfb55615..8a8279ece5ee 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -81,7 +81,6 @@ EXPORT_SYMBOL_GPL(nvme_reset_wq);
>   struct workqueue_struct *nvme_delete_wq;
>   EXPORT_SYMBOL_GPL(nvme_delete_wq);
>
> -static DEFINE_IDA(nvme_subsystems_ida);
>   static LIST_HEAD(nvme_subsystems);
>   static DEFINE_MUTEX(nvme_subsystems_lock);
>
> @@ -2344,7 +2343,8 @@ static void nvme_release_subsystem(struct device *dev)
>   	struct nvme_subsystem *subsys =
>   		container_of(dev, struct nvme_subsystem, dev);
>
> -	ida_simple_remove(&nvme_subsystems_ida, subsys->instance);
> +	if (subsys->instance >= 0)
> +		ida_simple_remove(&nvme_instance_ida, subsys->instance);
>   	kfree(subsys);
>   }
>
> @@ -2473,12 +2473,8 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
>   	subsys = kzalloc(sizeof(*subsys), GFP_KERNEL);
>   	if (!subsys)
>   		return -ENOMEM;
> -	ret = ida_simple_get(&nvme_subsystems_ida, 0, 0, GFP_KERNEL);
> -	if (ret < 0) {
> -		kfree(subsys);
> -		return ret;
> -	}
> -	subsys->instance = ret;
> +
> +	subsys->instance = -1;
>   	mutex_init(&subsys->lock);
>   	kref_init(&subsys->ref);
>   	INIT_LIST_HEAD(&subsys->ctrls);
> @@ -2497,7 +2493,7 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
>   	subsys->dev.class = nvme_subsys_class;
>   	subsys->dev.release = nvme_release_subsystem;
>   	subsys->dev.groups = nvme_subsys_attrs_groups;
> -	dev_set_name(&subsys->dev, "nvme-subsys%d", subsys->instance);
> +	dev_set_name(&subsys->dev, "nvme-subsys%d", ctrl->instance);
>   	device_initialize(&subsys->dev);
>
>   	mutex_lock(&nvme_subsystems_lock);
> @@ -2528,6 +2524,8 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
>   		goto out_put_subsystem;
>   	}
>
> +	if (!found)
> +		subsys->instance = ctrl->instance;
>   	ctrl->subsys = subsys;
>   	list_add_tail(&ctrl->subsys_entry, &subsys->ctrls);
>   	mutex_unlock(&nvme_subsystems_lock);
> @@ -3803,7 +3801,9 @@ static void nvme_free_ctrl(struct device *dev)
>   		container_of(dev, struct nvme_ctrl, ctrl_device);
>   	struct nvme_subsystem *subsys = ctrl->subsys;
>
> -	ida_simple_remove(&nvme_instance_ida, ctrl->instance);
> +	if (subsys && ctrl->instance != subsys->instance)
> +		ida_simple_remove(&nvme_instance_ida, ctrl->instance);
> +
>   	kfree(ctrl->effects);
>   	nvme_mpath_uninit(ctrl);
>   	__free_page(ctrl->discard_page);
> @@ -4085,7 +4085,6 @@ static int __init nvme_core_init(void)
>
>   static void __exit nvme_core_exit(void)
>   {
> -	ida_destroy(&nvme_subsystems_ida);
>   	class_destroy(nvme_subsys_class);
>   	class_destroy(nvme_class);
>   	unregister_chrdev_region(nvme_chr_devt, NVME_MINORS);
>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
