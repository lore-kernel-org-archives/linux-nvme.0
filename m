Return-Path: <SRS0=FbzM=CZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F5B3C433E2
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Sep 2020 20:46:38 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBE7C206BE
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Sep 2020 20:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="1ODHdS39";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rxd2zcDs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="WAUq9CZp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBE7C206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=CPLDVwiB2FTZ6/2LW+4w/VzWn83DAkbT7J0FXge2mkc=; b=1ODHdS39+S+pqcPAkctzMfyt1
	AU/QAl1CViSm9FV1lFZKyYjQiv0gDRTcWA3P8jFkmQsCxJQaMycujT+11srDHsduyPeUyPFsYaHOR
	Hts+0mnlnlQ4+TUNhg7dQab/xCRFuAoLwygU19X2KsGGiJ2QIax34ISOUeXXBVkoW2CF1YUqGCQV6
	zlEe/OSNvfWK4njbnBj29ekPZGnPwaRxC5eBe/oyNd5TQNZrWEGqB1WSxTDb+xkU8QWiYASMnZiAo
	A2FPvobOXlVsMD1nRqZsT9viNsd2Z0R58AxSDtJ1jmbwV0WXinX0nFDL1NcbCIYPx7sJWv71d8lzQ
	nfCepx72Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kIeJz-0005lO-8W; Wed, 16 Sep 2020 20:46:31 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIeJv-0005kK-RQ
 for linux-nvme@lists.infradead.org; Wed, 16 Sep 2020 20:46:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1600289187; x=1631825187;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=6Olpic92H4+b8wd52bVdVBcwgjA3ypEc4hScF2LkgRU=;
 b=rxd2zcDsLsY3za/BmkrI12MfBgQm6svcJhCsRqP6x8F/x7RoH5tGbxFq
 AuhDE5Fyp/8g1U7Te2XOz1KFmVMHo+L9dmJMdDt1N4UlYjkWN8ZDvtDG+
 Z8n4V0goFqdJGOnaEgD/iKscQJsTwwCqC81rRnPeg9JYrJ6BvBg5ngXis
 ht6XRp7nmMQ2LYejHIruLsEh476/PH7TdDGJURE4pNGJl6MKvO+kbROuc
 cLTDeQdU0ozalYQunXrDUuE5uIZD5NJkhiYQWwzvbTFDZw58Bt8IaPoGZ
 yEY4n44MyFhPdgA2Z6QjF2yE3jIu24HiihGukaNoUoADoRpO5WOzYZt4s A==;
IronPort-SDR: KAwHBqz0q5Vqk1Vuz9eSC6sAdF6hcdvD0IAAlA/PIqiJVsK/Fokj0pbizF8394tQRsSXG42+aU
 /CtJ/6qcRf/BZjduuRFeITQNMapvPrEhNrhaFw67yIRo0IuhtvsyKJT2OIwmWtQTzZrV5NAD5G
 5lHqHr36MvZ6bTUDcr5QVehNh6rB5gSeFEFpfrpn5w2UZcEFFPrjsPWWlRRClkgLmBKPhLuidU
 P3LpJ6uBo3bqlNjKF2JaGCvXBZd0bkOL0LyycN81iOGySZ9kttyAnvB0wwwrMjxoSZKnN/YU2K
 A9M=
X-IronPort-AV: E=Sophos;i="5.76,434,1592841600"; d="scan'208";a="147479811"
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
 by ob1.hgst.iphmx.com with ESMTP; 17 Sep 2020 04:46:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jcwDp2S2204gVcUK6x1orL1XjqRxWbiEQa6L5wFXnWNc3zEwuKgAj6D7bo4lj0N9V+CTBqcsgueHHukpwmUT1h2frQnN9TYhMth8i8Ew24QZyo4yIgePoiTNcJyAVXuWOp5roPU3WU6ktmxnanMoqPq0vBs+B0szEnn6FWNd43yhG+qgOKUAcoCIFsZEOSwEhRrVGUY0HKQ1qCYyvXTdxe9MEUnZohxurLoxMhau/EErhGy2QPSLLivw5DCG9DT+R+fdidDw8qtfraE/VXRyoG3UNvcAfHh32W7elMe0O0g6B8ago70L6dFaycYP86apP+xyBDAuiKuTavT3RkZbXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hg1roWAQc5Ge5kvgKs5pbR3XhyjC/2gwX/0CSxi3ObM=;
 b=cdlaC0xcjCbU0UM17df1U6khgUOC+ASLCnhhrI2yW4Y6mN3Ydb19TaXggBJcQaSj4CtxSLKXX5Z+t+2LC3UhFxdfOyJqyoArtYhHAssIojTGoo9qqJ6JJ7ljpRQijlYueP5oSbJCMp2QMIDFbqcOOs8rbYacMHEtpsYIkoW4Lspm7KutLDHru2M0W6dWtoTbQs8VULI9pU6WXJPc8BOs5Kvbkm6aWS1Yr6NweR5wq/Xll1dvnsQLeBEsYgZdsFCjLh8CVU4bggWqp2u6Kqhc6hN3d0vTLAy0apxYIZeQF/LIeXVINfUcZztedhQx9XcyoDxed+2mw2REsuGu66T1zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hg1roWAQc5Ge5kvgKs5pbR3XhyjC/2gwX/0CSxi3ObM=;
 b=WAUq9CZpgLcb51JU5C3llOUeVUD81sYN2UytIWxonNZvW5xMuLHgkcQZqugL2HD/00DpXxW5NRB/+BacmrdtrY6TdCbY8YKlAj7rf7kP3Fnq6t+GvOaqSeZGAeP4QPN8owtjFC6QpZOcKNm9jhqQrSAGyD4lMA/AMpLGa0RhuWw=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6753.namprd04.prod.outlook.com (2603:10b6:a03:221::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 16 Sep
 2020 20:46:23 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f%5]) with mapi id 15.20.3370.019; Wed, 16 Sep 2020
 20:46:23 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 1/7] nvme-core: use I/O timeout in submit sync cmd
Thread-Topic: [PATCH V3 1/7] nvme-core: use I/O timeout in submit sync cmd
Thread-Index: AQHWi6pgBR7S7YFfskqfOuEU49KzJQ==
Date: Wed, 16 Sep 2020 20:46:23 +0000
Message-ID: <BYAPR04MB4965D6D70F6D9601CBFC0CF986210@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200915215118.3934-1-chaitanya.kulkarni@wdc.com>
 <20200915215118.3934-2-chaitanya.kulkarni@wdc.com>
 <20200916070921.GA9592@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 15fde7a3-d423-475c-22ed-08d85a819313
x-ms-traffictypediagnostic: BY5PR04MB6753:
x-microsoft-antispam-prvs: <BY5PR04MB67535B6FA5433C0176D1D64986210@BY5PR04MB6753.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hJAP0Mad96JacD9rvU4I+o48Qv2PPbEbct+bpM+lnJY5AhkCxqjk2dOP6K3CY+TSajWcFKbCfGw9gZ0+AlC7i5v5z2ZPOxb2tGRjVzL5oDOUKfqxkpAqil95AS1Qw5+oOhucKChvJdHnrqB4KnszUih6UYnLKPwcC9rWI8Ng27PUEZqehSYu1wnYxUc6A37Pum3Ea/WEdkROm1Y+4RwSBt3uIP9X/tl3xlS/EwWh3q99l1ODBldk6jUpMnba/irPwQVpxejLABdnTSWT+PORG+48JiUm2crH8IWM1pPQzIzSVL6sX+JednskxZtIUnYnscQtvpb4GfEspXG4E57N/Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(136003)(396003)(366004)(8936002)(76116006)(55016002)(5660300002)(64756008)(316002)(33656002)(54906003)(186003)(66946007)(478600001)(66476007)(66556008)(66446008)(4326008)(2906002)(8676002)(52536014)(26005)(9686003)(6506007)(83380400001)(71200400001)(6916009)(86362001)(53546011)(7696005)(4744005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 5LPr+kr7H+uitKXHF3kLX37mswUIrfSr/uFKEa67Lox4ki0zV8/4ARM1wrogJ1Fnaui82cUFu3fUn9L2Gte5kAFE2gsJB5bClwY7rXdlqGqFUkpT3C5hjRmqoAExiJ4gtDwvQ3MZk8MSz45uOIzNqN0SrtOlFWSq5THs9oqval59DyuvGv2T9HsQqPwCILfOqhB9dFlBxztfQrdq1MmURwtgC74EXMNNQ2m1SRh7rPi82UNK9cx3thhBC+Cb8ONpgyHINKuHGd4YJmrz3r+g0GoQh/N1WkegS2foKIO7BnuWLso+xXXECBonGwGS0LGIflR1h5p0RUNhSh9xSMO39eiiYTVhuqtOeauARjVQ22APOt60PmIk9zDYDQSx5s4CGK2HC9h4U3NrscY+Bq5q8vv2Piz9LwAr7vBkuptNSLc8L4WFjGkK2Lw+m/kT09urTWQQzLquIJznJNsMFHGMT3tpsxxdrYmyphZ5wLYzNi1XyIS+0Pnuw0QDK7WNqKq3kyps+MXDrJ1z5moBF38GgPnmsIhOiJxKqGryNzn1udl0l+gWXAL90mZMzZXOTcLRw3kQ90HMAfDQKyCiFVyRcPl/VLAMmhoTus9FLLxMUVnCf/a8011WT5rr7nfOosBdDsoggCWIdZiWEk9kCvhc+A==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15fde7a3-d423-475c-22ed-08d85a819313
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2020 20:46:23.5212 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aNYJgKHkrfWO7HQX6ot9QfBCE1+Bp15xtGQjTaYL3czU4Lb9aNYqDGm+6SKvRW91IjDu++N/vF6x1xNOzzk0NMSEivc1Fdv49Zxx11qUJfM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6753
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200916_164628_197262_B4721CC4 
X-CRM114-Status: GOOD (  10.62  )
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
Cc: "kbusch@kernel.org" <kbusch@kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/16/20 00:09, Christoph Hellwig wrote:
>> +	req->timeout = timeout;
> The void *queuedata thing is really weird.
> 
> I'd keep the check for an existing timeout in the callers and just
> write this as:
> 
> static inline void nvme_req_set_default_timeout(struct request *req)
> {
> 	if (req->queuedata)
> 		req->timeout = NVME_IO_TIMEOUT
> 	else /* no queuedata implies admin queue */
> 		req->timeout = ADMIN_TIMEOUT;
> }
> 

Okay I'll add in V4.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
