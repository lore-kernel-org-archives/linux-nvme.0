Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54CBCD262B9
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Jan 2026 02:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=fFeKv09HCEkQRsng29UKXvnp+lJB/36rWHXN5G2fdyg=; b=Sk34fKiDI65DVJmckXrOzXOAym
	DrhSMHI11B0hLKSCkpS+NciPNbwVzhAf148CvHPaYMWplcaqSKuWZlST/AUEYgSRUWhIDXFrwrXUD
	owuf5jW3qv3p7ndPzzQ9emBBlNOP3MDQChun9ke9mYdN3kpLtU0IO0OyF6vR4pw47WgeYAD7xYM7R
	jTlfZZnONL7cOkwKeS5aQ3crHryyyJdE7ckW+Hr+of5hKLlOBI6Yfib+FygR3jUPieJ5ooDXITi6G
	sdDTiDgxkp+vkEjZ8zXeRx1tlK0kfWDxFeYJkygH7qFRwo4VPqxMhemsZ3kHpoHzCarLXF/5zHC+Y
	0LFxKC+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viOIZ-00000004oS1-0ONe;
	Wed, 21 Jan 2026 02:50:23 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viOIV-00000004oRh-1bLh
	for linux-nvme@lists.infradead.org;
	Wed, 21 Jan 2026 02:50:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768963816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=fFeKv09HCEkQRsng29UKXvnp+lJB/36rWHXN5G2fdyg=;
	b=AygaVcH12+3VTbrsSjuCubxkf7xJhFPUYAYb0V8CxKOs6f08lbXs5gM6dxYY51evoG8KOV
	a4oBnY9viN1sKbeyj5lDX3fexu0NuCKjTkQHaF78ri+KmgIBbKBGgDbRsM7o0IRYrQMkgU
	ZpY+sUWHFkCd27OxOdyMrsrIn3e63Vk=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-p-sbH8PzPmK-MABQ8dyYuw-1; Tue, 20 Jan 2026 21:50:15 -0500
X-MC-Unique: p-sbH8PzPmK-MABQ8dyYuw-1
X-Mimecast-MFC-AGG-ID: p-sbH8PzPmK-MABQ8dyYuw_1768963814
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-38323e5932eso32192661fa.2
        for <linux-nvme@lists.infradead.org>; Tue, 20 Jan 2026 18:50:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768963812; x=1769568612;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fFeKv09HCEkQRsng29UKXvnp+lJB/36rWHXN5G2fdyg=;
        b=rvEHeBeW+Jeq2yNaKUxy+RZcYr0frLNeEXGlJLBi7dZWQyiZ1tLW/WviJTftmv3mIl
         TuvoYmKdVqnPxkfUyWG7tO56ZgllogE9Sou43HNxvK/X9cre+UkvIQEvEgtH5ns1lc+J
         n0GW1snAN7p5ex8tcjjNV+k0vEUbq/Dlm8mXBYXQlUtF36mdZ7d0CN1hPaVjY2twHhbe
         J4fvzDcl6L1CAx4eJwj9kgvtzf1n3SjenSopA9Y5DEPfbYDmnBm2vsGoKY83ozLeVENd
         +PAsYSJu3E/pOYAriQY/HMHkrR4YLcZ17JQ+eNcYeVmV9z35uwT2m0yTN9lOa6qPM+Td
         jT1A==
X-Forwarded-Encrypted: i=1; AJvYcCXRqKIcJahx7Mu3FtzPGEfwW764tmxmrVwX05QnIapY8AlRsslhREy6hki2gZTt+y5VTwUE1rjYEN5n@lists.infradead.org
X-Gm-Message-State: AOJu0YyvNBn2pdqNKaCFQ5Z1J1AxNNH9p/jseeVDM5qzGd9VJXrls8Q6
	8ETO9Kq4Zxx3FH9NZ0JCC58u1nHrlgmQDsAr7prAJOnz1OwKpZyXS77SpT7hPOKsZWc3pN3c08V
	gACOtTMnT6MZreTPZfgPvFwQATTTBfeYuxHpvfFafLKmapUBlbHmqG7P3wX772eExacPDaqrBIR
	CJqYcEja0f/CXlMObak2U0ZQDSo7lf5f6ilLvO/x7XppR+UQ7BLls7vXvq5Yw=
X-Gm-Gg: AZuq6aKEIZBkka22ZhuvBteLRl2metNPGEJg2CCiU6kQOD+stMYT4YbE6cOXJIFGYMA
	YP46yO7zw7n7H5S19dhesHgkCwOs4WNl0e2q2+09tlmo2VodzVWvryvKHxvP9vftReM91eSzjp7
	nekaltaH6tjHzOrIXHLTTkdXgIr5ZmZcRCHWlnz8lCmi/95zPlaCNQIjvcdIiLT2fjh58=
X-Received: by 2002:a2e:be0a:0:b0:380:a1c:702b with SMTP id 38308e7fff4ca-38384153c55mr53882781fa.5.1768963812538;
        Tue, 20 Jan 2026 18:50:12 -0800 (PST)
X-Received: by 2002:a2e:be0a:0:b0:380:a1c:702b with SMTP id
 38308e7fff4ca-38384153c55mr53882721fa.5.1768963812089; Tue, 20 Jan 2026
 18:50:12 -0800 (PST)
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 21 Jan 2026 10:50:00 +0800
X-Gm-Features: AZwV_QizxBsjzmFkfE3NqLCyhma6GO59nWglwmWfjf5YXHqBLOS6BJ6iFt7QJ8s
Message-ID: <CAHj4cs9JJu+dDZqAvCd1qPM1CZuV-_b-AHxXpU-vJrGHHO-ExA@mail.gmail.com>
Subject: [bug report] nvme-tcp poll queue causes busy loop and 100% CPU in
 nvme_tcp_poll() on the latest linux-block/for-next
To: linux-block <linux-block@vger.kernel.org>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Ming Lei <ming.lei@redhat.com>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <chaitanyak@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zoj0rfxG-PHpgSM1blutTMLWkGp3TVTkQOqxR-ezqYE_1768963814
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260120_185019_494754_41B1C518 
X-CRM114-Status: UNSURE (   6.86  )
X-CRM114-Notice: Please train this message.
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

Hi

This issue was observed on the latest linux-block/for-next during CKI
test, where enabling the poll queues leads to a tight busy polling
loop and 100% CPU usage during "nvme connect".
It seems was introduced from v6.19-rc1 and cannot reproduced on v6.18.
I will try to bisect it.
I am happy to test any proposed fixes or provide additional traces if needed.

Reproducer:
#nvme_trtype=tcp  ./check nvme/047
nvme/047 (tr=tcp) (test different queue types for fabric transports) [passed]
    runtime  1061.108s  ...  19857.364s

# ps aux | grep "nvme connect"
root        2492 99.9  0.0  15884  5520 pts/0    R+   01:28   0:13
nvme connect --traddr 127.0.0.1 --transport tcp --trsvcid 4420 --nqn
blktests-subsystem-1
--hostnqn=nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
--hostid=0f01fb42-9f7f-4856-b0b3-51e60b8de349 --nr-write-queues=1
--nr-poll-queues=1 --output-format=json

# perf top -p  2492
Samples: 71K of event 'cycles:P', 4000 Hz, Event count (approx.):
39693035620 lost: 0/0 drop: 0/0
Overhead  Shared O  Symbol
  51.62%  [kernel]  [k] blk_hctx_poll
  34.64%  [kernel]  [k] nvme_tcp_poll
  13.39%  [kernel]  [k] __x86_indirect_thunk_rax
   0.02%  [kernel]  [k] native_irq_return_iret
   0.02%  [kernel]  [k] native_write_msr
   0.02%  [kernel]  [k] update_load_avg
   0.01%  [kernel]  [k] __raw_spin_lock_irqsave
   0.01%  [kernel]  [k] native_sched_clock
   0.01%  [kernel]  [k] read_tsc
   0.01%  [kernel]  [k] sched_balance_trigger
   0.01%  [kernel]  [k] __hrtimer_run_queues
   0.01%  [kernel]  [k] __update_load_avg_cfs_rq
   0.01%  [kernel]  [k] __timekeeping_advance
   0.01%  [kernel]  [k] native_read_msr
   0.01%  [kernel]  [k] ktime_get_update_offsets_now
   0.01%  [kernel]  [k] task_tick_fair
   0.01%  [kernel]  [k] native_apic_msr_eoi
   0.01%  [kernel]  [k] sugov_get_util

dmesg:
[ 5514.212238] run blktests nvme/047 at 2026-01-19 16:37:29
[ 5514.229581] loop0: detected capacity change from 0 to 2097152
[ 5514.235566] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[ 5514.244495] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[ 5514.267088] nvmet: Created nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[ 5514.269066] nvme nvme0: creating 73 I/O queues.
[ 5514.276926] nvme nvme0: mapped 1/72/0 default/read/poll queues.
[ 5514.301778] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr
127.0.0.1:4420, hostnqn:
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[ 5515.068893] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
[ 5515.150669] nvmet: Created nvm controller 2 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[ 5515.152791] nvme nvme0: creating 74 I/O queues.
[ 5515.161907] nvme nvme0: mapped 1/72/1 default/read/poll queues.
[25370.530190] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr
127.0.0.1:4420, hostnqn:
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[25371.283929] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"


--
Best Regards,
  Yi Zhang


