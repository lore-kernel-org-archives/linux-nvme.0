Return-Path: <SRS0=dOZ+=AN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3159EC433DF
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2020 08:19:24 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F356E20720
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2020 08:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eD5FEkUn";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EIg5Porw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="CmH0wo8W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F356E20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=VMtOoPKIh3Hbyy6CYhT7Yf/cEi+18mjEHBMg27O5+i0=; b=eD5FEkUn1WWGbEmUr1RkBUQuA
	i0QFg6YRwJ1X3CNqdEtp5Y9gLexknKnOuhdLVfMUHjdcxn4/qxIHDgj0Fod6ui7GivLrWivjRClT8
	3vQ84/kk6/1IWTHYnfEEbwGkdHpxbrRuP9bWj+WDboeFwLgcTXT3+Ts0QVYBlvbdM8kT4EUvwiBSB
	G4zyGonPT2s5+fzKSgpyU7wY58WJBwSTaF421HMkHu0ioku6l/hBeNdwqNMw7rSYLMyCL+7D1DRvc
	/DOCmvgqfiBH/FceiWQeg+0xL2Db9qLrrMhHqMialgc0S6BqAPyf9iswkiOFwfSzAFOGcquplVRK2
	7Xygs109w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jquRF-0006AV-Oe; Thu, 02 Jul 2020 08:19:21 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jquRD-000691-C5
 for linux-nvme@lists.infradead.org; Thu, 02 Jul 2020 08:19:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593677989; x=1625213989;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=CikwZJW8VNHWx26znTojCb4ecI/4/i+10obxJCgnBCc=;
 b=EIg5Porw26X2KkjKe/hH5SA9qVIxjinKD6myAOaGMi2mBfZWiR6C9RZA
 C3mdbYgfMRxeYdWjxvEFC/nNU+h+rkkeGfio0awM0ccox7ho7PYC3DF0+
 ro/ZWTH9ZiQ6pU9VB2zVh3sXOKscMtlySxNifAmoXlNOzAjF7GfiDhipZ
 k2/glVO/zjw/wpvSCh+UPOreX38kIEBBSbxh+/BUeotMRhmxoIoCvHVFF
 rEFj6wGFXF8YR/dFRFsprXDT1AS6oG3BVH1Zrw1Rp1suv4kfRiCjzZKke
 u+4fRovSjYze88CXveh6uojLoGKbtb3yCXJNZeHyHEmrgHSD/NAEUCcUl w==;
IronPort-SDR: L5OuPCC74wUpKqsqLpTx1Gaallfj3YEq3qJMos+WjQfDe9YGbolUw0Mymk/VeTQ+8NvGUQ2pMD
 mCw6sEuGELvi+PH3/J7DluUDWNmT5lqJJOTL8K2Dwi4TY+3XycNXqwnNl2hqsZKbO4gNLuipsi
 9UrqBXmRhRRMb2QXKXiVkX14LSxcNiSomgvmWvoMkrWH9jZA9w9GRbWeldaJnp23GmVH9kzanb
 y+/FqxsbRuv+tk1nwBnHobz68VBi92RdtTDBqYKOhF7JsSH9BeiHxwB7qx3yCV10aGWf8vA7CG
 fV8=
X-IronPort-AV: E=Sophos;i="5.75,303,1589212800"; d="scan'208";a="244482742"
Received: from mail-co1nam11lp2173.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.173])
 by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2020 16:19:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cTRuQ3YR/t7FWK4zqdl9ydkNwxf56OcmvWFRzBwma8jXsv0Qc9G2fgypBj5k8WzQpct5NGy3C+TgMi0l+Dfvm9VBHYzpkQXFNc0mLXoizb0t+pywJjfcOErql5GWWH3+Ci3THS+XrRwj9HMpJk3MY37BqvJ2jYgdt9NE93bi4wrWZ9i6cJQ/rAOJxj2WprRzPEGlYW3lJr0/Ql+OcUWXOXjOHL83zJB8lmLHd2g16TPlN562sRrPUDwDBmA+TcwDzSteOYzYew7TnEpJY2u9hcJqZal6D6tB5LMF//nQkQv3jUyJX2IeoQMXwron1lBZ0Sxccd+HdlNPFk0xvJ644A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vk3CfVYCoSItK4738Eb+t6Yu8KpCON9TBDucFRhKIgk=;
 b=al4RQhESB0mupiS9m5p55WiQ80fwaCCFhT6CaX+0vzOXKs9xfq8WFP+zXFurq2XB8jW8bWqdBSd04bGvux/CseYf0lpxNkKYA3vxnAlMUxd8iV/9xSbxuU5rGPFsYQbKMeNwlk4G481HfOImE9sjqpiBvy3SYlc+rQ7B89+ElzRrGetT+cJYnybDP6Qq5v2e621UwpDK5orBXrrE4K6LJH26MzQHn9n9lbi+NF47WvVkOkuIZ1fN2cIBihvdHFy6jXxQzv0HQJZ+X1W9ESujyj+ruZSNPWYp6cGJKMGmlVqIa+kHybpS+6SUwozlBylKCRC5SK5mzFcdADiBhX2SpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vk3CfVYCoSItK4738Eb+t6Yu8KpCON9TBDucFRhKIgk=;
 b=CmH0wo8WOYnnxu8e3hJbcvZbCAfpckrMI4InNX4FJrF3cWiofe8RV88cE2YC2PSvgk9hsQZ4bGUd1f/gDB58iQXUTR96rZtyE2SVrUm3j8XJ2by/slhS+qcrDMMyTX4sL0C0FcB2JbnHlc5fWz7WauMvUQnFmoNWcZ4HPBeFF+Q=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN2PR04MB2141.namprd04.prod.outlook.com
 (2603:10b6:804:10::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Thu, 2 Jul
 2020 08:19:15 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3131.028; Thu, 2 Jul 2020
 08:19:15 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 3/4] nvme: Add consistency check for zone count
Thread-Topic: [PATCH 3/4] nvme: Add consistency check for zone count
Thread-Index: AQHWUD291bkJAxiw9E2ZyLERtVBUMA==
Date: Thu, 2 Jul 2020 08:19:15 +0000
Message-ID: <SN4PR0401MB3598D462060502A55417B1399B6D0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200702065438.46350-1-javier@javigon.com>
 <20200702065438.46350-4-javier@javigon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: javigon.com; dkim=none (message not signed)
 header.d=none;javigon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1515:bd01:1941:c6e7:22b1:48aa]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c2830f7b-73d7-4813-6074-08d81e609c0a
x-ms-traffictypediagnostic: SN2PR04MB2141:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN2PR04MB2141819BFE9614BA8B3F634B9B6D0@SN2PR04MB2141.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:949;
x-forefront-prvs: 0452022BE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Eh0QmfuhGs24p3kWtfGGe8tfovzZODbnSDLapaH66v+FNrtRDvwG+qNa4O8y+Xcnrm8VKqAz7drVElnnKSDaAIgnqUkh1Se+zAqIy3lk+hSzHmlUS1DISqLeRJ7SAzi5pb1ifp1GAZvysNwvGpNyBbvZQ3+E/dAIINAhasC2sYaf1UyTkfKIJeMcqhcBNYkJfZpDQaq9qmNMA1hjY5ZDvgnXQGd/m7y106J/X2lfZVRLjPXnW8jsGfxumg1HC0fOw2uBNU5idaCDCHvKb8qU8m2gglLZK1ax2c7Uw+x653uw70NsSFyBI5JAC2FwjAvn
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN4PR0401MB3598.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(376002)(346002)(366004)(136003)(54906003)(52536014)(4326008)(7416002)(478600001)(91956017)(76116006)(33656002)(8936002)(8676002)(53546011)(186003)(316002)(6506007)(66946007)(66446008)(64756008)(66556008)(66476007)(5660300002)(110136005)(71200400001)(86362001)(7696005)(4744005)(55016002)(9686003)(66574015)(83380400001)(2906002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: NPuqj1Myy6PABX48JKwqPEjUc5dqoiuslvw6b9MyFHLNDHnCchUi8VOb+wQXKHv+x+sRNHV8JeE4fCgw2i9fPA+wah/fH46yAUJfqPTULpna1KDZedvqnYUTHpFAJHoAPrqY5W/r9NMjwU03x6gunrol5lPFaT0UADy7SNTt5fHfE0l0K9RW5UHAFEuQalx0RQwRLLopReLQoCvlW2oEuT3iYJVR0o/N91E0ieYFcJ+AG/EocqAzQdKrZ5cDZLXEJ7yLplkyUpkEj+N3qVDnTSYU9zZvICS/rie02w69nV+NXQFu2teJQtfAR7pizeY23zzwfVlSYK1DiiBwh9L+jb7R58W1NE0SZSTjIsa1TZEOSgApqa1OyO166xBdGzTiQTd2aS6bagGJeIX0GbTdR3SrCqRybhm3d7czxFxvTFR3uVJiBhwOCgVNOPRJh9Tv9Tdeetcp6mD0bsNPNDcbnBYdNe2GasaouwQBbtOfziX25ir6mb2WyPATNNTrbiRK1Q/bhOAsH1Bx49DMOQE8quna3xR3G7O+zJu7XGmMwDQ3dCN6saOEFJ/gvdgDqNM2
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2830f7b-73d7-4813-6074-08d81e609c0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2020 08:19:15.5145 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7GwCsXUmSnQc0hsIHTDj3uJ+tkKcFimVTu8hOv0zNRtse71d6eT8gL/HgCX0iKy+ZD/AUhvw6weRRPM3A5nPc6nfSr7CzdwfzVC6XFUtyI8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR04MB2141
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200702_041919_554557_03859B98 
X-CRM114-Status: UNSURE (   8.26  )
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>, Damien Le Moal <Damien.LeMoal@wdc.com>,
 SelvaKumar S <selvakuma.s1@samsung.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 Kanchan Joshi <joshi.k@samsung.com>, Nitesh Shetty <nj.shetty@samsung.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier.gonz@samsung.com>,
 "mb@lightnvm.io" <mb@lightnvm.io>, "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 02/07/2020 08:55, Javier Gonz=E1lez wrote:
>  int nvme_update_zone_info(struct gendisk *disk, struct nvme_ns *ns,
> -			  unsigned lbaf)
> +			  unsigned int lbaf, sector_t nsze)
>  {
>  //	struct nvme_effects_log *log =3D ns->head->effects;
>  	struct request_queue *q =3D disk->queue;


Please no C++ style comments and no commenting out of code in an official s=
ubmission.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
