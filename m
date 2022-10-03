Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64F0CC433FE
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Oct 2022 02:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KAAlL7qc3QNZomCjUUEDiMSHcBQehuSzbhVOyWtKOAY=; b=mAhs+Fb7hgaSbLczTKJMOg1zFs
	jB53hf92C8HYcS0Zs/irrmH663SStYbRsHlh4AQIY81gToYykqY0GftdO0yehfW9DpcNqmhA2v5Jc
	5byKc9UH1+h/Jc26I/MzQdVzOPC5QnB21P5aSZ0kFFnkVRkqGV4L26p34Ux4Y0jALjhBIJA/VdeDN
	OO/Wa1DYBf1a6pnQILnIMl1D8azaOekVcBUkuFznSHyFjg81XDirG6Ya+v6lvz51GxvYiqXGpxIg/
	mVy/I7wx2INdEKxu2g9NA0RBcVRY8Eo5gZMXv2IENxd7zBPGKOna87Sdq9OoOguBIq9Bs1CZqimlN
	ZR7kW7kQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ofBcv-003ZId-2v; Mon, 03 Oct 2022 02:56:17 +0000
Received: from mail-qk1-x72a.google.com ([2607:f8b0:4864:20::72a])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ofBcs-003ZHe-LF
	for linux-nvme@lists.infradead.org; Mon, 03 Oct 2022 02:56:16 +0000
Received: by mail-qk1-x72a.google.com with SMTP id i3so5936894qkl.3
        for <linux-nvme@lists.infradead.org>; Sun, 02 Oct 2022 19:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=KAAlL7qc3QNZomCjUUEDiMSHcBQehuSzbhVOyWtKOAY=;
        b=VGKkwPiIWp3rZLe+58DJ5FLlC9yVNVjZLRR3Yf/TFG2jECbS9DuxGkYaEh4A24xunM
         9Xwxr4RgMJoBS2eqPEi0ZeaS8hFC9F6Kqx46im21PFrYhVNojkU0Jz1pcxsS2FDRB+QR
         1GFZ1Zrf8T2xq8cV1HHCauaLPIYXhDsYhPu3+Dr8vs/+3L9K1IcJ2KXBtbMgOugirK9+
         NLv5X3J8dRxWliWiaJ4H4pAzN0/0nWdJ5MPgoSlmKGNM58LGZS1LfQE2uIuDZYUTBjXc
         Q9+kBkwkGOVAt3eHAADZoQw4QAolMcBWD3ZV4r2Cp/mMndB6Uh5xZi7aYG8TEWgyPP/3
         lS1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=KAAlL7qc3QNZomCjUUEDiMSHcBQehuSzbhVOyWtKOAY=;
        b=uG90O6VdPH074iLqmup4ByTc4bjQXb7/yanQdCXc+TgH6N5BtpVzb8rUhPIvGGWTJ8
         2JdbKcpOIRPF8//6JRubH6BHdJUXv2t0Y9qqbFbdd2oFByo9GCN/JbV4oT2ic/tWGDT3
         r3eOrguspb9bar2Gy2zKbQQ097OPKFN4/7HKDlgp7aglVOY+ajgxMvuBi9qYKzIm/naP
         lcliGTutnnKe2gKq6c7TQ/SSanrcuPh2C6zqM5x+jMUG4+LfqiZ9Ys9J3E77HVRANuep
         sO88cVTbnLNtU+Bmb+L1LIS98MWJTeKnyOfrO8Q7TJqJnjX5fwRwoQwFz4Evm44/NZDq
         xidg==
X-Gm-Message-State: ACrzQf3oUiYF/qUjdVce6ac+rVEX9X6/wxYZneQ3UJnH1EarKz6wGcE8
	yEuGAGn0RsSwXwzCqQPG9QI=
X-Google-Smtp-Source: AMsMyM5aHJ6xt7xoIYEcJa49IsZJ1uPLeVmWRV979AHtQwR2arzL3n9aaFyJj/j58wiRlRH9hS61XA==
X-Received: by 2002:a05:620a:1724:b0:6ce:9bb6:404b with SMTP id az36-20020a05620a172400b006ce9bb6404bmr12640211qkb.539.1664765773069;
        Sun, 02 Oct 2022 19:56:13 -0700 (PDT)
Received: from [192.168.50.208] (ip98-164-255-77.oc.oc.cox.net. [98.164.255.77])
        by smtp.gmail.com with ESMTPSA id cq15-20020a05622a424f00b0035cdd7a42d0sm8342371qtb.22.2022.10.02.19.56.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Oct 2022 19:56:12 -0700 (PDT)
Message-ID: <2f36fa52-2dc3-21f3-b53c-d0a9186c3ceb@gmail.com>
Date: Sun, 2 Oct 2022 19:56:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] nvme-fc: fix sleep-in-atomic-context bug caused by
 nvme_fc_rcv_ls_req
Content-Language: en-US
To: duoming@zju.edu.cn
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 james.smart@broadcom.com, kbusch@kernel.org, axboe@fb.com, hch@lst.de,
 sagi@grimberg.me
References: <20221002001909.20070-1-duoming@zju.edu.cn>
 <305fbf18-6759-9b00-6fc0-93a4a2e40be2@gmail.com>
 <7bd9e071.1063f1.1839b89cefa.Coremail.duoming@zju.edu.cn>
From: James Smart <jsmart2021@gmail.com>
In-Reply-To: <7bd9e071.1063f1.1839b89cefa.Coremail.duoming@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221002_195614_729179_A13C6004 
X-CRM114-Status: GOOD (  18.77  )
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

On 10/2/2022 6:50 PM, duoming@zju.edu.cn wrote:
> Hello,
> 
> On Sun, 2 Oct 2022 10:12:15 -0700 James Smart wrote:
> 
>> On 10/1/2022 5:19 PM, Duoming Zhou wrote:
>>> The function lpfc_poll_timeout() is a timer handler that runs in an
>>> atomic context, but it calls "kzalloc(.., GFP_KERNEL)" that may sleep.
>>> As a result, the sleep-in-atomic-context bug will happen. The processes
>>> is shown below:
>>>
>>> lpfc_poll_timeout()
>>>    lpfc_sli_handle_fast_ring_event()
>>>     lpfc_sli_process_unsol_iocb()
>>>      lpfc_complete_unsol_iocb()
>>>       lpfc_nvme_unsol_ls_handler()
>>>        lpfc_nvme_handle_lsreq()
>>>         nvme_fc_rcv_ls_req()
>>>          kzalloc(sizeof(.., GFP_KERNEL) //may sleep
>>>
>>> This patch changes the gfp_t parameter of kzalloc() from GFP_KERNEL to
>>> GFP_ATOMIC in order to mitigate the bug.
>>>
>>> Fixes: 14fd1e98afaf ("nvme-fc: Add Disconnect Association Rcv support")
>>> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
>>> ---
>>>    drivers/nvme/host/fc.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
>>> index 127abaf9ba5..36698dfc8b3 100644
>>> --- a/drivers/nvme/host/fc.c
>>> +++ b/drivers/nvme/host/fc.c
>>> @@ -1754,7 +1754,7 @@ nvme_fc_rcv_ls_req(struct nvme_fc_remote_port *portptr,
>>>    	lsop = kzalloc(sizeof(*lsop) +
>>>    			sizeof(union nvmefc_ls_requests) +
>>>    			sizeof(union nvmefc_ls_responses),
>>> -			GFP_KERNEL);
>>> +			GFP_ATOMIC);
>>>    	if (!lsop) {
>>>    		dev_info(lport->dev,
>>>    			"RCV %s LS failed: No memory\n",
>>
>> I would prefer this was fixed within lpfc rather than introducing atomic
>> allocations (1st in either host or target transport).  It was introduced
>> by lpfc change in irq handling style.
> 
> Thank your for your reply and suggestions!
> 
> Do you think change the lpfc_poll_timeout() to a delayed_work is better?
> 
> Best regards,
> Duoming Zhou

as a minimum: the lpfc_complete_unsol_iocb handler should be passing off 
the iocb to a work queue routine - so that the context changes so that 
either nvme host or nvmet ls callback routines can be called. If 
possible, it should do the axchg alloc - to avoid a GFP_ATOMIC there as 
well...

It's usually best for these nvme LS's and ELS's to be done in a slow 
path thread/work queue element. That may mean segmenting a little 
earlier in the path.

-- james


