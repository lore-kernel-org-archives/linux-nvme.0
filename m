Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEB760A263D
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2026 11:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Ug36Hrb2;
	dkim=pass (2048-bit key) header.d=crusoe.ai header.i=@crusoe.ai header.a=rsa-sha256 header.s=google header.b=DazflF/n
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=ko4mREqmDAZGw+P8OhAmIBygelpZYVgRRe6KEoxcY3E=; b=Ug36Hrb2+weKUb
	Ll6uKfz6dTeWRd1DBSXLLLUJpTWI4nc7nqqhntja79LrA6H3XrFSWVO5YiRdj+5kegZdy9wSRgEhS
	drENdO0m184WLUHiZLeD1pNhAOa0dFwT2rdR5VQGTEtEJZESEalFRESMbKTrSFB5F4BeOeZoXgpr2
	tcCnkiG777CuQ4y3lCQKMSXV01sKHBrZCw9MQ5UowLdxv+5VSouXTB8F8UCYt7XO1+a8ZJz0ovBD+
	YjFRXmk9/mAoF3RRhXPT+izrRxgbk7OeT8Gp+B+a7IPBFVTpxcU4sf65TqIPgyTH3CkA1zeOBIYKS
	SyLl7ooqzfhjdcr1NVIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQkMj-00000003hBC-28UO;
	Tue, 10 Nov 2026 11:50:17 +0000
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQkMa-00000003gyq-1RM9
	for linux-nvme@lists.infradead.org;
	Tue, 10 Nov 2026 11:50:13 +0000
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-4a1b07c3c5fso18594115e9.1
        for <linux-nvme@lists.infradead.org>; Tue, 10 Nov 2026 03:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1794311406; x=1794916206; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ko4mREqmDAZGw+P8OhAmIBygelpZYVgRRe6KEoxcY3E=;
        b=DazflF/nYNRNQi7ZifblsYz0SZWiX/xILGjEBuO1FhOgqnFvXA4hQL6E3Xq6jCofLQ
         PyA2dRlG2J+sb8351WE2XQjOwIaI+/+xCpsPnrXQ2SFgWTYZIq+krugD5bz5cFpoW6Ne
         J4lCJbDUH1kU/LJchUt6Ee/soAYt6CmfIpRlH2j48N3kEDSafKOLHhLo8FepBf5CuTcj
         QagPHkLsyDYuXsXKzvp2LE/hBnBbyfuscyI0+NkPar7uPVQmwRJQ+2l3T4MgdbKVrvqr
         J8ZR4nzaPBf66uW2SIFnxipSWfWUkTLUnKYy3Vg2RvLNw8eOKAdMhebkJTdQnveFnq7Q
         kJLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794311406; x=1794916206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ko4mREqmDAZGw+P8OhAmIBygelpZYVgRRe6KEoxcY3E=;
        b=cqBf1PtQxCbxEm4ixxDp3g67XP+hlItysAKNZNNJTgKTRZrHc8XqWuFKC/QXAontmm
         YKKzp+EQLcUbvh1VEy7WjRirMaN8bPDSIvWvgj+0yCKKOxjmxqydT2rFaCSB+vKhxy7+
         iVZGz5BhiXjtt/i9dIDCJIJWI3RNQ5NjDnE6j76UDf3t+bO6b703culQ60TOK/2QxP8f
         kH+6XemTeZ1z8elBQThl4OclIySKwtrGXkIdkTeEmQFnVDTrAms74np2E6A4AM+SpUK/
         9feDFlfs4sbmkGjGUuqgk43AoBRtN6we159BpvbeVT0kbvTzJmg2yKSyy8Rf54rWGVFN
         RRrQ==
X-Forwarded-Encrypted: i=1; AL+hErF6JMarNPS6UMLKr8IaKJTcZ4HuG/uLOxxxdVh7WMnbQpYJ5NKzazBihTdneKFDW1XawsoTSN/vqqXz@lists.infradead.org
X-Gm-Message-State: APuU4Z9ol6bmp78IDTt9frh2/KIdX37bKQF3nxhY3tOgEukSR8ftCLyo
	AOlJq1r0jxcfxanNXbWhGnhEvrka3XojI0Rqgek4EHDf2tulRCuWuDRBPobb8gN5Thc=
X-Gm-Gg: AYBFou0VdJSGzjtgAVKRd+E6/VykUGPaC71T1D32DDCNLK23sw/u5q3jcXmYk2En2yw
	hiScsVXq4GiHfoMa8L25+wZH/pDD6nPf/ekH5TXfKkFRspGGkkx5qFTUFktJSSN0tHr7KhRMhbb
	2tWNY46z2fCn5vPzviKoiX0bxxum8ji8H8rKHQFVUvFaI26XudZg77VZYpI5BH3AZE6Hd5dxTQV
	hN2L+lbpyQ2ieU2swogFmxYNX5FlpQNtqMosY9X1h/fcHfluSiCL139HbChuJ/21tjIOIaLKU2L
	ojC+7mbRtuUgXFgQZxm8sSrq/AAvbUwuXjMize6r8nqjdgkCvj9hNjRnnLY9gKNQY7sAfp/cq0P
	Rn3BaUkdQHJ04ckv1HtzA31dfdOg7Qg0BrdfxO1k9+A/SSeSQtUbIXbK2yovJrXLcZev5rNkcLQ
	3cpdhfjyK/Zyr+mG8J8imi2J8QFMDgSw0FRVL0NM5adHpIDJU59HB8S9e0a2th1Bl+oOnnuA5IK
	24o+BkDfIOFghwut9zmmCweyxaHU4Ic3z65RpNuKzGkD09tyJpqIr6yOOj0XJeQzXWJcw3Gzy0x
	4mB1yoveaB4Qh69G7KjXyOdqZ6E5P+PLPefTkuFcgDTEFLHbBOxdlBItGhdVImtUmgRM/Bg=
X-Received: by 2002:a05:600c:c166:b0:4a1:742e:3 with SMTP id 5b1f17b1804b1-4ba0234e9ebmr38685915e9.27.1794311405845;
        Tue, 10 Nov 2026 03:50:05 -0800 (PST)
Received: from MBP-Saravanan-D.civet-hops.ts.net ([83.71.242.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498366c500asm4674805f8f.48.2026.11.10.03.50.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Nov 2026 03:50:05 -0800 (PST)
From: Saravanan D <saravanand@crusoe.ai>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org,
	shinichiro.kawasaki@wdc.com,
	linux-nvme@lists.infradead.org,
	dwagner@suse.de,
	hare@suse.de,
	sagi@grimberg.me,
	kbusch@kernel.org,
	iyamahata@crusoe.ai,
	kiyer@crusoe.ai,
	ganbalagane@crusoe.ai,
	sjpark@crusoe.ai,
	bchen@crusoe.ai
Subject: Re: [PATCH blktests] nvme/081: test the per-queue io_cpu sysfs attribute
Date: Tue, 10 Nov 2026 11:49:42 +0000
Message-ID: <20261110114944.47206-1-saravanand@crusoe.ai>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <7a2bcf1c-990f-46fa-badd-dc1b14dfa96f@linux.ibm.com>
References: <cover.1794015622.git.saravanand@crusoe.ai> <20261107095350.98072-1-saravanand@crusoe.ai> <7a2bcf1c-990f-46fa-badd-dc1b14dfa96f@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261110_035008_538463_3F0F055E 
X-CRM114-Status: GOOD (  17.07  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 09, 2026 at 07:13:27PM +0530, Nilay Shroff wrote:
> > +	_nvme_connect_subsys --keep-alive-tmo 1 --reconnect-delay 2
>
> How about adding connection option "--nr-io-queues 2"? If we add
> this option then we may not need to have the requirement of
> _require_min_cpus 2. I think, we shall be able to run this test
> also on the system with only one cpu.

I added --nr-io-queues 2, which pins the queue count. The test still
needs _require_min_cpus 2 though. nvmf_parse_options() caps
nr_io_queues at num_online_cpus(), so a single CPU host still gets one
I/O queue, and the test needs queues 1 and 2.

> Can we also add one more test here which tests whether "$qdir"
> exists or not?

Yes. v2 checks the queues directory and the io_cpu attribute
separately, with a skip reason for each, so a kernel that has only the
first patch of the series reports which part is missing.

> I think using --nr-io-queues option would also replace the above relative
> comparison with an exact comparison based on num of queues selected.

Yes. The test now expects exactly two queue directories after connect,
and a different count fails the test instead of skipping it.

> The reset test could be updated to ensure that number of queues
> remains unchanged after controller reset. Current test_reset()
> verifies that the io_cpu and managed attributes retain their expected
> values after reset. However, it doesn't explicitly verify that the
> queue directories were recreated with the same count. I would capture
> the queue_count before reset and compare it afterward as well as
> ensure that queue_count matches with nr_queue_dirs.

v2 reads queue_count before the reset and checks that it is unchanged
afterwards. queue_count includes the admin queue, so the test then
checks that the number of queue directories is queue_count - 1.

I will send v2 in reply to this mail. Thanks also for reviewing both
kernel patches.

Thanks,
Saravanan D.

