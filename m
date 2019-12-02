Return-Path: <SRS0=f1uU=ZY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871F3C432C0
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Dec 2019 22:27:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52F0C20848
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Dec 2019 22:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nitEWAEF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ThRhRE2g";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="DC6xNRil"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52F0C20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=ACS7h5M61y4lALCOuejASlWVxx7W7d81JCNJArzFxyU=; b=nitEWAEFchyXA4
	IAW5nFFuPdO466wvPUfKi4/PBH90MFuI3O6axKdfScPlZ3feWh81rEvIgv4lwZZ/mRCVR0Zg8/8BL
	0FTzupG28N/9ZBYjD+egxCFQ0+4I/uK88gMnn3rNdXSNw/LbvKUkk/DoUvewsoXP6EHPVhuhCqTXy
	nmpBpvX4b2y9I5+3/d8XEE05mgd/wwd79LCMmpm9a6rDsGthgmNK9TrD9BW2Y6EmP4Zq7POGGBy/F
	ADl2yC1Z7KbOaJL/P4sMXK9vU4uP1SRMFAJk9i3d0DpB4hGL8ksgO/QAkzkRdk7pdTuB8w4B3boeL
	vhJ370NTBhyzBlJPUWOA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ibu9t-0000ue-3l; Mon, 02 Dec 2019 22:27:09 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ibu9q-0000u9-6j
 for linux-nvme@lists.infradead.org; Mon, 02 Dec 2019 22:27:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1575325626; x=1606861626;
 h=from:to:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=IDKKf4P7kqHJprA1l2AXwdxhYMhdgj4P6C0Xf4jScMM=;
 b=ThRhRE2gQlxXLRspz8gNKm+8/KOWExgg4spoHpzCHiNO0F6XYRIFI20y
 wklvCAS83w7K7xBVroZ2BdD/U2JVlYCeTlUMZ1SSIOSIYPDbqUmLQQqOF
 51WKCIOqMGv+/FG9xr4VWX0auugSGcCwOJeps2AFAMBjQz8SIkU/2AOGy
 PfGUeSFLdSyCcquJSMfpXBTspM2AJE+foktMSTbg5kQa+efbUdaoKNXoh
 7VlK56igpkx8xv77XVSgbxE2ZaooUiQ0TcFGQn4UCrWs0OP8X65oE+5tM
 cr19ynYopKnv3mM8m6bl3Kh4v9gGTLmBwr5cbc9bXi/43hR6sji4GPavz g==;
IronPort-SDR: WZrYNwUdhHuSfLGUpWAPsejNYLSHWYz9b33SXvHwu9U/he2kI+nBaMmclBUFFsujY/NngR3YLD
 XJQOWxoOL+C/3gKSQ/uraCwfH+R2hlXGSQvxCoCqm7lau+5QJv9wjrneVdjKKEPDa4+kO5fqFY
 L7oYd2hyjag6OCq3zV9WkSoZ4U7ES8lke8UC7CYw6w2Tk+VlMzV/P0/ey3zcwmQOFpyYqkju1X
 KaaGcIDwP0HelpEtOcTw7ahaWtgk25WfDdNU0JrR7qo4in7cKR00qcFICg5NjOSm/NdCsohzJb
 VhA=
X-IronPort-AV: E=Sophos;i="5.69,270,1571673600"; d="scan'208";a="231929373"
Received: from mail-sn1nam04lp2059.outbound.protection.outlook.com (HELO
 NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.59])
 by ob1.hgst.iphmx.com with ESMTP; 03 Dec 2019 06:27:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NS/mzrcTWNcKZO7phqpOCdkz/2FiXrxWB5FwBUu4KhTyx8PMBJSfhOu9ojC1pfy877NSjmCAiB9DQIXugjQIk6oaUwZ8TmXBT5cAqA3zu01LMjHYnWJL1y5ES8UCXfphdpqsy1v+I8QmD34bu2BAUlNqC8JS2zS11B5DG0sxZx0n1m7M4lXqriXpaPWRMUjwc3BvlZP66zQVSYv+691nXGTShQk4Omr9xYqIDezfgIafFCZti4JU7h/nk1Bkwki3diiW0515vxdhQ8lBBdRhM3gq3502HQiA2Mpgl0yCZgyFsQykwlgNHksnnts8LQtAEIm+joNQWOF9DqYg9AUB4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NpX+ht3aWQMi0/SztoXwRZliGBApceFQTk6vxOjv6pA=;
 b=DUlhJJx4fJ8DETPTLJ849vhxKnmUZx8vP+ob8J2v9QJf7TSPwjs6cdGRxXZ28dqpUuczOKL5nOj+S6tI/B9fiEOKwpBHM5rmb+nDOcB3cHRvxnJcPtZnAB/RKVylAivUFgJJNAkd7Z1gxVJUlWRbNqxWT1rBdQG/D7u0HQzEEXb+hLABqR1l0vUeLOoB/8+kmpOVV28dAZHkTRgxdkanJy3dOPbIwPalzghao9WoCO87tSeg4UVGA8NihAghUhSwA4kdlPWkqBNhBV+XyyREbRKLSmwJpGOApSz5U3y51uB/Gud/nKpltW2SH8bT5TsFaxiCV2l1m3ZvqEwUoJUOVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NpX+ht3aWQMi0/SztoXwRZliGBApceFQTk6vxOjv6pA=;
 b=DC6xNRilgv3GC/Xw+rz2OAnm6GLESQF9MIi+DRkUlUEjBXzf15jqHkiTn2SpHQI5ByTxXyTkiEM3vtlhyzk1LjG3idyqIYMXjxO8+EdsO9BHrRWl7Bnwd8U+LgOcooNHa08wlyjjbmpyRi8PtkHBNLRvdVyO714VaW2rDO1UkEw=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB4312.namprd04.prod.outlook.com (20.176.251.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.19; Mon, 2 Dec 2019 22:26:59 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6066:cd5d:206:5e04]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6066:cd5d:206:5e04%6]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 22:26:59 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Victor Gladkov <Victor.Gladkov@kioxia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme-fabrics: reject I/O to offline device
Thread-Topic: [PATCH] nvme-fabrics: reject I/O to offline device
Thread-Index: AdWoHEM2hZCp1trGT5CqiIXVszcBJg==
Date: Mon, 2 Dec 2019 22:26:59 +0000
Message-ID: <BYAPR04MB5749196620E479BFCBEBF6B886430@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <2caa40133c444771b706406b928ad88a@kioxia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9e42116f-bcd8-412e-45d9-08d77776bf81
x-ms-traffictypediagnostic: BYAPR04MB4312:
x-microsoft-antispam-prvs: <BYAPR04MB4312003EAD1D1857BB86051186430@BYAPR04MB4312.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 0239D46DB6
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(39860400002)(346002)(396003)(366004)(136003)(376002)(189003)(199004)(53546011)(6506007)(6246003)(316002)(6436002)(76176011)(7696005)(66066001)(8676002)(256004)(229853002)(2906002)(110136005)(71200400001)(71190400001)(52536014)(66446008)(66476007)(66556008)(66946007)(76116006)(8936002)(26005)(102836004)(5660300002)(81166006)(81156014)(186003)(7736002)(305945005)(33656002)(64756008)(478600001)(6116002)(3846002)(9686003)(55016002)(2501003)(74316002)(14454004)(4744005)(25786009)(446003)(86362001)(99286004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB4312;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UKnoEdHHAobWGUyW5sQ1gicIQFu9xoWvwUd4GLTKTg5FN7CKyE5qIZ1Ufr7+g+VOhvlzuLFihSDKsFF/WaeTjrf0NGk2JQSroq/444kdBxbf+vCdTz/VGv4PMZyTO/PwYdL94a1lJg5RpuLDzY1yPbYdzJCgzJOzgNoMukQRTLoUCQQz70FffKKmfq1JNFwSTMazmfeFLvR75xI8OAITo5E3Kl6K1p4g4ooujSY1BY0r/u3Wp5tKcxf0CFkBoifx/108r9YZcuFNXAxG0uK3UGC+IbMKUVqv3rFF6RTa1cVGTiBzz7jeOOuLDssnYqv9FHSH0SjhZKDXEh6myaLRTp+OXzv2h2XfzLbIkML9ZNZwqhF1KWfQqjc19WDTnT0ily6FOP3XzWhbEvZUcyj+i2kUWaOby0y/i2eyDmPBw00fnAKAQxQptrcFRVRhk2Oy
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e42116f-bcd8-412e-45d9-08d77776bf81
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2019 22:26:59.8031 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AVTVy7gGrLw3sVetgvkdomCa89fvXO4JqD6/XwQUsHm4OrKlL3QSGB+yWN6bG1OLVjMY2JGpS6R3HLHvQg6Iy4RgngLA2IBaa2jXz/j1Ta8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4312
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191202_142706_261476_DBD2950E 
X-CRM114-Status: UNSURE (   9.42  )
X-CRM114-Notice: Please train this message.
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
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 12/01/2019 12:14 AM, Victor Gladkov wrote:
> Issue Description:
> Commands get stuck while Host NVMe controller (TCP or RDMA) is in reconnect state.
> NVMe controller enters into reconnect state when it loses connection with the target. It tries to reconnect every 10 seconds (default) until successful reconnection or until reconnect time-out is reached. The default reconnect time out is 10 minutes.
> This behavior is different than ISCSI where Commands during reconnect state returns with the following error: "rejecting I/O to offline device"


The values NVMF_DEF_RECONNECT_DELAY and NVMF_OPT_CTRL_LOSS_TMO are
configurable using :-

  602         { NVMF_OPT_RECONNECT_DELAY,     "reconnect_delay=%d"    },
  603         { NVMF_OPT_CTRL_LOSS_TMO,       "ctrl_loss_tmo=%d"      }, 


Is it possible to get the same behavior with proper combination of above
two values set ?




_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
