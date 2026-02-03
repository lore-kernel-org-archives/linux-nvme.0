Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11FADE8B377
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Feb 2026 22:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nYp80HBXj7HEJBOQmuYVqQXfQnCKOZ6pqVoPpBFvjV0=; b=QIYQ201otjyaCRRhTlAvYs/y16
	YykwKRumHRHllvpf8EBDuD8DSwXJfj8HgYZqRJrdaxa+ncKufbbp3hyVtOFn3JrV54Ul1n0aNwQ91
	7iZAubApFBUypKaUrdbrjL/EbQKQORe5+aWg9ylakHBIU1RQJWIZly8WpK2PuJ1ueZ/f1uLVhnIwO
	q7dNk8yZYJa+1bJIu1mreM1FKZDkZjEbW13Vb6F4uoHLXQb6EqkI27A3HzfakLp29evFJy5ZMZK7P
	L/RoIV2AqkLj5uRftyEK+4X2NXjk+CM4dBWDHcY83rV4+enh6u+cJQ/5F20p1oRchQ/ha/SDxEGAl
	CYTeY6Jw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnPCm-00000007VEY-0DYu;
	Tue, 03 Feb 2026 22:49:08 +0000
Received: from mail-dl1-x1232.google.com ([2607:f8b0:4864:20::1232])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnPCj-00000007VEA-2Yaz
	for linux-nvme@lists.infradead.org;
	Tue, 03 Feb 2026 22:49:06 +0000
Received: by mail-dl1-x1232.google.com with SMTP id a92af1059eb24-124899ee9d3so289554c88.0
        for <linux-nvme@lists.infradead.org>; Tue, 03 Feb 2026 14:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770158944; x=1770763744; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nYp80HBXj7HEJBOQmuYVqQXfQnCKOZ6pqVoPpBFvjV0=;
        b=PLKlcjx7QECHmz1D7NCBRq1rHWamUSq51EGQTRh+anx1bH/XFjzo36FcnCgn4wYQlz
         Fyo1im6FyGsZsFzBd/U8KMp5/GoiGxc4PbxvuQ2EzaaeQNMXAgMVvb6ZvCGjMhNoyNTR
         upND7TqRW3c8MpL4lqxInZ57lmstxdllZK29njM1doP6lfpUfiCEzvtKY1zrxfDNR/fr
         ltrh9WkI6FGdInsU6XOnlIp0g3+YVsxPW+gi1u8aUWeDFRy4Gc4mmdWX0Dg5ZfnPJPON
         +wE+xwV4exOnSsjaBObw8070Fj1t47mFGJ+zoP4HLFGQn/rSbfLcyeMTdlzYSWaoYZEG
         JAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770158944; x=1770763744;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nYp80HBXj7HEJBOQmuYVqQXfQnCKOZ6pqVoPpBFvjV0=;
        b=OuE6+kZIt60U1SsGyT5OdaIOdiFolihNq5b7fNXWQFAt7whBoiu30Ll/4IdJLj4OGm
         f4Btgl67TqTfPQjB5HBn1GbCG7Vj9lRF2ZYgWkZhYCNG4EPpZoAQEkwqyz59M8QQwGC3
         awoWa5mbb+n14/hstnrGL/v0vvdARAba6Vmnexz44f/CL8lm8x0MALa6mB1Sv5jL9Kcz
         IuPyJSLYSqS8TTvJ+iW/TIdusdtg8m00kjvZn+gmAv48WOSRn4hpNkitWZvWc5keesSY
         VA4v0TPwxFZAd1LX187osHRAgWUZByWXe01xQioZasQRMholoiWA+lo5ARDkHeZb0I68
         JtEw==
X-Forwarded-Encrypted: i=1; AJvYcCUGg+SNE3C0U0VveHwUT/OKcZbp73Zrcdk0ci2ZjQHsIzPn77moZx2QKUFjDCZNydVeWUlmk719asVI@lists.infradead.org
X-Gm-Message-State: AOJu0Yx6y/gYwhkzN5o7ITfikBPNmnepXpD17zQfNjW0fk4+5SNy/3WJ
	0EPoh/B5AaEZcSTHTKQfzv//fhtl8y2aVl4/VPh8BQRfKPVJzAc67Yb2
X-Gm-Gg: AZuq6aK3FlxUSXjy1WRLoQqzAqrhKUUaOnyxzzB0dxTrSokmutc/VwKOr0JWIkLJuNN
	PrvL4evMCwZkmtk4gU8J/5zzD8pChjNS7TfC4u9eQkGcZU5NDNFAt81S17yTeQ/7QvKKsURSfGB
	qiO5Z63PlyQwRYCFJ/qoH42h7QKG1VJ9LgstyBRQczrq4Dt6KiTNNEgfrOgBJ3irPtWU6pkkq8u
	1Ssexfrec/7bjXS59ZCC0kww0EW1yoWxDtN1GbbUQEaubuytgtFvpuRjxsL6+trrfDRxHuRmpKG
	bqH5u/wSRFH0Y0u9kGv/SUq+Mm3IFhl04e5jCzyqBi4YW4pzZIij1IHJ5IuKj7PGEbn/GzxsULU
	XWp2bgZAQ6/gK9VQxBrYuTfKwDgEwoVzymf+Pc03Ahu+jGIfEXO75U7+9fmr1j+yPbF3Bkaablg
	9+E2XbWDktjZLD4N34BOmWtMqeBsE=
X-Received: by 2002:a05:7022:2386:b0:124:b18c:dcf8 with SMTP id a92af1059eb24-126ea8f2893mr1912282c88.11.1770158943752;
        Tue, 03 Feb 2026 14:49:03 -0800 (PST)
Received: from [10.69.37.27] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-126f4e10935sm489257c88.6.2026.02.03.14.49.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 14:49:03 -0800 (PST)
Message-ID: <df3246bc-a5e7-4835-8d75-ca468b6bcd27@gmail.com>
Date: Tue, 3 Feb 2026 14:49:01 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/14] nvme-fc: Decouple error recovery from controller
 reset
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
Cc: Aaron Dailey <adailey@purestorage.com>,
 Randy Jennings <randyj@purestorage.com>,
 Dhaval Giani <dgiani@purestorage.com>, Hannes Reinecke <hare@suse.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 jsmart833426@gmail.com
References: <20260130223531.2478849-1-mkhalfella@purestorage.com>
 <20260130223531.2478849-13-mkhalfella@purestorage.com>
 <383bbbe9-6cf5-465c-8811-0dddce34f883@gmail.com>
Content-Language: en-US
From: James Smart <jsmart833426@gmail.com>
In-Reply-To: <383bbbe9-6cf5-465c-8811-0dddce34f883@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260203_144905_650039_091A59C1 
X-CRM114-Status: GOOD (  16.96  )
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

On 2/3/2026 11:19 AM, James Smart wrote:
> On 1/30/2026 2:34 PM, Mohamed Khalfella wrote:
...
>>   static void
>>   nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
>>   {
>> @@ -2049,9 +2061,8 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
>>           nvme_fc_complete_rq(rq);
>>   check_error:
>> -    if (terminate_assoc &&
>> -        nvme_ctrl_state(&ctrl->ctrl) != NVME_CTRL_RESETTING)
>> -        queue_work(nvme_reset_wq, &ctrl->ioerr_work);
>> +    if (terminate_assoc)
>> +        nvme_fc_start_ioerr_recovery(ctrl, "io error");
> 
> this is ok. the ioerr_recovery will bounce the RESETTING state if it's 
> already in the state. So this is a little cleaner.a

What is problematic here is - if the start_ioerr path includes the 
CONNECTING logic that terminates i/o's, it's running in the LLDD's 
context that called this iodone routine. Not good. In existing code, the 
LLDD context was swapped to the work queue where error_recovery was called.

> 
>>   }
>>   static int
>> @@ -2495,39 +2506,6 @@ __nvme_fc_abort_outstanding_ios(struct 
>> nvme_fc_ctrl *ctrl, bool start_queues)
>>           nvme_unquiesce_admin_queue(&ctrl->ctrl);
>>   }
>> -static void
>> -nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg)
>> -{
>> -    enum nvme_ctrl_state state = nvme_ctrl_state(&ctrl->ctrl);
>> -
>> -    /*
>> -     * if an error (io timeout, etc) while (re)connecting, the remote
>> -     * port requested terminating of the association (disconnect_ls)
>> -     * or an error (timeout or abort) occurred on an io while creating
>> -     * the controller.  Abort any ios on the association and let the
>> -     * create_association error path resolve things.
>> -     */
>> -    if (state == NVME_CTRL_CONNECTING) {
>> -        __nvme_fc_abort_outstanding_ios(ctrl, true);
>> -        dev_warn(ctrl->ctrl.device,
>> -            "NVME-FC{%d}: transport error during (re)connect\n",
>> -            ctrl->cnum);
>> -        return;
>> -    }
> 
> This logic needs to be preserved. Its no longer part of 
> nvme_fc_start_ioerr_recovery(). Failures during CONNECTING should not be 
> "fenced". They should fail immediately.

this logic, if left in start_ioerr_recovery


-- james

