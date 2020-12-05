Return-Path: <SRS0=fl3Q=FJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C84C4361A
	for <linux-nvme@archiver.kernel.org>; Sat,  5 Dec 2020 08:29:05 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDBB922D2A
	for <linux-nvme@archiver.kernel.org>; Sat,  5 Dec 2020 08:29:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDBB922D2A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EbNEAIvCgN5FGNtcrQx9Gtlqe7NHwcXJjju1zv4FZFE=; b=1snpAZru1MHIu+sMHp8tMqrN+
	Ln1K9OhV3eUDw5kTxVGiskjg3NITcjEdiG7K7QN1zysicUd/N/G/GXNREqAdJVEPtV2aD0bLu4Egs
	CsQrszxMsIJ1P/JzFoXyiP6jKJjEO/BW8KiyIJTpP18F/qRNv06PCohJL5EjdRcR95bt6D/Mujn0s
	se4HNYyKoOon56eNSVGtyH5K//K94q7vIc7ZDqpbwVHAOmWQC6av7RbkyckUlHYtna9XIlyaQiLkQ
	spB20I8ZkH0B6f3bBB0vTdrVnsfQNHSGwvcPrn0ZUD4Wb8p7limiJaHtG9z8QE4bScM1qq+Mr3QJs
	WXuo1/Dgg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1klSw4-0007Fa-21; Sat, 05 Dec 2020 08:28:56 +0000
Received: from esa1.hc3370-68.iphmx.com ([216.71.145.142])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1klSw1-0007F2-40
 for linux-nvme@lists.infradead.org; Sat, 05 Dec 2020 08:28:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1607156932;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=nAbXPK3nVMptgUPtprCki/nA5ZKt7Jm7DI5lfY9ePPc=;
 b=YNYVqQllM7ZUANEB8TBJ27oLjgB+3nvuH7U1QLPlbFKRlGzBSPbW7Njs
 gOR/6zczgRH7aql9LHddGPK9xYq3sjqt5j/8sIZHaJgzRUj5qOARH8mvb
 fapXiFuYMh3KgqpUudUosxYrq49OVAAcs9IhaRNVk4Fw4iWf3NhlE6mmQ Y=;
Authentication-Results: esa1.hc3370-68.iphmx.com;
 dkim=pass (signature verified)
 header.i=@citrix.onmicrosoft.com
IronPort-SDR: eYwh+PWpzrUCxzctJsbE44MZ9g5neO0rDgE1/MapUWDDyJjJcDkADFBY/5UG205Xb4kbVvYDjz
 I4rgfs3td0I39Gu63LuRMDxRLGC9Fvev2q4sXWTiJRy4z2SesIces7TBxE7RPXc1WYWrwuwrrD
 Ez2FUj2wHJUiWHXQEKMGiTqHUYVMqEeKzWCM7QCr9KJZZ8SmnY3A8ymZ+UiqVdS5IS5yJhtwJW
 6fWQacRIO86MuS6sX/YCH5u6aacbQ5g3Q1HpGlO8o7bkloMdAKYv45pkdL6eicwgmCxTTsnx/n
 UAU=
X-SBRS: 5.1
X-MesageID: 32933548
X-Ironport-Server: esa1.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.78,395,1599537600"; d="scan'208";a="32933548"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dAorNJtTrtqjtdkZq4+abiINL3eQcFnRaNHliSUIyD0u253/8ViKICtLaV9W6u5ZB6qRne8o31Ouk5pu/XRx1p+yvF0xaUGqDWspHo9bbNnf8TM7+K8Sviu1aNAds9nAfkx5NkkFX4rammP7wHSVvSdfj4X+aF5zjqV1jt9zZ8Ib9HZmdjeD89IRJIJYfYX6nYeZEkGodmpOrxoZ4IEZq9HqBlzYXehu5dJbvO06Y3L5h6txh31mUPebz4a0CBTNp3nax6no03Ob/PJqMVrAB3atmwaHdM/Tl0+QYiwf/w5pfjQ2GleAOr5INO/YAWJEtzd+njVSVY4oh9sHwxx+TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N9fNEVGfoh0fiailX7qD0wLGaytrgfccSnKl9WE8ni4=;
 b=bWgHInKvCVxIruWrPqfIrYti3b8dj9kz40Pve1Qlagp6GmsDOpws7XDr51VNfHvMftQ93KdfMMhVEKlxshQ3JC4d+p6mRKQneT4VFA1HSp6zhBP0y9oNsvEJFjKEfcFlHJH/De/4ZlLRXram1wIuVXQufv+DT0jLTRtgwMwXCzpSGVTwY3pvm8iFmIxrYQdk2xkTXy+GNkKedTSKhob7zwhwzcXPjR8wTvvyzQySLV6R7NCCtb+IETJshZgmucfo/WVYzol9MNfkMwf6l8utiAZmu9vDSm8aJwU9ThyQxvBBUJ9OONc8fY0UoUT5BAKK316NfJVEb5W64frljFEUqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N9fNEVGfoh0fiailX7qD0wLGaytrgfccSnKl9WE8ni4=;
 b=IxddIOrRAaW8F1o20ekjH5EGaj0VX0ugJZ+1o+P5tReFtrvufpQYuVOM0QnmjOB0PrFsNtERxKrQjPCvcYOFMoI7JYGCmXfqbcGswsIgo8LW/LC0zV1MqBgeS4MYEWhyen2OfEj8z9OvCcS634rbfegYtPEkXVihwQ+T8zIDx48=
Date: Sat, 5 Dec 2020 09:28:39 +0100
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>
Subject: Re: GPF on 0xdead000000000100 in nvme_map_data - Linux 5.9.9
Message-ID: <20201205082839.ts3ju6yta46cgwjn@Air-de-Roger>
References: <20201129035639.GW2532@mail-itl>
 <20201130164010.GA23494@redsun51.ssa.fujisawa.hgst.com>
 <20201202000642.GJ201140@mail-itl> <20201204110847.GU201140@mail-itl>
 <20201204120803.GA20727@lst.de> <20201204122054.GV201140@mail-itl>
Content-Disposition: inline
In-Reply-To: <20201204122054.GV201140@mail-itl>
X-ClientProxiedBy: LNXP265CA0025.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::13) To DS7PR03MB5608.namprd03.prod.outlook.com
 (2603:10b6:5:2c9::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b327aea6-b25f-4ab1-8c6d-08d898f7c835
X-MS-TrafficTypeDiagnostic: DM5PR03MB2633:
X-Microsoft-Antispam-PRVS: <DM5PR03MB263394985F4D59930BE1101A8FF00@DM5PR03MB2633.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZUyZ7OhZmf1Ez15i9i1H0YxEBaMq+v56qCt/shMttn1Wc1b37H7G1VswrDl8ED6599a8My+NrYZuKvFtjnBiya45Z6x/Y1YXRLmDpgPyZit5PGsrYlnWvrzX+rUWjlq4jmCvFw8el22yo8ENj6xYJsO6uh0HQRgqvp4YMkVx/HhElACDjMpaivFEJhD1hZNJb//RpS2R5KUGcFs5mdl2kRhG9Kq3jE5HtPZEtvX9Us+Ye9omvSx+tkodqTzzE9l5kbmxyC3xblRrwVvNs0Ss+gEEVW1JKh2qjRnPkVuH9k3sIrZPRYB0QSBsIm11miFiHZdg7Pd+C0owQ2Vc1dU4zQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5608.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(7916004)(4636009)(136003)(376002)(396003)(39860400002)(366004)(346002)(1076003)(83380400001)(6486002)(66574015)(316002)(6496006)(86362001)(66476007)(66946007)(6666004)(85182001)(5660300002)(186003)(16526019)(66556008)(478600001)(26005)(9686003)(6916009)(8936002)(33716001)(4326008)(956004)(2906002)(54906003)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WGZYZFR5SWNMdXM4eW9TSkpVZEYyVHhrQXdBdi92RHU0UTk0V3BRdzZnT1ov?=
 =?utf-8?B?b1BCcUNzU24xM2M3dFhSbURqMVNjbHZ2cERVaHd4ci9wbStaWEl1RjhIQkZx?=
 =?utf-8?B?bTQwamlZS0pFRjAxOWV0Tm1UMURyODVnR1E3dEt4NkxWRFNkeUc2OFpKMmx6?=
 =?utf-8?B?Q1U3YmFEL05zVExYK0Nsei9PeFk0eDQxNkhNUjFmWWIvczNXNE9OQTJrYkxv?=
 =?utf-8?B?ZXdQdHlpVTYxeG0zNTFRMVczWEJHTGpZVjc4cXJGSGRIeWFDNktsRzVKaTEx?=
 =?utf-8?B?NHFQZkY2MXV5SXVEQXAyamJNYXRmc2VwZExBMWRBUHIxMGlEM2tZQ3Fudzgw?=
 =?utf-8?B?RzR1NU5EME8rZzNoY3B0d0JNR2o2SkNFdUExTWt6a3Nhc1BuTWFUdlpFalpw?=
 =?utf-8?B?TjB2WUZEelFJL3JjUnVsc0pEYTc1Q01HM3V3NGkwcUlxSzJlbmZRNnVkQ1Y1?=
 =?utf-8?B?N1lML2dEVW5KemJBWEFDTjdIZFlRdmhkMGsyMjd5dFFqeDMzNXI0RkdWZnUx?=
 =?utf-8?B?OHNTOHJoaTQvL2Fqd3djWXZ2OUFULy9QcHV3KzNzUmtLZU9FS2JzQ3dNMGJF?=
 =?utf-8?B?Q2NUdGJWa0RJSHVwa3o1b0ovSjdOK3dGcG1IZXZnNXZLNWpyNFpwbW5qZjZ6?=
 =?utf-8?B?cmI4Mzhya2Z5L1p6ZG0wZTkzWGJtdGppd0FjQkFiK2RSZzZDcFhKdWgrMDNT?=
 =?utf-8?B?YUZnQXdUNVJId1RLeENFdnVFSWZKUU9iajRqS2kvMkl1SVFJTVFobTJSSmI4?=
 =?utf-8?B?VGcwcW9uR1draGl2VFY3MHRudFJkWVNGSjVrUGtVdkhvcmszTWhTcDBzQW84?=
 =?utf-8?B?MkpmT3pBcjlMNHVPcXBFNFdabWxTZDBhSU5hVllNeWRHNm1iTDhETEg1Y1pH?=
 =?utf-8?B?cHdKR2FWOHF6aXUzYTYxYWtPYTRwWHBPS1cwdmtVbm1OOSt0cUdBTTlTSzVp?=
 =?utf-8?B?NFFiOFIyM3JPSlFIY1BZdTI1VVBMUkllMG5aWVY0S295bzR3dzRQR21PQngz?=
 =?utf-8?B?dnIwUmxNbmhmcHNMRGU0VEhYRkhuU3krSy9TN0FERys3Y01jYmxVL3hXTUN3?=
 =?utf-8?B?MHhRZEZQOFp1MkxiaXFCNk5aT2xCUzVIRitaaTdnRHhEUkRDN25KcTdNNUZz?=
 =?utf-8?B?NEdEWU9nZWNmOVd1YWJsNHFyL1BiS2l2TTRIYlhrdys1VDRhVHptbVBBNW4y?=
 =?utf-8?B?WlkrQ0JwbEw5VGRacG00TGJQanJ3YVYzMjIrbGFpUFFJUWQvMGdtbkhZVVJN?=
 =?utf-8?B?bVNwd0U4R0JKdzFrR2dJQncwV0dVNHpFWTQyK0cxRFZoS1FhRTZpbi9ET1pC?=
 =?utf-8?Q?l/QfaI4voi81817yUS0zRk+2yWib5eDgj+?=
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5608.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2020 08:28:45.4539 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-Network-Message-Id: b327aea6-b25f-4ab1-8c6d-08d898f7c835
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A+wSMUz9CuE3zSFwWjzL3+mNlH0UNTchnLuVlNmIT8/tTrzLFGNNeUPxwrpVGfLULsJbWz8tINIqR/j220k+Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB2633
X-OriginatorOrg: citrix.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201205_032853_301634_433AA28F 
X-CRM114-Status: GOOD (  11.23  )
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
Cc: Juergen Gross <jgross@suse.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, xen-devel <xen-devel@lists.xenproject.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gRnJpLCBEZWMgMDQsIDIwMjAgYXQgMDE6MjA6NTRQTSArMDEwMCwgTWFyZWsgTWFyY3p5a293
c2tpLUfDs3JlY2tpIHdyb3RlOgo+IE9uIEZyaSwgRGVjIDA0LCAyMDIwIGF0IDAxOjA4OjAzUE0g
KzAxMDAsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOgo+ID4gT24gRnJpLCBEZWMgMDQsIDIwMjAg
YXQgMTI6MDg6NDdQTSArMDEwMCwgTWFyZWsgTWFyY3p5a293c2tpLUfDs3JlY2tpIHdyb3RlOgo+
ID4gPiBjdWxwcml0OiAKPiA+ID4gCj4gPiA+IGNvbW1pdCA5ZTIzNjljMDZjOGExODE0NzgwMzky
NThhNDU5OGMxZGRkMmNhZGZhCj4gPiA+IEF1dGhvcjogUm9nZXIgUGF1IE1vbm5lIDxyb2dlci5w
YXVAY2l0cml4LmNvbT4KPiA+ID4gRGF0ZTogICBUdWUgU2VwIDEgMTA6MzM6MjYgMjAyMCArMDIw
MAo+ID4gPiAKPiA+ID4gICAgIHhlbjogYWRkIGhlbHBlcnMgdG8gYWxsb2NhdGUgdW5wb3B1bGF0
ZWQgbWVtb3J5Cj4gPiA+ICAgICAKPiA+ID4gSSdtIGFkZGluZyByZWxldmFudCBwZW9wbGUgYW5k
IHhlbi1kZXZlbCB0byB0aGUgdGhyZWFkLgo+ID4gPiBGb3IgY29tcGxldGVuZXNzLCBoZXJlIGlz
IHRoZSBvcmlnaW5hbCBjcmFzaCBtZXNzYWdlOgo+ID4gCj4gPiBUaGF0IGNvbW1pdCBkZWZpbml0
aXZlbHkgYWRkcyBhIG5ldyBaT05FX0RFVklDRSB1c2VyLCBzbyBpdCBkb2VzIGxvb2sKPiA+IHJl
bGF0ZWQuICBCdXQgeW91IGFyZSBub3QgcnVubmluZyBvbiBYZW4sIGFyZSB5b3U/Cj4gCj4gSSBh
bS4gSXQgaXMgWGVuIGRvbTAuCgpJJ20gYWZyYWlkIEknbSBvbiBsZWF2ZSBhbmQgd29uJ3QgYmUg
YWJsZSB0byBsb29rIGludG8gdGhpcyB1bnRpbCB0aGUKYmVnaW5uaW5nIG9mIEphbnVhcnkuIEkg
d291bGQgZ3Vlc3MgaXQncyBzb21lIGtpbmQgb2YgYmFkCmludGVyYWN0aW9uIGJldHdlZW4gYmxr
YmFjayBhbmQgTlZNZSBkcml2ZXJzIGJvdGggdXNpbmcgWk9ORV9ERVZJQ0U/CgpNYXliZSB0aGUg
YmVzdCBpcyB0byByZXZlcnQgdGhpcyBjaGFuZ2UgYW5kIEkgd2lsbCBsb29rIGludG8gaXQgd2hl
bgpJIGdldCBiYWNrLCB1bmxlc3Mgc29tZW9uZSBpcyB3aWxsaW5nIHRvIGRlYnVnIHRoaXMgZnVy
dGhlci4KClRoYW5rcywgUm9nZXIuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmlu
ZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9s
aW51eC1udm1lCg==
