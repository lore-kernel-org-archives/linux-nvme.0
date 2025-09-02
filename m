Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C234CA0FFE
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Sep 2025 06:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J64vzhmYvnyt+YlEJ1nfM3uHTy8B3Z5+80jaFlsR54E=; b=2drUIGOhVjoWtNF+hNPqJy1P8t
	DVmZC3/gtSJSV1E494s7FXjJNP41wnMADGQ+vzsO/DtfEu5UR2pEJXJH9ToH3iIwesBmUVGG1BPz+
	0bNUekY/lsHaZmoQ9kx9jZHk6ZAgbR/TUFQv0qnv1esdovjsDUdDaVU+baCXIe4vG31KTpbChVdjN
	0XOcO3KTOoBjuQC2ym4vbPMw5kJxhiB3JvmwTyCHNtyL6LvPRWTE1ly/9mwhx9HZXCwYbwJYZPTHg
	EpGpUWfSA1/l/MaZ+TFLAV6njJ8jpxNcFRBmU5l+DpFku77wPHWyGbWNTM4WpD62H/az7/C/dfJfP
	/Vrsn/Rg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utKUn-0000000FWfV-0HeQ;
	Tue, 02 Sep 2025 06:27:57 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utKT7-0000000FWS5-0wXU
	for linux-nvme@lists.infradead.org;
	Tue, 02 Sep 2025 06:26:14 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5DFD21F445;
	Tue,  2 Sep 2025 06:26:10 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2046313888;
	Tue,  2 Sep 2025 06:26:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0fWdBQKOtmgtUAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 02 Sep 2025 06:26:10 +0000
Message-ID: <ee0d329a-334b-429c-a916-f03c64bbb323@suse.de>
Date: Tue, 2 Sep 2025 08:26:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 2/4] nvme: extend show-topology command to add support
 for multipath
To: Daniel Wagner <dwagner@suse.de>, Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, gjoyce@ibm.com
References: <20250812125614.164445-1-nilay@linux.ibm.com>
 <20250812125614.164445-3-nilay@linux.ibm.com>
 <93be5b21-8897-44d3-a590-42ba8f1b6abb@suse.de>
 <a06660fb-821f-447e-9ea6-ef0f3372a844@linux.ibm.com>
 <ecd33303-830d-4e26-b49a-14a558725e67@suse.de>
 <4f504c94-e6da-4a33-aa12-9dcb447e7021@flourine.local>
 <4e20561b-8b51-45c5-ad83-24b3d7ae092d@suse.de>
 <180fd47e-ffe6-4ef1-986e-5885afc34c01@linux.ibm.com>
 <8de91a15-3d89-4801-911a-00e45bb6a2f1@linux.ibm.com>
 <2eeba3ca-293c-429b-8afa-c5ba401c67b6@flourine.local>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <2eeba3ca-293c-429b-8afa-c5ba401c67b6@flourine.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 5DFD21F445
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250901_232613_408647_14D953A3 
X-CRM114-Status: GOOD (  22.86  )
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

On 9/1/25 18:36, Daniel Wagner wrote:
> Hi Nilay,
> 
> On Mon, Sep 01, 2025 at 02:51:09PM +0530, Nilay Shroff wrote:
>> Hi Daniel and Hannes,
>>
>> Just a gentle ping on this one...
>>
>> Do you agree with the reasoning I suggested for filtering
>> columns based on iopolicy? If we all have agreement then
>> I'd send out the next patchset with appropriate change.
> 
> I was waiting for Hannes input here as he was in discussion.
> 
Yeah, and he is fine with the latest changes. Probably should've been
a bit more vocal about it :-)

>>>> But really, I'm not sure if we should print out values from the various
>>>> I/O policies. For NUMA it probably makes sense, but for round-robin and
>>>> queue-depths the values are extremely volatile, so I wonder what benefit
>>>> for the user is here.
>>>>
>>>
>>> I think the qdepth output could still be useful. For example, if I/Os are
>>> queuing up on one path (perhaps because that path is slower), then the Qdepth
>>> value might help indicate something unusual or explain why one path is being
>>> chosen over another.
>>>
>>> That said, if we all agree that tools or scripts should ideally rely on JSON
>>> output for parsing, then the tabular output could be simplified further:
>>>
>>> - For numa iopolicy: print <Nodes> and exclude <Qdepth>.
>>> - For queue-depth iopolicy: print <Qdepth> and exclude <Nodes>.
>>> - For round-robin iopolicy: exclude both <Nodes> and <Qdepth>.
> 
> Looks reasonable to me.
> 
Yep, that's fine.

>>> Does this sound reasonable? Or do we still want to avoid printing
>>> <Qdepth> even for queue-depth iopolicy?
> 
> I am fine with printing the qdepth value as long it is documented what it
> means. IIRC there are other tools which just show a snapshot for some
> statistics.
> 
> BTW, some discussion on github regarding something like a
> 'monitor' feature: https://github.com/linux-nvme/nvme-cli/issues/2189
> Might be something to which could be considered here as well.
> Well, that might be tricky. The current 'tree' structure is build
once when the program starts up. Any changes to that structure after
that are not tracked, and there (currently) are no hooks for updating
it. So having a 'monitor' function will get tricky.

To do that we would either need a udev event receiver (using uevents
to update the tree structure) or looking into fanotify()/inotify().
Then the tree structure would always be up-to-date and things like
'monitor' will be possible.
Will be hell for the python bindings, mind :-(

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

