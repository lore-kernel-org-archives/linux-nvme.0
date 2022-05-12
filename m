Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D3DDC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 12 May 2022 09:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=awl23rnaPshiQJCRT1fEhOTKhFkxc13B2kBpdyfx1J4=; b=GM5Wqz6fTNGftZLM4wSykIGoGf
	Z3jfmoA0mCK83EhB2IFCvLYGOHArvYkzCfk1DW7c3txvanSFcNU2icZnotRfR2bkK/KNpChYGJyA3
	UU0a9fNbGCQL+6DnnWNEKl6Aoy4ldG7wsTL7oh7/uSv8BfPHIO2++IRTle2TQvQ+Tz+fKvc7Dp4l8
	n4Bh1sBLncXBE2TD45V+Fpze+c2NJaLlkjMeRYvwYIJWcyRLBa8n+ewAm37D9DyRB9vSh9McS4l4b
	nFKZJ1qIuhnqckieSM4sYRAgQZbD/iIGZ826FzNqrKSEj1DETJdPo2kiRNdZnO/iPlAvNi70CzlWY
	RsMEP7Ng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1np5To-00BEKC-3e; Thu, 12 May 2022 09:51:32 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1np5Tk-00BEJ4-Qn
 for linux-nvme@lists.infradead.org; Thu, 12 May 2022 09:51:30 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9242F21CCD;
 Thu, 12 May 2022 09:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1652349087; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=awl23rnaPshiQJCRT1fEhOTKhFkxc13B2kBpdyfx1J4=;
 b=FXYz3YhVQhpt4do3XwTHKHjFCjXPEVY2sqKIGYcWVSlKRHA2rU6rPX1MrpEOmswVcMyCWl
 CNgIX4axfCqz0Awl4Z3oi0omyy/AT+JMHoCe1fukDrfFBEKuRGN0WxO/fkiTTKajXNGJMj
 w26YwDNBHsUnHEg5f6Zpxvp0GN2GB5Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1652349087;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=awl23rnaPshiQJCRT1fEhOTKhFkxc13B2kBpdyfx1J4=;
 b=TjB6SaIXzB3V1ltvoBxqQZq5Ap+VClFlR1sbfQuDrhv+nz4uhWQV0r9I646nfwA3pTpUwx
 v2YMZcnb7R0NMPCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 73B7413A84;
 Thu, 12 May 2022 09:51:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +oHSGZ/YfGK2PwAAMHmgww
 (envelope-from <hare@suse.de>); Thu, 12 May 2022 09:51:27 +0000
Message-ID: <a444684f-9d78-7422-6f9b-c988d2f8244b@suse.de>
Date: Thu, 12 May 2022 11:51:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 4/4] lpfc: Add support for vmid tagging of NVMe I/Os
Content-Language: en-US
To: James Smart <jsmart2021@gmail.com>, linux-scsi@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
 Gaurav Srivastava <gaurav.srivastava@broadcom.com>
References: <20220510200028.37399-1-jsmart2021@gmail.com>
 <20220510200028.37399-5-jsmart2021@gmail.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220510200028.37399-5-jsmart2021@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220512_025129_051553_8D3656F0 
X-CRM114-Status: UNSURE (   9.62  )
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

On 5/10/22 22:00, James Smart wrote:
> Modify the nvme io path to look for vmid support and call the
> transport to obtain the io's appid value.
> 
> Signed-off-by: Gaurav Srivastava <gaurav.srivastava@broadcom.com>
> Signed-off-by: James Smart <jsmart2021@gmail.com>
> ---
>   drivers/scsi/lpfc/lpfc_nvme.c | 45 +++++++++++++++++++++++++++++++++++
>   1 file changed, 45 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

