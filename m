Return-Path: <SRS0=ZogQ=IQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC16C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 18:40:50 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C619464F01
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 18:40:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C619464F01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3ZlKz/ZBHn1BDUFAlxMo60r/fXOnffDzB6l5S3tSfrM=; b=iNjDZLsHp8PWSOSzb7LBPRgwj
	VCT85suzIE+IdKyczkapYu3CPMbDxhgQd6+iBzXWIcVZ+avmN5mFNmWiMAwWD8P4w27BJ1W5PCelK
	FGdGFG6y9Wmb0KsSHWWV1zJlLvysQBOe1z1Yv/k+VceVxoJBlohTEkc4fPT/QZWZUNLT5qxbDSQ5/
	JPByS9Jxcv36Hc2kIQsE6OL3lWI73WCmi8Zh+B73r8obm+QlO6/0Nr7GxWRmOOOMKxMOnqbxItmsq
	ybrpy40Z19YIjzJvcz3+hENbIKc2I+diV4IyIC4IrvTccLv8b8brloSuBNjdM/Zdj4wbu8V7QlpQx
	k8/1w9T5g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMxZU-005rXs-EH; Thu, 18 Mar 2021 18:40:36 +0000
Received: from mail-il1-x12c.google.com ([2607:f8b0:4864:20::12c])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMxZN-005rWn-0P
 for linux-nvme@lists.infradead.org; Thu, 18 Mar 2021 18:40:34 +0000
Received: by mail-il1-x12c.google.com with SMTP id c17so5820030ilj.7
 for <linux-nvme@lists.infradead.org>; Thu, 18 Mar 2021 11:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ONx/uzdjfT0b5DHLqgA8kDbyHozHRRxaNQcXVrCxzSU=;
 b=0y6dXe4TfriBKq4GhmgaKg+aFdpyDIGsEHZT2scZlEX2DtP0M2ztbnLtIt3EWgUXZW
 N+isKVmpQ+0COSV0Pqlp2jsI2DgIhqJWaV4T+or+KC/aIh1vQcLPsYuW+mJR+OXYT21c
 soU7faQAFj0cQq9mDxr9sKsVHDcmZfP+A8MgonApfixEt0dbU/L2mj3YiBjZwGqKWV1D
 NdmZkYX49ZhN/jmjvnvpp6hiQaYG/O3UD7BA3+yOm7E5qI7c4V3ce2RFviIrl8AN3dXc
 S2+IKNOaPPjCs4ThaOGO8VIEFWx/c7A3yMqLHUHrD7gxQ7+fPtroq5nKT02ABmHkjBF8
 DYtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ONx/uzdjfT0b5DHLqgA8kDbyHozHRRxaNQcXVrCxzSU=;
 b=a1+pGBAtWPaTZ4QxOtK5c4Ce/EsXT/gdLWPiOcMrfT2E+IuApxNMEEMDqbyfwIz+SY
 684yQcXXQA9sFoEmawQeok1AvONudQ3ZuelhZnA6eSDvYJ6jv0pAPP6JztQaNcgdmD+U
 ex6sL++UJTmTCR1VtLgXrqeJGtzFnnOVixOZ8p8kZs4V0kY2h5sg3JRypUmjViEVpwBY
 a9ulRov1xeAVSpvKm5TDpuFItexOMk9qinoPe4h69st08aOZLsFX9vl3dcPw8JABrm1M
 lvMA68uXlt0SPTy5TcM23WTNoWA9r3A/3Yg1ma/hUEBjf3yUIFL3oJqK/N1aUw7toWUK
 tZeA==
X-Gm-Message-State: AOAM531MJhGXz/1diyGwDGPvuzHLXhLAouUms04FrGYZG5KuWnKHGDzU
 xDAajinPQu1wCKfj1Y6+FWF3+uLW8lZ63A==
X-Google-Smtp-Source: ABdhPJx6IXZSAgKiTd5lTyzyPSnE2BiuN3Qv1SYrRqae1YoDrpXgAh9ktmMN8ocox9sIR8gyLPGfdw==
X-Received: by 2002:a92:d58a:: with SMTP id a10mr3275904iln.63.1616092826256; 
 Thu, 18 Mar 2021 11:40:26 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
 by smtp.gmail.com with ESMTPSA id t5sm1423125ilm.69.2021.03.18.11.40.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Mar 2021 11:40:25 -0700 (PDT)
Subject: Re: [PATCH 1/8] io_uring: split up io_uring_sqe into hdr + main
To: Christoph Hellwig <hch@lst.de>
Cc: io-uring@vger.kernel.org, joshi.k@samsung.com, kbusch@kernel.org,
 linux-nvme@lists.infradead.org, metze@samba.org
References: <20210317221027.366780-1-axboe@kernel.dk>
 <20210317221027.366780-2-axboe@kernel.dk> <20210318053454.GA28063@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <04ffff78-4a34-0848-4131-8b3cfd9a24f7@kernel.dk>
Date: Thu, 18 Mar 2021 12:40:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210318053454.GA28063@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210318_184030_582870_609D71F5 
X-CRM114-Status: GOOD (  34.32  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 3/17/21 11:34 PM, Christoph Hellwig wrote:
>> @@ -14,11 +14,22 @@
>>  /*
>>   * IO submission data structure (Submission Queue Entry)
>>   */
>> +struct io_uring_sqe_hdr {
>> +	__u8	opcode;		/* type of operation for this sqe */
>> +	__u8	flags;		/* IOSQE_ flags */
>> +	__u16	ioprio;		/* ioprio for the request */
>> +	__s32	fd;		/* file descriptor to do IO on */
>> +};
>> +
>>  struct io_uring_sqe {
>> +#ifdef __KERNEL__
>> +	struct io_uring_sqe_hdr	hdr;
>> +#else
>>  	__u8	opcode;		/* type of operation for this sqe */
>>  	__u8	flags;		/* IOSQE_ flags */
>>  	__u16	ioprio;		/* ioprio for the request */
>>  	__s32	fd;		/* file descriptor to do IO on */
>> +#endif
>>  	union {
>>  		__u64	off;	/* offset into file */
>>  		__u64	addr2;
> 
> Please don't do that ifdef __KERNEL__ mess.  We never guaranteed
> userspace API compatbility, just ABI compatibility.

Right, but I'm the one that has to deal with the fallout. For the
in-kernel one I can skip the __KERNEL__ part, and the layout is the
same anyway.

> But we really do have a biger problem here, and that is ioprio is
> a field that is specific to the read and write commands and thus
> should not be in the generic header.  On the other hand the
> personality is.
> 
> So I'm not sure trying to retrofit this even makes all that much sense.
> 
> Maybe we should just define io_uring_sqe_hdr the way it makes
> sense:
> 
> struct io_uring_sqe_hdr {
> 	__u8	opcode;	
> 	__u8	flags;
> 	__u16	personality;
> 	__s32	fd;
> 	__u64	user_data;
> };
> 
> and use that for all new commands going forward while marking the
> old ones as legacy.
> 
> io_uring_cmd_sqe would then be:
> 
> struct io_uring_cmd_sqe {
>         struct io_uring_sqe_hdr	hdr;
> 	__u33			ioc;
> 	__u32 			len;
> 	__u8			data[40];
> };
> 
> for example.  Note the 32-bit opcode just like ioctl to avoid
> getting into too much trouble due to collisions.

I was debating that with myself too, it's essentially making
the existing io_uring_sqe into io_uring_sqe_v1 and then making a new
v2 one. That would impact _all_ commands, and we'd need some trickery
to have newly compiled stuff use v2 and have existing applications
continue to work with the v1 format. That's very different from having
a single (or new) opcodes use a v2 format, effectively.

Looking into the feasibility of this. But if that is done, there are
other things that need to be factored in, as I'm not at all interested
in having a v3 down the line as well. And I'd need to be able to do this
seamlessly, both from an application point of view, and a performance
point of view (no stupid conversions inline).

Things that come up when something like this is on the table

- Should flags be extended? We're almost out... It hasn't been an
  issue so far, but seems a bit silly to go v2 and not at least leave
  a bit of room there. But obviously comes at a cost of losing eg 8
  bits somewhere else.

- Is u8 enough for the opcode? Again, we're nowhere near the limits
  here, but eventually multiplexing might be necessary.

That's just off the top of my head, probably other things to consider
too.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
