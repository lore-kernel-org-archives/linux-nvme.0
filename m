Return-Path: <SRS0=qcAl=45=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6388BC10DCE
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Mar 2020 06:29:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3827020575
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Mar 2020 06:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kVHe8YIY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3827020575
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=rvGEELyTs3iKYIX4f2zsfe3So/2u79e7UlNvbr/U67E=; b=kVHe8YIYqK3sn5mklTf3f7wUq
	UbFFe6hC3mM6qQFbJ5sX7CY2RgZ765frREoL0XwxSqv011yWWutdqQvEjUNF0E9wzWVMs7otoR230
	qyfw0QhHIgPLxQENQO4Igd8rlHJ6WmIefHxl5Syag7LRORbTRs1sxib0PXiaY4bLc/AiOP+iwIJ9/
	QXwDZ3lqrnwsdbSChgyOeqpFhkfgbICxARfOhbNcyPI1CFPEj10VM8XrXYc0Vq+qWNmpbdJ8a0FbD
	9EXBIZGzvTQ0adJ4YeukZqHVBR1Hac90FA1K4JV9N+KdDTlMEFhBRgjqY4Vt4P2gRLK7j8v3ltDG7
	uAZxpj+Uw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jCHLM-0003Nh-1B; Thu, 12 Mar 2020 06:29:20 +0000
Received: from mail-pl1-f180.google.com ([209.85.214.180])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jCHLJ-0003NO-Uo
 for linux-nvme@lists.infradead.org; Thu, 12 Mar 2020 06:29:19 +0000
Received: by mail-pl1-f180.google.com with SMTP id h11so2240832plk.7
 for <linux-nvme@lists.infradead.org>; Wed, 11 Mar 2020 23:29:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7ZZBTpwy5DCCSGOfEQI52YEt8ot3+GPBq1U0zKeqde4=;
 b=Fc563IUWMgYqpK8vlzWd9e8vYOuvY6zS6yYxymg12uF1PbqQ85dose7XbdZ2+nJVrx
 hJRn+SCDA6nvhTFBrHptkEG5hGKzBEZcIBm39JQciOULJrK7rdhXLAPPD6AUnLdFm86z
 MmrzY1sQwERmGfePpzJ7YvsgROTBDEeZGUJhNZCtUwCmEwFJxGAZ6HSCKqsRZJCebC8N
 rCyQU1H0Em69Vrtt4Hng9BMYpEpBKiNw+NGP+fxdYf4Ms6kWxpJ7MJg8qiujj9NSkrVV
 FrjXq13yVJXxS3C59Bs0UGT9Q0Z5gYpOj0t2BFOJY9py8F/7abdywz//1NeTNqAYS2q/
 KLsw==
X-Gm-Message-State: ANhLgQ1UbGp369Hi1EJ9L1eshW0a+QcQAvSoWgwH05iHDKdlppOEvO5I
 Bi1UFs7y5FumhHiUt3sKw2LOvfY4
X-Google-Smtp-Source: ADFU+vtem1PfkIonYw37ggt3S6Kkh/HtY0wGSm7wqFLLz4bq6+Knb2D+COnKgh7RQs9AZGK518X9rA==
X-Received: by 2002:a17:90a:3aee:: with SMTP id
 b101mr2557658pjc.52.1583994556989; 
 Wed, 11 Mar 2020 23:29:16 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:c47a:8519:9343:83b8?
 ([2601:647:4802:9070:c47a:8519:9343:83b8])
 by smtp.gmail.com with ESMTPSA id q21sm55419110pff.105.2020.03.11.23.29.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 11 Mar 2020 23:29:16 -0700 (PDT)
Subject: Re: Sighting: Use of 'disable_sqflow' option shows drastic reduced
 I/O rate for small Queue Depths
To: "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <CY4PR11MB1351F4B992E207DCFD610FE6E5FE0@CY4PR11MB1351.namprd11.prod.outlook.com>
 <79eb6f31-1c65-7920-5e66-8ee9a6e81aae@grimberg.me>
 <CY4PR11MB1351F639D6B6582D5EEBA74DE5FE0@CY4PR11MB1351.namprd11.prod.outlook.com>
 <7ad247fc-4c42-2712-c324-d257505eb0d0@grimberg.me>
 <5732ea78-3b36-890d-70b8-e91edbebae47@grimberg.me>
 <CY4PR11MB13510BE7F01EC5B803E6DA56E5FD0@CY4PR11MB1351.namprd11.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <33277ae2-d55c-dc02-8993-08231178135b@grimberg.me>
Date: Wed, 11 Mar 2020 23:29:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CY4PR11MB13510BE7F01EC5B803E6DA56E5FD0@CY4PR11MB1351.namprd11.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200311_232917_996635_57989CBE 
X-CRM114-Status: GOOD (  13.81  )
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


> Yes, I modified the 'if' conditions a bit and testing does not show need for setting MSG_EOR.
> 
> New if condition used:
> +               if (cmd->wbytes_done + left < cmd->req.transfer_len ||   /* more data in this xfer to send */
> +                       !queue->nvme_sq.sqhd_disabled || /* then a response frame is coming */
> +                       (!last_in_batch && cmd->queue->send_list_len))  /* more requests to process in this batch window */
> +                       flags |= MSG_MORE;
> 
> For queue depth = 1 at times I will still see IOPS rate dip below the high but recover quickly.  And I do not see this on every run.  And it seems to be more frequent when testing a ramdisk, not a real nvme device.  But for the most part this greatly improves the original issue I reported.

Thanks, sent a patch for this.

For the short dip you see at times, does it happen when you
use sync/pvsync2 io engines?

Maybe this could be related to some NIC effects like adaptive moderation 
or LRO?

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
