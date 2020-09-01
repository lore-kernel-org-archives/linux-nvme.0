Return-Path: <SRS0=Ap99=CK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9CF8C433E7
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Sep 2020 17:46:14 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 865BA207D3
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Sep 2020 17:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oiVJtS3L";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="cXlpMLt/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 865BA207D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=eRgwNkTAJ47OL9UBF8wM3RvbrS6SBfz4rLIE8yVv2ro=; b=oiVJtS3LTWiEMvMt87aILxqxj
	qUe+w5lMENGeLESOTuSfStke8yHbxKr84q2XU+GndXSVWswa9XotuTC2p6pm047gr3mb3tp59SMit
	bQU3BAOESgqjtiadsKEbdyJEm/dfmfPVKSqIMUbEnNW+Ic+9t5QqUOtFMfitV2JpAQ+XuaLceZRxe
	5KZFfetz3LRoStx0Y6HjAwki2PHnHl6pyWkkFiYDvXLCM5JMVeH5Qo3ggcBEYuuPFrpUTLrkvJF16
	4cVeV00NeO2xq4xLzGSEaOsmYQYPlxpD5+GwHiOVI8Xnd4oXZkKlCG3hFRCwzxQyDF0YjQlld14bh
	lSE8gYV4A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kDAMF-0001or-MV; Tue, 01 Sep 2020 17:46:11 +0000
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kDAM8-0001lj-Uo
 for linux-nvme@lists.infradead.org; Tue, 01 Sep 2020 17:46:09 +0000
Received: by mail-qk1-x731.google.com with SMTP id o5so1765003qke.12
 for <linux-nvme@lists.infradead.org>; Tue, 01 Sep 2020 10:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=cSy4+2RDeeEJIAWSQYiuQheGRdiGJb8NlbxFbBqq2AM=;
 b=cXlpMLt/MZjGGJxxIXI3dRVI4uswoqGbuubaqPQro5E+Vxlidjbo5VD4YxUte9yV9n
 JGggD9c+n5hNtPF04P2fLwYCnLrn2PjcBNJ2TPdvwxby+LqAdjuTStUJWwXWsv7+VmVM
 5mRh+XQTeS1ZkGcYpcS2I2jsA3aNfqqxESdch/Lfa1suLKFyKj7pL/q/CaFoZCr613vh
 nMtVSMocVtIEc52WDjqw2OvCz5cwb6gn8KIGuZiEbNTm8mwhjITdAQNlXSR/HEbhcE/I
 OWouCb9f0F3A8GvtPJWlYO2AuTtiExzS5h17AM3EKMSVIiqlJsvrIIghN+G9eZ0GdcD3
 223Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cSy4+2RDeeEJIAWSQYiuQheGRdiGJb8NlbxFbBqq2AM=;
 b=DTngNUh8u7OzxJ5RD8hajFvGqH3fHLslmVipbNVVwsJGb6dL7bpHxz5ZE9XnzGkv6I
 hBMt2eSby5D0dm0Pd/Y5v3nlzfYggnn8yHCLJM9PrZvtszqMSatuARGP5aSGbzXLlP5U
 ZVIS2dzPHxg7KxBTAPD3of+68hZPF9UaykVEDyy6BntSgAE/bkbd+2pB3pvrKHggbcNT
 rifmYR5APSBBl4mMbMJEqOK4KBiX6PSFfdLauTmyxgp9kEgbfMX5on1FySBd4Uwap8O6
 +DyRBmLoKvJ4QzG+QmaYh8Bc8phWSCe0S/DUgpXYjCWdnkug7DvedMJ9Sg5/F5XCmcVY
 X5sA==
X-Gm-Message-State: AOAM530qqGCFeLAe0BsJlXhDR+sUlQNUCZso4mHZVdr2boxixxjscWTt
 7J/a3ITTOkhCDzcZSEzXtFxfQg==
X-Google-Smtp-Source: ABdhPJzuyOEEW4u0szMWmuV8qaZb9/osteZ8Kxw8co7ysE17hCNMDWr3cE6A6fD+O8okSgr6GveAkA==
X-Received: by 2002:a37:2d07:: with SMTP id t7mr2973895qkh.255.1598982360401; 
 Tue, 01 Sep 2020 10:46:00 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com.
 [174.109.172.136])
 by smtp.gmail.com with ESMTPSA id w20sm2217486qki.108.2020.09.01.10.45.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2020 10:45:59 -0700 (PDT)
Subject: Re: remove revalidate_disk()
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
References: <20200901155748.2884-1-hch@lst.de>
From: Josef Bacik <josef@toxicpanda.com>
Message-ID: <b89fe35d-cdf9-e652-2016-599d67bdc5eb@toxicpanda.com>
Date: Tue, 1 Sep 2020 13:45:58 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200901155748.2884-1-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200901_134605_004399_C4F3D87D 
X-CRM114-Status: GOOD (  18.79  )
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
Cc: linux-raid@vger.kernel.org, linux-scsi@vger.kernel.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>, linux-nvdimm@lists.01.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 nbd@other.debian.org, linux-block@vger.kernel.org, dm-devel@redhat.com,
 linux-fsdevel@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
 virtualization@lists.linux-foundation.org, ceph-devel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/1/20 11:57 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series removes the revalidate_disk() function, which has been a
> really odd duck in the last years.  The prime reason why most people
> use it is because it propagates a size change from the gendisk to
> the block_device structure.  But it also calls into the rather ill
> defined ->revalidate_disk method which is rather useless for the
> callers.  So this adds a new helper to just propagate the size, and
> cleans up all kinds of mess around this area.  Follow on patches
> will eventuall kill of ->revalidate_disk entirely, but ther are a lot
> more patches needed for that.
> 

I applied and built everything on Jens's for-next, patch #2 was fuzzy but it 
applied.

I checked through everything, the only thing that was strange to me is not 
calling revalidate_disk_size() in nvdimm, but since it's during attach you point 
out it doesn't matter.  You can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

To the series, thanks,

Josef

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
