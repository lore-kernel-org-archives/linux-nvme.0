Return-Path: <SRS0=f2Gy=4C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE69C352A3
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Feb 2020 01:11:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B2F220848
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Feb 2020 01:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BxWo9P1w";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iifZN5fH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="cAqnBKL/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B2F220848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=lr5MYxvmzWZ0Ge8buQRwXYIh40ENgVFX3G3ne1tFMYY=; b=BxWo9P1wE/0KHq
	DCmreB0dRcraazfNFTP4AIbx/+LAX1DOlolGM2PxdDZ7x23t1ZUsrf7cQ4TeEHiI0pr3zrjSR+SHm
	symdpw/hAv3j6qzDCIOKEdLzWqH/mUc06yiAipiZowHpGmQrxSzPuEDW1PO9k5qlAhiYk3e6Q9Tuc
	lrWOmjxpAPidYdnzb7I6NcEWyHWfxG7KTMZbJqk13q9l1an4sTRZw/A2mCWSatGLX9qWakQZ94t+h
	8CH7GgqArvakT7Bedq5ABjUQufF69/IcNvq7/+RurrsB2FTVdmkfJSiMyJMDAgY0L6Sa1ZSYcSVja
	+U6Hq3TIEb5PFSTeQaYg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j2PVl-0003Sl-PJ; Fri, 14 Feb 2020 01:11:17 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j2PVj-0003SD-3H
 for linux-nvme@lists.infradead.org; Fri, 14 Feb 2020 01:11:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1581642674; x=1613178674;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=uRgnNF37Jq70Je/AhZCAMvP8ODcn+kojEAUKt+gASfQ=;
 b=iifZN5fHt812PC3+Cz7hA8GYNJNHv5ejm6hur1JuOG4EfTS3dWLNe+dK
 Kzep//oXSGIlpnGNiQbPs7LfNaDDHXb7dGsN7yo/BdPdT5Y1WhQINUPQN
 RgHqrXDGZ8BqL/nL0A8E4Y4ZbDJry1J5bOsT8sfEojWSWzXc8WdWNh6GY
 yvsLuxFzD2g6gDWW4asM7rLYJTEzM9VCLron1U2czeDf7qoXJmqRyCRbb
 RwCORC82JXgGPPnto1H7JkQWgi46Eh+QuyKhkO9allDmx3SVNppmKK9iw
 kK5nQ3hdqSmv6kvUhu2cgTKJNQCjj+OdDknvh+visVij8xmm5w5t+i/oy w==;
IronPort-SDR: Afa8bnSlpE5jqpJBzqqXEoJAPzJhl0AV9O2gk8G8Kgol6JbE6W/iC/2TPdgsLPgd6xRJv/NmcQ
 fs8OEDnUyV8lHVtmg07EdnGFUKgLj4w080+n/qGiivsWHZnOX1w27wSq8gbcH0Vfm3nmAmaXUS
 SnN25/KCyRBZB01t3ssAeIapHRxlDlK6H3QPN2RDO4DA0+Yisqv2Um6OiR08jklXA+FL9BZ38R
 LPpW8D5ohyqp3hWgdxPGfIMfj6RokassQ6CFL9xSjXmvBnW3LT4zAOm+eUAtjhoqfEmQv+9ksf
 1RU=
X-IronPort-AV: E=Sophos;i="5.70,438,1574092800"; d="scan'208";a="237851796"
Received: from mail-dm6nam11lp2177.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.177])
 by ob1.hgst.iphmx.com with ESMTP; 14 Feb 2020 09:11:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jgGUapend04GgVJ4NBQAbwYuoCmWbNp21NPN6L/In1NWdjgcb0q1Y/gg2EzQwAwLIw44ooHHQPOH5JgO0my6CfyQ+oBR4oNgoJVX8I2luHdWM3WDmZPfylnsrzj0jbTcSAJd4vfHuciT3O4eXw96/lJPEEK3OVNRVTy3yCf/BrrQ2qpFNdO97BAcQ67rwPu3Qseq8sGbUVK555iuF8lj15KxCnA2jiHpS5SusVNgRnbo9hleYMJZURTaxCAKuvIBylsIHSe7LHPhC/xJjwh4gMjB9wKKt10LHeFJl69r7pwUH7IROpssqy22l6HSfAXhb5AYHgyEINGYEHFK24glbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDuNs1F40h4i7pLACZA52/gT/yzuIshOg3whM3eD9gE=;
 b=hxRYo8OuC39/G82VhIr2zgAoNNMIWE+Wl2XO3nzz9YzaktlW5qDOwsIBA63zTDF/Pa2wjfuwtw5sXIZ4UnJttFldP/6rZK8d+/EwvncOKw7MwW3BSvepBRDrfEd8LmEiEwodsxQp6RTyJvV/jyJ6k/d+BGQulx9FS82HnLaSv1zua12DNZsFvkB5Uw1uQ5ZdnvkbscZel4hQI09SSwQWsCa6azRz6OaGj44RzJrAZBgtwBIqYrpqFj9hijuZy2X/T3qI4vz8JflPKkfvkrpcuWkSzwD86dUWyBBIoCduLNL5+T77tVbRhELWkzXwK+MKjbyWQ3fqkM5A7d11r2TsrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDuNs1F40h4i7pLACZA52/gT/yzuIshOg3whM3eD9gE=;
 b=cAqnBKL/p0jQP1mC7gJ3ftwVID+WtiJA8AY4jbTmG0eLPRsNRUG3e7SUw4MKsJmwSV1CaLpaOhIsZVbDcP8das1RHukOseAVYQslZCMea6+vAHNxS19mUxsm0WrJyUI5jfAGPETKClTVmt/2TzCkxVBvLVngUlXFY/qSUT6MOa4=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB3848.namprd04.prod.outlook.com (52.135.215.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Fri, 14 Feb 2020 01:11:08 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f%5]) with mapi id 15.20.2707.031; Fri, 14 Feb 2020
 01:11:08 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Omar Sandoval <osandov@osandov.com>
Subject: Re: [PATCH 3/5 blktests] nvme: allow target subsys set model
Thread-Topic: [PATCH 3/5 blktests] nvme: allow target subsys set model
Thread-Index: AQHV1vv4m7siuAMmZkO3eWJXbxBdSQ==
Date: Fri, 14 Feb 2020 01:11:08 +0000
Message-ID: <BYAPR04MB57490C8BCDC4A7828807C01986150@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20200129232921.11771-1-chaitanya.kulkarni@wdc.com>
 <20200129232921.11771-4-chaitanya.kulkarni@wdc.com>
 <20200211220003.GD100751@vader>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 801a3c4a-4528-4c43-d96e-08d7b0eac622
x-ms-traffictypediagnostic: BYAPR04MB3848:
x-microsoft-antispam-prvs: <BYAPR04MB38485FECF06A15E2DCD5BF7686150@BYAPR04MB3848.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 03137AC81E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(39860400002)(136003)(366004)(376002)(396003)(199004)(189003)(5660300002)(8936002)(52536014)(55016002)(8676002)(4326008)(478600001)(81156014)(9686003)(81166006)(2906002)(4744005)(6916009)(7696005)(316002)(54906003)(53546011)(6506007)(186003)(26005)(86362001)(66556008)(66476007)(33656002)(66946007)(66446008)(76116006)(71200400001)(64756008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB3848;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4niQ71YXCsy+nu+lxKOq7WMkLlIOWNVfKTIPdEUmtdwV/cn3Kqt0stjAs+TEi9TLHCznpz0uzQdqbfXKjiks7vHGuM3f+LuTgEzeJBfx4lRhd1PR6UHLa+q1TREhgz+l69WkoyqNiJQyO8sC5mvg8gcn9x5wOU8r7aEIPnEfNdZ8k9OcG4mUhK27X4DfIJjNkLrKwkVWL/zcNLuP4de9H4xQ2xQtMhPbCYZaIm5yUOXaKdhpXZdWSGD7e79VLMurp3It7qxgE7P9wI32UjYWy8RGqSHWi4sWTRHcqEsX2digdWekPMnrca+S765nSMV1hijcRcKzF+eM3puWoMD8UhP2TmJ8707lzv05A+oz4C0jdLh1PA/kW+bYBWQDkeH87dhdgdOtDLx0cND5vjnZYXYgCS6Jp+uXlVzsGajS/66dbRBZqv3ZFOqiSdakOeqU
x-ms-exchange-antispam-messagedata: 3F9ngH6msxKlevbPIiRpxU799RhH4KIke1M2xqd6UmYHQsC+h6LtJIUqdFcysOMPKKo2dGWiFHdNy32+EufQzEFKLgZ/mwDGr7LYAiYS9l/CPZOP4YNg6UcXYIdQVG/jlz1274OyjQbWvBQBujVfKA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 801a3c4a-4528-4c43-d96e-08d7b0eac622
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2020 01:11:08.8173 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xbu2uZHTbJdHZmTh8Ysth4MQN4e+mtthjsjIF68c955s1ZybvavsgbRv9SqiCxnFBVddjXQDJu1pBlSXVH3D1QQghxSF7Kfee0U2NpVE7xU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3848
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200213_171115_150051_CAA19CAE 
X-CRM114-Status: UNSURE (   9.27  )
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
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 02/11/2020 02:00 PM, Omar Sandoval wrote:
>>   	fi
> It's not in the git diff context, but the line above is
>
> 	if [ $# -eq 5 ] && [ -f ${cfs_path}/attr_cntlid_min ]; then
>
> So if we pass 6 arguments, the cntlid arguments are ignored? These
> checks should probably be -ge
>

With the -ge change it will also print wrong skip reason for 034
I remember now I think that is the reason why kept it -eq :-

Here is with -ge :-

blktests (master) # ./check tests/nvme/033
nvme/033 (Test NVMeOF target cntlid[min|max] attributes)     [not run]
     attr_cntlid_[min|max] not found
blktests (master) # ./check tests/nvme/034
nvme/034 (Test NVMeOF target model attribute)                [not run]
     attr_cntlid_[min|max] not found

With -eq :-

blktests (master) # ./check tests/nvme/033
nvme/033 (Test NVMeOF target cntlid[min|max] attributes)     [not run]
     attr_cntlid_[min|max] not found
blktests (master) # ./check tests/nvme/034
nvme/034 (Test NVMeOF target model attribute)                [not run]
     attr_model not found








_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
