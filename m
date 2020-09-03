Return-Path: <SRS0=8iPx=CM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D734C433E2
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Sep 2020 19:40:31 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E73620722
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Sep 2020 19:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dLnRr8cg";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dEv0XZIh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="shX/2/JX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E73620722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=TSiTAeaiYIFErH0RNV7UFSQRD7fnwfDNm4UyvNh8gs0=; b=dLnRr8cgCNXRLqrR8y1FJxjoz
	cpSgP3kvRHnsFCIKkC8QvV8nYR/YD+XOAzn+zrRARZip7qbe3PdNz70VMkXVFiJAhwi+CuOq7R53o
	bNTG0az7RMMn3q7Pp+LeC4TnulUI+EbPvhMR/PxxkNEuofS1/t4Bz3JjQdGRSCMaVNgleDkpENY3E
	T5pwp1ZB7aCYuqAv3FrcvaFmle6pHOAs0P/L5BKZutn5+aGVIOvx9IJibQBR2Dtdo8Fn4zWh5Q0J9
	/9xpEvLh9XQXXEdgzhRdi8EWQkOPG11LZ/LQqjVi8fAdtlYPJMBkx0nAdCRySb6ttMqqDjhepD94n
	r01ZrT3fA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kDv5s-0008M9-FI; Thu, 03 Sep 2020 19:40:24 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kDv5p-0008LQ-PM
 for linux-nvme@lists.infradead.org; Thu, 03 Sep 2020 19:40:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1599162057; x=1630698057;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=1Vzd5gcD0+j+BeZs+Qt1L3a9U+pPYkolCOJ6qZ2QMts=;
 b=dEv0XZIhs0rk+udJfgZGbXTJNhywxeIIrY4xEBj8ZiAi9UP3FOcFttVN
 08wjfv+31Z79NKMcCatlWgVLvZDXptdGKpRxvDCpDvjwTo6D/+Wv3kMyZ
 XW5ObCAH8nKj3fvvllgh4fWfVnHrrxXzhqFElSqzry+XS1v2Q2VzR8DyR
 nqeUN0GCYYQ/rPfCY6klZ8Bc071VhHPQNZAv/vmkbidsVEomAeAHygmht
 boe4wd0WmAogpsrDu+XZZtJJ/ILuR1BmtzpxCV0zFiG1BOSG4ygbnjUgS
 LwuGYeIAVs13gjqawmx0MpvoXUSiBlB9a6qd9C6kmyKQXP0/RTwfSkV8l w==;
IronPort-SDR: qhEmOUwRk6C4xkb5UrVylrt5jEtViBVPFGoABzMkpu8xUcemBwZ6fWwaqSFtzi+5xERgr5bUKR
 3DgyTF+xh2zj/K7n0tQ4P9/n8w5J72yp55wLGIrUEtt1AtCNStrd1NYQlrmgzJD4i6NuGvxHL2
 4gtGdDWiLsrouPYWClGZv6NZpGgzcfLfBUeenzBrxa/qCoTcMvKc4gd3IKK7aVN8IXEZc/Z8Ew
 QepsKcN5v1jCfjRJEJpwPd9qRG9onuujhyAm1mfeVbup9S6+uzkqMPvjJ6fvegqczOjMSUd0kk
 Aik=
X-IronPort-AV: E=Sophos;i="5.76,387,1592841600"; d="scan'208";a="249799612"
Received: from mail-mw2nam10lp2107.outbound.protection.outlook.com (HELO
 NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.107])
 by ob1.hgst.iphmx.com with ESMTP; 04 Sep 2020 03:40:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=azh3gCCIA9wPAi1tRpoWqjXxNqNnwNEjxfpfq5IEvyFyf1tVfOucCDaGu/MVQOOWQB+sEetkpp7xf/LwYfxBVGj1fWZwVKmAKhTFJgKcw26jlM5OUnkvQ1lLcR+n3zHFhtQak/7087/fX1t5vn9TbtYYjQzMPjfhQyY9hGMF9zYNY50BeHMAXm5ODl3DzKa8o2R2fOGIk2rmtoKFMHLAEoEAUjz1AfbD17BXnYx9jr1z4IRrZ16TWFQW80DRI20UoM+cfqDC+5rxaEZB1MX1oAGEV32ACi8TzUHXDla6DDXjTFJ280MpPVuSxonxiWXU77b43qJhh5CYRp6XRget0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sTR89Vvy7lliZCI+vYxS0QcUzTvp+FwmCK0pBFLHvzA=;
 b=lsNlbqPg94S9KhpXbyynSMggMMQLBhCDtWaVYah0nxlw85SBAwVnzgEayJbuoQLqbHsHmj+2M7KpCywzDHL8LNzR6N8OlqDh4Kw74pn8DWetebmfhVvl8tCvdFDuAO3w0EZLwnH4xhNIBngMzaSKukezwrC/OP/9m0oXu4eZLB0I4QIeDzr+zh6E7Q58+uXJV60BU/twXmnGn4nv8Hkt1fbpMXhwNKD6rVbSUJzeoe6wW9eEgsdl12V64XaGCy3Uccejy2sdiwZv+ynGcY5eomxupbW0JVgFi2lWjOmmuHIitB5p98ubdpF1evSnqfcQl1fymu6dujo4kXJ+LzDRFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sTR89Vvy7lliZCI+vYxS0QcUzTvp+FwmCK0pBFLHvzA=;
 b=shX/2/JX5QKlKE2YxF5Ffhp1dv7LevOWCaHCFK8LMukPYSe/1pHOM0qnJ2ntAULJb+7URpX09kmbnJ5s7M5ZnYwXKTzpwSvEyODCwIsRVk59QBdHo/nsGdDAjIJjZY7g/iJ9SJKvc356DBImEP4RHQKvH3JD2VDVvKZ6GSHT/JM=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB3958.namprd04.prod.outlook.com (2603:10b6:a02:ae::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Thu, 3 Sep
 2020 19:40:15 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f%5]) with mapi id 15.20.3348.016; Thu, 3 Sep 2020
 19:40:15 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V2 01/12] nvme-core: annotate nvme_alloc_request()
Thread-Topic: [PATCH V2 01/12] nvme-core: annotate nvme_alloc_request()
Thread-Index: AQHWf+XlK4Ms7t96TEedzmnzF2kEwA==
Date: Thu, 3 Sep 2020 19:40:14 +0000
Message-ID: <BYAPR04MB49658D024946E9510B9C71FD862C0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200831222707.35611-1-chaitanya.kulkarni@wdc.com>
 <20200831222707.35611-2-chaitanya.kulkarni@wdc.com>
 <20200903161729.GA25423@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 269bd7dd-fb07-4a19-28be-08d850412e3c
x-ms-traffictypediagnostic: BYAPR04MB3958:
x-microsoft-antispam-prvs: <BYAPR04MB39587C85EAD06EED2B4DE921862C0@BYAPR04MB3958.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6w9KC5EDDCPRCx4jc5bYY/DOwgZxvnzt3WI3pwEvAYJcrDplzusw5UWkOLXSDmwel44220wCvND3V5mJmZ8J+eqgIYzL2qlT4szeBsj13MrUgWA092DsyN+xZmauIkhnOIfhzDgIifs2pGO4iqQD9Zt3/cbot9i8thkvEiXjG74R0uqCXQqsKih+TN+zOMszGBOVhl0TLSj51sOg87/wM3FcKo9BMQbxV/PcSRsiz2MalfEGg/76N2JNtKo3TT3yqfSreD4xD1m0FtVhnKdCOFzgFrvJWNFtvf+MiFVkK+I/Tm6tAPr8rUfmQ9IlEDPR
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(366004)(39860400002)(396003)(6916009)(8936002)(4744005)(9686003)(186003)(83380400001)(26005)(8676002)(55016002)(6506007)(7696005)(52536014)(4326008)(53546011)(2906002)(316002)(33656002)(478600001)(54906003)(76116006)(66556008)(66946007)(5660300002)(71200400001)(86362001)(66446008)(66476007)(64756008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: Nplr5q75gfk2F/MqjRx2vxMdbSO2LfCZZ0K4XARyP8EU+/iLx4Txd59f8kzc7s87IALsTM6uT3v2rfd8osb+hLzELN3ySF8XpO+OebLD5Wo544B/KhitoXztHW5E6i/ikSeboNLtGMEd6MMmrGTFqKncTLzKFWXNqnVUNgigAwUSxaiNKxfZ7ZXovpTmRwHDM9cfDsU8LqgwyTiwoP34OwXpHIdPnkrK1hpyPbERjV8DFayW9j4U/UtJoZA6I5E+XPZxTXfvMgnmC8A2/0Xg53Ad1SdwTCBr/WzJmNXEaY6K9VUXgE/w+z3sNYUBEXhJhuwSBpt6ibSlr5aJbCzPIUaVWEd6NthqzJr6pgB+qmSvXTQBY954wtCeA8aHFXJ99yvf3CN4zEhpvEvlVBRggb0PvemJs7lptwILXcIGoafFFaHUCnm3XDbdtdvzPLzv5GNEdgyhKl0lFto1zRT9WMB21KIrn2mWqBn+DtfEJfJ17zgbG1xLXVRu6/Guxkz359Sz9CbjSB96BQfh29QsiqcHWbCXhmpxr4PRhz/o6Ed0kr0nT6mfSqfJAuZwrQ7aEyI+aQsJZIi/OQcN8Gx3N7vCfaWkKPR4+hyWgfepPEYWskX7dREQuWpTDij3EWxP1/ewZSdzgO+vqgGtIBUVvg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 269bd7dd-fb07-4a19-28be-08d850412e3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2020 19:40:15.0566 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DPim98JXuiBUW3Uq7QbK0qeQyOhrL6KuSrqm4jSZUDlDu3F3scxc3HIRe/jMqRs6Ie2KwC1SEImljtMJIWA/GS3vxVrIcFyKwLSRf49W2K4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3958
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200903_154022_101360_6EC575F5 
X-CRM114-Status: GOOD (  13.07  )
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
Cc: "kbusch@kernel.org" <kbusch@kernel.org>,
 "logang@deltatee.com" <logang@deltatee.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/3/20 09:17, Christoph Hellwig wrote:
> Before we start micro-optimzing this stuff I suspect we might want
> to just split the submit_cmd handlers so that we have a fast path
> and the rest.  We've grown a few too many arguments by now..
> 

Are you referring to any of this :-

1. Split nvmet_passthru_execute_cmd() into
    nvmet_passthru_execute_io_cmd() and
    nvmet_passthru_execute_admin_cmd() handler just like as bdev-ns and
    file-ns. (I don't think so that is what you mean).

OR

2. Split the nvme_alloc_request() into nvme_alloc_request_qid_any() and
    nvme_alloc_request_qid() then call nvme_alloc_request_qid_any() from
    passthru fast path ? (or variation of the same).

OR

Can you please elaborate how you like to have a split ?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
