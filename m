Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D801AC8303C
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jul 2025 12:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ISbJeBw9NAi5f57BeJCVw181+eBAYp7u8b9Kdohio9o=; b=agaG3IPyoFQyNbr1+/5PX0Cf7u
	iXXqKXChHYlfMJWXdytlg7oYFxcc1j02AVT27Y1IoZSktaoYq3SiRTkKvNt6tHVXZWJiyWF7hpO2F
	KmvPwVlUWvWgQWqxKPZsx4hUA2laUoUmiaU8RTU759f8T7cfAg1RfpYTEh2/NIba6sl4vfOsK74ss
	hCKz43+lJTRSsVbT37AWl7vPWdxrnciDQBZ0WkJn/Agk6Op0P3Y5oTJcp/yUarukBSflAu1V+khLd
	jvwnUU8zn+sHSaiMuENNEVBMkuwdHvO0ZeakFESPNWGn9+KYk4DT0LP7A9n76Svd6CGPZcnEnkkvz
	7Edes7vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYlRl-00000002TE1-0Ert;
	Mon, 07 Jul 2025 12:59:49 +0000
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYjnn-00000002FdK-3OVL
	for linux-nvme@lists.infradead.org;
	Mon, 07 Jul 2025 11:14:28 +0000
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-ae0dd7ac1f5so548974766b.2
        for <linux-nvme@lists.infradead.org>; Mon, 07 Jul 2025 04:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751886866; x=1752491666; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ISbJeBw9NAi5f57BeJCVw181+eBAYp7u8b9Kdohio9o=;
        b=S8/rzkIwY/ofHoSo/0MBhgeoMcPT7kgg8PQNpuFVFGVZfppRm+dBZO1MBsqqJmE+CR
         8DMhpD5Na6JorgdXWhcGQ3PO8SYuWUSPnpIX0cO3WSTiSr3NOOiqOjpxa38Fw/sUtp+3
         wxPPwbfOn57UaT+YANMvixN+N9kZF9k1bLHzuNP/yEEdfVW/4giYUHYeewji2uOTpC4D
         Pd8WgaKg96PWdvvr3iVWi78wAMHTci3Aol/a0HPql6ag9KgIIv8a1HVBgYw+YyeEO1mh
         2W94dyQZ3dWBXxgoZrZGuOQPARHsc/Swqi2UG0GO9R9pavkl2QYYrBdfH77nYkbrylqA
         9EjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751886866; x=1752491666;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ISbJeBw9NAi5f57BeJCVw181+eBAYp7u8b9Kdohio9o=;
        b=nGeT7ZwCK+jA8J45E6pzJgJ50ZvT77hHdc1vzOwzs/xUT7F/ubBDNlNSImpOFuuwQ3
         e4Lh7T8BQhT1ekMRSn7743IIHgBinNrOD+zEpNmLeShkBJ4TK+Tvl6Ew6JgNX9UG5mNI
         InlJFO4RViMvYOw5N6mYbGT+DNo2CifMjDABPcKfY65oAJVHnVKI3ffZJwXoKjOxrpM4
         uvZSQt35vz/CFgzBNrnKkoHcJmVw0kbpbOqwDRpjMBy9GgmdvCVQy8gzsXcDNVbxOgL7
         lzFymepA6RYTAbcjrXbM/HADlyazbqL2b/rijqfkzIxkB7TZdO3IMBhO7wiKJNUDh1O0
         F+5w==
X-Forwarded-Encrypted: i=1; AJvYcCVUF49dg29iAFLSEGZtZ9/G+2lyI7DvzJqH+6cYG+Cj2jPwLvfzrWAz9nEXNIP3CW6IEilbRdG2vDeX@lists.infradead.org
X-Gm-Message-State: AOJu0YzaWe/BaIQoL2AMuy7/AGdXuzbNbAKuxp1arBTBblbr9JQKgBWJ
	Lv0r342PQiCOZ38jkrhQNNM5DsXyg8KzbOPkJ1rb8KKsgJjxrJBdEuujLUDqzg==
X-Gm-Gg: ASbGncvluACxTkWv3RKLnsXQYK1w/9OkVChciuTEeZhVwOR4oixQyGd/AvDb1BDXICe
	ikOo5kHgvJptR46ZYcFzBcd5IwHf/0udRgsZUBIK4QyIbcVSOjn+hF72QDQ4aK+YYB7ZTc518zO
	rnlSd4NsGk9Py+uJ7x8vGmYYlVlvHft/+ePa/1/BL4IdrNWMTIyDY+PreoNpzDbHJpx78GezYU8
	oro+HiGRKXN56VWUQBJHym7Zzh1BwATxb6kINfrQCT0RbDJM8BfXg/Aa8cmt8o5Wx0OKr80E59z
	Glyz0J7VuOK2c7ILB402OvNNmUM6mFg6dBdhk5YWLsqNIpgCqwao9FPqBxhMvCx/jbOCYPpS1nD
	yMPANx1vLxg==
X-Google-Smtp-Source: AGHT+IHXy0DieX4Ryfe7fnqNm2npiGA05vFcH84u4de0iwjmdTb2PEXlvbji/iKcic0iBMD+4uS9wg==
X-Received: by 2002:a17:907:dab:b0:ae0:c523:780c with SMTP id a640c23a62f3a-ae4108c85a2mr739098066b.5.1751886865420;
        Mon, 07 Jul 2025 04:14:25 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::1ac? ([2620:10d:c092:600::1:adc3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6b0336asm688993666b.115.2025.07.07.04.14.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 04:14:24 -0700 (PDT)
Message-ID: <f2216c30-6540-4b1a-b798-d9a3f83547b2@gmail.com>
Date: Mon, 7 Jul 2025 12:15:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 00/12] io_uring dmabuf read/write support
To: Christoph Hellwig <hch@infradead.org>
Cc: io-uring@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, David Wei <dw@davidwei.uk>,
 Vishal Verma <vishal1.verma@intel.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
References: <cover.1751035820.git.asml.silence@gmail.com>
 <aGaSb5rpLD9uc1IK@infradead.org>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <aGaSb5rpLD9uc1IK@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250707_041427_852337_5BF0C2F3 
X-CRM114-Status: GOOD (  20.98  )
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

On 7/3/25 15:23, Christoph Hellwig wrote:
> [Note: it would be really useful to Cc all relevant maintainers]

Will do next time

> On Fri, Jun 27, 2025 at 04:10:27PM +0100, Pavel Begunkov wrote:
>> This series implements it for read/write io_uring requests. The uAPI
>> looks similar to normal registered buffers, the user will need to
>> register a dmabuf in io_uring first and then use it as any other
>> registered buffer. On registration the user also specifies a file
>> to map the dmabuf for.
> 
> Just commenting from the in-kernel POV here, where the interface
> feels wrong.
> 
> You can't just expose 'the DMA device' up file operations, because
> there can be and often is more than one.  Similarly stuffing a
> dma_addr_t into an iovec is rather dangerous.
> 
> The model that should work much better is to have file operations
> to attach to / detach from a dma_buf, and then have an iter that
> specifies a dmabuf and offsets into.  That way the code behind the
> file operations can forward the attachment to all the needed
> devices (including more/less while it remains attached to the file)
> and can pick the right dma address for each device.

By "iter that specifies a dmabuf" do you mean an opaque file-specific
structure allocated inside the new fop? Akin to what Keith proposed back
then. That sounds good and has more potential for various optimisations.
My concern would be growing struct iov_iter by an extra pointer:

struct dma_seg {
	size_t 	off;
	unsigned len;
};

struct iov_iter {
	union {
		struct iovec *iov;
		struct dma_seg *dmav;
		...
	};
	void *dma_token;	
};

But maybe that's fine. It's 40B -> 48B, and it'll get back to
40 when / if xarray_start / ITER_XARRAY is removed.

> I also remember some discussion that new dma-buf importers should
> use the dynamic imported model for long-term imports, but as I'm
> everything but an expert in that area I'll let the dma-buf folks
> speak.

I'll take a look

-- 
Pavel Begunkov


