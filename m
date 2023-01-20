Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2C84C05027
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Jan 2023 16:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G/R9KZW2ypRwSFYmNL3DdGEYqt1RnjYffMb7JhYlSXM=; b=ZaoeID9tb/Li0b7VGV4+P9HqHB
	3mcZHd9Z+Juaia9juZ8yaMbL6QmwaTv1AtKle91AO5Pxw9zOJsfrvwJGyI1fIp5oz4Cfb95TLnyO/
	1h9RuwewCj8wajgJcdOQrn1BQvTgZl9Dd1GHuhFlxPSvfQls2nsAezTLLu41oGZOAL4Gzapd4Oien
	SqzAQ4RwCl5NnhVCOKVg3lkWz+yLG2kyBCAilpc8dmLdKpNrQqFrtzAoTdsFjN3Ekg4F+hjvEHdf5
	5R1uSYF/rHXmubzmmgInIfE/HHf6I62h0uCmwphxwXDeNsacumpuUM/NMU29Jo24ZmBBIQF9oDBT6
	NMbz3usg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pIu3w-00BBbJ-66; Fri, 20 Jan 2023 16:16:20 +0000
Received: from mail-io1-xd2f.google.com ([2607:f8b0:4864:20::d2f])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pIt15-00Av5C-Oj
	for linux-nvme@lists.infradead.org; Fri, 20 Jan 2023 15:09:21 +0000
Received: by mail-io1-xd2f.google.com with SMTP id s26so2552820ioa.11
        for <linux-nvme@lists.infradead.org>; Fri, 20 Jan 2023 07:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G/R9KZW2ypRwSFYmNL3DdGEYqt1RnjYffMb7JhYlSXM=;
        b=UfMaYiIiaMMe9NQYNKdvlcBwHZjsGmkTJkAw2JgQxng/BX3fP7aJ+Z2hEhKuS9rvUs
         57CvIFeWZYRAKV+EFOVGICIGM8syssDzylE9hvwO9FWsSSGYkv7nCDLss6GcNm2SK/eK
         O36O7CWmUvYR29RB5c728FcWs6ikE0OZ8HnWgXqfPDgysK40Pk5XXa5edK5L3+f/V9ld
         THbBqzyqJ625SoWFlP4QbH+wLAQ/tDGaA5yPc3wCMQl/rnQLHr1YMSiHsdNc6Yu+78l0
         yWr+6vTRXY+UQdRwlrdpAA+rjA6CKpWvPH5APyLadwAuMVqQlN7Ziiv3f6pjGdl6jOag
         ghTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G/R9KZW2ypRwSFYmNL3DdGEYqt1RnjYffMb7JhYlSXM=;
        b=l7LvzJFWIVQ5qzMFg3NeuHpF1mIVj0BLd1lhPwM4zHdeWzz4uwRtgKLepSgXbVWYVa
         mUcNawRFl7Iao5aH7+i5uhv3kWSGfLv3fEI+MbAB7v6EGVlWFbP0vA9Z4SppV+DNdMpX
         O+qPtwMWUKdlGF8jVi9VO2uMWESYdW57sfUEbstzA/Q+C+cq1MjxJ+5Xa6zrEZzcFtCm
         Gsv7FeyTGesPCszM6P5dzG1Zop5w7Yt6ZXlMVacbXcQyhCApn5livVPb09tVj4/Y6AiH
         mrPI7C4zzH51IKW4SYY8OBrJ/9bxZS6AuMMWIMig7c0Qt+6XbOqrBsdJPbOTeAdjuhwu
         CDrw==
X-Gm-Message-State: AFqh2ko++nMd22YKj5a3IRXBOQqDCCdRIhEahhF1FAfw/xcZi+5ZEBf6
	NpcogeI4Yq4oYYpX6mONAhUntg==
X-Google-Smtp-Source: AMrXdXsQblyHcEqK/fT04ILN7rk3rYlA4Hz3TToRbe+MU5lipN5BkyBWLq5KUz0L4UNQ/vmjbYWIXA==
X-Received: by 2002:a5d:9482:0:b0:6cc:8b29:9a73 with SMTP id v2-20020a5d9482000000b006cc8b299a73mr1897192ioj.1.1674227356776;
        Fri, 20 Jan 2023 07:09:16 -0800 (PST)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id i13-20020a0566022c8d00b00704d3db650bsm3050076iow.46.2023.01.20.07.09.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jan 2023 07:09:16 -0800 (PST)
Message-ID: <1cdd9e67-c62f-6c41-1308-5dab525e56e6@kernel.dk>
Date: Fri, 20 Jan 2023 08:09:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [GIT PULL] nvme fixes for Linux 6.2
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <Y8osKhxLSgeKMrSj@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y8osKhxLSgeKMrSj@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230120_070919_840981_B466A02C 
X-CRM114-Status: UNSURE (   9.63  )
X-CRM114-Notice: Please train this message.
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

On 1/19/23 10:52 PM, Christoph Hellwig wrote:
> The following changes since commit 7746564793978fe2f43b18a302b22dca0ad3a0e8:
> 
>   block: fix hctx checks for batch allocation (2023-01-17 09:56:52 -0700)
> 
> are available in the Git repository at:
> 
>   ssh://git.infradead.org/var/lib/git/nvme.git tags/nvme-6.2-2023-01-20

You really need to fix your script, I used:

git://git.infradead.org/nvme

as per usual (with that tag).

Pulled, thanks.

-- 
Jens Axboe



