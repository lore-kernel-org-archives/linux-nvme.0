Return-Path: <SRS0=pbEM=JE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC11C433ED
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Apr 2021 10:36:21 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BC72613A0
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Apr 2021 10:36:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BC72613A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=hFktGGVZc7Bwjq4J14ft1xoKoE2rWGgYn0lfqLq9XuE=; b=TKVWYF7tTCVBEbhQEOnF7By2Y
	kra7/kSKj9JkumljJTA9e0AvwTZr9zihYHONsCjKqzoYKvifC0kfNFLR8VOTOeOPfTTQaEhJ2ekcH
	MzyKixD39GK1oaOWaFuxMdikxe5MFcRK0Lo+YlwA2/hOcoXp/6DljGyNQy5n5VeGa+tQDTNqvN+oz
	j155fxOPA5VuZG36/ZXP/CL+vRAVXUcVX0NtO1HRXZUgtCyQveb8p7jfMJqMD++KpIJoD6fbEw3Um
	+ZNhEhxlUbz/VVqv1In9cAYNtqtpkXI6vJ6V7c9BJ+zb0soO5beSIfHkPtRERiJoIN5JRXvQO3NL5
	vGVJVcsng==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lU5Xb-004jx6-V8; Wed, 07 Apr 2021 10:36:08 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lU5XW-004jw7-8M
 for linux-nvme@lists.infradead.org; Wed, 07 Apr 2021 10:36:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1617791762; x=1649327762;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=Y+PF128z7Fg6p7nBTgQULYH+A08L83aI98d3q+YY8Rs=;
 b=RrJ4LWg5ttHNTCUtxnrWfaeHXK72zyDB6eArbkpoYVZFk5s8gS9buYrR
 VoTBsageq+UpR9AxdaaBnGAFjzA4nrHgD0x7WlI05IdyBDrPqDlCq4V8Z
 G9cnQp1aFf29ckCLEj3BwAGNeJQUjv/6j3eAOKz8DVurvQaU3R1P1+QfZ
 7H2f8HXGRnHS6xmOvJVBdHFP+mpUPdD9uQ80NcZgUKZC9yFQ9U+863YXW
 Gdb3T14oa9115hRFlLL14JkLyCl6ZkWzqN/okogNJfJt9WnJ8+kz2cOoL
 9Ql78rQP7Q7Yxzo+J+n+zJPmK9mRrqbAHrycIsMX5GHe/FMhqVwPNJCX8 Q==;
IronPort-SDR: dh5YH/fFyeICJD78Qm2xH8HOR98RxeA9RWYXVOqpzjCXpyF42LwUS950yllqmhi7a9Cduu55Pu
 87FmBGuF8AuuX4QFUiXvxqZxkIXJKk/YWEccB9hLv/fNJAcpgNuFY3xgnTCutIsOIAEhctxKwW
 odJZXG7isYN42X83/kGNEGJqmv/xRiaLGy0yVyGkagAnA5Meki34gmOicBW/nvX+buPujsQmbz
 sRlOGt96ybHHhpeh9xyngJnVck+JoJuCTH9yD794nclTHLe8zBc6Uu45Vj8IdGZNbAn5W9XPoW
 Z18=
X-IronPort-AV: E=Sophos;i="5.82,203,1613404800"; d="scan'208";a="164994877"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO
 NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
 by ob1.hgst.iphmx.com with ESMTP; 07 Apr 2021 18:34:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=je4S98x4bRrfAsOELAIkszj7pNAbHF91SDvWyKzKeQo9Wp1S5awHjOsBXk11daP2c17TYhBeL/X8D0mKDGYrab+6s36q5eTM6C8bVALX5cJVLhvMahsZ1nwx3c3WeCuiLokVPp3Pq9P7M8W8wVA6tAw6r7m2vhzC+WCghMHorY5RpdVNBCPmuJHAXvjGq6uD6RWSS77yS3uyaROwbwEkWiAlBVcCk3FUsu2WbUScURyEY/PZ1/nhRBAYJlH3mWzbfS/JfV6jOHsloTDCDtFEGsYvSzzEEZzbB0z4TB043SmoEqHFZkFtK5+3s0iUsqXuaMDrQlYm21FXbspJCntY+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+PF128z7Fg6p7nBTgQULYH+A08L83aI98d3q+YY8Rs=;
 b=FbGoqgJ7C5p/nzyee9jFdyY1Mwu8SUv0SACYs4rihG9rZ7Y2WuFGacCqfkt1/CwhcbJU1GhMkOBN5no0W+Y7OOuOL5UobRc7h8AhWb3gQTsBHZvs9wbH+4wXPDMI8+j7aTxTzADGcetuEjaTZzUwJ8U9g0BueUvXz70V0LWY+nethbvkX6Vq8tO0hf94lARYIatewT6RIpKE4QsWsSUUXA14B8ux2X6MR3oBd+PXkv70nq3BA4Atrk0mtyTgPFgqElH+eaUPfiZ8vyRp2IW8RjlJA4F58uSnx+DMWU19s9sRW3KbfzWC7hTLOKlkoFc8h2cKLPtHoHqhPAbL7Uvrzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+PF128z7Fg6p7nBTgQULYH+A08L83aI98d3q+YY8Rs=;
 b=YxEWPudpNSoFjJ23uR71zz6f2xPB7OCWXRytru2F/T4EVhciQJoG8N8pip8d6KhELmYgKUv0nAdeadVagyTpsLnC//BJ//0o3lUcLk27fdThaHeZq2fYicahKjJ38Lboa/sabFTLLeFXyGivr/rYVjwNqPOE6/Bkj4D3YC8DIKE=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB4642.namprd04.prod.outlook.com (2603:10b6:208:47::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Wed, 7 Apr
 2021 10:34:47 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887%3]) with mapi id 15.20.3999.032; Wed, 7 Apr 2021
 10:34:47 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Christoph Hellwig <hch@lst.de>, Niklas Cassel <Niklas.Cassel@wdc.com>
CC: Minwoo Im <minwoo.im.dev@gmail.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, Keith Busch <kbusch@kernel.org>, Jens Axboe
 <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>, Kanchan Joshi
 <joshiiitr@gmail.com>, =?iso-8859-1?Q?Javier_Gonz=E1lez?=
 <javier.gonz@samsung.com>
Subject: Re: [PATCH V2 0/1] nvme: introduce generic per-namespace chardev
Thread-Topic: [PATCH V2 0/1] nvme: introduce generic per-namespace chardev
Thread-Index: AQHXKrJHUi4rfDBb0EeuGA0FosXDZQ==
Date: Wed, 7 Apr 2021 10:34:47 +0000
Message-ID: <BL0PR04MB651481C1623F0B99F573168DE7759@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210406064841.103393-1-minwoo.im.dev@gmail.com>
 <YGwjc8rliXhvccPp@x1-carbon.lan> <20210406133533.GC2594@localhost>
 <20210406145948.GB7790@lst.de> <YG1g9bMYRjS3uCXs@x1-carbon.lan>
 <20210407093923.GA31210@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:f060:aa0a:9ee0:dfa8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: edd1a2bb-963a-4346-cda5-08d8f9b0c423
x-ms-traffictypediagnostic: BL0PR04MB4642:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR04MB4642633DAEEB49DA9B2E2875E7759@BL0PR04MB4642.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mDtqt0sxYCB6lUOdIkU0S4tpIBbWcx+50f0U9DCZxoplHE2oUJsBzVLE2WgQAe6E6sXsEQYVinWpLV4Pp9XTucpwCdiNrBdrmr/GffaqH+zl1Kw8KpaByVtKblZz3E1lzwJK6WCmD8RTQ6Y3UUX3nwS/DN+vyWyue5c6nAXxf2/moxm+DEjmuTBh2IAGe6bRJKNfgXLzoK+GkFTDhLhQOSRB4WPR86uH8UMSKDUk8CK8co2492u+kBQoLv5iTt0Gp+aDlXXNPydrU1Ry2xJFgdGPEro+pc4YGbyB6n23ZntWXu3BaIScmwdgNGcgn0+Be2pP20gKmkQ6WXTGVTzT8twKzqNau0WIWQ0uLC+XdrehG+cT6H3v7k57MihHh7W+qbxS0sN9N6vjwm2ocaBXEszR1s8SuNLvoMCCPYBTEit6e4q3M/vCLLyVdWQBDlm7GmWnu/SSAS/JdnKKXaV/MA/ilTtm6LeWse2t9UQcvI1Kvy/NW7h+Jfle8LCaFo6/XXMA81JVZPrrl4YG6Gx9FKdAJ9+Fc7wYPBdHIdQBpceVHDxFcxHfd3mBww5qGeahUMyj5ILyLoNrOOjPEYIYOtNFr/z77sa3vcdDWrI2vLRqO9LYDp503eKLwTZEp0hNZBB/s1igLZLzDRxj2s7clSHFbHvMwdxP2al1AluUfweIn9LMt/uv+1EZBqOP94bhJ/JFs4k/wm8hqDZJhvdrDvfjASOADxIo2yIg8XX9pC5n7/ih9kCXzstLToPhQpWjqpqEyshhbl83gujI0Ll81g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR04MB6514.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(366004)(39860400002)(376002)(346002)(54906003)(110136005)(8936002)(52536014)(5660300002)(316002)(966005)(76116006)(64756008)(66476007)(66946007)(71200400001)(7696005)(6636002)(86362001)(55016002)(33656002)(9686003)(186003)(478600001)(6506007)(4326008)(66556008)(53546011)(8676002)(2906002)(66446008)(91956017)(83380400001)(38100700001)(41533002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?Nq7zxxS5BusdRcODhbl+CeHYLEhe0KQwSq8lVACbUZBN1kPE/WSnJxaqeC?=
 =?iso-8859-1?Q?J7dEvBYqB05sksKVXSBZ1wdIayXUgD/Hcod9RmdlPHZb+jYedXpxuvTwP6?=
 =?iso-8859-1?Q?YuuMuCoH9nestt/w4vp2OscNtjXlVjaGnCVYvlI7e10gOml13sUGOSt+OC?=
 =?iso-8859-1?Q?utDshjMmwcmo+D7mWt5aFihIt/4y/iSPevjklElSKwyQyA/WcOlNPSDKot?=
 =?iso-8859-1?Q?eDul2iJGXV3mQ+Hfuv1CX9yoDDaA9NlEH+7Baxz4czZqMH6hg/PbBd09Ny?=
 =?iso-8859-1?Q?oPrxjN9kOw9ytZl+KaOt2RsBZwYUe2Pu265HaV3NKCIZ5h522h3GieHxtO?=
 =?iso-8859-1?Q?WLibPUP3UilcB4oc8ZvqkeT2LDT9XYQSOjb3ZOlNWBxtJaHT3G/tTI7+sh?=
 =?iso-8859-1?Q?sp0BACBn3e6vQxRObwZkhzLVLESG1b3FdgbOnmB9Nq0lYa9bzjq+43MZRL?=
 =?iso-8859-1?Q?Y14X1Nncrq3RrOYIC+aYrmJmqdt4E9mQI6W0uTONR167ce4+2mKI4zizTP?=
 =?iso-8859-1?Q?R41YOJ1uKPz/tRVYlD92a8PBhSg67QwIzEZ2+0qOE/kWQm0kkJEnX/1IP7?=
 =?iso-8859-1?Q?NHvEI7tsfMBGFtOVjouIEcjyuDwXHiGobqOK2Iea7HkumMvNJy2l1j+2oc?=
 =?iso-8859-1?Q?uV5UHIY4GjG1O7qEEpYv4wuvgKXg9OhRGETs9aQiI2j+9b81BjjVe2xN2S?=
 =?iso-8859-1?Q?+npe0fKhA1OR/1IdNsXQULwTQM78/lyAtrTrwV+0ysmeYLlgOOBeHi9Vy7?=
 =?iso-8859-1?Q?iGYC5BCksTlIzREX2PCzk+UGi48smSqZuZfEsy3vx7zriRntp9w8puRiJQ?=
 =?iso-8859-1?Q?W2MYrcXCewh2iE/jUFx20PkwOMheLj8WjFCZxDVzM8lcBWpkMiP8ry0PwW?=
 =?iso-8859-1?Q?MiCtpmaWKoiMf9O/sH/dhciUPRXEgCL0KTiWjh4Htj6EcVyaBspciWgGaz?=
 =?iso-8859-1?Q?ZbAreMWt0UyYbxbC1L4yPAfvlzBhABcGIU7tPW0LHPwhii8MkyhrTTeKas?=
 =?iso-8859-1?Q?7qh/ZBd+YazvA7Cs8Mw/eFnWCQSLBvB0ONZ+LwmcwcczT9KvSrqVp9ehDO?=
 =?iso-8859-1?Q?CTZa+Wrttxsdq4cmJovOBgSbQ43w+nUEllus1clRptL038QLrPIlMTTBpy?=
 =?iso-8859-1?Q?NMnlzkF4KMu8sCWBPsRtGfbqfsU+tA0Dd28bSfFIj2K99B+5eIOTL+t+sz?=
 =?iso-8859-1?Q?LvQRAVrDkQdCYFl9hm0XsLCyw2XJecP8jWzQQmPPzDdFhbGoUrSIdSF3iU?=
 =?iso-8859-1?Q?qhaujNhBsXhn9QGygMEroSzujB/qtIhsgaud2/83tMk3+WfrPcM+6kK8SB?=
 =?iso-8859-1?Q?JpGIhJ9rBmY8frb6WuHLp0bXFWRWO8Zc+3OHanUocjW6RJgnQnKm/Rd+oA?=
 =?iso-8859-1?Q?/SuS8cuAi2quXvRRtQcHahNNkdijr60kWrtIxHE95E0J2aK9jxAa1MMDNY?=
 =?iso-8859-1?Q?oQ+J2Ue4GJ0mQQPAFJjY4d3LxCZ2GtVyd/cCew=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edd1a2bb-963a-4346-cda5-08d8f9b0c423
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2021 10:34:47.2190 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ReMwG7ToJyEvKq3V3J/fvZsQXak6Mw0/5zO1F3ROZPBr4JXQYeHhSHzm1SL3WA2WYn9KhMb5zviVXd5wZZAwKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4642
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210407_113603_214176_F7DA6C05 
X-CRM114-Status: GOOD (  15.53  )
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

On 2021/04/07 18:47, Christoph Hellwig wrote:
> On Wed, Apr 07, 2021 at 07:36:22AM +0000, Niklas Cassel wrote:
>> The SCSI generic devices are named /dev/sgX while the SCSI block devices
>> are named /dev/sd*, so the names are more distinct compared to /dev/nvme*
>> and /dev/nvme-generic-*.
>>
>> A "regular" Linux user who writes /dev/sd<tab> will not see the SCSI
>> generic devices, but with the current proposal, if he writes
>> /dev/nvme<tab>, he will see the NVMe generic devices.
>>
>> I just had a gut feeling that this could cause confusion in the future.
>> However, I trust your experience and judgement more than my gut feeling.
> 
> Should we call the nodes /dev/ng* ?

That would be a nice symmetry with scsi / sg. I am all for it.
This would also make it easier to read a "ls" output, avoiding a lot of nvme
device names that differ only by 1 character ("c").

> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
> 


-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
