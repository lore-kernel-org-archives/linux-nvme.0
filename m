Return-Path: <SRS0=QPGu=A4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92047C433E1
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Jul 2020 02:02:38 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E0792076D
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Jul 2020 02:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PJRRU0Mc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UVNMjAxE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="rRkq5Y7f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E0792076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=BV3kom4tU1anwxEFvwqRLb4DUTdKrC7zVbwNQ229K/s=; b=PJRRU0McJWYJWlxlQD0rzR/9Z
	BFTB/wYs1mDd3jIqsq2GIZl5iNgKWbg03JCDzy7Vf2oBtMxDpPzB+yMC4VJtms0nQwTI5iBXR0hHL
	cpUcBfjQ/celn2ov8nHG0SCGLZY5/6qDKzgfuQ//BZwZBdQPrlw96dridLqS2jAfjmv4UW86tM871
	nW2kRSvy24CgWViF4qB7We6aP4+Up0MHkwcfwptT4Yo5plJVMqLMMXWtyhgOLhG4PgTf7joQfO7ID
	v1Zo3EKZmeer+v1vhfOzEAEPJ5YtM+cNDDV4DgwQLBXM4g2HYRu2NBZH8Zl23Ou4xpzQuMkAvcOAG
	xcRkZU3vQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jwFhr-0008Ka-6V; Fri, 17 Jul 2020 02:02:35 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jwFho-0008J5-U8
 for linux-nvme@lists.infradead.org; Fri, 17 Jul 2020 02:02:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1594951352; x=1626487352;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=AzZCzgbkAucIElZq0SC8i+1PhSfbK/+5jdeBx28qpIg=;
 b=UVNMjAxEg3riDMbYfuaybOIqGaMITBUvZTl/2u8hAlCCL14m2CQt8ovk
 WZbt7woaCBDQbXISROVj5wg9MMowiYUtv24zNZ0NbFNkCk2WLTWUh2lYX
 YZYSfNyD6QyVqzaaK6pY1lRbQK0ZOjzhxZvhiNFgxHjfaZyhKTZyuQL8g
 6tsW0DMUKToZTJ25kQuJGKGE3UnJTEwO4uHPUwHgXkqAXvTY21/LgBrXS
 E/g5Dyoecy+wcWT4iu9AjL6f4iyhjk++QtKhVXYrahZ4Xd2qiflr+2qrF
 BJI/C2VgPX3T5k6ZsxS9NcJOmVYb8VM0bChf0bO7vtGEDyVrgsDhDIkO6 g==;
IronPort-SDR: n86x7yEbKJpACuWNmg/4m1a0Pk48KN8WD23zLv4AM4SC8iakgz//meD7iLV3AGtGQ0iKGfCrSh
 mShj0adat6ijoD/OaKFUg3e+1+Le4K1BY2n0RoCfSrEvYDQDXbl3tEIzTBjKmzWDvgLottI4gx
 TKD3pT34fJwFI/hDDnQidBLyY+PlJWfyV4FQYZuJ2maU6rfM1Dqr9bdGyT4JJ1D5E4iYKCIg7Q
 E5XW74RYZXYbAri6H+Kwl7isC7ECCkXOyZmvN0nooGwUTYYYcDY2XD9bNfR5jZoJkWR7bO6lml
 ChA=
X-IronPort-AV: E=Sophos;i="5.75,361,1589212800"; d="scan'208";a="142668634"
Received: from mail-bn7nam10lp2104.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.104])
 by ob1.hgst.iphmx.com with ESMTP; 17 Jul 2020 10:02:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nDMhLQuuLuWNX31qHJIeh1EWO4QEIJXF3ciUm9Te1FbCirCIzokKg3bNlFPkk0cZ5kUDgoAk7WQRFG6lxr0nByto4ofisgtth6ylfxUIIznzY4LdQDsCBmvt8qxADTJFquz62g6qHq+G4wtCSkptfioIJSGXluoUO+YhVypKFbye9O25VBx3cZQvid+dPYY4ItkxmBYzYmKc2JPcBv1R/3qy64q1OLKRQKW3KRvWPLDhiZ3EkbyeGVIKnPck2ilIQus0jc4E0m5KtEv/4jdMJOz9YzoK8tWz+R3mPJnJPGuBbP7QDoc5zxp32akjV2gO1fOgoqIIGd/O49GVFWnK5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PhjSIi7oxseeXCD/or2YImR94p3UCgozkzZBnQRZyKU=;
 b=fSKWR7FDqD5kQP5Bj47bGvf6FGNDwnKCtNM/qDKK71tfCeTRX62Xe1K2VQ3lzJOKfM0C6dWw47e89nmdeTQm80HhgWK10lTmTachD+wf2020ZhjqigQ0XgwAbSaD7JSvcfkxW0zdIdCJhJaL9zPhBQunTWO5XO/4+nJ3eLTiWQrn+lBqbsLHBAh7oDir2QkMddHu8Pha21G0gfo9bm/N1OFJVTJDMJgTHzEAO+4Os2dXr6J9YoAytMv7i4Rp6lSBHIQwsl7wWZm4K5IxiTEZw0Sn1VY242GK22TJHxzwMppZpdtjAwNcEWxyqVHUrXJPzTzk33BSCxOgJ5BWeBWdSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PhjSIi7oxseeXCD/or2YImR94p3UCgozkzZBnQRZyKU=;
 b=rRkq5Y7fqVWsKFA81umqbKiNn/ZFHofKJr9VbBMWvQPUAKCEjWcEy3XZ3N4gOyFiIEhGSbffKApMIlXZYIfh3nUUTkUNRzJVRK0nPc1IerLKYqPx1yYz/9g8oNZy/bn+kzqLDRZxGkCDP/Ckc+q/fEqN8DolN15BCcdSYQQZen0=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5894.namprd04.prod.outlook.com (2603:10b6:a03:109::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Fri, 17 Jul
 2020 02:02:28 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4%5]) with mapi id 15.20.3195.018; Fri, 17 Jul 2020
 02:02:28 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 00/10] nvme: use xarray for ns tracking
Thread-Topic: [PATCH V3 00/10] nvme: use xarray for ns tracking
Thread-Index: AQHWWjbfkXJqkK13VEKRp+x7lckQDA==
Date: Fri, 17 Jul 2020 02:02:28 +0000
Message-ID: <BYAPR04MB4965F9A899D5A152D255DFCE867C0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200714233057.10915-1-chaitanya.kulkarni@wdc.com>
 <20200715070328.GA22320@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 20a47dd4-5190-4f2e-3826-08d829f5752f
x-ms-traffictypediagnostic: BYAPR04MB5894:
x-microsoft-antispam-prvs: <BYAPR04MB5894481DAB49E0979B215AB7867C0@BYAPR04MB5894.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0hsBFCCjaZw4fFN4+hu3jGdZaixhTBHxzvzAsVf/fwuWu19gQlnTt0NBaRRqaBO7uL8jrQR/IApX37fwk/a1omiWBy4eSLKl854OGH82g1sJK20Udvp0yjdvHMzGJgBLeVnXDUjzXweqwvZB9NqJWBlni3z/1gYFyG0DtP6a1RZvNdjMis/OpbA86Nygo2qG9/R8mqY0Wdqp9BGjupsuglBjGeGkCKEPyp3v8xJi/ce1R2Ih6voV9E09ECFF9yjjDhaP1DfHAGITQXVh5b9ZpzEiSwsOZV07ZQ1THMjGyfITcWr7yM8gjgsNmqFQLSt16E/ndEBcMrVQf8w8zEPVsQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(6916009)(55016002)(53546011)(33656002)(6506007)(316002)(54906003)(8676002)(52536014)(86362001)(5660300002)(83380400001)(66446008)(7696005)(66556008)(71200400001)(2906002)(9686003)(478600001)(66946007)(8936002)(66476007)(186003)(4326008)(76116006)(64756008)(26005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: Z6HQ/8e7DUjZasNN17OXggXN+tesaZNEwLE77ViF+AkSrZu1agx9v+gTx50zaOFP3oo5kMbLpbmNFu7Rod9iEz6DFS9PxwyPpoq0/DlRHbAEJV9dp95A8exeqV6QqbPp3pYPNUuKzDWMkDd7t9flbcdcIhdSg0lAIZjlDl29a9l4GJjxwlJ5PN2jvmEHN7ig880WRaxZWtPhbtV3fPvuxkExPz3HZ8rrFN8ECWs6i/ucC50eEihpK/NpsDYhXKMKT3rjJ/CNKg7YPh5qHVOrgKuVMnMZzzwwbw56MyDiuy3iKa1/6A6oiI4ILImQjI4g8K+9FqM8cdj+v95EahLkfeMYutcMsPyuFfBKcBHh1GHwWj5Jbs5VVzlgwBixzeJtAKEw5fhI0fESd2llddnVMgKA7nzqv6Rds1hiGoBttn0zjdlFlulQkiY4DwsH7vmmDrNcDqyPTev7axxMwQRcxGZyV38g9T9rT/Q2OoMl3L8=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20a47dd4-5190-4f2e-3826-08d829f5752f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2020 02:02:28.1231 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9WnLPEQ6/WBeSe6gzxQTnB5pSlrhNOoS/xkdfCWj2m0tQ2KRrL6wGGO+MgxzVcPByMTgibF7gPHQ0bVN+z3jtNgzi4fEgqbScFFfySSdKxg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5894
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200716_220233_249470_4353BC39 
X-CRM114-Status: GOOD (  12.15  )
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
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "willy@infradead.org" <willy@infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Christoph,

On 7/15/20 00:03, Christoph Hellwig wrote:
>> Following are the performance numbers with NVMeOF (nvme-loop) backed by
>> null_blk devices mapped 1:1 on NVMeOF target backend :-
> Can you make sure the nvmet patch is the first in the series?  That one
> is obviously useful, so as soon as everything is sorted out I'm happy
> to apply it.  I'm not quite as sold on the host side.
> 

Sure.

Can you please elaborate on what is wrong with host side patch ? any
potential bug/race/deadlock/performance regression ?

Cover-letter has basic explanation for host patch. See [1].

In case that is not sufficient at least I'd know what kind of more data
I need to collect to prove the usefulness of the patch.

I've also offered to forward port the passthru and get the performance
numbers with nvme_find_get_ns() with XArray version, but didn't get any
response on that.


[1] Host side patch cover letter reference :-

"For host even though nvme_find_get_ns() doesn't fall into the fast path
yet, it does for NVMeOF passthru. This prepares us to improve 
performance for future NVMeOF passthru backend which is under review 
that uses the similar data structure in host-core as target-core."

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
