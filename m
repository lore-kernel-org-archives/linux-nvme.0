Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A6D7C47077
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jan 2024 03:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pthhYBnfRi0iWoIDi2RPShJOY0XSc7dU8rohjsVNoDA=; b=0QzwhAe222j16qvXsmYywwa88d
	0dUeDpiyeKvqheJp1N6s+QRNR4pkRy3ZGpvDKvsDZo35VjNPoRuciBFKozv+JLSVwHYKXn4Z7hWKG
	zWwI1zp9SGG5PwL0Ph82N5U63al0HgrHdXbcNCBIWMq2UNmHNSvYZLesfRCeu4izDSUAnxRuUg6GK
	JPsjUE9kh/x9Cy4JBuxjUDVZf3UeatLdwFfvlRIGLLaBPsCt1v/8hAwOqPTc1STlf9+w9+vPm4u2j
	YyXp+vlxZ9q7zmJ21aEIrzqFMYGd5RZ2FK7t2+uMa8Bbvvo8P2xEzoL6snMX546z7jNduI8ulqbdS
	hTeaA9FA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rNP7u-00AD8Z-1x;
	Wed, 10 Jan 2024 03:19:34 +0000
Received: from out30-97.freemail.mail.aliyun.com ([115.124.30.97])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rNP7q-00AD7V-2a
	for linux-nvme@lists.infradead.org;
	Wed, 10 Jan 2024 03:19:32 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W-KblVK_1704856762;
Received: from 30.178.83.60(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W-KblVK_1704856762)
          by smtp.aliyun-inc.com;
          Wed, 10 Jan 2024 11:19:23 +0800
Message-ID: <a56b996e-8d38-42e9-914c-8877182c5cc0@linux.alibaba.com>
Date: Wed, 10 Jan 2024 11:19:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Guixin Liu <kanie@linux.alibaba.com>
Subject: Re: [PATCH] nvmet: support reservation feature
To: Keith Busch <kbusch@kernel.org>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
 linux-nvme@lists.infradead.org
References: <20240109121008.15925-1-kanie@linux.alibaba.com>
 <ZZ1713_D7MojvHUu@kbusch-mbp>
Content-Language: en-GB
In-Reply-To: <ZZ1713_D7MojvHUu@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240109_191931_179521_1EF7274E 
X-CRM114-Status: GOOD (  24.71  )
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


在 2024/1/10 01:01, Keith Busch 写道:
> On Tue, Jan 09, 2024 at 08:10:08PM +0800, Guixin Liu wrote:
>> This patch implements the reservation feature, includes:
>> 1. reservation register(register, unregister and replace).
>> 2. reservation acquire(acquire, preempt, preempt and abort).
>> 3. reservation release(release and clear).
>> 4. reservation report.
>>
>> And also make reservation configurable, one can set ns to support
>> reservation before enable ns. The default of resv_enable is false.
>>
>> Signed-off-by: Guixin Liu<kanie@linux.alibaba.com>
>> ---
>> Hi guys,
>>      I've implemented the NVMe reservation feature. Please review it, all
>> comments are welcome.
> Why? If you have a real use case, let's add a blktest example added to
> that project.
OK, I will research the blktests, and add some tests.
>>      In addtion, I didn't implement event reporting because I didn't see
>> any handling of these events on the host side. If these events are mandatory
>> to report, please let me know so that I can implement them.
> User space could be listening for them. The driver doesn't have any
> particular action to take on a PR event just send a uevent.
>   
I will analyze which uevents need to be send and implement the 
notifications.
>>   	 */
>>   	id->nmic = NVME_NS_NMIC_SHARED;
>>   	id->anagrpid = cpu_to_le32(req->ns->anagrpid);
>> -
>> +	id->rescap = NVME_PR_SUPPORT_WRITE_EXCLUSIVE |
>> +		     NVME_PR_SUPPORT_EXCLUSIVE_ACCESS |
>> +		     NVME_PR_SUPPORT_WRITE_EXCLUSIVE_REG_ONLY |
>> +		     NVME_PR_SUPPORT_EXCLUSIVE_ACCESS_REG_ONLY |
>> +		     NVME_PR_SUPPORT_WRITE_EXCLUSIVE_ALL_REGS |
>> +		     NVME_PR_SUPPORT_EXCLUSIVE_ACCESS_ALL_REGS |
>> +		     NVME_PR_SUPPORT_IEKEY_DEF_LATER_VER_1_3;
>>   	memcpy(&id->nguid, &req->ns->nguid, sizeof(id->nguid));
>>   
>>   	id->lbaf[0].ds = req->ns->blksize_shift;
>> @@ -1017,6 +1023,12 @@ u16 nvmet_parse_admin_cmd(struct nvmet_req *req)
>>   	if (nvmet_is_passthru_req(req))
>>   		return nvmet_parse_passthru_admin_cmd(req);
>>   
>> +	ret = nvmet_pr_check_cmd_access(req);
>> +	if (unlikely(ret)) {
>> +		req->error_loc = offsetof(struct nvme_common_command, opcode);
>> +		return ret;
>> +	}
> You're checking this before validating the opcode. I don't think pr
> access violation should have error precedence over an invalid opcode.
Agree, I will put it after validating the opcode.
>> +static bool nvmet_is_req_write_cmd_group(struct nvmet_req *req)
>> +{
>> +	struct nvme_command *cmd = req->cmd;
>> +	u8 opcode = cmd->common.opcode;
>> +
>> +	if (req->sq->qid) {
>> +		switch (opcode) {
>> +		case nvme_cmd_flush:
>> +		case nvme_cmd_write:
>> +		case nvme_cmd_write_zeroes:
>> +		case nvme_cmd_dsm:
>> +		case nvme_cmd_write_uncor:
>> +			return true;
>> +		default:
>> +			return false;
>> +		}
>> +	}
>> +	switch (opcode) {
>> +	case nvme_admin_cap_mgmt:
>> +	case nvme_admin_format_nvm:
>> +	case nvme_admin_ns_attach:
>> +	case nvme_admin_ns_mgmt:
>> +	case nvme_admin_sanitize_nvm:
>> +	case nvme_admin_security_send:
>> +		return true;
>> +	default:
>> +		return false;
>> +	}
>> +}
>> +static bool nvmet_is_req_read_cmd_group(struct nvmet_req *req)
>> +{
>> +	struct nvme_command *cmd = req->cmd;
>> +	u8 opcode = cmd->common.opcode;
>> +
>> +	if (req->sq->qid) {
>> +		switch (opcode) {
>> +		case nvme_cmd_read:
>> +		case nvme_cmd_compare:
>> +		case nvme_cmd_verify:
>> +			return true;
>> +		default:
>> +			return false;
>> +		}
>> +	}
>> +	switch (opcode) {
>> +	case nvme_admin_security_recv:
>> +		return true;
>> +	default:
>> +		return false;
>> +	}
>> +}
> You're checking opcodes that we don't even support. I suggest we stash
> the Command Effects Log in our target and trust what that reports to
> deterimine if a command violates a reservation so that this function
> doesn't need to be kept in sync as new opcodes are created.

You mean I should check the opcode is whether supported?

If I put the checking after validating the opcode, is this still needed？

> Speaking of effects, you also need to update nvmet_get_cmd_effects_nvm()
> so that it reports support for NVMe reservation opcodes.
Sure, update it in v2.
>> +u16 nvmet_pr_check_cmd_access(struct nvmet_req *req)
>> +{
>> +	struct nvmet_ctrl *ctrl = req->sq->ctrl;
>> +	struct nvmet_ns *ns = req->ns;
>> +	struct nvmet_pr *pr;
>> +	u16 ret = 0;
>> +
>> +	if (!ns) {
>> +		ns = xa_load(&nvmet_req_subsys(req)->namespaces,
>> +			     le32_to_cpu(req->cmd->common.nsid));
> This could be the broadcast NSID, 0xffffffff, in which case you have to
> check all the namespaces for reservations.
Oh, I miss that, will check this in v2.
>
>> +	/*
>> +	 * The Reservation command group is checked in executing,
>> +	 * allow it here.
>> +	 */
>> +	switch ((u8)pr->rtype) {
>> +	case NVME_PR_WRITE_EXCLUSIVE:
>> +		if (nvmet_is_req_write_cmd_group(req) ||
>> +		    nvmet_is_req_copy_cmd_group(req))
>> +			ret = NVME_SC_RESERVATION_CONFLICT | NVME_SC_DNR;
>> +		break;
>> +	case NVME_PR_EXCLUSIVE_ACCESS:
>> +		if (nvmet_is_req_copy_cmd_group(req) ||
>> +		    nvmet_is_req_read_cmd_group(req) ||
>> +		    nvmet_is_req_write_cmd_group(req))
>> +			ret = NVME_SC_RESERVATION_CONFLICT | NVME_SC_DNR;
>> +		break;
>> +	case NVME_PR_WRITE_EXCLUSIVE_REG_ONLY:
>> +	case NVME_PR_WRITE_EXCLUSIVE_ALL_REGS:
>> +		if ((nvmet_is_req_copy_cmd_group(req) ||
>> +		    nvmet_is_req_write_cmd_group(req)) &&
>> +		    !nvmet_pr_find_registrant_by_hostid(pr, &ctrl->hostid))
>> +			ret = NVME_SC_RESERVATION_CONFLICT | NVME_SC_DNR;
>> +		break;
>> +	case NVME_PR_EXCLUSIVE_ACCESS_REG_ONLY:
>> +	case NVME_PR_EXCLUSIVE_ACCESS_ALL_REGS:
>> +		if ((nvmet_is_req_copy_cmd_group(req) ||
>> +		    nvmet_is_req_read_cmd_group(req) ||
>> +		    nvmet_is_req_write_cmd_group(req)) &&
>> +		    !nvmet_pr_find_registrant_by_hostid(pr, &ctrl->hostid))
>> +			ret = NVME_SC_RESERVATION_CONFLICT | NVME_SC_DNR;
>> +		break;
>> +	default:
>> +		WARN_ON_ONCE(1);
>> +		break;
>> +	}
>> +
>> +unlock:
>> +	read_unlock(&pr->pr_lock);
>> +out:
>> +	if (!req->ns)
>> +		nvmet_put_namespace(ns);
>> +	return ret;
>> +}

