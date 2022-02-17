Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B198C433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Feb 2022 13:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Zo8tZz0dQI0lIkkvs+bcvl1kwCXKp/TLbDK3P6lafec=; b=qCHhaK6UA8oBDuOzo6Oqox9bk3
	cjfJa+p74Sn9mCwS6tIL4tgqdDPxjqylKbHy2lAbagEryo7R/9OK5zHGHZI0Kb5CSzAqXi1Kjwl4b
	d0+iUpR4QoCsnLP3QrrIw6z/y+Nl8Dthl6pHnxyJ3Nml65HWU6jKEcWvQKTFLmJwAf4+mE8gSDG+w
	v3ERrlE0uTSH9lmt+mEhExlEVPQVozCREa/1pcgFJTfP6I8DRkxCPmrnSUlSSlUn3+kCMWXwdwPg5
	74u4z6LXhLClkqby1J/xxXg5/SJKAdSW3MZGP6HgIgBs/fmUgZKgsidstoqcAql8TOQtQ3J4d49Eu
	as16C28A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nKh6t-00AikY-W0; Thu, 17 Feb 2022 13:46:16 +0000
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nKh5Q-00AhwD-Vi
 for linux-nvme@lists.infradead.org; Thu, 17 Feb 2022 13:44:46 +0000
Received: by mail-pj1-x102a.google.com with SMTP id v4so5619317pjh.2
 for <linux-nvme@lists.infradead.org>; Thu, 17 Feb 2022 05:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:in-reply-to:references:subject:message-id:date
 :mime-version:content-transfer-encoding;
 bh=Zo8tZz0dQI0lIkkvs+bcvl1kwCXKp/TLbDK3P6lafec=;
 b=Bj9881Ghb45ibpMfXVA7QkFyY1LibxlCn0fjA4JW4jbtxsObNYNmfIa6XKklDItJLU
 Q5eK+BZs+E9EtR/BES/MfVFQJEv3Gd0ziS3PmNjncLKhwX77UeOh1KQVqoSsvni0dkDV
 fydoC4g5GgklE/jnY1er/YYfveRgveCD4Sg1//HQyy6HAIXMcPtnhisOeXn2Qb28Q54W
 vSyovcTP8KN19d1FrhDwLti5XXzsedIvXO5Hm9JZs3+8MvSKUsZ/wc+3cytW+mHsNss/
 W+K2/cyTL8xuER4fP5g60lp6Ti4lZP6DCZ7i1NNen4m/MSxKwGRFSFB1GPs/JB2RuWbC
 pajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
 :message-id:date:mime-version:content-transfer-encoding;
 bh=Zo8tZz0dQI0lIkkvs+bcvl1kwCXKp/TLbDK3P6lafec=;
 b=dSdnn5jC6p6HfvwbYgkXQgCfOYkCZIJF/K8U/QCvyzkQuMDmXWSHgJYB9TaNdTiv66
 P38MfttemNClYpkcfDsF4I2u9h9LlfE9O9nNIMhajLoMsU9PcbygafO0qhl88Ni8tQzV
 m4AauKL5uOVTS9AmrENzGT4q8AlMH550XqFNW7lhPUNCiRhdxc7nzDop1sCLTQgUyrPV
 OFzchAA+Rq8o8LUZKeCvj46jMycqvEXDKy7S2aBpvRhVPabXvAGbxOILWco7qDd69Obx
 Ryp2Mghmwtnt0Qwnbr4+KJnB3tueFNS4+nKPb/jf7CGwZrvBeE8KkWXA3eEeisCEoNwe
 VGJQ==
X-Gm-Message-State: AOAM531KRSMG3PS65WhjS6t2u/6cjzjwzV6x1qDkh0YDNz/oyiekTOtz
 Nqkz+7RKxd1/rdMrlpmD94J2Lw==
X-Google-Smtp-Source: ABdhPJxMU7lcTYigsQf8wyx8/5dPGMnNfX0sEb9TJg2xhS0OA/uD2BXKHtEXxv4dRCSGk5+0GO/Tjg==
X-Received: by 2002:a17:902:f605:b0:14d:bd53:e2cd with SMTP id
 n5-20020a170902f60500b0014dbd53e2cdmr2972758plg.164.1645105483015; 
 Thu, 17 Feb 2022 05:44:43 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
 by smtp.gmail.com with ESMTPSA id il14sm2043781pjb.18.2022.02.17.05.44.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Feb 2022 05:44:42 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, markus.bloechl@ipetronik.com,
 linux-nvme@lists.infradead.org, kbusch@kernel.org
In-Reply-To: <20220217075231.1140-1-hch@lst.de>
References: <20220217075231.1140-1-hch@lst.de>
Subject: Re: [PATCH v2] block: fix surprise removal for drivers calling
 blk_set_queue_dying
Message-Id: <164510548193.7592.4301337271554848551.b4-ty@kernel.dk>
Date: Thu, 17 Feb 2022 06:44:41 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220217_054445_096505_BE503FFE 
X-CRM114-Status: GOOD (  10.04  )
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

On Thu, 17 Feb 2022 08:52:31 +0100, Christoph Hellwig wrote:
> Various block drivers call blk_set_queue_dying to mark a disk as dead due
> to surprise removal events, but since commit 8e141f9eb803 that doesn't
> work given that the GD_DEAD flag needs to be set to stop I/O.
> 
> Replace the driver calls to blk_set_queue_dying with a new (and properly
> documented) blk_mark_disk_dead API, and fold blk_set_queue_dying into the
> only remaining caller.
> 
> [...]

Applied, thanks!

[1/1] block: fix surprise removal for drivers calling blk_set_queue_dying
      commit: 73af72f93af41cd280423579c4ef9e8100c5edb4

Best regards,
-- 
Jens Axboe



