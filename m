Return-Path: <SRS0=isN7=4S=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4415C3F2C6
	for <linux-nvme@archiver.kernel.org>; Sun,  1 Mar 2020 00:40:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 716302072D
	for <linux-nvme@archiver.kernel.org>; Sun,  1 Mar 2020 00:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MEYfzqwm";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IhguE7KX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="pC2jBFcJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 716302072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=JGvAySYlbHVll55f4yVIzGavEvPhMUG4NopTCg7Ezg4=; b=MEYfzqwmcgkvnq
	AzlDATgEdrtjFx44Gb9G0CkCsAZpD4Zh8FJ9MRlJcQsFd495uSi4jUm3S2hAzKpSqqJuX6nO74YP/
	9uiSIdP9jpAIQaGQleCWZERQUw4xoHLTxC4sYnWBlZa2dKMuPd+c8em+pDbKNdtvuosVJa2cLCfME
	w9ZUoLYx/e9k5LwSXDdEAbH2XJvDlDXumeTrpIkqenR0MEgQsCxutoF2W/sv+smxgMgiXf1p6zIdo
	aQcdTvVyDJaCIwXAqsBHX7px+n+gXpO9YYA/LyJBj5Ju9FiSUWcQCx56IInt3saUCADd0qlNzC2Gy
	a8JOb/pez16rMAy4uivg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j8Ceh-00024Y-Vh; Sun, 01 Mar 2020 00:40:27 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j8Cef-00024A-9G
 for linux-nvme@lists.infradead.org; Sun, 01 Mar 2020 00:40:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1583023225; x=1614559225;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=nwXtC4nLs/XAWB6yaoP8dmMYsvrIwZrtdHQ/1AAwH84=;
 b=IhguE7KXUDdsPHo5c/Jed45lBXqM71CSA5B0wyqGORMdnCInJdsVNPMM
 SnlA/rpDru57jY1KGRwZOawnWRcZNtVg9+OZq7eWHnlQqjM+WsnewaDbD
 oVqo4N5xflW6ffhuyoMVQ6NBgxGvPN9grS50C1RrW3DZIhVDjCc6hWcvL
 lRmJuVxiX2miS5NKuVGF0AUxgeBLJUD5j3AsLOL8vIBfd+wHXNmo8+JO5
 29RyXtcwNkTV4/i1Yi4E3bZ7yQofXDDSwjBfBRB0MfCtSmEkjmCW5vWhv
 HuOTfisf83+IssKWd/UTRQOuyzV0CSesuJsn3SOtjsfEBOKs4s5wepmHH w==;
IronPort-SDR: AhjOgpcGoKPKb89XTCZCwH/XskcXs+sDWRJxt+tEeIOV8zFuQisqu2fUl4vfXu82hhKfAEKSvB
 eWZUndaQ99xzdnAmhwWomR/tU1h1ueQ/ZGVjHOJsG4dfseaoNnFACN/H8Q6gN3lPfA5WbH7k3N
 tsb8F9CaPAwv9IkEPo2uMjWPNBu/rohGWnE9Paat1soUiDOj5wVerO1InzYRGKA7gnjZ1g1GGV
 BEsK1MKdEb1t5OOqIBtjP5na+CGERwzEfSAtYeDDM/9WQtUuBh0kK/U1nJSGtwVjScDATCm2bi
 f8g=
X-IronPort-AV: E=Sophos;i="5.70,501,1574092800"; d="scan'208";a="131073379"
Received: from mail-dm6nam11lp2171.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.171])
 by ob1.hgst.iphmx.com with ESMTP; 01 Mar 2020 08:40:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IadfcV8oeItyluHb/lfB7kzwB/d9UWXXM6jBYH+DV2ruMxCAXWsY0USLynZchNo/YrbTvYqo+TLrvqppLvXRlsNlfNgQhX0q5lmFGz/qIBe8HVWuFljuLILyy5aQmOljb56a18utblX8tzltu4MPUhaLfJkTGnmEraavavI2ozHMaHCcGVjpUT8C8llUTz6f0QZpC+Bt8Oike/T44mjJ9JRHYb4fLnESQBIWq9V6NrTOWFD4TtkYqhD3ujufv0S3cwJxavBrfgMpzK4Dklc+E7fu/0oWBCwDatPXeBK9QrHNLV/z5YroIIaAPmrW36VCI8J/TwluytAcNnFXh6fcUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nwXtC4nLs/XAWB6yaoP8dmMYsvrIwZrtdHQ/1AAwH84=;
 b=oMBTea6JmPrJiUXv1eMVJD2lTAgULNla9WYPxDt3MDDZu3NefPAD8OPS+bzgWLtpuQZOASefI/b/m8zw8cTMHF8SZdVudVH5NUz1Rg7GX+GDdN1oon2m7fg/9GJcjxHaUJ2x+M10RRFt9cLjBhcutjmgUaJXBDxx9mh4MDh8pEdLrwlUggbSQyDxqkuJQmvoQHErE+0MA9Tt0qlguIBk3Xjnw27uVcX9ccBEsHbYx2kUKclsywPCVD6Ndq1OvHn3O9z80800j6rxK0n7kWFoW9NGj7cXILMBnehjMuR4fkGZ1B/MhWqTA5VOcurSeJH6nIbS71eCF0W+g3d5UaKA7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nwXtC4nLs/XAWB6yaoP8dmMYsvrIwZrtdHQ/1AAwH84=;
 b=pC2jBFcJwTVh7irbqfdt0CWxuxNG3CHgAomcMNppjAren7j7l0b44x2rm+cY/KDHd1TzLBBZfnl6MQyKdZugrCxPzVP9H38luP+wSXyGbm2c2vbuHPFyYJau4ZOmvPH8R7Nxtv97JwWTSFx9iTVtFtI3ulhII1fX/ukDz3LEsVs=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (2603:10b6:a03:106::21)
 by BYAPR04MB5096.namprd04.prod.outlook.com (2603:10b6:a03:44::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Sun, 1 Mar
 2020 00:40:21 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fdf8:bd6f:b33d:c2df]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fdf8:bd6f:b33d:c2df%3]) with mapi id 15.20.2772.019; Sun, 1 Mar 2020
 00:40:21 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Rupesh Girase <rgirase@redhat.com>, "kbusch@kernel.org" <kbusch@kernel.org>
Subject: Re: [PATCH v2] nvme: log additional message for controller status
Thread-Topic: [PATCH v2] nvme: log additional message for controller status
Thread-Index: AQHV7Y1dWrAsxArmhkyqmeIDmAHIDQ==
Date: Sun, 1 Mar 2020 00:40:21 +0000
Message-ID: <BYAPR04MB5749288EBFDEF1CF1AF8F35186E60@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <1582821926-26895-1-git-send-email-rgirase@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6368623c-a188-4530-4fc1-08d7bd791f7d
x-ms-traffictypediagnostic: BYAPR04MB5096:
x-microsoft-antispam-prvs: <BYAPR04MB5096E1DA4158AA6D6FF72B2D86E60@BYAPR04MB5096.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:222;
x-forefront-prvs: 0329B15C8A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(39860400002)(346002)(396003)(366004)(136003)(376002)(189003)(199004)(66476007)(76116006)(6506007)(5660300002)(9686003)(55016002)(66946007)(478600001)(316002)(4326008)(66556008)(64756008)(66446008)(53546011)(7696005)(110136005)(86362001)(8676002)(2906002)(81166006)(26005)(52536014)(54906003)(81156014)(71200400001)(186003)(558084003)(33656002)(8936002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB5096;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GGXw/1Smar6/ZpH790nTQ05c8rh3MUU8bb2t8Ja/lEvhJBI9RW/ZT6WomFQAo8olFGZG8npg26iAoiNuRZ71dQfHLND6oOkG1YU0S9fDcttZIyb6SBjqULZKqKIoDf3rDf4vQIrgL9jno9q16h8ZbigSE96H4RjLAkE9/BJR4Js3KweNVzg8huAmZek6/6QVufyBiXo2nFNdgBs3P7rkMC5lc2ImQCqRmg55FCczjP91i39W6To3zspTV80fApNBN2xq+eupka4Jfgrl7RsvI4OlfBwNwA/aVDlijYN6en3mxxbg9yK5HpUoAahoniTjtiFv1OniRueJsGkIfvsJu6LHO5gOk+pFhhUCYt0fleGExW+7ILmsL5ubcj2VNJY3nniP9/qFqlHrjDqKIxS8NrZiL9UWQnL189eaRQpB+0cLPNgEgRJBJa1JFsSUpCC/
x-ms-exchange-antispam-messagedata: PZzYQJD6d3dPa8H0jySqkLdVmARfeg4rLAZY/FijwxUQoC4ys2Ywn5TFxzJCoO18YJxDZaHQpOFXTGKp/dWcRg9+qQwmptrZ9tLgcPjoAdZpCSuGOJLiwCLv24FFIGcAjM+XnUPy0PixsxKdZL8/Jg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6368623c-a188-4530-4fc1-08d7bd791f7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2020 00:40:21.0884 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JttSV0DS85ra0Hj++1o5nO+ku7XWzWGVb4JRJ2dXDQXE0mEl2yaN5SyFZgQtqwD0sQAkhplvO1b+POhGuRtm6Lrj+fWiWzXavor+lVBmcaw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5096
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200229_164025_400831_7CFA279E 
X-CRM114-Status: UNSURE (   7.70  )
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
Cc: "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulakrni@wdc.com>

On 02/27/2020 08:45 AM, Rupesh Girase wrote:
> Log the controller status to know more about issue if it
> lies within kernel nvme subsytem or controller is unhealthy.
>
> Signed-off-by: Rupesh Girase<rgirase@redhat.com>


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
