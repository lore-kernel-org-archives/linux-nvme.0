Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C9DCC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 23 May 2022 08:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:From:MIME-Version:Date:Message-ID:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Jy6s8DEa5jSDvUdj8WBl45STs9nfFZM1IrmIzLolR84=; b=NJfPAd9Q4+Lc4GLHpH0jV81B12
	mHwWQEwnFGlufDhQlLsaIsJrtVttuU4rEqmF7s/Ote4FYFeTr1XNdzqnn92AZVVdZbgwKpsHxFu+L
	I54ILCfPjprp6rB9JGi+p7lSffko42OMjAeWxz/O1AwbatUWYpZvt13gYqMdoea0guNzAQL3xVRNv
	cyTvgInem96xecnNk7R7k0Mr/p6J9AmWTp8mOaJZVqbEKLj+hRztCjXtaQXxj0IzCE/S3GRXcMFXH
	ieBhiH5etBtZLcrORW0Iev8aIcj5vxMVJ0Ws+rQKki4NCtnoldivy0+hd9vfO7yCNkrd53cnzdxLq
	PWVbGjFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nt3YH-002UFH-UG; Mon, 23 May 2022 08:36:34 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nt327-002GHj-GN
 for linux-nvme@bombadil.infradead.org; Mon, 23 May 2022 08:03:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
 :Cc:To:Subject:From:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=Jy6s8DEa5jSDvUdj8WBl45STs9nfFZM1IrmIzLolR84=; b=CXDUvxLNz2iC6WAM5S/a79obek
 nrGhPGr+Os3EmZjY0l7RKELBgzPinDT2yEJ2MGYmvyuSm9+OXqHqkWvJC4JTls0nIF+/fVKT3Ux1V
 WUbDlkSDRy3VkktyivNNNMUQb5zSqS+r2Npx20QrG6JhjSf1jP5P3QRzFP+6gprV4JyqvT/H+8+KN
 0HxLPhA6kkWhSM2ePOAdgz19pmH5DuODxrfrNazrC4Xl8WhOVoQZkc0hxSyHqUk2sslVkQAroGJWE
 EKncBZF0LAban/6n6uoCy13BGurF53en03ToWvh8Jz29L/sP1kRZsvCEjN02W320J4BogBYtjGukB
 Ee3mAMYw==;
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nst7n-000dpr-7o
 for linux-nvme@lists.infradead.org; Sun, 22 May 2022 21:28:36 +0000
Received: by mail-pg1-x52d.google.com with SMTP id r71so12144941pgr.0
 for <linux-nvme@lists.infradead.org>; Sun, 22 May 2022 14:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:from:subject:to:cc
 :content-language:content-transfer-encoding;
 bh=Jy6s8DEa5jSDvUdj8WBl45STs9nfFZM1IrmIzLolR84=;
 b=XpzVcCFMPMRPF6AKPrdsazhWF0OuQNGHKGAKsGhp1RoEWhpTOOCLy1N+FU3EXosb8C
 bf0Y/oefnYB0Wmcb13ng0oWHEwKB83UN6AjBLUl2LYlwOWL6vhGP1yNjh5WHOD3Zhavb
 8nNtiop9Peq0RjHeRDksRtw8D74TaFEl2wv003O159oPYS/UFyanDBI3Q52i5pjHoSQM
 +qGCglb1BTjPSr87O7nG6BVclSB0fTUy2fT2xzYDSelRAUaExTVMtDrCJkbqitEh785p
 pAxidYrhJ3a/ytZUQLor5nLcbw0GhlFUYizgA9lyXYDaBSEr15GVKONvAKauZoqrf42c
 FhDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:from
 :subject:to:cc:content-language:content-transfer-encoding;
 bh=Jy6s8DEa5jSDvUdj8WBl45STs9nfFZM1IrmIzLolR84=;
 b=qUN7sV/WANkAyjVBFtQnR1bOFdGFGDfucbrr4eXS/NnNlN4BtQj0QvUkhkduNnJwxK
 vSRWe4+WTJ6KRvsifYEfX9AHliVKTU4yUwxiPf+8UP6nDYQwehyBA4uNv97kGLdoQ7Xy
 6icn8ssbaXMp+WtDIP48xM9HVWjILnZVPlOQhTQpwpahQlioUBALxaklV711PHlaL11g
 7TfQJ7tEslakrvyUe6NVyBVxDbAOZ7wDyvTZwcikVl2HUjaAG0wMLRvgZPREvyW5k/fy
 bkdGcG4WyeONNs/Nr7duxjgx5PKmYHAr6UkM2GOYRFH7dekw3/oUfQuSBb5zSDWc4AiJ
 SnXQ==
X-Gm-Message-State: AOAM532LZRjp/i9lqc+ai95XuCBjEa442UaPXPSnjwXmqIxgkmC+hVIj
 /ZdnHoWkz1BMXg8Ko03U1DxrPg==
X-Google-Smtp-Source: ABdhPJyhzDQhoqIrbgRSN/mIzZJF3J7wLyI50fM86fOei7NNuw/wBaY2mHUR4JFo1uTBnKhHnSi5hg==
X-Received: by 2002:a05:6a00:2442:b0:4fd:8b00:d2f with SMTP id
 d2-20020a056a00244200b004fd8b000d2fmr20545462pfj.39.1653254785023; 
 Sun, 22 May 2022 14:26:25 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
 by smtp.gmail.com with ESMTPSA id
 e11-20020a170902cf4b00b0015e8d4eb22csm3525249plg.118.2022.05.22.14.26.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 May 2022 14:26:24 -0700 (PDT)
Message-ID: <6f712c75-c849-ae89-d763-b2a18da52844@kernel.dk>
Date: Sun, 22 May 2022 15:26:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] io_uring passthrough support
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: io-uring <io-uring@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220522_222832_865611_277588CD 
X-CRM114-Status: GOOD (  15.33  )
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

Hi Linus,

On top of everything else, this adds support for passthrough for
io_uring. The initial feature for this is NVMe passthrough support,
which allows non-filesystem based IO commands and admin commands. To
support this, io_uring grows support for SQE and CQE members that are
twice as big, allowing to pass in a full NVMe command without having to
copy data around. And to complete with more than just a single 32-bit
value as the output.

This will cause a merge conflict as well, with the provided buffer
change from the core branch, and adding CQE32 support for NOP in this
branch. Resolution:

diff --cc fs/io_uring.c
index 1015dd49e7e5,c5a476e6c068..395d3a921b53
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@@ -4997,17 -5169,11 +5256,23 @@@ static int io_nop_prep(struct io_kiocb 
   */
  static int io_nop(struct io_kiocb *req, unsigned int issue_flags)
  {
++	unsigned int cflags;
 +	void __user *buf;
 +
 +	if (req->flags & REQ_F_BUFFER_SELECT) {
 +		size_t len = 1;
 +
 +		buf = io_buffer_select(req, &len, issue_flags);
 +		if (!buf)
 +			return -ENOBUFS;
 +	}
 +
- 	__io_req_complete(req, issue_flags, 0, io_put_kbuf(req, issue_flags));
++	cflags = io_put_kbuf(req, issue_flags);
+ 	if (!(req->ctx->flags & IORING_SETUP_CQE32))
 -		__io_req_complete(req, issue_flags, 0, 0);
++		__io_req_complete(req, issue_flags, 0, cflags);
+ 	else
 -		__io_req_complete32(req, issue_flags, 0, 0, req->nop.extra1,
 -					req->nop.extra2);
++		__io_req_complete32(req, issue_flags, 0, cflags,
++					req->nop.extra1, req->nop.extra2);
  	return 0;
  }
  

Please pull!


The following changes since commit 7ccba24d3bc084d891def1a6fea504e4cb327a8c:

  io_uring: don't clear req->kbuf when buffer selection is done (2022-05-09 06:29:06 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/for-5.19/io_uring-passthrough-2022-05-22

for you to fetch changes up to 3fe07bcd800d6e5e4e4263ca2564d69095c157bf:

  io_uring: cleanup handling of the two task_work lists (2022-05-21 09:17:05 -0600)

----------------------------------------------------------------
for-5.19/io_uring-passthrough-2022-05-22

----------------------------------------------------------------
Anuj Gupta (1):
      nvme: add vectored-io support for uring-cmd

Christoph Hellwig (1):
      nvme: refactor nvme_submit_user_cmd()

Jens Axboe (6):
      Merge branch 'for-5.19/io_uring' into for-5.19/io_uring-passthrough
      Merge branch 'for-5.19/io_uring-socket' into for-5.19/io_uring-passthrough
      io_uring: add support for 128-byte SQEs
      fs,io_uring: add infrastructure for uring-cmd
      block: wire-up support for passthrough plugging
      io_uring: cleanup handling of the two task_work lists

Kanchan Joshi (3):
      nvme: wire-up uring-cmd support for io-passthru on char-device.
      nvme: helper for uring-passthrough checks
      nvme: enable uring-passthrough for admin commands

Ming Lei (1):
      blk-mq: fix passthrough plugging

Stefan Roesch (12):
      io_uring: support CQE32 in io_uring_cqe
      io_uring: store add. return values for CQE32
      io_uring: change ring size calculation for CQE32
      io_uring: add CQE32 setup processing
      io_uring: add CQE32 completion processing
      io_uring: modify io_get_cqe for CQE32
      io_uring: flush completions for CQE32
      io_uring: overflow processing for CQE32
      io_uring: add tracing for additional CQE32 fields
      io_uring: support CQE32 in /proc info
      io_uring: enable CQE32
      io_uring: support CQE32 for nop operation

 block/blk-mq.c                  | 109 ++++----
 drivers/nvme/host/core.c        |   2 +
 drivers/nvme/host/ioctl.c       | 278 +++++++++++++++++++-
 drivers/nvme/host/multipath.c   |   1 +
 drivers/nvme/host/nvme.h        |   5 +
 fs/io_uring.c                   | 444 ++++++++++++++++++++++++++------
 include/linux/fs.h              |   2 +
 include/linux/io_uring.h        |  33 +++
 include/trace/events/io_uring.h |  18 +-
 include/uapi/linux/io_uring.h   |  24 +-
 include/uapi/linux/nvme_ioctl.h |  28 ++
 11 files changed, 806 insertions(+), 138 deletions(-)

-- 
Jens Axboe


