Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9EFAC54E90
	for <linux-nvme@archiver.kernel.org>; Thu, 22 May 2025 15:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lx0n5h1cqvuf4X6qJjMPK63d2ae4U83l+nIOQxouVe8=; b=jpkKfZjrLeHyIHAguLAhr0nXHK
	K2gj027wSDRYLYSMD8fae2Yyb6YoU1NstYAEj5t/qQbdjPqUKflffUM40pdbyECyblfENARD0w1/o
	j7SOR/fa1oF6ZXrcCBTxHdDcJtPYiNjU7bFa+4ceJIO+fmh07uuL/lTwXLNUf/EeItnu4egZ9RxJr
	Xs+CJngSYbe+9ZopJVXRg6JaMZ2ZStQ+LVdBTaiJ0wLR+UMNtnXiZxDlrm7yVGqPxQqMoIJFSpXwH
	3NMlHS/zeFPcGNa8hs9KLh+BVSMyWO2+NAjhVtZCm9XywGgc/HDmlTtLM+DzjR+VteFkCNlcYl7Fi
	2xJW6dGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uI8Dp-00000001V9x-3uKL;
	Thu, 22 May 2025 15:52:41 +0000
Received: from mail-il1-x132.google.com ([2607:f8b0:4864:20::132])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uI7oI-00000001R9R-30JS
	for linux-nvme@lists.infradead.org;
	Thu, 22 May 2025 15:26:20 +0000
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-3d817bc6eb0so48470265ab.1
        for <linux-nvme@lists.infradead.org>; Thu, 22 May 2025 08:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1747927577; x=1748532377; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lx0n5h1cqvuf4X6qJjMPK63d2ae4U83l+nIOQxouVe8=;
        b=v5JeVOkFA9T2M5lWqJZieHYTuE385b8eLJq4krDjUdgtJawoRRIVOj2utXfO41pqvg
         Io3vGPnheRYoLIuiLQrYueiHvA+OeoFUBeB6dhIMrwPBLar/GPYDf7yZTZgx8BiV4LPQ
         WD9rKxfGyy0KUjt6j86M+kaB/CKn+dMCYg9K/W7Yfiyl6gMWRG6TFbiDllUO+HJ2enQ5
         5SX0jmrZfQXwlf5d6+SVB2cnCdj8lRqn2BbOZwL6X1I7ylIIxpLaEDvRYMyDLbC5DJA8
         FYp4EFkTMy7j3BMwQk1QPQTtCbdl6NwKGB+dYxQSdPmYh9uWdjY3+3mGExgjEghCSwZ9
         GIrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747927577; x=1748532377;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lx0n5h1cqvuf4X6qJjMPK63d2ae4U83l+nIOQxouVe8=;
        b=F5f2g2zk+k36acH2DAZGZtK9A3eHRSmTo+ysfu2RyEEnphJnjyeMDL7Jskp4zLVLC7
         dY/+5flak/1JOGxcJubnBlnBl70EwleL3bat5TxnorcdfgnC/4E8FdE2Fzg2dcuw1KuF
         bpnKWTJCgP4AEneCZ07RseTDHqnNILqzTCA8OaQs4vjf9eWWsTEbdDeA7AvNpwpbj5Y9
         +VkfCOE7U8QrinSBTkqTKnCQe4LyHqnbYf0CYlguzkrgU3KVo4nC+fB1+Bde68gtUqbu
         rsMRy0kksRffiUqp2I6DmwtDetnDfEk34TKGnhcO0Xe3w8N2r9nR9PEUQB6TgRCdl4rD
         2QCg==
X-Forwarded-Encrypted: i=1; AJvYcCV+46M6LcadBnTRNufDKFjEeitzBHWwr7zVT3JkRPDEOmgbU55PNtu+hLnQg8LOv33JHxaK3vVXyuDv@lists.infradead.org
X-Gm-Message-State: AOJu0YwDf9GV6YkLQPSpEHulXloCtiiuHkCbWRrBNvKVDd057IhjMERM
	XN9K7IHgnMzkeuDuYN6srM6A/0/zocH8M1dB7Ph3AAJO2xnEu21M4dFIxoCAa+FJOAQ=
X-Gm-Gg: ASbGncuGNU/tm87+OVRlUqfZ7MfAn5vGB5vWVryfWrRqgCEHFC6WjqtnnLOLZ3AsTH0
	63ZXuyGhOwiWBbEpymD5iyxQTL6CeLdxDSgE0cQBXWgTG0f7/VUZ0HrA8fDtfqGAf0EK56Flqxr
	Tcsp4VeNqLSLikKy1Z/pHTzCxY4UoaFQgSJrvmD6HtYk0LL2sapaBku4/Apx7KLGujyUl7ZNFrG
	KUqE0gcx2QQVpCmncU3i5JlVW7HSxh0igAOz+3OXvtWU1OZrKhUtxPybQyBd9SXk6lSzwIQf0X6
	rE1Y+sT3XUDqI6URLTbfOFWasVu/04omSFg3/pOktyvHMPI=
X-Google-Smtp-Source: AGHT+IGzhOWXribK1IbycI+KBAw+QEv9gxomT+pM+E+BLOeT4eMJipexX7wJd2Mj6jucYgz00SXFkw==
X-Received: by 2002:a05:6e02:188d:b0:3dc:7c5d:6372 with SMTP id e9e14a558f8ab-3dc7c5d6637mr117988265ab.7.1747927577052;
        Thu, 22 May 2025 08:26:17 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3dc8ad89ecfsm5835255ab.26.2025.05.22.08.26.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 08:26:16 -0700 (PDT)
Message-ID: <cc3d3809-cb13-4800-8b67-2bb42587dca8@kernel.dk>
Date: Thu, 22 May 2025 09:26:15 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BGIT_PULL=5D_nvme_f=D1=96x_for_Linux_6=2E15?=
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
References: <aC8x5G4RUjgbAoAc@infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aC8x5G4RUjgbAoAc@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250522_082618_756585_2B2AB639 
X-CRM114-Status: GOOD (  11.79  )
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

On 5/22/25 8:17 AM, Christoph Hellwig wrote:
> The following changes since commit 355341e4359b2d5edf0ed5e117f7e9e7a0a5dac0:
> 
>   loop: don't require ->write_iter for writable files in loop_configure (2025-05-20 09:16:23 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.15-2025-05-22
> 
> for you to fetch changes up to 49b9f86a594a5403641e6e60508788a7310fd293:
> 
>   nvme: avoid creating multipath sysfs group under namespace path devices (2025-05-21 14:55:46 +0200)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.15
> 
>  - do not create the newly added multipath sysfs group for
>    non-multipath nodes (Nilay Shroff)

Pulled, thanks.

-- 
Jens Axboe


