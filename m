Return-Path: <SRS0=rw3x=BR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FADAC433E0
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 07:36:53 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 151DA206B5
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 07:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gWf+I6tc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=netapp.onmicrosoft.com header.i=@netapp.onmicrosoft.com header.b="Hr9f5JXc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 151DA206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netapp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/F8NVp3LU7cqy4dHiBfnmlk5YhlkMZ6kyfSqBbhBTKk=; b=gWf+I6tc8BYkRmLGCHF+pDIlL
	tbejdywEvibhAS6QFyPnUoP+hdvUejyWXixl1Tl+HTrtpGGWKiETBahEomX3KAs3IcWDO96447Ukx
	+F+MnmI9QSutFEnmpbblZrFR5jiTEcPOiwG0IA3hc3hNlzMZXdG9+fQ8R3yqfxPNkeuk1Aw9AZ83F
	xc5VK9d4g+5NHE3xQi6TVdJoZUrYetkSEz4fDTeJqQYymJSg7aI87AOFxPmVa1A9EHEgF+zH72Bw/
	3BAjBPUVa5CYf5PDntwq29CWpf8QjZPjp0wvFRVpd55POyHSpe07j74urA41ow17RkDct3WEoC7KH
	dBlfRcHXA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3wvm-0007cZ-Hw; Fri, 07 Aug 2020 07:36:46 +0000
Received: from mail-bn8nam08on2049.outbound.protection.outlook.com
 ([40.107.100.49] helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3wvg-0007bl-P3
 for linux-nvme@lists.infradead.org; Fri, 07 Aug 2020 07:36:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZYNbQ4LKsDx1GnsDXVQWUwLPNq6q/6tiAlPnU3y+iMiOLetj5o34NUkhAas7GnQXKRSLSMJrF/V33vlSbgk6UtDkw6a+8UItXsQYlKBWDEKwj25toDsdoUeCJt5iQp8Hk4C7NW6eo7d9c3ZN1g7bKVaLd1gWrQDT0/w0tDoKF2XhdwRuYF4L1zlqWuKymAvTVjRvbVJwc8xloSfSz4e+9e0E6P7QEFFzHm13LlUoxIz/jvLPcWnGTss5NH1q2g6N/ebE9IN1M9g8TLbonCiPOjghx61eLfw6Wh4V0/xh5BPx89Vd6sEQVcuixs6rbRUGSjtNHbx74zEM5BvTW7hRiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zy/0UXf6VruRpzK33NSGKsvs8305vS6VYLxMYxY9ghU=;
 b=HaA/1tJFOUvDKO28o7f/4TJCgRvL/8jscoO+Kw+3hExHy4C6iPTBB95G0AuRpQQmZOgpUrnQrcm7q54stbnj5x0a/d5E6my4Kw/uGla7pZFSDVhxLVxS3uC9LVPgvHu9cUs+V3LHuAge3IfL0EJ5K/kz6dpXBWy+E3TqaZBpzx2S9/th2rNeI6m/VZHa4n3ALPFg0F79PIRZpcyiH4GdU2YOp8amiDkaFSm8KXPoqwKIyAQ5+HMl7lRra2gFO0kl7KY8YXAnOG8GIws6GB+jTzl8SqfCMUvmYPCMUj6FbmA7zwvPpkt2SjDj2X8FC/pEE0U8b0Rmi1JPuSpEdQDYNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector1-netapp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zy/0UXf6VruRpzK33NSGKsvs8305vS6VYLxMYxY9ghU=;
 b=Hr9f5JXcDnCo2/IpLgD68/1NiXaYprJ7maCwhEeJGocTK3MZpxk/n6LUPArb+j4jeY0PffcaMOf7suoN88qPVxE+pWUApaXPRJiSa6++0Ex564HNsOyfxKYwcvb6dObKDybbsNHT7IkoA72Y3rs7tN1/pCdHypTT75D7xyrk7nY=
Received: from DM6PR06MB4634.namprd06.prod.outlook.com (2603:10b6:5:ff::25) by
 DM6PR06MB5419.namprd06.prod.outlook.com (2603:10b6:5:115::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.20; Fri, 7 Aug 2020 07:36:35 +0000
Received: from DM6PR06MB4634.namprd06.prod.outlook.com
 ([fe80::f968:313:8e80:d847]) by DM6PR06MB4634.namprd06.prod.outlook.com
 ([fe80::f968:313:8e80:d847%4]) with mapi id 15.20.3261.019; Fri, 7 Aug 2020
 07:36:35 +0000
From: "George, Martin" <Martin.George@netapp.com>
To: "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "mwilck@suse.com" <mwilck@suse.com>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 1/2] nvme: multipath: round-robin: fix single
 non-optimized path case
Thread-Topic: [PATCH 1/2] nvme: multipath: round-robin: fix single
 non-optimized path case
Thread-Index: AQHWa/RSXWgZjC0JYUWwrbott91+yqkrexeAgADH8wA=
Date: Fri, 7 Aug 2020 07:36:35 +0000
Message-ID: <a58ed3be0724c5ec4c1600cca818c1d3c8356fcc.camel@netapp.com>
References: <20200806131932.20017-1-mwilck@suse.com>
 <20200806131932.20017-2-mwilck@suse.com>
 <f00f506389acbe919016f8f4dc9ac6d91442af0c.camel@suse.com>
In-Reply-To: <f00f506389acbe919016f8f4dc9ac6d91442af0c.camel@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=netapp.com;
x-originating-ip: [202.3.121.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fedfa4fc-6da8-4ba0-e577-08d83aa49ce9
x-ms-traffictypediagnostic: DM6PR06MB5419:
x-microsoft-antispam-prvs: <DM6PR06MB541944AD2186F76B50FA16DD95490@DM6PR06MB5419.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: syD81FFXnb/VkL1DfPrZX+JI1WW4lYRNYwD0kkJPoWYYmQBNVPgW4hdqYn7aGqWgBw+Dt+7iqt51kygc/vEB+zoX6Lnfx7rMpCXqHPH9buRpklVNLOF/D0bt+IolJEyg6ejgEKSEpYAVlJfbZeXNhjd3hmEpWmAj4SR1g8l3sAOFGz/wepSbtRO+sjmnyWVBDq5an1JBuTG+ygd6XGVE1pStUOqvlN6c81WEm/SDR4y0gZj0jBxHy9HPTFbpYEu0hqI1O+Ol7IvsfQXjqtJ17kXkXEDRgVfkDB41KLdhIb/Z5Tq0HYRwbLgOGQoWqwk6dOBzTX3SzIMDeFV8vpVoD1vxBwYk6Jz404rSxvhwnY7XFbOdbAko62NsfsnOW434
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR06MB4634.namprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(316002)(76116006)(91956017)(54906003)(83380400001)(66476007)(66946007)(66556008)(110136005)(6486002)(8676002)(2616005)(66446008)(36756003)(86362001)(186003)(64756008)(26005)(8936002)(2906002)(6512007)(5660300002)(478600001)(6506007)(4326008)(71200400001)(99106002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: FR3q6vBBw9FFIBAvu12xwmw//Qp5HG45prc96/DyCCac5cHWTf1W59RPVFzIQI+meAAVpy9C9AI/xohwDsC+Fefm/kU7Pc0Ejxzl8aUepfQfZUDUd4nMQGBWpTcHIotFyxQesG7qi58UxDs/QpG+SFo6bUMGPHSNnyXS1jVnMZzDFEFoMI3lU7lyYKA5mFWBue3aF5iLV1nBmKpJf/ieVA0mtISQ97HKVD0jzCzle+UnQeL1sNsnK8V/qXkc5+WlejF2QsZPl9nQZuwmG7XEfkk7sRf9g9IakmSApiCklAgLc9L/kwDvHTODWHowB0H7hhNOtLBO6pWTsBNbQsLI0KULAeO1HhjfTIAOUwkbkxY56POb1RXHKjQCd5I9rhmyIpWK0HBp2lXGSjNaN5SvopzA+Hk77Czl40OiFWxQibSOubpG7HCvJspu+v064pcrn/HWsqRrqwk3hxT2vkeiMWrCul5fIMPreayrTd6niMhfEyCEiwi0yQqAiYR9xLeG3KM4BD0oUdw3np0yDN1zJRC9ZhNFXvCvLLTKHrscBRnSQgNQh32QInc1GN1yGkQWo6PKDU5riBwxqcllwY+/6W6+zc9np5f0i1aLVAmXl1K4wr+ufNe10nHflK/OWLEWCgcMOy0w/k/XY9Fr05RdCg==
x-ms-exchange-transport-forked: True
Content-ID: <15D8D6876F6FBA42B5A004F065CDE5D4@namprd06.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR06MB4634.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fedfa4fc-6da8-4ba0-e577-08d83aa49ce9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2020 07:36:35.3957 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OmzVr5sq7x1/Ap9biLBmZOjsHXhKqIb0GH7PNKovmOacoCePTMnAFWkp+mwhKQL8V+RIm71kacv84WwvQqx2tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB5419
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200807_033640_936454_447F42F5 
X-CRM114-Status: GOOD (  15.51  )
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
Cc: "hare@suse.de" <hare@suse.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, 2020-08-06 at 21:40 +0200, Martin Wilck wrote:
> On Thu, 2020-08-06 at 15:19 +0200, mwilck@suse.com wrote:
> > From: Martin Wilck <mwilck@suse.com>
> > 
> > If there's only one usable, non-optimized path,
> > nvme_round_robin_path()
> > returns NULL, which is wrong. Fix it by falling back to "old", like
> > in
> > the single optimized path case. Also, if the active path isn't
> > changed,
> > there's no need to re-assign the pointer.
> > 
> > Fixes: 3f6e3246db0e ("nvme-multipath: fix logic for non-optimized
> > paths")
> > Signed-off-by: Martin Wilck <mwilck@suse.com>
> > Reported-by: Martin George <marting@netapp.com>
> 
> I made a mistake here. It should be
> 
> Signed-off-by: Martin George <marting@netapp.com>
> 
> because Martin G. provided the initial idea for the fix.
> 

Thanks MartinW. 

I've also tested this patch and verified that it works fine for all
scenarios including the single ANA non-optimized path scenario. So in
addition to MartinW's Signed-off-by tag, please add

Signed-off-by: Martin George <marting@netapp.com>
Tested-by: Martin George <marting@netapp.com>

as well for this patch. Thank you.

-Martin George
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
