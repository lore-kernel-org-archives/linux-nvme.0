Return-Path: <SRS0=U9tF=ZC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DD8C43331
	for <linux-nvme@archiver.kernel.org>; Sun, 10 Nov 2019 02:25:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A36C207FA
	for <linux-nvme@archiver.kernel.org>; Sun, 10 Nov 2019 02:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="t1UmfCvt";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hvYKe8tl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="0Gix6ygE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A36C207FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=YcBFXV7rriSBcJlqc/jNlt8xS9K66+xoudiJVw1OnAI=; b=t1UmfCvtH/Hnt4
	Sg5G4MJNVsJEaEfVsd2JQwgUqKYUh4u5svzw/rr3cW2VMMyY/tbRIaepIqUhDcdlzCHJ/lYZP13UJ
	XevBIsMkk+p7vfrKDmLxhuc3Mn7YeA4gCNgduRWTzKauP/MZP4Fr9teb6bYB81G1JctotKtva5Ps6
	k2jHYvrzYtgUc1d8XI0JFl6hqASMR5Nz7PglEiYFfW0d2/iALLWIkUKaRU1M4D1Q/wFuP5BJYdHHO
	tIMhpHMMSUhnDLJDXJCDrB10x8DJppGPeOOugbz+g3QXNHog9sm04CMK/yOB7oxQGOFAyTX8UyjTL
	gPWv4ZW8A0VdRh65gdrA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iTcux-00043z-Cv; Sun, 10 Nov 2019 02:25:31 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iTcus-00043O-RE
 for linux-nvme@lists.infradead.org; Sun, 10 Nov 2019 02:25:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1573352726; x=1604888726;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=8ZAg7qrlY8AWjRMQj/3amUs3+HnV2WgX0uZCdYde/xw=;
 b=hvYKe8tlXwU5F64nnu8vHlYZLWv9hbL/Gt2VaDHzNAs/cDv0tFDnRrgl
 mngkzrFXVAhuSt5Iko3ge+i3a67/8+cDfTxFTlCcBzjxoaSzIikaVmDl3
 WK/GsmULEIGG06pzPVhjvRXkwfQgTmUX4JDYcOkoWxeT2sC9b5PCyHNHp
 sPiK7VEnSp8RUGFAeDkYy6hZwnwAVuSer1bmYDGZJ5kp5NAMtsrAl/rmT
 SukuIt2auC2XgIyvVfeTFcKi4LUeaUS17sLTLT8400vhgSjNj6yI4E1go
 XiIYMbSe8c05D2GcKe6asGb1auv55eS86mUOoxGLInYtHZl9Z3sAv0vV3 w==;
IronPort-SDR: 5mCxrvu/gZUAAMIqf0pO5YKMxc42QToBhkQAJUvNCAOlr5ReHKi6rD4rbprdiU4ZJQwx4dE0be
 Va5npFe/hxz4l8hF/so//GhGAnMjtIhBYucf7NwL8hYhJgNi9enu25WxqXliALTUYM+1ZsYZC0
 MjB4Frd2cM8Sqry16Io8f3j2fI3GhzBCsdIc0NmaK7YsEieR7qkB6+z0AspoiYlIopxlUuZ59Z
 JOMbUabp0T9RMq0LRNdWSERqOI8pGuShpTJoDYWsbak3rbK9B+mDWhAA06a0ZOLabubYctZqO/
 Phg=
X-IronPort-AV: E=Sophos;i="5.68,286,1569254400"; d="scan'208";a="229869214"
Received: from mail-co1nam05lp2058.outbound.protection.outlook.com (HELO
 NAM05-CO1-obe.outbound.protection.outlook.com) ([104.47.48.58])
 by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2019 10:25:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zf/jnzrnqWNqSjBAvZjyrj9BHEiOKZOzEjXGsSoW+amGyLlxbGa173d87qhD2J049GhKVgq5FxpCW756xx9yPLg0xr0++B5aYbCmv4VOYgdzvQVqAktlXv1/oGUsAe3qEKk2VrKOOAoyhhheGBcEcpiAX/TJM8k6DRTrZqtZFLJtSMwqTIR722hWaiovp7mGQP9of7NZwYirni5YWO5avCUt5MB95KfnSNdxaGsZpUGwOnRG514GS0SC8NiSOr1bkwVGd4vURbGMcj3fQHvwpNKF0e+SjkukUjsW0VIrH5Z+LEVG7VYAO4eWC7KZJ03O5Yn1YtxCI68t5SCt9TDZPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9aK0KC2uVHwfcST7WNRVPD6/UN++QSUG1KXhQmVr2ak=;
 b=Fz2J6tPMAYmZgydl7yQZonOkPpomHPHf+dAfNtoC4/qfBdcrDXrimnRacVB2XsDn8dbkgzMFRiKubQppluZclv9G0Xiq32bf3Kr5OfEIubWpdazqMtgmXcNDW0sjlMNLUeuytHiApN3AA8uo9mu1ZHgo7/ggHFIFZ9sP7dayL45Q6A9x1lS7RTfa6+7sS18bI9YP6uPBMN1fn4zVXromYrJyOV5XxkGMSQrFxJh8z3yIj1QzDTzWKYkJVcPRsJADToD4wTxZUkqQFw6F+yaaVtLIiySWH2kxyly+KAwLZLJC9k6PY57RYDLiPVo5BPh/02F1zDu2V4HT/3skQQccfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9aK0KC2uVHwfcST7WNRVPD6/UN++QSUG1KXhQmVr2ak=;
 b=0Gix6ygEOKoTG63emQdcDwtZmKtoaRicqie35j23JQJ0eFqsTY+NE4hYeUsLLVn5Qehu3tX3sdseR32YC+gClSpbDp8SXBeUMfxrBef+CviaTUtDqJUo/rSZcBqpA3SX78jfllQ4HpVqW/ACbp99634O52Aim/xiYKbfIZgdWxM=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB5637.namprd04.prod.outlook.com (20.179.59.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Sun, 10 Nov 2019 02:25:21 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6066:cd5d:206:5e04]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6066:cd5d:206:5e04%6]) with mapi id 15.20.2430.023; Sun, 10 Nov 2019
 02:25:21 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Daniel Wagner <dwagner@suse.de>, Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH] nvmet: Always remove processed AER elements from list
Thread-Topic: [PATCH] nvmet: Always remove processed AER elements from list
Thread-Index: AQHVkoMhq0HJ9KDTYUe4XHNQTdxotg==
Date: Sun, 10 Nov 2019 02:25:21 +0000
Message-ID: <BYAPR04MB5749B7B17F2DD6692922D41D86750@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20191103201310.24785-1-chaitanya.kulkarni@wdc.com>
 <20191104081338.gdrk2a4mlov2io6s@beryllium.lan>
 <20191104095034.GA3193@linux-lxv2>
 <20191104101935.lzdhraz5wnd56g4r@beryllium.lan>
 <20191108104207.7paup72lz2ipqynf@beryllium.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: eace84eb-068f-4538-a396-08d765853c65
x-ms-traffictypediagnostic: BYAPR04MB5637:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <BYAPR04MB5637FC3FDFD269127D7D9B3586750@BYAPR04MB5637.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 02176E2458
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(189003)(199004)(5660300002)(33656002)(4744005)(7696005)(52536014)(256004)(3846002)(76116006)(8936002)(2906002)(66446008)(8676002)(64756008)(66556008)(66476007)(66946007)(81156014)(81166006)(66066001)(71200400001)(71190400001)(6116002)(53546011)(6436002)(6246003)(6506007)(25786009)(99286004)(478600001)(102836004)(54906003)(4326008)(9686003)(186003)(86362001)(55016002)(76176011)(316002)(6306002)(110136005)(14454004)(229853002)(26005)(476003)(966005)(7736002)(446003)(305945005)(486006)(74316002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB5637;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BFfcajKUOIE50Q3wGk5ZqxTRucK2sFr3ZgBlrzko9ygtW0LmjqLvuv/E30jWYMISBgoO4J9QcxHBUsBGRYKr1maWagv/Qy1SC12+NCdKCvb/TznXBk1BSgoA5fwjiS2DDdFxThJc+MM1mulggJ0cQtiqslrD6p0tPvr+C49RE/thymLkKu02f4NI0EFvtLX01YcVHxCnLrLd11klCfJGyREmhqp+eVNP3V7K7bb9Ql6377A5XPBZGmNZArkEWOzN1CjdZ3EA0vIpPJSRNdqA2ZCOC2yx/34e8JYE9nji7VO2nzKu4HeWTLZYwcnOqos/h55FrN2YfO0eZpfFuVrQGpcqOAYbGdYZncoQvfi6LZtwbCN7cbtLVsBSSLkxi8BEMa5mxlXVIGoH0tkNajBw93FoDDmQ5Ovj/UthlHlKhWjHqW9SP4pZpPv1MdTjbmJTTNMd0C5fvgvTaXUh9YTrdrEZQVc5jS2FQtuOob6GmSw=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eace84eb-068f-4538-a396-08d765853c65
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2019 02:25:21.1955 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lJd6Yr72WQ5t0qbztI614ri5dPxnndjXfi6HMeZEs/GUtbJVfoFsF8F6//4gSC43eU9ce/njMOO1hRD4pXCt/QlfLOf51fMJ1C4p04RFECA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5637
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191109_182526_972829_7B6A7091 
X-CRM114-Status: UNSURE (   9.74  )
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
Cc: "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Daniel,

Did you see the same problem with the patch I've provided ?

On 11/08/2019 02:42 AM, Daniel Wagner wrote:
> On Mon, Nov 04, 2019 at 11:19:35AM +0100, Daniel Wagner wrote:
>>    Run perf to write data to tgt1 and tgt2 for a long time , command:
>>      sudo ./perf -q 1 -w read -o 4096 -t 600000 -r 'trtype:RDMA adrfam:IPv4 traddr:192.168.219.4 trsvcid:4420'
>>      sudo ./perf -q 1 -w read -o 4096 -t 600000 -r 'trtype:RDMA adrfam:IPv4 traddr:192.168.219.4 trsvcid:4421'
>
> This tool is from the SPDK project:
>
> https://github.com/spdk/spdk/tree/master/examples/nvme/perf
>
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
