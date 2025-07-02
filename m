Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11D00C77B7C
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Jul 2025 13:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+fHT724+2pLlrx0BuLAHl+ZqVSE+oJbAz028KvUs4b4=; b=WGGlOfEK8i4uDTlgDt+/Pmfq1v
	N0SRoKj6mseJN8E/AL/bNE0QhxJ2/EyUEIlS0UnNw7z1htgB0aqKHVEfJp6b7Z5En2eJyGrwC1UwP
	xFqQyFNXxj3GANl+EZ6iUaFWPSUMY23WJtw984h4UnOvYnsOKCquyWQPpXY7YRfHJGkW+ptisjsZz
	X9u8Y/xUle2vVl8wxnA+tY/saxJNVBRaIua8NxlethNbKoJQC/Tj4dVzDMfhfrleIv5Kxlez0PTvb
	uOIX7xIFTNphGGlNxZNQHkCgx/LVHQix25ABfcXNkKH/3HqTAh+ltOLWmn4BbCjOWC9+5rC1N4nwd
	NNWAKdPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWxdE-00000008TrR-21Hy;
	Wed, 02 Jul 2025 13:36:12 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWvjx-000000089Iw-0aMb
	for linux-nvme@lists.infradead.org;
	Wed, 02 Jul 2025 11:35:02 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A717921197;
	Wed,  2 Jul 2025 11:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751456099; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+fHT724+2pLlrx0BuLAHl+ZqVSE+oJbAz028KvUs4b4=;
	b=Xw8SGu7o75k5QVafroXMJv43PU7MAVndrdwEPFfDU39Z0aGLhfcnKPfExCKbkrLRIZQYBP
	D0649z5/Rm6OtnLMifBS7lOTGKA7Okj7hkSuGA3NtKTmC7QIwCsIG1c3b3MdTtt2baIMqT
	/OR2gxgX7d9bcZ/DxCRVLafDnPNZeRc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751456099;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+fHT724+2pLlrx0BuLAHl+ZqVSE+oJbAz028KvUs4b4=;
	b=d3b49/xwx/s8aSmpau9GUqkFy5yRxrNa720CB5xpVDJra/t5jGhGMOP6+y+drWUL42Ghui
	PF+3m1ZkcFf303Cw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751456099; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+fHT724+2pLlrx0BuLAHl+ZqVSE+oJbAz028KvUs4b4=;
	b=Xw8SGu7o75k5QVafroXMJv43PU7MAVndrdwEPFfDU39Z0aGLhfcnKPfExCKbkrLRIZQYBP
	D0649z5/Rm6OtnLMifBS7lOTGKA7Okj7hkSuGA3NtKTmC7QIwCsIG1c3b3MdTtt2baIMqT
	/OR2gxgX7d9bcZ/DxCRVLafDnPNZeRc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751456099;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+fHT724+2pLlrx0BuLAHl+ZqVSE+oJbAz028KvUs4b4=;
	b=d3b49/xwx/s8aSmpau9GUqkFy5yRxrNa720CB5xpVDJra/t5jGhGMOP6+y+drWUL42Ghui
	PF+3m1ZkcFf303Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 93F5613A24;
	Wed,  2 Jul 2025 11:34:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cYeqI2MZZWhnCQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 02 Jul 2025 11:34:59 +0000
Message-ID: <cbe6682c-345b-4807-acd0-5f83ea7df0b7@suse.de>
Date: Wed, 2 Jul 2025 13:34:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-tcp: log TLS handshake failures at error level
To: Maurizio Lombardi <mlombard@redhat.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, mlombard@bsdbackstore.eu
References: <20250624163930.104848-1-mlombard@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250624163930.104848-1-mlombard@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250702_043501_330565_15291D6D 
X-CRM114-Status: GOOD (  17.24  )
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

On 6/24/25 18:39, Maurizio Lombardi wrote:
> Update the nvme_tcp_start_tls() function to use dev_err()
> instead of dev_dbg() when a TLS error is detected.
> This ensures that handshake failures are visible by default,
> aiding in debugging.
> 
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> ---
>   drivers/nvme/host/tcp.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index d924008c3949..26d26823a0c5 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1745,9 +1745,11 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
>   			qid, ret);
>   		tls_handshake_cancel(queue->sock->sk);
>   	} else {
> -		dev_dbg(nctrl->device,
> -			"queue %d: TLS handshake complete, error %d\n",
> -			qid, queue->tls_err);
> +		if (queue->tls_err) {
> +			dev_err(nctrl->device,
> +				"queue %d: TLS handshake complete, error %d\n",
> +				qid, queue->tls_err);
> +		}
>   		ret = queue->tls_err;
>   	}
>   	return ret;

There still is a value in knowing that tlshd is complete, so maybe
something like

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index f6379aa33d77..39f8758d71e3 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1729,9 +1729,13 @@ static int nvme_tcp_start_tls(struct nvme_ctrl 
*nctrl,
                         qid, ret);
                 tls_handshake_cancel(queue->sock->sk);
         } else {
-               dev_dbg(nctrl->device,
-                       "queue %d: TLS handshake complete, error %d\n",
-                       qid, queue->tls_err);
+               if (queue->tls_err)
+                       dev_err(nctrl->device,
+                               "queue %d: TLS handshake complete, error 
%d\n",
+                               qid, queue->tls_err);
+               else
+                       dev_dbg(nctrl->device,
+                               "queue %d: TLS handshake complete\n");
                 ret = queue->tls_err;
         }
         return ret;

hmm?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

