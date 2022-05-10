Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA187C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 10 May 2022 23:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3v+p0mkjcjVcYZsVzpz7K33Xoaqzsk12OmOvm8nvT6E=; b=am6MX6Gj8nmAWDlpe4W5zaEA+L
	A66Q1AplQhdUNUNJAl2Mw9XAYdwMNDHuY1CEPvxm4vRHGPe0OTvJT6vasLp8X1v1Ny/HfbyNNmy7O
	PeJ5TWu/gCS/+qa7/Mb4qiYCKxQKOwcOIT9VTifKVB1NYYBF5zgnYA19rTwuLqovVmd6IYKdHri4Y
	FAAGxrMdqSByhBLwh7K9xb610Cz/VvAOfqAiLf7YeE25PunbzEFMlWzSnpSHQIhPtfmEuMBc8iEVG
	RzDsiQC3+HKKVE/ddf6gR/mHLPZkTVhxJTK8x9gSMwTsI8+Ifm4euAFZXz4LRrJuLUWr0tFtsTSwA
	gxPbuXSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1noZan-004Pk1-8M; Tue, 10 May 2022 23:48:37 +0000
Received: from mail-pg1-f177.google.com ([209.85.215.177])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1noZaj-004PiR-Le
 for linux-nvme@lists.infradead.org; Tue, 10 May 2022 23:48:35 +0000
Received: by mail-pg1-f177.google.com with SMTP id 202so293528pgc.9
 for <linux-nvme@lists.infradead.org>; Tue, 10 May 2022 16:48:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=3v+p0mkjcjVcYZsVzpz7K33Xoaqzsk12OmOvm8nvT6E=;
 b=FLEwjAWsS11dDuCsb3ZjHluECRJShzB35lJNWswAbQnFNp13U83J5Ca8Ox6ditl7TU
 x0yov2hPFayuF3vj2AGP2YTHNoFmPvG5EIzNhkMX2ToXessC8M9WDE14fNlxJMWK6cVE
 EhNy47DdojT911PckxH1PyEAh8f15IHE/FjPkw62eJbHXaMsCUHKc7u5bX/G/fBywFY9
 0L3s+IC0NQVKMZJrbHGYnj27zXjgRbMycyOan9AwXGZ2eVi4V3GqvfTWV2F5p5RPmjfZ
 g7QNy+SDhMSeC6+N8Wl129Q9VMcZv103l+M3vvNW6U8+tRaQ5feDo6qdFQTaK95WXVSF
 fqmg==
X-Gm-Message-State: AOAM532gj7d9qCnMQCEY08FteJcQM6aEzjKTYykcrfitW9JPfEEXuhyh
 mT+l4Pe0LWFEpQsfc2djbXw=
X-Google-Smtp-Source: ABdhPJxBH3ZzFAMX8tmiVtXSkg7M8wADCwG50qATAXW/1EUPKFBzrhrpdaFwRg4hdHcUNRL//MbNtQ==
X-Received: by 2002:a05:6a00:174a:b0:4fd:ac35:6731 with SMTP id
 j10-20020a056a00174a00b004fdac356731mr22714238pfc.71.1652226511410; 
 Tue, 10 May 2022 16:48:31 -0700 (PDT)
Received: from [10.69.0.118] ([131.107.8.246])
 by smtp.gmail.com with ESMTPSA id
 s20-20020a170902989400b0015e8d4eb206sm197883plp.80.2022.05.10.16.48.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 May 2022 16:48:31 -0700 (PDT)
Message-ID: <6eab7100-168f-e371-dbc4-a8946925099f@grimberg.me>
Date: Tue, 10 May 2022 16:48:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 blktests] tests/nvme: add tests for error logging
Content-Language: en-US
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Alan Adamson <alan.adamson@oracle.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "osandov@fb.com" <osandov@fb.com>
References: <20220510164304.86178-1-alan.adamson@oracle.com>
 <20220510164304.86178-2-alan.adamson@oracle.com>
 <da090342-f3c5-b3fa-d062-553a4f8a522c@grimberg.me>
 <20220510232919.xoxet3k7cxboixmt@shindev>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220510232919.xoxet3k7cxboixmt@shindev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220510_164833_761773_8064A519 
X-CRM114-Status: GOOD (  17.18  )
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


>> On 5/10/22 19:43, Alan Adamson wrote:
>>> Test nvme error logging by injecting errors. Kernel must have FAULT_INJECTION
>>> and FAULT_INJECTION_DEBUG_FS configured to use error injector. Tests can be
>>> run with or without NVME_VERBOSE_ERRORS configured.
>>>
>>> These test verify the functionality delivered by the follow:
>>> 	commit bd83fe6f2cd2 ("nvme: add verbose error logging")
>>>
>>> Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
>>> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
>>> ---
>>>    tests/nvme/039     | 185 +++++++++++++++++++++++++++++++++++++++++++++
>>>    tests/nvme/039.out |   7 ++
>>>    2 files changed, 192 insertions(+)
>>>    create mode 100755 tests/nvme/039
>>>    create mode 100644 tests/nvme/039.out
>>>
>>> diff --git a/tests/nvme/039 b/tests/nvme/039
>>> new file mode 100755
>>> index 000000000000..e6d45a6e3fe5
>>> --- /dev/null
>>> +++ b/tests/nvme/039
>>> @@ -0,0 +1,185 @@
>>> +#!/bin/bash
>>> +# SPDX-License-Identifier: GPL-3.0+
>>> +# Copyright (C) 2022 Oracle and/or its affiliates
>>> +#
>>> +# Test nvme error logging by injecting errors. Kernel must have FAULT_INJECTION
>>> +# and FAULT_INJECTION_DEBUG_FS configured to use error injector. Tests can be
>>> +# run with or without NVME_VERBOSE_ERRORS configured.
>>> +#
>>> +# Test for commit bd83fe6f2cd2 ("nvme: add verbose error logging").
>>> +
>>> +. tests/nvme/rc
>>> +DESCRIPTION="test error logging"
>>> +QUICK=1
>>> +
>>> +requires() {
>>> +	_nvme_requires
>>> +	_have_kernel_option FAULT_INJECTION && \
>>> +	    _have_kernel_option FAULT_INJECTION_DEBUG_FS
>>> +}
>>> +
>>> +declare -A NS_DEV_FAULT_INJECT_SAVE
>>> +declare -A CTRL_DEV_FAULT_INJECT_SAVE
>>> +
>>> +save_err_inject_attr()
>>> +{
>>> +	local a
>>> +
>>> +	for a in /sys/kernel/debug/"${ns_dev}"/fault_inject/*; do
>>> +		NS_DEV_FAULT_INJECT_SAVE[${a}]=$(<"${a}")
>>> +	done
>>> +	for a in /sys/kernel/debug/"${ctrl_dev}"/fault_inject/*; do
>>> +		CTRL_DEV_FAULT_INJECT_SAVE[${a}]=$(<"${a}")
>>> +	done
>>> +}
>>> +
>>> +restore_err_inject_attr()
>>> +{
>>> +	local a
>>> +
>>> +	for a in /sys/kernel/debug/"${ns_dev}"/fault_inject/*; do
>>> +		echo "${NS_DEV_FAULT_INJECT_SAVE[${a}]}" > "${a}"
>>> +	done
>>> +	for a in /sys/kernel/debug/"${ctrl_dev}"/fault_inject/*; do
>>> +		echo "${CTRL_DEV_FAULT_INJECT_SAVE[${a}]}" > "${a}"
>>> +	done
>>> +}
>>> +
>>> +set_verbose_prob_retry()
>>> +{
>>> +	echo 0 > /sys/kernel/debug/"$1"/fault_inject/verbose
>>> +	echo 100 > /sys/kernel/debug/"$1"/fault_inject/probability
>>> +	echo 1 > /sys/kernel/debug/"$1"/fault_inject/dont_retry
>>> +}
>>> +
>>> +set_status_time()
>>> +{
>>> +	echo "$1" > /sys/kernel/debug/"$3"/fault_inject/status
>>> +	echo "$2" > /sys/kernel/debug/"$3"/fault_inject/times
>>> +}
>>> +
>>> +inject_unrec_read_err()
>>> +{
>>> +	# Inject a 'Unrecovered Read Error' error on a READ
>>> +	set_status_time 0x281 1 "$1"
>>> +
>>> +	dd if=/dev/"$1" of=/dev/null bs=512 count=1 iflag=direct \
>>> +	    2> /dev/null 1>&2
>>> +
>>> +	if ${nvme_verbose_errors}; then
>>> +		dmesg -t | tail -2 | grep "Unrecovered Read Error (" | \
>>> +		    sed 's/nvme.*://g'
>>> +	else
>>> +		dmesg -t | tail -2 | grep "Cmd(" | sed 's/I\/O Cmd/Read/g' | \
>>> +		    sed 's/I\/O Error/Unrecovered Read Error/g' | \
>>> +		    sed 's/nvme.*://g'
>>> +	fi
>>> +}
>>> +
>>> +inject_invalid_read_err()
>>> +{
>>> +	# Inject a valid invalid error status (0x375) on a READ
>>> +	set_status_time 0x375 1 "$1"
>>> +
>>> +	dd if=/dev/"$1" of=/dev/null bs=512 count=1 iflag=direct \
>>> +	    2> /dev/null 1>&2
>>> +
>>> +	if ${nvme_verbose_errors}; then
>>> +		dmesg -t | tail -2 | grep "Unknown (" | \
>>> +		    sed 's/nvme.*://g'
>>> +	else
>>> +		dmesg -t | tail -2 | grep "Cmd(" | sed 's/I\/O Cmd/Read/g' | \
>>> +		    sed 's/I\/O Error/Unknown/g' | \
>>> +		    sed 's/nvme.*://g'
>>> +	fi
>>> +}
>>> +
>>> +inject_write_fault()
>>> +{
>>> +	# Inject a 'Write Fault' error on a WRITE
>>> +	set_status_time 0x280 1 "$1"
>>> +
>>> +	dd if=/dev/zero of=/dev/"$1" bs=512 count=1 oflag=direct \
>>> +	    2> /dev/null 1>&2
>>> +
>>> +	if ${nvme_verbose_errors}; then
>>> +		dmesg -t | tail -2 | grep "Write Fault (" | \
>>> +		    sed 's/nvme.*://g'
>>> +	else
>>> +		dmesg -t | tail -2 | grep "Cmd(" | sed 's/I\/O Cmd/Write/g' | \
>>> +		    sed 's/I\/O Error/Write Fault/g' | \
>>> +		    sed 's/nvme.*://g'
>>> +	fi
>>> +}
>>> +
>>> +inject_id_admin()
>>> +{
>>> +	# Inject a valid (Identify) Admin command
>>> +	set_status_time 0x286 1000 "$1"
>>> +
>>> +	nvme admin-passthru /dev/"$1" --opcode=0x06 --data-len=4096 \
>>> +	    --cdw10=1 -r 2> /dev/null 1>&2
>>> +
>>> +	if ${nvme_verbose_errors}; then
>>> +		dmesg -t | tail -1 | grep "Access Denied (" | \
>>> +		    sed 's/nvme.*://g'
>>> +	else
>>> +		dmesg -t | tail -1 | grep "Admin Cmd(" | \
>>> +		    sed 's/Admin Cmd/Identify/g' | \
>>> +		    sed 's/I\/O Error/Access Denied/g' | \
>>> +		    sed 's/nvme.*://g'
>>> +	fi
>>> +}
>>> +
>>> +inject_invalid_cmd()
>>> +{
>>> +	# Inject an invalid command (0x96)
>>> +	set_status_time 0x1 1 "$1"
>>> +
>>> +	nvme admin-passthru /dev/"$1" --opcode=0x96 --data-len=4096 \
>>> +	    --cdw10=1 -r 2> /dev/null 1>&2
>>> +	if ${nvme_verbose_errors}; then
>>> +		dmesg -t | tail -1 | grep "Invalid Command Opcode (" | \
>>> +		    sed 's/nvme.*://g'
>>> +	else
>>> +		dmesg -t | tail -1 | grep "Admin Cmd(" | \
>>> +		    sed 's/Admin Cmd/Unknown/g' | \
>>> +		    sed 's/I\/O Error/Invalid Command Opcode/g' | \
>>> +		    sed 's/nvme.*://g'
>>> +	fi
>>> +}
>>> +
>>
>> All of the above seems like they belong in common code...
> 
> So far, this nvme/039 is the only one user of the helper functions above. Do you
> foresee that future new test cases in nvmeof-mp or srp group will use them?
> 

I can absolutely see other tests inject errors. I meant that this code
should live in nvme/rc

