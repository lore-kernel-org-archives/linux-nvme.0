Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86D9DC4167B
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Dec 2023 05:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Hq1D3dPOKFVBkwWzrnxoG341psekA9TX4Bl21LrULo4=; b=DJ8ApOxlw+HiDwCxOgBbfziRbb
	oFhZZxDu1PwPHbJuShlDxBCF2fU+oyvMQhUNsis/FHL9MABeP+nlMcn333Sx18GLjvuMzfvfz3NJO
	7in2adxVsfJ8misZkAJENNohBtkM01+UurqqrNYha1VprRN6lax9lDkLrAkiwhllZIsrX98qkFqAK
	qanTeAlx9INlXPR6e54ZwMlDEfwkMhtWl+/EMkGJA+7Jzvmz8l1cMq7gDgF5iLaYhzQuO5lstYGic
	Mc9GpuQ85SDczzTbNSnLd/ZBgg1tZqBBaG0D3zi7KuAQdanNbjYOQj7QRA9pbMtPRgzHF3As0hHWR
	qwNtvm5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rB7LL-00BwIn-1n;
	Thu, 07 Dec 2023 05:54:39 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rB7LI-00BwIP-0O
	for linux-nvme@lists.infradead.org;
	Thu, 07 Dec 2023 05:54:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1701928476; x=1733464476;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Hq1D3dPOKFVBkwWzrnxoG341psekA9TX4Bl21LrULo4=;
  b=W+ClPtlyG/rIlmgHnHGzeD7fHmSvKY7+OVnFXH+LnqyE5/hOn11uLQby
   wy8jEDLWwX39+B+hfLh0cyOwLqtTETM9sOi+STjGDuEQFk8RuflSQex/K
   /atdGwueylUr4FFatAUhlWCK0cCod7avkCL389vnOaWqo+ZzT6AeWSyJ2
   6Ypjk9HQGXuFFO4sY7kjwlfXpPYicDpCEuaFqGYIT+jzxr4s+Ubpm50BH
   jLga7C4LrRKiFwoe60nMTzgdWfzQzEvlEWoRslvW1MyqRaJDlpWBD9GeS
   0ahLFTgFli/zZcXNEnt99bpdFyvgYijvTFR+lvvo39wwrqBfQgIobqJIZ
   w==;
X-CSE-ConnectionGUID: 4aLYvFAiQMqz1ZysLcwCaA==
X-CSE-MsgGUID: oRffrW4rTPW/0g583eDClA==
X-IronPort-AV: E=Sophos;i="6.04,256,1695657600"; 
   d="scan'208";a="4259501"
Received: from mail-dm6nam04lp2040.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.40])
  by ob1.hgst.iphmx.com with ESMTP; 07 Dec 2023 13:54:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E7WefOEpTNjstSdLifiDjL+kZeNszZCmZ20tdav2/x2GSjEnGg+R5ii0Ja2Y6kudI8eIEILd7V4LlVsO+aVzJv2KJ/LYOgthSUfxskr2GN88nSG6usAFnR2N7jmX4ALR8sMGEOthDwpJIcnkS+WXYiFMaiJquvzxtGgQ2vZ4aIVeH98Pqyfdr2OAExBO2FDPetGCE5SIQb7Axn0JV7jJya7NTSXXnxmLGZPmPOmvs74KRCgcMvyyvlxvarQnBZ2B/cEswrOxK7sxa5qNwTWkqIRV5UsQw5BcyLflXUWD/rAC/0AUdqnut1qn1dA57Kkg7CAnVjrMiekX8dLvZ2FgQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hq1D3dPOKFVBkwWzrnxoG341psekA9TX4Bl21LrULo4=;
 b=TkWcNp2jzBfNEfXHJraczxH+iu8a1u+Mmtos/5aC/DqFLJMT6OjN/PbsjDx9DIwsUY1tX9iLoQ9KNeOvqvMfBB6B7/Blet7USEFCYiZZp/r5Lnix2DuWkwLNBfTY8zQDE4UX/5A9wCTQALdLiRxKmUTLeGF0vB/oH7LyiGtMxxjtK4MWZnbE5TG1QWYWW03cIgnlnyuYGcz5ZcVsNQ3OQpYl+3TO9mmv4/P6WPDicq/TuyPWJCYQ4oCGOsXP3Sklko+zL6bT/CEdCKpTOmfymhSv8+wpmIDQIoWj8PiMWTRawDxHT9YJAz3PoXBExRlf2GYubUIFp9u7T25WUQMjRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hq1D3dPOKFVBkwWzrnxoG341psekA9TX4Bl21LrULo4=;
 b=vsni2f4m76W4UhMwmnDlpwuG9h21EkGOy/2UVwsGmrFfpGVAWB5znM90zdrAEANhEwdvNYJf3H0XbAbeSJ7Hz3c5JfP9/fv+16ICFmFNMBohx7VhqHRE2/f+h3bOsVbw1GJ4C37OHbuXKHhVd1dISXlVuJaQQnJhsr2BTO39Xz4=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CYYPR04MB8877.namprd04.prod.outlook.com (2603:10b6:930:c7::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.25; Thu, 7 Dec 2023 05:54:25 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::81a9:5f87:e955:16b4]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::81a9:5f87:e955:16b4%3]) with mapi id 15.20.7068.025; Thu, 7 Dec 2023
 05:54:25 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>
CC: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>, Keith
 Busch <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 1/2] nvmet-rdma: avoid circular locking dependency on
 install_queue()
Thread-Topic: [PATCH 1/2] nvmet-rdma: avoid circular locking dependency on
 install_queue()
Thread-Index: AQHaDZeWcQKmKfNo7E6DQ3n3jNSZV7BoQsCAgAAIYoCAAAd7AIAALFSAgAAjZwCAGrLTgIAVxn4AgAAY9gCAAAJRAIAACX4AgAAETICABEO/AA==
Date: Thu, 7 Dec 2023 05:54:25 +0000
Message-ID: <6nmywu5e44fkypykg27lctjmmd6ottw4t53cxgt2rmdlqgvem2@4vi5v4pbmgsv>
References: <69b6f873-f8a1-482b-a739-b47da6e98cec@suse.de>
 <20231103091952.GA18200@lst.de>
 <e09869f2-193b-4f03-a12f-2a7f6c24d537@suse.de> <20231103140514.GA2395@lst.de>
 <d5ef550d-91da-4135-959d-e10f153514a0@grimberg.me>
 <52bd0ef3-b91e-492e-8117-41a290b6cfe6@grimberg.me>
 <c261fe62-e8e6-4470-b9e2-3047fd4c3d99@suse.de>
 <9ca33803-e2ca-4550-8d6e-1e64219fb3d9@grimberg.me>
 <e3fa3584-47e3-4712-a2ce-7fc59e603898@suse.de>
 <8cb5e071-385a-4332-af97-cef4ddfb4720@grimberg.me>
In-Reply-To: <8cb5e071-385a-4332-af97-cef4ddfb4720@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CYYPR04MB8877:EE_
x-ms-office365-filtering-correlation-id: efc13dc0-8f62-4f8c-e19f-08dbf6e8f7df
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LBUIo3e+xvezbPHqR0tsXKQ5aA85clAw1n1eXA3zBqLPwzEUxR9mGI4mxg0S4acNC1vNTAeLXRNu238hnsI0qeda5lhgMFIUUzOvuwd4/tnj+hfQvwlh6yMBJZvjobRYZ0UJfHuZsunLmrrB28YYW5Akj9dbpk2a7+HfBosmPSujRzEzul6wwpmNMurSQhYOrrbm1cukXB7OynfWLJto94+T/InWVAnPY3nCU3CpJ495nlak5G+AbbHTgMBf21LYEQ53XAY0yKy+daeKetT2pl058gAsmkKvDJCvIKxuN2MtFBuBLl7dT59K6j0Nh/9rwUfKba0xou8/+IS16boBxlRggTefpEsxTUnEzysVJ+FpbMDG+p01nxiPIm8W/x2j7gLefDuTCxgbPOw+w56bzDXRJGxDAEIE9f2NSwBI7PcQ077tXN1PoOzEbKrcHre9TOWje+jfKDn/lG1rNdMCtzo6tkLdGlrXNwfu9F+aO0nDMYnJrBxf6vY/2kjh9QdUBni2yDDoEfucSVSXyGPUwXTZpWT8fqSFaAgOfyORwxb8trFOzqw37IK8dG5vvRfor0D0NTsb+EG8AuEaLRuyuawydwcTTln3K1HY0zY1sL/IJeAxQzPfn1inpnbOsCWy/0I2nSELHI3SCIaTf1QmsGe72cd2Q2/Grf+BQbZkY5JU3pZmhNdO4/N4hRjFxw1c
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(39860400002)(346002)(396003)(136003)(376002)(230273577357003)(230922051799003)(230173577357003)(451199024)(1800799012)(64100799003)(186009)(33716001)(82960400001)(5660300002)(122000001)(38070700009)(2906002)(71200400001)(6512007)(83380400001)(38100700002)(53546011)(9686003)(26005)(6506007)(478600001)(76116006)(66556008)(91956017)(966005)(6486002)(41300700001)(66476007)(66946007)(64756008)(4326008)(8676002)(54906003)(86362001)(8936002)(44832011)(6916009)(66446008)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?7mJe0P+DNAgSuEgnaVx7xWej2HvGlqBHQiIddVjapRUAMqisoeattnaj9C?=
 =?iso-8859-1?Q?OktZPMeQEWfAdqfgs1IEAxut2v+PiRxQ8CDP6/Pxb7wV4R+iQOCeV2CHTB?=
 =?iso-8859-1?Q?zm7BahxLJ+VGHlDXhWXEjD184ZCIPugSndIXc9h2AJOVfRHMKYOgjMP0tD?=
 =?iso-8859-1?Q?FAdV6G2MSMioDGH6Xkq5CMWtm9nQ6JRHEldX7MU03GMIJLOBvUg6zeD3fb?=
 =?iso-8859-1?Q?lrCqsZhtDBgJJi7j+QXK3Idtbqk3ZUI/IORqLXwjQVvAhEm7UcBuMe4cV3?=
 =?iso-8859-1?Q?aZdlC5cVtMqMGQodC0si7iirTk8y9MKzdNMl35tgikluinXc1+RgzmLmIF?=
 =?iso-8859-1?Q?gWs/BniHFGogaJ+EIoAzdY0TAZCzi4XVDzbhSbmfc9ZWrEthInxeMeDf6X?=
 =?iso-8859-1?Q?uCv6uz9JT7fP54h7wwZz31UFj35MUeX0Uj7Yp8AmIrh1c7Rlx7p7v80H+j?=
 =?iso-8859-1?Q?NWl+E7s4uFdGyUld1ESU1m1Zbxc0dZReLwcFPj19NXkt6+ZOPUoCW0Erub?=
 =?iso-8859-1?Q?sC2UGdBvwiVhQtLfM85gEQhYHkdjbZFWFZ8pTVYgFwLhdS5NS5TCqbGIoy?=
 =?iso-8859-1?Q?fcP5gU7k5RIwJfR2zEHcAuxEMBfRFwx21LNwyY4PTtZD8/2PXi9/Yan2+u?=
 =?iso-8859-1?Q?rsxJuhSg1tSX0JJoPkoXIeBjgEP9fO2WSICO2uxsOspfP24E06XA4UwkKA?=
 =?iso-8859-1?Q?NqtRKKR3szrDIZipfKjBP0kenCKvuDtzAGedWl2GdJ494zGz7GKiXRd1TY?=
 =?iso-8859-1?Q?4r5SYNCo5Pqpluu86K7/kEIy0FWpNI6U3LcDZC6LUqhTj5HkyViHE5kYqr?=
 =?iso-8859-1?Q?8ei/2OYGXoINDmcrr+kla/iAwcA1kMxwwBLc+eTBg9f9uYA3mr2s9xu26o?=
 =?iso-8859-1?Q?bLszpajT3sbva/GcKyRYvactGNzAOnovEd3fiaN/UeVPR/DnmCddp1YK1H?=
 =?iso-8859-1?Q?Z8UjKlA8cXJFE9oIjbW2n6s3HZLi/f3Mf8/2i1B58I3no+nQzpiQH1a5ZI?=
 =?iso-8859-1?Q?x2yho+16Fp6JbGzPFFZMerQbrJHy9o7mv8uzjYYJ0gm2ssa2vKjtm/NF6d?=
 =?iso-8859-1?Q?qunGzI6qBmsCEQaGgISd7l2amgWtyjcQh9X9i5TugKqmRVIbyOK8zstG30?=
 =?iso-8859-1?Q?ay/hZkiXOov52vXtlDLfNlyTBpK60siL9y4p1ORqfJvG6vFAUNEi/vrxDd?=
 =?iso-8859-1?Q?obi/kiR/kogF4o1sgyFIWCaXWrcakuLdjr3pTiEI9bKrkp6UFcFM++sfge?=
 =?iso-8859-1?Q?S8cNzf1+P1W+CQYRW/l4oFMUkqzRkm5Rq5KiG/cAoA5emzSDf7+N7HEdlP?=
 =?iso-8859-1?Q?THT6zJOLBpOTHOj7uwjGO1oa+vUPtFAuV1QVjr++q2kVAuGRO41WVIUX2H?=
 =?iso-8859-1?Q?O7NX0UKoLi/ofHBS2IEEAg7FC1JomOpLho5oSVYt31HMOubZKa/dCSS6zM?=
 =?iso-8859-1?Q?NHfpghV2VOGkPpgqQOBWXmab6QhxpwXMjEihjsVRajexZFjaeaCsmNzD5S?=
 =?iso-8859-1?Q?EVSVHXPO0sMcBpBLWMQbNah3H1So0zz22XTx+LIc4lPvpkwOuKkDvur38v?=
 =?iso-8859-1?Q?ZI9xbZhccMnhOd+nLJ7QhrDlivRVXbQJx1ZpTj0X+elPJZezYPPtSMynqH?=
 =?iso-8859-1?Q?XcKZySmwZTAK1l/CLUR/buVZn0UngHnJhruiio70utfj9H7LdGsarf5vNh?=
 =?iso-8859-1?Q?h8QIQx39FLcad284/OA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <1578C327DAC35A4ABF2B5820331DA500@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pJhjOQ2v46la7hBKLspXuKTEUq/1R5lpZYw339Drt4/T7sUqSd61LcF9j3u4GwoO/4A1DTab5jsYqeSaYNWr130OhxTF2r6wnQaAm77uKSd4c7H60e6bgHXFrdU6oiEb8xH019LDxFR2ixcqyIX14y6G9HYVQqMBqwI/Q/elpTEq+Ca5gd0N4oev9BEOHjLq8pS/VKPBRENGogTljuX9UK9LRd1XP+QehhiQa896ekE4bTODbztoOF+DAdjVQx0NHcoIJ1pAfXPJcLjBONH4q4HTwaMPF7fZspABP10zgOiEPtS4RjJ9dyNcxUWQ1kMFqaV8X313IJ29TSj47lMspGjCq/91eylm4o1KibU97eDLdhM62j+4P1JzSEWjqnXfBWhIjNMT0LKQtx6qJM7KSrLWNMkk902umNXUAjZRwWwbBS7hrVcItv4IHs+zrGFQ1SPnDFBehXfcFlWD3pBvOcg5bXI760QTGYoIdjcWEC0up7dmPHX3A5taaNgw+HbiNEmfUBKDO2o7DSCueCirMX/nsFPXD7y6MwVfKio77buta2BwRMXPiRyJBjOv1rydstm3dBm8BBozOwRi9N+v94gNDUC35geL3LVouMP3VJduFeHDxVzgeK5PShwJ7r4S311KQjQQhenxA74RqryRvRR7DGSabUcgDyFTipcBLwa7B+d+08spQOy2l7iarh8toKNeZF/Bii/4+gmQuBKaAaaGxr504qSAfp/bGzmon14mTST0qA8lLyf9ZwCdRf9t+bqdXbs357+TQ62qmav1cv1btf+eQQtb3IsxUMfEXcClWHbtfcya85DIs55aH1BaIYXM5j8hg4gU+Fh03a7zmVrZuqgHlEvu9d5hfR6gPADL1TUTTaXk+XGeyrcMspq/odNWbFsXA2EWZnKVPH45rg==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efc13dc0-8f62-4f8c-e19f-08dbf6e8f7df
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2023 05:54:25.4025
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nPHSZVy1siGo6PS7u8ZjjdBeQkRCmUr/67sh6hiVljV+HBKM7cNkLzlDerB7kCRqhxWstp+UlroKlcV+Yxz9lAVMRRI6BMmrNSLialpVPSo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR04MB8877
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231206_215436_304620_D507C25C 
X-CRM114-Status: GOOD (  47.24  )
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

On Dec 04, 2023 / 14:46, Sagi Grimberg wrote:
>=20
>=20
> On 12/4/23 14:31, Hannes Reinecke wrote:
> > On 12/4/23 12:57, Sagi Grimberg wrote:
> > >=20
> > >=20
> > > On 12/4/23 13:49, Hannes Reinecke wrote:
> > > > On 12/4/23 11:19, Sagi Grimberg wrote:
> > > > >=20
> > > > >=20
> > > > > On 11/20/23 15:48, Sagi Grimberg wrote:
> > > > > >=20
> > > > > > > > According to 777dc82395de ("nvmet-rdma: occasionally flush =
ongoing
> > > > > > > > controller teardown") this is just for reducing
> > > > > > > > the memory footprint.
> > > > > > > > Wonder if we need to bother, and whether it
> > > > > > > > won't be better to remove
> > > > > > > > the whole thing entirely.
> > > > > > >=20
> > > > > > > Well, Sagi added it, so I'll let him chime in on the usefulne=
ss.
> > > > > >=20
> > > > > > While I don't like having nvmet arbitrarily replying busy and i=
nstead
> > > > > > have lockdep simply just accept that its not a deadlock
> > > > > > here, but we can
> > > > > > simply just sidetrack it as proposed I guess.
> > > > > >=20
> > > > > > But Hannes, this is on the other extreme.. Now every
> > > > > > connect that nvmet
> > > > > > gets, if there is even a single queue that is disconnecting (gl=
obal
> > > > > > scope), then the host is denied. Lets give it a sane backlog.
> > > > > > We use rdma_listen backlog of 128, so maybe stick with this mag=
ic
> > > > > > number... This way we are busy only if more than 128
> > > > > > queues are tearing
> > > > > > down to prevent the memory footprint from exploding, and
> > > > > > hopefully it is
> > > > > > rare enough that the normal host does not see an arbitrary busy
> > > > > > rejection.
> > > > > >=20
> > > > > > Same comment for nvmet-tcp.
> > > > >=20
> > > > > Hey Hannes, anything happened with this one?
> > > > >=20
> > > > > Overall I think that the approach is fine, but I do think
> > > > > that we need a backlog for it.
> > > >=20
> > > > Hmm. The main issue here is the call to 'flush_workqueue()',
> > > > which triggers the circular lock warning. So a ratelimit would
> > > > only help
> > > > us so much; the real issue is to get rid of the flush_workqueue()
> > > > thingie.
> > > >=20
> > > > What I can to is to add this:
> > > >=20
> > > > diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> > > > index 4cc27856aa8f..72bcc54701a0 100644
> > > > --- a/drivers/nvme/target/tcp.c
> > > > +++ b/drivers/nvme/target/tcp.c
> > > > @@ -2119,8 +2119,20 @@ static u16 nvmet_tcp_install_queue(struct
> > > > nvmet_sq *sq)
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 container_of(sq, s=
truct nvmet_tcp_queue, nvme_sq);
> > > >=20
> > > > =A0=A0=A0=A0=A0=A0=A0=A0 if (sq->qid =3D=3D 0) {
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct nvmet_tcp_queue =
*q;
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int pending =3D 0;
> > > > +
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* Let inflight co=
ntroller teardown complete */
> > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 flush_workqueue(nvmet_w=
q);
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 mutex_lock(&nvmet_tcp_q=
ueue_mutex);
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 list_for_each_entry(q, =
&nvmet_tcp_queue_list,
> > > > queue_list) {
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 if (q->nvme_sq.ctrl =3D=3D sq->ctrl &&
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 q->state =3D=3D NVMET_TCP_Q_DISCONNECTING)
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 pending++;
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 mutex_unlock(&nvmet_tcp=
_queue_mutex);
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* Retry for pending co=
ntroller teardown */
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (pending)
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 return NVME_SC_CONNECT_CTRL_BUSY;
> > > > =A0=A0=A0=A0=A0=A0=A0=A0 }
> > > >=20
> > > > which then would only affect the controller we're connecting to.
> > > > Hmm?
> > >=20
> > > Still I think we should give a reasonable backlog, no reason to limit
> > > this as we may hit this more often than we'd like and the sole purpos=
e
> > > here is to avoid memory overrun.
> >=20
> > So would 'if (pending > tcp_backlog)' (with eg tcp_backlog =3D 20) fit =
the
> > bill here?
>=20
> Yes I think so, we already place a listen backlog, so maybe we can reuse
> that as NVME_TCP_BACKLOG or something. The same should apply to nvme-rdma=
.

Thanks for the discussion. FYI, I modified the patches by Hannes to reflect=
 the
discussion above [1][2]. With these, I confirmed the lockdep WARN disappear=
s,
and saw no regression in my blktests runs. Looks good. Will test again when
formal patches come out.

[1] https://github.com/kawasaki/linux/commit/dc58819d07b02bd54dbcd5b15d2600=
a517fcbbff
[2] https://github.com/kawasaki/linux/commit/20fb65d145152562d0e11a9c8065e6=
4405c31b0d=

