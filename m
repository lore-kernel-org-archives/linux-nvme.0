Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B64CC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Mar 2022 04:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QoePJSQbuVnvJh6L9HrarS4wgTWUo2BUYLqCrlMWPKo=; b=hpZxXtZpa1qkGP6oYdpqfVV8aQ
	hhOfvo7XshNILhgX/NH3T9yoBtMy/hqt4rH7D9m3gnT+OBXzFvVzM6xsfdmpCpV00TadiH1a8oviG
	H7xO2+78qmjYObLqS2v22DbyBaK7bVzdnGonOIRNvYHIiYOCsOwmjxNbmhRy84RW/tNWNioZPOQ8Y
	Q8nLTkG2KZdOD3gMHctXfyI06kTm3BWT7hbmTaS0hZ9GwQdYIK1O0bfCViXM6LMupYO1F4erR/i/m
	ccPGN5Yl9EOjveekMzLkYWItw1biWR+f4sX2e3JjM4Dgf9vMYGW/Xrglr2HX3v4tm4fY5tJvQp5VZ
	2G+8bTRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nWWbA-00A0Xs-JE; Tue, 22 Mar 2022 04:58:24 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nWWb7-00A0X8-Fu
 for linux-nvme@lists.infradead.org; Tue, 22 Mar 2022 04:58:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647925098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QoePJSQbuVnvJh6L9HrarS4wgTWUo2BUYLqCrlMWPKo=;
 b=RG+RVcc1cGsDCiSF92AXQdr3nxH8iEx7l+0kURtj78jysNhyfsf61/S4QCDzPZBhcmQKZ4
 laJihxu7+FW9s0jMFUVhsh6ZmB+8kAn4j+uplCOP4Fe9T9UHOb5QNVE84xAN9rWxN91dY2
 983QKhtGCe0Z1QQ+BGjtCcHYQWQpOHQ=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-67-J-DawJPjNOOUKS6MsbDOvA-1; Tue, 22 Mar 2022 00:58:17 -0400
X-MC-Unique: J-DawJPjNOOUKS6MsbDOvA-1
Received: by mail-pl1-f199.google.com with SMTP id
 q11-20020a170902c9cb00b001546680ee18so1723281pld.7
 for <linux-nvme@lists.infradead.org>; Mon, 21 Mar 2022 21:58:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QoePJSQbuVnvJh6L9HrarS4wgTWUo2BUYLqCrlMWPKo=;
 b=wVgWwYxbCziiABT+5WBtHmcxGkt37Rhqo+9yOrtYXNCpIW1ukS+aL7nC6VMZz5tWpe
 w72yo9ARE41LCfRxvZeztVsVgdSCGHuyeRF7NFxZ3ppI1Iv3hBhMsWW6q/Yipgi41k1N
 92orOYA7us6lj4HTLL0XH15Bka84C//6UkWEjjsqtA0Vq1Bvk6zHt6yC//FLOx+uFdFa
 FqcsAjlsf32kIU0tJPyWeNqhxZ1q5nlPIJyWS1OI4MsDulUEPluZi2MNTNnX4plfTFXA
 BaGv5/Xf/NF8+BiVpwq/jFn96IL8blJKNp91+dsD0WsqwbGkovhnvi+Qc6vRFGgq0hAD
 PLnQ==
X-Gm-Message-State: AOAM5334OSB9WBXEQO/RWoH1nBpSkYLQlVn+OeF/MdS3UeAsZ4/kbjdk
 xf9Ur+0J9xxT8V8D+Zpz2W6i8wqyAybCcOoeQ5P0o4TQQeBIS0LpAQXULcsTcleilS641V6VGhZ
 Cp13fGnYUgqZy6vqzomEOY1kKi1CwzKTTCr+GT8HNBLo=
X-Received: by 2002:a05:6a00:1890:b0:4fa:a140:ffe with SMTP id
 x16-20020a056a00189000b004faa1400ffemr8588325pfh.33.1647925096276; 
 Mon, 21 Mar 2022 21:58:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwrtC54PwNRkWhxmA2w+tb8nEWGOmDTKuM0CgbxGGc8mimXEvtccWDFb7V3GEl7agC7tCAta1HdHNYfdNF9750=
X-Received: by 2002:a05:6a00:1890:b0:4fa:a140:ffe with SMTP id
 x16-20020a056a00189000b004faa1400ffemr8588322pfh.33.1647925096079; Mon, 21
 Mar 2022 21:58:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs8vnLXyddEJkV_1Dbmn7UaM4sLX=C1CN9tuA-5Mhczayw@mail.gmail.com>
 <9d9abd33-51f2-5a8e-9df9-8ffe72e3a30b@nvidia.com>
 <CAHj4cs_uViOtdMmFmJZ=htBXybjUP3uL3LnRR0C4PCnHWUM82A@mail.gmail.com>
 <bbb103d5-7622-dc88-07b8-1edc684d2f82@nvidia.com>
 <CAHj4cs_L=QHh4XeOJGfibfSJhhijS6s7RBNuLd_XetKT3hfjWQ@mail.gmail.com>
 <9ba8bfae-2363-e331-83c7-317a9456da31@grimberg.me>
 <CAHj4cs9cmOt=9++wuqJ1ehLPDJcaXJGyTKcHSjU-avWxr1CBrA@mail.gmail.com>
 <f5394785-aafa-784c-9ac0-b4abe19f65be@grimberg.me>
In-Reply-To: <f5394785-aafa-784c-9ac0-b4abe19f65be@grimberg.me>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Tue, 22 Mar 2022 12:58:04 +0800
Message-ID: <CAHj4cs_WQg752czaR4mtaZVPRW6ZqO16EAHZ10njRB+g+8gOOQ@mail.gmail.com>
Subject: Re: [bug report] NVMe/IB: kmemleak observed on 5.17.0-rc5 with
 nvme-rdma testing
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>,
 RDMA mailing list <linux-rdma@vger.kernel.org>, 
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 Nitzan Carmi <nitzanc@nvidia.com>, 
 Israel Rukshin <israelr@nvidia.com>, Ming Lei <ming.lei@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220321_215821_645696_82D292FA 
X-CRM114-Status: GOOD (  21.29  )
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

On Mon, Mar 21, 2022 at 5:25 PM Sagi Grimberg <sagi@grimberg.me> wrote:
>
>
> >>>>> # nvme connect to target
> >>>>> # nvme reset /dev/nvme0
> >>>>> # nvme disconnect-all
> >>>>> # sleep 10
> >>>>> # echo scan > /sys/kernel/debug/kmemleak
> >>>>> # sleep 60
> >>>>> # cat /sys/kernel/debug/kmemleak
> >>>>>
> >>>> Thanks I was able to repro it with the above commands.
> >>>>
> >>>> Still not clear where is the leak is, but I do see some non-symmetric
> >>>> code in the error flows that we need to fix. Plus the keep-alive timing
> >>>> movement.
> >>>>
> >>>> It will take some time for me to debug this.
> >>>>
> >>>> Can you repro it with tcp transport as well ?
> >>>
> >>> Yes, nvme/tcp also can reproduce it, here is the log:
>
> Looks like the offending commit was 8e141f9eb803 ("block: drain file
> system I/O on del_gendisk") which moved the call-site for a reason.
>
> However rq_qos_exit() should be reentrant safe, so can you verify
> that this change eliminates the issue as well?

Yes, this change also fixed the kmemleak, thanks.

> --
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 94bf37f8e61d..6ccc02a41f25 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -323,6 +323,7 @@ void blk_cleanup_queue(struct request_queue *q)
>
>          blk_queue_flag_set(QUEUE_FLAG_DEAD, q);
>
> +       rq_qos_exit(q);
>          blk_sync_queue(q);
>          if (queue_is_mq(q)) {
>                  blk_mq_cancel_work_sync(q);
> --
>


-- 
Best Regards,
  Yi Zhang


