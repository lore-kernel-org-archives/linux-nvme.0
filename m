Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A84C8CA0EE9
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Aug 2025 06:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BwIEhPT/VcnE+ULw4d2aW/TN7mhs8f4KjUCmEu83gwY=; b=y/EQk/5kPHgWM/xdTM34Y20lYf
	IAUcPbkI+ZYzZQzaZ+Pmu66wFoIH1v0F8bsbEgjOWtHTuu56CTpyae6zD/d71n9+GgtBAWXAsPOrU
	dXUTz0j9NNnIkFflO0cWdL1ot8zIfdPCSyzfJ1Cp7rYLgRnob+Lf5hEgIsmlGG4VwRq8mheVOm1JU
	CjKB4+K41RU3Q0DLHotyRKGYJEOZOwyU884SvAPt+oQScHMsF40CHTB9VP8sekqsRW8XxRnYd7NIi
	gYINfg8I+XLwSIUeNscuS/gQClvuFeW80RM280KQZk7EyB6Ol2vKehEX22f77phqEcV5zKFyB7iiH
	53ltNyBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoFcn-00000009ViP-1ccX;
	Tue, 19 Aug 2025 06:15:13 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoFcl-00000009Vh3-1qYK
	for linux-nvme@lists.infradead.org;
	Tue, 19 Aug 2025 06:15:12 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 11CB52124F;
	Tue, 19 Aug 2025 06:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755584110; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BwIEhPT/VcnE+ULw4d2aW/TN7mhs8f4KjUCmEu83gwY=;
	b=FQt5lTyUklF3OQLFyCyinuOF714vJAhUp1G3pRw1OG4qG1wt8NRj3YErIkmrMt65FrzG+I
	T/xEtoBp5awJcTfOeeqJz//GYJxDkk7Ui3WIjmXfcP1YMURMh1Wm8JrxQ2Q4LixWZVhhcB
	2rcuQ0AFXKfBvdj94MaFdMW27PRHqDw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755584110;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BwIEhPT/VcnE+ULw4d2aW/TN7mhs8f4KjUCmEu83gwY=;
	b=FyHNKuEiMbCKRMa7ies66YJ9LCGMXrMSgstzucyMJi/GapfqaYeOljxteK1R29VNZQneZ5
	4gx7mJPOphqD2RDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=FQt5lTyU;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=FyHNKuEi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755584110; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BwIEhPT/VcnE+ULw4d2aW/TN7mhs8f4KjUCmEu83gwY=;
	b=FQt5lTyUklF3OQLFyCyinuOF714vJAhUp1G3pRw1OG4qG1wt8NRj3YErIkmrMt65FrzG+I
	T/xEtoBp5awJcTfOeeqJz//GYJxDkk7Ui3WIjmXfcP1YMURMh1Wm8JrxQ2Q4LixWZVhhcB
	2rcuQ0AFXKfBvdj94MaFdMW27PRHqDw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755584110;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BwIEhPT/VcnE+ULw4d2aW/TN7mhs8f4KjUCmEu83gwY=;
	b=FyHNKuEiMbCKRMa7ies66YJ9LCGMXrMSgstzucyMJi/GapfqaYeOljxteK1R29VNZQneZ5
	4gx7mJPOphqD2RDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ACFED139B3;
	Tue, 19 Aug 2025 06:15:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sGEsJ20WpGjmDQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 19 Aug 2025 06:15:09 +0000
Message-ID: <ecd33303-830d-4e26-b49a-14a558725e67@suse.de>
Date: Tue, 19 Aug 2025 08:15:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 2/4] nvme: extend show-topology command to add support
 for multipath
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, kbusch@kernel.org, gjoyce@ibm.com
References: <20250812125614.164445-1-nilay@linux.ibm.com>
 <20250812125614.164445-3-nilay@linux.ibm.com>
 <93be5b21-8897-44d3-a590-42ba8f1b6abb@suse.de>
 <a06660fb-821f-447e-9ea6-ef0f3372a844@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <a06660fb-821f-447e-9ea6-ef0f3372a844@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 11CB52124F
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250818_231511_635331_59D02DFC 
X-CRM114-Status: GOOD (  14.42  )
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

On 8/19/25 06:49, Nilay Shroff wrote:
> 
> 
> On 8/18/25 12:52 PM, Hannes Reinecke wrote:
>> On 8/12/25 14:56, Nilay Shroff wrote:
>>> This commit enhances the show-topology command by adding support for
>>> NVMe multipath. With this change, users can now list all paths to a
>>> namespace from its corresponding head node device. Each NVMe path
>>> entry then also includes additional details such as ANA state, NUMA
>>> node, and queue depth, improving visibility into multipath configs.
>>> This information can be particularly helpful for debugging and
>>> analyzing NVMe multipath setups.
>>>
>>> To support this functionality, the "--ranking" option of the nvme
>>> show-topology command has been extended with a new sub-option:
>>> "multipath".
>>>
>>> Since this enhancement is specific to NVMe multipath, the iopolicy
>>> configured under each subsystem is now always displayed. Previously,
>>> iopolicy was shown only with nvme show-topology verbose output, but
>>> it is now included by default to improve usability and provide better
>>> context when reviewing multipath configurations via show-topology.
>>>
>>> With this update, users can view the multipath topology of a multi
>>> controller/port NVMe disk using:
>>>
>>> $ nvme show-topology -r multipath
>>>
>>> nvme-subsys2 - NQN=nvmet_subsystem
>>>                  hostnqn=nqn.2014-08.org.nvmexpress:uuid:12b49f6e-0276-4746-b10c-56815b7e6dc2
>>>                  iopolicy=numa
>>>
>>>             _ _ _<head-node>
>>>            /              _ _ _ <ana-state>
>>>           /              /      _ _ _ <numa-node-list>
>>>          /              /      /  _ _ _<queue-depth>
>>>         |              /      /  /
>>>    +- nvme2n1 (ns 1)  /      /  /
>>>    \                 |      |  |
>>>     +- nvme2c2n1 optimized 1,2 0 nvme2 tcp traddr=127.0.0.2,trsvcid=4460,src_addr=127.0.0.1 live
>>>     +- nvme2c3n1 optimized 3,4 0 nvme3 tcp traddr=127.0.0.3,trsvcid=4460,src_addr=127.0.0.1 live
>>>
>>> Please note that the annotations shown above (e.g., <numa-node-list>,
>>> <ana-state>, <hed-node>, and <queue-depth>) are included for clarity
>>> only and are not part of the actual output.
>>>
>>
>> Hmm. Why do we have the values for 'numa-node-list' and 'queue-depth'
>> both in here? They are tied to the selected IO policy, and pretty
>> meaningless if that IO policy is not selected.
>> Please include only the values relevant for the selected IO policy;
>> this will increase readability of the resulting status string.
>>
> Okay makes sense, so we'd print <numa-node> and exclude <queue-depth> if iopolicy
> is numa. For 'queue-depth' iopolicy, we'd print <queue-depth> and exclude <numa-node>.
> And for 'round-robin' iopolicy, we'd neither print <numa-node> nor <queue-depth>.
> I'll update this in the next patch.
> 
Hmm. I'd rather have _some_ value for 'round-robin', too, as otherwise
the number of fields will be different (and making parsing harder).

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

