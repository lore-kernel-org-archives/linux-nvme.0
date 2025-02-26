Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D29C0C021B8
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2025 20:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XQY1cNnksnM7mm0vxRtHto+/6pTEYFjzebFLJCOPIWo=; b=1tXGJQvQhMKv+yx0ZChcrAjFqG
	q7EflBkvCoKmJZfJQtkdsyHhmT5J2DhxPF0wY8f7qG6AZFZ5UNu+D5SJtKdRAghQfXnx1pN/Cr8uQ
	OWHsQ5+BaJAVggpiuFB4vbq4+4X7P3/RsTW6AR5o188YYUd16Mm9HL3k7ZBZA6BIooqgHrc0CakHJ
	uYC6VA3Y7rm4rNA9Bm3BJRMmf1T//JsUa4+vwyOrIEg/vELGndf/rOkAtV72A5lOS9ab+S0htDDiT
	saJsPK1aCXzESS8nU3Bsk1F/eoxBwl5CGJkcbkHDiAoAIy5wzLgyiz0GKxJW5cdZtFzl39N3Vlb9j
	GeJcWaxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnNtO-00000005Jhi-0IP5;
	Wed, 26 Feb 2025 20:20:30 +0000
Received: from mail-io1-xd2a.google.com ([2607:f8b0:4864:20::d2a])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnNtK-00000005Jh8-3Vr5
	for linux-nvme@lists.infradead.org;
	Wed, 26 Feb 2025 20:20:28 +0000
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-856295d1f6cso14160739f.3
        for <linux-nvme@lists.infradead.org>; Wed, 26 Feb 2025 12:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1740601226; x=1741206026; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XQY1cNnksnM7mm0vxRtHto+/6pTEYFjzebFLJCOPIWo=;
        b=BdEcYSNWH+plpSocvsng8uGvyDoJqtSstyP5teX/QJZqzuqMcL7GRlK+MGzo8FWh6Q
         fA30LYlz8gsAmXpGh0lolZZq+1BrsWZjbc8SC0dLnGgqggc3juQh5v9kLjLHYJtfUQa5
         1yOnrC5M5+RfW4WoSXMUIpKVhfb70UkwBblCTK/WVqxwhVirlrRTjolcRragkuXCiWP3
         2X9sgyBN9T0fHw6VrUdRXb4rrIjeFX7VNbfI93cpO0R2lnsLMCK2AJdqrhLsfxohnioj
         jOy2K+FbR62Q+oSMjgGNiduO0flVmxR+LCD81gV3dpVfrup2y25jQgJZeAxzcl67o3pp
         HMZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740601226; x=1741206026;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XQY1cNnksnM7mm0vxRtHto+/6pTEYFjzebFLJCOPIWo=;
        b=EE9K5tRpUSxN1D3xa719cCpdY/2NvhqqsMmP+AkYChl9M6D8yw2iKoH9TdKApYXPYI
         fxAupHE1NNSqCxXnSuXFFuU8dayQpHI9facLkM+QEx8n4quOxO6woby0Dya9/Tp4CtHA
         o1R/hztGZHeWUBlvGD78QxTEqRFYnfDI7iqkZkyzRLoJm1IlJ32dk9f9IKQHuadQ7bhU
         umLlmBdia5riDgJZNzmMtzZN5c+xfWkMkrZ5pPPUdO8KP/LsS63bZUoy/My1XqqZfxAI
         9yc90JCA6gtjeOE8Dt7kg6eI2YRyYqFWUmV0jV/5COTxfMbgHK/ac9z9cz+BxCCN1tWB
         ERqA==
X-Forwarded-Encrypted: i=1; AJvYcCXl+4s0FECTYgYiDhW6sJ245aGUqytLBAFGAMX1vQ7JH+6C5VAJr0vu4qYEPBt3tFXClNeSwspfy3XK@lists.infradead.org
X-Gm-Message-State: AOJu0YxZVLtAI88XDf+xSlVWjNAhyfHMSuzWJuID6fODjAFvrQpoNbLM
	1TbKah2tqJooA2yPXzAfIXomSs7EyuhZ8xfuknji4f9CXoamIT7LIWIrH+dbnb8=
X-Gm-Gg: ASbGnctjDyAekIHsnu1SiWn3o3wv0Isb0wQPsuPjHTJ3Ok4drgSfrnkBaXTZJIh3GYx
	6mSkLHUDKjQHhdoh94De9NvM19MlZUES97q9hnLk+PDgFyi4O/5C8A8lNhGSbb6MxhaI5XosGp4
	H8rTu/US3yHCZT3d5oG4wxKDaQs6ksibawuZ8lG3JIQxcuJebtCHsFsIln9Kfrss3C29kKJd6p1
	nr3uvlqUgwG4mpGdEZIAn7ijFEj8rsC9/QZZ3XiCNcXUkmA4mCkiA3VPtgOXGSx3Jfn972BYlch
	XbDT3MIdRPWfm+hTXFLEGQ==
X-Google-Smtp-Source: AGHT+IEjEF0cObp94jBCRKJ95+V93f7YSBkOAprO1IawkzEuP1JiGipJ09HNY+mWwbaEPnO8tYx5IQ==
X-Received: by 2002:a05:6e02:1447:b0:3cf:b365:dcf8 with SMTP id e9e14a558f8ab-3d30489daf5mr95555765ab.21.1740601225972;
        Wed, 26 Feb 2025 12:20:25 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f061f38dc5sm7088173.86.2025.02.26.12.20.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 12:20:25 -0800 (PST)
Message-ID: <d1ff0d23-07a4-4123-b30f-446cf849814a@kernel.dk>
Date: Wed, 26 Feb 2025 13:20:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv7 1/6] io_uring/rw: move fixed buffer import to issue path
From: Jens Axboe <axboe@kernel.dk>
To: Keith Busch <kbusch@meta.com>, ming.lei@redhat.com,
 asml.silence@gmail.com, linux-block@vger.kernel.org, io-uring@vger.kernel.org
Cc: bernd@bsbernd.com, csander@purestorage.com,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
References: <20250226182102.2631321-1-kbusch@meta.com>
 <20250226182102.2631321-2-kbusch@meta.com>
 <8b65adec-8888-40ae-b6c8-358fa836bcc6@kernel.dk>
Content-Language: en-US
In-Reply-To: <8b65adec-8888-40ae-b6c8-358fa836bcc6@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250226_122026_886015_91C967D3 
X-CRM114-Status: GOOD (  20.13  )
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

On 2/26/25 12:04 PM, Jens Axboe wrote:
> On 2/26/25 11:20 AM, Keith Busch wrote:
>> From: Keith Busch <kbusch@kernel.org>
>>
>> Registered buffers may depend on a linked command, which makes the prep
>> path too early to import. Move to the issue path when the node is
>> actually needed like all the other users of fixed buffers.
> 
> Conceptually I think this patch is fine, but it does bother me with
> random bool arguments. We could fold in something like the (totally
> tested) below diff to get rid of that. What do you think?
> 
> +static int io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *sqe,
> +		      int ddir)
> +{
> +	int ret;
> +
> +	ret = __io_prep_rw(req, sqe, ddir);
> +	if (unlikely(ret))
> +		return ret;
> +
> +	return io_rw_do_import(req, ITER_DEST);

Oops, should be 'ddir' here too of course. Updated below, does pass my
testing fwiw.


diff --git a/io_uring/rw.c b/io_uring/rw.c
index 728d695d2552..4ac2d004b352 100644
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
+	return io_rw_do_import(req, ddir);
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

