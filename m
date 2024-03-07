Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEFF2C48BF6
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 15:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e9wG5H5aY5zB+vyh+IA0b/wmbpSbkGXDx48TrfQ8At0=; b=uPtPZocu8XSyw6/oQbWeO2+BYp
	oUWl+zObPl767nPkd7954a/H/jHm+xwQ5GdeNTBivXVWUBglzdcUyONeXgS7aTuPyvTKGVQnLAfuM
	CscEKiBTDgkqayaa0XyyhF8QzEMNeC/2lbhnOGizGavSNf6ovljL8f6rWFdayEgVsqqCDbm0LqU1e
	9J5ISbeuusPYovp7LD3IXd6mD/LMwHSqCE5Vm876vN5aYnns8F+vak2QAZSgwy7RzAUWLC7HpKAFb
	r1g5x+RF99vgebfLTcLbO+ffCJgUDWUpNv6TUqQ6tpakHK2t9sOlG1MCgu3kWfGAjZ7yW77YWKUKF
	8iU35gog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riFuD-00000005Kpc-0V4d;
	Thu, 07 Mar 2024 15:43:37 +0000
Received: from mail-bn8nam12on20601.outbound.protection.outlook.com ([2a01:111:f403:2418::601] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riFu9-00000005KoA-32gZ
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 15:43:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ELu8mdUEYaAszBfeX09bg+SERcec2AyDlvZSo0s6OmmOphu2++6+39+vhlJpMg1svhljYZR4NBPax0/OV62/XZSuNv/d0wPxFlu9HNE2SP6kT0OJqN/9UWVD5P9qbRWVBKI8FhplM14WF3/XWB8SznpZeweBBnUaa6RXFYKv/+2zJVe47NTtAJBZZOp6XZwuU8DoWIwYjLm81lG3AUD0pDqazE3yl4dcJEQ3VGtQ8XWg2TaAIm2Xti+soBex60aVMvNMFj+zG4GQa7s6FSB0KaiiDw7ihDGPRJbEhLaSqyoK37AXjK1DPbSBYk5CMD8qTbCUg+Zd0CwinTfOhcFVtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e9wG5H5aY5zB+vyh+IA0b/wmbpSbkGXDx48TrfQ8At0=;
 b=AvKUrtdnu35ptNVXnzCyrb6brtJMxpmLYpout7I6dkH3CblFKIsxeOjTLjH2lh7Pw6KARqTTuWIzLf5xDFhXyhkFJRijOKkMdfrK3iK32kWKfNOG/0o8sh1BEcRh/Pk5LSMLU/t88oqjefl8Op7VPijgJB8mEjX4PBpltaKgUJd12UnhVDPrnczfL0txmShsSpb8KfSjhsHew44/vYH8zKKkkHVLL+3LN5oQHk1HFRaZO/NgdPiR3ITbxlpmMhxvtHN1/vfGeWMSM5uMKkmWMswbcvA3+R45Pmbn9HvzEJKCWtA8/d1Sq/uwK79wu7S+T+4HarzL3uxLV8zTJUvO+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e9wG5H5aY5zB+vyh+IA0b/wmbpSbkGXDx48TrfQ8At0=;
 b=OJer+8w5D3tEUtw7rx6YDGXNQKdP3HycTW5FDgUFzNIw5m6d/9r3cBMGpZ/zPQn8jaz+U2rpBU367oYcVNsH/aJiaHE9tbXfPhnD7pql8tuaC1q7z3egWeRNQcdW9KkHaeeILZNUyXtLRc2KiBaiNChhcrAIWQOdIBjNfMYaiGAFVB4jv8smHyzfMl39rfEqEwreDku1vZ/LxXRFeFsNjbAocueCTP7fS/Fqev+h/N8dIsKIU6VXUToAPizli8cFpHwItUNMbIaM2ij3XrDjApZNsAiBTxSrkk2CAlcZtUa9+X6FUQFOQD6fCQUPs/i4Fnl0HIbAMetFlgo4r/swbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by SJ0PR12MB5633.namprd12.prod.outlook.com (2603:10b6:a03:428::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 15:43:27 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463%3]) with mapi id 15.20.7362.019; Thu, 7 Mar 2024
 15:43:27 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com,
 brauner@kernel.org
Subject: Re: [PATCH v23 05/20] nvme-tcp: Add DDP offload control path
In-Reply-To: <7a2c3491-bd2a-4104-8371-f5b98bbd7355@grimberg.me>
References: <20240228125733.299384-1-aaptel@nvidia.com>
 <20240228125733.299384-6-aaptel@nvidia.com>
 <7a2c3491-bd2a-4104-8371-f5b98bbd7355@grimberg.me>
Date: Thu, 07 Mar 2024 17:43:24 +0200
Message-ID: <253plw6ujxf.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0082.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::21) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|SJ0PR12MB5633:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b0f1f39-0847-4a95-9d25-08dc3ebd54c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l1y0R4Ry+Kaw1D2C1PF50m+WpFja7SIJWP9mwBn3abiqKQ/dWVxqYS8BtlHaHJzhz2+gJ3Mx4FBok/J9OrvEk6bmatHO+Hft3X+wDtvnIyAEQRLfB+ftsOn+xdr4q9XE8WragC/Ar4RESsNZa8HoHL7m6t27Ux4/lsDHtoh8DyT8MqB1aujFzVp2odEM7L0JNk4qE80fCbmjwQWHQrBq1aJ03XU6ndYtdNKpryajqJPBJ8Hsk/oHRUoMaYdO1j0iEVFuQgnqEZHHdMc+AJR83vgR+rdcoN/69ACi2PMY2sCf+6iCm1J+3EfRqwvQ22wHXyCFujuJsQsyfqHK9jnHCIRgm8XtAyn4alNQiXRsh3I0RT2dhEzYf3vYu9Gj4YANzlStwFr4SwD8C1W4xjfKnHvPiFpSBsH57sJdIL3DKi10lpOFlLynf5+jkhQv6yBRB6OQLvcTKnWTtM30mlH7jkLhls/Sty2dChvf7vr93wMoyUuRhZi42ZZQuCODSOWDpkgPRPRad5RDlQpEK3A/C9obMENpu6nAEt/YxVgd4MusDOop9qoj7SSEDRJPfwOvoMJ/1NOgCMRdBhD4caWXLj6A3CyJwj/MpNWuEMwsVlfjK2xT+XGn0mcyKMGLW2Nswuo6q6xaumTYwjL1MGAXhUsqKWQoQe3DHJVvv3SPWHo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eOwonKqtbEeuh3/sBcE8M0m95San2rsKbs8CRwY0TEDDda8U4o82grH6fNS/?=
 =?us-ascii?Q?hgRjpbvq/EdENZNSwrBbfDPGys7COh/W8TBJbV/dvXCc8m83QB4KVhc1BoXZ?=
 =?us-ascii?Q?c7L6RkfFSIUsUOZaG6JjqV6PKl6rSt5twfGwp2+tiObqIgimroT15dpRbTBk?=
 =?us-ascii?Q?BTLSdX6IlgORhA98tOfFJCTNmWDEG2m6LCTRYPNz5oROedP+5bVO7LdIDI2L?=
 =?us-ascii?Q?sCNaTHFErj2fGbi3uDSAWXHG3GFf7v4bVueU+TmbQupcSgc0hXDmvteEWqLa?=
 =?us-ascii?Q?RUroAux6csw7dY9sV/uI+ppRGzbT5MTwE/q9uGmuznPmL1z1pkwkUs96e1d3?=
 =?us-ascii?Q?3zoHKX0mG7ihwwab5prtlu8jnuwNsl363Ndc6028StqCFj6X9RUkhWfkZnru?=
 =?us-ascii?Q?2zmDExkmhbB3R6njZqHK2dR0D4OO6MGLqQaKt7Q16WKX43wQdjCbWMwtpj7c?=
 =?us-ascii?Q?VefCaVoTlrrKDBT8xbZDI8DezXaBpFMSlLP483FSfoysdJ4hb4F01NLUKDjs?=
 =?us-ascii?Q?AWTkBX38Pc5VqiG7ULtSbkfl8vu324V2ZyntDWDOSGmX4cFea296z2tDskCp?=
 =?us-ascii?Q?PeAI9iRBFla0ai95FiubBlg+T46OAehmTQiuexkiLqHOCo32pUeKxj0tYifn?=
 =?us-ascii?Q?s1iCVwyMSWtZY3hhka2o3OUWO0sTtUHcD0dT73LO5jnybQUSSMNCbGm79eFf?=
 =?us-ascii?Q?eo4d4ViJUmAm2/xYT3+FB6yyrSUISUVsGgUU0BXjVLohokLkIKHdtlh27GqN?=
 =?us-ascii?Q?a/hcdqrjquB5nhMxgSQ7H5N1vOirU/Xbo/3brlVenaDRYiJDzRhyNyUi+Zi1?=
 =?us-ascii?Q?5qpxGPF3n8JP8HqEOlChbpk0lj3TKRAYo6G64YTpecTOyZ8+SRo7H2HozW0g?=
 =?us-ascii?Q?7S21scLn2zlEquc5la1GBe93FqhdEIs9BhEDgc+SaHeOKJgxoPl4gFl4NU/s?=
 =?us-ascii?Q?ri5eP76xBJR2QmvDqYpjijVRiC5laUuZwlBsn6S1kpRWpKO4CtOVlWAxUIQu?=
 =?us-ascii?Q?5koOgIbthJgY91QJWrLhxwSEi9gegz0+gBmP1ewn3CNETYKI+Fon3cM8pfcm?=
 =?us-ascii?Q?szoLpjKu+Rpsmj9k58L0v4VhHiiNrouqcBC8WhQ/+jVxUisFOfIOA+MHXLYT?=
 =?us-ascii?Q?40VrRrXjwHQhjDmMAOYPbZIaK+PAhshaGnkSFjwM2l+ySmS5DhOGOz7f8Tk4?=
 =?us-ascii?Q?XjxmjaX4QqgjiAMkOZ3n0Tlq+ZeRwP9aj6o8nw2E3HY6CwQ/1kEMYdOKoFix?=
 =?us-ascii?Q?7rQNwBJqE1yzrq7IEuBLMDCx8lke2hXnpfqwa7iXEblRq+xbDVJDfTxoVsaY?=
 =?us-ascii?Q?UMjgmVKzWiY7R4gpNOVLf8zlw/8RJDa0HHg+FTUQ35iEhuLvetfPPfUyXzZy?=
 =?us-ascii?Q?ljFWlc8K2lE7Jh1g1j+/y15ZH+4vaeg56UVCAV8KgBtQC8HVP6MPdywQFtqm?=
 =?us-ascii?Q?FLdOxXeBsoswWi/oQxfzvjYvT/J22/wLVmGFnfged+C/d8tUGTGsKyOhZgRn?=
 =?us-ascii?Q?dGigd/dNLfyTB1+0TFnR2tjZbZu5Oif2Trdt5sXuty8RwB73bljqpY+Am3Pm?=
 =?us-ascii?Q?CuynJo0R98OCGIaKarKSsWL+srVR0lC6Tk01uRWY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b0f1f39-0847-4a95-9d25-08dc3ebd54c5
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 15:43:27.3859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kJ1XOczXMpZ16PncRoiujtxAIfsHzAHr2Rv+/mLPIGpxp2MJoT5DYbtWIE8gUA0jMHjGjcAVX6W4t32Q2Z/4qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5633
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_074333_999835_D4023947 
X-CRM114-Status: UNSURE (   8.99  )
X-CRM114-Notice: Please train this message.
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
>> +
>> +static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
>> +{
>> +     struct ulp_ddp_config config = {.type = ULP_DDP_NVME};
>> +     int ret;
>> +
>> +     config.nvmeotcp.pfv = NVME_TCP_PFV_1_0;
>> +     config.nvmeotcp.cpda = 0;
>> +     config.nvmeotcp.dgst =
>> +             queue->hdr_digest ? NVME_TCP_HDR_DIGEST_ENABLE : 0;
>> +     config.nvmeotcp.dgst |=
>> +             queue->data_digest ? NVME_TCP_DATA_DIGEST_ENABLE : 0;
>> +     config.nvmeotcp.queue_size = queue->ctrl->ctrl.sqsize + 1;
>> +     config.nvmeotcp.queue_id = nvme_tcp_queue_id(queue);
>
> I forget, why is the queue_id needed? it does not travel the wire outside
> of the connect cmd.

You're right it is not needed, we will remove it.

>> +static void nvme_tcp_ddp_apply_limits(struct nvme_tcp_ctrl *ctrl)
>> +{
>> +     ctrl->ctrl.max_segments = ctrl->ddp_limits.max_ddp_sgl_len;
>> +     ctrl->ctrl.max_hw_sectors =
>> +             ctrl->ddp_limits.max_ddp_sgl_len << (ilog2(SZ_4K) - SECTOR_SHIFT);
>
> I think you can use NVME_CTRL_PAGE_SHIFT instead of ilog2(SZ_4K)?

Yes both seems to be 12. We will use NVME_CTRL_PAGE_SHIFT.

Thanks

