Return-Path: <SRS0=sGEd=4I=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2BAC11D05
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Feb 2020 16:36:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB1A4207FD
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Feb 2020 16:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="P/2OdBOD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NGK9STcW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="OveZNsWV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB1A4207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=fH6s4NBFchTuy8LU1mQOZoBXcQ6yPVTTvfe6/AuNVc8=; b=P/2OdBODclggwv
	G2ubPvnjrDjHFll/Y6XCzIJEI3XS9LudwcAW6g8knkdee/OTdq5c3gYefpb/yXJSO2sJloa+3d/TA
	OPvdneyuJBkvsClppQV7HKKBvuETHc4JbZJ2wdWSdieGzx7JPO1o0HdH4L0VKs0F541vTuFKEqrd0
	1aZH2ssRctwH/hyzLZmync8//lMDYeGc699tX8Zyj3jkN2Kfvsad3T1q3mIzDAxEJVogVb7Em1JBU
	ayT/Gwi7nnT5Llbm+hmjZd5+5hNjjhJhxqKqTossMHaPGR1kQsklE+dNE9gYxIsk3dVnxTSgYMQ2l
	uaWdZUyKkqX9c4QFczVw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j4ooY-00055v-HN; Thu, 20 Feb 2020 16:36:38 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j4ooV-0004pf-NJ
 for linux-nvme@lists.infradead.org; Thu, 20 Feb 2020 16:36:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1582216595; x=1613752595;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=9/HPGA4qe2DtSNWDJ2ysKoOa+DUY9R2o9Yy9+kYo7F8=;
 b=NGK9STcWxDatoQa2WTezHZYzOVaFJcJKIIgAUjZ6hMs2GbcDzeXy29Xo
 5EQZaLgOlMVPkTrx0uwtekyluYT6bm9DqyIODB05UrXx4WOJYLrhKfms2
 SWm+hQJp6BonqwtECCNf8BIO1EUL//2nItYN4bWlsAWn6naKOO/gqsoBw
 YFsP763mCCbX12/vD5wCeFnc9r7jqKdonMbg+jwcKBgK/53kKjEjdOn8K
 oVcqEFidKG5SQD88Azkf4JgQm94hhaBbARxzJcnDCx7iOFpC62ZXWFGuU
 P7qQ7EoCIk3lLJixBdHU6+NLRb2HMgOqszTDZf4HdLCsAFeL8RTXBfNhF A==;
IronPort-SDR: sMG/e13Y3pGOh5CnRNMl0uwf50eBwne5t8eUa0TSjUpeB5aMSLZ2DhIU+a8UTMKpXlP9tKGMdN
 ES4i6jgKtnmHjvjlFMV4JMfnzlBVxhbZVdJpeKAAbHM6QTQmxOT+Z4trzHH9p7dJGVO4GYrkXT
 1sovdPdjIymEOfI37fswSrOtOBaHw1NMP9BjWpFiUynVwXRIeDCSQqWJmfXoIZIuUz1dwF393J
 dQyJoZzJjM8ReSI7MH3ptq3PldX32S98dpJfEJnF9s/tjW1laXW39cJOZIK+Cot2+MLXXFPs3C
 +Sg=
X-IronPort-AV: E=Sophos;i="5.70,465,1574092800"; d="scan'208";a="238404258"
Received: from mail-bn8nam12lp2177.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.177])
 by ob1.hgst.iphmx.com with ESMTP; 21 Feb 2020 00:36:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l1Q9vx+YOVDeberTZOcI+jTgUjx9HvbZM8R3ZQ/b0BACSA3ZmSem9uK1E7XDn5cIfem1QwnjYVdD7jobwkNLYSpwwp22x5Z5Fq+cAriqoMQ1ze4esT1/EcgxZ71y5qAuF2K1nYJX21blXbBqnQ4JURvVLLbjVxZLDwOSaFOBF/fHT1Cr3XUHD3BYUTudeMo1jJALXYRhwmdIIpKqogoR5m+HQadgX7QaSSYcGzj5XBbG1nF2Qw0UMmAkLLFnh+1Wc0XrlRZMGpncjAxAghgYgR3vKt2kgHGNFI9Jj3U2IpM7TvK1uArXnf1QNAUnqvtStk6we+WE+ewddMI5s5VPXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/HPGA4qe2DtSNWDJ2ysKoOa+DUY9R2o9Yy9+kYo7F8=;
 b=BXwWUZ9TZRsCNNF1fO5VtqD42QAF24C+U7E08KWBWpN8KZGtaHCz0aVRhqb3VyuesLoqHjIrfYtp+QxPsocRk6RXpC+w9IBwvCRmjNAL6kipEzpRfarmYp244QgqZqDtBinv5VC5Qafuf5n+FDMXK+x8qPuGmzCKN+2zY2bGT9FHEulPGN8m0MNwrYNgtAjnpmXLhD1t/9MIL+x4MhBZKN7/Op3EOM+DBYvrZ/CqK4LGDeuLfMmqy1FgaTYl20IHbFo5ZR8ykTckyHg1Kyh7VKgNs6P0sVAYUPLQcefUrkulIAorX0ovqGjIFxCHQDDgzPYWEpvcrDVqXUbnrVxeBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/HPGA4qe2DtSNWDJ2ysKoOa+DUY9R2o9Yy9+kYo7F8=;
 b=OveZNsWV5NmVBiADoxM40Ecej2ZZNKhRdLNKzmgBgLyxyKtGtpqv2M1r45wHHNIdTTzCBcZL/P38K//Ol/E5OHX4OpknhAQF3NB4PtGdpbhWJliToeYQuydDtdtLtUnLehRzlDAtGmw7kan29Ba4bCAQKnLR40/fsS1Hl8f36fw=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB5063.namprd04.prod.outlook.com (52.135.235.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.29; Thu, 20 Feb 2020 16:36:26 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fdf8:bd6f:b33d:c2df]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fdf8:bd6f:b33d:c2df%3]) with mapi id 15.20.2750.016; Thu, 20 Feb 2020
 16:36:26 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>, Keith
 Busch <kbusch@kernel.org>
Subject: Re: [PATCH 0/4] nvmet: add set feature based timestamp support
Thread-Topic: [PATCH 0/4] nvmet: add set feature based timestamp support
Thread-Index: AQHV5qSDrr+fJYkaUU+d9tLCNoqMIA==
Date: Thu, 20 Feb 2020 16:36:26 +0000
Message-ID: <BYAPR04MB57498D6A854DBD595B6E8F6D86130@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20200218214338.25088-1-chaitanya.kulkarni@wdc.com>
 <20200218231007.GA18306@redsun51.ssa.fujisawa.hgst.com>
 <20200219145907.GA17748@lst.de>
 <BYAPR04MB57497EB1A77974AF57769AEB86100@BYAPR04MB5749.namprd04.prod.outlook.com>
 <51465fc5-6f49-5790-4d85-df5f841e2f8e@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6b3dd3fb-b469-4f05-3626-08d7b62307df
x-ms-traffictypediagnostic: BYAPR04MB5063:
x-microsoft-antispam-prvs: <BYAPR04MB506308AB0E33F25E810E374C86130@BYAPR04MB5063.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 031996B7EF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(396003)(136003)(366004)(39860400002)(346002)(376002)(199004)(189003)(9686003)(55016002)(5660300002)(478600001)(52536014)(71200400001)(26005)(110136005)(4326008)(8676002)(66476007)(66946007)(86362001)(81156014)(64756008)(7696005)(33656002)(8936002)(2906002)(6506007)(53546011)(81166006)(316002)(76116006)(66556008)(66446008)(186003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB5063;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bxiXPYxdLtX9tBrmxKaYpWy9UDkYaVVz8kg+4V79IWLLLzoP27K7/rrIeJaH8TBJdAadnvlASuJmkmG7aDWJLgk5CfLLwZ6v+C0r/CbRyqcOnW7Mwbi+HJ8YMh/WthSAWj5dgnh1Hj2euY/cXWOUL4pdh3iv9EuR2YpbBGzJ3vXWcIk+FT7hvcEFy51bmWPua3UOZjtHHpjf48D9WvRbfsORL5NadjABxp5T0tcWn50TWqnwQbCRiTibsM4eGm8n9UlaDjbPR6BP+mU30NWIV3ymbpaXNoCwNIhqwx35CCxGTGbwRVzoMI0PpJcnGi95DK/UXNXSSEH/7h4FW0BRSYNc6BALH413ZQ//pr5BjRAXmt0hb98Dyb/9zJYsTuNmaN5/pq3WBT7V4bQmnzEwLVJMTVrzosA0UONzmS3E2NCe4YbF+S5zZHh1RCy10Gid
x-ms-exchange-antispam-messagedata: cNuOwGoOh73Zrv33tjEkcZVI73wsNBSJGSYxZCNRQfZt3Cs3f3rddIZ01YRbJA2/icg4mYhaxB6SgzVnUDnZ9M2LHieWcfj6+/sm9rYhF27xkqRj8em5qmlPICkXtsFZafmYNjQCTmLyd/qomV9ayg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b3dd3fb-b469-4f05-3626-08d7b62307df
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2020 16:36:26.7714 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZYR4RGVBEk8I5la7diF2EhGzGQtblp/fxy4ZHWW9G1mymWMxpBD9TKUOYfy90zSiYcdfsn8NgMGJRM6URVegChgyTcjuYoWScBf86TayvBQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5063
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200220_083635_778028_097A0FBF 
X-CRM114-Status: GOOD (  13.31  )
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
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 02/19/2020 11:48 PM, Sagi Grimberg wrote:
>
>>>> The last three ought to be a single patch IMO since those should really
>>>> from an inseparable package deal for this feature.
>>>
>>> Agreed.
>>>
>> Agree, just made series into small chunks so that it will be easier
>> for a reviewer to go through changes in a botttom up manner.
>>>> As to why we'd support this feature, the spec says "The use of the
>>>> Timestamp is outside the scope of this specification". Is there anything
>>>> interesting we can do with this?
>>>
>>> I can't really think of why this is useful either..
>>>
>> If a host is dealing with different controllers which are on a different
>> machines it will be easier to sync timestamp and read it's value.
>>
>> Although spec doesn't specify the right use, having this feature will
>> allow application(s) (if any) to use it if needed.
>
> Do we know why is that needed?
>

As of now I don't have an application which needs this ASAP.

When I was reading the host/core.c I found that we do set the
timestamp as a part of initializing the controller so it is nice to
have feature with a small code change which makes target controller
spec compliant.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
