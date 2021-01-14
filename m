Return-Path: <SRS0=kiw1=GR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCBCC433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 23:05:45 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B7B723A5C
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 23:05:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B7B723A5C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=GsACpdXMlwfJmA0eF07MxoiGPUWVLL6jRgKaVhyjwqY=; b=xXYMEev7pFQpeRgeGY4GVJ24V
	UYbEaxrAYaAZq4rr5t3tAQUYILEbwiO5pO2v3+n8aRhqdZrH+f9ibVEM/9Jh2hjbqPdSQNBkllPh2
	ClBfRGvKk9LTkQoumw8+IG6sGTRdnjdbQ896/eUukD9jTa1j7LdQuugxaHfQPzIQItgPTqADCa/cy
	O907ew8U97By9Ln9uJQIrwDUoCGYkNQOsEQPkjsV1Dkb07FXZzRp9xcZA5s4sxa01/y1J8VnEZcIP
	PKVwRduubLgxZ/73KGDG3xQ+QE0c4tWvm+F7SFWz2f1lXwa9dOWc/fjT+qLM++eCzrbJ8TD7t4sDm
	B1MwO5Sbw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l0BgL-0004bB-Ic; Thu, 14 Jan 2021 23:05:33 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l0BgI-0004ap-C5
 for linux-nvme@lists.infradead.org; Thu, 14 Jan 2021 23:05:31 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1057D23A59;
 Thu, 14 Jan 2021 23:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610665529;
 bh=Yhj2nP5cNNBUP3HWJRTODjzAYMKKSmP65QfONrT7Gy8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pKB7B1lEbpaJpPw/eSVmk+Rw0zy3EVJ6dfDEeVBWWn2QBcERnKp4//P5Ti9LX44ZL
 moAo1UpvkQxXKJoTeLa9E4NW4r8EQzQ5z9vla4MHl0fKM4w+KSn7IeGMmjlJjDh4qh
 2LaCgeXMZMm5CBCfs0SznRiS3pGOzwBpO5J+PX6HjXMTJtX7lAu0hKQAbCj51iyKPg
 DQYNe59MbasjGjH46xPip8STkTSyEXaJRiqt1IazUqOz+jSpsg9lL/Ic0JRYWYbdiU
 3s+deiby+5sphJ+LSjfn0IroVu9zfH5X2y3NwG0L+aL6F/YCRF0Kzs7f/LDuuve7H4
 D7/wyRFc9aHlw==
Date: Thu, 14 Jan 2021 15:05:27 -0800
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH V4 1/4] nvmet: set right status on error in id-ns handler
Message-ID: <20210114230527.GD1511902@dhcp-10-100-145-180.wdc.com>
References: <20210114013354.33946-1-chaitanya.kulkarni@wdc.com>
 <20210114013354.33946-2-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210114013354.33946-2-chaitanya.kulkarni@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210114_180530_483352_6823695B 
X-CRM114-Status: UNSURE (   5.57  )
X-CRM114-Notice: Please train this message.
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
Cc: hch@lst.de, linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Patch looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
