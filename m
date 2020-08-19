Return-Path: <SRS0=A4m9=B5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FF7C433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 09:38:51 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4742E206FA
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 09:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="prfNgl6+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gJ3qPzl3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="cPW1/bNI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4742E206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=cFPn0AV4F2nq1YZ9Cn8Nwn3GZWZIsW5usWGjKpvDzXg=; b=prfNgl6+H3l7Mj4FSwvh/vcOL
	5I+CGkSymdhXEwXWtfvN6jf0AqkGXfZ/WV0CE3y6cK6MCyNwO1H3gYsdZpv9gJYgkI+56po8wE88y
	2YYoMQOsRo4ZFipguDPj9sVjYVoDz70VJpnhMScfAzqJi599buHDgyDpopKqCxV6QEtQZ9f/yZ74B
	Vw7T/RmdBuuRuTQrvI0v4BWfUXKqQF8WsFBAmttWrMSfZN5bDz6DCs+RORcL4DCkHozQ+XLVxNQOd
	Yeq4/I/DKseIoesE1azKzkn6brfwI3b0HMOaQTe1TYgXjYch6pct/soxdEQ9CEaUJuVxvElYgW1Pp
	PooTQ+FeA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8KYQ-0006wn-5t; Wed, 19 Aug 2020 09:38:46 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8KYM-0006vl-7u
 for linux-nvme@lists.infradead.org; Wed, 19 Aug 2020 09:38:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597829925; x=1629365925;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=vUMgYPrZncmTGmmiQJesWkdRcuh2Ky62n4lwlGknIAw=;
 b=gJ3qPzl3zROzej5B4ioO/v8pYLEymiX/XIXnaXwzj5avgeZJ30FVDtvy
 QI3GPOpoJdQWdyb1iaBLC5QJbnyFOTLYF5m4wYcdI1wGu31rBqROuN2zE
 ETz40BE7xsQHQc3XskIDQoyRkfGpZR/7CyL2XBHryCrv5yIUsc+l3fhjp
 9jUUfaq8on7avgYNiE+6hlmwLkAliURBlejWyPeST5ehdxJjnbFj9int1
 v6aTN/HuHXJ8hZCVeRHCMEhlax/1KizLYkaX8mt/PdgpIEwr118xFhnVq
 MINFvXDXLmkUYrMF1JxHj7VH09NmfoMVsnqlFIS+NKHwYbllTM2ZnfSMy Q==;
IronPort-SDR: bUbJ2iaMIVh2Mjlyq7GyIl4Z+uqOCsDYlfYx39mCQYnJxzb6lZA1IK3Z+Bpj0W8D+37Em4gz79
 SsDNb19DM1a9nz9fC7hbPP4dT1dSDENZ448ezDTeYLojyxiWdxATxgr6GkK7bQ6ow/E5wyJQNy
 l2P3ZUAaA1XrZMYg1/eBHJz/p+mWRpK8hTerJBYgwlnzzr/AGWOMi3XWUmpDSxVzzh6dF0Aomm
 JI4CqlfnOY2N/u6dv4PV/Jucso9TaVWWlP0WOAbUMt2WDcNacEoomA8wMVe2AwCNQw5wz54EDg
 4NA=
X-IronPort-AV: E=Sophos;i="5.76,330,1592841600"; d="scan'208";a="248484596"
Received: from mail-bn7nam10lp2101.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.101])
 by ob1.hgst.iphmx.com with ESMTP; 19 Aug 2020 17:38:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ejtR9MPLq0LYNZ7yyIxcEBC+vppjKsh+f0tUZV7v6kg6yHunFKvHxdY8fR3XSdPBs1VhdlydmaNE/YkfxSNqplDwehrhvQFeYgPWJjAnyZPwUSJl2I7XLi3vfIfV22Ji34h9UN3+Dz2IZhY8yB4t9E/T93wibeUIbHExlDy7xbq7CCwFYf4uNixfwa7Q2wTwRkN23Y1YtSUB/e3beW4rJStVbLnBACNtzX0H5gL2/J/hdrkXhRMa3MRkn34V6Kr7szZB9kUUEvixFdrFnJYA/5qVaVLSb43+3RcO7oBKVRYxZpdI7sr4qC3+IyKV3cFqW9KWXKYZOcnP4L3ObjN2JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUMgYPrZncmTGmmiQJesWkdRcuh2Ky62n4lwlGknIAw=;
 b=OxFp901yOwy/9fX4PgzDZ05WQkkIbCKFrw4YitEEm9g5BzWIr3LoshUN1z7HDy6L/nC8HBI+LAUYDsXgcC6MW7pqr1IfUDJAmpCUAPpWL57FKxTgBm+CFly+g8I2Rvb43B+1/9B0AAo138urwL4qu/SJaqB9nYThidjgeMaBjovtzt6mzY56fKNK0jfM84q+qLiOjPQfM9MNsg3HNYCbXeuPNYXYH0z5DTUFTounjSo0k1z+o3uDz5L6mVR4cNnHYRnaN1wMo6DBb0TKObr33UgpfDrJ1wemc2JP0l58pcMj47thWRbK05v/aahJ0hZcH3esXZBIpa8ZtsYi+k0pUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUMgYPrZncmTGmmiQJesWkdRcuh2Ky62n4lwlGknIAw=;
 b=cPW1/bNIFwB9rQI2XpT0PggsS3+12Z2g8YrSiv5c3QblQBA/++WRiH8VnZEFecZhoIWQgkB5D9gIaIGr9t57FlehAmvIFrMFJloHQN54ZZhjVWGfyCWUHmHpWq015mA4zNL2RqfiW2tuR6BvTi8PspmDAW4wyduJwjVs78HCVU0=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0246.namprd04.prod.outlook.com (2603:10b6:903:38::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Wed, 19 Aug
 2020 09:38:36 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::7d15:9936:4b3b:f8a2]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::7d15:9936:4b3b:f8a2%12]) with mapi id 15.20.3283.028; Wed, 19 Aug
 2020 09:38:36 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Kanchan Joshi <joshiiitr@gmail.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2] nvme: set io-scheduler requirement for ZNS
Thread-Topic: [PATCH 1/2] nvme: set io-scheduler requirement for ZNS
Thread-Index: AQHWdSEIMmCxi6h3l0CfpdyAr+vLMA==
Date: Wed, 19 Aug 2020 09:38:36 +0000
Message-ID: <CY4PR04MB375148979AA403CF47EADE0BE75D0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200818052936.10995-1-joshi.k@samsung.com>
 <CGME20200818053252epcas5p4ee61d64bba5f6a131105e40330984f5e@epcas5p4.samsung.com>
 <20200818052936.10995-2-joshi.k@samsung.com> <20200818071141.GA2544@lst.de>
 <CA+1E3rJg0QOX4YgwWJf8Sm=6C-un4TsRX00E31fbFFPT9LYhXg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 263465a4-c7b6-4df8-5ce7-08d84423a5b7
x-ms-traffictypediagnostic: CY4PR04MB0246:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB0246F739F8469AFF85C04C86E75D0@CY4PR04MB0246.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IQUssL9EGbKO+fAu6zU4QjfL+yx6wHNr7kDcbN67rz5wDBQCzwPCpZ3+XUiDeuGpG1h7YucmOZ8UYMwv+k+rsceLLvjlo8JfUcH2hf2nIaYh9gxI/Xy5smAad0CaxD5+3jsWxeg0TbaVRkwZo62Kw+bRXfG7yr2rwA885HcaTCTvkvAsOzrOy1bm/Wy+heWh9n84s7kJEJ5uJK8F3eYRHrRLmoEXNOlQCSiIChavK02mhGqYqlNZj2OXcsZwdYAH2xOSMlzLs5UzzcuwxXnlhcO2hMrJYIH70cNbquFObMBmFY6YAYCDPoA/jCvCYUPSotIK9N+2nUP14ez3wRh/vQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(9686003)(55016002)(76116006)(91956017)(5660300002)(52536014)(64756008)(66446008)(66556008)(66476007)(66946007)(8676002)(86362001)(478600001)(33656002)(4326008)(2906002)(8936002)(71200400001)(186003)(110136005)(54906003)(83380400001)(7696005)(316002)(6506007)(53546011)(26005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: Qh4nAqWeMSp1NQ8d4JcOxvqQTdDmPEoEuQ4a9EOr95ien61CnbKlrjd+fXsocNP3qLDyH8fe3G0VQLAK8dQVylN+yK/JF8fdyC8OnwcQo4cI6+IeGvATtPgX6OkeOO+ih2y+dFPCcMI3B69xkKC/WUnWYsWKIOMpnYb88xAAQLNW8OZvQxOIE7TdSRuwTsn28nPPM40/ne+8h9TYAOyE0OR0aKPOd+CGGLu19snZkzqhxGKu4xkdEps0jqv4U0BaABNEozUgOLVHTmJYkYD4aRvDlHXi15fQhQpLZuWLk5xl0wKNzpjRJjg58hMFJAePR6JG6IKoG1tm8m5WXSwsAIUFYfWcxsz6ya6nMlgzI1lQNlhn05xoFZpjBkSV7nRaE89QosCTxxVMyoUljZ2WllKOxypWCZrWx3gkgkQnI7kIttviqyMD005cIRS2nCANObaYBc30eU8ub5bhYHiIOd6BPaVXOkqu7u+U0vv9y9mc39q0qq28NVm/e3tv3QT1H83D5ColK5ryWl2b/sDhah2G27k7Y38YvofYEXrGp67QoA0hhFnOfxwoC4HlkjiLRVPBJ8QGj3eTKDI+XKeH+X+RNnnzes5FZBsZcKe4/thlWaMAQZ/zWz2G68uAEfnEkbcSGIQuvJIxRdXWwKdnmw==
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 263465a4-c7b6-4df8-5ce7-08d84423a5b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2020 09:38:36.6147 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RoZTIqluihwIyNrt6yn6pUMYkOGsFB4wf+8BPTTSJ8ZELiVzGEJ1rR9Dr0ljVpu6aNhJYesKA3JXyo4gzyyKLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0246
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200819_053842_486942_6E1AE950 
X-CRM114-Status: GOOD (  15.35  )
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
Cc: Jens Axboe <axboe@kernel.dk>, "sagi@grimberg.me" <sagi@grimberg.me>,
 Kanchan Joshi <joshi.k@samsung.com>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020/08/19 18:27, Kanchan Joshi wrote:
> On Tue, Aug 18, 2020 at 12:46 PM Christoph Hellwig <hch@lst.de> wrote:
>>
>> On Tue, Aug 18, 2020 at 10:59:35AM +0530, Kanchan Joshi wrote:
>>> Set elevator feature ELEVATOR_F_ZBD_SEQ_WRITE required for ZNS.
>>
>> No, it is not.
> 
> Are you saying MQ-Deadline (write-lock) is not needed for writes on ZNS?
> I see that null-block zoned and SCSI-ZBC both set this requirement. I
> wonder how it became different for NVMe.

It is not required for an NVMe ZNS drive that has zone append native support.
zonefs and upcoming btrfs do not use regular writes, removing the requirement
for zone write locking.

In the context of your patch series, ELEVATOR_F_ZBD_SEQ_WRITE should be set only
and only if the drive does not have native zone append support. And even in that
case, since for an emulated zone append the zone write lock is taken and
released by the emulation driver itself, ELEVATOR_F_ZBD_SEQ_WRITE is required
only if the user will also be issuing regular writes at high QD. And that is
trivially controllable by the user by simply setting the drive elevator to
mq-deadline. Conclusion: setting ELEVATOR_F_ZBD_SEQ_WRITE is not needed.


-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
