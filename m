Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 052AED0C61B
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Oct 2024 14:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YbZ6IvrWZzggQVMX8ukV1QMEAzczd69eN/NFM2qvdTM=; b=oaISZiAXp4J7mt6qL2RgtMugEr
	oo+UCWSXGI/ZhH0WK56cN5OVVnM4psYqLGhV1MVZYLM/Htv11vPi6l7FZKla2GLmfGEdq1/Fg59ms
	32HejNtufgWtPiiBEfPSVcdgnpWmYwuLiIwNL98Xg44KwqTPVdKEZAFfF++Wvu1pokWYuokA1tSpb
	OcFn6VCaRVtl7YUPhrixiZlal8DYQ7NHsjPBL4ZwCvwSPCwLAWN7ZOwAd3LDY7erdjvcfvveJrXS+
	FZBN8oI8mu3Zm/rk+Y9En8d+s4vVse9eutr6GtUrHbpEXxBKuDybdBRaLqbuAWGXeR50i4QRMOJyV
	aTuo2jiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t4LYm-000000043zF-1RQA;
	Fri, 25 Oct 2024 14:45:04 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4LG8-000000040YJ-27Aj
	for linux-nvme@lists.infradead.org;
	Fri, 25 Oct 2024 14:25:52 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C7DE81F7F5;
	Fri, 25 Oct 2024 14:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729866347; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YbZ6IvrWZzggQVMX8ukV1QMEAzczd69eN/NFM2qvdTM=;
	b=rlvWl8sKRr7EOp3oTaPm9H3G3ZZlk0it7eXF0O1GUXavc9vNG6AkOZWAsP6y7Q5OeszHjM
	54F1TI1LgvLb3hReuMiaE0Kgniog99MtEjEb4rgbLB1a+GayQR8Cy4GLbkOdDNsNu5kah/
	ijRHG6w6GYZrvOEHn+Xe8f66FN1c6zI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729866347;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YbZ6IvrWZzggQVMX8ukV1QMEAzczd69eN/NFM2qvdTM=;
	b=6Eik6FEVNm0dnkMaMiLmXIXomOafvg6E+Ux7togFX0OlZfHxWyuZjHjS919RfX2+C3rd4S
	S+aRF9qxDXw32BBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=YiAcTtJ9;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=JrJzJuiG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729866346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YbZ6IvrWZzggQVMX8ukV1QMEAzczd69eN/NFM2qvdTM=;
	b=YiAcTtJ9gAVWtPL/d6U8Y3HxvNiKlBUPhQeTC40WXwk8+cSdP2pAPm9J/rWdnZFzcRjI55
	W5FXd9Er1TbUhFxNj9supLW78aGII8Mr9+q1DRvX25Us30Jqo9vYRlccW4lY7mIgvyQ8Pc
	ACdefCj/YW+9I36TicnXUdcI0LEvwjk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729866346;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YbZ6IvrWZzggQVMX8ukV1QMEAzczd69eN/NFM2qvdTM=;
	b=JrJzJuiG15RlhZQCPlGd8aF838Mj1GKokVUZkIsiP9hEXRRgD5ZmKT8DUxw0Igx0oGQAOB
	inkpMcBMSiR7cEBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AD166132D3;
	Fri, 25 Oct 2024 14:25:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id d33cJ2qqG2fNWgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 25 Oct 2024 14:25:46 +0000
Date: Fri, 25 Oct 2024 16:25:45 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests 06/15] nvme: fix fc port clean up failure
Message-ID: <c1e3d1f1-f176-4666-ac51-b8ddc7a45f4d@flourine.local>
References: <20241024010025.2216242-1-shinichiro.kawasaki@wdc.com>
 <20241024010025.2216242-7-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024010025.2216242-7-shinichiro.kawasaki@wdc.com>
X-Rspamd-Queue-Id: C7DE81F7F5
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241025_072548_723186_E824054E 
X-CRM114-Status: UNSURE (   8.71  )
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

On Thu, Oct 24, 2024 at 10:00:16AM GMT, Shin'ichiro Kawasaki wrote:
> Commit "nvme: sanitize transport parameter in _create_nvmet_port()"
> modified the wwnn and the wwpn names to be calculated based on port ID.
> However, this port dependent wwnn and wwpn calculation was not reflected
> to the clean up steps. This made the test case nvme/031 fail. To avoid
> the failure, add clean up steps based on the port ID.
> 
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Reviewed-by: Daniel Wagner <dwagner@suse.de>

