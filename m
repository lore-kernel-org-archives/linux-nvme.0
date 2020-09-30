Return-Path: <SRS0=B4mB=DH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83586C4727C
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Sep 2020 00:29:00 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FD582071E
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Sep 2020 00:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QgjUk8Uu";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VdwsAMnj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="L3TXw+b/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FD582071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=qqGFIOojN+EWrW3f5C5+cMR5A4+Yw0Ji+K2y8ehyKOs=; b=QgjUk8UuXrMXhhXy7873qG2fF
	OiDgYgDBvZS2ZF7FbYyo1puNKihRycuHHJjZEuJpzAiTit/fAYKKAUqARxVyaWCaHknIdlS2ha6Xr
	vpnievuaxjLPcmF8BfJ+Ciq2l/TOFLDl98qGwJ1w7BFmk4lW9e4dG+8IsjyQxYLOA+/n7F0GaTWSo
	CN2JA+DVwli6Zpx+7SxfDe4GPHjkKUJk1HCzPzmJX/SSYA63Dl2soK3nAM/0S2TXKtDisfdvdRW99
	ZqE1y/RnCz/2YHb7ZnDjyPQJZ1aN5Mt3O6ToJnOuzV2oRFJTm11pd/vUtTlAUcUstwek9y3fk3MfJ
	RUQt/xf4w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNPzJ-00043C-PL; Wed, 30 Sep 2020 00:28:53 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNPzG-00042k-Ig
 for linux-nvme@lists.infradead.org; Wed, 30 Sep 2020 00:28:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601425731; x=1632961731;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=wRYTnTNWO7t57oFYtukHOVO6DhBTi7nri+EMKH5xp18=;
 b=VdwsAMnjIUeR0cQAj6b2X0KNcrOrLNUee1a2VCZG/Q2TdbvpO4g0Jj2B
 Emk0sH2G3ZtwbVkqm79ua/67l1MEaP2TvcMqVKqvdazN01v4oXk+AzMoA
 XrwM9sRuQmPkBO5n57zBKbYrDPnzwfmS34jMYYkK37cKOARIStg+TxT8Z
 y4eWtVXh2s74+GppmVNmMeXVsr/DT3zWqI+amt7apbJiccDs6zs+wGkGz
 Bh8aDD7d6BULgSPye/ltcoFSa7MfKaYkZ4InxiapKePjMt6szsge2wF1m
 gIDz1aLcA4XG+Zq05fYsHMP8CDa4Fpb3+d/EOjSw5t1HQ1l8XgpRG6CkE Q==;
IronPort-SDR: ZXxYzcI+lkD/PaBtVOkmwUj7RRms+OOrla9Mjk47kA1IXnbdVeE6v1t1z9PaMXiAwpP1ZAJcgM
 zeUN5PHIeZms9MYfQnOaL1/LG6U1ILsM451RdA4rHL6FwrJE0fu3o4gY+KGNDQwDlDN8LLhXZg
 nbTTWmdoxGmuCSmmgjkKjZEXsUKOXkB/0U6/jpTDUXsb7j2NKuYhqU3yZDTejyJWJuiPcNx+Dn
 n+rb9xipk4qqP0KU6zML0nN/L3SJQZL5EeURqauu1Et0hbpnzElCWBAUxFbkp8z77lwN+73UrC
 x60=
X-IronPort-AV: E=Sophos;i="5.77,320,1596470400"; d="scan'208";a="148634652"
Received: from mail-mw2nam10lp2101.outbound.protection.outlook.com (HELO
 NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.101])
 by ob1.hgst.iphmx.com with ESMTP; 30 Sep 2020 08:28:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LN2NfxZbBLdGv7Cfvl2xQaz5WXP40RadUbLD0qhGbaDV3Uu4qvAnK0ex1JqfdObzRjicQ3fe8oBhaUfpUpcIjFNPo4R583XHVYdNsr9tj7kzAfFmwA5nKyrjaVmszFfGAbrFfFHp7CWzxJEE45+xhGoeKpRwkxfmcndTtLkGiGyfptwYKOTz9F3ZxWffEYxWtPIj8ynIt/ZnZ2iMUt+1znEWcJ2Ne18Y/kAgse76F8ceoRuNHjgKpQm1xofwz+CbDMTLkczIK5mt5TW3hSvlBnKm6T76qX4yWoqShQNpaFZGxZqTSODgY6Kp7bIZpjDxl/MvoyqIEjZ0NTEJfF+7ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRYTnTNWO7t57oFYtukHOVO6DhBTi7nri+EMKH5xp18=;
 b=cxmPpmOQqbobFBEEPxe1iuwZzcH1lZAmcNybfoNmL3cmqfdWq+OSbB9mgeUPSqqe6Epq0kDJ6Rdm6iPIVIBN2dGQsSlKp4+QV4IBaR18gp/8Js0ctk5EMCp/p0F5bboJsP4rIs7hQZw9yj3vAJ0WPJYC4xo6FhTfdaKcYOUzJyjsUpVrbStY8napp2OKmcw58NM8h3LPpdH+sPnUxMziUlccL0VudjCQZBmRVVvgpX7956bsBbUpcvrCv5q6LGjMe7PcDR8cah8uXhCDAc8cEottCPAGLsYYUOBJBRAiwfKSRL5xNY/2FpivideQM6XbDGmqRPmKoCVNlsVAnCyf3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRYTnTNWO7t57oFYtukHOVO6DhBTi7nri+EMKH5xp18=;
 b=L3TXw+b/HH5WUyDj+KSaFxUJd52IrejHROpR7YMVvWen2Q5WleGnVQoDQaPYTjNG5AHVwM/rCxSZcfH2lgPVQH4dN8CGmHLpa1oEf9uqqUHsZrKulBbmbOhqZVZW/IkEWGjLpoYSmBDOrndyCuuL7q0bGHfyeLCODtWkQ6d2GBM=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6884.namprd04.prod.outlook.com (2603:10b6:a03:222::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Wed, 30 Sep
 2020 00:28:48 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::e1cb:3a58:d588:d7eb]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::e1cb:3a58:d588:d7eb%7]) with mapi id 15.20.3412.028; Wed, 30 Sep 2020
 00:28:48 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Mark Ruijter <mruijter@primelogic.nl>
Subject: Re: Exporting NVMe-oF devices read-only enforced on export from the
 NVMe-oF target.
Thread-Topic: Exporting NVMe-oF devices read-only enforced on export from the
 NVMe-oF target.
Thread-Index: AQHWllSMA3Lc493H20yf5BlML9rh4Q==
Date: Wed, 30 Sep 2020 00:28:48 +0000
Message-ID: <BYAPR04MB4965DEBF8F5F06FC026B502786330@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <BBC87AAC-A523-41F0-8CDE-38757C407C7F@primelogic.nl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: primelogic.nl; dkim=none (message not signed)
 header.d=none;primelogic.nl; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 855a724b-a957-4e6c-2190-08d864d7ccbe
x-ms-traffictypediagnostic: BY5PR04MB6884:
x-microsoft-antispam-prvs: <BY5PR04MB68842A40B50488DC5CAD796F86330@BY5PR04MB6884.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QFtgKAzOQRfYr3fX/piOA5CDTLO5U5urUz+J7xtBSm/AmToCLISljRTRbFjpB+eS0cCkEvv8I2nvtLo0X5EMuNRiOhzEzhLqEjYoA50b0jQXk+kacEO9TkfpC7YxUKAY4pqCof2VWU9BK+WHo/ut9oYt6cE2+iFyu5eNQR5wnhRSenEw+7KyC8MGnl0M7E66nUMCHXPrZzg0EvjhavUlYCI8fa/sOrAJ4kVzdz5WSsgMk5lgiCocUIAAqHBJC9AHQNhgLBEEMTU/RI49CGKp6MT/+UFmNYk1Vt3tYm0OBEuiU0QapuxJXaZCS0dS1F/7mebRzHHusbK6lbVXuHpiAA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(346002)(396003)(39850400004)(136003)(52536014)(6916009)(478600001)(9686003)(316002)(8936002)(2906002)(7696005)(4744005)(33656002)(8676002)(5660300002)(186003)(66476007)(66556008)(64756008)(66446008)(66946007)(26005)(71200400001)(4326008)(76116006)(86362001)(55016002)(6506007)(53546011);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: RNCTfelOieeIeDLpZMMmelwhbFaTT1LLB4LYbxlryyoHQmN+MEPt026bqCJpTOem4UzAzbdN99FwtoHS3FdfgeE9fVBdagVf/TYXj9DgMCg3AQVqclHrN5X8WVX3UEXtpLwEp/lI5uATDfG35rgT3mMzFiAUSl3W4gisGpeTSNOYxj7cC5XCyieL0TTHMGmMPXR8LbUEHNUJK8gLjGyFU7FSX318nLC6mK3mj83nAvmlpjqoG/i/kBQY5fHXbJ1+ytx1kM0KD53E4Yy7NEcWfW8Bc0hKv2dU6+LPPotl2YSGEJTc4Ub9ZSRW9djrrGNF/4XTW6EgVQyjigHeIzexOoV5dtMiB8eNRNhe7kdUu29QR5fPJ8BrxMzqKCDkJgEOEH5UVn2VO4xHbhYH2OLBIabyOt+kynFHraw65WV9d1HhWiFvO0hQkeetlquSVIfpTGW0j7eZIvezBl9TM+pcGfxW4Mqy9/KUdmxKMmRuV1Ay8i4SVEXTzWYTqUu958MJpFbahrMugh9PPd6rmvd00FjBVMMo9psYHZMJF3S2eqVXMSZxUflABo5EVYb97Wit6cfAiAkixOZVy3HdKryFdM/8OzEqJDO9d9p+Mx7476js6wv9fbXElC5Zn8JynhpPUSE+3N7gXsjelzf/mPB3XA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 855a724b-a957-4e6c-2190-08d864d7ccbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2020 00:28:48.7554 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AlRV4xe0hnh+hUTtXwlTSW8vlbNbpabd/cUL7cgVycTFY7qPJuVR5laWBiz3guaGwpn77mC1SnDpPKFl58Xigkl9x+YsSEhGTlbZPeeOlg8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6884
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200929_202850_766483_D95EC47D 
X-CRM114-Status: GOOD (  10.58  )
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
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/29/20 04:35, Mark Ruijter wrote:
> Unless I am mistaken the NVMe-oF target driver does currently not support to export a device read-only from the target system.
> For exporting readonly snapshot devices I am currently using the attached patch.

It does, have you tried using nvme cli with NVME_NS_WRITE_PROTECT feature ?

we have both host and core patched for read-only mode, if you find any bug

please let me know.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
