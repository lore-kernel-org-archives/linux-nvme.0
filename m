Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 972D6D1036D
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Nov 2025 00:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sA8Pu6GjexaoK5oqKYEEM1+zYvyY2pk2eGWfIX+7D+A=; b=XZjw0zqd0wDGUjelboUX+Fp25g
	IVqGbNkgpzlRj5jAf27gmPtsu2bLAXpIi/RruQiuXqP9L1X3sJqwOFfx6EJTdY7TbwSdYEIpe1quj
	tPWTKxxtxgdTXeZyY5ciSZn8kBnS3sPb5riSWNWJqtU6cIClLfl1mnwEQxJw/JBrM7RFKP260fzFt
	3Lh73LE9SVWj+UZwOMrs+MbZsdvCKMWQBky2PqMdg6+ijx5Hwm9gmv/speTFRTZdufMAHxX3+hqTg
	sDhwtUX/vh9hOBVBzNG/SErx/i8Iz4ZschbaC4VJiwXzsAsLnTkdDduDCVJFxHJuZbHM1YxZq3IaL
	KTgSA37A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vO3C3-0000000E6uv-3QHO;
	Wed, 26 Nov 2025 00:15:35 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vO3C0-0000000E6uM-3Pun
	for linux-nvme@lists.infradead.org;
	Wed, 26 Nov 2025 00:15:34 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 308B45BD90;
	Wed, 26 Nov 2025 00:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764116129;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sA8Pu6GjexaoK5oqKYEEM1+zYvyY2pk2eGWfIX+7D+A=;
	b=UsdBUXk7cHjnJmRnaEU9hwoSxw0u7xi4eJ7jNFn9HnGssZlkNWZwdsLkIFz6V7a/SxLO7k
	OH5tJDOxwP/Cl0D6TUMN5AK/ss8iFCHysTYANRW30I35VkHoEyNxFkIF+et3rKSAPWL2i9
	Gu2k8Q6/z0Fc4chb2nz+CHvF58tq7xI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764116129;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sA8Pu6GjexaoK5oqKYEEM1+zYvyY2pk2eGWfIX+7D+A=;
	b=Z8/2IXWSnC/1meP7MKHEHDgoVGl8DCZqvPJf7YYACY20+CPKSEcP1d07fy9qMQ8h3ocl+1
	vMCeTvZoyKtQ41Aw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764116128;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sA8Pu6GjexaoK5oqKYEEM1+zYvyY2pk2eGWfIX+7D+A=;
	b=H+36ZQqE6tsgUZ3p0kXsOW6BF7+6g0EZJHttR9rj89roCzcqq0wwoYiI4VTpdvNwTtOhE5
	9u8I4U3p0u7Pgwl/XC77T1G6YADulSY7UGLDPRKsrms/UfSaUHkZeTnd2/O76m7fmMBg6j
	d5cBTfku1bJoGCuYrdhv8+Pr3xQQsoc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764116128;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sA8Pu6GjexaoK5oqKYEEM1+zYvyY2pk2eGWfIX+7D+A=;
	b=ZTyNsXx1x8aGHhtcF6r32cj8hJYdXoDcA8FgNYhp+sToGjV0IzY9+Bgm1d+N/q0ICBD6vQ
	n9RM9j8RSSAWfqDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1819E3EA63;
	Wed, 26 Nov 2025 00:15:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fqy4BaBGJmmAEgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 26 Nov 2025 00:15:28 +0000
Date: Wed, 26 Nov 2025 01:15:26 +0100
From: David Sterba <dsterba@suse.cz>
To: Wol <antlists@youngman.org.uk>
Cc: Justin Piszcz <jpiszcz@lucidpixels.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-nvme@lists.infradead.org,
	linux-raid@vger.kernel.org,
	Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: WD Red SN700 4000GB, F/W: 11C120WD (Device not ready; aborting
 reset, CSTS=0x1)
Message-ID: <20251126001526.GA13846@twin.jikos.cz>
References: <CAO9zADxCYgQVOD9A1WYoS4JcLgvsNtGGr4xEZm9CMFHXsTV8ww@mail.gmail.com>
 <07500979-eca8-4159-b2a5-3052e9958c84@youngman.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07500979-eca8-4159-b2a5-3052e9958c84@youngman.org.uk>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,twin.jikos.cz:mid];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251125_161533_002696_801BA94A 
X-CRM114-Status: UNSURE (   8.34  )
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
Reply-To: dsterba@suse.cz
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Nov 25, 2025 at 06:25:41PM +0000, Wol wrote:
> Probably not the problem, but how old are the drives? About 2020, WD 
> started shingling the Red line (you had to move to Red Pro to get 
> conventional drives).

The WD SN700 is an NVMe, though one can imagine how they could be
actually shingled with slightly tilted overlapping sockets.

