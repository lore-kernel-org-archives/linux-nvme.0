Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAFA7C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 19 May 2022 15:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T1HTtaBWsbeoUH6k1biDoIiy86pTLKDgc4Vb5950guc=; b=w+ojPlfCK63+eEbGCejFF7BHoE
	bBAG+zbZNVtxvVgVILKiMxmcCnLQjj0EG635HNkHM095r5ZarOmgoNBB7Lm/issVjPb5RHPRUrej2
	AdY08P2BKoaeVkHmcE4dZGfUzebvZsZ4UMbJejErKyloPKf+MEEZ/GQI6sD4mj53jjBpQyFeiTSvd
	cb6imyHkXket5JVVunorN55scq0VfpzzqQFsoXa+CA4kbqjRFBdTrtlmjQwqeQOIuHnAs+WC6lxHf
	v6V9/PWzGeDt23PMT+wUf15S2gpHEfv1BCGqDz0hMQoEVsxH3mrcCD+kP36wSYv5FEY94COon0uFQ
	Sn5uRi0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrhv4-007rj8-Nf; Thu, 19 May 2022 15:18:30 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrhbO-007eYR-DP
 for linux-nvme@bombadil.infradead.org; Thu, 19 May 2022 14:58:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
 :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=T1HTtaBWsbeoUH6k1biDoIiy86pTLKDgc4Vb5950guc=; b=Tk1A0o8YhNuvkGPYEAzrlGzMwN
 uCnsS1do2T73jQ+hw7eez1BNRRZyCdI2cxEYVRTFVAQ3D5jAZcnJLBE93oZvk5MSvg/aY/TJ20uwB
 zWCqSOxSxprM+IiTWuB+fmg+bYbwutcZAQCsxxcRK22gvt1ZMH+tOWbCHYKmOp9J9/cW5mEKfEJ5v
 SFg5cQ3YIxqZM3dObqcPMs7mg3fKGDhow4ywPJWF97LCuSoAR+CXDoqCE2rMzrxv/KBG28B/QweaD
 nw5WKSthZ+GvIoGmhIscoznqj5psvzSWf0hw++0UyetR3HhobK/vt7noNBu231GUP+c2vggF/u+Ir
 kIFTxzdw==;
Received: from mail-io1-xd35.google.com ([2607:f8b0:4864:20::d35])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrhbH-0023bZ-VV
 for linux-nvme@lists.infradead.org; Thu, 19 May 2022 14:58:07 +0000
Received: by mail-io1-xd35.google.com with SMTP id a10so6020626ioe.9
 for <linux-nvme@lists.infradead.org>; Thu, 19 May 2022 07:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=T1HTtaBWsbeoUH6k1biDoIiy86pTLKDgc4Vb5950guc=;
 b=aqlhhmf0XcwVhCOLIoSM5gOFq9mwD5Cex0twLmG85/ZIdhHn++iG7/MTq7TrDyJfDZ
 lSf+lLpGVkg01G+euyz/PwHMTverhxG1jNMqFwM8w6eVr85Ov0I55ohHcp4U/Dnfd+Gp
 7JlW7DuGPRObM+Cl+BbU/hXWlIHaYuwM0W20R7Y/dl5DlEpVgUoowlblZ3F1RxugjmBy
 mPjlbRIPaV00xBfw7LdWbx7SdhCnQXJghL3k9t0TEU7Zfiw/dGHr2Mzf08I1OABwCO0E
 U0z2QAwTxLcgxqX0t2Wm3I68t0PfFVPZY6jOiromfQtx8Xb0Df/OlN9LzkqaOySKboiu
 eqVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=T1HTtaBWsbeoUH6k1biDoIiy86pTLKDgc4Vb5950guc=;
 b=AC4MRzyrsz9ZNPnGYB+PW0GGCQu6nZFUkji5vrzFTAAVaFgsH8u8p2iYQC8t/f/Enk
 XCwn8cDzh6zWKU9Z2K1hHGcRWLq4uyn43GlcYUM0hi1OpP/88dMEaZNqw3x766CVf6vn
 TrjVquKB/+V1dNRFgWVUptHowH5cK7Z+E2ES9QDreikYKSDyQ6cZFIMLH2fq4dUcXjin
 GG3srm5jjG+aWu3L4b7UvLYz4R7WdZpPj7sxlfplOHiusOSTxKWlnJwPl8pGDOMlFWzT
 lu846y8jW7JdWEqEoKxG9OTBxgqHCMB3HrLQM1cL1nIiMcB7Q3z7EoGZs92IxvRiEP9l
 jT3g==
X-Gm-Message-State: AOAM531zi+lwzT/tfczUSNz1PIIhd67MmSzq5Hjb7A6hY/IbNfAmtnFs
 LMvFuiAl5WQbIIieC43l/BMCQsXvB/Z1Cg==
X-Google-Smtp-Source: ABdhPJxBwbitopVhO0+bUUUKGrOmSS6xhLHdmNyA3Q0WGCIaS6Hszyg4+nUy425DUlRtVZRaT+4PLg==
X-Received: by 2002:a05:6638:411d:b0:32b:7465:fee2 with SMTP id
 ay29-20020a056638411d00b0032b7465fee2mr3145530jab.318.1652972275705; 
 Thu, 19 May 2022 07:57:55 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
 by smtp.gmail.com with ESMTPSA id
 g8-20020a05660203c800b0065a47e16f64sm776198iov.54.2022.05.19.07.57.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 May 2022 07:57:55 -0700 (PDT)
Message-ID: <be88c0b4-ddc6-c851-c160-a929adc1e433@kernel.dk>
Date: Thu, 19 May 2022 08:57:53 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] nvme-fc: mask out blkcg_get_fc_appid() if
 BLK_CGROUP_FC_APPID is not set
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Muneendra <muneendra.kumar@broadcom.com>, James Smart <jsmart2021@gmail.com>
References: <20220519144555.22197-1-hare@suse.de>
 <84a7c290-5e75-3e24-0674-7b51dcafa2eb@kernel.dk>
 <0b33e180-9e23-f737-3c93-5b5b13a7ded2@suse.de>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <0b33e180-9e23-f737-3c93-5b5b13a7ded2@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220519_155805_080420_08EED0F0 
X-CRM114-Status: GOOD (  16.04  )
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

On 5/19/22 8:55 AM, Hannes Reinecke wrote:
> On 5/19/22 07:50, Jens Axboe wrote:
>> On 5/19/22 8:45 AM, Hannes Reinecke wrote:
>>> If BLK_CGROUP_FC_APPID is not configured the symbol blkcg_get_fc_appid()
>>> is undefined, so it needs to be masked out.
>>>
>>> This patch is just a diff to the v2 patchset, as the original version has
>>> already been merged.
>>>
>>> Fixes: 980a0e068d14 ("scsi: nvme-fc: Add new routine nvme_fc_io_getuuid()")
>>
>> Either this sha is wrong too, or it's not in my tree yet the breakage is.
>>
> Picked up from linux-next.
> Which tree should I look at?

I'm assuming that commit is from the scsi tree? It's certainly not in
mine. So your commit message may be correct, but since it was sent to me,
I was assuming it's breakage from my tree. Which doesn't appear to be the
case, and I don't see any of the SCSI maintainers on the to/cc.

-- 
Jens Axboe


