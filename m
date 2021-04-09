Return-Path: <SRS0=kA4j=JG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA1CC433B4
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Apr 2021 18:05:04 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A2C56115C
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Apr 2021 18:05:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A2C56115C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=dBIFK2VYOXhdit4wZ+QmPNKRbZUnG/888Zjfg6c+XCc=; b=NFOucH4BrQsxiMQ5MT26erDlh
	JObe/JF/gTxHNfGbo+E3hsFBAiI+1sUaWWmUQbAuknDJfmWQXeK9Kz1LGczHDxFjvAL2GmKkZnjuE
	kgOzh0thLsg8MBJg4BrmCnSyBYP66Wib9HOpXH90/eTaBcQPr0rpbohedTGrEcSfS0BMGN6B4eRV/
	YHeXM9+hmRAYnsAlwEn7nLk4S/Zc3IPp4faiBqACbBuItAoM4TfkGBOVBeYIvMcR9MwmA4XyCpIpg
	Wf1cwAvKY0x5g4eqnR45UOisF7kOLGgZGL+1T05/kFU63z1bSTpBftCEZZNHMtiBL0WZX0cssE0zK
	v2pSq7CWQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUvUz-001GXN-N1; Fri, 09 Apr 2021 18:04:53 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUvUv-001GWi-R3
 for linux-nvme@desiato.infradead.org; Fri, 09 Apr 2021 18:04:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=q7AXkSlN8BW9ksXpUrDp+oOu0qDGjvaeNrBUSNg5ioc=; b=zp5xQ4uzNX3/BLQBMy8VL/JYg8
 YJ+PZ+gYJ4CWMT9jN0/Iet0XmXe/gBwr6apZqjeDNW2SnjG4Aw8fK+0YtO8daLBx+TclZPNVqbtsc
 paz/PRWBdtwL7ouOFr7hHbsqlpOEMWy74TGC0ilJa5mOvXU8ZUCHpsMqgKsjg2tLGW/E9NAc88YKU
 Itcgd7ITZ3Ol2q2e+033dL2g75Q/zbIAby5sIy4QtBD/eBtxqADc3v38+oFAtmQE+SvKtzkQkAs2f
 xozHVAzAxgDMHHJGdcaX2BEbHyyIAoyOAc+iwXDISJnTrxNbh5dkXWD9fynJQCICFb0QrMeWd6A5g
 nYnTRCZQ==;
Received: from mail-pg1-f178.google.com ([209.85.215.178])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUvUs-004iBI-Vc
 for linux-nvme@lists.infradead.org; Fri, 09 Apr 2021 18:04:48 +0000
Received: by mail-pg1-f178.google.com with SMTP id t140so4488211pgb.13
 for <linux-nvme@lists.infradead.org>; Fri, 09 Apr 2021 11:04:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=q7AXkSlN8BW9ksXpUrDp+oOu0qDGjvaeNrBUSNg5ioc=;
 b=FP8TEcFFjsjfi0QG2uvXx8cIdHl8ZnJIOT7mRMMG+nYNDN+VEHjExjzeKnctBARksX
 yXJ7SdnQcMgJTCwnJniojNWWG3ZuYlZMdb1JGecvZQTHYszF8pHeiYleulOqAU5vqPur
 JaTM03QI/roIYuR0HzF/Vi5UHdZHLqVL8RW0KlLedW8WU754TjZjeIIi7Ie0yBFuZc28
 g9diwYuMxVk4CKkLMdtoEJAzS8STIeGQjNaXkI3riiaGElUJ8UFYE3P6QdU33HJSVM82
 qt/EljilPUzIHFybw0NvD3RS8PrcavFLe8phjz4z0kOIcyBeoEelvRxCM8HlJHlu/Mlf
 DPzA==
X-Gm-Message-State: AOAM530JX1nkgygSBrS/bKQuKNXoAmhzj7sSXwABNs41e4cejwqnwBIi
 5HMZcsCpy14BH0WVyAefzvI=
X-Google-Smtp-Source: ABdhPJwESo9rWUOsJbteDr41MNvDUW6zFgoLf4IBuh6uVHDzlw4fWfLB1+uzuMaV4ySpQdBhHL05lQ==
X-Received: by 2002:aa7:9561:0:b029:246:9133:f9ef with SMTP id
 x1-20020aa795610000b02902469133f9efmr4680242pfq.54.1617991485587; 
 Fri, 09 Apr 2021 11:04:45 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:95dd:20b7:6d40:bdc3?
 ([2601:647:4802:9070:95dd:20b7:6d40:bdc3])
 by smtp.gmail.com with ESMTPSA id y17sm3010394pfl.10.2021.04.09.11.04.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Apr 2021 11:04:45 -0700 (PDT)
Subject: Re: nvme tcp receive errors
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de
References: <20210331161825.GC23886@redsun51.ssa.fujisawa.hgst.com>
 <0976ff40-751e-cb95-429a-04ffa229ebf0@grimberg.me>
 <20210331204958.GD23886@redsun51.ssa.fujisawa.hgst.com>
 <20210402171141.GA1944994@dhcp-10-100-145-180.wdc.com>
 <53a11feb-bc49-d384-3b7b-481a0dfc70e6@grimberg.me>
 <20210405143702.GA20598@redsun51.ssa.fujisawa.hgst.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <300c9e90-9bd6-abc8-c67a-fa92e119e4a7@grimberg.me>
Date: Fri, 9 Apr 2021 11:04:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210405143702.GA20598@redsun51.ssa.fujisawa.hgst.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210409_110447_048931_59B7F39B 
X-CRM114-Status: GOOD (  20.67  )
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


>>>> Thanks for the reply.
>>>>
>>>> This was observed on the recent 5.12-rc4, so it has all the latest tcp
>>>> fixes. I'll check with reverting 0dc9edaf80ea and see if that makes a
>>>> difference. It is currently reproducible, though it can take over an
>>>> hour right now.
>>>
>>> After reverting 0dc9edaf80ea, we are observing a kernel panic (below).
>>
>> Ah, that's probably because WRITE_ZEROS are not set with RQF_SPECIAL..
>> This patch is actually needed.
>>
>>
>>> We'll try adding it back, plust adding your debug patch.
>>
>> Yes, that would give us more info about what is the state the
>> request is in when getting these errors
> 
> We have recreated with your debug patch:
> 
>    nvme nvme4: queue 6 no space in request 0x1 no space cmd_state 3
> 
> State 3 corresponds to the "NVME_TCP_CMD_DATA_DONE".
> 
> The summary from the test that I received:
> 
>    We have an Ethernet trace for this failure. I filtered the trace for the
>    connection that maps to "queue 6 of nvme4" and tracked the state of the IO
>    command with Command ID 0x1 ("Tag 0x1"). The sequence for this command per
>    the Ethernet trace is:
> 
>     1. The target receives this Command in an Ethernet frame that has  9 Command
>        capsules and a partial H2CDATA PDU. The Command with ID 0x1 is a Read
>        operation for 16K IO size
>     2. The target sends 11 frames of C2HDATA PDU's each with 1416 bytes and one
>        C2HDATA PDU with 832 bytes to complete the 16K transfer. LAS flag is set
>        in the last PDU.

Are the c2hdata pdus have data_length of 1416? and the last has 
data_length = 832?

1416 * 11 + 832 = 16408 > 16384

Can you share for each of the c2hdata PDUs what is:
- hlen
- plen
- data_length
- data_offset

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
