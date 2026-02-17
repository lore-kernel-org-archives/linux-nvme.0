Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 612BCE9A03B
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Feb 2026 20:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k8SqbdrAk7OPRqDyi7dtTLUSquWoyRO2qBWnvkuiTiw=; b=dDn94/0WhoxNYQVqLe+YYpurJs
	HTM71rxJhWuECc/vnSpEWbTmlfa1avXHGk9LKekWvm7CKRnDp1R2xIrGLz2E4RoyzF5P1uABBt+PR
	F+VlzAvPeKRfqcac255+9SnpxzZ+OuzPrOMa6b54twz5mCNhNatP7+M6SrTSYW5vDRLyMwqEYkxWD
	OOHwZOBdixr40cXpqmXF8P6Cr/Z51VrOpwhyaWLLsBw7Ags91xphO9mvTLefFT+eKS3dfFos6KuIh
	NTZsojaT+vVe0UtQAV8I5yMkUAygIDydRyJ8uxpeYApls9BLOekXH3XnqfQl/UdyABjorHnsgqUL3
	Ippkmg4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsRaP-00000008qmh-3HK1;
	Tue, 17 Feb 2026 20:22:21 +0000
Received: from mail-dy1-x132d.google.com ([2607:f8b0:4864:20::132d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsRaN-00000008qm7-0ny4
	for linux-nvme@lists.infradead.org;
	Tue, 17 Feb 2026 20:22:20 +0000
Received: by mail-dy1-x132d.google.com with SMTP id 5a478bee46e88-2baa098ffc6so3876780eec.0
        for <linux-nvme@lists.infradead.org>; Tue, 17 Feb 2026 12:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771359738; x=1771964538; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k8SqbdrAk7OPRqDyi7dtTLUSquWoyRO2qBWnvkuiTiw=;
        b=VjnfdCStoh4ffIsRDHrrHTTm/dUYmP5ehxfBj6/l94cMlp3pfBYlcanJkKQ9iZxMOI
         MlNOgZ5Y4GbYChh2f/mx0THN/dc8i8lh6wdfkdt3RwX+3Xn/vasJyONrJHjH1lNM/+ui
         gA0vbG/n1Uep7j1ck+r11RY+M3PXF4GxtxunglFlD3N5b9FfDYE3GwR20JM9KKGc/RTi
         6nmpSil2BvjQrM7ztLoX0eYENh0Xv7KzMIedxn/M9WTi3Tl/qp05iftck2Mo/52bsgc9
         MSEi/A3ALGBX7i0jHwPWMrK+3yqITddeGEAB5hpZ3rdrF4O5SKRAUICyy5chzsbkUcVI
         hfeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771359738; x=1771964538;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k8SqbdrAk7OPRqDyi7dtTLUSquWoyRO2qBWnvkuiTiw=;
        b=SEJc89vO0pr8FPJ3tNRZcbfYIWBeiPiT7ON5o7B2G9kGemfj7Z9n5kwAScQhyuNuyG
         7vX/sDlnF9R4LCSlhPK1HGUlG/D7+/11YX4NN2nuCs2eNsYOxXIzI0EkvKAqDB9p4ztc
         8QysAw2NyJf4WlOHBrayrnJ3KJd2VyRA/B/9PNU2OwOh7YJrTBoa+70ZikH1pH/XSK7J
         uMCiG46WCAz4ALIn6vOXKgKtrrxiKmHFPNgPR92/zElh2kugiX4mDJ/YZnqPYAbOvxZt
         yJCMTCD8iTilKallj9C6l3fW1fY5MfijQ9kK1YU/+qzrYyJ3K9dHHiQxOpWVp8ggHS+I
         rsjg==
X-Forwarded-Encrypted: i=1; AJvYcCXHRBPl/E1Om2/rMAR57BKMP137l0k4L5M4DMMUFyyE7ETTubUs6R2UnALi4uOduJbQx3nrO7b/CysZ@lists.infradead.org
X-Gm-Message-State: AOJu0Yxb2MuZrIBQiB5hH5vSdJGO+eVn+7DSa43YUy97GdWY4RyYqDcX
	LmWVM3/2w2F5wMnnKgfJBVT0LnwIaZGhsRzKOweiIVXmODZNLVIjIRMGc5eN7Po2iSw=
X-Gm-Gg: AZuq6aJx3GB3nJKtg6+F177OunGNRnuNTWrCpsdf+b6+Ey+6kFOHzBqRkfnsF7qUa1A
	LJOsW/eXIX4KhJbGo0bTE9/TC2uXQnEgaO8D4OF3Jy+SEDat0IGM1R7E0xsgatuLpPCVO/w4Y87
	iqZc0wdHcrr70i95TbjBt+tRPCczYCS1Dp3YIhvrpvORWujhlGWIVVopJSuMMAL3yf3+6fqK0bJ
	jGxAN+ytRlV4HBCdw6MpZOhiRVkxVFgLGeEmTTcEOHHhNUCBrOCo6wdl49RfFA6IMOQmej+ixFq
	XcZnFTz2jW0T9wabjiGiejJfqZx0S8pddNodRn46sWRj5ajYugkUiME0CND4UoNUERcQo+RWV6f
	9/f9fD3jKD80fSrdO8VY4uQxF3J0CBLOG6Mr0r6I0GKNMztPcza2LLk7QAkyHJ16/GcMrZNmVPB
	nQgN6zkE+L6S/WnzlTfRQCPvBUZ5b/WkZlb4QKaG6YfQI=
X-Received: by 2002:a05:7300:d70b:b0:2b8:2910:dc9b with SMTP id 5a478bee46e88-2baba010c12mr6260135eec.3.1771359737265;
        Tue, 17 Feb 2026 12:22:17 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id 5a478bee46e88-2bacb6782e5sm15346420eec.29.2026.02.17.12.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 12:22:16 -0800 (PST)
Date: Tue, 17 Feb 2026 12:22:15 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: kbusch@kernel.org, mheyne@amazon.de, emilne@redhat.com,
	jmeneghi@redhat.com, linux-nvme@lists.infradead.org,
	dwagner@suse.de, mlombard@bsdbackstore.eu
Subject: Re: [PATCH RFC 3/5] nvme: pci: use admin queue timeout over
 NVME_ADMIN_TIMEOUT
Message-ID: <20260217202215.GI3435530-mkhalfella@purestorage.com>
References: <20260212120951.79738-1-mlombard@redhat.com>
 <20260212120951.79738-4-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260212120951.79738-4-mlombard@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260217_122219_252964_34B04029 
X-CRM114-Status: GOOD (  17.75  )
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

On Thu 2026-02-12 13:09:49 +0100, Maurizio Lombardi wrote:
> From: David Jeffery <djeffery@redhat.com>
> 
> While tearing down its queues, nvme-pci uses NVME_ADMIN_TIMEOUT as its
> timeout target. Instead, use the configured admin queue's timeout value
> when available to match the device's existing timeout setting.
> 
> Signed-off-by: David Jeffery <djeffery@redhat.com>
> ---
>  drivers/nvme/host/pci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 58f3097888a7..853cd57e4480 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2911,9 +2911,10 @@ static bool __nvme_delete_io_queues(struct nvme_dev *dev, u8 opcode)
>  {
>  	int nr_queues = dev->online_queues - 1, sent = 0;
>  	unsigned long timeout;
> +	struct request_queue *q = dev->ctrl.admin_q;

Maybe place q between nr_queues and timeout?

>  
>   retry:
> -	timeout = NVME_ADMIN_TIMEOUT;
> +	timeout = q ? q->rq_timeout : NVME_ADMIN_TIMEOUT;

Under what condition we expect admin_q to be NULL?

>  	while (nr_queues > 0) {
>  		if (nvme_delete_queue(&dev->queues[nr_queues], opcode))
>  			break;
> -- 
> 2.53.0
> 
> 

