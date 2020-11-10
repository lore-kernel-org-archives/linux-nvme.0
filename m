Return-Path: <SRS0=JPfP=EQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B012BC388F7
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2020 11:26:20 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 303C020659
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2020 11:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="29x3jkbc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ah6zTz0J";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="MFZlgel3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 303C020659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=vQXVMC0Dsm/LFxU59+d2+JT9fYY3kTc7odc3rspZlzE=; b=29x3jkbcK9l6z+db42Q/KNgxB
	ygDfI3lMG1SABY7goARTtoiWyDZCpr0Et43oDnD1jVgKdWO7M5qP/ek5m+RITB4Q22+f7B7MEASSs
	VIMyCfMFY+BGdtGfThLNi+e/cdM0FXm3ngcloGKEu3IJpnkA6zYLupGYyw/SeJuQeGS0/s1rkCUJp
	O1ORzfoUwLV2xXWqzwAS2MHtmYcrV6M5GgRkOgczdY6mRrNkiryqGmG5BxhBNnoHxDWNJRtYFcRpV
	gGLwVmqS10J5fIFAOyNS6Fp3PJ/bBRyPgYH/3ALGjgpvsFhbXsH9OMKlGs1XIzb5q6U1w2E1L/ov+
	S/eX3B+Qw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kcRmv-0005U3-6A; Tue, 10 Nov 2020 11:26:13 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kcRmj-0005PL-NS
 for linux-nvme@lists.infradead.org; Tue, 10 Nov 2020 11:26:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1605007562; x=1636543562;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=drCZABqhweiambKn7abzPMAg2u4pyuybv/saN/dQ0NA=;
 b=Ah6zTz0J92YS3fN2fAhMcFpfsohJSQ7Ln9vfc29TiKovlohcij1OoT1X
 Fb9WIWznW13rYajAxk+NPiu+IgE9N6LfiVMo/GuT4swjwXo0CbjVjVRds
 AF/aEQuPAKSHWimpEkkfwoG6TQ0xj8x/QiMJbA6RbVCvwxeMtZJxmIpPt
 W8OLwKJJScSWgKxqus4AboOFvkvQXTXF/ALQxp8KiW5dmlCcIaAtX4/Wm
 XCYJHd2rAiZk34Y6lxAovMyODeEhVO+5SuhPauG5dYQerNUEOPgpQNIwe
 /VxM9HtU0O3Jm3uj2JCofAbeEt2A7SMBrSOPrfCqNYBNqAgrWgvBjFtpx Q==;
IronPort-SDR: HLHzpvs4WAnyuBJ0lWz2ZaESP2Rv99XdJcYl1mPV3wvYlZE7kzm5BZOAGEGllL0C1vt38hMR6h
 aZ63+3jqeuydcsQWWlP9FeFEWFiD2wV35nNYAR7ME5DWqENXdiKEgEhxyoFxHlcIRMuI42gLCU
 PMF4AAoIJ/TQDn3hMLXsv7orn5z6xn+7o63kuGX/KTAm7GgQa1I4WG4XCTm6csJ/F6D5xzYCWQ
 6CXV65kHavpcA73PP7eDvmo6hmzrWwWPlBircpptzfqUr/YRNN8YLqnMAZZhE2++iO1boRzCnt
 u0Y=
X-IronPort-AV: E=Sophos;i="5.77,466,1596470400"; d="scan'208";a="153477517"
Received: from mail-dm6nam12lp2177.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.177])
 by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2020 19:25:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IH0MK9CVLtZMRiPGAKi30aa5yFsDbXdQtIGpm+7Kd0rfX5O7pIkrkydZ2UbkzlTHHKSaahU7C5vHoeAzMJoTvt6zHcQi5nmcLN01h2CARulLup91atVQCX3/1IIQzLKkHjWpbwE6hN+BBE+5IqiSfzns6G/9yOiUbVtXMFLLtWe7yjFPHqv5cB/XeQAxgHHAyE1B/YsuaeOkZktKYpmBSF1hxqTTXoQ4s7EN71+meAMnGGmREUlm2VN0D38g+SXn75Tqz64R4HxyEqdtwVy+LSJungAHEOpXzm83axo5+gqgIvQOvcgrE46FX2+riSobr7cRGCJR7TZcUw6248Ihng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5CkoXKrhIvoLyns+q+XXpKaLNPaG+mBrt7Fk6OcC/I=;
 b=OxJUoSZb4opi3JFoSoQYpSmMbjgI03gxgLWnPLuJ1d2w1d/R4DHNHyQWPuxt/5DLKkM80xYCF/guwdHQJWNIxXYT4kojkrv5hNfnjG4+6Q+/jQJqmVe00Hw6Bu0xQ5ArUtBBTILCkSa9VS/IuB13N1l0GcdkdBBsDMvYswJYR/yd/LLK0s79dgnHmDj6bVSJEbpAUvskpFysF2hqPrszBmQYHZAlO2sxjz1SkkJP9vZ87VNHvp7FLrYAMHXpuqHy2e/Lc5EpAhGaWJM9lcAljGAP6CQoX/qvUgnkBDJRmbERXnuyb7rAhxGsDfRi+1kE3lYae6/RzM7Nt35OmGmxKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5CkoXKrhIvoLyns+q+XXpKaLNPaG+mBrt7Fk6OcC/I=;
 b=MFZlgel3h1VnpbYNEqad7AzanZ1TeApBrCi0MFbDv7Qrtga5gD3GFT/jnuJYikrDCkh2r7z+LF249nbygYPNMP99EpveZXkT5BgaNj/53jf/zVzG7AqESdgoiw8D51ebEMwQGSyIonBW9T3HbUnsjouoAqUSM9MstosIIRQxF9c=
Received: from DM6PR04MB5483.namprd04.prod.outlook.com (2603:10b6:5:126::20)
 by DM6PR04MB3850.namprd04.prod.outlook.com (2603:10b6:5:b9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Tue, 10 Nov
 2020 11:25:56 +0000
Received: from DM6PR04MB5483.namprd04.prod.outlook.com
 ([fe80::c8ee:62d1:5ed1:2ee]) by DM6PR04MB5483.namprd04.prod.outlook.com
 ([fe80::c8ee:62d1:5ed1:2ee%6]) with mapi id 15.20.3499.032; Tue, 10 Nov 2020
 11:25:56 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V2] nvme: enable ro namespace for ZNS without append
Thread-Topic: [PATCH V2] nvme: enable ro namespace for ZNS without append
Thread-Index: AQHWt0Vw2EMjBTbxRkeikWzu3p5prqnBHXYAgAAcfwA=
Date: Tue, 10 Nov 2020 11:25:56 +0000
Message-ID: <20201110112554.GA465503@localhost.localdomain>
References: <20201110093938.25386-1-javier.gonz@samsung.com>
 <20201110094354.GB25672@lst.de>
In-Reply-To: <20201110094354.GB25672@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.226.244.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0308a982-dd42-45cf-315b-08d8856b644c
x-ms-traffictypediagnostic: DM6PR04MB3850:
x-microsoft-antispam-prvs: <DM6PR04MB3850BEF659247C1B7C806AABF2E90@DM6PR04MB3850.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:651;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 46iTf5xMnnsBrOmCcaqIeUAY9hPgBkHYrIAhXmu/RixGCZffD/UFPx3p88hidyQGXJGWQxGV+e/XxPwj5U5uIaWcKCGj+acskNTJVf0zEWHhUrlO3bRKcKIXqJaD791GxYX5SdPPTnk+OKHehbWzZAJvM7V5d6QF17QUSPU1rrzEU2IBVEYo9v1ri+TMzCJ6LbWG6Ygq12l2gO8zxu83mPFbWFrGkLIbuKRJ3Ey11iy+LRdf+2Kefa/w8n7F0qAYuVS2KpQoQGR+0wP+r9AoZ4oYSa6H508uLJgEGz5DLNDIizwrKIX3+KIpCC2eCpAYqFDjz5QBX5KqiIJ3TQMfYZ/7Vjs967/E7VHKkxjGD6AVdT+Cmwl03zVvkde+k89quW12CPVmHRctVArsjPeAJg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB5483.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(376002)(366004)(136003)(33656002)(7416002)(1076003)(71200400001)(86362001)(66446008)(83380400001)(66946007)(66476007)(66556008)(64756008)(76116006)(6486002)(4326008)(91956017)(6512007)(26005)(54906003)(6916009)(9686003)(186003)(966005)(478600001)(66574015)(8676002)(2906002)(8936002)(6506007)(5660300002)(316002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: yuEHCZGX+s9Prgw1WWCfaff5t1QgX7IirbXL38d+fbcMO9ilbU/i5dLXdzvgOILVizbbNkAMHzfS/M3TlZNBxtkBBLZam+xrMxJiFQ+UJnEGnOpzRNTNn3wrTsfiwOoLmMWiDhaezqgiZYBJyxgqrKD1+Eb1u2X6iozprq8huEAecBe8BwrDp5vroiA3M7YtvSjClt/Go8nh25GHX3sJoc3DTd3O64A3pMFjA/rCIADcf3Q1nUW0G+Bsyiet2wMvKpz36Xl50aJSF0AV5ivKrOQQS6EZ/6734bOd6ISBV/F/jIeBH3TJbb57VOx6ub0JjdKvPJf6zcHepO0W1vl5xuexe1EfmZUxtgYSZfgW6dSXkdFmsmsS46zv8r4xf26dZY97dtyBmFENtD64+00Fmkkw4Mzf7UkE3+rezQei8DqM0sVY+gwa12bEArne6TSKkGenw42GIXgU6PB5fMmU9YpESCpjACP/m0vlQu8xwQwL4XaPQDGdPEEQ/cW+JBfj67RH0A3zOX93tyPyk35VKsqVmR8dhWxeSkxafOvOZ91ZdkYkl64nYfksMHG7x73dqEtgbQctm5kqli1OcMLdItUDQqY1yV11eXnUkl3ZeF7j6uvRSWijU8kdazu29nGZezK1zzgycBkNpRpi/ZLAeA==
x-ms-exchange-transport-forked: True
Content-ID: <16E7489F6014BD46A22DEFE241F00E3D@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB5483.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0308a982-dd42-45cf-315b-08d8856b644c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2020 11:25:56.2635 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C/qpgQQ3HaftAZrpKnsv1KZ8uZ/Vvu8S2mMgROw5O+NyjQTOSgFUADBOA0hPUA8wCNDPFtZlXNlVLgsWMMKLHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB3850
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201110_062601_975702_4775DB67 
X-CRM114-Status: GOOD (  20.08  )
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
 =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "joshi.k@samsung.com" <joshi.k@samsung.com>,
 "k.jensen@samsung.com" <k.jensen@samsung.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier.gonz@samsung.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Nov 10, 2020 at 10:43:54AM +0100, Christoph Hellwig wrote:
> > -	if (id->nsattr & NVME_NS_ATTR_RO)
> > +	if (id->nsattr & NVME_NS_ATTR_RO ||
> > +			test_bit(NVME_NS_FORCE_RO, &ns->flags))

Indentation for the test_bit() looks off.
I assume that Christoph can fixup that when applying.

$ ./scripts/checkpatch.pl --strict ~/javier.patch
CHECK: Alignment should match open parenthesis
#280: FILE: drivers/nvme/host/core.c:2062:
+       if (id->nsattr & NVME_NS_ATTR_RO ||
+                       test_bit(NVME_NS_FORCE_RO, &ns->flags))


For the record:

WARNING: From:/Signed-off-by: email address mismatch: 'From: "Javier Gonz=
=E1lez" <javier@javigon.com>' !=3D 'Signed-off-by: Javier Gonz=E1lez <javie=
r.gonz@samsung.com>'

If you want to use a SoB that is different from the email address which
you are sending from, then according to the The canonical patch format:

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#the-=
canonical-patch-format

"""
The from line must be the very first line in the message body, and has the =
form:

    From: Patch Author <author@example.com>

The from line specifies who will be credited as the author of the patch in =
the permanent changelog.
If the from line is missing, then the From: line from the email header will=
 be used to determine
the patch author in the changelog.

Note, the From: tag is optional when the From: author is also the person (a=
nd email) listed in the
From: line of the email header.
"""


That way, when the maintainers use git am, it will pick the author
from the "From:" in the message body, rather than from the email header.

Otherwise the Author: field in the git log will be different from your SoB.

There are several ways you can fix this, either by using the correct email
when you do the commit in the first place, then git format-patch will add
From: automatically, or by using the git config sendemail.from, or --from
option to git-send-email.


Kind regards,
Niklas
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
