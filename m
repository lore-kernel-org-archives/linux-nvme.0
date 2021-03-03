Return-Path: <SRS0=nBdQ=IC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F455C433DB
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 01:41:55 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF63F65062
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 01:41:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF63F65062
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=kVhklRcRpddRwx+Z8JWPNpt8DBt+ESBkY/lMjBA2OqQ=; b=VIUWiSDDGCVpyngd8npWivnu7
	oOpCD5fXqYkpR1RneVHv5gSUzU5u3GqCenBLytmB1iZ3WbfI7pTHgpHa7JF2Px4w3BbqTBrIsD4vC
	zJkwArek47eTImyXOYsQC+DP2dLyxU2xCIup/8zr+Yl4VYak2sB3NYTNE/qEHmPjPUyhuoKe4lPUM
	wiLoYqQ0rXBKJ2wBYbLw5vefILffLgOVMaEuVedu9ow0zU26hAorXLKE1K+m21wAtKjdqMTsIvjSN
	uo0lWNT4Fd+3nCdkkvctNoWW0ggEA3rmXxe3cjsgSjlred6wSQZycaC1B8houKqhFUGmcZF+b41Vb
	0YrqyEaEQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lHczi-007Mfj-W6; Thu, 04 Mar 2021 01:41:39 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHZ0U-006ahN-4T
 for linux-nvme@desiato.infradead.org; Wed, 03 Mar 2021 21:26:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:References:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:
 Content-ID:Content-Description:In-Reply-To;
 bh=fQDYqQHl7uLPABSzraBkt8orJKbRZN/CF+2Unw7QIMU=; b=F0AHoB034a3W4s9q5A9fl6MBpy
 Ptwzyaa7dMmYvFhFdLKGzIMfbRe8fUywAHpJ0rfF9QvKGKa9M5tdv+V0Swxs7WkReIHqTfhQXJ0w8
 J8tUNAh5hyFlu5pFCIT7HLIbldbZ71kF49kVhci7QCrSu6qupFQJS6HbrKttd9F2STQq12KSh33ex
 T10R53TRh6DWzypqz/irZQhGFd6UFK+FZLGciAuibCD3f4PCunTfNEGBvxAOYZEJaPVAB61o6KFBO
 KZT8dBkk8HJE9irTvizrSFInD6LRruZAasjbi94FYkVqsNdrZLaoqWIZyhd3QH/Z6qzoifCv6nveU
 iYczfBrQ==;
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by casper.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHZ0O-004G6J-G1
 for linux-nvme@lists.infradead.org; Wed, 03 Mar 2021 21:26:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1614806764; x=1646342764;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=fQDYqQHl7uLPABSzraBkt8orJKbRZN/CF+2Unw7QIMU=;
 b=CQJhsly2F9lZq8Wy79+AkqXBQ9BGsic0AlUnr7+seXG3XaWAnLFs39TW
 y7n/GJ+RhzeFRmHsIZsjxXOovfOhC/vzVtqnIp4YNGkI31hEj4PWGByx1
 R1R++oZDAHia3xrGlmS8IDD9O7vq3v8PAii++sPlVWTMBiRaazxxSBx3R
 QyF55i86JdCFC1+VTxUJ50jUJbakbGKoLS9g8wzwUyGdTk5+CrSlP5NCi
 i4e0z1kXUvdXx42ayezDkYA9bHDiKGBsK8IMwums2amF/D0vkBHsmHvPd
 K5y4n4kcoFC0NWYm8Z3hBbEwiDHJaUcIAsDPEglzvuuuigIPichVBst6H g==;
IronPort-SDR: AUnUOaFp2Mk2TBXr8FYr54IRuY2Doii+q3v8azDys/su51xRvm0sE9LZD3xAvtg+puZRsP78Iw
 IOm2vzqg6FG2oCJIga8FvJUuTQg4SQ+j1baJxIwcOqSazo+CkPbXegp7Z2jSU8TVIbnZJ40bM4
 0XVIDCIztlFTxA+ZoIyOEOLFCBrONI/2qn2Ie/i0N0YX5NhqJ1rwFZ6bLnM/CErNqziOZ5/wnZ
 n1ubLm0MAkczZyxygW+oDxaiIQ8M+HfCVJ9yQVRaowWYnMXEhYLu+CBNWmzfYvlfW5ex7LB/ED
 Y5I=
X-IronPort-AV: E=Sophos;i="5.81,220,1610380800"; d="scan'208";a="161276069"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
 by ob1.hgst.iphmx.com with ESMTP; 04 Mar 2021 05:24:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gPr59N+grXKNLcddTxnRiVSwHBERma3bTGi5B1RmrVRaStb/wty5ydwcSMmikoDOoDIhuVSiejEzXa4ZfmsQ+5NhaZ61ANy61ffDO4z5eFCXXKSBtAXHBasLRlLY4Th4nTvNtD+5xnqgekPE+JEHY7X2aWICVQe50m4pBUcu5FqfnZ5oRT1fUEipHj8+ch5gktR+C2fxa2uyvIrice/BShvDxejVrWparMLrBWYRVCjvm0hQP6PahwB4vX0+90stvJ0HAKNQU4aXXhD6tXEsb6mGs6cQRYW10ZimvpS8L+jkqCBrrx/whkGQ3/CGvpIz3dtcOrAtI3pNDjB+3kMCig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQDYqQHl7uLPABSzraBkt8orJKbRZN/CF+2Unw7QIMU=;
 b=Qbkj/eeZRFH92UbwGCrIyZ4z1AS8iC5NEi8/gWSTrQibynADyR8FAvuUUH7SkIijzBvxcihHFqY2x+m6dMiuljxByAfJx2dgQepvOMW6PvBRb0mlEcoqIx5K3XSRlwGAlJLOH7BfyJrdcqhd0pns5+54apOZBBXbQ0cA460X2aYcX+h8BDwTLcvY5bcOY8NomCtG1YbFMuUs+p4lI08g4YFZ+XYt86K0l8kpyqC1sZ5jICxxXP80aa0Nn0hGApM4SYHQV2R8/jHgOK/ZHsH4Pw5DkEjzzG3Vg/Pl2mUQjVJV5fYlZ+IbpI+eBxP9jUFOKmgV0yCUEL+HJGt5/+p6Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQDYqQHl7uLPABSzraBkt8orJKbRZN/CF+2Unw7QIMU=;
 b=yk9oi2qcyy1tLCnatUaYBHtoaHrNeOqHW/ug1fcI5dW1CLEC6ksXnEDNBhni0jTyR1WnCaSb5qgcsmz7YnvMsWTRj2pIQ1rrZpUNahPPLvqwfZEz+4n6Na+k4EgB+xtXGN1m2TvsBgjcWez5dlARHsDQIAE9yitGbQE2CWXfZ64=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4663.namprd04.prod.outlook.com (2603:10b6:a03:58::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.28; Wed, 3 Mar
 2021 21:24:58 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3890.029; Wed, 3 Mar 2021
 21:24:58 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 2/3] nvme: merge nvme_keep_alive into nvme_keep_alive_work
Thread-Topic: [PATCH 2/3] nvme: merge nvme_keep_alive into nvme_keep_alive_work
Thread-Index: AQHXEGGQm8TfA0lBxk2A4ZMRRw7cpw==
Date: Wed, 3 Mar 2021 21:24:58 +0000
Message-ID: <BYAPR04MB4965CFBD8C49A1DECFA1226F86989@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210303125304.1200789-1-hch@lst.de>
 <20210303125304.1200789-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ac7b820e-6500-49a1-1b9a-08d8de8acc67
x-ms-traffictypediagnostic: BYAPR04MB4663:
x-microsoft-antispam-prvs: <BYAPR04MB466304C44860E101C4F29CA186989@BYAPR04MB4663.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 60Nnjt1OrotpRX1sIbOXDjBieXZPrdIbQGwjwcKW7WZl3MbXhhfJSFwGc9vTlqF5Tu82wQQ6dH9J6Z3pEg+bS+soHVI9OQeje0gfNTnnGo9Qwm13bAmfHSEx3N/wDlIpnMGdi1f3CDeRmFTbiKiF7o1anPj7U4PZPTjYYzJwPMSZdKfW/PuNjVJh+dF+yYG/hb7yfLJBLdXxKoqZo228Wd6nXKRFnJTVpGJNh1XWI0v/csUk+GhX0HAei73Y6/6ygKzkJuWftQsUokGZA8TIWoMcH2vV0az6dvXFsDkFYCVrc0LuKmizu0Qb9aJ4Hkex14fHl+hAraWaWjBSxtK7HdB63F2g80BeGoDMP9NBtZcXWDVkRkulbTt2hY+GlyFE/jehNGvy1mtr+V845xHmKzXx3mMDKQkhHj+zTDXtiK/YNvyhf3PERW+nalnUgVNmrTzNEmjDbRd2ifkVNQSweCHeVP6m5/wyNzaKnLIXOuN8QDMdbNt9Lq5MsvgIwRK271R4wjhIcSS8kzQXSjcVKw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(396003)(136003)(376002)(346002)(66476007)(66446008)(71200400001)(110136005)(66556008)(316002)(66946007)(33656002)(64756008)(186003)(53546011)(6506007)(9686003)(8936002)(86362001)(76116006)(54906003)(55016002)(7696005)(91956017)(558084003)(26005)(2906002)(4326008)(8676002)(5660300002)(478600001)(52536014);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?qxUETd8GNTr21Lwi9QawiyoDOo+fYkMs+KMy6afhOjIa5JEJT6ZL9b0S6Y6G?=
 =?us-ascii?Q?ZHMAGhXY3yJCSC2JB2w0GjCrvzbBOe9REPCE1vUFMPgMQJRboDeUIdPGcH+N?=
 =?us-ascii?Q?rHVJgEJ5ojFsSOzXTpl1E+K28PU8izv1V+3EOWPoOvEOT/94Yf+Bgw2u671s?=
 =?us-ascii?Q?+5J42FbZO0uOSxDXsdT8hUVER8KUMkSlWaFTKrdFfG3jTSroLMC+3SzYJGnz?=
 =?us-ascii?Q?DjeJEA0RIADB7WIibZ2ntCWwrwdf7CYps6keR/zI8/+ng535WCpZA9LlexHC?=
 =?us-ascii?Q?TvKRu9MklS9R3Ms2g+wFt+AA3xtuqqmWJfMHLD1FAs8DthI1O6kH4NHi/jy/?=
 =?us-ascii?Q?QNt5OV2tO9jwbrizzbqw7vwd+lVoq9YcRwhs5RQqSiRBDn2nHu7qkqcGkfIi?=
 =?us-ascii?Q?tyCnZ0jwN7Ut0ncNVLr2rYkIxj3GeAYevmGJeLAwSjmck6xiWvWRKIAy0aA7?=
 =?us-ascii?Q?55a9QNba43n9WqAwNfjtx6UaX94HHyJiB5580/VUvHLWUfkWyJB8kEsJ1/AM?=
 =?us-ascii?Q?o6cFAO4vpam0HGz13J3UF0LQEyIbNF/OHwBrW46zHyFtVJU+IQmxKU3vzW6x?=
 =?us-ascii?Q?MzkLaQhCfeb/kd5gsJjnAYu7/kqpxNkSefLxQLXcravHUzGTPjtgbPQpdrYR?=
 =?us-ascii?Q?u3eWVWF2H/ersAlfag5D+gnSxl3TuEgTQ7BHQwwF74CGJ+YuXrMmNP4uZi0I?=
 =?us-ascii?Q?0gPhSw8maokzYYaMhjrJ+cF0z91EMJ/d/Frp2+ZFS1mX7Omga90rlekze+1i?=
 =?us-ascii?Q?UoUKmaufSjrdQVl5yMjpSAjY2fBqFU/qIT6RX2glf5nRQm0JOBvXy2Fdt2IX?=
 =?us-ascii?Q?AtSOK5G5JeTU3AgSTxJFR8tveXLb1BycjaU2S8BlYFx4iEHxxFysj7DfH6Ec?=
 =?us-ascii?Q?7L9wHDwJsQ+jGQrZips1nUaRKoDyalG8m4Ar7+oKq7IvwH+5JBUHcGmGW4zp?=
 =?us-ascii?Q?yCNvhP14DcTZz1iCtvQ/vgq6w8daTBbfj2SwZmPUyG2PUJjDSPjn60JN00t9?=
 =?us-ascii?Q?Gk4l4eO2ZWXCWD0hSTQTXckvB3wTiaEl7QNgFhKI3zPSbToGuy73nWAXR44w?=
 =?us-ascii?Q?monsD/pa6HP1YNsvPKc8jAbbCAqUTwxX7tKoVyffgN3f971tXAvASzFlNa+U?=
 =?us-ascii?Q?CBz71+HOhu8wZACeKn5/5EgFnfbHyATgoZ8o6Jt2kw5vJe78zSxSWcQ7Y/VX?=
 =?us-ascii?Q?3Ys8pS+xcvoFcN0s0OU5rh273MNGGYpR535P7bPfGmjpImOjzVgGlypFISHr?=
 =?us-ascii?Q?NYM1od/UDnuXzR87c2ssLqhZaRe6SKJRI5rJbPqZ6LLHo+ugJHldUyIzuvEw?=
 =?us-ascii?Q?0AYa1zvLWSIFvKjb/3JywLcI?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac7b820e-6500-49a1-1b9a-08d8de8acc67
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2021 21:24:58.7778 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m3JfIlp2Vy/FpoTZ68ioLpgRbU0UDekg+FhVAXFHxdtD9kJeDJnzW8ZzY4gH/0ODG7d6yB4hJ96DoAOBS/kaeoH/F/+XTzTZsaTctszUxus=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4663
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210303_212605_394767_4314DE4F 
X-CRM114-Status: UNSURE (   9.57  )
X-CRM114-Notice: Please train this message.
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

On 3/3/21 11:15, Christoph Hellwig wrote:
> Merge nvme_keep_alive into its only caller to prepare for additional
> changes to this code.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
