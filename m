Return-Path: <SRS0=KdjD=LS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A17C49EA5
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Jun 2021 22:43:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8DC1613AD
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Jun 2021 22:43:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8DC1613AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=Dp6Pi9XH5dU0Ao/mWb8WUtMeaFlIuWampWoohm2TUZw=; b=b6X60QD34yEsAy
	Xsrgg1yzOSaMkK/9kuDhOCheB82hl7lozrl7LLA3TJLsdHpayR2LzKNqP9sMinZa7zkDspviWxPGs
	LCMYlhNTyeoaPlHNU1u74ikgnHzBOFuIjMy8Y0AcOTlmG7yEzTgyIR7Jr/pUCMxYMeJvRifMMqf/5
	ADMz35+U9iRG8DViJMECYi7jGTG/B0E48NSoaQq4q6rn7q+VYjrK+OVlTeqoXZF4BdX75x/rlUxEH
	qXtiVjXXoSd2v0jkujm6iDHrsd5pFyGgrXIKtOdEkOgWHFlJZ1/TJSv3tsPDcNEvsmKIGuLkKQnUQ
	aSiKx6iH+khveXdqf1HA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lwY3z-00GbvL-QY; Thu, 24 Jun 2021 22:43:11 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lwY3p-00GbuA-5u
 for linux-nvme@lists.infradead.org; Thu, 24 Jun 2021 22:43:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1624574581; x=1656110581;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=rd2jhK5QTSUQVhUXQjdEBy8yCcFxyv0tb2sESxnwnzo=;
 b=oD1+vucyOBRpsPVCTARLq8zsJdR630hwEUkAgwGB60tbdACeg6AU5Mnm
 jcWXA/NjoHPKfJqYFQQQQvsrzYxNkpgrVA5MvT0UmqGHdU4qpizF+W6OJ
 Tx150TnTAS79mktj/R7cuKfchCVWO3QvbyE8y9NFYUHGsMmq2V6Si8UXl
 HiYingbI06mrJnajD03q2tKtjv6co5x2PUoLW6cVOPfHHHMPdN/JzzvPF
 nrSsEwkkItg6wCT2D7twlioHDy6ptXSikpP1+aMk5R0+e0cR3fSCcrjyJ
 kyjL4mZhg7gU7Fw4so0Ca6xmKHqMYK7bD/JENohHun9GLP+LFMIG6JYYF w==;
IronPort-SDR: fxJhTTePfn7NMKe8g13SLLQkiGgdwY7esAWXc8TjrFeTdjrHU5s62yFOT5OsHbFkg3bKro2CfU
 0TCfaAIsisMmeTGLVlfPDPU+KnXdVgVlLvtwutxadF5iZBs0N0Qo8ofAy4aT4FiU1qYhZBDccH
 Rs1eBoKoQkw67jN8cRdQ6aJzse7gzwDCDGVdHTkl/s3MvMUqK8mWh9jUWBjlI3Ai1FHG0eSGVn
 a4Q/TCGa6inLwH8AXIUZzSNblSwB9vJC+OJ273ops9ZihOaQc3QSIZ1NIwrAR4IStmgqGmp0xY
 joQ=
X-IronPort-AV: E=Sophos;i="5.83,297,1616428800"; d="scan'208";a="173413570"
Received: from mail-dm3nam07lp2040.outbound.protection.outlook.com (HELO
 NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.40])
 by ob1.hgst.iphmx.com with ESMTP; 25 Jun 2021 06:42:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E5jzYIAz40DGp+2bus/b5Qz43aoQJ71LmkJ+ckfkI39kaVBdKFyENWIXQXpND5qhJpW/0INDb0ERTFOHI4mILLCRMuSu2Gd7Dh2JUz9Ig06/Nzw1dfR2imfPn/RBMSi6khicckw16qBMQFvC4DyWt0VDq5tEaOp4lLKAmhL8JEzJPXcA11zeFxzgpqr2W0nszi48iGDbNOj8f8R2HirrAtufabQmYvpTG+RQrlDiEpRQs0dufQDGKdGwpibj/pUMVWip+F1ekQvboPEujn6ZsWzM7TjqHOnW9Ax1Nc4iswDOVUCqw4s9J72ZrFk1u1S8tkRq/0DpUQq93SLkYhg52g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8qiaOpkDrNnOUXGSz3PfrOo8TIQ26+av3sfLZywxcjQ=;
 b=kFnHkGaoaUZjR53GSkk29G6p1mLRmVSREa3glUff8bhcmihEKwUU7n1G0IpGrv0HVKLGNaviseaIk9X+A8dEM42EaFh+wZK2EcUoCYfPCUK1A29UahI/DzMy0vjrjq6ZttUZNQksveOo3cbbl68HcKgSUQBFgKM6VsTaDqjCWDtgXFwAL2nL/HhFHA66djTwo65E8XgDs24QQeNnDRR9cLy2eGXONBAoVw8RxNLzUpFtoVQw3+Fm9hW7T4X9W2VGQ5YbWTZUQzhJqKs32/r2ZK3c0usV1Lsa53GkCLssUiQAlV5pUnpIGBTjBHriyVXKsdV+G4G8LlcMGsBWx+Klqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8qiaOpkDrNnOUXGSz3PfrOo8TIQ26+av3sfLZywxcjQ=;
 b=OkvE0c2nmnBSbeOyQQEPhZ4Cm20ShCW2uTlg2MhlTil7wBlsYGetauxCo+BfRN9QiOSTpOsHEpDbh+6eOfhw3zyEWUXKm5m45gMQOEgOkc2k43dho+hWVoyDPevDFc0kVrtJkgF5DrwF9BHLc07bPycChSXaHHB3LQyvnWxruao=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6947.namprd04.prod.outlook.com (2603:10b6:a03:22e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Thu, 24 Jun
 2021 22:42:57 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4264.020; Thu, 24 Jun 2021
 22:42:57 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Casey Chen <cachen@purestorage.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "yzhong@purestorage.com" <yzhong@purestorage.com>, "ashishk@purestorage.com"
 <ashishk@purestorage.com>
Subject: Re: [PATCH 2/2] nvme-pci: Fix UAF introduced by
 nvme_dev_remove_admin()
Thread-Topic: [PATCH 2/2] nvme-pci: Fix UAF introduced by
 nvme_dev_remove_admin()
Thread-Index: AQHXaSP8nJRnBQQ6Sk6LlHRCP9eCMw==
Date: Thu, 24 Jun 2021 22:42:57 +0000
Message-ID: <BYAPR04MB496562CD675B008BEE8AB2B386079@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210624173125.20376-1-cachen@purestorage.com>
 <20210624173125.20376-3-cachen@purestorage.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: purestorage.com; dkim=none (message not signed)
 header.d=none;purestorage.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 58995f15-0d1c-4d7c-2e96-08d9376169a4
x-ms-traffictypediagnostic: BY5PR04MB6947:
x-microsoft-antispam-prvs: <BY5PR04MB69473663019854D330FF620886079@BY5PR04MB6947.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TFdUzqN8wu7/vshN4HquLGFZp6wJ46BVR1/eVkYqkVu0MjESobw+/g4amhyCDJ2Fn4AawlRdrZAHzAMy/b+oAbKX3ANrFVEhXQpQ3HR0HW7tMRH7wzfpmMLZDbJlvMBiLkYNvppGlgA6C/POJWI8xgg86NSEjAtCcBW4RMNK7vFxHge2x0qoWnRcVnkc5p2mRhhXLAuGuZcQWxuQG6/4yLCb4nlqhGyPwnvkOfhDeB0jiYmESIqb/JN3y/kLZgP+ncydqdXff987Gq5mQkvjxV6SIAo/J0df2l12dbDFdJG4EKZyed6hCdXAJV0CpKD6096Zm7NZQPgfgtVAkFzl6+uoo8iozSnAXE5dUPPYBz1sfa2OnwJVZ2grCVxmMXI/X2s1A8t6Fq/aIUkbDpA66BfBKYW2GUX/g3l9IS/2NZg5sYn/skqlqNO//K/QcOhpAtmT2mv80pj6Rp8halPAlUWmexdvfwoBlDqIg7JcM1UIO1YZtENmrDZbBRVdvCd0OS4FepkPZ73R9EamfddN3YAUcG5vnrTX0hzYl6pBm0l/gHJSqFuz0hVgI0Hw5yNpbYg6/UEu6KSsKtBX4BhjUbyN12WKv9rJBX+9rqG0qy8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(366004)(136003)(39860400002)(122000001)(66446008)(38100700002)(66556008)(64756008)(66946007)(66476007)(76116006)(6916009)(6506007)(7696005)(2906002)(55016002)(53546011)(9686003)(8676002)(71200400001)(4326008)(83380400001)(52536014)(5660300002)(478600001)(86362001)(8936002)(186003)(26005)(33656002)(316002)(54906003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jssK8TGvXQFyKEQF/EMNbVyiUiWclo+2YwWgUXU4iJt7zyiWH2DFwyn3uTs9?=
 =?us-ascii?Q?cRjZR/O06ehQlyjtW61WLOJOgr+oCJ8wLbENs/vFZHNx7Geef9Wy3+WvJlkO?=
 =?us-ascii?Q?2iAaP/GfvQ7lXXI0eniWSefPI6ODnRJB0cEKhEqpoC08noA6YcsgSdcVfZX5?=
 =?us-ascii?Q?rC8vAJBvLRN6p0w29CTOEKrsxLQk71X26bmIH8Aua3isgQYw502dBpQKAGHP?=
 =?us-ascii?Q?HEFVK8DdyGw40n2DFteei9ZoUuhKQywamAIIl5oz8t4ubpPyaw4O40+E+UMf?=
 =?us-ascii?Q?K68bzrFLqGjh6ZUXXkny7WjjFbgu2aI2NJHQGYcMhh6O34g7miIUNbHB7mTk?=
 =?us-ascii?Q?LRiWKAVcHnNcsVplmPfu2sJjgTPi9fuCRuCl9dWLx23iNKWNSM1/cUmuE8lE?=
 =?us-ascii?Q?7EKlO/9FzNisiqibRpwOX0Io2Jlk+mepDFKqTEQZb5NDjFkiTNxddFuz34fr?=
 =?us-ascii?Q?427zxZCfCR1A3pmbkvRIW+gdHlStwqlWF+QZ/90gKWkZxJmV7jh+GiZizX8b?=
 =?us-ascii?Q?5LXo7Y8g02SUcMmryewZD7WNDk+HkFJU5svuCwneD0IxPU1B+PgfCHtPZJo2?=
 =?us-ascii?Q?YBMFsVllbjQkY4ldj9Sa3cuce90xYxoZlJvDkM1C53YYXPUGibK2KuZI9NCl?=
 =?us-ascii?Q?qen2YO5VAzucMBRpa7XSf/VrOg4PQ29XtsBcjDIIUznSYd7GMIu9SdwlM7lb?=
 =?us-ascii?Q?lf9IEbBiE0dfs+etroCva9oIQJKnAmtM9A5Q27ecrN0fDalxW8EGkiEcqIVl?=
 =?us-ascii?Q?mA4GAxzh2w5lfM/pWS9R3WJPWYh086RGOrmb1cSPwROgcz54sf4SwC6EoSv7?=
 =?us-ascii?Q?kp1aJo0mJ4NUPJ2lHdiBQ3/Gqw3FEb0gP43YRBj6ZxhWASPpIbB5M0H901mp?=
 =?us-ascii?Q?1JelpjK5Sd2di2D7wn0ff7x+eXimAth8PVYQ0gMiBEsKKXmZwm6Ol/XGzaUY?=
 =?us-ascii?Q?sAUjKupeO3SFZG137Vz/Y/Op4o7jnuDuQrLDoP4UGJdgHwaYugoT8Iv5hO8K?=
 =?us-ascii?Q?k8lBan7rrIr8eZLzjndvDgXxnaIa6ouyVIUsNzzYCTUggca5gy0CgQDuMGa0?=
 =?us-ascii?Q?aYuiwirF2kwLwqUXci6WrbaVzIg2ps+s2PjnvBg9/kmK9PI9UN+4hDgv7Q2h?=
 =?us-ascii?Q?tbnDVN9zhsm5H7R3bRVlRc1VqXAprD+xAJ+S9NL+cIYQCrMt/GZsDGSn/TkR?=
 =?us-ascii?Q?f3+C447wPHKFsqKFVP/K0+qd3zfbFLUICigNcyQJuad7cWzLPEXz/5C7HKCv?=
 =?us-ascii?Q?/imP3hpndRyhKQv6Kmac25/rCAMbpTwZlTZrePCLlyo2lobO1H2yHWyWEPCm?=
 =?us-ascii?Q?tBjaXhlKqPj8WXF4qT83YnJo?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58995f15-0d1c-4d7c-2e96-08d9376169a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2021 22:42:57.2479 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 70z9JFg2vG+0HtIFJd4Ck41YUvrCTKvqkxRwZDdRKAf2dERMlOwHZURCPY89m3MLJcg5B6r2Aanh7XCvOYdqOIO3ob7vhEo/MZJ0zM9i8qU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6947
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210624_154302_237692_0221714B 
X-CRM114-Status: GOOD (  11.67  )
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

On 6/24/21 11:08, Casey Chen wrote:
> nvme_dev_remove_admin() could free admin_q and admin_tagset while
> they are being accessed by nvme_dev_disable(), which could come from
> nvme_remove_dead_ctrl() by nvme_reset_work() during cleanup.
>
> Commit cb4bfda62afa ("nvme-pci: fix hot removal during error handling") was
> to avoid requests being stuck on a removed controller by killing admin queue.
> But the later fix c8e9e9b7646e ("nvme-pci: unquiesce admin queue on shutdown"),
> together with nvme_dev_disable(dev, true) right before nvme_dev_remove_admin()
> could help dispatch requests and fail them early, so we don't need
> nvme_dev_remove_admin() any more.
>
> Fixes: cb4bfda62afa ("nvme-pci: fix hot removal during error handling")

consider following reformatted commit message without any content change :-

nvme_dev_remove_admin() could free admin_q and admin_tagset while
they are being accessed by nvme_dev_disable(), which could come from
nvme_remove_dead_ctrl() by nvme_reset_work() during cleanup.

Commit cb4bfda62afa ("nvme-pci: fix hot removal during error handling")
was to avoid requests being stuck on a removed controller by killing
admin queue. But the later fix c8e9e9b7646e ("nvme-pci: unquiesce
admin queue on shutdown"), together with nvme_dev_disable(dev, true)
right before nvme_dev_remove_admin() could help dispatch requests and
fail them early, so we don't need nvme_dev_remove_admin() any more.
                                                                                                      

Fixes: cb4bfda62afa ("nvme-pci: fix hot removal during error handling")



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
