Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4292C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Mar 2022 17:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TonIuU77rzWz6aKiT520rRTKo7KTSDufsee9pFn6qrQ=; b=tBqQ5VlA4AJYC+gF+yOHFexIEj
	yUy/bBYFmP1pjs4IcZHP+BCJ9fo5Y3RrGe8zQnwEpd3V6+gXkssDwS5sB8Pwm4zulnXZH6c5U/iHC
	bBjwH1wNKVz6Ha6mHD/sEyTmNhWIaB9WnrM8nmWdQwDR3Yyzb/8QfQidTOGHV6nMV2zNzDhFGhshP
	vIKhRg/PNgNAzwOPxCT7cpVcjeLC422ctjKzCWCC+KKFIVEO4wXkxKETnZP5GRaX3eL5qni1YYoUK
	gC5JuAhffedCXPj/DGFw2bK2rZuPZ72q1uMu8ZHoAugvrNEPYk3evtHw+pZ6gAy4XTnTZYHLAvlYU
	SK8nQOeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nX4an-00EO7P-QA; Wed, 23 Mar 2022 17:16:17 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nX4ak-00EO5o-GC
 for linux-nvme@lists.infradead.org; Wed, 23 Mar 2022 17:16:16 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9898F1F388;
 Wed, 23 Mar 2022 17:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1648055772; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TonIuU77rzWz6aKiT520rRTKo7KTSDufsee9pFn6qrQ=;
 b=dSuxSFiG44s+6kZ+5a3CihqZQE2yZQ8S56vNWCp8jtHVx3ceEl0D65+O5Bh10qRUqqQSr8
 gB/9doGqSoWMBBrDQhQ5ROwUvhhqiK6aFOW7nIeQ3hRHwrL/BY9zCJPAedkCkeeyTAH656
 9Luc2Wc5jCR4Tt7W0EvQxkJf/Ee0yXI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1648055772;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TonIuU77rzWz6aKiT520rRTKo7KTSDufsee9pFn6qrQ=;
 b=8oaed8fxcqNfsaRdyerm6/xIX7rGWgYPadl7Z/oLhIjhlX+etkIOaNjCWobIkj+kYN3HHo
 /C28c7HgaAmW4/DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 773E613302;
 Wed, 23 Mar 2022 17:16:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id vPIdHNxVO2LGHQAAMHmgww
 (envelope-from <hare@suse.de>); Wed, 23 Mar 2022 17:16:12 +0000
Message-ID: <da128051-4d15-1566-2876-5167a0c1d033@suse.de>
Date: Wed, 23 Mar 2022 18:16:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [LSF/MM/BPF TOPIC] dispersed namespaces revisited
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <521666e9-9114-9c2d-c680-a52defb45f8a@suse.de>
 <YjtKYETOnoI6/x4E@infradead.org>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <YjtKYETOnoI6/x4E@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220323_101614_719350_3B96BAEA 
X-CRM114-Status: GOOD (  15.58  )
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

On 3/23/22 17:27, Christoph Hellwig wrote:
> Hi Hannes,
> 
> the answer is pretty simple:  dispersed namespaces are a bad idea and
> will not be implemented in Linux, and this has been the stance since
> this was first proposed.
> 
> If these vendors want Linux support they can already trivially
> implement virtual subsystems and are highly encouraged to do so.
> (the concept of domains actually makes it even simpler than in
> the beginning).

Guess what, that's what I have been proposing.
And they have (somewhat) agreed.

I just wanted to use LSF to get everyone on board, and then be able to 
come with a proposal to NVMexpress which I know will be acceptable from 
the Linux community.

I have a patchset ready implementing virtual subsystems based on the NS 
UUID (and thereby putting each namespace into a separate subsystem).
At this time it's just a PoC to demonstrate the concept; specification 
is not even proposed, and so it's hard to code against.

I can send a pointer to my kernel.org branch if you like.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

