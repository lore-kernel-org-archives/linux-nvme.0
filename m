Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4B20C54EBC
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Jan 2023 14:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:Subject:From:References:Cc:To:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KHn0R/VoBgdRZZXGvJW+csIBEpLzve9yFtzNraGAOmA=; b=yNvblPM+eAlVaCmkvODs1tnAWj
	im4QsuMx2N5zAaSOwlmvEx1xuuWm7bQLzdW4RDGe8pJS2bABhOytjOYefPVAlc/RTeiTB7D5j2pHz
	Tl8uG2/q1ZXRXGnUgwZQzzSyKUktya50jkqsBaIjSh82Y7jl//dRlhEynfpjuD2Xe/9qS8Z4BDMBA
	1N5tjk2kcZOJpJUsXqbSfJ7BEVmk7V7KgCaVN5MsVGuZBEpLnQDfHlrGOAD1FzCX7rbgcg7Khi0ab
	WDoJ0F1mYkkYrk/GYvTs6d+gYIjZIAyBp4Hc+vnimN6yMU8+rjH7YdRzDAItHbbfZozUDcXgesudW
	84zbPItg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFyXt-00FLvs-01; Thu, 12 Jan 2023 14:27:09 +0000
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFyXo-00FLu3-VB
	for linux-nvme@lists.infradead.org; Thu, 12 Jan 2023 14:27:06 +0000
Received: by mail-ot1-x32a.google.com with SMTP id r2-20020a9d7cc2000000b006718a7f7fbaso10657625otn.2
        for <linux-nvme@lists.infradead.org>; Thu, 12 Jan 2023 06:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KHn0R/VoBgdRZZXGvJW+csIBEpLzve9yFtzNraGAOmA=;
        b=TuA3j0RTbKiPoD+0NIifbaQAQMSPBP20o6tcDBeimW5Fz1SU9iy3KgoLsT0+iAHDe1
         Z87cxz5eOE2UFYFDQvlGeR9MBTna5VUukbXNoVQ3XBMqLPBAiyaQybw+cxCgp3oCl232
         Kxcv3gjeaBTu2C1Ht4a/z7OBJlKw+xBiMq+JEALbWDdfhtzwlkUtFAm0nauIyMu+qJ1F
         m3aVTW+gVm8SBO7K2I24mPHvAVdcMYLwf7ls2Cogo52pixav/+/P25U1kxvsdMRTqkFl
         wyCL8rVrD0hJ1vTR/Vyp8aPQXgW8DKcTN6n+WgSbfF/niiJ+xd1u6ol11pu/R7hwbkye
         zXjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KHn0R/VoBgdRZZXGvJW+csIBEpLzve9yFtzNraGAOmA=;
        b=2HSZ4kt0MvshGjnsmf5DqBQ8UJLtJZA7A7jcARHnIidgRTFXt7Mol8vZPeSYztjHBV
         lXSY+QDJxoGzLsBdgahD+qBAl/JEdZL1dyRA2ZyOQib7MDcz7OFz42xUm/XDng638/Tt
         kgMUJ4xL8mciRhzPN5xM2gAK4ohRxK7tFCiSxU71J/GEklugdBeVU7Nz7MGkmCtBJv+x
         Yqfc0DeMBwxAKZrgNXMUnUirXmCSpfGYjM752en12yLCoRPkGh1ZK2DYbYEiDDeEp2WK
         tNfZ53LuI8ZtcJbXvSUJ3pMn+M8h3GYLXpH380n15FSn5k14zzRGT8dys4QHVSS/AJlE
         B0vw==
X-Gm-Message-State: AFqh2kpSRiX7Hk3V0+ZviLpKio7Cd8rHqaQrg3SO9sJAXGR3sjuluIL+
	u3Bl/69i1vu2o1GCtwkXfiw=
X-Google-Smtp-Source: AMrXdXv59qMv101vL3nhNReRXmOvurbTwEVzJCY1gxJGCbnPy1iiiRoxWP2YEtdjmxtSO59XjezMdQ==
X-Received: by 2002:a9d:187:0:b0:666:e1b0:8ecb with SMTP id e7-20020a9d0187000000b00666e1b08ecbmr37881512ote.29.1673533622059;
        Thu, 12 Jan 2023 06:27:02 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s40-20020a05683043a800b00684bc23f2cfsm1911721otv.32.2023.01.12.06.27.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 06:27:01 -0800 (PST)
Message-ID: <276fc1fd-87f8-e459-c9dc-8e4cf26a9f86@roeck-us.net>
Date: Thu, 12 Jan 2023 06:26:59 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To: Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <Y8AG21o/9/3eUMIg@cormorant.local>
From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: completion timeouts with pin-based interrupts in QEMU hw/nvme
In-Reply-To: <Y8AG21o/9/3eUMIg@cormorant.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230112_062705_036682_D76F5152 
X-CRM114-Status: GOOD (  33.87  )
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

On 1/12/23 05:10, Klaus Jensen wrote:
> Hi all (linux-nvme, qemu-devel, maintainers),
> 
> On QEMU riscv64, which does not use MSI/MSI-X and thus relies on
> pin-based interrupts, I'm seeing occasional completion timeouts, i.e.
> 
>    nvme nvme0: I/O 333 QID 1 timeout, completion polled
> 
> To rule out issues with shadow doorbells (which have been a source of
> frustration in the past), those are disabled. FWIW I'm also seeing the
> issue with shadow doorbells.
> 
> 	diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> 	index f25cc2c235e9..28d8e7f4b56c 100644
> 	--- a/hw/nvme/ctrl.c
> 	+++ b/hw/nvme/ctrl.c
> 	@@ -7407,7 +7407,7 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
> 	     id->mdts = n->params.mdts;
> 	     id->ver = cpu_to_le32(NVME_SPEC_VER);
> 	     id->oacs =
> 	-        cpu_to_le16(NVME_OACS_NS_MGMT | NVME_OACS_FORMAT | NVME_OACS_DBBUF);
> 	+        cpu_to_le16(NVME_OACS_NS_MGMT | NVME_OACS_FORMAT);
> 	     id->cntrltype = 0x1;
> 
> 	     /*
> 
> 
> I captured a trace from QEMU when this happens:
> 
> pci_nvme_mmio_write addr 0x1008 data 0x4e size 4
> pci_nvme_mmio_doorbell_sq sqid 1 new_tail 78
> pci_nvme_io_cmd cid 4428 nsid 0x1 sqid 1 opc 0x2 opname 'NVME_NVM_CMD_READ'
> pci_nvme_read cid 4428 nsid 1 nlb 32 count 16384 lba 0x1324
> pci_nvme_map_prp trans_len 4096 len 16384 prp1 0x80aca000 prp2 0x82474100 num_prps 5
> pci_nvme_map_addr addr 0x80aca000 len 4096
> pci_nvme_map_addr addr 0x80ac9000 len 4096
> pci_nvme_map_addr addr 0x80ac8000 len 4096
> pci_nvme_map_addr addr 0x80ac7000 len 4096
> pci_nvme_io_cmd cid 4429 nsid 0x1 sqid 1 opc 0x2 opname 'NVME_NVM_CMD_READ'
> pci_nvme_read cid 4429 nsid 1 nlb 224 count 114688 lba 0x1242
> pci_nvme_map_prp trans_len 4096 len 114688 prp1 0x80ae6000 prp2 0x82474000 num_prps 29
> pci_nvme_map_addr addr 0x80ae6000 len 4096
> pci_nvme_map_addr addr 0x80ae5000 len 4096
> pci_nvme_map_addr addr 0x80ae4000 len 4096
> pci_nvme_map_addr addr 0x80ae3000 len 4096
> pci_nvme_map_addr addr 0x80ae2000 len 4096
> pci_nvme_map_addr addr 0x80ae1000 len 4096
> pci_nvme_map_addr addr 0x80ae0000 len 4096
> pci_nvme_map_addr addr 0x80adf000 len 4096
> pci_nvme_map_addr addr 0x80ade000 len 4096
> pci_nvme_map_addr addr 0x80add000 len 4096
> pci_nvme_map_addr addr 0x80adc000 len 4096
> pci_nvme_map_addr addr 0x80adb000 len 4096
> pci_nvme_map_addr addr 0x80ada000 len 4096
> pci_nvme_map_addr addr 0x80ad9000 len 4096
> pci_nvme_map_addr addr 0x80ad8000 len 4096
> pci_nvme_map_addr addr 0x80ad7000 len 4096
> pci_nvme_map_addr addr 0x80ad6000 len 4096
> pci_nvme_map_addr addr 0x80ad5000 len 4096
> pci_nvme_map_addr addr 0x80ad4000 len 4096
> pci_nvme_map_addr addr 0x80ad3000 len 4096
> pci_nvme_map_addr addr 0x80ad2000 len 4096
> pci_nvme_map_addr addr 0x80ad1000 len 4096
> pci_nvme_map_addr addr 0x80ad0000 len 4096
> pci_nvme_map_addr addr 0x80acf000 len 4096
> pci_nvme_map_addr addr 0x80ace000 len 4096
> pci_nvme_map_addr addr 0x80acd000 len 4096
> pci_nvme_map_addr addr 0x80acc000 len 4096
> pci_nvme_map_addr addr 0x80acb000 len 4096
> pci_nvme_rw_cb cid 4428 blk 'd0'
> pci_nvme_rw_complete_cb cid 4428 blk 'd0'
> pci_nvme_enqueue_req_completion cid 4428 cqid 1 dw0 0x0 dw1 0x0 status 0x0
> [1]: pci_nvme_irq_pin pulsing IRQ pin
> pci_nvme_rw_cb cid 4429 blk 'd0'
> pci_nvme_rw_complete_cb cid 4429 blk 'd0'
> pci_nvme_enqueue_req_completion cid 4429 cqid 1 dw0 0x0 dw1 0x0 status 0x0
> [2]: pci_nvme_irq_pin pulsing IRQ pin
> [3]: pci_nvme_mmio_write addr 0x100c data 0x4d size 4
> [4]: pci_nvme_mmio_doorbell_cq cqid 1 new_head 77
> ---- TIMEOUT HERE (30s) ---
> [5]: pci_nvme_mmio_read addr 0x1c size 4
> [6]: pci_nvme_mmio_write addr 0x100c data 0x4e size 4
> [7]: pci_nvme_mmio_doorbell_cq cqid 1 new_head 78
> --- Interrupt deasserted (cq->tail == cq->head)
> [   31.757821] nvme nvme0: I/O 333 QID 1 timeout, completion polled
> 
> Following the timeout, everything returns to "normal" and device/driver
> happily continues.
> 
> The pin-based interrupt logic in hw/nvme seems sound enough to me, so I
> am wondering if there is something going on with the kernel driver (but
> I certainly do not rule out that hw/nvme is at fault here, since
> pin-based interrupts has also been a source of several issues in the
> past).
> 
> What I'm thinking is that following the interrupt in [1], the driver
> picks up completion for cid 4428 but does not find cid 4429 in the queue
> since it has not been posted yet. Before getting a cq head doorbell
> write (which would cause the pin to be deasserted), the device posts the
> completion for cid 4429 which just keeps the interrupt asserted in [2].
> The trace then shows the cq head doorbell update in [3,4] for cid 4428
> and then we hit the timeout since the driver is not aware that cid 4429
> has been posted in between this (why is it not aware of this?) Timing
> out, the driver then polls the queue and notices cid 4429 and updates
> the cq head doorbell in [5-7], causing the device to deassert the
> interrupt and we are "back in shape".
> 
> I'm observing this on 6.0 kernels and v6.2-rc3 (have not tested <6.0).
> Tested on QEMU v7.0.0 (to rule out all the shadow doorbell
> optimizations) as well as QEMU nvme-next (infradead). In other words,
> it's not a recent regression in either project and potentially it has
> always been like this. I've not tested other platforms for now, but I
> would assume others using pin-based interrupts would observe the same.
> 
> Any ideas on how to shed any light on this issue from the kernel side of
> things?


I have no idea what causes the problem, but I have seen this forever
in my testing. I have seen it with various architectures. Some architectures
are affected more than others. For example, I don't test nvme boots on mips
platforms because the problem is quite notorious there.

Guenter


