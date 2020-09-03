Return-Path: <SRS0=8iPx=CM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D60C433E9
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Sep 2020 18:35:30 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE48B208C7
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Sep 2020 18:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Fa5QuEiZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="riRDBSoC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="F5yfTyBx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE48B208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=jMeQfDDHSxHlqtHE6CpO09TKy5J0rLJAwrOs7fdOKQs=; b=Fa5QuEiZsMXOU80FFPdesOENg
	JTU9WexZBo42QZEiuxOYuJtRdF9BIX6xoywsGWg9W08tUYIakStubvpVzsUEhLTkZBMlp5IAjDcnz
	sFL9WEe2YQvX+jp4QEowfsYqfPw0ADt8fH0gQwkULtwjzZjS6JWSSnrPWci+QuRRVhFClOjjiOyBY
	szcSoLMRLIlJwLZMrddUK5jBkjpXtuGVF7mNtXNOG4LqDRz2+o9yLhnoxs26xOMlXVJbQtq1zxGvS
	iDBW+IXiqFMs8YMhxn8s0+le/Kox955x2IlNWOwVaFn3DR3bRvNtpDLNPWKmyiLz5jyIlrluzzKas
	YSmXvc38A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kDu50-0000Ty-AR; Thu, 03 Sep 2020 18:35:26 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kDu4y-0000Sy-59
 for linux-nvme@lists.infradead.org; Thu, 03 Sep 2020 18:35:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1599158124; x=1630694124;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=hNefQotPYocyFc8qpiJwYkppfNt4XTwk4U3wL+lJFaw=;
 b=riRDBSoC6mWJBnMPppyHmC097xmbECoAduQy75U3VBJgUhopdqGwwDaz
 SqBPVKp4qooHxkrt9vWDxf9CUYesstdGlLCYm7hRYk+pnAnwMkL38vk2f
 N/HFGkX8teZ+X+QW+kfEgg4Hi9NKHSCh+BmzrGAhcmfyYRu4gI5jfWdv1
 3k+NXA+aZ/Mx25aBI3eV8qyb/uCNw5wFYgW3iJytX5UAK1gvjZ0VdrTFK
 434vWOomTKCICaO3Tljaws6fcH/1RB/ypxRYIpkinXM0JhdItsaFU90yP
 4SUVDoogToqkqLEELAbdZhKzM/2Ar0pnjDAa+IPut5uenrpefKM41rZuJ w==;
IronPort-SDR: mjUhSZp72cLakbfi+/jraXQqjV3wkPpLnkpcFUm6u5n21Ts7r/49Ev/4J8fa6AKZCMZZNAriGM
 focUYyGcyQHpM2E8Rex1PJMcCECgL+kLKlY8/gK9lJBWI8ADJP+jnyXIziJBS3sg6XMkdwLhbb
 zGjOYb10L+J9GCJU6658ylLD1Hrx0iI1pUJ0oDfuzpoxsfOv3vi3fUR8XyG/JqqujMLwqBSH7k
 pED45HL6KKIo234MadKnnzrwQ0YjKoTR3ABG3bup/XUvcim607MZCH2LnXUFwD0AjKSRT8Wlyr
 MRU=
X-IronPort-AV: E=Sophos;i="5.76,387,1592841600"; d="scan'208";a="150869487"
Received: from mail-bn8nam11lp2174.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.174])
 by ob1.hgst.iphmx.com with ESMTP; 04 Sep 2020 02:35:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cFXWcsxaTfNZwQR0zX8bawQ70ZNAMsYKUUMCa/ccAwIi0iMsarm0v8zTvvFj6pJra0qHS/6rZMQ9yRFLD7W0MEabtsLzEA8Ppk0JFkCu4z7GZ2rydUKfInUXN0Mefzi7GE4E3MzHQg7MUp0RdtHepPDLjlRsG36xVGDNVzSHyJn21ksImGSVphFxz0+4DgMyQwsfmQ5GBimZe/NY5uAFFKUsQXkMhB4hxgZMLXRePN2buZWvu9JSQZZiV6TiPTYmotAg/G1Bkv1OwWvSc3m864MMSuWlHQyYcqBOsYQ33lm1OGC4r7YunNhM+bc3fVwKYxetD48U4yY/VL0qJVrBYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3kuxzj1hsuhCW9mylwHJ26ibT9C+X1sskov7TGupgb0=;
 b=U4yBs6M+vyezT0idvzGdwJpgGG+6dXXNtx+f5wflc/hwUdqQPNxwgOBIFqVBjMbLPS4IyNFzsD1iJS5zRybRZx78tIZ6jVIHeEzolfcKHFASIRhhUQpJOhiKJO9pE7/47xPvs0Q+wB4UNzq0wtatpgcCO3aG+T2fuTqFO63Tn3zNkS2SO7A44RokBEX/IgH04LKOaZ79NadlGjZxiywKwMgqahF0G+ZQOcNu+18InrrxnwIFpzunJ3ijHIr1qPHiAND5n4Atsi/5wbG185junysKJ9xK7lGVhKrsafzpHTmyNbhADU5BZYFQvsVuZD5KzuXMpCwBCh75EP95Sy8c3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3kuxzj1hsuhCW9mylwHJ26ibT9C+X1sskov7TGupgb0=;
 b=F5yfTyBxbXC/eTogUsPSo5z8NdipuXRr6F0TGlZmzN0s4ptJVIdwHjDS805e/4/kAcHVhKHRzg+zGntuSlSTZsoM040oR0uqVCc95UaIAztUqm3BVyeukfAyoKON6vSAHDX6WCZ/mzatyP5D+b6c8sRAaUqgm+LdwCPAX7+R1zg=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5029.namprd04.prod.outlook.com (2603:10b6:a03:48::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.21; Thu, 3 Sep
 2020 18:35:20 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f%5]) with mapi id 15.20.3348.016; Thu, 3 Sep 2020
 18:35:20 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V2 04/12] nvmet: use consistent type for op_flag
Thread-Topic: [PATCH V2 04/12] nvmet: use consistent type for op_flag
Thread-Index: AQHWf+Xsb3DA237+gkOde1Bx2ZqYGw==
Date: Thu, 3 Sep 2020 18:35:19 +0000
Message-ID: <BYAPR04MB4965F7BAD5E9715388F2B48F862C0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200831222707.35611-1-chaitanya.kulkarni@wdc.com>
 <20200831222707.35611-5-chaitanya.kulkarni@wdc.com>
 <20200903162017.GC25423@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0fa0155f-2577-4abc-a1cc-08d850381c8e
x-ms-traffictypediagnostic: BYAPR04MB5029:
x-microsoft-antispam-prvs: <BYAPR04MB5029658E057ED826DC712D1E862C0@BYAPR04MB5029.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CM1MsM2LqhWkXr8ex+FK8UK0TGXbYQgVKnU634GU7062jlnKH7eFvzsRzZBVexzoj1n3KyD07OyxB0RF62bCWE1zeEdJB9BLSfciT6lVR5BZSN6whgvpTuz/UEfjxwOdKY/gAOC43d6o/FfN7aTgDVQgFQ0VeYmKn8wcNBNM/TqyU2Rhhe8cwkXLh+9sScomXKPfHKf5bq3qdxVQ3ddaAxvp1/9pnF3BKCXq2Z/EriWHNH0gj4iVo/wXmT4+dq5aYWa0e3sGSWjJuD6WT7qPdINd+mnJ2PlsyIQICziSTJrARha9UTAAM+gaIQRXFk3b
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(86362001)(54906003)(52536014)(71200400001)(6916009)(2906002)(5660300002)(66946007)(55016002)(66476007)(316002)(8936002)(9686003)(64756008)(66556008)(66446008)(76116006)(558084003)(8676002)(7696005)(4326008)(186003)(33656002)(478600001)(26005)(53546011)(6506007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: ufVnqy0JYRHn55X5cIwM3lMNBcdz/CPCAvMz4mWVo9F+oJoCZKwsgNzPvlRiQzrSYnVgY9CZif7dZXp4VfZ273IsrzD0KfVK1YSJqIRg5prdk6FgOQbaeGTlwDVIS8TaawRcCam1rD712aQR73Bbo/zuoSV5tSqriw0z8QWFEijI+W/qk8VTULy0hbKGC9glWdB7nc7IvLOusP+RM72vJpBETk7Tv21UjNQYlGlZ/14aUPEBQQQQdjJmbmfYg0XsOMZSKvI18KUrsrkd/gMfD3YZlGtp6rXzvSy2QqALJLPXDAZd988rgaxQAmHszi3sqPT169xPn9qG1SK7wBMrf2rn0qmU44kR8EJGBvs9KF8XnvMoTGy/vhuuvmYENHVuRsgGC8wAXw6svb/Oz+Dx1VJBxEtv6IlGyQDsXwOKqS0Q9mFpE0mnZ9S8SyjMMVNyjsgOwNJMdfDepXt/Z0+yG83xBwt7fS+TiUYYFq/WfJgQCcmP/j4kuElvL0lVVMi01Hr+xzIj45J4uzvpozxZ6qOQa76S2UJxdWxKvTdJbfwkNAyZwyd5opxKSTt9u6mvV58Ua4KkTRoDWZUBz5np3hbXBtYrQeKMgFWpoBhrU5qjeKev1oxQqmJk6nqRsSaJTY+r/zxwy2GQ5bRo6ypsKA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fa0155f-2577-4abc-a1cc-08d850381c8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2020 18:35:19.8666 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: APLYmyKzxAKZcmVMegrGsXehLKmnXaNe41wXpDZHkbHgTKxO4e6nPyCSFyctdpJHpc/yfKnJ5EgRPtzZN+KMxyhgcWLGY4qOYwZrCH00x9Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5029
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200903_143524_342309_3A26555E 
X-CRM114-Status: GOOD (  10.74  )
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

On 9/3/20 09:20, Christoph Hellwig wrote:
> Actually all the op_flags used here are bogus and have no meaning for
> passthrough commands.  So the right fix is to remove op_flags entirely.
> 
Okay.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
