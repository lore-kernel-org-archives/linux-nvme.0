Return-Path: <SRS0=WpAz=AF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5E3C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 06:54:43 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 084C72072E
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 06:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="n/4pg5mn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 084C72072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=KEACNr4e+qXLtlLhTE2nJYSgpPkHhxG1gqPHbjFQwe0=; b=n/4pg5mnzqG+8HTLlIjPkO1s0
	3Vw5MuHdIdiGlUfdxLuwFj3RE1+lcJLSieoag8R5LEV1ZO1btxIbwnBBznerwoYYLXDWakSECOb+2
	GpWzzfYU5edawcQ5LTWdkpPUR9o8lsEBUVbCWwOvHo9nKys4/E/N1uAuAnkfOfM4qb7crH9UKWd8s
	lrcMcOqURduFIMsp/AEOZ7gYw8RucTW4peZh9nzwglqX70C4ULT85HI7LnwjtSv5GLjtbUeOgg/OB
	z/jzUhl3NOiG0NbbU2dAZVJNKqcn7z1jVYmp0Z10kb9nXhbNcQwaeYmLpSje0xAvYZ9obWTi89hrO
	7XPaAKBKQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jnzIv-0008VZ-3w; Wed, 24 Jun 2020 06:54:41 +0000
Received: from mail-pg1-f196.google.com ([209.85.215.196])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jnzIr-0008U0-3m
 for linux-nvme@lists.infradead.org; Wed, 24 Jun 2020 06:54:38 +0000
Received: by mail-pg1-f196.google.com with SMTP id g67so65162pgc.8
 for <linux-nvme@lists.infradead.org>; Tue, 23 Jun 2020 23:54:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ow3sDPSF+j1ScccaPKrnBDbwIOb/rwqj+XevptBhpZA=;
 b=HAX1JXeBC4tOuFlYiYJuo8ZwyOfQZtV6FpR9MWRI3ik0Qipnrif4wJnkzdoGSUOLeM
 SJZnDzhusXUjsrLqgaHSkabHD3s9YWJirKxO4u1wfk5bKa2f3HiijMjNoBK4KnM5dxIT
 JVruxF2f4p3r69MkN0LqbtaKzCd6Caqv4KEWxV0lL+Ohd8cyJLDNWVmz2MpbVQtb0zqX
 s7sFyZG+D9KOxOUn7YEdMm0bi84esgUbsEDDqttbeDbdjrhr+RiG29n6tu/SFX9eSgRo
 z/sSF9j5XxzrqoyDvH2uJTC/UxH5jLUtFvFz2v5IdBkyj3mPjS9dW0+QHjf40LsUeKyf
 AXOg==
X-Gm-Message-State: AOAM5316GWcRCev95hmpjsivemTxV4ldG/gLvuOmwihQ0LqEEJ1sJ8KS
 sXhQvXFNvBYZtLlhxk9JXCz2Gct4
X-Google-Smtp-Source: ABdhPJyNsbzE/B3x45Sfg52Q5VxU2dPJkFWfYVI6mejJzLx/i+/N5uaGJWliuJx/xfF9u0OV5NZs7g==
X-Received: by 2002:a63:dc50:: with SMTP id f16mr19469916pgj.19.1592981675867; 
 Tue, 23 Jun 2020 23:54:35 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:9915:87a9:9728:63e?
 ([2601:647:4802:9070:9915:87a9:9728:63e])
 by smtp.gmail.com with ESMTPSA id e78sm19070292pfh.50.2020.06.23.23.54.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2020 23:54:35 -0700 (PDT)
Subject: Re: [PATCH v2 for-5.8-rc 1/6] nvme: fix possible deadlock when I/O is
 blocked
To: Christoph Hellwig <hch@lst.de>
References: <20200624001853.5408-1-sagi@grimberg.me>
 <20200624001853.5408-2-sagi@grimberg.me> <20200624062902.GA17594@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <84583b2e-d59b-01bc-1737-5db107999d84@grimberg.me>
Date: Tue, 23 Jun 2020 23:54:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200624062902.GA17594@lst.de>
Content-Language: en-US
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
Cc: Keith Busch <kbusch@kernel.org>, Anton Eidelman <anton@lightbitslabs.com>,
 linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> Revert fab7772bfbcf ("nvme-multipath: revalidate nvme_ns_head gendisk
>> in nvme_validate_ns")
>>
>> When adding a new namespace to the head disk (via nvme_mpath_set_live)
>> we will see partition scan which triggers I/O on the mpath device node.
>> This process will usually be triggered from the scan_work which holds
>> the scan_lock. If I/O blocks (if we got ana change currently have only
>> available paths but none are accessible) this can deadlock on the head
>> disk bd_mutex as both partition scan I/O takes it, and head disk revalidation
>> takes it to check for resize (also triggered from scan_work on a different
>> path). See trace [1].
>>
>> This is no longer needed since commit cb224c3af4df ("nvme: Convert to
>> use set_capacity_revalidate_and_notify") which already updates resize
>> info without unnecessarily revalidating the disk.
> 
> Did you look if any other revalidation gets skipped this way? E.g.
> LBA size change?
> 
>  From purely the size POV this looks good, though.

The only reason the revalidate was added was to update on a size change,
which is redundant.

And if you look at revalidate, it only calls fops->revalidate_disk
(which is a noop in the mpath device) and checks the size change.

If you find this explanation sufficient, I'd love your Reviewed-by
tag ;)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
