Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4000FC05027
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Feb 2023 16:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FWpCTwblPDWaV+/VWYnkjaoyriCQssfHrdSwncVglsI=; b=xBmx/JCkRsIk9AsF3bG2RVo+uf
	88QyOfJZHBx+BxOPx5qEdym23tNOtcD+fzdgsvpimbQmqKoS+wqz6RbMRvjUhfqEDyNNZQ2IV+MTQ
	MxufPeV+7Wj36mgHYNudJyV/0aH+kM01sUtXwsqU+Ahs3J9aCP6DGTBh12PVjzJP3W8hyrQY16rde
	tN/wd3kGSRfEB8z6WIWS0r6olAGo6gJ+WEuD5xgMKx3RWOybVQwqVHnO3AOG+4ipzZ+wDDDS+Yhv+
	KmLVXjUeyclfPOfTZGqN7/J2AbRfIskSfCQ0mMhSEly+KIoRHnmIg8XJlmoPIdzVZfT7fBA23ZCnZ
	TDJQJuuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pT3H0-00EzA9-43; Fri, 17 Feb 2023 16:07:46 +0000
Received: from mail-io1-xd2d.google.com ([2607:f8b0:4864:20::d2d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pT3Gw-00Ez97-HU
	for linux-nvme@lists.infradead.org; Fri, 17 Feb 2023 16:07:44 +0000
Received: by mail-io1-xd2d.google.com with SMTP id f11so387712ioz.3
        for <linux-nvme@lists.infradead.org>; Fri, 17 Feb 2023 08:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FWpCTwblPDWaV+/VWYnkjaoyriCQssfHrdSwncVglsI=;
        b=2NEaslRv/SKgJNf8hZu5zfHekODk1PkZC5mH5b/rmGTxRTuzkQEu1awTkrL8tGLSvq
         GhTzWozzmIqwEeZkclGo20T2CH7TJYaNA/ezjTLduWVJ9q3mAcgBbeJsOnliRjYrnipk
         CNOqUwkFiJNAIBHYLApH+kZevftCXKq2zuSO93X1pNSSbq0G7padez2iO7aK/6tqHuei
         d/xFFUy7pxyAHVH9G3IWI30DKUYAyEBRhF39q4OAawAwguPwkfoz5+PuSJYFhcwZ4OLh
         UaSHXUetpZWtamUbHM8ptxU1fu/WG9nvL9J+zSKfa2tQcdbpRcL8H4yJ9ubgTJjVBl0p
         NKjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FWpCTwblPDWaV+/VWYnkjaoyriCQssfHrdSwncVglsI=;
        b=IcYsmN5qCrLO2ct++mqrHtsiuuIGynZE6WIiAu55UpuWpWUFl51mZvFNbckelL1jLn
         KPOY3+LdXh26R8GO3UrX4asX/uQ79kye71aPk5grZ1hgz2KPplQ1/KNUrElAb7sHnMP2
         R1yme7e6OlGZ7GGoLoKCOE1xhwsFraR7cu/POtrMQKvB16tDAX0kLJT5J3JLc0xXo1HI
         WmtQCIHxXYl13hlGAELhvsbXjCZ02+GqPxuFNtbNi6PO20icqfmNlWSy2iDwUUHtenS4
         6dJ1bP6+5ubfWA/N+XQwsMXdHds6/1kA71u7xHupIT1oFzyWHYi8EBd2BKfmWuDhJxr9
         TOiA==
X-Gm-Message-State: AO0yUKU1BunM7+SfzeWe/ssbU1CRwhlnLp8BvPDTY/WCOH6NV1j+MlNO
	/cpJMG0sYLJAfdrYzU7dlJCI7A==
X-Google-Smtp-Source: AK7set9h3hDOpTqtiuorBjgnvE8VHzSVpOAGyY50grRHzp9ZxPSh/NqXUy5tR9Cuq4fDYEAa0tg0dg==
X-Received: by 2002:a6b:da07:0:b0:740:7d21:d96f with SMTP id x7-20020a6bda07000000b007407d21d96fmr1335845iob.1.1676650061491;
        Fri, 17 Feb 2023 08:07:41 -0800 (PST)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id p10-20020a0566022b0a00b006e2f2369d3csm1522616iov.50.2023.02.17.08.07.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 08:07:40 -0800 (PST)
Message-ID: <cfdb886c-bfdd-e82a-2c47-0e0b8a7f444a@kernel.dk>
Date: Fri, 17 Feb 2023 09:07:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [GIT PULL] nvme fix for Linux 6.2
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <Y++ARzuse5GE4UCL@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y++ARzuse5GE4UCL@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230217_080742_597482_EA0115C3 
X-CRM114-Status: GOOD (  11.31  )
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

On 2/17/23 6:25 AM, Christoph Hellwig wrote:
> The following changes since commit 9a28b92cc21e8445c25b18e46f41634539938a91:
> 
>   Merge tag 'nvme-6.2-2023-02-15' of git://git.infradead.org/nvme into block-6.2 (2023-02-15 13:47:27 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.2-2022-02-17
> 
> for you to fetch changes up to e917a849c3fc317c4a5f82bb18726000173d39e6:
> 
>   nvme-pci: refresh visible attrs for cmb attributes (2023-02-17 08:31:05 +0100)
> 
> ----------------------------------------------------------------
> nvme fix for Linux 6.2
> 
>  - fix visibility of the CMB sysfs attributes (Keith Busch)

Pulled, thanks.

-- 
Jens Axboe



