Return-Path: <SRS0=Ubpo=JH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4801FC433B4
	for <linux-nvme@archiver.kernel.org>; Sat, 10 Apr 2021 20:16:39 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C30A8610E5
	for <linux-nvme@archiver.kernel.org>; Sat, 10 Apr 2021 20:16:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C30A8610E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=nNAfzm1194e7Xhga9ZTM5KGEPTLgXA/6QQuOt7lEyfE=; b=Xh7wJg2Ll2JmNZZy6vNtZwa5P
	G4nHF7aiFxBfisGemv09zN8vNnqVd2iD/iNXsuDXUeiC5oQbAafHg/srKXWKBmeGc4knF4BqhK3/Q
	AHglAw8G8qjqC1KHc4yGe2bqrt53/0/ZPhgHD26VizVd3wxzTB2ck0ioeoySKDDAjmeU7bECbQ18p
	eCGyyOHrs5GdQ4PNhydEmwp03d8KfhdseyMWNGzsWbjI1zHE8Obg/5bcr7tPTIToRqPJ1c35mzPFb
	NZwEupC/85OdIpYMzdaQaVJ4U2HZZpkvMnNPHdBkoVtDdVGH0TFdbjMwWFAzrNNrDDTV+IDcy8T1D
	Hv6XkgmAg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lVK1m-003NzK-15; Sat, 10 Apr 2021 20:16:22 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lVK1H-003Nv2-O3
 for linux-nvme@desiato.infradead.org; Sat, 10 Apr 2021 20:15:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
 :Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description;
 bh=gr3ja1jjuTxWoMbpuEESLxCsHsXusjcgl0rJ8+7BxUo=; b=IrM6oVaX9HurXmN0ZkD668zmfW
 geli8h0SGO5EriG3TGYRQg1rurPWqnOsZYg/nHkLE4fqE7d9OpmqFBaP/97lpeyvoeWE3e6u99SHp
 WzuUHPJsJGVZV2xhitGtm4AOTefkz68znNqNhGZQ+BLtuD6UEyY8QG2JApO+NKLv5jzmbYpTQT1pF
 p9T7u2SrxE9KYXs2lW+Y1J6nmAYMMPjP5ZxW0VCFgyNTahtMEoJRGRvPLppS5KQUTCwn1dm1Ja7BF
 WRxNvKZTYPgrGk7sUPpr+v0XRuEA8ZVBN5hMErwSMWV5N1VChoUrfipumHziT26ggn/1Bz/SerloA
 wFWdq91A==;
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lVK1F-005FMx-Bz
 for linux-nvme@lists.infradead.org; Sat, 10 Apr 2021 20:15:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1618085749; x=1649621749;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=YkXuOqiSXuL9rEdKnfOIJz9d/qzgm4EzADN0wtuA0S0=;
 b=JommwoJ4VDcA0MWHyjMo6yhYksX/Q9DOvEozMF9gMoIdZtvmVjbPNGWM
 JAdrlpg+p3FS+DVytoEtfOL5nF90+U/no+N8k0VCjQrKnnA442Tril/ZA
 tCPO2UEGJgCi39N8pgia+2cl8tALRyVIYWQScIDLrENoJMdP1elrxmbu/
 QhChDENsIgLgfMortt2AYYdIWfdhDthXp8d1KlvJe/YBbD3fpYhxfda+a
 SZhS74wz0cY2s9oNOZjmGArd/te58JZvGRKuCvoGGR0C+R1LXRBiOZ9fj
 aZPtYndu3fnDbz6crppyO3dZomBtEtt/xWg5VwDCRGvK1k2U+zZo0OEKd A==;
IronPort-SDR: ELx+qcBD5y5Rhvc3DptPkBtOR2hk7ht4obKIGktjuGVJRzDqCF5+JDGXLplFWs3CiiLuXM78Jw
 QPouuLGD+Qysl1PxHuMrT3XfVc26/zWhGJQKggpnKYCaGyLKgj+ibmDakif3haEAfwu4xGPywA
 QCNX49JgsWuWjGbxk0LSXsIfHtdH2PrwNsIsrssBTj1mu7V7fLLDRZButp4DpE0lIFubwZbLUK
 V73+YbDJeQhoA3O6DZKqK7jbXkLM5vZq/orzPAGCuemboqPoufh3RsWi64vh8jLFMGnuaILiqg
 EQo=
X-IronPort-AV: E=Sophos;i="5.82,212,1613404800"; d="scan'208";a="164388715"
Received: from mail-bn8nam12lp2175.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.175])
 by ob1.hgst.iphmx.com with ESMTP; 11 Apr 2021 04:15:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KGj42oIl90Zi+qYNlx8PdIwrlY6PfGqc6xVXw11gk6h5sWhqfTzferSXVc+he0LA3tQWlTdz5JsmqVyt17r+EBaokPdIArKHntcp63XnksW6Dn0l2HaefQrTfx3PxUkbKCVEh0U/IGQdi7mMNayHzwkN9n8btUKEpzYmTV4BvC79loTe+6Ub4XCYhBOpRuINUfn+CVFNarRvDo8sgtgAabxEw3JylKiDynUOye8QNpscyhcUniz680zRV+PsraRpNRHIQgOTGHy37I+A0HEueH95XhbDmd9MoEXG3/hP3Wj8fXTXsURgyy4C9eNChPa5L6D4eDYyPcliPrBjfAGIJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gr3ja1jjuTxWoMbpuEESLxCsHsXusjcgl0rJ8+7BxUo=;
 b=U1oKNo5TVvMPu62H/GcajgJTMoBuKJKXYZsR6zLwzqoMafnFrUmBVdihPlVJXibBmm4r62JNWpqgerz4km4UUewt2hjy50/dCtvinGIVGLFQUeF3ooxbRyFWX8Oanjqe7Vbq7ubij7dxAoCzXXTFQdsTCSc+2OrsFBwYuq1dxK1cq2T2KBbQ/xatgZp+sNMb732TNA6+hTOcPXS2f65bdHVdwVnn8uBveYMNkY3OU1OB7eAhzioC3ZlyxJJv1nJzm+j/mI76+qMPeLLRVX7bywW0pINJiGkJ9fz14TZTQ3wCvVnnHD9ixP+Fixj9jm9Oz/N3ZS8CpOTkbsQ9AsG7Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gr3ja1jjuTxWoMbpuEESLxCsHsXusjcgl0rJ8+7BxUo=;
 b=m3oRABzNxe80GdorcYB4/l8PRFdQEPHF+nvQ/QVED3XCPXl8A+TzLWxvS2flbLp4pt5gbs+U04ju7qeebKpU3N3KeQ52NzPuwS8eSCPwb2wn1KHFK9U1ttGe+vEspeIG8eF5IvErNN/IFMfVzAV+/kdMjtsP79Qfa69MUcKQZ30=
Received: from DM5PR04MB0684.namprd04.prod.outlook.com (2603:10b6:3:f3::20) by
 DM6PR04MB6379.namprd04.prod.outlook.com (2603:10b6:5:1ea::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.16; Sat, 10 Apr 2021 20:15:45 +0000
Received: from DM5PR04MB0684.namprd04.prod.outlook.com
 ([fe80::9842:455e:f0d:a1bf]) by DM5PR04MB0684.namprd04.prod.outlook.com
 ([fe80::9842:455e:f0d:a1bf%11]) with mapi id 15.20.4020.021; Sat, 10 Apr 2021
 20:15:45 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
CC: Niklas Cassel <Niklas.Cassel@wdc.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] nvme-multipath: remove single trailing whitespace
Thread-Topic: [PATCH 2/3] nvme-multipath: remove single trailing whitespace
Thread-Index: AQHXLkZJhATFysmlZkOhEbKmIjZzAw==
Date: Sat, 10 Apr 2021 20:15:45 +0000
Message-ID: <20210410201445.53061-3-niklas.cassel@wdc.com>
References: <20210410201445.53061-1-niklas.cassel@wdc.com>
In-Reply-To: <20210410201445.53061-1-niklas.cassel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.226.244.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1ee46f60-ce61-4e93-d214-08d8fc5d6c56
x-ms-traffictypediagnostic: DM6PR04MB6379:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB63790244D86C2455E5376E82F2729@DM6PR04MB6379.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GY8hZs3Gue3RqAltANvVD/8TlIuPMpWq/CXasNB5bt7X0ZB5Ug0/91vKJc+zZmq239YYqKVbxzYtXS7fYQXmz31sKrMXkWpQKGbLQrC7vtw561Jowyn2xEGNgyR7WOd5notVLz54yoWIFXvVe5/GPcKgYqJw9m3CcBtZWG1cFookQUSorGyFuUQdRvN4n08Dwi1tCgyJgxC6RBQGwWrEP1n0ahhR6oU5CKJ9WxwXDHOKtw11cOR4FwgBvyGRNFfaUvHBrISF3tT9SaBz8W88ff/RUj3yPlcb8sNT+zK3pKpGwmRUf4/mkEdP+0zZl2axyBFLOV5hXzrS7iY/OxEicHDo5HMHkbb6BuqtdYh0RAz5xOkVjgfEMURDHv2poTCQ02uSNbyUTBvv3bT1uqEMAPbTEcTAztj7Fi466SUuhK6Ui++F/r3Ygu2JU2QktA6z7QCzqI4GFqRqvDXsiDPX7oXpU+kecFsJvTwtx/J/M8JB7/GHlISYtJ45xbY78V0h+a44MOdtwQPn3vOYj7EgkaYCJHz25SxNJRYzG1zcKk00B2+rOtsLBIP3decCl50GLmHkprdYmf7OAd8RhURjH1EAoQ7uMhZRzXCitHed4do=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR04MB0684.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(39860400002)(366004)(136003)(66476007)(8936002)(64756008)(4744005)(66556008)(66446008)(66946007)(1076003)(76116006)(91956017)(71200400001)(5660300002)(2906002)(86362001)(36756003)(38100700002)(316002)(4326008)(8676002)(6512007)(26005)(186003)(2616005)(83380400001)(6486002)(110136005)(54906003)(6506007)(478600001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?pdIY3liZBIMB4gTsTk4e3a/S1la5bWjH3R6DuBcPRIX7n8di4es0AX09X+?=
 =?iso-8859-1?Q?jCcdK9oRpP0dA2HlbrYGxBdbMV5OcglD8hbxfys5yqSPhPa3P1BMXrxeJR?=
 =?iso-8859-1?Q?18nkfLHq5VHFvnFfTokOLy/7BYHWVSFnvaGS6h+X8hvOcY4pnGATQ++ENx?=
 =?iso-8859-1?Q?bOfNRKgQso/bcR6nH0e/OdnBIG7p+9Rzt4NcDIfiy2gAvfUFFX1/QWeoeE?=
 =?iso-8859-1?Q?m8iXpLb64y0cz9TtQsw0Of21pWQCeR4I6zQ2So1h8dfeZthIo1QIt5oZqY?=
 =?iso-8859-1?Q?qTVhIt2sBxB/jxmNbTwT06pOnLdU83havkyUyKAHNxz2Pj8Cz8oH2EJ92J?=
 =?iso-8859-1?Q?oyFdjNlsrTcp7u93gFiaOM4wiG6pf2m6TfdVtimCzyl58LNmi60A7qHByH?=
 =?iso-8859-1?Q?exh7igaMfmmCnm5WnB04E1ScK8UFC9SfuYqV+u7EU98OwLnzKzvqH+TPd6?=
 =?iso-8859-1?Q?AKM1HnvZF4kRvdGgFMpLo2Gm9mol+GdlfN/EgHa8yI4UcCPJnuAVbp7Klr?=
 =?iso-8859-1?Q?YkIyQCk4ny5fMCLuDMRZ6paK9524YHyqOYMuUShxEKZzRsd3CgNsELeCB+?=
 =?iso-8859-1?Q?v3I21Ru5fc27qsPowlHSJ/MBiEEnM5SnnUCYZMKBoEUywLrrfsw3NKkxWE?=
 =?iso-8859-1?Q?ZscieHkGsWbmQ5CmLSuz4mmyVUhJ60deD6zHuvD3d2vslF0tvGXPLsVgEN?=
 =?iso-8859-1?Q?28KVQJGuBsjGEma12Z7pRRX4ZakjONLsDvec9aZyZ7h7toSwrXZKFYFk1p?=
 =?iso-8859-1?Q?2gz7TpU4MQDSldIpqyFYKvrUzbMankTi//y9LGjc5xmYi8VV/r8oVe/rwK?=
 =?iso-8859-1?Q?/UT75CpVHa+RGONOfUa7dTNE7c+SKxD9qv4NKzV89Fmywz0aRoZ9O0eYbf?=
 =?iso-8859-1?Q?rVtdbHgYndSM6yCl0ZpkGPdMXxTT77QPe6vuxc/drEUvPmjBgXGB3s9lZM?=
 =?iso-8859-1?Q?d+CUbd51QAkyrgYG6VXD6+ejHw/wiauBhthQiA3NuZHqq0BodziV2hc1Pv?=
 =?iso-8859-1?Q?Mq6Y9pKTJCoiSz3GGinNZkDwzs8Vwu9vRe9ioOKY2cqM0OR8an3iKZYv/M?=
 =?iso-8859-1?Q?h2+ZBcGhdhruxCXyhNLY9G+ZBUiAn0pZiGbgoC1jehi0R2K1nmiRgGoNi0?=
 =?iso-8859-1?Q?9Mmxs7cNrMPKJaUHTQ/x/Dc5U02hQ0xI3HJxoOONxhv5Av0gF4U2lz2Q1s?=
 =?iso-8859-1?Q?YI4XgPf7DiFLH+HvllVpwxzBkJlXqluK5DB5aWzjh+0dpq2hWdsN+6upX1?=
 =?iso-8859-1?Q?9TOwsWPcVvl6TbdPnmT/sIfEJO8yB+iGG16jLCKrHA+22Lv3tDIs+BHnxr?=
 =?iso-8859-1?Q?g73CTjZCqKC4SjrnejqrmoWr76pTRK9dsJAz56yV9xH4zM2ZsdiHCm6L8g?=
 =?iso-8859-1?Q?xccZoLQBeD?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR04MB0684.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ee46f60-ce61-4e93-d214-08d8fc5d6c56
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2021 20:15:45.2482 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T8loy0WicNIkiw4ONPKjQ7jV1uAPiP+3NoAGIXso/Y6WDKc5wUUrwhyJZsub5W+WSkdsk7hTmz/9mKSzXoFBtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6379
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210410_131549_444111_C06F5D82 
X-CRM114-Status: GOOD (  15.26  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

There is a single trailing whitespace in multipath.c.
Since this is just a single whitespace, the chances of this affecting
backports to stable should be quite low, so let's just remove it.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 drivers/nvme/host/multipath.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 2bbc1685799d..68918ea1d3d0 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -697,7 +697,7 @@ void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id)
 			queue_work(nvme_wq, &ns->ctrl->ana_work);
 		}
 	} else {
-		ns->ana_state = NVME_ANA_OPTIMIZED; 
+		ns->ana_state = NVME_ANA_OPTIMIZED;
 		nvme_mpath_set_live(ns);
 	}
 
-- 
2.30.2

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
