Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A505C433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Apr 2022 05:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hEL9d85mYQeQC9/kr7P7vJsPNhuVPSgzuNHr+CnRjLI=; b=1qRaSS+QQZHP5/Kw+e4ARnCcUQ
	+UNGZVvVSd8kj0o490i0zMbR64olvrA83N5ieqq/aLviWwegKnR2PC2R0fmbqwvJU4gXHv4UwHgM0
	Dd3mVv1Pbrm/k4LBo1N3x+jK0c7jQ42IEn3i4t/7R6d+lBpR7wVEGohdb7KVC2hIYuQl/lWnVf5W5
	2/lwOz+O6xt7Jtpfhikj7w4JH3yQYD2/t1zE+J4Ywac/S/4ZG8mHDQMkElzhPYMm4cvoFc1iMcwSm
	A0QlimL0UAvp/tEYf+oI+hsIsVSCPdqDpr2Rw/ofiPiS2jYno0sGDDuvWGIL7I5/oINPqQk9reLDG
	oL2UyiTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nbcDC-00HEaH-Ov; Tue, 05 Apr 2022 05:58:42 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbcDA-00HEZ0-3s
 for linux-nvme@lists.infradead.org; Tue, 05 Apr 2022 05:58:41 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 1231868AFE; Tue,  5 Apr 2022 07:58:36 +0200 (CEST)
Date: Tue, 5 Apr 2022 07:58:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
 axboe@kernel.dk, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, ming.lei@redhat.com,
 mcgrof@kernel.org, pankydev8@gmail.com, javier@javigon.com,
 joshiiitr@gmail.com, anuj20.g@samsung.com
Subject: Re: [RFC 3/5] io_uring: add infra and support for IORING_OP_URING_CMD
Message-ID: <20220405055835.GC23698@lst.de>
References: <20220401110310.611869-1-joshi.k@samsung.com>
 <CGME20220401110834epcas5p4d1e5e8d1beb1a6205d670bbcb932bf77@epcas5p4.samsung.com>
 <20220401110310.611869-4-joshi.k@samsung.com> <20220404071656.GC444@lst.de>
 <e039827d-ab7b-1791-d06c-a52ebc949de8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e039827d-ab7b-1791-d06c-a52ebc949de8@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220404_225840_340181_FA93C5D3 
X-CRM114-Status: GOOD (  26.03  )
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

On Mon, Apr 04, 2022 at 09:20:00AM +0100, Pavel Begunkov wrote:
>> I'm still not a fund of the double indirect call here.  I don't really
>> have a good idea yet, but I plan to look into it.
>
> I haven't familiarised myself with the series properly, but if it's about
> driver_cb, we can expose struct io_kiocb and io_req_task_work_add() so
> the lower layers can implement their own io_task_work.func. Hopefully, it
> won't be inventively abused...

If we move io_kiocb out avoiding one indirection would be very easy
indeed.  But I think that just invites abuse.  Note that we also have
at least one and potentially more indirections in this path.  The
request rq_end_io handler is a guranteed one, and the IPI or softirq
for the request indirectin is another one.  So my plan was to look
into having an io_uring specific hook in the core block code to
deliver completions directly to the right I/O uring thread.  In the
best case that should allow us to do a single indirect call for
the completion instead of 4 and a pointless IPI/softirq.

>>> +	struct io_kiocb *req = container_of(ioucmd, struct io_kiocb, uring_cmd);
>>> +
>>> +	if (ret < 0)
>>> +		req_set_fail(req);
>>> +	io_req_complete(req, ret);
>>> +}
>>> +EXPORT_SYMBOL_GPL(io_uring_cmd_done);
>>
>> It seems like all callers of io_req_complete actually call req_set_fail
>> on failure.  So maybe it would be nice pre-cleanup to handle the
>> req_set_fail call from ĩo_req_complete?
>
> Interpretation of the result is different, e.g. io_tee(), that was the
> reason it was left in the callers.

Yes, there is about two of them that would then need to be open coded
using __io_req_complete.

>
> [...]
>>> @@ -60,7 +62,10 @@ struct io_uring_sqe {
>>>   		__s32	splice_fd_in;
>>>   		__u32	file_index;
>>>   	};
>>> -	__u64	__pad2[2];
>>> +	union {
>>> +		__u64	__pad2[2];
>>> +		__u64	cmd;
>>> +	};
>>
>> Can someone explain these changes to me a little more?
>
> not required indeed, just
>
> -	__u64	__pad2[2];
> +	__u64	cmd;
> +	__u64	__pad2;

Do we still want a union for cmd and document it to say what
opcode it is for?

