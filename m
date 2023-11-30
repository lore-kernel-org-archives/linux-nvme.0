Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08CDBC4167B
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Nov 2023 07:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b40oxQ+wmHnSlp41pNqOqa3g1K/uTJG2aa8xGLZb6s0=; b=zFje4ih3cdYJXQcq0sqIrZUP66
	2fJ6fgj4FvQNIHW/2gEuwVMBoBEvVBo6bTjE/Gs5uZHhnd8SUaapRYnrOUoJkpfQxTxgaFK9/Q0o3
	viEiqttSKvUISGjHV8N9AhEl1UQ943xRNKRYbKYVGBUlodH19OfO18GKAJBGQs8F+x/nr4Lp3Y1of
	xTdfEC8Y70j/ypaJfS0/tBUHHPsKHGCqMDbP9806KdwEwLtNvAYgHTjdZz9LJsx4RELO6Bcq5i8lO
	MuUGiQD42nM1htEBmJkDk+GTKAq4JH+9WQAdXMAvv6V5OKF9B9CwLxfppINWa2XXSfgz8zju6bdN1
	j+PCkwsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r8b8p-00A3vA-03;
	Thu, 30 Nov 2023 07:07:19 +0000
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r8b8m-00A3ul-1J
	for linux-nvme@lists.infradead.org;
	Thu, 30 Nov 2023 07:07:17 +0000
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-332e40315bdso412425f8f.1
        for <linux-nvme@lists.infradead.org>; Wed, 29 Nov 2023 23:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701328033; x=1701932833; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b40oxQ+wmHnSlp41pNqOqa3g1K/uTJG2aa8xGLZb6s0=;
        b=DuUo25BKGPc1hofScPWaFVmF+JVrN1ymXZX/GI0Aj80bLwwF33eoBgfNU59mcf7oUR
         OgQlGt3yJeoi61Vajq7rAsrwNg5xoqm4Es7PeaevNy8MCDXfKmiaxQYewo9GHNJGSIlN
         jv/SKw9oMZF+71+3FJW4H/RTvfZT9Maco2jvadeLbZEjEFHElqyG8oklRXgfxgXskOdk
         xPQExA1TwqCn3BUb420I3IR1LcpGP6Gcmu05uhqQS6xHDJBZUp3ItuI8S2QVvshmPpOs
         C/6xJN3foX6sM4XkEt9FcUInXX9QafKu73M2EDYk1GkSLYdQ0tiNxPpQgklIB6PJfa2T
         Bl6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701328033; x=1701932833;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b40oxQ+wmHnSlp41pNqOqa3g1K/uTJG2aa8xGLZb6s0=;
        b=UtuWrm3lp44S/5jN/4fH/+G0G9idmiZcoiB4EHCmv0x61l4imKVtlz+ICZpLmWawFG
         YPrGhS8W7FWswOa0k3lnQd2lov7E/ctu3qyXYG67owy2V1ZDStXO6b65zD8nkwfGCGp6
         0LuWMrkSfprx5oqgHPPiglc3WIFhO2xJhcA48RSRrIlW3I6aMEpZZPxABpickeBS7A/Z
         8BHh0elRZ4NiJmGkDAiU2PgKHBcg1G6CGkdTGhuC6JMekcamEV59BaKv0x5Qor1wKbyu
         K3L0dCyccFM72mQ7BA/As7G9Q6beDdnw8+XzR0h/wU4/q4Fpj9E6kvs9fh4g+frTqbUG
         vgAg==
X-Gm-Message-State: AOJu0YweVWl4smnG7sRylRLSXw4eiL40aE13nSomjUDMg54WhvirepE7
	YxQYmBlX2pMe1mpGTBXCCZa6Lg==
X-Google-Smtp-Source: AGHT+IFMC/oISgA6XE2T/E0Kbo4/fdoMZnlzwwiV0IXTByHlCrphi5wYAZzs7gYuX7enrHIzViEzBg==
X-Received: by 2002:a5d:480b:0:b0:332:f83b:e5e with SMTP id l11-20020a5d480b000000b00332f83b0e5emr11415160wrq.9.1701328033317;
        Wed, 29 Nov 2023 23:07:13 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id o17-20020a5d4751000000b00332f82265b7sm649576wrs.20.2023.11.29.23.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 23:07:12 -0800 (PST)
Date: Thu, 30 Nov 2023 10:07:08 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>, error27@gmail.com,
	gost.dev@samsung.com, nitheshshetty@gmail.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] nvme: Update type from size_t to u16 for
 opts->queue_size
Message-ID: <74306015-9e99-4703-b578-1d235dc725d5@suswa.mountain>
References: <CGME20231128123622epcas5p4940679fbbafdf0da802deea3e531f850@epcas5p4.samsung.com>
 <20231128122958.2235-1-nj.shetty@samsung.com>
 <0cd6862e-8037-40b3-9fde-b7f10d66e31c@suswa.mountain>
 <20231129104837.arls2gn3wttiqiff@green245>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129104837.arls2gn3wttiqiff@green245>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231129_230716_469448_C1F0FA2E 
X-CRM114-Status: GOOD (  16.61  )
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

On Wed, Nov 29, 2023 at 04:18:37PM +0530, Nitesh Shetty wrote:
> Thank you for this insight.
> I ran smatch on complete kernel using smatch's test_kernel.sh
> I was unaware of this smbd.py option. I will explore this.

The ./smatch_scripts/build_kernel_data.sh command creates the cross
function db.  It takes a while though.  And it's probably better to
run it a few times because every time you run it the call tree chains
get one call longer.  I run it every night against the latest
linux-next.

> Meanwhile I feel this patch is still relevant, as it aligns opts
> queue_size with size of ctrl queue_size.

I don't have an opinion on this.

regards,
dan carpenter



