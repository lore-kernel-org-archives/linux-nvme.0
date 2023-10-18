Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D366CCDB482
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Oct 2023 21:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uTgw2muMI+UU2c4fSk87Tgy6ScuQmc6FTz3A4nRWa5s=; b=ZfjWnZiUi/SbE9fwtDqplHvg4G
	c+jJXpIZPzLYFdjVWhpLdui0vE40XktI7Gn05Tnoiamb8GoxU6PiLi36uuo4ucAEeGydWDf209iTi
	lTVal26KdEI0yvHKRk9M3jDsOSzCUjswu/GvVyQ3K/5/FzhyrtB6SR/lX0sGJQSAZ6Gw+OIVVX3ps
	nlwpxGSEEhXNOxmIY44egvMRKSGoor2qIfzQgCMEhrDaczCKVXZxJ5bLJXY1z3LkIDcgOlZTGtVyJ
	B2p9UbCWJb0K5MksKiUP8BqSVmMTplNEF8LPnM+tkCkX+DrQZqQJ/jGOejU5skhCCSyvJH58CiJJF
	DQbDVUlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtEC6-00Fkbd-08;
	Wed, 18 Oct 2023 21:35:10 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtEC4-00FkYQ-1d
	for linux-nvme@bombadil.infradead.org;
	Wed, 18 Oct 2023 21:35:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=uTgw2muMI+UU2c4fSk87Tgy6ScuQmc6FTz3A4nRWa5s=; b=nylrJV4fJLpYRXMJAbzJ2iD2dz
	g9xTIg7DgfitjpVOPm+rUfL7QxOFUGyN+QcUDwzRxzatTGvcD946S+N5BcB4bOvtZZXX5m8HTQo60
	X0kNzLWnw2iYc50DNlN6Usx+tCtGoiijrjtMThQvZnRZDkXsd6TIh8WtMvbnEKQeEvnPTIgh5vPc0
	b1XuewbrAcv/zIo7ccHr52vNCRyt8P67NtcAA9HWxilh6ayH2NjJos5Za+8q/BgPIJLRN3G+UX4zC
	U5yrrhvQP4UxFcI8/e4V0ygQcOP/HDWolq+SDQ7/u6VMLh4Cejwsdt7RtrrZtIvU5MsC3IEoQ+et0
	n2/v4dbQ==;
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
	by casper.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qtEBz-003EQ5-Je
	for linux-nvme@lists.infradead.org; Wed, 18 Oct 2023 21:35:06 +0000
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-582050ce2d8so55294eaf.0
        for <linux-nvme@lists.infradead.org>; Wed, 18 Oct 2023 14:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1697664899; x=1698269699; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uTgw2muMI+UU2c4fSk87Tgy6ScuQmc6FTz3A4nRWa5s=;
        b=SaxiTYP5oAo5ACEBdTqJNu9I2JKm/QaDPdL+tyZhIhE+doaPvifKzppqTfu1SRTcrt
         LgAkdfiA3uYTXasCrLBCIqUKvyVIDx/DLT2kEshsMLQ72dhTVXoq0EvuHv8r47rP7rbt
         FiitrDKyryzyFNYvunntbrd7RoxaD2GAX8d1S+XO6PA/KW5KiUNHtlx4vtUXcrBOhfNn
         2QUGjKRq9DjeCJ6HltnIppuf+ie7bVD8+R6KvvINMrpG1QzLPUc9Wb9SPiC76oqOEwnl
         j19S2dbgnnl45TKSWmfeK7bJYaKSmkA8vJmjzLiHOCzddHQ4br5ud2I2vjYyWhB8xeAu
         Kx7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697664899; x=1698269699;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uTgw2muMI+UU2c4fSk87Tgy6ScuQmc6FTz3A4nRWa5s=;
        b=JAir/XdAd5exFthez7hYIvLM7l8wnxC9yrMn5jiCWyLhWU4COjX2xFzH+xxCpnZ3yG
         Dg+avPlZtI3zj7am1J++3dWhIj7S85HawdoHl1VjdciAKMNgTFzcsX7ZMx0fCQn1FOH5
         ZZMt+ls/bKnJDA/pHYeIAeXbIbRJnc5FSuE0CSV/4qp9cJyBZARIyLo7N/1NlBIn8M5g
         VsvrSXAoGcRVs+1CzTsvf11ehSSfrwV2awMIiINFt6N+bqlMxZStmv5zkDOHLXZ7Xl2M
         phMbJ5qBn8bBxxoUKJ8OE+uBipPBok2XkLSVXFI8ccIcrK5wQ8pBTqbwdW7pDLYMbTDN
         1NYA==
X-Gm-Message-State: AOJu0Yywn1sG9uxa1+ehL164TN2GlqL1VuG2LlsLYstHyBBLbKJW+wPP
	gM1KLBjDmb0KAF201hcYvsgH0g==
X-Google-Smtp-Source: AGHT+IGEEr3yZKDbXwLHJ8HFhCdZlAHoMLHSOqsFa9P5+RabA3flDtKAqUYuLb8XEpxWm43GBRwcug==
X-Received: by 2002:a05:6358:71b:b0:166:d909:74e with SMTP id e27-20020a056358071b00b00166d909074emr357519rwj.0.1697664898712;
        Wed, 18 Oct 2023 14:34:58 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id k9-20020aa790c9000000b006be047268d5sm3921729pfk.174.2023.10.18.14.34.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 14:34:58 -0700 (PDT)
Message-ID: <da26d8c0-46b5-4a0d-8c8f-e924cec88e6b@kernel.dk>
Date: Wed, 18 Oct 2023 15:34:57 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL REDO] nvme fixes for Linux 6.6
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de
References: <ZTBLFYbo8iuhF9kZ@kbusch-mbp>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZTBLFYbo8iuhF9kZ@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231018_223503_771944_FAF7EC7F 
X-CRM114-Status: GOOD (  11.17  )
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

On 10/18/23 3:16 PM, Keith Busch wrote:
> The previous contained a patch that needs additional consideration. This
> pull request is the same as before, minus the non-root passthrough
> revert.
> 
> The following changes since commit 07a1141ff170ff5d4f9c4fbb0453727ab48096e5:
> 
>   nbd: don't call blk_mark_disk_dead nbd_clear_sock_ioctl (2023-10-03 18:27:44 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.6-2023-10-18
> 
> for you to fetch changes up to 5c3f4066462a5f6cac04d3dd81c9f551fabbc6c7:
> 
>   nvme-pci: add BOGUS_NID for Intel 0a54 device (2023-10-18 14:08:39 -0700)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.6
> 
>  - nvme-rdma queue fix (Maurizio)
>  - nvmet-auth double free fix (Maurizio)
>  - nvme-tcp use-after-free fix (Sagi)
>  - nvme-auth data direction fix (Martin)
>  - nvme passthrough metadata sanitization (Keith)
>  - nvme bogus identifiers for multi-controller ssd (Keith)

Pulled, thanks.

-- 
Jens Axboe


