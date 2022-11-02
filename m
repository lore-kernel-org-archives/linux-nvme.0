Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0372FC433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Nov 2022 14:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:Subject:From:References:Cc:To:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ue6k6Q3rIXUI5ht3iwolA4zJAQLywzqBXrtyn2FcfoI=; b=BxYT0HTeuwYpWHEwxXjDUWKa2K
	HCXFD8foXJJPyQFp0aYLUNoAuoB2iq32Bhjyzq8mQDF1usQdNnbT0URkK7oyY7OUUgDLMiN1A6jrr
	gs3IafLupGSHwtK1yaseGyRavSq9mJQWa9lYZFrHAl/sCtoj43l433v6Ux18zDux2eeA4XPjNbiKR
	E9g2QL2v2mHNIPc++yCTKMXPGyLs8OxDH0JKiZ9vywYN739xMSyUUUZ3koHj6DwuR2SCdSnskeGPA
	WT+T8LhVqfBqQ4GNGrXLtCZAAgfXeMjr6u5P/o/yGPmC1MI35FVgOjU5R77Sxnsc3lpvax6CSY0J5
	blXU16tg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqEaW-00BTHg-Bn; Wed, 02 Nov 2022 14:19:28 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqEaS-00BTF6-9S
	for linux-nvme@lists.infradead.org; Wed, 02 Nov 2022 14:19:26 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2F8AB1F38A;
	Wed,  2 Nov 2022 14:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1667398761; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ue6k6Q3rIXUI5ht3iwolA4zJAQLywzqBXrtyn2FcfoI=;
	b=udFL8SJYFSWx6H1wKBf+FIy8DOj58Erg8kGGZiUdePxkphGjJfA1EEsKTiOmixQgp91Pit
	hHvfajmdO7HemglY5akQUuLxPqE+Rb64IxfaJi8AFBm7n/k1mzJArswPDpRzHKevREQBsj
	8pFy6OToOx4vpWm4jMyRnnnA7DteoWY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1667398761;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ue6k6Q3rIXUI5ht3iwolA4zJAQLywzqBXrtyn2FcfoI=;
	b=GYQkZWVNtruDQz1bocVyaMCWtYMCyaIbhXI/R+alMNMJBpH2DmSm0v+mZC8eMs2hyGLWQ1
	SY9Dbo8SWUavwhBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1FEDB13AE0;
	Wed,  2 Nov 2022 14:19:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id WkDiBWl8YmOAVQAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 02 Nov 2022 14:19:21 +0000
Message-ID: <208ac0eb-a7b3-9e58-8f93-f6810cad683c@suse.de>
Date: Wed, 2 Nov 2022 15:19:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Content-Language: en-US
To: Chao Leng <lengchao@huawei.com>, Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20221102073650.58245-1-hare@suse.de>
 <88b18b60-aa99-82d0-fc7e-bc65d05792c0@huawei.com>
From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvme: retry commands if DNR bit is not set
In-Reply-To: <88b18b60-aa99-82d0-fc7e-bc65d05792c0@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221102_071924_500849_46642AD1 
X-CRM114-Status: GOOD (  23.26  )
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

On 11/2/22 09:00, Chao Leng wrote:
> 
> 
> On 2022/11/2 15:36, Hannes Reinecke wrote:
>> Add a 'retries' argument to __nvme_submit_sync_cmd() to instruct
>> the function to retry the command if the DNR bit is not set in
>> the command result, and modify the authentication code to allow
>> for retries.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>   drivers/nvme/host/auth.c    |  2 +-
>>   drivers/nvme/host/core.c    | 29 ++++++++++++++++++++++++-----
>>   drivers/nvme/host/fabrics.c | 10 +++++-----
>>   drivers/nvme/host/nvme.h    |  6 +++++-
>>   4 files changed, 35 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
>> index c8a6db7c4498..3b63aa155beb 100644
>> --- a/drivers/nvme/host/auth.c
>> +++ b/drivers/nvme/host/auth.c
>> @@ -69,7 +69,7 @@ static int nvme_auth_submit(struct nvme_ctrl *ctrl, 
>> int qid,
>>       ret = __nvme_submit_sync_cmd(q, &cmd, NULL, data, data_len,
>>                        qid == 0 ? NVME_QID_ANY : qid,
>> -                     0, flags);
>> +                     0, flags, nvme_max_retries);
>>       if (ret > 0)
>>           dev_warn(ctrl->device,
>>               "qid %d auth_send failed with status %d\n", qid, ret);
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index dc4220600585..d0de1a85596a 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -54,7 +54,7 @@ static unsigned char shutdown_timeout = 5;
>>   module_param(shutdown_timeout, byte, 0644);
>>   MODULE_PARM_DESC(shutdown_timeout, "timeout in seconds for 
>> controller shutdown");
>> -static u8 nvme_max_retries = 5;
>> +u8 nvme_max_retries = 5;
>>   module_param_named(max_retries, nvme_max_retries, byte, 0644);
>>   MODULE_PARM_DESC(max_retries, "max number of retries a command may 
>> have");
>> @@ -1016,7 +1016,7 @@ static int nvme_execute_rq(struct request *rq, 
>> bool at_head)
>>    */
>>   int __nvme_submit_sync_cmd(struct request_queue *q, struct 
>> nvme_command *cmd,
>>           union nvme_result *result, void *buffer, unsigned bufflen,
>> -        int qid, int at_head, blk_mq_req_flags_t flags)
>> +        int qid, int at_head, blk_mq_req_flags_t flags, int retries)
>>   {
>>       struct request *req;
>>       int ret;
>> @@ -1030,6 +1030,7 @@ int __nvme_submit_sync_cmd(struct request_queue 
>> *q, struct nvme_command *cmd,
>>       if (IS_ERR(req))
>>           return PTR_ERR(req);
>>       nvme_init_request(req, cmd);
>> +    nvme_req(req)->retries = retries;
>>       if (buffer && bufflen) {
>>           ret = blk_rq_map_kern(q, req, buffer, bufflen, GFP_KERNEL);
>> @@ -1037,8 +1038,18 @@ int __nvme_submit_sync_cmd(struct request_queue 
>> *q, struct nvme_command *cmd,
>>               goto out;
>>       }
>> +retry:
>>       req->rq_flags |= RQF_QUIET;
>>       ret = nvme_execute_rq(req, at_head);
>> +    if (ret > 0) {
>> +        struct nvme_ctrl *ctrl = nvme_req(req)->ctrl;
>> +
>> +        if (ctrl->kas)
>> +            ctrl->comp_seen = true;
>> +
>> +        if (retries-- && nvme_decide_disposition(req) != COMPLETE)
>> +            goto retry;
>> +    }
>>       if (result && ret >= 0)
>>           *result = nvme_req(req)->result;
> Reusing the existing retry mechanism may be better.
> We can do like this:
> Do not set REQ_FAILFAST_DRIVER in nvme_init_request If need retry.
>      if (noretry)
>          req->cmd_flags |= REQ_FAILFAST_DRIVER;
> 
But then we still would need to set the retries; however, it's a good 
suggestion. Will be reworking the patch.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer


