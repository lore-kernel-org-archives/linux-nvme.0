Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EC48C04A95
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Oct 2022 17:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LQ764kc1UpxJXoZPgFxWbvEYa2N3WKe7AbIz2p+KXLA=; b=bPoSUM38LwNSok0wWXmv8hx7mB
	BWs++cwkrKOnH460cfd52Gk4P0DneLgix5TBNe+lrPaiKcKBORhdMvWp40pK2izct3N6iAE4qOdm0
	/0LFzGZPWZ9+9mNWPYOgPUWFI6iQWsrUID2w0XniGuPIoWPZHdB6uI1GZczcN24WEcVwSGGWpvZ9W
	P40VUQsNF84FMInzq6SvG1cAHSLR2qby6EUKaXuNzBq7Biqd7Vsbvv1R7SoIEBOXnDnXqm3Jr3l8X
	vpXxGjsRZUrlAti+QHXKqGCdmMEqXuEz4Xj/qVFWpd18xVPN6wHXV9TbEGI5COAl8vJvrdlkfWW2q
	c66F4QgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onNZX-006QHL-QH; Tue, 25 Oct 2022 17:18:39 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onNZP-006QCR-Mg
	for linux-nvme@lists.infradead.org; Tue, 25 Oct 2022 17:18:33 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 329411FA48;
	Tue, 25 Oct 2022 17:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1666718307; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LQ764kc1UpxJXoZPgFxWbvEYa2N3WKe7AbIz2p+KXLA=;
	b=zBtvuqnGBm73/Qy87rsvhzn0xC8CNiEZdy4ywZcW59a/eSwA9m/412neTl13BMd8yvTEsn
	oUo1latD5BRDCbnk9zmZFtP5vwt+/aCZa6odbPK+2cbmeMH5xLOCqsq/0YRs/L2EaIVmPZ
	isyJjjilOnEnHXmGeYMCGP/OcJCm/5E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1666718307;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LQ764kc1UpxJXoZPgFxWbvEYa2N3WKe7AbIz2p+KXLA=;
	b=POZNal4xVYOBzfSUhZ9BiFn8w53su0kgv92vzI56acxpby603eiU/HDBT+DQD3VCWV5i6D
	3EsLTwKN0rO+DwAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 17BF613A64;
	Tue, 25 Oct 2022 17:18:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id +/TgBGMaWGOvNAAAMHmgww
	(envelope-from <hare@suse.de>); Tue, 25 Oct 2022 17:18:27 +0000
Message-ID: <49906010-8c0d-0330-2a2a-284476e2783f@suse.de>
Date: Tue, 25 Oct 2022 19:18:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 2/6] nvme-auth: remove symbol export from nvme_auth_reset
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <20221025134330.1028352-1-sagi@grimberg.me>
 <20221025134330.1028352-3-sagi@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20221025134330.1028352-3-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221025_101831_916889_547EFB01 
X-CRM114-Status: GOOD (  15.16  )
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

On 10/25/22 15:43, Sagi Grimberg wrote:
> Only the nvme module calls it.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/host/auth.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> index d45333268fcf..734928282d3e 100644
> --- a/drivers/nvme/host/auth.c
> +++ b/drivers/nvme/host/auth.c
> @@ -932,7 +932,6 @@ void nvme_auth_reset(struct nvme_ctrl *ctrl)
>   	}
>   	mutex_unlock(&ctrl->dhchap_auth_mutex);
>   }
> -EXPORT_SYMBOL_GPL(nvme_auth_reset);
>   
>   static void nvme_dhchap_auth_work(struct work_struct *work)
>   {
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes

