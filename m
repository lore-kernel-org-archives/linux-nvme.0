Return-Path: <SRS0=HgRT=5J=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8720C4332B
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Mar 2020 09:47:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F2052051A
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Mar 2020 09:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="L1B22nxf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="m661h8hM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F2052051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=xe3geaKXQbC+mzMhLZ/mjl3S3YTi/bYGUZGujysVOq0=; b=L1B22nxfwYdj5Hzz7Rno/gtgS
	x26KTaxnQsVe8IDH9WULuh4CUqRisWlx2nsL1p13JwgsEAXuKtUtsYQZ58MS0KxkZ15dno8jsbaMX
	7eqhypK1VbHFWqCIYEf1Kbhe/Z/8ZEqx5D71n0fH4icozkUoZObTWSEwIAjgIkZB6HFsm/BycU475
	BZcCKYtiDihCAhYAWR2bBH8Y+EsWJJmsXbDbju6RrdNzLKU60T2mEzFWZOsZl+HDYKk7y4oGSYcqp
	3JUehlZ7Ih73Rvjp0euctzJ6Iz5jRmKW6iP0ooKVov/NKfetbYMVMDe90mmVV3xedLKtASy+lCeQn
	gPWgTOM7g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jGg9a-00022n-Pl; Tue, 24 Mar 2020 09:47:22 +0000
Received: from mail-eopbgr00070.outbound.protection.outlook.com ([40.107.0.70]
 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jGg9Y-0001si-9x
 for linux-nvme@lists.infradead.org; Tue, 24 Mar 2020 09:47:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kqmgMDBZh20gJ+aOzZYx8wTi2k+uXLRepgF6Rz56CKTo1WVV/o8GMgEMDYJnYht06KYxoTrWXjzH7z49xJec8Ys1bdGwb2dQ4pDkZO0ohWDU1Op9E8vonpAa+by7FT/pMe1Ca7Uox7G/Otr1h2jVBn66S9GxFyhbBRTEQz/DZZ4mgaLxhzwE5NFKPlElRZusE8zf2HgihqjbkYv/iZbW9JD96h+qfbAxnEfpgsoHGCUcogcwtfDNb0si/x40zTMWY/VGno/Aq6CAszPellftI17WgbMzyVXO7f2h9MtZnzr5olOPzoM5kJnVkTibNB+C/azsS7wvCt4WIU3dAwsBcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+KAKGjg4h24BeHE2VNLl+uEGfPXNJlhm5Vbdq6TB9o=;
 b=atRWcIyzvoFp/8j9Wf0ALRXF+dux1+19Zq5jEB0/7VUae1AFMH4smGpGosLpX97OOFkoqcTnydcrDNG1CLyfNxHM161yaD2kjnyUUDFQZ5sDknmSLbBLzZ2NANU7+o+feHwUeBImLusGJbSoKS1YxGTdR87XRriH74fxBO0d8XeHbbIMlWMLGJsfd9pPqWW28wOiEb+j/KOJjx2D4FaIY4fysUdMKulAf35dTvHX5yJ5XDe7QsqaOj8zKpr3WLRWvfh44V2oHyMehQgWNq3uOgJ6KKy8owZcek1v7NYrD2UqhxzRtHEHdKjxTxrHI1VOx5j7n4sZPQhJzfjyC0ZTtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=kernel.org smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+KAKGjg4h24BeHE2VNLl+uEGfPXNJlhm5Vbdq6TB9o=;
 b=m661h8hMPHCCvdYGLSJoL7cyMwkef+d6kLO2VcEqehr6lpoXtcJc2ChfV94c8cBEbOydc3otjFZajMwzNNzLU4Yox40v3V9NwucvmXMkAeUMVtV1Kmgj2QlwS3ooRVgZkVmnnd41fwI9T1f8fzNyixKliJ3rVWoBdYJhNx0C7IM=
Received: from AM0PR04CA0026.eurprd04.prod.outlook.com (2603:10a6:208:122::39)
 by AM6PR0502MB3800.eurprd05.prod.outlook.com (2603:10a6:209:a::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18; Tue, 24 Mar
 2020 09:47:14 +0000
Received: from AM5EUR03FT038.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:208:122:cafe::64) by AM0PR04CA0026.outlook.office365.com
 (2603:10a6:208:122::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20 via Frontend
 Transport; Tue, 24 Mar 2020 09:47:14 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 AM5EUR03FT038.mail.protection.outlook.com (10.152.17.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2814.13 via Frontend Transport; Tue, 24 Mar 2020 09:47:14 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Tue, 24 Mar 2020 11:47:13
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Tue,
 24 Mar 2020 11:47:13 +0200
Received: from [172.27.15.174] (172.27.15.174) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0;
 Tue, 24 Mar 2020 11:46:53 +0200
Subject: Re: [PATCH rfc 2/2] fabrics: allow user to pass hostname instead of
 traddr
To: Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>, "Keith
 Busch" <kbusch@kernel.org>
References: <20200324090324.24459-1-sagi@grimberg.me>
 <20200324090324.24459-3-sagi@grimberg.me>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <b5812c46-7763-1581-e9a7-2e2927ccee18@mellanox.com>
Date: Tue, 24 Mar 2020 11:46:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200324090324.24459-3-sagi@grimberg.me>
Content-Language: en-US
X-Originating-IP: [172.27.15.174]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251; IPV:; CTRY:IL; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(39860400002)(136003)(346002)(396003)(46966005)(16526019)(8936002)(186003)(36756003)(26005)(81156014)(86362001)(31696002)(31686004)(8676002)(81166006)(70586007)(70206006)(5660300002)(478600001)(2906002)(336012)(47076004)(53546011)(16576012)(2616005)(36906005)(316002)(356004)(110136005)(3940600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR0502MB3800; H:mtlcas13.mtl.com; FPR:;
 SPF:Pass; LANG:en; PTR:InfoDomainNonexistent; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c048313e-febb-4801-9880-08d7cfd8552a
X-MS-TrafficTypeDiagnostic: AM6PR0502MB3800:
X-Microsoft-Antispam-PRVS: <AM6PR0502MB3800FD78C1CBCDCB96819B7BB6F10@AM6PR0502MB3800.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:758;
X-Forefront-PRVS: 03524FBD26
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UFSjZUfzsC6LA9qxZTchLaGh/h4yp4rmilm0VtRBSl3z5H2tHkcFcWyR2qwY6xUYdLh2IqYAJFmpB13pcjBsqWjbJk/96Zo5zuwN7ufCvF/5IV75aRaUFdEc9Z3uiXYJKIgK0Ij5355XBS9+H+uAd+0wftH6aT8DRujQ2Xpk80kH/p2NdLMD2s5I1P9rR2SREiG7GtZExniBLngj/4aLjYEEjj/7rZG1n3ibVTvfh7zRd7PpJv7dLxIxO0TUrndXF1/8lGY8xz7n807fMxieN4zqBS3XtXY1Bk/l7VVF//WeiT/1DPLzPBG/ZfyFhR6w1rUCijusCamq94cerVe2+T5MItgHAzPSN3rhXIpi8yPsY2ya01WvhdBL3GxptTcHiRXYq1ZWHLHUd3d5RnPu1uCqwlkR2BUpgA6wqoTM6s+lj4BmW+U2bHGtjfwhh41qZvW1la2rI3DFfhYWNQszvw0a3LJM757e5i2W3xSWdnjUqoKBFOWY2RSIsTzUPJuHJVGRjpgl0Kuj2VksV10yiNPWxYoBzMUU+3vebgwbudY=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2020 09:47:14.3373 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c048313e-febb-4801-9880-08d7cfd8552a
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b; Ip=[193.47.165.251];
 Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0502MB3800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200324_024720_351928_6A2D1E70 
X-CRM114-Status: GOOD (  17.63  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 3/24/2020 11:03 AM, Sagi Grimberg wrote:
> Some users would like to use well known hostnames instead
> of remembering ip addresses. So, allow users to pass --hostname
> and we will attempt to resolve against the DNS.
>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   fabrics.c | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 75 insertions(+)
>
> diff --git a/fabrics.c b/fabrics.c
> index a7d628b1f0c9..7bd95c4b0d10 100644
> --- a/fabrics.c
> +++ b/fabrics.c
> @@ -33,6 +33,10 @@
>   #include <sys/stat.h>
>   #include <stddef.h>
>   
> +#include <sys/types.h>
> +#include <arpa/inet.h>
> +#include <netdb.h>
> +
>   #include "util/parser.h"
>   #include "nvme-ioctl.h"
>   #include "nvme-status.h"
> @@ -60,6 +64,7 @@ static struct config {
>   	char *nqn;
>   	char *transport;
>   	char *traddr;
> +	char *hostname;
>   	char *trsvcid;
>   	char *host_traddr;
>   	char *hostnqn;
> @@ -857,6 +862,54 @@ static int build_options(char *argstr, int max_len, bool discover)
>   	return 0;
>   }
>   
> +static int hostname2traddr(struct config *cfg)
> +{
> +	struct addrinfo *host_info, hints = {.ai_family = AF_UNSPEC};
> +	char addrstr[NVMF_TRADDR_SIZE];
> +	const char *p;
> +	int ret;
> +
> +	if (cfg->traddr) {
> +		fprintf(stderr, "hostname and traddr cannot be passed together\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = getaddrinfo(cfg->hostname, NULL, &hints, &host_info);
> +	if (ret) {
> +		fprintf(stderr, "failed to get host info for %s\n", cfg->hostname);
> +		return ret;
> +	}
> +
> +	switch (host_info->ai_family) {
> +	case AF_INET:
> +		p = inet_ntop(host_info->ai_family,
> +			&(((struct sockaddr_in *)host_info->ai_addr)->sin_addr),
> +			addrstr, NVMF_TRADDR_SIZE);
> +		break;
> +	case AF_INET6:
> +		p = inet_ntop(host_info->ai_family,
> +			&(((struct sockaddr_in6 *)host_info->ai_addr)->sin6_addr),
> +			addrstr, NVMF_TRADDR_SIZE);
> +		break;
> +	default:
> +		fprintf(stderr, "unrecognized address family (%d) %s\n",
> +			host_info->ai_family, cfg->hostname);
> +		ret = -EINVAL;
> +		goto free_addrinfo;
> +	}
> +
> +	if (!p) {
> +		fprintf(stderr, "failed to get traddr for %s\n", cfg->hostname);
> +		ret = -errno;
> +		goto free_addrinfo;
> +	}
> +	cfg->traddr = strdup(addrstr);
> +
> +free_addrinfo:
> +	freeaddrinfo(host_info);
> +	return ret;
> +}
> +
>   static int connect_ctrl(struct nvmf_disc_rsp_page_entry *e)
>   {
>   	char argstr[BUF_SIZE], *p;
> @@ -1230,6 +1283,13 @@ static int discover_from_conf_file(const char *desc, char *argstr,
>   		if (cfg.persistent && !cfg.keep_alive_tmo)
>   			cfg.keep_alive_tmo = NVMF_DEF_DISC_TMO;
>   
> +		if (cfg.hostname) {
> +			ret = hostname2traddr(&cfg);
> +			if (ret)
> +				goto out;
> +			cfg.hostname = NULL;
> +		}
> +

I guess you add the NULL to check mutual exclusion later ?

Can we check it in build_options ?


>   		err = build_options(argstr, BUF_SIZE, true);
>   		if (err) {
>   			ret = err;
> @@ -1259,6 +1319,7 @@ int fabrics_discover(const char *desc, int argc, char **argv, bool connect)
>   	OPT_ARGS(opts) = {
>   		OPT_LIST("transport",      't', &cfg.transport,       "transport type"),
>   		OPT_LIST("traddr",         'a', &cfg.traddr,          "transport address"),
> +		OPT_LIST("hostname",       'A', &cfg.hostname,        "transport address in a hostname form"),
>   		OPT_LIST("trsvcid",        's', &cfg.trsvcid,         "transport service id (e.g. IP port)"),
>   		OPT_LIST("host-traddr",    'w', &cfg.host_traddr,     "host traddr (e.g. FC WWN's)"),
>   		OPT_LIST("hostnqn",        'q', &cfg.hostnqn,         "user-defined hostnqn (if default not used)"),
> @@ -1295,6 +1356,13 @@ int fabrics_discover(const char *desc, int argc, char **argv, bool connect)
>   	} else {
>   		if (cfg.persistent && !cfg.keep_alive_tmo)
>   			cfg.keep_alive_tmo = NVMF_DEF_DISC_TMO;
> +
> +		if (cfg.hostname) {
> +			ret = hostname2traddr(&cfg);
> +			if (ret)
> +				goto out;

please NULLify the hostname for Mutual exclusion check.


> +		}
> +
>   		ret = build_options(argstr, BUF_SIZE, true);
>   		if (ret)
>   			goto out;
> @@ -1315,6 +1383,7 @@ int fabrics_connect(const char *desc, int argc, char **argv)
>   		OPT_LIST("transport",         't', &cfg.transport,         "transport type"),
>   		OPT_LIST("nqn",               'n', &cfg.nqn,               "nqn name"),
>   		OPT_LIST("traddr",            'a', &cfg.traddr,            "transport address"),
> +		OPT_LIST("hostname",          'A', &cfg.hostname,          "transport address in a hostname form"),
>   		OPT_LIST("trsvcid",           's', &cfg.trsvcid,           "transport service id (e.g. IP port)"),
>   		OPT_LIST("host-traddr",       'w', &cfg.host_traddr,       "host traddr (e.g. FC WWN's)"),
>   		OPT_LIST("hostnqn",           'q', &cfg.hostnqn,           "user-defined hostnqn"),
> @@ -1339,6 +1408,12 @@ int fabrics_connect(const char *desc, int argc, char **argv)
>   	if (ret)
>   		goto out;
>   
> +	if (cfg.hostname) {
> +		ret = hostname2traddr(&cfg);
> +		if (ret)
> +			goto out;

same here.

> +	}
> +
>   	ret = build_options(argstr, BUF_SIZE, false);
>   	if (ret)
>   		goto out;

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
