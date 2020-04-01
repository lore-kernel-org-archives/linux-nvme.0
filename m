Return-Path: <SRS0=eYyw=5R=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E84AC43331
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Apr 2020 22:15:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A331B20678
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Apr 2020 22:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IkWW/Ixp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AfBLzuaL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="nOMYlcPK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A331B20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=WfCoYuveSj4qeK2VRaonvvPHa8m46DwsPHO3RXiApEU=; b=IkWW/IxpbFB3qy
	uPzHa/dasX6Wj2AVinLtL0XsYDr3Vx3ELcDvwpewRiaBP+b3yzWVjOoo4Qb1905UV4yUGAyom1vKc
	VgOXoI3T2LftwjFKwOG09gn7tOi/+oO8iJ+fj2Gtq1IBZMPBboj6p+GSND4J2U4VTus9GUKQB8gil
	qehUx05OCXc3NFgYb0pgHiFPcqH9zttMBEHYXzeW7KIYFz52W/12Xh8gcmA5QeFHKTeg87axnDdir
	glLCdolQR0l/mLABq0B24kv6v1nFMUv70JlHJ6FiOZfQ06Hg16D6aX7aPkx1EE8gX/4OBqVVMltdx
	z9SJd8LXT3IM2U+lC2rg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jJldX-0003iZ-Ce; Wed, 01 Apr 2020 22:15:03 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJldT-0003Sd-Ew
 for linux-nvme@lists.infradead.org; Wed, 01 Apr 2020 22:15:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1585779299; x=1617315299;
 h=from:to:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=yytqTh9z4bIekmrFtv3Nuh0CJmYcmbPDix1GYc7IeH8=;
 b=AfBLzuaLuiO7NNXfwsiYaA+gp1yHdwIP8F72uL8v+S+s4qAF+VmFJ47b
 fkGaCaKS7elhuIPF2trr0XtsJYUSGh2YwhV9xVY3ETSlQjlcSHjKCx4kU
 myKcbmt4iMlK5RwFTj92TcvhUZoZw7jWy1feC0JCUu9zq6rdoIa4ztuQL
 oOA6M/F3CgMuo2alTZi3Zn4uOEoLCZFSg1d2ZqNKNFJFD5V1wNsHMKPwk
 LW3O22Eg4uxVP4pRaUKpADDlbOM0qQC7lsxab5El5jJpSswu2i0vzJWfm
 5RugZSlEXcDd1zcs3FHLmEO1VMcSfTyqUX0bju6a2PYkzJ2wuAQJeTX7Q w==;
IronPort-SDR: kRfb8ola9pw6gow32Jc+WYJBO9/8siwEoranTK3PkUwkjlMcT/XYu23H4ld/PxCJphNhdT14kd
 3k7iTkaMOiYh9FWUV0Fx68xO2usXqfoenJRHwIGHFIdhhsesooBpyNK8LX2cMpwCOUq1qXfJ8b
 B15D26KkhRDbpZI1N9v9k7I+OYvCwUtIGjqgr4VqEQmfXceb9qM+ZFaaCMxvMEBQ4wBHoZz8rZ
 opRb+ySPcVJ5NblSF0tvLtG34vQXUReFW6NKf67bRT5DJUn6s3XGFRIyNdtybiDL7TM06QyGYn
 QnI=
X-IronPort-AV: E=Sophos;i="5.72,333,1580745600"; d="scan'208";a="134351418"
Received: from mail-bn3nam04lp2051.outbound.protection.outlook.com (HELO
 NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.51])
 by ob1.hgst.iphmx.com with ESMTP; 02 Apr 2020 06:14:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A5PBfU/SAyJYf4A4WTq4oNIeDCLVIscPKf8KyCAftFcv2/2f9x334JWN7TQrJrigw9quv+70zgRqxtuawxqBcz+3agwThmQAgHRkiQ9uf2RQhalm7vnPnn9q6WC4TWuLSQp0qXu04z4jz+Bywi9bTU/M5+9EpMKifvnpdX7Xfa51XbAt4JI1QNLlAJ9gA0jONQ1ZhcLFWjfAmX8Q2WkOYNJByDzP6pmfftC0kLH8eTXY7jJKf7qWB0nTpJ85vLwDC/1SEQsg3tdxzgu26gduc2+QLUu31VFYuUFHyH2HSvUuLiaBXzzn/UdX0dCEZZKQeFgB07MFYkM5ckMynLpt+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PtmSjSUS/veRrCNFwShf2ltIiEfomio6nyVZGTIQpZA=;
 b=ef8jqdbIBEwboUa2Rmsj8yQsR6ZMu4pr5G1Mo+c3JkEuZzN8fTSdY4H92mvoEUUXO//R4z8WDudthL/JfE4wDsLFJ6OPWRovnB3RsRr56oXZ9tp5yfP5dcFQpA4UYIGXpq9eMQQfMB0iY3wfWdABTH3ZG/X9qj2ptYLE1k6gIMcBBE5cHcFOsgWSSlIyDPqaRTUPCJzYJAjb7N9hwASplddpKfTTYTXBwWIc+Vy6gXOcZUIKtTndsezZ6LfdlH43Qt6RmJp9qW9Pv9ZXbr9Ca9mZHEnKqPZUcsCLz/Qg0vjHI9chxtfha+iHAA3DjTIszxuW3gCLu17OlJO/OJllCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PtmSjSUS/veRrCNFwShf2ltIiEfomio6nyVZGTIQpZA=;
 b=nOMYlcPKFWgvy6K5/zLILOHxGIn2FyIub0H8X4+CQn/WtIIf1eL/0oKNr5ebltPqnM96wZ5Ve1utxXRl10CXTkou6FPw7GUj8Hv6gQFRRl5bMV58FJPV3WvVNFvJU+JVLKL1zTup27hBWAdr3EAeXoxKPOlAWb4ITGwjNxW7ipg=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5143.namprd04.prod.outlook.com (2603:10b6:a03:46::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Wed, 1 Apr
 2020 22:14:54 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::d826:82b2:764f:9733]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::d826:82b2:764f:9733%7]) with mapi id 15.20.2856.019; Wed, 1 Apr 2020
 22:14:54 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "tasleson@redhat.com" <tasleson@redhat.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: nvmet: Kernel oops during nvmetcli 'make test'
Thread-Topic: nvmet: Kernel oops during nvmetcli 'make test'
Thread-Index: AQHWCFZ6FEtYtIMGXkGri3sX8n1wdQ==
Date: Wed, 1 Apr 2020 22:14:54 +0000
Message-ID: <BYAPR04MB49659AC5A1D76560F7209D1986C90@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <bce98bfa-5740-d184-ac47-6ff1c1c97b30@redhat.com>
 <BYAPR04MB496520CAF145C79746B85B9E86C90@BYAPR04MB4965.namprd04.prod.outlook.com>
 <09a1b45a-8eda-bc0d-366e-33951ae0bdb7@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7939dbc7-72e8-4c20-14d1-08d7d68a1b55
x-ms-traffictypediagnostic: BYAPR04MB5143:
x-microsoft-antispam-prvs: <BYAPR04MB5143AAC29E1F982AAF3D3E5386C90@BYAPR04MB5143.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 03607C04F0
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(376002)(396003)(346002)(366004)(39860400002)(136003)(86362001)(9686003)(478600001)(186003)(2906002)(26005)(55016002)(66476007)(81156014)(8676002)(8936002)(81166006)(66946007)(66556008)(64756008)(66446008)(76116006)(110136005)(33656002)(7696005)(71200400001)(53546011)(6506007)(316002)(5660300002)(52536014);
 DIR:OUT; SFP:1102; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1YPWCuuAB5Z1RzEUy1Mx+TRGdbhbpsykvFzLon1l8c2eU2/dVigf2uJ6aOFR4i5HNVdvAlroYhTnC3yZ44z6z37wwbWA7u3ER0YxhETDaHprN4ZyLO6afXyrrDY5KJ5vmIVu0wiQoVxbhTT0BRsj2HfZe4b1PJaVnAYMaZLV2q6t65xQ7QgjoTynjH522lja/quVQrh81tHPWCb/qpDd9/QXYGqbWCwNvjGY2DncZ9ch8dkVKUV9UGtsuFnCDeZbbYLV2AmpAV3st0EFO2Omh78cRzODr20r5kUKW+FXhVoFoxAXeSq6Px2puoHE/ye4DOGjQKFEiTeY5EN+VRyOAkUIyr+8FDIwcbJYySEiDUdQ+dnyk0Kf9ktuKcHoFpgKlOe9r4Y3tZNFNR7Zy7aShvE9N4QBb1rGthiz0R4dbcun7mUWhsJMCMpGuT7KKgJ6
x-ms-exchange-antispam-messagedata: TjmIjZ75fyERABCD79pYm3HUkC7uUccrl7DFwfVU3klBXflN9q0J0mHgw+oeAegSZFWhhiztM3hZRv/Qn2nB0i+53agLDANPxvQz+sVCxFeUZIpbE8Ltd+uC8+1OvQIQ0wmxjGvNFLSE74NfBv3BpA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7939dbc7-72e8-4c20-14d1-08d7d68a1b55
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2020 22:14:54.7017 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SkiTum07nND+LZaeh3zw2LUIOZxyBzSVcYiX3EQbn4wKO3gQ/sUfh1oyZrizHytgJ/lR08pQnyTDsQeQwRN57C+zcFtaAwn0POQoLr4t/2I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5143
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200401_151459_622561_F3A25729 
X-CRM114-Status: GOOD (  11.88  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 04/01/2020 02:55 PM, Tony Asleson wrote:
> ...
>
>
>> >On the other note logging for these testcases could be much better.
>> >(totally unrelated to this)
> Or we could break the unit tests into much smaller units so that when
> you run with '-v' you could identify which specific part of the existing
> unit test is causing crash instead of just knowing 'test_referral'?
>
> Regardless, I added some debug.  We are hitting the issue on line 353.
>
> -Tony
>
>

I don't have your tree, this patch is based on the nvme-5.7 branch.
I'm suspecting cleanup issue with some configuration which needs to be 
sorted out. Can you port this patch on your tree so we will at least
know parent pointers and port are valid ? then we can backtrace into
testcase.

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 7aa10788b7c8..1f1c7d8c017b 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1100,9 +1100,27 @@ static struct configfs_attribute 
*nvmet_referral_attrs[] = {

  static void nvmet_referral_release(struct config_item *item)
  {
-       struct nvmet_port *parent = 
to_nvmet_port(item->ci_parent->ci_parent);
+       struct nvmet_port *parent;
         struct nvmet_port *port = to_nvmet_port(item);

+       if (port == NULL) {
+               pr_info("%s %d port = NULL\n", __func__, __LINE__);
+               return;
+       }
+
+       if (item->ci_parent == NULL) {
+               pr_info("%s %d ci_parent = NULL \n", __func__, __LINE__);
+               return;
+       }
+
+       if (item->ci_parent->ci_parent == NULL) {
+               pr_info("%s %d ci_parent->ci_parent = NULL \n",
+                               __func__, __LINE__);
+               return;
+       }
+
+       parent = to_nvmet_port(item->ci_parent->ci_parent);
+
         nvmet_referral_disable(parent, port);
         kfree(port);
  }


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
