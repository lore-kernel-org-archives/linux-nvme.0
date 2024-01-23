Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9709C47258
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jan 2024 10:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eiSPrqdGIvMsJ1QxtevY+REt1uHEBZE+NvIzrMqlMkk=; b=Odvok/saCgAuYgFg4hEf7o4Sfi
	vhhfpAQrbF2ecj+mTMbpyNR0Tu9r0aBV7Ci1TjJ1f7BtuaPwW0Ut2fSYhn7MAONAW4xmcvtyrcN7n
	878017V+fkTkOj3nlpAjuk7NCyumpxintTOrknBbah4Zr1zCPbzpAdzIJVsXlMOE8XqK+CIxJHFFC
	pS9qgRq3+Gr/cpxT0JJSawZ61j1bDrF1jtQzEiFGsiHKLnanzLVe4fA2Y3WGT7g2AM/KhkEM1qKdO
	yi1/vbSoYkyRp7ZQ+12gO5Mv4UDFL570Iq8iTgzZMgIyj+ao/Zv09ODuhyktIYN/2qNzXGv3A2B55
	mNPnufFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSEQ5-00G28e-0M;
	Tue, 23 Jan 2024 10:54:17 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSEQ2-00G287-2Q
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jan 2024 10:54:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1706007254; x=1737543254;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=eiSPrqdGIvMsJ1QxtevY+REt1uHEBZE+NvIzrMqlMkk=;
  b=dwh636WXdzm49FXLwlpPZ14+VMxRYzPpLwOE3x9+i+2Yd/iA+xbf9Lmu
   3U2ZXOSdRrD1qAabc7aGK4NGfxCvwtqMqFmJ5Co3B1KB8qxSN6kSR+v0X
   RltLsSEKUypOa0SNnSkHkEwXn2rbYPaBD5Sx3wPWMnZUVfnn6pggsf1U1
   07a+xJVFgecYOiCf/RwNDclHlVlJhEpokb1ywHbKHz6/2zjPoauJHYL4c
   fYeYLpLtyQRSK7JI9Azh8EReyRVtYNRijFyq5CIL5KdCiSYxUn7g0BIbx
   kZAK786WMWlWmjC0BHooEM5ahuhoDXX+VKo2bhhBGe/rOXGWyu+q0VjNM
   A==;
X-CSE-ConnectionGUID: /YGS6dp4STys6Jy3dqKWgg==
X-CSE-MsgGUID: PXZLVyUsQ16h3hm6VmBbMQ==
X-IronPort-AV: E=Sophos;i="6.05,214,1701100800"; 
   d="scan'208";a="7598033"
Received: from mail-westus2azlp17013031.outbound.protection.outlook.com (HELO MW2PR02CU002.outbound.protection.outlook.com) ([40.93.10.31])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jan 2024 18:54:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XDcuBsjwwC2FyJFpG9Ub0NZOWxCcqL6qHFAScFlQd4Yot1RfSyY37x/O/BnsoqJ+rdh0JiWQrPt1AFdfX1NatEUxGTaJhHtq8sCv4y4uSxmbaHXkT+RVL6jgM1wij4DFYcwzOhlWW0we66Sif12Ue934wg4XHuUYOzzAwm6dyOb8Na/i5XvUDz6PrVL8798yQ+ZIzcRHYR6Zmui/rPKldGcd/1wVVSd8extXKZ9/TErD7ZP/jXLYZvUiu+zUo+3m2PEPtIfX9w6cRRaJsqbMaVvKOmxOmM698MI8xCqo2MfqCzFp77VpxVkySJT+2yAJY3a6GDaz9V59BYvHJ8AbdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eiSPrqdGIvMsJ1QxtevY+REt1uHEBZE+NvIzrMqlMkk=;
 b=VQxYZTqvd0y+kkmmV8pyJRfa+UXoLo47nTZtj8dsQcwlyEdam6mNNfsHiRap9dBwUD6JHvZRanEbPsL3PZayvbbLX+bZGqr91Hf6JIGdMJikGqw5C9cwJm9pKzN2oCovhjCR6IWF+/RdzQH3/7PMb7Tgxpx9vZW1uG2HhEPGDiXQ86TZ56KUV590ye6bjEE7RzMZGKfwDkS6vvrITRq7yCNbxTxi3/8BMH2vtqWku7RDE8PxckyDVBI8+7chax8Lqk2G/4fp11evAdt/DZboJ68TKhJBbSpT1dbapOKf/KT2gzVUEx1G3OzNfTv0lTMUw7F/iZ16MfM/ywCsfrm+fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eiSPrqdGIvMsJ1QxtevY+REt1uHEBZE+NvIzrMqlMkk=;
 b=DphOfqx+vnCQGOYYDbjxEIWw4dZlH79hd8pUKZFsKmtL586dsNfXftsG0vGpsuNpCC3Xg2U3Fuojbun+ezOdU2j+wiNHhklPsp6h1iSA9msYDTJaRBMskfK6gcZb6iyCAs9wyv5cEK9DWzF0itITIT1vD8Iz7ejvdoUiSLg2TaY=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 MW4PR04MB7140.namprd04.prod.outlook.com (2603:10b6:303:7e::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.22; Tue, 23 Jan 2024 10:54:07 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::25d0:1445:7392:e814]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::25d0:1445:7392:e814%6]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 10:54:07 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Guixin Liu <kanie@linux.alibaba.com>
CC: "chaitanyak@nvidia.com" <chaitanyak@nvidia.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"dwagner@suse.de" <dwagner@suse.de>
Subject: Re: [PATCH V2 1/2] nvme/{rc,002,016,017,030,031}: introduce
 --resv_enable argument
Thread-Topic: [PATCH V2 1/2] nvme/{rc,002,016,017,030,031}: introduce
 --resv_enable argument
Thread-Index: AQHaSR2uKPFdCRtaxEW5yM1NNZMPo7DnQrwA
Date: Tue, 23 Jan 2024 10:54:07 +0000
Message-ID: <mn2kvkfr72tp7j5pcudkqzrp4yory24mwuqxby3zy7rjdhm5oe@2prxhce7mmgd>
References: <20240117081742.93941-1-kanie@linux.alibaba.com>
 <20240117081742.93941-2-kanie@linux.alibaba.com>
In-Reply-To: <20240117081742.93941-2-kanie@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|MW4PR04MB7140:EE_
x-ms-office365-filtering-correlation-id: 198335a4-c08e-4171-362d-08dc1c019f48
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1SWLW1eDmiJBkCQ0TJLrQaK0DUb+FNWGxVl4RW0wc1UmASUcxcuMhXphXCFR2JUwFuD/eXaG5SSeHplHJjkyg7mzlSzq5euBbz0LSvovCDlInTICdpiKr23p4xaS8Ggax/ZP+GMOSSRQBeQjkSdZk6d9ST34MEAwsczQMfaNjgH1o7Bairbbdk8wyjJMgkJVtaoxsrPryL+tQup53w0toT2ibfmRnyXmIY1XbZZ3xIJQeRfVbPvCxWuZXHwXNH6L52sCGqKkP6k/Du2uzJBHHZbNrqrus271Nfae/GueKz0rUtKMY31uIbNMdUsWWmyCfcC300GymMkWIPCNPHduReyBPCNvU91sho0W9FTdO28E5gDAWkIYxaoryHr8CUGFFckiEGY+529LK2XGX0FMjVa93Nnww0jS9OU6ze26racaz347YVgHhJTRtpFPsp1GwIw6EzLe5TsNXu1B89VooKjbIYeoZUE6S5mTLYndCGFhUwWD9HtNkrlkVO9xhGYcU3QYmTQX/U6d/PKYRDyT1r3AgEDRvts5Bm0HZnFc7GkxykkGWkwWtmnRaYMjKR5bFJ56zGp4IckZiy2TA6Ku6ttc77tVkrxJC4wuOmxZBXgEsxQHkelQyW6MoThvZg+p
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(376002)(136003)(396003)(366004)(346002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(2906002)(4744005)(44832011)(5660300002)(478600001)(86362001)(82960400001)(38100700002)(6486002)(38070700009)(41300700001)(6506007)(33716001)(9686003)(6512007)(26005)(122000001)(71200400001)(54906003)(66446008)(66476007)(66556008)(64756008)(316002)(6916009)(8936002)(4326008)(8676002)(66946007)(76116006)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EtMCLsx8HGSDXETUFAUdcsLtr0EubIwXdQgLgXFXc4PqpeaXxqs7paP0b907?=
 =?us-ascii?Q?JVmqwXm6vQhgptojIWXy39aWfhwWDXPtba2jT4Q/gbdIhs7ovm32ZKQ04pk6?=
 =?us-ascii?Q?8MPUiX7UvLO8nSg8u1G5BrcXEaHwJT8WgS8svb+6/XlYGe4fPc5Bh/cCUcmw?=
 =?us-ascii?Q?03D9zrGwWlY5kGXoU5+3fJmSMy1DfxPEApRM035GzKiAULY78W1KQjrnutj9?=
 =?us-ascii?Q?qQg5ByVCvlhlVW7vQXhrUzJ+TyghscBsXwN61J7C0yexAIQv4WPWLv9Uzlvc?=
 =?us-ascii?Q?xHvLO9oi3A/Q4RF0DU5OXTMlpscQ7yXpEzFCXDuR7/K+ZPcNaBF0ZjaR+aUm?=
 =?us-ascii?Q?r//w8WZPerufUKRkWQ8zSQNwuVmxFDLygdm4G61aSGU624ZxMiKVdWLVNJal?=
 =?us-ascii?Q?1xOMeYD9WE/6Zp9ProNGSGHRSS6jd1VQv2dhFz94QRiu+DDpBJP4Melx+8hn?=
 =?us-ascii?Q?Kvy0seeT/tle215sMp9rg4CXdFGIhruPAGAiWXAF9vIHC8jVNhLTw3xnxigY?=
 =?us-ascii?Q?LhMa7WiDfPiVYw4jZBtZg6jVGmOAX/v40zXkl94weF4ku2DYb6WRC2EGj3Af?=
 =?us-ascii?Q?QqAOMAn/Kn8LPGBO3y5XBpQo1pFc9bLoENuwTr0dT2p/HAD8xIT/En679DZV?=
 =?us-ascii?Q?H+Ps5R+xGKsyKgLESTU1kPWP6QypOsY8Y9/5o18J4m2CT5034153NfSeOX6O?=
 =?us-ascii?Q?kLl8GObm08CyVsvRKQ7IBxbwFqELaXJa7+0av+oqXPCJEH/uGtR1Btu27Kom?=
 =?us-ascii?Q?K43sZblZdIiSrn4xtpkl5e4oVgFUMCuLFo2AhH/AkVuCzTl5a11fvcpldkWS?=
 =?us-ascii?Q?CtK2vdWpJgYq+RZJCWYDW5c2LTZiHiAssFUUT8J7wPQAQEZ+eXfn+qopQB2m?=
 =?us-ascii?Q?UFvzBcHysuRANgb4B9kw31nsYTVGbth7VrfjKdL8db8chUMHrK/wIsDWkG2h?=
 =?us-ascii?Q?O6eWSGIPJZ+vZ+ZjHpu+d6nYDF7qhrB6bP6qSarstFBTljUzP1c8chKYlpuZ?=
 =?us-ascii?Q?FGqLIRE59iV6dLxhV9zIan4kT0+yKrvst8hQTLmteO5vdJ0A6lUyC0GmlrdV?=
 =?us-ascii?Q?xoUtc3arSkQM9TZWOSgojjmL5REurPTeiKAphMJs+o/6fISEBFlBzVcrT7z5?=
 =?us-ascii?Q?0mOTBFYlA5sDmg1/07mu+SLzNbm893xPmni7YkQSNyhBYOLsHX8J0E+/0rM7?=
 =?us-ascii?Q?gJciA/JqUcXJlVcQemlRE+aAQSsglyGRauWSV+K9K0UH4RaWXHFfVTrTR8to?=
 =?us-ascii?Q?pGZgpK4K+GvEZvw0SLrJWEKSOXfsMXRWq0Vurtrq3QAk4E8LXrwwZQiqj4Vg?=
 =?us-ascii?Q?EhPyJ1Airi4Twv7cd4yzWgMfTDV+QOQSally6Y128nTAyD5Ef7qkfOZEsSo4?=
 =?us-ascii?Q?J53GT+w7ju7vbXbc9jUjbAmepIqHkG9j4tzw4FUglJQ8oU48wloFVjAN42Pa?=
 =?us-ascii?Q?URR2dbTHZJdm8CXBvqoDeyvY44sPxjoe+7Iaz8tXUM2aVbXhADWjs+y/I5Qx?=
 =?us-ascii?Q?Oj4AJ0Py8k9k9ZY1uTalC7KWoOmrl3VzuV8CQXih/txkrxVhJL3JIe16231R?=
 =?us-ascii?Q?9lz0OWgAQrGls0MqeudFrMAiZlYfjUo7tmQ9dyt7MoFmxfhasoj2EEghzZFr?=
 =?us-ascii?Q?9Ikh+kbkKFIuaIUYjIhxBqg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7F47FDC01800BB4AAA2F57AE5E6FE16A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: AlnzWqulE+/aTP1vFr48Z9mylkwACv3Nxq8tpzgpGx9A/ARvFJblCs8I33VSNGpoRym45zP0uT5sUGlTaom9DeE8qZ/5LTcy+yh8Odlv0rWnZ9OS5Joy+nPq0zjMEMLsb6XdWXS8xQQV0Qwj+1CxeE5rqzKXhqIbAHVvLHdmRRVWK/GYuI63r8s+xC/+p+zSaZtHcMoNWEc6PmRo1PxAzNYXDrRnVCzs4DDVQsgHqlUwlI77FAZ7BMo6taYpexvuLEtkvesIW/Zzc1eAq4wFqPFHbsJCoa8xyDlRMSvDLoxDfZx1p31nJOdd5BDP6njQ2vljuT4e9vrHl5iV7zqosWQ/nMWzgeZ8JlZa7ArqBPGEvcJc1sLrNy23LjjD3Jbpseps+cmyP22uvEUPqPvHtXJpTh78q62qNu0vUjQ6KOiDRSF8oKzabNgFMW4go7Xi8bnpZSG4LVBcS8p1PS9EzuZnGXKkhSN5j88YSjnx5WvBFtdKy1+cKS2Mqj09OLQRDUxQH509DUsZFEg+VltcbiXt6ZA5w8AAOtJZn/ZwDQ5DldcZ3++aTRxNb+h+plehIlUX0EL8tYxCMHz4n7WEua3kIfwnynbMQe4IJvkyerrRHTOtRQi8Au5Wk4zf0yFC
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 198335a4-c08e-4171-362d-08dc1c019f48
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2024 10:54:07.2012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7j7KNLdaR4hgaxvtq6E0m+IhbBB/bwKVOLUbSuqtbPHfzYbDbKBGHViIM/eQo1k5uEyqwRuQDBvroYsqz0/Jl4ZSDyszkOSpgU+X37cdrfc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7140
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240123_025414_845708_D1C4E68A 
X-CRM114-Status: GOOD (  11.89  )
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

On Jan 17, 2024 / 16:17, Guixin Liu wrote:
> Add an optional argument --resv_enable to _nvmet_target_setup() and
> propagate it to _create_nvmet_subsystem() and _create_nvmet_ns().
>=20
> One can call functions with --resv_enable to enable reservation
> feature on a specific namespace.
>=20
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>

Thanks, looks good to me.

Daniel, could you take a look in this patch? I think it is consistent with =
your
work on _nvme_connect_subsys() and _nvmet_target_setup() in the past.=

