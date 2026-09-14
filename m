Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89FDBC88E6F
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Sep 2026 18:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m63TafUNT795XVWKUbjyGBW9D5PHRKi6O8/rAEmzyG8=; b=VJedZTkIDav99hv5HOEe8Ag2sf
	VrBLkxd/HkKx83wlJOeytXXNcPU2Ey6QNA+ZYGqjJnvd2aBqmNVHifa7uGiWuvgyt42nI3CcDSrTZ
	3Qd6haHT1TP7EQzQDa22j10CLZE4Eq0tI6tuGPBrif1bNKQuqjL4/lBxbmSvF7Z9p9IgfFkKC8IyZ
	/dSLyESAd4rqVNtp9qm/P4uxNBE8gThQ5yOdN3mbXQAKLSstFOWIx9Kh+QEQhkCpZwKCetAuuPgtt
	QQcjSHaQRnONhYmpnFSMVXZhkvpjfQ3Idui4XewEIRf3TTnwEVYGEA6vHDy7Sr9/Px4ba9Ulih8+3
	jtRleCMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6Bqv-00000004Uki-1BWP;
	Mon, 14 Sep 2026 18:56:29 +0000
Received: from mail-vs2-x20.google.com ([2a00:1450:4864:3a::20])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6Bqq-00000004UkL-0llF
	for linux-nvme@lists.infradead.org;
	Mon, 14 Sep 2026 18:56:28 +0000
Received: by mail-vs2-x20.google.com with SMTP id 71dfb90a1353d-5c9031e714dso767526e0c.3
        for <linux-nvme@lists.infradead.org>; Mon, 14 Sep 2026 11:56:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789412182; cv=none;
        d=google.com; s=arc-20260327;
        b=cZs/BFT6IbkwsAB69EaKX2f9BMddgrk1twMKKIwsb0KVxLzSaxAeMiiLNtLBC/NHAV
         t5Yu0uDmlGWPoe7AWOdkR56Z3PD+ajwECqHuVLYn6hR65bXtH9A06tjehoUNx+rVmXxA
         5Zn1/WBMIQqnIsK7FTZJoDAOjoqY3dl21CPbg/ZE3kXpS4qSTCoS+uuv4k6jfjcgbSXH
         jtXA6js0A4LJ4IN9q/ccJ6mHv3oEfgpg9U5aB8ZC2h6Pt6XBkyCwqaA6GExZg9EYvwfz
         AmW7FfPJqW7QrfGLC27Q9dtcI7SZaDitedj7R1EJizHODYSTOHVeVtQ4pdihxLvU2v3D
         Hx0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=m63TafUNT795XVWKUbjyGBW9D5PHRKi6O8/rAEmzyG8=;
        fh=6m6oSIGenx+jpWcrbxfLLVtlll7MMO42rWB8ab4UKfM=;
        b=Q1uxxVdsUEzqfmZJknHUWkgb73v+ggQtajoNgcgJO2YaChcl313Fc4PeufQGj3Ebh3
         Pyde7sUt9yS3Anlibx/ejvv5NWTpB6qYHJVl+pLq6zparjjVLJD9fZhu8HGAgeDKcAah
         iOQG3OuauZ4v0yLK6CCl4SWBhnDoV8Q7qbs40ePvoDX6QE3I6qZuSHQVErtrLm6vJ6OC
         4tRpHsxAtK/38wIa93W311wgkQ160/oHHgHn1XBlbtCrPh/gSnOC8cCng6uQ52qpSEBv
         wadACyw39nW06UDNyW+RcfBv9YKG5iCFnuTBHt8V9abeSnz+xIQKBimyyxuGqU/X9Jn5
         sfHA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1789412182; x=1790016982; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m63TafUNT795XVWKUbjyGBW9D5PHRKi6O8/rAEmzyG8=;
        b=ePlsNgAJIR2Y0WgwTkG1Ps8W2VZy2lQmKM9bruNTFQXT3Pd5ryblX/PC+JD3WlLRi+
         cMo/CT3naT5zWHUIwwQKOI3rzaxM7RJhDLpabMiN3SFaaaRbXX+f5oV84UT4slEY5co+
         dmPQQeWzR+FOEeRlIQu3t4zQqMTzS0QKAMrx3am5tz4AlCLyvZV3dP1fDFimsbRHkOYf
         m8PlNeIKe/mC9xyc7jxDz2IbLyoeCeXl2g1PJ45fhySzxMMF+r5istQUoDOF3AkBAWHi
         9QeXaipxyoY8cMSUHRVlrjHrVGjYxXH6knUfZiAMhPCoMCtuMip6O0xxr3ZrALLIRkpX
         w+Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789412182; x=1790016982;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=m63TafUNT795XVWKUbjyGBW9D5PHRKi6O8/rAEmzyG8=;
        b=TnkrOL9zJ5Jv4lg9Z0ZyXMIMWZUMFwi5PrjX1oROjU07L0Jsf3A6uBLGMuDpQ/owws
         C1ul73VfGOTJ8vy9FFh6x9jCJlw7cJ7CnjcUA62PfaDzLf8vNuyZuq2QFjo+FNOOfPqP
         8dD2xBH5A/Gm5OeVUXHMZPmp0ky7hTNKyuGNnuL2HyTkIUCfb1zZnY83NTaQ0hcKQHn7
         ASgiYiTVg2CgKvUQN1/aeWsMp7GQPsEJRler4LVIxgSgPL/AgE5Hpzncw0sQDmczwbBW
         0HDLRCKDLxAQPkt0KWp2C7El/p8z6FzJpY9IBNeFeZJlLGefweOQyhWXcK8Kw8EM/s1r
         xRnw==
X-Forwarded-Encrypted: i=1; AKwUvBz12Zt7liz9K20biqizo4fF67VDM6A+7OU7YY3Qc4ILT1ygldROu8zIXyiRx+Tkc0eTln07ML3uru/b@lists.infradead.org
X-Gm-Message-State: AFuF++nSryEHI1AvOFQGSyf6YRMS/xRVtwOikqyZVBkCynwQNruLIYdO
	zj1+8x44RCpC/+hOEvnCQGqnsu1p9PPEkqldKpn529i/oy7ib2g2XObiY4Jf11XmlKh/um6XoE+
	FIIAy2NaA4S4+aAmEQxlN89zA7GBt5J7958oOcns6BA==
X-Gm-Gg: AYBFou0NJfRqk4TxRb77GczQAcRC3UtoZt910h6qRE0X5P6ca0mi7E9TIHUiKGEbKfl
	ir0PcY0h0+RNCy7mcwPPttnLDxM/5PIGyU7NFf8+Bv8Pq7q/d8Wb8c3RBKeeCIQgzyZME+xW1B+
	l3mw22E+IYoXwd3VAUpdIoP7/8mKZ37w/VHpQqdOdwKtoHbkztR+7zK4IZxdXt2jgGfkUBavnfe
	KsNXQZX4ai1CnvUx6E1diVsQSHaBxutqGG2zaRA3fVexH7iEs0cwl9L2t3RR688hgRajFnzb32R
	K5wWnAiQGu2q+I8C6hrpQAi5EhwbfUEW3ZmXvj9kTWGTQIPBODaIv6Zd5EVwoBbSfkTUEyXXVNF
	Kg8kCxa6Gz3UNcDdBjMkP4CYxCziivt/OX4np6b5G
X-Received: by 2002:a05:6123:6e:b0:5c8:fa1e:9f5b with SMTP id
 71dfb90a1353d-5c981ad6e72mr5546450e0c.2.1789412181954; Mon, 14 Sep 2026
 11:56:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260815173502.1185929-1-nilay@linux.ibm.com> <f0215fbb-0e96-48de-8c6c-dd391fcf1d56@grimberg.me>
 <8ecbc5aa-0a5d-4780-9c34-bf433f5e6221@linux.ibm.com> <2a03f032-3fed-454c-a960-ac332b4c3fed@grimberg.me>
 <77d16701-c829-4fd7-bc4f-8fb51138d9d6@linux.ibm.com> <e6397f5d-b565-4219-95ed-4ace5f23c37d@suse.de>
 <CAPpK+O1QZKcab57unB2AsSMpPXHNVNHGarAXba4vvfYjm92=2g@mail.gmail.com> <3231383b-1383-4d24-bb04-6b348f8d04cd@grimberg.me>
In-Reply-To: <3231383b-1383-4d24-bb04-6b348f8d04cd@grimberg.me>
From: Randy Jennings <randyj@purestorage.com>
Date: Mon, 14 Sep 2026 11:56:08 -0700
X-Gm-Features: AcwNN1XaeLBFBER1dZRR6bdUo3hGdIRI7ksUSQds-yhN3LW1eDaIIDzDBoakWBY
Message-ID: <CAPpK+O3MxAQycemvXkfWK=95OzpJ-OjAfpsCX8djwxoxutHVyg@mail.gmail.com>
Subject: Re: [PATCH v8 00/10] nvme-multipath: introduce latency I/O policy
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Hannes Reinecke <hare@suse.de>, Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org, 
	kbusch@kernel.org, hch@lst.de, dwagner@suse.de, kanie@linux.alibaba.com, 
	jmeneghi@redhat.com, martin.petersen@oracle.com, john.g.garry@oracle.com, 
	gjoyce@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260914_115624_229625_1E936C7C 
X-CRM114-Status: GOOD (  14.39  )
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

> Randy, would it be possible for you folks to evaluate it as well? I will ask
> some folks on our side as well. I'm concerned that Nilay is the only one who
> has evaluated it in his lab.
Yes, absolutely, but there is going to be a time delay due to wrapping up
some current priorities.  I'd say we'd get to it in more than 2 months but
less than 6.  That is the best promise I can give right now.  (Yes, it is
behind some work for stretched subsystems and CCR/CQT, which are
higher priorities for me.)

> Overall, I am perfectly fine with the approach this path selector is
> taking, but I worry
> that we are growing path-selectors that are slightly different in subtle
> ways...
Agreed.

> TBH, I still don't understand what use-cases this path selector is more
> appropriate than queue-depth, or vice-versa.
I had this question, too, and we talked about it in Zagreb.  My
understanding from that discussion is that latency can handle
full queues better than queue-depth.  When you have shallow
queues, you still get information to make a path decision on.

Sincerely,
Randy Jennings

