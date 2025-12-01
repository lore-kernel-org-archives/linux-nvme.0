Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89F4FD116F3
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Dec 2025 17:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=03X4zYdI+GZpzbRSIDVbIkNyeOSXI5DyXdTsQ6LXE8A=; b=F51mhH2x29u2rNwAf0XCVT4sN5
	xls5yQHW2IcAA8UXq7xqWeZfeHp5kFA+f9JayDn7B3ETJEGpl4ksfVPSs0Z5WtwIkcG8PsICAqknA
	DPqGMt3Ibafa8D+dHiYR6pjEOZo8UPqeJxtwaus2Msk0Qci64q9BF1C12SeflduPVIm2l87/sThRU
	jmmf1OKm/TO+LZII3DXgXjILVIgl3ACx+GsYILQapmAAMPjAaSRRvuHbRTD6EcE/Kx6i6zUnMep19
	97OoGjWmgQeUpQLxWBl83Zv3jG+M9fa26fEMnMr/nLsJIuj2Bl8I8AboiofG5msGW9OPd0tk+mb1U
	RxfhsUEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQ81w-00000004Ne7-2uHG;
	Mon, 01 Dec 2025 17:49:44 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQ81u-00000004Ndb-1vN5
	for linux-nvme@lists.infradead.org;
	Mon, 01 Dec 2025 17:49:43 +0000
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47789cd2083so25818015e9.2
        for <linux-nvme@lists.infradead.org>; Mon, 01 Dec 2025 09:49:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764611381; x=1765216181;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=03X4zYdI+GZpzbRSIDVbIkNyeOSXI5DyXdTsQ6LXE8A=;
        b=JNPT4PiPPU2G2IMrnlDjgpXFXQzJO0ro0YUBilc5azP/Srqv9LFjc//L9jPSJ5hJmW
         lNAhS4kw4D9lre0HE2k4p1RAfw6zDix5WFz3TUF2f/nNZOfgxashxMBrS7n3t4GOxW07
         ndcsYfNJVpIXjbrn/t1IjdunBUXlL11r82NueD7xOhq+XD9YgP8AH3yxM+HD/x6RNg32
         0WLX94Dzf3l2uQlniIIs/t4nhBUHKDnIBuku1u4JNq8Q30mtEgchDdH6Vyr1C21Exeg9
         jrpEu/PEFFBOqWJh5umzTTIRChI1Hkq3bjjJcvOp1+ZDQYBaShrMK9GitBS3Ow89l7SP
         urSA==
X-Forwarded-Encrypted: i=1; AJvYcCX53vKG1gO/mLgVgUJqsOh0YzJ7x/Z5i6/iIiYeXlvoufJh5qcCrCS2bIHZD7CBL7xTWu76bKEupKNh@lists.infradead.org
X-Gm-Message-State: AOJu0YzMaGj7Z/Be6CoEo+IzY9Zrl/yrRfw5PbXRwj48xBJ3Rnat1cfj
	S+DLzPWZlW+/b/D0wIj9d3nMTOs8icOI5VmIYAkaS2MaBaRB9PzwtqTx
X-Gm-Gg: ASbGncujWGAN0OIG/rFoHYpdte2kGmkbQSI1HVzTVh6Dau/EcWMTd8S8iORfFsqevyp
	nOj51ltnHfC54aXwTcZ934rbdlH6XA4g9XSCc+eVsqlhW6/itPOhFU95HJCKfNuovFOd8pTzKm+
	vM+WLxbPvieFpaQGK4kRcdjaa5zhI38FgBs2UTeHe71rSe/+YP6qxlYbnUz72DwkE56OVWddjDw
	zyomwXHZGaN44ErEcmOn65VvILeoe7V+0ZeL77eknsil9GQxzp91k9aJCybGXVi/1fX6MZUlKYH
	Rqrev5pB5WOh9vBbtHMeofTcMptH/Itx+D1BnP+9ZqiNHrNwSUokAmNY0JmM96rRv4ehRMQ0Ljd
	nKV0Wi9ZiYe7HO1nYutIPRwWlnYjcfTq4w9pb/dIcDfTNCHRAuNRPUVpUvibT2shkSkZ9lydBOM
	SAk+wxL9XXUcZuYK8wrNmmn+AKZNb6YvlMXxRrzRv6kEoS7/hvdSevdDHC6CGMBSk=
X-Google-Smtp-Source: AGHT+IEexwwg2ZhaVoNgstnMmVnTGPkI7hWsLgkzHewh7zdcYYNhFmSwe9SFdJzskKWKJNfCXk52EQ==
X-Received: by 2002:a05:600c:4ece:b0:477:7af8:c8ad with SMTP id 5b1f17b1804b1-477c115db0cmr422298055e9.31.1764611380467;
        Mon, 01 Dec 2025 09:49:40 -0800 (PST)
Received: from [10.50.4.190] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4790b0e21e8sm334508885e9.15.2025.12.01.09.49.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Dec 2025 09:49:40 -0800 (PST)
Message-ID: <636ee8dc-5c2e-4ace-a746-8ee74933eb6b@grimberg.me>
Date: Mon, 1 Dec 2025 19:49:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] nvme-tcp: Implement recvmsg() receive flow
To: Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20251020085815.20657-1-hare@kernel.org>
 <42d6103c-3cbe-49e9-a8c3-6a6c652a60e7@grimberg.me>
 <809dc274-939a-436d-8293-37c6246ec3bf@suse.de>
 <3e20b46c-d0a8-454b-9c1d-6d010c2e2e42@suse.de>
 <bc44fabe-fcf4-4f63-86cf-0188f63cb2df@grimberg.me>
 <5c7468c0-ecbe-4c9f-bbaf-9c14e45c040f@suse.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <5c7468c0-ecbe-4c9f-bbaf-9c14e45c040f@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251201_094942_509861_D817FACF 
X-CRM114-Status: UNSURE (   9.80  )
X-CRM114-Notice: Please train this message.
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


>> There is TX work that may be pending as well, IIRC there is an 
>> assumption that io_work will NOT return if there is any TX work
> > pending (we've seen stalls in the past due to issues like that).>
> Hmm.
> But I've seen the opposite; the current io_work prioritizes TX
> over RX, so a 'data_ready' callback will trigger TX first, letting
> the RX data to stew for a bit before the TX data has been sent.

I wouldn't consider that prioritizing TX. the fact that it goes first is 
because
you want to send request to the ctrl to go off and work while you 
receive data.

> Maybe we should be looking into splitting TX and RX paths after all...

If both TX/RX remain kthreads I don't see how it will help performance.
But if someone provides data that shows otherwise, we can do that.

