Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57F9FC48BF6
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 12:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3mpMjAkuusoK8/oj/Vn3W9+94PIyIUmYBJcgPVcBd1c=; b=RomPdfA8d+UQtWTTJ/Eq17Uckl
	oTiqTjXYZyZaG7r/XSz0QmEgEdCpTCKqaBUGLsa6KYkTumzkL/tvJQDxhONUdgNrjbpK/Br8fu+DY
	nGW/k4bE6z6jjqsp91lJQW+O5bxghM4PAEF66cDq/jyPu31PljNaXCxkCmJJWIsjCI4mzCG+5v1a5
	yzgYqcn3PjZsACtFJSakSR2rFvh5G13N9GmGtBzXcLvQZuF7jtp/QHuckfjbBD1IyR8MjbtJhGBjq
	gD+SOKB0GRHpLH0DDzFY5Odw+pHmmFruIIeTyggpJabha9cWInwVHBh+JrfutowS6Pyk8PND9ZrOf
	PUKWP+Fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riCgh-00000004WjD-3uke;
	Thu, 07 Mar 2024 12:17:27 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riCgc-00000004WgS-0aCN
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 12:17:25 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CDD27770FC;
	Thu,  7 Mar 2024 11:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709811724; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3mpMjAkuusoK8/oj/Vn3W9+94PIyIUmYBJcgPVcBd1c=;
	b=GNNrVc55NUE+1mJ67572mnClmmOCf5OlVx2BoVQ8S5KPZwdKRXIHfqt90/NPZwKhXenLXj
	DCtiY58GqWlSOpYCahf6M9ybT1ALGiwpBq2mkD9+Cf89WHyAdk+uGDlvCz6X9TjpxIWZa8
	Qr23+bw7eDrIoEVmBTjZZPZY6hLxhlE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709811724;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3mpMjAkuusoK8/oj/Vn3W9+94PIyIUmYBJcgPVcBd1c=;
	b=aR7z7sTFl3QZ04PfHnPjHFWTjU/AWlgxJbZ1bzJ1Awvb7Qq+ogBGOdi1PQmHlpCYhga53n
	SRha6jJ2XJB57qCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709811724; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3mpMjAkuusoK8/oj/Vn3W9+94PIyIUmYBJcgPVcBd1c=;
	b=GNNrVc55NUE+1mJ67572mnClmmOCf5OlVx2BoVQ8S5KPZwdKRXIHfqt90/NPZwKhXenLXj
	DCtiY58GqWlSOpYCahf6M9ybT1ALGiwpBq2mkD9+Cf89WHyAdk+uGDlvCz6X9TjpxIWZa8
	Qr23+bw7eDrIoEVmBTjZZPZY6hLxhlE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709811724;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3mpMjAkuusoK8/oj/Vn3W9+94PIyIUmYBJcgPVcBd1c=;
	b=aR7z7sTFl3QZ04PfHnPjHFWTjU/AWlgxJbZ1bzJ1Awvb7Qq+ogBGOdi1PQmHlpCYhga53n
	SRha6jJ2XJB57qCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BC5EB12FC5;
	Thu,  7 Mar 2024 11:42:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3HW1LAyo6WVrOwAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 07 Mar 2024 11:42:04 +0000
Message-ID: <9908769d-cc6b-4517-9ed4-53cf53fee639@suse.de>
Date: Thu, 7 Mar 2024 12:42:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/13] nvme-tcp: sanitize TLS key handling
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, hare@kernel.org,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240127093058.15699-1-hare@kernel.org>
 <20240127093058.15699-10-hare@kernel.org>
 <438bb4bc-1102-41db-9ecc-af8fb0e42d07@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <438bb4bc-1102-41db-9ecc-af8fb0e42d07@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=GNNrVc55;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=aR7z7sTF
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.60 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-2.10)[95.63%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Queue-Id: CDD27770FC
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_041722_785655_FDE9EB1C 
X-CRM114-Status: GOOD (  10.36  )
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

On 3/7/24 12:03, Sagi Grimberg wrote:
> 
> 
> On 27/01/2024 11:30, hare@kernel.org wrote:
>> From: Hannes Reinecke <hare@suse.de>
>>
>> There is a difference between TLS configured (ie the user has
>> provisioned/requested a key) and TLS enabled (ie the connection
>> is encrypted with TLS).
> 
> When would the latter happen without the former?
> 
No. Difference is that 'TLS configured' is a configuration setting
(ie the admin has specified --tls or --tls_key), and 'TLS enabled'
is the result once the queue has been established.

>> So to differentiate between those two states store the provisioned
>> key in opts->tls_key (as we're using the same TLS key for all queues)
>> and the key serial of the key negotiated by the TLS handshake
>> in queue->tls_key.
> 
> Does nvmet generate a different key for each queue?

No.

Cheers,

Hannes


