Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1F39FCD0C5
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Mar 2026 07:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Er4/c7SlcLqsoPZuu/zr1GbCtexm9fJPQ91bx/nveEc=; b=TZ8q2vQWdEJ873668JQihKucRo
	II5Wx/SQFlAgb0UOXct1/UP5XuDZ3n0G7H5NKWmamMoLXFkVuWQiHg77YxdSNbCRKj5XDPfZIyeiJ
	PEK06bk9D4oJq7fKPaVTy59eZneTPdkIdopNEssU6cRyjY5NgX2E0H4ZC32eAxKp/lTnYO+thkYFK
	0Zq/Wb6L2h9nkDk1N0V+P6sZniYdu1zaz5K63BWvzRkccI9rZph5RylK9eB+nzeLFZIOc2v4gi5lp
	t/eIretqfMadnXulKmJtJvgRAT63gWlxKuVMXJq2a0DYEyxmsY7a5KyJ4uZUZuhzLNHu6hSI76Jva
	BIPJgv1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2lm2-00000007y2S-089b;
	Wed, 18 Mar 2026 07:57:02 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2llz-00000007y1t-3LIU
	for linux-nvme@lists.infradead.org;
	Wed, 18 Mar 2026 07:57:00 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C31DA68BEB; Wed, 18 Mar 2026 08:56:55 +0100 (CET)
Date: Wed, 18 Mar 2026 08:56:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: alistair23@gmail.com
Cc: hare@suse.de, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alistair Francis <alistair.francis@wdc.com>,
	Kamaljit Singh <kamaljit.singh@opensource.wdc.com>,
	yjshin0438@gmail.com
Subject: Re: [PATCH v3] nvme-auth: Don't propose NVME_AUTH_DHGROUP_NULL
 with SC_C
Message-ID: <20260318075655.GA25711@lst.de>
References: <20260318004658.3681991-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318004658.3681991-1-alistair.francis@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260318_005659_976488_8521A737 
X-CRM114-Status: GOOD (  14.71  )
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

On Wed, Mar 18, 2026 at 10:46:58AM +1000, alistair23@gmail.com wrote:
> +	idlist[dh_list_offset++] = NVME_AUTH_DHGROUP_6144;
> +	idlist[dh_list_offset++] = NVME_AUTH_DHGROUP_8192;
> +	data->auth_protocol[0].dhchap.dhlen = dh_list_offset - DH_GID_LIST_OFFSET;

Still an overly long line here.

>  
>  	return size;
>  }
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index 655d194f8e72..bd540ef33b63 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -2332,4 +2332,6 @@ enum nvme_pr_change_ptpl {
>  
>  #define NVME_PR_IGNORE_KEY (1 << 3)
>  
> +#define DH_GID_LIST_OFFSET 30

Note that we have a target side patch ("nvmet: auth: validate dhchap id
list lengths") also adding defines related to this, but in a different
place and using different naming:


+#define NVME_AUTH_DHCHAP_MAX_HASH_IDS 30
+#define NVME_AUTH_DHCHAP_MAX_DH_IDS 30

Back in the day we usually did nvme.h patch separately to handle these
kinds of conflicts a little better.

YunJe/Alistair, maybe whoever resends next should split this out,
add all the required values and add a pointer to the spec?



