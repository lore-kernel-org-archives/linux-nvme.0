Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE796C3ABA5
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Apr 2025 17:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GX2qXHxCI+YzanWk0wuGn3zCVc9Si2CNMSoWO9CF3II=; b=tzjkHSSBBTPXMF8HOLXK9kLRlq
	AsG9h+kLi1r1VXQDHxrGH/bj3LItyyhJglsyp8T2zK6OCAKQB+E1zCTdN6XjBZpmeE+AYa7beavUu
	fF3JgZ9j+d4o4cH06YTERJaEL17KbUvcQd4YFjdbCoC1FtZ5OT67DaBtZduXsBaFCEEBPZ0yQFpV8
	jpSKP5rr48/bawghptbPdRyGuaZ9DXArWacIoKIsU7X8I8XEXX8lJUQZDEDsyZgLK3NWvvlVdRIBd
	Gxvr3az+LLeiqVqcDlC1BIOoZu8+guSqAc6iFitD3yX0mtjnKyE7Dk4Nx7PTIVTjo0o9nLGelgwgl
	r/T6r1wQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9pBK-0000000ASb1-3UBE;
	Tue, 29 Apr 2025 17:55:46 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9p9o-0000000ASQn-0cvc
	for linux-nvme@lists.infradead.org;
	Tue, 29 Apr 2025 17:54:13 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BED961F391;
	Tue, 29 Apr 2025 17:54:06 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5E8011340C;
	Tue, 29 Apr 2025 17:54:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bCabFT4SEWiINwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 29 Apr 2025 17:54:06 +0000
Message-ID: <f0329c90-56d6-455a-8cbb-a4c28cb85057@suse.de>
Date: Tue, 29 Apr 2025 19:54:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme: only allow entering LIVE from CONNECTING state
To: Daniel Wagner <dwagner@suse.de>
Cc: Guenter Roeck <linux@roeck-us.net>, Daniel Wagner <wagi@kernel.org>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 James Smart <james.smart@broadcom.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250214-nvme-fc-fixes-v1-0-7a05d557d5cc@kernel.org>
 <20250214-nvme-fc-fixes-v1-1-7a05d557d5cc@kernel.org>
 <0134ea15-8d5f-41f7-9e9a-d7e6d82accaa@roeck-us.net>
 <cb46aa83-8033-4d64-a3c7-420172c3f3f5@flourine.local>
 <9763c4cf-8ca5-45d4-b723-270548ca1001@suse.de>
 <6894c914-a734-4a7b-97cb-e9a344fa5560@flourine.local>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <6894c914-a734-4a7b-97cb-e9a344fa5560@flourine.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Rspamd-Queue-Id: BED961F391
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250429_105412_788977_493608A8 
X-CRM114-Status: GOOD (  21.15  )
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

On 4/29/25 15:55, Daniel Wagner wrote:
> On Mon, Apr 28, 2025 at 03:21:18PM +0200, Hannes Reinecke wrote:
>> On 4/28/25 14:44, Daniel Wagner wrote:
>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>> index b502ac07483b..d3c4eacf607f 100644
>>> --- a/drivers/nvme/host/core.c
>>> +++ b/drivers/nvme/host/core.c
>>> @@ -4493,7 +4493,8 @@ static void nvme_fw_act_work(struct work_struct *work)
>>>                   msleep(100);
>>>           }
>>>
>>> -       if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE))
>>> +       if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING) ||
>>> +           !nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE))
>>>                   return;
>>>
>>>           nvme_unquiesce_io_queues(ctrl);
>>
>> I would rather have a separate state for firmware activation.
>> (Ab-)using the 'RESETTING' state here has direct implications
>> with the error handler, as for the error handler 'RESETTING'
>> means that the error handler has been scheduled.
>> Which is not true for firmware activation.
> 
> Okay, so something like this here (untested, working on it)?
> 
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index b502ac07483b..32482712d0f2 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -565,6 +565,7 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
>   	case NVME_CTRL_LIVE:
>   		switch (old_state) {
>   		case NVME_CTRL_CONNECTING:
> +		case NVME_CTRL_FW_ACTIVATION:
>   			changed = true;
>   			fallthrough;
>   		default:
> @@ -575,6 +576,7 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
>   		switch (old_state) {
>   		case NVME_CTRL_NEW:
>   		case NVME_CTRL_LIVE:
> +		case NVME_CTRL_FW_ACTIVATION:
>   			changed = true;
>   			fallthrough;
>   		default:
> @@ -596,6 +598,7 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
>   		case NVME_CTRL_LIVE:
>   		case NVME_CTRL_RESETTING:
>   		case NVME_CTRL_CONNECTING:
> +		case NVME_CTRL_FW_ACTIVATION:
>   			changed = true;
>   			fallthrough;
>   		default:
> @@ -621,6 +624,15 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
>   			break;
>   		}
>   		break;
> +	case NVME_CTRL_FW_ACTIVATION:
> +		switch (old_state) {
> +		case NVME_CTRL_LIVE:
> +			changed = true;
> +			fallthrough;
> +		default:
> +			break;
> +		}
> +		break;
>   	default:
>   		break;
>   	}
> @@ -4529,7 +4541,7 @@ static bool nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
>   		 * recovery actions from interfering with the controller's
>   		 * firmware activation.
>   		 */
> -		if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING)) {
> +		if (nvme_change_ctrl_state(ctrl, NVME_CTRL_FW_ACTIVATION)) {
>   			requeue = false;
>   			queue_work(nvme_wq, &ctrl->fw_act_work);
>   		}
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 51e078642127..3a383225afed 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -247,6 +247,7 @@ static inline u16 nvme_req_qid(struct request *req)
>    *				shutdown or removal. In this case we forcibly
>    *				kill all inflight I/O as they have no chance to
>    *				complete
> + * @NVME_CTRL_FW_ACTIVATION:	Controller is in firmware activation state.
>    */
>   enum nvme_ctrl_state {
>   	NVME_CTRL_NEW,
> @@ -256,6 +257,7 @@ enum nvme_ctrl_state {
>   	NVME_CTRL_DELETING,
>   	NVME_CTRL_DELETING_NOIO,
>   	NVME_CTRL_DEAD,
> +	NVME_CTRL_FW_ACTIVATION,
>   };
> 
>   struct nvme_fault_inject {
> 
Indeed, something like it.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

