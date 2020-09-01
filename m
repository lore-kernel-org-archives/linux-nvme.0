Return-Path: <SRS0=Ap99=CK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F10C433E6
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Sep 2020 21:18:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45A9120767
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Sep 2020 21:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LphdOcoN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oJcbF9Pm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Q+OBy9T8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45A9120767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=1YpEFLfH3hEc4DJnphL9wsZS+0CGAVeprGXiFVKroYY=; b=LphdOcoNrYym3VfTQJCj9/mLO
	S63w2urIMJfInXm4iMihMmn0i2SjeiA1nV24o5NTNapA6+vOLO77bTTxGhjiDDtq2oVKsuaJCmoIj
	KmjJS+9dOpAvTrdv3YZz38tnrx4ITZn/qro8drCxuBxp36STZ6O8X3gougPER/wT709uEh8oRurcG
	8EUlQEk1F3f4IpHg9rgnCkHEEfpjWkqK3wmPk4iBIdsi02Q0Js6ZKu5VXMglpitYJ6yCf7WDWfGML
	wX+hKphouavzMEG/GbbKJ1Y99AASvMe2nYv1Hoxou+YzRozdx3OhsolS1DPJuU5tE78p8I59vx1kG
	h2z9MCm8g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kDDfJ-0004QN-Bf; Tue, 01 Sep 2020 21:18:05 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kDDfG-0004Pu-Pp
 for linux-nvme@lists.infradead.org; Tue, 01 Sep 2020 21:18:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1598995083; x=1630531083;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=V2bFTWMHqAJOAfmwcy/e0de9FxowA3q2L/NrMCzAcq8=;
 b=oJcbF9PmzXXEvQQ5VloLVOXaUNFqCSYqJoZrTGJwMtjjaZ6uYas6ade8
 Rf8BcIVAXuBW8YK9KD7ZEnSLgUKaVHTzyNAs9h7EMUCKRMRxQi/fIPkL3
 ty3tw2Fzb2ynoNWbUKtCBoofXVJ+AC9SBglkUeCFAgmGqn2oE8JzO9LVL
 QQpGXKoWiygvmGSAffYRGFlUg0XrMBI9OmDSyPlsp9LW5nDxKp8xXN3e0
 r6hKe6o018F0SczebxmeAzulx5EKAO06AEKQwU9txy/4seR4LVVAoP5Ag
 5lQHBVMYozx3LrF18sY+VwfFsZ487TF0Q/elJg72J2fyCjHOFcUiQyzv4 g==;
IronPort-SDR: psR0qb5CDBcqAk4eI/I23WNL2nMQWTnfX4UYb0AePYgEKvGXNSRyCZGGAIHzaAXWeOhCB5Hfip
 1mIDsT9ALNyS75Fa56f0SNM43cYDqNd5Nj6VM8awSJd/LcwTmjVxnfft1DbuX9c5+e5ENHLMqa
 LE/3w4ZRH4I5c6m7ExlTmJWxC0Hb8i8H7MgLcHxhk+I30PX2tZYdx1Z2EJKNxsc5QA0TOXSK+p
 kgzUwt54acsPD0aT75Du4TzVRb72WG9/PMq0B4uzknfLRAmYdc+BjN7tRXZ7b+JEthZ54UjNkZ
 f7c=
X-IronPort-AV: E=Sophos;i="5.76,380,1592841600"; d="scan'208";a="147577861"
Received: from mail-dm6nam10lp2104.outbound.protection.outlook.com (HELO
 NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.104])
 by ob1.hgst.iphmx.com with ESMTP; 02 Sep 2020 05:17:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EcXgvgYXXFsH3eeXnVj9eO4dNHzs3b8NhwPyHP9M87Xgp6MTiiQa8n5EHRQk/MN3+LSxCsJeqScvqXsPi/UN9ELMhv3/UpqVPtwkNuECF5bs2QdrWkZjp9s6ds/wU0OSfRBT1A3rnqyG0F/HmwoWsNS6bM8XaTfhSfaEvh9hHHWtv5Zpe4Rm/J7+FB04OAP5/hpjqfzZ1pcbQwq2w7t1KBBZB0YKbDQ9vYRoZ/AmlllNSfqLd+2yK8PkCkaLi3XZBKU8rAZXhqGCiUynqOvFd+Oj0ld5VdeCnDCV1E6m9XfrrQmw0w8gbSFg89Mr/nVa8ljy9sXbtona9IrUFT91eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2bFTWMHqAJOAfmwcy/e0de9FxowA3q2L/NrMCzAcq8=;
 b=K8P4+bo0oltcn5UOvm5h43YHKPKCBP/+X+qNSsVgJIGzgV2lsoyb6DHY+fAQGh1HmvMwEqAnCgedPj0C63GGOPZ54ENL/hRbZ5c2ThQSMAYdDfdGtElvBhBc2WQdfz3ckdiDbsMEZ62asexjVRDjIre0aVCXzbK8mCVCt6AiPCst6FecT/aDEcC0qy7cwprap1JDXO1qO/kxJVJOb2mzJpdoGJ10sgpjKoLxIENFGuWvKgQkFzFdIz5b7PkJu43M+cmhxPuPRSdO8vrSmOc8gNt5MANMpjtPMNhb1M31UMflQ7U0pcMEL1LJrfQeXQxivel8d7hDL0VgdViIFLR4Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2bFTWMHqAJOAfmwcy/e0de9FxowA3q2L/NrMCzAcq8=;
 b=Q+OBy9T8ipqmyDYHau1U/gQWq9rCHZA/pRBF592gxsACGIiC6yqtLZBQvKXHEei0NwDztCtap0e2NwRagXoIKEARzEyEnTyfFDTLwU72/yW47Q5A1v8DtuZ9BjJkOwkFDTepsMPk0sLw9HDrTstm1m9iWtqNVv0HvzZsiZwdAcw=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6690.namprd04.prod.outlook.com (2603:10b6:a03:22c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Tue, 1 Sep
 2020 21:17:45 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f%5]) with mapi id 15.20.3326.025; Tue, 1 Sep 2020
 21:17:45 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH V2 03/12] nvmet: use consistent type with id->nlbaf
Thread-Topic: [PATCH V2 03/12] nvmet: use consistent type with id->nlbaf
Thread-Index: AQHWf+Xp3/A8kVR6/E6WXJgZSPyG+A==
Date: Tue, 1 Sep 2020 21:17:45 +0000
Message-ID: <BYAPR04MB4965C6CFC808F34EFAD4B44E862E0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200831222707.35611-1-chaitanya.kulkarni@wdc.com>
 <20200831222707.35611-4-chaitanya.kulkarni@wdc.com>
 <20200901155557.GB2831246@dhcp-10-100-145-180.wdl.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6b90c843-bf3c-4cfe-db36-08d84ebc787f
x-ms-traffictypediagnostic: BY5PR04MB6690:
x-microsoft-antispam-prvs: <BY5PR04MB6690D9E569257BFBEF4BF5B5862E0@BY5PR04MB6690.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MF+yCd3RSEcujGwv9XnfDai5kBoJvYvU8Y3d5Zt3vm9KcEyPczwE1aOUAbUVahZl3/Xt1oY9CrjAKozX9dhUG0vLkpL7EUNbHyoHNGIFUp0jcRxdiuWT8Mo9J8mMUAkclsIJazDAxvOGrqzXXXZyRv5nckQVXAKRV++S2FBFZ9NQhFw0ICfgRgkebNLLvBmHPAWtl2hjFPtNAh5ufQhCThtEgg4DW7TwFAZSLzjn16HFLOJ+zd/3ed0xAQXbG1NP43wKuJTS6bDa+TrU8un/CNsBGLMRHK/vuzzGMoYI6a/B4Vw2lhIkYlOv/jVbqmXv
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39860400002)(396003)(366004)(136003)(9686003)(7696005)(33656002)(8936002)(4326008)(316002)(55016002)(54906003)(66476007)(66446008)(64756008)(86362001)(76116006)(66946007)(2906002)(66556008)(71200400001)(5660300002)(83380400001)(26005)(52536014)(53546011)(4744005)(6916009)(186003)(6506007)(478600001)(8676002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: YILxtzpmt/Tt1MxUYa24I9XMmUv8nKXvy5/HUi7qX5FeT9QHr0qvT+IfmbPcwfCwm5U91JQbWZyP18IaLzEEMASYEF+HX4oS/TS6+XuZH/hdmk8gMzmXQpeZYVOrEfJntUnd/LAhVogha4ZINEcWDj7Kdvc1Ybrh87R6qGOPcoeMAt0A1acB2LBvuYPb/QqJsN3a7ZfsPR2ceWnqdGRUHxk4gw4+21WJUbvwVI7aw4yEDrn7TB60nPjnlS4YzzQN1kw8MKqaVop3xv53a+MdfjXq1a7i2dg98zhaGFJ1nrJpGDed6rAiZi3mcgcl+mmhd6fuHcYqPnDnHGHcXumh0cw0SdxvwdTm4lXL3YYpP/DBXjL66sPeuP+m+Q20qgP1kpHAexUqvZZG6W8Vc7/yF1ZAHedkdpytmVLOXraYcHAe7J+cK9Z8SO77UEuhHPyHt+591OdLAKvT3hyCaqBcHs4glsbZ9LSrCW/LF//YPfqy/+XN5fcg3fQYLhnRgLilz9pLQLR7NMCp8IaGyMrD5pa/Mh4a7BsKV55aA26pYJoRab/BSeS7pgsPhoxKgwI6RjI+pcfAzRyafJmSNmpNsBD3HhaxDc2YorGnooJh6t8ITm6GUbyYW8by78CPIF6hCNX1rpVbbWq3wfUI7IYzeQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b90c843-bf3c-4cfe-db36-08d84ebc787f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2020 21:17:45.3489 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R2KypdVQs0fD3U75BL1K05PWGq7QvPS9njoFyBP3y4p8zsroVTQZqOShp8ZfMAi3TqdtMOa1cmOgQY7M6G/g5pm59W3IYH9REVJhdfDf+i0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6690
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200901_171802_947701_D39E2139 
X-CRM114-Status: GOOD (  14.32  )
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
Cc: "logang@deltatee.com" <logang@deltatee.com>, "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/1/20 08:56, Keith Busch wrote:
> On Mon, Aug 31, 2020 at 03:26:58PM -0700, Chaitanya Kulkarni wrote:
>> In function nvmet_passthru_override_id_ns() while iterating
>> over namespace lba format loop variable is declared as int that is
>> inconsistent with the id->nlbaf type which is u8.
>>
>> Make loop variable of the same type as id->nlbaf.
> The loop is id->nlbaf + 1, so it'd overflow if the nlbaf value is the max
> u8. Sure, it doesn't get that large today, but they're always trying to
> make it bigger. And there's really nothing wrong with counting for loops
> with 'int i' anyway.
> 

In past when ppl run proprietary static checker it has generated
warnings for such cases.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
