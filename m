Return-Path: <SRS0=yPeo=GZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C15EDC433E6
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Jan 2021 02:54:51 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B95B23884
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Jan 2021 02:54:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B95B23884
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=VpU6zShxjrcwzvLyPin3wwPVzhD7EC2OGeAHZjbWB9o=; b=G7xVv8Efp9FkSl/Xnd7tgXVgK
	iG0k3BsgSAPvn54iB+Z1BymxiveINAS1nCcg9FYtoU/nYjoonnGKk2LbQY9bjC2wyiF8/8wlvxe20
	vWVPHdIJyyxFXX8GBdKqut/rMoDAJLljJYgyvqTqKwiAdGw20CcCpVs/o4sIHx7MzEjaDHyFNGH46
	8dLXvkpwdJXch6snEBnD6fyPl73WQU4LIci7/gMYT3MqXkyQBV4DyLJTEiHdKjp48c/cDxlZ7pGIw
	kPLEuFP0+z5OyTMQ3XCq097KtUjeZbRar+BQDkmko6uqpLoMMfGF70iB+2Q0BOYFj9ssU/u/rIbah
	d9wS0YMhA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l2mah-0007uI-FC; Fri, 22 Jan 2021 02:54:27 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2mae-0007sk-Cg
 for linux-nvme@lists.infradead.org; Fri, 22 Jan 2021 02:54:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1611284064; x=1642820064;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=K8hXx/xNKuFbZlMgfXkcykYeE9fW2AaPx7nD0ft1pJ4=;
 b=mwg8qtrtaLDC60daFNJxW7xkMMlapsv0tnQGMcXzFUh9JLm426Grm8hc
 8aex/aiZcxrMqIG+gysxNUoVm3FfaGBfHn0brVHU9rmr/7JmhU+c26rmu
 qN705OlgcIz+aDSmhcmWp7VXXqCIlFnnmUAkiDofcEiEv2sFxe89hecuK
 OOjBVcVNMlyFpkHJD4QHHDhtXX8rY5UL7DZWzziAs6Hyh1HyXDl31JJbv
 xxAFlnPvUFo7xVXoPzKrqRUE+3Muh7R7B+4/wnnN8fb5h7PdTCqUDDz2g
 Lyy2t1bNL7TXiCAN7TB4WWISIkCc6JQ6shJODEELc1Ao7X4ky5nCAqeUu A==;
IronPort-SDR: P9nvIWiQOaDqIip2ua2Cw1cAtwJd6vjIT2aCyhRQzIbsC+Ywre2LsQfhmenHN+lwbGkKxXewCu
 rUmNsTjuXoukpA/ER6EaGJuHh0ypENEdUPeUBonSWhQlYUYph9MsIftXtLa4/hTgWoPGjOJGw9
 rI4SqvDvBqQmQlSgO7yfWD7NHCuSGetEhLfSYFhoHph58COHX8R5/c8P6xuqhV2Pj9I8PaCiK6
 6J+QFnXcMuA3oldpW/5+uayLnF+J6G4maG4877YydSKeZFBNT6wvUvfwTNATASnlsBtqvi4EGY
 8Us=
X-IronPort-AV: E=Sophos;i="5.79,365,1602518400"; d="scan'208";a="268380847"
Received: from mail-co1nam11lp2175.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.175])
 by ob1.hgst.iphmx.com with ESMTP; 22 Jan 2021 10:54:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RIoumBK6yACXgViYGO0ioD54xyo3w3T83kTIFAiLYQz76wcS5B0j/4OcoPJM5pomjvOnb0aQE0TV12t8vuFw7i5FfcQTXRS4uqI41mi6XIQVMY98iH3pYLJVlZJinU2lJP4Q3q9yiPrJT8OTqSzg9/++ijTXIikRdE4HXe3PqO7B4/aoijo/dcd+yp7Tje8DdAj0DFu2I18htITyBM9M7bywl3WvjUYiargm4iuNR+KoN6NVnBIrY7HXlbuUP91O/WV6+NfdmdkNRTvq2Zf7B3AaSBkLzbqwRMoKlFEp1MA0Fy9F3U7EL7XGvFdR2+O9xUHPV1Y9Og96/SM5OOuPxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1BPpsOZ9jsFRHpUBvktF24NMwt36kMgE2ILzAVgrL0=;
 b=TiKVEQoanKfPBwIboq9/CHBc4h4fwyWv9x+1IMBWMl4e+FeOKfkBywZYDvFfZT/VQJt0nElpe3tz4NY0UxrgUnfivFviZC8K9rqislYmiUlkLoiOTmQew8q9KhUpAYHbtqawtLRyyEg288vu3j5wlndmDL8Ax7srmmM6AKzFBUjBGFjF76RysnEA/jmbpj8XERN+Kxvpr4rQeVn7B6KyJKrri3RkhC4baHTMcPJt+0syBj6EUjGCO6Zc7WYz7bc4RR9a7kOXeJkrVcrHKrrwwnY/HjC8yY41uoC0r0j0PsokZfuNSENDJNPXgRnJovnu3mdky1bc+f3jUrmkV72c7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1BPpsOZ9jsFRHpUBvktF24NMwt36kMgE2ILzAVgrL0=;
 b=zWhvqkOeWz5mYWsafuybbKG5nDOgxc+Qx9e6s/4weq3xUKmGOB+5tSGzy4q0T2WE3h86fiZM0ootSPX6Z6EkBjYB1hsnDPzzXSTtZ99PP2359FZ3qG7HeRZ1haVoebxHjGcEg4IK59ufuscLWDGd6EnxChMOYc2UaUCid19Ak5o=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6898.namprd04.prod.outlook.com (2603:10b6:a03:22a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Fri, 22 Jan
 2021 02:54:23 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a%6]) with mapi id 15.20.3742.014; Fri, 22 Jan 2021
 02:54:22 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "chapman6235@comcast.net" <chapman6235@comcast.net>
Subject: Re: Problem with SPCC 256GB NVMe 1.3 drive - refcount_t: underflow;
 use-after-free.
Thread-Topic: Problem with SPCC 256GB NVMe 1.3 drive - refcount_t: underflow; 
 use-after-free.
Thread-Index: AQHW7QO5MtNnJXjl5ka4VClzrgzGFg==
Date: Fri, 22 Jan 2021 02:54:17 +0000
Message-ID: <BYAPR04MB496526DA2E74A513E528D3E986A00@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <f50bc59c-db11-bb44-55be-7b9db1119872@comcast.net>
 <BYAPR04MB49659C0F0F0E11D166B31E0586A40@BYAPR04MB4965.namprd04.prod.outlook.com>
 <a4c75497-d170-1e0f-8608-282231ff3a8e@comcast.net>
 <BYAPR04MB496542BEF594F0380F7D41CF86A20@BYAPR04MB4965.namprd04.prod.outlook.com>
 <df46d7ce-ce70-1f43-0efd-7153761bcff0@comcast.net>
 <20210121124459.GA156577@localhost.localdomain>
 <96083ad4-e065-c071-bdc9-67517dc1e5a3@comcast.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: comcast.net; dkim=none (message not signed)
 header.d=none;comcast.net; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2600:1700:31ee:290:475:2d41:83ae:3ed5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8daa0b1a-d90d-4057-9513-08d8be8105c3
x-ms-traffictypediagnostic: BY5PR04MB6898:
x-microsoft-antispam-prvs: <BY5PR04MB6898A135B7E1599ED466342F86A09@BY5PR04MB6898.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dTiI5svd6QwrxTxh8oMSHJ70CnofPACU3/nx2h5uMaJLuL0sX8h5G+VVZ51gXNKGzabbzzbJ68+clZKec1V8WqJDOORoW4KWavGfRfeojaboCWH8cASPGdEQyu7rC/0GQ/ghEzuji3IEBnFoR3k4vayWX2U96PzXapRJFodyOh/kY0fgSXUqogi3ZxyhIxHZZooSM4vp5iaBU9Bp8hkG08mcAe8gMnJhf3Kw2+Taf5/1jD//piUZ1LjxYkyK9TBF0bPw5WXNMRGhBbX1gdbXBkDl039t+LOvXpq29kktCcFj8nk449ra+p7JOMzzoLb57uVA0d+JdC5cCWiwB/i1qk00w4Pyz6YM8AAUWdlVcs+zs+GDnWMH2ldkMNoDiz2ZhtK6WtvhpE0RJbyY8ggKYQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(71200400001)(55016002)(9686003)(8676002)(2906002)(86362001)(7696005)(52536014)(5660300002)(66556008)(76116006)(66446008)(64756008)(66476007)(66946007)(6916009)(83380400001)(33656002)(4326008)(6506007)(53546011)(8936002)(6666004)(316002)(4744005)(186003)(478600001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?CxebNld9t1J0RfVZOit041/pWJE7pqxLMXgmxh8Lb9arQCdOr24HmIhmVQ7m?=
 =?us-ascii?Q?ZyBAM/ixaULx1d1EWOV3E8p1CNLLnyaGj4yeMSRSOks+q5aTeTgerPYwqo6s?=
 =?us-ascii?Q?wtwDnIHn/wFu4DPg23VgFFaEpkOFhFyVZrXpVoqOuNpYeeAKv5zE03YE96vH?=
 =?us-ascii?Q?e/iOSi0u9V8+zmvDEUttvUqf2kiQqpw6iQPBUBNGTATEUQleMXa1LhIQ4W0b?=
 =?us-ascii?Q?6irgvDumQwxdM8NwkX9+IXCqBoHaDVg0PiBgFn9fDOJUD5nnXMzXhJDbj1kK?=
 =?us-ascii?Q?fRN6mhVMTVrA7gqBS7P5T1gYg15n+6Jx834Mpt6ZiijpNwwVQ+67KUR5hPcX?=
 =?us-ascii?Q?TVoCHelUas1mdTeA2it15LvTOX1tbhs7cgmE9O8FQ36VWJeJwGjTyuZ0dASX?=
 =?us-ascii?Q?Ydb3kTub0J0Xv9hr0lDHVeq6kpvX1Jm+97u7+vaYa55GSwXzj1v113MHrpEY?=
 =?us-ascii?Q?RqjxhtoPko/gUX1pBj51djy2IYy2t+cpOVX5G7JbAX2Oem0SZtxtqx+DJ5wz?=
 =?us-ascii?Q?oqqHGaLF4hTzQYwvU176Yc+QJ/0Z83tLfZUkut5lOtNGAj446XSfXgZRSMhi?=
 =?us-ascii?Q?ekK5ZEWz7PaFvHLr6N0DwyQ6/2Mqq7qwqj6om/DLuP04od9uIcNoCL8ohKXg?=
 =?us-ascii?Q?PErFKmO8hzwQ+OeHGFLAdQSslLrHdCfg6JMAaFg00H8TYWUdvM1Ra08gooXQ?=
 =?us-ascii?Q?G32CNT0MPtMvZj7060KOkcefKUboFxL3/Sia1Ob8bcENxSSiu6zZHprk2xew?=
 =?us-ascii?Q?nkFVT8fzE4AkKYPfgmnd3Z3xPOGFZ95ydzyZuQzBq1Biudjh3S+LX/OL/I2D?=
 =?us-ascii?Q?X4Mg6jwjY1xJ5FFdJ0uoF+GJzAWe6K/GRwL8AG7O4NnQY8chjc9uA+JGyaUQ?=
 =?us-ascii?Q?I8jcLjpgalJg1PeFLLHBTK1tZifw3bdLb1IvCxo3mIRJ2cpPRpgWyXq5YLIg?=
 =?us-ascii?Q?79DxMU5ok2Lz8qoC6zY5N70T5qqGquFU2qQ8sNpLKWvpy+d3NXtj38/URi/4?=
 =?us-ascii?Q?S+d93GwWS5P1vgOS8pGApsIzZQVTCDKm34q1e0rTaDmgc1naXotwh+mcLCpU?=
 =?us-ascii?Q?ck+d+tt4?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8daa0b1a-d90d-4057-9513-08d8be8105c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2021 02:54:17.8034 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 25SUVezlk6ORjyaj56KDm2+uj1nJv3mKJbUW1AGiDBJTyxuoAj7OowHp8Hp4R6sT4Vrrcq7Q858EqpCfs/3Kw2djlQisjqSOtqDINFC8AP0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6898
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210121_215424_646547_911B22A2 
X-CRM114-Status: GOOD (  11.98  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 1/21/21 6:32 PM, Bradley Chapman wrote:
> Thanks for the pointer. I've downloaded the code and will add it to a 
> stable 5.10 tree and a 5.11-rc tree and see what happens.
>
Please use the latest 5.12 branch and boot into the kernel.
If you can provide device's vendor ID and device ID I can cook up the
patch for you based on 5.12, will be waiting for your response.

These IDs can be found :-
cat  /sys/bus/pci/devices/<your device id>/device
cat  /sys/bus/pci/devices/<your device id>/vendor


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
