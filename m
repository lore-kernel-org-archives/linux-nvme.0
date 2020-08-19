Return-Path: <SRS0=A4m9=B5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5BC8C433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 21:50:20 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96FFA207DE
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 21:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Pc6h9Qwi";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hLe/vBWU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="W33oIsse"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96FFA207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=Wv9kyGVpJHAQusEAoIIaDxtFOP5sf1qlYIiyz7HTIEQ=; b=Pc6h9Qwi+EFLRcSOl+qBYz3aG
	4VLOOQ62OFh3rBRGVJXaPFI122sWNuO4VUzYJ9cVwzl7y/l1+S7YSI4nTUJ6mEvKU8lrQXls7gzKN
	WPOfHP+iR06FHApqnUa3MA56FfwFv4VqfnNFZ1oZCeAu+dHqL8XUUEpqUVXwkdRue+99Ikk9EkGuM
	GdR8x17b1Kv4/+yHE7XT1duiWhFTr78R2/Tb7rXnwvIYrvx7ca8efq2t9342bH9tu+dAwC2Lkt6kl
	HJyQ7RvK63HySqfmY/ha+NewuNEJU2d3rBaYvYn+hISD2bGo1qWBiQH0NiMgxqEznnBI62FKbvCBp
	UBcrm/tdA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8VyM-00051h-0n; Wed, 19 Aug 2020 21:50:18 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8VyI-00051D-MT
 for linux-nvme@lists.infradead.org; Wed, 19 Aug 2020 21:50:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597873814; x=1629409814;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=AmRcy5wuyM6Q0iLeM94cgKwv20mwsZv36VywSAT2a8M=;
 b=hLe/vBWU+Iag44fKp79HizVW4fGd6r8DLFZJ0pVsbEsP5WRbOG+z/ApQ
 RoX6NQLxx87anOse/m5/S6SmIrxTdTABoZY6yG9UCO9SvaKy2oFMI0IOM
 oRXqD6iW5WSJn5W2xG6R66uvs9hyCC5p8TvLy7W2MxY1UPJKEvgtg7tKJ
 EJ8PIb8mov7nyxJG24CnwnSYYx51nsOjBVhOFnXO4+9iuVY0aSm5tLAHG
 lLq+uGq2s6TxvsSOlShPaTHw0szdGIKG49eLNt/Nnbipa0ywR7Jk01+IE
 GBP0AwEuSj39F8ECH97QixNKkRM7ZTdkX4pUY1QmNw3NOBup6uRSf1OGe Q==;
IronPort-SDR: 7PhMH6f/Y3w2yQODeY7z/Ia+i+b7U6WnjLWLGYLHlLp4uY7xWqRLjC8wu0tlCM++oU+yscCb9f
 3P4luSGRrG9NKlPRkVq6UC7OOABmfL8eMP3BUgEs45gnUh9AxfZJiYGCwRNrfK302PSQDuU0zV
 cBURxF1vf8LWt87/GNCPCX+/CU7CNJg9NleGx4eHgXZD3iqZM+LbEXZp/V/4Op+Zw6tp75vDcj
 enWjW7knCgQxYQn6Oq7O4rjnctbwS6EEM/0/4kXyWBI2rr6df4ow9/EaZuMZiaxVD5YIjJKzMe
 Z6g=
X-IronPort-AV: E=Sophos;i="5.76,332,1592841600"; d="scan'208";a="254797390"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO
 NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
 by ob1.hgst.iphmx.com with ESMTP; 20 Aug 2020 05:50:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IabmCeqqsTZnN3Kq+833+xyCdW+ia3lrpg5jisZisJMTlDop5N44ZgXmXTUx3SGiMqE4ppNDBBF6uEojhLG8Sehmk/RFelIcOFhgUeNTUQlc4mdIDUXFaF3lewlYNS0QnY3HvhIMZo9QMtFJBlPPwbFJVzcaHmxD248c5Oae2mx81oRaAvLegm5W8kFFSEfnptJRbcx1f7FAnwYoNnVdwWKpU225ZpwhHvAN7l4mTRMsSy892QVV07CyTq88grgMZEYrk4EHcvbJomOR3uzdieUL5L7o5U2oAXFkhxhVwfywgPgpt1icRmYXmMdLIKplT2S2VGrz6JyBckMpB6MzXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wnqzHtX1bpQTv8S+4RiptkKc1jdOH3EUzfyazWcvS+c=;
 b=ARbbRmZ3iESQojdLWiDnRvOWm5scOQkoCnyBJ+u1yVBnbM18calUGsVFE8lxMy1WhOPDqumpMk38+cbei6NqM5lF1AX4g4zkXQJC+0GHk2vDPgTeHlXJVdNKScFM83WSv7Hdpl53B03YXNIigBbzTE3jeM8tzhYjsdEgIHz01LhOCH2ZJSmshiYysHbk+tYMiMkFXAyRWXYV9yVEf6O9vQLHeMwpQhv0Ga+y3scR0qEpWcEQz59R/6dXf9lk/zBY/oHC0tpfEywAnbRWG/X8y8s3040e6TIyyoOItxelA3mIcEqC70BI0l7VtUKyHrlpqHKkCmXANED149kOekeG3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wnqzHtX1bpQTv8S+4RiptkKc1jdOH3EUzfyazWcvS+c=;
 b=W33oIssezixqu7gw4z0+Fv+TZyKnuP8+2KwPncYvfZW7q6ornZ+b3evRZ8vxNbyQeOIQWtRdUQGcVTSls9VQ7ItzL4OqWavzy0oZfs9cXad8SFx/cBEYhRvpfTwX20neFODbatkCv0e9u0OWt4Utb862dtn+N5JkoQ5bxX6cu84=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB6248.namprd04.prod.outlook.com (2603:10b6:a03:f1::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Wed, 19 Aug
 2020 21:50:10 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f%5]) with mapi id 15.20.3283.028; Wed, 19 Aug 2020
 21:50:10 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 3/4] nvme: just check the status code type in
 nvme_is_path_error
Thread-Topic: [PATCH 3/4] nvme: just check the status code type in
 nvme_is_path_error
Thread-Index: AQHWdS+Tpk2vvWXCSESbpDfwtdksIg==
Date: Wed, 19 Aug 2020 21:50:09 +0000
Message-ID: <BYAPR04MB496547725D86BCC44B91B021865D0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200818071132.1136033-1-hch@lst.de>
 <20200818071132.1136033-4-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: eb2aba37-4914-488d-1951-08d84489d839
x-ms-traffictypediagnostic: BYAPR04MB6248:
x-microsoft-antispam-prvs: <BYAPR04MB6248D09112825BF73A3E1E6C865D0@BYAPR04MB6248.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GTNoMxtNbrz8RyQ5vwpCKHGPSRAce7nAXFBmuFjuA0M2sOdtuUEHOccqlJ0DX8ZbTbEKkbMZqg5Sl9XxRvSi2vxz9aDoJQ/48rQZrkXiqQDa9NnijikwG1ou/oESxRRkBwk8g1s2SG5n5TozkG1ti5Bb8qFkuviitbv+O42gTlyHhp8um/YWBMf+zU9boltvBNrzRyZiFQ1oNA197Vdc7KP6qACaKbi4pzw+vPspG8K3un/t3VrV7atKJNOXPm7wW8/YWTNj9SiSC7N9gv+oEAEhdeJN6MgqrzAQIX6zNxLy9sLKAnoLKEl8vZx2YMudEUC3lVXeHrbefFuqIsSuTA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(136003)(346002)(39860400002)(376002)(86362001)(55016002)(110136005)(66476007)(64756008)(66446008)(66556008)(478600001)(316002)(66946007)(76116006)(9686003)(71200400001)(6506007)(8676002)(7696005)(2906002)(8936002)(5660300002)(26005)(4744005)(186003)(33656002)(53546011)(52536014)(4326008)(54906003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: EUV7UO5iS2Sa7aNCTIWe0gkcncoYrUhBt27sr7cd3wV6ORO/U+UR6OQHeEGAWNcEf11lp0NsJNfmGtxKIyvcBFFCUEaFZ94XCxD4PO76sRrObcvpzbXjjDE6t6NZr8tQxa3oqdm4hSLFHNn96k2LE4JWIuqQPXM3lQxko7F8afCFLBFL6DG+8aQO50CMoc9LrFILAlG4h4RpW1ed9sgkAFDb9KkIyOt0yPnwUH06r0ITT6++RG6gBxd/mA8fZFL1PgTimF37j32NfuQiZWfqJEIQnsofgcoUIkmUE2VtqVfutl7wamJTU1Q8+U/o4b7zymrV7zqxNxgG/m5j3NtJNO2JObmV1lqrg0grZuUWOZ19pRSO7sMkpBTHxxTvjEv1pXTYW0rT90cc4iZWykE5POC55/9+KTKVa3cNw1ZGn2flNNN7n7oLEjM+TRJT7AanwfXyeI4I4ABKaVtG36Y4LgnogfD8THofIjv8zWFwRQU4BxwUAr9NNGid1+n2Zt5Qyi8p49mgok9YU6uD/KV32BUBPLcTNuah/TUK6gCXQ208d/CTKniFSwtiTcMoqChUmptur1PMMLGk4k0xPgpeIzZCLgzVBdy6J5awAnYmE+NCcZhxjWCkEKHXNLgh0jtDFdpuKeXX2PqyVE6mseO54g==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb2aba37-4914-488d-1951-08d84489d839
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2020 21:50:09.9465 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MtvQnOTbhku6fylNtQyPoAkWebCfti4CIMxYRsdm3ED41O7MyqfTwQFCKCBG/yz1YUiE3PIXmlFRkhC0W/0u9TAkgv+wNzpeYE6mBJp91jE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6248
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200819_175015_071182_6E60FF27 
X-CRM114-Status: GOOD (  11.63  )
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
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Mike Snitzer <snitzer@redhat.com>, Chao Leng <lengchao@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 8/18/20 00:17, Christoph Hellwig wrote:
> Check the SCT sub-field for a path related status instead of enumerating
> invididual status code.  As of NVMe 1.4 this adds "Internal Path Error"
> and "Controller Pathing Error" to the list, but it also future proofs for
> additional status codes added to the category.
> 
> Suggested-by: Chao Leng<lengchao@huawei.com>
> Signed-off-by: Christoph Hellwig<hch@lst.de>
> Reviewed-by: Mike Snitzer<snitzer@redhat.com>

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
