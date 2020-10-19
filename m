Return-Path: <SRS0=Xx51=D2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BDC5C433E7
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2020 15:19:45 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 023A92231B
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2020 15:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lO4FPms5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rWA1jIE7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 023A92231B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=sAQGOZtl/9sw9c+vBzslj4Q1YQ1JVtfKRb5KeE1Rgxs=; b=lO4FPms520bLrd7f00irzyMJf
	OxRiJhA+264W7G2sasTG5jJLRuJViWeJ8HIGKLYwEtqY26Pw4RIOVFR4NfQeoQhrGlzIpK6acZQOG
	QVW+dsS2j+nqLLWjHmpn7QkgNrpCbzjKS4beGocWd0W8S7wqV+Z4Yzzq00Ii3wxub/JI1/tTb9zj4
	pypMlR/c5J4okzUWGJanhqYhQmtHpV3N/CZ9zEzOI7jHHbhPGcTMCgXSIGJuJDywZOzZUOgXBLW0A
	zpvI8q+grru9Zwpvj+UHqOZQH8/B78RnU4RjI6DncVjFCdL7PpO8sedhPb6j09ZQ40P0o+5soCeE3
	zdQUogt9g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kUWwo-0002P6-5k; Mon, 19 Oct 2020 15:19:42 +0000
Received: from mail-io1-xd34.google.com ([2607:f8b0:4864:20::d34])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kUWwm-0002OU-6w
 for linux-nvme@lists.infradead.org; Mon, 19 Oct 2020 15:19:41 +0000
Received: by mail-io1-xd34.google.com with SMTP id q9so12508iow.6
 for <linux-nvme@lists.infradead.org>; Mon, 19 Oct 2020 08:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=epI/NmqDDFPd2x6NTLconypoymsJp/Js2lA8+8iN1vw=;
 b=rWA1jIE72D+TxJOf19M66XpVkM2rqeqbHdlfiiOP04TJy59RyiyNpW7h9ScTDLNUWv
 fSpik8/0e0wQbdZgnUD5n+0qC2iSlq4ENeGGJYDRe0Tgi5zDsY+c/VgkzxRu54BUcPp9
 x4yrTK8Nv+GLROAe1KIGOCSs8EO5S6kDtGDa37KaMz3OkIbtOpue+LGPeVfK8G8iuACC
 Sws9LPx83dpCwqcEeNgzzM3fRplMeL2jGn6LDokPaUj6xlo49a5WCO7lqpagPqWusOSV
 rvaEtdoY5ORR/ckcVuHOUJZsMTved9EYzumuGuDQ2KLxgJn+f1nd5+8/AndzS7xER1a+
 rP5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to;
 bh=epI/NmqDDFPd2x6NTLconypoymsJp/Js2lA8+8iN1vw=;
 b=YnIB13i+nSIZwPYa1W/JbVqe3DcmCkO3R21+18PfpZS6Fqn1QQ0Vm+9OZrCWWVymgY
 Bccp8gAqtGeTNu9o3O1IfVzOr/2BIhQtnW9Jat3O3pJ14F/R89N8SVZZPjvm+ep7Z50W
 de+z2f1yhzz0Nahj9EnkmVQ5zpf6RsM7t2vne28jYICpX8qa5S8d4sANzwm2PRWkHHTX
 dQLpfkLuBubdRWkwvSHsjLZ5+n5exbe63hXMrAVs/GLcJqd/r2ZPETSKqsGrcnZMRWw5
 kpi6YE2qTlU3eXcGGa2Atu+LPM6oIFw+KT3B1ln4U8ZLY1s3W0hzsBnFp0Z3yBq8icy8
 q6Lw==
X-Gm-Message-State: AOAM530ZINNBFXo2WjijsWx2YITWU6zOOmrB7Fgsc+sPJgf16SfPY+T7
 SDhEP4aIDNfkabCZRKUqUOU=
X-Google-Smtp-Source: ABdhPJwBtDJT5N42PRiolkfYjIPnzv33d5gH/hjFA9FBKJzMqw+8pbIY26pYv8OZwfoo8LRUcFYmbw==
X-Received: by 2002:a02:731e:: with SMTP id y30mr374641jab.78.1603120777982;
 Mon, 19 Oct 2020 08:19:37 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:b34d])
 by smtp.gmail.com with ESMTPSA id z200sm32428iof.47.2020.10.19.08.19.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2020 08:19:37 -0700 (PDT)
Date: Mon, 19 Oct 2020 11:19:35 -0400
From: Tejun Heo <tj@kernel.org>
To: Muneendra Kumar M <muneendra.kumar@broadcom.com>
Subject: Re: [RFC v2 02/18] blkcg: Added a app identifier support for blkcg
Message-ID: <20201019151935.GD4418@mtj.thefacebook.com>
References: <1603093393-12875-1-git-send-email-muneendra.kumar@broadcom.com>
 <1603093393-12875-3-git-send-email-muneendra.kumar@broadcom.com>
 <20201019144619.GC4418@mtj.thefacebook.com>
 <ab237522d9110888aaaa538519f3af7d@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ab237522d9110888aaaa538519f3af7d@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201019_111940_699010_47451169 
X-CRM114-Status: GOOD (  14.54  )
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

On Mon, Oct 19, 2020 at 08:43:05PM +0530, Muneendra Kumar M wrote:
> Hi Tejun,
> Thanks for the input.
> >> +     cgrp = cgroup_get_from_kernfs_id(id);
> >> +     if (!cgrp)
> >> +             return -ENOENT;
> >> +
> > >+     css = cgroup_get_e_css(cgrp, &io_cgrp_subsys);
> >> +     if (!css)
> >> +             return -ENOENT;
> >> +
> >> +     blkcg = css_to_blkcg(css);
> >> +     if (!blkcg)
> >> +             return -ENOENT;
> > >+		return -EINVAL;
> > >+	strlcpy(blkcg->app_id, buf, len);
> 
> >Shouldn't the cgrp and css be put before exit?
> [Muneendra]Correct me if iam wrong.
> You mean to add cgroup_put(cgrp) and css_put(css) before exit ?

Yeah, as-is it'd leak references each time the function is called.

Thanks.

-- 
tejun

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
