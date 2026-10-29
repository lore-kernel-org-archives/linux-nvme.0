Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C595606A31E
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2026 15:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=oykGgQW/;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ORdLZFpT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=rRdA5uHSPZKBZeNOuYhX0rKXdsFR95vH4JxvzhoSs4U=; b=oykGgQW/t1w3oQ
	+5EoECfm+YH8onD8xT7ZkqCjXu4uHQm6n1GOmcuVUt5dq4GRaD8BTb9uPHIXrggMkaB9mfbjMO1Ne
	JTAriwxwOFzdfxiAeH7AiEdBdBWBURhJWJB7sLtYE/DjRK2JWjaIdb40sv0IVMzQDBs7QUeXqEmPj
	WNjpsSABUTcAUPGOI3gI+aPb4rush20Rgjmb54i22QqVcDrYhA7L4XaLNZcKN/LdxaK/LjCfgJrIo
	RVLCqrBW582M6wSt9E3o6JMX720qNlS+TNUdjHZRXTziKiRrkCaYIGqupQPmCQ7tp/RzBrp/neU86
	0RvPdoD3O/byIBzX3qNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMS8Q-00000009drX-00Z9;
	Thu, 29 Oct 2026 15:33:46 +0000
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMS8N-00000009drD-0pLW
	for linux-nvme@lists.infradead.org;
	Thu, 29 Oct 2026 15:33:45 +0000
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-4a822463a22so1419844fac.2
        for <linux-nvme@lists.infradead.org>; Thu, 29 Oct 2026 08:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793288020; x=1793892820; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rRdA5uHSPZKBZeNOuYhX0rKXdsFR95vH4JxvzhoSs4U=;
        b=ORdLZFpTAhNQi/C6LlNy9s1R6sUDOEtHX3TIk1hnoIEy+sdo4VgEqGLzQtaF0ZCYUQ
         evbVnG/g8BHO2KZx8cCPPc0zxJyn5p3UkCqvQMif6olzHTqXABhepB8siXkAGEQoF/5X
         RUpVns1iVzAZlat7bJmeyO8ZyqFOKUoe//6luUliGeEVnRtY95aOtqqpWN/kR79VOFji
         Lbczz/wJjW8zbCS43EOOoKA/jLIYivGoJsEKUhouq3o08KvdscLGK3hin1CTx8Hr0QZA
         nv+2KeB/yh3Ui7bZhUw7qYTETCOewRddT40cv2YLDbfDuuk9tLadQvphSqhF8Rx5HXH4
         4hXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793288020; x=1793892820;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rRdA5uHSPZKBZeNOuYhX0rKXdsFR95vH4JxvzhoSs4U=;
        b=CG2nouEO57KvVC+Ly9R69tvaw8ci8Xubxdy7+hZcLVqHG/xl7ajYJsdUVjGxUQCAME
         w0gcrX+DXzea0vBdfJTwLdXkH0rn/wy5kb2rYmKmei07+kPSi2rVvJ/IS0qIVGZOWCV6
         V818mlqL1lQ8tFLvE54FeVxSFzkrhzurBCCgxvwhF4ciLC4h80NzVq5utaZ4mzQME+XW
         bL8Koj/GfEzDuwxfE3H+TjRxPR6RpR23gbbQmiHG86keHFqJ+q4336D/oejTimasZW1Q
         lQ+NOWYzJNU26IBtqgoJj2VV8zRRBKPJf7YftPbYGxGtf4nLEWjsy/zeQI2Qf+gA51nd
         8uZQ==
X-Gm-Message-State: AFq9FYJOUXWpGistVSJpnqV7axVOVb2NYxsnim+J8QrpxD7Jd1Uw/B5G
	HBaYbN+CHyHNABcCcXHzEBn6mnYo9hI/26rTTsc2QaAPZbSBKnaxVtnOJyIb5h5TcPigkG9R2jF
	n0isJB1g=
X-Gm-Gg: AYBFou3ECf5d75vkkj6PgJqEAHijUbrgiRG3VXY496TOfUkWOInYesVTFcB1k5WWBp3
	eOT5rwk9ldoXWf81+iegRc1+V2iSJd/J2k/pO4d7Cp+uN/FGQ6kEl7mM4TiLXeXLA9Rn/zdLwd+
	0W2HTz3/OecBqeb+jjSleDWkcsdNqvprBB951KVs6lpnqBsxzkz6XonigmP0ibTDkDicMbc+ZQF
	MF+koGalMqyKJl98lU7/rOJjukgBscSr58yTk3SwGm72MgwgcoaTiIlUxkManCQeCQgX7ACBxsi
	qY88tcxP70PMNRITEBGbvjjnKoNqRLhtXMjDRS8MOpfOpQXKui48dH7V5x2kZJzHCg/nk3McSLI
	sdxQKtARMIdHUPjsyRMoEByrges00je6LlJW1WgDHTH7O0TtVyplsqZz47Q4+6uV7tZ4OMPEbXP
	D383jU9H70CDskjghqcvXJJVZBLcZLA84btmeWPBjS1gLnLD4OobzQkqreRrNFeGK6AzmH+j6ke
	BS/5QxGnaKH+xR81m2/wBtXMPP7F0swFds7vwJIhOUxcmZvlzrS5boU64S/rtB5GDqlOnsU0rCE
	dqxHL4O4/+fiD0+5dMctpUoamR0lGq6mi9l2FnldFYQp0yPZWXs7fnoCJQDr4qLYzXkRaYfvVWf
	VrhwMWF4Y/Q==
X-Received: by 2002:a05:6871:e789:b0:45e:da16:d128 with SMTP id 586e51a60fabf-4a8bb338c09mr4391143fac.7.1793288020526;
        Thu, 29 Oct 2026 08:33:40 -0700 (PDT)
Received: from [192.168.2.38] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a9021e7925sm18159fac.11.2026.10.29.08.33.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 08:33:38 -0700 (PDT)
Message-ID: <512bb09c-2d14-4f20-8508-dacb59a30e2f@kernel.dk>
Date: Thu, 29 Oct 2026 09:33:37 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme updates for Linux 7.4
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
References: <auNZdZx2COp-NCyI@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <auNZdZx2COp-NCyI@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261029_083343_387903_B05312B0 
X-CRM114-Status: GOOD (  11.98  )
X-Spam-Score: -1.9 (-)
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
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/29/26 8:34 AM, Keith Busch wrote:
> ----------------------------------------------------------------
> nvme updates for Linux 7.4
> 
>  - Fix regressions from the parallel nvme-tcp I/O queue setup: request
>    PDU sizing with header digest, a NULL controller dereference when
>    reconnecting with more queues, and early lock initialization
>  - Handle TLS control records in nvme-tcp: skip records arriving ahead
>    of the ICResp, and start error recovery when the socket read fails
>  - Fix an nvme-tcp io_work priority inversion stalling I/O
>  - Fix nvme-tcp address attribute race with queue teardown
>  - Validate the TLS handshake timeout parameters for host and target
>  - Fix fabrics connects with isolated CPUs and queue mapping bugs
>  - Fix early boot hang and buffer size for the nvme.quirks parameter
>  - Fix nvme-rdma NULL metadata SGL dereference with T10-PI
>  - Fix ANA underflow check and an nvme-fc discovery reference leak
>  - Fix nvme-loop BUG() when a namespace scan races a reset
>  - Target port and configfs locking fixes, and port removal races
>  - Target auth fixes for CHALLENGE failure and negotiation handling
>  - Target fc fixes for a connection use-after-free, read data on failed
>    commands, and admin queue allocation failure teardown
>  - Target rdma fix for short connection requests
>  - Target rdma fix for inline SGL out-of-bounds write
>  - Target rdma refcount, locking, and module unload fixes
>  - Target pci-epf SGL length and error status fixes
>  - Target NULL dereference fixes for pci-epf and debugfs
>  - Target ZNS NUMD overflow check
>  - Target Connect fix for a controller leak with a zero queue size
>  - Target fixes for a metadata SGL double-free and a leaked blk plug
>  - Target fix for truncated large discards
>  - Misc cleanups

Pulled, thanks.

-- 
Jens Axboe

