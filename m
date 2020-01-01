Return-Path: <SRS0=dhu5=2W=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0BDC2D0C0
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jan 2020 03:27:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F049C206CC
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jan 2020 03:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ONUtiurT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ocxT3jRc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="pjaXuMY2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F049C206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=RJYUj5WAIyy/fqjRznwtTtWPK06atrqhJO3qY8+HCkg=; b=ONUtiurTQNCyMm
	+2mQajTuAkFEMmMFj9J/UQAy3B3U7wuCojlyD2l2gQMOTI1swDt0u5eXZQFHWr/d38kKxnuy9WlQn
	IbI17zp1zaLhybVFF5s6PZPxNJVu9LZcOjyeOjfVsapXJJdzTMIPPTeje49whzJ2yMtbMCiaiTc0G
	f42ac5BdMQFeNlTjLFFp7JSj7UGpCURhiL7AwwW7SdrDUN3nQEUMx9mHUgFz55U1yG0quHoFzAElo
	bgLrB2+QRlVkv/8k02oaQFlwCfcL/hYeyUSPu/MDdWTJL7j9wbPueSqI+BysHqMVyALUW3arUp+LL
	RH3Gim5FDtiGAQraQJrQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1imUf5-0004z1-7z; Wed, 01 Jan 2020 03:27:07 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1imUf2-0004yi-S4
 for linux-nvme@lists.infradead.org; Wed, 01 Jan 2020 03:27:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1577849224; x=1609385224;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=4tWaDeVt2dAXOgoyHNpnVKd4oN8rpdLKPk9FLKqy3Fg=;
 b=ocxT3jRcnrlUwJEPgXXpgUVJpfNZXgzzFgi6PO+uBHvKrmt07ju+uvIa
 bRW7ESdEPbno/FhLT0UDBTWGzcidr1cw0CmiznEzKri9ElSZqgF4cSz69
 AfU5UTFUSskZaHqXhYktpspdvevOTNJBqjq2T93f07fSHeR+tZmKeiAmC
 DbIWcimeFvUJeatIL/lP2e0M2zO2/sKwIGK+K9mkuU+zET2oS9cqhUKbG
 AkRyq+CXHC5rxLVCHFF76WWmc5JirwYPNlZ+9GCRHWawfVYJ0YAqhy8hI
 3wFmcckf4H0ImxopKE9TJHdOdV2ZANIl8fJEWpyE93RLzhzHake3pKK6i w==;
IronPort-SDR: yqtZfSbQGnWASr1pX8FScLgGaNr6cV1X5nJMNV7GVZ+sv6DmbIP1HWTMASJbw6VknsO9tBRXqj
 i2UlckgbVlpEtIMB2Vp7hJNlD2IGaJX9HxuOn4v4wcAjT7fW7F0mKPVLzagehcswhnRh3AxMCS
 U2sCOKHKajT22waifblj31sQveI89of8agchdjWYWzPOZQIdYE0d28mguBsTCaNRbBeDDJdf8Y
 Kh2nT0YMC8S0pwTMC+20lBhS1FTFXxYojpH2gO/zQdB2QOZjJ6An9UWz31CmKsQXnlpwjXCYjk
 Z0Q=
X-IronPort-AV: E=Sophos;i="5.69,381,1571673600"; d="scan'208";a="234267960"
Received: from mail-mw2nam10lp2109.outbound.protection.outlook.com (HELO
 NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.109])
 by ob1.hgst.iphmx.com with ESMTP; 01 Jan 2020 11:27:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dm6OYQ4JkWHJbJzh66wd13u5Ru7iNJxLbQS0vqSVy7SVdpEfOXq28SWtU1FxgB+84WG8Ox+VqKtVTDWTvKu/9EAvSVEZ7U+SQF83cvBnDV2sU27tQwDNcUIgHuwWnuUkTQdenJml765cG43YBDR2bNMw1Olc0fsij7LLeIED5atgmS6WKC0xbUTlJ/Z/Fe3ggUe84S54lKNqoQnjJLgVO0jbdB7uiCQtDR1Acjn8Yzprmg8rARWUqRlKcLVxgNI6yQULypgyfGqkmLs1BuegZVawo2RIgdzBZmN/lGW9gCQxYiSRk6PiRO58xJGvPafYQ3fyFr9GK/W3d9OTWt4c/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4tWaDeVt2dAXOgoyHNpnVKd4oN8rpdLKPk9FLKqy3Fg=;
 b=auFlmZh1442jEA3+ZuclW8eBURzdCpg6EKAZA4nsxJrj3bO1ppQW0m+2vdyo5Qlut9v//Yg9SBUSwcq02VPmRuI5NCat4rtJAy5QCWkZp3J33xHkUOUDxTnEhO9UePX3YwBPdJNthBJatUSRoNc1lttgfuo9Sa4PdmyrT7f1ToJ1eDAOXNXUmxkbfxfOqxbMZOlvhMkKWxeWjB4fMPexgZiX/ZFc9r8tGUfoJsSWz9UiRPSVK+Zvp+5ZF4NXs5J9Zz9DOoEfNsGqCB8+lZORUoTxheUK31ONAY0CsGn1w272JEhtrWT81JgyiXItE6aEusgF2r6ZQ91Oc4GeG6S43A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4tWaDeVt2dAXOgoyHNpnVKd4oN8rpdLKPk9FLKqy3Fg=;
 b=pjaXuMY2MzSJhz1amQZMiU31XDBvCOv1bKxsbBwfYbNkmjbug36x/Z5DJeq6Scy1InkUTByJd/XhLkyECVWkWwXCfk4WtOAJEt2tpGNMampnZz4WRRyy6SMJKvoNEE7uhWcdcnIhApN4zQSYbXBiLDG61+ioIhA71v1hItsJunM=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB5862.namprd04.prod.outlook.com (20.179.58.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.10; Wed, 1 Jan 2020 03:27:00 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f%5]) with mapi id 15.20.2602.010; Wed, 1 Jan 2020
 03:26:59 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "Singh, Balbir" <sblbir@amazon.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "=linux-block@vger.kernel.org"
 <=linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [RFC PATCH 1/5] block/genhd: Notify udev about capacity change
Thread-Topic: [RFC PATCH 1/5] block/genhd: Notify udev about capacity change
Thread-Index: AQHVuTJSbECLIM1il0K+YWQEXBwT7Q==
Date: Wed, 1 Jan 2020 03:26:59 +0000
Message-ID: <BYAPR04MB5749C2F13BD6F6C15509FE8586210@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20191223014056.17318-1-sblbir@amazon.com>
 <e452f6a638fe09f065b9e4cd1c25d5d3a2f29e5a.camel@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [2605:e000:3e45:f500:218d:d9ca:f71d:c5c4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 74ee8643-b92e-49e0-0ea5-08d78e6a765a
x-ms-traffictypediagnostic: BYAPR04MB5862:
x-microsoft-antispam-prvs: <BYAPR04MB586278B05ECA40AEA83B218C86210@BYAPR04MB5862.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 02698DF457
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(199004)(189003)(66476007)(66446008)(71200400001)(53546011)(4326008)(64756008)(66556008)(86362001)(558084003)(7696005)(186003)(6506007)(5660300002)(52536014)(478600001)(76116006)(66946007)(8676002)(55016002)(9686003)(316002)(8936002)(81156014)(33656002)(81166006)(54906003)(110136005)(2906002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB5862;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qnJjab+Qphngc4S8HXAhI5hdipbD5IW5wupEfa8MRaC2XNZU9LAZqWIryRRbZOesvTrlmzyUREg1ImMx64HKbyotAug8dPFHOv1m3sl04E+RJRskKEusk7Y4DXZny5s/0+NvqmRa9nI0wm6o8rRULMdE04Ps4U3+KU60lethjSIgBKTiscEhCDAu8Ix4ddZSnDP+WIh91YCxNYIOUN23nQMF6BPD6NMSMM4ns7PXF16PTFrU3crgSe0JomFZR1heGyqneWN8SmPesMQW1v0cMzzDecLKv/tzYNCvjgWidlgl6wtqdfE5ir4vWh6ZKOGnB6TyNW9lZ77tuCjByB7FhZOmUXEhFsUDE3OF8w4ymv3vagsCuwQbVa0NQTtsCacusg6yrTVJ5d6inO5gNHgootdA6k5b+x6ZsZiEK3199E49kXjuCG5B3RKS94mcO5/P
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74ee8643-b92e-49e0-0ea5-08d78e6a765a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jan 2020 03:26:59.7366 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xUva14W6FG2AZmeMdBDDde7pROo/zpa9YnZ/0j/FP6rKZXqbOLtjFT/DTK0vUjxZJ1pSayxd8VMjeKjCKASTtEhZqLM0lVlWlEWtrIT1kpE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5862
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191231_192705_000283_9D5339AA 
X-CRM114-Status: UNSURE (   7.08  )
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>, "Sangaraju,
 Someswarudu" <ssomesh@amazon.com>, "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
 "hch@lst.de" <hch@lst.de>, "mst@redhat.com" <mst@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 12/22/19 5:53 PM, Singh, Balbir wrote:
> I messed up with linux-block ML address, I can resend with the right address
> if needed. My apologies
> 
> Balbir Singh.


Unless you have sent it already and I totally missed it,
if you are planning to resend can you please also add a cover-letter ?

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
