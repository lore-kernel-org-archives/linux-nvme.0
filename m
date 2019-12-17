Return-Path: <SRS0=Ft3w=2H=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35CCC43603
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Dec 2019 08:59:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6991F2072D
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Dec 2019 08:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bRTlkl/p";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UgFrqDvE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="NKPRSJBj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6991F2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=mzlvMSDxL/Q4xuiZT9w7Tp0FBf3cQ9D1Gez+lz2CAgw=; b=bRTlkl/pdmxcnJ
	LuV4Bhpcx/Z5W1+C2Y9uiK9P+V8oknIpJ2EYGVSCmVg80N3PnRiC3qsLNxGos2wu3uHzqljvZFvo+
	3pbcjhRUvRRvvW5mFDgPm1mK/xoMYp7yeYkC0BoRTln94JDlgbU4KvhxJiVP7miglYPG5tMonjkRB
	7+09ip1X+GLGRD/M8jWGZ/RPWFK1lYCyoK7U9EECX9SlGyVtlYxjLlbozQqzWC0r6zc2tGvaHeCtf
	LoeXQbnDY6nY1/JegokiAUzgSVYwYeotP/p96ydnseGq378b39USKfJASRsgdJWZaDZa/2FMLlBr6
	bV9DAIJc00c2Ab0JfrGw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ih8hY-0007Xh-8V; Tue, 17 Dec 2019 08:59:32 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ih8hV-0007Wr-Eu
 for linux-nvme@lists.infradead.org; Tue, 17 Dec 2019 08:59:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1576573170; x=1608109170;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=h/gPUmWZk16SToQYj+rgLdrHxaT+6ReKdm6UJzUABtk=;
 b=UgFrqDvEHydie+zF8MGhQDzhLezipyma8Q7G/2Gn0MBKxiQLZ70LzWMh
 XpLsVBsk5KYFKd7KFbv22RpwoRDbFB3OmSybA2Ms7LMy5VeiUnsh0TlD5
 X0layPmZFxUjQJrCZ1Ht87+MfRgny+eucGPqtAdKs8Ow7WbTPpB6SFU4s
 JzCvG2ORzi2KitdSu91TuTxzapU20sHs+WUtJ9G2IWo/8jbgh49jcfSAl
 3lqjqKb5E5tZTegBoTiAqy/4u8KBNqU0zedB4oy78/jlIjioRwg1D6mhH
 thJBvRsAooq1e+QgaVugn0Qkrx4NSVJWtQrTI8jSCxM2MF6WLu3iZ4umD Q==;
IronPort-SDR: sI+tpR83R6vC9IhX6CZP2bZNkIZZ360nwsnDsDtaz/30zPS3HbK/xPDo/QLNnLeM0joh+Dv4qF
 O3azkllFHs8+fgbXI3rHCCEltAQ1g2/FruRgCXFv1qvrtg5db2+7AAU/1ecYWdaT+7dxHJRXLy
 uVhkzyfg5wK9xPYReTOWSyEMXTnh+PBJ2KD+2YJ0imZoLOTnnhgICRWS6NCWnCeMbMQ2WETlCo
 SKVFjEtlOO7ApFK2TX1JZCrDDGhC54N1KFXGVwB5H9jA6XyhSWMBTQ2QCTdSC6zcJlA4WuHJnR
 XyU=
X-IronPort-AV: E=Sophos;i="5.69,324,1571673600"; d="scan'208";a="129956571"
Received: from mail-bn7nam10lp2102.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.102])
 by ob1.hgst.iphmx.com with ESMTP; 17 Dec 2019 16:59:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eSXItenkCwSY8x0CGjv45knHVj/YbhPI7CDZLrHSF+Durz718t+RTN1+S7KDXZLUCnA5CfSDXgq/yaPq1Dswdn+BbmQE5DR9ZKed+RczNzzMSGwx0WT0F7rArxBgqhfuTF2Gx5e+a3nBmiJDF5IOP8/8b32QvBygq8HzPkPQeJn319knTZcISH5dnwTTXOEhBaZ7c8goFQZglP4yAV0kxabCj0Vfx5UZOmY+hcl8tA4vRbJXaSRImn49YYROwn8g3EybZ5SkqSZeOKVqErGzrwqUE5A8eW0W/5n/FY4hmcpTF6GPeVylpHthytap52K2JReAfguHPPJ0tJPg/FySOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/gPUmWZk16SToQYj+rgLdrHxaT+6ReKdm6UJzUABtk=;
 b=YZnU+mJ/mB/FHAJ8q6PBQ2dJ8VJJ5tqCSLN1//PUDYOeONlW+6OYdcB0SXYwtLdsBpJSVmrepcVil/SG3ZYQos8IAhKVxrRXo5Pn5W+5kzFPzmztT4ixpqiY8L4GHnZJC6rH1bhJWejeHqSkknrXGsQWD+KGBW8vNIhb2f1gGmdXe4i/2yMzKxlYwn+jvmb49KoQpe8djZpep2VbE3XtXqW2jjEMYoyvnJn4ycV6qeqHXI/7/RQZtwOjdNHQXKVX3mtNbjteP4hxTbXxlZnbmKcvRDOgL/qHvHAaYxefeH3nsHVUXcbjUtMO38+coyBfRWhIKr3F+CKNSbOM8PsC6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/gPUmWZk16SToQYj+rgLdrHxaT+6ReKdm6UJzUABtk=;
 b=NKPRSJBjjnJmdaK1Kn9iQ6J36oF/waHvPrtu3n6ZIjZ/zXgO+nLTUmqefJ8xVcj83l0I6bJE/WxIN7SUNiRz9T/tDJew0RrcB3dV75+yhGEtVVVoGCZABGkychODnz6JI4opIyvKSJiRXbPpl/w8TEMgQT9vkomaGrO5YqvtsvQ=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB6134.namprd04.prod.outlook.com (20.178.235.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Tue, 17 Dec 2019 08:59:26 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f%5]) with mapi id 15.20.2538.019; Tue, 17 Dec 2019
 08:59:26 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvmet: access nr_namespaces under subsys lock
Thread-Topic: [PATCH] nvmet: access nr_namespaces under subsys lock
Thread-Index: AQHVtLgieJjak14GU0K4ZRm6/M/CLg==
Date: Tue, 17 Dec 2019 08:59:25 +0000
Message-ID: <BYAPR04MB57497947016A89B95094178986500@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20191217085811.29684-1-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d44db4f4-3a0a-4340-9fd7-08d782cf6b06
x-ms-traffictypediagnostic: BYAPR04MB6134:
x-microsoft-antispam-prvs: <BYAPR04MB6134D5377F5B228AA798187486500@BYAPR04MB6134.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 02543CD7CD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(199004)(189003)(71200400001)(86362001)(9686003)(4744005)(6916009)(5660300002)(4326008)(76116006)(2906002)(7696005)(478600001)(26005)(8676002)(81156014)(55016002)(81166006)(8936002)(53546011)(66476007)(186003)(316002)(66946007)(66446008)(6506007)(33656002)(52536014)(66556008)(64756008)(54906003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB6134;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WLB/Xy5iib3ReBfbAMgiNIWJRaRM32bDNsj7WabHypB3OP1w/GkPIS1xqsRE6cOjSSHNH4msT+4QPs7pVrEHzoZDOIBqiwMoT6UYuaElx7kgUZfcUxYVcl1RIBwZiN5SIR9CK9d5Z3GSRfrd0Zma/bCjvFY9rUzwrOSM0L38m22dAKhlyoTeO97BSbUMU4EjOP8k4HW+SEwtZCVgVbC7pnAGDgDqQ7HpwF2CSZu7fYlRuHzDR5fKy6qPWb9hXIp3s3wWdiJyG0FjBQ4e237qGQRR8Qzc5DS4SfqGaFkaF+vp57p5QyBhkML9qfWOMvhqrSA87M5VHh45veXGi//TdBdGBnxE3Wr+cZUUzyQvJTyjPTLbd2lGM5g/Ehg/sr/IKzPW7AxE9ZDRrfNkH0vDvXDNVtYm6ak1GIDikX6/OtS+Q4udS7EvKoQFYiz0S+F+
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d44db4f4-3a0a-4340-9fd7-08d782cf6b06
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2019 08:59:25.8253 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4HgYOJzGOQhqegtx+Gbc69upClAXcpJd88RrkTRet6cp3FQtaKFDnrGPtzxbny3ForO4o3CvFsEaYer4IlJ8s5I45AZbhqA4OWrSorhIIe4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6134
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191217_005929_561471_83DDDE38 
X-CRM114-Status: UNSURE (   8.20  )
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
Cc: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Please ignore this patch I've messed up my git repo.

Sorry for the noise.

On 12/17/2019 12:58 AM, Chaitanya Kulkarni wrote:
> The subsystem increments the number of namespaces which is protected by
> the subsys->lock under nvmet_ns_enable(). Use a similar lock when
> decrementing the same variable in nvmet_ns_disable().
>


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
