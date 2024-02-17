Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA6D2C48BC3
	for <linux-nvme@archiver.kernel.org>; Sat, 17 Feb 2024 16:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TJxXm93B4TylDx6ccg8wI9mx1ojU/+4+CK/noqwvyTw=; b=h/VEZf9hU71Yvp+pKKi80gCfCk
	lPkG6JK49Wkf1QJtclsSTnu/BvDASJ596t4zRv6PXelKLg1qYKlaOlufZ4b8PeQ7QnArj59ej0vEH
	tTQs1y024RTGhCtEJdFkxDP3sF4cO1vk3SnnaJYzl2s8wWwJf/OV7J6RtdWW0kFIdmslM/E3lMTMx
	XYBHkl9V4aiFbSTSfix2dma2NCWsnXgJovxzeN6W6VhJ/220JbvZKlG23VPZBYR5IZzg8oeYnZwaa
	U40Rfk+SJmyob2JphU9jJWuHHTpHQ3cvVEcl6dUPs3CaxVIPg2CXwrJTFBuACzSp6SdB4CXgI50NH
	NYDvnePw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rbNXr-000000060NI-1Go9;
	Sat, 17 Feb 2024 16:28:07 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rbNXg-000000060L0-41Uw
	for linux-nvme@lists.infradead.org;
	Sat, 17 Feb 2024 16:28:01 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DF20921D9E;
	Sat, 17 Feb 2024 16:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708187273; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TJxXm93B4TylDx6ccg8wI9mx1ojU/+4+CK/noqwvyTw=;
	b=rRlVwqaUCpU+ro9h2l8ZGWIcI72iQu6hS2ZFe6EU6kXOorHlgo+1a3n9gV+shkBwkE3/oG
	D1BaSyQYDVMFaMTGKbozuI1OPqKpJRQ8EbvSTLGVIP7hW6Z8RDWS3DDNSg9O4MBiLR8r8h
	mK2O1D/BBqbDxPFrgewJCthYLPBTxsE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708187273;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TJxXm93B4TylDx6ccg8wI9mx1ojU/+4+CK/noqwvyTw=;
	b=kX+pPaL+NON4+xQUmqJhAderwQMAMvd8v8d4ZgHn46ktmS/OsXs1x4hQcowzBVw4JVO3Vw
	EpKzQxRUM8JAz+Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708187272; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TJxXm93B4TylDx6ccg8wI9mx1ojU/+4+CK/noqwvyTw=;
	b=TB9IPE0woCndtgdcaIgUMPb78NFMvXm9rCbFVWXDFIDkGjHcAFYeVlBSJnK51OLbEHgXf4
	RHUvqTLZN+zrwvqsqRgracW1TDluP9S0t8BmJHZ6B4Erq1VkwreTDr6vbNfktrffw61D+s
	1NNjGa8HZ6HZpgUIfg8/p4VUEOD0dn8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708187272;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TJxXm93B4TylDx6ccg8wI9mx1ojU/+4+CK/noqwvyTw=;
	b=n1CWji/rQ3qGCxxuz1PyppZv4vgwptF7gknFMs8RycqEz1lkyZC2pXVHRfpLxRbLtEi8p4
	pEhX5LYCKsuWaiCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E00A1370C;
	Sat, 17 Feb 2024 16:27:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id veJLHIje0GVDYwAAD6G6ig
	(envelope-from <hare@suse.de>); Sat, 17 Feb 2024 16:27:52 +0000
Message-ID: <0bd86557-c2da-42d0-9ad8-021c3f4fbd8f@suse.de>
Date: Sat, 17 Feb 2024 17:27:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v0 1/6] nvme-fabrics: introduce connect_sync option
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Daniel Wagner <dwagner@suse.de>
Cc: James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240216084526.14133-1-dwagner@suse.de>
 <20240216084526.14133-2-dwagner@suse.de> <20240216094909.GA19961@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240216094909.GA19961@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TB9IPE0w;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="n1CWji/r"
X-Spamd-Result: default: False [-3.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: DF20921D9E
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240217_082757_308840_2A05AF9F 
X-CRM114-Status: GOOD (  18.13  )
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

On 2/16/24 10:49, Christoph Hellwig wrote:
> On Fri, Feb 16, 2024 at 09:45:21AM +0100, Daniel Wagner wrote:
>> The TCP and RDMA transport are doing a synchronous connect, meaning the
>> syscal returns with the final result, that is. it either failed or
>> succeeded.
>>
>> This isn't the case for FC. This transport just setups and triggers
>> the connect and returns without waiting on the result.
> 
> That's really weird and unexpected.  James, can you explain the reason
> behind this?
> 
Reason is that the initial connect attempt might fail with an temporary 
failure, and will need to be retried. And rather than implementing two 
methods for handling this (one for the initial connect, and another one
for reconnect where one _has_ to use a workqueue) as eg TCP and RDMA
has implemented it FC is using a single code path for handling both.

Temporary failure on initial connect is far more likely on FC than on
other transports due to the way how FC-NVMe is modelled; essentially
one has to log into the remote port for each protocol. So if you run
in a dual fabric (with both FCP and NVMe) you'll need to log into the
same remote port twice. Depending on the implementation the target might 
only be capable of handling one port login at the same time, so the
other one will be failed with a temporary error.
That's why it's a common issue with FC. It _might_ happen with TCP, too,
but apparently not regularly otherwise we would have seen quite some
failures here; TCP can't really handle temporary failures for the
initial connect.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


