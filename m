Return-Path: <SRS0=zNed=5Y=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B9AC2BA2B
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Apr 2020 23:28:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5BF020857
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Apr 2020 23:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pbHMAI/g";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BYLOXDh7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="earSBkW2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5BF020857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=Hzpo/C0n2Nf+975Xvt4SmMzrtpbbFgvpaSmCwAZolEQ=; b=pbHMAI/gTWGXyq
	30cdrxYd4abv5SeArhewA7PCjSiyW4NvhwR+FpxeWTf62+At++sYLAnwLc1e5ysd0hiO1ufNC0bkb
	NVtsILx0t4EtTWPr/k1CTd33UD0++Dkc+pbeatySIk7gGthsJS+GPuG5+kvuKKd8IXswxHHC25PTM
	jRk+l70A8tzcF3xsYayuFoHivIEq7H5sFrSTSht1c4sT6cJ5gmKLE7C9Oylgm5aMavCm6+1utLK1O
	UCgNGlDwpxrNfjiMhuPKhrAUd9/4NscK8DgvCAjof+s2OfhDrEU0jT5AVFTfwS71Q6JZA8TElhACw
	uSvJIsfSmZmDngvIEEZw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jMK7E-00010a-AH; Wed, 08 Apr 2020 23:28:16 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jMK7B-00010A-9W
 for linux-nvme@lists.infradead.org; Wed, 08 Apr 2020 23:28:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1586388494; x=1617924494;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=tQgTBkDo25R9zLhAO3eVzcfdHpif7RLGi8KVY7DgmZw=;
 b=BYLOXDh7mMQkG9mV/m89Jb+Yzc0xsQomcdyU++1c8iIIy2fXR1LipxxB
 KWmkkND43xMwztNqXyvyaecLLde4dvt/ia73O0xtK5WTh1db5fBLgFnGE
 KVALMsPVWkwzLyvvYR07RwJvknwn07v/LtuABPGkfMOHOVrdGfwmHIrwY
 6FACtkkQ113eDsvXNFhlt0yeEOxLQZiIGcrvHCy26atklGwozaw9uh9En
 zK/RkR1Xz2+LXqwnUeWQKWnh6GG/it198kE+YEV51mvIC7SzttkC914wi
 Nn98IIYPRMStvUn+wkvBu4fre2L58tmAieYi5keOgHBGH/BTUWhtAfSmo g==;
IronPort-SDR: /rPdsZ85LQEcw2IoxveHDhItLsdk7aDMhHNTwnOKlH2ZZHe741rWDAtpImRaiwxHUMsmIip8OE
 BVT19TnetHGchnc5TbAPMlY1LNAH+pphpJkGjOphvDNZOLmY2tR7MpwOCDi00E0TWuSK8v+C55
 C41CtFZEgfZtS0S9E204MBNym7YIQr6y0TLgSSWCwuQUy1hBGg+Qsa1iCvjux8nlfLPEHhIOoY
 NrD9tHEYb4TDbx847qQIIkTBBUtNtKx/exdziT6x3efcdemWWLoBJy0BpGRMcgCxVnRqWeua0n
 Do8=
X-IronPort-AV: E=Sophos;i="5.72,360,1580745600"; d="scan'208";a="135226952"
Received: from mail-dm6nam11lp2173.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.173])
 by ob1.hgst.iphmx.com with ESMTP; 09 Apr 2020 07:28:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TmsYLPuzSdIM4iAzkztxXSS97xcGgXCIXxE2snGxD1hRNiA/9razTsE1hbgonZ8nhLUZ+YPdhR5Gk3SsyzH0lB/2HrXyzIfpkAuhLGwGz9GXfPOAbcmSRh7u9QoCeQJ6kD/hMejCtHk9M53LA3h8HydvRFKeUBHlA/V4K9f5vYkjg/z/A21tHHzWfDca1iusss/w/ZLqjyNj62MTHHmQp0IoKwYzpUmllXgYbfx48RqzwihM8NNZ/Jcv8TyNy7HSRKgz+xCyGsRRLC+vf4CDDSYTNP4IDMHZpWVUzV6iRDibcf1PmcY0snE41H5c1NoFwxtLeeLS/id3yUcPXxVigQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQgTBkDo25R9zLhAO3eVzcfdHpif7RLGi8KVY7DgmZw=;
 b=KTiVNE+FYTRL7hn/KSQSRYMiAUt22SeotZdkhUOxiDm5kYFsdT1xnV9G86axhy3egkZWqX0cUEKnA+gWJLVMydsRgxxZwwRm6H3jRcZ5qB2Mw7hICMbSbVZmNhKT6xqTxcGVoIyhNZwmDLiIxXsfj/LhQXR9P9RIQFozGUehs18ngb87ANA+sO5jdOhUwEgl2A29gV0maUXDcLcMRbG+AUD6BLzVtJeGU1Sfyyc3gBCDvDLWlJCWLFN7eX+tAL++dcNgkoDXWvtiXZpyxpaH6inDXpGSzvoy5jidCD/rKSMqECz5MfP63GV+wtzb3m0jTFzUWqyvZXUnJjoY3nWAqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQgTBkDo25R9zLhAO3eVzcfdHpif7RLGi8KVY7DgmZw=;
 b=earSBkW2PqjoZ9CzIbIuyLiwa9gBfB82eZmqD7pd3/f12NAywI6mGgNU/Vv32JynwWwM1C1UHBSYGcMVkw4pwB0MPs1k03hwdZo2ZP2EB3rxASXrqVZs5lvB4FFc+TxbvqTHlInnCnxD9R1atMTTAeXE8snlzHlCBshRKdSAz1w=
Received: from DM6PR04MB4972.namprd04.prod.outlook.com (2603:10b6:5:fc::10) by
 DM6PR04MB5963.namprd04.prod.outlook.com (2603:10b6:5:127::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.16; Wed, 8 Apr 2020 23:28:01 +0000
Received: from DM6PR04MB4972.namprd04.prod.outlook.com
 ([fe80::6c49:dd56:97c3:3ae]) by DM6PR04MB4972.namprd04.prod.outlook.com
 ([fe80::6c49:dd56:97c3:3ae%6]) with mapi id 15.20.2878.017; Wed, 8 Apr 2020
 23:28:01 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Anthony Iliopoulos <ailiop@suse.com>
Subject: Re: [PATCH V2 2/2] nvmet: add per ns thread to generate AEN
Thread-Topic: [PATCH V2 2/2] nvmet: add per ns thread to generate AEN
Thread-Index: AQHWDVyGx1h1rDwyCECcI/Bh3Diljg==
Date: Wed, 8 Apr 2020 23:28:01 +0000
Message-ID: <DM6PR04MB4972225DA024170AF54CFE0086C00@DM6PR04MB4972.namprd04.prod.outlook.com>
References: <20200408041633.20632-1-chaitanya.kulkarni@wdc.com>
 <20200408041633.20632-3-chaitanya.kulkarni@wdc.com>
 <5e54afaa-7de5-a89e-5740-88df15c52bba@grimberg.me>
 <20200408095500.GD1329@technoir>
 <SN6PR04MB4973222BC905A09B9CA0E55586C00@SN6PR04MB4973.namprd04.prod.outlook.com>
 <20200408170820.GE1329@technoir>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1370d38c-6ee0-4e2d-fa29-08d7dc147acd
x-ms-traffictypediagnostic: DM6PR04MB5963:
x-microsoft-antispam-prvs: <DM6PR04MB59632F1C4928CAD5637B779A86C00@DM6PR04MB5963.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0367A50BB1
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB4972.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(39850400004)(136003)(376002)(346002)(396003)(366004)(6506007)(8676002)(66556008)(2906002)(5660300002)(4326008)(316002)(71200400001)(33656002)(4744005)(8936002)(53546011)(54906003)(81166007)(86362001)(64756008)(66446008)(7696005)(66476007)(6916009)(186003)(91956017)(26005)(55016002)(66946007)(81156014)(9686003)(76116006)(478600001)(52536014);
 DIR:OUT; SFP:1102; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i6JzpJqrGmzEAzSxDCWiGt9tkv6eLuTqJczhydhIrZktjx1VqK0MuEPkR7nGQz2YO0h3Wyb3puXFc6pAhRl338MsMT/OJe4CX1JRUYdvtp/d2Z50bVBHHlMObHBG+YwRmZNjrSm3cI2WjKaYuSkSG/Wmy0zjPqc8zQi7/8xNMaFxH2uTnY2FR2b/fgZZW9Lgvj9dDl0RttZCQPhFr4hsgLtUjB6EkOTzqyL36C4htxVR8mTwWgiUA7AoEVFJDWQ0yaBVAoIVUrcxM6qAttaO9AHaCMWN/4EStpHn6lwi8loLhd7/QwrVg1syF5CiiU49cd7kG+4mr+EYSxx/tXNFlKzIqh3Hv6BLDiQNMMmC9P0yLeMqCrn3v1iT/7qEqyaKMIfvqh+7AmKGv2fQ5aewSQqgKC7bUGTloIxtXDMcMqZSvy2EoXU+U2Mydklt5uL8
x-ms-exchange-antispam-messagedata: omEZ7WkEgIc1GcvXHGSgpj1C6tny9ECjngHyy/Q1d/TSlYP6y7F/9NoW4B8cOF9IZg/6xTo/oADaw5CJicJhtYwjXqxNs+CAoCMrenqh/pKz0u3BCBcazlpyfroyLckedieHt6ux8P/+aQtiXvYM/w==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1370d38c-6ee0-4e2d-fa29-08d7dc147acd
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2020 23:28:01.3370 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bGdAsQuDiWl4luUGYpOz89oVvymiMLHCgkjKSQ+9YjudBr3FRa3Fe5bJw1txzGUtrK5PbdJ9264cQO67b/TysO53mlApQvABaS0fywPCut0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5963
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200408_162813_343461_9880216A 
X-CRM114-Status: UNSURE (   8.51  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 04/08/2020 10:08 AM, Anthony Iliopoulos wrote:
> Sure, but please note that this doesn't cover all use-cases, notably the
> bdev-over-loopback example that I mentioned (truncate on the file that
> backs loopback won't be reflected to its bdev w/o losetup -c, so the
> maintenance thread will never pick up any change). Are there any
> scenarios using non-loopback-based backing bdevs that admit resizing?

Not that I'm aware of, if anyone is please let me know.

Regarding loopback, are you saying that on the target side you are
using loop device backed by the file as a namespace device_path ?

Can you please describe the use case for loopback ?




_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
