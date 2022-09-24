Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79041C07E9D
	for <linux-nvme@archiver.kernel.org>; Sat, 24 Sep 2022 15:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qYvrAhig9F+unAPbd1/716L+dnUCLnsOlccNkw3UIUE=; b=u5cRF1JlR1NHvy9Lo9ZKxJAkM+
	sNOfAG8uEfECMg1qKGOra1GyfC0wBGynxBZ6Qmy2BtIVnSJZ1OWMdKYo/hAdjZQ/YiyI0UQwMKBIn
	cVQH5mRsX72No5dKHfWBCkVy3DuFzsRjr2i60JGV6fAsiUwFZuuE5jp6sZC5XfipsZ+nU1TfUSlZH
	MeHU16Q3BXxc92rZ0xkpPcSxBhTLAu0MHRPFR/Juphkf62baLCm7YhS+6rjFy/aKfUkULf9T83IMd
	CQNZMUmRB9ar5UFHD2HWBV39qq6nRJcPLgpGLzInDK+XocRPod5IhhBEsDGx2mvMt48PpmwD2RPaV
	Y/6R683g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oc6gq-007WWs-IK; Sat, 24 Sep 2022 15:03:36 +0000
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oc6gn-007WW0-0c
	for linux-nvme@lists.infradead.org; Sat, 24 Sep 2022 15:03:34 +0000
Received: by mail-pj1-x102a.google.com with SMTP id q9-20020a17090a178900b0020265d92ae3so8537132pja.5
        for <linux-nvme@lists.infradead.org>; Sat, 24 Sep 2022 08:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date;
        bh=qYvrAhig9F+unAPbd1/716L+dnUCLnsOlccNkw3UIUE=;
        b=6sjPQqTHqh7TGwi+KhrasovGQqG7CjZ0zXuHfDLtmqEv/w9/By8iRWQA3HuTVh0rbo
         KkWaTY5mlB69ECJA1ZUr5HtH1Z5LS6U24HxJ/7WXnD47J9uAHa7fDDzOwbFfIKB6Nxju
         mT8bYVXg4xhEc+GUMiQk7wicaBjUt4nNeyzsvtLuU73suBz34sGRutkufdjT/g6wRqta
         X9SZH6oMKVrYjX5o4idOfKK+uh5+vqQqEIs+9/lm9BmV3CecbBqNCIxVwFsSYP7/bohr
         WyFLI0zho83xlrJsREkNCy/3wPC2K3iBZTOLN2rQpczFUe4CcYNXIRyMAVOBIV4HZc6G
         CChw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=qYvrAhig9F+unAPbd1/716L+dnUCLnsOlccNkw3UIUE=;
        b=1pePTPiZl8u+yeHjXLQ/9VALi61Sxonzhjvt4mENmhurklplX/XFRbh4l4vrhEiiXI
         HG/kth73/0KR+EWWls7rRbINdW2uricP35sTYtHdp3A5qbJtTa9R95lmUk+RRxbbTMit
         ayZph1Si84mf+IDcbQSMm8vVFaiccSApw9N+mJ4Tnee1rXOqmlB6SCZP7MI8IBdXkRSL
         WpZtfxZwIcLi1Z/qtwRzQQlYc2lHaLo53fS4LeML3zZrsJiXpC/tRKR3Pz6OAoRYSPVE
         Bwg9hXZhiKU0/D4ApNkZH4ldK8N/zkG0pS+GRv3zEehwYFI78fOFa001mA2S34V5VZ3j
         TigQ==
X-Gm-Message-State: ACrzQf2mTPfjfCj/OYS5QHWhkYA8iiRiimcCQpbSrhTh2Ao5Ls7k1+5S
	iuT8TtgWcEjM+VMp8yRA8sRqGg==
X-Google-Smtp-Source: AMsMyM77oFWrzITHf0GXE3CUYxCjbosxOWcz9VPKexh2E83ai54BK/cGR4Crh9dFP6BT+CnPGPp3Yw==
X-Received: by 2002:a17:90a:e60d:b0:201:6b28:5406 with SMTP id j13-20020a17090ae60d00b002016b285406mr26532669pjy.228.1664031811263;
        Sat, 24 Sep 2022 08:03:31 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id b15-20020a170902650f00b00174f7d107c8sm141790plk.293.2022.09.24.08.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 08:03:30 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Liu Song <liusong@linux.alibaba.com>
Cc: hch@lst.de, sagi@grimberg.me, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, kbusch@kernel.org
In-Reply-To: <1663731123-81536-1-git-send-email-liusong@linux.alibaba.com>
References:  <894e18a4-4504-df48-6429-a04c222ca064@kernel.dk> <1663731123-81536-1-git-send-email-liusong@linux.alibaba.com>
Subject: Re: [RFC PATCH] blk-mq: hctx has only one ctx mapping is no need to redirect the completion
Message-Id: <166403181034.5940.4446452471783801931.b4-ty@kernel.dk>
Date: Sat, 24 Sep 2022 09:03:30 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-355bd
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220924_080333_070546_0A980A25 
X-CRM114-Status: UNSURE (   8.19  )
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

On Wed, 21 Sep 2022 11:32:03 +0800, Liu Song wrote:
> From: Liu Song <liusong@linux.alibaba.com>
> 
> High-performance NVMe devices usually support a large hw queue, which
> ensures a 1:1 mapping of hctx and ctx. In this case there will be no
> remote request, so we don't need to care about it.
> 
> 
> [...]

Applied, thanks!

[1/1] blk-mq: hctx has only one ctx mapping is no need to redirect the completion
      commit: f168420c62e7a106961f2489a89f6ade84fe3f27

Best regards,
-- 
Jens Axboe



