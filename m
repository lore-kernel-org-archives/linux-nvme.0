Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F0EEC43334
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Jun 2022 14:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HYMeQEOYiWID2yhpyHAGyopUXPz2WOZRYj6of+XCB1A=; b=S14jvS5PlcLXkPwREapj1jvb5t
	jLEhKCnBaCyGGwUQkyl6zupvsVF6dUm+qX680+Oxxp+Lu8I/y+TelJK9SJLHK+la45V9Izt8H5G5r
	6rBAN6sgS7dPDWekEPtOc8oqjA3JsSOCqmOjoPXceZXz4o/BMdUVd5DLWGF5sfU2pFcAHefrdGnXv
	7HFsGcyjnRzjjtVP6fYXF5HuQm7j1N8YU7SIdCNaQJ5cBSHjsvE6BYYgp1/Fjweus/+jFDuFEt1O5
	CWS4OEnvkl6YhPYcEb+3OwduRysM6ntwwoHBpM8JmjHmGIf95TyDYFtSkSvBOHIMp9FnyStDPufuT
	znfdX4Tg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o2DMC-0084An-GG; Fri, 17 Jun 2022 14:53:56 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o2DM9-00849i-W3
	for linux-nvme@lists.infradead.org; Fri, 17 Jun 2022 14:53:55 +0000
Received: by mail-pl1-x62e.google.com with SMTP id g8so4085885plt.8
        for <linux-nvme@lists.infradead.org>; Fri, 17 Jun 2022 07:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HYMeQEOYiWID2yhpyHAGyopUXPz2WOZRYj6of+XCB1A=;
        b=M+egF4rQ3gzLX3uff9NPXlMMAudd6I5z9fMHQxB+r3iRygwOD07CyHLS7nOicEPeKM
         RY6RCRl1+XOhQI7WjsJYdfW5yDY/o24lozabEP7GVvSZAs5YbG+HtyECC4Cf/3rrrubG
         nCI90Gnje/nJOU/C/0y6kbQGnbtPvmjzkb2eE3RPpvftNOaQZ23m0FyoUtwvc8vKoRZA
         MdUDgspnw35l0wwmP581Z2WuOW5m1OrBp/lnBI4uY9Nv4SOZIvoKm5wabfKvH0q+OMkR
         YdQzu/f9/xrhfZKPN7+mEKzWAPZtJbveEwywBoED4XcMl7983ZwRJKVQp9jwjxn+TTTC
         q3ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HYMeQEOYiWID2yhpyHAGyopUXPz2WOZRYj6of+XCB1A=;
        b=SDj/6BqrxC6RoGqfHiGIagUCo2GyY9hdQh3I6p8vOUMMXlPHYxgB67ZPQcFPxV1Y1+
         cS7i6W/pXDGm3skzzS8tkJQmfHUSJtP6BPFE/ZsuUYwCvSqYT6Vmb5SJYK9Ct8NUHI7T
         qw0rkIfhqTD4BsXlssinaNMwDHBrJyS+GRumL3L8DAH5Yws9hil5rRzuIeO+CHcNWlBj
         HHVsFAki8Bd44V5ZCIX6Kd1fXWfBp5nkYC5PLvh32vgaS2JrXOLhC5dZgicSdoVld6PN
         26gt0RB3VkTY9Kpldqx4Z2opQzaO7bYYd1xs2ssWQqWjF2Vk26/9pnKDxvm98Jy9/U+H
         3aCg==
X-Gm-Message-State: AJIora+gJsLJgnmQtK62V1umDsGVCNpJQgultNXzuhf31SJg6/8ZimLa
	9BXw1CD1hY8XCC7XQMMnKyo=
X-Google-Smtp-Source: AGRyM1tqvwAcx0xhp9OWCe6RtMmsn8GeN7CyuwQmn2/ZPd3VFZqlR/37o81eiMXQCNcWpt4kaABtxw==
X-Received: by 2002:a17:90b:1c02:b0:1e3:4b6d:4269 with SMTP id oc2-20020a17090b1c0200b001e34b6d4269mr21709189pjb.57.1655477630476;
        Fri, 17 Jun 2022 07:53:50 -0700 (PDT)
Received: from localhost ([122.164.42.73])
        by smtp.gmail.com with ESMTPSA id z15-20020aa7948f000000b0050dc7628178sm3818349pfk.82.2022.06.17.07.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 07:53:49 -0700 (PDT)
Date: Fri, 17 Jun 2022 16:53:42 +0200
From: Pankaj Raghav <pankydev8@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, sagi@grimberg.me, monish.kumar.r@intel.com,
	Jason@zx2c4.com, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: move the Samsung X5 quirk entry to the core quirks
Message-ID: <20220617145342.ktideod25ndexioy@quentin>
References: <20220617083206.1146088-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220617083206.1146088-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220617_075354_093005_010263FB 
X-CRM114-Status: GOOD (  11.70  )
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

On Fri, Jun 17, 2022 at 10:32:06AM +0200, Christoph Hellwig wrote:
> This device shares the PCI ID with the Samsung 970 Evo Plus that
> does not need or want the quirks.  Move the the quirk entry to the
> core table based on the model number instead.
> 
Can you add the thread that has the report in the commit log for
traceability?
https://lore.kernel.org/lkml/CAHmME9pwz4q0m-pSUy7ReWu4nNzxySNcYZrqyDZiTuGxHN=1NQ@mail.gmail.com/
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>

