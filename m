Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13EACC88E41
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Sep 2026 06:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+BjoqHo0QynWJyv+c8A4+PUEN5brhXPIQlpmzw83mcU=; b=42a9nk9YmoMPQBcKLWx4J0mftp
	qGPf8cESLTmnuim7i3+yhnYMZ/yuashUpVSvpNZa3P59QVfcw0j4cm9TGxvR1bIzGKETNk2yoR+7W
	np2InoV6NuLEb74xUww7+LqpLOhEfIQgtIn27fIynZAV5nz4shxxtJmvikbnSOc7LnyatYbzc8Idh
	xCE21OFV+O71kExWw0uiq9Td9C07VT5JczqBz11nJ2/JVL9JIxyK0pC9lBKww+j30oXOKcCmEGBVj
	iWDZD26PBKpWYp3hmikItokjKwKKjmetf16NWtJ0AmXQmYdba8Fl2wfGjZr/sU6RKSRhVVHRJ6vVK
	BrFYESkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4uMQ-0000000Fuga-0Zqj;
	Fri, 11 Sep 2026 06:03:42 +0000
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4uMJ-0000000FugC-37Qd
	for linux-nvme@lists.infradead.org;
	Fri, 11 Sep 2026 06:03:36 +0000
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-6b35cc0a8c3so598720eaf.0
        for <linux-nvme@lists.infradead.org>; Thu, 10 Sep 2026 23:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1789106614; x=1789711414; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+BjoqHo0QynWJyv+c8A4+PUEN5brhXPIQlpmzw83mcU=;
        b=W/fd/YiuP3m2Q1RU4+Q/5HsPGmbyIcSWlmYWL6U6dkVMxSTYOrKj//wuaUHN2WLf9o
         FjZFqELAno7RPkVwLMx8pHZzSzybShACiZCZt+2xlnsyZfOUdjiDUd2XkGEpArU21Z0R
         vUmrUtEVQrZro07shncUsadEx9kZyZpFSeUU6LhljL/gIhbkgxHtvI/oIFmA6gEgJESO
         uS/DAPMZHC1S7naIhQ1G/aQYxono1cTLKN1IZfsg0UIrNTlg2Ddw3cjoMjiKiXtQo1cb
         OVdSNCqHiU+6NWpCNLWbW7aIHfQLLtVpm9Ni9i15Sm3i1GgyX0BUlatn1eyzR/L0PeMU
         2H7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789106614; x=1789711414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+BjoqHo0QynWJyv+c8A4+PUEN5brhXPIQlpmzw83mcU=;
        b=gqqhYuMG6j3gO4NVstF2YnCXAFVpIcTLyKtO1LFnzVOdjKLcuqDgR3qv/aPvXgSPe3
         kOkJyDeUeLjzu9XAMDHSyP19Xgn2h0T1YALeN12D8hwqgXe84ZgISzj0D67MvF2Fl8Yq
         wKo9N3Oq10rZ0dCkaGg+NdCEPhPg8Nu/U/0/o6I5yQcM8IKMrM49LBqty0hiDtxFmN0W
         0kW+9koZbfIps1HbCFog+tUY7vVchKh+OBW8+44vVJPVsq+RYrJ2F8aTJdsHE4qGjnno
         TShIjqOJxqHdlx8KcB28z1JkCQizQxT8afpegm598g4Mlei22STu7xO3fGJ2CQ2P04ON
         muhQ==
X-Forwarded-Encrypted: i=1; AKwUvBxd2MBE4fNlAdoVZW9uJR9x8YS0cRglS2ckIQ+0g4CpDgfIgIXEb9l16UgrKnoEySbj59yPb7wzp0Gz@lists.infradead.org
X-Gm-Message-State: AFuF++kC4icIVxkWGeiB+edJW8JBT/VSZqjlwp7rUmw38tu/+we/6DT7
	58bQTBH3GW5VPR3RRIn6t88nsVnXRXsLVfUu+Ik6jlD8vlWwVcIlEhh+42A6tNfo5LY=
X-Gm-Gg: AYBFou0lUBKPpJvLZCVBUTLhDk3AzZtJsLXquxXfLVoIGRUMWPLTtXCUYh/+v13dhzE
	ad2WIyAdtaw4H8/5RAGy7EamRThyNYh9hr/pKxT3wAX/LKBbPsuKJxA+daEFQ/+c/AsIPScfJ2j
	eIsJ08SVcWEW5o2gNFxyq81NcwBHisQCmgncj7KYOKoiaLUP3LmZNAhJ0Dm9dX5c1MOJ5LZmOXm
	XqGh7KDBdW6eWdxl5+V10RlRiyw10H0KSTqgCO2r+YD20ZXUnv49fXeh0fcXBXZ8EHjbPBYGp66
	Oyp3Et3w+QkvI2JI/ZjC4uu4bCwaRiSOjwr4tF9fgx7Ogod4C5oXL47GjZGmnXfyvYO3RvBLop6
	vN6/am+9nkzBCTaBTwIk4Kny//TUSRw5r/rutEOJYBHwEw8PUaOHO8a01aJeMrQBAU5yqGEz8uO
	Mzmxlt4ZuRIDLg9HtvuAEqqh2wvCi0jbSFuYC9Kz4Jf9+ZqdkxWxkEcTt8p/V1Tc9yuDVNdO2qB
	HVqqDsP6tkDSOn2z+ZsXAkaGPJxjUbdxahGQzBEYuzwDdcqk68rOA==
X-Received: by 2002:a05:6820:c3c8:b0:6b1:535a:eb8 with SMTP id 006d021491bc7-6c0ba245822mr1214669eaf.2.1789106613729;
        Thu, 10 Sep 2026 23:03:33 -0700 (PDT)
Received: from MBP-Saravanan-D.civet-hops.ts.net ([2601:647:4380:3400:61fa:b5a6:b380:6ce0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4fb3ddasm2965890eec.30.2026.09.10.23.03.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 10 Sep 2026 23:03:33 -0700 (PDT)
From: Saravanan D <saravanand@crusoe.ai>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Saravanan D <saravanand@crusoe.ai>,
	linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@kernel.dk>,
	Daniel Wagner <dwagner@suse.de>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] nvme-tcp: allow setting per-queue io_cpu through sysfs
Date: Thu, 10 Sep 2026 23:03:28 -0700
Message-ID: <20260911060330.59998-1-saravanand@crusoe.ai>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <8dfee10f-89f3-463b-8d16-587873c3394c@linux.ibm.com>
References: <20260909211432.6741-1-saravanand@crusoe.ai> <8dfee10f-89f3-463b-8d16-587873c3394c@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260910_230335_828638_C943AA12 
X-CRM114-Status: GOOD (  14.40  )
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

On Thu, 10 Sep 2026 13:55:59 +0530 Nilay Shroff <nilay@linux.ibm.com> wrote:
> I wonder if we should avoid introducing a transport-specific tcp_queues
> hierarchy here. io_cpu describes CPU placement of an NVMe I/O queue
> rather than something inherently specific to TCP, and other transports
> may have similar queue-level attributes in the future. Could we instead
> introduce a generic "queues/<qid>/" hierarchy under each NVMe
> controller, e.g.
>
>       /sys/class/nvme/nvmeX/queues/<qid>/
>
> and have transports expose queue-specific attributes there?

Thanks for your review.

A controller is backed by exactly one transport, so we can adopt the
transport-neutral /sys/class/nvme/nvmeX/queues/<qid>/ path with the
creation staying outside of core in nvme-tcp, which owns the queue
lifecycle. The core only knows ctrl->queue_count and never sees
individual queue lifecycle.

No other transport has queue attributes today, so a controller backed
by rdma will have no queues directory at all. The path appears only
where a transport populates it, and if another transport grows queue
attributes later, the creation can move into the core without any
ABI change.

> So could we expose this state through an additional read-only
> attribute alongside io_cpu, for example:
>
>      /sys/class/nvme/nvmeX/queues/<qid>/io_cpu
>      /sys/class/nvme/nvmeX/queues/<qid>/managed
>
> where "managed" indicates who currently owns the CPU placement. For
> example, "1" could indicate that io_cpu is driver-managed and "0"
> indicates it is managed by the control plane or user.

Agreed, I can add the read-only managed attribute, 1 when the io_cpu is
driver managed and 0 when the user assigned it in the next version.

Both suggestions look good to me. I will wait for Sagi or Keith to
weigh in before spinning v4.

Saravanan D.

