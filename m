Return-Path: <SRS0=CsQm=XR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E223FC3A5A6
	for <linux-nvme@archiver.kernel.org>; Sun, 22 Sep 2019 05:37:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF3F02070C
	for <linux-nvme@archiver.kernel.org>; Sun, 22 Sep 2019 05:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dw+ANiw4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XLgTy0uD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="bVMpISGs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF3F02070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=offrl+SBJNeispTyMSBKVG7434Ev/sfCWbISOuJgHog=; b=dw+ANiw4ggs1Va
	8EKC1pkGbqoITX2duGCpRy1fGGYjNNgYRsH8cIIWskGssYHrAX9Q7RAxrJEm6U7rhIoyx0OGHpo1g
	0b+68oWeuSRdenYDQsjnWWB1GOPPr7PMOdgy16JP4qjLiuvRXVfkd3Tza1No6MWDYZHrX3Vb8KY2S
	NDAjzyQR+92ZPdrg+hVXZOt98nPAj5V6XafT0A3GvIX1mbUr02ClCtB3fEhyLx9BzLv6CvM8LJDDC
	gIk8SfHGL09O4zhPAlNhM3LaCvsqx8xWT1ERIJn8+4Q5X7xTZOKGHdHGWMHKn9slP7DjW9AmIhYxk
	wiCgG2nejeYJJ9AhdZYw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iBuZ1-0004rZ-SB; Sun, 22 Sep 2019 05:37:40 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iBuYv-0004q8-3n
 for linux-nvme@lists.infradead.org; Sun, 22 Sep 2019 05:37:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1569130653; x=1600666653;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=YET4FDyMbNSLBFWCBIakfHBryDtKNu4VpSrxYojdttA=;
 b=XLgTy0uDp6E0V9ju8foYePKXeBUpR8GiUXky750uK2KMzXF4STdZWXkO
 G771V8NrtRWbW/nNYJFnuLt7QAr4V0++iOoRvHbTYsGsVrOge0rKeTdbh
 dwrzNvbc5WTd9hQO8wwb6pvEH7WDjncu5KxwZAWOsCwgh4VQD1or/VDNZ
 FCncSxW5uwqgcbYv0+NykGj4CoFf2oQP8RehN90Jv5tHfsDwDEhN6v3cu
 NgJCKc3364Q668PWKR8efcRJLltOrj9XM1QBkxcfykgZPTnli0Q9aCHFx
 p12h1gWpMbRZWgbA0s3DHOaYCiZI8E0w3qBXOvMyz8MC9AcRxikVzLKCC A==;
IronPort-SDR: SNqgkrwOCBgcBmqWXulRa3S1Aq8z1EFsPcoPUQNI9AeSvBjUsEfl6GOoC4VjaWzorhkgt6LlYG
 Kx6oMdK7EV0be7eoM0cILFop7ilaGewkY5OdiitkGCpoRQhWFx4eiVoiZmXIjSBkuoXcYy9TdX
 IAf5dLnpEbTxZ/TtGp9O9SN8Ggc4EIWQrRhIPNnLPMkZ4Py1sYD1OVpC9vsfHmCAQq7yTcqAWu
 XwwiTe2dXhJdUUkyC83wJ2k2Tu5hbNewajpx1B+ArrQWhcZ4ibsPOiygDRkUvDgtAsS/4cWupp
 /yY=
X-IronPort-AV: E=Sophos;i="5.64,535,1559491200"; d="scan'208";a="120396924"
Received: from mail-co1nam04lp2057.outbound.protection.outlook.com (HELO
 NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.57])
 by ob1.hgst.iphmx.com with ESMTP; 22 Sep 2019 13:37:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NkxLgpi+mWSw2BtRdT69jOOCEAQLsmhqtMAGQaBImREx0RP94L7snUV0N9sBd/4miRz6hER6WltF9PXr5/0wRI6cVUWu2Uz3rKPvnW/jnUeeIi+dOp5h3vJZf9q9aqaX29YOmZhdS1ePN+XYJ4SRMypVyoFjpgqZz0qxUBLz3nn7+TM2BgNzlhjSiH8FAgDaGmki7od7t2Z42PnAnuYCWEtF10mh3j6533YeVmOQqBFtgVJ5OJoSehh9CJ5nU2aen7Kd7Dr5e7x/c4yT07HYOmi4jFZ6wU8ifaSumisTV13LkhD+2uf2N7FgVNvVBQ+gktms5MHv2UxYIQE82TKcdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1DSOeF2c06sghixFldDEkTxHGCBFO+TvOkSqidPhboU=;
 b=GrZn18M3PqZwEXBPmzLb6Rm8C5JkCFtryFOEYRDFrbwiyvGJPG6ZuEe/4ryXo26D/pu+6pbDKSvu88ln4fz1+WgQAKCL5tcLMadtiwyihwmJ0G45pNJ38k7TaS90cASTnsjJxXy/d7zWn/Q6Sd5duEAV5t2skdNsjSpfFst1pHN6AKlHxryQxuG11Mysi12FTozAr8cb0lYWyXXfyaMoSWHcXHEPsz0/l0CWlM5qjrowiISJalhwAGb0tO8DK3nJalZ+izEMCWG65ToYWYoT9qiMhtnF1qBmuQTHhPgp4ktH8GAx/cCAHK6fLtft7Nm17FFOcmgVPet0Htz3MwORBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1DSOeF2c06sghixFldDEkTxHGCBFO+TvOkSqidPhboU=;
 b=bVMpISGsH0hzUO9WM34Q89h9/yP4lqkjRtXfBBTlm9uE0MGW6PBLnF2p7UcrsLaJF7BQryJI57gJ1OD+cO0ZvPlPlMzHDoe2iF9BNOeHpR5cBniTRUkQwn1gh6eLn5bV+cQg1EMnC2IGlNS3h9SsIlpRFi3HDHVDsw0OrzMVN2k=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB6102.namprd04.prod.outlook.com (20.178.234.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.25; Sun, 22 Sep 2019 05:37:30 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6169:680:44fc:965d]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6169:680:44fc:965d%6]) with mapi id 15.20.2284.023; Sun, 22 Sep 2019
 05:37:30 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 2/2] nvmet-tcp: remove superflous check on request sgl
Thread-Topic: [PATCH 2/2] nvmet-tcp: remove superflous check on request sgl
Thread-Index: AQHVb9/Q+o+P2IWxE0GpFn/PPbowag==
Date: Sun, 22 Sep 2019 05:37:30 +0000
Message-ID: <BYAPR04MB574995E9BEA354AC196523CF868A0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190920181818.14424-1-sagi@grimberg.me>
 <20190920181818.14424-2-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db41d2d0-133a-4ece-dfb2-08d73f1ef631
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:BYAPR04MB6102; 
x-ms-traffictypediagnostic: BYAPR04MB6102:
x-microsoft-antispam-prvs: <BYAPR04MB6102CCA37FD972562C7A585D868A0@BYAPR04MB6102.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 016885DD9B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(366004)(136003)(396003)(376002)(39860400002)(189003)(199004)(6506007)(53546011)(76176011)(81166006)(110136005)(99286004)(5660300002)(316002)(54906003)(478600001)(71200400001)(229853002)(71190400001)(33656002)(6436002)(66066001)(6246003)(76116006)(14454004)(305945005)(66446008)(7736002)(66476007)(55016002)(66556008)(64756008)(25786009)(9686003)(66946007)(74316002)(52536014)(3846002)(14444005)(2906002)(256004)(4326008)(8936002)(26005)(486006)(6116002)(476003)(446003)(102836004)(7696005)(81156014)(2501003)(86362001)(186003)(8676002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB6102;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sbBol1cHpahS8XRPZ55cXA2mXBxI4WBd+dxZVCDNBukEYiz5JLEmDOOE4Zdx7NYEUe4gPhpYJGqK6bDmMSn/mnmxHgj/eJMoJjYYAJZB2+TfFGFpaUnoh8JKIm6XxdNyro6elOUk+wwvKjETDvXE2WWOLqr+nMK5kwnHs397sEmcYtgWRQqJdC+ns5yrp8nnf14IQfmy3AZc1Y/hsm6BRBllNyG5Wr3089S54xa/65zGHAuRER0htduC4HMuyrVNOUkcPiG9wCum9u+tZ8/Z+3+cABy9viYq4PKM+Q0p/CGrd6kiI/bpGij+J8ciVUc20G1DqpmGCrbRsB13Lble1mZ3BrmCNxDW3/rQwKf0vXPNC/SQAScGm4vpa59e3rBKGKVGcMYIO3JWTC1OLvqF2JLGmC/BZo3NOO1l+pPOzTg=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db41d2d0-133a-4ece-dfb2-08d73f1ef631
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2019 05:37:30.4519 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1tn5seCpMUv7Y3Lp+9CrlX+nYbBU7H7MurBgKzHVQGBWuHJSqx2MFlG28Nlp1idININl8nKiLjuVz8S2YE7AzuBz2/cMu0MkWRQH8XHqK+E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6102
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190921_223733_597835_F7CA27F7 
X-CRM114-Status: GOOD (  17.33  )
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
Cc: Keith Busch <keith.busch@intel.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Please have a look at the comment at patch #1.

If you look at the nvmet_req_free_sgl() we don't have
such check since I think code assumes that sgl_free() is null safe.

If that is correct we don't need additional checks in the
code anyway

Please correct me if I'm wrong.

On 09/20/2019 11:18 AM, Sagi Grimberg wrote:
> Now that sgl_free is null safe, drop the superflous check.
>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/target/tcp.c | 12 ++++--------
>   1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index bf4f03474e89..d535080b781f 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -348,8 +348,7 @@ static int nvmet_tcp_map_data(struct nvmet_tcp_cmd *cmd)
>
>   	return 0;
>   err:
> -	if (cmd->req.sg_cnt)
> -		sgl_free(cmd->req.sg);
> +	sgl_free(cmd->req.sg);
>   	return NVME_SC_INTERNAL;
>   }
>
> @@ -554,8 +553,7 @@ static int nvmet_try_send_data(struct nvmet_tcp_cmd *cmd)
>
>   	if (queue->nvme_sq.sqhd_disabled) {
>   		kfree(cmd->iov);
> -		if (cmd->req.sg_cnt)
> -			sgl_free(cmd->req.sg);
> +		sgl_free(cmd->req.sg);
>   	}
>
>   	return 1;
> @@ -586,8 +584,7 @@ static int nvmet_try_send_response(struct nvmet_tcp_cmd *cmd,
>   		return -EAGAIN;
>
>   	kfree(cmd->iov);
> -	if (cmd->req.sg_cnt)
> -		sgl_free(cmd->req.sg);
> +	sgl_free(cmd->req.sg);
>   	cmd->queue->snd_cmd = NULL;
>   	nvmet_tcp_put_cmd(cmd);
>   	return 1;
> @@ -1310,8 +1307,7 @@ static void nvmet_tcp_finish_cmd(struct nvmet_tcp_cmd *cmd)
>   	nvmet_req_uninit(&cmd->req);
>   	nvmet_tcp_unmap_pdu_iovec(cmd);
>   	kfree(cmd->iov);
> -	if (cmd->req.sg_cnt)
> -		sgl_free(cmd->req.sg);
> +	sgl_free(cmd->req.sg);
>   }
>
>   static void nvmet_tcp_uninit_data_in_cmds(struct nvmet_tcp_queue *queue)
>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
