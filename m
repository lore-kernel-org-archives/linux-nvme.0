Return-Path: <SRS0=aggL=35=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75AC2C2BA83
	for <linux-nvme@archiver.kernel.org>; Sun,  9 Feb 2020 23:57:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A5C52084D
	for <linux-nvme@archiver.kernel.org>; Sun,  9 Feb 2020 23:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Vq/nidzw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="G9hpowu8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Cm1i5Vzr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A5C52084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=OwlmkLTsgiY/GOpR25TZbAJN7k3AqEF2Ig10Bz0yaTc=; b=Vq/nidzwY9hcxi
	fGrsCf8V1DgwdM9oPxV50j0PaWP32Xz/MYbcGgr6Lo8NPEZew3Gm9UghxWKsUk9kI9S2ySLeDaZcm
	6oBzdYgOXIVjmwguQD7duqsuH1uTGnHjcPxnu0/VyqMxiApR1AqQ1cc/w5wTQq2TFpUKo58BhgtV2
	mEVXlyLO+e4M/O7i4T7zOPa//YRTWgW1Wb1iXZZ5SlPcbKMlETI2SgtWA/TaAH5mKAd5XUtJTFGrT
	QNii9m5WLz7C1tQ7ZElzEs/m6LBNAsrDQM7EjW5rC+6JcARKTxLS7dHntUX4VARuig9MiJP6XYZ8O
	O6LVK2jMORdmTHtkaSRQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j0wRf-0003TF-2U; Sun, 09 Feb 2020 23:56:59 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j0wRc-0003Sx-Ec
 for linux-nvme@lists.infradead.org; Sun, 09 Feb 2020 23:56:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1581292616; x=1612828616;
 h=from:to:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=W5l0gG/dDfVVrt+6qr/IC9zhP9TovKoc0ZLNb4sWbQU=;
 b=G9hpowu8UjZ2beFvT3xMt9Cno8XfKymLb8FdNVWLPErY2D0MCkxu/mV1
 Ry8tz30+vATkQPnOEEOlXCON1mQEU7MvU7xkb3qeQr6bEz2apT4f5KpOj
 hYc+G17sRbeXnXtHecF5TA6Zk0oUIcn0/iDqUhfJUR3BlBL3thXktmovL
 EIupXf4kfXJx5iyiCY/eqz1/82O+MqXszOGUninZYkwl5Qoki1xQPHd2s
 3V9jMcXJWB6ChthTSFJUH7Dhplev844todcg5YShHAb5S+suEO5gzFxhx
 qpO5iORSfA2Nbm/mMDeWGk0tJN7NcLbbYYTjG5INm/gslfIFnpvl1wRYe A==;
IronPort-SDR: jbgnYCzgnZNpTt56GzjY+v4R1SWEybgyCamdZKB1oWXfn6TJH9IWIWsoLZT15pFYZznCbRK0Di
 W502DxYTm4O4srFegNYNu4SZaZbExzny7slqM115e29l7Qjh12Kuqi/wr60t+xSIoJn/GWVzcG
 YOc6CeOXNbT/3y6+9BZYulBfmIJMC+lvEbebPit+oRKTxeoWgvmkAG4h0t+RYs71bAhjmtlWer
 S9wp6d7z1kh4Jn15Qawb6qmb/TV7WAjIFaYZ2MKCGwxio2vVMa75RaxRuIQ6icCdg/ZoaIjL+A
 ODg=
X-IronPort-AV: E=Sophos;i="5.70,423,1574092800"; d="scan'208";a="130008870"
Received: from mail-bn8nam12lp2173.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.173])
 by ob1.hgst.iphmx.com with ESMTP; 10 Feb 2020 07:56:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oLMQChIfqEm0sMW9sSmsAjxW5Htrk5lWnH3R42ElkYvtthdypMrjFsAiLQ75XaBRuFUBu0TdmeTeiTsrSdLVNUIw3eBxVv837mecHDC065EthKXdjby+5yXbweMq00wR3pMNzLqBkHt3hhWpOlO15wiA/v2acWWXEPP6LedzrY53UCBFyqlhbUf2cjsuQFaURB1THXvp5GJR+euDsBHOaH8P1JJhEEBO+zi5xQfWlW087dKxkikKwaLvMa/niEi6Agnp3Zt/vnHLvyjaxlMyuRwgBBqpDNZJ1ZCEHxipthbjk67wXr9KShfFc52dGhKTs15DxpxZeW8LFyp7aKEWSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5l0gG/dDfVVrt+6qr/IC9zhP9TovKoc0ZLNb4sWbQU=;
 b=A256bnepkCPtne32F4ufW7fGvy/Ga9gRfNOqQKSq+N8CDvJbVuLJlih+TMBE31xR1YAqpxXCDa/thGJAd+gqDVWqA7Xz8GBnHvFy6DBEFvGZGKnPuqImy0eise4yckiTYIptKOpPx142pa8h2f5U72NJJ+PvDTr75+El/P4v1GzlPFoy719Zme8aBHKMk5zIkS1nAYryloJ6GQOGFTy4z48dDn93hwnWSSGeaHDrQrDotgbTkvFTDosEMrWcMTTQnP9xyoJ+KmOkjlcK6TEHkG6TrQGgGouDrrVD0JiQag3aN41vphpVO1q4sqohV1HRjjQsR/dIUugZmw5bRr/LJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5l0gG/dDfVVrt+6qr/IC9zhP9TovKoc0ZLNb4sWbQU=;
 b=Cm1i5VzrG5iQSWuKfQXSVKUJHBF2X0lSw3LORse7ijOpWIJ4yANdgzaOQNpWsJyQWuOOTaX8Iu1dqA3ayq1RzPci3qrR32lGVL6tNwsYpyfWB22KDGM9kiGGWp1PONku87Yj7aQAqa5WU5eI4IMXcgBXmkvZHWYwgf4Kk3kkaiI=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB5669.namprd04.prod.outlook.com (20.179.58.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Sun, 9 Feb 2020 23:56:54 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f%5]) with mapi id 15.20.2707.028; Sun, 9 Feb 2020
 23:56:54 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, Keith Busch <kbusch@kernel.org>, Christoph
 Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 2/2] nvme: expose hostid via sysfs for fabrics
 controllers
Thread-Topic: [PATCH v2 2/2] nvme: expose hostid via sysfs for fabrics
 controllers
Thread-Index: AQHV3h0SzwW++1cyRUKiOE4hnmaorg==
Date: Sun, 9 Feb 2020 23:56:54 +0000
Message-ID: <BYAPR04MB574914CE8400D73F80913BC9861E0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20200208011354.20889-1-sagi@grimberg.me>
 <20200208011354.20889-2-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 411e9e0f-847b-4376-3194-08d7adbbbd81
x-ms-traffictypediagnostic: BYAPR04MB5669:
x-microsoft-antispam-prvs: <BYAPR04MB5669B265C597A362FB75D1F7861E0@BYAPR04MB5669.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0308EE423E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(376002)(136003)(346002)(396003)(39850400004)(199004)(189003)(86362001)(110136005)(52536014)(81156014)(186003)(7696005)(9686003)(26005)(53546011)(6506007)(55016002)(33656002)(316002)(8676002)(81166006)(8936002)(2906002)(71200400001)(478600001)(4744005)(66946007)(76116006)(5660300002)(66556008)(66446008)(64756008)(66476007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB5669;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rgBAM8kiTavyISLPXvmLRHf0CoWPDzNTXLSbCgI1aSZOsVVSz5BbvS7+J+0RN7oxpei+dv/VqUCxe3f+fbnnED8F3Rjzh9ZQ3PwT4SV+ZyIQjYx/6WqkcOeoMXcRju0lKKoJ5B+thHHedjSn6i9ISXC2Jqnsv/N/RaiRD0gyXEQr4LJ1anzdfaeloxvH5iKkfVuciN1z3PDkFmr1c5W+LVbpaSa6tSRUUBZYRDEu0Mnr0eB98++GPn3muAqbyF0keQyMn3XjZjpUojl50yzmeF5CAr7lROWypx9zb9Y61QCvW36fIMUCReNx5qNvXFIhNBqlG9h7CZhLTFGoC2yqf8NoglyG3d1Sq1mmEVRpbkhqAM71V3dHgiVVVBYAhPY95aXjbiKJ9Lq5RKmRmMkmDsH5NA0PBeyzsUVHb4YODpMR5X7o2BIPoK2n8xGJd+JP
x-ms-exchange-antispam-messagedata: 3V7YPnt7RuTjsMX37ZWGepv2UUH5zzz2XPFNSOUKIhzUW79SbmSbFhIa7XfP0O5c2g63PLzJfKN3gTnZvsZODVEEIk3b8iCkooqlR3HDgJXejrs2pMjDDYYdGIendVVGAM0u94Fctu4SdILhe0+XCw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 411e9e0f-847b-4376-3194-08d7adbbbd81
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2020 23:56:54.3736 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fl9AVFbyKlTq++ZkXCgmpLk71nx0VUNVX19Esz0kWK/hVDM0tJtekkiPjzr/l+veavB/DIy2bqHQC9S6lGtHlvJ0OW34SSfKCP5u+IKivLo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5669
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200209_155656_498484_20025F9F 
X-CRM114-Status: UNSURE (   9.87  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 02/07/2020 05:14 PM, Sagi Grimberg wrote:
> We allow userspace to connect with a custom hostid which
> is useful for certain use-cases. however there is is no way
Same here :- 's/however/However'. 's/is is/is/'.
> to tell what is the hostid used to connect to a given controller.
>
> Expose this so userspace can correlate controllers based on hostid.
>
> Signed-off-by: Sagi Grimberg<sagi@grimberg.me>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
