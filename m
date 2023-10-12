Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E240DCDB46E
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Oct 2023 05:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aWfXkdsYHd0p0oQF/ZLbQPFpoRi0xVLeZ4V7Xbfz5Q8=; b=tn8a+RnlF7NzokCuhT/qTv2jub
	mF1RKtgx5dJXZqrwHOm4Oja7lwlv/sNtniVgU3/eGWoRtIVKo9ojH0zJcZ0qEBhh6YkLtiXx76f+i
	r7DRIqk3zON7/d6XtbVMNa5omFY1obV+OOFQQqqokmpS+B8X3ZrbeLsZzny06Fr4gC1FCc99s/GNl
	yHkKaLhv28drWZtXfQ72W7HX9OSgacvd57qC8bEuSWnsk8lAarMYiHLFLQPH6VvIjFFHFE84EVan4
	/SPvLDSRaAQEH/6rXl3QpqAyHZDtlbS4+fGWHSJNoodErVqV2VMlzz0Jt0iIG1xW414n0Mm+3Y+0h
	eIi1Fn8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qqnzZ-00HQsZ-2r;
	Thu, 12 Oct 2023 05:12:13 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qqnzU-00HQrq-0G
	for linux-nvme@lists.infradead.org;
	Thu, 12 Oct 2023 05:12:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1697087528; x=1728623528;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=aWfXkdsYHd0p0oQF/ZLbQPFpoRi0xVLeZ4V7Xbfz5Q8=;
  b=eJ1UnJSnF0uCKWoXbJ7rNHlfk5634tCfXQaGEHPr1AkCfqhYUpppCtqx
   96VZmdhm/E1tkZ2TpKY7cBZJrnOs59WvZ8eESGpN6Qqq4lXntuNIAnDBB
   K5Tdr1BQGITynLXDvlBRC+0HYit1PuG/LUST61KNFKTZ6dOtqqvszgG5L
   gKU6uZs5fEBS7h5kv9LX6QIVIzD0b2sSvo/34H/u+exa+jnEHAGCeJ3tP
   UuNXmpXUy6/1Ph4+LVixfEwuLZUZD4Lqt8caZnz0ozfW48wOEsYm0QsmI
   6Ys1+tvbWBK9Xmj6lI/OhpB37GSmEpWVlDv1QjEeYfhaUfKksuDeHYxqp
   w==;
X-CSE-ConnectionGUID: C8LIE1BgTJGOWn1cyYJQFQ==
X-CSE-MsgGUID: fJ/7CRNOQ/u/kiWicqtlKA==
X-IronPort-AV: E=Sophos;i="6.03,217,1694707200"; 
   d="scan'208";a="246356624"
Received: from mail-bn7nam10lp2100.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.100])
  by ob1.hgst.iphmx.com with ESMTP; 12 Oct 2023 13:12:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BIH3DoFjr4XE/QvTu6tsOZbIcgJmzXCxpoyv4kUWxRgmXJAkK1rhRI8DBUr7sOBUeaK2DNIotOS+l18cIOpHSQj4dhUd1NJFKnbSXw/RswuqRmkkYVAokf9ff+juNdbX435r2xAnV6h5kslGOBXUbo/gN+AuRfsHUaNi4F1k5p/mnxQD5XxVXe7rLUh2jJiZ1jwJpg9H+gw8QKm8JT3bW6a1gQKuEpSIqcNf6zajmNEYFY1dyWr9AvN7EN9dtOKGDSCM2PihG7wIz8sl/1ZBBEAAYAv5JoRZWIEV/EW3RYatnQ6EYAL6LHQn23TgAzzsYfKDiQ1QMhdExZO1dslb2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aWfXkdsYHd0p0oQF/ZLbQPFpoRi0xVLeZ4V7Xbfz5Q8=;
 b=lbxuyZGuYxvVy6krHM3rAiiqpXKhk7ejDQrT6s4bDSoJRdIjr1UlHlJdckAhr70X5Xwv2yoapX5TzJJ98J8cpHozQ7KZByjJsvz9qtrUIjY0sgIZ6nCiQNt1mUnn4gQVB2YmHIkfuAUKyig3t7th9EOmEaWxF6UcZbxNNMM6+xchVN+d25pEsir7dCrS/SpKRG9MhtK+QT28i6tPNYbuDLGWVsKUbdeGdPZqEp5U9LEik9uhXkIbnZiuZh/MNvBRAoc8ZXYs22mIaw0LCYhIROWB2tHeuZxUlc5W4dkavdKNMA3oxC4u8SxhLdSdUikLZJTqzxX5M+sPSnf3ftKlig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aWfXkdsYHd0p0oQF/ZLbQPFpoRi0xVLeZ4V7Xbfz5Q8=;
 b=SA1Omt8sH2VN9ckYY8zbXSJ8/pSlyO2+40bxGB488iqiLwi9xoJBcJYLDD3xFTJh/Mac5Z3YMp6ahhNvQC6EgAsDWJNUC6TcNbdW2djFqW4BSodVDkvOTDQmbEKq1KKmpnJLreEGUj0Y9Ld0jQ1KksQUik1IcRC+OpwqxhDcTc8=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 PH0PR04MB7288.namprd04.prod.outlook.com (2603:10b6:510:1f::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.38; Thu, 12 Oct 2023 05:11:59 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::2256:4ad2:cd2b:dc9e]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::2256:4ad2:cd2b:dc9e%3]) with mapi id 15.20.6886.016; Thu, 12 Oct 2023
 05:11:59 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests] nvme/rc: fix rdma driver check
Thread-Topic: [PATCH blktests] nvme/rc: fix rdma driver check
Thread-Index: AQHZ92JW1vXYeyzpCkWtsrX7EVVb+LA7fWmAgAopDwA=
Date: Thu, 12 Oct 2023 05:11:58 +0000
Message-ID: <rrkoegtleaoph6lo5fwlbdk4b5j27hz5pc24av5y7d7rkdyz6d@f5tsjt7aefxe>
References: <20231005080242.292291-1-shinichiro.kawasaki@wdc.com>
 <6b267348-7548-4cb5-a62a-284c6750aeae@acm.org>
In-Reply-To: <6b267348-7548-4cb5-a62a-284c6750aeae@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|PH0PR04MB7288:EE_
x-ms-office365-filtering-correlation-id: 5ee55b6e-8aea-4d10-1487-08dbcae1c30d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fck3LnpfrucCMTmeZ1No9Etv+G1BPot9LI0JIHBl+9Wp9LFViO+mP/w0xr581omfWQURDwlINFf6MDrvhdGLng0n2enDBlj5NKw+JAzsg2u36F+BJWt1V25dHWwO2KvT+rLYnhPRaHlRnamebmFuSBmZxtMNngzoBsi9GpMbqMgMAXsX7Gc2W87oHfYRX0Y+i6qCGFTHDuOhhr9vw4IUnkSwadg5cx1C1rHuSRtn3D5AAPZNECWj/7ODpj/DTZgzKgVOkhPRJSpcDVfigGosKd6QDms8FctcrCHXpUS9xmWor96IFrAeGR/BGdti8krOmDeH73KHCF8YUB5PIFZyS6YypM58YA7nIEvsQbt+yptwxBniWoZCpHakuNqDxJV78/CBOCyt00fjqAC0HWUp5j/rGCm1S4Y5gJiu1k31lIrt5hq5WtX5umSJabLo6Ri/PYTPZwD6pUWKIG7AVJkxAKMUphpNV7hD8XeurInyGYV2xzBZfEjHFTTfAn7RRUv4Lx1mAmNcoTl8cQq7WX2pSnIdDUq+3hMF+29XLybLZ9RRqoHW7FQwftN0F/JECV26XaEUDTp1YnixPl/HYc4qiRxcTpL1u0ftdjrhh8viE/iZfSPHhbRFmeWdd09nN3ll
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(346002)(396003)(366004)(136003)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(6486002)(9686003)(26005)(6512007)(6506007)(71200400001)(478600001)(41300700001)(66946007)(76116006)(91956017)(38100700002)(6916009)(66446008)(316002)(64756008)(66476007)(66556008)(54906003)(8676002)(44832011)(8936002)(38070700005)(122000001)(4326008)(5660300002)(2906002)(82960400001)(558084003)(33716001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zT5u9xY2OhXX4Wldep7JyJAwISSLhceL5s7mWmANV/40s08/04nZVRcC0qyB?=
 =?us-ascii?Q?RX1Ol1xT//iTkhBH7i52x+18YJ8zt0tfEHj7BC4DCcaMItiYWRNGEcmg3HZt?=
 =?us-ascii?Q?4Eh6eXhf4N4MEsZpa2BqQ8hbwAzusLOprbylQ0K6mNkyFTQrobf2ZRwIevsQ?=
 =?us-ascii?Q?JFcnGT4CZuovdZ3vpNB/8q20cjstqrq7YHyJGHbAjbThUDI7Pm1SAYnfLgUJ?=
 =?us-ascii?Q?zoZWcpocDCiNy4l0lA9jf7io1F/GMASZhJ2CHKvQd/Yin2MW2XLzlNuaxByu?=
 =?us-ascii?Q?E5Spk0u3w8XtHKs2IJycxf3KpI2JTo9C+8NrZZquxksU/CrHGz9dAt+ZP/vU?=
 =?us-ascii?Q?YZncN2OwJeD0uNrEeuTc+hYwCAqWnMjxklbM5wLC35SnTCVeTeVfzP0iF8rf?=
 =?us-ascii?Q?7TDTl+z2wLTE3l3zUBcrQtRY7a+LtXcRYvPelckyY2LxcNjB1cpCnhP+noJz?=
 =?us-ascii?Q?FylK7vR4h2Mo3Tla7cnMTrZehUETfrr4hhYZkhbSMyZG1Nq2pWPcyC63smOf?=
 =?us-ascii?Q?adIUCJnBgQXBb2C0QBKANblQuLv2UyvlUm5inNU4tYxxjCttAWBQp7wNKMuJ?=
 =?us-ascii?Q?0Nb803W+3Dbz8AambydKuHuXw6WOObqScp9TaGJTq1PH2t+d5KoaVAuvnmsI?=
 =?us-ascii?Q?3eX80FLYWQf2CNa+Tg5q5tpjxAFqXJPxgLv3pmEpuU5aluJuzgltx2l989bl?=
 =?us-ascii?Q?banWe6m47RXX/W9Gw9FrJJgZnxHRwk9qOgykOxQuEzHqR9StyD/NXTea6KEz?=
 =?us-ascii?Q?6IE4ngBr3ulA0wVsMgX2xjeoyAv5jePozYp6eONI8kuRYRPIkoz7P8C7F8iu?=
 =?us-ascii?Q?8CxkCTQZXtwj5xI5wk6fE+GTdlWfPj7cjSJij/twYb5kwIu9o7firLu2PUmW?=
 =?us-ascii?Q?v8GI0otbbiDR577dGbqjNOaumFfJAjs5X1jbbmTQRYtX2mzRjae8NBMSxzxZ?=
 =?us-ascii?Q?9N2A2MjczVG76+YjzPr5YEK5iguUu9qMJQ0mGW1HdX5+goFhQBwhd9zh1/Ei?=
 =?us-ascii?Q?L7XDo1aZBwL/xoKQzVNT0x/L1wkrMFCyhR9v60U4wLVFSKeSc8Cniuic2f5p?=
 =?us-ascii?Q?qUZ1AzRWOhe73h/qVoNKNnTZ7RLdE2mRqtQcdkMu0HrUFDgjRL1lXbq9zuUb?=
 =?us-ascii?Q?8K1rJ19v2iFnOWDgVu19//HGtf0oODbiKLbK0rc4wicdBQxylGXRT0G6DXSx?=
 =?us-ascii?Q?vLt//6XGg1hSK64/JwkjM+rCX4B9n7Euk8O3/6Hgt8UTeuwS0sKVDebFw806?=
 =?us-ascii?Q?yh/aOQO/2n+jyJieNkN/zaXM1RFrhG739rW3deiKM0waeu0YdW6gYDV0CxyJ?=
 =?us-ascii?Q?DFUR7eJqGe0FQ/Nlynw5ES9ypbpyYPtYk2/JUqA9BnCkcU5bEi0yw4X80lNB?=
 =?us-ascii?Q?kUBstFsKWGFx06OhnzhreXkCYUjENwY/KszhsTYKkc/5We1vhmIX23mCsz2c?=
 =?us-ascii?Q?lowLQEx0FTji3USU38cYCBvZEn5GH01f3ovaEaC/dDh4/R7QitPiR3CO75kw?=
 =?us-ascii?Q?VeorjFINluel5oeyGVw8xzsZ9LXRh1qFG5cUq4nHH7jC+WpA1psf5er55m/X?=
 =?us-ascii?Q?g/b/IMb2vPRwPgRcd1WEYNvMfMCfTTh9svh0Kz2qOShM/WjKD/ju5Oef9OlN?=
 =?us-ascii?Q?Y2jlomwNAyj+MYmOva0wXNs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FC79E7FEB1C2D044A0B406F0D1838BC6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: cZmIRvMD3A4ROsTxSyVVKyHP9cuPnuTtrtSrpsNw9fQ/wrq/SehRoUXPRYDxwrKkZCcWooeI/8HfanJ2WGJCjwOas2cd9m3Ht1Dlz8E9bJRHAVUNY4qtWo37yLdMtjG1uG13UpEVuWY2zSaXVSegLTAl1dhHo8yZG5cUD+ZazXbk/eFFuZAi7h/NHqOO3aUqxb95U41Wr6U565eJiikeucXq1xb67vJQ66OqFqJrvdgv4qcGfxncQEYEJJ8JBk1u4Hlvo0Fv0SkvL/BqN0l2sRFVeCoVThwxoMdcRvfolk2+4Zzqqw/ZpBJ24qmW1NtavfH2DJlxCvc4QbjRAMUW0WWW8i04QDnbhzTfHybyYMbgnITvP4durWQ4RJGYQ3N67AoHAflQzQBK8EMI7F71h/9xwlnIm0G+RvGajC7UoSE8UL1AaKX1mAMK04X5NzhHxl8oy9UVErK2yH6lv51+d824BvETLoWIb2RpR7/9CheVLiT5xcgwoflehXVSgDVxvWOjmFqKgbOuuQKd4IxG+foTmIsgFApM5czZilTbzna9o4/mtvTXdw0guwvd96AqQ1y1n5KfEiY5fauiQhb4/IBGJFlHvCQ1OOzwg8Hn6ZfqagRzhZYJl8bEHiZlqD7zrbulTLuiTp/RlJEENO/Wz1+E7vktsaViDAFzQTxqWYW4a5eBLKE1zU4lNWUgQHChghJYWnby49YwsepmGF6LwtngBopqiRK17WVQpbDcRtbQf3GDdmEBhxfliWvMamEyE5RCiP3WniHTH5Dckfqe9nbH/sZEKrzCAbuYU7YpPMRcjqk90gDHnvedZgT2ull3dxwn1kLTEtQFWYMZS6k2siNYcRYlFO5hVSrhuI63Amk=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ee55b6e-8aea-4d10-1487-08dbcae1c30d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2023 05:11:59.1322
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FWYO3DiKRaoP0jAIU+ZwcSzSl5PfVT1i09e3ZqVZot/ZSYp4WFO5PWyp8vHAT5fS5mwL6TibYHJrsJIjrYwj9mHYHoqIhoxTTMjwcg+aVEg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7288
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231011_221208_127425_D5343E24 
X-CRM114-Status: UNSURE (   8.66  )
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

On Oct 05, 2023 / 11:02, Bart Van Assche wrote:
>=20
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>

Thanks for the review. I've applied the patch.=

