Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5F1DECAAD2
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Aug 2022 09:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B/PeAH9rrBjHv9IsrR2K6KQbajDHLTLdu4W8SWHH4Ts=; b=mtvwqCo6UimxLJFdFoEyaD/FiC
	xoym/FfwToWb1sgTdybxe608UwTulUQqoU377aoT+Q57T/YH7kIkXnktNFqnFqc/OtWTqRzRube0u
	dE0lDcWQ8JSmCIcT22tzyoO0h7CbJQVRPvXVDtqaWHU0/db5aC38VHTQI22mP2zyHWmChnBtMIi9C
	Ba5bx+u8+N/xgqtQIMfxqX9w6jcTaVPsRwSaMeFFzlgwsv23lk/e4XJ9Vth3uwzdnlI8KBmAOeTBX
	EiD0Y88rHI+STk3dQFL/PBzXqiyELJR7gLjpRxvPeuQDbAEACORgPsWMz8l+PoysTtmJWXRMjrdgH
	2rjffskA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSakY-006XTw-EE; Mon, 29 Aug 2022 09:08:06 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSakI-006XGR-Qe
	for linux-nvme@lists.infradead.org; Mon, 29 Aug 2022 09:07:53 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 382B31F9AF;
	Mon, 29 Aug 2022 09:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1661764066; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B/PeAH9rrBjHv9IsrR2K6KQbajDHLTLdu4W8SWHH4Ts=;
	b=Z8dZPkNmMMw1oxZ/Sgo1Njmb+877bQK7s+G7EV/GCzBRZbizdqauSdmsBPYfwNKnjMR7Yp
	efDaE2d/+3s2kVEffP0znQQANUa7ETelDEid4T9R6BzbLHaOuKtBlKpNJ4xmNr1e0thSbp
	2fsZ1Ql0X5+AUwxZHeH6tSE386rjg/4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1661764066;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B/PeAH9rrBjHv9IsrR2K6KQbajDHLTLdu4W8SWHH4Ts=;
	b=cYDQqJvLn8EnwxIzr7w/eNeppKYqpuehdqUJD/VHwFkjhde9P8hezL7M1iGsqSzzl8PfW8
	QhkKfik7VCGLDWAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 254FE1352A;
	Mon, 29 Aug 2022 09:07:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id P0OdCOKBDGPOIAAAMHmgww
	(envelope-from <hare@suse.de>); Mon, 29 Aug 2022 09:07:46 +0000
Message-ID: <18af0d76-71c5-4f35-d101-c1b886f450fc@suse.de>
Date: Mon, 29 Aug 2022 11:07:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 3/3] nvme-rdma: Handle number of queue changes
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: Sagi Grimberg <sagi@grimberg.me>, Chao Leng <lengchao@huawei.com>
References: <20220829083856.1850-1-dwagner@suse.de>
 <20220829083856.1850-4-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220829083856.1850-4-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220829_020751_117308_3D9A22FB 
X-CRM114-Status: GOOD (  15.35  )
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

On 8/29/22 10:38, Daniel Wagner wrote:
> On reconnect, the number of queues might have changed.
> 
> In the case where we have more queues available than previously we try
> to access queues which are not initialized yet.
> 
> The other case where we have less queues than previously, the
> connection attempt will fail because the target doesn't support the
> old number of queues and we end up in a reconnect loop.
> 
> Thus, only start queues which are currently present in the tagset
> limited by the number of available queues. Then we update the tagset
> and we can start any new queue.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/host/rdma.c | 26 +++++++++++++++++++++-----
>   1 file changed, 21 insertions(+), 5 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

