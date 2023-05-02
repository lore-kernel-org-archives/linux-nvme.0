Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57D66C77B73
	for <linux-nvme@archiver.kernel.org>; Tue,  2 May 2023 06:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=abkpTL2IrkzdKT1kp6lWlfq+hjGdGVNZtS/id2U7OuE=; b=p45y4I+C/IJ33Fat84mWz4l64/
	GPwx8MdicUn54qL6aRM6see/5JwGgG8RA2mRBV1JYmzk8DtdQIx06RJued7Lvx+Lwb1SdtIUSD6pK
	quvBUvTl5Q6r9KTyQHpynm5tXvL9Zf6yao0MBQ+aLFOawFn3XUDsDVegfSbWOTQHsUKuwnKenksfT
	R/VWWRLADTzR5/7S9XBLWpvkCX7KUaZzw9nxrPthWIR8Uos8sH8QfN0UQKO3UUN7eYq+1BRxttCAm
	2UBPCLN7psrLAPVVInj6XVzBB20ovaZImDyTE+VEzVm6KCf8nN0WfJz2O5CwsCdjPLb7seVgUjnpl
	BH5SrXgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptj7S-000I4V-0Y;
	Tue, 02 May 2023 06:04:10 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptj7P-000I3e-01
	for linux-nvme@lists.infradead.org;
	Tue, 02 May 2023 06:04:08 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AA2312245A;
	Tue,  2 May 2023 06:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1683007442; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=abkpTL2IrkzdKT1kp6lWlfq+hjGdGVNZtS/id2U7OuE=;
	b=uabnDJZz/iSXCFySLeqSs3/rcgaXWLjRcLWLAdj+p4MTjxDkEhYqjFqZSAuYJaiSNY9wmF
	+6KxxJDiALoa1Ep9lv2bruqX5tVDEEDSzJf9YXZJcbpbdeP3GPwGWxpOKjm5thzSLovsxl
	uncaCW1VD5fGVadJsPGwf9e94sau8x8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1683007442;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=abkpTL2IrkzdKT1kp6lWlfq+hjGdGVNZtS/id2U7OuE=;
	b=h2vkopyRLBeb5pgeINDylCcNMUJGDcK6Wnvnd/IdQZzl/M7gHalUhX4Kl9KPJqhd0/FwGP
	7WosUh+3/HRZ9vBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 76F15134FB;
	Tue,  2 May 2023 06:04:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 0hLMAtKnUGTeaAAAMHmgww
	(envelope-from <hare@suse.de>); Tue, 02 May 2023 06:04:02 +0000
Message-ID: <379eb282-843d-2b64-554a-8505aee263c2@suse.de>
Date: Tue, 2 May 2023 08:04:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] nvmet-auth: remove some dead code
Content-Language: en-US
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <e6f0e506459eaec9dad74946c1e01aac74874054.1681764032.git.christophe.jaillet@wanadoo.fr>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <e6f0e506459eaec9dad74946c1e01aac74874054.1681764032.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230501_230407_236309_A2C0AAB1 
X-CRM114-Status: GOOD (  12.50  )
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

On 4/17/23 22:41, Christophe JAILLET wrote:
> 'status' is known to be 0 at the point.
> And nvmet_auth_challenge() return a -E<ERROR_CODE> or 0.
> So these lines of code should just be removed.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> The dead code became obvious after commit be2ada6d0ed0 ("nvmet-auth: fix
> return value check in auth receive")
> ---
>   drivers/nvme/target/fabrics-cmd-auth.c | 9 ---------
>   1 file changed, 9 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


