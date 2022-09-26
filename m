Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF39C07E9D
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Sep 2022 14:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pTDxk9oXLcyzLIlge9oEls0XIl60bM4FjSB09bCJi7I=; b=hgV2TKjs0DJB02zqBbI/2nPg7N
	OY1cJFx7FqftEHRr3LoIgOe3/ztLsoTJJZ0/g1LYcxkPk+RzBBUHvY7VtsKBwVaViNSTx62hcUCFu
	4yf6Oe5JxrY8vzM1IjRJrtduYXWiWXqnAIqwM+WeWyeVPh8sXyNfxUbxsvIdDoI77z6sOrr2Zw4Jt
	9YcivrjCAO6zL/nrSa68sCbJopxzX9TnveZC7/u9eA6WDwEgSqAzKgZCwpoukngluEhv192wJjhtN
	Jaj8+NtIHwfl9cg5ji8D6GLKUoNAana2+sm5Df4ozpnC+ysWotHJFF6FMy+Fy+4pyNGZcb7HOWXqb
	kg8Vr38A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ocpRc-005VA2-0q; Mon, 26 Sep 2022 14:50:52 +0000
Received: from mail-io1-xd2f.google.com ([2607:f8b0:4864:20::d2f])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ocpRW-005V3P-9a
	for linux-nvme@lists.infradead.org; Mon, 26 Sep 2022 14:50:47 +0000
Received: by mail-io1-xd2f.google.com with SMTP id p3so5380965iof.13
        for <linux-nvme@lists.infradead.org>; Mon, 26 Sep 2022 07:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=pTDxk9oXLcyzLIlge9oEls0XIl60bM4FjSB09bCJi7I=;
        b=HYvDGszNu1gu6URMqy5VyPO0q1CjLZEc24iAopQm0fNr/8L0QweBd44p9s0Sy+yCiB
         ugqpaw+OzNCG5QFs9LmXrwSLt+OFDxXFtU4qrSW5Mq0MX75/UGFUftTXqK0UyXjEvFdh
         ZeP3ryaZrtP2yaocnW4b6ax+wiab+q3J3a23bPfNR12QrJRBe0vsqZMWHh4geLH+zGNv
         MdXBFXHKqXiFB0Dr9J4bRDOIJj2sfngS7KX7Y037Im/Fw/LEQdF6a5q6XT1ypWs7P+Jb
         JuwmSEAcV/ZQ4/YnWr3LwJEHbMHze15ZmdqBs68ASLe4yJWt1rSMDR4ipzZbTmfoTGpC
         6shg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=pTDxk9oXLcyzLIlge9oEls0XIl60bM4FjSB09bCJi7I=;
        b=WKnab8yhsrXkfGMKRPKe45ItRXk0ccxdlc1YOc33moxYwPMrRJva7LO/LoV+OdrvRV
         LMLxjVGtGt0MqKN6A6ado+lB3Yh6u2s1ALDmzXARbZtB+Y/aEn8LCeONl/l0TuUSHohi
         x1bkB1KSrwYF8r7W9/crMGZUF46SI/vdJJcHtVF/deb5GhVcsNgDWArqE6VFOOryIHVO
         4+7WpsdQhXa5lOrnzQfNfye62ov3jURxJUl1dVqcyxlkqEeb3xLbVeW4VL1EWtqHuIeB
         u5i6wk2RnlHhCS/pvUKCSIENtjbjOiGdcOB+oxO7TpZ9nWWuhvhUWSfIP5i9Sa4Zlull
         FBfA==
X-Gm-Message-State: ACrzQf2zsIkAZ1hFkf/Atct2mc7CBaQtQy+VbkdokQOdSzHBB9xBsz89
	fvQb9qDNUWRfjj9jH6KwFS3bSw==
X-Google-Smtp-Source: AMsMyM4ezesDcR/VrCIT8c4MqwXXAKedbbvzEcJmc1qxfhQgzw/YFvqad1860zJhGdYZ9FeErmdgJw==
X-Received: by 2002:a02:b681:0:b0:349:b7d5:7c25 with SMTP id i1-20020a02b681000000b00349b7d57c25mr11526271jam.228.1664203844319;
        Mon, 26 Sep 2022 07:50:44 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id e21-20020a056602159500b0067ba7abc4cesm7638553iow.50.2022.09.26.07.50.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 07:50:43 -0700 (PDT)
Message-ID: <25b9899f-0c60-39f2-179b-789b914e0f0a@kernel.dk>
Date: Mon, 26 Sep 2022 08:50:41 -0600
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
 <d09e1645-919f-9239-f86d-a8e85a133e5c@kernel.dk>
 <YzG5/1zSdiMlMLnB@infradead.org>
 <69598e37-fb91-5b92-bb80-b68457a7b6f8@kernel.dk>
 <YzG6mZhtd/QysvdH@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YzG6mZhtd/QysvdH@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220926_075046_339346_D4870E1A 
X-CRM114-Status: GOOD (  13.33  )
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

On 9/26/22 8:43 AM, Christoph Hellwig wrote:
> On Mon, Sep 26, 2022 at 08:41:38AM -0600, Jens Axboe wrote:
>> Sure, I don't really care. What name do you want for it?
> 
> Maybe slow and fast?  Or simple and meta?

So you want 'result' in a named struct too then? Because right now
it looks like this:

struct nvme_uring_cmd_pdu {
         union {
                 struct bio *bio;
                 struct request *req;
         };
         u32 meta_len;
         u32 nvme_status;
         union {
                 struct {
                         void *meta; /* kernel-resident buffer */
                         void __user *meta_buffer;
                 };
                 u64 result;
         };
};

Or just the union named so it's clear it's a union? That'd make it

pdu->u.meta

and so forth. I think that might be cleaner.

-- 
Jens Axboe

