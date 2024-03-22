Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86CE5C54E71
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Mar 2024 09:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TTtAEjy79hiT3gAK2l5vcSTBUTM14FK7qNKd6xKrFGk=; b=32TIw0sBEJJjDdooaZa7c4a9Vv
	q5WfOF2wLxR5WsFS8ayelFM3f+Cxub+nDuGk1zfmusRVMQvZe7YCTMsbWC8clNO/cv034z22gs+X7
	i3DJIEcLWWjqg2NOnHQADxupGamDzOxRCkzedB/JPT5I92bmuLcBSThyDfUNVVOc/teFZZlLjrX9a
	XPeyIPSHLPhJB18Ao3bXFXdA2BJMKgiRORdPVYO9i4zyDRsGR/KWZFvWUws/3PyeY2muNJJm9sX6D
	UV+8OTN3CnQKCDJKnYt5v8RVBTL7nfRAgrrZyeJMiKWDt5D5KhaaOx1vWJBdQocAsJ/7ph5OhL6b2
	4ot/8kRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnb5x-00000006Y0q-2CVt;
	Fri, 22 Mar 2024 09:21:49 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnb5v-00000006Y0F-0FnA
	for linux-nvme@lists.infradead.org;
	Fri, 22 Mar 2024 09:21:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1711099307; x=1742635307;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hBHVDVegnyqzQQpvzgHNApj8ta5r3Q9ZkD3HrzYeWCI=;
  b=Vb6qgFsKwS7BQda/N3asx3A0XV9XkphsrUYs5X7bHGlcAE4rC4uqMRoN
   so9nKHbNc2/xxvNdSEGoQyknHHLiFizEesZme3gyWeg5x0cCkkcSoQ/5N
   PXXdRrgusJepKfNPzg7mOYkiYhg3B9n2ybXrUh/nk2zz4dmBmA7K/ar0L
   B5VtEz8IvODT/CGU+Hmr+By4BqTn3sL5SUgA/OU+vXT0GKVh+pXEQxo+X
   pPcKO4eifLcnCVim3DGjYqX5zO3upokDXMwN6PuCaPQt0bhSO3G0gpCSl
   heyNZ2lWy2hsg6sIKn+bFH1Tul4yXeByp0uyxiIK4VCi5nRByyD+KmI4v
   g==;
X-CSE-ConnectionGUID: udssRD/xRjS4HloEQkFAHg==
X-CSE-MsgGUID: G8uVQLUmQt2hqOb/cbViAA==
X-IronPort-AV: E=Sophos;i="6.07,145,1708358400"; 
   d="scan'208";a="11739638"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 22 Mar 2024 17:21:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HaU7qSfhTGhxzGvqt3kCDHOCtaa/NwH+dDVv+UZESERIfZepm/vIma0tGIL4YoWUKP5+s9N8qjrN/GxUGohie+l9yzt0Mq2o3SH/V5lssJ7H93o8jN2SX99kVRPAPL7cO/h6l7ga7g6E8+rMu4fKcBhCJSzAK+QB6JpKikgJ7+pjoY7c0Jmj3sV0UJ59ADvO6olfsjgIUyF4qD7YR/XmqVwknr7zOueP96xH01DOhRxviLUf8qtfEPVDE4ZJBF/E0WEwYBKgNlMM5VIpNZ7CWnydX7BSXN+eHQJlOelJwO6LbTHYowbA/ISt7tbDXh9vXym2dM9/WgOjBBoPhg89/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TTtAEjy79hiT3gAK2l5vcSTBUTM14FK7qNKd6xKrFGk=;
 b=lfbwGj/8ZKteWmiNJop0Z8oTkTZL2UHMQ0rAmz8PS8ytiCLsbtR2ejbCcSt2ckTXI/1G40LRvTlYihmKrBUuU3TXjLLM7pKSmB7InOqueA/LnGrQzdyeShDZvPOihRGjZXHitGFbQLbQWkF88W5wY8FQbwNyE39B1uXD4qyre2Z/h8hvjl0+5cmU/FnQfBRSbG3UKJXIrdFHJUfLvjwb5kLi5SFjo8ZnFPWQweoZ8uWX65zsGGE9OdlbtOIlEKcMjTIwqY3MWDbwaBRR0U9zWdDSUgWEkpmPAhVzkUpwS8EMm3GQMR7NRnNa3nxBg3d2e+ochQmUlKf2IT8wUQG0ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TTtAEjy79hiT3gAK2l5vcSTBUTM14FK7qNKd6xKrFGk=;
 b=aRTuI0JUxW0OGdvHFnxRxdI8/rwHwFVtR03oW1FDNnnjyOzJuMXttgRqCn0SAAbaylyn+/MAQaffQ5gA5oiGI7h7QKySmnzqNf/r2ifFKcXOq3CMPS+YTPQBSkDGgvAvDTlsV/7ZV6C54rw5UJ43koiZZrBkKQbGNwbm07ciBeU=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CO6PR04MB7827.namprd04.prod.outlook.com (2603:10b6:303:139::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.34; Fri, 22 Mar
 2024 09:21:42 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f%2]) with mapi id 15.20.7409.023; Fri, 22 Mar 2024
 09:21:42 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Chaitanya
 Kulkarni <chaitanyak@nvidia.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v1 13/18] nvme/{rc,031}: do not cleanup external
 managed loop device
Thread-Topic: [PATCH blktests v1 13/18] nvme/{rc,031}: do not cleanup external
 managed loop device
Thread-Index: AQHae3TSP0hEJHfz7kC36M/31ZF/j7FDfcoA
Date: Fri, 22 Mar 2024 09:21:42 +0000
Message-ID: <b3642do26kjrjov2tg2n3t4wu3s2ruqxzd7s2s272jgbwpcb76@246hpcvdvypf>
References: <20240321094727.6503-1-dwagner@suse.de>
 <20240321094727.6503-14-dwagner@suse.de>
In-Reply-To: <20240321094727.6503-14-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CO6PR04MB7827:EE_
x-ms-office365-filtering-correlation-id: bf25b60e-3e31-41c4-8ee1-08dc4a517cd4
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G9DrDrNEJj2b5Z6TJ34IjKMykLZ6oTevVSE3smJfSkf8zf8or0vwLbH/zqiiyDRVMyemGsIBxJD9EW/4vsUKR8QCmkxlx2uv75gy3of87h7wKh8qr+mRLit5tzcjQ/7Kl1AFXXqXNX2tHM9k3WFiPatawKD8zLDI3053MDmtKhXnjqORxBMH714f7wJ2exJ4/BZc/oCKoZE0IKKd5wWtOR48p2KvXx17BFgo17pusLB/LMAAojZZPFOiUnVSoLLaltw5xt698wfnzCsK4w4pZ6g6056mCLNJJJCueMeskniXCSGS7wQcgksszGur6Z36xXRIIIBSJz0lKsfjHoZyDxQLfZOAd4aS4U/b2bIW2gS0DM+ONPm0o+In66s/wpbh71i2uplcd4JnUFWnMMDShL3hilqMwAZLXlCdTwE/IMG1W9dhPC0EtFOl/w/qFx/cp4pRDSs6UPFBMgEz+nIm5q1SeCQi94ZqKztB/MCt6BO0cnQwzGll5l4TEi7Tqb7AYdZibAm/201ravKMAfuN4pwOQOeJgSCK9d7vmr5RAPTO3AeQFlejJqxw5d1xVuGFstwI2vt20OX4MZFVKmqFYAKaTD6msdkWy+LRySB6MWOh0peGe2sbsmvpx8G/LGQA0nRjIvp6tPAn2k9zBesDuokpM5wF75nODPApGTXpJ2RJWUYKlS5eAKpM+k2dEnSb/4YkKCzT95grU1Y1xJ4CipVt++Lmq34G6aiWScaTkFc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MTyHZ+KB+zbjj6C6jQPnU1x/HUAomk0TpZHGGJl9p37YzPS9n3empgusTmlp?=
 =?us-ascii?Q?C6Q53SPp9bXt8tG1TO9pBY6yt093u6MM4G9T+2KmvlwxSnSN6L4qSbyaq+SG?=
 =?us-ascii?Q?8IIqJpfdOd/59QrSA2uNzsznBPqCcdTDCAL5Kvdoj3lKcuZXoCrIc+HZDmy0?=
 =?us-ascii?Q?yasxfwaF3uASnpDSWi8QaHcVWcnCJuxc90ivHuaA9O9w15CLdAyzo7+2I0Yq?=
 =?us-ascii?Q?e6stREpUAJXK64kb8XJ15OOCSI/frJpvmf42k51tMyL48bVaJD1Y1l4n52f0?=
 =?us-ascii?Q?60IiFUUz9u7EA94uPdk2xjmQ6MyrH75uPGtdzfC8VUP+7OBclaMpIjDY2egN?=
 =?us-ascii?Q?VA+WmPO3GYRqy1EatHlLMWuJZT3f/Ek8jg+F5bLtQkxxUc81HKnXgGsCHAzM?=
 =?us-ascii?Q?3+uJotAYxEnfkP6T+UrykSmIMF0mcGYywoYnV03/MFXbGD9t6OK9m9r+Udln?=
 =?us-ascii?Q?PlfhfdnyqCQnzcRTKzREVh3NvdFlWHXb3EosKGR2WUGCRah0V1GuRSdUODGJ?=
 =?us-ascii?Q?j7bXnPgf/ow/YNtwCyLSNU0g/gwxxqGIsAW4WVwzZzo2AsoQox+kmkopRxKB?=
 =?us-ascii?Q?NxzpzEiRFyWVzzZ9hbQmk5xX5l4vjolayDowvleDIbI8vNmsilqoS9hquR3M?=
 =?us-ascii?Q?VFieYS6HZKfxxQapOS2SnzTdPuA3usZUmr4mUihoXYnjjQ92F69fpMLCoRmE?=
 =?us-ascii?Q?OG2pHxR03s2tv8+OHi8GaoEbwt9WMFkWfkk4GvGbAkR/0P/yUDm9zCdvTZZ8?=
 =?us-ascii?Q?Fq2766JG/qSaoQvyttNtmS2hsxM5LiIiJrGC9rRUpDCj/Er3ZzHVxCsA4lbx?=
 =?us-ascii?Q?U4DsB/OP8WJVbbjJE0K2KzqXb9eclH7wMBRleJD8zoSB7YANn/NeN/lT4s8b?=
 =?us-ascii?Q?agNTa1b8VKMkgrYXTe0ai+g0qk2XId6OAIzbvmMLN97bXZwJTiOKZ2uwP8NM?=
 =?us-ascii?Q?0w/ZXtsFfzhIU8C643dVM9cY0OhXrs5AuIMU33Z60NWSIgcChnd+8EWfcLjt?=
 =?us-ascii?Q?O5cDDuNGv6WpGrwNs3vIpOag7AyV4UeAvZCFBth1ZxKS0O92wlhFGaYk2TUi?=
 =?us-ascii?Q?fbTBtnRFcx0GpQMUe28doWahq5PIG1u3Vutq8hcFP/acytw0KHAsmyKrTeMy?=
 =?us-ascii?Q?ZemEi484yCMW/5FDFscHZlIz5e8opJmRm/AdYvC4oiRhNzPY48f2r/KxP885?=
 =?us-ascii?Q?2LGJES8PtghUtGNjuaX9p8kcD4Na+M7MAkW7UMTaOHq0wOXnEpprcfKF69yh?=
 =?us-ascii?Q?UpOOsm9RrWHOL4pAAXQA22J/avPAH+5Edzvlcm4QnkkeedLIM8Z/j2cGVsXq?=
 =?us-ascii?Q?VOHH8AW1CN+fR8h5Mc11uhL/m5L/FWy3U9yBA84m4oQjsX91m3iuuZktfpQ1?=
 =?us-ascii?Q?HkvKevCTPrJVR8hucZfXeHsw1MypLpr9UfaHf5QuUhTip4Iw0CUkVtclXMIV?=
 =?us-ascii?Q?dB8xrvByKPBN1yrGJY4c/laj/xZZ44+y1rc+RknovCxAnZwcP4ScVNVT7Q/N?=
 =?us-ascii?Q?ZlyusyZCarvs4FlSuuN+mASCu8h3AlGhxTQyZO7glYdICtvkG0xLEnQXZwrI?=
 =?us-ascii?Q?xF46SIzHYSHsn8jnb4g0a7TbxNvsqsdoDSFLspnBO4LddZ6lZRXaeh54IZr6?=
 =?us-ascii?Q?4c9B8osIvrCD7s/mjTdKn0E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BC57681929F46F4591211582BF2B721C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qR1jraaWs9TciH6/f117uCSSI1RquFaca+ytfsR4bbwMbS6LzJqw8yJBmhbZeH6K+8DLfD6sZQoBG3MyM6SLfEs/OqcK5J4St1y6uP9MZyBPP9fwhIR2ZXk0IGYopJ72oaDtjnBy+zpiAsj5838C1ovcZe26wpcEjWdpIEsNFxgfLO9pP2Rk6vsUdcFTYUrPnX/w1iuO0gmfCmkLiirnjfi0JHLuKTqXshDdYPlTinNjyAbWpOUM2ue6hP908l4e7SZuis2LV5H5FudVRx3ci+ccOKeXV3mNiZ7fwyOxl7DMIKHnV4zGzjiEx0CwiebLpJUj2PNqvQN7wOdxVvAZIr87kJnhO3XDMiMOw7o5mNWqiUuwESEzrJ+tV0tnIyuLrnbp1q/0IFXMLI2095iaxm7geLTq/rLNXglN2xwvENQhU/C/0nO6iwu4zMKKMjwiShllM9P91Z/b1XyhbZWYYNRRBjQr0oanw67YDuObaNPsw6p1VhnwRXW8+Hk4ZwYa+cYBk81tMssi+MsK7QNJKgn4clVNJKsqcceSF1wMx4PbqRlr0Nf+B5C3I2d5yxDlDXJIKogCAHfjkfb2m+XreTCBPJukVTQPQktqa93xxCBqkLhI6K07FyRHXZYK7oL7
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf25b60e-3e31-41c4-8ee1-08dc4a517cd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2024 09:21:42.6575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7mZ8UiGCnMorctnx1HWC9BVTLIxSFFqJGNBydFYnnx6ebHYhgL7rYs/6GALWcYlY2t4z30F3IPu+7byACm3UdiszP1iFy9a+vdBA+IC2ZTM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7827
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240322_022147_192971_E264D79A 
X-CRM114-Status: GOOD (  20.98  )
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

On Mar 21, 2024 / 10:47, Daniel Wagner wrote:
> If the test setups a loop device itself (not created by
> _nvmet_target_create), do not cleanup automatically.

I couldn't find _nvmet_target_create(). Do you mean _nvmet_target_setup()?

This patch looks fixing an issue caused by the previous patch. If this gues=
s is
correct, it might be a bit better to reorder this patch and the previous on=
e.

>=20
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  tests/nvme/031 | 2 +-
>  tests/nvme/rc  | 9 ++++++++-
>  2 files changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/tests/nvme/031 b/tests/nvme/031
> index 892a52170ce9..bfc43282411e 100755
> --- a/tests/nvme/031
> +++ b/tests/nvme/031
> @@ -45,7 +45,7 @@ test() {
>  		_nvme_connect_subsys "${nvme_trtype}" "${subsys}$i"
>  		_nvme_disconnect_subsys "${subsys}$i" >> "${FULL}" 2>&1
> =20
> -		_nvmet_target_cleanup --subsysnqn "${subsys}$i"
> +		_nvmet_target_cleanup --subsysnqn "${subsys}$i" --blkdev "${loop_dev}"
>  	done
> =20
>  	_remove_nvmet_port "${port}"
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index d74a5418557d..e6e7b113ca8b 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -855,9 +855,14 @@ _nvmet_target_cleanup() {
>  	local port
>  	local blkdev
>  	local subsysnqn=3D"${def_subsysnqn}"
> +	local blkdev_type=3D""
> =20
>  	while [[ $# -gt 0 ]]; do
>  		case $1 in
> +			--blkdev)
> +				blkdev_type=3D"$2"
> +				shift 2
> +				;;
>  			--subsysnqn)
>  				subsysnqn=3D"$2"
>  				shift 2
> @@ -878,7 +883,9 @@ _nvmet_target_cleanup() {
>  	_remove_nvmet_subsystem "${subsysnqn}"
>  	_remove_nvmet_host "${def_hostnqn}"
> =20
> -	_cleanup_blkdev
> +	if [[ "${blkdev_type}" =3D=3D "device" ]]; then
> +		_cleanup_blkdev
> +	fi
>  }
> =20
>  _nvmet_passthru_target_setup() {
> --=20
> 2.44.0
> =

