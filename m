Return-Path: <SRS0=W9vg=7X=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 211CCC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jun 2020 22:54:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAA012074B
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jun 2020 22:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="INs+B9zb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="auwKkTND";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="kbo/bZQA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAA012074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=YY6a2HVG9Nyz44h2GZtQz0mwOROKtSXg/e8Coi2V9kI=; b=INs+B9zb3mCEcQ
	LFUQZAWUIhPtwQj1/8bxgrKSZ2UPsQuw9Tro9+O9XyWuDddi2Vnmj81l1bKefa18rL1CFnhtupP5x
	pY6xYniJeEkDjJUWSOz+DVPfCF0XuADzDx9s+WodA8kLTFqHoOrC8QFfW+qMrSevlP4vYTooFdHQ0
	Wun97Ry+8mEyxZvEUMItT7livdZPuNsCJuCxorBE83ZbvHN4vJVbgcOPSqTW81jGv9ps8ILISnPc1
	U6vFxXg60DMNjAeRpAGheDygUOayXpJ35HBdKjlF5h9ALgI9V65GrX4NdLsUpiP/N7J6Xq69IDfHx
	JTlTgdqJlDcBdiM5cn0g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jj9c1-0007of-A0; Wed, 10 Jun 2020 22:54:25 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jj9by-0007o9-Lw
 for linux-nvme@lists.infradead.org; Wed, 10 Jun 2020 22:54:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1591829662; x=1623365662;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=y/k7XPZnjDfodBkfInzUJucZZcClwmrAwvf1Q0/12NA=;
 b=auwKkTNDFOG4vKAolbELksRZm4snzeWOZ7DftCj0MvF1gPaASkE1EQhB
 rtTjdmgD5vKKjoaUbDdl2LeLUeYSPK50ExByFIXdjSTA366cezCbJ2Kqk
 fJ38WJsehnLPi0rDdoPnEPZNCw2cP9IK4kgbM1F5F/qWu800Ct+gAVB9Z
 RT8Fy9gFXPI8vlEbXKIzIiIeoCNPdgY+uwGBf44s5FtDB4mg3NF0a5P2z
 H15tTzFQIE2gGHXm8LRx2jHZHw6hQz2yQW4O0B6PKjw3v5CfAdZibtPJL
 1vekErepLrFvFP+ihPbCBFcPL0H91cspUf9lFlGgnTI4P9qAeW6xPuEWX A==;
IronPort-SDR: cA4uKareFMKX9/KUjQZ/KNzI15aePGxfr8Il6D0dYC6WxmfgsMbgbSZFOeVvnSzc/T78D5ExQE
 cZ+wxPE0o4Gfu2l2EkKR6gj1odtN29re8HSErfdqtVAWHZMTNZOFc4Y6+vEKCCu1ieS/HIKU8J
 l+qAJFKJdrChhg2jnpotBMaQs25pyQOMvtN56shQrVJpDESybRJ90C44wY4Wovdbv22yg+QRSF
 K3EQDCs4+63J4CQpHSyPzxkt3irsute7hDnAxOM5wyhphm3DC5m5R11u/IIzM4GxXgcFsYx0CG
 jEw=
X-IronPort-AV: E=Sophos;i="5.73,497,1583164800"; d="scan'208";a="139675550"
Received: from mail-bn8nam12lp2171.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.171])
 by ob1.hgst.iphmx.com with ESMTP; 11 Jun 2020 06:54:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NWM10BElE3YH6RKTctcLZQOz5aPlNWTkAPp+h9m7vZQrM2sjzraGUHvwcNNyxKUz1PWMftnuQma3t9fMuAbDNtHaAk85Qdl46LAnCp9sOXccz+n1JWFawH+dzc6qkvQFImb/Fhflh+dKkplYf3hEjo3Qfbwz7mrRX0cglGaNkEqPSA15fc3sDiptTaC6lvzVBe33DwUFvH7TZ2af3LIP/Vin460mUiTPSqe9bHzLw9oR4SmMKMboeGYqsk6mgXh4KPYiC4a0TjZhhr+Yz3Ymb6nAEx8CnKFqMYrOe6yA4rMQ5TDnUfHtbCvReqzLuH/00FFEDFGIC61lgdl+wrMoww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/k7XPZnjDfodBkfInzUJucZZcClwmrAwvf1Q0/12NA=;
 b=jpfoCp6FlZ6rbgUhtGWpzWNIAR2Baz79C9EUs2bytlu7ZQD6fwMi+M/uZHb41IzzcT73WPU8OBmVEw8PeFZc+4twJt4aaC2aIiCuIDmJikiqJGDOouIIjb6XZ547jG5JTF+frlsAEFznQ6QklQeXtiKNQOtHw/6zcmElhNLNMUPondIoVlTvQXRSgF97LO7Z2fdEY7fP9aWgdDxkQR5KOdDMYxzWrpZzpkH08qU/YK3JKElR2Sfi+q3q7UIP3z1yiYR/v9lgvkV5DPs3zW5aNTHfPCb6aTzto2x0V2luKOc6bltFM7SkYmU/EdBB3cu0dmVi3B30vjLfgqWiLmnGRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/k7XPZnjDfodBkfInzUJucZZcClwmrAwvf1Q0/12NA=;
 b=kbo/bZQA5CobcsGnFcyBm7rCy/mZzf2dEJJCyYEMkk05aAXfB00XOMcXewoW0k1mV5Q1WdYpnL3ZiMr4UCF9wAb7nMBeb30eretLtxW0t2c3QbfWZ7Wgf2H9zv9jdj5HWe7pRF+KbqucF1V0WV3vk5HaXY6Vbt5L3y/b73mW7bA=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5861.namprd04.prod.outlook.com (2603:10b6:a03:101::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.20; Wed, 10 Jun
 2020 22:54:19 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3066.023; Wed, 10 Jun 2020
 22:54:19 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3] nvmet: fail outstanding host posted AEN req
Thread-Topic: [PATCH V3] nvmet: fail outstanding host posted AEN req
Thread-Index: AQHWPrlulUXTr26y1EmQ/wSQTLiPEw==
Date: Wed, 10 Jun 2020 22:54:19 +0000
Message-ID: <BYAPR04MB49657EECE8DDA99B36340B4886830@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200609235514.57266-1-chaitanya.kulkarni@wdc.com>
 <20200610070010.GC1397@lst.de>
 <419b9d66-e36c-049e-4cfe-21475cb320dc@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0a79be8f-2e22-4c61-7193-08d80d91357d
x-ms-traffictypediagnostic: BYAPR04MB5861:
x-microsoft-antispam-prvs: <BYAPR04MB5861FB18F46F43E339E5E7A886830@BYAPR04MB5861.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0430FA5CB7
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yKAjpw1vb6UKddRj/zrlgkU10FMlIaFRbdFkYdiTcq4tjlXWwTaq2k6EZYKioyxlau1WYRfNJyBu+vqazr4BFQGkoAZKayWA87YFMA9GZw7TnBV8XvneSpq/tHE/wX8f+hP51xCTCvNPKxB46rz0snU4a3oycPRtLp41XFC4Xf/UvADiQoDTx/MsgBzA630fC6eCWldEptczlO91dskOyy9bYLdbCc0gSgR+X4dJn1grb3+yE+t+cEuZWX5LnD5/NjNuRR9JvM+Oz03bb81rLKU2B2WdMs16yhRe38K1BmPKZgOYUBL7RwXZ4oojiLF6+A+iAHvKoMSFAJY5AsducA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(366004)(346002)(376002)(396003)(136003)(8936002)(6506007)(8676002)(71200400001)(26005)(478600001)(33656002)(66446008)(66476007)(76116006)(64756008)(2906002)(558084003)(66556008)(66946007)(55016002)(9686003)(4326008)(186003)(53546011)(316002)(52536014)(7696005)(86362001)(110136005)(5660300002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: X0j3Yx95DTcVaJktZP9Hu4J2u/O0hhW6MxOOF7ryHv9u7B0xeP1TjDJQVRP4fAuKnVq3hVXaiPqm1wIC6GS5szI7edfmBTvzxLg+G4KiTjO+jCKUuUnnBG6x2eZtU81wTyr0LhsbaY/EObE/u7PQFuVDHNuHIeoU0BwB1S2kza4U71oRY4XHrQKfeOJ6M9u9nL8xbMTITEz9LfmnqMoClaYg1cEDqYzBRME8HDIkaSJ1r4C2juSSGuTLHLqiuESRzCDKtXPsYMgOuTe8iMXVQU4+YbXhWWkMZYxjLsSz/8nO3PzCHvU4DIImdAPYBJDHKrceMV6e1Nz8t4XaSmyUcaQhMqR5k8593+sRUFBmMgkUqwtVqeumc8wr5pCN9XmSq7kcOly578pz/hJscKWRdFpvJ5oLKy3Dz4J817YYasFpBUe2FycDgvbfuL0+1LuzOKL7N8xPjqm1FMl2rtH5K7Z9IcmmPWK22q99VbSWuGM=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a79be8f-2e22-4c61-7193-08d80d91357d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2020 22:54:19.1038 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: owfic1/Xus2SvltLxzTQyEZWdK2d+6V3KdXZqb1Aa85c2VTqrGVARSMsAYhXCLs0LMZL6Oze/evvFjuWDDfHwDfSX+pGl7N8AoPic3O87kE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5861
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200610_155422_864510_1D22B3A9 
X-CRM114-Status: UNSURE (   9.25  )
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

On 6/10/20 3:16 PM, Sagi Grimberg wrote:
> 
>> Thanks,
>>
>> applied to nvme-5.8.
> 
> Can we add a Fixes tag for stable to pick it up?
> 

This one ?

Fixes: 64f5e9cdd711 ("nvmet: fix memory leak when removing namespaces 
and controllers concurrently ")

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
