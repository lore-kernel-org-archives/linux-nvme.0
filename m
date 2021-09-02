Return-Path: <SRS0=DVYa=NY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DBBFC433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Sep 2021 21:37:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 150FD60698
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Sep 2021 21:37:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 150FD60698
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PT5sVm8tEVUtAjDNRfeHWAqy+GTB/ktH4z8OXZY4RJQ=; b=4tkGRWbFD3p9Bqh1qMrcmLib/F
	XrUn1Fm61z2lmGTaVIMTqXpbPY5THEQ1r+llZ935I3n0IzwUa53CJ7hTkR/QMah6ZIWtEW53sxNNz
	JQ13o7O3gtOchaBnVbuvzfjtWo+rUykDjtHwLB7OLuviBNvJzyE9oy+TOYlGKZsN/nXr982BcNA9H
	qwfCMHttj72ZDGkIEPBHau5RyNBHr/TIXc5f5nJNE3o9ut8GuHmS2hG3u+v3wsK1qWoL3puVe8SkE
	UJWzZPjO0ifXdBGgxBhE+a4+ywn4v5M+3mEFk+8ENliwFbQ9ES/i+89aPcDivrsjKxfh/RWog+Pkf
	Pg/tX3VQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mLuNo-00AXJO-VF; Thu, 02 Sep 2021 21:36:29 +0000
Received: from mail-mw2nam12on2062.outbound.protection.outlook.com
 ([40.107.244.62] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mLuNl-00AXIq-AQ
 for linux-nvme@lists.infradead.org; Thu, 02 Sep 2021 21:36:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U9E1yZrUVVUX3wBD6LgGwLRgwBDEVr5u9EG3ZpVMG0mNTlYMS7EeFpKNE3An2FxaRbiMTbOepuFmFATlwx1ewKyc/o0ZnUfdY1yg3bwrkizqxsKtGo8pKMK0Oipd/PdDyMi8CVvYvUqZsVUoIft59nOsZmTq47HT02RYr8t1XFfp/6dP4tAEU9rSrNZVw/5L2a0WtWrYL5VIZiahH/ivb3/l7UKUvF/qOoveRucIBa/rcDJnwY3G+zpkbKU33zJ/SUCbB+Cv0uR1Qq/7IANhMDNAn4KcZFe9HCepoPjo/bwt8uq+qYGPURkJCDQ+MGngcVxu/KnYRpHOLKQsI6fJCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F2HembqFbqs4jRODXKjr1XhaHjBWTE3gQzrMsUjeWwY=;
 b=V5zGJeaVWlDtkJXI/p44Ero2INOEGMOKrvbIGQuB6dHvtNwv37SK8YLKtGv8bU2Un/+8TcDByZDNFl7cD2+2SrlKK/kpOADt6Xqv2c+kGTgMFLHyX2lBPfuzorLXkcAL0Z5yIGKrynI4H45NFbW60nqYjZZtFgHmOqmAOWCZTc94et6wnUMrkEzkGqxeE3jUuC8w5TxLmRoPhwrtMWuo+fkZLAMGGAhfbBPI/Ibkk8zbTzf1lbgHyHKM6YfmvRB7SY0fH4fu3M7SAdbtr/afcfbvQbMhrTEdO4QWHMb4cwXV+vpYz9ZEtn6WfQgPkZ9DDfqsLI+nu6qgNc3K29yWPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=quarantine sp=none pct=100)
 action=none header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F2HembqFbqs4jRODXKjr1XhaHjBWTE3gQzrMsUjeWwY=;
 b=NUnb6a+d3NqFu9E61JbBGk5EHSV4Oa914ZJSye16yMGWK9SLjQeJWY+fiIcor9cArIp5KynGBP6mi26bJBA9kiw81DKpyDudQZszTlrQtiD5lcGTEMBtgcmN5oTeogAdxfy1dHz/HZu2P1EpnrnRU1TcbPbxcU3WmZpzp7FboQWsV/EyZCwHOUxEcErFKVLQxuRL7oNrrE5Nm50B5Pn1ni/wCRp4lx4PRwKEfZnRRMoB9oGXjjpGGnoh84leF5+9q+SZE3lRYl0547Zi6lGNgaG04Btm5D7caI6JuQjEaPZf55GrBNljIF8L/J5DBFn5WwTPxA8/ha/itMTjqIKWoA==
Received: from DM5PR13CA0043.namprd13.prod.outlook.com (2603:10b6:3:7b::29) by
 SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.24; Thu, 2 Sep 2021 21:36:21 +0000
Received: from DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:7b:cafe::79) by DM5PR13CA0043.outlook.office365.com
 (2603:10b6:3:7b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.4 via Frontend
 Transport; Thu, 2 Sep 2021 21:36:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 DM6NAM11FT036.mail.protection.outlook.com (10.13.172.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4478.19 via Frontend Transport; Thu, 2 Sep 2021 21:36:21 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 2 Sep
 2021 14:36:20 -0700
Received: from [172.27.1.70] (172.20.187.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 2 Sep 2021
 21:36:19 +0000
Subject: Re: SPDK initiators (Vmware 7.x) can not connect to nvmet-rdma.
To: Mark Ruijter <mruijter@primelogic.nl>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
References: <CA3F5384-4B57-47ED-9DFE-27E80F3D312C@primelogic.nl>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <2d8e7197-e25d-ba02-8e27-5869a9cf1cfe@nvidia.com>
Date: Fri, 3 Sep 2021 00:36:16 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CA3F5384-4B57-47ED-9DFE-27E80F3D312C@primelogic.nl>
Content-Language: en-US
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3ffd371-0157-4f2a-6c0d-08d96e59b4d8
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:
X-Microsoft-Antispam-PRVS: <SN6PR12MB27673EB94EDC83E485228FF7DECE9@SN6PR12MB2767.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2TuEFXnWQmw2ssbNQI/eXd5OUgfg6LI45Fi3J+oXBk3JtTSwXdP88JB6HFNP0etII6T0EGFGwqG89EKf7vMWIaG9t38/fs8z0ITf4uZR0PySb7q9DiRdrDkZ8+w8UFETwlRGGb17dX/QYwdkbpq1tlMHMXahRZfVoYk/DX7VJMkSrbDMigQVIYV+9GLNkQktm5aOH77GgQ2L3iTEufFpP4b2kiunqiXexEjsDx6Mvvs+9GZrNmbyoSHKov+N4T4fKGWiI1w8eqWM+waZ3QgLEvmSNBwg7Np/PMPBswEUxTt3FjAyE3pJWme6rqjqOWv67/yUFXN9ax+cCjL/ccqLRjaeXcM56Wjc8GwG047kEfzL3zAquiFTG1ePuo+8NZrPqmGavYYKQlGJ9mzvOhl4E/kw6dlGOQn2nqliRxUlUCqCp4HGSfv7qPKwfRhQoNXNkYLvgbkKX6qF997gOwI1ik0ibrdxjNKh+itqJOe/VuMchPLOszB7275ov+pcUxpYzOdKygfC/yZRYd0060JD9lbNsHQKu9LR28tgeZMYai4nM1gYfwOPrdT/K2HuBM+PEvMO+BmHBL+MOkjOLIeMacKRZF2PNZ1ibx6rXaQUCOXUD5NcXfKLC1Gyyy0q2+yMkhveNwphYcha6ZU7zh+trj/nPFPOlIeP+G866JYfKTj7Q/b1uvchswWBOuI0gg8Ziiq+YNlocnNPRgSgsZR+elDtlzyGk6ok+UhPTohxw5/bsvkf2l3yHdbc+38IuZ1DAmxoVOfaoNwwq4NN6LvxQPJaytCcCFsk6B7EfmI2IBhg9nWo0rnIifngQEloV7XCqnv1NlBY/cTsLnnXVFT67EU2mcorhzRyLkddIcz+xEEMC4YJIF5lfAdFhAATnj6A
X-Forefront-Antispam-Report: CIP:216.228.112.32; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid01.nvidia.com; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(39860400002)(136003)(46966006)(36840700001)(186003)(426003)(5660300002)(86362001)(82310400003)(47076005)(36756003)(6666004)(336012)(26005)(2906002)(70206006)(316002)(83380400001)(70586007)(31686004)(31696002)(16526019)(16576012)(110136005)(2616005)(478600001)(966005)(8676002)(7636003)(356005)(53546011)(82740400003)(36860700001)(8936002)(21314003)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2021 21:36:21.3773 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3ffd371-0157-4f2a-6c0d-08d96e59b4d8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.32];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2767
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210902_143625_564366_3BEB9304 
X-CRM114-Status: GOOD (  20.57  )
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


On 8/31/2021 4:42 PM, Mark Ruijter wrote:
> When I connect an SPDK initiator it will try to connect using 1024 connections.
> The linux target is unable to handle this situation and return an error.
>
> Aug 28 14:22:56 crashme kernel: [169366.627010] infiniband mlx5_0: create_qp:2789:(pid 33755): Create QP type 2 failed
> Aug 28 14:22:56 crashme kernel: [169366.627913] nvmet_rdma: failed to create_qp ret= -12
> Aug 28 14:22:56 crashme kernel: [169366.628498] nvmet_rdma: nvmet_rdma_alloc_queue: creating RDMA queue failed (-12).
>
> It is really easy to reproduce the problem, even when not using the SPDK initiator.
>
> Just type:
> nvme connect --transport=rdma --queue-size=1024 --nqn=SOME.NQN --traddr=SOME.IP --trsvcid=XXXX
> While a linux initiator attempts to setup 64 connections, SPDK attempts to create 1024 connections.

1024 connections or is it the queue depth ?

how many cores you have in initiator ?

can you give more details on the systems ?

>
> The result is that anything which relies on SPDK, like VMware 7.x for example, won't be able to connect.
> Forcing the queues to be restricted to 256 QD solves some of it. In this case SPDK and VMware seem to connect.
> See the code section below. Sadly, VMware declares the path to be dead afterwards. I guess this 'fix' needs more work. ;-(
>
> In noticed that someone reported this problem on the SPDK list:
> https://github.com/spdk/spdk/issues/1719
>
> Thanks,
>
> Mark
>
> ---
> static int
> nvmet_rdma_parse_cm_connect_req(struct rdma_conn_param *conn,
>                                  struct nvmet_rdma_queue *queue)
> {
>          struct nvme_rdma_cm_req *req;
>
>          req = (struct nvme_rdma_cm_req *)conn->private_data;
>          if (!req || conn->private_data_len == 0)
>                  return NVME_RDMA_CM_INVALID_LEN;
>
>          if (le16_to_cpu(req->recfmt) != NVME_RDMA_CM_FMT_1_0)
>                  return NVME_RDMA_CM_INVALID_RECFMT;
>
>          queue->host_qid = le16_to_cpu(req->qid);
>
>          /*
>           * req->hsqsize corresponds to our recv queue size plus 1
>           * req->hrqsize corresponds to our send queue size
>           */
>          queue->recv_queue_size = le16_to_cpu(req->hsqsize) + 1;
>          queue->send_queue_size = le16_to_cpu(req->hrqsize);
>          if (!queue->host_qid && queue->recv_queue_size > NVME_AQ_DEPTH) {
>                  pr_info("MARK nvmet_rdma_parse_cm_connect_req return %i", NVME_RDMA_CM_INVALID_HSQSIZE);
>                  return NVME_RDMA_CM_INVALID_HSQSIZE;
>          }
>
> +        if (queue->recv_queue_size > 256)
> +               queue->recv_queue_size = 256;
> +        if (queue->send_queue_size > 256)
> +               queue->send_queue_size = 256;
> +       pr_info("MARK queue->recv_queue_size = %i", queue->recv_queue_size);
> +       pr_info("MARK queue->send_queue_size = %i", queue->send_queue_size);
>
>          /* XXX: Should we enforce some kind of max for IO queues? */
>          return 0;
> }
>
>
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
