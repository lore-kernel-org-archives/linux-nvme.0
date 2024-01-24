Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20316C46CD2
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jan 2024 15:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/vEE2x6vx/ELx4pUGnKkV3qlKhIj+pSOCMyHB0Ial/U=; b=2JYfMvXWY7nhGKZqo/ImetS6bb
	nQAkfdLokDkK/2AeFg6VJW+z9Zd/CMjzORJby5NNRIKvf8XUrVAByVWrkZdWzHMdD0+RR2ZHaOpi1
	Jm5CyFNk4C5nB+Rlh7QE5m4ualwJ4aZ0PXyHXOQpn3w7UOgNVSrrLEQzVlRjCW0dbMO7imSXAaY1X
	1XC0G/D2mZlNKJeEvZySXmdpCU1moAsmJ7Tubiu/XxYtL+dLdm5QUl4vKdXopEw76q+aqdQbyXssl
	wICPS/s1vwbjhT+8q0LkxqQ6cprk15OrIchiOghpMt+5+b1Gvr0uqDxMXAB01P6SrLZY97noWh441
	NpLsQztA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSfEH-003xrq-11;
	Wed, 24 Jan 2024 15:31:53 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSfED-003xoX-1F
	for linux-nvme@lists.infradead.org;
	Wed, 24 Jan 2024 15:31:51 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 806D1222CC;
	Wed, 24 Jan 2024 15:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706110305; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=/vEE2x6vx/ELx4pUGnKkV3qlKhIj+pSOCMyHB0Ial/U=;
	b=gct6siqXoDVcDhV2zrVvXg7a6G3FYEty35s/sZS97xAQ/u5A5GdUCyZD/AtSf+JNzN7hmD
	qgTpFe9Q/3SEyXVpgViq4Afe31U5v+TC5qhBnZeGifYDb7J0mOQu8OXG6nN5qxppJsrYVu
	CIU1a8TT0zSBc7UQvNZ8vKhuq0OxqZU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706110305;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=/vEE2x6vx/ELx4pUGnKkV3qlKhIj+pSOCMyHB0Ial/U=;
	b=JB6eGqs/IEPBMyDCpaQcsddwaI5JjLaSYolnB93QXghZ50e0P6jq7W8NKAIGtXWfocXra/
	B32J08Q/h1Xlp+DA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706110305; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=/vEE2x6vx/ELx4pUGnKkV3qlKhIj+pSOCMyHB0Ial/U=;
	b=gct6siqXoDVcDhV2zrVvXg7a6G3FYEty35s/sZS97xAQ/u5A5GdUCyZD/AtSf+JNzN7hmD
	qgTpFe9Q/3SEyXVpgViq4Afe31U5v+TC5qhBnZeGifYDb7J0mOQu8OXG6nN5qxppJsrYVu
	CIU1a8TT0zSBc7UQvNZ8vKhuq0OxqZU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706110305;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=/vEE2x6vx/ELx4pUGnKkV3qlKhIj+pSOCMyHB0Ial/U=;
	b=JB6eGqs/IEPBMyDCpaQcsddwaI5JjLaSYolnB93QXghZ50e0P6jq7W8NKAIGtXWfocXra/
	B32J08Q/h1Xlp+DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 60ACD13786;
	Wed, 24 Jan 2024 15:31:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mZpJFmEtsWUdEQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 24 Jan 2024 15:31:45 +0000
Date: Wed, 24 Jan 2024 16:31:44 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: nvme-tcp: question on poll return value
Message-ID: <gcy35jsyvwmw37tlqpanvavqpxqmt3qylam7mtbkefolj737ef@vfswvevmfxku>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.80 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[43.64%]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240124_073149_601178_CA8F21EA 
X-CRM114-Status: GOOD (  15.89  )
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

Hi Sagi,

I am stubled across nr_cqe while debugging something else and I am not
sure if the poll function is doing the right thing with it. IIUC, the
blk_mq_ops poll callback is supposed to return > 0 value when it
processed at least one element. If this is the case, than I think we
would need to first copy the current value in nr_cqe before calling
nvme_tcp_try_recv. The function will reset queue->nr_cqe to 0, thus
nvme_tcp_poll will always return 0.

Does this make any sense?

Thanks,
Daniel

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index d79811cfa0ce..db9a105bd986 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2573,6 +2573,7 @@ static int nvme_tcp_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
 {
 	struct nvme_tcp_queue *queue = hctx->driver_data;
 	struct sock *sk = queue->sock->sk;
+	int nr_cqe;

 	if (!test_bit(NVME_TCP_Q_LIVE, &queue->flags))
 		return 0;
@@ -2580,9 +2581,10 @@ static int nvme_tcp_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
 	set_bit(NVME_TCP_Q_POLLING, &queue->flags);
 	if (sk_can_busy_loop(sk) && skb_queue_empty_lockless(&sk->sk_receive_queue))
 		sk_busy_loop(sk, true);
+	nr_cqe = queue->nr_cqe;
 	nvme_tcp_try_recv(queue);
 	clear_bit(NVME_TCP_Q_POLLING, &queue->flags);
-	return queue->nr_cqe;
+	return nr_cqe;
 }

 static int nvme_tcp_get_address(struct nvme_ctrl *ctrl, char *buf, int size)

