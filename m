Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CCCEEB8FAF
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Sep 2023 11:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v1wz3JXlD6sKijh39GZRuuCJLqyL+5GqqYL19oPvalk=; b=TubzjfCDWFxQMOZMpnVmeKJQmi
	s2XaWBRLUpDdsUfFlYDOGA3X9srmgldNAyLX6iFnhI0vHtEOurLM6U5NH+0ELJYsO/k2L6pL1Q+Fa
	2c34hfvlfQmo6jokg6vFl49IUe+nR9hDTKydt/rOOZFPSFCLb0wBv19i6Eu7xi8RxdrZrV/sN4V2L
	t/5B7rRBErV6kIkULm4MyhPHSiBKjRZhrueN1sjkW6LTkNt1Q8zyQrzKl159c6zK7LPDfs9t88q8+
	EbP/1HrpCZgPT/7/QAzDQu8PU5+QahgSkFluKKrwGsrGqXzZX+7q4Ank+Q4GP3pebGFNXKa3o+QNh
	O68+YCLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qdqGq-008PLK-0q;
	Wed, 06 Sep 2023 11:00:28 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qdqGn-008PFh-0K
	for linux-nvme@lists.infradead.org;
	Wed, 06 Sep 2023 11:00:26 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A59D022437;
	Wed,  6 Sep 2023 11:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1693998020; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v1wz3JXlD6sKijh39GZRuuCJLqyL+5GqqYL19oPvalk=;
	b=FP/CXZxw3KtnKEAJFzd5mRdgsDir0lcOL+5avoyNZQca9nQMLfw19GGTfKh+KbOV0eUefk
	9wlI1VCs55pJ7zFXFTkDDfiQWLVzvbTy1DQMMxgRzfJe+2M4DJNlAP0QW9V6MU7qsE5Xry
	Q9q9pQvFTqnI1+bmo8dQ+ep1d4wCqto=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1693998020;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v1wz3JXlD6sKijh39GZRuuCJLqyL+5GqqYL19oPvalk=;
	b=XDEtTln1kiJff3zIsGnj4cqeuw2qsX76p4UKDrlTrJaxzS5hezkXGPwpc/kqATNuOLYZDx
	KtTod8Nkwa40qgDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D098B1333E;
	Wed,  6 Sep 2023 11:00:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 4D2fLsNb+GSOQgAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 06 Sep 2023 11:00:19 +0000
Message-ID: <ff7b76d3-2983-44d1-8db7-20629bfbf89c@suse.de>
Date: Wed, 6 Sep 2023 13:00:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 1/4] nvmet-trace: avoid dereferencing pointer too early
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
 Jason Gunthorpe <jgg@ziepe.ca>, James Smart <james.smart@broadcom.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>
References: <20230829091350.16156-1-dwagner@suse.de>
 <20230829091350.16156-2-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230829091350.16156-2-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230906_040025_283526_0556C89C 
X-CRM114-Status: GOOD (  11.37  )
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
> The first command issued from the host to the target is the fabrics
> connect command. At this point, neither the target queue nor the
> controller have been allocated. But we already try to trace this command
> in nvmet_req_init.
> 
> Reported by KASAN.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> 
> ---
>   drivers/nvme/target/trace.c |  6 +++---
>   drivers/nvme/target/trace.h | 24 +++++++++++++-----------
>   2 files changed, 16 insertions(+), 14 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes



