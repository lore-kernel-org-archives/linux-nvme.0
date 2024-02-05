Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 046E9C4828D
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Feb 2024 18:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KoKljmPx+CCJJ2g7jlU2XB71oNqwymM3KyiYJV4wpLA=; b=ZmMv8MlGL/EDUXsi1IKpt5imOB
	zcuJnr+yxBxmdJlXw14gM+trHZaO1DnXv8MG9Hx26Ji9ojcKAukZgLPrTev2MNLXL72obVhyp0wZV
	oJrQvhnZBYRrHyS/EcauUuG20JRRe8v/NtKOwnQicoDwZhB1AlYj3xxr1Vvp6PuCe1Vg565/KssM+
	KIXHyXAFk/XHjfOIA4k0VsOvBl4odqZjxyodv5ndPPyPEl5GuQoQReCTwYckM7OJPVi+Qt7TiPC0t
	Z9lychTPtWw+uy0c0MwCh/frxRp9ZSt3NX2+wlZp9FkJyGSa63K7TMBh3oWz4e22Epmq6dMdBOQyZ
	36Xsy1gA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rX3xe-00000004QQS-0uYL;
	Mon, 05 Feb 2024 18:44:54 +0000
Received: from mail-pg1-f181.google.com ([209.85.215.181])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rX3xb-00000004QPw-3Ni4
	for linux-nvme@lists.infradead.org;
	Mon, 05 Feb 2024 18:44:53 +0000
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5cedfc32250so4131300a12.0
        for <linux-nvme@lists.infradead.org>; Mon, 05 Feb 2024 10:44:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707158690; x=1707763490;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KoKljmPx+CCJJ2g7jlU2XB71oNqwymM3KyiYJV4wpLA=;
        b=uOz2g1fnNo28MNNygj43fPG/FzXKzNHCbMdA+/GQlpRI98OKNbU1u3ZA9tr/m0XWWP
         d/apSBBK+9lSUSnXbm/9ZUyHvamOQoL1xF0JjAWT4/9Mfl+0jjPg/mTVEOcutq1xcq1p
         AVCrGj9CsDVaJ23l41hGJaUqSZFuV8QNwXN4uweiA+BSiBdQZsfkBOxEmwO9sflT8yWr
         fewI1rLcoKErzhf3Xvzl+b7nv5YiVt6ViGwQr3GdYIkVDfUBw31WzuaeSO0NM8PvuG49
         l9MPbGqu8SFvEYmpcv/Mco0RsI8oUyiGGOCkLzv00adIC68RPHReol3EkeePXlZTUm5O
         8++w==
X-Gm-Message-State: AOJu0YyNNuDy2kzQPsZk6wfH0hnVtwhU2k7QtWOPv2mjiF4iPEG/1dnp
	jPSLBoiDE551glenqYj8uXnjs0gQJQzG1EaiF2xpd1jjrvjYFkLL5yXXDzAU
X-Google-Smtp-Source: AGHT+IH3HDMDmpb/ry+asyba8e8Hpq2ZDbN+3jJSdOXGId9LlYosDOGkvZZVOkVoe+6sxPjhTqJodQ==
X-Received: by 2002:a17:90a:ee94:b0:295:d00b:3c41 with SMTP id i20-20020a17090aee9400b00295d00b3c41mr292828pjz.14.1707158690003;
        Mon, 05 Feb 2024 10:44:50 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:be2a:6ac0:4203:7316? ([2620:0:1000:8411:be2a:6ac0:4203:7316])
        by smtp.gmail.com with ESMTPSA id a15-20020a17090abe0f00b0029659674bbesm307944pjs.43.2024.02.05.10.44.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 10:44:49 -0800 (PST)
Message-ID: <74b2332d-c76b-4e3a-953a-baa14f09ed4f@acm.org>
Date: Mon, 5 Feb 2024 10:44:48 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: NVMe suspend failure
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <294cb317-22b1-4c03-9b12-b19c55ec3163@acm.org>
 <Zb7l5Lk814W4064a@kbusch-mbp.mynextlight.net>
 <ccfbb194-c355-4dd9-8b06-689480f5fb85@acm.org>
 <ZcEhtkAO0LlLmjgJ@kbusch-mbp.mynextlight.net>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ZcEhtkAO0LlLmjgJ@kbusch-mbp.mynextlight.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240205_104451_876792_AC325751 
X-CRM114-Status: GOOD (  13.34  )
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

On 2/5/24 09:58, Keith Busch wrote:
> On Sat, Feb 03, 2024 at 05:44:03PM -0800, Bart Van Assche wrote:
>> On 2/3/24 17:18, Keith Busch wrote:
>>> And this is happening during a suspend? What kind of suspend? Like an
>>> S3/S4, or idle suspend?
>>
>> I'm not sure how to determine this? This is what I found in the logs:
>>
>> Feb 03 09:02:20 asus systemd-logind[1208]: The system will suspend now!
>> Feb 03 09:02:20 asus systemd-logind[1208]: Unit suspend.target is masked,
>> refusing operation.
> 
> I am not sure what the "suspend now!" message means to the driver. Your
> initial report with the "CSTS=0xfffffff" comes from the nvme request
> timeout handler, so I'd want to confirm what command is timing out, and
> what path dispatched it: was the command dispatched from nvme_suspend()
> path, or is this coming from somewhere else? If somewhere else, was it
> dispatched before or after the nvme_suspend?

Hi Keith,

I think the requests that timed out were submitted after resume. User space
software is paused before nvme_suspend() is called. nvme_suspend() waits for
pending requests to complete. Hence, the requests that timed out must have
been submitted after user space processes were resumed. An additional
indication is that I saw user space software crash after resume that writes
periodically to block storage devices (email client and web browser).

Thanks,

Bart.

