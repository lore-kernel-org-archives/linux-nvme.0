Return-Path: <SRS0=W+Vz=CJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C7DC433E6
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2020 00:21:13 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B602C20757
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2020 00:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qvL1rLMc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="R9RZxV32";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="d6aYA2d1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B602C20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=8L8Z6jcYbrBzdpVA5l5lv7wbJ8/Pg7q15MulcVSd1zk=; b=qvL1rLMcZzRulZymbo3qJW2ch
	OBkHR6epuL4d5k4B2lZ8ionAW0O0Uu3ORZyr+1IQerHweaVov6Ozx/vySbnLod/I+6I4YGaTxJ2vp
	6Bi+7AdFAGVzT3RNBIi4afPPLA1WLf51Iy8EToeneqb+ZFwLyuWnEpRp82zvXNQ7UyzLOY0gACD+Q
	jOek/8Vo/uzP8daCx5ZHqg/kKHHn85G2K6ZBPdNhGMIsV2X6i1kJMk6zrpKpoD5UZHNylHC7BgwW3
	CXY6mz/jiWhn2pE69etHjPz2wJyMYdVj4bh0Di3Csn8iSkBpX6uhdROXfwPOSHH0IrASB+u6hY1Ws
	308TrLh5Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kCXZJ-0007WI-I3; Mon, 31 Aug 2020 00:21:05 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kCXZ4-0007Vr-W9
 for linux-nvme@lists.infradead.org; Mon, 31 Aug 2020 00:20:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1598833251; x=1630369251;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=57sbEebQzZJTjSP2UbnHDEhK8Dos5LDGtFSOgIIv1KQ=;
 b=R9RZxV32l8Bqwk2Bbt786Zq4+bgo4RWoJAjDImOd4vRfEw5MJeszYN4H
 e7l4BhcgiqufdMNDnLbaUmDD7HC/julfzS4eBWe2yerVc3+8jc9l0Wxuo
 WgndO5BE7QQdqXRUdDh2AH2o3klKlp+IJTpfHKD7WS0l8YgJJ+IzUYV+5
 BKlU6TYN9qEul5z22d9MQ5Z9BCq5pyyo0HX2tgDMCcymZA7ybTnUBz9LF
 A9Y5I662VT6uADkfRKR6mjlxfLbmFyoHu+BUzs+0P+oecA2Xs9vDDa+8u
 z2sbyZlogOnoZtyJT69+LVr23bTBYdDZwW8KfSDjpJihfXaDkwfvKYeL1 Q==;
IronPort-SDR: TDV0W0thpeJtpFmTl+Hb1t+s2+o8K3UhF00DkcfchlYaIuq3BuQ7nnUK9eUQpdEmtlhosotsk4
 hXIF+ZUktWCAzKC2kVWJd+arSv9WZvLOBBGzoR/35yKHkCSepRFVol0XPbdaTZcBq72zCabc5b
 yrpGIUJK/KwIhaVg2AuFyHmDkhvRqC2K3XaDraBPaP1/jy1b8uBnAgFfbRFZUhSfd41H/zEMSF
 L6vc8S19j0A0DN2YeDuVu+ZUCysDganBaiEq5Mw4omUtNSHJM7qsDRH7qYCYxxeoUKvj2rgKjP
 Reg=
X-IronPort-AV: E=Sophos;i="5.76,373,1592841600"; d="scan'208";a="150522870"
Received: from mail-bn8nam12lp2171.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.171])
 by ob1.hgst.iphmx.com with ESMTP; 31 Aug 2020 08:20:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mgl6oAR2mHcLj/zpRlQEOTW0rXym0DJTsaSLn64hvg0Hv2xX74vNauxIQXMxRTv33BKCKsr49N/e8zd9XbrsWVu/uvS+jmyieFcpJfuVq4EhfqrNRVQUPQwSQ45BC4HacUbEG3X0kET68LKh+gJhNJ6X6gfnpAhSZjL/0wW2DIm1o9eUO0IyR1u0yrC1WK6A2nIFqeJG3qqTqwf3EITRTOZlhhJ9XMx3ayKRlDvR/Knn9gVWgeywkNiWyJOLEJHPNUtf84JYqg7mxnWz22GimAIvqi94nRSWVehgkcj9GqLutY5e7sOeFrv81G+vZw/6xjlw/CsXWGxcrPnO/jenxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7WX5vSeHuUMvEbXYkg8NMZcDxdjLzTmg0uhqZbt1Sk=;
 b=B0A/sbdDKprrlAw+JxwEVHrork0gkmDuwQso9rEuikjQvtCtxzNZXpGnhJO9hfiiLzL1+QHkSKziwMZH8S5V/P+UF2QJB5uw8XsRlieMhY/zdOiSPUW/GRrC9Z1qS7+Xk/+hjZ2fdRBE/2mmYjDNVT0OJZk0ns6HIR6zJhWqQ3i85QTIawd2KRT41rGRMbPSpa8UC9EJXItxVtbITZyQKH9lw5nDlbSmnfDKO55HPm3doGJPEZxOkd8GLQUmaKUklp54NBCEksFmzIC7J5vaZppx1zcpZiwFtb2HAYw39i/KceWmw8H0tAhysNR7059ZsIojJqmU6+WLlcEbt1M7tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7WX5vSeHuUMvEbXYkg8NMZcDxdjLzTmg0uhqZbt1Sk=;
 b=d6aYA2d1bFbmdy5HFAEPAeD/nT3kGlrFbizmoEMeKaFByWAtp151Ox24ztHKBG0V+kGbOxiQAhrgCZ0CP8IXEVAti65duliyYwo8AeJwaiDaB1ZESIEOOkRuu8dEcQXCz5Qxw6V/PSklLoZJWafFS4lQAthIkPi8ey2YAiKYAfE=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB1049.namprd04.prod.outlook.com (2603:10b6:910:56::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Mon, 31 Aug
 2020 00:20:43 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3326.025; Mon, 31 Aug 2020
 00:20:43 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Christoph Hellwig <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH v2] nvme: fix error handling in nvme_ns_report_zones
Thread-Topic: [PATCH v2] nvme: fix error handling in nvme_ns_report_zones
Thread-Index: AQHWfrfwlwVTYXPEYUO6KLTmUkxflA==
Date: Mon, 31 Aug 2020 00:20:43 +0000
Message-ID: <CY4PR04MB3751C089FDF4DD46B7A8A50FE7510@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200830100010.1262680-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:6c79:3d7:ce06:5b33]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2add1adf-a624-414a-2b11-08d84d43b327
x-ms-traffictypediagnostic: CY4PR04MB1049:
x-microsoft-antispam-prvs: <CY4PR04MB10499E244AB2BE403171F3B6E7510@CY4PR04MB1049.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MhsLy3G+IxzmFYM90Tw04dHm2aPOGZ1acoxKh7KweZktfaWe5/JMKDQYmey3Xpjh/KHiDI7hse9qfYa2SkLWhGHdIJuyq4JN8/hh+WAUY8zR8nJert+zaQG6s/NVU8ojYW2DAKuqqBNDz/h9PHMMF4VNlDR+zmzr9Qu3/u5vkGJwgYwhrRexJdr6z8wNvnL6C2v7XWKsMYHtLWNUlSWHdUcKZ63EgaYrAqtLVXlbYd6deeyLfrC+eg0oVVxabpusH60OSJjMDbBgGKAJnF25rab9wHygBQl0/PUerPCCiqqXYpEPbBxQiBQtOiu1FLlM
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(5660300002)(4326008)(55016002)(7696005)(53546011)(6506007)(2906002)(110136005)(33656002)(316002)(8936002)(8676002)(9686003)(52536014)(66476007)(66446008)(66946007)(64756008)(66556008)(83380400001)(91956017)(86362001)(76116006)(71200400001)(186003)(478600001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: XfzOUet0+1odPWM2G22DGBzTZWB2aO/6fCMuM3Vm/BRcdOElsj5TXN3oIEw9+9NNuJPeJM3Za+J5dT+yaYqp6wZy5X+7PHIc7X8CnRYkNk5lY57icp7lVl0RvVAKQXpiKSLuwkyMznRgzQhJlCTDrRWaLvdM/CCL0j7rOrHFjdDYMmO9fMxrTZ8wKfG5NkXRoTcrf26cKTDK025YDLX1ehvdfxl3Kl7CabbwsUk6TXsdwauNDhQfeisL5LLq9vnTPzeLNu8kNC4uPblrmdviDpA03gyyUnz65CJv8HPUtS+ORwqAvmwaqgvnpQr1+2MG0ppgUbIJaVNBDt7uAunpIdFHXYlHFyIvfcX35x7pLm9KcI3YXKsvvP/GRs5bBalJAOE4jqUVPVwTmdWlMc6HR+4IKtcddYSgqSRC9JOa8VUu6agU2RjZFllrj+U1dlbTQuSqFx4scmpfgjvYx8l98E/rQLyx88yEvjuRrFrvCSN1UO6GZf23d7cc+6LFhbLdZT13TzvpA4VWiJsyUUqY0N7vHx5UyeK5QLyhFHvH2KCWBTHcI7Bwe3pyCaXuh8yggcZQ6gKIinMMbFL79SakX+3088VN/iNDmcJhpe6VuQ0JosyJKhx2hv9UFxGQRbPpFED6/FNVv5gSdX/D5szTv7HCZ0YPlQ0OwD1EQ/xDh4SuytPu1Qwlv7keYpmrGPauDW+nPmNbaNyJCMER9i3hOQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2add1adf-a624-414a-2b11-08d84d43b327
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2020 00:20:43.6456 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9v3JfEa7TDOTwhfPy03g0ubt2fPKbjmOhk1+uUmpstA3umGtAZW1QEYEUANOsLVMMVCzh0PYxVbRITn7FcVS1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB1049
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200830_202051_379892_88174A29 
X-CRM114-Status: GOOD (  21.50  )
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

On 2020/08/30 19:25, Christoph Hellwig wrote:
> nvme_submit_sync_cmd can return positive NVMe error codes in addition to
> the negative Linux error code, which are currently ignored.  Fix this
> by removing __nvme_ns_report_zones and handling the errors from
> nvme_submit_sync_cmd in the caller instead of multiplexing the return
> value and the zone size into a single return value.

s/zone size/number of zones reported/

> 
> Fixes: 240e6ee272c0 ("nvme: support for zoned namespaces")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/zns.c | 38 +++++++++++++-------------------------
>  1 file changed, 13 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
> index 57cfd78731fbbe..b4f0543d74700e 100644
> --- a/drivers/nvme/host/zns.c
> +++ b/drivers/nvme/host/zns.c
> @@ -133,28 +133,6 @@ static void *nvme_zns_alloc_report_buffer(struct nvme_ns *ns,
>  	return NULL;
>  }
>  
> -static int __nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
> -				  struct nvme_zone_report *report,
> -				  size_t buflen)
> -{
> -	struct nvme_command c = { };
> -	int ret;
> -
> -	c.zmr.opcode = nvme_cmd_zone_mgmt_recv;
> -	c.zmr.nsid = cpu_to_le32(ns->head->ns_id);
> -	c.zmr.slba = cpu_to_le64(nvme_sect_to_lba(ns, sector));
> -	c.zmr.numd = cpu_to_le32(nvme_bytes_to_numd(buflen));
> -	c.zmr.zra = NVME_ZRA_ZONE_REPORT;
> -	c.zmr.zrasf = NVME_ZRASF_ZONE_REPORT_ALL;
> -	c.zmr.pr = NVME_REPORT_ZONE_PARTIAL;
> -
> -	ret = nvme_submit_sync_cmd(ns->queue, &c, report, buflen);
> -	if (ret)
> -		return ret;
> -
> -	return le64_to_cpu(report->nr_zones);
> -}
> -
>  static int nvme_zone_parse_entry(struct nvme_ns *ns,
>  				 struct nvme_zone_descriptor *entry,
>  				 unsigned int idx, report_zones_cb cb,
> @@ -182,6 +160,7 @@ static int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
>  			unsigned int nr_zones, report_zones_cb cb, void *data)
>  {
>  	struct nvme_zone_report *report;
> +	struct nvme_command c = { };
>  	int ret, zone_idx = 0;
>  	unsigned int nz, i;
>  	size_t buflen;
> @@ -190,14 +169,23 @@ static int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
>  	if (!report)
>  		return -ENOMEM;
>  
> +	c.zmr.opcode = nvme_cmd_zone_mgmt_recv;
> +	c.zmr.nsid = cpu_to_le32(ns->head->ns_id);
> +	c.zmr.numd = cpu_to_le32(nvme_bytes_to_numd(buflen));
> +	c.zmr.zra = NVME_ZRA_ZONE_REPORT;
> +	c.zmr.zrasf = NVME_ZRASF_ZONE_REPORT_ALL;
> +	c.zmr.pr = NVME_REPORT_ZONE_PARTIAL;
> +
>  	sector &= ~(ns->zsze - 1);
>  	while (zone_idx < nr_zones && sector < get_capacity(ns->disk)) {
>  		memset(report, 0, buflen);
> -		ret = __nvme_ns_report_zones(ns, sector, report, buflen);
> -		if (ret < 0)
> +
> +		c.zmr.slba = cpu_to_le64(nvme_sect_to_lba(ns, sector));
> +		ret = nvme_submit_sync_cmd(ns->queue, &c, report, buflen);
> +		if (ret)
>  			goto out_free;

Isn't there a problem here ? goto out_free will do "return ret;" and if ret is a
positive error code, then that value will be interpreted as a number of zones
reported. ret must be a standard "-Exxx" error code since this is a file method
and the caller does not expect an NVMe error code.

>  
> -		nz = min_t(unsigned int, ret, nr_zones);
> +		nz = min((unsigned int)le64_to_cpu(report->nr_zones), nr_zones);
>  		if (!nz)
>  			break;
>  
> 


-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
