Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4A3DC61DC4
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Aug 2026 18:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/obGtHXal1IANk3/PIALr0lCRNbTZ89xgWJ3aY1PmwI=; b=sitDXDmGoFybDJEArQwgVx64iX
	uUejmQzDMc1jDw+eco56qpTUFragGDEw/ktRTs/2fESzR7UfLauCJXJMlFsl3d+sIie68jfdNc0Hv
	ncbQi4yvjnJKEBcCK17FYT6QNFCxpCoMgHIGeNtFdf6aK8ZZx4V5A8HGdU5+m9y95sGZgKjK+73d/
	PaS5LB8KwTLFHipYuEuGYMpRmOnYi4Mxxq7KrUdCd4MxGW5AraNR/wRB/cJweyUTfs4Fo3iInt6Hg
	JJNL6H3C0+iyykaJNH7NZ+ehMjljrRj4FO90uZap3s94cduc6JnTG1zSJCMR8x/ARrSBbWCRJuz3g
	vEeJtrGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzfD2-00000004eIU-45W0;
	Thu, 27 Aug 2026 18:52:20 +0000
Received: from esa.hc6817-7.iphmx.com ([216.71.152.95])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzfCw-00000004eHm-0Ynu
	for linux-nvme@lists.infradead.org;
	Thu, 27 Aug 2026 18:52:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1787856734; x=1819392734;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JtBX/aBUN09AWsxwadoJAg/+zMrcD1hLnk0HfZm4hJc=;
  b=BCEYsemSfKpGfJXGwcaamNNRtJV6dw5sqKN3fCJfm+K+IlwYrWrz7jeN
   sQm0JHFSJ6g2ahaaOkNZz48lUdrf0A5N1IurMWriRHQgCbhlbgXYgcY7L
   f+yOlekAtYu2s2vISCfuGs5BsTdLr+KVmOK5QRTKL1T0Rfp0HfqGvToG7
   8IH6ibZFFG68mPGCWglCM/n7mFFm1wV/SLNJuCdHPVM9RUhfo1vlyR9fG
   OfpXnlTE6JIVSvlDFht05wrPVL6lahTtN/sjleqjnQB6IfMQQGxtQ3P87
   4E+Q8FHu5Q03Rwzi9hL80nkWG26LgxzC7bPGvLPO1Mao5vM6uo0nc5Xmz
   g==;
X-CSE-ConnectionGUID: JA8pCxuRSwiz/kKpKuHNmA==
X-CSE-MsgGUID: gup5AhNTTo+047IfErFfXA==
X-IronPort-RemoteIP: 52.101.43.127
X-IronPort-MID: 29001589
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
Received: from mail-westusazon11022127.outbound.protection.outlook.com (HELO SJ2PR03CU001.outbound.protection.outlook.com) ([52.101.43.127])
  by ob1.hc6817-7.iphmx.com with ESMTP; 27 Aug 2026 11:52:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xGI5cT3+bfmVUQidhrkk0pQip++Oyu27vBuVC9iDvo3yuioD49Lw0wSeXaosufGG8SMjRVT7P3Mfg3GCOV0lhI8+eSEbbCBeY5xK210cZ1UEaTBBqpWbpETN/5NjjmZI/jyZIe81M9ZYhAOljjL54AmV5rzEcD4E0zIFDfnZwjHeQasVNkHttwa26ZNP3fxslPHfqIBiKZizSsU0u8ZLsZNxH8AIq5a6BJUQpp2ZViavgebu7dPhA4/6uRXXGVvB0oyjZL+ZsrmT4R7Oy89EvYd6wVKVuRwSIz9b2oLxfr3VlmKMR+zks4jTKBW+p/yvqMLjehaATfghV8EMr+D67w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/obGtHXal1IANk3/PIALr0lCRNbTZ89xgWJ3aY1PmwI=;
 b=E1uUYEIMuroTZXianzg6pZ9JfSyGbFr+s/889XH1Nwr/au93Up6Lshd0fFFioiRD7GCsel5M+seHeNEVk8pFGhrcjfH4XSPWRRHEy+tTThcG98XSRbFUOhbyQeE2jbUFXHU+C/roMl7WR9pf7mRBGxcgZoleBPJqdNwigLml70HnUWX6xkPoKehPNiDtfLVqCk97UoaSZaVrzBpKhTljbHthQWx1FJJdeq7z+lavRMtL4JNm9CDDNCGWG87i/GIfo02/ItthtoAi9omb3oSNYqx6MqQzm5F3wdeLBg7ncbl+tzEf5cdqN2rwRxjkcPRPot3gxWcW8xUaL16W0lh+rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from DS4PR16MB6924.namprd16.prod.outlook.com (2603:10b6:8:31f::17)
 by SJ0PR16MB4721.namprd16.prod.outlook.com (2603:10b6:a03:429::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 18:52:08 +0000
Received: from DS4PR16MB6924.namprd16.prod.outlook.com
 ([fe80::977c:faf6:2b68:f082]) by DS4PR16MB6924.namprd16.prod.outlook.com
 ([fe80::977c:faf6:2b68:f082%3]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 18:52:08 +0000
From: Alexey Bogoslavsky <Alexey.Bogoslavsky@sandisk.com>
To: Ferran Duarri <ferran.duarri@me.com>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
	<sagi@grimberg.me>, Yehuda Hahn <Yehuda.Hahn@sandisk.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] nvme: lower default APST max latency to 25ms
Thread-Topic: [PATCH] nvme: lower default APST max latency to 25ms
Thread-Index: AQHyoQ3ATROJkKaMw9FUI4dwULo0cbaHZgBw
Date: Thu, 27 Aug 2026 18:52:08 +0000
Message-ID: <DS4PR16MB692456B5425BE0974054C45692AD2@DS4PR16MB6924.namprd16.prod.outlook.com>
References: <20260820195415.275608-1-ferran.duarri@me.com>
In-Reply-To: <20260820195415.275608-1-ferran.duarri@me.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PR16MB6924:EE_|SJ0PR16MB4721:EE_
x-ms-office365-filtering-correlation-id: a7625416-4df0-4225-0aa4-08df046c4b97
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|10067099003|6133799003|5023799004|11063799006|56012099006|55112099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: 6/JvAkNXqiPkpbQfJcXsSfEeaZpt7Lz3h4My5Sh0S7nAU3qq2gDgvZIYes9K38JCG0UemmnduBxSgDdCcw44CNcOV3gDZ1qS+jgAXndA+n0CdcSiBbGljcSgVI7Fh9sbIq0U0LiTACSAy8u3bmmsW0ryzneDBeNDGSuLxy5VjtzNvSL8FyuJR4uhwQFTNMRobvayePfqlvA9M1PtAHivCTo9gOWKevfQ6NHa9R7W/d1vERdFOtnj+shcTY+3/oKZHeZvRKwuH9GZ40cjcJJTm3+nSs9wkHHC0Ec2vZnrhZrpCNDFGXeMEYKIJGgCg8DFfedyFiR3FAsnJIDj4bYm6cQDxFF8tEjX4KjazgaoBzj+KD7tQvudemuLo5HNZl40NxyiNjDMwkW3oRYZvA5pYwkx4SLKcsVr4Kk5sQWvPjsbboAE70qtNNlKxM3BF7Wcd+7Fmbu9NwchuEEBSkQI+Ys1K1BMBjWhTieFK6AOBsua1jIol3z9iGNIwyA6yMNVFAyIQikCvXXIKAiQNnLGaXcNxL80s2UE4NY1jyMSmLwz1Ra+Qb3mwDtjLQ0+tcPk25DV3OWfX+q3cAcsmLts2a/7PH7Jx+06yDWWg1wmawRdM/QzFjEs3Ui/h35jVhkI7KuuxhtVGuEDHhFeuDwUoInZxQKU3JPsThB7NhgL7RN7G9AIhvwuaDTHNlDnpLCxPiWz/dStYt/aF9LC7yZkAFNPiQD3h4bD9qdRaMt8i1k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR16MB6924.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(6133799003)(5023799004)(11063799006)(56012099006)(55112099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xEqF01PNGA0qUtE6jQrboTim6TQkrVV5yJPSY5apc4JjcMsT5lMxMM7UoSwA?=
 =?us-ascii?Q?tEOVKnIrnB+hhChULeimZLXXUIvY7hYB28XDDpw3dUCg6b1kWpkjWY8EpRnc?=
 =?us-ascii?Q?IxYOhLYMZV6/AB6qqrq8OZthm0SrO6UfiK6qft3Gw+SFdK6R7pLMntG1J6jQ?=
 =?us-ascii?Q?YrvfIGLrFAIHmJw8whrE/7l3Fy8vTmzsca0EPHVAppEeAJpgDCy9/vJ/90UF?=
 =?us-ascii?Q?RttLuymAEAwF6tMeisLSr8swSw/57weVpymzuGvaCJm14nYQLLypZLfMMBaa?=
 =?us-ascii?Q?nwvOyqvfmkr+maAePjv0xq+dB9FVzV3yd/bQEsxamz/WmlVQFxLAO7X9DzY7?=
 =?us-ascii?Q?tURkUUWA5Itoe8TcBi5Ob6zzPgJqsjQSoweeabqmMRKwCuWuXJ8UgJD/M7RO?=
 =?us-ascii?Q?YaNGMasmwC1df8fwaJwqcMVL1LD/gJQ8ae1fCBVT1p6hhdalPqcVv0Sz2N/l?=
 =?us-ascii?Q?WPqd0hpAmcfJ1mNPMrbr3OFZuZ2yTozQWnql6czbIVVdwON0tb4nH2QNsGZq?=
 =?us-ascii?Q?bxC2ZKVGhO0JHqSZOTSh+Xosjm8+ifCRJtERAiLDNDknI7Vpjlt7MO5Q8X6b?=
 =?us-ascii?Q?kbGuTPAjGp+btplgiAyHK9WHuLast5czV0QNGZoLdiyiKxJiTnKT4dKymhmp?=
 =?us-ascii?Q?FvNzAGZKxPIHGMmlEt2pCpgI2BDeJ5ddcf4P+fVgtPk4tnT68+Bh3ku5G+wx?=
 =?us-ascii?Q?sAmZkIRKYoBhhdAtpIaEtGAT9qV2vXaDHpug272STgBsQUPFA14SeHh32Flz?=
 =?us-ascii?Q?tisF2HQNLTC7mBTsJWBlgVSEonZozxgYvXgfT8O1wMG5KxRgfF8odymWfH4G?=
 =?us-ascii?Q?v06uPDIZwXCgnik0kGJkVbSQc6Y5+7bOQFukN9j//tN27Hk5aTb4v/auOUnd?=
 =?us-ascii?Q?he8Ts/OkVkuliSNH5Fh169PSkFnzasPL4V4RT2WHEdEOGmZiZFEHEEWK6aZI?=
 =?us-ascii?Q?42ZygdZ9o6jlmCT6fpcqfiGf9Ejo0I5Lqc29MvBySalLI/xI6ePo2ktRV7AR?=
 =?us-ascii?Q?lE0D1sD77xhO4yisBybuSS5FoWF3yroKxslEk5lZZckU++FaUpGRmvLYXqgw?=
 =?us-ascii?Q?IQ4GECvPviH2c+s6jF++qfFkZE8gu5VyTgrdCppPRpLAXZ7zQidGUG1ZwGPw?=
 =?us-ascii?Q?NEs9fHv6xl4Vq5WQJHrs59XkMYQbh+v/VMIvdNADmyhxjvdHaYucOU8ADYiy?=
 =?us-ascii?Q?6K9Vw6+qeiKJ5j0cnvN46zmZK33t5C0sVDy/uU1kTf5nekatTHsy7r6DNtLD?=
 =?us-ascii?Q?7Z+jL0ZFk/Wh4I6JaanxhACen0ywQkySaC9NxUeegAu+1J3XnGNHPxGaBgjR?=
 =?us-ascii?Q?xc8U6dhCynIxotbVtQn7RiClbXIeAlqslIiGpGVv3YLiMg0S+kz4s22N+YQu?=
 =?us-ascii?Q?oVYoAXGiZSUgohOwlGlk3+QzUPWZBvRoC+gvi9HuI1jo4H7zm355w9WdwzQJ?=
 =?us-ascii?Q?+UPywxNgEjmqwCZjkiBYHxqLH8PT87uoJ7cnsZ515YkEGDDyY5y2ECkmMtBT?=
 =?us-ascii?Q?kjCOsP1DGuNrZgEHLZ0JJTgeZJUh8UnXLGA+lg6nK3fIfGk8cYdRB1+dF2c2?=
 =?us-ascii?Q?q3rfRBQuX1n5ixCWMYOvcFziot/VzDoDLF5I8OgIusgm3y+UV/Dv5xwqQ16g?=
 =?us-ascii?Q?3ovejXm5TOlmxV5azADl9OVxtjCV4DkedbUb6V5oTFwLqUKb9JaoiaihLDuY?=
 =?us-ascii?Q?T+hXeYoKMhKdGLH0hgxiDdURUWALGKW6s6Ga+LlPhieMBR+9o1Pshj3Yh8uo?=
 =?us-ascii?Q?8Wx+xN+DU9JLCuWJcGfwBDiQ0bd62EM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: g74KWIvCEPA40EMIHp2hxZOTeaYSRmVTXCo9Pveo0U/lKCJcNB9gXsQmc6UZB+DF8gWSTsODe+wr5CtbaJeXt7GEl+OPitkqJjIJNWRPQvp7Txqw1Sm5eiIkuPQG/aGnRHUr9orLSdeQEZMt9EJf2VqWXBGQRzXqBWKTgNPgLHuH4K61UlvV2hzchCEtR28q+Hf0PPTmHqOsX11sFJP4o8vFfw0CQ5A+UiJayh/pS3tEJkwZfhF8yN7sLBEf/HgMEEBXs1Kg1cf3X1zaBNEDt+MVnZLkihCJDr6pEv37G2fHw3L8BYKAP/tSuG8QSqwGagogZmtqlplvd/rmCQTWTA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1c+Yq3VfoC/FzPH7JEJZU/FX8nsPpEalVyrbO7yCo1mtvFMo8y3IzW7CQdgnxR/9Zyk6DRCdapXsuZ6aLpovNQyV81inldSaKdO0u/uvIkWp9OxwXjkMTUJLF0i6lv4JYismI0hdYeWsXD9U8pM6OEeVOd9VfwFPevFv7XlwqofoNRcml55oDnz/5Fh4dlPm71iDYMVSGiAj89iAJ3VJ2HBdxrBoliaBX7snyj2KUih6voNYXVy4unN5hpKte9ez5gIGhqBBtUpUKsGBjeg+3HRlv7joz8b95vNjQbSHQoaJxVCjCEVZ1r7ZLVd9ZpyiwINkrNKSVOANXcru4eeSKDLJ8+Gi2F100QRGh0EirZkxNhANsc64nPQ7/3app/Lsvw3yZBTTWLizFuPv+0Mme78q6fMxw8JyRFgvBERvPcCZt7UiN/P0qwThMR/L4BIIVoS2rSBSnzZENsDogr8y/0xBdqB+zXdhqxGGtCS+bNXULBoNbtjmCc6fQERISbxRQsi7Rw/a6xszWvwe2l5wK+b50srIv0VZ6JKVhPwdq1iAvN1kJY35fmlBy9yI1oZIyqkWwfsr6j0BwbA28Zo9LV1KmLoye9rOu+PUjZdk3d5/6jW08ed6QI8tgjX461DdYv+s48b/N3RdcG0vbj9/lQ==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PR16MB6924.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7625416-4df0-4225-0aa4-08df046c4b97
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2026 18:52:08.0973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tjxVxdYH987L+FPY6/gdTDE8bDKxmaatmJn6vRVXEKucZEdgPs6mFDTg/MVy+l57DQdFhiXM8578+tsgp8f0EKbAX9GGTjnwstLLaz3d+is=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR16MB4721
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260827_115216_411501_9B5CB1BD 
X-CRM114-Status: GOOD (  34.67  )
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

On Thu, Aug 20, 2026 at 09:54:14PM +0200, Ferran Duarri wrote:
> That one bound decides how deep a device may sleep. On a device that
> advertises a non-operational state an order of magnitude slower than the
> next one up, the 100ms default silently selects the slow one, and the
> first read after an idle period pays that wake in full. It shows up as a
> stall rather than as reduced throughput, being a one-shot cost on a cold
> access rather than a steady-state penalty. The workload that prompted
> this is staging large model weights from NVMe, where a cold mmap fault
> on a multi-gigabyte checkpoint is exactly that access.

> Measured on a Samsung SSD 990 EVO Plus 4TB (fw 2B2QKXG7), which
> advertises two non-operational states:

>  ps 3   exit  4.6ms   0.0800W
>  ps 4   exit 43.0ms   0.0070W

> At 100000 the APST table targets ps 4; at 25000 it targets ps 3. Cold
> 4KiB O_DIRECT reads after an idle period, 60 trials per setting, the two
> settings interleaved trial by trial:

                     p50      p90      p99      max
>  100000 (ps 4)     3.3ms   33.0ms   33.5ms   33.5ms
>  25000  (ps 3)     3.2ms    3.6ms    3.7ms    4.2ms
>  warm, no idle     0.2ms    0.3ms    1.7ms    3.6ms

> Observed worst case falls from 33.5ms to 4.2ms. Both states measured 78%
> of their advertised exit latency, which is the cross-check that the two
> figures measure the same thing at two magnitudes.

> The p50 at 100000 needs reading carefully: roughly five trials in six did
> not finish descending to ps 4 inside the idle window and were sampled at
> ps 3 depth, which pulls that row's median down to the 25000 row's value.
> The ps 4 column therefore rests on the remaining sixth, where it was
> tightly reproducible, 32.9ms to 33.5ms. That effect can only understate
> the cost of the current default, never overstate it.

> 25ms is not derived from this device. It is a bound on latency an
> interactive reader notices; any value between 4.6ms and 43ms behaves
> identically here. The device is an existence proof that the 100ms
> default admits a state far slower than the next available one, not the
> source of the constant. On a device whose deepest non-operational state
> exits well under 25ms this changes nothing, which is correct for a bound.

> The cost is idle power. Excluding ps 4 leaves ps 3 as the deepest state
> the device reaches autonomously, 0.0800W rather than 0.0070W, so roughly
> 73mW more on an idle drive.

As you noted, the advertised latency is not necessarily the real
latency. But you may not have taken into account why the latencies
are advertised the way they are. In client devices, the EXLAT+ENLAT
values are derived from Microsoft guidelines available here:
https://learn.microsoft.com/en-us/windows-hardware/design/
component-guidelines/power-management-for-storage-hardware-devices-nvme
To get to a situation in Windows where PS3 is used most of the time,
the PS4 latency is sometimes advertised as much higher than in reality.
Also, transitional energy can be high and is not measurable using just
the power state values (transitional energy in worst case is PS0 power
for the entire EXLAT, but in reality it's generally lower).

I would recommend Linux keep aligning with the Windows values since
those are the ones client devices optimize for. Selecting 25ms as the
default will ensure that PS4 is never used in devices that are aligned
with Windows, which will cost more power even though it will improve
responsiveness. Some OEMs will find it unacceptable, as was the case
before I introduced the current APST algorithm back in 2021.

I believe that whenever latency is that important in the workload,
users should explicitly disable power management (as one would do on
Windows by switching to performance mode), but this shouldn't be the
default.

> This changes only the compiled-in default. default_ps_max_latency_us is
> consumed once per controller in nvme_add_ctrl(), so it applies from the
> kernel command line as nvme_core.default_ps_max_latency_us=3D. A running
> controller instead follows its per-device PM QOS value
> (pm_qos_latency_tolerance_us), which is how the two settings above were
> compared without a reboot. Any system preferring deeper idle states can
> restore the old behaviour without a rebuild.

> Signed-off-by: Ferran Duarri <ferran.duarri@me.com>
> ---
>  drivers/nvme/host/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index c3032d6ad6b1..e3038b880e8b 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -66,7 +66,7 @@ static u8 nvme_max_retries =3D 5;
>  module_param_named(max_retries, nvme_max_retries, byte, 0644);
>  MODULE_PARM_DESC(max_retries, "max number of retries a command may have"=
);

> -static unsigned long default_ps_max_latency_us =3D 100000;
> +static unsigned long default_ps_max_latency_us =3D 25000;
>  module_param(default_ps_max_latency_us, ulong, 0644);
> MODULE_PARM_DESC(default_ps_max_latency_us,
>                "max power saving latency for new devices; use PM QOS to c=
hange per device");

