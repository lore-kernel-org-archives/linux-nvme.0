Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4207CC4167B
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Dec 2023 11:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GzNPiWvCWPpJha7Di10zZ8P7DHj/KiiW0Z+dxfhni6M=; b=IfLcpVIdAY7hCG1xL7/cOzPAL6
	bXpumQJOgP+zLdH/Vv6+oMwjpoqSNwvRf268SHnM68eS2uvoa9atlIbXCKkogcylpCbnNBRJBINYE
	7hLGW6t3S2B6VcdrhJS8bt3VDwcp67/Das+s0QmTE1SOCgINKTRGVSbaOKE2wAwELtGFNS9Wf/IxZ
	3Wyp4Su6JONXhNG44BSuFYzaF7UejL2dXXX/EPB/+80W96SiDesXYNixGoL/NsM2lK0rjQgXq3T8v
	haz7EyXPHXVsPW09DSA4owF9TLZT9bbBsmWahA+70I4h+VzT6DgSYE04F9Az4OGiq3BuDA6giOaX8
	jhKn4x0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rA7Rx-003gvh-09;
	Mon, 04 Dec 2023 11:49:21 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rA7Rt-003gtu-15
	for linux-nvme@lists.infradead.org;
	Mon, 04 Dec 2023 11:49:19 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2B8D222097;
	Mon,  4 Dec 2023 11:49:15 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E63EE139AA;
	Mon,  4 Dec 2023 11:49:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id o/VaN7q8bWWudgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 04 Dec 2023 11:49:14 +0000
Message-ID: <c261fe62-e8e6-4470-b9e2-3047fd4c3d99@suse.de>
Date: Mon, 4 Dec 2023 12:49:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvmet-rdma: avoid circular locking dependency on
 install_queue()
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20231102141903.66515-1-hare@suse.de>
 <20231102141903.66515-2-hare@suse.de> <20231103082305.GA17096@lst.de>
 <69b6f873-f8a1-482b-a739-b47da6e98cec@suse.de>
 <20231103091952.GA18200@lst.de>
 <e09869f2-193b-4f03-a12f-2a7f6c24d537@suse.de> <20231103140514.GA2395@lst.de>
 <d5ef550d-91da-4135-959d-e10f153514a0@grimberg.me>
 <52bd0ef3-b91e-492e-8117-41a290b6cfe6@grimberg.me>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <52bd0ef3-b91e-492e-8117-41a290b6cfe6@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: ++++++++++++
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out1.suse.de;
	dkim=none;
	spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:97 is neither permitted nor denied by domain of hare@suse.de) smtp.mailfrom=hare@suse.de;
	dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.de (policy=none)
X-Rspamd-Queue-Id: 2B8D222097
X-Spamd-Result: default: False [12.29 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-0.00)[32.20%];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 R_SPF_SOFTFAIL(4.60)[~all:c];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_SPAM_SHORT(1.99)[0.663];
	 MX_GOOD(-0.01)[];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[];
	 DMARC_POLICY_SOFTFAIL(0.10)[suse.de : No valid SPF, No valid DKIM,none]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231204_034917_792920_8B85F530 
X-CRM114-Status: GOOD (  22.01  )
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

On 12/4/23 11:19, Sagi Grimberg wrote:
> 
> 
> On 11/20/23 15:48, Sagi Grimberg wrote:
>>
>>>> According to 777dc82395de ("nvmet-rdma: occasionally flush ongoing
>>>> controller teardown") this is just for reducing the memory footprint.
>>>> Wonder if we need to bother, and whether it won't be better to remove
>>>> the whole thing entirely.
>>>
>>> Well, Sagi added it, so I'll let him chime in on the usefulness.
>>
>> While I don't like having nvmet arbitrarily replying busy and instead
>> have lockdep simply just accept that its not a deadlock here, but we can
>> simply just sidetrack it as proposed I guess.
>>
>> But Hannes, this is on the other extreme.. Now every connect that nvmet
>> gets, if there is even a single queue that is disconnecting (global
>> scope), then the host is denied. Lets give it a sane backlog.
>> We use rdma_listen backlog of 128, so maybe stick with this magic
>> number... This way we are busy only if more than 128 queues are tearing
>> down to prevent the memory footprint from exploding, and hopefully it is
>> rare enough that the normal host does not see an arbitrary busy
>> rejection.
>>
>> Same comment for nvmet-tcp.
> 
> Hey Hannes, anything happened with this one?
> 
> Overall I think that the approach is fine, but I do think
> that we need a backlog for it.

Hmm. The main issue here is the call to 'flush_workqueue()', which 
triggers the circular lock warning. So a ratelimit would only help
us so much; the real issue is to get rid of the flush_workqueue()
thingie.

What I can to is to add this:

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 4cc27856aa8f..72bcc54701a0 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -2119,8 +2119,20 @@ static u16 nvmet_tcp_install_queue(struct 
nvmet_sq *sq)
                 container_of(sq, struct nvmet_tcp_queue, nvme_sq);

         if (sq->qid == 0) {
+               struct nvmet_tcp_queue *q;
+               int pending = 0;
+
                 /* Let inflight controller teardown complete */
-               flush_workqueue(nvmet_wq);
+               mutex_lock(&nvmet_tcp_queue_mutex);
+               list_for_each_entry(q, &nvmet_tcp_queue_list, queue_list) {
+                       if (q->nvme_sq.ctrl == sq->ctrl &&
+                           q->state == NVMET_TCP_Q_DISCONNECTING)
+                               pending++;
+               }
+               mutex_unlock(&nvmet_tcp_queue_mutex);
+               /* Retry for pending controller teardown */
+               if (pending)
+                       return NVME_SC_CONNECT_CTRL_BUSY;
         }

which then would only affect the controller we're connecting to.
Hmm?

Cheers,

Hannes


