Return-Path: <SRS0=kA5W=CC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C1CC433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Aug 2020 08:26:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79D8420738
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Aug 2020 08:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gIzn14sd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79D8420738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=gIzn14sdoA4WHR4Cee0cGoSbj
	G46kVbHdlJLoUbM/nTDlpbONa/F1vsEWbtSva7QYamfl7PmsspY/U9yA1guqA5OgZKF5BxbAOQUbU
	N8GaLTaZVAuUIGWiCvJejRIlMviFiTEeWnoAKh3SqYNSCp9IlK2oG/3Z3PxjHpVz/gXpRf2dIeG0y
	v5yNqGr8aRznNR88ScA3R/XwUSXB9yHE+AWYBVr+SRAdygewandioXSWsOWVW/+yo34NbF31M10sp
	BKXT9m0GrKlB3XvhkGCe6OrH5GvF+Uae5yxXk+k2rq8qoEFAgWiWpZEOo5oY8fTDMSwgczBX5UzYg
	yrOtqTo/w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kA7nq-000879-2K; Mon, 24 Aug 2020 08:26:06 +0000
Received: from mail-pl1-f195.google.com ([209.85.214.195])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kA7nm-00086C-Sp
 for linux-nvme@lists.infradead.org; Mon, 24 Aug 2020 08:26:03 +0000
Received: by mail-pl1-f195.google.com with SMTP id h2so3880351plr.0
 for <linux-nvme@lists.infradead.org>; Mon, 24 Aug 2020 01:26:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=N3CGN42z/P1tsm5tTO7SFPqVHSaJNyUI+RhVMVkLSjWOSIJQXIEO7618LdoOrRz0y6
 uwNkg1UM07tLnWphQ2cyXKudRRLV83Uhab9kh0WBic2awgMrc8OBcUYKWe5ULoYAoDtr
 8xoMFp3mZAttgchMdMPhWw0Vt+h5f/lyKTUHz8anFTrkFbVBwXlZFBNyMlmmzMB0DjmO
 JlvpOjKkCE5O+URNnEtIHT+aByrDiT7NQe/EMw9rPWEvG0ahZoQ8M2AH4L1tNpZQwGwB
 eLGtQ+tdg9cg2zbAiYPXsKePURyOWZr6FF18os3fIXCCSkXYE0BTVKd/ZsaBBIFX5mgL
 Rn+w==
X-Gm-Message-State: AOAM531hQqx0KIdZ0wQFUsLoyyT8PKp0Lie/ozwhKHx/rS9VSKTK84FX
 0hClr+i1Ja6lwoOBSMDo2gOOMk2DhMDcwg==
X-Google-Smtp-Source: ABdhPJxW0Sb1W31ji1xD5/tXnfUfq/0hDyEu38/TERhsoxJVdj23q3MPeALuQr+JGwJy3gfWJGZhFA==
X-Received: by 2002:a17:902:748c:: with SMTP id
 h12mr3050709pll.316.1598257560600; 
 Mon, 24 Aug 2020 01:26:00 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:cda6:bf68:c972:645d?
 ([2601:647:4802:9070:cda6:bf68:c972:645d])
 by smtp.gmail.com with ESMTPSA id j5sm10776991pfg.80.2020.08.24.01.25.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Aug 2020 01:26:00 -0700 (PDT)
Subject: Re: [PATCH 1/3] block: replace bd_set_size with bd_set_nr_sectors
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
References: <20200823091043.2600261-1-hch@lst.de>
 <20200823091043.2600261-2-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f31bb1a9-2f2c-2002-c7ce-29aa43feeafb@grimberg.me>
Date: Mon, 24 Aug 2020 01:25:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200823091043.2600261-2-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200824_042602_988401_F816E407 
X-CRM114-Status: GOOD (  11.01  )
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
Cc: linux-s390@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
 Justin Sanders <justin@coraid.com>, Hannes Reinecke <hare@suse.de>,
 Josef Bacik <josef@toxicpanda.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, dm-devel@redhat.com,
 Xianting Tian <xianting_tian@126.com>, nbd@other.debian.org,
 Stefan Haberland <sth@linux.ibm.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
