Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21AE7C001DB
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Aug 2023 13:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FiSkTKCYO+C4mUS8+BhGSRy3UXLvjgun3RjTRgxg6y4=; b=jSHtsZfWQNuhRmrNOtDrV7xrDB
	cocoFHTmRq40KvHagdZ6rAkSQqLfXtVuwiNJplyfIuUsXpBHbK3FUU3RIopJAQfMMpYYx/u8clku4
	nYSRHlc47EdWYg3MwijRKEWtlgQbTIuGEgsP8QD4Vy5eq6hly045IPTdN4x9miUaGeulfa4+oOaSk
	f8yyxv8WqSAFmGf34x8ZH10j26MZUyUd3GOGabZBJ1MPJuLAnWU8KLCyr8tZjn2VA6s+KALJ1XJQ+
	QQR6o+tRdrhSIu+jtUqT6ynPLAXxSs6Mfy8b2w8IVh8E1etXknksjZ+dnmlc/KPiAWtGFF3fCyVlt
	oaUwxN/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qU5mw-007kFP-1G;
	Thu, 10 Aug 2023 13:33:18 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qU5mt-007kEk-1W
	for linux-nvme@lists.infradead.org;
	Thu, 10 Aug 2023 13:33:16 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3A0921F45B;
	Thu, 10 Aug 2023 13:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691674394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FiSkTKCYO+C4mUS8+BhGSRy3UXLvjgun3RjTRgxg6y4=;
	b=bOE+dzxSjNBTD2oCjBwBmvx9Ap14yAzYJMYrpj+L4KDhdGoFzI/d5a3V9L2BAnC4y7qntz
	L2SJU3V9S2YrtGTxUiohuAWqLidqjG+d1z+Q3kSnCFu3FBy9rqK42dRiWVVXyQ61QaqkKi
	sjwirkubyYBuTQ2txN+fzW15pr/i1VA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691674394;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FiSkTKCYO+C4mUS8+BhGSRy3UXLvjgun3RjTRgxg6y4=;
	b=xvp+voA40LCPQrJCFEvVjUiCl6kOKLGK3P/S30ulkOHVQb63sPKZXKs2ZF/5eYkI1lDd7b
	sWuQdeSAGC77BNBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0BC9A138E2;
	Thu, 10 Aug 2023 13:33:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id EJU7ARrn1GQvbAAAMHmgww
	(envelope-from <hare@suse.de>); Thu, 10 Aug 2023 13:33:14 +0000
Message-ID: <7d60e267-be0a-41ff-8015-d3440b6eca2c@suse.de>
Date: Thu, 10 Aug 2023 15:33:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfc 6/6] nvme-fabrics: expose support for traddr as dns
 names to userspace
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Daniel Wagner <dwagner@suse.de>
References: <20230724092023.708335-1-sagi@grimberg.me>
 <20230724092023.708335-7-sagi@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230724092023.708335-7-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230810_063315_664030_BB4900D4 
X-CRM114-Status: GOOD (  16.54  )
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

On 7/24/23 11:20, Sagi Grimberg wrote:
> userspace needs to know that the kernel is capable of doing a dns
> query, so expose a custom opt called "dns_ip_traddr" which is not
> an argument, but rather indication of support for dns names for
> ip based traddr.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/host/fabrics.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index fadd25538d1b..6a7e8cbdaf69 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -1331,6 +1331,7 @@ static void __nvmf_concat_opt_tokens(struct seq_file *seq_file)
>   		seq_puts(seq_file, ",");
>   		seq_puts(seq_file, tok->pattern);
>   	}
> +	seq_puts(seq_file, ",dns_ip_traddr");
>   	seq_puts(seq_file, "\n");
>   }
>   

Don't we need to update the parser to accept this option, too?
After all, the implication is that all tokens in the output can be used 
as valid tokens for the connect string ...

Cheers,

Hannes


