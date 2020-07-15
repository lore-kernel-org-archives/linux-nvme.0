Return-Path: <SRS0=D+H5=A2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD8CC433E2
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jul 2020 05:12:27 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9540920657
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jul 2020 05:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="xHEuKroS";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UZY2C5bd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="mHzSChvt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9540920657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=fHgvmXOu60ixFhLjA5aAqPiRX7lKUv1D2tx+NLnCznk=; b=xHEuKroSyG6uFA+WuvfuaN36f
	zMoDH9GDBBehMB9MBD81kTemubyE+fV5WzX3MnIiEmNXtWk7G59WjgMyibGDgwOR6Q8WZlXHFKloM
	OXNw8/hcH5LF0x/E5gEbvEoj6VuJ/i5XzzZCbkHUtjgbb8sz8LiCjhdiy4EWRWx2Td5MtKqSGWoQ8
	qvFPMSnZQCkmYsbqcLrzVXKO64HLSiQ9TwAq9TAsOd72HL6HJc4Oaf98T71D/Arz2Iqct2UQz5vb3
	hKbUhqE/xvoSC8+ZFpFvNz23RcnfiGWd+FUP6ec3HzAJRhc6G0Qp/EKencIN3zrE2GWFALrfALoGM
	lhuJ1r/qA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jvZiN-0004JH-Bd; Wed, 15 Jul 2020 05:12:19 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jvZiI-0004Ik-Po
 for linux-nvme@lists.infradead.org; Wed, 15 Jul 2020 05:12:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1594789935; x=1626325935;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=o9Ut+Pt7uMqInBhlzC43TRbx8NmVbetCfi4W6gF/1As=;
 b=UZY2C5bdZk/rwnxv4EGaA/yRZtF1EbcrLh3Id3gTdlYtZ1EQkExiKY3+
 zBn9JnZ3xbMTFZZvOFLeXoP/d/MsbZeZoPevOANY8iFOdT18a7crUs+zj
 iyQqj5dklrGAr7j1mdPM+Wx96iknZ+4FbZRyRd0rui4rLcTUMzA5iE0/7
 4zwroVYi56zaw2RJYt0RrFUk4bSDZTjZP6pjvgf/k6+hAosIwWrQL5VlP
 qhv8E7wE/abiejPXZejTk+pPwns0o/RpcEaXd6+LlmlLCiPqNFz8gFWPu
 kAHLTC/gxuGvHrpY0o7+rUoHW3SN7KZBwLgWMTakaJMw2R9DgrN/nQrA0 g==;
IronPort-SDR: eZloo2rHhQZzECaLGFPPl4Rxi8hAkEZPkLuqPAY91ZqPQwwuT3i4rmlMX5Qvymp7GSA1HQJb7g
 YTF4PpkjB7vkxNkbVr979TI1ryL2IFCLSbIhg2mkrzYuGhn8ZLbis3gBBe7kucGkFKQLvsYhMC
 YR520UDntEPeyDch+v9x33Pzp/Gj1wCFhFKNjznvaOr8oOzQmn/5SrFuMHGxI7s5OTvliS4QDW
 HgYNXUtGZ+8ZC0fPl2UGwt0vTU7F1AcjjXAPw7pwVQ6fhezhZH+FfMEBUonjUjzjAkQQcldzoT
 TIM=
X-IronPort-AV: E=Sophos;i="5.75,354,1589212800"; d="scan'208";a="142628701"
Received: from mail-bn8nam11lp2176.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.176])
 by ob1.hgst.iphmx.com with ESMTP; 15 Jul 2020 13:12:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EWxv5Kz/kjX6nA0avD7dG9BL6NqpePz566GolYCXRBZU1Y5KC1q2ojIxyHVo5IFBhmTAXy8I8nKr5vjJboKoUOBS5dUEOVF7znlxZ7n/fViU4paz0gBiWuWKyD+iRTvUf9o3eWmYrQ65i0Ot4IhLJ3hSQAwrX2rg0nNk4tVZPL3VdTYnoFuxqRIuRBGiI0WmnvRIIIv1Z3ih1OVIrqXVJWpqr5wnrTVbA5OaTJ+UOtkNOvIF3dFdgaawNgkd6owcDOfC4bhKw1jAtt3mPCojCiiTbhjFah1MURFZk5l/VQNOXtv/bLP7u5irSbA+/G8Uze20NZegzQKDXQSYOwdITg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8avI4bvvJ0TEqTdiHeNO7w7klrnlesBR6ukoV/9hGEU=;
 b=Sil1HKgufCoRcAJBKekYdfcjtzpN61f6JhGLkfY4mGHNd4qV45nKp6kWduMhN0x22K7W4PPxjbKURsZxVZ6JJu9qC4Y1BudOisGBjt6TxzqTJ7RQQjyS7yh/WTKckMo9iGBuXYr5Ui867tNnqKhlPJ2azfNG8Y6pyOJSuZ5um9sQZVH2Nh4IsJinkXILyxQlB41sos515kcXjOtmoxJTm6RmUxMbI1PQpizCDtU4eOKvYU0abrLsLx6VUS0UdKlQboc40/AG2h+VWWdk0ZiiRYTiPzgxP7Xh3y9ylPg5OB6lbVeFPghehHQe+wsSzWnoavKSvSY6+NmWh/yNsRD3cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8avI4bvvJ0TEqTdiHeNO7w7klrnlesBR6ukoV/9hGEU=;
 b=mHzSChvt0zx5wg6sPyMMtmsmCR5581MA/fx6j5laS6oB7MedWvlu/6DqkAlWbYCt5r/1ZP4Fk6cL/qxdaj4v0Bn4B56zngLMTvCPAlQ7Y2ynHC3i7UTDLILbvLjJjfZ7WaBCVVtOY1rsI47LXZHTqrWpAfETfexS9pvKkp1t/NY=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4133.namprd04.prod.outlook.com (2603:10b6:a02:fc::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Wed, 15 Jul
 2020 05:12:10 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4%5]) with mapi id 15.20.3195.018; Wed, 15 Jul 2020
 05:12:10 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH V3 02/10] nvme-core: use xarray for ctrl ns tracking
Thread-Topic: [PATCH V3 02/10] nvme-core: use xarray for ctrl ns tracking
Thread-Index: AQHWWjbpvpVT6MLBx0S7Lw6Gb+2uDQ==
Date: Wed, 15 Jul 2020 05:12:10 +0000
Message-ID: <BYAPR04MB4965E771089D5E5142062634867E0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200714233057.10915-1-chaitanya.kulkarni@wdc.com>
 <20200714233057.10915-3-chaitanya.kulkarni@wdc.com>
 <20200715005509.GB2772284@dhcp-10-100-145-180.wdl.wdc.com>
 <20200715013342.GD12769@casper.infradead.org>
 <20200715014151.GD2772284@dhcp-10-100-145-180.wdl.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f7ed01fd-0261-4793-6cb9-08d8287da0d7
x-ms-traffictypediagnostic: BYAPR04MB4133:
x-microsoft-antispam-prvs: <BYAPR04MB41334E075DE15FF3C064B64F867E0@BYAPR04MB4133.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +IgVTKtaW7a0J7rxjKZtCjOMhPbeckD0g1z3TbpzCBY4Wv+5xvEGEODSHsWOc0RSRfTze7m0nbFAChiwT7MGq1f9q0SwFhQpCfCahrsXuduyIiZ8VCzYLcFhFt2rKIhwcnXu/1gpeQdnsydZe9JZR/GzQMqocgIHFgYIm+K1ov4DsYGREb1p7BywxJTPdIk6XR5fMWFY2GJMwXAqB29S9EdGBMkm37dGX3RICXzL+cZ8L/SgG4zZLLZgNl4daFViF8k4rdj5l2n5EJ9KJlPWb83+lcYYmoCCq4o0ittUud6H/pxF4fOGZe+G3vTpuAZK0VI7V0GVipCeBp38FVrOxw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(5660300002)(66946007)(33656002)(76116006)(6506007)(53546011)(478600001)(186003)(66556008)(71200400001)(66446008)(64756008)(66476007)(2906002)(110136005)(54906003)(7696005)(52536014)(316002)(26005)(86362001)(55016002)(4744005)(8936002)(4326008)(8676002)(9686003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 8SCGjviGQ5PTdreZkAWjH8WtmYAAWihbVcFamw1YhVepC8zr+x3Oa8t56BYkwxCldlnolRqR/Pxj+XM9mzRlkXOBrJXSUuO+ROqmBz7UxtUvkK3pLONmiv8uN7TrK/zS1gA5P33IzYACL4XX9ck6tcQ7Atp5g9woyC8y04mCdbrXuAv34rLmfewviaHErJ9gRf8V6wxEL+wn+jtQN66Z5VIszczh1OID5xk8iNbE9etpMq24iMKsBr8fvES7IZ2+Z/K0alCd6L7rL7UJEY8tuutiwroCNTmbWsLfnw5Lomd0dezD431HnF8ZKBwHOyMmxynl8A2rH4tOCTtuGrD022g1l0NU/8NsDHmwbTEwyYx/m38PTFHmcir9fDa2CG1mIGjiT9X/L5MNl1tmXNvnBmjMCJXSqF8m3LNye1r/EqDtH/PEaP4qAJ04sDlshMQ6jWmqEROmml7WeUMnzttBVWvidK+9UK5ZVM0Fmr/E/WB3Ml8O1OfdTkNl71o5k+1c
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7ed01fd-0261-4793-6cb9-08d8287da0d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2020 05:12:10.5741 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GMnGFkT0c+9E1A4zjuFjERRw2SuwKtzElbk+xFZmrSvXZ6r+Qc92AeZM2isZ0++lIsnOqnMVBfpGdtQmVub64CTCCeBqso2LTEi3BA4QI08=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4133
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200715_011215_210182_58E57DF6 
X-CRM114-Status: UNSURE (   9.03  )
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
Cc: "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 7/14/20 6:41 PM, Keith Busch wrote:
>>> Since you're using rcu to protect the kref_get() on load, we need a
>>> synchronize_rcu() after removing it from the xarray.
>> No, synchronize_rcu() is expensive.  We should instead use call_rcu()
>> to free the ns once the refcount hits zero.
> Yeah, that is an even better option, though namespace removal is so
> infrequent that cost isn't really a concern: this function already calls
> synchronize_rcu() and syncronize_srcu().
> 

So should keep the synchronize_rcu() ?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
