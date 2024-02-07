Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 490ECC4828F
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Feb 2024 04:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Kz4guNn8IUi3rXh+WhuWzqO1dofGb/1DSv33SD37Km4=; b=zHogiIvzOmxsbiYQzGjEV5M/FU
	NYaPJ0C+qd4PcGY42pfrEvaDy6e0ed0cAQGz+L+F8exkc1RBomMoWuHrPvveh93+l/3HY0GnvV8o/
	q7TKguAruKonsUQjzStgTBIgSglxAiMzpUV8GK3BoAEl5F559U4vcekDm/GgMGNRHTcQu2441zB/+
	hoFcio0yrmLVQAfMAbQd4Tjw+tv9orXOvI2sVjNfgT0fzh8WGP9mQCerj4HrTRolg/isy2yDLsh4Z
	op80NDu32qRWFC32oguv/Z2PUQP2ePGFZdEIyakJd8VzHkaUChRUL6MrkWCx9IW83tonlYwNKeVmz
	I+HW2B8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXZbj-00000009f8G-2wnr;
	Wed, 07 Feb 2024 04:32:23 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXZbg-00000009f7k-30lH
	for linux-nvme@lists.infradead.org;
	Wed, 07 Feb 2024 04:32:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1707280340; x=1738816340;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=x/mA1mgjcoFGLsga8dJbj+3f1+E/aztX5zi3l/IzOPg=;
  b=X5gPW/QmU8DAJ3OXzHh3pNcL0PLv249KNm3VmIRnjVtMXNszMQUxdsHP
   jxUa7unhhMSi+wfybaAEBDYa2tWECjAvNGyfeGKaxUJLWXH92XZ5TG9Yv
   iiRMzmzgZZc69nAV7a0yYttlKxETEvVhNN63xB0JLDDlFdzaGVI96e73C
   rq+30/6nn+SNjkGRjrD7ED+lQ1y/h954/A79Ys3AT5ktJzLs+Qr1ImgJx
   Jht46//lyXpAWqPWN/3ScHW42V4XZ8RwZ9ZI3W2V9px8jliSxBogaZ4ZX
   +ZMjtOABeMC28UWQZFzltNB0WCL6QRXD/rMS6HvIwp6LxeRbrnngZd6q7
   Q==;
X-CSE-ConnectionGUID: 2l4bnTbKTWSqf6ayy9m32g==
X-CSE-MsgGUID: SLqb0VnlQhWt1mT/DHdyrw==
X-IronPort-AV: E=Sophos;i="6.05,250,1701100800"; 
   d="scan'208";a="8733143"
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
  by ob1.hgst.iphmx.com with ESMTP; 07 Feb 2024 12:32:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UfCF1VLhBbkztG2SsDkAAO9Gi2KaaCN+NF2RUJjIi8XQQjKptnFKR8TUN3bA9KAQajRMTK1QNOsUCxERMNf7I965oScQ4S29L0vmkGlUlympTMgIHWWCGJiH61BeHSHckv6wieNSMWMNEe7qigEKbAxmScsLLrHhSv26KCp8EEcH/Sdd2n4KV0f/lHl/tFZHsZTuXLA/cOhgvZeVlqrUBoXZ2y0NzSAsp8RVvhQi2z7QCwLFpG0xIbshFyqhJ5Cs8idmww4PCEkFx0arId0fWQu1hd7Wch8gHz7ddPFFb+p33Pzq6P7jcxV907EhqQSZvVmnVP6a/rjuxT6VucJuKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kz4guNn8IUi3rXh+WhuWzqO1dofGb/1DSv33SD37Km4=;
 b=D5tNp4H79LivugrAEKAa2dFzLDoADmeBlg2NlMVT2pQtPK/BV3rXC0FAFXs9TzZ5JoXc668FwmAC463kHKhUhD6TPEWBfMdT2zTZjRowaMgtVk5e0liaQJ7jqU5QLHVYRrLFp7ats20NkLUzgJsYXG9t8/MxCdkmQym+jx90yGy1YplgHXu5JYSpVgfaPvtB2C3cx4PPaUaLE793ijp4tZLDRkUcrQ2/okb5lYY4WMcyxaVx9PmgfLbd1l+LsN5yreT9G5q9W/vXQN3NzRCqSO4Lc7dxzsuX6kd8oe/eooVN/u9VAX55fN8T0gnJR9o06Ci06SetDWKBFYv+lRhfYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kz4guNn8IUi3rXh+WhuWzqO1dofGb/1DSv33SD37Km4=;
 b=KCFQ5DPW1Yci2Ra3U9GCDRzqJ9UYWVUF+rbOwC2a54coxXhI0eK99KQo4GkwYQD29gXIY48zCeux/BxdjJlMf9hDWU1TWSR49duAtCy8mupvIMiyS/kBGgo0+s+TNLQMwxgMJSOS95vqRIemkyTcZtep7yYFP+OUDswXtvj0so4=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM6PR04MB6636.namprd04.prod.outlook.com (2603:10b6:5:24e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.36; Wed, 7 Feb 2024 04:32:09 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::25d0:1445:7392:e814]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::25d0:1445:7392:e814%7]) with mapi id 15.20.7249.035; Wed, 7 Feb 2024
 04:32:02 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Keith Busch <kbusch@kernel.org>
CC: Keith Busch <kbusch@meta.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests] nvme: test log page offsets
Thread-Topic: [PATCH blktests] nvme: test log page offsets
Thread-Index: AQHaWGR/Dr54sNANvUSX5YS80ipQ5LD801GAgAAKzoCAAW5IAA==
Date: Wed, 7 Feb 2024 04:32:02 +0000
Message-ID: <osl4dygp3c76pin62mumm42bs7t4hpooynfvsyqnda4acxxqeo@irad4vxvungc>
References: <20240205185225.2878642-1-kbusch@meta.com>
 <mabar2czffh5f7ftappnbtir34vzz65ecxatz7p4xbe6u6ts2s@hwe7yb3pcajx>
 <ZcHUf_MF_yDAkrMG@kbusch-mbp.mynextlight.net>
In-Reply-To: <ZcHUf_MF_yDAkrMG@kbusch-mbp.mynextlight.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|DM6PR04MB6636:EE_
x-ms-office365-filtering-correlation-id: b3804b32-1c26-4499-b7ab-08dc2795bb75
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UGaeyz250fMRPCq0fNWMmF7GIcOZKT10HOwn73T/0pHVeY5vcUQbvp5gjzufpfSla4s0z9dJ/Hcvbv/4gSS4h7jQhTqbzhB1SSov7IqxJeTZYr/rifaNnZ8TDR1RneB03nAG9nwoEzGJiX/FWG9jLywzpWCJtI14XvbSa8uusZQP3Z81+Hx4DUHAJu5+wGaxHlPA4xn4XAzL2mr5Akm8ywjBYyzNEcla96G/e+R7hIVN7MfiA71Mrz9f2nNGkElAFyGDn6w5Km55ZvXyCSzf9l/AveU2LTtvqtS9IJ2yNmr9Cp50pK3rM9HxaSCJtem67EnSHNZJRCKneHzADox5gSOT2JJ9HFwGqEAveCmFVIAxFkVzxChh3A7cqWyWC/8buu0AJptwCuveulJ8UoldCJWSa/PtbPqImVlg0HC9OVNhpGCNWpHVbNo1mg62jAUjIUuZKb54hFkX4r5ZiY5qARcu67jxb+uCctEbEBdTZ//PDD6zhPeEVyUWT82Va4jMCBFl4yrc+sQB8HHSDcV9WbpavMceSZlq0l+hdJZlwEUXw0yHuhMawKZltpF/r79qtqcK1vmOjoGbX9xmikx6Lt7XCO72z8twUWlAwrmhoXHj3mQc8Ys5yZjjUoZrGRr7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(396003)(366004)(136003)(39860400002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(38070700009)(33716001)(41300700001)(76116006)(66556008)(316002)(54906003)(64756008)(6916009)(66446008)(66476007)(4326008)(5660300002)(6486002)(8936002)(478600001)(8676002)(82960400001)(86362001)(66946007)(44832011)(2906002)(6506007)(83380400001)(71200400001)(9686003)(26005)(38100700002)(6512007)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?y+I/x1n92F+sutAS/+vElsgS0orV4qhDkZBmAZo2Dto4WKM7NIfDt8DgUZYe?=
 =?us-ascii?Q?US0ELrljucHgG/avdFfLnFrEeJ54TOCCAYroVlafb0OY8Ztdnw4JyOP9+I5n?=
 =?us-ascii?Q?eg0jlyN3WSsIo/qAmBWmDLUH/9cQaoOHeEzrQPlOmdmnTa0bZO/5hbWwKlaa?=
 =?us-ascii?Q?sG33suJ9uwdWE/KuS6VD2Sza6G9oMs47c39F2wbhHlBFWWWQ6z8yoHkXjjLC?=
 =?us-ascii?Q?3S89rnaLxv1LDUhTpfi1z6qGRF7NUCtAhxWQDfPJJydCmOQ6sADCfVw8v5+x?=
 =?us-ascii?Q?BHDmS2hJDE7FWqnM8yBGB5UX5lGIS9s/VVvoxNb/h+yDII/zNQiJHCZfzAOw?=
 =?us-ascii?Q?SgIJQiL7GnPwvqeIZ94yKZeDo60BwXPKbJBuirMITdv+Xtb/HgUQB42V6szR?=
 =?us-ascii?Q?VrOK9tRBB5ZRkC5csBFkVTGzM0klNeomYCr/amuUJW9rF2oOFcI/fpy9RLLm?=
 =?us-ascii?Q?UtxfnRhGHdPuHMFSD+y3zBEzu6WtTWPkFgJzao7r12fFfmSCiVGifjOJI7Mt?=
 =?us-ascii?Q?Z60ugqtyxE3uY6Y3TtClQVy+rtbJCakgxrO4uAq2Q0v/HBf0a39jFYJtouaE?=
 =?us-ascii?Q?0N2sbjs9lCb3GJJoKKvu+a9pntC0dQf/SVPqQcULzGepDI+tuatcEfd18JaV?=
 =?us-ascii?Q?OJdJrhrqF0N522fmO7wKZKXsRjpJTua7UNVNRageWqKmxMHYgbKLRQsiDec9?=
 =?us-ascii?Q?HD1U3F248aehpWfbNdtKS/NwzCN52IqhCM2k///CNk3yxvGPLufkaQkMB1t/?=
 =?us-ascii?Q?/GR277Qa4jLqYP/D5y8F2c/95Tg5nWKS2h/S/tiXILVqOeiPSZq18GcFbD15?=
 =?us-ascii?Q?0el+f+WzPVSCwjhISlVYiqAxlPtkJqiQE95SVP0tkiOTprrKLX4VoSYY/zrZ?=
 =?us-ascii?Q?z6l++Nb0f5aNz+1cbkkhkXqfNBAYRQcBpQWY1zm1nUCRHR6dHn6zTMtvRo08?=
 =?us-ascii?Q?vtpLtX8I37nAW/TzxS1/qzT20uhSgEgxk119MqEOaccWvvCmxhfKK8EUxAow?=
 =?us-ascii?Q?PCsrXqLSfRHbgUa5gbyiIQYqRc4ja3e4TUkRMnzUsdhY7xk1vmB5R+4E1xzN?=
 =?us-ascii?Q?HjgEjYb95AAHMNYzdSe6v0xNVBIOlCHwwNCODNdMtCzQ11ThEfu+9rdwiinX?=
 =?us-ascii?Q?XcaT93ekAGDExiJBt+tFkuP6njwhqGD/7yUqSIQjEQ6+SPEUDlPvfdEFS9vS?=
 =?us-ascii?Q?HjyAicF5ly7JSlQBSM7W6RizQIj5HgsJgLLNgi7gJgO2MhXfv8sHSR7gaxd0?=
 =?us-ascii?Q?bRnucegGwZQ5i1tCHHF9ywQzUjX5tAbRFHC6F/R3NwhhXWxgLjsLynDvQPlY?=
 =?us-ascii?Q?D7CSk7iGOPpfhrEzP9nTEyaRJafmG27QSsgHgOTUSUQzRVcIjqmaJ6jisq4t?=
 =?us-ascii?Q?V1mJPJbp/RPpQZgJPXKa7RUTNKF2TYMPvmebRCWekKcD59rke8FOKs8jbpab?=
 =?us-ascii?Q?FkLgOchV+JCL8ItoAA2M4TipdCBU37JUhkPfOezb70ISWGEB0hTDPSh4xvm9?=
 =?us-ascii?Q?hCeOSkHtCkC1jgZSqY1UAVgxAXWubcrEHfcl6Kng26fANnF8z4P6OMfpQTsF?=
 =?us-ascii?Q?7R/g0KTo4ZOdwmIEOWUB0QH8GxQv61L/oQ/ncTMT3GYhxTUa463Qt86IV7Ew?=
 =?us-ascii?Q?hP+n0ptrrXPtiooIbFMwaHo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3ECB9B8773AB654784EFB6AD7A7CF4A7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ilkMvxmNDsoneTZL/JFm6USqrzmH2UcdBPjVonpfLFDDAJgPjrfQ9hZiWYaaPAeXHM5XOzJ7l5zIf4HO42ZWATXcqoLBwZ0pgotPIUAWd0goWFWCNCESqC/HU6FrXUubBCfziyKQgVptwfq4VZzA51QdSpjrU7/WFCn2XAWc7zURfd3pqxlGIWLHzXgC1ZXl2dnOOOB9zR/nVQpT/6hvgxEyOvqGQqNuONDIEXM8zv+08hky1iE2gYpZ3aAWeducl7mIzjXsWwu7sWNqmSlaxNiVdI39k9MBDHyK1hrCRhQp9ligQzGlCLdg6nUBvRrGcKcnkjNzBdxi4wk6/6x+TBMu3FgVFP0FJukTIbxF8D0MB74eBmgTF7YZWPAEylzpejHjdl32dy+xYx8WcDf6ii71I6jGmr5nfVvyDe4SOnXEX1BjLy7aQAOi12yKF4M3j5B4sAOkpClG9uUXcdGWqNxAIFDcG4b2BLobg/pqR10Pi9XCQaim7NzKOnvo6PWfAAQOuiDL2niWiuimgzWKxnvwgCIziyGrEL0nnVLiNP4oQxWXymiP7xrT+nwTM8YQD4JtOS8I6yPpeqtgpfkm638hh/Oesql9l5Whzqlsh11U5/lC+HADI1hhns2i+poe
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3804b32-1c26-4499-b7ab-08dc2795bb75
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2024 04:32:02.7956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9InPcjq4262wQJZo456NbXiDfiaZ6LNGk/M14P424vbLQ3rsXQ16xqT3IKQ87GXoTKh7YYeBRpzorHbwulamw6lP6qxTIOopR53gxYEshns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6636
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240206_203220_899726_35B86EE9 
X-CRM114-Status: GOOD (  38.18  )
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

On Feb 05, 2024 / 22:41, Keith Busch wrote:
> On Tue, Feb 06, 2024 at 06:02:24AM +0000, Shinichiro Kawasaki wrote:
> > Hi Keith, thanks for the patch.
> >=20
> > On Feb 05, 2024 / 10:52, Keith Busch wrote:
> > > From: Keith Busch <kbusch@kernel.org>
> > >=20
> > > I've encountered a device that fails catastrophically if the host
> > > requests to an error log with a non-zero LPO. The fallout has been ba=
d
> > > enough to warrant a sanity check against this scenario.
> >=20
> > Question, which part of the kernel code does this test case cover? I'm =
wondering
> > if this test case might be testing NVMe devices rather than the kernel =
code.
>=20
> This is definitely a device-side focused test. This isn't really
> exercising particularly interesting parts of the kernel/driver that are
> not already thoroughly hit with other tests.
> =20
> > Also, was there any related kernel code change or discussion? If so, I =
would
> > like to leave links to them in the commit message.
>=20
> Not a kernel change, but a tooling change. smartmontools, particularly
> the minor update package from Redhat, version 7.1-3, introduced a change
> to split large logs into multiple commands. The device doesn't just
> break itself in this scenario: every non-posted PCIe transaction times
> out after it sees an error log command with a non-zero offset that AER
> handing fails to recover, taking servers offline with it. A truly
> spectacular cascade of failure from a seemingly benign test case.

Thanks for the explanations. The issue sounds nasty. IIUC, the motivation t=
o
add this test case is to catch the device issue early and to not lose
developer's precious time to debug it again.

Having said that, this test case will be the first test case to test *devic=
es*,
and it will extend the role of blktests. So far, all blktests test cases ar=
e
intended to test kernel/driver *code*.

With this background, I have two questions in my mind:

Q1) What is the expected action to take when blktests users observe failure=
 of
    the test case? Report to linux-block or linux-nvme? Or report to the
    device manufacturer?

Q2) When a new nvme driver patch needs check before submit, is this test ca=
se
    worth running?

I guess the answer of Q1 is 'Report to the device manufacturer' and the ans=
wer
of Q2 is 'No'. It would be the better to clarify these points with some mor=
e
descriptions in the comment block of the test case.

Another idea is to separate the test case from the nvme group to a new grou=
p
called "nvmedev" or "devcompat", which is dedicated to check that the stora=
ge
devices work good with Linux storage stack. It will make it easier for the
blktests users to understand the action to take, and which test group to ru=
n.
What do you think?


...

>=20
> > I ran this test case on my test system using QEMU NVME device, and saw =
it failed
> > with the message below.
> >=20
> > nvme/051 =3D> nvme0n1 (Tests device support for log page offsets) [fail=
ed]
> >     runtime  0.104s  ...  0.126s
> >     --- tests/nvme/051.out      2024-02-06 09:46:03.522522896 +0900
> >     +++ /home/shin/Blktests/blktests/results/nvme0n1/nvme/051.out.bad  =
 2024-02-06 14:50:57.394105192 +0900
> >     @@ -1,2 +1,3 @@
> >      Running nvme/051
> >     +NVMe status: Invalid Field in Command: A reserved coded value or a=
n unsupported value in a defined field(0x4002)
> >      Test complete
> >
> > I took a look in the latest QEMU code, and found it returns "Invalid Fi=
eld in
> > Command" when the specified offset is larger than error log size in QEM=
U. Do I
> > miss anything to make this test case pass?
>=20
> Ah, good catch. I don't want to fail the test if the device correctly
> reports an error, so I'd need to redirect 2>&1. Success for this test is
> just if the command completes at all with any status.

Got it, thanks for the clarification.=

