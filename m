Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 670D4ECAAA1
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Sep 2022 16:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zljQabgwxWpQhkxc5hdEeXa579g4ZcBz1qCSWjbNcE8=; b=MQSoIsekatRdsf7gioWCgutSD4
	nTbtlxTJbQukDveI11ubWWMUo1n//nL4+HqrAYQ+MqDn0LJVcCFgGNm8yy38azZ0k6Ej1U0VXEoy5
	tVLWigzMZkL2n9AWd5W1EMUild9csvP32RfpJdMJzDfDs9YK3M8g8o37/nShpoo5DTSLCrRnS7a9f
	ErIFOS6jbwZS/RQAv9z1U4BSyZHlbbC72XQJ70FJqTHfFmZTgcvozmV29SIOJQBJiVAzmSdQivmEX
	rlTLz+9EyJvfuaDucguPk2UfHzSoclhwMCmWOoSQJwPt8dKOihdM7FaIRpvy1Fxq3XG1QDIi5FLd5
	JDzauGnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oWhIG-000VKA-2p; Fri, 09 Sep 2022 16:55:52 +0000
Received: from mail-io1-xd2d.google.com ([2607:f8b0:4864:20::d2d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oWhID-000VJ6-Ez
	for linux-nvme@lists.infradead.org; Fri, 09 Sep 2022 16:55:51 +0000
Received: by mail-io1-xd2d.google.com with SMTP id g1so1886688iob.13
        for <linux-nvme@lists.infradead.org>; Fri, 09 Sep 2022 09:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=zljQabgwxWpQhkxc5hdEeXa579g4ZcBz1qCSWjbNcE8=;
        b=6HppRPDXsjGjn9KQ4XQTISgCxsSIGM9i3EUItaWm8EPYtJaIrSnwz1s5mV3DThIelo
         gqwLHzwBxQA4h1Tl23M9pp64osd6fhhEKApSIKOj8OWYYBX1AUn6DFLsYc1M5lljwHVA
         JJLyrfPgVlR7lpteMlwHaRyGRHqb4KjS8bH7wsh8B7eunAMZ/z2OhlC20fLvHPgFify3
         RIroKCmNvXFuWhV23s2BFNX91PlHqx78YWHK0iCHHsRDPXWKB+X+30/RoNUE3+SJAygD
         UXZxkpLxFbGB3PPeH/WTKI509eieLR39ZWH8bUSggP3rOvg9O5P6D3/r16+vqqlNtgvy
         zobA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=zljQabgwxWpQhkxc5hdEeXa579g4ZcBz1qCSWjbNcE8=;
        b=HOxiFOtkFMHdf1D12N//BLAxH0aKiSS5UgUpFl+lj/JRBYlYIjJgRoxH7/z9yyI/lp
         cn6n23/JdVYaqluFelyHcFkQVS5wE3YEdjC8npAqr/nNA8MJnLcuPMfP9hFumOecPzHe
         eYj0MVq3VsiWb7QMaNiDVoN3ZKMZezaJBWLAkgTZ8M6jz2wyErleOMDs68KKelTSS4a4
         nNKFN53pvwfvdsbfx7TtCNqFYjbACncdAjNVb4W6gdrV4raorAYttbC9KDRDxiiYFWiU
         HUaMQ0A9RPcEHkhvPvXOAQV2/Fyl3iKnJWas+OIMdp9aBwqnKiPJ1Q20d6SfEqIWJaU2
         XFqA==
X-Gm-Message-State: ACgBeo0kosFL0wCnKeBa+XZdr7MstXZk23oC3YboRYoU/DdHi7RTBvaI
	hN92+BthAsZSdL89E4S2dJ/2rYO+Nw/f8g==
X-Google-Smtp-Source: AA6agR4gnjiLKVqH8AdpAQuwUSHgDqsXk9bzTVfZu8VH/VVquc1s0I1wlA2l2mzqJFoFN8eWMLIdxw==
X-Received: by 2002:a02:904c:0:b0:343:50f4:48a2 with SMTP id y12-20020a02904c000000b0034350f448a2mr8013189jaf.22.1662742547662;
        Fri, 09 Sep 2022 09:55:47 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id w17-20020a02b0d1000000b0035a09ad2d87sm370961jah.99.2022.09.09.09.55.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 09:55:47 -0700 (PDT)
Message-ID: <47e19485-f321-cd2a-3408-173434b04d01@kernel.dk>
Date: Fri, 9 Sep 2022 10:55:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [RFC 1/2] nvme: add whitelisting infrastructure
Content-Language: en-US
To: Kanchan Joshi <joshi.k@samsung.com>, hch@lst.de, kbusch@kernel.org,
 sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, j.granados@samsung.com,
 javier.gonz@samsung.com
References: <20220909163307.30150-1-joshi.k@samsung.com>
 <CGME20220909164318epcas5p15d022bfc15bb4f22dbe4fb424576243d@epcas5p1.samsung.com>
 <20220909163307.30150-2-joshi.k@samsung.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220909163307.30150-2-joshi.k@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220909_095549_751757_27C4FC71 
X-CRM114-Status: GOOD (  20.00  )
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

On 9/9/22 10:33 AM, Kanchan Joshi wrote:
> If CAP_SYS_ADMIN is present, nothing else is checked, as before.
> If CAP_SYS_ADMIN is not present, take the decision based on
> - type of nvme command (io or admin)
> - nature of nvme-command (write or read)
> - mode with which file was opened (read-only, read-write etc.)
> 
> io-commands that write/read are allowed only if matching file mode is
> present.
> for admin-commands, few read-only admin command are allowed and that too
> when mode matches.
> 
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> ---
>  drivers/nvme/host/ioctl.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
> index 548aca8b5b9f..0d99135a1745 100644
> --- a/drivers/nvme/host/ioctl.c
> +++ b/drivers/nvme/host/ioctl.c
> @@ -20,6 +20,42 @@ static void __user *nvme_to_user_ptr(uintptr_t ptrval)
>  	return (void __user *)ptrval;
>  }
>  
> +bool nvme_io_cmd_allowed(u8 opcode, fmode_t mode)
> +{
> +	/* allow write/read based on what was allowed for open */
> +	/* TBD: try to use nvme_is_write() here */
> +	if (opcode & 1)
> +		return (mode & FMODE_WRITE);
> +	else
> +		return (mode & FMODE_READ);
> +}

The read/write distinction doesn't make a lot of sense to me. You've
already been able to open the device at this point. It would only make
sense to limit some things based on FMODE_WRITE imho, not FMODE_READ.

-- 
Jens Axboe

