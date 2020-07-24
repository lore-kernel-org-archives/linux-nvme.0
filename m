Return-Path: <SRS0=Gu9/=BD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1697AC433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2020 00:12:11 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6A8F206E3
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2020 00:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="s168DOu6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6A8F206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=o+V92os4ZyOlTIuhRrWfaxicL6fbFVlZfLwt4I56+7g=; b=s168DOu6eJDBH2+fwTjr9wwbX
	JbLuwd33Zs+WGHGcc0L1LBWwU87QbbVHl9pEyGn5q298GtmbChKaiKwVLZ7vhn2bOa8YK0MWk/Xtg
	6GEXqllqcSI5ML2/vecsN+Juf8Ou4jpFgNrCXHJ6lhPs/ndIpU8AcQ83nOmOWUGjQtQHZiJhTYoac
	QiQ3eo6zKbYGM1JiptjEwlx23U1zA5F2GXHHWVZQWHOWq8giv8EU4XLq5L2++1kNbfnXuBZT27VUD
	wYf3NJ5sEPEblQeYD4WyJZFVKJ0i/wH+tC2OMs7wTKhf8DK1Zytkn80Xdfvt4TIN4y5eTmRCaqW9Z
	nRamZjRLw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jylJm-0003M3-5S; Fri, 24 Jul 2020 00:12:06 +0000
Received: from mail-wr1-f65.google.com ([209.85.221.65])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jylJj-0003Lf-FC
 for linux-nvme@lists.infradead.org; Fri, 24 Jul 2020 00:12:04 +0000
Received: by mail-wr1-f65.google.com with SMTP id r12so6703351wrj.13
 for <linux-nvme@lists.infradead.org>; Thu, 23 Jul 2020 17:12:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ns3nhizG3/mUWr6SsGg8cdETw5+NbZxCCt4sGxTCzM4=;
 b=dZAxIHIbpyRJM7IicHHPQlddlMGrh0+DfOjuyYgvKNVV5YnhTK9CERajWGcC0rkm4g
 toaxySBugTsu13U1F0JrK8N3dn7KTKBhHAG+I18rs+HpEMaY20sFvrwiG/iDGTkgEuQZ
 g+9sns1ttEszzqF6biY1WQ0yKy7A1W92u+EE9w6Jr9U6mBFPrULtO05a3JywfBZqooM6
 2OLnlcOjg39MrUtH2Th81C3QYt4EtncXoTmNVeKXpVgPfBZPXYAmavqZpH23ckbJYu0K
 17Zj7LS4iRn3fFWne+jWgp3zLS7KX167137CDLuY2DXJ/h+vjOHGkAsbx9bDjtWZ9yqv
 eFiA==
X-Gm-Message-State: AOAM532swnCraiJ81C76nKAjvFKFnHGZ7oTM3YOJ2LJ96HIBEwGVnq4T
 ghlROgSKnL/mpkfB/YptwYs=
X-Google-Smtp-Source: ABdhPJyc0lDpf7SaZH1fPbndeLQrPKhT9f2dXU5A4qrlFEKmXawxB2PfA60UvR9EaN4jr3sO6nJtXA==
X-Received: by 2002:adf:e805:: with SMTP id o5mr6433151wrm.419.1595549521989; 
 Thu, 23 Jul 2020 17:12:01 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:a07e:34d2:a5fa:d770?
 ([2601:647:4802:9070:a07e:34d2:a5fa:d770])
 by smtp.gmail.com with ESMTPSA id g126sm5201860wme.16.2020.07.23.17.11.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2020 17:12:01 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] nvme-core: fix deadlock in disconnect during
 scan_work and/or ana_work
To: Logan Gunthorpe <logang@deltatee.com>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <20200722233219.117326-1-sagi@grimberg.me>
 <20200722233219.117326-3-sagi@grimberg.me>
 <770b71ff-b3d9-886d-3455-cfae217c45c8@deltatee.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <4da6f061-ee5b-d40a-7e81-6f705ac0fcb8@grimberg.me>
Date: Thu, 23 Jul 2020 17:11:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <770b71ff-b3d9-886d-3455-cfae217c45c8@deltatee.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200723_201203_521892_4FA0BAC8 
X-CRM114-Status: GOOD (  15.13  )
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
Cc: Anton Eidelman <anton@lightbitslabs.com>,
 James Smart <james.smart@broadcom.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> Fixes: 0d0b660f214d ("nvme: add ANA support")
>> Reported-by: Anton Eidelman <anton@lightbitslabs.com>
>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> I just tested nvme-5.9 and, after bisecting, found that this commit is
> hanging the nvme/031 test in blktests[1]. The test just rapidly creates,
> connects and destroys nvmet subsystems. The dmesg trace is below but I
> haven't really dug into root cause.

Thanks for reporting Logan!

The call to nvme_mpath_clear_ctrl_paths was delicate because it had
to do with an effects command coming in to a mpath device during
traffic and also controller reset.

But nothing afaict should prevent the scan_work from flushing before we
call nvme_mpath_clear_ctrl_paths, in fact, it even calls for a race
because the scan_work has the scan_lock taken.

Can you try?
--
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 35c39932c491..ac3fbc4005ad 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4105,6 +4105,9 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
         struct nvme_ns *ns, *next;
         LIST_HEAD(ns_list);

+       /* prevent racing with ns scanning */
+       flush_work(&ctrl->scan_work);
+
         /*
          * make sure to requeue I/O to all namespaces as these
          * might result from the scan itself and must complete
@@ -4112,9 +4115,6 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
          */
         nvme_mpath_clear_ctrl_paths(ctrl);

-       /* prevent racing with ns scanning */
-       flush_work(&ctrl->scan_work);
-
         /*
          * The dead states indicates the controller was not gracefully
          * disconnected. In that case, we won't be able to flush any 
data while
--

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
