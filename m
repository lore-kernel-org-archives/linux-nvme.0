Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AEF7C197A0
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Nov 2023 16:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rnc5IyGiUHni0EoPKK8WXke1mpVoWxPCpE+uMz0xOcU=; b=gFOUxHKwEOT+GxyosjMyAroHcs
	+Mvx2o0aoiUeepiszJDEI7PJ2wdtPwlocEKtps59k7dWn4zUK0nH/RSs3vzhZbned10LkocVIcwJY
	OCFb9OUMvyb1U1pj5ndSCIcOL42drrRSlur0SCGYf9wnsdQF2VwBiJXw5lQW9Og7TZHOhi0sVdOl7
	msgTcigHurbVXVproKZro7fN3XSsTd5Qrw/ESMAi0N5pqwYCh5zP3sy8R/bArZrCbS+gyQHPvt2aV
	FrTUxzHL4FoKeDSHUGhqxgwjKaUE+yWSYaVelOcYcpBpHVljF46eWBy+v1SWrdLQhzd1iFkVLzm8Q
	beeYeyug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r56iU-00CywR-0a;
	Mon, 20 Nov 2023 16:01:42 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r56iQ-00Cyt6-2r
	for linux-nvme@lists.infradead.org;
	Mon, 20 Nov 2023 16:01:40 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A5C231F895;
	Mon, 20 Nov 2023 16:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1700496096; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rnc5IyGiUHni0EoPKK8WXke1mpVoWxPCpE+uMz0xOcU=;
	b=oXrBI5AgR6tEc2c4wj6SPp7zHXqPjQD/Hdx3uPhzJTRYVEKPypsdpO6nGdk9F49A32t26J
	FtnuD3nVbOZg/Lx/japO4yP+PPaSoXIM6GQTAmfZKLAjSTOstIaAEqi01u2WmddmvI4Rmg
	YoXm4W2YhbkrB7Ab81xt4bDaPleexwc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1700496096;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rnc5IyGiUHni0EoPKK8WXke1mpVoWxPCpE+uMz0xOcU=;
	b=XnD+bCljj9oqc32xv/XdbpnVBM4m/iIWYSknXiNXYk7Lj0j4MZ6KdBm+dbEAbGA2VL9E/J
	9xCF7FiEfd1/ZiBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8B6D013499;
	Mon, 20 Nov 2023 16:01:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id cRYHIeCCW2WBXAAAMHmgww
	(envelope-from <hare@suse.de>); Mon, 20 Nov 2023 16:01:36 +0000
Message-ID: <337014e5-f564-4f0e-8c3c-298156aa82f3@suse.de>
Date: Mon, 20 Nov 2023 17:01:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvme: start keep-alive after admin queue setup
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20231024061337.35621-1-hare@suse.de>
 <20231024061337.35621-4-hare@suse.de>
 <a1ce2c2e-4f67-4271-ac67-5a1e8c5ebfb1@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <a1ce2c2e-4f67-4271-ac67-5a1e8c5ebfb1@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-4.29 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 BAYES_HAM(-3.00)[100.00%];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231120_080139_070899_A14DDB20 
X-CRM114-Status: GOOD (  22.11  )
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

On 11/20/23 14:39, Sagi Grimberg wrote:
> 
>> Setting up I/O queues might take quite some time on larger and/or
>> busy setups, so KATO might expire before all I/O queues could be
>> set up.
>> Fix this by start keep alive from the ->init_ctrl_finish() callback,
>> and stopping it when calling nvme_cancel_admin_tagset().
> 
> If this is a fix, the title should describe the issue it is fixing, and
> the body should say how it is fixing it.
> 
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>   drivers/nvme/host/core.c | 6 +++---
>>   drivers/nvme/host/fc.c   | 6 ++++++
>>   2 files changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 62612f87aafa..f48b4f735d2d 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -483,6 +483,7 @@ EXPORT_SYMBOL_GPL(nvme_cancel_tagset);
>>   void nvme_cancel_admin_tagset(struct nvme_ctrl *ctrl)
>>   {
>> +    nvme_stop_keep_alive(ctrl);
>>       if (ctrl->admin_tagset) {
>>           blk_mq_tagset_busy_iter(ctrl->admin_tagset,
>>                   nvme_cancel_request, ctrl);
> 
> There is a cross dependency here, now nvme_cancel_admin_tagset needs to
> have the keep-alive stopped first, which may be waiting on I/O, which
> needs to be cancelled...
> 
> Keep in mind that kato can be arbitrarily long, and now this function
> may be blocked on this kato period.
> 
> I also think that now the function is doing something that is more
> than simply cancelling the inflight admin tagset, as it is named.
> 
I am having a hard time following this reasoning.
While I do accept that nvme_stop_keep_alive() might trigger I/O
(ie if the work queue has just been started when calling 
cancel_delayed_work), nvme_tcp_error_recovery_work() has this:

	nvme_stop_keep_alive(ctrl);
	flush_work(&ctrl->async_event_work);
	nvme_tcp_teardown_io_queues(ctrl, false);
	/* unquiesce to fail fast pending requests */
	nvme_unquiesce_io_queues(ctrl);
	nvme_tcp_teardown_admin_queue(ctrl, false);

and nvme_tcp_teardown_admin_queue() calls nvme_cancel_admin_tagset().
So by your above reasoning this code should be wrong, too.
What am I missing?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Ivo Totev, Andrew McDonald,
Werner Knoblich


