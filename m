Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D75EC4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Nov 2023 01:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dNLPkYkTQYeaa3gDeF52qFGVfsmGEob8s3TtacXA/8I=; b=N6bpH8UeGcCpOIvcYDPsNexvan
	cUMXAEtS4gMrGCOYLuwe53nx0NU2clWeKTmEd2cKEcSME3sTYQZYEvjCG1oal9aACFOq57f+QBn+Q
	xQkvjBdTRU8TwuWl8K4RJTpcaLw4mmNuJ+wzYcbZw7V+m4TM2BwcTzWTUDvnh+6aLQJfgGgr8ttBo
	+UMrPqcTZU2H/aLiEI6pNLBkBJi+6FIRs3QH8QjyEpwNkhXQ0FxG6Ao4aaArIiIlolKENc3/+2lXg
	IUvpmtwXkp4RoDH9oNt7nLcgkbxOA2ltySO+2aCUM9FPs1vcj0Wb37Fj0lRmtAkpSEsBbWYHZhdFa
	mE1ZR4cA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r34xj-00HCCG-2m;
	Wed, 15 Nov 2023 01:45:03 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r34xf-00HCBS-24
	for linux-nvme@lists.infradead.org;
	Wed, 15 Nov 2023 01:45:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1700012699; x=1731548699;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=oWhnDZhaPbZ5Fy3fkX2aVnHR7z7TIR5Fsc2zp/tlnQs=;
  b=HCYAozRCqMZZgo7jwX7/xcoXNbFL7AVmIkfXkYF1zSUm0NrMQgnaVIyT
   eaQLNWEijFJS2NIBf85sosD0mCjjwzeRia4wF1YZeIH646EcJyTFEg/Ar
   LYyozH4pG2yeUHMR0gkSMN8H/nYpolW41zaw78eRoH30W/3BhwFMf3sS4
   Nz7eRMdA01iQW/0OxylQsQtn+dxj7hNypv5DJbScsQejjpNLI6ORzOtGV
   vYwahZprOsmCgU/3d91L8zdZRMBXj4HvpA53CqbntPbb6Rn7i3z/o2uOI
   FfBuCMPBN+DuNhQcsCQYQWKpTyj8QTxolbO+phoWTh15CGfDh59i17w1w
   Q==;
X-CSE-ConnectionGUID: dIwDKLLAQQmla+xlsjk0Mg==
X-CSE-MsgGUID: bJ09DpKhQO2JejA2ArcHVw==
X-IronPort-AV: E=Sophos;i="6.03,303,1694707200"; 
   d="scan'208";a="2313654"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by ob1.hgst.iphmx.com with ESMTP; 15 Nov 2023 09:44:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RxAiPenpT+yVTWBDOv6OZFoWGhbCgpYTvE32krrwSIKgLJPBDnVrfTWQ/y13+JXB+rQblDXo3sg14TVavNRDM1m393WJYB5lUzBj/46iAUXl6mVhMBVKYWGJuzioXqE8B/FAIwaHlMza0rJurM+FvmmCeDjiSwux2+Q1mEHmPN+6EshDHAQEhf88if5NXev0r7+ovTLdt6wj484Hidnrxp3MYnD3LIx7B7yas2OFWYaLgzA8uXl0vsiLnhMYhUVn8YcAAAkBt6H8hW24WzGwPkiUH2v5XDzz1qd9CXOFE9qnd8FjiLF5Q80OEu5hVhmId8fsrf0HHoGLK3bgd/d62g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dNLPkYkTQYeaa3gDeF52qFGVfsmGEob8s3TtacXA/8I=;
 b=OG9ZHC2LKhX6ncHD8GWGVZa6ZBkiIRO8jTCad/LPnUXpT7gKs/mxhmEArG+blXxSab+zBhH1+DwiwXDB0EFSFzbH7csjMQb8iMAavW/0jbQcWQ56Z1FWzYixbwxNtoxK1rM8hPyvlK7/xnaPXnqHVaUcalGfqxOiaHDAJ+Ezvdzf/lv+K1zjjHAgeBQyq7XFzKpWVFzVVS6RCtYhMEXJIpxV1/LSeP9soQH+GdSc7J1p+UUYHNZ+ena5B+vZVmzm0vaP0W9/liHOCog/QRAdIQaPVutIdePYRFA6kxwoBJFYyET0ERCNetWEgUiSGNsHoLqvL2Vb6SQQEh+nAWLxnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNLPkYkTQYeaa3gDeF52qFGVfsmGEob8s3TtacXA/8I=;
 b=C+o0PNcRvi5/yvODGKZUlOHlvnlUn3L4lFGauHQnb1ZLPyUr2toW7LvoL43Kt+Nj/CvJ3lmb1h5hYsAoPQDfry4rbfVWY0go72zVLJN9+UhY47i1G+R/g7Hqey8wVen1PLQJteUx4cYpONZLiMiAgumPGgv/EeF9dbAa4R+v9W0=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SA2PR04MB7737.namprd04.prod.outlook.com (2603:10b6:806:14d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.18; Wed, 15 Nov
 2023 01:44:47 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::2256:4ad2:cd2b:dc9e]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::2256:4ad2:cd2b:dc9e%3]) with mapi id 15.20.6977.029; Wed, 15 Nov 2023
 01:44:47 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Chris Leech <cleech@redhat.com>
CC: Yi Zhang <yi.zhang@redhat.com>, Hannes Reinecke <hare@suse.de>,
	linux-block <linux-block@vger.kernel.org>, "open list:NVM EXPRESS DRIVER"
	<linux-nvme@lists.infradead.org>, Keith Busch <kbusch@kernel.org>, Maurizio
 Lombardi <mlombard@redhat.com>
Subject: Re: [bug report][bisected] nvme authentication setup failed observed
 during blktests nvme/041 nvme/042 nvme/043
Thread-Topic: [bug report][bisected] nvme authentication setup failed observed
 during blktests nvme/041 nvme/042 nvme/043
Thread-Index: AQHaAlwxFhZ7Pq3sFUae9Ji10PFKObB4sTcAgAIUnQA=
Date: Wed, 15 Nov 2023 01:44:46 +0000
Message-ID: <hzbl2cjkzrmjmqdp75tio4aqe5s2fr2fsff4vcqpwbi3cs6676@gs5hsnskbf2j>
References: <CAHj4cs8yZ4-BXqTK4W0UsPpmc2ctCD=_mYiwuAuvcmgS3+KJ8g@mail.gmail.com>
 <CAHj4cs8vqrePA-TE_GGNAZLG3iqZBq9L1GkanA4A0wRF_TXDeA@mail.gmail.com>
 <ZVJjtOGpulFV61ii@rhel-developer-toolbox>
In-Reply-To: <ZVJjtOGpulFV61ii@rhel-developer-toolbox>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SA2PR04MB7737:EE_
x-ms-office365-filtering-correlation-id: 3729c028-8b35-470e-05f7-08dbe57c72ed
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1FGAmV39y78C5sytbpcglmmLhog/M7F+b8tIx4JSjfcJa0amjOjLuTFnoQka8DYCm6jer273VRcufWzXG2/wLMFj6csVcXrJouMR4hjKXyKTSawM7oFB1AwsRuRO3UEyTyOwQFVd3KED61xX5nsn3e6j3X2CaVuj0pD143y1uspSO0/rR3mxtlt+3ro1xy12As+hpqvwvsqIU4oDfHEXJQhabDJWJ6FIEo2TC9edq2Ns0hv9dgWmJ+lkMkjLt3/Inx8EJ12Et5G/CBpofk/axoXkuC/MJRqmmSeGY2HwsZI53wNDjldbsa8oP+yd7RT9aAiILXg0xKI4m0m74ud+xPmbPborTzpm/m7LDnhAg0LZZU3Rw/XvhC894AE7ESSro9sz6t+lTVjKS78sIzLaaxXtCPY4zZrfP+T23SzDSMTvZvwUKfP3FbPDNaZhElFuAHtd2Y1Y++G0vLuWiB65WdZlhHFX8ecVE/an8erPNbEGX1shiosLyuNfq9/v2Fg7kUCjdRT3b0J4FtxY9XchbG0CwBsjCdoSyjTrtHW3jZutL2p5zz8CzHaLNi6P6v2PCDiqXrb9eKFqwzZ/yR2fzizocDmn6XxFIHV5EQwcB6Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(39860400002)(396003)(376002)(136003)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(38070700009)(38100700002)(83380400001)(33716001)(54906003)(64756008)(66946007)(8676002)(4326008)(76116006)(8936002)(4744005)(66446008)(66556008)(66476007)(122000001)(41300700001)(82960400001)(26005)(6512007)(9686003)(6506007)(478600001)(6486002)(966005)(2906002)(44832011)(6916009)(316002)(86362001)(91956017)(71200400001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ht7gWLKZqzIRk1EPYt/P1UZV4yUDm0Ok+PUvd69OmKDXx09sK9Orqt3Le4e/?=
 =?us-ascii?Q?tKz8HWAuctIicL5njbGnrxoKimDLQ4Bp5VWGIaQQ+xeIjTUIuVDQ9taSq9/H?=
 =?us-ascii?Q?aAhLVh3ETsqu54yb/cmwgLV3dIeArdvc/TDnsAP075tx1Bxq8td42IaeBn9O?=
 =?us-ascii?Q?EGOGkyquBiyeTxhy9QKoIs1mqcb9m3k411NnWfeTMbNZXfItox5oUO1AvA61?=
 =?us-ascii?Q?wYaOii2xj0PwtB+GhpsU/JxsGNJAXdUkMWgYrzmsPzkxuabJdG6wERAlle0c?=
 =?us-ascii?Q?SUWDSt66wHJ8bse8qoY1gdANyyIzL70c06BGhRCm0tzQSDZkLuojVzGlBrCe?=
 =?us-ascii?Q?1B4w0AZwNLaay6m+BUjQlbPhobmURAMgaYeawLVTHB4uTwzN17YkPBjf0X1N?=
 =?us-ascii?Q?VEfE3n59r2DbiUcyI3eYduIEkQxVeUvl9FRbjM5KKBTtzsw6ROBlK+ovX7Js?=
 =?us-ascii?Q?hHgUJIUM0rZXkXR0K5coH2WJ9I02mdvyW9ymnWBxd4UeagRh5oLKXOwMA0k6?=
 =?us-ascii?Q?ki5v8Ye2H1/LR36Df9bbp5uP+L0dt4Y8uv6t6rMtNGhxY/Mj6yGoNX7FtVtr?=
 =?us-ascii?Q?sxHDyVU4YWJ5cl4nuYPq6tRgf4cjloB35AAUstySi05deqGm1p4AVEMCHbmQ?=
 =?us-ascii?Q?i/8fu0eGZq6wGOudsfuztwun/PK0iKkkTp9s7wTNOxiEdbg96wAxks5zEJAo?=
 =?us-ascii?Q?2wkq7DlB4pnkqpkkX4uSYdSm/2JCSBBWB80kVPsbZOVqPrYhorO1mSLUaMtW?=
 =?us-ascii?Q?A5LUqXyUPmJ4OKQyMa9xppvAGT+R5/TNyVz+4/kpt3AzdMo2oHm6H4ny4i03?=
 =?us-ascii?Q?IZw3uvwoVNAmg1mwgJgaRlUBaK8qZnbG98JyEnfbR5k68xW4Gu6Fv/ZuJyDp?=
 =?us-ascii?Q?pQ7b4PkgL5KKCwqP5wtlI2AvllHxn4CWDjP2iQfyOJqNECF8srFT5NMBnMb7?=
 =?us-ascii?Q?XfdoWEhJTuVWSMMbcsUhCP029RjWmD5e3/eL6Bjq2+HRFMUikRAsrxUW3X5L?=
 =?us-ascii?Q?vi/TXqD3MIvcAJUGAPUulvlM98qGPeaJBqbb1p2cTB5qlusOF9we+osnFQb7?=
 =?us-ascii?Q?iIbPFSG8u66qkmw7sJZ0BwePleFOnOo1Vp4VRxXXR/rXbStKevy8GPL0O04T?=
 =?us-ascii?Q?6ISZ3hVlAQ+5V5UB342Lyzu/+5DMyyNHACMxzaZbkZvibT+cxiMLodtjENeF?=
 =?us-ascii?Q?Q2Cci77XLw6Jaa7uutQgUWSd843x2d3u1V+w564ghnqNNaMGKIRpepjH5wXW?=
 =?us-ascii?Q?CPf3QfiIEUcCC1GNmiPWQUuca7rxK9m61Ljy+5/i/CiExHGfAh5JAm1nzFQf?=
 =?us-ascii?Q?+dhHySq3C6Vt6RBPuw+FLi7SD/ydNJF4TDrT2oeVy/ch1ZALRWFrUKjc4Npb?=
 =?us-ascii?Q?yQVHT07mVljbktvIYCXwdgTr6ldz91uryOrDbWHW7YoLoFXRP6vQ5cEczx9O?=
 =?us-ascii?Q?fDP9DWgPrIGfuwuTBT5lnqlL0faC8fo1yv0SkwYxMN1pS/goBUJxZJ3NS00O?=
 =?us-ascii?Q?hvmfN+jsh4g5wI3RhQwhcMLQkEr+n4pO2CwnfJeAncOKjqEV8vwCaf7i+AJn?=
 =?us-ascii?Q?boOaEE7VzZA+21e0/r0cToy2FqQbpHruWh9yqJe6AXiout1e7wu1LIcZqAEk?=
 =?us-ascii?Q?hne9Ytj7u/v5budX1RieJsY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B8021EA47463D64694BDC71739D3308A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: RPVqt5BDEi0Xv6nKK2AC75XKkRFoxSz9j2dxG4NHkvHzMjAjZ1DzVbX7CRzEEPgiHqXQ9o0Kp2UhBNHhNJVExM0Jhr1XQSOz0c+4XJqnSTf1L02SG8oX7kPnrGM8PgUNEtkxnknxhAKBXEqTjXIS08GgNO2/1nNp4xeP5R2RHuaEG/L3TMc36RXOgCM7W4oOXzAVOmPS/IpKR693gxmKa32aA7053ds7JhzhmLahaHbqZbUwxrcFekVSkBd5TnRL6p6zmxB2KbaDHetG4ROAOmGfmUQWYMsFFmSDV3U5CrNQt1x5LEns2EwRdpXWZ0U++hsV+GIdkzhIM6sCThP8/1ZY7WtIWn3491WwRaGyTZfeYuLZUNt8l28yzV4Jrh5J7uFPN5XEvQ7IxTtnpOOli1ZGPZ6J/LI7Izt21+SCpDl2V5Fg6Z4GSoRcuE/D83gWPrOKLsHMvbOldsR93JKr7JZxiGEXQiwxxPKOUq8I84GXNii8BwixHxT9Se2AKLIQleiMkW3N2znMxB2UILAnzTHekZ+VyBUhyzYZ9/g4EEoe6CAiPaY3R/BMCBfdyonj0RX4xoa+fXDYmWf6mE6nBUkQvQn6CpWuztYRQXgpkLf4EjX7wCqbTIBcq5J529TJpl/EktmML1zoMR+w3dJYqFpAnb7OtdsiTADCNoLaRhKnW6xUSblO07dA82bqaoBuuvbdheGQF/TmGLe6bo+2cJscZ0LiU6JaPkISFQtJs/H6uyTIyI5snsM+Ql8vCXWYgZojJbBrmaJTjdRAKVh/DcRvb8zQ0O2zQNXd04DJ3SOzHzaTjpL9nTsHiv/AeCY9E8FbILgLWIiRlnKq963hSGwj4HhjC+s6wHsYHg+LgW6fFFvLxQB0Wu2SN3ZTZOKADRhTFNgUVjaHhs9iiwGqdLk4hVZV24nncjHzY3jPLK0=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3729c028-8b35-470e-05f7-08dbe57c72ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2023 01:44:46.9567
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2l3u2eaKgKaYStp/C/gZRmoAP6IR8YnCYf7UHxMTF66Hw2shzDztYRXZtdE5zrtXm0z7eqm8vreCzM/By0QEb1cnO6ced6+kPYtOqbSTHuo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7737
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231114_174459_791504_432DCE1B 
X-CRM114-Status: GOOD (  12.12  )
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

On Nov 13, 2023 / 09:58, Chris Leech wrote:
> Hi Yi Zhang,
>=20
> Where is your kernel configuration coming from?  If it's carried forward
> from an older kernel, it may have the NVME_AUTH symbol set but not
> NVME_HOST_AUTH.  That would now just enabled the shared host/target core
> auth code, but not the host support.  I think updating your kernel
> config to include NVME_HOST_AUTH will fix this.

Hi, Yi, Chris,

I observed the same failure using kernel version v6.7-rc1. In my environmen=
t,
five test cases failed from nvme/041 to nvme/045. I enabled NVME_HOST_AUTH =
and
confirmed the failures go away.

My understanding is that the test cases newly require NVME_HOST_AUTH since
kernel v6.7. Now I'm preparing blktests patches to check that requirement [=
1].
Will post them after some more confirmations.

[1] https://github.com/kawasaki/blktests/commit/e0d9d4c8b981e291baf25c61798=
02278cd726521=

