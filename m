Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A638C10F1A
	for <linux-nvme@archiver.kernel.org>; Sun, 12 May 2024 14:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aNeBJLTigatIolunLX5l8+wKbiAT6liy3IpwbjRMLXY=; b=YGDndb3/tw175dJGMty3u1YAwC
	1jPAKXyoFZG6bMKbmyQ9BBDe/1F7ciaj99OPwWb0e26BPMJqDxjGdVzw+xXbGD9F8SyU1ddAmkeN7
	vozJmM8T9y2qoO8bg7wJWidamZV1VXfs6FQtpqIdURRpQC9RTMpV85J/9qVgQjRJiKpDDb6PldG4c
	m+yAMRVfH0awKdYrOAu0bRYQCeW2pq9k7Po2DJY/5F+XtZ4jlxqlHTkoXCFR4Z0TL5M+/ev//oVUp
	EWN+T0+j9Q6IWo7gWP8d03yCMlNsnENYag7yDTs7NbsMI1Olh0xt2xTwiBrhDjW1ykRunK0DXBkyL
	Njb/sRow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6A00-0000000A4cQ-3x62;
	Sun, 12 May 2024 14:16:24 +0000
Received: from mail-wr1-f45.google.com ([209.85.221.45])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s69zy-0000000A4bg-0bQV
	for linux-nvme@lists.infradead.org;
	Sun, 12 May 2024 14:16:23 +0000
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-34cba0d9a3eso316320f8f.1
        for <linux-nvme@lists.infradead.org>; Sun, 12 May 2024 07:16:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715523377; x=1716128177;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aNeBJLTigatIolunLX5l8+wKbiAT6liy3IpwbjRMLXY=;
        b=un6VkWaWtRNCdh7sVxMzt/Ks2HsZkfwIewCZHqEv5qEvKQfs+hNbBJTd+BNxTdP5Lz
         gg169D+cZCIObFzwc59l23f/Z6GpMI2lp0ru4Wi1A0dQKrxMiqXJJ6SsvnanEc1swN3x
         JDuT05iQD6AR2EgpD69LM3op3WI7mKsrivCug5adqihweGQV4L6Y2hDJ9fSgGxhHbpJw
         jud172ecd2i6gpNOcTEO7V7odFlz+uI9NYY+zNCyzGXa9icqU/qAfa5prOBaW105G0jW
         6V9K7I0v2JUxEDwFc/RAZqdL+7+hz8vUGQaqNNYMPch4Tt4Re6NK/+UOfbH1UyqemZBr
         somg==
X-Forwarded-Encrypted: i=1; AJvYcCXYPw0J3BOmN0eE8Ij2mFo3R+1/ff0WzinrA8fLpu0Yqjx6OEEVXC/ii51eBflFbLXteEyJMqAPmK0OnYQryhFaXzrQdav7EOe2xuiFk4o=
X-Gm-Message-State: AOJu0Yyk8i3080tLIi2UH5J9BLUj1BOJYJpD8eyQqS+wP1WnAFhb1xdS
	e5ykxiRa15n47WsNPXzUt/lmE7FTok4G8rXyPHLj6qdxa4zruFYM
X-Google-Smtp-Source: AGHT+IFCAEPpkK8tOiiPuFaXmEZve1ougOZtItIUmi8f+jI4YOyEqYQKDqIB6oBTW22oyIdqs2c11Q==
X-Received: by 2002:a5d:4149:0:b0:34f:96ba:ca39 with SMTP id ffacd0b85a97d-3504a206f13mr4693516f8f.0.1715523377282;
        Sun, 12 May 2024 07:16:17 -0700 (PDT)
Received: from [172.21.2.130] ([50.204.89.33])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b8a76e6sm8972273f8f.62.2024.05.12.07.16.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 May 2024 07:16:17 -0700 (PDT)
Message-ID: <d6e8c980-7be7-4902-b466-79dc4b9beb17@grimberg.me>
Date: Sun, 12 May 2024 17:16:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] nvme-pci: allow unmanaged interrupts
To: Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org, hch@lst.de
References: <20240510174645.3987951-1-kbusch@meta.com>
 <Zj6yDtRzl68zspQY@fedora> <Zj6745UDnwX1BteO@kbusch-mbp.dhcp.thefacebook.com>
 <Zj6/gqxxDD74IYR6@fedora>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <Zj6/gqxxDD74IYR6@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240512_071622_324121_A1FB9942 
X-CRM114-Status: GOOD (  13.02  )
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


>> Everyone expects nvme performance will suffer. IO latency and CPU
>> efficieny are not everyone's top priority, so allowing people to
>> optimize for something else seems like a reasonable request.
> I guess more people may be interested in 'something else', care to share
> them in the commit log, cause nvme is going to support it.

I don't have a special interest in this, but I can share what I heard 
several
times. The use-case is that people want to dedicate a few cores to handle
interrupts so they know it does not take cpu time from their application 
threads
that are running (usually pinned to different cores).

The app threads isolation is more important to them than affinity to the 
device...

>
>>   
>>> Is there any benefit to use unmanaged irq in this way?
>> The immediate desire is more predictable scheduling on a subset of CPUs
>> by steering hardware interrupts somewhere else. It's the same reason
>> RDMA undid managed interrupts.
>>
>>    231243c82793428 ("Revert "mlx5: move affinity hints assignments to generic code")
> The above commit only mentions it becomes not flexible since user can't
> adjust irq affinity any more.
>
> It is understandable for network, there is long history people need to adjust
> irq affinity from user space.

I suspect that the reasoning is similar to nvme as well.

