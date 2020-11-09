Return-Path: <SRS0=mxs5=EP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4598CC4741F
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2020 13:50:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBC342068D
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2020 13:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fr85j10N";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gtjQ3TKu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBC342068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=tBTP8MWpDstJd55DPnpOY/61LDnk+rBpGYAm+C6DTJw=; b=fr85j10NA7mIMJNBJMfiAz+8X
	onzY8JxklhgXKtniU5olg52QFWQqjCo6x1DNIH+Z+dtLXrVLc9iHwIH4qyJ2jqC8IoRtHeithdptx
	IQCelEEUMxJeLpCpgk8vb8ZtmnJBPfMe05DnyodyhrPh8sRCJ3iEfhLnSXrpyHrCYOtBXl+hFrJQA
	fVfKuw50+W+4IDSHEXfO6WudsaHkqqSwGmoNH6YeIuRylNUhi2Q3WG755M0XcTnO82YeWHCXeSxG/
	dcU51RVGepvFg6Mo08zvf/wqb+QskloR7VHtsNzTz1yCIPpyk00q5KjNgIES9ii4Z/3QWMdcSyOFU
	gyVpitVsg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kc7YY-0006fc-7S; Mon, 09 Nov 2020 13:50:02 +0000
Received: from mail-qv1-xf33.google.com ([2607:f8b0:4864:20::f33])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kc7YU-0006ct-DO
 for linux-nvme@lists.infradead.org; Mon, 09 Nov 2020 13:49:59 +0000
Received: by mail-qv1-xf33.google.com with SMTP id x13so2667270qvk.8
 for <linux-nvme@lists.infradead.org>; Mon, 09 Nov 2020 05:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=b/ROwKmSowuZ8b24Yd7aJ9Hn3G189OMSwVtmsQPyJKQ=;
 b=gtjQ3TKuIrzqO/1qDfFQ1QWwBn2pMpPvBvQgltCE5fjgQfbcBruG2wsk9sqvXKhjJo
 uaC9yquLvHSt97neC6MhCArQWuo5IQy7WDIQvDCTosF+Z2SlNcPUSfdQUuudeJzRm5vn
 e9WnYGvt7PVFtSSn4uYXxY8usl5qgCxpFPhS9PuL2W7OB140iZodbBEIz7PNEamjP8/5
 ChweBAf+LHvLA2KQdnrLnXL9MAZwOQvDlwm8TSQqxNWpDs/E7ZvcnHMAcLhORghL36TP
 9kTA/pU/VVVxpL0lOLMKZu2R6pVVEds6F5HS0oX/GNh2cvIL3R63OB+DKnfLfXuky9e5
 oYGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to;
 bh=b/ROwKmSowuZ8b24Yd7aJ9Hn3G189OMSwVtmsQPyJKQ=;
 b=lZG9VqTypC/Y1luGwb8sxS3fuETiMbjWYYG6Mw0xL2SaVbj0bzj9CPDChShOuvQOLj
 k/GGVWQH62U66pZAG3giViHQaj/KQV/PWadDBKBFvxGfonIS77LE71zoVTEp5Q8mnZn+
 Px2f+sniLmxvfqHgIWZcxELZP6uL9P+H+V8NgTthltEHvqRn6rE+mfzUOUkLAdLl77RN
 k5DWdO0CaDKNsZQjAucyjDXhFjKv9OR1IkYEPFgwWYJ4oIRPjDwn9RjbSGUzZlqsT6T3
 3yAHF8iIriXn237G+0Auo0F8N3jz0ggzgzSKW6VsBwFw+o5TaDFrfARggWv4oNaEDQRH
 q1Iw==
X-Gm-Message-State: AOAM531f2ZahF823cY/LkgxlVJicOxjEtWNSydiH5M5wxSgoertAyR5p
 X//3cyVuA58T5xsez9dSv5w=
X-Google-Smtp-Source: ABdhPJx2CDufxqBncB2CpkALJ5LrGPgbiyWH1thHAs8sP+x3QLK+gBeMSy7lVhZ+zrWZJDaFEblQKw==
X-Received: by 2002:a05:6214:2e1:: with SMTP id
 h1mr5530026qvu.60.1604929794985; 
 Mon, 09 Nov 2020 05:49:54 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:fc2b])
 by smtp.gmail.com with ESMTPSA id l3sm4191873qkj.114.2020.11.09.05.49.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2020 05:49:46 -0800 (PST)
Date: Mon, 9 Nov 2020 08:49:33 -0500
From: Tejun Heo <tj@kernel.org>
To: Muneendra <muneendra.kumar@broadcom.com>
Subject: Re: [PATCH v3 01/19] cgroup: Added cgroup_get_from_kernfs_id
Message-ID: <20201109134933.GC7496@mtj.duckdns.org>
References: <1604387903-20006-1-git-send-email-muneendra.kumar@broadcom.com>
 <1604387903-20006-2-git-send-email-muneendra.kumar@broadcom.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1604387903-20006-2-git-send-email-muneendra.kumar@broadcom.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201109_084958_524727_10FF15BF 
X-CRM114-Status: GOOD (  13.74  )
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
Cc: jsmart2021@gmail.com, mkumar@redhat.com, linux-scsi@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, emilne@redhat.com,
 pbonzini@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hello,

Generally looks good to me. A few nits.

On Tue, Nov 03, 2020 at 12:48:05PM +0530, Muneendra wrote:
> Added a new function cgroup_get_from_kernfs_id  to retrieve the cgroup
> associated with cgroup id.
> It takes cgroupid as an argument and returns cgrp and on failure
> it returns NULL.
> Exported the same as this can be used by blk-cgorup.c

Can you please reflow the above paragraph?

> +struct cgroup *cgroup_get_from_kernfs_id(u64 id);

Let's just name it cgroup_get_from_id(). There's no other id. We can rename
cgroup_path_from_kernfs_id() later.

> +/*

/** starts a function comment.

> + * cgroup_get_from_kernfs_id : get the cgroup associated with cgroup id
> + * @id: cgroup id
> + * On success it returns the cgrp on failure it returns NULL
> + */

With the above nits updated, please feel free to add

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
