Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE740C369C2
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Apr 2025 18:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eDEkK3tqStPemEWhZEMD+Wf5A8XE4p1ukzxj4lcPU18=; b=hkkclkQ+Yl35Ecr5HpuuHKHdoX
	e0lNdEQysrM7zuRvd09EVTgQlUDqlIV7YA8FOEl9WlN0eu+uilr98yXlS8rLHiu6sivTDTlN+m7DK
	4rUGjvefzkej527JB6KMVDYkLukxrZWVvC7W1tdGEFsHi0JfRPvzsogdqpdLju+a4cA0hmf8TkjNm
	8sSHX3EXH2WmLcSzPIosTCeJq5fGSE+mmpGepgnWjMRuNp7KV2gkTYai/wMIbhm28+XZYMpsRcG1U
	8cN6IcoHIDJTydHKRvUfC5JAK0XuNFockuxmHdouHdFOhkEy/3BMmJIa9Pvg7B4AunhF/mB6WP0n7
	3815ggVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8NNM-00000000TuA-1WEy;
	Fri, 25 Apr 2025 18:02:12 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8Miv-00000000N7Z-22LV
	for linux-nvme@lists.infradead.org;
	Fri, 25 Apr 2025 17:20:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1745601625; x=1777137625;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eDEkK3tqStPemEWhZEMD+Wf5A8XE4p1ukzxj4lcPU18=;
  b=MSWd4fWeehnZBtV00ov2SyfqenaqIsJ+RFUF5ZgROeVgnIp090gB+stx
   +8G3g41+S1Xu8hDdD+Mx6iVftphOhllRKklVjqE6MLnJoSDR2xKYBvILz
   5l6++BnsNLgkvJWUvdxurzM/NrRcdjY7h3Ts16Y9HpxUIG87nUXufupwc
   yPWrNRAw0Aki9+hDAtQ1NY3MpUVsZ0vXLgXoF7KUni/432+Ealz7ArpOp
   vvZNewI4KCbpzGPz8kqxydj2UKD1kwpkP/JzSUR3+HFWdpYNWiar1KS/G
   rcdmeGOZJ6NwpYRNwVYu4eRfA+xkUdxwtFltHTQo9t4jrX3OapngcscLW
   Q==;
X-CSE-ConnectionGUID: tRZOS99KRbKuEILdAML6Tw==
X-CSE-MsgGUID: fjkcm5b1SVCyHHuWcpchmw==
X-IronPort-AV: E=Sophos;i="6.15,238,1739808000"; 
   d="scan'208";a="83362031"
Received: from mail-southcentralusazlp17011024.outbound.protection.outlook.com (HELO SA9PR02CU001.outbound.protection.outlook.com) ([40.93.14.24])
  by ob1.hgst.iphmx.com with ESMTP; 26 Apr 2025 01:20:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=je4dp2sT47YK6PNF74TsCg7erTm029Ri+plIWta6fyQuxNWH5tdZE+6EO1Exva88a2IT8otk6sFH/YvLNfn87+Dbn5cwEMNnla3DqFSFSXVBIkFk3Wv7GIhpXDE0wlfrE2cKMShnaRlfFZxWs+0SA8w0SH5EKn0EcR+C94PKAipEYkW+T3tK5EUwT2/wRJvneS+5nZqMvZ1isSDZ55nuopgC/hxFqdRg4tarh/CZ6k0IbI4jlLiQChEKjh5Y2Lg++To64PiCY435HaTK8Bs/1zWUmjAigOPJE/nVrcpcRKRY5WO1p+k0Wn+wGJmXuAhuMaSLBagC4Qin2htcHLoECA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eDEkK3tqStPemEWhZEMD+Wf5A8XE4p1ukzxj4lcPU18=;
 b=dcEz09H1ZrVcj+DIaRBxW1E+dzX/ouzTEfy3FfMxB4pkaj7dPY1cGYHm4l5tvJF6XItT3UGB7DLEdRxQwNr/hXa+vaU4z3Jnv9miap+S+1zW1vHilwcyf8a3nr8jA3Tuz9k52Ni6Wrb2l4hNOMvwXRpfT8Uc/0TDagKmGo+B9aui75sxcaeLaa1wiFo4K12EZTZfH54jf72mrgqFoSc0aXQAfJKd5IfkBlyNMFX4fq9QgP7dyuTSB6yj/yb8reb1gUb/+wjLBQ4vN97k+xTZ4AbiUOVQIaiDSLzxKOy4F78ykILrWpIkBYjMD18MfMHWucxmK77yMPxep7e9jZ0NdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eDEkK3tqStPemEWhZEMD+Wf5A8XE4p1ukzxj4lcPU18=;
 b=Xy31E9pTc9p+pBJdx1W6gvbD/CRkYoNEajLIiKEWWtjYdKGDnjfnal6CZ1PMW3id7BbZdjHKcMGikkzn4bgHSEbPPKXmN6O4V07cRSN+wPTJs9ZW+qx1+hqJsPkOkGfEw//u0UItA+XyE1qTUuAcKDbFK7mYtdeCZcvqmahtK10=
Received: from BY5PR04MB6849.namprd04.prod.outlook.com (2603:10b6:a03:228::17)
 by BN8PR04MB6306.namprd04.prod.outlook.com (2603:10b6:408:d6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.28; Fri, 25 Apr
 2025 17:20:20 +0000
Received: from BY5PR04MB6849.namprd04.prod.outlook.com
 ([fe80::b2a6:2bbf:ed0a:7320]) by BY5PR04MB6849.namprd04.prod.outlook.com
 ([fe80::b2a6:2bbf:ed0a:7320%6]) with mapi id 15.20.8678.027; Fri, 25 Apr 2025
 17:20:19 +0000
From: Kamaljit Singh <Kamaljit.Singh1@wdc.com>
To: hch <hch@lst.de>, Waiman Long <llong@redhat.com>
CC: hch <hch@lst.de>, "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"kbusch@kernel.org" <kbusch@kernel.org>, "sagi@grimberg.me"
	<sagi@grimberg.me>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: cgroup null pointer dereference
Thread-Topic: cgroup null pointer dereference
Thread-Index: AQHbs867Ho4DUg/FyECYHcuhUwZmwbOxxQUAgAHKuW2AAAyjAIAABKmAgAAFwNmAANWVAIAAAtUAgAAB3wCAAAMfAIAAAOcAgAAedWo=
Date: Fri, 25 Apr 2025 17:20:19 +0000
Message-ID: <BY5PR04MB68493CECDBCFCB26237CD5AABC842@BY5PR04MB6849.namprd04.prod.outlook.com>
References: <BY5PR04MB68495E9E8A46CA9614D62669BCBB2@BY5PR04MB6849.namprd04.prod.outlook.com>
 <a5eac08e-bdb4-4aa2-bb46-aa89b6eb1871@redhat.com>
 <BY5PR04MB684951591DE83E6FD0CBD364BC842@BY5PR04MB6849.namprd04.prod.outlook.com>
 <623427dc-b555-4e38-a064-c20c26bb2a21@redhat.com>
 <642a7d6f-9d8b-4204-bc81-4d8e0179715d@redhat.com>
 <BY5PR04MB68493FB61BF28B5268815381BC842@BY5PR04MB6849.namprd04.prod.outlook.com>
 <20250425145450.GA12664@lst.de>
 <3fef1073-3a7e-45ab-8448-a144d5fb6a73@redhat.com>
 <20250425151140.GA14859@lst.de>
 <8a85a074-d4fe-404e-9438-131963a51051@redhat.com>
 <20250425152604.GA15999@lst.de>
In-Reply-To: <20250425152604.GA15999@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR04MB6849:EE_|BN8PR04MB6306:EE_
x-ms-office365-filtering-correlation-id: 18ff1dcd-ee01-4b1f-67f9-08dd841d7426
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Na/cl1Q5do0Og2KLWtH58ZACkh3BShBoAlzUlnQg5TNg9Zd/wgM56YiqaK?=
 =?iso-8859-1?Q?Rsc0zaG0nQZ0m7GlgmzobsLlc5PP1rV6A7wAEAULX3IOs1ktC4lXD2xrAI?=
 =?iso-8859-1?Q?WUDyDYPXI+vYilYJOwu9BScleyu9ZAkSpLjzKFK0qQ73kUkJYIN8DEAuGo?=
 =?iso-8859-1?Q?hnEDgEr6rXvV+ey1F0J3bSV8+4Lzz2Lx/ejoFVjXurBiQ3ZVqJrdkmUCT5?=
 =?iso-8859-1?Q?SV/r2K2kQKKcIETz/ZFSor8/rcrcF+wxZdWVLzIjGagRflX9vsA4/1+0QF?=
 =?iso-8859-1?Q?EfcFxYQxYhppdPM/39H2RyLhMfAuZZIC9zfSqALxrqLIdbrTWS8oV2U0lM?=
 =?iso-8859-1?Q?Vz5UYzuYdPiozsQpcO/MolVtPb4UUG+2y8La79Ki0QSRpK0BH2sX0Q2CtK?=
 =?iso-8859-1?Q?f9wzGoBbK3/PEHWRrGLjGHVLz1A+stVJwm/Eizt8agCHWChm+iJE/PEdbA?=
 =?iso-8859-1?Q?9tVMJQ6W8DvMdLdlw9AZUryZWVkUz8ZKJlpDGsszmWAeFkb+N/lmS9sZz8?=
 =?iso-8859-1?Q?6TSXLAl7rDuTYcJeSabyH1XiP+84KWuriTlXvu/3dFuANLCtnEfPYzjl/W?=
 =?iso-8859-1?Q?k4DFy3v/y1Z4lgQ4lNP2QuTEpMKkGMwh0B/w+TsC171HrlS0d9NwTAQ0Vd?=
 =?iso-8859-1?Q?Ykr53aaZm8MyBpiPoXbt7OJVdWTGlnb+aDsQqFc4jdlYLApyMrzJhHaXMg?=
 =?iso-8859-1?Q?x0SvLxOmFKbC9ULCC/B5UnP39SbGIJjzD3K7Xxw8tpM8ihWh57MLXDx8mS?=
 =?iso-8859-1?Q?NPdbXvMERSOnMhwdkkWsMqGH1N7JDO+fogxOmYqY6ZBhLIwXW0o8XdDRwY?=
 =?iso-8859-1?Q?ytIuN1oRlqEYRdLBUhQ0ssgNPBCGibF/u17Ws+5xmGsZgzacH40bJAiQyf?=
 =?iso-8859-1?Q?N/bG3cpLE1pPmihxjI2Uzqr5A5hKYWqisTt9oqnC4EjTry7W/cRP8mQKj3?=
 =?iso-8859-1?Q?BtRF9c1Rx+t+FE0rOKeJ/tNoU2+Ti0pdg2wE0K5jUcefArA50M91Gw3K35?=
 =?iso-8859-1?Q?L4YScGN9Rfn/MAGWE1zYlAifuO/YQqFhdYBhg8cyvmsmNUa6y5Cv1BtT4K?=
 =?iso-8859-1?Q?c3wpGPgqMGOJsQDQw3/t+tRRALjizcysS1ecYM2xiE75byf/kZzmhFoU5C?=
 =?iso-8859-1?Q?wQOb4grCoh5YOYlPgvKLa/CHzqsw0IQAmyAIzNiCUe4tjt9YtYfQVa0TYK?=
 =?iso-8859-1?Q?oBtuD26ZcA4bPehW0NS4GDs+5EF0R3/IhAhUXs2d3FZ4bXUWwO/BAEUQrv?=
 =?iso-8859-1?Q?q1rpuET/50VOIZ9VTZrO8eJAdxKtYFlwXf9+X9HO7ferb6Hgpf0tB+m94R?=
 =?iso-8859-1?Q?qilnln3tX/QYOL+PgRQjOYCrutp/M81obfAmSnIFDWgr4M1uVnYDXfrw8U?=
 =?iso-8859-1?Q?nImLjY/5dPjhEALvaxSrFlrzwvC2dlUhc4QbKMrc/Xk0nEPkAbdLFCdV9R?=
 =?iso-8859-1?Q?JAWvQ6uuvgNcOHffsiMtcxGHnKwB+aIjakSgPusl/GDXSMxcVY095ZrcaE?=
 =?iso-8859-1?Q?NBSTo5LIoG+puB5RWxGDwKdvtaM2jHeD7P0jZ/EpFutw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6849.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?1l2EZcxArcgQSiIMex4thZ2nzuP72Cvl6N3nuPd2lTK3j5N4GS2vfriDf+?=
 =?iso-8859-1?Q?erUNHkRSu1BweUo+u9G8/Af3tAHsQL9BLugNRsgGWLr7JusXmYtJcUjQ4z?=
 =?iso-8859-1?Q?RlQlm5Vn2+W0AcOpjPll2QU6M1zDdU1YRKLnTVJTKYaaiC+OTVERF10Zdx?=
 =?iso-8859-1?Q?A/oxsEIAMv6HPq8iBxzBHuzuVeKbZ9ny9vfspAy/PT2IaNDZ5mdcVrHs8q?=
 =?iso-8859-1?Q?xI2hs7Nmlx1wvOCtt/yBEsujI148ZqWg6a9H8Z5uE3J4n5f50amGa/fF41?=
 =?iso-8859-1?Q?D5LL3uBfDhvsXt7RTwZqAlpX7sYOjwy2CDfokHIXwyoJMYwfpHHpgSm0YL?=
 =?iso-8859-1?Q?gVC7gCOPu27PRHtEe82xMGxoplCqjxgd8hXQaKdv6oliAjdDlmgonWugrl?=
 =?iso-8859-1?Q?q5hWOS5nSTfCTmin8Kbb4yc2SMrSu2naagBqm5aaJqbLpwNnG9wiPYrOwv?=
 =?iso-8859-1?Q?dtAoKtVe8iN1JYlosCRDRbgRcX3TlKYYJaMSY5neSuxpeWgv6FbeYkZLIs?=
 =?iso-8859-1?Q?ywmFiaPEnoDkjHPvtqmcxPvTClGjKLcJm4G4UqVJ/KrFlAkgphuawi2WOI?=
 =?iso-8859-1?Q?Jiua2/DV5P4scfYCZmwlUkoJ/O75jCo8BoxTGubMDYKgGEbAu6rwUSgG9O?=
 =?iso-8859-1?Q?6aySJjceJwDSOpFtK+ypydOM4QS2X3Zgh08rPBIe9/slSKUKP0LoD+DjA0?=
 =?iso-8859-1?Q?f5fMjMCOuanBCN5F4RzuHyYoJG+U8huEtZTvfTXMENMo8kW/J4x5D6U/+1?=
 =?iso-8859-1?Q?AZeJf8OmD9sEF+synuqxb0V9+J7U3gRBJ7kmMJpC/zKTvUnuV13659AM0k?=
 =?iso-8859-1?Q?VERHw+YYJwM5NWhF15/neAV1UIlvt00s+OdlNJkkJ7+0HkMe30mCWk+8yk?=
 =?iso-8859-1?Q?d33q5ooLGHgQRuYnyB2yasj2OhTqdjB6Gke6d23MsQYvMo99TN2Nfm39hc?=
 =?iso-8859-1?Q?EkTiXHRVp9cB72WCW60RnAQ4rlzPYVxnG7j0UVLubu0yMEhXEiitrVnnlh?=
 =?iso-8859-1?Q?uUPkERatt93UZs1FjJMc8Ptkztrd+ZP1zH8KQCZ72LFsdwYnBFFTS3yTgy?=
 =?iso-8859-1?Q?O1pUu59N0sNCsPtk5YT50nq4vZPneQ1gQyKTLUp/jh3x/s/XPCa2RdoskP?=
 =?iso-8859-1?Q?Fq0FHSxBApvrFMMP6D/VU18BjN30C0keFdlZp0LuEixk9arvzCbskA1U54?=
 =?iso-8859-1?Q?gVRclI7x4aEdar4BV0+SecRZy83uk99gb+qDgKLY+G69pLHLKm+v639WrY?=
 =?iso-8859-1?Q?5p1BDG0lU9WUiZeaRY1l+n7JylxrUxUDd6KyMB3SFoScsK5xDxQ3DJ1rRU?=
 =?iso-8859-1?Q?veac9n89OYsfKjEKsi14eMPr56mdufAVJwajE+SMegQUaXnpABK15s0xO7?=
 =?iso-8859-1?Q?04p9glSTB6h7e/0+SwLLGE+LXFKYeJysZ8jij4ScQaP5hXneH3/MCH2KgW?=
 =?iso-8859-1?Q?GI4s5ZFlEju7hDAKhCBZakknCN0iqKCIFk+ohSAoJGNYQLnrcoJu26s2Hz?=
 =?iso-8859-1?Q?ojCzBtLF+qqWVj9RQCsbAV0nzmUNDQ0KIeBuzDqM4WyuUTP7ix8n2i8lnj?=
 =?iso-8859-1?Q?UbR6F7VUJL1ljbgk3kyndlFJQJBQ8HQ8mPR+AYF7CsTWMmB0N9gx59kBD/?=
 =?iso-8859-1?Q?gtfJhHVU5RwSWdODJhUj67HYwPlFT6pDpX?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Spdg7TnDjTOn9CRTH1EofdtHnBXemf8jH6d4f6fZY1zv/80vyTUZcaIljAVzfFB7V//2SoAEjzykUR+CG3ncYilgjnP8mYeefF0i/A2fepScr/sb9IhwwE33nT8PSbU95rGywb6w1UXMGYL6JLVvto1RZsV8mG8WX2RrV+fyXhy6ZGYQus539ooZ8fStXjMBwe1NOan3ZluwkHwrTVBwU4rnI7BJuekH1f0asV3hBNlLc+juM7szVs9U1os+FLrd9VH+hJjZK167eiMAtjsUbZvgTX4vLyS7zMq9Ul3ik3t4IanPmcSEtEwzej2+CqnOfdCBfE+Seoi1/zpY0gMFwQ9nTONKpOAFBVn2P40wFE36g7tvf42l68DwXgvogNu2HNiX306K/YO9vcbM04kTp/3a7EhsqXnHw1LbK6VuqJqKxZYCM/pQ49K+7ubDciGTqryQy6squmPwOu+v9Q5Ob09QQ5CxRNOFCCoT6zBirBdOP1VDfKdKNWqsnbVxsCHVQcgULCUN6SUEtbSxyEVuZ9Ezs/VN3Sp1X3OcQG358sm6a16ejWLnt/0zMOaQt/J1Ourp3OGFey91VFI8Nc/ZFwWdrTw56TnfW5al9aAjHF12MTkuOAB8VcSYooK8vA4W
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6849.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18ff1dcd-ee01-4b1f-67f9-08dd841d7426
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2025 17:20:19.3526
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xkxjEal4PYoAoOO4+GVFoVHzRVfIbAqLJRJXAv7KWwdQQUWyuwuCNf6sz8io1GGjwSIHmTwkPeELdwRUnds2Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6306
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250425_102025_613729_1925CD2F 
X-CRM114-Status: UNSURE (   9.12  )
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

Christoph,=0A=
=0A=
>On Fri, Apr 25, 2025 at 11:22:50AM -0400, Waiman Long wrote:=0A=
>> The nvme-6.15-2025-04-10 branch used by Kmaljit includes some v6.15=0A=
>> commits like the cgroup commit 093c8812de2d3 ("cgroup: rstat:=0A=
>> Cleanup flushing functions and locking") but not its fix commit=0A=
>> 7d6c63c31914 ("cgroup: rstat: call cgroup_rstat_updated_list with=0A=
>> cgroup_rstat_lock"). That can cause system crash in some cases. That=0A=
>> problem will be resolved if nvme is rebased on top of v6.15-rc1 or=0A=
>> later as the fix commit will be included.=0A=
>=0A=
>The nvme branches are always rebased on top of the current relevant block=
=0A=
>branches, i.e. block-6.15 in thise case.=A0 Everything else would create=
=0A=
>merge issues.=0A=
Please ignore my request. =0A=
=0A=
I'll pull in from the mainline. Thanks Damien!=

