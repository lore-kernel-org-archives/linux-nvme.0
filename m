Return-Path: <SRS0=UQCu=LC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBDEFC4743F
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 11:54:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCCF56135A
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 11:54:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCCF56135A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:CC:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/6foxv0OLnrglnAdufkUJ7H4IlKIR3405d/KZV1nfHs=; b=rEDAC4qw+KBO5UzYNP4zcOQcc0
	5X41WU96hHoeIahJYjQVEAbcb4mHQ7o8Vo5AuLIJwbH45y1OsrwHP6lKeBPVoMwum85pcdnVYzU5s
	dZoD6k9E9gCYV+K9PAbwEKE4Ek8E2iTmqr1KE27GLm/JJQmqoAAnj7cmmxM37MyjvGA1cF5iPGMuG
	bpDkT+eJ9rN0DuPhXV64ZccA/HvR/91w6VOOgBzXFK4Fn5aYN/mp5rozEXuxYAThYh7s9MBC/FNg8
	kCTNSYXwE9IONNDfiqv2bFu9Dk5U6fLGCKQHU7jw3EsLOyRxSIZ3KZuI5PaiQ/crwp0d5TqdDfgDi
	dWyTV4vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqaJl-00893k-QM; Tue, 08 Jun 2021 11:54:50 +0000
Received: from mail-dm6nam12on2076.outbound.protection.outlook.com
 ([40.107.243.76] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqa2J-0084Oq-Uu
 for linux-nvme@lists.infradead.org; Tue, 08 Jun 2021 11:36:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hocVYsneftIqMVSKFvUSlq0nbaXKftsPqmFw0iZrceUx+FPc5QrCFQUxCoIeUAPttJ0JVsSc/RWVmCknsNsDtCQ7qHW6IywwrB8t+npEERRwK1sETJepRig6z+jC3TKg6t319Q9HTYExWyGjjveUsY+8zMTacO5IjK85TWH8wJ5/Dhi2OOkskk/BFz424ODgD6wt+dNOmyJCmArdrOd/JWTdqv7Jzm+7uv/DDzCaTiKQoLorm4WU2PnSgMuH2QZ/HtjI1G52KLWSxy2HUIm4pk6lA3aVKLLcV9D1wcIQnqOpJzmtaNXGOzBEJ5y+QNheXyqJSj9aUgazyRpCRsdFKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQNqQJt+Y2ybIrgd9wcbHoA3odBctXfFamBdh5eyxwA=;
 b=MHdu0LGRjdOrTiYxCdez9Ld9tebfIIQwaMaWxNWYZ2C6M7DfnnKTYqUQoR3BMZN5BnvRAJlTRoy6+88HtMu5ii6gFPhYGygp+BtGOmPVfuXWNir1TodPBh6tUDUa2kZB+KMq891zzRVUY/iXZ0DHAWizkNquLVh5zolmoqRdznhctiaHu8XGEIgVkit+1+EzYxCKWiCDQn9W8cOnm00nXGYIHKQCD3hiZ+DMrmQYBEg5sOUCHsuLsScDPI9W/UR7fSgjBHKMDqyZzix+fQ9Jxu3EZ+T33gb5mBQB4q2UfO3p09AZvFlsjbLqH/un+D2ERGFdvUl8F1Q0uMKsYRo0/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQNqQJt+Y2ybIrgd9wcbHoA3odBctXfFamBdh5eyxwA=;
 b=ZzUIKtWEiYI+BtLwHyDb5/mzj6f5/pA56IH6KzOyJi7Ti0nOQzhXPFVSsrr6lrF2VWK+C3F4IDuUPpX5a54smQDGEhogvWHSxUtS2OhesO9Ds1XHLydKHSQJFbtXk4v2Ws51fRaODkyryIjlDWvgLxGX33sodYQn+0uGFkie6YjGcljVAiujetBAQb+RvlXrY8mKWKhK7WPDmolkRPwl5PcmfE5+Qn80RQ7jtV6THR+icdqKwHxhusJ9GQ+6fudX12BPdptV9cJhgOmuBNOnEgcxEHqElJKErsoj2IcmVSXQ6A1cU/76ZxYc7Hb8c7Tr0/viDlXfNIRz04U6R2ieLw==
Received: from BN9PR03CA0197.namprd03.prod.outlook.com (2603:10b6:408:f9::22)
 by BYAPR12MB2821.namprd12.prod.outlook.com (2603:10b6:a03:9b::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Tue, 8 Jun
 2021 11:36:44 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f9:cafe::fb) by BN9PR03CA0197.outlook.office365.com
 (2603:10b6:408:f9::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend
 Transport; Tue, 8 Jun 2021 11:36:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4195.22 via Frontend Transport; Tue, 8 Jun 2021 11:36:44 +0000
Received: from [10.222.163.45] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 8 Jun
 2021 11:36:41 +0000
Subject: Re: [PATCH v2 2/4] nvmet: make sn stable once connection was
 established
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "kbusch@kernel.org"
 <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>, "ngottlieb@nvidia.com"
 <ngottlieb@nvidia.com>, "oren@nvidia.com" <oren@nvidia.com>
References: <20210607092324.1031046-1-mgurtovoy@nvidia.com>
 <20210607092324.1031046-2-mgurtovoy@nvidia.com>
 <BYAPR04MB4965C4BD68DD41755F8CA15386389@BYAPR04MB4965.namprd04.prod.outlook.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <39a2ef7e-d511-8237-c298-cf32763a4880@nvidia.com>
Date: Tue, 8 Jun 2021 14:36:33 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB4965C4BD68DD41755F8CA15386389@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07648b38-ec8f-4fcd-7d79-08d92a71b13e
X-MS-TrafficTypeDiagnostic: BYAPR12MB2821:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2821D70EE375B999604BFA4CDE379@BYAPR12MB2821.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DRvuA3SAnUEh5MFfHQLUzvavFpTx+84K/iNyi+OjpSMBMsM6Rb9MvHJ7A2qbb6n13xngEIEun2COpvjCnEAmyYbqtRCEHYCHn1NQuwnSPG65bUXKcKCIHI82gzUh1jKisbmOqnZUFKT2BI2zH3XTPBj0jgO8XeqLIo04hPV8qnUGOIxEKa9VEmF+ddXZRkVuJ5L5at/bEYIceyAqOmjxV6gTi7vH+VyLojJA0wYUMNEXqJ2+6FmX6Q+9RI2zyh7OwpJB2vYURt2fOgYJUyzS/DpzFkjoawlZO7SgoV5hlS7ZegJWusAOljWCWks5cqdWMGfIZtzmxHXaDw9umzYnDgL+i/c7eMENFrc+GK+Aj1YkPsJkT6LRFEDSPn+qRpTxmnDa600UmnVLAq4yWqC2n5FGLUCrIR+XMdJrs9AQTU9IUUZQ1tcu39ptr5FTdpe7kuGAL7yRKXMZEj6jONvDGJu29gyMuhOjiaORM14QG0s7uuIs9tntACLq9++ZW+aPQpQRyEC1tsc/FXK9KVXDFeLWjgbLiTMIqBA7+NGFqts4iL9FhdzP3xBUNE6mzP5klBkNBlciRNGTvhCjhNhE4pZGfp9hw8WvuYaNEXQugY5cz54x6ykzTsbX2C0fXumyWtqifsfh3N2d+090UI146H2yTP5DMcSrpBGIXUKcPubVoxcqvHOKMZakz66c7nOj
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(46966006)(36840700001)(53546011)(54906003)(2906002)(36906005)(86362001)(4326008)(5660300002)(36860700001)(6916009)(47076005)(8676002)(336012)(83380400001)(2616005)(31686004)(426003)(16526019)(8936002)(82740400003)(6666004)(316002)(107886003)(26005)(31696002)(16576012)(36756003)(70586007)(356005)(478600001)(186003)(7636003)(70206006)(82310400003)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 11:36:44.1080 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07648b38-ec8f-4fcd-7d79-08d92a71b13e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2821
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210608_043648_128450_000CBF7F 
X-CRM114-Status: GOOD (  22.57  )
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


On 6/7/2021 11:37 PM, Chaitanya Kulkarni wrote:
> Max,
>
> On 6/7/21 02:23, Max Gurtovoy wrote:
>> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
>> index 0ae809ca428c..bd0a0b91d843 100644
>> --- a/drivers/nvme/target/nvmet.h
>> +++ b/drivers/nvme/target/nvmet.h
>> @@ -231,6 +231,7 @@ struct nvmet_subsys {
>>   
>>   	u64			ver;
>>   	char			serial[NVMET_SN_MAX_SIZE];
>> +	bool			subsys_discovered;
> When subsystem is discovered (connected to the host) we will have non empty
> controller list, instead of adding a new bool variable why not use
> something like following tested patch on the top of this one ?

No it's not the same. The controller list can be empty if initiator_A 
performed connect + disconnect.

In your solution, it is allowed to change the sn after the disconnection 
but in the original solution we don't allow this.

Once *any* initiator connected to this subsystem, the serial nmber will 
not be changed anymore.


> (that also fixes the indentation of
> nvmet_subsys_attr_serial_store_locked()).
>
> diff --git a/drivers/nvme/target/admin-cmd.c
> b/drivers/nvme/target/admin-cmd.c
> index bec84c231d37..897f419be618 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -366,12 +366,6 @@ static void nvmet_execute_identify_ctrl(struct
> nvmet_req *req)
>          u32 cmd_capsule_size;
>          u16 status = 0;
>   
> -       if (!subsys->subsys_discovered) {
> -               mutex_lock(&subsys->lock);
> -               subsys->subsys_discovered = true;
> -               mutex_unlock(&subsys->lock);
> -       }
> -
>          /*
>           * If there is no model number yet, set it now.  It will then remain
>           * stable for the life time of the subsystem.
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
> index a13da86fb374..94e23dca763f 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -1046,11 +1046,11 @@ static ssize_t
> nvmet_subsys_attr_serial_show(struct config_item *item,
>   
>   static ssize_t
>   nvmet_subsys_attr_serial_store_locked(struct nvmet_subsys *subsys,
> -               const char *page, size_t count)
> +                                     const char *page, size_t count)
>   {
>          int pos, len = strcspn(page, "\n");
>   
> -       if (subsys->subsys_discovered) {
> +       if (!list_empty(&subsys->ctrls)) {
>                  pr_err("Can't set serial number. %s is already assigned\n",
>                         subsys->serial);
>                  return -EINVAL;
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index f7fbf9690ce8..73c6c4dc8997 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -232,7 +232,6 @@ struct nvmet_subsys {
>   
>          u64                     ver;
>          char                    serial[NVMET_SN_MAX_SIZE];
> -       bool                    subsys_discovered;
>          char                    *subsysnqn;
>          bool                    pi_support;
>   
>
> # nvme list
> Node                  SN
> Model                                    Namespace
> Usage                      Format           FW Rev
> --------------------- --------------------
> ---------------------------------------- ---------
> -------------------------- ---------------- --------
> /dev/nvme0n1          foo                  QEMU NVMe
> Ctrl                           1           1.07  GB /   1.07  GB
> 512   B +  0 B   1.0
> /dev/nvme1n1          bf854da611a264d448c2
> Linux                                    1           2.15  GB /   2.15
> GB      4 KiB +  0 B   5.13.0-r
> # echo 1 > /sys/kernel/config/nvmet/subsystems/nqn/
> allowed_hosts/       attr_cntlid_min      attr_serial          passthru/
> attr_allow_any_host  attr_model           attr_version
> attr_cntlid_max      attr_pi_enable       namespaces/
>   # echo "1234567890" > /sys/kernel/config/nvmet/subsystems/nqn/attr_serial
> bash: echo: write error: Invalid argument
> # dmesg  -c
> [311081.155148] nvmet: Can't set serial number. bf854da611a264d448c2 is
> already assigned
>
>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
