Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE158CCF9F8
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Nov 2025 15:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I3hgVPxvqQKN83gQ2kvBZd5VQbXv1Ml6JmbzYW4vBlk=; b=44UBN1KbheIFlcAa+G2vjY89AC
	1oqrLj/GZ7OASe+uts3KHKwE5i+6RUUVpVLIR2YpsY5pP1AA75iTAxoiNLLfuz5eAK2uCS3H/19xG
	WwsRHqZx+TDLbPgD+Wu7YWI1G95hhRJX3irvHhXFWB+MzGDzzPOuZ6ZwgFuQXtMa70lzvOn6do/pj
	e1TvKZn01vqR+EkDtf7j2r8VuD0nB5bJSExOh3Ssg/tGCYme4IeJRuRhwgnVUpe7Pab01g3hIg3Bq
	6yUhhuyBWjmBABlgd6Jg3fPpuyclDYUFs8eEbrI1RtRGuxkKwqQRdlsqWOO2I+6mRBVXQSdeQtDOa
	YFjAvmMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFwX6-0000000A9z0-2Oye;
	Mon, 03 Nov 2025 15:31:48 +0000
Received: from mail-io1-xd2d.google.com ([2607:f8b0:4864:20::d2d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFwX3-0000000A9y7-04yG
	for linux-nvme@lists.infradead.org;
	Mon, 03 Nov 2025 15:31:46 +0000
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-945a42fd465so193105739f.3
        for <linux-nvme@lists.infradead.org>; Mon, 03 Nov 2025 07:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1762183903; x=1762788703; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I3hgVPxvqQKN83gQ2kvBZd5VQbXv1Ml6JmbzYW4vBlk=;
        b=JfWbyjcPsMUkf3ZJUKwgD7MA5nRcC5/Yg3Dszz9puZ1DvbxARqQ0I0Mvkv/z+nWHNX
         /by3m6cHcT4Vxz28EG4m20HCEmgSJVFdOrcbudZ6IAVIJ1S29rAe0y+Jtse/58nluBS3
         i3KU7wAdQmbNSUCkZY7MB8MIl8MeOS4YdJZwryHP3+voEDc1SiqdIFJ7K0IThMdALi8/
         eM/I2f1yjuCJZ+dQIiqhmTY1GB50T1hgCJ1IWUN3qCDVm1OBg1g5GbxSm0Hg60OL9DtP
         hBBe4qf5MrsseKYWadfHqyu4n7Dl+9MGqXsylro7or1MVRM9ZmarSNaF4dTLptWEUKXd
         x9rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762183903; x=1762788703;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I3hgVPxvqQKN83gQ2kvBZd5VQbXv1Ml6JmbzYW4vBlk=;
        b=Pu37vrUR1drZyfP5JbwkSLUG7E71CHEnM45NnL0ktNRmSMz68RTG7psWr9OBHnqMQn
         hlX7949Twy6xFAxgR84wTgfYkt9fA8yskyKTaeRsNwNWGdgyOXqjWd1hCfo2w7KDPXUT
         L0g1Vl//MCE0DZzbCVOiEgPnHlKo0YeiI5y9RCMEWMwW/mwdYFmKUCuasURdqqhLn9sk
         YOMNDgSAEaGvs4HNzOsfV5sr6nvryKTcmc8tQvs3BejG776hXfxewYZnpECm66t4mWEl
         wNXz7YDOTh+DozcLVtQgVYpq+ELBavzDlHGVYauWPMe7YhYdIOFD+0BfhAykItWQnHoG
         tqXw==
X-Forwarded-Encrypted: i=1; AJvYcCUOg+hZ9uN9japVJCfxibmMbf96W3DFaPBHjqjcH7obHnH/4lNHimoY5skozoE9CyVzlXtSBH/nw0pU@lists.infradead.org
X-Gm-Message-State: AOJu0YytpqfRTbacMJAsaq/gl1f4k00p2HMrppQR2K/3gGAJkajBVWPg
	pMrmcuAivwwyvf1PptCJZCMpilyLH82MUWWKOKxBP0mm0lk70Je3FIbpmNwNRCnjQy4=
X-Gm-Gg: ASbGncvBj9D/2ge0KZNUxao0n+no6D3Mc6c19wt+ZDUNMI5tWrglVPAxCwdHIKFaI8a
	yyrM0znDCynV9kaMOkofzB4CpzT2UxwqnHXIoGvce5xUFEXxHBEpa2pMrBK1HOhvi9DhbU4MPxv
	uXrujmgNpdRd9DKIPJGjbYKe5KCFT7ssAu38GhfD/ARh5pbWdqh5R5L4ngpaQqBtqYoCXJtO9VS
	20nVyTYy27c96u3mwfd8uBob89PAKXAOgxXie/z6qRlXPCY+FVdQemhMBzwKodmCRdBTB9ialdj
	PpPhDK61LDWSNxcjsQged1/DcF1GUtdkzM1juZjidzpx5hvr25HRpauiF7bH9ywrI0nLDZQM+SV
	MF+NMeQwf/T22+zdLJdCME6YsJcjanGxpNc8XALSq/1rz0Z2o/kHh2qs/JWfme9GT2zz8z5Ed0I
	6ZUw==
X-Google-Smtp-Source: AGHT+IFTIBxUfn46sYZ6hbUJrbv86bqFQPF02qtQJk8t7o8hAHovGW6C2GZKwz2eeRA4AwfjgvTr9g==
X-Received: by 2002:a05:6e02:3110:b0:431:d093:758d with SMTP id e9e14a558f8ab-4330d1f5a08mr177643355ab.22.1762183903343;
        Mon, 03 Nov 2025 07:31:43 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-43335b5a92dsm2754945ab.28.2025.11.03.07.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 07:31:42 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Miklos Szeredi <miklos@szeredi.hu>, Ming Lei <ming.lei@redhat.com>, 
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chris Mason <clm@fb.com>, 
 David Sterba <dsterba@suse.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251031203430.3886957-1-csander@purestorage.com>
References: <20251031203430.3886957-1-csander@purestorage.com>
Subject: Re: [PATCH v4 0/3] io_uring/uring_cmd: avoid double indirect call
 in task work dispatch
Message-Id: <176218390170.6648.16490159252453601596.b4-ty@kernel.dk>
Date: Mon, 03 Nov 2025 08:31:41 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251103_073145_089070_6D7F9CCA 
X-CRM114-Status: UNSURE (   9.42  )
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


On Fri, 31 Oct 2025 14:34:27 -0600, Caleb Sander Mateos wrote:
> Define uring_cmd implementation callback functions to have the
> io_req_tw_func_t signature to avoid the additional indirect call and
> save 8 bytes in struct io_uring_cmd.
> 
> v4:
> - Rebase on "io_uring: unify task_work cancelation checks"
> - Small cleanup in io_fallback_req_func()
> - Avoid intermediate variables where IO_URING_CMD_TASK_WORK_ISSUE_FLAG
>   is only used once (Christoph)
> 
> [...]

Applied, thanks!

[1/3] io_uring: only call io_should_terminate_tw() once for ctx
      commit: 4531d165ee39edb315b42a4a43e29339fa068e51
[2/3] io_uring: add wrapper type for io_req_tw_func_t arg
      commit: c33e779aba6804778c1440192a8033a145ba588d
[3/3] io_uring/uring_cmd: avoid double indirect call in task work dispatch
      commit: 20fb3d05a34b55c8ec28ec3d3555e70c5bc0c72d

Best regards,
-- 
Jens Axboe




