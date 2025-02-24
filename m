Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5512C021A4
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2025 22:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5Brl1HmaC0pMotRSff9RqCKofxWMST5H20PImARUhKI=; b=BzGOaBShfwGaC2NvdQJ4smC5jU
	fgWaA19jdltZQGwINbXuzFpA90o7xvAjvPL5v/JAymTueFJEc+i4QkCRFK02MlFzbl0FOuc9hsUnR
	0QKhByx9XDNHU78KEC0bo87THGdmTmFEUwPImSMQ3jgtKm1A8VmGkQQWYQnl5aSnVQRmwchubxI6/
	uN0YGweUbeOdkuFFhic5wIPJQZG2wWsaT1zQYPGAMYi/BlItX+mN/M3ONtonAlBbk4rnO/H1KGEPA
	Ijrw6av3OZj4n006uZDxtMTGyE3gLiGsnfgjTHUmuDNPrqsBnq2o9kPNNcQR5YP+OBFBDuc8kApnH
	RQMbInsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmgwj-0000000FN6q-39pn;
	Mon, 24 Feb 2025 22:29:05 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmgwh-0000000FN6d-3Jyr
	for linux-nvme@lists.infradead.org;
	Mon, 24 Feb 2025 22:29:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 2493C611F8;
	Mon, 24 Feb 2025 22:28:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FFDDC4CED6;
	Mon, 24 Feb 2025 22:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740436142;
	bh=OhsJzdaiBXULMplU3Pc/KZOuDLG3W6y1Pbua3iPllwE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=U1H/XSZr+CETRw6oA+A1XMZPDzCuZF5lpyUc9DaDiIyARKjeF7lNlCOFWORp5bBsB
	 36dQhTrPyQ1m2IgejTTr7sQ9J6cvLE5UwxeLVBz7tquwy5b0ZxZbN1z483h9toCFxU
	 ZnOETWDA8h7/OCcVNdqOqmX0oc2ONnHqps6HrO90oD2oagkDBNiv1aR/Vb/MFc/vAp
	 BGyMo3Ly2JYYIHUK19YMKVDHCvdYAI/XDjFBZnZGd2SiVFz2DX6rDcGqPz2PAHvjg2
	 UTdyhG1YvBPm9ufBEPCdVGLHOViB8HBbTuLcj5elUAdS5LYPoUMF5wQ7XtwfyjGvYu
	 n6VKZBU5zW2Dg==
Message-ID: <b15b831d-a54b-4b0d-9aa2-af43d73de58f@kernel.org>
Date: Tue, 25 Feb 2025 07:29:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] nvme-ioctl: common user timeout setting
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
 hch@lst.de, sagi@grimberg.me
Cc: Keith Busch <kbusch@kernel.org>
References: <20250224182128.2042061-1-kbusch@meta.com>
 <20250224182128.2042061-5-kbusch@meta.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250224182128.2042061-5-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 2/25/25 03:21, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Most of the passthrough paths repeat the same request timeout setup, so
> make it common with the request allocation.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/nvme/host/ioctl.c | 23 +++++++----------------
>  1 file changed, 7 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
> index 3da014ccbe550..1f28fc4b341dd 100644
> --- a/drivers/nvme/host/ioctl.c
> +++ b/drivers/nvme/host/ioctl.c
> @@ -101,7 +101,7 @@ static void __user *nvme_to_user_ptr(uintptr_t ptrval)
>  
>  static struct request *nvme_alloc_user_request(struct request_queue *q,
>  		struct nvme_command *cmd, blk_opf_t rq_flags,
> -		blk_mq_req_flags_t blk_flags)
> +		blk_mq_req_flags_t blk_flags, unsigned timeout_ms)
>  {
>  	struct request *req;
>  
> @@ -110,6 +110,7 @@ static struct request *nvme_alloc_user_request(struct request_queue *q,
>  		return req;
>  	nvme_init_request(req, cmd);
>  	nvme_req(req)->flags |= NVME_REQ_USERCMD;
> +	req->timeout = timeout_ms ? msecs_to_jiffies(timeout_ms) : 0;

Should we check for overflows / MAX_JIFFY_OFFSET here ?

-- 
Damien Le Moal
Western Digital Research

