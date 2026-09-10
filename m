Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B6CC88E41
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Sep 2026 20:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7BgPIv1ZQw0ml091p4qej1j/5Et1QAUdr/a/BWY2itQ=; b=cZM1N5fHY8ZwJrVh5Tr3kV6ZZz
	PICPXKKpPt9XSy3xXpperKFrYcqRadX9PzV7jc6UVyowaccvaPwDZnCrq7xNWjj7iKCZrSclf9BtG
	70oLaBdKGKduayBmo46NXeM686ZmJzVAeLpSrYJqFdjrPrH81yMhFlnQ70So9+LDkqRyajdXztdlo
	v4USYinn/QSOtzIZIKgPk7wqlxC/+X8HpFs3b/BY9MpcFLQETwMtrcTxCZf7yTRUNz9+/gInW1Z2p
	N/jm6SIHvnpZJGTTIC/LdGMhyu137/wq3IssvGZb8KfMikBQIIh+nZ5VRbRUmTT2ns8ow3mrRg/ac
	WKHt2vsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4lny-0000000FNYK-1DLD;
	Thu, 10 Sep 2026 20:55:34 +0000
Received: from mail-oo2-x0f.google.com ([2607:f8b0:4864:31::f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4lnw-0000000FNXV-2Lv7
	for linux-nvme@lists.infradead.org;
	Thu, 10 Sep 2026 20:55:33 +0000
Received: by mail-oo2-x0f.google.com with SMTP id 46e09a7af769-7f4f0c89e34so170393a34.1
        for <linux-nvme@lists.infradead.org>; Thu, 10 Sep 2026 13:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1789073731; x=1789678531; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7BgPIv1ZQw0ml091p4qej1j/5Et1QAUdr/a/BWY2itQ=;
        b=GERfgXyVJungJ2p23rcISn97PdSKSVMWq9DoZw3yezw+WLWkcPbHLbP9w7aPCxPzI4
         xVND5emFdQYoL4xorFRpHlTYw96ah0suA+WRVYf6tyH7aMzJ6wVP2ko/Tj85Fv8P+qHF
         s83son9Pa4zUbU12qKkqDDZcJut+kjF40T7M321aixQ3B0aUAFNmpGfT1fv8tObtw9EW
         1aFWPG/BjVbmlTBlczvhKpVsP63N1NzWNFZyjAMP2fBUCO19UuwaL0eCWX+ACvCmN75M
         0Dj3WBWVvlt1qb1SPmVsrkUhcs4iwdO13yqWR/e7Zul5cP0Wky3clX6ZlPsGU8BIYTFa
         ipzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789073731; x=1789678531;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7BgPIv1ZQw0ml091p4qej1j/5Et1QAUdr/a/BWY2itQ=;
        b=W4q3h+bn+juhceqEmRoOvA7dPAWo0qs4ecAix22nXc6iKvgRsdRLrL1aKE29OvmfJO
         Khvqhuurnom8R9a4q/AJ0hLXqMEONnYYy1Gjna4Fi7AMKYjWRpkOru3g9ihMc9Ep1XsQ
         FVySlSq0DV5kSHwbZOeYpHKXiaLWiMnXlneN7Mw8DnVe2CyWzk+iFOZo51Vd4aR2+yii
         lVnSsSeGAFroEtS6EtP4mk0feZdT5PRQkfKxnHz8p/OvKJ5e4BFAIxsxndsDjmuGXl5t
         qDJZX2Mr6d1iEfpuTZpNH1ICvN1WMp1wkRDd2MFhwo9DbWJUEeb28dDUiuyLBLAZABbe
         BvOA==
X-Forwarded-Encrypted: i=1; AKwUvBztySQIFivuDJCTLw1T6gBUtb0f+Y6YY1AbGSBXiryREqrVOygGtkXyqGSHExtIKEUX8Lx1E+E1lyWZ@lists.infradead.org
X-Gm-Message-State: AFuF++l93lONMzyWMxd8/uXegoof2b8fz9WkWZcNnMsrUsJRPumFBkfU
	7ImqGwVD4M/o5mcMuAP99jpT7wb2K0RYJjMCUb+0Tz7khbOBnJpEwdnpDcXgp83RL7k=
X-Gm-Gg: AYBFou1gXqdeEGrn5wSRDTUj1prwPtWR3PGg2gNLrLZjY6sQb8PAzI43osd5doPk7Xx
	+1V7S4ATLeHTT3Yn1fkfFHE3p/opwxlRRpEdMCv8PAXjPOS5RSwIWE2NCO/P8tZWBg9Ly9LtLLX
	GZHJuxzqEoTlM3IP35mbJqxOUd30MvPF0Sfv87CpnKBMpz//FMhdIImNXtVP7MHsZs8gJypHoGo
	4iinCvs7Kn5xEFhyBxyv2YYDGTvYEL84R7OwyJWojv2wpBWAQAvGpSu9Btg3QmVaGk/YxdMOpyg
	Ky0lBEeQ/orIIeFl31aNYoPvVDxpiVaThkjc8Os5VZ9zwTZdMEV+OjmgcuVxGgN8DpCiByXeQ10
	izEBZyQ4Sec+wKyEoOxu5WFBI7EFXuD2B+9P1Pqd0MwF1l4Lq2ntLiyZKpV94g3C38Zriabz2e8
	z+XWqSA/k22jRffdGRWsjPNUm/dSzvTplPmvn6M+nRU+cKFdoE5v07jWHVJ1amgxb0mRkEZXzy5
	j9j4h0/YC+lbp5qKRN2L7GKA8gqBV3n4hID3xkIhpYGNWoJ6RM=
X-Received: by 2002:a05:6830:67d1:b0:803:3878:bf59 with SMTP id 46e09a7af769-804001c3c9fmr433555a34.13.1789073731594;
        Thu, 10 Sep 2026 13:55:31 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-803f60fe54asm635779a34.15.2026.09.10.13.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 13:55:30 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: Joanne Koong <joannelkoong@gmail.com>, Ming Lei <tom.leiming@gmail.com>, 
 io-uring@vger.kernel.org, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260909155848.2069290-1-csander@purestorage.com>
References: <20260909155848.2069290-1-csander@purestorage.com>
Subject: Re: [PATCH v3 0/3] io_uring passthru: set result on blk-mq request
 completion
Message-Id: <178907373014.484803.6342081621851413599.b4-ty@b4>
Date: Thu, 10 Sep 2026 14:55:30 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260910_135532_630021_EEE16FBE 
X-CRM114-Status: GOOD (  11.32  )
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


On Wed, 09 Sep 2026 09:58:45 -0600, Caleb Sander Mateos wrote:
> io_uring NVMe passthru currently receives the NVMe status and result in
> the blk-mq request completion callback nvme_uring_cmd_end_io() but
> doesn't post the io_uring CQE until the io_uring task work callback
> nvme_uring_task_cb(). The status and result must be plumbed through
> struct nvme_uring_cmd_pdu, taking up 16 bytes of the 32 available.
> 
> Store the status and result on the io_uring request in
> nvme_uring_cmd_end_io() instead of nvme_uring_task_cb() so it doesn't
> need to be passed through struct nvme_uring_cmd_pdu.
> 
> [...]

Applied, thanks!

[1/3] io_uring: move req_set_*() to public header
      commit: 7acb6aa7916023e072eadb9e45e34a4b3f5801bb
[2/3] io_uring/cmd: split io_uring_cmd_set_res() from io_uring_cmd_done()
      commit: c54cf3476674a6a01c61da85fa32aee9f07c0741
[3/3] nvme/ioctl: call io_uring_cmd_set_res32() in ->end_io()
      commit: 11773ae6da9c9d92f5d1def78f7e70a9f1fa7b1c

Best regards,
-- 
Jens Axboe




