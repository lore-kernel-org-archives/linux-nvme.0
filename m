Return-Path: <SRS0=LBLG=7C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F33CC433E1
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2020 17:52:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 488A02072C
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2020 17:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="u6+6aZ7h";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IGPX9L4k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 488A02072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=fY+/L0rxgTS4tVTpI+w6LoMn7IxJZdNMxTYblDBTD7M=; b=u6+6aZ7hYDJFFNCuQJcynlDPx
	YeaVcSXhwK0zfJuez6Za7xsxbeEMDOU8rNJA5qE2zqlBCjlCFWCiOJqnpKSKNoKAGC/pC3QhCsjIg
	YggqoUXOmiIZL+ynHMhl8DixB6Q3IdUXcse3AryvtD+NdVlsraOFpqu/Imh26skKz2r5ii7MsnbYU
	veFei4QABljmRIvqWyVPm+8z/kCuIzlSJC9J0o1RhLWXwz26hg4X2imNOU7aQe1B56rlIRTwDsbwC
	hX7E7JEsNIJ0hZLjVQatlWJxlDZ9aJqrY6XUxRS5wIU82hetRpUqIADasvliPKKLMdI2L/YaBN+D8
	d32is6Oog==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jbSso-0006l5-GJ; Wed, 20 May 2020 17:51:58 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jbSsl-0006kC-94
 for linux-nvme@lists.infradead.org; Wed, 20 May 2020 17:51:56 +0000
Received: by mail-wm1-x344.google.com with SMTP id m185so3810733wme.3
 for <linux-nvme@lists.infradead.org>; Wed, 20 May 2020 10:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=6/K2r2mMGNXC0hjZP/edQuVZv9WqLKDECwgj0t5H2CI=;
 b=IGPX9L4k9Ivw+STA53YDbcHe/jWijBpChsxcqfoVM4H3g1XLSmcioRjHcCKLrrVXn/
 IvwXg4tS7GDt1kk9mgVwwD9zNxTRVsi4QdEtLK9WkvVz3kiTGOpAkUs+thETBXohhIbT
 jW+Ce0eAKMXAgHEZGKFtO3eooAOAnY3uy70m0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=6/K2r2mMGNXC0hjZP/edQuVZv9WqLKDECwgj0t5H2CI=;
 b=md7dgP6JsbdivMrAq7z/F1ZhNtRoirLkTcXmmOAjTe2UTQxqhzqTEHaCSkHlfKA4lF
 OXYA7A0d/y5A6XCR6QrhUAb55+CcJ0EDT4Am3/h+VRWwURewKBH2w8UOKz7YFtHU0fc0
 SFapph5/iBb2BuzPLEeW5ifv51wZ0WgvkQA4cQ7msKue5KflbbWBnHMYWxolgrrJcOoF
 kK05SmBwvTT2gtsNM6af03U5b7pOZZv+UJKwe6SQyMKAU9qDhvfaEyr4tkagwF9+hJFA
 OK69X7E9I4W2lcq5m37cGsnKP+AIxowg40rhPgLk5Wal9YLrxlAtj575GLIx0ki7WeUW
 7LXA==
X-Gm-Message-State: AOAM533yKX/AjKWkKptwaCAVW12UlLq202hKn4jnGMosyZ/1fXAbO0Bd
 KLIt+ysZDEVzN+KzRzxqQNroJg==
X-Google-Smtp-Source: ABdhPJwUu6hTVJnqQMkiiZojWCHHXZqLpYI4Ef1FWPqKJaOiKZnv/kYPTv56XL9GKNQQAczOtcdHlg==
X-Received: by 2002:a05:600c:2109:: with SMTP id
 u9mr5386234wml.75.1589997113302; 
 Wed, 20 May 2020 10:51:53 -0700 (PDT)
Received: from [192.168.1.237] (ip68-5-85-189.oc.oc.cox.net. [68.5.85.189])
 by smtp.gmail.com with ESMTPSA id q9sm3646293wmb.34.2020.05.20.10.51.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2020 10:51:52 -0700 (PDT)
Subject: Re: [PATCH resend] scsi: lpfc: Fix a use after free in
 lpfc_nvme_unsol_ls_handler()
To: Christoph Hellwig <hch@infradead.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
References: <yq1y2purqt1.fsf@oracle.com> <20200515101903.GJ3041@kadam>
 <20200520165557.GA9700@infradead.org> <20200520172433.GD30374@kadam>
 <20200520172844.GA21006@infradead.org> <yq1y2pmtsv7.fsf@ca-mkp.ca.oracle.com>
 <20200520173752.GA13546@infradead.org> <yq1sgfutsjd.fsf@ca-mkp.ca.oracle.com>
 <20200520174800.GA13253@infradead.org>
From: James Smart <james.smart@broadcom.com>
Message-ID: <4693662b-60de-388e-d67f-722eabbba475@broadcom.com>
Date: Wed, 20 May 2020 10:51:48 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200520174800.GA13253@infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200520_105155_316912_03288ACA 
X-CRM114-Status: UNSURE (   9.94  )
X-CRM114-Notice: Please train this message.
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
Cc: Jens Axboe <axboe@kernel.dk>, Dick Kennedy <dick.kennedy@broadcom.com>,
 linux-scsi@vger.kernel.org, "James E.J. Bottomley" <jejb@linux.ibm.com>,
 kernel-janitors@vger.kernel.org, linux-nvme@lists.infradead.org,
 Paul Ely <paul.ely@broadcom.com>, Hannes Reinecke <hare@suse.de>,
 Dan Carpenter <dan.carpenter@oracle.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 5/20/2020 10:48 AM, Christoph Hellwig wrote:
> On Wed, May 20, 2020 at 01:39:55PM -0400, Martin K. Petersen wrote:
>> Christoph,
>>
>>> I'll pick it up.  Can you give me an ACK for it to show Jens you are
>>> ok with that?
>> Acked-by: Martin K. Petersen <martin.petersen@oracle.com>
> Thanks,
>
> applied to nvme-5.8.

Guess you didn't see Dan's response - we had replied, and Dick rejected 
it. Dick has created a new patch that I'll be posting shortly.

-- james



_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
