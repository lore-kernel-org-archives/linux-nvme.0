Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFB05CCD18D
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Oct 2025 15:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Om98z2/a9k2gBCvueZ9BtfA6oYv79LdMeQNMbGk8Se0=; b=IGVCHS8diU/VWPiD/5i65zxcuZ
	fMNKQjo3GcN0qsCYnKYSvhuAGB1Okuyc7cMp9+6Ur0gmZ8uTbQ+nX7kNBzBxGkrkx3f13cCjkZZkx
	53P5mqW3asTKIvzA/ZeUi2Gdf1baQ+PjSDgYc5x384u45nI0hVm2VQ7QFxKUIzSi9KnMC+mGK6mWU
	j2dgzaeRRdWhdgZx1jf9HWx/ScFqRUgiQLWO5hhPx+jZs8rPqw+z9icP9ZSiReOO6pxkXrAvp5j6j
	j7JQ1b1eOSqq/UjpABIui1VCiwacj72LQ2hh9EuItJCh6PXIUbWJhI7BkRF2X5ez4i3pvPZollqJ3
	hO8rq6Dg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8Kmk-0000000Dklb-1nF1;
	Mon, 13 Oct 2025 15:48:30 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8Kmi-0000000DklD-36ES
	for linux-nvme@bombadil.infradead.org;
	Mon, 13 Oct 2025 15:48:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=Om98z2/a9k2gBCvueZ9BtfA6oYv79LdMeQNMbGk8Se0=; b=VCAUnvHhSzTZGj0zbl9Als3V17
	UzbhWnMbF1ts3ST+fzNf0FvgC7Ce/kvVYPhtGN1KUeY2sMEHoyYAkPDbn60FUflqyzAkfgBgRqHN0
	+kx3cqI7K9Q/C55AZG6/ZwScbaXriY44a/Z+ZkoTMH4JzqKS1/+GxHyENy3n+S52RhJJd0czTa3mm
	IPTTgu47PFJq/LO+xO+2BulhrGGxLmj05JtCA7BKexl7o0F3upp7OaSBwYt7lvqDsv3HCwVyW/CDI
	30O3UBPMOj+t1u9kB2b7T7r3YsXl9jCH9XrGhTqZaKOmqKXMDqhMsVyyWHIIVs2tjNIaPRfQOljKg
	SkMIc8ew==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8Kmd-00000004R3r-0INw
	for linux-nvme@lists.infradead.org;
	Mon, 13 Oct 2025 15:48:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760370487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Om98z2/a9k2gBCvueZ9BtfA6oYv79LdMeQNMbGk8Se0=;
	b=HIsw4dOXJciOHgtit4RQWSjMBv8H5C3Y0c+GhUEWJPkhd+HFQALJSMCZzeDyAS/EWZs480
	6EAQuJ3+1nvmIWHyWWSVmLD5sumxGEsAE68OCS8UAn7HPfSmEYsnfUDNoaTjAu6h8nlcv5
	iEI3Yl5qf9yyOjyM2kExDLPsAuL9spk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760370487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Om98z2/a9k2gBCvueZ9BtfA6oYv79LdMeQNMbGk8Se0=;
	b=HIsw4dOXJciOHgtit4RQWSjMBv8H5C3Y0c+GhUEWJPkhd+HFQALJSMCZzeDyAS/EWZs480
	6EAQuJ3+1nvmIWHyWWSVmLD5sumxGEsAE68OCS8UAn7HPfSmEYsnfUDNoaTjAu6h8nlcv5
	iEI3Yl5qf9yyOjyM2kExDLPsAuL9spk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-JqZbU1deO3iG-WxMMRPHdg-1; Mon, 13 Oct 2025 11:46:39 -0400
X-MC-Unique: JqZbU1deO3iG-WxMMRPHdg-1
X-Mimecast-MFC-AGG-ID: JqZbU1deO3iG-WxMMRPHdg_1760370398
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b448c864d45so403042066b.2
        for <linux-nvme@lists.infradead.org>; Mon, 13 Oct 2025 08:46:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760370398; x=1760975198;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Om98z2/a9k2gBCvueZ9BtfA6oYv79LdMeQNMbGk8Se0=;
        b=J3NbphQ7w8CLY5VjlnmpafL4Ud7F+vaCRqJeYWJzTT+q/NAsueHWOTioI0xOMbeWkG
         XkCc3cEAvJeICUQ3N7kWPmkt+eW8E9CMKXFv02pkV5Z3uiCxaVGCPKY5seVcelFDqPaB
         kobDQO1B9Etyd9l02nxlzfcETpsPz/XQCTR0jpjILisVMZvQ4Lj2fcC8I46A1rwkYymA
         0BwOCJB5iBJ/XJe1Lylhx/6ZZO8eeHDxsGvcrBRIt705ab87vtY/M0SvjXs78clv7jac
         g2FGyP+jzCbhzZFUOX3miwOmpYe5ZqyCtEfk0+0BmBqXUYrDYLdfu9eAGvaEWU2Rc9av
         jz9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVJ3FbFM42KWi6eKpDPHjIpGjkevnynXDusquyQWONWY6s1kx1mwEtT4mH/VxfzfTgbmkOdDz8arOqI@lists.infradead.org
X-Gm-Message-State: AOJu0YzvyoGRBCJgs/7//aZMPqxAEG/PpmAEQTLP4s8U99vVjeGQn7dR
	5qqx9E/JpQDws4RcmMeZGqg6QPOsxsT5PS/lOLuNsiMeZx1pCMIp8Efu95D7Ih5WAyJ4Ym3xhrF
	AHf0lAdnkeowHQ1QwyRASsnrdkw4qUGUI1OgTGfXW7sHM5wErvfrSNSKQBCHCqHGUN8/9R96htm
	0k
X-Gm-Gg: ASbGnctJaalnXrhOMe2mP8mrCnP09WQCgmB7qyTBquGTs66fMdaie/KzZBdOrvj/xEH
	rpuVP/BvYHWKtc7scXzy0UYZR2vqi5XLW28aWUxaWxBOz1wOEvZUXS1yBhcGJoZpNasf7yBCDdM
	PBxt9qu+xZaVAWxPD5GUNxNwVkHl4/v+D6PcsYPLZPMu6dAmRekrTG19mdHrHba3CiDWrhVjmwi
	qFeA0A7AbNYgQVyn6Bgl8amy+JYC9VUXx/g5jF28mzmkrIGDxVQi1XdAdjNLhpFuTY1oXvWlVy+
	0xVORYhF5ZLenwNr36d6xwYiwQk73tbB9MU660iU02rlcYlvUGZcKFdwTVOXZaXH7GCy6A==
X-Received: by 2002:a17:906:abc4:b0:b46:1db9:cb76 with SMTP id a640c23a62f3a-b50aba9f7aemr1805712566b.39.1760370397648;
        Mon, 13 Oct 2025 08:46:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJXRqxBHzlvqKzRSAC/z3gZc9DzUgGq/JGNM5q4zhfkzDByfELavsY6LOPqjKVLYnUPgxgnQ==
X-Received: by 2002:a17:906:abc4:b0:b46:1db9:cb76 with SMTP id a640c23a62f3a-b50aba9f7aemr1805710166b.39.1760370397218;
        Mon, 13 Oct 2025 08:46:37 -0700 (PDT)
Received: from [192.168.0.110] (78-80-81-65.customers.tmcz.cz. [78.80.81.65])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d5cacbeesm917302766b.15.2025.10.13.08.46.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 08:46:36 -0700 (PDT)
Message-ID: <b694da0d-5e7b-4591-bd46-c8ba02f2153e@redhat.com>
Date: Mon, 13 Oct 2025 17:46:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet-tcp: remove a redundant line in
 nvmet_tcp_release_queue_work
To: Maurizio Lombardi <mlombard@bsdbackstore.eu>,
 linux-nvme@lists.infradead.org, sagi@grimberg.me
Cc: kbusch@kernel.org
References: <20251006175910.62721-1-thenzl@redhat.com>
 <DDBVK80QRT7V.2R17ZR0TPDAHO@bsdbackstore.eu>
 <DDBVZC2RLIZB.96BBZ55VO06P@bsdbackstore.eu>
From: Tomas Henzl <thenzl@redhat.com>
In-Reply-To: <DDBVZC2RLIZB.96BBZ55VO06P@bsdbackstore.eu>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gEzB_1G_ybegPmrWoDWRSX6f0_gaENbmetsaDD2qtrk_1760370398
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251013_164823_834834_56C49819 
X-CRM114-Status: GOOD (  13.82  )
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

On 10/7/25 8:46 AM, Maurizio Lombardi wrote:
> On Tue Oct 7, 2025 at 8:26 AM CEST, Maurizio Lombardi wrote:
>> On Mon Oct 6, 2025 at 7:59 PM CEST, Tomas Henzl wrote:
>>> cancel_work_sync(&queue->io_work) is called twice, remove the
>>> second instance.
>>>
>>> Signed-off-by: Tomas Henzl <thenzl@redhat.com>
>>> ---
>>>  drivers/nvme/target/tcp.c | 1 -
>>>  1 file changed, 1 deletion(-)
>>>
>>> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
>>> index 470bf37e5a63..a1d0f6b18b2c 100644
>>> --- a/drivers/nvme/target/tcp.c
>>> +++ b/drivers/nvme/target/tcp.c
>>> @@ -1577,7 +1577,6 @@ static void nvmet_tcp_release_queue_work(struct work_struct *w)
>>>  	nvmet_tcp_uninit_data_in_cmds(queue);
>>>  	nvmet_sq_destroy(&queue->nvme_sq);
>>>  	nvmet_cq_put(&queue->nvme_cq);
>>> -	cancel_work_sync(&queue->io_work);
>>>  	nvmet_tcp_free_cmd_data_in_buffers(queue);
>>>  	/* ->sock will be released by fput() */
>>>  	fput(queue->sock->file);
>>
>> I am not sure it's safe to remove it because io_work can potentially
>> re-enqueue itself.
>>
> 
> Small correction, the problem isn't io_work re-enqueing itself
> (the first cancel_work_sync() prevents that); I think the real problem
> is that nvmet_sq_destroy() could end up calling
> nvmet_tcp_queue_response() which enqueues io_work again.

The NVMET_TCP_RECV_ERR sate would make the workqueue finish quickly but
sure we don't want a running workqueue.

Let's drop this patch.

tomash

> 
> Maurizio
> 


