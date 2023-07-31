Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75890C001DE
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Jul 2023 16:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Bu3hau3URp8DICPDRf+gefbn2Z5+ZSSp25qCWSFsxDw=; b=4KliwG9PA8JaDHvVt/JTUL8O5z
	ts3wK48MtivgtTRvlKwYa8U3WlAZPSR3or4EfXB+j1UXZTWxYZQIFHR5GF65gR559DcKM/g9F6yT/
	2l16KmLHRNBjURvi09FeX8cWPjc2jAheB93n9yPKR/rwWzMXYauSFfwoFPyFDpseBay4DkRmVxFy7
	shCXU9fqsXpi9Z5ulCBdRu63LxjJrtXHBSkvyjp4Q81Ch3/mOABPHo5FO6q5bDcvgv8P/Vr5hMnBB
	mf0W61x1j8iPu+eWd5Q/ABcuQHAPEX5+SNNS4ncK7TsNX/ONTrglA65lC0rnFYfs11mWnHsOZFd8R
	HZtCTuTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQVul-00GaSN-2i;
	Mon, 31 Jul 2023 16:38:35 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qQVuj-00GaQz-1I
	for linux-nvme@lists.infradead.org;
	Mon, 31 Jul 2023 16:38:34 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CB14F2212B;
	Mon, 31 Jul 2023 16:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1690821509; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bu3hau3URp8DICPDRf+gefbn2Z5+ZSSp25qCWSFsxDw=;
	b=CPCdPxshTz7famaKTrzxSj4Y6KD0E0fZetAF9mlKeZnJe7vcZfpvKLMCGRur6tWRO9jNfv
	Z+cazYZE6pB+CXD0F71Ujpjc2ftb8RBMAHI+GOIhPT25wfMx4PPnfQOwd/2Qmrephh8qAx
	B4XwDvezuo+X3BAVe4l6UdWn0gIUR4w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1690821509;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bu3hau3URp8DICPDRf+gefbn2Z5+ZSSp25qCWSFsxDw=;
	b=G3JYHm8kNu+wctf0TlH7KDTYcUs7oIvr6na+WX/prAa8sdBn5rGRrGavOrc507vP2ekb37
	KHzwMkQuZ4T9SEDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 64DAB1322C;
	Mon, 31 Jul 2023 16:38:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id QBymFoXjx2RsGAAAMHmgww
	(envelope-from <hare@suse.de>); Mon, 31 Jul 2023 16:38:29 +0000
Message-ID: <59caeb97-a32a-1e83-c4cd-38e70628027d@suse.de>
Date: Mon, 31 Jul 2023 18:38:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 2/2] nvme-auth: set explanation code for failure2 msgs
Content-Language: en-US
To: Mark O'Donovan <shiftee@posteo.net>, linux-kernel@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, axboe@kernel.dk, kbusch@kernel.org
References: <20230731145106.917526-1-shiftee@posteo.net>
 <20230731145106.917526-2-shiftee@posteo.net>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230731145106.917526-2-shiftee@posteo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230731_093833_589605_FA013399 
X-CRM114-Status: GOOD (  16.67  )
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

On 7/31/23 16:51, Mark O'Donovan wrote:
> Some error cases were not setting an auth-failure-reason-code-explanation.
> This means an AUTH_Failure2 message will be sent with an explanation value
> of 0 which is a reserved value.
> 
> Signed-off-by: Mark O'Donovan <shiftee@posteo.net>
> ---
> v1->v2: Set failure explanation in a single place if the error handling
> code has not already done so.
> 
>   drivers/nvme/host/auth.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> index e1a98647c3a2..9556cfc4f5f3 100644
> --- a/drivers/nvme/host/auth.c
> +++ b/drivers/nvme/host/auth.c
> @@ -839,6 +839,8 @@ static void nvme_queue_auth_work(struct work_struct *work)
>   	}
>   
>   fail2:
> +	if (chap->status == 0)
> +		chap->status = NVME_AUTH_DHCHAP_FAILURE_FAILED;
>   	dev_dbg(ctrl->device, "%s: qid %d send failure2, status %x\n",
>   		__func__, chap->qid, chap->status);
>   	tl = nvme_auth_set_dhchap_failure2_data(ctrl, chap);

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


