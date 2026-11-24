Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4931E606A31E
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Nov 2026 17:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=rOMnIqHK;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BL9W8+xu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:MIME-Version:References:In-Reply-To:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=K7ZWozzEANVXf1lex+kBD8Vnsv+SJSezh9UZ3MXZI24=; b=rOMnIqHKkW3wEL4+v/Umx5CPPq
	aD7NEbhhpiR5blSxD2oYmlYQkbWMbc3M7W0QSiRJkQNNTvIm40DfS1NAdHBYIGa9IklxwFro2GjhD
	W4qqKSovFswzPj8t+fBBeQ9OfWBt5DlyMEJ3M+Day/NSi1Bt7aA2zwxcwdVP46iAE1Q+9TB4F4XQZ
	lNxbeTBLyU0c+MjWqeaTUY7IjS8lUYr9j4Zjvq77+4cGIuZWeKcOZdvX7lJgFolUgxjhlJypMVbDO
	GOkCdHtkPzogIT/oNX6n76JlRPgKBomYhix2V92LWRKDAqRlyx/VCgilYQ9+fFt9iJsQZHyhsvm4t
	Lb6w0PRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVuEP-00000007KkC-1qhB;
	Tue, 24 Nov 2026 17:23:01 +0000
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVuEK-00000007KjM-2mOx
	for linux-nvme@lists.infradead.org;
	Tue, 24 Nov 2026 17:23:00 +0000
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-6ba4ce91e21so34451a12.1
        for <linux-nvme@lists.infradead.org>; Tue, 24 Nov 2026 09:22:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795540974; cv=none;
        d=google.com; s=arc-20260327;
        b=s4MzsdxjicRuKxF4Iphs+TO7V2zmWAm6m4FtU7d8Gr5n+KMOtxAyi/VbAZrVzAd7ao
         mR96GRWGow0vuE/wngdUl1YOmzDtTUn4JYcjkF0bRgxiX9Yy2ChN3Sot1phDCNyNMSk2
         kl5jD9IUL4HkrV7e9jTWGx3ip8HcqZhyoPd/bz8ogRWNPDG0M5dfet5eZ6yY8Gi79e27
         HmauQfvevtbSCE7scSM1i+xL+CuIcgVhZGvnlebt7R/dpqDQEG6z2KWKUbjdXE5PFBFv
         xR0JGfnr+q53eYJ3DNONm630DTumOmUibs8NzVdeIYYYK6hVjpa3j9GvuYDewCINn6Z/
         q+Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:dkim-signature;
        bh=K7ZWozzEANVXf1lex+kBD8Vnsv+SJSezh9UZ3MXZI24=;
        fh=QYu5wfvzY4bVNZYmP/SSCaHDjvNjBOVFh5unOcQUsbI=;
        b=HoZL7WQLFGEmEwwllZUzDBwSFaCDbt9LgeYDAYEpb0KOlWqtVPVRaMM4mSmTYFHtqS
         AfEweKToPbQrvFDiH3aQlfbFopIjOoV1WtRb5AB6k6SbxP7fPfiIRO+MhOVPSLEYg2Vq
         DI5XZOa8nGTtZpNhwXzYqHwglyj1rf8r6YAM26ZlDQGXsbqqjbTaGDRuZl3utgIU9jua
         ca5FDIiY1WhE8ZVFio9yEdNJmuqvTbqWlaRzEUzc2reiWgEFOejMj0BFMavQoP0URdRR
         OlKUkiON7k2mdETNurAhgQyitiQ4OnHG+GvUKgeoGaJNr1ghDgsRmJJArKRIW8JOCa/6
         U4Tw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795540974; x=1796145774; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K7ZWozzEANVXf1lex+kBD8Vnsv+SJSezh9UZ3MXZI24=;
        b=BL9W8+xuZdxrkGDu1i0QZUDItP/q/ntfdsd05k28xJkuIqfNVqXP+/VG1Vs3MkAb4/
         uEw8vUSMm40wJH99UPIElE1MVBoDYGj9CUg6QrOoeAnjATGE0upPj0TMqNRjAvkPz2OZ
         A2ColfoF0tv2C6UtYijlfhjG6DG0gwjHGP5/KFW7xPdoqClk+JwDlCrzAEGaMJ4kPdYx
         C9CVfw6HBzssRWplDp89rYhtZe7T8x66f1IBWgjbL2hhRfhof9zHUskp8a4LWHGcydXk
         5uCsD17DAFW3PaLrOPJkxahy/Xe5tux1eSUBnMC7f6QsjxayiZsfTUDxvhpJdsbn/rG4
         IBIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795540974; x=1796145774;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=K7ZWozzEANVXf1lex+kBD8Vnsv+SJSezh9UZ3MXZI24=;
        b=fRjhbABY5zjPICo+ic0P4j3ZnbeU3MilThQ8K/ZqjC1YNUMRMTcBKNDoQ+tW6MwnIi
         vAHoQFCU30nGjrFB+0oUdWMNS/ktczv69KpuxKLdwfCGYHso6kHaDdfTeTtYclka4xNa
         Ik6NcIt7HwmxZU01UA8yRDgHm5TShrBYX1v+CBcTDVhGEFB5EDwrzs7dC3q4koTEhGB7
         mz2vmD1NPyTZHYSs4fRZLrISxTB7SH1ShTxK/C+Rv4QCatILtOEpdrOOYIx0dGT0Mdyz
         1QTTHE0Vj4t3Qf34PX6h4EbY2ijrx8Z3QP8ajv/B1bcoIlFSIQNrJuNvlhX2hhAQ5fIx
         p/2A==
X-Gm-Message-State: APuU4Z/E/gOOhTukPVUwNDKlFje0J0ha4VTpgyHSorCVOZBo/i/+2tur
	qCIKLn1oVzI+MbIRElRNgOX2dgjV+oWxoOCp8la5BW5EnENjLln9do9NbNrZvPgXuo44qZSVhzs
	eukGidlAKS3y9ZgrpYI4taLsh/3pMWbv60UL4ga8luaxnsrzeNtD3Z7I2
X-Gm-Gg: AZFdTZdcU35Mkae0N3lfSoRjJAyf0qUipEzAHZHuxf7lLV9yeyRyD+4A5M7Jw75YwpR
	KRnNGD+KUwalT/KvzyzA6wqSFY8zwnC4YjVJehnLMI4batr0iRT3Dh6HAsO002VdvjHK9lNWTCh
	jJGZVyymSw0X04kDXam7RR97g7XUr7Qi04W3MBLUy6B/KBeTA2803x4M70w6HIPhzPPbiJQ9zjB
	U6fu2ItaK/mplfTZBk2at6Uxl92z3atTmGiiOZmZP3D/gtmd1ZkLc194vr2KXfsGaB9xOF9rZWb
	n3o/Bv9udziehCf5EgCcg8slcSEntN8eoCVaCSr5OYIaU6H1r12qR8PhRdO350a9TINe9x5XFrQ
	tRhrOmdS+6qTdkZj0Jqub/pWgTTiWk61ng9rofngbvzS/dNrqBxVH/j4Hr6sQyECHBQ==
X-Received: by 2002:aa7:cc0a:0:b0:6b1:bce6:1220 with SMTP id
 4fb4d7f45d1cf-6ba6ed9f615mr252227a12.12.1795540974220; Tue, 24 Nov 2026
 09:22:54 -0800 (PST)
Received: from 913411032810 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 24 Nov 2026 18:22:53 +0100
In-Reply-To: <sashiko-outbox-230556@kernel.org>
References: <20261124051041.3099796-1-zhenwenliang@google.com>
 <20261124051041.3099796-3-zhenwenliang@google.com> <sashiko-outbox-230556@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Zhenwen Liang <zhenwenliang@google.com>
Date: Tue, 24 Nov 2026 18:22:53 +0100
X-Gm-Features: Aa3M54rLrUBIj52P8s98UQtD37Z_eQtms3zPPid3__51D04UW6VlC8D1vg3Uf6Y
Message-ID: <CAE3ZW7vzLOsdcPbBePm1rao3DLpuU6JFNn3ALyPBiyDb2gHYMw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] nvme-tcp: set up R2T data transfer in the send path
To: sashiko-reviews@lists.linux.dev
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261124_092256_791041_664E39A9 
X-CRM114-Status: GOOD (  13.55  )
X-Spam-Score: -17.6 (-----------------)
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
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thanks, the review is correct. Going through the six points:

Introduced by v2:
- [1] CMD_SENT is set after the command PDU send, when a read or a
  command without data may already have been completed and the tag
  reused. This can happen with a compliant controller.
- [4] Relaxing the receive-path offset check to "<" lets an R2T with a
  larger offset through, so a following CQE can complete the request
  while it is still on req_list.
- [6] The new send error path leaves the request on req_list with the
  R2T still pending, so it can be sent again and then failed before
  error recovery stops the queue.

Already in v7.4-rc4 (misbehaving controller only):
- [2] an R2T between nvme_start_request() and llist_add() in queue_rq,
  and an R2T for a write with inline data;
- [3] a duplicate of the final R2T is accepted again, because the final
  send does not advance data_sent.
[5], and the part of [2] about an R2T arriving while the command PDU is
still being sent, are also misbehaving-controller cases; v2 changes
their shape but does not make them reachable for a compliant
controller.

I think deferring the R2T setup to the send path was the wrong
direction: it adds per-request state across completion and reuse, and
each round has found new races. Please disregard patch 2/2.
Patch 1/2 (32-bit overflow in the R2T length check) is independent.

The original problem is narrow. With a compliant controller, after
sock_sendmsg() of the last bytes of a non-final R2T, the receive path
can handle the next R2T before nvme_tcp_advance_req() runs. It then
reads a stale data_sent (rejected since 347d50d92e25) and resets
pdu_sent, which the send path advances afterwards (a short H2CData PDU
on stable). We can reproduce both in QEMU with a target that sends one
R2T per 16 KiB.

A smaller fix that leaves request lifetime alone could be: track the
end offset of the R2Ts accepted so far in a field that only the receive
path uses, and check the R2T against that instead of data_sent; and in
the send path, not advance pdu_sent on the send that completes the
H2CData PDU. That keeps today's receive-path setup and error handling.

Thank you again.

