Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF06BC433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 20 May 2022 09:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Xey/FwjQGJmE8KAZdflykEEW2d6j0vVqybrAu+f0xz4=; b=4JuCnBsRUYldo1ranjnRDUYHL9
	FWBl3oIzr7H5gOMTi2oI1JtGML77PKvSo5PhflCUsfcwpSDhLrwJpBRSwSHo32cDvvqKojhyN0X3M
	S58CApxx7lpsAaaKvBMEPnBrFSv7dy1QQe8DlMW9G/qqQLJWIlYHXaq5436f5O/UQVwkomI4RyF44
	le5/KgFqTYcOvNp0POj3YDtPRj/wWVtAjAL3rzncVMuBN0k7lmUEqttskl7ODO0dnsb2SMAOHJDYT
	7z8XX5We0i2j7ARrtD3tO5EAHFb7JAkrny+s/+MG7QF1vQfKV5M/+cWdkhqvxX8W+WBdws/s26d7k
	/o5KEjJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nryoM-00BZ00-UN; Fri, 20 May 2022 09:20:42 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nryoK-00BYxG-NE
 for linux-nvme@lists.infradead.org; Fri, 20 May 2022 09:20:41 +0000
Received: by mail-wr1-f50.google.com with SMTP id t6so10649266wra.4
 for <linux-nvme@lists.infradead.org>; Fri, 20 May 2022 02:20:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=Xey/FwjQGJmE8KAZdflykEEW2d6j0vVqybrAu+f0xz4=;
 b=smQQ8TmpUmJdXT0V5hQ9JFO1GffSiMdGbzBdDknybI/yqqsyQgYuV0PMJOA2HLNyq0
 6q2qKmvOoqDKl3pW5UIJP4Tc8IYBstMXODbdI1KUlaZQwnV5Y5R8d5D1ZQ2KqbEcDRjV
 Y2F1qfKkdw5SIkx2pS5U+hSqmAOaSk+HxClwLKu4CoN8I6O/KQY9BEoRVeS6aSqzB17J
 J2XyLvLe+yKDR4pebjazM8uZ8h+Fi7jjyBSY0VHvKEFvJUiYBdeguQ0Nnqt1uA6Fu2VQ
 3uRS5cNom4aZuyNJPPXKAgTvkjkiTW1hHCSYlGQ0nq/TZ4l5WVHgj0iwxNSW6QhDL+rG
 d+sQ==
X-Gm-Message-State: AOAM533rV6cydTVguUfS25iJrQV+8DUgoPPX04j/ydD5uB+CukXoKbn4
 y9j6igBguFlc2ep2c5QM8/0=
X-Google-Smtp-Source: ABdhPJxL+kxhLZxjuNsC5/zoat08IhRT0NpIACrJQemwufUPyKC3ocyF8b2fgcqvhwLh+5Hd5dtqDA==
X-Received: by 2002:adf:f012:0:b0:20d:80e:1170 with SMTP id
 j18-20020adff012000000b0020d080e1170mr7146557wro.401.1653038437538; 
 Fri, 20 May 2022 02:20:37 -0700 (PDT)
Received: from [10.100.102.14] (46-117-125-14.bb.netvision.net.il.
 [46.117.125.14]) by smtp.gmail.com with ESMTPSA id
 bd18-20020a05600c1f1200b003973d0a78casm229846wmb.38.2022.05.20.02.20.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 May 2022 02:20:37 -0700 (PDT)
Message-ID: <64f57dcf-f3d2-d1db-782e-4f48c542754d@grimberg.me>
Date: Fri, 20 May 2022 12:20:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 0/3] nvme-tcp: queue stalls under high load
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20220519062617.39715-1-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220519062617.39715-1-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220520_022040_809291_9353C46C 
X-CRM114-Status: GOOD (  15.58  )
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


> Hi all,
> 
> one of our partners registered queue stalls and I/O timeouts under
> high load. Analysis revealed that we see an extremely 'choppy' I/O
> behaviour when running large transfers on systems on low-performance
> links (eg 1GigE networks).
> We had a system with 30 queues trying to transfer 128M requests; simple
> calculation shows that transferring a _single_ request on all queues
> will take up to 38 seconds, thereby timing out the last request before
> it got sent.
> As a solution I first fixed up the timeout handler to reset the timeout
> if the request is still queued or in the process of being send. The
> second path modifies the send path to only allow for new requests if we
> have enough space on the TX queue, and finally break up the send loop to
> avoid system stalls when sending large request.

What is the average latency you are seeing with this test?
I'm guessing more than 30 seconds :)

