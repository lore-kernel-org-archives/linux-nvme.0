Return-Path: <SRS0=B4mB=DH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1400CC4727D
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Sep 2020 00:13:42 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B53E20739
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Sep 2020 00:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="n/6z3nry";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HKVw5IB0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B53E20739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9DBOg6aMh0e40vXTb5vqc9cZ5qYg1LUs2+2WYGXBIyg=; b=n/6z3nryCgmpcxM/KAOkzrfio
	pgREFDDNLIlcVZmj/ifu71Wa7TrgpsND/D8PI8CnINfrnEPrOs4WvOG8Wwi8WY6XcLBPVATnYT3pA
	6Yzp3Q8EHGsSOTrvAhUC6vHA9k16WO7dHqndWbSsyrSIW5Q/bgoByM7bIXnZ1scUzh4WsNajWDLuL
	ujKRKb/HZRUktSznNgfFjBT7B1zuzJh/w3w+Xbg5mLyVjgp2etRYdnvPXtEcJ6lBHuEqcrY7/XfOR
	QJZ3TfoHYa7ku2u2QkFezsMn0Hl4iyE8/nfZv91Dntmor9XNf2ELY1BoijFOl10lJktNe1KeTbabL
	oZ74J1Vrw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNPkX-0002Br-EF; Wed, 30 Sep 2020 00:13:37 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNPkV-0002Be-JC
 for linux-nvme@merlin.infradead.org; Wed, 30 Sep 2020 00:13:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=TahisG6kUDutXipbSb0V03+wLD+q13trx54ypaJdagw=; b=HKVw5IB0hKYct1Uuw5lklIVCpV
 xIZbt6VpLzXCuKp7AVdtX3indQiObrAjXZK2OA8P24B1NiVEZW/A/CW8G4xmiCSFCIEycEXrpEouN
 GS+AB1Cvtoj7VsWfmOjT+KRdFl+s3HxVZIg3Ny93a9/ZezVvUVePIQz6ShtlqxRWhw9HdQHTCxaHC
 WnUrWMAuzc91jJ+MwsUgE48yut+uFo9chQM+Kt4w8H4qaQaPyWn1RHEoamyd/j3qtSaqgvukDYnr1
 vZDU2UeFKGWnuXF3hFi3G7/P6Bxhpyj558Ww/GKzSFZ1GQUuoh+irzDyWYnFTf5XArKfOGcgvQ0nF
 KKG3rqIw==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNPkS-0000MO-Un; Wed, 30 Sep 2020 00:13:33 +0000
Subject: Re: [PATCH 17/22] mpool: add mpool lifecycle management ioctls
To: nmeeramohide@micron.com, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-mm@kvack.org, linux-nvdimm@lists.01.org
References: <20200928164534.48203-1-nmeeramohide@micron.com>
 <20200928164534.48203-18-nmeeramohide@micron.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <43f24e68-2625-36ce-1727-fcf981955b17@infradead.org>
Date: Tue, 29 Sep 2020 17:13:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200928164534.48203-18-nmeeramohide@micron.com>
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

On 9/28/20 9:45 AM, nmeeramohide@micron.com wrote:
> +	if (_IOC_TYPE(cmd) != MPIOC_MAGIC)
Hi,

MPIOC_MAGIC is defined in patch 01/22.
It should also be added to Documentation/userspace-api/ioctl/ioctl-number.rst.


thanks.
-- 
~Randy


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
