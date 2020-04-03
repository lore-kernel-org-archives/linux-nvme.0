Return-Path: <SRS0=Pknt=5T=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D78C43331
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Apr 2020 20:30:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8582420719
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Apr 2020 20:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="u7ed+rUz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lAROym58";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="T8+6EFVe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8582420719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=N8xzxfPxTN9NcPEL14EtvRyOu2DVW+9SFrJgYysL6xI=; b=u7ed+rUzb0QZKh
	8g2t2wRmwRA522Nf7nPJ7zfggU/jHFqjyRbnvqobus7FPZamCoIv51dydcGYOWfO5Vich9YEydPmW
	28d+y814sh00SJTnDUp0RK4+1f5B329kJ1HdEeapiW/u3H9wmsSbfnJzJb0FhVZ3AjYRBjlUbfke7
	8Z2Spuir6VWim0YnW92I8aylU/kO+kC8wuHrkPFq5j+oLET+aX7RfjDAaZvmbMOWn1gSW5hb6lbb7
	rweobprLqQAiQ1U2pKlK/zkdFbIxgELNKDUsHnnK2gC1x9vNFp9VrxVgX5q5nOdZVhxpxG9Q6D+lm
	F1mG5SzG2T4ID5KszAAQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jKSx1-0006RH-7v; Fri, 03 Apr 2020 20:30:03 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jKSwy-00069h-5G
 for linux-nvme@lists.infradead.org; Fri, 03 Apr 2020 20:30:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1585945802; x=1617481802;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=sUQsZE3e2/1Hyte3CchJEgrdHY5tsedbTcdWhgl42Ik=;
 b=lAROym58ExG0Oawbne/blWtp+BnclgT+3VOBriTe9SOIQ33eIgkvj/mE
 T6tFQB1yjiDEHsZQA1v3+Sk4wFKxpLYWGISVmUHbYbLr6MeVlmS7tYQ9b
 i7937a78ERBwhtyXH/fdB/Ac4xp723eBiRukX5vlUr08OW/zlsG0tmsKd
 sARUEx2ssCTQifnoVDmq1RY5Y/nRdEY+0z1KXHyN03KolaBtR5plakWkq
 RoOwNQmkk+OZocBpFkuZB8sXsyQdoRG5Cq+OhavcM0+h0q4BmTS3tn6dA
 uizsW9kn8CtyOGEtcIdI2JeXtVZp89NUjPheUdFVjuYnwLHxOzjHq4Tob g==;
IronPort-SDR: r8CV7x0ZEMgtpnQLUnQd2siESHJnH4DW39haGHbGVbxpBil/LhwFKxfYHNK3WFyb5GoS2O2Tn2
 0pe9c9KQBlPgyrGRpRB79BYvJ3a5OCBAMOiXEfYbz5MuqK1jsJ0uR4OPm3uRJOKtuh91cU7+sR
 L+vq98mJKK4j0ejiEE6asN7rYHdi0EYOcZqZ4wkR6yfz1qDP3sskLAFCu3wCyKeOaP7WDsH+lb
 16zXfDTDg6LdprAfz53EbsIhkJmcHrlGOZp8a60RRkaWIjulXSvRTuOCB+DtgBtwSAuQngyPjr
 zN8=
X-IronPort-AV: E=Sophos;i="5.72,341,1580745600"; d="scan'208";a="236837677"
Received: from mail-bn8nam12lp2172.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.172])
 by ob1.hgst.iphmx.com with ESMTP; 04 Apr 2020 04:30:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nyTN092D1Ffh37YDqvUrUvMO5RS+x1/81lVRV20ZxlelUIdrZirzG9b/+qVwGlgv6JRxs7FK9lzO2jFlBenpurACZUHHLyN1bkVbhKptvoXYVlNtsv/HOSno56O5d7IDsQGyAcjjXjziocGLXXuzaRukJGF2nR7Fc+HrTN9xw0UJXd2uFDHGZB3rVJBnXuhIYmkMLZFXtzAiq8O7mOFr8KXhp3LS6EAOJmMsfYoppTvgBF4leDA3c0xAW6WOw5vUF0ApUGTB9DzJsJmz7IfdyW+pK1XIPZQHfH3upV8Nr58jUUQifQeK1Gs66dg8LZ8wQzSwwv64Gl3RvYcNLGA+Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7ZZpApCIGTzS1XeLIlFWk6Dr81eJNVpakh35bui6as=;
 b=M3DnK1NXEIO8THWRe39x1pClDsifJRHJTKWkRB4Ns7mB7faFPEV3BcB2o9S8o6DVgdtPw7xV/aHJOOwbREtmwz1jx6/I7OAYsyQh+tsp/2651tskKaxsSxTDZDlhGH6dpazMvQi78nUT7gR1UPRPmJVVG8184mk4/2itvfaaMTllSdOoeGq72TyvornbSIJ5V/4hyxOoLOdwrZxRtYFHbNwy8D3BvHg/LnmcISoNgZjFMGBkfH26oJmNl1l3pMuWRm+nPSAcqAao8GJV87kzEiDwZL93yksJCWGVir2bjsP0QfyqHstdYwCm0/EuQOBdxikU+Ojtzj2A2zqhM3eqLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7ZZpApCIGTzS1XeLIlFWk6Dr81eJNVpakh35bui6as=;
 b=T8+6EFVeZb9qaYmCxFPdoEzlQx9zyzLw/C0xPrT+iatkBMo7i5oetSugY35RNIIPa0BRBD+4Mbo8f4SLKAmlhQHeuPF94JP03PaAdUtD1e+hIlphGzPsoqWCdkoSHF7W6CaCK7OM6IAPEkCypAh/0AUEQyUxz5wFNZRDWIxAG1M=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4296.namprd04.prod.outlook.com (2603:10b6:a02:fa::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.18; Fri, 3 Apr
 2020 20:29:57 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::d826:82b2:764f:9733]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::d826:82b2:764f:9733%7]) with mapi id 15.20.2878.018; Fri, 3 Apr 2020
 20:29:57 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Anthony Iliopoulos <ailiop@suse.com>, Christoph Hellwig <hch@lst.de>, Sagi
 Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvmet: add revalidation support to bdev and file backed
 namespaces
Thread-Topic: [PATCH] nvmet: add revalidation support to bdev and file backed
 namespaces
Thread-Index: AQHWCSVL06kuVSKmBEqONSGslHKI9A==
Date: Fri, 3 Apr 2020 20:29:56 +0000
Message-ID: <BYAPR04MB49656549926DDB70C95620B986C70@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200402193052.19935-1-ailiop@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 46d63de7-3c7f-4ca6-a2ca-08d7d80dc65b
x-ms-traffictypediagnostic: BYAPR04MB4296:
x-microsoft-antispam-prvs: <BYAPR04MB4296AD4F34D2616A149CC48A86C70@BYAPR04MB4296.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0362BF9FDB
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(39860400002)(346002)(366004)(136003)(376002)(396003)(478600001)(4744005)(55016002)(110136005)(4326008)(54906003)(316002)(186003)(7696005)(66556008)(86362001)(53546011)(33656002)(52536014)(8936002)(66446008)(5660300002)(8676002)(66946007)(66476007)(76116006)(6506007)(81166006)(71200400001)(64756008)(26005)(9686003)(2906002)(81156014);
 DIR:OUT; SFP:1102; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zbB4oxFcYY8YKWJJpXfdbr6jU9PbK+yh125ixQQ2rK130y5UBPnyLlhZC2/KFYZlr0B2Femv0TKbEfHLnQspO6hWTxVNHFCdY8itX8jfKwz3TfmOPQuZSdI8LnRSV+QjzmcLDIToX32mT83fcH/psh67IvU6El6es7Yym6iHuZw+CfbJc2cOu0I+pXHE0XxpAhYnllQrmzJq6bj++NA9Ex23tw/8KxSK5e/pZ3rXlmy+cD+/Z23HEliBQROgSoQ0rlzIc6DJJXgRFL3EJTrwKg5O9xv44hA2ZBbB8DwBFrGAoMbp/vPGSHxqkn0xks69gMI2tA54PEFaRpX7YZbi7LryO9P/ym654VBnPi3rrC2rTwi08X044BKxy0SduY7a4QuHmogbKMhy4U5SiExZq4yPU9qDQ2c39akN8VjCGMnLH2AgqgcQHaLRIBmq7XR8
x-ms-exchange-antispam-messagedata: iof/TNc8ycS+WIUTC2NF7ZjHDmScNbWgrgbfJ1u+MaPj0cfU2om6y0t41xIIxtjnpIEKp3dyBmrlhbd4DduoR+L+NZ/PvhRiNg4xckcylDj0YUGarKUJRj1tAbLTKGsIkdLFAcHWW4dzO6b1cRHxKg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46d63de7-3c7f-4ca6-a2ca-08d7d80dc65b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2020 20:29:56.9023 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /YU0EkC8JZSHKBVVKt0Oo/TaJN7dH5Z1xZYpJGsiqge26cTrQ74W+u0zG2VNr3EOqFwf+wlyAn6YOWHeUNxelaq+tkzgoX/t1Cfg2ON3nco=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4296
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200403_133000_343958_963AABE2 
X-CRM114-Status: UNSURE (   9.90  )
X-CRM114-Notice: Please train this message.
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
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 04/02/2020 12:31 PM, Anthony Iliopoulos wrote:
> +void nvmet_file_ns_revalidate(struct nvmet_ns *ns)
> +{
> +	struct kstat stat;
> +
> +	if (!ns->file)
> +		return;
No need for the above check.
> +
> +	if (vfs_getattr(&ns->file->f_path,
> +			&stat, STATX_SIZE, AT_STATX_FORCE_SYNC))
> +		return;

Error handling needed ? What should we set ns->size if vfs_getattr
fails ? in case of error what nvmet_identify_ns() report success or a
failure ?
> +
> +	ns->size = stat.size;
bdev checks the ns->size != size, why the same check is not here ?

Just remove the check from bdev and see my comment there.
> +}


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
