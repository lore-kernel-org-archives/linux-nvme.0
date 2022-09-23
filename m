Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CCF6C07E9D
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Sep 2022 20:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0pguD5ERzMg1kriRPNLUHasBeFWgUGfxhoverUsEc0M=; b=YNr4Byf+N7nKk2WOBZONFpuJKa
	SRhQtyxWrAZgkN5JK2VnqyzmcnTdyZywpR9ceWTaUr3kj2NTUj4GbPNU/HLfYjBMiViHdPP5XA+mY
	3QJBb5G6t2qK6eifUgwse4s3N1A3QnZHacejYqgcIBPyhzhG3cuahBQFhcLATLsCrGa8EvXBG4aXy
	4QW5TYDq++I8cbyTk7bZKakxQPHM587EPVvbjF/l3U3IjKfqWIjHrHvFi2PJnpDUk6MV5AAc6Ijwr
	eBqItAmpFmdVwQ5Ppg7fUvDrNs41Oah7BDcQm7/OoVHRCi1FyP4TPZflsAa9HtDEM4YDwBvaoa2sy
	m+/Vl1hQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obpfR-005gpO-Qw; Fri, 23 Sep 2022 20:53:01 +0000
Received: from mail-il1-x131.google.com ([2607:f8b0:4864:20::131])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obpfO-005gnk-4T
	for linux-nvme@lists.infradead.org; Fri, 23 Sep 2022 20:52:59 +0000
Received: by mail-il1-x131.google.com with SMTP id y15so770379ilq.4
        for <linux-nvme@lists.infradead.org>; Fri, 23 Sep 2022 13:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=0pguD5ERzMg1kriRPNLUHasBeFWgUGfxhoverUsEc0M=;
        b=W4fL5OpwMiLHCLHE6MA2VCMfatp1lEDsHdXjApFf75g7A4o+b8aKbVcI2KDIo696Sf
         ts4bZDR0j+B276oegyXKnN+/RxXID8cue/ScCc97/2L+SgbpwsyoD/qVuEJ3vgHecKgm
         QhBq/Coo3EkCwb0NWw1nV3SYN8cZYAfdGPOV2KuoKrZ2uXLiKOMUW5Zq4h1e9brDFza7
         KZYpR/a7iPwI7CH9yCogOVqua9QX48YTJgn6iLkamB8YCjrs38jCEChdL4oWULr37DVZ
         vEbPIOVck+OooX2/aeTEvnEsSJgpQh79dHs4hOCXuzbmiIFdBvTolv7lLs+kfig45Bfj
         YE2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=0pguD5ERzMg1kriRPNLUHasBeFWgUGfxhoverUsEc0M=;
        b=PY/Dc1DeU/5m5rvqpmG7q9fOw+F6Yq51+rZu83cbmAgxerHkPCuWfCAUiDHLHjl+1w
         8lF52MmWHTmh6FW11p/1/T6htFAhNXRWB0brXr3neu1TIr+8b7kaoAGGwvBoooff5IHa
         4gzZ8uuNyX4bqe4BXDSIuZym4fqLIxdWEUC0rLog5MhPTCHVywl6JhOtdVZ7ieqawIq2
         2uWV0nU0bXBLBZ+8GHBNbUsdbbIH53UKqnm+0I9lpibwuBYK0WS/zTOQJ97fxP/4n9Bm
         9mgOT2JPzNcUXss/BjvGonf+56wGs+l9Bgk6Mc38wK/bjwoK8S/9dSbDcQlCAvZuXTYQ
         gNDw==
X-Gm-Message-State: ACrzQf1vnnn3+NeMF2lmQRw2mZG5NuDQ8pPXyuUVXo5fixDL7TeMzC9h
	ku9oCEdv9TTcRpmsLYNKfJfBgw==
X-Google-Smtp-Source: AMsMyM51Ya2I8nFxvsCDC+9xPjmakd9dYpKCi1drkHVeMaH4beOmC4A8dpyYLut3dXaUzPsJEosJQQ==
X-Received: by 2002:a05:6e02:15c5:b0:2d7:a1cf:6f87 with SMTP id q5-20020a056e0215c500b002d7a1cf6f87mr5040089ilu.30.1663966376003;
        Fri, 23 Sep 2022 13:52:56 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id e23-20020a0566380cd700b00352ce4f5e72sm1201219jak.179.2022.09.23.13.52.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 13:52:55 -0700 (PDT)
Message-ID: <d09e1645-919f-9239-f86d-a8e85a133e5c@kernel.dk>
Date: Fri, 23 Sep 2022 14:52:54 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 4/5] nvme: split out metadata vs non metadata end_io
 uring_cmd completions
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-nvme@lists.infradead.org, Stefan Roesch <shr@fb.com>
References: <20220922182805.96173-1-axboe@kernel.dk>
 <20220922182805.96173-5-axboe@kernel.dk> <Yy3O7wH16t6AhC3j@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Yy3O7wH16t6AhC3j@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220923_135258_430693_A9BF6A1E 
X-CRM114-Status: GOOD (  18.71  )
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

On 9/23/22 9:21 AM, Christoph Hellwig wrote:
>> +	union {
>> +		struct {
>> +			void *meta; /* kernel-resident buffer */
>> +			void __user *meta_buffer;
>> +		};
>> +		struct {
>> +			u32 nvme_flags;
>> +			u32 nvme_status;
>> +			u64 result;
>> +		};
>> +	};
> 
> Without naming the arms of the union this is becoming a bit too much
> of a mess..
> 
>> +static void nvme_uring_task_cb(struct io_uring_cmd *ioucmd)
>> +{
>> +	struct nvme_uring_cmd_pdu *pdu = nvme_uring_cmd_pdu(ioucmd);
>> +	int status;
>> +
>> +	if (pdu->nvme_flags & NVME_REQ_CANCELLED)
>> +		status = -EINTR;
>> +	else
>> +		status = pdu->nvme_status;
> 
> If you add a signed int field you only need one field instead of
> two in the pdu for this (the nvme status is only 15 bits anyway).

For both of these, how about we just simplify like below? I think
at that point it's useless to name them anyway.


diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 25f2f6df1602..6f955984ca14 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -350,16 +350,13 @@ struct nvme_uring_cmd_pdu {
 		struct request *req;
 	};
 	u32 meta_len;
+	u32 nvme_status;
 	union {
 		struct {
 			void *meta; /* kernel-resident buffer */
 			void __user *meta_buffer;
 		};
-		struct {
-			u32 nvme_flags;
-			u32 nvme_status;
-			u64 result;
-		};
+		u64 result;
 	};
 };
 
@@ -396,17 +393,11 @@ static void nvme_uring_task_meta_cb(struct io_uring_cmd *ioucmd)
 static void nvme_uring_task_cb(struct io_uring_cmd *ioucmd)
 {
 	struct nvme_uring_cmd_pdu *pdu = nvme_uring_cmd_pdu(ioucmd);
-	int status;
-
-	if (pdu->nvme_flags & NVME_REQ_CANCELLED)
-		status = -EINTR;
-	else
-		status = pdu->nvme_status;
 
 	if (pdu->bio)
 		blk_rq_unmap_user(pdu->bio);
 
-	io_uring_cmd_done(ioucmd, status, pdu->result);
+	io_uring_cmd_done(ioucmd, pdu->nvme_status, pdu->result);
 }
 
 static enum rq_end_io_ret nvme_uring_cmd_end_io(struct request *req,
@@ -417,8 +408,10 @@ static enum rq_end_io_ret nvme_uring_cmd_end_io(struct request *req,
 	void *cookie = READ_ONCE(ioucmd->cookie);
 
 	req->bio = pdu->bio;
-	pdu->nvme_flags = nvme_req(req)->flags;
-	pdu->nvme_status = nvme_req(req)->status;
+	if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
+		pdu->nvme_status = -EINTR;
+	else
+		pdu->nvme_status = nvme_req(req)->status;
 	pdu->result = le64_to_cpu(nvme_req(req)->result.u64);
 
 	/*

-- 
Jens Axboe

