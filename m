Return-Path: <SRS0=6u0/=ES=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C7EC2D0A3
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Nov 2020 04:11:54 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99E0420795
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Nov 2020 04:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LsyieYX9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="N43GQubb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="hQZ15t02"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99E0420795
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=Lc5tWs8Jj3j5/ZqcQ7uZuiJ5HVCXVr0Uj5Zz5B7M+1k=; b=LsyieYX9581j4SWIdg5zEyD5o
	ZLa8I6SCG49UkdTj3JJf5TLAzQ3o7UGno3D75JmFTu8zZ750HgWUv6cXU4pXAVsQuTQnL5Sw71FjK
	r//cJACTtltM29t5Ys6fdSKPvh8Lzrn6mTGOfWs2Oxx3wWGG0ielSXFJY9j08aC3PCk7NYUF66uSF
	RAskHf/rwZAfoHX1FPDtwd3BUx7oElRQSd7GRCp107EpTfW544gebwCyPu0huyQhRtoxOcMayHNcy
	VkfJsV8znZuPeh/1q/Mgi2pMVdvhqRaWhxp34+O8LKMlKXLq/SfuVdpt6RPJjTwJilkG4XbH8+iSd
	ZcA7jwQxg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kd3xV-0000vK-A6; Thu, 12 Nov 2020 04:11:41 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kd3xO-0000um-3N
 for linux-nvme@lists.infradead.org; Thu, 12 Nov 2020 04:11:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1605154293; x=1636690293;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=cSdcgSm7o5jbXpnr7qq2MkQXOzlQK8lBg0QBCAA0oZg=;
 b=N43GQubbndoaTsxQnv2LDtkffLvexcYXE52JFxrItDAHgL/3WkCW4+Tj
 5Y5jE6e7b//epWDEGdCQ07dzmuYqcCgkXs0zdtsyP1yMFQ2zaXpRy8mSn
 SBVBXU/z5T26fZs+V4V6t7K6gir/ckp6LgHIInzPQTc2vDrjErJk+siny
 Lg8p3VWeisF6d7bxXdENJOTL6N3niiqVUNNTDrUrmghUqJJV+DPBGg3ep
 W7zGm3HcPfIqo5sRsTHHsRZV+54ibpweQStUHnPZD+G5DPCqQVkiBDVJH
 xLvqLy5wbtTt6MPLf+HJmc+UTDdOs+7zqDGrWXWMC05iUukq8tej6Mcpu Q==;
IronPort-SDR: lXKVATJJ9fVy1AkJlwkvMjXES9z2iPxbz7PlbBAu7ZZW70F3Pm98QjS8JNkrvSlloMQc9ZTLxW
 XiDHJm5JPAvzomrO5tsOWR8/V0wVCOXJdtbjktUm0ICycBHv3yDnlIU9t8GcWhDYsSfJ8SAMa5
 KKulRYPznkV2a9zDnztuS7yqpZzw8kpEbQ3Yeot15xb4FR8vK9Sj8xlDcJtlASv05506LEzDoU
 WbJc4IVj5oe5CR388sl//XZzg0nl86m+fEuxSY0DZc6mut7mkTmeC2n9MbHoLCdd/Nluq9KQM1
 2Os=
X-IronPort-AV: E=Sophos;i="5.77,471,1596470400"; d="scan'208";a="152545168"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
 by ob1.hgst.iphmx.com with ESMTP; 12 Nov 2020 12:11:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zx7OzgnAMvbq6cQ9y2Gxnl4z1SnPaSNxGV9npdAKm1okCy7WogT4rB5E6AtRsMhLVg4o9FxF8CV/Pd0ZCf/th3ELui8Km7tw9n5dhPeuni4e6FVvoyfvoia8LpVfKHkiQMIJ+5bSANsE5BVsmoz0atI0BS2dN9WMchUDZnDJbizEnIQvnkdmImVMcLpjc0viqPAkLAuyGW54I9xyOY+UFsv6vYv1fDs8DjCJ50qMkd+z/uenlViTOwIUj+zb25PzrBSYb/8fzBbGxAz2VlK0tgO2MrNsw5S+XrlFhVVXPWF2LxKZ6Y3OSLqGVO/rTVJ5Kv+8yP/kopsOfyTY30pong==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cSdcgSm7o5jbXpnr7qq2MkQXOzlQK8lBg0QBCAA0oZg=;
 b=XCX4R1RmfSxyMv6jlDEjfVsimd4r8ekI3Ctnni/s5opcbyGld7vAqUa/WEe36g3jp5MakhzOuu0Am1cwNogBKtRv4yrNLQ9pmC1vPCincshj9lA0trTfOla2nVQ9Wpqe6OehNEPnFakqKm5uiAzTCr6RtkUhiFAkTHd0x2mlri0NpoRaGC6X3i54/FTe0XFYV3cxBJA0mZDENS5NVVk/8ElOXFoSJ2JsfAX9N4Aify0VzJ8LHh0PpYD44eDgR4DLSKm4tWayyKekcVwxcDFUGxihIXluCcEOm07L+3B8Cc2CBI6MIyxCX9d2VQL63ZdC+Tr8ei+FjBUo/7/yCSZwzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cSdcgSm7o5jbXpnr7qq2MkQXOzlQK8lBg0QBCAA0oZg=;
 b=hQZ15t024EYYMKHS+yTD+DdIMydYO1oqYyE8TXxcrDmhX2AN7kbcE4Pz7cVTnSA/LHZ5s+x3uSIJVX0mcvUziUTh5ibJJL1TZ/4VWfqckE0gotfy0zNkoZeFOY1RxgKn+ShTldKyaH+YeNjcusWePkogeIbwEMlYXnQYz+QfvJo=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7198.namprd04.prod.outlook.com (2603:10b6:a03:297::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.22; Thu, 12 Nov
 2020 04:11:27 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4%7]) with mapi id 15.20.3541.025; Thu, 12 Nov 2020
 04:11:26 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "javier@javigon.com" <javier@javigon.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme: remove unnecessary return values
Thread-Topic: [PATCH] nvme: remove unnecessary return values
Thread-Index: AQHWuGa34tNj7I/TwE28HuX4CkJZNQ==
Date: Thu, 12 Nov 2020 04:11:26 +0000
Message-ID: <BYAPR04MB4965213DB3D1F07B7B75B92586E70@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20201111201018.30764-1-javier@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: javigon.com; dkim=none (message not signed)
 header.d=none;javigon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f0525d8a-a4e7-4473-570b-08d886c1068e
x-ms-traffictypediagnostic: SJ0PR04MB7198:
x-microsoft-antispam-prvs: <SJ0PR04MB7198587424C1BC5C29152C1E86E70@SJ0PR04MB7198.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P5+tBuyh9koAZ2NjesjHB7c0qSuZ1yf7G6VewoHChvfFRbfuNb+SbXtH+ubAoRQnJnWdg+zRuZafHA0mR1PT0hMejJZQS66MkVgMzzO3vrPPLqwrgi13lSmhFY7M29VrP3+qTop9bR11dqEhkf05FN/5+W7GFfQNpRoywuM6yQh3ovPD5SGnFExLw/Jg2XDuDWlw9JS5wYV6dFCxXvEc/26ozdx+lyi02Gfh62KeQmNPUrVUL1rUQD4/q51T5D8Bo8Ya8m62TMe6Db5ZcBDizhR4+jRE5o4nVgF1eERKl6qIIdt0r5fgFiJYkMTcSnx9FrLlQBPEpBKjN1Jj3U8pFQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(366004)(376002)(396003)(346002)(4326008)(66556008)(64756008)(66946007)(8936002)(8676002)(71200400001)(52536014)(316002)(76116006)(66476007)(5660300002)(33656002)(2906002)(86362001)(110136005)(4744005)(54906003)(55016002)(478600001)(6506007)(9686003)(53546011)(186003)(26005)(7696005)(66446008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: wQorYy1eE77ChCt891otJX15dTrXOEX//+ZkHirFSbG0q9WgF87GiEHFF6/X4hSTNAAKXv3zpm/XAZSL+O+wv/+egs7OYJthk1IFKCDL1fi7G2kLpzyRMcMHRhLtcGXfaKgSCHspBLDxGNm8W6t1Rs9zwRRHjDMxAjJQtB6HEHqOAXA96X+td4Zfci8YsZHXJNZvwc/H8T4ECCAHpPI77kJihjEjIREMXBiI2p9D11YddZjMN4V7cinDLG05Lts/tSX13fsK0AWJ/QD8+tfampx14WdulKNywR6RrKcKrNfF4xUgzZklRqRcHpGJK2N/fvENHHoFaH+jDEsWddBYwnvvpNzLwIMsaZK9oj74VBE68Jg+LT7cKqxcWW72BVuGPGVYYQt3JsUn511MU1fm2v+AiRsExRlxfliZVOEeOM14FlVIO0eTEDIQBkJmIadw1HQ1RB38k/OyXkiDJ8NmLPREmGLckKJjr8aelzME9Beog8M9jzy7tQgV3zJkv8bFyH6A4fi3SbIJM9UVTxic4QhX2R0Xjb7/m2e8jydfzdZ4UyM/YO5lZp/Il3G8AHxJNhi1TeqPNv+QBB8s4XuRNB8LTBhZ9cmWSYJkyLWjvYBxWYWJ6Umom9RpKGgC0DLe00XaMcPC1JWCIfz71NLOEQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0525d8a-a4e7-4473-570b-08d886c1068e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2020 04:11:26.8227 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jekClhUVKTBKOaJrmtyQKVq/WogXUu7Ivh61g6XnPi2tzx8nUHBfmuLY9ZgLRqI1jDpR+Mo+87WFlv2D2jeenKp0NqvJNxpAQ6M8mcx57WY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7198
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201111_231134_487353_3409D90A 
X-CRM114-Status: GOOD (  10.68  )
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
 =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier.gonz@samsung.com>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 11/11/20 12:10, javier@javigon.com wrote:
> From: Javier Gonz=E1lez <javier.gonz@samsung.com>
>
> Cleanup unnecessary ret values that are not checked or used in
> nvme_alloc_ns()
>
> Signed-off-by: Javier Gonz=E1lez <javier

The ret value pattern is used to avoid the calls in the if () which is

not clean based on the comments I had in the past.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
