Return-Path: <SRS0=Qryz=E2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2256AC388F9
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2020 01:10:03 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9656322254
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2020 01:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GCILC+MF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="E3GJkkDU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9656322254
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=u4aIBGKfXKllS3u8rmbMvFvnUVTnbCn79lm/Emn6050=; b=GCILC+MFkLa9vHc6oUEHlbw0p
	KkaNj7WoylL0/d6ejKUEWwI5oXfy0exwQAE1ammfzkGw0ZBP7EzSiTHfJo74BLQXhDk+O3NapygaE
	lh/y9ei0yJEDRdApBQ69+vOT1RMgtg2suabaj/SFmSLn8vqhwApMYkNIvBIhDsZMFutlvV5aCJGhH
	V5mXl11/eOimsMg1yUJvBu7vcbRvLwBi9sD1gJOCi5P+WpqgOxBOD1/L74Hjpq/5/RcDRDGs0064X
	94GqI4PJibICzfTT5lqNcTf2whnvhbEGZ2s7N7wYQ8wodJ7hnubiXY7T5aRdqdY9ndE9H1TfaoJT3
	b617UuO/g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kfuvz-000096-4X; Fri, 20 Nov 2020 01:09:55 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kfuvu-000079-Bi
 for linux-nvme@lists.infradead.org; Fri, 20 Nov 2020 01:09:51 +0000
Received: by mail-pf1-x444.google.com with SMTP id c66so6254824pfa.4
 for <linux-nvme@lists.infradead.org>; Thu, 19 Nov 2020 17:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=4K9iPhC4qNk/Rh7UFJxvkVuXYE1ScmXCx5XNoAoo/BE=;
 b=E3GJkkDUqRZcXOyddzcINghpgvYz14dVycTO5GBG/X8xKxQGkdk61gAfgNosA+BnrD
 DhtJQ6e8tMom+YYPIqk23Jw5SqIoZz7vdbzFyFT8RisdczKdIb4GfLoPhR+AbER0ZlHS
 IR3i5nest+Wdeh8ILGUPy6OlF2IeMsx79P/E+cMqDxO1spMZbJf+lVvHyvtmPwWPLYem
 UgMxICwkAvDt0epg4fjoojKXIZq9f8fvoXbIyX/KS6gopdru9Do6qv5y6i8XApp9KoU7
 5FeGwEbL6MZF4XVusM+xWmuIeUtjsRjEPYWl4HVr4KjjXKMLM1B0Qxcu9HsMurpfBDfv
 nLAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=4K9iPhC4qNk/Rh7UFJxvkVuXYE1ScmXCx5XNoAoo/BE=;
 b=EqxgY8aspl3gSynIQbr6j4cEm1z5nMwsd2UswomcZ4BQy0t1jZV74Xj0oT+pzD4M+E
 ep4lThqa/Gv9pLF1AolyzHMVWAlgpCMSZNemFQaLD4ltR4SmQEuD5QUONIGu09dod5Zy
 J3zJLYdoue99aEzVSOOSYFUcAUPnFexouB55vzWAgfwjOEBGrwPkmjSVC+Ap49lmrWVs
 6Z6a0GjNrhvEEdZJbWv88K4OhSdTQtJNj6RgyVFkR0l/BqCISr0f+xxXfpUvk3/5X42j
 NBjdEtXtvBhvJsVrksrQwVsFHDJNTaUQIkvRUV4lk421Dwpv1Pr92e1KmOtxEwdi5uCq
 y0NA==
X-Gm-Message-State: AOAM532Q4NLasfQLMVWuS28VVW3RhppO76uk6yM2Qs2Gu6k9B/CnaYOF
 ZD+LhmoRU5XPJx50Uo844MRIBQ==
X-Google-Smtp-Source: ABdhPJwlQHuDk/3sbVsTxG6I9t/kxU4uJxWjz9B0da63wH9QjC6ZNPQcfMtvS2PlHQFuu0Guz2jJXg==
X-Received: by 2002:a17:90a:4802:: with SMTP id
 a2mr7781069pjh.22.1605834585766; 
 Thu, 19 Nov 2020 17:09:45 -0800 (PST)
Received: from google.com ([2620:0:1008:11:7220:84ff:fe09:dc21])
 by smtp.gmail.com with ESMTPSA id c193sm1206226pfb.78.2020.11.19.17.09.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2020 17:09:44 -0800 (PST)
Date: Thu, 19 Nov 2020 17:09:40 -0800
From: Tom Roeder <tmroeder@google.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: Cache DMA descriptors to prevent corruption.
Message-ID: <20201120010940.GA2943603@google.com>
References: <20201119185919.2742954-1-tmroeder@google.com>
 <20201119210914.GB2855047@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201119210914.GB2855047@dhcp-10-100-145-180.wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201119_200950_524822_568592A7 
X-CRM114-Status: GOOD (  24.13  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Marios Pomonis <pomonis@google.com>,
 Jens Axboe <axboe@fb.com>, Peter Gonda <pgonda@google.com>,
 Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Nov 19, 2020 at 01:09:14PM -0800, Keith Busch wrote:
>On Thu, Nov 19, 2020 at 10:59:19AM -0800, Tom Roeder wrote:
>> This patch changes the NVMe PCI implementation to cache host_mem_descs
>> in non-DMA memory instead of depending on descriptors stored in DMA
>> memory. This change is needed under the malicious-hypervisor threat
>> model assumed by the AMD SEV and Intel TDX architectures, which encrypt
>> guest memory to make it unreadable. Some versions of these architectures
>> also make it cryptographically hard to modify guest memory without
>> detection.
>>
>> On these architectures, Linux generally leaves DMA memory unencrypted so
>> that devices can still communicate directly with the kernel: DMA memory
>> remains readable to and modifiable by devices. This means that this
>> memory is also accessible to a hypervisor.
>>
>> However, this means that a malicious hypervisor could modify the addr or
>> size fields of descriptors and cause the NVMe driver to call
>> dma_free_attrs on arbitrary addresses or on the right addresses but with
>> the wrong size. To prevent this attack, this commit changes the code to
>> cache those descriptors in non-DMA memory and to use the cached values
>> when freeing the memory they describe.
>
>If the hypervisor does that, then the device may use the wrong
>addresses, too. I guess you can't do anything about that from the
>driver, though.
I agree; I don't think there's anything the driver can do about that.

>
>> +	/* Cache the host_mem_descs in non-DMA memory so a malicious hypervisor
>> +	 * can't change them.
>> +	 */
>> +	struct nvme_host_mem_buf_desc *host_mem_descs_cache;
>>  	void **host_mem_desc_bufs;
>
>This is never seen by an nvme device, so no need for an nvme specific
>type here. You can use arch native types.

Thanks! I'll change the type to a new struct that has the addr and size 
fields as native integers and send out a v2 for this patch that makes 
that change and cleans up a couple of minor style issues in my code.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
