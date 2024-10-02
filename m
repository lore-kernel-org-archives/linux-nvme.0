Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01F8ECF6D38
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Oct 2024 15:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XFmPXFxwmqaEH2pONVsLGilCAvF1LQPRHWEwVuuQJ1U=; b=Q8iDKQIfGTKdAMeeOUr7TpUZzk
	G+tNnn3kFPr0GAPNBEp6dKMbejxgdglrJL3RFx9lxcinVXlzT6UQFEXtzU/M4f/Sujca3L5Xb5CWT
	7HHa0mMujPgDgsyBEb0+WJpJG4U4CiTbO9YpPJE2aLdcxgdMgTWKWJ1vqVr5VIPHAUqeQX/zvspkH
	h72qeBKOQVLB6ghOP4pTY4XS1JwVMlNeQ5wpvTCS/PLhjGeAvwB4ShTnBs6cB3E9GGdEQfmmtj6l1
	WK9Ph2IW9MuM3upQbZoLSslzuEObd/lT84FlQaivXOcly5m+pGykNcXIh9k0grigyCk3mhoPr4KKE
	rgnszbaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sw1BT-00000006cqQ-1LGp;
	Wed, 02 Oct 2024 15:22:35 +0000
Received: from mail-il1-x130.google.com ([2607:f8b0:4864:20::130])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sw1BQ-00000006cpU-1pIO
	for linux-nvme@lists.infradead.org;
	Wed, 02 Oct 2024 15:22:33 +0000
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-3a1a3090f93so23086045ab.1
        for <linux-nvme@lists.infradead.org>; Wed, 02 Oct 2024 08:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1727882551; x=1728487351; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XFmPXFxwmqaEH2pONVsLGilCAvF1LQPRHWEwVuuQJ1U=;
        b=eZsSI7jd8PlH/a5we1h6jiy6WZFISXdpohGMHXKbEwQFuwpm8+vsvbqfvaZpjbu6oA
         b2KB1NPhgoGPlq6o+aVRIN5sAl2WWvtIvIASyGSz0pX4YiL3Nqbm21Fy7PAPGkVFSY+Z
         ZrayaQOehcjY2k4c697cxrzpfQ2gYMLCI5/yGKbdMVfixe6grJjwMn+MHgCWGBeNFzrt
         idv7PIKixEyI9aeLHxemUpvFF719Mj5yylzRYlqq+68YwCNBQG9LyUUpk76ybV+DHEYT
         8CIwkO3GrNoDj95deGYaAVl9s6DPTD+DQL1I6aleX0oWKbG5ioRSDYYFhadLV7EYTLup
         99FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727882551; x=1728487351;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XFmPXFxwmqaEH2pONVsLGilCAvF1LQPRHWEwVuuQJ1U=;
        b=fMXB0qhzJlTAUWhi8VEbm08jQnC4rpv+mq4I0BJOnlAE3VzJac/DhBUpP4MdHJFfP9
         WxRAt9MDNYQ5QbOqFhoSpF8J5qocBvCajFfnl9fRTdwfDkdeHWf/xMJ0WRR0WVig46GC
         zAG741SvQgJxCM9BjCpzImhNRDADaz2PmlHAQDap+cTHYPNQzy3s2L3q8LJLkE45s8nq
         vgrDPtPY7R2bdZaZjNBKdJzKhwRmt+CE6OVkB7Vj1jRldS8SyCCdTdt4HCcc35qLpTc/
         FEJwueFUYhHVqH2xoNvZliNMo49vuJNtVhJ40k6oGifGsc0CfW4QZtUQrX0pYiqXJgZw
         /KPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaQPFi/qWn3woFAL3zsXDWbujQ7m8P574Y1vEfCdjKX5kxAn8jQz+JDnwmW88PlSQSI20Zg9Ez/ptd@lists.infradead.org
X-Gm-Message-State: AOJu0YwcQEivjuqp9qQeCzMi+Tx9XRzfkH630ucXjJXDxBXLMO5KRghC
	YwbCvIn81q8H0whgV1yXcZeK3RwpH11NaG8+HJi9tG5iSerDYbnyX9cOSuXvcns=
X-Google-Smtp-Source: AGHT+IEBXbiNHRx4XAwQFwRZqM92YvVanHnKcrNWpONgoVpy541W2Db8S2wG2E4AqcgHPytdS2Swmg==
X-Received: by 2002:a05:6e02:148e:b0:39b:640e:c5e6 with SMTP id e9e14a558f8ab-3a365942ff6mr33405025ab.17.1727882550903;
        Wed, 02 Oct 2024 08:22:30 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a344de21bfsm36751815ab.54.2024.10.02.08.22.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 08:22:30 -0700 (PDT)
Message-ID: <865a8947-1267-4df2-a2bd-dfe36c293317@kernel.dk>
Date: Wed, 2 Oct 2024 09:22:29 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/3] FDP and per-io hints
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, kbusch@kernel.org, hare@suse.de,
 sagi@grimberg.me, martin.petersen@oracle.com, brauner@kernel.org,
 viro@zeniv.linux.org.uk, jack@suse.cz, jaegeuk@kernel.org, bcrl@kvack.org,
 dhowells@redhat.com, bvanassche@acm.org, asml.silence@gmail.com,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-block@vger.kernel.org, linux-aio@kvack.org,
 gost.dev@samsung.com, vishak.g@samsung.com, javier.gonz@samsung.com
References: <CGME20240930182052epcas5p37edefa7556b87c3fbb543275756ac736@epcas5p3.samsung.com>
 <20240930181305.17286-1-joshi.k@samsung.com> <20241001092047.GA23730@lst.de>
 <99c95f26-d6fb-4354-822d-eac94fdba765@kernel.dk>
 <20241002075140.GB20819@lst.de>
 <f14a246b-10bf-40c1-bf8f-19101194a6dc@kernel.dk>
 <20241002151344.GA20364@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241002151344.GA20364@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241002_082232_512484_29CB96C4 
X-CRM114-Status: GOOD (  18.68  )
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

On 10/2/24 9:13 AM, Christoph Hellwig wrote:
> On Wed, Oct 02, 2024 at 09:03:22AM -0600, Jens Axboe wrote:
>>> The previous stream separation approach made total sense, but just
>>> needed a fair amount of work.  But it closely matches how things work
>>> at the hardware and file system level, so it was the right approach.
>>
>> What am I missing that makes this effort that different from streams?
>> Both are a lifetime hint.
> 
> A stream has a lot less strings attached.  But hey, don't make me
> argue for streams - you pushed the API in despite reservations back
> then, and we've learned a lot since.

Hah, I remember arguing for it back then! It was just a pain to use, but
thankfully we could kill it when devices didn't materialize with a
quality of implementation that made them useful. And then we just yanked
it. Nothing is forever, and particularly hints is something that can
always be ignored. Same for this.

>>> Suddenly dropping that and ignoring all comments really feels like
>>> someone urgently needs to pull a marketing stunt here.
>>
>> I think someone is just trying to finally get this feature in, so it
>> can get used by customers, after many months of fairly unproductive
>> discussion.
> 
> Well, he finally started on the right approach and gave it up after the
> first round of feedback.  That's just a bit weird.

I'm a big fan of keep-it-simple-stupid, and then you can improve it down
the line. I think the simple approach stands just fine alone.

-- 
Jens Axboe

