Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7455606B5BE
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Nov 2026 11:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=t3+qs2mO;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0kWQQNAd
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=WAvNZqDuM5KxCPGrNAiypS/+CAhcttiS2jUQXMyF64I=; b=t3+qs2mOHF9L35
	4q8Dz2vnnPjqFDCQEG2Ujok38wz12bfoEgDo0Si1vpjVFlhQ7nj4tV4qk7Ga2NN/c1gEvpTTt+5kg
	2uvfOjh1OsT2XLmJbrZxdDJ2+jA5gSAPbH4SRG7/d0phjh/V6u0H9tvjJdRyLYm8pjV11MJQuUR7T
	4xCZJtxelSnJHCemr/supvBYinbDNwDFEoJNji2eE3IXaKx+D8ZAeFZPrYzahTPInQZDlN3Ll0Mbi
	K25gMnbsT+PxNv8SeIbpQOlkZgVKOLXshXlr0wTf57XGW5hVxKFYgBahrXDCsdasboiXvl1M+gCfZ
	vIqQONhmhp/yOFHdoWaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRSuM-00000009gCk-3yku;
	Thu, 12 Nov 2026 11:23:58 +0000
Received: from mail-yx2-x05.google.com ([2607:f8b0:4864:41::5])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRSuJ-00000009gBW-2Zsu
	for linux-nvme@lists.infradead.org;
	Thu, 12 Nov 2026 11:23:56 +0000
Received: by mail-yx2-x05.google.com with SMTP id 956f58d0204a3-67a1a96329cso1956791d50.1
        for <linux-nvme@lists.infradead.org>; Thu, 12 Nov 2026 03:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794482634; x=1795087434; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WAvNZqDuM5KxCPGrNAiypS/+CAhcttiS2jUQXMyF64I=;
        b=0kWQQNAdm18ejeQ14PwWtBBofoQVbRR9cD5Q6BT90HZP1D/l0Bj7bDQvHENC0ZeUqY
         d+p88GotT0HOGZ6Da6z5UiZieI639uZj2RxdRzciaxANtr7Qew1vXSicP69rouGUkKQn
         RmMHguefCQ+iOptf/wNbwlxnI3jH5nl6o0oXmHBEEMgGY/D8DfD+08o9T1yZF6xg9AAk
         aJVV3OZhCJSmo89WMJs4sAWwyUnsZ/LTfj1R5KIAi1RpB55rOo5kwImYbIUfJTfhohXs
         DrQiGfZszcf5FKGw923wsBij2hcz6l12/6UGC2EjUq0H1tsLHEKdM19pLXsKKQ+VaxmQ
         +kWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794482634; x=1795087434;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WAvNZqDuM5KxCPGrNAiypS/+CAhcttiS2jUQXMyF64I=;
        b=ionaNKss0HjEkseHFHFq3fK/u7HrcfxxkhbDLnyAcYt4+CObSrK/5iN3BoyOApJauk
         odn+sAhHnPmY+qgrqlNusezZMtsRr8iUfgVK7UMv8cEAUVzrg6GxGOY8l1QJADZKdw9H
         nrk9wkKw02enPLK6zL+ESO+OOJ+nst4Iji6gf18/b468AwkJPNoDhPP8dP6Z5WLU6h8l
         U3RmbLmAw6dOPtz4CQ1q9h7Vvd9AGo5ZOpZLjS3h6r/nNQYt73iN08zJ3ducPns39nnN
         7QVfdoNbTqADR4j8+vpgXxaYyNBE7XoZeh1VfVV4isLmQLu25PvivScQv5rUF5zxSpHq
         MR5g==
X-Gm-Message-State: APuU4Z+vfGPhQYiwet9gdFLGyMXreK5jXdDw1L39LcEAzUnyIkVqfFOp
	dXAd+NXuyaYi1IdcI2CaLHU0N6tY0khE47xzD0nKaGge2RtvWm4CaVI3AKNR7jR7
X-Gm-Gg: AYBFou2obIdMURVvnBX5/Ge7cUS2sZ20I+q+W4UgmhldQZe0Vg3iASdQUseIvS9jWWT
	zM2buUNNtBEEk7VrDH2lWm8SExFOD65M4lZm1vj8QYgfK8H13k38gjzI2iPBdhtlPvI+KiiNGmN
	tug6eXNU+HaX9x+V3n0P7nD23CxLeciK99S6v3aCpXHB0cx/K+hG1iqybxDYPa9SoG91QuALQ64
	/9F9Qc21CdBaRnM+oR1C7y/+/G38jC8t2XoYCKbvuAy9TBfmRmrJWmLCpZhbyGnAyX8v2AWAZEY
	granWl2xwMwZTowv4hOtYVKaI+JVDFH21sZ43BZ9hdlm6jgn+4+5egR81EJ9JQ1+C07aAZ0suf7
	fU2MktF/bLD3tLcpK1c+E6TwC+UdQ5yMP2QFMNRUbTE6mlWYK4wGrAnqoVNEv28csakqigxgnON
	ZlNbEohQ6Ydwu9wkky+Q7Ep8b+sfTjdBXAbnj9GSbpV6rFYMUsxII6FzppOOfG9DMJEWSl6XG3B
	3OvulP2maaF45I840bSTaVRwsyJfMmVVcPlx51QwyAgKUYeuBqvNCnGLBlwMKSv/jIbNLLn9KP+
	w4nBoK9a4VL3zMv9Eua5mO+dVWAqoSvvfbSA
X-Received: by 2002:a05:690c:c0cd:20b0:8b3:ffe:ade9 with SMTP id 00721157ae682-8b3a7de595cmr24768907b3.9.1794482634396;
        Thu, 12 Nov 2026 03:23:54 -0800 (PST)
Received: from [10.0.0.48] ([71.69.222.122])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67c589c4e9bsm6873053d50.10.2026.11.12.03.23.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 03:23:53 -0800 (PST)
Message-ID: <77e8c2f4-9381-4e76-a75f-083e14473c94@gmail.com>
Date: Thu, 12 Nov 2026 06:23:52 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] nvme-tcp: consume TLS records without application
 data
To: sashiko-reviews@lists.linux.dev
Cc: linux-nvme@lists.infradead.org
References: <20261111-nvme-tcp-live-ctrlrec-v2-0-6295202b84de@gmail.com>
 <20261111-nvme-tcp-live-ctrlrec-v2-3-6295202b84de@gmail.com>
 <sashiko-outbox-209836@kernel.org>
Content-Language: en-US
From: Martin Belanger <martin.nvme.dev@gmail.com>
In-Reply-To: <sashiko-outbox-209836@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261112_032355_670459_13BDFB36 
X-CRM114-Status: UNSURE (   9.21  )
X-CRM114-Notice: Please train this message.
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



On 11/11/26 17:54, sashiko-bot@kernel.org wrote:
> [Severity: Medium]
> Can nvme_tcp_try_recv() leave subsequent TLS records or NVMe PDUs stranded
> on a poll queue after consuming a control record?
[...]
> Because strp->msg_ready and strp->msg_announced are already set, later TCP
> data will not trigger nvme_tcp_data_ready(), stalling the queue until I/O
> times out.  Looping back to read_sock() after nvme_tcp_recv_tls_record()
> succeeds would drain any remaining records under the same receive call.

On a queue without polling, only io_work reads. After the control
record, nvme_tcp_try_recv() returns a positive value, so
nvme_tcp_io_work() sets pending and calls read_sock() again, which
reads record 2. The announcement of record 2 also queues io_work,
because NVME_TCP_Q_POLLING is not set.

On a poll queue, the announcement is suppressed and nvme_tcp_poll()
returns 0, as you describe. But a poll queue only carries polled
requests, and their submitter (io_uring IOPOLL, bio_poll()) keeps
calling nvme_tcp_poll() until the request completes. The next call
reads record 2. The same applies when io_work sees
NVME_TCP_Q_TLS_RECORD set and returns 0. A record that is not yet
complete (tls_rx_rec_wait() returns 0) is handled the same way
today.

Calling read_sock() again in nvme_tcp_try_recv() would save one poll
call. It would also need a limit for a peer that keeps sending
tickets. I do not plan to change this.

Martin

