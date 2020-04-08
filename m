Return-Path: <SRS0=zNed=5Y=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91497C2D0EA
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Apr 2020 05:48:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57AAE206C0
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Apr 2020 05:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QVTcnYPS";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bg/LJbiQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="yiJnGTQS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57AAE206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=WO0z28ck3dhwkB/F2G8VPW0LAGWjgjPJDKMoVgfOlgU=; b=QVTcnYPSQOQzDQ
	wpgZFcNu4behtjR0OIAIu3QeTgrJY5wS8bcNMVB0An6tPqAfy6EbCSmqR+uScos1rrdgc6FLLFdE4
	PcMgh8VRlLKDdlSgis1sLaK8zj/tBvBly8amh+sHchykVJ4ZTpKhGKggpZhx6thYwlzluAO8Y1POT
	2XRAVNMKKXd1GqpcdopocOmnF4E4/f0onns9ZpQ5mX+IDpxZaLbeIcHmHKELJv10pPMdLGM0vUlkb
	tr+ypXbXAmw/G00ucCEkIcB7VnCrLNazcYdJQi0SKjfid77A/BUDlGEZC0cR9q5Z93GcDex9hUI5C
	vEL3lYgJlUJXiC/Xwdbw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jM3Ze-0002kb-SE; Wed, 08 Apr 2020 05:48:30 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jM3Zc-0002kA-Ed
 for linux-nvme@lists.infradead.org; Wed, 08 Apr 2020 05:48:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1586324926; x=1617860926;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=1FyZ7qCcjDlebZ/ecI5qU1MBc3GvwK1kClqsmD7syGY=;
 b=bg/LJbiQIMDMc7hvp8OxNcg+DVyn3qqeZfORX3Ka3zojd1a53Ddy3zYw
 c6rKQ0xYCyJ6803EtjuoKTtW6fbUNwS/prpduB0al+EFU3n+AiYBV3lUH
 vczq8sjxjSY0LZdrKqluNKX34YNi432xBcCxe5b5yiXpJCKVr4S6rIawV
 z18VGtvEgGfPMZBd1E22cGgH5PoBsAm49ThHcOsa7YWqMz/+Vp4i/31Mw
 l6pxgkp0vEVoOoDzqOkCoTtWsMxuhRzWGIdb1NzvnqUeIKpBMEFYIlCMU
 09l0eyg2SAvPgbSYkQqhyhKsJRTrHH73DUX6FubwCKJ7ilWOhynpi9nJW Q==;
IronPort-SDR: mMKKqOAihq/jz58+Xgf2Nb3kP2KDW4Xnp8eMjTrW/lktkF1eP6gpBKUZnpybleVRGU9m/MJMNZ
 GpoF0kotI5a5BiuLMvoHRBmj0Nr6eNk3W1jQrZOY5rkPyimCbQ4FFShiqkjJXtCclBwm22AqOQ
 PHIHSdoX+UfpqdnOrKii1W6Rp74usfqP2YdCfd4sk7I+Gkovj5yRsrIAz5qzlqRyx5y8AbLujB
 8ltZiVhY8o7MbMt+sMLVQzTDe274L4nbwbcz+PMCF1xb3S5MNy4A2Qa+yDeEVXYZSlkD2JdBrt
 Ti4=
X-IronPort-AV: E=Sophos;i="5.72,357,1580745600"; d="scan'208";a="237167914"
Received: from mail-bn3nam04lp2059.outbound.protection.outlook.com (HELO
 NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.59])
 by ob1.hgst.iphmx.com with ESMTP; 08 Apr 2020 13:48:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xv0yMHoRg/Y/vJb9HzyldUNZwj7BVT2jqxXzqvIVxePh3oRX17NlLXnPxpIonNpper84by/8t78HsqW13qGNOQCnMPsqS9KO1rWT5fNXV4glp8AtExPUND+tMl4xveP9YX4EwqrWIAxDwJnbhNp6PpXFot+W9ZRJfKqZz8Mf3+wLvz44YWIV9HYbI58JKVYyk/83JEcBmLURxTEWBphSi+sFtuI1S63XnlPtQQeQR0GlE5r3bpIwTtCg9CIZTa6upez+ZjG8VHcHTO7ZvVw96MnZqj/NxwlxOBdnaR1pSF8wihJOkoQc4DmWEQ97eoUPe0OMipt7ytTykPPjVRhQ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1FyZ7qCcjDlebZ/ecI5qU1MBc3GvwK1kClqsmD7syGY=;
 b=CD56qgrvUdJ4gjuqRZvWjk7HpIb7V28jn7deSODDybsS2bCCU8akAujJksZoAndtckUORqF8J5I8YkZ2OSRtziiYgt9NV4DLwvRm88bb1UrvXhHnZvCNTyVKbab3wHVm55OEsETyGfaEl+3QkKAHTEDXBNTUAeech8w8OBEZ1sgBk+Kdx+XUNMqINhxJZU5QUMws/ReBzGGNso5pgE5gjGkD/oV3qqN7W4xpxRbEkZB47FXA4hkG9sVmo+JHiXqC1QtZLQjtX+miVsmRtsubYyF9Y2myyoaq7Hq7ONsfYl/YjEqGObIpAI5ARN6YNZtn8fqk7EtXSZt5GcT16vBtzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1FyZ7qCcjDlebZ/ecI5qU1MBc3GvwK1kClqsmD7syGY=;
 b=yiJnGTQSe3Ej7aK4RZk5GUnk0i8MFHZ9BzfTB262k52brffSWhQ3FgGJ6gMkTeBTXIGWFFoRtVlvaqCQLlJKtRLRmo4p+7KgCumtzARl8B/9t3tupbNvWw+JmOFelYVTIwcCF6g7jVgEGG/vLSvZjojXZ/8QzS6tIsLt83jTqBE=
Received: from SN6PR04MB4973.namprd04.prod.outlook.com (2603:10b6:805:91::30)
 by SN6PR04MB4928.namprd04.prod.outlook.com (2603:10b6:805:9d::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16; Wed, 8 Apr
 2020 05:48:16 +0000
Received: from SN6PR04MB4973.namprd04.prod.outlook.com
 ([fe80::b0f4:a811:73dd:6c4e]) by SN6PR04MB4973.namprd04.prod.outlook.com
 ([fe80::b0f4:a811:73dd:6c4e%5]) with mapi id 15.20.2878.018; Wed, 8 Apr 2020
 05:48:16 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH V2 2/2] nvmet: add per ns thread to generate AEN
Thread-Topic: [PATCH V2 2/2] nvmet: add per ns thread to generate AEN
Thread-Index: AQHWDVyGx1h1rDwyCECcI/Bh3Diljg==
Date: Wed, 8 Apr 2020 05:48:16 +0000
Message-ID: <SN6PR04MB4973D768048933FB3BA53BD586C00@SN6PR04MB4973.namprd04.prod.outlook.com>
References: <20200408041633.20632-1-chaitanya.kulkarni@wdc.com>
 <20200408041633.20632-3-chaitanya.kulkarni@wdc.com>
 <5e54afaa-7de5-a89e-5740-88df15c52bba@grimberg.me>
 <SN6PR04MB4973BC935AE3BFD4CE874D9B86C00@SN6PR04MB4973.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a452bae3-0fbf-48e6-8756-08d7db806f19
x-ms-traffictypediagnostic: SN6PR04MB4928:
x-microsoft-antispam-prvs: <SN6PR04MB4928B0CDC88865680DFF156686C00@SN6PR04MB4928.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0367A50BB1
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR04MB4973.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(346002)(396003)(376002)(39860400002)(366004)(136003)(81156014)(478600001)(86362001)(8936002)(33656002)(5660300002)(76116006)(66556008)(66946007)(91956017)(8676002)(4326008)(64756008)(66476007)(9686003)(52536014)(54906003)(2906002)(7696005)(316002)(186003)(53546011)(110136005)(71200400001)(6506007)(66446008)(55016002)(26005)(4744005)(81166007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i6Lyc9eArWw22m989gAZtzCDRoL6j4tXau9gBrdfmILEIQ/Dm4N3RXsSO52mH9WoNDOtRk/uKlKfX50l1+OjJjNrsHf/5xGTCUenfgLydxSDI/V6jucpKzblXf2DaM2Hki3EuI/owAd+LBcb7bF67pLxPjfG6mYNH7RWgs8ys7xuyVLk0l3O4VunwRy0p89j5bDu9vllHUd2P5eu5rbUvM8ZtW4O6a3FLFVeIC/QnMZtNqYjfan58v2+uNK68ppINHHUPbVjd9X0Yxtbxylu2+sPjr+ON7wRtewCqKpdw0MPq99TP15bOY+THCAyohUvuRPacor7+mtYCq63jKFw8+lwISGA2jmE29XhKun8Uvs1EoktYRvxzg9UM0LyNTJdVQDsRTqEF2srVhFXvoxcpNVj4nADVuG1sTBrYOeIr0wu6Wpshw5v6/N0z9f9n4SK
x-ms-exchange-antispam-messagedata: KBrztQot3XBuswO6/knYu7UICYK5lpLPCzHZCsitMULsJCOdm6FqnKVWw4d1RL1NYXU73eWP1t5rweYgfusfPLnRyYcmTv57+GEIzFXRv7irpw9kmutRiR00AjvdqxTPh5z0qtJlmbixXKrlyQpvew==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a452bae3-0fbf-48e6-8756-08d7db806f19
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2020 05:48:16.0496 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qcr/vwGTXMAEp56KDeS1abDrCxZQ6snOvo0Dji4fhAF/ragxsgp6tWDmZm0ypbVapwO3X/v0rd03DYhvdV5a/gMdejL4l6ttfbPSrYkxDrA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4928
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200407_224828_541856_A4C909C9 
X-CRM114-Status: GOOD (  10.71  )
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
Cc: "ailiop@suse.com" <ailiop@suse.com>, "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 4/7/20 10:43 PM, Chaitanya Kulkarni wrote:
> On 4/7/20 10:33 PM, Sagi Grimberg wrote:
>> On 4/7/20 9:16 PM, Chaitanya Kulkarni wrote:
>>> The change of size detection on the target should generate the AEN to
>>> the host. Right now there is no mechanism that allows us to add
>>> callbacks for the block and file backend so that we will get the
>>> notification for change of the size for block device and file backend.
>>> This patch adds a simple per namespace thread that checks for the size
>>> change and generates AEN when needed.
>> kthread? per ns?! I really don't think this is the way to go Chaitanya..
> I hacked it up quickly, may be we can use a global kthread which does period
>
> susbsys and ns scan, but AEN needs to be issued to the host either way.
>
BTW I'd like to know what is the downside of the having a global kthread
approach

for subsys and their ns scanning to generate AER when re-validate ?



_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
