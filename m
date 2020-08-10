Return-Path: <SRS0=L2sc=BU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4862C433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 22:54:43 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86694206DA
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 22:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kg1/4aru";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="aPPl8Ked";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="B2fmJj5E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86694206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=oxSK5rNIiDsauc/VkSt+fyhBXt68cEyNMyJOuD47BmM=; b=kg1/4aruEIilKLGndKHLMHej4
	LReSXBEW6EfYbZ19Z/fEH2Si0WUc5bikFweRJdE/dKqMVgrXl8pVKfZJIlOLgHaHGUbj9FVm0zIN6
	0AICxDCpErPQ47dDv/h004/9IOvhbxfaf4/lfhvq/c2TA3F+kGkDn4K2sQPjYk8+/hodStoZUEQ7t
	F81TLLAOGrgUvJl0jRcw8gV0a7r1+qc0t6LPjxwbrcJNd3i1QZBqTMZfL6ClZ8Pyb94B6XmhZRacP
	C8EbYFEQNiZL6EtxttxZbKPc0bq8CwJgYBid4Hqxy+LSm7P1WXnccTbIDNb0mQE54Sr/f56nFceEI
	ggDgBlsVA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5Gge-0006Io-2v; Mon, 10 Aug 2020 22:54:36 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5Ggb-0006IP-1M
 for linux-nvme@lists.infradead.org; Mon, 10 Aug 2020 22:54:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597100072; x=1628636072;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=xMX5yDbhiT3Qh0NC0/xErTTPTrbxD/3VBo0FpI1Pqxc=;
 b=aPPl8KedkT/yHX75/n1Z0Gec2fqLhlO7xVPdjNZ4+pYQweSehn7vQzOL
 qDIVHycAv0ym1F30BnzoyCtgrtdWxm4Ay+GjNdPZ0GVBhDb2oDvf3T1Br
 b+6L/XqZv9pjtJimk/E44kw7nQQbMzA1E0Y2xYzuIUhFcI/JnqWrSxc5P
 RQCvolTevYkabKLCxNMuW3+eivzeZP/N3QlbIFiaaxYP0bczekFIh/eUY
 SijZEiQrk5+6JwVXEP6871GI1/G1gCA6ha8pAkmAKTbpHGDNnEg3PLLh9
 m1znuSLHeLLfdwGq9Y8KYluzX49OE+KqVcDcrQAY6cpjKC8oZdnbSSYn1 w==;
IronPort-SDR: ND788mNGBacgmkRAdhcLGKP/h3FPxChdc/OWPiwAHw6d/jZQeMKkP5lN/wCuyhfkUoa0x1ZyZ7
 yuVA+MasboOA+dNwopCdUX/LIsYWZNqZ/reFrgSUKc+BxYIPFJqXfSR80OziAJ0Hxml3jUaCtz
 AkPdTVrLdsdaFR2UChaHlVuIJckWD+DRK5cP+6WEM0CJPfJzD4tz+R5rLPIQhPuakKdb2c1et2
 0XE4EDgzor06VfdcZMh3s53JOez+1YLtcVVEpziYyFd4b10Ns2WIJ0ez7FJhU1tlsViCNJigYj
 wJg=
X-IronPort-AV: E=Sophos;i="5.75,458,1589212800"; d="scan'208";a="144615358"
Received: from mail-dm6nam11lp2173.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.173])
 by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2020 06:54:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=maqiRCUzDxmgTz5GN29veTEvGq+OJjAwYJwT9feZ1x0CVlIEIi7TRX2Uu0qbgWKH8E/cTQtyuTHNTMGdSH2BLfOMLW41ohthjMuyrh8YXRYqzA+mpK5y+VblIUXCMn7aMCfo9DwvuFk5N+yb3r3rnYa3QzmYDIDVcLrYKVOBEXrJiFX57JjMhMV0HnCSo+FdDQTCU0aFYvpBqwIOp2aiABOGKfHMmTgB7KSrTLG2Sg1NAY2uHL7O7kLsBUjQDhsXOdA02JswYvLMMv9lU+pP4Jp5HrIQLGaGgA9pszJZLc87Jc6IyVP0ysoyq1Q0KsmkyJC4O4OkOevszVAuzpk2vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMX5yDbhiT3Qh0NC0/xErTTPTrbxD/3VBo0FpI1Pqxc=;
 b=OePUh8Ex2t5XGlJptAtyMf0tMQy8912wvD0I8+hIBTXcSmzCHPUEHo0sWQI7js4ZhK8Vq2udw3K7uJLc+OPg8LMcRBXpgSaFscRTaCpUHGeI07s83T/29oyMZB7rj8n9Wf9Det/3V0qcLp/zXyz+4SgPNTF6hrXk3d3le+hEtXeN2sNoTnS2DqQir4E6ZAMUX3Yjh/hK1t6n099E41gPO2wASkikHHPny9+JnYRmbrGCuVVpAklKXKZOGJoDaA8PfahQqheDCSD65fx9ljM5ssWKdy+ZvWShJHWpdbSshf4CPXoR9ycfMuGudT7njq7gYTXdxyLmxP3VyC2KHbp25A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMX5yDbhiT3Qh0NC0/xErTTPTrbxD/3VBo0FpI1Pqxc=;
 b=B2fmJj5EbYnjwav09u8v6ioKHr7au248ZoZsiwVCYxiU34JgsDx2fWyendf/vMY9UT1V5qPddmCnLKRQAhgPjyhTwlLi8CEXFLpXRdZnC3IEPoiNNSulCYUh6TdobS9A+rvXYrD+DemE4cX0IIhfSYnw5Jq2h+flEMq0PPhOMKY=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB6101.namprd04.prod.outlook.com (2603:10b6:a03:f1::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Mon, 10 Aug
 2020 22:54:29 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4%5]) with mapi id 15.20.3261.024; Mon, 10 Aug 2020
 22:54:29 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Logan Gunthorpe <logang@deltatee.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 01/14] nvmet: for pt I/O cmds annotate req->sg_cnt likely
Thread-Topic: [PATCH 01/14] nvmet: for pt I/O cmds annotate req->sg_cnt likely
Thread-Index: AQHWb0fJvul0WzksoU210P1BYKlyqg==
Date: Mon, 10 Aug 2020 22:54:29 +0000
Message-ID: <BYAPR04MB49653405F083DDACB0514D4186440@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200810185456.7713-1-chaitanya.kulkarni@wdc.com>
 <20200810185456.7713-2-chaitanya.kulkarni@wdc.com>
 <53dd1aa6-31a7-a9bd-6def-5cc18468845e@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: deltatee.com; dkim=none (message not signed)
 header.d=none;deltatee.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0230a5e8-aea4-48d1-0f6a-08d83d8056b6
x-ms-traffictypediagnostic: BYAPR04MB6101:
x-microsoft-antispam-prvs: <BYAPR04MB61011AA699AF982816958E8D86440@BYAPR04MB6101.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xJS7v7yaddX20A4dSuTPZwlHebUXqEpIem48AjcqteIR8tNx2ug1Bwvw91phgBCiq7HYrI4SqM7XXdT1MfMgUkP0iJF76GxoKGtNBfhOtQnM8pJaDRCFCQAKcqHyteN+aekJJUIduaiWwK1c5Ubp226IHpV5BaQ9xbHPR2EFBYtfeCCl7OJMfCbdduCorCP6/Gyr9BrzgMSFLqw+eu/opgs+s52J4shrXmIn19V6s414oaPIipZPkLGlrFEF39jvm6zeg+0HYsD0ieivZfUXR7tPcPwW2NNY1kmtLSPot1JZlP6Tz9o6QQu531DsBnQL
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(346002)(39860400002)(376002)(366004)(55016002)(54906003)(110136005)(83380400001)(4326008)(9686003)(6506007)(33656002)(26005)(86362001)(8676002)(53546011)(7696005)(4744005)(66446008)(71200400001)(186003)(316002)(66556008)(64756008)(76116006)(2906002)(5660300002)(66946007)(66476007)(8936002)(478600001)(52536014);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: yYedSU5mzW3LevGTna9ky/5PSupaYs2wy8EVnHeeKSI5vP0t/K3NyLQ9ll48Y61aRzHk0yqw6q18dGml7tE/ALuPVP1J5fgoxNVrKYtHRP/LXvJz6CH4QYp5Y5fqoaOzeKefOUxhs11HIxg0G4eSdlpRKTwy4UFqs/imMF11cgwTcMtdUxOxHUI7sKBqQjffD9AQRQSz9kPBG6Ka6F1F10PWfcZpqSyKGctoBLq67tZ2u8O7JhgNz8XoTXq4rlSLSbuqV43XrVpZnxwfgJBDPdw2aoZRpyC13xHhHfhU+sFZl/HTJLPQDqZCvA6TGK19Fn4cwzIC0hIvimqqFu40ViWPIu5F6C4mPelUeyibDxZo0XgyEgKFXdmBfyB6bTA/jDhBO5VFn/JeznWKPAgyeR3JgOWDcTXpaXzM5lx55brUOtkh/FWXvP+T4LjVZ3FW9usNv5aREmr2bimsCX3b6FO2uX2Ln46mjnW0Ck5pUBm2mNNInwmiJTgxNtZSta7fchcde3QlpKXOp2iJOt21rM3L24+qExgPBvsRgZr7jzihAKzV2keAIHMgn5JAJ3XA9yy0MqBjlODxkg1q/GeBPVw/DsbmhxHziaP/QujfI7lgTOT33kBnvfzx+6/jQRQwR6p4bssJjFMem84rvfOEjw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0230a5e8-aea4-48d1-0f6a-08d83d8056b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2020 22:54:29.1556 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tCfJocKUflogHd2BpDQe7cO9XpGAJRi8Xt0niW2gHZPf3ikg9L2AwCv7Ul7HG5LNOquWrJd+EhE/B3pryCvWScvhV0PPdU7vtO4B0GDHvz4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6101
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200810_185433_429766_0263B1E5 
X-CRM114-Status: GOOD (  13.12  )
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
Cc: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 8/10/20 14:54, Logan Gunthorpe wrote:
> Hey,
> 
> You forgot to CC me again....
> 
Ugghhh..
> On 2020-08-10 12:54 p.m., Chaitanya Kulkarni wrote:
>> I/O Commands (nvme_cmd_read, nvme_cmd_write) are most command commands
>> when accessing passthru controller. For I/O commands data is represented
>> in SG list, so sg_cnt != 0 in most cases.
>>
>> Annotate req->sg_cnt check with likely.
> Does adding these likely annotations actually produce any benefit? Why
> can't we rely on the branch predictor in these instances?
> 

They are present in the target code. I don't see any problem having it 
in a passthru code unless it shows severe performance degradation.

> I vaguely remember somebody complaining about all the extra likelys and
> unlikelys which is why I removed them.
> 
> Logan
> 




_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
