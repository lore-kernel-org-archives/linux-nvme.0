Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E33DEEB572
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Dec 2025 22:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u3gU23GDV6+dVNC72KymJnypOIwrb8GJDySSJNKepbg=; b=0M2Bkw2/T8Tlq24VTJM4/RIofI
	TWiV4iZEnt3Vgc6wn0v5bFrfkPW/x0cbPM3YhhugGICVJEFisruyZEptkqXKZkCtzNumR0bfagsm0
	13NbloSmhx0VyNGKuCH0TD4Yu7OUj8ysGJPjLW4TOwX1s09TPyW6+jLhwIKmC63G7RLmanz9FgOX1
	CytAD6OExVfLHtBW0bSk2JGIbh6cHOysoU9O+uNjG8SmBo/79cFu83k3B4CdlJ99c9x5ipUitawuQ
	U2bQX7ENf1NuY0R5Trhaq3U3bDjxZ06g52SwTEH3Y3BGByp7rgGkXbkklHvE+2q0rxhP/ar3la2z0
	vn+ox9RQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vb4oL-00000006Ooi-0RT6;
	Wed, 31 Dec 2025 22:36:57 +0000
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vb4oI-00000006OoK-2jqa
	for linux-nvme@lists.infradead.org;
	Wed, 31 Dec 2025 22:36:55 +0000
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-2a0b4320665so170356655ad.1
        for <linux-nvme@lists.infradead.org>; Wed, 31 Dec 2025 14:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767220614; x=1767825414; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u3gU23GDV6+dVNC72KymJnypOIwrb8GJDySSJNKepbg=;
        b=fQwh8AoallnijzfNVpKzgOUQ0UPzR/9pc6qadKW7BGiWyc8WU0mNL4mFUSLcWTbk9l
         sWbrRKkSMOAOBkzU1aQiQ7tm4os49WOmai4cxKYNEwupcB+8HdUgQ+Fh4AA8NoO1Q7Ts
         dnNg4KCQeLutjYG0cLpv/BG8SqJrmxQ2pRcX5I+XWgEfUzHhhKzCfPjWL+dnvmJ5IW2L
         XVowLWlqiTmYE2DOD/DsytZ4s6QW+b3StPv86g1CBOdFycGDMrWAKUEN+BWkTdGgv3KL
         QukPt542W++XojFmnFh89SfLwc/cO0UVpH1QdcbvxIxcPXmsklrKcu9YojfAiaXNKizs
         EK2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767220614; x=1767825414;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u3gU23GDV6+dVNC72KymJnypOIwrb8GJDySSJNKepbg=;
        b=meGNTN8J5mv6uBBncItpeh+IkZorxY1CH5CXAxxGLuh2UeHJ7+H2pOaH+L1R97tybD
         L4uu/luDizhYhuJImiATQ9BjCG6TXdtvKNEYPENDToNarZDiYU/BWQ7vJX1vfl7Bdt38
         g9ubjrOwDr4liLp8Pf+7Ypp5aTGugys9Sk7wDHx3Q/M27qw3hKYr3JpODfvQk8tNrnIf
         POoHWVjik4L+nm4gSk7mmCzbSdYAWcd2bkyfhVvLdJ8yOYmTSg/QXkS+tcB+LsriSIhF
         zUnEQ2erw749Vd2TDW2rM1C0MdXjsCuhwSe67B6ap3a1L9aKe9LRqke6MlJsq8YhJh2J
         rjFA==
X-Forwarded-Encrypted: i=1; AJvYcCUIIH2GTvHW15A3XHzlKnXmdOeozE/Go6ZyrQZIuKXySYCOG/IEU7/aCs8re3n5LQNlwwTC9G6HMB65@lists.infradead.org
X-Gm-Message-State: AOJu0Yz5YtupK3H/m33FTvac5AQDuldIwfyloh7wIDOt5wolPnHUcFYg
	P+5bXyjret7pLVo1sWYVAp7TX5n/RwviNCQ2I1gn8WXcctIN4JMidzz9xGUpSCSo5Bw=
X-Gm-Gg: AY/fxX68ymkttlj85MDMjzYZUI1HQEPYHufL30wF23FTAA4B++8zHWMsxf+Y5vxpH8A
	acmfI3BFtpTZARe/dHQkN6n0sDVpsbBegc+7sqbzF/VmLRv8QkSE/3M0fHuvt8a3l1xq7wxItOU
	uZELaJyNr66wu9hOHYYCz/HH3shl2caQL2tSu6JAnqThdsjRwEyLj4oCrRbsGN3eIqi8eJA/xR5
	agJInPa03f6HgGmF+xf4LbGO6LYC/NlaCzIApXGGwGtqrJHgPbRxOh4GP8U8I1I2VngExA2zAht
	TzwnLteepyFn/duDBK8ScZEOH/7VVQeJzCaW7Y59qARpXNuiW2pd/1+VKyq3LUF7ll2mqrm5ow1
	+mrz4FuJL/fOfBltHtjM5Tfy5uLBrkGDcIqPMLdmHggQD/sk0KTDqQMMMiKkcBhssIgiMncxbw7
	rVWlZ+/IzFEsXcnKs8uEm7ouwFcFy9f8o=
X-Google-Smtp-Source: AGHT+IF01BZtUlvGqP79tx0R03jTkM04G1ETZYeE+YhCga5XjK+Zlo49tx0rW2H5KEtSD9ap1LkmCg==
X-Received: by 2002:a05:7022:6722:b0:11d:f464:38b3 with SMTP id a92af1059eb24-121722a9757mr34325025c88.2.1767220613380;
        Wed, 31 Dec 2025 14:36:53 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id a92af1059eb24-121724ddc30sm146308195c88.6.2025.12.31.14.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 14:36:53 -0800 (PST)
Date: Wed, 31 Dec 2025 14:36:52 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	John Meneghini <jmeneghi@redhat.com>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 07/14] nvme: Add RECOVERING nvme controller state
Message-ID: <20251231223652.GM3864520-mkhalfella@purestorage.com>
References: <20251126021250.2583630-1-mkhalfella@purestorage.com>
 <20251126021250.2583630-8-mkhalfella@purestorage.com>
 <e9bb2664-9d96-45f0-a39d-6deaad0829e9@grimberg.me>
 <20251225171709.GA8129-mkhalfella@purestorage.com>
 <f627fab9-9d8b-4a05-b2fd-e951ebb17fba@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f627fab9-9d8b-4a05-b2fd-e951ebb17fba@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251231_143654_702638_B8366251 
X-CRM114-Status: GOOD (  17.59  )
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

On Sat 2025-12-27 11:55:01 +0200, Sagi Grimberg wrote:
> 
> 
> On 25/12/2025 19:17, Mohamed Khalfella wrote:
> > On Thu 2025-12-25 15:29:52 +0200, Sagi Grimberg wrote:
> >>
> >> On 26/11/2025 4:11, Mohamed Khalfella wrote:
> >>> Add NVME_CTRL_RECOVERING as a new controller state to be used when
> >>> impacted controller is being recovered. A LIVE controller enters
> >>> RECOVERING state when an IO error is encountered. While recovering
> >>> inflight IOs will not be canceled if they timeout. These IOs will be
> >>> canceled after recovery finishes. Also, while recovering a controller
> >>> can not be reset or deleted. This is intentional because reset or delete
> >>> will result in canceling inflight IOs. When recovery finishes, the
> >>> impacted controller transitions from RECOVERING state to RESETTING state.
> >>> Reset codepath takes care of queues teardown and inflight requests
> >>> cancellation.
> >> Is RECOVERING really capturing the nature of this state? Maybe RESETTLING?
> >> or QUIESCING?
> > Naming is hard. QUIESCING sounds better, I will renaming it to
> > QUIESCING.
> 
> I actually think that FENCING is probably best to describe what the 
> state is used for...

FENCING is used in HA clusters with persistent reservations. I find it
confusing to use it here. Let me know if you have strong preference.

