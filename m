Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB945C7EE31
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Jun 2025 13:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uC0OiGu+HpG53VjMVvJGK6xBtdg+U1oBtGISu/VLg+M=; b=eOdkBW83vfkfVsrwAvlPoM1+Bg
	pstYXJKpIwaiDn2/gTdfmRPW8L3bnSP8+vBoV9brH1WBMOyHWTAKRILKs0lGMO2ubYyvdhmI3s8tQ
	kLIelsi9Phxmk+3X1V4OXbrqO4DHUgQlGvuX+IMkdvtJmO3iCWCRlRWREBHrWR8LyCdtFnAucVpYV
	I3iPVHHGnqNT9r2vGZ2OUbnEdSfwJUfntdjdj3rG/PwytkrTjEmULuQ3FCp0P8vJu8VCCr1+pqt9h
	/pCKrORgdlT8zYQE1IvOSIWuGf/DcKgHaIw63m8ADSPA02qSjBBavWvGGFwvIXBgk4Zgs07gxLxQ6
	YJ6tLMwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUmlZ-0000000Bgl6-0EqA;
	Thu, 26 Jun 2025 13:35:49 +0000
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUmjg-0000000BgU3-33tN
	for linux-nvme@lists.infradead.org;
	Thu, 26 Jun 2025 13:33:54 +0000
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-236377f00easo12252125ad.1
        for <linux-nvme@lists.infradead.org>; Thu, 26 Jun 2025 06:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1750944832; x=1751549632; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uC0OiGu+HpG53VjMVvJGK6xBtdg+U1oBtGISu/VLg+M=;
        b=N0Lw4WGtQADSFaQucKFwS3P/hh6kwXeW8N4HBN7NzQvLGziqtRur0QZhvLs5Iv+btu
         0B8WU9841iyLjHPHyGDEo0u7GnQpLTZwWzjQiMqOnT5+Qo2xN5XSMZ13/kdBYk/+UAq3
         ZITAwNOW5xLUt1AI7BjsY4Y/r1v+VTgnbnNzT/r1kkNdIe0bkXDF5TVqpFHRNmWGxag1
         mYmmaU2skxp/qLqqIZQLtR3RbtHV5/hCMM++9QSWDV/bW26RZqhiKKblXoDHP9moiVpB
         hizuNnc7fpoyHpe/k4k2JI3bUBO8zaWwAtbrH8AZAEMKwgxVzxmdNk7YcflN2M3cZhuh
         bG2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750944832; x=1751549632;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uC0OiGu+HpG53VjMVvJGK6xBtdg+U1oBtGISu/VLg+M=;
        b=FTUthO31ZEWOWfbp0vyvK1C/uowIKggJZn58Ec0xv3/HzopQO/FMQ6VIzKa3TRJ4US
         5Yy9SPhr/jHF1bMlLbcOWfxMm15nGBNr9/kawPuNPhG92kxbvzJz9LP9deJu4gMwee0x
         9mJKdvIIE96By8LOYiva5qnNri0sCjzpGRYe+K5o79e+LozDTlNfehARd/4HalMmI/bB
         rUHwNj0Vun1lFGC7+Pvkhb/hgKMhc8qhv4ep8cyUDcM8i1Ynn3YsNAbLw+OjnZw4v5Mc
         sHXsfybOAuWsTMLwipBtczTqNLNOSs0wcTe52Saq82AIf96KXmuIPrXryIaMFIbZzWPW
         +iUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUp6ad4JhlomoPTnwCj9NOR5OEs7NA0L1dE0Xxd0tP1zOVQQkUb3ECwDu1XC4zUR1HUj5uwb/96FaAn@lists.infradead.org
X-Gm-Message-State: AOJu0YzaiGriBgEL7hykWz/UIMVTIFjg1RyTgFTU7sgWfbZzo05EsRk+
	aKokpGcl0riu5T2MF7I+SYki/EzyDVMrgept+QDmmSfPC8SCEdrrXFKofKp/aBiqDP0=
X-Gm-Gg: ASbGncsQN+6KqA2lS3/JXJ0WgMLA5RT2s2gCe/zvr21XgvS8qVVe1k5yeltw03aPR6n
	dt0dbyMc9uR3HXb22xs2F5eMPEngljHTt+9oVcVMG8mFDfsIZpku/sJBWbZQxS9IjOQzymsb4Ix
	DWTt2oVesWm+CcF2JMTY+G6ggsW4nAtPsMc6KXvLDeGOB9nudJi6wdcWMclXDZWuZlk1q98jDjF
	Wl9WtpiBiW2GC8DNT8b+pcILEkkEWlaMFUnmZkhJlkftPW0MCQDft/5deKASBB5zXJsgXL1B3Ur
	5H5tBGaHxegd8ntSOvgo5iaKJsDCqBKQ4gwpixkRtPjrOn1kk5PLhpZeLw==
X-Google-Smtp-Source: AGHT+IFT9J6+igjlnsWk9/MBbtfEL/lvJB6RyoRwy5Ug8IZaAgpB13e+C+AhPihBSlpF/uw8wW13Ww==
X-Received: by 2002:a17:902:ccc3:b0:234:8ec1:4aec with SMTP id d9443c01a7336-23823f920a2mr81921445ad.6.1750944831975;
        Thu, 26 Jun 2025 06:33:51 -0700 (PDT)
Received: from [172.20.0.228] ([12.48.65.201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d873845esm167705555ad.243.2025.06.26.06.33.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 06:33:51 -0700 (PDT)
Message-ID: <3a148e8b-86a1-415d-b05f-237d40596d0d@kernel.dk>
Date: Thu, 26 Jun 2025 07:33:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL, resend] nvme updates for Linux 6.16
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
References: <aF1H_345SuVYxoCW@infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aF1H_345SuVYxoCW@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250626_063352_906982_EA343B1B 
X-CRM114-Status: GOOD (  12.71  )
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

On 6/26/25 7:15 AM, Christoph Hellwig wrote:
> [note that the commit dates are very recent.  That is because somehow the
> tree the ran through the build bot had me as the author for the commit
> from Keith, so I did a metadata only rebase just now to fix that]
> 
> The following changes since commit 4c8a951787ffc4b61a547db9866196104971b5fd:
> 
>   ublk: setup ublk_io correctly in case of ublk_get_data() failure (2025-06-24 20:45:31 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.16-2025-06-26
> 
> for you to fetch changes up to f46d273449ba65afd53f3dd8fe0182c9df877e08:
> 
>   nvme: fix atomic write size validation (2025-06-26 13:04:37 +0200)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.16
> 
>  - reset delayed remove_work after reconnect (Keith Busch)
>  - fix atomic write size validation (Christoph Hellwig)

Pulled, thanks.

-- 
Jens Axboe


