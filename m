Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20750C25B7A
	for <linux-nvme@archiver.kernel.org>; Tue, 21 May 2024 10:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zaiAWU3NXtCfmiYvgYy3wEGjD3mnbg8XC2Sk28TmeCE=; b=wn2tShQWKjqbpJBo/SqmUPo8aG
	+kro85/oTuHuEOcueLpFIvVIVis7rAwhNdSu97O5FDLVSYQbR5i50yH/lxU7dE+wpOSPi2ahTNGWJ
	wyu3Nb2mJsZJ7knz+0Gp2gWpN+2oPZpPAZ15U0llujOtK5TISnFSOUxED8Bse8p4uTt/7rBJ8soQP
	qw9RIsatg/tjdxJ5Y2pTqC4yerni8/DozoMSA30GERpbiaVd6kd/g7BiuxMzy8Q7oF7HF+X/Mggve
	2gFMidBbuVIpH1Wi8gAHtCxgD0mZUUIQH+A7jyRo+tQq2W2w/MfNs/EvbYLxqknDfB+wCQEi0H35h
	wBjT9BKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9MZt-0000000H3rZ-0FPR;
	Tue, 21 May 2024 10:18:41 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9MY3-0000000H2rJ-3uA8
	for linux-nvme@bombadil.infradead.org;
	Tue, 21 May 2024 10:16:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=zaiAWU3NXtCfmiYvgYy3wEGjD3mnbg8XC2Sk28TmeCE=; b=BycvmTJ3wWYQq/6ZFM+1LadtAl
	UfkDDnzwZpm+h+N3uFIQgImL8P6urYs7FJmoJeHQo0SNAE8GOWgBpjJRQ0Eg2js2FaYFDRe8oGQmz
	0ui99fLdBG51t3wo4vElthyow1ehoZJphxBemZK81s7/msALyLtpP7VZUpDFxNgDfPaHky6SIxSGE
	NWawMR4J+Jg17GRwtZ87naoL20lUuYskcRzf7u3HrAcZOX5vQq/0Z/mS7UzjuKDc2m/TuPCXzJ0Tt
	IOKQjQ6UuhgvqiEf1JPPdNO3IDKvDBSzqoza8tI8RAsJg0WRQASktJnnydkg8jBKForeL9YLOpJJU
	cYDBS0vA==;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9MXu-00000006gB1-4A2w
	for linux-nvme@lists.infradead.org;
	Tue, 21 May 2024 10:16:44 +0000
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-354c3b445bbso270651f8f.1
        for <linux-nvme@lists.infradead.org>; Tue, 21 May 2024 03:16:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716286597; x=1716891397;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zaiAWU3NXtCfmiYvgYy3wEGjD3mnbg8XC2Sk28TmeCE=;
        b=Ja8tqqtwxFmW4wfAChUT4pchNqVSIPViPbFg/pM7Ez3KTMpTAx7zj1stXYg4Amskiv
         +aKhE+zC3UdTrACADpCxKxi07+uqHPilPP85TUDZZgogdd6QqehZt4KAG+YJaUA6Ag1f
         LXdH5VgkkRlZDD0+tFO97WL8/5RNFH+f9DF2uNQcwuACYJrbHN7Oo3321TlWDzH66Y4g
         IPSlcXrQivHuFltv8TaOkKTZpwRXKjFzg97zMJIFRMFnD/qoJo+0yITJVL3MQtgTv/Mz
         F1ruQf46SI+nlcW8tkvHHvVXMBp9WZK+YeYOBVWexQhGKdSb6yr2W5+bMVh34suLYIop
         Jy2A==
X-Gm-Message-State: AOJu0YyNP+ecpkIcHDlHwvEJNCURV3i1zXGm5tRySyKiJB45izzynbX/
	r6cZ9lBuLspCcSL78aw2Bd/vnG4ZYBwZUEJTij23sAkCRlM362xa
X-Google-Smtp-Source: AGHT+IHzm5XmKjKZ6tsHMVzBPcQUMKdYpRr8I/AR7wUCjqE+6Br3cDXCQYKdwXv8uiY0N0OcPJJHrg==
X-Received: by 2002:a05:6000:227:b0:34b:5cef:4af3 with SMTP id ffacd0b85a97d-3504aa689d9mr22396035f8f.6.1716286597126;
        Tue, 21 May 2024 03:16:37 -0700 (PDT)
Received: from [10.100.102.74] (85.65.193.189.dynamic.barak-online.net. [85.65.193.189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-351d2df8449sm15112285f8f.12.2024.05.21.03.16.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 03:16:36 -0700 (PDT)
Message-ID: <ba2a6973-ba58-492c-9785-31e50ab40957@grimberg.me>
Date: Tue, 21 May 2024 13:16:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] nvme: multipath: Implemented new iopolicy
 "queue-depth"
From: Sagi Grimberg <sagi@grimberg.me>
To: Nilay Shroff <nilay@linux.ibm.com>, John Meneghini <jmeneghi@redhat.com>,
 kbusch@kernel.org, hch@lst.de, emilne@redhat.com
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 jrani@purestorage.com, randyj@purestorage.com, hare@kernel.org
References: <20240520202045.427110-1-jmeneghi@redhat.com>
 <20240520202045.427110-2-jmeneghi@redhat.com>
 <945416af-3f8b-40b5-9681-49973beb2cb2@linux.ibm.com>
 <3b8d33db-f2c3-469a-bfa0-8fc52594f243@grimberg.me>
 <95fe3168-ec39-4932-b9fc-26484de49191@linux.ibm.com>
 <da35bc8b-6813-42c8-b446-8a07b08db156@grimberg.me>
 <073ae18a-a80e-4a95-a093-36210a3bb230@grimberg.me>
Content-Language: he-IL, en-US
In-Reply-To: <073ae18a-a80e-4a95-a093-36210a3bb230@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240521_111639_741331_CEC795AE 
X-CRM114-Status: GOOD (  10.40  )
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



On 21/05/2024 13:15, Sagi Grimberg wrote:
>
>
> On 21/05/2024 13:11, Sagi Grimberg wrote:
>>
>>>> Don't think this matters because cancellation only happens when we
>>>> teardown the controller anyways...
>>>>
>>> I think in case if we reset the nvme controller then we don't teardown
>>> controller, isn't it? In this case we cancel all pending requests, and
>>> later restart the controller.
>>
>> Exactly, nvme_mpath_init_ctrl resets the counter.
>
> Except you're right, the counter reset needs to move to 
> nvme_mpath_init_identify()
> or some place that is called on every controller reset.

This however raises the question of how much failover/reset tests this 
patch has seen...

