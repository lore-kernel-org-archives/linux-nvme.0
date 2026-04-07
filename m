Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70155FB5183
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Apr 2026 02:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uj0K5FyMi7XSuPG2uq1mtZavJKlMVDQzSk2zMk1W2/0=; b=ndtWdo0wHGg6aDFucnsoE16mhM
	pT5MEBbDsqTW5M1raPHfxQKKk1CqsztZgr96C0D0DTAacGz/zEA++zSDpxybVyuEeaNMBi556jwgU
	99FgcIX7DXPGsn8CxqxvIYN8lOkmWWX1BZ5BsEft3kqSxdLP1h4cnHJQJwTy5x9uJBjbmzaL3JblO
	OBKaCvtMsmgSeukXBSuQKNi/MYt9E1/RO5Eo0axoIKCW63ApuoR+lpDL2rWt5YJEvV4eYQozlmQqc
	ZJJVdNGC03DeoKwuAPigj+bqcmECl7TtIh4Vdfsb7ZO3LB05AoV5PAOw6+wU2n+V4pnUp48YLrIBx
	hg3Ir4Vg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9w3W-00000005kw9-3Xb1;
	Tue, 07 Apr 2026 02:20:42 +0000
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9w3T-00000005kvJ-0OAq
	for linux-nvme@lists.infradead.org;
	Tue, 07 Apr 2026 02:20:41 +0000
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-7d9bba96f7dso2384415a34.1
        for <linux-nvme@lists.infradead.org>; Mon, 06 Apr 2026 19:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1775528437; x=1776133237; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uj0K5FyMi7XSuPG2uq1mtZavJKlMVDQzSk2zMk1W2/0=;
        b=yZjZCR0iXSpvNn/DDhpKqsQdcyrOY5VHr90rFjF5MPsHSjbR6XGYl8wme3QI7sZ1/U
         Y7wEqfohZBzC/7k5DEz1tb8S1vkqDMfAVrhwkxT9JtN0tGribUjV+rWZIYQIMiDt/Sf7
         dVW5L6pFayj6731z5J7EvR4NcPaQO5BD6tqIbwFVAdANAKO7bDJGvGlXjQ/oKcR2q9dc
         jug6VvmpQZnVFMFRqAhW9OJDYif5fHTXLMpFVvtL05iss3VPxgH/9AOM1n/hTxtBNA+1
         hkMCEfKFhGSsG3fhcXvd3F7y8yWE7WYbpEdRYl35gEfupcxv/PNjtKOlvUfo9td+3c/Z
         8RLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775528437; x=1776133237;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uj0K5FyMi7XSuPG2uq1mtZavJKlMVDQzSk2zMk1W2/0=;
        b=oRu+OuLbT/5cIVZa4m26MdFr60wEuZGX6PPSlojGS1SW+yLDXh3LcroIklrEvfV73I
         tAdX0R6Vk1okzN2cnBHev4URp1YR6JwcbV9W2ScjDa2Ar5r2THepiUd6rweCm/5s8q/y
         NlezivCB1iq/2EnsWG1w70kbwZnQ+WQHc+7ukx4DAoXZ6DChwQgTqB+sNsGx+/N2QkIY
         DlAgH/GHCkhmRB0qmMjV/wbCoypPJs9nvwBMAZVubuIO9byuHI2dfKqxlDtXTtnHFsnC
         relc9dPX1cLOebGBPSOqSYf1EQKmo5e0eks7rOWfX37dhr8lxD1yCNmj8HQ0lRk5umI0
         NXdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFSC6+osopn6XkWWWY4o9Ea8YTZQmeTiiVzzDsFOluJxg4T88kpAkRNAYSiWDGEAKepJ1PjdWG06eW@lists.infradead.org
X-Gm-Message-State: AOJu0YzkXjA3QhM6X6yPofxX2solUs9VgqbSubZPtibcVHpBnDOtiGz/
	se1CTBsWhu2VJYqMJrv9OB3QeKbT3ReBYIujmq4d0OLnLWxx3ErjYr6L5YfjX9S+Mmo=
X-Gm-Gg: AeBDieuUoh3EMJoc0Id32zJJ2jhA0+AzGVAoO0lXxpschJbkNw9d2LCFVBqBk+QbX0F
	wk/x7xfXnLJRTb/JU2+pWkWZncA4OoXrBPZu+MCoHYuz6rEQpeehLlieUqUMfoQSUC8IM5Gkr/z
	MFVjLA7pxh0k1Mdigt9GFXwEMATS2ht+baFuvl5EFkrT7cI1KcfLHV6usmIBZek4RXPiJzHiJ4M
	5yMVMjR+aObXBM1PWmKt+N9NkVQIo8OE2SvsIEn1k0l+mJ/RZVzu66c0elKzcJ3yzSFxflxW/3y
	bhNb1g6exSBpjlzANdGrFEkpbrHnB0SI2mw3m/JZd9pYq4aW+D86M/06XU3kUAgDyX2lKwInrub
	w3Telly64tPMDuxUyGU2kJmUBRWXa6IlS8XcBlR3uJ+qdiUl37eHJqO68Zgq/y+6HBXtm7Eejb7
	o5NZHQ+S+u+v/0M6xV7itKx7C9ldyPk2g8s/klLUtXd10Efgtg3vbctbxk8uedgDiNGElvQBY56
	kvdRYePng==
X-Received: by 2002:a05:6830:83af:b0:7db:b68f:b819 with SMTP id 46e09a7af769-7dbb6f25a6emr9575077a34.6.1775528437568;
        Mon, 06 Apr 2026 19:20:37 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dbd663a4a5sm4895363a34.25.2026.04.06.19.20.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2026 19:20:37 -0700 (PDT)
Message-ID: <8143e057-4c3b-4365-8780-003e897b9baf@kernel.dk>
Date: Mon, 6 Apr 2026 20:20:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-apple: drop invalid put of admin queue reference
 count
To: Fedor Pchelkin <pchelkin@ispras.ru>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
 Neal Gompa <neal@gompa.dev>, Sagi Grimberg <sagi@grimberg.me>,
 Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, "Heyne, Maximilian" <mheyne@amazon.de>,
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org, stable@vger.kernel.org
References: <20260403202701.991276-1-pchelkin@ispras.ru>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260403202701.991276-1-pchelkin@ispras.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260406_192039_544160_F21D0AC3 
X-CRM114-Status: GOOD (  20.30  )
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

On 4/3/26 2:27 PM, Fedor Pchelkin wrote:
> Commit 03b3bcd319b3 ("nvme: fix admin request_queue lifetime") moved the
> admin queue reference ->put call into nvme_free_ctrl() - a controller
> device release callback performed for every nvme driver doing
> nvme_init_ctrl().
> 
> nvme-apple sets refcount of the admin queue to 1 at allocation during the
> probe function and then puts it twice now:
> 
> nvme_free_ctrl()
>   blk_put_queue(ctrl->admin_q) // #1
>   ->free_ctrl()
>     apple_nvme_free_ctrl()
>       blk_put_queue(anv->ctrl.admin_q) // #2
> 
> Note that there is a commit 941f7298c70c ("nvme-apple: remove an extra
> queue reference") which intended to drop having an extra admin queue
> reference.  Looks like at that moment it accidentally fixed a refcount
> leak, which existed since the driver's introduction.  There were an
> initial ->set and an extra ->get call at driver's probe function, and only
> a single ->put inside apple_nvme_free_ctrl().
> 
> However now after commit 03b3bcd319b3 ("nvme: fix admin request_queue
> lifetime") the refcount is imbalanced again.  Fix it by removing extra
> ->put call from apple_nvme_free_ctrl().  Compile tested only.
> 
> Found by Linux Verification Center (linuxtesting.org).
> 
> Fixes: 03b3bcd319b3 ("nvme: fix admin request_queue lifetime")
> Cc: stable@vger.kernel.org # depends on 941f7298c70c
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> ---
> 
> Also nvme-apple seems not to have a blk_mq_destroy_queue() call for
> admin queue since introduction - if it's needed, the proper place would
> be in apple_nvme_remove() just before calling nvme_uninit_ctrl(), I guess?
> 
>  drivers/nvme/host/apple.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
> index ed61b97fde59..1d82f0541b0b 100644
> --- a/drivers/nvme/host/apple.c
> +++ b/drivers/nvme/host/apple.c
> @@ -1269,8 +1269,6 @@ static void apple_nvme_free_ctrl(struct nvme_ctrl *ctrl)
>  {
>  	struct apple_nvme *anv = ctrl_to_apple_nvme(ctrl);
>  
> -	if (anv->ctrl.admin_q)
> -		blk_put_queue(anv->ctrl.admin_q);
>  	put_device(anv->dev);
>  }

Could this just be:

static void apple_nvme_free_ctrl(struct nvme_ctrl *ctrl)
{
	put_device(ctrl->dev);
}

at this point?

-- 
Jens Axboe

