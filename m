Return-Path: <SRS0=DaCh=L5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC690C07E98
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jul 2021 07:16:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8303613CB
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jul 2021 07:16:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8303613CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:CC:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S2oUY4J67RZU/JfA6+DxP0fhgTxa9p0c0CHBsIrUDKg=; b=g0uOElnK+6DRBx+eU00vFZNVv6
	becdKtqxXZRxg+nJC2dV5cgpyB3Ov0467WFIwMQBOAOwAaxPztCUinqqapjiIbC51Q9VjzQhoVbb3
	ZabCkpFuWYKL9kfCof0CPt8hNX44Hq2Vd4SuK8w6GM7lQ7GvNeU5Ak30IyBxAuaUQcbjNhg8Vh9BK
	rYRNPozCWEX28YrjxWSG6xfg4cXkkfraNNZj0r21prxbEnlaChHZTFd32HQWwEZbH6jxk6iPAVd8W
	oxlyuy8kQGwIukaVTxSpoaRcX5wJbx697ZirEyOMblFIZLvVwBiM7lWgFgoMKPa2emvzclqTQRrap
	bkaisSkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m0IqK-0084Af-VE; Mon, 05 Jul 2021 07:16:36 +0000
Received: from mail-bn8nam12on2084.outbound.protection.outlook.com
 ([40.107.237.84] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m0IqI-0084AM-JU
 for linux-nvme@lists.infradead.org; Mon, 05 Jul 2021 07:16:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YIQcwD20lC73gbJ9rUWu/vvMoilUcEIqDxc5e0NS+/KrdNGx4gKvBwgJA6X5yDtMkyUHDN+QQZ2Wb8655qEkLRCdfmdqVkpC9+6nJeZntV6r88RdXQv1p4E99luhkqGDDlszE8GKx/rbxx709mWDYFeyTqwghbHzO7i0jfbA/VS2x6GC1w4ocCFMlvOi/y7ehUejEBC1nzTkLsSbM336wVYxMRh1MGvU6Dhl4ZDPWP+rT2y2CRR+G3lIJiGPo6of0K8Z1vb/KvlJKW+lSfj35eCFHGpOwRbxCwLtMfy3n8YrZDMfy+bGg8I9CGmqY7eWwMeQLTNkK6ytpezUIJPlBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mM2QGyKQHzGtkS+9SaHkzDWxWI3+Eczv5Xz66uab1xM=;
 b=cACZMV9ynAwhtnqF4kUcBzT3v42jZAOiiQKIv4XHjtM6You7Cii7zXkr46BmfxTHfzlGEvq2UodzfYSEZcK6x00TACHfD/PrilR7L09GfWaU8qJJos8W6KHVCSn5jLrmtjfAwJrEz1kRX4xexUccQ0fTGNzHx9QfVpWBy/uwjBSU3ObEUBeUogxBN2TK+Tishq3fo7CYXlUVj2frzEWeFc1vluv7FKnUgdC+J7QMha7Wh5rpPwVWmDRxhXdI1hghgMQzYUU9zJqgt/qkI92umKSjTmNAKJBRj1X79oULkoSim80LLVbE7KQoaqRV+Ol0JWK6qn2guIdFIzJyZiu5/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mM2QGyKQHzGtkS+9SaHkzDWxWI3+Eczv5Xz66uab1xM=;
 b=PBV+3lcmPiuG46ltD1A3uxGSO516CVtktO7nDK0oRhUT0Db74dQJoGY8AYetCy7W6W1U9byDePhi9UvEQDy44Ht9SWrcu1tCAmp3BmpHrQPH6C/JoAyQ3oEIo0+O26qUYoIF4mXICRuosn987WoYZjvGCFs92gNlDdgL6Fi2PyEygqPBO1iJ5bDiiO4GOy4f1ychUcJE/aN71hNC72Lz8xs/nk9jCjdWG5j91sOFoD404+E/NnNG5/RhSlR0JXt8Qc3jlfIlGeeNmTmxAEQhtfiSCoe9e5LLf6trAyS4uZ2NrKd/LOAbnfHaCDk117YjNM8rq/LJ42if+Soowiaa/Q==
Received: from MWHPR14CA0054.namprd14.prod.outlook.com (2603:10b6:300:81::16)
 by BN6PR12MB1249.namprd12.prod.outlook.com (2603:10b6:404:1d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23; Mon, 5 Jul
 2021 07:16:31 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:81:cafe::c6) by MWHPR14CA0054.outlook.office365.com
 (2603:10b6:300:81::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23 via Frontend
 Transport; Mon, 5 Jul 2021 07:16:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4287.22 via Frontend Transport; Mon, 5 Jul 2021 07:16:31 +0000
Received: from [172.27.15.98] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 5 Jul
 2021 07:16:28 +0000
Subject: Re: [PATCH 1/2] nvme: add set feature tracing support
To: Hou Pu <houpu.main@gmail.com>, <sagi@grimberg.me>, <hch@lst.de>,
 <chaitanya.kulkarni@wdc.com>
CC: <linux-nvme@lists.infradead.org>, <maxg@mellanox.com>
References: <20210705031529.36001-1-houpu.main@gmail.com>
 <20210705031529.36001-2-houpu.main@gmail.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <42d62146-3837-ff05-9e56-1c4c87d1ade9@nvidia.com>
Date: Mon, 5 Jul 2021 10:16:25 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210705031529.36001-2-houpu.main@gmail.com>
Content-Language: en-US
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d594898d-d297-489a-59a7-08d93f84d05c
X-MS-TrafficTypeDiagnostic: BN6PR12MB1249:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1249A08B58D5EE73C0403677DE1C9@BN6PR12MB1249.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:252;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a3D2aIbh2tXq9kGzSGzyPG2MRMQSZnBSu3MWFJVCsGm3PK7sGHv1TRXfrOgPZoOXsetSsXj197/sxIzo3Z76zXWqaSVlYAz9/uHC2P+z+tulCLgzttoU6D1qAseLfHXFsG8hwoMe7tiuWP2Tx98WcLLHWcDB6ROOQvHRH35NFriiNTWNVTHtReDW6uc0gKrGZywY13bPof6CLg5DIZKMrB+eyvBySfJXa3Sfg4R0AOvYMvgkEL8b+7sCimgsOjf/ewQLNRF+9fp2JFnvCl7D3mIf65NGd5VhTRSpkhMt0dkFaIfZFG34vkGMF26qRFxKs15G88I1ZP0y6FGffO1wXYmSBWzEcbaBjCBp+zg3Lf3JoYc0lCmHsWiMLq29AOYRAGXdNcuwslJFxAPrs7SiNh0p3vJ/puJ2rrie5S7/iRrzDjvUkaAreVzN5Tda5rjxf1BnrTM2GllEcDW81/K/awOFRzmiEW7oe4g0eDW9QE+OJ+Mr56Ak9uhkdsUpAPukR8PBNWm+2REeQ3uF7JkudYMU7zsd7BfgeYmqGhCCeLXaFNquGslP2PgbfFyxZ17TfFUOlwBMDjQUYDksXuR2p5uQTBYuGvy70n7fyCdn2BgUmufpR3A1YDw1+O+qQQjp5EvbRTkiLkbAI0dfczKubR2gndq56bmh9wYWwoToWJDESDuGdlRtDwKqjdXpXdv1OlGlWowuTN302xtbwmo0F3uPn6vQbH/bM1PCTIwMwlQxo6F6L7/mORTO/vdKOmsuOcJvcJL4eeZQUkn18PUY9Q==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(396003)(376002)(346002)(36840700001)(46966006)(47076005)(82740400003)(36860700001)(478600001)(53546011)(31696002)(6666004)(5660300002)(7636003)(54906003)(186003)(31686004)(316002)(36756003)(356005)(4326008)(70206006)(426003)(2906002)(83380400001)(336012)(16526019)(82310400003)(107886003)(8936002)(86362001)(2616005)(110136005)(70586007)(26005)(16576012)(36906005)(8676002)(43740500002)(505234006);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2021 07:16:31.2582 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d594898d-d297-489a-59a7-08d93f84d05c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1249
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210705_001634_700851_22B50BA3 
X-CRM114-Status: GOOD (  14.73  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 7/5/2021 6:15 AM, Hou Pu wrote:
> A nvme connect command produces following trace.
>
> Before:
> /sys/kernel/debug/tracing# cat trace | grep feature
>      kworker/5:1H-98      [005] ....  3221.294844: nvme_setup_cmd: nvme0: qid=0, cmdid=25, nsid=0, flags=0x0, meta=0x0, cmd=(nvme_admin_set_features cdw10=07 00 00 00 07 00 07 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00)
>      kworker/4:1H-124     [004] ....  3222.009186: nvme_setup_cmd: nvme0: qid=0, cmdid=17, nsid=0, flags=0x0, meta=0x0, cmd=(nvme_admin_set_features cdw10=0b 00 00 00 00 09 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00)
>
> After:
> /sys/kernel/debug/tracing# cat trace | grep feature
>      kworker/0:1H-253     [000] ....   196.060509: nvme_setup_cmd: nvme0: qid=0, cmdid=29, nsid=0, flags=0x0, meta=0x0, cmd=(nvme_admin_set_features fid=0x7, sv=0x0, cdw11=0x70007)
>      kworker/0:1H-253     [000] ....   196.763947: nvme_setup_cmd: nvme0: qid=0, cmdid=29, nsid=0, flags=0x0, meta=0x0, cmd=(nvme_admin_set_features fid=0xb, sv=0x0, cdw11=0x900)
>
> Using ',' to separate different field like others in
> nvmet_trace_admin_get_features.
>
> Signed-off-by: Hou Pu <houpu.main@gmail.com>
> ---
>   drivers/nvme/host/trace.c | 18 +++++++++++++++++-
>   1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/trace.c b/drivers/nvme/host/trace.c
> index 6543015b6121..2a89c5aa0790 100644
> --- a/drivers/nvme/host/trace.c
> +++ b/drivers/nvme/host/trace.c
> @@ -72,6 +72,20 @@ static const char *nvme_trace_admin_identify(struct trace_seq *p, u8 *cdw10)
>   	return ret;
>   }
>   
> +static const char *nvme_trace_admin_set_features(struct trace_seq *p,
> +						 u8 *cdw10)
> +{
> +	const char *ret = trace_seq_buffer_ptr(p);
> +	u8 fid = cdw10[0];
> +	u8 sv = cdw10[3] & 0x8;
> +	u32 cdw11 = get_unaligned_le32(cdw10 + 4);

By the spec cdw10, 11, 12, 13, 14, 15 are used by set features command.

At least lets print cdw11-cdw15 as raw data and not only cdw11.

We don't want to loose information.

> +
> +	trace_seq_printf(p, "fid=0x%x, sv=0x%x, cdw11=0x%x", fid, sv, cdw11);
> +	trace_seq_putc(p, 0);
> +
> +	return ret;
> +}
> +
>   static const char *nvme_trace_admin_get_features(struct trace_seq *p,
>   						 u8 *cdw10)
>   {
> @@ -80,7 +94,7 @@ static const char *nvme_trace_admin_get_features(struct trace_seq *p,
>   	u8 sel = cdw10[1] & 0x7;
>   	u32 cdw11 = get_unaligned_le32(cdw10 + 4);
>   
> -	trace_seq_printf(p, "fid=0x%x sel=0x%x cdw11=0x%x", fid, sel, cdw11);
> +	trace_seq_printf(p, "fid=0x%x, sel=0x%x, cdw11=0x%x", fid, sel, cdw11);

This can be done in separate commit.

Also if you can fix the current status and print also cdw14 since it's 
used by get features by the spec (in separate commit).


>   	trace_seq_putc(p, 0);
>   
>   	return ret;
> @@ -201,6 +215,8 @@ const char *nvme_trace_parse_admin_cmd(struct trace_seq *p,
>   		return nvme_trace_create_cq(p, cdw10);
>   	case nvme_admin_identify:
>   		return nvme_trace_admin_identify(p, cdw10);
> +	case nvme_admin_set_features:
> +		return nvme_trace_admin_set_features(p, cdw10);
>   	case nvme_admin_get_features:
>   		return nvme_trace_admin_get_features(p, cdw10);
>   	case nvme_admin_get_lba_status:

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
