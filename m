Return-Path: <SRS0=ohfr=AA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF1EC433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jun 2020 07:43:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D2C62073E
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jun 2020 07:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ji7cYTNB";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="V59yoAKS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="dAgSa5jl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D2C62073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=/XnqYShzbWlHJ46dknzGMYQcGkp3gt2rrMsFgxhnyuA=; b=ji7cYTNB0fKp48
	/dJ8I/wxGDjXLf5eyIgUI1ltrLKnWp4aKQ6lu+3up0MsulnFv1n+DMHdw9fjSqDVyxy+ypDHmE1Jf
	tlyMDOlIW4fSBpyr18jnGv8hm74fT//4eEezzbTgeVYjxB9/x/NUf0t6awnSRV20qF7cEsSWfpWpO
	5DpRK/2YaDfZwtJJIKuoq/oZt4J4EvPaHWsBDZrXTdOl5+AINcH5aoMbGpLK39CDjOLeDQoxywleM
	KUijRRUHQyk9EstcJVr8ITQEr/3BbRBXQDUXtp9OjHE0ZDr6P91y7URxsHHRlGF1RArbkqMZuUEdW
	HhER6GUKuU5ymE34R+5g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jmBgg-0005zw-GO; Fri, 19 Jun 2020 07:43:46 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jmBgd-0005zc-Jv
 for linux-nvme@lists.infradead.org; Fri, 19 Jun 2020 07:43:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592552623; x=1624088623;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=syndOrZM3SW0Ky8ig9nPG18n5CfsPXM8ky9jSYSLwfA=;
 b=V59yoAKSkzD2AVJ07vqIc7ix/XSrkVd/DqCYBznnE17lHJzSCoN88z69
 z5jTRGqg7iMB1PLJgK6tH0IGe+AszS44qiRvV5TRxepqXW+dEFaHufBei
 fCBlUb+liwPC4BIHZDqGKnYC5+hH7ESXMjd7RLlplPf92qs4R00ywiIF2
 sxEF7VRpMwth0kN5D5sFFwwWIRm5qJsxJ+hIxIlLdFj5W2Hb+77OPAA6Y
 1D6KjxDzbquNV4eht0ikyTM9D0iDLDfKGfOO18wpKn6z6ayWkM4PduWDJ
 IfpEm5R3z5AEE0WHF0fHQKuChfNlzgTu2eYo1Kigt6wHI2TVDjfvL8YDM A==;
IronPort-SDR: o0pkqRRQ40frrwjb/EBL1WkAXdx3Vlqk2HtdKb6Pqilvp7IIefPZ+sqY8ekCr8i4/hdWmsGV1v
 66Cepm5VwGlFQgBAypJqK424QckILHSQKfQ548y9rAhTALbn05W8zI0/xoHpKT8jq68NrD6/fN
 VXmYVwu1+k56k8CWe+oRW9bdLLZlCrDa8R5K5Jvom30SLxK4wb/pK+0A+HyjtcIVdJLHWoJVjV
 8GrgsSY6f40A5dUabNclkZUlJ+GyKiEF44aoOyfZDVb2FILdjH8xZUlU/8lktCLVoBdqmlu8R3
 E64=
X-IronPort-AV: E=Sophos;i="5.75,254,1589212800"; d="scan'208";a="140408005"
Received: from mail-co1nam11lp2173.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.173])
 by ob1.hgst.iphmx.com with ESMTP; 19 Jun 2020 15:43:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WALb9uDYddM28VrJIgLUYfzzAdZa8deo01HcqhDgKyTkp11M/9Fij/ygPI+d3FQazEOsO03PgJelSYBZPpKZtSKRKeyTPafFT9pporePZg34XzCeU35MWmFJAh0y1NVnI2uSZI200y67Db4QQkFu40mV388hDgf0rX6WKsVTqd0NcyBSh0aZ+blBz1YAdhZIHU6jrVgaWlHS4yvPgW2ekVotAlgMD+hM02cy5XFlBieTbjYQkAo4uYM9px6/AvB71+aw/IVzWopSH7VsfZPVoVvsyNBE+aMA9Xsi6uhGpKuASAsKnbZfRYbdN5fNgHX3Ft4oQ+ewCAscxn1/cpBSQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=syndOrZM3SW0Ky8ig9nPG18n5CfsPXM8ky9jSYSLwfA=;
 b=dxXI+2Zehw0RwJiMP458hpPV/uZUkFoA2mdQJ3DBfKNW/AkSvRdpIZ2kzOQ0KpU9LKXQV4CQmHauBxC7xESqxASsMPf4LE79rjF4NxBPOebpS30p4v0cWUMnJ7u6ajneGj4R77jCDB7n5X+FkYGlGFSE2X0nPfONV0XJ3nGPpsIEyGKtwPVJNh/gdwCbSXQB4UDQMssAesdwqnx7FnXPStk+6AWppvfd76TnlZEVyzlQAlLQxpTc1QnPQRRLy+PpZajz7nwtQWlc2cCgezds/pHyYF3/qyaS1YKK2rAzgJOVhn91PqosaQswzrT0YgVi7NiHAwo3vVw4ztrRWKKZAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=syndOrZM3SW0Ky8ig9nPG18n5CfsPXM8ky9jSYSLwfA=;
 b=dAgSa5jl2+HnoPXWS1ICtM8CLRjzhD9SZ75CBsgcUOg4kMRZMwjm+r35uS70k1+PDIlz2gjbRhsFQOHbMkbEUcoo0gntSjcF9TXiRy9FVT7wrSzVfnPhsJsx3ex5xWQCG3meoqyBpnz4DO6N9Can38tlnCtfDjp9VkW5yE4ylx0=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3520.namprd04.prod.outlook.com
 (2603:10b6:803:4e::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Fri, 19 Jun
 2020 07:43:37 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3088.028; Fri, 19 Jun 2020
 07:43:37 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: =?iso-8859-1?Q?Matias_Bj=F8rling?= <mb@lightnvm.io>, Keith Busch
 <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me"
 <sagi@grimberg.me>
Subject: Re: [PATCHv2 4/5] nvme: support for multi-command set effects
Thread-Topic: [PATCHv2 4/5] nvme: support for multi-command set effects
Thread-Index: AQHWRYBY6dkcvfj5QEOv6Tpz1l2QgQ==
Date: Fri, 19 Jun 2020 07:43:37 +0000
Message-ID: <SN4PR0401MB359884F5470C0812E7EFE3279B980@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200618145354.1139350-1-kbusch@kernel.org>
 <20200618145354.1139350-5-kbusch@kernel.org>
 <c8c285ee-6c49-810f-c029-eebdac7bcd72@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lightnvm.io; dkim=none (message not signed)
 header.d=none;lightnvm.io; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1597:de01:50b:1cf3:953b:431c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d122eeac-e5f4-45a3-2990-08d814247a17
x-ms-traffictypediagnostic: SN4PR0401MB3520:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB35208FFA263A2B43719CC64D9B980@SN4PR0401MB3520.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 0439571D1D
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XFm5zEfBLsESvzJNtyv3/Y69cHnwICWOsbGxNldGrJD3VCsihwih7oSDYVEWmr57yYYWspBOjQ7e5oofAwS+MqjUkqaPvRv2CgheYKm7huqVjao47j0EGYNcaZj7a+7UGGiQ5mhnin/oMHd3PxPcOppVT77lzW2rtda46naiOXxJjonicApPxxoz3qcU4nGt1fwx3hYESn41VGlwke6ede5MLQkfyLeHxPyqTGoKcWcyJGhB8jYXZQ6CTpINwA9FA1ZdfLsUQQVYhYsbMObtApczRre6DLxcOynK9xXWKp8WlEsL/zxY3e/6WXAziBkIyQJB8OtEB3kMvEDop9Z/uQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN4PR0401MB3598.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(55016002)(4326008)(6506007)(53546011)(54906003)(558084003)(2906002)(186003)(7696005)(316002)(8936002)(86362001)(5660300002)(33656002)(66476007)(66946007)(76116006)(64756008)(8676002)(66556008)(66446008)(91956017)(9686003)(71200400001)(110136005)(52536014)(478600001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 4LwfZBQwgWV18HxtplNBRVs0092ipnoQbr+1k/5kMFSmxc8Y28JbLK74OnrARUjJU2UcbZB7+h6pLcIPRtGw5kotL3fKghuVLQBgqdxhVs7f+xTL7yUWayCuwoL8BCti4vYmAUOM/nAbsRqUuDT1lZeq9kfwqHhCpReo3eXT1kdiLto9htHzga+ThB+6Q9tGjL/mYYgkoLcUpSBbLzOlNiDsx198lsNrP/AGRB9HUJteOqoyQNlcxlNg5UvDz6vKQB5w1yXVf7Lylvl6o99d8+J80h0vljMZ0xNST6B3ippu7j2WTelNorgD4uqmIg1PTzHI8AUPPNVYlFqn0H4ymWagpqggxAg7RNkqSW5HsUkz4ljpeNTFPsPAOCb85Ho1jyV1BpkNI79DAXiXLssXrdByyvSdjoUHOaL7fPJDcvE6WPQSY2uSIX1Rr78L3p49QzaQWUR29q27sMMCi58XSUIIPx/tFbX3tVOXPR5WIsExHA7xZu6v7cj+/mE0hb5c7xwhdbH3q/0Y+E1Ud4GQtgzEFbcjFCSZfRhwNT4zAVqEB3ogiCnTa8nyoyJVsiOv
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d122eeac-e5f4-45a3-2990-08d814247a17
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2020 07:43:37.1592 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3gjY2aLfcm5DL3xFmzCKV3ZHopKjhe8DpZqQdsgPNfXJlvMN3IjTVuk8P9EviJwcx3ue8zGNrM6KnNQADFMnyg+o1u8QrlFTIi17CheJtdo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3520
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200619_004343_747986_1C8D6EA1 
X-CRM114-Status: UNSURE (   6.78  )
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
 =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier.gonz@samsung.com>, "Martin K .
 Petersen" <martin.petersen@oracle.com>, Keith Busch <Keith.Busch@wdc.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 18/06/2020 23:09, Matias Bj=F8rling wrote:
> Johannes caught the double newline.

Oh you hid that on purpose to check if people are reviewing *scnr*

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
