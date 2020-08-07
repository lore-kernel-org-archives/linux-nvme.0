Return-Path: <SRS0=rw3x=BR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF222C433DF
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 17:20:00 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8EDE20748
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 17:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cFuz92+Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8EDE20748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=s8YbgNbva1GM0TkE2//Z8cS1SmndAsaZETeiDpmLvcc=; b=cFuz92+Z2vHDqP5ybvVed8EIV
	YI8kmVw14hTRqhs+J18hbdQoCK9+2ctFQ3AKpj6S1TMQaPivv9OgTyDboK+93lWZSF1SCPNhrTKeY
	HTFlPeGOZssSfE/bL9fXTTXsm6JFSpYkMHaos+VRVeeWuCtG8MqIzO4mhEL0Rawvuoy3hLjY2p8hW
	+q+Ldbv4H7pGndGaXdCi0tqXOySouLnBYQpr7emraT5zlf1r/F11PNztZpkYN1kfYAivH8shTRscL
	MEHco5i0A2dKZbZSnIfAdqj52JXfnZZgZapUncETW48ZdbjdS7h97FgrMzrJFOVcrSvlNtNUa9rVA
	oB80Qihmw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k4629-00018k-Nf; Fri, 07 Aug 2020 17:19:57 +0000
Received: from mail-pj1-f66.google.com ([209.85.216.66])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k4627-00017s-6s
 for linux-nvme@lists.infradead.org; Fri, 07 Aug 2020 17:19:55 +0000
Received: by mail-pj1-f66.google.com with SMTP id e4so1213820pjd.0
 for <linux-nvme@lists.infradead.org>; Fri, 07 Aug 2020 10:19:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BleyKxaoKX4w+9G8f0gdJ4kFsHgpTWDKDGAXl2lpAl0=;
 b=Y8JFC62hjNNnZ1Q8KJMTJyBI5DW9SfQT+1HK0ThXbG1DsvQ5oUcqceTzBdKFNtVRba
 fRswt+uY85j3kP1P5dsvyWl9oVRWNmznaSuhIgMkffJDmgWIdkOkXPI8LHsTEagbNAAm
 NiIY4dT3fmscx1WssPT/2qXZ24aRXrfMR6uWoDE6u4D7pQRaCfwkIqnGWQ+KqsHixLZD
 eCty4IgHCxjcc6luPtKY9T10ezQDkmCXWoAxcp3PJg9UKCyKdn1HO53LbZtNzZWMSh3f
 fB2Rl3shYUlRJ/BoTair/sTWigDSY7aKQRz/XG0x6td4uyR4230xJCGqAX11KbI4oUwK
 sb+Q==
X-Gm-Message-State: AOAM533Kw3p5+MG66aTip5G6309Pq7TujayJfEpsd0Mn7ep2xse+9cEg
 USY4dn88/nbmr3OtR1dNa+U=
X-Google-Smtp-Source: ABdhPJzZDyVxEsiUBSq+9eTjTln3b83Rm5krk4VI/4+RC9HimfmobBKYf1pZ2uncU1jWY3dPiN4qgQ==
X-Received: by 2002:a17:90a:230d:: with SMTP id
 f13mr13311634pje.116.1596820794059; 
 Fri, 07 Aug 2020 10:19:54 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:3dec:a6f0:8cde:ad1c?
 ([2601:647:4802:9070:3dec:a6f0:8cde:ad1c])
 by smtp.gmail.com with ESMTPSA id y135sm14249922pfg.148.2020.08.07.10.19.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2020 10:19:53 -0700 (PDT)
Subject: Re: [PATCH v2 3/7] nvme: make tests transport type agnostic
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Omar Sandoval <osandov@osandov.com>
References: <20200806191518.593880-1-sagi@grimberg.me>
 <20200806191518.593880-4-sagi@grimberg.me>
 <BYAPR04MB4965624DFCE5A870BDE20A4686490@BYAPR04MB4965.namprd04.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ecf895c8-c009-2327-cd37-e8838b7e5e38@grimberg.me>
Date: Fri, 7 Aug 2020 10:19:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB4965624DFCE5A870BDE20A4686490@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200807_131955_279058_EA783D79 
X-CRM114-Status: GOOD (  20.27  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> diff --git a/tests/nvme/002 b/tests/nvme/002
>> index 999e222705bf..8540623497c7 100755
>> --- a/tests/nvme/002
>> +++ b/tests/nvme/002
>> @@ -21,7 +21,7 @@ test() {
>>    
>>    	local iterations=1000
>>    	local port
>> -	port="$(_create_nvmet_port "loop")"
>> +	port="$(_create_nvmet_port ${nvme_trtype})"
> Is there a way to directly use nvme_trtype especially in rc ?
> if not disregard this comment.

I didn't want to do this, because a test can create multiple ports.
But maybe it could have a default value?

>> @@ -33,10 +33,10 @@ test() {
>>    		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
>>    	_add_nvmet_subsys_to_port "${port}" "blktests-subsystem-1"
>>    
>> -	_nvme_connect_subsys "loop" "blktests-subsystem-1"
>> +	_nvme_connect_subsys ${nvme_trtype} "blktests-subsystem-1"
>>    
>>    	local nvmedev
>> -	nvmedev="$(_find_nvme_loop_dev)"
>> +	nvmedev="$(_find_nvme_dev)"
>>    	cat "/sys/block/${nvmedev}n1/uuid"
>>    	cat "/sys/block/${nvmedev}n1/wwid"
> 
> Since we are touching nvmedev can we move above uuid and wwid to
> a wrapper something like _nvme_show_uuid_wwid ${nvmedev}n1 ?

Doesn't help the patch set cause, so it can be added incrementally.

> 
>>
>> @@ -36,12 +36,12 @@ test() {
>>    
>>    	loop_dev="$(losetup -f --show "$TMPDIR/img")"
>>    
>> -	port="$(_create_nvmet_port "loop")"
>> +	port="$(_create_nvmet_port ${nvme_trtype})"
>>    
>>    	for ((i = 0; i < iterations; i++)); do
>>    		_create_nvmet_subsystem "${subsys}$i" "${loop_dev}"
>>    		_add_nvmet_subsys_to_port "${port}" "${subsys}$i"
>> -		_nvme_connect_subsys "loop" "${subsys}$i"
>> +		_nvme_connect_subsys ${nvme_trtype} "${subsys}$i"
> Same here for nvme_trtype as first comment.
>>    		_nvme_disconnect_subsys "${subsys}$i" >> "${FULL}" 2>&1
>>    		_remove_nvmet_subsystem_from_port "${port}" "${subsys}$i"
>>    		_remove_nvmet_subsystem "${subsys}$i"
>> diff --git a/tests/nvme/rc b/tests/nvme/rc
>> index 6d57cf591300..191f0497416a 100644
>> --- a/tests/nvme/rc
>> +++ b/tests/nvme/rc
>> @@ -6,6 +6,9 @@
>>    
>>    . common/rc
>>    
>> +def_traddr="127.0.0.1"
>> +def_adrfam="ipv4"
>> +def_trsvcid="4420"
>>    nvme_trtype=${nvme_trtype:-"loop"}
>>    
>>    _nvme_requires() {
>> @@ -62,8 +65,8 @@ _cleanup_nvmet() {
>>    	for dev in /sys/class/nvme/nvme*; do
>>    		dev="$(basename "$dev")"
>>    		transport="$(cat "/sys/class/nvme/${dev}/transport")"
>> -		if [[ "$transport" == "loop" ]]; then
>> -			echo "WARNING: Test did not clean up loop device: ${dev}"
>> +		if [[ "$transport" == "${nvme_trtype}" ]]; then
>> +			echo "WARNING: Test did not clean up ${nvme_trtype} device: ${dev}"
>>    			_nvme_disconnect_ctrl "${dev}"
>>    		fi
>>    	done
>> @@ -87,14 +90,20 @@ _cleanup_nvmet() {
>>    	shopt -u nullglob
>>    	trap SIGINT
>>    
>> -	modprobe -r nvme-loop 2>/dev/null
>> +	modprobe -r nvme-${nvme_trtype} 2>/dev/null
>> +	if [[ "${nvme_trtype}" != "loop" ]]; then
>> +		modprobe -r nvmet-${nvme_trtype} 2>/dev/null
> This is not from your patch but I'd keep the error message it has
> turned out to be useful for me when debugging refcount problem
> especially unload and load scenario.

Again, I'd like to avoid doing things that are outside the scope
of what this is trying to achieve because it is not a small change.

We can add it incrementally.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
