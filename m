Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1D2DCFD376
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Nov 2025 23:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p4J7iM7ZGQTZDyBLcWpq/IqhyIm12Ui+EB/+V2R9wRQ=; b=hnONXY9FfWLQnRMDQoCaXf+Ao/
	NlDz5y9JZ4D6KgEDda6ZDf8bcvMgak7HIYKJkoeA/LDCYLa4O9izZd67oxC5T8RJZ6+2OfZdllz5K
	7Z6+frMASsb223gjIi1XkQ2JZOZuZEEWBSQHhe5FpvFYpkwkFgYxzy9BD1/RwStdJMsJ/en1MGsuG
	bCbPYEwI73YFBc4RSNXgW7uNCtDKNXGzL6PQEsJ3TyKX6qvf/NbJUZ3Jm7bG4zZKUzHDJ0uwoAKDB
	TysJUQa/0L1yhmDQaps90B8cJRg+rtYj0BDVH40Nm97LH1kUmSwoN/5QR4y0X/A/crS8ZbsYqEuJs
	wsq7BNjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPqY8-00000002fD9-0uDo;
	Sun, 30 Nov 2025 23:09:48 +0000
Received: from mail-wm1-f41.google.com ([209.85.128.41])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPqY5-00000002fCi-2xnN
	for linux-nvme@lists.infradead.org;
	Sun, 30 Nov 2025 23:09:46 +0000
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-477b1cc8fb4so20682625e9.1
        for <linux-nvme@lists.infradead.org>; Sun, 30 Nov 2025 15:09:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764544184; x=1765148984;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p4J7iM7ZGQTZDyBLcWpq/IqhyIm12Ui+EB/+V2R9wRQ=;
        b=L3S/RNoX1p11ESw+elLeH45SK6TESK/4LuIe6VDLDifLbPBT+b52MB1716ym1nBNu7
         4iI5UwqEjIp/w9PjQjbX09xmtDOwwl6hvrPRo23+fkVubuoGgx+RIkeEFnbwOLGShC0A
         tiJULqa4QmUoDfE2GnnX8P+oxWxu+yNs6d3Hm/4Lt7As0wYfXoDLwhQ9KVbnviwzr/fB
         Xsf9wdUOXDyAKrk9SlTVlDAWpdqKxVxj9iWPXmEmdh1P/AU9KeWXGlSfVOzfow7PqgMC
         u43alLgQI7WWNEVSOG/4xDjOPe32o5zm5jyg/s92EouADvAfkaun2Qe91dXKUgqFWSrv
         64CQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaUW4B2RQqAZIILWiUyWUy1oozFrsZR9klhxgTnDEvxPKFWmNR43wXHOO7KCfUY7kPXBSpZ5vrmXUr@lists.infradead.org
X-Gm-Message-State: AOJu0Yw19OCDa2/8pKA8r4gCKo3McnV+fgBN8Of0aLwLDMwvmtYVv9j3
	FdaA/HZEvfHwz2sqFbyRIi/aUK9t4rNk+mWgTE5AvzELtBeHzSAlISk+
X-Gm-Gg: ASbGnctrAwjy+ItKyXoPR6qzpqCO59577I0pXAdu/ZXODDa60y7inQ0HveGtXJTHgN3
	YPu9OuTFb5pE5pj71Q3mGxDgZqNN6NFXli/cHkPiCe3MyUAwEQrPw5/9+zlxUcq4P9JaixETwOS
	TPlqt+BIf9R7qcRq64j1k3CWT2H4RzYRSMkcWw6XXjp7hb0nqv3SwmkX/wYhcPYH8iecECPDaDv
	wqIozhIDu9SygK4Yka5gQkVeE0OkZ/3tiI/Y0ZiPdrYYDxrSzuUTuGw8L0HsIhyF75bOoc5gVr8
	LNSOQURGyE49J+0RrKbQkB4H6VPfINWghlTeS20k3gr4to7/tRd9gW56bOfSDr1YzbHE3iFvxJq
	eIrIu8xzKITOBF5QUZEyYB3pDzp14tmQM3pw8h/1HWnNPihSntfzCYOXi8tpvgepi55yvT24g4T
	skFlt4zrxA77tcFcpFzYtBo5uZHohItQ1Fp8mNxWtc
X-Google-Smtp-Source: AGHT+IHFcMhBja4n2pTa6kCLJ1ksY6klziEgnAzgM8SGkFMwvlZ7k+Q/k77fP6Y8+80MsuaX1xhg/Q==
X-Received: by 2002:a05:6000:615:b0:429:8b01:c093 with SMTP id ffacd0b85a97d-42e0f213973mr24183487f8f.15.1764544183787;
        Sun, 30 Nov 2025 15:09:43 -0800 (PST)
Received: from [10.100.102.74] (89-138-71-2.bb.netvision.net.il. [89.138.71.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1c5d613esm23095484f8f.11.2025.11.30.15.09.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Nov 2025 15:09:43 -0800 (PST)
Message-ID: <16fb8b14-6a70-4046-8771-a5c0fa867ce4@grimberg.me>
Date: Mon, 1 Dec 2025 01:09:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] nvme: expose active quirks in sysfs
To: Maurizio Lombardi <mlombard@redhat.com>, kbusch@kernel.org
Cc: mlombard@bsdbackstore.eu, bgurney@redhat.com, bvanassche@acm.org,
 linux-nvme@lists.infradead.org
References: <20251103144406.1148401-1-mlombard@redhat.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20251103144406.1148401-1-mlombard@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251130_150945_768315_BC00BF7B 
X-CRM114-Status: GOOD (  16.91  )
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



On 03/11/2025 16:44, Maurizio Lombardi wrote:
> Currently, there is no straightforward way for a user to inspect
> which quirks are active for a given device from userspace.
>
> Add a new "quirks" sysfs attribute to the nvme controller device.
>
> Reading this file will display a human-readable list
> of all active quirks, with each quirk name on a new line.
> If no quirks are active, it will display "none".
>
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> ---
>
> V2: Do not expose kernel-internal constants to userspace.
>      Move the quirks attribute to the controller device, where it belongs.
>
>   drivers/nvme/host/nvme.h  | 54 +++++++++++++++++++++++++++++++++++++++
>   drivers/nvme/host/sysfs.c | 23 +++++++++++++++++
>   2 files changed, 77 insertions(+)
>
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 102fae6a231c..647f19dd57e9 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -180,6 +180,60 @@ enum nvme_quirks {
>   	NVME_QUIRK_DMAPOOL_ALIGN_512		= (1 << 22),
>   };
>   
> +static inline char *nvme_quirk_name(enum nvme_quirks q)
> +{
> +	switch (q) {
> +	case NVME_QUIRK_STRIPE_SIZE:
> +		return "stripe_size";
> +	case NVME_QUIRK_IDENTIFY_CNS:
> +		return "identify_cns";
> +	case NVME_QUIRK_DEALLOCATE_ZEROES:
> +		return "deallocate_zeroes";
> +	case NVME_QUIRK_DELAY_BEFORE_CHK_RDY:
> +		return "delay_before_chk_rdy";
> +	case NVME_QUIRK_NO_APST:
> +		return "no_apst";
> +	case NVME_QUIRK_NO_DEEPEST_PS:
> +		return "no_deepest_ps";
> +	case NVME_QUIRK_QDEPTH_ONE:
> +		return "qdepth_one";
> +	case NVME_QUIRK_MEDIUM_PRIO_SQ:
> +		return "medium_prio_sq";
> +	case NVME_QUIRK_IGNORE_DEV_SUBNQN:
> +		return "ignore_dev_subnqn";
> +	case NVME_QUIRK_DISABLE_WRITE_ZEROES:
> +		return "disable_write_zeroes";
> +	case NVME_QUIRK_SIMPLE_SUSPEND:
> +		return "simple_suspend";
> +	case NVME_QUIRK_SINGLE_VECTOR:
> +		return "single_vector";
> +	case NVME_QUIRK_128_BYTES_SQES:
> +		return "128_bytes_sqes";
> +	case NVME_QUIRK_SHARED_TAGS:
> +		return "shared_tags";
> +	case NVME_QUIRK_NO_TEMP_THRESH_CHANGE:
> +		return "no_temp_thresh_change";
> +	case NVME_QUIRK_NO_NS_DESC_LIST:
> +		return "no_ns_desc_list";
> +	case NVME_QUIRK_DMA_ADDRESS_BITS_48:
> +		return "dma_address_bits_48";
> +	case NVME_QUIRK_SKIP_CID_GEN:
> +		return "skip_cid_gen";
> +	case NVME_QUIRK_BOGUS_NID:
> +		return "bogus_nid";
> +	case NVME_QUIRK_NO_SECONDARY_TEMP_THRESH:
> +		return "no_secondary_temp_thresh";
> +	case NVME_QUIRK_FORCE_NO_SIMPLE_SUSPEND:
> +		return "force_no_simple_suspend";
> +	case NVME_QUIRK_BROKEN_MSI:
> +		return "broken_msi";
> +	case NVME_QUIRK_DMAPOOL_ALIGN_512:
> +		return "dmapool_align_512";
> +	}
> +
> +	return "unknown";

How about simply print the value/bit in this case?

Other than that, looks fine,
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>


