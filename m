Return-Path: <SRS0=yPeo=GZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E635C433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Jan 2021 02:58:06 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B332D22C7C
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Jan 2021 02:58:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B332D22C7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=USyapUHOnF/CMVtTKvDapfaq3+6DNBaG2sWMtgow77o=; b=1DpHfpMuNLFg+W8vUp0PUOQeU
	yNBX05Pnwn35YtP22S8OZGWGCTcfDm3+mPwjvG9VjCww6honjMA2h8NnIsF7nyGXR8esjjPvWFXMK
	z+jmN+zeXP10gZHTEfic8AjBeGlHTZBPk4Y/yE5G0yr46hC4VOdG8WwTUCYzr0vhLL/OMPugvDEho
	yBZrK+hDAdql50kAlDWjQxyGJFxDFlvaD1NZord0zMbT2J+V8goS4HWyJZ76uPYUySl2U/Mv9uMGK
	sf0Mq+3zcEfiy+nebJ/yoEm5lnLltTKwb7e7jdunCCJeh2hdxb7sCIWmpLsxbvCvZJOtP4aGK9G3r
	o5sUqv9Cg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l2me3-0008NS-OJ; Fri, 22 Jan 2021 02:57:55 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2me0-0008Mu-KA
 for linux-nvme@lists.infradead.org; Fri, 22 Jan 2021 02:57:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1611284272; x=1642820272;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=QrVx8rF1AYSTxypIfCcrBYB8HzKvPhkbUTVFEBpbzgA=;
 b=SEYOodyNBjnqWaUFzVVBJX8akx+KaK75eEn3rEeCoDas82FJddZNqbgp
 Knpdk1b4shAXIkDx14TGyDiBmV7S7+uvEh9ShbTlg3ntPhdDlL761Z/FO
 rJRHZ482xvwom09bA91LvXg9JWXBXCB+cLVBFsZ7Fow+V5yHao7JC6Kje
 jqowspmeht+QEUFI+72/bkpwvbT+pW7Jzh8eYHoGQY77HuSXETESAElZn
 FefNLw2oE3av6bWTP2NheHQO8b1IQTnRAAVjImowUEQrF+i+HOLo54BDv
 24Ownbyov4EagGsmj4grfipNebzPwvAznjSO/tWagNgKPFp08iYkBXAr8 Q==;
IronPort-SDR: SbeKPWmnZR8qqryxSy6yzhJbkXqz8YwImGcUl2FcJd4fwIVMfxzULgQoUbDrtWjP+59i4X1Zdi
 xjDn3TIMTtEJD3toY/csTixENpHd50bkYGeGM7/yO2Foviv1jbNLF3PHfPlo+EndgqBiidnXPV
 4J2berIr4oxDsmwzjguT1yZdkc/b2Vx84YOvprwZHIgtuvJH/3GCQBjXie9Qty27hcUzvpyxXW
 prMfeeDC+0K+FfIsClQ3aeYVQ6ZE4GDv5ciegf9Av4vG4dOt5JW+4ATjO+I9u5NhjgqUtA62CI
 lZY=
X-IronPort-AV: E=Sophos;i="5.79,365,1602518400"; d="scan'208";a="268381041"
Received: from mail-dm6nam12lp2173.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.173])
 by ob1.hgst.iphmx.com with ESMTP; 22 Jan 2021 10:57:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQs/Pfu0a6QHpP/oCgVXc2xXu5Xf6qPdK1xkBJzELkWllBykGkiJX8LlYxpsLMkOn04ob/dbh02jxdX+pgyekAoz8u83UZRrAPStcnatEP1DZjmIohpwZW8Wz9dFNqliUx8EYM27yDC+pL/b3ntN278tmmn2ZJnkPxT4vw1IRJ/nWNi7mwY0WpO0AsF9a2PUYlu2bVem5pv9KbFO07doZH/VxaIBE8MyYIWoVD97YZjCI1TtvuZKRx9xm9S3HaQXimbIT/kYZnxz7M1sKd3Ag8gIwQtvEEyQUow7mpGJPJY3xtIJVv5/RqC35+nl6TSiexGOAHqXjD5kFme/x2amyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QrVx8rF1AYSTxypIfCcrBYB8HzKvPhkbUTVFEBpbzgA=;
 b=lQppMhwkbVnegGf0zdBdPq+Iq1ZSHd/YTxvBs5t7Bic4RKU5tZYpqagB2s1anWbgyWMdwwExvBnTR7IZaB+T/PxeQ84gDhUltl03fL2Vrqirt9obQMd97MuQGgKcADQt98TVAidYpmsF3mqrAVENqatVDjKouLzpkmU3V5QBIHiPzRqOzSu3eMPopzjwDVw7GNyIraCg5cHxrQgqIfXP313k4gzJKCK/Rrj1zIL5hBEnJCq+Rwml67+IKvaNNxF/bxoeMd1ehYZnb7bharelR3Wa356jFZ232B7LMKFfnSr0NPw0KD2gzgUjrTN/CPwFNwrFil2TPKNRkPlBwPUXug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QrVx8rF1AYSTxypIfCcrBYB8HzKvPhkbUTVFEBpbzgA=;
 b=mKwShRQ/aPrkbfY0QV9w3xU3PIrdlc5wlrSabp+PoeOD0W+as8+6+Tpvjqxjoloua5Y9ixPN/V2OeOKJ4UB1+ZGaTjzjAH3AU1/M9Sbhg4x+fQuyRMlp4OkSL8c1oJXpqv3cTbYSMmMsqDNT9BHmj06RdkwUfwPAp8A7aY7u43E=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (52.135.233.89) by
 BYAPR04MB4518.namprd04.prod.outlook.com (52.135.238.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.12; Fri, 22 Jan 2021 02:57:50 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a%6]) with mapi id 15.20.3742.014; Fri, 22 Jan 2021
 02:57:50 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "chapman6235@comcast.net" <chapman6235@comcast.net>
Subject: Re: Problem with SPCC 256GB NVMe 1.3 drive - refcount_t: underflow;
 use-after-free.
Thread-Topic: Problem with SPCC 256GB NVMe 1.3 drive - refcount_t: underflow; 
 use-after-free.
Thread-Index: AQHW7QO5MtNnJXjl5ka4VClzrgzGFg==
Date: Fri, 22 Jan 2021 02:57:49 +0000
Message-ID: <BYAPR04MB4965404638B4C43DBA577D1686A00@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <f50bc59c-db11-bb44-55be-7b9db1119872@comcast.net>
 <BYAPR04MB49659C0F0F0E11D166B31E0586A40@BYAPR04MB4965.namprd04.prod.outlook.com>
 <a4c75497-d170-1e0f-8608-282231ff3a8e@comcast.net>
 <BYAPR04MB496542BEF594F0380F7D41CF86A20@BYAPR04MB4965.namprd04.prod.outlook.com>
 <df46d7ce-ce70-1f43-0efd-7153761bcff0@comcast.net>
 <20210121124459.GA156577@localhost.localdomain>
 <c48abecf-8e4f-b76a-c751-1a0d239c99b3@comcast.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: comcast.net; dkim=none (message not signed)
 header.d=none;comcast.net; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2600:1700:31ee:290:475:2d41:83ae:3ed5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b9b1e2b3-6013-4fab-d295-08d8be818132
x-ms-traffictypediagnostic: BYAPR04MB4518:
x-microsoft-antispam-prvs: <BYAPR04MB4518B7D895E9340343B2188186A09@BYAPR04MB4518.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7sX4e5VS+mhnUDOzWOSxPQiCXVGffuXzNsFV9crF4925ir+5e6Z/tvXIVfg0d2x/eX1UuI837qjtSkEF3iFDVR6ntBOC4Q8Kmr5V7SiQ3+dPd60uOWlxwTNTwGBS18LDpN8X7r3PERXz9Gig/CMtdTXuK+1zPy3Qz+0ujB8g0THz/PSLWlwXDfXPZT/lh0Q8Lpid59rerX+ZHsgFL4sLV5eWAI6EgLzZu6hIZizDtitlB3UjyE7gmXYCogzHXGUhpJuI2y0sX2joL74kCi65wq4K72hXEULFCuVMB6lkLrpfAr/JQZqAr/9BLOaNPSNl69xHfhkyyyAVDPgO+yWGXi0V2/ijmsHd+vdDfN9574LqpQTe1cE2Cf8x2kGFj8b8qDuB0IMSkJEQNPbQyVNSxQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(136003)(376002)(39860400002)(366004)(33656002)(6916009)(64756008)(66556008)(66446008)(55016002)(2906002)(9686003)(5660300002)(53546011)(52536014)(316002)(186003)(4744005)(6506007)(8936002)(4326008)(8676002)(7696005)(478600001)(66946007)(71200400001)(66476007)(76116006)(86362001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?wH52cdmd0Kk1nCEsdAn8+K9IIsrKyaBEq2vsajdjSxnIviy4wFoKAbcPxHSt?=
 =?us-ascii?Q?NLr4LgdGigdtQsAugjr4mn9LVki5f1hL3DQ0FrUufRDejWTvNvz5RdQzkX79?=
 =?us-ascii?Q?VEl+I4pJzRE6oCAFh96X0fPXW6jImFhZR3Yeo38Bk7GAP9FTTPrv4qe2F6Tr?=
 =?us-ascii?Q?kscZ3xqBFEWDA7aNpWf0GVHUka0DztacnPfMynIimk6rz9jOHBgWY2XWGAHU?=
 =?us-ascii?Q?nJ/9moN578yNgUzqyJfaODTy789IjSraXH0Hn7pFVnG5tbfVQFzYMCh6u58i?=
 =?us-ascii?Q?xa4kPeIbk9Zjuy7Ylm9EaenhfqWG3V7AMw7Km3EreliJwjEI2DQ76rCIaxki?=
 =?us-ascii?Q?CPvM/RsnmOYI2kI2Y9ouCaA3CX10hpN4bR+LmwtDKu74Nk3fNzaVivk0Qpir?=
 =?us-ascii?Q?HRgfZRgTiaSbiqjr9fE8MUiUknlcO6rDWmodhU4IRWlDD59vPKUvs8VnOACf?=
 =?us-ascii?Q?ze27XKZBPJeZvQOzEQ/bll+MCp1np4AY9TCo7uv4yVDeYz4AOrNIK1+Okktw?=
 =?us-ascii?Q?QTSgJbxwVlASdp3c8AkvhDBnM83Q5uOBDX6UY44M31hT+LzmrMOMQjeVcyv7?=
 =?us-ascii?Q?BsnsRO852HF/LwduVJ3VGD/KSz6Pgy6k2fICzGyfqMRpDoSjaDSxHTaPKAAP?=
 =?us-ascii?Q?B0M3Dala2aEgdLAJEnVU72scs1GE1vnpW3UoiVvQ4upJBsQZt+TPPZCaucGU?=
 =?us-ascii?Q?n8fhVxw9bRSh+p/SDQJTCdX6VwPGQkjoZPEgv5DhvDu3/+lcQzZJlARFx22f?=
 =?us-ascii?Q?Cal8uur4bRbZNWQ+kDVoWhFBPggbhlGLQ6iffJ6azSUOk2Lnm5bEqHI6gioo?=
 =?us-ascii?Q?D1N3V7CpDHnsxJ0qchmhYnbbOCVkuthyK6Q7AM9ZL9MxFexPgVkHvPNtqBAy?=
 =?us-ascii?Q?nS0o8wANOembpjw8o5nlsECXHtnKlzgvJ5VSPIha/HSOUADmrYti7iRB30Vi?=
 =?us-ascii?Q?XGjTObeb/pRS5CDK5JYChOZ6VxAuXoA2TSuXixN8cmZYFARhPPkmDKvFMeWF?=
 =?us-ascii?Q?vAuz5dF+8sDIUosYZeAMaKb2vG3kiJsiXMH/n2JfsFQMNEoF01i9ERkemvoy?=
 =?us-ascii?Q?ZbBN4idt?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9b1e2b3-6013-4fab-d295-08d8be818132
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2021 02:57:49.9073 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9SotSNMCRCioqhthuej84OC7QnohKkImpmCA3/iWMXy8oGX74r9y6pLsR1t9HtAypIHBHw0K55a14fPeFVbkxBeFRPqlLZat5IeXRJ+OGu0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4518
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210121_215752_808901_986AA2BE 
X-CRM114-Status: GOOD (  13.57  )
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
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Bradley,

On 1/21/21 6:54 PM, Bradley Chapman wrote:
> I compiled the kernel from the above git tree, rebooted and attempted to 
> mount the filesystem on the NVMe drive. This is what the kernel put into 
> the dmesg when I attempted to list the contents of the filesystem root, 
> create an inode for a zero-byte file and then unmount the filesystem.
>
> Brad
Did you get a chance to see my response to your previous email ?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
