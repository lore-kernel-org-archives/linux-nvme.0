Return-Path: <SRS0=dhBa=DI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7BCC4727E
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Oct 2020 17:43:36 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D06B2054F
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Oct 2020 17:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CegqC4dw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ps2abQ2m";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="TbjtQbgw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D06B2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=OeBgw8RzPXzE64xJZe+2DhZzeSWnf5YysV082Ccy+9A=; b=CegqC4dwuBhXiHyYZ1Ur+zd1q
	7Csv4LtEUZ9PZU2d1/5BqnpOzO8xr54ssFXEPqltxiRGyCRuvstLYLJkJ3R5miWaGEhlzytH8QPrS
	tXrqTEBH3/jgRu2qjLRnuC8AWRFD6roD5zf9UYdy/sjXJ6eYmxi1vZXtf2WJGpIMF+VlwmVFBRy1G
	xxhPHs6qIZirOWzl2UlXsYtbQ96OWTiHoq70P9htCc906Xjp00ZV2Zu9conFxx0lp9kDk/WDAuBLZ
	+1ud4rHXCUylFsU0c0guVZhluV4yqbshbmr4yNMkP/ZQzy9xjvnGMjNjGRbigDwrruGoeSj1NQZQh
	vnYQhGAWQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kO2c8-0004CJ-0l; Thu, 01 Oct 2020 17:43:32 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kO2c5-0004BT-N4
 for linux-nvme@lists.infradead.org; Thu, 01 Oct 2020 17:43:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601574210; x=1633110210;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=d7sTSD/Gvs7l3KR6Dq0AO0Z5vLnAkF5yXq0nC8Sn6P8=;
 b=ps2abQ2moP+j0zNDZAJLqSXmTgQm9kpXkVP7FAOlp+ZyeQNhs+YJYJrh
 hctTt6nxfxpp8Nkzx5jUQJhQn/EDYpAm92knMRyOTd7BegoU8tlBmaeAr
 nb7NUImQUEdeZmjwOSu2WB9/sHPdS5Lenigkjb2T/dVD3O/roU5LqPjoG
 OYyyqF69aVTx9omfVYsIwMIRL9WsiiERdpiCR83ixsDTH2e2mixqTgl4H
 Wp+yC8yHDX02M+5ESZWAqlKoNV/2xaRHX1IwVlrN+5xFxCXyRIYFEa+fG
 WjFjSq5mF6CDKTJmruc3j/CJxQf2XuIeBe69DXU3FSBBpQefVs2SMGvrD g==;
IronPort-SDR: w8fXJh6gsdx+LL4hnqf0xS10YCksXDSWFCQtM5xLkW9Awrt4LbCyWgs5OSWOGPzZjDh3fZAFHC
 Nyy7Bca9QxRmfeyOJMRF9t9qDVKYh9G7pdzvu8iLp1uksYbcSipZBUV5vW9b28sa+tYGyZ/Flk
 gqC8mjoQusxd4xeSX8un/kyXtjgb/PZuJAnQAQcSxq9hebfGEehr3NQID7IJQhSMOyaBqd6JHm
 qxdXcxDDapqOdgPdyg6VD7hyZpzr4belBNCG84Lo9g8oBJOBTelmQPHPXq8UFJpP10d5TPX/4T
 hhc=
X-IronPort-AV: E=Sophos;i="5.77,324,1596470400"; d="scan'208";a="150031962"
Received: from mail-bn8nam11lp2170.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.170])
 by ob1.hgst.iphmx.com with ESMTP; 02 Oct 2020 01:43:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MN8BgNIn+oRYoXIoPMj15XwkOA5B5muFSnJovLWbbHrIzk9F2+M0nrZPzOS13cu8xwHRxJsPmJSYoompiGsZpgQmMFYHd15bDRnrP+L3UUOkkTNpN+LaDU7eXETCWB4SJKpWQTggk/BXM35xp4wArEH2vuz+/h1JF5hKIJh/Nhkt1TvnowUl5SQy72WinB0r6/hFt47YCmE9bBLOUiKcEWkwqLxqmdPm3Q7dre3TLB1HwkDtcSMOi/np7aJWPRwttSQt7nYeFRyXGTrCmetPuyQkYejLVD6Y5/MgWgByRq0z5CWVlKNyEEjinVaQQXCbKvgkHSb/taDpJB+bggjHqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ngPCCzrd/jyRTzlpLBby/ycwzhvWp8+yXknD6CyMweY=;
 b=dO2snYaohsuFz3cq7hNRZcj5E97NTnubsO3pppt3ChMvi9ceswycd2egi0hE2dJN45OG1NgwS6UNP8/fXbciBrcXWM5LNcTFDNdvN1gOiJviP+zmrFDPo2QZOEmGbGa6s3Q2ueoKxN98YCBjYXYutoakQoB0MYZk+/SAa+inRHt7oHqVCLcH5ILqmJfvxSd33p1lAlDuBo36OYb1cy/Rg2d4xmCRtxk4iE29w/x/68VEp/CWtjzS/Qso26ZqtMq562CuH/Yro8C0NY5M59IEMKtcaB97ykWs1AwvMxza30DZeekrKo9BV+NXbcMFZSIS/9Fc9ZisjCzHCGlGstN8qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ngPCCzrd/jyRTzlpLBby/ycwzhvWp8+yXknD6CyMweY=;
 b=TbjtQbgwv561UBShGjiN/znEtBuMUdzCruwnWNlSqzlu3Ia8l9+BJ1xIp7Lbq8c42iVPoKfVFl6s368v5aSY1I7jrCmP5nvAwBDGsrRXz/HWPgoZmfUhB60AYetjjW55TOer+T0MB9XX7de4tnrwXA/16FYniRDUDx+LQ8rf2TE=
Received: from BN6PR04MB0724.namprd04.prod.outlook.com (2603:10b6:404:ce::23)
 by BN7PR04MB4100.namprd04.prod.outlook.com (2603:10b6:406:ce::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.38; Thu, 1 Oct
 2020 17:43:23 +0000
Received: from BN6PR04MB0724.namprd04.prod.outlook.com
 ([fe80::acb1:47a4:73ba:69a7]) by BN6PR04MB0724.namprd04.prod.outlook.com
 ([fe80::acb1:47a4:73ba:69a7%9]) with mapi id 15.20.3433.037; Thu, 1 Oct 2020
 17:43:23 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 17/20] nvme: query namespae identifiers before adding the
 namespace
Thread-Topic: [PATCH 17/20] nvme: query namespae identifiers before adding the
 namespace
Thread-Index: AQHWlw5AkP94OOyeD0CkZEE29Sn+/KmA9CuAgAIKfoCAAAfvgA==
Date: Thu, 1 Oct 2020 17:43:23 +0000
Message-ID: <20201001174321.GA343057@localhost.localdomain>
References: <20200928123502.435373-1-hch@lst.de>
 <20200928123502.435373-18-hch@lst.de>
 <20200930094411.GA189371@localhost.localdomain>
 <20200930100453.GA191465@localhost.localdomain>
 <20201001171457.GA29475@lst.de>
In-Reply-To: <20201001171457.GA29475@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.226.244.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 36ed659a-a972-4dbd-5b27-08d866317e97
x-ms-traffictypediagnostic: BN7PR04MB4100:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR04MB4100A5D1F0257884A48092FAF2300@BN7PR04MB4100.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1060;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +KWNP6oflu1vP6t1yNOHYa1waectgkwNglfG7AiSROBgIhdRV+sQgu7ESNYzZQk2q+tDKTSNLzvPsr52AKubH/fnRgftLImtOEv1mxJPhmn6+wFIKLxYL3+Ju/hsPO9h4pAqNZId3q0cFqWC4Hh5VkUHNs3TV8zZoF1ZNiY+9f69+nQW3OOVu1A7jW1fFzMihjvx0UTmn2+bpLPn54d6MSUOS9qvz1YpnILhAbqZTM0SYQrjAg4dSLBBf5direm+yf74huT09VSocsg21xnz6gYFS84C/lJfeTwiHrW6iZh4C/YiXv3uBffUuwrfd4d1TdeXizYGB8RUTIYuMaep6n4GRKMV0QAZ10dlKrp4X/YXEO1L3wS+3ZGvmajrzBRtxXVPLt2OQFeTuF/DApkuAA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR04MB0724.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(316002)(8676002)(478600001)(8936002)(6916009)(9686003)(6512007)(1076003)(66476007)(64756008)(4326008)(86362001)(71200400001)(186003)(33656002)(6486002)(6506007)(5660300002)(83380400001)(91956017)(66556008)(66446008)(76116006)(66946007)(26005)(54906003)(966005)(83080400001)(2906002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: +SYqwQlFjoQl4J0UIXffg2W464DsI3LuTvUAjlTxDrhE1uv04qOUyWuITgbJs+FcF41chqg5LRcoS3Iyqxk6TvWEsZ+rji8zHDX7n/AAl85YzInni7FcK3OMJtmgdePOTLfb9XaI3gzzKAE+heNVHwTeD750Gjx66QVe+PAn3GR6KVoYdo4rnjMeD1j0GUHuJAgll3ofE2KAf5rnA82yjEW249ZSwQ1JCuBj7GsGDSfhw38wBm/M9/o5qo03rUZBFfE39PbiPy5bB89QUgC6Ky8ctqFGF8RPlylyDMfdw+JOnaFXPkdHMB9Vk+tIyL92A0U+jlZ1sdQfzg4uCrXVzqs0UB5UPbk71H7xoVuktST9uJEFVTZuaf2yWV4LuXKMLgGLxD1wIs51Sjl6cUyqzkL6TV25sEoD95GxHhHs6VKy0jKe8iuwbYk8m1mn4o8PE783rLrfp9pYp420yDuX292L0N65aJZcY5pcb1FZZay4zsiPmHovi4S+sQseHiU1ZULy+NjlhNt7QIxZdJgR/cLV8FFQ5yKLKYnBh3175SbPEgIdB3oek/Qhxdh0B+gwX9j2Xk0vFEbTozCsTWyeYdcDGP9e5DXKbBcRS6Ix213Jy5lLiL/m7Jy+bptz70LySChcZaxDC7Y2xCvlK4JG5g==
Content-ID: <1F5A885B9FE8E943ACC48779BC733273@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR04MB0724.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36ed659a-a972-4dbd-5b27-08d866317e97
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2020 17:43:23.4535 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /CYN63iY9rOGWKG+/i6HtB+qN/j/l5PkOM4/gtHwPUIz1tDm/F8iDP9nDivzjJH/Zl8bJu5FXE3GH5DxIz20HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB4100
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201001_134330_045938_498F0C45 
X-CRM114-Status: GOOD (  28.59  )
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
 Damien Le Moal <Damien.LeMoal@wdc.com>, Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Oct 01, 2020 at 07:14:57PM +0200, Christoph Hellwig wrote:
> On Wed, Sep 30, 2020 at 10:04:54AM +0000, Niklas Cassel wrote:
> > > For the subject of this patch:
> > > s/namespae/namespace
> 
> Fixed and force pushed.
> 
> > > nvme: remove the namespace identifier verification in __nvme_validate_ns
> > > 
> > > None of the identifiers (including the new CSI) can cange over the life
> > > time of a namespace, so don't bother with the extra query here.
> > > "
> > > 
> > > which now seems to have been squashed with this patch.
> > > 
> > > Squashing it is fine, but perhaps you could add that information in this
> > > commit message?
> > 
> > Hm..
> > 
> > I now see that nvme_validate_or_alloc_ns() in v2 of this series does a
> > nvme_identify_ns_descs(), while nvme_validate_or_alloc_ns() in v1 doesnt.
> > 
> > I don't see a change log, but considering this, my suggestion that you
> > the above sentence from the squashed v1 commit no longer makes sense.
> > 
> > What was the reason for this change?
> 
> Where does this this still show up in a change log?

The sentence only exists in the V1 patch series,
not in the V2 patch series. So that is all good.


My questions is rather:

In V1 nvme_validate_or_alloc_ns():
http://git.infradead.org/users/hch/misc.git/blob/refs/heads/nvme-scanning-cleanup:/drivers/nvme/host/core.c#l3975

You will only call nvme_identify_ns_descs() once, and once only per NSID,
in the nvme_alloc_ns() path.
Subsequent calls that goes through the nvme_validate_ns() path will not
call nvme_identify_ns_descs().


In V2 nvme_validate_or_alloc_ns():
http://git.infradead.org/users/hch/misc.git/blob/refs/heads/nvme-scanning-cleanup.2:/drivers/nvme/host/core.c#l3971

You will call nvme_identify_ns_descs() both for the initial nvme_alloc_ns()
path, but then also in each subsequent call, which goes through the
nvme_validate_ns() path.


V1 seems more optimized.
Since we know that none of the identifiers can change during the lifetime
of a namespace, why not do like V1, and only call it in the nvme_alloc_ns()
path?

Something like this:

static void nvme_validate_or_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
{
	...

	ns = nvme_find_get_ns(ctrl, nsid);
	if (ns) {
		nvme_validate_ns(ns, &ids);
		nvme_put_ns(ns);
		return;
	}

	/* only fetch the ns id desc list if we didn't find a ns */
	if (nvme_identify_ns_descs(ctrl, nsid, &ids))
		return;

	switch (ids.csi) {
	...
	}
	...
}


Is there something I'm missing, or why did you change this between V1 and V2?


Kind regards,
Niklas
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
