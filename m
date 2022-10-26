Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFBCEC433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Oct 2022 12:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Pw0FLMadUR8A5efZ1tZsM/1B2Rm2OJdc0zxzXCWgcmY=; b=wDLTe75C1P2ITuq5bLL/ZTDuD1
	L1h/XqRI6ivtEkeq6wvTDlWqb9nJvfh6E+l/nhQyqpQpxH5u0Kt1YZJwDclsEeFlvMMW731dAsnwc
	pW4yumSW171oNat1frZY9LJIdZkr93W/1/DMpKpwXv2Wyd7LFS4/jC7w+VGk88zxDxi+6+QnzCYYF
	NTFmQEMhfTaysNaICJdQjqxlfiOm6fbtc6nHH3B4QdWjNoV4z637d+0RTAR8n3/HipJjmPvx56i1g
	Lr6D7qH7K2fU6eeoG0tX+AUkOIxE+fPvwi7/dJr/kpMiw1pgsckQlesq48xI6wbpAysXqfp896+YA
	4vcUMPYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onf6h-0097Oo-DD; Wed, 26 Oct 2022 12:02:03 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onf6c-0097OK-RN
	for linux-nvme@lists.infradead.org; Wed, 26 Oct 2022 12:02:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666785718; x=1698321718;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ZmTcmrpsXKNgcJHoY6MXkW+0Apt939qapQwTplA3PAI=;
  b=F1QHFKUxAqt4PMwGRw/CIeX0cdpFBpy80qW4eGR1II1pjw4U4XdNR89j
   a28eKjdWjql32BH9qQdt3lwKgpz4CpgzHSYBPcFDqUxUnlvR5CTV6X52U
   qSZQX2SJRF4QG7EpSBWbBctXFI1juwRCAQ2zOdWrbA7Gv464QEPQQBW07
   MBm2W7C0CgLFuqoAN4GXMpjzmPO9sTYgiiDXtrmUGQ/Ja8rUMc9+96V3w
   0twY+sDS0GU6rMYttwmM1NDLmxZvAAXplhr/phRADpXFhiYSVjpxq2tTW
   zNR9aaQtvf9rDpBS+LvE5qyk0yG1fer9hJMQkDao3pn/yULzIY0Z2211C
   A==;
X-IronPort-AV: E=Sophos;i="5.95,214,1661788800"; 
   d="scan'208";a="214773946"
Received: from mail-bn7nam10lp2105.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.105])
  by ob1.hgst.iphmx.com with ESMTP; 26 Oct 2022 20:01:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UWrK25kCZs3txD1aI4QCvH8jgIT1zLXXsoXSDZfjGqxtuJz1epNJrfi6EXpbK+GmOB9BEWVbC81sVO5rT6suyMRo2lQ/dP4cyxcfNPU5iYDTOksHCh2QavDYzFZTs/XmXcNx2R6qq0loJ8Xov9DDi6Y7nlt0cV54sdDPxhc1x9hFGHB5UGdWRSSMLNLIUgF11SawVwPhRftKO2BttarrRUpXhmB0+0vYi1lwcJeN+BBk+VGfC24686mwy89oTptPZoRi1odgeHk4tYo2alym4N5Yb+PO+6afJjFz9IMyju3r/J+nnThKf5hINNLbTJH5HfS6h1DUQGwmYrw1GQ7+oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pw0FLMadUR8A5efZ1tZsM/1B2Rm2OJdc0zxzXCWgcmY=;
 b=XPvDUV4w20fBSeDGK5jQQTr44K57IP8cz9ByT3QOV/uo6Yuzj0lGFJ9d4grKvmBsCjOv5lHnrc199Ab7BQN3/PXlQfDo7XBYZxH9CDygfbtE79Ultn3YiaKDCA19bGSF80GzWErEx9ofwKV1WoKaJQ6NLTYp0as8GulzzQh+nIMaHtl97ZRyyYPhc0QiICQH65tZsQbCG2p7w45bJeiu+PhmH1WwLDffLk539Y1xqRUeK1py5ZHtH+hv75xoDSXUdyd5Zps40LqcpEYs8cFz+kWMCYWO4Jwy5pHT9V4VldBYEkBNGNNmHaVvbnVS7IqPYbvzbvciqwuNzPB455qnwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pw0FLMadUR8A5efZ1tZsM/1B2Rm2OJdc0zxzXCWgcmY=;
 b=amO0WSw1e4TWTmqDnQwR3Lowv/57dUqUYvAXGV21EHrgCKv36h6FMnbTJTG8CRp1uQcj9/fo3pcxYDxyyGJiUlihS1RtvXPBr4G9qI8hWAAAqtjW34/Sqm5XMu7BlGTiLk/dvyHPX6B9Pz5O2vUVxgNxN1/yKmjPovtse3CWn6M=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BYAPR04MB6135.namprd04.prod.outlook.com (2603:10b6:a03:f2::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.26; Wed, 26 Oct 2022 12:01:51 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::d4b9:86e9:4fc8:d6e0]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::d4b9:86e9:4fc8:d6e0%5]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 12:01:51 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Hannes Reinecke <hare@suse.de>
CC: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: bad unlock balance WARNING at nvme/045
Thread-Topic: bad unlock balance WARNING at nvme/045
Thread-Index: AQHY4sgozFGFnCMG3EKP0AQmcjycsa4T+1KAgAxLOICAAFlbAA==
Date: Wed, 26 Oct 2022 12:01:51 +0000
Message-ID: <20221026120150.luck4dinfvhrw7se@shindev>
References: <20221018080350.zir6xm6dnr4wgb7j@shindev>
 <93e16b0e-4fa0-c0e1-6cc5-dec018db5f5c@grimberg.me>
 <853f0eb7-1f0f-eefe-fd32-0b1a1a98d3d7@suse.de>
In-Reply-To: <853f0eb7-1f0f-eefe-fd32-0b1a1a98d3d7@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BYAPR04MB6135:EE_
x-ms-office365-filtering-correlation-id: 929bbee4-33ac-4f12-e162-08dab749de53
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  5QGBmoEGn0RnTUmjQBjSD+pAI5zhIgyX1ljVf/Spt2w2jlYK7xMzechveXodLfbto8TexLysK/D2kVqLpkc3Pticj43mvrkjYoz3z52Fg62jTu34JdYdNJat5Wgm2FL/fMfxiZFvj6bSiGXcMOcSWx0IQEI2YWovVr4u5ZER3wZW5m+b6oCBeTnNMv04YYCmPdQR7bbTln+V6Rb1vA+Fjhb2RiNATIs/6mpKh33+p4blp6uZLUa3i9uogapcL22T+RVzyQ7zl/LAXlA7vKBHVMoFRmMafbqUK1rSR+SwHdMVDIXjfv8uayDuhmfBw+IndzuttbJska/FHZJeaMmCt+4me9Ng9XB0G6a3bw0V3E+9bgkf7jSXvUNSOHsc95L3htDgyAK7AWoypQurDc/y7dKk/3vgJKZAkb6oCo5PNUHzdJB5cRfKirIZT54rA2UjDXGyPVfnAPQ6s+XMZHZlK5TUqyvdnvKi4ad19dRtfwczkq7cn9WD3ZeAOmIhMYaZVDchg/2DV/qPjAAwYbyExENl+MsqGNFTD0kfjj0QRVO5oRj9vRO6A8HDVR+J+Ti/668G4YYH10Df7rWlcUt0bq3DHJ6h0i0xza2FQzmFT1ZOZKhcRhs0nMFznR4vFhgIxCJE7IQXvJ/RoX7HfJzR+wvWsesZQKAvjrDqZCpghdtwOsx1R7gIhangedKPtGOe9oAuX/rORqwn8YsjnomvbmfsgcxSf9cZ5g3pP+o/ID7b6LdsFgHHmBhMF1I3RB38xGCcg5Xt+stOrcAOJQ/08w==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(346002)(366004)(136003)(39860400002)(376002)(396003)(451199015)(6916009)(122000001)(38070700005)(478600001)(54906003)(316002)(82960400001)(38100700002)(86362001)(83380400001)(71200400001)(6512007)(33716001)(186003)(53546011)(26005)(1076003)(9686003)(6506007)(66446008)(64756008)(6486002)(8676002)(8936002)(44832011)(4326008)(66476007)(66946007)(2906002)(41300700001)(76116006)(66556008)(5660300002)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?iso-8859-1?Q?RxkD8AID0M7m++rGn43bIkAktU3Jo5FJ60o8w0xb06cUGJevdYm1iJEbyD?=
 =?iso-8859-1?Q?25MmaIbpCNVichbYGGcIXHnRowjmVkAH+aciKZBdwzTaAqHXP90Id0FnEF?=
 =?iso-8859-1?Q?v0/IfYpuSaoMvoLLWIhhEZKcdEfGs0dUYUBfdW9HAj/unTmAcqvtMqqU4T?=
 =?iso-8859-1?Q?6pU/jcwuo88xZmTcV4ZkTTgQDT/wE76hwuYez0tDSgP9P/8+V7+ROjX10P?=
 =?iso-8859-1?Q?xzRcNe46z3ZaPOwkXmcDV/zysegCBRm8oDETl/UrfX4Fdrs2ibxvskqAK/?=
 =?iso-8859-1?Q?1zsS9iYWzFBlPssgewUF7gFF/hr2FG0RMwAUC++rVd+qG/00rB6+FjmGdB?=
 =?iso-8859-1?Q?aezgfHALwIFR+tae97+JeZavEk65f3Zyfj0fJFu9lwm1W6DojMmWS9GGFK?=
 =?iso-8859-1?Q?mm8hYZ/X/AnSR+7ZPRt2kcTJ8gBlMn4kv+pa+IMRZJDAQkkSoF8OBlP8Ir?=
 =?iso-8859-1?Q?c/TOYB9ZHGb3cjFi3wuJ2+1h0GtZO50c9AdtHBm9/ldmr3ifa5KP++QFi+?=
 =?iso-8859-1?Q?hxilMFZnkvzjkTCCKCQ/SSL/JjH9jrNe/ixCsC/rGn5G3BCXCvllRywmdp?=
 =?iso-8859-1?Q?0Ap24XMUzuU6ScLvs7BNJUosHuiGtLMrwGOPlFWs73sngbqzrIYAXCuTJZ?=
 =?iso-8859-1?Q?WhEmgwJXfATJEy+s0CviOBJ+pI2sYWBkaPvR69Ryx3nU64LwpNHH+d8sQL?=
 =?iso-8859-1?Q?I0TC8hb9LIpvVVHJOyIjSKvVgXEPekKh8D1xjGhHhbgw4ZhZCSH6GYF+5I?=
 =?iso-8859-1?Q?F1wSFj0FDaGadL9WOJE0/BcppRm1tpSkwEqODuitUMffweHVx1sDfU38Tp?=
 =?iso-8859-1?Q?RhWzJJuhh6DVrugRXEyidWYTVsd//N/Hpk36E2nctCCy6vv3/DE2AWNoe/?=
 =?iso-8859-1?Q?GJKYe6+xdr+6ioDuZvLUEX17mAGys4XJLvDR71slp5zzQw6cHrY3IPNk3o?=
 =?iso-8859-1?Q?EnNJoY6ESVzbOLI1LarrwvJh7vkB1QPwCC8Jnzgpk+EgpMA7ZqO1ylKJ9f?=
 =?iso-8859-1?Q?fQjbGiObwut3ezAl73hVTgLjutv5ROTnjMMvuu3E26EcBzMRa+dS1pn0Cm?=
 =?iso-8859-1?Q?/Dp9mc86C41TjJh7PjmMgGPWGzTVX/Gxki3MuLzB/R46OogETVdgka4Snv?=
 =?iso-8859-1?Q?LlHVgh6d2B6gQjZ1R8OImcr+Yjt4hrNsnetcIR+4xt4FiBGiP/RnvHsFgQ?=
 =?iso-8859-1?Q?5I7gGl3BiK7MkyXjjdFQbrCEC/IxfrgEZs6wiFK4FN28qm/0GNpYMJJJCh?=
 =?iso-8859-1?Q?P2KKTPKOrIRYa3zS62WyO+Cvjrzjo7KxrwLCgel2h/Q5mpxajiu1zuXqf+?=
 =?iso-8859-1?Q?vCkdZVDjvXUsZJ+FvgctkrHYBNIKz9g5x+/F1NMyt6QTXhynVvlif/wcIJ?=
 =?iso-8859-1?Q?JwgGJKKDO7KQeioctp52SQfanTKmlv46IEWgXaXKyeT3RUUnAkBAo4e6Bf?=
 =?iso-8859-1?Q?K9krMNXZf6R9WJ78UkJjNFfg++W3F5gBzchNnaoKibe0eGEi2cUmSSJaqt?=
 =?iso-8859-1?Q?VYQZ7vyLNsH2TY8LPlU/mCJdqKjOqoLayt58zIf5GZBzyOWU1+49q58+Iu?=
 =?iso-8859-1?Q?X7DvlBPazSFrSnfcYBhqKGCpg99RSI9IrdjuLmZmaqG8p67Ga4Vx7m68uC?=
 =?iso-8859-1?Q?OHLKdqu0IcEwFCzMQllHmS34R8gGh6lYyb4KLDwM3FXWozBek6Cbm8CG1w?=
 =?iso-8859-1?Q?5O0Ufg8zvzGFFyu+vfU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <D5A80AA1200E104CAF920326BA995921@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 929bbee4-33ac-4f12-e162-08dab749de53
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2022 12:01:51.6413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JKRkbbmelqVq7OI3omv0ZgC7qdXUcwAKVmBYhcy9r7FJIY7xDTjHVGNgWHNOQqr+ncTYxTwnGjzV4wsK6O27WTlJNCnX0Lo3XnfraY/EcWI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6135
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221026_050159_200183_5482D76B 
X-CRM114-Status: GOOD (  38.84  )
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

On Oct 26, 2022 / 08:42, Hannes Reinecke wrote:
> On 10/18/22 12:57, Sagi Grimberg wrote:
> >=20
> > > Hello Hannes,
> > >=20
> > > I observed "WARNING: bad unlock balance detected!" at nvme/045 [1].
> > > As the Call
> > > Trace shows, nvme_auth_reset() has unbalanced mutex lock/unlock.
> > >=20
> > > =A0=A0=A0=A0mutex_lock(&ctrl->dhchap_auth_mutex);
> > > =A0=A0=A0=A0list_for_each_entry(chap, &ctrl->dhchap_auth_list, entry)=
 {
> > > =A0=A0=A0=A0=A0=A0=A0 mutex_unlock(&ctrl->dhchap_auth_mutex);
> > > =A0=A0=A0=A0=A0=A0=A0 flush_work(&chap->auth_work);
> > > =A0=A0=A0=A0=A0=A0=A0 __nvme_auth_reset(chap);
> > > =A0=A0=A0=A0}
> > > =A0=A0=A0=A0mutex_unlock(&ctrl->dhchap_auth_mutex);
> > >=20
> > > I tried to remove the mutex_unlock in the list iteration with a
> > > patch [2], but
> > > it resulted in another "WARNING: possible recursive locking
> > > detected" [3]. I'm
> > > not sure but cause of this WARN could be __nvme_auth_work and
> > > nvme_dhchap_auth_work in same nvme_wq.
> > >=20
> > > Could you take a look for fix?
> >=20
> > I'm looking at the code and I think that the way the concurrent
> > negotiations and how dhchap_auth_mutex is handled is very fragile,
> > also why should the per-queue auth_work hold the controller-wide
> > dhchap_auth_mutex? The only reason I see is because nvme_auth_negotiate
> > is checking if the chap context is already queued? Why should we
> > allow that?
> >=20
> Well; that's partially due to the internal design of linux-nvme.
> The controller structure itself doesn't have 'queues' per se; there just =
is
> a general 'ctrl' structure. So while I would have loved to have a per-que=
ue
> structure to hook the chap authentication into, all I have is the control=
ler
> structure.
> Hence we have a controller-wide list holding all 'chap' structures for th=
e
> individual queues.
> Hence the controller-wide mutex to gate list modifications.
>=20
> > I'd suggest to splice dhchap_auth_list, to a local list and then just
> > flush nvmet_wq in teardown flows. Same for renegotiations/reset flows.
> > And we should prevent for the double-queuing of chap negotiations to
> > begin with, instead of handling them (I still don't understand why this
> > is permitted, but perhaps just return EBUSY in this case?)
>=20
> We don't double queue; we're re-using the existing entries.

Hannes, thanks for the explanations.

>=20
> Can you check if this fix works?
>=20
> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> index c8a6db7c4498..4e824aab30eb 100644
> --- a/drivers/nvme/host/auth.c
> +++ b/drivers/nvme/host/auth.c
> @@ -926,7 +926,6 @@ void nvme_auth_reset(struct nvme_ctrl *ctrl)
>=20
>         mutex_lock(&ctrl->dhchap_auth_mutex);
>         list_for_each_entry(chap, &ctrl->dhchap_auth_list, entry) {
> -               mutex_unlock(&ctrl->dhchap_auth_mutex);
>                 flush_work(&chap->auth_work);
>                 __nvme_auth_reset(chap);
>         }

I confirmed this hunk avoids the "WARNING: bad unlock balance detected!". A=
s far
as I ran blktests with this change, I observe no failure in other test case=
s.

However, I observed another new WARN at nvme/045: "WARNING: possible recurs=
ive
locking detected". I think it was caused by nvme_dhchap_auth_work in nvme_w=
q
tried to flush another work __nvme_auth_work in the same workqueue. I creat=
ed a
patch below which creates another workqueue nvme_auth_wq for __nvme_auth_wo=
rk.
Do you think this fix approach is acceptable?

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 4e824aab30eb..946085070223 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -42,6 +42,8 @@ struct nvme_dhchap_queue_context {
 	int sess_key_len;
 };
=20
+struct workqueue_struct *nvme_auth_wq;
+
 #define nvme_auth_flags_from_qid(qid) \
 	(qid =3D=3D 0) ? 0 : BLK_MQ_REQ_NOWAIT | BLK_MQ_REQ_RESERVED
 #define nvme_auth_queue_from_qid(ctrl, qid) \
@@ -869,7 +871,7 @@ int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid=
)
 			mutex_unlock(&ctrl->dhchap_auth_mutex);
 			flush_work(&chap->auth_work);
 			__nvme_auth_reset(chap);
-			queue_work(nvme_wq, &chap->auth_work);
+			queue_work(nvme_auth_wq, &chap->auth_work);
 			return 0;
 		}
 	}
@@ -896,7 +898,7 @@ int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid=
)
 	INIT_WORK(&chap->auth_work, __nvme_auth_work);
 	list_add(&chap->entry, &ctrl->dhchap_auth_list);
 	mutex_unlock(&ctrl->dhchap_auth_mutex);
-	queue_work(nvme_wq, &chap->auth_work);
+	queue_work(nvme_auth_wq, &chap->auth_work);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(nvme_auth_negotiate);
@@ -969,6 +971,21 @@ static void nvme_dhchap_auth_work(struct work_struct *=
work)
 	 */
 }
=20
+int nvme_auth_init(void)
+{
+	nvme_auth_wq =3D alloc_workqueue("nvme-auth-wq",
+				       WQ_UNBOUND | WQ_MEM_RECLAIM | WQ_SYSFS, 0);
+	if (!nvme_auth_wq)
+		return -ENOMEM;
+
+	return 0;
+}
+
+void nvme_auth_exit(void)
+{
+	destroy_workqueue(nvme_auth_wq);
+}
+
 void nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
 {
 	INIT_LIST_HEAD(&ctrl->dhchap_auth_list);
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 059737c1a2c1..aa06c686ad29 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5341,8 +5341,14 @@ static int __init nvme_core_init(void)
 		goto unregister_generic_ns;
 	}
=20
+	result =3D nvme_auth_init();
+	if (result)
+		goto exit_nvme_auth;
+
 	return 0;
=20
+exit_nvme_auth:
+	nvme_auth_exit();
 unregister_generic_ns:
 	unregister_chrdev_region(nvme_ns_chr_devt, NVME_MINORS);
 destroy_subsys_class:
@@ -5363,6 +5369,7 @@ static int __init nvme_core_init(void)
=20
 static void __exit nvme_core_exit(void)
 {
+	nvme_auth_exit();
 	class_destroy(nvme_ns_chr_class);
 	class_destroy(nvme_subsys_class);
 	class_destroy(nvme_class);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a29877217ee6..472ab2d14a67 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1019,6 +1019,8 @@ static inline bool nvme_ctrl_sgl_supported(struct nvm=
e_ctrl *ctrl)
 }
=20
 #ifdef CONFIG_NVME_AUTH
+int nvme_auth_init(void);
+void nvme_auth_exit(void);
 void nvme_auth_init_ctrl(struct nvme_ctrl *ctrl);
 void nvme_auth_stop(struct nvme_ctrl *ctrl);
 int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid);
@@ -1026,6 +1028,8 @@ int nvme_auth_wait(struct nvme_ctrl *ctrl, int qid);
 void nvme_auth_reset(struct nvme_ctrl *ctrl);
 void nvme_auth_free(struct nvme_ctrl *ctrl);
 #else
+static inline int nvme_auth_init(void) {};
+static inline void nvme_auth_exit(void) {};
 static inline void nvme_auth_init_ctrl(struct nvme_ctrl *ctrl) {};
 static inline void nvme_auth_stop(struct nvme_ctrl *ctrl) {};
 static inline int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid)


--=20
Shin'ichiro Kawasaki=

