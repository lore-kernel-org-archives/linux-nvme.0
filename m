Return-Path: <SRS0=OxAA=5E=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC2FFC4332B
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Mar 2020 14:49:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6581120782
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Mar 2020 14:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="m8kpz1ok"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6581120782
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Fh55GgAC4DtifxkWfOJnoRwr15ypZwaXZ8LIY9MiJtM=; b=m8kpz1ok1PEuuU+PIvMdMQxtA
	wwBz+/rNVr7+/KXHaYD4n47tdT20CjEYcuhYJpy0tRNE/HtkKgi1H0JxaB+5hUCwnON8ycmmuW1Uu
	DbvoU+wEkKd+M7ePZ2216REupjoDymiIT501KlNNCwffx3OtkF817m037nP2+NZaZRYsMpa3NAxL4
	dEFLoouVaQIMLMBKbeeeRR0/L2vQBE7ggc+J0bn4kupG8xVK0HwRw9VIPTJDCLPr0TWPuQZ7vxpEe
	8qiXJGyaOx8gU+G1pFxIzlLrpoHtBBz8Cz+S/AgVosVX47BBomqn6aDVeb+psGoPb09az4pLYCrW0
	vm2vDkOGQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jEwUL-0000c3-HR; Thu, 19 Mar 2020 14:49:37 +0000
Received: from mail-pg1-f193.google.com ([209.85.215.193])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jEwUJ-0000bj-3V
 for linux-nvme@lists.infradead.org; Thu, 19 Mar 2020 14:49:36 +0000
Received: by mail-pg1-f193.google.com with SMTP id k191so247113pgc.13
 for <linux-nvme@lists.infradead.org>; Thu, 19 Mar 2020 07:49:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JuHbSS0eGsYBNljx6ogyRU5OrOR3D6tnYOH5aEot1bo=;
 b=P/I0RZwyBLwVMKLjBv/c8JnAFZY62pKS03Q5Xyi1NZVbsZaiGXOZ+ySyDFGBzWKKN1
 D3fw6pmn8tnJm33dQx5FoheyFnat9M7VHgudxsCiedvJ0khcJH+10jjnBSUCEwwC6Y9A
 mKhFKjHVCa0YrnNKyljsmKNb+wsKqv62l8s+BNB021oUUONYK8LvGcT9xDULH/ehtWli
 W0aXe5etSSSjDiyWoTJWc9fJZsxv0/fj2NzjmURblOsnn3nF4By92c6YkKVEYesHjutL
 +2ydAokQxGI+LmdsSG0Rx25gdErBueG0AHmS1DGidI3mYdvAFvg+8GSyZRhXxXw8k7Vj
 kWXQ==
X-Gm-Message-State: ANhLgQ3vvgh1MrrOqMqtFuzuEZgJ660qT3I17UusB6ZKHhIJi4GhYtrK
 CMYQNNUHaxKXd9in58Rmb7o=
X-Google-Smtp-Source: ADFU+vsVsNb+pyULR/67nR+rIO5LTV/Xrueh2tN2NiSmX7YZWsKNbda6OdDSE8Bh0g5Z19vwJuslFA==
X-Received: by 2002:a63:1e4f:: with SMTP id p15mr3832067pgm.28.1584629374199; 
 Thu, 19 Mar 2020 07:49:34 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:af99:b4cf:6b17:1075?
 ([2601:647:4000:d7:af99:b4cf:6b17:1075])
 by smtp.gmail.com with ESMTPSA id y131sm2920765pfb.78.2020.03.19.07.49.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Mar 2020 07:49:33 -0700 (PDT)
Subject: Re: [PATCH v2 3/5] nvmet-rdma: use SRQ per completion vector
To: Jason Gunthorpe <jgg@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>
References: <20200318150257.198402-1-maxg@mellanox.com>
 <20200318150257.198402-4-maxg@mellanox.com>
 <d72e0312-1dfd-460e-bc83-49699d86dd64@acm.org>
 <5623419a-39e6-6090-4ae2-d4725a8b9740@mellanox.com>
 <20200319115654.GV13183@mellanox.com>
 <0b11c26f-d3de-faf5-5609-c290ea46ed9c@mellanox.com>
 <20200319135356.GZ13183@mellanox.com>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <6dcf300c-d010-829b-b996-285ad16786d5@acm.org>
Date: Thu, 19 Mar 2020 07:49:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200319135356.GZ13183@mellanox.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200319_074935_143823_BADCB385 
X-CRM114-Status: GOOD (  14.75  )
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
Cc: loberman@redhat.com, sagi@grimberg.me, vladimirk@mellanox.com,
 idanb@mellanox.com, linux-rdma@vger.kernel.org, shlomin@mellanox.com,
 linux-nvme@lists.infradead.org, leonro@mellanox.com, dledford@redhat.com,
 oren@mellanox.com, kbusch@kernel.org, rgirase@redhat.com, hch@lst.de
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 3/19/20 6:53 AM, Jason Gunthorpe wrote:
> On Thu, Mar 19, 2020 at 02:48:20PM +0200, Max Gurtovoy wrote:
> 
>> Nevertheless, this situation is better from the current SRQ per HCA
>> implementation.
> 
> nvme/srp/etc already use srq? I see it in the target but not initiator?
> 
> Just worried about breaking some weird target somewhere

 From the upstream SRP target driver:

static void srpt_get_ioc(struct srpt_port *sport, u32 slot,
			 struct ib_dm_mad *mad)
{
	[ ... ]
	if (sdev->use_srq)
		send_queue_depth = sdev->srq_size;
	else
		send_queue_depth = min(MAX_SRPT_RQ_SIZE,
				       sdev->device->attrs.max_qp_wr);
	[ ... ]
	iocp->send_queue_depth = cpu_to_be16(send_queue_depth);
	[ ... ]
}

I'm not sure the SRP initiator uses that data from the device management
I/O controller profile.

Anyway, with one SRQ per initiator it is possible for the initiator to
prevent SRQ overflows. I don't think that it is possible for an initiator
to prevent target side SRQ overflows if shared receive queues are shared
across multiple initiators.

Thanks,

Bart.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
