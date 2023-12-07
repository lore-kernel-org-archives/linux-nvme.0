Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25917C4167B
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Dec 2023 20:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S/fBeDJnEKkgjEcCResVDf8TuTKZlfWkayhpulOYu7A=; b=nac1J83y1OCEXDs4goyjCApfEG
	o/jc+I1gbetqzBJGkdHyTo0pzttu6kFQDThHxMRUo1GBgHKdy+5lrb6cKLOekHhQOiQD9tFoHn4Gk
	EXnQxVTv8LOGksHLVF05PCRGdMuC85UG00/Cb0Q/vP2ItnclykAWRXtOLyluEp7mGRl3myXgdF7Hv
	vQFWO0RBV1//1/x8pGw5gPuIuSdi27xU9jrUnK825z+Lc3BJXH1k10PFiGeW0Ty45LZuvmMZ0ATpi
	cGg+m2iMPLh2QiTXCtPBtHCavpRcDa54GZWvRr2Ln4kAQWjxZi+Eu05KxaCl5P+Yq50dNWFiJmbw/
	MbpMY/3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rBL8M-00Drbs-0Q;
	Thu, 07 Dec 2023 20:38:10 +0000
Received: from mail-il1-x136.google.com ([2607:f8b0:4864:20::136])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rBL8J-00DrbR-25
	for linux-nvme@lists.infradead.org;
	Thu, 07 Dec 2023 20:38:08 +0000
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-35d7e22ccfeso1208375ab.0
        for <linux-nvme@lists.infradead.org>; Thu, 07 Dec 2023 12:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1701981485; x=1702586285; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S/fBeDJnEKkgjEcCResVDf8TuTKZlfWkayhpulOYu7A=;
        b=ipgEb+7Csy8X8YdakDNlTu6o+5KE6t0nri/T1OrdEGodikuWiIB214XLNFnvN0X7Ac
         XoSQKHUZh+RYuhRvDT2H7YDkp3B/xwPdat3jdafJK0tyPsFblXr96zWcYu6onKxOaP10
         bKIgN8lpF0PtkL2YxOLgwqzEqP9h7kfpKQkg19X/VpGB5zUEJ71omErY6nHaRqiqQ8SR
         IQZeTF4nd1i/HNjnx4DwwztizXLIhUaQrAWsOJOyovOVEwvDya7PuqrLrwSDA/1iB/Lx
         Vn4PlkUz0bvcHySe95PNNyfoiW2Bry/23Vmd6fevc7weExi6rjFQFKBzhjd/R0QwFTBj
         s8jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701981485; x=1702586285;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S/fBeDJnEKkgjEcCResVDf8TuTKZlfWkayhpulOYu7A=;
        b=VtHxprci7smKBo99G17iVC+uhyoyvzEI99xNMxpJ04M+IA9hu+bz3GDw7M/e+lEI4e
         OQ6sSXs2LZByDsKE0F0P1tcLhNikUoP7Kq7fUolK6Ak/Llv9x0rMoqfKBtIlAJDUxtLf
         dwTS30xaFqbb+fDmRJizl2e1tvX7u+pAfnc3zM+P13dQN9U2ZA6dQssmKdIxNvlNfgiF
         mc/wzzu4IJukXyol6gOmfMmWPk2vQas9sY31XvQ7xQ6z/oH53CyzV7FlGGrEY3vEh7Zz
         VMNE/fgvSmNQHPt/mNV9prsXx9Tv440vsO7Hms21W+FpxumDITzgju8iC6LBzaLY31Xe
         7yMQ==
X-Gm-Message-State: AOJu0YxZqyYu0bR+AA6ONlchEvI7LLny1KxQ3UH+8CBxVB6okSDtGK6v
	4tcZu2AVK2fD9Mq0UMsB54bbsA==
X-Google-Smtp-Source: AGHT+IGnYw0SdQF5/vBPeyAHeDhmLOOpfxCmGYVoG6z1etnTw72S0okEHEfM48b1OIFzZtHzTCf0eQ==
X-Received: by 2002:a05:6e02:2195:b0:35d:6563:971 with SMTP id j21-20020a056e02219500b0035d65630971mr6781282ila.3.1701981485641;
        Thu, 07 Dec 2023 12:38:05 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id p16-20020a92d290000000b0035d6c524cc8sm105999ilp.76.2023.12.07.12.38.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 12:38:05 -0800 (PST)
Message-ID: <d66d032f-e564-4a76-b9ce-cc09ab94188c@kernel.dk>
Date: Thu, 7 Dec 2023 13:38:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-pci: enhance timeout kernel log
Content-Language: en-US
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org, hch@lst.de
Cc: sagi@grimberg.me, Keith Busch <kbusch@kernel.org>
References: <20231207183250.2947699-1-kbusch@meta.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231207183250.2947699-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231207_123807_704625_C2048A56 
X-CRM114-Status: GOOD (  16.32  )
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

On 12/7/23 11:32 AM, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Kernel configs don't necessarily have opcode decoding, and some opcodes
> are not even decodable. It is still interesting for debugging SSD issues
> to know what opcode is timing out, what request type it came from, and
> the data size (if applicable).
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/nvme/host/pci.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index fad4cccce745c..49771919b01f1 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1284,6 +1284,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req)
>  	struct request *abort_req;
>  	struct nvme_command cmd = { };
>  	u32 csts = readl(dev->bar + NVME_REG_CSTS);
> +	u8 opcode;
>  
>  	/* If PCI error recovery process is happening, we cannot reset or
>  	 * the recovery mechanism will surely fail.
> @@ -1361,11 +1362,11 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req)
>  	cmd.abort.cid = nvme_cid(req);
>  	cmd.abort.sqid = cpu_to_le16(nvmeq->qid);
>  
> +	opcode = nvme_req(req)->cmd->common.opcode,
>  	dev_warn(nvmeq->dev->ctrl.device,
> -		"I/O %d (%s) QID %d timeout, aborting\n",
> -		 req->tag,
> -		 nvme_get_opcode_str(nvme_req(req)->cmd->common.opcode),
> -		 nvmeq->qid);
> +		 "I/O %d (%s %d) QID %d timeout, aborting req_op:%u size:%u\n",
> +		 req->tag, nvme_get_opcode_str(opcode), opcode, nvmeq->qid,
> +		 req_op(req), blk_rq_bytes(req));

Your additions look good to me, but I do wish that we'd be equally
verbose on what the other values are. Ala:

	I/O tag %d (opcode: %s %d) ...

would be a lot more useful, for example. I find myself having to dig
into the source for a specific kernel sometimes when looking at various
nvme errors, which is really annoying.

-- 
Jens Axboe


