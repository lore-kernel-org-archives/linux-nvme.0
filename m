Return-Path: <SRS0=ZbIm=I7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D30C433B4
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Apr 2021 07:36:06 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 255FE61105
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Apr 2021 07:36:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 255FE61105
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=25qqkEzXNLJKkkTvQS9qJGfwEzoQ6hqGfdAG0JYNld4=; b=XbJ/rmpGDNd8o2H18p4cobGg1
	O1VOzldBtw8xlJQZaLywQA9ihswvJuOp5Yzu4XoMrx5IYS3xjuR+YXV+EURuwsYA5jWQwecbuIN/l
	nbReyRqqCw5i3JpoRscyvTSU0ryoQD7q79EttvsAa07aI7KRtSKidXh3ml75am0OfBIDxXPAzoxCN
	OlNjpWc59WU2Ib7Lc980gIHPDOyVoWmb1g/hai7GdD5LRRQcfXUqTcmXFP9kOYaY1t6JzWo6wp63Q
	fSzMsZQ5ObxVZlX2AHnGj8i3QmI+0QsRI3wzssNecTZXiCA7BSRy9/EBwzQcuuDtTvdy2jtTCHja3
	hOxBL4D6Q==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lSELS-00CCjR-Mx; Fri, 02 Apr 2021 07:35:54 +0000
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lSELP-00CCi9-CC
 for linux-nvme@lists.infradead.org; Fri, 02 Apr 2021 07:35:53 +0000
Received: by mail-pj1-x1035.google.com with SMTP id
 il9-20020a17090b1649b0290114bcb0d6c2so4278771pjb.0
 for <linux-nvme@lists.infradead.org>; Fri, 02 Apr 2021 00:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9IncaTfgQ/F6Vu69YWJgiR4vBpuB1nKZnnU9lNdRALI=;
 b=ZfvY0q78xcTx5DxScH9L5U0V/8dyIo9Y9KqJY81U/KJOy2y3ACrg5AuB0Y7mF7aFV2
 hpxkWBcpaHguHMHGc7A0hhJ8A4O3T+Ara8WoAgaobBKS0GLzgo+3OOV21x7S57gBlHcP
 ViOne7AuwexSINET3e5jKjzs+1xAIrVtx9ahEkhy8USD6qcN+gjCxO7l+/C5cR69x6Wg
 NJzvkcxjAte0JZhOAHG98Cf+Gn/WCufrlmcMMD7uB4YxzdXnfMbqogPcvwcYGE5prRfj
 U3hWtcHiv4DS4CdO/QZCBMoH1uTKBOpvJNqaRuvLrNA3zleMg0K4YpWtgN0SQowRkOKF
 pTrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9IncaTfgQ/F6Vu69YWJgiR4vBpuB1nKZnnU9lNdRALI=;
 b=Gtl0XI7I6RcUnSnVXiBGSOICPCPVaLGiyXhSWM9MMC/OP2YUFzh96lA3AYl0FeRpIH
 HnCdh+34SYuwFqlHz/tFyV/AgHqV1henvOoS5MlH9aDOBCHemnMXJbQLKxEQIM8qDtdC
 VEV2MzmLqXCntDApREIi+CuAWhcDBj/KHVUe619Ls+bEriPPNsACZSSYQ9iLZfyikEvu
 lWCspdF9YIDfZvnWAotCv3DY1fhF7z8WgK4tgVeCYeOxZehF7+YiVu1HTIE/4sMCmxIS
 Pd7UC+hFtdv1pro+JmNp2kjCtQK8jkAayjiEsKZt0/QxPoTZskpeDkCtf8Gdo3XuBSXu
 I9lQ==
X-Gm-Message-State: AOAM532AiUGQV+hrI5B9eNRjTwnkphemzu5V7rrjPZIXNDsFjYhWCYAD
 pokatunH1abfm0kvLAsTsNc=
X-Google-Smtp-Source: ABdhPJy1mYOy4rn1V9U2jYrG3ZD4M7a8eMswSqWEz5GE6QXdzb71deBUUNOBuSOS1t+wUIFpJYBdVQ==
X-Received: by 2002:a17:902:c204:b029:e7:32fd:bc8f with SMTP id
 4-20020a170902c204b02900e732fdbc8fmr11341748pll.43.1617348943479; 
 Fri, 02 Apr 2021 00:35:43 -0700 (PDT)
Received: from houpudeMacBook-Pro.local.net ([61.120.150.74])
 by smtp.gmail.com with ESMTPSA id t22sm7138697pjo.45.2021.04.02.00.35.40
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 02 Apr 2021 00:35:42 -0700 (PDT)
From: Hou Pu <houpu.main@gmail.com>
To: amit.engel@dell.com
Cc: Ran.Anner@dell.com, linux-nvme@lists.infradead.org, sagi@grimberg.me,
 chaitanya.kulkarni@wdc.com
Subject: Re: nvmet_set_error ignores error_loc NVMET_NO_ERROR_LOC
Date: Fri,  2 Apr 2021 15:35:31 +0800
Message-Id: <20210402073531.23753-1-houpu.main@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <BL0PR1901MB20202EA160DFA04E828A3719EE6B9@BL0PR1901MB2020.namprd19.prod.outlook.com>
References: <BL0PR1901MB20202EA160DFA04E828A3719EE6B9@BL0PR1901MB2020.namprd19.prod.outlook.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210402_083551_547972_41EAB14C 
X-CRM114-Status: GOOD (  13.69  )
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

On Date: Tue, 16 Mar 2021 08:57:08 +0000, Amit wrote:
> Hello,
> A question regarding Get Log Page - Error Information lid 01h:
> According to nvme spec 1.4,  bytes 15:14 refer to 'Parameter Error Location'
> "If the error is not specific to a particular command, then this field shall be set to FFFFh"
>
> In the current implementation, nvmet_req_init initializes req->error_loc to NVMET_NO_ERROR_LOC (((u16)-1))
> Then nvmet_set_error has this condition:

> if (!ctrl || req->error_loc == NVMET_NO_ERROR_LOC)
> 	return;
>
> means that the error log will not contain errors that don't specify error_loc
> is that expected ? 
> don't we expect that param_error_location log page field will be set to FFFFh in case there is no other valid req->error_loc ?

Hi Amit,
I think the specification does not tell us which error should go into the
error log page (or does it?). It is decided by implementation and current
implementation only records errors with an error_loc other than
NVMET_NO_ERROR_LOC.

So the problem here is that:
If some errors which do not set error_loc should go into the error log page,
we need some change here.

Thanks,
Hou

 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
