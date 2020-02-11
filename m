Return-Path: <SRS0=McG4=37=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3900CC352A3
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Feb 2020 16:55:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0117F20848
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Feb 2020 16:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uGs/uukR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="G527s8tN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="y+KUKd4P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0117F20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=nQ7frr91/TQ4w6/KzX7Za1AI9vXyIHMwxeiAd8epCDE=; b=uGs/uukRoXW0Ho
	C5ceYnOS81hRAdBIdp8kvgcfbogBmvKX4TitUA/uiof+DaXwgg0sm3cPFsdb5D08g2v+dOnB13HKa
	Zn4wqLBKOStwrVAMX3bL1JHyItuLT1Og2LauQMKB8zDuVqux9JmUMLTJAO7lkvaZmBAk9b+4O5TXm
	JmkjpNIqTArXpqRLZH3VeHKYWEpjZ3doIUtou43jmJ3RTqRTOlECAa6yXm1Y8tIOWXr8B0O/Mjdyf
	qb49NMEkEKhdmQrJ9udyMziSdhm37GvwwYwPQIfbDooQaDE9C9CPccc6olh+blJmOLs220PHRE/hP
	Ca9bHum0/QAe0JWUkMog==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j1Yoz-0005oG-UE; Tue, 11 Feb 2020 16:55:37 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j1Yox-0005nw-9W
 for linux-nvme@lists.infradead.org; Tue, 11 Feb 2020 16:55:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1581440135; x=1612976135;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=iLkvTu+8dOQa0o65nS3IlaV1RnfpGMmOOh11IQK74Co=;
 b=G527s8tNG6Kl/a7RZnjcTi0/FjMT8UN49d4tbaFh9TDEbajKEc0tutiR
 wKR3sw+X42iZugjKrSsJWnJ1meGPvpm8H2+ScHbrbrTYeCh1VrM6d8ufO
 gmCyyupj3VXuZISTBe1f0q39CnqA2M5nrISlUQgJ+szQWzPejpYWeziKh
 3rNpZLqEgFdGxPHUfka8139v81KIB43le5SPh/EkoF8HAjH8wIjUw+jWO
 1gJ+pgP6KPbSdHPhMRUVAFMT/A3iQ5NhmhYDtqpJwsyQDncY0aO+eAn7j
 UMDWHF4SRNwPQcoaq8MKge85fbefuEjSl+0EnPAs6NbiQI0IlKN82AcPO Q==;
IronPort-SDR: JuB7H8XPjK0ap468LUTwpsI/Azj88Az4kFMVCfO5WI6kIpAaIvhFKdMwOGXYfk5Y4G131CPV4x
 Q9zWPM+W9wK9URFOS7ftPdUwfFeTKG8JAFqoTWH9J5/KnbYbAflrzfFVJ0bJyLZ+kC4mG0vW7H
 87ONfWNDQTXFgy27NzmHkRpmslTg9PtzL9eqCLoRbkyp0rCpZuvoZETxaZ0YJsxgrZ77cgacyI
 Cqj0jXp6ZhrHw3o03xL9zuTah43Ax9iNpho/yh9sLKPE5iaHO69qfnZGrsPN0ap/8koCoavAiE
 sE4=
X-IronPort-AV: E=Sophos;i="5.70,428,1574092800"; d="scan'208";a="130135300"
Received: from mail-bn8nam11lp2173.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.173])
 by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2020 00:55:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OEf54/m3oEYjoPumQSbvCuybNDjHngPCI+WqaOyAW7JxhdgcYYrzr1PxHypHz3hBXB8my/lqCRyjMwWkvEkKDawtnF0SciNcd29TpDOuLmGqh2MKWrCsiyNSkDYDWF9MTp7aP4llhD0XNdzPzI8mItYjnOze/JN5mant6DD+MfQtUsaThYtzt0+HreDB7MswxjM9+FGYjcQt/Zg3u2pPExvwa/tRfh613oPSG/3obJ84z+WhYO1fuQpcxyXSpB64ohORshQ2aylNYWaHTMOXgoLS31wePvXtY9LzokPaMV3rLLzCtkEJeEgtfShF5fUonTqhL+swXVJQ3FFjyBGLlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLkvTu+8dOQa0o65nS3IlaV1RnfpGMmOOh11IQK74Co=;
 b=Ub2lvjLDzSACiSYDASGH1rvy6RiB9hfcPlLxccLWkYT+zcNs2Un5TfXEEjq5GPvZlkN4DxUWwminB+T0EYdD6CGmXIyOydj6iDDc20A5aRBle4Edx8ZWQ5VOlm7btkICDUuWCFyQ6JDSlF8BgkqlsB2TBs/x9MhPWBp9NoYPq2Mi87XY85O9XcE113hgz+iS72utGRQzev+BNjTw96mSTvOANv1ngTTzvYDDeHKAHM08PyZi0IuPAVlc8WZwiJZQ3TZepk3yYZBzspqcPAekHJuQ6d/EtlYQi77ahw5QAsNMMi/bx5aakv10Zz/ID7+Yr+uKmfXB6v+IoOMSmK1XVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLkvTu+8dOQa0o65nS3IlaV1RnfpGMmOOh11IQK74Co=;
 b=y+KUKd4PLmhFZxZ4UbuuQM9q3YLy9EME7/kL80PhPjNgPpQ/YZ17HtZfFsnRnbWutosutZTXRWIqD2I08CWrdvFTfXX5H4aqiCfxAf16Yv7U9IOG3N0bkdSQr9YjLENff8LT+OPYNAeTPDPZgoMinSd8/ROjkDQxJaCqeyRogWI=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB4070.namprd04.prod.outlook.com (52.135.218.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.24; Tue, 11 Feb 2020 16:55:31 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f%5]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 16:55:31 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Jean Delvare <jdelvare@suse.de>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme: Don't deter users from enabling hwmon support
Thread-Topic: [PATCH] nvme: Don't deter users from enabling hwmon support
Thread-Index: AQHV4NiiBzvU2tDXOEaUQl5QvMnhPQ==
Date: Tue, 11 Feb 2020 16:55:31 +0000
Message-ID: <BYAPR04MB57499F5D62181577D815E3F986180@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20200211134136.099ac9eb@endymion>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2f221be9-4405-4311-e0fa-08d7af13349a
x-ms-traffictypediagnostic: BYAPR04MB4070:
x-microsoft-antispam-prvs: <BYAPR04MB407011192650F70784D0384786180@BYAPR04MB4070.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 0310C78181
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(396003)(366004)(39860400002)(376002)(136003)(346002)(189003)(199004)(33656002)(55016002)(9686003)(2906002)(7696005)(26005)(86362001)(4326008)(66556008)(64756008)(66476007)(66946007)(66446008)(186003)(76116006)(81166006)(8676002)(5660300002)(316002)(110136005)(4744005)(54906003)(52536014)(81156014)(71200400001)(53546011)(6506007)(8936002)(478600001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB4070;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UZpMoxq4k6f4BbUrvuyaA+HWIyY0lJ2PMIv5IEdOwgBRgozcSvYGABb1nJqyZ3td9XbP/IHnH3H/fRnmBKBV4b/DBVML4nJ53GD5h034bM9MZa08drAHhr6VGjJpAryV5gZMMtmAv71bZdhFoK32LNvCvoA5BMi534nVWm/3ppYcAkGPH1k0Lr3RsNFMzYYm2YWccExcEsqX+wRTi3xUuLX3S6oA3b52uibfRWJC70B3Ap4UVfMeUSTOgNK35LjvCTa93G0mNQmMmPfnK/zVx1wfKpoY4xvc/ow9P0irOQhumwnNkCSiGNqS23DRzRrgHk4ybliVM8aHCOifYbh9AZjQ4nn3G1+7ZDUKS/zfxoS2SQF79d111UkLvejJYo9l1kNY2NRU2VRE0D6XKLrxNdEiF2WIVySwj+BLH/Ma8BqHWIsrbgMKYD+6Twc87wTG
x-ms-exchange-antispam-messagedata: WSkD9eQOCNAwLDw/XN5ZwsJkBWqRp8Lsw81vQ8jF/iEhSV/WGVQsNVbkBSYzW3hpm7/5fFWv9LvYtBZAYx5HJM1riouLUicEZavQZOoLVF4MHX5GiAVEh3rI8RBNcg8SFap6wdXf74PpN47cfdmR/g==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f221be9-4405-4311-e0fa-08d7af13349a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2020 16:55:31.6560 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qqkELiKlnNoUNYNDKpflu1mm2RZYmEzRRfP9ShEIhzuicInBjO7HHYvwrhhuur4rEs+N6JdDC1HFN4Q2Y3DJ7JZvkiJYuLlkRxJOEJheQBk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4070
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200211_085535_345820_AA2F66BA 
X-CRM114-Status: GOOD (  12.73  )
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
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

On 02/11/2020 04:41 AM, Jean Delvare wrote:
> I see no good reason for the "If unsure, say N" advice in the
> description of the NVME_HWMON configuration option. It is not
> dangerous, it does not select any other option, and has a fairly low
> overhead.
>
> As the option is already not enabled by default, further suggesting
> hesitant users to not enable it is not useful anyway. Unlike some
> other options where the description alone may not be sufficient for
> users to make a decision, NVME_HWMON is pretty simple to grasp in my
> opinion, so just let the user do what they want.
>
> Signed-off-by: Jean Delvare<jdelvare@suse.de>
> Cc: Christoph Hellwig<hch@lst.de>
> Cc: Guenter Roeck<linux@roeck-us.net>
> Cc: Keith Busch<kbusch@kernel.org>


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
