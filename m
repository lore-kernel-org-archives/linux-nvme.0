Return-Path: <SRS0=YADc=KM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3988AC433ED
	for <linux-nvme@archiver.kernel.org>; Mon, 17 May 2021 19:10:15 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 753E26109E
	for <linux-nvme@archiver.kernel.org>; Mon, 17 May 2021 19:10:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 753E26109E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=JrOkFj/4XDSBwWp71c7B77o1TvYAjhRbFLQ1jZDaNfw=; b=JNGV5J6cfPGZb2RjaAN/RvPAe
	RS8lJG7WI7qBlRL9LwC56BKbtYp//CMgqqzZjTYxn1s62vMlAR//TWaE8DJSoBUsM+YKktI6F0vvf
	4t7QL/Ohf/j/VmoGflxbJHJEgpn08XptSNNcO/tYlbjQiNHdfcs0LU8DmWebLk5kD2d4PxHqtn/fu
	mCtjeRBAjITOjvFY+Pu2IFdxCpIDGobbObJFEhtRUsEQQA0FxeaMmsf9m+CTH1bsHOioUYhmFqoNE
	4KRL7/1pVy3yYxZDnpmt3T3lFuEAaRnvNzch0JE8dk/w5UbG/HMYYUahaBSaEAOIgcH0cKtOcEYYi
	l8HgzS+Rw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1liicn-00FvOX-P8; Mon, 17 May 2021 19:09:57 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1liicl-00FvOP-84
 for linux-nvme@desiato.infradead.org; Mon, 17 May 2021 19:09:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=9UByNeW0WjJ1umuVqy70BbhgUES3G0W0gyg+zpdvtLQ=; b=m0yRj4eV5NCZGET+zviyolaCBZ
 jXfaYwy2CFYFclkzW6/nONesjApVylE4seHZjlTnNWe6U4SQpM9Vek1jEjGw5cjEypxqcHivMqLXN
 XWDwUCQjWdcs9BiS+ibutz8QijSbaVyIUU8y0U0S1OVA+9zg/i/DQoWx6WJS5nFKOrDNXz03TtCaN
 r7LTWHvv0C0NkE2CSyMHYSs4rzCvunBBOgpgPNFtkv2HyhVFI3rbpFPVT/h1A6nnyrImgv/61Cciv
 ashqveRV5EHep5ihnnioLLoms8wWkS2Swu9g2qG2r0tpu1T7rKfsQZe+2PjBr0qclJtEoSbqwhQN2
 ogUaRCXg==;
Received: from mail-pg1-f181.google.com ([209.85.215.181])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1liici-00E58h-Eg
 for linux-nvme@lists.infradead.org; Mon, 17 May 2021 19:09:53 +0000
Received: by mail-pg1-f181.google.com with SMTP id m190so5321250pga.2
 for <linux-nvme@lists.infradead.org>; Mon, 17 May 2021 12:09:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9UByNeW0WjJ1umuVqy70BbhgUES3G0W0gyg+zpdvtLQ=;
 b=YiitEtHXgvTEewXwBZS4CzgcLOrzyvezTJ2ZY5vWEfgwgVgHZ8k9c6cVb33GIfxCLH
 RmfZpBvhZ9N/XrAdL/9OMQjQd78MS/NEYN/OrtYAl95ASHCioWlYccKauNykZR+6D4pi
 p4eOlVHb1ZMX+8pW9ogUEPkogX3R9QriF4FvFOy59TCkmDaqN4D4ukVFG4Pm7Xwf7XR4
 cBGF7+aewzFnFFj6cuasHzWBkbfWLM5WJUkft1cBUQ8AfnOAjwY6jiovPnQQxvrb9bmj
 qOdxQbyRdc5T+sgdtqIG4AHkHAQQCvJ6IcyjCDdzoYzXfMsux89ovMo5YfGsypzQupaP
 Guog==
X-Gm-Message-State: AOAM530HY/jNpiUXuKci6pyVB8D0Wsq3hHyUwMCxZ2LVwzypEE5ekpoF
 KseKokvu9sqI89SgSRv078k=
X-Google-Smtp-Source: ABdhPJwFpOzIRiXoHrSiHxFukKdU+wrGpfS3qKzdrFkv0kBpU6ASf7O186x1fOoKUp1lQGV9iZ9vTw==
X-Received: by 2002:a05:6a00:1a12:b029:291:ced4:c38b with SMTP id
 g18-20020a056a001a12b0290291ced4c38bmr903766pfv.79.1621278590175; 
 Mon, 17 May 2021 12:09:50 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:8224:c0d6:d9dd:57b3?
 ([2601:647:4000:d7:8224:c0d6:d9dd:57b3])
 by smtp.gmail.com with ESMTPSA id h3sm8080411pfh.114.2021.05.17.12.09.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 May 2021 12:09:49 -0700 (PDT)
Subject: Re: [PATCH 3/3] nvme: code command_id with a genctr for
 use-after-free validation
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: Daniel Wagner <dwagner@suse.de>
References: <20210517175955.602725-1-sagi@grimberg.me>
 <20210517175955.602725-4-sagi@grimberg.me>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <0bd3f659-9691-4f25-6d3b-bdd19546186c@acm.org>
Date: Mon, 17 May 2021 12:09:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210517175955.602725-4-sagi@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210517_120952_528623_658167C5 
X-CRM114-Status: GOOD (  17.03  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 5/17/21 10:59 AM, Sagi Grimberg wrote:
> We cannot detect a (perhaps buggy) controller that is sending us
> a completion for a request that was already completed (for example
> sending a completion twice), this phenomenon was seen in the wild
> a few times.
> 
> So to protect against this, we use the upper 4 msbits of the nvme sqe
> command_id to use as a 4-bit generation counter and verify it matches
> the existing request generation that is incrementing on every execution.
> 
> The 16-bit command_id structure now is constructed by:
> | xxxx | xxxxxxxxxxxx |
>   gen    request tag
> 
> This means that we are giving up some possible queue depth as 12 bits
> allow for a maximum queue depth of 4095 instead of 65536, however we
> never create such long queues anyways so no real harm done.

Is a four bit generation counter sufficient? Shouldn't such a counter be
at least 32 bits to provide a reasonable protection against e.g.
duplicate packets generated by retry mechanisms in networking stacks?

Additionally, I do not agree with the statement "we never create such
long queues anyways". I have already done this myself.

Thanks,

Bart.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
