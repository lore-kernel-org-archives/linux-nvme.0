Return-Path: <SRS0=1D85=OM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F757C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 13:03:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59AB7611C0
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 13:03:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 59AB7611C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:CC:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IBBsoD4gXbzIfKbyZ+t2f8VXiIGipzCjkc2jfWPch6s=; b=scvvMhR8Vi37zjGWU/K5TmGbaw
	NGkw0GHMbXZjWiX9WE7BF85MA6xdpTx5NIdW/GqRrgmu5jQ2MeKovWtaV74Pkzcs0B6MAJlbbE3UO
	CC0vujDPVTp1hjt4RERlhqsWTFYCVLKRoUsVuJTHrgmha3ZZ88yRSdvXIQFADkzq3HTzQ33Ic4VXd
	VELgKKiB/iTDKXaNFYasmvnamyGDOwsx37nqoUs6VePSgV625/yoWSG3rCm+Ii376r0EuadD1QCCz
	NhT0vAogy1TyUgS/kw0Nl8P6Rt2FlDAu6yp2qJqtnWWNtqaf5LWsTvGuPa0+sDSKRo60iKM4Qqz0F
	bK2WIYQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mT1ud-008VmN-Av; Wed, 22 Sep 2021 13:03:47 +0000
Received: from mail-mw2nam10on2061.outbound.protection.outlook.com
 ([40.107.94.61] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mT1oU-008THe-KV
 for linux-nvme@lists.infradead.org; Wed, 22 Sep 2021 12:57:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YvC5sNjV/vGCV7KRDBWRPPMZ3JkVBIp4BMT0VjB933lZ/RM+32UUPW0yhaS913MpyfCW8bVlVvvpSZWYUSGy+c5Qt6ayWSa7IuimIoYfRXoETaq4Wcv2J3kLf4MgozNJPEoJXGH+jOmrh9teM09TKe7pBOWJMI1R4fw4LRey5CBJuzzxiETvrX+Oz6WZDQi4E0dJOPEDWpsBgILtDAj0J9l96ywVZAukE4eCLdLPIo6oDaKB3WUKP4rwvVP2LX1g4QMgYDbzpL5EcSqktMABioZz/SD7xSXQ+ow5cUfKqooZyLjzstQ9q7eT0KHJsRCJqfUFgUegeFHeXbq0bqf3gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=VeIVrt9f7AKlQCNq05X0swkr+qin8zbPCAxjwJRCeqg=;
 b=aWB6dW7H1lY2eXCaQePnVtQw4aqEDKtxdkwEEGtYyuYhRmjWWt8zNogjBtGqt4o1bmyL+GYSkCNi42FkouMGi929hLDakDYBw8oF4dfXW87trG5h64LpC2L4Z6W8zBeI35kHF38AeMs9YN1QwhoKSf4n6CbeG5wq6q21IJrG9kXnbdhDwS0o5k7h/yU2Ic04ALmUs9niBH9c0z55IpgMb/fvYE1SCBw5EHUZA1CDPhZraUpVSDhYY5aEINJulKuRd96reIL146IALDTfjipHjMGyizkTg7inxdbIXuDQizkx+e0GB6EI9McDNEicb5L3KkS99Af0KIXIaa3vjK2spQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com; 
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VeIVrt9f7AKlQCNq05X0swkr+qin8zbPCAxjwJRCeqg=;
 b=OK9WX2q60qx1meQzkn10qj8FvAy/59pX06RtDJmle1hZzSki5EBNP+ZzfAgT/bHmZUSniqROh9wmxYFr15h+aAfk4sJnMTbOh0wdp4Be07cpabOEApZ4z0N6C/fibfNH/WB7JY4dMBehfqeP0Dq/+YVumvt7v/tAMMjlLy2vR/gY69SE7tqGmSAtPZY1XV3aDMa/fAsidGQxU09sxM2Il3i5Eu7VN77c+mj9rZo+P2Vh19DGSXTC4+21ejjx641Yfcs91ty+svqB0qJKHEbecLajf5yI2HWp7VKkk2uSROg1/1Ik+cXlUEDnl+rJT+BGrydS6p62nWeDkqU2aINpUw==
Received: from CO2PR04CA0005.namprd04.prod.outlook.com (2603:10b6:102:1::15)
 by BYAPR12MB3303.namprd12.prod.outlook.com (2603:10b6:a03:131::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Wed, 22 Sep
 2021 12:57:23 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:102:1:cafe::b2) by CO2PR04CA0005.outlook.office365.com
 (2603:10b6:102:1::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Wed, 22 Sep 2021 12:57:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4544.13 via Frontend Transport; Wed, 22 Sep 2021 12:57:23 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 22 Sep
 2021 12:57:23 +0000
Received: from [172.27.14.84] (172.20.187.6) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 22 Sep
 2021 12:57:20 +0000
Subject: Re: [PATCH 2/2] nvmet-rdma: implement get_queue_size controller op
To: Jason Gunthorpe <jgg@nvidia.com>, Sagi Grimberg <sagi@grimberg.me>
CC: Christoph Hellwig <hch@lst.de>, <linux-nvme@lists.infradead.org>,
 <kbusch@kernel.org>, <chaitanyak@nvidia.com>, <israelr@nvidia.com>,
 <mruijter@primelogic.nl>, <oren@nvidia.com>, <nitzanc@nvidia.com>
References: <20210921190445.6974-1-mgurtovoy@nvidia.com>
 <20210921190445.6974-3-mgurtovoy@nvidia.com>
 <0b93503b-93c6-6314-939a-34bd69c30113@grimberg.me>
 <300d5661-c22c-bb8f-e5c3-38902dd946a0@nvidia.com>
 <20210922074550.GA16099@lst.de>
 <01762668-1572-9f37-73e8-714d4ff23323@nvidia.com>
 <6df58d37-0519-9e97-bae5-a529084c8341@grimberg.me>
 <20210922121014.GF327412@nvidia.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <902a6d63-fbf1-532f-c3f9-b74942b00ff0@nvidia.com>
Date: Wed, 22 Sep 2021 15:57:17 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210922121014.GF327412@nvidia.com>
Content-Language: en-US
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d119794-9114-46ed-2f7f-08d97dc8858b
X-MS-TrafficTypeDiagnostic: BYAPR12MB3303:
X-Microsoft-Antispam-PRVS: <BYAPR12MB330315BB8A1CACA82B09F93CDEA29@BYAPR12MB3303.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IppoZ6T5a96R6Y51GNPtR9IGsE4Vnyci65tL8mwI1lebMP5yO1Bzw0BhcDkJB+/6RWi2PB3KtPJpDguAnDE3jL9R+P+hJpX134nfOC+zvOWNXLn02a9QCnab8VA/WOf29UlEGEEYeDgsmn+b8XBHF9Ut5FZUrA+v8k9KkVCRu+tg5DIeds0mmtPTsr7YSn/6R6nsfkgS6XHZrLFCGz1VREPQnnSzhCad/K5I07lcdZW9+Q9/eCbwvZ6Cins7pN8Dxo3KleERerIzp4o/ddBT5TGrQhlQ/nN/hxDZCgEK5F2muWdlNrr7SBb1duVmcYiVMX67ttI8QO+KliCKxeN0XOUFDfupp9e0NE21KKYkQ/VlBctgpc9S43K/T/E+9/bruE3cEBqp4EsJfHAL+P6c8rSAgvaTY8uMLW8+DYrTpmxKgltga7v7gpo9RmOuEqmVTUFKYkXOYU2g7vsd/6+3sT4te9P5bQOJ54/Nx7xxhscDkl5qsp5kalvSexJd3naY0dkEmFi3XP8qUzZsz0znlN5melAaHRKmdJdEsOwBAYBIERfww1Z4X/8FEwZSoiqYMEarmFWdG7uW6dwdIiYlEMXCbF2vX6WnINK6sbJVbiqv70wy271cY8OoNurwjiuqG3qRQu/256vYKEXiJgjswta5+VSueUvgqRu//ghqbHU3NVbtt78tzdwBPR3iIf2JesrDUM6Q/3086DNiC8dKBxOK2r/ozXgZvV6RZcEw1BE=
X-Forefront-Antispam-Report: CIP:216.228.112.36; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid05.nvidia.com; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(336012)(4326008)(47076005)(31696002)(2616005)(83380400001)(36860700001)(8676002)(31686004)(36756003)(53546011)(16576012)(356005)(7636003)(70586007)(316002)(70206006)(82310400003)(16526019)(54906003)(36906005)(26005)(8936002)(508600001)(186003)(86362001)(5660300002)(426003)(107886003)(2906002)(110136005)(6666004)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 12:57:23.6059 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d119794-9114-46ed-2f7f-08d97dc8858b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.36];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3303
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210922_055726_771124_962C72E8 
X-CRM114-Status: GOOD (  22.04  )
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


On 9/22/2021 3:10 PM, Jason Gunthorpe wrote:
> On Wed, Sep 22, 2021 at 12:18:15PM +0300, Sagi Grimberg wrote:
>
>> Can't you do this in rdmw_rw? all of the users of it will need the
>> exact same value right?
> No, it depends on what ops the user is going to use.
>   
>>> is it necessary for this submission or can we live with 128 depth for
>>> now ? with and without new ib_ API the queue depth will be in these
>>> sizes.
>> I am not sure I see the entire complexity. Even if this calc is not
>> accurate, you are already proposing to hard-code it to 128, so you
>> can do this to account for the boundaries there.
> As I understood it the 128 is to match what the initiator hardcodes
> its limit to - both sides have the same basic problem with allocating
> the RDMA QP, they just had different hard coded limits. Due to this we
> know that 128 is OK for all RDMA HW as the initiator has proven it
> already.

Not exactly. The initiator 128 is the default value if not set 
differently in the connect command.

Probably this value can be bigger in initiator since it doesn't perform 
RDMA operation but only sends descriptors to the target.

So we'll need the ib_ future API for initiator as well, but not the RW 
API since the factor for NVMe IO will be 3 (MEM_REG, MEM_INVALID, SEND).


>
> For a stable fix to the interop problem this is a good approach.
>
> If someone wants to add all sorts of complexity to try and figure out
> the actual device specific limit then they should probably also show
> that there is a performance win (or at least not a loss) to increasing
> this number further..

Correct.


> Jason

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
