Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D72C6FD1F
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Apr 2024 03:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:Cc:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fugzhJcIxXGAO0ssTnR0bYZbKaxEwSQa+2J5+v83xpo=; b=4Tts6fY7QFSN6t2nKp2UH4LO/T
	8oeaYq57cYEHgtthZ5bmMn9SxvODy7eLQg4g+ZOtlH20qE3Foc1OIwnDjKn+Fy1pDAAuKA0ZkNFZt
	a75/c1L4gUL8m/9fqmxiiHGI3cTdcevrIxCECua8Us/1Ph5AZZBvezYO1CNASlrdVl+HVrALL8vfu
	1+uTK5rQIgtTYBZttxUTWZB1or5BsqbJBSvy2H+p0XziHCO8S89OxGVcyQlUYddrIRvch43ephJny
	UeHUObUVfGhZKxs6vtlWKO1L7vctqmH9WXXvb74DsSivJAmnH9kO6AP4NNhj9jTSFTgXNKYifmqOk
	5iartmJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrrjx-0000000DrbI-130t;
	Wed, 03 Apr 2024 03:56:45 +0000
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrrjv-0000000Draf-0oW0
	for linux-nvme@lists.infradead.org;
	Wed, 03 Apr 2024 03:56:44 +0000
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-5cdbc4334edso3222783a12.3
        for <linux-nvme@lists.infradead.org>; Tue, 02 Apr 2024 20:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712116601; x=1712721401; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fugzhJcIxXGAO0ssTnR0bYZbKaxEwSQa+2J5+v83xpo=;
        b=HVZAopvaq5xmOFoZ1S/pqSjwuBBpll0iEumdoXjTav5Iq+7+z7pWH5hYKMSfy2D3L3
         vpiOu4OdOhVzZeYPSznVlR4Fc0F+ZZkzLRArGPXvxG/XMjS9eHDkfy/9AyDWHehem7fV
         AbxpJen7LoetdZOj5r7xkYC2FF+1hwLiPtYXOK8pT0Jp+9NcHBFLNW59ocgCKBeUFrWe
         WFN8/HSTBTq2oJOWxbFVqVkPnP9g/bjRKFtv3Hj1uElzCyMm3qjfw8G2/5E/Z0m/h1Gj
         eJ5H+KEvY0kUecUAy/5fUkxL9jYPad1Jb1tDllZ8d5vLVmw/CFa0RitmRqxmH/ulLYN3
         Ll6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712116601; x=1712721401;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fugzhJcIxXGAO0ssTnR0bYZbKaxEwSQa+2J5+v83xpo=;
        b=SDvrcp0YpqcX8D8cT4REW+wkZyps+/K6vaXdml+nz4ydPH/kd7SW0OoT+z7ama0Qn9
         KDFubxY38wfYi7BB+yUSehw0oli3FBrr/80rJbBmXHmGyvDaL+RdK8cWN4acSQvw51vC
         ekHN9pPHg7AgbEy05EkvA+IuQzXqvzJA0fxLQm467NL4KcHnn7c8wCFaNw6g4MsEwYl2
         R9K1UJw8aA6SWeetQDX+q09VqljMrkwAIjOGmT4fkldtQkYIBRVJsgAMPnya7gsh2FRe
         TCTPuooN3/upJfkOuUGO0C7TmYGm2Jo10GJefckEpwKVrGjQkaB/nSrDI9ixVlaN+uGm
         XitQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCB1NGMF4RJcdf8zDlUwXxiYXCXAQ1x9nRSkwBV6GNJywEqZGTjTPaY0oEX4m4nv6ppANjC1qRqlhErv8lrNkpBvvtDGMN+/Y9BpGe0F4=
X-Gm-Message-State: AOJu0YxwS0b/CBnqZz9oOqG2i7AIGc0E8z0Xqhaj61IOFDnlJyCGErnl
	4DcWCzCa0OVUDWSNia3nqzl8jz5WABsvK/b2NqeGH1PXMuPmUbo9
X-Google-Smtp-Source: AGHT+IHfoJxdwg1KatKMqIm6Uh/xcA1bx9qJJajW01kM2Vir6+vvULrmKk55dbcD4GRCoM8/BWI30w==
X-Received: by 2002:a05:6a21:6d8e:b0:1a5:6c73:74b9 with SMTP id wl14-20020a056a216d8e00b001a56c7374b9mr14589743pzb.48.1712116601569;
        Tue, 02 Apr 2024 20:56:41 -0700 (PDT)
Received: from ?IPV6:2600:8802:3800:75a0:159f:e332:af97:bfba? ([2600:8802:3800:75a0:159f:e332:af97:bfba])
        by smtp.gmail.com with ESMTPSA id i13-20020a17090adc0d00b002a29160df67sm531650pjv.27.2024.04.02.20.56.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 20:56:41 -0700 (PDT)
Message-ID: <7a3be43c-39d9-472a-9593-89a1c4e03004@gmail.com>
Date: Tue, 2 Apr 2024 20:56:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 17/28] null_blk: Introduce fua attribute
To: Damien Le Moal <dlemoal@kernel.org>
References: <20240402123907.512027-1-dlemoal@kernel.org>
 <20240402123907.512027-18-dlemoal@kernel.org>
Content-Language: en-US
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 linux-scsi@vger.kernel.org, "Martin K . Petersen"
 <martin.petersen@oracle.com>, dm-devel@lists.linux.dev,
 Mike Snitzer <snitzer@redhat.com>, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
In-Reply-To: <20240402123907.512027-18-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240402_205643_271640_F2C30D86 
X-CRM114-Status: UNSURE (   8.66  )
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

Damien,

On 4/2/24 05:38, Damien Le Moal wrote:
>   
> +static bool g_fua = true;
> +module_param_named(fua, g_fua, bool, S_IRUGO);
> +MODULE_PARM_DESC(zoned, "Enable/disable FUA support when cache_size is used. Default: true");
> +

checkpatch is generating warning on this patch, please check :-

WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider 
using octal permissions '0444'.
#31: FILE: drivers/block/null_blk/main.c:229:
+module_param_named(fua, g_fua, bool, S_IRUGO);

Also, I noticed that for zone_append_max_sectors attribute patch
you are using 0444 but for fua you are using S_IRUGO, any specific
reason ?

-ck



