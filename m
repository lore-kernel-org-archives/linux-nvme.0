Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78B0DC072A2
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Nov 2023 04:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E+N3orFE2kwqnGAgMv2tNXOJhXa1647ISpfyW24L+p4=; b=hqSsQ5Fb6Z3AquQQmpW6w49SwK
	KLenZ0j7X4i+Db3HEeXRTzBa4K+EQ+xa4qccS7GSUPb8/DMHr9Gq9VKxfGFC5XUcwkmt3ZzW/hhM1
	2kjRvN7ldH2lpVLygY5ZoBaH4Tlt3LybKmzJ3OamN68U94IBEYOfBFlXNnETPLiPvH+YUuFE99t3e
	EnqWc4EtLlvjhyOIK28EgawyxFCXQpeJ5B32Ulzgxy9UmYT0h4VcAHzUbGQExe6JrdDLoOE6V4Qbz
	vXt/0wiV9ZjUYHPmd5EbD4yYZFEQ5g7tmwsZqDIQ2NxeaR52IBbYj91pFkZFcoUVmkr6cdJhVXrEp
	YWHK2Y2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r3qrD-005cxS-0O;
	Fri, 17 Nov 2023 04:53:31 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r3qr3-005cwz-10
	for linux-nvme@lists.infradead.org;
	Fri, 17 Nov 2023 04:53:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1700196801; x=1731732801;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=E+N3orFE2kwqnGAgMv2tNXOJhXa1647ISpfyW24L+p4=;
  b=SESal4tsFgGncM5NMM0aTi3KHJq4fRJ7LjGxMDNhpwld8FwgqaTpVNbU
   QhEByeiEpjbaf5dS9fprubeT14eZd1nV8Sfdhxri4A6r1FLYGGcVbW3Ib
   17CuDcgN95OPrO/JK35OUKOQ6Fuqb4PS5+1vY2C82iQYrpDvn0v2GPWVb
   8f64Octbn4OEwJwhHMUqzPajEONw5aR+eKll/HR1TKY22Eog/t/9aT2Cu
   s1cCuAHC4nPxeNh5I9Q4abxtcXYQWxlC0g4acgS2WgKl+6IIgWZaXKWfc
   9lWdd0hZTiFj6LWR2Orjx7uTpa71Gy0FaDSoJj39si06BVCw/ol4kvd0J
   g==;
X-CSE-ConnectionGUID: x3BaHRbWQsOcnnLbB3jhEw==
X-CSE-MsgGUID: W0mBmHv+S6iv9T4cdSsqKg==
X-IronPort-AV: E=Sophos;i="6.04,206,1695657600"; 
   d="scan'208";a="2549284"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 17 Nov 2023 12:53:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJdwh+ydHydWXUD2+UDF8vQyxEmQuuxUn6Kd7FMVfMYdDflG3DAQXrewS+SzVTtxL4ICXcRjzcyhd1FkCxq5YPncrD50FIWoTkgMwzT3h3qrmgvJTElDK8PVQkApvFqs41IR/HIg4pZZft8fKB2M34Ecpi5pdXClxHCgRwx4vtIlHuEGCatTkGVZOCedWqz8HbZjkADERgXI49xT6PHtsIZuVsjc6OceaYA5nlT2+Ll1btsLp5mFd07K8ZU7NM1mU+qCPvwAyed9QncK/mzFSe0kx82jbe7NjOZjD1ftod8VogIol/LTH50IqrsE/Fgs48Yd8w4oVyLEoXziNyPrUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E+N3orFE2kwqnGAgMv2tNXOJhXa1647ISpfyW24L+p4=;
 b=IIA3cNAMeWfthUzP6KjvLPna1+4c5O6kvgQeiiFGIVHI5GXnR6otHTQrBLs7aVk/9YCz2sqaf7tncT31ARuBti6LFK/G8vt7YqXzP8N5ykSLc8ozQ890cwfnXKkjVaHYFB/JWFTksWvlfYuD/rGMzWqhXp7liwcJAJGSEWA81Ldz1hv0qeuvj+/3Ymja1HrBcbLk9oPzysBtJ0x39z7Ua/1oknBr7Q7A3QDEZmtL473b9KZ2MQ8JffMJkTffKil/6Sla3rdWYUg6WNdD9MDtLYixrRhnfCLjTbYYm6BC5/AiYtsOdDGOpUqhobwD8z5GCboXk8dYVkRDRxiFgY7Zkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+N3orFE2kwqnGAgMv2tNXOJhXa1647ISpfyW24L+p4=;
 b=Ucw157h9LaW2XitJEICWBf9CdcA3Dh7tv/oIjDmO4aiEhrCjiC1HaPayI42bVE+MKtKCdeVzyNqQbCQWCv48y6bNP4PYX31qkD0BPmBpdLjD0qCAdm9lIB4bWZ682aBtxRBU8JiHw6KWH1iMt5o8TlfZyzKghQwcHyfX5dGUw/o=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 MW4PR04MB7364.namprd04.prod.outlook.com (2603:10b6:303:79::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.31; Fri, 17 Nov 2023 04:53:14 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::81a9:5f87:e955:16b4]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::81a9:5f87:e955:16b4%3]) with mapi id 15.20.7002.021; Fri, 17 Nov 2023
 04:53:14 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Hannes Reinecke <hare@suse.de>
CC: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Keith
 Busch <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCHv2] nvme: blank out authentication fabrics options if not
 configured
Thread-Topic: [PATCHv2] nvme: blank out authentication fabrics options if not
 configured
Thread-Index: AQHaGIZ9m5f/fgn6FUmwaf/VLSaNi7B98uOA
Date: Fri, 17 Nov 2023 04:53:14 +0000
Message-ID: <vhsku6krjngroeb7f734rz5axbkuwbsvedmd7xaht2zjucxdax@rk2k3xt7fpdy>
References: <20231116121435.17340-1-hare@suse.de>
In-Reply-To: <20231116121435.17340-1-hare@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|MW4PR04MB7364:EE_
x-ms-office365-filtering-correlation-id: b944d5be-2039-47da-b0c9-08dbe7291bb2
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rYkB53UYdXH412R9jESPZDMKb2uoDH28BkHXUw5pM6SAE/P+cEhmiTVW1hILcuXlfdcBm0N9oNuB0U7HtQgjSha+sbVLzG5O5tp620xYGyF140ITcs3l97+XtEBGsvkfhrinvH/OPZKMfiCSZE9ZndUjSDxqLP8vYtdHYeksbMiik4wvVUSE4Gu9V2fsugwe68ZBPMym61Ywf2wvBMMNdsTisBPKEFmmW6bX3BlDHpCA2iG8FuzLnpKpCDIokH6vgYElQwrJbKPHOVT068oLyAM4BnpoQMz1Zk7DM4afxabNlCNZGZDw9O3rfv3wgouOto7ScUtt9O1WvPD62B9id5KlTCFq0SkoCv4l6xWm9FJMLOkE/5uuuwpTE9IG6YHd0erCHrvMgN+bPTm0HOihORQIThgqTMfGJrf8CpZgvvKb3z4j0PaVLv0cVtx/gyrtsjKTLbnsKmxgGgO8mcw/XcvCZDNsxSikOQOVc490AV2V+JpmYRSqplGWcyj9z5nlZBravkV5rlqzdE2XC3eYB6XN1Mu+Wv+iNU75BBcaZOAqvxgmfWyFevW/aOH/4lGbHujZeePnkAfi8fkKiKRSHxPzv66pebYNRE7Ncs4oNXI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(366004)(346002)(136003)(396003)(376002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(6512007)(9686003)(2906002)(4326008)(82960400001)(26005)(38070700009)(33716001)(6486002)(478600001)(966005)(66446008)(44832011)(86362001)(5660300002)(41300700001)(8676002)(6916009)(4744005)(316002)(54906003)(76116006)(66946007)(8936002)(66556008)(91956017)(64756008)(66476007)(6506007)(71200400001)(38100700002)(83380400001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OoQHp29ID3a3tGpNdV6+BvOBmJrnoTA28wBJ8/R7Q+oAAWjyRKfYzdocxiAt?=
 =?us-ascii?Q?1v/BK+zITP89M/63HOsNO8T2QIq9dF0+BRj3A2e27PfQLy163SOJH3T1Rvyz?=
 =?us-ascii?Q?9Zt7UQnfHt1eREnOHfl35wnckeNQHoH123v3gq1UPq1nNiiRQMVaSHoUwmA6?=
 =?us-ascii?Q?eesC8sYKVIx+uH1hTiZ1YzITGg07/VNGugwXfgBtLGHHZsizcEspzOdUlC1N?=
 =?us-ascii?Q?H+NEf3VjKyObsbwehbOC7YBwJcGtWUefC7Scu4xS4a2FZbwE4Tjby6Dlhfwe?=
 =?us-ascii?Q?54IjPnrirEpR5zm64j3GUbj7OQ8RbzFlxOk7GIJMeHvNb3mz984rhp/Jfisk?=
 =?us-ascii?Q?zS153bITACoFA2zqkPnhHRLXG+HDi1Q0c3F89m8Hpd05TZKSXkjm14y0UXRy?=
 =?us-ascii?Q?CEYuMegyywhNd4qu7xjn3Cf1WEuEnltkdCKNmAo7c+Ti778QXxReFd/oeUhn?=
 =?us-ascii?Q?E9fVxlCM7g6LNbFRkUWLOwpjFaqMnz/CRuVQgegE3QbSEoYh8eeyy+tXKb7r?=
 =?us-ascii?Q?oCXCBBlyuS8BtlxDZowZfyrtLnkRyW3UFtTyfMKHjVWHAPMO7t/TmMiOcuyK?=
 =?us-ascii?Q?GXLIc881u6z2VmYYzeomd6X+mCkD/+ys9EYNabhxmghuPw05YkrDAbLpw4Tl?=
 =?us-ascii?Q?SLqOJV7NJM8Om7mZwwouV9bhNhyyjo2dK8JAA2Ub8rqtixjJJ8RLQTIaMn88?=
 =?us-ascii?Q?ioDnnum2PbnGuw2SWFbvfIm1fw43Ug5lXzp5qH7jPcKvfnnnSuPt5gP0gx2u?=
 =?us-ascii?Q?9U2O+AQtSq07GMJb8I6j7kfJouQJ2XejIGY12Kmi1wb7gGSJ8BfTgBT6feOE?=
 =?us-ascii?Q?FbHGrMOXiWT+24acnYbkpqr6KvZXM4MDyPszLrXg0Q5IhhydMNqImtJijUdl?=
 =?us-ascii?Q?AUQBveE29X23IZ2BQ8FUjgPoKFvCW43iw1w3wNVkY5C3cWxq3oVW877fvctx?=
 =?us-ascii?Q?R2cbb5kx0hF6kC1NL4Pr5awvjqcM3Ok0Ibr2i+K/OU6soeGTJ1ftRxuaY7dX?=
 =?us-ascii?Q?wVJs0gTYt+xwUEHpV/w8JjgY6rRxcjRUer6xEsR8E/3VHHhVbqYUwVH2TZkp?=
 =?us-ascii?Q?YrUga7whfhuT9lq9hD5fbRth0cVmxIit4xTIUPF2iSzybYqqxqbu9/yNhppK?=
 =?us-ascii?Q?7ML8lJvM8aeVgrbuiq7ff+OWxek3sxjOdsj0KcqeX/yMqMgyxqyEeJgj07O4?=
 =?us-ascii?Q?s6jN+N4P+FGtGgE0t3spnzODeAyt6nqxKFoHy1tSloDXjubrQ5H6B+qCnCb9?=
 =?us-ascii?Q?GYpFDyWqhwJLajlSJY/JvJoKhl1QGnuCUTe+SxWh4Yd02h7ChMjgtIybIKo+?=
 =?us-ascii?Q?YR4A/GBE5OskZacAji/H2WvIkBXc/s9lyJee9v8ghitwB1O5C2g5Bdh3ZR69?=
 =?us-ascii?Q?kBxkfn4S+Iq3lgF0xMYI/tUTznAHfrK716xLK1ehHVOG8wZyfJRNEtBfPR62?=
 =?us-ascii?Q?Tsg9emjycmLQqrwlfBceYBxfBDaWiA28NS8v3zWJPrHv4uPxwieSyazf/fr5?=
 =?us-ascii?Q?U8x8gD0kY3XdqmceREIadRLwav809k27tMROV2KHr14uK39h4Sr5o4LjC39/?=
 =?us-ascii?Q?KJjGjzU2NHY1/d6VWpkL6zTDMiTnRvHncgknYsAZFOySOa+jp+AcyTcRFQh2?=
 =?us-ascii?Q?nWTrgD53cfVFn1y+thWwLDM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A8AF0CB59B772443A7DA0E7BD4156D8C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Iq4N5StyHTv6VDltu+JEDjnPyP8wrsUZ1B/TqlSh3+pT6aJ8BJyWTLqinyFld0JxSJYEulHO1FIZ2qZtM4oTIGIXhHE+tWIqPEdijrDkoA3nR67RuvotBP8z4cZAyveW5iuOw9+jKExXJB41Bql0x8J4H/xaPVGRIIfrYpwriZLzAVPpklK4vQ5yiXazB59DFPDjIIeKYa30CIk5E9gm/6elIBmP6yq+bmcK4NzkUtFTHPM2lku8evbVsaGfkqEBkukyhZy33R0Ig3m1DNAc7nzY/N345zKBy/W1gJKMgWKrTf+ogqLh7Ugh7gLw5x6rTjJNXm2h86lDriY/5lHA9mo8OUfMHx1feD0Dw1XGRXuDaAGAFV8jz0s2hL2sz9YlusfldnIdKRYx45+NX6hdtcpbAOj3GbuzoVMdkibmhfbUwNwgNm50mND8dZCuiRo8oWptzxwleaHFryAY0+T2yR+rNT2AWLWiOvLC3IdI+EzEEI+wdEKuxze2jwvCSSfuSU03MtQjM+5PF0Z67RB+k2VaRT7hC2CwpXGPE1qe3MHdYFMm0gssBxGYv+NRmE28xzR33Rmn9T8xycwX6EiAmMd3SxpqOcqtZYBNL5KQHLGzP4kNBShTy+jc5xg25+5Aoqp6JT6SC93a4DCtyTKDwB0DqI47nwujSbCJguTO7wliMzfiNo8+m3sMBHPybYNyIH1BOxL8qQ9vJzMDfYM2TaRjv5WMsr2fX7iB+5WPNgLRoFEECVEZrmOR7foW9tQR4UL9+HlXeNa1QkU1mCaGi+aYz43kawRCUrHtX/YoXnzlssk6EOnRzGQhgvZ58XzMV5fCzXnGqs2cU6mnFZ8TTc+hLNcN016/MOFnSq5g3pUNJuOU+AD8WK3r3q5B1yvSdcFNmuWSDJEAO0zeitQTeQ==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b944d5be-2039-47da-b0c9-08dbe7291bb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2023 04:53:14.7050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yT+boTxeM+r13cEhwdR6Q2ZWjcGx4RxBRL5rYbBWb3PCSbV/bXjuFfgvMyFxDMYdhfirLG0W7S2Xp99l8B8HyetIQN3NNvhHFohscrzjS54=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7364
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231116_205321_928877_241AE085 
X-CRM114-Status: GOOD (  12.39  )
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

On Nov 16, 2023 / 13:14, Hannes Reinecke wrote:
> If the config option NVME_HOST_AUTH is not selected we should not
> accept the corresponding fabrics options. This allows userspace
> to detect if NVMe authentication has been enabled for the kernel.
>=20
> Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Fixes: f50fff73d620 ("nvme: implement In-Band authentication")
> Signed-off-by: Hannes Reinecke <hare@suse.de>

Thanks Hannes. I prepared a patch on blktests side [1] which refers the fab=
rics
options. Using these changes on kernel side and blktests side, I confirmed
blktests can detect if NVMe authentication is enabled or not.

Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

[1] https://github.com/kawasaki/blktests/commit/81110ce8056f16716d09774e6f2=
37ea0393579e1

