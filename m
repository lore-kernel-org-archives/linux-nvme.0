Return-Path: <SRS0=6U9w=JQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBEFC433B4
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Apr 2021 07:09:20 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D56F6101D
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Apr 2021 07:09:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D56F6101D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=9DUSApGL+Sy5LuVbxjabUBHBj0wGwdsx2P2EFHKrNkA=; b=fMQkiPFYlaDf26Xvdw1xRati9
	b7ZXx4MbCEqnd9Tjaqasi4utPXt1MhOL0f7xJ288UXIh99PzcAeyaTfz5o1jXWNYZxcb+UoqxNicv
	pXHHQ4NADYSL+EVGjlh8KceHh3BhLQrNcTfMSKXur1UsTKE3V7b7bLv/uljc7d9TevuG69mrSJyKM
	xdxpVg3ObC3OFkk40z15qPATDh+MDHMQnP2SYrlI0CrrQ1jRkVxiz0lErdsxUISVa2utDbIpEcm30
	Uc+3UPDedsiDvZNPlGD9eMQINrIsw9l1TuQpoBClDenh4qSXiu2FeJWzsXAEaXOKJcQAR6pBjPEv+
	FTwzBYL7w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lYO1i-009II0-Eo; Mon, 19 Apr 2021 07:08:58 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYO1g-009IHo-4J
 for linux-nvme@desiato.infradead.org; Mon, 19 Apr 2021 07:08:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:References:Message-ID:Date:Subject:CC:
 To:From:Sender:Reply-To:Content-ID:Content-Description:In-Reply-To;
 bh=PxUMHojGh2BludmnerrAmGIXv5EODa/V1Nz36Ejm1Zs=; b=k1cXZO3RuM+CmtqQCd/t7vHCEA
 UvC3R7Quz9VaOoi2ZD+7bOu43th+oAnDPgorETi8NbKmHexpExiEyv9BpZGkaXWSAVvUYAWS0Hw8d
 a5mn3GA/K/09SvE3ZP2uGtDXmJtvRIML0XGROhRQk7yhmqU4W7W7JqFWs9mncV0rQZBF4HYNwdB/U
 ewnPEvFfWxJv7c/ah18qbQZNCcyHMf3aAthAovAnOOe001SKjDxRoTyEw6DS6QTTAWSgXgg//59wf
 GN3nmpydCX36hArnHZ7eMhGBEW1Oi1kptty2NwsndPp61xabMnK8dnRF4s+uj7U6qDeb3C6b2/lSW
 t9UuSFjA==;
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYO1b-00B6dX-Fe
 for linux-nvme@lists.infradead.org; Mon, 19 Apr 2021 07:08:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1618816131; x=1650352131;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=PxUMHojGh2BludmnerrAmGIXv5EODa/V1Nz36Ejm1Zs=;
 b=Z4t4Y215DhJyffpTeXurEQoYudnTtGsJdLOeCHQco24puoowEr5+/Y4P
 wi/VtmY7cZ1g3ds9dnNQFCAdEadZwVj+osV+UFcIyy8hpdGlFMmg38YE+
 LvCso5RV/EaY0dr2h4Fsvds621Wl/sWjQ0LdWeEZT2XzZALddfjDK/Egq
 RuBNSrzmgyM90UkFoP4mvMBM1mmI9XUMU78J6CKOXogUFzN9YKYN5aZ6h
 Cha7KP1VYzbWj+O7nhXJZ6RLkFEMKlK0np7uyTy+8hEk4k54CJZ/B+Xpm
 MClAMcBMAZLJlSTcIwWry44PgokS5wFyQp1S0q67ucUZxo+D+dINe36M8 Q==;
IronPort-SDR: +xuvU/rtfcRuqU0OMBeFA1nirGvFQs9iZ0YZH2uLQ58eOHdeFyRzaAbwT4z+KxnJRWK5TN19tt
 g+vJW7/aLRONu3a6SQYePLwj17gYm2lDQ7HzAY9xTrqldXq7/22hfy6JvK+LhF4ngGh9OhdoEX
 K38M1MWt+WExIPn0B144+gMDwkyp6kwzmJ7ZJ7H3r6soVgyaTdfvXWxk4axaThviJt2fzsKkjJ
 mSiI2MQOqFnILIAbrfy/ePa0gklmqRPTQDfPurhi5SzOIeF6yZWL0lD0he3SoXmHdO/6MU5ipq
 F8Y=
X-IronPort-AV: E=Sophos;i="5.82,233,1613404800"; d="scan'208";a="165419531"
Received: from mail-co1nam04lp2057.outbound.protection.outlook.com (HELO
 NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.57])
 by ob1.hgst.iphmx.com with ESMTP; 19 Apr 2021 15:08:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cqk4piMxJmWqk4MerdKekERfea9MfsCkJ+Q7g/IKdBNkeWh4i9XK4ohFPDj+aabxJxurp2EuFW2cHmfcIvL+IVtCuo0HDn9lC+li8b/aHMfgGzVXxrR9fTtN24I3mAa/epkxKjqqBGUN8fMMwSOQugR40VNVarpNuIWdq4/V1We1cCoP5hqVWOwsDcU1+4Eg+hktFOy+Ah91gcaWG5rr7p4xbFPBX7n6LwvEtsc0p7Bn8Q967UHa5fZg2lMkxRQUNcVjzFi8JxLKSXkccwpSaSyAKfAQNxkZEZk2SLzcOaLc3clP1hAMjXL0ayo8byalS6mEALjz/SVKqXpd6XJ+yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxUMHojGh2BludmnerrAmGIXv5EODa/V1Nz36Ejm1Zs=;
 b=K2nV7xGiGM3XI8h3vED77jIFN4xlAoq0GOzGOG4brqWjVQkHFH3SZTCLxelxx9oXzSSZIoVdB9RaWcWVDCkK0zSfuChluzcqruXwXZjN7ytnGKpkh+2ZdHYznVBUuRKA4KpBdODwS0ReSAo/Dcdm/ekO9JuS9n1XodPZz8UmaOjLim+w3vQt4diIM+5Jro7WdqCfgobLX7LlbX8Xb10iX7TR7da2Pv0l6k/UY7Xa2xjiZB1N3bKaT0ZX3GUDBIGtPLGUkB74y8zRe6FPVfAe+KXfQQ9TzI3wDYJbhG9BP7o327JyT7lLPnMmWV3DAPXxdvupgJk73hSu3LX1q/V4LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxUMHojGh2BludmnerrAmGIXv5EODa/V1Nz36Ejm1Zs=;
 b=uOspYxfLbt3nxKFWVfCkmrZJ+z4ZJNsnLGpwxsV3Wy/vZ3Bf64j4BjFUj74CsRX76HcQ18ttO1mE9R8vm/3bfeVtXRofzM8DZPhExduBze1UicI1idp0ila+grkUbQC5N8fCnq8kQLY2vp9eo8PzhzU+ZVkg/qMYQ63SdEtAFqo=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB6976.namprd04.prod.outlook.com (2603:10b6:208:1e7::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Mon, 19 Apr
 2021 07:08:47 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::8557:ab07:8b6b:da78]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::8557:ab07:8b6b:da78%3]) with mapi id 15.20.4042.024; Mon, 19 Apr 2021
 07:08:46 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Christoph Hellwig <hch@lst.de>
CC: "dm-devel@redhat.com" <dm-devel@redhat.com>, Mike Snitzer
 <snitzer@redhat.com>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, "Martin K .
 Petersen" <martin.petersen@oracle.com>, "linux-fsdevel@vger.kernel.org"
 <linux-fsdevel@vger.kernel.org>, Johannes Thumshirn
 <Johannes.Thumshirn@wdc.com>, Shinichiro Kawasaki
 <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH v2 3/3] zonefs: fix synchronous write to sequential zone
 files
Thread-Topic: [PATCH v2 3/3] zonefs: fix synchronous write to sequential zone
 files
Thread-Index: AQHXMzIUD8ZVvai2c0OhPeRaKpo++w==
Date: Mon, 19 Apr 2021 07:08:46 +0000
Message-ID: <BL0PR04MB651477B7ECC57FA61E1C99EFE7499@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210417023323.852530-1-damien.lemoal@wdc.com>
 <20210417023323.852530-4-damien.lemoal@wdc.com>
 <20210419064529.GA19041@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:a0c9:53b3:13f2:51e7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f86fe9a9-8d30-4847-382a-08d90301f9b2
x-ms-traffictypediagnostic: MN2PR04MB6976:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB6976D230A4AB487D3A6C0957E7499@MN2PR04MB6976.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TG8uOKdGnE/bFcg0zYj0ZBG5vXINOG62B834mCCMhPSgvNJGkSlOdeCa+JmH2V2vOI5l127p+8U9FB91zH6xhdHp2jQwYBf16hu+KC9ERSV8r1drLElveV/mRWApBIeFDQ5gX0OeIN8rvB5zjh3KcwaBhQRzwwnvoefV0xHLK6YV9vDPaHkPZEJ092bijb5te2+0hiREEfIryueQI4kfYjUU4PaniTe3Hxwb0x/8PzJbFGgqSgybnuRvHipBVfmseSs59AZKibYrou+Ys8SQG/kVA5ZQ0UM+oBL9l4yl1ZZG6e7l2U+9rn73T9pJQ4ST4caOcm42k8eX5SdpqetjN/YflzauWYUHEexerbFl9LgrwmHcqKTO4GPqXZkK2YTLRiVYW3HgrtNEfgyFda5vtm0/nVYthvzOxhCtZeBAfmklc/e66Ccqmy4gNthUNm952uYUGjnlG6qEvngD6fVwkbhrOS5bkyREfGNnz4PkwrsOE+ehpSJ+KHjXR1Vs4res4w8TxUoTCVu4FIDJs+5dkmp4FRdE+J4iZll51fi/W7jsm7DphBwkmK1msJC7kx6N7KgAqERqXDxYp6Ji97dMym3XCIYZEUE83IoXRX6Mr4g=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR04MB6514.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(53546011)(38100700002)(6506007)(9686003)(66556008)(316002)(83380400001)(5660300002)(54906003)(8676002)(76116006)(52536014)(8936002)(122000001)(33656002)(2906002)(86362001)(7696005)(91956017)(55016002)(66476007)(6916009)(478600001)(71200400001)(4326008)(66446008)(66946007)(64756008)(186003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?NNJReNrZ64/P0Ymvust1WCgx0Fz1BJVMgaaA3e7mXlW7sKVL9IXfm6uplBpv?=
 =?us-ascii?Q?/gUOb/9hHw9Daxer3d/il6PvJwZ324pmeWkE2ohelx7wsquqrrV3cH00fhWH?=
 =?us-ascii?Q?G9MOFhc6iQoouWW3ZWJjs0c+PqjkN2VMRY/5GfwA8em0Jik7OdMnulGSGIka?=
 =?us-ascii?Q?c06LCmPCIxMZKkS08bB91MKnrpilhQeOPmJBMURmREHxeBpJN2z8o8l7wO9Y?=
 =?us-ascii?Q?9bdqm+39N4pE4FFVHSHgHVbzM93WJrNp6ZsoeIgNGSVT9AqxRIydKIoqDmOl?=
 =?us-ascii?Q?I03VsjtL4O3HDLMrTpZjJ+2edTWM83k8btoikuww4vm+IJK/v55GKht+fMZI?=
 =?us-ascii?Q?hxwV3Sdlk1B3OTARZ05+3KTjeGtgRYmnoYzEIZiB/4hFCgmYEKabX5O5v09z?=
 =?us-ascii?Q?nKowxAAQopdmbqyKMQq2h4nA9+EPaOwzKOxUoExd4o1PqDmOewH13n5xZELO?=
 =?us-ascii?Q?yRM3Y+xjLpmIFNHmaGx0tqKw1IGthSYi1K+7ZaV27KqLUFrBepk5Msuzozty?=
 =?us-ascii?Q?/kJdgDVZM3nKEADXe826X1tw6SPeal4MN9AVWFEkje53s3P87C+sNXh5rjFh?=
 =?us-ascii?Q?jK2L5nNenNbk6emrBHeSNmyVqsRAJHAPqbdEEPya12Gz9M7wcwhwryKehH8S?=
 =?us-ascii?Q?ujreeB7QXMq3klbCfhLxYsH8uYocnmrNPV2NrfNq7a34cnm2jE5xLw/B14nW?=
 =?us-ascii?Q?dwCPMPoOQdeeVpB1aWP65LTb4WsAwYWbciEKDNE9MrkMBcOboPycbQZvEiTL?=
 =?us-ascii?Q?0L4sj84JsKjR/2euHaSWY3mXt1Lql0dKEdWH9JO8ddixb3cp3EbifxSvwQwC?=
 =?us-ascii?Q?NE8Ls3L7zllvwpzE6Rp9JgB76wlXrPIuK/RLp9OF1mByBHlJcKe5tFDGlCGY?=
 =?us-ascii?Q?ggONgx/3sWfUuKFbouW/Ms6Ewj+SS8tTqibfWla7OIRRXTVaiZv6jDTZGHDY?=
 =?us-ascii?Q?kQe48fMUftLg6R7Jn++oYCsVDTpddWjog3yrOJShzTHzcNzIgePDTC2MBJc6?=
 =?us-ascii?Q?HS4CCdV217mH5rYej+pFvAac3EkcxrYT29CDv6BEnT2nLDfdG0uVT2dnnCEB?=
 =?us-ascii?Q?E9jmP75SY85O7C+tkvydwEwtoYT3VvWqOVsHmagXBDoxKuxorxd45H+UqnFI?=
 =?us-ascii?Q?eUCvlczVpbHqH7NhZTyGUCA5cx+4/GnnfgBjuajHkDL247W2cYK/vfJqUYaB?=
 =?us-ascii?Q?nxUXGxAdh4JVoQAnrlwEIn8w3QESu5eVfbMlrGynEmMHQJqhAywT5kQx93oo?=
 =?us-ascii?Q?LfwxIQMFGhJMyXKVWNgDrDwNg+HU64f72CeR8ypQitc3GjBu+pyOhpA1EPdT?=
 =?us-ascii?Q?UXgyhfq5LFI/8hFS1QEkUcH5baqwrLAz1wO5FyotWeGDTDh/vir2M0XNW03A?=
 =?us-ascii?Q?aogbmcSNqJT3icy5xBCB4Fqo4ldFcJbPSdmPZRQogDxcpE96vw=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f86fe9a9-8d30-4847-382a-08d90301f9b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2021 07:08:46.6492 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZxOqbGjYdWlED7Z3fluNIboWDAovZsMaVBEbORsesaYcZw9kItpBUTsjUjlva+A40t9vitWdEcRlMM/1y8tK9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6976
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210419_000851_553191_8990E202 
X-CRM114-Status: GOOD (  15.65  )
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

On 2021/04/19 15:45, Christoph Hellwig wrote:
> On Sat, Apr 17, 2021 at 11:33:23AM +0900, Damien Le Moal wrote:
>> Synchronous writes to sequential zone files cannot use zone append
>> operations if the underlying zoned device queue limit
>> max_zone_append_sectors is 0, indicating that the device does not
>> support this operation. In this case, fall back to using regular write
>> operations.
> 
> Zone append is a mandatory feature of the zoned device API.

Yes, I am well aware of that. All physical zoned devices and null blk do support
zone append, but the logical device created by dm-crypt is out. And we cannot
simply disable zone support in dm-crypt as there are use cases out there in the
field that I am aware of, in SMR space.

So this series is a compromise: preserve dm-crypt zone support for SMR (no one
uses the zone append emulation yet, as far as I know) by disabling zone append.

For zonefs, we can:
1) refuse to mount if ZA is disabled, same as btrfs
2) Do as I did in the patch, fallback to regular writes since that is easy to do
(zonefs file size tracks the WP position already).

I chose option (2) to allow for SMR+dm-crypt to still work with zonefs.


-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
