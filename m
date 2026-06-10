Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D3D5CD98C7
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jun 2026 22:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ERJnitgYeN+oHp0QIhM2Gx0sT2CNtRoOhhriDExY+yw=; b=zJiI0W2Es2kVU704dUt1c5Cgug
	+NFitff9qdTcY+rSCn4S7+Mn45xxvydJPzKLihogKbMS3uR4J7pIAImocKOdDOjXYqqK89f2AMagj
	CGQXjybMpd9O82NG+a7ZWdbJeg/7z35DA/DKQ93xKvvZw/85Mh8onpwGmxIFxUKEVMJEvaEvgqbrA
	wVosn60orBobReji+cBlNKiUvF8Wy7dYBMmVh3wFTh+hleSKxZ/D31/48QOTwm4DeuUVsFpOzFi7P
	f6Qj1yg0bjby4CY8jutY6ZhFAdCWpnzQyr2jrqp+uiXMU0CkqWpTqnneDel7tYinF6wya68AuGj44
	t6r7K07w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXROI-00000008Pry-3YqJ;
	Wed, 10 Jun 2026 22:27:18 +0000
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXROF-00000008Pra-48l5
	for linux-nvme@lists.infradead.org;
	Wed, 10 Jun 2026 22:27:17 +0000
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-45ee5cdbd28so179926f8f.1
        for <linux-nvme@lists.infradead.org>; Wed, 10 Jun 2026 15:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781130434; x=1781735234; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ERJnitgYeN+oHp0QIhM2Gx0sT2CNtRoOhhriDExY+yw=;
        b=jtX0pAC+qPcGyBpGuRPUPCk/itUa5MuNdlHn/ildTygbFJK+51qqVG3y1UayMqIsMz
         6aXEXMf9KIjOxqVKitzUsCCRcyaadDKC4ggJN9wqup7MqhkYXBA9Tqdau0uJtEKDLosw
         v+Bu2ZGxnxzpHvCtMJIegD0JtLQcYS77uCyCCCo5K+XLi+UZmAdyufOyVPuf+g/bfy71
         1BHdZAZBqT/KpFbMM6gNkBznkjQmtNR9HBs5lZuZ1uTd3dUI9odREpvIBTfEliLtuI2z
         3V5X4/lzUHxLnwWa9nhuBqOUBYrwsCOL7gFWQhL3LywYtUGfpVVDwmUYEEySmxzti654
         0xaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781130434; x=1781735234;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ERJnitgYeN+oHp0QIhM2Gx0sT2CNtRoOhhriDExY+yw=;
        b=pwnwf2TZHIkRyr/RyOVxixl1NYjpr8RLQlVSjyPzsklxmYuLh+mK+njhO8KJH3+r/q
         hEC9tHM/AJivDpHZGtLKALdgKtjeMNUsN3C2AZ3liO+IrRz/7+HSeYXNwJo0oPYvaDD7
         G2QJM098t5Re7rujClCiemyoTeQrWwXMceZFkrIpnYt6YvpEp+ZN2B3G9gXIBFWtjxFO
         //wd+JNvf0+9pJUQd4nqOT9/pTh2vNVr8tvRBHFGTGnemcM1HNJoomyeI0Xv3RkzDNCe
         9V0h/+t/qwoSQPzUxyhMFYbr3WP2/sosu9M0uFtaA4AtCSvfsjFyeG+Y2oDNhjgTxLwb
         ldng==
X-Forwarded-Encrypted: i=1; AFNElJ90JmyJ9vJNkkWc7+++Qk1N8tOKIiCK7oY2G6WQeNnZp9nEaEz6AdfGkgyLXXf0WgKbylm9GKAhdSS8@lists.infradead.org
X-Gm-Message-State: AOJu0YwXmoTc9JKk1L0j2N6Lil7JMWNhdltL0HZiIrujP131x2p1Yjv5
	FicYtVanabU+XjC/zPFRivDTDnrP9Ufb0KzT8cF4PO+RQQkWRYbwc6IjMYR/m7Iy0u0=
X-Gm-Gg: Acq92OHcJxlZiXtuK3FVCRdQyJZzSEoBU8aUBwfoI9ymJi7sIQSD38qpVrv/7NdjTPA
	Ovm+PVVxHujmgW4hr3LcYwUD/rC0NVWq63woAkFQGPWUv1TomrghqzIVdArJJa2hrH81t2tuelQ
	4VJmKu5rOv8sck2k5fft8miJTHMQAe4F4aHL/LZ5r43Uk91RQ00avtgHHTSihahy/9OBg88uXfp
	+L1S0f4bWE0PWl1uDcY1L8KoQPEqpVdBvk6acB7zrGZjaYk8mRahY1y1xxtnWZY1ajdvzjR4Z3t
	pzdUAxzuTOZv8I8vvuKhQYj/fB0BeIvIAtq4pMLH32YYbqjx2DWw7jzGLlcjNE6wbWsr4ajM2sU
	eXYlTUPOTJ+FSPffSTBGh4JGXXWndMquYAiQgU9Vdt+e1fMUkkOfsU6u3/EYg6Lm6GpfSNS90io
	KHPof7SFVGDmqDW60+erve+7GGjG80OIJfTOT0KBqTBrdZUTPNDZgsxd/+oIckr6Fluy4yW/tC5
	0iEpuiX/cMztTEwlWXnKLcagmpkrxw9sR7paJ8LUtHOqw==
X-Received: by 2002:a05:6000:461a:b0:460:d18:865c with SMTP id ffacd0b85a97d-460664c54bbmr512993f8f.1.1781130433530;
        Wed, 10 Jun 2026 15:27:13 -0700 (PDT)
Received: from localhost (pat-125-253.wlan.net.ed.ac.uk. [192.41.125.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcae2sm80574537f8f.6.2026.06.10.15.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 15:27:12 -0700 (PDT)
Date: Wed, 10 Jun 2026 23:27:12 +0100
From: Karim Manaouil <kmanaouil.dev@gmail.com>
To: Hannes Reinecke <hare@suse.de>
Cc: lsf-pc <lsf-pc@lists.linux-foundation.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	linux-mm@kvack.org
Subject: Re: [LSF/MM/BPF TOPIC] Memory fragmentation with large block sizes
Message-ID: <20260610222712.cmbforeivf7h544y@wrangler>
References: <f22caf98-1375-493a-a275-0500ffac3e81@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f22caf98-1375-493a-a275-0500ffac3e81@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260610_152716_073076_F3D21884 
X-CRM114-Status: GOOD (  20.46  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Feb 19, 2026 at 10:54:48AM +0100, Hannes Reinecke wrote:
> Hi all,
> 
> I (together with the Czech Technical University) did some experiments trying
> to measure memory fragmentation with large block sizes.
> Testbed used was an nvme setup talking to a nvmet storage over
> the network.
> 
> Doing so raised some challenges:
> 
> - How do you _generate_ memory fragmentation? The MM subsystem is
>   precisely geared up to avoid it, so you would need to come up
>   with some idea how to defeat it. With the help from Willy I managed
>   to come up with something, but I really would like to discuss
>   what would be the best option here.

thpchallenge from mmtests has been a staple for the compaction/anti
fragmentation folks.

And check this https://patchwork.freedesktop.org/patch/716404/?series=164353&rev=1

Btw, do you mind sharing what workloads you discussed with Matthew?

> - What is acceptable memory fragmentation? Are we good enough if the
>   measured fragmentation does not grow during the test runs?
> - Do we have better visibility into memory fragmentation other than
>   just reading /proc/buddyinfo?
> 
> And, of course, I would like to present (and discuss) the results
> of the testruns done on 4k, 8k, and 16k blocksizes.
> 
> Not sure if this should be a storage or MM topic; I'll let the
> lsf-pc decide.
> 
> Cheers,
> 
> Hannes
> -- 
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
> HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
> 

-- 
~karim

