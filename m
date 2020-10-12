Return-Path: <SRS0=YdFy=DT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAAE0C43457
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Oct 2020 16:53:42 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88AFB2080A
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Oct 2020 16:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="h9eDqbF3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kz3byLEj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88AFB2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=lSOVP+Q3FLQk8ewIugRgw9lUB5JjVoWdhxftSIbjXM8=; b=h9eDqbF3I9iCPgCbByYiFAJBz
	mS/Zcx83dzQ/Rvh5dyk7sFALGiz51NLeiNllXvxFjkml8t2Ra55g5NcNMKYbgrZpyyxzAdT3cTDCY
	ULhqfB2QeaaJYY80nbHBEE6dnRA7VIV53vvHrwKpbvgs84zUOE854HJMMJsK5VAwcTJXlvqFQxhSd
	lWkyNTpq8XslfT8qIWzqkgVqS6NH1sYbCOYZQdfTrBL4LQPpOavUeVKtFRvG4y1im4RPf1/tvT297
	xEsyfYeqYXuOVcEeggMr07PqKtQUYvf6I3TadgZYEg8mThxVHiBa5KHqLrZeipnrfw5QC7b72EbWB
	9pSGztUyg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kS14s-00018m-Aj; Mon, 12 Oct 2020 16:53:38 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kS14q-00018I-O0
 for linux-nvme@merlin.infradead.org; Mon, 12 Oct 2020 16:53:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=0xPKHcc8MTxN9G6km2QTOKG69v7B4xiLbgAzISFd/e0=; b=kz3byLEjQRbXUjKEwxSctQX5ib
 JSA+qNZHtA9aewEXAvoV2M3/g5ArH8yJiAAE/kke62YDaHPl5o3/+xMrd/i+waTWdk3FhLyFNeYuc
 4Nk7+Bj9BYXz1xAwd03P2XqWJ4u6gF0YTzxkwS+nNCJwrPuiM7tYRinTk9MOFt20vbPG0TllKA7E7
 FUnU7I/afnKhT4pPw79tju4VhbduW2vl13IeqsRBdekOuYvNqMsrEYykSyc7jGqRQHVc5tHH6aPY+
 3213WdwwwrFYELr6mggaHw1E8IyEoal3f+Bv/YjhibFGCElAxvPsPRtwNZbUqKeJg0h3VUzn9VsZs
 n9KroRrg==;
Received: from [2601:1c0:6280:3f0::507c]
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kS14o-0005Ww-Nr; Mon, 12 Oct 2020 16:53:35 +0000
Subject: Re: [PATCH v2 21/22] mpool: add documentation
To: Nabeel M Mohamed <nmeeramohide@micron.com>, linux-kernel@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-mm@kvack.org, linux-nvdimm@lists.01.org
References: <20201012162736.65241-1-nmeeramohide@micron.com>
 <20201012162736.65241-22-nmeeramohide@micron.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <57fef732-f63d-9c9c-e368-660c654a7438@infradead.org>
Date: Mon, 12 Oct 2020 09:53:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201012162736.65241-22-nmeeramohide@micron.com>
Content-Language: en-US
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
Cc: plabat@micron.com, smoyer@micron.com, jgroves@micron.com,
 gbecker@micron.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> diff --git a/drivers/mpool/mpool-locking.rst b/drivers/mpool/mpool-locking.rst
> new file mode 100644
> index 000000000000..6a5da727f2fb
> --- /dev/null
> +++ b/drivers/mpool/mpool-locking.rst
> @@ -0,0 +1,90 @@

> +Object Layout Reference Counts
> +------------------------------
> +
> +The reference counts for an object layout (eld_ref) are protected
> +by mmi_co_lock or mmi_uc_lock of the object's MDC dependiing upon

                                                     depending

> +which tree it is in at the time of acquisition.

-- 
~Randy


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
