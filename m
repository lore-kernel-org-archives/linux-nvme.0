Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF98C0502A
	for <linux-nvme@archiver.kernel.org>; Sun, 28 Aug 2022 12:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y4kq9NLY5RZw/knlpZ/iNxECmmAbxdCQQoN8yer4S0c=; b=ZwECDwMPsSRLK5SJU+eiUQMt2p
	+jBUCbGX2Y7egmbilJG3jUwQ07CF9dGPFnJONRylR/br+vW6RQLhJEpA5+SD1lFn4mKaUFx0xkzW2
	uZFfWEcvf+U5hhWimaTg+1Zld1o/d+vHzXEaujLoklRLrGCaxx/DmwS2O22buQKIfdyePxmvbT1/D
	jLtVv0OOOoWPzCYnfaTyVAVepHGOj9MLuwgVv3F1TSEUzAmdIRLIJajajSpuS8mCRKJ80qtraAfEa
	Cwe8vM+PewL/l3vdEgGPFuELK1doFhjwEcXN9gJSW9W2bCmqw8Uu1G4p8fHMrng1zZqblunYNqIAX
	Fd1Zmv8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSH9V-00Gguy-UY; Sun, 28 Aug 2022 12:12:33 +0000
Received: from mail-wm1-f41.google.com ([209.85.128.41])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSH9T-00GgtP-1h
	for linux-nvme@lists.infradead.org; Sun, 28 Aug 2022 12:12:32 +0000
Received: by mail-wm1-f41.google.com with SMTP id k6-20020a05600c1c8600b003a54ecc62f6so3085070wms.5
        for <linux-nvme@lists.infradead.org>; Sun, 28 Aug 2022 05:12:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=y4kq9NLY5RZw/knlpZ/iNxECmmAbxdCQQoN8yer4S0c=;
        b=1iKy7cTxRTcPjeiRMtJKLkAZbvnAqBaIjHWaQTZ1SAvMie4wE0jFtF1kUy0ahkhElm
         NtmQsXurGStauQbf6FWhxahhOd3cANqb4yyZwrIqU//Wo4RfufrrVI+HTl3ymid/POvm
         coRY7DrUfBpFRMsp2tKevPwsq3eRJtFP3e22Wr+UyxTSrh9xCE/W0ZzuZstJGD6VDVZQ
         e7hb9uXujrqPSxQiKUGl3Q9f/9KHPdtNaZBNv7f3/DvJBahjrBo6V3VJTeJ987veIBmW
         Jwlj+MZ7NsU5DOqIgrzHm7/Qiu+NGOePCstgefCIIXT+CijFjLgbLTp5y+fwCDcxLeFD
         XW3w==
X-Gm-Message-State: ACgBeo0fbQrVS0dC6A2+IJ4o/FSI6+8u7HcZ9CRdCjB6H7eQneDMYoqO
	SyQsOJ6V9ezggSoldog2vt9OnJtu1BIo8Q==
X-Google-Smtp-Source: AA6agR6+c9ocPeIILjDGiNRBIzeDIcGgsrH8don4mvZolrMwe5+G120dte2hSs9YoBpj27wHyyLlOA==
X-Received: by 2002:a05:600c:224d:b0:3a6:5533:ccca with SMTP id a13-20020a05600c224d00b003a65533cccamr4453800wmm.153.1661688749810;
        Sun, 28 Aug 2022 05:12:29 -0700 (PDT)
Received: from [192.168.64.104] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id i8-20020a5d5228000000b00225232154d7sm4369454wra.110.2022.08.28.05.12.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Aug 2022 05:12:29 -0700 (PDT)
Message-ID: <b45b7843-55c4-1aed-593e-0466b693959a@grimberg.me>
Date: Sun, 28 Aug 2022 15:12:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/3] nvmet: Expose max queues to sysfs
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
References: <20220823074451.12170-1-dwagner@suse.de>
 <20220823074451.12170-2-dwagner@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220823074451.12170-2-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220828_051231_213401_71838B5B 
X-CRM114-Status: GOOD (  15.41  )
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


> Allow to set the max queues the target supports. This is useful for
> testing the reconnect attempt of the host with chaning numbers of
> supported queues.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/target/configfs.c | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
> index 2bcd60758919..ba9f3209f848 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -1281,6 +1281,30 @@ static ssize_t nvmet_subsys_attr_pi_enable_store(struct config_item *item,
>   CONFIGFS_ATTR(nvmet_subsys_, attr_pi_enable);
>   #endif
>   
> +static ssize_t nvmet_subsys_attr_qid_max_show(struct config_item *item,
> +					      char *page)
> +{
> +	return snprintf(page, PAGE_SIZE, "%u\n", to_subsys(item)->max_qid);
> +}
> +
> +static ssize_t nvmet_subsys_attr_qid_max_store(struct config_item *item,
> +					       const char *page, size_t cnt)
> +{
> +	u16 qid_max;
> +
> +	if (sscanf(page, "%hu\n", &qid_max) != 1)
> +		return -EINVAL;
> +
> +	if (qid_max == 0)
> +		return -EINVAL;

This needs an upper limit.

