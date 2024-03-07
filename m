Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C5BFC54798
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 14:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FVsqeuZCf7wP7oVic4Vlb7w78aI5HGS6viBQbHD00pw=; b=Y4zqJ04zc1e8EoWAmxrafJ/OgT
	ZQRBOtw2pJG8JG6J9yyG1tvu4s2LcvGllStsUnDbgiK61weQZfopoYv5svC1SDS4gmDptDeTUerQJ
	tH+F1iCRD03MNgiztvvPoE8go/gDZkr0+w6uj54dojqP64P3VOYZJHbwOtSC9Ku3l3IyMkAZ2/3zz
	wC710TOIyooBzpUYTQbCdYZmhFXVnnqeBRrQcUmykeaRRzYOOyCc7Yp8VEO8AwpddP4LeEYOKeCQz
	mADoQa62rcsNOXFuylF/cOuEkeoSSENpjfB2iicco7u2dQcxAqvtbnV7FkUmyxOMf4kvXFDMjydP3
	D2L2TtJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riEQy-00000004y3U-0kg3;
	Thu, 07 Mar 2024 14:09:20 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riEQt-00000004y0y-0KkU
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 14:09:17 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 613F925777;
	Thu,  7 Mar 2024 12:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709815947; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FVsqeuZCf7wP7oVic4Vlb7w78aI5HGS6viBQbHD00pw=;
	b=PKX94h8/ylHaLrooR/zNzCol34chrap/nqQjlVaJ5M3Je5EkJjm2a4WySqV9Nf+wgatZPr
	f+W4mW8FYAj+pdXQF9apCuKqqWGeoVk8xyq4LcAnEfzneMaUtVIBIPLTPuhtH+eUVkmTOs
	M+BhBdFDCsHfnzOo5/GtKh4jKdPGG2g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709815947;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FVsqeuZCf7wP7oVic4Vlb7w78aI5HGS6viBQbHD00pw=;
	b=Q7rlOwPGwpmbTUitNvR2Iu2rgVU2wW6L51zpGaoecFPJRY6jVrPrfxSCyWH1utl5bnrLMA
	quzrAe1fChUtXVCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709815947; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FVsqeuZCf7wP7oVic4Vlb7w78aI5HGS6viBQbHD00pw=;
	b=PKX94h8/ylHaLrooR/zNzCol34chrap/nqQjlVaJ5M3Je5EkJjm2a4WySqV9Nf+wgatZPr
	f+W4mW8FYAj+pdXQF9apCuKqqWGeoVk8xyq4LcAnEfzneMaUtVIBIPLTPuhtH+eUVkmTOs
	M+BhBdFDCsHfnzOo5/GtKh4jKdPGG2g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709815947;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FVsqeuZCf7wP7oVic4Vlb7w78aI5HGS6viBQbHD00pw=;
	b=Q7rlOwPGwpmbTUitNvR2Iu2rgVU2wW6L51zpGaoecFPJRY6jVrPrfxSCyWH1utl5bnrLMA
	quzrAe1fChUtXVCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3FC40136BA;
	Thu,  7 Mar 2024 12:52:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dhkXD4q46WUlTQAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 07 Mar 2024 12:52:26 +0000
Message-ID: <b23a5c7c-a877-4cde-acd4-50c21c3ef1fc@suse.de>
Date: Thu, 7 Mar 2024 13:52:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] nvme-fabrics: short-circuit connect retries
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
 James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240305080005.3638-1-dwagner@suse.de>
 <22b01fb4-b543-43b2-949c-1873105dc343@grimberg.me>
 <72c1d3a8-14ad-43e8-a68a-25be903698c4@suse.de>
 <432a39d5-6d08-4d38-a357-7c8d9123189a@grimberg.me>
 <08f3d804-f94b-4a2f-897b-7fee3411e6fc@suse.de>
 <b02588cb-6fbc-4116-86d6-173c115f50c5@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <b02588cb-6fbc-4116-86d6-173c115f50c5@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-4.28 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.19)[-0.929];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_060915_308639_F2FF31A7 
X-CRM114-Status: GOOD (  22.91  )
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

On 3/7/24 13:14, Sagi Grimberg wrote:
> 
> 
> On 07/03/2024 13:45, Hannes Reinecke wrote:
>> On 3/7/24 12:30, Sagi Grimberg wrote:
>>>
[ .. ]
>>>
>>> Where is this retried today, I don't see where connect failure is 
>>> retried, outside of a periodic reconnect.
>>> Maybe I'm missing where what is the actual failure here.
>>
>> static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
>> {
>>         struct nvme_tcp_ctrl *tcp_ctrl =
>>                         container_of(to_delayed_work(work),
>>                         struct nvme_tcp_ctrl, connect_work);
>>         struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
>>
>>         ++ctrl->nr_reconnects;
>>
>>         if (nvme_tcp_setup_ctrl(ctrl, false))
>>                 goto requeue;
>>
>>         dev_info(ctrl->device, "Successfully reconnected (%d attempt)\n",
>>                         ctrl->nr_reconnects);
>>
>>         ctrl->nr_reconnects = 0;
>>
>>         return;
>>
>> requeue:
>>         dev_info(ctrl->device, "Failed reconnect attempt %d\n",
>>
>> and nvme_tcp_setup_ctrl() returns either a negative errno or an NVMe 
>> status code (which might include the DNR bit).
> 
> I thought this is about the initialization. yes today we ignore the 
> status in re-connection assuming that whatever
> happened, may (or may not) resolve itself. The basis for this assumption 
> is that if we managed to connect the first
> time there is no reason to assume that connecting again should fail 
> persistently.
> 
And that is another issue where I'm not really comfortable with.
While it would make sense to have the connect functionality to be
one-shot, and let userspace retry if needed, the problem is that we
don't have a means of transporting that information to userspace.
The only thing which we can transport is an error number, which
could be anything and mean anything.
If we had a defined way stating: 'This is a retryable, retry with the 
same options.' vs 'This is retryable error, retry with modified 
options.' vs 'This a non-retryable error, don't bother.' I'd be
fine with delegating retries to userspace.
But currently we don't.

> If there is a consensus that we should not assume it, its a valid 
> argument. I didn't see where this happens with respect
> to authentication though.

nvmf_connect_admin_queue():

             /* Authentication required */
             ret = nvme_auth_negotiate(ctrl, 0);
             if (ret) {
                     dev_warn(ctrl->device,
                              "qid 0: authentication setup failed\n");
                     ret = NVME_SC_AUTH_REQUIRED;
                     goto out_free_data;
             }
             ret = nvme_auth_wait(ctrl, 0);
             if (ret)
                     dev_warn(ctrl->device,
                              "qid 0: authentication failed\n");
             else
                     dev_info(ctrl->device,
                              "qid 0: authenticated\n");

The first call to 'nvme_auth_negotiate()' is just for setting up
the negotiation context and start the protocol. So if we get
an error here it's pretty much non-retryable as it's completely
controlled by the fabrics options.
nvme_auth_wait(), OTOH, contains the actual result from the negotiation,
so there we might or might not retry, depending on the value of 'ret'.

Cheers,

Hannes


