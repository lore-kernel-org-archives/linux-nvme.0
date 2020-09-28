Return-Path: <SRS0=ZZT4=DF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7266C2D0A8
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 14:52:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 688912083B
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 14:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AqpzTWUC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="URldFon6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="NUol4Xav"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 688912083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=artB27H3tn8gHlUmwpZQfNS7XgKyDa+BUdL6rO4h/VY=; b=AqpzTWUCM9gYTpa4gzyHg+Ry6
	WpDpbDvLlGzvoMr90S/5P3iKAIXlFHf+XQ3YtWruzTOf8+M+hYWpfNJC0jwknspWODb1uWXfFNcMw
	A0ruDIsY1MheQLbHfoGi5FjKk0lOpeK/PWfzGdyUrvkIv2Qsj80YPvP6+j1EwH5274DmhlEyUE6tE
	Zk0uf4rSdqCOeefNnw8QMfFY1OTNAXJ9Mf5+9lw4e70hotjchF91ms0qqjMZUa7p0YDKqrcZ5LXLS
	qXOpWVVYV1sjCoPwe+LitGwGOcw0unxFS7U6f/HFxFHgluGUuTr+6r6+bQG8SwJW/ftfn8JNgQii6
	VfIcFLoAw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kMuVb-0000e2-GG; Mon, 28 Sep 2020 14:52:07 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kMuVY-0000cl-CD
 for linux-nvme@lists.infradead.org; Mon, 28 Sep 2020 14:52:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601304724; x=1632840724;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=Kqi5VHJpzuJF9FkeP6HsGPHxY1GJNizRsIS+XwsuI0E=;
 b=URldFon6jRBteStLQBbKgNj4jxhJ4vfcmgzQ/uZUNWD1ZxpiJjtj+wcR
 /qA4lGo9uHMEXTc6Q8oFbDQsMIU2aUzSAq7VtXuiPXSt/c8fZ+w2YrZVL
 AzCOZ0WgQ/7lJ8zLQSnA3prHPmiTjk3LbDbO4+n74pLtr1pxYjgC8KrAY
 kemaVoX+zgqNResGHGTJnK1Ocx/qlmISOquuRLO96xlm+vKuuDiRmsoeL
 Ut7YxCN9+j9bt4BpC2n4kCXrUKC6++KeVSmOqbi40povQQD5i4htHri+9
 CKwhUbG5jlVl4naJVgX5LlQgRGuSZtwQxexujRngKxjb4wOS83UcadjtH g==;
IronPort-SDR: bCH8h6C5PKcgQDSF5ZIYV9k4ewy07Renp1ouVJo6IQD7YuK9BhKxzxODz1nk2iNDMtfEYnZDNo
 /8UpwU2sbMDds5h/zE0ebPzTx1VrS7IdGluDufDla3R17nU0ev0P3nXyrmqlo6sp9Bm99z81LE
 f7MHIPXOswqECi1Tu8oLislSflyLiL2DEXr1bSnNrFAwiwnLlGmJ7B403INiqI2HrHF+IJR0qq
 Ene8qXov8uzRQie6XIhsoi/mIs0NBCQQcRtz50tfEy1mzJJek+4dvWL8nvEg8U8zbSsZ4oME7l
 voM=
X-IronPort-AV: E=Sophos;i="5.77,313,1596470400"; d="scan'208";a="258172341"
Received: from mail-bn8nam12lp2177.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.177])
 by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2020 22:52:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MmUn+uElnfoeTDdvhd0Q6LmO/Qqv9o75J13pkI26EwXMI48AxuC473NiMPvaqBjzdayKowNwTPYaIc8PalsZC61h4/N6IGNWqEadVVivGCJCLAnGK985gquzpJAUPd/7FoRXopFmF+IS0FLC99jKNgabFZC71lQLQ0eAd6WSW8SdrGBK36SKhHzFdB/K/zyNw5DUn/2AkovkEIyMRcpZsmGQfBIlNiQEYvpMzF4uEHA3NrgnSpFKK2WBcY8rERPOmKI8003vzgMhLd/DHtd7GID+Djig0pRDbZqsMCw+6WBdz6fRBalVfJD4td2P0mFm68AzS9Xy6xeSZMntgX/HXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ArVyJiFMxp53seAdAPzbOptzDZtt1V07harwMu43tFQ=;
 b=YxLxJyLZ/OHNDvjeWOGvW8g9/W3J8lRHCiB2at4t1u16FkGxMRxDy7gZtk/DBTn2AuFHgu+BhblCyUM8CkBn79KRjn/SEehLXloj6r7/E7BJMj+/j89++2OyH3qzKKEAZbtSpKV62VvsSB+ummhdqXiS9f4O7yyoc7zWfE+aBO4JIsIsCIfZ+w1AVjtp63bPiumgFWWmB4igPNLeBrHzZCpBlJTA0biUh3mulWZolCTVKnb5axmRVguWZk6R3cWtcGlA/dFSdMfD8pQJ+oo6fP7xezgMBBFuq3DESB3bRPGVe1D8CzeIpq3N8IKC18PvM3sLpkAknNYsQuhNOpZPlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ArVyJiFMxp53seAdAPzbOptzDZtt1V07harwMu43tFQ=;
 b=NUol4XavErJTTm8Q8+P/hy809iFUzhWEBl0DKbes2pu4exz9o3T3LG0+huXBDg+FsOsFsnB889Yh02HIAbzx6I703iiwxMSPS4GP101CrRRWJWExSA1Lch/9dq6DV0kZh0X/OG3kRi1Bvz0EtJ+LM3TOG8bR96+S/rLocOaUC0E=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB1255.namprd04.prod.outlook.com (2603:10b6:910:58::35)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Mon, 28 Sep
 2020 14:51:58 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3412.029; Mon, 28 Sep 2020
 14:51:58 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Christoph Hellwig <hch@lst.de>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 12/20] nvme: remove the 0 lba_shift check in
 nvme_update_ns_info
Thread-Topic: [PATCH 12/20] nvme: remove the 0 lba_shift check in
 nvme_update_ns_info
Thread-Index: AQHWlZPZWjy6uCR6i0OafJ1+qvuoYg==
Date: Mon, 28 Sep 2020 14:51:58 +0000
Message-ID: <CY4PR04MB37516993B876C455EB779C2BE7350@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200928123502.435373-1-hch@lst.de>
 <20200928123502.435373-13-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:809d:4e2f:7912:1e64]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2304e11b-953f-4940-27f1-08d863be0d1f
x-ms-traffictypediagnostic: CY4PR04MB1255:
x-microsoft-antispam-prvs: <CY4PR04MB1255323F5F4851FFF725F8DAE7350@CY4PR04MB1255.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:576;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JcGFR79mDPMTPAQfp562lII7OpTWAsd3k6OSUwXO6wz1f570nlPSB7hbzI2zEZWsNtWmdUlYWOwHzTmN0RoOPPOfBp8ir4QuE4BCzkZrsZUHOb/I6QAo2ubEHJq9lDLrsgR1/POQfnDoIr5b3ruCNJujvUF0RFGx7DweG6f7QZ/QvPBf+D8z/uYWZEj46+2YmG/V5lA+dq9EE+jzqM/vEhq2WSUQFxMMhpbO/BDLb2UWNdInfzO2wnYdBnLg9MB34cHGt3ljX0PMKdMG1/kbaAScoO5ABhl1OMKzzIpVui/a91E/otLWZLqLYeNemVQ64gmMH0e1ojBTwr0rZlIWueXf7YOBVztFiibLrsl9Id9lGCI39fX6LfGSBQ4ckU2q
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(376002)(39860400002)(346002)(52536014)(91956017)(5660300002)(66946007)(66446008)(64756008)(66556008)(66476007)(76116006)(9686003)(71200400001)(316002)(110136005)(4744005)(83380400001)(55016002)(4326008)(33656002)(7696005)(86362001)(54906003)(8936002)(186003)(478600001)(2906002)(8676002)(6506007)(53546011);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 2shrr9Onqp+xQXnFbSzxgX+KlcaCNw8Vp3qXBBTeG9/tCMXpa5sf8hFcC4hnlnel4YubfhpV7br/t8DOoHgEbt8hzLPz7pdhKvidEFyUy/MQq6/xu3KNwtg1S1XLnn/boNggxlcXJ6B1lFnMufVvocRa5fKUMBF+u0tksVrwIa0ld2lqj9729p46PBmkr2Id8cvG+kmgmO3Bnep7OxBppoFCumSKzeZmrQSoNF84Rsg/J1HZZRGxr5sv+wL22bNVcbSgjOPXbgDrOQWJeGnd7F7/9v5B7iLG/wEwi1TVw2cTksOLgs/9FLlhR6fBWs+wJ3z6d6YnIV9mDmh5U2agrhni0PS/qq9pKIi2mrEaLjdTvyyd6QZWsZJjRqEfK0o9lz9x3RWuh7G5sul6M2ewY1hP1KUuWVqPMgt+GP6tF5LjJdzdxfPY52/jQpyO+UMGRfTvYbEFd9cyn18Nmbww7xTK18rea+NRsj8RyDoGVqzKBlpaDncrGOqjCQTk3/zfPHFeCVosrK/7zP76gsTXLFXYokwF0pVNBhbSjdzMUYxvcsLkmjFVwOqaeMPl3I7+vb8tZm670lhUeOgXwX+Cj39fCW9ir05DqOAZqp6m8a51dpXCP8dg+HsQxgXgTxvIw/F8lyzlYCMeaC8Vxa4tkf6gzp3rftyIoqu7PICEfnBC4y/1Yxw6IkuzaKlinshk1gmb5KSlQqqvgufNVbat2A==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2304e11b-953f-4940-27f1-08d863be0d1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2020 14:51:58.6737 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4MxpXmj0dK3jrk8cdHQqsl3TRfi1twTYuCdye/CWrUwFBrl7mO6h1RVZRjLJ70e7ISicJrdks9Z2/gbrPBWVug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB1255
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200928_105204_553503_75B139C2 
X-CRM114-Status: GOOD (  16.26  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020/09/28 21:35, Christoph Hellwig wrote:
> We can't reach this code if Identify Namespace failed.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/core.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 0114fe47de3571..910198c3e0bbd1 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2129,13 +2129,7 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
>  	int ret;
>  
>  	blk_mq_freeze_queue(ns->disk->queue);
> -	/*
> -	 * If identify namespace failed, use default 512 byte block size so
> -	 * block layer can use before failing read/write for 0 capacity.
> -	 */
>  	ns->lba_shift = id->lbaf[lbaf].ds;
> -	if (ns->lba_shift == 0)
> -		ns->lba_shift = 9;
>  
>  	switch (ns->head->ids.csi) {
>  	case NVME_CSI_NVM:
> 

Looks good.

Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>

-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
