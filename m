Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5648C001B0
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Aug 2023 11:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zN8iTvdPhuLsZQLnAEwMTegiCuovLy+20eG/2r7NgEE=; b=IaUeCtH1NoVZczT/DkpbHh0gfy
	n/w7sQZ2S0vKB1qTgUzOcWsl925Yv0ybmNUlsgO1fREze/GKt2hiMvK3MZvtG87T0l7BGcOTg/gMa
	3jRb/U0vBw3k0ZzyNAAp2ugMZVe4iPZGNYDQP8WnH6YFRg00bhS++qNQDhhL4ua8/RfEWtsgDq0ch
	nwfeg0N8n3GQa2sKBtBZJ8kFbZyvAB+OJVAYg07CSzof3kG7UxRydP3pdQq3nofnoTvr415YIloxA
	UlyU9zSWujznesoNc3Raphn8V3FqNLKAWBvcft8/gqEuAP7IzwCauOEQ6XLJ0SF73Ek9rIsD60kqC
	tX0kf2ig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qThTT-004mm2-0E;
	Wed, 09 Aug 2023 11:35:35 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qThTQ-004ml6-1I
	for linux-nvme@lists.infradead.org;
	Wed, 09 Aug 2023 11:35:33 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 504301F38C;
	Wed,  9 Aug 2023 11:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691580930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zN8iTvdPhuLsZQLnAEwMTegiCuovLy+20eG/2r7NgEE=;
	b=sJutXdGyRPxj8tSP6lMrq8XYgl6j5lco3XfTBuJeb7vC6Jz6AU6TSaZW31oLrDEf2KCyX1
	fjzlrh6TYGtcAlbdXGsl7GW2aXXeydvSmWsMpyFZOeSPsdpZNF73vIeERReEdNJ+SGRSt1
	/+t7A5xBxZwCg1Jk9IuwRQcrUZlG6mU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691580930;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zN8iTvdPhuLsZQLnAEwMTegiCuovLy+20eG/2r7NgEE=;
	b=tEyVPw3eIPLDe43oTP3aPhuzemgdGdhfi3/yJv6u+j9sGDvFfypXVpiP2ti0JL/IQSXXCx
	kI06n+dywtk8OvBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 40253133B5;
	Wed,  9 Aug 2023 11:35:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id aqJLDwJ602TVUgAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 09 Aug 2023 11:35:30 +0000
Message-ID: <f107bf6b-41fd-6a19-92da-457b44d424c9@suse.de>
Date: Wed, 9 Aug 2023 13:35:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/16] nvmet-tcp: control messages for recvmsg()
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230808165354.123499-1-hare@suse.de>
 <20230808165354.123499-17-hare@suse.de>
 <3b667ce4-e7c7-78a8-ccec-3cbe7620657f@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <3b667ce4-e7c7-78a8-ccec-3cbe7620657f@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230809_043532_585296_98B9B974 
X-CRM114-Status: GOOD (  22.82  )
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

On 8/9/23 13:30, Sagi Grimberg wrote:
> 
> 
> On 8/8/23 19:53, Hannes Reinecke wrote:
>> kTLS requires control messages for recvmsg() to relay any out-of-band
>> TLS messages (eg TLS alerts) to the caller.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>   drivers/nvme/target/tcp.c | 83 +++++++++++++++++++++++++++++++++------
>>   1 file changed, 72 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
>> index 75e4cb4c2f29..e1aea52e58da 100644
>> --- a/drivers/nvme/target/tcp.c
>> +++ b/drivers/nvme/target/tcp.c
>> @@ -14,6 +14,7 @@
>>   #include <net/sock.h>
>>   #include <net/tcp.h>
>>   #include <net/tls.h>
>> +#include <net/tls_prot.h>
>>   #include <net/handshake.h>
>>   #include <linux/inet.h>
>>   #include <linux/llist.h>
>> @@ -70,6 +71,9 @@ device_param_cb(idle_poll_period_usecs, &set_param_ops,
>>   MODULE_PARM_DESC(idle_poll_period_usecs,
>>           "nvmet tcp io_work poll till idle time period in usecs: 
>> Default 0");
>> +#define nvmet_queue_is_tls(queue) \
>> +    ((queue)->port->nport->disc_addr.tsas.tcp.sectype == 
>> NVMF_TCP_SECTYPE_TLS13)
> 
> That is some steep dereferencing... I'd say just cache a flag
> in the queue itself, or in the port.
> 
Yeah, not happy with that one, either.
Will be adding a queue flag.

>> +
>>   #ifdef CONFIG_NVME_TARGET_TCP_TLS
>>   /*
>>    * TLS handshake timeout
>> @@ -118,6 +122,7 @@ struct nvmet_tcp_cmd {
>>       u32                pdu_len;
>>       u32                pdu_recv;
>>       int                sg_idx;
>> +    char                recv_cbuf[CMSG_LEN(sizeof(char))];
>>       struct msghdr            recv_msg;
>>       struct bio_vec            *iov;
>>       u32                flags;
>> @@ -1116,20 +1121,59 @@ static inline bool nvmet_tcp_pdu_valid(u8 type)
>>       return false;
>>   }
>> +static int nvmet_tcp_tls_record_ok(struct nvmet_tcp_queue *queue,
>> +        struct msghdr *msg, char *cbuf)
>> +{
>> +    struct cmsghdr *cmsg = (struct cmsghdr *)cbuf;
>> +    u8 ctype, level, description;
>> +    int ret = 0;
>> +
>> +    if (!nvmet_queue_is_tls(queue))
>> +        return 0;
>> +
>> +    ctype = tls_get_record_type(queue->sock->sk, cmsg);
>> +    switch (ctype) {
>> +    case 0:
>> +        break;
>> +    case TLS_RECORD_TYPE_DATA:
>> +        break;
>> +    case TLS_RECORD_TYPE_ALERT:
>> +        tls_alert_recv(queue->sock->sk, msg, &level, &description);
>> +        pr_err("TLS Alert level %u desc %u\n", level, description);
>> +        ret = (level == TLS_ALERT_LEVEL_FATAL) ?
>> +            -ENOTCONN : -EAGAIN;
>> +        break;
>> +    default:
>> +        /* discard this record type */
>> +        pr_err("TLS record %d unhandled\n", ctype);
>> +        ret = -EAGAIN;
>> +        break;
>> +    }
>> +    return ret;
>> +}
>> +
>>   static int nvmet_tcp_try_recv_pdu(struct nvmet_tcp_queue *queue)
>>   {
>>       struct nvme_tcp_hdr *hdr = &queue->pdu.cmd.hdr;
>> -    int len;
>> +    int len, ret;
>>       struct kvec iov;
>> +    char cbuf[CMSG_LEN(sizeof(char))] = {};
>>       struct msghdr msg = { .msg_flags = MSG_DONTWAIT };
>>   recv:
>>       iov.iov_base = (void *)&queue->pdu + queue->offset;
>>       iov.iov_len = queue->left;
>> +    if (nvmet_queue_is_tls(queue)) {
>> +        msg.msg_control = cbuf;
>> +        msg.msg_controllen = sizeof(cbuf);
>> +    }
>>       len = kernel_recvmsg(queue->sock, &msg, &iov, 1,
>>               iov.iov_len, msg.msg_flags);
>>       if (unlikely(len < 0))
>>           return len;
>> +    ret = nvmet_tcp_tls_record_ok(queue, &msg, cbuf);
>> +    if (ret < 0)
>> +        return ret;
>>       queue->offset += len;
>>       queue->left -= len;
>> @@ -1182,16 +1226,21 @@ static void nvmet_tcp_prep_recv_ddgst(struct 
>> nvmet_tcp_cmd *cmd)
>>   static int nvmet_tcp_try_recv_data(struct nvmet_tcp_queue *queue)
>>   {
>>       struct nvmet_tcp_cmd  *cmd = queue->cmd;
>> -    int ret;
>> +    int len, ret;
>>       while (msg_data_left(&cmd->recv_msg)) {
>> -        ret = sock_recvmsg(cmd->queue->sock, &cmd->recv_msg,
>> +        len = sock_recvmsg(cmd->queue->sock, &cmd->recv_msg,
>>               cmd->recv_msg.msg_flags);
>> -        if (ret <= 0)
>> +        if (len <= 0)
>> +            return len;
>> +        ret = nvmet_tcp_tls_record_ok(cmd->queue,
>> +                          &cmd->recv_msg,
>> +                          cmd->recv_cbuf);
> 
> I think it will be better to condition on tls on the
> call sites, so it will be clearer that we are checking
> the tls record only for tls queues.

Ok, will be doing that.

Cheers,

Hannes


