Return-Path: <SRS0=NjBy=W6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 423FBC3A5A2
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Sep 2019 19:22:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 137642077B
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Sep 2019 19:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="I3xd9+8h";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="voEl1xim"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 137642077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=z0qwgHpSXB7yEZlm429y5mD0trk1sTHx3ok0zoG348c=; b=I3xd9+8hHwFAP4
	FeStPnjtxhdBp/yAotXoc5rsA9ZvpU7IvRSQLk2zRPifWkqDiICgmJJGXapckhbUems2HAUqOd8bG
	zrUAhNTF3Dks39Im2jklaHnNRq+3eaqSr1v3fVBacwPp5uFlu5RigE45VEduZdjFb+oSzhRe+wqiN
	LUxjwV3lnEBAA5pqESrnOuU2QVRQiRm2GNibx25eC0sefX6sUsFoaQ95CGQrLvO4c6zoAH8wV2kUR
	IKzSJ7yQK5DusVqrMmJ1M2xXWJxez9n7cxPcM5yhhjDamPChD0Vjn94JZ+o+eoYUDX3LYjjOdsv3q
	5CSXi7HwRZm25PxnUVFg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i5ENS-0007Yx-0f; Tue, 03 Sep 2019 19:22:06 +0000
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i5ENP-0007YN-48
 for linux-nvme@lists.infradead.org; Tue, 03 Sep 2019 19:22:04 +0000
Received: by mail-io1-xd41.google.com with SMTP id b10so38631877ioj.2
 for <linux-nvme@lists.infradead.org>; Tue, 03 Sep 2019 12:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=29dtAFPf34LxGH/UUfzYlaG1O5dS7BXSw9jlWp67F8c=;
 b=voEl1ximKls/CHflGcztyqprJBz4GJWnF0D9iQrARetjSUY5FM8m65i3q5k3tbQWQ7
 Yj2s+fKyQle47M78dVTd4avxZcIGVNxEZvlfKUPf/zbvuro4G3mTEfJNXHeG0wF1VXrI
 RjEtncz1zhWQwN3m1ah3oWfp67udechQZOV9XX4AxpvTvLrd8uaAyQD+gCHpJkRPDjRf
 xn+ptBl2YqBWF8COlppdc2taHxz3dT6K4ZVvVSmSHqZ+ZhwhPQbT/YMePjt2IcLrmmoy
 MiAlNNV2jg1Hm9ZXhDMH1xfRC0JV8/YLBqKlYAU99/nk1Xt9TE5w8hWTV+rLv1idTxgH
 aoag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=29dtAFPf34LxGH/UUfzYlaG1O5dS7BXSw9jlWp67F8c=;
 b=J1+oG92TeKxNXCvwWdnwV1Ic4aQOASArCNLYVv/GOxBaswfY91uU9RvR2uPuNfYDRQ
 mwCopJD+PPHiOoPGFUb7O/BFiThTLFQ+cl7ePlKJcQiLzvd3ugEwhmX34qcDnlNpSB8V
 Yx8oQXwWgHJvO6S8g9fq/Ph9oMqz6ctBrLPbvjN+KU0NKKoh9p5YRvsaZ3SHEpOhH/Kw
 Z1UG0dszQXCFvMtGGf1X3ui0TBTV0GCU2CDotmXCT5RuHMR/YNIWooTn/Fdg4vL1VP1J
 1KvYmBXEp8ttArDO/zWWQHi4LeTRGr+Pto770ZeDAOtR6RuA2CE9jWrT8ehANBJiECqs
 i0lg==
X-Gm-Message-State: APjAAAW6KLYLQ/M685e9QlYGW3RVavJeKS9JpUuMX1sd2+ZP+ShvyLCa
 XLhjbi1DFswuCiQRxS3pYK6t2A==
X-Google-Smtp-Source: APXvYqzBMtMZ2ZLDWbSZL0p1Rzk8Q6xurNani/F3mC7VqI3TC/2Wga/K5TZsESkUAb0XIIkxdMiP7g==
X-Received: by 2002:a02:ab90:: with SMTP id t16mr4273892jan.110.1567538521476; 
 Tue, 03 Sep 2019 12:22:01 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
 by smtp.gmail.com with ESMTPSA id i62sm13973375ioa.4.2019.09.03.12.22.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 03 Sep 2019 12:22:00 -0700 (PDT)
Subject: Re: [PATCH 1/4] block: centrelize PI remapping logic to the block
 layer
To: Sagi Grimberg <sagi@grimberg.me>, Max Gurtovoy <maxg@mellanox.com>,
 linux-block@vger.kernel.org, martin.petersen@oracle.com,
 linux-nvme@lists.infradead.org, keith.busch@intel.com, hch@lst.de
References: <1567523655-23989-1-git-send-email-maxg@mellanox.com>
 <8df57b71-9404-904d-7abd-587942814039@grimberg.me>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <e9e36b41-f262-e825-15dc-aecadb44cf85@kernel.dk>
Date: Tue, 3 Sep 2019 13:21:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <8df57b71-9404-904d-7abd-587942814039@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190903_122203_231328_260605EF 
X-CRM114-Status: GOOD (  12.21  )
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
Cc: shlomin@mellanox.com, israelr@mellanox.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/3/19 1:11 PM, Sagi Grimberg wrote:
> 
>> +	if (blk_integrity_rq(req) && req_op(req) == REQ_OP_READ &&
>> +	    error == BLK_STS_OK)
>> +		t10_pi_complete(req,
>> +				nr_bytes / queue_logical_block_size(req->q));
>> +
> 
> div in this path? better to use  >> ilog2(block_size).
> 
> Also, would be better to have a wrapper in place like:
> 
> static inline unsigned short blk_integrity_interval(struct request *rq)
> {
> 	return queue_logical_block_size(rq->q);
> }

If it's a hot path thing that matters, I'd strongly suggest to add
a queue block size shift instead.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
