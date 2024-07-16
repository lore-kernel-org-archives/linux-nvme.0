Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BA5FC3DA49
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Jul 2024 10:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WdKtjRTwOIt7k4JaJtjnwT0KE/WaLnugRaqQ1yyt8i8=; b=c4gOhUsS5zoT7FVn8/ynnBq+CM
	cqDOdNYT3+U3COYeoWv8EZH6+mdEZfapCk4FQ19HRB0egX+MmFBz/OUarbA26ikH9uPYdemhlYK5J
	gfh7qtc0tdm28ncmeTIQm1YNxlvN149FNIjpbPE02P+BmWee+G3MkdzRe4iJJMcj0icvGTK+GsK8N
	Lxh2DWFvfaw/ujpBC01G35aw2I1BoFm0dvKVFLcxnUIzWcltT7VXOO3rTb/1R1oRCtds8nQamOQE4
	nnPEX0etz3O58WGs51JJ5Fojc/WRkWELemKXh2Si5vT2mttKKHTqY8SQXM7tkNgFx4O0QDROQVhPp
	VWFBcNFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTfYE-0000000A4X2-2gNB;
	Tue, 16 Jul 2024 10:36:54 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTfY9-0000000A4VL-49KT
	for linux-nvme@lists.infradead.org;
	Tue, 16 Jul 2024 10:36:53 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2EFD21F8AC;
	Tue, 16 Jul 2024 10:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721126208; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WdKtjRTwOIt7k4JaJtjnwT0KE/WaLnugRaqQ1yyt8i8=;
	b=DG7X1yhQ7idojnjCzNdAZte2vI35I8Mu/YYl044QpI9L4LvrpsjBsm+gdt0UvJoLTJ6Ke/
	bG4UfuTwujKMnaMoeypNzC6WG5Tx5r1Zwailv/cd09N3W0MBce0j13eKEmU5isYeViFyki
	L5wcPliVjW1pYtLDj/h6ZqXuVKvBgpo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721126208;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WdKtjRTwOIt7k4JaJtjnwT0KE/WaLnugRaqQ1yyt8i8=;
	b=rmyNpWo1Sf0GEd3e7ZegGR4stQXjg3QV5mnlHVnUKpeT5VAAZVMauTejznBpJzd5Ylb/88
	XHC4yzunV7TnC6CA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DG7X1yhQ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=rmyNpWo1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721126208; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WdKtjRTwOIt7k4JaJtjnwT0KE/WaLnugRaqQ1yyt8i8=;
	b=DG7X1yhQ7idojnjCzNdAZte2vI35I8Mu/YYl044QpI9L4LvrpsjBsm+gdt0UvJoLTJ6Ke/
	bG4UfuTwujKMnaMoeypNzC6WG5Tx5r1Zwailv/cd09N3W0MBce0j13eKEmU5isYeViFyki
	L5wcPliVjW1pYtLDj/h6ZqXuVKvBgpo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721126208;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WdKtjRTwOIt7k4JaJtjnwT0KE/WaLnugRaqQ1yyt8i8=;
	b=rmyNpWo1Sf0GEd3e7ZegGR4stQXjg3QV5mnlHVnUKpeT5VAAZVMauTejznBpJzd5Ylb/88
	XHC4yzunV7TnC6CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F3185136E5;
	Tue, 16 Jul 2024 10:36:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IkVaOT9NlmYIMgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 16 Jul 2024 10:36:47 +0000
Message-ID: <af243508-e5f3-4835-8d8e-c1bb741e22f3@suse.de>
Date: Tue, 16 Jul 2024 12:36:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] nvmet: support polling task for RDMA and TCP
To: Ping Gan <jacky_gam_2001@163.com>, sagi@grimberg.me, hch@lst.de,
 kch@nvidia.com, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: ping.gan@dell.com
References: <12556163-9efa-461f-826d-264350f4ca58@grimberg.me>
 <20240704081015.63584-1-jacky_gam_2001@163.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240704081015.63584-1-jacky_gam_2001@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_TO(0.00)[163.com,grimberg.me,lst.de,nvidia.com,lists.infradead.org,vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[163.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 2EFD21F8AC
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240716_033650_198157_5FFF47F9 
X-CRM114-Status: GOOD (  12.50  )
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

On 7/4/24 10:10, Ping Gan wrote:
>> On 02/07/2024 13:02, Ping Gan wrote:
[ .. ]
>>> And the bandwidth of a node is only 3100MB. While we used the patch
>>> and enable 6 polling task, the bandwidth can be 4000MB. It's a good
>>> improvement.
>>
>> I think you will see similar performance with unbound workqueue and
>> rps.
> 
> Yes, I remodified the nvmet-tcp/nvmet-rdma code for supporting unbound
> workqueue, and in same prerequisites of above to run test, and compared
> the result of unbound workqueue and polling mode task. And I got a good
> performance for unbound workqueue. For unbound workqueue TCP we got
> 3850M/node, it's almost equal to polling task. And also tested
> nvmet-rdma we get 5100M/node for unbound workqueue RDMA versus 5600M for
> polling task, seems the diff is very small. Anyway, your advice is good.
> Do you think we should submit the unbound workqueue patches for nvmet-tcp
> and nvmet-rdma to upstream nvmet?

Please do. I have been using pretty much the same patch during
development of my nvme-tcp scalability patchset, and using WQ_UNBOUND
definitely improves the situation here.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


