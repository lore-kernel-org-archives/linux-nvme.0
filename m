Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 712ACC678D4
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Mar 2023 12:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K8l7CpGmyvyeNECJGOcIoXy3UgUx2lgzfIOXYsj53mk=; b=liISkpD7P+AuUPQ9H2ADaGLD+R
	la2dlrXNrvrQuAr8JxzW/B0x/jD4zMsTTXG8V6YcbMf4GoLXjfsEY4VguDnkZyMmZs2kNV9BqvF1g
	/cklCkzmpqjXm4kgl8VBmNi42WtjQFNE9mJ+4MFu9vhp4mF5mEdSA4qS4mb0WviTdXfej7u1Dso76
	NBuIe4AizHehcwldKNTcxDjar8M7wK0ZJYsTSkqwy8hJFvT8V4ud0qQzuKN92fQLHSYLIfkuuMoT1
	b5P9Hkwj26L4FqFT0IJu3aYyvPGhTKAnqgYLQ77FAhJlAAWLr/s2auDhaQpIyF+cvIP/uwrmuOEIg
	FWd7VtQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZWWC-0007El-3g; Tue, 07 Mar 2023 12:34:12 +0000
Received: from mail-wr1-f45.google.com ([209.85.221.45])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZWW9-0007DS-EL
	for linux-nvme@lists.infradead.org; Tue, 07 Mar 2023 12:34:10 +0000
Received: by mail-wr1-f45.google.com with SMTP id q16so11964415wrw.2
        for <linux-nvme@lists.infradead.org>; Tue, 07 Mar 2023 04:34:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678192444;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K8l7CpGmyvyeNECJGOcIoXy3UgUx2lgzfIOXYsj53mk=;
        b=yQ6jynYT5NR55/ZueQAoeqSojoUuA745hIjJ0YZYCVhu6SyhgZiqv5KCTbvyF9iy3/
         oTwa0q+AVzqy8sIQkIPiU2kM4emK+gWl5U95HQsY+QmEdmW9MJGygQnrEI6LekIxohyK
         bN7CJYy70HKw/WUgCp1ex2Ul1s7etNlYSRE3+k1iPhdYmBBqgfv/H0j93Fiw1vWK4SSO
         ewf5NfLEAXqqC72hbYo1xxI/useXHvtmZDVNouA32+yUoJCZuS2fPWzdfcRVcsfEZe1d
         nVVfXMJMztilihUo7AiF4LbpKUK2SD6HhudCXHGxDS8CpihrL4pdJPY+6DGWEBlw3AMU
         D36Q==
X-Gm-Message-State: AO0yUKVDd1BsDALpJKJ6iRs4C111bQXbSqsCRjW9ML+xZ7lwadX2pX+b
	m9T1BTOosY6bDuFFsgzwWu3P1cNu/Xk=
X-Google-Smtp-Source: AK7set+QAQTS2GNPQc3Zyb1KN9E375IDr1dvfR3diq1sUnSryRZyu7kk1DEVHPE5FcglIWA7v3d+kA==
X-Received: by 2002:a05:6000:11c7:b0:2c7:b49:97f6 with SMTP id i7-20020a05600011c700b002c70b4997f6mr7641309wrx.2.1678192444139;
        Tue, 07 Mar 2023 04:34:04 -0800 (PST)
Received: from [10.100.102.14] (46-116-231-83.bb.netvision.net.il. [46.116.231.83])
        by smtp.gmail.com with ESMTPSA id n5-20020a5d4c45000000b002c55306f6edsm12067946wrt.54.2023.03.07.04.34.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 04:34:03 -0800 (PST)
Message-ID: <442f638a-9ecf-0f17-82e5-06312c2ec5d6@grimberg.me>
Date: Tue, 7 Mar 2023 14:34:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC v1 0/3] Unifying fabrics drivers
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org
References: <20230301082737.10021-1-dwagner@suse.de>
 <a73ea22a-9871-d152-080e-49c0904dbe94@grimberg.me>
 <20230307122849.3oc66ojdsgvvj77h@carbon.lan>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230307122849.3oc66ojdsgvvj77h@carbon.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230307_043409_509087_4A2662CE 
X-CRM114-Status: GOOD (  22.42  )
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



On 3/7/23 14:28, Daniel Wagner wrote:
> On Tue, Mar 07, 2023 at 11:26:12AM +0200, Sagi Grimberg wrote:
>> I think we should make all transports to unify setup/teardown sequences
>> (i.e. including pcie and fc). Otherwise we are not gaining much.
> 
> Not sure about pcie but I haven't really looked at it. The state machine is
> really handling all the fabrics specific queue handling.
> 
> Ideally, fc would use the same state machine. Though the current code base is
> differs quiet significantly but I can try to convert it too.
> 
>> It will help if we make the ops higher level like
>>
>> ops.setup_transport(ctrl)
>> ops.alloc_admin_queue(ctrl)
>> ops.start_admin_queue(ctrl)
>> ops.stop_admin_queue(ctrl)
>> ops.free_admin_queue(ctrl)
>> ops.alloc_io_queues(ctrl)
>> ops.start_io_queues(ctrl)
>> ops.stop_io_queues(ctrl)
>> ops.free_io_queues(ctrl)
> 
> This is more ore less what v2 is.
> 
>> The init/deinit can be folded to alloc/free I think.
> 
> Yes, that would a good thing. In my first attempt I tried to keep things more a
> less identically with the existing code, just using the callbacks for the
> transport specific bits.
> 
>> This is indeed a much larger effort, but I don't know what
>> this unification of rdma/tcp buys us really...
> 
> My motiviation is that we are keep fixing the same bugs in rdma and tcp
> transport since a while. The state machine code is almost identically so why not
> trying to reduce the code duplication?

I'm not saying that we shouldn't, I'm saying that we should consolidate
with all transports (rdma/fc/tcp/loop and ideally also pcie which is
closer to fabrics than what it used to be).

