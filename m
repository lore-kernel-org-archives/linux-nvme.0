Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A496606A319
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Oct 2026 18:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=P7ATlmDa;
	dkim=pass (2048-bit key, unprotected) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=VoecARur
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Mmr/IR1zCY9h4L4dj3m8FpWvL2EHS7s4xmQLBcny3D4=; b=P7ATlmDaAe0FITiUZ6wdm58EG/
	egdPsHreOWBocXHsudW3f7v8KwWD08ytjD3nRZQgYUaeecgX6dn9MkmjQJrfUNZCTURd51lJUI/5V
	oJDVZCJeoaTyFB6a/2cvA0lIN2/8Ly8g+SoFNI8v7AwwEZyNE8swLRTfFYxjTjKE1Sb6cHPlgSy3E
	2hivL3ri2+nG3wZ2SaA79uvaSS1Eajy/ek/dztW60L96B5i7jpnMQHhhEaY0IZPQP8JpgzeBlz8kv
	OaUZ/FYAcwk1yJufr74jKsWfFlDIMM5Geay904d4t3Lhv6xlr+dgzawldYMbh4tnP+WKtTEGiRpBS
	wUIPOXgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJas6-0000000Cdip-1MhL;
	Wed, 21 Oct 2026 18:17:06 +0000
Received: from mail-dy1-x1335.google.com ([2607:f8b0:4864:20::1335])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJas0-0000000Cdhy-2L0s
	for linux-nvme@lists.infradead.org;
	Wed, 21 Oct 2026 18:17:04 +0000
Received: by mail-dy1-x1335.google.com with SMTP id 5a478bee46e88-3514b90bb89so2819287eec.1
        for <linux-nvme@lists.infradead.org>; Wed, 21 Oct 2026 11:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1792606620; x=1793211420; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Mmr/IR1zCY9h4L4dj3m8FpWvL2EHS7s4xmQLBcny3D4=;
        b=VoecARurkVFOsUou+Skvfo5hzjMZgVZAJFvjJ1ghWU1n+rgTiNHUg4E0jK741ZGE6M
         atSJOJJ/ioIwkFCtoPZE1+z6TKV2/trkepG5OuGWTwWAQatYt0BJ4+RXtmRIhyJuw57J
         9f6tboNyoBSb42YVobQRMYQ1PDRyqSeGY076V4qu0kZOaRQSh1+HO21s987d7QAcGasf
         CBINm3tu1ljLYcS91a28QveAU1c92CjPrGnfcHQYhFl1EiURa24CZ7Hk09DB4otlrbig
         DeYcQtQ4EPQ5PcDt08HWCNXQaicSuflv/j2HVYlfQ2mBrwRy7BtfASKzAANd/cWUclJ/
         9SLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792606620; x=1793211420;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mmr/IR1zCY9h4L4dj3m8FpWvL2EHS7s4xmQLBcny3D4=;
        b=PzTFEl1XIOynw6B9AWNrzD/Qx2eX/ncaW0VJBqLOi0tY2E3/FRoMsu67FZQICD5CwR
         lL4o+5qkyDKX7KCTpcLFzIQHWUjTzM3kqCKDUdOZ8XNCYn7Oc1s5cL/Mjmr3/jYoI3P3
         5t2eeReQF7uml42TS5AJOm/KG4TkxZ1VQjZs8W4s7VZau8eu68I3OSB/dE88iX2vdRWQ
         HxSRmHyUHQvWUeQ0dUZBCP8FeGtNJm2+aPZLWRxtelFWnWBpP50/XiR1V21X77ysglOA
         J6ygiG9+dEPWcx3ePwaVzuTiWPUkPQRVPAAsyGbGmH97PdYC5WWcpjwbXNRWlwZ9FutD
         NMVg==
X-Forwarded-Encrypted: i=1; AKwUvBzpkBZHmfkZJPVldn6urag0npPGyRV3nkRoqz6AMppolw7KAlkDA+lihbnzuYwnzSZon0R3uvFmploO@lists.infradead.org
X-Gm-Message-State: AFq9FYLM2nYxhIlQAlwe39pck1cGrs+wducnRb62toS3gj+tXTnyUxLZ
	nTWjcXYOhm8ih5vYg7LWWO7egseFtr+tBqvdUtWWSOvKTE3hCK+Pzk4LkzymN7eVY18=
X-Gm-Gg: AYBFou1kwSjgZaSyNOULJXH9oVF2FJzBN4iH3oJThF3fBTIDKCQm43zfw2aYc6JkvBZ
	pL7wXQhja7uQb1eizUjX2cudsFpMrboVImyLuSRkhtCTdziLwUjRjH+OQA8Ihlaz8i8wvOVftTW
	9hnymgN0uVsx3U/IlxNHKkwapyJdFUOG8zUcXuuGCQd3QWUM2uQiXQaiHu098dK781mlckIDKOx
	QlRHAUX5P3pLEsQmwCnfgbkeutWEnJ2Wmk5BJ54KCf1huIbzj7BvxbqVy0XuhPDBH5RP7wjesn1
	OKSuByEp2CHIXbOZWuaJXauD24lPAsodeqAoxFclwmBftBbGAsf365NzMtCc7kLtuGy7TgBgrxX
	SGgsnrs+IZe1rTV9ZBVrX0fi4uzIe/OWNgKpLNIf8Kxf1OXafArmeH1U5NRCVuhVg9a8Y3pjnDc
	JC5aizSJI/7WqV9yywW7dWH0ooOv5q6Y05R/rRrLtq5Gcc1fnvXNDhA7+A+CudeYNe4/0bONBwA
	Dzafb/7yqzBz050dc3m6Hc5nF0qy03esX/E/XBtZOw3hrnXHhjFmFhwj64MvaC5bLnTtgb/8rGm
X-Received: by 2002:a05:7022:eb46:10b0:14f:5cd:f286 with SMTP id a92af1059eb24-190a61447a2mr3916698c88.34.1792606619346;
        Wed, 21 Oct 2026 11:16:59 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-1903a180b9esm12244049c88.4.2026.10.21.11.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 11:16:58 -0700 (PDT)
Date: Wed, 21 Oct 2026 11:16:56 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Daniel Wagner <dwagner@suse.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>, Hannes Reinecke <hare@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	James Smart <jsmart833426@gmail.com>,
	Randy Jennings <randyj@purestorage.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 09/18] nvme: Implement cross-controller reset
 completion
Message-ID: <20261021181656.GV2931-mkhalfella@purestorage.com>
References: <20260920182936.2317916-1-mkhalfella@purestorage.com>
 <20260920182936.2317916-10-mkhalfella@purestorage.com>
 <207f5a00-7fee-4ea5-b541-38424d4766bd@flourine.local>
 <20261021010438.GR2931-mkhalfella@purestorage.com>
 <02c2a904-2264-46b8-b49f-6f7109913da6@flourine.local>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02c2a904-2264-46b8-b49f-6f7109913da6@flourine.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261021_111700_792897_B88A59A0 
X-CRM114-Status: GOOD (  45.86  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed 2026-10-21 10:43:03 +0200, Daniel Wagner wrote:
> On Tue, Oct 20, 2026 at 06:04:38PM -0700, Mohamed Khalfella wrote:
> > > What happens to the waiters on sctrl->ccr_list when the source
> > > controller enters error recovery while a CCR is pending?
> > 
> > You already answered it below :)
> 
> I tried to figure it out, but I'm still not sure if I really understand
> all the conditions. So bear with me.

No problem. Take your time.

> 
> > > As far as I can tell, ccr_work itself is fine. The reset path cancels
> > > it via nvme_stop_ctrl(), and in the error recovery path the Get Log
> > > Page just fails once the admin queue is torn down. But the target drops
> > > all CCRs issued by the old association when it frees the controller,
> > > so the CCR completed AEN for them will never arrive. Nothing on the
> > > host side walks ccr_list when the controller leaves LIVE, so
> > > nvme_issue_wait_ccr() sleeps until min(kato, deadline - now) runs out
> > > before nvme_fence_ctrl() tries the next source controller. In the
> > > worst case that eats the whole fencing window.
> > 
> > If the remaining of the fencing window (deadline - now) is less than
> > kato then I am fine with this scenario wasting this time anyway. If we
> > hit the deadline then we consider fencing done anyway. If it consumes
> > kato from the deadline then we retry another path.
> 
> Okay, this might be something worth documenting? It seems like a case we
> will get bug reports in the future.

I do not think this behavior worth documenting as stable behavior. We
should be able to refactor/change/optimize this code in the future
without worrying about breaking a documented behavior.

The main point of CCR is to speed up controller fencing in order to avoid
CQT delay. I think of it as a best-effort process attempted in a bounded
amount of time. If it succeeds we skip the CQT delay, otherwise we spend
the time we will have spent in CQT delay anyway.

Can we do better within this bounded amount of time? Sure, this is what
is being suggested here. However, I prefer not to do that part of this
patchset. Also, do not like to clutter the code with comments about
potential changes.

> 
> > > Would it make sense to fail all pending entries (set ccrs to a failure
> > > status and complete them under ctrl->lock) when the source controller
> > > goes into error recovery, so the fencing code can move on to another
> > > path right away?
> > 
> > Failing pending CCR entries that we know we are not going to complete
> > will help in this case. The question is where to do that. A LIVE
> > controller might hit an error and transition to FENCING, or manually 
> > reset and move to RESETTING, or deleted and go to DELETING. Do we need
> > to consider all these places to fail the pending CCRs?
> 
> I'd say yes. Anyway, I don't think this needs to be addressed right away
> if the current code is functional correct and we are just not as fast as
> possible. 

Agree, the goal of the patchset is to add the initial support for
CCR/CQT. If there are functional issues they should be addressed now.
Known gaps and optimizations can come in later patchsets.

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ca7f083702f5..6c0703fba8ff 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -863,6 +863,9 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
                wake_up_all(&ctrl->state_wq);
        }

+       if (changed && old_state == NVME_CTRL_LIVE)
+               nvme_fail_pending_ccrs(ctrl); /* TBD */
+
        spin_unlock_irqrestore(&ctrl->lock, flags);
        if (!changed)
                return false;

One way to fail pending CCRs is to add it to controller state machine.
Something like the diff above.

> 
> > You might have also noticed that nvme_issue_wait_ccr() calling
> > __nvme_submit_sync_cmd() might consume the entire fencing window if the
> > CCR command gets held because the source controller hits an error. This
> > is another area be optimized. I am inclined to leave the code as it is
> > today. What is being described here is an optimization that can come
> > later on.
> 
> Yes, I was actually about to ask about __nvme_submit_sync_cmd in this
> path next. Since my questions are about optimization, I don't think we
> should make the current version any more complex than it already is. We
> can handle optimization later, but please document those cases in the
> meantime.

Hannes also raised this point. It is on my todo list to add timeout
parameter to __nvme_submit_sync_cmd() and use that here.

