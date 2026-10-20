Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E1F606A31D
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2026 15:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=2KHlEcr6;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Wih5KuUo
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zTjUKTq2pDJiEG+CDmqesBFdpCYeamHw0/TGw/oMuDk=; b=2KHlEcr61mh4Mb1CwFA9T/NTlV
	ne5JMVQKwjh/3ZxSNEzUffDYR3DKusE9kSxtsErC5XmSME5bP50n+xajoWHyLimfOvpMrjtDH57nT
	iCuJuivbI+3JOwuMG2rGbq7izD7z9pxX/AEZBghC7gK9UIyKpJXWHYSpqN1mypu608a74SzFL2QGB
	itTFd5lDGt+LkUn9bHZ9vzevd+cdZIfZMi5MVaWmQZddsKNZOjKPT4tMr7OIXS2rieMNdi/TmRa7Q
	e9zdtsfcuFEj1kMP6Rjd4f1N/a/Hu0s6mCb7p9qsaP0q+nAy/2gjrvz2UzsiG71MfBqkYtnidEGcz
	sZngTHcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJBb2-0000000A2nj-2nFD;
	Tue, 20 Oct 2026 15:17:48 +0000
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJBaw-0000000A2mG-1RX2
	for linux-nvme@lists.infradead.org;
	Tue, 20 Oct 2026 15:17:47 +0000
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-48e0d1c095dso1972850f8f.1
        for <linux-nvme@lists.infradead.org>; Tue, 20 Oct 2026 08:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792509458; x=1793114258; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zTjUKTq2pDJiEG+CDmqesBFdpCYeamHw0/TGw/oMuDk=;
        b=Wih5KuUo05YcaeysxihQUGb++/rprW3pQzLM6oBckJJWjThr4NSiFJ7fJVPk3vCqSn
         HVI2meDM1kjxldyHknC9q9+CNmqP5SbLI7tGIzdM6dqCjjZSY63eTzh8KfNoasVY+JHt
         X5W45WSlwq68hKo7GlC+ZtMX2R6i+NSiNEkyROeKRP07n0phP7knFll7GKxhu3A95np8
         aPiksO21ykYJXJpI2SB9do5Vo1brI9ZNUGFQ3bf7dsTGb0iEX/2cL49dII2pRfsG0OtD
         b7rTY4PE9dllsE+9SynzCpNfCvESkrh8cuBilu/xy8f0CvXM1e+BoxtRdSSkaYThOiHd
         vtIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792509458; x=1793114258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zTjUKTq2pDJiEG+CDmqesBFdpCYeamHw0/TGw/oMuDk=;
        b=UCddzaS6KconwXTYYH1ddg3vg23ub1alfo9RzbgKxZb9HsJOGQzwMYaEUT/IXyFVRL
         pn17PGj3UrMOzIaCsZ3UiopAiC5j5FIl4vHHoxGVtZ6WaZ9gWJkdW3mzXI7Zvrv2zh3y
         irvuIn7zEvN/zD0brj7xUAmeEhwg6heQzH47Z8pcCr8mlsBFs+ZSHv8PHg5pcKYGhqip
         XH8jF8hKBD55QasumtWiMyuYFAJ+LmKc1WNxnlk4i0S95+GJrm153WkNRq9s7SsR3wj0
         xY7XU7fFIuIlHtYpV0QNi9eBtvhOvf6tkSsqDGR8NJ51TWxyqDogTkRA3mvddGC5D53W
         3OvA==
X-Forwarded-Encrypted: i=1; AKwUvBxs+WyzggxSz/DRtysAQxZrnUGsZtZK2KFpSgkkPh9dGBURw9sXCKm+gWPIaM1uwUcL0vGx5Po018QX@lists.infradead.org
X-Gm-Message-State: AFq9FYK4ubza4pIDgSFerkYWp1mcBaVioeLioP7B1nQ4y+YAl/Fl/Uql
	16hdOMu4Kx2Kx2yYwU9iQf61VXebFdXZzWlmNUcbSs7iG4oIq8IOXanq
X-Gm-Gg: AYBFou10d8HuB2TAvCGVreDn+4CL/Gu+rngj754f05DVdOHyzl71cc2ktsuLlxR0w/g
	1J6N6bJ8PwYf+MEDmZYrtoBJDE0WBsCGljMTfJOBZPq8QS8dDY6fiWXDGp7MVDoIrsOW6qbHQ8h
	/8R6WrpvQlb259/sQ5L83pjKmjUPJmnxt/N54qdlColNMQUOckfGfE4lzmIdiPwWBHv6uV6IyVV
	zzb+FMU7TUZo4/Z61sh1HCMUAb9xys56u5QC9C29E9zQ+1ygy/aqZpE1Yibhs5r+HCu0mf/qTSq
	1j61LoFGdf3x9aAPhExkF7XmEXAb/3EmBUAgXCUN2wZQaWkKEVbOZHpAz9pDleUnDdpK1eGpa0Q
	2LzsoEoj9iGbPT8vMk6ozr/ZJWbs5+TYzOf06Lp2fAFLNASySs4ZTO+0LM/+hClz7+AXYeLG6H8
	W4LH6hrl5lf2k09CDZX0Z+9kEnPEN7SjB0ERKV2fWktZqNA5SMyzgjoJMAqxdzKxgI8M3D7SVsd
	TpLOOF9bG+iQuXuaGGoHdwvYb5JCouIrTajyBSkMbU=
X-Received: by 2002:a05:600c:870b:b0:4a1:d487:2dc8 with SMTP id 5b1f17b1804b1-4a1d760518amr238522665e9.18.1792509458121;
        Tue, 20 Oct 2026 08:17:38 -0700 (PDT)
Received: from andreayoga.wind3.hub ([151.76.51.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fb83ff0dsm3555715e9.7.2026.10.20.08.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 08:17:37 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Daniel Wagner <dwagner@suse.de>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH blktests 2/4] nvme/071: test that nvmet sends no data for a failed read
Date: Tue, 20 Oct 2026 17:17:31 +0200
Message-ID: <20261020151732.90412-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <atdDDxISK3i_5uQX@shinmob>
References: <20261014170046.2516-1-parri.andrea@gmail.com> <20261014170046.2516-3-parri.andrea@gmail.com> <atdDDxISK3i_5uQX@shinmob>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261020_081742_398726_8B2A62B1 
X-CRM114-Status: GOOD (  16.02  )
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 20, 2026 at 07:35:53PM +0900, Shin'ichiro Kawasaki wrote:
> > +# Issue an Identify with CNS $2 to controller $1 and print the NVMe status
> > +# and the number of changed bytes in the 4096-byte data buffer.
> > +_identify() {
>
> In most cases, the function names that start with underscore are used for
> helper functions in common scripts. This function is used only in this script
> file, I suggest a function name that does not start with underscore. How about
> issue_identify() ?

Sure, issue_identify() it is.

> Do we really need this dd part below? As far as I understand, the core part of
> this test case is Identify command part above.

No, we don't.  It was meant as a control that the fc fix still sends
data for successful reads, but the successful Identify above already
checks that: it must overwrite the whole 4096-byte buffer.  I'll drop
the read, and with it the file backing, which was there only because
the read failed over the loop transport with the default backing.

Thanks,
Andrea

