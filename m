Return-Path: <SRS0=6U9w=JQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190E2C433B4
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Apr 2021 09:47:10 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9465D61077
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Apr 2021 09:47:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9465D61077
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=M+3nsSxpldvTGYGUK4Glx99W9vi4jgpfqW93b1mRLZE=; b=cLCljfXSvNkwYT83LVQVL1trF
	Es/PFlx/wQh2zUytQAbFo13Ng88C1ZZC2jWCdTdM4ju4gHqpfKIejWcjD8ZiFV+u3MsZySjL4adMi
	wylk6Vm98OsN8ytlCLwNyDk0QorLsidGs4aiO7M49B+JvlHh1Nc2Ah66Q45ysg4W4djz+Pji1FBaT
	CGkbqG2iyPOtke6VONRQbvFJoVMyfFTQdlWxiDl+1+1nW7ORCg0zIIRPjKBLR4bDcBLGkkFVZ1N20
	Z8HPUONvhEd6RaAYGV9S639SbjjOsBc7azQFb1ZD3T7XSw9NsUAknDgOEQMSIqMsZFgsRWYD6gy3Y
	KwJ8C0Wjg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lYQUU-009c8w-7R; Mon, 19 Apr 2021 09:46:51 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYQNZ-009aCS-NS
 for linux-nvme@desiato.infradead.org; Mon, 19 Apr 2021 09:39:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:References:Message-ID:Date:Subject:To:
 From:Sender:Reply-To:Cc:Content-ID:Content-Description:In-Reply-To;
 bh=duncyBXG5RgXKVZBIGbINvA/7Q15u8xGmWI4Qtr7g64=; b=GyeTq8GWLjPdGWWeAK9+0iWwey
 uYKMl/iodu9xGABl6yxykhqID+DqPdoHDJiSWUMk2AIBWYXAdmwXw5dVAbg6zxT3j3ZHNqhH4z41q
 TbWEA22DCIcMk7wRJSP+oqmhqyS5fH0aE8ra7xkvJ8LYDTsm2UN1EMyWHmwdRTc22JmVrizWFuD/M
 e67CP7XKj0mn6nGvkhgUjqVwWVeQUgd3+Qzcg5N1n88m0HzCA1ithQI2JbRLXCALQLrBX/IBLLzyw
 iI/0hLuRerlrVsidvP+tlOmZoFcKFUPkUvNr0NUUtR1pXm7mkibxauZ1q0Q7DRaRp9RuQWKOhOzlH
 Cmn9TLkw==;
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYQNU-00BEwL-La
 for linux-nvme@lists.infradead.org; Mon, 19 Apr 2021 09:39:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1618825176; x=1650361176;
 h=from:to:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=hsIyZ1nn29RNZxXi9NbV67EplZDkOQTzMyIsQQZnP14=;
 b=M/tbDfKl34DkwE37jMsHFekLrEYCbwb3enag260hOirTthrJAJe3jpoM
 dENiMnh5cjXPvsNFxwwW0jdl/V4mbIAaWKDYDIJonlj38ug1lf9WXmiVD
 6iTd3nL6lXanf0Mg0bwZREyh24D7vXly7Ls4kuSeC2qwBtKFVWiXRV1ch
 tfRucGub+p8tPTu0NXswP2gtYD/AIc+hd/4sS3nZl5egWy4HH2Dp00Oef
 bY7TkZkTw26l/at08F9qMXyhzbX4eUx8J1iREgPunZg2DEPB/qXUxsAYg
 2QEfJgGqDLF0cslEd337748AxSqfsZU0gP6++8XrKnaWUNzcDyGGPo3kY A==;
IronPort-SDR: xFqt51HY8bHSEGd/z4+aXK7cOU43l/4ZiwGgQNd3VGd7troxf5jeXN2RDV9ch1v1zfqY2Vaymq
 krLD1VIOWKU4YFxXn+zoP+9If7CeWlM0S0ri0tphyE2tSjnIKHU3NkW1ApbWCEAZb2y5+J613O
 susDIpSrwo6fDy7c5ireyzQJZw5uct7LYKtETyKHtzN95K1ljpouC6a9P1/KVk/Qj4Sd39Oc+8
 DHc/lF6GW7RhSWjuVx+oJsc/86w6asy/rep7G1nX4Xd1zcDI945L66QeVm+pe+4wj1zed16Qoh
 uKg=
X-IronPort-AV: E=Sophos;i="5.82,233,1613404800"; d="scan'208";a="164772087"
Received: from mail-bn7nam10lp2107.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.107])
 by ob1.hgst.iphmx.com with ESMTP; 19 Apr 2021 17:39:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sb3ry+8/wcGROqa+a6n0BzQqNTCrnxIam+XLuLGnJs2HFBAyBKaQITqtPSHmDdaFoAKGm0brR/7niqPGgzPdNjtqCTHXypyAJupfvT+WYJbEhZjoi2lXsdQZwTrpeavam0azhji+ozT+6Cs0OzT6FQqM5vNSD3ensvjT428IrUDxLXFoWQBHD1xohTWeUUVmNMl4V0I9Sz2lvtPe0L77nFT+cYRk4CSv/FmK2nA+WeIyKEU+jcu1rgGDn5GrCoWdlDZxp8x4QOFhUPgaeNcwxqTBWMFSHtd/zmZNnLc75PNf9nmOlke7Y8fIf4qZRyJXvHAzO7ackbkKST2hO3ao5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=duncyBXG5RgXKVZBIGbINvA/7Q15u8xGmWI4Qtr7g64=;
 b=Jgr1swByMKe0NxdUKV06hsDXn1yXhxMmxaRTJyLXO/gevm4quNopdv7hP4/F12Rrt/9iV6ZBiqd2gOnXVNahp0uYPKSbBrW4uef7r7O6hE0+LUFQW1dfqmZviTJp3j3xbG60Y/rRpJshHCAep0QFFV9KkTCNb0kjyqhNRSj30+i3dG6unqklTC+QJy6NY5utFdayDYSR4Wrf72iQEGBNXw7mfr3ojg5eMvzkEI5SBc0tEBMLoLOw9vlNqdKn1zc8nzT+MnrwQiT7xU2PZtaVIpzVj/weDA0bdIl5FSK7USnm+iJXODJ9OL/vBrXj2ymDVlmaVpSHDPeXlwMAVjtvBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=duncyBXG5RgXKVZBIGbINvA/7Q15u8xGmWI4Qtr7g64=;
 b=pnt1NFIRZ199pOKhJV/5Gpr9aGnQdmrcfcbpsbwpxhOZuO98CnUW75uNqdaRoUbVxBnBroav4AUZ8JZtIGNDKt5fhXKpVNUKZ9rn4SpPAXy+5ti7BIBdnefmgayKgkSUJGMKjKTQQBcgL89Oy0MoZwUfN7DOkrpn0WV6gOUDcrM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7703.namprd04.prod.outlook.com (2603:10b6:510:5c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Mon, 19 Apr
 2021 09:39:32 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4042.024; Mon, 19 Apr 2021
 09:39:32 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "hch@infradead.org" <hch@infradead.org>, "dsterba@suse.cz"
 <dsterba@suse.cz>, Damien Le Moal <Damien.LeMoal@wdc.com>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>, Mike Snitzer
 <snitzer@redhat.com>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Christoph
 Hellwig <hch@lst.de>, "linux-scsi@vger.kernel.org"
 <linux-scsi@vger.kernel.org>, "Martin K . Petersen"
 <martin.petersen@oracle.com>, "linux-fsdevel@vger.kernel.org"
 <linux-fsdevel@vger.kernel.org>, "linux-btrfs@vger.kernel.org"
 <linux-btrfs@vger.kernel.org>, David Sterba <dsterba@suse.com>, Josef Bacik
 <josef@toxicpanda.com>, Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH 3/4] btrfs: zoned: fail mount if the device does not
 support zone append
Thread-Topic: [PATCH 3/4] btrfs: zoned: fail mount if the device does not
 support zone append
Thread-Index: AQHXMm1jn5EJEN88W0OCORdM0KUcjg==
Date: Mon, 19 Apr 2021 09:39:32 +0000
Message-ID: <PH0PR04MB7416B4B1A6EFCE92D51927C59B499@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210416030528.757513-1-damien.lemoal@wdc.com>
 <20210416030528.757513-4-damien.lemoal@wdc.com>
 <20210416161720.GA7604@twin.jikos.cz>
 <20210419092855.GA3223318@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:15ab:1:11d8:98df:8246:6a70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 709c9bc3-cbf4-4f78-4111-08d903170938
x-ms-traffictypediagnostic: PH0PR04MB7703:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB770317ABFDD79B77B9A82BE79B499@PH0PR04MB7703.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P54MZK2uOaRBDWCmJ18O7WD0AUlcX9ufVqWLjnd0gOWjGV4zGufUcQqrl0YPtHmdLnuXxaAKa9QxW3E0Iw7Hn9KsLRRs4N7kylHhnzx3wNkSBbxTxD6UaJOOU0xA8ItpsMc1tC3RLdcibW4zF/yIvx4awxLE/hLEVF2AwBKAP0r2TCyMw6DbvC6b7jBO4Us14C0hDJzOvGhY0iZwPLCHLeTEjpjKgOuyv5G1EIZmV8ClThPNtLmOM+OXNHVIleMlrUea2Vw7agPq1jse9P7P5rvTo9qVWmcjLcm9kri/Glno3/ju6+Tr4LgQgtJ6rpkmjktALCXlc8H17KYat6DtLNdiXuqoawWHUNdcU5gqepLCGY+pAceuz/sxTTy+dT1CW8+91/H9F1bTTZufzF5eZ/XWj0oVHQdNeeLpWl9emVE2VMrRmwWY1Qp199TE7MDcE/hVburxBDu368/albY5bGEaM/xtSFO1JkgdRG3XheUj2D3JSzQF0K2OJ8R9FaUNka+OWV+oy77S0DLMEx2fPaS2nHLQUKHbdzrP6TEFkj23AlnPA3pwHbU3yEsMU3ZlmJE0N+qXu2e0ueMdxhzUAJtqMDbHQc61hEI+44lHoJ7B8nL7yx9GbGU9+t4kLneWvQ8G3fIJhk0kps3TPDH+Yg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR04MB7416.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(366004)(39860400002)(346002)(136003)(83380400001)(64756008)(66446008)(66946007)(921005)(33656002)(66476007)(2906002)(66556008)(76116006)(86362001)(91956017)(122000001)(38100700002)(6506007)(52536014)(5660300002)(55016002)(8936002)(9686003)(8676002)(6636002)(478600001)(110136005)(7416002)(71200400001)(186003)(316002)(53546011)(7696005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?kB4pZXIstJOT+QrMeSyidjvAdoGcog5xHYBbeFLR9Ad0JknSrhUafAkGMDmU?=
 =?us-ascii?Q?8pZpWajdmNhwJQEYyCViooAZaQ44gX6bKuxv1I0gVV31ccx9LSKRUOlilng+?=
 =?us-ascii?Q?fTnioUm86V9FPK+3tBti07ZHegmfkofZx97z5oC6Ih/Juit2YmCqVD+hDuzq?=
 =?us-ascii?Q?t1qITl1vrVCVDNfuQkXu23mlQGKjhqmYnZWNkJCg8HlwXJvkDS61HV/UecRv?=
 =?us-ascii?Q?nd/TBTY4nKcHpXImohz+8qYMqRnVGuFZ29G4/55WBb5SvjqB9xMYuaBmXOj0?=
 =?us-ascii?Q?XxJFwmWaWeZzE7nEOd+M55LThbcNFsCXRy8p6D8XHz+mPJ49zxHD7bMQZ8WI?=
 =?us-ascii?Q?wQP6vOJxZy1v/8Qqb6Aaxj3XfcHMkin0ldnqtaGzr+mFvshZd0BE/ti1N+bt?=
 =?us-ascii?Q?dxWQc52cmVWRGsflZZ2uD3qRu3gFjfi9Iuff1UMrGTxW0ncw33FM71CHUHgH?=
 =?us-ascii?Q?lGQoHa5FL76PJt6aw+ONWd2tcQftCXdJpME68DWsTi6UyObWE11fUQ+FF5az?=
 =?us-ascii?Q?QEDokTQ1TC1Z0HSp1Vh2mLkE0SM446JRcxpMXNubQbs6p0A5vVW3pIuwhvxb?=
 =?us-ascii?Q?fr3Iufa2iqvQdshCMF+O43zCh6h5hbyDqSCzyzY+U2bM3gkY2jWG6EXDEzsd?=
 =?us-ascii?Q?ufB+Hdvi/fOesHTUK3DB2m6QajsSPtakqe98XePXvBngWIDdd7XEgRIZxay2?=
 =?us-ascii?Q?PWji47DJ4foj1XhSEnWi/Hbiiupz4eL/RcjajwkC70UJ7NQjGQSSiR7fKvuV?=
 =?us-ascii?Q?uMTzo4RpyrOfXhxXpeL9DlVViawdWV6LtxC/eUuwoNqrpdQdAq0IjA/qWROs?=
 =?us-ascii?Q?F6n2QD1Jancm28/kkg+YfcwuMR06vibCTvxEVgGdCEpiOWyVD9c33XO1BPjs?=
 =?us-ascii?Q?jXW6xil675S83unuKOb404vVFdZio8u8L4Kexpb3jsShOhYGtm/OikrfCQJd?=
 =?us-ascii?Q?Y+m6pxTNDiBFV7vLRfQlMzTCnpcQaQMtAGTiNdGJlSpdjLESqG015HAIL5vq?=
 =?us-ascii?Q?8mYavtcqPaPCF6gQR9bvsYTviVX7KPbvb6qSldwSnWuxpObIYAOtzzQdx7lM?=
 =?us-ascii?Q?Z0+K1Z0+p886xi/NY7pEx+pyogN7j0bipxjsVB3zJvcOzE9QM8lripFzheJg?=
 =?us-ascii?Q?jOLUEn0CWbk+/QwBr67s/vfHKo/bQJ5C6Il77/5nFjhEvhx5K5BPgbQTvmOi?=
 =?us-ascii?Q?cHc2V+lI4jM3JyrGxrEo1uFcLN7+fhbx3dQRajs57LsgL0S9EpsvodBpd2Eg?=
 =?us-ascii?Q?q04ty6HlSkw+Muv1d5kovq5TqME93N5y4eVi+LRNjdOm2a9lyv+DIB0w/GWA?=
 =?us-ascii?Q?bTQHBxNwDGggVT7aB+RCSGXO+exYWWQtkRQWzQ8HWH3uaH5Y9DWG47Fob+aB?=
 =?us-ascii?Q?J2gLsmVfRBl+1tO4rPJ2IdbNfBtp?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 709c9bc3-cbf4-4f78-4111-08d903170938
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2021 09:39:32.1696 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SbjfAKfMViSMRGzWTkS+ZBnlX6rQf+9DxArgTp8KFuFGkGkoZB836wJoDcMzXF7n/TZ8scu7XQ1PihJiCKbZ73vJ65ZAvQfo8PGNBWyR8NQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7703
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210419_023936_796800_349AEB4D 
X-CRM114-Status: GOOD (  14.44  )
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

On 19/04/2021 11:29, Christoph Hellwig wrote:
> On Fri, Apr 16, 2021 at 06:17:21PM +0200, David Sterba wrote:
>> On Fri, Apr 16, 2021 at 12:05:27PM +0900, Damien Le Moal wrote:
>>> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>>>
>>> For zoned btrfs, zone append is mandatory to write to a sequential write
>>> only zone, otherwise parallel writes to the same zone could result in
>>> unaligned write errors.
>>>
>>> If a zoned block device does not support zone append (e.g. a dm-crypt
>>> zoned device using a non-NULL IV cypher), fail to mount.
>>>
>>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
>>
>> Added to misc-next, thanks. I'll queue it for 5.13, it's not an urgent
>> fix for 5.12 release but i'll tag it as stable so it'll apear in 5.12.x
>> later.
> 
> Please don't.  Zone append is a strict requirement for zoned devices,
> no need to add cargo cult code like this everywhere.
> 

As of now, dm-crypt supports zoned devices but cannot really work with 
zone append. At least not with ciphers that use sectors as IV.
OTOH btrfs cannot work without zone append. While we won't notice any 
problems with writes, reads (or better decrypt) will fail.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
