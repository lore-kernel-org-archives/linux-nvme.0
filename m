Return-Path: <SRS0=Ir45=W2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C49F4C3A5A6
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Aug 2019 18:42:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97D3023428
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Aug 2019 18:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jSXkU/ln";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pihXcjOb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="sLShbTvU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97D3023428
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=kd/nIOqT5WDMGoM848Dga8vWNLX/9a24Mjy4OG+oxZs=; b=jSXkU/lnO3K2ry
	dY3RPVvS2KwTqDjqpHZnYUA32fb7EYeWUIA18A7HZzfllE5Ukzvrc6F2d9E2nePOpSa6zLmKYv5iy
	cott5c4YNl2So1KGGQGzkw0QUuje0mR5HlWWpzxdEdeTQ5Pn+tfSQqbt0aYghbLDOkENWgm53tr4x
	IB4SCeqtIjDShIShiO/F9UL3VfT3DEZmLCZVLRs6yiVeKT7OaKVzZEcWGyO5mAI2WI6G7ZsHh3m/3
	IpcVfYhq5ynzYDAl21Y41fZLZk/PElvHnE1z9tXh3G9rFP287WKYjZixdyVLCScyqLJQhZwzI+nUT
	9NGYDQPU6lGePBqN7jKw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i3lqY-0005k9-CS; Fri, 30 Aug 2019 18:42:06 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i3lqV-0005jo-8p
 for linux-nvme@lists.infradead.org; Fri, 30 Aug 2019 18:42:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1567190523; x=1598726523;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=NU+FYInIwTiRE10clTiY1zKznNt8D/qyQ3BGU85Laa0=;
 b=pihXcjOb94CM8jqzsjBdom+pXAeM59Q7laeI/68Y7UTMVc9bWLldSoeT
 l76HOYVttT8dA8UiyUZUEZl1oWZwd2mVXw0NENSqrGkcNLpD0JCdB0EI1
 N+UQ4JAh4YtfmU/L2jGJFM6rnV7+VDqMU1TWRXAUpHHwUXp7hUnOVX4Kv
 zevumYSGwKCeBZ0LBWi4HgfrBmANvudfjm6UebwJAKUYnR8JfteppD6wK
 0UIrnsoVUMqGEx8O9cAAlaDBNXjIuUca7ENYyd0zQSoweaXofk+qGzruQ
 uDfLMrnqHKQGK3ov3cxB76OClyKkuN9JYEssjO4P/dXvGtcEKNY3o1jOu Q==;
IronPort-SDR: amVZe2Wcz7JTROlYnAI8KH9VxA3WY8i71+QS1XTuc/TSTwmKl3mKQ+PUhwolo+Ejo9vrRpe/yW
 02hb/lH3U21HS1SfMPBPxKK74VgWQx32JTzAxRlPA3vlbrZw53FxJN31IabNIvpl2mHjISmvdZ
 71I7Z/lmNRPMpoqhWWR9bZjSqiskg0O9XD8nU5++vnLDOTEs/xLuXXKMZ9PvwKmTbNJb7S+/fn
 DWkBEesvR0tZXpPICH+DoP2CMMnwy438S8LUB6bN6RaiuuSd81FR6wRujBGBKisx5vTZSF0KVj
 16U=
X-IronPort-AV: E=Sophos;i="5.64,447,1559491200"; d="scan'208";a="117063701"
Received: from mail-bn3nam01lp2050.outbound.protection.outlook.com (HELO
 NAM01-BN3-obe.outbound.protection.outlook.com) ([104.47.33.50])
 by ob1.hgst.iphmx.com with ESMTP; 31 Aug 2019 02:42:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gvv6eFHIoON6i1EEo/RW8wbUjABHdVwY/3X98pffGOS6hE9q7xAnY1hMeHXq3Xha2PmGO1gjs9sS8uV6DxPk35Z1RJmw0Jw/b/moviqw7/GK88y8N3D/Zo6SjEigJUt+Zq1cIDOGgTZh0rv9ZKaxmTF2kRuInIdzqUmlFoa6csHCQU//0Mw2eefngwMTjzWYlSpSjk1sgH1MQyg5wvfks6+wz45xxM9Jfdi9LgXhGokaWx3+4HM+vpP+yH+PNiYpDOLP08TFosiv5jMOEhxPl3NpG+kkUvtcKNzkBYj+p1HACH/ikmMluaM5AKqSTTcTe6xxO/b6o3oOoBaMcCG4lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D47eSUe1NonTdkUH35Vmfa6QMnVF8+hq6dFul2B4kKg=;
 b=NMQ6V+J4jY3+YlD+RKZw/CGV0fT1LCsnvO+z+qJD4r29RnOhPQt2hXjBmBButCI4olr5jFc7VVSLXb9DrvgTgOPYvLHKehCpTAC1j7KWet7R+xV8TuH7uacy6SX+loPfuhQWt6lSEEu+rybd1k2d3ggtxgpgYrayfy6XjkQOPPfjsaV4HwrmfIUhtsMQv2SXuI+EmxK94xLazndwL83l6mvYgkDlT4MGerVcaIWUiV7M/s41rjoYdz1DQtgIPQ5jhXEL+h2O+DMshvKWuuDkTEoxWjPpaNGFecUhsMQJNajhf6dkH/Qihnf+78sgo+zB/jjIBV7jJ0xWB1NUkuDvxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D47eSUe1NonTdkUH35Vmfa6QMnVF8+hq6dFul2B4kKg=;
 b=sLShbTvU0HuYo5ZkYckHnVL6+jGZCZonYJbuBvb/nM/UAW0rxamWrXzxbx6QTUYgI8we56tNzIdCbAeYCmr/5MwdUpyUosIjoQJOvebILLCYVya3EwV38Mt3KmOdq82/g/phYMVrMvaawmwNV/TU5VJbHJxcnu7JNzZhDND+gRg=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB4341.namprd04.prod.outlook.com (20.176.251.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.19; Fri, 30 Aug 2019 18:41:58 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::b066:cbf8:77ef:67d7]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::b066:cbf8:77ef:67d7%5]) with mapi id 15.20.2199.021; Fri, 30 Aug 2019
 18:41:58 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v9 2/9] nvme: make nvme_identify_ns propagate errors back
Thread-Topic: [PATCH v9 2/9] nvme: make nvme_identify_ns propagate errors back
Thread-Index: AQHVXrYpXQ6UiNrXfkOK3XdQgKzqQw==
Date: Fri, 30 Aug 2019 18:41:58 +0000
Message-ID: <BYAPR04MB5749FFF1E5CF489B4D194DFE86BD0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190829220645.5480-1-sagi@grimberg.me>
 <20190829220645.5480-3-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.170]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9848202b-4ceb-4925-b9b6-08d72d79bd16
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:BYAPR04MB4341; 
x-ms-traffictypediagnostic: BYAPR04MB4341:
x-microsoft-antispam-prvs: <BYAPR04MB43412C6572A895A7CC8A744486BD0@BYAPR04MB4341.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1122;
x-forefront-prvs: 0145758B1D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(136003)(376002)(366004)(39860400002)(396003)(346002)(189003)(199004)(229853002)(6246003)(478600001)(66066001)(55016002)(6436002)(14454004)(9686003)(53936002)(316002)(256004)(4744005)(8936002)(6506007)(81166006)(81156014)(76176011)(186003)(99286004)(53546011)(26005)(102836004)(7736002)(305945005)(74316002)(8676002)(7696005)(446003)(476003)(6116002)(54906003)(110136005)(486006)(2501003)(3846002)(5660300002)(86362001)(4326008)(66476007)(66446008)(25786009)(33656002)(66946007)(76116006)(71200400001)(2906002)(52536014)(71190400001)(66556008)(64756008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB4341;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NE8rhOm/rAjJ+HmImrkaOFwzn4wVDch7wPKGTDTp/Kyni0qIecolX2fl1I5M8/rZZn3HoPcNwbtvRynQ5RXzMPx6ApLH6jtNqTScmxBYLIFsO09AIZSYwmh3i1S3aTeeeqpZf1REO/EA3gxZyyho9lf9Kt/UH0RcIPD514sqT9DMJIGQ2stG0TNI3TB9JACYx3Rqo1xl35F0Ol0EKgnEddn94e1cVmpiOflAhgDJllEBo98qDH4B5268EHTV6yFAYWTLeVCg0htaTEw80mBHrdEkF25Cum0Z3PvW+KfHbCQgisy/Vu7y+AhdUWcBgPeYCie8Wdc/h1FVIKrAEtJSuIoGHGo3tjZGa9/XFh6mynl85NKUEiYNsDN6VyxosuuXiIBbm/93+1t4nHrjji1ghxzUshNzRPT9+wniP5ol5RI=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9848202b-4ceb-4925-b9b6-08d72d79bd16
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2019 18:41:58.0761 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rClF39Rr9nOFolXSn3laDM2VDCo14TCqG6Hyl1C3BkoWIjnhPPIEwIN994KjNf8Vz1pQcM11zfcyRJutl5Pnqooj5rVkTQtuajkO8AtzwB4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4341
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190830_114203_352048_A236A0CC 
X-CRM114-Status: GOOD (  11.19  )
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
Cc: Keith Busch <keith.busch@intel.com>, James Smart <james.smart@broadcom.com>,
 Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

On 08/29/2019 03:07 PM, Sagi Grimberg wrote:
> right now callers of nvme_identify_ns only know that it failed,
> but don't know why. Make nvme_identify_ns propagate the error back.
> Because nvme_submit_sync_cmd may return a positive status code, we
> make nvme_identify_ns receive the id by reference and return that
> status up the call chain.
>
> Reviewed-by: Minwoo Im <minwoo.im.dev@gmail.com>
> Reviewed-by: Hannes Reinecke <hare@suse.com>
> Reviewed-by: James Smart <james.smart@broadcom.com>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/host/core.c | 30 +++++++++++++-----------------
>   1 file changed, 13 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
