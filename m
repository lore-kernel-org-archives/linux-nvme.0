Return-Path: <SRS0=ZZT4=DF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9AB3C4741F
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 14:11:19 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 876D321941
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 14:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="q0clkxDs";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ljdAiVFy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="NogDZVwN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 876D321941
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=9tFMrrq+iQb5u7ICghPqK3nFIc65s+9pFoo5UGNEBwc=; b=q0clkxDsCHFAfUTQ7kVIR48Qo
	6lcGn/dqwFGWx83R52pW6H9KXpajyX8jIecCKk6/E6YuRc7WGtAyUchn9gfaGBSesNl8OG33nwoCY
	uaVDMs2Jb85NOSkjoHc9RXJ5iD2l+WeTv0WSSn3itQBx/rgDrOSPZCH5aOyjOPbvxhnTOt1GRYHKu
	dOs++2H6692N1r0PMrtK6XK6i7Bl95UOJh/uEYnaGSlht1DYNraERGS+R7sLQhJf1tdb0Z3U+y+p1
	qYQGdadKnfhtHrpgeoICAsl6jK/nKZQIuTppJeCVMx3gaDuSHVfRzdG+t/i3pqkhU8MSWj29jtc9L
	ozOr8QEzQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kMts1-0000LI-M2; Mon, 28 Sep 2020 14:11:13 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kMtrx-0000KF-LS
 for linux-nvme@lists.infradead.org; Mon, 28 Sep 2020 14:11:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601302270; x=1632838270;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=NTCiiPJAsGINfRLz5jp5sPdF2i3Wm5rIMAzZ47gvxwc=;
 b=ljdAiVFyoj9ueDYokb8HdB5jibkNRdST16AdNueC/4DwTaJbvzP6A6Nj
 YJlLhoyuhG970IfwV6MLIJMuarWtVyrpjacPs2Z32mtV5Q1vi4iomBxlf
 cZzzHkyoWiha463PYeDb//kFqS7/oNSxrNhRm7VMP5EkeR/feFJ5VQkof
 qAgMmMxpLeeChF/fL19DLsAcJvyZlxygMt1Q8xaA0daYt5CmRqZlwKUQ0
 WrkghAhQZIXhJm23tz1YC36EvOLsSn9wz5Fku/1bccYJZSAAnc7MIwWGF
 zdTmNyV3UF+4pXb9aypOObj49/1Ud9tzVG85T287xbxJYNu55dxG7UgAD A==;
IronPort-SDR: XWs8vUxC/p8t3otWZKLOZ8Ft5HQIYQ8xaXrdveMGHET0/yFDvJyUIqpE+yz97JWZGzZwLKGpyB
 ghTdTpo8kaDNtXGi6iU2fgJlSGx0SA74SFYG0uj6MIlm6bsWvF4jKUa2OFH4HLdCfMpYU9Egyl
 XDM5ZGD1yWAdU/iOzCiI4r4QzChg9DA9kRSi043WYNb0OWzYFoCQkPYGpmKNoL4LW8PgL3/rYP
 +mFxwqqPjLjv8LaZmDbx6RUtwzc+uw0aNIL+Q5iAqrLBOeKwbwAR698pgrOY5uk5Befpcac28u
 uY4=
X-IronPort-AV: E=Sophos;i="5.77,313,1596470400"; d="scan'208";a="152813516"
Received: from mail-bn8nam12lp2177.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.177])
 by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2020 22:11:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sz3Boot6clZqN62k3VbRRQklZpQ45rXh1cpdOvSeqng4nJL26HKp9RYxqN3+BsIYgKhULINZdYK7fMCW6oaBx7vTBb75f4Mz/sF9oGIz/OlEQTnYmqYDDlhqdQfQrvGrge4yUmqOMm3PlLlE8t7BtwV4gBkQsXYxdE6tjKlW4uUp2HK5Nv0WhM4gJ/oFHNhLdOGhJnEuvivnql0wigOaVE3w5+MmAyALiTCnjYN9Ji1FwcsL0m+a13AxMfgfjvzUooYeQtJLl4XzKCyRENVQZwJ1XS3RXryg1Qgx3/pBA2gE/Z1TrUl6JoEFfDFp3lizxx1B9d61u0jfKdRpSlPj/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bMJToPAg93QBVTbg5WpRfgifkea8XFOmJoOQEyAx9qw=;
 b=iOCdrEIe+H5frVOArh81CC1ESHT2ch1FQpi165BEhYViQt4Ul6aK89ZS6VEktwEhknKWx2wgvdtn22wEWYRJkdRK/ty2F6DtSWJpUDz/X5x2euaob74BYJvn+pajoFPHrhfNTRcC69yOwqAB++oc8FYi7XoqMRCQDJs4ErOMfiXq+fGBzH003dpE7/Ei+PECgmu0eT9YwN1IsH64Ybw+18j1m5OlFWLeVq4dTks8MkybTqW6xpBNbJgi94iGBEWq8OPyrIZrC3BNjW4Om5/fSH9dQ0OIe8R4AFHlQj3ky4GlD/g1AgfAClTxciJOM51QZ0AvHBRFjxQlYNSWelK/jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bMJToPAg93QBVTbg5WpRfgifkea8XFOmJoOQEyAx9qw=;
 b=NogDZVwNx83ieNbc1CQ+dzPWvKuG/i9RKCY76GgLlcnrNlUDxU1VoCYh2SZ5gA/1HAHXljXc7EJfwnc7qntmQycb7gvYjELVy5WKkUIy0q4UHcABjyZI6nXOnReeLgj8ryPAw9wvlv49aBGZietgRpqv40WzGWIHYvsahwu32ig=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0342.namprd04.prod.outlook.com (2603:10b6:903:3f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.24; Mon, 28 Sep
 2020 14:11:03 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3412.029; Mon, 28 Sep 2020
 14:11:03 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Christoph Hellwig <hch@lst.de>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 01/20] block: optimize blk_queue_zoned_model for
 !CONFIG_BLK_DEV_ZONED
Thread-Topic: [PATCH 01/20] block: optimize blk_queue_zoned_model for
 !CONFIG_BLK_DEV_ZONED
Thread-Index: AQHWlZPTuucQzagYeUqq4kAdQhDUmA==
Date: Mon, 28 Sep 2020 14:11:02 +0000
Message-ID: <CY4PR04MB3751538A5D8F6896173CF847E7350@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200928123502.435373-1-hch@lst.de>
 <20200928123502.435373-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:809d:4e2f:7912:1e64]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d25ca39f-0e9f-40b5-c1f7-08d863b8556f
x-ms-traffictypediagnostic: CY4PR04MB0342:
x-microsoft-antispam-prvs: <CY4PR04MB034201672CC557D52395BE22E7350@CY4PR04MB0342.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:989;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9WbDZAHDAGnFMmpwKxaV/z7bkDX91/jSHpIehXwzeQXFy0dABBbreoAi1ennggO1jmyFwKVI5+ilojRgQaX1rvhUaUEEVT5La9aPLvmMnQy41Hmu/NKdkSU4xu9KXXO7FPsBFCRRaPsEMewWzm+W9pnirOXob2ZkVeLmRttH0BUJUQtFJ9QxpqAGm7bVVFnerTCHYM73VUyl/TNsN8vW+xFFxt8IPYrpTNeEfgptbEpldmRJLUhTNvWpFmA2K17+kNaMvYQkAYPIXQ6PL6L3pwuxHO3WpJhOfz7yrJdleQkm7d5cuJXmcaVaVdXrO86/9YVIq8ri+LMtZ+Rp+DubiU97/QbwGoZIqqaeNLMIoivUYijP5xFB1IMs0oWb6t7y
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39860400002)(366004)(136003)(396003)(5660300002)(2906002)(186003)(110136005)(54906003)(316002)(4326008)(33656002)(53546011)(6506007)(8936002)(7696005)(52536014)(8676002)(91956017)(71200400001)(86362001)(9686003)(83380400001)(66556008)(4744005)(64756008)(66446008)(76116006)(66946007)(66476007)(478600001)(55016002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 1LX+eS7AUwwEy1IHA1hXxqlVIoVvzzfvsOUednWr3R/8RZJvcGzsppT7VcHa3trHXGc1PP8MCHlPYQX5NV8t4e4TmIUJlsW837LO7ZKrmzytGWP7haUhiQpH4ztO6rjeI2NbZ+VIUzkV0XzJAz8HddhMrDg5QisnQSd8eXEd7PtdpiCUvjXAROmyfSWwn3wefM2YsO6WmhazA49AQTfEYRIp5gEEaoGHdUFYG6FNQ6XFJazkIdrZU92CRBExfLiLqzwrCzcntYpXgPIJVl8fUAZ1Y5Ilj0wFuZhz8kAjSYsEZ5wyEcP4P+AXBBMiBHC+UkNNWcuUtI5GlV6YX+gG/DG9+nLNSajHdk+10TRDXMLxH19KkOpef0qeNo4jie8b0+VEEf7X57w12ZeNoGW34o7fABxbhgu7ntehIYiM8FH9WTtbManLO40WjuVm7GZ+7eC7Et0qMEMcAniVrLjebl0tCLXVmabHeyHlqx3WzuXjNQ2Ni4IIO/+q++v6m/AdBAcsiReIuuex67giYAKCAWamros37fXDyCl14Dh0lng4sFU5XBJFAByezSwJoFxbizmdkWD+xmQJbhzN/I/LQwNXfvSItzsx1Y5UcwGgbSsQ0EUXh4vp3wHemnyJ9zTfqOjJ2V76LmGjfcOVX7wlJdEhGibXvWWztvfPJXZlGT+80/Le3Cig6h8ibgO8XnJfy8VXcAw0/p5nSu9iP1HyNw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d25ca39f-0e9f-40b5-c1f7-08d863b8556f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2020 14:11:02.9735 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kAOd0PBXLH8SkgfIihEOa7nVC2P6wiGpgQQFsqBbeTF8U22ftI+GBfs6fDs7BefTtYwIEOMt33S2HGat/BqmQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0342
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200928_101110_024456_91CB635E 
X-CRM114-Status: GOOD (  16.99  )
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
> Always return BLK_ZONED_NONE if zoned device support is not enabled.
> This allows various compiler optimizations including the dead code
> elimination that we so like for avoiding ifdefs.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/blkdev.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 8e77f12de52214..1b81b2766858bb 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -692,7 +692,9 @@ static inline bool queue_is_mq(struct request_queue *q)
>  static inline enum blk_zoned_model
>  blk_queue_zoned_model(struct request_queue *q)
>  {
> -	return q->limits.zoned;
> +	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED))
> +		return q->limits.zoned;
> +	return BLK_ZONED_NONE;
>  }
>  
>  static inline bool blk_queue_is_zoned(struct request_queue *q)
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
