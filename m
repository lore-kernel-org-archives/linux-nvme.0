Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B477DCCF9E3
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Nov 2025 10:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pvl6XZ232GSUFvC70qNdvJh7hVhwQCiFbz9tJi6d5Ww=; b=1SsUCqMX2pkaqlw+LnzF88VisB
	GLvyu3MsAn24v3goLbxl1lJWID6oRLUnKJ62ZYS9wONyhOmGeUGuB173+QY6/7FRDmsee8pYfJtfy
	40MiwvjyhhSXkXQlhMhhgIVTvhUbdEOuUPYM5SRX/Eqrm2JGQ3KePYA+rq9iD6heUjsnYCoqKeBti
	KCe6Zltu7zZ2RUzvTyuxbhW5duU/q4sDrPNH2GsMxhJbR4V47UXU5RWztOh0hrfnY4NQH8VGSwms0
	a0er4otDonf8xtr1vC3ST8EukUTofb8IMHbea/9Ss8gfRrLBVpnmrhrjAFhpWT+mnwCv/v55KtBwr
	/XNxQYiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGEdX-0000000Bf4F-0dtv;
	Tue, 04 Nov 2025 10:51:39 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGEdU-0000000Bf3h-3KoB
	for linux-nvme@lists.infradead.org;
	Tue, 04 Nov 2025 10:51:38 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1A71921167;
	Tue,  4 Nov 2025 10:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762253495; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pvl6XZ232GSUFvC70qNdvJh7hVhwQCiFbz9tJi6d5Ww=;
	b=JvqqbKWZsGSZJPfxnrSbDGxY2cPw/epWjApMxEEzT9X9CcuSMAtNsMrVoqrouJ7f35WSdu
	1NQaxfBKbM/7WuitelGBSz0Su6D/5H5Lycr6JRe9CJDPnWihsS7EMVEQiW+CuATwk0GEHO
	XbOg9Qs7nNBJTVNWcNkkEVCXzbapkbQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762253495;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pvl6XZ232GSUFvC70qNdvJh7hVhwQCiFbz9tJi6d5Ww=;
	b=jQsoz15l00m2J2O6JuH+I2yveeeIUGE2PNoJL5Lq0SAXVzBp2j9R5aB2Tj/+OcTHoT1j+F
	SbtV0sd+4SE0ZrDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762253495; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pvl6XZ232GSUFvC70qNdvJh7hVhwQCiFbz9tJi6d5Ww=;
	b=JvqqbKWZsGSZJPfxnrSbDGxY2cPw/epWjApMxEEzT9X9CcuSMAtNsMrVoqrouJ7f35WSdu
	1NQaxfBKbM/7WuitelGBSz0Su6D/5H5Lycr6JRe9CJDPnWihsS7EMVEQiW+CuATwk0GEHO
	XbOg9Qs7nNBJTVNWcNkkEVCXzbapkbQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762253495;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pvl6XZ232GSUFvC70qNdvJh7hVhwQCiFbz9tJi6d5Ww=;
	b=jQsoz15l00m2J2O6JuH+I2yveeeIUGE2PNoJL5Lq0SAXVzBp2j9R5aB2Tj/+OcTHoT1j+F
	SbtV0sd+4SE0ZrDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ED6A8139A9;
	Tue,  4 Nov 2025 10:51:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mAqPObbaCWlbbgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 04 Nov 2025 10:51:34 +0000
Message-ID: <db035c45-91e4-422e-820c-701c0a60bc3c@suse.de>
Date: Tue, 4 Nov 2025 11:51:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] nvme-fc: check all request and response have been
 processed
To: Daniel Wagner <wagi@kernel.org>, Justin Tee <justin.tee@broadcom.com>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Jens Axboe <axboe@kernel.dk>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251028-nvmet-fcloop-fixes-v1-0-765427148613@kernel.org>
 <20251028-nvmet-fcloop-fixes-v1-2-765427148613@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251028-nvmet-fcloop-fixes-v1-2-765427148613@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251104_025136_983191_C4B7705C 
X-CRM114-Status: GOOD (  11.74  )
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

On 10/28/25 16:26, Daniel Wagner wrote:
> When the rport is removed there shouldn't be any in flight request or
> responses.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/host/fc.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

