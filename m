Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FA95C5478C
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Feb 2024 07:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jkfgTQn2Flz28mu2sP9XaTttgWHta7CGixHrWUbzvkk=; b=KfdjD31Df18SIJOoOu5ewkTeD1
	eYkfpeHxIG/nJoldDk9Nqg8YuyX2bnc+E6pD8YXduVvlL/9IVfqiiFMJXU9Ufs8DVOLSd9nUT/boi
	3VYA5nPaslGvtfkSbS+dvrE6Ai05if78NOe36hRwf2GdiP60/9qI7YzqFg7ZnZT4Q7Omvv8YPTOXx
	IWPsBpac2/YycYGtxODxj5F4DCoBsfHuWmPZz45etOBB4STt7b6+vVaOfTXwJOKGF1gP67BpBD/3N
	dmKDE/LQTNWEFR13woNtsyJ5/72IVRVP3vJ5DTbaFgQS9TaV4XB4trN6uH0pvXmKO3TxAKfjv1qtK
	fvYTPSgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reVkK-0000000GsN5-2ADM;
	Mon, 26 Feb 2024 07:49:56 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reVkG-0000000GsKr-1r9O
	for linux-nvme@lists.infradead.org;
	Mon, 26 Feb 2024 07:49:55 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7465B22254;
	Mon, 26 Feb 2024 07:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708933790; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jkfgTQn2Flz28mu2sP9XaTttgWHta7CGixHrWUbzvkk=;
	b=KTK+jD3rEhQuJhEgqu0cfpOy2siwIZcfGX3Gxp0OUn8Iy6vO+UEbV3XbzR774PNIaAmywP
	GF4W8vFCI83Jf0AXnPcLoAoAH8QetY4a6rME+SwBEmv8d5879X86fxKQKYLvoi/IcSD22b
	ov24ME+sfHZC8unRxpJOWVQu5SAjX9Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708933790;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jkfgTQn2Flz28mu2sP9XaTttgWHta7CGixHrWUbzvkk=;
	b=B8FF6mw509X45fhNEZ2tfG9zs8+Q7bzXFwlfyyawSfApcs8SBgcmKGviEnC2o8hsc/UcKt
	XAF15IyKMFmixyAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708933790; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jkfgTQn2Flz28mu2sP9XaTttgWHta7CGixHrWUbzvkk=;
	b=KTK+jD3rEhQuJhEgqu0cfpOy2siwIZcfGX3Gxp0OUn8Iy6vO+UEbV3XbzR774PNIaAmywP
	GF4W8vFCI83Jf0AXnPcLoAoAH8QetY4a6rME+SwBEmv8d5879X86fxKQKYLvoi/IcSD22b
	ov24ME+sfHZC8unRxpJOWVQu5SAjX9Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708933790;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jkfgTQn2Flz28mu2sP9XaTttgWHta7CGixHrWUbzvkk=;
	b=B8FF6mw509X45fhNEZ2tfG9zs8+Q7bzXFwlfyyawSfApcs8SBgcmKGviEnC2o8hsc/UcKt
	XAF15IyKMFmixyAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5AC8D13A3A;
	Mon, 26 Feb 2024 07:49:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6otuFZ5C3GXxBgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 26 Feb 2024 07:49:50 +0000
Message-ID: <1870dc3d-6ef2-47ee-b4b3-2aa7638a77fb@suse.de>
Date: Mon, 26 Feb 2024 08:49:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: authentication error are always non-retryable
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
To: Daniel Wagner <dwagner@suse.de>, hare@kernel.org
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240223105804.44473-1-hare@kernel.org>
 <c7mv5rb3wfpjlttvgycihgn7fxlngrewpdtuhucqhodde6y3m6@nk7hvf4rwzdj>
 <beef936a-c3aa-4300-b141-ab37ad5d7bf1@suse.de>
In-Reply-To: <beef936a-c3aa-4300-b141-ab37ad5d7bf1@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.09 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-0.00)[39.47%];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240225_234952_675827_6F3E9446 
X-CRM114-Status: GOOD (  14.19  )
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

On 2/26/24 08:44, Hannes Reinecke wrote:
> On 2/23/24 14:29, Daniel Wagner wrote:
>> On Fri, Feb 23, 2024 at 11:58:04AM +0100, hare@kernel.org wrote:
>>> From: Hannes Reinecke <hare@suse.de>
>>>
>>> Any authentication errors which are generated internally are always
>>> non-retryable, so set the DNR bit to ensure they are not retried.
>>
>> This still keeps nvme-fc in the retry loop. It fails with -126 which is
>> -ENOKEY:
>>
>> [ 2267.185691] nvme nvme0: qid 0: no key
>> [ 2267.187596] nvme nvme0: qid 0: authentication setup failed
>> [ 2267.188866] nvme nvme0: NVME-FC{0}: create_assoc failed, assoc_id 
>> 2a3022dff0fe0000 ret -126
>>
> Aw. Bugger.
> Of course we do retry, as negative transport errors are considered 
> retryable. Curiously enough, negative _NVMe_ errors are considered 
> non-retryable. Hmph. We may want to work on that.
> 
So we'll need this one on top:

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 2b66fa5cd43f..2b1bac54010c 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -475,13 +475,15 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
                 if (ret) {
                         dev_warn(ctrl->device,
                                  "qid 0: authentication setup failed\n");
+                       ret = NVME_SC_AUTH_REQUIRED | NVME_SC_DNR;
                         goto out_free_data;
                 }
                 ret = nvme_auth_wait(ctrl, 0);
-               if (ret)
+               if (ret) {
                         dev_warn(ctrl->device,
                                  "qid 0: authentication failed\n");
-               else
+                       ret = NVME_SC_AUTH_REQUIRED | NVME_SC_DNR;
+               } else
                         dev_info(ctrl->device,
                                  "qid 0: authenticated\n");
         }

I'll send a proper patch.

Cheers,

Hannes


