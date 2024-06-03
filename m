Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49028C25B76
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Jun 2024 07:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a2bJzNeQZky846Z95Ej0BchOIVdohOw0oxASksp4Yl8=; b=h/Jzdp3lyNusPp6qElS/K93VFK
	Dt7+VOaQAnk5n2FioXGB/vVex9lIyg9QoF9wOd8yT0z3Hx9AG6qNplPBJwqFxBHXv0My415DplVnw
	QXx7+qJ1WYI+MhbRlZ4nWyGD3WZSITl8M3x4cq4OVvFAaF5hjwg6TryBgsUo1x2oORVzn1g5pvJrB
	EOqgVO1+LIbPqlujZ88pYzWKx1tPLGNHNXVD5Kra+FD351r2maQEZ1s8xpOwxCRSwyMwE8H/EMcOa
	6/X3kHFTTJTkJMOh7F5qKu2sZsNXmslKINhVim4uFntiV2axI+ZLNPFt2e3bucA67Fi7MFlPyFhOB
	5/Yj3YLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sE23Q-0000000Ft9t-0F1g;
	Mon, 03 Jun 2024 07:24:28 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sE23M-0000000Ft92-0VvX
	for linux-nvme@lists.infradead.org;
	Mon, 03 Jun 2024 07:24:26 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0DF0322022;
	Mon,  3 Jun 2024 07:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717399462; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a2bJzNeQZky846Z95Ej0BchOIVdohOw0oxASksp4Yl8=;
	b=sugloF5mBdeWecoYHgF8TGh7vlr1CEtoloFQYrjNC/OlNvSVvT+WgJT5BP0O+2Vnqtxrw6
	lvaxWXtOfFOZjlWRqLoyUgjQusz2PtOmv0Ik8zoX/fRqe8yvIzsGyYTONFBDvW5PaBkMS+
	lmwkvTdVjyiIaOwV7noCvJ49cPOzNvI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717399462;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a2bJzNeQZky846Z95Ej0BchOIVdohOw0oxASksp4Yl8=;
	b=CTY+7GjceMZK2XjTs4KMn213TTSY0EbbTZlcUqarQ/NoclaH3EiRsJZkv+aoLa+EeOXWlW
	iI4C7u7KRGF5wUDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=sugloF5m;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=CTY+7Gjc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717399462; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a2bJzNeQZky846Z95Ej0BchOIVdohOw0oxASksp4Yl8=;
	b=sugloF5mBdeWecoYHgF8TGh7vlr1CEtoloFQYrjNC/OlNvSVvT+WgJT5BP0O+2Vnqtxrw6
	lvaxWXtOfFOZjlWRqLoyUgjQusz2PtOmv0Ik8zoX/fRqe8yvIzsGyYTONFBDvW5PaBkMS+
	lmwkvTdVjyiIaOwV7noCvJ49cPOzNvI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717399462;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a2bJzNeQZky846Z95Ej0BchOIVdohOw0oxASksp4Yl8=;
	b=CTY+7GjceMZK2XjTs4KMn213TTSY0EbbTZlcUqarQ/NoclaH3EiRsJZkv+aoLa+EeOXWlW
	iI4C7u7KRGF5wUDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3D9C5139CB;
	Mon,  3 Jun 2024 07:24:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MEAvC6VvXWa1VwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 03 Jun 2024 07:24:21 +0000
Message-ID: <a3fac93a-af2b-4969-8ab5-302089cdb3a6@suse.de>
Date: Mon, 3 Jun 2024 09:24:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] bugfix: Introduce sendpages_ok() to check
 sendpage_ok() on contiguous pages
Content-Language: en-US
To: Ofir Gal <ofir.gal@volumez.com>, davem@davemloft.net,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, ceph-devel@vger.kernel.org
Cc: dhowells@redhat.com, edumazet@google.com, pabeni@redhat.com,
 kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
 christoph.boehmwalder@linbit.com, idryomov@gmail.com, xiubli@redhat.com
References: <20240530142417.146696-1-ofir.gal@volumez.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240530142417.146696-1-ofir.gal@volumez.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 0DF0322022
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,google.com,kernel.org,kernel.dk,lst.de,grimberg.me,linbit.com,gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240603_002424_439971_C33030AE 
X-CRM114-Status: GOOD (  32.84  )
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

On 5/30/24 16:24, Ofir Gal wrote:
> skb_splice_from_iter() warns on !sendpage_ok() which results in nvme-tcp
> data transfer failure. This warning leads to hanging IO.
> 
> nvme-tcp using sendpage_ok() to check the first page of an iterator in
> order to disable MSG_SPLICE_PAGES. The iterator can represent a list of
> contiguous pages.
> 
> When MSG_SPLICE_PAGES is enabled skb_splice_from_iter() is being used,
> it requires all pages in the iterator to be sendable.
> skb_splice_from_iter() checks each page with sendpage_ok().
> 
> nvme_tcp_try_send_data() might allow MSG_SPLICE_PAGES when the first
> page is sendable, but the next one are not. skb_splice_from_iter() will
> attempt to send all the pages in the iterator. When reaching an
> unsendable page the IO will hang.
> 
> The patch introduces a helper sendpages_ok(), it returns true if all the
> continuous pages are sendable.
> 
> Drivers who want to send contiguous pages with MSG_SPLICE_PAGES may use
> this helper to check whether the page list is OK. If the helper does not
> return true, the driver should remove MSG_SPLICE_PAGES flag.
> 
> 
> The bug is reproducible, in order to reproduce we need nvme-over-tcp
> controllers with optimal IO size bigger than PAGE_SIZE. Creating a raid
> with bitmap over those devices reproduces the bug.
> 
> In order to simulate large optimal IO size you can use dm-stripe with a
> single device.
> Script to reproduce the issue on top of brd devices using dm-stripe is
> attached below.
> 
> 
> I have added 3 prints to test my theory. One in nvme_tcp_try_send_data()
> and two others in skb_splice_from_iter() the first before sendpage_ok()
> and the second on !sendpage_ok(), after the warning.
> ...
> nvme_tcp: sendpage_ok, page: 0x654eccd7 (pfn: 120755), len: 262144, offset: 0
> skbuff: before sendpage_ok - i: 0. page: 0x654eccd7 (pfn: 120755)
> skbuff: before sendpage_ok - i: 1. page: 0x1666a4da (pfn: 120756)
> skbuff: before sendpage_ok - i: 2. page: 0x54f9f140 (pfn: 120757)
> WARNING: at net/core/skbuff.c:6848 skb_splice_from_iter+0x142/0x450
> skbuff: !sendpage_ok - page: 0x54f9f140 (pfn: 120757). is_slab: 1, page_count: 1
> ...
> 
> 
> stack trace:
> ...
> WARNING: at net/core/skbuff.c:6848 skb_splice_from_iter+0x141/0x450
> Workqueue: nvme_tcp_wq nvme_tcp_io_work
> Call Trace:
>   ? show_regs+0x6a/0x80
>   ? skb_splice_from_iter+0x141/0x450
>   ? __warn+0x8d/0x130
>   ? skb_splice_from_iter+0x141/0x450
>   ? report_bug+0x18c/0x1a0
>   ? handle_bug+0x40/0x70
>   ? exc_invalid_op+0x19/0x70
>   ? asm_exc_invalid_op+0x1b/0x20
>   ? skb_splice_from_iter+0x141/0x450
>   tcp_sendmsg_locked+0x39e/0xee0
>   ? _prb_read_valid+0x216/0x290
>   tcp_sendmsg+0x2d/0x50
>   inet_sendmsg+0x43/0x80
>   sock_sendmsg+0x102/0x130
>   ? vprintk_default+0x1d/0x30
>   ? vprintk+0x3c/0x70
>   ? _printk+0x58/0x80
>   nvme_tcp_try_send_data+0x17d/0x530
>   nvme_tcp_try_send+0x1b7/0x300
>   nvme_tcp_io_work+0x3c/0xc0
>   process_one_work+0x22e/0x420
>   worker_thread+0x50/0x3f0
>   ? __pfx_worker_thread+0x10/0x10
>   kthread+0xd6/0x100
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork+0x3c/0x60
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork_asm+0x1b/0x30
> ...
> 
> ---
> Changelog:
> v2, fix typo in patch subject
> 
> Ofir Gal (4):
>    net: introduce helper sendpages_ok()
>    nvme-tcp: use sendpages_ok() instead of sendpage_ok()
>    drbd: use sendpages_ok() to instead of sendpage_ok()
>    libceph: use sendpages_ok() to instead of sendpage_ok()
> 
>   drivers/block/drbd/drbd_main.c |  2 +-
>   drivers/nvme/host/tcp.c        |  2 +-
>   include/linux/net.h            | 20 ++++++++++++++++++++
>   net/ceph/messenger_v1.c        |  2 +-
>   net/ceph/messenger_v2.c        |  2 +-
>   5 files changed, 24 insertions(+), 4 deletions(-)
> 
>   reproduce.sh | 114 +++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 114 insertions(+)
>   create mode 100755 reproduce.sh
> 
> diff --git a/reproduce.sh b/reproduce.sh
> new file mode 100755
> index 000000000..8ae226b18
> --- /dev/null
> +++ b/reproduce.sh
> @@ -0,0 +1,114 @@
> +#!/usr/bin/env sh
> +# SPDX-License-Identifier: MIT
> +
> +set -e
> +
> +load_modules() {
> +    modprobe nvme
> +    modprobe nvme-tcp
> +    modprobe nvmet
> +    modprobe nvmet-tcp
> +}
> +
> +setup_ns() {
> +    local dev=$1
> +    local num=$2
> +    local port=$3
> +    ls $dev > /dev/null
> +
> +    mkdir -p /sys/kernel/config/nvmet/subsystems/$num
> +    cd /sys/kernel/config/nvmet/subsystems/$num
> +    echo 1 > attr_allow_any_host
> +
> +    mkdir -p namespaces/$num
> +    cd namespaces/$num/
> +    echo $dev > device_path
> +    echo 1 > enable
> +
> +    ln -s /sys/kernel/config/nvmet/subsystems/$num \
> +        /sys/kernel/config/nvmet/ports/$port/subsystems/
> +}
> +
> +setup_port() {
> +    local num=$1
> +
> +    mkdir -p /sys/kernel/config/nvmet/ports/$num
> +    cd /sys/kernel/config/nvmet/ports/$num
> +    echo "127.0.0.1" > addr_traddr
> +    echo tcp > addr_trtype
> +    echo 8009 > addr_trsvcid
> +    echo ipv4 > addr_adrfam
> +}
> +
> +setup_big_opt_io() {
> +    local dev=$1
> +    local name=$2
> +
> +    # Change optimal IO size by creating dm stripe
> +    dmsetup create $name --table \
> +        "0 `blockdev --getsz $dev` striped 1 512 $dev 0"
> +}
> +
> +setup_targets() {
> +    # Setup ram devices instead of using real nvme devices
> +    modprobe brd rd_size=1048576 rd_nr=2 # 1GiB
> +
> +    setup_big_opt_io /dev/ram0 ram0_big_opt_io
> +    setup_big_opt_io /dev/ram1 ram1_big_opt_io
> +
> +    setup_port 1
> +    setup_ns /dev/mapper/ram0_big_opt_io 1 1
> +    setup_ns /dev/mapper/ram1_big_opt_io 2 1
> +}
> +
> +setup_initiators() {
> +    nvme connect -t tcp -n 1 -a 127.0.0.1 -s 8009
> +    nvme connect -t tcp -n 2 -a 127.0.0.1 -s 8009
> +}
> +
> +reproduce_warn() {
> +    local devs=$@
> +
> +    # Hangs here
> +    mdadm --create /dev/md/test_md --level=1 --bitmap=internal \
> +        --bitmap-chunk=1024K --assume-clean --run --raid-devices=2 $devs
> +}
> +
> +echo "###################################
> +
> +The script creates 2 nvme initiators in order to reproduce the bug.
> +The script doesn't know which controllers it created, choose the new nvme
> +controllers when asked.
> +
> +###################################
> +
> +Press enter to continue.
> +"
> +
> +read tmp
> +
> +echo "# Creating 2 nvme controllers for the reproduction. current nvme devices:"
> +lsblk -s | grep nvme || true
> +echo "---------------------------------
> +"
> +
> +load_modules
> +setup_targets
> +setup_initiators
> +
> +sleep 0.1 # Wait for the new nvme ctrls to show up
> +
> +echo "# Created 2 nvme devices. nvme devices list:"
> +
> +lsblk -s | grep nvme
> +echo "---------------------------------
> +"
> +
> +echo "# Insert the new nvme devices as separated lines. both should be with size of 1G"
> +read dev1
> +read dev2
> +
> +ls /dev/$dev1 > /dev/null
> +ls /dev/$dev2 > /dev/null
> +
> +reproduce_warn /dev/$dev1 /dev/$dev2

Can you convert that into a blktest script?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


