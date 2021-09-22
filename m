Return-Path: <SRS0=1D85=OM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A34BC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 14:03:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EBB460230
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 14:03:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3EBB460230
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:CC:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XhIYjFRdn/Nk0EYZ4L/opnq+QoXBvyYwz1bDZpx3mJY=; b=nHzxtEBl8meRKmnCA3BlJ9aMUY
	O+3+jtUeHeRiMzwFZplZlIOo/4Cz7AcfA3fvRSWi2jWUM4BK0se1Vf4yY8QKH3/eHnghTKaxmXjVe
	R3sPkMKPHEAYZ++njs6/foe9xs7pU8M6xdOd/M9CD6XMYT/XEvQ0XBKVRkkxq14f2yXHxg5lVDiCb
	YHGEBAnOFMiNWMSWQU2Cq7opOLawPXMwePcY36wthQcG9EgTzLURW6zeq2fDxlEiK0a/vxCA0gp8Q
	MnSYvt1IW6BIgQv5vbQH2o5r0DpXRGbsQbmTZT1SFA6Jq7FgYk6+7J9ZXu8AWlODXGSWBZsM38xFa
	DwF6VQqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mT2pl-008jvw-Gd; Wed, 22 Sep 2021 14:02:49 +0000
Received: from mail-dm3nam07on2043.outbound.protection.outlook.com
 ([40.107.95.43] helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mT2nL-008jHV-2c
 for linux-nvme@lists.infradead.org; Wed, 22 Sep 2021 14:00:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BR1YZ01IxKlEeVnbpeiLlkpq+MWMB9Iw7swoy6X7dxSYchPK60qnnSKRVbrY2ISDmGTA0uGU8k8S3R2EZd+2PfxYa9OReOyseAkXLqYWV3+eAVGHPfGHn+/3nqOYcitM8PqFJsy32Hbtkjay1DjuIuHyiNXvChdWqtFuv0n0kFWJV9aibXlypdIbb1Au4vHpzNHqxsdTPZG5qieNzrGZyZVPuX74PNhGYHwpAu6ItdCuCGqNvoHezlAKCzZjNqu6FPGIPtd8ffLXVKoC2Cc6tkhniZY/jjgyllnx34qNYDdkLycxQMBENiEFuNxpuNdURX7dnn7lp/PAYJ4mhtD8Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=KAghAlUxijPNxOplEYaUwjvDB4p4vpR5YYTI/xSEQaM=;
 b=G3CyuTJDSjRz3RCGoXPheYN/hnMW9wtpP0eEQWpnP0LD6Ip27ucU5ReyYapwJcTZ/1u3G2vrsHlzROJWFUoNVgm+PPTxkdEo4j2P879uE1qFbIxDjUmCaaqUkVoW1YmkRf/TjC+v8u/a0FF8YOTBKVHXi9f1bUhMQVIxiqeSw2I87bYfcjiKFM0ur455wLd1h2N0cKxh9bj3eBzeA7UESQXRf5ZgLKRJCDjqgaRKB72vnPrX/q6uI8XOB8eR7Nsix9FkUju+VvZfDSHsxjY/yQzypquHg9+bSLwV4UBRlbkT0mW2BrSKMIWwu+oQZnTj9eAxo0nqZPuwcukC8IsGxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com; 
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KAghAlUxijPNxOplEYaUwjvDB4p4vpR5YYTI/xSEQaM=;
 b=CZChlATy6M4J1JSMk2dkws6f1OKZxa2L+WH+I0DAcGLXoLprs06SDvL9lxlilVGGvM1QB0xGrzXIsV54yGRBOpGFtk+bxUbcLg0jYyhUObaxVayziazVqn+O40VmHXHdzAy8jx4E606fYFA3tpZM7t2LWh6ntA+NuQPGSyr2DSBA6cUqub96kWlzDxg5yBVGB8L41HvqYJBlrOo3SqPBz3H2gIpC8h8g8mBff8KrLI4bh31M5OGykVwBbS7JAQfRTmD27xEt8VWAtCpbKG4WiedBiFp7DaQWz2SXy3xsFo99ydrugYuLQYHw8CmwjQ4oBCTZacvIjDPNQhoa2gKijA==
Received: from MWHPR12CA0061.namprd12.prod.outlook.com (2603:10b6:300:103::23)
 by DM5PR12MB2341.namprd12.prod.outlook.com (2603:10b6:4:b5::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Wed, 22 Sep
 2021 14:00:15 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:103:cafe::9e) by MWHPR12CA0061.outlook.office365.com
 (2603:10b6:300:103::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Wed, 22 Sep 2021 14:00:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4544.13 via Frontend Transport; Wed, 22 Sep 2021 14:00:15 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 22 Sep
 2021 07:00:12 -0700
Received: from [172.27.14.84] (172.20.187.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 22 Sep
 2021 14:00:09 +0000
Subject: Re: [PATCH 2/2] nvmet-rdma: implement get_queue_size controller op
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 <linux-nvme@lists.infradead.org>, <kbusch@kernel.org>,
 <chaitanyak@nvidia.com>, <israelr@nvidia.com>, <mruijter@primelogic.nl>,
 <oren@nvidia.com>, <nitzanc@nvidia.com>
References: <20210921190445.6974-1-mgurtovoy@nvidia.com>
 <20210921190445.6974-3-mgurtovoy@nvidia.com>
 <0b93503b-93c6-6314-939a-34bd69c30113@grimberg.me>
 <300d5661-c22c-bb8f-e5c3-38902dd946a0@nvidia.com>
 <20210922074550.GA16099@lst.de>
 <01762668-1572-9f37-73e8-714d4ff23323@nvidia.com>
 <6df58d37-0519-9e97-bae5-a529084c8341@grimberg.me>
 <20210922121014.GF327412@nvidia.com>
 <902a6d63-fbf1-532f-c3f9-b74942b00ff0@nvidia.com>
 <20210922133119.GQ327412@nvidia.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <2aa9983a-b4eb-63c7-b9b6-a63bdc7d585b@nvidia.com>
Date: Wed, 22 Sep 2021 17:00:07 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210922133119.GQ327412@nvidia.com>
Content-Language: en-US
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e279a766-b0f8-4c9a-053f-08d97dd14d82
X-MS-TrafficTypeDiagnostic: DM5PR12MB2341:
X-Microsoft-Antispam-PRVS: <DM5PR12MB2341CB97CB99364BC6166A5BDEA29@DM5PR12MB2341.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T23asTBe/j2arhk989wqPOlxY5sCpFQpvI68L8n84ikgoI/8/MMZaYRDJx6x6L0377xg/zmHIux/0hcnXbgZMiSS4LtwYUXJUxeH/c/xDRxMYO7NtZZmYl6MG6nxHujyWEs+/dpa9f0B/C+Bad5gwI3Wv+IURGmOnUEh+NCvmEpupk8KKscxjk2X8LrvqNibs7imDd/oDEBagkcEISImDUu6V5RnzVox8dFNR9Jw/OGDSfCeX/mGaGYgPi3mypRvRCV5za3v9O11RKAyYC/p+ylhKluB3mwsQd9hGHGhmtnCov/MRzdanz8Ob/7Wp8p2dx1JhibPjjRwzMXIed8YqKVR/BcjbABJWCyDABHPyNY38JgHBkBvDD4GK6vTK3C2XyvofVs809C5BE1LY6SprC/vLD5hCWlm2ojcRl51fp5njnKSQPW9lD+vXVvHp+rJF41JN3z5nzYGJS2jLzx253OR56U+8sJS727aBq1zhAxcTJl4MjMz0wsAWnJZ1qPC2fuftmd8QBJYlFDK/R7HXHAqTZnRp7VuSfeCAURNb/1kd2JiaAd84sPjDWzHRLzRRDV3tx2obSTn6Hag6jMtKuCarCrPuqKvW2hx52jkTv5q8iPNmdvx2bcU5lzQyDlJhOSajZWjfwd1MWJRff+O5mcMc7U2vl70n/PHNcmx5u4cAYu79jzkAHNG/rixwr15U8vWabAnaCORm0zZ1fXb7pUdQm0KzKZSW6HjsXumJ9E=
X-Forefront-Antispam-Report: CIP:216.228.112.32; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid01.nvidia.com; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(31696002)(54906003)(70586007)(70206006)(5660300002)(16576012)(186003)(426003)(8936002)(316002)(36756003)(107886003)(2906002)(31686004)(37006003)(7636003)(53546011)(336012)(26005)(8676002)(4326008)(86362001)(356005)(82310400003)(36860700001)(6862004)(83380400001)(6636002)(508600001)(2616005)(47076005)(16526019)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 14:00:15.0619 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e279a766-b0f8-4c9a-053f-08d97dd14d82
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.32];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2341
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210922_070019_211648_9D34CA17 
X-CRM114-Status: GOOD (  25.50  )
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


On 9/22/2021 4:31 PM, Jason Gunthorpe wrote:
> On Wed, Sep 22, 2021 at 03:57:17PM +0300, Max Gurtovoy wrote:
>> On 9/22/2021 3:10 PM, Jason Gunthorpe wrote:
>>> On Wed, Sep 22, 2021 at 12:18:15PM +0300, Sagi Grimberg wrote:
>>>
>>>> Can't you do this in rdmw_rw? all of the users of it will need the
>>>> exact same value right?
>>> No, it depends on what ops the user is going to use.
>>>>> is it necessary for this submission or can we live with 128 depth for
>>>>> now ? with and without new ib_ API the queue depth will be in these
>>>>> sizes.
>>>> I am not sure I see the entire complexity. Even if this calc is not
>>>> accurate, you are already proposing to hard-code it to 128, so you
>>>> can do this to account for the boundaries there.
>>> As I understood it the 128 is to match what the initiator hardcodes
>>> its limit to - both sides have the same basic problem with allocating
>>> the RDMA QP, they just had different hard coded limits. Due to this we
>>> know that 128 is OK for all RDMA HW as the initiator has proven it
>>> already.
>> Not exactly. The initiator 128 is the default value if not set differently
>> in the connect command.
>>
>> Probably this value can be bigger in initiator since it doesn't perform RDMA
>> operation but only sends descriptors to the target.
> Well, that means the initiator side needs fixing too. I see this:
>
> 			if (token < NVMF_MIN_QUEUE_SIZE ||
> 			    token > NVMF_MAX_QUEUE_SIZE)
>                              ERR
> 			opts->queue_size = token;
>
> Which is probably still too big for what some HW can do.

Yes. I'll fix it in V2.

>
> Both host and target need to bring in an upper limit of queue_size
> from the RDMA layer. A ULP should not pass in a value to
> ib_qp_init_attr::max_send_wr that will cause QP creation to fail if
> the queue_size is programmable.
>
> Currently there is no way to to get the device limit for QPs using
> IB_QP_CREATE_INTEGRITY_EN. We know at least that 128 works on all RDMA
> devices.
>
> In any case I still view it as two tasks, fix the various interop
> problems by adjusting the current hardwired limits to something that
> works on all RDMA HW and computing the actual HW limit, adjusted by
> RW, etc.
>
> Jason

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
