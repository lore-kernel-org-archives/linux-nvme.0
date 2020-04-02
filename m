Return-Path: <SRS0=DaKL=5S=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30F3C43331
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Apr 2020 15:09:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AB752063A
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Apr 2020 15:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jUnSYiYr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="HG6FoZAM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AB752063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=P4kbagGpQAAPjZN4GVGgGBoriV6i9+s//QfyNaugX8o=; b=jUnSYiYrHxqvbqsTdjE9DwsoN
	dZyeFmOmxKeBzd8RCvlRwkuPcr9mzEfl6f7Vw29wPAbp/IBFCNnGd8baPSnBAO2ZjS8JDRhjT+X3i
	hTSPAnVQ70KT1SeyvkwADuVmnSlgQR667GuC91Br8msYp3ObMVXuZAWtsrXt9SJF1ciYEbk8Nb9/i
	FChDxaIUQzHkYfTG/sc4lJn3Ur9PC/aHccwIbGyn+QQ7t73OhfESltLpQz8SHtzso5Ezs8UlRYFBM
	rNndLOfA9MCPZElPKQ8k94SdYVQOieFYqChdoKzzyqB3gb8Q0YhuiZ2evQSEi4CkJLQXkaDMSnLWC
	l3dNideLg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jK1TL-0007oE-Mr; Thu, 02 Apr 2020 15:09:35 +0000
Received: from mail-eopbgr60088.outbound.protection.outlook.com ([40.107.6.88]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jK1TI-0007nQ-DM
 for linux-nvme@lists.infradead.org; Thu, 02 Apr 2020 15:09:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BjlMF/+2Gmz5vXfqkvP4Gh9/DDS0AEAOX8IYICoyYYO6IKesk64Ebt7MHWyRatD5qZjG1b/XA8b9ZyxcyxtVQrJRVZJMTWmIaIzhZ5+7gPydb/165Ka30ibBek+w0ORIfRc7fBx+S8onBbEIYhrCCSKKGwUUBZy6ZW2+piXamttgYUPFTs3HhfL4CsUuicKmRxNpCSwhlSuWTXVPtIFJkSrb9Lg5GPbXmz3FA2WGJQZGf2z8hQ5Hiro1pTKdMsUYd+7Hy1FIZsew3MB0CdqWktuU2s6Fa3mCzsHo0XRyQmtCBVLQBe5omvn3+AD0JW9moDCB7mNrlwwgZZaM0ksA/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1TH7Lj0cfEkpiZhST6k08es9BMaQFSwPpVqJYFCbW5s=;
 b=ZocuDtpAbcnll8rXwqodEb6gOL1zStszMVjR2lmp3RgstT+E/1qAFaYhUfSkaKsZU+pvC2v4goITgr4zOaRp+tEYclLbthfgRA3Ejg0XaJFjsrxcxPjw1ErzqKdOjJFX1uREWPP0GtsegtzZAFmhI4KBsWRG8bnJEEqv6K/u6XkORPwt+77fSfMsz+hCyf3NidRP587ASS9QQSe6/odNxLKBUckhKedctlz9AZFf/WqaF27VnFh9mMiLDAcWUiZ+RGUlprfniUoeATw4ez/9MlvdN1agXFKNM0iPipDvUM2GmJLORfMbqhDSMgkSWni2Ha2bE1iiT6RvQlWEyAYpYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=mellanox.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=mellanox.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1TH7Lj0cfEkpiZhST6k08es9BMaQFSwPpVqJYFCbW5s=;
 b=HG6FoZAMo/N9QPgOi3jiu9Nf/o+cdypa89dDa6KNknkjBYHF6lfQHgTdCTIVD9RFUN4E9k/NCfYb7IFHk4usmIua0VYYZnpijeeRGLQOm9aPuiI21lnic31NY3NdwL09zdiI444fmqZPoZ93Nkzstchrcg9RBRT8XmiDvifcUrw=
Received: from AM6P191CA0066.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:7f::43)
 by AM0PR05MB4147.eurprd05.prod.outlook.com (2603:10a6:208:63::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.18; Thu, 2 Apr
 2020 15:09:27 +0000
Received: from VE1EUR03FT037.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:7f:cafe::2) by AM6P191CA0066.outlook.office365.com
 (2603:10a6:209:7f::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16 via Frontend
 Transport; Thu, 2 Apr 2020 15:09:27 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; lists.infradead.org; dkim=none (message not
 signed) header.d=none;lists.infradead.org; dmarc=pass action=none
 header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 VE1EUR03FT037.mail.protection.outlook.com (10.152.19.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2856.17 via Frontend Transport; Thu, 2 Apr 2020 15:09:26 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Thu, 2 Apr 2020 18:09:25
 +0300
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Thu,
 2 Apr 2020 18:09:25 +0300
Received: from [172.27.15.144] (172.27.15.144) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0;
 Thu, 2 Apr 2020 18:08:53 +0300
Subject: Re: NULL pointer dereference in nvmet_rdma_queue_disconnect during
 bond failover
To: Alex Lyakas <alex@zadara.com>, Sagi Grimberg <sagi@grimberg.me>
References: <F7E28AA1609E4FC495B5E8D4250E7DEF@alyakaslap>
 <90599926-b7ec-8431-a7aa-c44fde08b5c4@grimberg.me>
 <ec4fb8df-98c4-fffc-7581-5245c397d16c@mellanox.com>
 <66ACE500178B47D6B39F23FE98D22363@alyakaslap>
 <b6443a7c-4be6-3dbc-0535-a8ded3261c50@mellanox.com>
 <8ab1fa5e-2d67-5128-93b5-2f32704869e4@grimberg.me>
 <28046c97-c271-dff4-5252-4b5668c7bfb7@grimberg.me>
 <B3E9005C4E4645628157970AE2A385C4@alyakaslap>
 <fbcd59ef-9c48-4e1a-4802-1cae33c5f671@grimberg.me>
 <d7caa73f-b939-41f5-793a-c9b74880f246@grimberg.me>
 <5fee46b0-0516-766a-5b1a-7114a164c9ae@grimberg.me>
 <CAOcd+r15zrG-uMuZ2M3JjOTODV9fX3qcXPW000jbp1mtc7_R-Q@mail.gmail.com>
 <5f439f61-338f-4f37-2b13-d3b743c32409@grimberg.me>
 <CAOcd+r2JSYfL66a6yLO6KDTFHo3XcNW=4mZnqAw_Wz-wQ1=ULQ@mail.gmail.com>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <c43c581a-a2b6-62fd-340a-b20c7ca25b88@mellanox.com>
Date: Thu, 2 Apr 2020 18:08:53 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAOcd+r2JSYfL66a6yLO6KDTFHo3XcNW=4mZnqAw_Wz-wQ1=ULQ@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [172.27.15.144]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251; CTRY:IL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mtlcas13.mtl.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(136003)(396003)(39860400002)(346002)(46966005)(70586007)(2906002)(5660300002)(336012)(36906005)(70206006)(82740400003)(36756003)(86362001)(110136005)(54906003)(81156014)(81166006)(107886003)(31686004)(8676002)(316002)(4326008)(30864003)(356004)(26005)(16576012)(2616005)(478600001)(16526019)(186003)(31696002)(53546011)(47076004)(8936002)(3940600001);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27876027-5737-46c3-8046-08d7d717d5fb
X-MS-TrafficTypeDiagnostic: AM0PR05MB4147:
X-Microsoft-Antispam-PRVS: <AM0PR05MB41478AA22E1D60238A11E973B6C60@AM0PR05MB4147.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:243;
X-Forefront-PRVS: 0361212EA8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yJk+c3YrAyPSOhSHcA9hUOdA5jft7NKUB+1z1TFWDYgzdlMnzU9WmglPlIy+a0asuyU0nWK3DlWKL0atDWDB0epbLndbE25eyBvDjnrRRmWeIvpG2swC45ifmYWlVPNZr/Hy0MJPw9He8BFHTUfYLvtKp9U/wYT45xrJ32PGSxJRfkrZ9vqHTuNyjhQATZiPAZt0+13N9G8Fx8J+00OolO1ASXPvs7S21bTryEi9l85Ue4SmFTtR2g+pbAf94bn3ppMEwEC8C+sfyorDOJeQmNiUwo0gxnonG7FEeORzQyHMhVmQny9woPQ3oTdnCAfJ2FmKns1xB/j7AphfaWC5jbyezHIjjBrkWovNEIozKskJ697Q4ddf5xBRxJye5vOkMwslYdWRXXUjS2AIOhIRwdeTCFdwHiYkIf4fgT+DQqkbQO/JPCiBA+JAhk2H82uNDm9GbDjITLCQtpo8kHntoMe1JRncQ+16ahZJPqX5RymfPmbqweUNwvK+A++LzQIZ+ODUTgOFPTktTJC4vBu3uK2fLrQUVmSQ4yNZpdBI5Yg=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2020 15:09:26.7431 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27876027-5737-46c3-8046-08d7d717d5fb
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b; Ip=[193.47.165.251];
 Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4147
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200402_080932_891684_6B951203 
X-CRM114-Status: GOOD (  21.69  )
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
Cc: Shlomi Nimrodi <shlomin@mellanox.com>, tomwu@mellanox.com,
 linux-nvme <linux-nvme@lists.infradead.org>,
 Israel Rukshin <israelr@mellanox.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 4/2/2020 12:13 PM, Alex Lyakas wrote:
> Hi Sagi,
>
> On Tue, Mar 31, 2020 at 3:21 AM Sagi Grimberg <sagi@grimberg.me> wrote:
>> Hey Alex,
>>
>>>>> Alex, Max? did you retest this?
>>>> Raising this from the ashes...
>>>>
>>>> Alex, did you test this patch?
>>> Raising from the ashes!
>>>
>>> In short: this patch fixes the issue!
>> Thanks for following up..
>>
>>> More details:
>>>
>>> This patch doesn't apply on kernel 5.2. Moreover, I believe this patch
>>> is incomplete, because nvmet_rdma_find_get_device() needs to be fixed
>>> to treat cm_id->context as "struct nvmet_rdma_port" and not as "struct
>>> nvmet_port".
>> Does patch [1] apply on kernel 5.2?
>>
>>> However, since we are working with kernel modules from Mellanox OFED,
>>> I tried applying this patch on OFED 4.7. I discovered that it already
>>> has almost everything this patch introduces. Like "struct
>>> nvmet_rdma_port" and the refactoring of nvmet_rdma_add_port into
>>> nvmet_rdma_enable_port, and nvmet_rdma_remove_port to
>>> nvmet_rdma_disable_port. I ended up with this patch [1].
>>>
>>> Tested bond failover, and cm_id is destroyed and re-created as expected [2]
>>>
>>> Israel, Max and other Mellanox folks: can we have this fix in OFED 4.9?
>>>
>> For MOFED issues you can follow-up with Max and Israel offline. If you
>> can test upstream or even 5.2 stable that would be beneficial as I can
>> add your Tested-by tag.
>>
> This patch did not apply to latest 5.2 (5.2.21). All of 10 hunks
> failed. I applied it manually, and also handled cm_id->context in
> nvmet_rdma_find_get_device as I mentioned earlier. I am attaching the
> patch that I tested on kernel 5.2.21 (target side). I confirm that
> this patch fixes the bond failover issue.
>
> Tested-by: Alex Lyakas <alex@zadara.com>
>
> Max, will this help to deliver this fix upstream, so that we can get
> it in MOFED 4.9?
>
> Thanks,
> Alex.

Alex,

Thanks for testing this.

Waiting for Sagi's official rebased version for doing full review.

We can take it on us to send the rebased, reviewed and validated version 
(Sagi - let me know what you prefer).

For mofed - this is not the forum to discuss Mellanox SW release (let's 
take it offline).



>
>
>> Thanks.
>>
>> [1]:
>> --
>> Author: Sagi Grimberg <sagi@grimberg.me>
>> Date:   Wed Jul 3 15:33:01 2019 -0700
>>
>>       nvmet-rdma: fix bonding failover possible NULL deref
>>
>>       RDMA_CM_EVENT_ADDR_CHANGE event occur in the case of bonding failover
>>       on normal as well as on listening cm_ids. Hence this event will
>>       immediately trigger a NULL dereference trying to disconnect a queue
>>       for a cm_id that actually belongs to the port.
>>
>>       To fix this we provide a different handler for the listener cm_ids
>>       that will defer a work to disable+(re)enable the port which essentially
>>       destroys and setups another listener cm_id
>>
>>       Reported-by: Alex Lyakas <alex@zadara.com>
>>       Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>>
>> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
>> index 9e1b8c61f54e..8dac89b7aa12 100644
>> --- a/drivers/nvme/target/rdma.c
>> +++ b/drivers/nvme/target/rdma.c
>> @@ -105,6 +105,13 @@ struct nvmet_rdma_queue {
>>           struct list_head        queue_list;
>>    };
>>
>> +struct nvmet_rdma_port {
>> +       struct nvmet_port       *nport;
>> +       struct sockaddr_storage addr;
>> +       struct rdma_cm_id       *cm_id;
>> +       struct delayed_work     repair_work;
>> +};
>> +
>>    struct nvmet_rdma_device {
>>           struct ib_device        *device;
>>           struct ib_pd            *pd;
>> @@ -1272,6 +1279,7 @@ static int nvmet_rdma_cm_accept(struct rdma_cm_id
>> *cm_id,
>>    static int nvmet_rdma_queue_connect(struct rdma_cm_id *cm_id,
>>                   struct rdma_cm_event *event)
>>    {
>> +       struct nvmet_rdma_port *port = cm_id->context;
>>           struct nvmet_rdma_device *ndev;
>>           struct nvmet_rdma_queue *queue;
>>           int ret = -EINVAL;
>> @@ -1287,7 +1295,7 @@ static int nvmet_rdma_queue_connect(struct
>> rdma_cm_id *cm_id,
>>                   ret = -ENOMEM;
>>                   goto put_device;
>>           }
>> -       queue->port = cm_id->context;
>> +       queue->port = port->nport;
>>
>>           if (queue->host_qid == 0) {
>>                   /* Let inflight controller teardown complete */
>> @@ -1412,7 +1420,7 @@ static void nvmet_rdma_queue_connect_fail(struct
>> rdma_cm_id *cm_id,
>>    static int nvmet_rdma_device_removal(struct rdma_cm_id *cm_id,
>>                   struct nvmet_rdma_queue *queue)
>>    {
>> -       struct nvmet_port *port;
>> +       struct nvmet_rdma_port *port;
>>
>>           if (queue) {
>>                   /*
>> @@ -1431,7 +1439,7 @@ static int nvmet_rdma_device_removal(struct
>> rdma_cm_id *cm_id,
>>            * cm_id destroy. use atomic xchg to make sure
>>            * we don't compete with remove_port.
>>            */
>> -       if (xchg(&port->priv, NULL) != cm_id)
>> +       if (xchg(&port->cm_id, NULL) != cm_id)
>>                   return 0;
>>
>>           /*
>> @@ -1462,6 +1470,13 @@ static int nvmet_rdma_cm_handler(struct
>> rdma_cm_id *cm_id,
>>                   nvmet_rdma_queue_established(queue);
>>                   break;
>>           case RDMA_CM_EVENT_ADDR_CHANGE:
>> +               if (!queue) {
>> +                       struct nvmet_rdma_port *port = cm_id->context;
>> +
>> +                       schedule_delayed_work(&port->repair_work, 0);
>> +                       break;
>> +               }
>> +               /* FALLTHROUGH */
>>           case RDMA_CM_EVENT_DISCONNECTED:
>>           case RDMA_CM_EVENT_TIMEWAIT_EXIT:
>>                   nvmet_rdma_queue_disconnect(queue);
>> @@ -1504,42 +1519,19 @@ static void nvmet_rdma_delete_ctrl(struct
>> nvmet_ctrl *ctrl)
>>           mutex_unlock(&nvmet_rdma_queue_mutex);
>>    }
>>
>> -static int nvmet_rdma_add_port(struct nvmet_port *port)
>> +static void nvmet_rdma_disable_port(struct nvmet_rdma_port *port)
>>    {
>> -       struct rdma_cm_id *cm_id;
>> -       struct sockaddr_storage addr = { };
>> -       __kernel_sa_family_t af;
>> -       int ret;
>> +       struct rdma_cm_id *cm_id = xchg(&port->cm_id, NULL);
>>
>> -       switch (port->disc_addr.adrfam) {
>> -       case NVMF_ADDR_FAMILY_IP4:
>> -               af = AF_INET;
>> -               break;
>> -       case NVMF_ADDR_FAMILY_IP6:
>> -               af = AF_INET6;
>> -               break;
>> -       default:
>> -               pr_err("address family %d not supported\n",
>> -                               port->disc_addr.adrfam);
>> -               return -EINVAL;
>> -       }
>> -
>> -       if (port->inline_data_size < 0) {
>> -               port->inline_data_size =
>> NVMET_RDMA_DEFAULT_INLINE_DATA_SIZE;
>> -       } else if (port->inline_data_size >
>> NVMET_RDMA_MAX_INLINE_DATA_SIZE) {
>> -               pr_warn("inline_data_size %u is too large, reducing to
>> %u\n",
>> -                       port->inline_data_size,
>> -                       NVMET_RDMA_MAX_INLINE_DATA_SIZE);
>> -               port->inline_data_size = NVMET_RDMA_MAX_INLINE_DATA_SIZE;
>> -       }
>> +       if (cm_id)
>> +               rdma_destroy_id(cm_id);
>> +}
>>
>> -       ret = inet_pton_with_scope(&init_net, af, port->disc_addr.traddr,
>> -                       port->disc_addr.trsvcid, &addr);
>> -       if (ret) {
>> -               pr_err("malformed ip/port passed: %s:%s\n",
>> -                       port->disc_addr.traddr, port->disc_addr.trsvcid);
>> -               return ret;
>> -       }
>> +static int nvmet_rdma_enable_port(struct nvmet_rdma_port *port)
>> +{
>> +       struct sockaddr *addr = (struct sockaddr *)&port->addr;
>> +       struct rdma_cm_id *cm_id;
>> +       int ret;
>>
>>           cm_id = rdma_create_id(&init_net, nvmet_rdma_cm_handler, port,
>>                           RDMA_PS_TCP, IB_QPT_RC);
>> @@ -1558,23 +1550,19 @@ static int nvmet_rdma_add_port(struct nvmet_port
>> *port)
>>                   goto out_destroy_id;
>>           }
>>
>> -       ret = rdma_bind_addr(cm_id, (struct sockaddr *)&addr);
>> +       ret = rdma_bind_addr(cm_id, addr);
>>           if (ret) {
>> -               pr_err("binding CM ID to %pISpcs failed (%d)\n",
>> -                       (struct sockaddr *)&addr, ret);
>> +               pr_err("binding CM ID to %pISpcs failed (%d)\n", addr, ret);
>>                   goto out_destroy_id;
>>           }
>>
>>           ret = rdma_listen(cm_id, 128);
>>           if (ret) {
>> -               pr_err("listening to %pISpcs failed (%d)\n",
>> -                       (struct sockaddr *)&addr, ret);
>> +               pr_err("listening to %pISpcs failed (%d)\n", addr, ret);
>>                   goto out_destroy_id;
>>           }
>>
>> -       pr_info("enabling port %d (%pISpcs)\n",
>> -               le16_to_cpu(port->disc_addr.portid), (struct sockaddr
>> *)&addr);
>> -       port->priv = cm_id;
>> +       port->cm_id = cm_id;
>>           return 0;
>>
>>    out_destroy_id:
>> @@ -1582,18 +1570,92 @@ static int nvmet_rdma_add_port(struct nvmet_port
>> *port)
>>           return ret;
>>    }
>>
>> -static void nvmet_rdma_remove_port(struct nvmet_port *port)
>> +static void nvmet_rdma_repair_port_work(struct work_struct *w)
>>    {
>> -       struct rdma_cm_id *cm_id = xchg(&port->priv, NULL);
>> +       struct nvmet_rdma_port *port = container_of(to_delayed_work(w),
>> +                       struct nvmet_rdma_port, repair_work);
>> +       int ret;
>>
>> -       if (cm_id)
>> -               rdma_destroy_id(cm_id);
>> +       nvmet_rdma_disable_port(port);
>> +       ret = nvmet_rdma_enable_port(port);
>> +       if (ret)
>> +               schedule_delayed_work(&port->repair_work, 5 * HZ);
>> +}
>> +
>> +static int nvmet_rdma_add_port(struct nvmet_port *nport)
>> +{
>> +       struct nvmet_rdma_port *port;
>> +       __kernel_sa_family_t af;
>> +       int ret;
>> +
>> +       port = kzalloc(sizeof(*port), GFP_KERNEL);
>> +       if (!port)
>> +               return -ENOMEM;
>> +
>> +       nport->priv = port;
>> +       port->nport = nport;
>> +       INIT_DELAYED_WORK(&port->repair_work, nvmet_rdma_repair_port_work);
>> +
>> +       switch (nport->disc_addr.adrfam) {
>> +       case NVMF_ADDR_FAMILY_IP4:
>> +               af = AF_INET;
>> +               break;
>> +       case NVMF_ADDR_FAMILY_IP6:
>> +               af = AF_INET6;
>> +               break;
>> +       default:
>> +               pr_err("address family %d not supported\n",
>> +                               nport->disc_addr.adrfam);
>> +               ret = -EINVAL;
>> +               goto out_free_port;
>> +       }
>> +
>> +       if (nport->inline_data_size < 0) {
>> +               nport->inline_data_size =
>> NVMET_RDMA_DEFAULT_INLINE_DATA_SIZE;
>> +       } else if (nport->inline_data_size >
>> NVMET_RDMA_MAX_INLINE_DATA_SIZE) {
>> +               pr_warn("inline_data_size %u is too large, reducing to
>> %u\n",
>> +                       nport->inline_data_size,
>> +                       NVMET_RDMA_MAX_INLINE_DATA_SIZE);
>> +               nport->inline_data_size = NVMET_RDMA_MAX_INLINE_DATA_SIZE;
>> +       }
>> +
>> +       ret = inet_pton_with_scope(&init_net, af, nport->disc_addr.traddr,
>> +                       nport->disc_addr.trsvcid, &port->addr);
>> +       if (ret) {
>> +               pr_err("malformed ip/port passed: %s:%s\n",
>> +                       nport->disc_addr.traddr, nport->disc_addr.trsvcid);
>> +               goto out_free_port;
>> +       }
>> +
>> +       ret = nvmet_rdma_enable_port(port);
>> +       if(ret)
>> +               goto out_free_port;
>> +
>> +       pr_info("enabling port %d (%pISpcs)\n",
>> +               le16_to_cpu(nport->disc_addr.portid),
>> +               (struct sockaddr *)&port->addr);
>> +
>> +       return 0;
>> +
>> +out_free_port:
>> +       kfree(port);
>> +       return ret;
>> +}
>> +
>> +static void nvmet_rdma_remove_port(struct nvmet_port *nport)
>> +{
>> +       struct nvmet_rdma_port *port = nport->priv;
>> +
>> +       cancel_delayed_work_sync(&port->repair_work);
>> +       nvmet_rdma_disable_port(port);
>> +       kfree(port);
>>    }
>>
>>    static void nvmet_rdma_disc_port_addr(struct nvmet_req *req,
>> -               struct nvmet_port *port, char *traddr)
>> +               struct nvmet_port *nport, char *traddr)
>>    {
>> -       struct rdma_cm_id *cm_id = port->priv;
>> +       struct nvmet_rdma_port *port = nport->priv;
>> +       struct rdma_cm_id *cm_id = port->cm_id;
>>
>>           if (inet_addr_is_any((struct sockaddr
>> *)&cm_id->route.addr.src_addr)) {
>>                   struct nvmet_rdma_rsp *rsp =
>> @@ -1603,7 +1665,7 @@ static void nvmet_rdma_disc_port_addr(struct
>> nvmet_req *req,
>>
>>                   sprintf(traddr, "%pISc", addr);
>>           } else {
>> -               memcpy(traddr, port->disc_addr.traddr, NVMF_TRADDR_SIZE);
>> +               memcpy(traddr, nport->disc_addr.traddr, NVMF_TRADDR_SIZE);
>>           }
>>    }
>> --

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
