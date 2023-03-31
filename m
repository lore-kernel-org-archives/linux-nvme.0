Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D63AC6FD18
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Mar 2023 07:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	In-Reply-To:References:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Saq+s9boYCqRxQX/BdRxt8z2e+PbsBFLFJ82thwxBlI=; b=NxmbRsAOgf9pXdeWk3uADqxewH
	2CYPDFcHaBy8d16mcSph15gokl9GfLQOb0U3kjGZBccd9w9+EZdjNSvTRuh5Cx1+0Pv4W8DFws1M8
	NKP5XVsZTt9KY13hrnuP1cEWuEJn0X+DNnAUmuUMT9/TwqcUbYgva+p6RIORMr8U8IezDshKZLhgL
	wNejKqKAoRoEToDKuIZDuhKeQL8DLo9TU0r/nLfKlKqZMpZGnGgaV0qjNg0KkbmIlUWN++FuD1Aj6
	0GpV/MLgEMVqWt6FWUg6lJmVdtC9Ed2KmSzx9ErrHgRnzy1/Dd2YqzFsOCoyZsPrpVcTS8O51r7tI
	lK7xD8AA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pi9aG-006FEP-1Q;
	Fri, 31 Mar 2023 07:54:04 +0000
Received: from ironeb3.johnshopkins.edu ([162.129.199.130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pi9aA-006FBm-19
	for linux-nvme@lists.infradead.org;
	Fri, 31 Mar 2023 07:54:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=jhu.edu; i=@jhu.edu; q=dns/txt; s=jhuiron;
  t=1680249239; x=1711785239;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version;
  bh=qm2k33vgJ71mJ2wNTijCaWZMZjNyA+AHwF/xv+N+jT0=;
  b=UYwS2nKpX4q2b4x6bJO5PxgXpFss1K8L0hfeW9KRxCLaJINWBXoc2hz1
   jY3qMy5bK39FH8fNw6zq3AiY9EfBsByT7cNr54faF0V2ryOqNAo16J/0D
   Huk0iBKyPYv6qwpEZoN5DE3Tq6uv33h2H954xYcF7yINe/4qBh67ZU+3/
   k=;
IronPort-SDR: gbzb9m/ASIVTOMDYJzFysxUuoAGEuWGct2grFG9fidZE2arDNiF3aZrvbCgZCnJoc9EzExuAEi
 HOMFZVIGQmZNvbhe3TKnbrvquRRGKBzf4=
X-IPAS-Result: =?us-ascii?q?A2H7BAAqkSZk/3mErQpaHgEBCxIMggQLgi5zgVyEU49hA?=
 =?us-ascii?q?QEBAQEBBoEkHgOBE4RUhXOQVIEsgSUDGD4GAgcBAQEBAQEBAQEIAUQEAQEDB?=
 =?us-ascii?q?IR/AoU7JjQJDgECBAEBAQEDAgMBAQEBAQEDAQEBBQEBAQEBAQYDAQEBAoEmD?=
 =?us-ascii?q?VcNXQuBRAuBdAsDMQ2CNykBdU07AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBBQKBCE8BAQEDICABATcBDwIBCBguAg4iJQIEDhOCcYIoA?=
 =?us-ascii?q?zGqGwiBNoEBgggBAQYEBJxNGEcBCYFkBwkJAYE3gxg1jWtCfYEQgRWCcwcwP?=
 =?us-ascii?q?oRbFYMtgmmZWwqBNHOBIA6BPYEEAgkCEWuBEghrXIEcBEACDWQLDnGBSgKDH?=
 =?us-ascii?q?wNEHTYKA0Y6PgE1FCAGgS9CJAUDCxUqRwQIOQYbNBECCA8SDwYmRA5CIRY0E?=
 =?us-ascii?q?wZcARwNCw4RA1A0gRMEL4FkBgEmJJ1AJhkdQmYdZEiBKAWSMQEHMo1xggmgT?=
 =?us-ascii?q?YQGhFyBZZsLg2qTUZF0l2+ncwIEAgQFAhaBY4IWchODIk8BAgEBAQ0CAQEBA?=
 =?us-ascii?q?wECAQEBCQEBAQGOHQwWFYM7j3l1PAIHCwEBAwmLRAEB?=
IronPort-PHdr: A9a23:BTGWiRIW1JKHkVjNi9mcuKNhWUAX0o4c3iYr45Yqw4hDbr6kt8y7e
 hCFuLM30geCBN+Ao9t/yMPo8InYEVQa5piAtH1QOLdtbDQizfssogo7HcSeAlf6JvO5JwYzH
 cBFSUM3tyrjaRsdF8nxfUDdrWOv5jAOBBr/KRB1JuPoEYLOksi7ze+/94PTbglSmjawYK9+I
 BqroQnPuMQdnJdvJLs2xhbVrXREfPhby3l1LlyJhRb84cmw/J9n8ytOvv8q6tBNX6bncakmV
 LJUFDspPXw7683trhnDUBCA5mAAXWUMkxpHGBbK4RfnVZrsqCT6t+592C6HPc3qSL0/RDqv4
 7t3RBLulSwKLCAy/n3JhcNsjaJbuBOhqAJ5w47Ie4GeKf5ycrrAcd8GWWZNW8BcXDFDDIyhd
 YsCF+oPM/hGoofgu1sAoxiwBQeuC+zzxTBFnXr20bEg3uk7DQ3KwA0tEtQTu3rUttX1M6ISX
 PipwanM0zrCYOlZ2THg54fWaBAqvOyCXbJtccrU00YvFATFjkuRqYz5IzyV1vkGvm+A7+pgS
 OKvkW8nqwJqrzitxscsl5PFiZwIxVDZ7Ch0xps+KtKkRkBhe9GkDIdQuD+AN4twWs4uXWFlt
 Tgnx7EaupO2eDQGxZQlyhPRa/GKd4eF7xDtWuuTPzt1gHFodb27ihux/0WuyuLxWMa73lpUr
 idIjNnCu3YQ3BLQ8siKUuZx8lu71TqS1Q3e5PtILV06mKbFMZIt36A8mocLvUjdHyL6hEv7g
 aqLekk44eel6uHqba/6qpKSMoJ4lxvxPb8rl8G6H+g1Mw4DVHWB9+umzr3s50j5Ta1Pjv0xj
 6bWrojXJd8epq6lGw9V1Zsj6wqnAzemztsYmX4HIUpKdhyajobnPE/AL/D3A/i+nlihkS5ny
 +7bMrH7DJTNL37DnK37crlg8UJcygozzc1F651KF74BPer/Wk73tNPGEh80KxG4z/r9BNlg1
 I4TV3iDDrKXPa/Mq1OE+/wjL/SUaI8Qojn9Kvwl5/D0jX8+nF8QZbKp3ZsKaHCiH/RmIF6UY
 XjsgtccC2sFoBcxTPHyhF2ESjFcf2yyUL4k5jEnFIKmCp/OSp61jLybwCi7BoFWZnxBCl2UD
 HjnbYCEW/YSZyKUOMNhliILVb2mS4A70RGjrwj6y6J5IerS4S0Yso/j1MJp6OLNjx0z+yF7A
 NiH326RSGF0m3sERyUq06BnvUx91lCD3LB8g/xZE9xT+vxIXh48NZ7Cyux1Fcv/WgbAfteSV
 FamWc+qATA3TtI/2d8BeVtyFMu4gR/exSaqBKUVl7PYTKAzp47V2nn8IY5Zxj7j06Alxw0qS
 85OOGvggqN68AHXL4nRnkOCkLuwfqlawyLGsmyEyDzdkltfVVtZVajVVHYTa1GeltTk40rBS
 KGvFb8nel9aydOYK6hiaN30y1hKWaGwa5zlf2utljLoVl6zzbSWYd+vIj1FtM2VIEQHkgVG+
 3GAOEB+Ayq6uGvRAXRoEk6neELj9+Ry6RbZBk85xg2HdQttgryy/BNGifmVUfhG2LUCtW8oo
 Cl1G1Do2dXQBpKAqgNtcb8ab8k65QJF1X+fugBgbfSd
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:jDOwkKMrR/BWl8BcT0X155DYdb4zR+YMi2TDiHofdfUFSKClfp
 6V8cjzjSWE9Qr4WBkb6LW90dq7MA/hHP9OkMMs1NKZMjUO11HYVb2KgbGSoAEIXheOjNK1tp
 0QPpSWaueAdWSS5PySiGLTcrYdKZu8gduVbI/lvjBQpGpRGsVdBnJCe2Cm+zpNNW577PQCZf
 ihz/sCgwDlVWUcb8y9CHVAdfPEvcf3mJXvZgNDLwI76SGV5AnYpILSIly95FMzQjlPybAt/S
 zuiAri/JiutPm911v1y3LT1ZJLg9Hso+EzS/Bky/JlZAkEuDzYJLiJaIfy/wzdZ9vfqmrCpe
 O84ivI+f4Drk85MFvF5ScFkDOQrwrGo0WSt2Nwx0GT5/ARDQhKevZplMZXdADU5FEnu8w52K
 VX33iBv54SFh/Ymj/hjuK4Hi2Cu3DE1kbKq9Rj+UB3QM8bcvtcvIYf9ERaHNMJGz/78pkuFK
 1rANvH7PhbfFuGZzSB11Mfi+CETzA2BFOLU0ICssua33xfm2141VIRwIgakm0b/JwwRpFY76
 DPM7hulrtJUsgKBJgNTNspUI+yECjAUBjMOGWdLRDuE7wGIWvEr9rt7LA89IiRCeg1JVsJ6e
 H8uX9jxBwPkhjVeL2zNbVwg2PwfFk=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,307,1673931600"; 
   d="txt'?scan'208";a="13575383"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-MessageIPDirection: Outgoing
Received: from esgmtwex16-21.win.ad.jhu.edu ([10.173.132.121])
  by IronEB3.johnshopkins.edu with ESMTP/TLS/AES256-GCM-SHA384; 31 Mar 2023 03:53:36 -0400
Received: from ESGMTWEX16-21.win.ad.jhu.edu (10.173.132.121) by
 ESGMTWEX16-21.win.ad.jhu.edu (10.173.132.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 31 Mar 2023 03:53:34 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (128.220.36.252)
 by ESGMTWEX16-21.win.ad.jhu.edu (10.173.132.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 31 Mar 2023 03:53:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lSHTPYI0k/L8a38tGQlTYiWYcwLRDY4AHNwySA2jtYukOqhFoPwyrroEcQAskTk/vIf/rZeEsYbwMzCBoIlLKM/xNGjv1oC5t+EfN00sD2HFmBEG/UOjT38kyCdYwKOUbEhUZ1kK2UiKR3k/1MIs18AiR004W10Y9AAnJUGgEN9wDEjYhE5s5PcvDXoNceaKIt+X+7uSlDgDWMhPquyxAcmCQy7hdHouyF4ru+bwqQzGEfwoBx628c80X0UyA3iLaAnndOrwY2P0l5oRzRFRK8e/bAYvstZRRvEMROMn/2lRFmgi0QTuyZ8sp6HY2J17g9rWBFH/FrAPG6c/dEgjjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Saq+s9boYCqRxQX/BdRxt8z2e+PbsBFLFJ82thwxBlI=;
 b=l7dQQAgyWXsS6Zlzizn//8u0Uko2nZuMavyjqZ/BFut8Gh663QqrxMIegM85IXjQejb9RNiTjClm6O7dNRGCYsth9irY7p7z11CziMe7NQ+HBRCQ+dhC6ee7dXbszgrGNXRucGnjUrOMSrmxNCASNuvOMJhKbRepWV5pT8pNq4RU/JC93eSYc/FpzxEFuXqgSqhNHn1UnxETjH3VQbISIloDI76HxZx+EjlaRkNhd69u+xUrt+AvxsO0qeQnank6KgwjWmmAZFWTLulurwwUEPia/gXv2TDNmZn8tlNu5tw88dXXTNXR/MPIVr8iT4QMe1eAm++Vpds0MSpenZxtzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jhu.edu; dmarc=pass action=none header.from=jhu.edu; dkim=pass
 header.d=jhu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=livejohnshopkins.onmicrosoft.com;
 s=selector2-livejohnshopkins-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Saq+s9boYCqRxQX/BdRxt8z2e+PbsBFLFJ82thwxBlI=;
 b=CP8WjCDymBK8WabW1tWVPh9Eu5Bx+Z5elWP/fserZV16GpNKjmSy3a/sjuGwGLGW7uFtCq7VytKehVA7mrabU7Ayn5a65FwhDujLB/6tSuHc8gpBwc1T1ca5SMcRrZIOU91ijFxAbhHMfpjunNGrMVyIlfRBkipBhva/Axq+mqM=
Received: from BY5PR01MB6100.prod.exchangelabs.com (2603:10b6:a03:1ab::26) by
 CO6PR01MB7515.prod.exchangelabs.com (2603:10b6:303:146::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.13; Fri, 31 Mar 2023 07:53:31 +0000
Received: from BY5PR01MB6100.prod.exchangelabs.com
 ([fe80::b47d:4bdd:536:2dd1]) by BY5PR01MB6100.prod.exchangelabs.com
 ([fe80::b47d:4bdd:536:2dd1%4]) with mapi id 15.20.6277.013; Fri, 31 Mar 2023
 07:53:30 +0000
From: Alexander Shumakovitch <shurik@jhu.edu>
To: Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: Read speed for a PCIe NVMe SSD is ridiculously slow on a
 multi-socket machine.
Thread-Topic: Read speed for a PCIe NVMe SSD is ridiculously slow on a
 multi-socket machine.
Thread-Index: AQHZXh2z2NkXUzjTO0KKexGZO2Rp268JnT0AgADTEICAAExAAIAJ0vqA
Date: Fri, 31 Mar 2023 07:53:30 +0000
Message-ID: <ZCaReYKRomOGsM9q@hornet>
References: <ZB1JgJ2DxyTMVUHB@hornet>
 <e2df2f18-aaf9-89d5-6fed-aa1fb663f69c@opensource.wdc.com>
 <ZB4Ty1L8Xa/qMQiV@hornet>
 <67d3d0c7-afbb-98a2-4ce8-4d93dbb82663@opensource.wdc.com>
In-Reply-To: <67d3d0c7-afbb-98a2-4ce8-4d93dbb82663@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jhu.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR01MB6100:EE_|CO6PR01MB7515:EE_
x-ms-office365-filtering-correlation-id: 896e82ed-6311-4216-b767-08db31bd0531
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D9kEEKhX9D4FXK52PbPLsJ5YPz1RjOXzwuS3RO4DpQhx87HYbpB4m0cYIHAT0MdrPhcafDEpiA09bfYmkTIesomswdefXs0FloGf4KdrgrAIiTx1sjHbE4HXPOWpZhilhTP8rXw3qUGlj4hBRDHmsL6jISb6Y1mUmzeDpNZtvLlvYqMEIkDYchgPNl5ISUOYxu8n48TjA16mRCGUlptK4lvlfpMBKVN0yLvQNicJ5V/baZcX3euJf7UfqtS+ASRMrgkfowUlsD5vA8AzlpESlOidGpzjdSU2aLQeo0DkA3M8kv2uPYpeDkHrAqwU+x7nkD7GoiHmh0z8ImgyrSPILjSCvR/hWWiRLMkJqaJ1wJwUYQEbid4iyv4+coQJYILpcnJ8VUdvUNhBTpuDf3AKakoEcxJpreqPk1uNQxbqvDnN7Lv1yEOTIma40lO8GSrwxAzMPeHs60txB0QAhwscWM2NhWPI2iG3oe8rD2ptDUPS/q63TEe3OKi5N40S24eVKGctLfMENYQGqYsFv3y378Gqqn7kdwXYv1opLjmRigRlPRcQQxFRGEKG1CyC6YJNg8W9+mOrSxT8ZDoCtG0HZ1QecbwKrE8GjXvpI+D1kZyLzKx1zMEF34FpKEy4dA9k
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR01MB6100.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(39860400002)(396003)(346002)(376002)(366004)(136003)(451199021)(38070700005)(99936003)(41320700001)(122000001)(38100700002)(478600001)(66899021)(4326008)(5660300002)(76116006)(66556008)(64756008)(66946007)(66476007)(75432002)(91956017)(66446008)(86362001)(6916009)(316002)(41300700001)(2906002)(9686003)(26005)(6512007)(33716001)(6506007)(71200400001)(83380400001)(6486002)(40140700001)(8676002)(8936002)(786003)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?koi8-r?Q?RSOjqkuwsRVKUekN2gYuoiajLO1hyC+2qjh1BoJ9aCyHQE4etBK0eIgj/sAIH5?=
 =?koi8-r?Q?RXjIoMwS4ZytjNichzjzq5ABeNJjHwggU8+jpCTUpExwEiXsahEP0GsuX5cnFQ?=
 =?koi8-r?Q?IxP6eaGlOscTVrA6gOQmt87YSapaBr1Gp+qMNE91yckifbWupaHXaKkKXfpKR+?=
 =?koi8-r?Q?fXdBrxzwSx/I4c8/Pfmokt/Q5RaKA4Ss8MYpwVPtc2Oby8yK9N3fafouKWdQwE?=
 =?koi8-r?Q?rFS+eKjgmsQzA7qMc1Q4EGnY9hjEvyOCULE9Joo2n8IKRFPZNp40xlQTNy20GB?=
 =?koi8-r?Q?TVXzEpsp8rqiHev6WfkUFyuQOTaac6iYmGmonjRmEqLdNcQ6whLnHno8q3SuCc?=
 =?koi8-r?Q?OC47jPYhUpH7JhWnNxQkd0kNUAFrJGEr4EQ4CZ6APT/BqU31CSqb+dnVEm81mk?=
 =?koi8-r?Q?J2auxNHm8mnvHbHqTTC5a1wzCNpUTBHkTRBwNHAj7Bs0NUcUIsGnGGo/+HCBTC?=
 =?koi8-r?Q?wc9kg7yCG2g74ndCZIYFdlS4hc5q3aWjq1k/PwjTivJ7x2uYYA+wOgLpRvVvfS?=
 =?koi8-r?Q?P68hrZKriJRv8E6+XjQpzthgVctb9J2+N8OfL+Nj4gsCw8MwJotLT0t7Hfs0Xc?=
 =?koi8-r?Q?IC/PFwAnUz2wrxh9DEQJ1o2dVxdwWEqE4RTKpD/OJTkvi3oAJ6rgJ+0JFJnMPZ?=
 =?koi8-r?Q?yNlXt1nNTiXREKNviXGc7BWMf6oPltM/DOmRtsUZtVA/K4rqOUZ5o7EJW1IlVF?=
 =?koi8-r?Q?akh0qdNNZHQS0j998vj1itvMHGc3D1Z6/m38/Gf2lEg6mQI05uSd1ekXeJ4fnr?=
 =?koi8-r?Q?tAEiAzDBmDrowS0vmo2ohJ+aCTIPI5h3hip0UJ95PGr2zXbgi0g02Grz9luXzd?=
 =?koi8-r?Q?HZu+cFVOj6PIdEWBelSZ8kWPDye/K5/rGUz33U0jhnBV9QcBMkY47xhsTvHAc3?=
 =?koi8-r?Q?/0wo73FJqaEweNz3YYhm669O42aDq67aCZNO7R6ox2gDTk1dQFs41bGjw5vda5?=
 =?koi8-r?Q?T6Eu/wgXYFHUJBEkG2x1T0801ggvMMCFnUjwklJ+QdBkXhziLimBxr2V6aIzHn?=
 =?koi8-r?Q?zJqYJFRCAbgqDo+04OcmugfsL2XxlHTnRznCcIqvoaTxKxOpdP7BKm6DILP9X5?=
 =?koi8-r?Q?a9AntkacQPfE6y5AOC1Rk9fjbQL4AmKX0JykWMMflWaW7hh3E1kPB01SDEsTml?=
 =?koi8-r?Q?wcmcArG4V3ZL4DgjpSBUQqVWFHxjUh5Kt2otQB/+QTgD2rusDiQjzPfHzpJ4lo?=
 =?koi8-r?Q?ydYYlB9B7yTpa1PiOpWHfkANSVye/mUQJdf4DmuLdezKsVeAf1ghXqX1LGL8Ac?=
 =?koi8-r?Q?g3dXuVuQ3uHM7LDzMre530aOlrlKWvO+Wa805JdrHGffTVqs5Cz5B/j7X42Dfi?=
 =?koi8-r?Q?AC/kmVxJbUWSjhhAN/Sfwq3WeEfjop+QwSeStmzBw6mKIwGf57r9DR8vDPEHAS?=
 =?koi8-r?Q?UEu+jI6JD9upelt7gJLCWgXkSjzoud03mUggzU/gP2aPABcoUCAcxRoAF017mA?=
 =?koi8-r?Q?efug+3K2zzAzUjT4CDtSl41DI77pDEZ3mT4CY7KZ051ArpRsf+Pld6kc9nMm6w?=
 =?koi8-r?Q?caxWocGQ4azQuipAyxLoym3Iw3pZOQ5v5Q5grBIxuzw5haY5rF?=
Content-Type: multipart/mixed; boundary="_009_ZCaReYKRomOGsM9qhornet_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR01MB6100.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 896e82ed-6311-4216-b767-08db31bd0531
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2023 07:53:30.8379
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9fa4f438-b1e6-473b-803f-86f8aedf0dec
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O2mHUe+MujMpbyAuQqWQMJJqZSxsQyX9/L60M9II69hl2yAWVbEr45obV6K5dGsQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR01MB7515
X-OriginatorOrg: jhu.edu
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230331_005359_087251_42E80659 
X-CRM114-Status: UNSURE (   7.28  )
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

--_009_ZCaReYKRomOGsM9qhornet_
Content-Type: text/plain; charset="koi8-r"
Content-ID: <132D8EC18E75BC4AAA9055FC01FC8E0C@prod.exchangelabs.com>
Content-Transfer-Encoding: quoted-printable

Thanks a lot, Damien. This was very helpful indeed. As you have suggested,
I've run a few fio test with libaio and io_uring engines with QD=3D32 and
different number of jobs. The results were mostly consistent between the tw=
o
engines, except for the random reads in the cached mode. In the case of
libaio, there was virtually no difference between different nodes, and the
bandwidth steadily increased with the number of nodes. Which made sense to
me after your explanations.

But for io_uring, node #0 was getting progressively faster as the number
of jobs increased, but the other three were getting slower, see the summary
tables below. Does this make sense for you? I understand that libaio engine
might ignore the iodepth settings in the cached mode. But smaller QD should
make things slower, not faster, shouldn't it? For your information, I also
attach complete outputs for fio in a few boundary cases.=20

The main things I'm still concerned about is that not all Linux subsystems
might be fully NUMA aware on this machine. As I wrote, it has a buggy BIOS
that doesn't tell the OS its NUMA configuration. I populate the values of
numa_node in /sys/devices/pci0000:* myself after each boot, but this might
not be enough.

Thank you,

  --- Alex.

Benchmarks for random reads: bs =3D 4k, iodepth =3D 32 (in MB/s):

         ||   libaio engine, cached mode  ||  io_uring engine, cached mode =
|
    jobs || CPU#0 | CPU#1 | CPU#2 | CPU#3 || CPU#0 | CPU#1 | CPU#2 | CPU#3 =
|
   ------------------------------------------------------------------------=
-
      1  ||  47.5 |  46.2 |  46.0 |  46.5 ||   330 |   285 |   281 |   252 =
|
      2  ||  94.2 |  91.8 |  90.9 |  91.8 ||   571 |   189 |   186 |   203 =
|
      4  ||   180 |   176 |   175 |   176 ||  1108 |   184 |   191 |   219 =
|
      8  ||   331 |   322 |   319 |   322 ||  1142 |   170 |   174 |   177 =
|
     16  ||   585 |   554 |   545 |   552 ||  1353 |   175 |   173 |   180 =
|
   ------------------------------------------------------------------------=
-
  =20
         ||   libaio engine, direct mode  ||  io_uring engine, direct mode =
|
    jobs || CPU#0 | CPU#1 | CPU#2 | CPU#3 || CPU#0 | CPU#1 | CPU#2 | CPU#3 =
|
   ------------------------------------------------------------------------=
-
      1  ||   544 |   520 |   477 |  519  ||   506 |   558 |   532 |   476 =
|
      2  ||  1034 |   928 |   943 |  996  ||  1028 |   938 |  1023 |  1004 =
|
      4  ||  1139 |  1138 |  1138 | 1139  ||  1138 |  1138 |  1138 |  1138 =
|
      8  ||  1140 |  1141 |  1141 | 1141  ||  1142 |  1142 |  1141 |  1141 =
|
     16  ||  1141 |  1135 |  1112 | 1136  ||  1141 |  1130 |  1133 |  1135 =
|
   ------------------------------------------------------------------------=
-
  =20

Benchmarks for sequential reads: bs =3D 256k, iodepth =3D 32, numjobs =3D 1=
.

   |   libaio engine, cached mode  ||  io_uring engine, cached mode |
   | CPU#0 | CPU#1 | CPU#2 | CPU#3 || CPU#0 | CPU#1 | CPU#2 | CPU#3 |
   ------------------------------------------------------------------
   |  1411 |   160 |   159 |   163 ||  1355 |   160 |   159 |   163 |
   ------------------------------------------------------------------
  =20
   |   libaio engine, direct mode  ||  io_uring engine, direct mode |
   | CPU#0 | CPU#1 | CPU#2 | CPU#3 || CPU#0 | CPU#1 | CPU#2 | CPU#3 |
   ------------------------------------------------------------------
   |  3627 |  2160 |  1637 |  2184 ||  3627 |  2076 |  1756 |  2167 |
   ------------------------------------------------------------------
  =20

On Sat, Mar 25, 2023 at 10:52:02AM +0900, Damien Le Moal wrote:
> For fast block devices, the overhead of the page management and memory
> copies done when using the page cache is very visible. Nothing that can b=
e
> done about that. Any application, fio included, will most of the time sho=
w
> slower performance because of that overhead. Not always true though (e.g.
> sequential read with read-ahead should be just fine), but at the very lea=
st
> you will see a higher CPU load.
>=20
> dd and hdparm will also exercise the drive at QD=3D1, far from ideal when
> trying to measure the maximum throughput of a device, unless you one uses
> very large IO sizes.
>=20

--_009_ZCaReYKRomOGsM9qhornet_
Content-Type: text/plain;
	name="fio-io_uring-iodepth_32-numjobs_16_cached-node0.txt"
Content-Description: fio-io_uring-iodepth_32-numjobs_16_cached-node0.txt
Content-Disposition: attachment;
	filename="fio-io_uring-iodepth_32-numjobs_16_cached-node0.txt"; size=1895;
	creation-date="Fri, 31 Mar 2023 07:53:30 GMT";
	modification-date="Fri, 31 Mar 2023 07:53:30 GMT"
Content-ID: <B207AE88CAF42A419C4E7DB213945A6A@prod.exchangelabs.com>
Content-Transfer-Encoding: base64

bnZtZTA6IChnPTApOiBydz1yYW5kcmVhZCwgYnM9KFIpIDQwOTZCLTQwOTZCLCAoVykgNDA5NkIt
NDA5NkIsIChUKSA0MDk2Qi00MDk2QiwgaW9lbmdpbmU9aW9fdXJpbmcsIGlvZGVwdGg9MzINCi4u
Lg0KZmlvLTMuMjUNClN0YXJ0aW5nIDE2IHByb2Nlc3Nlcw0KDQpudm1lMDogKGdyb3VwaWQ9MCwg
am9icz0xNik6IGVycj0gMDogcGlkPTE1ODA3OiBTYXQgTWFyIDI1IDIxOjE2OjI0IDIwMjMNCiAg
cmVhZDogSU9QUz0zMzBrLCBCVz0xMjkwTWlCL3MgKDEzNTNNQi9zKSgzNy44R2lCLzMwMDAzbXNl
YykNCiAgICBzbGF0IChuc2VjKTogbWluPTE5MzgsIG1heD0yMjU3NDksIGF2Zz0xNDQzNC4yMywg
c3RkZXY9NjUwNS42NQ0KICAgIGNsYXQgKHVzZWMpOiBtaW49NCwgbWF4PTU5OTcsIGF2Zz0xNTMz
LjA5LCBzdGRldj01NjYuOTYNCiAgICAgbGF0ICh1c2VjKTogbWluPTcsIG1heD02MDIyLCBhdmc9
MTU0Ny45Niwgc3RkZXY9NTY4LjU1DQogICAgY2xhdCBwZXJjZW50aWxlcyAodXNlYyk6DQogICAg
IHwgIDEuMDB0aD1bICAxOTZdLCAgNS4wMHRoPVsgIDI2OV0sIDEwLjAwdGg9WyAgNzgzXSwgMjAu
MDB0aD1bIDExMzldLA0KICAgICB8IDMwLjAwdGg9WyAxMzUyXSwgNDAuMDB0aD1bIDE0ODNdLCA1
MC4wMHRoPVsgMTU4Ml0sIDYwLjAwdGg9WyAxNjgwXSwNCiAgICAgfCA3MC4wMHRoPVsgMTc5NV0s
IDgwLjAwdGg9WyAxOTQyXSwgOTAuMDB0aD1bIDIxODBdLCA5NS4wMHRoPVsgMjQwOV0sDQogICAg
IHwgOTkuMDB0aD1bIDI5MDBdLCA5OS41MHRoPVsgMzEzMF0sIDk5LjkwdGg9WyAzNTg5XSwgOTku
OTV0aD1bIDM3ODVdLA0KICAgICB8IDk5Ljk5dGg9WyA0MjI4XQ0KICAgYncgKCAgTWlCL3MpOiBt
aW49IDEwNzcsIG1heD0gMjUzMCwgcGVyPTEwMC4wMCUsIGF2Zz0xMjkxLjQ1LCBzdGRldj0zOC4x
Miwgc2FtcGxlcz05NjANCiAgIGlvcHMgICAgICAgIDogbWluPTI3NTkyOSwgbWF4PTY0Nzg5Nywg
YXZnPTMzMDYwNi45OCwgc3RkZXY9OTc1OS4zMSwgc2FtcGxlcz05NjANCiAgbGF0ICh1c2VjKSAg
IDogMTA9MC4wMSUsIDIwPTAuMDElLCA1MD0wLjAxJSwgMTAwPTAuMDElLCAyNTA9NC40MyUNCiAg
bGF0ICh1c2VjKSAgIDogNTAwPTIuMzYlLCA3NTA9Mi43NSUsIDEwMDA9NS40MCUNCiAgbGF0ICht
c2VjKSAgIDogMj02OC40MSUsIDQ9MTYuNjMlLCAxMD0wLjAyJQ0KICBjcHUgICAgICAgICAgOiB1
c3I9MTAuNzglLCBzeXM9MzguMTQlLCBjdHg9NDY2ODY1OCwgbWFqZj0wLCBtaW5mPTkzMg0KICBJ
TyBkZXB0aHMgICAgOiAxPTAuMCUsIDI9MC4wJSwgND0wLjAlLCA4PTAuMCUsIDE2PTAuMCUsIDMy
PTEwMC4wJSwgPj02ND0wLjAlDQogICAgIHN1Ym1pdCAgICA6IDA9MC4wJSwgND0xMDAuMCUsIDg9
MC4wJSwgMTY9MC4wJSwgMzI9MC4wJSwgNjQ9MC4wJSwgPj02ND0wLjAlDQogICAgIGNvbXBsZXRl
ICA6IDA9MC4wJSwgND0xMDAuMCUsIDg9MC4wJSwgMTY9MC4wJSwgMzI9MC4xJSwgNjQ9MC4wJSwg
Pj02ND0wLjAlDQogICAgIGlzc3VlZCByd3RzOiB0b3RhbD05OTA3OTM5LDAsMCwwIHNob3J0PTAs
MCwwLDAgZHJvcHBlZD0wLDAsMCwwDQogICAgIGxhdGVuY3kgICA6IHRhcmdldD0wLCB3aW5kb3c9
MCwgcGVyY2VudGlsZT0xMDAuMDAlLCBkZXB0aD0zMg0KDQpSdW4gc3RhdHVzIGdyb3VwIDAgKGFs
bCBqb2JzKToNCiAgIFJFQUQ6IGJ3PTEyOTBNaUIvcyAoMTM1M01CL3MpLCAxMjkwTWlCL3MtMTI5
ME1pQi9zICgxMzUzTUIvcy0xMzUzTUIvcyksIGlvPTM3LjhHaUIgKDQwLjZHQiksIHJ1bj0zMDAw
My0zMDAwM21zZWMNCg0KRGlzayBzdGF0cyAocmVhZC93cml0ZSk6DQogIG52bWUwbjE6IGlvcz05
NzU4MDIxLzAsIG1lcmdlPTAvMCwgdGlja3M9MTYyMDUyMDYvMCwgaW5fcXVldWU9MTYyMDUyMDYs
IHV0aWw9OTkuODglDQo=

--_009_ZCaReYKRomOGsM9qhornet_
Content-Type: text/plain;
	name="fio-io_uring-iodepth_32-numjobs_16_cached-node1.txt"
Content-Description: fio-io_uring-iodepth_32-numjobs_16_cached-node1.txt
Content-Disposition: attachment;
	filename="fio-io_uring-iodepth_32-numjobs_16_cached-node1.txt"; size=1848;
	creation-date="Fri, 31 Mar 2023 07:53:30 GMT";
	modification-date="Fri, 31 Mar 2023 07:53:30 GMT"
Content-ID: <33D83B8DA45080419351F0C4197DC4BA@prod.exchangelabs.com>
Content-Transfer-Encoding: base64

bnZtZTA6IChnPTApOiBydz1yYW5kcmVhZCwgYnM9KFIpIDQwOTZCLTQwOTZCLCAoVykgNDA5NkIt
NDA5NkIsIChUKSA0MDk2Qi00MDk2QiwgaW9lbmdpbmU9aW9fdXJpbmcsIGlvZGVwdGg9MzINCi4u
Lg0KZmlvLTMuMjUNClN0YXJ0aW5nIDE2IHByb2Nlc3Nlcw0KDQpudm1lMDogKGdyb3VwaWQ9MCwg
am9icz0xNik6IGVycj0gMDogcGlkPTE1ODk4OiBTYXQgTWFyIDI1IDIxOjE3OjAyIDIwMjMNCiAg
cmVhZDogSU9QUz00Mi43aywgQlc9MTY3TWlCL3MgKDE3NU1CL3MpKDUwMDhNaUIvMzAwMTRtc2Vj
KQ0KICAgIHNsYXQgKHVzZWMpOiBtaW49NywgbWF4PTM5NSwgYXZnPTMwLjYyLCBzdGRldj0xMy4y
NQ0KICAgIGNsYXQgKHVzZWMpOiBtaW49MTcwLCBtYXg9Mjc0NDYsIGF2Zz0xMTk1Mi4wNiwgc3Rk
ZXY9MjkzOC4yNw0KICAgICBsYXQgKHVzZWMpOiBtaW49MjAwLCBtYXg9Mjc0NjIsIGF2Zz0xMTk4
My4zNCwgc3RkZXY9MjkzNy4wMw0KICAgIGNsYXQgcGVyY2VudGlsZXMgKHVzZWMpOg0KICAgICB8
ICAxLjAwdGg9WyAyMzExXSwgIDUuMDB0aD1bIDYxOTRdLCAxMC4wMHRoPVsgNzYzNV0sIDIwLjAw
dGg9WzEwMDI4XSwNCiAgICAgfCAzMC4wMHRoPVsxMTQ2OV0sIDQwLjAwdGg9WzEyMzg3XSwgNTAu
MDB0aD1bMTI5MTFdLCA2MC4wMHRoPVsxMzMwNF0sDQogICAgIHwgNzAuMDB0aD1bMTMzMDRdLCA4
MC4wMHRoPVsxMzMwNF0sIDkwLjAwdGg9WzE0MjIyXSwgOTUuMDB0aD1bMTU5MjZdLA0KICAgICB8
IDk5LjAwdGg9WzE4NzQ0XSwgOTkuNTB0aD1bMTk1MzBdLCA5OS45MHRoPVsyMTg5MF0sIDk5Ljk1
dGg9WzIyOTM4XSwNCiAgICAgfCA5OS45OXRoPVsyNTI5N10NCiAgIGJ3ICggIEtpQi9zKTogbWlu
PTE0OTkzNywgbWF4PTIwMTY2MiwgcGVyPTEwMC4wMCUsIGF2Zz0xNzA5MTYuMTMsIHN0ZGV2PTYw
NS42OCwgc2FtcGxlcz05NjANCiAgIGlvcHMgICAgICAgIDogbWluPTM3NDg0LCBtYXg9NTA0MTQs
IGF2Zz00MjcyOC4zNywgc3RkZXY9MTUxLjQxLCBzYW1wbGVzPTk2MA0KICBsYXQgKHVzZWMpICAg
OiAyNTA9MC4wMSUsIDUwMD0wLjAxJSwgNzUwPTAuMDIlLCAxMDAwPTAuMDUlDQogIGxhdCAobXNl
YykgICA6IDI9MC43MyUsIDQ9MS4yNSUsIDEwPTE3LjUwJSwgMjA9ODAuMTQlLCA1MD0wLjM1JQ0K
ICBjcHUgICAgICAgICAgOiB1c3I9Mi45MCUsIHN5cz0xMS4xNiUsIGN0eD02MzI4MDAsIG1hamY9
MCwgbWluZj05MzENCiAgSU8gZGVwdGhzICAgIDogMT0wLjAlLCAyPTAuMCUsIDQ9MC4wJSwgOD0w
LjAlLCAxNj0wLjAlLCAzMj0xMDAuMCUsID49NjQ9MC4wJQ0KICAgICBzdWJtaXQgICAgOiAwPTAu
MCUsIDQ9MTAwLjAlLCA4PTAuMCUsIDE2PTAuMCUsIDMyPTAuMCUsIDY0PTAuMCUsID49NjQ9MC4w
JQ0KICAgICBjb21wbGV0ZSAgOiAwPTAuMCUsIDQ9MTAwLjAlLCA4PTAuMCUsIDE2PTAuMCUsIDMy
PTAuMSUsIDY0PTAuMCUsID49NjQ9MC4wJQ0KICAgICBpc3N1ZWQgcnd0czogdG90YWw9MTI4MTU2
MCwwLDAsMCBzaG9ydD0wLDAsMCwwIGRyb3BwZWQ9MCwwLDAsMA0KICAgICBsYXRlbmN5ICAgOiB0
YXJnZXQ9MCwgd2luZG93PTAsIHBlcmNlbnRpbGU9MTAwLjAwJSwgZGVwdGg9MzINCg0KUnVuIHN0
YXR1cyBncm91cCAwIChhbGwgam9icyk6DQogICBSRUFEOiBidz0xNjdNaUIvcyAoMTc1TUIvcyks
IDE2N01pQi9zLTE2N01pQi9zICgxNzVNQi9zLTE3NU1CL3MpLCBpbz01MDA4TWlCICg1MjUxTUIp
LCBydW49MzAwMTQtMzAwMTRtc2VjDQoNCkRpc2sgc3RhdHMgKHJlYWQvd3JpdGUpOg0KICBudm1l
MG4xOiBpb3M9MTQ5NTkzMy8wLCBtZXJnZT0wLzAsIHRpY2tzPTE3NzkyMjk1LzAsIGluX3F1ZXVl
PTE3NzkyMjk1LCB1dGlsPTk5LjkxJQ0K

--_009_ZCaReYKRomOGsM9qhornet_
Content-Type: text/plain;
	name="fio-io_uring-iodepth_32-numjobs_1_cached-node0.txt"
Content-Description: fio-io_uring-iodepth_32-numjobs_1_cached-node0.txt
Content-Disposition: attachment;
	filename="fio-io_uring-iodepth_32-numjobs_1_cached-node0.txt"; size=1782;
	creation-date="Fri, 31 Mar 2023 07:53:30 GMT";
	modification-date="Fri, 31 Mar 2023 07:53:30 GMT"
Content-ID: <6ADD6F1AEC10BA4FAD20B11FF2F68BA3@prod.exchangelabs.com>
Content-Transfer-Encoding: base64

bnZtZTA6IChnPTApOiBydz1yYW5kcmVhZCwgYnM9KFIpIDQwOTZCLTQwOTZCLCAoVykgNDA5NkIt
NDA5NkIsIChUKSA0MDk2Qi00MDk2QiwgaW9lbmdpbmU9aW9fdXJpbmcsIGlvZGVwdGg9MzINCmZp
by0zLjI1DQpTdGFydGluZyAxIHByb2Nlc3MNCg0KbnZtZTA6IChncm91cGlkPTAsIGpvYnM9MSk6
IGVycj0gMDogcGlkPTEzNDkxOiBTYXQgTWFyIDI1IDIwOjU2OjMwIDIwMjMNCiAgcmVhZDogSU9Q
Uz04MC41aywgQlc9MzE0TWlCL3MgKDMzME1CL3MpKDk0MzFNaUIvMzAwMDFtc2VjKQ0KICAgIHNs
YXQgKHVzZWMpOiBtaW49NSwgbWF4PTE4NCwgYXZnPTEwLjYzLCBzdGRldj0gNS4wOA0KICAgIGNs
YXQgKHVzZWMpOiBtaW49MTE0LCBtYXg9MTAyNCwgYXZnPTM4NS40OCwgc3RkZXY9MzEuNDUNCiAg
ICAgbGF0ICh1c2VjKTogbWluPTEyNSwgbWF4PTEwMzEsIGF2Zz0zOTYuMzMsIHN0ZGV2PTMxLjU5
DQogICAgY2xhdCBwZXJjZW50aWxlcyAodXNlYyk6DQogICAgIHwgIDEuMDB0aD1bICAzMzBdLCAg
NS4wMHRoPVsgIDM0M10sIDEwLjAwdGg9WyAgMzUxXSwgMjAuMDB0aD1bICAzNjNdLA0KICAgICB8
IDMwLjAwdGg9WyAgMzcxXSwgNDAuMDB0aD1bICAzNzVdLCA1MC4wMHRoPVsgIDM4M10sIDYwLjAw
dGg9WyAgMzg4XSwNCiAgICAgfCA3MC4wMHRoPVsgIDM5Nl0sIDgwLjAwdGg9WyAgNDA4XSwgOTAu
MDB0aD1bICA0MjRdLCA5NS4wMHRoPVsgIDQ0MV0sDQogICAgIHwgOTkuMDB0aD1bICA0OTBdLCA5
OS41MHRoPVsgIDUxMF0sIDk5LjkwdGg9WyAgNTcwXSwgOTkuOTV0aD1bICA2MTFdLA0KICAgICB8
IDk5Ljk5dGg9WyAgNzAxXQ0KICAgYncgKCAgS2lCL3MpOiBtaW49MzE3NjE2LCBtYXg9MzI1Nzcx
LCBwZXI9MTAwLjAwJSwgYXZnPTMyMjM5My43NSwgc3RkZXY9MTg5Ny4zMiwgc2FtcGxlcz02MA0K
ICAgaW9wcyAgICAgICAgOiBtaW49Nzk0MDQsIG1heD04MTQ0MCwgYXZnPTgwNTk4LjMwLCBzdGRl
dj00NzQuMjcsIHNhbXBsZXM9NjANCiAgbGF0ICh1c2VjKSAgIDogMjUwPTAuMDElLCA1MDA9OTku
MzIlLCA3NTA9MC42NyUsIDEwMDA9MC4wMSUNCiAgbGF0IChtc2VjKSAgIDogMj0wLjAxJQ0KICBj
cHUgICAgICAgICAgOiB1c3I9MTYuNTMlLCBzeXM9ODMuMzclLCBjdHg9MjM3MSwgbWFqZj0wLCBt
aW5mPTU4DQogIElPIGRlcHRocyAgICA6IDE9MC4wJSwgMj0wLjAlLCA0PTAuMCUsIDg9MC4wJSwg
MTY9MC4wJSwgMzI9MTAwLjAlLCA+PTY0PTAuMCUNCiAgICAgc3VibWl0ICAgIDogMD0wLjAlLCA0
PTEwMC4wJSwgOD0wLjAlLCAxNj0wLjAlLCAzMj0wLjAlLCA2ND0wLjAlLCA+PTY0PTAuMCUNCiAg
ICAgY29tcGxldGUgIDogMD0wLjAlLCA0PTEwMC4wJSwgOD0wLjAlLCAxNj0wLjAlLCAzMj0wLjEl
LCA2ND0wLjAlLCA+PTY0PTAuMCUNCiAgICAgaXNzdWVkIHJ3dHM6IHRvdGFsPTI0MTQzNDQsMCww
LDAgc2hvcnQ9MCwwLDAsMCBkcm9wcGVkPTAsMCwwLDANCiAgICAgbGF0ZW5jeSAgIDogdGFyZ2V0
PTAsIHdpbmRvdz0wLCBwZXJjZW50aWxlPTEwMC4wMCUsIGRlcHRoPTMyDQoNClJ1biBzdGF0dXMg
Z3JvdXAgMCAoYWxsIGpvYnMpOg0KICAgUkVBRDogYnc9MzE0TWlCL3MgKDMzME1CL3MpLCAzMTRN
aUIvcy0zMTRNaUIvcyAoMzMwTUIvcy0zMzBNQi9zKSwgaW89OTQzMU1pQiAoOTg4OU1CKSwgcnVu
PTMwMDAxLTMwMDAxbXNlYw0KDQpEaXNrIHN0YXRzIChyZWFkL3dyaXRlKToNCiAgbnZtZTBuMTog
aW9zPTI3ODM4OTcvMCwgbWVyZ2U9MC8wLCB0aWNrcz0yMjc2ODgvMCwgaW5fcXVldWU9MjI3Njg4
LCB1dGlsPTk5Ljg3JQ0K

--_009_ZCaReYKRomOGsM9qhornet_
Content-Type: text/plain;
	name="fio-io_uring-iodepth_32-numjobs_1_cached-node1.txt"
Content-Description: fio-io_uring-iodepth_32-numjobs_1_cached-node1.txt
Content-Disposition: attachment;
	filename="fio-io_uring-iodepth_32-numjobs_1_cached-node1.txt"; size=1787;
	creation-date="Fri, 31 Mar 2023 07:53:30 GMT";
	modification-date="Fri, 31 Mar 2023 07:53:30 GMT"
Content-ID: <3BE74B888CFE7B4590ED53710941BBE7@prod.exchangelabs.com>
Content-Transfer-Encoding: base64

bnZtZTA6IChnPTApOiBydz1yYW5kcmVhZCwgYnM9KFIpIDQwOTZCLTQwOTZCLCAoVykgNDA5NkIt
NDA5NkIsIChUKSA0MDk2Qi00MDk2QiwgaW9lbmdpbmU9aW9fdXJpbmcsIGlvZGVwdGg9MzINCmZp
by0zLjI1DQpTdGFydGluZyAxIHByb2Nlc3MNCg0KbnZtZTA6IChncm91cGlkPTAsIGpvYnM9MSk6
IGVycj0gMDogcGlkPTEzNTU5OiBTYXQgTWFyIDI1IDIwOjU3OjA4IDIwMjMNCiAgcmVhZDogSU9Q
Uz02OS43aywgQlc9MjcyTWlCL3MgKDI4NU1CL3MpKDgxNjZNaUIvMzAwMDFtc2VjKQ0KICAgIHNs
YXQgKHVzZWMpOiBtaW49NSwgbWF4PTE4NCwgYXZnPTExLjY0LCBzdGRldj0gNS45OQ0KICAgIGNs
YXQgKHVzZWMpOiBtaW49MTIyLCBtYXg9MTI2NiwgYXZnPTQ0NS45NSwgc3RkZXY9ODAuODgNCiAg
ICAgbGF0ICh1c2VjKTogbWluPTE0NSwgbWF4PTEyNzgsIGF2Zz00NTcuODUsIHN0ZGV2PTgwLjcw
DQogICAgY2xhdCBwZXJjZW50aWxlcyAodXNlYyk6DQogICAgIHwgIDEuMDB0aD1bICAzNTldLCAg
NS4wMHRoPVsgIDM3OV0sIDEwLjAwdGg9WyAgMzg4XSwgMjAuMDB0aD1bICA0MDBdLA0KICAgICB8
IDMwLjAwdGg9WyAgNDA4XSwgNDAuMDB0aD1bICA0MTZdLCA1MC4wMHRoPVsgIDQyMF0sIDYwLjAw
dGg9WyAgNDMzXSwNCiAgICAgfCA3MC4wMHRoPVsgIDQ0NV0sIDgwLjAwdGg9WyAgNDY1XSwgOTAu
MDB0aD1bICA1MjNdLCA5NS4wMHRoPVsgIDY4NV0sDQogICAgIHwgOTkuMDB0aD1bICA3MTddLCA5
OS41MHRoPVsgIDc1MF0sIDk5LjkwdGg9WyAgODU3XSwgOTkuOTV0aD1bICA5MDZdLA0KICAgICB8
IDk5Ljk5dGg9WyAxMDEyXQ0KICAgYncgKCAgS2lCL3MpOiBtaW49MjQ0MDAwLCBtYXg9Mjg5MTU0
LCBwZXI9MTAwLjAwJSwgYXZnPTI3OTA5Ni44MCwgc3RkZXY9MTA1NDAuNTQsIHNhbXBsZXM9NTkN
CiAgIGlvcHMgICAgICAgIDogbWluPTYxMDAwLCBtYXg9NzIyODYsIGF2Zz02OTc3My45Nywgc3Rk
ZXY9MjYzNS4xOCwgc2FtcGxlcz01OQ0KICBsYXQgKHVzZWMpICAgOiAyNTA9MC4wMiUsIDUwMD04
Ni45MiUsIDc1MD0xMi42MCUsIDEwMDA9MC40NSUNCiAgbGF0IChtc2VjKSAgIDogMj0wLjAxJQ0K
ICBjcHUgICAgICAgICAgOiB1c3I9MTQuNDclLCBzeXM9ODMuMDElLCBjdHg9MTEwNDQ2LCBtYWpm
PTAsIG1pbmY9NTgNCiAgSU8gZGVwdGhzICAgIDogMT0wLjAlLCAyPTAuMCUsIDQ9MC4wJSwgOD0w
LjAlLCAxNj0wLjAlLCAzMj0xMDAuMCUsID49NjQ9MC4wJQ0KICAgICBzdWJtaXQgICAgOiAwPTAu
MCUsIDQ9MTAwLjAlLCA4PTAuMCUsIDE2PTAuMCUsIDMyPTAuMCUsIDY0PTAuMCUsID49NjQ9MC4w
JQ0KICAgICBjb21wbGV0ZSAgOiAwPTAuMCUsIDQ9MTAwLjAlLCA4PTAuMCUsIDE2PTAuMCUsIDMy
PTAuMSUsIDY0PTAuMCUsID49NjQ9MC4wJQ0KICAgICBpc3N1ZWQgcnd0czogdG90YWw9MjA5MDM1
MSwwLDAsMCBzaG9ydD0wLDAsMCwwIGRyb3BwZWQ9MCwwLDAsMA0KICAgICBsYXRlbmN5ICAgOiB0
YXJnZXQ9MCwgd2luZG93PTAsIHBlcmNlbnRpbGU9MTAwLjAwJSwgZGVwdGg9MzINCg0KUnVuIHN0
YXR1cyBncm91cCAwIChhbGwgam9icyk6DQogICBSRUFEOiBidz0yNzJNaUIvcyAoMjg1TUIvcyks
IDI3Mk1pQi9zLTI3Mk1pQi9zICgyODVNQi9zLTI4NU1CL3MpLCBpbz04MTY2TWlCICg4NTYyTUIp
LCBydW49MzAwMDEtMzAwMDFtc2VjDQoNCkRpc2sgc3RhdHMgKHJlYWQvd3JpdGUpOg0KICBudm1l
MG4xOiBpb3M9MjQxNzE2NC8wLCBtZXJnZT0wLzAsIHRpY2tzPTMyNDI1My8wLCBpbl9xdWV1ZT0z
MjQyNTMsIHV0aWw9OTkuODYlDQo=

--_009_ZCaReYKRomOGsM9qhornet_
Content-Type: text/plain;
	name="fio-libaio-iodepth_32-numjobs_16_cached-node0.txt"
Content-Description: fio-libaio-iodepth_32-numjobs_16_cached-node0.txt
Content-Disposition: attachment;
	filename="fio-libaio-iodepth_32-numjobs_16_cached-node0.txt"; size=1876;
	creation-date="Fri, 31 Mar 2023 07:53:30 GMT";
	modification-date="Fri, 31 Mar 2023 07:53:30 GMT"
Content-ID: <6883775BDA29D146907D5E2F8AC21E17@prod.exchangelabs.com>
Content-Transfer-Encoding: base64

bnZtZTA6IChnPTApOiBydz1yYW5kcmVhZCwgYnM9KFIpIDQwOTZCLTQwOTZCLCAoVykgNDA5NkIt
NDA5NkIsIChUKSA0MDk2Qi00MDk2QiwgaW9lbmdpbmU9bGliYWlvLCBpb2RlcHRoPTMyDQouLi4N
CmZpby0zLjI1DQpTdGFydGluZyAxNiBwcm9jZXNzZXMNCg0KbnZtZTA6IChncm91cGlkPTAsIGpv
YnM9MTYpOiBlcnI9IDA6IHBpZD03MzU0OiBTYXQgTWFyIDI1IDAyOjM5OjA4IDIwMjMNCiAgcmVh
ZDogSU9QUz0xNDNrLCBCVz01NThNaUIvcyAoNTg1TUIvcykoMTYuM0dpQi8zMDAwMm1zZWMpDQog
ICAgc2xhdCAodXNlYyk6IG1pbj0yLCBtYXg9NDk0LCBhdmc9MTA3LjYzLCBzdGRldj0zOC43Ng0K
ICAgIGNsYXQgKHVzZWMpOiBtaW49MywgbWF4PTUxMjksIGF2Zz0zNDc0LjYyLCBzdGRldj03MTgu
MTYNCiAgICAgbGF0ICh1c2VjKTogbWluPTg5LCBtYXg9NTIzOSwgYXZnPTM1ODIuNzUsIHN0ZGV2
PTc0MC4wNA0KICAgIGNsYXQgcGVyY2VudGlsZXMgKHVzZWMpOg0KICAgICB8ICAxLjAwdGg9WyAg
MTM5XSwgIDUuMDB0aD1bIDMxOTVdLCAxMC4wMHRoPVsgMzMyNl0sIDIwLjAwdGg9WyAzNDI1XSwN
CiAgICAgfCAzMC4wMHRoPVsgMzQ5MF0sIDQwLjAwdGg9WyAzNTU2XSwgNTAuMDB0aD1bIDM1ODld
LCA2MC4wMHRoPVsgMzY1NF0sDQogICAgIHwgNzAuMDB0aD1bIDM3MjBdLCA4MC4wMHRoPVsgMzc4
NV0sIDkwLjAwdGg9WyAzODg0XSwgOTUuMDB0aD1bIDM5NDldLA0KICAgICB8IDk5LjAwdGg9WyA0
MTQ2XSwgOTkuNTB0aD1bIDQyMjhdLCA5OS45MHRoPVsgNDM1OV0sIDk5Ljk1dGg9WyA0NDI0XSwN
CiAgICAgfCA5OS45OXRoPVsgNDU1NV0NCiAgIGJ3ICggIEtpQi9zKTogbWluPTUzNzYxNywgbWF4
PTEyOTU4MzcsIHBlcj0xMDAuMDAlLCBhdmc9NTcyNTM4Ljc5LCBzdGRldj0zMDk1Mi40Nywgc2Ft
cGxlcz05NDUNCiAgIGlvcHMgICAgICAgIDogbWluPTEzNDQwMCwgbWF4PTMyMzk1NiwgYXZnPTE0
MzEzMC43Nywgc3RkZXY9NzczOC4xMywgc2FtcGxlcz05NDUNCiAgbGF0ICh1c2VjKSAgIDogND0w
LjAxJSwgMTA9MC4wMSUsIDIwPTAuMDElLCAxMDA9MC4wMSUsIDI1MD00LjE1JQ0KICBsYXQgKHVz
ZWMpICAgOiA1MDA9MC4wMSUsIDc1MD0wLjAxJSwgMTAwMD0wLjAxJQ0KICBsYXQgKG1zZWMpICAg
OiAyPTAuMDElLCA0PTkyLjI5JSwgMTA9My41NyUNCiAgY3B1ICAgICAgICAgIDogdXNyPTUuMDQl
LCBzeXM9MTQuNDglLCBjdHg9NDEwNzU3OCwgbWFqZj0wLCBtaW5mPTkzMg0KICBJTyBkZXB0aHMg
ICAgOiAxPTAuMCUsIDI9MC4wJSwgND0wLjAlLCA4PTAuMCUsIDE2PTAuMCUsIDMyPTEwMC4wJSwg
Pj02ND0wLjAlDQogICAgIHN1Ym1pdCAgICA6IDA9MC4wJSwgND0xMDAuMCUsIDg9MC4wJSwgMTY9
MC4wJSwgMzI9MC4wJSwgNjQ9MC4wJSwgPj02ND0wLjAlDQogICAgIGNvbXBsZXRlICA6IDA9MC4w
JSwgND0xMDAuMCUsIDg9MC4wJSwgMTY9MC4wJSwgMzI9MC4xJSwgNjQ9MC4wJSwgPj02ND0wLjAl
DQogICAgIGlzc3VlZCByd3RzOiB0b3RhbD00Mjg0NzQxLDAsMCwwIHNob3J0PTAsMCwwLDAgZHJv
cHBlZD0wLDAsMCwwDQogICAgIGxhdGVuY3kgICA6IHRhcmdldD0wLCB3aW5kb3c9MCwgcGVyY2Vu
dGlsZT0xMDAuMDAlLCBkZXB0aD0zMg0KDQpSdW4gc3RhdHVzIGdyb3VwIDAgKGFsbCBqb2JzKToN
CiAgIFJFQUQ6IGJ3PTU1OE1pQi9zICg1ODVNQi9zKSwgNTU4TWlCL3MtNTU4TWlCL3MgKDU4NU1C
L3MtNTg1TUIvcyksIGlvPTE2LjNHaUIgKDE3LjZHQiksIHJ1bj0zMDAwMi0zMDAwMm1zZWMNCg0K
RGlzayBzdGF0cyAocmVhZC93cml0ZSk6DQogIG52bWUwbjE6IGlvcz00NjYxNDk1LzAsIG1lcmdl
PTAvMCwgdGlja3M9NDQ0NzgyLzAsIGluX3F1ZXVlPTQ0NDc4MiwgdXRpbD05OS44NCUNCg==

--_009_ZCaReYKRomOGsM9qhornet_
Content-Type: text/plain;
	name="fio-libaio-iodepth_32-numjobs_16_cached-node1.txt"
Content-Description: fio-libaio-iodepth_32-numjobs_16_cached-node1.txt
Content-Disposition: attachment;
	filename="fio-libaio-iodepth_32-numjobs_16_cached-node1.txt"; size=1870;
	creation-date="Fri, 31 Mar 2023 07:53:30 GMT";
	modification-date="Fri, 31 Mar 2023 07:53:30 GMT"
Content-ID: <6EB2293C9460704DADDD8F0B59DAC45B@prod.exchangelabs.com>
Content-Transfer-Encoding: base64

bnZtZTA6IChnPTApOiBydz1yYW5kcmVhZCwgYnM9KFIpIDQwOTZCLTQwOTZCLCAoVykgNDA5NkIt
NDA5NkIsIChUKSA0MDk2Qi00MDk2QiwgaW9lbmdpbmU9bGliYWlvLCBpb2RlcHRoPTMyDQouLi4N
CmZpby0zLjI1DQpTdGFydGluZyAxNiBwcm9jZXNzZXMNCg0KbnZtZTA6IChncm91cGlkPTAsIGpv
YnM9MTYpOiBlcnI9IDA6IHBpZD03MjcxOiBTYXQgTWFyIDI1IDAyOjM2OjQxIDIwMjMNCiAgcmVh
ZDogSU9QUz0xMzVrLCBCVz01MjhNaUIvcyAoNTU0TUIvcykoMTUuNUdpQi8zMDAwMW1zZWMpDQog
ICAgc2xhdCAodXNlYyk6IG1pbj0yLCBtYXg9NjY4LCBhdmc9MTEzLjk3LCBzdGRldj00OC42Nw0K
ICAgIGNsYXQgKHVzZWMpOiBtaW49NCwgbWF4PTEwMDQxLCBhdmc9MzY3MC43Miwgc3RkZXY9ODY4
LjMzDQogICAgIGxhdCAodXNlYyk6IG1pbj05MCwgbWF4PTEwMTYzLCBhdmc9Mzc4NS4xOSwgc3Rk
ZXY9ODkyLjg5DQogICAgY2xhdCBwZXJjZW50aWxlcyAodXNlYyk6DQogICAgIHwgIDEuMDB0aD1b
ICAxNjVdLCAgNS4wMHRoPVsgMzI5NF0sIDEwLjAwdGg9WyAzNDI1XSwgMjAuMDB0aD1bIDM1MjNd
LA0KICAgICB8IDMwLjAwdGg9WyAzNjIxXSwgNDAuMDB0aD1bIDM2NTRdLCA1MC4wMHRoPVsgMzcy
MF0sIDYwLjAwdGg9WyAzNzg1XSwNCiAgICAgfCA3MC4wMHRoPVsgMzg1MV0sIDgwLjAwdGg9WyAz
OTgyXSwgOTAuMDB0aD1bIDQxNzhdLCA5NS4wMHRoPVsgNDU1NV0sDQogICAgIHwgOTkuMDB0aD1b
IDU2NjldLCA5OS41MHRoPVsgNjMyNV0sIDk5LjkwdGg9WyA3NzY3XSwgOTkuOTV0aD1bIDg0NTVd
LA0KICAgICB8IDk5Ljk5dGg9WyA5MzcyXQ0KICAgYncgKCAgS2lCL3MpOiBtaW49NDkwMjMwLCBt
YXg9MTIyNDU2MiwgcGVyPTEwMC4wMCUsIGF2Zz01NDE3MzYuODMsIHN0ZGV2PTI4NTIyLjA2LCBz
YW1wbGVzPTk0NA0KICAgaW9wcyAgICAgICAgOiBtaW49MTIyNTU0LCBtYXg9MzA2MTMxLCBhdmc9
MTM1NDI5LjEwLCBzdGRldj03MTMwLjUyLCBzYW1wbGVzPTk0NA0KICBsYXQgKHVzZWMpICAgOiAx
MD0wLjAxJSwgMTAwPTAuMDElLCAyNTA9NC4zOSUsIDUwMD0wLjAxJSwgNzUwPTAuMDElDQogIGxh
dCAodXNlYykgICA6IDEwMDA9MC4wMSUNCiAgbGF0IChtc2VjKSAgIDogMj0wLjAxJSwgND03Ny43
NCUsIDEwPTE3Ljg3JSwgMjA9MC4wMSUNCiAgY3B1ICAgICAgICAgIDogdXNyPTQuNjMlLCBzeXM9
MTUuODQlLCBjdHg9Mzg3ODA4NCwgbWFqZj0wLCBtaW5mPTkzNQ0KICBJTyBkZXB0aHMgICAgOiAx
PTAuMCUsIDI9MC4wJSwgND0wLjAlLCA4PTAuMCUsIDE2PTAuMCUsIDMyPTEwMC4wJSwgPj02ND0w
LjAlDQogICAgIHN1Ym1pdCAgICA6IDA9MC4wJSwgND0xMDAuMCUsIDg9MC4wJSwgMTY9MC4wJSwg
MzI9MC4wJSwgNjQ9MC4wJSwgPj02ND0wLjAlDQogICAgIGNvbXBsZXRlICA6IDA9MC4wJSwgND0x
MDAuMCUsIDg9MC4wJSwgMTY9MC4wJSwgMzI9MC4xJSwgNjQ9MC4wJSwgPj02ND0wLjAlDQogICAg
IGlzc3VlZCByd3RzOiB0b3RhbD00MDU1Njg5LDAsMCwwIHNob3J0PTAsMCwwLDAgZHJvcHBlZD0w
LDAsMCwwDQogICAgIGxhdGVuY3kgICA6IHRhcmdldD0wLCB3aW5kb3c9MCwgcGVyY2VudGlsZT0x
MDAuMDAlLCBkZXB0aD0zMg0KDQpSdW4gc3RhdHVzIGdyb3VwIDAgKGFsbCBqb2JzKToNCiAgIFJF
QUQ6IGJ3PTUyOE1pQi9zICg1NTRNQi9zKSwgNTI4TWlCL3MtNTI4TWlCL3MgKDU1NE1CL3MtNTU0
TUIvcyksIGlvPTE1LjVHaUIgKDE2LjZHQiksIHJ1bj0zMDAwMS0zMDAwMW1zZWMNCg0KRGlzayBz
dGF0cyAocmVhZC93cml0ZSk6DQogIG52bWUwbjE6IGlvcz00NDA5MjI1LzAsIG1lcmdlPTAvMCwg
dGlja3M9NDQzMTM4LzAsIGluX3F1ZXVlPTQ0MzEzOCwgdXRpbD05OS44NCUNCg==

--_009_ZCaReYKRomOGsM9qhornet_
Content-Type: text/plain;
	name="fio-libaio-iodepth_32-numjobs_1_cached-node0.txt"
Content-Description: fio-libaio-iodepth_32-numjobs_1_cached-node0.txt
Content-Disposition: attachment;
	filename="fio-libaio-iodepth_32-numjobs_1_cached-node0.txt"; size=1828;
	creation-date="Fri, 31 Mar 2023 07:53:30 GMT";
	modification-date="Fri, 31 Mar 2023 07:53:30 GMT"
Content-ID: <7FB6B747FBDCE5429930D232DBD0C450@prod.exchangelabs.com>
Content-Transfer-Encoding: base64

bnZtZTA6IChnPTApOiBydz1yYW5kcmVhZCwgYnM9KFIpIDQwOTZCLTQwOTZCLCAoVykgNDA5NkIt
NDA5NkIsIChUKSA0MDk2Qi00MDk2QiwgaW9lbmdpbmU9bGliYWlvLCBpb2RlcHRoPTMyDQpmaW8t
My4yNQ0KU3RhcnRpbmcgMSBwcm9jZXNzDQoNCm52bWUwOiAoZ3JvdXBpZD0wLCBqb2JzPTEpOiBl
cnI9IDA6IHBpZD0xMjE2MjogU2F0IE1hciAyNSAyMDowMTozMSAyMDIzDQogIHJlYWQ6IElPUFM9
MTEuNmssIEJXPTQ1LjNNaUIvcyAoNDcuNU1CL3MpKDEzNjBNaUIvMzAwMDFtc2VjKQ0KICAgIHNs
YXQgKHVzZWMpOiBtaW49NjIsIG1heD0yMzMsIGF2Zz04My4wMSwgc3RkZXY9MTAuMjANCiAgICBj
bGF0ICh1c2VjKTogbWluPTQsIG1heD0zNjMzLCBhdmc9MjY3Mi44Mywgc3RkZXY9ODMuNzMNCiAg
ICAgbGF0ICh1c2VjKTogbWluPTk2LCBtYXg9MzcxNywgYXZnPTI3NTYuMTksIHN0ZGV2PTg0Ljk5
DQogICAgY2xhdCBwZXJjZW50aWxlcyAodXNlYyk6DQogICAgIHwgIDEuMDB0aD1bIDI1NDBdLCAg
NS4wMHRoPVsgMjU3M10sIDEwLjAwdGg9WyAyNjA2XSwgMjAuMDB0aD1bIDI2MDZdLA0KICAgICB8
IDMwLjAwdGg9WyAyNjM4XSwgNDAuMDB0aD1bIDI2MzhdLCA1MC4wMHRoPVsgMjY3MV0sIDYwLjAw
dGg9WyAyNjcxXSwNCiAgICAgfCA3MC4wMHRoPVsgMjcwNF0sIDgwLjAwdGg9WyAyNzA0XSwgOTAu
MDB0aD1bIDI3MzddLCA5NS4wMHRoPVsgMjgwMl0sDQogICAgIHwgOTkuMDB0aD1bIDI5OTldLCA5
OS41MHRoPVsgMzA5N10sIDk5LjkwdGg9WyAzNDI1XSwgOTkuOTV0aD1bIDM0NThdLA0KICAgICB8
IDk5Ljk5dGg9WyAzNTg5XQ0KICAgYncgKCAgS2lCL3MpOiBtaW49NDQ5NjEsIG1heD00Njc4MSwg
cGVyPTEwMC4wMCUsIGF2Zz00NjQ2My41OSwgc3RkZXY9Mzc3Ljg2LCBzYW1wbGVzPTU5DQogICBp
b3BzICAgICAgICA6IG1pbj0xMTI0MCwgbWF4PTExNjk1LCBhdmc9MTE2MTUuNzUsIHN0ZGV2PTk0
LjQ3LCBzYW1wbGVzPTU5DQogIGxhdCAodXNlYykgICA6IDEwPTAuMDElLCAxMDA9MC4wMSUsIDI1
MD0wLjAxJSwgNTAwPTAuMDElLCA3NTA9MC4wMSUNCiAgbGF0ICh1c2VjKSAgIDogMTAwMD0wLjAx
JQ0KICBsYXQgKG1zZWMpICAgOiAyPTAuMDElLCA0PTEwMC4wMCUNCiAgY3B1ICAgICAgICAgIDog
dXNyPTQuOTAlLCBzeXM9MTQuNzElLCBjdHg9MzQ4MTMzLCBtYWpmPTAsIG1pbmY9NTgNCiAgSU8g
ZGVwdGhzICAgIDogMT0wLjAlLCAyPTAuMCUsIDQ9MC4wJSwgOD0wLjAlLCAxNj0wLjAlLCAzMj0x
MDAuMCUsID49NjQ9MC4wJQ0KICAgICBzdWJtaXQgICAgOiAwPTAuMCUsIDQ9MTAwLjAlLCA4PTAu
MCUsIDE2PTAuMCUsIDMyPTAuMCUsIDY0PTAuMCUsID49NjQ9MC4wJQ0KICAgICBjb21wbGV0ZSAg
OiAwPTAuMCUsIDQ9MTAwLjAlLCA4PTAuMCUsIDE2PTAuMCUsIDMyPTAuMSUsIDY0PTAuMCUsID49
NjQ9MC4wJQ0KICAgICBpc3N1ZWQgcnd0czogdG90YWw9MzQ4MTIwLDAsMCwwIHNob3J0PTAsMCww
LDAgZHJvcHBlZD0wLDAsMCwwDQogICAgIGxhdGVuY3kgICA6IHRhcmdldD0wLCB3aW5kb3c9MCwg
cGVyY2VudGlsZT0xMDAuMDAlLCBkZXB0aD0zMg0KDQpSdW4gc3RhdHVzIGdyb3VwIDAgKGFsbCBq
b2JzKToNCiAgIFJFQUQ6IGJ3PTQ1LjNNaUIvcyAoNDcuNU1CL3MpLCA0NS4zTWlCL3MtNDUuM01p
Qi9zICg0Ny41TUIvcy00Ny41TUIvcyksIGlvPTEzNjBNaUIgKDE0MjZNQiksIHJ1bj0zMDAwMS0z
MDAwMW1zZWMNCg0KRGlzayBzdGF0cyAocmVhZC93cml0ZSk6DQogIG52bWUwbjE6IGlvcz00MDUy
NjUvMCwgbWVyZ2U9MC8wLCB0aWNrcz0yODYyMC8wLCBpbl9xdWV1ZT0yODYyMCwgdXRpbD05OS44
MyUNCg==

--_009_ZCaReYKRomOGsM9qhornet_
Content-Type: text/plain;
	name="fio-libaio-iodepth_32-numjobs_1_cached-node1.txt"
Content-Description: fio-libaio-iodepth_32-numjobs_1_cached-node1.txt
Content-Disposition: attachment;
	filename="fio-libaio-iodepth_32-numjobs_1_cached-node1.txt"; size=1801;
	creation-date="Fri, 31 Mar 2023 07:53:30 GMT";
	modification-date="Fri, 31 Mar 2023 07:53:30 GMT"
Content-ID: <E9113F24711CD943AEFEA6D7DCCE5950@prod.exchangelabs.com>
Content-Transfer-Encoding: base64

bnZtZTA6IChnPTApOiBydz1yYW5kcmVhZCwgYnM9KFIpIDQwOTZCLTQwOTZCLCAoVykgNDA5NkIt
NDA5NkIsIChUKSA0MDk2Qi00MDk2QiwgaW9lbmdpbmU9bGliYWlvLCBpb2RlcHRoPTMyDQpmaW8t
My4yNQ0KU3RhcnRpbmcgMSBwcm9jZXNzDQoNCm52bWUwOiAoZ3JvdXBpZD0wLCBqb2JzPTEpOiBl
cnI9IDA6IHBpZD0xMjIzMDogU2F0IE1hciAyNSAyMDowMjowNyAyMDIzDQogIHJlYWQ6IElPUFM9
MTEuM2ssIEJXPTQ0LjFNaUIvcyAoNDYuMk1CL3MpKDEzMjJNaUIvMzAwMDFtc2VjKQ0KICAgIHNs
YXQgKHVzZWMpOiBtaW49NjQsIG1heD00NzgsIGF2Zz04NS40OSwgc3RkZXY9MTAuMTMNCiAgICBj
bGF0ICh1c2VjKTogbWluPTUsIG1heD0zNzk0LCBhdmc9Mjc1MC4yNiwgc3RkZXY9ODEuNDkNCiAg
ICAgbGF0ICh1c2VjKTogbWluPTEwOSwgbWF4PTM4NzEsIGF2Zz0yODM2LjA5LCBzdGRldj04Mi42
Ng0KICAgIGNsYXQgcGVyY2VudGlsZXMgKHVzZWMpOg0KICAgICB8ICAxLjAwdGg9WyAyNjM4XSwg
IDUuMDB0aD1bIDI2NzFdLCAxMC4wMHRoPVsgMjY3MV0sIDIwLjAwdGg9WyAyNzA0XSwNCiAgICAg
fCAzMC4wMHRoPVsgMjcwNF0sIDQwLjAwdGg9WyAyNzM3XSwgNTAuMDB0aD1bIDI3MzddLCA2MC4w
MHRoPVsgMjczN10sDQogICAgIHwgNzAuMDB0aD1bIDI3NjldLCA4MC4wMHRoPVsgMjgwMl0sIDkw
LjAwdGg9WyAyODM1XSwgOTUuMDB0aD1bIDI5MDBdLA0KICAgICB8IDk5LjAwdGg9WyAzMDY0XSwg
OTkuNTB0aD1bIDMxMzBdLCA5OS45MHRoPVsgMzM1OV0sIDk5Ljk1dGg9WyAzNDU4XSwNCiAgICAg
fCA5OS45OXRoPVsgMzYyMV0NCiAgIGJ3ICggIEtpQi9zKTogbWluPTQ0NzkzLCBtYXg9NDU1OTIs
IHBlcj0xMDAuMDAlLCBhdmc9NDUxNTIuNzMsIHN0ZGV2PTE1Ni41NCwgc2FtcGxlcz01OQ0KICAg
aW9wcyAgICAgICAgOiBtaW49MTExOTgsIG1heD0xMTM5OCwgYXZnPTExMjg3LjkzLCBzdGRldj0z
OS4xMywgc2FtcGxlcz01OQ0KICBsYXQgKHVzZWMpICAgOiAxMD0wLjAxJSwgMjUwPTAuMDElLCA1
MDA9MC4wMSUsIDc1MD0wLjAxJSwgMTAwMD0wLjAxJQ0KICBsYXQgKG1zZWMpICAgOiAyPTAuMDEl
LCA0PTEwMC4wMCUNCiAgY3B1ICAgICAgICAgIDogdXNyPTQuNzUlLCBzeXM9MTUuMzMlLCBjdHg9
MzM4MzIyLCBtYWpmPTAsIG1pbmY9NTgNCiAgSU8gZGVwdGhzICAgIDogMT0wLjAlLCAyPTAuMCUs
IDQ9MC4wJSwgOD0wLjAlLCAxNj0wLjAlLCAzMj0xMDAuMCUsID49NjQ9MC4wJQ0KICAgICBzdWJt
aXQgICAgOiAwPTAuMCUsIDQ9MTAwLjAlLCA4PTAuMCUsIDE2PTAuMCUsIDMyPTAuMCUsIDY0PTAu
MCUsID49NjQ9MC4wJQ0KICAgICBjb21wbGV0ZSAgOiAwPTAuMCUsIDQ9MTAwLjAlLCA4PTAuMCUs
IDE2PTAuMCUsIDMyPTAuMSUsIDY0PTAuMCUsID49NjQ9MC4wJQ0KICAgICBpc3N1ZWQgcnd0czog
dG90YWw9MzM4MzE3LDAsMCwwIHNob3J0PTAsMCwwLDAgZHJvcHBlZD0wLDAsMCwwDQogICAgIGxh
dGVuY3kgICA6IHRhcmdldD0wLCB3aW5kb3c9MCwgcGVyY2VudGlsZT0xMDAuMDAlLCBkZXB0aD0z
Mg0KDQpSdW4gc3RhdHVzIGdyb3VwIDAgKGFsbCBqb2JzKToNCiAgIFJFQUQ6IGJ3PTQ0LjFNaUIv
cyAoNDYuMk1CL3MpLCA0NC4xTWlCL3MtNDQuMU1pQi9zICg0Ni4yTUIvcy00Ni4yTUIvcyksIGlv
PTEzMjJNaUIgKDEzODZNQiksIHJ1bj0zMDAwMS0zMDAwMW1zZWMNCg0KRGlzayBzdGF0cyAocmVh
ZC93cml0ZSk6DQogIG52bWUwbjE6IGlvcz0zOTQyOTIvMCwgbWVyZ2U9MC8wLCB0aWNrcz0yODU5
Ni8wLCBpbl9xdWV1ZT0yODU5NiwgdXRpbD05OS44MyUNCg==

--_009_ZCaReYKRomOGsM9qhornet_--

