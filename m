Return-Path: <SRS0=7z9d=C3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23679C43464
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2020 00:30:43 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 967F3207FB
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2020 00:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l578AXbv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hHgT7HMS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ebES07Kr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 967F3207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=8fPgvDYNK+AdzWjTAg2fNTX6W2h5Tk2YWviPg7lZAKM=; b=l578AXbv5YA35DxStj5mO+uNT
	utMi0K8zZf/0kr61r4B9cwJYlfaoFApQ96Xvyk4GaHEoveLX54bMiR097YPe0w3r8m8LpWw/PFlqg
	+tADQ9TroABQv7FP7SiO4lwekGCi4MYlecLCL4/My/b2WJYYjHFhBczDWNUTpI/06PJzRxf3AH9sU
	/14vZW/dDtK5XLLI1QLlwv30TjSjgP9tYONYUpemQ4DE2j6BUnSOFtzk5q5XC5yYk0ho+H7KgLGE4
	c4OQrKpteKWGKsOm/1QJDZfWbD3af1xASMDzY6WRbxQuCmrwtvtgHcAHUpzA35yXSdCc8jxPlWUor
	1n/Ct6a4A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kJ4IR-0004DS-Vs; Fri, 18 Sep 2020 00:30:40 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kJ4IO-0004Ci-K6
 for linux-nvme@lists.infradead.org; Fri, 18 Sep 2020 00:30:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1600389037; x=1631925037;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=V9LMB5/HWwOYJcCdyKAs8X314jcD8UXjuQ5Uwpznk/8=;
 b=hHgT7HMScMAecKs5TE/S7SSQrJeVSMpQR6f7EEuzE2BQxsHYS9SKJs9G
 nw5eH3N9NHFdNuwxl4lN/dmQ8daYnFeIGaNc3UjUlZeb5T7prtW2XtjJz
 clkWZCQC+gEpUtRImyl5sfJbcop1vKzYZ4GFriRXFGPa4HFwFGBGJAhF6
 Ov/wmw2U01neE3WovQUh5adFy40wKRJu5wDS3Ej5o12e2pK1k2r8YbLro
 d/CigRxC7lJDJW3uHS8MdSow4LHnjCP8xClzerEG+8EiOlzVpn8WqjKCe
 bzbFu5fu1PAXZaWFPVTREza8JvT/RE9PMrJiTanuWbZmoExiIyE5UZBYC g==;
IronPort-SDR: qf1Z41viSSvwepqQvtWG1RP6XNgp778rbwgW2EX4Bzh3+fJ38SQvbBjx7Ka3oUrmiBfZxOT0zS
 qQZSfVQ6a4rSHbUiiRY5v3emDSSY1nNWCz4SwyfrHOEWp85FesagYsJ1nVO6JTHtDCjBkb0GEY
 V9eiIBqINHlBU/u2y+uHYVzgc6FRi6bBH3YAT9Hz3ZfIuK5qHtUtzbdRlN8FGeg6HLMk4frQtK
 ckiw6YJUhEl1vD2zs/cgIEA0uQGrK7draeyIcLq2JwwkI1Of099pMylvMJDlqFWxRk3T5qKyHS
 oVs=
X-IronPort-AV: E=Sophos;i="5.77,272,1596470400"; d="scan'208";a="148912400"
Received: from mail-bl2nam02lp2056.outbound.protection.outlook.com (HELO
 NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.56])
 by ob1.hgst.iphmx.com with ESMTP; 18 Sep 2020 08:30:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nHB/f2OxHfjZBjf+5qwAgQIVOU+OfY+ZkxJtD+zSeSuMkW2T2c8cPmsnY0pdz1VZ6beVIm2cjhEbjutJXt+tRbQyGNCKE+J+0q7ZNSAfImHYCU2oQA646PkhW7d/CAHLZ3q+eJmxEm9TWMo1YI1rWocT8gm8oGiwo6LtWuD477GUSjP0bdqU+m5V+SY5TBH7Fu/Ql+WbVP5Pq5NMBLorT4CfnBGdFr9g8UfyEn7wFof8b/4iBM0HqHp3JlztexRGOb5TvVWcHHRrRko56RmFtkJQtDlCal04S0p1gpbOez23SqLUWNta2JzsrYsxH/bFK61E4z2R2YbOkHlI/hBbXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ub/IM5AXkd9CH4YE1Wc9uwWc4eMXdekPRe0Qanl8Vng=;
 b=aVDXkr+XS6p5eHF2FPLpVEOlCJr1ihiDS2l51PRb709eBZOh8n8wO5JvBlXi/8jadnx4ik1JEEE1/AOf3CZ03mDu/z8uMpp03xASdJGicVBhqGN1eAa1IWeZoufJYRcU46yUMgtiSAxLxRDmyRsazFta4886LPMlsnheoXB67KO3ffoiBT/L+tVIaoClf8iJh057izmsJ5+vAm/a+NsV585UEJ3KuA9hSXvk0ffTXhoqUKvEzdgfqm9cm40dEv5XSZyrZjiyFXeS3jbyTumRDXX/Ny6PUlDkf7J5KJUGxTHK8FGYjoVqGN9GCCddCzlU9t3oLYrizy9ldTYbaw/7+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ub/IM5AXkd9CH4YE1Wc9uwWc4eMXdekPRe0Qanl8Vng=;
 b=ebES07KrtIfnWUziMk9GX/k8n+NSB6axdmHnPDqgdAVgvhSIy+JFmz6U4G2/e+HQ9AN6iEgIXCeEoYZY1/opp6hM8G6oi9YL5pbELvqJ0s4E+0BD41KLwweCZ9FyGRF8GXPwXy6LW/5YT16+AG5yZaOO8OS4F7s30ElunlWHh18=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB1225.namprd04.prod.outlook.com (2603:10b6:903:bc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Fri, 18 Sep
 2020 00:30:32 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3391.015; Fri, 18 Sep 2020
 00:30:32 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Keith Busch <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "hch@lst.de" <hch@lst.de>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>
Subject: Re: [PATCHv3 2/4] nvme: translate zone resource errors
Thread-Topic: [PATCHv3 2/4] nvme: translate zone resource errors
Thread-Index: AQHWjUjpK3F9XEFLvUaN7nKRXw3OuQ==
Date: Fri, 18 Sep 2020 00:30:31 +0000
Message-ID: <CY4PR04MB375186AFD0FD8260397262E2E73F0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200917231841.4029747-1-kbusch@kernel.org>
 <20200917231841.4029747-3-kbusch@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:c162:b6b0:12c6:8cc]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 110587d6-2e32-4437-33d2-08d85b6a0d46
x-ms-traffictypediagnostic: CY4PR04MB1225:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB1225C17EE43C684A783C2815E73F0@CY4PR04MB1225.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:849;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IAeDCSO9sH/TqnnK9y6SG9l5CfTK1rEIE7lr06zgyJaHqHooEGIF1l/6jaQiRTGB75ThbVQ8ME5OW7AmyIP8IdEYYDxC53l6bYKrRRTbuV1rOMS0FIIZZxtn7W841Ht8vXG5gaT6oljHCe4GpqdV8/KvbfhgFQ8Uwo39R9VNBYUWe2enf+av39MrhKTo0uGTMOyOfxSf/wqiQkHUH8QFwJD6zrA6tgrG8so+rInGOWTAkddxLnnoy8aaSDeIo4VxhIt1BvUosOlw4nIMvfkt1Enf05sGwgBZ4AybcImlHcGEUwhJMnSGtRTzP5g3nn5GiPAIZKOqyfQIZiSPyb77dA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(66946007)(64756008)(52536014)(66476007)(66556008)(76116006)(4326008)(66446008)(91956017)(5660300002)(4744005)(478600001)(9686003)(8676002)(55016002)(316002)(54906003)(71200400001)(110136005)(186003)(53546011)(33656002)(8936002)(86362001)(7696005)(6506007)(2906002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 4pJg0PZ6FwtX//asjdHXEQ+lTULwqyv4CArFirZrsHM+U4sOsJuV1DMPMP+G3xY8w2l1cPj57/m403SAt+lfdMirHCaUjDGCoxOsDZOVfDn/yYS7npWv6Kh0fBRJfKBXbJ3C4rRq67mlCvXrFfVCAJR7GeaxCyAP9WSeZ8fA/cTjp4Cbl2m8E6wB+LcNeC69zhKQBZ4jJecCTNSUQHe41YKz4mI8RR+QULEKhQhlXZTWlwamFcx23OoyyGtV9uMV+kg2g97IgqNA+4XC1pWhKiuxxKOvRaon+SoVSEo1T0g8k7qDfX3jz/f3XjiN3zsdTO5w6jJaJelMeGJNoYJ8KnOoVCv48rnmIulHW66FgXFxq5ZzrlREp0wR5yHwzXMrFN4AP/RwR/0UBZ/d1yk07dWhAG59olvYc2LRDq5/wNAzxLCX1X7QT91GAY/P/OoqEIWh7WyKuux4fQ4+2xX9FCnfsn5eBfh/MGIXn4/UHf4ref0uZp6aHn8jxPAhTmblBsesk6dtlWYIH5pwogY07fBuHZf/whMTvCaA/xPTDb7fi0glggrOD6kRY+/uYBx17uob+w8Zp5E5RMYCjsu5g66NcNtzzvEobzImd1oLM5LOHYhnPxdch7XsitHvkas+UC2Zl3vyYGpX60syYZ6UW8ytTnrgpYRH8U/DrD3rqhD7SaNBht/PfcUUUFnB+DkE+ouC/I9ceBp3jQLvSg1yfw==
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 110587d6-2e32-4437-33d2-08d85b6a0d46
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2020 00:30:31.8531 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oMB3AfLPI7CR+ynmBg9i77GQvRRMX9O2hF6ePsdF489DjSuOzU/5PQrKnOI52VSjnaD7OxPemf4WvxzkUPG4gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB1225
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200917_203036_826123_7FC53C7E 
X-CRM114-Status: GOOD (  14.48  )
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020/09/18 8:18, Keith Busch wrote:
> Translate zoned resource errors to the appropriate blk_status_t.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Damien Le Moal <Damien.LeMoal@wdc.com>
> Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/nvme/host/core.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 614cd455836b..a0d26fcbf923 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -236,6 +236,10 @@ static blk_status_t nvme_error_status(u16 status)
>  		return BLK_STS_NEXUS;
>  	case NVME_SC_HOST_PATH_ERROR:
>  		return BLK_STS_TRANSPORT;
> +	case NVME_SC_ZONE_TOO_MANY_ACTIVE:
> +		return BLK_STS_ZONE_ACTIVE_RESOURCE;
> +	case NVME_SC_ZONE_TOO_MANY_OPEN:
> +		return BLK_STS_ZONE_OPEN_RESOURCE;
>  	default:
>  		return BLK_STS_IOERR;
>  	}
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
