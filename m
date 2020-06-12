Return-Path: <SRS0=+Z1J=7Z=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266C8C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Jun 2020 20:41:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E80EB207ED
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Jun 2020 20:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bzhvhMSq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZYgI5KaU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="GTydrGMy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E80EB207ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=FC6xNdkLgD/bq+5jkbe+vxd8prqLvK0SWlX86RhgdVc=; b=bzhvhMSqaoBzdr
	KPHT3y02+rWGxSLt93GJjmGD3Eu9tWgYXR7a0TcqUpIiGzTL3bWSADgt7bFmXq79YNp9OteZw4iC2
	8jJdiN+JhBiArW1WMpJxnwjHTktdsBjlMuwHBfWeYCOLqhtxpj0w1Bq517ttK505/d0IvUjiYL02t
	A6WhmhIBFha5yUzq+Wv5m7ibSXOIJguxC4FeLlSqiRM5wV+mnQXuUKuLFd35AZ1JxUUSuomooVkyD
	sqfHYxUNhCMm5LPn2HFZ1wo6or8+2nS73cR4lIGzdll+0EC2cZ+mTjS079m/ccW8tbX1rPS66023R
	DzZgVEjn8eaJSxfSc9eA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jjqU5-0004gP-RE; Fri, 12 Jun 2020 20:41:05 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jjqU2-0004fj-S9
 for linux-nvme@lists.infradead.org; Fri, 12 Jun 2020 20:41:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1591994463; x=1623530463;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=tENjIhC/UFd/7JYXJY6gZ14n5aR7uX+WGgalA1fZdxY=;
 b=ZYgI5KaU/OuXlpzP43nljgeN7GYH527t0zyTdnBMzyc7Xvzx2KCK2zch
 1pnDzTrfA2nTZwhqRPGC19AMdvlsB4tn/GlChb4R7HtRqhZ/7giunVkQp
 TWZOncgM8QvQq0q3l02X/XykfYjRZAgl29CSt4+dbp6nv0eqNEf1tVP7R
 TZuXlzZ7q3Fzh4k3cFXHRL5/NcPmL9GBFZ1eM7lpUKRSTWP/DaZHb0IJP
 gprn5y9+YuLs96vrPK3vxTKE7bEeqDRq8Jth2Fwo/GPftN9hBKbrx0CuN
 uP2/4PNedYJogqxbY9fI6achptX0e4L6yWYo+oygRI7dMKcX0sz+eizWJ Q==;
IronPort-SDR: hXybkEPRycJY8iiZ+KBC4w6C8/KvbD1tWbVUVD3sJLRsoU8hiXXCPH8V0yPLxeL3XRLwBLpyIk
 QYvvFkkFjuJZFek3oTa8b+3jVre7jGpkgCkvPVf1TZizHaiNRnL+bChvkgCSxkeifQzUT/15sb
 VeNDz/mr5dLc5JC0I+B0+lxJM9ciAKDayTsV0tyNUtYk8xZRKOxEhQRwXHBM6b1fYrNuQjeYnH
 /hj/dw+kHFGaEWar8HCn6n/dtqC+dieqyGIjE8WYK4juq231w3HJXK9Ja2rvo5OSwdxSxMJJNY
 sL4=
X-IronPort-AV: E=Sophos;i="5.73,504,1583164800"; d="scan'208";a="144187689"
Received: from mail-bn7nam10lp2100.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.100])
 by ob1.hgst.iphmx.com with ESMTP; 13 Jun 2020 04:40:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hBkYuSJO5jvW7n7WnmeW1bqWmTo0ZEkj4/jnV6M++NrFCjlopifJflKowcO39MKfSy5fd4gO/nwAFWktalsOjbiJwEMxlTGIaXL3tNRx3SUo9ZVKDvLifbxhRaIt0u18elJC30H7kChNqRO372fvEtqlrcuDi0N3p8TD3RS5OZrZYlWRM6OuuLkS625Nv9PUxASpU4vraYVs2aNi1ZGNHdBjiGf8d5QkagFHGDI/bRd8NH+XP+VBOOvZWxRICgb+dQayR5wPfQxPq0sDlqqjAknLrlPg/DcQ8N/ZN9BG0VZvtOn9DHrufnAdHS0fvjb9ZCyb1ted5NyAkQJ4jiJAKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzpCBSBeIR/ZsMzximYk5ODqPTbWgTYo8odcdOgZYL4=;
 b=fBN6LhJSJcw1RLYG7cD8zKnJBPYH3zZNf4yVSmlCMGaOAHwi6vBnIJQbeAgnJ5PmQGHWg9KmoH9Prg0zuJ89l3vrC4tEDMZJB53LdQWy+pejCzyYEoQScm6WrlfrRkxThdP8qbA78wSypFPU4qWxvsUSzBY7XP9kxyq3Z+vwvTho4kQOyTr/KAiFzLXjchrEz8S/KHNEEhYjC4fqVG+c+pohmMPyuaGkaHXjRjvJCtvLRNppy/d4Qnes9K9lhd+cvPjzpWRhjLPI+gGnT7+EBbZtw2YjQF0o9AUcFZyXcpgprQAuPe9yEkALnwmA7PdSs+qhVNN0k/4Lbl5eYLJ2ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzpCBSBeIR/ZsMzximYk5ODqPTbWgTYo8odcdOgZYL4=;
 b=GTydrGMycx2mlG7vBxJff7GAXTKEgV+h4C+UBox+dwSUALYMbv1qn8KIAhkVYAbxCSssYL1iOkSPNhxPMwrGb9MA8qiSRABScWAIOeb3fdoVadpGPqCmHrGqqz9DDtEn6u4JLJFDQRkYG3hTuoiOAI6GHKkagm3mZl/3PHWf+/I=
Received: from BYAPR04MB5656.namprd04.prod.outlook.com (2603:10b6:a03:10b::31)
 by BYAPR04MB4999.namprd04.prod.outlook.com (2603:10b6:a03:51::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.21; Fri, 12 Jun
 2020 20:40:57 +0000
Received: from BYAPR04MB5656.namprd04.prod.outlook.com
 ([fe80::2001:8422:8f69:2a89]) by BYAPR04MB5656.namprd04.prod.outlook.com
 ([fe80::2001:8422:8f69:2a89%2]) with mapi id 15.20.3088.021; Fri, 12 Jun 2020
 20:40:57 +0000
From: Jeffrey Lien <Jeff.Lien@wdc.com>
To: linux-nvme <linux-nvme@lists.infradead.org>, Keith Busch
 <kbusch@kernel.org>
Subject: [nvme-cli] Commit fix apsrintf return check
Thread-Topic: [nvme-cli] Commit fix apsrintf return check
Thread-Index: AdZA+VlzF2is4QufQ8KWbJpmcCqkXA==
Date: Fri, 12 Jun 2020 20:40:57 +0000
Message-ID: <BYAPR04MB565662A7A29C4A0EAE3F64DBEA810@BYAPR04MB5656.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=wdc.com;
x-originating-ip: [199.255.45.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 63dd42be-6305-49bb-8248-08d80f10e904
x-ms-traffictypediagnostic: BYAPR04MB4999:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB49991CE3BCC922DF57066AAEEA810@BYAPR04MB4999.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1051;
x-forefront-prvs: 0432A04947
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xq1oFLqIqOmbIJEUYmtj8vsfgKfjAdpvGG2cXpVERNO+Jr+dIAE5HVoxT8IEGuWf+Xxnc/Lnuddz+JHxObKdZhxeX78biTam8vRs4g/Ck1N8BO2SKtSow+mZus3MqV+81Ogqix8/0uScOWarF0uphoHQ/SmRA2RK6srArFy9df67k85x/yShT87YhGTF435ICZat5+xWeaiiMeQDgoNk2pLEmZAPYSgoh1cuRKL8G2YteU+GY2+hv3JbDKq5haLrNp3HppPmRqwt20WdiQ75UHeXXuY7mP2pPaTCsB8AS4otfzVpNy8aZuid8RXWADbM
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB5656.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39860400002)(136003)(376002)(346002)(366004)(66946007)(52536014)(66556008)(64756008)(110136005)(54906003)(71200400001)(7696005)(33656002)(186003)(26005)(66446008)(316002)(6506007)(5660300002)(86362001)(83380400001)(66476007)(2906002)(8936002)(8676002)(4744005)(76116006)(4326008)(9686003)(55016002)(478600001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 7GPszytDnV3VqhgaO7hr9612Die8SNa8gulVljQFqVH4oWHRfOvMR7u1K0vRqu6nqO/sqDfy1MrexNmytt43dkPubEsxwTlGVcgGBVXJ13hUhIvIyelY+CgdqpV9P7nrJ7HMCTGDJRRAuRLbKf1NG+X8f+U/at/K8QBQIUeFfuzIIGyGOykXLf+yA833OH1QNMKa0d8utnIAXVqZHTysAUmUQpGB/tG3638rbeh3gCX4SJt61DPrsa601TDPqtp3nMbCtIdOX/V70oFhSi/aB+xWl0G7O9mhKNN3+osnBPm46QbtZmMJCS+q0817gyW71hGSP6z6uMYrTawh1vcbZZFwstR2e8gS/nFdT/mYJXRbGdo/Y7K+pFsfQgoNGohzyQRkCxWLJN/L39amFDRVZYEGp5Y582dKUoddiDX0wdKuMh7MF0RRlhwAQgQjEhwVRJj2qeB3u8Ur1mmyonpNBzFyzPadFmlBppLT7PtsxTY=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63dd42be-6305-49bb-8248-08d80f10e904
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2020 20:40:57.5116 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wAx6zRzrlRSytO44QjyMaj5CHIzZEILQEMcmCBzg//WUaAEsJVaEglmiPCXlr5Ho33CpfM0sdjKZUayR5bCcDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4999
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200612_134102_993260_F82C04F3 
X-CRM114-Status: UNSURE (   7.75  )
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
Cc: Randy Bates <randall.bates@wdc.com>,
 Brandon Paupore <Brandon.Paupore@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Keith,
I noticed this commit (f719dfdff59518c2ea75e82695ea0e3e6026a4f7) is only in the 1.11-stable branch and not in the master.  Just wondering if that was intentionally or if it was missed.   I was expecting it in the master branch.  

Jeff Lien
Linux Device Driver Development
Device Host Apps and Drivers
jeff.lien@wdc.com
o: 507-322-2416 (ext. 23-2416)
m: 507-273-9124







_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
