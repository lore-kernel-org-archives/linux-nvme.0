Return-Path: <SRS0=DDko=AE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65DFC433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jun 2020 23:17:45 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0D9C20888
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jun 2020 23:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="U2B7uOSv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0D9C20888
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/9nRw1XR1hpxqjgPf1L1vIpJF4dynBrDiaZJdR0pUfc=; b=U2B7uOSvgu6dKbKJ7mzvc0oB8
	h+FtVYnIEjs/1gApiLG4M6ETmJQx+cFOjqSB2Ir01ddTV2fuRRD/urwoMJJjcMYRiaO8Ii+fxIRVZ
	/v9SPTLRI8vtZ23V9mIhEz+8YK0YcXFdF1ckpUsD6YvieOy+Sz5j48IvgMQMI4j67DK3XqF010eud
	PK5MVVQezlCpg0yPzOvX2fVxk6GXlbfl0wwRe6t0TwyLYbWv3Jnzmzrihxg87+ouU6Pob7ypztZ0D
	PMbSSL25aQofhgBHMXkZLEQcgdcxJsfN+qwEP2Fdq3qtktYtIIm8rv5YGbhm3OOkADhPuZR6RXI7T
	NOaVLhuwg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jnsAd-0000B7-Dj; Tue, 23 Jun 2020 23:17:39 +0000
Received: from mail-pj1-f44.google.com ([209.85.216.44])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jnsAZ-0000AK-MA
 for linux-nvme@lists.infradead.org; Tue, 23 Jun 2020 23:17:36 +0000
Received: by mail-pj1-f44.google.com with SMTP id u14so173225pjj.2
 for <linux-nvme@lists.infradead.org>; Tue, 23 Jun 2020 16:17:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8v36kYHXqDYrXPPTKD7e7zSjDj1Y3K52NiTT8vrQFZs=;
 b=WDSSUvM9vUc2GB55k2BBudrlDOvweasGQI5nhXovKYhaOzCbeFOL6igT+PjY8UT4iN
 qnnvPmMACV+6pzbVqmZVyMgR/EpWSGrcfobpOg4YofpQeaXj2bsjnt7TAQz4ulO4Ak2f
 nbantDVsH+l0J3OhUwg4iLD3J9g0HsXvzQv3/N4s/eVyRakj/xqWvOp4n08aUm6CX4MQ
 qpzz3AqLkU+fiRMHeqCDFcTo7hbTueCxBCrSn4XWpXq2qrNAGKMubVmTMW+rYymkGNFh
 Cm9Dwpkb0KIoCdfDGrH/VJprqW3NBRNSyAt2evN2Bku25jwolJD6HNWf9E7BUk4NjWh4
 bIuA==
X-Gm-Message-State: AOAM5312w2nooUiPZS5i+JKp5pZtqZcjurldbOqn4H4e6nH5U3nKJW0s
 /AX/rrmryXiuk3k1zfCTl/I=
X-Google-Smtp-Source: ABdhPJyxl4r8T7DEPzVPz2DLf7o7GMcybweLGUVOHBnXcHDft4F8gcBM7tpnsMQdahNy5CwdmTqzdg==
X-Received: by 2002:a17:90b:fd3:: with SMTP id
 gd19mr3695656pjb.83.1592954253341; 
 Tue, 23 Jun 2020 16:17:33 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:acd7:a900:b9f:8b8b?
 ([2601:647:4802:9070:acd7:a900:b9f:8b8b])
 by smtp.gmail.com with ESMTPSA id c194sm17615949pfc.212.2020.06.23.16.17.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2020 16:17:32 -0700 (PDT)
Subject: Re: [PATCHv3 3/5] nvme: implement I/O Command Sets Command Set support
To: Keith Busch <kbusch@kernel.org>, Niklas Cassel <Niklas.Cassel@wdc.com>
References: <20200622162530.1287650-1-kbusch@kernel.org>
 <20200622162530.1287650-4-kbusch@kernel.org>
 <69e8e88c-097b-368d-58f4-85d11110386d@grimberg.me>
 <20200623112551.GB117742@localhost.localdomain>
 <20200623221012.GA1291643@dhcp-10-100-145-180.wdl.wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <b5b7f6bc-22d4-0601-1749-2a631fb7d055@grimberg.me>
Date: Tue, 23 Jun 2020 16:17:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200623221012.GA1291643@dhcp-10-100-145-180.wdl.wdc.com>
Content-Language: en-US
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>, Daniel Wagner <dwagner@suse.de>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
 "hch@lst.de" <hch@lst.de>, Matias Bjorling <Matias.Bjorling@wdc.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>>> -		len = nvme_process_ns_desc(ctrl, ids, cur);
>>>> +		len = nvme_process_ns_desc(ctrl, ids, cur, &csi_seen);
>>>>    		if (len < 0)
>>>>    			goto free_data;
>>>>    		len += sizeof(*cur);
>>>>    	}
>>>>    free_data:
>>>> +	if (!status && nvme_multi_css(ctrl) && !csi_seen) {
>>>
>>> We will clear the status if we detect a path error, that is to
>>> avoid needlessly removing the ns for path failures, so you should
>>> check at the goto site.
>>
>> The problem is that this check has to be done after checking all the ns descs,
>> so this check to be done as the final thing, at least after processing all the
>> ns descs. No matter if nvme_process_ns_desc() returned an error, or if
>> simply NVME_NIDT_CSI wasn't part of the ns desc list, so the loop reached the
>> end without error.
>>
>> Even if the nvme command failed and the status was cleared:
>>
>>                  if (status > 0 && !(status & NVME_SC_DNR))
>>                          status = 0;
> 
> This check is so weird. What has DNR got to do with whether or not we
> want to continue with this namespace? The commit that adds this says
> it's to check for a host failed IO, but a controller can just as validly
> set DNR in its error status, in which case we'd still want clear the
> status.

The reason is that if this error is not a DNR error, it means that we
should retry and succeed, we don't want to remove the namespace.

The problem that this solves is the fact that we have various error
recovery conditions (interconnect issues, failures, resets) and the
async works are designed to continue to run, issue I/O and fail. The
scan work, will revalidate namespaces and remove them if it fails to
do so, which is inherently wrong if these are simply inaccessible by
the host at this time.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
