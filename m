Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C577BC00144
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Aug 2022 08:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=mQOFq/xaLK6H4nfjFRDxavkVwXEaUBNWXYfW4VcUK0s=; b=E+Wy4YtvLqs+++
	dwry6z5jBpjKamwuNdVlFft+XcLb0CD5dwoLu1PzAK2yT5PwNnWuM1be7OgLWREAgYV5trgZP6Dy3
	f7ZtTHDUsoJTsxw3l7AC9xLBLxEtPuhIY4mV79m7msxwD67xiI6p03qtR7BR6mYavJOH2Gl2tTpG+
	A6buUlT/NDWR2mXwOV1AdlDdXB/hGr3PfDvCHF1MLZI6E0HS6w0sl9UCINgx+LA74hA0Is3Y9Kt73
	TTNEVGijBSIXuCUqq+XsWlN8qq8sbdYVfaoM4qwc1OO62dEYDt+d/+j2JOA4dRKoW44Ehfkb99KX2
	vvLt+8K33F+rzzl1/FAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIQuU-0042C6-ST; Mon, 01 Aug 2022 08:36:22 +0000
Received: from mail-vi1eur05on2134.outbound.protection.outlook.com ([40.107.21.134] helo=EUR05-VI1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIQuO-00427b-4C
	for linux-nvme@lists.infradead.org; Mon, 01 Aug 2022 08:36:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dFkFtULcnTnp5DfD0nV8O2E6jr3YORj2SX5XWwnmVhkKpaBkKdAvW8qq/GxugP5pt17YMy6F9A1Wo8M9JX15hqD4AMAoGlVrr0dc/NQia3erhMU431GgWcB2K4d50KGRW9kK7xHGACpeaCcgh4fRNFCB7Q5tNHzdmIgOGram0WtTri13neBLyvja7RbCuNH8RLc8R6PVWGHzB0+sDMzHFZgTM2BH8bX6ielfLCLYi/XJaHi/4yan7hqD/P2d5xBZoN3i/z1ZGzGtmTf/EiQDOdKqtX8PYi1TG99gsz9bHjhMrRptK07+QEEp8/u7K3/gPBn2iDI3oSvyTpwDa16Dyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mQOFq/xaLK6H4nfjFRDxavkVwXEaUBNWXYfW4VcUK0s=;
 b=PvL1gOhTfNCzE+IYYhKECoOXOnrtUWE4B/xXz1GmFNHuywmSKwxO8dlit4Jxoc0skz2/u9j2DXs+osFlXJRjbqRR0Da0nqokvLmFJS90CP6phxXwtHZ9uWJW9px0hhJ7NQsy/ndEwXZ1OxlpXpkzdPT5HozUW+Bqj8syjq/epZ41/fpfLOtcJuJdh9hbV3uul8f43ooRVXb3pOVvvqWI2dvIvYz+ogP9fO9lwulnSOgTyiJK6akpJ0uV9kgzzqen3rnfooG5sg57h4NK1yZY1vCDwdxxX65O9cdcVYBkNAYqBpLxZDCdeiNDenZMPgtNfUo7kA7ToBZ+aqzrOH0wKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.com; dmarc=pass action=none header.from=kontron.com;
 dkim=pass header.d=kontron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQOFq/xaLK6H4nfjFRDxavkVwXEaUBNWXYfW4VcUK0s=;
 b=f1qNxOZMiLp0ae1JSSDgbSC9uTqV1Rjlv3r4ErJAoZpDdhyoeTNBXLMy+z4VaJYUowiFyf1Wt6dbfx5r8b1QG0DIMwWwaeQgx4/FgeRpulPWX0lKTjxueb1snXEh85shwMCDRx8hr8Hf6447CyMU0qzyZF7muRCx9jlPl+5/kts=
Received: from DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3ef::11)
 by AM7PR10MB3905.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:14c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Mon, 1 Aug
 2022 08:36:12 +0000
Received: from DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::88c1:4797:9d1a:97a5]) by DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::88c1:4797:9d1a:97a5%9]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 08:36:12 +0000
From: Gilles Buloz <Gilles.Buloz@kontron.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: NVMe write protection support
Thread-Topic: NVMe write protection support
Thread-Index: AQHYpYEbiU4zQ2Uo+E+2RUoaxlVOoA==
Date: Mon, 1 Aug 2022 08:36:12 +0000
Message-ID:  <DU0PR10MB62528F66099C2311E2AF1EEE809A9@DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f043808-958b-4497-6985-08da7398e428
x-ms-traffictypediagnostic: AM7PR10MB3905:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  ZEUu/f6I1bexjx/1tUXKdiI9kNm+RMMjgZMVeCHBzM7rMjr+hd6zpUFo8XiuvcRFxt790cdN82AvhjUM9Zu8y2B5l9bropk87GSRQOJKt39L/7hllJKkiFvkB2N275xO8SG2zUSgTTQampUVkApAIzY6Ks0S2BInr/Io8kM06xjowfG29fNko/q+kT5BZs+1WQoXhJ6f2Udm9ihhCqUoPi/LgfPwLyfy6jKOdSXLI4LGKOLnd61rlE/ZnH/lNuY0cEdRDsgUeM1l6Ltp7Bw1Hb7HZn6x/AVHrNODUGXWAek9DBhzSlwwX1G/cAFixIlaf9GXLBbAPknpaZ82r8g9MdAq78MP8x3kNvbLFlqC24FjBuVoFrFHgYOyW+D25G2jqDGiYTaj5DCnW9dS7d+YRmqWGfQ1k99RguPqRtYAPsrPLEg/H1BgQmZx0FFRrK24Wt05t2ViHQ4N6a1/gu7CZkGQPek2UO78z1421TZrWWbYc/2n3IqtPzSSG/M9OA/AVx43B/Al5wWLXTp1x1iv0qWO0Z48bcSqAyVcenPTzphe42oGamYZNi03k4iPI+OAje8C2bQhS2QToGW66Ug3lyhK+gCwTa1wxsbblBbXJ7VySuM0Vu1N6iS309Rk0XFzayPM+gxfTjGFsZb4KJqa0dberwPxLmFJzvUcZr0zp0Uenq5+22ZUl1uuYlsj1ItZ1VXXdcEIDHenLZylO7UsmnhRuyvODNGCMJwYoKkGFM3jPMSrI+ERWTGg1lQjf3xOP8xuBJ0/jvybGzQ0IcVGYATfP5k6t8g3bn/3p3UepSxWI5m8kEA4jD6I1N8+qcja
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39850400004)(376002)(396003)(346002)(136003)(76116006)(38070700005)(66446008)(64756008)(66946007)(5660300002)(83380400001)(91956017)(66556008)(478600001)(33656002)(8936002)(52536014)(186003)(8676002)(71200400001)(66476007)(7696005)(316002)(6506007)(55016003)(2906002)(38100700002)(3480700007)(6916009)(26005)(86362001)(9686003)(41300700001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?iso-8859-1?Q?raHC5AaZlB8vGvhxsrj2oux3nxVM5awR1m4Pv41RrurVSysFVa/AdvuzXW?=
 =?iso-8859-1?Q?Nu30YvvoBfL1bhhr3JczVrnDh/xGreMAjnIWLgWRMZF8jZD51sLzKc/cXS?=
 =?iso-8859-1?Q?iXEngEowuLXstSA6linWnDSQqrWeQ3zs4/Ez3HJKqKQFDmBHYJEAwoFGda?=
 =?iso-8859-1?Q?PfmBMNp+uyym7Yy83ouQ9jRIIXppjdQxFgTYm0na1iQ6C77ZBosqeA55jd?=
 =?iso-8859-1?Q?+ptkGlsbR8EN0VcOQj2/TUcqcXSpooNxtygmLh52xdDipW0PbVSUSNrCSu?=
 =?iso-8859-1?Q?LTZbllt7kROF2dK8OUHDqJPbdqf/S7NEZjlE2LKjVlqC0Tg1zgIk6Vh5Uu?=
 =?iso-8859-1?Q?Ke0nlvWEGm2kA5kCuZIlzJh6W2Jo8LpFzIQKfEHIBTkMIxXessZHOTboTF?=
 =?iso-8859-1?Q?J4gFwrkmbg2q4/EDZVz4v3CK0K9ZLSh3dBH9xFrRoxW0BewGYN/u7/Z4gh?=
 =?iso-8859-1?Q?YicysZol3xDeP3CaP+oth81b4qzP5pWKqy6KeUAwmmfGbnaagIQwWpM4G6?=
 =?iso-8859-1?Q?zlQY2VH5safjrd2d3EE9IdkUgLBgNZmc+Kv7q43wySObFMLi0cvndVaWNA?=
 =?iso-8859-1?Q?EZ9dEyDeUH3h2GMNVIE/XLnlkD6PmQ/rG6CWnXWD0KFah4atbV1g9XtUZG?=
 =?iso-8859-1?Q?yS7fFzckQr8RufHmmB/QjrbUlLZAJ6xL05p7sBacLadjKXESc6FuMD7AWA?=
 =?iso-8859-1?Q?E9ZGKJpuPqpIyGlOJvW5ZrO64vwwWOryTw5RLLPh1KbCPi8B+DJc8ajpDi?=
 =?iso-8859-1?Q?z87ynsy2XAbRgjcDYyyRa6+GWqwjzAaO1lDmqtVElUcwqXZKJ/nrWQ5ukK?=
 =?iso-8859-1?Q?u9f7OJhh82Zj1xcNWtq5qCVq0UJKJVA+lbi8JkRT5WZrvYlpN3uyVjCq5J?=
 =?iso-8859-1?Q?hsuByBFk6KL3pPLGvEdH3cNzUVzkchLxqsXziGaCim1pD5BksEf6bRMlQI?=
 =?iso-8859-1?Q?FzL1/iJWVVLkffnLtpGWHHCh3gdPZ6Zn+fH8ZK+YGc2U5Xlm37Um8LUlFV?=
 =?iso-8859-1?Q?PusWG4wAPjxAPCR8l4HCxNXuxqbtNYoAwC0mJTpxjsESBW6s8ETF4wdKkg?=
 =?iso-8859-1?Q?i3Ebk15f/KgVlA4OB/fGaGXZC01g3IV/E8O6FCB0VV868j91QquaThfZlO?=
 =?iso-8859-1?Q?xWnAJdGe+b3ZuQleKLTeY1efL/xlnBC7BuMUZKb7rxFRGc3niOWRaCl8o9?=
 =?iso-8859-1?Q?IxN8Rc4FMGjXo+JuaqKw9/c8gmflqpsBwTcBb8Qvs+cWXfFYvDXPHi4Pm3?=
 =?iso-8859-1?Q?cdNCmhHZ6hlDlElmQzg9OE+vJPsTSvLYWVhZZp84bfrl4UF1AcqzYx0ifc?=
 =?iso-8859-1?Q?WRGYz6MUp0N+/1OwCy3fdaG36LWIWBouSrPuawclE53wAV9x0my90LGQ7S?=
 =?iso-8859-1?Q?Z1HEFk7YQyCAr0OXnYriEoXpLMTOfdjChQiky/dxisyLZZDJzY32TOhyWi?=
 =?iso-8859-1?Q?dhB360O2c8xpdjgZDwl1GCOWmRJHfOnXxdm0ja4n5tuAKVxBqIKg80+uJ5?=
 =?iso-8859-1?Q?HmSzxaA/cbNNFIc+iXEBLJXm98Nf1qnE0q11xReAiNNW7ipaUKYUxQzaVf?=
 =?iso-8859-1?Q?ftOlAEZsfp89+SwjhMIprA5SoE+vf+RG1SLYRELZrDn1/E6CBcMOfrIu1J?=
 =?iso-8859-1?Q?GDj/n1VLBdMnzRfP6hbdd88VwZ5GeZpvpb?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: kontron.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f043808-958b-4497-6985-08da7398e428
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2022 08:36:12.6111
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AJgDgT+CeFQ5jYMEwW/yzTGROCdsz0i+MA479Vu8ImxxNIIMnghUOaZ44M4Nz+sAe5SLepzZaVeTmaz2/651TKyK7fzfeednMe3dcN61FXE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3905
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220801_013617_185198_B325AD42 
X-CRM114-Status: UNSURE (   8.85  )
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

Dear developers,=0A=
In case an NVMe module has a write protection feature, what is the best  me=
thod for the NVMe to tell the kernel it is write protected (if any),  and h=
ow the kernel should handle a write to such a module ?=0A=
As computer manufacturers, we had a request from some customers to have the=
 NVMe module fully write protected (fpr safety). So we asked our NVMe manuf=
acturer partner to add thiss feature to their NVMe. But the problem is that=
 if a write is done to this module while it is write protected, the kernel =
treats it as "critical medium error" (giving something like this in the dme=
sg : blk_update_request: critical medium error, dev nvme0n1, sector 9775374=
56 op 0x1:(WRITE) flags 0x800 phys_seg=0A=
 2 prio class 0).=0A=
OK, no write should be attempted if the write protection is enabled, but th=
is critical medium error is maybe too much because the disk is actually not=
 damaged and read is still possible.=0A=
For SATA devices I see that we have a message like that in dmesg : "sd 6:0:=
0:0: [sdb] Write Protect is off", but nothing like this for NVMe. So maybe =
the write protection is not supported/expected for NVMe devices ?=0A=
Thanks=

