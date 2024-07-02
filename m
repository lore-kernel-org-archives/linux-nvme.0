Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09D8EC3064D
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jul 2024 12:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=viku0a4H/gCWGYS0xOyoQ3+zs7R7D9MWP54xl7K33i0=; b=1aHck/u4N4CdAUgqGr5619gB1k
	x+dkbANGLrVip6sZVQ2NEvLkSkTz+PuhDE4TMdEZfrcRg0/oZUVAcabWAshSEj8uTp0Q/lf0QYAgh
	uVdfhhbyAx8K03OQnxXIjH29k8AP62OJa/nuO33tNQKaj9HA+W5csXVi2o93DPqaYhH3KembFTOZk
	nYu/T54XvL02kD27JRN7AN5/zuy8xfjfcZ1W8KnU27T0btt8PHmx8Um7doL/H+f6Ll3sxhaggEAxI
	QsAojkp3nLKT9Jw4Vgvjt8BIp5za1xzvBKoVzjiHpwzAgIeb9dT2EYt/zAgkfh5Oo5FyaC62vSn09
	ybdUvXfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOcV1-00000006eY6-47VH;
	Tue, 02 Jul 2024 12:20:43 +0000
Received: from rcdn-iport-6.cisco.com ([173.37.86.77])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOcUx-00000006eXb-18Cb
	for linux-nvme@lists.infradead.org;
	Tue, 02 Jul 2024 12:20:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=2481; q=dns/txt; s=iport;
  t=1719922839; x=1721132439;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=viku0a4H/gCWGYS0xOyoQ3+zs7R7D9MWP54xl7K33i0=;
  b=UzIu6G1VgKpPfMSwdEns0CnDvM/zJb4dMsM/yu1sx2+jk5K3yrGciw6Z
   eshDnfJS9YFbnZeArtBxoKgOTSRHdkIYWzeryztfjjBQzluhE+ntMpfAZ
   Y2NCo6Ar05RQ31XzfF97bz+TEpJyyGT2onI7q34lll1zTHxc4RPVtsEws
   0=;
X-CSE-ConnectionGUID: DrE3ULBZRHyUHfmUAZ3Tqw==
X-CSE-MsgGUID: y3KWwJZoQiuQMFrn/spU4g==
X-IPAS-Result: =?us-ascii?q?A0ADAACV74NmmJxdJa1aGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQCWBGAMBAQEBCwGBcVJ6gR5IiCEDhS2IbgOeDYElA1YPAQEBD?=
 =?us-ascii?q?QEBLhYEAQGFBgKJDQImNgcOAQIEAQEBAQMCAwEBAQEBAQEBAQUBAQUBAQECA?=
 =?us-ascii?q?QcFFAEBAQEBAQEBHhkFDhAnhgGGXQEBAQEDAREoPwwEAgEIEQQBAQEeECcKH?=
 =?us-ascii?q?QgCBAENBQgagl6CZQMBoAkBgUACiih4gTSBAYIYBd4AgUgBiDABhV4ehEAnG?=
 =?us-ascii?q?4FJRIEVQoJoPoEZgyyEE4IvBJZBgm8GBAUGDoIlggtXDgGCZU6BcFZ/JgtCC?=
 =?us-ascii?q?U4CAgIHAotzVHscA1khAhEBVRMXCz4dAhYDGxQEMA8JCyYpBjkCEgwGBgZZN?=
 =?us-ascii?q?AkEIwMIBANCAyBxEQMEGgQLB3eBcYE0BBNHgTeJbAyDLSmBSyeBDIMOS2yEA?=
 =?us-ascii?q?oFrDGGIBGKBD4E+gWIBS4MASoR6HUADC209NRQbBQSBNQWsaYJyODU4Cy+Ve?=
 =?us-ascii?q?q9LCoQTmUCIJxeqOZhnIKhBAgQCBAUCDwEBBoFuByyBW3AVgyJSGQ+OOs5Ce?=
 =?us-ascii?q?DsCBwsBAQMJimoBAQ?=
IronPort-PHdr: A9a23:KAnxVhwj2WVIo9XXCzMXngc9DxPP8539OgoTr50/hK0LK+Ko/o/pO
 wrU4vA+xFPKXICO8/tfkKKWqKHvX2Uc/IyM+G4Pap1CVhIJyI0WkgUsDdTDCBjTJ//xZCt8F
 8NHBxd+53/uCUFOA47lYkHK5Hi77DocABL6YA5pPOPoAqbZjt+80Ka5/JiAKwlNjSC2NKt7N
 w7+7R2ErMQUjIB+Yqow0U7PpX1FOqxakGhpPlmU2R3746+N
IronPort-Data: A9a23:HMwdFq47W+cev5C5SNxUmAxRtCHHchMFZxGqfqrLsTDasY5as4F+v
 mBJWTzUafbcN2ahfNx+a9/kpksBu8KEyNIxTQtsqChkZn8b8sCt6fZ1gavT04J+CuWZESqLO
 u1HMoGowPgcFyKa+1H0dOC88BGQ7InQLpLkEunIJyttcgFtTSYlmHpLlvUw6mJSqYDR7zil5
 5Wq8qUzBHf/g2Qoaj1MsfrZwP9SlK2aVA0w7wRWic9j5Dcyp1FNZLoDKKe4KWfPQ4U8NoaSW
 +bZwbilyXjS9hErB8nNuu6TnpoiG+O60aCm0xK6aoD66vRwjnVaPpUTaJLwXXxqZwChxLid/
 jniWauYEm/FNoWU8AgUvoIx/ytWZcWq85efSZSzXFD6I0DuKxPRL/tS4E4eEZc1odtTK1N01
 e0lCD4IUzmx3N6v3+fuIgVsrpxLwMjDJogTvDRryivUSKtgSpHYSKKM7thdtNsyrpkRRrCFO
 IxIMnw2MUqojx5nYj/7DLo6gP2vm2HXeDxDo1XTrq0yi4TW5FYrjuawboqFKrRmQ+1ExWWnu
 UD0+F34Hyg/GsaZjiGdzy6j07qncSTTA99KS+biqZaGmma7wm0VFQ1TU0W+rNG9i1WiQJReL
 UIO8yYjpKR081akJuQRRDWiq3KC+xUbQdcVTqsx6RqGzezf5APx6nU4oiBpRMYL7/ISbw4Q9
 k60v93sOBVd64GMVifInluLlg+aNS8QJG4EQCYLSwoZ/tXuyL3faDqRFr6P94br17XI9SHM/
 tyckMQpa1wuYSMjza63+xXMhCih48WPRQ8u7QKRVWWghu+YWGJHT9L1gbQ4xa8cRGp8crVnl
 CNe8yR5xLtSZaxhbATXHI0w8EiBvp5pygH0j191BIUG/D+w4XOldo04yGghfRY5bppcIGS4O
 R+7VeZtCHl7YSXCgUhfPtzZNijW5fG8fTgYfqmON4MVM8IZmPGvpXg3Ox74M5/RfLgEyvxnZ
 szBLq5A/F4RCL9sy3KtVvwB3LowjiE4ziW7eHwI50rP7FZqX1bMEe1tGALXNogRtfrYyC2Lq
 Iw3H5XRlH1ivBjWP3O/HXg7dw5adBDWxPne9qRqSwJ0ClA+QDB+U6aNm9vMueVNxsxoqwsBx
 VnkMmdww1vkjnqBIgKPAk2Popu2NXqjhRrX5RARAGs=
IronPort-HdrOrdr: A9a23:OdQ6AakpEpTD6Rb3px/uoxgNunPpDfNjiWdD5ihNYBxZY6Wkfp
 +V7ZcmPE7P6Ar5BktApTnZAtj/fZq9z/JICYl4B8bFYOCUghrYEGgE1/qs/9SAIVyzygcz79
 YbT0ETMqyVMbE+t7eE3ODaKadv/DDkytHUuQ629R4EJm8aCdAE0+46MHfmLqQcfng+OXNNLu
 vm2iMxnUvZRZ14VLXdOlA1G8L4i5ngkpXgbRQaBxghxjWvoFqTgoLSIlyz5DtbdylA74sD3A
 H+/jAR4J/Nj9iLjjvnk0PD5ZVfn9XsjvFZAtaXt8QTIjLwzi61eYVIQdS5zXAIidDqzGxvvM
 jHoh8mMcg2wWjWZHuJrRzk3BSl+Coy6kXl1USTjRLY0I/ErXMBeoh8bLBiA1/kAnkbzZZBOW
 VwriSkXq9sfFb9deLGloH1vl9R5xKJSDEZ4J4uZjRkIPgjgflq3M0iFIc/KuZbIMo8g7pXS9
 VGHYXS4u1bfkidaG2ctm5zwMa0VnB2BRueRFMe0/blmAS+sUoJhnfw/vZv1kso5dY4Ud1J9u
 7EOqNnmPVHSdIXd7t0AKMETdGsAmLATBrQOCbKSG6XWZ0vKjbIsdr68b817OaldNgBy4Yzgo
 3IVBdduXQpc0zjBMWS1NlA8wzLQm+6QTPxo/suraRRq/n5Xv7mICeDQFchn4+ppOgeGNTSX7
 KpNJdfE5bYXB3T8EZyrnrDsrVpWA0juZcuy6QGsnq107f2FrE=
X-Talos-CUID: 9a23:C0FZkW0FTDEN1yNCd69X4LxfNtoIKUD55kXqA16FKWhsdZSnEmOJ5/Yx
X-Talos-MUID: 9a23:ugD8ggVjced8YiXq/C63pw59FvVv2qWzMWUji5NBoNG5aSMlbg==
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-core-5.cisco.com ([173.37.93.156])
  by rcdn-iport-6.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 12:20:33 +0000
Received: from alln-opgw-1.cisco.com (alln-opgw-1.cisco.com [173.37.147.229])
	by rcdn-core-5.cisco.com (8.15.2/8.15.2) with ESMTPS id 462CKXl3014462
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nvme@lists.infradead.org>; Tue, 2 Jul 2024 12:20:33 GMT
X-CSE-ConnectionGUID: 237vNt9gRi2QAO7+5TM59A==
X-CSE-MsgGUID: mynI8mdURfGWUP1G4ma+gA==
Authentication-Results: alln-opgw-1.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=ltroup@cisco.com; dmarc=pass (p=reject dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.09,178,1716249600"; 
   d="scan'208";a="32296617"
Received: from mail-bn8nam04lp2044.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.44])
  by alln-opgw-1.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 12:20:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BlpW4741s1aKBmoY+NNFRPNMU78E9r8sNSoAxKG2LG66ax0KnRWPz2QHhepXPTPXdKwD+H5s6IxK7Ckb0EQjcgTe7ukmYRbFxglROsQkLiO7aYYrvhwhpN/kZvvGqX8RVeFBW4K2Ga5lycG99Rd2B1eAafEKPMyFa3S94msNl45ksAuzpwPCgNFQW/MrPciBrHtDwhSO50kjTvfTcVCciU79JF4mdl27NV4Sh7e2zBI/gaG8Bzb4OG77DSA/Obd2jKoEwwc2aT7jxfjxQ8BfWLLnRkdoTi4eX8zWfk4JAULGWjYPonSIF89+2O+uZPyJod7SPjtV68KV8gjyqTA9eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=viku0a4H/gCWGYS0xOyoQ3+zs7R7D9MWP54xl7K33i0=;
 b=EFrcMEicqy3i5F0pN5z2Qgi/3n3mDFOvKDXjDt2HtDj+ny+oIhxW0vXgQygtARuPTscOcRQcQrZPJ3O6XR2kIRo6K1AZdI2kbYqN47AbvmHbyqhTcpgzMbF27oecSvVwHRGxvpVPZrvZexHbeHqN2suxuK9O+/fF63+OHpf7L03ANb6PCe6Qw+/dPG/l/r6F1cVhLe6MaJTtYkVZ/8gndlLHQgXFxwE3aBAeM+eQ7qlg8IfnCOMpup/rdoNAHdxv3HrCLg5HNzaRfbAXFbX54gjnZAX49lQzFefEJnuXtvijl3F0rBmtO0VBoqCI1brSjWel+fwvMy4UmnixqhKhTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from MN0PR11MB6280.namprd11.prod.outlook.com (2603:10b6:208:3c0::15)
 by DS0PR11MB7335.namprd11.prod.outlook.com (2603:10b6:8:11e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Tue, 2 Jul
 2024 12:20:30 +0000
Received: from MN0PR11MB6280.namprd11.prod.outlook.com
 ([fe80::3f63:c727:6606:c089]) by MN0PR11MB6280.namprd11.prod.outlook.com
 ([fe80::3f63:c727:6606:c089%4]) with mapi id 15.20.7719.029; Tue, 2 Jul 2024
 12:20:30 +0000
From: "Lawrence Troup (ltroup)" <ltroup@cisco.com>
To: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>,
        "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Marcelo
 Tosatti <mtosatti@redhat.com>,
        Franck Baudin <fbaudin@redhat.com>
Subject: RE: [PATCH V3] nvme-pci: allow unmanaged interrupts
Thread-Topic: [PATCH V3] nvme-pci: allow unmanaged interrupts
Thread-Index: AQHazGxw+YHyeMnrkUS08iAwjeS0RbHjUxgAgAAGMYCAAADFIA==
Date: Tue, 2 Jul 2024 12:20:30 +0000
Message-ID: <MN0PR11MB6280284585EC79A329095CC6C0DC2@MN0PR11MB6280.namprd11.prod.outlook.com>
References: <20240702104112.4123810-1-ming.lei@redhat.com>
 <20240702115002.GA16219@lst.de> <ZoPum7MPTuA6/t7O@fedora>
In-Reply-To: <ZoPum7MPTuA6/t7O@fedora>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB6280:EE_|DS0PR11MB7335:EE_
x-ms-office365-filtering-correlation-id: f811243a-63b2-488d-cd53-08dc9a915d30
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?ygwzrT1yx8lQV3PBI+KW3Dn+XJ2HXOzsNFX7JIThsh2jt3S43DIHXl/yygSb?=
 =?us-ascii?Q?w57C6g/TgvxFE5oqhUO7SGDnqZQlSeeIimffXENWH1GLXXTTahz/O0QTX5i9?=
 =?us-ascii?Q?S34ryk8oeFUTcCL4ge+DUm1RpjMt8dza6xVxme5irUzm+SWisxkJ7DdtqNNS?=
 =?us-ascii?Q?AnD0iKrNGm+hIlGqMQuCRG8BDTKWrgfy2DvEq5ZFu+DEv7yeRUirOBAYKUHX?=
 =?us-ascii?Q?nLjQoAZjJkmRHotOJcLQMtDb9w+2a4zX489jTZaSAZhtoaLXYiqEiODGIi3O?=
 =?us-ascii?Q?EGZm3zHMA9wM8cIbyUAyGSaxc3Qf0VV9QRIF8OMb3Xz2Ki9za/t6Guy4FXxV?=
 =?us-ascii?Q?c7USET3/9bEQ5ftBf7Ni9sVZxSfBoHUjCatXv4H8JzPzzjKQJlReL2vm3GE6?=
 =?us-ascii?Q?ftbiXtfq4dXnBF4UPeisFYBh5ww9JrtpCo4dS4X0GOyC9+oXJB0UUsxKy7D7?=
 =?us-ascii?Q?ek+BXDOAEDzuJIeUgOVv9OHMa1Uq1OXDxf+g41Tx2rwpiNE2E/373u+LIsH8?=
 =?us-ascii?Q?3jteBKBg3wrizoB+JmPisxZt5gOwwq7sh6moIDio48vzUasnP22W03SJlNjg?=
 =?us-ascii?Q?zQ7PUy1ksrN834HReUxQTxs77dLl9YS5Mf/eSMo5pDlPbd1LCALgP5tcuJlI?=
 =?us-ascii?Q?PJ4yp1SDWdXoTulp8syjcey7k2PtefNJSD9n2f3M+SPOyPuS9XqYPRrJZ1ls?=
 =?us-ascii?Q?y8NCjQSJnAWErBeGLNLeUASZSowwxNzCkDxOuce1xXjnqTpyKgEwO6capZ3G?=
 =?us-ascii?Q?Z+19sOCzgDS6u1BrrWZrpYuDFBPw/prSjGb2RuRnwop5fodAHkrbJ3/kq/yT?=
 =?us-ascii?Q?FjaWflhrLpNtGnIKT7IFmzM9ys1yhPmvd5DuQbpSnCYTjlVp/rHGmU+/18Qg?=
 =?us-ascii?Q?6nUTF/MMdH4xp5kGxunx4IgRNr48/NRPKkc9wTDEwFGEo4dfAUWs5tx5XIQp?=
 =?us-ascii?Q?+30JuFY8BTbKl6ph0SUlYZWa7/fBBJ+QnDTi2vOAJPeHt45X3NYLS3ddJVIa?=
 =?us-ascii?Q?UzBLAKMlmP2s6ZQ3pqondtW/9iQ+KRcu3o29L+DWjkcujegRWIQHeELZMwKv?=
 =?us-ascii?Q?3YctYy37Knrdqh2Lq96JNtikoZA517/PpDl6NRBcUNT/78aUtfgLB6KUtNBi?=
 =?us-ascii?Q?QUtlZysG73GQjWhEFRP7iSmDu3aSa5VQzY7nuXu4uNMHp2R0hprrdDyJMZcK?=
 =?us-ascii?Q?fw1+HbeLOQBhiGMgaW07xociKHnZrONmZrF85jvcbrWJglae+Gy5cV+hmZaV?=
 =?us-ascii?Q?kML5QXqWSqcn5dTxzrVX26XpjVofUNTruEBKCi3Uz2Ij06OQqgP3S2mBsaxM?=
 =?us-ascii?Q?3L0iw4zOLFs9dVZABLvTaydqgrqJCoeFnmeVSX3db0kwG3Nmth7U4BnqX5qA?=
 =?us-ascii?Q?vKwTIMsGewDi1XkbL/2Lv8LsJzWOwOKqyzph7PeHvnUhJjqpnw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6280.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rNMN2D5REdFTd5abPA3n2KVqQtNU/ZzDbXS66zU6bEx2t2wBvmMT4y5Y5/M1?=
 =?us-ascii?Q?SjJnktowgQjmPWbVcCsgZ0UXZ16RZZLsGKtmPc7J3NxGF+73cKGNdEuzIwYE?=
 =?us-ascii?Q?+2rlLRByggARvUrH4rfKCKIu1aKgEoomndvWyL9fH9xwrvX7p64urr187B6f?=
 =?us-ascii?Q?Ny26L3ONdoYixDUMgC7ldYSv65agNGBZqfshYYgFhUf4xMur4MqMacvIOwts?=
 =?us-ascii?Q?MlC7E8ZCq70tIquepuDpd1Du900u5RxxZ2sSZHkcP7oxhOKjxfI/IKB1yDNb?=
 =?us-ascii?Q?Z5OYItk0dg2PQNKYF7XmX8WZTgiXxekrwWSQ9iJ5quPvf4vcH/JLHNpxhl/F?=
 =?us-ascii?Q?q1S4MD19c+xvCyLJ0OviodbHpFUQw8IDbYkV9DS8kczVjjozGpMDEwTmZZQq?=
 =?us-ascii?Q?L4jpWyNAwaIpErCb9CX/8JaVIW8D1HTw7QLepQvF/hO/DEXw0Qr5QlqsjtZf?=
 =?us-ascii?Q?nx/O+vFksaxNY2idA2leH/qbdILLeOypvyCxckHGNagXDs+S/bkdW6xgmsH4?=
 =?us-ascii?Q?lEMZgXIvPLJ8DHTZyP3HYU+O1E8lYq+IUnbduzxlfBpNUl2jL9oeO2RT5UUA?=
 =?us-ascii?Q?oE0SioST+EqyxP8js3afnHwnHYLVWKCI1at0V/TKpRvyDWSdtEeeR7qnMgH+?=
 =?us-ascii?Q?2DhAEQzLz1PhCqlIWgl8LxhGc9ACqF+OUJPeDvn8eQCaUUqszK21sbfhp7aV?=
 =?us-ascii?Q?gsXGN+oToaXBN1ounXs4+I57dfYoXpAb6/8DK5kFiPNgx5ZJxRNSQFw3+AQD?=
 =?us-ascii?Q?c0jHbKnn5PyyTiyS/1eRl1I10KXShp8Q2uwcVYo53l2sSxHef/bKRU7Tayo0?=
 =?us-ascii?Q?5lLZ7VOnqyZOYKU08FdLkAAgS/bW+xIk5CO94F1SsHMYAt7ZbF40G8WXASlV?=
 =?us-ascii?Q?+yHwgZ2dCjO/o14cAocMgAZWptXjYgOSavWP3R+qrJdF6ODdj7Q2USezFfjf?=
 =?us-ascii?Q?mMhIA9LPmb3JJeyyDC+3pBA5G/r71qTDJkU+JVyC+uoJnFzMyNMdH3sCDaGY?=
 =?us-ascii?Q?TraC0BUoOhAXTHO0WeC69UV9TpIqQXIkjMHXxxM+Yhb1wx2fNgg6RP4ZX9SL?=
 =?us-ascii?Q?ru6RtOkobbFxDL2bGfZMefHgzd8QGImauljyrxC/sGyvOrTsoB+eCkede6Od?=
 =?us-ascii?Q?xCFeA5aYnqjovl54iTmW3mzLnlQBwU+JtWTYwD/8JVCpuKQeHU9Y6oadPQjX?=
 =?us-ascii?Q?6Voj8Em3gx3L3kBfADugISN8vyHQP0Ww61rA9Ag32ItsCs9XnYyBp//nxaDf?=
 =?us-ascii?Q?sumhX4W91U3X4EI8xrTw3a/qdVTbBRTONQT5vOJivuZKNrWE9QKUhOgByWbS?=
 =?us-ascii?Q?i1pvvJnlDiZjA8hCylCmrGugQKVq/uikcQXaU/8ETGRYOrs7k2QsRDhczj4V?=
 =?us-ascii?Q?ItsbhKTlhGEYejBCnLuNGVealPVgSejnaS4JPbG+4Twjgs+EXrsIEPJhb1hL?=
 =?us-ascii?Q?XwQfcetFGJEvl631Gz5vC4DrbmLOBDZSdwlUy2sqXezTgXo1FG4XPN6zyEev?=
 =?us-ascii?Q?WkC+q7R3LNSre9uhFiAF1Bi/JNugRQhr8km6rgz6tTob9/yc9r6iz9TSjN3s?=
 =?us-ascii?Q?E+GnFUMNEfeIR4PZ2qs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6280.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f811243a-63b2-488d-cd53-08dc9a915d30
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2024 12:20:30.3904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qp7Zl4OpaEt8OVrfzA4YtS6TYzc5m2Ih8RoXuzRit7Q9HmLWaN4NdAwCGVBxBANA9jkecoG/4LohRL1UwIWtYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7335
X-Outbound-SMTP-Client: 173.37.147.229, alln-opgw-1.cisco.com
X-Outbound-Node: rcdn-core-5.cisco.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240702_052039_598574_30A4A06E 
X-CRM114-Status: GOOD (  23.75  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Openshift needs the ability to dynamically move IRQs of all drivers away fr=
om a specific set of CPUs, at the point that an isolated workload starts ru=
nning on those CPUs, and requires high performance guarantees, i.e. no HW i=
nterrupts to occur. To achieve this, dynamic setting of the smp_affinity fo=
r all drivers is used - at the moment, the NVME driver does not support thi=
s, so the NVME IRQs remain running on CPUs they should not be on, and so im=
pact performance of the isolated workload.

Ability to set the smp_affinity seems like a generic feature, that should b=
e supported by all drivers - I'm unclear how adding this feature to the NVM=
E driver can be viewed as a hack?

Thanks,
Lawrence

-----Original Message-----
From: Ming Lei <ming.lei@redhat.com>=20
Sent: Tuesday, July 2, 2024 1:12 PM
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>; linux-nvme@lists.infradead.org; Sagi G=
rimberg <sagi@grimberg.me>; Lawrence Troup (ltroup) <ltroup@cisco.com>; Mar=
celo Tosatti <mtosatti@redhat.com>; ming.lei@redhat.com
Subject: Re: [PATCH V3] nvme-pci: allow unmanaged interrupts

On Tue, Jul 02, 2024 at 01:50:02PM +0200, Christoph Hellwig wrote:
> On Tue, Jul 02, 2024 at 06:41:12PM +0800, Ming Lei wrote:
> > From: Keith Busch <kbusch@kernel.org>
> >=20
> > People _really_ want to control their interrupt affinity in some=20
> > cases, such as Openshift with Performance profile, in which each=20
> > irq's affinity is completely specified from userspace. Turns out=20
> > that 'isolcpus=3Dmanaged_irqs' isn't enough.
> >=20
> > Add module parameter to allow unmanaged interrupts, just as some=20
> > SCSI drivers are doing.
>=20
> Same as before: hell no.  We can't just add hacky global kernel=20
> parameters everywhere.  We need the cpu isolation infrastructure to=20
> work properly instead of piling hacks of hacks in every relevant driver.

Per my understanding, here cpu isolation infrastructure can't work for Open=
shift, in which IO workload can be run on applications which are executed o=
n isolated CPUs, meantime userspace do expect that interrupts can be trigge=
red on user-specified CPU cores only in controllable way. =20

Marcelo and Lawrence may have more input in this area.

Also irq allocation really belongs to device & driver stuff, how can that b=
e hack? We even may not abstract public API in block layer for handling irq=
 related thing.


Thanks,
Ming


