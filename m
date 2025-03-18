Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28AF5C282EC
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Mar 2025 14:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B/xUux8hjiOO8U26Ls00JNmFpkG+FZvjBFLklhjAXp0=; b=EyAJNhPcNQwaWOaWoHu4Nd4uSd
	/HvktXxwZmRmLvPI9x/c0XRqG3yCQEB/2y8uUEEOFU1O4Sl7tq9HIdfBQhMxClHDgSO2eDfGmA+k6
	ZRFa4d/BZTDcsuQ0aLU9K03dRranADdTX7306AV2tMTTrsHNSxtfCffseeE3oKmtHEDiluiJMxR0/
	QUpi4Bwv9Caarsunqu8ZH7wVgrPXcoF53MTMckLpDTbyahatiCyt4G852ZY49ZD2/gctd107TU55d
	dIa36J1Q98EXLJ4YdDcQcX8leHOssqD3/3zQ1+23byBoIqf/Q4Gd/BYcGlzgDAAfd1nJOlmPRXc1k
	aqMfZa6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuXeK-000000068hJ-3lFn;
	Tue, 18 Mar 2025 14:10:32 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuXeJ-000000068fu-0VdA
	for linux-nvme@lists.infradead.org;
	Tue, 18 Mar 2025 14:10:32 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B0B1821940;
	Tue, 18 Mar 2025 14:10:29 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 87E1E1379A;
	Tue, 18 Mar 2025 14:10:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SzbNH9V+2WcJBgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 18 Mar 2025 14:10:29 +0000
Message-ID: <b89fcad1-ed97-4354-9892-14631794d95d@suse.de>
Date: Tue, 18 Mar 2025 15:10:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/18] nvmet-fcloop: refactor fcloop_nport_alloc
To: Daniel Wagner <dwagner@suse.de>
Cc: Daniel Wagner <wagi@kernel.org>, James Smart <james.smart@broadcom.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
 <20250318-nvmet-fcloop-v3-4-05fec0fc02f6@kernel.org>
 <a9055e3c-d36f-4706-9fdc-f4532d14adb6@suse.de>
 <66261f08-5386-4b22-aa6f-7be1d4023fee@flourine.local>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <66261f08-5386-4b22-aa6f-7be1d4023fee@flourine.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: B0B1821940
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250318_071031_304062_96ADA12A 
X-CRM114-Status: GOOD (  17.15  )
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

On 3/18/25 14:38, Daniel Wagner wrote:
> On Tue, Mar 18, 2025 at 12:02:48PM +0100, Hannes Reinecke wrote:
>>> -	list_for_each_entry(tmplport, &fcloop_lports, lport_list) {
>>> -		if (tmplport->localport->node_name == opts->wwnn &&
>>> -		    tmplport->localport->port_name == opts->wwpn)
>>> -			goto out_invalid_opts;
>>> +		INIT_LIST_HEAD(&nport->nport_list);
>>> +		nport->node_name = opts->wwnn;
>>> +		nport->port_name = opts->wwpn;
>>> +		refcount_set(&nport->ref, 1);
>>> -		if (tmplport->localport->node_name == opts->lpwwnn &&
>>> -		    tmplport->localport->port_name == opts->lpwwpn)
>>> -			lport = tmplport;
>>> +		spin_lock_irqsave(&fcloop_lock, flags);
>>> +		list_add_tail(&nport->nport_list, &fcloop_nports);
>>> +		spin_unlock_irqrestore(&fcloop_lock, flags);
>>>    	}
>> Hmm. I don't really like this pattern; there is a race condition
>> between lookup and allocation leading to possibly duplicate entries
>> on the list.
> 
> Yes, that's not a good thing.
> 
>> Lookup and allocation really need to be under the same lock.
> 
> This means the new entry has always to be allocated first and then we
> either free it again or insert into the list, because it's not possible
> to allocate under the spinlock. Not that beautiful but correctness wins.
Allocate first, and then free it if the entry is already present.
Slightly wasteful, but that's what it is.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

