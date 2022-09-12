Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBA54ECAAD5
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Sep 2022 12:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OFWsmah8KSdcZMDalcae5t2JmFjsyvr0X3XjRdTWPHA=; b=jwSgIhqcMmH533VoOFz/SytAOD
	P9TsAAur8tO432sUpsxNkrKUfLDB+Bb54a/AL6e0ARiH3T64KIPhRyKnj+6Q7SImaDPldbNph1v8m
	opfjqwPegD4dc1XNqQQxlfaSYVK96AG/qvSUi5agjprt4AqG5kMb4+mvRaVyPWTRX2IZA2J+400Qk
	ggAhWRLux2ddFgUY5k/eGAgnFZ984scf6TZ8phYHw+E9LhULW7CjWsE6dWj2//8UTdt88iSF6H+BB
	Fd3ZZF7MvULAn408PbZWlGOuTTAaoeymnrcoiacUL8OYBwLG6/gzOM9qavsZRA+1dUI6Z/akqqPOg
	oy7dNUGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oXibi-009mAd-2z; Mon, 12 Sep 2022 12:32:10 +0000
Received: from mail-wr1-f47.google.com ([209.85.221.47])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oXibf-009m8m-2I
	for linux-nvme@lists.infradead.org; Mon, 12 Sep 2022 12:32:08 +0000
Received: by mail-wr1-f47.google.com with SMTP id bq9so15136026wrb.4
        for <linux-nvme@lists.infradead.org>; Mon, 12 Sep 2022 05:32:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=OFWsmah8KSdcZMDalcae5t2JmFjsyvr0X3XjRdTWPHA=;
        b=6FT1l7Ux2H0cJ/q8zESvt1xswxO2P4zIL/my2L4SP5r35KhtEypDhERVvrH0EJRKQ4
         2AFS/8KM9g9HKNWhsxbxafIuTAbCIyHOH1wJZRW+JYkdh06u3HnW5/9FO6hgfpL6q5W5
         n+NnuFqi4HEhN0Ae85YoW7wo/G5weRuvVSpd/5rKmh5I4eDPCZA1LVoeYrLoyhoG7ajo
         LpEyAez9igTvRlrmBruftvBj9DvvgHbyZRCvnUml+jd4zxKgd+cv2CntsGqLrKtIyxGW
         B8Ios2rvPxycavdjEcsYd69/+1JbB37R5kVpQQRCleWC0WtwnUI2a/8xONt9E3x7cGgC
         pAWQ==
X-Gm-Message-State: ACgBeo3gxI0lmYaKseE6bQDXAaqkairSdJVtK71Ki/BktKzKerVlKQ4u
	6KHRonRiAWlm+cokmjI3Vxk=
X-Google-Smtp-Source: AA6agR79OeFJhsUMq20FypVqm9t6KuE7B0b4+rB26zNINs+oR7AHtY4gKZ9GNFUGkfWYlzaOOG4p6w==
X-Received: by 2002:a05:6000:18ab:b0:22a:3b4d:3a53 with SMTP id b11-20020a05600018ab00b0022a3b4d3a53mr9544779wri.482.1662985924521;
        Mon, 12 Sep 2022 05:32:04 -0700 (PDT)
Received: from [192.168.64.104] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id r15-20020a05600c35cf00b003a4f08495b7sm10026973wmq.34.2022.09.12.05.32.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Sep 2022 05:32:03 -0700 (PDT)
Message-ID: <b709468e-56ed-a7af-6556-7ddfc4c3fea7@grimberg.me>
Date: Mon, 12 Sep 2022 15:32:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH libnvme 2/1] nvme: Add generic connect parameter support
 detection
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Martin Belanger <nitram_67@hotmail.com>, Hannes Reinecke <hare@suse.de>
References: <20220907142411.101950-1-sagi@grimberg.me>
 <20220907142411.101950-3-sagi@grimberg.me>
 <20220909065657.vnf6lzzfcs7y5nis@carbon.lan>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220909065657.vnf6lzzfcs7y5nis@carbon.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220912_053207_136330_79186AE0 
X-CRM114-Status: GOOD (  19.35  )
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


>> --- a/src/libnvme.map
>> +++ b/src/libnvme.map
>> @@ -352,6 +352,7 @@ LIBNVME_1_0 {
>>   		nvmf_treq_str;
>>   		nvmf_trtype_str;
>>   		nvmf_update_config;
>> +		nvmf_check_param_support;
> 
> New entries go to the 'unreleased' section, this would be LIBNVME_1_2.

OK.

>> +int nvmf_check_param_support(const char *param, bool *supported)
>> +{
> 
> I was wondering if t would be better to return all supported features in
> one go. Not really sure about it though.

Why? it is already held in the kernel, why hold it again?

>> +	int ret = 0, fd, len;
>> +	char buf[0x1000];
>> +
>> +	fd = open(nvmf_dev, O_RDWR);
>> +	if (fd < 0) {
>> +		nvme_msg(NULL, LOG_ERR, "Failed to open %s: %s\n",
>> +			 nvmf_dev, strerror(errno));
> 
> 'nvme_msg(NULL,' will always write to the stderr which is kind of bad
> for libraries. I think it would okay just to return the error codes in
> this function and have the caller do the logging part.

OK

> 
>> +		return -ENVME_CONNECT_OPEN;
>> +	}
>> +
>> +	memset(buf, 0x0, sizeof(buf));
>> +	len = read(fd, buf, sizeof(buf) - 1);
>> +	if (len < 0) {
>> +		nvme_msg(NULL, LOG_ERR, "Failed to read from %s: %s\n",
>> +			 nvmf_dev, strerror(errno));
>> +		ret = -ENVME_CONNECT_READ;
>> +		goto out_close;
>> +	}
>> +	nvme_msg(NULL, LOG_DEBUG, "supported opts: '%.*s'\n",
>> (int)strcspn(buf, "\n"), buf);
> 
> This triggered my question above why we don't return all supported
> features up and have the caller added something like this?

Why? the caller doesn't need the entire array, it is just looking
to check if a param is supported. We can move this out if someone
actually needs the entire string or set of caps...

