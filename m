Return-Path: <SRS0=Wy35=LD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2DF6C47082
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Jun 2021 00:14:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D929610F8
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Jun 2021 00:14:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D929610F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=URZT5nORharPmphe+YY7MsfGn0cMhotYHbZlERNvlj0=; b=OrowqEHkNYqwEn
	utG6Pxl8rmxQny8MsQVVDMLzHy+UU9Vbu71IeqRjCEeChNDRjerY8VOALd4I2RndujKwypBs/9Ri2
	oY99nzrqzSYsMekBh91ckJ1GnHl0mX9Kyp9pTNJ6krkO8flYQO5IPyUOic1gX7wyfQhsKtLgeDlMg
	xSPaTKpfqaWsLa37XXjKP8oPTcFpPNc54kXyjF7Vy3zrsKUEt7U5RT8Rp2MUBtMM3P6KoWmkwOjEJ
	UC9iFHMQwYcOJEciyhFvCGNNTlQzNnxoxHtOl/xw2I7f9on5i60h/eyJiDYat/9FVFvvUqoaA20QX
	dXFVQaewurIgvTsvqGdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqlrL-00AqYe-6H; Wed, 09 Jun 2021 00:14:15 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqlrH-00AqY6-Jb
 for linux-nvme@lists.infradead.org; Wed, 09 Jun 2021 00:14:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623197666; x=1654733666;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Ep97XNHU1GmSQhtBUQ95gM7H3BTQ3v73zGzEmd5hELQ=;
 b=CVd29FhhuKjS+GUx2Z7Ne1P73tvqZFfpDGWvgTw9ZqyPX42RT4Zckys2
 wJpdICOzcTGDdLrq9VbnD4bA0IpMJy+2Og6EWHqtwyi0MqRUHe5q9OD77
 y59dfbwY4BxgLsoPtvFzM1KLkbTyHuHr8UG7tE9ZU4JF2lboLldveyo32
 FPZ6nUxPBERlUaUSO5LOxR2qXGeaDvV5GSj/FaYhX+QRW62XbNsZ1903h
 6nphTibDJdK96aZp62mDCKi4SYKAwvSWDi1ssklV0QFvh/G4i4uBpYq9G
 NrjhwX/xfz56fzOUvfBZTPLs/7VsWuqhFUoeiLa5EhrM1j2/SQ1gXGAjJ Q==;
IronPort-SDR: OqP5vQ2zxj3uCDSPHq6IzYeAEV+Cfb/jzw+y0MLdnHXmkpsO9f6Oum2y/FhGzgfbahc3Prp/VH
 bdR4Bk1a4qtO7nnis2PDLwWcpzFFgUdz96es7XHVRCoAo3UiRRjLrLB5S42K18uqMQOVUvzNfE
 /7dLefJ1Q+5bItF7SrABifUEcq1tYU2jqRQE62pwlVfLwXnnxoSb806eTG7FXMUDyUTdLOkCkn
 DNdWZfdghg69UeCqhRg1UQj089USPSSZNmCPwdklRxFpBYTG37qW7sY9iKnO/d0trQff0G3LmH
 usU=
X-IronPort-AV: E=Sophos;i="5.83,259,1616428800"; d="scan'208";a="275045003"
Received: from mail-bn8nam08lp2043.outbound.protection.outlook.com (HELO
 NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.43])
 by ob1.hgst.iphmx.com with ESMTP; 09 Jun 2021 08:14:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XE+slMVloTFXditM5pCAP0i/UIKNTMV2POGdaBuBND0H0mG7XXrbnmlQPIk0sVlCjPMROgRyTdKk2uJqjb25qIgeyUgf8U6ihq6vjW7s6jHRcSOeRZ+n3w/RVluVFsjJQQb5w94i1EIgup/qTuuYftpIlMdms6SV7BQgKMFezgCdUQgy8EF22xqw29aKiim2D7yoL6OyrQhSL2OuzEySMq0dQ2A7h7sbvv6cJNDHjwwu56rdO+xpTQsMEh3JDEgw2jk91cUtMcjcCNRpmUvoubH4hA739MW4qGCskEVFxnwQLxEm/LaDP3OZn81dxMMHJS00L4tfyh7TO7vInStZ7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ep97XNHU1GmSQhtBUQ95gM7H3BTQ3v73zGzEmd5hELQ=;
 b=J9NMHYhrkOM72ExcNsTwZtuqeqcoTMabT2jEcz5wmbtdku6cplog29oKt/4nzCDhx5t7GzLMRoc5tSWCIAAqlgMsY4P+kOhdaH7OvQuhJKJyclG9z4rZ6BrNrwPH4ZK8UVlt9/StRy3NcYUX+m9YrUq3NyfmvPgLJvM943RdOO5pqxa8Riy7e5M5Xm7RDTf0GozyfCDV6KfeKfqkyuaFy8mIvTWcxrmE7hhdM2LUt3VMtrFkJhhFRM9znN/dFJVVQzDupeNWKY0PNnAoRDcy7dd4n08A8gtx0HsuCi0S5CCXlkIrxg6F5zzvB/acKSKu4MghrIUoC61iccmaqP6cXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ep97XNHU1GmSQhtBUQ95gM7H3BTQ3v73zGzEmd5hELQ=;
 b=gZ/YMkN0FD6ioyhvRhenZwJ8/g/Lv9zGCIw+CCQuUX2rH19E/D8o+IB4tWVLjsBtRFntxuWg/3mSnqQ+diXRUWdv0XXG288Wu7ai4xLAd7vPRrfHPnCiK1V9G5zsllGpnOUYvRkXz/2j6xuYP5RSWhskISlnJtGhoBlhfk29uoU=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5430.namprd04.prod.outlook.com (2603:10b6:a03:c7::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Wed, 9 Jun
 2021 00:14:06 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4219.021; Wed, 9 Jun 2021
 00:14:06 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: kernel test robot <lkp@intel.com>
CC: "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Christoph
 Hellwig <hch@lst.de>
Subject: Re: [linux-nvme:nvme-5.14 27/28] drivers/nvme/host/pci.c:539:7:
 error: implicit declaration of function 'nvme_ctrl_sgl_supported'
Thread-Topic: [linux-nvme:nvme-5.14 27/28] drivers/nvme/host/pci.c:539:7:
 error: implicit declaration of function 'nvme_ctrl_sgl_supported'
Thread-Index: AQHXXK2IrwBz92gihEO5U2lr9CPeVqsKz10t
Date: Wed, 9 Jun 2021 00:14:06 +0000
Message-ID: <E9067936-7A06-4EFF-A4A9-9405612333B6@wdc.com>
References: <202106090556.FQr8aEIa-lkp@intel.com>
In-Reply-To: <202106090556.FQr8aEIa-lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [70.175.137.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b91796e-fd74-4e9d-0357-08d92adb7f03
x-ms-traffictypediagnostic: BYAPR04MB5430:
x-microsoft-antispam-prvs: <BYAPR04MB5430D7526D9B72DE15411F8B86369@BYAPR04MB5430.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:239;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jx1Ie5IpGx6qe56dRV6NzWeAFT6OGY8qLCA47vq/kJRtytNmWkSybTr/4A8yFgVj5Se0caPfe3oXz7Klp6iq4IkspTun+sPARGyI6x0L40698O5nM3C+j694L12xkPB1Ve8tL/3R41J3hAliDV2bqeWyHfbjh3ueDa/0rCn9GTsGt71vOiveEH9a0YsfF7pwJYjnB3H3WJLrZZ6GZXlMEsZdHxjqoQe8HR8i/9FvsAGnfBT2qnABn0Kuvqhvc+n0aIDpaNZMs1ASkk1BpgHTdW7zyUJTyQgS/7Q7GVS8q8UbmII2PSzDP5+6rmyzfALH4VYYsTh5c8Deu1d3hFlFTYo8JiP2lM0B4l8nI45mVCUE1ibRWb2PTm5Ik7jDHp/LZV7yiJiqYAJ1QoTvzDhfRMe9yn4rbg6JOVB1eTnJJ+xfZ/CjDvAA2mCYK1LtguXL3y59332bRPha++V2WWWeGM9EQRDMltWvxq6S/BMzrGF6pq9Tc/GlHP5lBWdS6lHFLxm3BUrzJqp7R6hDhdbGDo8awzFHFVpKgP0QpAf6atv4szqtrol/ytjk1hEt22+WO3isWQnPhPzA+Xh51I4mVvjnNONfc3DJVSi5bG8Dn7O4Hcs/yfL8YYLD+r1jd2XoDpZv18gAWRLgtp7ssNWVpUo+EjSTTcbzF/lXroUhg/9h9KnFKmccVVKQFNfZVg7+IcX3exhCgBSWG+brLDQW3Z9sf2MeMAHnIt6vDL5AlpF6yDzsYyPt8YyEay1eBEcqEHPFgMRPZkIz1gW79FGIWtqYAHQddBiDkRtH/SE97ak=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(396003)(376002)(366004)(4326008)(5660300002)(2906002)(6916009)(54906003)(316002)(6506007)(6486002)(83380400001)(71200400001)(53546011)(122000001)(6512007)(26005)(33656002)(8676002)(36756003)(186003)(2616005)(66946007)(38100700002)(478600001)(8936002)(66476007)(66446008)(76116006)(64756008)(66556008)(86362001)(966005)(45980500001)(1758585002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UURIRW9rZDJCUS92am9BUVlWM2pKUDRjYnJtNitJMzl2aWR6aDFHSDdwYVFj?=
 =?utf-8?B?aGZwVDBscEVFNngvYnN1OU45aFZpMmlzby96b2xXbXl6RUZmSjJRaExBZlkx?=
 =?utf-8?B?cmprMjkzdEtnaThmQldJamJwSXZKdVIxbnA2T2tlSTRZdHh0WHcrUzJGK3pJ?=
 =?utf-8?B?T1VwSFNQMWdWRDAyMHFyRlMvdzIySmNINHFDcnlNaEZYR05xTTNaM29INU1I?=
 =?utf-8?B?MEIyTklOaDg0RTZZZlhkYTBIYkY1SDN0bFR6UjNjd3FIcEFjbnJxZXNoNGVn?=
 =?utf-8?B?cVA0bGp5ZnkyLzRjOERYTjNTbG5uTTgxTnU1OWNyM2dPdysvaFMxdzdpNFY1?=
 =?utf-8?B?dEJ6T2JoL1RKRTNPeGMyWDFaczlrTEZBeGZTY0RBR0hXNjBHNnk5elRFd2N6?=
 =?utf-8?B?QXlURER2dDFFTjdPU3FwYWxucjludXZ3ekI4OU5UY2pSckVqOFBjKzN3T0dS?=
 =?utf-8?B?aVJtTGxXRlc4dE9uejRJem85Y0x2cW1tOENTa211K2ZlYk93Qkd1RjdEbVpu?=
 =?utf-8?B?WmtYbGc0czNORTlqaitXZnJTWGpsaW1GTCtBSGhITWkyR2poRXdaeW9XcVFF?=
 =?utf-8?B?S0dsN1lCTXNNa1RiV1VDYTdhRzU0U3BKMENmOFFyM2JQcU8yZDcvWG03eFQ1?=
 =?utf-8?B?QW5MTTMwVFRCM3ZvZFdjQ3NGNEV4WFFrQVhkMnhMdmlSV0NpUWJMMFh3Ty9U?=
 =?utf-8?B?aXRYTU9jMzJuTHJWZEs1aTF6N0lNVW1oOTJheFZHT2FlUUcxcmd3Y0hDa0Z0?=
 =?utf-8?B?UW9XWjBiZXYwSHgvdC9UZXZmNHpZVWUyd3JHaStzbmhUeW1kOFhsL3hZRUNT?=
 =?utf-8?B?TWFjcnZBaDYya2ZTTkNoM0pENkFvV2Qyd2xVTlJMOWNYYktVdG1KRExkczdm?=
 =?utf-8?B?M1B4eHlIYXhzbENKWFM2Rk10anJ6cnRvb0pPT3hnTFptNnpZSUIydThNOHUw?=
 =?utf-8?B?cVdKa3RVazFwSVkrMEFNaC9yVkI0NkpJdSt5U1V4Z0NyRUkzMEx3SFdzclgw?=
 =?utf-8?B?UHB6RmFrNzJvY0N1cS9zT2RabFJXL0pIcFVaOGh5M3VIcEJXNjJ6a0krVm9o?=
 =?utf-8?B?d0FZL0k4Z1VCTy9lRlFsYU9ML1kyY1BSdFlZZ0pKODAvT2NKOGpacUk3TDB3?=
 =?utf-8?B?NVVQRlNUUnpPTndXKzk2T0VQN005aG9tLzUwb1c2S2l3WUVwM29lMmxsNGpY?=
 =?utf-8?B?cFB0ZmFrcEdxRG9JclF1UmR6RExNMTZaZzhqNENrUnMrNC9YY3ptcTFqYldp?=
 =?utf-8?B?L0tWOVNFVFB5WGtOeWJmdlJUek1UUVdSdzJzTjZLejVHUDBBakVvUzNyRUsz?=
 =?utf-8?B?VUZDVkJsRnAvZ1haOWEvcWptUUg0WDVaelNTeW10VFJEcW5FQ1hoZzVTU2Ro?=
 =?utf-8?B?SnY1emR1aEk3SjE5cjQxL3ppUUtVZmRRVkhBSUNtd1d3UHIrSldjZm10SSsr?=
 =?utf-8?B?emVDTi81c3RuWm5JcGZEUXBNWFdUSmVIWFlkUThSMWpONEdoRDl4a0lCQnBS?=
 =?utf-8?B?RERYQzNuTDNESWtsV09MSVlpaHRWZVRZS0J1cWIrMkpFYW5STGJzTHVJQW1F?=
 =?utf-8?B?ZHRDUWlBOVZ4d3RwWWl0dFllTWRtUFBuUFk1aytZa3ZpamY5NVRKWTRnOXhS?=
 =?utf-8?B?R1BpcGJpKyt6Y3N0UWdTVEJ6b292ckRLclVRYWRjd1dQV0ViUlpEWVhFbFMx?=
 =?utf-8?B?cU1XdlcyNSt4NDMzRWVlbzFELzFveTZkelJ5MWRDTi9pWTNYOFFjOCtJWTVj?=
 =?utf-8?Q?ibhgCmXNmwXUn+zEpLDglBU684MrqPtfez6J6wK?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b91796e-fd74-4e9d-0357-08d92adb7f03
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2021 00:14:06.4765 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gi2VjVOzaT+WwwNshadEAC6WpmGcfVRjC2N84qnCdYmQkl05+OfZGdr+0FECadD6RDDxegGuqR8AZBD0tK+QaGNax0onSJ92ecLo38tsN6o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5430
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210608_171411_797790_27AF4F96 
X-CRM114-Status: GOOD (  21.01  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

DQo+IE9uIEp1biA4LCAyMDIxLCBhdCAyOjMwIFBNLCBrZXJuZWwgdGVzdCByb2JvdCA8bGtwQGlu
dGVsLmNvbT4gd3JvdGU6DQo+IA0KPiDvu790cmVlOiAgIGdpdDovL2dpdC5pbmZyYWRlYWQub3Jn
L252bWUuZ2l0IG52bWUtNS4xNA0KPiBoZWFkOiAgIGIwMzg2ZWIxNjcxMzRkOTU4ZjE4NzZhMWE3
ZTM5ZTExMzM4NWM1MTYNCj4gY29tbWl0OiBhODU0YzVlYjRlOTU5ZjBkZmM2ZTFjMjJiNTExMjhh
YzY4YmMwNTFjIFsyNy8yOF0gbnZtZS1wY2k6IHVzZSBoZWxwZXIgZm9yIGN0cmwgc2dsIGNoZWNr
DQo+IGNvbmZpZzogc3BhcmMtcmFuZGNvbmZpZy1yMDI0LTIwMjEwNjA4IChhdHRhY2hlZCBhcyAu
Y29uZmlnKQ0KPiBjb21waWxlcjogc3BhcmMtbGludXgtZ2NjIChHQ0MpIDkuMy4wDQo+IHJlcHJv
ZHVjZSAodGhpcyBpcyBhIFc9MSBidWlsZCk6DQo+ICAgICAgICB3Z2V0IGh0dHBzOi8vcmF3Lmdp
dGh1YnVzZXJjb250ZW50LmNvbS9pbnRlbC9sa3AtdGVzdHMvbWFzdGVyL3NiaW4vbWFrZS5jcm9z
cyAtTyB+L2Jpbi9tYWtlLmNyb3NzDQo+ICAgICAgICBjaG1vZCAreCB+L2Jpbi9tYWtlLmNyb3Nz
DQo+ICAgICAgICBnaXQgcmVtb3RlIGFkZCBsaW51eC1udm1lIGdpdDovL2dpdC5pbmZyYWRlYWQu
b3JnL252bWUuZ2l0DQo+ICAgICAgICBnaXQgZmV0Y2ggLS1uby10YWdzIGxpbnV4LW52bWUgbnZt
ZS01LjE0DQo+ICAgICAgICBnaXQgY2hlY2tvdXQgYTg1NGM1ZWI0ZTk1OWYwZGZjNmUxYzIyYjUx
MTI4YWM2OGJjMDUxYw0KPiAgICAgICAgIyBzYXZlIHRoZSBhdHRhY2hlZCAuY29uZmlnIHRvIGxp
bnV4IGJ1aWxkIHRyZWUNCj4gICAgICAgIENPTVBJTEVSX0lOU1RBTExfUEFUSD0kSE9NRS8wZGF5
IENPTVBJTEVSPWdjYy05LjMuMCBtYWtlLmNyb3NzIEFSQ0g9c3BhcmMgDQo+IA0KPiBJZiB5b3Ug
Zml4IHRoZSBpc3N1ZSwga2luZGx5IGFkZCBmb2xsb3dpbmcgdGFnIGFzIGFwcHJvcHJpYXRlDQo+
IFJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT4NCj4gDQo+IEFs
bCBlcnJvcnMgKG5ldyBvbmVzIHByZWZpeGVkIGJ5ID4+KToNCj4gDQo+ICAgZHJpdmVycy9udm1l
L2hvc3QvcGNpLmM6IEluIGZ1bmN0aW9uICdudm1lX3BjaV91c2Vfc2dscyc6DQo+Pj4gZHJpdmVy
cy9udm1lL2hvc3QvcGNpLmM6NTM5Ojc6IGVycm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBm
dW5jdGlvbiAnbnZtZV9jdHJsX3NnbF9zdXBwb3J0ZWQnIFstV2Vycm9yPWltcGxpY2l0LWZ1bmN0
aW9uLWRlY2xhcmF0aW9uXQ0KPiAgICAgNTM5IHwgIGlmICghbnZtZV9jdHJsX3NnbF9zdXBwb3J0
ZWQoJmRldi0+Y3RybCkpDQo+ICAgICAgICAgfCAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+
fg0KPiAgIGNjMTogc29tZSB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycw0KPiANCj4g
DQo+IHZpbSArL252bWVfY3RybF9zZ2xfc3VwcG9ydGVkICs1MzkgZHJpdmVycy9udm1lL2hvc3Qv
cGNpLmMNCj4gDQo+ICAgNTMwICAgIA0KPiAgIDUzMSAgICBzdGF0aWMgaW5saW5lIGJvb2wgbnZt
ZV9wY2lfdXNlX3NnbHMoc3RydWN0IG52bWVfZGV2ICpkZXYsIHN0cnVjdCByZXF1ZXN0ICpyZXEp
DQo+ICAgNTMyICAgIHsNCj4gICA1MzMgICAgICAgIHN0cnVjdCBudm1lX2lvZCAqaW9kID0gYmxr
X21xX3JxX3RvX3BkdShyZXEpOw0KPiAgIDUzNCAgICAgICAgaW50IG5zZWcgPSBibGtfcnFfbnJf
cGh5c19zZWdtZW50cyhyZXEpOw0KPiAgIDUzNSAgICAgICAgdW5zaWduZWQgaW50IGF2Z19zZWdf
c2l6ZTsNCj4gICA1MzYgICAgDQo+ICAgNTM3ICAgICAgICBhdmdfc2VnX3NpemUgPSBESVZfUk9V
TkRfVVAoYmxrX3JxX3BheWxvYWRfYnl0ZXMocmVxKSwgbnNlZyk7DQo+ICAgNTM4ICAgIA0KPj4g
NTM5ICAgICAgICBpZiAoIW52bWVfY3RybF9zZ2xfc3VwcG9ydGVkKCZkZXYtPmN0cmwpKQ0KPiAg
IDU0MCAgICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4gICA1NDEgICAgICAgIGlmICghaW9kLT5u
dm1lcS0+cWlkKQ0KPiAgIDU0MiAgICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4gICA1NDMgICAg
ICAgIGlmICghc2dsX3RocmVzaG9sZCB8fCBhdmdfc2VnX3NpemUgPCBzZ2xfdGhyZXNob2xkKQ0K
PiAgIDU0NCAgICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4gICA1NDUgICAgICAgIHJldHVybiB0
cnVlOw0KPiAgIDU0NiAgICB9DQo+ICAgNTQ3ICAgIA0KPiANCj4gLS0tDQo+IDAtREFZIENJIEtl
cm5lbCBUZXN0IFNlcnZpY2UsIEludGVsIENvcnBvcmF0aW9uDQo+IGh0dHBzOi8vbGlzdHMuMDEu
b3JnL2h5cGVya2l0dHkvbGlzdC9rYnVpbGQtYWxsQGxpc3RzLjAxLm9yZw0KPiA8LmNvbmZpZy5n
ej4NCg0KDQpUaGUgcGF0Y2hlcyB0byBmaXggdGhpcyBhcmUgYWxyZWFkeSBzZW50Lg0KDQoNCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUg
bWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
