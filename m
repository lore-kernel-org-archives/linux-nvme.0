Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 744D7C3ABA6
	for <linux-nvme@archiver.kernel.org>; Sun, 15 Sep 2024 20:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8bFpdsxfx1Ace/q4aasi99xOr7vx0867TrczqjNMxQY=; b=KyKBRahI0dN5KaK/lngXrGEW9R
	B/NF0UqCKbwuiPELdTIEn4a5/Ss2x9Dewc1lQ6o7Mh+mDSkWLM0SrqzoAQGwqR4BmXJG7QOlxNbpf
	eTHmpOvecODR9eCtoqsmeFLBhobcsCIOe0DLS69F8KsSU+fHQ9V3YeQDW61/cGfMaW30CgkG0LUcx
	V3oi8APNyrepCD/YT/0jCVq/Ro04hjrZJ3dUoFlqpQhv+C6WAwpxIofXlhQ4q3+Jag7o9AExTVTYl
	igHWJBqs9CxoCZ5SEJl5s2V5Pmv6is20aEJ5pn8V+kbpW/EYVLL3Y36lrH5jvrakxvabH9oWZXVm7
	BaWodYdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1spvvG-00000002dHZ-18DP;
	Sun, 15 Sep 2024 20:32:42 +0000
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1spvv8-00000002dH8-3qqU
	for linux-nvme@lists.infradead.org;
	Sun, 15 Sep 2024 20:32:36 +0000
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-205659dc63aso36995595ad.1
        for <linux-nvme@lists.infradead.org>; Sun, 15 Sep 2024 13:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1726432354; x=1727037154; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8bFpdsxfx1Ace/q4aasi99xOr7vx0867TrczqjNMxQY=;
        b=IcsF9OPoH6Zx8rEb3zZ3FbTjbIGbccuG6M4WL4S6XtmUaJ6YbX4WwUC9JSv6ilwqW0
         qSMlVAENWUiMYjhSpqI4N+s40XBYFeU/4sCiVUNp6cPqWKgmRIK6rqA1YqeKj6eHz/i3
         YgjJfS1LfFpDScFbD8aSUUtjmlh//R6nUmk+hDn9mozMR92LIu47WriunQ7YJK9bJoe0
         3ixEkDBMIDgPiuL6lwjskUVklx4frOMq0iP1yR0JsHzzRQ7g8dd78V+tpXIGnCHPDs7r
         CdO7pvjb8P81k8jlhren/KaU6PiuYzZ7R0ZFPVoLDSMwhWPzMxng27eY6sTWLmwQEWu7
         m0eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726432354; x=1727037154;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8bFpdsxfx1Ace/q4aasi99xOr7vx0867TrczqjNMxQY=;
        b=RBBDJps8NiKDXjxeFAWhQku1hPRTjqRhl6DN7qsSnKyUDTxi4J1VhmOikBpbRBYDyX
         mM2x0wVe3l3M0ljD6R1V8/iHykjCg/JKm/yuZ2CATl6gFpGkEpdFiIYQkteYgtxisQuW
         6rA85ZBZcV9J+XZi8ZeI4WKbIkMRQbnxLG2eQ5b2zZmVdBIlww89iSzKBINnWDPRc7aC
         kwgEsgmOF2Aw3HWmSrrVOsA5+XdaNCOGxdRp7pHCLjDTpdf8UGRyXMC/BCXKs+X3S8wF
         ZKlC6lrXAq0fiST2S1IllBkAXzZ45r2OE/2UCe6H3A690CcKrAMlXPoajg8Hh7ueabQb
         JNbw==
X-Forwarded-Encrypted: i=1; AJvYcCX/pYNRlwdmlZdxk7CxqVN4t+xIluwiAivQygSw0IGja2axkYDDPTszPastxETXRljasht6W1JBBk+H@lists.infradead.org
X-Gm-Message-State: AOJu0Yy5wiqFNtLy8LIbIbXeC43Xfmt+2w9z7ipyO7KDUPOLBIZYGHqC
	4U5lvoGbIEYeHK0pOaE2Dgdg9RkyaA8QruZHvOowtclAdwXU3LmDtaaBg98sFXY=
X-Google-Smtp-Source: AGHT+IFqzpuwo8+eE5vUuJR+DujfLNGM59YFl+GDSbrA+peia+5jh6zgtexzrlgiRgj766UReKE8nQ==
X-Received: by 2002:a17:902:d2d2:b0:205:8a1a:53eb with SMTP id d9443c01a7336-2076e39c2e4mr194842025ad.18.1726432353601;
        Sun, 15 Sep 2024 13:32:33 -0700 (PDT)
Received: from [172.16.7.106] ([63.78.52.170])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dbb9c3f57esm5730249a91.8.2024.09.15.13.32.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Sep 2024 13:32:32 -0700 (PDT)
Message-ID: <0bd0be63-5595-4aae-829f-6b278a5b5e60@kernel.dk>
Date: Sun, 15 Sep 2024 14:32:30 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] blk-mq: introduce blk_mq_hctx_map_queues
To: Bjorn Helgaas <helgaas@kernel.org>, Daniel Wagner <wagi@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 virtualization@lists.linux.dev, linux-scsi@vger.kernel.org,
 megaraidlinux.pdl@broadcom.com, mpi3mr-linuxdrv.pdl@broadcom.com,
 MPT-FusionLinux.pdl@broadcom.com, storagedev@microchip.com,
 linux-nvme@lists.infradead.org, Daniel Wagner <dwagner@suse.de>,
 20240912-do-not-overwrite-pci-mapping-v1-1-85724b6cec49@suse.de,
 Ming Lei <ming.lei@redhat.com>
References: <20240913162654.GA713813@bhelgaas>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240913162654.GA713813@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240915_133235_201004_5BD04C39 
X-CRM114-Status: GOOD (  22.15  )
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

On 9/13/24 10:26 AM, Bjorn Helgaas wrote:
> On Fri, Sep 13, 2024 at 09:41:59AM +0200, Daniel Wagner wrote:
>> From: Ming Lei <ming.lei@redhat.com>
>>
>> blk_mq_pci_map_queues and blk_mq_virtio_map_queues will create a CPU to
>> hardware queue mapping based on affinity information. These two
>> function share code which only differs on how the affinity information
>> is retrieved. Also there is the hisi_sas which open codes the same loop.
>>
>> Thus introduce a new helper function for creating these mappings which
>> takes an callback function for fetching the affinity mask. Also
>> introduce common helper function for PCI and virtio devices to retrieve
>> affinity masks.
> 
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index e3a49f66982d..84f9c16b813b 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -6370,6 +6370,26 @@ int pci_set_vga_state(struct pci_dev *dev, bool decode,
>>  	return 0;
>>  }
>>  
>> +#ifdef CONFIG_BLK_MQ_PCI
>> +/**
>> + * pci_get_blk_mq_affinity - get affinity mask queue mapping for PCI device
>> + * @dev_data:	Pointer to struct pci_dev.
>> + * @offset:	Offset to use for the pci irq vector
>> + * @queue:	Queue index
>> + *
>> + * This function returns for a queue the affinity mask for a PCI device.
>> + * It is usually used as callback for blk_mq_hctx_map_queues().
>> + */
>> +const struct cpumask *pci_get_blk_mq_affinity(void *dev_data, int offset,
>> +					      int queue)
>> +{
>> +	struct pci_dev *pdev = dev_data;
>> +
>> +	return pci_irq_get_affinity(pdev, offset + queue);
>> +}
>> +EXPORT_SYMBOL_GPL(pci_get_blk_mq_affinity);
>> +#endif
> 
> IMO this doesn't really fit well in drivers/pci since it doesn't add
> any PCI-specific knowledge or require any PCI core internals, and the
> parameters are blk-specific.  I don't object to the code, but it seems
> like it could go somewhere in block/?

Probably not a bad idea.

Unrelated to that topic, but Daniel, all your email gets marked as spam.
I didn't see your series before this reply. This has been common
recently for people that haven't kept up with kernel.org changes, please
check for smtp changes there.

-- 
Jens Axboe

