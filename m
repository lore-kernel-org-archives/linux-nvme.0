Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DB11ECAAD2
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Aug 2022 18:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=plewtFTqSvvjikxwMXdnwKyZnCUz+CyO1lbBHJXtMF0=; b=KXBuZbdo18OmdlVU8vLM5gfyQ/
	qJRuTtdZmQLlPjP7n6Q4vTwtI+vUytEwrYHAb8kqT22ErwwOVRw4FlRBlkR6q6JxBvgZ4qd2HI9Fy
	HheMt4ieuU4LvrOzP53/2uJstrAP1chkH4dyXjrbwkDQRyv8of1o0V8kei/4o7jhFkzLjuoDMsFwB
	5w/Ej2VTvZw3ewV+qrV5dyX+qO/qMj9p9fxwZ4FLp2ZnGYH5UQ75aYFm6jma5xIrhwHatSVDWInog
	zQuKVg9tBUyoyL866kUKnBTtiw03y3nFy2QAzQwnOCuoXOXTTB7DHSh0IfHfN31veikBRsgjpzirj
	MNuGaDsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSjlw-00CIpk-Ho; Mon, 29 Aug 2022 18:46:08 +0000
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSjkb-00CI3x-Pw
	for linux-nvme@lists.infradead.org; Mon, 29 Aug 2022 18:44:47 +0000
Received: by mail-qt1-x82b.google.com with SMTP id cr9so6830251qtb.13
        for <linux-nvme@lists.infradead.org>; Mon, 29 Aug 2022 11:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=plewtFTqSvvjikxwMXdnwKyZnCUz+CyO1lbBHJXtMF0=;
        b=IjyqZQk4L+UILjWZqabz5YQ6ipR9TkImCRUHfqgDEGXWwJSaiNXI9oNib6h334Iw6N
         kou4KTQSJAX8uMTvQmTS1hLDQSw9vlVXgx2jDfzQlwrNGwp78jgQMIV0OW5tlRUQPahX
         CYImdpaIKmyfBnh5ZjHqIvKNvTtetudbrgYYqCc8+AXXpNJyriWzuAIOSco1pOe3fDn2
         //dQtJcSAFOM4hNqrMsTrVKTH/ZxiL9WLjqAWoEiBtCG3Ynt8p0cIyn+OHjP8wbz6Vsq
         ELDVJuLvG4MWr0Fp4q71UcoVxvlGcNb2eGZQhfnplNeb36A2Hg+j8iJMkb2e4AWhuqj4
         y8vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=plewtFTqSvvjikxwMXdnwKyZnCUz+CyO1lbBHJXtMF0=;
        b=eeMyLRimVqAWNQtdHH3rCmh4sJ9PFrJdZ7uNw08mXNLEf8IA0ugleUdRVATJupPwkT
         T/4ZLxqYrw2VpKIIuKHuw+QoDW6ezsq7Sm1Gdha9x/jDEbJEZbzfTPVDMMvGiGhJ231g
         dNoLZ1zxii+1HaXDfeFHn96Y+BdVy+YcJBOKkZ1GvOd95thF8CUjbA9jvP3uXVh7+doP
         RzTafPEfCw8gZsUWdZNv3pFvp/aWQeXaRHpkthlR1qUsUQbsCX2+R5MnnLcpL8CHGci3
         2cLNgwoACM21FA5dFHXv1l3ELZo+j9OnuTzNYgOtSIEb/CDIR9zZyOT0GSi2gINZQTiR
         EY8Q==
X-Gm-Message-State: ACgBeo3qoffh3qFDHrtn6FXFnmwa1OyOEZpkgA3A8bSCYI50NdnCRxKc
	XWmL7G6VZvMkaUV28LevoRc=
X-Google-Smtp-Source: AA6agR42BTR8e2O+CV4U3UH2eM0qJgDOAv8H2UK7NTBX8Qm3BNCLiD4RjXm+0ixn4e8Lfe1r7m4PpQ==
X-Received: by 2002:ac8:5a96:0:b0:344:b3be:6931 with SMTP id c22-20020ac85a96000000b00344b3be6931mr11474557qtc.509.1661798683797;
        Mon, 29 Aug 2022 11:44:43 -0700 (PDT)
Received: from [192.168.50.208] (ip98-164-255-77.oc.oc.cox.net. [98.164.255.77])
        by smtp.gmail.com with ESMTPSA id s16-20020ac85290000000b0034305a91aaesm5639217qtn.83.2022.08.29.11.44.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 11:44:43 -0700 (PDT)
Message-ID: <0ef532ad-819f-0e7b-402f-3ca20831109b@gmail.com>
Date: Mon, 29 Aug 2022 11:44:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3 0/3] Handle number of queue changes
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
 Chao Leng <lengchao@huawei.com>
References: <20220829083856.1850-1-dwagner@suse.de>
From: James Smart <jsmart2021@gmail.com>
In-Reply-To: <20220829083856.1850-1-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220829_114445_910870_0F0324D0 
X-CRM114-Status: GOOD (  20.75  )
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

On 8/29/2022 1:38 AM, Daniel Wagner wrote:
> Updated this series to a proper patch series with Hannes and Sagi's
> feedback addressed.
> 
> I tested this with nvme-tcp but due to lack of hardware the nvme-rdma
> is only compile tested.
> 
> Daniel
> 
> 
>  From the previous cover letter:
> 
> We got a report from our customer that a firmware upgrade on the
> storage array is able to 'break' host. This is caused a change of
> number of queues which the target supports after a reconnect.
> 
> Let's assume the number of queues is 8 and all is working fine. Then
> the connection is dropped and the host starts to try to
> reconnect. Eventually, this succeeds but now the new number of queues
> is 10:
> 
> nvme0: creating 8 I/O queues.
> nvme0: mapped 8/0/0 default/read/poll queues.
> nvme0: new ctrl: NQN "nvmet-test", addr 10.100.128.29:4420
> nvme0: queue 0: timeout request 0x0 type 4
> nvme0: starting error recovery
> nvme0: failed nvme_keep_alive_end_io error=10
> nvme0: Reconnecting in 10 seconds...
> nvme0: failed to connect socket: -110
> nvme0: Failed reconnect attempt 1
> nvme0: Reconnecting in 10 seconds...
> nvme0: creating 10 I/O queues.
> nvme0: Connect command failed, error wo/DNR bit: -16389
> nvme0: failed to connect queue: 9 ret=-5
> nvme0: Failed reconnect attempt 2
> 
> As you can see queue number 9 is not able to connect.
> 
> As the order of starting and unfreezing is important we can't just
> move the start of the queues after the tagset update. So my stupid
> idea was to start just the older number of queues and then the rest.

Since you're in the area....

I recommend adding something to ensure that after a reconnect that if 
I/O queues were present in the prior association, the new controller 
must return support for at least 1 io queue or the reconnect fails and 
retries. This was a bug we hit on a subsystem in FC.

-- james


