Return-Path: <SRS0=/IAj=27=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0025C282DD
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jan 2020 21:13:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D754205F4
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jan 2020 21:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EuIWr+z4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="iKYkxfg1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D754205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6HgQArEQJzvuLrb7d/8OTbPdOLRcYlhktoFHtpKVH5s=; b=EuIWr+z4WQvttk
	dpv6dLu7+DyDocKNTaINBo07JB7rVUv1tP4kfkf5AT9DqxuCSflBQs6QZkgJ7SdfQN49I98D5q+xj
	T/fO/9vz5Efu1mbnMKCtmeqHk4gmJTRV6i5lTU2KquCqqGOF6WKeMmUEYNMCqjTm7yilMTfYHa1D0
	TMMslrshCpj6I0dqeuNjqITr36QU8U0fH0hy5A2X1Cu1/KaDVYddpYbEaP/qS7h8gfhnDtwhEDD/V
	1CYbh32nXChIiVrcxeG9grTH6KxU6BQ3JWc4yhJe7HToDKScMezduCfYVXQd9sbEEkNYC6/QhMTWT
	CFEInYjdVthwbvoyp2Ew==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iq1av-00073Q-7S; Fri, 10 Jan 2020 21:13:25 +0000
Received: from mga09.intel.com ([134.134.136.24])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iq1as-00072N-2l
 for linux-nvme@lists.infradead.org; Fri, 10 Jan 2020 21:13:23 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 10 Jan 2020 13:13:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,418,1571727600"; d="scan'208";a="272523215"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
 by FMSMGA003.fm.intel.com with ESMTP; 10 Jan 2020 13:13:18 -0800
Received: from orsmsx116.amr.corp.intel.com (10.22.240.14) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 10 Jan 2020 13:13:17 -0800
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX116.amr.corp.intel.com (10.22.240.14) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 10 Jan 2020 13:13:17 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 10 Jan 2020 13:13:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LvPC/2rnlqD5GPsTMKWt7g3Rk5wpDEnROv226npA9CDkiFdIe1n0epb4mphr+y2deA6WeP2im1V7x+cZ9vbtZrcy62knf90eVElrnZmLnrOWZ0kR2KfdFAtyTlYGWpnubnUWBXjPtaaQTt09zRQyv5sSFw6g/Md3f9zzpGasnYZ1Gqfz1hnnIt8rWLGHYoiB+MCn3+f1P55JhksmubO/sQyxRmItsg91CC0QoGzdTY7QRoVPYFk8A74Fbtx/5gJQTULoMH/QsiYOoDG8VbVagghVvqVyThg/ZyqUpQzmnqSeITpTCov7rfcJCp6JQGHDdqryEFfg+aToDvHeS5WGMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJQeKqo9XifkDZea01j5NjqOgWswk8PbS+XGGrLxA6I=;
 b=hDEdT2d5CgROhHmC4tyUvfa5ZfR56zZTv/lctZ8k8B4gGG0NJQmE9CwfvVsB7vakL5d8kPnI1TT+y8QxA6BCd0QqPLUeHzSVZejlJwbF1yZ9ZF/cXKnHtfSMveaNp6ThHeMxylZ0S5VMbNXPSiTcc+ywVvtHpn+QfngO5svCF006zTqCwDHvgNAI5MW72heEPLkcyxW316brvWfr6nsNbisv7zj1u+KIBFErO4M55Z9wALRYkll+fLEqQ2aTNVSgANB8/ftAp3aCX2145U1Mej8iKIeiUk9CVGJgzuvtnYHr4oeEc4L6vXj0N3+XPj/AnxR3h5s3gZB9ElSbNjbbUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJQeKqo9XifkDZea01j5NjqOgWswk8PbS+XGGrLxA6I=;
 b=iKYkxfg1S/BD0xD0an16Zkft/LGqgyYKKXmspiT/UT+BtDygF3UP/uXpVPelvMh3sSbZ0NPN+v8meoaLX93ohCe4TBcaTtqFNCQ4OOvz8nPPeWk5KfgmCr64b3FZfgN26DfpY0pttOa8cMk1C2i7S3BWVU4lFNKAIpBj3FvDGCg=
Received: from BYAPR11MB2712.namprd11.prod.outlook.com (52.135.223.141) by
 BYAPR11MB2839.namprd11.prod.outlook.com (52.135.228.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Fri, 10 Jan 2020 21:13:16 +0000
Received: from BYAPR11MB2712.namprd11.prod.outlook.com
 ([fe80::13e:c076:124d:1db9]) by BYAPR11MB2712.namprd11.prod.outlook.com
 ([fe80::13e:c076:124d:1db9%2]) with mapi id 15.20.2623.013; Fri, 10 Jan 2020
 21:13:16 +0000
From: "Wunderlich, Mark" <mark.wunderlich@intel.com>
To: Keith Busch <kbusch@kernel.org>
Subject: RE: Page fault on branch nvme-5.6
Thread-Topic: Page fault on branch nvme-5.6
Thread-Index: AdXH6IazhWB7YrruQzSy63A2Yr2BUAAAwMQAAAOf5lA=
Date: Fri, 10 Jan 2020 21:13:16 +0000
Message-ID: <BYAPR11MB27126042E6F03D04F3988BE1E5380@BYAPR11MB2712.namprd11.prod.outlook.com>
References: <BYAPR11MB271291B9322BFF44486E5673E5380@BYAPR11MB2712.namprd11.prod.outlook.com>
 <20200110192412.GA1041950@chuupie.wdl.wdc.com>
In-Reply-To: <20200110192412.GA1041950@chuupie.wdl.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mark.wunderlich@intel.com; 
x-originating-ip: [134.134.136.209]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 299852ce-339c-44bb-492b-08d79611e8e9
x-ms-traffictypediagnostic: BYAPR11MB2839:
x-microsoft-antispam-prvs: <BYAPR11MB2839D45001133F4472838209E5380@BYAPR11MB2839.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02788FF38E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(346002)(39860400002)(136003)(366004)(376002)(199004)(189003)(33656002)(316002)(26005)(81156014)(81166006)(66476007)(55016002)(6916009)(66446008)(558084003)(66556008)(5660300002)(6506007)(7696005)(186003)(64756008)(9686003)(8676002)(71200400001)(2906002)(4326008)(8936002)(52536014)(76116006)(86362001)(478600001)(66946007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR11MB2839;
 H:BYAPR11MB2712.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HVk/wS9AxoZrDvZhTVIydV8zPg9cPQ/6z6uZeghWhlQOsnFqgaMkq9AB3jZNyqzJCm0Qct6jVh+4e1Gn8ZKCZPGqr6Ot1WjOqUjes6cxLxm/k/yx7gYcUNx2OPgqhn0xoUVPcBwu7cPkelUEMdqqMsQypZFK2CfMV3bq0zgsE5sv6UjB+/EAAF3gMjBT1aQIKLwTUoszMjaHpEMh7Mf7tC/BugSptFzKPEkK22RYzeAFVN2kWUbDhbKw3O/5FR3sRfXrwQtBEpR4iFY0RJNW/unkYWzuIVhy4N8WlTkdlpdjnHqDD8s8N77Opzm40lv4msjO05pqRYp7H7YiZsTkbZWjhFAfcTzXfB8i0PbJH7Nei2J2gLisKYXLknXUUbe0xqufpqkMPCmJ9qweT/0BLGjdZtTTHJMXBErPzpEe5IgEA/lQ8jF1iYiTw3LwC3lp
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 299852ce-339c-44bb-492b-08d79611e8e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2020 21:13:16.1418 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2jt9s1rao5PLyawwqW1lrMPaj1XPrgk1wRBnoJYECTcXHgKmG/c+errK/ZLwPyjVGC8b4NT59sx+4jzjE1tXiCHudhC+A7zCuDclLvkvtxE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2839
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200110_131322_226861_BCA42340 
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
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Thanks for the notice. Looks like I've used a bad baseline to start the
> 5.6 nvme series. I'll find a more suitable starting point and push this branch back out.a

Thanks Keith,
I stepped back to 5.5-rc and do not see the PF there.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
