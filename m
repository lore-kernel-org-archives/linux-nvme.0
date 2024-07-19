Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF63C3DA5D
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jul 2024 08:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RFe5mANEdJaN6HYGQ0mLltG2ifywrVncOqwrmHC3J0k=; b=WgObH0/qxXbECrYbRIpEKGb2is
	vP6oW/5yeZIV0HKyOEv1kYSwa7GimTGllaQmu1W5l2/Ka2vuciKxHNpc87o8pX/gr26/3/dUeMCg5
	DwR70olLEmOJqk9n5M8XcQOA97Pb/WpLqjBBPYl4OiGa/5DhRsoEBA2uM2VcQBAUdjQGW/hkRuWd0
	L9qVBEQClJPW2b3//HqELzkSWejFazoKN+MMa8tVd/4kuRR9oaj1fs7lxNZmuvMvbSLs4yRj6UDev
	nqP+JsrYvAxKjY0Lc6T85ppTiWdWIx9U5yEB9TNsoUfsZa2MxQ/L78Lyx/zOJEwr/QpW/IsjQ874+
	T1VzCYaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUiwo-000000023yb-4A4e;
	Fri, 19 Jul 2024 08:26:38 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUiwk-000000023xV-1ftb
	for linux-nvme@lists.infradead.org;
	Fri, 19 Jul 2024 08:26:37 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AF6441F799;
	Fri, 19 Jul 2024 08:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721377592; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RFe5mANEdJaN6HYGQ0mLltG2ifywrVncOqwrmHC3J0k=;
	b=bXVCSMs6hu6ms1lEuaun4+Z+fRW54PKi/A4122lnk4TJhSEwriT3Q4XgjSLxy2/VgqqcMF
	zThl0sj1D5+nLJiIDyBaIn+32RIp/NAHvXavxNNB9snQFQBU/tEDBPJ4I96oMfb6P9KdTK
	dC3yXkVIp5ou3ndcqFchT0sWh7SbxoU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721377592;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RFe5mANEdJaN6HYGQ0mLltG2ifywrVncOqwrmHC3J0k=;
	b=UzAhIMRoizZ2Gv6OdAejWncdHh7lMObN1YCe5r0WVEaXWebdW0XCsNl1oAuEMsJvXhBxUu
	AME8AJV4IuFU4yAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721377592; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RFe5mANEdJaN6HYGQ0mLltG2ifywrVncOqwrmHC3J0k=;
	b=bXVCSMs6hu6ms1lEuaun4+Z+fRW54PKi/A4122lnk4TJhSEwriT3Q4XgjSLxy2/VgqqcMF
	zThl0sj1D5+nLJiIDyBaIn+32RIp/NAHvXavxNNB9snQFQBU/tEDBPJ4I96oMfb6P9KdTK
	dC3yXkVIp5ou3ndcqFchT0sWh7SbxoU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721377592;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RFe5mANEdJaN6HYGQ0mLltG2ifywrVncOqwrmHC3J0k=;
	b=UzAhIMRoizZ2Gv6OdAejWncdHh7lMObN1YCe5r0WVEaXWebdW0XCsNl1oAuEMsJvXhBxUu
	AME8AJV4IuFU4yAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6F36A132CB;
	Fri, 19 Jul 2024 08:26:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LXA9GTgjmmauNQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 19 Jul 2024 08:26:32 +0000
Message-ID: <716c2c20-9471-4a37-9a75-c1bed7b30116@suse.de>
Date: Fri, 19 Jul 2024 10:26:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] nvmet: support unbound_wq for RDMA and TCP
To: Ping Gan <jacky_gam_2001@163.com>, hch@lst.de
Cc: ping.gan@dell.com, sagi@grimberg.me, kch@nvidia.com,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <0f15a932-1a42-4c51-a267-3f765866edc4@suse.de>
 <20240719080723.125046-1-jacky_gam_2001@163.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240719080723.125046-1-jacky_gam_2001@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.29 / 50.00];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_TO(0.00)[163.com,lst.de];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[163.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240719_012634_609602_74A4CC9D 
X-CRM114-Status: GOOD (  15.33  )
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

On 7/19/24 10:07, Ping Gan wrote:
>> On 7/19/24 07:31, Christoph Hellwig wrote:
>>> On Wed, Jul 17, 2024 at 05:14:49PM +0800, Ping Gan wrote:
>>>> When running nvmf on SMP platform, current nvme target's RDMA and
>>>> TCP use bounded workqueue to handle IO, but when there is other high
>>>> workload on the system(eg: kubernetes), the competition between the
>>>> bounded kworker and other workload is very radical. To decrease the
>>>> resource race of OS among them, this patchset will enable unbounded
>>>> workqueue for nvmet-rdma and nvmet-tcp; besides that, it can also
>>>> get some performance improvement. And this patchset bases on
>>>> previous
>>>> discussion from below session.
>>>
>>> So why aren't we using unbound workqueues by default?  Who makea the
>>> policy decision and how does anyone know which one to chose?
>>>
>> I'd be happy to switch to unbound workqueues per default.
>> It actually might be a left over from the various workqueue changes;
>> at one point 'unbound' meant that effectively only one CPU was used
>> for the workqueue, and you had to remove the 'unbound' parameter to
>> have the workqueue run on all CPUs. That has since changed, so I guess
>> switching to unbound per default is the better option here.
> 
> I don't fully understand what you said 'by default'. Did you mean we
> should just remove 'unbounded' parameter and create workqueue by
> WQ_UNBOUND flag or besides that, we should also add other parameter
> to switch 'unbounded' workqueue  to 'bounded' workqueue?
> 
The former. Just remove the 'unbounded' parameter and always us
'WQ_UNBOUND' flag when creating workqueues.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


