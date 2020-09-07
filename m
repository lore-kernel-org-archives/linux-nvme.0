Return-Path: <SRS0=Qo8g=CQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDAF2C43461
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Sep 2020 11:37:20 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DC1520C09
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Sep 2020 11:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="vt/d7qIZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MLjupn2W";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="aA7rBtFX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DC1520C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=fRuPtLmwaYAkDDRLr20tOHIUBmeARTLRDYHo0RqqmFA=; b=vt/d7qIZ/BmCTRI+1vM1/ZUyh
	DKG+ocq2YNJgZnzy2s1t8FJaU9JdMS4b+t8Rc8JjSF5OJwdotGVI2MCJHhYv89FVoIvdRyOj1HRxN
	6lFGLegYXfV2tzzx7IvBOOMhWDUwrT82O3ei91EbrvWU+2nvXqsIV8dhM323WzzaIzIZuQ0AJYpS2
	hgdUHEnD6RAhjNBkbo8HB40DtZIhCVTHZPu02oFjpYCXPHIEnX/6h3HB4ekVsM8giUrAyaIEggu+v
	+Ivpxk5N35PZ5aUYSHu0hpqhI8f+F8cGiB9bxG8M/OIgGn1jugz3m9+azBtHHSxiE6B8OzZ+Xtlu0
	l4tfRj8YQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kFFSU-0000uT-Sr; Mon, 07 Sep 2020 11:37:14 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kFFSR-0000tE-Im
 for linux-nvme@lists.infradead.org; Mon, 07 Sep 2020 11:37:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1599478631; x=1631014631;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=8AerEyFqp12J8GLMrWSCgphv6T2pK6qtYls/zxdPokI=;
 b=MLjupn2WI3hLlOxia67LsjcgZHZ9lL1QvmgTW/d965d+GbvjBuCLunO5
 e6+ShjZhMKNV74jsIo9FOzun/9ayai/v6YYK9V247PuMLKdkoWiEnGbXD
 Qn112TZ/EgRVt1FGZAx1nsX3V+KlH3EDDkQSzdFmUlNdral17lcLAYyOM
 MNQEtE+S8dd5mxMrp7VFwmgeVN3fQD2wPQEGe+vta+fP5KWAiWv4kFx0X
 m0WTTcBDdq59FYnPbZH4Hxfzxek2bXJzl/JyJjpVkCKoTtfJ8gJinjElp
 TdE4SYGGNm7NgAfV3P08zfqM/VQnRq/hXhFgcsAxEWJrf2ScCw/yCcNZj w==;
IronPort-SDR: 7dI0m6ZWB5H2HJG4yiLPf4reGPvPtpb+qL/RvJXVX8YAQwfuLW9X4rKTTv/w1XU8Nqs/P3Pg1y
 DjqcPUEibuDXCbgiqFzibJ33ALVTJgDJanq5gcpbpHpYCN3+hvB6USuhULkVsi4u8rcPM0N7+N
 9gxASpAJ2YCilCpAyhaM5e94zvjcRGCu8JJiGQvyf++BPJceU9Te3J4z6ctdNtQ6ADwSgmiQAJ
 11puNbM4hPee9sYOtWMS97DvrHDY9XxcdTiIg2NhJvRDed2+BPCKz6bnDMwjZ8zqvHJNb0H3LS
 FTc=
X-IronPort-AV: E=Sophos;i="5.76,401,1592841600"; d="scan'208";a="146733323"
Received: from mail-dm6nam12lp2175.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.175])
 by ob1.hgst.iphmx.com with ESMTP; 07 Sep 2020 19:37:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fqFK1229j+V08YnUkzKb9tKoAlxiMDSG1S6Y0qydYGIvA0C8CXNQxyp2ayuUUZG3ti77oO1uOX6EJF7svKJNTwDlxoHrWTUG+Zl+l6hp7kDmn55ijGLV0J+pLAgjEr91RRkw/HY/t2cm7HZp4Nzo3ViTvA25rZ0YhEDnC027y5mB05o7N9+EF512qXZxb4OBk6Pk5bplb/7aZwTyMSoBdguJjmpLF6v4z4/Zhq/si9ULtm18p2dqZ8yCaTpYigFoVkoqvEEhscDLjNfPHzO4T0bbGVMCMxjQneQGcGN79NtJftegf0e+quwFTkMBsUzbVZNfiTS8p06y8AXgUx4/2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8AerEyFqp12J8GLMrWSCgphv6T2pK6qtYls/zxdPokI=;
 b=fNlwdruCrBuRkio0gCaMOgnlVfQBr11vL9m8kWJvgPW9F8H3lLjS2wa9okuggaKSPcsg0WyH3lUFRcRikoX86nc0Ip8oYh9VJhiG3jaKtWI1lxd9fvnC3FubiPtckbcKdM1KgF0GnU4rUfifbTG84F+VaNXxxGZYoZnU6vWSa8Vn70teX5jqThtKpKB5eIazTpW0dy5DJjEXg01Z6S/TqtejrkV+A+lBNfN8UjZ1tnYZ9nSxNzDijN66NYBVnp9Yw7Y3cH11P1pIs9ZVYDuJCo/Mkm0QBZGsjfpko/FzpTcBpoEDN14ZWI8zBJ37MAl7xa/UQZCY4iIcKWUibPCQUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8AerEyFqp12J8GLMrWSCgphv6T2pK6qtYls/zxdPokI=;
 b=aA7rBtFXduEfeWw+Ca9WSPT9kLVaL4IVvTn8uJ/KV0kskhU+vYBTADu6OEdERrvctTbDce41z0495X3/EQTvIg54bEJ7UEASza0eIn3mHXub0hQs4xLcK6vTkqJGT6lI5xwxBwHR4+BHeyfHo0frZnObfNQ6+VjxJQ6b4vuj2ww=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR0401MB3633.namprd04.prod.outlook.com (2603:10b6:910:94::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Mon, 7 Sep
 2020 11:37:01 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3348.019; Mon, 7 Sep 2020
 11:37:01 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Kanchan Joshi <joshiiitr@gmail.com>
Subject: Re: [PATCH 1/2] nvme: set io-scheduler requirement for ZNS
Thread-Topic: [PATCH 1/2] nvme: set io-scheduler requirement for ZNS
Thread-Index: AQHWdSEIMmCxi6h3l0CfpdyAr+vLMA==
Date: Mon, 7 Sep 2020 11:37:01 +0000
Message-ID: <CY4PR04MB37516303D8C5FC32FB530FDBE7280@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200818052936.10995-1-joshi.k@samsung.com>
 <CGME20200818053252epcas5p4ee61d64bba5f6a131105e40330984f5e@epcas5p4.samsung.com>
 <20200818052936.10995-2-joshi.k@samsung.com> <20200818071141.GA2544@lst.de>
 <CA+1E3rJg0QOX4YgwWJf8Sm=6C-un4TsRX00E31fbFFPT9LYhXg@mail.gmail.com>
 <CY4PR04MB375148979AA403CF47EADE0BE75D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <CA+1E3r+C2KQENu=fO_+FZoUEvqZrAQcxziwSGt=FVidv85KQxA@mail.gmail.com>
 <CY4PR04MB3751B077D152A80B19236C20E75D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <CA+1E3r+0+jThD2KEu-d4rB=C4xL3Bb+cD=jUDbsGGBKR_GMpfQ@mail.gmail.com>
 <CY4PR04MB375151ABDF83FE0A9804C3EDE7280@CY4PR04MB3751.namprd04.prod.outlook.com>
 <CA+1E3r+sN8n6-ibJ1v_S5HEdfhbJ8yAYTm5ja=0M8ng2ujLZ4g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:2cd0:86fe:82f2:c566]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9150e58f-c4e8-4187-6ef6-08d85322568c
x-ms-traffictypediagnostic: CY4PR0401MB3633:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR0401MB36333B4099992AC8CC8390A5E7280@CY4PR0401MB3633.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qxWSETqZXFPg6jYXinbGxdkHFklA+MlVx+M02LUyRcLlfE9o68reeNU4zzz1lxRlHTsLfJAg4DwbOZCeMgL0uUMwLJeaBomPcTgZZBgoDliHrta1naUOKXzWI5p5x3bswxc3ZhNiJxLr24v9VbK2rbZb7/FqpOTIg8pWQhTTOlcZQPBmrtC/z8R/sOdURvvW6R5j7UVi1zMeco6CgfgDOUUo1YzbOlsWW3LGOHRpcX7EIvhOd0H5MjYPWvZ4hUcvsIEKg2dlT+7k6syjRAkb6N8A/xweJYElgi7Tnr3XlHDN5xY6+lYihaHmqSSPWy2y2Fnai8arYk7CKfZNn51a8A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(376002)(39860400002)(136003)(396003)(71200400001)(5660300002)(52536014)(54906003)(4326008)(33656002)(316002)(478600001)(86362001)(8936002)(55016002)(83380400001)(7696005)(186003)(2906002)(9686003)(76116006)(6506007)(91956017)(53546011)(66946007)(7416002)(66556008)(64756008)(66446008)(66476007)(6916009)(8676002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: kr8ddXBWXZXauzUxhUkLh02rqqOIEpX5iMkGl8QRe4LykP/z13CFNWyTU/9+JMSOJCFiVTTquZZHDu0jJQf61Ik4J1/L9DprMosiYlEyxj3k/9SfROebUJ1BDiRIZ2sSjwEQm+WgwyHRS8SJgHrAv9+zQhcoY7FkR1zGT+6bqplH2aW57pAAk0CAbevh63/Bn1CEkD0b6PRaC/lOVcDJ0SAM5IW220OGTKh+vNNhfIEnbptIflLwPrXZbw+fNd9Imbj4z/E0qsXyJYOHXIzIMfgs3EZo2kd96OmKhR4Lco5OwCmvhjQwmS5rmNaeMgA3MqzMKM0u1Z70AEQJ+gZsvWBYPIQbqpiltBaAZfHiJrLNJNi8DGBdAUyYZzEpEXTW8FWbdgLzlC0G+vVJLRxQp3X6JAL1ScBfIUX5A5i2vyAv60UEm0YKGEb9Q6IxL1kvzN+3MH81dCSONU316SiaCiPdeXgnzKAeyG491IO9taBm81CkFGQryD5tpcLjMKFHiazA7cob3A+vMb2KjfQunM0RbWa5u2vqdfvjbZY8SX/B/Yn32kOiwqKCcZ8v+YUbzyQqsY9qun4rSeWJfsHQaE8NndVGaymNvHbwPByuMjc839TCz9sfg20R/nryQnYrDUGeWafhQ1V/2aY9VM+MOYXsO/8+nKZbLiBb03hj8tApMo6kugdvgiz/a9C3N636RCq2kR3ylw2fpKmGZBb2dg==
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9150e58f-c4e8-4187-6ef6-08d85322568c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2020 11:37:01.7293 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dDjYt82nWwD8iDiRWYHysHMd00OYrfDbBZnV27LEQHcxK4mMrRgQDETDGE9nR2HPjiQeH+VDTPochfy5XXXy0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0401MB3633
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200907_073711_774256_BB066C72 
X-CRM114-Status: GOOD (  18.66  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Selvakumar S <selvakuma.s1@samsung.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>, Kanchan Joshi <joshi.k@samsung.com>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Nitesh Shetty <nj.shetty@samsung.com>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020/09/07 20:24, Kanchan Joshi wrote:
> On Mon, Sep 7, 2020 at 1:52 PM Damien Le Moal <Damien.LeMoal@wdc.com> wrote:
>>
>> On 2020/09/07 16:01, Kanchan Joshi wrote:
>>>> Even for SMR, the user is free to set the elevator to none, which disables zone
>>>> write locking. Issuing writes correctly then becomes the responsibility of the
>>>> application. This can be useful for settings that for instance use NCQ I/O
>>>> priorities, which give better results when "none" is used.
>>>
>>> Was it not a problem that even if the application is sending writes
>>> correctly, scheduler may not preserve the order.
>>> And even when none is being used, re-queue can happen which may lead
>>> to different ordering.
>>
>> "Issuing writes correctly" means doing small writes, one per zone at most. In
>> that case, it does not matter if the block layer reorders writes. Per zone, they
>> will still be sequential.
>>
>>>> As far as I know, zoned drives are always used in tightly controlled
>>>> environments. Problems like "does not know what other applications would be
>>>> doing" are non-existent. Setting up the drive correctly for the use case at hand
>>>> is a sysadmin/server setup problem, based on *the* application (singular)
>>>> requirements.
>>>
>>> Fine.
>>> But what about the null-block-zone which sets MQ-deadline but does not
>>> actually use write-lock to avoid race among multiple appends on a
>>> zone.
>>> Does that deserve a fix?
>>
>> In nullblk, commands are executed under a spinlock. So there is no concurrency
>> problem. The spinlock serializes the execution of all commands. null_blk zone
>> append emulation thus does not need to take the scheduler level zone write lock
>> like scsi does.
> 
> I do not see spinlock for that. There is one "nullb->lock", but its
> scope is limited to memory-backed handling.
> For concurrent zone-appends on a zone, multiple threads may set the
> "same" write-pointer into incoming request(s).
> Are you referring to any other spinlock that can avoid "same wp being
> returned to multiple threads".

Checking again, it looks like you are correct. nullb->lock is indeed only used
for processing read/write with memory backing turned on.
We either need to extend that spinlock use, or add one to protect the zone array
when doing zoned commands and checks of read/write against a zone wp.
Care to send a patch ? I can send one too.


-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
