Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A603C48BF6
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 11:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WMhrNxd6exoOCRVPY9gsTZc1kcLzMZ6/pS3Xv365aa8=; b=dj3O8L73LFViugRo1V23rqnqMw
	z1LwRmC+rAqdBq50A0rWOfFQaH9gQLV01xCWFAed5A5orLOZ582YtIU6IttE/gX/MNTRBjv1ecjuY
	StcJQ0uxg1XJd1CdhKpxZRwsq8xpyW7jzb3O2Agpi4KrtlQtQmjVkUzZHztRkkT2eGeAQipBt+3x4
	UlfJe1JaNJh1SjORfc58Bw+rw+zoSUpnzDprClLfCf5EN4kYcDcszj7viGoY0EFTp77iGBl3a28KX
	iMIqWzUwjFhQRtA6FJH98h2eRGoIT60bUc89118ngzAuFh5P93HgVPv5biOr8+eRAuNq+jQIEwWDx
	S2wpRqBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riC9z-00000004Ms7-1K34;
	Thu, 07 Mar 2024 11:43:39 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riC9m-00000004MlQ-31Md
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 11:43:37 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5BD098C584;
	Thu,  7 Mar 2024 11:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709810377; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WMhrNxd6exoOCRVPY9gsTZc1kcLzMZ6/pS3Xv365aa8=;
	b=yLG0+1cYnfs//qDR1QoX8GUNn7rY95kMzSltRRYUQLTombTzExZk7W/2tSZCJ/Q6u85r3M
	4p61b9cXsrfSByJWGk5UwWl7hGorkCRBC1TMTaM8j5rbtc//qbH/6tYr8PXcY7PmrI5VyF
	y6w016rWkv8Ts4/Qru3bskdruGL5EqU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709810377;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WMhrNxd6exoOCRVPY9gsTZc1kcLzMZ6/pS3Xv365aa8=;
	b=1rF8KuRLXQW4xfQFaqzKmbYIbYEuIZHA3atIoczGLRxL2yvyQKBXs6Oy/t6Jd5hV1HMphv
	24rGzVkwsptDLfAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709810377; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WMhrNxd6exoOCRVPY9gsTZc1kcLzMZ6/pS3Xv365aa8=;
	b=yLG0+1cYnfs//qDR1QoX8GUNn7rY95kMzSltRRYUQLTombTzExZk7W/2tSZCJ/Q6u85r3M
	4p61b9cXsrfSByJWGk5UwWl7hGorkCRBC1TMTaM8j5rbtc//qbH/6tYr8PXcY7PmrI5VyF
	y6w016rWkv8Ts4/Qru3bskdruGL5EqU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709810377;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WMhrNxd6exoOCRVPY9gsTZc1kcLzMZ6/pS3Xv365aa8=;
	b=1rF8KuRLXQW4xfQFaqzKmbYIbYEuIZHA3atIoczGLRxL2yvyQKBXs6Oy/t6Jd5hV1HMphv
	24rGzVkwsptDLfAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3A5C212FC5;
	Thu,  7 Mar 2024 11:19:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nwO/Dcmi6WXqNQAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 07 Mar 2024 11:19:37 +0000
Message-ID: <90c1e888-af15-4c89-9839-68d128d963d6@suse.de>
Date: Thu, 7 Mar 2024 12:19:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] nvmet: return DHCHAP status codes from
 nvmet_setup_auth()
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240301112823.132570-1-hare@kernel.org>
 <20240301112823.132570-4-hare@kernel.org>
 <38d98acc-4042-4fef-af1d-cee2eccc98d8@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <38d98acc-4042-4fef-af1d-cee2eccc98d8@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yLG0+1cY;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=1rF8KuRL
X-Spamd-Result: default: False [-2.36 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-2.06)[95.39%];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Queue-Id: 5BD098C584
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_034326_977345_184B3DB8 
X-CRM114-Status: UNSURE (   9.74  )
X-CRM114-Notice: Please train this message.
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

On 3/7/24 09:56, Sagi Grimberg wrote:
> 
> 
> On 01/03/2024 13:28, Hannes Reinecke wrote:
>> A failure in nvmet_setup_auth() does not mean that the NVMe
>> authentication command failed, so we should rather return a
>> protocol error with a 'failure1' response than an NVMe status.
> 
> Shouldn't nvmet reply NVME_SC_INTERNAL like in other similar
> cases?

No. NVME_SC_INTERNAL will be converted into a status code for the 
authentication _command_, indicating that the authentication
_command_ encountered an error.
But authentication _command_ is fine (ie it got send and received
okay). It's the authentication itself which failed, so we need to
return an authentication protocol failure state.

Cheers,

Hannes


