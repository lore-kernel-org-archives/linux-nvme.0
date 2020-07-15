Return-Path: <SRS0=D+H5=A2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 243AAC433E5
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jul 2020 09:06:03 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D57C220672
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jul 2020 09:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SVmWpoDm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="lykmeZV1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D57C220672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=dfH/+9NhGu2g+SjTQuhvKKr/JxHp6rrsJqvdZvMAj1Q=; b=SVmWpoDmIRZ9W2bAAgTViCSGd
	KDdf6c0fGQvBzJ6YgsND+MG28ks9V1VwC/7J58cwJXH6Nlm60yrdBRgv9t7mxvLUma5Y+OfcYqjqB
	YTUcrL0M7J8sMkYX8c+h2ZMXUjl6b6n540r65GbDBHMeV7MP/8zpP3GytGNkKIvTNh3pzkwAxGAo6
	lLet6vJTFeRuIijshk+MYKcwZfLuwBm4nlxAz69Cw/3IC7lURm7AxE2nd61sqUfPYyjcv14cijVhX
	HoRvam+i0MDhQv1xaWm6MmsGXxJY4SpTpT9VOp8UymfcoILH8bfCIp5qLRaQR1msWJJWJiKWrKvVD
	MdkDhwhcg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jvdMQ-0004de-Ax; Wed, 15 Jul 2020 09:05:54 +0000
Received: from mail-eopbgr50083.outbound.protection.outlook.com ([40.107.5.83]
 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jvdLk-0004Eg-1e
 for linux-nvme@lists.infradead.org; Wed, 15 Jul 2020 09:05:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K4tgtGAcU4V9BEBsLzkPiNNQyNqqZPlj8XBAZMC+h8a0WaiTCcZmp1BLBh+8dpUNTMWIlH8V5BttI2eZVmbc34rD0QuFZ+jQdQ2FHwJd6DLcMuqX+/Kp/jWGxCTp9/RxEy2YO+L4L7y4D+QKubByurmX1yrf89jHN2NPyYHVEvE+EiPPMS3BWOiyYo/MRmJrozsE74PvD5ZtmEK5ios8GKOynU/724srndzWiWHZ6izXHpMqxXqnKVoinB+ot2V5fIZQPhVN8Jzk9ONYndrMsQfWEyv+VYWCFu4c/uBVcHi6wKy3Il8Y5xCjVwwe5q2ojl77df+iBf8dudRGBS+xeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6IUiBt36YBg6hsiSBQVrS0nut/YX9qFBWNNvA/f0D94=;
 b=UiiYEsMH4mxhDEHg5/8mBoc1CO20Yvs4bCp+d8/r0Kb4wJywRFKG1hbubunzt0vhzORR1dLDmB9Ne4Owg6YJOccDOw6o+lECP1stOEeBXJKxd97ufVWuhZGBXvxFa4zqIzq4ppxxlqClIUWcBXODCuTA6jqPhlvfO0Q7OW61uzzvmACBwBX0FZaL3geGMCvY+uC71r0M/2Ga+V88fQzhKLN1ayLnj/0v4UxBWRDrzOLjTm47Gt1DANsovVkoxBute1WVU+j1ROMnHPmvH2U+yYUckGPUduKQgDb5qClVapbnZ8hyKWAuP0yaXN1DF3MK4lYEerjdhw+u2+XgA7mC6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6IUiBt36YBg6hsiSBQVrS0nut/YX9qFBWNNvA/f0D94=;
 b=lykmeZV1aTLP4mwR7WhfRVwpn0sLCU8VOAeM1+i0FxwAsRsFnzLxctqV0p+E8vRiWG4Bd1VPJ5iAvpmDyCSQ8kmzM2lT3k8eayDpW2V6dhyF99u4vSBnMtVKSTduodpkZM7HnvWCeSyY1i+Fp483rxDq7Eus5hIYiXA0qwLVbm4=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com (2603:10a6:208:11f::18)
 by AM0PR05MB6386.eurprd05.prod.outlook.com (2603:10a6:208:13c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Wed, 15 Jul
 2020 09:05:06 +0000
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::d05d:35af:3f2f:9110]) by AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::d05d:35af:3f2f:9110%5]) with mapi id 15.20.3174.025; Wed, 15 Jul 2020
 09:05:06 +0000
Subject: Re: [PATCH] nvme-fc: set max_segments to lldd max value
To: James Smart <jsmart2021@gmail.com>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>
References: <20200714190336.119013-1-jsmart2021@gmail.com>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <75927cec-e607-0293-47d3-f8b6141425f0@mellanox.com>
Date: Wed, 15 Jul 2020 12:04:58 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200714190336.119013-1-jsmart2021@gmail.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR04CA0003.eurprd04.prod.outlook.com
 (2603:10a6:208:122::16) To AM0PR05MB5810.eurprd05.prod.outlook.com
 (2603:10a6:208:11f::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.10] (46.116.90.232) by
 AM0PR04CA0003.eurprd04.prod.outlook.com (2603:10a6:208:122::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17 via Frontend
 Transport; Wed, 15 Jul 2020 09:05:05 +0000
X-Originating-IP: [46.116.90.232]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a39dc467-2e2c-49f7-a70d-08d8289e2aca
X-MS-TrafficTypeDiagnostic: AM0PR05MB6386:
X-Microsoft-Antispam-PRVS: <AM0PR05MB63867F5E131165693A6B5165B67E0@AM0PR05MB6386.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ke/bA/lJ8R6u1nYQasMbOUVNAqtBnuGgECO29RMZf5Jl9vtEvQhF3mFfqCdUuT9qIe2D+TdhM8IepdG5KGHZtphbjWFzcdxJxPhPqTtpc1g0iff4R4RL6djk71d3cMcHnP++K4UeSumKnn6Q7PjACJ9uwN+G9Ujodw6nZRSRHQO9PT+f/BKZ4ekFkb5aKQWQJJZ3+KiZ3Zh+xg1awrlKXeTu0ST8SPK7PBU9WM1FjJthPaWanlag9x+/nHVmuF8xdX9uU7/jMs9Xje54JZjCtYPs15jCxqF58m7WQCkBgnbZ5xP9+7jzD2ciz0+YVn3gCRj5VQJDGRF/2FWL8KPbEC1Ci5YaOXua56TsJrQ2jB8nfww3l4HbXIeaMM0WypP1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR05MB5810.eurprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(39860400002)(136003)(376002)(346002)(8676002)(66946007)(66556008)(478600001)(31686004)(66476007)(2906002)(83380400001)(31696002)(53546011)(186003)(86362001)(26005)(16526019)(52116002)(36756003)(16576012)(6486002)(8936002)(316002)(6666004)(110136005)(4326008)(2616005)(956004)(5660300002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 5d37aLyf+U//zlX0QOdBlkg20j57jXY+mxNBHz8inrMhYQQCYoTieTEGZXgtxWwawHa5/yUCh5jpdzJZcmCzsM68XyRr6tbYSRGdWNPWHsfnb1f2gOMyMZBTkSEnoXfSp9GkGPG2ibuEoXUlgu3l1FbSvSb7Isbj5b6I8ydD3xr3fkoyUjg6yAg9E4S0ONSKoYKeeXpedbw/aU/TMg41BBbP39wJRnG+Qw72vedAnIMf29OLRBvsLOe+9XJ5Il4ZcexF69JxFgHZET57+jhmDUeXscEVfuoaut1isZBngT3aIIF3rYZ2Tb3PRqAziT7cnXzW0dLGQj4oPZUVpDAQgWo3kUGj9Imy6hslb7VrUVZfp+z4TvOtyeLeEfoQL7OYDhkOOMJRn0XPmJbxz8PLiG/tS4ksNDXyf0vz0F60FXhXRGb/z+sMDf+r/HfOs4phmWa/4CtYS47Kf18SqHj/zqVDvDoKPyjnh4Emc9a2kYs=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a39dc467-2e2c-49f7-a70d-08d8289e2aca
X-MS-Exchange-CrossTenant-AuthSource: AM0PR05MB5810.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2020 09:05:06.3381 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VxvYff2xGZhLGqHC/PTSi7sHlZvfFpLp+8jl+CQgnc1tuClHJL5uH3rr1tNTCdzl7lRDbcuyVoAM1ksLTPv4ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB6386
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200715_050512_298133_FFA226D6 
X-CRM114-Status: GOOD (  20.34  )
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
Cc: "Ewan D . Milne" <emilne@redhat.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 7/14/2020 10:03 PM, James Smart wrote:
> Currently the FC transport is set max_hw_sectors based on the lldds
> max sgl segment count. However, the block queue max segments is
> set based on the controller's max_segments count, which the transport
> does not set.  As such, the lldd is receiving sgl lists that are
> exceeding its max segment count.
>
> Set the controller max segment count and derive max_hw_sectors from
> the max segment count.
>
> Signed-off-by: James Smart <jsmart2021@gmail.com>
> Reviewed-by: Ewan D. Milne <emilne@redhat.com>
> CC: Max Gurtovoy <maxg@mellanox.com>
>
> ---
> Looks like the setting of max_segments has been missing from all
> fabric transports for a while. Rdma had a fixup (ff13c1b87c97) from
> Max last fall that corrected this. But tcp and fc were still lacking.
> Copying Max to look at tcp.

The TCP stack is not limiting the IO size, I guess because of the fact 
it's a streaming protocol.

So I don't see a bug in the tcp driver but we can consider limiting the 
IO size if it will improve performance in some cases.

BTW, AFAIK the iscsi TCP acts the same.

Sagi,

do you see some benefits we can get by limiting the mdts for tcp ?


> ---
>   drivers/nvme/host/fc.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 6aa30bb5a762..e57e536546f7 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -3001,8 +3001,9 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
>   	if (ret)
>   		goto out_disconnect_admin_queue;
>   
> -	ctrl->ctrl.max_hw_sectors =
> -		(ctrl->lport->ops->max_sgl_segments - 1) << (PAGE_SHIFT - 9);
> +	ctrl->ctrl.max_segments = ctrl->lport->ops->max_sgl_segments;
> +	ctrl->ctrl.max_hw_sectors = ctrl->ctrl.max_segments <<
> +						(ilog2(SZ_4K) - 9);
>   
>   	blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
>   

Looks good,

Reviewed-by: Max Gurtovoy <maxg@mellanox.com>



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
