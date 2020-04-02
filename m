Return-Path: <SRS0=DaKL=5S=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8867C43331
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Apr 2020 00:35:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 782DC2063A
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Apr 2020 00:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kJtWX2nc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IDruqjzS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="vuZyQNc/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 782DC2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=7HnIDi/owDWuo8lNJZSLZnNIlnbnJmak+e7YqAhk34Q=; b=kJtWX2ncprvRCM
	yzQqWJIiTsr7/TDLtFMnVbiR5n9pRn1Mkeqd3VtB9wH7zs9lYSso7SxaThg+jOsZiEGG2rTIfrocB
	arVUH4JEHtyLlMpX7oT4XsG7QatbIImrrtXijK+NKyfPgjrnR+0SX12hLsMuGaRUa+HW7ggRt+MTf
	tCtn79SHIOK9wemIMr4UPGD5FjsnC2s7M/Zdzb0NmgpkFvdi6+EPowa2eozU+A7WnZdcdHmjLfIOm
	elQHlD3KjWH9xj6v0zrU0TJynEwNYYyvwKXG9lGO9eb0c8UUmZCp6TE/0F2ujfv3fC2EJuMWtqg65
	yBgeyqAyKSFlG6phHzNA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jJnpb-0005vi-6B; Thu, 02 Apr 2020 00:35:39 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJnpZ-0005v2-6d
 for linux-nvme@lists.infradead.org; Thu, 02 Apr 2020 00:35:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1585787755; x=1617323755;
 h=from:to:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=SZlxIQbxYItPlACgWkieSiCk6J+ltITfsYUWbAvBCi0=;
 b=IDruqjzSZCOa/R5eK+7sQ/hc60d22BJjOiHBzH6PecYnPvetwKTAZ1Ul
 hKEj1iBpJQdKU7i1z3mIokXuaLvNuThtIRSdNgYKKTRH2vGFmi3lklekl
 GI/3asieWDFgRL6okN7cm0wA5QxCg8zMlfTNQEDtfqdgsfft/voocmZe5
 fzG47mu2LjSsc5IRqylwcnNj2UiOfhRghW30GNoZaZ4BkwuQcTTmqKIWj
 x6dXZ3eefI0LQuF8/U86IoA9dEXgwSKcaWgMgxzECTOOrFXM+nqPyTME/
 eVBqipw3gwk5GcbNWSi4z8AyTYpS1em7W+Om3GMa6Ovu10+EfvN9/PgPI w==;
IronPort-SDR: V6fFaeHn/rfAcGG0DrpJb6oEsARXeKudG+FIOEDldzWbCCz5V3mav8jMos6xAB0oDDnyjRi8Fg
 YONzgZdiIf73wE86WDytsTa/XeFejzD3x9GQQhTUl4XDVytt83Fn/Zr9wGuvDiGYOjNpA9AMAq
 v3OvHJUg0S3vZ4iuPvh4CVjW7fmpley9g2ErwUjtEv9sCMY/HA67/qiJ9VL7CLbLTq+g46kis9
 4CUT0OUDjMkh1TLOMU8sbo8SCU0kQUmMKmUAlxiWq3QHskwt1GVtQOV5P/USkwd2jll9GHbaNm
 Cds=
X-IronPort-AV: E=Sophos;i="5.72,333,1580745600"; d="scan'208";a="236642948"
Received: from mail-dm6nam12lp2170.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.170])
 by ob1.hgst.iphmx.com with ESMTP; 02 Apr 2020 08:35:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VYEM+vrWs2a98bex1Hp0VAt94mIII4MCEVGKPUcqpMbhDBBZ+D4Hy9XjG5NPZNtjKYstLQwlp8ieeei7p/wuN0hG0Mj7oyIr6G8VFvxCsi80o3vSNx0UD2OgJqUlds2LXdwl7bEKV4J/HNE65Bv+jhFsY0vRsdbTGwKsMV08YVJtPkojdPVbFoukjR/sDghOKBlcq2KAQE9UXv5vthrKa9C/f0wkfcmd0pVdtlvicBXx67CNHtlHiEduU1HOWfAU3mHqx0C1JR1WydLKCbaDFUrlZm9ScrjOKOk6MbfaCYJbIkcuJQ+lPJrmHcTPEe3o+HzRT6WJzqB2n0IZR+aoyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZlxIQbxYItPlACgWkieSiCk6J+ltITfsYUWbAvBCi0=;
 b=fGarBkm2D5tiYHhKgpnWbyMafhYpgyXeFgnm2MY3LCoG5H6+ehQ7HBXLnZsAg5psRfWGxXomJWzf5mYv1OQQlIXbFfXupoRm1d2FxCq6XGM5xRjpA+d64Hp7OcVirjMo0HfuDudm5aDHm2DNK16L4iBUflVhwbJF7vDQJzpqSF7TCAaMwHXD2HsQSKgSjnWYkhrWIMe7MA1JNNeU0FM4GZK5w75i5Dufew89dJElSLJ8AF7vaays0FRKm8uA8jv0xgwZ2je1uPPDwJ6CBmKlGuetppZTArREnGZ7TZfxSk80ZtRZxxsk7f+RZaYEwRHRAS0TsXptAc6jTTVrjhb9hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZlxIQbxYItPlACgWkieSiCk6J+ltITfsYUWbAvBCi0=;
 b=vuZyQNc/U+IOyWPewqKIUYBff4b5YM+OABZP+39ThqU4R9RwIoKLd+zl2c8HLyQc49pbhD9cnBTAxOBbUEXoZ0ecmYraAIohznk9oaoRLGErHcbpiAoyZsqVqbA/V2Q4ngW40mjZ+jZurrunSQ7GILROyduRYg3zAIJGUQ7KszY=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5191.namprd04.prod.outlook.com (2603:10b6:a03:c2::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Thu, 2 Apr
 2020 00:35:24 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::d826:82b2:764f:9733]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::d826:82b2:764f:9733%7]) with mapi id 15.20.2856.019; Thu, 2 Apr 2020
 00:35:24 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v2 2/2] fabrics: allow traddr to be host name for ip based
 transports
Thread-Topic: [PATCH v2 2/2] fabrics: allow traddr to be host name for ip
 based transports
Thread-Index: AQHWCHAPU8VGnD/XEEyl2olvX5+LWQ==
Date: Thu, 2 Apr 2020 00:35:24 +0000
Message-ID: <BYAPR04MB4965BC218D5804E42D837B8486C60@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200401215344.2519-1-sagi@grimberg.me>
 <20200401215344.2519-2-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e3064252-ad59-4dd7-acb1-08d7d69dbbfa
x-ms-traffictypediagnostic: BYAPR04MB5191:
x-microsoft-antispam-prvs: <BYAPR04MB519108AD6A90A8254D9F94D386C60@BYAPR04MB5191.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 0361212EA8
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(396003)(376002)(366004)(346002)(39860400002)(136003)(81166006)(8936002)(186003)(52536014)(26005)(316002)(2906002)(53546011)(33656002)(6506007)(7696005)(4744005)(76116006)(478600001)(66476007)(66556008)(66946007)(64756008)(66446008)(8676002)(86362001)(71200400001)(55016002)(110136005)(5660300002)(9686003)(81156014);
 DIR:OUT; SFP:1102; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2g+wgj80SHGZEKgVBcSrCpmSiekEc2mxTd+sab4oHcfgvjRm7ytBjMuYQxyyAw78GvIc7QjeRXBph1xbA5ggp3Xk2F6jnlJxwuPkmYgXCworZkDg3Ufd80lucb/644QEYbil9dHvecuEtP9CwzEZh7b6Zho5RFrz5I4Q4VbvrMDn1Vj21lN/QO5A3dLu+sHZIwtf9iJ50RpDdna1i0/7uK/Rf476LYKBxkkyxfzmjNutn21zk56Moakz9pCA2YnmQfLRiTyukpZZ+AzGgltWebrsoFCL21+iP4YGg+doYyURmYgGBlFltXBStWoxvh347YZTJIHRciTLs3AM1pB3y6GUa8NGeTeSBzyNX4+qOnfcCFpiC1/OPJrdAB9YQl3mpNfWxtQw5/BUuVtMeUiYU4ec9fVNZIVHkETdVnk7Uve3Ffg+B6LIj7Vzhc2x/PKH
x-ms-exchange-antispam-messagedata: apjPFpf6BNkWFKbBgsIoxK8xJ7SJj6sbZLFko3kfcW8AAaiaC37KJPOKM5KaebSzHhkSm3ExgsbrxJyk9UsUQ1WBijDF/A85lAjXh0qnzikpNFM4vUfp9lBdYoJFffL1DqYFGEEZwgl3gtGcKfRvfw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3064252-ad59-4dd7-acb1-08d7d69dbbfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2020 00:35:24.6842 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1F35Gjp3x7R1SDccW9iV9g1qbl0KPjXYx77oIjVcrKv4ZYfJ4cWTKwHCMudOytkaIuXUnudq5B0+8500ZMrE5jcOgybe6sDzrDZKmG+4PyU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5191
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200401_173537_282064_34381736 
X-CRM114-Status: UNSURE (   9.24  )
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

On 04/01/2020 02:54 PM, Sagi Grimberg wrote:
> Some users would like to use well known hostnames instead of remembering
> ip addresses. So, allow users to set traddr to be a host name and we will
> attempt to resolve against a DNS.
>
> This applies for IP based transports only (e.g. tcp, rdma) while fc and
> loop will ignore this distinction.
>
> Signed-off-by: Sagi Grimberg<sagi@grimberg.me>

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
