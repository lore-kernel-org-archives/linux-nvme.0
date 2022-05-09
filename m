Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF40CC433F5
	for <linux-nvme@archiver.kernel.org>; Mon,  9 May 2022 12:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9Wgj59+jDaYn8pUPb9gbkix6V1cj4sjgt4RT2lUhgHw=; b=FqKbNbiRFqMPFrLcydrfj0i4ym
	NEB4SVdPYqB5Esy1Hb4/PYfyMnip5SqitNcV65jEpReEEQrKQFd1mAdiVJKB4niNG9TzncJ3V9PQ8
	esnZOoE0nrFO/PITeWnhUlCLSQD7OzqxgIkjtx4z6PicR1q0u73zOnm/q2noUzu/LzyG5HxzkwL56
	x44DUukEo7Pe8K00miDTRdZZ6O3XHI5CIS3eHMmh02Zs4NkP8I/ZKQ7pwILRrCjalYOW+otQUZ0Bh
	lWZbZ0ZzHQH5dLLlYmwpRrUev/bCYPPbprpFiGB26Au/TUb+Du9MKAoduCYWUncEb1O1d9OmzoABF
	48C5dL0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1no2sU-00ETZE-1g; Mon, 09 May 2022 12:52:42 +0000
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1no2sR-00ETY8-59
 for linux-nvme@lists.infradead.org; Mon, 09 May 2022 12:52:40 +0000
Received: by mail-pl1-x633.google.com with SMTP id k1so13732189pll.4
 for <linux-nvme@lists.infradead.org>; Mon, 09 May 2022 05:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=9Wgj59+jDaYn8pUPb9gbkix6V1cj4sjgt4RT2lUhgHw=;
 b=WExzwDCuPqM0R1Mg+wlehzBNlPxfMRSbCaBan+VCx2JwrbY5ZxLOv1Jht9zauHM9vX
 ztRPLqC43v/0jd9XSxXPckHjmmjosgl0sRWj5UT5VBOTrYg9yZGu/mmuIqBOmKV2R5Ep
 gqPosjp86/X/ZaxKlep044CNoma4/44BpEP2kyHrPBhquXobgiD4AJwDy9kNF6PyBszz
 annrdNxRYVU9PXCv8m0L55XBNHQjDX6vL536Ry6pyqWLzXZrAYKg97Um2a1vTHWot4eL
 oE0I3sFd4q3lbOOWnnBZWOrQWiICO7ryHzJt7Qc0YtDjzRprrEh717xXZu9j0FG6ALbx
 B53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=9Wgj59+jDaYn8pUPb9gbkix6V1cj4sjgt4RT2lUhgHw=;
 b=GFKy/dWfhC+FvrT+6v3LAd2ZtxfhHXg+wEOuXI7Nwft9czcH/YUVo6RsOcszQKMWJu
 MtXsgRZFYRNE1cn24nmju6CBhMarqMuXRUQBLvwCy4mq/AK160F59N6KHDYpRWZZfQCo
 Y8qmgL2SfiK3hS3LGsylQXefenRB41cixfcePSTO8WtZy/VWcnA2AkFBN8wsLtXtU3Qc
 Gen8qYczrQSU0MCWzaZFAL5bCY4hSEiP+CLjAoUB3wr9sqorJtFN1p2h7tcxEx9vmgY3
 GokcRUV6CSKgFY3CNNyV6zheuKj/8STJvC/ty9EeB6gRXatePg17dBkjxKzhZSiXMAfJ
 Fjdw==
X-Gm-Message-State: AOAM533XCxkan5qOHhonOGuh1dM2ORkfAJqAXApGEMfnB/XYKEFEuAAl
 gcxQ1eEcvydN0WS4WyhmCy0O2g==
X-Google-Smtp-Source: ABdhPJxkvpN1XB2thsrTILRIMUgiR9LrYgYSLs/QhgnJQA+B/s0XRKMf6Qwm/V2/EGIR8it1lhbspg==
X-Received: by 2002:a17:90b:4acf:b0:1dc:e6f2:dda1 with SMTP id
 mh15-20020a17090b4acf00b001dce6f2dda1mr14471699pjb.114.1652100755510; 
 Mon, 09 May 2022 05:52:35 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
 by smtp.gmail.com with ESMTPSA id
 f19-20020a17090a639300b001d840f4eee0sm12511993pjj.20.2022.05.09.05.52.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 May 2022 05:52:34 -0700 (PDT)
Message-ID: <832c42d4-5498-d6dc-7160-c7427e0c52bb@kernel.dk>
Date: Mon, 9 May 2022 06:52:33 -0600
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
References: <f24d9e5e-34af-9035-ffbc-0a770db0cb20@kernel.dk>
 <20220505134256.GA13109@lst.de>
 <f45c89db-0fed-2c88-e314-71dbda74b4a7@kernel.dk>
 <8ae2c507-ffcc-b693-336d-2d9f907edb76@kernel.dk>
 <20220506082844.GA30405@lst.de>
 <6b0811df-e2a4-22fc-7615-44e5615ce6a4@kernel.dk>
 <20220506145058.GA24077@lst.de>
 <45b5f76b-b186-e0b9-7b24-e048f73942d5@kernel.dk>
 <20220507050317.GA27706@lst.de>
 <d315712a-0792-d15f-040d-3a3922700a53@kernel.dk>
 <20220509060010.GA16939@lst.de>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220509060010.GA16939@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220509_055239_240604_9FA749AD 
X-CRM114-Status: GOOD (  18.12  )
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

On 5/9/22 12:00 AM, Christoph Hellwig wrote:
> On Sat, May 07, 2022 at 06:53:30AM -0600, Jens Axboe wrote:
>> How about we just add a comment? We use it in two spots, but one has
>> knowledge of the sqe64 vs sqe128 state, the other one does not. Hence
>> not sure how best to add a helper for this. One also must be a compile
>> time constant. Best I can think of is the below. Not the prettiest, but
>> it does keep it in one spot and with a single comment rather than in two
>> spots.
> 
> If you think just a comment is better I can live with that, also the
> proposed macro also looks fine to me.

I folded in the macro patch, seems safer and better to just have a
single spot where it's done rather than rely on two comments if things
do change there in the future.

-- 
Jens Axboe


