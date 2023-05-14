Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A27E9C7EE22
	for <linux-nvme@archiver.kernel.org>; Sun, 14 May 2023 10:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=spVip+6JzXtLJPfO+osDk8cEOQVAwFwGi/9lokwIeZM=; b=0HYT9CVbM8xxE6IfuSya2p7v3L
	pFf0zyf//gdBjR8MG8gDLf+dDOWgNUouB/DdedbV9so8QqyIptDar1BkZR/kTouNUNlty07UFBBQ3
	kVD7h9Wso6JNeBYgvlpxZeyFnuDuaRGv7iw/GTjsIakL+QpmpFTzxC5TjIr83M/4n9XDvXmuabDGh
	d/J7inZVtTvTSoEOsYPZHsDicoXH1Jj6u6C0Y1iX3frDqcrxGvfppAKmx5gfHpjT8It6YLItb518A
	TZyo78M+DXTW+n75aF8998okiLwvWN7J9q4s1xS1AyoLL0Ffq0puAVRZ49LRGcy6LmgbX8vjay7G5
	PqVr36LQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1py97U-00GwB4-2c;
	Sun, 14 May 2023 10:38:28 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1py97O-00GwAZ-08
	for linux-nvme@lists.infradead.org;
	Sun, 14 May 2023 10:38:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1684060701; x=1715596701;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=TwUCWBPqSacdH9XDVDrG7oaqZr2sI+504gfefv51vms=;
  b=LxT9KsNqfBYniwsviojcy4bjK9srLN67XDpIcp8fyfXbee6ZxuNBEAhw
   oSuuXkaqV0MKjWrySurJSdTwojeQnESS5xPJFozK4QStYOmqfZu269k2J
   Hhz0ZaYVneWTpRuFoEQQdGgNpOSv3AVQFctZWX8Y2A6bFh6XU0b2sxfHj
   k5QN7U2ROVsKSn1z1gCTRiFYUkpU0tB9FqWh4X7rafO+0f5n+h+fD/bwP
   bJjULFUFYTEyUObP7GDUjIG43rMsVepfV0XZ20+/R2dKZDOe92dPXqpt6
   DKNqzplXXyCXFIe3YIcEqW49a+QB/xyuN6Ip4l7Hm9zH3nmo9EXvyJjgj
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,274,1677513600"; 
   d="scan'208";a="235694227"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 14 May 2023 18:38:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H9/VcBYxr/WX7hDCAw78qNlfLOlFZw7BtEcdR6RWqFXn870R5p+9CiYJ5lwMEBN+o8mb+pW4QcWeaAYG5tgLv20OuA5bmyvcoNs07PSHKlz1ma3sML4f4NDM8yU6OFEWifTysjuXqErt2kpUD/RYa3IVfOctKjMFBe0fJiXrReTeztO4G1G1hrtiek7WvlGh/mcGFstVyC47fLAY2bKXX0N31vq3daNkxOm0RV8+xa2+kLVX5yAd1tYzrOux6AsVXcyEtA0I9NXIxElt9jKQwwB75y89bo85bxbISICgQuZ38xd8SEMi2XmaJIpDojzllbWdOP1QyXquAg9NQk7xZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=spVip+6JzXtLJPfO+osDk8cEOQVAwFwGi/9lokwIeZM=;
 b=EIihobZSekMDnSHC6ekgfb/VdYZFBVkK30rDsUqwEz7e7vdq1suc75nVQO58RCJFE5fDzRUZDXdzlpQSGxUjoBD2P9wIqEBX+qrs8hAUpV1gIabtM1irEefIjBgpRaVf+L/Ej+st1ORbK7IrodUxBV8V8boDswYY+aBYRx+m+WY+XjnWSDJtedHZujYcPTQG2KNSfaWQKuvUt79x976ERvfGLX5cpRL9Jst7PpwMgweNmKA8JYUPt7MVbmrgwownGXvs+rVg7pF9ZQvsiIX3W3046SaY5NHrOGlzOPlLjPpeAitzMXnSw7RdxO//R8euQQjRD3YwmfJGZRDDzIufhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=spVip+6JzXtLJPfO+osDk8cEOQVAwFwGi/9lokwIeZM=;
 b=oAsAkcaKxukm9sR4lSLE5vjisQ6n6o+uCUUKDZy74Nx91XlkwA4X/tPy49+SLA3nyPgeTUWvSRbwybDeMS4gsJ1UdJwGrFZoZuVNF3QUjA9Z+d+XKRKVGhbp9xzucE8O2ThPB1gzvX7X4aqspl3Z5ygJIxpQqOBj/3ABZs/blFg=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 MN2PR04MB7006.namprd04.prod.outlook.com (2603:10b6:208:1ef::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.29; Sun, 14 May
 2023 10:38:10 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb%6]) with mapi id 15.20.6387.029; Sun, 14 May 2023
 10:38:10 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>
CC: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Sagi
 Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvmet-rdma: Release connections synchronously
Thread-Topic: [PATCH] nvmet-rdma: Release connections synchronously
Thread-Index: AQHZhBnCeNlU7DOQmkm417qcayOZmK9ZmCOA
Date: Sun, 14 May 2023 10:38:09 +0000
Message-ID: <c7pbds22dwwpeozqqf3p5oqvyrkmo6nwhgtz67o6l2snll4mul@sb2el6jyif6w>
References: <20230511150321.103172-1-bvanassche@acm.org>
In-Reply-To: <20230511150321.103172-1-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|MN2PR04MB7006:EE_
x-ms-office365-filtering-correlation-id: 8efe0f6c-5ca6-4072-967b-08db54674fd2
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  6b1UY7DHBE33LQ45cHOByo8eiqSyYbPZnIwbLn4VcWHIPcdPnnkdhL9wuXu7Ur9SFPw0o9Jt7A8gyMZjJc0LBjYKe33eAKd8frgT7DdQdVQmYD0SS4+D7zKPAZBK0e/TVtXG4nJQvSXDcDLEBPSj8kt/LZuc5wLNRCblnySQ6BfZ3IOGWJuIz0NrfaCqIlSYKb0VJWN2JrsfQmFtiMGNN0fpI5m9EDmuj6Wb6xzdykg/WodcaFMb8z4ihWX3hZTzgxiH0TZW4wXS0U1Fb3+onnyso9yyakvCuwOHZyrZ+NH26BkqjazcO3kxvD0pyqpHxydGYpg4r7EWCi6di+8kig/+8tmoVx45CcwS1FZgnkiJ8ZH+XCnVR7Psg3W3Wg+RLbl0peu/83nt2wrK1h5h3+a3cER03j+5Urp3spXOUnwMaY89ZS7QT6/+rh2N67xYgt9oSMs5Ch7rUDSsC5HCfILVyft9bFScLLJ8pFw0kMlIIuJpRan0FXbxgvEg4r9yvGvARa6a5JG6ewVvYCXsN7DPrxMqYO5oOIqhO6qF8mqhAC5VN0KwIAEEah3pVhCYesPjT9DXN9iJFo/hC6BNmoqhgnsQtQWtfzHMo5BiCwH/Gu5AGd2M6HcqiqQPmk6T
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(136003)(39860400002)(366004)(376002)(396003)(346002)(451199021)(71200400001)(82960400001)(122000001)(38100700002)(186003)(26005)(9686003)(83380400001)(2906002)(30864003)(6506007)(6512007)(5660300002)(41300700001)(44832011)(8676002)(8936002)(6486002)(478600001)(38070700005)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(54906003)(91956017)(316002)(4326008)(6916009)(86362001)(33716001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?yR27Je9PaFsn+H+HJ/NYM0zclMz/32J0TKQ4yauruCnA+T0SlwhgsGbSkz7x?=
 =?us-ascii?Q?yZCpObZScDhITxbXrahuvAkmX82kFAV9/FZlEbZFpKk3HVitlZyEnpIN6wbd?=
 =?us-ascii?Q?L3x35nV1nXaJZ2Xr9F66wyZnoXHTMO4WIgEEWTrDPkuw53aRjXHQ6Itl9OOh?=
 =?us-ascii?Q?v3sy25PK+7WIGxv9pzuIAUODYPl4pGgGmY9VesGWxtymKGljyqYvfJSVeFoD?=
 =?us-ascii?Q?DoaIOeLh9D8bvcVFg27cwnJjl+/j+UOzv3OpfconAloTHna7v8kbW7TdoMfk?=
 =?us-ascii?Q?1yo1RRxH9nsSmbRpUAffJUe+DZyQkmqHMj/qjAdnXhcVt/h+upwlDlNHQGwX?=
 =?us-ascii?Q?vRYMuvEnP/KQtu0s2i7j7IZKOqxbeY2sVICO0lJZIYBSq8J4g4xbnzJep4xU?=
 =?us-ascii?Q?l51sjWQ5Gl4YQrzmQkjxp6NtrBWStiZYcsOjuyQyFbO3V6buYZxgaBeNI5Gf?=
 =?us-ascii?Q?xtkEJoCTSOPc0x6aGeDBao9kuo7WYB0Oon0TxrXDjBeKKYVGbSxqAN/Y1zcA?=
 =?us-ascii?Q?/W7R7qnnxH1T1F9xnNgEQXcVyRiQTDTxyMSZC30cVXrdnnxsdW1tHIoqsf7z?=
 =?us-ascii?Q?KkiwW+qUUjHgDmA/kitu6GFH3QCNcobGl91zyKk1vNuwtcrwikZQEhGCzy+T?=
 =?us-ascii?Q?9xy81D+0zsIPIwnijCAFIjHfj5taoR/Rr8b7AS+zD9q+3bOCJle06swXRtXX?=
 =?us-ascii?Q?xHFfbkbSOX/CZ4aYzlwAGiPdZJa2HrrP196xFhNruUGTxbWb9T2kC7lT+Awp?=
 =?us-ascii?Q?xFNmPMRX6T6mq9Ry3cyAlCfo5oYG0pP40xEc84A2WxYVV4g4RNDWpf2NyLXZ?=
 =?us-ascii?Q?1HY7SmWiKFdEVE+EO+njlFVk8BxNNrZFagYKfC8HruhVUF2xp2R3mmIR1NCx?=
 =?us-ascii?Q?qH+5Mgf7LLE8gpbBkeGMT732SG9fzB1W/M/Ty0kdZTjaTLGZoPM59WlHqkhT?=
 =?us-ascii?Q?Psc4qF7uf/tKth3EE9XVWLFG33PipkeeIahv5YkiMJ9qNQu5jUwYZO4Sm1Po?=
 =?us-ascii?Q?kx0Cna0wtZ1/gxy5k87QCc4S86RvJzQKvgUovt9+lLfmZrAaD4ixx8Pt1mR0?=
 =?us-ascii?Q?mGGQ7jHlYMDKECgPMrsNzVMIiHxPj4mxWKOXhE0kb17vf6tZJyKRbhpWprCc?=
 =?us-ascii?Q?eajieeSX88rqpXhKIKYwgAivs/4oRHApK4dlHpC2JNhTu1fYNF4IXSX/QB6M?=
 =?us-ascii?Q?7p0NZuucRiQ8ajiIgit3XWmj3An47hl9CnvVDzEJkaRQPfRDkqerXxRvaLng?=
 =?us-ascii?Q?iFj9Ty4S4ebKKFOAdyZCI+zaI2XiQ3UWwKentpCM6yTyJlTwOUaBJTvoQ4yM?=
 =?us-ascii?Q?8X9DzPj/4uJpTC8J9zNzynvKs1t87Kh+ekx6RCrBowiy0lfdP4CA2EMSpuIQ?=
 =?us-ascii?Q?R+n+27B+mj02VEMNDEhnnPM4UHWnx/rxPU/yitVQFoy/PPZhvg4aKu4HT78H?=
 =?us-ascii?Q?s96pR3B/Xs9u+KHQZLyzPmsUX/fnrklow2k6PWCxaoxdb3bHrJcckCrzveSN?=
 =?us-ascii?Q?esgpPOMgG4FzM+RigmMc57LxL2vvlfWdSZbs4mZYs6BDU3VQHhSKNbAI3+tD?=
 =?us-ascii?Q?Quje52YPySAngpkYCiAAusJE/eVVjlxIEllQB6Zg/oYmKcKzh7hyopy4ZuYC?=
 =?us-ascii?Q?b4uL7l5uNsY/SxYK6KmC3gE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <112F23832A2BA74B95ED90269F681F76@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	/3G/MifbUAYHMKS0YwfozWdb4O0EDu6F2ihjLOCPReFRTVUqPuxgOhTJLIUSKPJpW/WI3wzRbqaz+YK3PCkbBGiRUmd63eGYFeUCJaozwCRa1VLrhE8qDy/9b3ujs51FTn3vEAyLjLzg3spILPZiDxLr5++nD6QnpunGSgiWpXf6iiw+2OzVWtMA4XaFKBj582f7KOoWT/X+8vbAKahByK48LCwno+Ng5zL06jD7KA6GA3lUZmNOly0elAX6ulzxIgc1/RQ9kDWX8jbVQB51oES+abiybmijt3gNK6gB62AGrHoQ4NijoWKSyiKT46DCLO7a9gHdbqIPROWVOV+tU+XvMylyYqi9DdWuQMA3rAMD17qxVI5er5BLUn3VAYKDEiA1m0+sgkmoGJ6NQ7UF8AMa5sJjMqtPv1b1hcMXfCQ8M8S3ynNR8eRto1fKZhcaYYPVUoVFHRn5vvYkCopto09F0QvEkGop6BQO0PmtMxLrCGBdcRQcPo+0EZJj1bgFtuS8Du78uCyI8hCyX4b7FlXEVRxicn/ela9uiHcrbRZjKXEfOeoZiO0XXf5RCGNU2rG7OP4Ia1oO+xoz5oLFRo8IVLBUeZlRI2eq3kbHvMCZIO0tsSm3xb3oqroTJI2ubZ2NsoNjuRv2MBHCI/AU20EAYVTf2Mx3ckez9cbzBmd8MLsEAhMnLmI/ctAP80Z6UNMVs+KNCeS8Ye1jL5wk7k+J+PF6/8R0/aNlIDkgCCz5iOAJDeDoYbNWRi34ggsQ8N0ilUsIGHcfwewixUomHinuVwyiFhTVzytBI3kMKo771uKHG137sx4HjDQdmNaSatQx9KARpoR3VYH2tPH9cbdRq6HkP3/Wi6qgNNvTb+CvA8e3MybefBIJkfdL5qaIGUGSalCtkd1RgINWwGMsWKg4NPwSaJoj5KiU49R2Vm8=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8efe0f6c-5ca6-4072-967b-08db54674fd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2023 10:38:10.0520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: loTlO6x7fkVKSHlNTBOl/CrFj4r9Su3s39fkHgVTycgIiSfbdf+aoWqVKeEUnWcNmVU3I3bc4LSE9kNR4ndyEr5iH1GucYLlzmXVJUwP/84=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB7006
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230514_033822_195740_B240D450 
X-CRM114-Status: GOOD (  22.16  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On May 11, 2023 / 08:03, Bart Van Assche wrote:
> Lockdep complains about flushing queue->release_work in the NVMe RDMA tar=
get
> driver because all instances of queue->release_work have the same lock cl=
ass
> key. Assigning a different lock class key to each release_work instance i=
s
> difficult because dynamically registered lock class keys must be unregist=
ered
> and the last use of the work_struct lock class key happens after the work
> callback has returned. Hence rework the code for releasing connections as
> follows:
> * Add an argument to __nvmet_rdma_queue_disconnect() and also to
>   nvmet_rdma_queue_disconnect() that indicates whether or not these funct=
ions
>   are called from inside a CM handler callback.
> * Do not call rdma_destroy_id() if called from inside a CM handler callba=
ck.
> * Let these functions return a negative value if the caller should free t=
he
>   CM ID.
> * Let the CM handler return a negative value if its caller should free th=
e
>   CM ID.
> * Remove queue->release_work since releasing connections now happens
>   synchronously.
>=20
> This patch suppresses the following lockdep complaint:

Bart, thanks for the v2 patch. I applied to kernel v6.3 and ran blktests nv=
me
test group with siw transport. Unfortunately, I observed test process hang =
at
nvme/003 [1]. The kernel reported lockdep WARN of id_priv->handler_mutex. T=
he
patch adds the "from_cm_handler" argument to __nvmet_rdma_queue_disconnect(=
) to
skip rdma_destroy_id() if the call is from CM handler. However,
rdma_destroy_id() is still called in the call path below:

__nvmet_rdma_queue_disconnect()
  nvmet_rdma_free_queue()
    nvmet_rdma_destroy_queue_ib()
      rdma_destroy_id()

So I think, the from_cm_handler should be added to nvmet_rdma_free_queue() =
and
nvmet_rdma_destroy_queue_ib() also, so that from_cm_handler is propagated a=
nd
rdma_destroy_id() is not called in nvmet_rdma_destroy_queue_ib(). I created=
 a
quick patch with this approach [2], and observed it avoids the process hang=
.

However, when I did further test using the v2 patch and the fix [1], I obse=
rved
another process hang at nvme/009 [3]. This time, deadlock of subsys->lock
happened in nvmet_ctrl_free(). I created a dirty patch to avoid it [4], but=
 it
caused lockdep WARN for possible deadlock between subsys->lock and
id_priv->handler_mutex. I also observed hang at nvme/044 related
nvmet_fatal_error_handler.

It looks that the removal of queue->release_work looks triggering some more
lock related issues. Do you think this approach is the only way to address =
the
original issue? If so, it will need multiple follow-up fixes, I think.


[1]

[   44.824261] run blktests nvme/003 at 2023-05-14 16:32:23
[   44.925161] SoftiWARP attached
[   45.013065] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[   45.022749] iwpm_register_pid: Unable to send a nlmsg (client =3D 2)
[   45.025434] nvmet_rdma: enabling port 0 (10.0.2.15:4420)
[   45.072814] nvmet: creating discovery controller 1 for subsystem nqn.201=
4-08.org.nvmexpress.discovery for NQN nqn.2014-08.org.nvmexpress:uuid:00000=
000-0000-0000-0000-000000000000.
[   45.078662] nvme nvme1: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discov=
ery", addr 10.0.2.15:4420
[   55.141297] nvme nvme1: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.d=
iscovery"

[   55.172082] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   55.172563] WARNING: possible recursive locking detected
[   55.173018] 6.3.0+ #5 Tainted: G            E    =20
[   55.173426] --------------------------------------------
[   55.173876] kworker/u8:4/88 is trying to acquire lock:
[   55.174312] ffff88811ecd2420 (&id_priv->handler_mutex){+.+.}-{3:3}, at: =
rdma_destroy_id+0x17/0x20 [rdma_cm]
[   55.175099]=20
               but task is already holding lock:
[   55.175667] ffff88811ecd2420 (&id_priv->handler_mutex){+.+.}-{3:3}, at: =
cma_iw_handler+0xac/0x500 [rdma_cm]
[   55.176445]=20
               other info that might help us debug this:
[   55.177027]  Possible unsafe locking scenario:

[   55.177567]        CPU0
[   55.177873]        ----
[   55.178113]   lock(&id_priv->handler_mutex);
[   55.178488]   lock(&id_priv->handler_mutex);
[   55.178864]=20
                *** DEADLOCK ***

[   55.179482]  May be due to missing lock nesting notation

[   55.180102] 3 locks held by kworker/u8:4/88:
[   55.180516]  #0: ffff888129888138 ((wq_completion)iw_cm_wq){+.+.}-{0:0},=
 at: process_one_work+0x706/0x1390
[   55.181318]  #1: ffff88811cadfdb0 ((work_completion)(&work->work)#2){+.+=
.}-{0:0}, at: process_one_work+0x733/0x1390
[   55.182152]  #2: ffff88811ecd2420 (&id_priv->handler_mutex){+.+.}-{3:3},=
 at: cma_iw_handler+0xac/0x500 [rdma_cm]
[   55.183007]=20
               stack backtrace:
[   55.183458] CPU: 1 PID: 88 Comm: kworker/u8:4 Tainted: G            E   =
   6.3.0+ #5
[   55.184099] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.16.2-1.fc38 04/01/2014
[   55.185570] Workqueue: iw_cm_wq cm_work_handler [iw_cm]
[   55.186823] Call Trace:
[   55.187832]  <TASK>
[   55.188813]  dump_stack_lvl+0x57/0x90
[   55.189866]  __lock_acquire+0x12f5/0x5eb0
[   55.190934]  ? __pfx___lock_acquire+0x10/0x10
[   55.192038]  ? static_obj+0x89/0xc0
[   55.193062]  ? lockdep_init_map_type+0x169/0x7c0
[   55.194175]  lock_acquire+0x1a7/0x4e0
[   55.195262]  ? rdma_destroy_id+0x17/0x20 [rdma_cm]
[   55.196394]  ? __pfx_lock_acquire+0x10/0x10
[   55.197470]  ? lock_is_held_type+0xce/0x120
[   55.198541]  ? __pfx_ib_drain_qp_done+0x10/0x10 [ib_core]
[   55.199755]  ? __pfx___might_resched+0x10/0x10
[   55.200846]  __mutex_lock+0x185/0x18b0
[   55.201857]  ? rdma_destroy_id+0x17/0x20 [rdma_cm]
[   55.202922]  ? rdma_destroy_id+0x17/0x20 [rdma_cm]
[   55.203996]  ? __pfx___mutex_lock+0x10/0x10
[   55.204980]  ? rcu_is_watching+0x11/0xb0
[   55.205936]  ? rdma_destroy_id+0x17/0x20 [rdma_cm]
[   55.206988]  rdma_destroy_id+0x17/0x20 [rdma_cm]
[   55.207994]  nvmet_rdma_free_queue+0x7a/0x380 [nvmet_rdma]
[   55.209093]  __nvmet_rdma_queue_disconnect+0x3c0/0x7b0 [nvmet_rdma]
[   55.210215]  nvmet_rdma_cm_handler+0x765/0x3a10 [nvmet_rdma]
[   55.211304]  ? mark_lock+0x101/0x16d0
[   55.212201]  ? __pfx___might_resched+0x10/0x10
[   55.213109]  ? rcu_is_watching+0x11/0xb0
[   55.214040]  ? __pfx_nvmet_rdma_cm_handler+0x10/0x10 [nvmet_rdma]
[   55.215117]  ? cma_iw_handler+0xac/0x500 [rdma_cm]
[   55.216098]  ? __pfx___mutex_lock+0x10/0x10
[   55.216999]  ? mark_lock+0x101/0x16d0
[   55.217923]  ? __pfx_mark_lock+0x10/0x10
[   55.218837]  cma_cm_event_handler+0xb2/0x2f0 [rdma_cm]
[   55.219850]  cma_iw_handler+0x344/0x500 [rdma_cm]
[   55.220841]  ? __pfx_cma_iw_handler+0x10/0x10 [rdma_cm]
[   55.221874]  ? _raw_spin_unlock_irqrestore+0x4c/0x60
[   55.222889]  cm_work_handler+0xb57/0x1c50 [iw_cm]
[   55.223881]  ? __pfx_cm_work_handler+0x10/0x10 [iw_cm]
[   55.224916]  ? lock_release+0x378/0x650
[   55.225869]  ? __schedule+0x10c8/0x5c80
[   55.226816]  process_one_work+0x7e4/0x1390
[   55.227747]  ? __pfx_lock_acquire+0x10/0x10
[   55.228714]  ? __pfx_process_one_work+0x10/0x10
[   55.229689]  ? __pfx_do_raw_spin_lock+0x10/0x10
[   55.230614]  worker_thread+0xf7/0x12b0
[   55.231476]  ? __kthread_parkme+0xc1/0x1f0
[   55.232378]  ? __pfx_worker_thread+0x10/0x10
[   55.233261]  kthread+0x29e/0x340
[   55.234071]  ? __pfx_kthread+0x10/0x10
[   55.234938]  ret_from_fork+0x2c/0x50
[   55.235772]  </TASK>


[2]

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index cfd9d4368248..7d909a88d856 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1333,23 +1333,25 @@ static int nvmet_rdma_create_queue_ib(struct nvmet_=
rdma_queue *queue)
 	goto out;
 }
=20
-static void nvmet_rdma_destroy_queue_ib(struct nvmet_rdma_queue *queue)
+static void nvmet_rdma_destroy_queue_ib(struct nvmet_rdma_queue *queue,
+	bool from_cm_handler)
 {
 	ib_drain_qp(queue->qp);
-	if (queue->cm_id)
+	if (!from_cm_handler && queue->cm_id)
 		rdma_destroy_id(queue->cm_id);
 	ib_destroy_qp(queue->qp);
 	ib_cq_pool_put(queue->cq, queue->recv_queue_size + 2 *
 		       queue->send_queue_size + 1);
 }
=20
-static void nvmet_rdma_free_queue(struct nvmet_rdma_queue *queue)
+static void nvmet_rdma_free_queue(struct nvmet_rdma_queue *queue,
+				  bool from_cm_handler)
 {
 	pr_debug("freeing queue %d\n", queue->idx);
=20
 	nvmet_sq_destroy(&queue->nvme_sq);
=20
-	nvmet_rdma_destroy_queue_ib(queue);
+	nvmet_rdma_destroy_queue_ib(queue, from_cm_handler);
 	if (!queue->nsrq) {
 		nvmet_rdma_free_cmds(queue->dev, queue->cmds,
 				queue->recv_queue_size,
@@ -1583,7 +1585,7 @@ static int nvmet_rdma_queue_connect(struct rdma_cm_id=
 *cm_id,
 	return 0;
=20
 free_queue:
-	nvmet_rdma_free_queue(queue);
+	nvmet_rdma_free_queue(queue, true);
 put_device:
 	kref_put(&ndev->ref, nvmet_rdma_free_dev);
=20
@@ -1659,9 +1661,7 @@ static int __nvmet_rdma_queue_disconnect(struct nvmet=
_rdma_queue *queue,
 		rdma_disconnect(queue->cm_id);
 		if (from_cm_handler)
 			ret =3D -ENODEV;
-		else
-			rdma_destroy_id(queue->cm_id);
-		nvmet_rdma_free_queue(queue);
+		nvmet_rdma_free_queue(queue, from_cm_handler);
 		kref_put(&dev->ref, nvmet_rdma_free_dev);
 	}
=20
@@ -1700,7 +1700,7 @@ static void nvmet_rdma_queue_connect_fail(struct rdma=
_cm_id *cm_id,
=20
 	pr_err("failed to connect queue %d\n", queue->idx);
=20
-	nvmet_rdma_free_queue(queue);
+	nvmet_rdma_free_queue(queue, true);
 	kref_put(&dev->ref, nvmet_rdma_free_dev);
 }
=20


[3]

[   83.653727] run blktests nvme/009 at 2023-05-14 16:23:38
[   83.745101] SoftiWARP attached
[   83.818301] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[   83.839954] nvmet_rdma: enabling port 0 (10.0.2.15:4420)
[   83.878445] nvmet: creating nvm controller 1 for subsystem blktests-subs=
ystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:00000000-0000-0000-0000-000=
000000000.
[   83.885342] nvme nvme1: Please enable CONFIG_NVME_MULTIPATH for full sup=
port of multi-port devices.
[   83.888614] nvme nvme1: creating 4 I/O queues.
[   83.922458] nvme nvme1: mapped 4/0/0 default/read/poll queues.
[   83.927734] nvme nvme1: new ctrl: NQN "blktests-subsystem-1", addr 10.0.=
2.15:4420
[   85.333528] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"

[   85.429371] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   85.430868] WARNING: possible recursive locking detected
[   85.432353] 6.3.0+ #5 Tainted: G            E    =20
[   85.433785] --------------------------------------------
[   85.435283] rm/1789 is trying to acquire lock:
[   85.436688] ffff8881215cb870 (&subsys->lock#2){+.+.}-{3:3}, at: nvmet_ct=
rl_free+0xb4/0x800 [nvmet]
[   85.438606]=20
               but task is already holding lock:
[   85.441070] ffff8881215cb870 (&subsys->lock#2){+.+.}-{3:3}, at: nvmet_po=
rt_del_ctrls+0x2a/0x130 [nvmet]
[   85.443037]=20
               other info that might help us debug this:
[   85.445618]  Possible unsafe locking scenario:

[   85.448068]        CPU0
[   85.449320]        ----
[   85.450545]   lock(&subsys->lock#2);
[   85.451891]   lock(&subsys->lock#2);
[   85.453211]=20
                *** DEADLOCK ***

[   85.456225]  May be due to missing lock nesting notation

[   85.458498] 5 locks held by rm/1789:
[   85.459675]  #0: ffff8881218b0460 (sb_writers#15){.+.+}-{0:0}, at: do_un=
linkat+0x182/0x590
[   85.461326]  #1: ffff8881089ac2b8 (&default_group_class[depth - 1]#4/1){=
+.+.}-{3:3}, at: do_unlinkat+0x202/0x590
[   85.463099]  #2: ffff88810913d1d0 (&sb->s_type->i_mutex_key#22){++++}-{3=
:3}, at: vfs_unlink+0xb7/0x810
[   85.464829]  #3: ffffffffc166fb90 (nvmet_config_sem){++++}-{3:3}, at: nv=
met_port_subsys_drop_link+0x4c/0x2e0 [nvmet]
[   85.466702]  #4: ffff8881215cb870 (&subsys->lock#2){+.+.}-{3:3}, at: nvm=
et_port_del_ctrls+0x2a/0x130 [nvmet]
[   85.468507]=20
               stack backtrace:
[   85.470497] CPU: 1 PID: 1789 Comm: rm Tainted: G            E      6.3.0=
+ #5
[   85.471962] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.16.2-1.fc38 04/01/2014
[   85.473666] Call Trace:
[   85.474722]  <TASK>
[   85.475753]  dump_stack_lvl+0x57/0x90
[   85.476912]  __lock_acquire+0x12f5/0x5eb0
[   85.478095]  ? __pfx_lock_release+0x10/0x10
[   85.479333]  ? __pfx___lock_acquire+0x10/0x10
[   85.480549]  ? mark_held_locks+0x96/0xe0
[   85.481722]  lock_acquire+0x1a7/0x4e0
[   85.482855]  ? nvmet_ctrl_free+0xb4/0x800 [nvmet]
[   85.484097]  ? __pfx_lock_acquire+0x10/0x10
[   85.485290]  ? lock_is_held_type+0xce/0x120
[   85.486421]  ? kasan_set_track+0x21/0x30
[   85.487507]  ? kasan_save_free_info+0x2a/0x50
[   85.488599]  ? __pfx___might_resched+0x10/0x10
[   85.489727]  ? nvmet_sq_destroy+0xbd/0x3f0 [nvmet]
[   85.490876]  ? nvmet_rdma_free_queue+0x30/0x390 [nvmet_rdma]
[   85.492123]  ? __nvmet_rdma_queue_disconnect+0x3cd/0x780 [nvmet_rdma]
[   85.493471]  __mutex_lock+0x185/0x18b0
[   85.494536]  ? nvmet_ctrl_free+0xb4/0x800 [nvmet]
[   85.495680]  ? nvmet_ctrl_free+0xb4/0x800 [nvmet]
[   85.496774]  ? __pfx_mark_lock+0x10/0x10
[   85.497794]  ? __pfx___mutex_lock+0x10/0x10
[   85.498892]  ? __pfx_timer_delete+0x10/0x10
[   85.499955]  ? nvmet_ctrl_free+0xb4/0x800 [nvmet]
[   85.501058]  nvmet_ctrl_free+0xb4/0x800 [nvmet]
[   85.502144]  ? __cancel_work+0x13d/0x220
[   85.503184]  ? lockdep_hardirqs_on+0x7d/0x100
[   85.504248]  ? __pfx_nvmet_ctrl_free+0x10/0x10 [nvmet]
[   85.505385]  ? __pfx___cancel_work+0x10/0x10
[   85.506418]  ? nvmet_sq_destroy+0xbd/0x3f0 [nvmet]
[   85.507510]  ? rcu_is_watching+0x11/0xb0
[   85.508499]  nvmet_sq_destroy+0x238/0x3f0 [nvmet]
[   85.509598]  nvmet_rdma_free_queue+0x30/0x390 [nvmet_rdma]
[   85.510753]  __nvmet_rdma_queue_disconnect+0x3cd/0x780 [nvmet_rdma]
[   85.512023]  nvmet_rdma_delete_ctrl+0x1a0/0x250 [nvmet_rdma]
[   85.513266]  nvmet_port_del_ctrls+0xe8/0x130 [nvmet]
[   85.514422]  nvmet_port_subsys_drop_link+0x1be/0x2e0 [nvmet]
[   85.515657]  ? __pfx_nvmet_port_subsys_drop_link+0x10/0x10 [nvmet]
[   85.516935]  configfs_unlink+0x382/0x7a0
[   85.518006]  vfs_unlink+0x29e/0x810
[   85.519019]  do_unlinkat+0x30c/0x590
[   85.520014]  ? __pfx_do_unlinkat+0x10/0x10
[   85.521072]  ? strncpy_from_user+0x66/0x2b0
[   85.522119]  ? getname_flags.part.0+0x8d/0x430
[   85.523184]  __x64_sys_unlinkat+0x92/0xe0
[   85.524200]  do_syscall_64+0x5c/0x90
[   85.525105]  ? asm_exc_page_fault+0x22/0x30
[   85.526099]  ? lockdep_hardirqs_on+0x7d/0x100
[   85.527084]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[   85.528157] RIP: 0033:0x7ffb731f9adb
[   85.529079] Code: 73 01 c3 48 8b 0d 55 63 0d 00 f7 d8 64 89 01 48 83 c8 =
ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 07 01 00 00 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 25 63 0d 00 f7 d8 64 89 01 48
[   85.531986] RSP: 002b:00007ffdf5cca688 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000107
[   85.533397] RAX: ffffffffffffffda RBX: 0000561b08d0d810 RCX: 00007ffb731=
f9adb
[   85.534706] RDX: 0000000000000000 RSI: 0000561b08d0c5f0 RDI: 00000000fff=
fff9c
[   85.536022] RBP: 0000561b08d0c560 R08: 0000000000000003 R09: 00000000000=
00000
[   85.537384] R10: 0000000000000100 R11: 0000000000000246 R12: 00000000000=
00000
[   85.538740] R13: 00007ffdf5cca7a0 R14: 0000000000000000 R15: 00007ffdf5c=
ca7a0
[   85.540079]  </TASK>
[   94.320147] nvmet: ctrl 1 keep-alive timer (5 seconds) expired!
[   94.326018] nvmet: ctrl 1 fatal error occurred!


[4]

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 3935165048e7..4589412c28c8 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -306,13 +306,15 @@ EXPORT_SYMBOL_GPL(nvmet_unregister_transport);
=20
 void nvmet_port_del_ctrls(struct nvmet_port *port, struct nvmet_subsys *su=
bsys)
 {
-	struct nvmet_ctrl *ctrl;
+	struct nvmet_ctrl *ctrl, *tmp;
=20
 	mutex_lock(&subsys->lock);
-	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
+	subsys->ctrls_owner =3D current;
+	list_for_each_entry_safe(ctrl, tmp, &subsys->ctrls, subsys_entry) {
 		if (ctrl->port =3D=3D port)
 			ctrl->ops->delete_ctrl(ctrl);
 	}
+	subsys->ctrls_owner =3D NULL;
 	mutex_unlock(&subsys->lock);
 }
=20
@@ -1476,11 +1478,18 @@ static void nvmet_ctrl_free(struct kref *ref)
 {
 	struct nvmet_ctrl *ctrl =3D container_of(ref, struct nvmet_ctrl, ref);
 	struct nvmet_subsys *subsys =3D ctrl->subsys;
+	bool recursive_lock =3D false;
=20
-	mutex_lock(&subsys->lock);
+	if (!mutex_trylock(&subsys->lock)) {
+		if (subsys->ctrls_owner =3D=3D current)
+			recursive_lock =3D true;
+		else
+			mutex_lock(&subsys->lock);
+	}
 	nvmet_release_p2p_ns_map(ctrl);
 	list_del(&ctrl->subsys_entry);
-	mutex_unlock(&subsys->lock);
+	if (!recursive_lock)
+		mutex_unlock(&subsys->lock);
=20
 	nvmet_stop_keep_alive_timer(ctrl);
=20
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 89bedfcd974c..03569c712ae1 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -246,6 +246,7 @@ struct nvmet_subsys {
 	u16			cntlid_max;
=20
 	struct list_head	ctrls;
+	struct task_struct	*ctrls_owner;
=20
 	struct list_head	hosts;
 	bool			allow_any_host;=

