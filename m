Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D38BDC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 24 May 2022 13:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=clApbZMBY2yOG/4t3bp9A3szGqgjWUeQRiB7kxQlXGE=; b=ApJYhOlZImymPfMweoiSYpUYnU
	p2HsgB/UL911zpJyJxNZnsGwOGdNFv/Vz6KO6Z3vmiCHDq+8sDioRVnhC470hsjh2Wq577TFopMol
	5zzyDkWCqGE8auFeLKyo0gmyBQJ5lfQ/78c6JwmZpnEjcP8ENRTjsMWKccOToaGHXaWUPBe50O8ik
	gGB1w+EMpfzlmWOGBkXh+BaB5MBauIOhS4YPz8+ICHxWpmM28xQT9CxSctFCj4dyQzrJKjfeTQwaz
	BLRNMaEX73MCUEygdWkXsVpIVlUbcWOBsMydh72tP1keIchejkEBZOh3Lm+h0BMul6+NbeKkcGVz/
	uhN6AWJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ntULx-0084Fn-HO; Tue, 24 May 2022 13:13:37 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ntULs-0084E8-TF
 for linux-nvme@lists.infradead.org; Tue, 24 May 2022 13:13:36 +0000
Received: by mail-wr1-f46.google.com with SMTP id u27so24839808wru.8
 for <linux-nvme@lists.infradead.org>; Tue, 24 May 2022 06:13:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:from:to:references:in-reply-to
 :content-transfer-encoding;
 bh=clApbZMBY2yOG/4t3bp9A3szGqgjWUeQRiB7kxQlXGE=;
 b=QJPsmPoI0fx+vFXbqp3HIP4tjSpVAkINcEtPIxhbWAbKPU2t1wWugE9YbjiZKxqlfJ
 9qJrUe6G3gCFLHdLT+NsnlbDzTjl6+0qcEJKrhm0jGKwueohAOyxHiK7itUdRishWVR0
 i7c0EJ57NgOXMEVqLZosSIUyUEuNVrqxkPg8ajPoU+etCprdzbbAAzedQCvULRpz24v2
 EtwSTk16GKnv3vGPSQxgbYhHTXHD7hSnnEgr1Pw3aS02gH6wmOMrKJiQrhCinpeLmtEn
 jcVh50rOalNBimQ2zX/J/zROX+6I29K9wmA9+H/55DDXE+Nm/Gqtw5MKO+8u5R/8Hw2k
 M7Sg==
X-Gm-Message-State: AOAM531XYSzhLYujvTfdSQBpnStXI9Bk2v8xYzO+ZnvpumYijVX676Mc
 lc10wfUyc2Ll6jV9okE7jr11zT+C0pE=
X-Google-Smtp-Source: ABdhPJx+NChEIczXuQgN/xceK5oxNZGMvoPIHkxBfPXZ7C72nFZzC1Ywy4k9OEXGlw3FIrXm2oazDQ==
X-Received: by 2002:adf:d1c9:0:b0:20f:c3dc:e980 with SMTP id
 b9-20020adfd1c9000000b0020fc3dce980mr15258276wrd.552.1653398009914; 
 Tue, 24 May 2022 06:13:29 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 l24-20020adfa398000000b0020fcaba73bcsm9919051wrb.104.2022.05.24.06.13.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 May 2022 06:13:29 -0700 (PDT)
Message-ID: <95e18f3a-7997-ccbe-7889-18585bb72ff3@grimberg.me>
Date: Tue, 24 May 2022 16:13:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC] nvme-rdma: Stop queues when starting with error recovery
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
References: <20220523152102.41000-1-dwagner@suse.de>
 <c3e5bad8-8cca-8058-38d7-0eea2ddfd6bc@grimberg.me>
In-Reply-To: <c3e5bad8-8cca-8058-38d7-0eea2ddfd6bc@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220524_061332_990278_5514F5E8 
X-CRM114-Status: GOOD (  20.78  )
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



On 5/24/22 16:12, Sagi Grimberg wrote:
> 
> 
> On 5/23/22 18:21, Daniel Wagner wrote:
>> When we enter error recovery we should stop all queue activities and
>> all armed timers.
>>
>> For example, we could arming an ANATT timer right before we enter
>> error recovery but do not successfully recover before the timer
>> fires. The timer is supposed only be active when the controller is in
>> LIVE state hence we should call nvme_stop_ctrl when starting with the
>> recover activites.
> 
> This takes me back... IIRC the main reason why the error recovery
> handler in nvme-rdma (and nvme-tcp) does not start with nvme_stop_ctrl()
> is because back then, nvme_stop_ctrl() could block until an
> admin_timeout expired on an inflight admin command (I have a vague
> memory that if cancelled/flushed the scan_work), which delayed I/O
> failover, hence we just cherry-picked what needed to be stopped to make
> sure I/O failover will not be blocked by anything and progress quickly.
> 
> If I look at nvme_stop_queue

nvme_stop_ctrl obviously...

  it does not touch the scan_work, but it
> does flush ana_work which includes I/O, so it can still block on it
> to fail after admin_timeout expires... also flush failfast_work is
> taking the namespaces_rwsem (although read access). The fw_act_work
> is probably meaningless for fabrics...
> 
> Maybe we need to have something like nvme_stop_ctrl_fast, that will just
> stop the non-blocking stuff, so failover can work quickly, and then
> after we have failover, we can do the full nvme_stop_ctrl() or the
> reminder of nvme_stop_ctrl_fast...
> 
> thoughts?

