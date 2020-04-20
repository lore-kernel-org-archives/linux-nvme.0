Return-Path: <SRS0=yQ2W=6E=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9131FC38A29
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Apr 2020 00:20:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 514052073A
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Apr 2020 00:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DhnUYiq/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XYuge+7z";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="papooZcD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 514052073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=jZ01sdwWxFmNKNXbOKiMhWQkpTr444DDKNbx7LGIt2I=; b=DhnUYiq/g+Nv2m
	JBVBUghRvMmA2j7lJLqwJaSSiNuyhSN9v5xBHEtxcIe+uQRYPHtHnKM7T8+JosGWD6YYOiiLQ1TVD
	r+gLAJlbAU9juAwMxWxQcl0e79668diQq/coYnY0uqI3v29OpBm2k9d4mjcfMnlwT/FCozxEZKdzS
	bUWY8SJ/oCV+r58CMXfGzMs/Z3EntHl7k9r0g3DmZPHPZIgHA1mFdphB64ibRfj6vZPkCvS9igUV6
	sCwlRlXsZdWOhvGtHKPH7NqbUZxwynUq5K+oHGNBGnsp1VbC49UdBfi0hDdglhmIujSsKATWT/dGo
	/JKXSvcrjEIXgOizqiiA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jQKAy-00034O-SP; Mon, 20 Apr 2020 00:20:40 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jQKAw-00033m-DM
 for linux-nvme@lists.infradead.org; Mon, 20 Apr 2020 00:20:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1587342071; x=1618878071;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=+fLRVHXHrai/aQIKsazYXN99/F78Z8KgXnrDq2bU3QQ=;
 b=XYuge+7zaZB7q7TeCILuVNocZozTDVc+x+EnOJDa4UzEsQh0zE0Yd4yM
 MOk86/+ADfDFUhvIzm0qvc8U7HTHiFxDt1iAmHntwTz2IasPn5FeR4gXe
 DHg1a4ddf67n81SZ9H8KW3yXexirNXDq0jO7wwF+g/7ELzajcv1YGKyB2
 0MRvxdq3bUF5DCMYJ+M+e8knEIoiboQI/Ktz06l9N2ZLJkak+r2wi3Mmu
 /f+2Ax5GI8LXL51OJu9lW7cLnsx2vSZvgSIv8Pho8sAtVjJiCEFUDVUYZ
 ZArQTGZo56+GlJ2Wp2Nw9h1kdR/k4sezKg5gDGAHdaFQ571zeX09Cv9Hb g==;
IronPort-SDR: cvAze5mIrS/H9jKn+5ZfCTFsysediLtb3Qleafo8dCJ4C+1DUm6iQZ5WA4hxjUS5DQsfoBLmcZ
 3HkJDItmADvtUQ3vBCXmvNIDPIXm2yvWlP8ywifeHBDc+Cg5Jm5zOpKJWCoklkWPI1qlUINnhX
 7SFWsVRq1SOp84gPxCRs8Rqvwioab3OqF5rS6fSxpAgfbwrTSRC+edf8CKclSQnZM6BdH9Jx+L
 aD6FXM++BqX0zdLktYRy3HZ76LToUeu7vTrUARqf3SLt7/rjZm3lrli6GZJbVvHISz7KAQ9ZR4
 BCo=
X-IronPort-AV: E=Sophos;i="5.72,405,1580745600"; d="scan'208";a="238117978"
Received: from mail-dm6nam12lp2174.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.174])
 by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2020 08:21:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=objKvvs/lsUOjfJpn/uqeYeplbDXc4bbxXI4bHw/Kw7aRvghbv+9PvlPCOSiP1JB2jUp/tCbAileX4xGj1zg0YVbdf94Tuc74gBili2xltPiClxxIKkuvD93l0jkGWOED0YRBb2/lxTb6JSQdqN2rCSfwqKG2Xot9jzHObbBmJzy9KWZM1f5z4jklTVpf2KetzwSWVktGlGx3rZLwx8gWsRRQg6eud+eSJKP0UFQZosyQwCvAKiveEIdUJu3CGu/VsSHnpIkgOHSkUrq7xUSsNwUb4j1zDH9IvBWlz9xM9/F52zCLHzvnoEblboDfnZdESc9A8TO0kVO4Pz3SrLH0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+fLRVHXHrai/aQIKsazYXN99/F78Z8KgXnrDq2bU3QQ=;
 b=Y4zNDptEXdyROkT7pBRB6sVF5Y+PTjZSrRyXACosepBK6hffKUum4AOnB5LbsWwvAgdqqRm70/X3ZGhHVVNfLlPWwxWe5AeLxDv2GzCexXpzGuJm75yqLQvGsRO3sUIa6HgU/SpjMbPEwkND+HO31wSTK2m1JvPCCZTnts5KvVnAQINndi60WRCLEHCKdTkTQuUUurENbk2WYsycLYgY46DTKPIYfGBKyQjig+QYsXi0XPrT4PmIipPpNhL4+RpmQWftzSA6BFbhMHhrZXNiGZ4qnwfu0/XOhl/KIXgyQB3SFkgel9SJP7a4CtNh/RNdv98ZkEiYBvJNyjxo7vgP/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+fLRVHXHrai/aQIKsazYXN99/F78Z8KgXnrDq2bU3QQ=;
 b=papooZcDQ3AwSFrpnuqArdaQQCH3+Ysvts5gjA7CKqVP9SlS5vl0rBFxsxuH0f4Zxczi/q4qxC8E8x8OKybKC5Opqn7aClxzucMA4Ge8WxTObme8z9Q68+n7iY1MpmuElv0Vr4Aeo5nahOiFdqlgLfCfRYPv20dAHty6jrOn2Nk=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5303.namprd04.prod.outlook.com (2603:10b6:a03:c3::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Mon, 20 Apr
 2020 00:20:36 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::28be:e964:37e5:44b6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::28be:e964:37e5:44b6%6]) with mapi id 15.20.2921.027; Mon, 20 Apr 2020
 00:20:36 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Anthony Iliopoulos <ailiopoulos@suse.com>
Subject: Re: [PATCH V2 2/2] nvmet: add per ns thread to generate AEN
Thread-Topic: [PATCH V2 2/2] nvmet: add per ns thread to generate AEN
Thread-Index: AQHWDVyGx1h1rDwyCECcI/Bh3Diljg==
Date: Mon, 20 Apr 2020 00:20:35 +0000
Message-ID: <BYAPR04MB49650EE959D09629F5BDB22286D40@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200408041633.20632-1-chaitanya.kulkarni@wdc.com>
 <20200408041633.20632-3-chaitanya.kulkarni@wdc.com>
 <5e54afaa-7de5-a89e-5740-88df15c52bba@grimberg.me>
 <20200408095500.GD1329@technoir>
 <SN6PR04MB4973222BC905A09B9CA0E55586C00@SN6PR04MB4973.namprd04.prod.outlook.com>
 <20200408170820.GE1329@technoir>
 <DM6PR04MB4972225DA024170AF54CFE0086C00@DM6PR04MB4972.namprd04.prod.outlook.com>
 <FCC6B6BD-FF42-4589-BEC3-56C0885C32EF@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 460a2425-0749-46d3-8208-08d7e4c0a5ab
x-ms-traffictypediagnostic: BYAPR04MB5303:
x-microsoft-antispam-prvs: <BYAPR04MB5303044D24B0159914E3689686D40@BYAPR04MB5303.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 03793408BA
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(366004)(346002)(396003)(136003)(376002)(39860400002)(54906003)(81156014)(8936002)(71200400001)(8676002)(7696005)(5660300002)(86362001)(33656002)(6506007)(316002)(2906002)(53546011)(26005)(6916009)(52536014)(4326008)(9686003)(55016002)(66476007)(66556008)(64756008)(76116006)(66946007)(66446008)(478600001)(186003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3vm1lt4d8u0PS85/mC2ZkfrRdpvKVCaA2jK+XotOZ74yjewxUFZvp+SNCQhO2OWoaDI6bjMtZtlyqyJJI9tHwfQGnN7ai7J/eDck0p4/Fdzv3/GJPvtIupUu/h8qxhjD10crNHgCpvSq4YeIhBnxeR8QhityM1yHGFMPRixOS1ILiFREpT0NDQPSvBiu+iv2Hfn9r7WFm92qba/j8fw9pRstMRxqovbbo1B18JdHaR5QFKwyw4An4M1s1GkYpTUcRl2+tazQwhThbZPbE4XWXB31f8Ix+jIUssQe17CoGIwGTC3YQn6D5+jOA32SmBmvMVtip7xKl+Hu1CIANLwhVQxfXFxv7Hv47G6kXnmC34F17NFNxE8/O85ds2E60htG3UjRkM/oj7HgI9Z7ihRBgY/f1PDI8mTOUB0dXioenFLy6+NJILhM0VBRYviL41Y8
x-ms-exchange-antispam-messagedata: EDqY5z4KqJHC0MQN4kNFrIYU0BaOrHB1qlncGJZeBI5TuUj3mSnbL0yvbBcm8JJtTZS2tANSj3bu+AQFN8DqU/xYQSe6ZYUi8GsW8pusGpwwdB5GpdyZQPNKK3qWZFkIqEVjXRGVNZUaG9d3Hyj7XA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 460a2425-0749-46d3-8208-08d7e4c0a5ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2020 00:20:35.9499 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SHxkuhK2Tn9xPi4nE8ROUBcqJB9a0LTTonR+KTZTPFwAJVE3NeZWLg9ZYjMMLQzXnUb8wm/9TNK/iHCMejWlJJ4Ii6KSl5EH3qeBDssfnYg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5303
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200419_172038_503593_3300BFF3 
X-CRM114-Status: GOOD (  13.14  )
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

On 04/09/2020 02:41 AM, Anthony Iliopoulos wrote:
> I was primarily thinking of blktests, where loop blockdev is used for
> testing bdev-backed namespaces. For testing filesystem resizing on top
> of nvmet (which was my use-case), it really makes no difference whether
> the ns is bdev or file-backed.
>
For testing we can getaway with file backend, it will exercise same
code path.
> I'm just pointing out that if the loop blockdev is the only kind of
> resizable backing used for nvmet-bdev, then the maintenance kthread will
> only solve half of the problem: userspace would still need to issue a
> capacity change ioctl to the loop blockdev after resizing its underlying
> file, before the kthread could see any changes.
>
For nvmet it expects generic block deivce or generic backend, we should
avoid to rely on such functionality if we can and this is for testing 
case I'd use filebackend than loop device, since it uses same code path,
and easy to setup test with minimum steps.
> But I suppose there may exist other use-cases I am unaware of, given
> that if the ultimate backing is a file, then connecting this to a loop
> blockdev and doing a bdev-backed nvmet instead of a file-backed one
> directly to the backing file, doesn't bring any benefit.
>
Yes, I don't see any benefit yet except adding another level of 
indirection. (and possibly crypto support, but that can be solved
by using ext4 and user based per file encryption).



_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
