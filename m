Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B43606A31C
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 19:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=TXYxs5hi;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v0noSJEY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=iNu8wevlnlWuO7QPB5Pki9h/6ZFT28xcWP8fY0TirdY=; b=TXYxs5hiL7OsIn
	M0R/byghC3CNfzqB0/mbmprTdGBO58V0nOWhlF9EfNVyZXGqQp9H9ddFMu/B2/hXdAxpV3pHWldJo
	caf6dcYzeV3QslHj94mnEIAOb0QwFW5AGE4YDUacxfswxhrCsXkItZEpvw22UMCADn1IERh67o2fn
	P1jV9CsTVOcCvoIuqmfWHlulXRbbAaat8bA4bnuJlBkZU+MRS5gGBdB3fzmwGprJywmCPvzxojK4l
	AzeqaWSDFRQC/5NUfRodoc4Vx9MnuESNZK5EggyYj7hS+HgijJl/RLuM8mffklHXazAz4klotJNQf
	DfQJoZ5h07ucGFG3dUig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQVAs-00000001Z1Q-28Rg;
	Mon, 09 Nov 2026 19:37:02 +0000
Received: from mail-yx2-x05.google.com ([2607:f8b0:4864:41::5])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQVAp-00000001Z0G-23n6
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 19:37:01 +0000
Received: by mail-yx2-x05.google.com with SMTP id 956f58d0204a3-67a19a2621dso1007283d50.0
        for <linux-nvme@lists.infradead.org>; Mon, 09 Nov 2026 11:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794253018; x=1794857818; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iNu8wevlnlWuO7QPB5Pki9h/6ZFT28xcWP8fY0TirdY=;
        b=v0noSJEYuyR9HTWvcbUARz4BeBmgTqgAbheyOUbf2ZyzDXU05Mrxp6sxRUX/htr8dd
         s3uE8S7bbhCtwWEq4ZLv7hAJwa4dW0dRy1C0eBKb9qb1rjoU4lIEfd0Hl0BeXKBU7ZTo
         g1/RqnQTyY+Q0x6WGGjqtFlys7GdKXaHuxOWAEmrebtnZAvrevK2hxOhreg4p8X1+WpO
         vp7ZPNcaRQU6zu2WjXGRMA9grD3Tmq1FSz93dnY8aSjUuyc1ogcQPuOhHYKztY1sBA3H
         MaEXTogRzgrfOUGT3U0Hk0T0iK+CPV3+j9XkP5J69262AvvR8/9WOcifcVVw249ev/qj
         QxSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794253018; x=1794857818;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iNu8wevlnlWuO7QPB5Pki9h/6ZFT28xcWP8fY0TirdY=;
        b=Lb10yyTKcyJpm54ChCQUzM7/Rk2Woanea4VmAgTGc1cqU4OC9EO8WleqQPokOzo0NB
         ziBPbRkmNpaH7Vg+lBbFoa4fI+6YYta4HzRu5HWZJzNR3kW6LJArjXAc8F7OxVacwNlj
         AGwcEc+d1AV81oerpDkrMG58Z3b5hL1BViz8S1tZWRH1G+hQ4wMtV9W59AZJymfAygyB
         I+BhIaJap1jgJljhkeIU2yCqmUkyAI64oFQKO4J/YN1RKpjlLRVnGOYrjEA2/c81+IMu
         I1Zberpi67ysVIGXApZVsiqtNYXyaNmnGNjWANtBszmC1yyRViT0leHnUJWgYTSrxlBf
         N1Eg==
X-Gm-Message-State: APuU4Z81cs55BvrHVj5X9sVKc7sI57dSNwiapCIF/MY6hVTN8naI1ZWb
	2vPBa9LoF0w5nCLKrDzQg1Aq1tLqnyZ0GG4WYCPO85740zgwvDBMbwl4
X-Gm-Gg: AYBFou2axzxn+aWKwRdj+sb4fYTKOulYCfCpV/sfQEE1ARWjxjnRysVmkY590d/1OT1
	+PDqLyHrC3m+3LHAQ7OCSoKNcEVCofiEwVAeIfqXtMNmkZH/LRnaAMVtQRCjL7onOG+3ihGykb7
	QJbmGXIMe7ZWOBuxxZFQbMIdkSceWw+TJdCnzZMHyG65V40jk4wjHXXTBomFigjvbM20mJMFXdU
	FWD3IiurwRrzvI9yfe6I3xVADNSwKp2ZYQ3XquAsj8ff5/Zv4hZy81xb33XrZZcQXVRFoYIuMPJ
	K1eKmKFPyYshF9rOIkK1J+Ug5v4OaarghbKJSlnysScRS06dvesQ/QRvcVYyd7jJnV2QUnG9ZDb
	R5iJCgXi9MWI2pXBLt/zBBdK25HDMATPEPxRbviGSf63pQdJsI9ZKaQt8bb1c7bFQOpGaUHyc0b
	Xb3Qerkk1bTi59boGhhn10v7C930Skp15+RpDlXwq9V4IgKMwxQ+hb8XhoLZF36cgrbRTZCn3wv
	awEUJSuo7FgDzRxA8nx9aQprL4+jC1wWtVLzfPrYBt/3EKtnXMRdwkqdEQiiUAFy01qnkBsTfjk
	wHtrl75nz7VEE5muz6BgiDW9aNoOfOJzvg==
X-Received: by 2002:a05:690e:4399:b0:67c:3165:bd2d with SMTP id 956f58d0204a3-67c568707e2mr287035d50.68.1794253018056;
        Mon, 09 Nov 2026 11:36:58 -0800 (PST)
Received: from [10.0.0.48] ([71.69.222.122])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67c589c70a3sm62367d50.11.2026.11.09.11.36.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 11:36:57 -0800 (PST)
Message-ID: <8f89c7f8-8f27-477a-a98d-f08845667639@gmail.com>
Date: Mon, 9 Nov 2026 14:36:56 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvme-tcp: consume TLS records without application
 data
To: sashiko-reviews@lists.linux.dev
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20261109-nvme-tcp-live-ctrlrec-v1-0-47ba61670e65@gmail.com>
 <20261109-nvme-tcp-live-ctrlrec-v1-2-47ba61670e65@gmail.com>
 <sashiko-outbox-205483@kernel.org>
Content-Language: en-US
From: Martin Belanger <martin.nvme.dev@gmail.com>
In-Reply-To: <sashiko-outbox-205483@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261109_113659_542157_F257AB58 
X-CRM114-Status: GOOD (  12.38  )
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
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/9/26 14:21, sashiko-bot@kernel.org wrote:
> [Severity: Medium]
> Can dropping the socket lock here let concurrent callers of
> nvme_tcp_try_recv() race on the same TLS control record?

The report is correct. On a poll queue, nvme_tcp_io_work() and
nvme_tcp_poll() both call nvme_tcp_try_recv(). This patch releases the
socket lock before recvmsg(), so both callers can see the same record.
The second caller then fails the queue, and the controller reconnects.

Without this patch, every such record leads to a reconnect. So the race
does not make the result worse than today, but it is a bug in this
patch.

v2 will add a queue flag. The caller that gets -EINVAL from read_sock()
sets it with test_and_set_bit() before it releases the socket lock, and
clears it after it takes the lock again. A caller that finds the flag
set returns 0 and leaves the record to the first one. The flag is set
and tested only under the socket lock, so its owner knows the record at
the head of the queue is the one read_sock() reported.

v2 will also include the cmsg buffer fix from the report on patch 1,
and a test with poll queues.

Martin

