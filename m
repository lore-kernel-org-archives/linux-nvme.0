Return-Path: <SRS0=KdjD=LS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FADC49EA6
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Jun 2021 15:39:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDD98613DC
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Jun 2021 15:39:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDD98613DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=UYRXIsslHgm5dzCZVg685b6P0HmXep6V2Inl8Ee04eY=; b=ITj2mU4O7S54RL+iAgyhjqsRUb
	TNNLeh4x7Jz1VFKQdkrr7IKmby6P4mLS3UgT+cIiOT8L+o0D9ze9Rtzox5o3RuDXq0jnCAsrlILcK
	Ku4+CDe8tbIiVos15IQGGHMkU2Nl3HFtzduHdSlnR2dqKnsS4pTp6TXf2zSOBzbORFaxIlnSKo+26
	hyssiMNtSwEdyYrOecsfQQRLAv9nTkJDX/KzTiuvN5fZhAikxgj0PNOKoTPkcky0r9IedAeW5lcBs
	5pvhKD+X8ENhVlxycdDmfvQj8XnzPQi8L2lvS21HuOtao3GqwkUdRG36+jYykLUHGFx0IquUS+xwE
	BB9xyuzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lwRS1-00FIPP-MX; Thu, 24 Jun 2021 15:39:33 +0000
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lwRRy-00FINm-Fx
 for linux-nvme@lists.infradead.org; Thu, 24 Jun 2021 15:39:31 +0000
Received: by mail-oi1-x236.google.com with SMTP id u11so7806960oiv.1
 for <linux-nvme@lists.infradead.org>; Thu, 24 Jun 2021 08:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=dJCNiAlUPB1PoEdox/Uy/m2O+kkoSzI+wpISSQH9uNU=;
 b=HddnJQaCVd8jdtfn4xqh3tY66xVQ3nwwEEa3jPXpw52bLb1tpSQkvvjD+QTG7Xpq/a
 ReAzdQoe0JgL31DI6U7W2I/yTz/2YXQ++1Z1VwrDxj8dHthdszAyFS5XwZ7xerCwSExx
 omNajb500HI5Afp86lILVvDBApabxATVHwqQzgsLaiA+Y8VkgAlSqDmapjGSbXNPbwBZ
 gEbhNzGE1AOzgc0fQvfldHS5HxYVpNwt+gw97WS5A14JB2BiwE2D8HIZDIk4/f5GU5EB
 CrSIKmICvIj68Zdt7v6CGBytoif0VFcr7gsGtb87X6C5H0qbZk+2PQx5GttjcT5KdtcK
 QXwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dJCNiAlUPB1PoEdox/Uy/m2O+kkoSzI+wpISSQH9uNU=;
 b=buGHbaPYKYg24pRjrP6PMIj150uzOpHvvnQR5NvDiSCFWzoHq8N4XZ2aY4RF2boTuy
 oBu0mrDz27BPH/cj0YVKlZQyqZVpE74AYzWIlNyxTEt5HCwxuwoclcKH0T7flnr2pGjA
 XmSQ4Ptwj8Xv9Fn7YEJ1XE4aGeo5jYcnR+jJbd81qGyk9D0SJwjMAav48/2r2gmbBfcT
 7AK7q77rYg+nu5jRB3kmdsxCqEMfdUNg9LaB0/XAiSAW+GQJnT2QR7yT36Nnbcl/oIZJ
 MDT06StXjxktQgaITWd63JzvN1oC9bt36rdLk4OuN4I0Qciu77rwcf1Mxdk+uD+tMI3a
 WeBQ==
X-Gm-Message-State: AOAM531DbabtwVHQpGx8Gr5KyoND3S/ecjR3inBcfE7mdVi1TCY8lPiM
 XLvCBj6sNji87BQW4dAWoGpb/n6x9Ei1Ew==
X-Google-Smtp-Source: ABdhPJzPceqZfj/iH7K8oJ+N4+xnHxBd+O4f5aojmHDn/lJq6HFDL9UKOrLUzED1053PpfNzVRNz9A==
X-Received: by 2002:a05:6808:2019:: with SMTP id
 q25mr7770646oiw.84.1624549167832; 
 Thu, 24 Jun 2021 08:39:27 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.233.147])
 by smtp.gmail.com with ESMTPSA id w69sm732304oia.22.2021.06.24.08.39.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Jun 2021 08:39:27 -0700 (PDT)
Subject: Re: [GIT PULL] second round of nvme updates for Linux 5.14
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <YNGLn2MsJDwwbZbv@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <e6c5fddd-6829-a3ee-a270-c7e3a81a0c9a@kernel.dk>
Date: Thu, 24 Jun 2021 09:39:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YNGLn2MsJDwwbZbv@infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210624_083930_602359_1D49083A 
X-CRM114-Status: GOOD (  10.89  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 6/22/21 1:05 AM, Christoph Hellwig wrote:
> The following changes since commit e0d245e2230998e66dfda10fb8c413f29196eb1c:
> 
>   Merge branch 'md-next' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into for-5.14/drivers (2021-06-15 15:42:56 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.14-2021-06-22

Pulled, thanks.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
