Return-Path: <SRS0=9ZED=LE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335F5C47094
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Jun 2021 03:53:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E039861412
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Jun 2021 03:53:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E039861412
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=WnNE1WAdACLcSo/dbO+ur/f+EnpXkeT0EgZTMPaR2cY=; b=TvWmVOVN0l91H6
	pNOYO5Y57r2S7QDf+fzg8cabs48iH+Ae/g172gJ91x6yDhoVjLL2zrS7KBjN8i4dKJszk/hJz7vI1
	sULjuBD7X8Fi/psH3dHdPu344aKXdi+CvSp+J+ikmmdy0v/HJdHsY2+2aXJywkrBrWcR9mejTL2Uw
	+RqW7rf2I46BAAn4a4sYwTek9kaszUiskyo3axKEgIIsqZ6pXHkMiWFiBa/asKPhaVT72Fo9cGkOd
	Uje8lKxfsh/O8ODVWId5tEuZR/bfV1ZuTAs3ENQNTWUIa6YKlv3zcGFHPOmYyATyhmX5AWP/XR7Ar
	6kFvkZeCKF9axCnaJ20Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lrBl2-00Ghvp-Vf; Thu, 10 Jun 2021 03:53:29 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lrBkz-00Ghv0-M5
 for linux-nvme@lists.infradead.org; Thu, 10 Jun 2021 03:53:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623297205; x=1654833205;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=ynejzHUZkD7ensai/hqEphL+GJ/+/q91DXpSHZge+5w=;
 b=JoXA773+Aw09kSN5zBuVSKoKGpjlZa3xVB9K/fbcMyU7YswUqxnZ6US5
 EkAPtFRLMJVPe701kZAjhU64KX8KYW0uBgxc6TosebfNMqQFe19izd/Yl
 3+sIbc6+ZYrDUIRn5ND4+cKMb/xQi7dgVWqzgRxENPv8z2zcWpTbfE/bQ
 Ekg8zbYGmrI8MqcvSiBzp/hjjnU23nSp6U4Ab6sX4bqP49DIXm6MXRQWP
 Faj79ECH82yy+IIThVVs0hTLwYuwZoucdfJO+iSwgVbNfHga1Bf9YKuS2
 GHXTsS6s5Pyj3zawLrDPVPyPMdqAJ6QpHdCnLvaFKz3Sqhbq/1RDPOcw7 Q==;
IronPort-SDR: xeiTvvuq07efv3/ayu4wQYOcFBVcCet7H87rk5apThj8Ljvu/k3gNk3UeEpqSpeqZWMyUihobC
 CNZUDBZOtrqtluFPku8kD7qzroIJXZDb7gWds/Z3A6oT5ZZQ+7kqM34nU/X6dKhzgudWKlLwK8
 fiC960KySGOCxokTvSIEGJYbZb7ggirz5guOuo98XujvLyTHA/r7oMQ6mTzazZFxHLOgfxz1ZP
 v3Ad12aG/Y53wENaLCAP9dLLrye0qyRJHqf11M3Q9C7xnV2HeOuOUKusI92t5OJpoZFAosVH4/
 cQc=
X-IronPort-AV: E=Sophos;i="5.83,262,1616428800"; d="scan'208";a="170669135"
Received: from mail-bn8nam11lp2173.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.173])
 by ob1.hgst.iphmx.com with ESMTP; 10 Jun 2021 11:53:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d20b/+q5vkMkgdzofyPED3d0VfjSEBMPEQXIr93YA52j3Pc5Kh7CGPaihtep7ENNNAUB/S4Q7LLZQYpsfE/pVQbotFqXDCRdtUSD4xHcSM1MusercH+5/t8CdmDlxt1SZIXXn6b14v/bBd1XP2jzdZdAZbKhuF9hF22F71+m+vRVVvBUEsYL2gj5tGseSyCubxNdc7kzPjEbYtxkGfyO36cmscaoHjXgKqAK7Kr3zn7UGsdJmk3w9GpcK2GyK0wgA8/jUYc4zcU5/kohGxCDmm+aTKCUOo8JDCXkQ2PJuZxdNGuoo41clAdgHBOP6TCSeplP/rLfvQjXVWFEB6VY0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eai0zIlC0LPrrj9kdPEgEP1avMSLO0riC26IlLOkDGU=;
 b=TAJROUNTWca4k4COjzxP4iD2uyAp+Gj3NVU/eWCEFYyXDSquvRCjxkNOG14QJagkR+hC8DT1AMtyqzvKAg/17yxAkOo9E6neoAAo7e8dkeDzjDILL+4R7PUBios+iTwyXpyEKCr/Pvf5YlVIThunI/atq5y6zktOlHO+VQTp9h6HTFnh+JQ7iHExqmD8FTzNwuyO2QOct+8ehH6MMZ0b9aCNEceC2zbr89qoKvNTpQrGsNcKInA0aSnP6htr0Sk32tUh2gicnysIe9UOglOn2RLxgRaFn8/3NEN0ehDxes8TtZXXoqrdVpyDfqc/W2RHxV392MNLGSqo/X/pn7dSpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eai0zIlC0LPrrj9kdPEgEP1avMSLO0riC26IlLOkDGU=;
 b=XZnavt3cV5aBC7M/7zD+Uau/qfs1vhtze3tgVC/ss0vemvNaTG7omHSCOM4UdpNO5SBoceJOziCB5/YknFiUAdyiGlC8xhgGsfgk60+eDiMBwjHERSmuDihcosIMpMJYieGNuJZUOVwuY7kEmNw9DlNDZ1BHVq82Zrf41+YJ4r4=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6422.namprd04.prod.outlook.com (2603:10b6:a03:1ee::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Thu, 10 Jun
 2021 03:53:21 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4219.021; Thu, 10 Jun 2021
 03:53:21 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
 "james.smart@broadcom.com" <james.smart@broadcom.com>
Subject: Re: [PATCH V6] nvme-core: use xarray for ctrl ns tracking
Thread-Topic: [PATCH V6] nvme-core: use xarray for ctrl ns tracking
Thread-Index: AQHXXBAB1eC95a4h5kiXNQoT2WTT3g==
Date: Thu, 10 Jun 2021 03:53:21 +0000
Message-ID: <BYAPR04MB49651675991A7EC80AB1836186359@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210608024247.35286-1-chaitanya.kulkarni@wdc.com>
 <dbab5916-a6de-5cd0-4bb5-b06d0349df0b@grimberg.me>
 <BYAPR04MB49657620DF9C7EA9158DB60686369@BYAPR04MB4965.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f22a4c66-a111-4669-65a5-08d92bc34a64
x-ms-traffictypediagnostic: BY5PR04MB6422:
x-microsoft-antispam-prvs: <BY5PR04MB6422EBF55F56EA3A2C6AE0C986359@BY5PR04MB6422.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 17Y4sZt2qcStAzdSLDGRx3uOCjp69QZ46RTjG4A0wKjGvhESeAs3Llx674T6KVu7Hkoh9sHoXBngmGD0OwB+UMG6tsjmz2w/j7hhR7ycQBFDdGG3Dp7WIQSULcwp5wt5qgOEnS04YKibMQ0ILfSvhd7rpms+X8roj/aaAOe2yIZKA7kiXRMV6b96dO5UMEA0PsKxilVSMCOx7dWUkgI4zWHZ6YfaN6Du3R+J9Zyakl3kLEiOzRZY+qh3nyot50eVK1NUy+wKoBXkX8hI6UQBDibtWYL3B/Uwnnz2f4AL4Cks7CGmDha/2AC+R8PlCW52x4vmjypRtXWKa+MV9oF4vO8s9kphs2H7GRtPZwR5BqEBVYtDeA19/p7Xs4w3y3kAXAe/NtW9yRPVcyH1EymK8szffo/cI0xHE7LFhcOyY+FTBBT8TlANOFfdIyIX6lFTMci24+TQDYEpgTZ202nALBYinkxzZP7JJfz5FE9T8xny+no0zxbIUVdOZO09podiYlFvxAnby/ZYfBEdmOxM/CHsjHZzidDfl3in8KUtbRuGNKS5Aj3t9lIqPkd50cN6Pf/g+B2lZwpTn7NH9tEHDIxBFsNVnDnIyhL2MRDOZAU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(396003)(39860400002)(366004)(6916009)(478600001)(71200400001)(6506007)(26005)(83380400001)(33656002)(7696005)(5660300002)(8936002)(86362001)(186003)(38100700002)(66556008)(66446008)(76116006)(64756008)(122000001)(66946007)(66476007)(54906003)(55016002)(53546011)(2906002)(52536014)(9686003)(4326008)(8676002)(316002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?q3TijSERvkj0LnYqqEZ6tm/+VfqKs/NYKXQDPGjWG042BAaDtiQZ/Z0U1Gq6?=
 =?us-ascii?Q?wLs94+NvR94lslWkPLQCPZsR+csZBKRCEmLAD34digWbj8uRInlLzhtagCik?=
 =?us-ascii?Q?LqAfFGHLDd78taI+Uq7SmP4HTptxSAHQLPzSTlf0pQL62RJIuwQeS3FLDYGB?=
 =?us-ascii?Q?YZHqobphssOgLao8+SljHCDL2Nd2hTar2/Bq01UE/fMR+KH8QI3LDDXKMTi/?=
 =?us-ascii?Q?oEXIt4L8xqLdjO7uCxviY0reMMY0A+wj9L69CWbVZD4cTv/3TJddK9Fzn/kj?=
 =?us-ascii?Q?QiV08XsYBy8jCgjn+OWIBhC+ORN5/JLv/Wi88FuY9TQWNASsNjGU9kjhQFWx?=
 =?us-ascii?Q?gTag0P3d5GqpjlC9SF0M0UCDNpclyjZETsDdyV/KrdDaSsVWXfmM+pEe5UUC?=
 =?us-ascii?Q?kFJhr5OwGOMZrAtP7c6yUB5E46J7T4hJ/6XCN8erDTAsNbFE8+aLhkHfrWlx?=
 =?us-ascii?Q?BpkZXkgqjVksdj/iKRWpBobZRFu7T7v+O2neZXVRn1jdfON8lM+JaI/k0Sa5?=
 =?us-ascii?Q?NpgM7qCCBt8sG9jjzvzxx4LuBvvLPBmzzVdOGXXm6I10HYdKRa+QBRzDihgY?=
 =?us-ascii?Q?ztWEgoRTpKvn8D68MfZgyH1yL/ezmRDYmhX1QIQ14H68+RBGucdLwhnqTqvu?=
 =?us-ascii?Q?scvttZ+ajwroNVLEdEGtO79iJVe1HN0XTNbfblBjQyz9x7HWappuALfsv14f?=
 =?us-ascii?Q?hiM3oCk/Qj+rrAxkPbLGNRxHXWeqQ8GS55mU4FTnIVJgDzbf7zutfOgsC+FS?=
 =?us-ascii?Q?7VRcn8dHSyhR5eM2KTZMH77shuZE4yqNgKGSN/afSNXGPQ5TU0Y3mYquEY9b?=
 =?us-ascii?Q?thhP5wCMzfdCD47mCI77cKz5jcCObQze/o7B+FRsrTeIBGxtWE+E1Hejq3i+?=
 =?us-ascii?Q?Tduym6Y+kLJDUVWEJHhG4ruaFpJ6Vwcv0bxRu63AqdVzpWnbm1roXGw4BMjI?=
 =?us-ascii?Q?yQ6Hwq8HUC7XYJ5sbWhQcpshYawFWL3VwO7m9x9Dtnq4XzFVUGzJU+pKp9fU?=
 =?us-ascii?Q?ekfMKwodi2OtuEDTb53vruMey5DpexCO0hwDpYQ0aypeJ/fhmcZTqR5bZl99?=
 =?us-ascii?Q?6Y6dff700NUA2Dp32FjBZPBe+Zlgrkv68h0RVaT6tysfXImJQoSUTguZ6W5M?=
 =?us-ascii?Q?+0fdoNuyzyYVZqnuh7D7auCaUsXYmgwYCpCcadF1MBvZBRSihxQXtxl6c0o8?=
 =?us-ascii?Q?kvFY8SYD9qOh1+wAQ5AnnrhegoTEggPxo1TexZr1DoLsTxFkubKTEP+W6CbP?=
 =?us-ascii?Q?ryKFym2yznEg1ofCqxReJ/yawmu9osqlaQGubZdd2/qyrUKxHpAdJnHCJb0b?=
 =?us-ascii?Q?gYYGSWVBEPycR1fBe1mrS+zq?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f22a4c66-a111-4669-65a5-08d92bc34a64
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2021 03:53:21.4637 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f78N7xiXDFigbJHsSWh3Fi3hvu/3Z823JPQjfx29jtyG42Ish8iX/QdxD/F097Kk3eONmYxZb4OQ0oRklKJTyfZ81ynthXKtLMJspKBUNFk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6422
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210609_205325_852417_8BEE2A8B 
X-CRM114-Status: GOOD (  15.42  )
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

On 6/9/21 13:48, Chaitanya Kulkarni wrote:
>>>   
>>>   static int nvme_scan_ns_list(struct nvme_ctrl *ctrl)
>>> @@ -4068,10 +4051,6 @@ static void nvme_scan_work(struct work_struct *work)
>>>   	if (nvme_scan_ns_list(ctrl) != 0)
>>>   		nvme_scan_ns_sequential(ctrl);
>>>   	mutex_unlock(&ctrl->scan_lock);
>>> -
>>> -	down_write(&ctrl->namespaces_rwsem);
>>> -	list_sort(NULL, &ctrl->namespaces, ns_cmp);
>>> -	up_write(&ctrl->namespaces_rwsem);
>> Is xarray sorted by nsid? ana updates rely on ctrl->namespaces to be
>> sorted. Where is nvme_update_ana_state change anyway? you tested this
>> without CONFIG_NVME_MULTIPATH?
>>

We insert the code ns into xarray with nsid as index so there is 1:1 mapping
between the ns, nsid, and the array index. Given that it is an array in
iteration it always starts with the first element. Hence no sorting is
needed.

To check the correctness of the code (with multipath enabled) I used the
quick
debug.patch [1] and here is the the output [2].

nvme: print all the ns in id-ns from xarray

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 6fdbb0a22f3b..1f33fd46bf34 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1425,6 +1425,8 @@ static int nvme_identify_ns(struct nvme_ctrl
*ctrl, unsigned nsid,
 {
        struct nvme_command c = { };
        int error;
+       struct nvme_ns *ns;
+       unsigned long idx;
 
        /* gcc-4.4.4 (at least) has issues with initializers and anon
unions */
        c.identify.opcode = nvme_admin_identify;
@@ -1452,6 +1454,10 @@ static int nvme_identify_ns(struct nvme_ctrl
*ctrl, unsigned nsid,
            !memchr_inv(ids->nguid, 0, sizeof(ids->nguid)))
                memcpy(ids->nguid, (*id)->nguid, sizeof(ids->nguid));
 
+       xa_for_each(&ctrl->namespaces, idx, ns)
+               pr_info("%s %d nsid %d\n", __func__, __LINE__,
ns->head->ns_id);
+
+       pr_info("%s %d------------------------------", __func__, __LINE__);
        return 0;
 
 out_free_id:


Creation of the bdev controller with xarray (/dev/nvme1) and using that
as an
input to the passthru controller (/dev/nvme2), iterating over the xarray and
printing all the elements. All the ns are printed in sorted manner for the
passthru controller :-

[  229.877166] nvmet: creating controller 2 for subsystem pt-nqn for NQN
nqn.2014-08.org.nvmexpress:uuid:e4cfc949-8f19-4db2-a232-ab360b79204a.
[  229.880143] nvme nvme2: creating 64 I/O queues.
[  229.901741] nvme nvme2: new ctrl: "pt-nqn"
[  229.902230] nvme_identify_ns 1460------------------------------
[  229.932624] nvme_identify_ns 1458 nsid 1
[  229.932634] nvme_identify_ns 1460------------------------------
[  229.961368] nvme_identify_ns 1458 nsid 1
[  229.961375] nvme_identify_ns 1458 nsid 2
[  229.961381] nvme_identify_ns 1460------------------------------
[  229.986053] nvme_identify_ns 1458 nsid 1
[  229.986060] nvme_identify_ns 1458 nsid 2
[  229.986063] nvme_identify_ns 1458 nsid 3
[  229.986068] nvme_identify_ns 1460------------------------------
[  230.010679] nvme_identify_ns 1458 nsid 1
[  230.010686] nvme_identify_ns 1458 nsid 2
[  230.010689] nvme_identify_ns 1458 nsid 3
[  230.010691] nvme_identify_ns 1458 nsid 4
[  230.010696] nvme_identify_ns 1460------------------------------
[  230.034748] nvme_identify_ns 1458 nsid 1
[  230.034755] nvme_identify_ns 1458 nsid 2
[  230.034758] nvme_identify_ns 1458 nsid 3
[  230.034761] nvme_identify_ns 1458 nsid 4
[  230.034763] nvme_identify_ns 1458 nsid 5
[  230.034769] nvme_identify_ns 1460------------------------------
[  230.058996] nvme_identify_ns 1458 nsid 1
[  230.059003] nvme_identify_ns 1458 nsid 2
[  230.059006] nvme_identify_ns 1458 nsid 3
[  230.059009] nvme_identify_ns 1458 nsid 4
[  230.059012] nvme_identify_ns 1458 nsid 5
[  230.059014] nvme_identify_ns 1458 nsid 6
[  230.059019] nvme_identify_ns 1460------------------------------
[  230.083433] nvme_identify_ns 1458 nsid 1
[  230.083440] nvme_identify_ns 1458 nsid 2
[  230.083443] nvme_identify_ns 1458 nsid 3
[  230.083446] nvme_identify_ns 1458 nsid 4
[  230.083450] nvme_identify_ns 1458 nsid 5
[  230.083452] nvme_identify_ns 1458 nsid 6
[  230.083455] nvme_identify_ns 1458 nsid 7
[  230.083459] nvme_identify_ns 1460------------------------------
[  230.107702] nvme_identify_ns 1458 nsid 1
[  230.107709] nvme_identify_ns 1458 nsid 2
[  230.107744] nvme_identify_ns 1458 nsid 3
[  230.107748] nvme_identify_ns 1458 nsid 4
[  230.107751] nvme_identify_ns 1458 nsid 5
[  230.107754] nvme_identify_ns 1458 nsid 6
[  230.107756] nvme_identify_ns 1458 nsid 7
[  230.107758] nvme_identify_ns 1458 nsid 8
[  230.107763] nvme_identify_ns 1460------------------------------
[  230.132132] nvme_identify_ns 1458 nsid 1
[  230.132139] nvme_identify_ns 1458 nsid 2
[  230.132141] nvme_identify_ns 1458 nsid 3
[  230.132144] nvme_identify_ns 1458 nsid 4
[  230.132147] nvme_identify_ns 1458 nsid 5
[  230.132149] nvme_identify_ns 1458 nsid 6
[  230.132152] nvme_identify_ns 1458 nsid 7
[  230.132154] nvme_identify_ns 1458 nsid 8
[  230.132156] nvme_identify_ns 1458 nsid 9



Now disable the 5th and 8th namespace from target that should leave nid
5 & 8
but rest of the namespaces should be printed in the ascending order
in the ns rescan sequence :-


# echo 0 > /sys/kernel/config/nvmet/subsystems/x/namespaces/5/enable
# echo 0 > /sys/kernel/config/nvmet/subsystems/x/namespaces/8/enable

[  620.836412] nvme nvme1: rescanning namespaces.
[  620.836985] nvme_identify_ns 1458 nsid 1
[  620.836993] nvme_identify_ns 1458 nsid 2
[  620.836998] nvme_identify_ns 1458 nsid 3
[  620.837003] nvme_identify_ns 1458 nsid 4
[  620.837007] nvme_identify_ns 1458 nsid 6
[  620.837012] nvme_identify_ns 1458 nsid 7
[  620.837017] nvme_identify_ns 1458 nsid 8
[  620.837021] nvme_identify_ns 1458 nsid 9
[  620.837026] nvme_identify_ns 1458 nsid 10
[  620.837034] nvme_identify_ns 1460------------------------------
[  620.857901] nvme_identify_ns 1458 nsid 1
[  620.857909] nvme_identify_ns 1458 nsid 2
[  620.857913] nvme_identify_ns 1458 nsid 3
[  620.857929] nvme_identify_ns 1458 nsid 4
[  620.857933] nvme_identify_ns 1458 nsid 6
[  620.857937] nvme_identify_ns 1458 nsid 7
[  620.857940] nvme_identify_ns 1458 nsid 8
[  620.857944] nvme_identify_ns 1458 nsid 9
[  620.857948] nvme_identify_ns 1458 nsid 10
[  620.857956] nvme_identify_ns 1460------------------------------
[  620.873913] nvme_identify_ns 1458 nsid 1
[  620.873921] nvme_identify_ns 1458 nsid 2
[  620.873925] nvme_identify_ns 1458 nsid 3
[  620.873939] nvme_identify_ns 1458 nsid 4
[  620.873943] nvme_identify_ns 1458 nsid 6
[  620.873947] nvme_identify_ns 1458 nsid 7
[  620.873951] nvme_identify_ns 1458 nsid 8
[  620.873955] nvme_identify_ns 1458 nsid 9
[  620.873960] nvme_identify_ns 1458 nsid 10
[  620.873969] nvme_identify_ns 1460------------------------------
[  620.887976] nvme_identify_ns 1458 nsid 1
[  620.887983] nvme_identify_ns 1458 nsid 2
[  620.887988] nvme_identify_ns 1458 nsid 3
[  620.887991] nvme_identify_ns 1458 nsid 4
[  620.887995] nvme_identify_ns 1458 nsid 6
[  620.887999] nvme_identify_ns 1458 nsid 7
[  620.888002] nvme_identify_ns 1458 nsid 8
[  620.888006] nvme_identify_ns 1458 nsid 9
[  620.888010] nvme_identify_ns 1458 nsid 10
[  620.888018] nvme_identify_ns 1460------------------------------
[  620.901911] nvme_identify_ns 1458 nsid 1
[  620.901919] nvme_identify_ns 1458 nsid 2
[  620.901924] nvme_identify_ns 1458 nsid 3
[  620.901928] nvme_identify_ns 1458 nsid 4
[  620.901932] nvme_identify_ns 1458 nsid 6
[  620.901936] nvme_identify_ns 1458 nsid 7
[  620.901941] nvme_identify_ns 1458 nsid 8
[  620.901945] nvme_identify_ns 1458 nsid 9
[  620.901948] nvme_identify_ns 1458 nsid 10
[  620.901957] nvme_identify_ns 1460------------------------------
[  620.919913] nvme_identify_ns 1458 nsid 1
[  620.919921] nvme_identify_ns 1458 nsid 2
[  620.919926] nvme_identify_ns 1458 nsid 3
[  620.919930] nvme_identify_ns 1458 nsid 4
[  620.919934] nvme_identify_ns 1458 nsid 6
[  620.919938] nvme_identify_ns 1458 nsid 7
[  620.919942] nvme_identify_ns 1458 nsid 8
[  620.919946] nvme_identify_ns 1458 nsid 9
[  620.919950] nvme_identify_ns 1458 nsid 10
[  620.919959] nvme_identify_ns 1460------------------------------
[  620.933910] nvme_identify_ns 1458 nsid 1
[  620.933918] nvme_identify_ns 1458 nsid 2
[  620.933923] nvme_identify_ns 1458 nsid 3
[  620.933927] nvme_identify_ns 1458 nsid 4
[  620.933931] nvme_identify_ns 1458 nsid 6
[  620.933935] nvme_identify_ns 1458 nsid 7
[  620.933939] nvme_identify_ns 1458 nsid 8
[  620.933943] nvme_identify_ns 1458 nsid 9
[  620.933947] nvme_identify_ns 1458 nsid 10
[  620.933956] nvme_identify_ns 1460------------------------------
[  621.022320] nvme_identify_ns 1458 nsid 1
[  621.022330] nvme_identify_ns 1458 nsid 2
[  621.022335] nvme_identify_ns 1458 nsid 3
[  621.022340] nvme_identify_ns 1458 nsid 4
[  621.022344] nvme_identify_ns 1458 nsid 6
[  621.022348] nvme_identify_ns 1458 nsid 7
[  621.022352] nvme_identify_ns 1458 nsid 9
[  621.022355] nvme_identify_ns 1458 nsid 10

Hope this answers your questions.



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
