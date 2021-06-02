Return-Path: <SRS0=uBfD=K4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9C4C47092
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Jun 2021 12:24:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75133613B8
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Jun 2021 12:24:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75133613B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:Subject:
	From:References:Cc:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xKl5N/c8zkJZDV0TVJycgJGO5QzF3kPvqh8RIOUX3b0=; b=xzg1p7uc46djaEp7mke08WcrtU
	1XAVvBHZTeXbVXa2YwOxX7l7uloLZKL1WtIAFiYdvyy7OhPaUltqoYHKbeQpMp2Z2nMSC6fqDmi6T
	ih9bFrjuqNbzeqX4dVaLK3j2lBRHXw/YP942+bFjaUAJDNxll7NjlxSVWJaqJmstMoZuFaHBO+END
	8gilo3hlZ16h6qAFpaOPo9cTLRpUCDtuBeoFBeSbNKkjaATH2n7j8hADBEqeHsUWXSUF8oxjB/qa2
	ylU9Re42mQgNGCBEmw7mKtUJQuj0ptmVASFEctV2bXd4ia6Fm1MIXo81iTOvhKi7HlgLYThUS7qx1
	INv3PI4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1loPvG-00424V-R3; Wed, 02 Jun 2021 12:24:34 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1loPgH-003v0B-70
 for linux-nvme@lists.infradead.org; Wed, 02 Jun 2021 12:09:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622635742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nb53P46lpq0QHGo0Ib5PtqvuzN+E2xnIwefsTEFefR4=;
 b=YVEnaN7pz5MIcgoQ42l7Z+rpRf8UdFrdrrg3jJ1zqJixPRRZ26lYgH/4PenyLXL7DFrYi6
 08IiWhTZfuZ/nJcz7oQ35ufsomGxFHmFaw7bdybx5V9Vs0iuuilDajlCd4GdnCzSjFKBw8
 n79S6/fl2UNKYt4l3w7iy06SjE3SCg4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-PB5N9-mGMt2DROW6hbZ4iA-1; Wed, 02 Jun 2021 08:09:01 -0400
X-MC-Unique: PB5N9-mGMt2DROW6hbZ4iA-1
Received: by mail-wr1-f70.google.com with SMTP id
 x10-20020adfc18a0000b029010d83c83f2aso927353wre.8
 for <linux-nvme@lists.infradead.org>; Wed, 02 Jun 2021 05:09:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:references:from:organization:subject
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=Nb53P46lpq0QHGo0Ib5PtqvuzN+E2xnIwefsTEFefR4=;
 b=YPzJrgvP7UN/DBXlDNcHfSeLd2xCgbtq9sRwAMZzMInhoBeMMwd8oFNh7fjrJnR8sY
 zMRog5QGG+WZWf7fZ/nYvoL/p/EPfVbLdqI6dkz5FsRXh4R63fH34nZP4zLmFfQXz9HA
 jzyBL9FXIGzOUCZQKUhze0eK+UXV60HpsQ34vDyLd9W0ZaocVpOSvBBKdw6uvBRFROu6
 Q7JFDsKSWBQQIek/TUfgE+PV4xS2ZLqXGBgN/cFYWL+CITDVVc8jQ1PDryrVfMY9smVr
 P7ncdbXWRl7+mtJiRtgNZIlSz+Hcgqq3tujrCe7U9NFzz2HeAfpHzb/Vw8pgCAqB81HW
 vaCQ==
X-Gm-Message-State: AOAM5302IwAy5yII0/OHbbIWpp+muvVxnQRKfqG3x02QUWrbJ0IHKZOY
 y3RNe6sWb3V61rGD+/CV1/81peMHsJ54z5bDpgU34Eo7kekTcIJM+e+XuUFPTYuCXfAxfrBW0Ri
 t7GC7EGrMz/Ro6E7Sw6OUhojo1kA=
X-Received: by 2002:adf:d234:: with SMTP id k20mr33218106wrh.82.1622635740031; 
 Wed, 02 Jun 2021 05:09:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw58MA37jWfpzppDICXUB5EciUs4Xfx1MQed0fuQQQTrtlSOtPVp01wAzA/eKdOSmZhmGEK2A==
X-Received: by 2002:adf:d234:: with SMTP id k20mr33218076wrh.82.1622635739813; 
 Wed, 02 Jun 2021 05:08:59 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6b6d.dip0.t-ipconnect.de. [91.12.107.109])
 by smtp.gmail.com with ESMTPSA id n10sm7466284wre.95.2021.06.02.05.08.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jun 2021 05:08:59 -0700 (PDT)
To: Max Gurtovoy <mgurtovoy@nvidia.com>, linux-nvme@lists.infradead.org,
 dan.j.williams@intel.com, logang@deltatee.com, linux-mm@kvack.org, hch@lst.de
Cc: sagi@grimberg.me, oren@nvidia.com, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org
References: <20210602111055.10480-1-mgurtovoy@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH 0/3] PCI/P2PMEM: introduce pci_p2pdma_align_size API
Message-ID: <4bbb0934-384a-533f-b964-6b3695719b25@redhat.com>
Date: Wed, 2 Jun 2021 14:08:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210602111055.10480-1-mgurtovoy@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210602_050905_391704_792DB142 
X-CRM114-Status: GOOD (  15.94  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 02.06.21 13:10, Max Gurtovoy wrote:
> Hi all,
> In hotplugged memory (from check_pfn_span function):
> "
> Disallow all operations smaller than a sub-section and only
> allow operations smaller than a section for
> SPARSEMEM_VMEMMAP. Note that check_hotplug_memory_range()
> enforces a larger memory_block_size_bytes() granularity for
> memory that will be marked online, so this check should only
> fire for direct arch_{add,remove}_memory() users outside of
> add_memory_resource()
> "
> 
> This restriction will disqualify, for example, large NVMe CMBs that might have
> non power of 2 number of pages (e.g. 32767 pages of 4KB). For these
> devices, the CMB size will be rounded down from 0x7fff000 to 0x7e00000
> but it's better than having un-mapped CMB.

Just some high-level questions:

A CMB is just a PCI BAR used for communicating with the device, to be 
mapped into physical address space, right? I assume the relevant hotplug 
code is:

drivers/pci/p2pdma.c:   addr = devm_memremap_pages(&pdev->dev, pgmap);

correct?


Having a BAR span such weird sizes will most probably never be fully 
supported. But if sub-sections work for you, great.



-- 
Thanks,

David / dhildenb


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
