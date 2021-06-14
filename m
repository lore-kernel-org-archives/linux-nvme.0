Return-Path: <SRS0=JVDK=LI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BECC2B9F4
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Jun 2021 21:23:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FA1F60FF4
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Jun 2021 21:23:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FA1F60FF4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=6kc14C4I0aGfqAyjSPInTmMUgtkstJxocHczbzXzDPo=; b=qcy+wFRE+VmqgJ
	swmVXAekBX99u09TCvxOk5v8P1b7shi1GxuGuUEvuWTL3Yw60M8gmWlmzjfs/6xlI4j6Crx4Q3xlO
	fgEtPSVc8Y51bBRHZYzL7hbMG26o4rA9xhAoImmzQSdXky2S2wsrUsdALY1+TGHP1n2W3eiyZq3HR
	cDL0Rulp2oVSgXyHtZ2MuayYqwMo1tEFKFKw4k4Ln2EpM3X/wuNIyI2f0YDUoZKvj3gTToTjvG1Uo
	Z/zaYI+Sf8CO074W8U15awrjwSxrsqiLNIP7vxh4to4Zv/YSTuebfaDElF/HGeBxer95BJQ+LwWxW
	6OKGQC2cNkT+hrhL3p0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lsu37-00GDKE-SK; Mon, 14 Jun 2021 21:23:13 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lsu35-00GDJk-SL
 for linux-nvme@lists.infradead.org; Mon, 14 Jun 2021 21:23:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623705793; x=1655241793;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=EYLOX4ZaPPmBZ2SihQna5eCBisgF6SezXXyL0idN1u0=;
 b=cNtN5UmvAYayGBt9AM4bIUGRY7YLjmSu+VxFznKSEK/Qbpgfor2Yd2ln
 DHn94DmW9a+V5G1vUsZ/sU6+dSW3OopA0TFpN7ekSEvrFJI/oj2HW0m6g
 f04gsQpPGceKNbqR1OGiLQ/ESjI33FhGGpny4BRQTsHbznBph6hkeM6Kb
 sR01fzzA8lF8uFfXhFdrSHSRsirs64TfOrzdZ3SzD2oOXmEUHKzpN8rSs
 erQRFyiQaSaGXqrqW+YKcCV6SD/mHcCCdXP0pjttOJz4bMA7Yeua9Z9T6
 yx/0++k7sq4R+k1h7dWV1kqHaR4JT99+XedCFK5krwvWs7rW3un2utOTD w==;
IronPort-SDR: Z7yDvjh0p9vzTNyHGh4qreTxc0iD/vbATlVBcg8UMKoahgTHKtz9mD2NMHiFF2RujDIjG6htPE
 NEcGl8cHVV0D8N+is4i7efsUVqhBslRwDKtl2JaQUdRhqGGRW2SQkPjpfcALppU561EhwmhNDe
 GGBRhM4zyjubuM5foxJPtGMNayplMdqQNXGkVptNVQD43FoiKYX3UXBD6qlCHkeLruXeHkjtPN
 XXqzJF9zpDywmYl5Wi/at5d6P/yH0eZgHETNyaCGK5j3NrVjRFjnh4pCiqO09KrkTHVIt+hSxx
 +wA=
X-IronPort-AV: E=Sophos;i="5.83,273,1616428800"; d="scan'208";a="275661453"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO
 NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
 by ob1.hgst.iphmx.com with ESMTP; 15 Jun 2021 05:23:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KvH78afjSc6BP8vAAR3OUQ6eDORMGoNuT+iQ/cTB9r80cAgSVvLvPgCGQTGzIVVHZWgvfYlfzCwD4jtPWQtJO/njaHP5+mMNJsqADAcMrOKZg2vXNQPFZuek+l0dIWpUs9z9HMGGKGVifJ1kfPjyOtMXm779XI9SAlCuxscbf5P80OlH8vdOV6Cmh76R26jjr4UhO83HIA9Z5CkD/xguoNv56b3Q829LHAkzvTR1e0kMMfVAJyq0LIhoQHOScBeQy5yETq5qybPsa/RP/pT26IRYKqJ7G4v8iuetXwviP6P42NtARvWyASP8BKsuet0RWlO/YSZoezm+NvXL40rNSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2VDojilSKvxGMahTWyOqDpaurvwlgXFhiqyBI7wOk+w=;
 b=Uca7STuFOGWdVZozH83WMAwwM5klQrdV+9Q7UL6VUDhhiKX4WbM2CB3W/64VXBc185DPpGRLzfr5Jm5m5n9jK0nXoisvld00IWp0yT/M6lM/711qSB9Vj67GVS4GMAO8pMSJ79bZOmQK06XE6zAepFc/w7MsICbYMqGZ5ghL3ibROzaNC2qlfXsOzstII6AQIaL/QPnGDTNfAtTxqCdpv+/+sMC/CxWxJHT16dUQT0L5Qcy9VeckPSLNt6qGhDM2daRsEjlrne1Iufza9wFmpKvNB6tFqORHo2Yheqgks7fRyPnYJ7pQ6749uhUnpPIZa8eBLbre4YmwjB2yv3D0lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2VDojilSKvxGMahTWyOqDpaurvwlgXFhiqyBI7wOk+w=;
 b=nbsj15Ms2Mw20Bys5BDri0NPCUpZ9nHI5VcPW5mVcC27dBFei2++CR7qvHevJU8mWxKDkv/rsd/NTTVF73Ij4eEfFsSWqfE5eek3hvRt+w4HKtiAuq8r5QwvADx8VemQpZPUObPEX0/Q7p1rswKV+fa/Nyc4ptkp9aQ+ih/CncI=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6884.namprd04.prod.outlook.com (2603:10b6:a03:222::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Mon, 14 Jun
 2021 21:23:08 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 21:23:08 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Keith Busch <kbusch@kernel.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH] nvmet: use U32_MAX value to report NN
Thread-Topic: [PATCH] nvmet: use U32_MAX value to report NN
Thread-Index: AQHXYVYUTOcFnEzDoEmtA9GMTbY23w==
Date: Mon, 14 Jun 2021 21:23:07 +0000
Message-ID: <BYAPR04MB496590CDFF6E7589895BE0F186319@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210614194712.622-1-chaitanya.kulkarni@wdc.com>
 <20210614211840.GA646237@dhcp-10-100-145-180.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3baab17d-6c66-4740-db08-08d92f7a9aeb
x-ms-traffictypediagnostic: BY5PR04MB6884:
x-microsoft-antispam-prvs: <BY5PR04MB6884A591CF914841B9F321EE86319@BY5PR04MB6884.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kE8CcvhlxbGrDNVe5MP0ONnxZq8bCFl1GbGGNToP95vJWb2t9TA7DCyKkwgRToPdmvKijB3akR/ZkyhBdj1easvGWs2hjh07AgiTLTwuqfrEqZV34H/Kb7eeQ/7bHmDduBOiM0nnMP4uMK319CuO4bahQsX0hnHYYYOIkGRfXAM1X8ujhuDfAtpdU8VUyqHfA4iZEEQYMt6I/l7NKgMSMxMsvJiJmlXoe/j/2JeXvLbDKbNc+DnRFAitUutDFE8YCzPt5R+jq4uJnmdQptN8FGWfDNwoZY6J5V59gNg3WcNl2+gUQHNshEpnD6AvsKvAwOmwuJZbxrYtT55LNAioEBUcU6AHq7ds3/dFipT8octpc2KGU+kNeAm/yyyjoEludUeLb2Wv2vr6xLteT0Li1vinS19sfM9SdTygaA3Hlsb67+um+l7o7W90dEEUpCVF+NU+nrvkG6rEtZQwHDcEMGklpED4VmY6+wnCfukg3RgrWbcsD2IVFy5t+HCWJ7SrvE9Wch4SUXTzgaokAq2OZEfYUQwoT58Lsgs2mILxWePNT9p+PNjQW1aJ4YMoTRa/LPsBKnprY72b7nlcJbUK5p7K8ppwfTlKpoEudQlXMRo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(7696005)(478600001)(9686003)(83380400001)(55016002)(53546011)(5660300002)(316002)(54906003)(6916009)(33656002)(6506007)(66946007)(52536014)(66476007)(66446008)(64756008)(76116006)(66556008)(2906002)(38100700002)(4326008)(122000001)(186003)(8936002)(71200400001)(86362001)(8676002)(26005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ur5EL8ljMAwH9BcMkMZwXvmmbeaCTrYSFtEZyBKd3+DBiUp/J1UkxrPTTupJ?=
 =?us-ascii?Q?i1BLeG9wniZC4CR1H1MGAtS8gEQMA2Z6KMrTg3hmp/AYeHz/j2zymrbYMaoe?=
 =?us-ascii?Q?6MSUyR5CeCjiKA4wlKg5uQvCwj00ZhNlU2F7rlUg+HSvK3u87nHOexeaSYq+?=
 =?us-ascii?Q?UVdEnnkjvro0mXdv82Y4c9aQv2WiLAFD4tPhPmFhm0E38YO3aKlMi8aoIXzv?=
 =?us-ascii?Q?u65xXj6CbDRtgdhwSsm03pD6PKJnQiotK+vZgdVPMOuw8GNNpFVDNohjQrgl?=
 =?us-ascii?Q?v0mnZ5lXqBDRnsUobSgYN0qeUf0ukuNvyZGC3Z/ZLhsXsEloWp25uPiszxwx?=
 =?us-ascii?Q?QegsCHAJ+VJf6iNRpnq8lsSOvo0+P8C5oPFOCWwIKPo6aQK0fcJRjGwnSpgS?=
 =?us-ascii?Q?cEk5GL6Hf8+h2JLMdzew5QTJeMiZxCz6BbnXxzW9q/5ijKSPFb0nOQfH1iT1?=
 =?us-ascii?Q?6BEjT5beNjp1jPB/INsIDVpja5n/z7EhJYLRtUtSiFZGJ+N0VrkGADCOlHEs?=
 =?us-ascii?Q?zNT4D1HnYqqevuRTPU6cJ/cSxVVhzXtO8t6K/Ey3S0dyOI+/e2TMB193T9Pa?=
 =?us-ascii?Q?6mJRExcAkPJYgRms8U5kV9rvwC8bMYaRMt7EQDJmdDYAi7VR/8/ytXajjm0O?=
 =?us-ascii?Q?jwph5wwGF2LvtvuGf1cloJJJoGbf/0s8Vzok5qa/DYHyixDj272eFz/UMrpU?=
 =?us-ascii?Q?CX9AdeGtRhii50gtXo64tn8POr1EgEWxWrA9jZ6GcFnmaa2C+ucHbGVb1qRY?=
 =?us-ascii?Q?qIWo4FQQy9HifpHh+NMArDjmAi0RF+8N+Fe5SId27Ggal3ELW/WKh20mCGQ3?=
 =?us-ascii?Q?475ZAx/IXvEJGf0baIVHQKhDPmAs5shpFHYaPgELD5S1+AQt/MEW3d0a79Fr?=
 =?us-ascii?Q?Fg/xSO9aUF4sUJG5AB9Hubv8Xz+A74NdP8CLYlmiW5W7tNDgvRRzA8k2uzVa?=
 =?us-ascii?Q?6F0Bc9oo2vA1kespMyyf83Cc6ygSBgn2adQCLnKWaUMco/yTuyCdbPznoNju?=
 =?us-ascii?Q?spu31O3mpS5ZYYF1dedyco07bgjX7xi7hNQGURgprIPABdZII8Pq1XgqYRvl?=
 =?us-ascii?Q?vKE3xiBNdCB5yR7mSYoQIzJ0bXi89bkjGueWjm6TxkCpn2LCV6ICSa2e4cI8?=
 =?us-ascii?Q?7avZxbZ9peO+VwM1zHate0IF4NlYeX4k+5k/vldCea8GaIaQsGuhRn0nZUha?=
 =?us-ascii?Q?gOKxsi9n9wgOKA5gif8LWA3vuOBlne9s5+JYR/h907O//eze9kFSdvhb4H81?=
 =?us-ascii?Q?erbF8HSWa2bpWakpsoFPBjUNTZWaUc6f+iaHjDgwpoz+CE8/UueDazinbzO5?=
 =?us-ascii?Q?EV+UEwImxLh0NbA10Sig04bl?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3baab17d-6c66-4740-db08-08d92f7a9aeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2021 21:23:07.9190 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hRH7o7kIfw2T1iQLvPg7xkBRw73aRjPehuktcsq/s6bMavi/ECLivwyMcCh5ISzI/nvWkW+ETULqSLrzUbkUJCSfs8ql20pDKFS0mb72x+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6884
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210614_142312_006752_F6F5DEBA 
X-CRM114-Status: GOOD (  14.30  )
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

On 6/14/21 14:19, Keith Busch wrote:
> On Mon, Jun 14, 2021 at 12:47:12PM -0700, Chaitanya Kulkarni wrote:
>> @@ -393,7 +393,7 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
>>  	/* no enforcement soft-limit for maxcmd - pick arbitrary high value */
>>  	id->maxcmd = cpu_to_le16(NVMET_MAX_CMD);
>>  
>> -	id->nn = cpu_to_le32(ctrl->subsys->max_nsid);
>> +	id->nn = cpu_to_le32(U32_MAX);
> The NN field has to have the highest valid NSID, and FFFFFFFFh is not
> valid. That's reserved for the broadcast.
>

In that case we have to keep the dynamic id setting for the MNAN and
may have to keep the original proposed fix :-

 drivers/nvme/target/admin-cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/admin-cmd.c
b/drivers/nvme/target/admin-cmd.c
index cd60a8184d04..a8ec377bb68d 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -394,7 +394,7 @@ static void nvmet_execute_identify_ctrl(struct
nvmet_req *req)
        id->maxcmd = cpu_to_le16(NVMET_MAX_CMD);
 
        id->nn = cpu_to_le32(ctrl->subsys->max_nsid);
-       id->mnan = cpu_to_le32(NVMET_MAX_NAMESPACES);
+       id->mnan = cpu_to_le32(ctrl->subsys->max_nsid);
        id->oncs = cpu_to_le16(NVME_CTRL_ONCS_DSM |
                        NVME_CTRL_ONCS_WRITE_ZEROES);
 
-- 
2.22.1



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
