Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87846D116F3
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Dec 2025 00:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5jTJmblR2HM/nn4wteeMJ84PCpTR9lLFl2d+4kB+jSI=; b=s/RNiqcDdTkOkMipazZDs+uAuS
	wbWylu2llxAdoCaLzt5NwZzzJU2a2PMciuzahqgF43G0WLVxTMSfq/nHmj2GwfhdMtXsikfJaL8Lm
	DgjmLTJL342HzpXH2N9kBnXuHRXNap5dFh/ImUmoBQvOMP9igXdHOFjETzl+kYN3MOpMgQvHe5pHn
	w83PJGeveXaKB733n23mGCJrfds3i9bFpRvU0phP4g3t4D4KMTl2tJV+hU9hPaVgJPVY3CiyNrOdF
	NQpyBLjfowwQfY0YdwzLhA22ZFCEa8eLj3nxkljFjhHDETOEnFHRq6+1D84c4R3YIimL+ji9HPA9T
	W0QYDO9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQEFF-00000004dn3-31mq;
	Tue, 02 Dec 2025 00:27:53 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQEFD-00000004dmg-36ng
	for linux-nvme@lists.infradead.org;
	Tue, 02 Dec 2025 00:27:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D2B3A407A6;
	Tue,  2 Dec 2025 00:27:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63865C4CEF1;
	Tue,  2 Dec 2025 00:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764635270;
	bh=8OcKANKMxhWbSldT3hHBonHczicnEeMyT6RjUAi6Jhw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qC2i16CAe9ktzbd92ui05tsH3RV6sZGK8jrxwIk2P6arVSgFKvS1c0lNw1ANIph4k
	 P+ygry9eytqkxyvd3ipKi5mWg6rCe7Yd0/4IEf+VF0+mtAb838fVmiJQkNxATZluFv
	 tZUznbp/7KX/Yrmsc755bJtKztBbvVESMl/mP8K59KQN8NPey2I2+pnIIjlDQMkQGB
	 dpcvFb+WomQIEcf7azj4S/+d7Iw5joy+zD0MD7bwHySDSZ4Z7+OfXpiNFUu+VzGtb8
	 z0gKGNSDHB0N9EEhdCxXS8HMR5KcjMXhX2IoiHZBZ6nDZvGmaaFeH1CcITI2s9yz2q
	 LPHgpnKFug+Rg==
Date: Mon, 1 Dec 2025 17:27:48 -0700
From: Keith Busch <kbusch@kernel.org>
To: Eugene Korenevsky <ekorenevsky@aliyun.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] nvme: nvme_identify_ns_descs: prevent oob
Message-ID: <aS4yhAhZYjvHOqtD@kbusch-mbp>
References: <aS3v2_VcV8IwsT6g@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aS3v2_VcV8IwsT6g@localhost.localdomain>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251201_162751_821702_C574AC73 
X-CRM114-Status: GOOD (  13.21  )
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

On Mon, Dec 01, 2025 at 10:43:23PM +0300, Eugene Korenevsky wrote:
> -	for (pos = 0; pos < NVME_IDENTIFY_DATA_SIZE; pos += len) {
> -		struct nvme_ns_id_desc *cur = data + pos;
> +	pos = 0;
> +	do {
> +		cur = data + pos;
>  
>  		if (cur->nidl == 0)
>  			break;
> +		/* check ns id desc does not exceed remaining buffer by size */
> +		if (cur->nidl + sizeof(*cur) > NVME_IDENTIFY_DATA_SIZE - pos)
> +			break;
>  
>  		len = nvme_process_ns_desc(ctrl, &info->ids, cur, &csi_seen);
>  		if (len < 0)
>  			break;
>  
> -		len += sizeof(*cur);
> -	}
> +		pos += sizeof(*cur);
> +		pos += len;
> +	} while (pos < NVME_IDENTIFY_DATA_SIZE - sizeof(*cur));

I don't want bikeshed this, but I thought this looked better as a
for-loop. You can just modify the continuing condition instead of
changing the loop type to do-while.

