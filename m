Return-Path: <SRS0=ZvdC=KH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46997C433ED
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 07:31:37 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B86E6147F
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 07:31:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B86E6147F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=BzqJN1VPnqaRqrHv7pZkBamsh+OYqV5OTHL+14U+FpA=; b=YavQnIluUaLQ5ZvyTiBODVMkA
	md0ZcKD7Z3gbOkbDJPeYvQE9Xr11nbVriv8cvOH1S8PLRMm1XwKqJAfB/CFhgvHKyJDhzQ/g9E+t6
	zfX3f5iyAwVMRstc7hhEbCabMbnYGGCVQuo8zubD6gn6Kn64Y6vwWJUIJh+McwM+c1uiG2LsmmF40
	IeWORLKVsHWiK6/Z6C5xpQqOLRrjV1pYGy1CFiHyB/SV1e5wdv18L7lldMfoSwRjDoKndPGcH85q9
	n2UZAUHqf+Ncgz3wV14FzF5LqPzifJwVkbrln1J8l3TnqyK+oQYbcIZO72JjYSGfWWgGCFe3962nI
	KXi8WryRg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgjKs-002Flw-H8; Wed, 12 May 2021 07:31:14 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgjKo-002Fli-N5
 for linux-nvme@desiato.infradead.org; Wed, 12 May 2021 07:31:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:References:Message-ID:Date:Subject:CC:
 To:From:Sender:Reply-To:Content-ID:Content-Description:In-Reply-To;
 bh=Zh5C7znLPw3xcuIyvIOI1sTeKSXZw1aiMywQJSA9OFA=; b=dtQLzwl/8tPrj+LbC3+Q72C5KO
 pWyE29BqOb2s03jLnRVp7VtDxwZhvvumKocouwZLv+b11/u4cCgPegP8B3OZhwGYwLaiSjBShMyj3
 hMCg7bRcQbJy1ZWZ0ykV+tOZzcUJh36mQLtgBOQSJYQx51qMhzvY10P5StgAo+G46OL2vDj8A1QCc
 mfdvvfS3aj9mYeRpKqSWlNETzIQYjFe/hgrjkoOHBPjz+99Djd+ulAuP/7kWV1K8e+Z+08uxvgOkR
 sfktme9km8HWLrS5dYrT53RZcmVBA1DiegP0oxjxYO6/GQscXfjn5Ud/gaXy/bFkqAVCy4WR2kmoW
 lj4n3lVg==;
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgjKk-00AB9X-Gp
 for linux-nvme@lists.infradead.org; Wed, 12 May 2021 07:31:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1620804671; x=1652340671;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=Zh5C7znLPw3xcuIyvIOI1sTeKSXZw1aiMywQJSA9OFA=;
 b=UEVxoxAavDqXVpcmvm+x8TQ5/Zp+pL/KHLMqwMNVGBO1Hg8+A/uD4sTU
 LI1eEu7+cgvnngy25Ta52QUtIDovX0ZPwmMJAhuTTehqtePUqt1tjMdPO
 hNrfjknbxpFIfT0Mva8vBjWSttNe9npALmRiCT+xKtCcsE76BM9xUDLq7
 aiU0AUpanGoBJi6fQ2Z8P/xvl5dZexTQTMP2KjdJxLo7a21xD6ILosUiT
 9cYcbsI7VOBItNfcrgX975/lTB6o/FSy7eB8xASJwXcdXQk6XSVk+AhyI
 S4XQWEo9QGiHHwXhacYcb3pZ3/fKGYCIV+ujtzUwvQEZzy8of72sBuqKL w==;
IronPort-SDR: lyJuZPLRt5GxyFWdqR9bvSGVcnwnr3ujS2xMNZR35ud0U+BngjXPQwgSZ3PCJps8f0JGQMKhsH
 NkWAnCTm9IgIrz6AUMY3UUhmIs7bT6qxk43AxXVIXZxPVFZWvPJz7gcCU/WCtV+9pTaNMq6j5L
 qEZ1+pmP9MPgYqRfvG1GY81W0nrCUsGFQ4Zov1ppvmOqiggR+LeFotmScOLtsaNQaVXCAVBDaM
 XVKhPkEnHFVvVtIwn5argGMlgsXoSyZ7r7lDLMxn0WWBAX+ZCG9noYAWR2RyjNfisdqj+AZNBR
 aP0=
X-IronPort-AV: E=Sophos;i="5.82,293,1613404800"; d="scan'208";a="271843966"
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
 by ob1.hgst.iphmx.com with ESMTP; 12 May 2021 15:31:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z47uzI9jP00V+bkbnjCBeJtwLypjf7Fy/m9jl39HvA6WPir6KZnTJXt4ff4r3KbLF5zUmoo3gDlEawyJOkZTSTe6gRdd6S23RRbz3UoTXo5bTYuXssU61mskx+BBWmxMs0Utwg6w0xCkApFJuWQZYRB//C11ifUvjTvTZfRNmqoE51jb84LDHL8eOy1EN4JKRqkep7TQRGTqjbQHxFRTXSfmXtNDDSI8TwmWZTi898y81LpcJuvejguEDVwEcnfWGgUeKIJfYJMJ1B95/ubiawWsAUuT52d/Dd45Vt1w/1bbbdqTmcXySHh2acWF2mMFcptje22XvNR4zxlYLbN1ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zh5C7znLPw3xcuIyvIOI1sTeKSXZw1aiMywQJSA9OFA=;
 b=hzZ4Q2bIj+nt9jh3Qn/WXHf2D9gDAiUOP3YTZkrLfE/Q0jLQj00lj2901FWwBBSKAz8Ac9eqdId5V7576H5uBgjfI0C3ciF0kPNAgL6zlKKaZ0zP/gcVo6knP9lulhiNZwPEIe5SQxpg3ItiZB64SKOxHyRUzwQ7ZATO2RpVobNlMGmZrdSX66VocAld/HBLWTFGMR9/PzP0WSR6w/iwBLHIrH3mBtE7zLWJhGioaWhDz0nhCwhchrYSta11gyg6Yv3aZaApgx0DZFqJ9AtzRX5zT5uYugvkswZ/F+dh4ZTD82ItbtpIVtEKMxIZF8l+QB7/K59QRPjrQSLaENn86w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zh5C7znLPw3xcuIyvIOI1sTeKSXZw1aiMywQJSA9OFA=;
 b=YOjUHjwECxeBOcqV02T7q6hyiwqI4f8iBBuePSFGpLCMiuekH/fXQC/sR4z9+J3/txDfJLmmW0PEfjf7rrkgmomnPpP1shFGX3R4CM5OSd3uSKfpEqGNwPi4TNc20YVBCQ8zTeQ0xDFwtPyF45qVPqbVS/0lBsboRUyAXgk1Cxc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7256.namprd04.prod.outlook.com (2603:10b6:510:1a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Wed, 12 May
 2021 07:31:00 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4108.031; Wed, 12 May 2021
 07:30:59 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
CC: "axboe@kernel.dk" <axboe@kernel.dk>, "msnitzer@redhat.com"
 <msnitzer@redhat.com>, "bvanassche@acm.org" <bvanassche@acm.org>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "roland@purestorage.com" <roland@purestorage.com>, "mpatocka@redhat.com"
 <mpatocka@redhat.com>, "hare@suse.de" <hare@suse.de>, "kbusch@kernel.org"
 <kbusch@kernel.org>, "rwheeler@redhat.com" <rwheeler@redhat.com>,
 "hch@lst.de" <hch@lst.de>, "Frederick.Knight@netapp.com"
 <Frederick.Knight@netapp.com>, "zach.brown@ni.com" <zach.brown@ni.com>,
 "osandov@fb.com" <osandov@fb.com>
Subject: Re: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: Copy Offload
Thread-Topic: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: Copy Offload
Thread-Index: AQHXRfrE+mT6pvaiwEOWn89Dsv4XaA==
Date: Wed, 12 May 2021 07:30:59 +0000
Message-ID: <PH0PR04MB74161CD0BD15882BBD8838AB9B529@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <BYAPR04MB49652C4B75E38F3716F3C06386539@BYAPR04MB4965.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:152f:cc01:2079:86fb:b3fc:1190]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d68beba-92db-471b-fc85-08d91517e3cd
x-ms-traffictypediagnostic: PH0PR04MB7256:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB725661D975B16B6558016E029B529@PH0PR04MB7256.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e0dsVs7Ja7xxFnkfyj8UANuku9WoxDwCoWvD+AZCIqlFRl0syHUXH9HcX+6HrAnmCH6U52bR4QZLRK2dWX/NBUlAkgtVeBKIE50gduFk1aGvIVcV7yZ+szQXae/5ebaR5eH6vvLOT1MLY3+9fGLVWJOHLpVYmybFfu/2Te2fcY/d7qnNaZ8yZepKD9FDm/sr8w+z5Ter7o06Tmr7D9cJp9lx1kmWVU7oafcj97Ffb4tgWAQA07HmQQpM1rnhxojdOyM4/gXK9dsG5tc+hYZeDfIbQzY85hyEAI0di1ZckJ1VRZMIShnk7aRfy/ASnsIStI+ikiBKltaRf2vxjsMvjSbk8LHX7Ag8/v/Oe+MDP0YvgRH3HSCjEU2tVceIn44RSfsD9JBpoBm7QDcEcVsqweXSm49zKwa2WExwuZvtA4jRg81OKcqUtUSQoln/4Ue5k2nLdaasq1egvn3yhnyvEMXEHH4RdiaO3SVA87x2FUoeYEsb7G02fRHNbVPgY+A0rxI6ms/fiWwn2SukfPYk1Yt9LfhiqGx54xx1lVnjMlUBlDKbUXOThxnovRGRW4LbmxwvRGsOJSxz/Lpq0DiWAF6TYb8dF8TlIrymTWdRstw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR04MB7416.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(346002)(366004)(376002)(86362001)(8936002)(7696005)(53546011)(6506007)(33656002)(38100700002)(83380400001)(122000001)(8676002)(71200400001)(7416002)(2906002)(52536014)(55016002)(9686003)(5660300002)(478600001)(54906003)(316002)(110136005)(66946007)(66446008)(66476007)(66556008)(64756008)(76116006)(91956017)(4326008)(186003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?H0NCOAO4x3gXiz5Kffc3II1BmoVmu7KwMq5oVbpwec1jy/D9JztAbbO43T1L?=
 =?us-ascii?Q?PxdQRtNpn5oTm+EjbQhi6df8eCJMtyc2DP+Iv6v0Hm/lCnsFukZGS0XdhIMK?=
 =?us-ascii?Q?K3YLh0eosSu7VF1w4mG45TyMhx5FNv6ZWp+7EEv9o8XqAUHCbZn1c0UQ3SRP?=
 =?us-ascii?Q?Oj941wnQCO4U5+liXANqCsrVciz3psGR69WSncGcgrZFYjobgJ6nYoeWY/2/?=
 =?us-ascii?Q?IShpNLWB39h9AzJDTslxMV33r1Wu4rd1+7t5EujvucMeqRtUljD4LQhfQ+ss?=
 =?us-ascii?Q?XmOzr129tc3SqnZD6ENlk5hkyPkS9LEgGjmyRea5tDOMwPjK6naMdvrxYWjo?=
 =?us-ascii?Q?USzIYNV072urfgwiJjQ44EdxJYUFluq86rDb5xXJ4bEFSpZ/Wm1YIiZmZ8ir?=
 =?us-ascii?Q?1UKOI9QbixhjDgvg9KHR5rTuzNaSybp2uokdcYUQmvghMFvQTTTXv/43BnC8?=
 =?us-ascii?Q?WVvjSF0Do5uCZGrEEw58IS4PE5SF8cKWA/Z9/ttcFS9EuTCGPxrV/YBTenv3?=
 =?us-ascii?Q?qzPW7jQfLsoBS41DjwVIt0xaoitJif/FdOFODa56QkvvZwQhUzf5HkN3e19b?=
 =?us-ascii?Q?9Et66I4x4Zry2OjBwWljEg21+aEBgFhRjMut38xL82p8hlhHmn5OnCWSF9Cz?=
 =?us-ascii?Q?vp1GizjVc+l2LkflT5f5y62MTIAQIzxM9s6UKR2/B7sBKY1r/ecxJEeZ5ba+?=
 =?us-ascii?Q?UFpSpQZCXsTuVQNfnq7rl3SmZ93YxfgZKniUZVpX9Fz9V7tRmXMF6EPXUQJT?=
 =?us-ascii?Q?lyAGXsN7DMYIorKCGJYHuoxYxbQhWg+j+YKbitxx0V6V0Qw1zZAfDk9Qj7EW?=
 =?us-ascii?Q?pQ2bwrPj7cKlb0t/aGhuPmz0horIc4HwxMEEJiwMnB6ytxnc0Dj20diF5Igs?=
 =?us-ascii?Q?FvfHBgRtBjDxrqSZn5lW7e+4Rv/NGjEvyKRj7z8BAfQ/8ZS77tx0fHpNg17m?=
 =?us-ascii?Q?HYeX3WRvtQeU6CpB72pLLd9/6VS/8lgylruhM75VxVKPfcsI35zE7IUKPYl+?=
 =?us-ascii?Q?vgJeJY0veiPhEQCyp5tKbOTcJ2QqH676W3L6RWvfxJsWYVoTBpJVOti0d1BW?=
 =?us-ascii?Q?fevi1I6DeyXagbyVlmKM9B81xjlVI6xVI4VknEMoOOz15rWgINfZF+rQB0Ai?=
 =?us-ascii?Q?V6GmNMrxB1OJDt5IYJ+n3SEtgH4b8bzjwbK27ufYxjQzXhBFL6xQamNzA2eb?=
 =?us-ascii?Q?1kzryMIXhX6+oE9u22HGDxNEqg7wEjiqBA2tHD1C8KdZ8FUZchvUxRhO+Aew?=
 =?us-ascii?Q?LaPaCnF5Vlzcxj194lmSZ1TwZezi0wL2gbdzjUgivcyI8oUpGxNYzNJejPIz?=
 =?us-ascii?Q?mGnzuU94rwgpIdjZuEoS3pIPdFJzenoxA3kKfa2xLBheN5fiqxzCvGjWZBEH?=
 =?us-ascii?Q?IAwN0pvcetCAiktEhqDoNuBt/nF+zJYkyExZTuYUIvMZSF2XOA=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d68beba-92db-471b-fc85-08d91517e3cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2021 07:30:59.8252 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y3sCZyGWHLmUE2T3zyzy4pjcnFOYZdZuj8QMapJiN5LcnWc+ltdmjUz9gnThOBNGDahyy/gYmF3tjyDQ8+7Q2dnEnOhWZoO2iIDOtHlprzE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7256
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210512_003106_679941_C3E6749F 
X-CRM114-Status: GOOD (  28.21  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 11/05/2021 02:15, Chaitanya Kulkarni wrote:
> Hi,
> 
> * Background :-
> -----------------------------------------------------------------------
> 
> Copy offload is a feature that allows file-systems or storage devices
> to be instructed to copy files/logical blocks without requiring
> involvement of the local CPU.
> 
> With reference to the RISC-V summit keynote [1] single threaded
> performance is limiting due to Denard scaling and multi-threaded
> performance is slowing down due Moore's law limitations. With the rise
> of SNIA Computation Technical Storage Working Group (TWG) [2],
> offloading computations to the device or over the fabrics is becoming
> popular as there are several solutions available [2]. One of the common
> operation which is popular in the kernel and is not merged yet is Copy
> offload over the fabrics or on to the device.
> 
> * Problem :-
> -----------------------------------------------------------------------
> 
> The original work which is done by Martin is present here [3]. The
> latest work which is posted by Mikulas [4] is not merged yet. These two
> approaches are totally different from each other. Several storage
> vendors discourage mixing copy offload requests with regular READ/WRITE
> I/O. Also, the fact that the operation fails if a copy request ever
> needs to be split as it traverses the stack it has the unfortunate
> side-effect of preventing copy offload from working in pretty much
> every common deployment configuration out there.
> 
> * Current state of the work :-
> -----------------------------------------------------------------------
> 
> With [3] being hard to handle arbitrary DM/MD stacking without
> splitting the command in two, one for copying IN and one for copying
> OUT. Which is then demonstrated by the [4] why [3] it is not a suitable
> candidate. Also, with [4] there is an unresolved problem with the
> two-command approach about how to handle changes to the DM layout
> between an IN and OUT operations.
> 
> * Why Linux Kernel Storage System needs Copy Offload support now ?
> -----------------------------------------------------------------------
> 
> With the rise of the SNIA Computational Storage TWG and solutions [2],
> existing SCSI XCopy support in the protocol, recent advancement in the
> Linux Kernel File System for Zoned devices (Zonefs [5]), Peer to Peer
> DMA support in the Linux Kernel mainly for NVMe devices [7] and
> eventually NVMe Devices and subsystem (NVMe PCIe/NVMeOF) will benefit
> from Copy offload operation.
> 
> With this background we have significant number of use-cases which are
> strong candidates waiting for outstanding Linux Kernel Block Layer Copy
> Offload support, so that Linux Kernel Storage subsystem can to address
> previously mentioned problems [1] and allow efficient offloading of the
> data related operations. (Such as move/copy etc.)
> 
> For reference following is the list of the use-cases/candidates waiting
> for Copy Offload support :-
> 
> 1. SCSI-attached storage arrays.
> 2. Stacking drivers supporting XCopy DM/MD.
> 3. Computational Storage solutions.
> 7. File systems :- Local, NFS and Zonefs.
> 4. Block devices :- Distributed, local, and Zoned devices.
> 5. Peer to Peer DMA support solutions.
> 6. Potentially NVMe subsystem both NVMe PCIe and NVMeOF.
> 
> * What we will discuss in the proposed session ?
> -----------------------------------------------------------------------
> 
> I'd like to propose a session to go over this topic to understand :-
> 
> 1. What are the blockers for Copy Offload implementation ?
> 2. Discussion about having a file system interface.
> 3. Discussion about having right system call for user-space.
> 4. What is the right way to move this work forward ?
> 5. How can we help to contribute and move this work forward ?
> 
> * Required Participants :-
> -----------------------------------------------------------------------
> 
> I'd like to invite file system, block layer, and device drivers
> developers to:-
> 
> 1. Share their opinion on the topic.
> 2. Share their experience and any other issues with [4].
> 3. Uncover additional details that are missing from this proposal.
> 
> Required attendees :-
> 
> Martin K. Petersen
> Jens Axboe
> Christoph Hellwig
> Bart Van Assche
> Zach Brown
> Roland Dreier
> Ric Wheeler
> Trond Myklebust
> Mike Snitzer
> Keith Busch
> Sagi Grimberg
> Hannes Reinecke
> Frederick Knight
> Mikulas Patocka
> Keith Busch
>

I would like to participate in this discussion as well. A generic block layer
copy API is extremely helpful for filesystem garbage collection and copy operations
like copy_file_range().

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
