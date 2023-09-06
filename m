Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8F28EB8FB6
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Sep 2023 12:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aIHWHExCJytwauktI33lV3y52fadr8OCAogXiegZGCA=; b=ZKQ5kSh1TsQbuhStQ8gmi4aH6z
	OzenLkzzNJY82qKnPIepNI8FOq2afc6EmitJKEv8wMtW+U4z5+Nt9w4AhYow+S7Ww1mYqNiopjpdD
	QmLhn1Vxw6GHLvi2AUBTqlkNrGYTY2hEXs+1fjTDyBS86Xl+909rzSJ8h49PFvdAfbHXnatPdKmZA
	MSMacKeNxxKdMtXMTYOsb5YqL7lw2ULXsGPs7n5vGhilw0TPtTniCf0ukHrGl6zB+4NAtSOLE7U9P
	HgZ9WkNTxEqviSM2AIFSKtjofZzT/uHvXobvTeBBiEZYabe2kxPQ6taNq9OavvRYnMuoitJdg2FQb
	98t9sosg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qdrRx-009GjI-39;
	Wed, 06 Sep 2023 12:16:01 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qdqHU-008Pqe-3C
	for linux-nvme@lists.infradead.org;
	Wed, 06 Sep 2023 11:01:10 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C116420292;
	Wed,  6 Sep 2023 11:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1693998067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aIHWHExCJytwauktI33lV3y52fadr8OCAogXiegZGCA=;
	b=tesi9F604i11g5ZFa2kCst6kVHn4Ry2YYi5tZhAWLtcJnzc3CahI0w9Fj2kcs1Oe94iCUk
	Pe0g4OvUblEZH8szJLxs7gGxl4UgNnYxxLk1GwjJBxpcsLvdhlMLdg9Ot5YM9FvOsSKCwj
	hz92raVHnrqaelOAn7ukVdfIUsGTlEU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1693998067;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aIHWHExCJytwauktI33lV3y52fadr8OCAogXiegZGCA=;
	b=9NHaJrY3I/BtxPTeEklQQuMZExZeeys//52dnrX3QGUytjqG9jZauyQ8+NH2vVSo6ezBNq
	0HrtvvO2O9k5FYAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 70C631333E;
	Wed,  6 Sep 2023 11:01:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id WFuPF/Nb+GSOQgAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 06 Sep 2023 11:01:07 +0000
Message-ID: <3a540950-8ca7-4ff6-9f01-be194c346411@suse.de>
Date: Wed, 6 Sep 2023 13:01:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 2/4] nvmet-trace: null terminate device name string
 correctly
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
 Jason Gunthorpe <jgg@ziepe.ca>, James Smart <james.smart@broadcom.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>
References: <20230829091350.16156-1-dwagner@suse.de>
 <20230829091350.16156-3-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230829091350.16156-3-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230906_040109_192645_B4B2C989 
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

On 8/29/23 11:13, Daniel Wagner wrote:
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/target/trace.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/trace.h b/drivers/nvme/target/trace.h
> index 6997bd7e45cf..9ba466b49613 100644
> --- a/drivers/nvme/target/trace.h
> +++ b/drivers/nvme/target/trace.h
> @@ -55,8 +55,8 @@ static inline void __assign_req_name(char *name, struct nvmet_req *req)
>   		return;
>   	}
>   
> -	strncpy(name, req->ns->device_path,
> -		min_t(size_t, DISK_NAME_LEN, strlen(req->ns->device_path)));
> +	strscpy(name, req->ns->device_path,
> +		min_t(size_t, DISK_NAME_LEN, strlen(req->ns->device_path) + 1));
>   }
>   #endif
>   
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes


