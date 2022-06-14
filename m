Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96EC0C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jun 2022 04:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eFRuWMkhj5sqxKfrxn6D/ZwwV+0YiRCLXPwOZheXluE=; b=za5eQRvmaNI6ExQSHJT8lrAcPu
	ErA0k5P0mTwrSNCiV5cdA3rmKf4JBxI2oXfVS4OnOHF6dge30+WgnAVul7tZee+mjXoD1VdW6MYxR
	gTheU2FnuS/7PUGUoqoK7rXsh2550alSMdlB0L+25jlXt9y+2HMCiNHI8hMFivD4ub/IxX8oLWhJa
	aJQArZ04MkCc3IRYHDmB/7N3Pi+QwC7amPKVOAVbvjXWyRl9M2ULx78hKG5mDTEZtNmPQRZzmh3yS
	whR81Ts0OwPZIYvsKzp4dsJvlapdldS66mmgeQBn5vhQYAJvedFJDolEVfHjc2e+aNUKZdSODqCdp
	zzwIErfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0y5s-006zeb-JO; Tue, 14 Jun 2022 04:23:56 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0y5p-006zdN-Jr
	for linux-nvme@lists.infradead.org; Tue, 14 Jun 2022 04:23:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655180633; x=1686716633;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YTnPc5ujyeOQqUXTIWsW7jALOGchOuLhV2JTgurK2h0=;
  b=qZezkEDAmz6MJPhiFpha1qL63O1E7BS6WIqHLX/2gLhFu31orSXQBHNp
   D9SL/jDHJfoKF/QLmuLkaMYzZ7iPRkPOV1GgxCgg7+EFjBiYbCzCVjCzh
   bxrmCHpflNDK1UKzERIQjgVB/bKlIgBZV1s3v7O4LYHbD4KM3vkYyDx7K
   UpOFvMpqgQ99sbOtmDTsdIV0RPRzHaVlKrzWzJIlmkWzZAxcpHLBtvYZa
   vQtCTXRBUz0zqLKXUujKFhnaAcqt3iv47YjWt8I2uD1+QloB4JmuaVrjB
   LzXCtOM53cKrfkshpOLnbrtRW3hZaabb8bcrcIqxEQao/Ms4K47dvwqOs
   g==;
X-IronPort-AV: E=Sophos;i="5.91,299,1647273600"; 
   d="scan'208";a="207916056"
Received: from mail-mw2nam04lp2173.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.173])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jun 2022 12:23:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AdAnlYsoVpEVGUz+lEIgEBxwKGDtcpcgKIPDvZx6/FVCZexbGDB7lPP521W3fPdaPeY9ueTF/E8wNGDmltFAhan3Omm/aD7rGbVOJq5EABehyW7dmva+vWojDYi5w1UZl+oX5C66IX6zkEJYFDdgjiM5y/SaVDBS4HvL1qLj9u9G2b748yU6bo5Zmebu1SiqB4judTM51C4boEu8qtfTsOTitc27UivGDEkNIMIyzKngbTAT9qUUdc71/+rJm4fRMOIGsZe+wlTUM0ewAXmubOX8RAjyFDT5vkqi2NTEMovupxw7SjB3kIIRvz3sW/eKCDrEgOjrFYP8jPigHeqTRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eFRuWMkhj5sqxKfrxn6D/ZwwV+0YiRCLXPwOZheXluE=;
 b=eamCSb8PlGoXnvUgqF/EV/rqbtT+zNnkx2hfhhNSUN3aoN5lUbCNiuIT3BLY/beiFhxiji4DevA4HUt2X/TSUET3eresdgF0W2djOmOSWnMyOJPn+w2y1QceLCX2owaF465HLh7STqCZdFOAh+YGB77crKoJYc5QPDNquTPU4bLtRWfKsLiDLlMroJIJmeYU5WhpV9tLcFLUdRc80fvCksefT/02f506iXsVT5gsKYRngz7/q6mfmwmfcb0FF43WxJ6LsyvJlTUWhV7mNEYex6Wz0eJMQ4BiIk6ujToAUehfXUeBwUXg0UC6n2TOXbe8AXNcOtLuZ2xhGEvzhpvE3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eFRuWMkhj5sqxKfrxn6D/ZwwV+0YiRCLXPwOZheXluE=;
 b=aWtWpeL+auEZJi1XuMBkxnPUOEtZ572e3Gj6/RyZWecdgEuKG4gsJtusZlpkovL+cBINyqkAJlx9zC2NIE6/YSSsMRvV91skttSYY2g4wPJO6zqp28a2khrm3LrkVnEK7RMhYM0IlBOPf/Ujh5+kOW9HdXzL4moVeBif0bA10YA=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CO2PR04MB2230.namprd04.prod.outlook.com (2603:10b6:102:d::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.13; Tue, 14 Jun 2022 04:23:49 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7%3]) with mapi id 15.20.5332.020; Tue, 14 Jun 2022
 04:23:49 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Hannes Reinecke <hare@suse.de>
CC: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Keith
 Busch <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH 05/10] nvme/rc: add more arguments to
 _nvme_connect_subsys()
Thread-Topic: [PATCH 05/10] nvme/rc: add more arguments to
 _nvme_connect_subsys()
Thread-Index: AQHYfL3uG20QMwQyGU6XgkO3eIXAr61OU5oA
Date: Tue, 14 Jun 2022 04:23:49 +0000
Message-ID: <20220614042348.jb3i7wjmbbzdfmxn@shindev>
References: <20220610113324.10294-1-hare@suse.de>
 <20220610113324.10294-6-hare@suse.de>
In-Reply-To: <20220610113324.10294-6-hare@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ad4c68ab-1a4a-49d4-5bfb-08da4dbdae2d
x-ms-traffictypediagnostic: CO2PR04MB2230:EE_
x-microsoft-antispam-prvs:  <CO2PR04MB223043C79EEBA58CBE660AA5EDAA9@CO2PR04MB2230.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  Zr9wpDBjjbtyNNHLKqOG+FB9IG/pkanh4uspQtDfJtKRcM6cUkAHIcmu2HL3GWVU5gqTDeCwfNagSKzmRTEmt0P3po1PdK4FfHDJeLAZkxfq4XakF6Yb1QttyXz1t36+gkYfFNrCOhvEKAwDqGQMX9o+dv9S0JG1s8CtZRnCJqTqPQ03oz/zZtBaEHEI3+RWHMgKRni7MPO1BNVyFjGzCrSwIPRnNUwl4Fa9npMS91Vzn+Qsjxidav5e9KRFkjfXI9bWE8fpr4LimxNDYI+FX81faPMQvYNZscNjfnTZaOit/Wzvwy7g0TmSigwkyk7KVpO+SROSgWkMJ7CuR9n8V85gnM7cPA6n/ZImeNhC0plAnSp5v8MTSChMx2z4Iq1gT67KpR4TINkO0UpYUlmhoxVOuzKawS5v8r+5U0fMDEsWN5TLMximye5yFrU+ZLsCn3O/q+0Ewm8NAKPHbBNs1fsvEN5gC9Cllke4onjIlTyVG6zDXQ/aynLwPv+V3a1OJb9QjHUh4GeIbaOQx3JT92LOy0pwIkN+CrHMOU3wfDZyDolPOZ7hp49Z4Dip25ibb4OhOQyeh3S/IWKvZTB0Ljqk8HPG1SQQLmTp29tn3hjY4a6dzv+CBYa/NqZ50LUQFLiPf8mHM6yXDA3ZmZ5WX8IkW5C5YBDqjGrX68BCN96XjJpKC3/P+z9jQFcwT4e89S9xsiKohN3Vzd4t547KFA==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(366004)(8676002)(4326008)(5660300002)(316002)(66476007)(64756008)(66446008)(66556008)(91956017)(76116006)(66946007)(8936002)(6916009)(54906003)(44832011)(2906002)(71200400001)(33716001)(508600001)(6486002)(38070700005)(122000001)(9686003)(26005)(6512007)(6506007)(86362001)(1076003)(186003)(82960400001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?n8hm0MYUblewnCNJxn4PNNMemUloR2Ee1wTm+zKMPjXF3EBLt0efQVv/Q1Xx?=
 =?us-ascii?Q?VHtk9uBf5tsV6YsQGskljFvJeHDCQmv4z2X01r+MENRhieoRhwPT2w1zc31q?=
 =?us-ascii?Q?lUzFLDiHynBgxNj1pKmEGWg97fTB9f2t4+WDD1mCGhx/EmS8y8+JpG74cFZo?=
 =?us-ascii?Q?RF3j9joMQrWsVjLak2Y2/qgu91M21nzXluHPqzfa2mD+QbSGiAOjW51xa5Ql?=
 =?us-ascii?Q?Rrb/cjktde/ftLqbY10GZryx1LkQbGgSL6o81CNh/7aLHHoBbXeqDx1BpT5H?=
 =?us-ascii?Q?8Fy/PudjCrrEBy7Udr/Jf9loYZn/JqmIUu5Rq/ZwC3R3CbWWCPP010UM5Niv?=
 =?us-ascii?Q?8ty0DBcUAKZx5NUxdqmtv4mqzGzTXuDZtd+Zyi+gkCIKZeqD/cPHFRCN+lxG?=
 =?us-ascii?Q?0t3qJ+xZjPye1NiOa78/FWG7i/rLDoWRtUdxqrzijXCaIFoQXAJBh42BAOhn?=
 =?us-ascii?Q?mBrVGnGa7x5/tNoGD79MDgr4JfxKUtqJ1hCBtcXMar+UtNm2RqHMsOUibzfc?=
 =?us-ascii?Q?amsPT3ADcHExrhKO1i6dOKYgeHxZ3gCp3++fSSMQvfjszcIxMkMYy+a4BGbD?=
 =?us-ascii?Q?KmTOTDuBjNd03i0DjoMLyHqlUaxEZJA2dkIv0f507aP5cFKNS/ejMWJLHJSi?=
 =?us-ascii?Q?Fn0gN256thDBwPFzQsLO0JAyqot7fr7BrWH9m5kILuCexV8/n92m+1TD0h3a?=
 =?us-ascii?Q?rJDN9MqO7W7XW8FXYV6YUwxjUI8qe0eHfl0YUMuQelYyCS0yoQq/cXENMzW6?=
 =?us-ascii?Q?J4Q3/SyPzhWsrBd8NjU9f5X6Ub+1pHdEM8AHkuqZGWjxoGCDL117qP2n6JnI?=
 =?us-ascii?Q?7HB15n9GR0shhl7RUpZq41+Vx7P8RN5/yN/fdiXW0iVR1CxdtzaeQgLHGub9?=
 =?us-ascii?Q?C86s6qNN3ziRobMDkJ8rhLblcq95D1mxd6BYEkQCf2DtWyrYRLdInf622bfQ?=
 =?us-ascii?Q?l7tN2Ke7Zrp9tbqVtnM+Fvv2EFhPv5MG7rowOgoVcP0qMYjuvig96t28KTyg?=
 =?us-ascii?Q?9u2NUiETfSXAvcvr8pn7VkxtrzWOA7l0KtFNSYUnk7Ba4jZUvcmKhJVCbyee?=
 =?us-ascii?Q?RmQuqceEFi0MwlRHadrCCCh8TujQCXRvWoXKumrf8fqYHBl7mpkmU7Hlamc1?=
 =?us-ascii?Q?sMg4i37peePmASk7N46xDR1jXPeoi7xLGAfD571t0iCLIhLlnMQrd4DT/eYF?=
 =?us-ascii?Q?Y7fLZb4JbmJ1cg/2+6Yir4n/tvYllkRN/b+Gpb0JhW0Pz/bHeP19aIdY5+TN?=
 =?us-ascii?Q?L69p8D7UmoQeJB/2DdFwCS7VFsqb8rjqIyatV6a0P+7LXbmtFQbS2YNPfdye?=
 =?us-ascii?Q?n2a+CoQe4mlOW/ADa55PyBagoxq6/g4xcQPdWd8Vol5PefhjM9+CcqSuVIsb?=
 =?us-ascii?Q?rvQ1XmmbV6JXYDSMtJjA4SH73QquOld+0zJ9qlu1Zzgdi8lTGQVX7EoSrz+n?=
 =?us-ascii?Q?J64qbZ0uEUis9/Ghd8piqrxV/xsdqn3Ldxw0iEMeIqGGJAug/Y3MvCwqViNt?=
 =?us-ascii?Q?/WZciY1MKJJ49y5/PWzeOlrXhjFi3+pBjxncVvJ7D1JcsEXMvy6BK9d+REhk?=
 =?us-ascii?Q?OlI3Q14+8cOiAZLcQ93L31k9eAfYod13KGA7HC3Ek0+NWh83jGmbtCe19Q+t?=
 =?us-ascii?Q?mXBroiZPGOZw6rBpD8YjxA+YbNGXLygjQKXfNzqC72oDLNm2a8r87K9IZStM?=
 =?us-ascii?Q?p549aFjhYQvzk72tClV5ddINeqLYOqrQmX/QQKWCvgNTkM4/0JrOdwhcd0kH?=
 =?us-ascii?Q?9eXyL5DDKIT4FyOPGvIeqKBpss80LzK3eHJrhwpbkCRjFYX/q8xH?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D79BD745202C8A46ABC8224F41AC5D90@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad4c68ab-1a4a-49d4-5bfb-08da4dbdae2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2022 04:23:49.2087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IwPlafyws497GqpS0ZQEQVnVYLHQOr8EKE4fsb+DpuHYoGqVHCin6un9KeijT6UKjIEHbi97u45VFh7vq6Uu3qVVoPh3bz3EsA2JZpeh66o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR04MB2230
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220613_212353_748921_6AE22683 
X-CRM114-Status: GOOD (  16.96  )
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

On Jun 10, 2022 / 13:33, Hannes Reinecke wrote:
> From: Hannes Reinecke <hare@suse.com>
>=20
> Add optional arguments for setting 'hostnqn', 'hostid', 'hostkey',
> and 'ctrlkey' to _nvme_connect_subsys() to make it usable for
> testing nvme in-band authentication.
>=20
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  tests/nvme/rc | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>=20
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index 2873037..b7bb3cd 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -190,11 +190,27 @@ _nvme_connect_subsys() {
>  	local subsysnqn=3D"$2"
>  	local traddr=3D"${3:-$def_traddr}"
>  	local trsvcid=3D"${4:-$def_trsvcid}"
> +	local hostnqn=3D"${5:-$def_hostnqn}"
> +	local hostid=3D"${6:-$def_hostid}"

I can not find def_hostnqn and def_hostid defined. Did they slip out from t=
his
series?

> +	local hostkey=3D"${7}"
> +	local ctrlkey=3D"${8}"
> =20
>  	ARGS=3D(-t "${trtype}" -n "${subsysnqn}")
>  	if [[ "${trtype}" !=3D "loop" ]]; then
>  		ARGS+=3D(-a "${traddr}" -s "${trsvcid}")
>  	fi
> +	if [[ "${hostnqn}" !=3D "$def_hostnqn" ]]; then
> +		ARGS+=3D(--hostnqn=3D"${hostnqn}")
> +	fi
> +	if [[ "${hostid}" !=3D "$def_hostid" ]]; then
> +		ARGS+=3D(--hostid=3D"${hostid}")
> +	fi
> +	if [[ -n "${hostkey}" ]]; then
> +		ARGS+=3D(--dhchap-secret=3D"${hostkey}")
> +	fi
> +	if [[ -n "${ctrlkey}" ]]; then
> +		ARGS+=3D(--dhchap-ctrl-secret=3D"${ctrlkey}")
> +	fi
>  	nvme connect "${ARGS[@]}"
>  }
> =20
> --=20
> 2.26.2
>=20
>=20

--=20
Shin'ichiro Kawasaki=

