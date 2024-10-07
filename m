Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4938CFB443
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Oct 2024 14:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HXpntlSr7f4G6Ue7n3dG80YvsnxAtp30rkSdgAtygMA=; b=ntZ0wowQW5ffDHwnM8B0MQ/WOr
	cX6S/79ffqTk22UGmiKLBkoG+eES4PIGp604Dr2PvdKHajFtEKJg4/paJTtG61GuFcRC5M4SNsJO5
	zZ81SPB7ozOE89hdxIW5RyE8HSI1xQpzmPPgWzYQzewvtm1IBsAMbUC5oONEqKrxXvT0RVQ+Vdxpk
	U3eLlBaOE9frYtg6mlPMaci9T8mYXar9bN5hZtDgGUQDzHvvITqFJYEMXE3ut4/9kzUnB1cvgf6gp
	492CLYYfhbJHEYoBn4vtoZSnDTCmUGq4yop76PCdIYCSH9qSQugyD3+OSP0ixWtmCmptIjGmeKBcO
	r0wuKzzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sxoRN-00000002dsw-0G4f;
	Mon, 07 Oct 2024 14:10:25 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sxoLt-00000002cRO-2zSl
	for linux-nvme@lists.infradead.org;
	Mon, 07 Oct 2024 14:04:49 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BD4962199D;
	Mon,  7 Oct 2024 14:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728309883; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HXpntlSr7f4G6Ue7n3dG80YvsnxAtp30rkSdgAtygMA=;
	b=PMRFsprvpuVYAH8Tn+tnh+SAwDySbnW7YGP6Iq2ef1N91E1QSfPm7vb4xRYEKIX+0rrHkR
	LObjaa1+Ry8p+APIc6u0FR54E6Lt/tctw61khulwkUJmg/tKGUt/QRyX+PayUn+l5F22Qv
	C/5mzq1Su083twanlyiBeGwhHPQJGsk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728309883;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HXpntlSr7f4G6Ue7n3dG80YvsnxAtp30rkSdgAtygMA=;
	b=gxl93g7kvMUJSYgkTkpeTtmRhkVxMNEpm4jnZKAjcLVWkahr2ivd1SHgrd+UzIMuZ9nfpd
	xDPEGrwBF8hh32AQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=PMRFsprv;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=gxl93g7k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728309883; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HXpntlSr7f4G6Ue7n3dG80YvsnxAtp30rkSdgAtygMA=;
	b=PMRFsprvpuVYAH8Tn+tnh+SAwDySbnW7YGP6Iq2ef1N91E1QSfPm7vb4xRYEKIX+0rrHkR
	LObjaa1+Ry8p+APIc6u0FR54E6Lt/tctw61khulwkUJmg/tKGUt/QRyX+PayUn+l5F22Qv
	C/5mzq1Su083twanlyiBeGwhHPQJGsk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728309883;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HXpntlSr7f4G6Ue7n3dG80YvsnxAtp30rkSdgAtygMA=;
	b=gxl93g7kvMUJSYgkTkpeTtmRhkVxMNEpm4jnZKAjcLVWkahr2ivd1SHgrd+UzIMuZ9nfpd
	xDPEGrwBF8hh32AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9D8AD13786;
	Mon,  7 Oct 2024 14:04:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JqkLJnvqA2dUcgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 07 Oct 2024 14:04:43 +0000
Message-ID: <0f4528f0-8ef3-449f-bb15-47878d93a002@suse.de>
Date: Mon, 7 Oct 2024 16:04:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv4 RFC 1/1] nvme-multipath: Add sysfs attributes for
 showing multipath info
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hch@lst.de, kbusch@kernel.org, sagi@grimberg.me,
 axboe@fb.com, gjoyce@linux.ibm.com
References: <20240911062653.1060056-1-nilay@linux.ibm.com>
 <20240911062653.1060056-4-nilay@linux.ibm.com>
 <5050777a-2812-4fcf-bed9-00f0cb5706fc@suse.de>
 <93af0dc5-c988-423c-9788-e93ca8703fd5@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <93af0dc5-c988-423c-9788-e93ca8703fd5@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BD4962199D
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241007_070446_078344_C8CFE88B 
X-CRM114-Status: GOOD (  21.98  )
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

On 10/7/24 15:47, Nilay Shroff wrote:
> 
> 
> On 10/7/24 15:44, Hannes Reinecke wrote:
>> On 9/11/24 08:26, Nilay Shroff wrote:
>>> NVMe native multipath supports different IO policies for selecting I/O
>>> path, however we don't have any visibility about which path is being
>>> selected by multipath code for forwarding I/O.
>>> This patch helps add that visibility by adding new sysfs attribute files
>>> named "numa_nodes" and "queue_depth" under each namespace block device
>>> path /sys/block/nvmeXcYnZ/. We also create a "multipath" sysfs directory
>>> under head disk node and then from this directory add a link to each
>>> namespace path device this head disk node points to.
>>>
>>> For instance, /sys/block/nvmeXnY/multipath/ would create a soft link to
>>> each path the head disk node <nvmeXnY> points to:
>>>
>>> $ ls -1 /sys/block/nvme1n1/
>>> nvme1c1n1 -> ../../../../../pci052e:78/052e:78:00.0/nvme/nvme1/nvme1c1n1
>>> nvme1c3n1 -> ../../../../../pci058e:78/058e:78:00.0/nvme/nvme3/nvme1c3n1
>>>
>>> For round-robin I/O policy, we could easily infer from the above output
>>> that I/O workload targeted to nvme3n1 would toggle across paths nvme1c1n1
>>> and nvme1c3n1.
>>>
>>> For numa I/O policy, the "numa_nodes" attribute file shows the numa nodes
>>> being preferred by the respective block device path. The numa nodes value
>>> is comma delimited list of nodes or A-B range of nodes.
>>>
>>> For queue-depth I/O policy, the "queue_depth" attribute file shows the
>>> number of active/in-flight I/O requests currently queued for each path.
>>>
>>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
>>> ---
>>>    drivers/nvme/host/core.c      |  3 ++
>>>    drivers/nvme/host/multipath.c | 71 +++++++++++++++++++++++++++++++++++
>>>    drivers/nvme/host/nvme.h      | 20 ++++++++--
>>>    drivers/nvme/host/sysfs.c     | 20 ++++++++++
>>>    4 files changed, 110 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>> index 983909a600ad..6be29fd64236 100644
>>> --- a/drivers/nvme/host/core.c
>>> +++ b/drivers/nvme/host/core.c
>>> @@ -3951,6 +3951,9 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>>>          if (!nvme_ns_head_multipath(ns->head))
>>>            nvme_cdev_del(&ns->cdev, &ns->cdev_device);
>>> +
>>> +    nvme_mpath_remove_sysfs_link(ns);
>>> +
>>>        del_gendisk(ns->disk);
>>>          mutex_lock(&ns->ctrl->namespaces_lock);
>>> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
>>> index 518e22dd4f9b..7d9c36a7a261 100644
>>> --- a/drivers/nvme/host/multipath.c
>>> +++ b/drivers/nvme/host/multipath.c
>>> @@ -654,6 +654,8 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
>>>            nvme_add_ns_head_cdev(head);
>>>        }
>>>    +    nvme_mpath_add_sysfs_link(ns);
>>> +
>>>        mutex_lock(&head->lock);
>>>        if (nvme_path_is_optimized(ns)) {
>>>            int node, srcu_idx;
>> Nearly there.
> Thank you for your review comments!
> 
>>
>> You can only call 'nvme_mpath_add_sysfs_link()' if the gendisk on the head had been created.
>>
>> And there is one branch in nvme_mpath_add_disk():
>>
>>                  if (desc.state) {
>>                          /* found the group desc: update */
>>                          nvme_update_ns_ana_state(&desc, ns);
>>
>> which does not go via nvme_mpath_set_live(), yet a device link would need to be create here, too.
>> But you can't call nvme_mpath_add_sysfs_link() from nvme_mpath_add_disk(), as the actual gendisk
 >> might only be created later on during ANA log parsing.>>
>> It is a tangle, and I haven't found a good way out of this.
>> But I am _very much_ in favour of having these links, so please
>> update your patch.
>> In case disk supports ANA group then yes it would go through nvme_mpath_add_disk()->nvme_update_ns_ana_state();
>> and later nvme_update_ns_ana_state() would also fall through function nvme_mpath_set_live where we call
>> nvme_mpath_add_sysfs_link().
> 
> So I think that in any case while multipath namespace is being created it has to go through
> nvme_mpath_set_live function. And as we see in nvme_mpath_set_live function, we only create
> sysfs link after the gendisk on the head is created. Do you agree with this? Or please let
> me know if you have any further question.
> 
But it doesn't:

         if (nvme_state_is_live(ns->ana_state) &&
             nvme_ctrl_state(ns->ctrl) == NVME_CTRL_LIVE)
                 nvme_mpath_set_live(ns);

so if a namespace is being created for which nvme_state_is_live() 
returns 'false' nvme_mpath_set_live() is not called, and no links are 
being created.
This can happen eg. if the first namespace to be encountered is in any 
other state than 'optimized' or 'non-optimized'.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

