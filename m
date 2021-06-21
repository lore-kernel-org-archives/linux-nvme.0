Return-Path: <SRS0=I4H8=LP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63C8C48BE5
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Jun 2021 03:23:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BB42611C0
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Jun 2021 03:23:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BB42611C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=0UZDUQzkXWO8jO8TvOePdfblkMear0pWtgPwjrzgxbk=; b=n+ev33RJexTSZS
	MlBU6j50qomT2ZuY/UgfxNh+Ft53puj1I7fzHrs6eOeKwo6xpnDUfG5+nUp2P5y1pceZHfsnuWgKX
	4MebsM0iWLIXzH+MmOBRN3bgIYlxmJXonCjC8/EbBYV6yGoBJD2P6NnGvOTmUT8Uwfg96HHLh2TxQ
	YiriASS081nhO3GU4Z/LQ3FIZ5HyNv+UauB/rlFlRaD8aiRzbgJ2wwbt9HdX50yqOxznEqVMcDjwx
	pIBUmFWkH8QCGUsqxEzxYz0msnfShW3esQV3byVW3vLvFMgxFKU7SEhW6Qcw/iOA402R98EiLUchk
	nce3/9Uv+AUc/0LEkbGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lvAXD-001xQ9-Vy; Mon, 21 Jun 2021 03:23:40 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lvAX9-001xPj-T1
 for linux-nvme@lists.infradead.org; Mon, 21 Jun 2021 03:23:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1624245815; x=1655781815;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=s9i8XTlneHkK8ZcQc+my7qdovwpDIR2zSH1H6SR7/MA=;
 b=o23JzGHkEp+kTD4WZ0as7j7/kYouKNLUlE2phT7UbtRYh91K9X4FJxaF
 lSJqqcAopqtpaNpZ2HciHr3sZBB8qq01IP9UZ86opTzVcwy2Rro7IsikY
 hXGbOp/Gc1cWMWWJbNnAtBpxEJI06C8tVcaMFYPi+RxsquVFsTZwn9ZhY
 5gEneO1UnRzFkXpjMzUw+FYuQMwB6b9pzV6FSontt4G2bUfOTqabpIrum
 1F14FlKI+aIycADkkuLTGcc++4zTJueaSulJO2TcIQTc+VRiXl/i9VBl/
 EBPhVMZetv/5EC0P4JTub8TKKSk8SAMHW2K03utMy1dC3r5/vQC+SmV0D Q==;
IronPort-SDR: qj1XpiU5yrePZDTaMiNjh/5R0p/HWPhuRhor3lEGFzMz236eIojzakl3lNceqwNkmor+Ek/DXX
 7CRLY9W4s/anBwb2C6FVsfAnaGTeCGUyE928Wh0K9iZtM2O+NncRtcVpHRJkOM/zoEgKuSmnbS
 3Qxv7oXXYjj+ZcxE8C4V+sZZqY/Bo3PeeAhMfFTqIlErmAu9KyZL7KwtPGAD9nwn9g/QyOkAhX
 t7JSv6dNxqBSnk5Iq6tcv2qdDk0lqxQMUP4rS0a7qo4VcHwiEN75RKFXscJNICV+8Gqe31Xtoh
 Yu8=
X-IronPort-AV: E=Sophos;i="5.83,288,1616428800"; d="scan'208";a="172446445"
Received: from mail-mw2nam12lp2045.outbound.protection.outlook.com (HELO
 NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.45])
 by ob1.hgst.iphmx.com with ESMTP; 21 Jun 2021 11:23:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mPxX0kHxsDMUbFBWBaN76Welqh//fFbeAQxLZRG2pnjAZ4z7R+KbX6vyRDepfjKlZ0YeO6P7BaRPN3so2B5yn2ch+/TbQqLwwxXuIO/KXr5SgYKNFQeyIfELiVLuq0bfGIkmEPVCb4HBUCc2IQOfJR7R/I/loR8/il6cfGZwy/Hq8d2uSmAG3ULeYpEAZXfygeEZVBSZIdvl6a1xiDVn0tSnhFdgVo3xEidnp+Zg5mZ/T/+K4MW/HvidLGIUnqXm/o0UZIeKesxlPsHkA0KGprPVgaMve7yffy3VzFrgE1pE93vGE5XlyNFdBDgbMkD00/Nid0RWlFCTeDEjPzTfHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A5LIdpu3Ccf/uh8FIaKRS6u7eHklMHElWxi4jh28+yQ=;
 b=GuhUHT8+CCZLqbQf1xUlkZ1ULfFLhSBa+R/xH6ZpmNSFpoO/sHIVi7dRibuWD7mgJ2/rjdVZJ0GMupy/0woOiu6nTcqKWp770qLkrk6YQlUV2A/NI8FJMkt3Juiuz1lJ08OBKrTqzXtNXQ/IWHLJ7VF4t8etQsNM6QGxfRftJ7OwSrayooA2gpisho+B6DYVAPs9yQStA3fiT8JTndd8m7z6g028EJgHI1uQZQRIAS4ifN8H/7rkEogdEn35Fp4RSs2tvRal2Bm9zwQEmWvd344ItqONuswQOdFTnNgf+OR3A1+txqAgPQdlPFSu7KD4nk77aZIyRrG6jrFTttxYlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A5LIdpu3Ccf/uh8FIaKRS6u7eHklMHElWxi4jh28+yQ=;
 b=D3OFpwnkTTGuFWzSqmWlkH39zyP6nJd1KLVFQPAuheOptiFA9s1MO2FtbsFMVLk5MFsm7ZUr5xx/AubuKk2wOo2DMyKNd8u0AR7jszYbn3/1b4kJ7RMzEIBAV6r5m8UvXo9nFRQI9yfvF3x8hVmtpCdnN7sF0I52YQvQegCENH0=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB3784.namprd04.prod.outlook.com (2603:10b6:a02:b2::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Mon, 21 Jun
 2021 03:23:34 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 03:23:34 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
CC: "axboe@fb.com" <axboe@fb.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] remove all blanks in front of goto label
Thread-Topic: [PATCH] remove all blanks in front of goto label
Thread-Index: AQHXZN+Tfv3RtE1rZ02lAUINrHoKJA==
Date: Mon, 21 Jun 2021 03:23:34 +0000
Message-ID: <BYAPR04MB49650E07DD0D902EADE35995860A9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <tencent_B28F4F86583B12ADE15402FA0EBA8CE87806@qq.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d27e529-e8f0-4011-2799-08d93463f393
x-ms-traffictypediagnostic: BYAPR04MB3784:
x-microsoft-antispam-prvs: <BYAPR04MB37840696EB77D7AA5EFDC2EC860A9@BYAPR04MB3784.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:227;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qJv/8uR+8CpOeEGmGn5UT7/rPVZlUhuiUiqEkqGXbFRtuWbHtvLKiVk7QSp/DjlETHUi5n4qJIzgNcuD8t6fHJN0xpBJexwxb5syZnBeNWA4mhjsQivJzQdD4BEA2YwINlujlqm0rfnJB5CtBUbJZR2i0/c16Sly2lH1WrHiX15jIKniC0UASi6oY8yLBCBVpnKvYCzOKHl/EwGEGhoHvd18qvCOphq0nq0tDHLxo85FzHAphMKMBQBVPdv3OIMnXnmW4NzMddub4ujn80l1+DytPmZ5FQpUa0uUt9Thy5y+lENgsNIwf+HVwmQGmeUIDFbULK7NARgiosoTE0vDVLt6QOo9FIuu4vp3CNkZYwNyKdc9uONoyTJWKkf/FO1I3Zkuxral94z+nMRc3KC6QGiSTvSyhum/XC98foOIsRKMhEpORsy3IHLjpCOOsm/FxKX1w/tzIUkkn0yK5VQquknAmlJFoWzEBGizQLQjcmOooGm8LK4a8kC1xgQ8/ALhG+rEPobo4N7xqTNwk9ph+/PE2G1xynlgPmrFdApIp7gG7+N7M2eNVDSnPBfYhZ/C25FFWTsVA5Fv21TPjFBYLGv/J9HapOPCsGBBJtDtRSg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(366004)(396003)(376002)(53546011)(7696005)(6506007)(122000001)(8936002)(83380400001)(33656002)(26005)(186003)(38100700002)(8676002)(71200400001)(5660300002)(478600001)(64756008)(9686003)(66556008)(110136005)(52536014)(316002)(4326008)(55016002)(86362001)(2906002)(54906003)(66946007)(66446008)(76116006)(66476007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dv0qsa8ltRW8wyU5m0qNHGCMIIvQplBH2/wbEM/QOmFCkrwYAz/wDCOLezIa?=
 =?us-ascii?Q?axMgfLzFV/jAhA0BVtQhkgB///dSsFt1S60qud83Oemgy3GLkpxcleniPVp3?=
 =?us-ascii?Q?W70EPxUtnBl1LDsoTKeMW9TYG30+CFE7ro8BO4T7A0jbgZpGqXHpXjXnF+Ax?=
 =?us-ascii?Q?YFFh06ugCYWVYSCa7yOb5NCzBi8PeiZ6ScUT/yDrC3yM2k4GNmdDFBP4oTw2?=
 =?us-ascii?Q?fPXrN/HA1+YSI4RxPOl8Mu/LiLWg7kIoSylFTXoe90IleQNEx/nu2TZOk9X6?=
 =?us-ascii?Q?00mB4E7AXTp0khX4kTDt8Y++BQRHv/rPyZsAnw11rfqH9I3aGIJA7VdxoieB?=
 =?us-ascii?Q?GKPWlh8jmg+dCPkyHZ2Izvp7yR7n6MWh3LdCDpdtLypTpLHxrjDTgE3nRXh/?=
 =?us-ascii?Q?V+ZCZ1Szx3s49BNlFF6H/TfnkH72lEdw0BVwoHRjqpEQ+qfULYTtIJ9aK+WU?=
 =?us-ascii?Q?8B4Br8X+VLzA3pE+KEvqG/YGa2UCnpFUIa2e78QKJzlQknZpKv2f8vfWqqPD?=
 =?us-ascii?Q?M+z6g50Dyzk9uZbb/7r/PRXMvUrMxT/s+3MTn3UNco1l1LJe4/H7mrYMRLYq?=
 =?us-ascii?Q?z6bbHefGQ1pofURc5rgZEopWWt154O3+oFjx4Y1ikgi1biBeyvj4x2mRkX8W?=
 =?us-ascii?Q?3MxSKQNjuZnDWtdCTWQsHJj6rZqQcpVVcunBGZ+oiwegx7JHHkjrMA7Jv/bT?=
 =?us-ascii?Q?yelmxu4jDSI7S//ltUeg0zRjYaUlEg6/vvMdXlTQbIk6ZBaRTuXsiGbXpL5A?=
 =?us-ascii?Q?JgdmDZFGeAtzGUowX3mtVyHPLR56C026uEfKy9o6TXrckBtdZYIgebjZoVBf?=
 =?us-ascii?Q?c2X8E2Eynw9calKCAdQPTH4UMMNIBe/x1KPsHSpTLigMOUHD5bc0VsKRNjSq?=
 =?us-ascii?Q?uNUE6NGy6fbIbdNz10ifKqHLat+uInof1r5bbgMWyr9mHeXqVrn8qGKMQuBb?=
 =?us-ascii?Q?+SPUPsXeBphDjxM2FdPudmEY9XregsO+a+3gjH+tfwSMmdup8qSXRispbhzU?=
 =?us-ascii?Q?Bt11O5a0frU0Al3AatNUB5zCgqHxEOaYRz1rmCNOdRm+Z7/emKuTfXtavjO0?=
 =?us-ascii?Q?Mpy+iXhH6vBLcoVync5skvj+Ncf1+g4pz4524W2cjQhGtxIIP9JS4KaUGRov?=
 =?us-ascii?Q?luajShGCmEAPfqaLJ5HeuHn9Jy3E1RATRYoqLLrZllZfv/G4eLlPcI6myW+l?=
 =?us-ascii?Q?/mjJI9dr8ifrEAmwkFYAsUacYSFwM5XifFMRtt7lNPZXkcYqcuwKnZftLoAS?=
 =?us-ascii?Q?xrUPFi0eelfa0MQX/La0nMh/2PNAyPwvfL2eyIOR3i2inEiSmDNHmOGSh/ey?=
 =?us-ascii?Q?BE0rC5LoC4ZKY+mHDRd7pHNg?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d27e529-e8f0-4011-2799-08d93463f393
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2021 03:23:34.1060 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lcHtn5H63FLqVPnye1A2v7saHdbwNF5EIzo32s8IKNE9HSQzr0xdD0ia7y0Hoq4qTAQFNwGlTI7LdoCUpiAREO9fi6MFKqYfYA6XtGcnrNQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3784
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210620_202335_990411_604530F9 
X-CRM114-Status: GOOD (  16.85  )
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

Keith/Christoph,

On 6/19/21 00:49, Ming.Li wrote:
> There is a format style mistake. Some blanks in front of goto label.
>
> Signed-off-by: Ming.Li <mingli199x@qq.com>
> ---
>  drivers/nvme/host/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index a29b170701fc..bf3deda1561e 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2780,7 +2780,7 @@ static int nvme_dev_map(struct nvme_dev *dev)
>  		goto release;
>  
>  	return 0;
> -  release:
> +release:
>  	pci_release_mem_regions(pdev);
>  	return -ENODEV;
>  }
> -- 2.24.3 (Apple Git-128)

While reviewing this patch I found that on the host side there
are many places where we've spaces before goto labeldefinition,
perhaps following cleanup is useful ?


diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 559637ebda25..03c8201d15b2 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1095,7 +1095,7 @@ int __nvme_submit_sync_cmd(struct request_queue
*q, struct nvme_command *cmd,
                ret = -EINTR;
        else
                ret = nvme_req(req)->status;
- out:
+out:
        blk_mq_free_request(req);
        return ret;
 }
@@ -3997,9 +3997,9 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl)
                                nvme_ns_remove_by_nsid(ctrl, prev);
                }
        }
- out:
+out:
        nvme_remove_invalid_namespaces(ctrl, prev);
- free:
+free:
        kfree(ns_list);
        return ret;
 }
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index d93928d1e5bd..49a9e376251c 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -105,10 +105,10 @@ static int nvme_submit_user_cmd(struct
request_queue *q,
                        ret = -EFAULT;
        }
        kfree(meta);
- out_unmap:
+out_unmap:
        if (bio)
                blk_rq_unmap_user(bio);
- out:
+out:
        blk_mq_free_request(req);
        return ret;
 }
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d3c5086673bc..1519433d541f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2188,7 +2188,7 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
        } while (1);
        adminq->q_db = dev->dbs;
 
- retry:
+retry:
        /* Deregister the admin queue's interrupt */
        pci_free_irq(pdev, 0, adminq);
 
@@ -2279,7 +2279,7 @@ static bool __nvme_disable_io_queues(struct
nvme_dev *dev, u8 opcode)
        int nr_queues = dev->online_queues - 1, sent = 0;
        unsigned long timeout;
 
- retry:
+retry:
        timeout = NVME_ADMIN_TIMEOUT;
        while (nr_queues > 0) {
                if (nvme_delete_queue(&dev->queues[nr_queues], opcode))
@@ -2428,7 +2428,7 @@ static int nvme_pci_enable(struct nvme_dev *dev)
        pci_save_state(pdev);
        return 0;
 
- disable:
+disable:
        pci_disable_device(pdev);
        return result;
 }
@@ -2702,9 +2702,9 @@ static void nvme_reset_work(struct work_struct *work)
        nvme_start_ctrl(&dev->ctrl);
        return;
 
- out_unlock:
+out_unlock:
        mutex_unlock(&dev->shutdown_lock);
- out:
+out:
        if (result)
                dev_warn(dev->ctrl.device,
                         "Removing after probe failure status: %d\n",
result);
@@ -2905,15 +2905,15 @@ static int nvme_probe(struct pci_dev *pdev,
const struct pci_device_id *id)
 
        return 0;
 
- release_mempool:
+release_mempool:
        mempool_destroy(dev->iod_mempool);
- release_pools:
+release_pools:
        nvme_release_prp_pools(dev);
- unmap:
+unmap:
        nvme_dev_unmap(dev);
  put_pci:
        put_device(dev->dev);
- free:
+free:
        kfree(dev->queues);
        kfree(dev);
        return result;


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
