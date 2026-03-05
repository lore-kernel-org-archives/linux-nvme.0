Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49DDBF30946
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Mar 2026 11:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6/cO57o76fPesWyAidaOu+qFZhUKADpjA63gFQ6riK8=; b=nMg+oOU6j2SX4FjaF0z3A6Q8zj
	ywCwvQQfqVvXmzepo6ew27PI0TnS+9WJon5efGfQe2gzdzuYwMVgOKDhS0K5NdKwMEjsGJSvyXRHD
	AkexlBHVw0+7L402RBweue7fu8CjPo9Ic7kV5rbOIIRBTrZZMtBhscUzmR9R/6bxe3gBgaqKQSFF/
	ELZUmHbb7Ln2NdZWY0BLqJp9REjUIoDakCTQN2fP+LJ93LTVcfnqSFMHbrZFiHzcstj5xY0GS6ZWp
	GoPKFY1CYag0SKRgtEsF1T6gfDEWf6aEMWK/qD2KRymXGHxCzzst6AjD/fSsb2UpwhhNIIQW17K4Y
	gdZUT7OQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vy76x-00000001h9r-15RL;
	Thu, 05 Mar 2026 11:43:23 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vy76u-00000001h9J-0rgX
	for linux-nvme@lists.infradead.org;
	Thu, 05 Mar 2026 11:43:21 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A712F5BCD5;
	Thu,  5 Mar 2026 11:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772710996; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6/cO57o76fPesWyAidaOu+qFZhUKADpjA63gFQ6riK8=;
	b=jbQ7I0Un1hw0X73PCJ/MRDT+1euzR8g6JbO/XDKTgUFFLNU8OJLPBO7LmGjgK3vZvyrdm3
	PMdOMu2qQ6NjJsCDX4DD07QH7uAb6lllSlJVsPMdTnPVnhXpHt0i6+6RJI8uBE3PXzDJaH
	zfTiuZJlprI0thOcSlPfSvCg321ftGU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772710996;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6/cO57o76fPesWyAidaOu+qFZhUKADpjA63gFQ6riK8=;
	b=BckCzbH7WRQ/992pT44zMmVLdiInnEF2A5+rPqgvwBMl/nO39vQV65bcBnRHkNxwaxseBp
	OKLHTgFgHq0656BQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=jbQ7I0Un;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BckCzbH7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772710996; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6/cO57o76fPesWyAidaOu+qFZhUKADpjA63gFQ6riK8=;
	b=jbQ7I0Un1hw0X73PCJ/MRDT+1euzR8g6JbO/XDKTgUFFLNU8OJLPBO7LmGjgK3vZvyrdm3
	PMdOMu2qQ6NjJsCDX4DD07QH7uAb6lllSlJVsPMdTnPVnhXpHt0i6+6RJI8uBE3PXzDJaH
	zfTiuZJlprI0thOcSlPfSvCg321ftGU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772710996;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6/cO57o76fPesWyAidaOu+qFZhUKADpjA63gFQ6riK8=;
	b=BckCzbH7WRQ/992pT44zMmVLdiInnEF2A5+rPqgvwBMl/nO39vQV65bcBnRHkNxwaxseBp
	OKLHTgFgHq0656BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7810B3EA68;
	Thu,  5 Mar 2026 11:43:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id opceHFRsqWmwQAAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 05 Mar 2026 11:43:16 +0000
Message-ID: <f6e8f196-7bd0-4f94-86e0-cb27c7e69d0a@suse.de>
Date: Thu, 5 Mar 2026 12:43:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/5] nvme-tcp: Support KeyUpdate
To: Alistair Francis <alistair23@gmail.com>
Cc: chuck.lever@oracle.com, hare@kernel.org,
 kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org,
 kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com, Alistair Francis <alistair.francis@wdc.com>
References: <20260304053500.590630-1-alistair.francis@wdc.com>
 <20260304053500.590630-5-alistair.francis@wdc.com>
 <103c958f-d5f9-47d3-9be8-dd7225368fd5@suse.de>
 <CAKmqyKPdJ2bgT2JaXi_38obyFTjRQ_rR5EdGmP81so8MEJNRVw@mail.gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <CAKmqyKPdJ2bgT2JaXi_38obyFTjRQ_rR5EdGmP81so8MEJNRVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid,suse.de:email]
X-Rspamd-Queue-Id: A712F5BCD5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260305_034320_420057_9BAC38EB 
X-CRM114-Status: GOOD (  25.99  )
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

On 3/4/26 12:37, Alistair Francis wrote:
> On Wed, Mar 4, 2026 at 5:40 PM Hannes Reinecke <hare@suse.de> wrote:
>>
>> On 3/4/26 06:34, alistair23@gmail.com wrote:
>>> From: Alistair Francis <alistair.francis@wdc.com>
>>>
>>> If the nvme_tcp_try_send() or nvme_tcp_try_recv() functions return
>>> EKEYEXPIRED then the underlying TLS keys need to be updated. This occurs
>>> on an KeyUpdate event as described in RFC8446
>>> https://datatracker.ietf.org/doc/html/rfc8446#section-4.6.3.
>>>
>>> If the NVMe Target (TLS server) initiates a KeyUpdate this patch will
>>> allow the NVMe layer to process the KeyUpdate request and forward the
>>> request to userspace. Userspace must then update the key to keep the
>>> connection alive.
>>>
>>> This patch allows us to handle the NVMe target sending a KeyUpdate
>>> request without aborting the connection. At this time we don't support
>>> initiating a KeyUpdate.
>>>
>>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>>> ---
>>> v7:
>>>    - Use read_sock_cmsg instead of recvmsg() to handle KeyUpdate
>>> v6:
>>>    - Don't use `struct nvme_tcp_hdr` to determine TLS_HANDSHAKE_KEYUPDATE,
>>>      instead look at the cmsg fields.
>>>    - Don't flush async_event_work
>>> v5:
>>>    - Cleanup code flow
>>>    - Check for MSG_CTRUNC in the msg_flags return from recvmsg
>>>      and use that to determine if it's a control message
>>> v4:
>>>    - Remove all support for initiating KeyUpdate
>>>    - Don't call cancel_work() when updating keys
>>> v3:
>>>    - Don't cancel existing handshake requests
>>> v2:
>>>    - Don't change the state
>>>    - Use a helper function for KeyUpdates
>>>    - Continue sending in nvme_tcp_send_all() after a KeyUpdate
>>>    - Remove command message using recvmsg
>>>
>>>    drivers/nvme/host/tcp.c | 59 ++++++++++++++++++++++++++++++++++++++++-
>>>    1 file changed, 58 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>>> index 8b6172dd1c0f..ade11d2ac9ef 100644
>>> --- a/drivers/nvme/host/tcp.c
>>> +++ b/drivers/nvme/host/tcp.c
>>> @@ -171,6 +171,7 @@ struct nvme_tcp_queue {
>>>        bool                    tls_enabled;
>>>        u32                     rcv_crc;
>>>        u32                     snd_crc;
>>> +     key_serial_t            handshake_session_id;
>>>        __le32                  exp_ddgst;
>>>        __le32                  recv_ddgst;
>>>        struct completion       tls_complete;
>>> @@ -1361,6 +1362,59 @@ static int nvme_tcp_try_send(struct nvme_tcp_queue *queue)
>>>        return ret;
>>>    }
>>>
>>> +static void update_tls_keys(struct nvme_tcp_queue *queue)
>>> +{
>>> +     int qid = nvme_tcp_queue_id(queue);
>>> +     int ret;
>>> +
>>> +     dev_dbg(queue->ctrl->ctrl.device,
>>> +             "updating key for queue %d\n", qid);
>>> +
>>> +     ret = nvme_tcp_start_tls(&(queue->ctrl->ctrl),
>>> +                              queue, queue->ctrl->ctrl.tls_pskid,
>>> +                              HANDSHAKE_KEY_UPDATE_TYPE_RECEIVED);
>>> +
>>> +     if (ret < 0) {
>>> +             dev_err(queue->ctrl->ctrl.device,
>>> +                     "failed to update the keys %d\n", ret);
>>> +             nvme_tcp_fail_request(queue->request);
>>> +     }
>>> +}
>>> +
>>> +static int nvme_tcp_recv_cmsg(read_descriptor_t *desc,
>>> +                           struct sk_buff *skb,
>>> +                           unsigned int offset, size_t len,
>>> +                           u8 content_type)
>>> +{
>>> +     struct nvme_tcp_queue *queue = desc->arg.data;
>>> +     struct socket *sock = queue->sock;
>>> +     struct sock *sk = sock->sk;
>>> +
>>> +     switch (content_type) {
>>> +     case TLS_RECORD_TYPE_HANDSHAKE:
>>> +             if (len == 5) {
>>> +                     u8 header[5];
>>> +
>>> +                     if (!skb_copy_bits(skb, offset, header,
>>> +                                        sizeof(header))) {
>>> +                             if (header[0] == TLS_HANDSHAKE_KEYUPDATE) {
>>> +                                     dev_err(queue->ctrl->ctrl.device, "KeyUpdate message\n");
>>> +                                     release_sock(sk);
>>> +                                     update_tls_keys(queue);
>>> +                                     lock_sock(sk);
>>> +                                     return 0;
>>> +                             }
>>> +                     }
>>> +             }
>>> +
>>> +             break;
>>> +     default:
>>> +             break;
>>> +     }
>>
>> I think a simple 'if' condition would be sufficient here, or do you have
>> handling of other TLS record types queued somewhere?
>> And we should log unhandled TLS records.
> 
> I like this approach as it makes it really easy to handle more types
> in the future. I don't have any more record types queued anywhere so I
> can change it to an if statement.
> 
> Good point about logging unhandled records
> 
Which reminds me:
This is now a simple callback, and doesn't influence the main state machine.
In particular, we do _not_ reset the connection (as we did with the
original implementation) if we received an unhandled TLS record.

I guess we should be doing that nevertheless, as unhandled TLS records
also will include things like TLS Alert which really require us to
reset the connection.
Hmm?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

