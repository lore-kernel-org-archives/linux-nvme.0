Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DBB7D18129
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Oct 2024 15:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Dm/MAMNFUnS4XyzI6pPb80UxIPxXdtfK6XrUBTXSYmY=; b=WTz1AilUOPaCkGrbAC3zCvfsUa
	RyQ8x/kX+7Xari1lCE+lKrk3WrSKekAD3juFwnUl9nGxM44bLeGhaOYDAGkBXSNQ73R7tGONwpjzL
	5B0qGh1G9RzlHDeP1gfK45gkuxiv71xB6CRDcjThZw+ZtgQeUVxYUMPAfMafUKvO06kI/sqpXx/XV
	dKiQATTTcI9lt8CqaddbXr7JePe79mKqQyyyctNv9Ky4drSAZsPPIEwkd3II7wzFR3lIYckiyLKi1
	NiTxOiXSYcLQfiV1ls37tbuX6sR8qqhL3gunGTQz8QmyNryoeBDSfurWzEKOK2YiLIUHa9sS0kXyQ
	vLXja59w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0NLY-00000005lYW-20hC;
	Mon, 14 Oct 2024 15:51:00 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0NKq-00000005lTM-0lU1
	for linux-nvme@bombadil.infradead.org;
	Mon, 14 Oct 2024 15:50:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Dm/MAMNFUnS4XyzI6pPb80UxIPxXdtfK6XrUBTXSYmY=; b=TWbhQ8AIcFM32MsllBYkj01v1F
	zWcQuEaecCdhTSUNJrg9BcwKCQYZlGDTKU3AEPt1YtoDD5CnKeznDArxDyPdtTK0UH4lGFIGKydTT
	TZbPf3kbBvHSNHyIBT0PEz2yCpON86fs0j7ymVNV4WIXC3v/EyTgryPxHt0pb4xCtExMEdwE9uTK5
	dAdQFgcAw7lWHxvQEA/162LivwaVogTqIchvd5I08i7Mvhw8kORtvXNORSJANvQ9U5VD+QSi4aAqS
	m+CmmEPw6tdbnEFeD9kwg8rG7Oe/AVr/KW8N4H6g/WlaLCuf+qgbuyPFp/c33mLG5Z5ESPp+c9NE7
	7W8lIa3A==;
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0NKk-00000006NRU-3fGw
	for linux-nvme@lists.infradead.org;
	Mon, 14 Oct 2024 15:50:13 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 953D121D30;
	Mon, 14 Oct 2024 15:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728921007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dm/MAMNFUnS4XyzI6pPb80UxIPxXdtfK6XrUBTXSYmY=;
	b=yC9v54nxkb9fHBbU9bANACysy10AiTQvv08W+6zPIRSOf4F48n+PUgW6826OeNdJZMoKBe
	3KrXF69X0badehzA5ZsWvIiPnpzF71EHKC9KuU3c0Ij8SQmAyS7k3nzipy/ycpdfahOmi0
	1lsJWoEVtxFchves7zGx5HXojKR8o4c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728921007;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dm/MAMNFUnS4XyzI6pPb80UxIPxXdtfK6XrUBTXSYmY=;
	b=qPF4wtAi9FnAKAmWAwww86oWzzsPObLJZPiXv78Ey4VO46yRn4sFfQMZ12or9jIH2hX6fn
	VWTE+E6zlOZ2OFAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yC9v54nx;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qPF4wtAi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728921007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dm/MAMNFUnS4XyzI6pPb80UxIPxXdtfK6XrUBTXSYmY=;
	b=yC9v54nxkb9fHBbU9bANACysy10AiTQvv08W+6zPIRSOf4F48n+PUgW6826OeNdJZMoKBe
	3KrXF69X0badehzA5ZsWvIiPnpzF71EHKC9KuU3c0Ij8SQmAyS7k3nzipy/ycpdfahOmi0
	1lsJWoEVtxFchves7zGx5HXojKR8o4c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728921007;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dm/MAMNFUnS4XyzI6pPb80UxIPxXdtfK6XrUBTXSYmY=;
	b=qPF4wtAi9FnAKAmWAwww86oWzzsPObLJZPiXv78Ey4VO46yRn4sFfQMZ12or9jIH2hX6fn
	VWTE+E6zlOZ2OFAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7A87713A51;
	Mon, 14 Oct 2024 15:50:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gSClG689DWcVAgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 14 Oct 2024 15:50:07 +0000
Date: Mon, 14 Oct 2024 17:50:06 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: nvme-tcp uaf when tls setup fails
Message-ID: <65b78364-4420-41f9-bca2-f59f854a51c7@flourine.local>
References: <8bb28305-01b3-4d68-bc74-bdbd9352b1c1@flourine.local>
 <5b68b804-337f-4cec-9d90-6f727baaabbd@flourine.local>
 <77f84f3b-86ff-4d26-ab25-a0355bcb0e40@flourine.local>
 <eb2298da-1d64-4424-a462-9056f722b5d7@suse.de>
 <a5ec9717-ebb0-4cdf-aaad-17f8a247a2c3@flourine.local>
 <d4a742e5-3639-467d-9ce9-a1b50211667b@flourine.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4a742e5-3639-467d-9ce9-a1b50211667b@flourine.local>
X-Rspamd-Queue-Id: 953D121D30
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,flourine.local:mid];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241014_165011_061299_D2251E76 
X-CRM114-Status: UNSURE (   8.75  )
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

nvme_tcp_setup_ctrl is called from different context. If the function as
part of the initial controller creation, the argument 'new' is set to
true. That means nvme_tcp_teardown_admin_queue should also get informed
that it should release all resources, but currently it doesn't.

Pass forward the correct context to the error handling path as well.

diff --git a/drivers/nvmehost/tcp.c b/drivers/nvme/host/tcp.c
index 89c44413c593..c31434b4da73 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2278,7 +2278,7 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
        }
 destroy_admin:
        nvme_stop_keep_alive(ctrl);
-       nvme_tcp_teardown_admin_queue(ctrl, false);
+       nvme_tcp_teardown_admin_queue(ctrl, new);
        return ret;
 }

