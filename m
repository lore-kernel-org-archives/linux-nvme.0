Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2874C43334
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Jul 2022 13:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=; b=KrfKzJ3/1a7QA7RHKJyQtdWHji
	E1P51YeR/dgW4RFZeRFhmh7SOVYuBwX3aSvKY/S/VacfEXWUom7wdsGd7Pt2IkFHWDVke/5otb0Gs
	L3qNWUUAhbFhqoKSAHkXJMFsQSgKlibdrT9CiBGynzUVcBPxZzUXH1Lfp+hQyjIr56c9SV4YKqDZ+
	QiXLD00gCD+R1eyww+6i6T2Y8YYLBTzizcBRYHgno9A5T3EkEciyB81JfwH+IOjqxDeVglZOOOiQX
	SGLVtAVlb4G3ExnQwGfGBND7qKJiRBpGGVTRa7DlyylSjPfBxWqROBZj/Q1gk/I0fmkV4thN28i8M
	zVNuP4zg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8M4W-0099PY-4t; Mon, 04 Jul 2022 13:25:04 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8M3y-0099D6-IS
	for linux-nvme@lists.infradead.org; Mon, 04 Jul 2022 13:24:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656941070; x=1688477070;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=es4izb/scF4cjt5Q9LWZTiVjCRefj2M1V0c8p2aRZi9J107SvpGXZY00
   q7M8iEkZw03Gv79fjLIvGr7Wu02jmMHAQSxamvqD7drc6gb4tG1IikIA9
   rVgstdNkakVUwY9HYdPObnbb7MpL6repmzFwxNy/SOJp3tmRtWKbJ63TD
   6wAWy46unsiAhisj0CbdY1GSXw6X9EBQS3zfiLCXXP+dmVy/kjAtWu9vg
   foqQX52kwWYQtoRtL6CN5gRoBHLIq9Kp00G5jPsp3Q9AjdYnByZrfS/B5
   9UGMhbS5Oom8O1nlh+t3Mw+CkUWki8Bm1N8AXK7OjxVGRqgutL9Is3xa3
   A==;
X-IronPort-AV: E=Sophos;i="5.92,243,1650902400"; 
   d="scan'208";a="203428417"
Received: from mail-sn1anam02lp2043.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.43])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jul 2022 21:24:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I8PojDn8L1/+s9WFuUG6zjtgXXWgpl3uHegz25VRDimtZMqmRzpBGBDEhjz/q/7S/gLMrGU5nOdczXkTr+G7O0+QG0EY3hyxCDf6ahdoVZ2CSrZMdwuAgppVh/kmv0hKds8XWXWoL1ueTqYAcyuouVlkRXLT4bxSaQNyix4skFx/MAgCLyxvXJZc3RIiCIsHE++8d17uLf2ApvWJgzaovxKvABI6k82v+E5z9EqmS1QiGmyBxkPoISc2NNR/ej8puR2WUybZQkBR8c1ZM7SR9UU0rcAFdf8OxPcsbao8PYS8VcJ8RLl/KASaaCSk9aBBdanbABLokHLJq0Pey0DJ0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Ppda2RmSHKkWzPYmzryUwa8yShdhfv4kL2K3rze6tXpW0CiOOa96KdjZ5wba/oxbGXyAVdzB7QeO1JTwT7DZkBQEMGck+vHmBpwSnqcIRoX+6sbm3M4UOV54WHo/0P0LzQD2sHsDd2w9VE3uCQ/XToy/PISKvJKssxm63Bo5qF6ed7KZqXba/TR44VYsduPX4/TOoMn7aYcHrZLuj6mJ/vaumDgWkctiABUGOJlt8oxE7hlSrlj2H1jwNvNzzNWYFfcTg+6NcKzaSAjS4Iw/GiljKF8Z63rM7+bHXpfvl2giMRPLx/V8sis2iSftgCKXkQZkraHY1yWdN/grJie8qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=eigJAy0oPKYCOp9NC5yTqc6cx/Qh8TQ3+rvGCE5FuLctOhaRB02NFFyM9L54MJGEKJv2TtVXSmrqIN7Voy4wslmZgU66ZGXHI0kO1zC+zNBxjzxhRTnruvhNO5frnuqR7/KWRQuUnFaW3SDUUXtgZANKlSiBAAz60ko9qvVhDzA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SN6PR04MB4640.namprd04.prod.outlook.com (2603:10b6:805:a4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Mon, 4 Jul
 2022 13:24:28 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91%7]) with mapi id 15.20.5395.021; Mon, 4 Jul 2022
 13:24:28 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Damien Le
 Moal <damien.lemoal@opensource.wdc.com>
CC: "dm-devel@redhat.com" <dm-devel@redhat.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 12/17] block: pass a gendisk to blk_queue_max_open_zones
 and blk_queue_max_active_zones
Thread-Topic: [PATCH 12/17] block: pass a gendisk to blk_queue_max_open_zones
 and blk_queue_max_active_zones
Thread-Index: AQHYj6QHDnj2NBN4u0K1MvrUU9sc5g==
Date: Mon, 4 Jul 2022 13:24:27 +0000
Message-ID:  <PH0PR04MB7416BA6668BA68C5801513109BBE9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220704124500.155247-1-hch@lst.de>
 <20220704124500.155247-13-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8c402fdc-31d4-48d5-64a2-08da5dc0856b
x-ms-traffictypediagnostic: SN6PR04MB4640:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  52hdKi2bb8/N8qlBU7XYtqj5cjm2N+UbD3W7y7TXdd5wmd6JTGS5cSXHW/75DBtOAJNGwyTg0CmE+cb4UIerozr40b02mO6qapyo7Ql4Bj9/PKf2DT26ZIB7PSNaJZBil2sN1okKrs9J+Z7+PYRb+bnTOF0stKzc0Wr2+uPjHm0ywOSXghMTEij0OuMRzCcxNI02+LL4bKDYQ8CGBktPQxjsXhIiMU0KX0aAYA0EiutnVFf1CoJNznuPCXU0F/DyhN5Li0POx+BTd5scuLSX24mH5wR2fj1rncG6w00EUlxymK/674SySBFi+7tl7BJIxeGssbjwvCvHdb5xyarw/rgyxho4947B2zR9QArhhRRtjxoGUFJ+QUCGIcltEpngm1Lnc0xRDEkxqTbk/KYKNI0a7f2xIaKf1K27TLc8fLL57frcSzIMbs/Pp86zNADJmd/D1C1FKFTuqf9+jzgowgcugxsWd2cBMHpC/d93+Yvd3Dx4hRGl5pEvjXwY7WDsq2NEhV7YHFGp7jFJF9kZ+58QVed54x+77YBsn0NEm3p9I5ecyJaYFHki7uwv2nSkeRgtwX0ak/MAwVt9fWPGAfbvDwtuWS46Kzug9a8ZfgbNAIUCAJl3OBMCNjn9ktXr8uGyCfR2pN+pOfPaATAMGYJwIzlTffB7y9bw0Vb7nMw3NkyFwJTPdt0npAvH6SSx+UA35P2GZnTtdMMO05HOfCvQpnw74zU1dpxSi75Dr3qivQDjW6K0FZeGIMDQOqfE4+SatK4CuryWCOfvo1CE4PX8rKY0V07jebk5LCZCMULo4EAU9Cx1dNB+UIy8GohD
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(136003)(396003)(39860400002)(366004)(33656002)(38070700005)(4270600006)(122000001)(2906002)(5660300002)(558084003)(186003)(82960400001)(478600001)(55016003)(19618925003)(316002)(8676002)(66556008)(66946007)(41300700001)(66446008)(110136005)(8936002)(64756008)(52536014)(76116006)(54906003)(4326008)(66476007)(71200400001)(9686003)(7696005)(38100700002)(91956017)(6506007)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?cKOxmowv1NwAcoRIrCInplwoZG3iMxm26zo0pCIYs4MikPN3wK3DhOAtw0TX?=
 =?us-ascii?Q?DLj4oSXyMBDAlZI8YXW2GVaW3mmfE4++bmgu89D8DuyxiT+iGiWtMiYM77Qz?=
 =?us-ascii?Q?EimRJsEe4eDo49UUs0QIWQc3TV0nm7uAI0UsD0kTRlzH24oOxlf2ZeA7QFUw?=
 =?us-ascii?Q?7TQVvTZf07WHsZcJblFtKNtftd/J/SD1TVTqfZnRhM/nlGiqHhyK59Sq9qsQ?=
 =?us-ascii?Q?acqBvsQiy6xApxOIjgVwYUCd/j+DzNVg9PkOYpUnfWPyegpS1XnkpJdPknCu?=
 =?us-ascii?Q?k8Vmiab1hDWfhksJssywGdRA5KYCjnLV/wrwKy0GkDZwGA5fKCI8z0c/eO/R?=
 =?us-ascii?Q?ae1ZucLl91psbS0pBAxG4aacD1zgqbjquQogNxv8B+RtOuMZmidpZFaPfBMI?=
 =?us-ascii?Q?kOflwIgKpOTGhYJDmplKcq/d0SCYzuTpm5txaH2f1kaxvmdp1x2fAK4qNpwR?=
 =?us-ascii?Q?UwOzESHgwe7z21SbaP01XgzUmj7D8I0X8JFlIKxypdoGyXr0U5nmxuZmuALy?=
 =?us-ascii?Q?Vl/oXoCC6Ir0MXTPLpxb/Vkwamjfh+574hqdPaHa6tmchJAl0aFPEucjbDTh?=
 =?us-ascii?Q?QTN13GE+QlEfAl9mfLkqrShihk4sAteOASjcGNfaYrP5dmpHkEriLenJO5Eo?=
 =?us-ascii?Q?btle6Gra3GWDS216CUJpOhIGVAoyUgI69d6Jlbz+Jf4KUJnGonO+qaXjVVEe?=
 =?us-ascii?Q?iTuTUVSRrxPOLRmPDmBHkCTwBlDWrsVeptv+1iocThwgdoPTdZHCBMQ95BBg?=
 =?us-ascii?Q?9q7of8Ofcdn8CixIFhEXa8hciqV6Q2oKm+J84hJm3Cf5l8PqMe1uC4pjBQv4?=
 =?us-ascii?Q?5PUNFfeTmg8aJu/vbJIuTVajrTZYx7Rn4zs8y+IiequrHlatYSiZxjqE6aGh?=
 =?us-ascii?Q?BY3dZ/ZsYG2a/0CqL8jxEMaCl58OQSoSOXMhc3pvkO4Z8yB8kjdvvjp3bYUx?=
 =?us-ascii?Q?9l8JHKUIVv74Yz6kCrTOnFtzG7P+/CLxZPk39NtCaqzwdoOxt8uE+3HseE3v?=
 =?us-ascii?Q?ILbzs2FV/cAsau1AXIsld0cQD+G8lU7t9PciHVhmDKRVbgaD43vneZ7HemZr?=
 =?us-ascii?Q?vVSQmz1TAribbBFLUrR2yesZcNewdjkbKOWrzJWUwyBpL5nqxFrDV5nTlxjl?=
 =?us-ascii?Q?vHNb0GqK8ZPI57YqabPAado1iuJ1dHGXZK94VyJBDOtbkOOfnny2kK9+pSd+?=
 =?us-ascii?Q?LS+eKrjXgsbBDDAUTYhODhpg+OvKkUgQyrH8B2LfytTVX1l7fHcwRrGmp6Vr?=
 =?us-ascii?Q?1DNdF009jl7gvLWfagn6HijGvD1th1SB/vio0HSU+hqDqXlP/R4Q3kaAqEsp?=
 =?us-ascii?Q?cnNr0sg3CMMYveUSvaEjaI61jYD/gnxlo4jJE30f/AYZlE8j7CqY6b0/dZcP?=
 =?us-ascii?Q?QatyX8z2VUKJUzORJespoYiICut++8qit1MLg/2F3DgWxAcC5Y/QQFXLTrdm?=
 =?us-ascii?Q?7xJxv3flxpjpgfYDBCrbFPrk9hfNLLIpOgY8WzHYoJcirTxBGENZTO7moZiD?=
 =?us-ascii?Q?SLIszDh77crrb2FwaBXaKsJlLJMoNRWns39q/chSw3VhqLGJNx1xO+O4hcVJ?=
 =?us-ascii?Q?HFZn8S/WRZj+9WHjdbQx9rgYpJGQqSYaZDvlNhMPSCBgGsG84iPnumP9ePP6?=
 =?us-ascii?Q?gJjh8d8fw4il+TknHL/47fhhr0skg78cwn7ATwYA0Zs/xZAAlfPdc82ghUUH?=
 =?us-ascii?Q?xHncpwS12kuEXIKeL0iuEatcgXs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c402fdc-31d4-48d5-64a2-08da5dc0856b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2022 13:24:27.9389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h5gkSnsqggqAUJdffE+oiDSNHVlA48mGibcZUFPFGwQ6WSd9DZ1/z3qvP7zGsk6EvNGAiX97godCC9tn7MakUXuAvFNInq1gQt757RgL2xA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4640
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220704_062430_701421_19F97AAB 
X-CRM114-Status: UNSURE (   8.88  )
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

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=

