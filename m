Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76BA3C3601E
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Apr 2025 07:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-ID:To:Subject:From:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=8juwAuA5QfCK9G0ZTyfkhbvbUPbhRFAk1K5ddM/3Al8=; b=rkQ//l9JV+jKCTEoXeZGU/+Ugy
	yc+g8IZoKVzrpM8VqUpDHN2nnNyNWD3taTJTaRE67wPrOb3Wqn8QGLQD6dNeLChyTDP6d8zno+g4R
	CiEJQrItcqR7smWeypOBM6lOFNmFdLYXE1xIiXtqxumBQn4Yd4dNYPkrW1Od7LsEm6ed551JsiIl7
	Jj6pqrj2TstGRaFtrqkAsuXVn77IM27pKRiTeW9vCxm9S5li+9Qq2KX1A41BE7LPfvPxlGBg8o1dq
	tiWe2L8vpEkIYlBwxbvB6DM0DWRefMH0lWD5VUKpf33dVg8pUWP5c+TTJczOt2a0ipke1GXMX4eJE
	gY9vBxQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4DxU-00000000tR6-09wT;
	Mon, 14 Apr 2025 07:10:20 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4Dvu-00000000tFm-49lA
	for linux-nvme@lists.infradead.org;
	Mon, 14 Apr 2025 07:08:45 +0000
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-227cf12df27so30951175ad.0
        for <linux-nvme@lists.infradead.org>; Mon, 14 Apr 2025 00:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744614522; x=1745219322; darn=lists.infradead.org;
        h=content-language:content-transfer-encoding:mime-version:user-agent
         :date:message-id:to:subject:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8juwAuA5QfCK9G0ZTyfkhbvbUPbhRFAk1K5ddM/3Al8=;
        b=f0z3Q2G1inS7ioZgDDE3sZa9U///jdfTSiDJoBWzxmD4xPUJFr4Sr/MkQ4Xk70rS8f
         cKUyBbO/KLjFdshhjafAK19SmF9bvJkTdBoD3aa7BfJMlfmk8f6k8pJzk2+5ndahFFmN
         fHBrabyBzZx5kmziR5iIgDyPzyswBg6pyTkruVBV05qiDG7/JnpNGSdYCdZ41tQdv1dV
         t/IdqCEKKSXTLUp5gxpOVQFvsX8Q7ua6+do8+AogQ0LY0BxK1lytlyP27n2zyxwAlpW5
         wtbCgC8gEqVwHtE0AT5yYEDWWzQRm5pDfyM627EQnsjBIediB3N0Ru7lJ1uDJQ3jZuOO
         Uh7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744614522; x=1745219322;
        h=content-language:content-transfer-encoding:mime-version:user-agent
         :date:message-id:to:subject:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8juwAuA5QfCK9G0ZTyfkhbvbUPbhRFAk1K5ddM/3Al8=;
        b=OwhXyPahxL3DP35xpwMkZMQZHmp6j+6NDMxNbzMffb/HAB4ZKcEhQDOSf421lqjFla
         jooKF36L+zEHbxzSlrKD5gL2AMrTYFo5JCfKjJtUog55TWd9K+AHCQBBSqCjRa9GI6SC
         4DzVqY4+7Qc/a8R0GKDCOPzKRzjJumfY/TZtpNM2QOV2fbWjC0VQi8sH1817jgD3ST4E
         cBEApj045d4WJNEg/rtMlWvVXU2f7abHnx56qYTH+vE6XU63ZPPZTNaoehcg9eB4x8aF
         UtHaHZ/YPe/Vq3E4Ry6BYFDuqCC/15TmVo2VqQ5Wiej8tLvueur29suhfSZ97+Fywg8l
         hN0g==
X-Forwarded-Encrypted: i=1; AJvYcCX7XWZgXM0cCHCZHb0mQ+GzZIATcobbMQr16g5xpfzkAR+DdJM/0cqq7xvU7piLxXhpks1P39dfnsym@lists.infradead.org
X-Gm-Message-State: AOJu0Yz+Wa5MMKrJJIIqws9i2r+x/GPpYrGiphzJgUxRlpa7dSkZ/LYh
	0Ed0/bOxW2Y4ci7ByLXcJ0Qu7X65/qKco6el+YN0MUndwV+zFuzI
X-Gm-Gg: ASbGncsUSATSDqPY1YAtPUUkjqI6AI9YrIhXwkza2wag20T0M+xMLOj9gg8A6LaLYMU
	2cA8Nx//xFdbc4ewOmSrHO/Rs3A6d4udGbAHcv4QQTk0ryjyM5BtHCR5190zD/lrJojVqvQfeRM
	/yHZ6/qVs5iUAYwTXO2bbVhwLgc9KcmeRGcio2CoC/fhlbsKQVnCdl00XRoyB8YV3+QXFERH5x3
	pBjplC9wIRrDaKZqPnBp+WqerfEp2ZpVVFy54e5s1bjr6BtB1vzd168111gxNNNBEDjkF+xx4i+
	BvLXR1vnUUH+hjuGYYYKQuZnLHYSyeErl3dFwF48jDVMJ5Mj4WLxV5CIpkKpJJvp4Xnfw/BzNjA
	=
X-Google-Smtp-Source: AGHT+IFI+TJHtXuU1Um1khf1rw63watwMWDxf39z1l44AL0ytJFyYwaYRdKUfwGI9oSBq3JyA0oBxA==
X-Received: by 2002:a17:903:2ac5:b0:223:607c:1d99 with SMTP id d9443c01a7336-22be9f68255mr174065865ad.0.1744614521164;
        Mon, 14 Apr 2025 00:08:41 -0700 (PDT)
Received: from [0.0.0.0] ([103.127.219.137])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7cc9202sm92845015ad.211.2025.04.14.00.08.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Apr 2025 00:08:40 -0700 (PDT)
From: Linjun Bao <meljbao@gmail.com>
Subject: nvme: potential stack collision when running nvme_setup_io_queues and
 nvme_user_cmd in parallel
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Message-ID: <3c6be8cb-753a-6efb-e2a6-5686740e6361@gmail.com>
Date: Mon, 14 Apr 2025 15:08:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250414_000843_040386_B0D07CE7 
X-CRM114-Status: GOOD (  16.82  )
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

Hi there,

This is Linjun Bao from Solidigm, a SSD vendor. Recently we get some drive drop report from customer, and we confirm this is solid on the latest kernel.

## Issue Description
This issue happens across different platform, from Intel BHS server to several desktop system. This issue happens on newer kernel including
5.19, 6.0, 6.3 and 6.6, but older kernel 5.14 does not have such issue. This issue happens on SSDs from different vendors.

This issue is easily reproduced under test scenario below. Two scripts are running concurrently, one is keeping sending nvme reset to the SSD, another is keeping querying smart log from the same SSD. After several reset cycles, when issue happens, the dmesg message prints out "nvme nvme0: I/O 11 QID 0 timeout, disable controller, nvme nvme0: Disabling device after reset failure: -4".

Using the kernel 6.6.85 (almost latest) to debug, from both Lecory PCIe trace and kernel ftrace, it shows the host stops sending out nvme_admin_create_cq or nvme_admin_create_sq during the nvme_reset_work. This issue happens only when the nvme_queue_rq() from user cmd executes just after the nvme_queue_rq() from nvme_setup_io_queues(), and with the same CPU core and thread.
In the example below, I marked "Q" as parent cmd is nvme_setup_io_queues(). "L" as parent cmd is user cmd of getting smart log.

```
 13)    <idle>-0    => kworker-151717
 ------------------------------------------
 13)Q ! 561.302 us  |        } /* nvme_execute_rq [nvme_core] */
 19)L   0.125 us    |            nvme_init_request [nvme_core]();
 13)Q ! 563.722 us  |      } /* nvme_submit_sync_cmd [nvme_core] */
 19)L   1.244 us    |          }
 19)L   1.549 us    |          nvme_map_user_request [nvme_core]();
 13)Q               |      nvme_submit_sync_cmd [nvme_core]() {
 13)Q   0.368 us    |        nvme_init_request [nvme_core]();
 19)L               |          nvme_passthru_start [nvme_core]() {
 13)Q               |        nvme_execute_rq [nvme_core]() {
 19)L   0.140 us    |            nvme_command_effects [nvme_core]();
 19)L   0.348 us    |          }
 19)L + 13.250 us   |          nvme_execute_rq [nvme_core]();
 13)Q               |          nvme_queue_rq [nvme]() {
 13)Q               |            nvme_setup_cmd [nvme_core]() {
 13)Q               |              /* nvme_setup_cmd: nvme0: qid=0, cmdid=8214, nsid=0, flags=0x0, meta=0x0, cmd=(nvme_admin_create_sq sqid=19, qsize=1023, sq_flags=0x1, cqid=19) */
 13)Q   1.716 us    |            }
 13)Q   0.494 us    |            nvme_prep_rq.part.0 [nvme]();
 13)Q   3.718 us    |          }
 13)L               |          nvme_queue_rq [nvme]() {
 13)L               |            nvme_fail_nonready_command [nvme_core]() {
 13)L               |              nvme_complete_rq [nvme_core]() {
 13)L               |                /* nvme_complete_rq: nvme0: qid=0, cmdid=0, opcode=2, res=0x0, retries=0, flags=0x2, status=0x370 */
 13)L               |                nvme_end_req [nvme_core]() {
 13)L   0.411 us    |                  nvme_error_status [nvme_core]();
 13)L   3.194 us    |                }
 13)L   4.299 us    |              }
 13)L   4.952 us    |            }
 13)L   5.729 us    |          }
 19)L   0.158 us    |          nvme_passthru_end [nvme_core]();
 19)L + 18.486 us   |        }
 19)L + 19.510 us   |      }
 19)L + 19.731 us   |    }
 19)L + 19.966 us   |  }
 19)L               |  nvme_release [nvme_core]() {
 19)L   0.159 us    |    nvme_ns_release [nvme_core]();
 19)L   0.433 us    |  }

// this nvme_admin_create_sq completion irq comes way later, 60s after the host sets nvme admin cmd timeout
 ## line 3165365
 12)  nvme-303232   =>    <idle>-0  
 ------------------------------------------

 12)               |  nvme_irq [nvme]() {
 12)               |  /* nvme_sq: nvme0: qid=0, head=27, tail=27 */
 12)   1.341 us    |  }
 12)               |  nvme_pci_complete_rq [nvme]() {
 12)               |    nvme_complete_rq [nvme_core]() {
 12)               |      /* nvme_complete_rq: nvme0: qid=0, cmdid=8214, opcode=1, res=0x0, retries=0, flags=0x1, status=0x0 */
 12)               |      nvme_end_req [nvme_core]() {
 12)   0.076 us    |        nvme_error_status [nvme_core]();
 12)   1.486 us    |      }
 12)   1.794 us    |    }
 12)   2.087 us    |  }
```

A call stack ftrace shows more. Among the lines that I comment "wield behavior here," the call stack for nvme_fail_nonready_command <-nvme_queue_rq seems wrong, for an user nvme smart cmd during nvme_create_io_queues(), it should go the path nvme_fail_nonready_command <- nvme_queue_rq <- blk_mq_dispatch_rq_list <-...<- nvme_execute_rq <- nvme_submit_user_cmd since this NVMe is in CONNECTING status, but the trace shows nvme_fail_nonready_command <- nvme_queue_rq <- ... <- nvme_submit_sync_cmd <- nvme_setup_io_queues. This is wrong, since this user cmd is now using the same thread kworker/u40:5-302 and cpu core #19, I believe some stack collision happens, and this user cmd wrongly uses the stack for the sync cmd from nvme_setup_io_queues, that's the reason why there is no further create sq/cq cmds afterwards. But I do not know how to debug further, please do help guide me.
```
=> cpu_startup_entry
 => start_secondary
 => secondary_startup_64_no_verify
           <...>-20136   [018]L .....   744.363379: nvme_open <-blkdev_get_whole
   kworker/u40:5-302     [019]Q .....   744.363379: nvme_setup_io_queues_trylock <-nvme_setup_io_queues
   kworker/u40:5-302     [019]Q .....   744.363380: <stack trace>
 => nvme_setup_io_queues_trylock
 => nvme_setup_io_queues
 => nvme_reset_work
 => process_scheduled_works
 => worker_thread
 => kthread
 => ret_from_fork
 => ret_from_fork_asm
   kworker/u40:5-302     [019]Q .....   744.363381: nvme_init_queue <-nvme_setup_io_queues
   kworker/u40:5-302     [019]Q .....   744.363382: <stack trace>
 => nvme_init_queue
 => nvme_setup_io_queues
 => nvme_reset_work
 => process_scheduled_works
 => worker_thread
 => kthread
 => ret_from_fork
 => ret_from_fork_asm
           <...>-20136   [018]L .....   744.363383: <stack trace>
 => nvme_open
 => blkdev_get_whole
 => blkdev_get_by_dev
 => blkdev_open
 => do_dentry_open
 => vfs_open
 => path_openat
 => do_filp_open
 => do_sys_openat2
 => do_sys_open
 => __x64_sys_openat
 => x64_sys_call
 => do_syscall_64
 => entry_SYSCALL_64_after_hwframe
           <...>-20136   [018]L .....   744.363383: nvme_ns_open <-nvme_open
           <...>-20136   [018]L .....   744.363385: <stack trace>
 => nvme_ns_open
 => nvme_open
 => blkdev_get_whole
 => blkdev_get_by_dev
 => blkdev_open
 => do_dentry_open
 => vfs_open
 => path_openat
 => do_filp_open
 => do_sys_openat2
 => do_sys_open
 => __x64_sys_openat
 => x64_sys_call
 => do_syscall_64
 => entry_SYSCALL_64_after_hwframe
           <...>-20136   [018]L .....   744.363390: nvme_ioctl <-blkdev_ioctl
           <...>-20136   [018]L .....   744.363391: <stack trace>
 => nvme_ioctl
 => blkdev_ioctl
 => __x64_sys_ioctl
 => x64_sys_call
 => do_syscall_64
 => entry_SYSCALL_64_after_hwframe
           <...>-20136   [018]L .....   744.363391: nvme_ctrl_ioctl <-nvme_ioctl
           <...>-20136   [018]L .....   744.363392: <stack trace>
 => nvme_ctrl_ioctl
 => nvme_ioctl
 => blkdev_ioctl
 => __x64_sys_ioctl
 => x64_sys_call
 => do_syscall_64
 => entry_SYSCALL_64_after_hwframe
           <...>-20136   [018]L .....   744.363392: nvme_user_cmd.constprop.0 <-nvme_ctrl_ioctl
           <...>-20136   [018]L .....   744.363393: <stack trace>
 => nvme_user_cmd.constprop.0
 => nvme_ctrl_ioctl
 => nvme_ioctl
 => blkdev_ioctl
 => __x64_sys_ioctl
 => x64_sys_call
 => do_syscall_64
 => entry_SYSCALL_64_after_hwframe
           <...>-20136   [018]L .....   744.363393: nvme_validate_passthru_nsid.isra.0 <-nvme_user_cmd.constprop.0
           <...>-20136   [018]L .....   744.363394: <stack trace>
 => nvme_validate_passthru_nsid.isra.0
 => nvme_user_cmd.constprop.0
 => nvme_ctrl_ioctl
 => nvme_ioctl
 => blkdev_ioctl
 => __x64_sys_ioctl
 => x64_sys_call
 => do_syscall_64
 => entry_SYSCALL_64_after_hwframe
           <...>-20136   [018]L .....   744.363394: nvme_cmd_allowed <-nvme_user_cmd.constprop.0
           <...>-20136   [018]L .....   744.363395: <stack trace>
 => nvme_cmd_allowed
 => nvme_user_cmd.constprop.0
 => nvme_ctrl_ioctl
 => nvme_ioctl
 => blkdev_ioctl
 => __x64_sys_ioctl
 => x64_sys_call
 => do_syscall_64
 => entry_SYSCALL_64_after_hwframe
           <...>-20136   [018]L .....   744.363395: nvme_submit_user_cmd <-nvme_user_cmd.constprop.0
           <...>-20136   [018]L .....   744.363396: <stack trace>
 => nvme_submit_user_cmd
 => nvme_user_cmd.constprop.0
 => nvme_ctrl_ioctl
 => nvme_ioctl
 => blkdev_ioctl
 => __x64_sys_ioctl
 => x64_sys_call
 => do_syscall_64
 => entry_SYSCALL_64_after_hwframe
           <...>-20136   [018]L .....   744.363396: nvme_alloc_user_request <-nvme_submit_user_cmd
           <...>-20136   [018]L .....   744.363397: <stack trace>
 => nvme_alloc_user_request
 => nvme_submit_user_cmd
 => nvme_user_cmd.constprop.0
 => nvme_ctrl_ioctl
 => nvme_ioctl
 => blkdev_ioctl
 => __x64_sys_ioctl
 => x64_sys_call
 => do_syscall_64
 => entry_SYSCALL_64_after_hwframe
           <...>-20136   [018]L .....   744.363399: nvme_init_request <-nvme_alloc_user_request
           <...>-20136   [018]L .....   744.363400: <stack trace>
 => nvme_init_request
 => nvme_alloc_user_request
 => nvme_submit_user_cmd
 => nvme_user_cmd.constprop.0
 => nvme_ctrl_ioctl
 => nvme_ioctl
 => blkdev_ioctl
 => __x64_sys_ioctl
 => x64_sys_call
 => do_syscall_64
 => entry_SYSCALL_64_after_hwframe
           <...>-20136   [018]L .....   744.363400: nvme_map_user_request <-nvme_submit_user_cmd
           <...>-20136   [018]L .....   744.363401: <stack trace>
 => nvme_map_user_request
 => nvme_submit_user_cmd
 => nvme_user_cmd.constprop.0
 => nvme_ctrl_ioctl
 => nvme_ioctl
 => blkdev_ioctl
 => __x64_sys_ioctl
 => x64_sys_call
 => do_syscall_64
 => entry_SYSCALL_64_after_hwframe
   kworker/u40:5-302     [019]Q .....   744.363402: nvme_submit_sync_cmd <-nvme_setup_io_queues
   kworker/u40:5-302     [019]Q .....   744.363403: <stack trace>
 => nvme_submit_sync_cmd
 => nvme_setup_io_queues
 => nvme_reset_work
 => process_scheduled_works
 => worker_thread
 => kthread
 => ret_from_fork
 => ret_from_fork_asm
           <...>-20136   [018]L .....   744.363404: nvme_passthru_start <-nvme_submit_user_cmd
   kworker/u40:5-302     [019]Q .....   744.363405: nvme_init_request <-__nvme_submit_sync_cmd
           <...>-20136   [018]L .....   744.363405: <stack trace>
 => nvme_passthru_start
 => nvme_submit_user_cmd
 => nvme_user_cmd.constprop.0
 => nvme_ctrl_ioctl
 => nvme_ioctl
 => blkdev_ioctl
 => __x64_sys_ioctl
 => x64_sys_call
 => do_syscall_64
 => entry_SYSCALL_64_after_hwframe
           <...>-20136   [018]L .....   744.363405: nvme_command_effects <-nvme_passthru_start
   kworker/u40:5-302     [019]Q .....   744.363405: <stack trace>
 => nvme_init_request
 => __nvme_submit_sync_cmd
 => nvme_submit_sync_cmd
 => nvme_setup_io_queues
 => nvme_reset_work
 => process_scheduled_works
 => worker_thread
 => kthread
 => ret_from_fork
 => ret_from_fork_asm
   kworker/u40:5-302     [019]Q .....   744.363406: nvme_execute_rq <-__nvme_submit_sync_cmd
           <...>-20136   [018]L .....   744.363406: <stack trace>
 => nvme_command_effects
 => nvme_passthru_start
 => nvme_submit_user_cmd
 => nvme_user_cmd.constprop.0
 => nvme_ctrl_ioctl
 => nvme_ioctl
 => blkdev_ioctl
 => __x64_sys_ioctl
 => x64_sys_call
 => do_syscall_64
 => entry_SYSCALL_64_after_hwframe
           <...>-20136   [018]L .....   744.363406: nvme_execute_rq <-nvme_submit_user_cmd
   kworker/u40:5-302     [019]Q .....   744.363407: <stack trace>
 => nvme_execute_rq
 => __nvme_submit_sync_cmd
 => nvme_submit_sync_cmd
 => nvme_setup_io_queues
 => nvme_reset_work
 => process_scheduled_works
 => worker_thread
 => kthread
 => ret_from_fork
 => ret_from_fork_asm
           <...>-20136   [018]L .....   744.363407: <stack trace>
 => nvme_execute_rq
 => nvme_submit_user_cmd
 => nvme_user_cmd.constprop.0
 => nvme_ctrl_ioctl
 => nvme_ioctl
 => blkdev_ioctl
 => __x64_sys_ioctl
 => x64_sys_call
 => do_syscall_64
 => entry_SYSCALL_64_after_hwframe
   kworker/u40:5-302     [019]Q .....   744.363408: nvme_queue_rq <-blk_mq_dispatch_rq_list
   kworker/u40:5-302     [019]Q .....   744.363409: <stack trace>
 => nvme_queue_rq
 => blk_mq_dispatch_rq_list
 => __blk_mq_sched_dispatch_requests
 => blk_mq_sched_dispatch_requests
 => blk_mq_run_hw_queue
 => blk_execute_rq
 => nvme_execute_rq
 => __nvme_submit_sync_cmd
 => nvme_submit_sync_cmd
 => nvme_setup_io_queues
 => nvme_reset_work
 => process_scheduled_works
 => worker_thread
 => kthread
 => ret_from_fork
 => ret_from_fork_asm
   kworker/u40:5-302     [019]Q .....   744.363409: nvme_setup_cmd <-nvme_queue_rq
   kworker/u40:5-302     [019]Q .....   744.363410: <stack trace>
 => nvme_setup_cmd
 => nvme_queue_rq
 => blk_mq_dispatch_rq_list
 => __blk_mq_sched_dispatch_requests
 => blk_mq_sched_dispatch_requests
 => blk_mq_run_hw_queue
 => blk_execute_rq
 => nvme_execute_rq
 => __nvme_submit_sync_cmd
 => nvme_submit_sync_cmd
 => nvme_setup_io_queues
 => nvme_reset_work
 => process_scheduled_works
 => worker_thread
 => kthread
 => ret_from_fork
 => ret_from_fork_asm
   kworker/u40:5-302     [019]Q .....   744.363411: nvme_setup_cmd: nvme0: qid=0, cmdid=0, nsid=0, flags=0x0, meta=0x0, cmd=(nvme_admin_create_cq cqid=13, qsize=1023, cq_flags=0x3, irq_vector=13)
   kworker/u40:5-302     [019]Q .....   744.363411: nvme_setup_cmd: nvme0: qid=0, cmdid=0, nsid=0, flags=0x0, meta=0x0, cmd=(nvme_admin_create_cq cqid=13, qsize=1023, cq_flags=0x3, irq_vector=13)
   kworker/u40:5-302     [019]Q .....   744.363411: nvme_setup_cmd: nvme0: qid=0, cmdid=57352, nsid=0, flags=0x0, meta=0x0, cmd=(nvme_admin_create_cq cqid=13, qsize=1023, cq_flags=0x3, irq_vector=13)
   kworker/u40:5-302     [019]Q .....   744.363412: nvme_prep_rq.part.0 <-nvme_queue_rq
   kworker/u40:5-302     [019]Q .....   744.363413: <stack trace>
 => nvme_prep_rq.part.0
 => nvme_queue_rq
 => blk_mq_dispatch_rq_list
 => __blk_mq_sched_dispatch_requests
 => blk_mq_sched_dispatch_requests
 => blk_mq_run_hw_queue
 => blk_execute_rq
 => nvme_execute_rq
 => __nvme_submit_sync_cmd
 => nvme_submit_sync_cmd
 => nvme_setup_io_queues
 => nvme_reset_work
 => process_scheduled_works
 => worker_thread
 => kthread
 => ret_from_fork
 => ret_from_fork_asm
 ## wield behavior here
   kworker/u40:5-302     [019]Q ...1.   744.363413: nvme_queue_rq: nvme_sq_copy_cmd
   kworker/u40:5-302     [019]L .....   744.363415: nvme_fail_nonready_command <-nvme_queue_rq
   kworker/u40:5-302     [019]L .....   744.363416: <stack trace>
 => nvme_fail_nonready_command
 => nvme_queue_rq
 => blk_mq_dispatch_rq_list
 => __blk_mq_sched_dispatch_requests
 => blk_mq_sched_dispatch_requests
 => blk_mq_run_hw_queue
 => blk_execute_rq
 => nvme_execute_rq
 => __nvme_submit_sync_cmd
 => nvme_submit_sync_cmd
 => nvme_setup_io_queues
 => nvme_reset_work
 => process_scheduled_works
 => worker_thread
 => kthread
 => ret_from_fork
 => ret_from_fork_asm
   kworker/u40:5-302     [019]L .....   744.363417: nvme_complete_rq <-nvme_fail_nonready_command
   kworker/u40:5-302     [019]L .....   744.363418: <stack trace>
 => nvme_complete_rq
 => nvme_fail_nonready_command
 => nvme_queue_rq
 => blk_mq_dispatch_rq_list
 => __blk_mq_sched_dispatch_requests
 => blk_mq_sched_dispatch_requests
 => blk_mq_run_hw_queue
 => blk_execute_rq
 => nvme_execute_rq
 => __nvme_submit_sync_cmd
 => nvme_submit_sync_cmd
 => nvme_setup_io_queues
 => nvme_reset_work
 => process_scheduled_works
 => worker_thread
 => kthread
 => ret_from_fork
 => ret_from_fork_asm
   kworker/u40:5-302     [019]L .....   744.363418: nvme_complete_rq: nvme0: qid=0, cmdid=0, opcode=2, res=0x0, retries=0, flags=0x2, status=0x370
   kworker/u40:5-302     [019]L .....   744.363418: nvme_end_req <-nvme_complete_rq
   kworker/u40:5-302     [019]L .....   744.363419: <stack trace>
 => nvme_end_req
 => nvme_complete_rq
 => nvme_fail_nonready_command
 => nvme_queue_rq
 => blk_mq_dispatch_rq_list
 => __blk_mq_sched_dispatch_requests
 => blk_mq_sched_dispatch_requests
 => blk_mq_run_hw_queue
 => blk_execute_rq
 => nvme_execute_rq
 => __nvme_submit_sync_cmd
 => nvme_submit_sync_cmd
 => nvme_setup_io_queues
 => nvme_reset_work
 => process_scheduled_works
 => worker_thread
 => kthread
 => ret_from_fork
 => ret_from_fork_asm
   kworker/u40:5-302     [019]L .....   744.363420: nvme_error_status <-nvme_end_req
   kworker/u40:5-302     [019]L .....   744.363421: <stack trace>
 => nvme_error_status
 => nvme_end_req
 => nvme_complete_rq
 => nvme_fail_nonready_command
 => nvme_queue_rq
 => blk_mq_dispatch_rq_list
 => __blk_mq_sched_dispatch_requests
 => blk_mq_sched_dispatch_requests
 => blk_mq_run_hw_queue
 => blk_execute_rq
 => nvme_execute_rq
 => __nvme_submit_sync_cmd
 => nvme_submit_sync_cmd
 => nvme_setup_io_queues
 => nvme_reset_work
 => process_scheduled_works
 => worker_thread
 => kthread
 => ret_from_fork
 => ret_from_fork_asm
           <...>-20136   [018]L .....   744.363429: nvme_passthru_end <-nvme_submit_user_cmd
           <...>-20136   [018]L .....   744.363430: <stack trace>
 => nvme_passthru_end
 => nvme_submit_user_cmd
 => nvme_user_cmd.constprop.0
 => nvme_ctrl_ioctl
 => nvme_ioctl
 => blkdev_ioctl
 => __x64_sys_ioctl
 => x64_sys_call
 => do_syscall_64
 => entry_SYSCALL_64_after_hwframe
           <...>-20136   [018]L .....   744.363449: nvme_release <-blkdev_put_whole
           <...>-20136   [018]L .....   744.363450: <stack trace>
 => nvme_release
 => blkdev_put_whole
 => blkdev_put
 => blkdev_release
 => __fput
 => __fput_sync
 => __x64_sys_close
 => x64_sys_call
 => do_syscall_64
 => entry_SYSCALL_64_after_hwframe
           <...>-20136   [018]L .....   744.363451: nvme_ns_release <-nvme_release
           <...>-20136   [018]L .....   744.363452: <stack trace>
 => nvme_ns_release
 => nvme_release
 => blkdev_put_whole
 => blkdev_put
 => blkdev_release
 => __fput
 => __fput_sync
 => __x64_sys_close
```



