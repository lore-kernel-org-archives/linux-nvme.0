Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59637EB5948
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Feb 2026 01:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YQWt1R0WAX4GXLt31RyEjtHcrk3cWxVVpnwl4fyb9mg=; b=P80ejLt0d0SEyVfKbT2XW39Ics
	IOTKvYeiJuMZ14oUux9HGzYw8qDjqOFfmm4xonin0UmVlWTzHW/2crMRBHigdTb4a3LKu8t/8QR0f
	xmwd6xqlEqnPUadDwKbd7xYdKT13oa1vldpfossO3HNv3qccXim3hm1lrXfNc3AUXVrm0s3P6pn8R
	RPlOjoDOiXIZzE7hqpqYIp8GtKzbYpKfB2GoYsxt5ZHrNdDqgeJzw1TiCs8Tt/HmK9RgZdqoNfPiG
	Ca268YZi5WemkeTNpUM4rX9YxqpBhPS7tlzbor2UISqaCeY6hudy6P29IstVhZwu0s2Ul/WIg5Gju
	TpQ7ElXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpycy-000000004XT-0ip5;
	Wed, 11 Feb 2026 01:02:48 +0000
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpycw-000000004X9-04qu
	for linux-nvme@lists.infradead.org;
	Wed, 11 Feb 2026 01:02:47 +0000
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-47ee3a63300so16760845e9.2
        for <linux-nvme@lists.infradead.org>; Tue, 10 Feb 2026 17:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1770771764; x=1771376564; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YQWt1R0WAX4GXLt31RyEjtHcrk3cWxVVpnwl4fyb9mg=;
        b=T/jakWwcP3bYGH5ACNTyuXHZWVrgmOA3bLnTiPzQA4lgzqGOQtkKdFwSzWSAjR5ZHM
         jUeyIBTUNT5Fs5XGYLDdWRGb1gPn5iCVDkK7CFc4j8VPq9j3Guta8/UtJdxsSiMqRnNP
         F7U2WY0ETDT9cgvZDd1l0jvV5hX1b5H1M1u3Bkls6igGmaew9kNjthN3DDc03hgpqwLT
         UP5k6LYe9yC27ET7IN2X2GVTZrTtZCkFGDCKwL4xhm/rAw1qC+yNnE4gAlmt3tKOVQRj
         Ct9WGi8YCV7C5iRN9Oz9ZEyDGsp/nQx0AAYa4fJLh+D6ZNulwJU4ioktHHFR3GpyTZQv
         UdeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770771764; x=1771376564;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YQWt1R0WAX4GXLt31RyEjtHcrk3cWxVVpnwl4fyb9mg=;
        b=qEKGiXnKdAv86Lj13Ul4qp9R4WFfxDmryowSD7N8iQZRFcKEnvQByiGX0hAZpfg3GI
         hSk5bNF8LFXpg41ByQFjA7opzP4dmPzSmlWuWIYxQSSn8g9rs+HO3Aqv024mWbmaknBj
         shr8tTm5LzzOt7gWfHrqx6puX2TeLNTksDWGeqmKOl8InR/H2bEU9wx9Sumvk7BoZav1
         nXVywCLZ9fi2M1jilgowpvEp/TLJOn4oohPDkbHUJ1Avizlxu5luQWYabDVL5wzL6njG
         /xVdwMisBc+gHR254djUmnEINiYwE4ox3urz95mWpFKDms+wPlfUmMZZCBDFI36SLpFD
         xEew==
X-Forwarded-Encrypted: i=1; AJvYcCXWb7eGV0FtSl1UGAwOgqFJ5qMAYRjzKPmWB7rglk4BNhD+r4DlTFm/IP4iNmH6fdUv9fSQQIuBnCJY@lists.infradead.org
X-Gm-Message-State: AOJu0YzQX4Y5g56NsWAf+wbFyz+fzyPo+EYC9Peh27IzZ7Nsbn3SML3M
	Qa9Dl1BkG2b41R/+Z4tryjvxex+amAHeO1GUUGrZjQJcaMwc/VhG07Dx4FDCTkbbM4o=
X-Gm-Gg: AZuq6aJsvnXvL99TvztHP3G7DI5COF+5gqPeWqDR1zbo31o02eIJAbhUoWIfGziz7kn
	ovOKsDDJwCMXA4hsSkDUNN3vFsmnlG9mjk7qGPpelWLUMqCgDZB4HMycg9HxqGFi/iVQ9qx1N0H
	Uq/wb0FzX3IeLVm1WYGM8AQKU39rgVK9U8asI+2eRujlel4SlKDOdW8JkLffZUkmTkZBX+80r9Y
	f+4do4O4xKEECa8mS38Uh3sFxmsxYsbYBtwwERIKA+P4C4iSDswimQZN01FHJBvua3idzMvHE+b
	ym69KckrlU3TiieZGk/MtSs2sDNlDQ1R7aP6LLYDtjoXYrAxjyIR7jno3SX0eKeeqEfHvXyqYlx
	Oww5jibqSxujM2A/MCOEw+86IGtSjnRph8qgJ2smV11O853HnRimHv+zakL3QaoiOTyif598Znp
	ji32L1MCUsq/76GiE3PmgTZt2zY3lXaCD+I06lN4F/MXc=
X-Received: by 2002:a05:600c:8b35:b0:477:af8d:203a with SMTP id 5b1f17b1804b1-48320236695mr244451695e9.27.1770771763806;
        Tue, 10 Feb 2026 17:02:43 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id 5b1f17b1804b1-4835dd20519sm6884795e9.15.2026.02.10.17.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 17:02:42 -0800 (PST)
Date: Tue, 10 Feb 2026 17:02:39 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Randy Jennings <randyj@purestorage.com>
Cc: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Aaron Dailey <adailey@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/14] nvmet/debugfs: Add ctrl uniquifier and random
 values
Message-ID: <20260211010239.GT3729-mkhalfella@purestorage.com>
References: <20260130223531.2478849-1-mkhalfella@purestorage.com>
 <20260130223531.2478849-3-mkhalfella@purestorage.com>
 <CAPpK+O25W1MUoxoa5bSXYpQf248DM7MreCM2y+MOCoY7MCJY0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPpK+O25W1MUoxoa5bSXYpQf248DM7MreCM2y+MOCoY7MCJY0g@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260210_170246_069057_46F13D53 
X-CRM114-Status: UNSURE (   9.90  )
X-CRM114-Notice: Please train this message.
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

On Tue 2026-02-10 16:50:51 -0800, Randy Jennings wrote:
> On Fri, Jan 30, 2026 at 2:36 PM Mohamed Khalfella
> <mkhalfella@purestorage.com> wrote:
> >
> > Export ctrl->random and ctrl->uniquifier as debugfs files under
> Please update to the new names.

Good catch. Done.

