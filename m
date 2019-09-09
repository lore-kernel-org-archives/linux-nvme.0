Return-Path: <SRS0=NvMH=XE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02250C4740C
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Sep 2019 16:48:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B931D21479
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Sep 2019 16:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Hx3eVXdH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WK+rQmnc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="iF2X+OBy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B931D21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=PDM3pIbQ0q5snqFjpuiavhnx+JGzjgtZHaroDKx3FHY=; b=Hx3eVXdH2BBkGu
	ebqLrwP6UFZMd28ieBwh832RsPmdTcihS6PJUYXhfKtLOwhJHZxAmLyE7xzjz9xMdBbTICfVYDkeH
	wgAmalv4cCNeBWm9Taj4axygesx2hoDv8mfQ0j9nzth0SrDyDLIldHRtMtUrxplVzvdZFYtPQCjjj
	PCU2YlvKKpmXkn93u43w/ClWxg36t/+xSQSFY22XvTHMXTww9MD+yoFdv8k8GWqQ+330ii2izUbIv
	v33FvZNsBe1nt1IVidf/rSIoy1lnwsPrEMQDWqzmByMXyhd1FUru1eK80UhnFFE3LhojkI32Ps5Te
	uNrDyi9ZxQRKWA3UvR1A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i7Mpi-0003C8-Rf; Mon, 09 Sep 2019 16:48:06 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i7Mpf-0003Bk-RX
 for linux-nvme@lists.infradead.org; Mon, 09 Sep 2019 16:48:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1568047683; x=1599583683;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=HBk+XTmfcWGUJLN2ydjIF6gre1kBsKJTXBEX+rKUbs4=;
 b=WK+rQmncarJfNo/aSeKB6LJ7TA8D7NAI3eiTEZMKTgvC/VnqrftdfmNF
 wdo03Rqsb43X0mmDhUYBA1vOUynBSIkWhIkoHN+SbRePFigMubZFAOEdf
 du/kEXRao7hrlxvOb6GEyR2LosTy7yRf3Mb7RAaCInkGIdtDPgXizygZu
 yKfMJyjrjysI1sNyoj5Rr+/7pQy1qB7RHJ9GB6EcbY3eE/Bv6HAVXuw3A
 7uJPZmOKpqt0PiKIkbiBXmWcmE+KQVmFjddhpQEC331xIL004QLsILQ0r
 Ff9I2op8IkSLEHuKpiSEiD9DjDlkLLH9geZ7P2C/vlECMk4UIfmqS0Z8P g==;
IronPort-SDR: YbQklKwNGhvD0vtLbF050lsap6sFELkCRk/L/0XSkm+5MBkAd4KubydqfImSLpZwQuwvRwC6yu
 5fU2KCk6io967Rx3REH0E3cvXmsfUlHFMLU6w3EYc/Qp4Ut469RFeJPZU+rgby34rWkzySeTHu
 CK+PDntCu3qMB0OYEqZn5dCjqNS6WwzgKe2jS7xcUkGDns7Y+iazyMhubVY3MCJhEyYbpBYxPi
 Y5fbE778eUHaJ67AxWYVFcj5+v6jP+rUfh33doi3QEC7Ub3rPTjXV2Gjlaipyg/KfzKVSUARFN
 6XE=
X-IronPort-AV: E=Sophos;i="5.64,486,1559491200"; d="scan'208";a="118724600"
Received: from mail-sn1nam02lp2051.outbound.protection.outlook.com (HELO
 NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.51])
 by ob1.hgst.iphmx.com with ESMTP; 10 Sep 2019 00:48:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RaibcaKTy0V2U+r/dIEHl9tWIwJ8enDKH0ZTGhC4wYBf3U9rnQF3DgHRRzx23sBdouR0Kp71y0FfP9TKGnZlj8VXO/y6Dt6UGYlv5TOBaR1vfLHABkzOPRNKb7lNxmLKk+9HH5zoSOE82Q8u+0TM5enQ1DFh/u/kiztx96l02h8YHy3cMKWZLiL7SWOS+D96+//TmLNTqMCImXzJwvBa4aeOGGywZGSzf5HGVXSoVKKEj2UzBLqzwxzGg7hUDsYxXj5AbJ91N8/0/miUaFeC0RSAh9SeSFmAHI4BvFoHkvZ0kflK77LFavdt82XEIklFtOktOEg1KqzDuxfSitd1bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gDdEecT96SRPT1JZBLVuOWScwYRhTmdzQdX+g2ciTxs=;
 b=mp0XKNIItMvuBIgXz1jhFrkKU5QsWAjSKcFZ3wxRuYRHH76oq6hjnnFWmV3Lp4Z56RZWSt7A/00T6Bf7yv0131oK7gladAqIu0id9mQ/RW9AABPrX1SyfT+v0NXaSo6+cK6uL/5IfdZAE9q/VlRvB2dCwS/JWzJ9PhocZoXbI6JsZFDVtChQKDFt1/Lgq8gQ9v++69zyj0qiAOQCBY0wz3PKz6xiGCRP/vnH0SbsbXEMa2wabEukBV8d/Cu3xz611BgkU+/V3j58mOdZ7Si7BnXdKHELRT5dUAvM2nLqu9DNThW+O+V1w+cZrMfb8rLxaKgx0FXkRcbg4rEkdgekKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gDdEecT96SRPT1JZBLVuOWScwYRhTmdzQdX+g2ciTxs=;
 b=iF2X+OByIgF0Dt1eMZKZ1hI7drYC4Ou/PguY2/2XdH8h6V+R1INqIQU1sKil6oJpZliP3Mv+b5fZEW6sl9S0/E58wD0K5yW6C48ZOSYhxso4gCTbQdlp3nRxvCBzUCq+waF9PH7+RdbVDnPRUT919BUJTG7xokGp6QqcJvcgURQ=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB4167.namprd04.prod.outlook.com (20.176.251.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.18; Mon, 9 Sep 2019 16:47:59 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6169:680:44fc:965d]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6169:680:44fc:965d%6]) with mapi id 15.20.2241.018; Mon, 9 Sep 2019
 16:47:59 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v4 1/4] nvme-fabrics: allow discovery subsystems accept a
 kato
Thread-Topic: [PATCH v4 1/4] nvme-fabrics: allow discovery subsystems accept a
 kato
Thread-Index: AQHVY2wr5hnCntf++Eig5IT4FYRyyQ==
Date: Mon, 9 Sep 2019 16:47:59 +0000
Message-ID: <BYAPR04MB57492B8AAE2A59F3A37E288486B70@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190904215954.15423-1-sagi@grimberg.me>
 <20190904215954.15423-2-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.170]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c0264ef5-a1c8-437d-7bc9-08d73545792e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:BYAPR04MB4167; 
x-ms-traffictypediagnostic: BYAPR04MB4167:
x-microsoft-antispam-prvs: <BYAPR04MB41679887B05ECD3FB0E6055786B70@BYAPR04MB4167.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 01559F388D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(366004)(39860400002)(396003)(376002)(136003)(189003)(199004)(66946007)(486006)(3846002)(446003)(476003)(305945005)(186003)(5660300002)(53936002)(2906002)(8936002)(26005)(33656002)(102836004)(6436002)(99286004)(6246003)(316002)(14454004)(25786009)(66066001)(7696005)(76176011)(4326008)(110136005)(6506007)(53546011)(8676002)(256004)(54906003)(81156014)(81166006)(229853002)(9686003)(6116002)(66556008)(86362001)(55016002)(64756008)(76116006)(71200400001)(2501003)(7736002)(71190400001)(74316002)(66446008)(66476007)(52536014)(478600001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB4167;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BB4MR9EDyJJz/p9KiovWRq9PVTFpcQNoSRNkSMitEGnlUvgbqx/8p5zg7ugUHlL2Lk2u5pP1r6A9e3DpLMlcizuiOXbKzBmsq896DbAlxwr7C0I6k9CW6MfEYleJ3Kf0i1i2/K9mlSm6/VRpwE37aiimDtH7DyCSmrSUHqxT5zBrmhkD3/eD0s5KKKts1lPZGZ8yL+oDGyFXMLJ2iSvCXi1C+28Q+M14i+HYLJYvRRr/DzNZ3LtBmOZxez1oXckbGZfXBiEoE9t2EimIohVv2Mn4kzwKPvRsT/F8Yw5kSlTvYmw79HDJG8a+9LthIaYSBoMkzxvfyh7Uz923+Ms4H5CCGRQDJvrP6QgpzZi2xe2TB3XRk1iKNTkTeUBBhrdS1GhUQzndS4X4yE52K3ON0rJOtNwd/RQjM9psLI8AYRc=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0264ef5-a1c8-437d-7bc9-08d73545792e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2019 16:47:59.7150 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vM9CagCHLZb5RkyyC9j6T8S6qYPCHddcGF1UBhfOSrdZWixdGN2UC0mS2NZe4j36mfFEpnlse2HLUj8Smj753TrvuJJcOwiy1VWh5SIa1uo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4167
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190909_094803_982869_241127F9 
X-CRM114-Status: GOOD (  15.66  )
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
Cc: Keith Busch <keith.busch@intel.com>, James Smart <james.smart@broadcom.com>,
 Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Looks good to me, btw do we have existing test-case which
covers this behavior ?

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
On 09/04/2019 03:00 PM, Sagi Grimberg wrote:
> This modifies the behavior of discovery subsystems to accept
> a kato as a preparation to support discovery log change
> events. This also means that now every discovery controller
> will have a default kato value, and for non-persistent connections
> the host needs to pass in a zero kato value (keep_alive_tmo=0).
>
> Reviewed-by: Minwoo Im <minwoo.im.dev@gmail.com>
> Reviewed-by: James Smart <james.smart@broadcom.com>
> Reviewed-by: Hannes Reinecke <hare@suse.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/host/fabrics.c | 12 ++----------
>   1 file changed, 2 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 145c210edb03..74b8818ac9a1 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -381,8 +381,8 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
>   	 * Set keep-alive timeout in seconds granularity (ms * 1000)
>   	 * and add a grace period for controller kato enforcement
>   	 */
> -	cmd.connect.kato = ctrl->opts->discovery_nqn ? 0 :
> -		cpu_to_le32((ctrl->kato + NVME_KATO_GRACE) * 1000);
> +	cmd.connect.kato = ctrl->kato ?
> +		cpu_to_le32((ctrl->kato + NVME_KATO_GRACE) * 1000) : 0;
>
>   	if (ctrl->opts->disable_sqflow)
>   		cmd.connect.cattr |= NVME_CONNECT_DISABLE_SQFLOW;
> @@ -740,13 +740,6 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>   				pr_warn("keep_alive_tmo 0 won't execute keep alives!!!\n");
>   			}
>   			opts->kato = token;
> -
> -			if (opts->discovery_nqn && opts->kato) {
> -				pr_err("Discovery controllers cannot accept KATO != 0\n");
> -				ret = -EINVAL;
> -				goto out;
> -			}
> -
>   			break;
>   		case NVMF_OPT_CTRL_LOSS_TMO:
>   			if (match_int(args, &token)) {
> @@ -883,7 +876,6 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>   	}
>
>   	if (opts->discovery_nqn) {
> -		opts->kato = 0;
>   		opts->nr_io_queues = 0;
>   		opts->nr_write_queues = 0;
>   		opts->nr_poll_queues = 0;
>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
