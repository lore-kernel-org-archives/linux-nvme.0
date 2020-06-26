Return-Path: <SRS0=morU=AH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2018C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 10:50:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9432E20775
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 10:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UzWKeQ9U";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p24mlMrH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KwOA2g1h";
	dkim=neutral (0-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="E8f5zi//"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9432E20775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=dR9mwxN3wvcBJuuvhXIHtrmWfa5kVuqLiQeUENo6+o0=; b=UzWKeQ9UPmvqbkP3OxmZ9ulv6
	FYipfNdzA9CdNFDRzayHDNv+0FhS8VujJy9YjAcXG+5cuKqHGK94aIaQyXRVgugQYV/vyY68eSVbm
	yblcmJL96AgZTFPfzNC2CWCql+N4qo7rU+dlzYqoNuzKVppBBpjpeGnRvFgGfoVvba+O34VLJXbqA
	vFzAl0nfxgR6XzrRQ9jEHOXHz3RiyHev6KnTkTTd1D6+UHCeijN4KzZievWWNXznTdBG8TX6TXl4k
	N3X1nuuVV30TRVHAl3OoPXg4p2SrJVxsfap0iiVGgAnYuou57Xrrq9jGjrlf6+0OFX4QhWgBGCvai
	x49/r/wxA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jolvr-0005Wy-7j; Fri, 26 Jun 2020 10:50:07 +0000
Received: from casper.infradead.org ([90.155.50.34])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jolvo-0005UN-VJ
 for linux-nvme@merlin.infradead.org; Fri, 26 Jun 2020 10:50:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:References:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:
 Content-ID:Content-Description:In-Reply-To;
 bh=7N53Y6KWBEUFLdteooV3bksCCcT/CmW7S5LRrWz3wbA=; b=p24mlMrHTZ1GRr/lBHSHBPaj4A
 jpYdxGnQwyoCZ6SY+4gT2J/Ae7cBBgqXJObuhqo1mIKJBa61g2JBm0EpD+T38rfVKMSY6KDcfUL8T
 zD8SWOHyN5KV/nK+JeyHG16xTtgLYc+6P5Zl1DQ2HJm8fbedfjpdBUzxuBRuncT5wC7ea7w783Sdp
 CbNoUo8EexfXKM77GNGp6LmiWbmDt7hjfHbY293y8a2l9PT3rFQsRVOKH9vGOPvRa1foXTgp+Kt/E
 0612tMF+D5iOv8jqfymBH6IxEHho4QLFrviyiezmyFARbijyJwArWd7os2NUQ7xY5Gr9kdkjXkhIs
 PArkFf2g==;
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by casper.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jolut-00044i-Bk
 for linux-nvme@lists.infradead.org; Fri, 26 Jun 2020 10:49:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593168566; x=1624704566;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=Lzh+xF3ZKt96MNjMa9V+soRfoQVvQOOXw8iGWLc5ej4=;
 b=KwOA2g1hkgfxDZIHKu1/oR3bccnejXcuS9C8TESmYvhcIsNvVe0OdNWh
 SrjcOlWfqb7ACFk7MyM6SMxSNQjEMn9XrVvh9DHttQBYxnNYS74FWoqfz
 jp56cuO9R0GWwCFcrI9fsAs5FkMe8FEZKyhYaGbp2/mMlQ7ZlW6oecgvl
 B1aTjs6EyxKGr5ndfv1Qh9AMRzLvaw7CzPDSqyh6p71VPZ1Iz+knjkQYk
 Wg3B8kP1+UeGIuwREAk8ABPn+8sbgmaxWTwpqTzWwrmdcBgkroPJR3ZE4
 Pj9PprTwhBOsVP/sBAiJ0oPnQ3nQYFvic94h6KdRIBYt8ckb+7xCr8zRX Q==;
IronPort-SDR: 8LMsIgC3EK3xv0pPQd6fAeItxTUGIDcqVZzSxNUwldolgjKCrr85eV9Cnf5ZA9yP0kAOU5ru53
 GrekbNsRrsa83UDfcQE94kErDpfeQlaORnpwOaptz3PZeaz/Tv5jzNWI9jn9SnR9T0wnHSnpTx
 1O0ODGPzJemV+Va6LkznQwKovNnuDCOEbiPrLDw39mZ8lsNwAck8Tm+/9KUifteURwyN/Py6WO
 F7rljvIadOl6neOUXpdgwTkIk3abBgNc4uSPEVVVV80JY2QLcxhiAEMwQ+4l8tZT9D1Gto6i47
 3O4=
X-IronPort-AV: E=Sophos;i="5.75,281,1589212800"; d="scan'208";a="243972068"
Received: from mail-sn1nam02lp2057.outbound.protection.outlook.com (HELO
 NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.57])
 by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2020 08:57:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BeYyZ/X2turcSrRrU08eNLR0do5WEy6pYQXsSaBL4qXJo/DFKnn4L/SqV8PHTid6LH/HwoFlmzYIVu33d6L62JffQ7wrQySJOuuec6lccWyM15K3JxLbGVN1tilk2gk5dVIKXko307nc36/Q4xV538dkRLRqJ0QNGwbsM6atPvalTBjiAOMRtLv+GQSDISV9xqcXSnOXqEHnb/1jtHTPO+Buh6mDLQtrTNlIC+7OdiKB7n/eCVTn3NL3zF0DaXwi7P+cW79tEEKFi2oZ6NkPQo2wP4ZtNt0ZnOVOSSILdrgQ/25N+ox5SCy8Ks5AsEvuJdk1RmzpcSYS5GINsY+w5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7N53Y6KWBEUFLdteooV3bksCCcT/CmW7S5LRrWz3wbA=;
 b=Z9WNFBYkWyyFmrqkVxrkHclmSboOkmehcBvl3bVRhQX82UUYVFAgqwUt9flh7HhsBsveDdBal6iemGaeEolKTWrUhgxuYIDQj7y2m4SdnZIr7xA0bg8xFj4/hWcOJLtSpt1jIW+QViGsFtkwBU3k7whnhN9QI5hvt05CbdPkN+EpKBpqBzUcWarVcmPWt43Mr22YkJS3FkOdBTwM5gCjB+2WvKa6JtzdaRGNwWD9R77muXPMVl78U/V3JcMLqj/hqUw7lagpVPrZnkTVyxW7R5bsvPz9VsZ0/f1ttjFDI8zQYHZ4QMx9b1mRg07av07xZixS81rVdnDJ5/O8PPGAZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7N53Y6KWBEUFLdteooV3bksCCcT/CmW7S5LRrWz3wbA=;
 b=E8f5zi//VJDMf9hJtVS1I4qI7rY//AA1AThvitKdsuNVuXytWNU+Lh2M0CAoAvEjBPT2ceN/e2xLLGHgXglopiQIjWtNHLl+T7zLlc+GQsHrUDBtwKQPrXSSAaKhA7sACaDIuNudZvIRCziGmsCWvv8iURx0Bq6qUsBsed6xPcs=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB1257.namprd04.prod.outlook.com (2603:10b6:910:53::34)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.25; Fri, 26 Jun
 2020 00:57:45 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3131.024; Fri, 26 Jun 2020
 00:57:44 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>,
 =?iso-8859-1?Q?Matias_Bj=F8rling?= <mb@lightnvm.io>
Subject: Re: [PATCH 4/6] block: introduce IOCTL to report dev properties
Thread-Topic: [PATCH 4/6] block: introduce IOCTL to report dev properties
Thread-Index: AQHWSutNlrk/U7ZovU6aHVaoqZz0nw==
Date: Fri, 26 Jun 2020 00:57:44 +0000
Message-ID: <CY4PR04MB3751C079C5906D9F0D93F961E7930@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-5-javier@javigon.com>
 <6333b2f1-a4f1-166f-5e0d-03f47389458a@lightnvm.io>
 <20200625194248.44rwwestffgz4jks@MacBook-Pro.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: javigon.com; dkim=none (message not signed)
 header.d=none;javigon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dc2dc252-1747-4688-d9be-08d8196befed
x-ms-traffictypediagnostic: CY4PR04MB1257:
x-microsoft-antispam-prvs: <CY4PR04MB1257C9C15224F43B6FE9EF85E7930@CY4PR04MB1257.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0446F0FCE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hp6lhFVJCFgaWLIU6OsKz8nVKehxZGOhRpb7W39zoJrg/7Kp74C6IxqpN2KsVBgzyemDP8UO3Z5lb+O6CbPsidIyuZoX3VQvvDAl5Ho+nr6TOmS6uDPh8nlUiiCwcQlNHhpt8Zdn49grtt3R37jJu4Ch5cplpq7YYvSCC+vFRVTeVEn2U/Pa3dwsHjxx9QoLrXwoiYKqn1YraA44lgBeDgxoX1biB0M5nBrLor+k4ak5++YBI3mXrvp2xpakPqDIsSnMnxumoaTQxN6rMLCZz/de4kd+3Q3jI7kgd6bTa2Lvw/LbKm/Irej4olq0zEduoH0aA4hxznm3kgxB6ri7wQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(39860400002)(136003)(396003)(346002)(8676002)(8936002)(316002)(54906003)(478600001)(66574015)(30864003)(7696005)(83380400001)(7416002)(53546011)(33656002)(55016002)(66446008)(4326008)(76116006)(66476007)(52536014)(91956017)(66946007)(66556008)(64756008)(86362001)(2906002)(9686003)(26005)(71200400001)(110136005)(5660300002)(6506007)(186003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: YicK7VhyHv63Mk4OPW5H3Zb8pUoZpHEum/MzEqaW0oTnvt972cZJj71NQW0t93uLgVCBNKpJCXEnDNRUgBaJs9SX2sF5lvRrNsz2CU2qFND1DSMTkySxW+eDlcKqjbp8Jctf6sygAk6ZWQFhbYCVbmDpwiV9YFvuXXqYcVIUgPzZ4EMAaoxjgBx9U5Vjv41rJnak0CQJOkaYPUYtEI1hXk7Ct+aJoRddbRUcL+9jnfliKjOF51IBazmnAYY9gLcreVmAbwPu4/V/BEdyC22qCs9E8QBaC6Z86Nq6rxVZgdSWvMUzri/PwIXbGFFq6yADz1S77VAATMZxcl88yyj6ssio30TrnRjLSRMDCYFNf5l2+/wTvijlHMy+5GgfZDt4LsG10DHqINpMyNQdZ753NkJoqT6EnKrWVri9EFa++FkOdurVnqAFL2pE15/kvehiMNKVdPePLpbbyRXA+O0bKH7DGl8rr7if8WVXYKba7Xl/2+ColaexZR4JHy7sUlHE
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc2dc252-1747-4688-d9be-08d8196befed
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2020 00:57:44.7833 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UyMPmPyMh9/RLgTexSg2GGzI5BgAq0gqp1EJP32u7gxqJxh442LXgSLhNum+UftodoasXZmMzVpsoZVxvJyEAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB1257
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200626_114909_595667_F5A1A058 
X-CRM114-Status: GOOD (  14.42  )
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
 SelvaKumar S <selvakuma.s1@samsung.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 Kanchan Joshi <joshi.k@samsung.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Nitesh Shetty <nj.shetty@samsung.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020/06/26 4:42, Javier Gonz=E1lez wrote:
> On 25.06.2020 15:10, Matias Bj=F8rling wrote:
>> On 25/06/2020 14.21, Javier Gonz=E1lez wrote:
>>> From: Javier Gonz=E1lez <javier.gonz@samsung.com>
>>>
>>> With the addition of ZNS, a new set of properties have been added to the
>>> zoned block device. This patch introduces a new IOCTL to expose these
>>> rroperties to user space.
>>>
>>> Signed-off-by: Javier Gonz=E1lez <javier.gonz@samsung.com>
>>> Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
>>> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
>>> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
>>> ---
>>>  block/blk-zoned.c             | 46 ++++++++++++++++++++++++++
>>>  block/ioctl.c                 |  2 ++
>>>  drivers/nvme/host/core.c      |  2 ++
>>>  drivers/nvme/host/nvme.h      | 11 +++++++
>>>  drivers/nvme/host/zns.c       | 61 +++++++++++++++++++++++++++++++++++
>>>  include/linux/blkdev.h        |  9 ++++++
>>>  include/uapi/linux/blkzoned.h | 13 ++++++++
>>>  7 files changed, 144 insertions(+)
>>>
>>> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
>>> index 704fc15813d1..39ec72af9537 100644
>>> --- a/block/blk-zoned.c
>>> +++ b/block/blk-zoned.c
>>> @@ -169,6 +169,17 @@ int blkdev_report_zones(struct block_device *bdev,=
 sector_t sector,
>>>  }
>>>  EXPORT_SYMBOL_GPL(blkdev_report_zones);
>>> +static int blkdev_report_zonedev_prop(struct block_device *bdev,
>>> +				      struct blk_zone_dev *zprop)
>>> +{
>>> +	struct gendisk *disk =3D bdev->bd_disk;
>>> +
>>> +	if (WARN_ON_ONCE(!bdev->bd_disk->fops->report_zone_p))
>>> +		return -EOPNOTSUPP;
>>> +
>>> +	return disk->fops->report_zone_p(disk, zprop);
>>> +}
>>> +
>>>  static inline bool blkdev_allow_reset_all_zones(struct block_device *b=
dev,
>>>  						sector_t sector,
>>>  						sector_t nr_sectors)
>>> @@ -430,6 +441,41 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bd=
ev, fmode_t mode,
>>>  				GFP_KERNEL);
>>>  }
>>> +int blkdev_zonedev_prop(struct block_device *bdev, fmode_t mode,
>>> +			unsigned int cmd, unsigned long arg)
>>> +{
>>> +	void __user *argp =3D (void __user *)arg;
>>> +	struct request_queue *q;
>>> +	struct blk_zone_dev zprop;
>>> +	int ret;
>>> +
>>> +	if (!argp)
>>> +		return -EINVAL;
>>> +
>>> +	q =3D bdev_get_queue(bdev);
>>> +	if (!q)
>>> +		return -ENXIO;
>>> +
>>> +	if (!blk_queue_is_zoned(q))
>>> +		return -ENOTTY;
>>> +
>>> +	if (!capable(CAP_SYS_ADMIN))
>>> +		return -EACCES;
>>> +
>>> +	if (!(mode & FMODE_WRITE))
>>> +		return -EBADF;
>>> +
>>> +	ret =3D blkdev_report_zonedev_prop(bdev, &zprop);
>>> +	if (ret)
>>> +		goto out;
>>> +
>>> +	if (copy_to_user(argp, &zprop, sizeof(struct blk_zone_dev)))
>>> +		return -EFAULT;
>>> +
>>> +out:
>>> +	return ret;
>>> +}
>>> +
>>>  static inline unsigned long *blk_alloc_zone_bitmap(int node,
>>>  						   unsigned int nr_zones)
>>>  {
>>> diff --git a/block/ioctl.c b/block/ioctl.c
>>> index 0ea29754e7dd..f7b4e0f2dd4c 100644
>>> --- a/block/ioctl.c
>>> +++ b/block/ioctl.c
>>> @@ -517,6 +517,8 @@ static int blkdev_common_ioctl(struct block_device =
*bdev, fmode_t mode,
>>>  		return blkdev_zone_ops_ioctl(bdev, mode, cmd, arg);
>>>  	case BLKMGMTZONE:
>>>  		return blkdev_zone_mgmt_ioctl(bdev, mode, cmd, arg);
>>> +	case BLKZONEDEVPROP:
>>> +		return blkdev_zonedev_prop(bdev, mode, cmd, arg);
>>>  	case BLKGETZONESZ:
>>>  		return put_uint(argp, bdev_zone_sectors(bdev));
>>>  	case BLKGETNRZONES:
>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>> index 5b95c81d2a2d..a32c909a915f 100644
>>> --- a/drivers/nvme/host/core.c
>>> +++ b/drivers/nvme/host/core.c
>>> @@ -2254,6 +2254,7 @@ static const struct block_device_operations nvme_=
fops =3D {
>>>  	.getgeo		=3D nvme_getgeo,
>>>  	.revalidate_disk=3D nvme_revalidate_disk,
>>>  	.report_zones	=3D nvme_report_zones,
>>> +	.report_zone_p	=3D nvme_report_zone_prop,
>>>  	.pr_ops		=3D &nvme_pr_ops,
>>>  };
>>> @@ -2280,6 +2281,7 @@ const struct block_device_operations nvme_ns_head=
_ops =3D {
>>>  	.compat_ioctl	=3D nvme_compat_ioctl,
>>>  	.getgeo		=3D nvme_getgeo,
>>>  	.report_zones	=3D nvme_report_zones,
>>> +	.report_zone_p	=3D nvme_report_zone_prop,
>>>  	.pr_ops		=3D &nvme_pr_ops,
>>>  };
>>>  #endif /* CONFIG_NVME_MULTIPATH */
>>> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
>>> index ecf443efdf91..172e0531f37f 100644
>>> --- a/drivers/nvme/host/nvme.h
>>> +++ b/drivers/nvme/host/nvme.h
>>> @@ -407,6 +407,14 @@ struct nvme_ns {
>>>  	u8 pi_type;
>>>  #ifdef CONFIG_BLK_DEV_ZONED
>>>  	u64 zsze;
>>> +
>>> +	u32 nr_zones;
>>> +	u32 mar;
>>> +	u32 mor;
>>> +	u32 rrl;
>>> +	u32 frl;
>>> +	u16 zoc;
>>> +	u16 ozcs;
>>>  #endif
>>>  	unsigned long features;
>>>  	unsigned long flags;
>>> @@ -704,11 +712,14 @@ int nvme_update_zone_info(struct gendisk *disk, s=
truct nvme_ns *ns,
>>>  int nvme_report_zones(struct gendisk *disk, sector_t sector,
>>>  		      unsigned int nr_zones, report_zones_cb cb, void *data);
>>> +int nvme_report_zone_prop(struct gendisk *disk, struct blk_zone_dev *z=
prop);
>>> +
>>>  blk_status_t nvme_setup_zone_mgmt_send(struct nvme_ns *ns, struct requ=
est *req,
>>>  				       struct nvme_command *cmnd,
>>>  				       enum nvme_zone_mgmt_action action);
>>>  #else
>>>  #define nvme_report_zones NULL
>>> +#define nvme_report_zone_prop NULL
>>>  static inline blk_status_t nvme_setup_zone_mgmt_send(struct nvme_ns *n=
s,
>>>  		struct request *req, struct nvme_command *cmnd,
>>> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
>>> index 2e6512ac6f01..258d03610cc0 100644
>>> --- a/drivers/nvme/host/zns.c
>>> +++ b/drivers/nvme/host/zns.c
>>> @@ -32,6 +32,28 @@ static int nvme_set_max_append(struct nvme_ctrl *ctr=
l)
>>>  	return 0;
>>>  }
>>> +static u64 nvme_zns_nr_zones(struct nvme_ns *ns)
>>> +{
>>> +	struct nvme_command c =3D { };
>>> +	struct nvme_zone_report report;
>>> +	int buflen =3D sizeof(struct nvme_zone_report);
>>> +	int ret;
>>> +
>>> +	c.zmr.opcode =3D nvme_cmd_zone_mgmt_recv;
>>> +	c.zmr.nsid =3D cpu_to_le32(ns->head->ns_id);
>>> +	c.zmr.slba =3D cpu_to_le64(0);
>>> +	c.zmr.numd =3D cpu_to_le32(nvme_bytes_to_numd(buflen));
>>> +	c.zmr.zra =3D NVME_ZRA_ZONE_REPORT;
>>> +	c.zmr.zrasf =3D NVME_ZRASF_ZONE_REPORT_ALL;
>>> +	c.zmr.pr =3D 0;
>>> +
>>> +	ret =3D nvme_submit_sync_cmd(ns->queue, &c, &report, buflen);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	return le64_to_cpu(report.nr_zones);
>>> +}
>>> +
>>>  int nvme_update_zone_info(struct gendisk *disk, struct nvme_ns *ns,
>>>  			  unsigned lbaf)
>>>  {
>>> @@ -87,6 +109,13 @@ int nvme_update_zone_info(struct gendisk *disk, str=
uct nvme_ns *ns,
>>>  		goto free_data;
>>>  	}
>>> +	ns->nr_zones =3D nvme_zns_nr_zones(ns);
>>> +	ns->mar =3D le32_to_cpu(id->mar);
>>> +	ns->mor =3D le32_to_cpu(id->mor);
>>> +	ns->rrl =3D le32_to_cpu(id->rrl);
>>> +	ns->frl =3D le32_to_cpu(id->frl);
>>> +	ns->zoc =3D le16_to_cpu(id->zoc);
>>> +
>>>  	q->limits.zoned =3D BLK_ZONED_HM;
>>>  	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
>>>  free_data:
>>> @@ -230,6 +259,38 @@ int nvme_report_zones(struct gendisk *disk, sector=
_t sector,
>>>  	return ret;
>>>  }
>>> +static int nvme_ns_report_zone_prop(struct nvme_ns *ns, struct blk_zon=
e_dev *zprop)
>>> +{
>>> +	zprop->nr_zones =3D ns->nr_zones;
>>> +	zprop->zoc =3D ns->zoc;
>>> +	zprop->ozcs =3D ns->ozcs;
>>> +	zprop->mar =3D ns->mar;
>>> +	zprop->mor =3D ns->mor;
>>> +	zprop->rrl =3D ns->rrl;
>>> +	zprop->frl =3D ns->frl;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +int nvme_report_zone_prop(struct gendisk *disk, struct blk_zone_dev *z=
prop)
>>> +{
>>> +	struct nvme_ns_head *head =3D NULL;
>>> +	struct nvme_ns *ns;
>>> +	int srcu_idx, ret;
>>> +
>>> +	ns =3D nvme_get_ns_from_disk(disk, &head, &srcu_idx);
>>> +	if (unlikely(!ns))
>>> +		return -EWOULDBLOCK;
>>> +
>>> +	if (ns->head->ids.csi =3D=3D NVME_CSI_ZNS)
>>> +		ret =3D nvme_ns_report_zone_prop(ns, zprop);
>>> +	else
>>> +		ret =3D -EINVAL;
>>> +	nvme_put_ns_from_disk(head, srcu_idx);
>>> +
>>> +	return ret;
>>> +}
>>> +
>>>  blk_status_t nvme_setup_zone_mgmt_send(struct nvme_ns *ns, struct requ=
est *req,
>>>  		struct nvme_command *c, enum nvme_zone_mgmt_action action)
>>>  {
>>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>>> index 8308d8a3720b..0c0faa58b7f4 100644
>>> --- a/include/linux/blkdev.h
>>> +++ b/include/linux/blkdev.h
>>> @@ -372,6 +372,8 @@ extern int blkdev_zone_ops_ioctl(struct block_devic=
e *bdev, fmode_t mode,
>>>  				  unsigned int cmd, unsigned long arg);
>>>  extern int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t m=
ode,
>>>  				  unsigned int cmd, unsigned long arg);
>>> +extern int blkdev_zonedev_prop(struct block_device *bdev, fmode_t mode,
>>> +			unsigned int cmd, unsigned long arg);
>>>  #else /* CONFIG_BLK_DEV_ZONED */
>>>  static inline unsigned int blkdev_nr_zones(struct gendisk *disk)
>>> @@ -400,6 +402,12 @@ static inline int blkdev_zone_mgmt_ioctl(struct bl=
ock_device *bdev,
>>>  	return -ENOTTY;
>>>  }
>>> +static inline int blkdev_zonedev_prop(struct block_device *bdev, fmode=
_t mode,
>>> +				      unsigned int cmd, unsigned long arg)
>>> +{
>>> +	return -ENOTTY;
>>> +}
>>> +
>>>  #endif /* CONFIG_BLK_DEV_ZONED */
>>>  struct request_queue {
>>> @@ -1770,6 +1778,7 @@ struct block_device_operations {
>>>  	int (*report_zones)(struct gendisk *, sector_t sector,
>>>  			unsigned int nr_zones, report_zones_cb cb, void *data);
>>>  	char *(*devnode)(struct gendisk *disk, umode_t *mode);
>>> +	int (*report_zone_p)(struct gendisk *disk, struct blk_zone_dev *zprop=
);
>>>  	struct module *owner;
>>>  	const struct pr_ops *pr_ops;
>>>  };
>>> diff --git a/include/uapi/linux/blkzoned.h b/include/uapi/linux/blkzone=
d.h
>>> index d0978ee10fc7..0c49a4b2ce5d 100644
>>> --- a/include/uapi/linux/blkzoned.h
>>> +++ b/include/uapi/linux/blkzoned.h
>>> @@ -142,6 +142,18 @@ struct blk_zone_range {
>>>  	__u64		nr_sectors;
>>>  };
>>> +struct blk_zone_dev {
>>> +	__u32	nr_zones;
>>> +	__u32	mar;
>>> +	__u32	mor;
>>> +	__u32	rrl;
>>> +	__u32	frl;
>>> +	__u16	zoc;
>>> +	__u16	ozcs;
>>> +	__u32	rsv31[2];
>>> +	__u64	rsv63[4];
>>> +};
>>> +
>>>  /**
>>>   * enum blk_zone_action - Zone state transitions managed from user-spa=
ce
>>>   *
>>> @@ -209,5 +221,6 @@ struct blk_zone_mgmt {
>>>  #define BLKCLOSEZONE	_IOW(0x12, 135, struct blk_zone_range)
>>>  #define BLKFINISHZONE	_IOW(0x12, 136, struct blk_zone_range)
>>>  #define BLKMGMTZONE	_IOR(0x12, 137, struct blk_zone_mgmt)
>>> +#define BLKZONEDEVPROP	_IOR(0x12, 138, struct blk_zone_dev)
>>>  #endif /* _UAPI_BLKZONED_H */
>>
>> Nak. These properties can already be retrieved using the nvme ioctl =

>> passthru command and support have also been added to nvme-cli.
>>
> =

> These properties are intended to be consumed by an application, so
> nvme-cli is of not much use. I would also like to avoid sysfs variables.

Why not sysfs ? These are device properties, they can be defined as sysfs d=
evice
attributes. If there is an equivalent for ZBC/ZAC drives, you could even
consider defining them as queue attributes as long as you also patch sd.c, =
but
that may be pushing things too far.

In any case, sysfs seems a much better approach to me as that would be limi=
ted
to the NVMe driver rather than all this additional code in the block layer.

> =

> We can use nvme passthru, but this bypasses the zoned block abstraction.
> Why not representing ZNS features in the standard zoned block API? I am
> happy to iterate on the actual implementation if you have feedback.
> =

> Javier
> =

> =



-- =

Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
