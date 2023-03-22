Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33789C6FD1F
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Mar 2023 09:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MYlhViqMz0bd4DXCascc+OvuVDb0CAVg/i8FvQBdZCc=; b=A2oZDIf11i/1VrKnKCP2XH2Oxm
	6GC/A+8C9iJQx9TuxCp4pTcWbHacHnPmV4UiVOlV11MmtCCr7fG4hZyBsu29o0BvQtC5w3zkrA2Mn
	xFXHRGEf13Z8w2N9gMvtWYQhV58TvDit70h1UzVHCy8YFxENpLSwOGy3mY0hwjq0QIEio8gF0isNS
	vKAcQCclXrIE1VfhoNc+5WFCjmq2DSDhjFVYrvbGxae4NzY35s3dNRmhxjk+G/ceotntPXjKJvlmm
	O/rtBHD1h0WqkgjkKgNs7xNlnCGe8iCDtLhNdoBC1rNEmJ23CbGfbU2Nlp5wek+7D4cG5US1NLoKJ
	HGEdWeuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1peuWh-00FKKb-1E;
	Wed, 22 Mar 2023 09:12:59 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1peuWd-00FKIp-1p
	for linux-nvme@lists.infradead.org;
	Wed, 22 Mar 2023 09:12:57 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 260453391E;
	Wed, 22 Mar 2023 09:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1679476374; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MYlhViqMz0bd4DXCascc+OvuVDb0CAVg/i8FvQBdZCc=;
	b=grqVCUIs2BX18Nd4v8yrGWLu9lG/arlVGHaufAxg4NRmt5bWYmL9YNIuhKALimBeMg72GP
	4KQKtp0g1h0m/RGMQOrkbFEuOLV6O8VV1fxPLTSVm9oHfU4F5kK9FQUDp6zHXcT4+HkXE/
	SYPaIBUD0aqGukW8c6ehmZXEnFWqXzw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1679476374;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MYlhViqMz0bd4DXCascc+OvuVDb0CAVg/i8FvQBdZCc=;
	b=wi9Xx6F9R4F2oc8AR7eaoIa3Jn4mzovvpOmo0VbiwizyrYuMO0eQMmDCuyOJzMBFE0gf0v
	bmpagC4BanMQErAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 05EF013416;
	Wed, 22 Mar 2023 09:12:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id EKV9AJbGGmSCWwAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 22 Mar 2023 09:12:54 +0000
Message-ID: <cc5a73b9-7457-9f72-1b2f-750443b33925@suse.de>
Date: Wed, 22 Mar 2023 10:12:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 08/18] nvme-tcp: enable TLS handshake upcall
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chuck Lever <cel@kernel.org>, kernel-tls-handshake@lists.linux.dev
References: <20230321124325.77385-1-hare@suse.de>
 <20230321124325.77385-9-hare@suse.de>
 <92bd0f9f-8df1-b1ef-dc8b-99ae3b1e0300@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <92bd0f9f-8df1-b1ef-dc8b-99ae3b1e0300@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_021255_891287_3FF568AF 
X-CRM114-Status: GOOD (  47.17  )
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

On 3/22/23 09:45, Sagi Grimberg wrote:
> 
>> Select possible PSK identities and call the TLS handshake upcall
>> for each identity.
>> The TLS 1.3 RFC allows to send multiple identities with each ClientHello
>> request, but none of the SSL libraries implement it. As the connection
>> is established when the association is created we send only a single
>> identity for each upcall, and close the connection to restart with
>> the next identity if the handshake fails.
> 
> Can't this loop be done in userspace? In other words, how can
> we get rid of this when SSL libs would decide to support it?
> 
Well. That is something which I've been thinking about, but really 
haven't come to a good solution.

Crux of the matter is that we have to close the connection after a 
failed TLS handshake:

 > A TLS 1.3 client implementation that only supports sending a single
 > PSK identity during connection setup may be required to connect
 > multiple times in order to negotiate cipher suites with different hash
 > functions.

and as it's quite unclear in which state the connection is after the 
userspace library failed the handshake.
So the only good way to recover is to close the connection and restart 
with a different identity.

While we can move the identity selection to userspace (eg by providing 
an 'tls_psk' fabrics option holding the key serial of the PSK to user), 
that will allow us only to pass a _single_ PSK for each attempt.

And the other problem is that in its current form the spec allows for 
_different_ identites for each connection; by passing a key from 
userspace we would not be able to support that.
(Not saying that it's useful, mind.)

We could allow for several 'tls_psk' options, though; maybe that would 
be a way out.

>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>   drivers/nvme/host/tcp.c | 157 +++++++++++++++++++++++++++++++++++++---
>>   1 file changed, 148 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>> index 0438d42f4179..bcf24e9a08e1 100644
>> --- a/drivers/nvme/host/tcp.c
>> +++ b/drivers/nvme/host/tcp.c
>> @@ -8,9 +8,12 @@
>>   #include <linux/init.h>
>>   #include <linux/slab.h>
>>   #include <linux/err.h>
>> +#include <linux/key.h>
>>   #include <linux/nvme-tcp.h>
>> +#include <linux/nvme-keyring.h>
>>   #include <net/sock.h>
>>   #include <net/tcp.h>
>> +#include <net/handshake.h>
>>   #include <linux/blk-mq.h>
>>   #include <crypto/hash.h>
>>   #include <net/busy_poll.h>
>> @@ -31,6 +34,14 @@ static int so_priority;
>>   module_param(so_priority, int, 0644);
>>   MODULE_PARM_DESC(so_priority, "nvme tcp socket optimize priority");
>> +/*
>> + * TLS handshake timeout
>> + */
>> +static int tls_handshake_timeout = 10;
>> +module_param(tls_handshake_timeout, int, 0644);
>> +MODULE_PARM_DESC(tls_handshake_timeout,
>> +         "nvme TLS handshake timeout in seconds (default 10)");
> 
> Can you share what is the normal time of an upcall?
> 
That really depends on the network latency and/or reachability of the 
server. It might just have been started up, switches MAC tables not 
updated, STP still ongoing, what do I know.
So 10 seconds seemed to be a good compromise.
But that's also why I made this configurable.

>> +
>>   #ifdef CONFIG_DEBUG_LOCK_ALLOC
>>   /* lockdep can detect a circular dependency of the form
>>    *   sk_lock -> mmap_lock (page fault) -> fs locks -> sk_lock
>> @@ -104,6 +115,7 @@ enum nvme_tcp_queue_flags {
>>       NVME_TCP_Q_ALLOCATED    = 0,
>>       NVME_TCP_Q_LIVE        = 1,
>>       NVME_TCP_Q_POLLING    = 2,
>> +    NVME_TCP_Q_TLS        = 3,
>>   };
>>   enum nvme_tcp_recv_state {
>> @@ -148,6 +160,9 @@ struct nvme_tcp_queue {
>>       __le32            exp_ddgst;
>>       __le32            recv_ddgst;
>> +    struct completion       *tls_complete;
>> +    int                     tls_err;
>> +
>>       struct page_frag_cache    pf_cache;
>>       void (*state_change)(struct sock *);
>> @@ -1505,7 +1520,102 @@ static void nvme_tcp_set_queue_io_cpu(struct 
>> nvme_tcp_queue *queue)
>>       queue->io_cpu = cpumask_next_wrap(n - 1, cpu_online_mask, -1, 
>> false);
>>   }
>> -static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid)
>> +/*
>> + * nvme_tcp_lookup_psk - Look up PSKs to use for TLS
>> + *
>> + */
>> +static int nvme_tcp_lookup_psks(struct nvme_ctrl *nctrl,
>> +                   key_serial_t *keylist, int num_keys)
> 
> Where is num_keys used?
> 
Ah, indeed, need to check this in the loop.

>> +{
>> +    enum nvme_tcp_tls_cipher cipher = NVME_TCP_TLS_CIPHER_SHA384;
>> +    struct key *tls_key;
>> +    int num = 0;
>> +    bool generated = false;
>> +
>> +    /* Check for pre-provisioned keys; retained keys first */
>> +    do {
>> +        tls_key = nvme_tls_psk_lookup(NULL, nctrl->opts->host->nqn,
>> +                          nctrl->opts->subsysnqn,
>> +                          cipher, generated);
>> +        if (!IS_ERR(tls_key)) {
>> +            keylist[num] = tls_key->serial;
>> +            num++;
>> +            key_put(tls_key);
>> +        }
>> +        if (cipher == NVME_TCP_TLS_CIPHER_SHA384)
>> +            cipher = NVME_TCP_TLS_CIPHER_SHA256;
>> +        else {
>> +            if (generated)
>> +                cipher = NVME_TCP_TLS_CIPHER_INVALID;
>> +            else {
>> +                cipher = NVME_TCP_TLS_CIPHER_SHA384;
>> +                generated = true;
>> +            }
>> +        }
>> +    } while(cipher != NVME_TCP_TLS_CIPHER_INVALID);
> 
> I'm unclear about a few things here:
> 1. what is the meaning of pre-provisioned vs. retained vs. generated?
> 2. Can this loop be reorganized in a nested for loop with a break?
>     I'm wandering if it will make it simpler to read.
> 
'pre-provisioned' means that the admin has stored the keys in the 
keyring prior to calling 'nvme connect'.
'generated' means a key which is derived from the key material generated 
from a previous DH-HMAC-CHAP transaction.
As for the loop: I am going back and forth between having a loop
(which is executed exactly four times) and unrolling the loop into four 
distinct calls to nvme_tls_psk_lookup().
It probably doesn't matter for the actual assembler code (as the 
compiler will be doing a loop unroll anyway), but the unrolled code 
would allow for better documentation, Code might be slightly longer, 
though, with lots of repetitions.
So really, I don't know which is best.

>> +    return num;
>> +}
>> +
>> +static void nvme_tcp_tls_done(void *data, int status, key_serial_t 
>> peerid)
>> +{
>> +    struct nvme_tcp_queue *queue = data;
>> +    struct nvme_tcp_ctrl *ctrl = queue->ctrl;
>> +    int qid = nvme_tcp_queue_id(queue);
>> +
>> +    dev_dbg(ctrl->ctrl.device, "queue %d: TLS handshake done, key %x, 
>> status %d\n",
>> +        qid, peerid, status);
>> +
>> +    queue->tls_err = -status;
>> +    if (queue->tls_complete)
>> +        complete(queue->tls_complete);
>> +}
>> +
>> +static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
>> +                  struct nvme_tcp_queue *queue,
>> +                  key_serial_t peerid)
>> +{
>> +    int qid = nvme_tcp_queue_id(queue);
>> +    int ret;
>> +    struct tls_handshake_args args;
>> +    unsigned long tmo = tls_handshake_timeout * HZ;
>> +    DECLARE_COMPLETION_ONSTACK(tls_complete);
>> +
>> +    dev_dbg(nctrl->device, "queue %d: start TLS with key %x\n",
>> +        qid, peerid);
>> +    args.ta_sock = queue->sock;
>> +    args.ta_done = nvme_tcp_tls_done;
>> +    args.ta_data = queue;
>> +    args.ta_my_peerids[0] = peerid;
>> +    args.ta_num_peerids = 1;
>> +    args.ta_keyring = nvme_keyring_id();
>> +    args.ta_timeout_ms = tls_handshake_timeout * 2 * 1000;
>> +    queue->tls_err = -EOPNOTSUPP;
>> +    queue->tls_complete = &tls_complete;
>> +    ret = tls_client_hello_psk(&args, GFP_KERNEL);
>> +    if (ret) {
>> +        dev_dbg(nctrl->device, "queue %d: failed to start TLS: %d\n",
>> +            qid, ret);
>> +        return ret;
>> +    }
>> +    if (wait_for_completion_timeout(queue->tls_complete, tmo) == 0) {
>> +        dev_dbg(nctrl->device,
>> +            "queue %d: TLS handshake timeout\n", qid);
>> +        queue->tls_complete = NULL;
>> +        ret = -ETIMEDOUT;
>> +    } else {
>> +        dev_dbg(nctrl->device,
>> +            "queue %d: TLS handshake complete, error %d\n",
>> +            qid, queue->tls_err);
>> +        ret = queue->tls_err;
>> +    }
>> +    queue->tls_complete = NULL;
>> +    if (!ret)
>> +        set_bit(NVME_TCP_Q_TLS, &queue->flags);
>> +    return ret;
>> +}
>> +
>> +static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
>> +                key_serial_t peerid)
>>   {
>>       struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
>>       struct nvme_tcp_queue *queue = &ctrl->queues[qid];
>> @@ -1628,6 +1738,13 @@ static int nvme_tcp_alloc_queue(struct 
>> nvme_ctrl *nctrl, int qid)
>>           goto err_rcv_pdu;
>>       }
>> +    /* If PSKs are configured try to start TLS */
>> +    if (peerid) {
> 
> Where is peerid being initialized? Not to mention that peerid is
> a rather cryptic name (at least to me). Is this the ClientHello
> identity?
> 
'peerid' is the term used in the netlink handshake protocol.
It actually is the key serial number of the PSK to use.
Maybe 'psk_id' would be more appropriate here.

>> +        ret = nvme_tcp_start_tls(nctrl, queue, peerid);
>> +        if (ret)
>> +            goto err_init_connect;
>> +    }
>> +
>>       ret = nvme_tcp_init_connection(queue);
>>       if (ret)
>>           goto err_init_connect;
>> @@ -1774,11 +1891,22 @@ static int nvme_tcp_start_io_queues(struct 
>> nvme_ctrl *ctrl,
>>   static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
>>   {
>> -    int ret;
>> +    int ret = -EINVAL, num_keys, k;
>> +    key_serial_t keylist[4];
>> -    ret = nvme_tcp_alloc_queue(ctrl, 0);
>> -    if (ret)
>> -        return ret;
>> +    memset(keylist, 0, sizeof(key_serial_t));
>> +    num_keys = nvme_tcp_lookup_psks(ctrl, keylist, 4);
>> +    for (k = 0; k < num_keys; k++) {
>> +        ret = nvme_tcp_alloc_queue(ctrl, 0, keylist[k]);
>> +        if (!ret)
>> +            break;
>> +    }
>> +    if (ret) {
>> +        /* Try without TLS */
> 
> Why? this is trying to always connect with tls and fallback to no-tls?
> Why not simply do what userspace is asking us to do?
> 
> Seems backwards to me. Unless there is a statement in the spec
> that I'm not aware of which tells us to do so.
> 
This is an implication of the chosen method to select the PSK from the 
kernel code.
If we move PSK selection to userspace we clearly wouldn't need this.
But if we move PSK selection to userspace we need an updated nvme-cli 
for a) selecting the PSK from the keystore and b) passing in the new option.
So for development it was easier to run with the in-kernel selection as 
I don't need to modify nvme-cli.

>> +        ret = nvme_tcp_alloc_queue(ctrl, 0, 0);
>> +        if (ret)
>> +            goto out_free_queue;
>> +    }
>>       ret = nvme_tcp_alloc_async_req(to_tcp_ctrl(ctrl));
>>       if (ret)
>> @@ -1793,12 +1921,23 @@ static int nvme_tcp_alloc_admin_queue(struct 
>> nvme_ctrl *ctrl)
>>   static int __nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
>>   {
>> -    int i, ret;
>> +    int i, ret, num_keys = 0, k;
>> +    key_serial_t keylist[4];
>> +    memset(keylist, 0, sizeof(key_serial_t));
>> +    num_keys = nvme_tcp_lookup_psks(ctrl, keylist, 4);
>>       for (i = 1; i < ctrl->queue_count; i++) {
>> -        ret = nvme_tcp_alloc_queue(ctrl, i);
>> -        if (ret)
>> -            goto out_free_queues;
>> +        ret = -EINVAL;
>> +        for (k = 0; k < num_keys; k++) {
>> +            ret = nvme_tcp_alloc_queue(ctrl, i, keylist[k]);
>> +            if (!ret)
>> +                break;
> 
> What is going on here. are you establishing queue_count x num_keys nvme 
> queues?
> 
No, I am _trying_ to establish a connection, breaking out if the attempt
_succeeded_.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


