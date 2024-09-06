Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B41CE7AB8
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Sep 2024 07:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kp6WxUGLrmlMjG6TQdYpont4auxYnJE01C96ftGEZ60=; b=b8t80HX3XhpnuJBWPw0b+TvSQ7
	7tyN1djJ1AkGDFulBcPeqK/yH/WevR0zGa3/W7XdHP+jif0XdSEyU7B1B3N4WOlPz/xQMusUqdTlZ
	NC1KqvhOl71uZlm8pcU2X8cB8z8HbzjBxii32wQ+eZfYRu1pjeTb5J6f2OVHWGcEgH0u5P1wUGvDT
	jtbx3T+cZYkSGVVSFYKE6a8cBN0eRyUgl0G23aCIES7T/U2M6a+g5/VIWFYaVspgktss+xZWZoYRZ
	jKfzhZI4WScJZCbWt/te/Ybj4dSB+dc2mE5myZucocI6u/Osx+IaHBF5mjLum+frc6EYOvok35mho
	l/TZAONQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smTdA-0000000B911-270o;
	Fri, 06 Sep 2024 07:43:44 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smTYN-0000000B7yh-3xkd
	for linux-nvme@lists.infradead.org;
	Fri, 06 Sep 2024 07:38:49 +0000
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-374c84dcc64so1120979f8f.1
        for <linux-nvme@lists.infradead.org>; Fri, 06 Sep 2024 00:38:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725608326; x=1726213126;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kp6WxUGLrmlMjG6TQdYpont4auxYnJE01C96ftGEZ60=;
        b=n/JW8IJ4TDauLiqvTKEdSw7X155BdF4Q4bfgsvNbSqfwg1hn2UIYNMrpipptHGZqDj
         ILcTSlMm+w28r/ylBQXG9gUjv0rOpjcWCsqLoWUiW5pWSD90mi97D8sOgzEmhwNlIMWx
         nbOmdQUk7WrhDE0yHC9hlO8ofms2nwI9cJu43ciMfvkLsXnZsv1DKHR05PBbC9zuy+NE
         6FEdPTNy5CBrSp2PFJBEvYlit4pnionOsYYM/cZxUCV/tiFfVXqGMCcjhecEq0B0JDny
         P4BvkKWTTqrR5Wy/OuG0SV04qEfxFyNtt3dFpC5jsPgu0HOALwdwJHgLg9vI5WT2GzZu
         9A3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVsZV9oSs/NtJP6H6z4NVcBrCMO3BoIUQ5E5Q/7Tas8YzdRNs3MrNH/zv+mFBn1YFTSjjK9m4wbcGSt@lists.infradead.org
X-Gm-Message-State: AOJu0YwBrMIMFJ1uLPwRJY7vhDF2qTKGgMrkkAyPhVYPLAwDvfH399Lk
	JQi36eTw0mMsmUeDKdWP7oTIiiCStoj9r37MplMkcsE7XwJZzvN8ICK0Cw==
X-Google-Smtp-Source: AGHT+IGZV0lEJLjx2Uah/ziZKaIDRZGSZawHtSE6I3JM0+ZIqUok8nHpmOg3nhI7KzX49d37aLPR1A==
X-Received: by 2002:a05:6000:b82:b0:374:bb28:2c29 with SMTP id ffacd0b85a97d-374bb282d0emr16802971f8f.0.1725608325495;
        Fri, 06 Sep 2024 00:38:45 -0700 (PDT)
Received: from [10.100.102.74] (89-138-71-253.bb.netvision.net.il. [89.138.71.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374cc75a5fbsm11901143f8f.80.2024.09.06.00.38.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 00:38:45 -0700 (PDT)
Message-ID: <bb65b34d-9f30-4799-b34e-9665367b8aa0@grimberg.me>
Date: Fri, 6 Sep 2024 10:38:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] nvme: set 'failfast_expired' in
 nvme_remove_namespaces()
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240906071828.125614-1-hare@kernel.org>
 <20240906071828.125614-5-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240906071828.125614-5-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240906_003848_030977_C2F2DF8A 
X-CRM114-Status: GOOD (  21.54  )
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

Please describe what the patch fixes in the title, not what it does.


On 06/09/2024 10:18, Hannes Reinecke wrote:
> nvme_remove_namespaces() is only called when the controller is
> being removed. If there is a scan process still pending and
> the I/O from that process cannot make progress (eg if all paths
> are in ANA state 'inaccessible') we cannot disconnect the
> controller as the 'nvme disconnect' process will hang in
> flush_work(&ctrl->scan_work).

Please include the hang process stack.

>
> This patch sets the 'failfast_expired' bit for the controller
> to cause all pending I/O to be failed, and the disconnect process
> to complete.

How did you reproduce it? trigger namespace scanning and disconnect-all
in a loop? Can we get a blktest for it?

>
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> ---
>   drivers/nvme/host/core.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 651073280f6f..b968b672dcf8 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4222,6 +4222,13 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
>   	 */
>   	nvme_mpath_clear_ctrl_paths(ctrl);
>   
> +	/*
> +	 * Mark the controller as 'failfast' to ensure all pending I/O
> +	 * is killed.
> +	 */
> +	set_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags);

What about nvme_stop_failfast_work() ?

> +	nvme_kick_requeue_lists(ctrl);
> +
>   	/*
>   	 * Unquiesce io queues so any pending IO won't hang, especially
>   	 * those submitted from scan work


