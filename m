Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40CD7C02198
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Feb 2025 16:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=osr4FRdQnl8J3zDw1t/LPp+CG9KGZ9ONvFk8a2w0RHc=; b=3C3Cb4rsk3L9l5gUPQOQaniY6A
	pxIbzLSv83NSY9xCkxuFs1Jk2xu1utB+om3+QqCvUKg+VGijt5atKw1Wf5rnHdfbsFA8vIOUyaEhF
	TmzR2YrNo0W+whQNhd0jphv8LcXHJbSTTCNK+crFDGCGMzb3BYfwRu9mjhfI+CV8aXN1GCfROCtNB
	BAiWTGOLvJOworD5cGQl7n/dR0w1H14fyfaKDNyAJH1GJOXGLD3+FXN+gPHNiCgrh0QAnco8Qk9gM
	dURGj9+4N/BqQBbqYHVSPF7U2SDWlRCuVXSVr3DIj0nN9zuu6uhlLkP7R1F6wR8NTzNVB+Eiil1Ba
	El4vDYhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tfik8-000000042UG-07vp;
	Wed, 05 Feb 2025 16:59:16 +0000
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tfifp-000000041qs-0Eck
	for linux-nvme@lists.infradead.org;
	Wed, 05 Feb 2025 16:54:50 +0000
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515GHebv012071;
	Wed, 5 Feb 2025 16:54:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=os
	r4FRdQnl8J3zDw1t/LPp+CG9KGZ9ONvFk8a2w0RHc=; b=m+jQGrMFUdY0d3+XIC
	s0XTaCoHO2nvC2aDBajb83Bb4Qhgx7jHNE9TjMscQ/JzerkFujZcQYm/Mc0+v+3T
	C5tmvabLXqmt0K7c6IWGiZQ8h45oNz0WlJyuyMdOnJuxaCgQ95IgnHs3u83kh9gW
	l9iJqBBPNhsBS31hliblSxCfl0A8X7NBfc3KHye9pocGMZ6wRxfLycsg8GCQuD63
	uGb4+AIMU3d6LfcUb1I7m+VMfT23FQ9eoIh2oe/tgeSZ5sm+dj4KvWSvjHuTZuC0
	CBB76RKyMqRG+98Dj5gaMdLEmz/Q+GVBVukbulssIHqJifgxMgQAQss081yi7gj7
	Qskw==
Received: from p1lg14880.it.hpe.com ([16.230.97.201])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 44mbccra8b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 16:54:23 +0000 (GMT)
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14880.it.hpe.com (Postfix) with ESMTPS id D1B4E801AC4;
	Wed,  5 Feb 2025 16:54:20 +0000 (UTC)
Received: from p1wg14925.americas.hpqcorp.net (10.119.18.114) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 5 Feb 2025 04:53:52 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11 via Frontend Transport; Wed, 5 Feb 2025 04:53:52 -1200
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 5 Feb 2025 04:53:53 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YrzdfPMygmdmMGwX92aJ2zaCg1au4cbP/Wgc5sDdbEhjnfcHo603ShZ3Q6/i1TtkgRZgBN39Eqy9FSKiTUMe1smQiLJ3fvVUlRAjz6hRoFYa/RV++jVEgPLmL/lz8CXneqPF3GHFwN3728HuZglQLwsse6jEkfs0HXQs44Y+52Emjda08NOXlyBLVhqjGU78r4ywBuKD0Xxdw5jBAtVLefn8P1eLfO7c20yq7q0ZlM096yMByJqOrnSkM5kuhrBACxxWJf0lc/QOJ18VVJjkWRJ3MbbF0xp05OnJ1EltMbT7L7ygbfqIN8DUMykMo5qSAARlv4CV6nN8urVUouuJ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=osr4FRdQnl8J3zDw1t/LPp+CG9KGZ9ONvFk8a2w0RHc=;
 b=FMXZLgDIE1wdkTciCJwAG3tHkG5QQkSKBkA78B1Qhnkz2RUz4sJGoKNQ1njOhBYk7aF88RvfCiLqdrfEcnOROynGQxqh+qGyrG08FTggYS6fkY2vigwu/lTrFNwWURCQqM2QBccshy/QZ3oNluuXT6JkeSveixetxhxXRdGfWf7BgW15nAseoXTaIUWsy4i5sdi2Lj4AW6k4aIVVAUevvVpp4ua/5kFa/3x07bZh2sDrf15ClpM0s/2nDvgOsMhK+VYYrHOrkLNNLTIP/7gzzc68mNMO9eP9dnI6f7yHaD/WU4qsuiafhp+qS8Ky2fRc1mg44yc3rd7GRf48TBcpIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1374.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:49::14) by
 PH8PR84MB3163.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:1ce::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 16:53:51 +0000
Received: from DM4PR84MB1374.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::95d6:782:51c3:42f0]) by DM4PR84MB1374.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::95d6:782:51c3:42f0%6]) with mapi id 15.20.8422.009; Wed, 5 Feb 2025
 16:53:51 +0000
From: "Ballard, Curtis C (HPE Storage)" <curtis.ballard@hpe.com>
To: Christoph Hellwig <hch@infradead.org>
CC: Daniel Wagner <dwagner@suse.de>, Hannes Reinecke <hare@suse.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "Mohamed
 Khalfella" <mkhalfella@purestorage.com>,
        Sagi Grimberg <sagi@grimberg.me>, John Meneghini <jmeneghi@redhat.com>,
        Randy Jennings
	<randyj@purestorage.com>,
        Keith Busch <kbusch@kernel.org>,
        "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
Subject: RE: [LSF/MM/BPF TOPIC] TP4129 KATO correctoins and clarification
Thread-Topic: [LSF/MM/BPF TOPIC] TP4129 KATO correctoins and clarification
Thread-Index: AQHbc8Iz+czm4vBBUk+Is19CrVgMobMwnnSAgAAZaICAAFidgIAAKHjggAeu4ICAAAnKYA==
Date: Wed, 5 Feb 2025 16:53:51 +0000
Message-ID: <DM4PR84MB1374EB9468EC63867217240E98F72@DM4PR84MB1374.NAMPRD84.PROD.OUTLOOK.COM>
References: <63af907d-9cdd-4956-9978-4e77389b1716@suse.de>
 <Z5yYk7vHIhMfiPz1@infradead.org>
 <527f476b-18e3-43f9-98c3-d19a25a6488a@suse.de>
 <613065bf-ad13-489e-9d57-408684e85923@flourine.local>
 <PH0PR84MB1358752FEA88D5EF0971B27E98E82@PH0PR84MB1358.NAMPRD84.PROD.OUTLOOK.COM>
 <Z6OMGweV-wUI3iVn@infradead.org>
In-Reply-To: <Z6OMGweV-wUI3iVn@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR84MB1374:EE_|PH8PR84MB3163:EE_
x-ms-office365-filtering-correlation-id: 3ac95179-dbba-4a1a-2eea-08dd4605ab20
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?7junBqvRWItl3qnsEdQ+CQ7gd4XCYZUAUnD3sgFdLSUJDcyKiRLMrWF9HUZm?=
 =?us-ascii?Q?m+czBZpMkz1kV0kCfPjlfkmh7AvSzVVF22jU1490/lmPIPX+/7TvtoHbCYfl?=
 =?us-ascii?Q?yXh4FE4Q+L7PJ+nlohI2/BfUL4mOGDnVOPle+AA1Dy6M/EqbkhJkmhGAcGgw?=
 =?us-ascii?Q?zc+hm3RLJQLL0AZ8JM7LtYi746upgdIyGlvBhU5NhGel6vEXRipna9SqPf+1?=
 =?us-ascii?Q?F52+PsAtoqnmuKXMz9FlDmBCum9clt6QORqsKv4vdfiElgC1vWLzgzSk0jcR?=
 =?us-ascii?Q?CWy7hFfGi2dUOS5sbkmhUpi+2VWR3OgiL2eLTr0yHCV4VEdm62XuwWVmo9JG?=
 =?us-ascii?Q?dRXuvPIsWrhBr5gJXNkaHzkzniY5XgK/RhTIaCi3Ff9CCVdLOkzLhbZf75Ls?=
 =?us-ascii?Q?3W1V5AJeN+OYXpIziu2s6PulRMhgblCAxlHFjfnsHeCUlm4RnSpbW/0DTQ5v?=
 =?us-ascii?Q?07Dnw2A/KihfA9P9XC9JOxKgeo5WJlyxNfCqLKFOwZ5Taz6KMXH20ysPuQxL?=
 =?us-ascii?Q?ojwGGzb9ta/N9Fxz+E+UXNyM8QnhsAc0JvbeKGTD3HDM7/CfEMyFRCssCMAu?=
 =?us-ascii?Q?+6CF7B9vSO03XPKYORVyJjDHalJ7v7P+SMr15BnYRsydoh7wco0Ki5oBaBwU?=
 =?us-ascii?Q?j+yplk3vbSZQ1pEEFko8J64OCuNsQ6Yn+W+1QROTRB2hh4Mpd+chSvNp/K78?=
 =?us-ascii?Q?aJcaNJsIiiJl7pdqMY1ozHp7IqBi+fLFyIUWoab4+ydSruvU9Ny+fuHbVvbZ?=
 =?us-ascii?Q?eG9Y4uqkpRn+Puhpm0Itf349DMq3vaVg3Ej9GBVAOHxZViWF0q2i4xbBLe6O?=
 =?us-ascii?Q?R6QiImkV5gYU/jHZZQjYypri8kfiM8c7+gKDvNL8d4NZ1wDeAntQ7zkUmpUf?=
 =?us-ascii?Q?wdUiNGVOMS45rGZmer/5FNJYty4PJnmJAGLpNG6I4QM18QLZpEOOVjr6yUj/?=
 =?us-ascii?Q?X4ov9OxBAMnfOeP8J+Z3yPOkFAW6WeRKMVS99Fv48DEOIF7EnM67zCDl4qxi?=
 =?us-ascii?Q?U/Wz197NYmM1QNio7UbgAQ1Iq6BlURp+LMMJNMbpxRQZgzCqyZzBeprR28iW?=
 =?us-ascii?Q?7qb9T9ud0zcLj13Rs/L91oIm2tuolGz1V3tmMVtXMvcnaTadURk7cq+i1HZ9?=
 =?us-ascii?Q?2kXrlPcrLO0C7tIpKjXJjtvtSEGKjPnp8SDcPTv3kAriP0BMFV+N75tRbIe9?=
 =?us-ascii?Q?BZsprhFOpcoz9sNsipXps0SMNCi2R2pTAq0hdQYnlYpUz1L/SM/QMG5RYv7K?=
 =?us-ascii?Q?KkZjYjpxIpTOf//0Pzsn/jSzAEY/p4c1LTg1SPgcOeZXLFEqz+U5Aps7d1rA?=
 =?us-ascii?Q?gOjs5hUlg7C6AZnHYMGuaJq0Q4bS1IIzLqk6PVwVCUwdE8OD2yBDil22oZb9?=
 =?us-ascii?Q?gskbBtL2s2K42NzCBqesicCOE1q/7+T49ZURto2fK2iHKU6fjGzb8tkYOodu?=
 =?us-ascii?Q?czPIXHA4t5jsrDDfonvT3xk5hXzmiY6Y?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1374.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?K4MaSp5rOdKUhqITVy26bx0d+ZG0iIuW5mWf85YEpfwV+YllQsn5dYrW8Xja?=
 =?us-ascii?Q?fmm0ALELRk7ygj7BIetYA29Bxyv0HblR/1rzDWpExGkWkEBEiiZA67GvqIle?=
 =?us-ascii?Q?Wue0n8NYPqAVBUx1s16tmb1nS42OFPRmrWQ8yoa2f4ZiEYHV6HGYXQTVb5pQ?=
 =?us-ascii?Q?frWvhZpfXKxcW3AzIzKXWwtabiYmjasdKO2gU9Wxdkcz8p17nSzdkmeATf/1?=
 =?us-ascii?Q?f1tW1HN2+U1RZflP3aJ4UyckIfQYtvxW16tmgOkLWN0Wji7BqRFCn8rJ4g/T?=
 =?us-ascii?Q?LTvWgylCuNCcVqIoxBNaNhz04nZtqLqlph7/ud+flqUbaAbVtUT0MsESJIub?=
 =?us-ascii?Q?v3H5QtTx9VGNsn5Ash9maKPoddtVL+mrCy+97LravPDV/f1KYc5iUsPUbT9C?=
 =?us-ascii?Q?vF2ZLOLMoYtPOK+UueSAzXuWHxB/w0Z2kunxg9lvbV8sUoV/pyRYNoSmY2CA?=
 =?us-ascii?Q?huOGjyG5sP372WGo6VSVziOaHIPu4WU8HOJVMA2iujn9Ma5Bvc5SkBgMfDmu?=
 =?us-ascii?Q?OnpBPBy6Kh5RPUMhr2s+47jFWZ3kd5VxFICrS9nPpZyyBAiGSTXmFp9buMvn?=
 =?us-ascii?Q?DUAHNZEvp4KOr4XU+oj9wGCPEp59YcvC3EltzTPN0dipN+jErh5+nUPGyXz7?=
 =?us-ascii?Q?dPdee4ySs9wWpEAE8kZSG2Sn4yqyqHWSCUcqRNsxuFRdSaAtp9Bd8Bql5UWJ?=
 =?us-ascii?Q?l157kASZBfMzdHCuHAsYnCucXIe31nqvEGvAPHjxOIYHC/yeVOXUxxSFjSiH?=
 =?us-ascii?Q?UokEqamAFElKW8s//XBB7QULAP8bGShz1QnAVVT7CyrzE9iXmlF7O/GcLE4p?=
 =?us-ascii?Q?i8KlClMSRv73TOgXXVS1s+j/awY8Gr4qFFkyPY/8As0zF6QTLPu+hmDwikjz?=
 =?us-ascii?Q?FL2v4FBag5ySiES3sQR+nC9NmDSoSEV8rdNLWQJfs9kdqG2p38WnxCdcmwmO?=
 =?us-ascii?Q?IVw8c1qUobKwwvDEEP67PFn5jvIPPrsyAMk4/kMPhVtkt+Fho1AQm5mVlSsS?=
 =?us-ascii?Q?3iLXuEmxyR5qLYZSe9myQBi6gHKhsP3l2kXAOOPxGvHWI9Kl/CDOaXUDgmhG?=
 =?us-ascii?Q?qqQkV+OWmHm4fTCufslTIOuURNKGFKJ1P+c9qcVsGcPS43FsK1CJCXuvfytW?=
 =?us-ascii?Q?UkNzRMUmukeCFiJSyZOru+Cg0LkPSCWhIfIxYAEqLPgnpA76anwwelB3CxEm?=
 =?us-ascii?Q?wxaRlgS/SLHgfENXMsLObyrhEoqI8PKuuynr3SfS1qCiWcVzs/oSftF+byIz?=
 =?us-ascii?Q?BcCJdEg05753DHVjKeRQ3Ycn846CLCx0khQ0idYRcZfVHxbH4El2cYvsJi2C?=
 =?us-ascii?Q?3wund2qdZeucGGJWVPGDFih1Yus06zuv6oAcH8SIrmr3F84wzkq2S8bBMIba?=
 =?us-ascii?Q?v7Uks5POUmyjscDcryt4le/IThLYJ/zFAfPJuK1q5H+NSWl3TNIFiqK0x7sH?=
 =?us-ascii?Q?EDroVtu+Yh/vc5QTej3vVIG4Rrwdg5qpGuB83HnVP77VG5a9MYHTsjuxZ6Ol?=
 =?us-ascii?Q?cwhPwWi7NypZqRAs8IeWzLa3jv3zN8nhdh/y0duiyKtPIFj7z35knuzPIeWF?=
 =?us-ascii?Q?a4R0RV8jNtmqE3fpPImSg0zmkbGupiORNx1O4Gqb?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1374.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ac95179-dbba-4a1a-2eea-08dd4605ab20
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2025 16:53:51.6114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /DiKECITArA3JRghOBXRRjofbCAzjiFykgMdUlLLrZdIBqiAWozgVw6ZAJfnkg7ZbQRV/qOJO0MY1myyBhnRfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR84MB3163
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: AQqzwWvkBfsWvnsPl7BuVB2XNRpBJ4Du
X-Proofpoint-ORIG-GUID: AQqzwWvkBfsWvnsPl7BuVB2XNRpBJ4Du
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_06,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502050129
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250205_085449_208318_C953A633 
X-CRM114-Status: GOOD (  21.58  )
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

>> On Fri, Jan 31, 2025 at 06:48:20PM +0000, Ballard, Curtis C (HPE Storage=
) wrote:
>> If there are specific aspects of TP4129 that are broken, I would be inte=
rested in learning more about them and how they are broken.
>
>Serious Curtis, we've been through this a dozen times in the TWG.
>It just adds another best effort timer that is not better than the
>one that already is there.  But you guys insist on papering over it,
>an there is no real reason for Linux to adopt that.  (despite the pages
>long John rant).
>

Thanks for that response Christoph. It is really helpful to understand that
the concern is around the timer and the "best effort" aspects. I was aware =
that
concerns had been expressed on whether the timer was reliable and the TWG t=
ook
those seriously.

Reading between the lines on the term "best effort" I think that the concer=
n
is that the timers don't provide a reliable technique to prevent the ghost
write data corruption issue that was discussed at LSF last year.

There was quite a bit of work to go through scenarios, and timer processing=
, to
address the concerns that the timer was a "best effort" (to reuse the term)
rather than a reliable method. I'm not aware of a scenario where applying t=
he
timers, with the process described in TP4129, fails to provide a reliable=20
assurance that it is safe to retry write commands.  While it is slower than
any of us would like, having a method to prevent the possibility of data
corruption seems like a worthy effort.

If there is a scenario where the timer management model described in TP4129
isn't a reliable method of determining that it is safe to retry write comma=
nds
then we need to do some investigation to see if we can resolve that issue.

I appreciate the comments on TP8028. I don't like how slow the timer method=
 is
and really hope that we can continue to work on methods of making NVMe-oF
error detection and recovery faster, while maintaining data integrity. The
TP8028 effort is what we have in development and I'm optimistic that we'll =
be
able to discuss that model at LSF. =20

Curtis Ballard
Hewlett Packard Enterprise

