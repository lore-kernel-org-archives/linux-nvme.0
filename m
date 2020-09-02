Return-Path: <SRS0=9ikG=CL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A25C43461
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2020 07:24:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07D572072A
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2020 07:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="H/sUJXHg";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="d8bc5Kw9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="iyPaOVGQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07D572072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=gQ/O5nEsM943n6GGPmAwMQcmYXtt6bGIHMQuu9Uk9Xc=; b=H/sUJXHgPPzZmhQbzs0rMIvvP
	uJi6v+OwQ4whI0QHPmeg7Fc1qtZ7y1TDv7yO75x1DUrSnWq9J6Lk/fzOKqYOGYX9MW0JbjrCb7Iry
	SHOXykG7G+RsYataUnNl5QMP4dR0etb2l8hr/BiahmFEa2QTWD1Xy4AjNXIIfNGR3STlPISN8xu3p
	nSAtnOA6aMy+duYntA7WuoWDp6TfEhhBGaOd0Kltob6ehuLM6DPDmDZ+v0duOIoPwwUz/KjCHNMat
	xqRcEebFNUsha4cJ92s9NKDINkShyVXGYEBlMFUIDOefrZ9fbxhRxMwqNYJcOAUxjlYaxEx0RmJkf
	WWoBjb8Tw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kDN8I-000291-Q1; Wed, 02 Sep 2020 07:24:38 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kDN8F-00027J-NC
 for linux-nvme@lists.infradead.org; Wed, 02 Sep 2020 07:24:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1599031476; x=1630567476;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=d8bc5Kw9cKLKaywtOptzzP8S6T+upvgPaOdETLVuyg8NPxOmOY7xIqPm
 3Eu0UK+BAEyvmBc/Fr5MsWcAgV7ir49gXQYF8qGv4lcs3F4wsChSo21lv
 TTbE5fH4nvzBew2dgTpXdE3KIPIwMlptSu4KwLOfMtsIGMSEgbanKHPtu
 MUrqTqptVcpXIdpY29OgpkeSQHWmE6ZDsnmgjHJKZnzV8oIfMc+Rg8BKV
 jjDEHk5r5bIt9DOsdj36pxQh7XcAXTUhStVFzaDj22Mxgx8jzpQR9CPXE
 JTbghQjQQmabN6gKFEWZ+1Nq0204LnBEoZaEtbo/eJj8VwB4GrIEXZD9V Q==;
IronPort-SDR: e+2NK0Rm0H8+t7/xXqCbp5NIzKL7O1JPSAZ+enQuzI638BywQZI80hoAZ37K8Jgai+smuvel3+
 YC6Y10oS3T8y4O5HylgnrSXPHMpL5+k4hZrWa7NBgW99lMBZJW3gkIbB0zDZMVY3/sN0+0fLYF
 mSMT0CX5c2gc45MtBkOaFzt2B89kdet5mrVSr8/oV47Or52EAu1q30qEDHam0adgIPFGvxwzyY
 314f2pKMiljuQdiComLJqG7D8THr+VbWjHfDR1hLn4LjwLNK9kXY6heVb+TF263V/Y9iCN4IHH
 qpo=
X-IronPort-AV: E=Sophos;i="5.76,381,1592841600"; d="scan'208";a="150728245"
Received: from mail-mw2nam10lp2103.outbound.protection.outlook.com (HELO
 NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.103])
 by ob1.hgst.iphmx.com with ESMTP; 02 Sep 2020 15:24:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HqPhMKNs3dQTZin6FULjMOXpyYQyT1wYJbdIb0qekPcD42I5nNM6N45/COA2nJHqjpE2laANdEIykB+zMqGmcNntjsdkFNpDaUBa98xsEDq0p4SEj9mmwFZFSIl9jmea5K4+wVj7NUFmj03r7yKcW1DQY24RnK2pQl0E6gapXeFuO6FjpSva5bGXn+zOvTLIDFAq0Nrfe6QUhH3B/vo9ztu/YvgYDEtmqIvBEzkHQqRyW36d3SFKIVBJ2cV9rAPLfcsoMBLPe5vpPqeij5RhyFY0nhS9tSGBKdmwjkpoucx/Bq93iCgvFt8wpHFNSrIvBchRjA3fTeYYYh+ImqU7Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=XSWcGXdxawjgKRiW0S0B+3gfWZgqrtiCw8SQGmNA1o8e8ZS7rjpAb0Y916lYbdLyrASgoGtG8wWFOKbQR0C7JbRK4oZcMF4n9Tj1V1NOT2kJs9zJpQDB0UwTaFCSOLMNR+M3EFRDjcmylHWjNAu6RJG4CGpjDs8n4LMnYXK6dpiIxk1aWqO1iKFJhufPvcDdIeZd32GPBOTbclXntkt9eBIffEPJ3g8GEftWegP2qhk99l1OxBxuv/1vtjWG51ggwtDAFq6JIo3yN9qiuAvcVmg5rkMwrvN/0cARHOoWbKwjBETj4xHmbHEYou30OTCqPs7tSBzCBX7TKZEc1My0gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=iyPaOVGQQEHDkSC5loJyypyAazcLmXECdlt11aPNkgkt0Be7vJOcibCTSEx5iXJ0CFQJYnX6lJuahvLGNt+uKTf7oJTVvafLiwwLSMDWBdTvWmn2fUP/5Ssd6iyYuKQuKAyPI206OrZ7dTcMNdqngvFcsMhpEC+SMqCCfcrl/8Y=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4238.namprd04.prod.outlook.com
 (2603:10b6:805:2c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Wed, 2 Sep
 2020 07:24:30 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3326.023; Wed, 2 Sep 2020
 07:24:30 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 7/9] sd: open code revalidate_disk
Thread-Topic: [PATCH 7/9] sd: open code revalidate_disk
Thread-Index: AQHWgHi9+D0vRxf7MUaqbL81EAOZ+A==
Date: Wed, 2 Sep 2020 07:24:30 +0000
Message-ID: <SN4PR0401MB3598270C537F0E7A3ED538049B2F0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200901155748.2884-1-hch@lst.de>
 <20200901155748.2884-8-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1590:f101:bd07:d1f9:7e6b:2014]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f12e4383-fcd1-41a8-ec18-08d84f113b95
x-ms-traffictypediagnostic: SN6PR04MB4238:
x-microsoft-antispam-prvs: <SN6PR04MB4238C6E35A3E8051FB5A3C5A9B2F0@SN6PR04MB4238.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bMjGwrvH49VG+SFumlAzF3c4O31aq6r0kIkCIOkw6SFfhFSnzrDt01M2WOR+Ek/f1JURBf5dlcJBqUxLuovzqS3Uc+BonFqSC094i2UpFonDCFaWi+TvgIqvc8VpM5wrtra5xWM1vzdGMkFLcPpzHCfkKK0BlyWblj4peSxPyVMc7gZtv3r+jum4RM5z4pIr95h1zNGlACxlZ5AG67OyGNbd4ADWi+vefuqz0qnVCKGk/grP4GvcdJ5fHVoRjDo3EIlOEBIIJG1JJinxgalfMzHs55RsYenkduPUoAVhBps5YE456bMOzcoH2uyLYnv8WkZJoo8p15iFkLWBufd0lQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN4PR0401MB3598.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(396003)(136003)(366004)(346002)(7416002)(2906002)(19618925003)(76116006)(8936002)(5660300002)(558084003)(66946007)(33656002)(91956017)(86362001)(66556008)(7696005)(64756008)(66446008)(66476007)(316002)(52536014)(8676002)(9686003)(71200400001)(186003)(6506007)(54906003)(478600001)(4270600006)(4326008)(55016002)(110136005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: ngkVHmW3/Bt+G5u+vylrG+VmQWBrwJdyMKVQ6lc7NsWLaz34Wky7qCz4D+3YBInqlWVwEtDiPb3fLXIwkFzvrPAa9j+N5y1BrwHvK5XeCSzCi0KeaaIOcIu5fbWTvPLfN/eHsaw7soQCL2pxUA/+YmuKFgbiT671ff+2SlQptf7Sa2/PschaqWGElfPuCYYz9iucV1V6ZiM6IEYAUU4fdjQnldVWApVOyoSQORvnAXdXS7mm48wFeBSR+w2qPZAnZ2OtZVBtFCGP82AySy06LCtAXSrdP18fiTq7UKG5ZWfj7tA5snniLmp/GKlvkn7GJGgSp6gFmna5clwcbRXAvO2RQdFHZhAdhkU3KseXOW6PKXl4zCMpO3QGTb64BD6kidLAWkWdX5VRAJYidQGqI1btlc8aiR6aeKh+DLHlEjPd8ekISZe1FySLjN025nhVn+v+NkR61SyDx4k7utXDrMlugXPpGPNavOomIX+noV8/mJw0f1DhkW2jpnd2fCBflToEO6PrRWTEstzYoqrGOxPOo109IeSopbemWPZ0AhuDrNLzzUzFRcoAy4cInX8JDP8VolFu1gHdRu78grWtjqoqDGMP42F7aSvE+8f6HRyoJw/cWSTBckfWokesve6Jshvi3Lt52g4KCAwwI8p3AoO58aHzH7Xo/rjjwAGGfIx21owcdNyx2LW94gEZCbPz97U5gbswioOcZ7G4BhrtlQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f12e4383-fcd1-41a8-ec18-08d84f113b95
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2020 07:24:30.4715 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hod2R3pvj6h3UjZbl9iEN/uDfqHDePJ6WU4fywwecOvUVJ9vFBEPV7QuGvYcjiZFqcxIf3o1RrzCzjPbkOVIU+3/vIZ9wRscUvOVOwlMoRg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4238
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200902_032435_914098_0B59A5BD 
X-CRM114-Status: GOOD (  10.41  )
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
Cc: "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Josef Bacik <josef@toxicpanda.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Dan Williams <dan.j.williams@intel.com>,
 "nbd@other.debian.org" <nbd@other.debian.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Looks good,
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
