Return-Path: <SRS0=IcOG=JL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 277B2C433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Apr 2021 16:29:00 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAE3C6113B
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Apr 2021 16:28:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAE3C6113B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=cezjFKcHQquDbz9hxA7xuKE8uWjFLfdqXMF/GWNNNjs=; b=govBMANrnAaPRmOdDk5VJQNEO
	h3ooqSoVfttUO03G8DDhTwh0MfWD5wMCHQHzkQ4PSIlQph1ANdL+jW+7CozKg0DMBvwsTTWllq5kI
	+iLZzcvnnMa7f5lSk+58aJh5cQ4YWzwRL0LZaIo9MUSLzkOLBQEng3vmHAmmmwLoYEoNcZnfh3oUi
	kMYvcz3kV5nLi92VynkCjA8CI3brVxs/VZqu38dItVsdCprrvk1OX9pCPKTpyieXwZdevfqhaoF/Z
	cRy+odK/Lww55FaAiA8ihjOBP2CY7whCiNQvdxn5HxQ3oDjMFOOwLPHIGCQobsA5pplCpQ4odrdq3
	K0Nt/wZpQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lWiNT-00D8du-0Q; Wed, 14 Apr 2021 16:28:31 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWiNQ-00D8cx-Cd
 for linux-nvme@desiato.infradead.org; Wed, 14 Apr 2021 16:28:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:Cc:To:Subject:Message-ID
 :Date:From:In-Reply-To:References:MIME-Version:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=toGm6Agv5lwh7MH98M2iHvOjaQjMPEy/P204OuACMG0=; b=CVZEQ/CU5afL40nQZOfWpH6dkn
 UopjLMxUbR9Q5YjaafP/RF5LvrA9qhg0nFIGams3kn4VE7b994/JY5hVl+S7X/ekCLbDVucytQ2SG
 UEsx5wWtVBVE//4ShMfTzXjBKJSubaNzqBlKMlHEZerw4X9tTsc4FaD+/UeUEqbcJlIbrO2Nr72zk
 9dLi0GmA1d4vSdnR0s7BKyIERMFiDQGkxVfAP13VfPfDnD0+bIzcXHJUrTGNcoOi+P89PlXgLIg2n
 cRxC+9hVeMWrykfPTUdi4YOmAE9fYTDDOBNi8N84eRRJdvdDP+cO+tsRWlnIca9b/AT8YT0WWkqO9
 esDwrK2w==;
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWiNO-007wfM-0J
 for linux-nvme@lists.infradead.org; Wed, 14 Apr 2021 16:28:27 +0000
Received: by mail-wm1-x335.google.com with SMTP id
 q123-20020a1c43810000b029012c7d852459so2839965wma.0
 for <linux-nvme@lists.infradead.org>; Wed, 14 Apr 2021 09:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=toGm6Agv5lwh7MH98M2iHvOjaQjMPEy/P204OuACMG0=;
 b=LMsxQlpWwoLfK4ymwCXnt7GP9RIxOB3E+edPQA6hK9b3367we7Y8WRwJ/bP6DAa5bd
 jod22IF/M5PXZR2B8EAuYsYyLBehf0LciR40KirnCFRjnQkdmpwd3fISksfQKfhVa1PH
 GWTBLjFE0iBJ8vZv1i554wpXMZKd7SwSw8ZLzakArRDFS7wDguNBatEecHZxU2YfhKoH
 DHc/LkxpwMIHwOXaiUH+vnlcOC2+hMyKWGNPNPk74vCiqjGytw1wEhTJNuKjFONyLcBe
 dpcY9VWLxk5DwZsGhN9ykLnypdHgF81Z6qiBR9NInPa7ps9/ea1DQy6C25kGqcPMtuiA
 hsdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=toGm6Agv5lwh7MH98M2iHvOjaQjMPEy/P204OuACMG0=;
 b=svbd5HS/uTncYAv2VadegBm5qLRV7vprybCyzdXSBrESsEv0IFqpgh/8yf/7HsP9ha
 0Iqr2fF+y47hJ/heuRy02MwV6jCEixEHvFJD4zTK7kJbyPHRRT/zRsufRDBPcMTUNjya
 TUCGic29xl6z8QdzXqHB+B0zo9RAVjAcMI1Z/nOgrrfuorKNcHJkGC2RVL5Br84/JJad
 qeYShXfHwSByv46qgAIQq0Hb/g1eh84FiugIDQOZ0b3RSYjR7cREdZSZljdMbA3yRT9U
 3K3gbGdBriTtvQyUvZ7SnIK0JUEDM+CuRRb+IXkhZmFcP6tI4e3EnkRx9HUW5ljf4s98
 YYiQ==
X-Gm-Message-State: AOAM533Nb2eD61K80p3f/Sbg4E8Qm/BXmJdul9QQp48iUaVKZvKqIXFZ
 8xkxWncLAqeFuKGUUDswhDTwEj9LLnrV5rAaNFQ=
X-Google-Smtp-Source: ABdhPJysuMRxLZjIDKD+n5NTTToO5fJcxS3klSs6SZMbvPmmgl34Y+FqDzjfJeMGOX2S09X1YVM4jQVh97D86907/Mg=
X-Received: by 2002:a1c:c91a:: with SMTP id f26mr3792206wmb.15.1618417703529; 
 Wed, 14 Apr 2021 09:28:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210414051629.103383-1-joshi.k@samsung.com>
 <CGME20210414051747epcas5p265826317a971aaa3337efb6472a9df7c@epcas5p2.samsung.com>
 <20210414051629.103383-3-joshi.k@samsung.com> <20210414060812.GA24949@lst.de>
In-Reply-To: <20210414060812.GA24949@lst.de>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Wed, 14 Apr 2021 21:57:56 +0530
Message-ID: <CA+1E3rLS_jsUDN-=3dqu4h-+VHUfEjyXUNXy2KjGca8yiURvqw@mail.gmail.com>
Subject: Re: [PATCH 2/2] nvme: avoid memset for passthrough requests
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, 
 linux-nvme@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210414_092826_068570_4F3A5AA3 
X-CRM114-Status: GOOD (  12.21  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Apr 14, 2021 at 11:46 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Apr 14, 2021 at 10:46:29AM +0530, Kanchan Joshi wrote:
> > nvme_clear_nvme_request() clears the nvme_command, which is unncessary for
> > passthrough requests as nvme_command is overwritten immediately.
> > Change nvme_clear_nvme_request() so that double memset for passthrough
> > requests is avoided.
>
> Please just move the memset to the one caller that wants ->cmd zeroed.
>
Fine, I'll do it that way.


-- 
Kanchan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
