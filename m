Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B307C369C9
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Apr 2025 19:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NgbC0Ho51LBhNAGrJS6KpfvBsql1IBS8J1NX4yoaH+M=; b=lvh8fYAjlEJ3lUtniM2VojSnIo
	XuBnNLAktHPyKPP9M412A4hrX0nMNmWyQZwFbz3x7WNFYY716kEzK6ONNcwwzXZMNpMdkCrM+bZkM
	uMADaUH+gehNofPfYTgUT0kswv5FEJh2JGT90qmQ93zVuG0O+lFJiS2VRlbI0tOgYrhsuofXPJqMt
	tfw/ocMrxe22IbRb6uPPB5BqbjXnBrMyxvxFR+K13Z2TJ83Woh9Oyj2Xnoj5ETcG8JJ6LE/cHBT3m
	qd8/kA5Md+9MF4wUWUvq404VxtDn02OaqbqU7oaS8YgX7mxIqpXmCpD0ij6ZjDARn+vXBkF4RACtA
	1wFoq3ug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5r9l-0000000HZSx-1nXa;
	Fri, 18 Apr 2025 19:13:45 +0000
Received: from mail-io1-xd2c.google.com ([2607:f8b0:4864:20::d2c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5kfT-0000000G3E1-3q08
	for linux-nvme@lists.infradead.org;
	Fri, 18 Apr 2025 12:18:06 +0000
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-85e15dc8035so59768339f.0
        for <linux-nvme@lists.infradead.org>; Fri, 18 Apr 2025 05:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1744978683; x=1745583483; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NgbC0Ho51LBhNAGrJS6KpfvBsql1IBS8J1NX4yoaH+M=;
        b=QN8R7DYZrPU21Sjnt45M9KaAuIB7qB07yA2nhmuu7Z6L5bAJV1XZ0XQntaqDLRxCdc
         1sw57KKad97CmDaZizZ/lCWcVpTq3aY+3P9IqwzHpCF1FxgrLgiKqHo9E41900kDimTl
         NLGTpw8B9yPuLAe8v2NqG4uQ95lSLE4vTXEb7MnkxeJaRRmw0sWMHFTjr2a/u4SPnGN1
         0GY2MLc3W7E2JiwKVQQz77UOTPkNh3rKomH1EnIxN3PB1oOOuWJ0MuvGM848YW0SC4W8
         AXW+Ab8j0heUMMwDdjbkALk2uneJ+5u/8kK0+wLoev9lE80B9bPx+XLOsnA54f27rW6O
         Z+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744978683; x=1745583483;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NgbC0Ho51LBhNAGrJS6KpfvBsql1IBS8J1NX4yoaH+M=;
        b=D9hEV6QQOy0FG6S1qdcKhsdotv57KnuJbTGNttp/7lb9ElzKm3STPC/9VNp4crk6mH
         7ozUzqJBjA8Vahm4I8fQJ0LuXKSwpcP2KQWcQt95gskrrV+aFV6oWrHn8c3ffO2/znd/
         J51Po4SdpXo+Rlv8G+bvY4W3aJItr7LHoI5JkWdSee3HiZAmNfP6G/XfyrF0+AjmdJKR
         pEeqygX6odIMWWdwK+rD48VLJ/oKHtrzHzqeswOkBB2aid8eq5unbPxvqZmP1naPtcSJ
         cliMsarx0HNN5Lk+NwOZ5lrzFa4Uf3vZyJ8+RfPtNGUQVc5Vc7whjKXzVFE0wD38tTlM
         V4vA==
X-Forwarded-Encrypted: i=1; AJvYcCWBTnaOUUScVPCWquK42RnOPDedMqNCigYCxwpgC4mbaBT+er6icImlX1KjwnzZZeHLhsVzUN+AvjZm@lists.infradead.org
X-Gm-Message-State: AOJu0YwdEjXXNZMnE4eiRZ/a84ZQIuXKzRMd2qONCN75RtNBAsPCPcnY
	US+kGn1d+yjDJ1HJchpPRbiLpuS4asUaFkB3l01N8NQSOeISdpY0sM8DiwnZqAw=
X-Gm-Gg: ASbGncuSyBne5PZvCKTkVYhRwDzyhYyKmKX3vGtN4T+wXcu5xTzhv7XQ2qrJhHYxr0x
	Vg0dlrWfeNuOBHVXhHL3h8UzkivlPLjngZO1c/u77MW3OaHbdeGK+2X0d670BK3Qdm+vpHvSNLb
	X6Hdv0kHR6LbmExOLVQOdp1SQt3g5tT85hvN0tFvqtT2M1xeR3uFJBi0sEQ0zwI3C4Bf8NDIDGc
	X+MLBfqkHiRpERwA79QFNKNSacarNPEJhkwDCFa24ukgitcrWtgDZR3nddn+R7D5aiiPTqTaRZC
	crBf23F6TZ1dxWMBdByeXFnifh7km1zAx1E9QvF4KahWTxEl
X-Google-Smtp-Source: AGHT+IEcKW8yUly7My6VmHwOUQO6x2LKb/qwvAEzz9JLvNvB2Bo85wGWvtKeixpJ/OLzr9zB/iMeqQ==
X-Received: by 2002:a05:6e02:17cd:b0:3d8:211c:9891 with SMTP id e9e14a558f8ab-3d88ed7c3fcmr25688805ab.2.1744978682766;
        Fri, 18 Apr 2025 05:18:02 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f6a3957613sm406821173.120.2025.04.18.05.18.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Apr 2025 05:18:02 -0700 (PDT)
Message-ID: <93ef8629-4040-4773-beac-03c62f848727@kernel.dk>
Date: Fri, 18 Apr 2025 06:18:00 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/24] Provide a new two step DMA mapping API
To: Leon Romanovsky <leon@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Cc: Jake Edge <jake@lwn.net>, Jonathan Corbet <corbet@lwn.net>,
 Jason Gunthorpe <jgg@ziepe.ca>, Zhu Yanjun <zyjzyj2000@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 Yishai Hadas <yishaih@nvidia.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
 kvm@vger.kernel.org, linux-mm@kvack.org,
 Niklas Schnelle <schnelle@linux.ibm.com>,
 Chuck Lever <chuck.lever@oracle.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, Dan Williams
 <dan.j.williams@intel.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Chaitanya Kulkarni <kch@nvidia.com>
References: <cover.1744825142.git.leon@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <cover.1744825142.git.leon@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250418_051804_157340_D857FB79 
X-CRM114-Status: GOOD (  13.13  )
X-Mailman-Approved-At: Fri, 18 Apr 2025 09:39:28 -0700
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

On 4/18/25 12:47 AM, Leon Romanovsky wrote:
> Following recent on site LSF/MM 2025 [1] discussion, the overall
> response was extremely positive with many people expressed their
> desire to see this series merged, so they can base their work on it.
> 
> It includes, but not limited:
>  * Luis's "nvme-pci: breaking the 512 KiB max IO boundary":
>    https://lore.kernel.org/all/20250320111328.2841690-1-mcgrof@kernel.org/
>  * Chuck's NFS conversion to use one structure (bio_vec) for all types
>    of RPC transports:
>    https://lore.kernel.org/all/913df4b4-fc4a-409d-9007-088a3e2c8291@oracle.com
>  * Matthew's vision for the world without struct page:
>    https://lore.kernel.org/all/20250320111328.2841690-1-mcgrof@kernel.org/
>  * Confidential computing roadmap from Dan:
>    https://lore.kernel.org/all/6801a8e3968da_71fe29411@dwillia2-xfh.jf.intel.com.notmuch
> 
> This series is combination of effort of many people who contributed ideas,
> code and testing and I'm gratefully thankful for them.

Since I previously complained about performance regressions from this
series, I re-tested the current code. I no longer see a performance
regression on a AMD EPYC 9754 256 core box, nor on AMD EPYC 7763 128
core box.

Tested-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

