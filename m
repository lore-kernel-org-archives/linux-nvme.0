Return-Path: <SRS0=PNO/=FP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B7EC4361B
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Dec 2020 08:11:01 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6879523E56
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Dec 2020 08:11:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6879523E56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kalrayinc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Subject:References:In-Reply-To:
	Message-ID:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=nn0U/uY7zfs6A7UXoYpx+EZTRqjoMtes3lbjwcHZaVY=; b=yW5GTH3aNyw0OicjnjbhH6sJi
	xayT0U2tm6ETUt+nZfFwwrxFvJQ5N1ZsQAp9UWRzIqPSU6NoH+0fbX4Rav8b+ATIzcVyEO0FmILb0
	cuQXPQUKOcbm7Bojgxboz/vfcPG4fbf1La1oMPuCMpU+xIliEjag5izHIq0dr2OZRZyc0HCKgtZln
	za4yG3/eWXMKmlJ06Uafqodf92H+8FSRr6CUmQsNaihRVmRM0KtOLc8U868oSJB+MpKjt0XQtOK85
	xI+k8e0gQp7mBij2XunDs09Mql9LmKmM/H0Gam/IN6J8P6ZGPxjCvN4yzKLvxwHAZuNb0xJowI/SU
	wgQGSjvEA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kndVs-0007jb-Sg; Fri, 11 Dec 2020 08:10:52 +0000
Received: from mib.mailinblack.com ([137.74.84.110])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kndVp-0007iT-BU
 for linux-nvme@lists.infradead.org; Fri, 11 Dec 2020 08:10:50 +0000
Received: from localhost (localhost [127.0.0.1])
 by mib.mailinblack.com (Postfix) with ESMTP id 906A61A1FAC
 for <linux-nvme@lists.infradead.org>; Fri, 11 Dec 2020 08:10:47 +0000 (UTC)
Received: from mib.mailinblack.com (localhost [127.0.0.1])
 by mib.mailinblack.com with SMTP (Mib Daemon ) id KIJZQK9U;
 Fri, 11 Dec 2020 08:10:47 +0000 (UTC)
Received: from zimbra2.kalray.eu (zimbra2.kalray.eu [92.103.151.219])
 by mib.mailinblack.com (Postfix) with ESMTPS id 2A6861A1FAA;
 Fri, 11 Dec 2020 08:10:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by zimbra2.kalray.eu (Postfix) with ESMTP id EBA2927E02B7;
 Fri, 11 Dec 2020 09:10:46 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1])
 by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id 4QEgHWv2lVbZ; Fri, 11 Dec 2020 09:10:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zimbra2.kalray.eu (Postfix) with ESMTP id B0C7A27E064D;
 Fri, 11 Dec 2020 09:10:46 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra2.kalray.eu
Received: from zimbra2.kalray.eu ([127.0.0.1])
 by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id UBfBR-J0MSrE; Fri, 11 Dec 2020 09:10:46 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1])
 by zimbra2.kalray.eu (Postfix) with ESMTP id 9BFA627E02B7;
 Fri, 11 Dec 2020 09:10:46 +0100 (CET)
Date: Fri, 11 Dec 2020 09:10:46 +0100 (CET)
From: Samuel Jones <sjones@kalrayinc.com>
To: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <1913158592.21839129.1607674246318.JavaMail.zimbra@kalray.eu>
In-Reply-To: <dfd08de7-afd7-d1c3-2f01-db93f53a67ea@grimberg.me>
References: <253503002.21820362.1607631686785.JavaMail.zimbra@kalray.eu>
 <dfd08de7-afd7-d1c3-2f01-db93f53a67ea@grimberg.me>
Subject: Re: nvme-tcp: Queue deadlock (stuck PDU) on NVMe TCP host driver
MIME-Version: 1.0
X-Originating-IP: [192.168.40.202]
X-Mailer: Zimbra 8.8.15_GA_3895 (ZimbraWebClient - FF70 (Linux)/8.8.15_GA_3895)
Thread-Topic: nvme-tcp: Queue deadlock (stuck PDU) on NVMe TCP host driver
Thread-Index: yi5UabsLS7Fp+/LolRgMqvCGUqYouQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201211_031049_529483_8F01C98B 
X-CRM114-Status: GOOD (  16.50  )
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
Cc: linux-nvme <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Sagi,

>> If this occurs, the H2CData PDU will not be sent until io_work is rescheduled. If we are lucky, this will happen soon, because of other activity on the socket (new responses from the target for example). If we are not, the H2CData PDU will never be sent and the queue is deadlocked. Eventually the block io timeout will kick in and tear down the queue.
>> 
>> I have not been able to prove formally that the above sequence is what we are observing. I have been able to test rescheduling the workqueue if the call to mutex_trylock() in nvme_tcp_try_send fails, which fixes the issue for us.
>> 
>> 
>> What do you think? I'd be grateful for any comments you may have this.

> I agree with the analysis.
 
> I'm assuming that this patch makes the issue go away:
> --
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 1ba659927442..9193b05d7bda 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1122,6 +1122,14 @@ static void nvme_tcp_io_work(struct work_struct *w)
>                                 pending = true;
>                         else if (unlikely(result < 0))
>                                 break;
> +               } else {
> +                       /*
> +                        * submission path is sending, we need to
> +                        * continue or resched because the submission
> +                        * path direct send is not concerned with
> +                        * rescheduling...
> +                        */
> +                       pending = true;
>                 }
>
>                 result = nvme_tcp_try_recv(queue);
> --

I confirm this fixes the issue for us.

Regards,
Samuel


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
