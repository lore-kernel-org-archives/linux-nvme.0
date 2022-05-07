Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0362C433EF
	for <linux-nvme@archiver.kernel.org>; Sat,  7 May 2022 12:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qBW1EXKGUeQrlcaUCq/1s8UAzcPPcWNYauWhX+6w4hY=; b=TRL6FvcyQXkBLZjt91383l3shQ
	bL2wZaCCnegE2WeXGUj9vzrCX+08Ug6bj6n2rugHDhdvVoEvZ5bNEJHDVWi/mh2t1qVPSkvuqtsra
	Sng8gW5TYY62JufZJCBj7Nvw2NUnrT4BsqARIyw2pLnaPWrinzrNvNItfdLTYsnthB3DXEp4SriCc
	qAWhhC3rEIj8yJg6EjPUUOxgGnq2tZ2wQv1mwPUFsb8y2B6gjxFJ5fXvAdzbx/7FxKWhMn2ytzn/s
	sx5xcwllX+I8yg82AiLyBJEe/lGqowLgakvoELquB0iWEmc3v2GrtN4+jAmIDbHZt0HFQNU/to/3I
	8Ul27gCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nnJwI-007BuM-6a; Sat, 07 May 2022 12:53:38 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nnJwE-007BtA-Mp
 for linux-nvme@lists.infradead.org; Sat, 07 May 2022 12:53:36 +0000
Received: by mail-pl1-x631.google.com with SMTP id k1so9852154pll.4
 for <linux-nvme@lists.infradead.org>; Sat, 07 May 2022 05:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=qBW1EXKGUeQrlcaUCq/1s8UAzcPPcWNYauWhX+6w4hY=;
 b=vlBQ8e1xW2V0wpHdIzbgo+jglaeGGZLPL6LYA8iGYfrantof/N7FW8eOJNsewQxYhS
 wa2Tt8kKKnyTx6ZzQ9biCYwISFfw6ubjms8Gg6q0Vb1jWt7rD2sE1hYy5muS7L3ltQme
 1tMvze3FwD+53PRp3BLqIAVLTlHAtVrg8d5vfy7F0F4yQtbwjXRNeEDves2XQEXx7Fhl
 QuDrl86dbymzLCPmPFpWC9eBMuBnX3gm7W95j5ggxN0XUZZBUFVUorGMq4Ztw5/r/C6U
 zRrDCg8yyDF55qpBD3ofIfM05udL8GNF9y7fNxNYXlj6DRMZ0N7K02o09QIoNfGYh6Um
 CyMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=qBW1EXKGUeQrlcaUCq/1s8UAzcPPcWNYauWhX+6w4hY=;
 b=ix04t98XgeZNjXOJ/w8PS4Rn0K5iOOUF1TiYuozTgzvYd1YBq7RE/W1XPUd92a0mst
 aIekShgbKQLkuNAb/YmOtY1LV3it++CgmDr+SR49eefIIoAwdzHeFhr4KL3as9jYr9yO
 RhdtruQp3kK/l7qj7DEa22LMU1kl7EhC+LQPziCyDcj61MbidhFDnuqhh42df4A1SFIm
 cbtUdoI42DyNIiERyHEWeFSiBruw74d0c53SXsCHvPvv5roaq2q6+l30DZf2QZpVoQqj
 IJobw2GC5OnRVcIpsxs2ec5HZqlbv3inPm0P92RcXJsK7S/62wBeEHRvISZPgdkwk3q0
 KI9Q==
X-Gm-Message-State: AOAM533qmubsDo6q5YpHaaikcGIxF5hzJi+o8PQkcWG2/aPO+RqnNoTq
 45bal5Tz7qUYTZMq7kmZcKQoRg==
X-Google-Smtp-Source: ABdhPJwg0Pxo91rBnLOcJHAYfdSXGgBf3FrwDBoOVvOt4TBI13HNJZ/EhYdxfTGetwUkqeRfvMjI/Q==
X-Received: by 2002:a17:902:c952:b0:15e:9e3d:8e16 with SMTP id
 i18-20020a170902c95200b0015e9e3d8e16mr8448104pla.51.1651928012758; 
 Sat, 07 May 2022 05:53:32 -0700 (PDT)
Received: from [192.168.4.166] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
 by smtp.gmail.com with ESMTPSA id
 n12-20020a170902968c00b0015e8d4eb244sm3584932plp.142.2022.05.07.05.53.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 May 2022 05:53:31 -0700 (PDT)
Message-ID: <d315712a-0792-d15f-040d-3a3922700a53@kernel.dk>
Date: Sat, 7 May 2022 06:53:30 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 4/5] nvme: wire-up uring-cmd support for io-passthru on
 char-device.
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, asml.silence@gmail.com, ming.lei@redhat.com,
 mcgrof@kernel.org, shr@fb.com, joshiiitr@gmail.com, anuj20.g@samsung.com,
 gost.dev@samsung.com
References: <CGME20220505061150epcas5p2b60880c541a4b2f144c348834c7cbf0b@epcas5p2.samsung.com>
 <20220505060616.803816-5-joshi.k@samsung.com>
 <f24d9e5e-34af-9035-ffbc-0a770db0cb20@kernel.dk>
 <20220505134256.GA13109@lst.de>
 <f45c89db-0fed-2c88-e314-71dbda74b4a7@kernel.dk>
 <8ae2c507-ffcc-b693-336d-2d9f907edb76@kernel.dk>
 <20220506082844.GA30405@lst.de>
 <6b0811df-e2a4-22fc-7615-44e5615ce6a4@kernel.dk>
 <20220506145058.GA24077@lst.de>
 <45b5f76b-b186-e0b9-7b24-e048f73942d5@kernel.dk>
 <20220507050317.GA27706@lst.de>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220507050317.GA27706@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220507_055335_010671_90617949 
X-CRM114-Status: GOOD (  27.98  )
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

On 5/6/22 11:03 PM, Christoph Hellwig wrote:
> Getting back to this after a good night's worth of sleep:
> 
> On Fri, May 06, 2022 at 08:57:53AM -0600, Jens Axboe wrote:
>>> Just add this:
>>>
>>> "Add a small helper to act as the counterpart to nvme_add_user_metadata."
>>>
>>> with my signoff:
>>>
>>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>>
>> Both done, thanks.
> 
> I think we're much better of folding "nvme: add nvme_finish_user_metadata
> helper" into "nvme: refactor nvme_submit_user_cmd()" as the first basically
> just redos the split done in the first patch in a more fine grained way
> to allow sharing some of the metadata end I/O code with the uring path,
> and basically only touches code changes in the first patch again.

Yes good point, I've folded the two.

>>>> I did not do your async_size changes, I think you're jetlagged eyes
>>>> missed that this isn't a sizeof thing on a flexible array, it's just the
>>>> offset of it. Hence for non-sqe128, the the async size is io_uring_sqe -
>>>> offsetof where pdu starts, and so forth.
>>>
>>> Hmm, this still seems a bit odd to me.  So without sqe128 you don't even
>>> get the cmd data that would fit into the 64-bit SQE?
>>
>> You do. Without sqe128, you get sizeof(sqe) - offsetof(cmd) == 16 bytes.
>> With, you get 16 + 64, 80.
> 
> Can we please get a little documented helper that does this instead of
> the two open coded places?

How about we just add a comment? We use it in two spots, but one has
knowledge of the sqe64 vs sqe128 state, the other one does not. Hence
not sure how best to add a helper for this. One also must be a compile
time constant. Best I can think of is the below. Not the prettiest, but
it does keep it in one spot and with a single comment rather than in two
spots.


diff --git a/fs/io_uring.c b/fs/io_uring.c
index 1860c50f7f8e..0a9b0fde55af 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1044,6 +1044,14 @@ struct io_cancel_data {
 	int seq;
 };
 
+/*
+ * The URING_CMD payload starts at 'cmd' in the first sqe, and continues into
+ * the following sqe if SQE128 is used.
+ */
+#define uring_cmd_pdu_size(is_sqe128)				\
+	((1 + !!(is_sqe128)) * sizeof(struct io_uring_sqe) -	\
+		offsetof(struct io_uring_sqe, cmd))
+
 struct io_op_def {
 	/* needs req->file assigned */
 	unsigned		needs_file : 1;
@@ -1286,8 +1294,7 @@ static const struct io_op_def io_op_defs[] = {
 	[IORING_OP_URING_CMD] = {
 		.needs_file		= 1,
 		.plug			= 1,
-		.async_size		= 2 * sizeof(struct io_uring_sqe) -
-					  offsetof(struct io_uring_sqe, cmd),
+		.async_size		= uring_cmd_pdu_size(1),
 	},
 };
 
@@ -4947,11 +4954,9 @@ EXPORT_SYMBOL_GPL(io_uring_cmd_done);
 
 static int io_uring_cmd_prep_async(struct io_kiocb *req)
 {
-	size_t cmd_size = sizeof(struct io_uring_sqe) -
-				offsetof(struct io_uring_sqe, cmd);
+	size_t cmd_size;
 
-	if (req->ctx->flags & IORING_SETUP_SQE128)
-		cmd_size += sizeof(struct io_uring_sqe);
+	cmd_size = uring_cmd_pdu_size(req->ctx->flags & IORING_SETUP_SQE128);
 
 	memcpy(req->async_data, req->uring_cmd.cmd, cmd_size);
 	return 0;

-- 
Jens Axboe


