Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B34CC48BF6
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 15:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G8U+9+uG8IRu6UlaPIFOtvge584G9DvXxh4DYdQBW0o=; b=4iSfi1YlUdZTusoj/l4bM+L7HC
	NI68zaQ8oWveBorvh/ITtS7cBh1WgCsr794OcZPGji8JBJEipmzIAzrbGLduJ4c4rk5apM4dwccU2
	9Yd+KOfIhOfgnqAAcObmmg7xP+ezRxp2DDSUPY9RJbK7wZARemYFxE/Hktl4smLtkU19ANiuh3nPU
	KshrjTwvbc1+WIJE+zjRzii2kqRZbXyyJjCfXromolQR8S/hENYFrblD0Qo2u/6szzQOSOLNx661q
	zx+IU29l6Vo2gsm+PsfNYaE+kW5hiBGFUVMq9TLzw1b59MECeJ7waUcpuSYOlmhantd64o8knA5Ck
	tmCi1ODw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riFv1-00000005KwI-36cn;
	Thu, 07 Mar 2024 15:44:27 +0000
Received: from mail-bn8nam12on20601.outbound.protection.outlook.com ([2a01:111:f403:2418::601] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riFuy-00000005Kva-2rJZ
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 15:44:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NSFtaSr/TU+8WVrB8vAdFFbsffufis992Z5LGClp5ISRcoAmNzY+PwQ5l4Ec93r/1u/VzyZvRg7/nyKrvbfVvNBN0CFmMF5cJM62K8TDZ0oduM0OT6dzM1cczx8lhNvBM8Vhu0jMU4f+G0dAglOC16hnj0sVsypufXpOTCYh81/LUxnih4j3TQ21E+HARry9tNdVT3Hwrnk/8WKcDkdnecas5RxMW/ddE6ArOSwvUf0q/cwl2NQ5YvqL1frFjVSh+WYDixjw44f2pIo2YWhzToWc44qJ/HRRB56zovZYOZsIc38+BO6WrdoZnq2DQEp8MKoeZzeT3PdmfAg0IiyEzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8U+9+uG8IRu6UlaPIFOtvge584G9DvXxh4DYdQBW0o=;
 b=M5FH5FdeOdmka4by7MBqn92xwiqvCB9u3ielOaKq8mFAR6QcX6TqgjbmcfZhughaCcOMxcds9/fO8iTi5/J78uN70jD3OtlyyBUG/oW+sODP/8nnX52YCzAo/IO9pPc1d/XRThXWLadTFq4hshl5A4zVHFjdiM6jp2vCJAtuzSm0w9X+RkcWjWGclFgjzkHchh5TxAlKfs2SIX6D3tWWMPHmOzuYF392C3q4AcGjHzNjjjRbx4/TRE4aL7yo/ocDH1hRV5fhJJTxQ2Btc7RBiTQaA4jRkbECDeaNIQL+7nmV0HyGEjeYvgjy6ZBSNbOyn9PSJ5ngYSw7v9bTNpW8KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8U+9+uG8IRu6UlaPIFOtvge584G9DvXxh4DYdQBW0o=;
 b=TIxnsdMxSPODkAB2Ec4nj+OpG3lXOTfD2mRNfbKZtkUCC5GzQA5PcI9OB0L+nGgUn3ODVS8zGUs7Q3nwDMLM/JnSStrSt+baztb69NtaaST6davJgeL4U38X99n+jQpQKdlu1CtwzStJWpCxClKcJWSbPy1gGbhc5018CL/1+Kw8q7cRWQDsUmvZXrDF8IImm+o80XDxA7nEUMCuIVw1eoOK7IExoFrEXh2Kv3HEoqEOSMWAGaR5al+/6iPGB79ub6hu04NvxeLt9yQj6XcAxZUaXDZPQGRwOBuGxOEMT6DVzHeeCXP8NCqVgiUDcbMILk0l/CVn99ieUmG03mWjvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by SJ0PR12MB5633.namprd12.prod.outlook.com (2603:10b6:a03:428::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 15:44:17 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463%3]) with mapi id 15.20.7362.019; Thu, 7 Mar 2024
 15:44:17 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com
Subject: Re: [PATCH v23 06/20] nvme-tcp: Add DDP data-path
In-Reply-To: <40a01a90-b91f-4526-a404-462de3ffa38a@grimberg.me>
References: <20240228125733.299384-1-aaptel@nvidia.com>
 <20240228125733.299384-7-aaptel@nvidia.com>
 <40a01a90-b91f-4526-a404-462de3ffa38a@grimberg.me>
Date: Thu, 07 Mar 2024 17:44:13 +0200
Message-ID: <253msraujw2.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0104.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::15) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|SJ0PR12MB5633:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eb25080-d9e0-4631-4cd2-08dc3ebd7232
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DGXixbakc63uTaM8Kvk39WJIixOZZ7TiypNjiIF8VkcE/N5mrb3Gjk7hPynN8Aq7qu0Y/zNQtpMJB7QSDeVP3RBtu4xyjuzae7CA816Fpqu9o9+YbSzlRUlu+U7IvzuMFeW2hVMpTYiQg+3vc952kLzVAggFk7ZoHp989tzcZ8BAT6AGGyTMh2eeCAKs+gZqVGxkbSj5S8cQOMLOTUIhYqufRJAmLoUvbiEhbWlnhaW2j3rMRbvGEHcEzAngdYjerZj7UMImnXRdQNN2CZU+5Ssbg4x5jTFa/oKuKUyDU5kMdLw7ufbISFyBj4tbL9mjoaPOvHTIuZk1v7LOO7Tbg9cDUvvojDRfJOMuogI2a9mr92lPsPEcD/SiyxOJQCu2bq6zffB/M3s/ab7pYvgw4EyVe9EkkHuSZj+NiDxoqfl2TV1uO5c8m67rHQYyVGFLLheRlvwiUzc6Gi3CFJrfCymOvgejhiLQASyFPBCCyueFMRa8PCbtik9/C4/yunYbf0t2hYoAl1wcnr2S0DPeeVCOTvYirH8ZoTa99/U65TdTibEvqEMOLwp5t6pjGwLj4lVThG/3J9aNfMNT0l7Sk4GvDyjSr+oq1uG1tlxcqpq5tj+IfnBnDFBKfP9PKLbdCHPkdPZZSdIu+T6iCn8TjmBh6BzKSqOZSzXdHDvhuAI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Flwv67uL6QrcHirLVnkv9c3oCL6J37kb++TvC9ozr4yGTPwIgPv0fE5b4XwL?=
 =?us-ascii?Q?By/VzwZpIO4Gbz4yg92hne2cY8X2014OemvG6WiD5BEr8k2sQ9tWjhBTHN+a?=
 =?us-ascii?Q?5L+GYWZ7Lh4EXfXgL/YNlf4J4T9Y3iUFDvhIbpGf8zkm1uzKQ8WPeZPlmtdb?=
 =?us-ascii?Q?qdcE6wmgKnITM5dNWawr2ScnfO6PqJTK2TKPUopvo+N6CLWJIdANSkkyfWDC?=
 =?us-ascii?Q?XyZ6ZKN0icqrQsi0s9+5lZqneR2b53BS+85W6yUBe82BG7Zx79qOzspXXtr2?=
 =?us-ascii?Q?Fmz4LY1IVZpzNCgbRe6B0byBJqeZJFPTGEK81u1jbK9hwcxqDLt9dTaZIG1v?=
 =?us-ascii?Q?wJoL4e2a7EkSToiWn77fudGNdZWUckWHfPMjCRP6N+SbHMRVk5xmQQAzjkdD?=
 =?us-ascii?Q?wM5toruXEfqzYdjF3gH/LMidnBTUsZ1Lx+TQRZ/uOQOVjZyOjR033fS44ctf?=
 =?us-ascii?Q?lr1OlgZItiePGTReTcZqBnpK5VSEzGno82mSr/D5zUkS0jM58puzEgcjwFeX?=
 =?us-ascii?Q?SUPEzmOdFZPhkXTXBTVjDLKLXTK1RW/H98x1j6KLUky43vLNa0LYhnGU/VXs?=
 =?us-ascii?Q?TJuO2mKappmffe6pBC7dSty/YxP1GrQuWjeeeoz+5YR4ZTLWUEv1FaVn8ggJ?=
 =?us-ascii?Q?OjTI4czrZkrV4dKktSpl/H7x0/tlPaHPzGGiaas9/IiLtGsPHz7q0Y6FldqO?=
 =?us-ascii?Q?3MCP7vBKQZ793A2qRaYMvyIbOR0RfwegLMWaYJrXi2i3o67SIYkfwuhYnIOy?=
 =?us-ascii?Q?CIe1Mu7OIsQzvbgPp/jDoTytmQo4TWJCe/s9p+f+xxFfz9VJa3DHM8OsE8JJ?=
 =?us-ascii?Q?fnSIwYksiBDXufKcTP4DO//A8t+qpcMwdPUBUtH4QIcNWU8opooq2c8Pfddc?=
 =?us-ascii?Q?nx0HZVYYLC5KWKg0VckMdBDOiReAbpjlc54kjANx80IN5SQxbXC65gM9EZAr?=
 =?us-ascii?Q?ZanOIRmwDgTJbQUq+tJv3JzjDIITrg3W5rlOxmzbvWG9nlrhIBukasb4cWeo?=
 =?us-ascii?Q?LMA/h5LIaNCGPgFOeD3lQPTwzZFBZwIa5+FKI/Et/HcYmFIz6FKObo5EPdGy?=
 =?us-ascii?Q?6UxpVy5LsD2XG0/G/GeZBrAHP3fpxYHDOvS684s2/6nPMUMVgiZ+BLbx30vv?=
 =?us-ascii?Q?hjFBG145MawVBS3xgSXehIQUR/u3ZCh+Pf5b2790IIc2sAGDNBDd+sQVAsjW?=
 =?us-ascii?Q?QZ3KDaaDxPYNsL75W1MgJw5MOP1WXw6V72yLYVb23S5nrN7q7i85z2Mg9ObU?=
 =?us-ascii?Q?adk62P7i3oi2yFF9io23BPvXzYBPNAT6Aenmi3hp2de4SKhocVBJjZG+VZlJ?=
 =?us-ascii?Q?mnxY/h1HrGtPJofJit49pbnlRn6lcFww4nEP7GMd0KrQiq6laNbNrhWn4GXz?=
 =?us-ascii?Q?TG+o7QgdleVgHe1R+UoDNXFcRrlfQhcteWsfiJLtY9vGxuYtGS1LEUEeYk0b?=
 =?us-ascii?Q?4KBaiz9W1LPv0OE5p/P0wXDafK/U/PfTGbaqyHcCsWZ+zA4GgUYE58YMBAvR?=
 =?us-ascii?Q?NYtvtVZVTLjTGAAWTTv5DGwdaCoYiwqBUWnYWFxjoesQa+cHdo/cdLYMxM64?=
 =?us-ascii?Q?5Ksk5hINozj1hjVOqWsErP3uPZ8o7ykBVQkeoyo1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eb25080-d9e0-4631-4cd2-08dc3ebd7232
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 15:44:16.8580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6gCkpK4dMLdjZY9fiuMQ2+iGtz3E8MddqnrAB8ib7lG1rh4BTPr1c6vAw4CKYqto82tz2mZXGlRKPcRZKr9Vog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5633
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_074424_745258_D1F640E7 
X-CRM114-Status: GOOD (  10.41  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Sagi Grimberg <sagi@grimberg.me> writes:
>> +static void nvme_tcp_complete_request(struct request *rq,
>> +                                   __le16 status,
>> +                                   union nvme_result result,
>> +                                   __u16 command_id)
>> +{
>> +     struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
>> +
>> +     if (nvme_tcp_is_ddp_offloaded(req)) {
>> +             req->nvme_status = status;
>
> this can just be called req->status I think.

Since req->status already exists, we have checked whether it can be
safely used instead of adding nvme_status and it seems to be ok.

We will remove nvme_status.

>> +             req->result = result;
> I think it will be cleaner to always capture req->result and req->status
> regardless of ddp offload.

Sure, we will set status and result in the function before the offload
check:

static void nvme_tcp_complete_request(struct request *rq,
                                      __le16 status,
                                      union nvme_result result,
                                      __u16 command_id)
{
        struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);

        req->status = status;
        req->result = result;

        if (nvme_tcp_is_ddp_offloaded(req)) {
                /* complete when teardown is confirmed to be done */
                nvme_tcp_teardown_ddp(req->queue, rq);
                return;
        }

        if (!nvme_try_complete_req(rq, status, result))
                nvme_complete_rq(rq);
}

