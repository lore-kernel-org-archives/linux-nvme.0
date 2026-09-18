Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8D92C982D8
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2026 23:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dATcnoYMonNxmEj8m95cM7akpILvaBmnE82ibKmB9T0=; b=dJdk2N1Egf1RtCrWJ+T6N5Lg/b
	pE+r7x4jF8vPMuV/HaQom5fBbqXIixSgUCUTOQwjXJJWMndVz1xqUux+mrJavyvfZsdhRvOqdbG7o
	if88PWaxwKeXCJ0KueXVaPzbvkq/ValwiTOM3EAaHAplVWQPUrmrVvNGSsB4yMZhk4thjcuwN7Ls/
	btO7iBe++Y5P5qBTpBlSk7QnJzeNMFxFod0fP6dTSQ/qWArsAgk81/6IQISngANyHudcbdqqX1CiP
	GuT0B9LfRQ3j6cUcZgNRVnau4nnYmGqfzIKO8JVQJwwuJZufSC9u0ZareCLIG0Y8gJvcvmxMAM0GZ
	z2VTf1QQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7hqg-0000000FgvB-0D0s;
	Fri, 18 Sep 2026 23:18:30 +0000
Received: from mail-pj2-x0f.google.com ([2607:f8b0:4864:39::f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7hqY-0000000Fgup-1WPR
	for linux-nvme@lists.infradead.org;
	Fri, 18 Sep 2026 23:18:23 +0000
Received: by mail-pj2-x0f.google.com with SMTP id 98e67ed59e1d1-39b9184fa80so1286142a91.2
        for <linux-nvme@lists.infradead.org>; Fri, 18 Sep 2026 16:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1789773501; x=1790378301; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dATcnoYMonNxmEj8m95cM7akpILvaBmnE82ibKmB9T0=;
        b=MBjJr7eFSKUIBVVjujbMBzxHCKSMcVjGn8yL7OsFgm9drTAZE7tN0GlujgAmsLL3Ah
         8pxGKdbpd6+WUHbziGeMu34tV4Iknt8sVMrOvvnk7lNf7Mg9h7ohTl2GrgwWBJMSkqHQ
         sWAmdSjSMxoi9mxC/BCmIfW6I3ov6nLrzYFEtF1HD05+ceU3odemShszFmlPZ8ZAZhU2
         uos0UOB37DSSw/3r++ZAMjqYHEEXCM+W+De3myy0BLshe2z2gCv1uA3XAiZyW1zOk7L3
         w2oKe2p9B2qjbGLcakrHL7GtI0fB67ZF85ppGSIn1NROt6WhgVMpT88tZSLdHEzDoDF/
         m83g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789773501; x=1790378301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dATcnoYMonNxmEj8m95cM7akpILvaBmnE82ibKmB9T0=;
        b=xefHex5CAzsN6Ms+jCTVz1zSk6NLP3R3RK6PgUL0nbj7Z6a179lbhqZiRArfrooSd7
         EsNndHf7eR6TwfBZIOr9kiBxRHppYiuR+Nsq1XFhuOjQIfmlo576G4zDef2YJQdXXrPq
         bGkHAw9rS/S+oz9/DYLhCLWfz49Raat3IvSUJ5XDK7GemXxsAUz+Ty+3N7YJrMYggpQz
         wwipY0MzPW6P0v7OeC5DV0UbJ8Zxa898wt/u0/3AsGruKErOiC+KMBndht0/lf7iQb8k
         jg3KiueOLm9Pj5nM5xK9iA/xtFnlpKIPsmmKU5mBbnX4hj6AB2ZjSfJ/niPn7Ql45uZW
         G0yg==
X-Forwarded-Encrypted: i=1; AKwUvBwX6tCel9RqQSeFy2dTgcjAG5cbws+Kk8l4MWtovdY0tRSkx9+4hL7KKDXQCoyCRS7INEoZvu27rKLS@lists.infradead.org
X-Gm-Message-State: AFuF++kKZDH4ElwglWXKr9kbHqlsXh4J+AfioQ9pfyB60ecx9hvHWj7g
	/N4vR/rgTdcFbBt/tAGCnvePh4ZxRE0OagFPgKPhOMGE0PTp4foFvr/rEl8TQiOOf4g=
X-Gm-Gg: AYBFou2KjZzYipQUYhOgteZEfLWZd4cX8LC9MY3sRyJAsJNNXiBmEua/7v6aJLMnX+8
	ztOk2iGi6H1q6QuP4K4izK4f+l6CybkwSfJDx9cV4GP0ZvVpBl4f6s4x/8HAgs9DMoxq7Nb3z8d
	6X+bCEbAZnVMFjomS4pezpvAVZ9i++xmTaSt3ooYw2ToUbieBhOL9v4QkzAWSzQbUGu/jqCD9jw
	E9B9xnqGuG7v1Pdc9gkR+Ci5LJOzsuPo9cMdqZE7jIJ0W/QsZBPWnS+1skLzHv+W3f8bL5VLzcf
	VMl6rGt1sl6RwwydGD0i9m4ndor8nOxZkwJlvSJk1qblPrM3/GIysHd/yqu33eFWiCgvc96h1cR
	QPfzf6585/ogftE5uvFID6QZI6oUW9njnEgPvO5jwiUMvh+MLGWhq+V/oudSuldubmSNoI4lhTs
	WfsFG4I9FlUMtsSeQe3yt02WOD/PKIhxfT+UdfLHCMoInDzyfWXL+fp8NxyBG+aN9Sd0EA942Jl
	ihv0EhojNUFYZS2e6OU4x4sbUnAxEIO+Q==
X-Received: by 2002:a17:90b:3bcb:b0:38e:bbf1:de3f with SMTP id 98e67ed59e1d1-39e54eab3e6mr14592787a91.12.1789773501145;
        Fri, 18 Sep 2026 16:18:21 -0700 (PDT)
Received: from MBP-Krishna-Iyer.civet-hops.ts.net ([4.7.95.218])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144d55e8954sm2274358c88.14.2026.09.18.16.18.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 18 Sep 2026 16:18:20 -0700 (PDT)
From: Krishna Iyer <kiyer@crusoe.ai>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Krishna Iyer <kiyer@crusoe.ai>,
	linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@kernel.dk>,
	SeongJae Park <sj@kernel.org>,
	Saravanan D <saravanand@crusoe.ai>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nvme-multipath: add fail_if_no_path sysfs attribute
Date: Fri, 18 Sep 2026 16:18:18 -0700
Message-ID: <20260918231818.42832-1-kiyer@crusoe.ai>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <7b9e6dc8-6d44-4bfa-9c3c-9e51a5ba643f@linux.ibm.com>
References: <20260917231647.79956-1-kiyer@crusoe.ai> <7b9e6dc8-6d44-4bfa-9c3c-9e51a5ba643f@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260918_161822_427634_EDB8FF73 
X-CRM114-Status: GOOD (  13.77  )
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

On 9/18/26 1:58 AM, Nilay Shroff wrote:
>>   		switch (nvme_ctrl_state(ns->ctrl)) {
>>   		case NVME_CTRL_LIVE:
>> +			if (fail_if_no_path &&
>> +			    (ns->ana_state == NVME_ANA_INACCESSIBLE ||
>> +			     ns->ana_state == NVME_ANA_PERSISTENT_LOSS))
>> +				continue;
> I think we have helper nvme_state_is_live() which could be used here.

Will use it in v3. One note: !nvme_state_is_live() alone would also
cover NVME_ANA_CHANGE, which v2 deliberately keeps queueing since it
is transient and bounded by ANATT. So I'll keep an explicit
NVME_ANA_CHANGE check alongside the helper:

		if (fail_if_no_path &&
		    !nvme_state_is_live(ns->ana_state) &&
		    ns->ana_state != NVME_ANA_CHANGE)
			continue;

This also means moving nvme_state_is_live() above
nvme_available_path().

>> +	if (enable)
>> +		set_bit(NVME_NSHEAD_FAIL_IF_NO_PATH, &head->flags);
>> +	else
>> +		clear_bit(NVME_NSHEAD_FAIL_IF_NO_PATH, &head->flags);
> If the user stores the same value as the current setting, we could
> return immediately instead of waiting for synchronize_srcu() and
> scheduling the requeue work.

Good point, will fix in v3 using test_and_set_bit()/
test_and_clear_bit() and returning early when the value is unchanged.

> Otherwise changes look good.

Thanks for the review! I'll send v3 addressing both in the next few
days.

Thanks,
Krishna

