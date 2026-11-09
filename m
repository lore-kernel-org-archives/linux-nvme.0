Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF1F606A31C
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 19:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=BAythObg;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=bwIR6F2w
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=zJy9Suk4ayq50Ayby3ChgQJYB8bJU6C5/4/gEq399Pk=; b=BAythObggmTPfK5hloRdtJU8iR
	nYqoA7ZtmoJ/nMavmz1Uua0HWK9LaqWE5jY1kRkT7R3qI8yYMiJzRRB+G0r19xPRrbYb7COMChFWb
	AIgIRYBi6AUBxLyg5urUggDvmfSL99TA0ZCaXnESz0EprwBeAoqtU0FpG0OfIc7j21FnZ39/U30un
	gcVqg6fvcY2mNCko+DG0joSg5HAk8rIRoOfc2TKACtqZXqJ7PZIDPXlL9Q1AAtcleZdqfnfEx/ZMk
	dgVz9IOM36H1hqu2WpweUyecZghw3fZCZvFUE9lX0ysL+7ECrbjZV8GvTY8nQDqGfvE393OnFc5Pn
	z4IbEODQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQUjm-00000001WIf-3LLV;
	Mon, 09 Nov 2026 19:09:02 +0000
Received: from mail-dy1-x132b.google.com ([2607:f8b0:4864:20::132b])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQUjj-00000001WI6-0i8G
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 19:09:00 +0000
Received: by mail-dy1-x132b.google.com with SMTP id 5a478bee46e88-36ff9c9da34so2090576eec.1
        for <linux-nvme@lists.infradead.org>; Mon, 09 Nov 2026 11:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1794251337; x=1794856137; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zJy9Suk4ayq50Ayby3ChgQJYB8bJU6C5/4/gEq399Pk=;
        b=bwIR6F2wjhoZiTrXr6O1pCBIru9KXw4+feSDTkEgxplUb1kQwgv9tqqeaRCckWJbdT
         tmn5jX9qBcgRHfe4fbqXG0pOHeMj2gGd90ATuYdN9cuDa+ap+ORreq+e5VivUaTGyKUz
         0uBJ676SWxcL6Cfe8e0t8CL7B9o6PxBC2IxZ50n4HIfAX4lIJ5BYCIks9gL4bFgeJ/Y2
         VmL0CdjMW2lA8MnSkV9R35VTg8Z2ObwmXnjKGANmwhf82LgwarnnYby6xXjjgRe9wgoZ
         UbQsoXUDun6m8IGNJOSwxghAIWIyIGUKHNfEgdEE5zPQgD4MVn9HlIJrwGyjUH/gS5Lm
         QvqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794251337; x=1794856137;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zJy9Suk4ayq50Ayby3ChgQJYB8bJU6C5/4/gEq399Pk=;
        b=Nq80zQEyl/mImc9MXFWg3YVt1NixhIIJpKFfJROCv6OBSI286lmqtjM2rY3mD9NKxN
         1eEvuPv3MvwsjF1sgwUsalp9rAxQk2MFvcBvlMK4wug7JS6ujDyhMhmau8EigTkEBu+V
         zHSkhzPuepkBZ0vZNPkuGNyjIFYthpVM7zidsLLNzUvbux4ae+wbG1bcYCmyasfa++lt
         9ZaJ7yNnQjaMg/Jr28dOJp/zMDSwl0a7zjGjyCzGpGL4nyRKQMSOa8pTwik9kX7/Nwcv
         8WL5uNGGnYdksK4Q9CecceHp0cyTAqO24HmCVpaRmnrCxP6Az5Q9lpZg0eYbkZXYaTD0
         6xrg==
X-Forwarded-Encrypted: i=1; AL+hErGhArffziQu8zdHLfqLzO676t/+knHUIsKzUfilP85uKbqkUiIhDgz5fbzb8rJ4Rah5/pYGZh8Nbu+H@lists.infradead.org
X-Gm-Message-State: APuU4Z//4GGz5Q3IBYe5hcyUe4NavKG3rzupygICWyL8hjN/1TAe5+JW
	1p9NgvHed4FWSXdGM1bvEE1hCJ86eVOtCYAtgI2p7V2gVaowd7qssefgoVLvmY08dzE=
X-Gm-Gg: AYBFou3nNvk0p8wfzoQd6VCGEDGiceee+6wJosg8LwKrwbxPdzsXesOxzO0HPrY+iir
	5WS7IvtVmB2gFNCAtpx6agrqceDPDIAQA8RUpkJEFD2r4/F7S1nfFcYtVNF30ssRkdymLC69SM1
	rxXzjXQidGzjWchog2/+Ftp/bhhi+T2H2k3Tkj1laSrkxeoxhJCIeT1uK6MScYwsnQSSvQSPTJI
	WIfSVnwvTTkrIhG3wUnwoaxpY9TKgOSGwM7Szf27IJmxSDXHC5CBxAbMGkKbJsA1RQqJD8XEEZV
	KbAKmgJOi+b23los+ZtorVGqghWS2n9x+tZtyqijAT7IwbKciLDYLnCKwx0useYs62gyPxPJ+OS
	11VDy+AlSgYegsh6FpGgzQ/StC2ONd0VlVW1t+eMTWBfSixG/heBnK9otHt/k4BBabLfjetAJId
	ePZGhfxWKdxe37BaKj17luIoVifbeDA6iN6mLAGavMhiEPktjXjBM22sxrp42WyHF1bwuLXN3pw
	x4BPie3lzgZmh6CDE9zp2W9Rtw0Xp4ydD5ZijHAmqwJnH53hurKYVCw0dsh/pKeMSntS15Jayl+
	1iEQ1rFsYn/VoAj+U/uI0EzFMi1uAMn9t1PP0v4aRQIkuRBZ
X-Received: by 2002:a05:7301:9a91:b0:374:ba43:ae2e with SMTP id 5a478bee46e88-3751ee74826mr222496eec.14.1794251336486;
        Mon, 09 Nov 2026 11:08:56 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-375212e9e03sm510989eec.23.2026.11.09.11.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 11:08:55 -0800 (PST)
Date: Mon, 9 Nov 2026 11:08:54 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: zhang san <shunsheng1218@gmail.com>
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: Question: NVMe AER completion delivery during controller removal
Message-ID: <20261109190854.GA765534-mkhalfella@purestorage.com>
References: <CAGTEBTa9dGn8TjKxRPsfeCFiRYAt-cGMAp-XSLBS86SHB6FJ_A@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGTEBTa9dGn8TjKxRPsfeCFiRYAt-cGMAp-XSLBS86SHB6FJ_A@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261109_110859_221922_C9E11D40 
X-CRM114-Status: GOOD (  19.74  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed 2026-11-04 12:50:42 +0800, zhang san wrote:
> Hello,
> 
> We are seeking clarification about asynchronous event request (AER)
> completion behavior during NVMe controller removal, before treating an
> observed test failure as a production-reachable driver bug.
> 
> Our source analysis suggests a possible lifetime race between the AEN
> completion path, which can requeue nvme_async_event_work, and the
> controller removal path. We observed KASAN use-after-free in an
> emulated environment on Linux v7.4-rc1 (6628e7d4c6b2).


My reading of the code suggests this can happen. nvme_stop_ctrl()
flushes async_event_work, but the admin queue can still deliver an AER
completion afterwards, either from the admin queue interrupt handler or
from the final admin CQ poll in nvme_dev_disable():

nvme_remove() ->
  nvme_dev_disable() ->
    nvme_poll_irqdisable(&dev->queues[0]) ->
      nvme_poll_cq() ->
        nvme_handle_cqe() ->
          nvme_complete_async_event() ->
	    queue_work(nvme_wq, &ctrl->async_event_work);


Nothing flushes async_event_work after that, so the work can run after
nvme_uninit_ctrl() drops the last reference and the nvme_dev is freed.

> 
> However, our test induced an ERROR AEN through an out-of-specification
> MMIO doorbell write while the device was being removed. This
> deliberately synthetic trigger does not establish that a compliant
> controller would generate the same completion.

--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3909,20 +3909,21 @@ static void nvme_remove(struct pci_dev *pdev)

        if (!pci_device_is_present(pdev)) {
                nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DEAD);
                nvme_dev_disable(dev, true);
        }

        flush_work(&dev->ctrl.reset_work);
        nvme_stop_ctrl(&dev->ctrl);
        nvme_remove_namespaces(&dev->ctrl);
        nvme_dev_disable(dev, true);
+       flush_work(&dev->ctrl.async_event_work);
        nvme_free_host_mem(dev);
        nvme_dev_remove_admin(dev);
        nvme_dbbuf_dma_free(dev);
        nvme_free_queues(dev, 0);
        mempool_destroy(dev->dmavec_mempool);
        nvme_release_descriptor_pools(dev);
        nvme_dev_unmap(dev);
        nvme_uninit_ctrl(&dev->ctrl);
 }

Since you are able to reproduce this issue reliabely, how about you try
the diff above and see if it fixes the issue.

> 
> Our main question is: can a specification-compliant controller deliver
> a completion for a previously submitted AER during the interval in
> which the host is disabling the controller and tearing down the admin
> queue, or must such completions be quiesced before disable completes?
> We would also welcome guidance on the exact point after which the host
> may safely assume that no further AER completions can be delivered.

If the above diff fixes the issue for you, then I think this is a driver
bug.

