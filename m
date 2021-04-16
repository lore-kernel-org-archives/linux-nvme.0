Return-Path: <SRS0=jca5=JN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6556C433B4
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 07:08:50 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13A9A6108E
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 07:08:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13A9A6108E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=gQ/O5nEsM943n6GGPmAwMQcmYXtt6bGIHMQuu9Uk9Xc=; b=KFOOsTzA19fVgXayExXxvTgh6
	0tWZY/TCvjtjnJxwXJ8529ZY/DNTpkL6rwSOxcIbvOGhUAxGTbKiozJIjPDvBYz+dCcczdQYfNMat
	XyWxTVrr+G9ZYVaoNcXprWfreRpE/DxLkdYuAoX0oa74Frz72IDocy02Ya115DDId5lCR4Z7X+WN6
	l/GCUDZNhKDFKpD0JCDoLqcukY3QZsyGOj5sbgmlt3SA6nqz5S7JcEQwOHj64rEvEXy5msHKDIVlM
	ACzM7nHDQHPSIbIJcaVGAYn2m8ZGq59wowEqsjwD+B839/Y6CdVx3CUl8/c//FYWJ4XeR5nKbkAhR
	rmYdGbQNw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lXIaa-0018p1-JY; Fri, 16 Apr 2021 07:08:28 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXILC-0016qJ-91
 for linux-nvme@desiato.infradead.org; Fri, 16 Apr 2021 06:53:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:References:Message-ID:Date:Subject:CC:
 To:From:Sender:Reply-To:Content-ID:Content-Description:In-Reply-To;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=; b=tQz/3kQPF1hoClYAEA5NOmKPcj
 nqDdwhCHdHjzjLGswhJhB5kOtUltRaLFKi2tU1vLdRdWhGmhseXK2ll0Q7qAL/9SFu/Cn1X0ubA8i
 eAqpf8w8OCpHPjbp1BxIskdeC0CArOzuTNKCRFPQC0N3sVbGna8rpmy6uIHpaO6wd/MHr1hN4iV3q
 HC6VteB/h595ShpLijAm/arCqBtezTlKDP/C1CBlObU8FR7BQvBt8JKEmFZuFOwzHk1aJp+WtS9iV
 AgbEj2BG8R/rKHTW0sy/hxXI8POS+/VDLMz/tOF6WBcbiuBWmXRY4woo1yX4KikzsnB9yUW0wCz50
 YMOBQrOQ==;
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXIL9-009887-TJ
 for linux-nvme@lists.infradead.org; Fri, 16 Apr 2021 06:52:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1618555951; x=1650091951;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=LkxdYYse2BLi/LonSFoBhBwPZhQEK0acXcLOnh2iHnGChpCbg9e/pi0g
 GisaBkVCEkW08ppBpJU5Q+ofD2YOznL61iuI/qdIXjwFyZQgMfqQ4HAif
 JY//k64H0v8SbOZtnh/im/YaXVdWsRZtW4hVUL4oTicIeie9Jxa2zmj6y
 /8nD2ANMYl+gwhoYwmuG/upJM8hzh07hfmCpUV1ZY1UQ5BYNaW2d7qZi2
 3KD4xKzPkO/hmK7TjeN0BVYVUZimaImhJ2MV1r+yIAOvEDZuUKh09Nb4Z
 5QRd+BCQQG+9ca8ueaj0bAYNg1H0HgXtUC2mgq/8cT0Zx3ChO9ih8Y8Tp w==;
IronPort-SDR: bgWh6DPrNkqBT3Iyaj/kYXgihbOd8qpHH8eDilIcLRl9l5yJalaP7Uu/Mkki7fWgjYvMz2qDH/
 ZSzun7FPWrc9cqZ+plxWL2P9E89DR65K6tr4n1XZpQRbKHG5tNLuTCwk+RBE5qSt6kRy9DAwai
 mTKw+Hi1Ni+/gebdf6kZjZgjTTqfpcodYPZrL3pRANeSkkBgFa40Kpv+3xqgwC/EpzOHl4/jUi
 bSb2r4ZjnwB/z/EtOvr0ZtoOuEkhAm4zPotHR/mPTX3irlG3YXEAFWuSREXC3x0Q5M1jP9psdr
 gCQ=
X-IronPort-AV: E=Sophos;i="5.82,226,1613404800"; d="scan'208";a="275974625"
Received: from mail-dm6nam12lp2176.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.176])
 by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2021 14:51:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FWu7HyRu4STi5iXdIJe2hN29SGxt4jw5iDKNBc2nA1b+yHdyBLiK95VITBl+RkCheZ8KBH/Q81fvUTc62S9JT930S6h7fi5TxROt+FXFWBqMVoOZ1YR2Ti74AYH55JYDgKH/Il+XvJDpqwBJUiVMG24deFjDbaB9TUnIhSyupEPhQgzi+bQyBHA4vDE5gb5VyJ5g6im+1eAeVV1h6fYP+X1gB2rEuV0WDeB0HIpulr14CbAhr6TQxpBPXluIBuIky1q3QfA+YfueU5SiGrZHMie79e39OFXL+UGON35EO1DUi5tMUKaizoiCs2U0mAmzUgtR+BGFlxsujchLD5LcqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=nMCXx+mMXKjQwUv2XKu+Yxe/vZA1K6OCZOwx52on7+VC+DUo243v5Uf4eZDjuf/6JsOFPc70g2VJIvH3a+5lHbb8U0Z9s4in3x7Yh60a3CjpL+OTsGUYwjMEmSyu/5C1eUDf+1qrU1SUZk4n+YtD6Nk8NuSH+MJyBhLdaLalizlIxURQOKbeG2/HyjBvX2+ynpI7doZ+ZfDb5lP6BL2vOoMHIq1Mxjm3bPD4mb/Lr8eXYrzYf4UXdyX0G1eGd6MJ+q1Zw+EzIrXBXExovFHSPdsdphYw7Pau9jGznpno8eq9RFtP2WpEvmDY78PvM8LsOKdFQYlIzHVyQmDZK1eRRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=LqGbMPBATNYZ4RqFW6D96lVtaiwyheDViT+hWw2l21tn0ZtB8LC37UD2MrlchfeUXKx1QenneiWH7KL7EckoS2ttAXZE8gq+sa4bpBGk7vj1UmPaAPvMwsO9sK/8ZuzIj/ziA+bVvADqFTDRfxJKYcZvA/5k5/xuL21T1FJS1Gw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7334.namprd04.prod.outlook.com (2603:10b6:510:b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Fri, 16 Apr
 2021 06:51:45 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4042.018; Fri, 16 Apr 2021
 06:51:45 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Damien Le Moal <Damien.LeMoal@wdc.com>, "dm-devel@redhat.com"
 <dm-devel@redhat.com>, Mike Snitzer <snitzer@redhat.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Jens Axboe
 <axboe@kernel.dk>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, "Martin K .
 Petersen" <martin.petersen@oracle.com>, "linux-fsdevel@vger.kernel.org"
 <linux-fsdevel@vger.kernel.org>, "linux-btrfs@vger.kernel.org"
 <linux-btrfs@vger.kernel.org>, David Sterba <dsterba@suse.com>, Josef Bacik
 <josef@toxicpanda.com>
CC: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Naohiro Aota
 <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH 1/4] dm: Introduce zone append support control
Thread-Topic: [PATCH 1/4] dm: Introduce zone append support control
Thread-Index: AQHXMm1gL8WU7E5fp06Z3hjUVfsrGg==
Date: Fri, 16 Apr 2021 06:51:45 +0000
Message-ID: <PH0PR04MB741615DD316F6B22E1A4D8929B4C9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210416030528.757513-1-damien.lemoal@wdc.com>
 <20210416030528.757513-2-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:15ab:1:e10b:72a5:d443:5e5c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 56402fca-d0ac-4eec-8aaf-08d900a4198b
x-ms-traffictypediagnostic: PH0PR04MB7334:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7334515AAC714D814DB51B3D9B4C9@PH0PR04MB7334.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nWXKf3vsSAWGMZ0YfJZg3U3AW87jFpLJunl7aiUVltj9piGfyTvGlQT0ZNeozBG74OnrqeIWlZQ4qV5gyUZHyTkWST4nMB/c5DvKX4Odifi9TnGBvGmICGjb7+jXW7uQS9IOUs/VQddNr6SlVxlQcyF9qjzGtzP7jzjV1RK0/eoix+0dZe7NIZwm5iNkTZdwEYxFhucwA/JmxLK+DOXUHTj25JvRG5jUHnhuqKQHE7esshm/aRUOiEbAakFzKm6jVv1XZ5k3I6IMKqLYSKIWPrpMlkC0vQjEmZTJxuPVtpldjxC4guVihtcuvJ5ZDm+z/y3nLcBpsMmU0jBub36gyUAop0LJvX/JQRSSjI52zPZ8vMDsqqjvSiRgy+epkvrzXt2DOz4hcttthaPtCKEPYF+7IlPPqhnqm1fS2fC2dskNC9Zuby0s/lUcWJQv2+ajQ2aJvysZJ5aEHCpRstwBk8q5UV1OC5PNTrOMbaDbjpPlOvLdpewmnyBxpurSAhb69hsp5hsKWKf9KFdvGqK3YFcPSnO3fiF6lOyq2DwDNscTaVnQeHKLUrHF8S/2y38KSdtgoX60wda+oCXKgiaO2yDFkoaTxdQ5AZfexY8rITLq8yOF4Kh7O4KpUSAqDW4ojl9YHEeVKw9KGmXBW2gtuA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR04MB7416.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(396003)(136003)(346002)(39860400002)(316002)(66476007)(66946007)(558084003)(122000001)(19618925003)(76116006)(91956017)(66446008)(8936002)(64756008)(8676002)(921005)(6506007)(110136005)(9686003)(2906002)(71200400001)(4326008)(7696005)(54906003)(86362001)(66556008)(52536014)(478600001)(7416002)(55016002)(4270600006)(186003)(38100700002)(5660300002)(33656002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?pMyEPy4tuVErH5BMrTvk00eAsVBaBA4QX9cJ5F5IJOdyR7qY/em2NeI0cn/O?=
 =?us-ascii?Q?i/zbkajtYoITGM9gzrSHCKnjT5Z40bHATGGhUJ19YxXU10fAtZ7rTT1oVE5s?=
 =?us-ascii?Q?DUclRtGY5kRqfzGQTdBm/0ei5b/vQTdL4ucGV5Jc68uC59BygtdQpBrbVldJ?=
 =?us-ascii?Q?pMPsAzJ0Pl+vS0oYii+f92ASdzcqv1RJMKbwqBRXP68IAwo3T68Cil61uZ0e?=
 =?us-ascii?Q?i8Tiqe1BZcpYJhf740MugGUxRGDRSSZC/ZcuENqM6PdeZbZTc2LW5cul+xOJ?=
 =?us-ascii?Q?Zx+iSxKMDBln+zY7wgDJGZ//4Pqo8A5nKP76Lq+861u3LhIFUZbkRCZd+s9p?=
 =?us-ascii?Q?XAUnlrz5T9VPsNZwkp26wyIIylNp9b+GkkZcSzA1rnZ09S9NVea8nzIjcX49?=
 =?us-ascii?Q?fAHhQ/daMlOYFBSfxjCdQYAbwUIhVopMszLa81y6075/LPCaw+z35Jc5fKCC?=
 =?us-ascii?Q?8oIOLaJr4W/o5zn1HUZutah+6gcmerlK8Et9M+tIKtoCXpG1+2b2SVzZTnZZ?=
 =?us-ascii?Q?WtdB1vE8uk5K6wMDrGH7SdkRBg+js0OtC/CwxLaaumfp2dtAjUmiZgQnES62?=
 =?us-ascii?Q?XsKk/Ta/lZzqIwm+h7AsDXE204Hmq9gW/KPeblojVp/DgHV112tYoGoCEf3s?=
 =?us-ascii?Q?jFhHc7A2yEOpIb1+b7Z817lOSoe31aXmU0YEcNyDbf7LOLU9cX/gypjjxmO2?=
 =?us-ascii?Q?/GsF/ucdIiByWUUm8E3YNxymrU0ol0cixF7okVEefuPYZwWmZFOMaGp0+lkO?=
 =?us-ascii?Q?owgH4bwZmLOjvF9dap8W4hxY/CmKQ1cr8HCWSsZbYEeA65+8UMhSr4xVnROj?=
 =?us-ascii?Q?bV1fqh/IKvFW0iQRqzop2bO1ECAXFWAAzGAng/v9pUvRWdGxD51QS0Oh1qbd?=
 =?us-ascii?Q?4YYhpQHTGL6T7n5jmw0kux8wJvUvSPF5UiPSRUunc+/zUsRy6PHLOxYeUub3?=
 =?us-ascii?Q?2yXt9xxuWyJzhB6bkOOsCs7F2hSi9JoAkWnfIL6/7ELse3CBK3QsA8qnBHH+?=
 =?us-ascii?Q?MISjHSTWe96GpcbyKhqZlkEG0RvFr6CbSaCYuVBLw0XmSZyt1Uw8NzTsLzkj?=
 =?us-ascii?Q?/5HUak4dRFM64TpRUeMUDDBKHXHlKi/kFENSG4LFHcoFH/F50ZVZIIWJjyKL?=
 =?us-ascii?Q?H+xWOMnxWda9QRh5+rDasP7hH1ZJNHWsio4DFio69QIpwHYZ+Ls8CjMTUjiw?=
 =?us-ascii?Q?Rrk/Q5ZITGhcfHx18wNMTyUou3xdjmeKIhIlTWt3XwNogc7aVEsHVbVpJg5h?=
 =?us-ascii?Q?pAPrJPys173465W5m2TIKn06/LhULh5ibMhRKFAVPwQqmwXhF1wGVmYrQnkm?=
 =?us-ascii?Q?h6d2hhU4GJN9L8aPLk+RUYF9qh39qHTfupMp5bQgbH7O5zhbwKcednDEm5bs?=
 =?us-ascii?Q?p17umDkpJNdV+1N+bz0ETdrg1I83?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56402fca-d0ac-4eec-8aaf-08d900a4198b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2021 06:51:45.0776 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yvmZnU6qTLkVYUsaKzL4kF8NkKKABmGOBtPKyt8Cz8HoIyelKYXWQf0JgzwrGr4/vIyWeqGN48tXo2LYUY8EyjjFSaeT5bhk6e3JGEYKPK4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7334
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210415_235232_004375_68E55CE8 
X-CRM114-Status: UNSURE (   8.13  )
X-CRM114-Notice: Please train this message.
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

Looks good,
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
