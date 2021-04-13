Return-Path: <SRS0=BJyz=JK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 071C2C433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Apr 2021 18:38:14 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57EC2613C5
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Apr 2021 18:38:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57EC2613C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=zrg9Jj70dE49fqJTv5MfCO5vENrhZUlXAmPrkVd4jWs=; b=hhxoT0YZe70+sgs33gIzG4PIE
	+kZsxxtm5ILQXOIydREHyE/wpElF0tPrrVLhyIAac0fYW0k00UatY9F0KOrzbR/XNu0DdQnOQMtne
	kyXfFFtt13aGbkC9qvNPAaaPYa9iAK3fbXuintJvrkBqCzxySUkKxf8rIGusxbwQ4pFHX6r4eeBp/
	+TAPolOKeWIHikhV20Xxnc1E6Ikrdq02QkS2VS9CB98m/iNhNAr9k37Cb9Cjw6oCJEYZNysw3MW5s
	vKUO+vWJBewUCLUtyxmdtxsnY9BJYOb044fj7Uf8apARN0HzXE9KvW1zesYh64mD4NNthp7qKNsve
	LcOntEVTA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lWNvF-00A9wX-Ex; Tue, 13 Apr 2021 18:38:01 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWNvA-00A9vc-FI
 for linux-nvme@desiato.infradead.org; Tue, 13 Apr 2021 18:37:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:References:Message-ID:Date:Subject:CC:
 To:From:Sender:Reply-To:Content-ID:Content-Description:In-Reply-To;
 bh=BmeKu/60K+kL43WU/5W+5FF7/1zpEg6N31AcmeZldf8=; b=DzL8mCSTAu+mExCNTpZWMBJlwB
 EH1yi3K8xt994sa2gO9/+vGPW0CGACHChmABfdWLC5WyMF7kXFMMuzK06y4BLm/CVg4+zmdVhCa5A
 /LVsjE1nrwoO2mmiE/mMzAZ8lhRPCwMtJL+uJQtOGmE3Nj+CoHwGTGb2KZjAZiyI4G1mdl5+nHfoa
 ChJNm0Fbj0bFM+LFaEaHqcmHPpiJPV3jSNAbwG46uKoxdi7KPU8MrH/8xiS/NC/dUK8F9sn1sKL2b
 9nMNuAUr1kqFbyQBrDqO/Qgv9+cTEjO1idx1HtqOYEPRV7mg9jIEMZkPOxkRohj4IR6E0ux40Vv5I
 cpZytNRQ==;
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWNv7-007G9L-2q
 for linux-nvme@lists.infradead.org; Tue, 13 Apr 2021 18:37:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1618339072; x=1649875072;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=BmeKu/60K+kL43WU/5W+5FF7/1zpEg6N31AcmeZldf8=;
 b=bceS77VCkKRTZK92t91Mxz1sIrx8G5mUVbzWFozPACuK/WQLI04Xy8Q+
 HIIIPucV7iZrm8mpV93/N1F/N95py15Vmr2GaeYgPcolydg7dJjde5LL3
 TDq0iZQvFgSMs76ZyovztGuGIWNpG4RQ2eTk+hu7iaKorFEKkzTBOaS25
 jjplQvaOt1SXJs2aDe6TnW/woKBpXUFKb4ZjTsDUkFx/BWisnZ1rMDAbC
 IJSjWvKVKf/gWHju3usGnQ+qF5i9aD5RkWl8iJkcVtr0UG3ha54Rnk2fd
 T3qpCx2i+cP2j1/V4dtNWqgv+Ru92F1CKUbKKW5lA2dpn43Mb58ibHYKh w==;
IronPort-SDR: wIA1KIacVeS4Hvqog9ySjbZa/cZctLWFdoYxhoaX6Tij8PqMsjrMU4IjFZJPVVMeeE4B8yw74m
 wxRH/ZWn7lhgLqRidhBwSAJ1HXg05q7/g5dFWQZ4QXSOSOauLDflQAXepKQ/6SbeZb1NEJu/oq
 yIx8arVS31WhCF6ItXZzzDDHKwdm0V2PXneRJF8jpSjWEJ3Sy1bj4vybuyFzLVwEF79CSxQ3FZ
 /nW+he5zOkd1A9M/qDefJT4zl7WTddQS/wK9lC3Y/7HliWdz0UyqzDbXE9DW7dnxH7IWtpCvKT
 UzE=
X-IronPort-AV: E=Sophos;i="5.82,220,1613404800"; d="scan'208";a="164633132"
Received: from mail-bn8nam12lp2173.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.173])
 by ob1.hgst.iphmx.com with ESMTP; 14 Apr 2021 02:36:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NxxmViz9ruRzDi9hWybooghcdapN2GSZxm+2ldjeTa5MFXh8VCwlcr+0r6zWSkJSqU8CnDd4JgbLSv4oMRDh2Pa7j8GeZcIiM0gFWhMd3iEu8rHE4qU/3GSeKejW8m+2JTDM8rKZD5JhyDOH8+O/TvMqqoV7VDL9R/FKL7nuIUzaWHNsYyUJK/ze0BqzeLsjgkB5efaNDRxX1YVyNLp3j0V3v1tqeJQ4wTNcnqxUmPw0vwXCWgdzTKQlCjcnOkJN5GIrMnglIIZ9aVrerQLALXKssi9UjMeV+Xk8Ndyac++13YwPyQZH/n6nAbcIJADAH7Z3DriimjUnGkY32Qq1kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BmeKu/60K+kL43WU/5W+5FF7/1zpEg6N31AcmeZldf8=;
 b=m7bBK3cVolLIufaR7M1n/Ydv2OzUqLrD4/Gl6oU2lFoHpIvR96jnQciep2Lx8OzjK5G0WUNWu6F0rAos64uNT+J++Spl8G5uMDVskzDYPNlvOgA10oKHaIrXG5Mj+1DWVhV8I4RkHXoQG8mSf9eOjdhy75i48c43seMwxT46Uzvdebb8OBzIl3WD6jS9gWVvUAjcrk/sJTEVmZsPUOqgTD8lcxLiLTkETkQESqvKFuJ/7KYnm0+DZOZnGxYOj+D2wXBb/LuRzDXx4uCzfIdDTLJtcbGxDKCoBDqf1LCdyLRq0dGqIDrqdUskTl48ds8jR87kvlAB2ulagLoV7oxdNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BmeKu/60K+kL43WU/5W+5FF7/1zpEg6N31AcmeZldf8=;
 b=X6jSrGMhslysk2v8S6dQWJHjttaZPvkj2bedSankuu1IBEKiMYb0X6+M4GSTB/4I8sd5c1KbHbQeFG8sdEpFYY2QSWQRTLyniiYNPnkBxGSw+GDEw6bGzWdtsthBY32rihZkCHXiU2HtNQhFR8OJskuHZN82Q3vsg9jO0cIgy54=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5831.namprd04.prod.outlook.com (2603:10b6:a03:10d::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Tue, 13 Apr
 2021 18:36:22 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 18:36:22 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>, Max Gurtovoy
 <mgurtovoy@nvidia.com>
CC: SelvaKumar S <selvakuma.s1@samsung.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "axboe@kernel.dk" <axboe@kernel.dk>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, "kch@kernel.org" <kch@kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "snitzer@redhat.com"
 <snitzer@redhat.com>, "selvajove@gmail.com" <selvajove@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "nj.shetty@samsung.com" <nj.shetty@samsung.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>, "joshi.k@samsung.com"
 <joshi.k@samsung.com>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "joshiiitr@gmail.com" <joshiiitr@gmail.com>, "hch@lst.de" <hch@lst.de>
Subject: Re: [RFC PATCH v5 0/4] add simple copy support
Thread-Topic: [RFC PATCH v5 0/4] add simple copy support
Thread-Index: AQHXByxPYjd3lKFugEyHev6iOAHEsg==
Date: Tue, 13 Apr 2021 18:36:21 +0000
Message-ID: <BYAPR04MB4965A79071C8DC9DA9D49FC8864F9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <BYAPR04MB49652982D00724001AE758C986729@BYAPR04MB4965.namprd04.prod.outlook.com>
 <5BE5E1D9-675F-4122-A845-B0A29BB74447@javigon.com>
 <c7848f1c-c2c1-6955-bf20-f413a44f9969@nvidia.com>
 <20210411192641.ya6ntxannk3gjyl5@mpHalley.localdomain>
 <3a52cc06-27ce-96a4-b180-60fc269719ba@nvidia.com>
 <20210413182558.v2lynge6aleazgbv@mpHalley.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: javigon.com; dkim=none (message not signed)
 header.d=none;javigon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 07d44658-af8d-42c8-1008-08d8feab094c
x-ms-traffictypediagnostic: BYAPR04MB5831:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB583150F9937AF4B9E369E0CB864F9@BYAPR04MB5831.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JBr7pG6TnGVl6YdKYyIZ4BhOioPkmcuNaUz7klkiqHAYb54p8fwqXp0C2DKZA/vfdfvjcED4RDCzOwkbws+aMlhcWzcZWz4tIJxrJ6bux0J0QoPhughkFKwqB29ObDMaYMlVlx1Hz1aTSnYVMnjdxkA3Z91rA4a2AVgfPhfD8FnFFnJNGtcTxmbqfeI9wV2MvXeRYKBJTVCBbwQbIxSF4XquAsi/G7TMhG3h81r/MJrliUrqmrOgZrcnvE6zmWDWCY1nP0u4gndHsJtP+5Uh5KLCqFU5zEo27NIS1jIqYfaElNJtkT+6XzyU2Z986VY498TZgZculD59Pro+33EJIZ0KhBeFWIXEio5ONCaboOLfOCjEhE8nPuQ0/dzYfmCvtmcWHe6rqm0mPrfN1CKAU8FFaoRSPBkwKDLFLL3uo7x8zLO8ExiASy3NPNjZG9NbYqTSuJbvh49tTP6FzdrRbKUP/5upo5d38VySNtfOJtQfXyKoUPoERe6bY9UYh9m3Z4NVUrSkRM35naE6o+YusMErFIMkRel1S7F+KSTD2Yy218MxXpyH8jUC1+2bHHTFWQqG9VcnnDWLRfXuAoFvXPBN8Y9vSctXyrBL3WN2HPQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39850400004)(376002)(346002)(366004)(6506007)(7696005)(55016002)(53546011)(8676002)(8936002)(110136005)(33656002)(316002)(2906002)(478600001)(54906003)(71200400001)(26005)(66446008)(86362001)(52536014)(66946007)(76116006)(122000001)(9686003)(66476007)(5660300002)(4744005)(66556008)(186003)(64756008)(7416002)(4326008)(38100700002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?M5TpDuBSP8cM9nhAeCTpefAVq13+lWPJeQs8R5A+RbOAs5J0Tz0mr9AQ4L?=
 =?iso-8859-1?Q?F81EoaDFoMJdNNkr7ssJTSRljTk9SD6tWfO8ms+E/WdWbJQy3WzM6faSPc?=
 =?iso-8859-1?Q?M2y2e1b9W+6plqeaIXJQem9/DbBL9TswHAqGtox5ldaYLjIyOIF/O8KXgF?=
 =?iso-8859-1?Q?R540QX2pWui4cDA47CfnfbFNKnnooEnBg2yy8CuZUYaUFiUdwKo/BdLbFE?=
 =?iso-8859-1?Q?XKAfCT0cFXFDEaZXWNHuV/SVThjvzjxArFy72b4AadATx0lsgpnejAJ64e?=
 =?iso-8859-1?Q?h0AsUp3+UE5FUXZBMFAawHkuybQJAjSA69dvKhMlowJnDUcCuasEAFT0Ps?=
 =?iso-8859-1?Q?wK2eDhP5Jv+gzqVwgrc+IXxqG7hiU9l2FmXL2dnYbGzZd7hWGXPTdCRxNz?=
 =?iso-8859-1?Q?uDvvnjH5PgRrAARQUWefEZDvsKyLTsi928F/KUlH93Gliy2djrYLZJx8o1?=
 =?iso-8859-1?Q?kYmQRY4UDXj4zcye2r02r3up3DabvwQcD+rz8SIo9ePgysoIEnDk5p7Zi8?=
 =?iso-8859-1?Q?Pt3G4vGI4S7pkQ1HMWllSlMCf0aKvxNN7RBeoLvQVJKmImXb2VWBzLxMGm?=
 =?iso-8859-1?Q?RCnbBDJVu3YMkLvd+Hd28Zxrqti4Z7PC8/iBWU4FLzjwoHJaHsD5MVC65d?=
 =?iso-8859-1?Q?LP04d8MBTAk5Zhmie9KrErEAmz6vAhNQ+EhXlme77VK4Zhg0XCMZQYWOvJ?=
 =?iso-8859-1?Q?tO9cJXgvNbs/sndAum7e4h/WFvyWr5kr3vKBO7bbi6hkZKUZxSa/Jml9Kl?=
 =?iso-8859-1?Q?RDyWvl0IV74VlYi7bp+77X/Xi2ywtYVLTgJiVoMafoMNZa+DVMvkhzf2XK?=
 =?iso-8859-1?Q?D2/QW8B1KBFexCLMkJ1UOml/kwrcQaJ0mfUbBYIGz1Zlp67ieLxEKkNlTn?=
 =?iso-8859-1?Q?XCDw/iytrrGmOVS+pexg5U45EE92g4875iydhZiNY9XV0Da0RiyEdcBKJK?=
 =?iso-8859-1?Q?/rnymwfJ05VRU/n7AjlbNQG2BAmRRi5D7W8K8FHaCy6O1oeQ7iEGe/Eiq1?=
 =?iso-8859-1?Q?P/itxnsIuK+AiiAGaZRWwJtBDwp9pZJMl6jAfOexbhdDPsYvZOCJfhTj9f?=
 =?iso-8859-1?Q?ncI0WhXERQG2VgTC3XGfFzja+XQX2heEgSSIFgi0cG58XGUthi/61uNTMj?=
 =?iso-8859-1?Q?zfJP3i5xqUxAvzKdSrMbvzSXEVAhd/bcOdLTW6Nu9Z7uyqfodCpitW6TJO?=
 =?iso-8859-1?Q?leJq0Z53OUHjGFi1Sya501gAYWiC/eVj5uat+372iN7UTD/vvLw4mzl+05?=
 =?iso-8859-1?Q?oM4kRSg0NaIx2EkDarpl5heJou0cu4NvQ0mFr8ZPA5suqTWnR39pu0IweP?=
 =?iso-8859-1?Q?rpsAoi8yzEno7WbF8yrpSKp/Gg2W7fDhum/pfrNT7oRabJYx0HQJT6UXkl?=
 =?iso-8859-1?Q?A+6rdS8nq5?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07d44658-af8d-42c8-1008-08d8feab094c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2021 18:36:21.9379 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aQk3lW+pLtNEJaw5UIPu+n5AFE/A8oQRNwDjAjm6oHMAyu0LP9WmDOsb68NccbHEFTRPO9hMVwBDlSjMkOBsdMPgv/Qe81f99GpO9FE2oXM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5831
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210413_113753_240404_B93A4BA5 
X-CRM114-Status: GOOD (  13.49  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 4/13/21 11:26, Javier Gonz=E1lez wrote:
>>> I believe there is space for extensions to simple copy. But given the
>>> experience with XCOPY, I can imagine that changes will be incremental,
>>> based on very specific use cases.
>>>
>>> I think getting support upstream and bringing deployed cases is a very
>>> good start.
>> Copying data (files) within the controller/subsystem from ns_A to ns_B =

>> using NVMf will reduce network BW and memory BW in the host server.
>>
>> This feature is well known and the use case is well known.
> Definitely.
>

I've a working code for nvmet for simple copy, I'm waiting to resolve
the host interface for REQ_OP_COPY so I can post it with this series.

Let me know if someone wants to collaborate offline on that.

IMHO we first need to sort out the host side interface which is
a challenge for years and it is not that easy to get it right
based on the history.



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
