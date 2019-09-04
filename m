Return-Path: <SRS0=Tecl=W7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76B5C3A5A8
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2019 18:27:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAAE320882
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2019 18:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="H2OkX/9h";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="R72S+jxA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Fn5hlTZf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAAE320882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1IS4hkxMcHmrpn+Ctnf0fAn1IzJ0MkOb4L8PNDjr3LI=; b=H2OkX/9hqQ0mR4
	dq1ajU3GNCHLX9ewRKXAebEWsLNBCgfFYo9ZQO5hKP2NaSs371FKZuQt5cAwEwU+cxJe561qQlOS5
	vK0d81RDoCTZ0PYc1URtcbVwde2EAUhmrQ1kjH7/WeLJkjYLGrCmhu7VD6D1mYj8sYzo/Pxqta6MQ
	kHraz0KSfFusMt3veBoucs2ktsTIxPOleWI6cPeFC1aes7RTm1GZTCNcLE1+vhijk1Em7jgxybyhl
	bJ9iwQt9unx88oRbu3i50KK75h6wIc0raZKBKn7S2y/ss1J3dFaiW2dDwF5HbsDwFpppsC4NC/Xoh
	nC8B1trTCSrKDEDkp8OQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i5Zzr-0005gH-1e; Wed, 04 Sep 2019 18:27:11 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i5Zzn-0005fY-TO
 for linux-nvme@lists.infradead.org; Wed, 04 Sep 2019 18:27:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1567621628; x=1599157628;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=QPT/YUNBNfx+XyIXxiem1f7JRQbwbDp4J0ty93hRCb8=;
 b=R72S+jxATp+xX0I72ngOMrP60auxYUJijIkFncADB2CaeZf6npfZGUyr
 4uPy9Qsnx3xkf+sL0Y5YczhulHVewLl3oEJTxBW4/SG2q7mJMuu/NE0ZW
 PAkAbgiokEw0ds+injL5iapjT3u1hQx5jWt293xWWZlPlpr+1Utz9hjl1
 znrM4Tu1OXPBsary6WRl3sSGX7tAPT8XBZuWCSQUXXnhJNMw8SRylZsva
 Ofa4SjgGx1XK8Kz5egzy084Gkxom9L41awP/xmZ4TL4fJZQMj8lrQ5uwb
 H9QLZuzXMJ/tfzUxaL5yd8Q49qPr4TgeIen7nT0TGEorx7uacfnOBSaQP g==;
IronPort-SDR: PtUimEA0IZDx4bPmdwllxcp1cWr0Hkrm6q0Lu+X1/zVnxvZdZeVTh6vn2cJMWtGDIEkjNNFsM4
 uTvfVpX2jk+u+ZsHgKPocSBS0dzrDmgLXYlPopKS76kkHgbu6f9cii7HBGEsbbfwcE/X9dWg1s
 iM1HYzPaLKgoMvkYxQkS60x/ryF2DB4VOWL5Q8HzA/I901sbWVyKraq/nYRU8yCOje0vi1g7/x
 QaDTUA+1J8qFf8FWR0Yi24BLJUfYIi0UyHLKzW4l2GUzTkwVU6ah7uTIS0r/ocxIU826Il+PqG
 3zY=
X-IronPort-AV: E=Sophos;i="5.64,467,1559491200"; d="scan'208";a="119012451"
Received: from mail-bn3nam04lp2056.outbound.protection.outlook.com (HELO
 NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.56])
 by ob1.hgst.iphmx.com with ESMTP; 05 Sep 2019 02:27:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hSM1J4F+BoJN8tIs8Aab4khzhmLj/ePbLKj8grkAO6SAacWVNLyEFCkU4KA4eOVRIjQ4uJBHxeu6+zxhQlhPqIV1z5Adsr4ed3v6vrDUlAznQ4cHfX2UveaBCpfGkac9e1m5214rk6vcuT7NDash99mR1yX+yj7UobEWdOmselaFstx19HRoRvMKbR5oG4IFIX1v3AilbLTIauWQhvJUTR4hKqJV2yyjtb6Ya5wtrC8+1GdCv9I7K0ebrgAaKPysjIlmQCLoWfKDyurZj4tFZQe0xW73U8SpH0KD5V7/Iif+fhUxbfuV+Phz44nQbtK2yFSPM1u9XJVVTi0ebQK1gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPT/YUNBNfx+XyIXxiem1f7JRQbwbDp4J0ty93hRCb8=;
 b=bXO1BFAREPh+IUjFoAOTNJK+LiEbfiL3RkLRLrDjgky2g6CswwuekUf5e4Q/NNMjtcmrL5mdO5HDzEqRMsNPUKSvlnJPUKm2gTTYshXwbCjve0eFBzKmpUhI5Of6DxspR7h9OK6siVevMZkMH6ScOJ3wFTfvz/Zn4YYqp8EvX1tOoMfGUwl79gYm1ZZRhj0nzvIyFFzEAL8uWI+C1DNvQJXa5asjciaDNoA/kB254E/l5KrWAVBKV7mxmwtR4I/6tNuD26iS89o/3Eyoj1MVsxWVd5/TlEXk55GFwitt8q5xgqCYkCFjN9e6mIvcwCI3RXXatyrKX35JlRon1QFamw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPT/YUNBNfx+XyIXxiem1f7JRQbwbDp4J0ty93hRCb8=;
 b=Fn5hlTZfWiJGlhcwGceLgeqyCIawfyf9IDK5p1k1bu3fbggMcdwbQ0EZ399Hy6fG5xCrYxQW0MBEJJ3SiuxXtwt8FUV6v33ZLDbUTUpEjiqsKx8ekNcvMuMtb5VURHJspRgRnNW8ETxvxaWJUXhdGxTywbV6IceD5bFJfLbC6EU=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB4261.namprd04.prod.outlook.com (20.176.251.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.20; Wed, 4 Sep 2019 18:27:03 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::b066:cbf8:77ef:67d7]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::b066:cbf8:77ef:67d7%5]) with mapi id 15.20.2199.021; Wed, 4 Sep 2019
 18:27:03 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme-core: get rid of the unused variable
Thread-Topic: [PATCH] nvme-core: get rid of the unused variable
Thread-Index: AQHVX5B6n1LQbFu3lk64BQctE5wcX6cYk+KAgANJrIA=
Date: Wed, 4 Sep 2019 18:27:03 +0000
Message-ID: <3a87f739-c7b3-b718-0d82-08029544bc77@wdc.com>
References: <20190831001013.8581-1-chaitanya.kulkarni@wdc.com>
 <20190902161433.GC27231@infradead.org>
In-Reply-To: <20190902161433.GC27231@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [2607:fcc8:bc82:5d00:74:44ca:7821:461b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 29dd2095-149f-4392-8e7e-08d731657bcf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:BYAPR04MB4261; 
x-ms-traffictypediagnostic: BYAPR04MB4261:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR04MB4261008A40C2FE6B3B4A7F7686B80@BYAPR04MB4261.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0150F3F97D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(199004)(189003)(478600001)(2906002)(966005)(76176011)(65806001)(65956001)(36756003)(66946007)(76116006)(53936002)(25786009)(14454004)(81156014)(81166006)(8676002)(8936002)(53546011)(46003)(7736002)(4744005)(305945005)(5660300002)(71200400001)(71190400001)(102836004)(6506007)(186003)(316002)(2351001)(6116002)(446003)(14444005)(31696002)(476003)(2501003)(86362001)(2616005)(11346002)(99286004)(66476007)(31686004)(66556008)(64756008)(58126008)(6306002)(6512007)(6246003)(6436002)(229853002)(6486002)(5640700003)(6916009)(486006)(66446008)(256004)(26583001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB4261;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: f1YEnGSFjyrg+Gg101gVGOlSERJDUOuoI2vZxgnVtD/+XV9bcnS6wzixFvb8HwizvD/iUlH4h+t7kSBNz96I5bqFW2c7j+/K5msGM6LVYRM64wav9S2ssVJo4JtzABOV8QYCLTNwHWs53FGNbl9NkMNrGlrHK3Rl1Z6PX3f3Apde8vqKb4IsKrK6Ul+CQOKcBmK44t933fB9PE1dbVjpOA8XA8ccPNaQW7GQRObD2bTL7hN8V3Sr4h+uJw6DwWQl4f7KZCW3Zk+xSJArVu/NTOK4fhnBfc1EE/g7fijpKpGPkTeut6eG6WhkHY6l0wm5iegootS7t/w2z4ONC6QechqcQkneXrqlgkBjLp74UviSPlebcVWBpNe0rXrAMFfd+Ipay2tWCeEuy9wT3uhKxp4s0y9ke1JjxTzZub+CQTE=
x-ms-exchange-transport-forked: True
Content-ID: <7683C92238791743B77F801C20E2BEB1@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29dd2095-149f-4392-8e7e-08d731657bcf
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2019 18:27:03.2773 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nkKvA/XStjoJcVl61Xnwl5c6NIsMwXZUcNdkGeDxyjgUPQTc2FzeXNEahs7YduxYqZ+IqNLH0WxMW9L3NA1FTDJEHW2yqmPebxZ/dmW8wCU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4261
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190904_112708_041722_DACEC35B 
X-CRM114-Status: GOOD (  15.72  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Please ignore this, I've messed up the pull-merge, sorry for the noise.

On 9/2/19 12:14 PM, Christoph Hellwig wrote:
> On Fri, Aug 30, 2019 at 05:10:13PM -0700, Chaitanya Kulkarni wrote:
>>   void nvme_complete_rq(struct request *req)
>>   {
>>   	blk_status_t status = nvme_error_status(req);
>> -	struct nvme_ns *ns = req->q->queuedata;
>>   
>>   	trace_nvme_complete_rq(req);
> I don't actually see this variable in Linus' tree or the nvme-5.4
> branch, what tree is this against?
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
