Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A329EC6FD1F
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Mar 2023 13:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GNULCC5EkUKaPa+4EqnSt5ODUpuC/rQwpBfd5JfOX+s=; b=yH9wt4E9w1juDDkKaLFC949p/I
	61SZuUEGax2Ap8xRfI4scRymrcQ7nTemOUIMQUJXf1R+RPe+KAZOFaLHYIcIVrdZlRV8ul7HsaaE6
	WzTlIwVsJGV77J1F5MbRvhV12a6sOamPQpQhDUwFIqbarU79m6QlomvgKEHMj6Uf2frMzln91ewpK
	2XdrV9mjU79316E6FNQiSXPx3TSlCJFlL7c6w/s23RuRtbpR+t7oQRoL+njBGY75nXd5wBPq0QVpN
	1gkz0JGKvGjkGQwAy6rAH7L56imxwiK1kiogyWPMIwdnGsfVFetD1nEakpVo6kDAgT+7eJdrhVgQn
	laZbBFYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1peyoD-00GAPq-2D;
	Wed, 22 Mar 2023 13:47:21 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1peyo7-00GAOP-1r
	for linux-nvme@lists.infradead.org;
	Wed, 22 Mar 2023 13:47:18 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2CE8933B7E;
	Wed, 22 Mar 2023 13:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1679492832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GNULCC5EkUKaPa+4EqnSt5ODUpuC/rQwpBfd5JfOX+s=;
	b=Po69nzb5CaC6dyn9ZgsYmGZ/porixpwk6nxowFn6gV7dVwgNR+fAStd6JSSNdS5C5U7nAR
	MuT+cpVHGJolgEg+xTUpN8BvlwC+qD7Fqi8bf35h2M2DHDKB8vD+AHfXb6nSposB5Fdt3w
	6BXXiKz56cxwOFglZdMsG47o7wIPesk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1679492832;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GNULCC5EkUKaPa+4EqnSt5ODUpuC/rQwpBfd5JfOX+s=;
	b=XBJ4vw6GL8wk/KTOJ7bdAT42ijn/z0UKjnBBTltmbghgBKsCY1YPkRoi7mcungiQabDnFN
	7XR2l0TKAzkS3gAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1A17013416;
	Wed, 22 Mar 2023 13:47:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id odfvBeAGG2SEDAAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 22 Mar 2023 13:47:12 +0000
Message-ID: <c426d104-b7f2-e736-c23a-b94fda54ed37@suse.de>
Date: Wed, 22 Mar 2023 14:47:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 15/18] nvmet-tcp: enable TLS handshake upcall
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chuck Lever <cel@kernel.org>, kernel-tls-handshake@lists.linux.dev
References: <20230321124325.77385-1-hare@suse.de>
 <20230321124325.77385-16-hare@suse.de>
 <6f69983c-17bd-dd72-b941-95f55db10180@grimberg.me>
 <b8a2e1d4-3571-447b-25c6-c6dd25fbad02@suse.de>
 <a1af3f6b-ec9e-4e91-ad70-57fcc9010a91@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <a1af3f6b-ec9e-4e91-ad70-57fcc9010a91@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_064715_940438_2D5EE27C 
X-CRM114-Status: GOOD (  38.25  )
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

On 3/22/23 13:51, Sagi Grimberg wrote:
> 
> 
> On 3/22/23 14:34, Hannes Reinecke wrote:
>> On 3/22/23 13:13, Sagi Grimberg wrote:
>>>
>>>
>>> On 3/21/23 14:43, Hannes Reinecke wrote:
>>>> Add functions to start the TLS handshake upcall.
>>>>
>>>> Signed-off-by: Hannes Reincke <hare@suse.de>
>>>> ---
>>>>   drivers/nvme/target/tcp.c | 188 
>>>> ++++++++++++++++++++++++++++++++++++--
>>>>   1 file changed, 181 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
>>>> index 5c43767c5ecd..6e88e98a2c59 100644
>>>> --- a/drivers/nvme/target/tcp.c
>>>> +++ b/drivers/nvme/target/tcp.c
>>>> @@ -9,8 +9,10 @@
>>>>   #include <linux/slab.h>
>>>>   #include <linux/err.h>
>>>>   #include <linux/nvme-tcp.h>
>>>> +#include <linux/nvme-keyring.h>
>>>>   #include <net/sock.h>
>>>>   #include <net/tcp.h>
>>>> +#include <net/handshake.h>
>>>>   #include <linux/inet.h>
>>>>   #include <linux/llist.h>
>>>>   #include <crypto/hash.h>
>>>> @@ -40,6 +42,14 @@ module_param(idle_poll_period_usecs, int, 0644);
>>>>   MODULE_PARM_DESC(idle_poll_period_usecs,
>>>>           "nvmet tcp io_work poll till idle time period in usecs");
>>>> +/*
>>>> + * TLS handshake timeout
>>>> + */
>>>> +static int tls_handshake_timeout = 30;
>>>
>>> 30 ?
>>>
>> Yeah; will be changing it to 10.
>>
>>>> +module_param(tls_handshake_timeout, int, 0644);
>>>> +MODULE_PARM_DESC(tls_handshake_timeout,
>>>> +         "nvme TLS handshake timeout in seconds (default 30)");
>>>> +
>>>>   #define NVMET_TCP_RECV_BUDGET        8
>>>>   #define NVMET_TCP_SEND_BUDGET        8
>>>>   #define NVMET_TCP_IO_WORK_BUDGET    64
>>>> @@ -131,6 +141,9 @@ struct nvmet_tcp_queue {
>>>>       struct ahash_request    *snd_hash;
>>>>       struct ahash_request    *rcv_hash;
>>>> +    struct key        *tls_psk;
>>>> +    struct delayed_work    tls_handshake_work;
>>>> +
>>>>       unsigned long           poll_end;
>>>>       spinlock_t        state_lock;
>>>> @@ -168,6 +181,7 @@ static struct workqueue_struct *nvmet_tcp_wq;
>>>>   static const struct nvmet_fabrics_ops nvmet_tcp_ops;
>>>>   static void nvmet_tcp_free_cmd(struct nvmet_tcp_cmd *c);
>>>>   static void nvmet_tcp_free_cmd_buffers(struct nvmet_tcp_cmd *cmd);
>>>> +static void nvmet_tcp_tls_handshake_timeout_work(struct work_struct 
>>>> *work);
>>>>   static inline u16 nvmet_tcp_cmd_tag(struct nvmet_tcp_queue *queue,
>>>>           struct nvmet_tcp_cmd *cmd)
>>>> @@ -1400,6 +1414,8 @@ static void 
>>>> nvmet_tcp_restore_socket_callbacks(struct nvmet_tcp_queue *queue)
>>>>   {
>>>>       struct socket *sock = queue->sock;
>>>> +    if (!sock->sk)
>>>> +        return;
>>>
>>> Umm, when will the sock not have an sk?
>>>
>> When someone called 'sock_release()'.
>> But that's basically a leftover from development.
>>
>>>>       write_lock_bh(&sock->sk->sk_callback_lock);
>>>>       sock->sk->sk_data_ready =  queue->data_ready;
>>>>       sock->sk->sk_state_change = queue->state_change;
>>>> @@ -1448,7 +1464,8 @@ static void 
>>>> nvmet_tcp_release_queue_work(struct work_struct *w)
>>>>       list_del_init(&queue->queue_list);
>>>>       mutex_unlock(&nvmet_tcp_queue_mutex);
>>>> -    nvmet_tcp_restore_socket_callbacks(queue);
>>>> +    if (queue->state != NVMET_TCP_Q_TLS_HANDSHAKE)
>>>> +        nvmet_tcp_restore_socket_callbacks(queue);
>>>
>>> This is because you only save the callbacks after the handshake
>>> phase is done? Maybe it would be simpler to clear the ops because
>>> the socket is going away anyways...
>>>
>> Or just leave it in place, as they'll be cleared up on sock_release().
> 
> This plays a role today, because after we clear sock callbacks, and
> flush io_work, we know we are not going to be triggered from the
> network, which is needed to continue teardown safely. So if you leave
> them in place, you need to do a different fence here.
> 
>>
>>>>       cancel_work_sync(&queue->io_work);
>>>>       /* stop accepting incoming data */
>>>>       queue->rcv_state = NVMET_TCP_RECV_ERR;
>>>> @@ -1469,6 +1486,8 @@ static void 
>>>> nvmet_tcp_release_queue_work(struct work_struct *w)
>>>>       nvmet_tcp_free_cmds(queue);
>>>>       if (queue->hdr_digest || queue->data_digest)
>>>>           nvmet_tcp_free_crypto(queue);
>>>> +    if (queue->tls_psk)
>>>> +        key_put(queue->tls_psk);
>>>>       ida_free(&nvmet_tcp_queue_ida, queue->idx);
>>>>       page = virt_to_head_page(queue->pf_cache.va);
>>>>       __page_frag_cache_drain(page, queue->pf_cache.pagecnt_bias);
>>>> @@ -1481,11 +1500,15 @@ static void nvmet_tcp_data_ready(struct sock 
>>>> *sk)
>>>>       trace_sk_data_ready(sk);
>>>> -    read_lock_bh(&sk->sk_callback_lock);
>>>> -    queue = sk->sk_user_data;
>>>> -    if (likely(queue))
>>>> -        queue_work_on(queue_cpu(queue), nvmet_tcp_wq, 
>>>> &queue->io_work);
>>>> -    read_unlock_bh(&sk->sk_callback_lock);
>>>> +    rcu_read_lock_bh();
>>>> +    queue = rcu_dereference_sk_user_data(sk);
>>>> +    if (queue->data_ready)
>>>> +        queue->data_ready(sk);
>>>> +    if (likely(queue) &&
>>>> +        queue->state != NVMET_TCP_Q_TLS_HANDSHAKE)
>>>> +        queue_work_on(queue_cpu(queue), nvmet_tcp_wq,
>>>> +                  &queue->io_work);
>>>> +    rcu_read_unlock_bh();
>>>
>>> Same comment as the host side. separate rcu stuff from data_ready call.
>>>
>> Ok.
>>
>>>>   }
>>>>   static void nvmet_tcp_write_space(struct sock *sk)
>>>> @@ -1585,13 +1608,139 @@ static int nvmet_tcp_set_queue_sock(struct 
>>>> nvmet_tcp_queue *queue)
>>>>           sock->sk->sk_write_space = nvmet_tcp_write_space;
>>>>           if (idle_poll_period_usecs)
>>>>               nvmet_tcp_arm_queue_deadline(queue);
>>>> -        queue_work_on(queue_cpu(queue), nvmet_tcp_wq, 
>>>> &queue->io_work);
>>>> +        queue_work_on(queue_cpu(queue), nvmet_tcp_wq,
>>>> +                  &queue->io_work);
>>>
>>> Why the change?
>>>
>> Left-over from development.
>>
>>>>       }
>>>>       write_unlock_bh(&sock->sk->sk_callback_lock);
>>>>       return ret;
>>>>   }
>>>> +static void nvmet_tcp_tls_data_ready(struct sock *sk)
>>>> +{
>>>> +    struct socket_wq *wq;
>>>> +
>>>> +    rcu_read_lock();
>>>> +    /* kTLS will change the callback */
>>>> +    if (sk->sk_data_ready == nvmet_tcp_tls_data_ready) {
>>>> +        wq = rcu_dereference(sk->sk_wq);
>>>> +        if (skwq_has_sleeper(wq))
>>>> +            wake_up_interruptible_all(&wq->wait);
>>>> +    }
>>>> +    rcu_read_unlock();
>>>> +}
>>>
>>> Can you explain why this is needed? It looks out-of-place.
>>> Who is this waking up? isn't tls already calling the socket
>>> default data_ready that does something similar for userspace?
>>>
>> Black magic.
> 
> :)
> 
>> The 'data_ready' call might happen at any time after the 'accept' call 
>> and us calling into userspace.
>> In particular we have this flow of control:
>>
>> 1. Kernel: accept()
>> 2. Kernel: handshake request
>> 3. Userspace: read data from socket
>> 4. Userspace: tls handshake
>> 5. Kernel: handshake complete
>>
>> If the 'data_ready' event occurs between 1. and 3. userspace wouldn't 
>> know that something has happened, and will be sitting there waiting 
>> for data which is already present.
> 
> Umm, doesn't userspace read from the socket once we trigger the upcall?
> it should. But I still don't understand what is the difference between
> us waiking up userspace, from the default sock doing the same?
> 
No, it doesn't (or, rather, can't).
After processing 'accept()' (from the kernel code) data might already be 
present (after all, why would we get an 'accept' call otherwise?).
But the daemon has not been started up (yet); that's only done in
step 3). But 'data_ready' has already been called, so by the time 
userland is able to do a 'read()' on the socket it won't be seeing anything.

To be precise: that's the reasoning I've come up with.
Might be completely wrong, or beside the point.
But what I _do_ know is that without this call userspace would
_not_ see any data, and would happily sit there until we close the 
socket due to a timeout (which also why I put in the timeout
module options ...), and only _then_ see the data.
But with this call everything works. So there.

>>>> +
>>>> +static void nvmet_tcp_tls_handshake_restart(struct nvmet_tcp_queue 
>>>> *queue)
>>>> +{
>>>> +    spin_lock(&queue->state_lock);
>>>> +    if (queue->state != NVMET_TCP_Q_TLS_HANDSHAKE) {
>>>> +        pr_warn("queue %d: TLS handshake already completed\n",
>>>> +            queue->idx);
>>>> +        spin_unlock(&queue->state_lock);
>>>> +        return;
>>>> +    }
>>>> +    queue->state = NVMET_TCP_Q_CONNECTING;
>>>> +    spin_unlock(&queue->state_lock);
>>>> +
>>>> +    pr_debug("queue %d: restarting queue after TLS handshake\n",
>>>> +         queue->idx);
>>>> +    /*
>>>> +     * Set callbacks after handshake; TLS implementation
>>>> +     * might have changed the socket callbacks.
>>>> +     */
>>>> +    nvmet_tcp_set_queue_sock(queue);
>>>
>>> My understanding is that this is the desired end-state, i.e.
>>> tls connection is ready and now we are expecting nvme traffic?
>>>
>> Yes.
>>
>>> I think that the function name should be changed, it sounds like
>>> it is restarting the handshake, and it does not appear to do that.
>>>
>> Sure, np.
>>
>> nvmet_tcp_set_queue_callbacks()?
> 
> I meant about nvmet_tcp_tls_handshake_restart()
> 
Ah, that. Yes, of course.

>>
>>>> +}
>>>> +
>>>> +static void nvmet_tcp_save_tls_callbacks(struct nvmet_tcp_queue 
>>>> *queue)
>>>> +{
>>>> +    struct sock *sk = queue->sock->sk;
>>>> +
>>>> +    write_lock_bh(&sk->sk_callback_lock);
>>>> +    rcu_assign_sk_user_data(sk, queue);
>>>> +    queue->data_ready = sk->sk_data_ready;
>>>> +    sk->sk_data_ready = nvmet_tcp_tls_data_ready;
>>>> +    write_unlock_bh(&sk->sk_callback_lock);
>>>> +}
>>>> +
>>>> +static void nvmet_tcp_restore_tls_callbacks(struct nvmet_tcp_queue 
>>>> *queue)
>>>> +{
>>>> +    struct sock *sk = queue->sock->sk;
>>>> +
>>>> +    if (WARN_ON(!sk))
>>>> +        return;
>>>> +    write_lock_bh(&sk->sk_callback_lock);
>>>> +    /* Only reset the callback if it really is ours */
>>>> +    if (sk->sk_data_ready == nvmet_tcp_tls_data_ready)
>>>
>>> I still don't understand why our data_ready for tls is needed.
>>> Who are
>>>
>> See above for an explanation.
>>
>>>> +        sk->sk_data_ready = queue->data_ready;
>>>> +    rcu_assign_sk_user_data(sk, NULL);
>>>> +    queue->data_ready = NULL;
>>>> +    write_unlock_bh(&sk->sk_callback_lock);
>>>> +}
>>>> +
>>>> +static void nvmet_tcp_tls_handshake_done(void *data, int status,
>>>> +                     key_serial_t peerid)
>>>> +{
>>>> +    struct nvmet_tcp_queue *queue = data;
>>>> +
>>>> +    pr_debug("queue %d: TLS handshake done, key %x, status %d\n",
>>>> +         queue->idx, peerid, status);
>>>> +    if (!status) {
>>>> +        spin_lock(&queue->state_lock);
>>>> +        queue->tls_psk = key_lookup(peerid);
>>>> +        if (IS_ERR(queue->tls_psk)) {
>>>> +            pr_warn("queue %d: TLS key %x not found\n",
>>>> +                queue->idx, peerid);
>>>> +            queue->tls_psk = NULL;
>>>> +        }
>>>> +        spin_unlock(&queue->state_lock);
>>>> +    }
>>>> +    cancel_delayed_work_sync(&queue->tls_handshake_work);
>>>> +    nvmet_tcp_restore_tls_callbacks(queue);
>>>> +    if (status)
>>>> +        nvmet_tcp_schedule_release_queue(queue);
>>>> +    else
>>>> +        nvmet_tcp_tls_handshake_restart(queue);
>>>> +}
>>>> +
>>>> +static void nvmet_tcp_tls_handshake_timeout_work(struct work_struct 
>>>> *w)
>>>> +{
>>>> +    struct nvmet_tcp_queue *queue = container_of(to_delayed_work(w),
>>>> +            struct nvmet_tcp_queue, tls_handshake_work);
>>>> +
>>>> +    pr_debug("queue %d: TLS handshake timeout\n", queue->idx);
>>>> +    nvmet_tcp_restore_tls_callbacks(queue);
>>>> +    nvmet_tcp_schedule_release_queue(queue);
>>>> +}
>>>> +
>>>> +static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue)
>>>> +{
>>>> +    int ret = -EOPNOTSUPP;
>>>> +    struct tls_handshake_args args;
>>>> +
>>>> +    if (queue->state != NVMET_TCP_Q_TLS_HANDSHAKE) {
>>>> +        pr_warn("cannot start TLS in state %d\n", queue->state);
>>>> +        return -EINVAL;
>>>> +    }
>>>> +
>>>> +    pr_debug("queue %d: TLS ServerHello\n", queue->idx);
>>>> +    args.ta_sock = queue->sock;
>>>> +    args.ta_done = nvmet_tcp_tls_handshake_done;
>>>> +    args.ta_data = queue;
>>>> +    args.ta_keyring = nvme_keyring_id();
>>>> +    args.ta_timeout_ms = tls_handshake_timeout * 2 * 1024;
>>>
>>>   why the 2x timeout?
>>>
>> Because I'm chicken. Will be changing it.l
> 
> :)
> 
>>
>>>> +
>>>> +    ret = tls_server_hello_psk(&args, GFP_KERNEL);
>>>> +    if (ret) {
>>>> +        pr_err("failed to start TLS, err=%d\n", ret);
>>>> +    } else {
>>>> +        pr_debug("queue %d wakeup userspace\n", queue->idx);
>>>> +        nvmet_tcp_tls_data_ready(queue->sock->sk);
>>>> +        queue_delayed_work(nvmet_wq, &queue->tls_handshake_work,
>>>> +                   tls_handshake_timeout * HZ);
>>>> +    }
>>>> +    return ret;
>>>> +}
>>>> +
>>>>   static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
>>>>           struct socket *newsock)
>>>>   {
>>>> @@ -1604,6 +1753,8 @@ static void nvmet_tcp_alloc_queue(struct 
>>>> nvmet_tcp_port *port,
>>>>       INIT_WORK(&queue->release_work, nvmet_tcp_release_queue_work);
>>>>       INIT_WORK(&queue->io_work, nvmet_tcp_io_work);
>>>> +    INIT_DELAYED_WORK(&queue->tls_handshake_work,
>>>> +              nvmet_tcp_tls_handshake_timeout_work);
>>>>       queue->sock = newsock;
>>>>       queue->port = port;
>>>>       queue->nr_cmds = 0;
>>>> @@ -1646,6 +1797,29 @@ static void nvmet_tcp_alloc_queue(struct 
>>>> nvmet_tcp_port *port,
>>>>       list_add_tail(&queue->queue_list, &nvmet_tcp_queue_list);
>>>>       mutex_unlock(&nvmet_tcp_queue_mutex);
>>>> +    if (queue->state == NVMET_TCP_Q_TLS_HANDSHAKE) {
>>>> +        nvmet_tcp_save_tls_callbacks(queue);
>>>> +        if (!nvmet_tcp_tls_handshake(queue))
>>>> +            return;
>>>> +        nvmet_tcp_restore_tls_callbacks(queue);
>>>> +
>>>> +        /*
>>>> +         * If sectype is set to 'tls1.3' TLS is required
>>>> +         * so terminate the connection if the TLS handshake
>>>> +         * failed.
>>>> +         */
>>>> +        if (queue->port->nport->disc_addr.tsas.tcp.sectype ==
>>>> +            NVMF_TCP_SECTYPE_TLS13) {
>>>> +            pr_debug("queue %d sectype tls1.3, terminate 
>>>> connection\n",
>>>> +                 queue->idx);
>>>> +            goto out_destroy_sq;
>>>> +        }
>>>> +        pr_debug("queue %d fallback to icreq\n", queue->idx);
>>>> +        spin_lock(&queue->state_lock);
>>>> +        queue->state = NVMET_TCP_Q_CONNECTING;
>>>> +        spin_unlock(&queue->state_lock);
>>>> +    }
>>>> +
>>>>       ret = nvmet_tcp_set_queue_sock(queue);
>>>>       if (ret)
>>>>           goto out_destroy_sq;
>>>
>>> I'm still trying to learn the state machine here, can you share a few 
>>> words on it? Also please include it in the next round in the change log.
>>
>> As outlined in the response to the nvme-tcp upcall, on the server side 
>> we _have_ to allow for non-TLS connections (eg. for discovery).
> 
> But in essence what you are doing is that you allow normal connections
> for a secured port...
> 
Correct.

> btw, why not enforce a psk for the discovery controller (on this port)
> as well? for secured ports? No one said that we must accept a
> non-secured discovery connecting host on a secured port.
> 
Because we can't have a PSK for standard discovery.
Every discovery controller has the canonical discovery NQN, so every
PSK will have the same subsystem NQN, and you will have to provide the 
_same_ PSK to every attached storage system.

If we had unique discovery controller NQNs everything would be good,
but as we don't I guess we have to support normal connections in 
addition to secured ones.

As I said; maybe it's time to revisit the unique discovery NQN patches;
with those we should be able to separate the various use-case like
having a dedicated secured discovery port.

>> And we have to start the daemon _before_ the first packet arrives,
> 
> Not sure why that is.
> 
>> but only the first packet will tell us what we should have done.
>> So really we have to start the upcall and see what happens.
>> The 'real' handling / differentiation between these two modes is done 
>> with the 'peek pdu' patch later on.
> 
> I am hoping we can kill it.

Sorry, no. Can't.
Not without killing standard discovery.

Cheers,

Hannes


