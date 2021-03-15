Return-Path: <SRS0=15CP=IN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E54FC433DB
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 17:22:12 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07B3061494
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 17:22:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07B3061494
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=nH4Mp0xuUbEYE5S807x7VDLNOqBk7IG+kKFi1xxYu3k=; b=RL18SfH65aQe+Yq2LvyF6QsR8
	z/FCj8ek8N2L40mVZXFbOUDHfKADmJj8nknqXfjivL52OLzG4bgs31b55mJf28ZZ7RSwVVVU+zMnW
	h9c8obwXWwB/TH+ylcDUsVj5QeKkGhU3fwWPB0l0cgvGnhD9xSPuJxzNOk4aD5pKBvqZU6zzcgM6Y
	qM5MxV3ziFqhO4eGUDGMJs11w7sy3G1caxmD8ChpiMg8TkAlqM/Uh6BZFt5SokT00PS8X5L4XAUqL
	w+pCrDS/PKAc0DXIQWsbak/lWhed7pyyFCiMXqvH5OSldcPXK6hnD2PJc6ofH/+jtaoDbBTQXDq80
	iqVKq9F1w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lLqui-00GUt6-1a; Mon, 15 Mar 2021 17:21:56 +0000
Received: from mail-pg1-f171.google.com ([209.85.215.171])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lLquX-00GUrT-LD
 for linux-nvme@lists.infradead.org; Mon, 15 Mar 2021 17:21:52 +0000
Received: by mail-pg1-f171.google.com with SMTP id t37so10050825pga.11
 for <linux-nvme@lists.infradead.org>; Mon, 15 Mar 2021 10:21:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dMRlrjeCABVmQ3PKk3//dMJMN8ceVp7UqJeDgsUcXbI=;
 b=kYN431GEqHkalnaBf8Z8VFX1yzQ4ZCR0o+9hPw3UCAv2IuiqEZH/zDZRI+wZFNsa+d
 4M7OvSfvIg58dBDYUopI2B6xpypiS4QS3U3YJNLjEXKdSRc1xwNSecH4YIA4ntWcAQ2l
 HvtkbDgzbICj1HgRKNBn2gb4ck02Qi76EObBGL6FAGkbFulAJkSJRiejg6sLr5maR/ZE
 pAnjnQAvzusvImCoBwyt3sEye27T8DOoUcHk6JDF/T9HiesmCXL6yxDnFvgVu5KFgCEf
 xogqpfSPyLPzcHPlDRndZgyxoHqOjD3KrOdX9FMHXllSsaAW1n3R4Fw21KcCdjJAf9EH
 G79A==
X-Gm-Message-State: AOAM531Ooy+imLw+o0p1APePc2FA8X336yjgKtEfp8Mfj2I3GzfEqDYj
 DqJbH6RLdqxOWEhdul7tWhQ=
X-Google-Smtp-Source: ABdhPJw0QhPWjh1CRTcYpc9Tsh4o0oPQX+v9xhXSacqG/6qyZbhArambMEzWyRX3hOXYRxeGUILZ4Q==
X-Received: by 2002:aa7:81cd:0:b029:1ee:db83:c852 with SMTP id
 c13-20020aa781cd0000b02901eedb83c852mr25454287pfn.49.1615828903444; 
 Mon, 15 Mar 2021 10:21:43 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4faf:1598:b15b:7e86?
 ([2601:647:4802:9070:4faf:1598:b15b:7e86])
 by smtp.gmail.com with ESMTPSA id d16sm12653103pgb.12.2021.03.15.10.21.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Mar 2021 10:21:42 -0700 (PDT)
Subject: Re: [PATCH 2/2] nvme: add 'queue_if_no_path' semantics
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Keith Busch <keith.busch@wdc.com>
References: <20201005124500.6015-1-hare@suse.de>
 <20201005124500.6015-3-hare@suse.de> <20201005125201.GB1125@lst.de>
 <8d7d4803-5808-0839-ee4f-e36a12756497@suse.de>
 <20201006075153.GA10041@lst.de>
 <b720433b-5849-2e7f-d359-53247976bad5@suse.de>
 <20201006082727.GC10243@lst.de>
 <a848297e-3243-6366-86ee-0800d51198e1@suse.de>
 <20201006083926.GA13568@lst.de>
 <00e75643-d422-ca12-1648-02ca89044182@suse.de>
 <ce2c93e1-ba38-cebb-33b3-d506116a61aa@suse.de>
 <28830f4b-181d-2a4d-0bdd-2f63fcdbcf72@grimberg.me>
 <44affc5e-d655-aa1c-55fe-65805d66065a@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <34e5c178-8bc4-68d3-8374-fbc1b451b6e8@grimberg.me>
Date: Mon, 15 Mar 2021 10:21:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <44affc5e-d655-aa1c-55fe-65805d66065a@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210315_172147_210618_D2786923 
X-CRM114-Status: GOOD (  15.22  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>> And yes, this is exactly the same setup, the only difference being the
>>> CMIC setting for the NVMe device.
>>
>> I agree with Christoph that we should do exactly the same for all.
>>
>> Hannes, My understanding here is that you want the device to go away
>> after the last path disappeared because it breaks md, why don't you
>> want to have this also for fabrics?
>>
> Oh, I would _love_ to have it for fabrics per default.
> If you agree with it I can resend Keiths original patch, which solves
> the issue without the need for any additional settings.

I think that this is what we should do. Care to resend this for
both fabrics and pci?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
