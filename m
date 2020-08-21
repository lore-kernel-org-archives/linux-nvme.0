Return-Path: <SRS0=kXjr=B7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E2FDC433E1
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Aug 2020 06:00:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D124A207DA
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Aug 2020 06:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ns2Kr3gr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="psBeuVZU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D124A207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AWJc3Xs1uAfUE2O0O0OIvRisr9cCaMxJsaiGSReIplg=; b=Ns2Kr3grNu07im5/3jSt6GAxmz
	8jTb9EyQXhlEQyhtpwlP0U6jhZvJPnSo3HzF4vo9jf9rEEaDeRY7SOa7fXyPZ5lHDtIM1qa71XSlw
	EvXb+pI+85P26hYJPvW6kfUIHiYmqsA5SCIaGllBb66nqG3RKfljxf5ikxM6aziyx09ewpbQ3ATo4
	cZkvL4tQpWOKeePJJtoTKpqWgIhYaJ5GXLh8gvpuFlolPNaxcjBIrJD+eMUNPdHSkL4NwSh5z0HVM
	81V9bEODQgwL7nRE+LZbJx6TvYytEQZaCQREk4EuihNqxRQoAPuy4/ZFU13MURvQdlawp2bgenkao
	nyaixsaA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k906e-0003kW-24; Fri, 21 Aug 2020 06:00:52 +0000
Received: from mga14.intel.com ([192.55.52.115])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k906b-0003jt-3S
 for linux-nvme@lists.infradead.org; Fri, 21 Aug 2020 06:00:50 +0000
IronPort-SDR: 9ca4DVsylgR80eR36clY+KckbK5ZAWZJet9PFuSCUOUofbQ3Bm6aUEJWF2uZLVNbCICRbSnhDg
 FU24QL1Svghw==
X-IronPort-AV: E=McAfee;i="6000,8403,9719"; a="154738902"
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; d="scan'208";a="154738902"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2020 23:00:47 -0700
IronPort-SDR: hoI6JRR+hdSyqe1gEG+71dMW//VPX1eoCHrD+UEP4N6LxW/ZUZ77RejawLw12bQ+u0dqLWcQkp
 sgjJU7WIz/nA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; d="scan'208";a="329939370"
Received: from unknown (HELO fmsmsx604.amr.corp.intel.com) ([10.18.84.214])
 by fmsmga002.fm.intel.com with ESMTP; 20 Aug 2020 23:00:47 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 20 Aug 2020 23:00:45 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 20 Aug 2020 23:00:44 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 20 Aug 2020 23:00:44 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.43) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Thu, 20 Aug 2020 23:00:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kXZzKFlzbyGUWog1rLFotgpy/HK23QrYBHfPftSr/bL5doAcqHv2SEiCfOhPdl1MXK7bTxfgKTgBwYwMLZ0SlLr1dX6a5jlBRJYj0rrqnPViJtYaRPiR+twvMEDkj1cWCpMdL+1Tlu6WDwdiqbWOIFyFtYd95uOLsH5e3jV0bvVhlETfhTQItLYX0v93Ne7XwZ1SRv4Oq7RJrz0MSPcNsibwUGtST4JrQV9DlxdGrPh/+XBF3eii768cIEO6cZJTgWxRz+FeEncUBAyybXV/pppt/gIu+GoUv2IQoj9aClRgdiutMJhGFWCQC3DrhzDeqEglHBMCapTIrilAZCV27A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8v4QrnRr7fM2ZcfSPeqGshdYJY/2bafdZ82GeCUzDQ=;
 b=K3rOcX0ED1GQFwnG7xblSfwxcm1pI1L5sWHiSVKF9AqdxDkE9onhR3xkOsNSmXaiMT2/0HX4rMkXqQ8/tDahAT+I8IQU6VSW9BaoF8Jf5ybvmFRA0HLM1MgUC/u3mqMoe3eGpPbzQYElA2/lZUT7cyXVChWPiScKluey3v4o6wWRfpg1eU6zRIoMRCABoukORw2w+J57mtpUUdYdz91vDQniyFdYJw1XSTWgwepNONtNrHE/a1+F/6PwfPygx7ER/Fw5SU9KuE6yePLERJu5DZcAjDQy0fkg7sQTtnUgBUonumj/KpJkFxRt8B2h49jPjS5qVpSDKxHgnQ25wxGWpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8v4QrnRr7fM2ZcfSPeqGshdYJY/2bafdZ82GeCUzDQ=;
 b=psBeuVZU6coSL7mi3/Qm50+wbRqhJjv7H4YL6KdQytEyX5wL6UMhJLocWdiTKhC8MVPtDrRQG5cWHb3aeXxLi9hPChBqa8rOilVXHsmwBTis/fFwpMR29v11wqjiRsRFrlfuB2s3PgO/RYgNNrB/gzLlbK+qlsvhCxVpJm0a50I=
Received: from BN6PR11MB4081.namprd11.prod.outlook.com (2603:10b6:405:78::38)
 by BN8PR11MB3779.namprd11.prod.outlook.com (2603:10b6:408:8a::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Fri, 21 Aug
 2020 06:00:42 +0000
Received: from BN6PR11MB4081.namprd11.prod.outlook.com
 ([fe80::1849:565d:9454:cdf0]) by BN6PR11MB4081.namprd11.prod.outlook.com
 ([fe80::1849:565d:9454:cdf0%6]) with mapi id 15.20.3305.024; Fri, 21 Aug 2020
 06:00:42 +0000
From: "Yang, Ziye" <ziye.yang@intel.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: RE: [PATCH] nvmet/tcp: Solve coredump issue while initiator sends
 write CapsuleCmd
Thread-Topic: [PATCH] nvmet/tcp: Solve coredump issue while initiator sends
 write CapsuleCmd
Thread-Index: AQHWd4AH+ch4VvYeTUqUHattWXFGsalCEURQ
Date: Fri, 21 Aug 2020 06:00:41 +0000
Message-ID: <BN6PR11MB408118BDE6D42B403076BA57FF5B0@BN6PR11MB4081.namprd11.prod.outlook.com>
References: <20200821150252.40800-1-ziye.yang@intel.com>
 <e87116e2-f633-9656-3ef8-1621367b28a2@grimberg.me>
In-Reply-To: <e87116e2-f633-9656-3ef8-1621367b28a2@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.102.204.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4f437ceb-78b3-40b7-1b94-08d845978977
x-ms-traffictypediagnostic: BN8PR11MB3779:
x-microsoft-antispam-prvs: <BN8PR11MB37792E2509644E25337BE7C8FF5B0@BN8PR11MB3779.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:773;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L9LR7GcYHKtnMFXdMqAu4j8guswxbCzwepDmNkbhiN5ugGytDczJ55wPH6rOzJvj1aFKDQ92ZoE1Fu0kYzT2ly1iR7PxLYY6cUihIHfU2MwVy5aTyNKl7NuyC39Llig2YdXBioKmvwkz5/BoqnalxRcUydx5Ai/t2W7/zXj1zmK8FpSBzxexiBQ8IbRiOZFwHsjKoDA9RHb/hOc4nbL2iVasSYVXsFNVWugLCY2znrL2GF3p2mP06gP3hglE7eKMFsrR1njHPQggy//tzNTESbXxre3d1kYkdE5TrbU69BpyqSAi2sN6VMJPeMfYyDJUcz2cFfigJfiAyqbCGO7IvA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR11MB4081.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(376002)(136003)(39860400002)(346002)(316002)(52536014)(8676002)(110136005)(83380400001)(2906002)(26005)(86362001)(478600001)(71200400001)(186003)(5660300002)(8936002)(76116006)(66476007)(55016002)(66946007)(66556008)(33656002)(66446008)(53546011)(6506007)(64756008)(7696005)(9686003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: MNrkYgVvkM8c8oym0xZ+HzBW3dwj63+pyoLw5pRoLiGMeFGlRAF4ik1ZSIa4TOu7wO5THiN9yD4BxlU6Idstpp3b8llEFqL/E2AdC7cua2omvuKY3SrlaG6lDEjyj3kY4RLluw46xUeTxzOw2bH/+Ya15YLVf2Vq/6bkMNVavF+bur4mgYpKPd1nQ6Estn/Q3Y49F6Dxr1GEZrF9YMcnx1TYD2cwwTlBZJBGsO7IytJPHK5Lr7WBs1OZd+WMN+heG/p5ticXO6W2gKTtExxWgQezbZ95ZnwenW1PbR1vAeWiLNL4kM9RaNAc2wBRq7mDl5mkb1kpYAoOh23EmRS4Y8RNRewzXbsXR4+JSzGeB7YfhaxCstDBm20G9AJXtW10L2G4VZHYuVEC8hmmpNp7M+ag+gEMrBNswueMnBmWyoDskTVphSg+OyndAV8KW0U8ye838Ti5zaATKKMQlwA9dJWdGoacqe2BpsmgjVoIyldC7jcl0MDvm/Ujout4/ci1kujYg5UzYKRU7fMszCDOgohHYIDgRwSmNmdAlboGxNttKNXR9BXYcO1W6wjmx6pxfHl5hNIJqZjTGdOeVFIEVpIcSg2b2kYSuTnmIuGWxEMGhxM7RX02NfYsLgvO0846kyskSzDM2NcbWMsqO4JjWw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB4081.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f437ceb-78b3-40b7-1b94-08d845978977
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2020 06:00:41.9828 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ztefYzEcpk3vDWcXTwVcBl+Ue/FCf/JaRyX5eF4H7bF6U9y4bAfT2UH/oxRYD2dgbbYC4pUfgFZINLDY+pd2yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3779
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200821_020049_640668_8BB7EC73 
X-CRM114-Status: GOOD (  29.18  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Sagi,

No problem. Let me revise the comments and use your commit message  instead. 




Best Regards
Ziye Yang 

-----Original Message-----
From: Sagi Grimberg <sagi@grimberg.me> 
Sent: Friday, August 21, 2020 1:58 PM
To: Yang, Ziye <ziye.yang@intel.com>; linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet/tcp: Solve coredump issue while initiator sends write CapsuleCmd

Hey Ziye,

> When the initiator sneds write CapsuleCmd without incapsuledata, we
		     sends                          in-capsule data

> can use the queue->connect command to handle. If we do not do that, we 
> will have a coredump because queue->cmds are not initialized.

This issue is specific to the I/O queue connect where the payload comes solicited via r2t.

I suggest to document the change log to the following:

nvmet-tcp: Fix NULL dereference when a connect data comes in h2cdata pdu

When handling commands without in-capsule data, we assign the ttag assuming we already have the queue commands array allocated (based on the queue size information in the connect data payload).

However if the connect itself did not send the connect data in-capsule we have yet to allocate the queue commands, and we will assign a bogus ttag and suffer a NULL dereference when we receive the corresponding h2cdata pdu.

Fix this by checking if we already allocated commands before dereferencing it when handling h2cdata, if we didn't, its for sure a connect and we should use the preallocated connect command.

> Signed-off-by: Ziye Yang <ziye.yang@intel.com>
> ---
>   drivers/nvme/target/tcp.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c 
> index 9eda91162fe4..9d3eeb9338cc 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -866,7 +866,11 @@ static int nvmet_tcp_handle_h2c_data_pdu(struct nvmet_tcp_queue *queue)
>   	struct nvme_tcp_data_pdu *data = &queue->pdu.data;
>   	struct nvmet_tcp_cmd *cmd;
>   
> -	cmd = &queue->cmds[data->ttag];
> +	if (likely(queue->nr_cmds)) {
> +		cmd = &queue->cmds[data->ttag];
> +	} else {
> +		cmd = &queue->connect;
> +	}

No need for brackets on one-liner conditionals.

Also, I think it'd make sense to set the ttag to 0xffff if we hit this condition, otherwise we are sending a bogus ttag.

Something like:
--
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c index dfcbc6522aba..3fec5119ec90 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -159,6 +159,10 @@ static void nvmet_tcp_finish_cmd(struct nvmet_tcp_cmd *cmd);
  static inline u16 nvmet_tcp_cmd_tag(struct nvmet_tcp_queue *queue,
                 struct nvmet_tcp_cmd *cmd)
  {
+       if (unlikely(cmd == queue->connect)) {
+               /* We didn't allocate cmds yet, send 0xffff */
+               return USHRT_MAX;
+       }
         return cmd - queue->cmds;
  }
--
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
