Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69127C433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Apr 2022 13:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dKLoZSBw0o9mQYz4/QvQEZ+IwGTCXcYrJ1wK6HCdZSs=; b=2KDfSLMrwvYUx0hUZP+l8iSF7S
	ARjrT+ic1lroovRFqpcXhCeBZv1unAiI1TYiY9sjW3l0vx7SspopoWyFmUQcITcN3fkaTquxzHhhn
	LteS5n0SzVj1qt/+tawGUP+1MB8zBaMtDP9CaiDMeCjSNAduunuL2RsNHQFUNSTkG/N6kl7ghTqmw
	KFPrLfzh0rmZAUH2v4lJPUxfaNL0i7NwFMW15C7C3c/gblPfVDVyL/4z8o9Vf6sRxldRFEQODS/n1
	WUsR0xlsnfG85BWaadY06KXDveh3cEfulyJdP64i+2UBPcKApVTICFMlpxdkctQXi0rc4shOBUVoi
	Ky2s/+Zw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ncSF2-00C9Ng-9C; Thu, 07 Apr 2022 13:32:04 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ncSEv-00C9Ir-Fw
 for linux-nvme@lists.infradead.org; Thu, 07 Apr 2022 13:31:58 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6CA0E212B7;
 Thu,  7 Apr 2022 13:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1649338312; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dKLoZSBw0o9mQYz4/QvQEZ+IwGTCXcYrJ1wK6HCdZSs=;
 b=JvY1RVMHathl6B2Esyr7Eaq38mqvvwFq6BwQA5cK1ujFspbW8CgQ9gsPPibJRpY2DoL1hl
 v6k1+Gbzpgr7dhLFzwGUKQKnVrv+vw2NQwMbNJgh3XAeWVYyhUS2k95+lyS8S9ytIckls/
 leu4YBhiNYR14DymcOQel/46ERNRqVQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1649338312;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dKLoZSBw0o9mQYz4/QvQEZ+IwGTCXcYrJ1wK6HCdZSs=;
 b=r1VoHNwBzzZxx+1bjYA13dXAp13huSLRw76SnAfu+hTu93F4Jn6zRwDcfGdS39ZQXPpauV
 zlvthCYMZBoIdHDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5E16313A66;
 Thu,  7 Apr 2022 13:31:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 9rqiFsjnTmJ6NQAAMHmgww
 (envelope-from <hare@suse.de>); Thu, 07 Apr 2022 13:31:52 +0000
Message-ID: <f28bed4d-a5a5-b1e4-020e-c76ded479c5b@suse.de>
Date: Thu, 7 Apr 2022 15:31:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 3/3] nvmet: include all configured ports in the discovery
 log page
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20220407104808.29007-1-hare@suse.de>
 <20220407104808.29007-4-hare@suse.de>
 <81dd2585-3c71-370f-70da-302072f3e9af@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <81dd2585-3c71-370f-70da-302072f3e9af@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220407_063157_710646_D4A2E776 
X-CRM114-Status: UNSURE (   9.62  )
X-CRM114-Notice: Please train this message.
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

On 4/7/22 15:29, Sagi Grimberg wrote:
> 
>> When a per-port discovery subsystem is used we should include
>> all configured ports in the discovery log page, not just that one
>> through which the controller was connected.
> 
> Why?
> 
Because that's the whole point if it being configurable.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

