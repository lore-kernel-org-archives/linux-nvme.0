Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 217F4ECAAD3
	for <linux-nvme@archiver.kernel.org>; Sat, 10 Sep 2022 15:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j91wQRVOnapfyOPKYGGd6DzTZZGVAffAjzutxqPqkag=; b=nZAPQqsKApVAKZ0r+dsbParOb2
	elbcnrup7fleCft/JJTdPETvr+oJj7hQxAVl4LmAiUiHqWsGBJgDd6Y0q8NpzaQVcoL9p694LpjbE
	uwWLvBOI0e3IjfvKaKiRXNn7JPFFyCjcun5SkCeHRS5oW5ANT6pJHOawYnl9l04PiAF8V5s5qMBjR
	q3JeJ8IEvCqyqY0inNyuiSnHCB1fg9D3rVBVvm7ysjpCORfQ2Y6rBcQLV63NCEJ9KCAL8/Kp96V3U
	lRBi6MZX8sI/9j1tvOms5HpP3jB3pdMYMp7qh3veHCOC9JsKgoGxoC0bg0cBfKIkUsg2k/o1hpMHI
	zS4fqqvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oX2he-00BJjK-HM; Sat, 10 Sep 2022 15:47:30 +0000
Received: from mail-qk1-x72b.google.com ([2607:f8b0:4864:20::72b])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oX2hb-00BJir-Ho
	for linux-nvme@lists.infradead.org; Sat, 10 Sep 2022 15:47:28 +0000
Received: by mail-qk1-x72b.google.com with SMTP id s22so3271128qkj.3
        for <linux-nvme@lists.infradead.org>; Sat, 10 Sep 2022 08:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=j91wQRVOnapfyOPKYGGd6DzTZZGVAffAjzutxqPqkag=;
        b=YQG0bqDu+8bI1bhDDn9vPU0Q47QCk49vxk1wKWriY1npdbIFmjNS0UfgRIbRdHBNEf
         n4klbFdRC3tAFm5aCGBRbh4c1yOoI3rGU3Jwg/jL5MRiU1ereFj6SORHsgcA7JtVj8Xp
         4PfF0VgOsCY2m9PEhaknrDOZRaokvVyvKb7uvgjOM/F0/GM1/6VwiZZoVvQtUW+zAety
         Hq3mzQ0pgDnWrtQsWceqnSWnXosir7oFE0zwK5XryJDzesR6Pf2KJM+kfdHsvE6L1rfx
         DHIJ6R7cMlEzMyB2sFDHeVPqen2AR2xLJi07CjSB9ytQ7xyTm+HUumgIx6ou0CkisSRc
         d27A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=j91wQRVOnapfyOPKYGGd6DzTZZGVAffAjzutxqPqkag=;
        b=LhEQ/z4ETlN0N8uYU5spLIPUqvZsjbTChTKj3SPsNgdYRfLPXLJVNqDISqzkgbb5es
         ay4skA5f7hvl8e3lT7SewGW4DCSdY3WByUKSptY8eJpqvdkLrzhzeKwwxg2PdAkJEHDr
         jaG+yRjEgIqIn6SdzdWnZeXiibp6SZWpIEfV8StfiIToWsdN5HPA2uVx6oDnQDh2ME4M
         Ug3GvGMy0I0o5AJYWBIFmLpcHH2CMlbkNDnErX2KRsXykEh1/OJQoKVAKQ6HCCv8EdKn
         tvbKSgBztpfj0Dbqfd8nu/GibOuUuJ+vTTJnqV0ryzJ2IlnbrQciASEGfNIipZSHWR40
         Icrw==
X-Gm-Message-State: ACgBeo0MWl9GdpgXh5449YM0q6qvmaHpabRnsg1cxxk+NMqGBEF4ImCq
	/h8PwhSmiiQezJGa3iLUwk0=
X-Google-Smtp-Source: AA6agR6t1V3gdveX7UTSXlF7wg0U4T7yoqsZShgzYGcKwtsfYhKBRE6kRNhKjCX1EUsci9wLAdHh4A==
X-Received: by 2002:a05:620a:85a:b0:6ce:157f:9266 with SMTP id u26-20020a05620a085a00b006ce157f9266mr753070qku.769.1662824845555;
        Sat, 10 Sep 2022 08:47:25 -0700 (PDT)
Received: from [192.168.50.208] (ip98-164-255-77.oc.oc.cox.net. [98.164.255.77])
        by smtp.gmail.com with ESMTPSA id p22-20020ac84096000000b00342fb07944fsm2891144qtl.82.2022.09.10.08.47.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Sep 2022 08:47:25 -0700 (PDT)
Message-ID: <9eb798de-149d-a56d-ac00-dd6b7ae79a81@gmail.com>
Date: Sat, 10 Sep 2022 08:47:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH rfc 0/1] Fix missing AENs when discovery controllers are
 disconnected
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Martin Belanger <nitram_67@hotmail.com>, Hannes Reinecke <hare@suse.de>
References: <20220907142411.101950-1-sagi@grimberg.me>
From: James Smart <jsmart2021@gmail.com>
In-Reply-To: <20220907142411.101950-1-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220910_084727_636044_03F3B2C1 
X-CRM114-Status: GOOD (  14.52  )
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

On 9/7/2022 7:24 AM, Sagi Grimberg wrote:
> When a discovery controller is disconnected, no AENs will
> arrive to notify the host about discovery log-page changes.
> 
> This attempts to fix it with a new connection parameter asking
> the kernel to send a dedicated udev event for this case. Prior
> attempt tried to use "connected" event already sent by the kernel
> however this also applied on the first connected, causing undesired
> side-effects when issuing a simple 'discover' command.
> 
> The patchset includes the nvme-cli/libnvme counter-parts as well.

Sagi,

Do we really need another parameter/option ?  seems awkward to need 
userspace to figure it out.

The transport certainly knows the difference between 1st time connect 
and nth time re-connect - perhaps this should be a simple flag on the 
nvme ctrl struct set by the transport ?  Simple thing for rdma/tcp to 
set flag at end of successful xxx_create_ctrl(), while FC, given it does 
reconnects w/o a first successful connect needs a little more logic.

-- james



