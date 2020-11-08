Return-Path: <SRS0=Cbe1=EO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F31B2C388F9
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Nov 2020 09:44:20 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71AB3206E3
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Nov 2020 09:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ue2vG0xT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fuANvQfl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71AB3206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:Subject:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=hQadXAs2s9ZxM/zpMsQ0fbSMrF6PcCYUYC02MQrUI7s=; b=Ue2vG0xTXrvL34wTPcK8Fc9HX
	ssp2cTnOLLRqaBrseYNSoZSIiJrNkikYFgoB2fiFNNOhidNULYY1shrsn74dw6GAJyoRaWu8XvcDh
	CXN0bC4IXPidMLfXWHhSv5wY4Ta8yVH1R/2WgDsF3FXpPEpjWHRZibwYoidg+0/0nMJRgBLCU5yQC
	jXooyNpq2lvIJwPJbokhnTxHWpESzS8h7bXSG06lrFKyrdWU+3i/9A2TznOagETdGSmD/4iLdW48z
	IJ4FLP4VH2Ynjg9Cp3qBSTHqSr8TGWj0L2cZnGO4jybcA7x75DuDf4C2+CzpFL6biWdcnPsG3dCKw
	1zDOd0u+Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kbhF6-0004GR-VI; Sun, 08 Nov 2020 09:44:13 +0000
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kbhF3-0004G1-WE
 for linux-nvme@lists.infradead.org; Sun, 08 Nov 2020 09:44:10 +0000
Received: by mail-ej1-x643.google.com with SMTP id oq3so8004175ejb.7
 for <linux-nvme@lists.infradead.org>; Sun, 08 Nov 2020 01:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:subject:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=NqzS9U+QS3IP0V0izaLcyeyzRCwvQwZCD+ve+WO/lPo=;
 b=fuANvQfljCYaTnot/4xUrVG3z1cKdJ5KKWyE66/A4/63QkW653/Quws5G5JPUky1hE
 lN65vGWKrTuK11lOjwH7oXXuMaE78NWG/McS6tWv6FTfknZMJAmkawx32Q+1wI1xcDRZ
 gDuzVQXfL1P8PDhcbGV1eDDwrPoxm7Ytfb6LA9rQh4oIeLjYz5oXP9MNEQubjqKFE9L/
 jHi61tHXLvHIpggoK270tqyKgHN0xV6mo+mOwR+PWdL+UKZS1x6KS3IlN3YuCByn4sux
 zV4JZn1G419TSrqfKEUL2trPl1hY4etz2xCr4QF2i69AgETIx0d9kmgLeoLr/8fu8w2I
 C9gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:subject:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=NqzS9U+QS3IP0V0izaLcyeyzRCwvQwZCD+ve+WO/lPo=;
 b=fmBAYaJuDzTUTY9aWARiAmxCLq1EmNiYnk39ju3JtS971CPiJQSJcJnMrUP4pY8/Zy
 McJ2oGYSHc+3MPxsrN1gKZZ9V4reG36KpZ8zMkLT8i9ZBB6ZUs0qO8E9/eCaogPNCHxU
 l6tTD3nP2faSKeq4wp7VJc4lgtem5hfpgJlmjg674KIT+MbW6U+3wgryasdq0xc756zu
 NWGKSbvKzqcPp/hWygLtQP9stHGdSxBdtlkCRkpd/3WTXVnGrGZLxVgIVNItSXi3ox0G
 NMHTeobZ4AUHV8738U2+Mz3sLYPtUEfVdsM+NMbNX+DfQDN7E6ET9j+bnZidCxxeY16x
 Rh/Q==
X-Gm-Message-State: AOAM530HOOfiz8FahYUjHHLxDHt1lo+MOYBPn2AhGuyVejpF3skhL7nN
 shMjBoG78GdzwVXM8g9LVpU=
X-Google-Smtp-Source: ABdhPJyibw5wtNj0Zwr9hH+v06TvP7u+Tyg8yIDZOsxh8GHanFBVO0mxdO4JhSfZNzfLXCMYMpfFZA==
X-Received: by 2002:a17:906:4104:: with SMTP id
 j4mr10399207ejk.439.1604828648586; 
 Sun, 08 Nov 2020 01:44:08 -0800 (PST)
Received: from [192.168.1.11] ([213.57.108.142])
 by smtp.gmail.com with ESMTPSA id us11sm5617067ejb.91.2020.11.08.01.44.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Nov 2020 01:44:07 -0800 (PST)
From: Boris Pismenny <borispismenny@gmail.com>
Subject: Re: [PATCH net-next RFC v1 06/10] nvme-tcp: Add DDP data-path
To: Sagi Grimberg <sagi@grimberg.me>, Boris Pismenny <borisp@mellanox.com>,
 kuba@kernel.org, davem@davemloft.net, saeedm@nvidia.com, hch@lst.de,
 axboe@fb.com, kbusch@kernel.org, viro@zeniv.linux.org.uk, edumazet@google.com
References: <20200930162010.21610-1-borisp@mellanox.com>
 <20200930162010.21610-7-borisp@mellanox.com>
 <5a23d221-fd3e-5802-ce68-7edec55068bb@grimberg.me>
Message-ID: <12692704-126a-4242-f0a9-f00db6071e40@gmail.com>
Date: Sun, 8 Nov 2020 11:44:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <5a23d221-fd3e-5802-ce68-7edec55068bb@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201108_044410_197396_A163DD00 
X-CRM114-Status: GOOD (  11.73  )
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
Cc: Yoray Zack <yorayz@mellanox.com>, Ben Ben-Ishay <benishay@mellanox.com>,
 boris.pismenny@gmail.com, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, Or Gerlitz <ogerlitz@mellanox.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 09/10/2020 1:29, Sagi Grimberg wrote:
>
>>   static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
>> @@ -1115,6 +1222,7 @@ static int nvme_tcp_try_send_cmd_pdu(struct nvme_tcp_request *req)
>>   	bool inline_data = nvme_tcp_has_inline_data(req);
>>   	u8 hdgst = nvme_tcp_hdgst_len(queue);
>>   	int len = sizeof(*pdu) + hdgst - req->offset;
>> +	struct request *rq = blk_mq_rq_from_pdu(req);
>>   	int flags = MSG_DONTWAIT;
>>   	int ret;
>>   
>> @@ -1123,6 +1231,10 @@ static int nvme_tcp_try_send_cmd_pdu(struct nvme_tcp_request *req)
>>   	else
>>   		flags |= MSG_EOR;
>>   
>> +	if (test_bit(NVME_TCP_Q_OFFLOADS, &queue->flags) &&
>> +	    blk_rq_nr_phys_segments(rq) && rq_data_dir(rq) == READ)
>> +		nvme_tcp_setup_ddp(queue, pdu->cmd.common.command_id, rq);
> I'd assume that this is something we want to setup in
> nvme_tcp_setup_cmd_pdu. Why do it here?
Our goal in placing it here is to keep both setup and teardown in the same thread.
This enables drivers to avoid locking for per-queue operations.



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
