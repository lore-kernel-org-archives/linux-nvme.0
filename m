Return-Path: <SRS0=yUYt=43=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A45EC10DCE
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Mar 2020 20:43:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F06A420663
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Mar 2020 20:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rxb6zj3M";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="h35er1Zq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="wYIUavKw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F06A420663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=dxDHIbk72NPbxbauiXlO7VG0nsd/cPmvk0A1S80t4Q8=; b=rxb6zj3M0atxOf
	CJXS2cNfEsS7I8/SbtPCcPVDfEWmgpPgCU2wg34CYIGpvLmTxIPKxoBxnac5rkSYelRUvmLJzWbyQ
	nX7afJCOabguJxCJT6kL2mUb7ik0zc+NGDYvBKL6RMQkZmTaZc609uEn/Fb3QfduqHM9JDlcd18WU
	CD6rM4EtSEeMT/W9UBcwRj7A9bHxlbXSo4ft4QpYH0rjL5wmaZeNCnsXAqLwC7rODt0MbgCe6PM4x
	lu8hI+lIVFUt91cLP8JRxjJE+SZxUnfOrIYA+joP8wzaLEBO29+qe1T7jU7J+ssHUydS7snkIMA98
	PxRh/7MrSCENeTyxNZow==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jBliX-0005et-ED; Tue, 10 Mar 2020 20:43:09 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jBliU-0005eE-Nd
 for linux-nvme@lists.infradead.org; Tue, 10 Mar 2020 20:43:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1583872986; x=1615408986;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=FEVpmxd/+wvTwAl22iTxTdkA+GHNh1SAjBxSQ9oG3us=;
 b=h35er1ZqMSBJZ6nNNexZEls4lEVvYxIY5gPaE0Mfikn/Cr1jkLz3f3Ou
 dIMKcREWWxILqjNrWQWU03TM7qbsostTlaAEbFq7vpQAofm/h1i/l7Ceg
 w9zK84pC+UI7ozj6An6BWYuPle6fEdx0J056KWXBAsDDIFuzv2OgXoFfz
 dOnkoMN0OiaX5HyLpJT34clkjvc3NJDbuBk3/Mr6Qfh3jm7EP0RkSUxsi
 M8GBq6AB8iqAkHXVKb9YxJv1GvcVplJa5NV2L21g9ud6w6OUmONU4urY2
 1/+c3okiWlRgJMGAFGzOlX5bB9B1czrpQQaZAa74y8hKh+sihcK/tDLgv A==;
IronPort-SDR: B6577zcVdgULU4gjPVerccj+aS1SjzDRKBoH1VoiQgjTonwkfsdkNaUqA8TM2/LSuTW7BaRsG1
 0E0FmBQfmOfv2D2JhiEwa3eP7E2K0DlYRY/7qJubJSGtJI0G89qS9o8M8/w/9rDcyCNshauFah
 AbO1ReptUpBT1ItkfPszS0+SL3XKi1DPWE21WGsWBW5s8TrB/4494K803EGTJ9A/O6bGzCwsS6
 5XKtxXdRAMkefHkrfVBZBv0/QDFOneFG+u19mUuiMrTlPZYauIzJA+o7Bzdf4dzza6VhA5xK7W
 RRg=
X-IronPort-AV: E=Sophos;i="5.70,538,1574092800"; d="scan'208";a="132095142"
Received: from mail-dm6nam11lp2176.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.176])
 by ob1.hgst.iphmx.com with ESMTP; 11 Mar 2020 04:43:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jg4qNHfVpuWnCmK4LXu1x+EYZnwLPWI6TqZJDPv35mertHKDe04ZCMe3MZBswVZT47GyswC8ugi46MPiePScYI9zNuGkhFRlkXq3UyiSr364xKzMP6NNnY5MhMR0DH6My/B7J0+iOd9UeEaDiw9cZZHhnG1itj59Z3fjFjMiYppIfDd3/JIGFIM2PsSOR7lOhFr/uQ9MUJwmxQStUrnwGvad8UhqgeVCoqbPUkRPI8wNdEUpn3itJE1ZcuEwAeNv9ojAO8ztc571vvoh3byF2rEYxVeepUWMWr7o+3h3c03lKiatqTjMaVLGQqCzUZSjtnkeOr4qN1XkClbEuacprA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6WaCUMPHB9niEv1gjGUpAfVjJoPqxHduhg78H9z8ybs=;
 b=FkXRduFUughUTuUmub0jhQAj8/eBiLQBgO1bE7p+hCsLM/22+sITFFG4um8rbp+guoY/4XpRnR1l/smrbaTRMIWGc4ZGYleHRZlvS6e0eSWXg7llM/S/Tmk5muQsgtWrgdN7cjGztmYHjejOwnh54VoL74n0Y0OVHt0qqmyssln+WoHuIgW0n3Zpd54wPTnTU21okJ0hm88iD6ThHj0VWRqxq8EEbeswslh52u+okIAzi7VUQGszjmcF4PgGCmc08Dw9da1TTiL66gsqTCZ1lcqbDqM+bWjwv5lfDo2NhFfT0F4/I0cycHQnPVFMDb6HMD5+A895Ql3/rEU3HWZaYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6WaCUMPHB9niEv1gjGUpAfVjJoPqxHduhg78H9z8ybs=;
 b=wYIUavKwil8P9OYikQvereENmGObqLQMtW2YioJgwcB+0WdACoFVQIkDIwQ0o9u+fDNhZdb1FdoL+LQf1N3E8yIZ44e4Xq3dFumy1yLmQVN13vHZtjcALP3fAGxP4hMyg8w+XKc8/MVkq9UNNtYSGx81yDT4hyAeTTTeAql2UvY=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (2603:10b6:a03:106::21)
 by BYAPR04MB5320.namprd04.prod.outlook.com (2603:10b6:a03:c6::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Tue, 10 Mar
 2020 20:43:02 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fdf8:bd6f:b33d:c2df]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fdf8:bd6f:b33d:c2df%3]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 20:43:02 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@infradead.org>
Subject: Re: I/O performance with block sizes > 128k
Thread-Topic: I/O performance with block sizes > 128k
Thread-Index: AQHV9lyi6y6wLPHzKUu8uao8F8tl0g==
Date: Tue, 10 Mar 2020 20:43:01 +0000
Message-ID: <BYAPR04MB574963D335A868B36A0B4F1486FF0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <321f0a4b-8a75-8cae-2d77-34ad712225d3@oracle.com>
 <20200310170818.GA28008@infradead.org>
 <20200310194421.GB17237@redsun51.ssa.fujisawa.hgst.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b7220538-edce-4761-73de-08d7c533a055
x-ms-traffictypediagnostic: BYAPR04MB5320:
x-microsoft-antispam-prvs: <BYAPR04MB5320A2D126ADE50FE4B344AF86FF0@BYAPR04MB5320.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 033857D0BD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(39860400002)(376002)(396003)(136003)(346002)(199004)(189003)(8676002)(71200400001)(478600001)(8936002)(7696005)(86362001)(52536014)(81156014)(81166006)(33656002)(316002)(2906002)(4744005)(66446008)(54906003)(76116006)(26005)(66476007)(6506007)(53546011)(66946007)(64756008)(55016002)(5660300002)(186003)(9686003)(66556008)(110136005)(4326008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB5320;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r/IYztwM9WH2xYOH8d5wGjvw4vNAS9KGd0DOUyq7gzTyoepHK//sGu/CXcxCjMpv+vuEVeF2NO6sZd10b7i+VuI+cFm5IBtxIEmQ5pMuidPvqX18kz4OSbUC8rbitZEA0QLr5cJmwTjyorPeaiBSAZ+HdjwOjm46ZbeTm4uMHpbXGIuGycbnU8zdfEDCSAyIyfOuKf3f5iCe7LsSsBxiivZs9T9aoPpSFMIX8xpG21QwOZPaaosilCtwcjK9Q+HX+mRvH7O2HW1pCPZXhhyqyMXYpYmiygpdLOQdgflt5dqGSOgcJhPs5bmAqWsz0ccNK2IE6MKgXYyS7bm2QwdG8X9u6IbBFkKTp0lVhfsaThDVxtXMJWeRWMBBpis9Fg5waJGvxJkf3zUjF/vq2ny0knE+pQ+HH0fscvcqUEm346ororIMCwS9go1wSYPk7Oni
x-ms-exchange-antispam-messagedata: sEs9+ytzxOxe0fR+1le5K/Irgt6PIIeJYhk+08Sq25MGMduSETfy1xIPjnlC13yCbt3SMXeEWsU5duM+4gpGDpupr65SrVErHNAPeDcEd2HWjAXyaCjcfGjTdkeMsk5l7RTwK8DFPnewHLhMtJMSTA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7220538-edce-4761-73de-08d7c533a055
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2020 20:43:01.8524 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m5CI7exP3fAo5jaWWMqe6pbpVGF6IpKrvHHVFKgJLKaTYFRw7mTH4w7QssdlAYFkJu2N5czfrZbCAhn1KySQxY+wnco6sDqH5eM7YuuOJv8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5320
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200310_134306_812521_2BBD11A3 
X-CRM114-Status: GOOD (  10.23  )
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
Cc: Bijan Mottahedeh <bijan.mottahedeh@oracle.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 03/10/2020 12:44 PM, Keith Busch wrote:
>> >Try using a controller with SGL support.  NVMe PRP unfortunately are
>> >a completely brain dead scheme once you use non-tiny I/O sizes (
>> >and actually really painful even for those for other reasons).
> SGL would really help if you have phyiscal continuity, and never needs
> to allocate from the dma pools. If most pages in the transfer are not
> physically contiguous, though, PRP is still more memory efficient. But
> yes, the PRP format is ... unique.:)
>

When we added SGL support I remember having ~5% increase with the 
controller which was supporting SGLs with fio block size > 32K, also 
there was performance drop when SGL is used for block size < 32k
(i.e. 4k,8k,16k).

Maybe it is worth taking numbers on the controller with varying block
size with PRPs vs SGLs (4k, 8k, 16k, 32k, 64k) with just random-read to 
avoid any gc effect ?

> FWIW, I couldn't measure a performance drop on real hardware comparing
> the large pool vs the small one.


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
