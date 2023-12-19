Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D665C46CA2
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Dec 2023 17:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NgUO5ddUY2edyrwQj3D5CY1Ktn6R6W3IbHS+Q16jNW8=; b=Fu5/4gcDpK83zZOGTuPLy4wgGk
	vBDkIyf6hhTl7nPD3LXYY8UcmPI2G0o+4QcDAjFsIJGXgSvQUIfi3RfREEiQPm893rJo9iPi8cUij
	RdnK9HhHcfwMDIaNqoziQyxaV5fySnkEkJI4rSocujRHyMTK0GvGbK2X8tQZ3GESEzi2FIa58oe3Q
	fzp/YXjp/ONDKNAmMRbyOWbdhSq8cUJxOOCwBl9lfrEB1QYzjLomt2Xb13JE1mng/uGf8C1G/IMX6
	/ipgI7X6wLHYgl7B6Q+OohDcTiDqYKX21U3GUX//TBKVYxQJ+ADLzfwgqyLf1ELr8Gn/YRzJBSm9a
	mUryJHAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFdqo-00Evmg-0l;
	Tue, 19 Dec 2023 17:25:50 +0000
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFdql-00EvlV-0O
	for linux-nvme@lists.infradead.org;
	Tue, 19 Dec 2023 17:25:49 +0000
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1d3d3f0afc4so3663735ad.1
        for <linux-nvme@lists.infradead.org>; Tue, 19 Dec 2023 09:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1703006745; x=1703611545; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NgUO5ddUY2edyrwQj3D5CY1Ktn6R6W3IbHS+Q16jNW8=;
        b=i+z1juUdyhLQ/+apYwABhEqQx4nZWt6ilA6sne9f+oXnYkJUGnfZk0Ogmbpsdmz6Y+
         JdkojA33U0mbUSPjSY7nJgEP7+gem96D6WjhJU7tfmSU+pIuBvDzL1HUxezgY8rLf/QV
         +lnTu7bFkTgPLjFtSqKI4dauUyXhDZ0yOpg/+9NQdn7spvYsI+acsDni52lHQZkyzcZV
         HMkuvZNDaU1zZs6iGRcsok95Hiho04GjOZ7hUUhjpArMDYL+Nvp/bFXna5N3+YvRn7UZ
         VPAGFTmvXOV3wL1s5d0ROenY0pIBiBFto9ypKvMgkLj1tGRzoElUgLu64bpzAoJ1Fu1p
         bbNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703006745; x=1703611545;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NgUO5ddUY2edyrwQj3D5CY1Ktn6R6W3IbHS+Q16jNW8=;
        b=OX0QRA6j4YdrfyQy3/Z+RA4pl9vgWFfJxLO9pQaOW5aMTUBOHNyYMa8kSgsNllXlSE
         5pxsPJ7Rk4lkY4Bslog9mLMBjec7xq+m+mRN7vu5BJdZ1ddGSFdJIafKYW1sM1sXU986
         vOHSzH4JG0DBLOKav05DZLIbH4nBu8WpaO1JBaL3mGiFfMefS8DZLsqiybKaytNKvff/
         jiAf21sxsX0CP8uAhNJKGc7vC9wl7jOeg04wJEnGdfx6f+xmKhT5AZQeSHzo/GoCnzpr
         qfcV6Jb0uu2nbZcLtYohM8SIvCJF0CaI8JVfm0jKk9YfDS2fqk79PnQIGbwGm7fOFZaL
         6/GA==
X-Gm-Message-State: AOJu0YxAn7Qlp5WtbXyW//xaPWwy3mrkMct1pr2Ea3B+xPmJVXkQfTm3
	/Eh8msekGcYfe352qLHfGhV6xA==
X-Google-Smtp-Source: AGHT+IH74pyNXA69xod2dK0XmP4SBQuCt9ODgu+XbGRWKPsb3JFxOxc3Kc+Tnznxugif86868t0ECA==
X-Received: by 2002:a17:902:eb0d:b0:1d3:daf3:7b5 with SMTP id l13-20020a170902eb0d00b001d3daf307b5mr3218079plb.6.1703006745562;
        Tue, 19 Dec 2023 09:25:45 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id jw20-20020a170903279400b001d36df58ba2sm10019488plb.308.2023.12.19.09.25.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 09:25:44 -0800 (PST)
Message-ID: <f84fb765-1891-4a3d-8726-6128f23ba1bc@kernel.dk>
Date: Tue, 19 Dec 2023 10:25:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] nvme-pci: fix sleeping function called from interrupt
 context
Content-Language: en-US
To: Maurizio Lombardi <mlombard@redhat.com>, kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me
References: <20231219164823.442687-1-mlombard@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231219164823.442687-1-mlombard@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231219_092547_380808_2335DDEF 
X-CRM114-Status: UNSURE (   8.45  )
X-CRM114-Notice: Please train this message.
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

On 12/19/23 9:48 AM, Maurizio Lombardi wrote:
> the nvme_handle_cqe() interrupt handler calls nvme_complete_async_event()
> but the latter may call nvme_auth_stop() which is a blocking function.
> Sleeping functions can't be called in interrupt context
> 
>  BUG: sleeping function called from invalid context
>  in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 0, name: swapper/15
>   Call Trace:
>      <IRQ>
>       __cancel_work_timer+0x31e/0x460
>       ? nvme_change_ctrl_state+0xcf/0x3c0 [nvme_core]
>       ? nvme_change_ctrl_state+0xcf/0x3c0 [nvme_core]
>       nvme_complete_async_event+0x365/0x480 [nvme_core]
>       nvme_poll_cq+0x262/0xe50 [nvme]
> 
> Fix the bug by moving nvme_auth_stop() to fw_act_work
> (executed by the nvme_wq workqueue)

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe



