Return-Path: <SRS0=OKIn=7E=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1736CC433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 22 May 2020 00:59:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC0CA2083E
	for <linux-nvme@archiver.kernel.org>; Fri, 22 May 2020 00:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XxuSbDz0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Yc6expRW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="f0G17b0v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC0CA2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=13OzRbNeU5/U0bZafOcya/3MOpTdG6v9qQzt6OXJFKg=; b=XxuSbDz0QHdjB4
	T11YWJ8dN3xrVaXS2p8rRv23ChQTJMMtmoFYB1dmhoPlFp7xgFLSdt5Coaa6KySl8JHZXNNUgy27v
	Ym5sO15hJuAWSB6eMKkXdbprKHGPfueVC64CgKJkItddBnBvt2l8iJZrjEOEDFTFcdsPRvrSgB1Rn
	MvlPf1uqXj3EfpTieiE72P9MNLX9vErP31afVVMBYL5na6iP6UuygyMfAJrLmEN+8A7KAyJ9gniE8
	C/Q/VSGxniw2XDV9UdvwOwQFV6pgCiKv1MwYPQAJMqn0Qd9jWBKYMZJzahpLnu3n/LvmdVsvFqbiI
	ucE01Lkl3SOHK3zsHW7g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jbw1h-0003En-7b; Fri, 22 May 2020 00:59:05 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jbw1e-0003Di-DN
 for linux-nvme@lists.infradead.org; Fri, 22 May 2020 00:59:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1590109142; x=1621645142;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=IzexgZoG3waFvthaWTLsOIvyj2T8pqbnRth1xunAA5w=;
 b=Yc6expRWTmPxWBsvK8+XEL2UD6wl1R6iBwD8U3KKgzeKm8d5wD4DZ8tF
 338YJbIOiAPROkTxxYrmKl1Ey2CjGZ5pGWs+PtQnJ4dEcUa1TcgXZInHM
 iveSEzSBmgDeQ/rkV30wZWaz2oKEW6R7nYdSuRxqRnzzwv9jO01WiSCLW
 3P5rw5oAJEkItmrFW4WlJHL7bdRf+iEngltOA82DoK8MRvfmifverzdtn
 WDl2+K0TXPdrvYHXXITZMmpfSbfw8+0y/1yWbdf9LzSGfYWDBsvOEyLHu
 YYdyT7yI9izSaihpH4c1xwoJppavDSbShsfQGgBIMk1UfzA+sy8IYDseg g==;
IronPort-SDR: CDubTV8FEtUzy+kBNJtvEVnBqBZ7r5EYWbxI4vGM23Cj2Nsk8QxP6kRZezLWjByfCGN2irOIzn
 lTpSplF3V3msjqMRP0uMsVgogmdzelK5dwSEvjTUTkKQEWvbO78x9Nhk8mkOjrC2vXL9rgggpN
 0g+eCMhTMEH6sBAORKu6kkJ+vupZnQU6KgZgAYFzBVRnFzvXiMs/ZU7M48ZFhA2H8u8Y5deklD
 lP5Cxatf/XENEx0M7HF7pG0C3jJKN1QT+UpOmWD8AnSf+OJ4h3/Rd4cnsVQUYX3ofL0YeUiQ5k
 o4g=
X-IronPort-AV: E=Sophos;i="5.73,419,1583164800"; d="scan'208";a="247274967"
Received: from mail-dm6nam11lp2172.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.172])
 by ob1.hgst.iphmx.com with ESMTP; 22 May 2020 08:58:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mTWqFvpS4zmwQXESlb/TU1s6y84iQjGE4H/3F9tFwpuy+t2gz0lRg/QXmFgkjSQQImwiHAjA0D0Nk21PXMnSQHVmTXHuga2OmanJe6HBK5WO3eB1zv+pfcJ6e6uKzzhilI9S660brDR9uOge6TRQMblbHQjBZD3grZfWCW3qT+sMFF95Pdz0k1rX3sf8JfN18OnIQ8WdNvAcBhLauiE1gGBmk6CXzNCE/kPlQHzn1hdYbBXJaeUvGhYFzENgB/BwJqHvUyIz6iwt9PN0H14aCIDaQhgnR5maZ4eQYXbXuhVyzAW381fTUR4sY28a4GvDd/8Sj9GgQ5iHuDSfFA7kTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=59P/tQprizSBB3YA5gvsErqo9kqdp/6p9YxTd8sXJrg=;
 b=Saao9JXsqABq6tR4cSRN1sN9GN7q9PJRYYd4wiQ+fd5NPDaWUHrkbhu5dOM2LDHv+U6MplZWKvNd1fVIotNjxD3FlQ2AvbdzZz05s0Q675viNfcZURt5GN9YID9BVWONEcB3OgPSyMJPF5Hcm47jBsyaE1nmOC57Zgjg5pb7K8scXnkds9R0fuUlsxUEh7j/EmbSHnpWo5vAQ77+MwVT9EZJbjtHwZ76vDcj85Df+OzLj89mO1UZTLh7IbP1gNu1Jqp5WkLbUIGAKB6eLEm6pgaa8Kv5eaZgYUx6EDQFNUoGCBoY/2QKXJcvoPcOLUeiCyj5Fh2QZNW+88ejMP3SPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=59P/tQprizSBB3YA5gvsErqo9kqdp/6p9YxTd8sXJrg=;
 b=f0G17b0vALQM+FrqSB3msk4rHWCA2XPSf8VuTSnfoKuDET3FWiAGWfTwBG3cAA5pbwmIrpwddl7RCrXkeUFIIEO0jaZI+JKGHEZS0a29c4c3BNhlmEBhctg04xgQ1SI3dB8RBmkvRT4zCjgvUt3vCOdooVXC8zeo4TCi4B2piI8=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4120.namprd04.prod.outlook.com (2603:10b6:a02:f8::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Fri, 22 May
 2020 00:58:56 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3021.020; Fri, 22 May 2020
 00:58:56 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Zhouhua Liu <liuzhouhua@huawei.com>, "kbusch@kernel.org"
 <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH nvme-cli] edit huawei ssd filter
Thread-Topic: [PATCH nvme-cli] edit huawei ssd filter
Thread-Index: AQHWLkiUTt0iwLFwtEqVryqKzPchdQ==
Date: Fri, 22 May 2020 00:58:56 +0000
Message-ID: <BYAPR04MB49653F95BB628CADD7DB057F86B40@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200520013922.101374-1-liuzhouhua@huawei.com>
 <BYAPR04MB496503E2EB0863F2C69CB2AC86B60@BYAPR04MB4965.namprd04.prod.outlook.com>
 <6f5a1e9e-a3f8-3653-56c6-4e71ddc26a2d@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fc7633d6-2494-4209-f489-08d7fdeb4e09
x-ms-traffictypediagnostic: BYAPR04MB4120:
x-microsoft-antispam-prvs: <BYAPR04MB4120B4F51C9A0F38B5A9C47E86B40@BYAPR04MB4120.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-forefront-prvs: 04111BAC64
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ak2055UYbg3n7paQ23S9wdVHe7lNeRXmURI7Xr+QzfU20LyQ3rLv5DOcvS67nhUN+a+vJkhi1wR92VwRtRSpacI/Vf5g++jbLLKaIvHgIjLUXS83xFi45U7ZFC6Rbw/0PSLLf79gpgxwJoWrW+O8IO6KBFJwFhpJJeGk0IwkFm0Xdzx6bdOH3lm/32R0Yw/HvLT1nDD6rh7z65ZyFk0G6JGquBjmbN8QRNM5wEpxeK2PP9hsGnIn87SfaH3bHBh7kFT3Lwz0ZrZJEgZ83RNlSP4SHyj4sB10O15wYq/QH+Jlko8HeH2YC39rCJGfE2ny5hurl3LxWO4OZp0m79OfFg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(136003)(366004)(396003)(39860400002)(76116006)(33656002)(7696005)(66946007)(64756008)(8936002)(66446008)(8676002)(316002)(4326008)(54906003)(110136005)(2906002)(186003)(478600001)(53546011)(26005)(52536014)(66476007)(86362001)(9686003)(55016002)(6506007)(71200400001)(5660300002)(66556008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: gyUQ8CYWg7I/Yg2NuDnwwRtMcR8tr1vt7832gGslGIzo5LGfA++QxOYcGCZhxX+Cuw/vSxHNc5hSTFAarA7eHsiHUO808nFttlehunPLk7EACqYHwVgo6qNQ/xGMrslKjtaGHqcOltX1ZeBMhY/wHcNH8bXxN7GrBxvWnZRZ0PajBv6RFMeaCBj0mK8rFo2RPFrv/l+DqhTLgUR1giJ4MTExpfe1jm68fIFcuW+yQAqhVm1yAPRn11DZVDVyyxXFUQtpmRWy8iN2GVxqWGOnptWrt1g9I0ahw67HUdQMycTrLAQow9oC0maIgSsge5xUTE9VC5HBE1wrSG1FsHPP81kUqVS4lM/AW4ybeku6kUGTfKG6A8MEecmWCca79YpdHVmFIfGFmFRfOYid6sufszPrpztd61CNqv33Vh7U3P68XMRqBDtCGQxwWWrhuuVPi/40VRptjx54plJN9TsGjINMux2DaILC2UZnrNWTf/E=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc7633d6-2494-4209-f489-08d7fdeb4e09
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2020 00:58:56.2952 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4lOAPf/ksquiGfmakF1eKWeirF96UDG3lW5ymPOaTk+vbxxP7tYJchDNQtt79UgpxkW/BerSZ8bVC62hFNhpXVXCLQv6Lb195INt8Ba1YAs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4120
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200521_175902_560638_3BF60FBB 
X-CRM114-Status: GOOD (  14.48  )
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
Cc: wangzan <wangzan@huawei.com>, Kangwenhong <kangwenhong@huawei.com>,
 "Wangchong \(Michael\)" <Michael.wangchong@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 5/21/20 2:35 AM, Zhouhua Liu wrote:
> Chaitanya,
> 
> thank you for your suggestion, the new patch is blow:
> 
> Signed-off-by: Zhouhua Liu <liuzhouhua@huawei.com>
> ---
>   plugins/huawei/huawei-nvme.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/plugins/huawei/huawei-nvme.c b/plugins/huawei/huawei-nvme.c
> index c935f47..b4aef1e 100644
> --- a/plugins/huawei/huawei-nvme.c
> +++ b/plugins/huawei/huawei-nvme.c
> @@ -41,6 +41,7 @@
>   #define CREATE_CMD
>   #include "huawei-nvme.h"
> 
> +#define HW_SSD_PCI_VENDOR_ID 0x19E5
>   #define ARRAY_NAME_LEN 80
>   #define NS_NAME_LEN    40
> 
> @@ -80,16 +81,15 @@ static int huawei_get_nvme_info(int fd, struct huawei_list_item *item, const cha
>                  return err;
> 
>          /*identify huawei device*/
> -       if (strstr(item->ctrl.mn, "Huawei") == NULL) {
> +       if ((strstr(item->ctrl.mn, "Huawei") == NULL) &&
> +               (le16_to_cpu(item->ctrl.vid) != HW_SSD_PCI_VENDOR_ID)) {
>                  item->huawei_device = false;
>                  return 0;
>          }
> -       else
> -               item->huawei_device = true;
> 
> +       item->huawei_device = true;
>          item->nsid = nvme_get_nsid(fd);
> -       err = nvme_identify_ns(fd, item->nsid,
> -                                                       0, &item->ns);
> +       err = nvme_identify_ns(fd, item->nsid, 0, &item->ns);
>          if (err)
>                  return err;
> 
This looks okay to me. You need to send a separate patch with V2 prefix 
and document the code changes from V1.


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
