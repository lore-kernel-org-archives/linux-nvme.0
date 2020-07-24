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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620B0C433E1
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2020 00:26:59 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F85B20888
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2020 00:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eBXNodUt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F85B20888
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=CZLYkzp9rfsKk7awcHCw/FFSsB9q7bF6WYwoBlMBMvs=; b=eBXNodUtBBGu6gqHhS1zm+HxX
	gpwpOdmcVCwTYGiTCp38tnaeU8Np2oEsHVzOOTyGNDXZ+K917dkVWGmR2BrEipmFWj88k/C3oxEh/
	H38X0xJivgmZNt8n/vUhJpy6tn8w1XO+R9WFJcSaVmZoCvQcjxEWQdB8HZgqRPeRW9ZqKhAzTGodU
	BTVJSJ+jclJUsnOT/n6lPMWXl3ns2+Zrt1ElXAIixdm0SAFDzmWoeP0C7SKXU5Tf4xLyWBcXwk4Es
	gUoi6UNTJ9yLf6UUCP9oDEQyrsmR5NwyKkTk8aZa3ehCu24fR9hmlydE/C19W1u4UAOiEa/y4W6NZ
	2IVcKfBOw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jylY5-00042J-9p; Fri, 24 Jul 2020 00:26:53 +0000
Received: from mail-wr1-f67.google.com ([209.85.221.67])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jylY2-00041s-89
 for linux-nvme@lists.infradead.org; Fri, 24 Jul 2020 00:26:51 +0000
Received: by mail-wr1-f67.google.com with SMTP id r2so1667934wrs.8
 for <linux-nvme@lists.infradead.org>; Thu, 23 Jul 2020 17:26:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hvL6A1V0k9Vj9KISBW9D8+UI848DQ0KC3aWJc3al/Sc=;
 b=P2B+lu3F8yxwlG7jwdGjl9eZShQMJ0HCShv1mZEd0ksidhSNOeQxJ+0SNEY2OEGnBs
 sF6dh1rklnm78nrmLTf2S7OCq8pB2QDJZDeTbt+//tHyzEnn/5pihMsfnL0kSFCkkqgJ
 qG5oo6rIhQ3rU6ifsRycfyt7dwUKadOLDdCTAhX7SqG1TvvxVwfGba8nNS1rm20/z7cW
 /Cm/gAjetdYVJgjq1ZMBVgKezNVti1L5OJS8wNRE7OMaxsTNzJanbpD9OQx+ow1s7qf9
 aM181aFooBnHwO9LfXofpaSq73alM33QvVXRUUyQZ6lKgnXMLQqXAIVFGIgjb3UrOIzs
 GIBg==
X-Gm-Message-State: AOAM532g7VWG6o8u/AaVE+MAx1hRJJtRgbeG/37v6l+lgnyHgBne3bUW
 nKTPD3AnrJ25QFo3un6Vrzw=
X-Google-Smtp-Source: ABdhPJyXJQuf7TF8aYsrHTvcvXBxZAGgUOscIRWjKaXDbslqLOH3co+lculuY3CRZWCN8j69I12AFw==
X-Received: by 2002:adf:ded0:: with SMTP id i16mr6046832wrn.389.1595550408768; 
 Thu, 23 Jul 2020 17:26:48 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:a07e:34d2:a5fa:d770?
 ([2601:647:4802:9070:a07e:34d2:a5fa:d770])
 by smtp.gmail.com with ESMTPSA id y189sm6199348wmd.27.2020.07.23.17.26.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2020 17:26:48 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] nvme-core: fix deadlock in disconnect during
 scan_work and/or ana_work
From: Sagi Grimberg <sagi@grimberg.me>
To: Logan Gunthorpe <logang@deltatee.com>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <20200722233219.117326-1-sagi@grimberg.me>
 <20200722233219.117326-3-sagi@grimberg.me>
 <770b71ff-b3d9-886d-3455-cfae217c45c8@deltatee.com>
 <4da6f061-ee5b-d40a-7e81-6f705ac0fcb8@grimberg.me>
Message-ID: <70424742-3af4-ded7-d3d0-b1f32d97905e@grimberg.me>
Date: Thu, 23 Jul 2020 17:26:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4da6f061-ee5b-d40a-7e81-6f705ac0fcb8@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200723_202650_326430_3E8B70C1 
X-CRM114-Status: GOOD (  18.42  )
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


>>> Fixes: 0d0b660f214d ("nvme: add ANA support")
>>> Reported-by: Anton Eidelman <anton@lightbitslabs.com>
>>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>> I just tested nvme-5.9 and, after bisecting, found that this commit is
>> hanging the nvme/031 test in blktests[1]. The test just rapidly creates,
>> connects and destroys nvmet subsystems. The dmesg trace is below but I
>> haven't really dug into root cause.
> 
> Thanks for reporting Logan!
> 
> The call to nvme_mpath_clear_ctrl_paths was delicate because it had
> to do with an effects command coming in to a mpath device during
> traffic and also controller reset.

Actually, I think I'm confusing, the original report was from you Logan.

> But nothing afaict should prevent the scan_work from flushing before we
> call nvme_mpath_clear_ctrl_paths, in fact, it even calls for a race
> because the scan_work has the scan_lock taken.

Actually, I think that the design was to unblock the scan_work and that
is why nvme_mpath_clear_ctrl_paths was placed before (as the comment
say).

But looking at the implementation of nvme_mpath_clear_ctrl_paths, it's
completely unclear why it should take the scan_lock. It is just clearing
the paths..

I think that the correct patch would be to just not take the scan_lock
and only take the namespaces_rwsem.

So a more appropriate patch would be:
--
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 900b35d47ec7..83beffddbc0a 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -156,13 +156,11 @@ void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl 
*ctrl)
  {
         struct nvme_ns *ns;

-       mutex_lock(&ctrl->scan_lock);
         down_read(&ctrl->namespaces_rwsem);
         list_for_each_entry(ns, &ctrl->namespaces, list)
                 if (nvme_mpath_clear_current_path(ns))
                         kblockd_schedule_work(&ns->head->requeue_work);
         up_read(&ctrl->namespaces_rwsem);
-       mutex_unlock(&ctrl->scan_lock);
  }
--

I'll also prepare a setup and run the test.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
