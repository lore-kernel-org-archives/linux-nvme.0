Return-Path: <SRS0=D3NM=F2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28268C433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Dec 2020 17:10:06 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0D1923103
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Dec 2020 17:10:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0D1923103
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=FVPc7vM9UEEMwQi5CYLpogrGphYKBWw3mu5C8G2cks8=; b=zpyrPs0929/SAMWCBCgMHwckm
	q42CKhP7cSuPLKEAyYtyASJJN7wtdWTsJdiu2duGTnzVoYciUXGYUQX1cE3TiQ6MdOojRbaAI9mBw
	HSpqwWnMewYp/7ouz/LhF6sTup500V/XrStLOf8wRp6qcZcqTzr47EumHUTyMTUCXp7XuuY59xoCT
	Xm5SSaaOV0Obr3FfTsVFbe/fzHiFOmEz6L57ZZAPSynxOBFEqgM9PRwqxiiHQr1WkFyZNpTLnLuVv
	dI5TEiWlsQUs39JgQX2s4iR9J+YRx6exmp4chPrdYV1ovaLooANkYjIq2qFhDbzqxJCrQNRWNbYtm
	xFeUtCAVw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1krlAg-00061O-Cq; Tue, 22 Dec 2020 17:10:02 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1krlAf-00060j-0A
 for linux-nvme@merlin.infradead.org; Tue, 22 Dec 2020 17:10:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=ik8+7drT2hf8fGhGbNu/E/uz+NLQQnAX3uaoN3mqMCM=; b=CG15D5+zJNT5EHh3IEnfMvfnwg
 wzhOHxO4uczqFycunh9BLLQ3yhcJln2rOKai0Vs11gZIyJH3YZ76t3pwZFhVhNHyFCDvkCdcdcoHi
 WStvQO7rbKgFPkxItDXL5jN96yu8oKxDA7y+yKgGCu18l1V5wY/hyh9trpToCzTrOSlD3PK+VdBAN
 LcDLQFZMWVGAvzOnPEGm9V1If5QtAYZRnSm26gG3YBtkxu7BnFn60XkjTbRwy3qe/Lb6JIWCauEek
 sfJEAP9QLxNwHJPFzfZtpTH2tND7QtLyaekekmyq4+7AUYtzDQohhWzgXrpm1OHcurD/rdKuN+15F
 3hR6/KSA==;
Received: from [2601:1c0:6280:3f0::64ea]
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1krlAd-0008BG-Cv; Tue, 22 Dec 2020 17:10:00 +0000
Subject: Re: [PATCH v6 00/16] blkcg:Support to track FC storage blk io traffic
To: Muneendra <muneendra.kumar@broadcom.com>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, tj@kernel.org, linux-nvme@lists.infradead.org,
 hare@suse.de
References: <1608595918-21954-1-git-send-email-muneendra.kumar@broadcom.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <2780d561-c1cd-c82d-57e3-7b79db1071aa@infradead.org>
Date: Tue, 22 Dec 2020 09:09:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1608595918-21954-1-git-send-email-muneendra.kumar@broadcom.com>
Content-Language: en-US
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
Cc: pbonzini@redhat.com, jsmart2021@gmail.com, mkumar@redhat.com,
 emilne@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 12/21/20 4:11 PM, Muneendra wrote:
> This Patch added a unique application identifier i.e
> app_id  knob to  blkcg which allows identification of traffic
> sources at an individual cgroup based Applications
> (ex:virtual machine (VM))level in both host and
> fabric infrastructure.
> 

Hi,
Can you get rid of that legalese footer message?


thanks.
-- 
~Randy


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
