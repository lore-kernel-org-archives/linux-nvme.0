Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3967BC54FB9
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Nov 2023 11:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z2JrYzYQhRqdcxFmOtYMrhc7eYbzx4qwvaF+EBTawyM=; b=DfzCnwFNON72TGDWTWRpF8QR9e
	id6+liu7xxbRldB74UoF/439OtWwDqHjhAC4ksk7JYNZ4+Rmd7zyObz2xi6Ml62QDbo8rY4bYUkcW
	M2tIDXsa66wmDtt7D7m0Rwvl6glO9CUpNzM+VolQmQbY12PNyW2O7o9D/XlOie9driRiTUfGSY26s
	fA0jbTqbmt8yD22qzVsAlxMhEYbCWOX9kaFqGoY+4JaS621h2JNprf5Qb8/WNGBx2ISPmkMfm5ng2
	ugmFBGByxWlcuTg0NmbdmVJfw883NCbFiT5E03DiaBE27kcu6PIns2U3MG9x9CHnGSut9q0grwjn2
	9EcQ6xAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r3a73-0039oK-1C;
	Thu, 16 Nov 2023 11:00:45 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r3a70-0039ni-2z
	for linux-nvme@lists.infradead.org;
	Thu, 16 Nov 2023 11:00:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1700132442; x=1731668442;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=z2JrYzYQhRqdcxFmOtYMrhc7eYbzx4qwvaF+EBTawyM=;
  b=CiKWa/ZMTMFSA+J3G9742BYl7fwgD6spxnAqf+4MWNIt7B+A5bZHlmrQ
   OD9eB+GXBcFXpvZV3eNd+C/THICHk3ernoTh2rAU2CmFJeTxnzdcAcWKA
   zzzApxl3ExcTqJnJ2en8cd2ZJ1vJAdRftsKJVyyxVY8OEL2mwxolFxBxL
   qrfUrqRDR4gDZNS45NLlRLf6HeIWFUqUheIZl9ppuEiLmTvsxSnnc3A5H
   TVJb/lbCTOxtcJr2s3TmMmPpRGoeg2DGO5DHqMnBtaZ2P1cbbEhu4FnwM
   jxG6zIf9lGs/BvlFouhfJ8a5FEmtgpPFXUmjNWfRRy2dwVE3cW1XQ1+fD
   A==;
X-CSE-ConnectionGUID: ot3Kb74xQISHguEboAYeOQ==
X-CSE-MsgGUID: 1knbozIuRnKQ/a5NdVFnJw==
X-IronPort-AV: E=Sophos;i="6.03,308,1694707200"; 
   d="scan'208";a="2432628"
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
  by ob1.hgst.iphmx.com with ESMTP; 16 Nov 2023 19:00:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XS1zn6DrlPOpILWsoSgVlTeBHh88iIdRbXZWu5JErN2gDPb3Ib+GdGk/WJOuK1/IhDgRqlTqQDWGVrec1n2IEtudiA0g1BUry74DReiRfC6U/Gttk1Ep6UyNEGtPiRVfTxdYhq93xrdzaJj9S2o0TtUq5GvKlii86F4RiiTyaZQp4UT5DBddSZNSH574fn/A8Vu+W0TN4Ug2zB/ATonSisTwS+OY1XAHbNHgSdAh+jZ5WwRpIvT6K6xXAmEN7N4nPszkina7N8z80t31RTB+Dm6WY7/coZ0edjjosK40qa3bhU7xw2bo7/C1QXacC8kagB0fkGr9rHc0tyZC4QCgvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z2JrYzYQhRqdcxFmOtYMrhc7eYbzx4qwvaF+EBTawyM=;
 b=iIEeqHU4qEss+eVW2ZmrNVlzHbvf7peHplLBdpYUVyuE1mC5YMv3WVr3Lp5GuRI8GiVGLYXTlvEUufhBGHMXtZ+HbIP1rkNMqF2EEBQkQRPLto5930A8x9KldXTacMPWZWXLLHcqEiiVWfuB1Z3cc2maoPZhJ4BYQ1tB6bMvjMrK8/FtbvvQ//5yhbhyCkI/TpbeXOkKfhiLlVpDWCIyhQE38BchDBNX4/5NVP9Ofg0F32m7HHUTHB/KaJgiVcue3hvKcpgiQndJRntAtC35lHQpJbKCJpW8M0O7HeVZxo1WySyCITSlxDx+Ns7u0kJ38R1LVAoAPfSIsCTDKeEjJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2JrYzYQhRqdcxFmOtYMrhc7eYbzx4qwvaF+EBTawyM=;
 b=M8sjAheKJCRRd31JI9Ju6VOuS6Ux+84q+iRImkz+3BJkf2Kn5xT/dfan3+1NdvCvqKyAyTvd2YXagFjUOsxQbFq541yj8mjoD/rWRM0li+Fhc4PSOpFfwcu6pLwMO315eWXgwJnSs0jz7JIO3Fvw7ui0l7grvuLiZg7gL5nC6AI=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SJ0PR04MB7566.namprd04.prod.outlook.com (2603:10b6:a03:325::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Thu, 16 Nov
 2023 11:00:37 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::81a9:5f87:e955:16b4]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::81a9:5f87:e955:16b4%3]) with mapi id 15.20.7002.021; Thu, 16 Nov 2023
 11:00:34 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Hannes Reinecke <hare@suse.de>
CC: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Sagi
 Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Maurizio Lombardi <mlombard@redhat.com>
Subject: Re: [PATCHv3] nvmet-tcp: always initialize tls_handshake_tmo_work
Thread-Topic: [PATCHv3] nvmet-tcp: always initialize tls_handshake_tmo_work
Thread-Index: AQHaGHwfGpnGV/U9YEOit+aqsplRwQ==
Date: Thu, 16 Nov 2023 11:00:34 +0000
Message-ID: <fji2ew4cctjhsiwecxzbpxjw442asqiw45gnfkoqaaolhtasfv@af66hnl7hwb4>
References: <20231020050606.9464-1-hare@suse.de>
In-Reply-To: <20231020050606.9464-1-hare@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SJ0PR04MB7566:EE_
x-ms-office365-filtering-correlation-id: f1a24b28-c936-4968-9542-08dbe6934247
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cwVZfKY6+bKBmOqOq4jLRRF6Df6I1FhlM2Yq/wHZRolEhpOFvGZefVpbv999AA5rcdcVJlp8dPUhZFwi8iM+oPqnhlYlc6HFoeqthzX0xzSSZhhzQWQXH4gX4LPTH0aU8FB9tFiPxlI4BYW2zRki+NMbf28WWMZwvgdTa7yOl/1R1mUrxBH1Qb35/JCuU2GZhHD1kkgjPIj1yLRbKa0fVUNet5RgZNNUV0jtd56JPcciiiXGaQUk23ahdt/t03GbMgW4lh5ZNsf6/srOknUplKJmNwysNlA1NjFmduPUZARgP/K1lYg4zQuttb8qcU3Iu2fwY4X2WbnONtYyC5vLjZByr4RFs/5Y2IyDlfix9HPFMoYrnD8eMGgv8DYnNlIeBqzoZefAwNRCO8IBDxWmdYfk6yHnM6XPPNofWDEa4DTichhxRRYQCr5QRr+NXSPbosLqdnqic7Y51S0kTqKQqfhhm06v3VrYSSZnQiEV6OPZZZdfkb6viOZGFjghBpiVMx0xYvc0Fxegi5D2egIWU4PEQFkiR5LRnlDaHNahBZIzokLSrSwxx5F58/5GbZCYFepxTrjTyF67lQTPViQyqZDfFIUNzHKXwWCBO0kvxf8iEbkSxqVvKYn5J4lhlOus
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(366004)(376002)(396003)(39860400002)(346002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(66556008)(6506007)(33716001)(71200400001)(41300700001)(6512007)(9686003)(26005)(4326008)(8676002)(8936002)(5660300002)(44832011)(4744005)(83380400001)(2906002)(6486002)(316002)(478600001)(54906003)(6916009)(64756008)(66476007)(76116006)(66446008)(66946007)(122000001)(91956017)(86362001)(82960400001)(38100700002)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WlPVwO2j6Xf4kRCZGoEcw7Xqj6aECGH+9dVQfo8kcTKhWL5ojFzkmvi9IcMu?=
 =?us-ascii?Q?qo/H5aDa7cIR7HGOLmSEsn6D+t8kDTsvIHxw9nDUWCwpQsO5zpTi2l0btW3Y?=
 =?us-ascii?Q?gLTgZWQKbnYDwZLsvyzNmvkZTNBxP7xcMB4ydbTJl+rC2CoX1cRnYQ1Ljzmw?=
 =?us-ascii?Q?6L67WShEEAa8BVIgQAm9z5aBnwzpwXnCROpV7iITqxsIIoUDfTDVTerE9M3B?=
 =?us-ascii?Q?UGZsmbDEVODEwp7zla+3f7t+lTrVtL+e55h7B/+UAyS74QsKZ+js3NRweao3?=
 =?us-ascii?Q?wPubTlzeXKHOzL++I+HVDiTjkfcFHel2e2JygoAoOeM5TErJvTjbKSqDNWzI?=
 =?us-ascii?Q?BJQGSYbPA6HqkAv/X2KN/rb7/DTFYqZMey/GJ/ZcouoYhKGowIIvjZVQWvlI?=
 =?us-ascii?Q?GE3lyjhMEvWRelAXrEDE3cg3X/CO/uLxiAaYLQUy1GiyZ1hCltJgraq9JT/Z?=
 =?us-ascii?Q?Sm/sjLyUF2vhF2uQquHC/Uit6ftb0apI4x8M1b+0LsyqssXgy+C2ARGYBRJm?=
 =?us-ascii?Q?Uyad3d4EeoXQ0SJKbEPQuJ4RT/H1OmhXvdX/wb1p/RCZB+a7LvVQErpQEEnC?=
 =?us-ascii?Q?ohaN1b3iWgci7bV8zL4FR+BABmUXG0WMueRPlPqYGn95Rfe9JFLlI1OvhwgE?=
 =?us-ascii?Q?zx5JO9pAQfLkc1w10zlHHS9vLT0cZl7rcuVFkYIvjZ6H8biVH1PxSKkcpa+F?=
 =?us-ascii?Q?SMB5mOhqgyKvnPDwaptHoOh3UOT1HjF3+/Q/dgQNZ28xY8okGVEIHj+dq/wT?=
 =?us-ascii?Q?3RyUkRH97afyMS457rt7XVWm4PnaWZh3IgzTaIXh7bQp9EqGyOqsrUI0DHMr?=
 =?us-ascii?Q?mmrUruQz9s1CdxsDrqHgMrX212BnXvqq2F2eprhdrfL/+Vw+QLJ3aGDQiSu2?=
 =?us-ascii?Q?hndvoxoXi+fz6syoBL6c8TVbKDAbfz2G3uDKYWAIcqKHK1hR8dtsC/Xr30GW?=
 =?us-ascii?Q?wbT1BMvFNF0pG2mZsGahGUKMQfddPG90EmgbpO/VYgw+QtpAOkexeWIJ7IUl?=
 =?us-ascii?Q?nfDnl100ipdg3c+o02blr5beuOET8oMko2cDZqEpEtBjeawaonjBJq8De3ka?=
 =?us-ascii?Q?cC31wiS0Rw8qLuiJYdhoPTsziaJLaHvtJHjjFloA0mNN8qyf2q6IzcqnT5e3?=
 =?us-ascii?Q?6+F41huSGEGQ0QLIcO49zZLUuh9YUq7/O3m3PbrNk2QagvRdAelO9l6nNhaw?=
 =?us-ascii?Q?d9Kr78UH1JsQB76ZJNUT7jUvEm+qGGjy2Nhr4jdlwwHJFd7og8AkiDXw3eJb?=
 =?us-ascii?Q?h2+RHyPYd8XZVGtIWexIJQ6u+7g8VfOvOW0W4tlmvfwCWrKTBvVWxgUi2jHA?=
 =?us-ascii?Q?dDE3Qc+C2IkQyCLwzl4awAjcCCWmyJMst9cwv1xhfApcevYsnNEDfQbPT+BO?=
 =?us-ascii?Q?/EOJi/bVkJESmnuHnWdxsQSjCXh1QigWD0pohSuCS1ndv1VkWHxODPnPzfr9?=
 =?us-ascii?Q?wZ7od52gk8/NfLyRetxYLqbqyYV/RpKdkr81UzENhcxXmx+zEJoW/NGJ66G0?=
 =?us-ascii?Q?NY3KTslMPdvGojCAUP/olFqwDRIpRTJ8B8d/G99hyauhH8tajQwDjco48ISE?=
 =?us-ascii?Q?wpyJSt1TTyALaRcW2PNtObOeYoVMudkM/fYZv2Tj+iFcBAxZ00BtwFfEeoyl?=
 =?us-ascii?Q?i2+IWKdCvIxRvQ5tzXDT3tE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DB0F9D80FB48F8498F5178171EED9F45@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: UZZHZEs0hsW2pQC6Hkj12qwijLK/SghHEDmmvQLJye4cCjvgyVLwIVt7PThdvEACMZs1znm/1scg2I98C8AwirQfFLqrBYyN5/YA3XVXzPAGzR3tBJFop0calVJWloupGO+iI1QG0nMhozJHsDdIegIqOjZaqEqXEahQ4QNSK1/4ZVt6ssEVMdqgRiNvdM9JQxW5Avkwc84JEEE1IwDxS8we9G13CIxNlAWHiTx6BvJegh2fH/aH4N2Be9IGAkpf7jWZ920M7qDYumJV0nIhTOZk/TkqAhGP6NGibtpou9TO4IkQyKkCJ34a95bkO49gKHADskMRsKRV3d7cK1IQmiv7+FEaQ5k/ubg9yxsxQMhQvykkAF9H7w4rEXFLlZNRquM0x0Jn1WfX3oWs/SqZNVjWv1SHtK2MafZiOXw18nW1VTw74pSX/HmRGAVedPOm9JV1Ba65aZtZYwzvDslyEFuUp5CQGirKhMqnPynWoePdWHN8DbwY8fEu9kU0IU1IYG+AJ75ucFm/bRyMH2kvYFBVy80YwdMaR2MCvLuwhedTrTlfRkS/2n4+u5Izc4xBjKtTdYjcBAOazQuAufMgL9FzczyJhThOLGjwhSGblKieZd0IpGA3v8kQq59iFsdQ2VM66kbp+gtRkfrE5Y48WBfEvN11qyvAgj42s0yeBKuufQB7bTm3XSJIF4Wj8NIRYpVNf49xfOAie8HNQR/kVqaVqbRN6hp7auV/QtDcp8j6EXj8GOisTuVoq+G9AqUuUEL+uR3od/qM7MoRSJIslbQ4EwfieoOl5cMrCVFw4w6/wcQ7Y5D839NDhPJbTlqPMjXkVGATrDvFUjkbD+nV5+mME9H/cGEIuaa0Tlh31t0PqxYbceBsBh0TALdRQl2PZyX+fjhYDB208ZBfyM3y1/gMzis746XSqMaZBzuX6WU=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1a24b28-c936-4968-9542-08dbe6934247
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2023 11:00:34.9206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W205M+srcqL30vwzGro+aBAd67Ao2XZ1Sl9uiSp9xjLJ2kUDBrwjYmx7NZyw2sbFLwOl/W9iQ2OE483nJftHHWYZNRXPbH1votUX2u6UJ24=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7566
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231116_030043_045954_2168DC4F 
X-CRM114-Status: UNSURE (   9.92  )
X-CRM114-Notice: Please train this message.
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

On Oct 20, 2023 / 07:06, Hannes Reinecke wrote:
> The TLS handshake timeout work item should always be
> initialized to avoid a crash when cancelling the workqueue.
>=20
> Fixes: 675b453e0241 ("nvmet-tcp: enable TLS handshake upcall")
> Suggested-by: Maurizio Lombardi <mlombard@redhat.com>
> Signed-off-by: Hannes Reinecke <hare@suse.de>

I also confirmed that this patch fixes blktests nvme test group failures
observed with tcp transport.

Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>=

