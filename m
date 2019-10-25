Return-Path: <SRS0=pUqL=YS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815F3CA9EAF
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Oct 2019 03:29:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5301E2166E
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Oct 2019 03:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RBV/ypVk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KGyToIYM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="eQB1Tid4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5301E2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=2i2QitIpP+CbTqip/NbpRRvd1vAxfuprkPEUF4mvi/Y=; b=RBV/ypVk9dKveG
	GoNZgw1Xr0KsLj6ZiNWi8/1Ms16shoSC6WDCIgRps2T3b5xZZbyBAK4cqfqKCYLT3LGTNK1a+arpD
	fNLQXcyoY0uawAw3pXyfKNtZJCtnf1klIMoVxe1XPHCnStqD0dO8x5o3eYKsQisRGNnAbLksUzMJH
	X8250N7ocTpDs119gO1jxpTKM/C47jAYXXPBgGz/HfjF499VFMZpBDA3cBbjRClCMFCscyUgUxGn4
	VZL27c32JcWff8vzRvcal2VMuPFJaTOwXqXPK3f7urbGdpHTzfavvqhSfTTQZl08vU4Y43+VVl5hy
	e3BF3ADLuVQi04wGV3sQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iNqHp-0005y3-0b; Fri, 25 Oct 2019 03:29:13 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iNqHl-0005xf-MB
 for linux-nvme@lists.infradead.org; Fri, 25 Oct 2019 03:29:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1571974149; x=1603510149;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=pI/wlS4NpzaVL3AAUx35VAJ7qrED2PkJISllgIckFAk=;
 b=KGyToIYMjeSV+r/1ctfeAYDfdjcYVnjH36WkhNqQ5Ica1+YTx4wo5fEP
 gZMT2kDxnTYZhOGcyLk1hSrKYifTILgPVP4wmukJFPdqhhE4DOI4ZB7Jh
 0dqNcPk42ywrqDKxlQMk4cwneyX/kpas96JDXLyPb9pp7NZ4gcIOJQzlR
 4xn0Ihi+ZdBg8a9JuNOUpLi/qjkeP8v5fd5hd83ghXsuerpn9B25Ih7qU
 pakWLyCdaIcvGyE6QmijY/bFV5MWy06NdGmZVGSKlNUqh4gb5jV/1FcA5
 lrGLRtfxQU9y8MP/p5iy3dnOtm36KeWjp1cLURy0zP54CiY2x3CQInQpj Q==;
IronPort-SDR: avgexV9M+WqBxddsCmu4dQmEKO0Z9oMhChrZViPEaD6GpPMyI18Cohv4lKPJs4qWEIBPUP3pGF
 yO6rQL04G6Sbvb3jn5h+sG7n3fPsDaT9yyxnYajvcWqICDtXWiUXodcccsJxbEzj4Yg7UmRTBd
 As/Uz+jHMuyIRrOBaWyMCaLVcrIYjf1U40sy6IUVDo1fjUSKu1zZcZDFtNt41LAZiIxuhy0IKG
 2zZlbeo6Kd5cVgAblHndSABGysoeAV0GVSuj70QkaJqlVnUYR0AbUjSco2rVyReYvZ5C2EAcPM
 RTo=
X-IronPort-AV: E=Sophos;i="5.68,227,1569254400"; d="scan'208";a="228448437"
Received: from mail-sn1nam04lp2051.outbound.protection.outlook.com (HELO
 NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.51])
 by ob1.hgst.iphmx.com with ESMTP; 25 Oct 2019 11:29:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JmyMDwJXIhWoIXE2+zFRIZab5i+baDj3jiRk4pgS+UuzhYwasqEF5NXY/Sun8cNAR7JflRQsm2tklwV5IoW8hU216dxkWOeMtqahn823W+gXKjCIozYSHcgB7+VQEjdBztOpQtPlanuvTiqWbeHz+dCB9xFfNEE/x+ZhTiCTb1PDrYRIpc4hFRYAr2SOCrfl3fObEz6JVdaVUxrQOI7P756nknL1r9mphIADwrpSIs3oDSPjMaT8VZwvIxhmfUK/6nQ1iBkORILWT5xH8GNZw5e/EeVYudgY1vDgm6ezX4ybFoLrxFm4uD1F8eVZaEkDv18KbkPYFMXDxIColh9x8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qAJfxo9apGzwN0zaa36DkfgFs/F3bkrNxJs8SgkErek=;
 b=DcLVBzhXPuax8tJlzolJdi3zYW6iujx7ASdBRQQ8d8MBufRefAwaSkmEqTRNvUVlIY3bAjpojI2qlo0K0A3pqsKOJ2A22HCMbEUL3DUlfIca0R+1cJUmYeOwQ75GUkL5VWDL38huLTiqfkhtCgy5dh7WGY/yoAQKTavIwiWo9IYxFAyLloJuMzJF1RfHSjryRjJ09vfEODPtoRMA1bePOZPovyTcqVuKe/e8qV4v5VtVllTo9f+Sag+moI7GazDt+35gZ7uRTK2MJ2jeZA0EIys3Ho7Vrr5//+DDCkrAykmjTmdzkt6dW/3M4horRguwnyFznYDJ90zwLPGkLX5Wcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qAJfxo9apGzwN0zaa36DkfgFs/F3bkrNxJs8SgkErek=;
 b=eQB1Tid4MPaVeMeBI4dDw+rfPLeAi4kzAPbDhqGO20sCZTRRZ38HfezspaJZ+R9cyxxkfqYBtDb60PiH+/oPP9JY4kafeuUCAUd0IxbHq4P+6y+jny10Lp/SLfr/rTWx0SSpy2tYL407Xu3URgWO+qEmETrPbzOC8Y2v8gCpUJY=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB6183.namprd04.prod.outlook.com (20.178.235.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Fri, 25 Oct 2019 03:29:05 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::34a1:afd2:e5c1:77c7]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::34a1:afd2:e5c1:77c7%6]) with mapi id 15.20.2387.023; Fri, 25 Oct 2019
 03:29:05 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvmet: introduce use_vfs ns-attr
Thread-Topic: [PATCH] nvmet: introduce use_vfs ns-attr
Thread-Index: AQHVid7kgFRDrsrFkkeJqDNfcuN3xQ==
Date: Fri, 25 Oct 2019 03:29:05 +0000
Message-ID: <BYAPR04MB5749682207F2A9D9572B46F886650@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20191023201715.4236-1-chaitanya.kulkarni@wdc.com>
 <20191024020003.GA2148@redsun51.ssa.fujisawa.hgst.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f42922a6-596c-4214-f614-08d758fb7d36
x-ms-traffictypediagnostic: BYAPR04MB6183:
x-microsoft-antispam-prvs: <BYAPR04MB618320B327D3517153AF118A86650@BYAPR04MB6183.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 02015246A9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(189003)(199004)(446003)(476003)(74316002)(4744005)(71200400001)(54906003)(71190400001)(3846002)(102836004)(52536014)(99286004)(81156014)(8936002)(8676002)(81166006)(7736002)(305945005)(76176011)(33656002)(7696005)(5660300002)(2906002)(6116002)(86362001)(486006)(6506007)(9686003)(316002)(55016002)(66066001)(66476007)(66556008)(66946007)(229853002)(76116006)(53546011)(6436002)(66446008)(186003)(6916009)(64756008)(478600001)(14454004)(4326008)(256004)(6246003)(26005)(25786009);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB6183;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l43VoxmXZ9ZYP7rduPSfBrPHF6b/2uWsbRcph1RsE8CpvgzK3F8OLgyD1NPtNUVAL89NvMfEjtlVsK8ZLQr1CHF8YhhOO7Oyrs/5JOIMbt+UkDHK+YzNNYTydCKp7c+hVJvG0r6H1nFIl7vD1kSMvSv2YnfEfWCxYjl8z+/0oPeZlUMsrzbCV9+jhQwaPtVt5HUbrC183n7UwYiAk5PTQGgS7sG9uaiyfieeYzU7fSzTJyqGDZ5UinSyoJWbMXwvqea/zqFR6bdjQ/iHoNUSjoYX6ZkyBHA5VMmVpOCr7MQM9wwap4gaAxOBxlM92/XT2FD7tPPwJ+ajlNbtWwLRvL/EQW3E5RRFiZX88b2a1M8ICXOfyVS1heAqzOp7fDpNVVg/SDnF8qQX/SeA+VthcOUOCBlXdVZJZK/NAiv81x0ZJRr936kC2/nTH9GNeWJU
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f42922a6-596c-4214-f614-08d758fb7d36
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2019 03:29:05.5015 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yCwh3UfQreFmacHdsM3hoQz8TJnCFLy4hNB3YrvCYpagW+LvxxIIZu/rSp9kqiPBFVF1FbjkD0oTrZ3gIIZn7CrFbQifitx1X6BoYbgB5kc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6183
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191024_202909_822752_B04816D2 
X-CRM114-Status: UNSURE (   9.49  )
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
Cc: "MRuijter@onestopsystems.com" <MRuijter@onestopsystems.com>,
 "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 10/23/2019 07:00 PM, Keith Busch wrote:
> On Wed, Oct 23, 2019 at 01:17:15PM -0700, Chaitanya Kulkarni wrote:
>> >@@ -45,17 +46,27 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
>> >
>> >  	ret = vfs_getattr(&ns->file->f_path,
>> >  			&stat, STATX_SIZE, AT_STATX_FORCE_SYNC);
>> >-	if (ret)
>> >-		goto err;
>> >-
>> >-	ns->size = stat.size;
>> >-	/*
>> >-	 * i_blkbits can be greater than the universally accepted upper bound,
>> >-	 * so make sure we export a sane namespace lba_shift.
>> >-	 */
>> >-	ns->blksize_shift = min_t(u8,
>> >-			file_inode(ns->file)->i_blkbits, 12);
>> >+	if (ret) {
>> >+		pr_err("failed to stat device file %s\n",
>> >+			ns->device_path);
>
> Why remove the 'goto err' from this condition? The code that proceeds
> may be using an uninitialized 'stat' without it.
>
>
Yes, will fix it in next version. Still waiting for some comments
and see if this makes sense.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
