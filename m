Return-Path: <SRS0=7z9d=C3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CDEC43465
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2020 14:31:45 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78C98235FA
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2020 14:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hIuEf6SH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Na5wzycy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="UnGIapQo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78C98235FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=UrnmMdMmThrOI6Pf77jWoikD+aB3H6TZFI6faMXrApI=; b=hIuEf6SHM0pTgwXno5Ixque6h
	MNm+cvd6QXwipM2aHSMajMgAG5Q08gH3pxX4C0/5F62OV/9dmoYpQhSLfLCbx1eEurldQZvS2SUgu
	pIq0QIHk5gYbaSb7zZR5cBSfho5TcJn4oO4iV9Bn7QDKonkx61eCpL3mtvFGqw2cXxe3Dj5IbBptg
	y7OCpt7RBl4cAGIyZUD/6GxuEsus1p0NZ5YRuL84BLMldjNt1k475KV3QOvsYNdXrDrZiFt2Lqbel
	4trZfsCdfGi0JFQPkrAHAAjqFiaNx+FEMUPxZSLV65Jcdh0kA88IeNXkNalAug4IE5/d9aBV6qtDh
	ZKBcjyGqw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kJHQ2-0003O1-NO; Fri, 18 Sep 2020 14:31:22 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kJGRp-0001BN-0N
 for linux-nvme@lists.infradead.org; Fri, 18 Sep 2020 13:29:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1600435750; x=1631971750;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=Q32QRsRtvtObYYuTNzLNG3+HC5lh3SmW+ga9yYvPHT4=;
 b=Na5wzycypffirfjvX7nIxoTXa00NpYri6UPrtvrKN57MBt5r2R7VOgJ7
 6Xjw553Gol6H4abDcKaFx733JDkdAQ7SNO0b0RM43kkLqQJNuTVAxhyeG
 2CX7+HmeoXUjj8/2K9GCr289O6TtXM5puvy7/eWHu3nzs2A1mQP587NTo
 N+9RyM2HEMdfTNGlpC1NDK0JIOQRUu/pBsCZw3aWSPGtXNlg749PmXCaL
 VAzf5NhsbUm1ligAmkU+EdY7TduuzSAWSRl40gdzBI8shWEQupgnDqcD6
 +qnZ7YXkRAH6Lb/hFFNPGSkOaiV/Ema5MiLczy0doGuEFx0NXzMmRd9tI A==;
IronPort-SDR: jSVAc2dsPX6CP0JdfNiMXFvPS+LPdqaDqpDOODMnDf9PpPCkew/n2ndBnZ4Fo/bQEr9S14KzqB
 /YtveKo6clVTFhO+PojcuF6+oAEazJ5/CMaFIMvlIYot/K2JZIGkap6MdIKVzVSPk0AsG3OQC0
 bxSvQF7wrMokR0vOBKSy6kLzmPugpZZ+BVfTaAguhqU/JG8imhLgD6ngUhG6T+Dmf9Dr0pBIEx
 q0Nv6P0rzfJTuPpsh3dFxBZ1HHDX78G2yegLRdFlcifZiVrACNtBCpefFgw4SqTMLDczXzMqPo
 rb4=
X-IronPort-AV: E=Sophos;i="5.77,274,1596470400"; d="scan'208";a="147737103"
Received: from mail-bn8nam12lp2170.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.170])
 by ob1.hgst.iphmx.com with ESMTP; 18 Sep 2020 21:29:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L37rCR1uz2Stw+FYgwTDIj2KoKNUz+mdGQY1Z7ECddEAuMGJcEwlxkAHQYwBfGDkPnvx8q3EpSEgWHdG4NfAPNCrNE0fHpCqbudgpwLkIucD2Emu1cuuwjJp4CT6XIX5zrgaRqpsbfewYivvZIKObpfRmmDUpuu3bogaIFKB/coKtH8wHDJKYM+Msh0/zSCOtnFjt9AYdFxDDQKE+Cb3cRJpQsxIK2Nov8abXgypOomUhbhAcxCynuDH4XYn9vVEuH/eyqtOHDr2ooYH/bOtXHQIhN5PQdD//z3zvtWAf8QNQsRgME7PI4724GVbnI/odYTeASpjF0y21TbSnvwr0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q32QRsRtvtObYYuTNzLNG3+HC5lh3SmW+ga9yYvPHT4=;
 b=TVxLsYQCY0sW2dsATPcyQPiAX3OPEledlbUOA61ECvxPk7+ChaHYXq/PSfZDUlbMGfvtUUJ3f4MFbIpTbUBzYK+VlK7oHakEcETcPdyhyUy7arfTdtG7MsWn+MV8L12RpQ1NUj1qdR/gn5jG9QKniz/HuPuZNoJbKTsGCSBPU0Hi7GyvnMyNjO7fArUaS5kAL71xdMwBJF7vaMYrwwirdkQxcsjhnC0Jyddag3UryweQ8ejSkADDzWbiIh9HpNdrfrAo7ATWyRRdHtGh7MLQZjmKdJhvPcnyzINFJJNROOojfgH1+JQz9pbmYrcth+9eb/AO8cCGXXPCQyW2a6ZRzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q32QRsRtvtObYYuTNzLNG3+HC5lh3SmW+ga9yYvPHT4=;
 b=UnGIapQo/VzEdq4/vzOAyiSnAW2061jVIX+zYjt8CpIC1PN/fdsaaCicTkY10cB5T/dcMbN59igccsMph4F3LFfCrjbDqdicGPdp0rD5+mkRK0GeqlpZSoWlnqCtOrKxePxJSjMw0ANy+5nV5Pq0bbQffChGopus3QqWRr4Tgss=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4543.namprd04.prod.outlook.com
 (2603:10b6:805:a5::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 18 Sep
 2020 13:29:03 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3370.019; Fri, 18 Sep 2020
 13:29:00 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Keith Busch <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "hch@lst.de" <hch@lst.de>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>
Subject: Re: [PATCHv3 2/4] nvme: translate zone resource errors
Thread-Topic: [PATCHv3 2/4] nvme: translate zone resource errors
Thread-Index: AQHWjUjpDWYPCX4jkESswoik4Y/w1g==
Date: Fri, 18 Sep 2020 13:29:00 +0000
Message-ID: <SN4PR0401MB35981EF822D883E062E633989B3F0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200917231841.4029747-1-kbusch@kernel.org>
 <20200917231841.4029747-3-kbusch@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1460:3d01:8d9e:cb93:a2df:3de3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3d6bb88a-6165-4963-c35a-08d85bd6cdd5
x-ms-traffictypediagnostic: SN6PR04MB4543:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB4543570C9713F9B5545233B79B3F0@SN6PR04MB4543.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wi7iaWxqbtixwDmpO06ZZbhsIIMY3dAwegCHlS7siRp11SS0bMqYZHH/Y4b1LpVr0UnApygRkJXkeaBwV/xJ1TB4Kp37kES8P1o/csjn1rEim7FKT7BNiRa3kKJb50xBFsH9RSD+GycUpG94iSGsEbaX04Fd2JD5loP2ypw6huDGrl0xSFNK/JvuIejr3pQubMRN6Shpqqfr7j5+N4WC3aYNnbsofmwVhEp/cjdvkB4KxnkF5JZJP6H6QEQBlE5Va0ErmflDjTCUpxdDkUI9jS9WkuwFP5QW/udd4cqvAMe53LpUwi53Fq+4N6Ft739fiws/6JzQQnhTVIQbXGJ9JA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN4PR0401MB3598.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(8676002)(6506007)(558084003)(33656002)(186003)(91956017)(4270600006)(54906003)(2906002)(64756008)(66556008)(66476007)(66946007)(19618925003)(8936002)(66446008)(7696005)(76116006)(5660300002)(55016002)(86362001)(478600001)(110136005)(316002)(71200400001)(52536014)(9686003)(4326008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: MCYi92rM24wPMd48LjUQIQC3KkDxJAbjG2ZwCvHKYJhbkQ40smotBy1LP+fY5XZ8f+Xx70X9xfrnpQR+i3P/3DqZsOIW+2rlw0qQNTNJQcFyiZXuBxdkkjaxVzI4kzOtrVbvzYhXUR2P5554g2O3FjsbT3jECJrwRIbd8pELWb/WjMNaAP+oONg1VJt5Rpb1NCZrr8/Q1bmE7J4bVRVXq6wdtDvBVexno0wqvuz0MJJ9HvEPRCnObGRV19ugFIYCQmGhwYj+56PjJ4WhcDTzYDNmp5YtXak1GbSyr41VgRxh+J7nncOoTqHHtv0+mfS9B1C/d+P5FcfbVftusx7rqsiv8f5zsRsdaqs/zEsBlFH0ngi/2jF1OnS4oKsy7olyCHmoE4y44Sn9axWzFIQHwELmPBfzWpqxYIBukD3tiusKRiYKQ0W+Dr+DZTYtLdkQL13aD6eYimIr7fAClCGMtgMnemZr/1I4MvpdokbRmFzshmnZ/mLdWJeZ0WeeqoV2u2y+62GGs1s8G3yE9i1dwBORL7cvWyfZMJPgxDYmhB2UvmLvzka3HpVmQ3Ay4pkt2e4dHzzU+/O23GgTbD9HJ7ka6QgS87yOKa8+bLg/WoZH24vLqLkyvCCcsdBCczJaVoyt11PmZddMuVaiKOMSNdGoh7sXqBRRxTAVveodOAGvv1lWqngazsfko5VMGHPbcyxQkYHZ+xG+52t6kLrM3g==
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d6bb88a-6165-4963-c35a-08d85bd6cdd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2020 13:29:00.6013 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0QOL/TB9JGjKrhz+UIL3PjxAx1lMLplokHSVhqZ0QHkEMog21h1MYv4TjFHkfIHOrnYBcWJIVNieIfhDRN3xYtAcNjodleeMFPPbS1YY/Bg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4543
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200918_092909_419015_984902F8 
X-CRM114-Status: UNSURE (   9.22  )
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>, Damien Le Moal <Damien.LeMoal@wdc.com>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Easy enough,
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
