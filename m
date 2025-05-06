Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59173C3ABC7
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 03:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yMIauxUIuW+HoqF685ItcdozcY2TEvm8DOxp+4JrKME=; b=hkUN0+5yoLQfds1QurtPZSVSN6
	7YYrpnlfpQRJx+cbg3GBo894b+9grl4Mx2fv34xL1KUznwsFPbZDablIQSQP5vsW1Ouxj96rck66D
	FRp+B611K2enNlT9MfpgwZ6URenC8D+hDbx4XqO1Df2pglSgedKXUjRYxPQixyEkl/BvaFjnoKPLs
	gOavinT5NURv43E7dhBf1pXWlqejZ9g2v1buxdzU9ZNyOTAkqrQgNF7tr+cpaPrfmp6Ya5QOZwn1Z
	/tW7au5LFFTfPYyfmR8zgQ55k2dUfgSY2EiAnG0DoNrNYGls4gvREC6Eh0UsCgGlCHSthyRc1fFd5
	5/qFJHpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCVju-0000000E754-2GkV;
	Wed, 07 May 2025 03:46:34 +0000
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCQ73-0000000DT23-28Q2
	for linux-nvme@lists.infradead.org;
	Tue, 06 May 2025 21:46:08 +0000
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-72d3b48d2ffso6667812b3a.2
        for <linux-nvme@lists.infradead.org>; Tue, 06 May 2025 14:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1746567964; x=1747172764; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yMIauxUIuW+HoqF685ItcdozcY2TEvm8DOxp+4JrKME=;
        b=Ra16hTFAxa0jln9hTeJYPfoecEARRazww9kmc5E+eF/ySxN5pUNOpaZXIWlbrikcA8
         R74LMgl+Lr66tasQojqffwgq5y/7ATvbMXAwk0hvhyH/0kgWUtqQd94XCQm0MYbgfdAQ
         ojnAqf+sRjrwBdgSwyruEAVmubWfuXTA6NZUxIxA2J8VXXviT/eiWel8S9c0l7wfk7Tj
         ebE68ywjXS24ZMslYJDlMXcx5esXi/woB+QWRVUw7/PlV85w5uxKJyn4MCSXyA4px6MQ
         JzG+XlgrUtAKz5LXDxdESUxZX9EF6EiKz6EM97bYzNeXJA8DxbJXdkQOXSn2/GdEOzQi
         gKAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746567964; x=1747172764;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yMIauxUIuW+HoqF685ItcdozcY2TEvm8DOxp+4JrKME=;
        b=wRK1tfzz6uojIH71ER7Uk8CX/iUjnEoXcATAd0Edz4uD9MA/cQSRtgNmkqxBE7+OlE
         n2VjoTJvfIg8NcP+R1aRkNjBfuuIXXH1SyejX6AY1wMIk/2/5uQlJXgZ2WWZEUs0WNpS
         puhLCu4+Eq/TXckq9wxcCsMqNWLvKehWdOtMWMonnRsCAPREk4jrv59JJUzlN0cTOYXw
         nmwVru4it7Ky0H+zD6k23yhyafM656CHe5+QbtZ2eciyYben7xpgzZCpQKCKR+Nr2u+F
         S8UGinYa91rhiTXn3xHcXbpgNsYpSgeOL9F/i676SinoWO40FyXGgJDDsKCmD3MtlzGw
         OxNg==
X-Forwarded-Encrypted: i=1; AJvYcCVqos1KndHET+ULDiNBcevBOHrmo9tmUa3ssQZIPmfdDi2paWhICxwfxaChGHl4ZJAEA+kZvRuFyUM0@lists.infradead.org
X-Gm-Message-State: AOJu0YxwoXlQ70hkPP4Nh85g1kgH+SRvbZyx45kBo6OAmW9dQpmdvQ72
	lkGvooDH/uqrIcevk+J6jZKQVMZ4WB75sIy47Sy73OowXYj6Rcn0brtrUKMeVOM=
X-Gm-Gg: ASbGnctpUX1uLf54+WxNc8kEJtwJ0ji/M939CBiUsFJbBUyQAixfeMqtsUfsz996KXn
	6LpRhKd64bEpp4VeBmH6O9MiFywWzhXRg9cHXh112mVBUCkXmcEoOF6EaicV+pQwSxo14vgrdG1
	hezErzUw96RKoyF0QcEhAiqNKFtBonejam9A6ZLefWDHJjux3jVib87O9MFTw/N7TFUlmLW+nVL
	98F1dZi9FInWjAMASdEw2DU9ZtTDND7IVquLpAgZN94GXiAwda9rs1xCLTQD7m4Uq7OhxCjG1Wi
	nYlQys+g8r0N2EopUXcO4qKqch7BXrxhKaBciuzAiMbiSmHMcGNQpTKHDoplTHOc94YhXZymK1F
	puToQYdscbKbr6w==
X-Google-Smtp-Source: AGHT+IEDv1UiP/xCxZrA1w8m+KQBBlf4+RMLlDiU6bPNRxHPNwXX75ish2am3Kh1zQ+4fNgAJNLx6A==
X-Received: by 2002:a05:6a20:9e49:b0:203:becd:f98c with SMTP id adf61e73a8af0-2148bc12e8cmr1101048637.13.1746567964591;
        Tue, 06 May 2025 14:46:04 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-60-96.pa.nsw.optusnet.com.au. [49.181.60.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-740590a463fsm9917368b3a.173.2025.05.06.14.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 14:46:04 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1uCQ6z-00000000GTQ-0jbm;
	Wed, 07 May 2025 07:46:01 +1000
Date: Wed, 7 May 2025 07:46:01 +1000
From: Dave Chinner <david@fromorbit.com>
To: Anton Gavriliuk <antosha20xx@gmail.com>
Cc: Laurence Oberman <loberman@redhat.com>, linux-nvme@lists.infradead.org,
	linux-xfs@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: Sequential read from NVMe/XFS twice slower on Fedora 42 than on
 Rocky 9.5
Message-ID: <aBqDGY1i3RePyzaB@dread.disaster.area>
References: <CAAiJnjoo0--yp47UKZhbu8sNSZN6DZ-QzmZBMmtr1oC=fOOgAQ@mail.gmail.com>
 <aBaVsli2AKbIa4We@dread.disaster.area>
 <CAAiJnjor+=Zn62n09f-aJw2amX2wxQOb-2TB3rea9wDCU7ONoA@mail.gmail.com>
 <aBfhDQ6lAPmn81j0@dread.disaster.area>
 <7c33f38a52ccff8b94f20c0714b60b61b061ad58.camel@redhat.com>
 <a1f322ab801e7f7037951578d289c5d18c6adc4d.camel@redhat.com>
 <aBlCDTm-grqM4WtY@dread.disaster.area>
 <CAAiJnjo87CEeFrkHbXtQM-=+K9M8uEpythLthWTwM_-i4HMA_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAiJnjo87CEeFrkHbXtQM-=+K9M8uEpythLthWTwM_-i4HMA_Q@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250506_144605_734337_ECF92F79 
X-CRM114-Status: GOOD (  12.66  )
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

On Tue, May 06, 2025 at 02:03:37PM +0300, Anton Gavriliuk wrote:
> > So is this MD chunk size related? i.e. what is the chunk size
> > the MD device? Is it smaller than the IO size (256kB) or larger?
> > Does the regression go away if the chunk size matches the IO size,
> > or if the IO size vs chunk size relationship is reversed?
> 
> According to the output below, the chunk size is 512K,

Ok.

`iostat -dxm 5` output during the fio run on both kernels will give
us some indication of the differences in IO patterns, queue depths,
etc.

Silly question: if you use DM to create the same RAID 0 array
with a dm table such as:

0 75011629056 striped 12 1024 /dev/nvme7n1 0 /dev/nvme0n1 0 ....  /dev/nvme12n1 0

to create a similar 38TB raid 0 array, do you see the same perf
degradation?

-Dave.
-- 
Dave Chinner
david@fromorbit.com

