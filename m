Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E3C9C07E97
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Nov 2023 09:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NbUOW+EsHL3mG5VoxBgIYnWYJjPiLMR6J06zMpRjSzM=; b=OmFLbxjl2AzJ1LZcvBnMFeezPV
	U3dXdHcserf7C/tKsnGI5bE5qNqW2lIRoefYqbzlZ4uGvyEObLCMaAkVLToPowm7t3IY1V88okpw5
	nLfVqLsXFwbOD+C+ZQruPmmqBjuQTb0IIiIm8q1S/JuOcYxC0DFNRXCTp6S95X4srggHPa6S8VtL3
	f79mFgfFvZU8F0Ar4i67N01WkMri9bmONXvDzw1wLW0GB6z/GG/SDMJvUJbAosP+FwXIKRHYOMn4J
	Vl/uKc0p1o6hBRhR1vxKoodV5sI0Wg0VfSgkaRp9ipkGf14YvTpuq9LacX4JR1yLuoEHeOCVd2S9O
	Msf4gwkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r8Gnt-007cox-0B;
	Wed, 29 Nov 2023 09:24:21 +0000
Received: from out30-99.freemail.mail.aliyun.com ([115.124.30.99])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r8Gnp-007co0-39
	for linux-nvme@lists.infradead.org;
	Wed, 29 Nov 2023 09:24:19 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=yaoma@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VxNaj96_1701249851;
Received: from 30.178.67.199(mailfrom:yaoma@linux.alibaba.com fp:SMTPD_---0VxNaj96_1701249851)
          by smtp.aliyun-inc.com;
          Wed, 29 Nov 2023 17:24:12 +0800
Message-ID: <7a1a6a34-019a-3ecc-3aee-1a92d29eb6e9@linux.alibaba.com>
Date: Wed, 29 Nov 2023 17:24:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
From: yaoma <yaoma@linux.alibaba.com>
Subject: Re: [PATCH] nvme: fix deadlock between reset and scan
To: Sagi Grimberg <sagi@grimberg.me>
Cc: axboe@kernel.dk, hch@lst.de, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, kanie@linux.alibaba.com,
 Keith Busch <kbusch@kernel.org>, yaoma@linux.alibaba.com
References: <1700737213-110685-1-git-send-email-yaoma@linux.alibaba.com>
 <ZWTa0DJmcLKHRWWC@kbusch-mbp.dhcp.thefacebook.com>
 <65b0c372-b308-46dd-c2f2-a5ddb50adb10@linux.alibaba.com>
 <c47a0edd-7437-4c21-b7cf-f969ff85bf78@grimberg.me>
Content-Language: en-US
In-Reply-To: <c47a0edd-7437-4c21-b7cf-f969ff85bf78@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231129_012418_174183_DBE1A66D 
X-CRM114-Status: GOOD (  21.21  )
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

Hi, Sagi Grimberg

I revised my code following your advice and carried out tests.

Test Scripts:
	for ((t=1;t<=128;t++))
	do
     	nsid=`nvme create-ns /dev/nvme0 -s 1453772 -c 1453772 -f 0\
	-m 0 -d 0 | awk -F:  '{print($NF);}'`
     	nvme attach-ns /dev/nvme0 -n $nsid -c 0
	done

	echo "resetting"
	nvme reset /dev/nvme0
	lsblk | grep nvme0 | wc -l
	sleep 2
	lsblk | grep nvme0 | wc -l

Results:
	...
	attach-ns: Success, nsid:128
	resetting
	23
	128

After the fix, we will not be deadlocked.

I find a minor issue. In the resetting state, the scan may not recognize 
all ns, but since a scan work is queued at the end of reset, so the 
impact is not significant. After the reset is completed, all ns can 
eventually be recognized.

---
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 21783aa2e..e361aba39 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3630,6 +3630,10 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, 
struct nvme_ns_info *info)
                 goto out_unlink_ns;

         down_write(&ctrl->namespaces_rwsem);
+       if (test_bit(NVME_CTRL_FROZEN, &ctrl->flags)) {
+               up_write(&ctrl->namespaces_rwsem);
+               goto out_unlink_ns;
+       }
         nvme_ns_add_to_ctrl_list(ns);
         up_write(&ctrl->namespaces_rwsem);
         nvme_get_ctrl(ctrl);
@@ -4539,6 +4543,7 @@ void nvme_unfreeze(struct nvme_ctrl *ctrl)
         list_for_each_entry(ns, &ctrl->namespaces, list)
                 blk_mq_unfreeze_queue(ns->queue);
         up_read(&ctrl->namespaces_rwsem);
+       clear_bit(NVME_CTRL_FROZEN, &ctrl->flags);
  }
  EXPORT_SYMBOL_GPL(nvme_unfreeze);

@@ -4572,6 +4577,7 @@ void nvme_start_freeze(struct nvme_ctrl *ctrl)
  {
         struct nvme_ns *ns;

+       set_bit(NVME_CTRL_FROZEN, &ctrl->flags);
         down_read(&ctrl->namespaces_rwsem);
         list_for_each_entry(ns, &ctrl->namespaces, list)
                 blk_freeze_queue_start(ns->queue);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index f35647c47..755319b0d 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -251,6 +251,7 @@ enum nvme_ctrl_flags {
         NVME_CTRL_STOPPED               = 3,
         NVME_CTRL_SKIP_ID_CNS_CS        = 4,
         NVME_CTRL_DIRTY_CAPABILITY      = 5,
+       NVME_CTRL_FROZEN                = 6,
  };

  struct nvme_ctrl {
--

On 2023/11/28 18:13, Sagi Grimberg wrote:
> 
> 
> On 11/28/23 08:22, yaoma wrote:
>> Hi Keith Busch
>>
>> Thanks for your reply.
>>
>> The idea to avoid such a deadlock between nvme_reset and nvme_scan is 
>> to ensure that no namespace can be added to ctrl->namespaces after 
>> nvme_start_freeze has already been called. We can achieve this goal by 
>> assessing the ctrl->state after we have already acquired the 
>> ctrl->namespaces_rwsem lock, to decide whether to add the namespace to 
>> the list or not.
>> 1. After we determine that ctrl->state is LIVE, it may be immediately 
>> changed to another state. However, since we have already acquired the 
>> lock, other tasks cannot access ctrl->namespace, so we can still 
>> safely add the namespace to the list. After acquiring the lock, 
>> nvme_start_freeze will freeze all ns->q in the list, including any 
>> newly added namespaces.
>> 2. Before the completion of nvme_reset, ctrl->state will not be 
>> changed to LIVE, so we will not add any more namespaces to the list. 
>> All ns->q in the list is frozen, so nvme_wait_freeze can exit normally.
> 
> I agree with the analysis, there is a hole between start_freeze and
> freeze_wait that a scan may add a ns to the ctrl ns list.
> 
> However the fix should be to mark the ctrl with say NVME_CTRL_FROZEN
> flag set in nvme_freeze_start and cleared in nvme_unfreeze (similar
> to what we did with quiesce). Then the scan can check it before adding
> the new namespace (under the namespaces_rwsem).

