Return-Path: <SRS0=H4mI=XU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68731C432C2
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Sep 2019 21:10:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 264A721D7A
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Sep 2019 21:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aDujqNoY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XlciXwLc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="xaW4yIRo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 264A721D7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ifkx9yjyvO57V2bq+9a7fLFArRf+fLl2rG/XegNqdDE=; b=aDujqNoYJ8ydhe
	glP3cZF5UJBxYvBaLYDpj0S1kOQCnAklueYnEAh1HY5LjdiLWNGHkaTnxN7gNbesSkGid4YPh3ez8
	YhnF++Vmuqyr8pcAnocoT+QMN5v1KKfZDGVku1A9QXwnnqrifvdxJbXw92arMlJGjrDWmGp2gtNQN
	+vSuWNEF2CfP2tMOFmxmH0/9hQoLimbZqHpUetOBTbv/OOZwq6VM740+z1P1aqh8GyTHOlkhFvawH
	CJYIvMLVI2MYF3QsLMRKZ4eftEPkOjSxpVUZn42N7GMf5GaCjN66WNoyk3A591bZ01qmH/F7C1O8b
	lUquZB/0fvzXE/4qWxEA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iDEYC-0000Cr-Bj; Wed, 25 Sep 2019 21:10:16 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iDEY9-0000CU-DF
 for linux-nvme@lists.infradead.org; Wed, 25 Sep 2019 21:10:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1569445813; x=1600981813;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=OsscOBL0dh2aT9deBDfQMmPNejeBMXiMVWPyryKw4ag=;
 b=XlciXwLcnGGCBfeYZ+WsKz0Haws+WWwM0qB5vSd1Qs6w/Hd7EmnXmcRp
 MgyJ6Dy6IQ+j7aNQzq0PPNdXQ8eajoCfHl9PzhMlyTlbjNSi432IMDFFc
 /+jQ8td6yu+UZN0gBnm5jAGmU9i+rXhr6cdTuBk4GXwtQomt1rLNbCd+9
 e0SxFYe9+IlFs7igOXH1EtYjfjrw0XQhECtjwGvASoGR0rFLSYVYWqhey
 it/Q7kUyfU8cdEYkHBEOJ7gCaBdAgng/WXDhKCx8Ink6Up+Ny/8f42Nt/
 AIbfjxG2ozYXqk/ysokPP5RrEiNYGedXsZ5ZACzb66uQzCSHCvpr206KF w==;
IronPort-SDR: 4EwsuH3zakSH44Gz5BxEuMZLbMkI9tZ3AslgDB9KXIsarT1hG/gs2miREfxUj6IpYo9gc7TG1G
 8GtAIaPrJQ5E5S6FuStMOa+wlmR0eMqL8/RjFjK2Mg8sS+9oWUmAY0RGJmi6/TLxZ+WYQH8Vqx
 TY80ahRI3gJ0sQwL3prG6RW69xiFRrsAfvzXB452FEkqlJwO7eT4cEFQ+TVmRUoEJtoad2w1Bd
 sblmtpcD2lwMTjLsmkKoFsX+1OEQIJZfMIrrk1HZGMhUnur4m6k2XlPMForvFmRIrluYBApj2E
 5jA=
X-IronPort-AV: E=Sophos;i="5.64,549,1559491200"; d="scan'208";a="123560284"
Received: from mail-co1nam05lp2057.outbound.protection.outlook.com (HELO
 NAM05-CO1-obe.outbound.protection.outlook.com) ([104.47.48.57])
 by ob1.hgst.iphmx.com with ESMTP; 26 Sep 2019 05:10:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AnhWzx4Ye6XkO67Qwr3iqTjVFIlqC1BsV9DRTNhZAeAtq4fgf4mrtRTkskrMDLLMDvE3Uxn0wI5Dl1i3qAi8tuqVmL5z6ezT5POJWkaT49esBqRTIf7v2eyxuG+hOrxWE5MLuZJmVsJ2XKaxCOF2CKzYS1+Gk0OmJ7AebWZWxq3kM90AF7bQFUJiS0VElHxYoxRM1GsIiURvVCAScKJK6+FJjg+ZW7yjS2VBdfY9Qfy8q/yZ6T7xDpY5FzBFX1UXQgE3V2Z3Ctm4ohcXaqSV/ax167z2RiijQaHoIYZtLKuCba6Y/1ZmAkfUtaPhX03ARV/bCVk01YLzq0QiqS1j7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OsscOBL0dh2aT9deBDfQMmPNejeBMXiMVWPyryKw4ag=;
 b=PS/Ti77djNIHIdo+l+UjlxpOl/3Zbxw8DB55vVuV2z5txGncckv8lWjJ3H2QHFglysLZGNe9IOiPcZFvcvdBSJ3aHFj2M8MaOBB9ngj49ZzXAPr0h0iSC76tFVs94MBR9rEknqiPvVtiAlAdu6mud/beqFPg0TRHWODxuqCtjiANoHtm3G011ZHMTPzidhx6bT9wgAgP4wUI4awb4JKJ0YVgUvr85mLMrBV1h1+VxcStVIJ8hfshrEKoJgbZ2a8FlKnUSVfeTFtJwgs8WFbpzE5JU6lfFqTizMnwiOBoE6GAoG6NfmYDLtxKMnpANfTk3i+wY+RkWQIQ/f7YEUnbNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OsscOBL0dh2aT9deBDfQMmPNejeBMXiMVWPyryKw4ag=;
 b=xaW4yIRowu49CyNjbgeBQMvv0g5vpz63zGlkIFrA8ZRTK09kvn5qYDfGc7zRvToVRyaAfmgUlOwA/Xmb2S1gWKLfZTKbRS+voMqKtYuXrlzio4Gc2Fjs2vX5hGtXeNrliRggppoYK7fznsHznMWsGF18guYKucsAxWgwqEdve2U=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB4662.namprd04.prod.outlook.com (52.135.240.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.18; Wed, 25 Sep 2019 21:10:11 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6169:680:44fc:965d]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6169:680:44fc:965d%6]) with mapi id 15.20.2284.023; Wed, 25 Sep 2019
 21:10:11 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme: Add ctrl attributes for queue_count and sqsize
Thread-Topic: [PATCH] nvme: Add ctrl attributes for queue_count and sqsize
Thread-Index: AQHVcx42QcB+Q1+rHUa0nTp9OJbCmac85P4A
Date: Wed, 25 Sep 2019 21:10:10 +0000
Message-ID: <053b1656-6a9c-7b0f-ed9e-2861f64f67bf@wdc.com>
References: <20190924212208.3637-1-jsmart2021@gmail.com>
In-Reply-To: <20190924212208.3637-1-jsmart2021@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.1.0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ea0b5d21-54f2-4ed1-7242-08d741fcc051
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:BYAPR04MB4662; 
x-ms-traffictypediagnostic: BYAPR04MB4662:
x-microsoft-antispam-prvs: <BYAPR04MB4662A06B9D35C29B3B3C5C1386870@BYAPR04MB4662.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-forefront-prvs: 01713B2841
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(189003)(199004)(476003)(6486002)(7736002)(64756008)(66556008)(6436002)(66476007)(102836004)(5660300002)(53546011)(14444005)(66946007)(99286004)(446003)(76116006)(26005)(76176011)(6116002)(66446008)(2906002)(478600001)(2501003)(65806001)(66066001)(5640700003)(14454004)(86362001)(6246003)(305945005)(31696002)(6506007)(3846002)(486006)(65956001)(71190400001)(71200400001)(31686004)(58126008)(11346002)(81156014)(8676002)(186003)(36756003)(2351001)(81166006)(256004)(8936002)(229853002)(25786009)(6916009)(6512007)(2616005)(316002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB4662;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: e/iqZf+AzXFDOrajlL56EXhDhUheUmKpRwDdsGxXpo+Uls8Sft9ED7jCXQqnvHcVyHobTqUAXZNs7H/EqOtLXJO0yoX6Y3Rhr4DjP0w4OQF/uxvP0Mvs2V4Jy8MRMXLY57T7SdEXEdtZjW3na1WXSV49uu7HxUCyajdopAKoXdMUkZo4C+thZipY2eWr0d5+PHfoGWfZqr7u9l7k5FSyMKMIi8y98lOyGwiPzy8bp0g16N3uqemaxTpF3EMpchAckHP+ToQpSL+3hMPa9ThjveeX9mMROUZlD/lvLKUxIYIyZ55f4pEG5CVCmRnI2VKKXsXM1msiJWHYPuCjQGygmDQ9pvSw/7yQiHMUzn1ihj56RyAFI7n6NXfECq01Qz36KQDfSUDpQjHX/Ksk9pc9citT4L3txJkN5hXwkUwKI7k=
x-ms-exchange-transport-forked: True
Content-ID: <AD3CC2F0BC0FEA47B7A6EE358D8B2FF6@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea0b5d21-54f2-4ed1-7242-08d741fcc051
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2019 21:10:10.8552 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gOylegRRjX6Rt3VYk+5lJeYwrnWA7feY7exjSio0Bnrsg93BYBCFhFvHL1h3Z+FPGtcmWQgyNG8VBVc7OsQOq3dFMFnfMNxFf0QI5d3WbY4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4662
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190925_141013_623793_38F8B3D5 
X-CRM114-Status: GOOD (  17.69  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

On 9/24/19 2:22 PM, James Smart wrote:
> Current controller interrogation requires a lot of guesswork
> on how many io queues were created and what the io sq size is.
> The numbers are dependent upon core/fabric defaults, connect
> arguments, and target responses.
>
> Add sysfs attributes for queue_count and sqsize.
>
> Signed-off-by: James Smart <jsmart2021@gmail.com>
> ---
>   drivers/nvme/host/core.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index e0e2dcbfd05e..b1c24af284ca 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3040,6 +3040,8 @@ static DEVICE_ATTR(field, S_IRUGO, field##_show, NULL);
>   
>   nvme_show_int_function(cntlid);
>   nvme_show_int_function(numa_node);
> +nvme_show_int_function(queue_count);
> +nvme_show_int_function(sqsize);
>   
>   static ssize_t nvme_sysfs_delete(struct device *dev,
>   				struct device_attribute *attr, const char *buf,
> @@ -3120,6 +3122,8 @@ static struct attribute *nvme_dev_attrs[] = {
>   	&dev_attr_address.attr,
>   	&dev_attr_state.attr,
>   	&dev_attr_numa_node.attr,
> +	&dev_attr_queue_count.attr,
> +	&dev_attr_sqsize.attr,
>   	NULL
>   };
>   


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
