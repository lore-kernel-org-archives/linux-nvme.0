Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4CE510FCAC0
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Apr 2026 18:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0wT4pFp4rcg/tslBX8LUpuJrgYaYkzWwsf/lgk9kz7o=; b=a06Psy38Y/LQMPKufiN4Az2Y6/
	KBb/Lflu+AiC4kzZzCaNAsBSpsEZeIx+zafBYy4taTyBOWFSymoCbb7ZDEJbkTKdL3J7IWtZczAap
	jIjfvQKJNAJ61mznylCOaLVLo31TSOSAUZa9mAwxk0dvrLUJKkvuxyLzxOxks1bB/+Hc0bI9gkmOT
	4gzFck1Tbu+nUK2FbZlic3xQDrsypkE9fAZ3wZYfuo/BraWLmCoTS9spxfv63MK62aajp+wLMEFuo
	7aD/LEm63gclM0pJYG2R4cZ0/VGwXfHYa/vlpTmctBZHMeuTH8L2woRPILNrqRmRnd4MrltHPJqUb
	BvLprvnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w80XF-0000000Fydd-0c2s;
	Wed, 01 Apr 2026 18:43:25 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w80XC-0000000FydE-3zMT
	for linux-nvme@lists.infradead.org;
	Wed, 01 Apr 2026 18:43:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775069001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0wT4pFp4rcg/tslBX8LUpuJrgYaYkzWwsf/lgk9kz7o=;
	b=Tbe8zC+hoTOjSGYE/uBVA+pcHQVYg8NIrDBVDRsl+LRpE2YAABf0LblR+eOYri/Bweiscy
	hmH2mXTqJGu+pNmRSvRwKOf8WHpZJO8ZymKnn+uOApQrfYpkB6vmFg1K/RzOaevvlBDnh0
	Zne5mA+xw6GiM3POYTgy8xbZC/DELbs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-371-hWEGNhWjOwW2NE14a_rMMw-1; Wed,
 01 Apr 2026 14:43:15 -0400
X-MC-Unique: hWEGNhWjOwW2NE14a_rMMw-1
X-Mimecast-MFC-AGG-ID: hWEGNhWjOwW2NE14a_rMMw_1775068994
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 057D119560AB;
	Wed,  1 Apr 2026 18:43:14 +0000 (UTC)
Received: from cleech-thinkpadt14sgen2i.rmtusor.csb (unknown [10.2.17.44])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 177581800361;
	Wed,  1 Apr 2026 18:43:11 +0000 (UTC)
Date: Wed, 1 Apr 2026 11:43:11 -0700
From: Chris Leech <cleech@redhat.com>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 4/8] nvme: parse dhchap keys during option parsing
Message-ID: <20260401-9844eebdfe2fe11cf72e20aa@redhat.com>
References: <20260317130103.107360-1-hare@kernel.org>
 <20260317130103.107360-5-hare@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260317130103.107360-5-hare@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NzKFUIQrZrw1z9tvnJEtaoC97c5VVLr4_R-utAJ2fAQ_1775068994
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260401_114323_067465_9883BAAA 
X-CRM114-Status: GOOD (  15.14  )
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

On Tue, Mar 17, 2026 at 02:00:59PM +0100, Hannes Reinecke wrote:
> We really should parse the dhchap keys during option parsing to avoid
> having to pass around the plain dhchap secret. During options parsing
> we will create a 'dhchap' key with a random UUID as description, and
> store the key serial in the 'opts' structure.
> This simplifies key handling as on every access the key needs to be
> looked up and checked for validity before accessing the key data.
> 
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> ---
>  drivers/nvme/host/auth.c    | 118 +++++++++++++++--------
>  drivers/nvme/host/fabrics.c |  82 +++++++++++-----
>  drivers/nvme/host/fabrics.h |   8 +-
>  drivers/nvme/host/sysfs.c   | 185 ++++++++++++++++++++++++++----------
>  4 files changed, 275 insertions(+), 118 deletions(-)
> 
...
> @@ -1290,8 +1314,18 @@ void nvmf_free_options(struct nvmf_ctrl_options *opts)
>  	kfree(opts->subsysnqn);
>  	kfree(opts->host_traddr);
>  	kfree(opts->host_iface);
> -	kfree(opts->dhchap_secret);
> -	kfree(opts->dhchap_ctrl_secret);
> +	if (opts->dhchap_key) {
> +		pr_debug("revoke dhchap host key %08x\n",
> +			 key_serial(opts->dhchap_key));
> +		key_revoke(opts->dhchap_key);
> +		key_put(opts->dhchap_key);
> +	}
> +	if (opts->dhchap_ctrl_key) {
> +		pr_debug("revoke dhchap ctrl key %08x\n",
> +			 key_serial(opts->dhchap_ctrl_key));
> +		key_revoke(opts->dhchap_key);

This is revoking the wrong key, it should be dhchap_ctrl_key.

- Chris


