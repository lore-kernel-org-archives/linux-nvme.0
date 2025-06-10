Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53F85C61CE8
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Jun 2025 02:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Bqqb/0wgOJGsOURQSVTuhP0hc6XI2X5UfLD/+t3jP+I=; b=oXVArszqd9IT3KqSEE3tL1Qgle
	47j9M0UyCvAo9Wc94u+gt1XLiGJFjtAU8mYfKO+yVqI1VRmkOO77y7EPnzervUCto5qz1YsbPuFXA
	tohZV4QyCe5yRysbd9N8uf5g5YKQIS0T+1CDYidfC1kK2siHEGZ5clnNOQASU6/Awm/VgXvlDZb4y
	Y6btIbymk721mzAtYTp+JM+j3mY2xTswdDBkQIlsDI9HL07zK//IDeMNwcu0iDiVdvg1M4lU40D/6
	RgiHtBitGNQsEAs8wBnWM4k4mf9agfW81tdv36CvbmIf5Rm5suPJ4HBcHSSBnH/pKLflnza9Yo4Xf
	KKqYBIZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOoP8-00000005c3s-3As8;
	Tue, 10 Jun 2025 02:07:58 +0000
Received: from dggsgout12.his.huawei.com ([45.249.212.56])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOoP5-00000005c2s-0VCq
	for linux-nvme@lists.infradead.org;
	Tue, 10 Jun 2025 02:07:57 +0000
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bGXHp3FH8zKHN2h
	for <linux-nvme@lists.infradead.org>; Tue, 10 Jun 2025 10:07:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id C3CEE1A0AAD
	for <linux-nvme@lists.infradead.org>; Tue, 10 Jun 2025 10:07:48 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgAni190k0doM1EvPA--.5683S3;
	Tue, 10 Jun 2025 10:07:48 +0800 (CST)
Subject: Re: [bug report] WARNING: CPU: 3 PID: 522 at block/genhd.c:144
 bdev_count_inflight_rw+0x26e/0x410
To: Breno Leitao <leitao@debian.org>, Yi Zhang <yi.zhang@redhat.com>
Cc: linux-block <linux-block@vger.kernel.org>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 axboe@kernel.dk, "yukuai (C)" <yukuai3@huawei.com>
References: <CAHj4cs-uWZcgHLLkE8JeDpkd-ddkWiZCQC_HWObS5D3TAKE9ng@mail.gmail.com>
 <aEal7hIpLpQSMn8+@gmail.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <738f680c-d0e8-b6c0-cfaa-5f420a592c4f@huaweicloud.com>
Date: Tue, 10 Jun 2025 10:07:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <aEal7hIpLpQSMn8+@gmail.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAni190k0doM1EvPA--.5683S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCFy8CF4rWw15Ar17Jr4kXrb_yoWrGFyxpr
	WUtw4qkr48tr18JF4jyr45Za4rAayvv3W3Zrs7Wry7ZF98WFyaqFy8C3yYgrZxJr4UX3W7
	t3WDXw4Iqr1YqaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07Upyx
	iUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250609_190755_511737_DD6BBA68 
X-CRM114-Status: GOOD (  12.52  )
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

Hi,

ÔÚ 2025/06/09 17:14, Breno Leitao Ð´µÀ:
> On Fri, Jun 06, 2025 at 11:31:06AM +0800, Yi Zhang wrote:
>> Hello
>>
>> The following WARNING was triggered by blktests nvme/fc nvme/012,
>> please help check and let me know if you need any info/test, thanks.
>>
>> commit: linux-block: 38f4878b9463 (HEAD, origin/for-next) Merge branch
>> 'block-6.16' into for-next
> 
> I am seeing a similar issue on Linus' recent tree as e271ed52b344
> ("Merge tag 'pm-6.16-rc1-3' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm").
> CCing Jens.
> 
> This is my stack, in case it is useful.
> 
>             WARNING: CPU: 33 PID: 1865 at block/genhd.c:146 bdev_count_inflight_rw+0x334/0x3b0
>             Modules linked in: sch_fq(E) tls(E) act_gact(E) tcp_diag(E) inet_diag(E) cls_bpf(E) intel_uncore_frequency(E) intel_uncore_frequency_common(E) skx_edac(E) skx_edac_common(E) nfit(E) libnvdimm(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) coretemp(E) kvm_intel(E) kvm(E) mlx5_ib(E) iTCO_wdt(E) iTCO_vendor_support(E) xhci_pci(E) evdev(E) irqbypass(E) acpi_cpufreq(E) ib_uverbs(E) ipmi_si(E) i2c_i801(E) xhci_hcd(E) i2c_smbus(E) ipmi_devintf(E) wmi(E) ipmi_msghandler(E) button(E) sch_fq_codel(E) vhost_net(E) tun(E) vhost(E) vhost_iotlb(E) tap(E) mpls_gso(E) mpls_iptunnel(E) mpls_router(E) fou(E) loop(E) drm(E) backlight(E) drm_panel_orientation_quirks(E) autofs4(E) efivarfs(E)
>             CPU: 33 UID: 0 PID: 1865 Comm: kworker/u144:14 Kdump: loaded Tainted: G S          E    N  6.15.0-0_fbk701_debugnightly_rc0_upstream_12426_ge271ed52b344 #1 PREEMPT(undef)
>             Tainted: [S]=CPU_OUT_OF_SPEC, [E]=UNSIGNED_MODULE, [N]=TEST
>             Hardware name: Quanta Twin Lakes MP/Twin Lakes Passive MP, BIOS F09_3A23 12/08/2020
>             Workqueue: writeback wb_workfn (flush-btrfs-1)
>             RIP: 0010:bdev_count_inflight_rw+0x334/0x3b0
>             Code: 75 5c 41 83 3f 00 78 22 48 83 c4 40 5b 41 5c 41 5d 41 5e 41 5f 5d c3 0f 0b 41 0f b6 06 84 c0 75 54 41 c7 07 00 00 00 00 eb bb <0f> 0b 48 b8 00 00 00 00 00 fc ff df 0f b6 04 03 84 c0 75 4e 41 c7
>             RSP: 0018:ffff8882ed786f20 EFLAGS: 00010286
>             RAX: 0000000000000000 RBX: 1ffff1105daf0df3 RCX: ffffffff829739f7
>             RDX: 0000000000000024 RSI: 0000000000000024 RDI: ffffffff853f79f8
>             RBP: 0000606f9ff42610 R08: ffffe8ffffd866a7 R09: 1ffffd1ffffb0cd4
>             R10: dffffc0000000000 R11: fffff91ffffb0cd5 R12: 0000000000000024
>             R13: 1ffffffff0dd0120 R14: ffffed105daf0df3 R15: ffff8882ed786f9c
>             FS:  0000000000000000(0000) GS:ffff88905fd44000(0000) knlGS:0000000000000000
>             CR2: 00007f904bc6d008 CR3: 0000001075c2b001 CR4: 00000000007726f0
>             PKRU: 55555554
>             Call Trace:
>              <TASK>
>              bdev_count_inflight+0x28/0x50
>              update_io_ticks+0x10f/0x1b0
>              blk_account_io_start+0x3a0/0x690
>              blk_mq_submit_bio+0xc7e/0x1940

So, this is blk-mq IO accounting, a different problem than nvme mpath.

What kind of test you're running, can you reporduce ths problem? I don't
have a clue yet after a quick code review.

Thanks,
Kuai

>              __submit_bio+0x125/0x3c0
>              ? lock_release+0x4a/0x3c0
>              submit_bio_noacct_nocheck+0x3cf/0xa30
>              btree_write_cache_pages+0x5eb/0x870
>              do_writepages+0x307/0x4d0
>              ? rcu_is_watching+0xf/0xa0
>              __writeback_single_inode+0x106/0xd10
>              writeback_sb_inodes+0x53d/0xd60
>              wb_writeback+0x368/0x8d0
>              wb_workfn+0x3aa/0xcf0
>              ? rcu_is_watching+0xf/0xa0
>              ? trace_irq_enable+0x64/0x190
>              ? process_scheduled_works+0x959/0x1450
>              process_scheduled_works+0x9fe/0x1450
>              worker_thread+0x8fd/0xd10
>              kthread+0x50c/0x630
>              ? rcu_is_watching+0xf/0xa0
>              </TASK>
>             irq event stamp: 0
>             hardirqs last disabled at (0): [<ffffffff81401f85>] copy_process+0x655/0x32d0
>             softirqs last  enabled at (0): [<ffffffff81401f85>] copy_process+0x655/0x32d0
> 
> .
> 


