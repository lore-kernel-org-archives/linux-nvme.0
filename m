Return-Path: <SRS0=wRjJ=FE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96345C64E7B
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Nov 2020 18:55:18 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BFFB20725
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Nov 2020 18:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VuTwUzNw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="IxPlmO7G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BFFB20725
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=h56Vr8kpEKEGHHG9ZvpjBpDL7iwz9hmP5TchbnnqQag=; b=VuTwUzNw0gvRR0dVKZ+HghhZw
	KN7DlgFMvZr4ruua0gfYQP/VyAlOGSgg6oaYyhPOpXGiOtozFWQLSNSk+e+c0dRzMQrMR2dKPLiZG
	jNvxhmLNYLf0TkgjNCYjkPcSTPMx6vvmYebmqGKpdPVipHDOcrkVeiz8tKUJq+rNCPWEG+BLMaXCz
	XZaJApxRiDoEUwG7oOmAbbPOAulJq1pvjIPAnjderYJMq7wvpvijtFw41lu9GHCS5AoJZfY+wYuC+
	ZlQ3mxSQ9ZRSMmk4b0u4jVu0H/10RqWNtXQNvJXSXXYSFLWmHomiohYwgx7YndDugkqspaOP5j/L6
	y41K7I+Gw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kjoKO-0006kz-Ta; Mon, 30 Nov 2020 18:55:12 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kjoKJ-0006iA-GE
 for linux-nvme@lists.infradead.org; Mon, 30 Nov 2020 18:55:09 +0000
Received: by mail-pf1-x441.google.com with SMTP id s21so10984568pfu.13
 for <linux-nvme@lists.infradead.org>; Mon, 30 Nov 2020 10:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=0Vx4/FiJNN1SrwnDdCOvxazqKVfbLGSmLYwYBmUjLLI=;
 b=IxPlmO7GPxYk8jDbcom3XunGu65QwSmt67V98TljR9QJZexOLAyVEbotoWLPxsrS6m
 Dnq4QqjuXfLwKLMPfQs5c0wc/yCAbtCPwg7+uZR8pWHxjz/UNzO83Wm9CTpjQCvc/ALO
 eeBB7PtJ4TOJiaoTkkxJbZJG37q+I2/zROTPluZYwiMWX5XlQHsZjhkxbhatEdCXeeOQ
 8ohdclWfKHv8Xyf5/vXUEAl82Pk6EY87ASvTSZz/HDxWZeUT4H/YVxM0D7XeP1yWANcl
 excDDyuHPC6zb63K46lD5AerDoL6LsmeKOzg1r1mk3jPC+E++eEUbBwrvwhRI6dGwzIQ
 FxyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=0Vx4/FiJNN1SrwnDdCOvxazqKVfbLGSmLYwYBmUjLLI=;
 b=E3AQuRI4uxnietYIcBmh5gl5n5wKcd5fknvwcomQSgW8CBYN1ty4AhBbv7ePkXRKbx
 lS2naXqYC2tgiCZT0NGPgU4fqV9mAGTWSwHMMfekzVJvFIX9OfSWyVcSJXa5iumdGMvB
 wLE/syMN6F142vtar6gVHhQjFUA5CUQ1D7rcU+0wToQ4y82uehTs3fT/e8dVL9JhS1KV
 wikBhGRay6+WIWpTbVnBHgbrPOvdXx1pdtsrxdcfM89mJVx0h3fS9B9jNJoQUnWMId9s
 ElUxfMV8xBlHWq+M2wgMyIE914EcOt2fYC6FTt66tGWHHpjhJQ5bmmvI9YqhIjDrsn3+
 9gKQ==
X-Gm-Message-State: AOAM530u7KQUGyPmjC9IQGtl46vER8E771n2g3yoVYmA8WedAeeR0EcR
 7eGDxKtK3opwH+icXxWhw3R3Cw==
X-Google-Smtp-Source: ABdhPJxvA2ew/N0+nPbOex6g0qlEJ0rB2I0BryChaExqkZ1KtBtIRREOiPSAA3kirWXgTAnEpD69ng==
X-Received: by 2002:a65:68cd:: with SMTP id k13mr8988005pgt.115.1606762504810; 
 Mon, 30 Nov 2020 10:55:04 -0800 (PST)
Received: from google.com ([2620:0:1008:11:7220:84ff:fe09:dc21])
 by smtp.gmail.com with ESMTPSA id p127sm17718569pfp.93.2020.11.30.10.55.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Nov 2020 10:55:03 -0800 (PST)
Date: Mon, 30 Nov 2020 10:55:00 -0800
From: Tom Roeder <tmroeder@google.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v2] nvme: Cache DMA descriptors to prevent corruption.
Message-ID: <20201130185500.GB744128@google.com>
References: <20201120012738.2953282-1-tmroeder@google.com>
 <20201120080243.GA20463@lst.de>
 <20201120142954.GC2855047@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201120142954.GC2855047@dhcp-10-100-145-180.wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201130_135507_639264_C10E9C9D 
X-CRM114-Status: GOOD (  22.20  )
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

On Fri, Nov 20, 2020 at 06:29:54AM -0800, Keith Busch wrote:
>On Fri, Nov 20, 2020 at 09:02:43AM +0100, Christoph Hellwig wrote:
>> On Thu, Nov 19, 2020 at 05:27:37PM -0800, Tom Roeder wrote:
>> > This patch changes the NVMe PCI implementation to cache host_mem_descs
>> > in non-DMA memory instead of depending on descriptors stored in DMA
>> > memory. This change is needed under the malicious-hypervisor threat
>> > model assumed by the AMD SEV and Intel TDX architectures, which encrypt
>> > guest memory to make it unreadable. Some versions of these architectures
>> > also make it cryptographically hard to modify guest memory without
>> > detection.
>>
>> I don't think this is a useful threat model, and I've not seen a
>> discussion on lkml where we had any discussion on this kind of threat
>> model either.
>>
>> Before you start sending patches that regress optimizations in various
>> drivers (and there will be lots with this model) we need to have a
>> broader discussion first.
>>
>> And HMB support, which is for low-end consumer devices that are usually
>> not directly assigned to VMs aren't a good starting point for this.
>
>Yeah, while doing this for HMB isn't really a performance concern, this
>method for chaining SGL/PRP lists would be.

I see that this answers a question I just asked in my reply to the 
previous message. Sorry about that. Can you please point me to the code 
in question?

>
>And perhaps more importantly, the proposed mitigation only lets the
>guest silently carry on from such an attack while the device is surely
>corrupting something. I think we'd rather free the wrong address since
>that may at least eventually raise an error.

 From a security perspective, I'd rather not free the wrong address, 
since that could lead to an attack on the guest (use-after-free). But I 
agree with the concern about fixing the problem silently. Maybe this 
code should instead raise an error itself in this case after comparing 
the cached values with the values stored in the DMA memory?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
