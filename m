Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4A0DEE57DF
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Sep 2023 12:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hxz3tF0raJbCIupGex6TpSrop4jB6quL234IyEN0U2U=; b=OCdYFkSAxu1VS4hibRW3WpjRNP
	Hhs/JVXc0HnU5HhMK1pAZxjGJEF8R1qECuIhR6AWxHgDroZqT9nzPHlMTPX1cXJ7BiNUYa+Ho5E9x
	TgMsBTIvV8Tck0852AU1/fjDaSriDkC3bioYrVxpcYS662AeHRHz+dlqHJd+quh3TT0bothLhmibk
	Yt2u6EHmAj+QeYOwePUC2t9KXsRwua9qGnUEs2ccc8tOrYhkSSwOQBP8Fz+y9vbXFJ5Lk3oYwok7Z
	Asv9Ok64DrbEcjcsRrK2oHyw9TuS79eVSY2p6ggfM1mwtDjlOiTr57SjtnrTRb5xEIrCldbMlOR69
	cv+znmqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qffj8-000S4y-1z;
	Mon, 11 Sep 2023 12:09:14 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qffj5-000S3s-1B
	for linux-nvme@lists.infradead.org;
	Mon, 11 Sep 2023 12:09:12 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4D8D31F893;
	Mon, 11 Sep 2023 12:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1694434148; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hxz3tF0raJbCIupGex6TpSrop4jB6quL234IyEN0U2U=;
	b=mNv2EQHefB5shIXkPBHYSAzymUNO6yaRsn5kZlP17sXvE6iSXHyrIoRUyDG1va+8D2hll0
	8P3qAdjKSgPT91RWiL+ePicFEJGM5+poxBYbv37tG0e3cOsHGF+xHycpQKKSb2EfcKW8I9
	ohJ2iLoZlwb1/OphRe/rd8Ww4Q8Ila4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1694434148;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hxz3tF0raJbCIupGex6TpSrop4jB6quL234IyEN0U2U=;
	b=E87AjngD+k7FUGgB44ztr+zqXSEeuLEWNgYOMe4Z/QQKgfiF4wpGrro5VYzdG8j/IHp+h/
	ytkAD3z6PssyHXDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 297E1139CC;
	Mon, 11 Sep 2023 12:09:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id UrlzCWQD/2RufwAAMHmgww
	(envelope-from <hare@suse.de>); Mon, 11 Sep 2023 12:09:08 +0000
Message-ID: <46878e81-92ba-4624-af7a-c4d620ff524b@suse.de>
Date: Mon, 11 Sep 2023 14:09:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv11 00/18] nvme: In-kernel TLS support for TCP
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
To: Pawel Baldysiak <pawel.baldysiak@dell.com>
Cc: linux-nvme@lists.infradead.org
References: <20230824143925.9098-1-hare@suse.de>
 <20230906084840.3710977-1-pawel.baldysiak@dell.com>
 <0e3fe3f6-3d14-4117-bff7-093b1b2edde2@suse.de>
In-Reply-To: <0e3fe3f6-3d14-4117-bff7-093b1b2edde2@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230911_050911_551541_F92469D9 
X-CRM114-Status: GOOD (  14.68  )
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

On 9/6/23 12:04, Hannes Reinecke wrote:
> On 9/6/23 10:48, Pawel Baldysiak wrote:
>> Hi Hannes,
>>
>> I'm testing v15 patchset in extensive way and observing that it is not 
>> stable.
>> I'm running it on two connected machines - one is used as a host, 
>> second as target.
>> Once connected I'm running I/Os with dd.
>> Eventually I got I/O timeouts from nvme layer on host,
>> causing connect/disconnect loops and I/O hung.
>> Does not matter if the workload is reads or writes.
>>
> Do you have the kernel message log here?
> It _might_ be that we're overloading the TLS stack, such that processing 
> of individual packets is taking too long and triggering a KATO.
> 
>> Second test is connect/disconnect loops.
>> On disconnect I've got ocasional delays due to nvme commands timeouts.
>> The disconnect happens eventually, but first it need to hit timeout.
>>
> Again, do you have message logs?
> 
Managed to validate it with a larger setup.
Message log is:
nvme nvme0: mapped 16/0/0 default/read/poll queues.
nvme nvme0: new ctrl: NQN "nqn.exuma", addr 10.168.136.124:4420
nvme nvme0: Removing ctrl: NQN "nqn.exuma"
nvme nvme0: queue 1: timeout cid 0x3071 type 4 opcode 0x2 (Read)
nvme0c0n1: Read(0x2) @ LBA 15999927, 9 blocks, Host Aborted Command (sct 
0x3 / sc 0x71)
nvme nvme0: queue 1: timeout cid 0x2078 type 4 opcode 0x2 (Read)
nvme0c0n1: Read(0x2) @ LBA 15999872, 4 blocks, Host Aborted Command (sct 
0x3 / sc 0x71)
nvme nvme0: queue 1: timeout cid 0x2079 type 4 opcode 0x2 (Read)
nvme0c0n1: Read(0x2) @ LBA 15999877, 1 blocks, Host Aborted Command (sct 
0x3 / sc 0x71)
nvme nvme0: queue 1: timeout cid 0x207a type 4 opcode 0x2 (Read)
nvme0c0n1: Read(0x2) @ LBA 15999879, 2 blocks, Host Aborted Command (sct 
0x3 / sc 0x71)
nvme nvme0: queue 1: timeout cid 0x207b type 4 opcode 0x2 (Read)
nvme0c0n1: Read(0x2) @ LBA 15999882, 4 blocks, Host Aborted Command (sct 
0x3 / sc 0x71)
nvme nvme0: queue 1: timeout cid 0x207c type 4 opcode 0x2 (Read)
nvme0c0n1: Read(0x2) @ LBA 15999887, 21 blocks, Host Aborted Command 
(sct 0x3 / sc 0x71)
nvme nvme0: queue 1: timeout cid 0x207d type 4 opcode 0x2 (Read)
nvme0c0n1: Read(0x2) @ LBA 15999909, 6 blocks, Host Aborted Command (sct 
0x3 / sc 0x71)
nvme nvme0: queue 1: timeout cid 0x207e type 4 opcode 0x2 (Read)
nvme0c0n1: Read(0x2) @ LBA 15999916, 10 blocks, Host Aborted Command 
(sct 0x3 / sc 0x71)
block nvme0n1: no available path - failing I/O
Buffer I/O error on dev nvme0n1, logical block 15999872, async page read
nvme nvme0: failed to send request -32
nvme nvme0: Property Set error: 880, offset 0x14

Which actually points to an issue in the teardown flow.
nvme_do_delete_ctrl() does this:

         nvme_stop_ctrl(ctrl);
         nvme_remove_namespaces(ctrl);
         ctrl->ops->delete_ctrl(ctrl);

and ->delete_ctrl()
   ->nvme_tcp_delete_ctrl()
     ->nvme_tcp_teardown_ctrl()
       ->nvme_tcp_teardown_io_queues()

has:
         nvme_quiesce_admin_queue(ctrl);
         nvme_quiesce_io_queues(ctrl);
         nvme_sync_io_queues(ctrl);
         nvme_tcp_stop_io_queues(ctrl);

Now, if you look at 'nvme_sync_io_queues()' you'll find

         down_read(&ctrl->namespaces_rwsem);
         list_for_each_entry(ns, &ctrl->namespaces, list)
                 blk_sync_queue(ns->queue);
         up_read(&ctrl->namespaces_rwsem);

but we've removed all namespaces right at the start in
nvme_do_delete_ctr(), so this is a no-op and we'll never
catch any I/O in flight causing the timeouts to occur :-(

Cheers,

Hannes


