Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B367C28B28
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Mar 2025 07:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uCJnaYfBV+bCveHsvLRPGjY00SQjzI4tFLM4k70eHG8=; b=K1IOAuwkYVG7nuO9VHai2Pl63f
	yUYIf8U1RHQfN2P1516DrKzg4YV0KPzFTZT0hVCDnFUTvjaLjxWQihl/xiUCbBiCpqO42zXBoHGYS
	JSxyxHaEPnb6i7ig6GMl7jBtNODdmhgVPHPiGNwIq615R6ErfRv9rpuCeOuQ7LxVP4TEGbbgWQGGy
	TFgnBRoQh++vjzDipz4PP0spYXpl57Ry/Wv9A50KwodN39T/mFsrTbKwg/8IPKpS5wJioFgeHR5bH
	MWAmS9pQlzwM6dUbpDImYVMWIQ+tGuLzynJM0T3avRNQiC7TNV1tdwykbqJs1i+X/NRqq0tsaZpQ+
	pSS0Le6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tsdO5-0000000ASxI-0ciX;
	Thu, 13 Mar 2025 07:53:53 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tsdLi-0000000ARXh-0Cir
	for linux-nvme@lists.infradead.org;
	Thu, 13 Mar 2025 07:51:27 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 353C921180;
	Thu, 13 Mar 2025 07:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741852284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uCJnaYfBV+bCveHsvLRPGjY00SQjzI4tFLM4k70eHG8=;
	b=d3f+Ib2hYiNQFRoP0LDfkid1rYwpV9Zec21KuIvdFIoiFt0o5uezAIxHRJWp2srC2df/ZW
	71DuQMIWGK0fXK6z9VpPWyhSn/VWkL6TTv7m2e7KHBdl5a3VB90GdHlkQhZBhqM0INa/cL
	7XYw/jRgrLe59vFn9KkprNLtuk/h5Ec=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741852284;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uCJnaYfBV+bCveHsvLRPGjY00SQjzI4tFLM4k70eHG8=;
	b=vIiANh1PBpqaqyWRcdGDgYPapfK3QDPw/xVwPB3zdoN+/N7EVZqWk1b5JsE0+aOTMhhoUc
	rHTNRMlEscRrblBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=d3f+Ib2h;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=vIiANh1P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741852284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uCJnaYfBV+bCveHsvLRPGjY00SQjzI4tFLM4k70eHG8=;
	b=d3f+Ib2hYiNQFRoP0LDfkid1rYwpV9Zec21KuIvdFIoiFt0o5uezAIxHRJWp2srC2df/ZW
	71DuQMIWGK0fXK6z9VpPWyhSn/VWkL6TTv7m2e7KHBdl5a3VB90GdHlkQhZBhqM0INa/cL
	7XYw/jRgrLe59vFn9KkprNLtuk/h5Ec=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741852284;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uCJnaYfBV+bCveHsvLRPGjY00SQjzI4tFLM4k70eHG8=;
	b=vIiANh1PBpqaqyWRcdGDgYPapfK3QDPw/xVwPB3zdoN+/N7EVZqWk1b5JsE0+aOTMhhoUc
	rHTNRMlEscRrblBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CEC48137BA;
	Thu, 13 Mar 2025 07:51:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OilfMHuO0mfrGQAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 13 Mar 2025 07:51:23 +0000
Message-ID: <deb1584c-67b8-4543-9017-9ca18a9ee7d8@suse.de>
Date: Thu, 13 Mar 2025 08:51:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_nvme-tcp=3A_fix_a_possible_UAF_when_failing_to_send?=
 =?UTF-8?B?IHJlcXVlc3TjgJDor7fms6jmhI/vvIzpgq7ku7bnlLFzYWdpZ3JpbUBnbWFpbC5j?=
 =?UTF-8?B?b23ku6Plj5HjgJE=?=
To: "zhang.guanghui@cestc.cn" <zhang.guanghui@cestc.cn>,
 Maurizio Lombardi <mlombard@bsdbackstore.eu>, sagi <sagi@grimberg.me>,
 mgurtovoy <mgurtovoy@nvidia.com>, kbusch <kbusch@kernel.org>,
 sashal <sashal@kernel.org>, "chunguang.xu" <chunguang.xu@shopee.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
 linux-nvme <linux-nvme@lists.infradead.org>,
 linux-block <linux-block@vger.kernel.org>
References: <2025021015413817916143@cestc.cn>
 <aed9dde7-3271-4b97-9632-8380d37505d9@grimberg.me>
 <202503071810452687957@cestc.cn> <D8DDP6LIPOKB.2ACTHLE9FPI2A@bsdbackstore.eu>
 <2025031309485746586710@cestc.cn>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <2025031309485746586710@cestc.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 353C921180
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250313_005126_234219_80C8F8BE 
X-CRM114-Status: GOOD (  14.06  )
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

On 3/13/25 02:48, zhang.guanghui@cestc.cn wrote:
> Yes, the problem here is that,  despite the nvme_tcp_try_send() failure, the target sends a response capsule for the command, leading to a UAF in the host.
> 
> Is it more reasonable to disable queue->rd_enabled to prevent receiving. Thanks
>   
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index be04c5f3856d..17407eb12ad9 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1203,8 +1203,9 @@ static int nvme_tcp_try_send(struct nvme_tcp_queue *queue)
>          } else if (ret < 0) {
>                  dev_err(queue->ctrl->ctrl.device,
>                          "failed to send request %d\n", ret);
> -               nvme_tcp_fail_request(queue->request);
>                  nvme_tcp_done_send_req(queue);
> +              queue->rd_enabled = false;
> +              nvme_tcp_error_recovery(&queue->ctrl->ctrl);
>          }
>   out:
>          memalloc_noreclaim_restore(noreclaim_flag);
> 
> 
> 
Hmm. In principle, yes. Problem is that network is a bi-directional 
communication, and a failure on one side doesn't necessarily imply
a failure on the other.
In particular when the send side fails we should _continue_ to read
as we should be flushing the read side buffer before closing.

So I agree with starting error recovery, but not with disabling the 
reading side (as we haven't encountered a read error).

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

