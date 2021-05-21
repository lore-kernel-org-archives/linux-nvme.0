Return-Path: <SRS0=oXoK=KQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 174D5C47076
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 18:19:34 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B819613DA
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 18:19:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B819613DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jGWhkYiUBR/CMuPG9QHFW1EuyXSeMOniU6uabEZg/rs=; b=LOzbQEYTb6LpTDKinWmet291eu
	d2iidbAjOMYtaY0LUuAhwbprtZePUSnJvlW3qHS1hNhr2g3uXSX4oC1D/wpaj41mff+pZYqbnxlA9
	7VGNe/m3juU3/tENcYzhU+DQ909idtsUy1sDZcTqj1qS7jphfM0MLTnHIMZjDB/CjbE0LNL3P3nO5
	74ryMy66h2T0Odr5jsYhIdart15jMH3JvFWItBx+GS3pm/2bog3GrNyUi3fUk4zg6hEoekhPqRSvq
	1P3naC9ZNO7oj3u+Ra5x4l/yvyK13eJr2/FOzOY1T4EEOgdGwl+OWfkxObC0/iYbmqjVRjBTfQ0ka
	dZ/C7BWg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lk9k5-000gs9-Dd; Fri, 21 May 2021 18:19:25 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lk9k1-000grL-KF
 for linux-nvme@desiato.infradead.org; Fri, 21 May 2021 18:19:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=iSKsuxc7KK290fDdhFLYw4gtD9YNRQ+Uu5LmwoVVTXA=; b=cdSycrbe4ZTAahi6IlehJReZ5p
 +AZ4M4yNnKGpnI8zITZ2b+RzcBctUnUX8nLpH93A/TJrt1WdirWe7jQcrM2jUNmVA5nqgskx19lTX
 XzhzaxwjpVbsTInTuIUg7u6kl6cOUPAyyGsx+5X0eZMBqG8Bfw6aO6su2ZLDAPBcNK8ltRm7WTrT1
 1aVq5F7O6PD2kbhq6djS3P7FHnd/Skkeq6Yq3MHr8+Da0A4uecSz9eL6xrjJMittLwxr3GHX2G9iY
 hUr8u9lkIN6XhsuZzOBXnAKfK4lOGJeJLxozksnH/SNEwkA+kGTTD1sZdEKC5+/6hS7c/BHqcRKsr
 7Z7DVsag==;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lk9jz-00HLfL-16
 for linux-nvme@lists.infradead.org; Fri, 21 May 2021 18:19:20 +0000
Received: by mail-wr1-f44.google.com with SMTP id x7so2320167wrt.12
 for <linux-nvme@lists.infradead.org>; Fri, 21 May 2021 11:19:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iSKsuxc7KK290fDdhFLYw4gtD9YNRQ+Uu5LmwoVVTXA=;
 b=ekEgBFP3pqbyezyg5xS6wwWdz6SiI1GQVoQPd+RNfyoDTOEzMnzoMHmt/6C6paWTm3
 Hmd7dGRxFC8LGBeTPuPLObxvaTJsgGTR6EaBMgq1GjAy258I1jmqpJ+v8ZY0Guv8q0d6
 wzzLIGK8cDbPMgxwrd/5zhNcAhmbd9IeTTE/urbVL3JNzfiP4stgH6WkrMuZNUqcR3wh
 4rnSq3K3hx77MKDpv816WvFVCSa9zw8tj9Clxr2VSZVK8zlRGvO79tDy9Txdi7qkIifI
 fPsqITfHn781lTTxtcRGUHzTCtUO2mzN8OPRe2Kc5DumLPnRCct+wHBeY6dDq1nWTlSS
 ax0A==
X-Gm-Message-State: AOAM531/PJ36iCMQ+HBAZAoXjZuQ13fmBeXo+kaYID2zD0y0hMxd2lar
 sC+wkNGXf34t/L2ku3cn4pQ=
X-Google-Smtp-Source: ABdhPJxB66HwfYQpqw5w1KrdnI3GcaMU0KISKKjsesggXmCdnuPlOja2mFkRiH/6wpGLdP/pHNLxUg==
X-Received: by 2002:a5d:6e0d:: with SMTP id h13mr11186409wrz.118.1621621157117; 
 Fri, 21 May 2021 11:19:17 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:66b2:1988:438b:4253?
 ([2601:647:4802:9070:66b2:1988:438b:4253])
 by smtp.gmail.com with ESMTPSA id z18sm3019895wro.33.2021.05.21.11.19.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 May 2021 11:19:16 -0700 (PDT)
Subject: Re: [bug report] blktests nvme/022 lead kernel WARNING and NULL
 pointer
To: Yi Zhang <yi.zhang@redhat.com>, Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org, skt-results-master@redhat.com,
 Bruno Goncalves <bgoncalv@redhat.com>
References: <CAHj4cs-hAaHhWU4Kb4NrQ9Fvi7DiH95P=Q=7zK-inxpeZtztkw@mail.gmail.com>
 <3243ab72-ffe3-e655-ef0a-d695885ce2c5@grimberg.me>
 <CAHj4cs9uOHRgRe9PJ3_0A4NMo4T1q4XzCYG6UAV-V=RZ39i1iQ@mail.gmail.com>
 <CAHj4cs-JawWOTNBnQ3OTeNXUb_zeH3-5MrPQWK0=1QPfEJ7ROA@mail.gmail.com>
 <201a97a9-e42f-8d8e-3cc7-e5cf8ba816c2@grimberg.me>
 <423b7c5e-deb7-3547-6ca4-8f4476e9eb03@suse.de>
 <CAHj4cs-3sY=E643N89Gs46M0-KLivJP2WeXsB8bCftNq1kAe9g@mail.gmail.com>
 <CAHj4cs_NVzgA8=gC9MKSakdDgBR4ghLQv6H8tw_BgxUUvA+Uew@mail.gmail.com>
 <d0bd7905-9741-012f-ff7a-f211d8170088@suse.de>
 <CAHj4cs8XEVdZKK1J0GHZxEzBkApOaO9T-uONGiimM-_qR8Kjaw@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <3cce5b25-c8f3-536b-6285-9ce5aab1572f@grimberg.me>
Date: Fri, 21 May 2021 11:19:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAHj4cs8XEVdZKK1J0GHZxEzBkApOaO9T-uONGiimM-_qR8Kjaw@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210521_111919_105110_6B5B2170 
X-CRM114-Status: GOOD (  21.69  )
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


>>> What about this?
> 
> Hi Hannes
> With this patch, no WARNNING/NULL pointer this time, but still have
> 'keep-alive timer expired' and reset failure issue, here is the full
> log:
> 
> # ./check nvme/022
> nvme/022 (test NVMe reset command on NVMeOF file-backed ns)  [failed]
>      runtime  10.646s  ...  11.087s
>      --- tests/nvme/022.out 2021-05-20 20:16:31.384068807 -0400
>      +++ /root/blktests/results/nodev/nvme/022.out.bad 2021-05-20
> 20:24:27.874250466 -0400
>      @@ -1,4 +1,5 @@
>       Running nvme/022
>       91fdba0d-f87b-4c25-b80f-db7be1418b9e
>       uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
>      +ERROR: reset failed
>       Test complete
> # cat results/nodev/nvme/022.full
> Reset: Network dropped connection on reset
> NQN:blktests-subsystem-1 disconnected 1 controller(s)
> 
> [37353.068448] run blktests nvme/022 at 2021-05-20 20:24:16
> [37353.146301] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> [37353.161765] nvmet: creating controller 1 for subsystem
> blktests-subsystem-1 for NQN
> nqn.2014-08.org.nvmexpress:uuid:6a70d220-bfde-1000-03ce-ea40b8730904.
> [37353.175796] nvme nvme0: creating 128 I/O queues.
> [37353.189734] nvme nvme0: new ctrl: "blktests-subsystem-1"
> [37354.216686] nvme nvme0: resetting controller
> [37363.270607] nvmet: ctrl 1 keep-alive timer (5 seconds) expired!
> [37363.276521] nvmet: ctrl 1 fatal error occurred!
> [37363.281058] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
> 
> # ./check nvme/021
> nvme/021 (test NVMe list command on NVMeOF file-backed ns)   [passed]
>      runtime  10.958s  ...  11.382s
> # dmesg
> [38142.862881] run blktests nvme/021 at 2021-05-20 20:37:26
> [38142.941038] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> [38142.956621] nvmet: creating controller 1 for subsystem
> blktests-subsystem-1 for NQN
> nqn.2014-08.org.nvmexpress:uuid:6a70d220-bfde-1000-03ce-ea40b8730904.
> [38142.970524] nvme nvme0: creating 128 I/O queues.
> [38142.984356] nvme nvme0: new ctrl: "blktests-subsystem-1"
> [38144.014601] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
> [38153.030107] nvmet: ctrl 1 keep-alive timer (5 seconds) expired!
> [38153.036018] nvmet: ctrl 1 fatal error occurred!

I think that the main reason is that there are 128 queues that are being
created, and during that time the keep alive timer ends up expiring as
it is shorter (used to be 15 seconds, now 5 by default).

nvmet only stops the keep-alive timer when the controller is freed,
which is pretty late in the sequence.. The problem is that it needs to
be this way because if we shut it down sooner a host can die in the
middle of a teardown sequence and we still need to detect that and
cleanup ourselves. But maybe we can mod the keep-alive timer for
every queue we delete, just in the case the host is not deleting
fast enough?

Ming, does this solve the issue you are seeing?
--
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 1853db38b682..f0715e9a4a9c 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -804,6 +804,7 @@ void nvmet_sq_destroy(struct nvmet_sq *sq)
         percpu_ref_exit(&sq->ref);

         if (ctrl) {
+               ctrl->cmd_seen = true;
                 nvmet_ctrl_put(ctrl);
                 sq->ctrl = NULL; /* allows reusing the queue later */
         }
--

We probably need to rename cmd_seen to extend_tbkas (extend traffic
based keep-alive).

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
