Return-Path: <SRS0=HgRT=5J=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA90CC43331
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Mar 2020 01:29:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B10620714
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Mar 2020 01:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mY64UZfW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B10620714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=pM6RYRfLR/gAyOUm0KTCsaNyCRLXrf3Sa5hX77iMEYU=; b=mY64UZfWpwIWiwic0pigKvITg
	M/Q+p958I4PvwrjTUbCcwegtSyz8iQuJ8OtRepcpQhocHWwA6gWdD80QsSp5Pfq0wKA9hFY0BASue
	WGzZ9hdyH4o3hBrWsrOmAM3MjXTiCmkT0KSTq0oH03/Cj6Frum1NEU6CL0L3SiT6O49VoKDJWL3FD
	7i0cMRnJrlMJGxzGGapdXIL2pzXHZ64uhrPeRXil64XirNQkPopG4vEDUUGRr62HfXXwiDmOjsQcI
	ekymqfqdiFX9txw16jD+U1uN8qjGgQFaHPcp0MSCYVkrDvpREJEDSOOmKjZnB8U3UpybVZXQAuRV5
	cz2s/ccNw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jGYNc-0006ZJ-7T; Tue, 24 Mar 2020 01:29:20 +0000
Received: from mail-pf1-f196.google.com ([209.85.210.196])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jGYNZ-0006YO-64
 for linux-nvme@lists.infradead.org; Tue, 24 Mar 2020 01:29:18 +0000
Received: by mail-pf1-f196.google.com with SMTP id 22so4845969pfa.9
 for <linux-nvme@lists.infradead.org>; Mon, 23 Mar 2020 18:29:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZziEUme0PDJBjt+guxhWPG+yCw4m0lOA8w23VrQ3wxU=;
 b=EPrFsx9/chxCBTCqMUe2mTGok0QliL5YMw1grGi6nwLUJHuiRW/pIHNTUAdnSB9Osz
 GMqXiBJsV/BQmxq3aD1tQEEW3OfTuP8z0T/D2d4FBXWkdi6LbdV3kSoa1MijdpJH+qcR
 DkFmc4vuLQeHfBcWawwueiB4RYb2+vldVsdbEDCKt2Z7kSivn7p/iju5k4InIUgCNBbt
 xqz+hHHPfX/K0zABN9GM7yo2rlwpVlCXdRNWZRNOok4SNjXo86JQwHNNHCHWgAF8MFGa
 GmgUsMf1pEOeZ1JdQd4S1Sr653BvyNTkduOVAOLhh0dFyeO6BLLv3/zdKJ7XcIyXeSQw
 ZlDw==
X-Gm-Message-State: ANhLgQ2WjQeteC3qRtqpwc9nfxC+2g+m1OTz1KYekxAt8jQws3SQPBk4
 +G/pgKdu9s7/clPEZDvxHK81rK4L
X-Google-Smtp-Source: ADFU+vuxW9Wk2LMIifiN4rJV84enCRw4AlNQqIj03QqmHOQzSy170E4mASTBmI58P+rX8Zw6WEDT1A==
X-Received: by 2002:aa7:998e:: with SMTP id k14mr26578901pfh.313.1585013354594; 
 Mon, 23 Mar 2020 18:29:14 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:45a4:15de:f2dc:1149?
 ([2601:647:4802:9070:45a4:15de:f2dc:1149])
 by smtp.gmail.com with ESMTPSA id j4sm14441530pfg.133.2020.03.23.18.29.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 23 Mar 2020 18:29:13 -0700 (PDT)
Subject: Re: Sighting: Kernel fault with large write (512k) and io_uring
To: "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <MW3PR11MB4684AEE8587BFCC0A9F41DE4E5F70@MW3PR11MB4684.namprd11.prod.outlook.com>
 <4eaa3e21-833d-f6ec-3b14-58dd2022a381@grimberg.me>
 <MW3PR11MB4684AC746EE60B9E5D0D46E1E5F00@MW3PR11MB4684.namprd11.prod.outlook.com>
 <82255be7-fb89-c66c-442e-6fe04239768c@grimberg.me>
 <52ce2f94-e11b-c537-63d2-e9b72cf1b00c@grimberg.me>
 <MW3PR11MB46844ED6C11993D7F5D911A8E5F00@MW3PR11MB4684.namprd11.prod.outlook.com>
 <092f6922-ab29-c2bc-04b8-0d0c95c14ad6@grimberg.me>
 <MW3PR11MB4684FD29002D6D1FE29A4A0FE5F00@MW3PR11MB4684.namprd11.prod.outlook.com>
 <2f68591c-d2f1-f632-644c-11de97511a45@grimberg.me>
 <MW3PR11MB46845357C4C1651D1C24CEBBE5F00@MW3PR11MB4684.namprd11.prod.outlook.com>
 <112775b2-ef19-7e8c-630c-22bc529536cf@grimberg.me>
 <MW3PR11MB4684610CA3A664EA62EE7780E5F10@MW3PR11MB4684.namprd11.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e9a4b2c7-5dec-296d-be6c-880afa8869c3@grimberg.me>
Date: Mon, 23 Mar 2020 18:29:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <MW3PR11MB4684610CA3A664EA62EE7780E5F10@MW3PR11MB4684.namprd11.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200323_182917_226372_13B03AFA 
X-CRM114-Status: GOOD (  10.18  )
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
Cc: Jens Axboe <axboe@kernel.dk>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> Does the I/O timeout only happens when you run polling mode (hipri)? Or does it happen for non-polling I/O as well?
> 
> So far have not seen a failure with io_uring (not setting hipri) or using libaio for same I/O pattern.  Only when hipri is set have I been able to reproduce the recovery failure.

This also reproduces without the POLLING patch correct?

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
