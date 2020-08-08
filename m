Return-Path: <SRS0=sRvj=BS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601B2C433E0
	for <linux-nvme@archiver.kernel.org>; Sat,  8 Aug 2020 01:47:02 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FDBB2086A
	for <linux-nvme@archiver.kernel.org>; Sat,  8 Aug 2020 01:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QnNkHEuP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XDh5rbND";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ZPLjicFz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FDBB2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=WXNFGIUeGND5rUA/nKoVCID0B93fLGuPyRZpxJhVrNE=; b=QnNkHEuPTcbvcbYLV72r/DVwV
	Z+1UMDZ2ggKFzj0K/XgNcS3XohEkx0V0+XkI7agZVcwyGLzBtuLumE3nPWVhyffe6xXp2+JgSqZN1
	gldQhNfNnODsRGk+zOG+IfkLATX3UjxEpklD+0YkFpfhQ0aBc32L03OaxYwbds1D+e8AR7cKvtPue
	/GFkT4gLrRfhZyiQMA8VAiJXSL2GwnedS49O0bTTqx0aqarNrMIagj5S335Lv69bH4c3Z9EvL1ojp
	WPpJXrhWSLQr84PGf6w6qjzT4cljpiLqJ1+YIlzHOpdN+5/Vw1f974kBhiNTLU/QHf9i996QcPFkq
	RKXHjIGkw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k4Dwk-0002og-Hs; Sat, 08 Aug 2020 01:46:54 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k4Dwg-0002oK-Kw
 for linux-nvme@lists.infradead.org; Sat, 08 Aug 2020 01:46:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1596851210; x=1628387210;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=S9BC/0HqqbYU6V67QOQ5uwXIcuTPFu8AF72OF0miB4M=;
 b=XDh5rbND7fdWOfu4l4beuIOaz7oS/zpkBP0grAt6Rt5qrNyrV1K+HHmw
 fLdPrOrpetx6Z1vnD5Gc5D2FHslLMwSXae8+g7i2mkM92oBZR0BCWmsR0
 Ra++Sfnmd6JLzUaH5jJHrx8roAdUYHCDEL1hRDNjL01lINWmei+/30px+
 YYsMu9CUtlXv2gDSkbq9oeHD7qO7p2Jg/4c8NvX1NrNj4wjw71pjreof0
 s2pKb1WYFjaC+FdYUgDJvqJRgkZqzvu8nAGmjkxAlfkiynOKDTCOe9w9X
 LNmYCJgpZus2sd80/OBJ8VS6/uUqDaJl2s9D5Ek9AmWhpdq14UmPcn6qq w==;
IronPort-SDR: 4m427aD2VnD7qUXsiX3UFrlkvIbv8zW3wbEYeEnKNxPNcdIQlK9bd0HRR7UwwAdxB/bz797mWp
 JgvSHFHjgQHnq9PlLrI9SSlRV11arFIpYcyk7lljdNsrU0se5xbPZh4/7yND9PJPEtVZ3Ga8Sr
 GmssJhdqDiUypeLvxC0pv4YpbQJi+BNxkimktRE/Dd9yk9+ww361wegMiymWa+brJqaIaSppHP
 Kk2f5CtDAP6yzTPYdtL3GtmAmmsTofxp3jWTMPF1DSw7gKkd7pfGkYNU5IHv/nvd9tp01tH2OG
 Kkc=
X-IronPort-AV: E=Sophos;i="5.75,447,1589212800"; d="scan'208";a="144504120"
Received: from mail-dm6nam12lp2170.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.170])
 by ob1.hgst.iphmx.com with ESMTP; 08 Aug 2020 09:46:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QbackahJBSlCcECONYKn1YWdv77GVd6zONMYWs5jTmfJp0F4PcGt11YH1skjSRci7Zg0p5Xt05YBIEXiNwmNvonKwHB4BfoUDjAW1j/ES+bBA7B2iUNKNVVSV15Bcq+94jO0ePLCCTb4qI1NQD5iSvgo4aGvTj6OVBjCiB3n3z3T2W89Lv2AKb0xpmtwdihY5lxHIZ4YZnwsIpXAfc5pS+SO7u0G4i1J1h8h4qr9Lcs/ZduG2k6/Ec6c1UOwto3j/Xl7Mo1/ryNWVsfJUDPYJPMsr+9xxNMk/B4FlXtJutV0f0B8UQE9UoS812XVcEs+9/Qn+rn1VdqUe2rPnWdWnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9BC/0HqqbYU6V67QOQ5uwXIcuTPFu8AF72OF0miB4M=;
 b=TKnBdENCgJ/sFS68f8UgqpPJjal0lrbv4ZzaxoiejYm1btsfoESkdzDRRwLy0svoDvKmbxIL0CEXs8JzpIB1kiJHiUNlQMC3nGtWWVoYfrY0thTCK9yAtIFleXA//l2soE9cNnppuARIpTDZBLmZclHM7JMSjTDQldvrkfPua08YGp2+fB6bIHBvnkmQy6tWTZAO4IrJlVd2scP0gVTTZYQIlDyrV/8bgICghaO7Y25Pmx4xkf5ijJqkEER8QEy28EWINiKDXibfbv/GJQpnEdMF9emn4pIn/6d3wzPPkqAihUVVrpBY660apl96bwKJuEFlF6jWaSrLvj69zgosaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9BC/0HqqbYU6V67QOQ5uwXIcuTPFu8AF72OF0miB4M=;
 b=ZPLjicFzViiBiplEmPMhGmHZkyo7X4WJGdlbkw3WWZ9sJOlDBstm3kgJKCQpugQs8vsrIfOG/TaK5T2SpxFx7fBSxVro/t2V7rjjXdiU8qQXsbnlvsQ2fF1/jRQJfjModryH0S5hxr0eMaZlccvJoXWi8yyKPUUaGlJYLu5ogcs=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4661.namprd04.prod.outlook.com (2603:10b6:a03:12::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Sat, 8 Aug
 2020 01:46:43 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4%5]) with mapi id 15.20.3261.019; Sat, 8 Aug 2020
 01:46:43 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATVH V2 1/3] nvmet: add ns tear down label for pt-cmd handling
Thread-Topic: [PATVH V2 1/3] nvmet: add ns tear down label for pt-cmd handling
Thread-Index: AQHWbPE38bBY2OKRIk2R2gd3H4d0ig==
Date: Sat, 8 Aug 2020 01:46:43 +0000
Message-ID: <BYAPR04MB4965A2A0C65672EB98B4C0BA86460@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200807193026.9129-1-chaitanya.kulkarni@wdc.com>
 <20200807193026.9129-2-chaitanya.kulkarni@wdc.com>
 <e2881bed-0403-f044-2097-c75edee4fd8d@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b48e34a9-fa59-403d-069b-08d83b3ce705
x-ms-traffictypediagnostic: BYAPR04MB4661:
x-microsoft-antispam-prvs: <BYAPR04MB46619255E9C0C248CEF85A7186460@BYAPR04MB4661.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Lj/1mj7aXjrX2O92qZvWw2kGPemd5f03mTX3s7ydIjCIK/mOVS/Hf6NGelCmUjqnnFFqMVJkPfWPX5ug0Elb92jV068UT235N3SXd//VS0Itb9DM6V+egXunLrMxvJ0er2c8G1FYaQHf1XblxI0pJgfSQvGiXglmHuUDqtzt6Mk+SuSF5cdwhYB722ImfGVZUiP7DUfCjOTeKM17OOD7v5LcFhCZZ5kE4FMj+Ljc3MozPlmiOCxr9+xPisI9SfVEDGI7u+qvkQ35molZU3msLdK5SOKtEkpleOnjQYUot2Br7/T+4zrOBtGOuVI+q5o3UVMcgAlY4P5Ue1fvnCw/FA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(136003)(396003)(346002)(366004)(376002)(5660300002)(66946007)(66476007)(76116006)(55016002)(66446008)(52536014)(9686003)(8936002)(66556008)(64756008)(2906002)(558084003)(478600001)(110136005)(316002)(86362001)(54906003)(7696005)(4326008)(26005)(186003)(53546011)(6506007)(71200400001)(8676002)(33656002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 1rZjUHClnR7XifpHcvi19nAvzxzmBQtAipUgJsYN+qX5fLTn92sbKmyedhfQTx+j4+fo1vGSEzYDLPdiznXE9aHRuHKtl9P7yNB4X3Dx9ehvXhmSQMWqvUkN4Gf3koXKht2AEyz4DDplR6bTDyPAn1jZgrGxL3cznSAJVECoyUHQBnpbSUTPx3t67Tz+JX6zfVWPZ9vEhHl7kkeRoVBMfj2Vr9TGWvMMxUxcygFeQ3v55ELMwqq0ZzRKJW84DJ+E/pZcJ+ojwcv33cFWz+rVvI/00ZVqyYqgHrVAbvZWc1D3ugIB0JOA4LiwKXgKdqvdiJ3yNkX9tsj/soHpdnFb22pW3uvO4AgFZNhP2+nW762IY1kL5OyyOT3fKPFMrr01xKsff4ms7TFNzmlJkyGxNoJztL3J+OWrybMKUdqRBBJXCcahDH0rJacDEJfR0zsMXNB1TlBuK/s1LDpNIrJRLAf+L/KA5H7pY9cCZZ3JCCb5t2owZxdEYwUgD9RsHgbFNowHNQh4Smz4+7z7lc1koJoxpIaBN8cMJVMAdg6Sx9pM2oclgOHBq0r351N4bxQlZlmUFSH1Ew9JiRzgyg+5m+VUX+Pon7kJ4ezXVIm4kwaWJL1kTWbIft4CFviZ708Q+FzL7WkemTwpHug4t7Qdqg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b48e34a9-fa59-403d-069b-08d83b3ce705
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2020 01:46:43.0609 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2gP51+t2NZ+3I1fxhMcPrw6JXZSTubWmnWs3io/+qv+4ZDPCXNPWyMDTc530giFyVDHKvvrPwu/odZAehL+JDd+URXRyU70dO4DippD94M8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4661
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200807_214651_219208_1B5FEB19 
X-CRM114-Status: UNSURE (   9.89  )
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
Cc: "hch@lst.dew" <hch@lst.dew>, Logan Gunthorpe <logang@deltatee.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 8/7/20 16:29, Sagi Grimberg wrote:
> Still doesn't apply... not sure what is going on here,
> the tar.gz applies though.
> 
> You should check if your mailer mangles due to some configuration...
> 
> Queued for 5.9-rc

Ugghh I've changed anything, I'll check. Thanks for pointing this out.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
