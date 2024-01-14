Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20CEAC4706C
	for <linux-nvme@archiver.kernel.org>; Sun, 14 Jan 2024 02:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iAoEsus8yK+L6uGtTjCT4+f/nn93APFK+PiNlFRZy2M=; b=4CUNMa8ZIvEZ6S77N4EUrOO1zE
	w2GeKx1BBm/1JiLUS92J6B2c5g8/BrhlhIR3q2s3PzagFWZ++XjuSZ+c9ZKU3Ii3uA667CZuNttDW
	tpClt3KYxCC1aXRDzYQHuGZEbyqcgrWSea2b2J//Df3mRZ8SbILWWQAEw2Yj743o+ZN5Jaooysos+
	jVNDONyUm1W4AeBDYW6ujJizqGhKgd92nz/p25xVYdm6apXWifyTRKnbkNfBN4sBsazj3WE+d9WYY
	/sXWUZW8PIPwwnsOYYJ51GdK+VXTQlTdtD/tGMdMC9wi7ctnYFzaOQUV3t76O4QU2glyVuY4KoQpZ
	lRTb1qSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rOqde-00661i-1h;
	Sun, 14 Jan 2024 02:54:18 +0000
Received: from mail-dm6nam10on2047.outbound.protection.outlook.com ([40.107.93.47] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rOqdU-006612-2G
	for linux-nvme@lists.infradead.org;
	Sun, 14 Jan 2024 02:54:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kn6NIPAksKokp/0hcb09iBiEbcZX5TkgQ8fr+yTTSYFF7KU71zHi0YSqEr/kHppwBe/xz/sUDxP2lmbSCm94cBieaZlOlFqkxZRJkQyqhhWK/qRepLg3VAveLKhhtYkUd16LPOahE/3nbaxtkMAhgxuDQDpztZhIuhaV0MKgGOPLVHZrJoQUuscDp60X7nM3ZQKFNj/u1fbp/mX9l0sTUk0jnDQPiXmVrlCwKz/1Yz1bSM+mo8iwLCIfXXqBiWSRxJY4LSXDgn2c8gpHodnzoxGC4Uabe5dfDvH/HKvQPLjku5Q/AEb835bDfZeLpF+aTbVgx/n/69mhTKmtAEtC+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iAoEsus8yK+L6uGtTjCT4+f/nn93APFK+PiNlFRZy2M=;
 b=D892tBAbIu5uXw9hGpHbJDLnkLMNyqbbTGtmmxwQEqT9YR61tlW5pEPmbL7TZApjmATgFOq0bG+rOhD1/1eQv1o/9TAsnXEBfDff4QbohkpN9zLUfnc6Cg9CRZ8wJGTd2TcNU2gbGunzIoV80lz9Hqm7KCc3StS6DkVMMS88hJvmrGtmquc5NLoz1SYNJ/XADL7b9NxusAMWfw7HR4Tu1gB4lkF2TMzC6NyaWrJES5nIDvgMENA7ARkFSxnP/65pQsw8VsPGfHyzSRSrtRe5eggQXiAOzNI1VTId6TVnV9957Nslp9U+AxqYPaMaANS9Xi/252g3AKfQrO29Da+09Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iAoEsus8yK+L6uGtTjCT4+f/nn93APFK+PiNlFRZy2M=;
 b=AvElXIbHr0+6t9GKOAo9k+ktZ1YdHN5ZLrAXA8mSiNv8Y+IhnhemZKzPfTwf3e8Vh4Y7HHUkAbsJKlAFQ06hXHrtFQePoOpq9pLo2Z0tBghEsgCWYJqL/BAQzpQgNut2emBXvJAB8cgWb3iuvsOVWnQb6MHSPr9FNuVDkMj9eKTIPH2L2a1UBty/pzWT50Ry6DSTwiCdkxPcxaIhUNFxRclTkbfQ8AtVg4IEQNCbQctoYVjkHWprCjnzxPQ7gCVvxB7Ow6G7ydCQLh/gPEVOYwPN8aVRH2oJQmZGSN80v7rJaMuj4ylzGrwHF9GgIczzAE5gF2LqsJ4ZTQAdYvlI8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Sun, 14 Jan
 2024 02:53:34 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504%4]) with mapi id 15.20.7181.020; Sun, 14 Jan 2024
 02:53:34 +0000
Message-ID: <8292c439-4ac1-4ccb-9c18-71d55fbc57e2@nvidia.com>
Date: Sun, 14 Jan 2024 04:53:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] nvme-tcp: Do not terminate i/o commands during
 RESETTING
Content-Language: en-US
To: hare@kernel.org, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
References: <20240112100907.80765-1-hare@kernel.org>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20240112100907.80765-1-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0076.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::11) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|BL1PR12MB5349:EE_
X-MS-Office365-Filtering-Correlation-Id: 79a91a80-0383-47ad-c6b8-08dc14abffb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DvUMccph62oPY9kOoHPI8njKLdjWiq0fU/eMLwwp5GjG+8xaN9GIxGMxCjobOrHXbKb+VjDbX8s0x4mL5jzdmGj3S7L0ys2cMG2HyR2QgpSelW1kmMrMxzviXEj6qFTSnTDw3+xrPpBQYfJLiumcdD4xg539sKiUE3Uz6j7m6inFI3zSU14Y5Z2U1uZI9mEiv5aasz91lkgLuaRY/Oj6010Ftap3ytDDn2OmgwYK9oAdJumbmrTtTG6Vpsed8bi937NfWE7EI8+RbvZ1/zmuJHNNtBqeOwdSWsBeI+XxmEU4kwCHGysmPLshCTksKXTF0Ru1vy1yjb0z+M2gFJAs8TxzKUQ+NUcJ/TTWWTiqZ7zEk8pqAp0iVVKbBHyc1OogVu4zX653cFlMIApd4YPSAPMUzuf8fJQNE0Mv3fLw2yVu4gIc9f/RS/azD5nKlow5KTZo5FYedRWrl/RTGPLJnZ65keJn11eWJzUs4Vq457CLIWxYzH9z4LztvdmD5oqwgRHQKAS6wvhTWf+uASm5PuWkqqqDOhs0BQIT1gd7834f4vEjWbIClJuQCF5a2N6z6KYT+dpf7onSU5A6fAruKN6ichSYV4/La9tUi3vOLEciLPiKkqwf0IeZjLk9PRiH0k25012iRyobeWl50621jw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(136003)(39860400002)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(31696002)(2616005)(26005)(83380400001)(41300700001)(38100700002)(66476007)(66556008)(66946007)(5660300002)(6916009)(2906002)(4326008)(8676002)(8936002)(54906003)(316002)(6506007)(6512007)(6666004)(478600001)(53546011)(6486002)(36756003)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0MxTnhQLzJJeDJRWkY4NjVhREpJNForREtmaGx4biszMDg4VjVRU2F6cjht?=
 =?utf-8?B?dDFCdTB4NVZ3Q0ZWOXQ3TFZkZ1RubzZRcXFHNjBIcFhWSHJBd2dvaWh1NFFi?=
 =?utf-8?B?UkxFc01xeHk3TmlpYmlranBHaEhVTnlNN3NLbHcycVJ3Y3BkNlIyRVdWQ2F1?=
 =?utf-8?B?LzFRNzdPWUV2dEZiWGc5clE2QTg4dm1VMHBlbFdyc1JOM0VOWlB4YkpWTm1q?=
 =?utf-8?B?b0gvQmVKM25QVWhwZGJ1NHhJYklXQVpSRUtwZ3ZNLy9lcE4zN1NQODV1cnVm?=
 =?utf-8?B?cHBzVHpFaWgycFBlSllSRzluSVNsOTdzTk84R0Ywc1dQc0Z5MzZSdWZVc2Yy?=
 =?utf-8?B?MHg1QVdtandCVUxXYmlmRHhySDUxa21zUXduT2RCbmhXV3BNeTFOZDkySFVD?=
 =?utf-8?B?VlNldUZDQjZpWkxKWXdTQnBydUF1UEZBVU53Z1J5K0FTWVZBNWVPY0NyYVl3?=
 =?utf-8?B?enBQSE81QTVVNzRLSG1BNHJjU0EvTWVNcGlmR1lkK0xSMkp3K3huTVR0ZXd6?=
 =?utf-8?B?cHZ4dFU2UEZwRXAzbllMZ21NSkdLR25PbTlpQkhtcDNFM3hUZXhpU0JFMmpZ?=
 =?utf-8?B?VEpJbDAyQ0p1ejZtRkoxKzZDOUhuZHdERHJVYXdZMUV0UVkremN3eUFDN3lp?=
 =?utf-8?B?dWZ2bkxuMUl1SmNMbXNmTEtBdkpmOGg5dElrUjZ0cGxOK1BpUFZHN295Yko5?=
 =?utf-8?B?UTMvUHIwWDNBR0pkNk1DQmVBRFQ5TG1WSjFtYzVZMDF2clRTQmlGL1B5d2pY?=
 =?utf-8?B?R3pTZ1hEQWJibG82VlRiOUZ0a0duRnpMSlBrbWZrQVFUUUZMS2VIOHR6UjRZ?=
 =?utf-8?B?dVJ0eVFNV3FuQmcwQVpBM0lvMDRScWFyZFJNR0dKa29Gd3dxMEp4QnpwNFp0?=
 =?utf-8?B?TDJKR0NlQ2FpZG1UNXp3QTlTUzZzYjVjTVJxaGxheWkyRzR0am93QmFHdnJX?=
 =?utf-8?B?clVwNW5ZZTdnUG9xQVVQelg0UUU0RUFMcFZUV2p6MUNkaHVmdHdacXVmNDZ0?=
 =?utf-8?B?dVIvaUhvVUdBdjdmWTJTdjB4a004TjlxYXcveGlSUmcrRGxONlZZaTAwcmtV?=
 =?utf-8?B?VjV6OGJWaElPZnFNdFNnMDFHdGxZbmxoNEVkTW9iU3lyNSs1Z29Mazk2em9p?=
 =?utf-8?B?YkJUb2p0Y1M5NDhmSTRWRjFyMlZlLzhDSU5WU0tac1pXbUZ1b2YxNE5EQk8z?=
 =?utf-8?B?dHdIRjlUVnhRdUIrMys5c3VXblVRVS9MUlV4NjdCV1dPTlNLZHVVelpaNk5Q?=
 =?utf-8?B?K3MxOHNiSm9jUEhRMHNsNDBOMkwyVmtrdXVhZHFhRkFpTXhHeW5VZmttV3Nz?=
 =?utf-8?B?eUFnWFpBU0h2aTFNTkdpSWRPMVBwd0YzYWtEdm9pdW9iR2ExWGVmZnVxUFN6?=
 =?utf-8?B?UnQ3SWgySkZTMG51bW5OaVhqZFhTbDFXbmc5R1BHcGpPYTFNMXhMcVBhTElh?=
 =?utf-8?B?STNJdkhOck00ZHdDeTJtUTg3K1FKeTlNVkxtZkdUYmhNakhXbVJGQ3Rhc1lv?=
 =?utf-8?B?emwxd2tiTk40QWIzdlRNVVJaS1pZMXJoUVovbjZWSFFuQ3FNWDJnUUMzUkpz?=
 =?utf-8?B?S2JQWjQ5M2hwMHA4ZXNQZHdxVHhmajRpd1VFR0cwYTVCODBucFFmOWE1cVdy?=
 =?utf-8?B?NHR1R09PSW1vOEkyLzhDSmwyUGlqdjh5bkpTL0VVMkNqRUJhcExpNkNlL0lZ?=
 =?utf-8?B?d1JQNTRFeGkvSlhBNHBEUnpzK1JvVElPY2VxU0ZKTEtHdjRqN29PRlNEY0Zj?=
 =?utf-8?B?Z1A2SXhPWjlHZmg4M2FIUW5OUk9KUGd0d0NUTitYOU1zMlZDaEtQTFc5VnlQ?=
 =?utf-8?B?bkQ4djVGRSt2aFFPTHV2T3krQWlCR1ZwdUpPcGZac2xPZGZFSE9WbHBUU29G?=
 =?utf-8?B?MDN3OWFWYkp0TkZJcXNXYUh3V3ErcWFoR3hoTXBEcEhSL3plbjBhUytYUXJl?=
 =?utf-8?B?RXNBMzJ6LzJWd1FaZkNrcVNTWHRpK3Z1Y0hMbmZUdmFoaW1JZ3ljbDEwaDk2?=
 =?utf-8?B?SW5vSE1rbDFqSk9VdlhCT2ZMRitPSHNEL1EvKzZGYXNlWnc0UjlaUjlSTzU2?=
 =?utf-8?B?b2xKMmFVOVh2WHpkRkhFYThodUpvUWc2QTZJaDVDYTh4RmcwSy9NdHgzYnd6?=
 =?utf-8?Q?1Em/rJZHHbkomaMNb+3/ISQZ5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79a91a80-0383-47ad-c6b8-08dc14abffb5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2024 02:53:34.3840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l48Mhrv4XnfijZAnWWirqVKiQI02xrzOmDECYapUXVgsQNjuNsygpYf7J/1QTRqwCqQ4xsdMjT753Lab25ymOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5349
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240113_185412_814093_CEA6146F 
X-CRM114-Status: GOOD (  25.83  )
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

Hi Hannes,

On 12/01/2024 12:09, hare@kernel.org wrote:
> From: Hannes Reinecke <hare@suse.de>
> 
> Terminating commands from the timeout handler might lead
> to a data corruption as the timeout might trigger before
> KATO expired.

Can you please explain the data corruption and how this patch is fixing it ?

> When several commands have been sent in a batch and
> the command timeouts trigger just after the keep-alive
> command has been sent then the first command will trigger
> the error recovery. But all other commands will timeout
> directly afterwards and will hit the timeout handler
> before the err_work workqueue handler has started.
> This results in these commands being aborted and
> immediately retried without waiting for KATO.
> So return BLK_EH_RESET_TIMER for I/O commands when
> the controller is in 'RESETTING' or 'DELETING'
> state to ensure that the commands will
> be retried only after the KATO interval.

I'm not sure I understand how does KATO and reconnect_delay are related ?

> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/host/tcp.c | 22 ++++++++++++++++------
>   1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 08805f027810..9dcb2d3b123c 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -2431,17 +2431,27 @@ static enum blk_eh_timer_return nvme_tcp_timeout(struct request *rq)
>   	struct nvme_tcp_cmd_pdu *pdu = nvme_tcp_req_cmd_pdu(req);
>   	u8 opc = pdu->cmd.common.opcode, fctype = pdu->cmd.fabrics.fctype;
>   	int qid = nvme_tcp_queue_id(req->queue);
> +	enum nvme_ctrl_state state = nvme_ctrl_state(ctrl);
>   
>   	dev_warn(ctrl->device,
> -		"queue %d: timeout cid %#x type %d opcode %#x (%s)\n",
> +		"queue %d: timeout cid %#x type %d opcode %#x (%s) state %d\n",
>   		nvme_tcp_queue_id(req->queue), nvme_cid(rq), pdu->hdr.type,
> -		opc, nvme_opcode_str(qid, opc, fctype));
> +		opc, nvme_opcode_str(qid, opc, fctype), state);
> +
> +	/*
> +	 * If the controller is in state RESETTING or DELETING all
> +	 * inflight commands will be terminated soon which in turn
> +	 * may failover to a different path.
> +	 */
> +	if ((state == NVME_CTRL_RESETTING ||
> +	     state == NVME_CTRL_DELETING) && qid > 0)
> +		return BLK_EH_RESET_TIMER;
>   
> -	if (nvme_ctrl_state(ctrl) != NVME_CTRL_LIVE) {
> +	if (state != NVME_CTRL_LIVE) {
>   		/*
> -		 * If we are resetting, connecting or deleting we should
> -		 * complete immediately because we may block controller
> -		 * teardown or setup sequence
> +		 * If the controller is not live we should complete
> +		 * immediately because we may block controller teardown
> +		 * or setup sequence
>   		 * - ctrl disable/shutdown fabrics requests
>   		 * - connect requests
>   		 * - initialization admin requests

