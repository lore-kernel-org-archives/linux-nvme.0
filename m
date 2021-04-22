Return-Path: <SRS0=aHbv=JT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F3A9C433ED
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Apr 2021 23:30:10 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADF2E61417
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Apr 2021 23:30:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADF2E61417
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=mPFbl1VaHz/PUv2kCZrJicIdoqBWVy8vGdELH0yYVmY=; b=MWpMV+dshx3/d1plOCN/gNEdx
	00+V9P+bTWGqhYQxNtSVzib9NUxc96fmikrAReZ0UAoMbLzCcW8T6aJByLqLj45RHlPe6Vg2eET+R
	Bw06OGtIutUV4dH/Qhg8eDfouqzV0QOWAXApbBTILlXSaYJwhq2kLPif9Nxm2LBOvD8UubdQ2Iw43
	tflVR4K/1caSUMhgNgEVBiod+9tvy0WSv9BmyoHsgL7R3z8v0aPl/kXKNf+78HUzPPbJ1NQBCwM8J
	TWVzmqivBgXsW+6LOhxcC77xfHGTxl8cTLPEg8kTWY0FAMs4FErM7pN/TE3JK2ejkS74RDCljk+3V
	NLLM7atRA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lZilD-0006QX-6S; Thu, 22 Apr 2021 23:29:30 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZil2-0006QK-MJ
 for linux-nvme@desiato.infradead.org; Thu, 22 Apr 2021 23:29:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=4TtuWRmxd6c7tO7/d2Lj8r80VpNylQlJV6QO2aOBW0E=; b=v7zye+Xr7n9B9tn2bAoUp82WzR
 NIipGbX4pFwjZrlpx/XMg5kXZCxCGMcHw3kPMcT2q0ZdjIoo2MG39xKf0StqsrBiABbsRIJ7bpDkN
 eIvZMyDHlqDc0ZTABbpw0u3q4EDXKIW7B4eim3iGq0o5N1MOXyv0kDDscaJa1qObVLWda3J4iQIbB
 DBiTTemS5+PcsyMylKj0Rtnxs1eq6TinPILctgLdgx9/hdm1tYspG/7r8PpznCuhTRwQAZr2ZRedD
 qS4zzlPH8DI/KIlJ6thIMyloU5e3zHxrdU14E6O5O2u9/VmAx+5VNnxORiOC0gX+YTm6wJUk7RAjW
 EhsqUDzA==;
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZikz-00E2Tn-SG
 for linux-nvme@lists.infradead.org; Thu, 22 Apr 2021 23:29:15 +0000
Received: by mail-pj1-x1031.google.com with SMTP id
 gq23-20020a17090b1057b0290151869af68bso194574pjb.4
 for <linux-nvme@lists.infradead.org>; Thu, 22 Apr 2021 16:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=4TtuWRmxd6c7tO7/d2Lj8r80VpNylQlJV6QO2aOBW0E=;
 b=Ls6iOdIHabkazicNCeXQk+1LCdwk/s34fk1+ormyK5yAjiHdDoGMjuEvUzbtaiDxZR
 ojYPu50Ip9tkQjZoD2wwm/mEpYivWZjEv5FYASMuTCCvk6egMXV9eX888lP5wVt3aBeS
 PRQQrSorYTX5bcZaTkyQjG/SwlF9k6mbpHZ1p8muLXPYkjdZtJTwkZw38YBLXimNjbQE
 DCTONXGJ9xKwosXy6+6oRHJpDHeAEtFbco84Ix99ZsSfAS54J4L4hVBnyVJyqgnNcm63
 Q6T2AISvr9Bz+W5kq+vXeLaDtFlrcRON3bhX6n87XxU8sRrjhvpuw7uUv7rsHezncbJB
 c0Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4TtuWRmxd6c7tO7/d2Lj8r80VpNylQlJV6QO2aOBW0E=;
 b=rT1xpJj8qSe+h4p9dfXckBwMr0NtVRg5dojPSKmvuX9/h8iubM2Y4RWXIjamJsbgDU
 2KN/rlPtEzfKZa2uZhzEF0OWB+vqveeoi9iobzjsodvlFK5Ct7VDksiIoTvM2NiHAiLX
 racbJPILuemC3SyDYysf+Hp63dUjEj0SGvYya12g3WG2rJzHPo0+SxIUDhmALyFPkkv0
 AokidR3aM6J4Wm5shiycQ6suS4cngqx6rkSE1LWsoTNsKFtksZT0HR99WzWrhU3e9jNs
 Vj/rmZ2bSFVCo5NS7T1OBSOJX7A7QY9rIBl0dswsBJenOA4yZmc6Ww7+DsrP6wCL9O+0
 hKBg==
X-Gm-Message-State: AOAM533Et5dyYvEkxzWjlXHT6obaCZ6QBmee/37+BvMhm4AqVRuqpddB
 xaD7F/sg6nTcfnVtPPlc2JM=
X-Google-Smtp-Source: ABdhPJxwPM6t5pY9h03M0se/Wvu4DzAp47uOVtizRJfg5yRIzdI7rmVoAl+6rtTyYGcjGctLUxqHHg==
X-Received: by 2002:a17:90b:a0d:: with SMTP id
 gg13mr1256054pjb.124.1619134152150; 
 Thu, 22 Apr 2021 16:29:12 -0700 (PDT)
Received: from [10.230.185.151] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id 25sm3357917pgx.72.2021.04.22.16.29.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Apr 2021 16:29:11 -0700 (PDT)
Subject: Re: [PATCH v9 03/13] nvme: Added a newsysfs attribute appid_store
To: Benjamin Block <bblock@linux.ibm.com>,
 Muneendra Kumar M <muneendra.kumar@broadcom.com>
Cc: Benjamin Block <lkml@mageta.org>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, tj@kernel.org, linux-nvme@lists.infradead.org,
 hare@suse.de, emilne@redhat.com, mkumar@redhat.com,
 Steffen Maier <maier@linux.ibm.com>
References: <1617750397-26466-1-git-send-email-muneendra.kumar@broadcom.com>
 <1617750397-26466-4-git-send-email-muneendra.kumar@broadcom.com>
 <YHxRK33kf7OSVlxf@chlorum.ategam.org>
 <a6497bd924795a5a9279b893b0d83baf@mail.gmail.com>
 <YH62VB+SVfnG+GoI@t480-pf1aa2c2.linux.ibm.com>
From: James Smart <jsmart2021@gmail.com>
Message-ID: <2eec720b-401a-32b4-80e6-900e136939b3@gmail.com>
Date: Thu, 22 Apr 2021 16:29:10 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YH62VB+SVfnG+GoI@t480-pf1aa2c2.linux.ibm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210422_162913_966374_157025FA 
X-CRM114-Status: GOOD (  21.59  )
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

On 4/20/2021 4:09 AM, Benjamin Block wrote:
> On Tue, Apr 20, 2021 at 12:24:41PM +0530, Muneendra Kumar M wrote:
>> Hi Benjamin,
>>
>>>> ---
>>>>   drivers/nvme/host/fc.c | 73
>>>> +++++++++++++++++++++++++++++++++++++++++-
>>>>   1 file changed, 72 insertions(+), 1 deletion(-)
>>
>>> Hmm, I wonder why only NVMe-FC? Or is this just for the moment? We also
>>> have the FC transport class for SCSI; I assume this could feed the same
>>> IDs into the LLDs.
>>
>> At present it supports only for SCSI-FC .
> 
> It does? By adding it to the implementation under `drivers/nvme/host/`?
> I am confused.

Yeah, this is a little odd.

This history is: we know we need to merge the scsi fc transport and the 
nvme fc transport as the two independent things are creating 
difficulties and duplications (devloss is an example). But it's a bit of 
work to change this as it will move where the objects are in the 
topology tree.

As we tried to figure out how to do the interaction with cgroups, we 
wanted to support SCSI and nvme. If you look at how this new attribute 
sets the vmid, it's somewhat generic - it just sets the fc appid field 
on a cgrp id.  There's really nothing that says the cgrp is on a block 
device that is scsi or is nvme.  It should work on devices regardless of 
their underlying protocol type. Which then left the question - where to 
place such an attribute.

Given this is an "fc service" and as we knew the transport will be 
merged eventually we picked to put it under /sys/class/fc point which is 
where we expect to root the common transport. This class point happens 
to be owned/created by the nvme fc host code for requesting nve-fc 
rediscovery events. It is odd that it creates a requirement to load the 
nvme-fc transport in order to set values for scsi fc devices, but we 
deemed it acceptable.  Guess we need to get going on that merged 
transport...

-- james



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
