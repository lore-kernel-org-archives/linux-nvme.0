Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8504DC021B8
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2025 19:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rB4Eah3vxU92S35BcxthA4vQ5D4JS2TWUNxGQ43tWiY=; b=WVEZQoyJft50qbbfDERklmvCM2
	pgImsh6hC7PQpsY1lBCBbUJvuxQZREO0CVSPh9dVNxnN+16Vq+1RSkdLoJQkh2e4Jvoh2kMEinEL+
	6XS51KvCANlRRkDSuN+I/dIa3Bcbi6DzdVxe09EslYk5J+lqdhyCDMJULArn2Pih/Tp5IGFVrNbUR
	4vtqmaEVLXLSxEolfxtVewAsJINd3OxdoTkM5J6oK1sQ/0A6oHOSxkPNH03iQRaBhZvMEJN+5wDlw
	Xwnk7/BeqZQteYdB53VP/FiyuQ4+KU15+sFuoDYALPdbAcje2CgEE0Ia0ar5dp1rSwrSVE63SnkMQ
	mq+wNyhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnMpw-000000056nr-3KEY;
	Wed, 26 Feb 2025 19:12:52 +0000
Received: from mail-il1-x12f.google.com ([2607:f8b0:4864:20::12f])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnMhT-000000055PY-1EDW
	for linux-nvme@lists.infradead.org;
	Wed, 26 Feb 2025 19:04:08 +0000
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-3cf8e017abcso690245ab.1
        for <linux-nvme@lists.infradead.org>; Wed, 26 Feb 2025 11:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1740596646; x=1741201446; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rB4Eah3vxU92S35BcxthA4vQ5D4JS2TWUNxGQ43tWiY=;
        b=gQROhA8keq7I7SAwMSPYZfuB1KLMiozsNbL7uv6E2UHQ9jK3Yd0fMNsfw6RICbsLjt
         8zN59OQ+Kqt+++JnwtCbzr8xRqvQZ50OShY4BuW4XHpTDsB82gxLqJ3VRZrCyWy4oV6p
         zO+90ba0kK/O7/GpHhO3+du6KcTbyYdaUWGWRqJLJAPZgO5s0v57ZZJRpTVf49/n2MPd
         Po/cKkq5yZD7WDnDjFhPSkalBMIoXLFVbPnBDh5sMPh+Z5+3dCp0VoGWuaRlC0rgnGUX
         7gkLUHyzQkxnPn5ekKWM7lYFqVH4JU04ex05KLbxGEquogDQo+xfvKfbw/FpMZR4bgSo
         /xTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740596646; x=1741201446;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rB4Eah3vxU92S35BcxthA4vQ5D4JS2TWUNxGQ43tWiY=;
        b=H9o2lBf7f3T8OD4aQGW2C8ukCKKKkAvR7WH4eZ+lVAFWtnQHljpN+M8n484ylOj6ka
         ayDmLisfcVwkP7uPc0pWuvQeeV9nx2QVG7MZ4e9eMUp+2VynogROd3J+OTjMDDfEzYPe
         pSzhYDB1pn3+Gs4scDZUYuNpN4ZBnOgc9iGL4iuJFxHsHWUO+g1EofSL0bD8d/uYmZZd
         weV7LguKa58pw4bjlQh/VoFHF9vKJENpGNgSkjl/jKn/b8Pgi/yY6SkxKJVLxzEcUAGC
         qmq6zw1pZuVr4NNPNFU+FK4hRZwsgMo1VEoJIyWbZcqM3YqduviHI1TtihXNmIKs7Fv3
         M0+w==
X-Forwarded-Encrypted: i=1; AJvYcCUS2Yi3L9JA2x6it6iMSbFOvjKXFG8keggBSoDmbcgv3j4QWR3UOgj9/KGiTZHS8+q3vRxZdW032uTI@lists.infradead.org
X-Gm-Message-State: AOJu0YyqLTx9+Q8is+dF6sHgdliBPvYK2oxGHUq2f0QTLlNSbvxCwMjy
	46ZnYKwnHmbo+SAx23XyJUuUox+Y6bEbgMsGUGIFKpVv3JOtWc5FMdqKv4xg674=
X-Gm-Gg: ASbGncv7gedOBqOQm94zXSGef/SR6NNzirgZN2xGDW3CAUlx8lSApL+so7Ab1a084km
	eAkqtP1/MZEBUoMa+8Ye+1x4iT5042hd9h80c2e3e8UoS9JL38raEhnPn697QhZX+JBSJYeUeCT
	OJtJJl/0mc+qoJNpHh1O4JWjeqzMZT1cm5pg9ubNzI36TGHp1sPvdFh9zRZAZRmRHKwQNmIwrdI
	LlduAXpa3MRZodzgIB+9vCaYh2hkxH8+FK4Ve6MruEQoRIBf8MtJcNsjkWhNp/AgWG+VJwaGPGH
	zpF32KY2dkYzOqym40jurw==
X-Google-Smtp-Source: AGHT+IFGdm4gUg27Qjv/O1KCfXKyBBjOxuXWvgOi1stUm7jgCxRPXQd2w1RcykLJRLfUsqV6LYlAUQ==
X-Received: by 2002:a05:6e02:3f10:b0:3d3:d8af:6f with SMTP id e9e14a558f8ab-3d3d8af0135mr23418085ab.8.1740596646247;
        Wed, 26 Feb 2025 11:04:06 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d3d93fa494sm2117805ab.35.2025.02.26.11.04.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 11:04:05 -0800 (PST)
Message-ID: <8b65adec-8888-40ae-b6c8-358fa836bcc6@kernel.dk>
Date: Wed, 26 Feb 2025 12:04:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv7 1/6] io_uring/rw: move fixed buffer import to issue path
To: Keith Busch <kbusch@meta.com>, ming.lei@redhat.com,
 asml.silence@gmail.com, linux-block@vger.kernel.org, io-uring@vger.kernel.org
Cc: bernd@bsbernd.com, csander@purestorage.com,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
References: <20250226182102.2631321-1-kbusch@meta.com>
 <20250226182102.2631321-2-kbusch@meta.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250226182102.2631321-2-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250226_110407_338791_B041399C 
X-CRM114-Status: GOOD (  17.33  )
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

On 2/26/25 11:20 AM, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Registered buffers may depend on a linked command, which makes the prep
> path too early to import. Move to the issue path when the node is
> actually needed like all the other users of fixed buffers.

Conceptually I think this patch is fine, but it does bother me with
random bool arguments. We could fold in something like the (totally
tested) below diff to get rid of that. What do you think?

diff --git a/io_uring/rw.c b/io_uring/rw.c
index 728d695d2552..a8a46a32f20d 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -248,8 +248,8 @@ static int io_prep_rw_pi(struct io_kiocb *req, struct io_rw *rw, int ddir,
 	return ret;
 }
 
-static int io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *sqe,
-		      int ddir, bool do_import)
+static int __io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *sqe,
+			int ddir)
 {
 	struct io_rw *rw = io_kiocb_to_cmd(req, struct io_rw);
 	unsigned ioprio;
@@ -285,14 +285,6 @@ static int io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	rw->len = READ_ONCE(sqe->len);
 	rw->flags = READ_ONCE(sqe->rw_flags);
 
-	if (do_import && !io_do_buffer_select(req)) {
-		struct io_async_rw *io = req->async_data;
-
-		ret = io_import_rw_buffer(ddir, req, io, 0);
-		if (unlikely(ret))
-			return ret;
-	}
-
 	attr_type_mask = READ_ONCE(sqe->attr_type_mask);
 	if (attr_type_mask) {
 		u64 attr_ptr;
@@ -307,27 +299,52 @@ static int io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	return ret;
 }
 
+static int io_rw_do_import(struct io_kiocb *req, int ddir)
+{
+	if (!io_do_buffer_select(req)) {
+		struct io_async_rw *io = req->async_data;
+		int ret;
+
+		ret = io_import_rw_buffer(ddir, req, io, 0);
+		if (unlikely(ret))
+			return ret;
+	}
+
+	return 0;
+}
+
+static int io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *sqe,
+		      int ddir)
+{
+	int ret;
+
+	ret = __io_prep_rw(req, sqe, ddir);
+	if (unlikely(ret))
+		return ret;
+
+	return io_rw_do_import(req, ITER_DEST);
+}
+
 int io_prep_read(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 {
-	return io_prep_rw(req, sqe, ITER_DEST, true);
+	return io_prep_rw(req, sqe, ITER_DEST);
 }
 
 int io_prep_write(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 {
-	return io_prep_rw(req, sqe, ITER_SOURCE, true);
+	return io_prep_rw(req, sqe, ITER_SOURCE);
 }
 
 static int io_prep_rwv(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 		       int ddir)
 {
-	const bool do_import = !(req->flags & REQ_F_BUFFER_SELECT);
 	int ret;
 
-	ret = io_prep_rw(req, sqe, ddir, do_import);
+	ret = io_prep_rw(req, sqe, ddir);
 	if (unlikely(ret))
 		return ret;
-	if (do_import)
-		return 0;
+	if (!(req->flags & REQ_F_BUFFER_SELECT))
+		return io_rw_do_import(req, ddir);
 
 	/*
 	 * Have to do this validation here, as this is in io_read() rw->len
@@ -364,12 +381,12 @@ static int io_init_rw_fixed(struct io_kiocb *req, unsigned int issue_flags,
 
 int io_prep_read_fixed(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 {
-	return io_prep_rw(req, sqe, ITER_DEST, false);
+	return io_prep_rw(req, sqe, ITER_DEST);
 }
 
 int io_prep_write_fixed(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 {
-	return io_prep_rw(req, sqe, ITER_SOURCE, false);
+	return io_prep_rw(req, sqe, ITER_SOURCE);
 }
 
 /*
@@ -385,7 +402,7 @@ int io_read_mshot_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	if (!(req->flags & REQ_F_BUFFER_SELECT))
 		return -EINVAL;
 
-	ret = io_prep_rw(req, sqe, ITER_DEST, false);
+	ret = io_prep_rw(req, sqe, ITER_DEST);
 	if (unlikely(ret))
 		return ret;
 

-- 
Jens Axboe

