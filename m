Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CA37C433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Oct 2022 06:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:Subject:From:References:Cc:To:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lZ0P249zbpPFNjYWcdlNsvsiBBnl0T6qoUiGa9ssnrU=; b=rQ12JMzWQ6W90US2lKwiF/AY1M
	Is19rCd4E2lGY+tFfitcCsxXaQWRFbIkHs+TXNdSldG5q4wfiS80/fmspZ5KQ74IAR1AmyKiK7mf7
	BiJZ/ZYbZeL9at/O8aCXNVSvBUNqRdFA+Lwd2/TspGJYBUBUglmm+l//7itlo+RdRwj/pH83HoOVd
	mErezPLfH69oa+SXPLRqDdjOp3YY9/4ZKGfWMt7xO6/NsbLRELhoSsAYPT+/KeIfShav5UMg7AQdl
	a859AqFifFRxNyP2VZcRXfQntT0TIITnHwD8UBEPX+gwnw3gtqjlq1CdKpi4EnHLO7EIKMcqJoQnt
	zUFs+34g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ona7C-008IIp-HM; Wed, 26 Oct 2022 06:42:14 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ona75-008IEq-Le
	for linux-nvme@lists.infradead.org; Wed, 26 Oct 2022 06:42:11 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2781321FCA;
	Wed, 26 Oct 2022 06:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1666766522; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lZ0P249zbpPFNjYWcdlNsvsiBBnl0T6qoUiGa9ssnrU=;
	b=IaaDqUUWH+IPHsCjW+AeOV3CAFv8fM4PM59PC3CWRT54wgmV1xpE5WOME8k3UnN5NjdFIL
	7zlUjknPWVztmgQHYcFrZTY33VdVIp5oTutsfQn1Xh6EtFyUFdr8LlKDy/AAGaLGLQzeR0
	4J8qTIHMNbIp6zFH/X+sDCwuoaHCUzQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1666766522;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lZ0P249zbpPFNjYWcdlNsvsiBBnl0T6qoUiGa9ssnrU=;
	b=x1K/pIwNqOTJOBNg+mu+8uen86MLEvMWgRvAPXwVC82AdiXhU0TSo6JiMwFhnLV+lPpxJq
	hysxxhEvHHhD0ABQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1223F13A6E;
	Wed, 26 Oct 2022 06:42:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id FnebArrWWGMlBwAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 26 Oct 2022 06:42:02 +0000
Message-ID: <853f0eb7-1f0f-eefe-fd32-0b1a1a98d3d7@suse.de>
Date: Wed, 26 Oct 2022 08:42:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
To: Sagi Grimberg <sagi@grimberg.me>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: Damien Le Moal <Damien.LeMoal@wdc.com>
References: <20221018080350.zir6xm6dnr4wgb7j@shindev>
 <93e16b0e-4fa0-c0e1-6cc5-dec018db5f5c@grimberg.me>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
Subject: Re: bad unlock balance WARNING at nvme/045
In-Reply-To: <93e16b0e-4fa0-c0e1-6cc5-dec018db5f5c@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221025_234207_874811_2037952B 
X-CRM114-Status: GOOD (  19.33  )
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

On 10/18/22 12:57, Sagi Grimberg wrote:
> 
>> Hello Hannes,
>>
>> I observed "WARNING: bad unlock balance detected!" at nvme/045 [1]. As 
>> the Call
>> Trace shows, nvme_auth_reset() has unbalanced mutex lock/unlock.
>>
>>     mutex_lock(&ctrl->dhchap_auth_mutex);
>>     list_for_each_entry(chap, &ctrl->dhchap_auth_list, entry) {
>>         mutex_unlock(&ctrl->dhchap_auth_mutex);
>>         flush_work(&chap->auth_work);
>>         __nvme_auth_reset(chap);
>>     }
>>     mutex_unlock(&ctrl->dhchap_auth_mutex);
>>
>> I tried to remove the mutex_unlock in the list iteration with a patch 
>> [2], but
>> it resulted in another "WARNING: possible recursive locking detected" 
>> [3]. I'm
>> not sure but cause of this WARN could be __nvme_auth_work and
>> nvme_dhchap_auth_work in same nvme_wq.
>>
>> Could you take a look for fix?
> 
> I'm looking at the code and I think that the way the concurrent
> negotiations and how dhchap_auth_mutex is handled is very fragile,
> also why should the per-queue auth_work hold the controller-wide
> dhchap_auth_mutex? The only reason I see is because nvme_auth_negotiate
> is checking if the chap context is already queued? Why should we
> allow that?
> 
Well; that's partially due to the internal design of linux-nvme.
The controller structure itself doesn't have 'queues' per se; there just 
is a general 'ctrl' structure. So while I would have loved to have a 
per-queue structure to hook the chap authentication into, all I have is 
the controller structure.
Hence we have a controller-wide list holding all 'chap' structures for 
the individual queues.
Hence the controller-wide mutex to gate list modifications.

> I'd suggest to splice dhchap_auth_list, to a local list and then just
> flush nvmet_wq in teardown flows. Same for renegotiations/reset flows.
> And we should prevent for the double-queuing of chap negotiations to
> begin with, instead of handling them (I still don't understand why this
> is permitted, but perhaps just return EBUSY in this case?)

We don't double queue; we're re-using the existing entries.

Can you check if this fix works?

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index c8a6db7c4498..4e824aab30eb 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -926,7 +926,6 @@ void nvme_auth_reset(struct nvme_ctrl *ctrl)

         mutex_lock(&ctrl->dhchap_auth_mutex);
         list_for_each_entry(chap, &ctrl->dhchap_auth_list, entry) {
-               mutex_unlock(&ctrl->dhchap_auth_mutex);
                 flush_work(&chap->auth_work);
                 __nvme_auth_reset(chap);
         }

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer


