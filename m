Return-Path: <SRS0=0To6=77=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D22C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jun 2020 18:59:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A399C207DD
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jun 2020 18:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UL4E/u+a";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BMkvM0rQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="DRlf6K2O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A399C207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=ElWTH+EF1jjHHivQgUHEwqCvzmMEhFOjZdiTNbRmiXU=; b=UL4E/u+aKhIR0m
	WCYFi2oDRA2LM5V1PPvQeIvQ+jstai7MGxQxRy50Yv5icatxJaivUCf1COlsOl60LpByBVe2N1dA7
	i9MhWehGJ9B0GAvldmfjFAAwerT1Zt8LO4hQ4a6TlvH+fpAjpLLqeqrl0lVgAsFQT8V5etXbiZBqH
	38al0ZnecAzKHAuxUuCJLAVFhu6lpVi6EiZEKze7wmg0ur6UnJgTsUWvEorAL40xlvUsv7dCkzZko
	1+qtC+8CGlwMrNDS5IXhXi+YHd0bNOwIumgxaJXx6rl2hjAwvAB5CbZ+vzJSmrYzGHmvJVJC8m1lb
	ka1fnZv8BlbVh1Bj1X3A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jlzlA-0007OU-CS; Thu, 18 Jun 2020 18:59:36 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jlzl8-0007Nr-Fv
 for linux-nvme@lists.infradead.org; Thu, 18 Jun 2020 18:59:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592506774; x=1624042774;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=BMkvM0rQYtVs0j9XqF7bKLpXPQw0N+tZQwXitkySJuwxk6eA+OpnlBJI
 Qcd8O2GpMw2SlOymXdnwIGgkPdFRvePxzdnU5BoiPLc+5lGVnEXof8Bu5
 jVHKX000cpoPCzeRC/1eBwRkn+yLVfv2yso0Dr1SA2RYMOF+xvHb8ioEa
 zmRgQq3bGtTSeMWGk24Xx1+DByhrWfPst1kuXhzKkF9TD/PwV6X9lK5m8
 77ZR8hXRJ0vsq4I+YJw3plpU/4b/RjCGul5V1WAUZiT/FAe5p+7oPJnSD
 iRMiyWQpm3sh4/tMd572UhXIv6NbMmOV08xhZ1dUOjBaf84e32MUFEjk0 A==;
IronPort-SDR: hJSAbbzYyex10359H8I2Y3fiuuDjib2QpdkFvo7JkB5jlLfHUmmKULBmRPBg8QadduXrbRvq+x
 u0/oILFhCYRNLqofH0TTbN1zQ7uuyZCzHmURziwM6JIS9kIZzqaCn59BsUo4ZHqbUwM5pOAC8N
 2g8FGyg0rijpyjjRCRHRu1GRh8RgYGvz2hb8lyoy3wJsVycknmoDQQvaqy4YFUiFHu15+wXfQZ
 MVn0CfMmF3HJFXiYJGPetsG5dFKGzpAB13vXNe6C07K6FbNtc0+xtwCMXGlt7EEYHMBno/KTxx
 Mjs=
X-IronPort-AV: E=Sophos;i="5.75,252,1589212800"; d="scan'208";a="141730000"
Received: from mail-dm6nam12lp2177.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.177])
 by ob1.hgst.iphmx.com with ESMTP; 19 Jun 2020 02:59:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JqXUJp2E3wraSFU5DYQnJP0o2bJQgPBZPCZH5z8Y9ZdilTUPD5Tk7+NjDCug7n31AQsCoDGJ+BII8aJQV1bCeurNQp5kqqLyFTtf8kkHTRgwXUYp/FcWCqdtEfLfr8BIgGC5GGoaBfUTRR7YXmy3ZTWSZFvMOXDlRO+gVM2XIyN55ZSjrpE2ASx/CRmY+6P1Qct+BfA/PKwENKuxOk3wKNhePQyuonSn7GRF2iRn+VK6Aj2gyKHRgCVby33O6spCOJqCy6ra8aq3L1tvnvhhbpvuBWhDGq9vePpmhHK16ZtK+gDZifpzxodO2F8ZLrAjzlMERVYUbvwMsxIxZvZi7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=A4d6r7tgGpBR2VtWEDL50DHsFmSHX7q6nbXmOFDhxZPdIRIVk98u3L3pAfKgcpeYrgTU0UOwwgd2axnmVaal/6DCcwqXwhBr4qXpq+01A9ssyZCrUIcCMyWBMwM/sNA3+tDeBfIY5iKAzLIC21LKtDd9z0oWQcvwz0uxTUx8LAyfk09XHfP9ScVLPRZkGjumdjk6Y7IKkL5ghHxoaOIoQ26MIGQKyGHpUvqc32Yx+E1a9Zdi0ArQIlZm05dy0pb5LZWdisb1Njq9Hz9y9cCQjVD8RsKmHY5X+NgNyeUca7WF+mlKFthGLJfBxKvxHQ8Un8t3L84gAwIGDIPfgoxCMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=DRlf6K2OejB3EUUHCVfqkQpK7eVdyLNAh7izWjGDLKz36ZHJII8hHgIj8iZRo+oEhUYbissldNZqdo/eACeBn36dfrAnR34eABMO/KFbcTVlSEc+iGDo1lylAG6fILTsCgr3I09KP7vC3YgqCy0/e4+r+vPAv+IqJuNvUQ9poBA=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB5248.namprd04.prod.outlook.com
 (2603:10b6:805:fc::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 18 Jun
 2020 18:59:32 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3088.028; Thu, 18 Jun 2020
 18:59:31 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Keith Busch <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me"
 <sagi@grimberg.me>
Subject: Re: [PATCHv2 3/5] nvme: implement I/O Command Sets Command Set support
Thread-Topic: [PATCHv2 3/5] nvme: implement I/O Command Sets Command Set
 support
Thread-Index: AQHWRYBYgq5Q+ZcjSEqOZ65eN4Wdew==
Date: Thu, 18 Jun 2020 18:59:31 +0000
Message-ID: <SN4PR0401MB35987451050359E6A203AC899B9B0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200618145354.1139350-1-kbusch@kernel.org>
 <20200618145354.1139350-4-kbusch@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f178d7ee-6f38-4668-e16f-08d813b9bc2d
x-ms-traffictypediagnostic: SN6PR04MB5248:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB5248C28AACCCB17CFFC5AC199B9B0@SN6PR04MB5248.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0438F90F17
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5SQCH9eM8nCNimuMo4fPtQ318I+g5ZgtvIyJ3k03qHZ+nACRt0AiuQspun1NunPdIogwmOz4gbWlPd6txgfzcPc/OY32tS5t1d6yZjANlSUQq9k4EwUc2PE9HDGfk360RpcvjVm5ktwQB0b+2HQsDCiP3ZFixNCOJh6URYPoDGH/XLC0Li1sKh49Uth3TCWK6o+hKyV0Tj7BkEGMCUSCt7K9qTTOnIuh9y7Ixu0mEx6AvlhJMlHHy4o3hNJY3h1Ao+Eparurnf+sjp5bkpk6rRfby15uU6Z8fAcRFkEvNSD2WoFZOicOh/uPCIdoVj2GUEF043GnAYWnsqUli6OwGg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN4PR0401MB3598.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(186003)(26005)(8676002)(316002)(6506007)(4270600006)(54906003)(478600001)(2906002)(558084003)(52536014)(71200400001)(33656002)(7696005)(5660300002)(66446008)(4326008)(110136005)(66946007)(91956017)(76116006)(66476007)(66556008)(64756008)(9686003)(55016002)(8936002)(86362001)(19618925003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: t4g5+Y2CLBpZh+o82ZO3Qhj97rLmhQyLecmw8XwyRxC2ujMxpUjUFePCNbW3DAkqqmb7E90vEhTYzlM553WQPBFvEdzzI7BX62if8O2el0gPpzJvJabZfk7X9FC+03mQzD+nLAv587aOhl6vQL+sb0RcbA1IHDjTKtNyeqAsHyKvL3DN7iVOJ7dLr5KewTr9JUfp/V4T8+i7flPtnrP46tAFwLKznQchqrCw44Jr+bPDJ/Tvbcao0hPLcx7j2w+Tig2/TeYmfZ5Ux3Fad0igdHjFhtCy8xw4IG7DxM/iinCYuWZguTpYz+9kicF3LDYu0GOcQsvCJu7mNvn+6DpcgwcQS7uQck5ovwzDgOmbl81mQGACyffoOm7m9R2d+1uZjN5x5E3PdgnsstsOn0O2TW3UUvVNkiSXtxaeD3DsDd/QIKDWtWZzL5WDxPEjVk+vbOXKdFzha7SsoFgVyT79yg43jI4SbolS+CpvW78RfK2MzGwH7kuVW8gw4qNWkiue
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f178d7ee-6f38-4668-e16f-08d813b9bc2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2020 18:59:31.8936 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DSHraCgKKE8TQOGiqrtUU0EkyCss5S8F3Ejk1aaR4znhLIHAlJbdc082vmP39PZ9z3LmxoaYsM5Tuh3DTrl3e8Z1so6sWjuYy3BL+IKYoe4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5248
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200618_115934_594120_87E75D24 
X-CRM114-Status: UNSURE (   8.31  )
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>, Niklas Cassel <Niklas.Cassel@wdc.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier.gonz@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Looks good,
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
