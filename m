Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EFDEC77B7E
	for <linux-nvme@archiver.kernel.org>; Mon, 29 May 2023 17:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NegH+swazvU/wxlTpibh451W3Q3aF6wr5EDdgLaDl/w=; b=JjV+xp4Jxym95K0KUelcSodmuq
	w9SZstLOsSvxP4EI8BtFcZcwm8uB+emfJ9u5H7I7aDy+VCUdDcxVx83Sq0sfq4rBbw24f3iyNzuOZ
	eF/v5zIe6gvLQjQRKUAYs58v8L163tRNNCRt6L/N03rMT3pm2WzPfNfDVd65/mdR59N8NaY/TtJNw
	bD6ETLWwRbLJxsqT3FeRBrHxooK18ASI9aOwbiP4uXFJB0Y1SiC0BbCDC6JmgzKILLasO9e8VCRmj
	HIUlthhu1ZfVE2yY2XzWXhdRV8XRK1OrV6dsq0xYkBuoKjd2VKnQN1peFYO5STq2u/P2i1RS3BAxY
	0vUvWyig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q3gtE-00BHet-2K;
	Mon, 29 May 2023 17:42:40 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q1fZY-00CGtF-3C
	for linux-nvme@lists.infradead.org;
	Wed, 24 May 2023 03:54:02 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id D568863866;
	Wed, 24 May 2023 03:53:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD908C433D2;
	Wed, 24 May 2023 03:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684900437;
	bh=4f1gt/BCfbLHog09/Xsin0iYouAloZtBkhPaw5h+3Uk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VTjRau/bNOfmdJ33zPP9fzppLzalj2n66xWeUM8et/U2kDIXenWJlws9ke/J63cua
	 7h8nbEpBrHk+3kbBwK4hYrTG0TJuuA4Y8nyVrZV34Feh/wVZUCXe9pHkiL5GrZpTPb
	 1pUq0WoLiV4z1hh/q8nIAUP6Q7nvRsPe6zxlxMbem5vTDjKC2IBSsISEX6TycDAT+K
	 E11xrcZaYzPDD+AvVcAUfQueTdIeTLMtPcPMx7rpOceZRwETWUuo1o7AcoLQuOypBm
	 fbpREO7W2cFcnLHLSfIPlJAIvbGWiK22cduJxuIMSKGEpMfWr2jO0/7hSlREuEGrtM
	 7Bq4VihlXfeWA==
Date: Tue, 23 May 2023 20:53:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>, Christoph Hellwig
 <hch@infradead.org>, Tony Nguyen <anthony.l.nguyen@intel.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, James Smart <james.smart@broadcom.com>, Keith
 Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Sagi Grimberg
 <sagi@grimberg.me>, HighPoint Linux Team <linux@highpoint-tech.com>, "James
 E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen"
 <martin.petersen@oracle.com>, Kashyap Desai <kashyap.desai@broadcom.com>,
 Sumit Saxena <sumit.saxena@broadcom.com>, Shivasharan S
 <shivasharan.srikanteshwara@broadcom.com>, Don Brace
 <don.brace@microchip.com>, "Darrick J. Wong" <djwong@kernel.org>, Dave
 Chinner <dchinner@redhat.com>, Guo Xuenan <guoxuenan@huawei.com>,
 Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>, Nick Desaulniers
 <ndesaulniers@google.com>, Daniel Latypov <dlatypov@google.com>, kernel
 test robot <lkp@intel.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com,
 storagedev@microchip.com, linux-xfs@vger.kernel.org,
 linux-hardening@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Tales
 Aparecida <tales.aparecida@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] overflow: Add struct_size_t() helper
Message-ID: <20230523205354.06b147c6@kernel.org>
In-Reply-To: <20230522211810.never.421-kees@kernel.org>
References: <20230522211810.never.421-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230523_205401_114109_9666F9C3 
X-CRM114-Status: GOOD (  14.37  )
X-Mailman-Approved-At: Mon, 29 May 2023 10:42:39 -0700
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

On Mon, 22 May 2023 14:18:13 -0700 Kees Cook wrote:
> diff --git a/drivers/net/ethernet/intel/ice/ice_ddp.h b/drivers/net/ethernet/intel/ice/ice_ddp.h
> index 37eadb3d27a8..41acfe26df1c 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ddp.h
> +++ b/drivers/net/ethernet/intel/ice/ice_ddp.h
> @@ -185,7 +185,7 @@ struct ice_buf_hdr {
>  
>  #define ICE_MAX_ENTRIES_IN_BUF(hd_sz, ent_sz)                                 \
>  	((ICE_PKG_BUF_SIZE -                                                  \
> -	  struct_size((struct ice_buf_hdr *)0, section_entry, 1) - (hd_sz)) / \
> +	  struct_size_t(struct ice_buf_hdr,  section_entry, 1) - (hd_sz)) / \
>  	 (ent_sz))
>  
>  /* ice package section IDs */
> @@ -297,7 +297,7 @@ struct ice_label_section {
>  };
>  
>  #define ICE_MAX_LABELS_IN_BUF                                             \
> -	ICE_MAX_ENTRIES_IN_BUF(struct_size((struct ice_label_section *)0, \
> +	ICE_MAX_ENTRIES_IN_BUF(struct_size_t(struct ice_label_section,  \
>  					   label, 1) -                    \
>  				       sizeof(struct ice_label),          \
>  			       sizeof(struct ice_label))
> @@ -352,7 +352,7 @@ struct ice_boost_tcam_section {
>  };
>  
>  #define ICE_MAX_BST_TCAMS_IN_BUF                                               \
> -	ICE_MAX_ENTRIES_IN_BUF(struct_size((struct ice_boost_tcam_section *)0, \
> +	ICE_MAX_ENTRIES_IN_BUF(struct_size_t(struct ice_boost_tcam_section,  \
>  					   tcam, 1) -                          \
>  				       sizeof(struct ice_boost_tcam_entry),    \
>  			       sizeof(struct ice_boost_tcam_entry))
> @@ -372,8 +372,7 @@ struct ice_marker_ptype_tcam_section {
>  };
>  
>  #define ICE_MAX_MARKER_PTYPE_TCAMS_IN_BUF                                    \
> -	ICE_MAX_ENTRIES_IN_BUF(                                              \
> -		struct_size((struct ice_marker_ptype_tcam_section *)0, tcam, \
> +	ICE_MAX_ENTRIES_IN_BUF(struct_size_t(struct ice_marker_ptype_tcam_section,  tcam, \
>  			    1) -                                             \
>  			sizeof(struct ice_marker_ptype_tcam_entry),          \
>  		sizeof(struct ice_marker_ptype_tcam_entry))

Acked-by: Jakub Kicinski <kuba@kernel.org>

but Intel ICE folks please speak up if this has a high chance of
conflicts, I think I've seen some ICE DDP patches flying around :(

