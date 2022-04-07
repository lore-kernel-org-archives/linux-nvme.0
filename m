Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E849C433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Apr 2022 14:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:Subject:From:References:Cc:To:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T4p2HyLQZ/DHHFd9glCN7dYhahkq9kZDk7uvClpKOw0=; b=gE3/Xk79p7B+WBz2Vk3xzbN1dI
	qfaKkO5ZowUuJ0NV+8EqrzXCbQYWeLj7NcwEeP/yO35gtd8ASNQmIsuK9pX1LM35j5ss0iEhKCzjM
	YrNpclAneHbrZVdXSp/wE4/fgDVirDBWcOuGc7bqHNPWWMzOA7M2nCdWqJjmQyUra+I+uN6sfdOTR
	Mvrym+bpi7E2E0tV7vgCeIbmWIwU+tFsMRAgFjUoH+87gehj9jxn3Vj0ofUgSVexLwtxZLJ/xd7iF
	P/qHrGERPFtv0kZe3eEf1IgrrIWSODBs88pteh/pgp7D12y6UY8yjfw9SHOlaBkKe7qF772Xqy/Zm
	mw4YLv2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ncTTw-00CUyZ-O0; Thu, 07 Apr 2022 14:51:32 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ncTTt-00CUwp-UO
 for linux-nvme@lists.infradead.org; Thu, 07 Apr 2022 14:51:31 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A3735210DD;
 Thu,  7 Apr 2022 14:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1649343088; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T4p2HyLQZ/DHHFd9glCN7dYhahkq9kZDk7uvClpKOw0=;
 b=GBJ8iCMAoursng7cZMBAzSyZxjIGyiqocuupnDcfRswEIhr3PkqeogKu9g73JcoT3uk8QT
 dG16OdJhEFfJG+XN+dlyNrTHiegRWerEajt7SQLPfXsVnReKEFbORvHZ+3gJepaXrt+a/g
 PohSMNGCJgYgQk3SSCvfaM1lhfYRp2A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1649343088;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T4p2HyLQZ/DHHFd9glCN7dYhahkq9kZDk7uvClpKOw0=;
 b=R2AHi9l016+QCggTMuqKJBAC9wgu2Yf966xGXQpB57ORK/OSvSOa5X6DQoS8GLxzLIdtxQ
 lZdD2INdTN6xC1Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8A69F13485;
 Thu,  7 Apr 2022 14:51:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kVlAIXD6TmKgXgAAMHmgww
 (envelope-from <hare@suse.de>); Thu, 07 Apr 2022 14:51:28 +0000
Message-ID: <e5225486-6fd9-2bdf-3aa5-540e7e3fa429@suse.de>
Date: Thu, 7 Apr 2022 16:51:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20220407104808.29007-1-hare@suse.de>
 <20220407104808.29007-4-hare@suse.de>
 <81dd2585-3c71-370f-70da-302072f3e9af@grimberg.me>
 <f28bed4d-a5a5-b1e4-020e-c76ded479c5b@suse.de>
 <f7f1e537-ed14-5ed9-4274-ab60f18dce60@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 3/3] nvmet: include all configured ports in the discovery
 log page
In-Reply-To: <f7f1e537-ed14-5ed9-4274-ab60f18dce60@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220407_075130_153666_F8B4880F 
X-CRM114-Status: GOOD (  17.44  )
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

On 4/7/22 15:38, Sagi Grimberg wrote:
> 
>>>> When a per-port discovery subsystem is used we should include
>>>> all configured ports in the discovery log page, not just that one
>>>> through which the controller was connected.
>>>
>>> Why?
>>>
>> Because that's the whole point if it being configurable.
> 
> Maybe I'm missing something. It is one thing to allow configurable
> discovery NQNs, it is another thing to have discovery subsystems that
> are producing a log page about all connected ports.
>

Not all connected ports. All ports which have the _same_ discovery 
subsystem configured.

- /
   o- ports
   | o- 1 .. [trtype=tcp, traddr=127.0.0.1, trsvcid=8009]
   | | o- subsystems
   | |   o- nqn.discovery
   | o- 2 .. [trtype=tcp, traddr=127.0.0.1, trsvcid=4420]
   | | o- subsystems
   | |   o- nqn.discovery
   | |   o- nqn.io-1
   | o- 3 .. [trtype=tcp, traddr=127.0.0.1, trsvcid=4421]
   |   o- subsystems
   |     o- nqn.io-2
   o- subsystems
     o- nqn.discovery
     o- nqn.io-1
     | o- namespaces
     |   o- 1  [path=/tmp/ns1]
     |   o- 2  [path=/tmp/ns2]
     o- nqn.io-2
       o- namespaces
         o- 1  [path=/tmp/ns3]
         o- 2  [path=/tmp/ns4]

Here a discovery on port 8009 will print information about
- nqn.discovery at port 8009
- nqn.discovery at port 4420
- nqn.io-1 at port 4420
Discovery on port 4420 will get the same information, and discovery on 
port 4421 will return information about
- standard discovery subsyste on port 4421
- nqn.io-2 on port 4421

That's what I meant with 'configurable': you can define which 
information gets returned from which port.

> I suggest that if we want to have discovery subsystems that will
> produce entries on different ports, the log page content needs to be
> programmed explicitly in some form. Doing that is going to produce
> routing issues for sure (subnets, vlans, etc etc etc will cause hosts
> to get log entries for subsystems they can't connect to).

But this is nothing new, and in fact there are subsystem out there which 
_do_ provide log pages containing information about _all_ connected 
ports, even for different transport protocols.
And nvme-cli is already fixed up because of this.

But the whole point is that it _is_ configurable. If you don't want 
invalid entries, fine, configure it to not display potential invalid 
entries. The model allows you to create individual discovery subsystem 
for every port, simulating existing behaviour.
Or configure different discovery subsystem, and link them only to ports 
of the same type. Or same VLAN. Or whatever you care to.
Why should we restrict the choices here?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

