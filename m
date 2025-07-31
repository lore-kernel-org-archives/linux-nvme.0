Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C099FC87FCA
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Jul 2025 17:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ls5gCUTjVBeUXhIwXzFVvEfqHedChX+/IDCkmstbyv8=; b=pK54UHd2CExHRcRV+UFTqg4Kv2
	0RmYUU7/MLv8Zr2hQTuNqsuoFGDTpr2LbnWuMIT4mtpYOBHLgpuWE/7OyMa5pfpEd9GG/gcezU6FB
	KGEVCJJLddPYsnuW2TJQcGRB3U3s6NO7C4xrpSQ3Z2qxY31tVcdUxR22vovA2WsnVa2w10UeKvVHR
	E8ScS2DhUCZRqf7mDchSGbmjZ+DTkdX0/EjwneorbGVaeOWib9KiMJvxJ97/+s9ttN0WSt/FgHZjk
	+jpXoq4SSHj2mrnD8qa2HuVi26j3JAgkhu9Ekd4WHIcM4qDQZJxfInOO7/W4As5xSyCIX6gO4wN/n
	naApYHHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhWq2-000000049Ls-3Ij1;
	Thu, 31 Jul 2025 17:13:06 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhVml-000000042pf-2CW1
	for linux-nvme@bombadil.infradead.org;
	Thu, 31 Jul 2025 16:05:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=ls5gCUTjVBeUXhIwXzFVvEfqHedChX+/IDCkmstbyv8=; b=nPrXdg2pci6Nc3hjROzkv3FvxV
	B+rdKCniSANreMeeKE54I2Dl21fvb8LrACTnXBZ4MKFQhidxmlZtpL5zu9Z5WOWLi9xgyXIz1JP0T
	GS5LOGLywiwe4zF1HGQjEbO5S1SpAs/HO7/EgHHLCUweYE9RRfuMXxr6QJPMtqyLUjkn836IDOn/I
	RHRRWPiw7JiGCgjf6Uysrokir13xjFJ2hV0K7n8a534JnigR2AK5pYQJU1ieLOhb3tYhg6RsIKTUz
	vvyHkfxHbSUsrx6aYk/0fYfie+ntmmfsqaNMSUxfKiXg2r25pu+D/r0672jmmEbxw3ucCE76Cwc7j
	jwfc0Ocg==;
Received: from smtp-out1.suse.de ([195.135.223.130])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhVmi-0000000D5ts-2mIS
	for linux-nvme@lists.infradead.org;
	Thu, 31 Jul 2025 16:05:38 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3903F21CFF;
	Thu, 31 Jul 2025 16:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753977934; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ls5gCUTjVBeUXhIwXzFVvEfqHedChX+/IDCkmstbyv8=;
	b=a8lx5J5vx5bM2QH4EzJWlVNkWmu3SamghkittVIRlhEM+qP8UMKXf8aGJ56/iq+X/dD9Ky
	z/U/52BmcsgGWYyeMjDhRDtNwEgrSpcteb/7U860YFiI7g1wr9mV7j4UfZB/iLHjrsnK16
	Y349WrTJPiO07+hZwVg6KMaAEmn+sc4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753977934;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ls5gCUTjVBeUXhIwXzFVvEfqHedChX+/IDCkmstbyv8=;
	b=8Ucsu68etg4g0tUfbqRT4gXMvNg/h5ug70PtR3WnzAidrq8dWtcEedqA8tjrTK6ZIxGL4x
	i0FCORpKEqQ4F0Ag==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753977934; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ls5gCUTjVBeUXhIwXzFVvEfqHedChX+/IDCkmstbyv8=;
	b=a8lx5J5vx5bM2QH4EzJWlVNkWmu3SamghkittVIRlhEM+qP8UMKXf8aGJ56/iq+X/dD9Ky
	z/U/52BmcsgGWYyeMjDhRDtNwEgrSpcteb/7U860YFiI7g1wr9mV7j4UfZB/iLHjrsnK16
	Y349WrTJPiO07+hZwVg6KMaAEmn+sc4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753977934;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ls5gCUTjVBeUXhIwXzFVvEfqHedChX+/IDCkmstbyv8=;
	b=8Ucsu68etg4g0tUfbqRT4gXMvNg/h5ug70PtR3WnzAidrq8dWtcEedqA8tjrTK6ZIxGL4x
	i0FCORpKEqQ4F0Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9B3FF13A43;
	Thu, 31 Jul 2025 16:05:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4rwTJE2Ui2i9HwAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 31 Jul 2025 16:05:33 +0000
Message-ID: <9057206c-7173-4f1c-8ff7-ea5e2a29a66d@suse.de>
Date: Thu, 31 Jul 2025 18:05:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] nvmet-tcp: fix handling of tls alerts
To: Olga Kornievskaia <okorniev@redhat.com>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, trondmy@hammerspace.com,
 anna.schumaker@oracle.com, hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux-nfs@vger.kernel.org,
 linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 kernel-tls-handshake@lists.linux.dev, neil@brown.name, Dai.Ngo@oracle.com,
 tom@talpey.com, horms@kernel.org, kbusch@kernel.org
References: <20250730200835.80605-1-okorniev@redhat.com>
 <20250730200835.80605-4-okorniev@redhat.com>
 <cdeb5e12-5c61-4a95-8e31-c56a3a90d6a3@suse.de>
 <CACSpFtCu+it5n2z=OXRARznR02aU4d3r2z7Sok6WzGt24C6-NQ@mail.gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <CACSpFtCu+it5n2z=OXRARznR02aU4d3r2z7Sok6WzGt24C6-NQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250731_170536_851002_D01275A2 
X-CRM114-Status: GOOD (  23.81  )
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

On 7/31/25 17:29, Olga Kornievskaia wrote:
> On Thu, Jul 31, 2025 at 2:10 AM Hannes Reinecke <hare@suse.de> wrote:
>>
>> On 7/30/25 22:08, Olga Kornievskaia wrote:
>>> Revert kvec msg iterator before trying to process a TLS alert
>>> when possible.
>>>
>>> In nvmet_tcp_try_recv_data(), it's assumed that no msg control
>>> message buffer is set prior to sock_recvmsg(). Hannes suggested
>>> that upon detecting that TLS control message is received log a
>>> message and error out. Left comments in the code for the future
>>> improvements.
>>>
>>> Fixes: a1c5dd8355b1 ("nvmet-tcp: control messages for recvmsg()")
>>> Suggested-by: Hannes Reinecke <hare@suse.de>
>>> Reviewed-by: Hannes Reinecky <hare@susu.de>
>>> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
>>> ---
>>>    drivers/nvme/target/tcp.c | 30 +++++++++++++++++++-----------
>>>    1 file changed, 19 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
>>> index 688033b88d38..055e420d3f2e 100644
>>> --- a/drivers/nvme/target/tcp.c
>>> +++ b/drivers/nvme/target/tcp.c
>>> @@ -1161,6 +1161,7 @@ static int nvmet_tcp_try_recv_pdu(struct nvmet_tcp_queue *queue)
>>>        if (unlikely(len < 0))
>>>                return len;
>>>        if (queue->tls_pskid) {
>>> +             iov_iter_revert(&msg.msg_iter, len);
>>>                ret = nvmet_tcp_tls_record_ok(queue, &msg, cbuf);
>>>                if (ret < 0)
>>>                        return ret;
>>> @@ -1217,19 +1218,28 @@ static void nvmet_tcp_prep_recv_ddgst(struct nvmet_tcp_cmd *cmd)
>>>    static int nvmet_tcp_try_recv_data(struct nvmet_tcp_queue *queue)
>>>    {
>>>        struct nvmet_tcp_cmd  *cmd = queue->cmd;
>>> -     int len, ret;
>>> +     int len;
>>>
>>>        while (msg_data_left(&cmd->recv_msg)) {
>>> +             /* to detect that we received a TlS alert, we assumed that
>>> +              * cmg->recv_msg's control buffer is not setup. kTLS will
>>> +              * return an error when no control buffer is set and
>>> +              * non-tls-data payload is received.
>>> +              */
>>>                len = sock_recvmsg(cmd->queue->sock, &cmd->recv_msg,
>>>                        cmd->recv_msg.msg_flags);
>>> +             if (cmd->recv_msg.msg_flags & MSG_CTRUNC) {
>>> +                     if (len == 0 || len == -EIO) {
>>> +                             pr_err("queue %d: unhandled control message\n",
>>> +                                    queue->idx);
>>> +                             /* note that unconsumed TLS control message such
>>> +                              * as TLS alert is still on the socket.
>>> +                              */
>>
>> Hmm. Will it get cleared when we close the socket?
> 
> If the socket is closed then any data on that socket would be freed.
> 
>> Or shouldn't we rather introduce proper cmsg handling?
> 
> That would be what I have originally proposed (I know that was on the
> private list). But yes, we can setup a dedicated kvec to receive the
> TLS control message once its been detected and then call
> nvme_tcp_tls_record_ok().
> 
> Let me know if proper cmsg handling is what's desired for this patch.
> 
>> (If we do, we'll need it to do on the host side, too)
> 
No, let's delegate that to a next step. My main concern is that
data on the socket is freed upon closing (ie on reconnect).
If that's the case we should leave it for now.
There is talk to handle TLS new session ticket messages, which probably
will require some evaluation of TLS messages and will most certainly
require the updated TLS Alert handling.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

