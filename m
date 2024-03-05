Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2752DC54798
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Mar 2024 16:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6p+B6BMfSNiRzpUCkMXN3MfTQDg6PWb4kzKLXddhMRs=; b=q1R+0JHVk8QeC9LSt+u3MbKZB8
	iUSdt+CiXXkO4awa47tWE5/WIpGZRRWn/0b7mlJ/SEWu3cTE0CxMhLqqpFGDfCw66p9/EjuTLVdMF
	ZG99nx93Y6/0bOgxC+oTuyrSad0VXfdD6D+DgKTk1/meWEAsr0I01k7UkgNnI/lWUXDqTS/pxhZAN
	syVfhfyeJ2lkBZxsA86BjBD3MIJWStAZe94EVJ911olpAD+Mt7ZZBswhz455Gf03DwtmyJh+HlH6k
	c0RGWvb8I4h57x5xXLb0mDWDosossAx2edZDQnGHtmbQ8RhGm40MkLLOlhuWutygWsWDAXfA8w4gT
	ZtCN9cLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhXk0-0000000EVBH-1Dgz;
	Tue, 05 Mar 2024 16:34:08 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhXjy-0000000EVAJ-0Pt6
	for linux-nvme@lists.infradead.org;
	Tue, 05 Mar 2024 16:34:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 853D5CE1CDD;
	Tue,  5 Mar 2024 16:34:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 523AFC433C7;
	Tue,  5 Mar 2024 16:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709656442;
	bh=Hy/sLtg6t7BqeNEZwrs+35Mppc5n5bY4B8ykw9pkx30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NZK3FcUBvwt/chd01wKwQu8AHCym7Mkis8vgA4835wFx9gFtZ1ZX/h3laOjf7HLdn
	 vcLWPPdWa4VQMmILRHkBmDKTRqlQp5h3bf1JEoj5NConRCpS37MLXRxKP/+6aFjn0p
	 WNp7pqAxnXQXIWhihGJtNBDoBTssLfytYVEKmGXKY5AchI+XyqfMmkzVsEEF+ajZ54
	 7YJVS4P3XCRYcm+2r94i/JPSe74enKUmhvU2X3G7KghmpqWGTNTpq9IhsEdhN7Z95W
	 k90zsQWHWICs5Du6BFN4TbZlfcwS8VFlDGzxMMonWiomlcZRtI3Y2jfpIDTAQN/F+O
	 i9KyH26zbGOWA==
Date: Tue, 5 Mar 2024 09:34:00 -0700
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH 1/2] nvme-core: add ctrl state transition debug helper
Message-ID: <ZedJeFUpuogtBSd5@kbusch-mbp.mynextlight.net>
References: <20240212042641.227821-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212042641.227821-1-kch@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240305_083406_362999_546287BA 
X-CRM114-Status: UNSURE (   8.33  )
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

On Sun, Feb 11, 2024 at 08:26:40PM -0800, Chaitanya Kulkarni wrote:
> @@ -621,6 +636,9 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
>  	}
>  
>  	if (changed) {
> +		dev_dbg(ctrl->device, "%s %s -> %s\n", __func__,
> +			nvme_ctrl_state_str(old_state),
> +			nvme_ctrl_state_str(new_state));
>  		WRITE_ONCE(ctrl->state, new_state);
>  		wake_up_all(&ctrl->state_wq);
>  	}

Turing the system logs up to debug level might get you a whole lot of
unrelated stuff. Could a new trace_event get you what you need instead?
There's more fine grain control on those.

