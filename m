Return-Path: <SRS0=AvHe=JX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD93C433B4
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Apr 2021 01:51:34 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB0A3610A5
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Apr 2021 01:51:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB0A3610A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=L8tgHNLANG23MEytDvsxYAKDXUDVfPl7VY+IE2scHLw=; b=U+c/Xf4r2nfxHomPVZOlW5gDT
	dlvN7JclUyDn77I/PDmVrLzyRCW3GWgAfjQHRz7Mg1DQs8oikQuD3UxDTc4ebxtPJHvlJ+KHFrxfJ
	xvUF0jq7ZUrz7zs3Mm7k9dcEQdlSq9znp8Cx9N2sOqn6sJot6K45DyTOH0GCO4kqF+hFHLWEg0M9Y
	u15qLGQ0y4VxEJEeplMeiIjJOlqn9y7AQrwMk2uc32FR1WanhOJS+vDEFYfB/9H4jUok0h9CoQnER
	BHeaHlPzjGmRR17ZJTNItZxCu/gzu2GT+ZRiBNszxgASkfG70aSiW9a/YQ+DeLWwdhXJuaFPLZpBu
	AZTUWU07A==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1laqOn-006evG-KE; Mon, 26 Apr 2021 01:50:57 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1laqOk-006evB-C9
 for linux-nvme@desiato.infradead.org; Mon, 26 Apr 2021 01:50:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=zPUtfVnEEWwuygIs9roDA8n1hisriGb9DgakGssm9V4=; b=E7Wr+1P8AUdX6SHwRKI2ahk58M
 RFHETGQQYPEeERG4DdbQ7Z6h6KuH6snGhJ4eWC7UUEs3yVSU56LCgjlxWqWMry2n/0siJwSLT/V6/
 RWP1NSpxOwsTXjkpVoP2JN+MYvA4eHyPHLwNSdPcVsW6yzRYRGx6TnCTqrgk8qtLfaT07csF2scUm
 BNNkFeH9kXIN5TnJZJrtUPh2MxSiVjPQ0TaoxnH8Csgu/KQA3uuHPxpSB2lWG1D2mpmf/LcbXa66U
 cfpoo6h5BrZD/kxoEBR2j5Sw/XgC+1jw6J7mfKyqML+0HNDGUvsKg2mg2cKvGXxBpxMwI1JGEfute
 W9aPUeig==;
Received: from mail-pg1-f171.google.com ([209.85.215.171])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1laqOh-00FgbX-Pe
 for linux-nvme@lists.infradead.org; Mon, 26 Apr 2021 01:50:53 +0000
Received: by mail-pg1-f171.google.com with SMTP id w20so167169pge.13
 for <linux-nvme@lists.infradead.org>; Sun, 25 Apr 2021 18:50:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zPUtfVnEEWwuygIs9roDA8n1hisriGb9DgakGssm9V4=;
 b=NcI3kojzxUnTUOY1iTWUAlU0nsNykmhS9wcPLzQIUTMz6UPWa8D8EBtJaK8T/cu3hN
 MolZBolATg6vC/6Al3jWxynzir+4txysOEQ8GrzUzjoCmxMbfj2VQ9XTU4mz7YIXOFtL
 gRigK1g568K6qsb2ZmE0jM8f6sO/NOcwTlPbci5y25OGab018f3z+QqCeofVskNC5ZV5
 VrxcIps3rNmwt6bLNHkKEnTIddEuz0XOMtPKnyis/hOADGD0f/E8qzYfUtFbBRe+la3T
 l3MKPej2HoiDUAfUwrly5LFkELoHC0UA5SUreKEsIE1LWWIhIWOX6q2FrQqDsrUbCMly
 3gPw==
X-Gm-Message-State: AOAM531ET5N3+7j/exapM1dyDbxOCw1WainUN3sVsM11uRF6BsLtPmkY
 3uCqKaA86C4BpaAXdg7p3b4Zu34h+Yj4gw==
X-Google-Smtp-Source: ABdhPJzwMUBdl76J3O+0TGJaDFvHGuRvkjdgNBKS/8OpFzxfDhzu6bUmqq9rsaKdhTXZZEebZzeFTg==
X-Received: by 2002:aa7:9299:0:b029:21d:7ad1:2320 with SMTP id
 j25-20020aa792990000b029021d7ad12320mr15243625pfa.22.1619401850638; 
 Sun, 25 Apr 2021 18:50:50 -0700 (PDT)
Received: from [192.168.3.219] (c-73-241-217-19.hsd1.ca.comcast.net.
 [73.241.217.19])
 by smtp.gmail.com with ESMTPSA id 22sm13214507pjl.31.2021.04.25.18.50.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Apr 2021 18:50:49 -0700 (PDT)
Subject: Re: [PATCH 8/8] blk-mq: clear stale request in tags->rq[] before
 freeing one request pool
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Christoph Hellwig <hch@lst.de>, Khazhy Kumykov <khazhy@google.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Hannes Reinecke <hare@suse.de>, John Garry <john.garry@huawei.com>,
 David Jeffery <djeffery@redhat.com>
References: <20210425085753.2617424-1-ming.lei@redhat.com>
 <20210425085753.2617424-9-ming.lei@redhat.com>
 <d3493eef-ff45-23a8-f12a-b7246ba9f3a2@acm.org> <YIYOLHaidxc5fBH2@T590>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <69764ff2-f339-0dc0-aac0-a1f9f4b30d53@acm.org>
Date: Sun, 25 Apr 2021 18:50:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <YIYOLHaidxc5fBH2@T590>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210425_185051_860915_8B3F83B4 
X-CRM114-Status: GOOD (  16.15  )
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

On 4/25/21 5:49 PM, Ming Lei wrote:
> On Sun, Apr 25, 2021 at 01:42:59PM -0700, Bart Van Assche wrote:
>> Using cmpxchg() on set->tags[] is only safe if all other set->tags[]
>> accesses are changed into WRITE_ONCE() or READ_ONCE().
> 
> Why?
> 
> Semantic of cmpxchg() is to modify value pointed by the address if its
> old value is same with passed 'rq'. That is exactly what we need.
> 
> writting 'void *' is always atomic. if someone has touched
> '->rqs[tag]', cmpxchg() won't modify the value.

WRITE_ONCE() supports data types that have the same size as char, short,
int, long and long long. That includes void *. If writes to these data
types would always be atomic then we wouldn't need the WRITE_ONCE()
macro. The explanation at the top of the rwonce.h header file is as
follows: "Prevent the compiler from merging or refetching reads or
writes. [ ... ] Ensuring that the compiler does not fold, spindle, or
otherwise mutilate accesses that either do not require ordering or that
interact with an explicit memory barrier or atomic instruction that
provides the required ordering."

Bart.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
