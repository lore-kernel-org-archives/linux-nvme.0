Return-Path: <SRS0=Gozd=AY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94298C433E5
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2020 23:58:35 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6575721852
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2020 23:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iOA52OLQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ie4/E5GN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="XCaVo5Yk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6575721852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=v2L30iRq572ZYbli9Dz/7Oa0ljm8OAE2k2vCP7w8MwU=; b=iOA52OLQ7uXpRmAiTy37faTn1
	Zh83axFWbsh/SPAarG4rlDMyU/IJv8mnOhSdWsBpEXEV20ij7bH3DjJxmOBLXielNyxRnv53RfFx5
	K605j5XFnL9hqaMdy/ORlx2nPoJMhODdv0ZX4F9dJWmI5cDjEu5X3OeKYKSN0AB6IcazYI6wktx6z
	gut/bWOcYxYrmVPf6C1og5csozX13NfbZja2sT6CN4PxGI0xR93KoIdWXGn4pIXxNy5tJJaL6u+GA
	JWz4DcrKFLixABct5+4x6iPklNKDfLm4/5k2tVPqxd8v7vO2E+jSj5wKcjCKjkem9BeW5N1lRqTO1
	IksE13dJg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jv8L7-0000Vg-Gn; Mon, 13 Jul 2020 23:58:29 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jv8L3-0000V4-0u
 for linux-nvme@lists.infradead.org; Mon, 13 Jul 2020 23:58:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1594684705; x=1626220705;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=HAJsM7p3yWWbZecr/YgR+Y7RjgEW/A+Q1KqtkulViMo=;
 b=Ie4/E5GNyJb9JLOANji7g88S0r68kX13VYT88iT2edzwNXIN8mzDER4d
 VdWKgaDSVGK9Y5wM+GchGSr6fC9hok/+hILOCyr+cGUuNp3l1EGZ3ZxWO
 cRkIOKx0T5wLzcj46OV+uaKTxXqsFJCrcR9ushnVSBoiDSVpp1T/scScU
 pAXnd7ERjt1zMmDO/CyjLbDrPFHuTqAqNEahqt+5yC4/t1k6fX/1DhMZ8
 u5iJvJAs0l4aiVFJXru3M8mZVLJF5eMvJJvNXXAeo6xhg/Ceh6e0GfrPP
 9/UvFWCccfPyDnlYRyZImW6I4Fon3ADSFszcA5b7qUpu6JqgjZLfGB7qz A==;
IronPort-SDR: +zgTvq1jYazdqFL9i4YBdxgh1Bog+uJb3Oysxn8mUxCgtxI2U4lYQLHuxlS+j9polN7UKhTKNY
 MkWPBDkw2b5LXfCqz+lMC7CmLALGLWvj1MCpe9LlsjCcZlwTyH2JqSWjphkjIn68ZxlCcCgjE2
 up710bLSleEtgYPVFOzHP9NxF63/2Dvd+P1mx1r9L5Vj6F0CoCTVuQcsvJ8E7h2W3/Nkwwjjgh
 lyu9aBdJkVhTErWD2cCytqDty9qVT9IyxaJnBwOSHlpbYFFpjdGYoJQ/sWxKf/sDtmUK3v3DyK
 /zs=
X-IronPort-AV: E=Sophos;i="5.75,349,1589212800"; d="scan'208";a="142509185"
Received: from mail-co1nam04lp2051.outbound.protection.outlook.com (HELO
 NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.51])
 by ob1.hgst.iphmx.com with ESMTP; 14 Jul 2020 07:58:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gAStohHlD1tNhrAkEyCEQIonqlU1CNdN2+6e9QG1wA11+Q/3khaVUoR6ZDhiirflWf7L+vEeuX4hVEUE6boHrk/2yOJ5hs/3mbkx5ULfOlHJ5TGEX1LHhmI6boKmXavNkF27LEOMMWxC/HebtNdxbgA5qo3uGniHH+mclSPQf5MaVQ2TBKBO1hYES778X0b2MQUlmtLyQhCmaasFsj2gIGeTHQ6hrhWu22+vdL5DaADIILVFz7C0sPBGrAYN2vB7qM80x1g6BTbZG5qRwk3KX+vAOJeH+OzO13h0RjIwTkpgdA5krz0eoG+Xpenw+diHSSnKEx95/AXfjdM/bopuKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=InDBfV4kQvJs7Jw4ECirMpO9f0ffhZxguX/LQAjAgSA=;
 b=h+A2H+UGFSPWnYGp8B8gbnllP+I09pgctbB8MuF2FmKlN0CUvrtozmtCT5iz01YSI/leilXGUTHFq11fu5Dg/3SLc1bOKxIWfPz1NGXzQY5wVd+XPRb540brvuTI4zSrhExNwHJtHi/pEvFzRSMQeyp+u4J9/Vncn4II1KhqANQaSPUfmZxGiGOxezbW64PxtpmIMciIoxBSmgjwNh4kecX7sr4WNVefHLLMpUobNWxav/feq7iUxzMo/mIWRiqLknh1gulB4oUad/4HEC1cVmKnj/Iut5EfoUGMTlLNUygaxKQxhhOpkERfK9JD7ryINwbitezxcMWVL+GcaDtRkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=InDBfV4kQvJs7Jw4ECirMpO9f0ffhZxguX/LQAjAgSA=;
 b=XCaVo5YkhxhzIdV8TzDEINpg+UzoJ4euLHHkg6hVdlUPdQqmpO0yEL2QZijtuIRnBnvGSZhsiSlr/wUPCxwbjWdAs9g4XwRIczr2k3sMTUmEBfTnwhiW9LWW+PFdNC+tgNEN7ddiL1OEpnYM3N9TT3Iw84N9ZVJc+/dA4KpnnIU=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6549.namprd04.prod.outlook.com (2603:10b6:a03:1d2::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Mon, 13 Jul
 2020 23:58:18 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3174.026; Mon, 13 Jul 2020
 23:58:18 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>, "kbusch@kernel.org"
 <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>, "hch@lst.de"
 <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH] nvme: Remove redundant validation in nvme_start_ctrl()
Thread-Topic: [PATCH] nvme: Remove redundant validation in nvme_start_ctrl()
Thread-Index: AQHWWN9KvInmw7yU802p8iILluvbIQ==
Date: Mon, 13 Jul 2020 23:58:18 +0000
Message-ID: <BYAPR04MB49655C05950BC7BDAD30629F86600@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <710eb90d9c1c125bdb37aae31ddc41a0f9782fa6.1594621435.git.baolin.wang@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.alibaba.com; dkim=none (message not signed)
 header.d=none;linux.alibaba.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1127165b-a821-4467-a63a-08d827889d9e
x-ms-traffictypediagnostic: BY5PR04MB6549:
x-microsoft-antispam-prvs: <BY5PR04MB65497D2A3FAA9D7F246E3CE386600@BY5PR04MB6549.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LohTDdsy7Hl+mHtq7YZHnwKz39l39fD5JFBPICYqF9zG7x5Rm0EBtRwy0CvK45X1OuV92G16GNZGdc3f1Dt/IjaIeW0b3kUuOnCI+90V676XvYqCodJhMOpjEYpPJVA1CFAvRFTtGmKp/MEvWtJ0sujy6losjQiQrr23ezMouy7AJ6pnu66gDAvzVJVdqLU4b9CfrgoTrL2tjaci8qxLh6Udl4E5FZdyiHy8+WCwN9MkxCijLC2lk+lH76UZoSJEt8l4IozbntxK0Pqhd4yvmDEDD+A7k454FjbCEvaKWbCS8laAyU9g4itu4H8JwCuxa92zWDSfKBzrePQHe/w3hA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(66476007)(8936002)(478600001)(9686003)(4326008)(55016002)(86362001)(110136005)(8676002)(54906003)(66446008)(26005)(6506007)(83380400001)(66946007)(2906002)(33656002)(52536014)(53546011)(5660300002)(7696005)(316002)(186003)(71200400001)(76116006)(66556008)(64756008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: JbScmvP6X2lthZzqK0ZQEYcxrhTIW+xFQhDy7NQyqSWbmqAB4I4YCQSs2yEi3rQuuKWqTlPWS15S2jZb1ZtRjOfhV1ISCKpVPGRMwctTgfyyJuIB48Xcv4daWK3FLyWALiaaVJ//HQcCr+/JzzjXQHpOz0kN8I5qjdeXs/n+UyuFT9uAuplTc1A1kBE3gzqoAxocnmRNciRu5LNERx8q29oviPbBJd2qs0XHGmNwZNzVuhAOBxtRF+U26JNNuFNJhAFdmwcUHYS6Tj41mw/Y7SRe0DlG//RkLYG4gtN2xM0vpP9v92n8JKi8l/dU1vqyfHmhn4lUTCaKywUYvYxIF7x1kHoVLrCQ4RVhyUwC1Eqo34C7djjrrmTLWrOBe7NrD4BZXVsnIE7Ut4Bok5905mwAWtrQvmkqYywn+xnZ7pPUaR8vJjDmrXOlCTH8imEH6hBwDGymTDl5xk7FE7O88jSoMOkXozrtN+gGEQvhkHE=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1127165b-a821-4467-a63a-08d827889d9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2020 23:58:18.3952 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IzbIoHQIBCfmH9/Eim4nLpUMtjFRmCVJ57JXjzS5T9SwCPQ//SvGnpQpZGVExCnKZSxlCD/lw1lsSTsekILZaQR6VSeZI5Crw48Mvw5CqkU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6549
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200713_195825_556509_9DD42020 
X-CRM114-Status: GOOD (  15.61  )
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
Cc: "baolin.wang7@gmail.com" <baolin.wang7@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 7/12/20 23:31, Baolin Wang wrote:
> We've already validated the 'kato' in nvme_start_keep_alive(), thus no
> need to validate it again in nvme_start_ctrl(). Remove it.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>   drivers/nvme/host/core.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 3d00ea4..a95e26e 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4313,8 +4313,7 @@ void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
>   
>   void nvme_start_ctrl(struct nvme_ctrl *ctrl)
>   {
> -	if (ctrl->kato)
> -		nvme_start_keep_alive(ctrl);
> +	nvme_start_keep_alive(ctrl);
>   
>   	nvme_enable_aen(ctrl);
>   
> 

Since start keep alive is so small to make a function call how about we 
in-line the call ? untested patch :-

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 09abf2ca33f5..c7289c23658a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4311,8 +4311,9 @@ EXPORT_SYMBOL_GPL(nvme_stop_ctrl);

  void nvme_start_ctrl(struct nvme_ctrl *ctrl)
  {
+       /* if ctrl keep alive time out is set start keep alive */
         if (ctrl->kato)
-               nvme_start_keep_alive(ctrl);
+               queue_delayed_work(nvme_wq, &ctrl->ka_work, ctrl->kato * 
HZ);

         nvme_enable_aen(ctrl);

root@iouring nvme (xarray) # git diff
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 09abf2ca33f5..08e1a6826b08 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1031,14 +1031,6 @@ static void nvme_keep_alive_work(struct 
work_struct *work)
         }
  }

-static void nvme_start_keep_alive(struct nvme_ctrl *ctrl)
-{
-       if (unlikely(ctrl->kato == 0))
-               return;
-
-       queue_delayed_work(nvme_wq, &ctrl->ka_work, ctrl->kato * HZ);
-}
-
  void nvme_stop_keep_alive(struct nvme_ctrl *ctrl)
  {
         if (unlikely(ctrl->kato == 0))
@@ -4311,8 +4303,9 @@ EXPORT_SYMBOL_GPL(nvme_stop_ctrl);

  void nvme_start_ctrl(struct nvme_ctrl *ctrl)
  {
+       /* if ctrl keep alive time out is set start keep alive */
         if (ctrl->kato)
-               nvme_start_keep_alive(ctrl);
+               queue_delayed_work(nvme_wq, &ctrl->ka_work, ctrl->kato * 
HZ);

         nvme_enable_aen(ctrl);



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
