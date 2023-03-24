Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBC15C6FD20
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Mar 2023 21:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O4CuAlHYVXot/Z1FlRrwAsjPmUHMhMyX8Ehm9+sGVAI=; b=DA2xzvdp+wlIanM8Fehxc49Ey8
	/LaivV8SB6F8l+f21Y87k0o9nXoiy4BriFoqBudPUnXhIONUfC+mRimgJxExn7R/YcsbddaPKCBx+
	wfTZqZWEIsIz5ARtr2ZsKNRyMtML9vhTNG3Fshf4KIXS8wP4XgercAuS5XcrcJppNCQ6IJ3jslxmK
	vnxmN50bgmnx1PbdIDlkOG8my2ojcZqcpSgQ0a9KrH0zYvI0EeQfs5u4Ujf9P3pQ1ysubjj/06Q27
	uxR1RmDJDOgbUckFTC4zqR6Uar14z71Xn39+V0NPw1OWtjkXvZertSVNodZZeRIGfhJeXMw7BbnzW
	vinGaLVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pfook-005dH1-0s;
	Fri, 24 Mar 2023 21:19:22 +0000
Received: from ironeb3.johnshopkins.edu ([162.129.199.130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pfoof-005dGN-37
	for linux-nvme@lists.infradead.org;
	Fri, 24 Mar 2023 21:19:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=jhu.edu; i=@jhu.edu; q=dns/txt; s=jhuiron;
  t=1679692759; x=1711228759;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nX6rJWurVUVSdH1VktYvzoChsZ7unpdGhDE65pb4FLk=;
  b=4ZQIEqsb1Ff9K0xXSzpMsMYRGYZwAu8p93Albz19Ho6BjfVny/NTKDjx
   2jeUkptXf3W6ZCqoHzm+O6DJnOLlaykbyfeJiyER6BYWibp3llVA8bFd7
   QftiLjZUOg8nr39zg2DlLYqI9cUJMybkcc0AmgisbLwU40T1OdthgGw4h
   U=;
IronPort-SDR: Et3tX2tpgUocs8Se8JGTgwVCzLfqB4xIFbasDs0omncawJblPscNlgqhmKxf5Flj0PDF3X5WOp
 It4MWRfmcG8inPdfQzV1OjA5iwbTXenZs=
X-IPAS-Result: =?us-ascii?q?A2HpAABCEh5k/9+ErQpUBh0BAQEBCQESAQUFAYF7CAELA?=
 =?us-ascii?q?YItc4FchFOIH4dCAQEBAQEBBoFCA4VlhXOGQYllKoEsgSUDGD4GCQEBAQEBA?=
 =?us-ascii?q?QEBAQgBRAQBAQMEhH4ChTsmNAkOAQIEAQEBAQMCAwEBAQEBAQMBAQEFAQEBA?=
 =?us-ascii?q?QEBBgMBAQECgSZkaoFPgX8LAzENgjcpAXVNOwEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQUCgQhPAQEBAwQcIAEBNwEPAgEIGC4QIiUCB?=
 =?us-ascii?q?A6FLAMxshkIgTaBAYIIAQEGBAScTRhGAQmBawkJAYEILwGDS4N8doh3Qn2BE?=
 =?us-ascii?q?IEVgnowPoN8MAgQg1aCaZlJCoE0dYEgDoE9gQQCCQIRa4ESCGtcgR0EQQINZ?=
 =?us-ascii?q?AsOb4FLAoJPNwNEHUADRjo+ATUUIQaBL0IkBQMLFSpHBAg5Bho0EQIIDxIPB?=
 =?us-ascii?q?iZDDkIhFjQTBlwBHA0LDhEDUDSBEwQvgVwGASYknGdlLwwEJ4ECAoEvDR8Fj?=
 =?us-ascii?q?2SDRkGwN4QEhFuccINqjGaGaopfhxOXaqItK4UZAgQCBAUCFoFjghZyEzuCZ?=
 =?us-ascii?q?08BAgEBAQ0CAQEBAwECAQEBCQEBAQGOHQkZFYM7j3l1OwIHCwEBAwmIe4JIA?=
 =?us-ascii?q?QE?=
IronPort-PHdr: A9a23:j7AQNhQ9dV+/aZQ7BDISPW7E7tpsok+YAWYlg6HPa5pwe6iut67vI
 FbYra00ygOTAMOBt6wP0raI+4nbGkU+or+5+EgYd5JNUxJXwe43pCcHRPC/NEvgMfTxZDY7F
 skRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQviPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCS9bL9oM
 hm7ogTcusYLjYZtK6s61wfErGZPd+lKymxkIk6ekQzh7cmq5p5j9CpQu/Ml98FeVKjxYro1Q
 79FAjk4Km45/MLkuwXNQguJ/XscT34ZkgFUDAjf7RH1RYn+vy3nvedgwiaaPMn2TbcpWTS+6
 qpgVRHlhDsbOzM/7WrakdJ7gr5Frx29phx/24/Ub5+TNPpiZaPWYNcWSXNcUspNSyBNB4WxZ
 JYNAeUcJ+ZVt4nzqUUQoBWjGQmiCuDhyjFKiXDq0qM13P8sER3f3AE6A94CrGjYodTzOawPU
 e611q7IzTDbYv5K3Tfy9ofJfQonof6RQ71wa9fax1QvFwPYi1Wfs4/lPzSL1uQMr2iU8+pgX
 v+ohm48qwFxvyKvxsYvioTShIIVyk3E+T9nz4koON21UUh2asOrH5VMrS+VLZd2Qt88TGFyv
 iY30qAKtJC7ciUK1pgq2gPTZ+CEfoWM/h/uVvqdLzdmiX9keLyyhRW//Ey9xuD4SsW63kpHo
 jdEn9XQtH0AywHe58eBR/Bg/UmhwS6C2x3P5u1ePEw5l6TWJ4Q8zrM+iJYfq1rPEjH4lUnuk
 qObd1ko9+at5uj6frnpvZ6ROopuhQ3iPKkjn9GzDv4jPQULWmWX5+Wx2bv+9kPjWrpKlOc5k
 qzBvZDfIsQUu7C2DhdO0oYm9xa/FzCm0MkEnXUfLFJKZhaHj4/xNlzSPv32D/CxjU2xnTlow
 f7IMaftDJHPIHbEk7ntZ7lz5UBSxwYrzNBf4YxbCq0ZLf7uRkP9rsHUAx03PgCu3urqBstx2
 pkAVW6RDKKVKKbSvkWJ5uIrLemMfogVuDPlJvg+5/7ukGU5mV4efaSy35sXaG24Eu54LEqEf
 HrgmtEBHnwSsQokUOPqkEGCUSJUZ3uqQa4w/is7B56+DYffWoCth6SM0zqhEZ1TZ2BJFFaMH
 W3sd4qaXvcMbzidIst6nzwDTbiuVYkh1QqptA/n0bpoMvTb9jcWtJ3+yNd5/fHclRY39TBsF
 cSSz3mNT31onmMPXzI22KF/oUpgylaMyKR4heJYFdlN6P5SVgc6NIXcz/BhC9zoWwLBeNmJS
 Ey8Tdq7Hz4+VM8+z8UJY0ZnFNXxxizEigajBr4YkfSvCdQR9avYlyz9LsN8xnCA0KQkiFAia
 sxXOGu9gbNl/AWVGILC1U6ekvD5W74b2Xvk8GqTxGyCsVsQaw5tVKzGWm4eekDW5YDi5l7YT
 ryGC7Q6dAZN1JjReeNxdtT1gAAeF7/YM9PEbjf0wj/obf7A7r+PbY+/fWIb0W2dDUUfiAkc8
 D6AMhR2HSaupW/STVkMXVLiak/h669y/XW8SEJnwwSDdUY00b2z91YcjuCdTPVG2LUCtW8hp
 jx4EUz70cjRDo+CpxcncalBMrsA
IronPort-Data: A9a23:aTSZ4alhYEDegcXYd+JrqOHo5gxgJkRdPkR7XQ2eYbSJt1+Wr1Gzt
 xIZWW6GPP7bYmX1cosjO9m19h4FuMKAmNFnTldlrHs9Qi4T+ZvOCP2ndUqhZCn6wu8v7q5Ex
 55HNoSfdpBcolv0/ErF3m3J9CEkvU2wqz6V5NfsYkidfyc9IMsaoU8lyr5RbrJA24DjWFvW4
 4+q+aUzBXf8s9JKGjNEg068gE431BjCkGtwUosWPK0jUPf2zhH5PbpHTU2DByKQrrp8R4ZWc
 93+IISRpQs1yT92U4/4zeyrGqE9auW60QCm0hK6UkU56/RIjnRaPq0TbJLwZarL4tkgch8YJ
 Nhl7PSNpQkV0qLkqr4eDzt8DjpHO/cF+7TrYki+lfON9hiTG5fs660G4EAeFKY438FdIEVjs
 944DRFLQzy+7w606OvjDLAz3YJ6d5OtZtlE0p1j5Wix4fIOWpDeWaTJzd1YwXE9it0m8fP2P
 pBAMWs1PUmojxtnfVcaWbwQxPaUuFrcSSJqt2yyqLY3yj2GpOB2+P23WDbPQfSGTMBUk0Deo
 m/D+G39KhYCOdqEzief+X/qmePE2yj8Xeo6ELy+6+4vhkOWy0QXCQYKTh26p/ejg0KzUt4ZL
 FYbkhfCtoA/70OuUsbwT0Tp5STf+AEdXZxZH6s46BzLx6bJi+qEOlU5ovd6QIROnKcLqfYCj
 DdlRvvlWm5itqO7U3WY+uvGpD++I3FJf3QCeDUFTiMH48SlrY0u10qdQtFmGa+zr9v0BTCpn
 W/V9XBm2OhJgJ5Zzbi/8HDGnymo98rAQQMC7wnKWn6os1Fib4m/ao32tVXWtK4SLIuQQlSbk
 mIDnsySsLIHAZ2XzXDfW+UQBrCqz/SFLXvRjUM2R8st8DGk+niCe4FM4Wggexgwap5bJGXkO
 RaBtxlQ6ZlfOGqRQZV2O4/hWd43yaXAFMj+UqGGZ9VDVZF9aQub8Xw8fkWXxW3szhQhnKxja
 5eWdcGgUSQTBah9lWrkbsw99JgB5wQTg0HzYLG94jiaiOLMaHmQQLYDEV2PcuFgsvzb+V2Nr
 IsFOpvY0QhbXc3/fjLToNwaIl09JHQmAYz79p5MfemZLws4RGwsV63LzbU6d9A3lqhZjL2Yr
 HymVUpE11fv3CyCc17MdXFlLrrjG5R/sDQ2MTF1ZQSk3H0qYICO6qYDdsJpIuZ+rLQ8kKR5H
 6sfZsGNIvVTUTCWqT0SYK70oJFmaBn21xmFODCoYWZjcpNtL+ATFgQIoucyGPEyMxeK
IronPort-HdrOrdr: A9a23:CAG5uKFoD1XQWRTtpLqEc8eALOsnbusQ8zAXPiFKIiC9Hfb3qy
 nDppsmPHzP4gr5MUtI8exoU5PsfZqzz/JICPIqXIuKbU3doW61K4MnxZL6qgeQeRHWx6pmzK
 J9dKo7I8HxCFUSt7ed3CCIV+w4xcWB8uSOjePTpk0McShaL5t46ht/CEK8DEp7X2B9dPkEPa
 vZ3NNDuz2jPU42Q62Adxw4dtmGncTPiJXlJSQLHAEq8y6HiT/A0s+fLzGomi0GVi9Jw/Mc/X
 Pekwr/j5/T1M2G9g==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,288,1673931600"; 
   d="scan'208";a="12109295"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-MessageIPDirection: Outgoing
Received: from esgmtwex19-23.win.ad.jhu.edu (HELO ACHMOBILE.JHMI.EDU) ([10.173.132.223])
  by IronEB3.johnshopkins.edu with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 17:19:13 -0400
Received: from ESGMTWEX16-21.win.ad.jhu.edu (10.173.132.121) by
 ESGMTWEX19-23.win.ad.jhu.edu (10.173.132.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1118.26; Fri, 24 Mar 2023 17:19:12 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (128.220.36.251)
 by ESGMTWEX16-21.win.ad.jhu.edu (10.173.132.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 24 Mar 2023 17:19:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iINcUYFZnmburJcDQX1ZD1sLcDpMDbl2K5OYxKRPTAUs1zTFUkCzAhBDGZg7U/JvlhBolhWtBR839YC5wSBaynKSUKKxT6H/gko+TOq1NW1pDoX97iGEzc1yi4G1cBaKyEuidu/dAVeVOhHpmu3q0Hy4OEQJo6UO6XqMnyQZ5mvURCUrT/dhnW0TyQOYdA9OSnnnNwcJe/w6g8LiL15tmjMuCNNEauigEliYy/0jQ9HHBwYje83TZaVgRKDGMwkbStKArP8w/Nx4RMQSJ0jfrp47rvc+qiZmXFUVXMd0HtlNLuW/r39QuFWmrphY8HQBOx+46ivxzeM0rYRw0wPXaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O4CuAlHYVXot/Z1FlRrwAsjPmUHMhMyX8Ehm9+sGVAI=;
 b=obMC2sqATUccCDKVnJp5nfDOHIbACSPPnEEf8NeKSDTcPy79/Ia5PHKLRJH+GW9193M0QMXzj5i0Uvf1qcKPFOYEBhBT0VFXcEJNIA2VkstC3v3nbK0hduykgoaLlMQkbRs499wz9qENMpHwR5qWjVu8qKsDfOa17ZAx15FE45v+dOnvyzDeoHzT0ZUBIqjNXtFojQMxCyU6wP/KC6Ge1OqjP/P6ZPLsDBUfhZCil6PgATVzNAqCcjLFCVirxaa9R8YywOUA0ZhXVinKVtO4QLcYMvvolfu4s4sWCCpuhIHekzcuuvw+xgFN6GRdcrkRkrwEDIMndfFPnulDN3Px/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jhu.edu; dmarc=pass action=none header.from=jhu.edu; dkim=pass
 header.d=jhu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=livejohnshopkins.onmicrosoft.com;
 s=selector2-livejohnshopkins-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4CuAlHYVXot/Z1FlRrwAsjPmUHMhMyX8Ehm9+sGVAI=;
 b=FMLOXypp+Ez1NHR2VyX9k2xeKusNsZ03vDx6sp81ixTtS0iokf0rMnI1FZaS/CDljej2Lvv7z9QEWFHy/FqwNhoW9ezcnTOdCQX0K+EwzaAndpyO/i39KFWes02Vr+CVUaTDymQ1BhLd47n04Gw6I2+i0iCCKLI1/gDv2C30Dv0=
Received: from BY5PR01MB6100.prod.exchangelabs.com (2603:10b6:a03:1ab::26) by
 SN6PR0102MB3485.prod.exchangelabs.com (2603:10b6:805:f::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.36; Fri, 24 Mar 2023 21:19:09 +0000
Received: from BY5PR01MB6100.prod.exchangelabs.com
 ([fe80::b47d:4bdd:536:2dd1]) by BY5PR01MB6100.prod.exchangelabs.com
 ([fe80::b47d:4bdd:536:2dd1%4]) with mapi id 15.20.6222.008; Fri, 24 Mar 2023
 21:19:09 +0000
From: Alexander Shumakovitch <shurik@jhu.edu>
To: Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: Read speed for a PCIe NVMe SSD is ridiculously slow on a
 multi-socket machine.
Thread-Topic: Read speed for a PCIe NVMe SSD is ridiculously slow on a
 multi-socket machine.
Thread-Index: AQHZXh2z2NkXUzjTO0KKexGZO2Rp268JnT0AgADTEIA=
Date: Fri, 24 Mar 2023 21:19:09 +0000
Message-ID: <ZB4Ty1L8Xa/qMQiV@hornet>
References: <ZB1JgJ2DxyTMVUHB@hornet>
 <e2df2f18-aaf9-89d5-6fed-aa1fb663f69c@opensource.wdc.com>
In-Reply-To: <e2df2f18-aaf9-89d5-6fed-aa1fb663f69c@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jhu.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR01MB6100:EE_|SN6PR0102MB3485:EE_
x-ms-office365-filtering-correlation-id: 8c65778d-d474-49b7-39fb-08db2cad6834
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iAc5pFnFtUdn+z4qHH6s2i7KimqPTo1xhmt8DHCIszC0ftxo16mGVz7+YZZHtM2TnO3d8YsHoss6ClpRNnSBub6BzasscsK4z8vpL7Bt5qluUUsOrKrgKtFbPOeZDvgNgsvslKCRvF+1/Wq+f8ZAg0O2C7bHMr3zFv/duowMpw4JBFlecAXHG5vWl92jf/7HflzYTwXQudETTx5s5z7lu3vi4jXDSrC2GnJf8OaqEaE3Wd443s14OORi+wxQJygqT8bfivCNr2LvdFnH1Wne5FEC28lOTc0lmBHvaRJcISNVdZEvuvp0H0ILmtebhz9E9RVDNygQp0XkZ43AiLTCYrzaJyZI5dS9X+FtObqzfhPB1R9g0VAdxNxahApyqBs0lSARPejQEayJjMqbzwWqYZtBZX8uvX9vkIO8I8IjhQJLHm13wAfeYktmP1xRwYhOqX1f8GJFMbK3t+3ZOUcCWXO0XPuUvu9w21ZISFKZCKqiGDX0DkTchztDvyK7rKAod4ydhoIWL1Xurlaz6drzjrh5QsgUwleCD2Et7hYxoQWS0d7pWx9165n9RJoq9a+beSUnUjXMg64Dh0ubMpLKfDnrm8TD+1gHUJ7KitjziCWTpU5x1/ORIYZG7Dmuumh3oak8XH5aHS4ExbndlJohNXbEpZPShvj4pNhxG8nVCj36hhv1Qqx8o9WrP6saBcPCzOUUF0MTwaTMpWf8RoLQ+A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR01MB6100.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(366004)(376002)(39860400002)(346002)(136003)(396003)(451199021)(6486002)(8676002)(478600001)(6512007)(4326008)(26005)(8936002)(6506007)(316002)(66476007)(186003)(786003)(33716001)(41320700001)(71200400001)(75432002)(9686003)(64756008)(86362001)(66556008)(66946007)(66446008)(2906002)(38100700002)(76116006)(6916009)(41300700001)(5660300002)(83380400001)(122000001)(38070700005)(53546011)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?koi8-r?Q?CViigiOp5++T3TyH+LNS1ujjMomnfHdv8rnwCVQebefYWHQdGF+Flwj+hipu9U?=
 =?koi8-r?Q?3FncB/18kGiMsPjQMRav0tZY26TZeoxjdZWgmYYhnxo+EpQhUELtZ+q0tZHftK?=
 =?koi8-r?Q?gvZCDiwpXNVQ+0Zwf9a6CZMkBwSocS6qjbwDcYNLOS2KWxGtcB86y6Nu6a06r4?=
 =?koi8-r?Q?3/+4Oi4vxzxcvpdPgGnQEH380uT0MxkUxvk3T01R5I3x9wGKT1r5o/4Dl1pewR?=
 =?koi8-r?Q?4ogQsZj3VtXb+IVwKULfsTBaUwTo/iPSw2wovt7OjWmrax0JPAXnM9nFAJcC3D?=
 =?koi8-r?Q?ttBiEldvRIgRClJzhy/nLFmFg1OatKI1Z51EQdPFv2DOxIPlRvJSZp/jaq97bN?=
 =?koi8-r?Q?gjnK08qrwF38iwJ7L+z6gQ7PXP1Ihc8j6Qyulo3hJzQbBBAcFBgNFvAA2kq6Zi?=
 =?koi8-r?Q?0kdeBz6R3N0G+Gym6AEbB8sDTUFma1YQkzUlhbaCmXzkR+isKdCd3Ivj/TkSth?=
 =?koi8-r?Q?Me0VYNiM6VBwzh1RFrKApx+CLyr2K7K+ISdQYs8bbD7RQOKT1MzQNWjbb+oq7p?=
 =?koi8-r?Q?L+Tz3BodFBcL/Mv2gFEmkUxPE77jPrECXGFw25cUdnq7vGzGvJ6hpJ0WTh3rn0?=
 =?koi8-r?Q?XW2UoxljamcDbJUr9HcFjmRnjtoM3Haxfh3CpXpPtzVDZjApBhZLoKhomrcoOw?=
 =?koi8-r?Q?0cPpyeLEVP0dH6vThMtkN/+HHx7fMDcuNnDPscSI+zjj6zZlTxsLUPZ/Q4vcwW?=
 =?koi8-r?Q?v+e7HKa1IIwkaItwSIxu+698SADW7PB4Ey9wvBzNtE0PGRhAr7Rkgz4OuQNhG5?=
 =?koi8-r?Q?DwVpVvMOOip7i9g8o8DkxhmbY/zXuY7aJkoi9NlNBYg8tgA8syeKjK7s2KAI8x?=
 =?koi8-r?Q?y5mSv0P5qtw20Ai5+p5tG7oO4XKxYKFDBfc3cx3RdL8MSGc1ua0Fivq05AiEEI?=
 =?koi8-r?Q?NgMALONbyTaV6+/OImxprTF+viy2ZJ00x8YFpMtF37JBDryf4NuufWPmg+TWWW?=
 =?koi8-r?Q?equ22Lg6RiBspdpFcGSiO0foFK16YgbpY+P3ocfh3KsZX59jTbpv5Mbwf7170m?=
 =?koi8-r?Q?s7zsT0cwJZFI7Lhv4mJrptlwRPW9ohw+Sak3h4UZrrTa+0pJ/w3MnQeG/AKwC+?=
 =?koi8-r?Q?9T9Flsue6W4ymIIQo1fqGe7CXSica0OZXOKA8JKjDL6i+3YYQSMtZq/0AEo3Q3?=
 =?koi8-r?Q?FrYvqtAFegajJyrPgD5ID5tmRTxGR45608UeqhxHcCHntuMWZ0bimm4vyfeISR?=
 =?koi8-r?Q?Heedq2+9/H1P8m5BoT6UX2I7ozGdFIJ4gwfuSXE+QaSQdiCbzCl5rSbYSuGTGi?=
 =?koi8-r?Q?y5JLxSqcutAKWNL/odkjgn4CkG8X7ayeUcS9dRw1AGK1BPvug6RV1KC2eI29lA?=
 =?koi8-r?Q?o/zPPHclyjB2x5cHoWCuQdsPF9G46b+Okoo1L9mdLwKbP8kPRPVD25hIXcqtX/?=
 =?koi8-r?Q?bpqdOMvV7wCQCxyqDZSrBYX/H7zHNPRoZg+9NCnZmuydT3okC3hjFhivHwcUPT?=
 =?koi8-r?Q?wRHzYLZV1fV91y6UVR8TlfjXMlSlNY+UU585Y/0DulxL3nUjzig23/+LYONSn3?=
 =?koi8-r?Q?Q/3L6XrOyluvq/zbANp4mtmEKsius5CoymOTiGHTIjoGhQbt1g?=
Content-Type: text/plain; charset="koi8-r"
Content-ID: <987B64AC4B05D6438D35F9983151875B@prod.exchangelabs.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR01MB6100.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c65778d-d474-49b7-39fb-08db2cad6834
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2023 21:19:09.2230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9fa4f438-b1e6-473b-803f-86f8aedf0dec
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aYEw99zFlGhSE6l+1/Ed1B9cRCDmSHPlwjRlatVRQNefghjV0DwhOTLt3Srq0rfn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR0102MB3485
X-OriginatorOrg: jhu.edu
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230324_141918_490658_284DBF27 
X-CRM114-Status: GOOD (  13.82  )
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

Hi Damien,

Thanks a lot for your thoughtful reply. The main reason why I used hdparm
and dd to benchmark the performance is because they are included with every
live distro. I didn't want to install an OS before confirming that hardware
works as expected.

Back to the main topic, it didn't occur to me that the --direct option can
have such a profound impact on reading speeds, but it does. With this
option enabled, most of the discrepancies in reading speeds from different
nodes disappear. The same happens when using dd with "iflag=3Ddirect". This
should imply that the issue is with the access time to the kernel's read
cache, correct? On the other hand, MLC shows completely reasonable latency
and bandwidth numbers between the nodes, see below.

So what could be the culprit and in which direction should I continue
digging? If hdparm and dd have issues with accessing the read cache, then
so will every other read-intensive program. Could this happen because of
the lack of the (correct) NUMA affinity for certain IRQs? I understand that
this question might not be NVMe-specific anymore, but would be grateful for
any pointer.

Thank you,

  --- Alex.

# ./mlc --bandwidth_matrix
Intel(R) Memory Latency Checker - v3.10
Command line parameters: --bandwidth_matrix

Using buffer size of 100.000MiB/thread for reads and an additional 100.000M=
iB/thread for writes
Measuring Memory Bandwidths between nodes within system
Bandwidths are in MB/sec (1 MB/sec =3D 1,000,000 Bytes/sec)
Using all the threads from each core if Hyper-threading is enabled
Using Read-only traffic type
                Numa node
Numa node            0       1       2       3
       0        25328.8  4131.8  4013.0  4541.0
       1         4180.3 24696.3  4501.2  3996.3
       2         4017.7  4535.5 25746.4  4105.7
       3         4488.1  4024.0  4157.0 25467.7

# ./mlc --latency_matrix
Intel(R) Memory Latency Checker - v3.10
Command line parameters: --latency_matrix

Using buffer size of 200.000MiB
Measuring idle latencies for sequential access (in ns)...
                Numa node
Numa node            0       1       2       3
       0          71.7   245.9   257.5   239.5
       1         156.4    71.8   238.3   256.3
       2         250.6   237.9    71.8   245.1
       3         238.4   252.5   237.9    71.9


On Fri, Mar 24, 2023 at 05:43:42PM +0900, Damien Le Moal wrote:
>=20
> On 3/24/23 15:56, Alexander Shumakovitch wrote:
> > [ please copy me on your replies since I'm not subscribed to this list =
]
> >
> > Hello all,
> >
> > I have an oldish quad socket server (Stratos S400-X44E by Quanta, 512GB=
 RAM,
> > 4 x Xeon E5-4620) that I'm trying to upgrade with an NVMe Samsung 970 E=
VO
> > Plus SSD, connected via an adapter card to a PCIe slot, which is wired =
to
> > CPU #0 directly and supports PCIe 3.0 speeds. For some reason, the read=
ing
> > speed from this SSD differs by a factor of 10 (ten!), depending on whic=
h
> > physical CPU hdparm or dd is run on:
> >
> >     # hdparm -t /dev/nvme0n1
>=20
> It is very unusual to use hdparm, a tool designed mainly for ATA devices,=
 to
> benchmark an nvme device. At the very least, if you really want to measur=
e the
> drive performance, you should add the --direct option (see man hdparm).
>=20
> But a better way to test would be to use fio with io_uring or libaio IO e=
ngine
> doing multi-job & high QD --direct=3D1 IOs. That will give you the maximu=
m
> performance of your device. Then remove the --direct=3D1 option to do buf=
fered
> IOs, which will expose potential issues with your system memory bandwidth=
.
> =

