Return-Path: <SRS0=ZZT4=DF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7D0C2D0A8
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 14:35:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9990A2075A
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 14:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OvABmymf";
	dkim=permerror (0-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZKiVMf3Z";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="pNx1QvD0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9990A2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=sgHPyhxETf/XlrKxHCon1Or1egPrV8a5WX2ryMoCSIs=; b=OvABmymfuRZVFiwtASzB7I1zv
	27VI9kqIm9Tg+eFIlRzYYlqmHSrM8TPGWBI/mYXHm2aSZKf9b7YX4JiNAqdyhsjs6DIsgw4MD8gfm
	TcMmTVwVagPl+QZKo807l/QubBn5BEeeHgIeTcxikLiloRRvX+VPACxolKrmm+O/ES8X0eSZmMoQz
	HF7h1rSHeJRpkHzQ0Rf2S0yeHs6MVpmI+uKHoQeUkWMhYqAVAHBkOwpUPa9r1lZ9HCs8GzvNeAwG4
	DhtsQa7J+x0F0bJFjoeQnkQuQz+tkesHHtRpjWDPAHOrPlAX5O2b/K7MPCRZ8SzV8a6httxFwmcqa
	ao/sBnBDw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kMuFF-0005Pz-4e; Mon, 28 Sep 2020 14:35:13 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kMuFC-0005PT-L0
 for linux-nvme@lists.infradead.org; Mon, 28 Sep 2020 14:35:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601304217; x=1632840217;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=W+OTcTmcDsCYKIHVSwmAL0V1CPC36H6M9yztXruAGV4=;
 b=ZKiVMf3ZmerRtKYIBygnFm/8kvhiiaBwjLR6Ps4Yxv1MtgKNAhgAxHhh
 Rg1EXK5Fl8GIJF6PixKzBOXNoAck2O61FS9ebwlUuEm7Dz1qcDA5o9/nm
 QDfH/YF2Bj9m2UU+HAO7+6bDwe+tthoCfSaF3zQqed5Zka8xMK4x51yfN
 ywtsts0BtynMiRovKT6isV4R8IDQ+KAggshaHrNWLfnnBH9Bh+CdXjckF
 mFxi1cZKsYbzInqbDWYQIFhUMblzBcIjT5fYp3vKiLMskmSLTF+vRIad6
 IoLDSv3BPsA/b/rsgFtuNzHGPiaX+w3l7aKp5COoRHhXvPKV49VLNlGYR g==;
IronPort-SDR: oqofZ00TYo7YwXe6Ewg2HoA+TzRAB8XKlPHG5A86d/tE3wX/dCnT3wTX1K25o9ZgH1C6Ry5m+B
 yxx6a9jRtjGqOPmeLuyAc15i6aA4s2HKWmwPzfCkHm2XtPzoCVTY+t1ZoniTjoCcJMKqCHYcsE
 GM+UxHDJtyWl5SjGdds+KuKtxDl+jJ6F01FmT88MBHr1Zfm4Hr/r2OnAA5YqwzpwdSpsVbJuSQ
 g2g63OIWO9JX5pRcX4kmRTRZ0ZYpsg18VsdNAlyaBV/38cfaF1M91nMoT3MIRWEXlb92NdWwF6
 4eA=
X-IronPort-AV: E=Sophos;i="5.77,313,1596470400"; d="scan'208";a="251843832"
Received: from mail-mw2nam10lp2102.outbound.protection.outlook.com (HELO
 NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.102])
 by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2020 22:43:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LSvbvOto77C6QoqKls/73M3FV2Bw61E/k5kUK3ksJn2ke4R0wn6v8sq/a9wtKK1Q5lmf7bIdm3CMPDzo83y+KEOIHAPk5/7Xsb5OMOkpD/rFaMst9/stAv8j3nkgrkWaM9UwrSznVFdwv5CWiKXEKzA1gc1JDjUaIGpst6LskF5BjTy8pYKfBnkmZSzslyCI8I+pje98rToIuP0A4A5sy7LIRlQ11go45uGGsl94ieFHlZF/rpu2GLMZcHcZXX7iYG2KdQeyKidqfw5aaIRvjyhB1OWiaiMEIjIMpCuG8dvVz0DZjP7b6ZDJw1TlTKWkMxVb3Kmicxhq9Is6Y0IbGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uUjhIJWaaRLdj2nV4RAnaSFpJhSo3I4HU2/74be9r54=;
 b=B+rTGBk5ugm2jPtXkFTUG54iO27FkUZWRzrqUQ7ymIlEp3D/Gh7K9SRbX9AikkheLwW1G9S9uUUiXtfYhxHnw7mBSs6l2BYVGR/OVPhYMOPA/iYyjbydLg+mZqWq4ZTyc86XnOc67oH8ZG16ugy25QTGVH9OWClILx1AsN7Xe68g8hdBp29AjazCFyOUVNlKSdUPRLjwKfxIf3DLTy8vTfXwxJ0V1BzPSXDhT0Kedhleq6v7BFtqBs9zmWa8LZ2AVR+BP7Usr7RGFBYctDFZQcGsNLIK7dsE3PXJ0c2v2yXDbjU9GGocqbE0h/hi4Eb9jOmkoVXvKDIvm2vYZf+weA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uUjhIJWaaRLdj2nV4RAnaSFpJhSo3I4HU2/74be9r54=;
 b=pNx1QvD0PMB+KxTtN/4QYEutSPXDUqrwlCUpJpO0vjeMIMTbnvbNdo4UKWJh3krO/Dw4dNTgwvsXFlwZ7NH3EQ+KdOSJsaMTy1Et6ciCAOpz8KQyX0MHFA3V/EjjafzeiOEGfMD01uPKPYVWp2uTPYJPM9iEWSvxL6Iq2gE53bw=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB1031.namprd04.prod.outlook.com (2603:10b6:910:51::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.28; Mon, 28 Sep
 2020 14:35:08 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3412.029; Mon, 28 Sep 2020
 14:35:08 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Christoph Hellwig <hch@lst.de>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 09/20] nvme: factor out a nvme_configure_metadata helper
Thread-Topic: [PATCH 09/20] nvme: factor out a nvme_configure_metadata helper
Thread-Index: AQHWlZPYNLApV1bOFkeBFPGNGi9FBg==
Date: Mon, 28 Sep 2020 14:35:07 +0000
Message-ID: <CY4PR04MB37514FB2D8E2D95657F62022E7350@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200928123502.435373-1-hch@lst.de>
 <20200928123502.435373-10-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:809d:4e2f:7912:1e64]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cf66c95b-ac2a-4471-33f8-08d863bbb2ad
x-ms-traffictypediagnostic: CY4PR04MB1031:
x-microsoft-antispam-prvs: <CY4PR04MB1031347723F6201B68C89A73E7350@CY4PR04MB1031.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /lqnRnJvVcRryvE6EPvretHJxkfozi8mNZUP9G4tw00LJXPyit5V5byla0tTuLWVfdmCWkrn/C6jLhNF9XPK29APXyAZu4WDHsAU3Ge7U3oPza6JFjMA3gEUinwYxTDURmfsnepfv6ptJ30qcj9pSa7sP4j7jqOl+QpKWyoGrrMqR8Ir4n06UQXHCZELvq3/ivBgeCpaxmxVQqo/X9Vfk4NVhs5qSAP0YtPqzPfe/ze6CVLe21zZpcGt/qAWO22+PAAbZgLmO/bsz0q6day6KtkdlKyDkq/F5/4G7nf1jiSTGQnfaF49dwB42V3WF/zOcXrb9irAbuPaePu9TlsgD9E6lpU28XmewK00pjJZwYt8tkjQv5Flyd7bsE+NVZTk
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(346002)(39860400002)(136003)(366004)(52536014)(91956017)(478600001)(55016002)(86362001)(33656002)(186003)(53546011)(8936002)(66946007)(6506007)(76116006)(4326008)(2906002)(8676002)(66556008)(66446008)(64756008)(110136005)(54906003)(7696005)(9686003)(66476007)(83380400001)(316002)(71200400001)(5660300002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: J4Uplwh+DDFu5wuyaUv72rlzS0T0E2r6+GxlcWR4Q76hJ0eBfgpvJne0eekHXroeICITCTb6IRWP/72Frj3YVthDqeo+BKkHHr7gU4JMW0wlEFYbRqBeEuRukt6RY3mXYGRezuAw8nw4maQprjYBakfJ91MJmVkZZbLpRGBquwszcdoPzFTA1w0jR4JEqZPRyzYkreQ5LU2R0ws60W4xp+veiPl7FLVoGD9HuKXGw2lEKqEDGPiNJPKjfSBXRTg4XyaihHHhjKFTd4BQ7xF9aJwiqdpjtUnnyLDGy8+rIaJTbJW/hv05gvlifK2FZYSIxfUWea9hfUI+3Zq+3uP88BriQJiOYSoWP0xeFow7uH/TSL2JG63XtWatI8ddlosGzVZcWdnBq5wlbC8T8Q9fuoDZRVwomd3fYZydxdUF5B07KN/wa/pJJAva6MiLE+/QQc+uDwvRWvaWdZ3VADJFXAN941sJ8RtzW8kQM59COFfDnsBP6YFxH1zwcoTs+1GmeeiIvMmlLVWbYdzSk6ECnqVNWWeRP5sdS0Nh4QVI9NNZPYNnArY0nm/Ont5DbYHaabhD/VxxZclK5DM5WZzonlY15gKIX/YPHE6Q89it2c9YmtzDCXhOYiPz4QnfO1w+bVWPTIm4/4iSxCqrhktdCR2acKQlgmL3z1/OamqsCUUG9YM7uGxF71mq3mBDQ85RtmVZI1O89MywUgIgaF7Reg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf66c95b-ac2a-4471-33f8-08d863bbb2ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2020 14:35:07.9155 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bChHioD7YCh+tTx/wmUMfBacdP+iCpbEoxbuvihZRF0ZQf83L6/c/jk9wP8/of45xcUAGJmppKrV0sdLTrPh/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB1031
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200928_103510_849882_66A47FEB 
X-CRM114-Status: GOOD (  24.61  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020/09/28 21:35, Christoph Hellwig wrote:
> Factor out a helper from nvme_update_ns_info that configures the
> per-namespaces metadata and PI settings.  Also make sure the helpers
> clear the flags explicitly instead of all of ->features to allow for
> potentially reusing ->features for future non-metadata flags.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/core.c | 78 ++++++++++++++++++++++++----------------
>  1 file changed, 47 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 4a5c4d45755b55..443aba9c9fdd11 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1966,6 +1966,50 @@ static int nvme_setup_streams_ns(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
>  	return 0;
>  }
>  
> +static int nvme_configure_metadata(struct nvme_ns *ns, struct nvme_id_ns *id)
> +{
> +	struct nvme_ctrl *ctrl = ns->ctrl;
> +
> +	/*
> +	 * The PI implementation requires the metadata size to be equal to the
> +	 * t10 pi tuple size.
> +	 */
> +	ns->ms = le16_to_cpu(id->lbaf[id->flbas & NVME_NS_FLBAS_LBA_MASK].ms);
> +	if (ns->ms == sizeof(struct t10_pi_tuple))
> +		ns->pi_type = id->dps & NVME_NS_DPS_PI_MASK;
> +	else
> +		ns->pi_type = 0;
> +
> +	ns->features &= ~(NVME_NS_METADATA_SUPPORTED | NVME_NS_EXT_LBAS);
> +	if (!ns->ms || !(ctrl->ops->flags & NVME_F_METADATA_SUPPORTED))
> +		return 0;
> +	if (ctrl->ops->flags & NVME_F_FABRICS) {
> +		/*
> +		 * The NVMe over Fabrics specification only supports metadata as
> +		 * part of the extended data LBA.  We rely on HCA/HBA support to
> +		 * remap the separate metadata buffer from the block layer.
> +		 */
> +		if (WARN_ON_ONCE(!(id->flbas & NVME_NS_FLBAS_META_EXT)))
> +			return -EINVAL;
> +		if (ctrl->max_integrity_segments)
> +			ns->features |=
> +				(NVME_NS_METADATA_SUPPORTED | NVME_NS_EXT_LBAS);
> +	} else {
> +		/*
> +		 * For PCIe controllers, we can't easily remap the separate
> +		 * metadata buffer from the block layer and thus require a
> +		 * separate metadata buffer for block layer metadata/PI support.
> +		 * We allow extended LBAs for the passthrough interface, though.
> +		 */
> +		if (id->flbas & NVME_NS_FLBAS_META_EXT)
> +			ns->features |= NVME_NS_EXT_LBAS;
> +		else
> +			ns->features |= NVME_NS_METADATA_SUPPORTED;
> +	}
> +
> +	return 0;
> +}
> +
>  static void nvme_update_disk_info(struct gendisk *disk,
>  		struct nvme_ns *ns, struct nvme_id_ns *id)
>  {
> @@ -2115,37 +2159,9 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
>  		return -ENODEV;
>  	}
>  
> -	ns->features = 0;
> -	ns->ms = le16_to_cpu(id->lbaf[lbaf].ms);
> -	/* the PI implementation requires metadata equal t10 pi tuple size */
> -	if (ns->ms == sizeof(struct t10_pi_tuple))
> -		ns->pi_type = id->dps & NVME_NS_DPS_PI_MASK;
> -	else
> -		ns->pi_type = 0;
> -
> -	if (ns->ms) {
> -		/*
> -		 * For PCIe only the separate metadata pointer is supported,
> -		 * as the block layer supplies metadata in a separate bio_vec
> -		 * chain. For Fabrics, only metadata as part of extended data
> -		 * LBA is supported on the wire per the Fabrics specification,
> -		 * but the HBA/HCA will do the remapping from the separate
> -		 * metadata buffers for us.
> -		 */
> -		if (id->flbas & NVME_NS_FLBAS_META_EXT) {
> -			ns->features |= NVME_NS_EXT_LBAS;
> -			if ((ctrl->ops->flags & NVME_F_FABRICS) &&
> -			    (ctrl->ops->flags & NVME_F_METADATA_SUPPORTED) &&
> -			    ctrl->max_integrity_segments)
> -				ns->features |= NVME_NS_METADATA_SUPPORTED;
> -		} else {
> -			if (WARN_ON_ONCE(ctrl->ops->flags & NVME_F_FABRICS))
> -				return -EINVAL;
> -			if (ctrl->ops->flags & NVME_F_METADATA_SUPPORTED)
> -				ns->features |= NVME_NS_METADATA_SUPPORTED;
> -		}
> -	}
> -
> +	ret = nvme_configure_metadata(ns, id);
> +	if (ret)
> +		return ret;
>  	nvme_set_chunk_sectors(ns, id);
>  	nvme_update_disk_info(ns->disk, ns, id);
>  #ifdef CONFIG_NVME_MULTIPATH
> 

Looks OK to me.

Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>

-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
