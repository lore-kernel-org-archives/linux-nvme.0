Return-Path: <SRS0=Nmvj=PI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC030C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Oct 2021 00:28:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF30F610E6
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Oct 2021 00:28:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AF30F610E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NCBYMmyWBTij8GrA0rmTzTTz81qB2hbsuZq37PhU+Ps=; b=zjz3Y3ctCzKkVTmRRu4kkgagKe
	1bt91NueX3yrXRnhLRH50goJe7dGiTtgi8XqBwTvHXdMoi4VNNZAeo8n0cm20b8/lKyI5AuuaETAi
	R+q8R5fP47uorAUxQqoaa71R8dqWV7Alk5wVtkGYF4JUnZrCjBljBbRXox4Lv6xn3S53GSE+buxo5
	n7AgGMBso/52s+Ur9gIhWI5YDVWozLwgLy+NTe3fpyN4Jzlm4f9xQZizElUjzjtCoMZhR4s6iU1Wm
	RA6Cpk/nInkTebwnFHvsHeEaO1419cVQvwA8700A3qi5EeS39OWKc3lVASqye7xXceXu+BTgAjTL4
	XgJLjGBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mczSz-00340q-Ek; Wed, 20 Oct 2021 00:28:25 +0000
Received: from mail-io1-xd31.google.com ([2607:f8b0:4864:20::d31])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mczSw-0033zo-Jt
 for linux-nvme@lists.infradead.org; Wed, 20 Oct 2021 00:28:24 +0000
Received: by mail-io1-xd31.google.com with SMTP id r134so22497569iod.11
 for <linux-nvme@lists.infradead.org>; Tue, 19 Oct 2021 17:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NCBYMmyWBTij8GrA0rmTzTTz81qB2hbsuZq37PhU+Ps=;
 b=8WHvWN4/ehC9bK0jRL/5g7a4EweYQ+d+pYmkPI4eZJSXgPJTJnQrUoRFPak8lhkY0m
 iztNqBcWXQJUvreARYLVWq9CHQXBBsLJk2BeayLgVCRnh9+JgJglYC2HUb09zujR3VL+
 NquDQPIHQ4jtGl+j7mB5O+Otl6aTuxoFOXHoWvmqVpEeekf1KGAIa+0kwbH4BFAFcQS4
 HI2LARMTs6JKC3QX5LmXtq+4LP8qgXe1K/C/MqI9+1bnr8erEay6CkI54CvYzc7dMHpm
 qGNxLfB04J33HjubZr4ECsN3tqyW8nL6VwubEpbhSMR5ghNC8nzS2sF64lZk/B44PhNQ
 jcLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NCBYMmyWBTij8GrA0rmTzTTz81qB2hbsuZq37PhU+Ps=;
 b=e7zqtOJ8wQpJOuXprft1D2WUfjIV1cgR5D3eNcD9CXfUmAsMOqmIgglarYWtDtbG2k
 eE64f0TKq/cP4WMVMnpZACO1LNItMJ0cfQPwxVHx9p4Hl0gOaS8iGONrtYv51TbHv5u8
 NsTizG4DNqeUn3nFSVZtpWVrlq9Fp0A7L6JENGVhAKHJT7xuVNoEP8kDMA+jysznrtXJ
 rzzT92wn85Zu2w4A6Fy+UqXdcvgzgN++ydSd2eiwaCy31LEXaEKJkfI96DJV7Njinwqn
 CnFl6IzoyEnUC7SMSkbvHwcwO88tH37yef9l/0jij5oFdvVTLouN8GtiQvYTIWmLigbv
 VRPg==
X-Gm-Message-State: AOAM533mnc7wez0SE1ev7Hr0WFaZXPsAkkVXBl5HHyEBSU2dsAArimx8
 +FBUnWXxjsun/0M3ceRNi9Uu4w==
X-Google-Smtp-Source: ABdhPJyD0OAkDNxgyLxgJIgP7vJUdUIKldS2Up83evAkUunJNwIi0L7HMaS/NJxD13OEo7rUHpSy7A==
X-Received: by 2002:a05:6638:3396:: with SMTP id
 h22mr6462578jav.13.1634689701009; 
 Tue, 19 Oct 2021 17:28:21 -0700 (PDT)
Received: from localhost.localdomain ([66.219.217.159])
 by smtp.gmail.com with ESMTPSA id l9sm340155ilh.19.2021.10.19.17.28.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Oct 2021 17:28:20 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org
Cc: Jens Axboe <axboe@kernel.dk>, Yu Kuai <yukuai3@huawei.com>,
 Keith Busch <kbusch@kernel.org>, Bart Van Assche <bvanassche@acm.org>,
 Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH V4 0/6] blk-mq: support concurrent queue quiescing
Date: Tue, 19 Oct 2021 18:28:16 -0600
Message-Id: <163468969358.719012.15754644754744739872.b4-ty@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211014081710.1871747-1-ming.lei@redhat.com>
References: <20211014081710.1871747-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211019_172822_682624_24B9B900 
X-CRM114-Status: GOOD (  11.91  )
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

On Thu, 14 Oct 2021 16:17:04 +0800, Ming Lei wrote:
> request queue quiescing has been applied in lots of block drivers and
> block core from different/un-related code paths. So far, both quiesce
> and unquiesce changes the queue state unconditionally. This way has
> caused trouble, such as, driver is quiescing queue for its own purpose,
> however block core's queue quiesce may come because of elevator switch,
> updating nr_requests or other queue attributes, then un-expected
> unquiesce may come too early.
> 
> [...]

Applied, thanks!

[1/6] nvme: add APIs for stopping/starting admin queue
      commit: a277654bafb51fb8b4cf23550f15926bb02536f4
[2/6] nvme: apply nvme API to quiesce/unquiesce admin queue
      commit: 6ca1d9027e0d9ce5604a3e28de89456a76138034
[3/6] nvme: prepare for pairing quiescing and unquiescing
      commit: ebc9b95260151d966728cf0063b3b4e465f934d9
[4/6] nvme: paring quiesce/unquiesce
      commit: 9e6a6b1212100148c109675e003369e3e219dbd9
[5/6] nvme: loop: clear NVME_CTRL_ADMIN_Q_STOPPED after admin queue is reallocated
      commit: 1d35d519d8bf224ccdb43f9a235b8bda2d6d453c
[6/6] blk-mq: support concurrent queue quiesce/unquiesce
      commit: e70feb8b3e6886c525c88943b5f1508d02f5a683

Best regards,
-- 
Jens Axboe



