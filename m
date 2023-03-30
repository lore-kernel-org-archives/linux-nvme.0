Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D2FFC761A6
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Mar 2023 12:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CEbRUz/ElrqRxRFuU1BfEJQbWcHx5l+POx/F9f+fgwA=; b=XOep3RznPr09Ax0B5sh6YEwvDN
	++2tUNsmBjbAfIR9nFM9MdNc27WuFqdIHWGGfcCnHYQw2xrncrowI/dQquYRvAHffcZBp90gSMUPb
	uGyNMTMxT/YefZooUGn/dJ1qcU7C9x5DAmiWpxsPz4BWar8WiPyjGTxCw//49VMGdbjD8TZMQx5wW
	7PXVaeo1nfdr2XJKaucRGaIbXJxUysQ5kjC2gwQa3ojFe/NWg10+hB0o1HdVND3PWaDQ5SL6dSEno
	gY5i5vutqzbS/zAsRwfESMo9auVu8an0quRjAd9IcTjPBlaoRCvar2Km+MU/y5X1ANXimC7j2dXw4
	+Ic1V28w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1phrnV-003nw4-0B;
	Thu, 30 Mar 2023 12:54:33 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1phrnR-003nvP-2A
	for linux-nvme@lists.infradead.org;
	Thu, 30 Mar 2023 12:54:30 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E02EB21A18;
	Thu, 30 Mar 2023 12:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1680180864; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CEbRUz/ElrqRxRFuU1BfEJQbWcHx5l+POx/F9f+fgwA=;
	b=MAh01rxkt3jKLYRuTWcScY8liVQvOxzNBNUQlElU56qbwx/O7y95U2xSqiuDw8Boqk2FE4
	KrFNfWiSehSRVpO7C6HMTY7+AYKZgyfMyCeC00+PLvjughRClyj/hvxghdk5iVfZTuvx76
	nlc2ZTTlANMgzWgLCdzWxWH3ceackgY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1680180864;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CEbRUz/ElrqRxRFuU1BfEJQbWcHx5l+POx/F9f+fgwA=;
	b=a+NNppD5K48IsvWYWJHJHPGu8FVsPng+HmE0iwy179TTuBSi0Mafoz9U4m9f+fh5VFABI1
	drgF9XFsiIxTEUDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D28761348E;
	Thu, 30 Mar 2023 12:54:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 8VFbM4CGJWSSdQAAMHmgww
	(envelope-from <dwagner@suse.de>); Thu, 30 Mar 2023 12:54:24 +0000
Date: Thu, 30 Mar 2023 14:54:24 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	Chuck Lever <chuck.lever@oracle.com>,
	kernel-tls-handshake@lists.linux.dev
Subject: Re: [PATCH 09/18] nvme-tcp: enable TLS handshake upcall
Message-ID: <20230330125424.q65gcbu7rrmnmueb@carbon.lan>
References: <20230329135938.46905-1-hare@suse.de>
 <20230329135938.46905-10-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329135938.46905-10-hare@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230330_055429_877014_7635B40E 
X-CRM114-Status: UNSURE (   9.59  )
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

On Wed, Mar 29, 2023 at 03:59:29PM +0200, Hannes Reinecke wrote:
 --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -609,6 +609,7 @@ static const match_table_t opt_tokens = {
>  	{ NVMF_OPT_DISCOVERY,		"discovery"		},
>  	{ NVMF_OPT_DHCHAP_SECRET,	"dhchap_secret=%s"	},
>  	{ NVMF_OPT_DHCHAP_CTRL_SECRET,	"dhchap_ctrl_secret=%s"	},
> +	{ NVMF_OPT_TLS,			"tls"			},
>  	{ NVMF_OPT_ERR,			NULL			}
>  };

This should be ifdef out for !CONFIG_NVME_TLS

