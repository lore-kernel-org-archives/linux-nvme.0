Return-Path: <SRS0=Ft3w=2H=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFBDC43603
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Dec 2019 04:53:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D8E820733
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Dec 2019 04:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WVUQs4ql";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Uu4ZnaOl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="XU/ofhB5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D8E820733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=7urfsiFbumBtaD408ImO+OBcvXDPO8UcvilNhIoNQUM=; b=WVUQs4qljuBhOL
	CFvR54+LxFdFMPkgdautQs3gbUv6G2iPDAFbJy6LlYlOpzjWTlezLSd4TRBqbVJYE43JaAx4ymClE
	BeW3SsuiYY8BetgOMGnxivsX/auutHuEmScfbSgF/Gf6X7aOdTS0A5fE/EvbDu/Mm+R2RluDiYc2i
	Ze4Oe9LFbdZT5m9MbE/lpib083DZkgb9RDXVhr6wicaa/SrpN0GoV7UMYX84vYcyX1BKLEDEG1oko
	JsRLb2Cb9zrau8sbVaEAORvtsOeFx51GEsQKb1iVJa+34TgEKvrXkPIUMvjXdLopyKHYDo1QYymdK
	eGwbFAlYHEUOQ512Lhtw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ih4rk-0006lq-MG; Tue, 17 Dec 2019 04:53:48 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ih4ri-0006lQ-5v
 for linux-nvme@lists.infradead.org; Tue, 17 Dec 2019 04:53:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1576558448; x=1608094448;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=3Qub2lveADvt5Ot0Y9XCqgBqecMVoo+1oPQrD3Q9b3M=;
 b=Uu4ZnaOl/oLR3qr/sm9BBjjTCXQc2DdGFe728htY+76qvyYReDOCBLax
 CaAjlB5Dc+4UD7J+80Gyhr1A0rkrL1NnU6MsqPfGhk2GV0h363Kok0DJC
 J+gmpCktorc2buAMq2nffEeK2JwPw76AJ1M15Lwzag22UWfOlb3Ufg72+
 l4VPtbDdZovaBdjAHfUWmiEdfrzSvBiipHJwbgVA/WqRU+xtfCJEa9GUv
 /mXq/te5K5RIu+FFqfnLc494jjUZC5LZIEmVWiaN1/JDt0vdeNToNMYew
 cQD/ynplHJv+tALSSQxPvuMz9PRPzAsnOae/oF+psgDf5LcOS32xOX6mk A==;
IronPort-SDR: 2waC3/Lh1YNrR6IrHAEbIKlgpItnKhcOINhaNUiTshuFJaNEKu+d7lBEcnekXovXM8RNVNGUSA
 UPU68ECo19vVbLjzGMW0to3xsWhJ3qvlgvVhtvnrHO9DHVjGJoZNKgiKFqAuO8kDgVw/1pImHQ
 0EFuP6mZpEWeZQ/+UFGuxp6DrDdGpVlqMO9KJOmZxNKiyTxQ+dGHrGw4HQC63pHHCPVnt5A67+
 O1u6LX/gAN7osu6Bwv/sMBOSN84vJzOrq4OOHl731OldFrKUUamPfK8IYz3tN1NGPiAxtDUmRk
 +GA=
X-IronPort-AV: E=Sophos;i="5.69,324,1571673600"; d="scan'208";a="227082929"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO
 NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
 by ob1.hgst.iphmx.com with ESMTP; 17 Dec 2019 12:54:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h9+4fjqlKd9i63xBd8iUkuNZYwaUSFXvcRK8W49OqO5APGs+ynBZbNg/73x2Kmt2k9wpitof1uoXVVHtQUTtFlb5tA5e0oEuR2M2v3UC/Ng1L1bxI0w/nKMO65L/aYvolDaDre/a4DxcXnPYxPViM+tS8Hr7TZfeyP9XxwHs6xHqgQQ+yLGkxsYJnoBJ0m05jIGPvgcCJFBuGazSdYAi7RqB476GCX3of25r8KdQJQ9ws60iouQVdez/8uWbysrNFBQGMF1s2uMwYNpNgxEZcZYHOyBjb136KVEEsxp5sxgF4Ww4iIEL6p3Jd7S0EkYvb28XAxSyLtfT8LZYJ3UO2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZMRtZTeH3KSZt8CJqnV8ObOvGAfsQmPpYHfgQ8rr20=;
 b=gRuKimWFfu+l8CjDYdW8OvJaRiaCR0Ujqo8UN8DpDnlIi3Baqs4cI5pl3wHFeTsdeqNGs7IrlVSemh9+ZUCl1N/dkN7yzfm0NesA9I3auf4bjcvkpgmuBJqtlJUo312N5htRqTviVxZHkq9G2LwLGAa/Tg2MlxzH30SsIzGO7Vsijh92ZQyQ3h+p+Np+41Is5Qi9L1T+189wOcDil6ltC1zV15SGE8xsw1RvhZlHMDvDoiHnbXFzhdMv9tKc6gcTyR7KYahYSniEJXVWzJ3D30JlQuN/QwS5edMZR7EH3+CkYi9zow17OyopuAzhk8MXA/DYA6U5FTomvL9a4qP3iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZMRtZTeH3KSZt8CJqnV8ObOvGAfsQmPpYHfgQ8rr20=;
 b=XU/ofhB5GEVMZh7exY1gJ4SYf0wVl/zp8LSur5kRCKBdFPqVm2/ckEeV08S3pWuSZP9/grLBcTObwDBkoGZqJsMJ6oWCHzb0wjy0eS5N013PUcUDdwNRDl5X4/XVmWo3ZYKLXErhoCeotGth/Hu/jbSxf5ko0cjOHdB1/t0DcUI=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB6230.namprd04.prod.outlook.com (20.178.234.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.16; Tue, 17 Dec 2019 04:53:41 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f%5]) with mapi id 15.20.2538.019; Tue, 17 Dec 2019
 04:53:40 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V4 2/3] nvmet: make ctrl model configurable
Thread-Topic: [PATCH V4 2/3] nvmet: make ctrl model configurable
Thread-Index: AQHVpQa/t8A28IAfGkCPkD6H8eHh1Q==
Date: Tue, 17 Dec 2019 04:53:40 +0000
Message-ID: <BYAPR04MB574978E89ED3B85EC3C5360686500@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20191127094034.12334-1-chaitanya.kulkarni@wdc.com>
 <20191127094034.12334-3-chaitanya.kulkarni@wdc.com>
 <20191212092842.GI2399@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b8e7c4be-5c41-4a38-ca81-08d782ad1613
x-ms-traffictypediagnostic: BYAPR04MB6230:
x-microsoft-antispam-prvs: <BYAPR04MB62309A4693D5F9467B9DE88786500@BYAPR04MB6230.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 02543CD7CD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(136003)(39860400002)(396003)(376002)(346002)(199004)(189003)(316002)(55016002)(6916009)(4326008)(478600001)(86362001)(33656002)(66946007)(54906003)(76116006)(186003)(81156014)(81166006)(8936002)(8676002)(5660300002)(64756008)(66476007)(66446008)(7696005)(6506007)(2906002)(53546011)(71200400001)(9686003)(66556008)(26005)(52536014);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB6230;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nEehd9NA6LLNfgN4oUBjZnt6yJV2MLOQ3p3+Oyd0uqxWdGgyRystct2O4OClcckRX8IEiXhdDsCZbloT0x+b+8iDpMc0kyCRkU1rLDmd2Hhgg4qRTVnAzXCnBI+nrPwu8RMar5Qk7a2mj6vEqDraShp+5aftb21cpoinOK4aXzZofCsrxSvM1PpyDaupcPasdS552aD28WFaDFDyHlBrCNMO4otsiaTAlRZdDemQumNWY7mrhjZkHYqFMkS04la6HERlK8SLEceHjKLE2xNg/OJsfgUm8lvqGkmOdtkctbrUzIZHq75f+0yuEbRB66O3LqHyG08M8BRq9vw7gNds8FP8zhReNzmmd/qUFvuEaRk2x/lW5E2s0b9E8yJx9c5PkR+mBAiLCC3dgYPNhELvDxZHyIDncMVyNuLqBjxnwNs4H9uRl8Fvhk0jRTuuOO0Q
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8e7c4be-5c41-4a38-ca81-08d782ad1613
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2019 04:53:40.3815 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B/2rJ6q4jdWyegTr3awPBYWxqt4gZZhDnqtdTdbV11ILv+vbHoeP8IGWoG/JUsOfLa+UhDKjm8ISPPYdZua8TyaqAJ+rbmCS1rbVnu7csOc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6230
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191216_205346_429828_85056E1D 
X-CRM114-Status: GOOD (  10.44  )
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
Cc: Mark Ruijter <MRuijter@onestopsystems.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 12/12/2019 01:28 AM, Christoph Hellwig wrote:
>> +static ssize_t nvmet_subsys_attr_model_show(struct config_item *item,
>> +					    char *page)
>> +{
>> +	struct nvmet_subsys *subsys = to_subsys(item);
>> +
>> +	return snprintf(page, PAGE_SIZE, "%s\n",
>> +			nvmet_model_number(subsys));
>
> This whole statements easily fits onto a single line.
>
>> +	down_write(&nvmet_config_sem);
>> +	kfree(subsys->model);
>> +	subsys->model = tmp_model;
>> +	up_write(&nvmet_config_sem);
>
> Without using something like RCU this means all users of ->model
> now need to take nvmet_config_sem.  I guess using RCU here is simple
> enough - just use rcu_swap_protected and kfree_rcu here.
>

Since this is not into the fast path subsys->lock can be used for that ?
(and in the helper nvmet_model_number() ?)

OR

Is there a specific reason we need to use rcu ?

Also similar pattern(use of nvmet_config_sem) exists for the
subsys->serial, does that mean whatever fix we do for subsys->model that 
needs to be repeated for subsys->serial ?





_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
