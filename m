Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4921160A3837
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2026 15:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=hmMcJJ9R;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20260707.gappssmtp.com header.i=@isslab-korea-ac-kr.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=rlM4aWuN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=0QNzEFV3vJuOGSdQIc+xIG1ijvSXzUStwoNbAGUQa7M=; b=hmMcJJ9RdhpUM+
	ICRQSenaOrEYC3IUxOFulRJY+cHUHVVHiHlbDLuvZ6cVxXr/6JiwUkorb/532ytJ+8x4TKCa73EuK
	r1mghvt4kezHVCAaKea8ImBz1TBUYwsKFr2k/SI35u0WRxYPLJ/Qml+JXqOCg0t6M+ZY3OjWSws3L
	accB7ju8vnaS0lkSLDKMP5LZr121wgAfp+noIk4sFGA7RNF/AM4RwJzywmc97Ul4aCpnSg3Fm8KSR
	j+O8FeZ2E4y3Ye4bozsN6FNxYFFCB/w0fnvuiG+z+dmp51RrOCyBDpiMr8pwaHqd3mEo9ONVG3z8f
	M96y4LLuFCzDwRC3mEBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUQ5m-0000000FKmW-2OJ3;
	Fri, 20 Nov 2026 14:59:58 +0000
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUQ5j-0000000FKli-0M21
	for linux-nvme@lists.infradead.org;
	Fri, 20 Nov 2026 14:59:56 +0000
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-2f00fc215f9so6737165ad.0
        for <linux-nvme@lists.infradead.org>; Fri, 20 Nov 2026 06:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20260707.gappssmtp.com; s=20260707; t=1795186794; x=1795791594; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0QNzEFV3vJuOGSdQIc+xIG1ijvSXzUStwoNbAGUQa7M=;
        b=rlM4aWuNDMFu2uERKF3mJsyWZSBovKa+bayHW/XdHnqk/Mw5pRx/rzHLSXgFZ1ayR9
         +RDyHH//HCMNIhgosNzgdZCuWjDZzQw+CO3ssXJE72op591XjgzLtOmsrwuULIGE1sXB
         9rdocUUq4hWhzqBn4OjjSPqfgsVOsyllTkrFk4r6yutxshszIsVIPtUH/TaYnvSZ4jqn
         fTpEbZ96O3ouhlIU9h3HGCE1eU2y3jqbn8BuxVzwXBmoGKtIL+V2YC9VBzayj6frYf2G
         VoWTr5XWdC0MjyN2bYYdMxN12brk2ImOUqQ4NbTdHfgfoQUvIkCK/OA40SygVt9E6VLs
         pEnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795186794; x=1795791594;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0QNzEFV3vJuOGSdQIc+xIG1ijvSXzUStwoNbAGUQa7M=;
        b=mBuaYo8kGABG9lzI4sj1XFdSmGCKSxRA6RMalzPUM36UvXgTxrJdXEyP97Rb1mHk5Q
         jFmMHwALVje6z+mGUUgI7uZjoyH463BRumLSE8lmYqKjS14W4Qix5Rs6u/C9AiIpx5fl
         plpn/NGfS6LGcvhJv04RTY7aB+zo4rMXqf3nFhNSBp4EhlRULkwHusIA7kTLN5MgmT7M
         Bp1IOPhzSlmetCpdmoR9N2YrKPjsdUiKOx6tRMr8Rcy5ZW9b8VgV/dhy7Me1ypkd83Zz
         nm+/AMNyX1Ja7C3aSAlNqGyjNIT6phj183hTXmGxFFPzMyPt0YoRUwrLvA0gdvuzmc8N
         CfWw==
X-Forwarded-Encrypted: i=1; AL+hErH3+k8cAJrAlxaVPvs/v13oBBfC+k5BqtTiOYD9ycXEfSFo3dyc12y8KP/+cZ1kHPgEgCpluH3nRcVo@lists.infradead.org
X-Gm-Message-State: APuU4Z8+0oAf2gqLkrrdkRD8WcrFLEFiJpfiknLz/FoOgwtcDWZNF8C7
	L5SyByX2yLWBVIAF0RGlFXby0MPZ9ZBooZJuwyDYL1m+rXyzfiGGYcelamD86U0gWU8=
X-Gm-Gg: AZFdTZcl6q+mDZSj3FH9COmOQTELg/plPUpscDs09WXXtWTt5Qz/lqMqPODSwHc0aod
	Xj6CBk+LXrGUF6jxWXJuT9R/kkU7mYHv61062gNSTtPn0rK9XTusCHCAnGyusXErOsNV3v7SnOU
	61LYOfUjMYfhPG4qtEzdNVe+9ZGV5RxJGaJmyW+oJcZSJv6Wzffgj2PEraFaDBpPDfZXyIQ9mhW
	c+0pes4EBahPs4FIEQhflmdDoCQO9lk36DbvInyG0hfVtPldlfj59eWvUzFW6SDnk6C/ymvJck7
	/jRmNhUZIxcj0J6IYqmGA+vZJkRXU02LZHFL8ncb5JaU/MgOjv8cJvM86NnhjdRLXzl9NNdUksM
	Ct+gZ+dMi2ZtHwnSmswLrZPjUB7tIwsuj37YMXXGlpLaB30v5gWFrQcFTTFA7a7zURYeIwIFWGM
	AEzB8NTmzrSUK7kSzTXAyY2JOgE32fZngB9blhEbsudpJi1uREav2X/z15EdxHuOMcEGBmMlsFx
	YYUix0OrzlqAkQa9UcQO+5+/ilzah2b8/lxnRN5XFQ69gYtkduMhDVJNpr84NpnyfvHi88MW1Mz
	98DK7ria7+yIz37ncrCIGa0hCcssB0DfNBvFp9hX6MV1oER6/lSiG5r5Z/RIZqJRMIGgtKmhOj7
	EYRuMB1yLY7MJcxxG2X7g1BRjOcWYJyyeu9eu
X-Received: by 2002:a17:902:e847:b0:2f0:2c63:8bff with SMTP id d9443c01a7336-2f03f1c0088mr38054055ad.39.1795186793943;
        Fri, 20 Nov 2026 06:59:53 -0800 (PST)
Received: from yhlee-960QFG.Davolink ([2406:5900:1044:110c:8b25:951:ad8d:5cc1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f14a432sm15587795ad.75.2026.11.20.06.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 06:59:53 -0800 (PST)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: justin.tee@broadcom.com
Cc: hch@lst.de,
	sagi@grimberg.me,
	kbusch@kernel.org,
	linux-nvme@lists.infradead.org,
	nareshgottumukkala83@gmail.com,
	paul.ely@broadcom.com,
	kch@nvidia.com,
	jsmart2021@gmail.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet-fc: bound the FCP command data length before allocating buffers
Date: Fri, 20 Nov 2026 23:59:47 +0900
Message-ID: <20261120145947.3127969-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013104038.3078601-1-yhlee@isslab.korea.ac.kr>
References: <20261013104038.3078601-1-yhlee@isslab.korea.ac.kr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261120_065955_125061_DC0D88D8 
X-CRM114-Status: UNSURE (   9.84  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -1.0 (-)
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
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 13, 2026 at 07:40:38PM +0900, Yehyeong Lee wrote:
> nvmet_fc_handle_fcp_rqst() takes the data length straight from the FCP
> command IU (cmdiu->data_len, a 32-bit value from the wire) into
> fod->req.transfer_len and calls nvmet_fc_alloc_tgt_pgs(), which hands it to
> sgl_alloc() with no upper bound.  nvmet_req_init() only parses the command
> and clears transfer_len; nvmet_check_transfer_len(), the only other place
> the length is checked, runs later from req->execute(), after the allocation

This is superseded by v2:
  https://lore.kernel.org/all/20261013153316.3178656-1-yhlee@isslab.korea.ac.kr/

Best regards,
Yehyeong Lee

