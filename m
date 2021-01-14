Return-Path: <SRS0=kiw1=GR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850EAC433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 03:35:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21CD72368A
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 03:35:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21CD72368A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=XnjkuzxuMTO8w6T53ZY5NRYqWcuzEkCbTE1Q0f9OPoE=; b=TZ9tSvY6UgjTllNlBfpMCHs4X
	HANFtb3K6Kzbu8KKhAVteeNioHWXuyqboeUJaBpMe6lUib/F9Bg+vxsPDJnPLGx0p5iUEMjC+SJrS
	gUCM8zZtiT9+3p6PgVEaQL7zwdc1DKzuyZeALFdeychzkwcul+b738M/hlJhmEPR11JA/Jrb78SR7
	QUYFBNdM01bXue9DlQFeQ+9UNP6UqjwhXeoV3s0gxdrKgiPO1Sf5vPNSclxefoUaE6i/6Wu1om9e1
	higZYDXvrKxOdDn9bVFN0Y84hg4btXEBv5FulYJlNXiRaFbTSws5Nt+IkHae91O7Ht23veYtAO2ni
	XKCJ7JzLA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kztPI-0006LI-7P; Thu, 14 Jan 2021 03:34:44 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kztPF-0006Kq-8n
 for linux-nvme@lists.infradead.org; Thu, 14 Jan 2021 03:34:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1610595281; x=1642131281;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=BCf0/ppg7yODYZE/KIKp/MqSUzazPrejo4kgWb+WrbY=;
 b=VkVJ+HJtegUn91dn99PNAd+Nf728B6lWGocnYmvBfbbz/+B4+IgvyUBy
 wZbwCAu1vd55R6LmkVoNZic1IQlhzpwNgV7Eugj+sKpmb0VTtrcYR9Y8V
 X4TEk/OUD9utbtjmGS6zsRghcf4iwwGoCQOIpclfMoDk5su653NnKqAB0
 WnYgbodXLzLTz8r+dKn+IresMZcS6lFrj1+PIODih6M3n3w/BHZq4eV+O
 4KbW+NpdW5NBt1SC28QgXPuope8OUlPPRCa5wQtlBjXWYTKG2hSl9o5mD
 7M0JNDzRnbcQ9rIfo7MS5+lZRmnJf5PKSG1UU8iXQUnHFzfXqZC1fj8RM w==;
IronPort-SDR: UhrJM/P61csy/vtnGY7Ot67rmOnRF3mKP+cfWYYdUuEeJFre11qcYytyuaMDNbtoaoxCU2lNfq
 Sob7gxgry1NIiSnJ3gym4DBIIPhfXLyIa1qZBeIlb6/p6MzK7WBrF021GmOVgGJcryKCYRNXMe
 URsuRPHBDk7ohWsLyKBaz7sCEspb/77xrpulI4mSVFcWWcRHuY31YFY2GfjhRkjUbH3XJKHplr
 E7sa9VQdFtGPdgG0cJJr7zYYLNrDB/sYS0aVd/+Wd7rj33v4mnx4Y0b3KNDwfQQcshOwcRjRUP
 kQ4=
X-IronPort-AV: E=Sophos;i="5.79,346,1602518400"; d="scan'208";a="158561450"
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
 by ob1.hgst.iphmx.com with ESMTP; 14 Jan 2021 11:34:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ly3VPZ2mS4OPtUP29JhOIvnrOwgrHMm9b9u7Zr359aVYAL/bAcF1SG3kVC5SMQMv6xyDuNnGPyr7IX0XTc+e+MpcLafJbEgrUr1AEJq6UEYAY4GKZsNTv39bRIIcIKNQgBfsmhOBpAzEIZAG8wasF6ThAy/FnWzrFo0D4O4CRHDHhPeVzyLe+BCFa5VDCLB2M2bAOG2Vdt2Wmlrf3xCm6Rss540O/3JNljRZBfWxpDD5XSZ54rLHCO9YI9XrE0OoG4DaBRa4sISorbXMnUEKUJB3ANLucs6WkdOQeCJ8vetELMaJI2EFXjl8stRxOCOghUX9bxwmYuccgyW755q+qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BCf0/ppg7yODYZE/KIKp/MqSUzazPrejo4kgWb+WrbY=;
 b=Drhxj/RE5snXt5/hwvjGy38FDO6JFG+MKNGOPgBKoJ7LVS02LvgAJ2qD0dkop/a+EjEXFnHDcFCOgQcE0rHx/35whTot5zlL2ujJVNSvFWY4mmf7ZV+uoCvyagehiWxbKNCI3+8wu2R2mqYlNLeZ1NA9oux2anxMfAAOOkbpyQPWTd2iQkX7kZLTslG4oJzpkh1H8pZUCPU2QrEhOaKek1/U/+corPil4UknGuEukcnTWLujhpjSwPbCycKUCT5A2OOsl9a0rk19GL/DVKpHO27F6P8T9a+PGkaG4vl6OG4AFR+HsMTkAlvHoIV9ZZrdd/QRxwjpMJ/8dgXzApP6IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BCf0/ppg7yODYZE/KIKp/MqSUzazPrejo4kgWb+WrbY=;
 b=vu7izGZzpVGEhFgF0BckKeyMqD9sPJdAaEio7STOAjVli9Wg6FUsWOr5wJr4LeoiXFkJPCdGvYPbsUyy4IIDVBkDPCR4M45U0ksjcMxGsHqDKl0MSc6mkE6q440RL3dTE5GhxUF7bjX9UT2XHO/mkV639+dPvpn/ARfQqaIbbuY=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB3861.namprd04.prod.outlook.com (2603:10b6:a02:ac::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.12; Thu, 14 Jan
 2021 03:34:37 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a%6]) with mapi id 15.20.3742.012; Thu, 14 Jan 2021
 03:34:37 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH V4 0/4] nvmet: admin-cmd related cleanups and a fix
Thread-Topic: [PATCH V4 0/4] nvmet: admin-cmd related cleanups and a fix
Thread-Index: AQHW6hVWRywAQoWJNEOvC6w9KbNL1A==
Date: Thu, 14 Jan 2021 03:34:36 +0000
Message-ID: <BYAPR04MB4965B8DDB144D6B6B09A0F8386A80@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210114013354.33946-1-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2600:8802:2700:4a05:7017:af91:deb0:d174]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 677f8436-5260-4e04-9676-08d8b83d517b
x-ms-traffictypediagnostic: BYAPR04MB3861:
x-microsoft-antispam-prvs: <BYAPR04MB3861EB3F8761B1F413C658C086A80@BYAPR04MB3861.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SbgJfaVOGl7mAzY5BlENiKrVf4JLrQhLyGnTRBewwtINQUuvxTP9vZMXusqiyugNTes0j6Rh5wTcI9og8fcnCCoBdwKSRZUKBbkxCat/sVniJVGxOChno3Qc/2R0mPtK/UzZ/OX1HuUT+8YXkpV6lzzFNBYqb47fLFN9xrIJX8YElEvtiel++GwLwnMp+8GYChp5eAhzksSIHL3PNEhQcaesjDnrkVsJmTDHcV0P6TGruxsWRanjLK+xT2JYodfFnx2PyhLIrfsvJcYKcVaD85MCjPfI/LFjn5B6jbQWEMAkdUqKpZXe4tOWF52tSj4o5RwNNalzqJisESsHhG2WYdBDxjF/wvd9RBxPpFN/kOuTJeVQvB1fgToEFA3UuVam8QeTCVjF7E5x9ei31NA8JQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(7696005)(5660300002)(55016002)(52536014)(8936002)(2906002)(4744005)(478600001)(53546011)(6916009)(71200400001)(186003)(66556008)(66946007)(9686003)(33656002)(4326008)(76116006)(66446008)(316002)(66476007)(86362001)(64756008)(54906003)(8676002)(6506007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?OQlf+XXkKzBjXA9Efqm6AbrtkrKprwjXib+cxKO8JtG37ECpfzQ3F1k9qDFY?=
 =?us-ascii?Q?gpK8uu3ab9BE/aqqxkBsocZZ7pwqVXY4a085LOcU+bNHB+E/LuK/RofAc27l?=
 =?us-ascii?Q?91IWWrMghpdWWq/sAR9QLPS4yJb9Jas74F0MCJDzEgcOSfsuWczDif3DVUyn?=
 =?us-ascii?Q?FOLZCaE83CcT1kA+7zBxZaYWjrKDzZcKK59Xol2Ae/zrG3Ckf+8QZwPyOi/H?=
 =?us-ascii?Q?r+QKNdaVUcD4sDp79o9RDox96GMZwEMT+kSemP4rBz3AhqaFyZfTTcCjcfe9?=
 =?us-ascii?Q?mcJGmjIgkWeAwsQBa2WNs0n7Xu1wKQ7QvOYXXSwkjI5Qyx6nQvvupvr4OZAt?=
 =?us-ascii?Q?W5HW0pW6XeRLUm8J0P7mb69LOZAHLJgsXgIQJLTzET97UfYrQRqRdu/pg0/I?=
 =?us-ascii?Q?x5wfLp6uimsb0szZkfrlABtfz+OVDbht+ilwJl9QbL1FTQ9KAbQTe0xXKIos?=
 =?us-ascii?Q?BYMuENZg4qoC7+EFjgUw2xR7wziEq2fk4PdlDTjFGq24Hdc8TlgxoXQodgzw?=
 =?us-ascii?Q?1N1BM+/0Jk/JAfbyvAKnmW58NamHNEvYy3zUMZDNE1izZoMoiKPXPObap4Z6?=
 =?us-ascii?Q?6cqoWyLjjPKS99YdVqP7NzKmVvAcwwHbR+2ycpSNMeIFb+nVSia8akHoMOVk?=
 =?us-ascii?Q?uT1/+JP5izpNU8JN+wv4k4BFAEdhxsa8tFA++jwzKSaE77+yNXtA2vXD9nVR?=
 =?us-ascii?Q?+FjDHi1HKAmjZk7QrDLtKRMvy+uK9g3kxYBmkZ60PgzGlAVtmxSTIbUVjhcU?=
 =?us-ascii?Q?Q/pcluQDFi2H9Zu+IqBlHOgYi594LVT5DeJU95BdwF0+0ILfkE3tpD/nYQZ6?=
 =?us-ascii?Q?LT7dC6NdWoiFrTdXQVlxx5cDZfECxQwkZQsZzdhFmoAlO1DYKt5j2KXmXe4o?=
 =?us-ascii?Q?7fPfQPWzct2iXlUIxZyeN0wgaZzKgREZ2togwr1Dum+BJhblgjlo10U2hXSN?=
 =?us-ascii?Q?sypIJbyLgZElJgH8R2bN6RE21NgLDK/hBnQy8h0GbnKTRgG3cFJOiuSgQhup?=
 =?us-ascii?Q?erux0qNeW6aBkbgyVCM4KZwB2joG5ru9BOe2ZOZfWEafV6tYclplIGuTuUv9?=
 =?us-ascii?Q?OaVyUUkq?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 677f8436-5260-4e04-9676-08d8b83d517b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2021 03:34:37.1501 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jpdSGX8FXcDpClFs315yK5gatSu7HIlQaE1NxEJnqrRnYwZm1VC7shGgaNGo/gy5DjgQY04yWJLBiTpMR/aXshiEyktwi8LsNu2Y4cY2f+Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3861
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210113_223441_503796_35D622AB 
X-CRM114-Status: GOOD (  14.80  )
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
Cc: "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 1/13/21 5:34 PM, Chaitanya Kulkarni wrote:
> Hi,
>
> There are three functions where local variable ns is used instead of
> using req->ns which leads to duplicate nvmet_put_namespace() calls.
> We can just use req->ns and not the local variable to avoid duplicate
> calls.
>
> The first patch sets the right error status code when namespace is not
> found in nvmet_execute_identify_ns().
>
> I've tested this series with nvme blktests, all the testcases are
> passing.
>
> -ck
>
Thanks for the reviewed-by tags Sagi.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
