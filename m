Return-Path: <SRS0=UA0h=2G=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04644C43603
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Dec 2019 20:40:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B618F2166E
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Dec 2019 20:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="F6HFXXTZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WbqA40rR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="iMulqHAT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B618F2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=e3OUfJTZ5dsVu/BpUwgwBtsnk92f1lfnGSjn4zNPeuk=; b=F6HFXXTZJJxYBx
	iF0hTVPz+fmIG+Xk01Rz7NVHGzkS2DRISQ9xaE1O8jn4sO93Jondfsgvi1ET74M+Rrs5KF97+rmya
	kqj6U1DX6w6ZOKiMB7+512W8vs4QCl0qbm3Nnhkbbpe9D5HHeN5oxA2Veh4mYAzX8L6olSgu1OdwV
	nhEKV5frJbr853byi6cGcRWfYPDXW80l4hfiay7jOOkeT5/WuhrZFn95+6z3rA5C8O9ERb4Zb0IyS
	Mv3vE7uRhheKykRokO39IeKZGTgHYrduCAwwoayRhu93D67cIfHo/pft6VO2QYbvKsJ5iO5yB/vYm
	1JlWLyYSlhb1JCOAxA5w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1igxA4-0001uN-4m; Mon, 16 Dec 2019 20:40:12 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1igxA1-0001oi-VE
 for linux-nvme@lists.infradead.org; Mon, 16 Dec 2019 20:40:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1576528810; x=1608064810;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=Bu61obhfNbfGCppTisvYlLRf4Vc70m/2aqpTvIZJQ+8=;
 b=WbqA40rR1JnmKVyTGflH+R7KJgNRaYwMusQYjiybGUmc4FQt3v4fupil
 oMP9fPyfmwHyOpnJ5HXFR5zUyfPVrQKkG6J3K8EBMviIhUFAA8joXOjSf
 tDiAFrqqvvz9B37ESPS/Tx13Yg3VOzmeIUObQHQ7ui3DgkpMcbIE3oeiM
 Wb3I/N7eFnuFPMXoqSollf8q1oEfZrzyZ723bE9p4G87Q//VuBp+c+4qm
 JovJ3AhFGR7ocV3zgHgGzjKaplb5BW/1XXPHulw4TQ5sRpCi7upRUpiPd
 7Wb20fgNXOcuhMsBs1QlkT7XBTJwtiFlH0+4MkcVj4wqOFfF3qW3RBNJ2 A==;
IronPort-SDR: HocIVReFcAzYr2gujBvkQ1QV3fLkipemEGNnNT+BFX/TS6a5xUU2Q+Hd7F+ows6CV4k/YbIu5x
 SFqTeiWe9X5Qxm5lUbzqnP1NNsVaPXKA6Hw0AzyKf0VWgo+wq0Ih6xJfF0POF73wYqBIRcKQAY
 SMzTycqqEdi5Wpi3DnRZ85DY5L+tB5E/lPkTR/vCf/+k+RqpLU4ckQwK964Xb0XeMsNS3aAikW
 hVc7zSTBt8b+ExOsxesC+1cp0sJOH5Cx4B14nSn1Sr4A951rR7C7jyXkUNJSdJD7wyxq0BwU4k
 Teo=
X-IronPort-AV: E=Sophos;i="5.69,322,1571673600"; d="scan'208";a="129915828"
Received: from mail-dm6nam10lp2104.outbound.protection.outlook.com (HELO
 NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.104])
 by ob1.hgst.iphmx.com with ESMTP; 17 Dec 2019 04:40:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YYPBdSslWHdAIqhOytjmc0JPrRgD32FXyEPnsTnbDajYskd72UyNpPhiG60/7cjfSj8A9DjKFMb84TS5UBBt99BMr8T6GqWFK+ZVJr6XFoJruzBI4pUynYuIwKiwyrm7IlFtP6+o0ftp3t2Yzk8/bcV5B0efqNG8OWY3j+vzidIDaH8CrrPROp3KK2RMcVw2K6juuQwk1R7asaGGNH8YdbBKmiU25C4LodoiAJf8kdKJMGcbr5VO3cHGsDO7pu68BScedT96V9P4HXFs2ISzfon5SPyMrPErr9i9tQcFDLHEGjKzHn1GHpBEP8WR0RyXLw2gJk94+Dt39o2L6cl0kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7xVk23wQEqu/AXvixmoLD9nghCXk17OOToSdX+RxRs=;
 b=KrWTbP01XQQMay8MYv8DIE6V+yw/4CQUZPy94TX7lnVt893GVpkRcM0HVS5FetkNySDOEmYrA/Lje+/fJ0xoS3x3QqNM7K+MTC2l+OKkH4Od1bk6oSSi/lYZS0QLjzR633aItEgTrzUvZZ47G5C/5JI3zb+8H+yL1d9rgEZr1kBEKIIkPJ7vpjibNjOqlrrYxu6Nx3Vy3RP7tYRyDzlra2FWQmdMsS/ZaGuZZENgiVvRir4JBRMO8h/K4psuLVu90VP0jxCKlVQpzmqC2YuLG8r+Fw3vlByjPcQTCJZKDteBRHJK/wuLpGVwxoCzerME57ACdRDs4EFvSLUJMVJBvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7xVk23wQEqu/AXvixmoLD9nghCXk17OOToSdX+RxRs=;
 b=iMulqHATGYckh0TEZ0YrMil0iXALBdTKzlDooa7t0UUORsCcYxDk55fBurWAqlP13mZotiz7ZOd/ixZf5ouSWvV2AkhMWSWvn1YHUY1+uxAc3MxaKqGJWiIh2uoE9dKix6ICQNuUxdOi9Ay5qh45IDv4sxS/+xGh6ZKjUCTfoGc=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB4837.namprd04.prod.outlook.com (52.135.240.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Mon, 16 Dec 2019 20:40:05 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f%5]) with mapi id 15.20.2538.019; Mon, 16 Dec 2019
 20:40:05 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 1/3] nvmet: make ctrl-id configurable
Thread-Topic: [PATCH V3 1/3] nvmet: make ctrl-id configurable
Thread-Index: AQHVpQa9aux70ddZIUOSSAPxxnE44Q==
Date: Mon, 16 Dec 2019 20:40:05 +0000
Message-ID: <BYAPR04MB5749F7880EF76A42CB80501786510@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20191127094034.12334-1-chaitanya.kulkarni@wdc.com>
 <20191127094034.12334-2-chaitanya.kulkarni@wdc.com>
 <20191212092608.GH2399@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 830d01d6-39b2-48f0-e1f0-08d782682225
x-ms-traffictypediagnostic: BYAPR04MB4837:
x-microsoft-antispam-prvs: <BYAPR04MB48376D17A7EB67B5961C3D5986510@BYAPR04MB4837.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-forefront-prvs: 02530BD3AA
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(136003)(346002)(39860400002)(376002)(396003)(366004)(51914003)(199004)(189003)(8936002)(558084003)(55016002)(81166006)(81156014)(86362001)(33656002)(8676002)(66556008)(64756008)(66446008)(66476007)(66946007)(76116006)(2906002)(6506007)(186003)(53546011)(6916009)(7696005)(4326008)(71200400001)(5660300002)(26005)(9686003)(478600001)(52536014)(316002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB4837;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XCnOBCKYvdWfMaIO/7TYamgXc/t4pOMlgcAGNRQrHaf9yUjcRord/mc1tYNGTqCIQhvNX0AGXkz7a4r/puOUMvLRght/ZpuETq4lMzmGZ/ayJf/vIRg4LjbiiFWKdVPjejrGlymmmubJPuyDa+RtvpokF4nY7brcVLP5C+/ppQ6Jt67/fNjmE/gm+cIajJR3IsQHTz8Gpx+QpZV8ugD6yXKLfp8YxBCi3WOmUe1qX/+t6X+hSMTo8ni0G9oQz0KqHHPmV2POS7Zr95O5zwic3kcWcO8iybGLjZVZEYizRUZRir4Grhh3GwKhG5m0yIKeqbKoKmtl4uueIFhBR6lgq1PPg7MjYnOhy6LMHZZycLcKx/w/M2OpZHxPim7GeuGebsfkV2Q0Hbt7Ok9yOOTT7IWNEKcmMzIpEORSBEuzKu8XKL9Y2MWWSzYJfCMy6OaOxyMuJcjjDzLTVPwZxnlet8MV1xM+rhhqlVArAazCqbxreE2rShup8FgJ8xuH9DEB
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 830d01d6-39b2-48f0-e1f0-08d782682225
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2019 20:40:05.6222 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +5Cy13GRh3AEDKfVEN2jz6qlAAAcingJbJujP4oIAvVIFuSI8p9gtQc3qJmn6AvIpVDFAukfE1ZQBy0/hFQ2DlN2rxINEQEf+9kjBnTORRc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4837
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191216_124010_073352_72B05A07 
X-CRM114-Status: UNSURE (   8.13  )
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
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks for the comments, sending next version shortly.

On 12/12/2019 01:26 AM, Christoph Hellwig wrote:
> On Wed, Nov 27, 2019 at 01:40:32AM -0800, Chaitanya Kulkarni wrote:
>> >+	int ret = -EINVAL;
>> >+	u16 cntlid_min;


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
