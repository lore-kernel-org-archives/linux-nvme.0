Return-Path: <SRS0=7cDU=PR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC9FBC433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Oct 2021 10:32:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABAE161051
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Oct 2021 10:32:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ABAE161051
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aUs7KCBU+tsQHW325os3DK1eUq5OiStVr/dlguKlEuY=; b=uG6m1QF/vZLvi2C6sdGJqfaH+J
	Zyt/kTYFoDKMaeSYYsxsbFI/ZGvqeIEdhLw+swtgbo/hm4dd0a65TP7sZEupTzRUKu2cSsY1+JlHW
	i9P7cnNkF69NoOdopTmwwc6cOa3IWg3Dr7NF92vvr22Echj6fnBoj9eD8F+QfCemJ8ud9NsD6vT42
	t3t4DFe6PgatQAldFOWO4KVcMlMK5zhv8sp9pyxG1aVAnwM/naGeA1UG6T6KgO5L9pWn09C/ZxSss
	lXx0b9MEnO05DwcXIxnqnnkzm/2hoQipBK83lhUpR6HGZSRfkoTbXz7S+6IHOi6qK7s1+OgHF3Pnh
	jXJh2ehQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mgPBf-00Abrf-9U; Fri, 29 Oct 2021 10:32:39 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mgPBc-00Abp8-6V
 for linux-nvme@lists.infradead.org; Fri, 29 Oct 2021 10:32:37 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7FA39212C9;
 Fri, 29 Oct 2021 10:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1635503550; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aUs7KCBU+tsQHW325os3DK1eUq5OiStVr/dlguKlEuY=;
 b=NXF7OZJP236cyBpoxCaN88Ewk0SyE89dhC5TUPsb5kBqJB0o9h2wZdL3HCZGfgWBdtlGkp
 a7EfN8So56h9k9LrRV1CNntJdFXcbKlKvr+reeh9VINcSVomx0E+fpFs4+XevnMlASMKGe
 1Lxq8txWNJ7IT3CWp8WorsnSHmapzLo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1635503550;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aUs7KCBU+tsQHW325os3DK1eUq5OiStVr/dlguKlEuY=;
 b=qWm/6uJNLIiTSej22eKsbOtM3M3rHVk/xu/FDrxjYegLst1BK4BE84YkvlZ51otMSlVtjX
 9TwAnzoEE7yTCdCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7037413BBE;
 Fri, 29 Oct 2021 10:32:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id KzcgG77Ne2E2TAAAMHmgww
 (envelope-from <hare@suse.de>); Fri, 29 Oct 2021 10:32:30 +0000
Subject: Re: [GIT PULL] second round of nvme updates for Linux 5.16
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <YXqzb6dj0DCrIbGY@infradead.org>
 <9684ed24-532d-952a-a478-5388a9da1bbc@suse.de>
Message-ID: <67eabdb1-6e34-33ec-602a-8a524f32624d@suse.de>
Date: Fri, 29 Oct 2021 12:32:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <9684ed24-532d-952a-a478-5388a9da1bbc@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211029_033236_418306_A1762985 
X-CRM114-Status: GOOD (  15.75  )
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

On 10/29/21 12:19 PM, Hannes Reinecke wrote:
> On 10/28/21 4:27 PM, Christoph Hellwig wrote:
>> The following changes since commit d28e4dff085c5a87025c9a0a85fb798bd8e9ca17:
>>
>>   block: ataflop: more blk-mq refactoring fixes (2021-10-25 07:54:32 -0600)
>>
>> are available in the Git repository at:
>>
>>   git://git.infradead.org/nvme.git tags/nvme-5.16-2021-10-28
>>
>> for you to fetch changes up to d156cfcafbd0eae4224ea007d95ebda467eb0c46:
>>
>>   nvmet: use flex_array_size and struct_size (2021-10-27 08:06:41 +0200)
>>
>> ----------------------------------------------------------------
>> nvme updates for Linux 5.16
>>
>>  - support the current discovery subsystem entry (Hannes Reinecke)
>>  - use flex_array_size and struct_size (Len Baker)
>>
>> ----------------------------------------------------------------
>> Hannes Reinecke (3):
>>       nvme: add new discovery log page entry definitions
>>       nvmet: switch check for subsystem type
>>       nvmet: register discovery subsystem as 'current'
>>
>> Len Baker (1):
>>       nvmet: use flex_array_size and struct_size
>>
>>  drivers/nvme/host/multipath.c   |  2 +-
>>  drivers/nvme/target/admin-cmd.c |  2 +-
>>  drivers/nvme/target/core.c      |  1 +
>>  drivers/nvme/target/discovery.c | 17 +++++++++++------
>>  drivers/nvme/target/nvmet.h     |  2 +-
>>  include/linux/nvme.h            | 19 ++++++++++++++++---
>>  6 files changed, 31 insertions(+), 12 deletions(-)
>>
> This one hangs at boot for me:
> 
> [  220.294358] Code: ef e8 61 25 3e 00 3b 05 3f c1 5d 01 89 c5 73 24 48
> 63 c5 49 8b 7d 00 48 03 3c c5 c0 0a 20 82 66 90 8b 47 08 a8 01 74 0a f3
> 90 <8b> 57 08 83 e2 01 75 f6 eb c7 48 83 c4 48 5b 5d 41 5c 41 5d 41 5e
> [  220.297931] RSP: 0018:ffffc900011ebd20 EFLAGS: 00000202
> [  220.299181] RAX: 0000000000000011 RBX: 0000000000000001 RCX:
> 0000000000000000
> [  220.300656] RDX: 0000000000000001 RSI: 0000000000000000 RDI:
> ffff88827fc32d40
> [  220.302126] RBP: 0000000000000000 R08: 0000000000000000 R09:
> 0000000000000000
> [  220.303603] R10: 0000000000000000 R11: 0000000000000000 R12:
> ffff88827fdec040
> [  220.305052] R13: ffff88827fdec040 R14: 0000000000000000 R15:
> 0000000000000006
> [  220.306509] FS:  0000000000000000(0000) GS:ffff88827fdc0000(0000)
> knlGS:0000000000000000
> [  220.308074] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  220.309338] CR2: 00005644f553dcd8 CR3: 000000010392e000 CR4:
> 0000000000350ee0
> [  220.310777] Call Trace:
> [  220.311655]  ? __flush_tlb_all+0x30/0x30
> [  220.312686]  on_each_cpu_cond_mask+0x1e/0x20
> [  220.313776]  __purge_vmap_area_lazy+0xbc/0x6d0
> [  220.314887]  ? __cond_resched+0x15/0x40
> [  220.315921]  ? vunmap_range_noflush+0x3fc/0x4b0
> [  220.317024]  ? cpumask_next+0x1f/0x30
> [  220.318002]  ? purge_fragmented_blocks_allcpus+0x51/0x1d0
> [  220.319235]  _vm_unmap_aliases.part.50+0xdf/0x110
> [  220.320356]  __vunmap+0x11d/0x250
> [  220.321301]  do_free_init+0x26/0x50
> [  220.322266]  process_one_work+0x231/0x420
> [  220.323304]  ? process_one_work+0x420/0x420
> [  220.324352]  worker_thread+0x2d/0x3f0
> [  220.325346]  ? process_one_work+0x420/0x420
> [  220.326400]  kthread+0x11a/0x140
> [  220.327362]  ? set_kthread_struct+0x40/0x40
> [  220.328413]  ret_from_fork+0x22/0x30
> 
> Known issue?
> 
Using
kernel/git/axboe/linux-block.git for-next
works.

Just so that you know :-)

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

