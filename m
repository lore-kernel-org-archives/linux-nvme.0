Return-Path: <SRS0=g+aI=DG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02040C4727C
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 21:16:04 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CA3020757
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 21:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ih/Z5MZM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="b7TxMGbX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="bovHLlPN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CA3020757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=eGl4O2zXwSf2gyRZP0IRqzl0zuomkng1uPOeo+0zGbo=; b=Ih/Z5MZMzoyZRXDJqIW7cQKvi
	+WG/i0DAZ6obHHQVjbHeEpUFDSr5styFs7mzpbgFeiXRlLzj5NOlxl7r6Idaqi8n3nI+MTe3rgPR6
	DRxk3cHWhAV5a0uJ+taUCGdveGznIbP2CswiAJxuesmMNGCWNneUtnUJOalpott9aI03f4Tf60h9O
	jPQMQlPMd33WYBnZXIZTOQHcG7NRMDB4CvxSz/wQt7by/HVJxxaKC3goFkBBzTz5k2kuFJp72ZkqX
	ZnKSrqoNXalP1j8JDJB3cSBGWIL1QI5ZwpMtlb9joZ1458UBWJ8y1PUNCd/p0b/VqvWvd2xqY8+mr
	wTEXr8klw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNMyd-0001UX-QT; Tue, 29 Sep 2020 21:15:59 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNMyb-0001Tr-87
 for linux-nvme@lists.infradead.org; Tue, 29 Sep 2020 21:15:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601414157; x=1632950157;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=+7EXJwDxmjAyrsbNJZSNyk/JTJev1uTmOPjKat0LLsc=;
 b=b7TxMGbXWF5b+ywkWn+jnuP1ZLSh4ur+YVoRzk//MJfOSNNomeaxBWs/
 LXJOdDgacHViUhXcIcD1zYx1rEFWKuVIjfEiUV47qtSQ7bO02cgA2wjxh
 ge9g2BXZZNNQ/kvvvJAfc2SBmLyJhICwjuxyc14Ew+BbQY/aXf5/zyxrG
 UOIq3Axr41yiVBXOLNEtTyO4xaJ1IBxvRs3O/P8liDLG6iPPspNRFxw9B
 Q+m0vDAKV48/s++rmBHQgCM833kjvb0dl0C8Bhh8CJUuosIuiqltZYJlS
 iNyuBdyeUVJgvNjhflGYoL0oGWSk59Gy9uEfwkyn1fCBuTnN1QGhM0tpa g==;
IronPort-SDR: ++I5ErxdRaIUTaA9bOcAOwyUKdlUJv4HDts4dILqMLHI9h3fxPPlcGED/jhf8TpwADPIcjBm17
 tS6a4inmA31TS2MgUqHGxoay5wXaS1DjN+qaqUI9ay5sitR9abogglOd7CRUDGH7KXtlXfdRQ8
 jIN5YS8MmVjs4jBqllrKixi+IvlDSagVzgL4Hn8mzPs66vs9gge+OILlvw35k4ezyhU8BRswSK
 2HeqmT8uuHdciwzeOWlhtRuNCSu/PRuV2oOkWYT/qDzc3FA7TYkgS9OaTDubnulhTygtKItT8V
 iYE=
X-IronPort-AV: E=Sophos;i="5.77,319,1596470400"; d="scan'208";a="149812253"
Received: from mail-dm6nam10lp2104.outbound.protection.outlook.com (HELO
 NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.104])
 by ob1.hgst.iphmx.com with ESMTP; 30 Sep 2020 05:15:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eWRyMFxruIwP1R2vVFwq2B/dCjGCJ2gb0Uz24F+ELN26e8yF27OTT4klBDRejWj+zqiFqXA35JNCJ/+yFjWXT2Dbis3c942IX4xpZ/MSxCTmr16QGwMHAeMTmh6Wmsv7GLoatgPXvXyV+qmSclQ+7HDX/Z/ebiao3mfl34EIFw1FV7Q051iMvzfrMk1ZJafkerBDOx2pf3RgDGMm5o/hg+HYgE8moew8vYA6tzqQ6vpScThf87Z5tMZVV4FGrLkjCrLDoxKKaxXmZU3zBv47FhlJ8xQh82r16J36p5BFECEVZ95VfGsu2/HFcdPpYYF2uhZRYaLTLgWKcESairG94A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+7EXJwDxmjAyrsbNJZSNyk/JTJev1uTmOPjKat0LLsc=;
 b=k8P/v+rLZVxzKhuajBGPbzWAsbIW0TDB8NWMfhgtoklmXsw/ByWdFteluGyX/rlZDZ23Zt/gxfflG3zbKOSUqSYtOfvGkK9xC5951BS2RaWjBu3jB0vSEI5YJVRZRcorenrEEtef4IoxDdt+7K8wtzrFVtJwWh8IDb04h+wQRn+MIhGaVmrmuG/GaIYwClfLu2M6QbwOZxvrnM1aRijmdjsPOVlsEV1fURsGOX+8ZpWk265xOPMMT8w4YJLJ3AP0JorAesbLk6JkgZs945Ny2g9vrEQjISFv0eUX/CNUYSqDla9KLx3VeYN1GBOss1kQlsLCxt0G6bSsWYCI/6irrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+7EXJwDxmjAyrsbNJZSNyk/JTJev1uTmOPjKat0LLsc=;
 b=bovHLlPNA38f56HMdbYZwrY9z3g1669ViUcXETlmO6qMv5/fNzdtADMnurc9BuWqd2hn6ppC7tZ8ytj4WH15EvvMOFeAidYA9F2Ogsz6PCN1Fid3oxPPlgsBhBDaBa+4XMifuDl/tyKMSbWbriaHdIu62LeZ1uznRA7bhXgiNV4=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4759.namprd04.prod.outlook.com (2603:10b6:a03:15::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.23; Tue, 29 Sep
 2020 21:15:52 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::e1cb:3a58:d588:d7eb]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::e1cb:3a58:d588:d7eb%7]) with mapi id 15.20.3412.028; Tue, 29 Sep 2020
 21:15:51 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 03/20] nvme: remove the disk argument to
 nvme_update_zone_info
Thread-Topic: [PATCH 03/20] nvme: remove the disk argument to
 nvme_update_zone_info
Thread-Index: AQHWlZSr73s3emmhpkmaECBdl/pH3A==
Date: Tue, 29 Sep 2020 21:15:51 +0000
Message-ID: <BYAPR04MB4965EA6FF473B6C3E7D403FE86320@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200928123502.435373-1-hch@lst.de>
 <20200928123502.435373-4-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 45858513-77bc-469e-d8a0-08d864bcd847
x-ms-traffictypediagnostic: BYAPR04MB4759:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB47590487418BA9118EBFDBB086320@BYAPR04MB4759.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Nh0kCAHCmndRr8spXq+biZmjiCheePCygdC/cBrZPMjMC8qCJcga1II6IkwDWv/DykdedjQFrgz0hL7kpHRdNTe5SYWBnK1xxD+AT21qUjN6jXq0LjtesGR1qUJc9iRl4LPzDEqZMxJEdF6PaSd2OgwAjwzTMwIU74kle4BBbffVZODezdsyHemWAmeul/W2DKi4lYFLVMlv7ezE9Q72UyYM1WGha1PoF5dJB4+iioTrN0JehBzB4zFVcdMSKL8SoC4XZA0mseo/EuQvDTOn8fSbf6pnl5FwaCIEacZ2XBcaJPGOQcquUzVtIQ7L8aETbHhlID0cC56Rng39MoPIzDBUjRK1Q6pb8HAAeFIq76jtQP63B0sUaMhoUtX7CrLJ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(346002)(39850400004)(376002)(136003)(186003)(33656002)(478600001)(26005)(316002)(7696005)(110136005)(54906003)(53546011)(6506007)(76116006)(66476007)(66556008)(64756008)(66446008)(66946007)(71200400001)(86362001)(52536014)(5660300002)(558084003)(9686003)(8676002)(8936002)(2906002)(55016002)(4326008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: Hk88BM5DSYQHpXXtvhalAF3VkEElDoQ3EN8BImxGZP3cCCRGva3+V79pZkTRIKzs/cbjrn6Fphufyo9UoaeNSZwuJIU4PNWf2+lBQyFv84t8lsPPgumnRf9rD5hT9OA9HFlNVi787cbDBNGKScusBnMPCZpahMCGm1SSxUUP3QKkFaBCf+ZhmE71oB8+nJel0uMndHc5k1F8niR99YXp5QujCl4lutviOMz2OEnqwvLgw095a0eRNN9uhqlbJJ+PvPS490VIYibuy5f6iMp9M/YU7yAr9hcswsbQ994R1puNUQGngozOGzQnKKlWkTq8Ri7cK8i0TXEmcnGYYthwCkqAYqgOz5Smn/mcrKafelVpYySxg2rtx/jE7UBppVZlTBD3S3iImVXW1k97UOb1AxTKmw81dFS+0CHde2UrQw5KDYv5VOe18gvJPaoFc5+hFnBCkyJIEtUqQQP/29+mS2EJ+YIcacA+eGTNjxJGFB8Qmw96Vf7S5LW9toPuaOquO2t2gMvH0aieJSL22SmeWbvNHPjDcmBhf8VStyA9VFz0pTsT0AheMqoEeUf24uCYPjpkH2DgfCN3JqDTk0n09YqAzdUcefXgHpa1warjrG0Vz/+pQ1qT7zCvv8JD6O3iHWRYq0QCjEoKQn67QW5hzQ==
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45858513-77bc-469e-d8a0-08d864bcd847
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2020 21:15:51.5723 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7zhFUu7hoY1TmqBVb6c1g4Nn/rQNPjfZ1mo25t2bFXuqbrIg1PpHrWBmMxW1HTeEh8BI2VPuI8OVWy+fB57l6IzYyaA7H0bU1uxBHdkqi+4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4759
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200929_171557_417561_FA67057B 
X-CRM114-Status: GOOD (  12.31  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/28/20 05:41, Christoph Hellwig wrote:
> The queue can trivially be derived from the nvme_ns structure.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
