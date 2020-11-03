Return-Path: <SRS0=7iC9=EJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABCA2C2D0A3
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2020 23:50:58 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 282F2206FB
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2020 23:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sW2MHLQ1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gVt+3LeH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="FC7JVFhL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 282F2206FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=csmtOt/yE0Q7JeoOn3CDI1kRFSrbwQJRm5yWy8HOdfs=; b=sW2MHLQ1ExktnfkP9was1jp5t
	d0TpVrO4xkyg6qLnITDRBwIGpO+mj0ih3jf1WvOvSaWQmwzyQcC9vVe59Asc1B1lk2uww14ja9knY
	es8f0CARgpu8glxLmhKHJ+ZT1pvymfNTbtLuGoxue4AYn/hGopc3tcPVQOltFbY63wEFqFKAmWXr6
	OyU9Gzi5iupvdE6O8CUS5Me3GPWmSQt5TuJ+YABhgIGwT1JpQokAfGQN0FqFsMlSe9OqVQHOHMofh
	cnkgthIAMpwTtivSLH5BcKjX9X3bSbUQtBX/cFR6AQAf/42JRVJIqNDhRhNCSUvF1E+8XfHZMlMka
	QZh7zRR1g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ka64f-0003Oq-7y; Tue, 03 Nov 2020 23:50:49 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ka64b-0003OI-Dp
 for linux-nvme@lists.infradead.org; Tue, 03 Nov 2020 23:50:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604447549; x=1635983549;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=pja4+mFNdkqtfHGuY0tCsvM+VG/zilHzQp/7QTJdxbk=;
 b=gVt+3LeHraTyY7DScBLOzW4iPiktBWDV0PnYI+Bf/fAvQXJFcXTmSjfb
 hYQKX4BPIMBQ+ZudbeeG4EK1Fm/W+tbl7YM+Frz0c5ZzYO/DaHOWNv5wJ
 d9IpoAJLJlMOV/uqFavFp7EHuuOD3DRZb/au4Oq2RG32X0qIBiq0cXV4g
 yyj2gPZ2GDrc/NfsOUWPhEWiUUMCkytTwGk2Q5/TeogDVlyjbPvor0xn1
 /eL9XISy/rl5fENWQZGk6CKKDDQWolNeUF6W1Bx41W/E1xeSqGgj0d+Ag
 YHbN2gS0fbI1uGrwOm8GTElA9lBjeddwdXaUa3u2+zW1xboTzFXiY3C57 A==;
IronPort-SDR: knUQ4zqtVte3Xm2Oe2nnhKtybzE1HxOcYEzKk/x6Qdzb8KToRl8BK9bOFHRe9d+H2yDALW2xTV
 ZDHLokmkrBUdX9rcKk92NNOKNXWpzdRZJPvRyrSQhcLpHRQw+ux79p4OTQeT9LfpQqLtdpSrSc
 iPpqhD+8a8U/1Bk8sjUapW49ojfG8Yd6iBrK2dtqTgN/eBEMFzlbe3GcZ097Hn3QRQL71pIFxe
 8eJLE3rM3wBszDkCFF0GE5H9PzS/WYbb7Ezc5+wxjl56YfwSwXq54DJKWC9Zf0Y19+io5nhKlJ
 51o=
X-IronPort-AV: E=Sophos;i="5.77,449,1596470400"; d="scan'208";a="255277508"
Received: from mail-dm6nam11lp2174.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.174])
 by ob1.hgst.iphmx.com with ESMTP; 04 Nov 2020 07:52:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n/C9V8Y86FB9150ufrW0dSNRZW9UucQ9aSH2n49WFb9RJzg16egJ/UDos7antLB8Ps+K+eOcPaFF24kAxXBvL9WRQoSuWfozXr3s+s8+FNT0w1rsP+3AJd5AM3Q+opn0ZrBYmsvFKhPYNpk29/1HG7vDxdDa0hHSX/sC9ASjDcqYWejpcZrtgIYDvPTZman4f550OtnXx4bMsVr2+apzbwoWIMGIIQCMNdJhjwUD0akKb8Aq0W7/+lf+2dH0dB6r/mxg2czcmLthSW+euD0GKnbfOd7D3nxXjlfYqfzHIx1F34K1h2we3C3Tk36Oyb/TJlULv5vRtLBzsCveEwQLsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z219Zva0uheGjwEB5A4sgv77eDfTvWZOGnuxZ9PedE0=;
 b=Wfbs3irDZMrJ4kl9G72NMgpaIos+o0Duz74SLxtQRaOiCY3U5kfloqoGPSHMuPOGnza3FhIQCy3yY+7/SWoWFwhxaeLe14i8QcYelWAA+eenjyj5Xk2G5DOXdy2niFKRepmBHfk9MVOG3mZHqb5QaCv7qfwUKEWamF1QMYP773+C/Vkz6ze8J41ALSfmniyQ8NPjskBEMHbp5U6GbSUJQyVVKKUnOkBXgRy/v8Kr4x3Yp5JKTfpmJATel8tqMco8dx+ubW71oXq1l5jzmSZ6wBtRKJNdgREe/LsV9MincZjroWFqSs9Jcw8NxzzR6Yayde2FiJ6CcC+ZgUvqtjoCOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z219Zva0uheGjwEB5A4sgv77eDfTvWZOGnuxZ9PedE0=;
 b=FC7JVFhLXzYEMGj7MDy0hG1XQMaZIGMcJvH1q8E/IuaZEHag5M8ISebffDcj01B/m+z0390aOO836V45NK3eTTjrxObpvQdV3NykLCACSPc3MEIFt7WDeyL9n9e6tvZmYlZWKZvTMixtqSa/kiY/rQ1/iB+fA9gs9qazOEr2kag=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7261.namprd04.prod.outlook.com (2603:10b6:a03:294::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Tue, 3 Nov
 2020 23:50:40 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4%7]) with mapi id 15.20.3499.032; Tue, 3 Nov 2020
 23:50:40 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 0/6] nvmet: passthru fixes and improvements
Thread-Topic: [PATCH V3 0/6] nvmet: passthru fixes and improvements
Thread-Index: AQHWqA8MVGF7pRslmUm9QIaVYg/sIg==
Date: Tue, 3 Nov 2020 23:50:40 +0000
Message-ID: <BYAPR04MB4965DD9FF8B6000F20A23E8F86110@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20201022010234.8304-1-chaitanya.kulkarni@wdc.com>
 <20201103183246.GA23697@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0a010d8d-fc0b-4d40-59b9-08d88053454e
x-ms-traffictypediagnostic: SJ0PR04MB7261:
x-microsoft-antispam-prvs: <SJ0PR04MB7261E2DB371AA5CD62451C8E86110@SJ0PR04MB7261.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yNrg3BL+Ww8wjhzXjf+Qq29XkHXiz6IQaWNT6Boi8kYqaCIo254IvvyG14/qR9wN+MdiywzQ9gy3Uowv7WkgpmjumlkByhJRZ0kDQP6S48v4apxvM6Y/Gu1ZEQCLXmmuw7OTn5UYiEAot8kFIXguBrsT1sM42nXc/DDs2VAnbpIEkbxgQyT38UgSCzWeps3qtRB3zW3pKegejpOi9X1Y8cYeZ3D82FHzubnAg1wMWkZp4xehFXtGpt9VT1BO6TKkt8oRTjTa52rLeX5VwY+gdPWCvzE/0w6XqsGM1xtiRG0PPQgyiC6AP5z6RcX4RFj/R/BrBWZBBETKQ9cn5L4JXg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39850400004)(396003)(346002)(366004)(376002)(136003)(2906002)(186003)(4326008)(316002)(558084003)(26005)(8936002)(54906003)(6916009)(55016002)(8676002)(53546011)(66946007)(7696005)(64756008)(478600001)(66446008)(5660300002)(66476007)(66556008)(52536014)(9686003)(33656002)(71200400001)(86362001)(6506007)(76116006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 3qZao1y8kNJOpvZ56T+Dssi3jHGO+sk9Liv5u4DINf7N/bs1UXfXVWKJcRnMWITeL6uftJ8PZHYxsIjBICPqgEa/NCO8gAy7mOsV5CUPtSY8cVcae4pfiyQblNx24agHtLUM1g9yz5o9VVfSc6H73f+FHrhsGn0LORcXkHxFNIN7TUA/rRymFa2fwaC5HTtxLAoqdw/kA9CEfa1CRix3rOVfETAhSGdJkDZtrW3xTabE98Jx2dsgHXzg9A4Qo+B5I8owiIhP8zyV6cweLoIGsc/fRmbZn21nt8t0YnC9L0NmzdDI9CdpE81xiknKDyvQgwgF89wcAFLbKbv9v9njo6oARYE8Yo1NQ68woDlfIgI1+oCbg9DYgimYu6zd5HnRIBUOzjo0c3ivrMI/UpALbJAx896fhgSq4gAPgTRtKIZyappp7D4LuT8wdLPLADlflNU6h6M+RPCJR7acssChh7vbXD5b4Ezn4xl+nACaKl4AsavYWIcsTJRyY/AkiMRhsifKUXou1wVeLqtBAwv1qz2SW/dNWVZbephGh+Wi4H5YzXQWkHBariZwP86LGmOU7PzZp1kpBxHRlvVBt4Se5NY3ApW4Ekc62qX18j6q/Caw+MqkBT+qSOOMg0v1q9yDo4yq8MYsVRWnc70qFp7SPA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a010d8d-fc0b-4d40-59b9-08d88053454e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2020 23:50:40.5699 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TbO3QGIhWBy/Z+mykmv2w5l94NuX/1IVAemB9N9Vu/IEuaiSyHD/VDqpnTis3/2j3C5xKWvTSafQlWWr01b8BXcCFS13AR4hFOgkDMbKu1k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7261
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201103_185046_486171_B26AFE62 
X-CRM114-Status: GOOD (  10.15  )
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
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "logang@deltatee.com" <logang@deltatee.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 11/3/20 10:32, Christoph Hellwig wrote:
> Btw, what is fixed by the series?  It looks like just (useful) cleanups
> to me.
>
No fixes as we did the separate series for that, will remove it.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
