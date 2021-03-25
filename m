Return-Path: <SRS0=zNYX=IX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C02DC433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Mar 2021 08:41:10 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1778C61554
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Mar 2021 08:41:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1778C61554
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=6O6ur1DdgFijxm7ofUvqhFe6MKEGO8gGnP5EQS3nFak=; b=Gzv3URE9ppBJFwn6bkG4encum
	CLKbPh92wZ+bXQJWMhKYSy0TyQtGdZg3Hy7T2kDfP7hmJ+ph4uOlUokCqnOObfgwg6pIfa6M/pjs2
	3XzhK1bQYmLfeIP63pB9dGSCGI+mw3S5ebr8GQXVFRAeJn6fw+APVTyqIt8gdXs0D0JnLIeqkPqYa
	Piev/2Q72FaRl55eq5YcRcgCorypkbr0HDHC2CYwGEVLexZlGRInueq4SIb1WxnpqoJuctqa/TOI7
	Xx7hocWKJaN8rhjSBIP7/6jCZ+WDgFfjgNxTkK0e3xX5fcVUheP+M6zhCLp4ge7ppfd02oFQ3KIFe
	27qXTBq3g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lPLXV-000xNz-5b; Thu, 25 Mar 2021 08:40:28 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lPLXI-000xMx-PG
 for linux-nvme@lists.infradead.org; Thu, 25 Mar 2021 08:40:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1616661614; x=1648197614;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=s4ua/SUdZlvVBmMNtnXduHxuENC5pWUUvXjp2ubAR4E=;
 b=ni+lHTJ68pwv8Ed7qkITYUjYgAAhND2XI4WOuNOxAqaZcmZwvTJfhQ6M
 VaRed1ip2B2/tZRRFwjVfD4jsKJ/Mo4k6XsE2oGrKhTw7uwWrazPzlh1l
 nnU7tt/ze5TkWb2IxydRfG5RUbZrWrTtz2tOFtRPSs+8G9kHC3387ViGI
 lQ1MGpxh984NzT7usi4MxR8lje2RIpi3/CGvC7p7k5LCrxE2rmu9HFK6M
 BT2RA3s3HL4WKhgWu7HDNEpHvVQalKc2h+V6OWWNPbaIr/VsXpC1/YMIw
 hYb2ZzpthBAgQj3ispuuSBPRWvJnMl0D4WFaGkN5j9Jw9OuLZqETVVIw+ A==;
IronPort-SDR: ycfCMRLGRsDpBoi9h8wX5A0ViCNKZe7LZr4yZrzOf37b9jxIcci4FffLPxPH8Tsb/hMfGj7efI
 z1IkRzf7rFGQYGR41RSr/RMvxYZI5ZXVXVMZiIAO8WssSqlo9ZLT+VijI7zKDMXIAT3agU4qNv
 xwj8zltfh9Uok2/Yb43gbDiEXH1dprJS4tIgp1oCbdWbSFjfJZPNXpm8PSBIbH3tquCsNJkL8c
 iShkxADaIn6KGHMqKv/1aO69bktfli3pbRJMLvW4IIT375V+zmqZ/H2VR5To103ZnKoNoyACyI
 lRA=
X-IronPort-AV: E=Sophos;i="5.81,277,1610380800"; d="scan'208";a="164087671"
Received: from mail-bn8nam12lp2177.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.177])
 by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2021 16:39:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UrTKHBo2npjGMbDfuNrHoOeadB6rpc7DUAPw9NCt1w690qws0EAZf0hxiGcgOpZK672MqDdByUBLX8TO6QOXdr4QMWaYPiN9gDs5RjQn6XW/K1TihtG/E487DrCUZN+QTqeJup4x6UpI8dqvKjY+r4xVWXe5AV2uvPsbst5hH9/SNpwc4fyLrmlVLTDvr2246Phs97HGzbPkqp+VkzMlXVj1c0ALS90zcy+NbrtpZWayoLcTorD0QpJIezrtrmEwWWrUMHXpYLd4HS7JvncVkrmR1wnctOH6oGc/8gh//uxSEP1iHlkm7tg6OhvyzBanVDgBX0pkW0wH49fIJdn1OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILYyEbx/5gHbPLvMFdJhDiL40katfg6s79VymdE5jb8=;
 b=NKctgpA/Q4rT73L/6OKdGZdi21zeqnApg+iK28r59lNF5j5NApjbx5NTiOKDwfafOpmjPLkEJGGDDYjkk7KWs4fvxNC1LYuBWcSxD4LySo1zSADSvwltE+cs8F8O+avbmhEca+yYE/jYxZRQLl8rVWQbuJvBOaDbEgXas61bxUoVcJwO/AVofFQuj/EDle10O6VwYWMnzIn6YSUMnYst3aCMtwx7n6CmZSQ7Aj+PQK15vLcBXs7f895U6aP21i3CErZfRZD00PtTaRptGsgXfHm6D3ri7YUNndJvJETT9ZrvvwHEa45AGR1yVFxXtGPye1xEeupslIl9SqNFBCqlbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILYyEbx/5gHbPLvMFdJhDiL40katfg6s79VymdE5jb8=;
 b=L4OIP/1P/edslYrsslP1FjtE56FZPud72KIO8WOI4Mvr1D4lS/CbFDv6qZm1GSWd2hvoyDeXYqfcenBxOBEmOIDnxaDTjDk2ZFCbRHYaO/usEyLFtx5JoHUNxjfn8ymMMo6HXeu/Gw+67L1ytq0AIPNzEV3icAzW8VfjUj6eib0=
Received: from DM5PR04MB0684.namprd04.prod.outlook.com (2603:10b6:3:f3::20) by
 DM5PR0401MB3509.namprd04.prod.outlook.com (2603:10b6:4:78::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.18; Thu, 25 Mar 2021 08:39:40 +0000
Received: from DM5PR04MB0684.namprd04.prod.outlook.com
 ([fe80::f0ed:1983:98c8:3046]) by DM5PR04MB0684.namprd04.prod.outlook.com
 ([fe80::f0ed:1983:98c8:3046%12]) with mapi id 15.20.3955.027; Thu, 25 Mar
 2021 08:39:40 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: "hch@lst.de" <hch@lst.de>
CC: Minwoo Im <minwoo.im.dev@gmail.com>, "javier@javigon.com"
 <javier@javigon.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, =?iso-8859-1?Q?Javier_Gonz=E1lez?=
 <javier.gonz@samsung.com>
Subject: Re: [PATCH V6 1/2] nvme: enable char device per namespace
Thread-Topic: [PATCH V6 1/2] nvme: enable char device per namespace
Thread-Index: AQHXIKlX58TcqiDl90OEMALlWkZSkqqT9o2AgABpUYCAAAOYgA==
Date: Thu, 25 Mar 2021 08:39:40 +0000
Message-ID: <YFxMSzjJMqdUiqxm@x1-carbon.lan>
References: <20210301192452.16770-1-javier.gonz@samsung.com>
 <20210301192452.16770-2-javier.gonz@samsung.com>
 <YFswq8pgzg9y00GO@x1-carbon.lan> <20210325020951.GA2105@localhost>
 <20210325082647.GA27622@lst.de>
In-Reply-To: <20210325082647.GA27622@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.226.244.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8244cd65-6537-4897-ee3f-08d8ef69880d
x-ms-traffictypediagnostic: DM5PR0401MB3509:
x-microsoft-antispam-prvs: <DM5PR0401MB35094D477513ADB956661530F2629@DM5PR0401MB3509.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ArUpwmJpm6IxkFYXDKuYN1WrE7RDpjSnoZwCvLTRhBa4mPV9sNK1pWuiPQV5tn7xLI2rGaock9eFDLbRzD/HKFWS2giAYE6VuKHojmZYwOfNEPQyQ+7RbUDE2fBaCcetHh6/n1flwvVKvYBEg853UHbUNHDGq99Y7smSTxBqRG8xv9T9p7U4PPsL5nhly+uIfozWvnWcf0hUsPn3Ab9/ZaCYtefTR7+qUO9NmsepBqhS/w9kBlpy1i6Sxkq0VfhnpIgd8H8fqsgL5AxfeBspmk8EhXaiIX1t8O5eA1LoTMj/0d7C0l10Or0Lhvn/eaZf4pE5eFkEGonCBx1TGT9Zol+CIHhzeNLriNo9tVtX9e6SkSEjbeMl17BP7fU/MxG65RWB2jQXIGFjf63FHfRIqs0gVHycGLZlpSNa4b6juhofC/vI8YhK0SwIVDt6fRk/10vRbGdWFXcFYEVjyqNxiVtWOOeaKPV8SZ2p0aL+cx2L+aNsYKUkgcCEDxJxzvmV5e9H8R1cM/Ic6sZc5cI2faT5xzUkK49aFsWFJm0UpuYBcJ4Az55qEh8GGEURS+zVgq/KshSn7jEax0/S5NbqJphcli0jbqpdMGUqhbpZCDw+lOn7b676z/kTjdr0CUMz34UzoGqFNsSHjbhnmE+Mm31sjH4vzM6iFgEV1a0a/MI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR04MB0684.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(2906002)(83380400001)(186003)(66446008)(6506007)(6512007)(478600001)(9686003)(316002)(36756003)(26005)(66476007)(6486002)(71200400001)(76116006)(6916009)(8676002)(54906003)(4326008)(91956017)(66946007)(86362001)(64756008)(38100700001)(5660300002)(66556008)(8936002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?540ci0FF4AWamyKQSl8RjMb8tUWAUiX8aAuTkmn4RHFde6SM8oZ0f3sc+J?=
 =?iso-8859-1?Q?OT+BfcmIUuRwq7xBu2xQt30OhVlBzEF5bfYs9hLAfhiE7a2iOF36QcPEYA?=
 =?iso-8859-1?Q?fU0LEWLRp36QBmyYKkYH/IQxnzykVInwMJcc9PSuiOISbuTp5n48bwCiKV?=
 =?iso-8859-1?Q?Lav+c7KjcjShej6yzlkHIhFOhTylTAkeN9Eqqc7yr9yXJe+foUBdU6U2AU?=
 =?iso-8859-1?Q?bgDsIDn/UbZlUvl+Ms9rmcB8igJEG27TaOJFIvbxd3jdJsUafw6W0RB5Am?=
 =?iso-8859-1?Q?onnIH+ca9uGSOLcyIDYhgL8ZV4wUxBgWHT3R3+soTadVJlHl+GJzDc3Ed/?=
 =?iso-8859-1?Q?8boubzglJ94x2OJWBBQngtYPJ1Kum7jh9fphRk2Fgtv4VxPT7WNMlNYWhI?=
 =?iso-8859-1?Q?vzm11U9fbwKLr342NzJwfnjhZdzlYWbDl3fEYodiGQxOnuIVM/Z3xJsl+Z?=
 =?iso-8859-1?Q?/KT1Cer4v7r9C02gUWvAdVppXy6kyGxpjxZjku4Bl8pjvdF74/IF4O81Tg?=
 =?iso-8859-1?Q?5P8Wzn1Bf0Dad4ptfAPwF1HUuvt7gMuGAYkJkkcd/MamGMQ6+VtXMvcD+Y?=
 =?iso-8859-1?Q?7ryYVTXJYGt0ReMIdDI3ePRHJ8/gY4RJd2TfygmFeRbQKnOdXc3yv98ayc?=
 =?iso-8859-1?Q?URqwwcQWFGvHFQu6CSrk6oFl3hbAtCEsgAftJFUjZ0OjHbE0PCAlzbny48?=
 =?iso-8859-1?Q?gph9Jf2ivoSDjvRRdmwzjXPVdyPK6cVx5xGPVfC3hcdRN/FFEdQxu8ugpY?=
 =?iso-8859-1?Q?s4GTekL9XL80kaD8FBN9NcmEC1YmJmb/YbG05z6rKMyroiTFciB6wyKR4z?=
 =?iso-8859-1?Q?lbUooKXY+4uHVOrRvFQP/qvHUnsliHM0YXGSzddrlQcpNuM0DVnWLsTAQC?=
 =?iso-8859-1?Q?hLu5tknZ7uSJ2HbKJa7+YucgO/ykl+0axlTRGXZr207Yd2adamUcNgeiR7?=
 =?iso-8859-1?Q?A0bgnB5zr/KG1GJipWDyA/JbpSS7bVkbw51bTF50Xk6Ged6F+S8vUZ5t8R?=
 =?iso-8859-1?Q?1DTtTSvpNhRjt0fyqEdnPOY/US5RtSl0GMCwvCJQuKifXpXJ6TzYhRonx8?=
 =?iso-8859-1?Q?FFSurd61HS4TMgxGP5oiCnoptcWbAi/6iIf2cnRdpuRqoiIj1d+/1A8NzD?=
 =?iso-8859-1?Q?qUJj9DCLWI4DR66MaJc/PP+pFyJ3+5PkHcCUBTqc73vlRbDZvz1JMPiQfM?=
 =?iso-8859-1?Q?h9avZLJn/R2cJ8qMXPXXW7+RkZ8120Qub+RxaktHkzuaAZYJ2RyAoR/xC5?=
 =?iso-8859-1?Q?S9/HW0AIC1FXEEficIggMfA1Oth/WYCG9SfBuEFVvezUPFj4OlgDHGR97Q?=
 =?iso-8859-1?Q?iy+FqjD3rAZmP9QjZu9FI4c8zkuOsnGYxnL+YSV2lK/UEwwfqy1gssjba+?=
 =?iso-8859-1?Q?4rPVhDlA27?=
x-ms-exchange-transport-forked: True
Content-ID: <41FE56A43AF3FE4B9961EB359C3BF831@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR04MB0684.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8244cd65-6537-4897-ee3f-08d8ef69880d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2021 08:39:40.4694 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 50LC1baa5y3XEDIrrU0hp73gQhPvx1KCqHdLS7PJCKfza25EkAB2EbiTSBdLpoUefBdpg0HJr4cnSluTrWHV2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0401MB3509
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210325_084013_647645_50E95EFB 
X-CRM114-Status: GOOD (  26.18  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
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

On Thu, Mar 25, 2021 at 09:26:47AM +0100, hch@lst.de wrote:
> On Thu, Mar 25, 2021 at 11:09:51AM +0900, Minwoo Im wrote:
> > > I was still allowed to write to NSID2:
> > > 
> > > sudo nvme zns report-zones -d 1 /dev/nvme0n2
> > > SLBA: 0x0        WP: 0x1        Cap: 0x3e000    State: IMP_OPENED   Type: SEQWRITE_REQ   Attrs: 0x0
> > > 
> > > Should this really be allowed?
> > 
> > I think this should not be allowed at all.  Thanks for the testing!
> 
> It should not be allowed, but it seems like a pre-existing problem
> as nvme_user_cmd does not verify the nsid.
> 
> > > I was under the impression that Christoph's argument for implementing per
> > > namespace char devices, was that you should be able to do access control.
> > > Doesn't that mean that for the new char devices, we need to reject ioctls
> > > that specify a nvme_passthru_cmd.nsid != the NSID that the char device
> > > represents?
> > > 
> > > 
> > > Although, this is not really something new, as we already have the same
> > > behavior when it comes ioctls and the block devices. Perhaps we want to
> > > add the same verification there?
> > 
> > I think there should be verifications.
> 
> Yes.

Thanks Minwoo, Christoph,

I'll cook up a patch based on nvme/nvme-5.13.


Kind regards,
Niklas
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
