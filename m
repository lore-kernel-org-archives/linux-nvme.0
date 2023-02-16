Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2BBBC61DA4
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Feb 2023 03:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R1kOUaE0EiKmZk9jWga/4Ri5+1QBKa/W13AHkjPQiM4=; b=uZNvPgXrT3ZsKbtFJlhY3erMnA
	JP2BoPF0cVpfPLelgwB76l5m5Z4Cx9XiLucdQ3RDchQohKZg4t5tSANJiyXa2+7EuJG4DUHczssOD
	RWL1syyOMT9N2iVEowjt0T1BkRNkX2g+dPn+42uS+C1Vm1G6TT6wwqh14sdt9f+l4kGikkbW9Pxkc
	AkLXVwPGi18+DIMNPSUhtX8NTmrkAMHwN/mUTys9yvPsPa5dYQbDjLd9DsRt3xalsDAw/58mgZKgO
	6NbTpPkoWVZY7qn2Qx+eILyTnFgPrejiA1j0YRuSvw+pnd2iX52prJr9ErLauB7heBQUXBP5IhtBR
	01tPfgZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSUuI-008OU1-75; Thu, 16 Feb 2023 03:26:02 +0000
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSUuF-008OSl-FA
	for linux-nvme@lists.infradead.org; Thu, 16 Feb 2023 03:26:00 +0000
Received: by mail-pj1-x102c.google.com with SMTP id d2so595045pjd.5
        for <linux-nvme@lists.infradead.org>; Wed, 15 Feb 2023 19:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R1kOUaE0EiKmZk9jWga/4Ri5+1QBKa/W13AHkjPQiM4=;
        b=wpu1digYWAfQFn4RXL4rbyNWKLk5iDpnEC/V582dT91O6cGU1C7O/EV3CznVhlScQH
         rD8PetDj6R8zuCuBAsV7DQcBAxsR6ur/Ug5JclsSeH7ULIg66kD5ZrA2bxmZeSPdhIKr
         jKlVLgFMvCXo7s+o+G2zcz1ts8vlOCAfcQ4ylIw6wkya8q1u/5Y+v1M23b6eSjQFCoLF
         rihGDjrMNIzKb+NMqkVJOccMNnlh6aBkvT1X4JnS0Y1I3jCB0DnDydEBvv/cy387hYdA
         kjyGDn7FFncYmN6O9ZvnToUSDxi8/E6vuGr+cnuQinxfuDTzDObz7p4or1jg5l9FCUhZ
         MnZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R1kOUaE0EiKmZk9jWga/4Ri5+1QBKa/W13AHkjPQiM4=;
        b=0sgNcSnxeYs++WqNfQz9a4SiBk6e2Y9aeWkILoP3quG+09CdfI+6G3js/9sEq+LfK9
         l+EXPqvD2nxOOIPhFk9KlHJMLVuYYgsRFw7n+A6mSvfSXziD/dH7nLOLftKx1+LYiXXE
         12TPMMfRdG8l8TZofkHPWRjm03D48HEbNeQ/Y35QtFz00HZovfzCixvmJL1OGMSDY2dJ
         a6WiUyMsLvCqJhx9IEaUWCgG2VmcWulsseRXFjL+nXFN2jgNQzMDxRJD499qpYeHFmiy
         0rAaaK7Zc8HWzeT6xTElrtCBwG8Ikv66Dnr96stad6AZgYTOe1vtAcow4aZjiLZgpXs6
         id9Q==
X-Gm-Message-State: AO0yUKVpPwwB9GQhp2dmzDXw1e8qR4m68qxrvDVUfNCy5GRAYwRB9R8A
	DQ1rvX5bgNqugoGOEN3RbcfhNw==
X-Google-Smtp-Source: AK7set8GbKfFb7nuzK8sp8QOC27EkkD3yZHaUl5JQdqnBciQX4jwm80ekOPBQ5uUtY06rN/LBr3NPA==
X-Received: by 2002:a05:6a21:7891:b0:be:adc8:96c8 with SMTP id bf17-20020a056a21789100b000beadc896c8mr5227369pzc.3.1676517955979;
        Wed, 15 Feb 2023 19:25:55 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id c130-20020a633588000000b004fb26a80875sm146674pga.22.2023.02.15.19.25.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 19:25:55 -0800 (PST)
Message-ID: <efffdb82-85f4-af8c-6866-a643a7a16ad4@kernel.dk>
Date: Wed, 15 Feb 2023 20:25:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [GIT PULL] nvme fixes for Linux 6.3
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <Y+0hqoUKkv1fMMzk@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y+0hqoUKkv1fMMzk@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230215_192559_523776_23ECF2A7 
X-CRM114-Status: GOOD (  11.92  )
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

On 2/15/23 11:17 AM, Christoph Hellwig wrote:
> The following changes since commit 2f1e07dda1e1310873647abc40bbc49eaf3b10e3:
> 
>   block: ublk: check IO buffer based on flag need_get_data (2023-02-13 08:36:23 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.3-2023-02-15
> 
> for you to fetch changes up to b6c0c237bea191fb99b6c2de093262402b0159a6:
> 
>   nvme-pci: remove iod use_sgls (2023-02-14 06:40:57 +0100)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.3
> 
>  - fix and cleanup freeing single sgl (Keith Busch)

Pulled, thanks.

-- 
Jens Axboe



