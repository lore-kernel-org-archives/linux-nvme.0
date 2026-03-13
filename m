Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0CFE106FD9B
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Mar 2026 08:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=48N3ezLDPzi4WJmYIjB/KXhcJ8z9wHa8c7Q1HcRU2YE=; b=2dyRV4vBmWYX5xHQ3mzYfNJBcg
	QfIKjqCvRWhhYRkZqjh/lTdGPQM+NgN5rFec7pKes3hys7mqRs8nJJ10byDjgCSk8HhKzaaPkgyeU
	S+3F7g6rZV3eXI7POPgphRO+Jcjx0gHTvUgfevu3tXfwIUy1/3pcfnwZ/jiEfrWiRZStodJQ3xCCE
	w+25fzXeSyp615qHYog35n0pcMsZQfOMuCKkEWHYK8F4fDb7lyMbGGc+Ru+zrKp0YpjIE3NPHZ2qg
	JHyLTfoIQtn9xIyAat9GlFx/k1d/ZDHQzwp1V/phmx44ySe4wauC36PCmKZzRRkEtoaWZNJPVIECj
	mSBGwGeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0xdM-0000000HBcZ-43Ht;
	Fri, 13 Mar 2026 08:12:36 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0xdG-0000000HBNf-1fXB
	for linux-nvme@lists.infradead.org;
	Fri, 13 Mar 2026 08:12:33 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5F3014D337;
	Fri, 13 Mar 2026 08:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773389477; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=48N3ezLDPzi4WJmYIjB/KXhcJ8z9wHa8c7Q1HcRU2YE=;
	b=ZrPyw8gQIXekAZ0GXxXnANteyGfp10OfHCbkcBKa2T8Z7RCDDiZR6kalG8HVZGz0+gEagL
	JSyuyK5SJf9zVjJbd4+VWLkADq7h/TDCmxk3LDGzp0hRxeMkzbld8KGMQp+pkJtFtZn33E
	4K7uGW8aFvezSOHWKlja0z9Wdi13BeE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773389477;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=48N3ezLDPzi4WJmYIjB/KXhcJ8z9wHa8c7Q1HcRU2YE=;
	b=vGguBueFXpZNFK805QG+OYarY+CrUJVguanwpK4DO7LNzVFkNe3FZanzZccn7Rb4GJ0B6A
	oV6zZTQIsp30OmBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773389476; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=48N3ezLDPzi4WJmYIjB/KXhcJ8z9wHa8c7Q1HcRU2YE=;
	b=euAaJKNptD9ChCSKYXq0SXEyJ+i/ED6J27Tj963/JCrc+8v90sVAZCvIyo784isfSML1p9
	0Oizxeei6wWGUIEV1mD3s2/+Gf1T/XOi6hwvbVJlCYVAWzXp1JR7zpyS7eatW1YSPnm7dH
	IDPc7boFB01ExhdIo5J95HpliegO4I8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773389476;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=48N3ezLDPzi4WJmYIjB/KXhcJ8z9wHa8c7Q1HcRU2YE=;
	b=5bABXbSe8hF/pgOD9JmldTEk3IQbqxCQBtBPrI1t+Vh34LGRNV7mQKALULKhmafRRjeBwz
	lo7Nzo9c/xQWMjDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2D4E84040D;
	Fri, 13 Mar 2026 08:11:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VrTbCaTGs2kZMQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 13 Mar 2026 08:11:16 +0000
Message-ID: <222658ae-747e-4b90-9491-d49e26c9cbef@suse.de>
Date: Fri, 13 Mar 2026 09:11:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/2] nvmet-tcp: remove redundant calls to
 nvmet_tcp_fatal_error()
To: Maurizio Lombardi <mlombard@arkamax.eu>,
 Maurizio Lombardi <mlombard@redhat.com>, kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org, dwagner@suse.de, yjshin0438@gmail.com,
 sagi@grimberg.me, chaitanyak@nvidia.com
References: <20260312134057.110274-1-mlombard@redhat.com>
 <20260312134057.110274-3-mlombard@redhat.com>
 <5accbc4b-42c3-4d47-a8c5-51b0a7180f11@suse.de>
 <DH1HOH95UR5I.3VIFUN1OMD5TE@arkamax.eu>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <DH1HOH95UR5I.3VIFUN1OMD5TE@arkamax.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[lists.infradead.org,suse.de,gmail.com,grimberg.me,nvidia.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260313_011231_017568_0B3119B2 
X-CRM114-Status: GOOD (  16.68  )
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

On 3/13/26 08:51, Maurizio Lombardi wrote:
> On Fri Mar 13, 2026 at 8:20 AM CET, Hannes Reinecke wrote:
>> On 3/12/26 14:40, Maurizio Lombardi wrote:
>>> Executing nvmet_tcp_fatal_error() is generally the responsibility
>>> of the caller (nvmet_tcp_try_recv); all other functions should
>>> just return the error code.
>>>
>>> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
>>> ---
>>>    drivers/nvme/target/tcp.c | 22 +++++-----------------
>>>    1 file changed, 5 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
>>> index 1fbf12df1183..b250b13854b4 100644
>>> --- a/drivers/nvme/target/tcp.c
>>> +++ b/drivers/nvme/target/tcp.c
>>> @@ -885,7 +885,6 @@ static int nvmet_tcp_handle_icreq(struct nvmet_tcp_queue *queue)
>>>    	if (le32_to_cpu(icreq->hdr.plen) != sizeof(struct nvme_tcp_icreq_pdu)) {
>>>    		pr_err("bad nvme-tcp pdu length (%d)\n",
>>>    			le32_to_cpu(icreq->hdr.plen));
>>> -		nvmet_tcp_fatal_error(queue);
>>>    		return -EPROTO;
>>>    	}
>>>    
>>> @@ -951,7 +950,6 @@ static int nvmet_tcp_handle_req_failure(struct nvmet_tcp_queue *queue,
>>>    	ret = nvmet_tcp_map_data(cmd);
>>>    	if (unlikely(ret)) {
>>>    		pr_err("queue %d: failed to map data\n", queue->idx);
>>> -		nvmet_tcp_fatal_error(queue);
>>>    		return -EPROTO;
>>>    	}
>>>    
>>> @@ -1024,7 +1022,6 @@ static int nvmet_tcp_handle_h2c_data_pdu(struct nvmet_tcp_queue *queue)
>>>    
>>>    err_proto:
>>>    	/* FIXME: use proper transport errors */
>>> -	nvmet_tcp_fatal_error(queue);
>>>    	return -EPROTO;
>>>    }
>>>    
>>> @@ -1039,7 +1036,6 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tcp_queue *queue)
>>>    		if (hdr->type != nvme_tcp_icreq) {
>>>    			pr_err("unexpected pdu type (%d) before icreq\n",
>>>    				hdr->type);
>>> -			nvmet_tcp_fatal_error(queue);
>>>    			return -EPROTO;
>>>    		}
>>>    		return nvmet_tcp_handle_icreq(queue);
>>> @@ -1048,7 +1044,6 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tcp_queue *queue)
>>>    	if (unlikely(hdr->type == nvme_tcp_icreq)) {
>>>    		pr_err("queue %d: received icreq pdu in state %d\n",
>>>    			queue->idx, queue->state);
>>> -		nvmet_tcp_fatal_error(queue);
>>>    		return -EPROTO;
>>>    	}
>>>    
>>> @@ -1065,7 +1060,6 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tcp_queue *queue)
>>>    		pr_err("queue %d: out of commands (%d) send_list_len: %d, opcode: %d",
>>>    			queue->idx, queue->nr_cmds, queue->send_list_len,
>>>    			nvme_cmd->common.opcode);
>>> -		nvmet_tcp_fatal_error(queue);
>>>    		return -ENOMEM;
>>>    	}
>>>    
>>> @@ -1086,9 +1080,9 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tcp_queue *queue)
>>>    	if (unlikely(ret)) {
>>>    		pr_err("queue %d: failed to map data\n", queue->idx);
>>>    		if (nvmet_tcp_has_inline_data(queue->cmd))
>>> -			nvmet_tcp_fatal_error(queue);
>>> -		else
>>> -			nvmet_req_complete(req, ret);
>>> +			return -EPROTO;
>>> +
>>> +		nvmet_req_complete(req, ret);
>>>    		ret = -EAGAIN;
>>>    		goto out;
>>>    	}
>>> @@ -1211,7 +1205,6 @@ static int nvmet_tcp_try_recv_pdu(struct nvmet_tcp_queue *queue)
>>>    
>>>    		if (unlikely(!nvmet_tcp_pdu_valid(hdr->type))) {
>>>    			pr_err("unexpected pdu type %d\n", hdr->type);
>>> -			nvmet_tcp_fatal_error(queue);
>>>    			return -EIO;
>>>    		}
>>>    
>>> @@ -1225,16 +1218,12 @@ static int nvmet_tcp_try_recv_pdu(struct nvmet_tcp_queue *queue)
>>>    	}
>>>    
>>>    	if (queue->hdr_digest &&
>>> -	    nvmet_tcp_verify_hdgst(queue, &queue->pdu, hdr->hlen)) {
>>> -		nvmet_tcp_fatal_error(queue); /* fatal */
>>> +	    nvmet_tcp_verify_hdgst(queue, &queue->pdu, hdr->hlen))
>>>    		return -EPROTO;
>>> -	}
>>>    
>>>    	if (queue->data_digest &&
>>> -	    nvmet_tcp_check_ddgst(queue, &queue->pdu)) {
>>> -		nvmet_tcp_fatal_error(queue); /* fatal */
>>> +	    nvmet_tcp_check_ddgst(queue, &queue->pdu))
>>>    		return -EPROTO;
>>> -	}
>>>    
>>>    	return nvmet_tcp_done_recv_pdu(queue);
>>>    }
>>> @@ -1319,7 +1308,6 @@ static int nvmet_tcp_try_recv_ddgst(struct nvmet_tcp_queue *queue)
>>>    			le32_to_cpu(cmd->exp_ddgst));
>>>    		nvmet_req_uninit(&cmd->req);
>>>    		nvmet_tcp_free_cmd_buffers(cmd);
>>> -		nvmet_tcp_fatal_error(queue);
>>>    		ret = -EPROTO;
>>>    		goto out;
>>>    	}
>>
>> I seem to be missing something crucial here. But after applying this
>> patch _all_ invocations to nvmet_tcp_fatal_error() are gone.
>> (Applying the patches on top of linus tree with topmost commit
>> 0257f64bdac7fdca30fa3cae0df8b9ecbec7733a)
>>
>> I must be missing something crucial here ...
> 
> I've just rebased my branch on top of master and I can still
> see nvmet_tcp_socket_error() calling nvmet_tcp_fatal_error()
> 
> nvmet_tcp_socket_error() is called by both nvmet_tcp_try_send()
> and nvmet_tcp_try_recv() in case of errors, so it's still here.
> with us.
> 
Right.
But now nvmet_tcp_fatal_error() has just a single caller, so please
fold it into nvmet_tcp_socket_error() (and remove the forward declaration).

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

