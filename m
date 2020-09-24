Return-Path: <SRS0=MLi/=DB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D2AAC4363D
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Sep 2020 10:47:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C19902396E
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Sep 2020 10:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="s2391eeW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GXcg5C48";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="V7/74R+R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C19902396E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=pycGWjkRP+KO5ZPyv9RPb50O2WX7FQcbK61/ikOXRvc=; b=s2391eeW/eX+I/0Oegp6T3Fw4
	ve5oqkmAF9sa0k0hSC6UBqcw/WUge26rCmNCwi6qcq/5/ywAZKtB9uo4ptECHULwHds/tA78kcAF9
	ZVBUrSIUdfBGm7h+sKaO8A1Z7zaHmc9L/T2kVcjDvdHHR2AV6KlxO4wRwrQuQEDMg3K/I7+77H3FP
	mrTcy8UzFQrIfuYj3h85R/dC/OkDPQDNfYCaGyyjTmPOPEkvsK9dBxuOXkWISbZGV+9h7YtVFT4P9
	1hoHYypHnIn5oMZGG9rxfNGMNXpokQa4Br52OUl48fjY2M3sxHScELYPfC1SsqZndaQot+iMF3Rut
	FggGcrfeA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kLOmW-00075y-TW; Thu, 24 Sep 2020 10:47:20 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kLOmT-00075G-2e
 for linux-nvme@lists.infradead.org; Thu, 24 Sep 2020 10:47:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1600944437; x=1632480437;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=0sXVM9BUC3f6wvP2o5ok+w6aYIjZwEiWX1otxLUSdlk=;
 b=GXcg5C482ioj0tHmZHiUKJHkd4f0iMdKik0l4wO2lHUabdOnEBIrbq6z
 BUP5tCjPAdFE1cHWMAYmSgr71ikGTq/IvHuZGo99Jme9ws2W+qo7MU8Ti
 8Yo2gVqqvqbmUvKWYq32JtZm15kiqterRyiJdQnniYYd8/3c/78IdZJbl
 3/pTWgrh1LULLG5B57JENuTd5BLLcHe7FT4Tp0qpWc17FVmkqS+MFoRJ3
 W028ZsR00xwa3Ix6lGvedmHexdXevMTYDIXXcPwitx7I4lwySy/GxQXLq
 xN+0MofUCkEPMXjTIUG8nYXFb+LwzrEyjV+8FmB+l67NupXNvTqVx+1Kh w==;
IronPort-SDR: KmADTLaPTllOgWSiq0MfgrDpKdyO546TfwEj4h0XxbT7tCRNrGNr27yK9ntF4iaoMq0OpBQ7cr
 AofvoBGlJ9hCJuQGA+qaZKhXGb9F+yj+iqiQByvn0tcB/SaM1nUmWRosnLav2JsnRM+sTTn9wU
 x7vMK9zUHwnI/IfWTjQXsYfZt2mhaKyKWaT+yFZ2pBL5X8aReFlYEZn0zIJptK1uvI1pTtZpNq
 iGRt0zWWwVEu1rWNQaJ6LlITwCVeRJcIt7mLGDuAVs+A7ispf/yfAeGmqkTNXYPKmtqZ2CV/GB
 bHQ=
X-IronPort-AV: E=Sophos;i="5.77,297,1596470400"; d="scan'208";a="257886654"
Received: from mail-mw2nam10lp2109.outbound.protection.outlook.com (HELO
 NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.109])
 by ob1.hgst.iphmx.com with ESMTP; 24 Sep 2020 18:47:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=le8Y4UU809FnuCBQ1yY6dII4CBqvGMAlU3aymWTsN+qSwAG+emjgHJRiFb0/uAlc2qRegD/BwvH6MDiiMsU09ogm9TmvbwpnARuuZd47DTVaV5wHw1x6CeA+3QR32s1djIAfuqp8F9vk1hWAAj++I98aSgDPqkEXh4pE5Rszo9P8qrdx2iasx1hByU9a3IDI7Qk5/E20/CWxxwYpCt3dR59CaiqIMoR2kjTtkWE7fVl/QD9y+WgEO7fSNaoFrpi5lBVVpYvi/XR3czNuKtCMvk6OCmZXRGfzYGIOtAGfHqSsvjYF+OCwcScZTGggvV898jcW4tl63UISZVVErA6jEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mnkSZVpnu236+jVgbaGkzXtOQvNz4B4kDqzESDsjwP4=;
 b=eiQzwP00L0aVgq2lW7TKngNCNnVNOP1JufUYj9GSg9CGszphumSYJo9LXOPsfzM2+wvUjbx+gHQM0gZLmX0WpOlpZG6Wg21WOQS4lt2aWtmr90uuUn+jB+4Aqvpr5eL33VljJYlSLQanZmuJ4ZsG1ZtACPKlsSIuxkw+NZwN33CBVRE+r7j5JS1mZNNDlfoBIbe3rt+nDOZMRUOI3Zey2ikdMygH18P9X2E2oUmTovFfIYtAFkD2OPwIMr9UZuS+K2TTWCMZEd6oyNNzKXApPsMPypPx3sp0u+q3EbED7UNLJGihd+8DnSuyDsTBnjiNBw5JvzfWE0LQFC72Yugb2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mnkSZVpnu236+jVgbaGkzXtOQvNz4B4kDqzESDsjwP4=;
 b=V7/74R+Rc5MlOArLgeBxwuQpIGAXnXiO6vAPFYmrQQQtI0XFUK2E0D+52uxmgsVQcoG4QydZwcYiRuJHwMWw9J5r9WGz+MAzml43B7yBg0ZO4ScSMyO4l6cxEDT7mVix9gyW7PTOe14Mll0b737JQyrSM7RKuQ9InhFq5NQvsTo=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB1030.namprd04.prod.outlook.com (2603:10b6:910:56::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.26; Thu, 24 Sep
 2020 10:47:12 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3391.024; Thu, 24 Sep 2020
 10:47:12 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Christoph Hellwig <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH] nvme: fix error handling in nvme_ns_report_zones
Thread-Topic: [PATCH] nvme: fix error handling in nvme_ns_report_zones
Thread-Index: AQHWkl5neeAseYZo7km8+Yw/28MvTQ==
Date: Thu, 24 Sep 2020 10:47:12 +0000
Message-ID: <CY4PR04MB375135ACEA1246BAF05C2DD8E7390@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200924103505.848424-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:61d4:c443:7ba:718]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cda48e1f-8db8-42d7-1495-08d8607731f0
x-ms-traffictypediagnostic: CY4PR04MB1030:
x-microsoft-antispam-prvs: <CY4PR04MB103063F31D268043F4407AA1E7390@CY4PR04MB1030.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kqRBqGyerRZAZ21yarJSp2L02+X6MgW9dwRGu1DCUtoWyBrDPC8/07cyYdmihxaGsTVEm5W5nLW0DwZsyKaVAu9Od0gHWjFQr57EIbFh4HEl7FbmGtpVPX6vhiLgNcnLgU2ZDJGrzkY1sDbcgpkwq8fvngSOTXepI+zalFSFbuvu8y8ESbfmNi4DEX+WPFEeQdGSDFX83btZHn/WyL4BGHKH4s/nE/T86VRL87yiNXp71i8IFCGc9773tYVttqWRRxzdvYN+UI28bjnehq6DrW6/dRgtwkHE3sUh7iqbkYKYIyYz3QFBj/7/yjm+gjTNCq2nOFdlWumvq1vsxYZMJKUFmdwqw+Kr9TWZoLh/gFaLaQ9mn0cGsLDrOW6ft+wB
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(366004)(376002)(39860400002)(66476007)(7696005)(316002)(186003)(83380400001)(66556008)(66946007)(71200400001)(6506007)(66446008)(478600001)(5660300002)(8936002)(64756008)(91956017)(76116006)(4326008)(110136005)(55016002)(9686003)(53546011)(86362001)(2906002)(33656002)(8676002)(52536014);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: al5iegVT1mwAOxiL36h4dBs+5rCbIEP23JbYMypEsN977n4gy9iaGtu2DdRe1Ub0gvB/IJ3/43HBDl5n/tSNTvTngV4a0YH3LxptWfBG4IO8M7YmlLuhUycmuFq8jrw2DZhDrYgyqmbG4x7WQqhe2SV8hLTuh3uoakCNpOAOEJ/CvWqljH8FGSZ+BJygEi/Nt+DVc0sGdUSrOl9x3OUZi91K9MIjcUJESDpIOmOS13aKcBxqlM/Gi3F4djHYqrk5ie66kkP06N62ZW7xT/OlXLscBEjlMcIbbsHjuaKQHPXoLNsC0i3uc/x/HHK1jWziyEUND4kT2VxODbKIpcpvut5On5lT4wEBg3KMA1Zfuo9PRVHXaUckf3BL8IqCGfgNh3iHGoBcADvMY5HM64j6VMsJMAfecQ031QkTmfm9mQ/zAxbQAEQcUQIGGnJeaNSocSxks9pKJmbncJngiBmPj4hNw0sd7cuMtqrfems1DJmNwHeGn7m7yRB/ptl0hvAjrzefsd/gBv2kTv/9mOmBhy5LQFlUHe3kOE9p32J6D6JEZbAV3ZPfmvy3ocsv9uq8uLDI5adSgFafJoEINhvEZ7jgNy7QNE7bmBtFQbY1mA14jU+F4lOjp7oRwZXf1MdXIXLNG1BaiRluSOQON+CMAZdRasLqUoDq/gp2osqCFyLgfkUZ4UBO3Ht6qxxHIb6bo1odegBSCzOkthvTPFiz6Q==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cda48e1f-8db8-42d7-1495-08d8607731f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2020 10:47:12.6388 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PD25LOIBnNmu81uLtvGvs0DTExk5rFigP2Qx+3aVljmUBTuNTfb/w1NRf+WsbqqasQXR9fZs9K+XoM6t41OxgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB1030
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200924_064717_441955_733027A5 
X-CRM114-Status: GOOD (  20.54  )
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

On 2020/09/24 19:35, Christoph Hellwig wrote:
> nvme_submit_sync_cmd can return positive NVMe error codes in addition to
> the negative Linux error code, which are currently ignored.  Fix this
> by removing __nvme_ns_report_zones and handling the errors from
> nvme_submit_sync_cmd in the caller instead of multiplexing the return
> value and the number of zones reported into a single return value.
> 
> Fixes: 240e6ee272c0 ("nvme: support for zoned namespaces")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/zns.c | 41 ++++++++++++++++-------------------------
>  1 file changed, 16 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
> index 57cfd78731fbbe..53efecb6789838 100644
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
> @@ -190,14 +169,26 @@ static int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
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
> +		if (ret) {
> +			if (ret > 0)
> +				ret = -EIO;
>  			goto out_free;
> +		}
>  
> -		nz = min_t(unsigned int, ret, nr_zones);
> +		nz = min((unsigned int)le64_to_cpu(report->nr_zones), nr_zones);
>  		if (!nz)
>  			break;
>  
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
