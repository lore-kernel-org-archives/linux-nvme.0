Return-Path: <SRS0=qQKB=H2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A3E1C433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Feb 2021 22:36:12 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAAAB64EDD
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Feb 2021 22:36:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAAAB64EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=dpikE/1+OmeBF7e4SOpGZGQthSKCmml2EAqe015kETs=; b=fkZDdD1rhoGgf1HxbZUFa8bRB
	xw9qNdPOgvaIil/QCoSaTGHatnD2dyHsRpkkrySDkvZbBQjz84nGsBoFYUlmYXF65qrFF/z2rnUc8
	lSJsCI30ULwkYdvwRTqm2XNCMTTqytGjhhFMHheXK+udLa4PvbMZfqkyO8gJUvHz0vUq13N3j19WL
	qKNM7Qq7lzDqBlkKyuXBlHehzQrvW1oEULJvN/feHCiV476QJZLDvPdlfUiwQWlADqaA8hwjKFdC/
	JgyqHQdpJY6CZaS2txafCzRkmSCtWl5nxyF0XmgNne4YMEEJmBbk87An6MoOvjwPcEAiW1F9m/GGb
	vvxrbB1NQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lF2lC-0004jX-0b; Wed, 24 Feb 2021 22:35:58 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lF2l8-0004j0-5R
 for linux-nvme@lists.infradead.org; Wed, 24 Feb 2021 22:35:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1614206154; x=1645742154;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=J+pn65IqIp7JPCpBq1/KuOjU9pZYcWos9p5qgK2ZEeE=;
 b=IkDIkZd+erm23CJOqAD9tcCOAfrIFhqn/Q//iApmFaFCNHC2M0gxCniv
 E9ZxUtAYN4oDk6MrSoBi8i9NZjTT5mme6vjHBPUtYuUm6TsgZvhGqgZjk
 l5bc7OcQwWmCEDDZx9kiUIciFaC8JGYi8ryNlR5zaVdKwNlvEoDqf0TFv
 z+T2oM2fuz/3/gZGQ7izj6uNqLB4PYnE7OBUEzyIhm/zWs2APxsbjbquz
 aOBjaVWMFHesEIMof/ADmVpNBWyuyPRgxlgCoeWwrE0Snd+uU43q8+Wix
 osATcbf4pt9JGXw9k51Njl5ctuX+NxHRZXVOJ/+s/qdvMTFzrRnJdN5Xc g==;
IronPort-SDR: IA7IItXlNR7hbERZlkDIumGF6Nr8WDFtrti2DH3CW+XgQEhO1kSgawcOvhQ+/3v/8LLRSs7EHJ
 aTR/5dR+gK6E6Gj8UuDFDzlQ2Cib4ZiS+L3+J9XmfdYYZ5X0WXvTVSzBfC90qWdZ3VC//aEstb
 0hu5c5CpPssFeUcNppwjY1D8RBEZdEkCbcwEZI/ylWdV5kI047+8MIePKruhP7lLPnyTiRDclR
 PhdyGWrzsn7SNHo/kC6/5wpez+EbJJwCFrwDgbEArdJpJucxsfWvt9U98FXo4bN67hqEhZDHhd
 KGI=
X-IronPort-AV: E=Sophos;i="5.81,203,1610380800"; d="scan'208";a="271285471"
Received: from mail-bn7nam10lp2107.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.107])
 by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2021 06:35:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dkVE2KgTTPL/bQ5kvrdmoIiaOnUTLrPp7U2u9i6oiY07oQH/Mo1Bu1ysSfqlZqLCDTFuIDEuzcL1zYalJ4XJOByzeK6FVNe2ZyNKZqYV+1p+CByw0DHEm/31i73LFVWEEYMa5yP4+5bwGwrJ7ClLbd/HGLvsqaQfBpK9Tl4/jQXuQo3M0lYbeRKP8NCTzt+2nx7pbXtGyGhm48q/ZQa4SXqeEgaDxqNrj0AOLBRAyaudUERgJNxSU1+WtbEjDshosEAfhV67e18qTGJK1kDsfjWIeXxyrek+8TOAM0doIiPp64gGo59YnFIZL03deWEfl3QmqZ2k3GX4ccHAgRczrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9CGnj3l74YIAWr56eEZM3ukUDGhafE50zSLn6kSQ9g=;
 b=fM9KsO3ymkaEOSrcwT3u1oQKIkbPQZtqHgyVi7IiCtyLpcgMAVatbSHnElKgNrSxRO9RzZhuDccjql2WUGZkKJiVwbH/RyfVpMe42xwChN9ch/VXnYr+mnt31LyTJOY9kXN5i4Jjqqenn6QarmAKbPkt3NJ6Gg5Qk4YgZoK/vbCGTIhy7zSrAMj/PxqPlSnXtnfOfKedUdRhdpSNXEDSyD06/3xU2zDS4PyHdUqu5sKRRnRWHCy8Xsi7AhL1TbeD6UTCryUG0D5ExUb8m691gtO3JP2t/hB4kWFPKFzFR8vwnGbuKeoR9w+GTuhezhHE+xtoI4Dl6GeB3eHWOSEmjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9CGnj3l74YIAWr56eEZM3ukUDGhafE50zSLn6kSQ9g=;
 b=PmdLgM+mmluzutgHMgCQZkTuBeB24h44Cx0X0gAn3H218JEPKdF5ZWeqAQX4HShLjhblXa904E478q3G8n+l9MQRSmsRQzmcnlKe9M1RLdhwf8xE5ipmrBvhc0Pq7Ds0T+ME5uA/PB7bomPDq6RgCeD1YwOPA98OuRQoJfUGAqY=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6642.namprd04.prod.outlook.com (2603:10b6:a03:21b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 24 Feb
 2021 22:35:49 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:35:49 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 01/14] nvme-core: remove duplicate kfree in init identify
Thread-Topic: [PATCH 01/14] nvme-core: remove duplicate kfree in init identify
Thread-Index: AQHXBMFZ5FvBzVK480+pgdhGCawgTA==
Date: Wed, 24 Feb 2021 22:35:49 +0000
Message-ID: <BYAPR04MB49659BEC727069DD470A18B8869F9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210217001032.25741-1-chaitanya.kulkarni@wdc.com>
 <20210217001032.25741-2-chaitanya.kulkarni@wdc.com>
 <20210224163505.GD10673@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0ea79019-1a8d-4c80-255e-08d8d914893b
x-ms-traffictypediagnostic: BY5PR04MB6642:
x-microsoft-antispam-prvs: <BY5PR04MB6642966CD2B76794292FB5F7869F9@BY5PR04MB6642.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1s/448L+eflqIm5tU6dYL0f+HeY2vZQXwWyTvj1xJQXBmUFUzvMyx4Ts5TAz4r4OL2U+sTDk+BHqzpvHnxtdRP7uMxkgdgvaaIRIPthHBrUp/9zl7DN/SuP6VHbV30Ki69IUp/n5jkYkBL9m0TcVFrDlNK/eckv/2KmMMXSLc5MpWXPrRJfyin1FE9mP2daqXb1qrIQR4MVAz8Kb3vfMPWjF5FDPpOj486RB+2akCG0/dWORqu2zih5bH8ZN1eQ9/AurDnrxPjTlIY88ESHyTD2Q+A9kO/Uw89LV8Vr8zuSeEL7fWVI0II47HwiB/N3nhO0R+fg5NLOB6hAt7NyVDyfWRXQhE71wjZ0LxYkfjfQJiwe2hO6VaJZWa/ZgORMYV75dBmnw7pYoqEMrvGTePLd5xg0u4GYEBsOKgkorqLgaHUXCOQEPs+jJYgC8u5n+TZQhNi5QGmKfPfZkjUICHeXn1CxR7f1PHfQjVjhA3H43ItB9HPNCEsVwqHjD9kVAVAYVYTQ2gZMavJt0PZagYA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(39860400002)(366004)(376002)(83380400001)(316002)(54906003)(8936002)(66556008)(66946007)(2906002)(86362001)(33656002)(66476007)(55016002)(8676002)(7696005)(6506007)(9686003)(53546011)(4326008)(64756008)(66446008)(478600001)(186003)(6916009)(26005)(71200400001)(5660300002)(52536014)(76116006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?MpWdfOLPv5iGrOCvu95cf9csqpWNmqO55wY3uUIaO+5qmdQzaLq0M/9fxx7O?=
 =?us-ascii?Q?fdl8+H++rd/Qs57t30YD+6eX5EJOaFPh33OxgJqW3Lm0W1UzHTtcPZylvUYW?=
 =?us-ascii?Q?iOhmH4rMqplVbOqLT/DQrpxnVABIyEOZTG6fOPBy/IE4FBqRNRNPLjYtj5LY?=
 =?us-ascii?Q?d+CfpLpSIc44YoGv5/TCA8yhZfnsmsX+Zpctnon+niCiTosVlccyNFd9S3Fp?=
 =?us-ascii?Q?e76Pzi4kBBV4fJ1kzfR4mo59axKKhPkE7FD3FP6S+PZr5DUOOD9+zvlm4A59?=
 =?us-ascii?Q?ZgLL/sAA0O4txa6u+NgBq2rE+TZr8WdFrp9QAyEhqOX2dvFa7HWl7UsZqymT?=
 =?us-ascii?Q?0uNoKKm6Rfqp79oyEMxvzoXB/HVHelX82A3ktt+pg/SpHtSHcpAvgCllcZ8E?=
 =?us-ascii?Q?4HGFY9LM2wCnt1TL9aBw7i8GQgJkfTcvHf/s26CjwfNUpCNkdZEXm7lnouil?=
 =?us-ascii?Q?rzoX8C8bW0R8jayhpVUx26d0WoO/9zfHaOAYTSwlNoinyJfUU4NZcA71NBcu?=
 =?us-ascii?Q?I4T7gA0GMNkVHxxZ/T5m9E11hpkqtRs7vUZkFU47xFhOGBuDDV8g9ytLXvS2?=
 =?us-ascii?Q?03n37xyUJSWSvoT53AyLDrl2F1JM6PqqrjZ6VPO9Mc4gLmmGLjhV0Di/vfhT?=
 =?us-ascii?Q?hOWFnpUqQFrrbhWFHfPUHN8R9xf2FPzxizEcG7Z68ePlcvJU3YfPJYAVXu8R?=
 =?us-ascii?Q?qUf0ZrwQOw/yClQA1KUeQTpbwLViMDQRXh3z3yc/YMrpWI4Q3FmCR3BDqzEG?=
 =?us-ascii?Q?agQzMw3xv7nJqIIPSmU9mlu+jqjTzEgbImc+DEA4RldCH0lCof15fnhtW4XK?=
 =?us-ascii?Q?34okKG96ehRGn07/GhcrRCAeneKI0OUjd+HUJ6PTD9R+DAMjoeQ0TZEetpxl?=
 =?us-ascii?Q?rUbSeDxpgh2ALrE4iuRGKKZwL6BWszd2cEoLDvnP6CJYgSTiQsWcnTpfmVyS?=
 =?us-ascii?Q?Yl8O6jgErfoBod8E8h9uo/Ew0Ykeo1mc7hFe03wg1YrKKvrrzqY5qh+TgXQR?=
 =?us-ascii?Q?wVJP4XDDFalMNABSINxtO0dGkl/oL2BcM00UJr0cmGHnZFeYfHTH593vZ9wB?=
 =?us-ascii?Q?ZpTubgLHYX/cRawd4kWsmq/h20rOgMORZjNx8ibxyDHMEULsfvmIImCNlMkc?=
 =?us-ascii?Q?aP+5yH3g75kvhr1V52bbRf2XqAPboHBhEuHa93KFGLXnVd5vQteEr/ulvCeP?=
 =?us-ascii?Q?TVI2KiobjLWce+EnorImJh8oKQsIrxpmYkwEyEl7gY2MV9U+cCoJH31LIR1S?=
 =?us-ascii?Q?w+BJ+ZNbyyBYtnc5ZThIXxEWm1HrCO5WnrF6pNp+RSyf8OQBqiFxyIXgwWGc?=
 =?us-ascii?Q?qy8iaU64474qrCxMs87K9PQ3DRqjZL+2u9KXZIFO7rlwlg=3D=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ea79019-1a8d-4c80-255e-08d8d914893b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2021 22:35:49.6554 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BwhqKkUhTBRDizt8q1nC7O3wROD1D2op3JlJWaaZ1j5bmvoDoH9I+qvlo9z8uXZZwrdIJJjE+yw20/0llWtp9ZaUunyhIvhT5qhsxyQrsxU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6642
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210224_173554_545954_CB63055F 
X-CRM114-Status: GOOD (  26.20  )
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
Cc: "kbusch@kernel.org" <kbusch@kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2/24/21 08:35, Christoph Hellwig wrote:
> On Tue, Feb 16, 2021 at 04:10:19PM -0800, Chaitanya Kulkarni wrote:
>> In nvme_init_identify() once we initialize nvme_mpath_init() we free
>> the id with kfree(). This is needed since we just return from all the
>> following calls to nvme_mpath_init(), that also makes kfree() call
>> duplicate.
>>
>> Instead of returning after nvme_mpath_init() jump to the lable
>> out_free and remove the duplicate call to the kfree() since out_free
>> label already has one..
> Hmm.  I'd rather split nvme_init_identify.  Rename the publically
> called function to something like nvme_init_ctrl_finish, and
> the split out a nvme_init_identify for just the section that deals
> with the id_ns data.
>

How about following patch in [1] ? If you like [1] please suggest
the patch distribution. I'd add a prep patch to rename and second patch
to split the helper.

Shorten the original list to avoid churn, along with the documentation fixes
planning to keep following in V2, is that okay:-

  nvme-core: mark nvme_setup_passsthru() inline
  nvme-core: use likely in nvme_init_request()
  nvme-core: don't check nvme_req flags for new req
  nvme-fc: fix the function documentation comment
  nvmet-fc: update function documentation


[1] nvme-core: split out id_ns into helper

From 4b4ec36b0c660fc54e22aa4d712db1b595b2e90d Mon Sep 17 00:00:00 2001
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date: Wed, 24 Feb 2021 14:14:05 -0800
Subject: [PATCH] nvme-core: split out id_ns into helper

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/core.c   | 65 ++++++++++++++++++++------------------
 drivers/nvme/host/fc.c     |  2 +-
 drivers/nvme/host/nvme.h   |  2 +-
 drivers/nvme/host/pci.c    |  2 +-
 drivers/nvme/host/rdma.c   |  2 +-
 drivers/nvme/host/tcp.c    |  2 +-
 drivers/nvme/target/loop.c |  2 +-
 7 files changed, 41 insertions(+), 36 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e68a8c4ac5a6..68b0022bc60d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1119,7 +1119,7 @@ static void nvme_passthru_end(struct nvme_ctrl
*ctrl, u32 effects)
         mutex_unlock(&ctrl->scan_lock);
     }
     if (effects & NVME_CMD_EFFECTS_CCC)
-        nvme_init_identify(ctrl);
+        nvme_init_ctrl_finish(ctrl);
     if (effects & (NVME_CMD_EFFECTS_NIC | NVME_CMD_EFFECTS_NCC)) {
         nvme_queue_scan(ctrl);
         flush_work(&ctrl->scan_work);
@@ -1978,7 +1978,7 @@ static void nvme_config_write_zeroes(struct
gendisk *disk, struct nvme_ns *ns)
      * In order to be more cautious use controller's max_hw_sectors value
      * to configure the maximum sectors for the write-zeroes which is
      * configured based on the controller's MDTS field in the
-     * nvme_init_identify() if available.
+     * nvme_init_ctrl_finish() if available.
      */
     if (ns->ctrl->max_hw_sectors == UINT_MAX)
         max_blocks = (u64)USHRT_MAX + 1;
@@ -3059,28 +3059,12 @@ static int nvme_get_effects_log(struct nvme_ctrl
*ctrl, u8 csi,
     return 0;
 }
 
-/*
- * Initialize the cached copies of the Identify data and various controller
- * register in our nvme_ctrl structure.  This should be called as soon as
- * the admin queue is fully up and running.
- */
 int nvme_init_identify(struct nvme_ctrl *ctrl)
 {
     struct nvme_id_ctrl *id;
+    bool prev_apst_enabled;
     int ret, page_shift;
     u32 max_hw_sectors;
-    bool prev_apst_enabled;
-
-    ret = ctrl->ops->reg_read32(ctrl, NVME_REG_VS, &ctrl->vs);
-    if (ret) {
-        dev_err(ctrl->device, "Reading VS failed (%d)\n", ret);
-        return ret;
-    }
-    page_shift = NVME_CAP_MPSMIN(ctrl->cap) + 12;
-    ctrl->sqsize = min_t(u16, NVME_CAP_MQES(ctrl->cap), ctrl->sqsize);
-
-    if (ctrl->vs >= NVME_VS(1, 1, 0))
-        ctrl->subsystem = NVME_CAP_NSSRC(ctrl->cap);
 
     ret = nvme_identify_ctrl(ctrl, &id);
     if (ret) {
@@ -3098,7 +3082,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
         ctrl->cntlid = le16_to_cpu(id->cntlid);
 
     if (!ctrl->identified) {
-        int i;
+        unsigned int i;
 
         ret = nvme_init_subsystem(ctrl, id);
         if (ret)
@@ -3136,6 +3120,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 
     atomic_set(&ctrl->abort_limit, id->acl + 1);
     ctrl->vwc = id->vwc;
+    page_shift = NVME_CAP_MPSMIN(ctrl->cap) + 12;
     if (id->mdts)
         max_hw_sectors = 1 << (id->mdts + page_shift - 9);
     else
@@ -3210,16 +3195,40 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
         ctrl->hmmaxd = le16_to_cpu(id->hmmaxd);
     }
 
+    if (ctrl->apst_enabled && !prev_apst_enabled)
+        dev_pm_qos_expose_latency_tolerance(ctrl->device);
+    else if (!ctrl->apst_enabled && prev_apst_enabled)
+        dev_pm_qos_hide_latency_tolerance(ctrl->device);
+
     ret = nvme_mpath_init(ctrl, id);
+
+out_free:
     kfree(id);
+    return ret;
+}
 
-    if (ret < 0)
+/*
+ * Initialize the cached copies of the Identify data and various controller
+ * register in our nvme_ctrl structure.  This should be called as soon as
+ * the admin queue is fully up and running.
+ */
+int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl)
+{
+    int ret;
+
+    ret = ctrl->ops->reg_read32(ctrl, NVME_REG_VS, &ctrl->vs);
+    if (ret) {
+        dev_err(ctrl->device, "Reading VS failed (%d)\n", ret);
         return ret;
+    }
+    ctrl->sqsize = min_t(u16, NVME_CAP_MQES(ctrl->cap), ctrl->sqsize);
 
-    if (ctrl->apst_enabled && !prev_apst_enabled)
-        dev_pm_qos_expose_latency_tolerance(ctrl->device);
-    else if (!ctrl->apst_enabled && prev_apst_enabled)
-        dev_pm_qos_hide_latency_tolerance(ctrl->device);
+    if (ctrl->vs >= NVME_VS(1, 1, 0))
+        ctrl->subsystem = NVME_CAP_NSSRC(ctrl->cap);
+
+    ret = nvme_init_ctrl_finish(ctrl);
+    if (ret < 0)
+        return ret;
 
     ret = nvme_configure_apst(ctrl);
     if (ret < 0)
@@ -3246,12 +3255,8 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
     ctrl->identified = true;
 
     return 0;
-
-out_free:
-    kfree(id);
-    return ret;
 }
-EXPORT_SYMBOL_GPL(nvme_init_identify);
+EXPORT_SYMBOL_GPL(nvme_init_ctrl_finish);
 
 static int nvme_dev_open(struct inode *inode, struct file *file)
 {
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 20dadd86e981..962987a330d6 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3085,7 +3085,7 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 
     blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
 
-    ret = nvme_init_identify(&ctrl->ctrl);
+    ret = nvme_init_ctrl_finish(&ctrl->ctrl);
     if (ret || test_bit(ASSOC_FAILED, &ctrl->flags))
         goto out_disconnect_admin_queue;
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 07b34175c6ce..624fc4334a2c 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -599,7 +599,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct
device *dev,
 void nvme_uninit_ctrl(struct nvme_ctrl *ctrl);
 void nvme_start_ctrl(struct nvme_ctrl *ctrl);
 void nvme_stop_ctrl(struct nvme_ctrl *ctrl);
-int nvme_init_identify(struct nvme_ctrl *ctrl);
+int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl);
 
 void nvme_remove_namespaces(struct nvme_ctrl *ctrl);
 
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 207137a0ed8e..b8f0bfaa8f2a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2652,7 +2652,7 @@ static void nvme_reset_work(struct work_struct *work)
      */
     dev->ctrl.max_integrity_segments = 1;
 
-    result = nvme_init_identify(&dev->ctrl);
+    result = nvme_init_ctrl_finish(&dev->ctrl);
     if (result)
         goto out;
 
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 53ac4d7442ba..9c710839b03a 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -917,7 +917,7 @@ static int nvme_rdma_configure_admin_queue(struct
nvme_rdma_ctrl *ctrl,
 
     blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
 
-    error = nvme_init_identify(&ctrl->ctrl);
+    error = nvme_init_ctrl_finish(&ctrl->ctrl);
     if (error)
         goto out_quiesce_queue;
 
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 69f59d2c5799..735e768f9f43 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1875,7 +1875,7 @@ static int nvme_tcp_configure_admin_queue(struct
nvme_ctrl *ctrl, bool new)
 
     blk_mq_unquiesce_queue(ctrl->admin_q);
 
-    error = nvme_init_identify(ctrl);
+    error = nvme_init_ctrl_finish(ctrl);
     if (error)
         goto out_quiesce_queue;
 
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index cb6f86572b24..a7f97c8b2f77 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -396,7 +396,7 @@ static int nvme_loop_configure_admin_queue(struct
nvme_loop_ctrl *ctrl)
 
     blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
 
-    error = nvme_init_identify(&ctrl->ctrl);
+    error = nvme_init_ctrl_finish(&ctrl->ctrl);
     if (error)
         goto out_cleanup_queue;
 
-- 
2.22.1




_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
