Return-Path: <SRS0=g+aI=DG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75772C4727C
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 21:24:50 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B99C620757
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 21:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SAGjpVQN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rVkN2ETW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="cBYyuhAF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B99C620757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=ec8BjohknfNuo+EeDLGXmyQLnXPt0S8U2oq9uxs/DGU=; b=SAGjpVQNbiOqSeOrS/FYXbvDe
	YWgofgB+2vxfXyOC1qlzTf/r/fUA2ufoOj/VGYn23OHfID2FkwFRN3sHl823FT/K3toSkBB3HvkBc
	Pg5BNJeUwOQiOBg8URGchER3/Un2matdry6CjV7uTDVS913IYBWp6Gwrr/gTtMMw2YkyjTFWH3ebs
	tuo3zr8QiDjgiOn9iiDsu0MAhfd5s7YI6/EgkWON42LyjluUsxYOIb75lXkdFT/52zlMsft5KHK0g
	h/qZ/gDAoorx7vS6TdGCaHVh6vZBjJ3XDnPyBNwBsuEddJxpqFVXXqhgYU2w8bSxqcCCX3EAB9EHh
	ma85XRQ3w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNN75-0003P2-NB; Tue, 29 Sep 2020 21:24:43 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNN73-0003O9-DM
 for linux-nvme@lists.infradead.org; Tue, 29 Sep 2020 21:24:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601414681; x=1632950681;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=tzBbbSM/I8oJcZn5lMBvLA4U7arbn4qjyMLjgPo5eg0=;
 b=rVkN2ETWARKOIfXTPQ/In4EFSGPytzTHpFSOnembVNbRZk7uj1beo9/U
 lVzTxPMiqvehJd178lT2u0Dt3ZjM1BIxbZAdGh1Xfn96YXao3tAsUbqEM
 9/uXSQ9Zr063MYAAf5TZ2PSMZ7hsLANRsHaApvw7DywR/yehgHXVkH1+k
 BDzSZ2QT7kvOylqQOxTY3X2k9b7C7drSfGFaLufpu3uSWCicTXBPI+05l
 uTu5Jjj+/b2SHqfbeGidTl9/3lK4f5H3HyebaoWHwSfI1CsrQ9ptfppXl
 EY9sUhFdda+d8sFJsGWYqUNgqkb6Cg35BZrE1iFXdmGd5n+7kXnSCI8Qm A==;
IronPort-SDR: 5QVyTQ4oDB+sx2yEAfPdyFPWOYc8jLfn5LGQH6A01sJEXDSs56eQDpbDHOIRmDrFJyGk5jKUQG
 uIA6JHZ8GZeNgLuQV5ywuFDfn7C5QUbUWzDMARFnf4+tGSpgmjEXW5JZdM5ZGJO0agsFhimjwt
 C+LWg29zCM7ET1Mh2YWIQzGrdJKupVeXBEcUU6RnqWI9FXnV0zR+0f/vmnDkhqXeOWIdfEVwvu
 lcXVm7GZrBeccxg2dRl8QmX05zqH5q7LSBlT/IRMFHXxHGgCeOR3Hf4b+EZy76vJinmp3TcoJt
 0ec=
X-IronPort-AV: E=Sophos;i="5.77,319,1596470400"; d="scan'208";a="149812637"
Received: from mail-sn1nam04lp2058.outbound.protection.outlook.com (HELO
 NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.58])
 by ob1.hgst.iphmx.com with ESMTP; 30 Sep 2020 05:24:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KFyZJJXuNrJjVLxmTNlDqUyAf67h4Jo/1v59KkhbhpzSYY3zP9E1VVmmdr/EAMcNFRjQPr3Km9wAQ9LnlJPopYeZn8L/zxLRouNpDysjT6n+8by6hj5aWp8ja5oGrqOd7IuzVizwXct8eVbpX6i3LygUb300myHSdT/VKC75Z8/LV563YelDhxt/vgu81I7KHIUy5Y/NX+eU5wOzuWsAJfi8acawBmQkncaZHPE6DC+hBCuqr/xxsODFtUBFPeCtlpXU7a7k6JGG6WjTkrg1eLs8AyBIpZlr0Lgxo1FcrUJBrfU5/rOSGAEkPaq3oHglsapVErqRA/PQeGHRZAE9OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPRM0drTRfLzzgfQdxBsOMqceqEBsLaU0EQy7Tib17Y=;
 b=GMypHhdMm5/gsMjoaXKblD5b1tPmmhrG7KNPK/kfhpJ1XHzdn48saY1H4aVEDn7fkAKHSzPuICqBiCdFYNZyyLnUcNPSsFPBnOqJdD6x1bGkG0AWUlB28OmRxKmAPCiYvG8tLhKqFDR5RlmtjykcSQuP38mOOsfhdHz38CWa/oEoXxvMIKWd4hEZcLfVrDjjKWXv4ovSNkQ/ZVY1w8LKuXH0zQG2hsDiFV9SQOO/jOKw5AyiE1uDnjl+CRX5bmpQmksIQCH/dqmswAn9FBDsrqZlVZDt+4HogFEZUE63JG/dsLKRqu8nxNwraPTUWukQomKnd5SaoP1vG/3wQyJpjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPRM0drTRfLzzgfQdxBsOMqceqEBsLaU0EQy7Tib17Y=;
 b=cBYyuhAFej3ZhoLLTvh/rXZyz0M+4P0mkd3fNO49tmFvVB/Jyrt7qbdxI9O8j1qAushlHnQb/erj/zhN+20oC6kgMtY1indXDDETeU+UWB2W5wRQ8VdLJFi5zQgbJEzs0ZZi+HQxi86XftMGlINxXBG/lZjv1ViMHN4F4an6OX4=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB6102.namprd04.prod.outlook.com (2603:10b6:a03:e8::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.23; Tue, 29 Sep
 2020 21:24:38 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::e1cb:3a58:d588:d7eb]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::e1cb:3a58:d588:d7eb%7]) with mapi id 15.20.3412.028; Tue, 29 Sep 2020
 21:24:38 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 08/20] nvme: call nvme_identify_ns as the first thing in
 nvme_alloc_ns_block
Thread-Topic: [PATCH 08/20] nvme: call nvme_identify_ns as the first thing in
 nvme_alloc_ns_block
Thread-Index: AQHWlZSzqoS9L/ZAKEOt4Ekx/cEvhw==
Date: Tue, 29 Sep 2020 21:24:38 +0000
Message-ID: <BYAPR04MB49651ABBE4F70FE90CCA283686320@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200928123502.435373-1-hch@lst.de>
 <20200928123502.435373-9-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 39d6f1be-338f-4c97-26e2-08d864be1269
x-ms-traffictypediagnostic: BYAPR04MB6102:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB6102E816B76745EA5A6FE73B86320@BYAPR04MB6102.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o23Nv37gHSYeV+lGBC3wBIuWvR45BqEIa9g0e1x/IoExO5PsRLBRTXeUK4kXJOUBbZVzqe7qdIrNR7klR0/JONbCHqkPGBkfFg9Uzj+y/0i894nTPlVp/Nuhnnaf84Oc2m3WRYrJg0XndezcKFqH2/aGzsv2vkYRs1yfrWJE+UopcDGsu/s7KdXQrrVAvH4dqg83QpwJoXvsJiEpXgf6IquWjKc1EgUaPokXaoVIPptFqrj0GsT3RH/P3pk9CfggQ/0tpq/nDaFIOY00uBL1hKONjfhcCONM1O1STz/O7Z1lQPEokfubxxPwiWEwSeWxzK19cVOq0EiMWvzErq6EELQUfkze1/t7ilJthbWh1kykIAbCA/XRtyeqsZJ4PGUC
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(136003)(396003)(366004)(346002)(53546011)(6506007)(186003)(26005)(9686003)(33656002)(66946007)(5660300002)(76116006)(2906002)(71200400001)(4326008)(110136005)(478600001)(7696005)(54906003)(316002)(8676002)(55016002)(4744005)(66556008)(52536014)(8936002)(86362001)(64756008)(66476007)(66446008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: FW8JC9eGYX2zmWuBqGDtIgXc+L82/Jl0KDYu2dgIwArFU8uyXLXvoMOcHGrZWnUdirv2tY/O7ihQZGofHdFeELqYnvC1HUkDvwpWVP7HbcaQBAX086j77rKw/BMLr6TX9aSe6jnlV3eVHBUeHRBSD7C81ysjY8CSpnYXHB6h8txIwYsYmbLpNCYw+Jdv9s7ioGqjCYboPFlMBwsx3keIrEUNrekcga9WOLpZM8nOvcEvFgoM1C7K0s/9X22brPZiWkbiEbquiZO5xaThIvEvFDFvQCq6Wb733zCY+3IdZ6k2c7tr4NDnKcSDPe3ImJkHYEJQOVXoDC+UtHgtnZLn9PXydYIxfxwdmOk9dHNo39t82Vm9R0jt2I9xjlbSyIF6szerlK+uMO5CzX5CS4geN3gOMwK5ab6lpwdAKjOGyTW5dwf1bIE0pHABY5HICIaR2+xQzAeuHKR7/FIGr40J/xJkiCbBnvcCu1EF1Q/ntlz/sAuYwY4K0pyOKtbjBhyf3a2XX8vc6M/H6tuPjOwcZz0CETbXemd87kzk1lCVIv0zIg0jFBQrDv/Ygehy8NC5T/TGDGR1ma+kP6wi/XjX3/yI3fr7fIwPG5IAd3JSzN0rpgR1SPrGa/GALRB6+PzuS4HxGDGXgxZlmuzq/4qG1A==
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39d6f1be-338f-4c97-26e2-08d864be1269
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2020 21:24:38.6161 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dfCUf3X/fWY2XkFsdJPeapBk4qcAlxqhKvQ8UDV6HiItssdYFUc1zAmz7mwZcJmv0jcoku0zXGKtMhQFGxhgcilBDCZiiwSVXosaJ9Zrkvw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6102
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200929_172441_607436_FF2C22CA 
X-CRM114-Status: GOOD (  12.68  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/28/20 05:41, Christoph Hellwig wrote:
> Check if the namespace actually exists as the very first thing and don't
> bother with any extra work if not.  This should speed up and simplify
> the sequential scanning for NVMe 1.0 devices.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
