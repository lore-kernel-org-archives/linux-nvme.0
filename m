Return-Path: <SRS0=yFSL=I5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F96C433C1
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 07:49:27 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6018619B1
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 07:49:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6018619B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=JrnzLfPK5n+DikNmtdjTPUtT+1gHLQNm/iQk/M0ByJo=; b=kdRsdzdWWzoyWaUqx/TUr0DBX
	CRWs0jylR1VZziDbfeDrRaN2hm0t2nQt11/XxruQw14no5XVIxwXHA3MyrYRTN/SNADXcuE43jSUe
	mCvwn+ep0VIPr3LMIw7foYcRdrADDJwwqzyC9w7rqZCpO6juY/ZZc0Ky9Dvv37+zIoI9fnBHMikNt
	jVz28dk+EGoPOEaPpePBPxqlEd+rO6Hpg86gciLwE7vt4w72BMcYkH2XB4pq9+q1CUgft7DrLueoj
	eCQmIf+UiYHWIqrDKhSQDwRKkbqIkaMSlNDbYd31ir1S4aCETOR9nK/GRQYoaFE8LB4OkIvfr9czN
	tEQpGRcew==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRVbG-005qnu-Qa; Wed, 31 Mar 2021 07:49:14 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRVbA-005qmn-1U
 for linux-nvme@lists.infradead.org; Wed, 31 Mar 2021 07:49:09 +0000
Received: by mail-pl1-x631.google.com with SMTP id o2so7471810plg.1
 for <linux-nvme@lists.infradead.org>; Wed, 31 Mar 2021 00:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DFVbMZmJOmjue96FULS1cKk383WtQ51DljDr7h5egKQ=;
 b=e/JpGJvEZu2ksIQXjzZmbRZHJlDNTiop/tYpa7LudTsGhTFyD5iPtV4vpPVFgBBUeC
 jJgxPNSP5EhWf1d4qR3Lrx9ljz0kJy9lXwuvaBmVgZucLbot3mnj1P6F6VR8IH0A1rTm
 +bGQi+JThmIRieYl27wCn1M75YyY9I1vyVGIpswRtwvo/wLKIU7M7uGM9LohOA6j5l+i
 mk1sqoEiQGBuWFZ+VuHDVu7rFjtpik498aIYTlyh9aSkqv1Tvlb8msKRX/zLaIf2Akw4
 ouwDHOYCSkCFIXYtsv8jmAFBMWeqCKUQ+IY3Ov8Lr0XZ0CVmLBoQwNqh0gh4DkJVyBtz
 dntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DFVbMZmJOmjue96FULS1cKk383WtQ51DljDr7h5egKQ=;
 b=DRSJQ7mpBDhGA+wuc8MVdo67hfBRU1g0KGwfedA6+jZwfyuWKuecOBsmfxjn95izq5
 yyGt8oW2zwKHOZf97QAwwoIkE55zfO5zDuuqDUU3o9ciY1B3uxswx763ZCV21LvijP5A
 6/l5YyC5CcpkpGvoyMO280ztmJZe4JMOsL5fZkogshwQY+MvmWod5eH7FusvhKFXBHec
 LdOKZGfYvbPshz3vvWNadg1ab8CB3A+bIpG9TWsRvhE29MEveJDfA6Y2166usxCRtVtg
 dLRUnvoz+AXc00n4MN5Qs14zN9x8lZryxfwk2oauZB4spmAR16lkhPgqQXUPWmV903tO
 BESQ==
X-Gm-Message-State: AOAM530oGFrTyMRJgJ3THsdiSjvXz9/zfbwudUMJMY5k2CRouoCGW5es
 zS4uj037hqHndNwXQZtO4z8=
X-Google-Smtp-Source: ABdhPJyjHFTXke28im/x55h8/47EXiqashnWjxe1IzbJH2jX2miAyqRyGrmkc+M9quH4o+JkDshXUg==
X-Received: by 2002:a17:90b:1b42:: with SMTP id
 nv2mr2255308pjb.190.1617176946654; 
 Wed, 31 Mar 2021 00:49:06 -0700 (PDT)
Received: from houpudeMacBook-Pro.local.net ([61.120.150.74])
 by smtp.gmail.com with ESMTPSA id l6sm1551996pgf.35.2021.03.31.00.49.04
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 31 Mar 2021 00:49:06 -0700 (PDT)
From: Hou Pu <houpu.main@gmail.com>
To: elad.grupi@dell.com
Cc: linux-nvme@lists.infradead.org,
	sagi@grimberg.me
Subject: Re: [PATCH v4] nvmet-tcp: fix a segmentation fault during io parsing
 error
Date: Wed, 31 Mar 2021 15:48:56 +0800
Message-Id: <20210331074856.46966-1-houpu.main@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20210330172407.22936-1-elad.grupi@dell.com>
References: <20210330172407.22936-1-elad.grupi@dell.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210331_084908_161904_C391DFFC 
X-CRM114-Status: GOOD (  10.21  )
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

On Tue, 30 Mar 2021 20:24:07 +0300, Elad wrote:
> @@ -960,7 +981,7 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tcp_queue *queue)
>  			le32_to_cpu(req->cmd->common.dptr.sgl.length));
> 
>  		nvmet_tcp_handle_req_failure(queue, queue->cmd, req);
> -		return -EAGAIN;
> +		return 0;
>  	}
> 
>  	ret = nvmet_tcp_map_data(queue->cmd);

Hi Elad
By returning 0, the response is queued twice before it is get off from the
list. Even still returning -EAGAIN, the cmd still could be queued twice
potentially.

I think we'd better not queue the failed cmd in first place.
Please see my following fix later.

Thanks,
Hou

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
