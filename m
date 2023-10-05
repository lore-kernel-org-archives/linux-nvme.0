Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1590E92FC9
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Oct 2023 22:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ltrto+rjiXQu6CZ+tQzK6opfBYwCjT8QDYR8jfh7uis=; b=YoWhReqwVshnhDncfA3Ezr6ZfC
	CfDOMpRfJSIT2a1wNc3dJMSO2EEnG6EM66OVf9by1awGl9YetfpYUicirnTLkv7L8TFgvaZ7z4Kqy
	M1lRRCYBvQ4ZN6Uy/o0eE9J+5xfDhYsiourMOmoahKGT7rEN4yvthtHiSt9xPiTkje1qdpFPPq6N+
	VWdJ+QT37MjHrEQ9edvBszqeWOfUukGwLXeuifH6SPbDbSlxXAGaig81Qy3oHLkZQ6Pf8yN79WQGF
	OoWUdCQrZK8pZgWaojbBNrkhLVQdvH+moTW4J/ZIbClHCBbZF+P0aB7Lr59AjYB40AtqodBQkht74
	/jpxiI/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qoXIv-004aI2-0y;
	Thu, 05 Oct 2023 22:58:49 +0000
Received: from mail-pl1-f169.google.com ([209.85.214.169])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qoXIp-004aHh-2B
	for linux-nvme@lists.infradead.org;
	Thu, 05 Oct 2023 22:58:47 +0000
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1c871a095ceso12665425ad.2
        for <linux-nvme@lists.infradead.org>; Thu, 05 Oct 2023 15:58:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696546722; x=1697151522;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ltrto+rjiXQu6CZ+tQzK6opfBYwCjT8QDYR8jfh7uis=;
        b=Zo9TVFGMeClKiNIoqfKO/QMzK7Juw4sMK4TOeexWEjryXybdAZ747AigP5WuALEC6P
         jjMa7MCziwFaz/OeHkVBhBSJyXOCoFsc35do8KUYffN8b2WaQqoifQX8GG43RhBPO5BX
         UWTAhiv03PAx9r8I7RiD87E6PxrV1f4aoMJDN8oJJ9nVrhtAZC5kwww8GLZ34MQKYKAG
         LDAnl+84CvQ5mVZURcu97CIsifdCji1NWMiwuLk7p7ZJwZ5HMy0IUO3qNTXQFyA4FI8U
         ucEVjJ3r6T8+eYQbMYZX7ig6MijQku8ZGEUXoQ6UTFFryweqGvvsPEN96Zs1TqT+hXnD
         uUfw==
X-Gm-Message-State: AOJu0YwufdOqdMG/UYcJn2gETPU6dfup4ZDyuLRkH7z4fsXqov+ASfHi
	mE7KG9I6In1xs0uu4SWl2TI=
X-Google-Smtp-Source: AGHT+IG0/9Wn5G/tnzM5vE5E/JIG1ER4pe53NdB/BX3Y8VlltjOu9i9A0D7Ui0Qfz98C4QopBOrp7w==
X-Received: by 2002:a17:902:6ac4:b0:1c6:d34:5279 with SMTP id i4-20020a1709026ac400b001c60d345279mr6265144plt.13.1696546722102;
        Thu, 05 Oct 2023 15:58:42 -0700 (PDT)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902c24600b001b89a6164desm2316513plg.118.2023.10.05.15.58.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 15:58:41 -0700 (PDT)
Message-ID: <d976868a-d32c-43d1-b5da-ebbc4c8de468@acm.org>
Date: Thu, 5 Oct 2023 15:58:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/21] block: Add fops atomic write support
Content-Language: en-US
To: Dave Chinner <david@fromorbit.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
 John Garry <john.g.garry@oracle.com>, axboe@kernel.dk, kbusch@kernel.org,
 hch@lst.de, sagi@grimberg.me, jejb@linux.ibm.com, djwong@kernel.org,
 viro@zeniv.linux.org.uk, brauner@kernel.org, chandan.babu@oracle.com,
 dchinner@redhat.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, tytso@mit.edu,
 jbongio@google.com, linux-api@vger.kernel.org
References: <20230929102726.2985188-11-john.g.garry@oracle.com>
 <17ee1669-5830-4ead-888d-a6a4624b638a@acm.org>
 <5d26fa3b-ec34-bc39-ecfe-4616a04977ca@oracle.com>
 <b7a6f380-c6fa-45e0-b727-ba804c6684e4@acm.org>
 <yq1lecktuoo.fsf@ca-mkp.ca.oracle.com>
 <db6a950b-1308-4ca1-9f75-6275118bdcf5@acm.org>
 <yq1h6n7rume.fsf@ca-mkp.ca.oracle.com>
 <34c08488-a288-45f9-a28f-a514a408541d@acm.org>
 <yq1ttr6qoqp.fsf@ca-mkp.ca.oracle.com>
 <a2077ddf-9a8f-4101-aeb9-605d6dee3c6e@acm.org>
 <ZR86Z1OcO52a4BtH@dread.disaster.area>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ZR86Z1OcO52a4BtH@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231005_155843_728149_F6018DFE 
X-CRM114-Status: GOOD (  10.56  )
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

On 10/5/23 15:36, Dave Chinner wrote:
> $ lspci |grep -i nvme
> 03:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller SM981/PM981/PM983
> 06:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller SM981/PM981/PM983
> $ cat /sys/block/nvme*n1/queue/write_cache
> write back
> write back
> $
> 
> That they have volatile writeback caches....

It seems like what I wrote has been misunderstood completely. With
"handling a power failure cleanly" I meant that power cycling a block device
does not result in read errors nor in reading data that has never been written.
Although it is hard to find information about this topic, here is what I found
online:
* About certain SSDs with power loss protection:
   https://us.transcend-info.com/embedded/technology/power-loss-protection-plp
* About another class of SSDs with power loss protection:
   https://www.kingston.com/en/blog/servers-and-data-centers/ssd-power-loss-protection
* About yet another class of SSDs with power loss protection:
   https://phisonblog.com/avoiding-ssd-data-loss-with-phisons-power-loss-protection-2/

So far I haven't found any information about hard disks and power failure
handling. What I found is that most current hard disks protect data with ECC.
The ECC mechanism should provide good protection against reading data that
has never been written. If a power failure occurs while a hard disk is writing
a physical block, can this result in a read error after power is restored? If
so, is this behavior allowed by storage standards?

Bart.

