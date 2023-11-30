Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 372BFC10DCE
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Nov 2023 23:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WmpnCqUtuoxHHvkEl3B5MTEZYjPTnTR+G4KhZG9sw9Q=; b=vds33dJAs603A/09e3HD3MZ01D
	fTEnuh0ddkrYRUmdroJtmjxfJUCVeFb9o1+temW7wpIDN6iwRw/H3bN2Mhqf2Kvi+u5YvAeUEl1OM
	PcdMadrBnAC0Se0DCK5p6AgsWNlQ+8aoBfolDb2v4SimPQ5SbPZ1GcDg+7Ji3dEYn7sRMKhcqhfk9
	YfWQC2sK7GLeXiTV3NBEYsOl1vHwIqb086qWb3GKHfjlUIYWd6J88op0qoFJqElEUv+bW0z794Rnm
	PMxKSJfczdfIWcprpVORyOA4OwQ7wsVqwz3KNFqB9uCiq3QEYPY8dEmGhWqBUn3gKKiO0puVNPvZd
	+H5od9Lw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r8qA3-00C81A-2V;
	Thu, 30 Nov 2023 23:09:35 +0000
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r8q9w-00C7zH-2n
	for linux-nvme@lists.infradead.org;
	Thu, 30 Nov 2023 23:09:33 +0000
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6cdd2aeaa24so267846b3a.1
        for <linux-nvme@lists.infradead.org>; Thu, 30 Nov 2023 15:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1701385766; x=1701990566; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WmpnCqUtuoxHHvkEl3B5MTEZYjPTnTR+G4KhZG9sw9Q=;
        b=Mft5LlL/+1r/CoSW0WrnG2Lh9UkD89713w3B1EDyBzfTYcSuAJG2L7XjHIlDFlUhAc
         f0jtj7w6QAH/Wm72tDgJ3jguKDLbjhTHP3cpgYOGvuhGfI40oWK70rVnESsHPskhdS97
         P1WJsqZvIO3yTyiDnT4JLR+km0hy+X7KARv0Yx4cppiPCmMbRPvt7cI2S4iu44dMZYQc
         kQQah9crHAf9nk5bXU+ymXqNHmhtxZdbKPtyIPcjF5/VyrzwhlwoGWFSLRbWS6ji0xi+
         z/RdafPN56mNch1A4t3ISi6krrInOj/+QzMwbOMc8JmukcJwZMuuIb3kCU7Y2uY4lxlM
         ijcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701385766; x=1701990566;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WmpnCqUtuoxHHvkEl3B5MTEZYjPTnTR+G4KhZG9sw9Q=;
        b=v9RquVSWoCmYhxYVjWGK+JUJYgE8iTUrOihD6UedFQtk+9rJ9Wici4rS5dAMbvDUlA
         4xBBzazHTZptbXwbIcI/vBo9xjs2uDyoh8r67WXidIqjEp7Ry8XuVkPtYEuEUbKeRPLi
         0e3oGoNi9x0sCcDNUrqkjlslK4NeNVvvlHHxQGN8Jxs9Y79anfLjwkA67Vfs4qxse4OL
         7VW+89v7WSfGmShQF8icH+jfdb6LpU//Vc8x2QqhNE+gCKLTxd5ATEoSHDN/U4rgQtrp
         94PaMdyXN+eZmQCqt5snvxNpXB756l8H1x3ncX+US2KcPl70YVpRtRiZAfMfH0Us9LUk
         ldTQ==
X-Gm-Message-State: AOJu0YxlBufFHjDJ51BZS6SlMqQ58NbcyaWe9I6cEIwHuX1X+I7c4Of4
	prwDMeLGfiqmzkXnFSYd8KL0NQ==
X-Google-Smtp-Source: AGHT+IFKPPF8r3m5BMDX5DFNv0M2Ii6euwt49/3tWDuQf1TJfXsX7mSig2AEFjsW0Ceh/6TAPaPTMA==
X-Received: by 2002:a05:6a20:8f05:b0:18c:6148:6a7b with SMTP id b5-20020a056a208f0500b0018c61486a7bmr20428611pzk.0.1701385766268;
        Thu, 30 Nov 2023 15:09:26 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id 3-20020a17090a000300b002850eb8b6dcsm2010297pja.44.2023.11.30.15.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 15:09:25 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 io-uring@vger.kernel.org, Keith Busch <kbusch@meta.com>
Cc: hch@lst.de, joshi.k@samsung.com, martin.petersen@oracle.com, 
 ming.lei@redhat.com, Keith Busch <kbusch@kernel.org>
In-Reply-To: <20231130215309.2923568-1-kbusch@meta.com>
References: <20231130215309.2923568-1-kbusch@meta.com>
Subject: Re: [PATCHv5 0/4] block integrity: directly map user space
 addresses
Message-Id: <170138576512.699292.6762410631511683338.b4-ty@kernel.dk>
Date: Thu, 30 Nov 2023 16:09:25 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-7edf1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231130_150931_645805_D0804106 
X-CRM114-Status: UNSURE (   7.38  )
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


On Thu, 30 Nov 2023 13:53:05 -0800, Keith Busch wrote:
> Handling passthrough metadata ("integrity") today introduces overhead
> and complications that we can avoid if we just map user space addresses
> directly. This patch series implements that, falling back to a kernel
> bounce buffer if necessary.
> 
> v4->v5:
> 
> [...]

Applied, thanks!

[1/4] block: bio-integrity: directly map user buffers
      commit: 5a0584b2c714a219296d97d9f4307ffe53c18937
[2/4] nvme: use bio_integrity_map_user
      commit: aec0ff70f016fdf7b4ba52e34d682a185dd8dd74
[3/4] iouring: remove IORING_URING_CMD_POLLED
      commit: f8243a30dc179ac197bd8315bdf9d55d3d7792c3
[4/4] io_uring: remove uring_cmd cookie
      commit: fb62c0c9b04265539851734ae35cf3f10651a8dd

Best regards,
-- 
Jens Axboe




