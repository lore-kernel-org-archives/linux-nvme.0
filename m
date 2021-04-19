Return-Path: <SRS0=6U9w=JQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C176C433B4
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Apr 2021 07:32:50 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 469C560FE9
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Apr 2021 07:32:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 469C560FE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Fk+gQcoJJV+mKcD1OaGqk4bWW12Jfm+qFTTIuViaDXg=; b=G7yen8IE0ddqUOqWGepi3CKOB
	C+MJjX7AM2IQceYABSiZJf4lgUwmrw9DVvo1ZWsZYUZxxCw34EgwJKMSHcTkpVsyBXRkCXnmR1kiK
	ltirVD2wpEHZOzuUcWISdXhI5Qpbmx7P1oZ13GkF9Ihiprt9nxkCTdwxxRl7w8XjO2P8d0fTKrAYe
	42fT0Q6i7wcNNbcJFzf0b6upOMZ3Ebjzn0sqqhI8rbP0ACTcKw2uFuPzeOOnp7snm5J8YNLp5t7XT
	9RAUxhSU9rqF+aHHDdsc5NPNJlySJD/7JxAab1L85HHZu9d/mUcuXmwVHTt9OY8cd3oa009EQWZVF
	jYLPS5SVw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lYOOU-009LEE-Qf; Mon, 19 Apr 2021 07:32:30 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYOOS-009LE3-03
 for linux-nvme@desiato.infradead.org; Mon, 19 Apr 2021 07:32:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
 Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-Description;
 bh=05LF7Y7xfaHJs9zxJbTFQz3NwEVUEtpOyr1uoF40J78=; b=zwBEBSAPBsCzsAwzOPsGl8Skbq
 GGml4IgHmfgXtNm1oQ5ASCXhaAUz9TrvKqlIfv8ETiM1b9JcFjfOebIaE4M+BjnAGEdn4mTc6EY+P
 jCpvaC6cw6PR4MpbwbtfL8el326VefdW9b91DeiT+OHPsipjhWIylYPbFm3tO9iPub/jRHNGt8Zon
 qkCriKpKxQ+e4NTjIPq2QGXk3qIFd0cP77kziJGXrCN4nIzeeAnZpoFYj1bJNvB01wTEU3eCGFerJ
 kk2GOh4ERqoUqIm2ZYisIZqYU1MCx9rVuXvRRlLiWxdBal59TBnupEUO3pdjsJuuNndaGQhe3iZik
 /8nhA8ZQ==;
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYOOO-00B8Gk-GD
 for linux-nvme@lists.infradead.org; Mon, 19 Apr 2021 07:32:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1618817544; x=1650353544;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=6HISE/isu4Wowtugz1ayQmAeJ7Ojh+wu6XDsoj6c9EI=;
 b=mH5gBJO18Zf7qJQ07edj+kHiLLrNnAgKo0q4B76U/2vVr8youckflvDm
 36/zvdDyOQyVSB9gmDK8FPipwh1KwMhRg+9wxoYm0usG/MrcJy3UkXXOB
 ZDRuK09ECenc6TwDBG0PHJYOf3rxEQpO467Z5hsy7vn8wnCpGatd/4VWg
 XrN8qckB1JFm92GNWXsWdRS/XJj3tDX0QBh/EYSe2kGqPWAfgSXUhbHRx
 lyOpGOo9Y4mVE1dBd/E1y94zth/MfkGtzdvycge9f63zfiop3DptOqkJ0
 R/0wR3Q0d4v9oXk8dsrQSJBTBqOr2YRdtZDBDJWbvWNGx4tVbfIklUrSZ Q==;
IronPort-SDR: nD3KBljsnmweeUglnckCn8e6GKWxzZp3eP9KXI0UrtzY7A/9W/CSuHF20s3u5wbM0rcVChZqBt
 B1nCGfEDLiPqiPNUs5SmyxnRPPKEtSKq2zaDoArXAhqcHsRAUN1dPL8N1XfBfHHDt0RiFJjPFM
 N9cvs1PmY/EZdeTp6PxJFrcsOtWaKG+MB3geOoQU+BRjYvzijnQsLV9+Em+FPAuVpTaPCSK+In
 cV1Owbz9l1WcW//EFzYN/r/7ctMludk3KIFNtmWzdh4bWFGfm8jRzoDm365+FYIfB2WFmfJK2Z
 8vQ=
X-IronPort-AV: E=Sophos;i="5.82,233,1613404800"; d="scan'208";a="165421467"
Received: from mail-co1nam11lp2172.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.172])
 by ob1.hgst.iphmx.com with ESMTP; 19 Apr 2021 15:32:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n/0u394/Rk5AIx2iNGRpy1eDygZI1JSmHMZRNO4jT82ar3D59vTxmTslpl9u1J1GqZNXe0hxpTk5y1y9IRHDddWOjlPB02yVxwW1bt4AXFR0Ce2m4Zn7nnaBc6GzuzFdAYEvWJQFt37nJpk4ai9NjAHzEOG9H4FH4NUSsLVvcL6m1ZDtyL/9F9P0Y63o/Qb2SMP5fSFN8UoK/qyKryZ+gzDb3F+AxBKQxZ3sv6Pj+76EYQnMuf/6Reuha+aKFJxZQaZVg590SkRC9hqOU4ZiSVfMAe0be2Pb0Aoqq8/GDPSzHCwBvmRVfqTdA4NH6/XoWhbgAHkd2QrhsyPNNic4CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05LF7Y7xfaHJs9zxJbTFQz3NwEVUEtpOyr1uoF40J78=;
 b=GLdn76oD1t/VfBwm2nEC9TAgs1TGHzAbf1oIIAPGN01DF+MzJmNciy6tlxj+aSAkbo6FQhB70v7QpZyWDDe4NlSynaa1epJGwUwuWVWePx7+T86TzrXRRnD9/vWDtYp4Ex1PVd7X6DL424111DTaUhaM6MKkfwFrSOTzbaKCNQdmPZcez4d24vbZv5m7A8tm4aVYqu1efIlaB7o8BtWnAKTE0P8963UgErxsnqsiTZpeGwK8Wiq+Sw1tfQGFNy8P/OqUnWpNhEh82gvQH7cJAx+D7zEbWVsl2YXDfnDlfPLkXwtprDpW6JjnO2dC/hkJKnYUc/s+Xo8tNecsM9FIag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05LF7Y7xfaHJs9zxJbTFQz3NwEVUEtpOyr1uoF40J78=;
 b=MEnKgmMHSIrBb/jw6zFy2toGop+y7ZCEBMXKs4wokO6cxc7ursZgxYVXMBFRl0wvUEYTNwjmtJVe9sfb1tYJSXnbMXir4Xul+ybmkCVGCiHv1yy9AKEj5u5/Ws0uP0SKh+nPxBVkLs2ISbQR2iu8hXDdoJbJL7MapaeXyxTsrqo=
Received: from DM5PR04MB0684.namprd04.prod.outlook.com (2603:10b6:3:f3::20) by
 DM5PR0401MB3509.namprd04.prod.outlook.com (2603:10b6:4:78::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.20; Mon, 19 Apr 2021 07:32:22 +0000
Received: from DM5PR04MB0684.namprd04.prod.outlook.com
 ([fe80::9842:455e:f0d:a1bf]) by DM5PR04MB0684.namprd04.prod.outlook.com
 ([fe80::9842:455e:f0d:a1bf%11]) with mapi id 15.20.4042.024; Mon, 19 Apr 2021
 07:32:22 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Christoph Hellwig <hch@lst.de>
CC: "sagi@grimberg.me" <sagi@grimberg.me>, "kbusch@kernel.org"
 <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme: cleanup nvme_configure_apst
Thread-Topic: [PATCH] nvme: cleanup nvme_configure_apst
Thread-Index: AQHXNO4i2X2DLWp/Zkq2wlfNg6YN6Q==
Date: Mon, 19 Apr 2021 07:32:22 +0000
Message-ID: <YH0yBbPC5aRvF5pV@x1-carbon.lan>
References: <20210409094524.1920584-1-hch@lst.de>
In-Reply-To: <20210409094524.1920584-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.226.244.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 57104edd-4a43-45ef-802b-08d90305457f
x-ms-traffictypediagnostic: DM5PR0401MB3509:
x-microsoft-antispam-prvs: <DM5PR0401MB35096CE82EB49BF2627A6CADF2499@DM5PR0401MB3509.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qB8T4N4tCMcZgS/HIlcfEeI7B3Dg4r32nbynM6abvFWcx6C6g7CGa7i9Y+CzGvCKfnExBfVFOWMLo1qY1MI4b4cdv3lb9jmMMWgtfFzX5X+eFTHqRb8o93GUriadYly7xXFFDonjFxmPekHahie9IHzeuf6ldUWk4kORFJqNc9iGfpiMtpNzFRLGu54kCFahma/u099fhW5D75PEgh3vqVBQpUVjuMjdozf4x5/TJcaiUpK0fwE+IncYGt3B5+uVbsnq/9eCk/VbTUmgrlllhR1kCuXNOvOjxtmEeICXtz5OV3ySCR/AaUFS1Fm37bN6KCLo4VnkXzmYzJ9C4eBgUX16P0YKDh14/Es9OEVNHsvkjjo8hFdjF35/oKj4x1P7XX8BG1YXjZFT/ha0zzVtYxPjkrm1mcqmLleNXSr3RP+uG6qL5eVPMeo5siiFHz9mnCFlCSbA+DlqX0qLmd5rwYAWocQh7SfT8FyOLW3J/Z6nOCFmArwjd66nreA1V5OPTITbn2WRIbaoxreo2ytRBLID8O0X+sopSKWS4CgjK7o3NwtV2Lm1N1rkhU7CTbZXT2MLpJhvXsvFVd1EU/43NgczPXbKPrV9Qn5BfP462g4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR04MB0684.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(366004)(346002)(376002)(8676002)(122000001)(186003)(54906003)(86362001)(91956017)(66476007)(83380400001)(66446008)(71200400001)(76116006)(64756008)(66556008)(66946007)(4326008)(5660300002)(6486002)(26005)(6506007)(2906002)(478600001)(8936002)(316002)(36756003)(6512007)(38100700002)(6916009)(9686003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?mDLDj8dAAaM3k178RCNgtDuiMuQPd5H8szF3koDkoj1GiVQcXG5Z3l/Fw3wd?=
 =?us-ascii?Q?NHRk339aq9ZCktava0xuc/jNYOLE9Y/C1pjt/kA44YNEY4IC/Yy1v1yXtQ86?=
 =?us-ascii?Q?2brGecfq1MlFlWoOBnmEcOxFciEm7pJcYfTmdqq3JmwufxxjaQTuRGQl+TJM?=
 =?us-ascii?Q?YaIpRe+0NilD0BEHNCCDup1YU0lM6co+QaGXq2X8t0JMkqh2tvv5w+Ftn8E/?=
 =?us-ascii?Q?6c9Emq2DUV5/rIS9SRdqcLI3b5gzHb0Bup3KwphGWTjXcth5RSnHJQ2JLDIw?=
 =?us-ascii?Q?Gb5/xoJkRpyaZqkWHHEwR7mae4TBmHgzIqE7Kvtwq/wvAVxP5O4ZYinKMLkQ?=
 =?us-ascii?Q?JliY6Nc7DMJd8XJXTqYKeuS0WjnOBXIv3JHsJVALF3jzfQ36J7SmsTYQ7K6c?=
 =?us-ascii?Q?07MXfh+VNf3I/ZoYQudFTvutd67lj+nVDM7oifSczG+qAD7qepBSo95u5TX9?=
 =?us-ascii?Q?Yy8JsoKPX8fBmaRm5BUFtYW+RgBSSdRGeXRVQXLTxewLLunZRFhaHHEC6MsC?=
 =?us-ascii?Q?H2TGDOIMDn4rpEPybCktXi8Ns3OacnqPZjxdxpCEvGyLbo3wtdsbCD7liSnz?=
 =?us-ascii?Q?Zp1j5GTL64+9TffjO9FAqnCOvXvP8oDiu/3iZLfCmd9EmPoaDOFfk68RMA3E?=
 =?us-ascii?Q?dSwWXYCwD5rq3gHpCQ8u6VtopHQwlB7/S1jdXIWdlxZNYM1cuYtt3T03CKLd?=
 =?us-ascii?Q?UJcgrTJn68Za2xG3dF7hlXHOiZdD/lLW92m2gaLwbLfyHxQ9UNrmP4/xB0vB?=
 =?us-ascii?Q?RCF6wdyLNONisAA/VSdm3caY6KhmgPOTetYI0rmvAunEnW9RT7LoDE3T7505?=
 =?us-ascii?Q?aQHj/TZNk4daQLQ5JEz3E8IoACducifwi8skfU/XRFC6V8uiCR9bhaA7QJXG?=
 =?us-ascii?Q?lztlCazzPcpHRtsEOSPb7p10LV2ZNUNz4j+16J0dYgedK9XcO9TtGD/mEc6O?=
 =?us-ascii?Q?Wxt2TtpT0ayCYXyC0+bedPxO2cyQepEw8QITn1Rg6/xobtBJZjUar2eb5adX?=
 =?us-ascii?Q?/SJzyGlrzhb83wr4ABCV3xFUguOpyvnpo+xuschks1iYSAOF14Nrx7qoUIvq?=
 =?us-ascii?Q?Th8QnbYpMYyQ8oYIrN8DLur+12r/7Qr8UyWN0kkLz5dxr3ohBkNVCYodsQYu?=
 =?us-ascii?Q?Y2QEHdLLReWdHJfyJFVbYgcblHTsP3z1iuULd0J5WyCOPhjfTNfo/kbBF3RS?=
 =?us-ascii?Q?oHdK+FWEehZnIhjv6twN1vqkB5MG1Lw2XbWfg7bTVm5Ss/NF1ahPg56y8u2r?=
 =?us-ascii?Q?jpjenKh3/Xr8s9kWzl/MGRIlpM2S/Yhqzgf8NCVpvj99apG1DowWC/prjMkF?=
 =?us-ascii?Q?pXsc/U24kKKAK1u6OOmOIXOM?=
x-ms-exchange-transport-forked: True
Content-ID: <711F278BC81C8842858BD512F070DAC3@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR04MB0684.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57104edd-4a43-45ef-802b-08d90305457f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2021 07:32:22.3550 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w1P0dcSXKvD47/4dM4+lSZ4OknZXZlhzCzg0htILfUgwfa/Zfn6m/Exks4Dlqp1ED7OkuiYkKoEddZjgli1Zfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0401MB3509
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210419_003224_580944_D18CA24A 
X-CRM114-Status: GOOD (  21.12  )
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

On Fri, Apr 09, 2021 at 11:45:24AM +0200, Christoph Hellwig wrote:
> Remove a level of indentation from the main code implementating the table
> search by using a goto for the APST not supported case.  Also move the
> main comment above the function.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/core.c | 148 ++++++++++++++++++---------------------
>  1 file changed, 69 insertions(+), 79 deletions(-)
> 

(snip)

> +		/*
> +		 * This state is good.  Use it as the APST idle target for
> +		 * higher power states.
> +		 */
> +		transition_ms = total_latency_us + 19;
> +		do_div(transition_ms, 20);
> +		if (transition_ms > (1 << 24) - 1)
> +			transition_ms = (1 << 24) - 1;
> +
> +		target = cpu_to_le64((state << 3) | (transition_ms << 8));
> +		if (max_ps == -1)
> +			max_ps = state;
> +		if (total_latency_us > max_lat_us)
> +			max_lat_us = total_latency_us;
> +	}
>  

First new line.

> -		apste = 1;
>  

Second new line.

> -		if (max_ps == -1) {
> -			dev_dbg(ctrl->device, "APST enabled but no non-operational states are available\n");
> -		} else {
> -			dev_dbg(ctrl->device, "APST enabled: max PS = %d, max round-trip latency = %lluus, table = %*phN\n",
> -				max_ps, max_lat_us, (int)sizeof(*table), table);
> -		}
> -	}
> +	if (max_ps == -1)
> +		dev_dbg(ctrl->device, "APST enabled but no non-operational states are available\n");
> +	else
> +		dev_dbg(ctrl->device, "APST enabled: max PS = %d, max round-trip latency = %lluus, table = %*phN\n",
> +			max_ps, max_lat_us, (int)sizeof(*table), table);
> +	apste = 1;
>  
> +done:
>  	ret = nvme_set_features(ctrl, NVME_FEAT_AUTO_PST, apste,
>  				table, sizeof(*table), NULL);
>  	if (ret)
>  		dev_err(ctrl->device, "failed to set APST feature (%d)\n", ret);
> -
>  	kfree(table);
>  	return ret;
>  }

If you remove the second new line, such that there are not two succeeding
new lines:

Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
