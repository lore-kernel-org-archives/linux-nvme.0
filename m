Return-Path: <SRS0=FbzM=CZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0002EC2D0E3
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Sep 2020 01:30:18 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5002020936
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Sep 2020 01:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DDhMVeP0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IgoruQoi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="aSnNVc8d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5002020936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=KjYuq9BPuZ1LUbToIQ53K/d/Ha5BV8X8J+pWLbnXw2s=; b=DDhMVeP0Ynt4mcPPDPJ2k0PlT
	aBU4mXrRuDzAtS1m0sxiHpfEeLrpEs24F9f/N1KL7H0T5JgZTxBKXaAbl1TbkO9rwBR9xq93sbG30
	z97v8CliwZ5ZaxwvthFbNjXhL3dMBqm4hssv1cK8l+qui8IA+FavREruYEFZ+j7jGHlZJtuyLaEV5
	wVdxOgM/Ax+rtYQAQTCIsteAnRefc6A4Mp22UU6B5Zt1V7zeExchTcYGXyxvMT6ZkuGxvLwt2jFvr
	nIIR8WaqSScqDbFTqAVeQw3IRQk7DxLQbSWszWURCuBiIcTnDGU0yRpbdSyTvWR93NZXeW3YMxHBz
	KgaC8mtMw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kIMGx-0004Dg-9Y; Wed, 16 Sep 2020 01:30:11 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIMGu-0004Ct-CB
 for linux-nvme@lists.infradead.org; Wed, 16 Sep 2020 01:30:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1600219808; x=1631755808;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=agm4gnkwvR4rJdl1hQqXfkBOCJFRchtvV1jn3oWka2A=;
 b=IgoruQoiVLvZhuNvNJneMNrHitCRQTeiZ5rnjgsXen1ANkLnW3C+9RNy
 yJ9vPJqFsI8uZfaNCg2RoSZUf9fdwdx1xYRtyIoK6dWw1Fabcipprdco/
 A888mHSD5FTnRzurmHFDJ4HnBBhNhlCcuZM3cXSBlfh+IyilPDbvtSiZV
 BGaV1Tedc/j1wtRAfKkLdzZ3PwYIaPvL8R74mXdpEoT3P/oqP6937dmWb
 Ki+hYC67iQ47WayEAKn3XLf0aV09hiJJQ17Gu4nV70vkQH07kxtl77IFd
 NqfLx589A/hbfFIdrdGxYXmlQaBPWxlF7gvwalymxHnU1sOlNTpJniQmY w==;
IronPort-SDR: NzQGjfhrmK3YMac4ehv1vitj5f3ngLhMGqoay9UXieDWpFQDqPqNSLu4nCkYBgv5kX2AH6VN2z
 VpVuNTE86Hq9qHFM2BzaJ2S4Gd5LIASXeUPCI5JGNEgGQ8QRI42V80AVa4xbU8joaF/WoOr0X8
 JsAgn+dpGO8jUghExMYxx//7rAhlwA3J5FCCNAHKv7x3J81ka04SBOEFQugTLCr92ZT3OpIZ86
 Mm5hX6If2W4/nC5wL1bC9CS9bxpaJlBZZ15tjEOaE+dtMX/dmZL4NEVCMD2gHPTrxwrJKliWZT
 tsY=
X-IronPort-AV: E=Sophos;i="5.76,430,1592841600"; d="scan'208";a="147399521"
Received: from mail-dm6nam12lp2171.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.171])
 by ob1.hgst.iphmx.com with ESMTP; 16 Sep 2020 09:30:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YlyRYcSu3A6G3s8SNuaGLGQPTrLlbQkFKbQ2nbDiZ57rsAXJdnnZbjb+UQSqKqywkCpbAgQoISLVHDuCd3ofZKKiMEV8CZ5zi+5ErsaVp5g37vPYVeHHCPQfUKkvG1y1O+ZPV04w5IIYo2myHi2eROcszBnMgeIe1WPSedF5yK6mPm3hbe4yxEl3UYZXQiQbVQ6O4+GLZrEjkv4h9MpU1MUXw8sCrfn7ftxxApNZua9dNuO+2QarsQLB1pVjzV5efAuwVUTx0ISTEP7hHZsTx/IpdPuafv6YfcD+uIxAprZt0c70Ll7Ho7C7REvxnCR4tLM25Un5OafBN7q9sGznmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJy0pp7o9NJm7qT+n+VnSd+JqBNYVTjGN1UGlNkqN0o=;
 b=eX9J9LoTckyD69OueOOoB2JujR2ofQpM4Y6DGbcnb/Jv3qurKR7jwZt4vwd6S3DcyL5g+di8IowRKOa6Y+LL1Kd+IgWXqZk2y8RaB5wcZKt0OeBGneVWwVQkgquAsYlzMWwWJ7dVGtu4QkoWWL0ZV0nXmL3wbXD87GuWWFXXq0DQY27eBrKkKAkXBWYaPYi4ya0D2nLj1113/0mfUtJ6oI36chCmv5QLz1KnjOIlwmUujcrM73Z5PZyqB3qx8ShXaISgrBkIMqbG362pbpi872DzvYcY1Fzr8QQpZxfG7RXUBDRN+MlSWzQEvv59ggOJjc4JgsEHGeYmlVkNf+xKoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJy0pp7o9NJm7qT+n+VnSd+JqBNYVTjGN1UGlNkqN0o=;
 b=aSnNVc8dcFWEhPP0itBClzCYhsdJakcCLXgE1ZWdqyjr/YZstOoEq+DSykG6bVRCSwXHzK3nRtLMdsKj091T7LDabsIeWvu4H20cQX2wX8m9VDowDMzzlDR2I3sHntCnVZoGavcBZYDc+QY7lZcQ9NUx7Zh8KVLwqwQVnj8x7Qk=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (52.135.233.89) by
 BYAPR04MB3960.namprd04.prod.outlook.com (52.135.214.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11; Wed, 16 Sep 2020 01:30:03 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f%5]) with mapi id 15.20.3370.019; Wed, 16 Sep 2020
 01:30:03 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme-loop: allow ctrl-loss-tmo for nvme-loop
Thread-Topic: [PATCH] nvme-loop: allow ctrl-loss-tmo for nvme-loop
Thread-Index: AQHWi7SiU+yGXE+Gyk6gjm+/HimNtA==
Date: Wed, 16 Sep 2020 01:30:03 +0000
Message-ID: <BYAPR04MB49658A3CB5BA3AB70434551E86210@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200915230456.13159-1-chaitanya.kulkarni@wdc.com>
 <9aaecc8f-7eda-b792-2e5f-a8cc8f8178f2@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1f980f65-a431-4e5b-2206-08d859e0091c
x-ms-traffictypediagnostic: BYAPR04MB3960:
x-microsoft-antispam-prvs: <BYAPR04MB39607D5BD2347E2D01671EBA86210@BYAPR04MB3960.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:129;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vMi9N87um9PQhYJb8Qsod/CyN2wnoo4d/VZOchzsRk1rb8jYl2uE7PT63nwIgccn3l6tSEo3QuKcabR5WebdN8PshBCSKbXQzaq/bo7e3RAxmE8dlb+zm/6DAjECKMDTXgmOCv9XkXEZArlJJ60wn13zR5FSzRsTNj9gKLJ2j1SXCQPL4PoajqbxWt8waUfUWaCwpNz0CcWurT99eO7yD9vglS0UqtPLiw8JeCPMAFB4afTtB1vfo5A0lBoTBLyDa7TvNgt5AJ4jq8J8Vg+MrnsySv5RixVKD2wsQQ5VWe+ePrOIucF/gxrLFOBhMRf5XHL2XyCAVV7An4in847g1buWrkp6Vwqx6E6Wn1QT12yDQGrXCgS5Yw9LT23IEKCV
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(396003)(346002)(366004)(136003)(83380400001)(52536014)(110136005)(66446008)(8676002)(66476007)(66556008)(64756008)(71200400001)(186003)(30864003)(7696005)(9686003)(55016002)(8936002)(5660300002)(86362001)(316002)(2906002)(4326008)(478600001)(76116006)(26005)(33656002)(6506007)(53546011)(66946007)(579004)(559001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: i3dD+KfWfEXfniawV9j0k7Vu82IOkD/iY7d3ZZnR0oWq/QuXAv53pomFq5maXQ4LSCPfCtd+NvnXlUHHVi+kQVjbBueGpHXUQahUsQ7e+RhM8hAv1YmgP/5rioo17XhhFNNq1/an4Kiv7l1lpjYG1q+z5yAvNmtJ/Mjig6KoEjpZjdYNRgcx9x00IFOm7Vu+m1oIEpHGBLaXq/sKnTmeutQq+5HOVjo81kLGFX8PVM2hAwEfQImBilUvqahpk01954BMkJMPgEGCwo+usE391gbiATGT/QEXcTrSn6MLMAk/ibGLff79haKY0um4h+Z3xkM3P7u77qB8UK/C0O7F99AfAKmOIj3cM499t2xzs84PuYf5a+gNwMDH6nuMTx/YPl3zV9L/iNHWXbj8rPXrJORv3C4j6deigP3NgzEkqy7yr1GijfacdkohnRZZZZZOFSVn1QHPStPn3YsHrQHrPBLp0zAXjX6Mi6CKncl2En0jle5POooD9fIEfKVUCI/u0wXKxF8NEEjPwEpzbyoSO+rBWu50yvbmKoImHp8kmjTX6Iz+VKirO5BPxpF6BYGBBZYtv+MIsJys1H32JzCOkLicVFYAECstEZnlZcEqnLskOHnBjaYSibyS6bUL4gHfpkuLaEozZU0GJRVwYuAR/g==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f980f65-a431-4e5b-2206-08d859e0091c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2020 01:30:03.1701 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oUVk7H37a5pGjQkgci1MpUUtIhqi8goQeDIm5MqcJhMj3arWiZe48v7/39/6L2vfMX91MvydkwXnS5n8dT+KXHyGTSEE5VaGV1iSVsdOnAs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3960
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200915_213008_649003_8892A55A 
X-CRM114-Status: GOOD (  12.91  )
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
Cc: "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/15/20 16:12, Sagi Grimberg wrote:
>> Update nvme-loop transport with NVMF_OPT_CTRL_LOSS_TMO in allowed ops.
>> Without this patch following command fails on my setup :-
>>
>> nvme_fabrics: invalid parameter 'ctrl_loss_tmo=%d'
> 
> But loop doesn't do anything with this param, why should it
> accept it?
> 

With latest nvme-cli all the testcases are failing [1] with this patch
they pass [2]. We can ignore this param in the nvme-loop unless there is 
a need for implementing the behavior.

[1] Failed test-cases :-

  # ./check tests/nvme/
nvme/002 (create many subsystems and test discovery)         [failed]
     runtime    ...  20.131s
     --- tests/nvme/002.out	2019-09-13 21:45:10.352000000 -0700
     +++ /root/blktests/results/nodev/nvme/002.out.bad	2020-09-15 
17:51:24.222000000 -0700
     @@ -1,3003 +1,3 @@
      Running nvme/002
     -Discovery Log Number of Records 1000, Generation counter X
     -=====Discovery Log Entry 0======
     -trtype:  loop
     -subnqn:  blktests-subsystem-0
     -=====Discovery Log Entry 1======
     -trtype:  loop
     ...
     (Run 'diff -u tests/nvme/002.out 
/root/blktests/results/nodev/nvme/002.out.bad' to see the entire diff)
nvme/003 (test if we're sending keep-alives to a discovery controller) 
[failed]
     runtime  10.136s  ...  10.104s
     --- tests/nvme/003.out	2019-09-13 21:45:10.352000000 -0700
     +++ /root/blktests/results/nodev/nvme/003.out.bad	2020-09-15 
17:51:34.526000000 -0700
     @@ -1,3 +1,4 @@
      Running nvme/003
     -NQN:nqn.2014-08.org.nvmexpress.discovery disconnected 1 controller(s)
     +Failed to write to /dev/nvme-fabrics: Invalid argument
     +NQN:nqn.2014-08.org.nvmexpress.discovery disconnected 0 controller(s)
      Test complete
nvme/004 (test nvme and nvmet UUID NS descriptors)           [failed]
     runtime  2.856s  ...  0.139s
     --- tests/nvme/004.out	2019-09-13 21:45:10.352000000 -0700
     +++ /root/blktests/results/nodev/nvme/004.out.bad	2020-09-15 
17:51:34.841000000 -0700
     @@ -1,5 +1,7 @@
      Running nvme/004
     -91fdba0d-f87b-4c25-b80f-db7be1418b9e
     -uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
     -NQN:blktests-subsystem-1 disconnected 1 controller(s)
     +Failed to write to /dev/nvme-fabrics: Invalid argument
     +cat: /sys/class/nvme/nvme*/transport: No such file or directory
     +cat: /sys/block/n1/uuid: No such file or directory
     ...
     (Run 'diff -u tests/nvme/004.out 
/root/blktests/results/nodev/nvme/004.out.bad' to see the entire diff)
nvme/005 (reset local loopback target)                       [failed]
     runtime  3.451s  ...  0.136s
     --- tests/nvme/005.out	2019-09-13 21:45:10.352000000 -0700
     +++ /root/blktests/results/nodev/nvme/005.out.bad	2020-09-15 
17:51:35.166000000 -0700
     @@ -1,2 +1,6 @@
      Running nvme/005
     +Failed to write to /dev/nvme-fabrics: Invalid argument
     +cat: /sys/class/nvme/nvme*/transport: No such file or directory
     +tests/nvme/005: line 43: /sys/class/nvme//reset_controller: 
Permission denied
     +Failed to disconnect by device name:
      Test complete
nvme/006 (create an NVMeOF target with a block device-backed ns) [passed]
     runtime  0.099s  ...  0.100s
nvme/007 (create an NVMeOF target with a file-backed ns)     [passed]
     runtime  0.057s  ...  0.058s
nvme/008 (create an NVMeOF host with a block device-backed ns) [failed]
     runtime  2.906s  ...  0.138s
     --- tests/nvme/008.out	2019-09-13 21:45:10.353000000 -0700
     +++ /root/blktests/results/nodev/nvme/008.out.bad	2020-09-15 
17:51:35.998000000 -0700
     @@ -1,5 +1,7 @@
      Running nvme/008
     -91fdba0d-f87b-4c25-b80f-db7be1418b9e
     -uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
     -NQN:blktests-subsystem-1 disconnected 1 controller(s)
     +Failed to write to /dev/nvme-fabrics: Invalid argument
     +cat: /sys/class/nvme/nvme*/transport: No such file or directory
     +cat: /sys/block/n1/uuid: No such file or directory
     ...
     (Run 'diff -u tests/nvme/008.out 
/root/blktests/results/nodev/nvme/008.out.bad' to see the entire diff)
nvme/009 (create an NVMeOF host with a file-backed ns)       [failed]
     runtime  2.816s  ...  0.096s
     --- tests/nvme/009.out	2019-09-13 21:45:10.353000000 -0700
     +++ /root/blktests/results/nodev/nvme/009.out.bad	2020-09-15 
17:51:36.286000000 -0700
     @@ -1,5 +1,7 @@
      Running nvme/009
     -91fdba0d-f87b-4c25-b80f-db7be1418b9e
     -uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
     -NQN:blktests-subsystem-1 disconnected 1 controller(s)
     +Failed to write to /dev/nvme-fabrics: Invalid argument
     +cat: /sys/class/nvme/nvme*/transport: No such file or directory
     +cat: /sys/block/n1/uuid: No such file or directory
     ...
     (Run 'diff -u tests/nvme/009.out 
/root/blktests/results/nodev/nvme/009.out.bad' to see the entire diff)
nvme/010 (run data verification fio job on NVMeOF block device-backed 
ns) [failed]
     runtime  17.964s  ...  1.678s
     --- tests/nvme/010.out	2019-09-13 21:45:10.353000000 -0700
     +++ /root/blktests/results/nodev/nvme/010.out.bad	2020-09-15 
17:51:38.228000000 -0700
     @@ -1,5 +1,12 @@
      Running nvme/010
     -91fdba0d-f87b-4c25-b80f-db7be1418b9e
     -uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
     -NQN:blktests-subsystem-1 disconnected 1 controller(s)
     +Failed to write to /dev/nvme-fabrics: Invalid argument
     +cat: /sys/class/nvme/nvme*/transport: No such file or directory
     +cat: /sys/block/n1/uuid: No such file or directory
     ...
     (Run 'diff -u tests/nvme/010.out 
/root/blktests/results/nodev/nvme/010.out.bad' to see the entire diff)
nvme/011 (run data verification fio job on NVMeOF file-backed ns) [failed]
     runtime  361.528s  ...  0.980s
     --- tests/nvme/011.out	2019-09-13 21:45:10.353000000 -0700
     +++ /root/blktests/results/nodev/nvme/011.out.bad	2020-09-15 
17:51:39.465000000 -0700
     @@ -1,5 +1,12 @@
      Running nvme/011
     -91fdba0d-f87b-4c25-b80f-db7be1418b9e
     -uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
     -NQN:blktests-subsystem-1 disconnected 1 controller(s)
     +Failed to write to /dev/nvme-fabrics: Invalid argument
     +cat: /sys/class/nvme/nvme*/transport: No such file or directory
     +cat: /sys/block/n1/uuid: No such file or directory
     ...
     (Run 'diff -u tests/nvme/011.out 
/root/blktests/results/nodev/nvme/011.out.bad' to see the entire diff)
nnvme/012 (run mkfs and data verification fio job on NVMeOF block 
device-backed ns) [failed]
     runtime  41.423s  ...  19.896s
     --- tests/nvme/012.out	2019-09-13 21:45:10.354000000 -0700
     +++ /root/blktests/results/nodev/nvme/012.out.bad	2020-09-15 
17:51:59.535000000 -0700
     @@ -1,5 +1,11 @@
      Running nvme/012
     -91fdba0d-f87b-4c25-b80f-db7be1418b9e
     -uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
     -NQN:blktests-subsystem-1 disconnected 1 controller(s)
     +Failed to write to /dev/nvme-fabrics: Invalid argument
     +cat: /sys/class/nvme/nvme*/transport: No such file or directory
     +cat: /sys/block/n1/uuid: No such file or directory
     ...
     (Run 'diff -u tests/nvme/012.out 
/root/blktests/results/nodev/nvme/012.out.bad' to see the entire diff)
nvme/013 (run mkfs and data verification fio job on NVMeOF file-backed 
ns) [failed]
     runtime  147.563s  ...  15.116s
     --- tests/nvme/013.out	2019-09-13 21:45:10.354000000 -0700
     +++ /root/blktests/results/nodev/nvme/013.out.bad	2020-09-15 
17:52:14.911000000 -0700
     @@ -1,5 +1,7 @@
      Running nvme/013
     -91fdba0d-f87b-4c25-b80f-db7be1418b9e
     -uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
     -NQN:blktests-subsystem-1 disconnected 1 controller(s)
     +Failed to write to /dev/nvme-fabrics: Invalid argument
     +cat: /sys/class/nvme/nvme*/transport: No such file or directory
     +cat: /sys/block/n1/uuid: No such file or directory
     ...
     (Run 'diff -u tests/nvme/013.out 
/root/blktests/results/nodev/nvme/013.out.bad' to see the entire diff)
nvme/014 (flush a NVMeOF block device-backed ns)             [failed]
     runtime  21.723s  ...  10.242s
     --- tests/nvme/014.out	2019-09-13 21:45:10.354000000 -0700
     +++ /root/blktests/results/nodev/nvme/014.out.bad	2020-09-15 
17:52:25.330000000 -0700
     @@ -1,6 +1,17 @@
      Running nvme/014
     -91fdba0d-f87b-4c25-b80f-db7be1418b9e
     -uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
     -NVMe Flush: success
     -NQN:blktests-subsystem-1 disconnected 1 controller(s)
     +Failed to write to /dev/nvme-fabrics: Invalid argument
     +cat: /sys/class/nvme/nvme*/transport: No such file or directory
     ...
     (Run 'diff -u tests/nvme/014.out 
/root/blktests/results/nodev/nvme/014.out.bad' to see the entire diff)
nvme/015 (unit test for NVMe flush for file backed ns)       [failed]
     runtime  19.574s  ...  10.089s
     --- tests/nvme/015.out	2019-09-13 21:45:10.354000000 -0700
     +++ /root/blktests/results/nodev/nvme/015.out.bad	2020-09-15 
17:52:35.606000000 -0700
     @@ -1,6 +1,17 @@
      Running nvme/015
     -91fdba0d-f87b-4c25-b80f-db7be1418b9e
     -uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
     -NVMe Flush: success
     -NQN:blktests-subsystem-1 disconnected 1 controller(s)
     +Failed to write to /dev/nvme-fabrics: Invalid argument
     +cat: /sys/class/nvme/nvme*/transport: No such file or directory
     ...
     (Run 'diff -u tests/nvme/015.out 
/root/blktests/results/nodev/nvme/015.out.bad' to see the entire diff)
nvme/016 (create/delete many NVMeOF block device-backed ns and test 
discovery) [failed]
     runtime  14.664s  ...  14.691s
     --- tests/nvme/016.out	2019-09-13 21:45:10.354000000 -0700
     +++ /root/blktests/results/nodev/nvme/016.out.bad	2020-09-15 
17:52:50.470000000 -0700
     @@ -1,6 +1,3 @@
      Running nvme/016
     -Discovery Log Number of Records 1, Generation counter X
     -=====Discovery Log Entry 0======
     -trtype:  loop
     -subnqn:  blktests-subsystem-1
     +Failed to write to /dev/nvme-fabrics: Invalid argument
      Test complete
nvme/017 (create/delete many file-ns and test discovery)     [failed]
     runtime  14.640s  ...  14.590s
     --- tests/nvme/017.out	2019-09-13 21:45:10.355000000 -0700
     +++ /root/blktests/results/nodev/nvme/017.out.bad	2020-09-15 
17:53:05.247000000 -0700
     @@ -1,6 +1,3 @@
      Running nvme/017
     -Discovery Log Number of Records 1, Generation counter X
     -=====Discovery Log Entry 0======
     -trtype:  loop
     -subnqn:  blktests-subsystem-1
     +Failed to write to /dev/nvme-fabrics: Invalid argument
      Test complete
nvme/018 (unit test NVMe-oF out of range access on a file backend) [failed]
     runtime  2.807s  ...  0.102s
     --- tests/nvme/018.out	2019-09-13 21:45:10.355000000 -0700
     +++ /root/blktests/results/nodev/nvme/018.out.bad	2020-09-15 
17:53:05.538000000 -0700
     @@ -1,5 +1,9 @@
      Running nvme/018
     -91fdba0d-f87b-4c25-b80f-db7be1418b9e
     -uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
     -NQN:blktests-subsystem-1 disconnected 1 controller(s)
     +Failed to write to /dev/nvme-fabrics: Invalid argument
     +cat: /sys/class/nvme/nvme*/transport: No such file or directory
     +cat: /sys/block/n1/uuid: No such file or directory
     ...
     (Run 'diff -u tests/nvme/018.out 
/root/blktests/results/nodev/nvme/018.out.bad' to see the entire diff)
nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [failed]
     runtime  2.826s  ...  0.132s
     --- tests/nvme/019.out	2019-09-13 21:45:10.355000000 -0700
     +++ /root/blktests/results/nodev/nvme/019.out.bad	2020-09-15 
17:53:05.846000000 -0700
     @@ -1,6 +1,31 @@
      Running nvme/019
     -91fdba0d-f87b-4c25-b80f-db7be1418b9e
     -uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
     -NVMe DSM: success
     -NQN:blktests-subsystem-1 disconnected 1 controller(s)
     +Failed to write to /dev/nvme-fabrics: Invalid argument
     +cat: /sys/class/nvme/nvme*/transport: No such file or directory
     ...
     (Run 'diff -u tests/nvme/019.out 
/root/blktests/results/nodev/nvme/019.out.bad' to see the entire diff)
nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [failed]
     runtime  2.814s  ...  0.094s
     --- tests/nvme/020.out	2019-09-13 21:45:10.355000000 -0700
     +++ /root/blktests/results/nodev/nvme/020.out.bad	2020-09-15 
17:53:06.130000000 -0700
     @@ -1,6 +1,31 @@
      Running nvme/020
     -91fdba0d-f87b-4c25-b80f-db7be1418b9e
     -uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
     -NVMe DSM: success
     -NQN:blktests-subsystem-1 disconnected 1 controller(s)
     +Failed to write to /dev/nvme-fabrics: Invalid argument
     +cat: /sys/class/nvme/nvme*/transport: No such file or directory
     ...
     (Run 'diff -u tests/nvme/020.out 
/root/blktests/results/nodev/nvme/020.out.bad' to see the entire diff)
nvme/021 (test NVMe list command on NVMeOF file-backed ns)   [failed]
     runtime  2.837s  ...  0.086s
     --- tests/nvme/021.out	2019-09-13 21:45:10.355000000 -0700
     +++ /root/blktests/results/nodev/nvme/021.out.bad	2020-09-15 
17:53:06.394000000 -0700
     @@ -1,4 +1,7 @@
      Running nvme/021
     -91fdba0d-f87b-4c25-b80f-db7be1418b9e
     -uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
     +Failed to write to /dev/nvme-fabrics: Invalid argument
     +cat: /sys/class/nvme/nvme*/transport: No such file or directory
     +cat: /sys/block/n1/uuid: No such file or directory
     +cat: /sys/block/n1/wwid: No such file or directory
     ...
     (Run 'diff -u tests/nvme/021.out 
/root/blktests/results/nodev/nvme/021.out.bad' to see the entire diff)
nvme/022 (test NVMe reset command on NVMeOF file-backed ns)  [failed]
     runtime  3.375s  ...  0.095s
     --- tests/nvme/022.out	2019-09-13 21:45:10.355000000 -0700
     +++ /root/blktests/results/nodev/nvme/022.out.bad	2020-09-15 
17:53:06.671000000 -0700
     @@ -1,4 +1,6 @@
      Running nvme/022
     -91fdba0d-f87b-4c25-b80f-db7be1418b9e
     -uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
     +Failed to write to /dev/nvme-fabrics: Invalid argument
     +cat: /sys/class/nvme/nvme*/transport: No such file or directory
     +cat: /sys/block/n1/uuid: No such file or directory
     +cat: /sys/block/n1/wwid: No such file or directory
     ...
     (Run 'diff -u tests/nvme/022.out 
/root/blktests/results/nodev/nvme/022.out.bad' to see the entire diff)
nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [failed]
     runtime  2.844s  ...  0.132s
     --- tests/nvme/023.out	2019-09-13 21:45:10.356000000 -0700
     +++ /root/blktests/results/nodev/nvme/023.out.bad	2020-09-15 
17:53:06.978000000 -0700
     @@ -1,4 +1,6 @@
      Running nvme/023
     -91fdba0d-f87b-4c25-b80f-db7be1418b9e
     -uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
     +Failed to write to /dev/nvme-fabrics: Invalid argument
     +cat: /sys/class/nvme/nvme*/transport: No such file or directory
     +cat: /sys/block/n1/uuid: No such file or directory
     +cat: /sys/block/n1/wwid: No such file or directory
     ...
     (Run 'diff -u tests/nvme/023.out 
/root/blktests/results/nodev/nvme/023.out.bad' to see the entire diff)
nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [failed]
     runtime  2.754s  ...  0.091s
     --- tests/nvme/024.out	2019-09-13 21:45:10.356000000 -0700
     +++ /root/blktests/results/nodev/nvme/024.out.bad	2020-09-15 
17:53:07.253000000 -0700
     @@ -1,4 +1,6 @@
      Running nvme/024
     -91fdba0d-f87b-4c25-b80f-db7be1418b9e
     -uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
     +Failed to write to /dev/nvme-fabrics: Invalid argument
     +cat: /sys/class/nvme/nvme*/transport: No such file or directory
     +cat: /sys/block/n1/uuid: No such file or directory
     +cat: /sys/block/n1/wwid: No such file or directory
     ...
     (Run 'diff -u tests/nvme/024.out 
/root/blktests/results/nodev/nvme/024.out.bad' to see the entire diff)
nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [failed]
     runtime  2.747s  ...  0.093s
     --- tests/nvme/025.out	2019-09-13 21:45:10.356000000 -0700
     +++ /root/blktests/results/nodev/nvme/025.out.bad	2020-09-15 
17:53:07.533000000 -0700
     @@ -1,4 +1,6 @@
      Running nvme/025
     -91fdba0d-f87b-4c25-b80f-db7be1418b9e
     -uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
     +Failed to write to /dev/nvme-fabrics: Invalid argument
     +cat: /sys/class/nvme/nvme*/transport: No such file or directory
     +cat: /sys/block/n1/uuid: No such file or directory
     +cat: /sys/block/n1/wwid: No such file or directory
     ...
     (Run 'diff -u tests/nvme/025.out 
/root/blktests/results/nodev/nvme/025.out.bad' to see the entire diff)
nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [failed]
     runtime  2.801s  ...  0.090s
     --- tests/nvme/026.out	2019-09-13 21:45:10.356000000 -0700
     +++ /root/blktests/results/nodev/nvme/026.out.bad	2020-09-15 
17:53:07.804000000 -0700
     @@ -1,4 +1,6 @@
      Running nvme/026
     -91fdba0d-f87b-4c25-b80f-db7be1418b9e
     -uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
     +Failed to write to /dev/nvme-fabrics: Invalid argument
     +cat: /sys/class/nvme/nvme*/transport: No such file or directory
     +cat: /sys/block/n1/uuid: No such file or directory
     +cat: /sys/block/n1/wwid: No such file or directory
     ...
     (Run 'diff -u tests/nvme/026.out 
/root/blktests/results/nodev/nvme/026.out.bad' to see the entire diff)
nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [failed]
     runtime  2.787s  ...  0.090s
     --- tests/nvme/027.out	2019-09-13 21:45:10.356000000 -0700
     +++ /root/blktests/results/nodev/nvme/027.out.bad	2020-09-15 
17:53:08.071000000 -0700
     @@ -1,4 +1,6 @@
      Running nvme/027
     -91fdba0d-f87b-4c25-b80f-db7be1418b9e
     -uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
     +Failed to write to /dev/nvme-fabrics: Invalid argument
     +cat: /sys/class/nvme/nvme*/transport: No such file or directory
     +cat: /sys/block/n1/uuid: No such file or directory
     +cat: /sys/block/n1/wwid: No such file or directory
     ...
     (Run 'diff -u tests/nvme/027.out 
/root/blktests/results/nodev/nvme/027.out.bad' to see the entire diff)
nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [failed]
     runtime  2.769s  ...  0.090s
     --- tests/nvme/028.out	2019-09-13 21:45:10.356000000 -0700
     +++ /root/blktests/results/nodev/nvme/028.out.bad	2020-09-15 
17:53:08.342000000 -0700
     @@ -1,4 +1,7 @@
      Running nvme/028
     -91fdba0d-f87b-4c25-b80f-db7be1418b9e
     -uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
     +Failed to write to /dev/nvme-fabrics: Invalid argument
     +cat: /sys/class/nvme/nvme*/transport: No such file or directory
     +cat: /sys/block/n1/uuid: No such file or directory
     +cat: /sys/block/n1/wwid: No such file or directory
     ...
     (Run 'diff -u tests/nvme/028.out 
/root/blktests/results/nodev/nvme/028.out.bad' to see the entire diff)
nvme/029 (test userspace IO via nvme-cli read/write interface) [failed]
     runtime  3.103s  ...  0.298s
     --- tests/nvme/029.out	2019-09-13 21:45:10.357000000 -0700
     +++ /root/blktests/results/nodev/nvme/029.out.bad	2020-09-15 
17:53:08.821000000 -0700
     @@ -1,4 +1,6 @@
      Running nvme/029
     -91fdba0d-f87b-4c25-b80f-db7be1418b9e
     -uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
     +Failed to write to /dev/nvme-fabrics: Invalid argument
     +cat: /sys/class/nvme/nvme*/transport: No such file or directory
     +cat: /sys/block/n1/uuid: No such file or directory
     +cat: /sys/block/n1/wwid: No such file or directory
     ...
     (Run 'diff -u tests/nvme/029.out 
/root/blktests/results/nodev/nvme/029.out.bad' to see the entire diff)
nvme/030 (ensure the discovery generation counter is updated 
appropriately) [failed]
     runtime  0.331s  ...  0.131s
     --- tests/nvme/030.out	2019-09-13 21:45:10.357000000 -0700
     +++ /root/blktests/results/nodev/nvme/030.out.bad	2020-09-15 
17:53:09.128000000 -0700
     @@ -1,2 +1,11 @@
      Running nvme/030
     +Failed to write to /dev/nvme-fabrics: Invalid argument
     +Failed to write to /dev/nvme-fabrics: Invalid argument
     +tests/nvme/030: line 25: ((: <=  : syntax error: operand expected 
(error token is "<=  ")
     +Failed to write to /dev/nvme-fabrics: Invalid argument
     +tests/nvme/030: line 25: ((: <=  : syntax error: operand expected 
(error token is "<=  ")
     +Failed to write to /dev/nvme-fabrics: Invalid argument
     ...
     (Run 'diff -u tests/nvme/030.out 
/root/blktests/results/nodev/nvme/030.out.bad' to see the entire diff)
nvme/031 (test deletion of NVMeOF controllers immediately after setup) 
[failed]
     runtime  17.152s  ...  0.465s
     --- tests/nvme/031.out	2020-08-02 20:25:49.032000000 -0700
     +++ /root/blktests/results/nodev/nvme/031.out.bad	2020-09-15 
17:53:09.767000000 -0700
     @@ -1,2 +1,12 @@
      Running nvme/031
     +Failed to write to /dev/nvme-fabrics: Invalid argument
     +Failed to write to /dev/nvme-fabrics: Invalid argument
     +Failed to write to /dev/nvme-fabrics: Invalid argument
     +Failed to write to /dev/nvme-fabrics: Invalid argument
     +Failed to write to /dev/nvme-fabrics: Invalid argument
     +Failed to write to /dev/nvme-fabrics: Invalid argument
     ...
     (Run 'diff -u tests/nvme/031.out 
/root/blktests/results/nodev/nvme/031.out.bad' to see the entire diff)
nvme/033 (test ANA optimized/transitioning/inaccessible support) [failed]
     runtime  84.098s  ...  18.353s
     --- tests/nvme/033.out	2020-08-02 20:29:24.865000000 -0700
     +++ /root/blktests/results/nodev/nvme/033.out.bad	2020-09-15 
17:53:28.369000000 -0700
     @@ -1,20 +1,205 @@
      Running nvme/033
     -nvme0c1n1: grpid 1 state optimized
     -nvme0c1n2: grpid 2 state inaccessible
     -nvme0c2n1: grpid 1 state inaccessible
     -nvme0c2n2: grpid 2 state optimized
     -ANA state transition
     -nvme0c1n1: grpid 1 state change
     ...
     (Run 'diff -u tests/nvme/033.out 
/root/blktests/results/nodev/nvme/033.out.bad' to see the entire diff)


2. Passed Test-cases :-

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 0d6008cf66a2..517c93ede8dd 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -678,7 +678,10 @@ static struct nvmf_transport_ops 
nvme_loop_transport = {
         .name           = "loop",
         .module         = THIS_MODULE,
         .create_ctrl    = nvme_loop_create_ctrl,
-       .allowed_opts   = NVMF_OPT_TRADDR,
+       /*
+        * We currently ignore the CTRL_LOSS_TMO for nvme-loop.
+        */
+       .allowed_opts   = NVMF_OPT_TRADDR | NVMF_OPT_CTRL_LOSS_TMO,
  };

  static int __init nvme_loop_init_module(void)


nvme/002 (create many subsystems and test discovery)         [passed]
     runtime  20.165s  ...  20.955s
nvme/003 (test if we're sending keep-alives to a discovery controller) 
[passed]
     runtime  10.118s  ...  10.141s
nvme/004 (test nvme and nvmet UUID NS descriptors)           [passed]
     runtime  2.867s  ...  2.854s
nvme/005 (reset local loopback target)                       [passed]
     runtime  3.425s  ...  3.409s
nvme/006 (create an NVMeOF target with a block device-backed ns) [passed]
     runtime  0.097s  ...  0.097s
nvme/007 (create an NVMeOF target with a file-backed ns)     [passed]
     runtime  0.050s  ...  0.054s
nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
     runtime  2.846s  ...  2.837s
nvme/009 (create an NVMeOF host with a file-backed ns)       [passed]
     runtime  2.798s  ...  2.762s
nvme/010 (run data verification fio job on NVMeOF block device-backed 
ns) [passed]
     runtime  30.388s  ...  26.443s
nvme/011 (run data verification fio job on NVMeOF file-backed ns) [passed]
     runtime  238.745s  ...  241.024s
nvme/012 (run mkfs and data verification fio job on NVMeOF block 
device-backed ns) [passed]
     runtime  39.890s  ...  36.863s
nvme/013 (run mkfs and data verification fio job on NVMeOF file-backed 
ns) [passed]
     runtime  150.226s  ...  129.343s
nvme/014 (flush a NVMeOF block device-backed ns)             [passed]
     runtime  22.811s  ...  22.595snvme/002 (create many subsystems and 
test discovery)         [passed]
     runtime  20.165s  ...  20.955s
nvme/003 (test if we're sending keep-alives to a discovery controller) 
[passed]
     runtime  10.118s  ...  10.141s
nvme/004 (test nvme and nvmet UUID NS descriptors)           [passed]
     runtime  2.867s  ...  2.854s
nvme/005 (reset local loopback target)                       [passed]
     runtime  3.425s  ...  3.409s
nvme/006 (create an NVMeOF target with a block device-backed ns) [passed]
     runtime  0.097s  ...  0.097s
nvme/007 (create an NVMeOF target with a file-backed ns)     [passed]
     runtime  0.050s  ...  0.054s
nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
     runtime  2.846s  ...  2.837s
nvme/009 (create an NVMeOF host with a file-backed ns)       [passed]
     runtime  2.798s  ...  2.762s
nvme/010 (run data verification fio job on NVMeOF block device-backed 
ns) [passed]
     runtime  30.388s  ...  26.443s
nvme/011 (run data verification fio job on NVMeOF file-backed ns) [passed]
     runtime  238.745s  ...  241.024s
nvme/012 (run mkfs and data verification fio job on NVMeOF block 
device-backed ns) [passed]
     runtime  39.890s  ...  36.863s
nvme/013 (run mkfs and data verification fio job on NVMeOF file-backed 
ns) [passed]
     runtime  150.226s  ...  129.343s
nvme/014 (flush a NVMeOF block device-backed ns)             [passed]
     runtime  22.811s  ...  22.595s
nvme/015 (unit test for NVMe flush for file backed ns)       [passed]
     runtime  20.756s  ...  22.266s
nvme/016 (create/delete many NVMeOF block device-backed ns and test 
discovery) [passed]
     runtime  14.594s  ...  14.685s
nvme/017 (create/delete many file-ns and test discovery)     [passed]
     runtime  14.626s  ...  14.593s
nvme/018 (unit test NVMe-oF out of range access on a file backend) [passed]
     runtime  2.791s  ...  2.832s
nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [passed]
     runtime  2.861s  ...  2.896s
nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [passed]
     runtime  2.803s  ...  2.820s
nvme/021 (test NVMe list command on NVMeOF file-backed ns)   [passed]
     runtime  2.798s  ...  2.803s
nvme/022 (test NVMe reset command on NVMeOF file-backed ns)  [passed]
     runtime  3.400s  ...  3.420s
nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [passed]
     runtime  2.894s  ...  2.858s
nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [passed]
     runtime  2.806s  ...  2.814s
nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [passed]
     runtime  2.822s  ...  2.814s
nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [passed]
     runtime  2.767s  ...  2.810s
nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [passed]
     runtime  2.875s  ...  2.812s
nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [passed]
     runtime  2.752s  ...  2.774s
nvme/029 (test userspace IO via nvme-cli read/write interface) [passed]
     runtime  3.045s  ...  3.070s
nvme/030 (ensure the discovery generation counter is updated 
appropriately) [passed]
     runtime  0.324s  ...  0.327s
nvme/031 (test deletion of NVMeOF controllers immediately after setup) 
[passed]
     runtime  17.458s  ...  17.345s

nvme/015 (unit test for NVMe flush for file backed ns)       [passed]
     runtime  20.756s  ...  22.266s
nvme/016 (create/delete many NVMeOF block device-backed ns and test 
discovery) [passed]
     runtime  14.594s  ...  14.685s
nvme/017 (create/delete many file-ns and test discovery)     [passed]
     runtime  14.626s  ...  14.593s
nvme/018 (unit test NVMe-oF out of range access on a file backend) [passed]
     runtime  2.791s  ...  2.832s
nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [passed]
     runtime  2.861s  ...  2.896s
nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [passed]
     runtime  2.803s  ...  2.820s
nvme/021 (test NVMe list command on NVMeOF file-backed ns)   [passed]
     runtime  2.798s  ...  2.803s
nvme/022 (test NVMe reset command on NVMeOF file-backed ns)  [passed]
     runtime  3.400s  ...  3.420s
nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [passed]
     runtime  2.894s  ...  2.858s
nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [passed]
     runtime  2.806s  ...  2.814s
nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [passed]
     runtime  2.822s  ...  2.814s
nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [passed]
     runtime  2.767s  ...  2.810s
nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [passed]
     runtime  2.875s  ...  2.812s
nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [passed]
     runtime  2.752s  ...  2.774s
nvme/029 (test userspace IO via nvme-cli read/write interface) [passed]
     runtime  3.045s  ...  3.070s
nvme/030 (ensure the discovery generation counter is updated 
appropriately) [passed]
     runtime  0.324s  ...  0.327s
nvme/031 (test deletion of NVMeOF controllers immediately after setup) 
[passed]
     runtime  17.458s  ...  17.345s






_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
