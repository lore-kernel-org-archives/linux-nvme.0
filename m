Return-Path: <SRS0=yMBa=LB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4635FC47094
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 20:38:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 028AD610FB
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 20:38:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 028AD610FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=lS45f3c2c9SN+wCKgSZ0NOymWQ0FYShn1qYiWByoKsQ=; b=qk6aVqSUhEqZKm
	2+xJOdTO2B0tbkj6+/btgGrt40yHzO5ttaiDzoMqiizMRBI0BwaYpWrnBbZU98VewRYpd/84mAwdZ
	ryFHaAUoAj6nJlDS3HxTPjg7V6jyRZu8YmeecXwczQsTslMhI8KKcf3LTx+d4yHnYRjumCgsjWpMg
	Qs8WYsW5I2dxZtG3jDfP3iDg2meziFrdIuthB4rrVRoO6AnEKUZWF/zFPdRn/qbk+dt0QbAJo5FH3
	Xh9X/XxSgn2I9+WeoM56Xqsgt1KFJsODViqrwtHAdwa0vyzfptbBMXYx7ZBqsng7DrzN/J+rDlql0
	J+AkMAtGfvle+Z+zMG2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqM0G-005MCG-UJ; Mon, 07 Jun 2021 20:37:44 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqM0E-005MBR-8z
 for linux-nvme@lists.infradead.org; Mon, 07 Jun 2021 20:37:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623098262; x=1654634262;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=b92qz4FNKKFoT/OlQVfOc+thru9302/A0VVuEIIDhpA=;
 b=UEElO2OYo7oDV0EzhUA+njE6noecRRiZ3UUjBIL1IwgUkfSupHvUj/Dk
 gZUPo9BfR54aRAQyBaxjTJOTnYUqKZ4QVmBikd0Wd2ejCLwh6jw4wjJ31
 dg2gy1IkuWirEHZAANln/dkxakIyLeTAkN6qABYMfiYnCCFrTJNfXMrD8
 2RXA5paF7cGegm8wsGxvUH57uRJZP7t/hIV4kFg7c1YF7Rg3SkbRDnO9T
 PyfsRbdsb9HY0+3HdlvJTWgw/4gMCRURvE0tIzZr76PX/VQePRRhWgsoH
 yTSVhA9c0E+ys8XjSU7sC7MuVy2GtSP+MRRWnKYbINSe+Cji/FPGHj1cy A==;
IronPort-SDR: 7w3gERw+AUBF+CNp1VfnnA9CPJednCRsqPijkpS07DjtLBY+QVEkIOUM/P/p84xc0NgM/hSiVv
 i1vXGE9mhFRLRImfKOCzCVTPfEqqCS7Iidkh6FNxSY+O6QaeYCZuTl2KiFGvnD7eqGca0qEP1z
 fSSY2cow3zuEYTg656ZPVFxSouJ78xFx4v4WfhVzNYsO8A2VKr6VgMf7NdUi3wt3Up5KKczE8s
 C/uQOZoDkTJbDqwc4Nfj/fwT5HgW+fRmuKt6PRg/FnsHu1gwK3UmiNEN8HlWObUeFxSwRoWJ+4
 Vlk=
X-IronPort-AV: E=Sophos;i="5.83,255,1616428800"; d="scan'208";a="170348058"
Received: from mail-mw2nam12lp2048.outbound.protection.outlook.com (HELO
 NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.48])
 by ob1.hgst.iphmx.com with ESMTP; 08 Jun 2021 04:37:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YTKLVlnAnRoJVwc8Kd4kLyPdFel7mWexamRiI4UOozZv9xFpgyFn262TwGEyTTZl8w4bWzNhkLKAaasxwoSS5m4ZZXq4d5RWY18VQzXZZmtNPQcTJDNTb0JR6CDE7ExVTQYth/hXsxK/GxbazAhiNgmWcAfTQUCEZ6wNgmwadJvrShixZLOIelckwUzOmVYWEbHDPZDkxjCTGSy2uWQNfM0FKmw2gvHVNzlGeNYiEmZHAsxcCc2kTkwrmqBD8ruzBS2y2e06EjAVBq0jY4tV3yl/fNxgnW575s+WVRWLGe18ng0nSEtTRgHZJayyIi3YFGSsVaKwjAVg2cs/CPj2HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ept92CFTxdgL1NEd/hSbG6vpqoA70PKVV1J0avM9C0s=;
 b=ku7m22RKyMAcnbO/Kp+8ZOP78P1Wun7Xa50XaS+VJpTOa2Incco/5Ct892CIxmJP5g0xi4QWPYwa+KqsElCb2zaHkGpn6hnN8NVTvQwtf1N1FmujHrSDk4z+/0OJqivF5BLtxQirAm783kRFDxbfq9UAavt8r6frTdEBzY7302GdmcVpj+isPunEL8YY8BDos39XaZ2+GOlxSxWWjmYI1tEu+p7NX93kk+QTcPWrlhJJRt/X7NU7o2sqwN9T5xwo8fAo6EJjnG2s6J0W/tPGtw4d0QejYfLslCZawc3kUG7GWF5l82ScrJPSfjPzFcMf7UGnY8ChpPbRMxdTos9agA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ept92CFTxdgL1NEd/hSbG6vpqoA70PKVV1J0avM9C0s=;
 b=SLV3hy/hPOJiF8RukvDe14uoMnzLPxQeGnYpH5fSuMNO/7kJI2rkVkUcdazTwWZrQgtkag9mq7UOu0DUQkyUjzos5VzZGLmhJsSVy61FPEW0ZPihM5sOOI2+GsoXNhGKjjhvM8xrbWoZW1z0xn2q7cZYV0yfzyW1J3Ce9AC6r/U=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (52.135.233.89) by
 BYAPR04MB4229.namprd04.prod.outlook.com (52.135.202.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.27; Mon, 7 Jun 2021 20:37:38 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 20:37:38 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "kbusch@kernel.org"
 <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>, "ngottlieb@nvidia.com"
 <ngottlieb@nvidia.com>, "oren@nvidia.com" <oren@nvidia.com>
Subject: Re: [PATCH v2 2/4] nvmet: make sn stable once connection was
 established
Thread-Topic: [PATCH v2 2/4] nvmet: make sn stable once connection was
 established
Thread-Index: AQHXW37LP7o1au9JFEih6PmSqEp1pw==
Date: Mon, 7 Jun 2021 20:37:38 +0000
Message-ID: <BYAPR04MB4965C4BD68DD41755F8CA15386389@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210607092324.1031046-1-mgurtovoy@nvidia.com>
 <20210607092324.1031046-2-mgurtovoy@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 229d277a-14f1-41d9-16e3-08d929f4170d
x-ms-traffictypediagnostic: BYAPR04MB4229:
x-microsoft-antispam-prvs: <BYAPR04MB4229E39CF1C4B730F3D385F586389@BYAPR04MB4229.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h6fmhm2bWwt/B8muYyvVvJI1LkPOS0J5HTlyb+46Joax4C+wV2uYGNc7UKVVAdGgXveE824f9928yUhL9n/8ursOD7uEOZ88uWTG6934TaKPuXmtw/wowLVutnXfystRtfi/ZPkjIm1EbLbIc0r/PagY3YipO1lUJYMi+jh1UMoMcxQMyeRNJ7mRsc6/nXFdCf7DBo/3t5qw8B9PFZmODqFSInqATosNXO3AWtoyWVFJ0Apr16eFesMb7MZv7cE5cb0JufMOeguZK5H2kYmXU3PLEqrQoB1ivDsshfGc/7Amctv0zg1tFIs/zrq6NJpNkQA74e/tvKqjJCL9+Gt/gaozwI9Bpi0UYy/o4GU9TR9PPKwReBAb0AVwlBSnWwOZenSVDQBLvOT9VXRdsnMcfbrIAC90TdI7VXTdc/Jrl6ymQV4Ktg/qC5mmrmAUb+tefqNKe7Q0UJ4qpwZ5yBARdVcRmGd/ZsPFHsfCSTNLKPCkyJ+pV17I5mfosXpYrYA9qB4OoYkli72fHfqpJnRfiFpxAVIh7JRgtuKd82qTx2lA0tmwaMC9/0lgSG94/9IJwz7Egnakzs14vSUUXgxrRUHY+1fv144qx4WP86uyLoA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(346002)(136003)(366004)(39850400004)(8676002)(26005)(54906003)(316002)(6916009)(8936002)(186003)(71200400001)(86362001)(4326008)(2906002)(7696005)(122000001)(38100700002)(478600001)(33656002)(55016002)(53546011)(5660300002)(6506007)(9686003)(52536014)(76116006)(66446008)(66476007)(66946007)(66556008)(64756008)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?zwFw7zRzTmH4+RpOZY1xkxTC4Ux9BM1317n2zbcrXHom8ndI5b2uh7+24/fX?=
 =?us-ascii?Q?Mvhv7/z+626Rm2PYwGNsEaXcwHZbbgTewGXEUbo5I38yLZK7i5F9QK3QRO7N?=
 =?us-ascii?Q?tqBQ083PcepXin326iv4PZ7Kw61ek8lhgA9yLJsTTKyd+Zn3EQGJjCH5lMwf?=
 =?us-ascii?Q?uOgpqVFNozbxn5DoriKmvov/A/dCvLgE6+7V+DeXV+DSZVKad/3vJBajSrLK?=
 =?us-ascii?Q?bMsFM4hHW1NY6abLJ15CcXspC6WhhP7EuRhMgVIZpLMZqPgHXNoookBy01Wk?=
 =?us-ascii?Q?9zmxnUuFGbhJB0cCBRGQiNPaFMfUUZB6rRzlfG4qtJ9kuSpu02daOlRic1f+?=
 =?us-ascii?Q?nRXpVPpR9fPyuWueWVHWt/v13RJfOZwll5Vf8VCEQWY2YNi83TUEzFua7MGM?=
 =?us-ascii?Q?xzRI2XRl9AnccZpmpfcVFvkN9wAEdVxRQBKzQGuflusRZGck3gjaKLfkbhEG?=
 =?us-ascii?Q?Yu6W54bY8ujo8h/XCzslmMzzPSt0kOD+/RMMtbgfa+pnMd94Oy7R+chhmE0E?=
 =?us-ascii?Q?oCdFkR56CwuJEpKcmdbUWyB77BrpiQyFlr/1PQLR/h4j8WanIbEmCmsJGqpK?=
 =?us-ascii?Q?tiOI3dXjsAzFrtjCZ3OfSqCGsCnPtCD51TDlMdgOc9tlSGmqzFa2VtDfAzBg?=
 =?us-ascii?Q?eXzoOoOe3oUYzRMZ4b8KytRO3tjEQixCcT3tQMT8bXhy3yfDWcdiyaGiiKkE?=
 =?us-ascii?Q?5xW1cRxJorhQtDOuit5Y/ogieTxV3aPY88kZN/HQpGR9f0N2AFVRyAo/XYtP?=
 =?us-ascii?Q?Q9EfHTO36G5ReewdEPBNh6bO2lyzdCUwus0Sk9/uuBfMbOHAV+PIk8OPLIK7?=
 =?us-ascii?Q?qsOQRAekt2yFeLrMpUhrPSFHG04OX1rFQr5JfZYIX9Ti5ApL/EGZ5fpMTauT?=
 =?us-ascii?Q?pZ3/qp7Uq6FNYWyrYNXGf/mZFcDwULrKTLSTdTilR25nruMctsxkU0uDQW+l?=
 =?us-ascii?Q?VFgmuogaSHebEUzw/RcaqdhuCz0QaR3bDesJAlIY+B/WxYiTr5ca3Y3PxNCZ?=
 =?us-ascii?Q?TeB4Sou/oRUTo0SvcgQIDv8RTR8f2Z0eG3SJZZT60JuZLh+M6xOrdYYZhk5O?=
 =?us-ascii?Q?b2Pb4+q7geyXfII+2T5aSygTa1iuMHvs1bYrJTNcEfceedCRKjhfRsi0Hnbf?=
 =?us-ascii?Q?kk10dKCys6Sz+82qThCdeOnMvCsIJEJk6yGW59PpWSQDqeif9XZ8uzX2BlN8?=
 =?us-ascii?Q?93hTWkf0nQ2FZoeyB2u121Fjo+XW92wJqhDqSRwbxV+ivh7Ya3NG4jqFGjIB?=
 =?us-ascii?Q?bFZI5Le3GeV1TqbtCzynsaujhkKeeIbTlOvArX4cMKME23DTdl53Pm3BLAnL?=
 =?us-ascii?Q?qxAc8kAfLDwB5KiADgY4erp1?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 229d277a-14f1-41d9-16e3-08d929f4170d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2021 20:37:38.3659 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UKmR5P7/NIM8+CKJHfWl0xxca/lJVX0LjmlveYbg+EO/+dzmqifYHHwZOMXSxc6zVNkXxNPJeUEp3rL+FCryAO6ALDc96VTBxbzIDUoUMI0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4229
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210607_133742_413864_6F4B8DFB 
X-CRM114-Status: GOOD (  16.91  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Max,

On 6/7/21 02:23, Max Gurtovoy wrote:
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index 0ae809ca428c..bd0a0b91d843 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -231,6 +231,7 @@ struct nvmet_subsys {
>  
>  	u64			ver;
>  	char			serial[NVMET_SN_MAX_SIZE];
> +	bool			subsys_discovered;

When subsystem is discovered (connected to the host) we will have non empty
controller list, instead of adding a new bool variable why not use
something like following tested patch on the top of this one ?
(that also fixes the indentation of
nvmet_subsys_attr_serial_store_locked()).

diff --git a/drivers/nvme/target/admin-cmd.c
b/drivers/nvme/target/admin-cmd.c
index bec84c231d37..897f419be618 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -366,12 +366,6 @@ static void nvmet_execute_identify_ctrl(struct
nvmet_req *req)
        u32 cmd_capsule_size;
        u16 status = 0;
 
-       if (!subsys->subsys_discovered) {
-               mutex_lock(&subsys->lock);
-               subsys->subsys_discovered = true;
-               mutex_unlock(&subsys->lock);
-       }
-
        /*
         * If there is no model number yet, set it now.  It will then remain
         * stable for the life time of the subsystem.
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index a13da86fb374..94e23dca763f 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1046,11 +1046,11 @@ static ssize_t
nvmet_subsys_attr_serial_show(struct config_item *item,
 
 static ssize_t
 nvmet_subsys_attr_serial_store_locked(struct nvmet_subsys *subsys,
-               const char *page, size_t count)
+                                     const char *page, size_t count)
 {
        int pos, len = strcspn(page, "\n");
 
-       if (subsys->subsys_discovered) {
+       if (!list_empty(&subsys->ctrls)) {
                pr_err("Can't set serial number. %s is already assigned\n",
                       subsys->serial);
                return -EINVAL;
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index f7fbf9690ce8..73c6c4dc8997 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -232,7 +232,6 @@ struct nvmet_subsys {
 
        u64                     ver;
        char                    serial[NVMET_SN_MAX_SIZE];
-       bool                    subsys_discovered;
        char                    *subsysnqn;
        bool                    pi_support;
 

# nvme list
Node                  SN                  
Model                                    Namespace
Usage                      Format           FW Rev 
--------------------- --------------------
---------------------------------------- ---------
-------------------------- ---------------- --------
/dev/nvme0n1          foo                  QEMU NVMe
Ctrl                           1           1.07  GB /   1.07  GB   
512   B +  0 B   1.0    
/dev/nvme1n1          bf854da611a264d448c2
Linux                                    1           2.15  GB /   2.15 
GB      4 KiB +  0 B   5.13.0-r
# echo 1 > /sys/kernel/config/nvmet/subsystems/nqn/
allowed_hosts/       attr_cntlid_min      attr_serial          passthru/
attr_allow_any_host  attr_model           attr_version        
attr_cntlid_max      attr_pi_enable       namespaces/         
 # echo "1234567890" > /sys/kernel/config/nvmet/subsystems/nqn/attr_serial
bash: echo: write error: Invalid argument
# dmesg  -c
[311081.155148] nvmet: Can't set serial number. bf854da611a264d448c2 is
already assigned



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
