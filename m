Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5511EEB64D7
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Jun 2023 09:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=foLI8oofbou4hrt7TVAkrvJDeJCFo178hS/ZQokH0vY=; b=nbXUHeCvru3f4DLr1teoqvJgNO
	2hAyaish8aRCK2U2rupinwcZ5//NI6JwSqGpjj95bU3qUwi2Y/G0mNSPx72AIbBzDPsC+hKxGhlaa
	uCWAZo1KIElymozpVJjuG85w9T1pPC7nfyzEh+nJTkKZgFfMzBb5WSzomTIA91q9nxiF/X+NYuhi9
	YHE3YZq5AJTN8RuLKUBhP2ujE+MAxHmqtqC7KuR4IAU2FanNEWsg/478OnI3+xpmAz3EeIukd1K1g
	1WPs+kQoEP+0rTZ3f4fLH0zm4Y0d0JQpVqpsooF+muemad/KfMEPgZyoLwEKdJYGdZmmHgX0spnks
	AEncC5Tg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qBuU3-00Dvb5-1T;
	Wed, 21 Jun 2023 09:50:39 +0000
Received: from mail-wr1-f45.google.com ([209.85.221.45])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qBuU0-00DvZW-14
	for linux-nvme@lists.infradead.org;
	Wed, 21 Jun 2023 09:50:37 +0000
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-31114d47414so1270312f8f.1
        for <linux-nvme@lists.infradead.org>; Wed, 21 Jun 2023 02:50:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687341033; x=1689933033;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=foLI8oofbou4hrt7TVAkrvJDeJCFo178hS/ZQokH0vY=;
        b=U0tZ7IUteYNgI6YoHea7oE/Ys5DI9S9OPBD9Gg4WbUVErF4XyRKS0AY1Ts1/FUICKg
         l6CWNoPpcltHvE3P+XzICHp1pRymhEISRFMbHDOmxOqHHxG8VHVJNUC6tGtEAjZ8AjCV
         tARw+/AEIEYQPHsQZYDSHyYmuS2dVkq9lTAqzMVL53PG8o4QLcFE4MG0AeJ31KeHHjea
         JnQb8FIWQ5349EQTahMR0JxQqS/GTnyLhRVKOFMHnEICXQqmcx4a7/R26xlFG5zFpI9k
         liQDw3aB6OV8kSwDnZFh0xwlQgLoFtk/n/0wL0AZmdFh84zLURnzFyq9g2PeYT/sTAtc
         dJUA==
X-Gm-Message-State: AC+VfDzY+aHkLiz7INVTrR2A2Jo7mJFohlW2rKulcYolQVyKI/YBPjJ3
	vXkDRHAikd4DwjwTZhyAUG0=
X-Google-Smtp-Source: ACHHUZ4Hah7qAiMDMVHWF7ildurOLQasEXFh5ekDJrboVLcvEPHKdYejnUi/v+YlmoRmMei1jMIPWw==
X-Received: by 2002:adf:f312:0:b0:30e:460b:bede with SMTP id i18-20020adff312000000b0030e460bbedemr12934277wro.5.1687341032561;
        Wed, 21 Jun 2023 02:50:32 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id h9-20020a5d4fc9000000b0031134bcdacdsm3998202wrw.42.2023.06.21.02.50.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 02:50:31 -0700 (PDT)
Message-ID: <083e29ff-4ad0-d05f-0521-56ace13629e6@grimberg.me>
Date: Wed, 21 Jun 2023 12:50:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH blktests v1 1/3] nvme/048: Check for queue count check
 directly
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
 Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
 Hannes Reinecke <hare@suse.de>, James Smart <jsmart2021@gmail.com>,
 Martin Belanger <Martin.Belanger@dell.com>
References: <20230620132703.20648-1-dwagner@suse.de>
 <20230620132703.20648-2-dwagner@suse.de>
 <380cde65-8794-cfbc-237f-30a8d7e9330c@grimberg.me>
 <f6rvvhgim4nk34onfgbwyfctgvgdbdigwbsugjvizgtli46p57@s7c4gkqrpjqy>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <f6rvvhgim4nk34onfgbwyfctgvgdbdigwbsugjvizgtli46p57@s7c4gkqrpjqy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230621_025036_373925_0E358E46 
X-CRM114-Status: GOOD (  10.21  )
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


>>> +nvmf_wait_for_queue_count() {
>>> +	local subsys_name="$1"
>>> +	local queue_count="$2"
>>> +	local nvmedev
>>> +
>>> +	nvmedev=$(_find_nvme_dev "${subsys_name}")
>>> +
>>> +	queue_count_file="/sys/class/nvme-fabrics/ctl/${nvmedev}/queue_count"
>>> +
>>> +	nvmf_wait_for_state "${subsys_name}" "live" || return 1
>>> +
>>> +	queue_count=$((queue_count + 1))
>>> +	if grep -q "${queue_count}" "${queue_count_file}"; then
>>> +		return 0
>>> +	fi
>>> +
>>> +	echo "expected queue count ${queue_count} not set"
>>> +	return 1
>>> +}
>>> +
>>>    set_nvmet_attr_qid_max() {
>>>    	local nvmet_subsystem="$1"
>>>    	local qid_max="$2"
>>> @@ -56,10 +76,7 @@ set_qid_max() {
>>>    	local qid_max="$3"
>>>    	set_nvmet_attr_qid_max "${subsys_name}" "${qid_max}"
>>> -
>>> -	# Setting qid_max forces a disconnect and the reconntect attempt starts
>>> -	nvmf_wait_for_state "${subsys_name}" "connecting" || return 1
>>> -	nvmf_wait_for_state "${subsys_name}" "live" || return 1
>>> +	nvmf_wait_for_queue_count "${subsys_name}" "${qid_max}" || return 1
>>
>> Why not simply wait for live? The connecting is obviously racy...
> 
> That is what the new version is doing. It's waiting for the live state and then
> checks the queue count.

Maybe don't fold waiting for live into waiting for queue_count.

