Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DBAAC433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Mar 2022 22:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rzoZYAsHrVdv98Xt1yQ3c/yb77T1PgQBlk+j4+YdQqs=; b=bnwJONuxRcBpLt056BFW3ceucO
	MruyZ5e4+RPOprHO01n2b7RQKjXMQDSyvokoelxtl9Td6Qe1SIAe9UpE2GRwq+IQkM98X3z4f43rI
	JQoaOzom1OJQ0IcUwmab3VdHjJbG3L5YnReRgXysj5u356pWAMAxeg0lGNHlh+Zu87GymFxs7NeJI
	RGemT+ldBHdPexedh5FezoDyI+8DYPeusdbcsW+JuiqsCtKpm2Oyv+oQ9FOwzBUrP8Yf6WyWSRVDj
	UacvJ8Es31IiKDVA220oIIGoacHSVGj/KOEKKgJotbP4AgimLUnDdHqWgohg0+sakKdHxzFHh2ysx
	G4lM7/Ag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nRiny-006T8x-69; Tue, 08 Mar 2022 22:59:46 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRinu-006T7d-QW
 for linux-nvme@lists.infradead.org; Tue, 08 Mar 2022 22:59:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646780379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rzoZYAsHrVdv98Xt1yQ3c/yb77T1PgQBlk+j4+YdQqs=;
 b=BgevHF636apLMi7QL11UeY2QE3aLMUC6mTUK3GwB+LdIt1msL+rA7QMakelQ7tGEKNQyhw
 27A9sl65tnNiqMG1aper7Qt950x8boxl1bJXITCFU9/a3msA3TzjZXX3k4d1mI2VkRKQkk
 uQYM1aMXi8dROMWejUU2Vc6ZW3+NhQA=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-492-lHSLWdD5PbeQA9q4xtVmNQ-1; Tue, 08 Mar 2022 17:59:38 -0500
X-MC-Unique: lHSLWdD5PbeQA9q4xtVmNQ-1
Received: by mail-pg1-f200.google.com with SMTP id
 j5-20020a63e745000000b00378c359fac3so238284pgk.2
 for <linux-nvme@lists.infradead.org>; Tue, 08 Mar 2022 14:59:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rzoZYAsHrVdv98Xt1yQ3c/yb77T1PgQBlk+j4+YdQqs=;
 b=aS8XM4179pETLisyZbuUuPcc/FKlKsTc61zVP2HCnTbQh74wq0R82y49SbcSZ4vHDl
 WNPnQZ400t1E/M5WBQ2Sj0i0ynE9yacQGUsAdtvJQrB1BOh2eV0wkyOzCXoBC66KreY/
 Tb8ebW/+qHhwakNxfOHP7OHp89i3vAh53Gcm5PH/Azu5IPPVQFspq3curWOF4aoe5HVr
 z+kH0WKDq0+Q++O/6zTLjMj0B4/gN9yxVX4O5/zk/P4a6F5hvAXJEoOpKUvtszLL9xfe
 mxj40NaqQBBI+CsmuW7d8VqcdV1XSHh1rH8Z/xl0Ay/+o1oeUJZFK/DsQBb6yw/U2ceU
 7gNg==
X-Gm-Message-State: AOAM531x5RS1n/B2hw0bSYig3uNA0GdDCI2MQj705K6HXz+NfGKAMjSD
 /t2F7FKkvA83WBbS/6W3YgU8d95/+eLVqF4k8LvHn1pVTxQZ/k7ACn4hoy574CmdViMvZdXl3hM
 g4TL/hdVfXxugmD7YeF2s0TXE+bhBK6sGk+fwyitjs1A=
X-Received: by 2002:a17:902:ce86:b0:151:a78b:44fe with SMTP id
 f6-20020a170902ce8600b00151a78b44femr19284460plg.159.1646780376974; 
 Tue, 08 Mar 2022 14:59:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxaJw+Dfu3e7uZzkDDFjsyYEDS9HCRwvl6GxiQmrUkZUYPtyT+OK0JFJRX4YT9rNCsDqEuKLjXcwDJmw3s+apI=
X-Received: by 2002:a17:902:ce86:b0:151:a78b:44fe with SMTP id
 f6-20020a170902ce8600b00151a78b44femr19284437plg.159.1646780376664; Tue, 08
 Mar 2022 14:59:36 -0800 (PST)
MIME-Version: 1.0
References: <CAHj4cs8vnLXyddEJkV_1Dbmn7UaM4sLX=C1CN9tuA-5Mhczayw@mail.gmail.com>
 <9d9abd33-51f2-5a8e-9df9-8ffe72e3a30b@nvidia.com>
In-Reply-To: <9d9abd33-51f2-5a8e-9df9-8ffe72e3a30b@nvidia.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 9 Mar 2022 06:59:24 +0800
Message-ID: <CAHj4cs_uViOtdMmFmJZ=htBXybjUP3uL3LnRR0C4PCnHWUM82A@mail.gmail.com>
Subject: Re: [bug report] NVMe/IB: kmemleak observed on 5.17.0-rc5 with
 nvme-rdma testing
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: RDMA mailing list <linux-rdma@vger.kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, 
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220308_145942_982690_C822B5EB 
X-CRM114-Status: GOOD (  14.92  )
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

On Tue, Mar 8, 2022 at 11:51 PM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
>
> Hi Yi Zhang,
>
> Please send the commands to repro.
>
> I run the following with no success to repro:
>
> for i in `seq 100`; do echo $i &&  cat /sys/kernel/debug/kmemleak &&
> echo clear > /sys/kernel/debug/kmemleak && nvme reset /dev/nvme2 &&
> sleep 5 && echo scan > /sys/kernel/debug/kmemleak ; done

Hi Max
Sorry, I should add more details when I report it.
The kmemleak observed when I was reproducing the "nvme reset" timeout
issue we discussed before[1], and the cmd I used are[2]

[1]
https://lore.kernel.org/linux-nvme/CAHj4cs_ir917u7Up5PBfwWpZtnVLey69pXXNjFNAjbqQ5vwU0w@mail.gmail.com/T/#m5e6dcc434fc1925b18047c348226cfbc48ffbd14
[2]
# nvme connect to target
# nvme reset /dev/nvme0
# nvme disconnect-all
# sleep 10
# echo scan > /sys/kernel/debug/kmemleak
# sleep 60
# cat /sys/kernel/debug/kmemleak


>
> -Max.
>
> On 2/21/2022 1:37 PM, Yi Zhang wrote:
> > Hello
> >
> > Below kmemleak triggered when I do nvme connect/reset/disconnect
> > operations on latest 5.17.0-rc5, pls check it.
> >
> > # cat /sys/kernel/debug/kmemleak
> > unreferenced object 0xffff8883e398bc00 (size 192):
> >    comm "nvme", pid 2632, jiffies 4295317772 (age 2951.476s)
> >    hex dump (first 32 bytes):
> >      80 50 84 a3 ff ff ff ff 70 d4 12 67 81 88 ff ff  .P......p..g....
> >      01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >    backtrace:
> >      [<00000000ecf84f29>] kmem_cache_alloc_trace+0x10e/0x220
> >      [<0000000099bbcbaa>] blk_iolatency_init+0x4e/0x380
> >      [<00000000e7a59176>] blkcg_init_queue+0x12e/0x610
> >      [<00000000aade682c>] blk_alloc_queue+0x400/0x840
> >      [<000000007ed43824>] blk_mq_init_queue_data+0x6a/0x100
> >      [<00000000cbff6d39>] nvme_rdma_setup_ctrl+0x4ca/0x15f0 [nvme_rdma]
> >      [<00000000a309d26c>] nvme_rdma_create_ctrl+0x7e5/0xa9f [nvme_rdma]
> >      [<000000007d8b5cca>] nvmf_dev_write+0x44e/0xa39 [nvme_fabrics]
> >      [<0000000031d8624b>] vfs_write+0x17e/0x9a0
> >      [<00000000471d7945>] ksys_write+0xf1/0x1c0
> >      [<00000000a963bc79>] do_syscall_64+0x3a/0x80
> >      [<0000000005154fc2>] entry_SYSCALL_64_after_hwframe+0x44/0xae
> > unreferenced object 0xffff8883e398a700 (size 192):
> >    comm "nvme", pid 2632, jiffies 4295317782 (age 2951.466s)
> >    hex dump (first 32 bytes):
> >      80 50 84 a3 ff ff ff ff 60 c8 12 67 81 88 ff ff  .P......`..g....
> >      01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >    backtrace:
> >      [<00000000ecf84f29>] kmem_cache_alloc_trace+0x10e/0x220
> >      [<0000000099bbcbaa>] blk_iolatency_init+0x4e/0x380
> >      [<00000000e7a59176>] blkcg_init_queue+0x12e/0x610
> >      [<00000000aade682c>] blk_alloc_queue+0x400/0x840
> >      [<000000007ed43824>] blk_mq_init_queue_data+0x6a/0x100
> >      [<000000004f80b965>] nvme_rdma_setup_ctrl+0xf37/0x15f0 [nvme_rdma]
> >      [<00000000a309d26c>] nvme_rdma_create_ctrl+0x7e5/0xa9f [nvme_rdma]
> >      [<000000007d8b5cca>] nvmf_dev_write+0x44e/0xa39 [nvme_fabrics]
> >      [<0000000031d8624b>] vfs_write+0x17e/0x9a0
> >      [<00000000471d7945>] ksys_write+0xf1/0x1c0
> >      [<00000000a963bc79>] do_syscall_64+0x3a/0x80
> >      [<0000000005154fc2>] entry_SYSCALL_64_after_hwframe+0x44/0xae
> > unreferenced object 0xffff8894253d9d00 (size 192):
> >    comm "nvme", pid 2632, jiffies 4295331915 (age 2937.333s)
> >    hex dump (first 32 bytes):
> >      80 50 84 a3 ff ff ff ff 80 e0 12 67 81 88 ff ff  .P.........g....
> >      01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >    backtrace:
> >      [<00000000ecf84f29>] kmem_cache_alloc_trace+0x10e/0x220
> >      [<0000000099bbcbaa>] blk_iolatency_init+0x4e/0x380
> >      [<00000000e7a59176>] blkcg_init_queue+0x12e/0x610
> >      [<00000000aade682c>] blk_alloc_queue+0x400/0x840
> >      [<000000007ed43824>] blk_mq_init_queue_data+0x6a/0x100
> >      [<000000009f9abba5>] nvme_rdma_setup_ctrl.cold.70+0x5ee/0xb01 [nvme_rdma]
> >      [<00000000a309d26c>] nvme_rdma_create_ctrl+0x7e5/0xa9f [nvme_rdma]
> >      [<000000007d8b5cca>] nvmf_dev_write+0x44e/0xa39 [nvme_fabrics]
> >      [<0000000031d8624b>] vfs_write+0x17e/0x9a0
> >      [<00000000471d7945>] ksys_write+0xf1/0x1c0
> >      [<00000000a963bc79>] do_syscall_64+0x3a/0x80
> >      [<0000000005154fc2>] entry_SYSCALL_64_after_hwframe+0x44/0xae
> >
> >
> >
>


-- 
Best Regards,
  Yi Zhang


