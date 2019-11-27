Return-Path: <SRS0=HRbs=ZT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3521DC432C0
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Nov 2019 19:22:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ACFC20665
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Nov 2019 19:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dGRcEAGe";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=netapp.onmicrosoft.com header.i=@netapp.onmicrosoft.com header.b="cwnBjraw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ACFC20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netapp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=n2BYPE1GgVVRGGhbSSv1VGRVPN7yIjJJu2hUZjMloXo=; b=dGRcEAGeMwfLLz
	YKYLujWHoJrsOy3+dmLmZE9Pp+wbdpHyd0dclWogwOFnXH1hrXNiocPkkJvS0Z0azvOo9EPvSVbo6
	m7u99lyujCwE0JPqBb9xrsu99XGdHdQUwoeckRL8wpG9AFN7cCsHKx5dgek6kyZTB8Hu6KuRI9hys
	C1YeAs/LCJQ2bcXXhe2rff2yx0vJWkRqO9dirkk07wGZfRuEUC6CCxYNc8xKcajLSnf4Dmd+Db4Pw
	n6PzEBSqTVm6zUm1iKX7tIVJVjy6sckAX2C9Ja4SEAROIRXv90zpb319NRPTavl+YuL25X0NTlpYG
	9CaB7zHLvLTctiWqsh+A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ia2tM-0000Lx-BI; Wed, 27 Nov 2019 19:22:24 +0000
Received: from mail-dm3nam03on0607.outbound.protection.outlook.com
 ([2a01:111:f400:fe49::607]
 helo=NAM03-DM3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ia2tJ-0000LL-Cb
 for linux-nvme@lists.infradead.org; Wed, 27 Nov 2019 19:22:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RF8lJXiyiFgMpno/flpyMoHN1w8SVpzsrpsY2Qj3SuYXdFUYlRTxTWXTEvntycX9cmblwyqhxPbeVwOjXQkDFk+At4Mn+73MHWy1l5W6E0Jb6sHB4vMnTVWOFu27Yii/CEjS9zYXFceRRCGkpOJdlykHD4fIse4SylqLJ69mF+v+/AZ28xtuO+NtUZxS7gC6uZM4KXhiMhyw3fOQ1ZX5Kbmcyda4B5V0HN1ept4hOBLD4XWjtPtV0efG+s4R94Ou6bOZr27qV1Vwafl97WPRvHftZnu+vCH7jlYuV9VI57o6YoM27K+evCxLkq0iOD51caGkoguCegtcKV7tT8DUSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/gaW25E+GpTNTORVhrHTeLMuYkGHmn85IrHVdZNzns=;
 b=e/8Y2u+yEY/Fx1adaxqJSEDLyi0RdgzN8Nt1FHYLugw/9WoprSQt36HoKwuha88AokFx3rXXis8iV+ZV7jn+BAe1wWis1MmIqzk1QJ3qxZNqwAXZKOP060ofSF//4YQHYRi4FpUtDD7GkR1/62oUIeRYl+wmwbvG4FsqEoRTva/DXHt4hs+6+SFi8gYonQUaPuwh2GvBG7dWPGqWrQG30xy2TB5qNcqsfVUw6BgWsAUbgwFtBfe+WZ/7/hFqETCh6NmqDCoN4nfpYfD4W0ocq2JtxFQJ6hdD+PZZCrsTsFRbZV0UNYlOqjXnTtgRSyZo2rnYSWK643jZGQwFDR0ltA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector1-netapp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/gaW25E+GpTNTORVhrHTeLMuYkGHmn85IrHVdZNzns=;
 b=cwnBjrawrGYAIS3f/HqwY9D5wZ+oLYpkb2ntNy+UVn+qwmnaGv0ZYbOeg9vbWfBtQXn5aE+f2b5W/VTEO0GyEaMmQL8oN1g9tpILQv3f/n04pWVg/uz+iHURif4WG8MPfQWDJf7Pv8b3icFIg+G0zjSL6F1Uu6snmhKEz17Oncg=
Received: from BN8PR06MB6115.namprd06.prod.outlook.com (20.178.216.139) by
 BN8PR06MB6257.namprd06.prod.outlook.com (20.178.214.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.19; Wed, 27 Nov 2019 19:22:18 +0000
Received: from BN8PR06MB6115.namprd06.prod.outlook.com
 ([fe80::6923:8e28:8cc8:6c99]) by BN8PR06MB6115.namprd06.prod.outlook.com
 ([fe80::6923:8e28:8cc8:6c99%5]) with mapi id 15.20.2474.023; Wed, 27 Nov 2019
 19:22:18 +0000
From: "Meneghini, John" <John.Meneghini@netapp.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: Add support for ACRE Command Interrupted status
Thread-Topic: [PATCH] nvme: Add support for ACRE Command Interrupted status
Thread-Index: AQHVpF6Ymda5HHf+tUmLPGNyVZkab6ednfwAgAAFJgCAAS9bgIAAkQSA//+v5oA=
Date: Wed, 27 Nov 2019 19:22:18 +0000
Message-ID: <4106A22B-FA00-43A6-A18B-74DB15E8CAAD@netapp.com>
References: <20191126133650.72196-1-hare@suse.de>
 <20191126160546.GA2906@redsun51.ssa.fujisawa.hgst.com>
 <20191126162412.GA7663@lst.de>
 <AC3DED38-491E-4778-88E0-DEC84031A115@netapp.com>
 <20191127190859.GA2050@redsun51.ssa.fujisawa.hgst.com>
In-Reply-To: <20191127190859.GA2050@redsun51.ssa.fujisawa.hgst.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.1e.0.191013
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=John.Meneghini@netapp.com; 
x-originating-ip: [216.240.30.25]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8e9f4285-f0f0-46f7-3259-08d7736f1e67
x-ms-traffictypediagnostic: BN8PR06MB6257:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR06MB6257ECA262AFD6BE37D1CC8DE4440@BN8PR06MB6257.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 023495660C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(39860400002)(366004)(396003)(376002)(136003)(189003)(199004)(6916009)(6436002)(58126008)(3846002)(107886003)(6116002)(6486002)(6246003)(33656002)(14454004)(54906003)(6512007)(25786009)(36756003)(2906002)(316002)(478600001)(66066001)(256004)(446003)(2616005)(11346002)(64756008)(229853002)(76176011)(305945005)(102836004)(6506007)(53546011)(186003)(71190400001)(71200400001)(26005)(8676002)(81156014)(8936002)(81166006)(66446008)(5660300002)(66556008)(99286004)(4744005)(4326008)(66946007)(66476007)(76116006)(86362001)(91956017)(7736002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN8PR06MB6257;
 H:BN8PR06MB6115.namprd06.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: netapp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RtVNeER5QfDPBLHlhDP4FZAmBxPqGJcOwW4tyfdsBc41bZHSbm0T7Pr7rsnXaivG7CJIQhN1tQfcDQFgG8nLWEtU/9uFb2skcMPASUe5ImVokRthXch0swDdXf68j1FMdMYZ7Ed6GINoqGvWEExBhVxD2sFy16YVt3OtqYnpH11zUpjVYRLoYZppCoVeLBg45qN7i79e7d2bu+zxSAWaZhLZ8V0/8TKyNcELUCTQLeGd/NLbfN281xw4TzfeI3l3p/IPWrj+1mVGeZW9xSGU5+1uBHxQ9aMVDpgY5BBHrnBneCO5vWwoyGcWKqMWk7C0UNEKi9gzVU5a7UCYoi/NNlFm3v0xGtPk5mk8FvCitPS6UtqE0cSMn97xLPPz+Fg6lZTSFa5qGUMlnH3dkmVawyHH1WWMG/Yut2vpEyk2MZWyEKuwaDTy7T10sc9TYap7
Content-ID: <38988DBF72EEC743B7460A1ED1EA5E93@namprd06.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e9f4285-f0f0-46f7-3259-08d7736f1e67
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2019 19:22:18.3698 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: apY4fB8tyUkk1E2rYbjVs1LiqQKVnivqLO49+8czorXlZW4nq/FcIKo4GRwwu4pTf6fMwcU78IiCE2N38pRpkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR06MB6257
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191127_112221_426129_591DD86E 
X-CRM114-Status: UNSURE (   9.55  )
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
Cc: Jen Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>, "Knight, 
 Frederick" <Frederick.Knight@netapp.com>, "Meneghini,
 John" <John.Meneghini@netapp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 11/27/19, 2:09 PM, "Keith Busch" <kbusch@kernel.org> wrote:
    >> It wasn't my intention to turn NVME_SC_CMD_INTERRUPTED into non-path related error.
    >> The goal was to make the command retry after CDR on the same controller.  So why
    >> does this patch change the meaning of BLK_STS_RESOURCE?
    
    > What I meant by a "non-path error" is that those types of errors for
    > nvme go through the "normal" requeuing that checks CRD. The failover
    > requeuing does not check CRD. But thinking again, I don't see why the
    > failover side can't also be CRD aware.

Yes, the failover side can be CRD aware, but I don't see the point in failing
over to a different path when CRD is set.  As you said, this isn't a pathing
error.  

We can argue about whether the command is retried on the current controller
or a different controller, but CRD must be observed before the command is retried.

Agreed?

/John

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
