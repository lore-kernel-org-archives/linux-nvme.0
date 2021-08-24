Return-Path: <SRS0=S+bv=NP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D60C4338F
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Aug 2021 20:39:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F619611C8
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Aug 2021 20:39:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8F619611C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B+Hc5aP5iYIzU7NH5UIeKkZV6ne7X8QAt4FhhsvabjE=; b=Ex+31FsJbW5RtCcQklRsxp0782
	9ILmTo9LB+js3LXXboRsN72kdyxJgadBWHZCHCIcxgLlC7nCgBNau6wb5LskJ/rJA4Pn9Hvm1YaMy
	k6KvnIHBilTmQCoFzx7ylMDxjDxgWG0+XXb3OOzQWjWDqjpFo4JaOvIDBdCW4NJPmEXBWUG5Kvn6Z
	i9R6b5SDO0y76Yhe9SCJa4KJjnH/oBMqb2BMTSloIfv1NaHIqwsX6eRSTpuahOzpno3H40r7E+9ga
	ID57bZ/GeUbwpp9Pux3BovMKodrZzDCjtfL1avpCCvZuee22o6n2URpAR6j9uovwqC1FPixWi9Vgd
	bOStkbXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mIdBk-004f4E-VB; Tue, 24 Aug 2021 20:38:28 +0000
Received: from mail-ed1-f47.google.com ([209.85.208.47])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mIdBi-004f3l-S7
 for linux-nvme@lists.infradead.org; Tue, 24 Aug 2021 20:38:28 +0000
Received: by mail-ed1-f47.google.com with SMTP id q3so33622026edt.5
 for <linux-nvme@lists.infradead.org>; Tue, 24 Aug 2021 13:38:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3bj4G4Fv3K7qkrLB/46eXuh+KiEbZ4cq/4erNT5rDd0=;
 b=L/cONljQkaN7NntBZLWIA+n3v5+c07Q/E1C6FS/lI8sKNW5C7RPExhrxjEJRItxpsK
 sJBR86JoPHup2oNTCbk3cJXnHIfZ7jX2JboASXdSK4fRLcCim9t5RnOl1ZZIP9BrZ2iP
 jbms9hH8UYZ7X6oiNyQthoXvR3MmVDOnN4tyvbPuC66wiuPOAeYlkkaysYme3H1EPfip
 G4RPA+yDoK5kokSahXP7ddvDIWEKpUgHAhEI80Av1IQ0bqwYDgGJmiLiX0MtVSUbQQ+p
 MKGd1oD63iwYUJLwu0TzRZix+PnqCnTiPEZdlf+QotuFSmU5WDCtRcSJtJkQqoQn5qz/
 2SIA==
X-Gm-Message-State: AOAM533U/dE6XaF1sZSC4oyFQlea/BleZcGFnuWwI0cGZTgzy9lHJHEh
 znanuQ6GqwMQjBa3M5L6ARo=
X-Google-Smtp-Source: ABdhPJxeb6t+lJh7qnda3Z3KUzyz3sKfhEGA7TLQyQcnmVirqWp28zytteoDi8lIxNyn3a8+wM3VIw==
X-Received: by 2002:aa7:d842:: with SMTP id f2mr12940811eds.57.1629837504309; 
 Tue, 24 Aug 2021 13:38:24 -0700 (PDT)
Received: from [10.100.102.14] (109-186-228-184.bb.netvision.net.il.
 [109.186.228.184])
 by smtp.gmail.com with ESMTPSA id be5sm1018543edb.57.2021.08.24.13.38.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Aug 2021 13:38:23 -0700 (PDT)
Subject: Re: [PATCH v6 3/3] nvme-fc: Remove freeze/unfreeze around
 update_nr_hw_queues
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>,
 Hannes Reinecke <hare@suse.de>, Wen Xiong <wenxiong@us.ibm.com>,
 Himanshu Madhani <himanshu.madhani@oracle.com>,
 James Smart <jsmart2021@gmail.com>
References: <20210823112351.82899-1-dwagner@suse.de>
 <20210823112351.82899-4-dwagner@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <025942a6-4f57-b005-eb77-e9eed143522c@grimberg.me>
Date: Tue, 24 Aug 2021 13:38:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210823112351.82899-4-dwagner@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210824_133826_964546_AECA9EA8 
X-CRM114-Status: GOOD (  15.03  )
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


> From: James Smart <jsmart2021@gmail.com>
> 
> Remove the freeze/unfreeze around changes to the number of hardware
> queues. Study and retest has indicated there are no ios that can be
> active at this point so there is nothing to freeze.
> 
> This patch primarily reverts 883837ed0f1f

Bogus commit ID.

  "nvme-fc: wait for queues to
> freeze before calling update_hr_hw_queues". It's not an exact revert as
> it leaves the adjusting of hw queues only if the count changes.

I see that fc doesn't freeze the queues, so it obviously wrong to
unfreeze them. But is it correct to not freeze the queues?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
