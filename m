Return-Path: <SRS0=O3HW=ZN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A2D1C432C0
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Nov 2019 20:17:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9F4A20672
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Nov 2019 20:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JQtsn2U8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="diCIWI2L";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="fFkTIz6/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9F4A20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=+rXIQGsp41R/x18mk6wIzjfoaPQVi3gKRlu/MsTR0OQ=; b=JQtsn2U8LoN/to
	JSaaU4pDHF/HJJh8ixnwGH8RaHMcT1sCTBzWydWgXYx/0SHv4QgXvrUEdma9kdk86kLp+kSX5nPMG
	R76AmwGAGrlR4qW+LI64CXcGpzjqz6LdMb7xrk0nG4eQOjbwVVb8ijxmNpVF3n2+GXZ9b4T7v8GQq
	RUAYJLzZml237dVnsWHf4XiteM1HDuVfax9hmlHTE4zkIkSEwbMDtxgUgMiMrSZnsJqjYXxVXpsBe
	IgYLXDaRkd23cbuRyXI5WmB8eIhwrmwAvxhLAhGSZ88ASOEYX/ejiY/dBv0dlfpIup5mYwDbwUKPG
	/AkxtOYYOutLBxIp3ErQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iXssq-00010T-1e; Thu, 21 Nov 2019 20:16:56 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iXssm-0000zo-Ef
 for linux-nvme@lists.infradead.org; Thu, 21 Nov 2019 20:16:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1574367413; x=1605903413;
 h=from:to:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=T9X1tGH1FTUemUjbx17h+p4GSWn56/evJYBWZm0Txns=;
 b=diCIWI2L0WNJ6RUDUU9T9ySyihvCBZg27vHP6ecMXfsPG85SXQV5hquj
 fH9L9KDobpx+Du1KQLXUhWt8WRdRMROPxe3a3Edn1ySda+V7zTyeH1iBL
 Jgb2YZi5Ua3XO//wySP5Uxh282Zj+w8GfdEzhXbmMHV20pJh0QiCgASON
 7S6XJEv6PCKmMclh4Nn5gPzUD9qcnuekE5UdCjjaM7UPgyEqFOrwlh2Ol
 2r7tfggAPiN1S9K80+QnHzWHwz3I1RlAIobcauMkGo+C6nd1uTT/onf8d
 siP++KtargHw8NEYLqze/f95gr87b5nJZL/vlQxbM4S6ekSma4rIthFkS w==;
IronPort-SDR: zxrxYjVMMujLGL2DFP1g0/Mf6gvaT7BzfyJminu0yzSYd4bDQtvLzXJEzickvo3PMYc5fJjqWa
 d4wj3BI6t6k/vC3R/ASw/SbKpuEAj1Ds1PjiFnCpPNwKnM1IlqWgODbS/udinLwpTKQytNuZHK
 dPR5o4foaiPKg+8OYwaK6D5eVxjJ422dVsu9YQtKpEzlwGWdkLYdFVgD3C0l4zFyFmuc1IgG2z
 jwEwcrbhea+rzv/acOFKvX0b8ImJnqiauN5tjpR3uyFFVmaUGU3CKTb/S+KnnXZ8GwGa0C6EZE
 75g=
X-IronPort-AV: E=Sophos;i="5.69,227,1571673600"; d="scan'208";a="124444894"
Received: from mail-co1nam03lp2059.outbound.protection.outlook.com (HELO
 NAM03-CO1-obe.outbound.protection.outlook.com) ([104.47.40.59])
 by ob1.hgst.iphmx.com with ESMTP; 22 Nov 2019 04:16:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ux781UA+JAqz8woE3aYt5ZXKdQAFqWYI0xWLDzrBXKHKbQKDXS/tcfeTki4/+qWynBynNvhbaT+1s5JgzJHHNrcTp9DkD43QUdre4P/6avGvYicp/lposWqRJcxs9q/wqyPI8ENFUOMazyA3gm2ZneA5zI4sPotwEBPZXOeykDGCyvPsKYYDhia4FFrSKxXX2z8PEmvBvfqnh7NaYuenTnM/QB96KwwNYgTdrPWP3cl4OK6XqaJGgZCh+t6uzXgEtvNA8u6UdeHdbCtrqX3jBSQXKJntU9eeRBEyInL1EaL9dWHmz2kg048H1dc5jHAvVCtt9Ad5zXZv2kMkFV+WLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZGJcDtsLYS3KWx96OmVpdoKk3cK+7kLBeAhTljns2k=;
 b=TpOWFFDTIH2K/5xaZey5S4wgKiRc9GXjpDSUuxL2VoWOTsR+NSsQv2VplLgSNv/0Hz+rgZ36wTkiziAGJXECGT9QYyb9sG1iy0B17mP0RvOCc4Cosy5zqyFLqtiZW39Ke9piXPbWz2YxWPJhoK5lMzW5lf59jCafCkli0dmpSKSqsigaUy7ku8UBHffJPrLQVLT8I21AjrGNo1BtytcIWyptuSIZfyVoaZgcD4knmbf7L/5YRSuuRgYDfJ1eC1jIAaq5B+y/r9URL4cmW2j+hSwyetEHzGjAyVLbrcF7MqsVgg0qfQOCOynqWWoMWPHbULYz56Ts8IzrXrznXu/fMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZGJcDtsLYS3KWx96OmVpdoKk3cK+7kLBeAhTljns2k=;
 b=fFkTIz6/zSDbpIBIGRJwphEd+LXUG2O9ZSaV88ZXqhLeXuNhujo0Ha7sDaO4T9w/SRHOSNo8R3AeGy/l9t0eGbjKR2FY33G1XVtJkxfnChf0C6jbQh5jH+Ef+XOIUZzIcvK09vlgKHtENe3J1txKFKxM2omCDTHs04t9evv1EYs=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB6184.namprd04.prod.outlook.com (20.178.234.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.18; Thu, 21 Nov 2019 20:16:47 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6066:cd5d:206:5e04]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6066:cd5d:206:5e04%6]) with mapi id 15.20.2474.019; Thu, 21 Nov 2019
 20:16:47 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: James Smart <jsmart2021@gmail.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme: add error message on mismatching controller ids
Thread-Topic: [PATCH] nvme: add error message on mismatching controller ids
Thread-Index: AQHVoJVIZokE9SAtKkuCy+NNm3g3WQ==
Date: Thu, 21 Nov 2019 20:16:46 +0000
Message-ID: <BYAPR04MB5749300C95DFB14D882000DF864E0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20191121175810.19501-1-jsmart2021@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1f4af306-7880-4f0d-1c71-08d76ebfbc20
x-ms-traffictypediagnostic: BYAPR04MB6184:
x-microsoft-antispam-prvs: <BYAPR04MB6184CEDDDBC1172B2AA86EEF864E0@BYAPR04MB6184.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:660;
x-forefront-prvs: 0228DDDDD7
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(136003)(366004)(346002)(396003)(39860400002)(376002)(199004)(189003)(229853002)(478600001)(14454004)(6436002)(316002)(3846002)(9686003)(14444005)(2501003)(81166006)(8676002)(110136005)(52536014)(7696005)(76116006)(6116002)(6246003)(76176011)(446003)(71190400001)(71200400001)(66946007)(6506007)(7736002)(15650500001)(305945005)(66556008)(53546011)(186003)(99286004)(86362001)(25786009)(81156014)(74316002)(33656002)(8936002)(55016002)(66066001)(5660300002)(256004)(26005)(66476007)(102836004)(2906002)(66446008)(64756008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB6184;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eOidmHqXd8RYwTa6j9nbVcUAz4vQiIRAw31Rxk+wHEFH0NWmNyKIhbArVWbkNKVAy+sF0YmFNZ70FV4FstjVyI8xTD7BuSRiJFAsxOhAFP0RTmxit1uxBxGH43gA41e6XFahGMWjQO5KB4wh6vG2VlpI8se3CUQJ6ErDCYDCABdcmVCJbSUhCddd/7bl94tS6JEElgq2ybWP5RpaZCdgWvlhMq8GXf+ddK9IVuFkm+jbqSTTCMVd8/nTdQUKefAxGyUVv6P8I5k85HDh1H2jXe/lwkmhe/olnORn6DzEhNTYauqr34QWkcenVQ23ZqXT/oc7sPLc4B4IRd1VcJoXaSDD4ToOd/NOFfEB1y4+2timNx+QFNitYBbrJWx7oxLu26L/mCYgfgM/5YlH4NyRLw8r51bJ5eNvZRPzs5wTAMLaKQFqV7CCZLLT7zzeq6wo
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f4af306-7880-4f0d-1c71-08d76ebfbc20
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2019 20:16:46.9045 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0fZY/qSncmHIDdIOBzkyoXiMxmZPhyGhYAtYgQMrpM2lStxumZkd+T0usdJW5V8P02D+Zi2PMfreslwhJWKKxFLD9vAhFVJ8JAPeHcFSY2w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6184
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191121_121652_584113_B2B38F6C 
X-CRM114-Status: GOOD (  15.74  )
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

Looks good to me, just one nit with the commit message
and can be applied at the time of applying patch.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

On 11/21/2019 09:58 AM, James Smart wrote:
> We've seen a few devices that return different controller
> id's to the Fabric Connect command vs the Identify(controller)
> command. It's currently hard to identify this failure by
> existing error messages. It comes across as a (re)connect
> attempt in the transport that fails with a -22 (-EINVAL)
> status. The issue is compounded by older kernels not having
> the controller id check or had the identify command overwrite
> the fabrics controller id value before it checked. Both resulted
> in cases where the devices appeared fine until more recent kernels.
>
> Clarify the reject by adding an error message on controller
> id mismatches.

When I applied this patch found that there is still some room
so we can get to the 72 columns (unless it is done with some purpose)
for the commit message, I've just adjusted the lines without changing 
any description :-

We've seen a few devices that return different controller id's to the
Fabric Connect command vs the Identify(controller) command. It's
currently hard to identify this failure by existing error messages.
It comes across as a (re)connect attempt in the transport that fails
with a -22 (-EINVAL) status. The issue is compounded by older kernels
not having the controller id check or had the identify command
overwrite the fabrics controller id value before it checked. Both
resulted in cases where the devices appeared fine until more recent
kernels.

Clarify the reject by adding an error message on controller id
mismatches.

>
> Signed-off-by: James Smart <jsmart2021@gmail.com>
> ---
>   drivers/nvme/host/core.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 9696404a6182..c272afb084d1 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2824,6 +2824,10 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
>   		 * admin connect
>   		 */
>   		if (ctrl->cntlid != le16_to_cpu(id->cntlid)) {
> +			dev_err(ctrl->device,
> +				"Mismatching cntlid: Connect %u vs Identify "
> +				"%u, rejecting\n",
> +				ctrl->cntlid, le16_to_cpu(id->cntlid));
>   			ret = -EINVAL;
>   			goto out_free;
>   		}
>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
