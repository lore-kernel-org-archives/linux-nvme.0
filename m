Return-Path: <SRS0=Ni0e=M5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5353BC4338F
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Aug 2021 19:35:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7EF061167
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Aug 2021 19:35:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E7EF061167
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0CpPjX9+nL3lL9MOAfMUUKflsfcYgt8eXT3jp05wKmI=; b=Qlhoj0WEY0P5rRHbHZSm5x1ck3
	oSqh417IetX0vvqxQ9x9816irWxbjti8MX+ebLbJ2ReWPDgtTaF2IPKmutn+8UIQL8a+Mpsz8tzbx
	lNMUaZUJT0EhUGcd3/qOfMhMMK0HVMtx/0ichGFplvO8n6Wndo8BTefqPtNhFA3PvsNR6x3OupYfJ
	EOU43sz+psnmvdLCO3PQwY9XPYoCZ4sZ9IHDi7/RUVxpxGx4yN5U8XEj3pdP0Oo+Nff0M6r5I7sEZ
	AmoKv3CFbJtbwlSIneRS8wmkYz6cZpSjkIzple1vFyLpBuBgTdsirL1M+mF0vYRyyE14r92YdqVhO
	fg3Y8uAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mC5cV-00DJXG-Du; Fri, 06 Aug 2021 19:35:03 +0000
Received: from mail-pj1-f45.google.com ([209.85.216.45])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mC5cS-00DJWN-R2
 for linux-nvme@lists.infradead.org; Fri, 06 Aug 2021 19:35:02 +0000
Received: by mail-pj1-f45.google.com with SMTP id
 u5-20020a17090ae005b029017842fe8f82so10195304pjy.0
 for <linux-nvme@lists.infradead.org>; Fri, 06 Aug 2021 12:35:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UdX02+HUoeoCmh78jH0fVH3iLosk3ngHK2f2ScfhPNk=;
 b=S648ISJdVrs9z1F99SxaODkSIjbG3+rBCrtLN+1y/QU6ecbjE7vSIkkNPLzidZYNGD
 PkLLk2VtMzXz9WB3I3vvDIDa+x4Q9eySJj+TwI/g5j4Nsqoppcv+bYSCdPlHnB9sq8ae
 SMWCX5fkg4oh0UQCSlR/aBKcqie763GDDPrzoDGktm/JAGTbLmHuevKhGJwNe2r65p+T
 +FQ+XnSGUqM8j/rsHLrvVgR6Ne2flDRFe2oBqHtnignbq5a3oucW679fAgI/+k08yQJU
 Vn669F+MQdwrwGi2nRSAQ9hHezABtl8AN7j3TNjMQWdBioGbgrrUYAYA1hlQlTMSJcs7
 /KZQ==
X-Gm-Message-State: AOAM532kz7mWU5Tx0+ifH1DL9gBLdDEJRcQSud0ogLiiaZKXtZlTJWBy
 UDoUz2EB2r2z0ShNbooIwV0=
X-Google-Smtp-Source: ABdhPJw/3VbQ5OZPA9CdfxSoeBcGN2wdkR82ihajm+j8SqqRhBg/4yZM8301Evkj3MpIB3cEYP7wog==
X-Received: by 2002:a17:90a:bd98:: with SMTP id
 z24mr22499524pjr.99.1628278500193; 
 Fri, 06 Aug 2021 12:35:00 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4a77:cdda:c1bf:a6b7?
 ([2601:647:4802:9070:4a77:cdda:c1bf:a6b7])
 by smtp.gmail.com with ESMTPSA id p2sm11756673pfn.141.2021.08.06.12.34.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Aug 2021 12:34:59 -0700 (PDT)
Subject: Re: [PATCH] nvmet: pass back cntlid on successful completion
To: amit.engel@dell.com, linux-nvme@lists.infradead.org, kbusch@kernel.org
References: <20210805153310.30986-1-amit.engel@dell.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f5615019-6e81-ee85-6bc8-deb12c7f6fb2@grimberg.me>
Date: Fri, 6 Aug 2021 12:34:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210805153310.30986-1-amit.engel@dell.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210806_123500_935179_DEB3D875 
X-CRM114-Status: GOOD (  12.36  )
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


>   	status = nvmet_install_queue(ctrl, req);
> -	if (status) {
> -		/* pass back cntlid that had the issue of installing queue */
> -		req->cqe->result.u16 = cpu_to_le16(ctrl->cntlid);
> +

No need for this newline

> +	if (status)
>   		goto out_ctrl_put;
> -	}
> +
> +	/* pass back cntlid for successful completion */
> +	req->cqe->result.u16 = cpu_to_le16(ctrl->cntlid);
>   
>   	pr_debug("adding queue %d to ctrl %d.\n", qid, ctrl->cntlid);
>   
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
