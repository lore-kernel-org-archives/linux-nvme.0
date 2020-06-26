Return-Path: <SRS0=morU=AH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFFBAC433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 12:39:04 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ADEA2078D
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 12:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WdAKmqXu";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nrkz91NE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JF9fb3XT";
	dkim=neutral (0-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="wGIAmrdY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ADEA2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=wu72JvaWU06dhcqmCdTvUv+4DMJfRHmD08IHa278Prg=; b=WdAKmqXutQZ+elCNzJ37SYT3G
	uMj73IjBMknCpIwzB73lApHUO9jbl2hdz4MZsQM9PcV2b4kJcKvU3VeXG/LS/eMrRAR7AQj7ryYvC
	XkxYg2cQSP9CwaBEqRtTjETyxlijEk3banmtPw49VYQFnUsV7dZ9qZf91z+qFdQ//mxq2gyi6W9Zs
	h2fYEO96oPXJhVseVWYJtiGe4dauWtZ5u1pWuxaEUSteR+BQxq/vhUxiIAtb5iGUlUo0Ntjv4sX3z
	i1JNHZoNl2hq6ArHZafe+ogfctz5QFZZAnRsVzqgNEYfh9i4uoo+V64+IpsalcCH1Gpeu8dd+OdWg
	pC6eWOU+A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jond3-0002WT-8s; Fri, 26 Jun 2020 12:38:49 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jolFO-0000z2-9s
 for linux-nvme@merlin.infradead.org; Fri, 26 Jun 2020 10:06:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:References:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:
 Content-ID:Content-Description:In-Reply-To;
 bh=4DaxkXyICe7US2JM85ST3Hsi3Sv8a42hLlx7VW2c8Zk=; b=nrkz91NEf/2fSVyG0dkQ9RT/F8
 I4HNSnT9FBaWNhc2xuW90OmIO6tbOyX3ufKWAs9kuz3FObaLSamA2cYEEDnIfGuxvVc4GRkL6Sivo
 wOoe7Moia5B/oy438DV12I+b7BSPuC53neccQBRlpJVFYTwg2cX9y+LRdqb4ZHcR3LqWBitAXNmF8
 ETxjcZS5mERN7uYyQelmGjZyv/FgJdnbkx4LccmUOtBlVGCv+PNu6OsBe6dqMUkK3N+DqEgQ5Pu1V
 fq/nVpbHs+Zs5ASngldzF6ApUUxKAPPpIqfkiyiYlZIWnHbuYOdDiI3PCEvXBFXpIW5d/4z8Rs29e
 7MPVVjxw==;
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by casper.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jolEe-0004rG-Fw
 for linux-nvme@lists.infradead.org; Fri, 26 Jun 2020 10:06:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593165928; x=1624701928;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=4wnY9jVExZlFGMGWJeRJXFas18H+o0EG3vUtAtDxiYE=;
 b=JF9fb3XTVTUDxD9ke70X558bHX7bYPBd58cco2XQQU3bTCfsuSXc2MLn
 qSWkLMxFxcMg/+ut5Ntd/wjqV9QFZd8XjFTfBvYugzi8QrdihdB6dmPua
 7S61TYnesT6unmYdoMKwIwaTzJnIt2lzngNKxoNd5dJmhRtsKYabqQjv9
 LWNeb6dFzfla6KZ9PVKjFGfMyXIuFzVxuRa9x/UJb0ppR4+r4BluYkjVp
 0yyhVcHfJD3j2kHk/4GGBYj5Up1MfTTGkCtNdr8almWR60LWAjq4ZP5Bn
 rZ8qRSJCoXL/Z3sW3FYERn13vapvVs22Ro2HJZvLuntIKsxB9AgLzh7yx Q==;
IronPort-SDR: 73wv1I9xZV1jePHIUsWLu3eYRalc6wmfR4iQ1V635DJhcqiZ59VIgfotgMTQNkGDzRvE3Vp3CO
 CXXehLKrPDhCYvY83aYIkBibcWWk5HEKGN9P1LZVncwMa2eujIeCNA85iT09pQL50/2yQUWGrN
 4RaLbSbAebPriFyeQ9VttVWX1xtyCpoCev9oQosZzTJ0vfgXQ5faJ3Eqiusxi6rp5pyqQlD91V
 LjHjb3fzfjQIGleLgA2BvNVlKxLn5bNf5BDW2QgdhoMKkgNPEmvvWNkwECJdIwDqrkFzpYJYn/
 OJw=
X-IronPort-AV: E=Sophos;i="5.75,282,1589212800"; d="scan'208";a="250203577"
Received: from mail-mw2nam12lp2044.outbound.protection.outlook.com (HELO
 NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.44])
 by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2020 14:38:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iN+uokCjbSVoLGq/044JLbf+SX8xpFzhR/9vlhAhMIc0klRsb6bdBWTEFidQ+FqmhVfJwwgNNnZoNmrooOpW7KTmLv4jrZ48IXF4xn83cgJ1Bycxzw75kfmEb4YQQ08x0+CULJ27buJriuG0hTwkhkEqod3Fm5EE4q52jMHGO//jSfA1TPIMoJuz7BVwgWvpjYd9pyMlLRDDRkrt+tTgMlVXDYnTeHN7aJ7HR0OeJrRTkt87xt0k92jwNN0N7AQCQkKZdaslQ5Dz+MB/BdUsDj2cZc2ReGyF/EARm7Jlm08uf5gRb2ASHAd2IiO1AfzyVJZQ92GdeAAx3CeTSZY+/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4DaxkXyICe7US2JM85ST3Hsi3Sv8a42hLlx7VW2c8Zk=;
 b=bgJhhDOIl8L9SnksSphCyaXCMAPIk4vM6FZDIk7EBhbfu74e1zO0ai9rNsuA6Z35re1f8GcpElcd+H/BHNGXOi2dF9PqhaV2SVAxsIjwLHMNhnOtiEygIOJApL4cpO6XfRW9Orl3xLZvo+xwdgy7UjV06SCM3yCce3GJojOmELFC1n++grb/NVu95/EFqnDpH7A4qV3wYJ+U4wKHEKTxN2dGt6J2sFW7XGGEk7UoIgepfRXkm0cIQ/RA7HjSrbxviRu/6QBEZwkon2qo78OmadlP3q8LKLo6xOUYXLwooo+BqYbuL1EsF8dVYD2dwmmZOxBzmFuDzuWCZaQ+baMyWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4DaxkXyICe7US2JM85ST3Hsi3Sv8a42hLlx7VW2c8Zk=;
 b=wGIAmrdY97HJc9oNRuYweuH48mfF3D79MtfJfdiC8+glL6LFgS1aJJAZiYjWH8Ve8ljCsvS1AUa/8Hfay0Snqzq+MkL4vy0MwKyyEwmSrr6PyXW+TPw4gAGgrci4Cjz0teQGEDRK6abOeH/bfNfnOZtDFAldrm2AVLk6x0M44Ow=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR0401MB3586.namprd04.prod.outlook.com (2603:10b6:910:8e::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Fri, 26 Jun
 2020 06:38:43 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3131.024; Fri, 26 Jun 2020
 06:38:43 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>
Subject: Re: [PATCH 5/6] block: add zone attr. to zone mgmt IOCTL struct
Thread-Topic: [PATCH 5/6] block: add zone attr. to zone mgmt IOCTL struct
Thread-Index: AQHWSutSdYSwrXPXKEe2iCYs45u1PA==
Date: Fri, 26 Jun 2020 06:38:43 +0000
Message-ID: <CY4PR04MB3751CFFB03844247C3177071E7930@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-6-javier@javigon.com>
 <CY4PR04MB3751FFD1B1D2003B48465C64E7930@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200626060332.erje6ohzmhxzfaj4@mpHalley.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: javigon.com; dkim=none (message not signed)
 header.d=none;javigon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a38b2858-71ee-4679-040d-08d8199b91ef
x-ms-traffictypediagnostic: CY4PR0401MB3586:
x-microsoft-antispam-prvs: <CY4PR0401MB3586549BBED8346CD1BF3684E7930@CY4PR0401MB3586.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0446F0FCE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 52A9MicQj/6uUK05ctGoTOEyjjxPVQHzlep/rM73guEXGew+uLQVFTCDmBC5YvitDcjAllTWklH0JF1t+6lufOQEGf2Zq5rPXjwhz+C/Vu9tiDmNLPJiCy19jzx8S5d/zCm5jDB3R9u1i4+S9jnS6OBOb4oWLKE9nYadQeMaT5xG41BVF6FSVZLgc6XZW/SOSNcj9gV+uRSSOI7PGD7reiS+0TOGA1bSXo/RrYis9UyLsbbyIoz6wrrpX/sA6Kv9NTkDgJJNuZDdt7VbOGp7MjzKAa8wx2hCKGhyhXneyiWv9sAt90Yc3tTnwgTQWROKHYttOMpPuwRT2eGZ1IzGVg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(346002)(366004)(396003)(39860400002)(86362001)(5660300002)(8936002)(6916009)(52536014)(8676002)(66446008)(66476007)(33656002)(64756008)(66556008)(66946007)(76116006)(71200400001)(83380400001)(91956017)(4326008)(26005)(186003)(53546011)(55016002)(9686003)(2906002)(6506007)(7416002)(66574015)(316002)(478600001)(54906003)(7696005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: cziS756kiEy+BS7my8pHfoC2bsUoP11aPJZxSgZBJxu5xyUXxVS80wk39F7839ZdTjH1+A8ubKEGTnk5P7XX1H63j1B2LYytiU+CnJ5Ud0Jf4mk1F5HDWaeyP0+8SIS564SLRJSg9PKWDi7SFvWq9t8dD2YHS6wzwDW9B40eUzjOGpcnMyyYhK/me6e10D3Bs+01dNaFsLML0PufLlgxTOruIJNMp3p/pzDNfc5ub3pqnrxocutFjW4l4L6T/o9H1mpTcLebVybF2bebhPWNf6Dil4nJHm+YAf7h4bhEtBM8mvNw3PzlQIBkmPfHMtKHnVnCcQZg59YolJX8lPHBYZjzPQh4lj2wHi3laoT174oNEY9RQPUeo4elkF1T3mWQdpT2sB2UHgga6fGsnw3L//eOB4ckIkL3y5sex/8lalhqer+v2vSzYI+fEbgPghFAY2KHBht1W7FbRNQp+22lPbroGPb1aHrmpMwL+i+x7En/7CAMFglSIsYTiq25Tlqs
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a38b2858-71ee-4679-040d-08d8199b91ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2020 06:38:43.0731 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pHVxecphG+oWbf3pzMQhmljeort51hdxqF5RsEwYO0ZhzlluxtoXhn3Ii5l0Y+HWzolY4bUFIoglSLMFyNH2Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0401MB3586
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200626_110530_378600_BC142B1E 
X-CRM114-Status: GOOD (  15.79  )
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

On 2020/06/26 15:03, Javier Gonz=E1lez wrote:
> On 26.06.2020 01:45, Damien Le Moal wrote:
>> On 2020/06/25 21:22, Javier Gonz=E1lez wrote:
>>> From: Javier Gonz=E1lez <javier.gonz@samsung.com>
>>>
>>> Add zone attributes field to the blk_zone structure. Use ZNS attributes
>>> as base for zoned block devices in general.
>>>
>>> Signed-off-by: Javier Gonz=E1lez <javier.gonz@samsung.com>
>>> Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
>>> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
>>> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
>>> ---
>>>  drivers/nvme/host/zns.c       |  1 +
>>>  include/uapi/linux/blkzoned.h | 13 ++++++++++++-
>>>  2 files changed, 13 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
>>> index 258d03610cc0..7d8381fe7665 100644
>>> --- a/drivers/nvme/host/zns.c
>>> +++ b/drivers/nvme/host/zns.c
>>> @@ -195,6 +195,7 @@ static int nvme_zone_parse_entry(struct nvme_ns *ns,
>>>  	zone.capacity =3D nvme_lba_to_sect(ns, le64_to_cpu(entry->zcap));
>>>  	zone.start =3D nvme_lba_to_sect(ns, le64_to_cpu(entry->zslba));
>>>  	zone.wp =3D nvme_lba_to_sect(ns, le64_to_cpu(entry->wp));
>>> +	zone.attr =3D entry->za;
>>>
>>>  	return cb(&zone, idx, data);
>>>  }
>>> diff --git a/include/uapi/linux/blkzoned.h b/include/uapi/linux/blkzone=
d.h
>>> index 0c49a4b2ce5d..2e43a00e3425 100644
>>> --- a/include/uapi/linux/blkzoned.h
>>> +++ b/include/uapi/linux/blkzoned.h
>>> @@ -82,6 +82,16 @@ enum blk_zone_report_flags {
>>>  	BLK_ZONE_REP_CAPACITY	=3D (1 << 0),
>>>  };
>>>
>>> +/**
>>> + * Zone Attributes
>>
>> This is a user interface file. Please document the meaning of each attri=
bute.
>>
> =

> Sure.
> =

>>> + */
>>> +enum blk_zone_attr {
>>> +	BLK_ZONE_ATTR_ZFC	=3D 1 << 0,
>>> +	BLK_ZONE_ATTR_FZR	=3D 1 << 1,
>>> +	BLK_ZONE_ATTR_RZR	=3D 1 << 2,
>>> +	BLK_ZONE_ATTR_ZDEV	=3D 1 << 7,
>> These are ZNS specific, right ? Integrating the 2 ZBC/ZAC attributes in =
this
>> list would be nice, namely non_seq and reset. That will imply patching s=
d.c.
>>
> =

> Of course. I will look at non_seq and reset. Any other that should go
> in here?

See ZBC specs. These are the only 2 zone attributes defined.

> =

>>> +};
>>> +
>>>  /**
>>>   * struct blk_zone - Zone descriptor for BLKREPORTZONE ioctl.
>>>   *
>>> @@ -108,7 +118,8 @@ struct blk_zone {
>>>  	__u8	cond;		/* Zone condition */
>>>  	__u8	non_seq;	/* Non-sequential write resources active */
>>>  	__u8	reset;		/* Reset write pointer recommended */
>>> -	__u8	resv[4];
>>> +	__u8	attr;		/* Zone attributes */
>>> +	__u8	resv[3];
>>>  	__u64	capacity;	/* Zone capacity in number of sectors */
>>>  	__u8	reserved[24];
>>>  };
>>>
>>
>> You are missing a BLK_ZONE_REP_ATTR report flag to indicate to the user =
that the
>> attr field is present, used and valid.
>>
>> enum blk_zone_report_flags {
>> 	BLK_ZONE_REP_CAPACITY	=3D (1 << 0),
>> +	BLK_ZONE_REP_ATTR	=3D (1 << 1),
>> };
>>
>> is I think needed.
> =

> Good point. I will add that on a V2.
> =

> Javier
> =



-- =

Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
