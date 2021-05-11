Return-Path: <SRS0=LCWA=KG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6D5C433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 11 May 2021 17:17:39 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 790F0611F0
	for <linux-nvme@archiver.kernel.org>; Tue, 11 May 2021 17:17:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 790F0611F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=dCBJpd/8U+FI3at+ybZQ432Lko9WzGMNwg34QLzD+NE=; b=JmZ6jvWqSuafVaaqTAcu1ew87
	5s/R0h2opmvBBMBGGzwkfLFg7GprGhrsn8RB28NfNClORFKKCq4AvVo+16Jcg9y1rIvx3W8hC4JXm
	jiV/o0mHpe9IRZhG1/rbo+Yf+bJ7MMIdz3tj8+Ffn40XbOmJhGLn0QxGTmzCralKIO9YD6HUMLiMC
	KJIPYkSUSqfZf5beK8lO/30j0JeijhglLQERruiQTzNOnJ9wadMjBYi8U6cyLkhTjJ+aCC4QPMy4L
	SMnNFPj5CVgHbmvhVhRf9A4DhWTCgJdxfftn50ZsVS5JxUJTNnhOSrqo9BIv59jO5YJVf697US+2N
	CdENqcG7Q==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgW0U-000tcu-K7; Tue, 11 May 2021 17:17:20 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgW0S-000tca-TC
 for linux-nvme@desiato.infradead.org; Tue, 11 May 2021 17:17:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=YUOkXBOaeMDKYGgIyZ6PcKAG1bRbcYeBv4E0Ese9c6w=; b=PXkw/M+mlwf+wzpoUWv5S+lxFx
 IkD2/OOHz9YwuLcnSMibsK2AjAHv2gpD+eBIRobaLTQ6h2DpyzumF7Do/OtvuEfLBSOzRZeS38DKw
 6BhfXu+jJscHWAwMc2xi8oHXFGimPriaI4lW28ypXRYZw+PEA2wrpHw3rqcWiyrG7ECX7iKGGX3MV
 8Awoh8s+05Xbotol5lrX5js0BlA54mN3r7lTiq4pgbiAwlDwnNubpM0GTWuqbenPVLjgLWvXFedpM
 /5d7vZO1Om0we2qbPEZ8PV9lwNbu0s0rB26tHhSC9jmfMzb8RKIAyy8P+D6me04ev5fktzmGjhtlb
 JjvVT5aw==;
Received: from mail-pf1-f182.google.com ([209.85.210.182])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgW0Q-009nx4-A6
 for linux-nvme@lists.infradead.org; Tue, 11 May 2021 17:17:15 +0000
Received: by mail-pf1-f182.google.com with SMTP id h16so3796411pfk.0
 for <linux-nvme@lists.infradead.org>; Tue, 11 May 2021 10:17:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YUOkXBOaeMDKYGgIyZ6PcKAG1bRbcYeBv4E0Ese9c6w=;
 b=r1gQL6dIRTxe3KNBilQcDmgJnpaElNiKsAzL1CClVz4N5BC0+0b1DaFPqVGcti6tHp
 9XOLQ5/89OzAe3DtTulQO/zmrIHn5+ryx+wS3+RvM/WhpEV+Oaihy84XrkBCPV9ydLAy
 OSB1tRT1WbLHGJWsKKm8kY+VGhJekIW/sNrfbM2cLlqOwA/LkFLy4TCRyJxkxkeKLFE1
 qJWuJQIdMu6V9t7xKZvb09sVGf9817IBBwQhoehiowHZjxfUEpr9doOM6qr6UuBpFC3L
 Q5Tq+cIukk2sNKNGv5ruj3b7pEahYzEraKfhT8SfpP44lOpkxsaV9pJPcaWLFuyuLmll
 jrRA==
X-Gm-Message-State: AOAM532saeXUrigP3e8D6anAAiRAMr0G0N75ze8h137/9DH1x0RuEaI2
 Jep2Hgom/tVxo7+S7deHziq6pR63f6A=
X-Google-Smtp-Source: ABdhPJymsh6YsjbHpWpWJ65/mXBXiJJMdpBHhIXMRhTf9Ui1ttoLIV2sUVvJJdj/5G9OtRXfNJzBSg==
X-Received: by 2002:a62:65c7:0:b029:278:e19f:f838 with SMTP id
 z190-20020a6265c70000b0290278e19ff838mr31588653pfb.64.1620753431453; 
 Tue, 11 May 2021 10:17:11 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:1522:1d2e:7c9d:185c?
 ([2601:647:4802:9070:1522:1d2e:7c9d:185c])
 by smtp.gmail.com with ESMTPSA id lb7sm2568066pjb.29.2021.05.11.10.17.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 May 2021 10:17:10 -0700 (PDT)
Subject: Re: nvme tcp receive errors
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de
References: <bd69eafa-9f1d-4cdf-f1b5-8b71ffd78917@grimberg.me>
 <20210503194404.GA910455@dhcp-10-100-145-180.wdc.com>
 <ba05ff5a-b6bd-b6e4-a96b-fb9ee4e01f66@grimberg.me>
 <20210504143633.GC910455@dhcp-10-100-145-180.wdc.com>
 <76a715f5-6a37-8535-3fbe-1aa0f3a54dbc@grimberg.me>
 <20210504191441.GA911866@dhcp-10-100-145-180.wdc.com>
 <20210510180633.GB1857448@dhcp-10-100-145-180.wdc.com>
 <6838b8da-7e05-a08d-b67f-1fe28b0d880b@grimberg.me>
 <20210510183040.GC1857448@dhcp-10-100-145-180.wdc.com>
 <9a6fed85-2f8b-8398-1e8b-cd44e6004f40@grimberg.me>
 <20210511030051.GD1857448@dhcp-10-100-145-180.wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <88879279-fff5-b26c-2c1c-52a700a1c40a@grimberg.me>
Date: Tue, 11 May 2021 10:17:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210511030051.GD1857448@dhcp-10-100-145-180.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210511_101714_380447_33A225BE 
X-CRM114-Status: GOOD (  23.37  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> I may have a theory to this issue. I think that the problem is in
>> cases where we send commands with data to the controller and then in
>> nvme_tcp_send_data between the last successful kernel_sendpage
>> and before nvme_tcp_advance_req, the controller sends back a successful
>> completion.
>>
>> If that is the case, then the completion path could be triggered,
>> the tag would be reused, triggering a new .queue_rq, setting again
>> the req.iter with the new bio params (all is not taken by the
>> send_mutex) and then the send context would call nvme_tcp_advance_req
>> progressing the req.iter with the former sent bytes... And given that
>> the req.iter is used for reads/writes, it is possible that it can
>> explain both issues.
>>
>> While this is not easy to trigger, there is nothing I think that
>> can prevent that. The driver used to have a single context that
>> would do both send and recv so this could not have happened, but
>> now that we added the .queue_rq send context, I guess this can
>> indeed confuse the driver.
> 
> Awesome, this is exactly the type of sequence I've been trying to
> capture, but couldn't quite get there. Now that you've described it,
> that flow can certainly explain the observations, including the
> corrupted debug trace event I was trying to add.
> 
> The sequence looks unlikely to happen, which agrees with the difficulty
> in reproducing it. I am betting right now that you got it, but a little
> surprised no one else is reporting a similar problem yet.

We had at least one report from Potnuri that I think may have been
triggered by this, this ended up fixed (or rather worked-around
with 5c11f7d9f843).

> Your option "1" looks like the best one, IMO. I've requested dropping
> all debug and test patches and using just this one on the current nvme
> baseline for the next test cycle.

Cool, waiting to hear back...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
